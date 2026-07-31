/**
 * 地の文に直接書かれた数学記号（ℝ, Λ, ∞ など）を LaTeX へ写す。
 *
 * 本プロジェクトの散文は「ℝ へ脱出した箇所」「Λ の言葉で書く」のように、**Unicode の数学記号を
 * 地の文へ直に書く**のが自然な書き方である（README も企画書もその書き方をしている）。
 * ところが欧文フォントにこれらの字が無いと、PDF から**無言で消える**
 * （実測: ℝ / ℤ / ℚ / μ が Missing character になった）。
 *
 * 対処は 2 通りある。(a) 和文フォントへ回す。(b) 対応する LaTeX の数式へ写す。
 * ここでは (b) を採る。理由は、これらは数学記号であって和文の文字ではなく、
 * 数式として組むほうが本文中の `$\mathbb{R}$` などと**同じ字面になる**ためである
 * （(a) だと同じ ℝ が場所によって別の字体で出る）。
 *
 * この変換は**生成器の中だけ**で行う。`content/` のデータは書き換えない
 * （本文の記法をどう書くかは執筆側の判断であり、生成器の責務ではない）。
 */

/** Unicode の数学記号 → LaTeX。地の文（エスケープ済み）に対して適用する。 */
const UNICODE_MATH: Record<string, string> = {
  "ℝ": "$\\mathbb{R}$",
  "ℂ": "$\\mathbb{C}$",
  "ℤ": "$\\mathbb{Z}$",
  "ℚ": "$\\mathbb{Q}$",
  "ℕ": "$\\mathbb{N}$",
  "Λ": "$\\Lambda$",
  "λ": "$\\lambda$",
  "μ": "$\\mu$",
  "ν": "$\\nu$",
  "π": "$\\pi$",
  "ζ": "$\\zeta$",
  "τ": "$\\tau$",
  "Φ": "$\\Phi$",
  "χ": "$\\chi$",
  "θ": "$\\theta$",
  "Θ": "$\\Theta$",
  "α": "$\\alpha$",
  "β": "$\\beta$",
  "γ": "$\\gamma$",
  "Γ": "$\\Gamma$",
  "δ": "$\\delta$",
  "Δ": "$\\Delta$",
  "ε": "$\\varepsilon$",
  "σ": "$\\sigma$",
  "Σ": "$\\Sigma$",
  "ρ": "$\\rho$",
  "ξ": "$\\xi$",
  "ψ": "$\\psi$",
  "ω": "$\\omega$",
  "Ω": "$\\Omega$",
  "κ": "$\\kappa$",
  "η": "$\\eta$",
  "∞": "$\\infty$",
  "→": "$\\to$",
  "≥": "$\\geq$",
  "≤": "$\\leq$",
  "≠": "$\\neq$",
  "×": "$\\times$",
  "∈": "$\\in$",
  "⊂": "$\\subset$",
  "∣": "$\\mid$",
  "§": "\\S{}",
  "–": "--",
  "—": "---",
};

/**
 * 合成（基底文字 + 結合文字）で書かれる記号。**単字の置換より先に処理する。**
 *
 * `ℚ̄`（U+211A + U+0304）は ℚ とは別の住処（代数的閉包）を表す。結合マクロンを
 * 単に捨てると **ℚ̄ が ℚ に化けて意味が変わる**（実測でそうなっていた）。
 */
const COMBINED_MATH: readonly (readonly [string, string])[] = [
  ["ℚ\u0304", "$\\overline{\\mathbb{Q}}$"],
  ["ℝ\u0304", "$\\overline{\\mathbb{R}}$"],
  ["ℂ\u0304", "$\\overline{\\mathbb{C}}$"],
  ["𝔽\u0304", "$\\overline{\\mathbb{F}}$"],
];

const PATTERN = new RegExp(`[${Object.keys(UNICODE_MATH).join("")}]`, "g");

/**
 * 対応表に無い結合文字。これが残ると PDF から無言で消えるので、**呼び出し側で落とす**ための検出。
 * 結合文字（U+0300–U+036F）は単体では組めない。
 */
const UNHANDLED_COMBINING = /[\u0300-\u036f]/;

/**
 * 数式（`math` / `displayMath` の tex）の中に現れる、欧文数式フォントに無い記号。
 *
 * 本文の記号として ★ が数式内で使われている（例: `(★_2)`）。`\newunicodechar` は
 * 数式モードのこの位置では効かず、PDF から**無言で消える**（実測: Missing character U+2605）。
 * プリアンブルで定義した `\jpstar`（和文フォントの箱）へ置き換える。
 */
const MATH_UNICODE: Record<string, string> = {
  "★": "\\jpstar{}",
};

const MATH_PATTERN = new RegExp(`[${Object.keys(MATH_UNICODE).join("")}]`, "g");

/** 数式文字列に対する変換。地の文用の `unicodeMathToLatex` とは別（数式の中身は translate しない）。 */
export function mathUnicodeToLatex(tex: string): string {
  return tex.replace(MATH_PATTERN, (char) => MATH_UNICODE[char] ?? char);
}

export function unicodeMathToLatex(value: string): string {
  let result = value;
  for (const [from, to] of COMBINED_MATH) {
    result = result.replaceAll(from, to);
  }
  result = result.replace(PATTERN, (char) => UNICODE_MATH[char] ?? char);
  if (UNHANDLED_COMBINING.test(result)) {
    throw new Error(
      `地の文に対応表の無い結合文字がある（PDF から無言で消える）: ${result.slice(0, 60)}\n` +
        "  → tools/unicode-math.ts の COMBINED_MATH に追加するか、本文の書き方を変えること",
    );
  }
  return result;
}
