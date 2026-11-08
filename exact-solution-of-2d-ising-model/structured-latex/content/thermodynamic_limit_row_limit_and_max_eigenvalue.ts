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
        math(String.raw`\bigl(Z(K_1,K_2)\bigr)_{\mathbb{C}} = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        " である。熱力学極限を取るには、この ",
        math(String.raw`N_{\mathrm{row}}`),
        " 乗のトレースを**最大固有値ひとつ**で挟み撃ちしたい。以下でそれを行う。",
      ]),
      paragraph([
        "得られる評価は、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）、",
        math(String.raw`W := V_1^{1/2}V_2V_1^{1/2}`),
        "、その成分を実数として並べた行列 ",
        math(String.raw`W_{\mathbb{R}}`),
        "（",
        ref("def_W_real"),
        "）、",
        math(String.raw`c(M_{\mathrm{col}}) := \sup\{\,x^{\top}W_{\mathbb{R}}x \mid x \in \mathbb{R}^{d},\ \|x\| = 1\,\}`),
        " として",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \ \leq\ Z(K_1,K_2)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`,
      ),
      paragraph([
        "である。右辺の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " の ",
        ref("def_power_of_real_number"),
        " の冪 ",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
        " の略記で、",
        math(String.raw`\mathbb{Z}`),
        " の元 ",
        math(String.raw`d`),
        " とは別の元である。",
        "**以下では固有値の存在（対角化可能性・スペクトル定理）を一切使わない。**",
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
        "）。割る ",
        math(String.raw`M_{\mathrm{col}}N_{\mathrm{row}}`),
        " と右辺の ",
        math(String.raw`M_{\mathrm{col}}`),
        " は、",
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}}) \in \mathbb{R}`),
        "・",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}}) \in \mathbb{R}`),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
        "2026-10-31: 章立ての組み直しで、N→∞ の極限と最大固有値 c(M) の章の冒頭へ移した。c_+(M) と ε の性質を述べる段落は 011 の案内文 maxeig_remark_overview_c_plus_and_epsilon に残し、N_row→∞ の極限（limit_of_log_Z_in_N_row）を述べる段落を足した。「この章」を「以下」に直した。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 冒頭の引用を (Z(K_1,K_2))_ℂ = tr(…)（partition_function_via_transfer_matrix の新しい形）に、c(M_col) の式を W_ℝ（def_W_real）の二次形式に直した。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: M_col ∈ ℤ_{≥2} を書き、ベクトルの次元に使っていた添字なしの 2^{M_col}（ℝ^{2^{M_col}}）を、d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて ℝ^d にした。挟み撃ちの右辺の 2^{M_col} は ℝ の元 2_ℝ^{M_col}（def_power_of_real_number）の略記で d とは別の元であることを書いた（partition_function_sandwich の主張と同じ断り）。最後の段落の M_col N_row・M_col が inclusion_zz_to_rr の ι で送った ℝ の元の略記であること（limit_of_log_Z_in_N_row と同じ断り）を書いた。値は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_002_claim_Z_equals_trace_of_W",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 4 },
    title: { tex: String.raw`Z_{\mathbb{C}} = \mathrm{tr}(W^{N_{\mathrm{row}}})` },
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
        math(String.raw`\bigl(Z(K_1,K_2)\bigr)_{\mathbb{C}} = \mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)`),
        "（",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n_0 := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）",
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
\bigl(Z(K_1,K_2)\bigr)_{\mathbb{C}}
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: Z(K_1,K_2) ∈ ℝ_{>0} とトレース（ℂ の元）を等号で結んでいたので、表題・主張の「とくに」・その鎖の左辺を inclusion_rr_to_cc の (Z(K_1,K_2))_ℂ にした（partition_function_via_transfer_matrix の新しい形に合わせた）。",
        "2026-11-04: SageMath の検算（sagemath/check/Z_equals_trace_of_W/）を付けるにあたり、証明を (∵) 付きの鎖にした。散文の「結合法則で括り直す」「冪の定義」「n−1 個の積」を、冪の定義 <def_exp> (1) による二つの帰納法（準備 2: (X(YX)^k)Y = (XY)^{k+1}、準備 3: W^{k+1} = ((B(V_2V_1)^k)V_2)B）と <mat_mult_associative>・単位行列の左右の単位律の行に分けた。本体の鎖は元の証明と同じ順（V_1(V_2V_1)^{n−1}V_2 → BB を代入 → 巡回性 → W^n）で、内容は不変。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ n_0 := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、n_0 ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。値と手順は変えていない。",
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
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記する。",
        ref("def_symmetrized_transfer_matrix"),
        " より ",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " である。",
      ]),
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
   \quad (\because \blkref{transpose_of_matrix_product}\ (\text{主張の行数・列数 } m, n, p \to d,\ A \to \sigma_m^z,\ B \to \sigma_{m^{+}}^z)) \\
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
   \quad \left(\because\ \blkref{transpose_of_matrix_scalar_multiple}\ (\text{主張の行数・列数 } m, n \to d,\ c \to (K_1)_{\mathbb{C}},\ A \to \textstyle\sum_{\ell=1}^{M_{\mathrm{col}}}\sigma_\ell^z\sigma_{\ell+1}^z)\right) \\
&= (K_1)_{\mathbb{C}}\sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)^\top
   \quad \left(\because\ \blkref{transpose_of_finite_sum_of_matrices}\ (\text{主張の行数・列数 } m, n \to d,\ r \to M_{\mathrm{col}},\ X_\ell \to \sigma_\ell^z\sigma_{\ell+1}^z\ (1 \leq \ell \leq M_{\mathrm{col}}))\right) \\
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
        math(String.raw`\text{主張の行数・列数 } m, n, p \to d,\ A \to \sigma_m^z,\ B \to \sigma_{m^{+}}^z`),
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
        math(String.raw`\text{主張の行数・列数 } m, n \to d,\ r \to M_{\mathrm{col}},\ X_\ell \to \sigma_\ell^z\sigma_{\ell+1}^z\ (1 \leq \ell \leq M_{\mathrm{col}})`),
        "）より ",
        math(String.raw`D`),
        " の成分はすべて実数であり、",
        ref("real_scalar_multiple_of_real_entry_matrix_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n \to d,\ c \to K_1,\ B \to D`),
        "）より ",
        math(String.raw`K_1D = (K_1)_{\mathbb{C}}D`),
        " の成分もすべて実数である。転置について対称であることと合わせて、",
        math(String.raw`K_1D`),
        " は実対称である（",
        ref("def_real_symmetric_complex_matrix"),
        "）。",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`S_2`),
        " も実対称である（実対称性を示すのはその Step 3）。その表示は",
      ]),
      displayMath(String.raw`\begin{aligned}
S_2
&=iK_2^*H_2
  &&\bigl(\because\ S_2\ \text{の定義}\bigr)\\
&=K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
  &&\bigl(\because\ \blkref{iH_is_real_symmetric}\bigr)
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
        math(String.raw`n \to d,\ A \to K_1D`),
        " と ",
        math(String.raw`A \to S_2`),
        "）よりエルミートであり、",
        ref("real_multiple_of_hermitian_is_hermitian"),
        "（",
        math(String.raw`n \to d,\ \alpha \to \tfrac12,\ A \to K_1D`),
        "）より ",
        math(String.raw`\tfrac12 K_1D`),
        " もエルミートである。",
        ref("exp_hermitian_is_positive_definite"),
        "（",
        math(String.raw`n \to d,\ S \to \tfrac12 K_1D`),
        " と ",
        math(String.raw`n \to d,\ S \to S_2`),
        "）より ",
        math(String.raw`B := \exp(\tfrac12 K_1D)`),
        " と ",
        math(String.raw`A := \exp(S_2)`),
        " はいずれも正定値（とくにエルミート）であり、",
        ref("exp_of_negative_is_left_inverse"),
        "（",
        math(String.raw`n \to d,\ A \to \tfrac12 K_1D`),
        "）より ",
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
        math(String.raw`\tfrac12 K_1D`),
        "（",
        math(String.raw`(\tfrac12)_{\mathbb{C}}(K_1D)`),
        " の略記。",
        math(String.raw`(\tfrac12)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        "、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "）は実対称である。成分がすべて実数であることは、Step 1 の ",
        math(String.raw`K_1D`),
        " の成分がすべて実数であることと ",
        ref("real_scalar_multiple_of_real_entry_matrix_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n \to d,\ c \to \tfrac12,\ B \to K_1D`),
        "）による。転置で不変であることは次の鎖による。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\tfrac12 K_1D\bigr)^{\top}
&= (\tfrac12)_{\mathbb{C}}\bigl(K_1D\bigr)^{\top}
  &&\bigl(\because\ \blkref{transpose_of_matrix_scalar_multiple}\ (\text{主張の行数・列数 } m, n \to d,\ c \to (\tfrac12)_{\mathbb{C}},\ A \to K_1D)\bigr)\\
&= (\tfrac12)_{\mathbb{C}}\bigl(K_1D\bigr)
  &&\bigl(\because\ \text{Step 1 の}\ (K_1D)^{\top} = K_1D\bigr)\\
&= \tfrac12 K_1D
  &&\bigl(\because\ \tfrac12 K_1D\ \text{の略記}\bigr)
\end{aligned}`),
      paragraph([
        "よって ",
        ref("exp_of_real_symmetric_is_real_symmetric"),
        "（",
        math(String.raw`n \to d,\ A \to \tfrac12 K_1D`),
        " と ",
        math(String.raw`A \to S_2`),
        "。",
        math(String.raw`S_2`),
        " の実対称性は Step 1）より ",
        math(String.raw`B = \exp(\tfrac12 K_1D)`),
        " と ",
        math(String.raw`A = \exp(S_2)`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）である。上の正定値性と合わせて、",
        math(String.raw`B, A`),
        " は**実**対称正定値である。",
      ]),
      paragraph([
        "Step 3（合同変換）。",
        ref("V2_exponential_representation"),
        " より ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}\exp(iK_2^*H_2) = (2s_2)^{M_{\mathrm{col}}/2}A`),
        "（",
        ref("iH_is_real_symmetric"),
        " の ",
        math(String.raw`S_2 := iK_2^*H_2`),
        " と Step 2 の ",
        math(String.raw`A := \exp(S_2)`),
        " の置き方）であり、",
        math(String.raw`X \in \mathrm{Mat}(d,\mathbb{C})`),
        " について ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}X`),
        " は ",
        math(String.raw`\bigl((2s_2)^{M_{\mathrm{col}}/2}\bigr)_{\mathbb{C}}X`),
        "（",
        math(String.raw`\bigl((2s_2)^{M_{\mathrm{col}}/2}\bigr)_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、スカラー倍は ",
        ref("def_matrix_scalar_multiple"),
        "）を表す。",
        math(String.raw`B`),
        " がエルミートなので ",
        math(String.raw`B^* = B`),
        "。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
W
&=\bigl(B V_2\bigr)B
  &&\bigl(\because\ \blkref{def_symmetrized_transfer_matrix},\ B = V_1^{1/2}\ \blkref{def_transfer_matrix_square_root}\bigr)\\
&=\Bigl(B\bigl((2s_2)^{M_{\mathrm{col}}/2}A\bigr)\Bigr)B
  &&\bigl(\because\ \text{Step 3 の冒頭の}\ V_2=(2s_2)^{M_{\mathrm{col}}/2}A\bigr)\\
&=\Bigl((2s_2)^{M_{\mathrm{col}}/2}\bigl(BA\bigr)\Bigr)B
  &&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_right_factor}\ (\text{主張の行数・列数 } m, n, p \to d,\ a \to \bigl((2s_2)^{M_{\mathrm{col}}/2}\bigr)_{\mathbb{C}},\ A \to B,\ B \to A)\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}\Bigl(\bigl(BA\bigr)B\Bigr)
  &&\bigl(\because\ \blkref{scalar_multiple_factors_out_of_left_factor}\ (\text{主張の行数・列数 } m, n, p \to d,\ a \to \bigl((2s_2)^{M_{\mathrm{col}}/2}\bigr)_{\mathbb{C}},\ A \to BA,\ B \to B)\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}\Bigl(\bigl(B^{*}A\bigr)B\Bigr)
  &&\bigl(\because\ B^*=B\bigr)
\end{aligned}`),
      paragraph([
        ref("congruence_preserves_positive_definite"),
        "（",
        math(String.raw`n \to d,\ A \to A,\ B \to B,\ B' \to B'`),
        "）より ",
        math(String.raw`B^*(AB)`),
        " は正定値であり、",
        math(String.raw`(B^*A)B = B^*(AB)`),
        "（",
        ref("mat_mult_associative"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n, p, q \to d,\ A \to B^*,\ B \to A,\ C \to B`),
        "））なので ",
        math(String.raw`(B^*A)B`),
        " も正定値、",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} > 0`),
        " なので ",
        ref("positive_real_multiple_preserves_positive_definite"),
        "（",
        math(String.raw`n \to d,\ \alpha \to (2s_2)^{M_{\mathrm{col}}/2},\ A \to (B^*A)B`),
        "）より ",
        math(String.raw`W`),
        " は正定値である。",
      ]),
      paragraph([
        "次に実対称性を示す。Step 2 より ",
        math(String.raw`B`),
        " と ",
        math(String.raw`A`),
        " は実対称なので、",
        ref("def_real_symmetric_complex_matrix"),
        " より ",
        math(String.raw`B^\top = B`),
        "、",
        math(String.raw`A^\top = A`),
        " であり、",
        math(String.raw`B`),
        " と ",
        math(String.raw`A`),
        " の成分はすべて実数である。まず ",
        math(String.raw`V_2`),
        " の転置を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
V_2^\top
&=\bigl((2s_2)^{M_{\mathrm{col}}/2}A\bigr)^\top
  &&\bigl(\because\ \text{Step 3 の冒頭の}\ V_2=(2s_2)^{M_{\mathrm{col}}/2}A\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}A^\top
  &&\bigl(\because\ \blkref{transpose_of_matrix_scalar_multiple}\ (\text{主張の行数・列数 } m, n \to d,\ c \to \bigl((2s_2)^{M_{\mathrm{col}}/2}\bigr)_{\mathbb{C}},\ A \to A)\bigr)\\
&=(2s_2)^{M_{\mathrm{col}}/2}A
  &&\bigl(\because\ \text{Step 2 の}\ A^\top = A\bigr)\\
&=V_2
  &&\bigl(\because\ \text{Step 3 の冒頭の}\ V_2=(2s_2)^{M_{\mathrm{col}}/2}A\bigr)
\end{aligned}`),
      paragraph([
        "これを用いて ",
        math(String.raw`W`),
        " の転置を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
W^\top
&=\bigl((B V_2) B\bigr)^\top
  &&\bigl(\because\ \blkref{def_symmetrized_transfer_matrix},\ B = V_1^{1/2}\ \blkref{def_transfer_matrix_square_root}\bigr)\\
&=B^\top\bigl(B V_2\bigr)^\top
  &&\bigl(\because\ \blkref{transpose_of_matrix_product}\ (\text{主張の行数・列数 } m, n, p \to d,\ A \to BV_2,\ B \to B)\bigr)\\
&=B^\top\bigl(V_2^\top B^\top\bigr)
  &&\bigl(\because\ \blkref{transpose_of_matrix_product}\ (\text{主張の行数・列数 } m, n, p \to d,\ A \to B,\ B \to V_2)\bigr)\\
&=B\bigl(V_2^\top B\bigr)
  &&\bigl(\because\ \text{Step 2 の}\ B^\top = B\ \text{を 2 箇所へ同時に適用}\bigr)\\
&=B\bigl(V_2 B\bigr)
  &&\bigl(\because\ \text{上で得た}\ V_2^\top = V_2\bigr)\\
&=\bigl(B V_2\bigr)B
  &&\bigl(\because\ \blkref{mat_mult_associative}\ (\text{主張の行数・列数 } m, n, p, q \to d,\ A \to B,\ B \to V_2,\ C \to B)\bigr)\\
&=W
  &&\bigl(\because\ \blkref{def_symmetrized_transfer_matrix},\ B = V_1^{1/2}\ \blkref{def_transfer_matrix_square_root}\bigr)
\end{aligned}`),
      paragraph([
        "成分が実数であること（",
        ref("def_matrix_with_real_entries"),
        "）を見る。",
        math(String.raw`A`),
        " の成分はすべて実数なので、",
        ref("real_scalar_multiple_of_real_entry_matrix_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n \to d,\ c \to (2s_2)^{M_{\mathrm{col}}/2},\ B \to A`),
        "）より ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}A`),
        " の成分はすべて実数である。",
        math(String.raw`B`),
        " と ",
        math(String.raw`V_2`),
        " の成分はすべて実数なので、",
        ref("product_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n, p \to d,\ A \to B,\ B \to V_2`),
        "）より ",
        math(String.raw`BV_2`),
        " の成分はすべて実数であり、もう一度 ",
        ref("product_of_real_entry_matrices_has_real_entries"),
        "（",
        math(String.raw`\text{主張の行数・列数 } m, n, p \to d,\ A \to BV_2,\ B \to B`),
        "）より ",
        math(String.raw`W = (BV_2)B`),
        " の成分はすべて実数である。転置について対称であることと合わせて、",
        math(String.raw`W`),
        " は実対称である（",
        ref("def_real_symmetric_complex_matrix"),
        "）。",
      ]),
      paragraph([
        "可逆性。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`M`),
        " を ",
        math(String.raw`M_{\mathrm{col}}`),
        " に取った ",
        math(String.raw`R=\mathrm{Mat}(d,\mathbb{C})`),
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
  &&\bigl(\because\ \blkref{matrix_double_negation}\ (m\to d,\ n\to d,\ A\to \tfrac12 K_1D)\bigr)\\
&=I
  &&\bigl(\because\ \blkref{exp_of_negative_is_left_inverse}\ (n\to d,\ A\to -\tfrac12 K_1D)\bigr)
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
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: Step 2 の最後の散文「実対称行列の冪は実対称で、def_exp の級数の部分和は実対称、star_preserves_norm_and_limits (3) と同じ議論（転置もノルムを保つ）から極限も実対称」を、新しい主張 exp_of_real_symmetric_is_real_symmetric を A → ½K_1D・A → S_2 で引く形にした。½K_1D が実対称であることを、成分の実性（real_scalar_multiple_of_real_entry_matrix_has_real_entries）と転置の 3 行の鎖（transpose_of_matrix_scalar_multiple と Step 1）で書いた。主張は変えていない。",
        "2026-11-04: SageMath の検算（sagemath/check/W_is_real_symmetric_positive_definite/）を付けるにあたり、可逆性の段を直した。旧い段は Wx = 0 から x^⊤Wx = 0 を作って正定値性で x = 0 としていたが、正定値性（def_hermitian_positive_definite）は x ∈ ℂ^n の x^*Wx についての条件で、複素の x では x^⊤Wx = 0 から x = 0 は従わない（検算で、実対称正定値な W と x = u + iv（u^⊤Wu = v^⊤Wv、u^⊤Wv = 0）で x^⊤Wx = 0 となる例を作った）。また核が {0} であることから可逆を導く主張は本文に無かった。可逆性を、BB' = I の 3 行の鎖（matrix_double_negation・exp_of_negative_is_left_inverse）と Step 2 の B'B = I による B ∈ R^×、V2_invertible、def_invertible_elements_of_R (ii) の 2 回の適用で示す形にした。主張の「とくに W は可逆」を、def_invertible_elements_of_R の意味で可逆と書いた（内容は不変）。",
        "2026-11-05（Lean の通しの証明のゴールラインの確認）: Step 1 の K_1D の実対称性が「iH_is_real_symmetric の Step 3 で見たとおり」と散文で済ませていた（その Step 3 は 1 ≤ m ≤ M_col−1 の σ_m^zσ_{m+1}^z しか扱わず、周期端 σ_{M_col}^zσ_1^z を覆わない）のを、(σ_k^z)^⊤ = σ_k^z の 5 行、(σ_m^zσ_{m+1}^z)^⊤ の 5 行（m^+ を置き、transpose_of_matrix_product と distinct_site_pauli_matrices_commute で。M_col = 1 は同じ行列）、(K_1D)^⊤ の 5 行と、成分の実性の 2 段落（kronecker_of_real_entry_matrices_has_real_entries・product_of_real_entry_matrices_has_real_entries・finite_sum_of_real_entry_matrices_has_real_entries・real_scalar_multiple_of_real_entry_matrix_has_real_entries）に書き直した。主張は不変。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: Step 3 の転置の鎖 4 行が「転置の積の法則 (ABC)^⊤ = C^⊤B^⊤A^⊤」と「B^⊤ = B, V_2^⊤ = V_2」を名前だけで引いていたのを、V_2^⊤ = V_2 の 4 行（Step 3 冒頭の V_2 = (2s_2)^{M_col/2}A・transpose_of_matrix_scalar_multiple・Step 2 の A^⊤ = A）と W^⊤ の 7 行（transpose_of_matrix_product を 2 回、Step 2 の B^⊤ = B、V_2^⊤ = V_2、mat_mult_associative）に書き直した。主張の「W は成分がすべて実数」を示す段が無かったので、real_scalar_multiple_of_real_entry_matrix_has_real_entries と product_of_real_entry_matrices_has_real_entries を 2 回引く段を足した。Step 1 の「iH_is_real_symmetric の Step 1 より S_2 も実対称」と S_2 の表示の根拠を、主張そのものを引く形に直した（実対称性を示すのはその Step 3）。Step 3 冒頭の V_2 = (2s_2)^{M_col/2}A の根拠を、V2_exponential_representation の exp(iK_2^*H_2) と S_2・A の置き方に直した。主張は不変。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: Step 3 の W の鎖の「スカラー倍と行列積の結合則」（名前だけの根拠）を、scalar_multiple_factors_out_of_right_factor（B(cA) = c(BA)）と scalar_multiple_factors_out_of_left_factor（(c(BA))B = c((BA)B)）を引く 2 行に割り、鎖の各行の括弧を def_symmetrized_transfer_matrix の W = (BV_2)B に合わせた（4 行 → 5 行）。c = (2s_2)^{M_col/2} を ℂ の元として使うこと（inclusion_rr_to_cc）の断りを Step 3 の冒頭へ移した。続く段落の B^*AB = B^*(AB) を、鎖の終わりの (B^*A)B と mat_mult_associative で結ぶ形にした。主張は不変。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 証明の中で行列の大きさを添字なしの 2^{M_col} で書いていた 24 行 25 か所（当てはめの「主張の行数・列数 m, n, p → 2^{M_col}」、X ∈ Mat(2^{M_col},ℂ)、R = Mat(2^{M_col},ℂ) ほか）を、証明の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の def_W_real・trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。W ∈ Mat(d,ℂ) の出典として def_symmetrized_transfer_matrix を引いた。当てはめが書かれていなかった real_multiple_of_hermitian_is_hermitian・exp_hermitian_is_positive_definite・exp_of_negative_is_left_inverse（Step 2）・congruence_preserves_positive_definite・positive_real_multiple_preserves_positive_definite に n → d ほかの当てはめを書いた。主張・値・手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_definition_W_real",
    kind: "definition",
    title: { tex: String.raw`W \text{ の実数の行列 } W_{\mathbb{R}}` },
    labels: ["def_W_real"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記する。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " は、",
        ref("W_is_real_symmetric_positive_definite"),
        " より成分がすべて実数（",
        ref("def_matrix_with_real_entries"),
        "）なので、",
        ref("def_real_matrix_of_real_entry_matrix"),
        "（",
        math(String.raw`m \to d,\ n \to d,\ B \to W`),
        "）の",
      ]),
      displayMath(String.raw`W_{\mathbb{R}} := \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W) \in \mathrm{Mat}(d,\mathbb{R})`),
      paragraph([
        "が定まる。",
        ref("def_real_matrix_of_real_entry_matrix"),
        " より、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}} = W_{kl}`),
        " である（",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の中で定めていた W_ℝ := ϱ(W) を、W_ℝ の対称性（W_real_is_symmetric）と正定値性（W_real_is_positive_definite）が def_rayleigh_sup より前に引けるよう、独立の定義ブロックに切り出した。中身は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさを添字なしの 2^{M_col} で書いていたのを、主張の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。W が Mat(d,ℂ) の元であることの出典として def_symmetrized_transfer_matrix を引いた。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_claim_W_real_is_symmetric",
    kind: "claim",
    title: { tex: String.raw`W_{\mathbb{R}} \text{ は対称}` },
    labels: ["W_real_is_symmetric"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記する。",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " は ",
        ref("def_real_symmetric_matrix"),
        "（",
        math(String.raw`n \to d,\ P \to W_{\mathbb{R}}`),
        "）の意味で対称である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " を取る。",
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W^{\top} = W`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}
&= W_{kl}
  &&\bigl(\because\ \blkref{def_W_real}\bigr)\\
&= \bigl(W^{\top}\bigr)_{kl}
  &&\bigl(\because\ W^{\top} = W\ \text{（}\blkref{W_is_real_symmetric_positive_definite}\text{）}\bigr)\\
&= W_{lk}
  &&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&= \bigl((W_{\mathbb{R}})_{lk}\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_W_real}\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to (W_{\mathbb{R}})_{kl},\ b \to (W_{\mathbb{R}})_{lk}`),
        "）より ",
        math(String.raw`(W_{\mathbb{R}})_{kl} = (W_{\mathbb{R}})_{lk}`),
        " である。",
        math(String.raw`k, l`),
        " は任意なので、",
        ref("def_real_symmetric_matrix"),
        " の意味で ",
        math(String.raw`W_{\mathbb{R}}`),
        " は対称である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。rayleigh_bounds_operator_norm などが psd_cauchy_schwarz を W に当てるとき、psd_cauchy_schwarz が求める「実数の行列で対称」を W について示す主張が本文に無かった（W_is_real_symmetric_positive_definite は複素行列 W の W^⊤ = W を述べる）。W_ℝ について示す主張として足した。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさを添字なしの 2^{M_col} で書いていたのを、主張の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_claim_W_real_is_positive_definite",
    kind: "claim",
    title: { tex: String.raw`x \neq 0 \text{ なら } x^\top W_{\mathbb{R}} x > 0` },
    labels: ["W_real_is_positive_definite"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記する。",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " について、",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " が ",
        math(String.raw`x \neq 0`),
        "（ある ",
        math(String.raw`k`),
        " で ",
        math(String.raw`x_k \neq 0`),
        "）なら ",
        math(String.raw`x^\top W_{\mathbb{R}} x > 0`),
        " である。",
        math(String.raw`x^\top W_{\mathbb{R}} x`),
        " は ",
        ref("def_real_bilinear_value"),
        "（",
        math(String.raw`n \to d,\ P \to W_{\mathbb{R}},\ y \to x`),
        "）の値である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\xi \in \mathbb{C}^{d}`),
        " を ",
        math(String.raw`\xi_k := (x_k)_{\mathbb{C}}`),
        "（",
        math(String.raw`k \in \{1,\dots,d\}`),
        "、",
        ref("inclusion_rr_to_cc"),
        "）で定める。",
        math(String.raw`x_k \neq 0`),
        " となる ",
        math(String.raw`k`),
        " を取ると、",
        math(String.raw`\xi_k = 0_{\mathbb{C}} = (0)_{\mathbb{C}}`),
        " なら ",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to x_k,\ b \to 0`),
        "）より ",
        math(String.raw`x_k = 0`),
        " となって矛盾するので、",
        math(String.raw`\xi_k \neq 0_{\mathbb{C}}`),
        "、すなわち ",
        math(String.raw`\xi \neq 0`),
        "（",
        ref("def_zero_matrix"),
        " の零ベクトル）である。",
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W`),
        " は ",
        ref("def_hermitian_positive_definite"),
        " の意味で正定値なので、",
        math(String.raw`\xi^* W \xi = \rho_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\rho \in \mathbb{R}_{>0}`),
        " がある。",
      ]),
      displayMath(String.raw`\begin{aligned}
\rho_{\mathbb{C}}
&= \xi^* W \xi
  &&\bigl(\because\ \rho\ \text{の取り方}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \overline{\xi_k}\,W_{kl}\,\xi_l
  &&\bigl(\because\ \blkref{def_conjugate_bilinear_value}\ (n \to d,\ A \to W,\ \text{定義の変数}\ x, y \to \xi)\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \overline{(x_k)_{\mathbb{C}}}\,W_{kl}\,(x_l)_{\mathbb{C}}
  &&\bigl(\because\ \xi\ \text{の置き方}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} (x_k)_{\mathbb{C}}\,W_{kl}\,(x_l)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{complex_conjugate_of_real_inclusion}\ (r \to x_k)\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} (x_k)_{\mathbb{C}}\,\bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\,(x_l)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_W_real}\ \text{の}\ \bigl((W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}} = W_{kl}\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \bigl(x_k\,(W_{\mathbb{R}})_{kl}\bigr)_{\mathbb{C}}\,(x_l)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to x_k,\ b \to (W_{\mathbb{R}})_{kl})\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \bigl(x_k\,(W_{\mathbb{R}})_{kl}\,x_l\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ (a \to x_k\,(W_{\mathbb{R}})_{kl},\ b \to x_l)\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\Bigl(\sum_{l=1}^{d} x_k\,(W_{\mathbb{R}})_{kl}\,x_l\Bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m \to d,\ r_j \to x_k\,(W_{\mathbb{R}})_{kj}\,x_j)\ \text{を各}\ k\ \text{へ}\bigr)\\
&= \Bigl(\sum_{k=1}^{d}\sum_{l=1}^{d} x_k\,(W_{\mathbb{R}})_{kl}\,x_l\Bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m \to d,\ r_j \to \textstyle\sum_{l} x_j\,(W_{\mathbb{R}})_{jl}\,x_l)\bigr)\\
&= \bigl(x^\top W_{\mathbb{R}} x\bigr)_{\mathbb{C}}
  &&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to W_{\mathbb{R}},\ y \to x)\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to \rho,\ b \to x^\top W_{\mathbb{R}} x`),
        "）より ",
        math(String.raw`x^\top W_{\mathbb{R}} x = \rho > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup の 𝓡 ⊆ ℝ_{>0} と、rayleigh_bounds_operator_norm などが psd_cauchy_schwarz を W に当てるときの半正定値性（x^⊤Wx ≥ 0）を、複素行列 W の正定値性（x ∈ ℂ^n の x^*Wx についての条件）から実数の x の x^⊤W_ℝx へ移す段が本文に無かった。x を ℂ^n へ成分ごとに包含した ξ について ξ^*Wξ = (x^⊤W_ℝx)_ℂ を示す主張として足した。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ d := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。値と手順は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 主張が行列の大きさを添字なしの 2^{M_col} で書き、証明が d := 2_ℤ^{M_col} を置いていた（ブロックの中で書き方が二通り）のを、d の置き方を主張の冒頭へ移し、主張も d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）の d で書いた（同じ章の trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_claim_W_real_is_positive_semidefinite",
    kind: "claim",
    title: { tex: String.raw`u^\top W_{\mathbb{R}} u \geq 0` },
    labels: ["W_real_is_positive_semidefinite"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記する。",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " について、すべての ",
        math(String.raw`u \in \mathbb{R}^{d}`),
        " で ",
        math(String.raw`u^\top W_{\mathbb{R}} u \geq 0`),
        " である（",
        ref("psd_cauchy_schwarz"),
        " の意味で半正定値）。",
        math(String.raw`u^\top W_{\mathbb{R}} u`),
        " は ",
        ref("def_real_bilinear_value"),
        "（",
        math(String.raw`n \to d,\ P \to W_{\mathbb{R}},\ x \to u,\ y \to u`),
        "）の値である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u \in \mathbb{R}^{d}`),
        " を取る。",
        math(String.raw`u \neq 0`),
        " なら ",
        ref("W_real_is_positive_definite"),
        "（",
        math(String.raw`x \to u`),
        "）より ",
        math(String.raw`u^\top W_{\mathbb{R}} u > 0`),
        " である。",
        math(String.raw`u = 0`),
        "（すべての ",
        math(String.raw`k`),
        " で ",
        math(String.raw`u_k = 0`),
        "）なら",
      ]),
      displayMath(String.raw`\begin{aligned}
u^\top W_{\mathbb{R}} u
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \bigl(u_k\,(W_{\mathbb{R}})_{kl}\bigr)\,u_l
  &&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to W_{\mathbb{R}},\ x \to u,\ y \to u)\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} \bigl(0\cdot(W_{\mathbb{R}})_{kl}\bigr)\cdot 0
  &&\bigl(\because\ u_k = 0,\ u_l = 0\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} 0\cdot 0
  &&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 \cdot a = 0\ (a \to (W_{\mathbb{R}})_{kl})\ \text{を各項へ}\bigr)\\
&= \sum_{k=1}^{d}\sum_{l=1}^{d} 0
  &&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 \cdot a = 0\ (a \to 0)\ \text{を各項へ}\bigr)\\
&= 0
  &&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の和を左から順に足し、}\ \mathbb{R}\ \text{で}\ 0 + 0 = 0\bigr)
\end{aligned}`),
      paragraph([
        "である。どちらの場合も ",
        math(String.raw`u^\top W_{\mathbb{R}} u \geq 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。rayleigh_bounds_operator_norm と moment_log_convexity は psd_cauchy_schwarz を W に当てるとき、その仮定の半正定値性を W_is_real_symmetric_positive_definite（複素行列 W の正定値性）から「とくに半正定値」として名前だけで取っていた。実数の行列 W_ℝ について、正定値性（W_real_is_positive_definite）と u = 0 の 5 行の鎖から示す主張として足した。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさを添字なしの 2^{M_col} で書いていたのを、主張の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_claim_trace_of_W_power_via_W_real",
    kind: "claim",
    title: { tex: String.raw`\mathrm{tr}(W^q) = \Bigl(\sum_k ((W_{\mathbb{R}})^q)_{kk}\Bigr)_{\mathbb{C}}` },
    labels: ["trace_of_W_power_via_W_real"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " を ",
        ref("def_symmetrized_transfer_matrix"),
        " の行列、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列とする。すべての ",
        math(String.raw`q \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{tr}\!\left(W^q\right) = \Bigl(\sum_{k=1}^{d} \bigl((W_{\mathbb{R}})^q\bigr)_{kk}\Bigr)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。左辺のトレースは ",
        ref("def_trace"),
        "、右辺の和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和、",
        math(String.raw`W^q`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{C}`),
        " の冪、",
        math(String.raw`(W_{\mathbb{R}})^q`),
        " は同じ (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W`),
        " の成分はすべて実数なので ",
        math(String.raw`W \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）であり、",
        ref("def_W_real"),
        " より ",
        math(String.raw`W_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)`),
        " である。",
        ref("real_matrix_of_real_entry_matrix_preserves_power"),
        "（",
        math(String.raw`n \to d,\ A \to W`),
        "）より、",
        math(String.raw`W^q`),
        " の成分はすべて実数で、",
        math(String.raw`(W^q)_{\mathbb{R}} = (W_{\mathbb{R}})^q`),
        " である。これを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\!\left(W^q\right)
&= \sum_{k=1}^{d} (W^q)_{kk}
&&(\because \blkref{def_trace}\ (n \to d,\ A \to W^q)) \\
&= \sum_{k=1}^{d} \bigl(((W^q)_{\mathbb{R}})_{kk}\bigr)_{\mathbb{C}}
&&(\because \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^q)\ \text{を}\ d\ \text{個の項へ同時に適用}) \\
&= \sum_{k=1}^{d} \Bigl(\bigl((W_{\mathbb{R}})^q\bigr)_{kk}\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_matrix_of_real_entry_matrix_preserves_power}\ (n \to d,\ A \to W)\ \text{の}\ (W^q)_{\mathbb{R}} = (W_{\mathbb{R}})^q) \\
&= \Bigl(\sum_{k=1}^{d} \bigl((W_{\mathbb{R}})^q\bigr)_{kk}\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}\ (m \to d,\ r_k \to ((W_{\mathbb{R}})^q)_{kk}))
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。W^q のトレースを W_ℝ の冪の対角成分の実数の和で言う主張が本文に無かったので足した。いまは Lean の partitionFunction_eq_trace_physicalSymTransferR_pow が使い、本文の trace_power_upper_bound・trace_power_sandwich・partition_function_sandwich を W_ℝ で書き直すときに引く予定である。数値検証: sagemath/check/trace_of_W_power_via_W_real/。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 3 つの書き直しは済んだ。本文でこの主張を引くのは partition_function_sandwich の準備（(Z(K_1,K_2))_ℂ = tr(W^{N_row}) = T_ℂ）だけで、trace_power_upper_bound・trace_power_sandwich は Σ_k ((W_ℝ)^n)_kk を直接述べるので引かない。Lean で引くのは partition_function_eq_sum_diag_W_real_pow（旧名 partitionFunction_eq_trace_physicalSymTransferR_pow）である。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ d := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_006_definition_rayleigh_sup",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 8 },
    title: { tex: String.raw`c(M_{\mathrm{col}}) := \sup_{\|x\|=1} x^\top W_{\mathbb{R}} x` },
    labels: ["def_rayleigh_sup"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列とし、",
      ]),
      displayMath(
        String.raw`\mathcal{R} := \left\{\, x^\top W_{\mathbb{R}} x \ \middle|\ x \in \mathbb{R}^{d},\ \|x\| = 1 \,\right\} \subseteq \mathbb{R}_{>0}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\mathcal{R} \subseteq \mathbb{R}_{>0}`),
        " を示す。",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " が ",
        math(String.raw`\|x\| = 1`),
        " を満たすとする。",
        math(String.raw`x = 0`),
        "（すべての ",
        math(String.raw`j`),
        " で ",
        math(String.raw`x_j = 0`),
        "）と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\|x\|
&= \sqrt{\textstyle\sum_{j=1}^{d}|x_j|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to x)\bigr)\\
&= \sqrt{\textstyle\sum_{j=1}^{d}|0|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ x_j = 0\ \text{を各項へ}\bigr)\\
&= \sqrt{\textstyle\sum_{j=1}^{d}0^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_real_absolute_value}\ \text{の}\ 0 \geq 0\ \text{の場合}\ |0| = 0\ \text{を各項へ}\bigr)\\
&= \sqrt{\textstyle\sum_{j=1}^{d}0}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \mathbb{R}\ \text{で}\ 0^2 = 0\ \text{を各項へ}\bigr)\\
&= \sqrt{0}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_finite_sum_of_real_numbers}\ \text{の和を左から順に足し、}\ \mathbb{R}\ \text{で}\ 0 + 0 = 0\bigr)\\
&= 0
  &&\bigl(\because\ \blkref{sqrt_of_real_zero_is_zero}\bigr)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`\|x\| = 1`),
        " と矛盾するので、",
        math(String.raw`x \neq 0`),
        " である。よって ",
        ref("W_real_is_positive_definite"),
        "（",
        math(String.raw`x \to x`),
        "）より ",
        math(String.raw`x^\top W_{\mathbb{R}} x > 0`),
        " で、",
        math(String.raw`\mathcal{R} \subseteq \mathbb{R}_{>0}`),
        " である。",
        math(String.raw`\mathcal{R}`),
        " は空でない（下で示す ",
        math(String.raw`\|e_1\| = 1`),
        " により ",
        math(String.raw`e_1`),
        " を取れる）。上に有界であることは、成分の有限和として次のように評価できる。",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " が ",
        math(String.raw`\|x\| = 1`),
        " を満たすとし、",
        math(String.raw`i \in \{1,\dots,d\}`),
        " を取る。",
        math(String.raw`|\cdot|`),
        " は ",
        ref("def_real_absolute_value"),
        " の実数の絶対値（",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K = \mathbb{R}`),
        "）で、各 ",
        math(String.raw`k`),
        " について ",
        math(String.raw`|x_k| \geq 0`),
        " なので ",
        math(String.raw`|x_k|^2 = |x_k|\,|x_k| \geq 0`),
        " である。よって ",
        ref("finite_sum_of_nonnegative_reals_is_at_least_each_term"),
        "（",
        math(String.raw`m \to d,\ a_j \to |x_j|^2\ (j \in \{1,\dots,d\}),\ k \to i`),
        "）より ",
        math(String.raw`\sum_{j=1}^{d}|x_j|^2 \geq |x_i|^2 \geq 0`),
        " で、",
        math(String.raw`\sum_{j=1}^{d}|x_j|^2 \in \mathbb{R}_{\geq 0}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
|x_i|^2
&\leq \sum_{j=1}^{d}|x_j|^2
  &&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ (m \to d,\ a_j \to |x_j|^2\ (j \in \{1,\dots,d\}),\ k \to i)\bigr)\\
&= \Bigl(\sqrt{\textstyle\sum_{j=1}^{d}|x_j|^2}^{\,(\mathbb{R}_{\ge 0})}\Bigr)^2
  &&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\ \bigl(x \to \textstyle\sum_{j}|x_j|^2 \in \mathbb{R}_{\geq 0}\bigr)\bigr)\\
&= \|x\|^2
  &&\bigl(\because\ \blkref{def_matrix_norm}\ \text{の}\ \|w\|\ (K = \mathbb{R},\ d \to d,\ w \to x)\bigr)\\
&= 1^2
  &&\bigl(\because\ \|x\| = 1\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`|x_i| \geq 0`),
        "、",
        math(String.raw`1 \geq 0`),
        " なので、",
        ref("nonnegative_real_order_from_squares"),
        "（",
        math(String.raw`u \to |x_i|`),
        "、",
        math(String.raw`v \to 1`),
        "）より ",
        math(String.raw`|x_i| \leq 1`),
        " である。",
        math(String.raw`i`),
        " は任意なので、すべての ",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`|x_k| \leq 1`),
        " である。次に ",
        math(String.raw`i, j \in \{1,\dots,d\}`),
        " を取る。",
        math(String.raw`(W_{\mathbb{R}})_{ij} \in \mathbb{R}`),
        " は ",
        math(String.raw`W_{\mathbb{R}}`),
        " の成分、",
        math(String.raw`x_i\,(W_{\mathbb{R}})_{ij}\,x_j := \bigl(x_i\,(W_{\mathbb{R}})_{ij}\bigr)\,x_j`),
        " は ",
        ref("def_real_bilinear_value"),
        " の項であり、",
        math(String.raw`|x_i|\,|(W_{\mathbb{R}})_{ij}| \geq 0`),
        "（非負の実数の積）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|x_i\,(W_{\mathbb{R}})_{ij}\,x_j\right|
&= \left|x_i\,(W_{\mathbb{R}})_{ij}\right|\,|x_j|
  &&\bigl(\because\ \blkref{real_abs_of_product}\ (a \to x_i\,(W_{\mathbb{R}})_{ij},\ b \to x_j)\bigr)\\
&= |x_i|\,|(W_{\mathbb{R}})_{ij}|\,|x_j|
  &&\bigl(\because\ \blkref{real_abs_of_product}\ (a \to x_i,\ b \to (W_{\mathbb{R}})_{ij})\bigr)\\
&\leq |x_i|\,|(W_{\mathbb{R}})_{ij}| \cdot 1
  &&\bigl(\because\ |x_j| \leq 1\ \text{の両辺に非負の実数}\ |x_i|\,|(W_{\mathbb{R}})_{ij}|\ \text{を左から掛ける}\bigr)\\
&= |x_i|\,|(W_{\mathbb{R}})_{ij}|
  &&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の積の単位元}\bigr)\\
&\leq 1 \cdot |(W_{\mathbb{R}})_{ij}|
  &&\bigl(\because\ |x_i| \leq 1\ \text{の両辺に非負の実数}\ |(W_{\mathbb{R}})_{ij}|\ \text{を右から掛ける}\bigr)\\
&= |(W_{\mathbb{R}})_{ij}|
  &&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の積の単位元}\bigr)
\end{aligned}`),
      paragraph([
        "である。よって各 ",
        math(String.raw`i`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left|\sum_{j=1}^{d} x_i\,(W_{\mathbb{R}})_{ij}\,x_j\right|
&\leq \sum_{j=1}^{d} \left|x_i\,(W_{\mathbb{R}})_{ij}\,x_j\right|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_triangle_inequality}\ (m \to d,\ a_j \to x_i\,(W_{\mathbb{R}})_{ij}\,x_j)\bigr)\\
&\leq \sum_{j=1}^{d} |(W_{\mathbb{R}})_{ij}|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_monotone}\ (m \to d,\ a_j \to |x_i\,(W_{\mathbb{R}})_{ij}\,x_j|,\ b_j \to |(W_{\mathbb{R}})_{ij}|)\text{。各}\ j\ \text{の大小は上の鎖}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
x^\top W_{\mathbb{R}} x
&\leq \left|x^\top W_{\mathbb{R}} x\right|
  &&\bigl(\because\ \blkref{real_number_is_at_most_its_absolute_value}\ (q \to x^\top W_{\mathbb{R}} x)\bigr)\\
&= \left|\sum_{i=1}^{d}\sum_{j=1}^{d} x_i\,(W_{\mathbb{R}})_{ij}\,x_j\right|
  &&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to W_{\mathbb{R}},\ y \to x)\bigr)\\
&\leq \sum_{i=1}^{d}\left|\sum_{j=1}^{d} x_i\,(W_{\mathbb{R}})_{ij}\,x_j\right|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_triangle_inequality}\ (m \to d,\ \text{添字}\ j \to i,\ a_i \to \textstyle\sum_{j} x_i\,(W_{\mathbb{R}})_{ij}\,x_j)\bigr)\\
&\leq \sum_{i=1}^{d}\sum_{j=1}^{d} |(W_{\mathbb{R}})_{ij}|
  &&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_monotone}\ (m \to d,\ \text{添字}\ j \to i,\ a_i \to \bigl|\textstyle\sum_{j} x_i\,(W_{\mathbb{R}})_{ij}\,x_j\bigr|,\ b_i \to \textstyle\sum_{j}|(W_{\mathbb{R}})_{ij}|)\text{。各}\ i\ \text{の大小は上の鎖}\bigr)
\end{aligned}`),
      paragraph([
        "となる。右辺は ",
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
        " の性質による。有理数の範囲では同じ主張は成り立たない。",
        math(String.raw`c(M_{\mathrm{col}}) > 0`),
        " を示す。",
        math(String.raw`e_1 \in \mathbb{R}^{d}`),
        " を ",
        math(String.raw`(e_1)_1 := 1`),
        "、",
        math(String.raw`i \neq 1`),
        " なら ",
        math(String.raw`(e_1)_i := 0`),
        " で定める。",
        math(String.raw`i \in \{2,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
|(e_1)_i|^2
&= |0|^2
  &&\bigl(\because\ i \neq 1\ \text{なので}\ (e_1)_i = 0\bigr)\\
&= 0^2
  &&\bigl(\because\ \blkref{def_real_absolute_value}\ \text{の}\ 0 \geq 0\ \text{の場合}\ |0| = 0\bigr)\\
&= 0
  &&\bigl(\because\ \mathbb{R}\ \text{で}\ 0^2 = 0\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
|(e_1)_1|^2
&= |1|^2
  &&\bigl(\because\ (e_1)_1 = 1\bigr)\\
&= 1^2
  &&\bigl(\because\ \blkref{def_real_absolute_value}\ \text{の}\ 1 \geq 0\ \text{の場合}\ |1| = 1\bigr)\\
&= 1
  &&\bigl(\because\ \blkref{power_of_real_one_is_one}\ (m \to 2)\bigr)
\end{aligned}`),
      paragraph(["なので"]),
      displayMath(String.raw`\begin{aligned}
\|e_1\|
&= \sqrt{\textstyle\sum_{i=1}^{d}|(e_1)_i|^2}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to e_1)\bigr)\\
&= \sqrt{1 + 0 + \cdots + 0}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \text{上の}\ |(e_1)_1|^2 = 1\ \text{と}\ |(e_1)_i|^2 = 0\ (i \geq 2)\ \text{を各項へ。和は}\ \blkref{def_finite_sum_of_real_numbers}\ \text{の左から順に足したもの}\bigr)\\
&= \sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
  &&\bigl(\because\ \mathbb{R}\ \text{で}\ 1 + 0 = 1\ \text{を左から順に}\bigr)\\
&= 1
  &&\bigl(\because\ \blkref{sqrt_of_real_one_is_one}\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`e_1^\top W_{\mathbb{R}} e_1 \in \mathcal{R}`),
        " である（これが ",
        math(String.raw`\mathcal{R}`),
        " が空でないことの根拠でもある）。",
      ]),
      displayMath(String.raw`\begin{aligned}
c(M_{\mathrm{col}})
&= \sup \mathcal{R}
  &&\bigl(\because\ c(M_{\mathrm{col}})\ \text{の定義}\bigr)\\
&\geq e_1^\top W_{\mathbb{R}} e_1
  &&\bigl(\because\ \text{上限は}\ \mathcal{R}\ \text{の上界であり、}\ e_1^\top W_{\mathbb{R}} e_1 \in \mathcal{R}\bigr)\\
&> 0
  &&\bigl(\because\ e_1^\top W_{\mathbb{R}} e_1 \in \mathcal{R} \subseteq \mathbb{R}_{>0}\bigr)
\end{aligned}`),
      paragraph([
        "である。定義から",
      ]),
      displayMath(
        String.raw`x^\top W_{\mathbb{R}} x \leq c(M_{\mathrm{col}})\,\|x\|^2 \qquad (\forall x \in \mathbb{R}^{d})`,
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
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 「‖x‖ = 1 なら x ≠ 0」の鎖の最後の行 √0 = 0 が definition_of_sqrt_r_positive（y → 0）と 0 ≥ 0・0^2 = 0 を 1 行で使っていたので、sqrt_of_real_zero_is_zero の参照にした（値は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: ‖e_1‖ の鎖の |1|^2 = 1^2 = 1 の 2 行目を power_of_real_one_is_one（m → 2）の参照にし、最後の行 √1 = 1 を sqrt_of_real_one_is_one の参照にした（値は不変）。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: |x_i| ≤ 1 を示す鎖の名前だけの根拠を直した。「非負の項の有限和は各項以上」を finite_sum_of_nonnegative_reals_is_at_least_each_term（m → 2^{M_col}、a_j → |x_j|^2、k → i）の参照に、「ノルムの定義」の 1 行を definition_of_sqrt_r_positive の y^2 = x の行と def_matrix_norm の行の 2 行に割り、最後の行を 1^2 で止めた。|x_i|^2 ≤ 1^2 から |x_i| ≤ 1 へ移る段を nonnegative_real_order_from_squares（u → |x_i|、v → 1）の参照にした。x と i の取り方、|x_k|^2 ≥ 0、根号の中身 Σ_j|x_j|^2 が非負であること（同じ主張と推移律）を鎖の前に書いた。主張は不変。",
        "2026-11-06（同じ確認の続き）: |x^⊤Wx| ≤ ΣΣ|W_ij| の鎖の名前だけの根拠を直した。𝓡 の元 x^⊤Wx を |x^⊤Wx| で上から抑える行（real_number_is_at_most_its_absolute_value）を鎖の先頭に足し、「行列積の成分表示」を def_real_bilinear_value の参照に、「有限和の三角不等式と積の絶対値」と「|x_i| ≤ 1, |x_j| ≤ 1」を、項ごとの 6 行の鎖（real_abs_of_product を 2 回、|x_j| ≤ 1 と |x_i| ≤ 1 に非負の実数を掛ける行）、各 i の 2 行の鎖（finite_sum_of_real_numbers_triangle_inequality・finite_sum_of_real_numbers_is_monotone）、外側の和の 2 行（同じ 2 つの主張）に割った。上界 ΣΣ|W_ij| と主張は不変。",
        "2026-11-06（同じ確認の続き）: 冒頭で定めていた W_ℝ := ϱ(W) を独立の定義 def_W_real へ切り出して引く形にした。𝓡 ⊆ ℝ_{>0} と c(M_col) > 0 の根拠が書かれていなかったので、x = 0 なら ‖x‖ = 0 の 6 行の鎖と W_real_is_positive_definite、項ごとの値の 3 行の鎖 2 本・‖e_1‖ = 1 の 4 行の鎖と c = sup 𝓡 ≥ e_1^⊤W_ℝe_1 > 0 の 3 行の鎖を足した（𝓡 が空でないことの ‖e_1‖ = 1 もこの鎖で示す）。主張は変えていない。",
        "2026-11-06（同じ確認の続き）: 冒頭の「W は W_is_real_symmetric_positive_definite より実行列とみなせる」（同一視）を、W の成分がすべて実数であること（def_matrix_with_real_entries）と、新しく足した def_real_matrix_of_real_entry_matrix の写像 ϱ で定める W_ℝ := ϱ(W) ∈ Mat(2^{M_col},ℝ) に替え、𝓡・c(M_col)・上に有界であることの鎖・x^⊤Wx ≤ c‖x‖^2 の W を W_ℝ（成分 (W_ℝ)_{ij}）にした。値は変わらない。このブロックを引くほかのブロックの x^⊤Wx は、まだ W のまま書いてある。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ・ベクトルの次元・添字の範囲・有限和の上端を添字なしの 2^{M_col} で書いていた 40 か所を、主張の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の def_W_real・trace_of_W_power_via_W_real と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。def_matrix_norm の当てはめは K = ℝ, d → d と書いた（K の当てはめの抜けも合わせて直した）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_007_claim_operator_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 9 },
    title: { tex: String.raw`\|W_{\mathbb{R}}x\| \leq c(M_{\mathrm{col}})\,\|x\|` },
    labels: ["rayleigh_bounds_operator_norm"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列、",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        ref("def_rayleigh_sup"),
        " の数とする。",
        math(String.raw`\forall x \in \mathbb{R}^{d}`),
        " について ",
        math(String.raw`\|W_{\mathbb{R}}x\| \leq c(M_{\mathrm{col}})\,\|x\|`),
        "。したがって ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\|(W_{\mathbb{R}})^k x\| \leq c(M_{\mathrm{col}})^k\|x\|`),
        "。行列とベクトルの積 ",
        math(String.raw`W_{\mathbb{R}}x`),
        "・",
        math(String.raw`(W_{\mathbb{R}})^kx`),
        " は ",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d`),
        "）のもの、冪 ",
        math(String.raw`(W_{\mathbb{R}})^k`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " のもの（積は ",
        ref("def_real_matrix_product"),
        "、",
        math(String.raw`(W_{\mathbb{R}})^0`),
        " は ",
        ref("def_real_identity_matrix"),
        " の ",
        math(String.raw`I_{\mathrm{Mat}(d,\mathbb{R})}`),
        "）、ノルムは ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K = \mathbb{R}`),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "（",
        ref("def_rayleigh_sup"),
        "）と略記する。",
      ]),
      paragraph([
        math(String.raw`x \in \mathbb{R}^{d}`),
        " を取り、",
        math(String.raw`y := W_{\mathbb{R}}x`),
        "（成分は ",
        math(String.raw`y_k = \sum_{l=1}^{d} (W_{\mathbb{R}})_{kl}\,x_l`),
        "（",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to W_{\mathbb{R}},\ x \to x`),
        "））。",
        math(String.raw`(W_{\mathbb{R}})_{kl}`),
        " と ",
        math(String.raw`x_l`),
        " は実数なので ",
        math(String.raw`y \in \mathbb{R}^{d}`),
        "）とおく。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W_{\mathbb{R}}x\|^2
&=\|y\|^2
&&\bigl(\because\ y:=W_{\mathbb{R}}x\bigr)\\
&=\sum_{k=1}^{d}|y_k|^2
&&\bigl(\because\ \text{ノルムの定義 }\blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to y)\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{a}\bigr)^2=a\bigr)\\
&=\sum_{k=1}^{d}y_k\,y_k
&&\bigl(\because\ y_k\in\mathbb{R}\ \text{なので}\ |y_k|^2=y_ky_k\bigr)\\
&=\sum_{k=1}^{d}y_k\sum_{l=1}^{d}(W_{\mathbb{R}})_{kl}\,x_l
&&\bigl(\because\ y=W_{\mathbb{R}}x\ \text{の成分 }\blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to W_{\mathbb{R}},\ x \to x)\bigr)\\
&=\sum_{k=1}^{d}\sum_{l=1}^{d}y_k\,(W_{\mathbb{R}})_{kl}\,x_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\ y_k((W_{\mathbb{R}})_{kl}x_l)=(y_k(W_{\mathbb{R}})_{kl})x_l\bigr)\\
&=y^\top W_{\mathbb{R}}x
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to W_{\mathbb{R}},\ x \to y,\ y \to x)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`W_{\mathbb{R}}`),
        " は対称（",
        ref("W_real_is_symmetric"),
        "）かつ半正定値（",
        ref("W_real_is_positive_semidefinite"),
        "）であるから、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W_{\mathbb{R}}x\|^4
&=\left(\|W_{\mathbb{R}}x\|^2\right)^2
&&\bigl(\because\ \text{冪の指数法則}\bigr)\\
&=\left(y^\top W_{\mathbb{R}}x\right)^2
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&\leq\left(x^\top W_{\mathbb{R}}x\right)\left(y^\top W_{\mathbb{R}}y\right)
&&\bigl(\because\ \blkref{psd_cauchy_schwarz}\ (n \to d,\ P \to W_{\mathbb{R}},\ x \to x,\ y \to y)\bigr)\\
&\leq\left(c\|x\|^2\right)\left(y^\top W_{\mathbb{R}}y\right)
&&\bigl(\because\ \blkref{def_rayleigh_sup}\ \text{の}\ x^\top W_{\mathbb{R}}x\leq c\|x\|^2\ \text{と}\ \blkref{W_real_is_positive_semidefinite}\ (u \to y)\ \text{の}\ 0\leq y^\top W_{\mathbb{R}}y\bigr)\\
&\leq\left(c\|x\|^2\right)\left(c\|y\|^2\right)
&&\bigl(\because\ \blkref{def_rayleigh_sup}\ \text{の}\ y^\top W_{\mathbb{R}}y\leq c\|y\|^2\ (x \to y)\ \text{と}\ 0\leq c\|x\|^2\ \text{（}c>0\text{）}\bigr)\\
&=c^2\|x\|^2\|W_{\mathbb{R}}x\|^2
&&\bigl(\because\ y=W_{\mathbb{R}}x\ \text{と}\ \mathbb{R}\ \text{の乗法の可換則・結合則}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`\|W_{\mathbb{R}}x\| = 0`),
        " のときは左辺が ",
        math(String.raw`0`),
        "、右辺が ",
        math(String.raw`c\|x\| \geq 0`),
        " なので主張が成り立つ。以下 ",
        math(String.raw`\|W_{\mathbb{R}}x\| > 0`),
        " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\|W_{\mathbb{R}}x\|^4 \leq c^2\|x\|^2\|W_{\mathbb{R}}x\|^2
&\Longrightarrow \|W_{\mathbb{R}}x\|^2 \leq c^2\|x\|^2
  &&\bigl(\because\ \text{両辺を}\ \|W_{\mathbb{R}}x\|^2>0\ \text{で割る}\bigr)\\
&\Longrightarrow \|W_{\mathbb{R}}x\|^2 \leq \bigl(c\|x\|\bigr)^2
  &&\bigl(\because\ \text{冪の指数法則}\ c^2\|x\|^2=\bigl(c\|x\|\bigr)^2\bigr)\\
&\Longrightarrow \|W_{\mathbb{R}}x\| \leq c\|x\|
  &&\bigl(\because\ \blkref{nonnegative_real_order_from_squares}\ (u \to \|W_{\mathbb{R}}x\|,\ v \to c\|x\|)\ \text{と}\ \|W_{\mathbb{R}}x\| \geq 0,\ c\|x\| \geq 0\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意に取ったので、すべての ",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " について ",
        math(String.raw`\|W_{\mathbb{R}}x\| \leq c\|x\|`),
        " である。",
      ]),
      paragraph([
        "冪についての主張は ",
        math(String.raw`k`),
        " に関する帰納法で示す。",
        math(String.raw`k=0`),
        " のときは、",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\|(W_{\mathbb{R}})^0x\|
&=\|I_{\mathrm{Mat}(d,\mathbb{R})}\,x\|
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0:=I\ (K = \mathbb{R}\text{。}I\ \text{は}\ \blkref{def_real_identity_matrix})\bigr)\\
&=\|x\|
  &&\bigl(\because\ \blkref{real_identity_matrix_is_left_unit_of_real_matrix_vector_product}\ (n \to d,\ x \to x)\bigr)\\
&=c^0\|x\|
  &&\bigl(\because\ c^0=1\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k`),
        " で成り立つ（すべての ",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " について ",
        math(String.raw`\|(W_{\mathbb{R}})^kx\| \leq c^k\|x\|`),
        "）とし、",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\|(W_{\mathbb{R}})^{k+1}x\|
&=\|((W_{\mathbb{R}})^kW_{\mathbb{R}})x\|
  &&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1}:=A^mA\ (K = \mathbb{R}\text{。積は}\ \blkref{def_real_matrix_product})\bigr)\\
&=\|(W_{\mathbb{R}})^k(W_{\mathbb{R}}x)\|
  &&\bigl(\because\ \blkref{real_matrix_vector_product_is_associative}\ (m, n, p \to d,\ P \to (W_{\mathbb{R}})^k,\ Q \to W_{\mathbb{R}},\ x \to x)\bigr)\\
&\leq c^k\|W_{\mathbb{R}}x\|
  &&\bigl(\because\ \text{帰納法の仮定を}\ W_{\mathbb{R}}x\in\mathbb{R}^{d}\ \text{に適用}\bigr)\\
&\leq c^k\bigl(c\|x\|\bigr)
  &&\bigl(\because\ \text{いま示した評価}\ \|W_{\mathbb{R}}x\|\leq c\|x\|\ \text{と}\ c^k\geq 0\ \text{（}c>0\text{）}\bigr)\\
&=c^{k+1}\|x\|
  &&\bigl(\because\ \text{冪の指数法則と}\ \mathbb{R}\ \text{の乗法の結合則}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意に取ったので、",
        math(String.raw`k+1`),
        " のときもすべての ",
        math(String.raw`x \in \mathbb{R}^{d}`),
        " について成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: SageMath の検算（sagemath/check/rayleigh_bounds_operator_norm/）を付けるにあたり、二か所を直した（主張は不変）。(1) 一つ目の鎖は ‖Wx‖^2 = (Wx)^⊤(Wx) = y^⊤(Wx) で止まり、続く鎖が使う y^⊤Wx（def_real_bilinear_value の二重和）との等号が書かれていなかった。def_matrix_norm・definition_of_sqrt_r_positive・y の成分・分配則・def_real_bilinear_value の 5 行（‖Wx‖^2 = ‖y‖^2 の置き換えと合わせて 6 行）で ‖Wx‖^2 = y^⊤Wx まで一続きにし、y ∈ ℝ^n であることを置き方に書いた（y の成分と鎖の 4 行目に mat_mult を引き、‖Wx‖^2 = ‖y‖^2 の置き換えを独立の行にした）。k = 0 の行に def_exp (1) の A^0 := I・identity_matrix_is_left_unit_of_mat_mult・c^0 = 1 の 3 行の鎖を置いた。(2) 帰納法の段の 1 行目 ‖W^{k+1}x‖ = ‖W(W^kx)‖ は「行列の冪の定義と結合則」としていたが、def_exp (1) の冪は W^{k+1} := W^kW で、W(W^kx) にするには W^kW = WW^k が要り、その主張は本文に無い。W^{k+1}x = (W^kW)x = W^k(Wx) とし、帰納法の仮定（すべての x について）を Wx に当て、前半の評価を後に使う順にした。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: psd_cauchy_schwarz は実数の行列 P を取るのに、複素行列 W を当てていた。主張と証明の W を def_W_real の W_ℝ に替え（冪は (W_ℝ)^k）、psd_cauchy_schwarz の仮定を W_real_is_symmetric と、新しく足した主張 W_real_is_positive_semidefinite で満たす形にした。旧い根拠「W_is_real_symmetric_positive_definite より実対称かつ正定値、とくに半正定値」はこれに替わる。y の成分が実数である理由を (W_ℝ)_{kl} が実数であることにした。最後の段の「平方の単調性」を c^2‖x‖^2 = (c‖x‖)^2 の行と nonnegative_real_order_from_squares（u → ‖W_ℝx‖、v → c‖x‖）に割り、c > 0 の根拠に def_rayleigh_sup を引いた。実数の行列の積・冪・単位行列は、ほかの K = ℝ の箇所と同じく mat_mult・def_exp (1)・identity_matrix_is_left_unit_of_mat_mult を引いている（これらは ℂ の行列についてだけ述べる。状態台帳の「mat_mult を K について述べる件」）。主張の値は変わらない。",
        "2026-11-06（同じ確認の続き）: 主張と証明の行列とベクトルの積を、係数が ℂ の行列の積 mat_mult の成分の式（数ベクトルを 1 列の行列とみなす）から def_real_matrix_vector_product に替え、冪の積と (W_ℝ)^0 を def_real_matrix_product・def_real_identity_matrix で読むと書いた。k = 0 の段の identity_matrix_is_left_unit_of_mat_mult を、新しく足した real_identity_matrix_is_left_unit_of_real_matrix_vector_product に、帰納法の段の mat_mult_associative を、新しく足した real_matrix_vector_product_is_associative に替えた。主張の値は変わらない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ・ベクトルの次元・有限和の上端・当てはめ（m, n, p → ·）を添字なしの 2^{M_col} で書いていた 26 か所（単位行列 I_{Mat(·,ℝ)} を含む）を、主張の冒頭で d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d で書いた（同じ章の def_W_real・def_rayleigh_sup・trace_power_upper_bound と同じ書き方。ℝ の元 2_ℝ^{M_col} と同じ記号を使わないため）。一つ目の鎖の def_matrix_norm に当てはめ K = ℝ, d → d, w → y を書いた。主張・値・手順は不変。",
      ],
    },
  },
  {
    id: "maxeig_008a_claim_trace_power_upper_bound",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 10 },
    title: { tex: String.raw`\sum_{k} ((W_{\mathbb{R}})^{n})_{kk} \leq 2^{M_{\mathrm{col}}} c(M_{\mathrm{col}})^{n}` },
    labels: ["trace_power_upper_bound"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列、",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        ref("def_rayleigh_sup"),
        " の数とする。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(String.raw`\sum_{k=1}^{d} \bigl((W_{\mathbb{R}})^{n}\bigr)_{kk}\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{n}`),
      paragraph([
        "が成り立つ。左辺の ",
        math(String.raw`(W_{\mathbb{R}})^{n}`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪、和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和である。右辺の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " の ",
        ref("def_power_of_real_number"),
        " の冪 ",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
        " の略記で、",
        math(String.raw`\mathbb{Z}`),
        " の元 ",
        math(String.raw`d`),
        " とは別の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "（",
        ref("def_rayleigh_sup"),
        "）と略記する。",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " は ",
        ref("def_symmetrized_transfer_matrix"),
        " の行列で、",
        ref("def_W_real"),
        " より ",
        math(String.raw`W \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）、",
        math(String.raw`W_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)`),
        " である。",
        math(String.raw`B \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " について ",
        math(String.raw`B_{\mathbb{R}} := \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(B)`),
        " と書く（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の略記）。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
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
        " で定める。実数の行列とベクトルの積 ",
        math(String.raw`(W_{\mathbb{R}})^{a}e_k \in \mathbb{R}^{d}`),
        " は ",
        ref("def_real_matrix_vector_product"),
        " の積である。",
      ]),
      paragraph([
        "【",
        math(String.raw`e_k`),
        " のノルム】",
        math(String.raw`i \in \{1,\dots,d\}`),
        "、",
        math(String.raw`i \neq k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
|(e_k)_i|^2
&= |0|^2
&&\bigl(\because\ i \neq k\ \text{なので}\ (e_k)_i = 0\bigr)\\
&= 0^2
&&\bigl(\because\ \blkref{def_real_absolute_value}\ \text{の}\ 0 \geq 0\ \text{の場合}\ |0| = 0\bigr)\\
&= 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0^2 = 0\bigr)
\end{aligned}`),
      paragraph(["なので"]),
      displayMath(String.raw`\begin{aligned}
\|e_k\|
&=\sqrt{\sum_{i=1}^{d}|(e_k)_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{def_matrix_norm}\ (K = \mathbb{R},\ d \to d,\ w \to e_k)\bigr)\\
&=\sqrt{0 + \cdots + 0 + |(e_k)_k|^2 + 0 + \cdots + 0}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \text{上の}\ |(e_k)_i|^2 = 0\ (i \neq k)\ \text{を}\ k\ \text{以外の各項へ。和は}\ \blkref{def_finite_sum_of_real_numbers}\ \text{の左から順に足したもの。}\ |(e_k)_k|^2\ \text{の前に}\ 0\ \text{が}\ k-1\ \text{個、後に}\ d-k\ \text{個（}0\ \text{個のときは書かない）}\bigr)\\
&=\sqrt{|(e_k)_k|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0 + a = a\ \text{と}\ a + 0 = a\ (a \in \mathbb{R})\ \text{を左から順に}\bigr)\\
&=\sqrt{|1|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ (e_k)_k = 1\bigr)\\
&=\sqrt{1^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{def_real_absolute_value}\ \text{の}\ 1 \geq 0\ \text{の場合}\ |1| = 1\bigr)\\
&=\sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{power_of_real_one_is_one}\ (m \to 2)\bigr)\\
&=1
&&\bigl(\because\ \blkref{sqrt_of_real_one_is_one}\bigr)
\end{aligned}`),
      paragraph([
        "【冪の実数の行列】",
        ref("real_matrix_of_real_entry_matrix_preserves_power"),
        "（",
        math(String.raw`n \to d,\ A \to W,\ q \to p`),
        "）より、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        math(String.raw`W^p`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{C}`),
        " の冪）であり、",
      ]),
      displayMath(String.raw`(W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p`),
      paragraph(["である。"]),
      paragraph([
        "【冪の対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）であり（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "）、とくに ",
        math(String.raw`(W^p)^\top = W^p`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）である。すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\bigl((W_{\mathbb{R}})^p\bigr)_{kl}\Bigr)_{\mathbb{C}}
&=\Bigl(\bigl((W^p)_{\mathbb{R}}\bigr)_{kl}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p\bigr)\\
&=(W^p)_{kl}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^p)\bigr)\\
&=\bigl((W^p)^\top\bigr)_{kl}
&&\bigl(\because\ (W^p)^\top = W^p\bigr)\\
&=(W^p)_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&=\Bigl(\bigl((W^p)_{\mathbb{R}}\bigr)_{lk}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^p)\bigr)\\
&=\Bigl(\bigl((W_{\mathbb{R}})^p\bigr)_{lk}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to ((W_{\mathbb{R}})^p)_{kl},\ b \to ((W_{\mathbb{R}})^p)_{lk}`),
        "）より ",
        math(String.raw`((W_{\mathbb{R}})^p)_{kl} = ((W_{\mathbb{R}})^p)_{lk}`),
        " である。",
      ]),
      paragraph([
        "【対角成分の表示】",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top (W_{\mathbb{R}})^p e_k
&=\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i\,\bigl((W_{\mathbb{R}})^p\bigr)_{ij}\,(e_k)_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to (W_{\mathbb{R}})^p,\ x, y \to e_k)\bigr)\\
&=\sum_{j=1}^{d}(e_k)_k\,\bigl((W_{\mathbb{R}})^p\bigr)_{kj}\,(e_k)_j
&&\bigl(\because\ i \neq k\ \text{の項は}\ (e_k)_i = 0\ \text{なので}\ 0\bigr)\\
&=\sum_{j=1}^{d}\bigl((W_{\mathbb{R}})^p\bigr)_{kj}\,(e_k)_j
&&\bigl(\because\ (e_k)_k = 1\bigr)\\
&=\bigl((W_{\mathbb{R}})^p\bigr)_{kk}\,(e_k)_k
&&\bigl(\because\ j \neq k\ \text{の項は}\ (e_k)_j = 0\ \text{なので}\ 0\bigr)\\
&=\bigl((W_{\mathbb{R}})^p\bigr)_{kk}
&&\bigl(\because\ (e_k)_k = 1\bigr)
\end{aligned}`),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^ae_k`),
        " の成分とノルム】",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`k \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`u := (W_{\mathbb{R}})^ae_k \in \mathbb{R}^d`),
        " とおく。",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
u_l
&=\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{lm}\,(e_k)_m
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to (W_{\mathbb{R}})^a,\ x \to e_k)\bigr)\\
&=\bigl((W_{\mathbb{R}})^a\bigr)_{lk}\,(e_k)_k
&&\bigl(\because\ m \neq k\ \text{の項は}\ (e_k)_m = 0\ \text{なので}\ 0\bigr)\\
&=\bigl((W_{\mathbb{R}})^a\bigr)_{lk}
&&\bigl(\because\ (e_k)_k = 1\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
\|u\|
&=\bigl\|(W_{\mathbb{R}})^ae_k\bigr\|
&&\bigl(\because\ u := (W_{\mathbb{R}})^ae_k\bigr)\\
&\leq c^a\,\|e_k\|
&&\bigl(\because\ \blkref{rayleigh_bounds_operator_norm}\ \text{の冪の主張}\ (\text{指数}\ k \to a,\ x \to e_k)\bigr)\\
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
        "）が偶数の場合。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
(W_{\mathbb{R}})^{2a}
&=(W^{2a})_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to 2a)\bigr)\\
&=(W^{a+a})_{\mathbb{R}}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a = a+a\bigr)\\
&=(W^aW^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p, q \to a)\bigr)\\
&=(W^a)_{\mathbb{R}}\,(W^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A, B \to W^a)\bigr)\\
&=(W_{\mathbb{R}})^a\,(W_{\mathbb{R}})^a
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to a)\ \text{を二つの因子へ同時に適用}\bigr)
\end{aligned}`),
      paragraph([
        "である（",
        math(String.raw`W^a \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " は【冪の実数の行列】、右辺の積は ",
        ref("def_real_matrix_product"),
        "）。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " と【",
        math(String.raw`(W_{\mathbb{R}})^ae_k`),
        " の成分とノルム】の ",
        math(String.raw`u = (W_{\mathbb{R}})^ae_k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top (W_{\mathbb{R}})^{2a}e_k
&=\bigl((W_{\mathbb{R}})^{2a}\bigr)_{kk}
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to 2a)\bigr)\\
&=\bigl((W_{\mathbb{R}})^a(W_{\mathbb{R}})^a\bigr)_{kk}
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&=\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{kl}\,\bigl((W_{\mathbb{R}})^a\bigr)_{lk}
&&\bigl(\because\ \blkref{def_real_matrix_product}\ (m, n, p \to d,\ P, Q \to (W_{\mathbb{R}})^a)\bigr)\\
&=\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{lk}\,\bigl((W_{\mathbb{R}})^a\bigr)_{lk}
&&\bigl(\because\ \text{【冪の対称性】の}\ ((W_{\mathbb{R}})^a)_{kl} = ((W_{\mathbb{R}})^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}u_l\,u_l
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ae_k\text{ の成分とノルム】の}\ u_l = ((W_{\mathbb{R}})^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}|u_l|^2
&&\bigl(\because\ u_l \in \mathbb{R}\ \text{なので}\ \blkref{def_real_absolute_value}\ \text{より}\ u_lu_l = |u_l|^2\bigr)\\
&=\|u\|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&\leq c^{2a}
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ae_k\text{ の成分とノルム】の}\ \|u\|^2 \leq c^{2a}\bigr)\\
&=c^n
&&\bigl(\because\ n = 2a\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`n = 2a+1`),
        "（",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        "）が奇数の場合。まず ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " で",
      ]),
      displayMath(String.raw`\begin{aligned}
W^{2a+1}
&=W^{a+(1+a)}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a+1 = a+(1+a)\bigr)\\
&=W^aW^{1+a}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p \to a,\ q \to 1+a)\bigr)\\
&=W^a\bigl(W^1W^a\bigr)
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p \to 1,\ q \to a)\bigr)\\
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
        ref("real_matrix_of_real_entry_matrix_preserves_product"),
        "（",
        math(String.raw`m, n, p \to d,\ A \to W,\ B \to W^a`),
        "）より ",
        math(String.raw`WW^a \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " で ",
        math(String.raw`(WW^a)_{\mathbb{R}} = W_{\mathbb{R}}(W^a)_{\mathbb{R}}`),
        " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
(W_{\mathbb{R}})^{2a+1}
&=(W^{2a+1})_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to 2a+1)\bigr)\\
&=\bigl(W^a(WW^a)\bigr)_{\mathbb{R}}
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&=(W^a)_{\mathbb{R}}\,(WW^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to W^a,\ B \to WW^a)\bigr)\\
&=(W^a)_{\mathbb{R}}\bigl(W_{\mathbb{R}}(W^a)_{\mathbb{R}}\bigr)
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to W,\ B \to W^a)\bigr)\\
&=(W_{\mathbb{R}})^a\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to a)\ \text{を二か所へ同時に適用}\bigr)
\end{aligned}`),
      paragraph([
        "である（右辺の積は ",
        ref("def_real_matrix_product"),
        "）。",
        math(String.raw`k \in \{1,\dots,d\}`),
        " と【",
        math(String.raw`(W_{\mathbb{R}})^ae_k`),
        " の成分とノルム】の ",
        math(String.raw`u = (W_{\mathbb{R}})^ae_k`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
e_k^\top (W_{\mathbb{R}})^{2a+1}e_k
&=\bigl((W_{\mathbb{R}})^{2a+1}\bigr)_{kk}
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to 2a+1)\bigr)\\
&=\Bigl((W_{\mathbb{R}})^a\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)_{kk}
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&=\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{kl}\,\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)_{lk}
&&\bigl(\because\ \blkref{def_real_matrix_product}\ (m, n, p \to d,\ P \to (W_{\mathbb{R}})^a,\ Q \to W_{\mathbb{R}}(W_{\mathbb{R}})^a)\bigr)\\
&=\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{kl}\sum_{m=1}^{d}(W_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mk}
&&\bigl(\because\ \blkref{def_real_matrix_product}\ (m, n, p \to d,\ P \to W_{\mathbb{R}},\ Q \to (W_{\mathbb{R}})^a)\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{kl}\,(W_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mk}
&&\bigl(\because\ \text{分配則と乗法の結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{lk}\,(W_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mk}
&&\bigl(\because\ \text{【冪の対称性】の}\ ((W_{\mathbb{R}})^a)_{kl} = ((W_{\mathbb{R}})^a)_{lk}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}u_l\,(W_{\mathbb{R}})_{lm}\,u_m
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ae_k\text{ の成分とノルム】の}\ u_l = ((W_{\mathbb{R}})^a)_{lk},\ u_m = ((W_{\mathbb{R}})^a)_{mk}\bigr)\\
&=u^\top W_{\mathbb{R}}u
&&\bigl(\because\ \blkref{def_real_bilinear_value}\ (n \to d,\ P \to W_{\mathbb{R}},\ x, y \to u)\bigr)\\
&\leq c\,\|u\|^2
&&\bigl(\because\ \blkref{def_rayleigh_sup}\ \text{の}\ x^\top W_{\mathbb{R}}x \leq c\|x\|^2\ (x \to u)\bigr)\\
&\leq c\,c^{2a}
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ae_k\text{ の成分とノルム】の}\ \|u\|^2 \leq c^{2a}\ \text{と}\ c > 0\bigr)\\
&=c^{2a+1}
&&\bigl(\because\ \mathbb{R}\ \text{の冪の指数法則}\bigr)\\
&=c^n
&&\bigl(\because\ n = 2a+1\bigr)
\end{aligned}`),
      paragraph([
        "である。いずれの場合も、すべての ",
        math(String.raw`k`),
        " について ",
        math(String.raw`e_k^\top (W_{\mathbb{R}})^ne_k \leq c^n`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{d}\bigl((W_{\mathbb{R}})^n\bigr)_{kk}
&=\sum_{k=1}^{d} e_k^\top (W_{\mathbb{R}})^n e_k
&&\bigl(\because\ \text{【対角成分の表示】}\ (p \to n)\ \text{を}\ d\ \text{個の項へ同時に適用}\bigr)\\
&\leq \sum_{k=1}^{d} c^n
&&\bigl(\because\ \blkref{finite_sum_of_real_numbers_is_monotone}\ (m \to d,\ \text{添字}\ j \to k,\ a_k \to e_k^\top (W_{\mathbb{R}})^ne_k,\ b_k \to c^n\text{。各}\ k\ \text{の}\ a_k \leq b_k\ \text{は上の偶数・奇数の鎖})\bigr)\\
&=\iota_{\mathbb{Z}\to\mathbb{R}}(d)\,c^n
&&\bigl(\because\ \blkref{finite_sum_of_constant_real_number}\ (m \to d \in \mathbb{Z}_{\geq 1},\ r \to c^n)\bigr)\\
&=\iota_{\mathbb{Z}\to\mathbb{R}}\bigl(2_{\mathbb{Z}}^{\,M_{\mathrm{col}}}\bigr)\,c^n
&&\bigl(\because\ d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}}\bigr)\\
&=2_{\mathbb{R}}^{\,M_{\mathrm{col}}}\,c^n
&&\bigl(\because\ \blkref{inclusion_zz_to_rr_of_power_of_two}\ (M \to M_{\mathrm{col}})\bigr)
\end{aligned}`),
      paragraph([
        "となり（",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " は ",
        ref("inclusion_zz_to_rr"),
        " の写像）、",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}}`),
        " は主張の右辺の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " なので、主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【e_k のノルム】の 2 行目「i ≠ k の項は |(e_k)_i|^2 = |0|^2 = 0」（(e_k)_i = 0・|0| = 0・0^2 = 0・0 の項を和から落とすことを 1 行で使っていた）を、i ≠ k の |(e_k)_i|^2 の 3 行の鎖（def_rayleigh_sup の |(e_1)_i|^2 の鎖と同じ書き方）と、ノルムの鎖の「各項へ当てる」「0 の項を落とす」の 2 行に割った（値は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【e_k のノルム】の最後の行 √1 = 1 を sqrt_of_real_one_is_one の参照にした（値は不変）。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【e_k のノルム】の 4 行目 √(|1|^2) = √1（根拠 |1|^2 = 1 が |1| = 1 と 1^2 = 1 の 2 つの事実を 1 行で使っていた）を、def_real_absolute_value の 1 ≥ 0 の場合 |1| = 1 の行と power_of_real_one_is_one（m → 2）の行の 2 行に割った（def_rayleigh_sup の |(e_1)_1|^2 の鎖と同じ書き方。値は不変）。",
        "2026-09-05 の分割で、トレースの挟み込みを上からの評価・モーメントの対数凸性・下からの評価の三主張へ分けた。この主張は上からの評価だけを扱う。式変形と根拠は分割前と同じで、後置きしていた作用素評価の参照を適用行の末尾へ移した。",
        "2026-11-04: SageMath の検算（sagemath/check/trace_power_upper_bound/）を付けるにあたり、根拠の欠けを直した（主張は不変）。(1)「W は実対称なので W^n も実対称」と「冪の指数法則（W^{2a} = W^aW^a、W^{2a+1} = W^aWW^a）」は本文に主張が無かったので、power_of_real_symmetric_complex_matrix_is_real_symmetric・matrix_power_exponent_law・product_of_real_entry_matrices_has_real_entries を足して引いた。(2) 旧い鎖は (W^a e_k)^⊤(W^a e_k) と (W^a)^⊤ = W^a を使っていたが、行列の積の転置の主張は本文に無い。対角成分を mat_mult で開き、W^a の成分の対称性と u_l = (W^a)_{lk} で ‖u‖^2・u^⊤Wu に着く形にした。(3) (W^n)_{kk} = e_k^⊤W^ne_k・‖e_k‖ = 1 を def_real_bilinear_value・def_matrix_norm から示す準備を置き、e_k を定めた。(4)「作用素ノルムのレイリー上限評価の a 回の適用」は rayleigh_bounds_operator_norm の冪の主張（k → a）を一度当てるものなので、そう書いた。(5) W^{2a+1} = W^a(WW^a) を def_exp (1) と matrix_power_exponent_law の鎖にした。def_trace・def_rayleigh_sup への blkref を足した。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 証明は W の冪の成分を「def_rayleigh_sup が W を読むのと同じく実数として読む」としてから def_real_bilinear_value（実数の行列を取る）に当てていた。主張を def_W_real の W_ℝ の冪の対角成分の実数の和 Σ_k ((W_ℝ)^n)_kk で述べ直し（tr(W^n) はその r_ℂ であることは trace_of_W_power_via_W_real が述べる。下流の trace_power_sandwich・partition_function_sandwich はそれを引く形に書き直す予定）、証明の中の冪をすべて (W_ℝ)^p にした。【冪の実数の行列】で real_matrix_of_real_entry_matrix_preserves_power を引き、【冪の対称性】を W^p の実対称性から ϱ を通す 6 行の鎖と単射性に、W^{2a} = W^aW^a・W^{2a+1} = W^a(WW^a) を ϱ で運ぶ 5 行の鎖二本（real_matrix_of_real_entry_matrix_preserves_product）にし、成分の積を def_real_matrix_product で開き、(W_ℝ)^a e_k を新しく足した def_real_matrix_vector_product で開いた（旧い版は mat_mult の成分の式で「読んで」いた）。rayleigh_bounds_operator_norm の主張の積はまだ mat_mult の成分の式で、同じ式だが別の定義である（状態台帳の (r3b2e) で def_real_matrix_vector_product にそろえる）。最後のトレースの鎖の「項ごとの不等式の有限和は順序を保つ」を finite_sum_of_real_numbers_is_monotone の参照にした。値は変わらない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 最後の鎖の「d c^n = 2^{M_col} c^n（∵ d := 2^{M_col}）」は、行列の大きさ d ∈ ℤ と ℝ の冪 2^{M_col} を同じ記号で等号で結んでいた。新しく足した inclusion_zz_to_rr の写像 ι_{ℤ→ℝ} を通し、「同じ項 c^n を d 個足した和 = ι(d)c^n」を finite_sum_of_constant_real_number、「ι(2_ℤ^{M_col}) = 2_ℝ^{M_col}」を inclusion_zz_to_rr_of_power_of_two の参照にした。d を def_power_of_integer の 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した。主張の 2^{M_col} が ℝ の冪であることを主張の文に書いた。値は変わらない。",
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
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列とする（",
        ref("W_real_is_symmetric"),
        " より対称、",
        ref("W_real_is_positive_definite"),
        " より正定値）。単位ベクトル ",
        math(String.raw`x \in \mathbb{R}^{d}`),
        "（",
        math(String.raw`\|x\| = 1`),
        "。ノルムは ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K = \mathbb{R}`),
        "）を固定し、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`m_k := x^\top (W_{\mathbb{R}})^k x \in \mathbb{R}`),
        "（",
        math(String.raw`(W_{\mathbb{R}})^k`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪で積は ",
        ref("def_real_matrix_product"),
        "、値は ",
        ref("def_real_bilinear_value"),
        "）とおく。このとき全ての ",
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
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " は ",
        ref("def_symmetrized_transfer_matrix"),
        " の行列で、",
        ref("def_W_real"),
        " より ",
        math(String.raw`W \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）、",
        math(String.raw`W_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)`),
        " である。",
        math(String.raw`B \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " について ",
        math(String.raw`B_{\mathbb{R}} := \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(B)`),
        " と書く（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の略記）。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
        math(String.raw`I := I_{\mathrm{Mat}(d,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）、",
        math(String.raw`I_{\mathbb{R}} := I_{\mathrm{Mat}(d,\mathbb{R})}`),
        "（",
        ref("def_real_identity_matrix"),
        "）と書く。",
        math(String.raw`W^p`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{C}`),
        " の冪で積は ",
        ref("mat_mult"),
        "、",
        math(String.raw`(W_{\mathbb{R}})^p`),
        " は同じ (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪で、実数の行列どうしの積は ",
        ref("def_real_matrix_product"),
        "、実数の行列と実数のベクトルの積は ",
        ref("def_real_matrix_vector_product"),
        " のものである。",
      ]),
      paragraph([
        "【冪の実数の行列】",
        ref("real_matrix_of_real_entry_matrix_preserves_power"),
        "（",
        math(String.raw`n \to d,\ A \to W,\ q \to p`),
        "）より、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " であり、",
      ]),
      displayMath(String.raw`(W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p`),
      paragraph([
        "である。とくに ",
        math(String.raw`I = W^0`),
        "（",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`A^0 := I`),
        "、",
        math(String.raw`K = \mathbb{C}`),
        "）なので ",
        math(String.raw`I \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
I_{\mathbb{R}}
&=(W_{\mathbb{R}})^0
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{R}\text{、}I = I_{\mathrm{Mat}(d,\mathbb{R})}\ \text{は}\ \blkref{def_real_identity_matrix})\bigr)\\
&=(W^0)_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to 0)\bigr)\\
&=\varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(I)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{C})\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`C = I`),
        " または ",
        math(String.raw`C = W`),
        " とすると、",
        math(String.raw`C \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " であり、",
        math(String.raw`C_{\mathbb{R}}`),
        " は ",
        math(String.raw`C = I`),
        " なら上の鎖より ",
        math(String.raw`I_{\mathbb{R}}`),
        "、",
        math(String.raw`C = W`),
        " なら ",
        ref("def_W_real"),
        " より ",
        math(String.raw`W_{\mathbb{R}}`),
        " である。",
      ]),
      paragraph([
        "【冪の対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）であり（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "）、とくに ",
        math(String.raw`(W^p)^\top = W^p`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）である。すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\bigl((W_{\mathbb{R}})^p\bigr)_{kl}\Bigr)_{\mathbb{C}}
&=\Bigl(\bigl((W^p)_{\mathbb{R}}\bigr)_{kl}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p\bigr)\\
&=(W^p)_{kl}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^p)\bigr)\\
&=\bigl((W^p)^\top\bigr)_{kl}
&&\bigl(\because\ (W^p)^\top = W^p\bigr)\\
&=(W^p)_{lk}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&=\Bigl(\bigl((W^p)_{\mathbb{R}}\bigr)_{lk}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^p)\bigr)\\
&=\Bigl(\bigl((W_{\mathbb{R}})^p\bigr)_{lk}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to ((W_{\mathbb{R}})^p)_{kl},\ b \to ((W_{\mathbb{R}})^p)_{lk}`),
        "）より ",
        math(String.raw`((W_{\mathbb{R}})^p)_{kl} = ((W_{\mathbb{R}})^p)_{lk}`),
        " である。",
      ]),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^ax`),
        " の成分】",
        math(String.raw`a \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`u^{(a)} := (W_{\mathbb{R}})^ax \in \mathbb{R}^d`),
        " とおく。",
        ref("def_real_matrix_vector_product"),
        "（",
        math(String.raw`m, n \to d,\ P \to (W_{\mathbb{R}})^a`),
        "）より、",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について ",
        math(String.raw`u^{(a)}_l = \sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{lm}\,x_m`),
        " である。",
      ]),
      paragraph([
        "【冪の分け方】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について、",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " で",
      ]),
      displayMath(String.raw`\begin{aligned}
W^{a+b}
&=W^{b+a}
&&\bigl(\because\ \mathbb{Z}\ \text{の加法の交換則}\bigr)\\
&=W^bW^a
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p \to b,\ q \to a)\bigr)\\
&=W^b\bigl(IW^a\bigr)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
W^{a+b+1}
&=W^{b+(1+a)}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+b+1 = b+(1+a)\bigr)\\
&=W^bW^{1+a}
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p \to b,\ q \to 1+a)\bigr)\\
&=W^b\bigl(W^1W^a\bigr)
&&\bigl(\because\ \blkref{matrix_power_exponent_law}\ (n \to d,\ A \to W,\ p \to 1,\ q \to a)\bigr)\\
&=W^b\bigl(W^{0+1}W^a\bigr)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=W^b\bigl((W^0W)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ \text{を}\ m = 0\ \text{に適用}\bigr)\\
&=W^b\bigl((IW)W^a\bigr)
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\bigr)\\
&=W^b\bigl(WW^a\bigr)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`C = I`),
        " なら ",
        math(String.raw`s := a+b`),
        "、",
        math(String.raw`C = W`),
        " なら ",
        math(String.raw`s := a+b+1`),
        " とおくと、上の二つの鎖は ",
        math(String.raw`W^{s} = W^b(CW^a)`),
        " である。",
        ref("real_matrix_of_real_entry_matrix_preserves_product"),
        "（",
        math(String.raw`m, n, p \to d,\ A \to C,\ B \to W^a`),
        "）より ",
        math(String.raw`CW^a \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " で ",
        math(String.raw`(CW^a)_{\mathbb{R}} = C_{\mathbb{R}}(W^a)_{\mathbb{R}}`),
        " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
(W_{\mathbb{R}})^{s}
&=(W^{s})_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to s)\bigr)\\
&=\bigl(W^b(CW^a)\bigr)_{\mathbb{R}}
&&\bigl(\because\ \text{上の二つの鎖}\bigr)\\
&=(W^b)_{\mathbb{R}}\,(CW^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to W^b,\ B \to CW^a)\bigr)\\
&=(W^b)_{\mathbb{R}}\bigl(C_{\mathbb{R}}(W^a)_{\mathbb{R}}\bigr)
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to C,\ B \to W^a)\bigr)\\
&=(W_{\mathbb{R}})^b\bigl(C_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to b)\ \text{と}\ (p \to a)\ \text{を二か所へ同時に適用}\bigr)
\end{aligned}`),
      paragraph([
        "である。すなわち ",
        math(String.raw`(W_{\mathbb{R}})^{a+b} = (W_{\mathbb{R}})^b\bigl(I_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)`),
        "（一つ目）、",
        math(String.raw`(W_{\mathbb{R}})^{a+b+1} = (W_{\mathbb{R}})^b\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)`),
        "（二つ目）である。",
      ]),
      paragraph([
        "【二つの冪で挟んだ値】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " と、",
        math(String.raw`C_{\mathbb{R}} = I_{\mathbb{R}}`),
        " または ",
        math(String.raw`C_{\mathbb{R}} = W_{\mathbb{R}}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
x^\top\Bigl((W_{\mathbb{R}})^b\bigl(C_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\,\Bigl((W_{\mathbb{R}})^b\bigl(C_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)_{ij}\,x_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\Bigl(\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^b\bigr)_{il}\,\bigl(C_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)_{lj}\Bigr)x_j
&&\bigl(\because\ \blkref{def_real_matrix_product}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\Bigl(\sum_{l=1}^{d}\bigl((W_{\mathbb{R}})^b\bigr)_{il}\sum_{m=1}^{d}(C_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\Bigr)x_j
&&\bigl(\because\ \blkref{def_real_matrix_product}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\sum_{l=1}^{d}\sum_{m=1}^{d}x_i\,\bigl((W_{\mathbb{R}})^b\bigr)_{il}\,(C_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\,x_j
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\sum_{i=1}^{d}\sum_{j=1}^{d}x_i\,\bigl((W_{\mathbb{R}})^b\bigr)_{il}\,(C_{\mathbb{R}})_{lm}\,\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\,x_j
&&\bigl(\because\ \mathbb{R}\ \text{の有限和の順序の交換}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}x_i\,\bigl((W_{\mathbb{R}})^b\bigr)_{il}\Bigr)(C_{\mathbb{R}})_{lm}\Bigl(\sum_{j=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の交換則・結合則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}x_i\,\bigl((W_{\mathbb{R}})^b\bigr)_{li}\Bigr)(C_{\mathbb{R}})_{lm}\Bigl(\sum_{j=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \text{【冪の対称性】の}\ ((W_{\mathbb{R}})^b)_{il} = ((W_{\mathbb{R}})^b)_{li}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}\Bigl(\sum_{i=1}^{d}\bigl((W_{\mathbb{R}})^b\bigr)_{li}\,x_i\Bigr)(C_{\mathbb{R}})_{lm}\Bigl(\sum_{j=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{mj}\,x_j\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則}\bigr)\\
&=\sum_{l=1}^{d}\sum_{m=1}^{d}u^{(b)}_l\,(C_{\mathbb{R}})_{lm}\,u^{(a)}_m
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ の成分】を}\ a\ \text{と}\ b\ \text{へ同時に適用}\bigr)\\
&=\bigl(u^{(b)}\bigr)^\top C_{\mathbb{R}}\,u^{(a)}
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`I_{\mathbb{R}}`),
        " と ",
        math(String.raw`W_{\mathbb{R}}`),
        " の正値性】",
        math(String.raw`y \in \mathbb{R}^d`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
y^\top I_{\mathbb{R}}y
&=\sum_{k=1}^{d}\sum_{l=1}^{d}y_k\,(I_{\mathbb{R}})_{kl}\,y_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{d}y_k\,(I_{\mathbb{R}})_{kk}\,y_k
&&\bigl(\because\ l \neq k\ \text{の項は}\ (I_{\mathbb{R}})_{kl} = 0\ \text{（}\blkref{def_real_identity_matrix}\text{）なので}\ 0\bigr)\\
&=\sum_{k=1}^{d}y_k\,y_k
&&\bigl(\because\ (I_{\mathbb{R}})_{kk} = 1\ \text{（}\blkref{def_real_identity_matrix}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、各項 ",
        math(String.raw`y_ky_k`),
        " は ",
        math(String.raw`0`),
        " 以上なので ",
        math(String.raw`y^\top I_{\mathbb{R}}y \geq 0`),
        "、",
        math(String.raw`y \neq 0`),
        " なら ",
        math(String.raw`y_{k_0} \neq 0`),
        " となる ",
        math(String.raw`k_0`),
        " の項が正なので ",
        math(String.raw`y^\top I_{\mathbb{R}}y > 0`),
        " である。また ",
        ref("W_real_is_positive_definite"),
        "（",
        math(String.raw`x \to y`),
        "）より ",
        math(String.raw`y \neq 0`),
        " なら ",
        math(String.raw`y^\top W_{\mathbb{R}}y > 0`),
        "、",
        ref("W_real_is_positive_semidefinite"),
        "（",
        math(String.raw`u \to y`),
        "）よりすべての ",
        math(String.raw`y`),
        " について ",
        math(String.raw`y^\top W_{\mathbb{R}}y \geq 0`),
        " である。さらに、すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(I_{\mathbb{R}})_{kl}
&=\begin{cases} 1 & (k = l) \\ 0 & (k \neq l) \end{cases}
&&\bigl(\because\ \blkref{def_real_identity_matrix}\bigr)\\
&=\begin{cases} 1 & (l = k) \\ 0 & (l \neq k) \end{cases}
&&\bigl(\because\ \text{場合分けの条件は}\ k = l\ \text{と}\ l = k\ \text{で同じ}\bigr)\\
&=(I_{\mathbb{R}})_{lk}
&&\bigl(\because\ \blkref{def_real_identity_matrix}\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`I_{\mathbb{R}}`),
        " は ",
        ref("def_real_symmetric_matrix"),
        " の意味で対称であり、",
        math(String.raw`W_{\mathbb{R}}`),
        " も ",
        ref("W_real_is_symmetric"),
        " より対称である。上の評価と合わせて、",
        math(String.raw`I_{\mathbb{R}}`),
        " と ",
        math(String.raw`W_{\mathbb{R}}`),
        " はともに ",
        ref("psd_cauchy_schwarz"),
        " の前提（対称かつ半正定値）を満たす。",
      ]),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^ax`),
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
        ref("sqrt_of_real_zero_is_zero"),
        "）。",
        math(String.raw`a`),
        " についての帰納法で ",
        math(String.raw`u^{(a)} \neq 0`),
        " を示す。",
        math(String.raw`a = 0`),
        " では、",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
u^{(0)}_l
&=\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^0\bigr)_{lm}\,x_m
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ の成分】}\ (a \to 0)\bigr)\\
&=\sum_{m=1}^{d}(I_{\mathbb{R}})_{lm}\,x_m
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{R})\bigr)\\
&=(I_{\mathbb{R}})_{ll}\,x_l
&&\bigl(\because\ m \neq l\ \text{の項は}\ (I_{\mathbb{R}})_{lm} = 0\ \text{（}\blkref{def_real_identity_matrix}\text{）なので}\ 0\bigr)\\
&=x_l
&&\bigl(\because\ (I_{\mathbb{R}})_{ll} = 1\ \text{（}\blkref{def_real_identity_matrix}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`u^{(0)} = x \neq 0`),
        " である。",
        math(String.raw`u^{(a)} \neq 0`),
        " とする。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
(W_{\mathbb{R}})^{a+1}
&=(W^{a+1})_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to a+1)\bigr)\\
&=(W^{a+0+1})_{\mathbb{R}}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+1 = a+0+1\bigr)\\
&=\bigl(W^0(WW^a)\bigr)_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の分け方】の}\ \mathrm{Mat}(d,\mathbb{C})\ \text{の二つ目の鎖}\ (b \to 0)\bigr)\\
&=\bigl(I(WW^a)\bigr)_{\mathbb{R}}
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{C})\bigr)\\
&=(WW^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\bigr)\\
&=W_{\mathbb{R}}\,(W^a)_{\mathbb{R}}
&&\bigl(\because\ \blkref{real_matrix_of_real_entry_matrix_preserves_product}\ (m, n, p \to d,\ A \to W,\ B \to W^a)\bigr)\\
&=W_{\mathbb{R}}\,(W_{\mathbb{R}})^a
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to a)\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
u^{(a+1)}_l
&=\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^{a+1}\bigr)_{lm}\,x_m
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ の成分】}\ (a \to a+1)\bigr)\\
&=\sum_{m=1}^{d}\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)_{lm}\,x_m
&&\bigl(\because\ \text{上の式変形}\bigr)\\
&=\sum_{m=1}^{d}\Bigl(\sum_{n=1}^{d}(W_{\mathbb{R}})_{ln}\,\bigl((W_{\mathbb{R}})^a\bigr)_{nm}\Bigr)x_m
&&\bigl(\because\ \blkref{def_real_matrix_product}\bigr)\\
&=\sum_{m=1}^{d}\sum_{n=1}^{d}(W_{\mathbb{R}})_{ln}\,\bigl((W_{\mathbb{R}})^a\bigr)_{nm}\,x_m
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{n=1}^{d}\sum_{m=1}^{d}(W_{\mathbb{R}})_{ln}\,\bigl((W_{\mathbb{R}})^a\bigr)_{nm}\,x_m
&&\bigl(\because\ \mathbb{R}\ \text{の有限和の順序の交換}\bigr)\\
&=\sum_{n=1}^{d}(W_{\mathbb{R}})_{ln}\sum_{m=1}^{d}\bigl((W_{\mathbb{R}})^a\bigr)_{nm}\,x_m
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{n=1}^{d}(W_{\mathbb{R}})_{ln}\,u^{(a)}_n
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ の成分】}\bigr)\\
&=\bigl(W_{\mathbb{R}}u^{(a)}\bigr)_l
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\ (m, n \to d,\ P \to W_{\mathbb{R}},\ x \to u^{(a)})\bigr)
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`u^{(a+1)} = W_{\mathbb{R}}u^{(a)}`),
        " である。仮に ",
        math(String.raw`W_{\mathbb{R}}u^{(a)} = 0`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(u^{(a)}\bigr)^\top W_{\mathbb{R}}u^{(a)}
&=\sum_{k=1}^{d}\sum_{l=1}^{d}u^{(a)}_k\,(W_{\mathbb{R}})_{kl}\,u^{(a)}_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\sum_{l=1}^{d}(W_{\mathbb{R}})_{kl}\,u^{(a)}_l
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の結合則}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\,\bigl(W_{\mathbb{R}}u^{(a)}\bigr)_k
&&\bigl(\because\ \blkref{def_real_matrix_vector_product}\bigr)\\
&=\sum_{k=1}^{d}u^{(a)}_k\cdot 0
&&\bigl(\because\ W_{\mathbb{R}}u^{(a)} = 0\ \text{という仮定}\bigr)\\
&=0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ r \cdot 0 = 0\ \text{と}\ 0\ \text{の有限和}\bigr)
\end{aligned}`),
      paragraph([
        "となり、帰納法の仮定 ",
        math(String.raw`u^{(a)} \neq 0`),
        " と【",
        math(String.raw`I_{\mathbb{R}}`),
        " と ",
        math(String.raw`W_{\mathbb{R}}`),
        " の正値性】の ",
        math(String.raw`\bigl(u^{(a)}\bigr)^\top W_{\mathbb{R}}u^{(a)} > 0`),
        " に反する。よって ",
        math(String.raw`u^{(a+1)} = W_{\mathbb{R}}u^{(a)} \neq 0`),
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
&=x^\top (W_{\mathbb{R}})^{2a}x
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\bigr)\\
&=x^\top (W_{\mathbb{R}})^{a+a}x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a = a+a\bigr)\\
&=x^\top\Bigl((W_{\mathbb{R}})^a\bigl(I_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x
&&\bigl(\because\ \text{【冪の分け方】の一つ目}\ (b \to a)\bigr)\\
&=\bigl(u^{(a)}\bigr)^\top I_{\mathbb{R}}\,u^{(a)}
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (b \to a,\ C_{\mathbb{R}} = I_{\mathbb{R}})\bigr)\\
&>0
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ は零でない】と【}I_{\mathbb{R}}\text{ と }W_{\mathbb{R}}\text{ の正値性】}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`k = 2a+1`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{2a+1}
&=x^\top (W_{\mathbb{R}})^{2a+1}x
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\bigr)\\
&=x^\top (W_{\mathbb{R}})^{a+a+1}x
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 2a+1 = a+a+1\bigr)\\
&=x^\top\Bigl((W_{\mathbb{R}})^a\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x
&&\bigl(\because\ \text{【冪の分け方】の二つ目}\ (b \to a)\bigr)\\
&=\bigl(u^{(a)}\bigr)^\top W_{\mathbb{R}}\,u^{(a)}
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (b \to a,\ C_{\mathbb{R}} = W_{\mathbb{R}})\bigr)\\
&>0
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^ax\text{ は零でない】と【}I_{\mathbb{R}}\text{ と }W_{\mathbb{R}}\text{ の正値性】}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "【",
        math(String.raw`P = W_{\mathbb{R}}`),
        " の不等式】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b+1}\right)^2
&=\left(x^\top (W_{\mathbb{R}})^{a+b+1}x\right)^2
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\bigr)\\
&=\left(x^\top\Bigl((W_{\mathbb{R}})^b\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x\right)^2
&&\bigl(\because\ \text{【冪の分け方】の二つ目}\bigr)\\
&=\left(\bigl(u^{(b)}\bigr)^\top W_{\mathbb{R}}\,u^{(a)}\right)^2
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (C_{\mathbb{R}} = W_{\mathbb{R}})\bigr)\\
&\leq\left(\bigl(u^{(a)}\bigr)^\top W_{\mathbb{R}}\,u^{(a)}\right)\left(\bigl(u^{(b)}\bigr)^\top W_{\mathbb{R}}\,u^{(b)}\right)
&&\bigl(\because\ \blkref{psd_cauchy_schwarz}\ (n \to d,\ P \to W_{\mathbb{R}},\ x \to u^{(a)},\ y \to u^{(b)})\bigr)\\
&=\left(x^\top\Bigl((W_{\mathbb{R}})^a\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x\right)\left(x^\top\Bigl((W_{\mathbb{R}})^b\bigl(W_{\mathbb{R}}(W_{\mathbb{R}})^b\bigr)\Bigr)x\right)
&&\bigl(\because\ \text{【二つの冪で挟んだ値】を}\ (a,b) \to (a,a),\ (b,b),\ C_{\mathbb{R}} = W_{\mathbb{R}}\ \text{で両因子へ同時に適用}\bigr)\\
&=\left(x^\top (W_{\mathbb{R}})^{a+a+1}x\right)\left(x^\top (W_{\mathbb{R}})^{b+b+1}x\right)
&&\bigl(\because\ \text{【冪の分け方】の二つ目を両因子へ同時に適用}\bigr)\\
&=\left(x^\top (W_{\mathbb{R}})^{2a+1}x\right)\left(x^\top (W_{\mathbb{R}})^{2b+1}x\right)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+a+1 = 2a+1,\ b+b+1 = 2b+1\bigr)\\
&=m_{2a+1}\,m_{2b+1}
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\ \text{を両因子へ同時に適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`P = I_{\mathbb{R}}`),
        " の不等式】",
        math(String.raw`a, b \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(m_{a+b}\right)^2
&=\left(x^\top (W_{\mathbb{R}})^{a+b}x\right)^2
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\bigr)\\
&=\left(x^\top\Bigl((W_{\mathbb{R}})^b\bigl(I_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x\right)^2
&&\bigl(\because\ \text{【冪の分け方】の一つ目}\bigr)\\
&=\left(\bigl(u^{(b)}\bigr)^\top I_{\mathbb{R}}\,u^{(a)}\right)^2
&&\bigl(\because\ \text{【二つの冪で挟んだ値】}\ (C_{\mathbb{R}} = I_{\mathbb{R}})\bigr)\\
&\leq\left(\bigl(u^{(a)}\bigr)^\top I_{\mathbb{R}}\,u^{(a)}\right)\left(\bigl(u^{(b)}\bigr)^\top I_{\mathbb{R}}\,u^{(b)}\right)
&&\bigl(\because\ \blkref{psd_cauchy_schwarz}\ (n \to d,\ P \to I_{\mathbb{R}},\ x \to u^{(a)},\ y \to u^{(b)})\bigr)\\
&=\left(x^\top\Bigl((W_{\mathbb{R}})^a\bigl(I_{\mathbb{R}}(W_{\mathbb{R}})^a\bigr)\Bigr)x\right)\left(x^\top\Bigl((W_{\mathbb{R}})^b\bigl(I_{\mathbb{R}}(W_{\mathbb{R}})^b\bigr)\Bigr)x\right)
&&\bigl(\because\ \text{【二つの冪で挟んだ値】を}\ (a,b) \to (a,a),\ (b,b),\ C_{\mathbb{R}} = I_{\mathbb{R}}\ \text{で両因子へ同時に適用}\bigr)\\
&=\left(x^\top (W_{\mathbb{R}})^{a+a}x\right)\left(x^\top (W_{\mathbb{R}})^{b+b}x\right)
&&\bigl(\because\ \text{【冪の分け方】の一つ目を両因子へ同時に適用}\bigr)\\
&=\left(x^\top (W_{\mathbb{R}})^{2a}x\right)\left(x^\top (W_{\mathbb{R}})^{2b}x\right)
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ a+a = 2a,\ b+b = 2b\bigr)\\
&=m_{2a}\,m_{2b}
&&\bigl(\because\ m_k := x^\top (W_{\mathbb{R}})^kx\ \text{を両因子へ同時に適用}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`P = I_{\mathbb{R}}`),
        " の不等式】と【",
        math(String.raw`P = W_{\mathbb{R}}`),
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
&&(\because\ \text{【}P = I_{\mathbb{R}}\text{ の不等式】})\\
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
&&(\because\ \text{【}P = W_{\mathbb{R}}\text{ の不等式】})\\
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
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【(W_ℝ)^a x は零でない】の √0 = 0 の根拠（definition_of_sqrt_r_positive の 0 ≥ 0, 0^2 = 0）を sqrt_of_real_zero_is_zero の参照にした（値は不変）。",
        "2026-09-05 の分割で、トレースの挟み込みから独立した主張として切り出した。式変形と根拠は分割前と同じである。",
        "2026-11-05: SageMath の検算（sagemath/check/moment_log_convexity/）を付けるにあたり、根拠の欠けを直した（主張の不等式は不変。主張文に m_k の読み方を足した）。(1) 旧い鎖は (W^bx)^⊤W(W^ax) と x^⊤W^{a+b+1}x の等号を「冪の指数法則と (W^b)^⊤ = W^b」としていたが、行列の積の転置の主張は本文に無い。【二つの冪で挟んだ値】x^⊤(W^b(BW^a))x = (W^bx)^⊤B(W^ax)（B = I, W）を def_real_bilinear_value・mat_mult・W^b の成分の対称性で示し、二つの不等式の鎖をこれで書いた。P = I の鎖はユークリッドノルムを経ずに (u^{(a)})^⊤Iu^{(a)} で閉じた。(2)「冪の指数法則」を matrix_power_exponent_law の行に、「W は実対称」を power_of_real_symmetric_complex_matrix_is_real_symmetric の【冪の実対称性】にした。(3) 正値性の「W が可逆なので W^ax ≠ 0」は、可逆から核の自明性を導く主張が本文に無い。W の正定値性から Wu ≠ 0（u ≠ 0）を示し、a の帰納法で W^ax ≠ 0 とした。m_{2a}・m_{2a+1} > 0 を【二つの冪で挟んだ値】の鎖にした。I と W が psd_cauchy_schwarz の前提（def_real_symmetric_matrix の対称と半正定値）を満たすことを鎖で示した。積の行列 W^b(BW^a) の成分が実数であることを product_of_real_entry_matrices_has_real_entries で示して def_real_bilinear_value で読んだ。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 主張と証明は W の冪の成分を「def_rayleigh_sup が W を読むのと同じく実数として読む」としてから def_real_bilinear_value（実数の行列を取る）に当てていた。主張を def_W_real の W_ℝ で m_k := x^⊤(W_ℝ)^kx と述べ直し、証明の冪をすべて (W_ℝ)^p、単位行列を I_ℝ（def_real_identity_matrix）にした。trace_power_upper_bound と同じく【冪の実数の行列】（real_matrix_of_real_entry_matrix_preserves_power。I_ℝ = ϱ(I) もここから出した）と【冪の対称性】（W^p の実対称性から ϱ を通す 6 行の鎖と単射性）を置き、【冪の分け方】は Mat(d,ℂ) の二つの鎖を ϱ で運ぶ 5 行の鎖（real_matrix_of_real_entry_matrix_preserves_product）にした。成分の積は def_real_matrix_product、(W_ℝ)^ax は def_real_matrix_vector_product で開いた（旧い版は mat_mult の成分の式で読んでいた）。u^(a+1) = W_ℝu^(a) は、(W_ℝ)^{a+1} = W_ℝ(W_ℝ)^a を ϱ で運ぶ 7 行の鎖と成分の 8 行の鎖にした（実数の行列とベクトルの積の結合則の主張が本文に無いため、mat_mult_associative の行を成分の計算に替えた）。W_ℝ の対称性・正定値性・半正定値性は W_real_is_symmetric・W_real_is_positive_definite・W_real_is_positive_semidefinite を引いた。主張の不等式は不変である。下流の trace_power_sandwich はまだこの主張を旧い形（m_k := x^⊤W^kx、w^⊤W^nw > 0）で引いており、主張と食い違っている（状態台帳の (r3b2e2) で W_ℝ の形に書き直す）。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ d := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。値と手順は変えていない。",
      ],
    },
  },
  {
    id: "maxeig_008_claim_trace_power_sandwich",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 10 },
    title: { tex: String.raw`c(M_{\mathrm{col}})^{n} \leq \sum_{k} ((W_{\mathbb{R}})^{n})_{kk} \leq 2^{M_{\mathrm{col}}} c(M_{\mathrm{col}})^{n}` },
    labels: ["trace_power_sandwich"],
    statement: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）と略記し、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列、",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        ref("def_rayleigh_sup"),
        " の数とする。",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{n} \ \leq\ \sum_{k=1}^{d} \bigl((W_{\mathbb{R}})^{n}\bigr)_{kk}\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{n}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`(W_{\mathbb{R}})^{n}`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪、和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和、",
        math(String.raw`\mathbb{R}`),
        " の元の冪は ",
        ref("def_power_of_real_number"),
        " の冪である。右辺の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " の ",
        ref("def_power_of_real_number"),
        " の冪 ",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
        " の略記で、",
        math(String.raw`\mathbb{Z}`),
        " の元 ",
        math(String.raw`d`),
        " とは別の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`\mathcal{R} := \{x^\top W_{\mathbb{R}}x \mid x \in \mathbb{R}^d,\ \|x\| = 1\} \subseteq \mathbb{R}_{>0}`),
        "（いずれも ",
        ref("def_rayleigh_sup"),
        "）、",
        math(String.raw`T := \sum_{k=1}^{d}\bigl((W_{\mathbb{R}})^{n}\bigr)_{kk} \in \mathbb{R}`),
        " と略記する。",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " は ",
        ref("def_symmetrized_transfer_matrix"),
        " の行列で、",
        ref("def_W_real"),
        " より ",
        math(String.raw`W \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        "（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の記号）、",
        math(String.raw`W_{\mathbb{R}} = \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)`),
        " である。",
        math(String.raw`B \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " について ",
        math(String.raw`B_{\mathbb{R}} := \varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(B)`),
        " と書く（",
        ref("def_real_matrix_of_real_entry_matrix"),
        " の略記）。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
        math(String.raw`I := I_{\mathrm{Mat}(d,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        "）、",
        math(String.raw`I_{\mathbb{R}} := I_{\mathrm{Mat}(d,\mathbb{R})}`),
        "（",
        ref("def_real_identity_matrix"),
        "）と書く。",
        math(String.raw`W^p`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{C}`),
        " の冪で積は ",
        ref("mat_mult"),
        "、",
        math(String.raw`(W_{\mathbb{R}})^p`),
        " は同じ (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪で積は ",
        ref("def_real_matrix_product"),
        " のものである。上からの評価 ",
        math(String.raw`T \leq 2^{M_{\mathrm{col}}}c^n`),
        " は ",
        ref("trace_power_upper_bound"),
        " なので、以下で下からの評価 ",
        math(String.raw`c^n \leq T`),
        " を示す。",
      ]),
      paragraph([
        "【冪の実数の行列】",
        ref("real_matrix_of_real_entry_matrix_preserves_power"),
        "（",
        math(String.raw`n \to d,\ A \to W,\ q \to p`),
        "）より、すべての ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`W^p \in \mathrm{Mat}^{\mathrm{re}}(d,d,\mathbb{C})`),
        " であり、",
      ]),
      displayMath(String.raw`(W^p)_{\mathbb{R}} = (W_{\mathbb{R}})^p`),
      paragraph(["である。とくに"]),
      displayMath(String.raw`\begin{aligned}
(W_{\mathbb{R}})^1
&=(W^1)_{\mathbb{R}}
&&\bigl(\because\ \text{【冪の実数の行列】}\ (p \to 1)\bigr)\\
&=(W^{0+1})_{\mathbb{R}}
&&\bigl(\because\ \mathbb{Z}\ \text{で}\ 1 = 0+1\bigr)\\
&=(W^0W)_{\mathbb{R}}
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^mA\ (K = \mathbb{C},\ m = 0)\bigr)\\
&=(IW)_{\mathbb{R}}
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{C})\bigr)\\
&=\varrho^{d,d}_{\mathbb{C}\to\mathbb{R}}(W)
&&\bigl(\because\ \blkref{identity_matrix_is_left_unit_of_mat_mult}\ \text{の}\ IW = W\bigr)\\
&=W_{\mathbb{R}}
&&\bigl(\because\ \blkref{def_W_real}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^n`),
        " の成分の対称性】",
        math(String.raw`W`),
        " は実対称なので（",
        ref("W_is_real_symmetric_positive_definite"),
        "）、",
        math(String.raw`W^n`),
        " は実対称（",
        ref("def_real_symmetric_complex_matrix"),
        "）であり（",
        ref("power_of_real_symmetric_complex_matrix_is_real_symmetric"),
        "、",
        math(String.raw`n \to d,\ A \to W`),
        "、指数 ",
        math(String.raw`n`),
        "）、とくに ",
        math(String.raw`(W^n)^\top = W^n`),
        "（転置は ",
        ref("def_matrix_transpose"),
        "）である。すべての ",
        math(String.raw`k, l \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\bigl((W_{\mathbb{R}})^n\bigr)_{lk}\Bigr)_{\mathbb{C}}
&=\Bigl(\bigl((W^n)_{\mathbb{R}}\bigr)_{lk}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^n)_{\mathbb{R}} = (W_{\mathbb{R}})^n\ (p \to n)\bigr)\\
&=(W^n)_{lk}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^n)\bigr)\\
&=\bigl((W^n)^\top\bigr)_{kl}
&&\bigl(\because\ \blkref{def_matrix_transpose}\bigr)\\
&=(W^n)_{kl}
&&\bigl(\because\ (W^n)^\top = W^n\bigr)\\
&=\Bigl(\bigl((W^n)_{\mathbb{R}}\bigr)_{kl}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_real_matrix_of_real_entry_matrix}\ (m, n \to d,\ B \to W^n)\bigr)\\
&=\Bigl(\bigl((W_{\mathbb{R}})^n\bigr)_{kl}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W^n)_{\mathbb{R}} = (W_{\mathbb{R}})^n\ (p \to n)\bigr)
\end{aligned}`),
      paragraph([
        "なので、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to ((W_{\mathbb{R}})^n)_{lk},\ b \to ((W_{\mathbb{R}})^n)_{kl}`),
        "）より ",
        math(String.raw`((W_{\mathbb{R}})^n)_{lk} = ((W_{\mathbb{R}})^n)_{kl}`),
        " である。",
      ]),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^n`),
        " の半正定値性】",
        math(String.raw`z \in \mathbb{R}^d`),
        " について ",
        math(String.raw`z^\top (W_{\mathbb{R}})^nz \geq 0`),
        " を示す。",
        math(String.raw`z = 0`),
        " なら ",
        ref("def_real_bilinear_value"),
        " の和の各項が ",
        math(String.raw`0\cdot((W_{\mathbb{R}})^n)_{ij}\cdot 0 = 0`),
        " なので ",
        math(String.raw`z^\top (W_{\mathbb{R}})^nz = 0`),
        " である。",
        math(String.raw`z \neq 0`),
        " なら ",
        math(String.raw`z_{j_0} \neq 0`),
        " となる ",
        math(String.raw`j_0`),
        " がある。",
        math(String.raw`j \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
|z_j|^2
&=|z_j|\,|z_j|
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to |z_j|)\bigr)\\
&\geq 0
&&\bigl(\because\ \blkref{def_real_absolute_value}\ (q \to z_j)\ \text{の}\ |q| \geq 0\ \text{と、}\mathbb{R}\ \text{の順序で非負の数の積は非負}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`z_{j_0} \neq 0`),
        " なので ",
        math(String.raw`\mathbb{R}`),
        " の順序で ",
        math(String.raw`z_{j_0} > 0`),
        " か ",
        math(String.raw`z_{j_0} < 0`),
        " であり、前者なら ",
        math(String.raw`z_{j_0} \geq 0`),
        " なので ",
        math(String.raw`|z_{j_0}| = z_{j_0} > 0`),
        "、後者なら ",
        math(String.raw`|z_{j_0}| = -z_{j_0} > 0`),
        "（",
        ref("def_real_absolute_value"),
        "（",
        math(String.raw`q \to z_{j_0}`),
        "））なので、",
        math(String.raw`|z_{j_0}| > 0`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\|z\|^2
&=\sum_{j=1}^{d}|z_j|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&\geq |z_{j_0}|^2
&&\bigl(\because\ \blkref{finite_sum_of_nonnegative_reals_is_at_least_each_term}\ (a_j \to |z_j|^2,\ k \to j_0)\ \text{。各項が非負なのは上の}\ |z_j|^2 \geq 0\bigr)\\
&=|z_{j_0}|\,|z_{j_0}|
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to |z_{j_0}|)\bigr)\\
&>0
&&\bigl(\because\ \text{上の}\ |z_{j_0}| > 0\ \text{と、}\mathbb{R}\ \text{の順序で正の数の積は正}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\|z\| = 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\|z\|^2
&=0^2
&&\bigl(\because\ \|z\| = 0\ \text{を代入}\bigr)\\
&=0\cdot 0
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to 0)\bigr)\\
&=0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ 0\cdot x = 0\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 0\bigr)
\end{aligned}`),
      paragraph([
        "となり、上の ",
        math(String.raw`\|z\|^2 > 0`),
        " に反する。よって ",
        math(String.raw`\|z\| \neq 0`),
        " であり、",
        math(String.raw`\|z\| \geq 0`),
        "（",
        ref("def_matrix_norm"),
        "）と合わせて ",
        math(String.raw`\|z\| > 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序で ",
        math(String.raw`x \geq 0`),
        " かつ ",
        math(String.raw`x \neq 0`),
        " なら ",
        math(String.raw`x > 0`),
        "、",
        math(String.raw`x \to \|z\|`),
        "）である。",
        math(String.raw`w \in \mathbb{R}^d`),
        " を ",
        math(String.raw`w_i := \|z\|^{-1}z_i`),
        " で定めると、",
        math(String.raw`i \in \{1,\dots,d\}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
z_i
&=1\,z_i
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\bigr)\\
&=\bigl(\|z\|\,\|z\|^{-1}\bigr)z_i
&&\bigl(\because\ \|z\| \neq 0\ \text{なので}\ \|z\|\,\|z\|^{-1} = 1\bigr)\\
&=\|z\|\bigl(\|z\|^{-1}z_i\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合則}\bigr)\\
&=\|z\|\,w_i
&&\bigl(\because\ w_i := \|z\|^{-1}z_i\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
\|w\|
&=\sqrt{\sum_{i=1}^{d}|w_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{def_matrix_norm}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl|\|z\|^{-1}z_i\bigr|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ w_i := \|z\|^{-1}z_i\ \text{を各項へ同時に代入}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}z_i\bigr)^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_absolute_value}\ (q \to \|z\|^{-1}z_i)\ \text{の}\ |q|^2 = q^2\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}z_i\bigr)\bigl(\|z\|^{-1}z_i\bigr)}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \|z\|^{-1}z_i)\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}\|z\|^{-1}\bigr)(z_iz_i)}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則を各項へ同時に適用}\bigr)\\
&=\sqrt{\sum_{i=1}^{d}\bigl(\|z\|^{-1}\bigr)^2z_i^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \|z\|^{-1},\ z_i)\ \text{を右辺から左辺へ、各項へ同時に適用}\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\sum_{i=1}^{d}z_i^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to (\|z\|^{-1})^2)\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\sum_{i=1}^{d}|z_i|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_absolute_value}\ \text{の}\ |q|^2 = q^2\ \text{を各項へ同時に適用}\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\bigr)^2\|z\|^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \text{上の}\ \|z\|^2 = \sum_{j}|z_j|^2\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\|z\|^{-1}\bigr)\bigl(\|z\|\,\|z\|\bigr)}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \|z\|^{-1},\ \|z\|)\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\|z\|\bigr)\bigl(\|z\|^{-1}\|z\|\bigr)}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則}\bigr)\\
&=\sqrt{\bigl(\|z\|^{-1}\|z\|\bigr)^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \|z\|^{-1}\|z\|)\ \text{を右辺から左辺へ}\bigr)\\
&=\sqrt{1^2}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \|z\| \neq 0\ \text{なので}\ \|z\|^{-1}\|z\| = 1\bigr)\\
&=\sqrt{1}^{\,(\mathbb{R}_{\ge 0})}
&&\bigl(\because\ \blkref{power_of_real_one_is_one}\ (m \to 2)\bigr)\\
&=1
&&\bigl(\because\ \blkref{sqrt_of_real_one_is_one}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        ref("moment_log_convexity"),
        " の正値性を単位ベクトル ",
        math(String.raw`x \to w`),
        " と ",
        math(String.raw`k \to n`),
        " で適用すると ",
        math(String.raw`w^\top (W_{\mathbb{R}})^nw > 0`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
z^\top (W_{\mathbb{R}})^nz
&=\sum_{i=1}^{d}\sum_{j=1}^{d}z_i\,((W_{\mathbb{R}})^n)_{ij}\,z_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\bigl(\|z\|\,w_i\bigr)((W_{\mathbb{R}})^n)_{ij}\bigl(\|z\|\,w_j\bigr)
&&\bigl(\because\ z_i = \|z\|\,w_i\ \text{を各項へ同時に適用}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\bigl(\|z\|\,\|z\|\bigr)\bigl(w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則・結合則を各項へ同時に適用}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\|z\|^2\bigl(w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j\bigr)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to \|z\|)\ \text{を右辺から左辺へ、各項へ同時に適用}\bigr)\\
&=\sum_{i=1}^{d}\|z\|^2\sum_{j=1}^{d}w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to \|z\|^2,\ x_j \to w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j)\ \text{を各}\ i\ \text{の内側の和へ同時に適用}\bigr)\\
&=\|z\|^2\sum_{i=1}^{d}\sum_{j=1}^{d}w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j
&&\bigl(\because\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to \|z\|^2,\ x_i \to \sum_{j=1}^{d}w_i\,((W_{\mathbb{R}})^n)_{ij}\,w_j)\ \text{を外側の和へ適用}\bigr)\\
&=\|z\|^2\,\bigl(w^\top (W_{\mathbb{R}})^nw\bigr)
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&>0
&&\bigl(\because\ \text{上の}\ \|z\|^2 > 0\ \text{と}\ w^\top (W_{\mathbb{R}})^nw > 0\ \text{で、}\mathbb{R}\ \text{の順序で正の数の積は正}\bigr)
\end{aligned}`),
      paragraph([
        "である。いずれの場合も ",
        math(String.raw`z^\top (W_{\mathbb{R}})^nz \geq 0`),
        " である。",
      ]),
      paragraph([
        "【",
        math(String.raw`(W_{\mathbb{R}})^n`),
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
&\leq v^\top (W_{\mathbb{R}})^nv
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^n\text{ の半正定値性】}\ (z \to v)\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}v_i\,((W_{\mathbb{R}})^n)_{ij}\,v_j
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{i=1}^{d}\sum_{j=1}^{d}\bigl(x_l(e_k)_i - x_k(e_l)_i\bigr)((W_{\mathbb{R}})^n)_{ij}\bigl(x_l(e_k)_j - x_k(e_l)_j\bigr)
&&\bigl(\because\ v\ \text{の定義}\bigr)\\
&=(x_lx_l)\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i((W_{\mathbb{R}})^n)_{ij}(e_k)_j
 - x_lx_k\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i((W_{\mathbb{R}})^n)_{ij}(e_l)_j\\
&\qquad - x_kx_l\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i((W_{\mathbb{R}})^n)_{ij}(e_k)_j
 + (x_kx_k)\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i((W_{\mathbb{R}})^n)_{ij}(e_l)_j
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と乗法の交換則・結合則、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を内側と外側の和へ適用}\bigr)\\
&=x_l^2\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i((W_{\mathbb{R}})^n)_{ij}(e_k)_j
 - x_lx_k\sum_{i=1}^{d}\sum_{j=1}^{d}(e_k)_i((W_{\mathbb{R}})^n)_{ij}(e_l)_j\\
&\qquad - x_kx_l\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i((W_{\mathbb{R}})^n)_{ij}(e_k)_j
 + x_k^2\sum_{i=1}^{d}\sum_{j=1}^{d}(e_l)_i((W_{\mathbb{R}})^n)_{ij}(e_l)_j
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to x_l,\ x_k)\ \text{を右辺から左辺へ}\bigr)\\
&=x_l^2\,((W_{\mathbb{R}})^n)_{kk} - x_lx_k\,((W_{\mathbb{R}})^n)_{kl} - x_kx_l\,((W_{\mathbb{R}})^n)_{lk} + x_k^2\,((W_{\mathbb{R}})^n)_{ll}
&&\bigl(\because\ (e_q)_i\ \text{は}\ i = q\ \text{でだけ}\ 1\ \text{でほかは}\ 0\ \text{なので、各二重和で}\ 0\ \text{でない項は一つだけ}\bigr)\\
&=x_l^2\,((W_{\mathbb{R}})^n)_{kk} - x_lx_k\,((W_{\mathbb{R}})^n)_{kl} - x_kx_l\,((W_{\mathbb{R}})^n)_{kl} + x_k^2\,((W_{\mathbb{R}})^n)_{ll}
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^n\text{ の成分の対称性】の}\ ((W_{\mathbb{R}})^n)_{lk} = ((W_{\mathbb{R}})^n)_{kl}\bigr)\\
&=x_l^2\,((W_{\mathbb{R}})^n)_{kk} - 2\,x_k\,((W_{\mathbb{R}})^n)_{kl}\,x_l + x_k^2\,((W_{\mathbb{R}})^n)_{ll}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と同類項の加法}\bigr)
\end{aligned}`),
      paragraph(["であり、移項して"]),
      displayMath(String.raw`2\,x_k\,((W_{\mathbb{R}})^n)_{kl}\,x_l \ \leq\ x_l^2\,((W_{\mathbb{R}})^n)_{kk} + x_k^2\,((W_{\mathbb{R}})^n)_{ll}`),
      paragraph(["である。"]),
      paragraph([
        "【単位ベクトルでの評価】",
        math(String.raw`x \in \mathbb{R}^d`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とし、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`m_k := x^\top (W_{\mathbb{R}})^kx`),
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
&&\bigl(\because\ x_k \in \mathbb{R}\ \text{なので}\ \blkref{square_of_real_absolute_value}\ \text{の}\ |q|^2 = q^2\ (q \to x_k)\bigr)\\
&=\|x\|^2
&&\bigl(\because\ \blkref{def_matrix_norm}\ \text{と}\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ \bigl(\sqrt{b}\bigr)^2 = b\bigr)\\
&=1^2
&&\bigl(\because\ \|x\| = 1\bigr)\\
&=1
&&\bigl(\because\ \blkref{power_of_real_one_is_one}\ (m \to 2)\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
m_0
&=x^\top (W_{\mathbb{R}})^0x
&&\bigl(\because\ m_0 := x^\top (W_{\mathbb{R}})^0x\bigr)\\
&=x^\top I_{\mathbb{R}}x
&&\bigl(\because\ \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I\ (K = \mathbb{R}\text{、}I = I_{\mathbb{R}}\ \text{は}\ \blkref{def_real_identity_matrix})\bigr)\\
&=\sum_{k=1}^{d}\sum_{l=1}^{d}x_k\,(I_{\mathbb{R}})_{kl}\,x_l
&&\bigl(\because\ \blkref{def_real_bilinear_value}\bigr)\\
&=\sum_{k=1}^{d}x_k\,(I_{\mathbb{R}})_{kk}\,x_k
&&\bigl(\because\ l \neq k\ \text{の項は}\ (I_{\mathbb{R}})_{kl} = 0\ \text{（}\blkref{def_real_identity_matrix}\text{）なので}\ 0\bigr)\\
&=\sum_{k=1}^{d}x_kx_k
&&\bigl(\because\ (I_{\mathbb{R}})_{kk} = 1\ \text{（}\blkref{def_real_identity_matrix}\text{）}\bigr)\\
&=\sum_{k=1}^{d}x_k^2
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to x_k)\ \text{を右辺から左辺へ、各項へ同時に適用}\bigr)\\
&=1
&&\bigl(\because\ \text{上の式変形}\bigr)
\end{aligned}`),
      paragraph(["であり、"]),
      displayMath(String.raw`\begin{aligned}
m_1
&=x^\top (W_{\mathbb{R}})^1x
&&\bigl(\because\ m_1 := x^\top (W_{\mathbb{R}})^1x\bigr)\\
&=x^\top W_{\mathbb{R}}x
&&\bigl(\because\ \text{【冪の実数の行列】の}\ (W_{\mathbb{R}})^1 = W_{\mathbb{R}}\bigr)
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
&=\frac{m_km_k}{m_{k-1}}
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to m_k)\bigr)\\
&=m_k\,\frac{m_k}{m_{k-1}}
&&\bigl(\because\ \text{乗法の結合則}\bigr)\\
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
        "（",
        ref("def_power_of_real_number"),
        " で ",
        math(String.raw`m_1^{\,0} = 1`),
        "）である。",
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
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と}\ \blkref{def_power_of_real_number}\ \text{で}\ m_1^{\,p+1} = m_1^{\,p}m_1\bigr)
\end{aligned}`),
      paragraph([
        "である。最後に、【",
        math(String.raw`(W_{\mathbb{R}})^n`),
        " の成分の評価】をすべての ",
        math(String.raw`k, l`),
        " に当てて",
      ]),
      displayMath(String.raw`\begin{aligned}
m_n
&=\sum_{k=1}^{d}\sum_{l=1}^{d}x_k\,((W_{\mathbb{R}})^n)_{kl}\,x_l
&&\bigl(\because\ m_n := x^\top (W_{\mathbb{R}})^nx\ \text{と}\ \blkref{def_real_bilinear_value}\bigr)\\
&=2^{-1}\sum_{k=1}^{d}\sum_{l=1}^{d}2\,x_k\,((W_{\mathbb{R}})^n)_{kl}\,x_l
&&\bigl(\because\ 2^{-1}\cdot 2 = 1\ \text{と}\ \blkref{finite_sum_of_real_scalar_multiples}\ (c \to 2^{-1})\ \text{を内側と外側の和へ適用}\bigr)\\
&\leq 2^{-1}\sum_{k=1}^{d}\sum_{l=1}^{d}\bigl(x_l^2\,((W_{\mathbb{R}})^n)_{kk} + x_k^2\,((W_{\mathbb{R}})^n)_{ll}\bigr)
&&\bigl(\because\ \text{【}(W_{\mathbb{R}})^n\text{ の成分の評価】を}\ k, l \in \{1,\dots,d\}\ \text{の組}\ (k,l)\ \text{ごとの項へ同時に適用し、項ごとの不等式の有限和と}\ 2^{-1} > 0\ \text{倍は順序を保つ}\bigr)\\
&=2^{-1}\Bigl(\sum_{k=1}^{d}\sum_{l=1}^{d}x_l^2\,((W_{\mathbb{R}})^n)_{kk} + \sum_{k=1}^{d}\sum_{l=1}^{d}x_k^2\,((W_{\mathbb{R}})^n)_{ll}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の有限和の加法の交換則・結合則}\bigr)\\
&=2^{-1}\Bigl(\sum_{k=1}^{d}((W_{\mathbb{R}})^n)_{kk}\sum_{l=1}^{d}x_l^2 + \sum_{k=1}^{d}x_k^2\sum_{l=1}^{d}((W_{\mathbb{R}})^n)_{ll}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を内側の和へ適用}\bigr)\\
&=2^{-1}\Bigl(\Bigl(\sum_{k=1}^{d}((W_{\mathbb{R}})^n)_{kk}\Bigr)\Bigl(\sum_{l=1}^{d}x_l^2\Bigr) + \Bigl(\sum_{k=1}^{d}x_k^2\Bigr)\Bigl(\sum_{l=1}^{d}((W_{\mathbb{R}})^n)_{ll}\Bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換則と、}\blkref{finite_sum_of_real_scalar_multiples}\ \text{を外側の和へ適用}\bigr)\\
&=2^{-1}\bigl(T\cdot 1 + 1\cdot T\bigr)
&&\bigl(\because\ T := \textstyle\sum_{k}((W_{\mathbb{R}})^n)_{kk}\ \text{と、上の}\ \textstyle\sum_{k}x_k^2 = 1\bigr)\\
&=T
&&\bigl(\because\ \mathbb{R}\ \text{の四則}\bigr)
\end{aligned}`),
      paragraph(["である。以上を合わせると、単位ベクトル ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\begin{aligned}
\bigl(x^\top W_{\mathbb{R}}x\bigr)^n
&=m_1^{\,n}
&&\bigl(\because\ \text{上の}\ m_1 = x^\top W_{\mathbb{R}}x\bigr)\\
&\leq m_n
&&\bigl(\because\ \text{上の}\ m_p \geq m_1^{\,p}\ (p \to n)\bigr)\\
&\leq T
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
        "（",
        ref("def_power_of_real_number"),
        "）なので (a) は ",
        math(String.raw`0 < r < s`),
        "、(b) は ",
        math(String.raw`s - r = 1\cdot s^0(s - r)`),
        "（",
        ref("def_power_of_real_number"),
        " で ",
        math(String.raw`s^0 = 1`),
        "）である。",
        math(String.raw`p`),
        " で (a)(b) が成り立つとすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
r^{p+1}
&=r^pr
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{で}\ r^{p+1} = r^pr\bigr)\\
&<s^pr
&&\bigl(\because\ \text{(a) の}\ r^p < s^p\ \text{と}\ r > 0\bigr)\\
&<s^ps
&&\bigl(\because\ r < s\ \text{と、(a) から}\ s^p > r^p > 0\bigr)\\
&=s^{p+1}
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{で}\ s^{p+1} = s^ps\bigr)
\end{aligned}`),
      paragraph([
        "かつ ",
        math(String.raw`r^{p+1} = r^pr > 0`),
        "（",
        ref("def_power_of_real_number"),
        "、",
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
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{で}\ s^{p+1} = s^ps,\ r^{p+1} = r^pr\ \text{と}\ \mathbb{R}\ \text{の分配則・乗法の交換則（}-sr^p + r^ps = 0\text{）}\bigr)\\
&\leq s\bigl(p\,s^{p-1}(s - r)\bigr) + r^p(s - r)
&&\bigl(\because\ \text{(b) と}\ s > 0\bigr)\\
&\leq s\bigl(p\,s^{p-1}(s - r)\bigr) + s^p(s - r)
&&\bigl(\because\ \text{(a) の}\ r^p < s^p\ \text{と}\ s - r > 0\bigr)\\
&=p\,s^p(s - r) + s^p(s - r)
&&\bigl(\because\ s\,s^{p-1} = s^{p-1}s = s^p\ \text{（乗法の交換則と、}\blkref{def_power_of_real_number}\ \text{で}\ s^{(p-1)+1} = s^{p-1}s\ \text{、}\mathbb{Z}\ \text{で}\ (p-1)+1 = p\text{）と乗法の結合則}\bigr)\\
&=(p+1)\,s^{(p+1)-1}(s - r)
&&\bigl(\because\ \mathbb{R}\ \text{の分配則と}\ \mathbb{Z}\ \text{で}\ p = (p+1)-1\bigr)
\end{aligned}`),
      paragraph(["なので (b) が ", math(String.raw`p+1`), " で成り立つ。"]),
      paragraph([
        "【上限への移行】",
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
        "（",
        ref("def_power_of_real_number"),
        "）、",
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
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{で}\ c^{(n-1)+1} = c^{n-1}c\ \text{と}\ \mathbb{Z}\ \text{で}\ n = (n-1)+1\bigr)\\
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
        math(String.raw`t := x^\top W_{\mathbb{R}}x > r`),
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
&&\bigl(\because\ \text{【単位ベクトルでの評価】の}\ \bigl(x^\top W_{\mathbb{R}}x\bigr)^n \leq T\bigr)\\
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
        math(String.raw`c^n \leq T`),
        " である。上からの評価 ",
        ref("trace_power_upper_bound"),
        " の ",
        math(String.raw`T \leq 2^{M_{\mathrm{col}}}c^n`),
        " と合わせて主張を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【(W_ℝ)^n の半正定値性】の ‖w‖ の鎖の最後の行 √1 = 1 を sqrt_of_real_one_is_one の参照にした（値は不変）。",
        "この証明はスペクトル定理（実対称行列の対角化可能性）を使っていない。c(M) は上限として定義され、上からの評価は rayleigh_bounds_operator_norm、下からの評価はモーメント列の対数凸性による。対角化可能性は正しいが本文にまだ無く、挟み撃ちには不要である。",
        "2026-08-14 の式変形統一で、Step 2 の対数凸性を任意の k へ移す奇数・偶数の場合分けを、それぞれ四段の一続きの不等式鎖へ開き、各行末に根拠を置いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、Step 3 冒頭の比の単調性（三段）と望遠鏡積からの下からの評価（四段）を、それぞれ一続きの根拠付きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、半正定値行列の二次形式をトレースで上から評価する計算を、成分表示・二つの Cauchy--Schwarz・有限和の分配則を行末根拠にした八段の一続きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、トレース評価の A = W^n への適用（三段）と、単位ベクトル上の上限を取って c^n ≤ tr(W^n) を得る圧縮（三段）を、それぞれ行末根拠付きの鎖へ開いた。内容は変えていない。",
        "2026-08-14 の式変形統一で、モーメントの対数凸性に使う P = W 版の Cauchy--Schwarz の一行圧縮を、定義・冪の指数法則・実対称性・不等式・定義への復帰の五段へ開いた。内容は変えていない。",
        "2026-11-05: SageMath の検算（sagemath/check/trace_power_sandwich/）を付けるにあたり、根拠の欠けを直した（主張は不変）。(1) 「…」で書いた望遠鏡積と「単調非減少を j−1 回適用」を、m_k ≥ m_1m_{k−1}（k の帰納法）と m_p ≥ m_1^p（p の帰納法）の鎖にし、m_0 = 1・m_1 = x^⊤Wx を def_exp (1)・def_real_bilinear_value・def_matrix_norm の鎖で示した。m_k は moment_log_convexity の置き方で読むと書いた。(2) 半正定値行列の二次形式をトレースで抑える八段の鎖は、実数の絶対値・有限和の三角不等式・平方根の積の法則という本文にラベルの無い道具と psd_cauchy_schwarz の二回の適用を使っていた。W^n の半正定値性を v_i := x_l(e_k)_i − x_k(e_l)_i に当てた 2x_k(W^n)_{kl}x_l ≤ x_l^2(W^n)_{kk} + x_k^2(W^n)_{ll} を足し合わせる鎖に替え、絶対値と平方根を使わない形にした。旧い鎖は誤りではないが、より初等的に書けるのでこちらを採った（README の新しい道具を導入するときの判断基準）。(3) 「W^n は正定値」の散文を、z = 0 と z ≠ 0 に分け、z ≠ 0 では w := ‖z‖^{-1}z が単位ベクトルであることを示して moment_log_convexity の正値性を当てる鎖にした。(4) 「t ↦ t^n は単調増加なので上限と可換」は t^n の連続性を暗に使っていた。正の実数の冪の比較 0 < r^p < s^p・s^p − r^p ≤ p s^{p−1}(s − r)（p の帰納法）を示し、c^n > tr(W^n) を仮定して δ := (c^n − T)(nc^{n−1})^{−1}、r := c − δ が R の上界でないことから矛盾を導く背理法にした。極限・連続性を使わず、上限の性質は最小の上界であることだけを使う。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 旧い主張 c^n ≤ tr(W^n) ≤ 2^{M_col}c^n は ℂ の元 tr(W^n) に順序を使っており、証明は W^n の成分を「def_rayleigh_sup が W を読むのと同じく実数として読む」としてから def_real_bilinear_value（実数の行列を取る）に当てていた。上流の trace_power_upper_bound・moment_log_convexity は既に def_W_real の W_ℝ で述べ直されており、この証明は旧い形（tr(W^n) ≤ …、m_k := x^⊤W^kx）で引いて食い違っていた。主張を T := Σ_k ((W_ℝ)^n)_kk について c^n ≤ T ≤ 2^{M_col}c^n と述べ直し（tr(W^n) = (T)_ℂ は trace_of_W_power_via_W_real が述べる）、証明の冪をすべて (W_ℝ)^n にした。【冪の実数の行列】（real_matrix_of_real_entry_matrix_preserves_power）を置き、(W_ℝ)^1 = W_ℝ を ϱ で運ぶ 5 行の鎖（実数の行列の左単位の主張が本文に無いため、Mat(d,ℂ) の identity_matrix_is_left_unit_of_mat_mult を ϱ の中で使う）にした。成分の対称性は W^n の実対称性から ϱ を通す 6 行の鎖と inclusion_rr_to_cc_is_injective にした。m_0 = 1 は I_ℝ（def_real_identity_matrix）で読んだ。上からの評価は trace_power_upper_bound をそのまま引く。値は変えていない。下流の partition_function_sandwich はまだ Z = tr(W^{N_row}) に旧い形で当てている（状態台帳の (r3b2e3) で trace_of_W_power_via_W_real を引く形に書き直す）。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 正の実数の冪を名前だけの根拠「冪の定義」で引いていた 7 行と、実数の冪の定義を根拠なしに使っていた箇所（m_1^0 = 1、r^1 = r^0r = r と s^1 = s、s^0 = 1、r^{p+1} = r^pr、c^0 = 1、m_k^2 = m_km_k、|z_{j_0}|^2 > 0、0^2 = 0、(st)^2 = s^2t^2、(‖z‖^{-1})^2‖z‖^2 = (‖z‖^{-1}‖z‖)^2、1^2 = 1 の 2 か所、‖z‖‖z‖ = ‖z‖^2）を def_power_of_real_number の参照にし、各行で定義を当てた等式を書き添えた。主張の段落が t^0 := 1, t^{p+1} := t^pt と冪を定義し直していたのを def_power_of_real_number の参照にした。|t|^2 = t^2 の 3 か所を square_of_real_absolute_value の参照にした。s^{p+1} − r^{p+1} の行の根拠に乗法の交換則を足した。値と手順は変えていない。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【(W_ℝ)^n の半正定値性】の z ≠ 0 の段で、|z_{j_0}|^2 > 0 の行が |z_{j_0}| > 0・square_of_real_number_is_product・正の数の積は正の 3 つを 1 行で使っていたので、|z_{j_0}|^2 = |z_{j_0}||z_{j_0}| の行と > 0 の行に割り、|z_{j_0}| > 0 を def_real_absolute_value の場合分けで示した。finite_sum_of_nonnegative_reals_is_at_least_each_term が要る各項の非負性 |z_j|^2 ≥ 0 に根拠が無かったので、square_of_real_number_is_product と def_real_absolute_value の |q| ≥ 0 の 2 行の鎖を置いた。z^⊤(W_ℝ)^nz の鎖の 3 行目（交換則・結合則・square_of_real_number_is_product・finite_sum_of_real_scalar_multiples を 1 行で使っていた）を 4 行に割り（5 行 → 8 行）、最後の行の w^⊤(W_ℝ)^nw > 0 を鎖の前に出した。z_i = ‖z‖w_i を 4 行の鎖にし（‖z‖‖z‖^{-1} = 1・結合則・単位元に根拠が無かった）、‖w‖ の鎖の 2 行目（代入と square_of_real_absolute_value）を 2 行に割った（14 行 → 15 行）。値と主張は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ d := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。主張の右辺の 2^{M_col} は 2_ℝ := 1_ℝ + 1_ℝ の def_power_of_real_number の冪 2_ℝ^{M_col} の略記で、ℤ の元 d とは別の元であることを主張の文に書いた（trace_power_upper_bound と同じ書き方）。値と手順は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 上からの評価の鎖の根拠の文「d^2 個の項へ同時に適用」の d^2 は、d ∈ ℤ なので def_power_of_integer の冪としか読めないが、項の数は論証に使わないので数を書かず、「k, l ∈ {1,…,d} の組 (k,l) ごとの項へ同時に適用」とした。値と手順は変えていない。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 二乗と積の行き来を def_power_of_real_number の冪をその場で開く書き方（x^2 = (x^0x)x = xx、t^2 = tt）から square_of_real_number_is_product を引く行に替え、1^2 = 1 を power_of_real_one_is_one（m → 2）から引いた。1 行に複数の事実をまとめていた行を割った: ‖w‖ の鎖の (‖z‖^{-1}z_i)^2 の行を積へ開く・並べ替える・冪へ戻すの 3 行に、(‖z‖^{-1})^2‖z‖^2 の行を同じく 3 行に、√1 の行を ‖z‖^{-1}‖z‖ = 1 の行と 1^2 = 1 の行に（9 行 → 14 行）、Σx_k^2 の鎖の最後の行を ‖x‖ = 1 の行と 1^2 = 1 の行に（3 行 → 4 行）、m_{k+1} の鎖の m_k^2/m_{k-1} = m_k(m_k/m_{k-1}) を square_of_real_number_is_product の行と結合則の行に（5 行 → 6 行）、【(W_ℝ)^n の成分の評価】の展開の行を、x_lx_l・x_kx_k の積で展開する行と square_of_real_number_is_product で冪へ戻す行に（7 行 → 8 行）。‖z‖ = 0 の場合の ‖z‖^2 = 0^2 = 0 を 0^2 = 0·0 = 0 にし、√1 = 1 の行の 1^2 = 1 を power_of_real_one_is_one から引いた。値と主張は変えていない。",
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 【(W_ℝ)^n の半正定値性】の z ≠ 0 の段で、‖z‖ ≠ 0 の背理（‖z‖ = 0 なら ‖z‖^2 = 0^2 = 0·0 = 0 を文の中の鎖と括弧 1 つの根拠で書いていた）を、‖z‖ = 0 の代入・square_of_real_number_is_product（r → 0）・ℝ で 0·x = 0（x → 0）の 3 行の鎖に開き、‖z‖^2 > 0 との矛盾と ‖z‖ ≥ 0 から ‖z‖ > 0（ℝ の順序で x ≥ 0 かつ x ≠ 0 なら x > 0 の根拠を添えた）を続く文に置いた。値と主張は変えていない。",
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
        " について、",
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(K_1,K_2) \in \mathbb{R}_{>0}`),
        "（行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " のもの）と ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        " は",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}} \ \leq\ Z(K_1,K_2)\ \leq\ 2^{M_{\mathrm{col}}}\,c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`,
      ),
      paragraph([
        "を満たす。三つの量はいずれも ",
        math(String.raw`\mathbb{R}`),
        " の元で、不等号は ",
        math(String.raw`\mathbb{R}`),
        " の順序である。冪 ",
        math(String.raw`c(M_{\mathrm{col}})^{N_{\mathrm{row}}}`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪である。",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " の ",
        ref("def_power_of_real_number"),
        " の冪 ",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
        " の略記で、",
        ref("def_power_of_integer"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の元 ",
        math(String.raw`2_{\mathbb{Z}}^{\,M_{\mathrm{col}}}`),
        "（証明の ",
        math(String.raw`d`),
        "）とは別の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）",
        "、",
        math(String.raw`W \in \mathrm{Mat}(d,\mathbb{C})`),
        " を ",
        ref("def_symmetrized_transfer_matrix"),
        " の行列、",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        " を ",
        ref("def_W_real"),
        " の行列とし、",
        math(String.raw`c := c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`T := \sum_{k=1}^{d}\bigl((W_{\mathbb{R}})^{N_{\mathrm{row}}}\bigr)_{kk} \in \mathbb{R}`),
        "（",
        math(String.raw`(W_{\mathbb{R}})^{N_{\mathrm{row}}}`),
        " は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`K = \mathbb{R}`),
        " の冪、和は ",
        ref("def_finite_sum_of_real_numbers"),
        " の有限和）と略記する。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
      paragraph(["準備（", math(String.raw`Z(K_1,K_2) = T`), "）。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(Z(K_1,K_2)\bigr)_{\mathbb{C}}
&=\mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)
  &&\bigl(\because\ \blkref{Z_equals_trace_of_W}\ \text{の「とくに」}\bigr)\\
&=T_{\mathbb{C}}
  &&\bigl(\because\ \blkref{trace_of_W_power_via_W_real}\ (q \to N_{\mathrm{row}})\bigr)
\end{aligned}`),
      paragraph([
        "であるから、",
        ref("inclusion_rr_to_cc_is_injective"),
        "（",
        math(String.raw`a \to Z(K_1,K_2),\ b \to T`),
        "）より ",
        math(String.raw`Z(K_1,K_2) = T`),
        " である。これを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
Z(K_1,K_2)
&=T
  &&\bigl(\because\ \text{準備}\bigr)\\
&\geq c^{N_{\mathrm{row}}}
  &&\bigl(\because\ \blkref{trace_power_sandwich}\ (n \to N_{\mathrm{row}})\ \text{の左の不等式}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Z(K_1,K_2)
&=T
  &&\bigl(\because\ \text{準備}\bigr)\\
&\leq 2^{M_{\mathrm{col}}}\,c^{N_{\mathrm{row}}}
  &&\bigl(\because\ \blkref{trace_power_sandwich}\ (n \to N_{\mathrm{row}})\ \text{の右の不等式}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の式変形統一で、一文にまとめていた二段の適用を、下からの評価と上からの評価の二つの鎖へ開いた。内容と根拠は変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 旧い証明は Z(K_1,K_2) = tr(W^{N_row}) と書き、trace_power_sandwich の旧い主張 c^n ≤ tr(W^n) ≤ 2^{M_col}c^n（ℂ の元に順序を使っていた）を当てていた。trace_power_sandwich は T := Σ_k ((W_ℝ)^n)_kk ∈ ℝ について述べ直されたので、(Z(K_1,K_2))_ℂ = tr(W^{N_row}) = T_ℂ（Z_equals_trace_of_W の「とくに」と trace_of_W_power_via_W_real）と inclusion_rr_to_cc_is_injective で Z(K_1,K_2) = T を示し、T に新しい主張を当てる形にした。主張に Z(K_1,K_2)・c(M_col) の帰属と、不等号が ℝ の順序であることを書いた。値は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 主張の段落が冪を「trace_power_sandwich がその場で定める t^0 := 1, t^{p+1} := t^pt と同じもの」と書いていたが、trace_power_sandwich は冪を定め直さず def_power_of_real_number を引く形に改められたので、この括弧を除いた。冪の帰属を ℝ_{>0} と書いていたが、def_power_of_real_number が与えるのは ℝ の元であることだけで、正であることはこのブロックで使わないので ℝ にした。値と手順は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさ d := 2^{M_col} を def_power_of_integer の ℤ の冪 2_ℤ^{M_col} と書き、d ∈ ℤ_{≥1} を power_of_two_in_integers_is_at_least_one で示した（同じ記号 2^{M_col} を ℤ の元と ℝ の元に使い回さないため）。主張の 2^{M_col} ∈ ℝ が 2_ℝ^{M_col} の略記で、証明に出る ℤ の元 d とは別の元であることを主張の文に書いた。上からの評価の鎖の 2^{M_col}c^{N_row} は trace_power_sandwich の右の不等式の右辺そのもので、d を ℝ の元として使う行は無いので、inclusion_zz_to_rr_of_power_of_two を通す行は要らない。値と手順は変えていない。",
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
        " 脱出）。左辺の分母の ",
        math(String.raw`M_{\mathrm{col}}\,N_{\mathrm{row}}`),
        " は ",
        ref("inclusion_zz_to_rr"),
        " の ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}`),
        " で送った ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}}) \in \mathbb{R}`),
        " の、右辺の ",
        math(String.raw`M_{\mathrm{col}}`),
        " は ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}}) \in \mathbb{R}`),
        " の略記である（証明では略さずに書く）。",
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
        " である。",
        math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
        " を以下 ",
        math(String.raw`2`),
        "、その ",
        ref("def_power_of_real_number"),
        " の冪 ",
        math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
        " を以下 ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " と略記する（",
        ref("def_power_of_integer"),
        " の ",
        math(String.raw`\mathbb{Z}`),
        " の元 ",
        math(String.raw`2_{\mathbb{Z}}^{\,M_{\mathrm{col}}}`),
        " とは別の元で、",
        ref("partition_function_sandwich"),
        " の右辺の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " と同じ元）。冪 ",
        math(String.raw`c^{N_{\mathrm{row}}}`),
        "、",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪で、",
        ref("real_log_of_power"),
        " を ",
        math(String.raw`a=c,\ n=N_{\mathrm{row}}`),
        " と ",
        math(String.raw`a=2,\ n=M_{\mathrm{col}}`),
        " で引くと ",
        math(String.raw`\mathbb{R}_{>0}`),
        " に住む。",
        ref("real_log_of_product"),
        " を ",
        math(String.raw`a=2^{M_{\mathrm{col}}},\ b=c^{N_{\mathrm{row}}}`),
        " で引くと ",
        math(String.raw`2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}} \in \mathbb{R}_{>0}`),
        " である。したがって ",
        math(String.raw`c^{N_{\mathrm{row}}}`),
        "、",
        math(String.raw`Z`),
        "、",
        math(String.raw`2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}}`),
        " の ",
        math(String.raw`\log`),
        " が定まる。",
        ref("inclusion_zz_to_rr_of_positive_is_at_least_one"),
        " を ",
        math(String.raw`n=M_{\mathrm{col}}`),
        " と ",
        math(String.raw`n=N_{\mathrm{row}}`),
        " で引くと ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}}) \geq 1 > 0`),
        "、",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}}) \geq 1 > 0`),
        " であり、",
        ref("real_log_of_product"),
        " を ",
        math(String.raw`a=\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}}),\ b=\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})`),
        " で引くと ",
        math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}}) \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&c^{N_{\mathrm{row}}} \leq Z \leq 2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}}
&&\left(\because\ \blkref{partition_function_sandwich}\right)\\
\Longrightarrow\ &\log(c^{N_{\mathrm{row}}}) \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ u \leq v\text{ は }u<v\text{ か }u=v\text{。前者は }\blkref{real_log_strictly_increasing}\text{、後者は写像 }\log\text{ の値が一つに定まること}\right)\\
\Longrightarrow\ &\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}}c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=c,\ n=N_{\mathrm{row}}\text{ で}\right)\\
\Longrightarrow\ &\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c \leq \log Z \leq \log(2^{M_{\mathrm{col}}})+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_product}\text{ を }a=2^{M_{\mathrm{col}}},\ b=c^{N_{\mathrm{row}}}\text{ で}\right)\\
\Longrightarrow\ &\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c \leq \log Z \leq \iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\log 2+\log(c^{N_{\mathrm{row}}})
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=2,\ n=M_{\mathrm{col}}\text{ で}\right)\\
\Longrightarrow\ &\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c \leq \log Z \leq \iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\log 2+\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c
&&\left(\because\ \blkref{real_log_of_power}\text{ を }a=c,\ n=N_{\mathrm{row}}\text{ で}\right)\\
\Longrightarrow\ &\frac{\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})} \leq \frac{\log Z}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})} \leq \frac{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\log 2+\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\,\log c}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}
&&\left(\because\ \text{各辺を }\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\in\mathbb{R}_{>0}\text{ で割る。正の数で割っても不等号は保たれる}\right)\\
\Longrightarrow\ &\frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c \leq \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}\log Z \leq \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c + \frac{\log 2}{\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}
&&\left(\because\ \mathbb{R}\text{ の四則。分子と分母の共通の因子 }\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\text{、}\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\text{ を約す}\right)\\
\Longrightarrow\ &0 \leq \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}\log Z - \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c \leq \frac{\log 2}{\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}
&&\left(\because\ \text{各辺から }\tfrac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c\text{ を引く。引いても不等号は保たれる}\right)\\
\Longrightarrow\ &\left|\frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}\log Z - \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c\right| \leq \frac{\log 2}{\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}
&&\left(\because\ \blkref{def_real_absolute_value}\text{ の }q\geq 0\text{ の場合を、前の行の }0\leq\tfrac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}\log Z-\tfrac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c\text{ に}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`a_{N_{\mathrm{row}}} := \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}\log Z(K_1,K_2) \in \mathbb{R}`),
        "、",
        math(String.raw`a := \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c \in \mathbb{R}`),
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
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\log 2}{\varepsilon}
&> 0
&&\left(\because\ \text{準備の }\log 2 > 0\text{ と }\varepsilon > 0\text{。正の数を正の数で割る}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\mathbb{R}`),
        " のアルキメデス性（任意の ",
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        math(String.raw`t < \iota_{\mathbb{Z}\to\mathbb{R}}(m)`),
        " となる ",
        math(String.raw`m \in \mathbb{Z}`),
        " がある）を ",
        math(String.raw`t = \frac{\log 2}{\varepsilon}`),
        " に使い、",
        math(String.raw`\frac{\log 2}{\varepsilon} < \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)`),
        " となる ",
        math(String.raw`N_0 \in \mathbb{Z}`),
        " を取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&0 < \frac{\log 2}{\varepsilon} < \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)
&&\left(\because\ \text{上の行と }N_0\text{ の取り方}\right)\\
\Longrightarrow\ &0 < \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)
&&\left(\because\ \text{不等号の推移律}\right)\\
\Longrightarrow\ &N_0 > 0
&&\left(\because\ \blkref{inclusion_zz_to_rr_of_nonpositive_is_nonpositive}\text{ の対偶を }n=N_0\text{ に}\right)\\
\Longrightarrow\ &N_0 \geq 1
&&\left(\because\ N_0 \in \mathbb{Z}\text{。}0\text{ と }1\text{ の間に整数は無い}\right),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\log 2
&= \frac{\log 2}{\varepsilon}\,\varepsilon
&&\left(\because\ \mathbb{R}\text{ の四則。}\varepsilon \neq 0\text{ を約す}\right)\\
&< \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)\,\varepsilon
&&\left(\because\ \frac{\log 2}{\varepsilon} < \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)\text{ の両辺に }\varepsilon > 0\text{ を掛ける}\right).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq N_0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|a_{N_{\mathrm{row}}} - a\right|
&\leq \frac{\log 2}{\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})}
&&\left(\because\ \text{上の含意の鎖の最後の行}\right)\\
&\leq \frac{\log 2}{\iota_{\mathbb{Z}\to\mathbb{R}}(N_0)}
&&\left(\because\ \text{準備の }\log 2 > 0\text{ かつ }0 < \iota_{\mathbb{Z}\to\mathbb{R}}(N_0) \leq \iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}})\text{。後者は }\blkref{inclusion_zz_to_rr_is_monotone_on_nonnegatives}\text{ を }1 \leq N_0 \leq N_{\mathrm{row}}\text{ に}\right)\\
&< \varepsilon
&&\left(\because\ \iota_{\mathbb{Z}\to\mathbb{R}}(N_0)\,\varepsilon > \log 2\text{ の両辺を }\iota_{\mathbb{Z}\to\mathbb{R}}(N_0) > 0\text{ で割る}\right).
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
        math(String.raw`a = \frac{1}{\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})}\log c(M_{\mathrm{col}})`),
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
        "2026-11-07: 証明の冒頭で、c^{N_row}・2^{M_col} が正であることの根拠を def_power_of_real_number（ℝ の元であることしか与えない）から real_log_of_power の a^n ∈ ℝ_{>0} に替え、2^{M_col}c^{N_row} が正であることに real_log_of_product の ab ∈ ℝ_{>0} を引いた（Lean の具体版 abs_log_Z_sub_log_c_le の冒頭と 1 対 1 にした）。値・手順は不変。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 含意の鎖の最後の行の根拠「非負の実数の絶対値はそれ自身」を def_real_absolute_value の q ≥ 0 の場合への参照にした。「ℝ のアルキメデス性より N_0ε > log 2 となる N_0 ∈ ℤ_{≥1} を取る」を、アルキメデス性の述べ方（任意の t ∈ ℝ に t < m となる m ∈ ℤ がある）と適用先 t = log 2/ε の文と、log 2/ε > 0・0 < N_0・N_0 ≥ 1・N_0ε > log 2 の表示式の鎖にした（アルキメデス性は ℝ の性質で、本文に引ける主張は無い）。正の数で割る・共通の因子を約す・引く・u ≤ v の場合分けの行は、高校教科書レベルの四則と順序の操作なので名前のまま残した。値と手順は変えていない。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: ℤ の元 M_col・N_row・N_0 を ℝ の式に入れる箇所と ℝ の元と比べる箇所を、inclusion_zz_to_rr の ι_{ℤ→ℝ} を通して書いた（証明の書き方の「同一視をしない」）。real_log_of_power の右辺が ι(n) log a になったのに合わせ、ι(M_col), ι(N_row) ∈ ℝ_{>0} を新しい主張 inclusion_zz_to_rr_of_positive_is_at_least_one で、アルキメデス性で取る N_0 ∈ ℤ について 0 < ι(N_0) から N_0 > 0 を inclusion_zz_to_rr_of_nonpositive_is_nonpositive の対偶で、ι(N_0) ≤ ι(N_row) を inclusion_zz_to_rr_is_monotone_on_nonnegatives で引いた。主張の M_col N_row は ι(M_col)ι(N_row) の略記と書いた。値・手順は不変。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 証明の準備で 2^{M_col} を def_power_of_real_number の冪とだけ書き、底の 2 がどの集合の元かを書いていなかった。2_ℝ := 1_ℝ +_ℝ 1_ℝ とその冪 2_ℝ^{M_col} ∈ ℝ を置き、以下 2・2^{M_col} と略記すること、def_power_of_integer の ℤ の元 2_ℤ^{M_col} とは別の元で partition_function_sandwich の右辺と同じ元であることを書いた（証明に出る 2^{M_col} の 9 か所と log 2・a=2 はこの略記で読む）。値と手順は変えていない。",
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
        "、",
        math(String.raw`d := 2_{\mathbb{Z}}^{\,M_{\mathrm{col}}} \in \mathbb{Z}_{\geq 1}`),
        "（",
        ref("def_power_of_integer"),
        " の冪。",
        ref("power_of_two_in_integers_is_at_least_one"),
        " より ",
        math(String.raw`\mathbb{Z}_{\geq 1}`),
        " の元）とする。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W = V_1^{1/2}\,V_2\,V_1^{1/2} \in \mathrm{Mat}(d,\mathbb{C})`),
        "（成分はすべて実数。",
        ref("W_is_real_symmetric_positive_definite"),
        "。成分が ",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_exp"),
        " の行列の指数関数の値であるため。指数評価による脱出）、その成分を実数として並べた ",
        ref("def_W_real"),
        " の ",
        math(String.raw`W_{\mathbb{R}} \in \mathrm{Mat}(d,\mathbb{R})`),
        "、",
        ref("def_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c(M_{\mathrm{col}}) = \sup\left\{\, x^\top W_{\mathbb{R}} x \ \middle|\ x \in \mathbb{R}^{d},\ \|x\| = 1 \,\right\} \in \mathbb{R}_{>0}`,
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
          "（不等号は ",
          math(String.raw`\mathbb{R}`),
          " の順序。",
          math(String.raw`2^{M_{\mathrm{col}}}`),
          " は ",
          math(String.raw`2_{\mathbb{R}} := 1_{\mathbb{R}} +_{\mathbb{R}} 1_{\mathbb{R}}`),
          " の ",
          ref("def_power_of_real_number"),
          " の冪 ",
          math(String.raw`2_{\mathbb{R}}^{\,M_{\mathrm{col}}} \in \mathbb{R}`),
          " の略記で、",
          math(String.raw`\mathbb{Z}`),
          " の元 ",
          math(String.raw`d`),
          " とは別の元である）",
        ],
        [
          math(String.raw`\text{(2)}\quad \lim_{N_{\mathrm{row}} \to \infty}\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2) = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`),
          "（",
          math(String.raw`\log`),
          " は正の実数上の実対数で、値は ",
          math(String.raw`\mathbb{R}`),
          " に住む。実対数と極限による脱出。左辺の分母の ",
          math(String.raw`M_{\mathrm{col}}\,N_{\mathrm{row}}`),
          " は ",
          ref("inclusion_zz_to_rr"),
          " の ",
          math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}})\,\iota_{\mathbb{Z}\to\mathbb{R}}(N_{\mathrm{row}}) \in \mathbb{R}`),
          " の、右辺の ",
          math(String.raw`M_{\mathrm{col}}`),
          " は ",
          math(String.raw`\iota_{\mathbb{Z}\to\mathbb{R}}(M_{\mathrm{col}}) \in \mathbb{R}`),
          " の略記で、",
          ref("limit_of_log_Z_in_N_row"),
          " と同じ）",
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: c(M_col) の式を、def_rayleigh_sup の定義どおり W_ℝ（def_W_real）の二次形式 x^⊤W_ℝx の上限に直した（旧い式は複素行列 W に実ベクトルを掛けていた）。",
        "2026-11-07（Lean の通しの証明のゴールラインの確認）: 行列の大きさとベクトルの次元に使っていた添字なしの 2^{M_col}（Mat(2^{M_col},ℂ)・Mat(2^{M_col},ℝ)・ℝ^{2^{M_col}} の 3 か所）を、d := 2_ℤ^{M_col}（def_power_of_integer の ℤ の冪、power_of_two_in_integers_is_at_least_one より ℤ_{≥1} の元）と置いて d にした。(1) の 2^{M_col} が ℝ の元 2_ℝ^{M_col}（def_power_of_real_number）の略記で d とは別の元であること（partition_function_sandwich と同じ断り）と、(2) の M_col N_row・M_col が inclusion_zz_to_rr の ι で送った ℝ の元の略記であること（limit_of_log_Z_in_N_row と同じ断り）を書いた。値は変えていない。",
      ],
    },
  },
]);
