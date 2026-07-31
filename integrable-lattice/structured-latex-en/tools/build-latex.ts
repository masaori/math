#!/usr/bin/env node
/**
 * 英語版（Expositiones Mathematicae 投稿稿）の生成器。**入力は `content/` と `frontmatter.ts` だけ**。
 *
 * 日本語版 `../structured-latex/tools/build-latex.ts` を土台にして、次を変えてある。
 *
 *   1. **xeCJK と和文フォント指定を外した**（英語のみなので不要）。
 *      日本語版が和文フォントで組んでいた ★ は pifont の `\ding{72}` へ落とす（`\starmark`）。
 *   2. 定理環境の見出し語・`cleveref` の名前・住処の枠の文言を**英語**にした。
 *   3. **フロントマター**（表題・著者・要旨・キーワード・MSC 2020）を出す。中身は
 *      `../frontmatter.ts` から読む（後続の担当者が本文と独立に書けるようにするため）。
 *   4. **参考文献**を BibTeX で出す。`cite` ノードを `\cite[note]{keys}` へ落とし、
 *      未定義の引用キーが 1 件でもあればビルドを落とす。
 *   5. 目次（`\tableofcontents`）を**出さない**。理由は下の `renderDocument` のコメント。
 *   6. 地の文の `**強調**`（本文の書き方）を `\textbf{...}` へ落とす。理由は下の `applyBold`。
 *
 * **日本語版から引き継いだ検査は 1 つも落としていない**:
 *   未解決参照 0 件 / ラベル重複 0 件 / 組めない文字 0 件 / 版面外へ出た行 0 件 / ページ数の取得。
 *   これに「未定義の引用キー 0 件」と「対応の取れない `**` 0 件」を足してある。
 *
 * 使い方:
 *   node tools/build-latex.ts            .tex を生成する
 *   node tools/build-latex.ts --pdf      .tex を生成し tectonic で PDF まで作る
 */

import { spawnSync } from "node:child_process";
import { existsSync, mkdirSync, readFileSync, writeFileSync } from "node:fs";
import { join, relative } from "node:path";

import { frontmatter } from "../frontmatter.ts";
import type { HeadingBlock, Node, TheoremLikeBlock } from "../schema.ts";
import type { TheoremLikeKind } from "../schema.ts";
import { loadContentFiles, structuredLatexDir } from "./content-modules.ts";
// 地の文のエスケープと Unicode 数学記号の変換は言語に依存しない。日本語版のものを使う（複製しない）。
import { escapeText } from "../../structured-latex/tools/latex-escape.ts";
import { unicodeMathToLatex } from "../../structured-latex/tools/unicode-math.ts";
import { mathUnicodeToLatex } from "./math-unicode.ts";

const buildDir = join(structuredLatexDir, "build");
const texPath = join(buildDir, "document.tex");
const pdfPath = join(buildDir, "document.pdf");
const withPdf = process.argv.includes("--pdf");

/**
 * 参考文献データベース。**書誌の正本は 1 つだけである**
 * （`integrable-lattice/outputs/papers/001_R_Lambda_duality/refs.bib`）。
 * リポジトリへ複製は作らない。ここで作るのは、その 1 つの正本から**ビルド時に導出する**
 * gitignore 済みの中間物 `build/refs.generated.bib` だけである。
 *
 * なぜ素通しでなく導出が要るか（実測に基づく）:
 *   正本の各エントリは `note` フィールドに**日本語の来歴メモ**（「本文 pp.1--8 で確認済み」等）を
 *   持っている。これはプロジェクト内部の記録であって、投稿稿に出してよいものではない。
 *   加えて `plain.bst` は `note` を印字するので、欧文フォントに無い和字が
 *   **無言で消えた状態**の参考文献リストが出来る（実測: Missing character が 200 件超）。
 *   したがって `note` を落としてから BibTeX へ渡す。**落とすのは note だけで、書誌は変えない。**
 */
const bibPath = join(
  structuredLatexDir,
  "..",
  "outputs",
  "papers",
  "001_R_Lambda_duality",
  "refs.bib",
);
if (!existsSync(bibPath)) {
  throw new Error(`参考文献データベースが無い: ${bibPath}`);
}
const bibSource = readFileSync(bibPath, "utf8");
/** `.bib` に実在するキー（未定義引用を生成前に見つけるため、生成器側でも読む）。 */
const bibKeys = new Set(
  [...bibSource.matchAll(/^@\w+\{\s*([^,\s]+)\s*,/gm)].map((m) => m[1] ?? ""),
);
const derivedBibName = "refs.generated";
const bibSpecifier = derivedBibName;

/**
 * `note = {...}` を波括弧の対応を数えて取り除く（正規表現では入れ子の括弧を扱えない）。
 * 取り除くのは `note` だけで、他のフィールドには一切触れない。
 */
function stripNoteFields(source: string): { text: string; removed: number } {
  const out: string[] = [];
  let index = 0;
  let removed = 0;
  const fieldStart = /(,\s*)note\s*=\s*\{/gi;
  for (;;) {
    fieldStart.lastIndex = index;
    const match = fieldStart.exec(source);
    if (match === null) break;
    const openAt = match.index + match[0].length - 1;
    let depth = 0;
    let cursor = openAt;
    for (; cursor < source.length; cursor += 1) {
      const char = source[cursor];
      if (char === "{") depth += 1;
      else if (char === "}") {
        depth -= 1;
        if (depth === 0) break;
      }
    }
    if (depth !== 0) {
      throw new Error(`refs.bib の note フィールドで波括弧が閉じていない（位置 ${match.index}）`);
    }
    out.push(source.slice(index, match.index));
    index = cursor + 1;
    removed += 1;
  }
  out.push(source.slice(index));
  return { text: out.join(""), removed };
}

/** amsthm の環境名と見出し語。定理型 kind と 1 対 1 に対応させる。 */
const THEOREM_ENVIRONMENTS: Record<TheoremLikeKind, { env: string; heading: string }> = {
  definition: { env: "definition", heading: "Definition" },
  claim: { env: "claim", heading: "Claim" },
  theorem: { env: "theorem", heading: "Theorem" },
  remark: { env: "remark", heading: "Remark" },
  note: { env: "structurednote", heading: "Note" },
};

/** 見出しの深さ → LaTeX の節コマンド（日本語版と同じ。level 1 が章）。 */
const SECTION_COMMANDS = [
  "section",
  "subsection",
  "subsubsection",
  "paragraph",
  "subparagraph",
  "subparagraph",
] as const;

/** `habitat` の値 → 本文に出す表記（英語）。 */
const HABITAT_LABELS: Record<string, string> = {
  N: "$\\mathbb{N}$",
  Z: "$\\mathbb{Z}$",
  Q: "$\\mathbb{Q}$",
  Lambda: "$\\Lambda$",
  Qbar: "$\\overline{\\mathbb{Q}}$",
  none: "no quantities",
  R: "$\\mathbb{R}$",
  C: "$\\mathbb{C}$",
  mixed: "countable and uncountable mixed",
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
const usedCites: { key: string; blockId: string }[] = [];
const suspiciousTexts: { blockId: string; sample: string }[] = [];
const unmatchedBold: { blockId: string; sample: string }[] = [];
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

// 引用キーの実在検査（.bib に無いキーは PDF で [?] になる。生成前に落とす）。
const unknownCites = usedCites.filter((use) => !bibKeys.has(use.key));
if (unknownCites.length > 0) {
  const detail = unknownCites.map((use) => `  ${use.blockId} -> "${use.key}"`).join("\n");
  throw new Error(
    `${relative(structuredLatexDir, bibPath)} に無い引用キーがある（生成を中止）:\n${detail}`,
  );
}

// 対応の取れない `**` は PDF に素のアスタリスクとして出る（投稿稿では明白な瑕疵）。
if (unmatchedBold.length > 0) {
  const detail = unmatchedBold
    .map((item) => `  ${item.blockId}: ${item.sample}`)
    .join("\n");
  throw new Error(
    `対応の取れない ** が地の文にある（PDF にアスタリスクがそのまま出る）:\n${detail}\n` +
      "  強調は 1 つのノードの中で閉じること（ノードをまたぐ ** は組めない）。",
  );
}

mkdirSync(buildDir, { recursive: true });

// 書誌の導出（正本 refs.bib は読むだけ。書き込みは build/ の中だけ）。
const stripped = stripNoteFields(bibSource);
// 正本の `%` 行はプロジェクト内部の日本語コメントである（BibTeX はエントリ外を無視するので
// 出力には影響しないが、導出物に残しても意味が無いので落とす）。
const derivedBib = stripped.text
  .split("\n")
  .filter((line) => !/^\s*%/.test(line))
  .join("\n");
// 落とし残しがあると和字が無言で消えるので、残った非 ASCII は 1 件でも通さない。
const leftover = [...new Set([...derivedBib].filter((char) => char.charCodeAt(0) > 0x7f))];
if (leftover.length > 0) {
  throw new Error(
    `note を落とした後の書誌に非 ASCII 文字が残っている（欧文フォントで無言で消える）: ${leftover.join(" ")}\n` +
      `  対処: ${relative(structuredLatexDir, bibPath)} の該当箇所を LaTeX の記法へ直すこと。`,
  );
}
writeFileSync(
  join(buildDir, `${derivedBibName}.bib`),
  `% 自動生成ファイル — 直接編集しない。\n` +
    `% 正本: ${relative(buildDir, bibPath)}（note フィールドと %% コメントだけを落としてある）\n` +
    derivedBib,
  "utf8",
);

writeFileSync(texPath, renderDocument(body.join("\n\n")), "utf8");

if (suspiciousTexts.length > 0) {
  console.warn(
    `警告: 地の文に数式記法らしき文字がある ${suspiciousTexts.length} 件` +
      "（そのままの文字として組まれる。math ノードにするか記法を直すこと）:",
  );
  for (const item of suspiciousTexts.slice(0, 10)) {
    console.warn(`  ${item.blockId}: ${item.sample}`);
  }
}

if (usedCites.length === 0) {
  // 引用が 1 件も無いと BibTeX は参考文献リストを作らない（"I found no \citation commands"）。
  // 本文の翻訳が済むまでの**過渡的な状態**なので、`\nocite{*}` で .bib 全件を出し、
  // BibTeX 経路が実際に通ることを毎回のビルドで確かめられるようにしてある。
  // 引用が 1 件でも入れば自動的に通常の挙動（引用したものだけ）へ戻る。
  console.warn(
    `警告: cite ノードが 1 件も無い。過渡措置として \\nocite{*} で ${bibKeys.size} 件すべてを出力する` +
      "（本文が引用を持てば自動的に引用分だけになる）。",
  );
}

console.log(
  `generated ${texPath}\n` +
    `  ブロック ${blockCount} 件（見出し ${headingCount}、証明 ${proofCount}、TODO ${todoCount}）` +
    ` / ラベル ${labelOwner.size} 件 / 相互参照 ${usedRefs.length} 件（すべて解決）` +
    ` / 引用 ${usedCites.length} 件（.bib のキー ${bibKeys.size} 件、すべて実在）`,
);

if (!withPdf) {
  console.log("  PDF まで作るには --pdf を付ける");
  process.exit(0);
}

// --- PDF ビルド --------------------------------------------------------------
const result = spawnSync("tectonic", ["-X", "compile", "--keep-logs", "--keep-intermediates", texPath], {
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
const logText = readFileSync(join(buildDir, "document.log"), "utf8");

// 1. 未解決参照。
const undefinedRefs = [
  ...logText.matchAll(/Reference `([^']+)' on page [^ ]+ undefined/g),
].map((m) => m[1]);
if (undefinedRefs.length > 0) {
  throw new Error(`PDF に未解決参照が残っている: ${[...new Set(undefinedRefs)].join(", ")}`);
}

// 2. 未定義の引用。生成前のキー実在検査（上）を通っても、BibTeX の実行が失敗すれば
//    参考文献が丸ごと落ちる。**ログを見るのはその経路を塞ぐため**。
const undefinedCites = [
  ...logText.matchAll(/Citation `([^']+)' on page [^ ]+ undefined/g),
].map((m) => m[1]);
if (undefinedCites.length > 0) {
  throw new Error(`PDF に未定義の引用がある: ${[...new Set(undefinedCites)].join(", ")}`);
}
const blgPath = join(buildDir, "document.blg");
if (existsSync(blgPath)) {
  const blg = readFileSync(blgPath, "utf8");
  const bibErrors = blg
    .split("\n")
    .filter((line) => /^Warning--I didn't find a database entry|^I couldn't open|error message/.test(line));
  if (bibErrors.length > 0) {
    throw new Error(`BibTeX が書誌を解決できなかった:\n${bibErrors.slice(0, 20).join("\n")}`);
  }
}
// 参考文献が実際に組まれたこと。BibTeX が走らなければ .bbl は空か生成されない
// （その場合、参考文献リストだけが無言で欠けた PDF ができる）。
const bblPath = join(buildDir, "document.bbl");
const bblText = existsSync(bblPath) ? readFileSync(bblPath, "utf8") : "";
const bibitemCount = [...bblText.matchAll(/\\bibitem/g)].length;
if (bibitemCount === 0) {
  throw new Error(
    `参考文献が組まれなかった（${bblPath} に \\bibitem が無い）。\n` +
      "  BibTeX が走っていないか、.bib を解決できていない。",
  );
}

// 3. ラベルの重複（参照先が一意に決まらなくなる）。
if (/There were multiply-defined labels/.test(logText)) {
  const duplicated = [...logText.matchAll(/Label `([^']+)' multiply defined/g)].map((m) => m[1]);
  throw new Error(`PDF にラベルの重複がある: ${[...new Set(duplicated)].join(", ")}`);
}

// 4. フォントに無い文字は**無言で消える**ので、1 件でも許さない。
const missingChars = [
  ...new Set([...logText.matchAll(/Missing character: There is no (.) /g)].map((m) => m[1])),
];
if (missingChars.length > 0) {
  throw new Error(
    `PDF に組めない文字がある（出力から無言で消える）: ${missingChars.join(" ")}\n` +
      "  対処: tools/math-unicode.ts（数式中）または日本語版 tools/unicode-math.ts（地の文）の\n" +
      "        対応表へ追加するか、本文の書き方を変える。",
  );
}

// 5. 版面をはみ出した行。
const RIGHT_MARGIN_PT = 71; // 25mm ≒ 71pt
const overfull = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)]
  .map((m) => Number(m[1]))
  .filter((width) => width > RIGHT_MARGIN_PT);
if (overfull.length > 0) {
  throw new Error(
    `版面から出て内容が切れている行が ${overfull.length} 件ある` +
      `（最大 ${Math.max(...overfull).toFixed(1)}pt 超過）。\n` +
      `  詳細: ${join(buildDir, "document.log")} の Overfull \\hbox`,
  );
}

const pageMatch = logText.match(/Output written on [^(]+\((\d+) pages?/);
const pageCount = pageMatch?.[1];
if (pageCount === undefined) {
  throw new Error("ビルドログからページ数を取得できなかった（ビルドが途中で終わった可能性）");
}

const overfullAll = [...logText.matchAll(/Overfull \\hbox \(([0-9.]+)pt too wide\)/g)].length;
console.log(
  `built ${pdfPath}: ${pageCount} ページ、未解決参照 0 件、未定義引用 0 件、組めない文字 0 件、` +
    `版面外へ出た行 0 件（軽微な overfull ${overfullAll} 件は余白内）、` +
    `参考文献 ${bibitemCount} 件`,
);

// --- レンダリング ------------------------------------------------------------

function renderDocument(inner: string): string {
  const authors = frontmatter.authors
    .map((author) => {
      const lines = [escapeText(author.name)];
      if (author.affiliation !== undefined) lines.push(escapeText(author.affiliation));
      if (author.email !== undefined) lines.push(`\\texttt{${escapeText(author.email)}}`);
      return lines.join(" \\\\ ");
    })
    .join(" \\and ");
  const abstract = renderNodes(frontmatter.abstract, "(abstract)");
  const keywords = frontmatter.keywords.map((word) => escapeText(word)).join(", ");
  const msc = [
    `Primary ${frontmatter.msc2020.primary.map((code) => escapeText(code)).join(", ")}`,
    ...(frontmatter.msc2020.secondary.length > 0
      ? [`Secondary ${frontmatter.msc2020.secondary.map((code) => escapeText(code)).join(", ")}`]
      : []),
  ].join("; ");
  // 引用が 1 件も無い間だけ .bib 全件を出す（上の警告と対）。
  const nocite = usedCites.length === 0 ? "\\nocite{*}\n" : "";

  return `% Generated file -- do not edit by hand.
% Source: structured-latex-en/content/ and structured-latex-en/frontmatter.ts (tools/build-latex.ts)
% Regenerate: cd structured-latex-en && npm run build:pdf
\\documentclass[11pt,a4paper]{article}

\\usepackage{amsmath}
\\usepackage{amssymb}
\\usepackage{amsthm}
\\usepackage[margin=25mm]{geometry}
\\usepackage{graphicx}
% Long monospaced strings (paths, identifiers) must be breakable at separators: url's \\path.
\\usepackage{url}
\\urlstyle{tt}
% The mark U+2605 (used in the text to flag the passage to real analysis). This document loads no
% CJK font, so it is set with Zapf Dingbats. Without this it would vanish silently from the PDF;
% the generator rewrites U+2605 inside math into this macro (tools/math-unicode.ts).
\\usepackage{pifont}
\\newcommand{\\starmark}{\\text{\\ding{72}}}
\\usepackage[hidelinks]{hyperref}
\\usepackage[nameinlink]{cleveref}

% Shrink displayed equations that are wider than the text block, by exactly the overflow.
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
\\newtheorem{definition}{${THEOREM_ENVIRONMENTS.definition.heading}}[section]
\\newtheorem{claim}[definition]{${THEOREM_ENVIRONMENTS.claim.heading}}
\\newtheorem{theorem}[definition]{${THEOREM_ENVIRONMENTS.theorem.heading}}
\\newtheorem{remark}[definition]{${THEOREM_ENVIRONMENTS.remark.heading}}
\\newtheorem{structurednote}[definition]{${THEOREM_ENVIRONMENTS.note.heading}}

\\crefname{definition}{Definition}{Definitions}
\\crefname{claim}{Claim}{Claims}
\\crefname{theorem}{Theorem}{Theorems}
\\crefname{remark}{Remark}{Remarks}
\\crefname{structurednote}{Note}{Notes}
\\crefname{section}{Section}{Sections}

\\title{${escapeText(frontmatter.title)}}
\\author{${authors}}
\\date{}

\\begin{document}
\\maketitle

\\begin{abstract}
${abstract}
\\end{abstract}

\\noindent\\textbf{Keywords.} ${keywords}

\\noindent\\textbf{Mathematics Subject Classification (2020).} ${msc}

\\bigskip

% No table of contents. This is a manuscript for submission to Expositiones Mathematicae; the
% table of contents is decided by the publisher's typesetting, not supplied by the author.
% (The Japanese version does print one, because it is a reading copy for internal use.)

${inner}

${nocite}\\bibliographystyle{plain}
\\bibliography{${bibSpecifier}}

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
 * （リポジトリ直下 CLAUDE.md / integrable-lattice README）。**投稿稿でもこの表示は落とさない。**
 * 文言だけを英語の散文にする（読者は日本語を読まないため）。
 */
function renderHabitat(block: TheoremLikeBlock): string {
  const habitat = HABITAT_LABELS[block.habitat];
  if (block.realEscape === undefined) {
    const qualifier =
      block.habitat === "none" ? "" : " (countable; no use of $\\mathbb{R}$)";
    return `\\par\\smallskip\\noindent{\\small[Habitat: ${habitat}${qualifier}]}`;
  }
  return (
    `\\par\\smallskip\\noindent\\fbox{\\parbox{\\dimexpr\\linewidth-2\\fboxsep-2\\fboxrule}{%
` +
    `\\small\\textbf{Escape to $\\mathbb{R}$} (habitat: ${habitat}): ` +
    `${renderProse(block.realEscape, block.id)}}}`
  );
}

function renderTheoremLike(block: TheoremLikeBlock): string {
  const { env } = THEOREM_ENVIRONMENTS[block.kind];
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
  if (/[\^_`]/.test(text)) suspiciousTexts.push({ blockId, sample: text.slice(0, 60) });
  return renderProse(text, blockId);
}

/**
 * 地の文 1 つ分。エスケープ → Unicode 数学記号の変換 → 強調の順で写す。
 * 順序を入れ替えてはならない（エスケープ前に `\textbf` を入れると `\` が潰れる）。
 */
function renderProse(value: string, blockId: string): string {
  return applyBold(unicodeMathToLatex(escapeText(value)), blockId);
}

/**
 * 本文は強調を `**...**` と書く（日本語版 content からの書き方をそのまま引き継いでいる）。
 * LaTeX は `*` を素の文字として組むので、**変換しないと投稿稿にアスタリスクがそのまま出る**
 * （日本語版の PDF では実際にそうなっている。ここで直す）。
 * 対応の取れない `**` は無言で通さず、呼び出し側でビルドを落とす。
 */
function applyBold(value: string, blockId: string): string {
  const converted = value.replace(/\*\*(.+?)\*\*/gs, (_match, inner: string) => `\\textbf{${inner}}`);
  if (converted.includes("**")) {
    unmatchedBold.push({ blockId, sample: converted.slice(0, 60) });
  }
  return converted;
}

function renderNodes(nodes: readonly Node[], blockId: string): string {
  // 別行立て数式の直後に続く地の文は、同じ文の続きであることが多い。
  // 空行で連結すると LaTeX が新段落として字下げしてしまうので `\noindent` を付ける。
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
      return renderProse(node.value, blockId);
    case "math":
      return renderInlineMath(node.tex);
    case "displayMath":
      return renderDisplayMath(node.tex);
    case "paragraph":
      return node.children.map((child) => renderInline(child, blockId)).join("");
    case "list": {
      const items = node.items
        .map((item) => `  \\item ${item.map((child) => renderInline(child, blockId)).join("")}`)
        .join("\n");
      return `\\begin{itemize}\n${items}\n\\end{itemize}`;
    }
    case "ref": {
      usedRefs.push({ target: node.target, blockId });
      if (node.label !== undefined) {
        return `\\hyperref[lab:${node.target}]{${escapeText(node.label)}}`;
      }
      return `\\cref{lab:${node.target}}`;
    }
    case "cite": {
      for (const key of node.keys) usedCites.push({ key, blockId });
      const note = node.note === undefined ? "" : `[${renderProse(node.note, blockId)}]`;
      return `\\cite${note}{${node.keys.join(",")}}`;
    }
    case "todo":
      todoCount += 1;
      return `\\par\\noindent\\textbf{[TODO]}\\ ${renderProse(node.value, blockId)}`;
    case "image":
      throw new Error(`画像ノード（${node.assetKey}）の LaTeX 出力は未実装: ${blockId}`);
  }
}

/**
 * 行内数式。中身が `\texttt{...}` だけのもの（ファイルパスや識別子の表記）は、数式の箱になると
 * どこでも改行できず版面から出るので、`\path{...}` で組む（日本語版と同じ規則）。
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

/** 別行立て数式。`\tag` は箱の中では使えないので、その場合だけ素の `equation*` で組む。 */
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
