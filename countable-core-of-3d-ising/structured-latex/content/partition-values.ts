/**
 * 帰無モデルの値の恒等式。
 *
 * 有限集合の数え上げと整係数多項式だけを使う。非可算な量は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "partition_values_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 分配多項式の 1 での値" },
    labels: [],
  },

  {
    id: "partition_values_definition_partition_polynomial",
    kind: "definition",
    title: { text: "自由境界の分配多項式" },
    labels: ["def_partition_polynomial"],
    habitat: "Z",
    statement: [
      paragraph([
        "不定元 ",
        math(String.raw`X`),
        " を取り、自由境界の多重度（",
        ref("def_multiplicity"),
        "）から整係数多項式",
      ]),
      displayMath(
        String.raw`Z_L(X)=\sum_{m=0}^{\#E_L}\Omega_L(m)X^m\ \in\ \mathbb Z[X]`,
      ),
      paragraph([
        "を定め、自由境界の分配多項式と呼ぶ。和は ",
        math(String.raw`0\le m\le\#E_L`),
        " の有限個の自然数係数だけを含む。多項式 ",
        math(String.raw`Z_L(X)\in\mathbb Z[X]`),
        " と、その整数値 ",
        math(String.raw`Z_L(1)\in\mathbb Z`),
        " を区別する。",
      ]),
    ],
  },

  {
    id: "partition_values_claim_value_at_one",
    kind: "claim",
    title: { text: "分配多項式の 1 での値は配位の個数である" },
    labels: ["claim_partition_value_at_one"],
    habitat: "N",
    statement: [
      paragraph(["自然数の等式"]),
      displayMath(String.raw`Z_L(1)=2^{\#V_L}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "各配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " の破れ数 ",
        math(String.raw`m_L(\sigma)`),
        " は、ちょうど一つの自然数 ",
        math(String.raw`m\in\{0,1,\ldots,\#E_L\}`),
        " に等しい（",
        ref("def_broken_count"),
        "）。したがって、多重度が数える有限集合は互いに重ならず、合わせると ",
        math(String.raw`\Sigma_L`),
        " になる（",
        ref("def_multiplicity"),
        "）。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_L(1)
&=\sum_{m=0}^{\#E_L}\Omega_L(m)1^m
&&(\because\ \blkref{def_partition_polynomial})\\
&=\sum_{m=0}^{\#E_L}\Omega_L(m)
&&(\because\ 1^m=1)\\
&=\#\Sigma_L
&&(\because\ \text{上記の互いに重ならない分割})\\
&=2^{\#V_L}
&&(\because\ \blkref{def_configuration})
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
  },

  {
    id: "partition_coefficients_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 分配多項式の係数の非負性" },
    labels: [],
  },

  {
    id: "partition_coefficients_claim_nonnegative",
    kind: "claim",
    title: { text: "分配多項式の各係数は非負である" },
    labels: ["claim_partition_coefficients_nonnegative"],
    habitat: "Z",
    statement: [
      paragraph([
        "自然数 ",
        math(String.raw`m\in\{0,1,\ldots,\#E_L\}`),
        " に対し、",
      ]),
      displayMath(
        String.raw`[X^m]Z_L(X)=\Omega_L(m)\in\mathbb N\subset\mathbb Z`,
      ),
      paragraph([
        "が成り立つ。したがって、整係数多項式 ",
        math(String.raw`Z_L(X)`),
        " の各係数は非負である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`[X^m]P(X)`),
        " は整係数多項式 ",
        math(String.raw`P(X)`),
        " の ",
        math(String.raw`X^m`),
        " の係数を表す。また、",
        math(String.raw`\delta_{r,m}`),
        " は ",
        math(String.raw`r=m`),
        " のとき 1、そうでないとき 0 である。すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[X^m]Z_L(X)
&=[X^m]\sum_{r=0}^{\#E_L}\Omega_L(r)X^r
&&(\because\ \blkref{def_partition_polynomial})\\
&=\sum_{r=0}^{\#E_L}\Omega_L(r)\delta_{r,m}
&&(\because\ \text{係数を取る写像の有限和に対する加法性})\\
&=\Omega_L(m)
&&(\because\ 0\le m\le\#E_L)\\
&\in\mathbb N
&&(\because\ \blkref{def_multiplicity})
\end{aligned}`,
      ),
      paragraph(["となる。"]),
    ],
  },

  {
    id: "partition_support_endpoints_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 分配多項式の台の両端" },
    labels: [],
  },

  {
    id: "partition_support_endpoints_claim",
    kind: "claim",
    title: { text: "分配多項式の台の両端は 0 と辺の本数である" },
    labels: ["claim_partition_support_endpoints"],
    habitat: "Z",
    statement: [
      paragraph(["自由境界の分配多項式の両端の係数は"]),
      displayMath(
        String.raw`[X^0]Z_L(X)=\Omega_L(0)\ge2,\qquad
[X^{\#E_L}]Z_L(X)=\Omega_L(\#E_L)\ge2`,
      ),
      paragraph([
        "を満たす。したがって、係数が非零である最小の次数は ",
        math(String.raw`0`),
        "、最大の次数は ",
        math(String.raw`\#E_L`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "すべての点で値 ",
        math(String.raw`+1`),
        " を取る配位を ",
        math(String.raw`\sigma^+`),
        "、すべての点で値 ",
        math(String.raw`-1`),
        " を取る配位を ",
        math(String.raw`\sigma^-`),
        " と置く（",
        ref("def_configuration"),
        "）。箱には点 ",
        math(String.raw`(0,0,0)`),
        " が属するので、この二つの配位は異なる。",
      ]),
      paragraph([
        "各辺の両端で定数配位の値は等しい。したがって、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_L(\sigma^+)&=\varnothing
&&(\because\ \blkref{def_broken_count})\\
m_L(\sigma^+)&=0
&&(\because\ \blkref{def_broken_count})\\
D_L(\sigma^-)&=\varnothing
&&(\because\ \blkref{def_broken_count})\\
m_L(\sigma^-)&=0
&&(\because\ \blkref{def_broken_count})
\end{aligned}`,
      ),
      paragraph([
        "である。破れ数が ",
        math(String.raw`0`),
        " の水準集合は相異なる二つの配位 ",
        math(String.raw`\sigma^+,\sigma^-`),
        " を含むので、",
        math(String.raw`\Omega_L(0)\ge2`),
        " である（",
        ref("def_multiplicity"),
        "）。",
      ]),
      paragraph([
        "奇数側だけ反転する全単射 ",
        math(String.raw`T`),
        "（",
        ref("claim_odd_flip_involution"),
        "）をこの二つの配位に適用する。すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
m_L(T\sigma^+)
&=\#E_L-m_L(\sigma^+)
&&(\because\ \blkref{claim_broken_complement})\\
&=\#E_L
&&(\because\ m_L(\sigma^+)=0)\\
m_L(T\sigma^-)
&=\#E_L-m_L(\sigma^-)
&&(\because\ \blkref{claim_broken_complement})\\
&=\#E_L
&&(\because\ m_L(\sigma^-)=0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T`),
        " は単射で ",
        math(String.raw`\sigma^+\ne\sigma^-`),
        " なので、",
        math(String.raw`T\sigma^+\ne T\sigma^-`),
        " である。よって破れ数が ",
        math(String.raw`\#E_L`),
        " の水準集合も相異なる二つの配位を含み、",
        math(String.raw`\Omega_L(\#E_L)\ge2`),
        " である（",
        ref("def_multiplicity"),
        "）。",
      ]),
      paragraph([
        "係数と多重度の一致（",
        ref("claim_partition_coefficients_nonnegative"),
        "）を次数 ",
        math(String.raw`0`),
        " と ",
        math(String.raw`\#E_L`),
        " に適用すると、主張した二つの係数の等式と非零性を得る。さらに ",
        math(String.raw`Z_L(X)`),
        " の定義は次数 ",
        math(String.raw`0`),
        " から ",
        math(String.raw`\#E_L`),
        " までの有限和なので、これより小さい次数または大きい次数の項は無い（",
        ref("def_partition_polynomial"),
        "）。したがって台の両端はそれぞれ ",
        math(String.raw`0`),
        " と ",
        math(String.raw`\#E_L`),
        " である。",
      ]),
    ],
  },

  {
    id: "global_spin_flip_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 全スピン反転による多重度の偶数性" },
    labels: [],
  },

  {
    id: "global_spin_flip_definition",
    kind: "definition",
    title: { text: "全スピン反転" },
    labels: ["def_global_spin_flip"],
    habitat: "Z",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " に対して、配位 ",
        math(String.raw`F\sigma\in\Sigma_L`),
        " を各点 ",
        math(String.raw`a\in V_L`),
        " で",
      ]),
      displayMath(String.raw`(F\sigma)(a)=-\sigma(a)`),
      paragraph([
        "と定める。値 ",
        math(String.raw`\sigma(a)`),
        " は整数 ",
        math(String.raw`+1`),
        " または ",
        math(String.raw`-1`),
        " なので、",
        math(String.raw`-\sigma(a)`),
        " も同じ二元集合に属する。",
      ]),
    ],
  },

  {
    id: "global_spin_flip_claim_even_multiplicity",
    kind: "claim",
    title: { text: "各破れ数の多重度は偶数である" },
    labels: ["claim_even_multiplicity"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての自然数 ",
        math(String.raw`m\in\{0,1,\ldots,\#E_L\}`),
        " に対して、ある自然数 ",
        math(String.raw`k_m\in\mathbb N`),
        " が存在して",
      ]),
      displayMath(String.raw`\Omega_L(m)=2k_m`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "まず、全スピン反転（",
        ref("def_global_spin_flip"),
        "）を二回適用すると、各点 ",
        math(String.raw`a\in V_L`),
        " で",
      ]),
      displayMath(
        String.raw`(F(F\sigma))(a)=-(-\sigma(a))=\sigma(a)
\qquad(\because\ \blkref{def_global_spin_flip}\ \text{を二回適用})`,
      ),
      paragraph([
        "となる。したがって ",
        math(String.raw`F(F\sigma)=\sigma`),
        " であり、",
        math(String.raw`F:\Sigma_L\to\Sigma_L`),
        " は対合である。",
      ]),
      paragraph([
        "次に、辺 ",
        math(String.raw`e\in E_L`),
        " を任意に取る。両端の二つの値をともに符号反転しても、等しいか異なるかは変わらない。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_L(F\sigma)
&=\{\,e\in E_L:(F\sigma)(\partial_0e)\ne(F\sigma)(\partial_1e)\,\}
&&(\because\ \blkref{def_broken_count})\\
&=\{\,e\in E_L:-\sigma(\partial_0e)\ne-\sigma(\partial_1e)\,\}
&&(\because\ \blkref{def_global_spin_flip})\\
&=\{\,e\in E_L:\sigma(\partial_0e)\ne\sigma(\partial_1e)\,\}
&&(\because\ \text{整数の等式の両辺を }-1\text{ 倍しても同値})\\
&=D_L(\sigma)
&&(\because\ \blkref{def_broken_count})
\end{aligned}`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
m_L(F\sigma)
&=\#D_L(F\sigma)
&&(\because\ \blkref{def_broken_count})\\
&=\#D_L(\sigma)
&&(\because\ \text{前段の集合の等式})\\
&=m_L(\sigma)
&&(\because\ \blkref{def_broken_count})
\end{aligned}`,
      ),
      paragraph([
        "である。ゆえに ",
        math(String.raw`S_m=\{\,\sigma\in\Sigma_L:m_L(\sigma)=m\,\}`),
        " と置くと、",
        math(String.raw`F`),
        " は有限集合 ",
        math(String.raw`S_m`),
        " 上の対合を定める。",
      ]),
      paragraph([
        "この対合に不動点は無い。実際、点 ",
        math(String.raw`a_0=(0,0,0)\in V_L`),
        " において ",
        math(String.raw`\sigma(a_0)\in\{+1,-1\}`),
        " なので ",
        math(String.raw`-\sigma(a_0)\ne\sigma(a_0)`),
        " である。したがって ",
        math(String.raw`F\sigma\ne\sigma`),
        " である。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`\sigma\in S_m`),
        " に対する二元集合 ",
        math(String.raw`\{\sigma,F\sigma\}`),
        " を集めた有限集合を ",
        math(String.raw`\mathcal P_m`),
        " と置く。二つの二元集合が元を共有すれば、共有する元が元の配位かその反転かで場合分けし、",
        math(String.raw`F(F\sigma)=\sigma`),
        " を使うと二つの集合は等しい。したがって、異なる二元集合は互いに交わらない。不動点が無いので各集合の元は二つであり、これらを合わせると ",
        math(String.raw`S_m`),
        " になる。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Omega_L(m)
&=\#S_m
&&(\because\ \blkref{def_multiplicity})\\
&=2\cdot\#\mathcal P_m
&&(\because\ S_m\ \text{は互いに交わらない二元集合の合併})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k_m=\#\mathcal P_m\in\mathbb N`),
        " と取れば主張を得る。",
      ]),
    ],
  },

  {
    id: "galois_bound_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: Galois 群の上限" },
    labels: [],
  },

  {
    id: "galois_bound_definition_nonfixed_roots",
    kind: "definition",
    title: { text: "逆数写像の固定根を除いた根の集合" },
    labels: ["def_nonfixed_reciprocal_roots"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "自由境界の分配多項式 ",
        math(String.raw`Z_L(X)`),
        " の相異なる根から ",
        math(String.raw`+1,-1`),
        " を除いた有限集合を",
      ]),
      displayMath(
        String.raw`R_L=\{\,\alpha\in\overline{\mathbb Q}:Z_L(\alpha)=0,\ \alpha\ne1,\ \alpha\ne-1\,\}`,
      ),
      paragraph([
        "と定める。重複根は一度だけ含める。",
        math(String.raw`K_L\subset\overline{\mathbb Q}`),
        " を ",
        math(String.raw`Z_L(X)`),
        " の分解体とし、",
        math(String.raw`G_L=\operatorname{Aut}_{\mathbb Q}(K_L)`),
        " と置く。これらは代数的数の有限集合・有限次代数拡大・有限置換群に属し、非可算への脱出を含まない。",
      ]),
    ],
  },

  {
    id: "galois_bound_claim_hyperoctahedral",
    kind: "claim",
    title: { text: "Galois 群は逆数対の置換群に埋め込まれる" },
    labels: ["claim_galois_hyperoctahedral_bound"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "ある自然数 ",
        math(String.raw`r_L\in\mathbb N`),
        " が存在して、",
        math(String.raw`R_L`),
        " は ",
        math(String.raw`r_L`),
        " 個の互いに交わらない逆数対 ",
        math(String.raw`\{\alpha,\alpha^{-1}\}`),
        " の合併である。さらに ",
        math(String.raw`G_L`),
        " の各元は逆数対を置換し、各対の中では二元を保つか交換する。したがって、作用による準同型は単射であり、",
      ]),
      displayMath(String.raw`G_L\hookrightarrow C_2\wr\mathfrak S_{r_L}`),
      paragraph([
        "を得る。右辺は ",
        math(String.raw`r_L`),
        " 個の二元対を保つ置換全体、すなわち超八面体群である。根 ",
        math(String.raw`-1`),
        " が存在する場合も、それは有理数なので分解体を広げず、この作用から除いてよい。",
      ]),
    ],
    proof: [
      paragraph(["まず回文性から"]),
      displayMath(
        String.raw`\begin{aligned}
X^{\#E_L}Z_L(X^{-1})
&=X^{\#E_L}\sum_{m=0}^{\#E_L}\Omega_L(m)X^{-m}
&& (\because\ \blkref{def_partition_polynomial})\\
&=\sum_{m=0}^{\#E_L}\Omega_L(m)X^{\#E_L-m}
&& (\because\ \text{有限和の各項を掛ける})\\
&=\sum_{m=0}^{\#E_L}\Omega_L(\#E_L-m)X^{\#E_L-m}
&& (\because\ \blkref{claim_palindrome})\\
&=Z_L(X)
&& (\because\ \blkref{def_partition_polynomial}\ \text{の有限和の添字を逆順にする})
\end{aligned}`,
      ),
      paragraph([
        "となる。定数項は ",
        math(String.raw`\Omega_L(0)\ge2`),
        " なので 0 は根でない（",
        ref("claim_partition_support_endpoints"),
        "）。よって ",
        math(String.raw`\alpha`),
        " が根なら ",
        math(String.raw`\alpha\ne0`),
        " であり、前段の等式へ ",
        math(String.raw`X=\alpha`),
        " を代入すると ",
        math(String.raw`\alpha^{\#E_L}\,Z_L(\alpha^{-1})=Z_L(\alpha)=0`),
        " となる。体 ",
        math(String.raw`\overline{\mathbb Q}`),
        " に零因子は無く ",
        math(String.raw`\alpha^{\#E_L}\ne0`),
        " なので ",
        math(String.raw`Z_L(\alpha^{-1})=0`),
        " を得る。",
      ]),
      paragraph([
        math(String.raw`R_L`),
        " では ",
        math(String.raw`\alpha=\alpha^{-1}`),
        " なら ",
        math(String.raw`\alpha^2=1`),
        "、したがって ",
        math(String.raw`\alpha\in\{1,-1\}`),
        " となり定義に反する。ゆえに逆数写像は ",
        math(String.raw`R_L`),
        " 上で不動点を持たない対合である。有限集合上の不動点を持たない対合の軌道は相異なる二元集合なので、ある ",
        math(String.raw`r_L\in\mathbb N`),
        " に対して主張の逆数対への分割を得る。",
      ]),
      paragraph([
        math(String.raw`g\in G_L`),
        " と ",
        math(String.raw`\alpha\in R_L`),
        " を取る。係数が有理数なので ",
        math(String.raw`Z_L(g(\alpha))=g(Z_L(\alpha))=0`),
        " である。また体の自己同型は積と 1 を保つので",
      ]),
      displayMath(
        String.raw`g(\alpha^{-1})g(\alpha)=g(\alpha^{-1}\alpha)=g(1)=1`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`g(\alpha^{-1})=g(\alpha)^{-1}`),
        " である。ゆえに ",
        math(String.raw`g`),
        " は逆数対を逆数対へ送る。これは ",
        math(String.raw`G_L`),
        " から超八面体群への準同型を与える。分解体 ",
        math(String.raw`K_L`),
        " は全ての根で生成され、除いた根 ",
        math(String.raw`1,-1`),
        " は有理数で各自己同型が固定する。したがって ",
        math(String.raw`R_L`),
        " の全元を固定する自己同型は ",
        math(String.raw`K_L`),
        " の全元を固定し、恒等写像である。よって準同型は単射である。",
      ]),
    ],
  },
]);
