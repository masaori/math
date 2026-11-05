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
        ref("iH_is_real_symmetric"),
        " の Step 3 と同じく ",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と書く。",
        math(String.raw`D`),
        " は ",
        ref("def_transfer_matrix_square_root"),
        " の ",
        math(String.raw`D := \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        "（",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z := \sigma_1^z`),
        "、",
        ref("def_site_pauli_periodic_extension"),
        "）であり、",
        math(String.raw`K_1 \in \mathbb{R}`),
        " の ",
        math(String.raw`K_1D`),
        " は ",
        math(String.raw`(K_1)_{\mathbb{C}}D`),
        "（",
        math(String.raw`(K_1)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "）を表す。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`m^{+} := m+1`),
        "（",
        math(String.raw`m \leq M_{\mathrm{col}}-1`),
        "）、",
        math(String.raw`m^{+} := 1`),
        "（",
        math(String.raw`m = M_{\mathrm{col}}`),
        "）とおく。",
        math(String.raw`m^{+} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " である。",
        math(String.raw`\sigma_{m+1}^z = \sigma_{m^{+}}^z`),
        " である。",
        math(String.raw`m \leq M_{\mathrm{col}}-1`),
        " のときは ",
        math(String.raw`m^{+}`),
        " の定義そのものであり、",
        math(String.raw`m = M_{\mathrm{col}}`),
        " のときは ",
        ref("def_site_pauli_periodic_extension"),
        " より ",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z = \sigma_1^z`),
        " である。また ",
        math(String.raw`\sigma_{m^{+}}^z\sigma_m^z = \sigma_m^z\sigma_{m^{+}}^z`),
        " である。",
        math(String.raw`m^{+} \neq m`),
        " のときは ",
        ref("distinct_site_pauli_matrices_commute"),
        "（",
        math(String.raw`j \to m^{+},\ k \to m,\ a, b \to z`),
        "）による。",
        math(String.raw`m^{+} = m`),
        " となるのは ",
        math(String.raw`M_{\mathrm{col}} = 1`),
        " のときに限り、このとき両辺は同じ行列 ",
        math(String.raw`\sigma_1^z\sigma_1^z`),
        " である。",
      ]),
      paragraph([
        "まず転置（",
        ref("def_matrix_transpose"),
        "）を計算する。",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について（",
        math(String.raw`k = 1`),
        " のとき第 ",
        math(String.raw`k`),
        " 因子より前の因子は無く、",
        math(String.raw`k = M_{\mathrm{col}}`),
        " のとき第 ",
        math(String.raw`k`),
        " 因子より後の因子は無い）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sigma_k^z\right)^\top
&= \Bigl(I\boxtimes\cdots\boxtimes\overbrace{\sigma^{z}}^{k\text{th}}\boxtimes\cdots\boxtimes I\Bigr)^\top
   \quad (\because \blkref{def_site_pauli_matrices}\ (k \to k,\ a \to z)) \\
&= I^\top\boxtimes\cdots\boxtimes\overbrace{\left(\sigma^{z}\right)^\top}^{k\text{th}}\boxtimes\cdots\boxtimes I^\top
   \quad (\because \blkref{kronecker_transpose}\ (M \to M_{\mathrm{col}},\ A_k \to \sigma^z,\ A_j \to I\ (j \neq k))) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\left(\sigma^{z}\right)^\top}^{k\text{th}}\boxtimes\cdots\boxtimes I
   \quad (\because \blkref{transpose_of_identity_matrix_of_order_two}\ \text{を第}\ k\ \text{因子以外の因子へ同時に適用}) \\
&= I\boxtimes\cdots\boxtimes\overbrace{\sigma^{z}}^{k\text{th}}\boxtimes\cdots\boxtimes I
   \quad (\because \blkref{transpose_of_pauli_z}\ \text{を第}\ k\ \text{因子へ}) \\
&= \sigma_k^z
   \quad (\because \blkref{def_site_pauli_matrices}\ (k \to k,\ a \to z))
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\sigma_m^z\sigma_{m+1}^z\right)^\top
&= \left(\sigma_m^z\sigma_{m^{+}}^z\right)^\top
   \quad (\because \text{準備の } \sigma_{m+1}^z = \sigma_{m^{+}}^z) \\
&= \left(\sigma_{m^{+}}^z\right)^\top\left(\sigma_m^z\right)^\top
   \quad (\because \blkref{transpose_of_matrix_product}\ (\text{主張の行数・列数 } m, n, p \to 2^{M_{\mathrm{col}}},\ A \to \sigma_m^z,\ B \to \sigma_{m^{+}}^z)) \\
&= \sigma_{m^{+}}^z\sigma_m^z
   \quad (\because \text{上で得た } \left(\sigma_k^z\right)^\top = \sigma_k^z \text{ を } k \to m^{+} \text{ と } k \to m \text{ へ同時に適用}) \\
&= \sigma_m^z\sigma_{m^{+}}^z
   \quad (\because \text{準備の } \sigma_{m^{+}}^z\sigma_m^z = \sigma_m^z\sigma_{m^{+}}^z) \\
&= \sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{準備の } \sigma_{m+1}^z = \sigma_{m^{+}}^z)
\end{aligned}`,
      ),
      paragraph([
        "である。これを用いて ",
        math(String.raw`K_1D`),
        " の転置を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(K_1D\right)^\top
&= \Bigl((K_1)_{\mathbb{C}}\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\Bigr)^\top
   \quad (\because \blkref{def_transfer_matrix_square_root}\ \text{の}\ D\ \text{の定義}) \\
&= (K_1)_{\mathbb{C}}\Bigl(\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\Bigr)^\top
   \quad \left(\because\ \blkref{transpose_of_matrix_scalar_multiple}\ (\text{主張の行数・列数 } m, n \to 2^{M_{\mathrm{col}}},\ c \to (K_1)_{\mathbb{C}},\ A \to \textstyle\sum_{\ell=1}^{M_{\mathrm{col}}}\sigma_\ell^z\sigma_{\ell+1}^z)\right) \\
&= (K_1)_{\mathbb{C}}\sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)^\top
   \quad \left(\because\ \blkref{transpose_of_finite_sum_of_matrices}\ (\text{主張の行数・列数 } m, n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ X_\ell \to \sigma_\ell^z\sigma_{\ell+1}^z\ (1 \leq \ell \leq M_{\mathrm{col}}))\right) \\
&= (K_1)_{\mathbb{C}}\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{上で得た } \left(\sigma_m^z\sigma_{m+1}^z\right)^\top = \sigma_m^z\sigma_{m+1}^z \text{ を各項へ}) \\
&= K_1D
   \quad (\because \blkref{def_transfer_matrix_square_root}\ \text{の}\ D\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "次に成分が実数であること（",
        ref("def_matrix_with_real_entries"),
        "）を見る。",
        math(String.raw`k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_site_pauli_matrices"),
        "（",
        math(String.raw`k \to k,\ a \to z`),
        "）より ",
        math(String.raw`\sigma_k^z = I\boxtimes\cdots\boxtimes\overbrace{\sigma^{z}}^{k\text{th}}\boxtimes\cdots\boxtimes I`),
        " である。因子 ",
        math(String.raw`I`),
        " の成分はすべて実数（",
        ref("identity_matrix_of_order_two_has_real_entries"),
        "）、因子 ",
        math(String.raw`\sigma^z`),
        " の成分もすべて実数（",
        ref("pauli_z_has_real_entries"),
        "）なので、",
        ref("kronecker_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`M \to M_{\mathrm{col}},\ A_k \to \sigma^z,\ A_j \to I\ (j \neq k)`),
        "）より ",
        math(String.raw`\sigma_k^z`),
        " の成分はすべて実数である。",
      ]),
      paragraph([
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        math(String.raw`\sigma_m^z`),
        " と ",
        math(String.raw`\sigma_{m^{+}}^z`),
        " の成分はすべて実数なので、",
        ref("product_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n, p \to 2^{M_{\mathrm{col}}},\ A \to \sigma_m^z,\ B \to \sigma_{m^{+}}^z`),
        "）より ",
        math(String.raw`\sigma_m^z\sigma_{m^{+}}^z`),
        " の成分はすべて実数であり、",
        "準備の ",
        math(String.raw`\sigma_{m+1}^z = \sigma_{m^{+}}^z`),
        " より ",
        math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
        " の成分もすべて実数である。",
        ref("finite_sum_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n \to 2^{M_{\mathrm{col}}},\ r \to M_{\mathrm{col}},\ X_\ell \to \sigma_\ell^z\sigma_{\ell+1}^z\ (1 \leq \ell \leq M_{\mathrm{col}})`),
        "）より ",
        math(String.raw`D`),
        " の成分はすべて実数であり、",
        ref("real_scalar_multiple_of_real_entry_matrix_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n \to 2^{M_{\mathrm{col}}},\ c \to K_1,\ B \to D`),
        "）より ",
        math(String.raw`K_1D = (K_1)_{\mathbb{C}}D`),
        " の成分もすべて実数である。転置について対称であることと合わせて、",
        math(String.raw`K_1D`),
        " は実対称である（",
        ref("def_real_symmetric_complex_matrix"),
        "）。",
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
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: Step 1 の K_1D の実対称性が「iH_is_real_symmetric の Step 3 で見たとおり」と散文で済ませていた（その Step 3 は 1 ≤ m ≤ M_col−1 の σ_m^zσ_{m+1}^z しか扱わず、周期端 σ_{M_col}^zσ_1^z を覆わない）のを、(σ_k^z)^⊤ = σ_k^z の 5 行、(σ_m^zσ_{m+1}^z)^⊤ の 5 行（m^+ を置き、transpose_of_matrix_product と distinct_site_pauli_matrices_commute で。M_col = 1 は同じ行列）、(K_1D)^⊤ の 5 行と、成分の実性の 2 段落（kronecker_of_real_entry_matrices_has_real_entries・product_of_real_entry_matrices_has_real_entries・finite_sum_of_real_entry_matrices_has_real_entries・real_scalar_multiple_of_real_entry_matrix_has_real_entries）に書き直した。主張は不変。",
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
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "（",
        ref("def_rayleigh_sup"),
        "）、",
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記する。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`e_k \in \mathbb{R}^{d}`),
        " を、",
        math(String.raw`i \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`i = k`),
        " なら ",
        math(String.raw`(e_k)_i := 1`),
        "、",
        math(String.raw`i \neq k`),
        " なら ",
        math(String.raw`(e_k)_i := 0`),
        " で定める。",
      ]),
      paragraph([
        "【",
        math(String.raw`e_k`),
        " のノルム】",
      ]),
      displayMath(String.raw`\begin{aligned}
\|e_k\|
&=\sqrt{\sum_{i=1}^{d}|(e_k)_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R})\bigr)\\
&=\sqrt{|(e_k)_k|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ i \neq k\ \text{の項は}\ |(e_k)_i|^2 = |0|^2 = 0\bigr)\\
&=\sqrt{|1|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ (e_k)_k = 1\bigr)\\
&=\sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ |1|^2 = 1\bigr)\\
&=1
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ 1 \geq 0,\ 1^2 = 1\bigr)
\end{aligned}`),
      paragraph([
        "【冪の実対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p`),
        " は実対称である（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "）。すなわち ",
        math(String.raw`W^p`),
        " の成分はすべて実数で、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(W^p)_{kl}
&=\bigl((W^p)^\top\bigr)_{kl}
&&\bigl(\because\ W^p\ \text{は実対称なので}\ (W^p)^\top = W^p\ \text{（}\blkref{def_real_symmetric_complex_matrix}\text{）}\bigr)\\
&=(W^p)_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)
\end{aligned}`),
      paragraph([
        "である。以下、",
        ref("def_rayleigh_sup"),
        " が ",
        math(String.raw`W`),
        " を読むのと同じく、",
        math(String.raw`W^p`),
        " の成分を実数として ",
        math(String.raw`W^pe_k \in \mathbb{R}^d`),
        "（",
        ref("mat_mult"),
        "）と ",
        math(String.raw`x^\top W^p y`),
        "（",
        ref("def_real_bilinear_value"),
        "）を読む。",
      ]),
      paragraph([
        "【対角成分の表示】",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top W^p e_k
&=\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i\,(W^p)_{ij}\,(e_k)_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{j=1}^{d}(e_k)_k\,(W^p)_{kj}\,(e_k)_j
&&\bigl(\because\ i \neq k\ \text{の項は}\ (e_k)_i = 0\ \text{なので}\ 0\bigr)\\
&=\sum_{j=1}^{d}(W^p)_{kj}\,(e_k)_j
&&\bigl(\because\ (e_k)_k = 1\bigr)\\
&=(W^p)_{kk}\,(e_k)_k
&&\bigl(\because\ j \neq k\ \text{の項は}\ (e_k)_j = 0\ \text{なので}\ 0\bigr)\\
&=(W^p)_{kk}
&&\bigl(\because\ (e_k)_k = 1\bigr)
\end{aligned}`),
      paragraph([
        "【",
        math(String.raw`W^ae_k`),
        " の成分とノルム】",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`u := W^ae_k \in \mathbb{R}^d`),
        " とおく。",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
u_l
&=\sum_{m=1}^{d}(W^a)_{lm}\,(e_k)_m
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=(W^a)_{lk}\,(e_k)_k
&&\bigl(\because\ m \neq k\ \text{の項は}\ (e_k)_m = 0\ \text{なので}\ 0\bigr)\\
&=(W^a)_{lk}
&&\bigl(\because\ (e_k)_k = 1\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
\|u\|
&=\|W^ae_k\|
&&\bigl(\because\ u := W^ae_k\bigr)\\
&\leq c^a\,\|e_k\|
&&\bigl(\because\ \blkref{rayleigh_bounds_operator_norm}\ \text{の冪の主張を指数}\ a\ \text{と}\ x \to e_k\ \text{で適用}\bigr)\\
&=c^a
&&\bigl(\because\ \text{【}e_k\text{ のノルム】}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
\|u\|^2
&\leq \bigl(c^a\bigr)^2
&&\bigl(\because\ 0 \leq \|u\| \leq c^a\ \text{（上の式変形と}\ \blkref{def_matrix_norm}\ \text{の値が}\ \mathbb{R}_{\geq 0}\text{）と}\ \mathbb{R}_{\geq 0}\ \text{の平方の単調性}\bigr)\\
&=c^{2a}
&&\bigl(\because\ \mathbb{R}\ \text{の冪の指数法則}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        math(String.raw`n = 2a`),
        "（",
        math(String.raw`a \in \mathbb{Z}_{\geq 1}`),
        "）が偶数の場合。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " と【",
        math(String.raw`W^ae_k`),
        " の成分とノルム】の ",
        math(String.raw`u = W^ae_k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top W^{2a}e_k
&=(W^{2a})_{kk}
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to 2a)\bigr)\\
&=(W^{a+a})_{kk}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a = a+a\bigr)\\
&=(W^aW^a)_{kk}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p, q \to a)\bigr)\\
&=\sum_{l=1}^{d}(W^a)_{kl}\,(W^a)_{lk}
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{l=1}^{d}(W^a)_{lk}\,(W^a)_{lk}
&&\bigl(\because\ \text{【冪の実対称性】の}\ (W^a)_{kl} = (W^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}u_l\,u_l
&&\bigl(\because\ \text{【}W^ae_k\text{ の成分とノルム】の}\ u_l = (W^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}|u_l|^2
&&\bigl(\because\ u_l \in \mathbb{R}\ \text{なので}\ u_lu_l = |u_l|^2\bigr)\\
&=\|u\|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&\leq c^{2a}
&&\bigl(\because\ \text{【}W^ae_k\text{ の成分とノルム】の}\ \|u\|^2 \leq c^{2a}\bigr)\\
&=c^n
&&\bigl(\because\ n = 2a\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n = 2a+1`),
        "（",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        "）が奇数の場合。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
W^{2a+1}
&=W^{a+(1+a)}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a+1 = a+(1+a)\bigr)\\
&=W^aW^{1+a}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to a,\ q \to 1+a)\bigr)\\
&=W^a\bigl(W^1W^a\bigr)
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to 1,\ q \to a)\bigr)\\
&=W^a\bigl(W^{0+1}W^a\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=W^a\bigl((W^0W)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}\bigr)\\
&=W^a\bigl((I_{\mathrm{Mat}(d,\mathbb{C})}W)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=W^a\bigl(WW^a\bigr)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " と【",
        math(String.raw`W^ae_k`),
        " の成分とノルム】の ",
        math(String.raw`u = W^ae_k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top W^{2a+1}e_k
&=(W^{2a+1})_{kk}
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to 2a+1)\bigr)\\
&=\bigl(W^a(WW^a)\bigr)_{kk}
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&=\sum_{l=1}^{d}(W^a)_{kl}\,(WW^a)_{lk}
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{l=1}^{d}(W^a)_{kl}\sum_{m=1}^{d}W_{lm}\,(W^a)_{mk}
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}(W^a)_{kl}\,W_{lm}\,(W^a)_{mk}
&&\bigl(\because\ \text{分配則と乗法の結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}(W^a)_{lk}\,W_{lm}\,(W^a)_{mk}
&&\bigl(\because\ \text{【冪の実対称性】の}\ (W^a)_{kl} = (W^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}u_l\,W_{lm}\,u_m
&&\bigl(\because\ \text{【}W^ae_k\text{ の成分とノルム】の}\ u_l = (W^a)_{lk},\ u_m = (W^a)_{mk}\bigr)\\
&=u^\top Wu
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&\leq c\,\|u\|^2
&&\bigl(\because\ \blkref{def_rayleigh_sup}\ \text{の}\ x^\top Wx \leq c\|x\|^2\ (x \to u)\bigr)\\
&\leq c\,c^{2a}
&&\bigl(\because\ \text{【}W^ae_k\text{ の成分とノルム】の}\ \|u\|^2 \leq c^{2a}\ \text{と}\ c > 0\bigr)\\
&=c^{2a+1}
&&\bigl(\because\ \mathbb{R}\ \text{の冪の指数法則}\bigr)\\
&=c^n
&&\bigl(\because\ n = 2a+1\bigr)
\end{aligned}`),
      paragraph([
        "である。いずれの場合も、すべての ",
        math(String.raw`k`),
        " について ",
        math(String.raw`e_k^\top W^ne_k \leq c^n`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(W^n)
&=\sum_{k=1}^{d}(W^n)_{kk}
&&\bigl(\because\ \blkref{def_trace}\bigr)\\
&=\sum_{k=1}^{d} e_k^\top W^n e_k
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to n)\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&\leq \sum_{k=1}^{d} c^n
&&\bigl(\because\ \text{各}\ k\ \text{の}\ e_k^\top W^ne_k \leq c^n\ \text{と、項ごとの不等式の有限和は順序を保つ}\bigr)\\
&=d\,c^n
&&\bigl(\because\ \text{同じ項}\ c^n\ \text{を}\ d\ \text{個足した和}\bigr)\\
&=2^{M_{\mathrm{col}}} c^n
&&\bigl(\because\ d := 2^{M_{\mathrm{col}}}\bigr)
\end{aligned}`),
      paragraph(["となり、上からの評価を得る。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、トレースの挟み込みを上からの評価・モーメントの対数凸性・下からの評価の三主張へ分けた。この主張は上からの評価だけを扱う。式変形と根拠は分割前と同じで、後置きしていた作用素評価の参照を適用行の末尾へ移した。",
        "2026-11-04: SageMath の検算（sagemath/check/trace_power_upper_bound/）を付けるにあたり、根拠の欠けを直した（主張は不変）。(1)「W は実対称なので W^n も実対称」と「冪の指数法則（W^{2a} = W^aW^a、W^{2a+1} = W^aWW^a）」は本文に主張が無かったので、power_of_real_symmetric_complex_matrix_is_real_symmetric・matrix_power_exponent_law・product_of_real_entry_matrices_has_real_entries を足して引いた。(2) 旧い鎖は (W^a e_k)^⊤(W^a e_k) と (W^a)^⊤ = W^a を使っていたが、行列の積の転置の主張は本文に無い。対角成分を mat_mult で開き、W^a の成分の対称性と u_l = (W^a)_{lk} で ‖u‖^2・u^⊤Wu に着く形にした。(3) (W^n)_{kk} = e_k^⊤W^ne_k・‖e_k‖ = 1 を def_real_bilinear_value・def_matrix_norm から示す準備を置き、e_k を定めた。(4)「作用素ノルムのレイリー上限評価の a 回の適用」は rayleigh_bounds_operator_norm の冪の主張（k → a）を一度当てるものなので、そう書いた。(5) W^{2a+1} = W^a(WW^a) を def_exp (1) と matrix_power_exponent_law の鎖にした。def_trace・def_rayleigh_sup への blkref を足した。",
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
        math(String.raw`m_k := x^\top W^k x \in \mathbb{R}`),
        "（",
        math(String.raw`W^k`),
        " は ",
        ref("def_exp"),
        " (1) の冪で、",
        ref("def_rayleigh_sup"),
        " が ",
        math(String.raw`W`),
        " を読むのと同じく、その成分を実数として ",
        ref("def_real_bilinear_value"),
        " で読む）とおく。このとき全ての ",
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
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        " と略記する。冪は ",
        ref("def_exp"),
        " (1) のもの、積は ",
        ref("mat_mult"),
        " のものである。",
      ]),
      paragraph([
        "【冪の実対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p`),
        " は実対称である（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "）。すなわち ",
        math(String.raw`W^p`),
        " の成分はすべて実数で、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(W^p)_{kl}
&=\bigl((W^p)^\top\bigr)_{kl}
&&\bigl(\because\ W^p\ \text{は実対称なので}\ (W^p)^\top = W^p\ \text{（}\blkref{def_real_symmetric_complex_matrix}\text{）}\bigr)\\
&=(W^p)_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)
\end{aligned}`),
      paragraph([
        "である。単位行列 ",
        math(String.raw`I := I_{\mathrm{Mat}(d,\mathbb{C})}`),
        " の成分 ",
        math(String.raw`I_{kl} = \delta_{kl}`),
        "（",
        ref("def_identity_matrix"),
        "、",
        ref("def_kronecker_delta"),
        "）も実数である。",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`B = I`),
        " または ",
        math(String.raw`B = W`),
        " について、",
        math(String.raw`BW^a`),
        " と ",
        math(String.raw`W^b(BW^a)`),
        " の成分も実数である（",
        ref("product_of_real_entry_matrices_has_real_entries"),
        " の行列 ",
        math(String.raw`A`),
        "・",
        math(String.raw`B`),
        " を、ここの ",
        math(String.raw`B`),
        "・",
        math(String.raw`W^a`),
        " とした場合と、",
        math(String.raw`W^b`),
        "・",
        math(String.raw`BW^a`),
        " とした場合の二回適用）。以下、",
        ref("def_rayleigh_sup"),
        " が ",
        math(String.raw`W`),
        " を読むのと同じく、",
        math(String.raw`W^p`),
        "・",
        math(String.raw`I`),
        "・",
        math(String.raw`W^b(BW^a)`),
        " の成分を実数として、",
        math(String.raw`W^px \in \mathbb{R}^d`),
        "（",
        ref("mat_mult"),
        "）と ",
        math(String.raw`y^\top Pz`),
        "（",
        ref("def_real_bilinear_value"),
        "）を読む。",
      ]),
      paragraph([
        "【",
        math(String.raw`W^ax`),
        " の成分】",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`u^{(a)} := W^ax \in \mathbb{R}^d`),
        " とおく。",
        ref("mat_mult"),
        " より、",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`u^{(a)}_l = \sum_{m=1}^{d}(W^a)_{lm}\,x_m`),
        " である。",
      ]),
      paragraph([
        "【冪の分け方】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
W^{a+b}
&=W^{b+a}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換則}\bigr)\\
&=W^bW^a
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to b,\ q \to a)\bigr)\\
&=W^b\bigl(IW^a\bigr)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
W^{a+b+1}
&=W^{b+(1+a)}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+b+1 = b+(1+a)\bigr)\\
&=W^bW^{1+a}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to b,\ q \to 1+a)\bigr)\\
&=W^b\bigl(W^1W^a\bigr)
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to 1,\ q \to a)\bigr)\\
&=W^b\bigl(W^{0+1}W^a\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=W^b\bigl((W^0W)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}\bigr)\\
&=W^b\bigl((IW)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=W^b\bigl(WW^a\bigr)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【二つの冪で挟んだ値】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " と、",
        math(String.raw`B = I`),
        " または ",
        math(String.raw`B = W`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
x^\top\bigl(W^b(BW^a)\bigr)x
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\,\bigl(W^b(BW^a)\bigr)_{ij}\,x_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\Bigl(\sum_{l=1}^{d}(W^b)_{il}\,(BW^a)_{lj}\Bigr)x_j
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\Bigl(\sum_{l=1}^{d}(W^b)_{il}\sum_{m=1}^{d}B_{lm}\,(W^a)_{mj}\Bigr)x_j
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\sum_{l=1}^{d}\sum_{m=1}^{d}x_i\,(W^b)_{il}\,B_{lm}\,(W^a)_{mj}\,x_j
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\,(W^b)_{il}\,B_{lm}\,(W^a)_{mj}\,x_j
&&\bigl(\because\ \mathbb{R}\ \text{の有限和の順序の交換}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}x_i\,(W^b)_{il}\Bigr)B_{lm}\Bigl(\sum_{j=1}^{d}(W^a)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の交換則・結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}x_i\,(W^b)_{li}\Bigr)B_{lm}\Bigl(\sum_{j=1}^{d}(W^a)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \text{【冪の実対称性】の}\ (W^b)_{il} = (W^b)_{li}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}(W^b)_{li}\,x_i\Bigr)B_{lm}\Bigl(\sum_{j=1}^{d}(W^a)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}u^{(b)}_l\,B_{lm}\,u^{(a)}_m
&&\bigl(\because\ \text{【}W^ax\text{ の成分】を}\ a\ \text{と}\ b\ \text{へ同時に適用}\bigr)\\
&=\bigl(u^{(b)}\bigr)^\top B\,u^{(a)}
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`I`),
        " と ",
        math(String.raw`W`),
        " の正値性】",
        math(String.raw`y \in \mathbb{R}^d`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
y^\top Iy
&=\sum_{k=1}^{d}\sum_{l=1}^{d}y_k\,\delta_{kl}\,y_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ \text{と}\ \blkref{def_identity_matrix}\bigr)\\
&=\sum_{k=1}^{d}y_k\,\delta_{kk}\,y_k
&&\bigl(\because\ l \neq k\ \text{の項は}\ \delta_{kl} = 0\ \text{（}\blkref{def_kronecker_delta}\text{）なので}\ 0\bigr)\\
&=\sum_{k=1}^{d}y_k\,y_k
&&\bigl(\because\ \delta_{kk} = 1\ \text{（}\blkref{def_kronecker_delta}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、各項 ",
        math(String.raw`y_ky_k`),
        " は ",
        math(String.raw`0`),
        " 以上なので ",
        math(String.raw`y^\top Iy \geq 0`),
        "、",
        math(String.raw`y \neq 0`),
        " なら ",
        math(String.raw`y_{k_0} \neq 0`),
        " となる ",
        math(String.raw`k_0`),
        " の項が正なので ",
        math(String.raw`y^\top Iy > 0`),
        " である。また ",
        math(String.raw`W`),
        " は正定値なので（",
        ref("W_is_real_symmetric_positive_definite"),
        " の正定値性を、",
        ref("def_rayleigh_sup"),
        " が ",
        math(String.raw`W`),
        " を読むのと同じく実の ",
        math(String.raw`y`),
        " で読む）、",
        math(String.raw`y \neq 0`),
        " なら ",
        math(String.raw`y^\top Wy > 0`),
        "、すべての ",
        math(String.raw`y`),
        " について ",
        math(String.raw`y^\top Wy \geq 0`),
        " である。さらに、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
I_{kl}
&=\delta_{kl}
&&\bigl(\because\ \blkref{def_identity_matrix}\bigr)\\
&=\delta_{lk}
&&\bigl(\because\ \blkref{def_kronecker_delta}\ \text{の場合分けは}\ k = l\ \text{と}\ l = k\ \text{で同じ}\bigr)\\
&=I_{lk}
&&\bigl(\because\ \blkref{def_identity_matrix}\bigr)\\
W_{kl}
&=\bigl(W^\top\bigr)_{kl}
&&\bigl(\because\ W\ \text{は実対称なので}\ W^\top = W\ \text{（}\blkref{W_is_real_symmetric_positive_definite}\text{、}\blkref{def_real_symmetric_complex_matrix}\text{）}\bigr)\\
&=W_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        math(String.raw`I`),
        " と ",
        math(String.raw`W`),
        " は ",
        ref("def_real_symmetric_matrix"),
        " の意味で対称であり、上の評価から半正定値である。すなわち ",
        ref("psd_cauchy_schwarz"),
        " の前提を満たす。",
      ]),
      paragraph([
        "【",
        math(String.raw`W^ax`),
        " は零でない】",
        math(String.raw`\|x\| = 1`),
        " なので ",
        math(String.raw`x \neq 0`),
        " である（",
        math(String.raw`x = 0`),
        " なら ",
        ref("def_matrix_norm"),
        " より ",
        math(String.raw`\|x\| = \sqrt{0} = 0`),
        "。",
        math(String.raw`\sqrt{0} = 0`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`0 \geq 0,\ 0^2 = 0`),
        "）。",
        math(String.raw`a`),
        " についての帰納法で ",
        math(String.raw`u^{(a)} \neq 0`),
        " を示す。",
        math(String.raw`a = 0`),
        " では",
      ]),
      displayMath(String.raw`\begin{aligned}
u^{(0)}
&=W^0x
&&\bigl(\because\ u^{(0)} := W^0x\bigr)\\
&=Ix
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=x
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`u^{(0)} \neq 0`),
        " である。",
        math(String.raw`u^{(a)} \neq 0`),
        " とすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
u^{(a+1)}
&=W^{a+1}x
&&\bigl(\because\ u^{(a+1)} := W^{a+1}x\bigr)\\
&=W^{1+a}x
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換則}\bigr)\\
&=\bigl(W^1W^a\bigr)x
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (p \to 1,\ q \to a)\bigr)\\
&=\bigl(W^{0+1}W^a\bigr)x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=\bigl((W^0W)W^a\bigr)x
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}\bigr)\\
&=\bigl((IW)W^a\bigr)x
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=\bigl(WW^a\bigr)x
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&=W\bigl(W^ax\bigr)
&&\bigl(\because\ \blkref{mat_mult_associative}\bigr)\\
&=Wu^{(a)}
&&\bigl(\because\ u^{(a)} := W^ax\bigr)
\end{aligned}`),
      paragraph([
        "である。仮に ",
        math(String.raw`Wu^{(a)} = 0`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(u^{(a)}\bigr)^\top Wu^{(a)}
&=\sum_{k=1}^{d}\sum_{l=1}^{d}u^{(a)}_k\,W_{kl}\,u^{(a)}_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\sum_{l=1}^{d}W_{kl}\,u^{(a)}_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\,\bigl(Wu^{(a)}\bigr)_k
&&\bigl(\because\ \blkref{mat_mult}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\cdot 0
&&\bigl(\because\ Wu^{(a)} = 0\ \text{という仮定}\bigr)\\
&=0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ r \cdot 0 = 0\ \text{と}\ 0\ \text{の有限和}\bigr)
\end{aligned}`),
      paragraph([
        "となり、帰納法の仮定 ",
        math(String.raw`u^{(a)} \neq 0`),
        " と【",
        math(String.raw`I`),
        " と ",
        math(String.raw`W`),
        " の正値性】の ",
        math(String.raw`\bigl(u^{(a)}\bigr)^\top Wu^{(a)} > 0`),
        " に反する。よって ",
        math(String.raw`u^{(a+1)} = Wu^{(a)} \neq 0`),
        " である。",
      ]),
      paragraph([
        "【正値性】",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " は、ある ",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`k = 2a`),
        " か ",
        math(String.raw`k = 2a+1`),
        " である。",
        math(String.raw`k = 2a`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{2a}
&=x^\top W^{2a}x
&&\bigl(\because\ m_k := x^\top W^kx\bigr)\\
&=x^\top W^{a+a}x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a = a+a\bigr)\\
&=x^\top\bigl(W^a(IW^a)\bigr)x
&&\bigl(\because\ \text{【冪の分け方】の一つ目}\ (b \to a)\bigr)\\
&=\bigl(u^{(a)}\bigr)^\top I\,u^{(a)}
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (b \to a,\ B = I)\bigr)\\
&>0
&&\bigl(\because\ \text{【}W^ax\text{ は零でない】と【}I\text{ と }W\text{ の正値性】}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`k = 2a+1`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{2a+1}
&=x^\top W^{2a+1}x
&&\bigl(\because\ m_k := x^\top W^kx\bigr)\\
&=x^\top W^{a+a+1}x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a+1 = a+a+1\bigr)\\
&=x^\top\bigl(W^a(WW^a)\bigr)x
&&\bigl(\because\ \text{【冪の分け方】の二つ目}\ (b \to a)\bigr)\\
&=\bigl(u^{(a)}\bigr)^\top W\,u^{(a)}
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (b \to a,\ B = W)\bigr)\\
&>0
&&\bigl(\because\ \text{【}W^ax\text{ は零でない】と【}I\text{ と }W\text{ の正値性】}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "【",
        math(String.raw`P = W`),
        " の不等式】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b+1}\right)^2
&=\left(x^\top W^{a+b+1}x\right)^2
&&\bigl(\because\ m_k := x^\top W^kx\bigr)\\
&=\left(x^\top\bigl(W^b(WW^a)\bigr)x\right)^2
&&\bigl(\because\ \text{【冪の分け方】の二つ目}\bigr)\\
&=\left(\bigl(u^{(b)}\bigr)^\top W\,u^{(a)}\right)^2
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (B = W)\bigr)\\
&\leq\left(\bigl(u^{(a)}\bigr)^\top W\,u^{(a)}\right)\left(\bigl(u^{(b)}\bigr)^\top W\,u^{(b)}\right)
&&\bigl(\because\ \blkref{psd_cauchy_schwarz}\ (n \to d,\ P \to W,\ x \to u^{(a)},\ y \to u^{(b)})\bigr)\\
&=\left(x^\top\bigl(W^a(WW^a)\bigr)x\right)\left(x^\top\bigl(W^b(WW^b)\bigr)x\right)
&&\bigl(\because\ \text{【二つの冪で挟んだ値】を}\ (a,b) \to (a,a),\ (b,b),\ B = W\ \text{で両因子へ同時に適用}\bigr)\\
&=\left(x^\top W^{a+a+1}x\right)\left(x^\top W^{b+b+1}x\right)
&&\bigl(\because\ \text{【冪の分け方】の二つ目を両因子へ同時に適用}\bigr)\\
&=\left(x^\top W^{2a+1}x\right)\left(x^\top W^{2b+1}x\right)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+a+1 = 2a+1,\ b+b+1 = 2b+1\bigr)\\
&=m_{2a+1}\,m_{2b+1}
&&\bigl(\because\ m_k := x^\top W^kx\ \text{を両因子へ同時に適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`P = I`),
        " の不等式】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b}\right)^2
&=\left(x^\top W^{a+b}x\right)^2
&&\bigl(\because\ m_k := x^\top W^kx\bigr)\\
&=\left(x^\top\bigl(W^b(IW^a)\bigr)x\right)^2
&&\bigl(\because\ \text{【冪の分け方】の一つ目}\bigr)\\
&=\left(\bigl(u^{(b)}\bigr)^\top I\,u^{(a)}\right)^2
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (B = I)\bigr)\\
&\leq\left(\bigl(u^{(a)}\bigr)^\top I\,u^{(a)}\right)\left(\bigl(u^{(b)}\bigr)^\top I\,u^{(b)}\right)
&&\bigl(\because\ \blkref{psd_cauchy_schwarz}\ (n \to d,\ P \to I,\ x \to u^{(a)},\ y \to u^{(b)})\bigr)\\
&=\left(x^\top\bigl(W^a(IW^a)\bigr)x\right)\left(x^\top\bigl(W^b(IW^b)\bigr)x\right)
&&\bigl(\because\ \text{【二つの冪で挟んだ値】を}\ (a,b) \to (a,a),\ (b,b),\ B = I\ \text{で両因子へ同時に適用}\bigr)\\
&=\left(x^\top W^{a+a}x\right)\left(x^\top W^{b+b}x\right)
&&\bigl(\because\ \text{【冪の分け方】の一つ目を両因子へ同時に適用}\bigr)\\
&=\left(x^\top W^{2a}x\right)\left(x^\top W^{2b}x\right)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+a = 2a,\ b+b = 2b\bigr)\\
&=m_{2a}\,m_{2b}
&&\bigl(\because\ m_k := x^\top W^kx\ \text{を両因子へ同時に適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`P = I`),
        " の不等式】と【",
        math(String.raw`P = W`),
        " の不等式】から、任意の ",
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
&&(\because\ \text{【}P = I\text{ の不等式】})\\
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
&&(\because\ \text{【}P = W\text{ の不等式】})\\
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
        "2026-11-05: SageMath の検算（sagemath/check/moment_log_convexity/）を付けるにあたり、根拠の欠けを直した（主張の不等式は不変。主張文に m_k の読み方を足した）。(1) 旧い鎖は (W^bx)^⊤W(W^ax) と x^⊤W^{a+b+1}x の等号を「冪の指数法則と (W^b)^⊤ = W^b」としていたが、行列の積の転置の主張は本文に無い。【二つの冪で挟んだ値】x^⊤(W^b(BW^a))x = (W^bx)^⊤B(W^ax)（B = I, W）を def_real_bilinear_value・mat_mult・W^b の成分の対称性で示し、二つの不等式の鎖をこれで書いた。P = I の鎖はユークリッドノルムを経ずに (u^{(a)})^⊤Iu^{(a)} で閉じた。(2)「冪の指数法則」を matrix_power_exponent_law の行に、「W は実対称」を power_of_real_symmetric_complex_matrix_is_real_symmetric の【冪の実対称性】にした。(3) 正値性の「W が可逆なので W^ax ≠ 0」は、可逆から核の自明性を導く主張が本文に無い。W の正定値性から Wu ≠ 0（u ≠ 0）を示し、a の帰納法で W^ax ≠ 0 とした。m_{2a}・m_{2a+1} > 0 を【二つの冪で挟んだ値】の鎖にした。I と W が psd_cauchy_schwarz の前提（def_real_symmetric_matrix の対称と半正定値）を満たすことを鎖で示した。積の行列 W^b(BW^a) の成分が実数であることを product_of_real_entry_matrices_has_real_entries で示して def_real_bilinear_value で読んだ。",
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
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "（",
        ref("def_rayleigh_sup"),
        "）、",
        math(String.raw`d := 2^{M_{\mathrm{col}}}`),
        "、",
        math(String.raw`\mathcal{R} := \{x^\top Wx \mid x \in \mathbb{R}^d,\ \|x\| = 1\} \subseteq \mathbb{R}_{>0}`),
        "（",
        ref("def_rayleigh_sup"),
        "）と略記する。冪は ",
        ref("def_exp"),
        " (1) のもの、積は ",
        ref("mat_mult"),
        " のもの、",
        math(String.raw`\mathbb{R}`),
        " の元 ",
        math(String.raw`t`),
        " の冪は ",
        math(String.raw`t^0 := 1,\ t^{p+1} := t^pt`),
        " である。上からの評価 ",
        math(String.raw`\mathrm{tr}(W^n) \leq 2^{M_{\mathrm{col}}}c^n`),
        " は ",
        ref("trace_power_upper_bound"),
        " なので、以下で下からの評価 ",
        math(String.raw`c^n \leq \mathrm{tr}(W^n)`),
        " を示す。",
      ]),
      paragraph([
        "【",
        math(String.raw`W^n`),
        " の成分の対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、",
        math(String.raw`W^n`),
        " は実対称である（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "、指数 ",
        math(String.raw`n`),
        "）。すなわち ",
        math(String.raw`W^n`),
        " の成分はすべて実数で、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(W^n)_{lk}
&=\bigl((W^n)^\top\bigr)_{kl}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&=(W^n)_{kl}
&&\bigl(\because\ W^n\ \text{は実対称なので}\ (W^n)^\top = W^n\ \text{（}\blkref{def_real_symmetric_complex_matrix}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。以下、",
        ref("def_rayleigh_sup"),
        " が ",
        math(String.raw`W`),
        " を読むのと同じく、",
        math(String.raw`W^n`),
        " の成分を実数として ",
        math(String.raw`y^\top W^nz`),
        "（",
        ref("def_real_bilinear_value"),
        "）と ",
        math(String.raw`\mathrm{tr}(W^n) = \sum_{k=1}^{d}(W^n)_{kk}`),
        "（",
        ref("def_trace"),
        "）を読む。",
      ]),
      paragraph([
        "【",
        math(String.raw`W^n`),
        " の半正定値性】",
        math(String.raw`z \in \mathbb{R}^d`),
        " について ",
        math(String.raw`z^\top W^nz \geq 0`),
        " を示す。",
        math(String.raw`z = 0`),
        " なら ",
        ref("def_real_bilinear_value"),
        " の和の各項が ",
        math(String.raw`0\cdot(W^n)_{ij}\cdot 0 = 0`),
        " なので ",
        math(String.raw`z^\top W^nz = 0`),
        " である。",
        math(String.raw`z \neq 0`),
        " なら ",
        math(String.raw`z_{j_0} \neq 0`),
        " となる ",
        math(String.raw`j_0`),
        " があり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|z\|^2
&=\sum_{j=1}^{d}|z_j|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&\geq |z_{j_0}|^2
&&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ (a_j \to |z_j|^2,\ k \to j_0)\bigr)\\
&>0
&&\bigl(\because\ z_{j_0} \neq 0\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        math(String.raw`\|z\| \geq 0`),
        "（",
        ref("def_matrix_norm"),
        "）と ",
        math(String.raw`\|z\| \neq 0`),
        "（",
        math(String.raw`\|z\| = 0`),
        " なら ",
        math(String.raw`\|z\|^2 = 0^2 = 0`),
        " となり ",
        math(String.raw`\|z\|^2 > 0`),
        " に反する）から ",
        math(String.raw`\|z\| > 0`),
        " である。",
        math(String.raw`w \in \mathbb{R}^d`),
        " を ",
        math(String.raw`w_i := \|z\|^{-1}z_i`),
        " で定めると、",
        math(String.raw`i \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`z_i = \|z\|\bigl(\|z\|^{-1}z_i\bigr) = \|z\|\,w_i`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|w\|
&=\sqrt{\sum_{i=1}^{d}|w_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{def_matrix_norm}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}z_i\bigr)^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ w_i := \|z\|^{-1}z_i\ \text{と、}\mathbb{R}\ \text{の元}\ t\ \text{で}\ |t|^2 = t^2\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}\bigr)^2z_i^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (st)^2 = s^2t^2\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\sum_{i=1}^{d}z_i^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to (\|z\|^{-1})^2)\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\sum_{i=1}^{d}|z_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{の元}\ t\ \text{で}\ t^2 = |t|^2\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\|z\|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \text{上の}\ \|z\|^2 = \sum_{j}|z_j|^2\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\|z\|\bigr)^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則}\bigr)\\
&=\sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \|z\| \neq 0\ \text{なので}\ \|z\|^{-1}\|z\| = 1,\ 1^2 = 1\bigr)\\
&=1
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ 1 \geq 0,\ 1^2 = 1\bigr)
\end{aligned}`),
      paragraph(["である。よって"]),
      displayMath(String.raw`\begin{aligned}
z^\top W^nz
&=\sum_{i=1}^{d}\sum_{j=1}^{d}z_i\,(W^n)_{ij}\,z_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\bigl(\|z\|\,w_i\bigr)(W^n)_{ij}\bigl(\|z\|\,w_j\bigr)
&&\bigl(\because\ z_i = \|z\|\,w_i\ \text{を各項へ同時に適用}\bigr)\\
&=\|z\|^2\sum_{i=1}^{d}\sum_{j=1}^{d}w_i\,(W^n)_{ij}\,w_j
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則と、}\blkref{finite_sum_of_real_scalar_multiples}\ (c \to \|z\|^2)\ \text{を内側と外側の和へ適用}\bigr)\\
&=\|z\|^2\,\bigl(w^\top W^nw\bigr)
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&>0
&&\bigl(\because\ \|z\|^2 > 0\ \text{と、}\blkref{moment_log_convexity}\ \text{の正値性を単位ベクトル}\ x \to w\ \text{と}\ k \to n\ \text{で適用した}\ w^\top W^nw > 0\bigr)
\end{aligned}`),
      paragraph([
        "である。いずれの場合も ",
        math(String.raw`z^\top W^nz \geq 0`),
        " である。",
      ]),
      paragraph([
        "【",
        math(String.raw`W^n`),
        " の成分の評価】",
        math(String.raw`x \in \mathbb{R}^d`),
        "、",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について、",
        math(String.raw`v \in \mathbb{R}^d`),
        " を ",
        math(String.raw`v_i := x_l\,(e_k)_i - x_k\,(e_l)_i`),
        " で定める。ここで ",
        math(String.raw`q \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`e_q \in \mathbb{R}^d`),
        " は、",
        math(String.raw`i = q`),
        " なら ",
        math(String.raw`(e_q)_i := 1`),
        "、",
        math(String.raw`i \neq q`),
        " なら ",
        math(String.raw`(e_q)_i := 0`),
        " で定めた実数の組である。",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq v^\top W^nv
&&\bigl(\because\ \text{【}W^n\text{ の半正定値性】}\ (z \to v)\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}v_i\,(W^n)_{ij}\,v_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\bigl(x_l(e_k)_i - x_k(e_l)_i\bigr)(W^n)_{ij}\bigl(x_l(e_k)_j - x_k(e_l)_j\bigr)
&&\bigl(\because\ v\ \text{の定義}\bigr)\\
&=x_l^2\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i(W^n)_{ij}(e_k)_j
 - x_lx_k\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i(W^n)_{ij}(e_l)_j\\
&\qquad - x_kx_l\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i(W^n)_{ij}(e_k)_j
 + x_k^2\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i(W^n)_{ij}(e_l)_j
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の交換則・結合則、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を内側と外側の和へ適用}\bigr)\\
&=x_l^2\,(W^n)_{kk} - x_lx_k\,(W^n)_{kl} - x_kx_l\,(W^n)_{lk} + x_k^2\,(W^n)_{ll}
&&\bigl(\because\ (e_q)_i\ \text{は}\ i = q\ \text{でだけ}\ 1\ \text{でほかは}\ 0\ \text{なので、各二重和で}\ 0\ \text{でない項は一つだけ}\bigr)\\
&=x_l^2\,(W^n)_{kk} - x_lx_k\,(W^n)_{kl} - x_kx_l\,(W^n)_{kl} + x_k^2\,(W^n)_{ll}
&&\bigl(\because\ \text{【}W^n\text{ の成分の対称性】の}\ (W^n)_{lk} = (W^n)_{kl}\bigr)\\
&=x_l^2\,(W^n)_{kk} - 2\,x_k\,(W^n)_{kl}\,x_l + x_k^2\,(W^n)_{ll}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と同類項の加法}\bigr)
\end{aligned}`),
      paragraph(["であり、移項して"]),
      displayMath(String.raw`2\,x_k\,(W^n)_{kl}\,x_l \ \leq\ x_l^2\,(W^n)_{kk} + x_k^2\,(W^n)_{ll}`),
      paragraph(["である。"]),
      paragraph([
        "【単位ベクトルでの評価】",
        math(String.raw`x \in \mathbb{R}^d`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とし、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`m_k := x^\top W^kx`),
        " を ",
        ref("moment_log_convexity"),
        " のとおりに置く。",
        ref("moment_log_convexity"),
        " より、すべての ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " で ",
        math(String.raw`m_k > 0`),
        "、すべての ",
        math(String.raw`k \in \mathbb{Z}_{\geq 1}`),
        " で ",
        math(String.raw`m_k^{\,2} \leq m_{k-1}m_{k+1}`),
        " である。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{d}x_k^2
&=\sum_{k=1}^{d}|x_k|^2
&&\bigl(\because\ x_k \in \mathbb{R}\ \text{なので}\ x_k^2 = |x_k|^2\bigr)\\
&=\|x\|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&=1
&&\bigl(\because\ \|x\| = 1\ \text{と}\ 1^2 = 1\bigr)
\end{aligned}`),
      paragraph(["であり、単位行列 ", math(String.raw`I := I_{\mathrm{Mat}(d,\mathbb{C})}`), " について"]),
      displayMath(String.raw`\begin{aligned}
m_0
&=x^\top W^0x
&&\bigl(\because\ m_0 := x^\top W^0x\bigr)\\
&=x^\top Ix
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=\sum_{k=1}^{d}\sum_{l=1}^{d}x_k\,\delta_{kl}\,x_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ \text{と}\ \blkref{def_identity_matrix}\bigr)\\
&=\sum_{k=1}^{d}x_k\,\delta_{kk}\,x_k
&&\bigl(\because\ l \neq k\ \text{の項は}\ \delta_{kl} = 0\ \text{（}\blkref{def_kronecker_delta}\text{）なので}\ 0\bigr)\\
&=\sum_{k=1}^{d}x_kx_k
&&\bigl(\because\ \delta_{kk} = 1\ \text{（}\blkref{def_kronecker_delta}\text{）}\bigr)\\
&=\sum_{k=1}^{d}x_k^2
&&\bigl(\because\ \text{冪の定義}\ t^2 = (t^0t)t = tt\bigr)\\
&=1
&&\bigl(\because\ \text{上の式変形}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
m_1
&=x^\top W^1x
&&\bigl(\because\ m_1 := x^\top W^1x\bigr)\\
&=x^\top W^{0+1}x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=x^\top\bigl(W^0W\bigr)x
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}\bigr)\\
&=x^\top\bigl(IW\bigr)x
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=x^\top Wx
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "である。次に、",
        math(String.raw`k \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`m_k \geq m_1m_{k-1}`),
        " を ",
        math(String.raw`k`),
        " についての帰納法で示す。",
        math(String.raw`k = 1`),
        " では ",
        math(String.raw`m_1 = m_1\cdot 1 = m_1m_0`),
        "（",
        math(String.raw`m_0 = 1`),
        "）である。",
        math(String.raw`k \geq 1`),
        " で ",
        math(String.raw`m_k \geq m_1m_{k-1}`),
        " とすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{m_k}{m_{k-1}}
&\geq\frac{m_1m_{k-1}}{m_{k-1}}
&&\bigl(\because\ \text{帰納法の仮定と、正の}\ m_{k-1}\ \text{での商は順序を保つ}\bigr)\\
&=m_1
&&\bigl(\because\ m_{k-1} > 0\ \text{の約分}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
m_{k+1}
&=\frac{m_{k-1}m_{k+1}}{m_{k-1}}
&&\bigl(\because\ m_{k-1} > 0\ \text{の約分}\bigr)\\
&\geq\frac{m_k^{\,2}}{m_{k-1}}
&&\bigl(\because\ \blkref{moment_log_convexity}\ \text{の}\ m_k^{\,2} \leq m_{k-1}m_{k+1}\ \text{と、正の}\ m_{k-1}\ \text{での商は順序を保つ}\bigr)\\
&=m_k\,\frac{m_k}{m_{k-1}}
&&\bigl(\because\ m_k^{\,2} = m_km_k\ \text{と乗法の結合則}\bigr)\\
&\geq m_k\,m_1
&&\bigl(\because\ \text{上の}\ \tfrac{m_k}{m_{k-1}} \geq m_1\ \text{と、正の}\ m_k\ \text{を掛けても順序を保つ}\bigr)\\
&=m_1m_{(k+1)-1}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と}\ \mathbb{Z}\ \text{で}\ k = (k+1)-1\bigr)
\end{aligned}`),
      paragraph([
        "である。さらに、",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`m_p \geq m_1^{\,p}`),
        " を ",
        math(String.raw`p`),
        " についての帰納法で示す。",
        math(String.raw`p = 0`),
        " では ",
        math(String.raw`m_0 = 1 = m_1^{\,0}`),
        " である。",
        math(String.raw`m_p \geq m_1^{\,p}`),
        " とすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{p+1}
&\geq m_1m_{(p+1)-1}
&&\bigl(\because\ \text{上の}\ m_k \geq m_1m_{k-1}\ (k \to p+1)\bigr)\\
&=m_1m_p
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ (p+1)-1 = p\bigr)\\
&\geq m_1m_1^{\,p}
&&\bigl(\because\ \text{帰納法の仮定と、正の}\ m_1\ \text{を掛けても順序を保つ}\bigr)\\
&=m_1^{\,p+1}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と冪の定義}\ t^{p+1} := t^pt\bigr)
\end{aligned}`),
      paragraph([
        "である。最後に、【",
        math(String.raw`W^n`),
        " の成分の評価】をすべての ",
        math(String.raw`k, l`),
        " に当てて",
      ]),
      displayMath(String.raw`\begin{aligned}
m_n
&=\sum_{k=1}^{d}\sum_{l=1}^{d}x_k\,(W^n)_{kl}\,x_l
&&\bigl(\because\ m_n := x^\top W^nx\ \text{と}\ \blkref{def_real_bilinear_value}\bigr)\\
&=2^{-1}\sum_{k=1}^{d}\sum_{l=1}^{d}2\,x_k\,(W^n)_{kl}\,x_l
&&\bigl(\because\ 2^{-1}\cdot 2 = 1\ \text{と}\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to 2^{-1})\ \text{を内側と外側の和へ適用}\bigr)\\
&\leq 2^{-1}\sum_{k=1}^{d}\sum_{l=1}^{d}\bigl(x_l^2\,(W^n)_{kk} + x_k^2\,(W^n)_{ll}\bigr)
&&\bigl(\because\ \text{【}W^n\text{ の成分の評価】を}\ d^2\ \text{個の項へ同時に適用し、項ごとの不等式の有限和と}\ 2^{-1} > 0\ \text{倍は順序を保つ}\bigr)\\
&=2^{-1}\Bigl(\sum_{k=1}^{d}\sum_{l=1}^{d}x_l^2\,(W^n)_{kk} + \sum_{k=1}^{d}\sum_{l=1}^{d}x_k^2\,(W^n)_{ll}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の有限和の加法の交換則・結合則}\bigr)\\
&=2^{-1}\Bigl(\sum_{k=1}^{d}(W^n)_{kk}\sum_{l=1}^{d}x_l^2 + \sum_{k=1}^{d}x_k^2\sum_{l=1}^{d}(W^n)_{ll}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を内側の和へ適用}\bigr)\\
&=2^{-1}\Bigl(\Bigl(\sum_{k=1}^{d}(W^n)_{kk}\Bigr)\Bigl(\sum_{l=1}^{d}x_l^2\Bigr) + \Bigl(\sum_{k=1}^{d}x_k^2\Bigr)\Bigl(\sum_{l=1}^{d}(W^n)_{ll}\Bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を外側の和へ適用}\bigr)\\
&=2^{-1}\bigl(\mathrm{tr}(W^n)\cdot 1 + 1\cdot\mathrm{tr}(W^n)\bigr)
&&\bigl(\because\ \blkref{def_trace}\ \text{と、上の}\ \textstyle\sum_{k}x_k^2 = 1\bigr)\\
&=\mathrm{tr}(W^n)
&&\bigl(\because\ \mathbb{R}\ \text{の四則}\bigr)
\end{aligned}`),
      paragraph(["である。以上を合わせると、単位ベクトル ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\begin{aligned}
\bigl(x^\top Wx\bigr)^n
&=m_1^{\,n}
&&\bigl(\because\ \text{上の}\ m_1 = x^\top Wx\bigr)\\
&\leq m_n
&&\bigl(\because\ \text{上の}\ m_p \geq m_1^{\,p}\ (p \to n)\bigr)\\
&\leq\mathrm{tr}(W^n)
&&\bigl(\because\ \text{上の式変形}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【正の実数の冪の比較】",
        math(String.raw`r, s \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`r < s`),
        " とする。",
        math(String.raw`p \in \mathbb{Z}_{\geq 1}`),
        " について (a) ",
        math(String.raw`0 < r^p < s^p`),
        "、(b) ",
        math(String.raw`s^p - r^p \leq p\,s^{p-1}(s - r)`),
        " を ",
        math(String.raw`p`),
        " についての帰納法で示す。",
        math(String.raw`p = 1`),
        " では ",
        math(String.raw`r^1 = r^0r = r`),
        "、",
        math(String.raw`s^1 = s`),
        " なので (a) は ",
        math(String.raw`0 < r < s`),
        "、(b) は ",
        math(String.raw`s - r = 1\cdot s^0(s - r)`),
        " である。",
        math(String.raw`p`),
        " で (a)(b) が成り立つとすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
r^{p+1}
&=r^pr
&&\bigl(\because\ \text{冪の定義}\bigr)\\
&<s^pr
&&\bigl(\because\ \text{(a) の}\ r^p < s^p\ \text{と}\ r > 0\bigr)\\
&<s^ps
&&\bigl(\because\ r < s\ \text{と、(a) から}\ s^p > r^p > 0\bigr)\\
&=s^{p+1}
&&\bigl(\because\ \text{冪の定義}\bigr)
\end{aligned}`),
      paragraph([
        "かつ ",
        math(String.raw`r^{p+1} = r^pr > 0`),
        "（",
        math(String.raw`r^p > 0`),
        "、",
        math(String.raw`r > 0`),
        "）なので (a) が ",
        math(String.raw`p+1`),
        " で成り立ち、",
      ]),
      displayMath(String.raw`\begin{aligned}
s^{p+1} - r^{p+1}
&=s\bigl(s^p - r^p\bigr) + r^p(s - r)
&&\bigl(\because\ \text{冪の定義と}\ \mathbb{R}\ \text{の分配則（}-sr^p + r^ps = 0\text{）}\bigr)\\
&\leq s\bigl(p\,s^{p-1}(s - r)\bigr) + r^p(s - r)
&&\bigl(\because\ \text{(b) と}\ s > 0\bigr)\\
&\leq s\bigl(p\,s^{p-1}(s - r)\bigr) + s^p(s - r)
&&\bigl(\because\ \text{(a) の}\ r^p < s^p\ \text{と}\ s - r > 0\bigr)\\
&=p\,s^p(s - r) + s^p(s - r)
&&\bigl(\because\ s\,s^{p-1} = s^{p-1}s = s^p\ \text{（冪の定義）と乗法の交換則・結合則}\bigr)\\
&=(p+1)\,s^{(p+1)-1}(s - r)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と}\ \mathbb{Z}\ \text{で}\ p = (p+1)-1\bigr)
\end{aligned}`),
      paragraph(["なので (b) が ", math(String.raw`p+1`), " で成り立つ。"]),
      paragraph([
        "【上限への移行】",
        math(String.raw`T := \mathrm{tr}(W^n)`),
        " とおく。",
        math(String.raw`\|e_1\| = 1`),
        " の ",
        math(String.raw`e_1`),
        "（",
        ref("def_rayleigh_sup"),
        "）に【単位ベクトルでの評価】を当てると ",
        math(String.raw`T \geq m_n > 0`),
        " である（",
        math(String.raw`m_n`),
        " は ",
        math(String.raw`x = e_1`),
        " のもの）。",
        math(String.raw`c^n \leq T`),
        " を背理法で示す。",
        math(String.raw`c^n > T`),
        " と仮定し、",
        math(String.raw`\delta := (c^n - T)\,(n\,c^{n-1})^{-1}`),
        "、",
        math(String.raw`r := c - \delta`),
        " とおく（",
        math(String.raw`c^{n-1} > 0`),
        "（",
        math(String.raw`n = 1`),
        " なら ",
        math(String.raw`c^0 = 1`),
        "、",
        math(String.raw`n \geq 2`),
        " なら【正の実数の冪の比較】(a) を ",
        math(String.raw`r \to c,\ s \to c+1,\ p \to n-1`),
        " に当てる）なので ",
        math(String.raw`n\,c^{n-1} > 0`),
        "、",
        math(String.raw`\delta \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        "、",
        math(String.raw`r < c`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\delta
&=(c^n - T)\,(n\,c^{n-1})^{-1}
&&\bigl(\because\ \delta\ \text{の定義}\bigr)\\
&<c^n\,(n\,c^{n-1})^{-1}
&&\bigl(\because\ T > 0\ \text{と、正の}\ (n\,c^{n-1})^{-1}\ \text{を掛けても順序を保つ}\bigr)\\
&=c^{n-1}c\,(n\,c^{n-1})^{-1}
&&\bigl(\because\ \text{冪の定義と}\ \mathbb{Z}\ \text{で}\ n = (n-1)+1\bigr)\\
&=c^{n-1}c\,\bigl(n^{-1}(c^{n-1})^{-1}\bigr)
&&\bigl(\because\ n \neq 0,\ c^{n-1} \neq 0\ \text{なので}\ (n\,c^{n-1})^{-1} = n^{-1}(c^{n-1})^{-1}\bigr)\\
&=c\,n^{-1}\bigl(c^{n-1}(c^{n-1})^{-1}\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則}\bigr)\\
&=c\,n^{-1}
&&\bigl(\because\ c^{n-1}(c^{n-1})^{-1} = 1\bigr)\\
&\leq c
&&\bigl(\because\ n \geq 1\ \text{なので}\ 0 < n^{-1} \leq 1\ \text{と}\ c > 0\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`r = c - \delta > 0`),
        " である。",
        math(String.raw`r < c = \sup\mathcal{R}`),
        " で、上限は最小の上界なので、",
        math(String.raw`r`),
        " は ",
        math(String.raw`\mathcal{R}`),
        " の上界でない。すなわち ",
        math(String.raw`\|x\| = 1`),
        " で ",
        math(String.raw`t := x^\top Wx > r`),
        " となる ",
        math(String.raw`x \in \mathbb{R}^d`),
        " があり、",
        math(String.raw`t \in \mathcal{R} \subseteq \mathbb{R}_{>0}`),
        " である。この ",
        math(String.raw`x`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
T
&\geq t^n
&&\bigl(\because\ \text{【単位ベクトルでの評価】の}\ \bigl(x^\top Wx\bigr)^n \leq \mathrm{tr}(W^n)\bigr)\\
&>r^n
&&\bigl(\because\ \text{【正の実数の冪の比較】(a)}\ (r \to r,\ s \to t,\ p \to n)\bigr)\\
&\geq c^n - n\,c^{n-1}(c - r)
&&\bigl(\because\ \text{【正の実数の冪の比較】(b)}\ (r \to r,\ s \to c,\ p \to n)\ \text{の移項}\bigr)\\
&=c^n - n\,c^{n-1}\delta
&&\bigl(\because\ r := c - \delta\ \text{なので}\ c - r = \delta\bigr)\\
&=c^n - (c^n - T)
&&\bigl(\because\ \delta\ \text{の定義と}\ n\,c^{n-1}\,(n\,c^{n-1})^{-1} = 1\bigr)\\
&=T
&&\bigl(\because\ \mathbb{R}\ \text{の加法}\bigr)
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`T > T`),
        " で矛盾する。よって ",
        math(String.raw`c^n \leq \mathrm{tr}(W^n)`),
        " である。上からの評価 ",
        ref("trace_power_upper_bound"),
        " と合わせて主張を得る。",
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
        "2026-11-05: SageMath の検算（sagemath/check/trace_power_sandwich/）を付けるにあたり、根拠の欠けを直した（主張は不変）。(1) 「…」で書いた望遠鏡積と「単調非減少を j−1 回適用」を、m_k ≥ m_1m_{k−1}（k の帰納法）と m_p ≥ m_1^p（p の帰納法）の鎖にし、m_0 = 1・m_1 = x^⊤Wx を def_exp (1)・def_real_bilinear_value・def_matrix_norm の鎖で示した。m_k は moment_log_convexity の置き方で読むと書いた。(2) 半正定値行列の二次形式をトレースで抑える八段の鎖は、実数の絶対値・有限和の三角不等式・平方根の積の法則という本文にラベルの無い道具と psd_cauchy_schwarz の二回の適用を使っていた。W^n の半正定値性を v_i := x_l(e_k)_i − x_k(e_l)_i に当てた 2x_k(W^n)_{kl}x_l ≤ x_l^2(W^n)_{kk} + x_k^2(W^n)_{ll} を足し合わせる鎖に替え、絶対値と平方根を使わない形にした。旧い鎖は誤りではないが、より初等的に書けるのでこちらを採った（README の新しい道具を導入するときの判断基準）。(3) 「W^n は正定値」の散文を、z = 0 と z ≠ 0 に分け、z ≠ 0 では w := ‖z‖^{-1}z が単位ベクトルであることを示して moment_log_convexity の正値性を当てる鎖にした。(4) 「t ↦ t^n は単調増加なので上限と可換」は t^n の連続性を暗に使っていた。正の実数の冪の比較 0 < r^p < s^p・s^p − r^p ≤ p s^{p−1}(s − r)（p の帰納法）を示し、c^n > tr(W^n) を仮定して δ := (c^n − T)(nc^{n−1})^{−1}、r := c − δ が R の上界でないことから矛盾を導く背理法にした。極限・連続性を使わず、上限の性質は最小の上界であることだけを使う。",
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
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " を固定する。",
        ref("partition_function_sandwich"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        " と、行数 ",
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        " の ",
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(K_1,K_2) \in \mathbb{R}_{>0}`),
        " について、",
        math(String.raw`N_{\mathrm{row}}`),
        " を動かした実数列の極限",
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
        math(String.raw`\log`),
        " は ",
        ref("def_real_logarithm_positive"),
        " の実対数で、値は ",
        math(String.raw`\mathbb{R}`),
        " に住む（実対数と極限による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`Z := Z(K_1,K_2)`),
        "（行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " のもの）、",
        math(String.raw`c := c(M_{\mathrm{col}})`),
        " と略記する。",
        ref("def_partition_function_2d_ising"),
        " より ",
        math(String.raw`Z \in \mathbb{R}_{>0}`),
        "、",
        ref("def_rayleigh_sup"),
        " より ",
        math(String.raw`c \in \mathbb{R}_{>0}`),
        " である。冪 ",
        math(String.raw`c^{N_{\mathrm{row}}}`),
        "、",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪で、",
        math(String.raw`\mathbb{R}_{>0}`),
        " に住む。したがって ",
        math(String.raw`c^{N_{\mathrm{row}}}`),
        "、",
        math(String.raw`Z`),
        "、",
        math(String.raw`2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}}`),
        " の ",
        math(String.raw`\log`),
        " が定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&c^{N_{\mathrm{row}}} \leq Z \leq 2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}}
&&\left(\because\ \blkref{partition_function_sandwich}\right)\\
\Longrightarrow\ &\log(c^{N_{\mathrm{row}}}) \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ u \leq v\text{ は }u<v\text{ か }u=v\text{。前者は }\blkref{real_log_strictly_increasing}\text{、後者は写像 }\log\text{ の値が一つに定まること}\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=c,\ n=N_{\mathrm{row}}\text{ で}\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}})+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_product}\text{ を }a=2^{M_{\mathrm{col}}},\ b=c^{N_{\mathrm{row}}}\text{ で}\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq M_{\mathrm{col}}\log 2+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=2,\ n=M_{\mathrm{col}}\text{ で}\right)\\
\Longrightarrow\ &N_{\mathrm{row}}\log c \leq \log Z \leq M_{\mathrm{col}}\log 2+N_{\mathrm{row}}\log c
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=c,\ n=N_{\mathrm{row}}\text{ で}\right)\\
\Longrightarrow\ &\frac{N_{\mathrm{row}}\log c}{M_{\mathrm{col}}N_{\mathrm{row}}} \leq \frac{\log Z}{M_{\mathrm{col}}N_{\mathrm{row}}} \leq \frac{M_{\mathrm{col}}\log 2+N_{\mathrm{row}}\log c}{M_{\mathrm{col}}N_{\mathrm{row}}}
&&\left(\because\ \text{各辺を }M_{\mathrm{col}}N_{\mathrm{row}}\in\mathbb{R}_{>0}\text{ で割る。正の数で割っても不等号は保たれる}\right)\\
\Longrightarrow\ &\frac{1}{M_{\mathrm{col}}}\log c \leq \frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z \leq \frac{1}{M_{\mathrm{col}}}\log c + \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \mathbb{R}\text{ の四則。分子と分母の共通の因子 }N_{\mathrm{row}}\text{、}M_{\mathrm{col}}\text{ を約す}\right)\\
\Longrightarrow\ &0 \leq \frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z - \frac{1}{M_{\mathrm{col}}}\log c \leq \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \text{各辺から }\tfrac{1}{M_{\mathrm{col}}}\log c\text{ を引く。引いても不等号は保たれる}\right)\\
\Longrightarrow\ &\left|\frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z - \frac{1}{M_{\mathrm{col}}}\log c\right| \leq \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \text{非負の実数の絶対値はそれ自身}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`a_{N_{\mathrm{row}}} := \frac{1}{M_{\mathrm{col}}N_{\mathrm{row}}}\log Z(K_1,K_2) \in \mathbb{R}`),
        "、",
        math(String.raw`a := \frac{1}{M_{\mathrm{col}}}\log c \in \mathbb{R}`),
        " と置く。準備として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\log 2
&> \log 1
&&\left(\because\ \blkref{real_log_strictly_increasing}\text{ を }1<2\text{ に}\right)\\
&= \log(\exp 0)
&&\left(\because\ \blkref{scalar_exp_zero}\right)\\
&= 0
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x)=x\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\varepsilon \in \mathbb{R}_{>0}`),
        " を取る。",
        math(String.raw`\mathbb{R}`),
        " のアルキメデス性より ",
        math(String.raw`N_0\,\varepsilon > \log 2`),
        " となる ",
        math(String.raw`N_0 \in \mathbb{Z}_{\geq 1}`),
        " を取る。",
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq N_0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|a_{N_{\mathrm{row}}} - a\right|
&\leq \frac{\log 2}{N_{\mathrm{row}}}
&&\left(\because\ \text{上の含意の鎖の最後の行}\right)\\
&\leq \frac{\log 2}{N_0}
&&\left(\because\ \text{準備の }\log 2 > 0\text{ かつ }0 < N_0 \leq N_{\mathrm{row}}\right)\\
&< \varepsilon
&&\left(\because\ N_0\,\varepsilon > \log 2\text{ の両辺を }N_0 > 0\text{ で割る}\right).
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K = \mathbb{R}`),
        " の列の収束の意味で ",
        math(String.raw`a_{N_{\mathrm{row}}} \to a`),
        " であり、極限は ",
        ref("scalar_limit_is_unique"),
        " により一つに定まるので、主張の極限は存在して値は ",
        math(String.raw`a = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
        " である。",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\log`),
        " が実対数で値が ",
        math(String.raw`\mathbb{R}`),
        " に住むこと（実対数による脱出）と、実数列の極限とアルキメデス性を使うこと（極限による脱出）のためである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-08-18: 式変形の書き方を統一した。挟み込みへの log の適用・MN による割り算・中心からの差の評価が散文で継がれた 3 つの表示に分かれていたのを、一続きの含意の鎖へまとめ、根拠を各行末の (∵ …) へ移した。極限の存在の論法と参照は変更していない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-11-05: SageMath の検算（sagemath/check/limit_of_log_Z_in_N_row/）に合わせて直した。各行の根拠をラベル参照にし（log(c^N) = N log c と log(2^M) = M log 2 は新しい主張 real_log_of_power）、割り算と約分の行、差を取る行と絶対値の行を分けた。極限の段を log 2 > 0 の準備と ε と N_0 の鎖で書いて def_matrix_norm・scalar_limit_is_unique を引き、冪を新しい定義 def_power_of_real_number で引き、「この段階では実数解析へ移行していない」の誤った断り書きを、実対数と極限による ℝ 脱出の宣言に替えた。主張に K_1, K_2 と N_row の帰属を書いた。計算の誤りは無かった。",
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
