/**
 * 地の文の LaTeX エスケープ。
 *
 * 生成器（`build-latex.ts`）と、ノート混入検査（`verify-no-notes-in-output.ts`）の両方が使う。
 * 検査側は「エスケープ後の形」でも照合する必要があるため、規則を 1 か所に置く
 * （生成器から import すると生成器の本体処理まで走ってしまうので、別モジュールにしてある）。
 */

/** 地の文で LaTeX の特殊文字として扱われる文字と、その置き換え。 */
const TEXT_ESCAPES: Record<string, string> = {
  "\\": "\\textbackslash{}",
  "{": "\\{",
  "}": "\\}",
  $: "\\$",
  "&": "\\&",
  "%": "\\%",
  "#": "\\#",
  _: "\\_",
  "~": "\\textasciitilde{}",
  "^": "\\textasciicircum{}",
};

export function escapeText(value: string): string {
  // 1 パスで置換する。順に replaceAll すると、先に入れた `\textbackslash{}` の波括弧を
  // 後段が再エスケープしてしまう（実測: "a\\b" → "a\textbackslash\{\}b"）。
  return value.replace(/[\\{}$&%#_~^]/g, (char) => TEXT_ESCAPES[char] ?? char);
}
