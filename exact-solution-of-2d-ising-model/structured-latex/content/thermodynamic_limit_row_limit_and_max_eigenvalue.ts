import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「熱力学極限」の章「N→∞ の極限と最大固有値 c(M)」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_part_thermodynamic_limit",
    kind: "heading",
    level: 1,
    title: { text: "熱力学極限" },
    labels: [],
  },
  {
    id: "heading_chapter_row_limit_and_max_eigenvalue",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`N\to\infty\text{ の極限と最大固有値 }c(M)` },
    labels: [],
  },
  {
    id: "maxeig_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 2 },
    title: { tex: String.raw`Z \text{ を } c(M_{\mathrm{col}}) \text{ で挟み、} N_{\mathrm{row}}\to\infty \text{ の極限を取る道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " により ",
        math(String.raw`Z(K_1,K_2) = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        " である。熱力学極限を取るには、この ",
        math(String.raw`N_{\mathrm{row}}`),
        " 乗のトレースを**最大固有値ひとつ**で挟み撃ちしたい。以下でそれを行う。",
      ]),
      paragraph([
        "得られる評価は、",
        math(String.raw`W := V_1^{1/2}V_2V_1^{1/2}`),
        "、",
        math(String.raw`c(M_{\mathrm{col}}) := \sup\{\,x^{\top}Wx \mid x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1\,\}`),
        " として",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \ \leq\ Z(K_1,K_2)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`,
      ),
      paragraph([
        "である。**以下では固有値の存在（対角化可能性・スペクトル定理）を一切使わない。**",
        math(String.raw`c(M_{\mathrm{col}})`),
        " は上限として定義され、必要な不等式はすべて半正定値双線型形式に対する Cauchy–Schwarz の不等式から出る。",
        "有限次元の実対称行列が対角化できること自体は正しいが、その証明は本文にまだ無く、",
        "また挟み撃ちには不要だからである。",
      ]),
      paragraph([
        "この挟み撃ちの両辺の対数を ",
        math(String.raw`M_{\mathrm{col}}N_{\mathrm{row}}`),
        " で割ると、",
        math(String.raw`M_{\mathrm{col}}`),
        " を固定したまま ",
        math(String.raw`N_{\mathrm{row}}\to\infty`),
        " の極限が ",
        math(String.raw`\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
        " に等しいことが従う（",
        ref("limit_of_log_Z_in_N_row"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、N→∞ の極限と最大固有値 c(M) の章の冒頭へ移した。c_+(M) と ε の性質を述べる段落は 011 の案内文 maxeig_remark_overview_c_plus_and_epsilon に残し、N_row→∞ の極限（limit_of_log_Z_in_N_row）を述べる段落を足した。「この章」を「以下」に直した。",
      ],
    },
  },
  {
    id: "maxeig_002_claim_Z_equals_trace_of_W",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 4 },
    title: { tex: String.raw`Z = \mathrm{tr}(W^{N_{\mathrm{row}}})` },
    labels: ["Z_equals_trace_of_W"],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " と同じ設定のもと、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{tr}\!\left((V_1V_2)^{n}\right) = \mathrm{tr}\!\left(W^{n}\right)`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`Z(K_1,K_2) = \mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n_0 := 2^{M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`B := V_1^{1/2} \in \mathrm{Mat}(n_0,\mathbb{C})`),
        " と書く。",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(n_0,\mathbb{C})`),
        " は ",
        ref("def_transfer_matrix"),
        " のものである。行列の積は ",
        ref("mat_mult"),
        "、行列の冪は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`X^0 := I`),
        "、",
        math(String.raw`X^{m+1} := X^m X`),
        "（",
        math(String.raw`X \in \mathrm{Mat}(n_0,\mathbb{C})`),
        "、",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`I := I_{\mathrm{Mat}(n_0,\mathbb{C})}`),
        "）による。三つ以上の行列の積は括弧を省かずに書く。",
      ]),
      paragraph(["準備 1（", math(String.raw`B`), " と ", math(String.raw`W`), " の関係）。"]),
      displayMath(
        String.raw`\begin{aligned}
BB &= V_1
  &&\bigl(\because\ \blkref{def_transfer_matrix_square_root}\bigr)\\
W &= \left(BV_2\right)B
  &&\bigl(\because\ \blkref{def_symmetrized_transfer_matrix}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "準備 2（開いた積の冪）。",
        math(String.raw`X, Y \in \mathrm{Mat}(n_0,\mathbb{C})`),
        "、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\left(X(YX)^{k}\right)Y = (XY)^{k+1}`),
        " を ",
        math(String.raw`k`),
        " の帰納法で示す。",
        math(String.raw`k = 0`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(X(YX)^{0}\right)Y
  &= (XI)Y
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (YX)^0 := I\bigr)\\
  &= XY
  &&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)\\
  &= I(XY)
  &&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
  &= (XY)^{0}(XY)
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (XY)^0 := I\bigr)\\
  &= (XY)^{1}
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (XY)^{0+1} := (XY)^0(XY)\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(X(YX)^{k+1}\right)Y
  &= \left(X\left((YX)^{k}(YX)\right)\right)Y
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (YX)^{k+1} := (YX)^k(YX)\bigr)\\
  &= \left(\left(X(YX)^{k}\right)(YX)\right)Y
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(\left(X(YX)^{k}\right)Y\right)X\right)Y
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left((XY)^{k+1}X\right)Y
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
  &= (XY)^{k+1}(XY)
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= (XY)^{k+2}
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (XY)^{(k+1)+1} := (XY)^{k+1}(XY)\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`k + 1`),
        " でも成り立つ。ゆえにすべての ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " で成り立つ。",
      ]),
      paragraph([
        "準備 3（",
        math(String.raw`W`),
        " の冪）。",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^{k+1} = \left(\left(B(V_2V_1)^{k}\right)V_2\right)B`),
        " を ",
        math(String.raw`k`),
        " の帰納法で示す。",
        math(String.raw`k = 0`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W^{1}
  &= W^{0}W
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ W^{0+1} := W^0W\bigr)\\
  &= IW
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ W^0 := I\bigr)\\
  &= W
  &&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
  &= \left(BV_2\right)B
  &&\bigl(\because\ \text{準備 1}\bigr)\\
  &= \left(\left(BI\right)V_2\right)B
  &&\bigl(\because\ \blkref{identity_matrix_is_right_unit_of_mat_mult}\bigr)\\
  &= \left(\left(B(V_2V_1)^{0}\right)V_2\right)B
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (V_2V_1)^0 := I\bigr)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k`),
        " で成り立つとし、",
        math(String.raw`C := B(V_2V_1)^{k} \in \mathrm{Mat}(n_0,\mathbb{C})`),
        " と書くと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W^{k+2}
  &= W^{k+1}W
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ W^{(k+1)+1} := W^{k+1}W\bigr)\\
  &= \left(\left(\left(B(V_2V_1)^{k}\right)V_2\right)B\right)W
  &&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
  &= \left(\left(CV_2\right)B\right)W
  &&\bigl(\because\ C\ \text{の置き方}\bigr)\\
  &= \left(\left(CV_2\right)B\right)\left(\left(BV_2\right)B\right)
  &&\bigl(\because\ \text{準備 1}\bigr)\\
  &= \left(\left(\left(CV_2\right)B\right)\left(BV_2\right)\right)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(\left(\left(CV_2\right)B\right)B\right)V_2\right)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(\left(CV_2\right)\left(BB\right)\right)V_2\right)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(\left(CV_2\right)V_1\right)V_2\right)B
  &&\bigl(\because\ \text{準備 1}\bigr)\\
  &= \left(\left(C\left(V_2V_1\right)\right)V_2\right)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(\left(B(V_2V_1)^{k}\right)\left(V_2V_1\right)\right)V_2\right)B
  &&\bigl(\because\ C\ \text{の置き方}\bigr)\\
  &= \left(\left(B\left((V_2V_1)^{k}\left(V_2V_1\right)\right)\right)V_2\right)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \left(\left(B(V_2V_1)^{k+1}\right)V_2\right)B
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ (V_2V_1)^{k+1} := (V_2V_1)^k(V_2V_1)\bigr)
\end{aligned}`,
      ),
      paragraph([
        "となり ",
        math(String.raw`k + 1`),
        " でも成り立つ。ゆえにすべての ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " で成り立つ。",
      ]),
      paragraph([
        "本体。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`k := n - 1 \in \mathbb{Z}_{\geq 0}`),
        " と置くと ",
        math(String.raw`k + 1 = n`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left((V_1V_2)^{n}\right)
  &= \mathrm{tr}\!\left(\left(V_1(V_2V_1)^{k}\right)V_2\right)
  &&\bigl(\because\ \text{準備 2 を}\ X := V_1,\ Y := V_2\ \text{に適用}\bigr)\\
  &= \mathrm{tr}\!\left(\left(\left(BB\right)(V_2V_1)^{k}\right)V_2\right)
  &&\bigl(\because\ \text{準備 1}\bigr)\\
  &= \mathrm{tr}\!\left(\left(B\left(B(V_2V_1)^{k}\right)\right)V_2\right)
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \mathrm{tr}\!\left(B\left(\left(B(V_2V_1)^{k}\right)V_2\right)\right)
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
  &= \mathrm{tr}\!\left(\left(\left(B(V_2V_1)^{k}\right)V_2\right)B\right)
  &&\bigl(\because\ \blkref{trace_basic_properties}\ (2)\ \text{の巡回性の左の因子に}\ B\ \text{を、右の因子に}\ \left(B(V_2V_1)^{k}\right)V_2\ \text{を当てる}\bigr)\\
  &= \mathrm{tr}\!\left(W^{n}\right)
  &&\bigl(\because\ \text{準備 3}\bigr)
\end{aligned}`,
      ),
      paragraph(["とくに ", math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`), " について"]),
      displayMath(
        String.raw`\begin{aligned}
Z(K_1,K_2)
  &= \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)
  &&\bigl(\because\ \blkref{partition_function_via_transfer_matrix}\bigr)\\
  &= \mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)
  &&\bigl(\because\ \text{本体を}\ n := N_{\mathrm{row}}\ \text{に適用}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-11-04: SageMath の検算（sagemath/check/Z_equals_trace_of_W/）を付けるにあたり、証明を (∵) 付きの鎖にした。散文の「結合法則で括り直す」「冪の定義」「n−1 個の積」を、冪の定義 <def_exp> (1) による二つの帰納法（準備 2: (X(YX)^k)Y = (XY)^{k+1}、準備 3: W^{k+1} = ((B(V_2V_1)^k)V_2)B）と <mat_mult_associative>・単位行列の左右の単位律の行に分けた。本体の鎖は元の証明と同じ順（V_1(V_2V_1)^{n−1}V_2 → BB を代入 → 巡回性 → W^n）で、内容は不変。",
      ],
    },
  },
  {
    id: "maxeig_003_claim_W_is_positive_definite",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 5 },
    title: { tex: String.raw`W \text{ は実対称正定値}` },
    labels: ["W_is_real_symmetric_positive_definite"],
    statement: [
      paragraph([
        math(String.raw`W`),
        " は成分がすべて実数で転置について対称であり、",
        ref("def_hermitian_positive_definite"),
        " の意味で正定値である。また ",
        math(String.raw`W`),
        " は ",
        ref("def_invertible_elements_of_R"),
        "（",
        math(String.raw`M \to M_{\mathrm{col}}`),
        "）の意味で可逆である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`K_1D`),
        " と ",
        math(String.raw`S_2`),
        " は実対称）。",
        math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
        " は ",
        ref("iH_is_real_symmetric"),
        " の Step 3 で見たとおり、成分が実で転置について対称である（",
        math(String.raw`\sigma^z`),
        " が 2 個、他は単位行列のクロネッカー積）。実係数 ",
        math(String.raw`K_1`),
        " の有限和なので ",
        math(String.raw`K_1D`),
        " も実対称。",
        ref("iH_is_real_symmetric"),
        " の Step 1 より ",
        math(String.raw`S_2`),
        " も実対称である。その表示は",
      ]),
      displayMath(String.raw`\begin{aligned}
S_2
&=iK_2^*H_2
  &&\bigl(\because\ S_2\ \text{の定義}\bigr)\\
&=K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
  &&\bigl(\because\ \text{実対称性の主張の Step 1}\bigr)
\end{aligned}`),
      paragraph([
        "Step 2（指数関数）。",
        math(String.raw`K_1D`),
        " と ",
        math(String.raw`S_2`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）なので、",
        ref("real_symmetric_matrix_is_hermitian"),
        "（",
        math(String.raw`n \to 2^{M_{\mathrm{col}}},\ A \to K_1D`),
        " と ",
        math(String.raw`A \to S_2`),
        "）よりエルミートであり、",
        ref("real_multiple_of_hermitian_is_hermitian"),
        "（",
        math(String.raw`\alpha \to \tfrac12,\ A \to K_1D`),
        "）より ",
        math(String.raw`\tfrac12 K_1D`),
        " もエルミートである。",
        ref("exp_hermitian_is_positive_definite"),
        " より ",
        math(String.raw`B := \exp(\tfrac12 K_1D)`),
        " と ",
        math(String.raw`A := \exp(S_2)`),
        " はいずれも正定値（とくにエルミート）であり、",
        ref("exp_of_negative_is_left_inverse"),
        " より ",
        math(String.raw`B' := \exp(-\tfrac12 K_1D)`),
        " は ",
        math(String.raw`B'B = I`),
        " を満たす。この ",
        math(String.raw`B`),
        " は ",
        ref("def_transfer_matrix_square_root"),
        " で定めた ",
        math(String.raw`V_1^{1/2}`),
        " そのものである。",
        "さらに実対称行列の冪は実対称で、",
        ref("def_exp"),
        " の級数の部分和は実対称、",
        ref("star_preserves_norm_and_limits"),
        " (3) と同じ議論（転置もノルムを保つ）から極限も実対称。よって ",
        math(String.raw`B, A`),
        " は**実**対称正定値である。",
      ]),
      paragraph([
        "Step 3（合同変換）。",
        ref("V2_exponential_representation"),
        " より ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}A`),
        "（",
        ref("iH_is_real_symmetric"),
        " Step 1）であり、",
        math(String.raw`B`),
        " がエルミートなので ",
        math(String.raw`B^* = B`),
        "。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
W
&=B\,V_2\,B
  &&\bigl(\because\ W=B V_2 B\ \text{の定義 }\blkref{def_symmetrized_transfer_matrix}\bigr)\\
&=B\bigl((2s_2)^{M_{\mathrm{col}}/2}A\bigr)B
  &&\bigl(\because\ V_2=(2s_2)^{M_{\mathrm{col}}/2}A\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}B A B
  &&\bigl(\because\ \text{スカラー倍と行列積の結合則}\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}B^{*}A B
  &&\bigl(\because\ B^*=B\bigr)
\end{aligned}`),
      paragraph([
        ref("congruence_preserves_positive_definite"),
        " より ",
        math(String.raw`B^*AB = B^*(AB)`),
        "（",
        ref("mat_mult_associative"),
        "）は正定値、",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} > 0`),
        " なので ",
        ref("positive_real_multiple_preserves_positive_definite"),
        " より ",
        math(String.raw`W`),
        " は正定値である。実対称性は次の転置の計算から従う。",
      ]),
      displayMath(String.raw`\begin{aligned}
W^\top
&=(B V_2 B)^\top
  &&\bigl(\because\ W=B V_2 B\ \text{の定義 }\blkref{def_symmetrized_transfer_matrix}\bigr)\\
&=B^\top V_2^\top B^\top
  &&\bigl(\because\ \text{転置の積の法則}\ (ABC)^\top=C^\top B^\top A^\top\bigr)\\
&=B V_2 B
  &&\bigl(\because\ B^\top=B,\ V_2^\top=V_2\bigr)\\
&=W
  &&\bigl(\because\ W=B V_2 B\ \text{の定義 }\blkref{def_symmetrized_transfer_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "可逆性。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と、その単位行列 ",
        math(String.raw`I`),
        "・可逆元の集合 ",
        math(String.raw`R^\times`),
        " を用いる（",
        math(String.raw`-\tfrac12 K_1D := -\bigl(\tfrac12 K_1D\bigr)`),
        " は ",
        ref("def_matrix_negation"),
        " の符号反転）。Step 2 の ",
        math(String.raw`B'B = I`),
        " と次の鎖から ",
        math(String.raw`B \in R^\times`),
        " である（",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`g \to B,\ h \to B'`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
BB'
&=\exp\!\left(\tfrac12 K_1D\right)\exp\!\left(-\tfrac12 K_1D\right)
  &&\bigl(\because\ B,\ B'\ \text{の置き方}\bigr)\\
&=\exp\!\left(-\left(-\tfrac12 K_1D\right)\right)\exp\!\left(-\tfrac12 K_1D\right)
  &&\bigl(\because\ \blkref{matrix_double_negation}\ (m\to 2^{M_{\mathrm{col}}},\ n\to 2^{M_{\mathrm{col}}},\ A\to \tfrac12 K_1D)\bigr)\\
&=I
  &&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to 2^{M_{\mathrm{col}}},\ A\to -\tfrac12 K_1D)\bigr)
\end{aligned}`),
      displayMath(String.raw`BV_2\in R^\times
\qquad\bigl(\because\ B \in R^\times,\ \blkref{V2_invertible},\ \blkref{def_invertible_elements_of_R}\text{ (ii)}\ (g_1\to B,\ g_2\to V_2)\bigr)`),
      displayMath(String.raw`\begin{aligned}
W
&=\left(BV_2\right)B
  &&\bigl(\because\ \blkref{def_symmetrized_transfer_matrix},\ B = V_1^{1/2}\ \blkref{def_transfer_matrix_square_root}\bigr)\\
&\in R^\times
  &&\bigl(\because\ \text{前の式の}\ BV_2\in R^\times,\ B \in R^\times,\ \blkref{def_invertible_elements_of_R}\text{ (ii)}\ (g_1\to BV_2,\ g_2\to B)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: Step 2 が「def_hermitian_positive_definite の最後の注意より実対称行列はエルミート」と定義の中の主張を引いていたのを、それを切り出した主張 real_symmetric_matrix_is_hermitian と定義 def_real_symmetric_complex_matrix を引く形にし、当てはめ（n → 2^{M_col}、A → K_1D と A → S_2）を書いた。exp_hermitian_is_positive_definite を当てはめる ½K_1D がエルミートであることの根拠が無かったので、real_multiple_of_hermitian_is_hermitian（α → ½、A → K_1D）を足した。Step 1 の K_1D・S_2 の実対称性の論証（名前だけの根拠が残る）は変えていない。主張は変えていない。",
        "2026-11-04: SageMath の検算（sagemath/check/W_is_real_symmetric_positive_definite/）を付けるにあたり、可逆性の段を直した。旧い段は Wx = 0 から x^⊤Wx = 0 を作って正定値性で x = 0 としていたが、正定値性（def_hermitian_positive_definite）は x ∈ ℂ^n の x^*Wx についての条件で、複素の x では x^⊤Wx = 0 から x = 0 は従わない（検算で、実対称正定値な W と x = u + iv（u^⊤Wu = v^⊤Wv、u^⊤Wv = 0）で x^⊤Wx = 0 となる例を作った）。また核が {0} であることから可逆を導く主張は本文に無かった。可逆性を、BB' = I の 3 行の鎖（matrix_double_negation・exp_of_negative_is_left_inverse）と Step 2 の B'B = I による B ∈ R^×、V2_invertible、def_invertible_elements_of_R (ii) の 2 回の適用で示す形にした。主張の「とくに W は可逆」を、def_invertible_elements_of_R の意味で可逆と書いた（内容は不変）。",
      ],
    },
  },
  {
    id: "maxeig_006_definition_rayleigh_sup",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 8 },
    title: { tex: String.raw`c(M_{\mathrm{col}}) := \sup_{\|x\|=1} x^\top W x` },
    labels: ["def_rayleigh_sup"],
    statement: [
      paragraph([
        math(String.raw`W`),
        " は ",
        ref("W_is_real_symmetric_positive_definite"),
        " より実行列とみなせるので、",
      ]),
      displayMath(
        String.raw`\mathcal{R} := \left\{\, x^\top W x \ \middle|\ x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\} \subseteq \mathbb{R}_{>0}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\mathcal{R}`),
        " は空でない（",
        math(String.raw`\|e_1\| = 1`),
        " なので ",
        math(String.raw`e_1`),
        " を取れる）。上に有界であることは、成分の有限和として次のように評価できる。",
        math(String.raw`\|x\| = 1`),
        " とすると、各 ",
        math(String.raw`i`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
|x_i|^2
&\leq \sum_{k=1}^{2^{M_{\mathrm{col}}}}|x_k|^2
  &&\bigl(\because\ \text{非負の項の有限和は各項以上}\bigr)\\
&= \|x\|^2
  &&\bigl(\because\ \text{ノルムの定義 }\blkref{def_matrix_norm}\bigr)\\
&= 1
  &&\bigl(\because\ \|x\| = 1\bigr)
\end{aligned}`),
      paragraph([
        "であるから ",
        math(String.raw`|x_i| \leq 1`),
        " である。これを成分表示へ入れると",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|x^\top W x\right|
&= \left|\sum_{i=1}^{2^{M_{\mathrm{col}}}}\sum_{j=1}^{2^{M_{\mathrm{col}}}} x_i\,W_{ij}\,x_j\right|
  &&\bigl(\because\ \text{行列積の成分表示}\bigr)\\
&\leq \sum_{i=1}^{2^{M_{\mathrm{col}}}}\sum_{j=1}^{2^{M_{\mathrm{col}}}} |x_i|\,|W_{ij}|\,|x_j|
  &&\bigl(\because\ \text{有限和の三角不等式と積の絶対値}\bigr)\\
&\leq \sum_{i=1}^{2^{M_{\mathrm{col}}}}\sum_{j=1}^{2^{M_{\mathrm{col}}}} |W_{ij}|
  &&\bigl(\because\ |x_i| \leq 1,\ |x_j| \leq 1\bigr)
\end{aligned}`),
      paragraph([
        "となり、右辺は ",
        math(String.raw`x`),
        " によらない有限個の実数の和である。よって ",
        math(String.raw`\mathcal{R}`),
        " は上に有界である。ここで実数の上限",
      ]),
      displayMath(String.raw`c(M_{\mathrm{col}}) := \sup \mathcal{R} \in \mathbb{R}_{>0}`),
      paragraph([
        "が定まる。**ここが実数へ脱出する箇所である。** ",
        math(String.raw`\mathcal{R}`),
        " は一般に有限集合でも可算集合でもなく、上限の存在は「空でなく上に有界な実数の集合は上限をもつ」という ",
        math(String.raw`\mathbb{R}`),
        " の性質による。有理数の範囲では同じ主張は成り立たない。定義から",
      ]),
      displayMath(
        String.raw`x^\top W x \leq c(M_{\mathrm{col}})\,\|x\|^2 \qquad (\forall x \in \mathbb{R}^{2^{M_{\mathrm{col}}}})`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`x/\|x\|`),
        " に適用し、",
        math(String.raw`x = 0`),
        " なら両辺 ",
        math(String.raw`0`),
        "）。",
      ]),
      paragraph([
        "**上限が達成されること（最大固有値の存在）はここでは主張しない。**",
        "以下の評価は上限としての ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " だけで足りる。",
      ]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "maxeig_007_claim_operator_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 9 },
    title: { tex: String.raw`\|Wx\| \leq c(M_{\mathrm{col}})\,\|x\|` },
    labels: ["rayleigh_bounds_operator_norm"],
    statement: [
      paragraph([
        math(String.raw`\forall x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " について ",
        math(String.raw`\|Wx\| \leq c(M_{\mathrm{col}})\,\|x\|`),
        "。したがって ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\|W^k x\| \leq c(M_{\mathrm{col}})^k\|x\|`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M_{\mathrm{col}})`),
        " と略記する。",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " を取り、",
        math(String.raw`y := Wx`),
        "（成分は ",
        math(String.raw`y_k = \sum_{l=1}^{2^{M_{\mathrm{col}}}} W_{kl}\,x_l`),
        "（",
        ref("mat_mult"),
        "）。",
        math(String.raw`W`),
        " の成分と ",
        math(String.raw`x`),
        " の成分は実数なので ",
        math(String.raw`y \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "）とおく。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Wx\|^2
&=\|y\|^2
&&\bigl(\because\ y:=Wx\bigr)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}|y_k|^2
&&\bigl(\because\ \text{ノルムの定義 }\blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{a}\bigr)^2=a\bigr)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}y_k\,y_k
&&\bigl(\because\ y_k\in\mathbb{R}\ \text{なので}\ |y_k|^2=y_ky_k\bigr)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}y_k\sum_{l=1}^{2^{M_{\mathrm{col}}}}W_{kl}\,x_l
&&\bigl(\because\ y=Wx\ \text{の成分 }\blkref{mat_mult}\ \text{（右因子）}\bigr)\\
&=\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}y_k\,W_{kl}\,x_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\ y_k(W_{kl}x_l)=(y_kW_{kl})x_l\bigr)\\
&=y^\top Wx
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`W`),
        " は実対称かつ正定値、とくに半正定値である（",
        ref("W_is_real_symmetric_positive_definite"),
        "）から、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Wx\|^4
&=\left(\|Wx\|^2\right)^2
&&\bigl(\because\ \text{冪の指数法則}\bigr)\\
&=\left(y^\top Wx\right)^2
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&\leq\left(x^\top Wx\right)\left(y^\top Wy\right)
&&\bigl(\because\ \text{半正定値の Cauchy--Schwarz }\blkref{psd_cauchy_schwarz}\ \text{を}\ P=W,\ y=Wx\ \text{に適用}\bigr)\\
&\leq\left(c\|x\|^2\right)\left(y^\top Wy\right)
&&\bigl(\because\ \text{上限の評価}\ \blkref{def_rayleigh_sup}\ \text{の}\ x^\top Wx\leq c\|x\|^2\ \text{と}\ 0\leq y^\top Wy\ \text{（半正定値性）}\bigr)\\
&\leq\left(c\|x\|^2\right)\left(c\|y\|^2\right)
&&\bigl(\because\ \text{上限の評価}\ \blkref{def_rayleigh_sup}\ \text{の}\ y^\top Wy\leq c\|y\|^2\ \text{と}\ 0\leq c\|x\|^2\bigr)\\
&=c^2\|x\|^2\|Wx\|^2
&&\bigl(\because\ y=Wx\ \text{と}\ \mathbb{R}\ \text{の乗法の可換則・結合則}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\|Wx\| = 0`),
        " のときは左辺が ",
        math(String.raw`0`),
        "、右辺が ",
        math(String.raw`c\|x\| \geq 0`),
        " なので主張が成り立つ。以下 ",
        math(String.raw`\|Wx\| > 0`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Wx\|^4 \leq c^2\|x\|^2\|Wx\|^2
&\Longrightarrow \|Wx\|^2 \leq c^2\|x\|^2
  &&\bigl(\because\ \text{両辺を}\ \|Wx\|^2>0\ \text{で割る}\bigr)\\
&\Longrightarrow \|Wx\| \leq c\|x\|
  &&\bigl(\because\ \|Wx\| \geq 0,\ c\|x\| \geq 0\ \text{と平方の単調性}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意に取ったので、すべての ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " について ",
        math(String.raw`\|Wx\| \leq c\|x\|`),
        " である。",
      ]),
      paragraph([
        "冪についての主張は ",
        math(String.raw`k`),
        " に関する帰納法で示す。",
        math(String.raw`k=0`),
        " のときは、",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W^0x\|
&=\|Ix\|
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0:=I\bigr)\\
&=\|x\|
  &&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&=c^0\|x\|
  &&\bigl(\because\ c^0=1\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k`),
        " で成り立つ（すべての ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " について ",
        math(String.raw`\|W^kx\| \leq c^k\|x\|`),
        "）とし、",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W^{k+1}x\|
&=\|(W^kW)x\|
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1}:=A^mA\bigr)\\
&=\|W^k(Wx)\|
  &&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&\leq c^k\|Wx\|
  &&\bigl(\because\ \text{帰納法の仮定を}\ Wx\in\mathbb{R}^{2^{M_{\mathrm{col}}}}\ \text{に適用}\bigr)\\
&\leq c^k\bigl(c\|x\|\bigr)
  &&\bigl(\because\ \text{いま示した評価}\ \|Wx\|\leq c\|x\|\ \text{と}\ c^k\geq 0\ \text{（}c>0\text{）}\bigr)\\
&=c^{k+1}\|x\|
  &&\bigl(\because\ \text{冪の指数法則と}\ \mathbb{R}\ \text{の乗法の結合則}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意に取ったので、",
        math(String.raw`k+1`),
        " のときもすべての ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " について成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: SageMath の検算（sagemath/check/rayleigh_bounds_operator_norm/）を付けるにあたり、二か所を直した（主張は不変）。(1) 一つ目の鎖は ‖Wx‖^2 = (Wx)^⊤(Wx) = y^⊤(Wx) で止まり、続く鎖が使う y^⊤Wx（def_real_bilinear_value の二重和）との等号が書かれていなかった。def_matrix_norm・definition_of_sqrt_r_positive・y の成分・分配則・def_real_bilinear_value の 5 行（‖Wx‖^2 = ‖y‖^2 の置き換えと合わせて 6 行）で ‖Wx‖^2 = y^⊤Wx まで一続きにし、y ∈ ℝ^n であることを置き方に書いた（y の成分と鎖の 4 行目に mat_mult を引き、‖Wx‖^2 = ‖y‖^2 の置き換えを独立の行にした）。k = 0 の行に def_exp (1) の A^0 := I・identity_matrix_is_left_unit_of_mat_mult・c^0 = 1 の 3 行の鎖を置いた。(2) 帰納法の段の 1 行目 ‖W^{k+1}x‖ = ‖W(W^kx)‖ は「行列の冪の定義と結合則」としていたが、def_exp (1) の冪は W^{k+1} := W^kW で、W(W^kx) にするには W^kW = WW^k が要り、その主張は本文に無い。W^{k+1}x = (W^kW)x = W^k(Wx) とし、帰納法の仮定（すべての x について）を Wx に当て、前半の評価を後に使う順にした。",
      ],
    },
  },
  {
    id: "maxeig_008a_claim_trace_power_upper_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 10 },
    title: { tex: String.raw`\mathrm{tr}(W^{n}) \leq 2^{M_{\mathrm{col}}} c(M_{\mathrm{col}})^{n}` },
    labels: ["trace_power_upper_bound"],
    statement: [
      paragraph([math(String.raw`n \in \mathbb{Z}_{\geq 1}`), " について"]),
      displayMath(String.raw`\mathrm{tr}\!\left(W^{n}\right)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{n}`),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M_{\mathrm{col}})`),
        "、",
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記し、",
        math(String.raw`e_1,\dots,e_d`),
        " を標準基底とする。",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、その冪 ",
        math(String.raw`W^n`),
        " も実対称である。標準基底を用いるトレースの表示は、次の一続きの等式で得られる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(W^n)
&=\sum_{k=1}^{d}(W^n)_{kk}
&&\bigl(\because\ \text{トレースの定義}\bigr)\\
&=\sum_{k=1}^{d} e_k^\top W^n e_k
&&\bigl(\because\ \text{標準基底 }e_k\text{ による対角成分の表示 }(W^n)_{kk}=e_k^\top W^n e_k\bigr)
\end{aligned}`),
      paragraph([
        "まず ",
        math(String.raw`n = 2a`),
        " が偶数の場合。各 ",
        math(String.raw`k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top W^{2a}e_k
&=(W^a e_k)^\top(W^a e_k)
&&\bigl(\because\ W^{2a}=W^aW^a\ \text{（冪の指数法則）と}\ (W^a)^\top=W^a\ \text{（}W\text{ は実対称）}\bigr)\\
&=\|W^a e_k\|^2
&&\bigl(\because\ \text{ノルムの定義}\bigr)\\
&\leq \bigl(c^a\,\|e_k\|\bigr)^2
&&\bigl(\because\ \text{作用素ノルムのレイリー上限評価の}\ a\ \text{回の適用と、非負の両辺の二乗は順序を保つ}\bigr)\\
&=c^{2a}\,\|e_k\|^2
&&\bigl(\because\ \text{積の冪は冪の積}\bigr)\\
&=c^{n}
&&\bigl(\because\ \|e_k\|=1\ \text{と}\ n=2a\bigr)
\end{aligned}`),
      paragraph([
        "である（レイリー上限評価は ",
        ref("rayleigh_bounds_operator_norm"),
        "）。次に ",
        math(String.raw`n = 2a+1`),
        " が奇数なら",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top W^{2a+1}e_k
&=(W^ae_k)^\top W(W^ae_k)
&&\bigl(\because\ W^{2a+1}=W^aWW^a\ \text{（冪の指数法則）と}\ (W^a)^\top=W^a\ \text{（}W\text{ は実対称）}\bigr)\\
&\leq c\,\|W^ae_k\|^2
&&\bigl(\because\ \text{レイリー商の上限 }c\text{ の定義}\bigr)\\
&\leq c\,\bigl(c^a\|e_k\|\bigr)^2
&&\bigl(\because\ \text{作用素ノルムのレイリー上限評価の}\ a\ \text{回の適用と、非負量による乗法は順序を保つ}\bigr)\\
&=c\cdot c^{2a}\,\|e_k\|^2
&&\bigl(\because\ \text{積の冪は冪の積}\bigr)\\
&=c^{2a+1}
&&\bigl(\because\ \|e_k\|=1\ \text{と冪の指数法則}\bigr)\\
&=c^n
&&\bigl(\because\ n=2a+1\bigr)
\end{aligned}`),
      paragraph([
        "（1 つ目の不等号は ",
        ref("def_rayleigh_sup"),
        "）。いずれの場合も ",
        math(String.raw`e_k^\top W^ne_k \leq c^n`),
        " である。これを標準基底の全体にわたって足すと",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(W^n)
&=\sum_{k=1}^{d} e_k^\top W^n e_k
&&\bigl(\because\ \text{冒頭のトレースの標準基底表示}\bigr)\\
&\leq \sum_{k=1}^{d} c^n
&&\bigl(\because\ \text{各 }k\text{ の評価 }e_k^\top W^ne_k \leq c^n\text{ と、項ごとの不等式の有限和は順序を保つ}\bigr)\\
&=d\,c^n
&&\bigl(\because\ \text{同じ項 }c^n\text{ を }d\text{ 個足した和}\bigr)\\
&=2^{M_{\mathrm{col}}} c^n
&&\bigl(\because\ d=2^{M_{\mathrm{col}}}\ \text{（冒頭の略記）}\bigr)
\end{aligned}`),
      paragraph(["となり、上からの評価を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、トレースの挟み込みを上からの評価・モーメントの対数凸性・下からの評価の三主張へ分けた。この主張は上からの評価だけを扱う。式変形と根拠は分割前と同じで、後置きしていた作用素評価の参照を適用行の末尾へ移した。",
      ],
    },
  },
  {
    id: "maxeig_008b_claim_moment_log_convexity",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 10 },
    title: { text: "モーメント列の正値性と対数凸性" },
    labels: ["moment_log_convexity"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " は ",
        ref("W_is_real_symmetric_positive_definite"),
        " より実対称正定値である。単位ベクトル ",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "（",
        math(String.raw`\|x\| = 1`),
        "）を固定し、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`m_k := x^\top W^k x`),
        " とおく。このとき全ての ",
        math(String.raw`k`),
        " について ",
        math(String.raw`m_k > 0`),
        " であり、",
      ]),
      displayMath(String.raw`m_k^{\,2} \leq m_{k-1}\,m_{k+1} \qquad (k \in \mathbb{Z}_{\geq 1})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "単位ベクトル ",
        math(String.raw`x`),
        " を固定し ",
        math(String.raw`m_k := x^\top W^k x`),
        "（",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        "）とおく。",
        math(String.raw`W`),
        " は正定値なので ",
        math(String.raw`m_k > 0`),
        " である（",
        math(String.raw`k = 2a`),
        " なら ",
        math(String.raw`m_k = \|W^ax\|^2 > 0`),
        "、",
        math(String.raw`k = 2a+1`),
        " なら ",
        math(String.raw`m_k = (W^ax)^\top W(W^ax) > 0`),
        "。いずれも ",
        math(String.raw`W`),
        " が可逆なので ",
        math(String.raw`W^ax \neq 0`),
        "）。",
      ]),
      paragraph([
        ref("psd_cauchy_schwarz"),
        " を ",
        math(String.raw`P = W`),
        "、",
        math(String.raw`x \to W^{a}x`),
        "、",
        math(String.raw`y \to W^{b}x`),
        " として使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b+1}\right)^2
&=\left(x^\top W^{a+b+1}x\right)^2
&&\bigl(\because\ m_k=x^\top W^kx\ \text{の定義}\bigr)\\
&=\left(\left(W^bx\right)^\top W\left(W^ax\right)\right)^2
&&\bigl(\because\ W^{a+b+1}=W^bWW^a\ \text{（冪の指数法則）と}\ (W^b)^\top=W^b\ \text{（}W\text{ は実対称）}\bigr)\\
&\leq\left(\left(W^ax\right)^\top W\left(W^ax\right)\right)
  \left(\left(W^bx\right)^\top W\left(W^bx\right)\right)
&&\bigl(\because\ \text{半正定値双線型形式の Cauchy--Schwarz の不等式を }P=W\text{ として適用}\bigr)\\
&=\left(x^\top W^{2a+1}x\right)\left(x^\top W^{2b+1}x\right)
&&\bigl(\because\ (W^a)^\top=W^a\text{、}(W^b)^\top=W^b\text{ と冪の指数法則}\bigr)\\
&=m_{2a+1}\,m_{2b+1}
&&\bigl(\because\ m_k=x^\top W^kx\ \text{の定義を両因子へ適用}\bigr)
\end{aligned}`),
      paragraph([
        "同様に ",
        ref("psd_cauchy_schwarz"),
        " を ",
        math(String.raw`P = I`),
        "（半正定値）として使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b}\right)^2
&=\left(x^\top W^{a+b}x\right)^2
&&\bigl(\because\ m_k=x^\top W^kx\ \text{の定義}\bigr)\\
&=\left(x^\top W^bW^ax\right)^2
&&\bigl(\because\ \text{冪の指数法則}\bigr)\\
&=\left(\left(W^bx\right)^\top\left(W^ax\right)\right)^2
&&\bigl(\because\ (W^b)^\top=W^b\ \text{（}W\text{ は実対称）}\bigr)\\
&\leq \|W^ax\|^2\,\|W^bx\|^2
&&\bigl(\because\ \text{半正定値双線型形式の Cauchy--Schwarz の不等式を }P=I\text{ として適用}\bigr)\\
&=\left(\left(W^ax\right)^\top\left(W^ax\right)\right)
  \left(\left(W^bx\right)^\top\left(W^bx\right)\right)
&&\bigl(\because\ \text{ユークリッドノルムの定義}\bigr)\\
&=\left(x^\top W^aW^ax\right)\left(x^\top W^bW^bx\right)
&&\bigl(\because\ (W^a)^\top=W^a\ \text{かつ }(W^b)^\top=W^b\ \text{（}W\text{ は実対称）}\bigr)\\
&=\left(x^\top W^{2a}x\right)\left(x^\top W^{2b}x\right)
&&\bigl(\because\ \text{冪の指数法則を両因子へ適用}\bigr)\\
&=m_{2a}\,m_{2b}
&&\bigl(\because\ m_k=x^\top W^kx\ \text{の定義を両因子へ適用}\bigr)
\end{aligned}`),
      paragraph([
        "この 2 式から、任意の ",
        math(String.raw`k \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(String.raw`m_k^{\,2} \leq m_{k-1}\,m_{k+1} \qquad (k \in \mathbb{Z}_{\geq 1})`),
      paragraph([
        "が従う。",
        math(String.raw`k`),
        " の偶奇でどちらの式を使うかを分け、いずれの場合も ",
        math(String.raw`a := \left\lfloor (k-1)/2 \right\rfloor`),
        "、",
        math(String.raw`b := a+1`),
        " と取る。",
      ]),
      paragraph([
        math(String.raw`k=2p+1`),
        "（奇数、",
        math(String.raw`p\in\mathbb{Z}_{\geq0}`),
        "）の場合は ",
        math(String.raw`(a,b)=(p,p+1)`),
        " と取る。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
m_k^{\,2}
&=\left(m_{a+b}\right)^2
&&(\because\ k=2p+1=a+b)\\
&\leq m_{2a}\,m_{2b}
&&(\because\ P=I\ \text{版の不等式})\\
&=m_{2p}\,m_{2p+2}
&&(\because\ a=p,\ b=p+1)\\
&=m_{k-1}\,m_{k+1}
&&(\because\ k=2p+1)
\end{aligned}`),
      paragraph([
        math(String.raw`k=2p+2`),
        "（偶数、",
        math(String.raw`p\in\mathbb{Z}_{\geq0}`),
        "）の場合も ",
        math(String.raw`(a,b)=(p,p+1)`),
        " と取る。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
m_k^{\,2}
&=\left(m_{a+b+1}\right)^2
&&(\because\ k=2p+2=a+b+1)\\
&\leq m_{2a+1}\,m_{2b+1}
&&(\because\ P=W\ \text{版の不等式})\\
&=m_{2p+1}\,m_{2p+3}
&&(\because\ a=p,\ b=p+1)\\
&=m_{k-1}\,m_{k+1}
&&(\because\ k=2p+2)
\end{aligned}`),
      paragraph(["（添字の確認。奇数の場合は"]),
      displayMath(String.raw`\begin{aligned}
a+b &= p+(p+1)
&&(\because\ a=p,\ b=p+1)\\
&= 2p+1
&&(\because\ \mathbb{Z}\text{ の加法})\\
&= k
&&(\because\ k=2p+1)\\
2a &= 2p
&&(\because\ a=p)\\
&= k-1
&&(\because\ k=2p+1\ \text{の両辺から }1\text{ を引く})\\
2b &= 2(p+1)
&&(\because\ b=p+1)\\
&= 2p+2
&&(\because\ \mathbb{Z}\text{ の分配則})\\
&= k+1
&&(\because\ k=2p+1\ \text{の両辺へ }1\text{ を足す})
\end{aligned}`),
      paragraph(["であり、偶数の場合は"]),
      displayMath(String.raw`\begin{aligned}
a+b+1 &= p+(p+1)+1
&&(\because\ a=p,\ b=p+1)\\
&= 2p+2
&&(\because\ \mathbb{Z}\text{ の加法})\\
&= k
&&(\because\ k=2p+2)\\
2a+1 &= 2p+1
&&(\because\ a=p)\\
&= k-1
&&(\because\ k=2p+2\ \text{の両辺から }1\text{ を引く})\\
2b+1 &= 2(p+1)+1
&&(\because\ b=p+1)\\
&= 2p+3
&&(\because\ \mathbb{Z}\text{ の分配則と加法})\\
&= k+1
&&(\because\ k=2p+2\ \text{の両辺へ }1\text{ を足す})
\end{aligned}`),
      paragraph([
        "である。また ",
        math(String.raw`k \geq 1`),
        " より奇数の場合 ",
        math(String.raw`p = (k-1)/2 \in \mathbb{Z}_{\geq 0}`),
        "、偶数の場合は ",
        math(String.raw`k \geq 2`),
        " なので ",
        math(String.raw`p = (k-2)/2 \in \mathbb{Z}_{\geq 0}`),
        " であり、どちらも ",
        math(String.raw`p = \left\lfloor (k-1)/2 \right\rfloor = a`),
        "。現れる指数はすべて ",
        math(String.raw`\mathbb{Z}_{\geq 0}`),
        " に収まるので、",
        math(String.raw`m_j`),
        " はいずれも定義済みである。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、トレースの挟み込みから独立した主張として切り出した。式変形と根拠は分割前と同じである。",
      ],
    },
  },
  {
    id: "maxeig_008_claim_trace_power_sandwich",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 10 },
    title: { tex: String.raw`c(M_{\mathrm{col}})^{n} \leq \mathrm{tr}(W^{n}) \leq 2^{M_{\mathrm{col}}} c(M_{\mathrm{col}})^{n}` },
    labels: ["trace_power_sandwich"],
    statement: [
      paragraph([math(String.raw`n \in \mathbb{Z}_{\geq 1}`), " について"]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{n} \ \leq\ \mathrm{tr}\!\left(W^{n}\right)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{n}`,
      ),
    ],
    proof: [
      paragraph([
        "まず、任意の ",
        math(String.raw`k \geq 1`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{m_k}{m_{k-1}}
&=\frac{m_k^2}{m_{k-1}\,m_k}
&&\bigl(\because\ \text{分子と分母に }m_k>0\text{ を掛けた（}\blkref{moment_log_convexity}\text{ の正値性）}\bigr)\\
&\leq\frac{m_{k-1}\,m_{k+1}}{m_{k-1}\,m_k}
&&\bigl(\because\ \text{対数凸性 }\blkref{moment_log_convexity}\text{ と、正の分母での商は順序を保つ}\bigr)\\
&=\frac{m_{k+1}}{m_k}
&&\bigl(\because\ m_{k-1}>0\ \text{の約分}\bigr)
\end{aligned}`),
      paragraph([
        "であり、比 ",
        math(String.raw`m_{k+1}/m_k`),
        " は ",
        math(String.raw`k`),
        " について単調非減少である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
m_n
&=m_0\cdot\frac{m_1}{m_0}\cdot\frac{m_2}{m_1}\cdots\frac{m_n}{m_{n-1}}
&&\bigl(\because\ \text{望遠鏡積（分母は }\blkref{moment_log_convexity}\text{ の正値性により零でない）}\bigr)\\
&=\frac{m_1}{m_0}\cdot\frac{m_2}{m_1}\cdots\frac{m_n}{m_{n-1}}
&&\bigl(\because\ m_0=x^\top W^0x=\|x\|^2=1\ \text{（}x\text{ は単位ベクトル）}\bigr)\\
&\geq\left(\frac{m_1}{m_0}\right)^{n}
&&\bigl(\because\ \text{各 }j\text{ で }\tfrac{m_j}{m_{j-1}}\geq\tfrac{m_1}{m_0}\text{（上の単調非減少を }j-1\text{ 回適用）と、}\\
&&&\quad\text{正の項どうしの積は順序を保つ}\bigr)\\
&=\left(x^\top Wx\right)^{n}
&&\bigl(\because\ m_1=x^\top Wx\ \text{と}\ m_0=1\bigr)
\end{aligned}`),
      paragraph([
        "一方、",
        math(String.raw`W^n`),
        " は正定値（",
        math(String.raw`W`),
        " が正定値なので、",
        math(String.raw`n`),
        " が偶数なら ",
        math(String.raw`y^\top W^ny = \|W^{n/2}y\|^2`),
        "、奇数なら ",
        math(String.raw`(W^{(n-1)/2}y)^\top W(W^{(n-1)/2}y)`),
        " がいずれも ",
        math(String.raw`y \neq 0`),
        " で正）であり、半正定値行列 ",
        math(String.raw`A`),
        " については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top A x
&=|x^\top A x|
&&\bigl(\because\ A\text{ は半正定値なので }0\leq x^\top A x\bigr)\\
&=\left|\sum_{k,l=1}^{d}x_kx_lA_{kl}\right|
&&\bigl(\because\ \text{行列の積の成分表示}\bigr)\\
&\leq\sum_{k,l=1}^{d}|x_k|\,|x_l|\,|A_{kl}|
&&\bigl(\because\ \text{有限和の三角不等式}\bigr)\\
&\leq\sum_{k,l=1}^{d}|x_k|\,|x_l|\sqrt{A_{kk}A_{ll}}
&&\bigl(\because\ \text{半正定値の Cauchy--Schwarz }\blkref{psd_cauchy_schwarz}\ \text{を}\ P=A,\ x=e_k,\ y=e_l\ \text{に適用して}\ |A_{kl}|\leq\sqrt{A_{kk}A_{ll}}\bigr)\\
&=\sum_{k,l=1}^{d}|x_k|\,|x_l|\sqrt{A_{kk}}\sqrt{A_{ll}}
&&\bigl(\because\ A_{kk},A_{ll}\geq0\text{ と平方根の積の法則}\bigr)\\
&=\left(\sum_{k=1}^{d}|x_k|\sqrt{A_{kk}}\right)^2
&&\bigl(\because\ \text{有限和の分配則}\bigr)\\
&\leq\left(\sum_{k=1}^{d}x_k^2\right)\left(\sum_{k=1}^{d}A_{kk}\right)
&&\bigl(\because\ \text{半正定値の Cauchy--Schwarz }\blkref{psd_cauchy_schwarz}\ \text{を}\ P=I\ \text{と}\\
&&&\quad\text{二つのベクトル}\ \left(|x_k|\right)_k,\ \left(\sqrt{A_{kk}}\right)_k\ \text{に適用}\bigr)\\
&=\|x\|^2\,\mathrm{tr}(A)
&&\bigl(\because\ \text{ノルムとトレースの定義}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "この評価を ",
        math(String.raw`A = W^n`),
        " と単位ベクトル ",
        math(String.raw`x`),
        " に適用すると",
      ]),
      displayMath(String.raw`\begin{aligned}
m_n
&=x^\top W^nx
&&\bigl(\because\ m_n=x^\top W^nx\ \text{の定義}\bigr)\\
&\leq\|x\|^2\,\mathrm{tr}(W^n)
&&\bigl(\because\ \text{上の評価を半正定値行列}\ A=W^n\ \text{へ適用}\bigr)\\
&=\mathrm{tr}(W^n)
&&\bigl(\because\ \|x\|=1\ \text{（}x\text{ は単位ベクトル）}\bigr)
\end{aligned}`),
      paragraph(["である。以上を合わせると、任意の単位ベクトル ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\left(x^\top Wx\right)^{n} \leq m_n \leq \mathrm{tr}(W^n)`),
      paragraph([
        "である。左辺の ",
        math(String.raw`x`),
        " についての上限を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
c^{n}
&=\left(\sup_{\|x\|=1}x^\top Wx\right)^{n}
&&\bigl(\because\ c\ \text{の定義}\bigr)\\
&=\sup_{\|x\|=1}\left(x^\top Wx\right)^{n}
&&\bigl(\because\ t\mapsto t^n\ \text{は}\ \mathbb{R}_{>0}\ \text{上で単調増加なので、上限と可換}\bigr)\\
&\leq\mathrm{tr}(W^n)
&&\bigl(\because\ \text{各単位ベクトル}\ x\ \text{で}\ (x^\top Wx)^n\leq\mathrm{tr}(W^n)\ \text{（上の鎖）なので}\\
&&&\quad\mathrm{tr}(W^n)\ \text{は上界であり、上限は最小の上界}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`c^n \leq \mathrm{tr}(W^n)`),
        " を得る（",
        math(String.raw`c`),
        " の定義は ",
        ref("def_rayleigh_sup"),
        "）。上からの評価 ",
        math(String.raw`\mathrm{tr}(W^n) \leq 2^{M_{\mathrm{col}}} c^n`),
        " は ",
        ref("trace_power_upper_bound"),
        " である。二つを合わせて主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この証明はスペクトル定理（実対称行列の対角化可能性）を使っていない。c(M) は上限として定義され、上からの評価は rayleigh_bounds_operator_norm、下からの評価はモーメント列の対数凸性による。対角化可能性は正しいが本文にまだ無く、挟み撃ちには不要である。",
        "2026-08-14 の式変形統一で、Step 2 の対数凸性を任意の k へ移す奇数・偶数の場合分けを、それぞれ四段の一続きの不等式鎖へ開き、各行末に根拠を置いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、Step 3 冒頭の比の単調性（三段）と望遠鏡積からの下からの評価（四段）を、それぞれ一続きの根拠付きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、半正定値行列の二次形式をトレースで上から評価する計算を、成分表示・二つの Cauchy--Schwarz・有限和の分配則を行末根拠にした八段の一続きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、トレース評価の A = W^n への適用（三段）と、単位ベクトル上の上限を取って c^n ≤ tr(W^n) を得る圧縮（三段）を、それぞれ行末根拠付きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、モーメントの対数凸性に使う P = W 版の Cauchy--Schwarz の一行圧縮を、定義・冪の指数法則・実対称性・不等式・定義への復帰の五段へ開いた。内容は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_009_claim_partition_function_sandwich",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 11 },
    title: { text: "分配関数の挟み撃ち" },
    labels: ["partition_function_sandwich"],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " と同じ設定のもと、",
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \ \leq\ Z(K_1,K_2)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`,
      ),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
Z(K_1,K_2)
&=\mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)
  &&\bigl(\because\ \blkref{Z_equals_trace_of_W}\bigr)\\
&\geq c(M_{\mathrm{col}})^{N_{\mathrm{row}}}
  &&\bigl(\because\ \blkref{trace_power_sandwich}\ \text{の下からの評価を}\ n=N_{\mathrm{row}}\ \text{に適用}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Z(K_1,K_2)
&=\mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)
  &&\bigl(\because\ \blkref{Z_equals_trace_of_W}\bigr)\\
&\leq 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}}
  &&\bigl(\because\ \blkref{trace_power_sandwich}\ \text{の上からの評価を}\ n=N_{\mathrm{row}}\ \text{に適用}\bigr)
\end{aligned}`),
      paragraph(["この二つを合わせて主張を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、一文にまとめていた二段の適用を、下からの評価と上からの評価の二つの鎖へ開いた。内容と根拠は変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
      ],
    },
  },
  {
    id: "freeenergy_003_claim_limit_in_N_row",
    kind: "claim",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 5 },
    title: { tex: String.raw`N_{\mathrm{row}} \to \infty \text{ の極限}` },
    labels: ["limit_of_log_Z_in_N_row"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " を固定する。",
        ref("partition_function_sandwich"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " について、極限",
      ]),
      displayMath(
        String.raw`\lim_{N_{\mathrm{row}} \to \infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2)
= \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`,
      ),
      paragraph([
        "が存在する。すなわち、行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " についての極限は ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " だけで決まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`Z := Z(K_1,K_2)`),
        "、",
        math(String.raw`c := c(M_{\mathrm{col}})`),
        " と略記する。",
        ref("def_partition_function_2d_ising"),
        " より ",
        math(String.raw`Z \in \mathbb{R}_{>0}`),
        "、",
        ref("def_rayleigh_sup"),
        " より ",
        math(String.raw`c > 0`),
        " なので、両者の ",
        math(String.raw`\log`),
        " が定まる。",
      ]),
      paragraph([
        ref("partition_function_sandwich"),
        " の挟み込みから始めて、一続きに変形する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&c^{N_{\mathrm{row}}} \leq Z \leq 2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}}
&&\left(\because\ \text{分配関数の挟み込み}\right)\\
\Longrightarrow\ &\log(c^{N_{\mathrm{row}}}) \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ \log\text{ は }\mathbb{R}_{>0}\text{ 上で狭義単調増加}\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ \log(c^{N_{\mathrm{row}}})=N_{\mathrm{row}}\log c\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}})+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \log(ab)=\log a+\log b\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq M_{\mathrm{col}}\log 2+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \log(2^{M_{\mathrm{col}}})=M_{\mathrm{col}}\log 2\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq M_{\mathrm{col}}\log 2+N_{\mathrm{row}}\log c
&&\left(\because\ \log(c^{N_{\mathrm{row}}})=N_{\mathrm{row}}\log c\right)\\
\Longrightarrow\ &\frac{1}{M_{\mathrm{col}}}\log c \leq \frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z \leq \frac{1}{M_{\mathrm{col}}}\log c + \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \text{各辺を }M_{\mathrm{col}}N_{\mathrm{row}}>0\text{ で割る。正の数で割っても不等号は保たれる}\right)\\
\Longrightarrow\ &\left|\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z - \frac{1}{M_{\mathrm{col}}}\log c\right| \leq \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \text{上下の評価が中心 }\tfrac{1}{M_{\mathrm{col}}}\log c\text{ からの差を }\tfrac{\log 2}{N_{\mathrm{row}}}\text{ で挟む。}\mathbb{R}\text{ の四則}\right).
\end{aligned}`,
      ),
      paragraph([
        "右辺は ",
        math(String.raw`N_{\mathrm{row}} \to \infty`),
        " で ",
        math(String.raw`0`),
        " に収束する（",
        math(String.raw`\log 2`),
        " は ",
        math(String.raw`N_{\mathrm{row}}`),
        " に依らない定数）。よって主張の極限が存在して値は ",
        math(String.raw`\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
        " である。",
      ]),
      paragraph([
        "**この段階では実数解析へ移行していない**：使ったのは有限個の実数の不等式、",
        math(String.raw`\log`),
        " の単調性と乗法から加法への変換、および実数列 ",
        math(String.raw`(\log 2)/N_{\mathrm{row}} \to 0`),
        " だけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。挟み込みへの log の適用・MN による割り算・中心からの差の評価が散文で継がれた 3 つの表示に分かれていたのを、一続きの含意の鎖へまとめ、根拠を各行末の (∵ …) へ移した。極限の存在の論法と参照は変更していない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
      ],
    },
  },

  {
    id: "row_limit_and_max_eigenvalue_claim_sandwich_and_limit_in_N_row",
    kind: "claim",
    standing: "mainTheorem",
    title: {
      tex: String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \leq Z \leq 2^{M_{\mathrm{col}}}c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \text{ と } \lim_{N_{\mathrm{row}}\to\infty}\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`,
    },
    labels: ["partition_function_sandwich_and_limit_in_N_row"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（",
        ref("def_partition_function_2d_ising"),
        " の定義域が ",
        math(String.raw`\mathbb{R}_{>0}\times\mathbb{R}_{>0}`),
        " であるため）、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W = V_1^{1/2}\,V_2\,V_1^{1/2} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（成分はすべて実数。",
        ref("W_is_real_symmetric_positive_definite"),
        "。成分が ",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_exp"),
        " の行列の指数関数の値であるため。指数評価による脱出）と、",
        ref("def_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\ x \in \mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\} \in \mathbb{R}_{>0}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、上限の存在を ",
        math(String.raw`\mathbb{R}`),
        " の完備性から得るため。完備性による脱出）について、",
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(K_1,K_2) \in \mathbb{R}_{>0}`),
        "（行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " に依る。",
        math(String.raw`\mathbb{R}`),
        " に住むのは、実数の指数関数の値の有限和であるため。指数評価による脱出）は次を満たす。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \ \leq\ Z(K_1,K_2)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \qquad (N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \lim_{N_{\mathrm{row}} \to \infty}\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2) = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
          "（",
          math(String.raw`\log`),
          " は正の実数上の実対数で、値は ",
          math(String.raw`\mathbb{R}`),
          " に住む。実対数と極限による脱出）",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("partition_function_sandwich"),
        " そのものである。",
      ]),
      paragraph([
        "(2) ",
        ref("limit_of_log_Z_in_N_row"),
        " そのものである（その証明は (1) の挟み撃ちから始まる）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、N→∞ の極限と最大固有値 c(M) の章のゴールの式（W・c(M) の定義のもとでの c(M)^N ≤ Z ≤ 2^M c(M)^N と lim (1/(MN)) log Z = (1/M) log c(M)）を一つの主張として立てた。既存の主張 partition_function_sandwich・limit_of_log_Z_in_N_row を並べるだけで、新しい証明は無い。",
      ],
    },
  },
]);
