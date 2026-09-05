#!/usr/bin/env node
/**
 * 研究の段取りの規則（`roadmap-rules.ts`）に、実際に検査が掛かることを確かめる。
 *
 * 正本を直接読む検査だけでは、正本がたまたま規則を満たしている間、規則の側が壊れても静かに
 * 通ってしまう。ここでは合成した段取りを与え、落ちるべきものが落ち、通るべきものが通ることを
 * 両方向で確かめる。
 */

import type { RoadmapStage } from "../research-roadmap.ts";
import { inspectRoadmap, type RoadmapInput } from "./roadmap-rules.ts";

const resolvers = { hasLabel: () => true, hasPath: () => true };

const stage = (
  id: string,
  status: RoadmapStage["status"],
  dependsOn: readonly string[],
  current = false,
): RoadmapStage => ({
  id,
  title: `段階 ${id}`,
  scope: "合成した範囲",
  habitat: "合成した住処",
  dependsOn,
  status,
  current,
  completion: [`${id} の完了条件`],
  evidence: status === "未着手" ? [] : [{ kind: "path", path: "README.md", why: "合成した根拠" }],
});

/** 入口の段階と後続の個数の要件を満たす、規則に適合した最小の段取り。 */
const baseStages = (): RoadmapStage[] => [
  stage("general_stage_and_nonuniform_rules", "進行中", [], true),
  stage("elementary_ca_finite_calibration", "未着手", ["general_stage_and_nonuniform_rules"]),
  stage("one_dimensional_arbitrary_radius", "未着手", ["elementary_ca_finite_calibration"]),
  stage("lattice_and_countable_group_stages", "未着手", ["one_dimensional_arbitrary_radius"]),
  stage("rule_class_separation", "未着手", ["elementary_ca_finite_calibration"]),
];

const build = (stages: readonly RoadmapStage[]): RoadmapInput => ({
  title: "研究の段取り",
  preamble: ["合成した前置き"],
  stages,
});

const replace = (stages: readonly RoadmapStage[], id: string, patch: Partial<RoadmapStage>): RoadmapStage[] =>
  stages.map((item) => (item.id === id ? { ...item, ...patch } : item));

let failures = 0;

const expectViolation = (
  name: string,
  stages: readonly RoadmapStage[],
  fragment: string,
  overrides: Partial<typeof resolvers> = {},
): void => {
  const { violations } = inspectRoadmap(build(stages), { ...resolvers, ...overrides });
  const hit = violations.some((violation) => violation.includes(fragment));
  if (hit) {
    console.log(`✓ ${name}`);
    return;
  }
  failures += 1;
  console.error(`✗ ${name}: 「${fragment}」を含む違反が出なかった（違反 ${violations.length} 件）`);
  for (const violation of violations) console.error(`    - ${violation}`);
};

const expectClean = (name: string, stages: readonly RoadmapStage[]): void => {
  const { violations } = inspectRoadmap(build(stages), resolvers);
  if (violations.length === 0) {
    console.log(`✓ ${name}`);
    return;
  }
  failures += 1;
  console.error(`✗ ${name}: 違反が出た（${violations.length} 件）`);
  for (const violation of violations) console.error(`    - ${violation}`);
};

expectClean("規則に適合した段取りは通る", baseStages());

expectViolation(
  "現在地が未着手（着手していない段階を現在地と称する）",
  replace(baseStages(), "general_stage_and_nonuniform_rules", {
    status: "未着手",
    evidence: [],
  }),
  "現在地なのに進行中ではない",
);

expectViolation(
  "現在地が到達済み（進行中の作業が段取りのどこにも現れない）",
  replace(baseStages(), "general_stage_and_nonuniform_rules", { status: "到達済み" }),
  "現在地なのに進行中ではない",
);

expectViolation(
  "到達済みの段階の依存先が進行中（先に済ませられないものを済ませたと書く）",
  replace(baseStages(), "elementary_ca_finite_calibration", { status: "到達済み" }),
  "先に済んでいる必要がある依存先が到達済みでない",
);

expectViolation(
  "進行中の段階の依存先が未着手",
  replace(
    replace(baseStages(), "general_stage_and_nonuniform_rules", { status: "未着手", current: false, evidence: [] }),
    "elementary_ca_finite_calibration",
    { status: "進行中", current: true, evidence: [{ kind: "path", path: "README.md", why: "合成した根拠" }] },
  ),
  "先に済んでいる必要がある依存先が到達済みでない",
);

expectViolation(
  "進行中の段階の依存先も進行中（依存先の完了前に後続へ着手する）",
  replace(baseStages(), "elementary_ca_finite_calibration", {
    status: "進行中",
    current: true,
    evidence: [{ kind: "path", path: "README.md", why: "合成した根拠" }],
  }).map((item) =>
    item.id === "general_stage_and_nonuniform_rules" ? { ...item, current: false } : item,
  ),
  "先に済んでいる必要がある依存先が到達済みでない",
);

expectClean(
  "到達済みの段階の依存先が到達済みなら通る",
  replace(
    replace(baseStages(), "general_stage_and_nonuniform_rules", { status: "到達済み", current: false }),
    "elementary_ca_finite_calibration",
    { status: "進行中", current: true, evidence: [{ kind: "path", path: "README.md", why: "合成した根拠" }] },
  ),
);

expectViolation(
  "現在地が二つある",
  replace(baseStages(), "elementary_ca_finite_calibration", {
    current: true,
    status: "進行中",
    evidence: [{ kind: "path", path: "README.md", why: "合成した根拠" }],
  }),
  "現在地はちょうど一つ",
);

expectViolation("依存関係に巡回がある", [
  ...replace(baseStages(), "general_stage_and_nonuniform_rules", {
    dependsOn: ["rule_class_separation"],
  }),
], "依存関係に巡回がある");

expectViolation(
  "実在しない本文ラベルを根拠にしている",
  replace(baseStages(), "general_stage_and_nonuniform_rules", {
    evidence: [{ kind: "label", label: "存在しないラベル", why: "合成した根拠" }],
  }),
  "本文に存在しないラベル",
  { hasLabel: () => false },
);

expectViolation(
  "入口の段階に後続が無い（入口が射程の全体になっている）",
  replace(
    replace(baseStages(), "one_dimensional_arbitrary_radius", { dependsOn: [] }),
    "rule_class_separation",
    { dependsOn: [] },
  ),
  "入口が射程の全体になっている",
);

if (failures > 0) {
  console.error(`段取りの規則の回帰検査が失敗した（${failures} 件）`);
  process.exit(1);
}

console.log("段取りの規則の回帰検査がすべて期待どおり（11 件）");
