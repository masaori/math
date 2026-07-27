#!/usr/bin/env node
/**
 * 構造化テキストの実行時検証。
 *
 * 型検査（`tsc -p tsconfig.json --noEmit`）と役割を分ける:
 *   - **コンパイル時**に落ちるもの（存在しないラベルへの ref / targets、id・ラベルの重複、
 *     kind ごとのフィールド、targets の空配列、habitat の必須性と realEscape の要否）は
 *     `schema.ts` の型と `document.generated.ts` が担当する。ここでの再検査は、
 *     型を経由せずに値が作られる経路（動的生成・`as` による回避）への保険である。
 *   - **型では表現できないもの**（未変換 Typst 記法の混入、生成物とファイル一覧の一致、
 *     `verification` が指すディレクトリの実在、可算 habitat のブロックに ℝ/ℂ が混入していないこと）は
 *     このスクリプトだけが検出できる。
 *
 * 使い方: node structured-latex/tools/validate-content.ts
 */

import { existsSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { defineNotes, HABITAT_VALUES, validateBlock } from "../schema.ts";
import type { ConvertedBlock, Node } from "../schema.ts";
import { loadContentFiles, loadNoteFiles, structuredLatexDir } from "./content-modules.ts";

/** プロジェクトルート（`integrable-lattice/`）。`verification` のパスはここからの相対。 */
const projectRoot = join(structuredLatexDir, "..");

type RefUse = { target: string; blockId: string; file: string };

const ids = new Set<string>();
const labels = new Map<string, string>();
// ref 解決チェック用に、全ブロックの ref を一旦集約してから（ラベルは後続ファイルで
// 定義されうるため）全ラベル確定後に target を検証する。
const refs: RefUse[] = [];
let blockCount = 0;
let headingCount = 0;
/** ℝ/ℂ へ脱出していると宣言したブロック（最後に一覧で出す）。 */
const escapes: { blockId: string; habitat: string; why: string }[] = [];
let verificationLinkCount = 0;
let leanLinkCount = 0;

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
    checkHabitatConsistency(block, file);
    checkLinkageTargets(block, file);
    collectRefTargets(block, file, refs);
  }
}

if (blockCount === 0) {
  throw new Error("no blocks found — check that content files export defineBlocks([...])");
}

// --- notes/ の検証 -----------------------------------------------------------
// ノートは文書本体ではない（最終成果物は content/ だけから生成する）。ただし
// targets / ref は content 側のラベルへ必ず解決できなければならない。
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
    const noteTitle = note.title;
    scanForTypstMathInNodes(note.body ?? [], `${file}:${note.id}`);
    if (noteTitle !== null && noteTitle !== undefined && noteTitle.tex !== undefined) {
      assertNoTypstToken([noteTitle.tex], `${file}:${note.id}.title`);
    }
    walkRefs(note.body ?? [], note.id, file, refs);
  }
}

// ref 解決チェック: ref.target は必ず定義済みラベルでなければならない。
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

// 生成済みラベル一覧（型の土台）と実状の一致。
const generated = new Set<string>(ALL_LABELS);
const missingInGenerated = [...labels.keys()].filter((label) => !generated.has(label));
const staleInGenerated = [...generated].filter((label) => !labels.has(label));
if (missingInGenerated.length > 0 || staleInGenerated.length > 0) {
  throw new Error(
    "labels.generated.ts が content/ の実状と一致していない（node tools/generate-index.ts で再生成する）:\n" +
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
console.log(
  `linkage: SageMath 検証 ${verificationLinkCount} 件（全て実在）、Lean 定理 ${leanLinkCount} 件`,
);
console.log(`ℝ/ℂ への脱出を宣言しているブロック: ${escapes.length} 件`);
for (const escape of escapes) {
  console.log(`  - ${escape.blockId} [${escape.habitat}] ${summarize(escape.why)}`);
}

function scanForTypstMath(block: ConvertedBlock, file: string): void {
  const strings = collectBlockStrings(block);
  assertNoTypstToken(strings, `${file}:${block.id}`);
}

function collectBlockStrings(block: ConvertedBlock): string[] {
  const strings: string[] = [];
  // 見出しブロックは本文を持たないため statement は undefined になりうる。
  collectStrings(block.statement ?? [], strings);
  collectStrings(block.proof ?? [], strings);
  // タイトルの tex も KaTeX へ渡るので同じ規約で検査する。
  const title = block.title;
  if (title !== null && title !== undefined && title.tex !== undefined) {
    strings.push(title.tex);
  }
  return strings;
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

/**
 * 可算／非可算の分別（本プロジェクト固有の検査）。
 *
 * README とリポジトリ直下 CLAUDE.md の要求は「可算（ℕ/ℤ/ℚ/Λ/ℚ̄）と非可算（ℝ/ℂ）を混ぜず、
 * ℝ へ脱出した箇所を必ず明示する」。`habitat` / `realEscape` の**要否**は型で守れるが、
 * 「可算だと宣言したブロックの数式に実は ℝ が出ている」という**宣言と中身の食い違い**は、
 * 数式が `String.raw` の `string`（リテラル型ではない）である以上、型では検出できない。
 * ここで実行時に見る。
 *
 * 誤検出したときに黙らせる正しい直し方は「検査を緩める」ことではなく、
 * habitat を `"mixed"`（または `"R"` / `"C"`）にして realEscape を書くことである。
 */
function checkHabitatConsistency(block: ConvertedBlock, file: string): void {
  if (block.kind === "heading") return;
  const habitat = block.habitat;
  if (HABITAT_VALUES.escaping.has(habitat)) {
    escapes.push({ blockId: block.id, habitat, why: block.realEscape ?? "" });
    return;
  }
  const offending = collectBlockStrings(block).filter((value) =>
    // 地の文に直書きされた Unicode の ℝ / ℂ も見る。生成器はこれを LaTeX の
    // \mathbb{R} へ写して PDF に印字するので、見逃すと可算宣言のまま実数が出力へ出る。
    /\\mathbb\{[RC]\}|\\mathbb R\b|\\mathbb C\b|\\R\b|\\C\b|[ℝℂ]/.test(value),
  );
  const first = offending[0];
  if (first !== undefined) {
    throw new Error(
      `${file}:${block.id} は可算側の habitat "${habitat}" を宣言しているのに、` +
        `数式に非可算（ℝ/ℂ）が現れている: ${first}\n` +
        "  → ℝ/ℂ を本当に使うなら habitat を \"mixed\"（または \"R\" / \"C\"）にして、" +
        "realEscape にどこで・なぜ脱出したかを書くこと。" +
        "使っていないなら数式から ℝ/ℂ を取り除くこと。",
    );
  }
}

/**
 * `verification` が指す SageMath 検証ディレクトリの実在確認。
 * 型システムはファイルシステムを読めないので、ここでしか検出できない。
 * 実在しないパスを黙って通すと、証明↔数値検証の対応が切れたまま「紐づいている」ように見える。
 */
function checkLinkageTargets(block: ConvertedBlock, file: string): void {
  if (block.kind === "heading") return;
  for (const target of block.verification ?? []) {
    verificationLinkCount += 1;
    const absolute = join(projectRoot, target);
    if (!existsSync(absolute)) {
      throw new Error(
        `${file}:${block.id}.verification が実在しないパスを指している: ${target}\n` +
          `  （プロジェクトルート ${projectRoot} からの相対パスで書く）`,
      );
    }
  }
  leanLinkCount += (block.lean ?? []).length;
}

function summarize(value: string): string {
  const oneLine = value.replaceAll(/\s+/g, " ").trim();
  return oneLine.length > 60 ? `${oneLine.slice(0, 60)}…` : oneLine;
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
