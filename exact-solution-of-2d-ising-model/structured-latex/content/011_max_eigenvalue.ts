import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/011_max_eigenvalue.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "転送行列の最大固有値と分配関数の挟み撃ち" },
    labels: [],
  },

  {
    id: "maxeig_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        ref("partition_function_in_pauli_form"),
        " により ",
        math(String.raw`Z(J,J') = \mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)`),
        " である。熱力学極限を取るには、この ",
        math(String.raw`N_{\mathrm{row}}`),
        " 乗のトレースを**最大固有値ひとつ**で挟み撃ちしたい。この章でそれを行う。",
      ]),
      paragraph([
        "得られる評価は、",
        math(String.raw`W := V_1^{1/2}V_2V_1^{1/2}`),
        "、",
        math(String.raw`c(M) := \sup\{\,x^{\top}Wx \mid x \in \mathbb{R}^{2^M},\ \|x\| = 1\,\}`),
        " として",
      ]),
      displayMath(
        String.raw`c(M)^{N_{\mathrm{row}}} \ \leq\ Z(J,J')\ \leq\ 2^{M}\,c(M)^{N_{\mathrm{row}}}`,
      ),
      paragraph([
        "である。**この章では固有値の存在（対角化可能性・スペクトル定理）を一切使わない。**",
        math(String.raw`c(M)`),
        " は上限として定義され、必要な不等式はすべて半正定値双線型形式に対する Cauchy–Schwarz の不等式から出る。",
        "有限次元の実対称行列が対角化できること自体は正しいが、その証明は本文にまだ無く、",
        "また挟み撃ちには不要だからである。",
      ]),
      paragraph([
        "あわせて、",
        math(String.raw`W`),
        " が ",
        math(String.raw`\varepsilon`),
        " の偶奇セクターを保つこと、および ",
        math(String.raw`c(M) = \max(c_+(M), c_-(M))`),
        "（各セクターでの上限）を示す。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_001_definition_transfer_matrix_square_root",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`V_1^{1/2} := \exp\!\left(\tfrac{1}{2}K_1D\right)` },
    labels: ["def_transfer_matrix_square_root"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_1 = \exp(K_1 D)`),
        "（",
        math(String.raw`D := \sum_{m=1}^{M}\sigma_m^z\sigma_{m+1}^z`),
        "、",
        math(String.raw`\sigma_{M+1}^z := \sigma_1^z`),
        "）について",
      ]),
      displayMath(
        String.raw`V_1^{1/2} := \exp\!\left(\tfrac{1}{2}K_1 D\right)
\in \mathrm{Mat}(2^M,\mathbb{C})`,
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
    conversion: { status: "added" },
  },

  {
    id: "maxeig_001a_definition_symmetrized_transfer_matrix",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
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
\in \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_002_claim_Z_equals_trace_of_W",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`Z = \mathrm{tr}(W^{N_{\mathrm{row}}})` },
    labels: ["Z_equals_trace_of_W"],
    statement: [
      paragraph([
        ref("partition_function_in_pauli_form"),
        " と同じ設定のもと、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{tr}\!\left((V_1V_2)^{n}\right) = \mathrm{tr}\!\left(W^{n}\right)`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`Z(J,J') = \mathrm{tr}\!\left(W^{N_{\mathrm{row}}}\right)`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`B := V_1^{1/2}`),
        " と略記する。",
        ref("def_transfer_matrix_square_root"),
        " より ",
        math(String.raw`BB = V_1`),
        " であり、",
        ref("def_symmetrized_transfer_matrix"),
        " より ",
        math(String.raw`W = BV_2B`),
        " である。トレースの巡回性は ",
        ref("trace_basic_properties"),
        " (2) のものである。次の等式鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left((V_1V_2)^{n}\right)
&= \mathrm{tr}\!\left(V_1\,\underbrace{(V_2\,V_1)(V_2\,V_1)\cdots(V_2\,V_1)}_{n-1\ \text{個}}\,V_2\right)
   \quad (\because \text{行列の積の結合法則で括り直す}) \\
&= \mathrm{tr}\!\left(V_1\left(V_2V_1\right)^{n-1}V_2\right)
   \quad (\because \text{冪の定義}) \\
&= \mathrm{tr}\!\left(B\,B\left(V_2V_1\right)^{n-1}V_2\right)
   \quad (\because V_1 = BB) \\
&= \mathrm{tr}\!\left(B\left(V_2V_1\right)^{n-1}V_2\,B\right)
   \quad (\because \text{巡回性 } \mathrm{tr}(AB)=\mathrm{tr}(BA)\ \text{を}\ A=B,\ B=B(V_2V_1)^{n-1}V_2\ \text{に適用}) \\
&= \mathrm{tr}\!\left(B\,\underbrace{(V_2\,BB)(V_2\,BB)\cdots(V_2\,BB)}_{n-1\ \text{個}}\,V_2\,B\right)
   \quad (\because V_1 = BB\ \text{と冪の定義}) \\
&= \mathrm{tr}\!\left((B V_2 B)^{n}\right)
   \quad (\because \text{行列の積の結合法則で括り直す}) \\
&= \mathrm{tr}\!\left(W^{n}\right)
   \quad (\because W = BV_2B)
\end{aligned}`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_003_claim_W_is_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`W \text{ は実対称正定値}` },
    labels: ["W_is_real_symmetric_positive_definite"],
    statement: [
      paragraph([
        math(String.raw`W`),
        " は成分がすべて実数で転置について対称であり、",
        ref("def_hermitian_positive_definite"),
        " の意味で正定値である。とくに ",
        math(String.raw`W`),
        " は可逆である。",
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
&=K_2^*\sum_{m=1}^{M}\sigma_m^x
  &&\bigl(\because\ \text{実対称性の主張の Step 1}\bigr)
\end{aligned}`),
      paragraph([
        "Step 2（指数関数）。",
        ref("def_hermitian_positive_definite"),
        " の最後の注意より実対称行列はエルミートなので、",
        ref("exp_hermitian_is_positive_definite"),
        " (1) より ",
        math(String.raw`B := \exp(\tfrac12 K_1D)`),
        " と ",
        math(String.raw`A := \exp(S_2)`),
        " はいずれもエルミートかつ正定値である。この ",
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
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`V_2 = (2s_2)^{M/2}A`),
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
&=B\bigl((2s_2)^{M/2}A\bigr)B
  &&\bigl(\because\ V_2=(2s_2)^{M/2}A\bigr)\\
&=(2s_2)^{M/2}B A B
  &&\bigl(\because\ \text{スカラー倍と行列積の結合則}\bigr)\\
&=(2s_2)^{M/2}B^{*}A B
  &&\bigl(\because\ B^*=B\bigr)
\end{aligned}`),
      paragraph([
        ref("exp_hermitian_is_positive_definite"),
        " (2) より ",
        math(String.raw`B^*AB`),
        " は正定値、",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " なので同 (3) より ",
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
        "可逆性：",
        math(String.raw`Wx = 0`),
        " と仮定すると、次の鎖を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
x^\top W x
&=x^\top(Wx)
  &&\bigl(\because\ \text{行列積の結合則}\bigr)\\
&=x^\top 0
  &&\bigl(\because\ Wx=0\bigr)\\
&=0
  &&\bigl(\because\ \text{零ベクトルとの積}\bigr)
\end{aligned}`),
      paragraph([
        "正定値性より ",
        math(String.raw`x = 0`),
        "。よって ",
        math(String.raw`W`),
        " の核は ",
        math(String.raw`\{0\}`),
        " であり ",
        math(String.raw`W`),
        " は可逆。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_004_claim_W_has_positive_entries",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`W \text{ の成分はすべて正}` },
    labels: ["W_has_positive_entries"],
    statement: [
      paragraph([
        ref("def_config_basis_iso"),
        " の同一視のもとで、",
        ref("def_symmetrized_transfer_matrix"),
        " で定めた ",
        math(String.raw`W`),
        " のすべての成分は正の実数である：",
      ]),
      displayMath(
        String.raw`W_{\iota(\mu),\iota(\mu')} > 0 \qquad (\mu,\mu' \in \mathfrak{M})`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`V_1^{1/2}`),
        " は正の対角行列）。以下、周期端では ",
        math(String.raw`\mu(M+1):=\mu(1)`),
        " と書く。",
        ref("def_transfer_matrix_square_root"),
        " の定義と ",
        ref("sigma_z_diagonal_action"),
        " より ",
        math(String.raw`D f_{\iota(\mu)} = \left(\sum_{m}\mu(m)\mu(m+1)\right)f_{\iota(\mu)}`),
        " なので ",
        math(String.raw`\tfrac12 K_1 D`),
        " は対角行列である。",
        ref("exp_of_diagonal_matrix"),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より",
      ]),
      displayMath(
        String.raw`\left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
= \begin{cases}
\exp\!\left(\tfrac{1}{2}K_1\sum_{m=1}^{M}\mu(m)\mu(m+1)\right) > 0 & (\mu = \mu') \\
0 & (\mu \neq \mu')
\end{cases}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`V_2`),
        " の成分は正）。",
        ref("V2_component_equals_pauli"),
        " より ",
        math(String.raw`(V_2)_{\iota(\mu),\iota(\mu')} = \exp\!\left(\sum_{m}K_2\,\mu(m)\mu'(m)\right)`),
        " である。指数は実数なので、",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より、この値は正である。",
      ]),
      paragraph(["Step 3。"]),
      displayMath(
        String.raw`\begin{aligned}
W_{\iota(\mu),\iota(\mu')}
&= \left(V_1^{1/2}\,V_2\,V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
   \quad (\because W = V_1^{1/2}V_2V_1^{1/2}) \\
&= \sum_{j=1}^{2^M}\sum_{k=1}^{2^M}
   \left(V_1^{1/2}\right)_{\iota(\mu),j}\left(V_2\right)_{j,k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{行列の積の定義}) \\
&= \sum_{k=1}^{2^M}
   \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}\left(V_2\right)_{\iota(\mu),k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } j\neq\iota(\mu)\ \text{の項は } 0) \\
&= \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}
   \left(V_2\right)_{\iota(\mu),\iota(\mu')}
   \left(V_1^{1/2}\right)_{\iota(\mu'),\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } k\neq\iota(\mu')\ \text{の項は } 0)
\end{aligned}`,
      ),
      paragraph([
        "3 つの因子はいずれも正の実数なので、積も正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この正値性は、最大固有値が偶セクター（ε の固有値 +1 の側）で達成されることの理由でもある（Perron–Frobenius）。本文ではその事実を使っていないが、docs/tasks/free-energy-roadmap に次章の指針として記録した。数値でも M=2,3,4 で最大が (+) セクターにあることを確認している。",
      ],
    },
  },

  {
    id: "maxeig_005_claim_psd_cauchy_schwarz",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: ["psd_cauchy_schwarz"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称かつ半正定値（",
        math(String.raw`\forall x \in \mathbb{R}^n : x^\top P x \geq 0`),
        "）とする。このとき任意の ",
        math(String.raw`x, y \in \mathbb{R}^n`),
        " について",
      ]),
      displayMath(
        String.raw`\left(y^\top P x\right)^2 \leq \left(x^\top P x\right)\left(y^\top P y\right)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        math(String.raw`q(t) := (y + t x)^\top P (y + t x)`),
        " と置く。半正定値性により、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について ",
        math(String.raw`0\leq q(t)`),
        " である。対称性を使って展開すると",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=(y+t x)^\top P(y+t x)
&&\bigl(\because\ q(t)\ \text{の定義}\bigr)\\
&=y^\top Py+t\,y^\top Px+t\,x^\top Py+t^2x^\top Px
&&\bigl(\because\ \text{転置・行列積の分配法則}\bigr)\\
&=y^\top Py+2t\,y^\top Px+t^2x^\top Px
&&\bigl(\because\ P^\top=P\ \text{より}\ x^\top Py=y^\top Px\bigr)\\
&=(x^\top Px)t^2+2(y^\top Px)t+y^\top Py
&&\bigl(\because\ \mathbb{R}\ \text{の加法と乗法の可換則}\bigr)
\end{aligned}`),
      paragraph([
        "(i) ",
        math(String.raw`a := x^\top Px > 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置き、",
        math(String.raw`t=-b/a`),
        " を上の式へ代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq q(-b/a)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)\\
&=a\left(-\frac{b}{a}\right)^2+2b\left(-\frac{b}{a}\right)+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示へ}\ t=-b/a\ \text{を代入}\bigr)\\
&=\frac{b^2}{a}-\frac{2b^2}{a}+y^\top Py
&&\bigl(\because\ a>0\ \text{より}\ a\neq0\bigr)\\
&=y^\top Py-\frac{b^2}{a}
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\frac{b^2}{a}
&\leq y^\top Py
&&\bigl(\because\ 0\leq y^\top Py-b^2/a\ \text{の移項}\bigr)\\
b^2
&\leq a\,(y^\top Py)
&&\bigl(\because\ a>0\ \text{を両辺へ掛ける}\bigr)
\end{aligned}`),
      paragraph([
        "(ii) ",
        math(String.raw`a = 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置くと、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=2bt+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示と}\ a=0\bigr)\\
0
&\leq q(t)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)
\end{aligned}`),
      paragraph([math(String.raw`b\neq0`), " と仮定し、", math(String.raw`t_0:=-(y^\top Py+1)/(2b)`), " と置くと"]),
      displayMath(String.raw`\begin{aligned}
q(t_0)
&=2b\left(-\frac{y^\top Py+1}{2b}\right)+y^\top Py
&&\bigl(\because\ q(t)=2bt+y^\top Py\ \text{へ}\ t=t_0\ \text{を代入}\bigr)\\
&=-(y^\top Py+1)+y^\top Py
&&\bigl(\because\ b\neq0\bigr)\\
&=-1
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&<0
&&\bigl(\because\ -1<0\bigr)
\end{aligned}`),
      paragraph(["これは半正定値性と矛盾するので ", math(String.raw`b=0`), " である。したがって"]),
      displayMath(String.raw`\begin{aligned}
(y^\top Px)^2
&=b^2
&&\bigl(\because\ b=y^\top Px\bigr)\\
&=0
&&\bigl(\because\ b=0\bigr)\\
&=(x^\top Px)(y^\top Py)
&&\bigl(\because\ a=x^\top Px=0\bigr)
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_006_definition_rayleigh_sup",
    kind: "definition",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`c(M) := \sup_{\|x\|=1} x^\top W x` },
    labels: ["def_rayleigh_sup"],
    statement: [
      paragraph([
        math(String.raw`W`),
        " は ",
        ref("W_is_real_symmetric_positive_definite"),
        " より実行列とみなせるので、",
      ]),
      displayMath(
        String.raw`\mathcal{R} := \left\{\, x^\top W x \ \middle|\ x \in \mathbb{R}^{2^M},\ \|x\| = 1 \,\right\} \subseteq \mathbb{R}_{>0}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\mathcal{R}`),
        " は空でなく（",
        math(String.raw`x = e_1`),
        " を取れる）、上に有界である。実際、",
        ref("psd_cauchy_schwarz"),
        " を ",
        math(String.raw`P = W`),
        "、",
        math(String.raw`y = x`),
        " として使うまでもなく、",
        math(String.raw`|x^\top Wx| \leq \|x\|\,\|Wx\| \leq \|W\|\,\|x\|^2 = \|W\|`),
        "（",
        ref("matrix_norm_vector_bound"),
        " と Cauchy–Schwarz）である。よって実数の上限",
      ]),
      displayMath(String.raw`c(M) := \sup \mathcal{R} \in \mathbb{R}_{>0}`),
      paragraph([
        "が定まる（上に有界な空でない実数集合は上限をもつ）。定義から",
      ]),
      displayMath(
        String.raw`x^\top W x \leq c(M)\,\|x\|^2 \qquad (\forall x \in \mathbb{R}^{2^M})`,
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
        math(String.raw`c(M)`),
        " だけで足りる。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_007_claim_operator_bound",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`\|Wx\| \leq c(M)\,\|x\|` },
    labels: ["rayleigh_bounds_operator_norm"],
    statement: [
      paragraph([
        math(String.raw`\forall x \in \mathbb{R}^{2^M}`),
        " について ",
        math(String.raw`\|Wx\| \leq c(M)\,\|x\|`),
        "。したがって ",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        " について ",
        math(String.raw`\|W^k x\| \leq c(M)^k\|x\|`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M)`),
        " と略記する。",
        math(String.raw`x \in \mathbb{R}^{2^M}`),
        " を取り、",
        math(String.raw`y := Wx`),
        " とおく。まず",
      ]),
      displayMath(String.raw`\begin{aligned}
\|Wx\|^2
&=(Wx)^\top(Wx)
&&\bigl(\because\ \text{ノルムの定義}\ \|v\|^2=v^\top v\bigr)\\
&=y^\top(Wx)
&&\bigl(\because\ y=Wx\ \text{の置き換え（左因子）}\bigr)
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
&&\bigl(\because\ \text{半正定値の Cauchy--Schwarz を}\ P=W\ \text{に適用}\bigr)\\
&\leq\left(c\|x\|^2\right)\left(y^\top Wy\right)
&&\bigl(\because\ \text{レイリー上限の評価}\ x^\top Wx\leq c\|x\|^2\ \text{と}\ 0\leq y^\top Wy\ \text{（半正定値性）}\bigr)\\
&\leq\left(c\|x\|^2\right)\left(c\|y\|^2\right)
&&\bigl(\because\ \text{レイリー上限の評価}\ y^\top Wy\leq c\|y\|^2\ \text{と}\ 0\leq c\|x\|^2\bigr)\\
&=c^2\|x\|^2\|Wx\|^2
&&\bigl(\because\ y=Wx\ \text{と}\ \mathbb{R}\ \text{の乗法の可換則・結合則}\bigr)
\end{aligned}`),
      paragraph([
        "である（半正定値の Cauchy--Schwarz は ",
        ref("psd_cauchy_schwarz"),
        "、レイリー上限の評価は ",
        ref("def_rayleigh_sup"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\|Wx\| = 0`),
        " なら主張は明らか。",
        math(String.raw`\|Wx\| > 0`),
        " なら両辺を ",
        math(String.raw`\|Wx\|^2 > 0`),
        " で割って ",
        math(String.raw`\|Wx\|^2 \leq c^2\|x\|^2`),
        "、平方根を取って ",
        math(String.raw`\|Wx\| \leq c\|x\|`),
        "（両辺非負）。",
      ]),
      paragraph([
        math(String.raw`k`),
        " についての主張は ",
        math(String.raw`k`),
        " に関する帰納法：",
        math(String.raw`\|W^{k+1}x\| = \|W(W^kx)\| \leq c\|W^kx\| \leq c\cdot c^k\|x\|`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_008_claim_trace_power_sandwich",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`c(M)^{n} \leq \mathrm{tr}(W^{n}) \leq 2^{M} c(M)^{n}` },
    labels: ["trace_power_sandwich"],
    statement: [
      paragraph([math(String.raw`n \in \mathbb{Z}_{\geq 1}`), " について"]),
      displayMath(
        String.raw`c(M)^{n} \ \leq\ \mathrm{tr}\!\left(W^{n}\right)\ \leq\ 2^{M}\,c(M)^{n}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`c := c(M)`),
        "、",
        math(String.raw`d := 2^M`),
        " と略記し、",
        math(String.raw`e_1,\dots,e_d`),
        " を標準基底とする。",
        math(String.raw`W`),
        " は実対称なので、その冪 ",
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
        "Step 1（上からの評価）。まず ",
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
&=2^M c^n
&&\bigl(\because\ d=2^M\ \text{（冒頭の略記）}\bigr)
\end{aligned}`),
      paragraph(["となり、上からの評価を得る。"]),
      paragraph([
        "Step 2（下からの評価の準備：モーメントの対数凸性）。単位ベクトル ",
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
      paragraph([
        "Step 3（下からの評価）。まず、任意の ",
        math(String.raw`k \geq 1`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{m_k}{m_{k-1}}
&=\frac{m_k^2}{m_{k-1}\,m_k}
&&\bigl(\because\ \text{分子と分母に }m_k>0\text{ を掛けた（Step 2 の正値性）}\bigr)\\
&\leq\frac{m_{k-1}\,m_{k+1}}{m_{k-1}\,m_k}
&&\bigl(\because\ \text{Step 2 の }m_k^2 \leq m_{k-1}m_{k+1}\text{ と、正の分母での商は順序を保つ}\bigr)\\
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
&&\bigl(\because\ \text{望遠鏡積（分母は Step 2 の正値性により零でない）}\bigr)\\
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
&&\bigl(\because\ |A_{kl}|\leq\sqrt{A_{kk}A_{ll}}\bigr)\\
&=\sum_{k,l=1}^{d}|x_k|\,|x_l|\sqrt{A_{kk}}\sqrt{A_{ll}}
&&\bigl(\because\ A_{kk},A_{ll}\geq0\text{ と平方根の積の法則}\bigr)\\
&=\left(\sum_{k=1}^{d}|x_k|\sqrt{A_{kk}}\right)^2
&&\bigl(\because\ \text{有限和の分配則}\bigr)\\
&\leq\left(\sum_{k=1}^{d}x_k^2\right)\left(\sum_{k=1}^{d}A_{kk}\right)
&&\bigl(\because\ \mathbb{R}^d\text{ の Cauchy--Schwarz}\bigr)\\
&=\|x\|^2\,\mathrm{tr}(A)
&&\bigl(\because\ \text{ノルムとトレースの定義}\bigr).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`|A_{kl}|`),
        " を評価する不等号は ",
        ref("psd_cauchy_schwarz"),
        " による ",
        math(String.raw`|A_{kl}| = |e_k^\top A e_l| \leq \sqrt{A_{kk}A_{ll}}`),
        " の適用である。これを ",
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
        "）。",
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
    origin: { path: SRC, ordinal: 11 },
    title: { text: "分配関数の挟み撃ち" },
    labels: ["partition_function_sandwich"],
    statement: [
      paragraph([
        ref("partition_function_in_pauli_form"),
        " と同じ設定のもと、",
        math(String.raw`N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        " について",
      ]),
      displayMath(
        String.raw`c(M)^{N_{\mathrm{row}}} \ \leq\ Z(J,J')\ \leq\ 2^{M}\,c(M)^{N_{\mathrm{row}}}`,
      ),
    ],
    proof: [
      paragraph([
        ref("Z_equals_trace_of_W"),
        " より ",
        math(String.raw`Z(J,J') = \mathrm{tr}(W^{N_{\mathrm{row}}})`),
        " であり、",
        ref("trace_power_sandwich"),
        " を ",
        math(String.raw`n = N_{\mathrm{row}}`),
        " として適用すればよい。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_010_claim_sector_decomposition_of_c",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`c(M) = \max\left(c_+(M), c_-(M)\right)` },
    labels: ["sector_decomposition_of_rayleigh_sup"],
    statement: [
      paragraph([
        ref("def_epsilon_projectors"),
        " の ",
        math(String.raw`P^{(\pm)}`),
        " と ",
        ref("def_eigenspaces_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathcal{R}_\pm := \left\{\, x^\top W x \ \middle|\ x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M},\ \|x\| = 1 \,\right\},
\qquad c_\pm(M) := \sup \mathcal{R}_\pm`,
      ),
      paragraph([
        "とおく（複号同順）。この上限が定まること、すなわち ",
        math(String.raw`\mathcal{R}_\pm`),
        " が空でなく上に有界であることを先に確かめる。上に有界なのは ",
        math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M} \subseteq \mathbb{R}^{2^M}`),
        " より ",
        math(String.raw`\mathcal{R}_\pm \subseteq \mathcal{R}`),
        "（",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        "）であり、",
        math(String.raw`\mathcal{R}`),
        " が ",
        math(String.raw`\|W\|`),
        " で上に有界だからである。空でないことは、",
        math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルを具体的に作れることから従う。",
      ]),
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix} \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`a_\pm := \frac{1}{\sqrt{2}}\begin{pmatrix}1 \\ \pm 1\end{pmatrix} \in \mathbb{R}^2,
\qquad
\sigma^x a_\pm = \frac{1}{\sqrt{2}}\begin{pmatrix}\pm 1 \\ 1\end{pmatrix} = \pm\,a_\pm`,
      ),
      paragraph([
        "とおき（右の等式は ",
        math(String.raw`2\times 2`),
        " 行列と ",
        math(String.raw`2`),
        " 次元数ベクトルの積の計算そのもの）、",
        ref("def_kronecker"),
        " (1) の数ベクトルのクロネッカー積で",
      ]),
      displayMath(
        String.raw`x^{(+)} := \overbrace{a_+ \boxtimes a_+ \boxtimes \cdots \boxtimes a_+}^{M},
\qquad
x^{(-)} := a_- \boxtimes \overbrace{a_+ \boxtimes \cdots \boxtimes a_+}^{M-1}
\quad \in \mathbb{R}^{2^M}`,
      ),
      paragraph([
        "と定める（",
        ref("def_kronecker"),
        " (1) より成分は各因子の成分の積だから、",
        math(String.raw`x^{(\pm)}`),
        " の各成分は ",
        math(String.raw`\pm 2^{-M/2}`),
        " という実数であり、とくに ",
        math(String.raw`x^{(\pm)} \in \mathbb{R}^{2^M}`),
        "）。",
        ref("def_eigenspaces_of_epsilon"),
        " の ",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " と ",
        ref("kronecker_product_rule"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,x^{(+)}
&= \left(\sigma^xa_+\right)\boxtimes\cdots\boxtimes\left(\sigma^xa_+\right)
= a_+\boxtimes\cdots\boxtimes a_+ = x^{(+)} \\
\varepsilon\,x^{(-)}
&= \left(\sigma^xa_-\right)\boxtimes\left(\sigma^xa_+\right)\boxtimes\cdots\boxtimes\left(\sigma^xa_+\right)
= \left(-a_-\right)\boxtimes a_+\boxtimes\cdots\boxtimes a_+
= -\,x^{(-)}
\end{aligned}`,
      ),
      paragraph([
        "（最後の等号は ",
        ref("def_kronecker"),
        " (1) の成分表示において第 1 因子の成分だけが ",
        math(String.raw`-1`),
        " 倍されることによる）。よって ",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`x^{(\pm)} \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}`),
        " である。さらに ",
        math(String.raw`x^{(\pm)}`),
        " の ",
        math(String.raw`2^M`),
        " 個の成分はすべて絶対値 ",
        math(String.raw`2^{-M/2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\left\|x^{(\pm)}\right\|^2
= \sum_{I \in \mathcal{I}_M}\left(2^{-M/2}\right)^2
= 2^M\cdot 2^{-M} = 1`,
      ),
      paragraph([
        "（",
        math(String.raw`\mathcal{I}_M`),
        " は ",
        ref("def_kronecker"),
        " の添字集合で ",
        math(String.raw`\#\mathcal{I}_M = 2^M`),
        "）。したがって ",
        math(String.raw`\left(x^{(\pm)}\right)^\top Wx^{(\pm)} \in \mathcal{R}_\pm`),
        " で ",
        math(String.raw`\mathcal{R}_\pm \neq \emptyset`),
        " であり、上限 ",
        math(String.raw`c_\pm(M) \in \mathbb{R}`),
        " が定まる。以上のもとで、",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \varepsilon W = W\varepsilon`), "、したがって ", math(String.raw`W`), " は ", math(String.raw`\mathcal{F}^{(\pm)}`), " を保つ"],
        [
          math(String.raw`\text{(2)}\quad W\,P^{(\pm)} = \left(V^{(\pm)}\right)P^{(\pm)}`),
          "（",
          math(String.raw`V^{(\pm)}`),
          " は ",
          ref("partition_function_sector_decomposition"),
          " のもの）",
        ],
        [math(String.raw`\text{(3)}\quad c(M) = \max\left(c_+(M),\, c_-(M)\right)`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 3 で ",
        math(String.raw`\varepsilon`),
        " が ",
        math(String.raw`D = \sum_m\sigma_m^z\sigma_{m+1}^z`),
        " と可換であることを示した。同 Step 2 と同じ議論（可換なら冪とも可換、部分和とも可換、極限とも可換）で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`V_1^{1/2} = \exp(\tfrac12 K_1D)`),
        " と可換であり、同 Step 2 より ",
        math(String.raw`V_2`),
        " とも可換である。よって次の等式鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon W
&= \varepsilon V_1^{1/2}V_2V_1^{1/2}
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}) \\
&= V_1^{1/2}\varepsilon V_2V_1^{1/2}
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= V_1^{1/2}V_2\varepsilon V_1^{1/2}
   \quad (\because \varepsilon V_2=V_2\varepsilon) \\
&= V_1^{1/2}V_2V_1^{1/2}\varepsilon
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= W\varepsilon
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f \in \mathcal{F}^{(\pm)}`),
        " とすると、",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f = \pm f`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(Wf)
&= (\varepsilon W)f
   \quad (\because \text{行列の積の結合則}) \\
&= (W\varepsilon)f
   \quad (\because \text{上の等式鎖 } \varepsilon W = W\varepsilon) \\
&= W(\varepsilon f)
   \quad (\because \text{行列の積の結合則}) \\
&= W(\pm f)
   \quad (\because \varepsilon f = \pm f) \\
&= \pm (Wf)
   \quad (\because \text{スカラー倍は行列の作用と交換する})
\end{aligned}`,
      ),
      paragraph([
        "なので ",
        math(String.raw`Wf \in \mathcal{F}^{(\pm)}`),
        "（",
        ref("def_eigenspaces_of_epsilon"),
        "）。",
      ]),
      paragraph([
        "(2) ",
        ref("sector_replacement_of_V1"),
        " の ",
        math(String.raw`V_1P^{(\pm)} = V_1^{(\pm)}P^{(\pm)}`),
        " と同じ議論を半分の冪について行う。",
        ref("V1_restriction_to_eigenspaces"),
        " は ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " 上で ",
        math(String.raw`V_1`),
        " と ",
        math(String.raw`V_1^{(\pm)}`),
        " が一致することを主張しているが、これは指数の中身 ",
        math(String.raw`K_1D`),
        " と ",
        math(String.raw`iK_1H_1^{(\pm)}`),
        " が ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " 上で一致することから従っている。同じ一致から ",
        math(String.raw`\tfrac12`),
        " 倍しても一致し、",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " が両者で保たれるので、級数の各項が一致して",
      ]),
      displayMath(
        String.raw`V_1^{1/2}P^{(\pm)} = \left(V_1^{(\pm)}\right)^{1/2}P^{(\pm)}`,
      ),
      paragraph([
        math(String.raw`P^{(\pm)}`),
        " は ",
        ref("epsilon_projectors_commute_with_transfer_matrices"),
        " より ",
        math(String.raw`V_2`),
        " とも ",
        math(String.raw`(V_1^{(\pm)})^{1/2}`),
        " とも可換、(1) より ",
        math(String.raw`V_1^{1/2}`),
        " とも可換であり、",
        ref("epsilon_projector_properties"),
        " (2) より ",
        math(String.raw`\left(P^{(\pm)}\right)^2 = P^{(\pm)}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
W P^{(\pm)}
&= V_1^{1/2}V_2V_1^{1/2}P^{(\pm)}
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}) \\
&= \left(V_1^{1/2}P^{(\pm)}\right)V_2\left(V_1^{1/2}P^{(\pm)}\right)
   \quad (\because P^{(\pm)}\text{ の可換性と }(P^{(\pm)})^2=P^{(\pm)}) \\
&= \left(\left(V_1^{(\pm)}\right)^{1/2}P^{(\pm)}\right)
   V_2
   \left(\left(V_1^{(\pm)}\right)^{1/2}P^{(\pm)}\right)
   \quad (\because V_1^{1/2}P^{(\pm)}=(V_1^{(\pm)})^{1/2}P^{(\pm)}\text{ を二箇所へ適用する}) \\
&= \left(V_1^{(\pm)}\right)^{1/2}V_2\left(V_1^{(\pm)}\right)^{1/2}P^{(\pm)}
   \quad (\because P^{(\pm)}\text{ の可換性と }(P^{(\pm)})^2=P^{(\pm)}) \\
&= V^{(\pm)}P^{(\pm)}
   \quad (\because V^{(\pm)}=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2}).
\end{aligned}`,
      ),
      paragraph([
        "（途中で ",
        math(String.raw`P^{(\pm)}`),
        " を可換性で移動させ、",
        math(String.raw`P^{(\pm)}P^{(\pm)} = P^{(\pm)}`),
        " でまとめた。）",
      ]),
      paragraph([
        "(3) ",
        ref("epsilon_projector_properties"),
        " (3) より、任意の ",
        math(String.raw`x \in \mathbb{R}^{2^M}`),
        " は ",
        math(String.raw`x = x_+ + x_-`),
        "（",
        math(String.raw`x_\pm := P^{(\pm)}x \in \mathcal{F}^{(\pm)}`),
        "）と分解される。",
        math(String.raw`\varepsilon`),
        " は実対称（置換行列であり ",
        math(String.raw`\varepsilon^\top = \varepsilon`),
        "）なので ",
        math(String.raw`P^{(\pm)}`),
        " も実対称であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x_+^\top x_-
&= \left(P^{(+)}x\right)^\top\left(P^{(-)}x\right)
   \quad (\because x_\pm = P^{(\pm)}x \text{ の定義}) \\
&= x^\top \left(P^{(+)}\right)^\top P^{(-)}x
   \quad (\because \text{転置の積の法則 } (AB)^\top = B^\top A^\top \text{ と結合則}) \\
&= x^\top P^{(+)}P^{(-)}x
   \quad (\because P^{(+)} \text{ は実対称: } (P^{(+)})^\top = P^{(+)}) \\
&= x^\top\, 0\, x
   \quad (\because P^{(+)}P^{(-)} = 0) \\
&= 0
   \quad (\because \text{零行列の作用})
\end{aligned}`,
      ),
      paragraph([
        "（",
        ref("epsilon_projector_properties"),
        " (2)）。よって ",
        math(String.raw`\|x\|^2 = \|x_+\|^2 + \|x_-\|^2`),
        "。また (1) より ",
        math(String.raw`Wx_\pm \in \mathcal{F}^{(\pm)}`),
        " なので、同じ直交性から交叉項が消えて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top Wx
&=(x_++x_-)^\top W(x_++x_-)
  \quad (\because x=x_++x_- \text{ を左右へ代入する})\\
&=(x_++x_-)^\top(Wx_++Wx_-)
  \quad (\because \text{行列の作用の分配則})\\
&=x_+^\top Wx_+ + x_+^\top Wx_- + x_-^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{転置と内積の分配則})\\
&=x_+^\top Wx_+ + 0 + 0 + x_-^\top Wx_-
  \quad (\because x_+,Wx_+\in\mathcal F^{(+)}\text{ と }x_-,Wx_-\in\mathcal F^{(-)}\text{ の直交性})\\
&=x_+^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{零は加法単位元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`c_\pm := c_\pm(M)`),
        " の定義より ",
        math(String.raw`x_\pm^\top Wx_\pm \leq c_\pm\|x_\pm\|^2`),
        " なので、",
        math(String.raw`\|x\| = 1`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top Wx
&= x_+^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{上の交叉項の消去})\\
&\leq c_+\|x_+\|^2 + x_-^\top Wx_-
  \quad (\because x_+^\top Wx_+ \leq c_+\|x_+\|^2 \text{ を第一項へ適用する})\\
&\leq c_+\|x_+\|^2 + c_-\|x_-\|^2
  \quad (\because x_-^\top Wx_- \leq c_-\|x_-\|^2 \text{ を第二項へ適用する})\\
&\leq \max(c_+,c_-)\|x_+\|^2 + \max(c_+,c_-)\|x_-\|^2
  \quad (\because c_\pm \leq \max(c_+,c_-) \text{ と } \|x_\pm\|^2 \geq 0 \text{ の積の単調性})\\
&= \max(c_+,c_-)\left(\|x_+\|^2+\|x_-\|^2\right)
  \quad (\because \text{分配則})\\
&= \max(c_+,c_-)\,\|x\|^2
  \quad (\because \|x\|^2 = \|x_+\|^2 + \|x_-\|^2 \text{ を上で示した})\\
&= \max(c_+,c_-)
  \quad (\because \|x\| = 1)
\end{aligned}`,
      ),
      paragraph([
        "上限を取って ",
        math(String.raw`c(M) \leq \max(c_+,c_-)`),
        "。逆に、",
        math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルは ",
        math(String.raw`\mathbb{R}^{2^M}`),
        " の単位ベクトルでもあるので ",
        math(String.raw`\mathcal{R}_\pm \subseteq \mathcal{R}`),
        " である（上でこの集合が空でないことも確かめた）。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_\pm
&= \sup \mathcal{R}_\pm
  \quad (\because c_\pm \text{ の定義})\\
&\leq \sup \mathcal{R}
  \quad (\because \mathcal{R}_\pm \subseteq \mathcal{R} \text{ と上限の単調性})\\
&= c(M)
  \quad (\because c(M) \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["両方の符号について成り立つので、"]),
      displayMath(
        String.raw`\begin{aligned}
\max(c_+,c_-)
&\leq c(M)
  \quad (\because c_+\leq c(M) \text{ かつ } c_-\leq c(M))\\
&\leq \max(c_+,c_-)
  \quad (\because \text{上で示したレイリー商の上界})
\end{aligned}`,
      ),
      paragraph(["よって等号が成り立つ。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "c_±(M) を上限として定義するために必要な「集合 R_± が空でなく上に有界であること」を statement 側で明示した（def_rayleigh_sup と同じ流儀）。空でないことは a_± := (1, ±1)^T/√2 のクロネッカー積で F^{(±)} ∩ R^{2^M} の単位ベクトルを具体的に構成して示す。章 019 の epsilon_is_sign_flip_permutation (4) も F^{(-)} の単位ベクトルを構成しているが、そちらは後の章なので参照せず、この章より前に確立している def_kronecker / kronecker_product_rule / pauli_matrix_products / def_eigenspaces_of_epsilon だけで閉じる形にした。",
        "(2) により c_-(M) は eigenvalues_of_V の Λ_ε のうち、固有ベクトルが F^{(-)} に属するものの上限である。c_+(M) に対応する V^{(+)} の固有値は本文では未確立（半整数運動量が要る）。この点は docs/tasks/free-energy-roadmap に章 C' として記録した。",
      ],
    },
  },
]);
