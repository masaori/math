#!/usr/bin/env node
/**
 * 生成物（`build/document.tex`）に**参照用ノートが混入していない**ことを機械的に検査する。
 * 観点は日本語版 `../structured-latex/tools/verify-no-notes-in-output.ts` と同じ 3 つ。
 *
 *   1. **構造**: 生成器がノートを読む経路を持たないこと。
 *   2. **識別子**: 生成物にノートの id が 1 件も現れないこと。
 *   3. **本文**: 各ノートの本文から取った特徴的な文字列が、生成物に現れないこと。
 *
 * **複製した理由**: この検査は「その生成器がノートを読まないこと」をソースの実測で確かめる。
 * 対象の生成器が英語版固有（`tools/build-latex.ts`）なので、日本語版のものをそのまま
 * 呼んでも英語版の生成器は検査されない。共通化するには日本語版の書き換えが要るが、
 * この作業は日本語版を変更しない方針である。
 *
 * 既知の限界: 英語版の生成器は地の文の `**強調**` を `\textbf{...}` へ写す。ノート本文に
 * `**` が含まれる場合、下の 3 の照合（エスケープ形までしか作らない）は取りこぼしうる。
 * ノートが 0 件の現状では効かないが、ノートを足すときはここを見直すこと。
 *
 * 使い方: node tools/verify-no-notes-in-output.ts
 */

import { existsSync, readFileSync } from "node:fs";
import { join } from "node:path";

import { escapeText } from "../../structured-latex/tools/latex-escape.ts";
import type { Node } from "../schema.ts";
import { loadNoteFiles, structuredLatexDir } from "./content-modules.ts";

const texPath = join(structuredLatexDir, "build", "document.tex");
if (!existsSync(texPath)) {
  throw new Error(`生成物が無い: ${texPath}\n  先に npm run build:tex を実行する`);
}
const tex = readFileSync(texPath, "utf8");

// --- 1. 生成器がノートを読む経路を持たないこと --------------------------------
const generatorSource = readFileSync(join(structuredLatexDir, "tools", "build-latex.ts"), "utf8");
const generatorCode = generatorSource
  .split("\n")
  .filter((line) => !/^\s*(\*|\/\/|\/\*)/.test(line))
  .join("\n");
for (const forbidden of ["loadNoteFiles", "notesDir", "notes/"]) {
  if (generatorCode.includes(forbidden)) {
    throw new Error(
      `生成器がノートを参照している（${forbidden}）。最終成果物は content/ だけから作る。`,
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
  `no notes in output: ノート ${noteCount} 件（本文サンプル ${checkedSamples} 件）は ` +
    "いずれも build/document.tex に現れない",
);
if (notesWithoutSample.length > 0) {
  console.log(
    `  うち ${notesWithoutSample.length} 件は地の文サンプルを取れず id 検査のみ: ` +
      `${notesWithoutSample.slice(0, 5).join(", ")}${notesWithoutSample.length > 5 ? " ほか" : ""}`,
  );
}

/** ノート本文から「偶然一致しない程度に長い」地の文を取り出す。 */
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
