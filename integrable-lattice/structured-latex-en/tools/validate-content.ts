#!/usr/bin/env node
/**
 * 英語版 content の実行時検証。役割分担は日本語版 `../structured-latex/tools/validate-content.ts`
 * と同じである（型で落ちるものはここで再検査しない。型を迂回した値への保険と、
 * 型では表現できないもの——`verification` の実在・可算宣言と数式の食い違い——だけを見る）。
 *
 * **日本語版の複製ではあるが、共通化していない。** 理由は 2 つ。
 *   1. 日本語版のこのファイルは日本語版の `schema.ts` / `labels.generated.ts` に束縛されている。
 *      共通化するには日本語版を書き換える必要があり、この作業は日本語版を変更しない方針である。
 *   2. 未変換 Typst 記法の検査は日本語版から Typst を移行した経緯に固有のもので、
 *      英語版には Typst 由来のテキストが無い。ここでは落としてある（差分を明示するため）。
 *
 * 使い方: node tools/validate-content.ts
 */

import { existsSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { HABITAT_VALUES, checkHabitation, runtimeSchema } from "../schema.ts";
import type { ConvertedBlock, Node, TheoremLikeBlock } from "../schema.ts";
import { loadContentFiles, loadNoteFiles, structuredLatexDir } from "./content-modules.ts";

/** プロジェクトルート（`integrable-lattice/`）。`verification` のパスはここからの相対。 */
const projectRoot = join(structuredLatexDir, "..");

type RefUse = { target: string; blockId: string; file: string };

const problems: string[] = [];
const ids = new Set<string>();
const labels = new Map<string, string>();
const refs: RefUse[] = [];
let blockCount = 0;
let headingCount = 0;
const escapes: { blockId: string; habitat: string; why: string }[] = [];
let verificationLinkCount = 0;
let leanLinkCount = 0;
let citeCount = 0;

const contentFiles = await loadContentFiles();

for (const { file, blocks } of contentFiles) {
  const parsed = runtimeSchema.validateBlocks(blocks, file);
  if (!parsed.success) {
    for (const issue of parsed.error) problems.push(`${issue.path}: ${issue.message}`);
  }
  for (const block of blocks) {
    blockCount += 1;
    if (block.kind === "heading") headingCount += 1;
    if (ids.has(block.id)) problems.push(`duplicate block id: ${block.id}`);
    ids.add(block.id);
    for (const label of block.labels) {
      const owner = labels.get(label);
      if (owner !== undefined) problems.push(`duplicate label ${label}: ${owner} と ${block.id}`);
      labels.set(label, block.id);
    }
    checkHabitatConsistency(block, file);
    checkLinkageTargets(block, file);
    collectRefTargets(block, file, refs);
    citeCount += countCites(block);
  }
}

if (blockCount === 0) {
  problems.push("no blocks found — check that content files export defineBlocks([...])");
}

// --- notes/ の検証 -----------------------------------------------------------
const noteIds = new Set<string>();
const noteTargets: { target: string; noteId: string; file: string }[] = [];
let noteCount = 0;
const noteFiles = await loadNoteFiles();

for (const { file, notes } of noteFiles) {
  const parsed = runtimeSchema.validateNotes(notes, file);
  if (!parsed.success) {
    for (const issue of parsed.error) problems.push(`${issue.path}: ${issue.message}`);
  }
  for (const note of notes) {
    noteCount += 1;
    if (noteIds.has(note.id) || ids.has(note.id)) {
      problems.push(`duplicate note id: ${note.id}`);
    }
    noteIds.add(note.id);
    for (const target of note.targets) {
      noteTargets.push({ target, noteId: note.id, file });
    }
    walkRefs(note.body, note.id, file, refs);
  }
}

for (const use of refs.filter((r) => !labels.has(r.target))) {
  problems.push(`unresolved ref target: ${use.file}:${use.blockId} -> "${use.target}"`);
}
for (const target of noteTargets.filter((t) => !labels.has(t.target))) {
  problems.push(`unresolved note target: ${target.file}:${target.noteId} -> "${target.target}"`);
}

const generated = new Set<string>(ALL_LABELS);
const missingInGenerated = [...labels.keys()].filter((label) => !generated.has(label));
const staleInGenerated = [...generated].filter((label) => !labels.has(label));
if (missingInGenerated.length > 0 || staleInGenerated.length > 0) {
  problems.push(
    "labels.generated.ts が content/ の実状と一致していない（npm run gen で再生成する）:\n" +
      `  生成物に無い実在ラベル: ${missingInGenerated.join(", ") || "なし"}\n` +
      `  実在しない生成物のラベル: ${staleInGenerated.join(", ") || "なし"}`,
  );
}

if (problems.length > 0) {
  console.error(`実行時検証で ${problems.length} 件の問題:`);
  for (const problem of problems) console.error(`  - ${problem}`);
  process.exit(1);
}

console.log(
  `validated ${blockCount} blocks from ${contentFiles.length} files ` +
    `(${headingCount} headings, ${labels.size} labels, ${refs.length} refs, ${citeCount} cites, all resolved)`,
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

function collectBlockStrings(block: ConvertedBlock): string[] {
  const strings: string[] = [];
  collectStrings(block.statement ?? [], strings);
  collectStrings(block.proof ?? [], strings);
  const title = block.kind === "figure" ? undefined : block.title;
  if (title !== null && title !== undefined && title.tex !== undefined) {
    strings.push(title.tex);
  }
  return strings;
}

/**
 * 可算／非可算の分別（本プロジェクト固有の検査）。日本語版と同じ規則を英語版にも掛ける。
 * 誤検出を黙らせる正しい直し方は「検査を緩める」ことではなく、habitat を `"mixed"`
 * （または `"R"` / `"C"`）にして realEscape を書くことである。
 */
function checkHabitatConsistency(block: ConvertedBlock, file: string): void {
  if (block.kind === "heading" || block.kind === "figure") return;
  const theoremLike = block as TheoremLikeBlock;
  problems.push(...checkHabitation(theoremLike));
  const habitat: string = theoremLike.habitat;
  if (HABITAT_VALUES.escaping.has(habitat)) {
    escapes.push({ blockId: block.id, habitat, why: theoremLike.realEscape ?? "" });
    return;
  }
  const offending = collectBlockStrings(block).filter((value) =>
    /\\mathbb\{[RC]\}|\\mathbb R\b|\\mathbb C\b|\\R\b|\\C\b|[ℝℂ]/.test(value),
  );
  const first = offending[0];
  if (first !== undefined) {
    problems.push(
      `${file}:${block.id} は可算側の habitat "${habitat}" を宣言しているのに、` +
        `数式に非可算（ℝ/ℂ）が現れている: ${first}`,
    );
  }
}

/** `verification` が指す SageMath 検証ディレクトリの実在確認（型システムは fs を読めない）。 */
function checkLinkageTargets(block: ConvertedBlock, file: string): void {
  if (block.kind === "heading" || block.kind === "figure") return;
  const theoremLike = block as TheoremLikeBlock;
  for (const target of theoremLike.verification ?? []) {
    verificationLinkCount += 1;
    const absolute = join(projectRoot, target);
    if (!existsSync(absolute)) {
      problems.push(
        `${file}:${block.id}.verification が実在しないパスを指している: ${target}` +
          `（プロジェクトルート ${projectRoot} からの相対パスで書く）`,
      );
    }
  }
  leanLinkCount += (theoremLike.lean ?? []).length;
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

function countCites(block: ConvertedBlock): number {
  let count = 0;
  const walk = (nodes: readonly Node[]): void => {
    for (const node of nodes) {
      if (node.type === "cite") count += 1;
      if (node.type === "paragraph") walk(node.children);
      if (node.type === "list") node.items.forEach(walk);
    }
  };
  walk(block.statement ?? []);
  walk(block.proof ?? []);
  return count;
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
