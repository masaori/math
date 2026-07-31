/**
 * 日英対応検証（`verify-ja-en-correspondence.ts`）で、**数式の多重集合の差を許すブロック**の表。
 *
 * 数式（`math` / `displayMath` の `tex`）は翻訳の対象ではない。日英で数式がずれていたら、
 * それは訳し落としか、断りなく数学を書き換えたかのどちらかである。だから既定は「一致必須」とする。
 *
 * 正当な差が出うる場面はある（例: 日本語の地の文に書かれていた量を、英語では行内数式へ出した）。
 * その場合だけ、**なぜ差が正当なのかを一次情報で説明できる文言とともに**ここへ登録する。
 *
 * 規約:
 *   - キーはブロック id。値は**理由の文字列**。
 *   - **空文字（および空白のみ）は例外として認めない**（検証ツールがその登録自体を違反として報告する）。
 *   - 「数式が合わないから」は理由ではない。何がどう違い、なぜそれが訳し落としではないのかを書く。
 *
 * **この表は 0 件で始める。** 増やすときは、増やした本人が上の規約を満たすこと。
 */
const JAPANESE_IN_TEXT_MACRO =
  "数式中の `\\text{}` の中身は数式ではなく地の文であり、翻訳の対象である。" +
  "英語版の生成器は和文フォントを読み込まないため、日本語のままだと PDF から無言で消える" +
  "（実測: build-latex.ts の「組めない文字」検査がビルドを落とす）。" +
  "そこで `\\text{}` の**中身だけ**を英訳し、その外側の数式記号は 1 文字も変えていない。" +
  "したがってこの差は訳し落としでも数学の書き換えでもない。日本語版は正本なので変更していない。";

/**
 * リポジトリ内部のパスを投稿稿から落としたことによる差。
 *
 * 日本語版は補助レポートや Lean の README を `\texttt{outputs/reports/...}` のような
 * **math ノード**で書いている。これは**リポジトリ内部のパス**であり、
 * Expositiones Mathematicae へ出す投稿稿の読者はそのファイルを開けない
 * （リポジトリは投稿物ではない）。したがって英語版では、パス文字列を出さず
 * "the supporting report for this proposition" のような言い方へ置き換えた。
 *
 * 落としたのは**参照先の名前だけ**であって、主張・限界・caveat は 1 つも落としていない。
 * 数式として意味を持つ記号は 1 文字も変えていない（そもそもこれらは数式ではなく、
 * `\texttt{}` に入れたファイル名である）。日本語版は正本なので変更していない。
 */
const INTERNAL_PATH_REMOVED =
  "日本語版が `\\texttt{outputs/reports/...}` 等の math ノードで書いているリポジトリ内部のパスを、" +
  "投稿稿から落とした。投稿先の読者はこのリポジトリを開けないため、内部パスは投稿稿では意味を持たない。" +
  "落としたのは参照先の**名前**だけで、主張・限界・caveat は 1 つも落としていない。" +
  "これらのノードは数式ではなく `\\texttt{}` に入れたファイル名であり、" +
  "数学的な記号は 1 文字も変えていない。日本語版は正本なので変更していない。";

/**
 * `\text{}` の中身が**後置修飾の日本語**であるために、英訳すると語順が変わる場合。
 *
 * 例: `(=\ \bar{\tilde E}\ \text{の原始二項式部分の次数})` は「〜の次数」という後置修飾であり、
 * `\text{}` の中身だけを英訳して同じ位置に置くと
 * `(=\ \bar{\tilde E}\ \text{the degree of the primitive binomial part of})` となって
 * 英語として読めない（かつ「b = \bar{\tilde E}」と読める偽の等式になる）。
 * そこで `\text{}` の前後にある記号の**順序だけ**を英語の語順へ直した。
 * **記号は 1 つも足していないし、1 つも消していない。数学は変えていない。**
 */
const JAPANESE_IN_TEXT_MACRO_REORDERED =
  JAPANESE_IN_TEXT_MACRO +
  " 加えて、`\\text{}` の中身が日本語の後置修飾（「〜の次数」「〜で相異なる」「〜なる δ 上」）" +
  "である箇所は、中身だけを同じ位置で英訳すると英語として読めず、偽の等式に読める形になる。" +
  "そこで `\\text{}` の前後にある記号の**順序だけ**を英語の語順へ直した。" +
  "記号は 1 つも足しても消してもいない（数学は変えていない）。";

export const MATH_DIFFERENCE_EXCEPTIONS: Readonly<Record<string, string>> = {
  paper_012_definition_ladder: JAPANESE_IN_TEXT_MACRO,
  paper_042_theorem_pi_p1: JAPANESE_IN_TEXT_MACRO + " 加えて、" + INTERNAL_PATH_REMOVED,
  paper_043b_theorem_trace_bound: INTERNAL_PATH_REMOVED,
  paper_046_theorem_wstar_different: JAPANESE_IN_TEXT_MACRO,
  paper_052_theorem_l0_computable: INTERNAL_PATH_REMOVED,
  paper_053_theorem_lower_order: INTERNAL_PATH_REMOVED,
  paper_055_theorem_theta_infinity: JAPANESE_IN_TEXT_MACRO + " 加えて、" + INTERNAL_PATH_REMOVED,
  paper_056_theorem_ell2_family: JAPANESE_IN_TEXT_MACRO,
  paper_082_remark_formalization: INTERNAL_PATH_REMOVED,
  paper_101_theorem_s_infinity_decision: JAPANESE_IN_TEXT_MACRO_REORDERED,
  paper_101_theorem_digit_branch: JAPANESE_IN_TEXT_MACRO_REORDERED,
};
