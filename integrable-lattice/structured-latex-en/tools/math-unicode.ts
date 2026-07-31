/**
 * 数式（`math` / `displayMath` の tex）の中に現れる、欧文数式フォントに無い記号の変換。
 *
 * **地の文の変換（ℝ → `$\mathbb{R}$` 等）は言語に依存しないので、日本語版の
 * `../../structured-latex/tools/unicode-math.ts` をそのまま import して使う（複製しない）。**
 * こちらに別実装を置いたのは、数式中の ★ の落とし先だけが言語に依存するためである。
 *
 * 日本語版は ★ を和文フォントの箱（`\jpstar` = Hiragino Sans の U+2605）で組む。
 * 英語版は xeCJK も和文フォントも読み込まないので、その箱を作れない。
 * 代わりに pifont の `\ding{72}`（Zapf Dingbats の黒星）へ落とす。
 * どちらにせよ、置き換え忘れると PDF から**無言で消える**（Missing character 検査で担保する）。
 */

/** 数式中の記号 → 英語版プリアンブルが定義するマクロ。 */
const MATH_UNICODE: Record<string, string> = {
  "★": "\\starmark{}",
};

const MATH_PATTERN = new RegExp(`[${Object.keys(MATH_UNICODE).join("")}]`, "g");

export function mathUnicodeToLatex(tex: string): string {
  return tex.replace(MATH_PATTERN, (char) => MATH_UNICODE[char] ?? char);
}
