#!/usr/bin/env node
/**
 * **転記検査が、実際に起きた事故を検出できることの実証。**
 *
 * 「本番の本文へ走らせたら違反 0 件だった」は、検査が効いていることの根拠にならない
 * （事故はもう直っているのだから 0 件になるのは当たり前である）。
 * そこで `transcription-fixtures.ts` が持つ**事故当時の本文への差分**をメモリ上で当て直し、
 * 検査が挙げることを確かめる。**本文ファイルは 1 バイトも書き換えない。**
 *
 * 各再現データについて 2 つを確かめる:
 *   1. 差分を当てると検査が期待どおりの項目を挙げる（＝検出できる）。
 *   2. 差分を当てなければ挙げない（＝現在の本文では直っている／偽陽性を出していない）。
 *
 * 使い方: node tools/verify-transcription-detection-test.ts
 */

import { loadContentFiles } from "./content-modules.ts";
import { SOURCE_LINKS } from "./source-links.ts";
import {
  applyExemptionRot,
  applyFixture,
  EXEMPTION_ROTS,
  FIXTURES,
  type ExemptionRot,
  type Fixture,
} from "./transcription-fixtures.ts";
import {
  checkBareFamilyUse,
  checkCoverage,
  checkExemptionGrounds,
  readPassage,
  viewOf,
  type BlockView,
} from "./transcription-model.ts";

const files = await loadContentFiles();
const views = new Map<string, BlockView>();
for (const { file, blocks } of files) for (const b of blocks) views.set(b.id, viewOf(b, file));

let failures = 0;
console.log("転記検査の検出テスト");
console.log(`  再現データ: ${FIXTURES.length} 件\n`);

for (const fixture of FIXTURES) {
  const base = views.get(fixture.block);
  if (base === undefined) {
    report(fixture, false, `ブロックが本文に無い: ${fixture.block}`);
    continue;
  }
  const broken: BlockView = { ...base, ...applyFixture(base, fixture) };

  const beforeItems = await itemsOf(base, fixture);
  const afterItems = await itemsOf(broken, fixture);

  const detected = afterItems.some((item) => item.includes(fixture.expect.contains));
  const quietBefore = !beforeItems.some((item) => item.includes(fixture.expect.contains));

  if (detected && quietBefore) {
    report(fixture, true, `検査 ${fixture.expect.check} が「${fixture.expect.contains}」を挙げた`);
  } else if (!detected) {
    report(fixture, false, `検査 ${fixture.expect.check} が挙げなかった。挙がったのは: ${afterItems.join(", ") || "（無し）"}`);
  } else {
    report(fixture, false, `現在の本文でも挙がってしまう（偽陽性）: ${beforeItems.join(", ")}`);
  }
}

// --- 免除の腐り（検査 A′） -------------------------------------------------------
// 「免除は 91 件あるが全部妥当である」を自然文の理由だけで信じない。
// **腐った免除を作ると実際に赤くなる**ことを、型ごとに確かめる。
console.log(`\n免除の腐りの再現データ: ${EXEMPTION_ROTS.length} 件（検査 A′）\n`);
for (const rot of EXEMPTION_ROTS) {
  const link = SOURCE_LINKS.find((l) => l.block === rot.block);
  const view = views.get(rot.block);
  if (link === undefined || view === undefined) {
    reportRot(rot, false, `台帳または本文にブロックが無い: ${rot.block}`);
    continue;
  }
  const passages = [];
  for (const passage of link.passages) passages.push({ passage, lines: (await readPassage(passage)).lines });

  const before = await checkExemptionGrounds(link, view, passages, views);
  const rotten = applyExemptionRot(rot, link, view, passages, views);
  const after = await checkExemptionGrounds(rotten.link, rotten.view, rotten.passageLines, rotten.blocks);

  const hit = after.find((f) => f.item === rot.item && f.kind === rot.expect);
  const quietBefore = !before.some((f) => f.item === rot.item);
  if (hit !== undefined && quietBefore) {
    reportRot(rot, true, `検査 A′ が「${hit.kind}」で挙げた（${rot.item}）`);
  } else if (hit === undefined) {
    reportRot(rot, false, `期待した「${rot.expect}」が出なかった。出たのは: ${after.map((f) => `${f.item}:${f.kind}`).join(", ") || "（無し）"}`);
  } else {
    reportRot(rot, false, `腐らせる前から挙がってしまう（偽陽性）: ${before.map((f) => `${f.item}:${f.kind}`).join(", ")}`);
  }
}

const total = FIXTURES.length + EXEMPTION_ROTS.length;
console.log(`\n${total - failures} / ${total} 件で検出を実証した（転記事故 ${FIXTURES.length} 件 + 免除の腐り ${EXEMPTION_ROTS.length} 件）。`);
if (failures > 0) process.exit(1);

function reportRot(rot: ExemptionRot, ok: boolean, detail: string): void {
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${rot.name}`);
  console.log(`      対象: ${rot.block} / ${rot.item}`);
  console.log(`      ${detail}`);
}

async function itemsOf(view: BlockView, fixture: Fixture): Promise<string[]> {
  if (fixture.expect.check === "B") {
    return checkBareFamilyUse(view).map((f) => `${f.symbol}（${f.binder}）`);
  }
  const link = SOURCE_LINKS.find((l) => l.block === fixture.block);
  if (link === undefined) throw new Error(`検査 A の台帳に ${fixture.block} が無い（source-links.ts）`);
  const passages = [];
  for (const passage of link.passages) passages.push({ passage, lines: (await readPassage(passage)).lines });
  return checkCoverage(link, view, passages).findings.map((f) => f.item);
}

function report(fixture: Fixture, ok: boolean, detail: string): void {
  if (!ok) failures += 1;
  console.log(`  ${ok ? "検出" : "**失敗**"}: ${fixture.name}`);
  console.log(`      対象ブロック: ${fixture.block}`);
  console.log(`      ${detail}`);
}
