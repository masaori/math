#!/usr/bin/env node
/**
 * 構造化テキストの実行時検証。
 *
 * 型検査（`tsc -p tsconfig.json --noEmit`）と役割を分ける:
 *   - コンパイル時に落ちるもの（存在しないラベルへの ref / targets、id・ラベルの重複、
 *     kind ごとのフィールド、住処と realEscape の対応 ほか）は、システム（リポジトリ直下
 *     `structured-latex/`）が持つ入力言語の型と、このプロジェクトの `schema.ts` が担当する。
 *     ここでの再検査は、型を経由せずに値が作られる経路（動的生成・`as` による回避）への保険。
 *   - 型では表現できないものはこのスクリプトだけが検出できる:
 *       1. 可算な住処を宣言したブロックの数式に ℝ/ℂ が現れていないこと（本プロジェクトの核）
 *       2. `verification` が指す SageMath 検証ディレクトリの実在（型システムは fs を読めない）
 *       3. 未変換の Typst 記法の混入
 *       4. 生成済みラベル一覧と content の実状の一致
 *       5. 角括弧の区間記法が母集合の添字を持つこと
 *
 * 使い方: node structured-latex/tools/validate-content.ts
 */

import { existsSync } from "node:fs";
import { join } from "node:path";

import { ALL_LABELS } from "../labels.generated.ts";
import { HABITAT_VALUES, checkHabitation, runtimeSchema } from "../schema.ts";
import type { ConvertedBlock, Node, ValidationIssue } from "../schema.ts";
import { loadContentFiles, loadNoteFiles, structuredLatexDir } from "./content-modules.ts";

type RefUse = { target: string; blockId: string; file: string };

/** プロジェクトルート（`verification` のパスはここからの相対で書かれる）。 */
const projectRoot = join(structuredLatexDir, "..");

/**
 * 実行時検証の指摘は 1 件目で止めずに全件集める（受け取り側が一度で直せるように、という
 * システム側の方針に合わせる）。集め終わってから、あれば 1 度だけ落とす。
 */
const schemaIssues: ValidationIssue[] = [];
const projectIssues: string[] = [];

const ids = new Set<string>();
const labels = new Map<string, string>();
// ref 解決チェック用に、全ブロックの ref を一旦集約してから（ラベルは後続ファイルで
// 定義されうるため）全ラベル確定後に target を検証する。
const refs: RefUse[] = [];
let blockCount = 0;
let headingCount = 0;

/**
 * 走査範囲そのものの回帰検査。**タイトルの数式が走査から外れたら、その場で落とす。**
 *
 * この検査は現在の本文では一件も掛からない（`title.tex` を使うブロックが今は無い）。
 * 掛からない検査は静かに壊れるので、合成ブロックで走査範囲を毎回確かめる。
 * `publishedMathOf` を `bodyNodesOf` へ戻す変更は、ここで終了コード 1 になる。
 *
 * 文字列が拾えたことではなく、**実際の検査規則が掛かること**を確かめる。
 * 走査範囲だけを比べると、規則の側が緩んだときに素通りする。
 */
{
  const probe = {
    id: "probe_published_math_scope",
    kind: "claim",
    title: { tex: String.raw`\mathbb{R}\ [a,b]` },
    labels: [],
    habitat: "finite",
    statement: [],
  } as unknown as ConvertedBlock;
  const before = projectIssues.length;
  checkProjectRules(probe, "(走査範囲の回帰検査)");
  const raised = projectIssues.splice(before).join("\n");
  if (!raised.includes("ℝ/ℂ が現れる") || !raised.includes("母集合の添字が無い")) {
    throw new Error(
      "走査範囲の回帰検査が失敗した: タイトルの数式に ℝ と添字なし区間を置いても検査が掛からない" +
        `（報告: ${raised || "なし"}）`,
    );
  }

  const headingProbe = {
    id: "probe_heading_published_math_scope",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`[a,b]` },
    labels: [],
  } as unknown as ConvertedBlock;
  const beforeHeading = projectIssues.length;
  checkProjectRules(headingProbe, "(見出し走査範囲の回帰検査)");
  const headingRaised = projectIssues.splice(beforeHeading).join("\n");
  if (!headingRaised.includes("母集合の添字が無い")) {
    throw new Error(
      "見出し走査範囲の回帰検査が失敗した: 見出しタイトルの数式に添字なし区間を置いても検査が掛からない" +
        `（報告: ${headingRaised || "なし"}）`,
    );
  }

  // `\blkref` の実在確認も同じ走査範囲でなければならない。定理型のタイトルと見出しの
  // タイトルの両方から拾えることを毎回確かめる（現在の本文に `title.tex` は無いので、
  // 確かめないとこの経路は静かに壊れる）。
  for (const kind of ["claim", "heading"] as const) {
    const refProbe = {
      id: `probe_blkref_scope_${kind}`,
      kind,
      level: 2,
      title: { tex: String.raw`\blkref{probe_target_label}` },
      labels: [],
      habitat: kind === "claim" ? "finite" : undefined,
      statement: [],
    } as unknown as ConvertedBlock;
    const collected: RefUse[] = [];
    collectBlockRefsInMath(refProbe, "(blkref 走査範囲の回帰検査)", collected);
    if (!collected.some((use) => use.target === "probe_target_label")) {
      throw new Error(
        "blkref 走査範囲の回帰検査が失敗した: " +
          `${kind} のタイトルの数式に置いた \\blkref が実在確認へ渡らない`,
      );
    }
  }
}

const contentFiles = await loadContentFiles();

for (const { file, blocks } of contentFiles) {
  for (const block of blocks) {
    const parsed = runtimeSchema.validateBlock(block, file);
    if (!parsed.success) schemaIssues.push(...parsed.error);
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
    checkProjectRules(block, file);
    collectRefTargets(block, file, refs);
    collectBlockRefsInMath(block, file, refs);
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
  const parsed = runtimeSchema.validateNotes(notes, file);
  if (!parsed.success) schemaIssues.push(...parsed.error);
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

if (schemaIssues.length > 0) {
  const detail = schemaIssues.map((issue) => `  ${issue.path}: ${issue.message}`);
  throw new Error(`入力言語の実行時検証に失敗した ${schemaIssues.length} 件:\n${detail.join("\n")}`);
}

if (projectIssues.length > 0) {
  throw new Error(
    `本プロジェクト固有の検証に失敗した ${projectIssues.length} 件:\n${projectIssues
      .map((issue) => `  ${issue}`)
      .join("\n")}`,
  );
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

// 生成済みラベル一覧（型の土台）と実状の一致。ここがずれていると、
// 型検査が通っても実在しないラベルを許してしまう / 実在するラベルを拒んでしまう。
const generated = new Set<string>(ALL_LABELS);
const missingInGenerated = [...labels.keys()].filter((label) => !generated.has(label));
const staleInGenerated = [...generated].filter((label) => !labels.has(label));
if (missingInGenerated.length > 0 || staleInGenerated.length > 0) {
  throw new Error(
    "labels.generated.ts が content/ の実状と一致していない（npm run gen で再生成する）:\n" +
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

/**
 * ブロックが持つノード列（種別ごとに置き場所が違う）。
 * 種別を足したらここが型エラーになるので、走査から漏れたまま気づかない状態にならない。
 */
function bodyNodesOf(block: ConvertedBlock): readonly (readonly Node[])[] {
  if (block.kind === "heading") return [];
  if (block.kind === "figure") return [block.content, block.caption ?? []];
  return [block.statement, block.proof ?? []];
}

/**
 * ブロックが出版本文へ出す数式のすべて。**この一本を通してだけ数式を走査する。**
 *
 * 本文ノード（statement / proof、図は content / caption）に加えて、**タイトルの数式**を含む。
 * タイトルは `{ tex: ... }` の形を取れて、`tools/build-latex.ts` の `renderTitle` が
 * `$...$` として出版本文へ出す。ところが住処と区間記法の検査は `bodyNodesOf` だけを見ており、
 * タイトルの数式を一度も読んでいなかった。同じファイルの Typst 記法の検査は既に
 * `title.tex` を読んでいるため、二つの検査で走査範囲が食い違っていた。
 *
 * 実測: `habitat: "finite"` を宣言したブロックのタイトルを
 * `{ tex: String.raw`\mathbb{R}\ \text{smuggled}\ [a,b]` }` に差し替えると、
 * 可算宣言の裏取り（ℝ/ℂ 非出現）も母集合の添字の要求も一件も報告せず、
 * 一覧を再生成したうえで `npm run check` が終了コード 0 で通った。
 * ℝ が出版本文の見出し行へ出るのに、可算で閉じているという宣言は無傷で残る。
 *
 * 図は住処を持たない（本プロジェクト固有メタデータは定理型だけに付く）ため、
 * ℝ/ℂ の検査は掛けようがない。しかし母集合の添字は住処に依らない記法の規律なので、
 * 図の数式にも掛ける。
 */
function publishedMathOf(block: ConvertedBlock): string[] {
  const math: string[] = [];
  for (const nodes of bodyNodesOf(block)) collectMathStrings(nodes, math);
  if (block.kind !== "figure") {
    const title = block.title;
    if (title !== null && title !== undefined && title.tex !== undefined) math.push(title.tex);
  }
  return math;
}

/**
 * 本プロジェクト固有の検査。
 *
 *   1. 住処と realEscape の対応（型を迂回した値のための保険）
 *   2. 可算な住処を宣言したブロックの数式に ℝ/ℂ の記号が現れていないこと
 *   3. `verification` が指す SageMath 検証ディレクトリの実在
 *   4. 角括弧の区間記法が `_{\mathbb{N}}` 等の母集合を明示すること
 *
 * 2 が本プロジェクトの核である。「可算で閉じている」という宣言が本当かを、
 * 宣言した本人の言葉ではなく数式の字面で検査する。
 *
 * 走査する数式は `publishedMathOf` の一本に閉じる。ここを `bodyNodesOf` へ戻すと、
 * タイトルの数式が再び無検査になる。
 */
function checkProjectRules(block: ConvertedBlock, file: string): void {
  const math = publishedMathOf(block);
  // 母集合の添字は住処に依らない記法の規律なので、住処を持たない図にも掛ける。
  const ambiguousInterval = math.find((value) =>
    /\[[^\]\n,]+,[^\]\n]+\](?!_\{\\mathbb\{(?:N|Z|Q|R|C)\}\})/.test(value),
  );
  if (ambiguousInterval !== undefined) {
    projectIssues.push(
      `${file}:${block.id} の角括弧区間に母集合の添字が無い: ${ambiguousInterval}\n` +
        "    → 自然数区間なら [a,b]_{\\mathbb{N}} のように、記号だけで母集合が分かる形にする。",
    );
  }

  // ここから下は本プロジェクト固有メタデータ（住処・検証対応）を持つ定理型だけの検査。
  // 見出しと図はそのメタデータを持たないので、型の上でも掛けようがない。
  if (block.kind === "heading" || block.kind === "figure") return;

  for (const issue of checkHabitation(block)) {
    projectIssues.push(`${file}: ${issue}`);
  }

  const habitat: unknown = block.habitat;
  if (typeof habitat === "string" && HABITAT_VALUES.countable.has(habitat) && habitat !== "none") {
    // ℝ/ℂ そのものを指す記号だけを見る。可算側のブロックがこれらを数式に書いているなら、
    // 住処の宣言か証明のどちらかが誤っている。
    // 「ℝ を使わない」と本文で述べる文脈は地の文（text ノード）に書けるので、
    // 検査対象は数式（本文ノードの数式とタイトルの数式）だけにしてある。
    const offending = math.filter((value) =>
      /\\mathbb\{(R|C)\}|\\mathbf\{(R|C)\}|\\Re\b|\\Im\b/.test(value),
    );
    const first = offending[0];
    if (first !== undefined) {
      projectIssues.push(
        `${file}:${block.id} は可算な住処 "${habitat}" を宣言しているのに数式に ℝ/ℂ が現れる: ${first}\n` +
          '    → 実際に ℝ/ℂ を使っているなら habitat を "R" / "C" / "mixed" にし、realEscape を書く。\n' +
          "    → 使っていないなら数式から ℝ/ℂ の記号を除く（地の文で言及するのは可）。",
      );
    }
  }

  const verification: unknown = block.verification;
  if (Array.isArray(verification)) {
    for (const path of verification) {
      if (typeof path !== "string") continue;
      if (!existsSync(join(projectRoot, path))) {
        projectIssues.push(
          `${file}:${block.id}.verification が指す検証ディレクトリが無い: ${path}`,
        );
      }
    }
  }
}

function collectMathStrings(nodes: readonly Node[], out: string[]): void {
  for (const node of nodes) {
    if (node.type === "math" || node.type === "displayMath") out.push(node.tex);
    if (node.type === "paragraph") collectMathStrings(node.children, out);
    if (node.type === "list") node.items.forEach((item) => collectMathStrings(item, out));
  }
}

function scanForTypstMath(block: ConvertedBlock, file: string): void {
  const strings: string[] = [];
  for (const nodes of bodyNodesOf(block)) collectStrings(nodes, strings);
  const title = block.kind === "figure" ? null : block.title;
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

/**
 * 数式の中からブロックを引く命令 `\blkref{<ラベル>}` を集める。
 *
 * ラベル参照ノード（`ref`）は数式の中に置けないので、式変形の根拠 `(∵ …)` からブロックを
 * 番号で引くために `\blkref` を用意している（LaTeX 側で `\cref` に展開される）。
 * 型では中身が文字列なので検査できない。**ここで実在するラベルかを確かめる**
 * （確かめないと、ラベルを改名したときに参照が黙って壊れる）。
 *
 * 走査は `publishedMathOf` の一本を通す。ここを `bodyNodesOf` へ戻すと、**タイトルの数式に
 * 書いた `\blkref` が実在確認から外れる**。実測: ある定理型ブロックのタイトルを
 * `{ tex: String.raw`\blkref{no_such_label_smuggled}` }` に差し替え、一覧を再生成すると、
 * `npm run check` は「相互参照 1732 件、すべて解決」と報告して終了コード 0 で通った。
 * 壊れた参照は tectonic が組んだ後の LaTeX ログ（`Reference ... undefined`）でしか出ず、
 * 速い層は全て素通りする。
 */
function collectBlockRefsInMath(block: ConvertedBlock, file: string, out: RefUse[]): void {
  for (const tex of publishedMathOf(block)) {
    for (const match of tex.matchAll(/\\blkref\{([^}]*)\}/g)) {
      out.push({ target: match[1] ?? "", blockId: block.id, file });
    }
  }
}

function collectRefTargets(block: ConvertedBlock, file: string, out: RefUse[]): void {
  for (const nodes of bodyNodesOf(block)) walkRefs(nodes, block.id, file, out);
}

function walkRefs(nodes: readonly Node[], blockId: string, file: string, out: RefUse[]): void {
  for (const node of nodes) {
    if (node.type === "ref") out.push({ target: node.target, blockId, file });
    if (node.type === "paragraph") walkRefs(node.children, blockId, file, out);
    if (node.type === "list") node.items.forEach((item) => walkRefs(item, blockId, file, out));
  }
}
