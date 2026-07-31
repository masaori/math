#!/usr/bin/env node
/**
 * 最終成果物（論文）の生成器。**入力は `content/` だけ**。
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

import type { HeadingBlock, Node, TheoremLikeBlock, TheoremLikeKind } from "../schema.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";
import { escapeText } from "./latex-escape.ts";
import { mathUnicodeToLatex, unicodeMathToLatex } from "./unicode-math.ts";

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
 * 複製元（Ising 側）は level 1 を `\part` へ写すが、**本プロジェクトでは level 1 が章**である
 * （部に相当する層を持たない）。そのため level 1 を `\section` から始める。
 */
const SECTION_COMMANDS = [
  "section",
  "subsection",
  "subsubsection",
  "paragraph",
  "subparagraph",
  "subparagraph",
] as const;


/** `habitat` の値 → 本文に出す表記。 */
const HABITAT_LABELS: Record<string, string> = {
  N: "$\\mathbb{N}$",
  Z: "$\\mathbb{Z}$",
  Q: "$\\mathbb{Q}$",
  Lambda: "$\\Lambda$",
  Qbar: "$\\overline{\\mathbb{Q}}$",
  none: "数量を扱わない",
  R: "$\\mathbb{R}$",
  C: "$\\mathbb{C}$",
  mixed: "可算と非可算の混在",
};

const contentFiles = await loadContentFiles();

// ラベル → ブロック id。相互参照の解決に使う（型でも保証済みだが、生成時にも確かめる）。
const labelOwner = new Map<string, string>();
for (const { blocks } of contentFiles) {
  for (const block of blocks) {
    for (const label of block.labels) labelOwner.set(label, block.id);
  }
}

const usedRefs: { target: string; blockId: string }[] = [];
const suspiciousTexts: { blockId: string; sample: string }[] = [];
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
    if (block.kind === "figure") {
      // 図表はシステムの語彙には在るが、本論文はまだ 1 件も使っていない。
      // 使い始めたときに「黙って出力から消える」ことがないよう、ここで明示的に落とす。
      throw new Error(`図表ブロック（${block.id}）の LaTeX 出力は未実装`);
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

// 地の文に「数式のつもりの記法」が混じっていると、そのまま素の文字として組まれる
// （例: text ノードの "2^M" は上付きにならない）。content 側の判断材料として警告する。
if (suspiciousTexts.length > 0) {
  console.warn(
    `警告: 地の文に数式記法らしき文字がある ${suspiciousTexts.length} 件` +
      "（そのままの文字として組まれる。math ノードにするか記法を直すこと）:",
  );
  for (const item of suspiciousTexts.slice(0, 10)) {
    console.warn(`  ${item.blockId}: ${item.sample}`);
  }
}

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

// LaTeX の警告は **stdout ではなくログファイル**にしか出ない（tectonic は要約しか出さない）。
// 実測: `\cref{lab:missing}` を含む文書でも tectonic の終了コードは 0、stdout に警告は無い。
const logText = readFileSync(join(buildDir, "document.log"), "utf8");

// 1. 未解決参照。
const undefinedRefs = [
  ...logText.matchAll(/Reference `([^']+)' on page [^ ]+ undefined/g),
].map((m) => m[1]);
if (undefinedRefs.length > 0) {
  throw new Error(`PDF に未解決参照が残っている: ${[...new Set(undefinedRefs)].join(", ")}`);
}

// 2. ラベルの重複（参照先が一意に決まらなくなる）。
if (/There were multiply-defined labels/.test(logText)) {
  const duplicated = [...logText.matchAll(/Label `([^']+)' multiply defined/g)].map((m) => m[1]);
  throw new Error(`PDF にラベルの重複がある: ${[...new Set(duplicated)].join(", ")}`);
}

// 3. フォントに無い文字は**無言で消える**ので、1 件でも許さない。
const missingChars = [...new Set([...logText.matchAll(/Missing character: There is no (.) /g)].map((m) => m[1]))];
if (missingChars.length > 0) {
  throw new Error(
    `PDF に組めない文字がある（出力から無言で消える）: ${missingChars.join(" ")}\n` +
      "  対処: プリアンブルの xeCJKDeclareCharClass にコードポイントを追加する",
  );
}

// 4. 版面をはみ出した行。右余白（geometry の margin）を超えると紙の外へ出て内容が読めなくなる。
const RIGHT_MARGIN_PT = 71; // 25mm ≒ 71pt
const overfull = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)]
  .map((m) => Number(m[1]))
  .filter((width) => width > RIGHT_MARGIN_PT);
if (overfull.length > 0) {
  throw new Error(
    `版面から出て内容が切れている行が ${overfull.length} 件ある` +
      `（最大 ${Math.max(...overfull).toFixed(1)}pt 超過）。\n` +
      "  別行立て数式は fitdisplay が自動で縮めるので、残るのは地の文か行内数式。\n" +
      `  詳細: ${join(buildDir, "document.log")} の Overfull \\hbox`,
  );
}

const pageMatch = logText.match(/Output written on [^(]+\((\d+) pages?/);
const pageCount = pageMatch?.[1];
if (pageCount === undefined) {
  throw new Error("ビルドログからページ数を取得できなかった（ビルドが途中で終わった可能性）");
}

// 生成物にノートが混入していないことは verify-no-notes-in-output.ts が検査する。
const overfullAll = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)].length;
console.log(
  `built ${pdfPath}: ${pageCount} ページ、未解決参照 0 件、組めない文字 0 件、` +
    `版面外へ出た行 0 件（軽微な overfull ${overfullAll} 件は余白内）`,
);

// --- レンダリング ------------------------------------------------------------

function renderDocument(inner: string): string {
  return `% 自動生成ファイル — 直接編集しない。
% 生成元: structured-latex/content/（tools/build-latex.ts）
% 再生成: cd structured-latex && npm run build:pdf
\\documentclass[11pt,a4paper]{article}

\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{amsthm}
\\usepackage[margin=25mm]{geometry}
\\usepackage{graphicx}
% パス・識別子のような長い等幅文字列を、区切りで改行できるようにする（url パッケージの \\path）。
\\usepackage{url}
\\urlstyle{tt}
\\usepackage{xeCJK}
\\setCJKmainfont{Hiragino Mincho ProN}
\\setCJKsansfont{Hiragino Sans}
% 欧文フォントに無い記号（★ = 実数解析への移行点の印、′ = 章 C' のプライム）は
% 和文フォント側で組む。指定が無いと**無言で消える**（実測: Missing character 3 件）。
\\xeCJKDeclareCharClass{CJK}{"2605, "2032, "2033, "21D2}
% 上の文字クラス指定は**本文モードにしか効かない**。この文書では ★ が数式の中にも現れるので
% （本文の記号として (★_2) のように使われている）、数式用に和文フォントの箱を用意し、
% 生成器が数式中の ★ をこれへ置き換える（tools/unicode-math.ts）。
% 用意しないと PDF から無言で消える（実測: Missing character U+2605）。
\\newcommand{\\jpstar}{\\mbox{\\CJKfontspec{Hiragino Sans}\\char"2605}}
\\usepackage[hidelinks]{hyperref}
\\usepackage[nameinlink]{cleveref}

% 見出し語を日本語にする。
\\renewcommand{\\contentsname}{目次}
\\renewcommand{\\partname}{部}
\\renewcommand{\\proofname}{証明}

% 版面より広い別行立て数式を、はみ出す分だけ自動で縮める。
% 縮めないと紙の外へ出て**内容が読めなくなる**（実測で 22 箇所）。
\\newsavebox{\\displaymathbox}
\\newlength{\\displaymathwidth}
\\newcommand{\\fitdisplay}[1]{%
  \\sbox{\\displaymathbox}{\\ensuremath{\\displaystyle #1}}%
  \\setlength{\\displaymathwidth}{\\wd\\displaymathbox}%
  \\ifdim\\displaymathwidth>\\linewidth
    \\begin{equation*}\\resizebox{\\linewidth}{!}{\\usebox{\\displaymathbox}}\\end{equation*}%
  \\else
    \\begin{equation*}#1\\end{equation*}%
  \\fi
}

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

\\title{$\\mathbb{R}/\\Lambda$ 双対 — 整数スペクトル曲線の二素点と $\\Lambda$ 側の決定可能性}
\\date{}

\\begin{document}
\\maketitle
\\tableofcontents
\\clearpage

${inner}

\\end{document}
`;
}

function renderHeading(block: HeadingBlock): string {
  const command = SECTION_COMMANDS[block.level - 1] ?? "paragraph";
  const title = renderTitle(block.title, block.id);
  const labels = block.labels.map((label) => `\\label{lab:${label}}`).join("");
  return `\\${command}{${title}}${labels}`;
}

/**
 * 住処（`habitat`）と ℝ 脱出（`realEscape`）の表示。
 *
 * 本プロジェクトの中核要求は「可算と非可算を分別し、**ℝ へ脱出した箇所を必ず明示する**」
 * （リポジトリ直下 CLAUDE.md / integrable-lattice README）。データとして持っているだけでは
 * 読者に伝わらないので、**最終成果物にも印字する**。可算側は住処だけを小さく添え、
 * 非可算側は脱出の理由を枠付きで目立たせる。
 */
function renderHabitat(block: TheoremLikeBlock): string {
  const habitat = HABITAT_LABELS[block.habitat];
  if (block.realEscape === undefined) {
    // `none`（数量を扱わないブロック）に「可算」と付けると意味が通らない。
    const qualifier = block.habitat === "none" ? "" : "（可算。$\\mathbb{R}$ を使わない）";
    return `\\par\\smallskip\\noindent{\\small［住処: ${habitat}${qualifier}］}`;
  }
  return (
    `\\par\\smallskip\\noindent\\fbox{\\parbox{\\dimexpr\\linewidth-2\\fboxsep-2\\fboxrule}{%
` +
    `\\small\\textbf{$\\mathbb{R}$ 脱出}（住処: ${habitat}）: ${unicodeMathToLatex(escapeText(block.realEscape))}}}`
  );
}


function renderTheoremLike(block: TheoremLikeBlock): string {
  const { env } = THEOREM_ENVIRONMENTS[block.kind];
  // `]` を含むタイトル（例: `\arg^{[0,2\pi)}`）で引数が途中で切れないよう波括弧で包む。
  const title =
    block.title === null || block.title === undefined
      ? ""
      : `[{${renderTitle(block.title, block.id)}}]`;
  const anchors = [
    `\\label{blk:${block.id}}`,
    ...block.labels.map((label) => `\\label{lab:${label}}`),
  ].join("");
  const statement = renderNodes(block.statement, block.id);
  const parts = [
    `\\begin{${env}}${title}${anchors}\n${statement}\n${renderHabitat(block)}\n\\end{${env}}`,
  ];
  if (block.proof !== undefined && block.proof.length > 0) {
    proofCount += 1;
    parts.push(`\\begin{proof}\n${renderNodes(block.proof, block.id)}\n\\end{proof}`);
  }
  return parts.join("\n\n");
}

function renderTitle(
  title: { text?: string; tex?: string } | null | undefined,
  blockId = "(title)",
): string {
  if (title === null || title === undefined) return "";
  if (title.tex !== undefined) return `$${title.tex}$`;
  const text = title.text ?? "";
  // 地の文と同じく、数式記法らしき文字は素の文字として組まれてしまう
  // （実測: タイトルの "2^M" が上付きにならない）。
  if (/[\^_`]/.test(text)) suspiciousTexts.push({ blockId, sample: text.slice(0, 60) });
  return unicodeMathToLatex(escapeText(text));
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  // 別行立て数式の直後に続く地の文は、同じ文の続きであることが多い。
  // 空行で連結すると LaTeX が新段落として字下げしてしまうので `\noindent` を付ける
  // （日本語の数学組版の通例に合わせる）。
  return nodes
    .map((node, index) => {
      const rendered = renderNode(node, blockId);
      const previous = nodes[index - 1];
      const continuesAfterDisplay =
        previous?.type === "displayMath" && (node.type === "text" || node.type === "paragraph");
      return continuesAfterDisplay ? `\\noindent ${rendered}` : rendered;
    })
    .join("\n\n");
}

function renderNode(node: Node, blockId: string): string {
  switch (node.type) {
    case "text":
      if (/[\^_`]/.test(node.value)) {
        suspiciousTexts.push({ blockId, sample: node.value.slice(0, 60) });
      }
      return unicodeMathToLatex(escapeText(node.value));
    case "math":
      return renderInlineMath(node.tex);
    case "displayMath":
      return renderDisplayMath(node.tex);
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
      // `label` は参照の表示テキストを上書きする任意フィールド（現在 content では未使用）。
      // 指定があれば、その文字列をリンクにする。
      if (node.label !== undefined) {
        return `\\hyperref[lab:${node.target}]{${escapeText(node.label)}}`;
      }
      return `\\cref{lab:${node.target}}`;
    }
    case "todo":
      todoCount += 1;
      return `\\par\\noindent\\textbf{[TODO]}\\ ${unicodeMathToLatex(escapeText(node.value))}`;
    case "image":
      // 図版はシステムの語彙には在るが、本論文はまだ 1 件も使っていない
      // （資産の解決規則を決めていない）。黙って消さず、使い始めたら落ちるようにしておく。
      throw new Error(`画像ノード（${node.assetKey}）の LaTeX 出力は未実装: ${blockId}`);
  }
}

/**
 * 行内数式。
 *
 * 中身が `\texttt{...}` だけのもの（ファイルパスや識別子の表記）は、数式の箱になると
 * **どこでも改行できず版面から出る**（実測: パス 1 個で 93pt はみ出した）。
 * この場合だけ `\path{...}` で組み、区切り文字で改行できるようにする。
 */
function renderInlineMath(rawTex: string): string {
  const tex = mathUnicodeToLatex(rawTex);
  const textOnly = tex.match(/^\\texttt\{([^{}]*)\}$/);
  const inner = textOnly?.[1];
  if (inner !== undefined) {
    return `\\path{${inner}}`;
  }
  return `$${tex}$`;
}

/**
 * 別行立て数式。既定では幅を測って必要なら縮める `\fitdisplay` を通す。
 * ただし `\tag` は箱の中では使えない（amsmath: "\tag not allowed here"）ので、
 * その 1 件だけは素の `equation*` で組む。
 */
function renderDisplayMath(rawTex: string): string {
  const tex = mathUnicodeToLatex(rawTex);
  if (tex.includes("\\tag")) {
    return `\\begin{equation*}\n${tex}\n\\end{equation*}`;
  }
  return `\\fitdisplay{%\n${tex}%\n}`;
}

/** 段落・リスト項目の内部（改行を挟まない）。 */
function renderInline(node: Node, blockId: string): string {
  if (node.type === "displayMath") return `\n${renderDisplayMath(node.tex)}\n`;
  if (node.type === "list") return `\n${renderNode(node, blockId)}\n`;
  return renderNode(node, blockId);
}
