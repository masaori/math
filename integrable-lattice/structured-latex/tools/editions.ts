/**
 * **版（edition）ごとの組版設定**。ロケール 1 つにつき 1 つ。
 *
 * cycle 24 step 2 まで、英語版は `structured-latex-en/tools/build-latex.ts` という
 * **生成器そのものの複製**を持っていた（644 行。日本語版 459 行の写しに手を入れたもの）。
 * 複製された生成器は、日本語版へ入れた検査（未解決参照・組めない文字・版面外の行）が
 * 片方にだけ入る状態を作る。実際、英語版にだけ「未定義の引用キー」「対応の取れない `**`」の
 * 検査があり、日本語版には無かった。
 *
 * そこで生成器は 1 本にし、**言語で変わるものだけ**をこのファイルへ集めた。
 * ここに書くのは「その版の LaTeX がどう見えるか」であって、検査の有無ではない。
 * 検査は `build-latex.ts` が全版に同じものを掛ける（書誌の検査だけは、書誌を出す版にのみ効く）。
 */

import { readFileSync } from "node:fs";

import type { TheoremLikeKind } from "../schema.ts";
import { frontmatter as englishFrontmatter } from "../locales/en/frontmatter.ts";

export type EditionContext = {
  /** 本文（ブロック列を組んだもの）。 */
  inner: string;
  /** 地の文 1 つ分の描画（エスケープ・記号変換・強調をこの版の規則で通す）。 */
  renderProse: (value: string, blockId: string) => string;
  /** LaTeX の特殊文字のエスケープだけ（記号変換も強調も掛けない）。 */
  escape: (value: string) => string;
  /** ノード列の描画（要旨のように本文以外の場所で使う）。 */
  renderNodes: (nodes: readonly never[], blockId: string) => string;
  /** 引用が 1 件も無いか（過渡措置の `\nocite{*}` の判断に使う）。 */
  hasNoCitations: boolean;
  /** 導出した書誌ファイルの名前（拡張子なし）。 */
  bibSpecifier: string;
};

export type Edition = {
  locale: string;
  /** 生成物の置き場（`structured-latex/build/` からの相対。原文は直下）。 */
  buildSubdir: string;
  /** amsthm の環境名と見出し語。 */
  theorem: Record<TheoremLikeKind, { env: string; heading: string }>;
  /** `habitat` の値 → 本文に出す表記。 */
  habitatLabels: Record<string, string>;
  /** 可算側の住処に添える但し書き（`none` には付けない）。 */
  countableQualifier: string;
  /** ℝ 脱出の枠の見出し。 */
  escapeHeading: (habitat: string) => string;
  /** 住処の行の見出し（`[住処: …]` の左側）。 */
  habitatLead: string;
  /** 住処の行を囲む括弧（和文は全角、欧文は半角）。 */
  habitatBrackets: readonly [string, string];
  /** 数式中の ★ の落とし先マクロ（版によって使えるフォントが違う）。 */
  starMacro: string;
  /** `cite` ノードを出力できるか。できない版に渡されたら生成器が落とす。 */
  citations: null | {
    /** 書誌の正本（`structured-latex/` からの相対）。 */
    bibPath: readonly string[];
    /** 導出物の名前（拡張子なし）。 */
    derivedName: string;
  };
  /** 文書全体の骨格。 */
  renderDocument: (context: EditionContext) => string;
};

// --- 日本語版（原文。内部で読むための版）------------------------------------

const JAPANESE_THEOREMS: Record<TheoremLikeKind, { env: string; heading: string }> = {
  definition: { env: "definition", heading: "定義" },
  claim: { env: "claim", heading: "主張" },
  theorem: { env: "theorem", heading: "定理" },
  remark: { env: "remark", heading: "注意" },
  note: { env: "structurednote", heading: "ノート" },
};

const japanese: Edition = {
  locale: "ja",
  buildSubdir: "",
  theorem: JAPANESE_THEOREMS,
  habitatLabels: {
    N: "$\\mathbb{N}$",
    Z: "$\\mathbb{Z}$",
    Q: "$\\mathbb{Q}$",
    Lambda: "$\\Lambda$",
    Qbar: "$\\overline{\\mathbb{Q}}$",
    none: "数量を扱わない",
    R: "$\\mathbb{R}$",
    C: "$\\mathbb{C}$",
    mixed: "可算と非可算の混在",
  },
  countableQualifier: "（可算。$\\mathbb{R}$ を使わない）",
  habitatLead: "住処: ",
  habitatBrackets: ["［", "］"],
  escapeHeading: (habitat) => `\\small\\textbf{$\\mathbb{R}$ 脱出}（住処: ${habitat}）: `,
  starMacro: "\\jpstar{}",
  citations: null,
  renderDocument: ({ inner }) => `% 自動生成ファイル — 直接編集しない。
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
`,
};

// --- 英語版（Expositiones Mathematicae 投稿稿）-------------------------------

const ENGLISH_THEOREMS: Record<TheoremLikeKind, { env: string; heading: string }> = {
  definition: { env: "definition", heading: "Definition" },
  claim: { env: "claim", heading: "Claim" },
  theorem: { env: "theorem", heading: "Theorem" },
  remark: { env: "remark", heading: "Remark" },
  note: { env: "structurednote", heading: "Note" },
};

const english: Edition = {
  locale: "en",
  buildSubdir: "en",
  theorem: ENGLISH_THEOREMS,
  habitatLabels: {
    N: "$\\mathbb{N}$",
    Z: "$\\mathbb{Z}$",
    Q: "$\\mathbb{Q}$",
    Lambda: "$\\Lambda$",
    Qbar: "$\\overline{\\mathbb{Q}}$",
    none: "no quantities",
    R: "$\\mathbb{R}$",
    C: "$\\mathbb{C}$",
    mixed: "countable and uncountable mixed",
  },
  countableQualifier: " (countable; no use of $\\mathbb{R}$)",
  habitatLead: "Habitat: ",
  habitatBrackets: ["[", "]"],
  escapeHeading: (habitat) => `\\small\\textbf{Escape to $\\mathbb{R}$} (habitat: ${habitat}): `,
  starMacro: "\\starmark{}",
  citations: {
    bibPath: ["..", "outputs", "papers", "001_R_Lambda_duality", "refs.bib"],
    derivedName: "refs.generated",
  },
  renderDocument: ({ inner, escape, renderNodes, hasNoCitations, bibSpecifier }) => {
    const authors = englishFrontmatter.authors
      .map((author) => {
        const lines = [escape(author.name)];
        if (author.affiliation !== undefined) lines.push(escape(author.affiliation));
        if (author.email !== undefined) lines.push(`\\texttt{${escape(author.email)}}`);
        return lines.join(" \\\\ ");
      })
      .join(" \\and ");
    const abstract = renderNodes(englishFrontmatter.abstract as readonly never[], "(abstract)");
    const keywords = englishFrontmatter.keywords.map((word) => escape(word)).join(", ");
    const msc = [
      `Primary ${englishFrontmatter.msc2020.primary.map((code) => escape(code)).join(", ")}`,
      ...(englishFrontmatter.msc2020.secondary.length > 0
        ? [`Secondary ${englishFrontmatter.msc2020.secondary.map((code) => escape(code)).join(", ")}`]
        : []),
    ].join("; ");
    // 引用が 1 件も無い間だけ .bib 全件を出す（生成器側の警告と対）。
    const nocite = hasNoCitations ? "\\nocite{*}\n" : "";

    return `% Generated file -- do not edit by hand.
% Source: structured-latex/locales/en/content/ and locales/en/frontmatter.ts (tools/build-latex.ts)
% Regenerate: cd structured-latex && npm run build:pdf:en
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
% the generator rewrites U+2605 inside math into this macro (tools/editions.ts).
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
\\newtheorem{definition}{${ENGLISH_THEOREMS.definition.heading}}[section]
\\newtheorem{claim}[definition]{${ENGLISH_THEOREMS.claim.heading}}
\\newtheorem{theorem}[definition]{${ENGLISH_THEOREMS.theorem.heading}}
\\newtheorem{remark}[definition]{${ENGLISH_THEOREMS.remark.heading}}
\\newtheorem{structurednote}[definition]{${ENGLISH_THEOREMS.note.heading}}

\\crefname{definition}{Definition}{Definitions}
\\crefname{claim}{Claim}{Claims}
\\crefname{theorem}{Theorem}{Theorems}
\\crefname{remark}{Remark}{Remarks}
\\crefname{structurednote}{Note}{Notes}
\\crefname{section}{Section}{Sections}

\\title{${escape(englishFrontmatter.title)}}
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
  },
};

export const EDITIONS: Readonly<Record<string, Edition>> = { ja: japanese, en: english };

export const editionFor = (locale: string): Edition => {
  const edition = EDITIONS[locale];
  if (edition === undefined) {
    throw new Error(
      `ロケール ${locale} の組版設定が tools/editions.ts に無い` +
        `（locales.config.ts に足したら、ここにも版を足すこと）`,
    );
  }
  return edition;
};

/**
 * `note = {...}` を波括弧の対応を数えて取り除く（正規表現では入れ子の括弧を扱えない）。
 * 取り除くのは `note` だけで、他のフィールドには一切触れない。
 */
export const stripNoteFields = (source: string): { text: string; removed: number } => {
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
};

/** `.bib` に実在するキー。未定義引用を生成前に見つけるために生成器が読む。 */
export const bibKeysOf = (source: string): Set<string> =>
  new Set([...source.matchAll(/^@\w+\{\s*([^,\s]+)\s*,/gm)].map((match) => match[1] ?? ""));

export const readBib = (path: string): string => readFileSync(path, "utf8");
