#!/usr/bin/env node
/**
 * 出力された HTML（手元のビルド、または公開済みのページ）に、研究の段取りが
 * 正本のとおり載っていることを検査する。
 *
 * 正本を直しても公開物が古いままなら、読む人には段取りが存在しないのと同じである。
 * したがって「正本が正しい」だけでは足りず、「読める場所に同じものが在る」ことを別に検査する。
 * 期待文字列は `render-roadmap.ts` から作るので、描画側を変えればこの検査も一緒に動く。
 *
 * 使い方: node tools/verify-roadmap-in-output.ts <HTMLファイル> [表示名]
 */

import { readFileSync } from "node:fs";

import { roadmapStages, roadmapTitle, type RoadmapStage } from "../research-roadmap.ts";

const [, , filePath, displayName] = process.argv;
if (filePath === undefined) {
  console.error("使い方: node tools/verify-roadmap-in-output.ts <HTMLファイル> [表示名]");
  process.exit(2);
}
const where = displayName ?? filePath;

const html = readFileSync(filePath, "utf8");
const stages: readonly RoadmapStage[] = roadmapStages;

const escapeHtml = (value: string): string =>
  value.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

const missing: string[] = [];
let checked = 0;
const expect = (needle: string, description: string): void => {
  checked += 1;
  if (!html.includes(escapeHtml(needle))) missing.push(`${description}: ${needle}`);
};

expect(roadmapTitle, "段取りの表題");
if (!html.includes('id="sec-roadmap"')) missing.push("段取りの節そのものが無い（id=\"sec-roadmap\"）");

for (const stage of stages) {
  expect(stage.title, "段階の表示名");
  if (!html.includes(`id="sec-roadmap-${stage.id}"`)) {
    missing.push(`段階の飛び先が無い: ${stage.id}`);
  }
  checked += 1;
  expect(stage.scope, `${stage.title} の範囲`);
  expect(stage.habitat, `${stage.title} の量の住処`);
  for (const item of stage.completion) expect(item, `${stage.title} の完了条件`);
  for (const item of stage.evidence) {
    expect(item.kind === "label" ? item.label : item.path, `${stage.title} の根拠`);
  }
  for (const dependency of stage.dependsOn) {
    const title = stages.find((candidate) => candidate.id === dependency)?.title;
    if (title === undefined) {
      missing.push(`依存先が正本に無い: ${stage.id} -> ${dependency}`);
      continue;
    }
    expect(title, `${stage.title} の依存先`);
  }
}

const current = stages.find((stage) => stage.current);
if (current === undefined) {
  missing.push("現在地が正本に無い");
} else {
  checked += 1;
  if (!html.includes("roadmap-stage--current")) missing.push("現在地の印が出力に無い");
  expect(`${current.status}（現在地）`, "現在地の状態表示");
}

if (missing.length > 0) {
  console.error(`${where} に段取りが正本どおり載っていない（${missing.length} 件）:`);
  for (const item of missing) console.error(`  - ${item}`);
  process.exit(1);
}

console.log(`${where}: 段取りの照合 ${checked} 件すべて一致（段階 ${stages.length} 件）`);
