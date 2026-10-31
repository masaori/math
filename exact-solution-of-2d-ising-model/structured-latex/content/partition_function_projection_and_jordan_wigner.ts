import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「分配関数」の章「ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示」。章立て（`tools/chapter-plan.ts`）でこの章に
 * 割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_projection_and_jordan_wigner",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`\varepsilon \text{ の固有値 } +1 \text{ の固有空間への射影と Jordan–Wigner 表示}` },
    labels: [],
  },
  {
    id: "transfer_matrix_000c_definition_jordan_wigner_Z_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { text: "Jordan–Wigner 行列族 Z_m" },
    labels: ["def_jordan_wigner_Z_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いる。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して、Jordan--Wigner 行列 ",
        math(String.raw`Z_m`),
        " を",
      ]),
      displayMath(
        String.raw`Z_m:=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`m=1`),
        " では左側の積を空積とし、",
        math(String.raw`Z_1:=\sigma_1^z`),
        " とする。また周期端では ",
        math(String.raw`Z_{M_{\mathrm{col}}+1}:=Z_1`),
        " と定める。ホロノミック量子場では ",
        math(String.raw`Z_m`),
        " を ",
        math(String.raw`p_m`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、Jordan--Wigner 行列族 Z_m と周期端の規約だけを一つの定義として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000d_definition_jordan_wigner_Y_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "Jordan–Wigner 行列族 Y_m" },
    labels: ["def_jordan_wigner_Y_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いる。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して、Jordan--Wigner 行列 ",
        math(String.raw`Y_m`),
        " を",
      ]),
      displayMath(
        String.raw`Y_m:=\sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`m=1`),
        " では左側の積を空積とし、",
        math(String.raw`Y_1:=\sigma_1^y`),
        " とする。また周期端では ",
        math(String.raw`Y_{M_{\mathrm{col}}+1}:=Y_1`),
        " と定める。ホロノミック量子場では ",
        math(String.raw`Y_m`),
        " を ",
        math(String.raw`q_m`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、Jordan--Wigner 行列族 Y_m と周期端の規約だけを一つの定義として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000e_definition_global_spin_flip_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 6 },
    title: { text: "全スピン反転行列" },
    labels: ["def_global_spin_flip_matrix"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族を用いて、全スピン反転行列を",
      ]),
      displayMath(
        String.raw`\varepsilon:=\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}}^x\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。積はサイト番号の昇順に取る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、全スピン反転行列の定義だけを分離した。Jordan--Wigner 行列による表示は <global_spin_flip_jordan_wigner_representation> へ分離し、そこから本定義を明示参照している。旧ラベルからの後続参照は、残した複合定義が新しい表示主張を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_000f_claim_global_spin_flip_jordan_wigner_representation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 7 },
    title: { text: "全スピン反転行列の Jordan–Wigner 表示" },
    labels: ["global_spin_flip_jordan_wigner_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_1,\dots,Z_{M_{\mathrm{col}}}`),
        "、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_1,\dots,Y_{M_{\mathrm{col}}}`),
        "、および ",
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " について、",
      ]),
      displayMath(
        String.raw`\varepsilon=i^{M_{\mathrm{col}}}(Z_1Y_1)(Z_2Y_2)\cdots(Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "が成り立つ。右辺は ",
        math(String.raw`Z_mY_m`),
        " の積であって、和ではない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の Pauli 行列の成分表示、",
        ref("mat_mult"),
        " の行列積、および ",
        ref("complex_numbers_form_a_field"),
        " の複素数の四則から、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sigma^z\sigma^y
&=\begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because\ \text{Pauli 行列の定義。}\blkref{pauli_matrix_products})\\
&=\begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because\ 2\times2\text{ 行列の積の定義。}\blkref{mat_mult})\\
&=-i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because\ \mathbb{C}\text{ の四則})\\
&=-i\,\sigma^x
&&(\because\ \text{Pauli 行列の定義。}\blkref{pauli_matrix_products})
\end{aligned}`),
      paragraph([
        "を得る。次に任意の ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " を固定する。まず ",
        math(String.raw`r\in\{0,1,\dots,M_{\mathrm{col}}\}`),
        " に対して ",
        math(String.raw`P_r:=\sigma_1^x\cdots\sigma_r^x\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)`),
        " と置き、",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}`),
        " とする。",
        ref("def_site_pauli_matrices"),
        " と ",
        ref("kronecker_product_rule"),
        " を用いる有限帰納法で、次の表示を示す。後で一因子の複素スカラーを外へ出すときは ",
        ref("kronecker_multilinear"),
        " の各因子についての線型性を用いる。",
      ]),
      displayMath(String.raw`P_r=
\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}
\qquad(0\leq r\leq M_{\mathrm{col}})`),
      paragraph(["を示す。初項では"]),
      displayMath(String.raw`\begin{aligned}
P_0
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ P_0\text{ の定義})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}}
&&(\because\ \text{単位因子のクロネッカー積。}\blkref{kronecker_product_rule})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0\leq r<M_{\mathrm{col}}`),
        " で帰納法の仮定が成り立つとする。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
P_{r+1}
&=P_r\sigma_{r+1}^x
&&(\because\ P_{r+1}\text{ の定義})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}\right)\sigma_{r+1}^x
&&(\because\ \text{帰納法の仮定})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{r}
\boxtimes\sigma^x\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r-1}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{r}
\boxtimes(I\sigma^x)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-r-1}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{r+1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r-1}
&&(\because\ AI=IA=A)
\end{aligned}`),
      paragraph([
        "となる。よって有限帰納法により上の ",
        math(String.raw`P_r`),
        " の表示がすべての ",
        math(String.raw`0\leq r\leq M_{\mathrm{col}}`),
        " で成り立つ。特に ",
        ref("def_jordan_wigner_Z_matrices"),
        " と ",
        ref("def_jordan_wigner_Y_matrices"),
        " から、",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_m
&=P_{m-1}\sigma_m^z
&&(\because\ Z_m\text{ の定義。}\blkref{def_jordan_wigner_Z_matrices})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)\sigma_m^z
&&(\because\ P_{m-1}\text{ の表示})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{m-1}
\boxtimes(I\sigma^z)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ AI=IA=A)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Y_m
&=P_{m-1}\sigma_m^y
&&(\because\ Y_m\text{ の定義。}\blkref{def_jordan_wigner_Y_matrices})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)\sigma_m^y
&&(\because\ P_{m-1}\text{ の表示})\\
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m+1}\right)
\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})\\
&=\overbrace{(\sigma^xI)\boxtimes\cdots\boxtimes(\sigma^xI)}^{m-1}
\boxtimes(I\sigma^y)\boxtimes\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ AI=IA=A)
\end{aligned}`),
      paragraph(["を得る。したがって"]),
      displayMath(String.raw`\begin{aligned}
Z_mY_m
&=\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^z\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
\left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\sigma^y\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{直前の }Z_m,Y_m\text{ のクロネッカー積表示})\\
&=\overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \text{クロネッカー積の積の規則。}\blkref{kronecker_product_rule})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{(II)\boxtimes\cdots\boxtimes(II)}^{M_{\mathrm{col}}-m}
&&(\because\ \sigma^x\sigma^x=I.\ \blkref{pauli_matrix_products})\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(\sigma^z\sigma^y)\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ II=I)\\
&=\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes(-i\,\sigma^x)\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because\ \text{上の }\sigma^z\sigma^y=-i\sigma^x)\\
&=-i\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\sigma^x\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}\right)
&&(\because\ \text{クロネッカー積の線型性。}\blkref{kronecker_multilinear})\\
&=-i\,\sigma_m^x
&&(\because\ \text{サイト行列の定義。}\blkref{def_site_pauli_matrices})
\end{aligned}`),
      paragraph([
        math(String.raw`m=1`),
        " では先頭の ",
        math(String.raw`m-1`),
        " 因子を空積、",
        math(String.raw`m=M_{\mathrm{col}}`),
        " では末尾の ",
        math(String.raw`M_{\mathrm{col}}-m`),
        " 因子を空積と読む。ここで ",
        math(String.raw`Q_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}`),
        "、",
        math(String.raw`Q_r:=(Z_1Y_1)\cdots(Z_rY_r)\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)`),
        " と置く。",
        math(String.raw`Q_r=(-i)^rP_r`),
        " を ",
        math(String.raw`r=0,\dots,M_{\mathrm{col}}`),
        " について有限帰納法で示す。初項は",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_0
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ Q_0\text{ の定義})\\
&=(-i)^0I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)}
&&(\because\ (-i)^0=1)\\
&=(-i)^0P_0
&&(\because\ P_0\text{ の定義})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0\leq r<M_{\mathrm{col}}`),
        " で帰納法の仮定が成り立つとすると、因子を並べ替えずに",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_{r+1}
&=Q_r(Z_{r+1}Y_{r+1})
&&(\because\ Q_{r+1}\text{ の定義})\\
&=(-i)^rP_r(Z_{r+1}Y_{r+1})
&&(\because\ \text{帰納法の仮定})\\
&=(-i)^rP_r(-i\,\sigma_{r+1}^x)
&&(\because\ Z_{r+1}Y_{r+1}=-i\sigma_{r+1}^x)\\
&=(-i)^r\bigl(P_r(-i\,\sigma_{r+1}^x)\bigr)
&&(\because\ \text{左側のスカラー倍と行列積の両立})\\
&=(-i)^r\bigl((-i)(P_r\sigma_{r+1}^x)\bigr)
&&(\because\ \text{右側のスカラー倍と行列積の両立})\\
&=\bigl((-i)^r(-i)\bigr)(P_r\sigma_{r+1}^x)
&&(\because\ \text{スカラー倍の結合律})\\
&=(-i)^{r+1}P_r\sigma_{r+1}^x
&&(\because\ \text{冪の再帰})\\
&=(-i)^{r+1}P_{r+1}
&&(\because\ P_{r+1}\text{ の定義})
\end{aligned}`),
      paragraph([
        "となる。したがって有限帰納法の終端 ",
        math(String.raw`r=M_{\mathrm{col}}`),
        " で ",
        math(String.raw`Q_{M_{\mathrm{col}}}=(-i)^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}`),
        " を得る。ゆえに",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon
&=\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}}^x
&&(\because\ \text{全スピン反転行列の定義。}\blkref{def_global_spin_flip_matrix})\\
&=P_{M_{\mathrm{col}}}
&&(\because\ P_{M_{\mathrm{col}}}\text{ の定義})\\
&=1^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ 1^{M_{\mathrm{col}}}=1)\\
&=(i(-i))^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ i(-i)=1)\\
&=i^{M_{\mathrm{col}}}(-i)^{M_{\mathrm{col}}}P_{M_{\mathrm{col}}}
&&(\because\ \mathbb{C}\text{ の乗法の可換律と冪の法則})\\
&=i^{M_{\mathrm{col}}}Q_{M_{\mathrm{col}}}
&&(\because\ \text{有限帰納法の終端})\\
&=i^{M_{\mathrm{col}}}(Z_1Y_1)(Z_2Y_2)\cdots(Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})
&&(\because\ Q_{M_{\mathrm{col}}}\text{ の定義})
\end{aligned}`),
      paragraph(["ゆえに主張が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、全スピン反転行列の Jordan--Wigner 表示だけを独立した主張として分離した。各サイトの積 Z_mY_m=-i sigma_m^x と昇順の有限積を明示し、右辺が和でないことを保持した。Lean の zyPrefixProduct_eq_neg_i_pow_smul_xString と epsilon_eq_i_pow_smul_zyPrefixProduct が本文の向きの第二の有限帰納法と終端に対応し、NecSuf.prefix_eq_pow_smul_of_local_smul が同じ手順の必要十分版を担う。SageMath は同じ各行を global_spin_flip_jordan_wigner_representation で検算する。",
      ],
    },
  },
  {
    id: "transfer_matrix_000j_claim_first_dual_coupling_relation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第一の結合定数と双対結合定数の双対関係" },
    labels: ["first_dual_coupling_relation"],
    statement: [
      paragraph([
        ref("def_first_dual_coupling_constant"),
        " の ",
        math(String.raw`K_1,K_1^*\in\mathbb{R}_{>0}`),
        " に対して、",
      ]),
      displayMath(String.raw`\sinh(2K_1)\sinh(2K_1^*)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、",
        ref("def_positive_coupling_tanh"),
        " の実数値の双曲線正接、",
        ref("def_real_logarithm_positive"),
        " の実対数、",
        ref("def_cosh_sinh"),
        " の双曲線関数の定義、および ",
        ref("cosh_sinh_basic_properties"),
        " の実双曲線関数の基本性質を用いる。まず、各分母が零でないことを確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow \cosh K_1>\sinh K_1>0
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K_1>\sinh K_1>0
&\Longrightarrow \sinh K_1\ne0\ \land\ \cosh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K_1\ne0\ \land\ \cosh K_1\ne0
&\Longrightarrow \sinh K_1\cosh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ は体である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_1<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1
&\Longrightarrow \tanh K_1\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_1\in\mathbb{R}_{>0}
&\Longrightarrow \tanh K_1\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      paragraph(["双対結合定数の定義を指数関数へ戻すと、"]),
      displayMath(String.raw`\begin{aligned}
K_1^*&=-\frac12\log(\tanh K_1)
&&\left(\because\ \blkref{def_first_dual_coupling_constant}\right)\\
2K_1^*&=-\log(\tanh K_1)
&&\left(\because\ \mathbb{R}\text{ の等式の両辺を }2\text{ 倍}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\exp\!\left(-\log(\tanh K_1)\right)\exp\!\left(\log(\tanh K_1)\right)\\
&\qquad=\exp\!\left(-\log(\tanh K_1)+\log(\tanh K_1)\right)
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&\qquad=\exp(0)
&&\left(\because\ \mathbb{R}\text{ の加法逆元}\right)\\
&\qquad=1
&&\left(\because\ \exp(0)=1\ \blkref{scalar_exp_zero}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-\log(\tanh K_1)\right)\tanh K_1
&=1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
\exp\!\left(-\log(\tanh K_1)\right)
&=\frac1{\tanh K_1}
&&\left(\because\ \tanh K_1\ne0\text{ と }\mathbb{R}\text{ の除法}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(2K_1^*)
&=\exp\!\left(-\log(\tanh K_1)\right)
&&\left(\because\ 2K_1^*=-\log(\tanh K_1)\right)\\
&=\frac{1}{\tanh K_1}
&&\left(\because\ \text{直前の等式}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-2K_1^*&=\log(\tanh K_1)
&&\left(\because\ 2K_1^*=-\log(\tanh K_1)\text{ の両辺を符号反転}\right)\\
\exp(-2K_1^*)&=\exp(\log(\tanh K_1))
&&\left(\because\ \text{等しい実数への指数関数の適用}\right)\\
&=\tanh K_1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_1^*)
&=\frac{\exp(2K_1^*)-\exp(-2K_1^*)}{2}
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac{\frac1{\tanh K_1}-\exp(-2K_1^*)}{2}
&&\left(\because\ \exp(2K_1^*)=\frac1{\tanh K_1}\right)\\
&=\frac{\frac1{\tanh K_1}-\tanh K_1}{2}
&&\left(\because\ \exp(-2K_1^*)=\tanh K_1\right)\\
&=\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ \mathbb{R}\text{ の分配法則}\right)
\end{aligned}`),
      paragraph(["一方、倍角の双曲線正弦は定義から"]),
      displayMath(String.raw`\begin{aligned}
2\sinh K_1\cosh K_1
&=2\frac{\exp(K_1)-\exp(-K_1)}2\frac{\exp(K_1)+\exp(-K_1)}2
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac12\left(\exp(K_1)-\exp(-K_1)\right)\left(\exp(K_1)+\exp(-K_1)\right)
&&\left(\because\ 2\cdot\frac12\cdot\frac12=\frac12\right)\\
&=\frac{\exp(K_1)^2-\exp(-K_1)^2}{2}
&&\left(\because\ (a-b)(a+b)=a^2-b^2\right)\\
&=\frac{\exp(2K_1)-\exp(-2K_1)}2
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&=\sinh(2K_1)
&&\left(\because\ \blkref{def_cosh_sinh}\right)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_1)\sinh(2K_1^*)
&=2\sinh K_1\cosh K_1\sinh(2K_1^*)
&&\left(\because\ \sinh(2K_1)=2\sinh K_1\cosh K_1\right)\\
&=2\sinh K_1\cosh K_1\cdot\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ \sinh(2K_1^*)=\frac12\left(\frac1{\tanh K_1}-\tanh K_1\right)\right)\\
&=\sinh K_1\cosh K_1\left(\frac1{\tanh K_1}-\tanh K_1\right)
&&\left(\because\ 2\cdot\frac12=1\right)\\
&=\sinh K_1\cosh K_1\left(\frac1{\sinh K_1/\cosh K_1}-\frac{\sinh K_1}{\cosh K_1}\right)
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)\\
&=\sinh K_1\cosh K_1\left(\frac{\cosh K_1}{\sinh K_1}-\frac{\sinh K_1}{\cosh K_1}\right)
&&\left(\because\ \sinh K_1\ne0\ \land\ \cosh K_1\ne0\right)\\
&=\sinh K_1\cosh K_1\frac{(\cosh K_1)^2-(\sinh K_1)^2}{\sinh K_1\cosh K_1}
&&\left(\because\ \mathbb{R}\text{ の分数の通分}\right)\\
&=(\cosh K_1)^2-(\sinh K_1)^2
&&\left(\because\ \sinh K_1\cosh K_1\ne0\right)\\
&=1
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (2)}\right)
\end{aligned}`),
      paragraph(["ゆえに第一の結合定数と双対結合定数の双対関係が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から第一の双対関係だけを独立した主張として分離した。第一の双対結合定数、双曲線正接、実対数、および双曲線関数の基本性質を先行入力とし、指数関数へ戻す計算から双対関係を一段ずつ示した。第二の双対結合定数、第二の双対関係、双曲線関数の略記、および残る正値性には進んでいない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000l_claim_second_dual_coupling_relation",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第二の結合定数と双対結合定数の双対関係" },
    labels: ["second_dual_coupling_relation"],
    statement: [
      paragraph([
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2,K_2^*\in\mathbb{R}_{>0}`),
        " に対して、",
      ]),
      displayMath(String.raw`\sinh(2K_2)\sinh(2K_2^*)=1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、",
        ref("def_positive_coupling_tanh"),
        " の実数値の双曲線正接、",
        ref("def_real_logarithm_positive"),
        " の実対数、",
        ref("def_cosh_sinh"),
        " の双曲線関数の定義、および ",
        ref("cosh_sinh_basic_properties"),
        " の実双曲線関数の基本性質を用いる。まず、各分母が零でないことを確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow \cosh K_2>\sinh K_2>0
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K_2>\sinh K_2>0
&\Longrightarrow \sinh K_2\ne0\ \land\ \cosh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K_2\ne0\ \land\ \cosh K_2\ne0
&\Longrightarrow \sinh K_2\cosh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ は体である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_2<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2
&\Longrightarrow \tanh K_2\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_2\in\mathbb{R}_{>0}
&\Longrightarrow \tanh K_2\ne0
&&\left(\because\ \mathbb{R}\text{ の正の元は零でない}\right)
\end{aligned}`),
      paragraph(["双対結合定数の定義を指数関数へ戻すと、"]),
      displayMath(String.raw`\begin{aligned}
K_2^*&=-\frac12\log(\tanh K_2)
&&\left(\because\ \blkref{def_second_dual_coupling_constant}\right)\\
2K_2^*&=-\log(\tanh K_2)
&&\left(\because\ \mathbb{R}\text{ の等式の両辺を }2\text{ 倍}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
&\exp\!\left(-\log(\tanh K_2)\right)\exp\!\left(\log(\tanh K_2)\right)\\
&\qquad=\exp\!\left(-\log(\tanh K_2)+\log(\tanh K_2)\right)
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&\qquad=\exp(0)
&&\left(\because\ \mathbb{R}\text{ の加法逆元}\right)\\
&\qquad=1
&&\left(\because\ \exp(0)=1\ \blkref{scalar_exp_zero}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-\log(\tanh K_2)\right)\tanh K_2
&=1
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
\exp\!\left(-\log(\tanh K_2)\right)
&=\frac1{\tanh K_2}
&&\left(\because\ \tanh K_2\ne0\text{ と }\mathbb{R}\text{ の除法}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\exp(2K_2^*)
&=\exp\!\left(-\log(\tanh K_2)\right)
&&\left(\because\ 2K_2^*=-\log(\tanh K_2)\right)\\
&=\frac{1}{\tanh K_2}
&&\left(\because\ \text{直前の等式}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-2K_2^*&=\log(\tanh K_2)
&&\left(\because\ 2K_2^*=-\log(\tanh K_2)\text{ の両辺を符号反転}\right)\\
\exp(-2K_2^*)&=\exp(\log(\tanh K_2))
&&\left(\because\ \text{等しい実数への指数関数の適用}\right)\\
&=\tanh K_2
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_2^*)
&=\frac{\exp(2K_2^*)-\exp(-2K_2^*)}{2}
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac{\frac1{\tanh K_2}-\exp(-2K_2^*)}{2}
&&\left(\because\ \exp(2K_2^*)=\frac1{\tanh K_2}\right)\\
&=\frac{\frac1{\tanh K_2}-\tanh K_2}{2}
&&\left(\because\ \exp(-2K_2^*)=\tanh K_2\right)\\
&=\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ \mathbb{R}\text{ の分配法則}\right)
\end{aligned}`),
      paragraph(["一方、倍角の双曲線正弦は定義から"]),
      displayMath(String.raw`\begin{aligned}
2\sinh K_2\cosh K_2
&=2\frac{\exp(K_2)-\exp(-K_2)}2\frac{\exp(K_2)+\exp(-K_2)}2
&&\left(\because\ \blkref{def_cosh_sinh}\right)\\
&=\frac12\left(\exp(K_2)-\exp(-K_2)\right)\left(\exp(K_2)+\exp(-K_2)\right)
&&\left(\because\ 2\cdot\frac12\cdot\frac12=\frac12\right)\\
&=\frac{\exp(K_2)^2-\exp(-K_2)^2}{2}
&&\left(\because\ (a-b)(a+b)=a^2-b^2\right)\\
&=\frac{\exp(2K_2)-\exp(-2K_2)}2
&&\left(\because\ \exp(x)\exp(y)=\exp(x+y)\ \blkref{scalar_exp_product}\right)\\
&=\sinh(2K_2)
&&\left(\because\ \blkref{def_cosh_sinh}\right)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\sinh(2K_2)\sinh(2K_2^*)
&=2\sinh K_2\cosh K_2\sinh(2K_2^*)
&&\left(\because\ \sinh(2K_2)=2\sinh K_2\cosh K_2\right)\\
&=2\sinh K_2\cosh K_2\cdot\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ \sinh(2K_2^*)=\frac12\left(\frac1{\tanh K_2}-\tanh K_2\right)\right)\\
&=\sinh K_2\cosh K_2\left(\frac1{\tanh K_2}-\tanh K_2\right)
&&\left(\because\ 2\cdot\frac12=1\right)\\
&=\sinh K_2\cosh K_2\left(\frac1{\sinh K_2/\cosh K_2}-\frac{\sinh K_2}{\cosh K_2}\right)
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)\\
&=\sinh K_2\cosh K_2\left(\frac{\cosh K_2}{\sinh K_2}-\frac{\sinh K_2}{\cosh K_2}\right)
&&\left(\because\ \sinh K_2\ne0\ \land\ \cosh K_2\ne0\right)\\
&=\sinh K_2\cosh K_2\frac{(\cosh K_2)^2-(\sinh K_2)^2}{\sinh K_2\cosh K_2}
&&\left(\because\ \mathbb{R}\text{ の分数の通分}\right)\\
&=(\cosh K_2)^2-(\sinh K_2)^2
&&\left(\because\ \sinh K_2\cosh K_2\ne0\right)\\
&=1
&&\left(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (2)}\right)
\end{aligned}`),
      paragraph(["ゆえに第二の結合定数と双対結合定数の双対関係が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から第二の双対関係だけを独立した主張として分離した。第二の双対結合定数、双曲線正接、実対数、および双曲線関数の基本性質を先行入力とし、指数関数へ戻す計算から双対関係を一段ずつ示した。双曲線関数の略記と残る正値性には進んでいない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000n_claim_indexed_hyperbolic_abbreviations_positive",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "双曲線関数の添字つき略記の正値性" },
    labels: ["indexed_hyperbolic_abbreviations_positive"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`i\in\{1,2\}`),
        " について、",
        math(String.raw`K_i,K_i^*\in\mathbb{R}_{>0}`),
        " ならば、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記は ",
        math(String.raw`c_i,s_i,c_i^*,s_i^*\in\mathbb{R}`),
        " であり、",
      ]),
      displayMath(String.raw`c_i>0,\qquad s_i>0,\qquad c_i^*>0,\qquad s_i^*>0`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph([
        "任意の ",
        math(String.raw`i\in\{1,2\}`),
        " を固定する。（実双曲線関数の評価と実数順序による実数への脱出）ここでは ",
        math(String.raw`K_i,K_i^*\in\mathbb{R}_{>0}`),
        " を実双曲線関数へ入力し、実数の順序で値を比較する。したがって、以下は実双曲線関数の評価と実数順序を用いる実数上の主張である。",
      ]),
      displayMath(String.raw`\begin{aligned}
2K_i&>0
&&\bigl(\because 2>0,\ K_i>0,\ \text{正数の積}\bigr),\\
2K_i^*&>0
&&\bigl(\because 2>0,\ K_i^*>0,\ \text{正数の積}\bigr).
\end{aligned}`),
      paragraph([
        ref("cosh_sinh_basic_properties"),
        " の (3) を二つの正の引数へ適用する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cosh(2K_i)&>\sinh(2K_i)>0
&&\bigl(\because \blkref{cosh_sinh_basic_properties}\text{ の (3) と }2K_i>0\bigr),\\
\cosh(2K_i^*)&>\sinh(2K_i^*)>0
&&\bigl(\because \blkref{cosh_sinh_basic_properties}\text{ の (3) と }2K_i^*>0\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
c_i&>s_i>0
&&\bigl(\because \blkref{def_indexed_hyperbolic_abbreviations}\text{ の定義で上の第 1 式を書き換えた}\bigr),\\
c_i^*&>s_i^*>0
&&\bigl(\because \blkref{def_indexed_hyperbolic_abbreviations}\text{ の定義で上の第 2 式を書き換えた}\bigr),\\
s_i&>0
&&\bigl(\because c_i>s_i>0\text{ の後半}\bigr),\\
s_i^*&>0
&&\bigl(\because c_i^*>s_i^*>0\text{ の後半}\bigr),\\
c_i&>0
&&\bigl(\because c_i>s_i\text{ と }s_i>0\text{ の推移律}\bigr),\\
c_i^*&>0
&&\bigl(\because c_i^*>s_i^*\text{ と }s_i^*>0\text{ の推移律}\bigr).
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から、添字つき略記の正値性だけを独立した主張へ分離した。実数の順序を用いる実数への脱出であるため、双曲線関数の基本性質を入力として正値性を一段ずつ示した。",
      ],
    },
  },
  {
    id: "transfer_matrix_001_definition_symbols",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "記号の定義" },
    labels: ["def_transfer_matrix_symbols"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた転送行列 ",
        math(String.raw`V_1, V_2`),
        " と、",
        ref("first_transfer_matrix_pauli_form"),
        " で示した ",
        math(String.raw`V_1`),
        " のパウリ行列表示、",
        ref("second_transfer_matrix_pauli_form"),
        " で示した ",
        math(String.raw`V_2`),
        " のパウリ行列表示、",
        ref("def_site_pauli_periodic_extension"),
        " で定めた周期的な延長 ",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z`),
        "、",
        ref("pauli_matrix_products"),
        " で定めた二次の Pauli 行列と単位行列、",
        ref("kronecker_product_rule"),
        " の (2) で示した二次の単位行列のクロネッカー積、",
        ref("def_site_pauli_matrices"),
        " で定めたサイトごとの Pauli 行列族、",
        ref("global_spin_flip_jordan_wigner_representation"),
        " で示した全スピン反転行列の Jordan--Wigner 表示、および ",
        ref("def_cosh_sinh"),
        " で定めた双曲線余弦・双曲線正弦を用いる。また、双対結合定数の式に現れる双曲線正接は ",
        ref("def_positive_coupling_tanh"),
        " で定めたものを用いる。実対数は ",
        ref("def_real_logarithm_positive"),
        " で定めたものを用いる。第一の双対結合定数は ",
        ref("def_first_dual_coupling_constant"),
        " で定めたものを用いる。第一の双対関係は ",
        ref("first_dual_coupling_relation"),
        " で示したものを用いる。第二の双対結合定数は ",
        ref("def_second_dual_coupling_constant"),
        " で定めたものを用いる。第二の双対関係は ",
        ref("second_dual_coupling_relation"),
        " で示したものに加え、双曲線関数の添字つき略記は ",
        ref("def_indexed_hyperbolic_abbreviations"),
        " で定めたものを用い、その正値性は ",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " で示したものを用いる。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\boxtimes`),
        " は ",
        ref("def_kronecker"),
        " のクロネッカー積であり、",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素正方行列全体である。すなわち上の ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z, Z_m, Y_m, \varepsilon`),
        " などはすべて具体的な ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の複素行列である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "第一の転送行列と周期規約は <def_first_transfer_matrix_pauli> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "第二の転送行列は <def_second_transfer_matrix_pauli> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "Jordan--Wigner 行列族 Z_m は <def_jordan_wigner_Z_matrices> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "Jordan--Wigner 行列族 Y_m は <def_jordan_wigner_Y_matrices> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新定義を明示参照している。",
        "全スピン反転行列 epsilon は <def_global_spin_flip_matrix> へ、その Jordan--Wigner 行列による表示は <global_spin_flip_jordan_wigner_representation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから新しい表示主張を明示参照している。",
        "二次の単位行列 I_{Mat(2,C)} は <pauli_matrix_products> で既に定義されているため、本ブロックの重複した一覧項目を削除し、先頭段落の参照だけで接続した。",
        "2^M 次の単位行列 I_{Mat(2^M,C)} と二次の単位行列のクロネッカー積の等式は <kronecker_product_rule> (2) で既に示されているため、本ブロックの重複した一覧項目を削除し、先頭段落の参照だけで接続した。",
        "第一の双対結合定数 K_1^* の定義と正値性は <def_first_dual_coupling_constant> へ、第一の双対関係は <first_dual_coupling_relation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        "第二の双対結合定数 K_2^* の定義と正値性は <def_second_dual_coupling_constant> へ、第二の双対関係は <second_dual_coupling_relation> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        "双曲線関数の添字つき略記は <def_indexed_hyperbolic_abbreviations> へ、その正値性は <indexed_hyperbolic_abbreviations_positive> へ分離した。旧ラベルを使う後続参照の意味を保つため、本ブロックから両者を明示参照している。",
        '旧 main.typ には、見出し「対角化の計算」直下に同内容のインライン #definition("記号の定義") が' +
          "重複して置かれていた。相違は双対関係の注記のみで、そちらは旧版の sinh(K_i)sinh(K_i^*)=1" +
          "（parts/004/000 で sinh(2K_i)sinh(2K_i^*)=1 に訂正済み）。よって重複ブロックは作らず、" +
          "本ブロックへ集約した（インライン側にのみ在った σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, " +
          "p_m/q_m の対応は本ブロックへ補記済み）。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。本ブロックは V_1, V_2 を定義せず、<def_transfer_matrix> の成分定義と、<first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> のパウリ行列表示を参照する。上の <def_first_transfer_matrix_pauli>・<def_second_transfer_matrix_pauli> への分離の記録は、両ブロックがこの主張へ統合されたため歴史的な記録である。",
      ],
    },
  },
  {
    id: "transfer_matrix_003_claim_V1_in_Z_Y_epsilon",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ", ordinal: 3 },
    title: { tex: String.raw`V_1 \text{ を } Z, Y, \varepsilon \text{ で表す}` },
    labels: ["V1_in_Z_Y_epsilon"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1, Z_m, Y_m, \varepsilon, K_1`),
        " を考える。このとき ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - \varepsilon Y_{M_{\mathrm{col}}} Z_1)\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`i \in \mathbb{C}`),
        " は虚数単位）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の方針: ",
        math(String.raw`\exp`),
        " の中身どうしが ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元として等しいことを示す。",
        math(String.raw`\exp`),
        " は写像であるから、これが示されれば ",
        math(String.raw`\exp`),
        " の値も等しく、主張が従う（したがって ",
        ref("theorem_exp_product"),
        " のような ",
        math(String.raw`\exp`),
        " の分解は用いない）。",
      ]),
      paragraph([
        "以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z, I := I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列とし、クロネッカー積の積が各サイトごとの積であること（",
        ref("kronecker_product_rule"),
        " (1)）",
      ]),
      displayMath(
        String.raw`(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}})(B_1\boxtimes\cdots\boxtimes B_{M_{\mathrm{col}}})
= (A_1B_1)\boxtimes\cdots\boxtimes(A_{M_{\mathrm{col}}}B_{M_{\mathrm{col}}})
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "と、クロネッカー積が各因子について ",
        math(String.raw`\mathbb{C}`),
        "-線型であること（",
        ref("kronecker_multilinear"),
        "）",
      ]),
      displayMath(
        String.raw`C_1\boxtimes\cdots\boxtimes\overbrace{(c\,C_j)}^{j\text{th}}\boxtimes\cdots\boxtimes C_{M_{\mathrm{col}}}
= c\,(C_1\boxtimes\cdots\boxtimes C_{M_{\mathrm{col}}}) \quad (c\in\mathbb{C})
\quad (\because \text{第 } j \text{ 因子についての } \mathbb{C}\text{-線型性})`,
      ),
      paragraph(["を繰り返し用いる。"]),
      paragraph([
        "Step 0: 単一サイトの Pauli 行列の積。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " に加えて、以下の 3 式を ",
        math(String.raw`2\times 2`),
        " 行列の積の成分計算で確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+(-i)\cdot1 & 0\cdot1+(-i)\cdot0 \\ i\cdot0+0\cdot1 & i\cdot1+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^y
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}0\cdot0+1\cdot i & 0\cdot(-i)+1\cdot0 \\ 1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}i&0\\0&-i\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= i\begin{pmatrix}1&0\\0&-1\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= i\,\sigma^z
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&&(\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0 \\ 0\cdot0+(-1)\cdot i & 0\cdot(-i)+(-1)\cdot0\end{pmatrix}
&&(\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&&(\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&&(\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^x
&&(\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`Z_m, Y_m, \varepsilon, \sigma_m^z\sigma_{m+1}^z, \sigma_m^x`),
        " のクロネッカー積による表示。まず ",
        math(String.raw`1\le r\le M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "が成り立つ。これを ",
        math(String.raw`r`),
        " に関する帰納法で示す。",
        math(String.raw`r=1`),
        " のときは ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\sigma_1^{a_1}`),
        " の定義そのものである。",
        math(String.raw`r`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&&(\because \text{帰納法の仮定}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&&(\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-(r+1)}
&&(\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        ref("def_jordan_wigner_Z_matrices"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        ref("def_jordan_wigner_Y_matrices"),
        " の ",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " に適用すると（",
        math(String.raw`m=1`),
        " のときは前半の積が空積で ",
        math(String.raw`Z_1=\sigma_1^z`),
        "、",
        math(String.raw`Y_1=\sigma_1^y`),
        "。以下の式で ",
        math(String.raw`\sigma^x`),
        " の個数を ",
        math(String.raw`0`),
        " とすればよい）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because \text{上の一般式と } Z_m \text{ の定義}) \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
&&(\because \text{上の一般式と } Y_m \text{ の定義 }\blkref{def_jordan_wigner_Y_matrices}) \\
\varepsilon &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}
&&(\because \text{上の一般式（} r=M_{\mathrm{col}} \text{）と } \varepsilon \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\sigma_m^x`),
        " は第 ",
        math(String.raw`m`),
        " 因子のみ ",
        math(String.raw`\sigma^x`),
        " で他は ",
        math(String.raw`I`),
        " であり、",
        math(String.raw`1\le m\le M_{\mathrm{col}}-1`),
        " について（第 ",
        math(String.raw`m`),
        " 因子と第 ",
        math(String.raw`m+1`),
        " 因子以外はすべて ",
        math(String.raw`II=I`),
        "）",
      ]),
      displayMath(
        String.raw`\sigma_m^z\sigma_{m+1}^z
= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m-1}
\quad (\because \text{クロネッカー積の積の規則})`,
      ),
      paragraph([
        "である。同様に ",
        math(String.raw`M_{\mathrm{col}}\ge 2`),
        " より第 ",
        math(String.raw`1`),
        " 因子と第 ",
        math(String.raw`M_{\mathrm{col}}`),
        " 因子は異なるので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{\sigma^z}^{M_{\mathrm{col}}\text{th}}
&& (\because \text{クロネッカー積の積の規則})\\
&= \sigma_1^z\sigma_{M_{\mathrm{col}}}^z
&& (\because \text{クロネッカー積の積の規則})
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`1\le m\le M_{\mathrm{col}}-1`),
        " について ",
        math(String.raw`Y_m Z_{m+1} = -i\,\sigma_m^z\sigma_{m+1}^z`),
        "。Step 1 の表示を用いて因子ごとに計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^x}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}
   \boxtimes\overbrace{(\sigma^y\sigma^x)}^{m\text{th}}\boxtimes\overbrace{(I\sigma^z)}^{(m+1)\text{th}}\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{(-i\,\sigma^z)}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I
&& (\because \sigma^x\sigma^x = I,\ \sigma^y\sigma^x = -i\,\sigma^z \text{（Step 0）}) \\
&= (-i)\left(\overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{\sigma^z}^{(m+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{第 } m \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
&& (\because \text{Step 1}) \\
\sigma_m^z\sigma_{m+1}^z
&= \bigl(i\cdot(-i)\bigr)\sigma_m^z\sigma_{m+1}^z
&& (\because\ i\cdot(-i)=1\text{（複素数の四則）})\\
&= i\bigl((-i)\sigma_m^z\sigma_{m+1}^z\bigr)
&& (\because\ \text{複素数倍の結合則})\\
&= i\,Y_m Z_{m+1}
&& (\because\ \text{上の Step 2 の等式})
\qquad (1\le m\le M_{\mathrm{col}}-1)
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 境界項 ",
        math(String.raw`\varepsilon\, Y_{M_{\mathrm{col}}} Z_1 = i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        "。ここで Jordan--Wigner 文字列 ",
        math(String.raw`\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}-1}^x`),
        " が周期境界で一周し、",
        math(String.raw`Z_1 = \sigma_1^z`),
        " の側に文字列が付いていないため、Step 2 の計算では第 ",
        math(String.raw`1`),
        " 因子の ",
        math(String.raw`\sigma^x`),
        " が相殺せずに残る。これを打ち消すのが ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " である。実際、",
        math(String.raw`M_{\mathrm{col}}\ge 2`),
        " のもとで 3 つの元の積を（クロネッカー積の積の規則を 2 回使って）因子ごとに計算すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\, Y_{M_{\mathrm{col}}} Z_1
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}}\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}-1}\boxtimes\overbrace{\sigma^y}^{M_{\mathrm{col}}\text{th}}\right)
   \left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-1}\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x\sigma^z)}^{1\text{st}}
   \boxtimes\overbrace{(\sigma^x\sigma^x I)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x I)}^{2\text{nd},\dots,(M_{\mathrm{col}}-1)\text{th}}
   \boxtimes\overbrace{(\sigma^x\sigma^y I)}^{M_{\mathrm{col}}\text{th}}
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{(i\,\sigma^z)}^{M_{\mathrm{col}}\text{th}}
&& (\because \sigma^x\sigma^x = I,\ AI=A,\ \sigma^x\sigma^y = i\,\sigma^z \text{（Step 0）}) \\
&= i\left(\overbrace{\sigma^z}^{1\text{st}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-2}\boxtimes\overbrace{\sigma^z}^{M_{\mathrm{col}}\text{th}}\right)
&& (\because \text{第 } M_{\mathrm{col}} \text{ 因子についての } \mathbb{C}\text{-線型性}) \\
&= i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&& (\because \text{Step 1 の最後の式})
\end{aligned}`,
      ),
      paragraph([
        "したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&= \bigl((-i)\cdot i\bigr)\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&& (\because\ (-i)\cdot i=1\text{（複素数の四則）})\\
&= (-i)\bigl(i\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z\bigr)
&& (\because\ \text{複素数倍の結合則})\\
&= -i\,\varepsilon\, Y_{M_{\mathrm{col}}} Z_1
&& (\because\ \text{上の Step 3 の等式})
\end{aligned}`,
      ),
      paragraph([
        "Step 4: ",
        math(String.raw`V_1`),
        " の表式。",
        ref("first_transfer_matrix_pauli_form"),
        " の ",
        math(String.raw`V_1`),
        " の指数の中身を、",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z = \sigma_1^z`),
        " により最後の項 ",
        math(String.raw`\sigma_{M_{\mathrm{col}}}^z\sigma_{M_{\mathrm{col}}+1}^z = \sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        " だけ分けて書くと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_1\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z
&= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right) + K_1\,\sigma_{M_{\mathrm{col}}}^z\sigma_1^z
&&(\because\ \sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z\ \text{として有限和の最後の項を分ける}) \\
&= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} i\,Y_m Z_{m+1}\right) + K_1\left(-i\,\varepsilon\,Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because \text{Step 2, Step 3}) \\
&= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - \varepsilon\, Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because \mathbb{C}\text{-線型空間 } \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \text{ でのスカラー倍の分配律}) \\
&= i K_1\left(Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}} - \varepsilon\,Y_{M_{\mathrm{col}}} Z_1\right)
&&(\because\ \text{有限和を項ごとに書く})
\end{aligned}`,
      ),
      paragraph([
        "両辺は ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の同一の元であるから、",
        math(String.raw`\exp`),
        " の値も等しく、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_1
&= \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
&&(\because\ \blkref{first_transfer_matrix_pauli_form}) \\
&= \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - \varepsilon Y_{M_{\mathrm{col}}} Z_1)\right)
&&(\because\ \text{直前の指数の等式})
\end{aligned}`,
      ),
      paragraph(["以上で主張が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明の過程で、原文の V_1 の定義に含まれていた虚数単位が誤りであることが判明したため、" +
          "<def_transfer_matrix_symbols> 側を訂正した（理由はそちらの conversion.notes を参照）。",
        "原文の statement は式のみで M の範囲・記号の出典が書かれていなかったため、M ≥ 2 と" +
          "参照先（<def_transfer_matrix_symbols>）を明示した（主張の内容自体は変えていない）。",
        "2026-09-02 の式変形統一で、Step 1 の帰納法と Z_m・Y_m・ε の三本の表示に行中の " +
          "\\quad (\\because …) で置かれていた根拠 6 行を、aligned の行末の根拠列へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
        "2026-09-02 の式変形統一で、Step 3 の境界項 εY_MZ_1 の鎖に行中の " +
          "\\quad (\\because …) で置かれていた根拠 5 行を、aligned の行末の根拠列へ揃えた。" +
          "内容・式変形・根拠・参照は変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。パウリ行列の指数表示を引く箇所の参照先を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_003a_claim_V2_in_Z_Y",
    kind: "claim",
    origin: { path: "_old/typst/parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ", ordinal: 3 },
    title: { tex: String.raw`V_2 \text{ を } Z, Y \text{ で表す}` },
    labels: ["V2_in_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2, Z_m, Y_m, K_2^*, s_2 \;(= \sinh 2K_2)`),
        " を考える。このとき ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2} \exp\!\left(i K_2^* (Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_{M_{\mathrm{col}}} Y_{M_{\mathrm{col}}})\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`i \in \mathbb{C}`),
        " は虚数単位）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の方針: ",
        math(String.raw`\exp`),
        " の中身どうしが ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元として等しいことを示す。以下、",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z, I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " は ",
        ref("pauli_matrix_products"),
        " の Pauli 行列とする。クロネッカー積の積の規則（",
        ref("kronecker_product_rule"),
        " (1)）と各因子についての ",
        math(String.raw`\mathbb{C}`),
        "-線型性（",
        ref("kronecker_multilinear"),
        "）を用いる。",
      ]),
      paragraph([
        "Step 0: 単一サイトの積 ",
        math(String.raw`\sigma^z\sigma^y=-i\,\sigma^x`),
        " を成分計算で確かめる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
&& (\because \text{Pauli 行列の定義}) \\
&= \begin{pmatrix}1\cdot0+0\cdot i & 1\cdot(-i)+0\cdot0 \\ 0\cdot0+(-1)\cdot i & 0\cdot(-i)+(-1)\cdot0\end{pmatrix}
&& (\because 2\times2 \text{ 行列の積の成分計算}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
&& (\because \mathbb{C} \text{ の四則}) \\
&= -i\begin{pmatrix}0&1\\1&0\end{pmatrix}
&& (\because \text{行列のスカラー倍の定義}) \\
&= -i\,\sigma^x
&& (\because \text{Pauli 行列の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 1: ",
        math(String.raw`Z_m,Y_m,\sigma_m^x`),
        " のクロネッカー積表示。まず ",
        math(String.raw`1\le r\le M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a_1,\dots,a_r\in\{x,y,z\}`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\cdots\sigma_r^{a_r}
= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes
\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`r=1`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の定義である。",
        math(String.raw`r`),
        " で成り立つと仮定して ",
        math(String.raw`\sigma_{r+1}^{a_{r+1}}`),
        " を右から掛けると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_1^{a_1}\cdots\sigma_r^{a_r}\sigma_{r+1}^{a_{r+1}}
&= \left(\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_r}\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(I\boxtimes\cdots\boxtimes I\boxtimes\overbrace{\sigma^{a_{r+1}}}^{(r+1)\text{th}}\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{帰納法の仮定とサイト作用素の定義}) \\
&= (\sigma^{a_1}I)\boxtimes\cdots\boxtimes(\sigma^{a_r}I)\boxtimes(I\sigma^{a_{r+1}})\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_{r+1}}\boxtimes
   \overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-(r+1)}
&& (\because AI=IA=A)
\end{aligned}`,
      ),
      paragraph(["よって帰納法により一般式が成り立つ。定義へ適用すると"]),
      displayMath(
        String.raw`\begin{aligned}
Z_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^z}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}, \\
Y_m &= \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}
\boxtimes\overbrace{\sigma^y}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}, \\
\sigma_m^x &= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}
\boxtimes\overbrace{\sigma^x}^{m\text{th}}
\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}
\end{aligned}
\quad (\because \text{一般式とサイト作用素の定義})`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`1\le m\le M_{\mathrm{col}}`),
        " について ",
        math(String.raw`Z_mY_m=-i\,\sigma_m^x`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_mY_m
&= \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^z\boxtimes I\boxtimes\cdots\boxtimes I\right)
   \left(\overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\sigma^y\boxtimes I\boxtimes\cdots\boxtimes I\right)
&& (\because \text{Step 1}) \\
&= \overbrace{(\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)}^{m-1}\boxtimes(\sigma^z\sigma^y)\boxtimes(II)\boxtimes\cdots\boxtimes(II)
&& (\because \text{クロネッカー積の積の規則}) \\
&= \overbrace{I\boxtimes\cdots\boxtimes I}^{m-1}\boxtimes(-i\,\sigma^x)\boxtimes I\boxtimes\cdots\boxtimes I
&& (\because \sigma^x\sigma^x=I\ \text{と Step 0}) \\
&= -i\,\sigma_m^x
&& (\because \text{第 }m\text{ 因子についての複素線型性と Step 1})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^x
&= \bigl(i\cdot(-i)\bigr)\sigma_m^x
&& (\because i\cdot(-i)=1) \\
&= i\bigl((-i)\sigma_m^x\bigr)
&& (\because \text{複素数倍の結合則}) \\
&= i\,Z_mY_m
&& (\because \text{Step 2})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: ",
        math(String.raw`V_2`),
        " の表式。指数の中身は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
K_2^*\left(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x\right)
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
&& (\because \text{有限和を}\ \textstyle\sum\ \text{記法で書く}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}i\,Z_mY_m
&& (\because \text{Step 2 の直後の等式を各項へ適用}) \\
&= iK_2^*\left(Z_1Y_1+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}\right)
&& (\because \text{スカラー倍の分配律と有限和を項ごとに書く})
\end{aligned}`,
      ),
      paragraph([
        "両辺へ行列指数関数を適用し、",
        ref("second_transfer_matrix_pauli_form"),
        " の ",
        math(String.raw`V_2`),
        " のパウリ行列表示と ",
        math(String.raw`s_2=\sinh 2K_2`),
        " の定義を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V_2
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x)\right)
&& (\because \blkref{second_transfer_matrix_pauli_form}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*(\sigma_1^x+\cdots+\sigma_{M_{\mathrm{col}}}^x)\right)
&& (\because s_2=\sinh 2K_2) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*(Z_1Y_1+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}})\right)
&& (\because \text{直前の指数の等式})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧ブロックは独立した V1 と V2 の二等式を一つの主張へ束ねていたため、一ブロック一主張の規約に従って V2 の等式を分離した。",
        "抽象テンソル積を使わず、具体的なクロネッカー積と二次 Pauli 行列の成分計算だけで証明した。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。パウリ行列の指数表示を引く箇所の参照先を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_004_definition_eigenspace_even_of_epsilon",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の固有値 }+1\text{ の固有ベクトル全体}` },
    labels: ["def_even_eigenvectors_of_epsilon"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を考える。",
        math(String.raw`\varepsilon`),
        " を ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 成分の複素数ベクトルへ ",
        ref("mat_mult"),
        " の通常の行列と数ベクトルの積として作用させ、",
      ]),
      displayMath(
        String.raw`\mathcal{F}^{(+)}
:=\left\{f\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\;\middle|\;\varepsilon f=f\right\}`,
      ),
      paragraph([
        "と定める。すなわち ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は、全スピン反転行列を左から掛けても変わらない複素数ベクトルの全体である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "二つの固有ベクトル集合と二つの部分空間性を束ねていたブロックから、固有値 +1 の集合定義だけを分離した。",
        "抽象線型写像 end(ε) を経由せず、2^M 次複素行列 ε と数ベクトルの積で定義した。",
      ],
    },
  },
  {
    id: "transfer_matrix_004b_claim_epsilon_square_and_eigenvalues",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`\varepsilon\text{ の二乗}` },
    labels: ["epsilon_square_and_eigenvalues", "epsilon_square_identity"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
      ]),
      displayMath(String.raw`\varepsilon^2=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
    ],
    proof: [
      paragraph([
        "まず ",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と略記し、",
        math(String.raw`P_0:=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`P_r:=\sigma_1^x\cdots\sigma_r^x\ (1\leq r\leq M_{\mathrm{col}})`),
        " と置く。各 ",
        math(String.raw`r\in\{0,\dots,M_{\mathrm{col}}\}`),
        " について、",
      ]),
      displayMath(
        String.raw`P_r
=\underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r}
 \boxtimes
 \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r}`,
      ),
      paragraph([
        "を示す。ただし、因子が零個の部分は書かない。",
        math(String.raw`r=0`),
        " の場合は、",
        ref("kronecker_product_rule"),
        " (2) を繰り返し使うと、右辺は ",
        math(String.raw`I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}=P_0`),
        " である。ある ",
        math(String.raw`r\in\{0,\dots,M_{\mathrm{col}}-1\}`),
        " についてこの式が成り立つと仮定する。このとき ",
        math(String.raw`r+1\leq M_{\mathrm{col}}`),
        " なので、サイト作用素の定義と ",
        ref("kronecker_product_rule"),
        " (1)(2) より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{r+1}=P_r\sigma_{r+1}^x
&=\left(
   \underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r}
   \boxtimes
   \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r}
  \right)
  \left(
   \underbrace{I\boxtimes\cdots\boxtimes I}_{r}
   \boxtimes\sigma^x\boxtimes
   \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r-1}
  \right)
&&(\because\ \text{帰納法の仮定と}\ \sigma_{r+1}^x\ \text{の定義})\\
&=\underbrace{(\sigma^x I)\boxtimes\cdots\boxtimes(\sigma^x I)}_{r}
  \boxtimes(I\sigma^x)\boxtimes
  \underbrace{(II)\boxtimes\cdots\boxtimes(II)}_{M_{\mathrm{col}}-r-1}
&&(\because\ \text{クロネッカー積の積の規則})\\
&=\underbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}_{r+1}
  \boxtimes
  \underbrace{I\boxtimes\cdots\boxtimes I}_{M_{\mathrm{col}}-r-1}
&&(\because\ \sigma^x I=I\sigma^x=\sigma^x\ \text{と}\ II=I).
\end{aligned}`,
      ),
      paragraph([
        "よって有限帰納法により一般式が成り立つ。",
        math(String.raw`r=M_{\mathrm{col}}`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon=\sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " の定義から ",
        math(String.raw`\varepsilon=\sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " を得る。したがって、",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x\sigma^x = I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "、および ",
        ref("kronecker_product_rule"),
        " (1)(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^2
&= (\sigma^x\boxtimes\cdots\boxtimes\sigma^x)(\sigma^x\boxtimes\cdots\boxtimes\sigma^x)
&&(\because\ \varepsilon=\sigma^x\boxtimes\cdots\boxtimes\sigma^x)\\
&= (\sigma^x\sigma^x)\boxtimes\cdots\boxtimes(\sigma^x\sigma^x)
&&(\because\ \text{クロネッカー積の積の規則})\\
&= \underbrace{I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}}_{M_{\mathrm{col}}}
&&(\because\ \sigma^x\sigma^x=I_{\mathrm{Mat}(2,\mathbb{C})}\ \text{を各因子へ同時に適用})\\
&= I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{クロネッカー積の単位元の規則})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: ["全スピン反転行列の二乗と固有値候補を、一ブロック一主張になるよう分離した。"],
    },
  },
  {
    id: "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/005_claim_V1の固有空間への制限.typ", ordinal: 6 },
    title: { tex: String.raw`V_1 \text{ の }\mathcal{F}^{(+)}\text{ への制限}` },
    labels: ["V1_restriction_to_eigenspaces"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1`),
        "、",
        ref("def_end_iso"),
        " の ",
        math(String.raw`\mathbf{end}`),
        "、",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、",
      ]),
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(+)}}
= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(+)}}`,
      ),
      paragraph([
        "が成り立つ。両辺は ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " から ",
        math(String.raw`\mathcal{F}`),
        " への写像として一致する、という意味である（右辺の ",
        math(String.raw`\exp(\cdots)`),
        " をこの証明内で ",
        math(String.raw`V_1^{(+)}`),
        " と略記する）。",
      ]),
    ],
    proof: [
      paragraph([
        "記号を固定する。",
        ref("V1_in_Z_Y_epsilon"),
        " より ",
        math(String.raw`V_1 = \exp(G)`),
        "、また上の略記より ",
        math(String.raw`V_1^{(+)} = \exp(G^{(+)})`),
        "。ここで",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W &:= Y_{M_{\mathrm{col}}} Z_1 \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \\
G &:= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - \varepsilon W\right) \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}) \\
G^{(+)} &:= i K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - W\right) \ \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})
\end{aligned}`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`A \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " に対し ",
        math(String.raw`\hat{A} := \mathbf{end}(A) \in \mathrm{End}(\mathcal{F})`),
        " と書く。",
        ref("end_is_algebra_isomorphism"),
        " より ",
        math(String.raw`\widehat{AB} = \hat{A}\circ\hat{B}`),
        " かつ ",
        math(String.raw`A \mapsto \hat{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\varepsilon`),
        " は各 ",
        math(String.raw`Z_m, Y_m`),
        "（",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        "）と反交換する。すなわち",
      ]),
      displayMath(
        String.raw`\varepsilon Z_m = -\,Z_m\varepsilon, \qquad \varepsilon Y_m = -\,Y_m\varepsilon`,
      ),
      paragraph([
        ref("V1_in_Z_Y_epsilon"),
        " の証明 Step 1 と同じクロネッカー積による表示",
      ]),
      displayMath(
        String.raw`\varepsilon = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{M_{\mathrm{col}}},\qquad
Z_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^z}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m},\qquad
Y_m = \overbrace{\sigma^x\boxtimes\cdots\boxtimes\sigma^x}^{m-1}\boxtimes\overbrace{\sigma^y}^{m\text{th}}\boxtimes\overbrace{I\boxtimes\cdots\boxtimes I}^{M_{\mathrm{col}}-m}`,
      ),
      paragraph([
        "のもとで ",
        ref("tensor_anticommutation_from_single_site"),
        " を ",
        math(String.raw`X=\varepsilon`),
        "、",
        math(String.raw`Y=Z_m`),
        " に適用する。第 ",
        math(String.raw`k`),
        " 因子の組 ",
        math(String.raw`(x_k,y_k)`),
        " は",
      ]),
      list([
        [
          math(String.raw`k<m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^x)`),
          "。",
          math(String.raw`\sigma^x\sigma^x = \sigma^x\sigma^x`),
          " より可換。",
        ],
        [
          math(String.raw`k=m`),
          " のとき ",
          math(String.raw`(\sigma^x,\sigma^z)`),
          "。",
          ref("pauli_matrix_products"),
          " の ",
          math(String.raw`\sigma^z\sigma^x = -\,\sigma^x\sigma^z`),
          " より反可換。",
        ],
        [
          math(String.raw`k>m`),
          " のとき ",
          math(String.raw`(\sigma^x,I)`),
          "。",
          math(String.raw`I\sigma^x = \sigma^x I`),
          " より可換。",
        ],
      ]),
      paragraph([
        "であり、反可換なサイトはちょうど 1 つ（",
        math(String.raw`k=m`),
        "）だから ",
        math(String.raw`[\varepsilon, Z_m]_+ = \varepsilon Z_m + Z_m\varepsilon = 0`),
        "、すなわち ",
        math(String.raw`\varepsilon Z_m = -Z_m\varepsilon`),
        "。",
        math(String.raw`Y_m`),
        " についても、",
        math(String.raw`k=m`),
        " の組が ",
        math(String.raw`(\sigma^x,\sigma^y)`),
        " で ",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y\sigma^x = -\,\sigma^x\sigma^y`),
        " より反可換、他のサイトは同じく可換であるから ",
        math(String.raw`\varepsilon Y_m = -Y_m\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`W`),
        "、各 ",
        math(String.raw`Y_mZ_{m+1}`),
        "、",
        math(String.raw`\varepsilon W`),
        "、および ",
        math(String.raw`G, G^{(+)}`),
        " と可換である。実際、",
        math(String.raw`a,b\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について Step 1 を 2 回使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon (Y_a Z_b)
&= (\varepsilon Y_a) Z_b
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})\\
&= (-Y_a\varepsilon)Z_b
&&(\because\ \text{Step 1 の}\ \varepsilon Y_a = -Y_a\varepsilon)\\
&= -\left(Y_a\varepsilon\right)Z_b
&&(\because\ \text{スカラー倍と積の可換性})\\
&= -Y_a(\varepsilon Z_b)
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})\\
&= -Y_a(-Z_b\varepsilon)
&&(\because\ \text{Step 1 の}\ \varepsilon Z_b = -Z_b\varepsilon)\\
&= (Y_a Z_b)\varepsilon
&&(\because\ \text{スカラー倍と積の可換性、および}\ -(-1)=1)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。特に ",
        math(String.raw`\varepsilon W = W\varepsilon`),
        " かつ ",
        math(String.raw`\varepsilon(Y_mZ_{m+1}) = (Y_mZ_{m+1})\varepsilon`),
        "。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(\varepsilon W)
&= \varepsilon(W\varepsilon)
&&(\because\ \text{上で示した}\ \varepsilon W = W\varepsilon)\\
&= (\varepsilon W)\varepsilon
&&(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\ \text{の積の結合律})
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`G, G^{(+)}`),
        " はいずれも ",
        math(String.raw`\varepsilon`),
        " と可換な元の ",
        math(String.raw`\mathbb{C}`),
        "-線型結合であり、積の双線型性より ",
        math(String.raw`\varepsilon G = G\varepsilon`),
        "、",
        math(String.raw`\varepsilon G^{(+)} = G^{(+)}\varepsilon`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " は ",
        math(String.raw`\hat{W}, \hat{G}, \hat{G}^{(+)}`),
        " で不変である。",
        math(String.raw`A \in \{W, G, G^{(+)}\}`),
        " は Step 2 より ",
        math(String.raw`\varepsilon A = A\varepsilon`),
        " を満たすから、",
        ref("end_is_algebra_isomorphism"),
        " (2) より次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{\varepsilon}\circ\hat{A}
&= \widehat{\varepsilon A}
&&(\because\ \mathbf{end}\ \text{が積を保つこと})\\
&= \widehat{A\varepsilon}
&&(\because\ \text{Step 2 の}\ \varepsilon A = A\varepsilon)\\
&= \hat{A}\circ\hat{\varepsilon}
&&(\because\ \mathbf{end}\ \text{が積を保つこと})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        "（すなわち ",
        math(String.raw`\hat{\varepsilon}f = f`),
        "）に対し",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{\varepsilon}\left(\hat{A}f\right)
&= \hat{A}\left(\hat{\varepsilon}f\right)
&&(\because\ \hat{\varepsilon}\circ\hat{A} = \hat{A}\circ\hat{\varepsilon})\\
&= \hat{A}f
&&(\because\ f\in\mathcal{F}^{(+)}\ \text{すなわち}\ \hat{\varepsilon}f = f)
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\hat{A}f \in \mathcal{F}^{(+)}`),
        "。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " に対し ",
        math(String.raw`\hat{G}f = \hat{G}^{(+)}f`),
        "。まず ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の中で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
G-G^{(+)}
&=iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}-\varepsilon W\right)
  -iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- W\right)
&&\left(\because\ G,G^{(+)}\ \text{の定義}\right)\\
&=iK_1\left(
  \left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}-\varepsilon W\right)
  -\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- W\right)
\right)
&&\left(\because\ \text{スカラー倍の分配則}\right)\\
&=iK_1\left(-\varepsilon W+ W\right)
&&\left(\because\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb C)\ \text{の加法の四則}\right)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("end_is_algebra_isomorphism"),
        " の線型性と (2) より ",
        math(String.raw`\widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}`),
        " だから、Step 3 の ",
        math(String.raw`\hat{W}f\in\mathcal{F}^{(+)}`),
        " を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\hat{G} - \hat{G}^{(+)}\right)f
&= \left(\widehat{G-G^{(+)}}\right)f
&&(\because\ \mathbf{end}\ \text{の線型性（差の像は像の差）})\\
&= \left(\widehat{iK_1\left(-\varepsilon W+ W\right)}\right)f
&&(\because\ \text{上で示した}\ G-G^{(+)}\ \text{の表示})\\
&= i K_1\left(-\widehat{\varepsilon W} + \hat{W}\right)f
&&(\because\ \mathbf{end}\ \text{の線型性})\\
&= i K_1\left(-\hat{\varepsilon}\!\left(\hat{W}f\right) + \hat{W}f\right)
&&(\because\ \widehat{\varepsilon W} = \hat{\varepsilon}\circ\hat{W}\ \text{（}\mathbf{end}\ \text{が積を保つこと）と写像の値の書き下し})\\
&= i K_1\left(-\hat{W}f + \hat{W}f\right)
&&(\because\ \hat{W}f\in\mathcal{F}^{(+)}\ \text{より}\ \hat{\varepsilon}(\hat{W}f) = \hat{W}f\text{（Step 3）})\\
&= i K_1\cdot 0
&&(\because\ -x + x = 0)\\
&= 0
&&(\because\ \text{零ベクトルのスカラー倍は零ベクトル})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。よって ",
        math(String.raw`\hat{G}f = \hat{G}^{(+)}f`),
        "。",
      ]),
      paragraph([
        "Step 5: ",
        math(String.raw`n\in\mathbb{Z}_{\geq 0}`),
        " と ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " について ",
        math(String.raw`\hat{G}^{\,n}f = \left(\hat{G}^{(+)}\right)^{n}f`),
        "（",
        math(String.raw`\hat{G}^{\,0} := \mathrm{id}_{\mathcal{F}}`),
        "）。",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " では",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{G}^{\,0}f
&= \mathrm{id}_{\mathcal F}(f)
&&(\because\ \text{写像の零乗の定義})\\
&= f
&&(\because\ \text{恒等写像の定義})\\
&= \mathrm{id}_{\mathcal F}(f)
&&(\because\ \text{恒等写像の定義})\\
&= \left(\hat{G}^{(+)}\right)^{0}f
&&(\because\ \text{写像の零乗の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`n`),
        " で成立するとし ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " を取ると、Step 4 より ",
        math(String.raw`g := \hat{G}f = \hat{G}^{(+)}f`),
        " であり、Step 3 より ",
        math(String.raw`g\in\mathcal{F}^{(+)}`),
        " だから帰納法の仮定を ",
        math(String.raw`g`),
        " に適用でき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{G}^{\,n+1}f
&= \hat{G}^{\,n}\!\left(\hat{G}f\right)
&&(\because\ \text{写像の冪の定義})\\
&= \hat{G}^{\,n}g
&&(\because\ g := \hat{G}f)\\
&= \left(\hat{G}^{(+)}\right)^{n}g
&&(\because\ \text{帰納法の仮定を}\ g\in\mathcal{F}^{(+)}\ \text{に適用})\\
&= \left(\hat{G}^{(+)}\right)^{n}\!\left(\hat{G}^{(+)}f\right)
&&(\because\ \text{Step 4 の}\ g = \hat{G}^{(+)}f)\\
&= \left(\hat{G}^{(+)}\right)^{n+1}f
&&(\because\ \text{写像の冪の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 6: ",
        math(String.raw`\exp`),
        " への持ち上げ。",
        ref("end_preserves_matrix_exponential"),
        " を ",
        math(String.raw`A=G`),
        " と ",
        math(String.raw`A=G^{(+)}`),
        " に適用する。任意の ",
        math(String.raw`f\in\mathcal{F}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)(f)
&= \left(\mathbf{end}(\exp(G))\right)(f)
&&\left(\because\ V_1=\exp(G)\right)\\
&= \lim_{N\to\infty}\sum_{n=0}^{N}\frac{1}{n!}\hat{G}^{\,n}f
&&\left(\because\ \text{行列表示と線型写像表示の間の指数関数保存}\right),
\end{aligned}`,
      ),
      paragraph(["および"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)(f)
&= \left(\mathbf{end}\!\left(\exp\!\left(G^{(+)}\right)\right)\right)(f)
&&\left(\because\ V_1^{(+)}=\exp(G^{(+)})\right)\\
&= \lim_{N\to\infty}\sum_{n=0}^{N}\frac{1}{n!}\left(\hat{G}^{(+)}\right)^{n}f
&&\left(\because\ \text{行列表示と線型写像表示の間の指数関数保存}\right)
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。ここで解析的操作（",
        math(String.raw`\mathbb{C}`),
        " 上の無限級数の極限）へ移行するのはこの箇所だけであり、Step 1〜5 はすべて有限個の元の" +
          "代数的な等式である。",
      ]),
      paragraph([
        "いま ",
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " を任意に取る。Step 5 より、各 ",
        math(String.raw`N\in\mathbb{Z}_{\geq 0}`),
        " について部分和が",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_N := \sum_{n=0}^{N}\frac{1}{n!}\hat{G}^{\,n}f
&= \sum_{n=0}^{N}\frac{1}{n!}\left(\hat{G}^{(+)}\right)^{n}f
&&(\because\ \text{Step 5 を各}\ n\in\{0,\dots,N\}\ \text{に適用})\\
&=: S_N^{(+)}
&&(\because\ S_N^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "と一致する。上の各点収束より ",
        math(String.raw`S_N \to \left(\mathbf{end}(V_1)\right)(f)`),
        " かつ ",
        math(String.raw`S_N^{(+)} = S_N \to \left(\mathbf{end}(V_1^{(+)})\right)(f)`),
        " であり、同一の点列が 2 つの極限 ",
        math(String.raw`\alpha,\beta`),
        " を持てば、ノルムの三角不等式と極限の定義から次の鎖を得る。",
        ref("matrix_norm_triangle_inequality"),
        " のノルムの非負性・三角不等式・非退化性を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&\leq \|\alpha-\beta\|
&&\left(\because\ \text{ノルムの非負性}\right)\\
&\leq \|\alpha-S_N\|+\|S_N-\beta\|
&&\left(\because\ \alpha-\beta=(\alpha-S_N)+(S_N-\beta)\ \text{と三角不等式}\right)\\
&\longrightarrow 0
&&\left(\because\ S_N\to\alpha\ \text{かつ}\ S_N\to\beta\right).
\end{aligned}`,
      ),
      paragraph(["したがって次の鎖を得る。"]),
      displayMath(
        String.raw`\begin{aligned}
\|\alpha-\beta\|
&=0
&&\left(\because\ 0\leq\|\alpha-\beta\|\leq\|\alpha-S_N\|+\|S_N-\beta\|\to0\right)\\
\alpha
&=\beta
&&\left(\because\ \|\alpha-\beta\|=0\ \text{なら}\ \alpha-\beta=0\right).
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)f
&= \left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)f
&&(\because\ \text{同一の点列}\ S_N = S_N^{(+)}\ \text{の極限の一意性})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f\in\mathcal{F}^{(+)}`),
        " は任意だったから、",
        math(String.raw`\mathcal{F}^{(+)}`),
        " 上の写像として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(+)}}
&= \left(\mathbf{end}\!\left(V_1^{(+)}\right)\right)\big|_{\mathcal{F}^{(+)}}
&&(\because\ \text{上の等式が任意の}\ f\in\mathcal{F}^{(+)}\ \text{で成り立つこと})\\
&= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(+)}}
&&(\because\ V_1^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["が示された。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ、A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文の proof は「TODO」のみ。ここで証明を与えた。",
        "証明には end が単位的代数の同型であること（積の保存）が必要であり、原文のように" +
          "「線型同型を一つ取る」だけでは Step 3・Step 4 が成立しない。<def_end_iso> を書き換えた理由はそちら参照。",
        "原文の statement は式のみで、両辺が F^{(±)} 上の写像として一致するという意味であることと" +
          "M の範囲が書かれていなかったため明示した（主張の内容自体は変えていない）。",
        "式変形の書き方の統一（2026-08-14）: 同一の点列の極限の一意性を散文中で圧縮していた箇所を、" +
          "三角不等式・二つの収束・ノルム零からの一致を一行ずつ根拠付きで示す鎖へ開いた。内容は変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_007_definition_V1_pm",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/006_definition_V1_plus_minusの定義.typ", ordinal: 7 },
    title: { tex: String.raw`V_1^{(+)} \text{ の定義}` },
    labels: ["def_V1_plus"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1,Y_m,Z_m`),
        " を用いて",
      ]),
      displayMath(
        String.raw`V_1^{(+)} := \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M_{\mathrm{col}}-1} Z_{M_{\mathrm{col}}} - Y_{M_{\mathrm{col}}} Z_1)\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\exp`),
        " は ",
        ref("def_end_iso"),
        " の同一視のもとでの ",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "参照のためラベル <def_V1_pm> を付け、M の範囲と exp の意味（<def_end_iso> の同一視による）を" +
          "明示した（定義の内容自体は変えていない）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_011a_definition_H1_pm",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`\text{一般生成子 } H_1^{(+)}` },
    labels: ["def_H1_plus"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        " とし、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_jordan_wigner_Y_matrices"),
        " と ",
        ref("def_jordan_wigner_Z_matrices"),
        " で定めた具体的な複素行列 ",
        math(String.raw`Y_m,Z_m\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`H_1^{(+)} := \sum_{m=1}^{M_{\mathrm{col}}-1} Y_m Z_{m+1} - Y_{M_{\mathrm{col}}} Z_1`,
      ),
      paragraph(["と定める。行列の積は ", ref("mat_mult"), " の成分表示による。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、一般生成子 H_1^{(±)} の定義だけを独立させた。端点を含めて曖昧さのない有限和で、元の式と同じ内容を記した。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_011b_definition_H2",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`\text{一般生成子 } H_2` },
    labels: ["def_H2"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_jordan_wigner_Z_matrices"),
        " と ",
        ref("def_jordan_wigner_Y_matrices"),
        " で定めた具体的な複素行列 ",
        math(String.raw`Z_m,Y_m\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用い、",
        math(String.raw`H_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を",
      ]),
      displayMath(String.raw`H_2 := \sum_{m=1}^{M_{\mathrm{col}}} Z_m Y_m`),
      paragraph(["と定める。行列の積は ", ref("mat_mult"), " の成分表示による。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、一般生成子 H_2 の定義だけを独立させた。端点を含めて曖昧さのない有限和で、元の式と同じ内容を記した。",
      ],
    },
  },
  {
    id: "transfer_matrix_011c_claim_V1_pm_exponential_representation",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`V_1^{(+)} \text{ の一般生成子による指数表示}` },
    labels: ["V1_plus_exponential_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 2}`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        "、および虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`V_1^{(+)}
= \exp\!\left(i K_1 H_1^{(+)}\right)`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_V1_plus"),
        " の表示中の ",
        math(String.raw`Y_1Z_2+Y_2Z_3+\cdots+Y_{M_{\mathrm{col}}-1}Z_{M_{\mathrm{col}}}`),
        " は、添字を省略しない有限和 ",
        math(String.raw`\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}`),
        " を表す。特に ",
        math(String.raw`M_{\mathrm{col}}=2`),
        " では一項 ",
        math(String.raw`Y_1Z_2`),
        " だけである。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
V_1^{(+)}
&=\exp\!\left(iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1}- Y_{M_{\mathrm{col}}}Z_1\right)\right)
&&(\because\ \text{第一転送行列の定義と上の有限和記法。}\blkref{def_V1_plus})\\
&=\exp\!\left(iK_1H_1^{(+)}\right)
&&(\because\ \text{一般生成子の定義。}\blkref{def_H1_plus})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、V1^{(±)} の指数表示だけを独立主張として分離した。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_011d_claim_V2_exponential_representation",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "_old/typst/parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ", ordinal: 11 },
    title: { tex: String.raw`V_2 \text{ の一般生成子による指数表示}` },
    labels: ["V2_exponential_representation"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        "、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_2^*,s_2\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        "、および虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_H2"),
        " の ",
        math(String.raw`H_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と同じ記号定義の ",
        math(String.raw`V_2\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
        ref("V2_in_Z_Y"),
        " と合わせると",
      ]),
      displayMath(
        String.raw`V_2
= (2s_2)^{M_{\mathrm{col}}/2} \exp\!\left(i K_2^* H_2\right)`,
      ),
    ],
    proof: [
      paragraph([
        ref("V2_in_Z_Y"),
        " の表示中の ",
        math(String.raw`Z_1Y_1+Z_2Y_2+\cdots+Z_{M_{\mathrm{col}}}Y_{M_{\mathrm{col}}}`),
        " は、添字を省略しない有限和 ",
        math(String.raw`\sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m`),
        " を表す。特に ",
        math(String.raw`M_{\mathrm{col}}=1`),
        " では一項 ",
        math(String.raw`Z_1Y_1`),
        " だけである。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
V_2
&=(2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*\sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m\right)
&&(\because\ \text{第二転送行列の Jordan--Wigner 表示と上の有限和記法。}\blkref{V2_in_Z_Y})\\
&=(2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)
&&(\because\ \text{一般生成子の定義。}\blkref{def_H2})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロック <def_H1_H2> から、V2 の指数表示だけを独立主張として分離した。",
      ],
    },
  },
  {
    id: "bridge_008_definition_epsilon_projectors",
    kind: "definition",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 10 },
    title: { tex: String.raw`\mathcal{F}^{(+)} \text{ への射影子 } P^{(+)}` },
    labels: ["def_epsilon_projectors"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`P^{(+)} := \tfrac{1}{2}\left(I + \varepsilon\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "bridge_009_claim_epsilon_projector_properties",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 11 },
    title: { tex: String.raw`P^{(+)} \text{ の性質}` },
    labels: ["epsilon_projector_properties"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \left(P^{(+)}\right)^2 = P^{(+)}`)],
        [
          math(String.raw`\text{(2)}\quad \mathrm{im}\,P^{(+)} := \left\{P^{(+)}x \;\middle|\; x\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\right\} = \mathcal{F}^{(+)}`),
        ],
      ]),
    ],
    proof: [
      paragraph(["(1)"]),
      displayMath(
        String.raw`\begin{aligned}
\left(P^{(+)}\right)^2
&= \tfrac{1}{4}\left(I + \varepsilon\right)\left(I + \varepsilon\right)
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{4}\left(I + \varepsilon + \varepsilon + \varepsilon^2\right)
   \quad (\because \text{分配法則と } I\varepsilon=\varepsilon I=\varepsilon) \\
&= \tfrac{1}{4}\left(I + 2\varepsilon + \varepsilon^2\right)
   \quad (\because \text{同類項をまとめる}) \\
&= \tfrac{1}{4}\left(2I + 2\varepsilon\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \tfrac{1}{2}\left(I + \varepsilon\right)
   \quad (\because \text{スカラー倍を整理する}) \\
&= P^{(+)}
   \quad (\because \blkref{def_epsilon_projectors})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\mathcal{F}^{(+)} = \{f \in \mathbb{C}^{2^{M_{\mathrm{col}}}} \mid \varepsilon f = f\}`),
        "（",
        math(String.raw`\varepsilon f`),
        " は行列と数ベクトルの積）である。",
      ]),
      paragraph([
        math(String.raw`(\subseteq)`),
        " ",
        math(String.raw`y \in \mathrm{im}\,P^{(+)}`),
        " とすると、ある ",
        math(String.raw`x\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " について ",
        math(String.raw`y = P^{(+)}x`),
        " と書ける。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}y
&= P^{(+)}P^{(+)}x
   \quad (\because y = P^{(+)}x) \\
&= \left(P^{(+)}\right)^2x
   \quad (\because \text{積の冪の表記}) \\
&= P^{(+)}x
   \quad (\because \text{(1) の冪等性}) \\
&= y
   \quad (\because y = P^{(+)}x)
\end{aligned}`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon y
&= \varepsilon P^{(+)} y
   \quad (\because \text{上の等式 } y = P^{(+)}y) \\
&= \varepsilon\cdot\tfrac{1}{2}\left(I + \varepsilon\right) y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(\varepsilon I + \varepsilon^2\right) y
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(\varepsilon + \varepsilon^2\right) y
   \quad (\because \varepsilon I=\varepsilon) \\
&= \tfrac{1}{2}\left(\varepsilon + I\right) y
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の } \varepsilon^2=I) \\
&= \tfrac{1}{2}\left(I + \varepsilon\right) y
   \quad (\because \text{行列の加法の可換性}) \\
&= P^{(+)}y
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= y
   \quad (\because \text{上の等式 } y = P^{(+)}y)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " により ",
        math(String.raw`y \in \mathcal{F}^{(+)}`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\supseteq)`),
        " ",
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " すなわち（",
        ref("def_even_eigenvectors_of_epsilon"),
        " により）",
        math(String.raw`\varepsilon f = f`),
        " とすると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)} f
&= \tfrac{1}{2}\left(I + \varepsilon\right) f
   \quad (\because \blkref{def_epsilon_projectors}) \\
&= \tfrac{1}{2}\left(If + \varepsilon f\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac{1}{2}\left(f + \varepsilon f\right)
   \quad (\because If=f) \\
&= \tfrac{1}{2}\left(f + f\right)
   \quad (\because \text{仮定 } \varepsilon f = f) \\
&= \tfrac{1}{2}\left(2f\right)
   \quad (\because \text{同類項をまとめる}) \\
&= f
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`f = P^{(+)}f \in \mathrm{im}\,P^{(+)}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: 各式変形の行末に残っていた根拠に対応するラベル参照を、各鎖の直後へ追加した。等式・不等式・場合分け・使用する根拠の内容は変えていない。",
        "式変形の書き方の統一（2026-09-03）: 各鎖の直後に置かれた参照段落を削り、参照を実際に使う各式変形行の行末の \\blkref へ移した。内容・式変形・根拠・参照は不変である。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。旧 (1) の P^{(+)}P^{(-)}=0 と旧 (2) の P^{(+)}+P^{(-)}=I を除き、旧 (3) を (2) とした。F^{(+)} の定義の参照先を <def_even_eigenvectors_of_epsilon> にし、像を数ベクトル空間 C^{2^M} の部分集合として書いた。",
      ],
    },
  },
  {
    id: "bridge_definition_V1_pm_square_root",
    kind: "definition",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 12 },
    title: { tex: String.raw`V_1^{(+)} \text{ の平方根として用いる行列}` },
    labels: ["def_V1_plus_square_root"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`K_1\in\mathbb{R}_{>0}\subset\mathbb{C}`),
        " と ",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いて",
      ]),
      displayMath(
        String.raw`\left(V_1^{(+)}\right)^{1/2}
:= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの可換性の主張で未定義のまま使われていた (V_1^{(\pm)})^{1/2} を、1 ブロック 1 定義に従って独立させた。二乗が V_1^{(\pm)} に等しいことは後続の平方根の主張で証明する。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。偶セクターの章にあった同じ行列の重複定義（exp((i/2)K_1H_1^{(+)}) の形）を削除してこのブロックを唯一の定義とし、式をその形にそろえた。ラベルを <def_V1_pm_square_root> から <def_V1_plus_square_root> に改めた。",
      ],
    },
  },
  {
    id: "evensectorT_definition_V_plus",
    kind: "definition",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 12 },
    title: { tex: String.raw`V^{(+)} := \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}` },
    labels: ["def_V_plus"],
    statement: [
      paragraph([
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        ref("V2_exponential_representation"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^* H_2\right)`),
        " を用いて",
      ]),
      displayMath(
        String.raw`V^{(+)} := \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。V^{(+)} の定義を偶セクターの章からこの章へ移し、唯一の定義とした（対称化転送行列の章が前方参照しないため）。",
      ],
    },
  },
  {
    id: "bridge_010_claim_epsilon_commutes",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 12 },
    title: { tex: String.raw`\varepsilon \text{ は } V_1, V_2, V_1^{(+)}, \left(V_1^{(+)}\right)^{1/2} \text{ と可換}` },
    labels: ["epsilon_commutes_with_transfer_matrices"],
    statement: [
      paragraph([
        math(String.raw`\varepsilon`),
        " は ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`V_1, V_2`),
        " および ",
        ref("def_V1_plus"),
        " の ",
        math(String.raw`V_1^{(+)}`),
        "、さらに ",
        ref("def_V1_plus_square_root"),
        " の ",
        math(String.raw`(V_1^{(+)})^{1/2}`),
        " と可換である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（サイト演算子との関係）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        "、",
        math(String.raw`\sigma^y\sigma^x = -\sigma^x\sigma^y`),
        "。相異なるサイトに置かれた因子どうしは可換（",
        ref("kronecker_product_rule"),
        " (1)）なので、",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_k^x
&= \sigma_k^x\,\varepsilon
   \quad (\because \sigma^x\sigma^x=I\text{ と、相異なるサイトの因子の可換性}) \\
\varepsilon\,\sigma_k^z
&= -\,\sigma_k^z\,\varepsilon
   \quad (\because \sigma^z\sigma^x=-\sigma^x\sigma^z\text{ と、相異なるサイトの因子の可換性}) \\
\varepsilon\,\sigma_k^y
&= -\,\sigma_k^y\,\varepsilon
   \quad (\because \sigma^y\sigma^x=-\sigma^x\sigma^y\text{ と、相異なるサイトの因子の可換性})
\qquad (k \in \{1,\dots,M_{\mathrm{col}}\})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\varepsilon`),
        " のうち第 ",
        math(String.raw`k`),
        " 因子の ",
        math(String.raw`\sigma^x`),
        " だけが ",
        math(String.raw`\sigma_k^a`),
        " と非可換になりうる。）",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`V_2`),
        " との可換性）。",
        math(String.raw`R := K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon R
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\varepsilon\,\sigma_m^x
   \quad (\because \text{スカラー倍との可換性と、行列積の有限和への分配}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\,\varepsilon
   \quad (\because \text{Step 1 の }\varepsilon\sigma_k^x=\sigma_k^x\varepsilon\text{ を全項へ同時適用}) \\
&= R\,\varepsilon
   \quad (\because \text{行列積の有限和への分配とスカラー倍との可換性})
\end{aligned}`,
      ),
      paragraph([
        "可換なら冪とも可換（",
        math(String.raw`\varepsilon R^p = R^p\varepsilon`),
        " が ",
        math(String.raw`p`),
        " についての帰納法で従う）ので、",
        ref("def_exp"),
        " の部分和とも可換であり、",
        ref("matrix_multiplication_continuity"),
        " による極限との交換から次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\exp(R)
&= \varepsilon\lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p}{p!}
   \quad (\because \exp\text{ の定義}) \\
&= \lim_{n\to\infty}\sum_{p=0}^{n}\frac{\varepsilon R^p}{p!}
   \quad (\because \text{行列積の連続性と有限和への分配}) \\
&= \lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p\varepsilon}{p!}
   \quad (\because \varepsilon R^p=R^p\varepsilon) \\
&= \left(\lim_{n\to\infty}\sum_{p=0}^{n}\frac{R^p}{p!}\right)\varepsilon
   \quad (\because \text{有限和への分配と行列積の連続性}) \\
&= \exp(R)\varepsilon
   \quad (\because \exp\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "スカラー ",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}`),
        " は ",
        ref("scalar_identity_commutes"),
        " より任意の行列と可換なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_2
&= \varepsilon\left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp(R)\right)
   \quad (\because \blkref{second_transfer_matrix_pauli_form}\text{ と }R\text{ の定義}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\left(\varepsilon\exp(R)\right)
   \quad (\because \text{スカラー倍との可換性}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\left(\exp(R)\,\varepsilon\right)
   \quad (\because \text{上の }\varepsilon\exp(R)=\exp(R)\varepsilon) \\
&= \left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp(R)\right)\varepsilon
   \quad (\because \text{スカラー倍との可換性}) \\
&= V_2\,\varepsilon
   \quad (\because \blkref{second_transfer_matrix_pauli_form}\text{ と }R\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`V_1`),
        " との可換性）。Step 1 より次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,\sigma_m^z\sigma_{m+1}^z
&= (-1)^2\,\sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because \sigma^z\text{ が二個なので、Step 1 の反可換性を二回適用}) \\
&= \sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because (-1)^2=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`D = \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        " と置くと、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon D
&= \sum_{m=1}^{M_{\mathrm{col}}}\varepsilon\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\,\varepsilon
   \quad (\because \text{上の }\varepsilon\,\sigma_m^z\sigma_{m+1}^z=\sigma_m^z\sigma_{m+1}^z\,\varepsilon\text{ を全項へ同時適用}) \\
&= D\,\varepsilon
   \quad (\because \text{行列積の有限和への分配})
\end{aligned}`,
      ),
      paragraph([
        "よって Step 2 と同じ冪・有限和・極限の議論で ",
        math(String.raw`\varepsilon\exp(K_1D)=\exp(K_1D)\varepsilon`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon V_1
&= \varepsilon\exp(K_1D)
   \quad (\because \blkref{first_transfer_matrix_pauli_form}\text{ と }D\text{ の定義}) \\
&= \exp(K_1D)\varepsilon
   \quad (\because \varepsilon\text{ と }\exp(K_1D)\text{ の可換性}) \\
&= V_1\varepsilon
   \quad (\because \blkref{first_transfer_matrix_pauli_form}\text{ と }D\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`V_1^{(+)}`),
        " との可換性）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " について、Step 1 より ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`\sigma_j^x`),
        " と可換、",
        math(String.raw`\sigma_m^z`),
        "・",
        math(String.raw`\sigma_m^y`),
        " とは反可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon Z_m
&= -\,Z_m\,\varepsilon
   \quad (\because \sigma_j^x\text{ との可換性と }\sigma_m^z\text{ との反可換性}) \\
\varepsilon Y_m
&= -\,Y_m\,\varepsilon
   \quad (\because \sigma_j^x\text{ との可換性と }\sigma_m^y\text{ との反可換性})
\end{aligned}`,
      ),
      paragraph([
        "よって次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,(Y_mZ_{m'})
&= (-1)^2 (Y_mZ_{m'})\,\varepsilon
   \quad (\because \varepsilon\text{ と }Y_m,Z_{m'}\text{ の反可換性を一回ずつ適用}) \\
&= (Y_mZ_{m'})\,\varepsilon
   \quad (\because (-1)^2=1)
\end{aligned}`,
      ),
      paragraph([
        ref("def_H1_plus"),
        " の ",
      ]),
      displayMath(
        String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`,
      ),
      paragraph([
        "は各項が ",
        math(String.raw`Y\cdot Z`),
        " の形なので、次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon H_1^{(+)}
&= \varepsilon\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because \blkref{def_H1_plus}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\varepsilon\,(Y_mZ_{m+1}) - \varepsilon\,(Y_{M_{\mathrm{col}}}Z_1)
   \quad (\because \text{行列積の有限和への分配}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}(Y_mZ_{m+1})\,\varepsilon - (Y_{M_{\mathrm{col}}}Z_1)\,\varepsilon
   \quad (\because \text{上の }\varepsilon\,(Y_mZ_{m'})=(Y_mZ_{m'})\,\varepsilon\text{ を全項へ同時適用}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)\varepsilon
   \quad (\because \text{行列積の有限和への分配}) \\
&= H_1^{(+)}\,\varepsilon
   \quad (\because \blkref{def_H1_plus})
\end{aligned}`,
      ),
      paragraph([
        "Step 2 と同じ議論で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`\exp(iK_1H_1^{(+)})`),
        " とも ",
        math(String.raw`\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)`),
        " とも可換である。",
        ref("V1_plus_exponential_representation"),
        " より前者は ",
        math(String.raw`V_1^{(+)}`),
        "、",
        ref("def_V1_plus_square_root"),
        " より後者は ",
        math(String.raw`(V_1^{(+)})^{1/2}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "式変形の書き方の統一（2026-08-14）: Step 2 末尾の散文に埋まっていたスカラー因子の付加（εV₂=V₂ε の導出）を、一行一等号と行末根拠の鎖へ開いた。等式・根拠の内容は変えていない。",
        "2026-09-01 の構成レビューで、後続の未ラベル定義にある H_1^{(\pm)} を先取りしていた箇所を、証明内の局所記号 G^{(\pm)} へ置き換えた。平方根の定義と射影の可換性は独立ブロックへ分けた。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。V_1, V_2 の参照先を <def_transfer_matrix> にし、パウリ行列表示を使う行の根拠を <first_transfer_matrix_pauli_form>・<second_transfer_matrix_pauli_form> にした。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "bridge_claim_epsilon_projectors_commute_with_transfer_matrices",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 12 },
    title: { tex: String.raw`P^{(+)} \text{ は転送行列と可換}` },
    labels: ["epsilon_projectors_commute_with_transfer_matrices"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        " は ",
        ref("epsilon_commutes_with_transfer_matrices"),
        " の ",
        math(String.raw`V_1,V_2,V_1^{(+)},(V_1^{(+)})^{1/2}`),
        " のすべてと可換である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を ",
        math(String.raw`\varepsilon X = X\varepsilon`),
        " を満たす行列とする（",
        ref("epsilon_commutes_with_transfer_matrices"),
        " より ",
        math(String.raw`V_1, V_2, V_1^{(+)}, (V_1^{(+)})^{1/2}`),
        " がこれにあたる）。次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}X
&= \tfrac12\left(I + \varepsilon\right)X
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(+)}\text{ の定義}) \\
&= \tfrac12\left(IX + \varepsilon X\right)
   \quad (\because \text{分配法則}) \\
&= \tfrac12\left(X + \varepsilon X\right)
   \quad (\because IX=X) \\
&= \tfrac12\left(X + X\varepsilon\right)
   \quad (\because \text{仮定 }\varepsilon X=X\varepsilon) \\
&= \tfrac12\left(XI + X\varepsilon\right)
   \quad (\because X=XI) \\
&= X\cdot\tfrac12\left(I + \varepsilon\right)
   \quad (\because \text{分配法則とスカラー倍との可換性}) \\
&= X\,P^{(+)}
   \quad (\because \blkref{def_epsilon_projectors}\ \text{の }P^{(+)}\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\varepsilon`),
        " と可換な行列は ",
        math(String.raw`P^{(+)}`),
        " とも可換である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "もとの epsilon_commutes_with_transfer_matrices の Step 5 を、1 ブロック 1 主張に従って独立させた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "maxeig_001_definition_transfer_matrix_square_root",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 3 },
    title: { tex: String.raw`V_1^{1/2} := \exp\!\left(\tfrac{1}{2}K_1D\right)` },
    labels: ["def_transfer_matrix_square_root"],
    statement: [
      paragraph([
        ref("first_transfer_matrix_pauli_form"),
        " の ",
        math(String.raw`V_1 = \exp(K_1 D)`),
        "（",
        math(String.raw`D := \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z`),
        "、",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z := \sigma_1^z`),
        "）について",
      ]),
      displayMath(
        String.raw`V_1^{1/2} := \exp\!\left(\tfrac{1}{2}K_1 D\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。",
        ref("theorem_exp_product"),
        " より ",
        math(String.raw`V_1^{1/2}V_1^{1/2} = \exp(K_1D) = V_1`),
        " であり、記号 ",
        math(String.raw`V_1^{1/2}`),
        " はこの意味での平方根である（",
        math(String.raw`\tfrac12 K_1D`),
        " は自分自身と可換）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。V_1 = exp(K_1 D) の参照先を <first_transfer_matrix_pauli_form> にした。",
      ],
    },
  },
  {
    id: "maxeig_001a_definition_symmetrized_transfer_matrix",
    kind: "definition",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 3 },
    title: { tex: String.raw`\text{対称化転送行列 } W` },
    labels: ["def_symmetrized_transfer_matrix"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_square_root"),
        " の ",
        math(String.raw`V_1^{1/2}`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2`),
        " を用いて",
      ]),
      displayMath(
        String.raw`W := V_1^{1/2}\,V_2\,V_1^{1/2}
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added" },
  },
  {
    id: "maxeig_claim_symmetrized_transfer_matrix_on_sectors",
    kind: "claim",
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    title: { tex: String.raw`W P^{(+)} = V^{(+)}P^{(+)}` },
    labels: ["symmetrized_transfer_matrix_on_sectors"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"), " の ", math(String.raw`W`),
        "、", ref("def_epsilon_projectors"), " の ", math(String.raw`P^{(+)}`),
        "、", ref("def_V_plus"), " の ", math(String.raw`V^{(+)}`),
        " について、次が成り立つ。",
      ]),
      displayMath(String.raw`W P^{(+)} = V^{(+)}P^{(+)}`),
    ],
    proof: [
      paragraph([
        math(String.raw`B:=V_1^{1/2}`), " は ", ref("def_transfer_matrix_square_root"),
        "、", math(String.raw`C:=(V_1^{(+)})^{1/2}`), " は ", ref("def_V1_plus_square_root"),
        " の行列とし、", math(String.raw`P:=P^{(+)}`), " と略記する。",
        ref("V1_restriction_to_eigenspaces"), " に結合定数 ", math(String.raw`K_1/2`),
        " を代入すると（右辺の指数の中身は ", ref("def_H1_plus"), " の ", math(String.raw`\tfrac{i}{2}K_1H_1^{(+)}`),
        " である）、任意の ", math(String.raw`f\in\mathcal F^{(+)}`),
        " について ", math(String.raw`Bf=Cf`), " を得る。",
        ref("epsilon_projector_properties"), " (2) より任意の ", math(String.raw`x\in\mathbb C^{2^{M_{\mathrm{col}}}}`),
        " に対して ", math(String.raw`Px\in\mathcal F^{(+)}`), " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
(BP)x
&=B(Px) &&(\because\ \text{行列積の結合則})\\
&=C(Px) &&(\because\ \blkref{V1_restriction_to_eigenspaces}\text{ に }K_1/2\text{ と }Px\text{ を代入})\\
&=(CP)x &&(\because\ \text{行列積の結合則}).
\end{aligned}`),
      paragraph([
        "すべての数ベクトルへの作用が等しいため ", math(String.raw`BP=CP`), " である。",
        ref("epsilon_projectors_commute_with_transfer_matrices"), " の ",
        math(String.raw`PC=CP`), " と ", math(String.raw`PV_2=V_2P`), " を用いると、",
      ]),
      displayMath(String.raw`\begin{aligned}
WP
&=BV_2BP &&(\because\ \blkref{def_symmetrized_transfer_matrix})\\
&=BV_2CP &&(\because\ BP=CP)\\
&=BV_2PC &&(\because\ \blkref{epsilon_projectors_commute_with_transfer_matrices}\text{ の }CP=PC)\\
&=BPV_2C &&(\because\ \blkref{epsilon_projectors_commute_with_transfer_matrices}\text{ の }V_2P=PV_2)\\
&=CPV_2C &&(\because\ BP=CP)\\
&=CV_2PC &&(\because\ \blkref{epsilon_projectors_commute_with_transfer_matrices}\text{ の }PV_2=V_2P)\\
&=CV_2CP &&(\because\ \blkref{epsilon_projectors_commute_with_transfer_matrices}\text{ の }PC=CP)\\
&=V^{(+)}P &&(\because\ \blkref{def_V_plus}).
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "セクター射影子による表示を上限の最大値分解から分離した。BP=CP と後続の等式鎖は一行ずつ SageMath 検査へ対応済みである。Lean では physicalSymTransferR_map_mul_epsProj_eq_Vsym として同じ九段を形式化済みである。有限個の浮動小数点計算の成功と形式証明は別の検証層として扱う。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。V^{(+)} の定義の参照先を <def_V_plus> にし、射影子の像の参照を <epsilon_projector_properties> (2) に直した。",
      ],
    },
  },
  {
    id: "projection_and_jordan_wigner_claim_symmetrized_transfer_matrix_on_sector_exponential_form",
    kind: "claim",
    standing: "mainTheorem",
    title: { tex: String.raw`W P^{(+)} \text{ の } H_1^{(+)},\ H_2 \text{ による指数表示}` },
    labels: ["symmetrized_transfer_matrix_on_sector_exponential_form"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " とし、虚数単位 ",
        math(String.raw`i\in\mathbb{C}`),
        " を用いる。",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        "、",
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(+)}`),
        "、",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        "、",
        ref("def_H2"),
        " の ",
        math(String.raw`H_2`),
        "（いずれも ",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " の元）と ",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        " について、",
      ]),
      displayMath(
        String.raw`W P^{(+)}
= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}`,
      ),
      paragraph([
        "が成り立つ。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_indexed_hyperbolic_abbreviations"),
        " の略記 ",
        math(String.raw`s_2 := \sinh 2K_2`),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W P^{(+)}
&= V^{(+)} P^{(+)}
&&(\because\ \blkref{symmetrized_transfer_matrix_on_sectors}) \\
&= \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2} P^{(+)}
&&(\because\ \blkref{def_V_plus}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) V_2 \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{def_V1_plus_square_root}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{V2_exponential_representation}) \\
&= \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(i K_2^* H_2\right)
  \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right) P^{(+)}
&&(\because\ \blkref{def_indexed_hyperbolic_abbreviations})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、ε の固有値 +1 の固有空間への射影と Jordan–Wigner 表示の章のゴールの式を一つの主張として立てた。既存の主張と定義を代入するだけで、新しい証明は無い。",
      ],
    },
  },
]);
