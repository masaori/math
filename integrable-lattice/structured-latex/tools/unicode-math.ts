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
  // 結合文字のマクロン（ℚ̄ のような合成）。単体では組めないので上線として扱う。
  "̄": "",
};

const PATTERN = new RegExp(`[${Object.keys(UNICODE_MATH).join("")}]`, "g");

export function unicodeMathToLatex(value: string): string {
  return value.replace(PATTERN, (char) => UNICODE_MATH[char] ?? char);
}
