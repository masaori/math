#!/usr/bin/env node
/**
 * 生成物（`build/document.tex`）に**参照用ノートが混入していない**ことを機械的に検査する。
 *
 * README 7 節と CLAUDE.md の規約: `content/` が出版物の本体で、`notes/` は出版物に載らない。
 * 「載らないつもり」で運用していても、生成器がうっかり `notes/` を読めば混入する。
 * ここでは 3 つの独立した観点で確かめる:
 *
 *   1. **構造**: 生成器 `build-latex.ts` が notes を読む経路を持たないこと
 *      （`loadNoteFiles` / `notesDir` を参照していない）。
 *   2. **識別子**: 生成物にノートの id が 1 件も現れないこと。
 *   3. **本文**: 各ノートの本文から取った特徴的な文字列が、生成物に現れないこと
 *      （id を書き換えただけで中身が混入する経路を塞ぐ）。
 *
 * **全ロケールに同じ検査を掛ける**（cycle 24 step 2）。それ以前は英語版が
 * `structured-latex-en/tools/verify-no-notes-in-output.ts` としてこの検査ごと複製されており、
 * 「複製した理由: 対象の生成器が英語版固有だから」と自分で書いていた。生成器を 1 本にした
 * いま、その理由は消えた。
 *
 * 使い方:
 *   node tools/verify-no-notes-in-output.ts               原文の生成物を検査する
 *   node tools/verify-no-notes-in-output.ts --locale en   英語版の生成物を検査する
 */

import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

import type { Node } from "../schema.ts";
import { escapeText } from "./latex-escape.ts";
import { loadNoteFiles, localeFromArgv, structuredLatexDir } from "./content-modules.ts";
import { editionFor } from "./editions.ts";

const locale = localeFromArgv();
const edition = editionFor(locale);
const texPath = join(structuredLatexDir, "build", edition.buildSubdir, "document.tex");
if (!existsSync(texPath)) {
  throw new Error(`生成物が無い: ${texPath}\n  先に build-latex.ts（--locale ${locale}）を実行する`);
}
const tex = readFileSync(texPath, "utf8");

// --- 1. 生成器が notes を読む経路を持たないこと ------------------------------
const generatorSource = readFileSync(join(structuredLatexDir, "tools", "build-latex.ts"), "utf8");
// コメント行を除いたコードだけを見る（説明文に語が出てくるのは構わない）。
const generatorCode = generatorSource
  .split("\n")
  .filter((line) => !/^\s*(\*|\/\/|\/\*)/.test(line))
  .join("\n");
for (const forbidden of ["loadNoteFiles", "notesDir", "notes/"]) {
  if (generatorCode.includes(forbidden)) {
    throw new Error(
      `生成器が notes を参照している（${forbidden}）。最終成果物は content/ だけから作る。`,
    );
  }
}

// --- 2 と 3. ノートの id と本文が生成物に現れないこと -------------------------
const noteFiles = await loadNoteFiles();
const leakedIds: string[] = [];
const leakedTexts: { noteId: string; sample: string }[] = [];
const notesWithoutSample: string[] = [];
let noteCount = 0;
let checkedSamples = 0;

for (const { notes } of noteFiles) {
  for (const note of notes) {
    noteCount += 1;
    if (tex.includes(note.id)) leakedIds.push(note.id);
    const samples = distinctiveTexts(note.body ?? []);
    if (samples.length === 0) notesWithoutSample.push(note.id);
    for (const sample of samples) {
      checkedSamples += 1;
      // 生成物は地の文をエスケープするので、エスケープ後の形でも照合する。
      if (tex.includes(sample) || tex.includes(escapeText(sample))) {
        leakedTexts.push({ noteId: note.id, sample });
      }
    }
  }
}

if (leakedIds.length > 0 || leakedTexts.length > 0) {
  const detail = [
    ...leakedIds.map((id) => `  ノート id が生成物にある: ${id}`),
    ...leakedTexts.map((leak) => `  ノート本文が生成物にある: ${leak.noteId} — 「${leak.sample}」`),
  ].join("\n");
  throw new Error(`参照用ノートが最終成果物へ混入している:\n${detail}`);
}

console.log(
  `no notes in output (${locale}): ノート ${noteCount} 件（本文サンプル ${checkedSamples} 件）は ` +
    `いずれも ${texPath} に現れない`,
);
if (notesWithoutSample.length > 0) {
  // 本文がほぼ数式のノートは、地の文サンプルを取れない。id 検査だけが効いている状態なので明示する。
  console.log(
    `  うち ${notesWithoutSample.length} 件は地の文サンプルを取れず id 検査のみ: ` +
      `${notesWithoutSample.slice(0, 5).join(", ")}${notesWithoutSample.length > 5 ? " ほか" : ""}`,
  );
}

/**
 * ノート本文から「偶然一致しない程度に長い」地の文を取り出す。
 * 数式は content と一致しうる（同じ式に言及するため）ので、地の文だけを見る。
 */
function distinctiveTexts(nodes: readonly Node[]): string[] {
  const out: string[] = [];
  const walk = (list: readonly Node[]): void => {
    for (const node of list) {
      if (node.type === "text" && node.value.trim().length >= 24) {
        out.push(node.value.trim());
      }
      if (node.type === "paragraph") walk(node.children);
      if (node.type === "list") node.items.forEach(walk);
    }
  };
  walk(nodes);
  return out;
}
