/**
 * **英語版の骨格が原文と食い違ってよいブロック**の表。
 *
 * 数式（`math` / `displayMath` の `tex`）・参照先・引用キー・画像資産・それらの位置は
 * 翻訳の対象ではない。ずれていたら、それは訳し落としか、断りなく数学を書き換えたかの
 * どちらかである。だから既定は「一致必須」（システムの構造照合。domain-model.md I8）とする。
 *
 * **cycle 22 で形を変えた（理由は重要なので必ず読むこと）。**
 * 以前この表は「ブロック id → 理由の文字列」で、**登録するとそのブロックの数式照合が丸ごと免除された**。
 * cycle 21 step 4 は、登録済みのブロックで英語版のインライン数式を **11 個落としたのに検証を通過**した。
 * 事故報告（`outputs/reports/cycle21_ops_reflect_to_paper.md` §6.1）は
 * 「例外表への登録は検査の穴を開ける操作である、という認識が薄かった」と書いている。
 *
 * そこで免除の単位を**差分 1 つ**へ落とした。ここに書くのは
 *   - `reason`: なぜその差が訳し落としでも数学の書き換えでもないのか
 *   - `allow`: どの**種類**の差なら出てよいか（`diff-rules.ts`）
 * の 2 つで、**宣言した規則で説明できない差が 1 つでも残れば違反**になる。
 * 数式ノードを丸ごと落とせば、どの規則でも説明できないので必ず違反になる。
 *
 * **cycle 24 step 2 で比較器をシステム側へ移した**（自前の `verify-ja-en-correspondence.ts` を撤去）。
 * システムは数式だけでなく参照・引用・画像・**位置**まで見るので、移行時に
 * (a) 段落の切り直し・語順の変更（`translation-reflowed`）、(b) 引用ノードの追加（`citation-added`）、
 * (c) 行内→別行立ての変更（`math-display-mode-changed`）が新たに差として現れた。
 * (c) は移行前の検査では**原理的に見えなかった**差である（tex の多重集合しか見ていなかった）。
 *
 * 規約:
 *   - **空文字（および空白のみ）の理由は認めない。**
 *   - 「数式が合わないから」は理由ではない。何がどう違い、なぜそれが訳し落としではないのかを書く。
 *   - 宣言した規則が 1 度も使われなければ、検証ツールが「登録が古い」として報告する。
 */

import type { MathDifferenceException } from "./diff-rules.ts";

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

/**
 * 英語版にだけ `cite` ノードが増えたことによる差。
 *
 * 日本語版は書誌を**地の文**に書く方針で `cite` ノードを 1 件も使わない
 * （日本語版の生成器は `cite` を出力できず、渡されれば例外を投げる）。英語版は投稿稿なので
 * BibTeX で引く。したがって英語版にだけ引用ノードが増える。増えたのは引用だけで、
 * 数式・参照・画像は 1 つも増減していない（規則 `citation-added` は `cite` ノードにしか当たらない）。
 */
const CITATIONS_ADDED =
  "英語版は投稿稿なので書誌を `cite` ノードで引く。日本語版は書誌を地の文へ直に書く方針で " +
  "`cite` を 1 件も使わない。したがって英語版にだけ引用ノードが増える。" +
  "増えたのは引用ノードだけで、数式・参照・画像は 1 つも増減していない。";

/**
 * 英訳で段落の切り方・語順が変わったことによる差。
 *
 * 日本語と英語では 1 文の切り方が違うので、同じ内容でも段落の割り方や、
 * 数式と地の文の前後関係が変わる。**骨格ノードの多重集合が一致することを実際に検査する**ので、
 * 「組み替えた」を口実にノードを落とす／足すことはできない。
 */
const REFLOWED =
  "英訳にあたって段落の切り方と語順が変わり、骨格ノードの入れ子・並びが原文と違う。" +
  "規則 `translation-reflowed` は骨格ノードを平らにした多重集合の一致を実際に検査するので、" +
  "この理由でノードを落とすことも足すこともできない。日本語版は正本なので変更していない。";

/**
 * 同じ数式が原文では行内、英語版では別行立てになっている差。
 * tex 自体は他の規則の下で一致することを別に検査する。
 */
const DISPLAY_MODE_CHANGED =
  "同じ数式を、原文では行内（`math`）、英語版では別行立て（`displayMath`）で組んでいる。" +
  "英語は語が長く、行内に置くと版面から出るためである。tex の中身は他の規則の下で" +
  "一致することを別に検査しているので、この理由で数式を書き換えることはできない。" +
  "移行前の自前検査は tex の多重集合しか見ておらず、この差を検出できなかった。";

export const MATH_DIFFERENCE_EXCEPTIONS: Readonly<Record<string, MathDifferenceException>> = {
  paper_012_definition_ladder: {
    reason: JAPANESE_IN_TEXT_MACRO,
    allow: ["text-body-translated"],
  },
  paper_022_claim_resultant: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_031_theorem_lsw: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_032_remark_ising_known: {
    reason: CITATIONS_ADDED,
    allow: ["citation-added"],
  },
  paper_041_theorem_periodicity: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_042_theorem_pi_p1: {
    // cycle 27: 日本語版からもリポジトリ内部のパスを落としたので、その規則は要らなくなった。
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED + " 加えて、" + REFLOWED,
    allow: ["text-body-translated-reordered", "translation-reflowed"],
  },
  paper_043_theorem_bound: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_043b_theorem_trace_bound: {
    reason: INTERNAL_PATH_REMOVED + " 加えて、" + REFLOWED,
    allow: ["repo-internal-texttt-removed", "translation-reflowed"],
  },
  paper_044_theorem_newton: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_045_theorem_trace_ladder: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_046_theorem_wstar_different: {
    reason: JAPANESE_IN_TEXT_MACRO + " 加えて、" + REFLOWED,
    allow: ["text-body-translated", "translation-reflowed"],
  },
  paper_051_theorem_duality: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_052_theorem_l0_computable: {
    reason: REFLOWED,
    allow: ["translation-reflowed"],
  },
  paper_053_theorem_lower_order: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_054_remark_limits: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_055_theorem_theta_infinity: {
    reason: JAPANESE_IN_TEXT_MACRO + " 加えて、" + REFLOWED,
    allow: ["text-body-translated", "translation-reflowed"],
  },
  paper_056_theorem_ell2_family: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED + " 加えて、" + REFLOWED,
    allow: ["text-body-translated-reordered", "translation-reflowed"],
  },
  paper_061_theorem_V: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_062_theorem_T: {
    reason: CITATIONS_ADDED,
    allow: ["citation-added"],
  },
  paper_063_theorem_W: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_071_remark_asymmetry: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_072_remark_qp_free: {
    reason: CITATIONS_ADDED,
    allow: ["citation-added"],
  },
  paper_081_remark_scope: {
    reason: CITATIONS_ADDED,
    allow: ["citation-added"],
  },
  paper_082_remark_formalization: {
    reason: INTERNAL_PATH_REMOVED + " 加えて、" + REFLOWED,
    allow: ["repo-internal-texttt-removed", "translation-reflowed"],
  },
  paper_091_theorem_theta_padic: {
    reason: CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["citation-added", "translation-reflowed"],
  },
  paper_101_theorem_digit_branch: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED + " 加えて、" + DISPLAY_MODE_CHANGED + " 加えて、" + REFLOWED,
    allow: ["text-body-translated-reordered", "math-display-mode-changed", "translation-reflowed"],
  },
  paper_101_theorem_s_infinity_decision: {
    reason: JAPANESE_IN_TEXT_MACRO_REORDERED + " 加えて、" + CITATIONS_ADDED + " 加えて、" + REFLOWED,
    allow: ["text-body-translated-reordered", "citation-added", "translation-reflowed"],
  },
};
