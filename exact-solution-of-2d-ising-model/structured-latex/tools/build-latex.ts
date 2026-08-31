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
 * **入力言語のうち、この出力器がまだ対応していない語彙**（図表ブロック `figure` と画像ノード
 * `image`。いずれもこのプロジェクトの content には 1 件も無い）は、黙って落とさず**明示的に
 * エラーにする**。網羅性の穴を無音にすると、後から図表を書いたときに出力から消えるため。
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

/**
 * 和文フォント。既定は macOS のヒラギノ（手元の作業環境）。
 * Linux（GitHub Actions の ubuntu-latest）にはヒラギノが無く、指定したフォントが
 * 見つからないと xeCJK/fontspec がエラーで止まるため、環境変数で差し替えられるようにする。
 * CI では fonts-noto-cjk の "Noto Serif CJK JP" / "Noto Sans CJK JP" を渡す。
 */
const cjkMainFont = process.env.ISING_PDF_CJK_MAIN_FONT ?? "Hiragino Mincho ProN";
const cjkSansFont = process.env.ISING_PDF_CJK_SANS_FONT ?? "Hiragino Sans";

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
      throw new Error(
        `図表ブロックは、この出力器がまだ対応していない: ${block.id}\n` +
          "  対応するまで content/ に figure を置かないこと（黙って出力から落とさないため）。",
      );
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
\\usepackage{xeCJK}
\\setCJKmainfont{${cjkMainFont}}
\\setCJKsansfont{${cjkSansFont}}
% 欧文フォントに無い記号（★ = 実数解析への移行点の印、′ = 章 C' のプライム）は
% 和文フォント側で組む。指定が無いと**無言で消える**（実測: Missing character 3 件）。
\\xeCJKDeclareCharClass{CJK}{"2605, "2032, "2033}
\\usepackage[hidelinks]{hyperref}
\\usepackage[nameinlink]{cleveref}

% 見出し語を日本語にする。
\\renewcommand{\\contentsname}{目次}
\\renewcommand{\\partname}{部}
\\renewcommand{\\proofname}{証明}

% 数式の中からブロックを引く（HTML 側 build-html.ts と同じ記法。lambda 側と同一の定義）
\\newcommand{\\blkref}[1]{\\text{\\cref{lab:#1}}}

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

function renderHeading(block: HeadingBlock): string {
  const command = SECTION_COMMANDS[block.level - 1] ?? "paragraph";
  const title = renderTitle(block.title, block.id);
  const labels = block.labels.map((label) => `\\label{lab:${label}}`).join("");
  return `\\${command}{${title}}${labels}`;
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
  const parts = [`\\begin{${env}}${title}${anchors}\n${statement}\n\\end{${env}}`];
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
  return escapeText(text);
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
      return escapeText(node.value);
    case "math":
      return `$${node.tex}$`;
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
    case "cite":
      // 引用ノードは入力言語の語彙にあるが、この文書は参考文献リストを持たない
      // （証明は自足しており、外部文献に依存しない）。素通しすると引用が無音で消えるので落とす。
      throw new Error(
        `引用ノードは、この出力器がまだ対応していない: ${blockId} の ${node.keys.join(", ")}\n` +
          "  この文書は .bib を持たない。対応するまで content/ に cite を置かないこと。",
      );
    case "todo":
      todoCount += 1;
      return `\\par\\noindent\\textbf{[TODO]}\\ ${escapeText(node.value)}`;
    case "image":
      // 画像ノードは入力言語の語彙にあるが、この出力器はまだ資産解決器を持たない。
      // 素通しすると図が無音で消えるので、明示的に落とす。
      throw new Error(
        `画像ノードは、この出力器がまだ対応していない: ${blockId} の ${node.assetKey}\n` +
          "  対応するまで content/ に image を置かないこと。",
      );
  }
}

/**
 * 別行立て数式。既定では幅を測って必要なら縮める `\fitdisplay` を通す。
 * ただし `\tag` は箱の中では使えない（amsmath: "\tag not allowed here"）ので、
 * その 1 件だけは素の `equation*` で組む。
 */
function renderDisplayMath(tex: string): string {
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
