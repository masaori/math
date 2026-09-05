/**
 * 研究の段取り（`../research-roadmap.ts`）が満たすべき規則を、正本のデータから切り離した形で持つ。
 *
 * 切り離す理由は、規則そのものへ回帰検査を掛けられるようにするためである。正本を直接読む検査は、
 * 正本がたまたま規則を満たしている限り、規則の側が壊れても静かに通ってしまう
 * （実際、現在地と進捗の整合の二つの穴がその形で残っていた）。ここを純関数にしておけば、
 * 合成した段取りを与えて「落ちるべきものが落ちること」を確かめられる。
 *
 * 実在の検査（本文のラベル・ディスク上のパス）だけは呼び出し側から解決子を受け取る。
 */

import type { Evidence, RoadmapStage } from "../research-roadmap.ts";

export type RoadmapResolvers = {
  /** 本文（`content/`）に実在するラベルか。 */
  readonly hasLabel: (label: string) => boolean;
  /** プロジェクトルートからの相対パスが実在するか。 */
  readonly hasPath: (path: string) => boolean;
};

export type RoadmapInput = {
  readonly title: string;
  readonly preamble: readonly string[];
  readonly stages: readonly RoadmapStage[];
};

export type RoadmapReport = {
  readonly violations: readonly string[];
  readonly completionCount: number;
  readonly evidenceCount: number;
  readonly currentCount: number;
  readonly dependencyCount: number;
};

const startedStatuses = new Set<RoadmapStage["status"]>(["到達済み", "進行中"]);

const evidenceExists = (item: Evidence, resolvers: RoadmapResolvers): boolean =>
  item.kind === "label" ? resolvers.hasLabel(item.label) : resolvers.hasPath(item.path);

export const inspectRoadmap = (input: RoadmapInput, resolvers: RoadmapResolvers): RoadmapReport => {
  const { title, preamble, stages } = input;
  const violations: string[] = [];
  const fail = (message: string): void => {
    violations.push(message);
  };

  // --- 一意性 ----------------------------------------------------------------

  const byId = new Map<string, RoadmapStage>();
  const seenTitles = new Set<string>();
  for (const stage of stages) {
    if (byId.has(stage.id)) fail(`段階の id が重複している: ${stage.id}`);
    byId.set(stage.id, stage);
    if (seenTitles.has(stage.title)) fail(`段階の表示名が重複している: ${stage.title}`);
    seenTitles.add(stage.title);
    if (stage.title.trim() === "") fail(`段階の表示名が空である: ${stage.id}`);
    if (stage.scope.trim() === "") fail(`段階の範囲が空である: ${stage.id}`);
    if (stage.habitat.trim() === "") fail(`段階の量の住処が空である: ${stage.id}`);
  }

  if (title.trim() === "") fail("段取りの表題が空である");
  if (preamble.length === 0) fail("段取りの前置きが無い");

  // --- 依存関係 --------------------------------------------------------------

  for (const stage of stages) {
    for (const dependency of stage.dependsOn) {
      if (!byId.has(dependency)) fail(`存在しない段階へ依存している: ${stage.id} -> ${dependency}`);
      if (dependency === stage.id) fail(`段階が自分自身へ依存している: ${stage.id}`);
    }
    if (new Set(stage.dependsOn).size !== stage.dependsOn.length) {
      fail(`依存先が重複している: ${stage.id}`);
    }
  }

  const visitState = new Map<string, "visiting" | "done">();
  const findCycle = (id: string, path: readonly string[]): void => {
    const state = visitState.get(id);
    if (state === "done") return;
    if (state === "visiting") {
      fail(`依存関係に巡回がある: ${[...path, id].join(" -> ")}`);
      return;
    }
    visitState.set(id, "visiting");
    for (const dependency of byId.get(id)?.dependsOn ?? []) findCycle(dependency, [...path, id]);
    visitState.set(id, "done");
  };
  for (const stage of stages) findCycle(stage.id, []);

  // --- 現在地と進捗の整合 ----------------------------------------------------

  const currents = stages.filter((stage) => stage.current);
  if (currents.length !== 1) {
    fail(`現在地はちょうど一つでなければならない: ${currents.map((stage) => stage.id).join(", ") || "無し"}`);
  }
  /**
   * 現在地は「いま手を動かしている段階」である。未着手の段階を現在地と書けば、着手していない
   * ものを現在地と称することになり、到達済みの段階を現在地と書けば、進行中の作業が段取りの
   * どこにも現れなくなる。どちらも段取りが現在地を指せていない。
   */
  for (const stage of currents) {
    if (stage.status !== "進行中") {
      fail(`現在地なのに進行中ではない: ${stage.id}（${stage.status}）`);
    }
  }

  /** `dependsOn` は「先に済んでいる必要がある段階」なので、着手済みの段階の依存先は到達済みに限る。 */
  for (const stage of stages) {
    if (!startedStatuses.has(stage.status)) continue;
    for (const dependency of stage.dependsOn) {
      const upstream = byId.get(dependency);
      if (upstream === undefined) continue;
      if (upstream.status !== "到達済み") {
        fail(
          `先に済んでいる必要がある依存先が到達済みでない: ${stage.id}（${stage.status}）` +
            ` -> ${dependency}（${upstream.status}）`,
        );
      }
    }
  }

  // --- 完了条件 --------------------------------------------------------------

  const seenCompletion = new Map<string, string>();
  for (const stage of stages) {
    if (stage.completion.length === 0) fail(`完了条件が無い: ${stage.id}`);
    for (const item of stage.completion) {
      if (item.trim() === "") fail(`空の完了条件がある: ${stage.id}`);
      const owner = seenCompletion.get(item);
      if (owner !== undefined) fail(`完了条件が段階をまたいで重複している: ${owner} と ${stage.id}`);
      seenCompletion.set(item, stage.id);
    }
  }

  // --- 根拠の実在 ------------------------------------------------------------

  let evidenceCount = 0;
  for (const stage of stages) {
    if (startedStatuses.has(stage.status) && stage.evidence.length === 0) {
      fail(`到達済みまたは進行中なのに根拠が無い: ${stage.id}`);
    }
    for (const item of stage.evidence) {
      evidenceCount += 1;
      if (item.why.trim() === "") fail(`根拠の説明が空である: ${stage.id}`);
      if (evidenceExists(item, resolvers)) continue;
      if (item.kind === "label") {
        fail(`本文に存在しないラベルを根拠にしている: ${stage.id} -> ${item.label}`);
      } else {
        fail(`存在しないパスを根拠にしている: ${stage.id} -> ${item.path}`);
      }
    }
  }

  // --- 入口が射程を名乗っていないこと ----------------------------------------

  const entryStage = byId.get("elementary_ca_finite_calibration");
  if (entryStage === undefined) {
    fail("初等セルオートマトンの校正段階が段取りに無い（入口を落としている）");
  } else {
    const successors = stages.filter((stage) => stage.dependsOn.includes(entryStage.id));
    if (successors.length === 0) {
      fail("初等セルオートマトンの段階に後続が無い（入口が射程の全体になっている）");
    }
    const broaderStages = stages.filter((stage) => stage.id !== entryStage.id);
    if (broaderStages.length < 4) {
      fail("初等セルオートマトン以外の段階が少なすぎる（舞台と規則クラスの二軸を覆っていない）");
    }
  }

  return {
    violations,
    completionCount: seenCompletion.size,
    evidenceCount,
    currentCount: currents.length,
    dependencyCount: stages.reduce((sum, stage) => sum + stage.dependsOn.length, 0),
  };
};
