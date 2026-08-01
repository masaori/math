/**
 * 日英対応検証（`verify-ja-en-correspondence.ts`）で、**数式の差を許すブロック**の表。
 *
 * 数式（`math` / `displayMath` の `tex`）は翻訳の対象ではない。日英で数式がずれていたら、
 * それは訳し落としか、断りなく数学を書き換えたかのどちらかである。だから既定は「一致必須」とする。
 *
 * **cycle 22 で形を変えた（理由は重要なので必ず読むこと）。**
 * 以前この表は「ブロック id → 理由の文字列」で、**登録するとそのブロックの数式照合が丸ごと免除された**。
 * cycle 21 step 4 は、登録済みのブロックで英語版のインライン数式を **11 個落としたのに検証を通過**した。
 * 事故報告（`outputs/reports/cycle21_ops_reflect_to_paper.md` §6.1）は
 * 「例外表への登録は検査の穴を開ける操作である、という認識が薄かった」と書いている。
 *
 * そこで免除の単位を**差分 1 つ**へ落とした。ここに書くのは
 *   - `reason`: なぜその差が訳し落としでも数学の書き換えでもないのか
 *   - `allow`: どの**種類**の差なら出てよいか（`ja-en-diff-rules.ts`）
 * の 2 つで、**宣言した規則で説明できない差が 1 つでも残れば違反**になる。
 * 数式ノードを丸ごと落とせば、どの規則でも説明できないので必ず違反になる。
 *
 * 規約:
 *   - **空文字（および空白のみ）の理由は認めない。**
 *   - 「数式が合わないから」は理由ではない。何がどう違い、なぜそれが訳し落としではないのかを書く。
 *   - 宣言した規則が 1 度も使われなければ、検証ツールが「登録が古い」として報告する。
 */

import type { MathDifferenceException } from "./ja-en-diff-rules.ts";

const JAPANESE_IN_TEXT_MACRO =
  "数式中の `\\text{}` の中身は数式ではなく地の文であり、翻訳の対象である。" +
  "英語版の生成器は和文フォントを読み込まないため、日本語のままだと PDF から無言で消える" +
  "（実測: build-latex.ts の「組めない文字」検査がビルドを落とす）。" +
  "そこで `\\text{}` の**中身だけ**を英訳し、その外側の数式記号は 1 文字も変えていない。" +
  "したがってこの差は訳し落としでも数学の書き換えでもない。日本語版は正本なので変更していない。";

/**
 * リポジトリ内部のパス・フィールド名を投稿稿から落としたことによる差。
 *
 * 日本語版は補助レポートや Lean の README、スキーマのフィールド名を
 * `\texttt{outputs/reports/...}` のような **math ノード**で書いている。これは
 * **リポジトリ内部の名前**であり、Expositiones Mathematicae へ出す投稿稿の読者はそれを開けない
 * （リポジトリは投稿物ではない）。したがって英語版では、内部の名前を出さず
 * "the supporting report for this proposition" のような言い方へ置き換えた。
 *
 * 落としたのは**参照先の名前だけ**であって、主張・限界・caveat は 1 つも落としていない。
 * これらのノードは数式ではなく `\texttt{}` に入れた文字列であり、数学的な記号は 1 文字も変えていない。
 * 規則 `repo-internal-texttt-removed` は **`\texttt{...}` だけからなるノードにしか当たらない**ので、
 * この理由を盾に数式を落とすことはできない。
 */
const INTERNAL_PATH_REMOVED =
  "日本語版が `\\texttt{outputs/reports/...}` 等の math ノードで書いているリポジトリ内部の名前を、" +
  "投稿稿から落とした。投稿先の読者はこのリポジトリを開けないため、内部の名前は投稿稿では意味を持たない。" +
  "落としたのは参照先の**名前**だけで、主張・限界・caveat は 1 つも落としていない。" +
  "これらのノードは数式ではなく `\\texttt{}` に入れた文字列であり、" +
  "数学的な記号は 1 文字も変えていない。日本語版は正本なので変更していない。";

/**
 * `\text{}` の中身が**後置修飾の日本語**であるために、英訳すると語順が変わる場合。
 *
 * 例: `(=\ \bar{\tilde E}\ \text{の原始二項式部分の次数})` は「〜の次数」という後置修飾であり、
 * `\text{}` の中身だけを英訳して同じ位置に置くと
 * `(=\ \bar{\tilde E}\ \text{the degree of the primitive binomial part of})` となって
 * 英語として読めない（かつ「b = \bar{\tilde E}」と読める偽の等式になる）。
 * そこで `\text{}` の前後にある記号の**順序だけ**を英語の語順へ直した。
 * **記号は 1 つも足していないし、1 つも消していない。** 規則
 * `text-body-translated-reordered` は、`\text{}` を取り除いた残りが多重集合として一致することを
 * 実際に検査するので、「並べ替えた」を口実に記号を落とすことはできない。
 */
const JAPANESE_IN_TEXT_MACRO_REORDERED =
  JAPANESE_IN_TEXT_MACRO +
  " 加えて、`\\text{}` の中身が日本語の後置修飾（「〜の次数」「〜で相異なる」「〜なる δ 上」）" +
  "である箇所は、中身だけを同じ位置で英訳すると英語として読めず、偽の等式に読める形になる。" +
  "そこで `\\text{}` の前後にある記号の**順序だけ**を英語の語順へ直した。" +
  "記号は 1 つも足しても消してもいない（数学は変えていない）。";

export const MATH_DIFFERENCE_EXCEPTIONS: Readonly<Record<string, MathDifferenceException>> = {
  paper_012_definition_ladder: {
    reason: JAPANESE_IN_TEXT_MACRO,
    allow: ["text-body-translated"],
  },
  paper_042_theorem_pi_p1: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED + " 加えて、" + INTERNAL_PATH_REMOVED,
    allow: ["text-body-translated-reordered", "repo-internal-texttt-removed"],
  },
  paper_043b_theorem_trace_bound: {
    reason: INTERNAL_PATH_REMOVED,
    allow: ["repo-internal-texttt-removed"],
  },
  paper_046_theorem_wstar_different: {
    reason: JAPANESE_IN_TEXT_MACRO,
    allow: ["text-body-translated"],
  },
  paper_052_theorem_l0_computable: {
    reason: INTERNAL_PATH_REMOVED,
    allow: ["repo-internal-texttt-removed"],
  },
  paper_053_theorem_lower_order: {
    reason: INTERNAL_PATH_REMOVED,
    allow: ["repo-internal-texttt-removed"],
  },
  paper_055_theorem_theta_infinity: {
    reason: JAPANESE_IN_TEXT_MACRO + " 加えて、" + INTERNAL_PATH_REMOVED,
    allow: ["text-body-translated", "repo-internal-texttt-removed"],
  },
  paper_056_theorem_ell2_family: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED,
    allow: ["text-body-translated", "text-body-translated-reordered"],
  },
  paper_082_remark_formalization: {
    reason: INTERNAL_PATH_REMOVED,
    allow: ["repo-internal-texttt-removed"],
  },
  paper_101_theorem_s_infinity_decision: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED,
    allow: ["text-body-translated", "text-body-translated-reordered"],
  },
  paper_101_theorem_digit_branch: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED,
    allow: ["text-body-translated-reordered"],
  },
};
