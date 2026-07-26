#!/usr/bin/env node
/**
 * 構造化テキストの実行時検証。
 *
 * 型検査（`tsc -p tsconfig.json --noEmit`）と役割を分ける:
 *   - **コンパイル時**に落とせるもの（存在しないラベルへの ref / targets、kind ごとの
 *     フィールド、targets の空配列）は `schema.ts` の型が担当する。ここでは再検査しない
 *     …のではなく、`.mjs`（型検査対象外）が残っている移行期のために**同じ検査を実行時にも回す**。
 *   - 型では表現できないもの（id・ラベルの重複、未変換 Typst 記法の混入、
 *     生成済みラベル一覧と実状の一致）はこのスクリプトだけが検出できる。
 *
 * 使い方: node structured-latex/tools/validate-content.ts
 */

import { ALL_LABELS } from "../labels.generated.ts";
import { defineNotes, validateBlock } from "../schema.ts";
import type { ConvertedBlock, Node } from "../schema.ts";
import { loadContentFiles, loadNoteFiles } from "./content-modules.ts";

type RefUse = { target: string; blockId: string; file: string };

const ids = new Set<string>();
const labels = new Map<string, string>();
// ref 解決チェック用に、全ブロックの ref を一旦集約してから（ラベルは後続ファイルで
// 定義されうるため）全ラベル確定後に target を検証する。
const refs: RefUse[] = [];
let blockCount = 0;
let headingCount = 0;

const contentFiles = await loadContentFiles();

for (const { file, blocks } of contentFiles) {
  for (const block of blocks) {
    validateBlock(block);
    blockCount += 1;
    if (block.kind === "heading") headingCount += 1;
    if (ids.has(block.id)) {
      throw new Error(`duplicate block id: ${block.id}`);
    }
    ids.add(block.id);
    for (const label of block.labels) {
      const owner = labels.get(label);
      if (owner !== undefined) {
        throw new Error(`duplicate label ${label}: ${owner} and ${block.id}`);
      }
      labels.set(label, block.id);
    }
    scanForTypstMath(block, file);
    collectRefTargets(block, file, refs);
  }
}

if (blockCount === 0) {
  throw new Error("no blocks found — check that content files export defineBlocks([...])");
}

// --- notes/ の検証 -----------------------------------------------------------
// ノートは文書本体ではない（最終成果物は content/ だけから生成する）。ただし
// targets / ref は content 側のラベルへ必ず解決できなければならない。解決できない
// ノートは「どの主張に属するのか分からないメモ」であり、ラベル改名時に静かに迷子になる。
const noteIds = new Set<string>();
const noteTargets: { target: string; noteId: string; file: string }[] = [];
let noteCount = 0;
const noteFiles = await loadNoteFiles();

for (const { file, notes } of noteFiles) {
  // schema 妥当性は defineNotes に通して確認する（notes ファイル自身と同じ検証）。
  defineNotes(notes);
  for (const note of notes) {
    noteCount += 1;
    if (noteIds.has(note.id) || ids.has(note.id)) {
      throw new Error(`duplicate note id: ${note.id}`);
    }
    noteIds.add(note.id);
    for (const target of note.targets) {
      noteTargets.push({ target, noteId: note.id, file });
    }
    scanForTypstMathInNodes(note.body ?? [], `${file}:${note.id}`);
    walkRefs(note.body ?? [], note.id, file, refs);
  }
}

// ref 解決チェック: ref.target は必ず定義済みラベルでなければならない
// （Typst の `<label>`↔`#ref(<label>)` に対応。未解決 ref は Typst の警告に相当）。
const unresolved = refs.filter((r) => !labels.has(r.target));
if (unresolved.length > 0) {
  const detail = unresolved.map((r) => `  ${r.file}:${r.blockId} -> ref target "${r.target}"`);
  throw new Error(
    `unresolved ref target(s) — target must be a defined label:\n${detail.join("\n")}`,
  );
}

// targets 解決チェック: ノートは必ず content 側の実在ラベルに紐づく。
const unresolvedTargets = noteTargets.filter((t) => !labels.has(t.target));
if (unresolvedTargets.length > 0) {
  const detail = unresolvedTargets.map((t) => `  ${t.file}:${t.noteId} -> targets "${t.target}"`);
  throw new Error(
    `unresolved note target(s) — targets must be labels defined in content/:\n${detail.join("\n")}`,
  );
}

// 生成済みラベル一覧（型の土台）と実状の一致。ここがずれていると、
// 型検査が通っても実在しないラベルを許してしまう / 実在するラベルを拒んでしまう。
const generated = new Set<string>(ALL_LABELS);
const missingInGenerated = [...labels.keys()].filter((label) => !generated.has(label));
const staleInGenerated = [...generated].filter((label) => !labels.has(label));
if (missingInGenerated.length > 0 || staleInGenerated.length > 0) {
  throw new Error(
    "labels.generated.ts が content/ の実状と一致していない（node tools/generate-labels.ts で再生成する）:\n" +
      `  生成物に無い実在ラベル: ${missingInGenerated.join(", ") || "なし"}\n` +
      `  実在しない生成物のラベル: ${staleInGenerated.join(", ") || "なし"}`,
  );
}

console.log(
  `validated ${blockCount} blocks from ${contentFiles.length} files ` +
    `(${headingCount} headings, ${labels.size} labels, ${refs.length} refs, all resolved)`,
);
console.log(
  `notes: ${noteCount}件（内部参照用・出版物には載らない） from ${noteFiles.length} files ` +
    `(${noteTargets.length} targets, all resolved)`,
);

function scanForTypstMath(block: ConvertedBlock, file: string): void {
  const strings: string[] = [];
  // 見出しブロックは本文を持たないため statement は undefined になりうる。
  collectStrings(block.statement ?? [], strings);
  collectStrings(block.proof ?? [], strings);
  // タイトルの tex も KaTeX へ渡るので同じ規約で検査する。
  const title = block.title;
  if (title !== null && title !== undefined && title.tex !== undefined) {
    strings.push(title.tex);
  }
  assertNoTypstToken(strings, `${file}:${block.id}`);
}

function scanForTypstMathInNodes(nodes: readonly Node[], where: string): void {
  const strings: string[] = [];
  collectStrings(nodes, strings);
  assertNoTypstToken(strings, where);
}

function assertNoTypstToken(strings: readonly string[], where: string): void {
  const suspicious = strings.filter((value) =>
    /(^|[^\\])\b(dot\.op|times\.o|arrow\.l\.r|eq\.not|sqrt\(|mat\(|cases\(|quad)\b/.test(
      value.replaceAll("\\quad", ""),
    ),
  );
  const first = suspicious[0];
  if (first !== undefined) {
    throw new Error(`${where} has suspicious unconverted Typst math token: ${first}`);
  }
}

function collectStrings(nodes: readonly Node[], out: string[]): void {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") out.push(node.tex);
    if (node.type === "paragraph") collectStrings(node.children, out);
    if (node.type === "list") node.items.forEach((item) => collectStrings(item, out));
  }
}

function collectRefTargets(block: ConvertedBlock, file: string, out: RefUse[]): void {
  walkRefs(block.statement ?? [], block.id, file, out);
  walkRefs(block.proof ?? [], block.id, file, out);
}

function walkRefs(nodes: readonly Node[], blockId: string, file: string, out: RefUse[]): void {
  for (const node of nodes) {
    if (node.type === "ref") out.push({ target: node.target, blockId, file });
    if (node.type === "paragraph") walkRefs(node.children, blockId, file, out);
    if (node.type === "list") node.items.forEach((item) => walkRefs(item, blockId, file, out));
  }
}
