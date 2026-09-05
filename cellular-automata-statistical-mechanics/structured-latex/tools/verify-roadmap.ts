#!/usr/bin/env node
/**
 * 研究の段取り（`../research-roadmap.ts`）が、記録だけの飾りになっていないことを検査する。
 *
 * 規則そのものは `roadmap-rules.ts` が純関数として持つ（合成した段取りで回帰検査を掛けるため）。
 * ここは正本を読み込み、本文のラベルとディスク上のパスの実在を解決して規則へ渡す入口である。
 */

import { join } from "node:path";

import { roadmapPreamble, roadmapStages, roadmapTitle, type RoadmapStage } from "../research-roadmap.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";
import { evidenceFileExists } from "./roadmap-evidence-fs.ts";
import { inspectRoadmap } from "./roadmap-rules.ts";

const projectDir = join(structuredLatexDir, "..");

/**
 * `as const satisfies` で書かれた正本は、配列長や依存先 id まで型に固定されている。
 * 検査側でその狭い型のまま扱うと「長さ 0 との比較は無意味」と型検査に拒まれ、
 * 空の段取りを検出する検査そのものが書けなくなる。検査は広い型の上で行う。
 */
const stages: readonly RoadmapStage[] = roadmapStages;
const preamble: readonly string[] = roadmapPreamble;

const contentFiles = await loadContentFiles();
const labels = new Set<string>();
for (const file of contentFiles) {
  for (const block of file.blocks) {
    for (const label of block.labels) labels.add(label);
  }
}

const report = inspectRoadmap(
  { title: roadmapTitle, preamble, stages },
  {
    hasLabel: (label) => labels.has(label),
    hasPath: (path) => evidenceFileExists(projectDir, path),
  },
);

if (report.violations.length > 0) {
  console.error(`研究の段取りに違反がある（${report.violations.length} 件）:`);
  for (const violation of report.violations) console.error(`  - ${violation}`);
  process.exit(1);
}

console.log(
  `研究の段取りを検査した: 段階 ${stages.length} 件、` +
    `依存 ${report.dependencyCount} 件、` +
    `完了条件 ${report.completionCount} 件、根拠 ${report.evidenceCount} 件、現在地 ${report.currentCount} 件`,
);
