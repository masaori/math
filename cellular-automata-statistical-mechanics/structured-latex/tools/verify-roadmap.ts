#!/usr/bin/env node
/**
 * 研究の段取り（`../research-roadmap.ts`）が、記録だけの飾りになっていないことを検査する。
 *
 * 段取りは「どこまでを射程に置き、いまどこに居て、何をもって完了とするか」を固定するために在る。
 * したがって次の性質が壊れた段取りは、書いてあること自体が誤りになる。
 *
 *   - 段階の id と表示名が一意である。
 *   - 依存先が実在し、依存関係が有向非巡回である（先に済ませられない順序を書かない）。
 *   - 現在地がちょうど一つである。
 *   - 到達済み・進行中の段階は、依存先が未着手でない（追い越した進捗を書かない）。
 *   - 完了条件が段階ごとに一つ以上あり、段階をまたいで重複しない（写した空文を置かない）。
 *   - 到達済み・進行中の段階は根拠を一つ以上持ち、その根拠が実在する
 *     （本文のラベルは `content/` に、パスはディスクに）。
 *   - 入口である初等セルオートマトンの段階が、射程の全体を名乗っていない
 *     （他の段階がその段階だけに依存して終わっていないこと、すなわち後続が存在すること）。
 *
 * 実在の検査だけは fs と `content/` を読むので、型では書けない。
 */

import { existsSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

import { roadmapPreamble, roadmapStages, roadmapTitle, type RoadmapStage } from "../research-roadmap.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

void dirname(fileURLToPath(import.meta.url));
const projectDir = join(structuredLatexDir, "..");

/**
 * `as const satisfies` で書かれた正本は、配列長や依存先 id まで型に固定されている。
 * 検査側でその狭い型のまま扱うと「長さ 0 との比較は無意味」と型検査に拒まれ、
 * 空の段取りを検出する検査そのものが書けなくなる。検査は広い型の上で行う。
 */
const stages: readonly RoadmapStage[] = roadmapStages;
const preamble: readonly string[] = roadmapPreamble;

const violations: string[] = [];
const fail = (message: string): void => {
  violations.push(message);
};

// --- 一意性 ------------------------------------------------------------------

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

if (roadmapTitle.trim() === "") fail("段取りの表題が空である");
if (preamble.length === 0) fail("段取りの前置きが無い");

// --- 依存関係 ----------------------------------------------------------------

for (const stage of stages) {
  for (const dependency of stage.dependsOn) {
    if (!byId.has(dependency)) fail(`存在しない段階へ依存している: ${stage.id} -> ${dependency}`);
    if (dependency === stage.id) fail(`段階が自分自身へ依存している: ${stage.id}`);
  }
  if (new Set(stage.dependsOn).size !== stage.dependsOn.length) {
    fail(`依存先が重複している: ${stage.id}`);
  }
}

/** 深さ優先で巡回を探す。巡回があれば、先に済ませられない順序を書いたことになる。 */
const visitState = new Map<string, "visiting" | "done">();
const findCycle = (id: string, path: string[]): void => {
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

// --- 現在地と進捗の整合 ------------------------------------------------------

const currents = stages.filter((stage) => stage.current);
if (currents.length !== 1) {
  fail(`現在地はちょうど一つでなければならない: ${currents.map((stage) => stage.id).join(", ") || "無し"}`);
}

const startedStatuses = new Set(["到達済み", "進行中"]);
for (const stage of stages) {
  if (!startedStatuses.has(stage.status)) continue;
  for (const dependency of stage.dependsOn) {
    const upstream = byId.get(dependency);
    if (upstream !== undefined && upstream.status === "未着手") {
      fail(`依存先が未着手なのに先へ進んでいる: ${stage.id}（依存先 ${dependency}）`);
    }
  }
}

// --- 完了条件 ----------------------------------------------------------------

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

// --- 根拠の実在 --------------------------------------------------------------

const contentFiles = await loadContentFiles();
const labels = new Set<string>();
for (const file of contentFiles) {
  for (const block of file.blocks) {
    for (const label of block.labels) labels.add(label);
  }
}

let checkedEvidence = 0;
for (const stage of stages) {
  if (startedStatuses.has(stage.status) && stage.evidence.length === 0) {
    fail(`到達済みまたは進行中なのに根拠が無い: ${stage.id}`);
  }
  for (const item of stage.evidence) {
    checkedEvidence += 1;
    if (item.why.trim() === "") fail(`根拠の説明が空である: ${stage.id}`);
    if (item.kind === "label") {
      if (!labels.has(item.label)) fail(`本文に存在しないラベルを根拠にしている: ${stage.id} -> ${item.label}`);
    } else if (!existsSync(join(projectDir, item.path))) {
      fail(`存在しないパスを根拠にしている: ${stage.id} -> ${item.path}`);
    }
  }
}

// --- 入口が射程を名乗っていないこと ------------------------------------------

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

// --- 報告 --------------------------------------------------------------------

if (violations.length > 0) {
  console.error(`研究の段取りに違反がある（${violations.length} 件）:`);
  for (const violation of violations) console.error(`  - ${violation}`);
  process.exit(1);
}

console.log(
  `研究の段取りを検査した: 段階 ${stages.length} 件、` +
    `依存 ${stages.reduce((sum, stage) => sum + stage.dependsOn.length, 0)} 件、` +
    `完了条件 ${seenCompletion.size} 件、根拠 ${checkedEvidence} 件、現在地 ${currents.length} 件`,
);
