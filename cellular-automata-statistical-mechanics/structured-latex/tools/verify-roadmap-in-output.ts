#!/usr/bin/env node
/**
 * 出力された HTML（手元のビルド、または公開済みのページ）に、研究の段取りが
 * 正本のとおり載っていることを検査する。
 *
 * 正本を直しても公開物が古いままなら、読む人には段取りが存在しないのと同じである。
 * したがって「正本が正しい」だけでは足りず、「読める場所に同じものが在る」ことを別に検査する。
 *
 * **期待文字列は描画器（`render-roadmap.ts`）の関数から作らない。** 描画器の出す文字列を
 * そのまま期待値にすると、描画器が壊れたときに期待値も一緒に壊れ、照合が恒真になる。
 * 期待値は正本のデータ（`../research-roadmap.ts`）だけから組み立てる。
 *
 * **照合は段階ごとの区画に閉じて行う。** 文書全体を対象に部分文字列を探すと、ある段階の
 * 完了条件・根拠・状態が別の段階の下に描かれていても通り、どの段階の話かを主張できない。
 *
 * 使い方: node tools/verify-roadmap-in-output.ts <HTMLファイル> [表示名]
 */

import { readFileSync } from "node:fs";

import { roadmapPreamble, roadmapStages, roadmapTitle, type RoadmapStage } from "../research-roadmap.ts";

const [, , filePath, displayName] = process.argv;
if (filePath === undefined) {
  console.error("使い方: node tools/verify-roadmap-in-output.ts <HTMLファイル> [表示名]");
  process.exit(2);
}
const where = displayName ?? filePath;

const html = readFileSync(filePath, "utf8");
const stages: readonly RoadmapStage[] = roadmapStages;
const preamble: readonly string[] = roadmapPreamble;

const escapeHtml = (value: string): string =>
  value.replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

const missing: string[] = [];
let checked = 0;
const expectIn = (haystack: string, needle: string, description: string): void => {
  checked += 1;
  if (!haystack.includes(escapeHtml(needle))) missing.push(`${description}: ${needle}`);
};
const expect = (needle: string, description: string): void => expectIn(html, needle, description);

expect(roadmapTitle, "段取りの表題");
if (!html.includes('id="sec-roadmap"')) missing.push('段取りの節そのものが無い（id="sec-roadmap"）');

/**
 * 前置きは「初等セルオートマトンは入口であって射程ではない」等、段取りの読み方そのものを
 * 決めている。ここが落ちた公開物は、段階の一覧だけが残って射程の宣言を失う。
 */
for (const paragraph of preamble) expect(paragraph, "段取りの前置き");

/** 段階の区画（`<section ... id="sec-roadmap-<id>"> ... </section>`）を切り出す。 */
const stageSection = (stage: RoadmapStage): string | undefined => {
  const anchor = `id="sec-roadmap-${stage.id}"`;
  const at = html.indexOf(anchor);
  if (at < 0) return undefined;
  const opens = html.lastIndexOf("<section", at);
  const closes = html.indexOf("</section>", at);
  if (opens < 0 || closes < 0) return undefined;
  return html.slice(opens, closes + "</section>".length);
};

for (const stage of stages) {
  const section = stageSection(stage);
  checked += 1;
  if (section === undefined) {
    missing.push(`段階の区画が無い: ${stage.id}`);
    continue;
  }
  expectIn(section, stage.title, "段階の表示名");
  expectIn(section, stage.scope, `${stage.title} の範囲`);
  expectIn(section, stage.habitat, `${stage.title} の量の住処`);
  /**
   * 状態は進捗の主張そのものなので、段階の区画の中に、正本の三値がそのまま出ていることを見る。
   * 区画に閉じないと、別の段階に出ている同じ三値で満たされてしまう。
   */
  expectIn(section, stage.status, `${stage.title} の状態`);
  checked += 1;
  if (section.includes("（現在地）") !== stage.current) {
    missing.push(
      stage.current
        ? `現在地なのに現在地の表示が無い: ${stage.title}`
        : `現在地でないのに現在地として描かれている: ${stage.title}`,
    );
  }
  checked += 1;
  if (section.includes("roadmap-stage--current") !== stage.current) {
    missing.push(
      stage.current
        ? `現在地の印が出力に無い: ${stage.title}`
        : `現在地でない段階に現在地の印が付いている: ${stage.title}`,
    );
  }
  for (const item of stage.completion) expectIn(section, item, `${stage.title} の完了条件`);
  for (const item of stage.evidence) {
    expectIn(section, item.kind === "label" ? item.label : item.path, `${stage.title} の根拠`);
    /** 根拠は「何を指すか」だけでは足りない。なぜそれが根拠なのかが読めなければ主張が空になる。 */
    expectIn(section, item.why, `${stage.title} の根拠の説明`);
  }
  for (const dependency of stage.dependsOn) {
    const title = stages.find((candidate) => candidate.id === dependency)?.title;
    if (title === undefined) {
      missing.push(`依存先が正本に無い: ${stage.id} -> ${dependency}`);
      continue;
    }
    expectIn(section, title, `${stage.title} の依存先`);
  }
}

if (stages.every((stage) => !stage.current)) missing.push("現在地が正本に無い");

if (missing.length > 0) {
  console.error(`${where} に段取りが正本どおり載っていない（${missing.length} 件）:`);
  for (const item of missing) console.error(`  - ${item}`);
  process.exit(1);
}

console.log(`${where}: 段取りの照合 ${checked} 件すべて一致（段階 ${stages.length} 件）`);
