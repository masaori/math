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

  {
    id: "rational_values_heading",
    kind: "heading",
    level: 1,
    title: { text: "有理点の値が分配多項式を決める" },
    labels: [],
  },

  {
    id: "rational_values_definition_prime_exponent_data",
    kind: "definition",
    title: { text: "正の有理数の素指数データ" },
    labels: ["def_positive_rational_prime_exponent_data"],
    habitat: "Lambda",
    statement: [
      paragraph([
        "正の有理数 ",
        math(String.raw`a\in\mathbb Q_{>0}`),
        " と素数 ",
        math(String.raw`p`),
        " に対し、分子に現れる ",
        math(String.raw`p`),
        " の指数から分母に現れる指数を引いた整数を ",
        math(String.raw`v_p(a)\in\mathbb Z`),
        " とする。有限個を除く素数ではこの整数は 0 である。",
      ]),
      displayMath(
        String.raw`\lambda(a)=(v_p(a))_{p\ \mathrm{prime}}\in\bigoplus_{p\ \mathrm{prime}}\mathbb Z=: \Lambda`,
      ),
      paragraph([
        "を ",
        math(String.raw`a`),
        " の素指数データと呼ぶ。素因数分解の一意性により、正の有理数 ",
        math(String.raw`a,b`),
        " について ",
        math(String.raw`\lambda(a)=\lambda(b)`),
        " なら ",
        math(String.raw`a=b`),
        " である。ここでは実対数を用いない。",
      ]),
    ],
  },

  {
    id: "rational_values_claim_determine_partition_polynomial",
    kind: "claim",
    title: { text: "相異なる有理点の素指数データは分配多項式を一意に決める" },
    labels: ["claim_rational_values_determine_partition_polynomial"],
    habitat: "Lambda",
    statement: [
      paragraph([
        math(String.raw`d_L=\#E_L\in\mathbb N`),
        " と置き、相異なる正の有理数 ",
        math(String.raw`q_0,q_1,\ldots,q_{d_L}\in\mathbb Q_{>0}`),
        " を取る。このとき有限個のデータ",
      ]),
      displayMath(
        String.raw`\bigl(q_i,\lambda(Z_L(q_i))\bigr)_{0\le i\le d_L}`,
      ),
      paragraph([
        "は ",
        math(String.raw`Z_L(X)\in\mathbb Z[X]`),
        " を一意に決める。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ",
        math(String.raw`0\le i\le d_L`),
        " について、係数の非負性と定数項 ",
        math(String.raw`\Omega_L(0)\ge2`),
        " から ",
        math(String.raw`Z_L(q_i)\in\mathbb Q_{>0}`),
        " である（",
        ref("claim_partition_coefficients_nonnegative"),
        "、",
        ref("claim_partition_support_endpoints"),
        "）。したがって素指数データが定義される。",
      ]),
      paragraph([
        math(String.raw`A(X),B(X)\in\mathbb Q[X]`),
        " はともに次数が ",
        math(String.raw`d_L`),
        " 以下で、全ての ",
        math(String.raw`0\le i\le d_L`),
        " について ",
        math(String.raw`A(q_i),B(q_i)\in\mathbb Q_{>0}`),
        " かつ",
      ]),
      displayMath(String.raw`\lambda(A(q_i))=\lambda(B(q_i))=\lambda(Z_L(q_i))`),
      paragraph([
        "を満たすと仮定する。素因数分解の一意性（",
        ref("def_positive_rational_prime_exponent_data"),
        "）により、各 ",
        math(String.raw`i`),
        " について ",
        math(String.raw`A(q_i)=B(q_i)`),
        " である。よって ",
        math(String.raw`A(X)-B(X)`),
        " は相異なる ",
        math(String.raw`d_L+1`),
        " 個の根 ",
        math(String.raw`q_0,\ldots,q_{d_L}`),
        " を持つ。一方、零多項式でなければその次数は ",
        math(String.raw`d_L`),
        " 以下なので、体上の非零多項式の根の個数は次数以下であることに反する。したがって",
      ]),
      displayMath(String.raw`A(X)-B(X)=0`),
      paragraph([
        "すなわち ",
        math(String.raw`A(X)=B(X)`),
        " である。分配多項式は定義から次数が ",
        math(String.raw`d_L`),
        " 以下なので（",
        ref("def_partition_polynomial"),
        "）、与えた有限データから一意に決まる。",
      ]),
    ],
  },

  {
    id: "univariate_loss_heading",
    kind: "heading",
    level: 1,
    title: { text: "単変数化で潰れる二点データ" },
    labels: [],
  },

  {
    id: "univariate_loss_definition_signed_pair_polynomial",
    kind: "definition",
    title: { text: "標識した二点の符号付き多項式" },
    labels: ["def_signed_pair_polynomial"],
    habitat: "Z",
    statement: [
      paragraph([
        "自由境界の箱の相異なる二点 ",
        math(String.raw`u,v\in V_L`),
        " を標識する。各 ",
        math(String.raw`0\le m\le\#E_L`),
        " について",
      ]),
      displayMath(
        String.raw`C_{L;u,v}(m)=\#\{\sigma:m_L(\sigma)=m,\ \sigma(u)=\sigma(v)\}-\#\{\sigma:m_L(\sigma)=m,\ \sigma(u)\ne\sigma(v)\}\in\mathbb Z`,
      ),
      paragraph(["と定め、有限和"]),
      displayMath(
        String.raw`P_{L;u,v}(X)=\sum_{m=0}^{\#E_L}C_{L;u,v}(m)X^m\in\mathbb Z[X]`,
      ),
      paragraph([
        "を標識した二点の符号付き多項式と呼ぶ。これは点対ごとの一致配位数と不一致配位数の差を保存する有限の二点データである。標識を忘れる写像は ",
        math(String.raw`P_{L;u,v}(X)`),
        " を捨て、",
        ref("def_partition_polynomial"),
        " の ",
        math(String.raw`Z_L(X)`),
        " だけを残す。",
      ]),
    ],
  },

  {
    id: "univariate_loss_claim_same_partition_different_pair_data",
    kind: "claim",
    title: { text: "同じ分配多項式は異なる二点データを区別しない" },
    labels: ["claim_same_partition_different_pair_data"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`L=2`),
        " の自由境界の箱で ",
        math(String.raw`a=(0,0,0)`),
        "、",
        math(String.raw`b=(1,0,0)`),
        "、",
        math(String.raw`c=(1,1,1)`),
        " と置く。点対 ",
        math(String.raw`(a,b)`),
        " を標識した箱と点対 ",
        math(String.raw`(a,c)`),
        " を標識した箱は同じ分配多項式 ",
        math(String.raw`Z_2(X)`),
        " を持つが、",
        math(String.raw`P_{2;a,b}(X)\ne P_{2;a,c}(X)`),
        " である。したがって単変数の分配多項式だけから、標識した二点の有限データは決まらない。",
      ]),
    ],
    proof: [
      paragraph([
        "二つの標識付き箱は頂点集合、辺集合、配位集合、破れ数を変えず、標識した点対だけが異なる。よって ",
        ref("def_partition_polynomial"),
        " から両者の分配多項式は同じ ",
        math(String.raw`Z_2(X)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`V_2=\{0,1\}^3`),
        " の各配位を八つの頂点値の組として有限列挙する。十二本の辺のうち破れた辺が四本である配位を、標識点の値が一致するものと異なるものに分けると、次の整数になる。",
      ]),
      displayMath(
        String.raw`\begin{array}{c|cc|c}
\text{標識点対}&\#\{\sigma:m_2(\sigma)=4,\ \sigma(u)=\sigma(v)\}&\#\{\sigma:m_2(\sigma)=4,\ \sigma(u)\ne\sigma(v)\}&C_{2;u,v}(4)\\ \hline
(a,b)&20&10&20-10=10\\
(a,c)&12&18&12-18=-6
\end{array}`,
      ),
      paragraph([
        ref("def_signed_pair_polynomial"),
        " により、",
        math(String.raw`P_{2;a,b}(X)`),
        " の四次係数は ",
        math(String.raw`10`),
        "、",
        math(String.raw`P_{2;a,c}(X)`),
        " の四次係数は ",
        math(String.raw`-6`),
        " である。係数が異なるので二つの整係数多項式は等しくない。",
      ]),
    ],
  },

  {
    id: "splitting_data_loss_heading",
    kind: "heading",
    level: 1,
    title: { text: "分解体の次数と Galois 群で潰れる多項式の情報" },
    labels: [],
  },

  {
    id: "splitting_data_loss_claim_linear_counterexample",
    kind: "claim",
    title: { text: "分解体の次数と Galois 群だけでは多項式を決めない" },
    labels: ["claim_splitting_degree_galois_group_do_not_determine_polynomial"],
    habitat: "Q",
    statement: [
      paragraph([
        "有理係数多項式の分解体の次数と Galois 群を与えても、もとの多項式は一意に決まらない。",
      ]),
    ],
    proof: [
      paragraph(["相異なる二つの有理係数多項式"]),
      displayMath(String.raw`A(X)=X-1,\qquad B(X)=X-2\qquad\in\mathbb Q[X]`),
      paragraph([
        "を取る。定数係数はそれぞれ ",
        math(String.raw`-1`),
        " と ",
        math(String.raw`-2`),
        " なので、",
        math(String.raw`A(X)\ne B(X)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`A(X)`),
        " の根は有理数 ",
        math(String.raw`1`),
        "、",
        math(String.raw`B(X)`),
        " の根は有理数 ",
        math(String.raw`2`),
        " である。したがって、どちらも ",
        math(String.raw`\mathbb Q`),
        " 上で既に一次式へ分解し、どちらの分解体も ",
        math(String.raw`\mathbb Q`),
        " である。よって、どちらの分解体の次数も ",
        math(String.raw`[\mathbb Q:\mathbb Q]=1`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\mathbb Q`),
        " を各点で固定する ",
        math(String.raw`\mathbb Q`),
        " 自己同型は恒等写像だけなので、どちらの Galois 群も一元群である。相異なる ",
        math(String.raw`A(X)`),
        " と ",
        math(String.raw`B(X)`),
        " が同じ分解体の次数と同型な Galois 群を持つため、これら二つのデータだけでは多項式を決めない。",
      ]),
    ],
  },

  {
    id: "discriminant_data_loss_heading",
    kind: "heading",
    level: 1,
    title: { text: "判別式で潰れる多項式の情報" },
    labels: [],
  },

  {
    id: "discriminant_data_loss_claim_quadratic_counterexample",
    kind: "claim",
    title: { text: "判別式だけでは多項式を決めない" },
    labels: ["claim_discriminant_does_not_determine_polynomial"],
    habitat: "Z",
    statement: [
      paragraph([
        "整係数多項式の判別式を与えても、もとの多項式は一意に決まらない。",
        "この反例では二つの多項式がともに重複因子を持たないので、多項式自身の判別式と square-free 部分の判別式は一致する。",
      ]),
    ],
    proof: [
      paragraph(["相異なる二つの整係数多項式"]),
      displayMath(String.raw`A(X)=X^2-X,\qquad B(X)=X^2+X\qquad\in\mathbb Z[X]`),
      paragraph([
        "を取る。一次係数はそれぞれ ",
        math(String.raw`-1`),
        " と ",
        math(String.raw`1`),
        " なので、",
        math(String.raw`A(X)\ne B(X)`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A(X)&=X(X-1)
&&(\because\ \text{分配法則})\\
B(X)&=X(X+1)
&&(\because\ \text{分配法則})
\end{aligned}`,
      ),
      paragraph([
        "各積の二つの一次因子は相異なるので、",
        math(String.raw`A(X)`),
        " と ",
        math(String.raw`B(X)`),
        " はともに重複因子を持たない。したがって、それぞれの square-free 部分は多項式自身である。",
      ]),
      paragraph([
        "二次式 ",
        math(String.raw`aX^2+bX+c`),
        " の判別式を整数 ",
        math(String.raw`b^2-4ac`),
        " として計算すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\operatorname{disc}(A)&=(-1)^2-4\cdot1\cdot0
&&(\because\ A(X)=1\cdot X^2+(-1)\cdot X+0)\\
&=1
&&(\because\ \text{整数の四則演算})\\
\operatorname{disc}(B)&=1^2-4\cdot1\cdot0
&&(\because\ B(X)=1\cdot X^2+1\cdot X+0)\\
&=1
&&(\because\ \text{整数の四則演算})
\end{aligned}`,
      ),
      paragraph([
        "相異なる ",
        math(String.raw`A(X)`),
        " と ",
        math(String.raw`B(X)`),
        " が同じ判別式を持つため、判別式だけでは多項式を決めない。",
      ]),
    ],
  },

  {
    id: "irreducible_factor_degrees_heading",
    kind: "heading",
    level: 1,
    title: { text: "既約分解から決まる零点の次数" },
    labels: [],
  },

  {
    id: "irreducible_factor_degrees_claim_root_minimal_degrees",
    kind: "claim",
    title: { text: "既約分解の型が零点の最小多項式次数を決める" },
    labels: ["claim_factorization_type_determines_root_minimal_degrees"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "非零の整係数多項式 ",
        math(String.raw`F(X)`),
        " の有理数体上の既約分解を",
      ]),
      displayMath(
        String.raw`F(X)=c\prod_{j\in J}P_j(X)^{e_j}`,
      ),
      paragraph([
        "とする。ここで ",
        math(String.raw`J`),
        " は有限集合、",
        math(String.raw`c\in\mathbb Z\setminus\{0\}`),
        "、各 ",
        math(String.raw`P_j(X)\in\mathbb Z[X]`),
        " は原始的で最高次係数が正の相異なる非定数既約多項式、",
        math(String.raw`e_j\in\mathbb N`),
        " は正とする。このとき、代数的重複度を込めた各零点の最小多項式次数の多重集合は、各 ",
        math(String.raw`j\in J`),
        " について ",
        math(String.raw`\deg P_j`),
        " を ",
        math(String.raw`e_j\deg P_j`),
        " 個並べた多重集合である。したがって、この多重集合は既約因子の次数と重複度だけで決まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in J`),
        " を一つ固定する。",
        math(String.raw`P_j`),
        " は有理数体上既約なので、その任意の零点 ",
        math(String.raw`\alpha\in\overline{\mathbb Q}`),
        " のモニック最小多項式は ",
        math(String.raw`P_j`),
        " を最高次係数で割った多項式である。よって",
      ]),
      displayMath(
        String.raw`\deg\operatorname{minpoly}_{\mathbb Q}(\alpha)=\deg P_j
\qquad(\because\ \mathbb Q[X]\text{ における最小多項式の一意性})`,
      ),
      paragraph([
        "有理数体の標数は ",
        math(String.raw`0`),
        " なので、既約多項式 ",
        math(String.raw`P_j`),
        " は重根を持たない。したがって、",
        math(String.raw`P_j`),
        " は ",
        math(String.raw`\deg P_j`),
        " 個の相異なる零点を持つ。",
      ]),
      paragraph([
        math(String.raw`F`),
        " において因子 ",
        math(String.raw`P_j`),
        " は ",
        math(String.raw`e_j`),
        " 回現れるので、これら各零点の ",
        math(String.raw`F`),
        " における代数的重複度は ",
        math(String.raw`e_j`),
        " である。よって次数 ",
        math(String.raw`\deg P_j`),
        " は、代数的重複度を込めると ",
        math(String.raw`e_j\deg P_j`),
        " 回現れる。",
      ]),
      paragraph([
        "相異なる既約因子は共通の零点を持たないので、",
        math(String.raw`j\in J`),
        " ごとに得た有限多重集合を合わせれば、",
        math(String.raw`F`),
        " の全零点を代数的重複度込みでちょうど一度ずつ数える。以上から主張が従う。",
      ]),
    ],
  },

  {
    id: "polynomial_root_data_heading",
    kind: "heading",
    level: 1,
    title: { text: "零点と係数データによる多項式の決定" },
    labels: [],
  },

  {
    id: "polynomial_root_data_claim_distinct_roots_insufficient",
    kind: "claim",
    title: { text: "相異なる零点だけでは多項式を決めない" },
    labels: ["claim_distinct_roots_do_not_determine_polynomial"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "相異なる零点の有限集合だけから、非零の代数的数係数多項式は一意に決まらない。",
        "最高次係数を落とす反例と、零点の代数的重複度を落とす反例がそれぞれ存在する。",
      ]),
    ],
    proof: [
      paragraph(["最高次係数を落とす反例として、二つの多項式"]),
      displayMath(String.raw`A(X)=X-1,\qquad B(X)=2X-2\quad\in\overline{\mathbb Q}[X]`),
      paragraph(["を取る。係数を比較すると"]),
      displayMath(
        String.raw`[X]A(X)=1\ne2=[X]B(X)
\qquad(\because\ \text{一次係数の比較})`,
      ),
      paragraph(["なので、", math(String.raw`A(X)\ne B(X)`), " である。一方、"]),
      displayMath(
        String.raw`A(1)=0,\qquad B(1)=0
\qquad(\because\ \text{代入による有限な四則演算})`,
      ),
      paragraph([
        math(String.raw`A`),
        " と ",
        math(String.raw`B`),
        " はともに次数 ",
        math(String.raw`1`),
        " なので、相異なる零点の集合はどちらも ",
        math(String.raw`\{1\}`),
        " である。",
      ]),
      paragraph(["零点の代数的重複度を落とす反例として、二つの多項式"]),
      displayMath(String.raw`C(X)=X-1,\qquad D(X)=(X-1)^2\quad\in\overline{\mathbb Q}[X]`),
      paragraph(["を取る。次数を比較すると"]),
      displayMath(
        String.raw`\deg C=1\ne2=\deg D
\qquad(\because\ \text{非零多項式の積の次数})`,
      ),
      paragraph(["なので、", math(String.raw`C(X)\ne D(X)`), " である。一方、"]),
      displayMath(
        String.raw`C(1)=0,\qquad D(1)=0
\qquad(\because\ \text{代入による有限な四則演算})`,
      ),
      paragraph([
        math(String.raw`C`),
        " の次数は ",
        math(String.raw`1`),
        "、",
        math(String.raw`D`),
        " は一次因子 ",
        math(String.raw`X-1`),
        " の有限積なので、相異なる零点の集合はどちらも ",
        math(String.raw`\{1\}`),
        " である。以上の二つの有限な反例から主張が従う。",
      ]),
    ],
  },

  {
    id: "polynomial_root_data_claim_leading_coefficient_and_multiplicities_determine",
    kind: "claim",
    title: { text: "最高次係数と重複度を加えれば多項式が決まる" },
    labels: ["claim_roots_leading_coefficient_multiplicities_determine_polynomial"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "非定数多項式 ",
        math(String.raw`F(X)\in\overline{\mathbb Q}[X]`),
        " の相異なる零点の有限集合を ",
        math(String.raw`R`),
        "、零点 ",
        math(String.raw`r\in R`),
        " の正の代数的重複度を ",
        math(String.raw`\mu(r)\in\mathbb N`),
        "、最高次係数を ",
        math(String.raw`c\in\overline{\mathbb Q}\setminus\{0\}`),
        " とする。この有限データは ",
        math(String.raw`F`),
        " を一意に決め、具体的には",
      ]),
      displayMath(String.raw`F(X)=c\prod_{r\in R}(X-r)^{\mu(r)}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\overline{\mathbb Q}`),
        " は代数的閉体なので、非定数多項式を一次因子へ有限回分解できる。",
        "相異なる零点を一度ずつ ",
        math(String.raw`R`),
        " に集め、各一次因子の出現回数を ",
        math(String.raw`\mu(r)`),
        " とすると、零点と代数的重複度の定義から、ある非零係数 ",
        math(String.raw`d\in\overline{\mathbb Q}\setminus\{0\}`),
        " について",
      ]),
      displayMath(
        String.raw`F(X)=d\prod_{r\in R}(X-r)^{\mu(r)}
\qquad(\because\ \overline{\mathbb Q}[X]\ \text{における有限な一次因子分解})`,
      ),
      paragraph([
        "各因子 ",
        math(String.raw`(X-r)^{\mu(r)}`),
        " の最高次係数は ",
        math(String.raw`1`),
        " なので、その有限積の最高次係数も ",
        math(String.raw`1`),
        " である。したがって右辺の最高次係数は ",
        math(String.raw`d`),
        " である。",
      ]),
      displayMath(
        String.raw`d=c
\qquad(\because\ F\ \text{の最高次係数は}\ c)`,
      ),
      paragraph([
        "これを直前の有限積表示へ代入すると主張の表示を得る。右辺は ",
        math(String.raw`R`),
        "、",
        math(String.raw`\mu`),
        "、",
        math(String.raw`c`),
        " だけで定まるので、同じ三つの有限データを持つ二つの多項式は等しい。",
      ]),
    ],
  },

  {
    id: "two_dimensional_prediction_filter_heading",
    kind: "heading",
    level: 1,
    title: { text: "2 次元の有限式による測定候補の選別" },
    labels: [],
  },

  {
    id: "two_dimensional_prediction_filter_remark",
    kind: "remark",
    title: { text: "代数的不変量には測定前の予言が得られない" },
    labels: ["remark_two_dimensional_prediction_filter"],
    habitat: "Qbar",
    statement: [
      paragraph([
        "2 次元側で有限の式として得られているのは、整係数の分配多項式、代数的数からなるその零点、",
        "四つの境界条件を混合する双対恒等式、および双対変換の固定点を定める二次方程式である。",
        "最初の二つは有限グラフの定義から次元によらず得られ、後の二つは 2 次元の双対辺写像と境界条件の混合に依存する。",
      ]),
      paragraph([
        "したがって、この有限式から 3 次元の自由境界族について、既約因子の次数と重複度、判別式、",
        "分解体の次数と Galois 群、零点の最小多項式次数のいずれにも具体的な全称命題は導けない。",
        "これら四つは測定前に何を検査するかを定められないため、次の厳密測定の候補から落とす。",
        "この候補選別で挙げた測定量はこの四つで尽きるので、残る厳密測定の対象は無い。",
        "零点・代数的重複度・最高次係数から多項式を復元できることは ",
        ref("claim_roots_leading_coefficient_multiplicities_determine_polynomial"),
        " の有限代数の一般則であり、2 次元の式が 3 次元について与える追加の予言ではない。",
      ]),
    ],
  },

  {
    id: "boundary_response_measurement_heading",
    kind: "heading",
    level: 1,
    title: { text: "箱の包含に沿う測定量の選び直し" },
    labels: [],
  },

  {
    id: "boundary_response_measurement_definition",
    kind: "definition",
    title: { text: "境界応答多項式" },
    labels: ["def_boundary_response_polynomial"],
    habitat: "Z",
    statement: [
      paragraph([
        "自由境界の二つの箱の点集合が ",
        math(String.raw`V_{L'}\subset V_L`),
        " を満たすとする。大きい箱の辺のうち少なくとも一方の端点が ",
        math(String.raw`V_{L'}`),
        " に属する辺の有限集合を ",
        math(String.raw`A_{L,L'}`),
        " とする。辺ごとに不定元を持つ多変数分配多項式を",
      ]),
      displayMath(
        String.raw`\mathcal Z_L((X_e)_{e\in E_L})
=\sum_{\sigma:V_L\to\{-1,1\}}\prod_{\substack{e\in E_L\\
\sigma(\partial_0 e)\ne\sigma(\partial_1 e)}}X_e
\ \in\ \mathbb Z[(X_e)_{e\in E_L}]`,
      ),
      paragraph([
        "と定める。さらに、各 ",
        math(String.raw`e\in A_{L,L'}`),
        " の変数は保ち、各 ",
        math(String.raw`e\in E_L\setminus A_{L,L'}`),
        " の変数を ",
        math(String.raw`1`),
        " に置く代入写像を ",
        math(String.raw`\rho_{L,L'}`),
        " とする。有限な代入で得る整係数多項式",
      ]),
      displayMath(
        String.raw`R_{L,L'}((X_e)_{e\in A_{L,L'}})
=\rho_{L,L'}\bigl(\mathcal Z_L((X_e)_{e\in E_L})\bigr)
\ \in\ \mathbb Z[(X_e)_{e\in A_{L,L'}}]`,
      ),
      paragraph([
        "を包含 ",
        math(String.raw`V_{L'}\subset V_L`),
        " の境界応答多項式と呼ぶ。これは内箱の内部辺に加え、内箱と外側を結ぶ辺の変数を保持する。",
        "この有限な整係数多項式の族を、箱の大きさの極限で残る部分と潰れる部分を問う次の測定量に選ぶ。",
      ]),
    ],
  },

  {
    id: "boundary_response_measurement_claim_specialization_homomorphism",
    kind: "claim",
    title: { text: "境界応答を作る代入は環準同型である" },
    labels: ["claim_boundary_response_specialization_homomorphism"],
    habitat: "Z",
    statement: [
      paragraph([
        "代入写像 ",
        math(String.raw`\rho_{L,L'}:\mathbb Z[(X_e)_{e\in E_L}]\to\mathbb Z[(X_e)_{e\in A_{L,L'}}]`),
        " は整係数多項式環の環準同型である。",
      ]),
    ],
    proof: [
      paragraph([
        "各不定元の像を、",
        math(String.raw`e\in A_{L,L'}`),
        " なら同名の不定元 ",
        math(String.raw`X_e`),
        "、",
        math(String.raw`e\in E_L\setminus A_{L,L'}`),
        " なら整数 ",
        math(String.raw`1`),
        " と指定する。",
      ]),
      displayMath(
        String.raw`\rho_{L,L'}(X_e)=
\begin{cases}
X_e,&e\in A_{L,L'},\\
1,&e\in E_L\setminus A_{L,L'}.
\end{cases}`,
      ),
      paragraph([
        "有限個の不定元を持つ多項式環の代入の普遍性により、この指定を保つ環準同型が一意に存在する。",
        "したがって ",
        math(String.raw`\rho_{L,L'}`),
        " は環準同型である。",
      ]),
    ],
  },

  {
    id: "boundary_response_measurement_claim_outer_box_stability",
    kind: "claim",
    title: { text: "外箱を広げても境界応答多項式は 2 冪倍にしかならない" },
    labels: ["claim_boundary_response_outer_box_stability"],
    habitat: "Z",
    statement: [
      paragraph([
        "自由境界の三つの箱の点集合が ",
        math(String.raw`V_{L'}\subset V_L\subset V_{L''}`),
        " を満たし、さらに ",
        math(String.raw`E_{L''}`),
        " の辺のうち少なくとも一方の端点が ",
        math(String.raw`V_{L'}`),
        " に属するものがすべて ",
        math(String.raw`E_L`),
        " に含まれるとする。このとき変数集合は ",
        math(String.raw`A_{L'',L'}=A_{L,L'}`),
        " で一致し、有限個の点の個数の差 ",
        math(String.raw`\#V_{L''}-\#V_L\in\mathbb N`),
        " について",
      ]),
      displayMath(
        String.raw`R_{L'',L'}((X_e)_{e\in A_{L,L'}})=2^{\#V_{L''}-\#V_L}\,R_{L,L'}((X_e)_{e\in A_{L,L'}})
\ \in\ \mathbb Z[(X_e)_{e\in A_{L,L'}}]`,
      ),
      paragraph(["が成り立つ。すなわち境界応答多項式は、内箱の近傍を収める外箱の取り方に、2 冪の定数倍を除いて依存しない。"]),
    ],
    proof: [
      paragraph([
        "まず変数集合の一致を示す。自由境界の箱の辺集合は点集合の隣接する 2 点の組の全体なので、",
        math(String.raw`V_L\subset V_{L''}`),
        " から ",
        math(String.raw`E_L\subset E_{L''}`),
        " が従う。よって ",
        math(String.raw`E_L`),
        " の辺で一方の端点が ",
        math(String.raw`V_{L'}`),
        " に属するものは ",
        math(String.raw`E_{L''}`),
        " でも同じ条件を満たし、",
        math(String.raw`A_{L,L'}\subseteq A_{L'',L'}`),
        " を得る。逆の包含 ",
        math(String.raw`A_{L'',L'}\subseteq A_{L,L'}`),
        " は仮定そのものである。ゆえに ",
        math(String.raw`A_{L'',L'}=A_{L,L'}`),
        " であり、以下この有限集合を ",
        math(String.raw`A`),
        " と書く。",
      ]),
      paragraph([
        "次に代入を有限和の各項へ分配する。代入写像 ",
        math(String.raw`\rho_{L'',L'}`),
        " は環準同型なので、有限和と有限積を保ち、",
        math(String.raw`e\in E_{L''}\setminus A`),
        " の不定元を ",
        math(String.raw`1`),
        " に、",
        math(String.raw`e\in A`),
        " の不定元を同名の不定元に送る。したがって",
      ]),
      displayMath(
        String.raw`R_{L'',L'}=\sum_{\sigma:V_{L''}\to\{-1,1\}}\ \prod_{\substack{e\in A\\ \sigma(\partial_0 e)\ne\sigma(\partial_1 e)}}X_e .`,
      ),
      paragraph([
        "写像 ",
        math(String.raw`\sigma\mapsto(\sigma|_{V_L},\ \sigma|_{V_{L''}\setminus V_L})`),
        " は、",
        math(String.raw`V_{L''}`),
        " 上の配位の有限集合から、",
        math(String.raw`V_L`),
        " 上の配位と ",
        math(String.raw`V_{L''}\setminus V_L`),
        " 上の配位の組の有限集合への全単射である（",
        math(String.raw`V_{L''}`),
        " が二つの部分の非交和なので、制限の組から元の写像が一意に復元される）。",
        "各 ",
        math(String.raw`e\in A\subseteq E_L`),
        " の両端点は ",
        math(String.raw`V_L`),
        " に属するから、",
        math(String.raw`\sigma(\partial_0 e)\ne\sigma(\partial_1 e)`),
        " の成否は ",
        math(String.raw`\tau=\sigma|_{V_L}`),
        " だけで決まる。ゆえに有限和を添字の全単射で書き換えて",
      ]),
      displayMath(
        String.raw`R_{L'',L'}=\sum_{\tau:V_L\to\{-1,1\}}\ \sum_{\upsilon:V_{L''}\setminus V_L\to\{-1,1\}}\ \prod_{\substack{e\in A\\ \tau(\partial_0 e)\ne\tau(\partial_1 e)}}X_e
=\Bigl(\#\{\upsilon:V_{L''}\setminus V_L\to\{-1,1\}\}\Bigr)\sum_{\tau:V_L\to\{-1,1\}}\ \prod_{\substack{e\in A\\ \tau(\partial_0 e)\ne\tau(\partial_1 e)}}X_e .`,
      ),
      paragraph([
        "内側の和の各項は ",
        math(String.raw`\upsilon`),
        " に依らないので、その個数 ",
        math(String.raw`2^{\#(V_{L''}\setminus V_L)}=2^{\#V_{L''}-\#V_L}`),
        " が括り出せる。残った有限和は、",
        math(String.raw`\rho_{L,L'}`),
        " が環準同型であることを同じ順で使えば ",
        math(String.raw`R_{L,L'}`),
        " に等しい（",
        math(String.raw`E_L\setminus A`),
        " の不定元が ",
        math(String.raw`1`),
        " に送られ、",
        math(String.raw`A`),
        " の不定元が保たれる）。以上で主張の等式を得る。",
      ]),
    ],
  },

  {
    id: "boundary_response_measurement_claim_outer_box_independence",
    kind: "claim",
    title: { text: "境界応答多項式は外箱に依存しない" },
    labels: ["claim_boundary_response_outer_box_independence"],
    habitat: "Z",
    statement: [
      paragraph([
        "自由境界の箱の点集合 ",
        math(String.raw`V_{L'}\subset V_{L_0}`),
        " と、二つの外箱 ",
        math(String.raw`V_{L_0}\subset V_{L_1}`),
        "、",
        math(String.raw`V_{L_0}\subset V_{L_2}`),
        " をとり、",
        math(String.raw`E_{L_1}`),
        " および ",
        math(String.raw`E_{L_2}`),
        " の辺のうち少なくとも一方の端点が ",
        math(String.raw`V_{L'}`),
        " に属するものがすべて ",
        math(String.raw`E_{L_0}`),
        " に含まれるとする。このとき変数集合は ",
        math(String.raw`A_{L_1,L'}=A_{L_0,L'}=A_{L_2,L'}`),
        " で一致し、",
      ]),
      displayMath(
        String.raw`2^{\#V_{L_2}}\,R_{L_1,L'}((X_e)_{e\in A_{L_0,L'}})=2^{\#V_{L_1}}\,R_{L_2,L'}((X_e)_{e\in A_{L_0,L'}})
\ \in\ \mathbb Z[(X_e)_{e\in A_{L_0,L'}}]`,
      ),
      paragraph([
        "が成り立つ。すなわち、内箱の近傍を収める二つの外箱に対する境界応答多項式は、外箱の点の個数で定まる 2 冪の因子を除いて一致し、外箱の取り方に依存しない。",
      ]),
    ],
    proof: [
      paragraph([
        "三つ組 ",
        math(String.raw`V_{L'}\subset V_{L_0}\subset V_{L_1}`),
        " は ",
        ref("claim_boundary_response_outer_box_stability"),
        " の仮定を満たす（",
        math(String.raw`E_{L_1}`),
        " の辺で ",
        math(String.raw`V_{L'}`),
        " に触れるものが ",
        math(String.raw`E_{L_0}`),
        " に含まれることを仮定した）。よって ",
        math(String.raw`A_{L_1,L'}=A_{L_0,L'}`),
        " であり、",
      ]),
      displayMath(
        String.raw`R_{L_1,L'}=2^{\#V_{L_1}-\#V_{L_0}}\,R_{L_0,L'} .`,
      ),
      paragraph([
        "同様に三つ組 ",
        math(String.raw`V_{L'}\subset V_{L_0}\subset V_{L_2}`),
        " にも ",
        ref("claim_boundary_response_outer_box_stability"),
        " を適用して、",
        math(String.raw`A_{L_2,L'}=A_{L_0,L'}`),
        " および",
      ]),
      displayMath(
        String.raw`R_{L_2,L'}=2^{\#V_{L_2}-\#V_{L_0}}\,R_{L_0,L'} .`,
      ),
      paragraph([
        "第一の等式の両辺に ",
        math(String.raw`2^{\#V_{L_2}}`),
        " を、第二の等式の両辺に ",
        math(String.raw`2^{\#V_{L_1}}`),
        " を掛ける。",
        math(String.raw`\#V_{L_0}\le\#V_{L_1}`),
        "、",
        math(String.raw`\#V_{L_0}\le\#V_{L_2}`),
        " なので指数はいずれも自然数であり、自然数冪の積の法則 ",
        math(String.raw`2^{a}\,2^{b}=2^{a+b}`),
        " により両辺の右辺はともに ",
        math(String.raw`2^{\#V_{L_1}+\#V_{L_2}-\#V_{L_0}}\,R_{L_0,L'}`),
        " に等しい。したがって ",
        math(String.raw`2^{\#V_{L_2}}R_{L_1,L'}=2^{\#V_{L_1}}R_{L_2,L'}`),
        " を得る。",
      ]),
    ],
  },
]);
