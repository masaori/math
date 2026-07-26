#!/usr/bin/env node
/**
 * 最終成果物（論文・書籍）の生成器。**入力は `content/` だけ**。
 *
 * README 7 節「証明の正本は content/。ここだけから最終成果物を生成する」を実装する。
 * `notes/` は文書本体ではないので、このファイルは `loadNoteFiles` を**呼ばない**
 * （混入していないことは `tools/verify-no-notes-in-output.ts` が機械的に検査する）。
 *
 * 変換規則:
 *   - 文書順 = content のファイル名昇順 × 各ファイルの配列順（＝正準表現をそのまま使う）
 *   - 見出し `level` 1..6 → `\section` / `\subsection` / ... の節構造
 *   - 定理型ブロック → amsthm の環境（definition / claim / theorem / remark / note）
 *   - `proof` → `proof` 環境
 *   - ブロックの `labels` → `\label{lab:<ラベル>}`、`ref()` → `\cref{lab:<ラベル>}`
 *   - `math` → `$...$`、`displayMath` → `\[...\]`（KaTeX 向けの LaTeX 文字列をそのまま渡す）
 *   - `list` → `itemize`、`todo` → 目立つ未完マーカー
 *
 * 使い方:
 *   node tools/build-latex.ts            .tex を生成する
 *   node tools/build-latex.ts --pdf      .tex を生成し tectonic で PDF まで作る
 */

import { spawnSync } from "node:child_process";
import { mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join } from "node:path";

import type { ConvertedBlock, Node, TheoremLikeBlock, TheoremLikeKind } from "../schema.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";

const buildDir = join(structuredLatexDir, "build");
const texPath = join(buildDir, "document.tex");
const pdfPath = join(buildDir, "document.pdf");
const withPdf = process.argv.includes("--pdf");

/** amsthm の環境名と見出し語。定理型 kind と 1 対 1 に対応させる。 */
const THEOREM_ENVIRONMENTS: Record<TheoremLikeKind, { env: string; heading: string }> = {
  definition: { env: "definition", heading: "定義" },
  claim: { env: "claim", heading: "主張" },
  theorem: { env: "theorem", heading: "定理" },
  remark: { env: "remark", heading: "注意" },
  note: { env: "structurednote", heading: "ノート" },
};

/**
 * 見出しの深さ → LaTeX の節コマンド。
 * content の最上位（level 1）は「部」に相当する 1 件だけで、章はすべて level 2 である
 * （原本 Typst の `=` / `==` に対応）。そこで level 1 を `\part`、level 2 を `\section` へ写す。
 * こうすると定理番号が「章番号.通し番号」になり、章より前に置かれたブロックが
 * 0.x 番になる不自然さも消える。
 */
const SECTION_COMMANDS = [
  "part",
  "section",
  "subsection",
  "subsubsection",
  "paragraph",
  "subparagraph",
] as const;

const contentFiles = await loadContentFiles();

// ラベル → ブロック id。相互参照の解決に使う（型でも保証済みだが、生成時にも確かめる）。
const labelOwner = new Map<string, string>();
for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const usedRefs: { target: string; blockId: string }[] = [];
const body: string[] = [];
let blockCount = 0;
let headingCount = 0;
let proofCount = 0;
let todoCount = 0;

for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    blockCount += 1;
    if (block.kind === "heading") {
      headingCount += 1;
      body.push(renderHeading(block));
      continue;
    }
    body.push(renderTheoremLike(block));
  }
}

// 相互参照の解決検査（未解決が 1 件でもあれば生成を中止する）。
const unresolved = usedRefs.filter((use) => !labelOwner.has(use.target));
if (unresolved.length > 0) {
  const detail = unresolved.map((use) => `  ${use.blockId} -> "${use.target}"`).join("\n");
  throw new Error(`未解決の相互参照がある（生成を中止）:\n${detail}`);
}

mkdirSync(buildDir, { recursive: true });
writeFileSync(texPath, renderDocument(body.join("\n\n")), "utf8");

console.log(
  `generated ${texPath}\n` +
    `  ブロック ${blockCount} 件（見出し ${headingCount}、証明 ${proofCount}、TODO ${todoCount}）` +
    ` / ラベル ${labelOwner.size} 件 / 相互参照 ${usedRefs.length} 件（すべて解決）`,
);

if (!withPdf) {
  console.log("  PDF まで作るには --pdf を付ける");
  process.exit(0);
}

// --- PDF ビルド --------------------------------------------------------------
const result = spawnSync("tectonic", ["-X", "compile", "--keep-logs", texPath], {
  cwd: buildDir,
  encoding: "utf8",
  maxBuffer: 64 * 1024 * 1024,
});
if (result.error !== undefined) {
  throw new Error(
    `tectonic を起動できなかった: ${result.error.message}\n  導入: brew install tectonic`,
  );
}
const output = `${result.stdout ?? ""}${result.stderr ?? ""}`;
if (result.status !== 0) {
  writeFileSync(join(buildDir, "tectonic-error.log"), output, "utf8");
  const errorLines = output
    .split("\n")
    .filter((line) => /^error|! |Undefined control sequence|Missing/.test(line))
    .slice(0, 30);
  throw new Error(
    `PDF のビルドに失敗した（詳細: ${join(buildDir, "tectonic-error.log")}）:\n${errorLines.join("\n")}`,
  );
}

// 未解決参照は LaTeX の警告に出る。1 件でもあれば失敗にする。
const undefinedRefs = [...output.matchAll(/Reference `([^']+)' on page/g)].map((m) => m[1]);
if (undefinedRefs.length > 0) {
  throw new Error(`PDF に未解決参照が残っている: ${[...new Set(undefinedRefs)].join(", ")}`);
}

// ページ数は LaTeX のログから取る（PDF のオブジェクトは圧縮されていて数えられない）。
const logText = readFileSync(join(buildDir, "document.log"), "utf8");
const pageMatch = logText.match(/Output written on [^(]+\((\d+) pages?/);
const pageCount = pageMatch?.[1];
if (pageCount === undefined) {
  throw new Error("ビルドログからページ数を取得できなかった（ビルドが途中で終わった可能性）");
}

// 生成物にノートが混入していないことは verify-no-notes-in-output.ts が検査する。
console.log(`built ${pdfPath}: ${pageCount} ページ、未解決参照 0 件`);

// --- レンダリング ------------------------------------------------------------

function renderDocument(inner: string): string {
  return `% 自動生成ファイル — 直接編集しない。
% 生成元: structured-latex/content/（tools/build-latex.ts）
% 再生成: cd structured-latex && npm run build:pdf
\\documentclass[11pt,a4paper]{article}

\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{amsthm}
\\usepackage{mathtools}
\\usepackage[margin=25mm]{geometry}
\\usepackage{xeCJK}
\\setCJKmainfont{Hiragino Mincho ProN}
\\setCJKsansfont{Hiragino Sans}
\\usepackage{hyperref}
\\usepackage[nameinlink]{cleveref}

\\theoremstyle{definition}
\\newtheorem{definition}{定義}[section]
\\newtheorem{claim}[definition]{主張}
\\newtheorem{theorem}[definition]{定理}
\\newtheorem{remark}[definition]{注意}
\\newtheorem{structurednote}[definition]{ノート}

\\crefname{definition}{定義}{定義}
\\crefname{claim}{主張}{主張}
\\crefname{theorem}{定理}{定理}
\\crefname{remark}{注意}{注意}
\\crefname{structurednote}{ノート}{ノート}
\\crefname{section}{節}{節}

\\title{2次元 Ising 模型の厳密解}
\\date{}

\\begin{document}
\\maketitle
\\tableofcontents
\\clearpage

${inner}

\\end{document}
`;
}

function renderHeading(block: ConvertedBlock & { kind: "heading" }): string {
  const command = SECTION_COMMANDS[block.level - 1] ?? "paragraph";
  const title = renderTitle(block.title);
  const labels = block.labels.map((label) => `\\label{lab:${label}}`).join("");
  return `\\${command}{${title}}${labels}`;
}

function renderTheoremLike(block: TheoremLikeBlock): string {
  const { env } = THEOREM_ENVIRONMENTS[block.kind];
  const title = block.title === null || block.title === undefined ? "" : `[${renderTitle(block.title)}]`;
  const anchors = [
    `\\label{blk:${block.id}}`,
    ...block.labels.map((label) => `\\label{lab:${label}}`),
  ].join("");
  const statement = renderNodes(block.statement, block.id);
  const parts = [`\\begin{${env}}${title}${anchors}\n${statement}\n\\end{${env}}`];
  if (block.proof !== undefined && block.proof.length > 0) {
    proofCount += 1;
    parts.push(`\\begin{proof}\n${renderNodes(block.proof, block.id)}\n\\end{proof}`);
  }
  return parts.join("\n\n");
}

function renderTitle(title: { text?: string; tex?: string } | null | undefined): string {
  if (title === null || title === undefined) return "";
  if (title.tex !== undefined) return `$${title.tex}$`;
  return escapeText(title.text ?? "");
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  return nodes.map((node) => renderNode(node, blockId)).join("\n\n");
}

function renderNode(node: Node, blockId: string): string {
  switch (node.type) {
    case "text":
      return escapeText(node.value);
    case "math":
      return `$${node.tex}$`;
    case "displayMath":
      return `\\[\n${node.tex}\n\\]`;
    case "paragraph":
      // 段落の中身は連結する（数式と地の文が交互に並ぶため、間に空行を入れない）。
      return node.children.map((child) => renderInline(child, blockId)).join("");
    case "list": {
      const items = node.items
        .map((item) => `  \\item ${item.map((child) => renderInline(child, blockId)).join("")}`)
        .join("\n");
      return `\\begin{itemize}\n${items}\n\\end{itemize}`;
    }
    case "ref": {
      usedRefs.push({ target: node.target, blockId });
      return `\\cref{lab:${node.target}}`;
    }
    case "todo":
      todoCount += 1;
      return `\\par\\noindent\\textbf{[TODO]}\\ ${escapeText(node.value)}`;
  }
}

/** 段落・リスト項目の内部（改行を挟まない）。 */
function renderInline(node: Node, blockId: string): string {
  if (node.type === "displayMath") return `\n\\[\n${node.tex}\n\\]\n`;
  if (node.type === "list") return `\n${renderNode(node, blockId)}\n`;
  return renderNode(node, blockId);
}

/**
 * 地の文の LaTeX エスケープ。
 * 本文は日本語の散文で、`_` や `%` などが素のまま入りうる（`content/` は KaTeX 前提で
 * 書かれており、地の文のエスケープは想定されていない）。
 */
function escapeText(value: string): string {
  return value
    .replaceAll("\\", "\\textbackslash{}")
    .replaceAll("{", "\\{")
    .replaceAll("}", "\\}")
    .replaceAll("$", "\\$")
    .replaceAll("&", "\\&")
    .replaceAll("%", "\\%")
    .replaceAll("#", "\\#")
    .replaceAll("_", "\\_")
    .replaceAll("~", "\\textasciitilde{}")
    .replaceAll("^", "\\textasciicircum{}");
}
