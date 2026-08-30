import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "arithmetic_invariants_heading",
    kind: "heading",
    level: 1,
    title: { text: "固定剰余類格子の算術的不変量" },
    labels: [],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_coefficient_support",
    kind: "theorem",
    title: { text: "固定剰余類格子の係数列の支持と偶数性" },
    labels: ["theorem_fixed_quotient_coefficient_support"],
    habitat: "N",
    verification: ["sagemath/check/fixed-quotient-coefficient-support"],
    statement: [
      paragraph(["有限集合"]),
      displayMath(String.raw`S_Q:=\left\{0,7,12,14,15\right\}\cup\left\{17,18,\ldots,56\right\}
\subset\left\{0,1,\ldots,84\right\}\subset\mathbb N`),
      paragraph(["を固定する。このとき任意の ", math(String.raw`m\in\left\{0,1,\ldots,84\right\}`), " に対して"]),
      displayMath(String.raw`\Omega_{G_Q}(m)\in
\begin{cases}
  \{2n\mid n\in\mathbb N_{>0}\} & (m\in S_Q),\\
  \{0\} & (m\notin S_Q)
\end{cases}`),
      paragraph([
        "である。したがって ",
        math(String.raw`S_Q`),
        " は固定剰余類格子の Ising 分配多項式の支持であり、その全ての非零係数は正の偶数である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_spin_configuration_set"),
        " の配位集合上に、大域スピン反転写像 ",
        math(String.raw`\mathfrak F_Q:\mathcal S_{G_Q}\to\mathcal S_{G_Q}`),
        " を",
      ]),
      displayMath(String.raw`\mathfrak F_Q(\sigma)(v):=\nu(\sigma(v))
\qquad(\sigma\in\mathcal S_{G_Q},\ v\in\mathcal V_Q)`),
      paragraph(["で定める。", ref("def_spin_label_reversal"), " の二つの定義値より、任意の ", math(String.raw`a\in\mathsf{Spin}`), " に対して"]),
      displayMath(String.raw`\nu(\nu(a))=a,
\qquad
\nu(a)\ne a`),
      paragraph(["である。したがって任意の ", math(String.raw`\sigma\in\mathcal S_{G_Q}`), " と ", math(String.raw`v\in\mathcal V_Q`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
\mathfrak F_Q(\mathfrak F_Q(\sigma))(v)
&=\nu(\mathfrak F_Q(\sigma)(v))
&&\bigl(\because\ \mathfrak F_Q\text{ の定義}\bigr)\\
&=\nu(\nu(\sigma(v)))
&&\bigl(\because\ \mathfrak F_Q\text{ の定義}\bigr)\\
&=\sigma(v)
&&\bigl(\because\ \nu(\nu(a))=a\bigr).
\end{aligned}`),
      paragraph([
        ref("theorem_generated_quotient_cellulation_is_hyperbolic_regular"),
        " より ",
        math(String.raw`|\mathcal V_Q|=24`),
        " なので、",
        math(String.raw`w\in\mathcal V_Q`),
        " を一つ選べる。",
      ]),
      displayMath(String.raw`\mathfrak F_Q(\sigma)(w)
=\nu(\sigma(w))
\ne\sigma(w)
\quad\bigl(\because\ \nu(a)\ne a\bigr).`),
      paragraph([
        "ゆえに ",
        math(String.raw`\mathfrak F_Q`),
        " は不動点を持たない対合である。次に、",
        ref("def_broken_edge_set"),
        " の破れ辺集合へ大域スピン反転を適用する。任意の ",
        math(String.raw`e\in\mathcal E_Q`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
e\in B_{G_Q}(\mathfrak F_Q(\sigma))
&\iff
\nu\!\left(\sigma\!\left(\partial_{G_Q}(e,\mathsf{source})\right)\right)
\ne
\nu\!\left(\sigma\!\left(\partial_{G_Q}(e,\mathsf{target})\right)\right)
&&\bigl(\because\ B_{G_Q}\text{ と }\mathfrak F_Q\text{ の定義}\bigr)\\
&\iff
\sigma\!\left(\partial_{G_Q}(e,\mathsf{source})\right)
\ne
\sigma\!\left(\partial_{G_Q}(e,\mathsf{target})\right)
&&\bigl(\because\ \nu\text{ は全単射}\bigr)\\
&\iff e\in B_{G_Q}(\sigma)
&&\bigl(\because\ B_{G_Q}\text{ の定義}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
B_{G_Q}(\mathfrak F_Q(\sigma))
&=B_{G_Q}(\sigma)
&&\bigl(\because\ \mathcal E_Q\text{ の全ての元について所属が同値}\bigr)\\
b_{G_Q}(\mathfrak F_Q(\sigma))
&=b_{G_Q}(\sigma)
&&\bigl(\because\ \text{等しい有限集合の元数は等しい}\bigr).
\end{aligned}`),
      paragraph([
        "各 ",
        math(String.raw`m\in\{0,1,\ldots,84\}`),
        " に対し、有限集合 ",
        math(String.raw`\mathcal A_m:=\{\sigma\in\mathcal S_{G_Q}\mid b_{G_Q}(\sigma)=m\}`),
        " を置く。直前の等式より ",
        math(String.raw`\mathfrak F_Q`),
        " は ",
        math(String.raw`\mathcal A_m`),
        " を保つ。不動点を持たない対合は有限集合を二元部分集合へ分割するので、ある ",
        math(String.raw`n_m\in\mathbb N`),
        " が存在して",
      ]),
      paragraph([ref("def_broken_edge_multiplicity"), " より"]),
      displayMath(String.raw`\Omega_{G_Q}(m)
=|\mathcal A_m|
=2n_m
\in\{2n\mid n\in\mathbb N\}.`),
      paragraph([
        ref("theorem_fixed_quotient_ising_partition_polynomial"),
        " と ",
        ref("claim_partition_polynomial_coefficient_expansion"),
        " を係数ごとに照合すると",
      ]),
      displayMath(String.raw`\{m\in\{0,1,\ldots,84\}\mid\Omega_{G_Q}(m)>0\}
=S_Q.`),
      paragraph([
        "したがって ",
        math(String.raw`m\in S_Q`),
        " なら ",
        math(String.raw`n_m\in\mathbb N_{>0}`),
        " であり、",
        math(String.raw`m\notin S_Q`),
        " なら ",
        math(String.raw`n_m=0`),
        " である。これが主張の二場合を与える。全ての対象は有限集合と自然数に属し、実数、複素数、極限、積分は用いない。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_definition_fixed_quotient_coefficient_valuation",
    kind: "definition",
    title: { text: "固定剰余類格子の係数付値" },
    labels: ["def_fixed_quotient_coefficient_valuation"],
    habitat: "Z",
    verification: ["sagemath/check/fixed-quotient-coefficient-valuations"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_coefficient_support"),
        " の有限支持 ",
        math(String.raw`S_Q`),
        " と、素数 ",
        math(String.raw`p\in\mathbb N_{>1}`),
        " を固定する。各 ",
        math(String.raw`m\in S_Q`),
        " に対する係数付値写像を",
      ]),
      displayMath(String.raw`\nu_{Q,p}:S_Q\longrightarrow\mathbb N,
\qquad
\nu_{Q,p}(m)\in\mathbb N\subset\mathbb Z`),
      paragraph(["と定め、各値を"]),
      displayMath(String.raw`\nu_{Q,p}(m):=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists r\in\mathbb N_{>0},\ \Omega_{G_Q}(m)=p^k r
\right\}`),
      paragraph([
        "で定める。",
        ref("theorem_fixed_quotient_coefficient_support"),
        " より ",
        math(String.raw`\Omega_{G_Q}(m)\in\mathbb N_{>0}`),
        " なので、最大値を取る集合は ",
        math(String.raw`k=0`),
        " を含む。さらに、この集合に属する ",
        math(String.raw`k`),
        " は ",
        math(String.raw`p^k\leq\Omega_{G_Q}(m)`),
        " を満たし、",
        math(String.raw`p\geq2`),
        " なので、この集合は有限である。したがって ",
        math(String.raw`\nu_{Q,p}(m)`),
        " は一意に定まる。この値は ",
        math(String.raw`\Omega_{G_Q}(m)`),
        " を ",
        math(String.raw`p`),
        " で割り切れる間だけ反復して割った回数として、係数の完全因数分解を用いずに決定できる。全ての対象は自然数または整数に属し、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_definition_fixed_quotient_rational_evaluation_valuation",
    kind: "definition",
    title: { text: "固定剰余類格子の正有理評価値の付値" },
    labels: ["def_fixed_quotient_rational_evaluation_valuation"],
    habitat: "Z",
    verification: ["sagemath/check/fixed-quotient-rational-evaluation-valuations"],
    statement: [
      paragraph([
        "素数 ",
        math(String.raw`p\in\mathbb N_{>1}`),
        " を固定する。各 ",
        math(String.raw`q\in\mathbb Q_{>0}`),
        " に対し、互いに素な ",
        math(String.raw`a_q,b_q\in\mathbb N_{>0}`),
        " を ",
        math(String.raw`q=a_q/b_q`),
        " により一意に選ぶ。",
        ref("theorem_fixed_quotient_ising_partition_polynomial"),
        " の次数が ",
        math(String.raw`56`),
        " であることを用いて、分母を払った評価整数を",
      ]),
      displayMath(String.raw`E_Q(q):=
b_q^{56}Z_{G_Q}\!\left(\frac{a_q}{b_q}\right)
=\sum_{m=0}^{56}\Omega_{G_Q}(m)a_q^m b_q^{56-m}
\in\mathbb N_{>0}`),
      paragraph([
        "と置く。正値性は ",
        ref("theorem_fixed_quotient_ising_partition_polynomial"),
        " の非負係数と正の定数項から従う。正有理評価付値写像を",
      ]),
      displayMath(String.raw`\operatorname{val}^{\mathrm{eval}}_{Q,p}:
\mathbb Q_{>0}\longrightarrow\mathbb Z`),
      paragraph(["とし、その値を"]),
      displayMath(String.raw`\begin{aligned}
\operatorname{val}^{\mathrm{eval}}_{Q,p}(q)
&:=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists r\in\mathbb N_{>0},\ E_Q(q)=p^k r
\right\}\\
&\quad{}-56
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  \exists s\in\mathbb N_{>0},\ b_q=p^k s
\right\}
\in\mathbb Z
\end{aligned}`),
      paragraph([
        "で定める。二つの最大値は、",
        ref("def_fixed_quotient_coefficient_valuation"),
        " と同じ有限性の議論により一意に定まる。また",
      ]),
      displayMath(String.raw`Z_{G_Q}(q)=\frac{E_Q(q)}{b_q^{56}}\in\mathbb Q_{>0}`),
      paragraph([
        "なので、この整数は非零有理数 ",
        math(String.raw`Z_{G_Q}(q)`),
        " の分子に現れる ",
        math(String.raw`p`),
        " の指数から分母に現れる指数を引いた値である。計算には整数の整除判定と反復除算だけを用い、完全因数分解、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_has_square_factor",
    kind: "theorem",
    title: { text: "固定剰余類格子の分配多項式の平方因子" },
    labels: ["theorem_fixed_quotient_partition_polynomial_has_square_factor"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/fixed-quotient-partition-polynomial-square-factor"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_ising_partition_polynomial"),
        " の多項式を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\mathbb Q[x]}:\mathbb Z[x]\hookrightarrow\mathbb Q[x]`),
        " で有理係数多項式環へ移し、",
      ]),
      displayMath(String.raw`P_Q(x):=\iota_{\mathbb Z[x],\mathbb Q[x]}\!\left(Z_{G_Q}(x)\right)\in\mathbb Q[x]`),
      paragraph(["と置く。形式微分を ", math(String.raw`P_Q'(x)\in\mathbb Q[x]`), " と書く。このとき"]),
      displayMath(String.raw`\gcd_{\mathbb Q[x]}\!\left(P_Q(x),P_Q'(x)\right)\ne 1.`),
      paragraph([
        "したがって固定剰余類格子の Ising 分配多項式は平方因子を持ち、平方因子を持たない多項式ではない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_ising_partition_polynomial"),
        " の係数を偶数次数と奇数次数に分けて整数として加えると",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{0\le m\le56\\m\ \mathrm{even}}}\Omega_{G_Q}(m)
&=8388608
&&\bigl(\because\ \text{表示された有限係数列の加法}\bigr)\\
&=\sum_{\substack{0\le m\le56\\m\ \mathrm{odd}}}\Omega_{G_Q}(m)
&&\bigl(\because\ \text{表示された有限係数列の加法}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_Q(-1)
&=\sum_{m=0}^{56}\Omega_{G_Q}(m)(-1)^m
&&\bigl(\because\ P_Q\text{ の定義}\bigr)\\
&=8388608-8388608
&&\bigl(\because\ \text{偶数次数和と奇数次数和}\bigr)\\
&=0.
\end{aligned}`),
      paragraph(["同じ係数列を形式微分し、次数を掛けた係数を偶奇別に加えると"]),
      displayMath(String.raw`\begin{aligned}
\sum_{\substack{1\le m\le56\\m\ \mathrm{odd}}}m\Omega_{G_Q}(m)
&=352321536
&&\bigl(\because\ \text{表示された有限係数列の乗法と加法}\bigr)\\
&=\sum_{\substack{1\le m\le56\\m\ \mathrm{even}}}m\Omega_{G_Q}(m)
&&\bigl(\because\ \text{表示された有限係数列の乗法と加法}\bigr).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_Q'(-1)
&=\sum_{m=1}^{56}m\Omega_{G_Q}(m)(-1)^{m-1}
&&\bigl(\because\ \mathbb Q[x]\text{ の形式微分}\bigr)\\
&=352321536-352321536
&&\bigl(\because\ \text{奇数次数重み付き和と偶数次数重み付き和}\bigr)\\
&=0.
\end{aligned}`),
      paragraph(["有理係数多項式の因数定理より"]),
      displayMath(String.raw`x+1\mid P_Q(x),
\qquad
x+1\mid P_Q'(x).`),
      displayMath(String.raw`\deg\!\left(\gcd_{\mathbb Q[x]}(P_Q,P_Q')\right)
\ge\deg(x+1)
=1.`),
      paragraph([
        "ゆえに最大公約多項式は ",
        math(String.raw`1`),
        " ではない。有理係数多項式の重根判定より ",
        math(String.raw`(x+1)^2\mid P_Q(x)`),
        " である。",
        math(String.raw`x+1`),
        " はモニックな整数係数多項式なので、Gauss の補題より ",
        math(String.raw`(x+1)^2\mid Z_{G_Q}(x)`),
        " が ",
        math(String.raw`\mathbb Z[x]`),
        " でも成り立つ。全ての計算は整数と有理係数多項式の有限演算であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_irreducible_factorization",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "固定剰余類格子の分配多項式の既約分解" },
    labels: ["theorem_fixed_quotient_partition_polynomial_irreducible_factorization"],
    habitat: "ZPolynomial",
    verification: ["sagemath/check/fixed-quotient-partition-polynomial-irreducible-factorization"],
    statement: [
      paragraph([ref("theorem_fixed_quotient_ising_partition_polynomial"), " の多項式は "]),
      displayMath(String.raw`Z_{G_Q}(x)=2(x+1)^{12}Q_Q(x)\in\mathbb Z[x]`),
      paragraph(["と既約分解される。ただし "]),
      displayMath(String.raw`\begin{aligned}
Q_Q(x)={}&63x^{44}-84x^{43}+882x^{42}-5292x^{41}+30261x^{40}-124376x^{39}\\
&+396144x^{38}-1022928x^{37}+2256050x^{36}-4400568x^{35}+7781004x^{34}\\
&-12653312x^{33}+19098240x^{32}-26919480x^{31}+35607568x^{30}-44375136x^{29}\\
&+52275723x^{28}-58374540x^{27}+61934922x^{26}-62562108x^{25}+60269153x^{24}\\
&-55450752x^{23}+48781656x^{22}-41071744x^{21}+33118029x^{20}-25586652x^{19}\\
&+18944254x^{18}-13441092x^{17}+9135819x^{16}-5945016x^{15}+3700368x^{14}\\
&-2200128x^{13}+1247330x^{12}-672672x^{11}+343980x^{10}-166088x^9+75294x^8\\
&-31800x^7+12376x^6-4368x^5+1365x^4-364x^3+78x^2-12x+1
\in\mathbb Z[x].
\end{aligned}`),
      paragraph([
        "は原始的な次数 ",
        math("44"),
        " の既約多項式である。したがって非定数既約因子の重複度は ",
        math("x+1"),
        " が ",
        math("12"),
        "、",
        math("Q_Q"),
        " が ",
        math("1"),
        " である。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_ising_partition_polynomial"), " の表示された有限係数列を整数係数多項式として乗除算すると"]),
      displayMath(String.raw`\begin{aligned}
Z_{G_Q}(x)
&=2(x+1)^{12}Q_Q(x)
&&\bigl(\because\ \mathbb Z[x]\text{ 上の有限乗算による係数照合}\bigr),\\
\deg Q_Q
&=44
&&\bigl(\because\ Q_Q\text{ の最高次係数と定数項の表示}\bigr),\\
\gcd_{\mathbb Z}\{a\in\mathbb Z\mid a\text{ は }Q_Q\text{ の係数}\}
&=1
&&\bigl(\because\ Q_Q\text{ の定数項が }1\bigr).
\end{aligned}`),
      paragraph([
        math(String.raw`\overline Q_Q\in\mathbb F_{191}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を標準写像 ",
        math(String.raw`\mathbb Z\to\mathbb F_{191}`),
        " で移した多項式とする。",
        math(String.raw`44=2^2\cdot11`),
        " なので、有限体上の既約性判定に必要な有限剰余計算は",
      ]),
      displayMath(String.raw`\begin{aligned}
x^{191^{44}}&\equiv x\pmod{\overline Q_Q},\\
\gcd_{\mathbb F_{191}[x]}\!\left(\overline Q_Q,x^{191^{22}}-x\right)&=1,\\
\gcd_{\mathbb F_{191}[x]}\!\left(\overline Q_Q,x^{191^4}-x\right)&=1.
\end{aligned}`),
      paragraph([
        "を与える。有限体上の既約性判定より ",
        math(String.raw`\overline Q_Q`),
        " は ",
        math(String.raw`\mathbb F_{191}[x]`),
        " で既約である。したがって整数係数の原始多項式に対する Gauss の補題より ",
        math(String.raw`Q_Q`),
        " は ",
        math(String.raw`\mathbb Z[x]`),
        " で既約である。さらに ",
        math(String.raw`x+1`),
        " は一次式なので既約であり、表示された積が主張する重複度をもつ既約分解である。全ての計算は整数係数多項式と有限体上の有限演算であり、実数、複素数、極限、積分を用いない。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_zero_multiplicity_data",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 零点の代数的重複度データ" },
    labels: ["theorem_fixed_quotient_fisher_zero_multiplicity_data"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-zero-multiplicity-data"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " の分配多項式を標準単射 ",
        math(String.raw`\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}:\mathbb Z[x]\hookrightarrow\overline{\mathbb Q}[x]`),
        " で代数的閉包上へ移し、",
      ]),
      displayMath(String.raw`\overline P_Q(x):=\iota_{\mathbb Z[x],\overline{\mathbb Q}[x]}\!\left(Z_{G_Q}(x)\right)
\in\overline{\mathbb Q}[x]`),
      paragraph(["と置く。各 ", math(String.raw`\alpha\in\overline{\mathbb Q}`), " に対して零点重複度を"]),
      displayMath(String.raw`\mu_Q(\alpha):=
\max\left\{
  k\in\mathbb N
  \,\middle|\,
  (x-\alpha)^k\mid\overline P_Q(x)
  \text{ in }\overline{\mathbb Q}[x]
\right\}
\in\mathbb N`),
      paragraph([
        "で定める。集合は ",
        math("k=0"),
        " を含み、",
        math(String.raw`\deg\overline P_Q=56`),
        " により上に有界なので、この最大値は一意に存在する。このとき",
      ]),
      displayMath(String.raw`\mu_Q(\alpha)=
\begin{cases}
  12 & (\alpha=-1),\\
  1 & (Q_Q(\alpha)=0),\\
  0 & (\alpha\ne-1\text{ and }Q_Q(\alpha)\ne0).
\end{cases}`),
      paragraph([
        "したがって Fisher 零点の台は相異なる ",
        math("45"),
        " 個の代数的数からなり、重複度の総和は ",
        math("56"),
        " である。このデータは ",
        math(String.raw`\overline{\mathbb Q}`),
        " と代数的多項式の整除だけで定まり、複素平面への埋め込み、数値近似、距離、偏角を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"), " を標準単射で移すと"]),
      displayMath(String.raw`\overline P_Q(x)
=2(x+1)^{12}\overline Q_Q(x)
\in\overline{\mathbb Q}[x],`),
      paragraph([
        "ただし ",
        math(String.raw`\overline Q_Q`),
        " は ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\overline{\mathbb Q}`),
        " へ移した多項式である。",
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " より ",
        math(String.raw`Q_Q\in\mathbb Q[x]`),
        " は次数 ",
        math("44"),
        " の既約多項式である。標数零の体上の既約多項式は分離的なので、",
      ]),
      displayMath(String.raw`\left|\left\{\alpha\in\overline{\mathbb Q}\mid Q_Q(\alpha)=0\right\}\right|
=44
=\deg Q_Q.`),
      paragraph([
        math(String.raw`x+1`),
        " と ",
        math(String.raw`Q_Q`),
        " は次数の異なる既約多項式なので互いに素であり、",
      ]),
      displayMath(String.raw`Q_Q(-1)\ne0
\quad\bigl(\because\ \gcd_{\mathbb Q[x]}(x+1,Q_Q)=1\bigr).`),
      paragraph(["よって積における各一次因子の指数を読むと"]),
      displayMath(String.raw`\mu_Q(\alpha)=
\begin{cases}
  12 & (\alpha=-1),\\
  1 & (Q_Q(\alpha)=0),\\
  0 & (\alpha\ne-1\text{ and }Q_Q(\alpha)\ne0)
\end{cases}
\quad\bigl(\because\ \overline P_Q=2(x+1)^{12}\overline Q_Q\bigr).`),
      displayMath(String.raw`\left|\left\{\alpha\in\overline{\mathbb Q}\mid\mu_Q(\alpha)>0\right\}\right|
=1+44
=45,`),
      displayMath(String.raw`\sum_{\substack{\alpha\in\overline{\mathbb Q}\\\mu_Q(\alpha)>0}}\mu_Q(\alpha)
=12+44
=56.`),
      paragraph([
        "以上は有理係数多項式の既約分解、代数的閉包における有限個の根、標数零での分離性だけを用いる。数値近似と複素平面上の根分離は別の成果物で扱う。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_finite_degree",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体の有限次性" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_finite_degree"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-finite-degree"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子 ",
        math(String.raw`Q_Q`),
        " の相異なる四十四根を一つの全順序に従って ",
        math(String.raw`\alpha_1,\ldots,\alpha_{44}\in\overline{\mathbb Q}`),
        " と書く。",
      ]),
      displayMath(String.raw`K_Q:=\mathbb Q(\alpha_1,\ldots,\alpha_{44})
\subset\overline{\mathbb Q}`),
      paragraph([
        "と置く。このとき ",
        math(String.raw`K_Q`),
        " は固定剰余類格子の Ising 分配多項式 ",
        math(String.raw`Z_{G_Q}(x)`),
        " の ",
        math(String.raw`\mathbb Q`),
        " 上の分解体であり、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{n\in\mathbb N_{>0}\mid n\le44^{44}\right\}.`),
      paragraph([
        "特に Fisher 零点を全て含む最小の体も有限次の代数拡大として ",
        math(String.raw`\overline{\mathbb Q}`),
        " の中に留まる。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " と ",
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " より、各 ",
        math(String.raw`r\in\{1,\ldots,44\}`),
        " に対して ",
        math(String.raw`\alpha_r`),
        " は次数 ",
        math("44"),
        " の既約多項式 ",
        math(String.raw`Q_Q\in\mathbb Q[x]`),
        " の根である。したがって",
      ]),
      displayMath(String.raw`[\mathbb Q(\alpha_r):\mathbb Q]=44
\qquad(r\in\{1,\ldots,44\}).`),
      paragraph([
        math(String.raw`K_0:=\mathbb Q`),
        " とし、各 ",
        math(String.raw`r\in\{1,\ldots,44\}`),
        " に対して",
      ]),
      displayMath(String.raw`K_r:=K_{r-1}(\alpha_r)\subset\overline{\mathbb Q}`),
      paragraph([
        "と置く。",
        math(String.raw`\alpha_r`),
        " の ",
        math(String.raw`K_{r-1}`),
        " 上の最小多項式は ",
        math(String.raw`Q_Q`),
        " を ",
        math(String.raw`K_{r-1}[x]`),
        " で割り切るので、",
      ]),
      displayMath(String.raw`[K_r:K_{r-1}]\le 44
\qquad(r\in\{1,\ldots,44\}).`),
      displayMath(String.raw`[K_0:\mathbb Q]
=[\mathbb Q:\mathbb Q]
=1
=44^0.`),
      paragraph(["体の塔の次数公式と帰納法により、任意の ", math(String.raw`r\in\{1,\ldots,44\}`), " について"]),
      displayMath(String.raw`\begin{aligned}
[K_r:\mathbb Q]
&=[K_r:K_{r-1}][K_{r-1}:\mathbb Q]
&&\bigl(\because\ \text{体の塔の次数公式}\bigr)\\
&\le 44[K_{r-1}:\mathbb Q]
&&\bigl(\because\ [K_r:K_{r-1}]\le44\bigr)\\
&\le 44\cdot44^{r-1}
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&=44^r.
\end{aligned}`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=[K_{44}:\mathbb Q]
\le44^{44}\in\mathbb N_{>0}.`),
      paragraph([
        "全ての ",
        math(String.raw`\alpha_r`),
        " が ",
        math(String.raw`K_Q`),
        " に属するので、",
        math(String.raw`Q_Q`),
        " は ",
        math(String.raw`K_Q[x]`),
        " で一次式の積へ分解する。さらに ",
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " より",
      ]),
      displayMath(String.raw`Z_{G_Q}(x)=2(x+1)^{12}Q_Q(x),`),
      paragraph([
        "かつ ",
        math(String.raw`-1\in\mathbb Q\subset K_Q`),
        " なので、",
        math(String.raw`Z_{G_Q}`),
        " も ",
        math(String.raw`K_Q[x]`),
        " で一次式の積へ分解する。逆に、",
        math(String.raw`\mathbb Q`),
        " を含み ",
        math(String.raw`Z_{G_Q}`),
        " が一次式の積へ分解する任意の ",
        math(String.raw`L\subset\overline{\mathbb Q}`),
        " は全ての ",
        math(String.raw`\alpha_r`),
        " を含むため、",
      ]),
      displayMath(String.raw`K_Q=\mathbb Q(\alpha_1,\ldots,\alpha_{44})\subset L.`),
      paragraph([
        "よって ",
        math(String.raw`K_Q`),
        " は ",
        math(String.raw`Z_{G_Q}`),
        " の ",
        math(String.raw`\mathbb Q`),
        " 上の分解体である。",
      ]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の階乗上界" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_factorial_degree_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-factorial-degree-bound"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{n\in\mathbb N_{>0}\mid n\le44!\right\}.`),
      paragraph([
        "したがって既存の上界 ",
        math(String.raw`44^{44}`),
        " は ",
        math(String.raw`44!`),
        " へ強められる。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の相異なる四十四根を ",
        math(String.raw`\alpha_1,\ldots,\alpha_{44}`),
        " とし、",
      ]),
      displayMath(String.raw`K_0:=\mathbb Q,
\qquad
K_r:=K_{r-1}(\alpha_r)\subset\overline{\mathbb Q}
\quad(r\in\{1,\ldots,44\})`),
      paragraph([
        "と置く。空積を ",
        math("1"),
        " とし、各 ",
        math(String.raw`r\in\{1,\ldots,44\}`),
        " に対して",
      ]),
      displayMath(String.raw`R_{r-1}(x):=
\frac{Q_Q(x)}{\prod_{j=1}^{r-1}(x-\alpha_j)}`),
      paragraph([
        "と置く。",
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " より各 ",
        math(String.raw`\alpha_j`),
        " は ",
        math(String.raw`Q_Q`),
        " の相異なる単根であり、",
        math(String.raw`\alpha_1,\ldots,\alpha_{r-1}\in K_{r-1}`),
        " である。因数定理を順に適用すると、",
      ]),
      displayMath(String.raw`R_{r-1}(x)\in K_{r-1}[x].`),
      paragraph([
        math(String.raw`Q_Q`),
        " の次数が ",
        math("44"),
        " であり、分母は相異なる ",
        math(String.raw`r-1`),
        " 個のモニック一次因子の積なので、",
      ]),
      displayMath(String.raw`\deg R_{r-1}=44-(r-1).`),
      displayMath(String.raw`44-(r-1)=45-r.`),
      displayMath(String.raw`\deg R_{r-1}=45-r.`),
      paragraph([
        math(String.raw`\alpha_r`),
        " はそれ以前の根と相異なり、",
        math(String.raw`Q_Q`),
        " の根である。したがって",
      ]),
      displayMath(String.raw`\prod_{j=1}^{r-1}(\alpha_r-\alpha_j)\ne0.`),
      displayMath(String.raw`Q_Q(\alpha_r)
=\left(\prod_{j=1}^{r-1}(\alpha_r-\alpha_j)\right)R_{r-1}(\alpha_r).`),
      displayMath(String.raw`Q_Q(\alpha_r)=0.`),
      displayMath(String.raw`\left(\prod_{j=1}^{r-1}(\alpha_r-\alpha_j)\right)R_{r-1}(\alpha_r)=0.`),
      paragraph(["体の零積性により、"]),
      displayMath(String.raw`R_{r-1}(\alpha_r)=0.`),
      paragraph([
        math(String.raw`\alpha_r`),
        " の ",
        math(String.raw`K_{r-1}`),
        " 上の最小多項式を ",
        math(String.raw`m_r\in K_{r-1}[x]`),
        " と書く。最小多項式の特徴付けにより ",
        math(String.raw`m_r`),
        " は ",
        math(String.raw`R_{r-1}`),
        " を割り切るので、",
      ]),
      displayMath(String.raw`\deg m_r\le\deg R_{r-1}.`),
      paragraph(["単拡大の次数公式により、"]),
      displayMath(String.raw`[K_r:K_{r-1}]=\deg m_r.`),
      displayMath(String.raw`[K_r:K_{r-1}]\le\deg R_{r-1}.`),
      displayMath(String.raw`[K_r:K_{r-1}]\le45-r.`),
      paragraph(["体の塔の次数公式を四十四段へ適用すると、"]),
      displayMath(String.raw`[K_{44}:\mathbb Q]
=\prod_{r=1}^{44}[K_r:K_{r-1}].`),
      paragraph(["各段の上界を有限積へ移すと、"]),
      displayMath(String.raw`[K_{44}:\mathbb Q]
\le\prod_{r=1}^{44}(45-r).`),
      displayMath(String.raw`\prod_{r=1}^{44}(45-r)
=44!.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"), " の構成より、"]),
      displayMath(String.raw`K_{44}=K_Q.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=[K_{44}:\mathbb Q].`),
      displayMath(String.raw`[K_Q:\mathbb Q]\le44!.`),
      paragraph(["有限拡大次数は正の自然数なので、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]\in\mathbb N_{>0}.`),
      paragraph([
        "さらに各 ",
        math(String.raw`k\in\{1,\ldots,44\}`),
        " について ",
        math(String.raw`k\le44`),
        " であり、",
        math(String.raw`1<44`),
        " だから、正整数の有限積の狭義単調性により、",
      ]),
      displayMath(String.raw`44!=\prod_{k=1}^{44}k.`),
      displayMath(String.raw`\prod_{k=1}^{44}k<\prod_{k=1}^{44}44.`),
      displayMath(String.raw`\prod_{k=1}^{44}44=44^{44}.`),
      displayMath(String.raw`44!<44^{44}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の階乗整除性" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-divides-factorial"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は ",
        math(String.raw`44!`),
        " を割り切る。すなわち",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{n\in\mathbb N_{>0}\mid n\mid44!\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子 ",
        math(String.raw`Q_Q\in\mathbb Q[x]`),
        " の根集合を",
      ]),
      displayMath(String.raw`A_Q:=\left\{\alpha\in\overline{\mathbb Q}\mid Q_Q(\alpha)=0\right\}`),
      paragraph(["と置く。同じ定理より、"]),
      displayMath(String.raw`|A_Q|=44.`),
      paragraph([
        math(String.raw`\mathbb Q`),
        " の標数は零なので ",
        math(String.raw`Q_Q`),
        " は分離的である。さらに ",
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " より ",
        math(String.raw`K_Q/\mathbb Q`),
        " は有限分離拡大かつ正規拡大である。したがって",
      ]),
      displayMath(String.raw`K_Q/\mathbb Q\text{ は有限 Galois 拡大である}.`),
      paragraph([
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " を ",
        math(String.raw`K_Q/\mathbb Q`),
        " の Galois 群、",
        math(String.raw`\operatorname{Sym}(A_Q)`),
        " を有限集合 ",
        math(String.raw`A_Q`),
        " の全ての置換からなる群とする。任意の ",
        math(String.raw`\sigma\in\operatorname{Gal}(K_Q/\mathbb Q)`),
        " と ",
        math(String.raw`\alpha\in A_Q`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
Q_Q(\sigma(\alpha))
&=\sigma(Q_Q(\alpha))
&&\bigl(\because\ \sigma\text{ は }\mathbb Q\text{ を固定する体自己同型}\bigr)\\
&=\sigma(0)
&&\bigl(\because\ \alpha\in A_Q\bigr)\\
&=0.
\end{aligned}`),
      displayMath(String.raw`\sigma(\alpha)\in A_Q.`),
      paragraph([
        math(String.raw`\sigma^{-1}\in\operatorname{Gal}(K_Q/\mathbb Q)`),
        " にも同じ議論を適用すると、",
      ]),
      displayMath(String.raw`\sigma^{-1}(\alpha)\in A_Q
\qquad(\alpha\in A_Q).`),
      paragraph(["したがって ", math(String.raw`\sigma|_{A_Q}`), " は逆写像 ", math(String.raw`\sigma^{-1}|_{A_Q}`), " をもつ置換である。ゆえに根集合への制限により写像"]),
      displayMath(String.raw`\rho:\operatorname{Gal}(K_Q/\mathbb Q)\longrightarrow\operatorname{Sym}(A_Q),
\qquad
\rho(\sigma):=\sigma|_{A_Q}`),
      paragraph(["が定まる。任意の ", math(String.raw`\sigma,\tau\in\operatorname{Gal}(K_Q/\mathbb Q)`), " と ", math(String.raw`\alpha\in A_Q`), " に対して"]),
      displayMath(String.raw`\begin{aligned}
\rho(\sigma\circ\tau)(\alpha)
&=(\sigma\circ\tau)(\alpha)
&&\bigl(\because\ \rho\text{ の定義}\bigr)\\
&=\sigma(\tau(\alpha))
&&\bigl(\because\ \text{写像の合成の定義}\bigr)\\
&=(\rho(\sigma)\circ\rho(\tau))(\alpha)
&&\bigl(\because\ \rho\text{ の定義}\bigr).
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`\rho`), " は群準同型である。次に ", math(String.raw`\rho(\sigma)=\operatorname{id}_{A_Q}`), " と仮定する。すると"]),
      displayMath(String.raw`\sigma(\alpha)=\alpha
\qquad(\alpha\in A_Q).`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"), " より、"]),
      displayMath(String.raw`K_Q=\mathbb Q(A_Q).`),
      paragraph([
        math(String.raw`\sigma`),
        " は ",
        math(String.raw`\mathbb Q`),
        " と全ての ",
        math(String.raw`\alpha\in A_Q`),
        " を固定するので、",
      ]),
      displayMath(String.raw`\sigma=\operatorname{id}_{K_Q}.`),
      paragraph(["よって ", math(String.raw`\ker\rho=\{\operatorname{id}_{K_Q}\}`), " であり、", math(String.raw`\rho`), " は単射である。したがって"]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|
=|\rho(\operatorname{Gal}(K_Q/\mathbb Q))|.`),
      displayMath(String.raw`\rho(\operatorname{Gal}(K_Q/\mathbb Q))
\le\operatorname{Sym}(A_Q).`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`|\rho(\operatorname{Gal}(K_Q/\mathbb Q))|
\mid|\operatorname{Sym}(A_Q)|.`),
      displayMath(String.raw`|\operatorname{Sym}(A_Q)|=|A_Q|!=44!.`),
      paragraph(["有限 Galois 拡大の次数公式により、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]
=\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      displayMath(String.raw`[K_Q:\mathbb Q]\mid44!.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]\in\mathbb N_{>0}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{n\in\mathbb N_{>0}\mid n\mid44!\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の既約因子次数による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-irreducible-factor-multiple"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{44d\mid d\in\mathbb N_{>0},\ d\mid43!\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子 ",
        math(String.raw`Q_Q\in\mathbb Q[x]`),
        " の根を一つ ",
        math(String.raw`\alpha_1\in\overline{\mathbb Q}`),
        " とする。同じ定理より、",
      ]),
      displayMath(String.raw`[\mathbb Q(\alpha_1):\mathbb Q]=44.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"), " より、"]),
      displayMath(String.raw`\mathbb Q(\alpha_1)\subset K_Q.`),
      paragraph(["有限拡大の体の塔の次数公式により、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]
=[K_Q:\mathbb Q(\alpha_1)][\mathbb Q(\alpha_1):\mathbb Q].`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44[K_Q:\mathbb Q(\alpha_1)].`),
      paragraph([
        math(String.raw`d:=[K_Q:\mathbb Q(\alpha_1)]\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"), " より、"]),
      displayMath(String.raw`44d\mid44!.`),
      displayMath(String.raw`44!=44\cdot43!.`),
      displayMath(String.raw`44d\mid44\cdot43!.`),
      paragraph(["正整数の整除関係における四十四の消去により、"]),
      displayMath(String.raw`d\mid43!.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{44d\mid d\in\mathbb N_{>0},\ d\mid43!\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{65780e\,\middle|\,e\in\mathbb N_{>0},\ e\mid\frac{43!}{1495}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=107\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{107}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=43\ne0\in\mathbb F_{107}.`),
      paragraph([
        math(String.raw`\overline{Q}_Q\in\mathbb F_{107}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{107}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\overline{Q}_Q
=63q_1q_2q_5q_{13}q_{23}\in\mathbb F_{107}[x],`),
      displayMath(String.raw`\deg q_j=j
\qquad\bigl(j\in\{1,2,5,13,23\}\bigr),`),
      paragraph([
        "かつ各 ",
        math(String.raw`q_j\in\mathbb F_{107}[x]`),
        " はモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,2,5,13,23`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma`),
        " とする。互いに素な巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma)
&=\operatorname{lcm}(1,2,5,13,23)
&&\bigl(\because\ \sigma\text{ の巡回分解}\bigr)\\
&=2990.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`2990\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`2990\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`2990\mid44d.`),
      displayMath(String.raw`2\cdot1495\mid2\cdot22d.`),
      paragraph(["正整数の整除関係における二の消去により、"]),
      displayMath(String.raw`1495\mid22d.`),
      displayMath(String.raw`\gcd(1495,22)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`1495\mid d.`),
      paragraph([
        math(String.raw`e:=d/1495\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=1495e.`),
      displayMath(String.raw`1495e\mid43!.`),
      paragraph(["正整数の整除関係における千四百九十五の消去により、"]),
      displayMath(String.raw`e\mid\frac{43!}{1495}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot1495e.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=65780e.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{65780e\,\middle|\,e\in\mathbb N_{>0},\ e\mid\frac{43!}{1495}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の二つの有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-two-modular-cycle-constraints"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{26246220f\,\middle|\,f\in\mathbb N_{>0},\ f\mid\frac{43!}{596505}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=101\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{101}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=18\ne0\in\mathbb F_{101}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q\in\mathbb F_{101}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{101}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q
=63r_4r_{19}r_{21}\in\mathbb F_{101}[x],`),
      displayMath(String.raw`\deg r_j=j
\qquad\bigl(j\in\{4,19,21\}\bigr),`),
      paragraph([
        "かつ各 ",
        math(String.raw`r_j\in\mathbb F_{101}[x]`),
        " はモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`4,19,21`),
        " の置換を一つ含む。これを ",
        math(String.raw`\tau`),
        " とする。互いに素な巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\tau)
&=\operatorname{lcm}(4,19,21)
&&\bigl(\because\ \tau\text{ の巡回分解}\bigr)\\
&=1596.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`1596\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`1596\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`2990\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(1596,2990)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`2386020\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`2386020\mid44d.`),
      displayMath(String.raw`4\cdot596505\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`596505\mid11d.`),
      displayMath(String.raw`\gcd(596505,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`596505\mid d.`),
      paragraph([
        math(String.raw`f:=d/596505\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=596505f.`),
      displayMath(String.raw`596505f\mid43!.`),
      paragraph(["正整数の整除関係における五十九万六千五百五の消去により、"]),
      displayMath(String.raw`f\mid\frac{43!}{596505}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot596505f.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=26246220f.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{26246220f\,\middle|\,f\in\mathbb N_{>0},\ f\mid\frac{43!}{596505}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_103_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数百三における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_103_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-103-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{2283421140g\,\middle|\,g\in\mathbb N_{>0},\ g\mid\frac{43!}{51895935}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=103\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{103}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=98\ne0\in\mathbb F_{103}.`),
      paragraph([
        math(String.raw`\widehat{Q}_Q\in\mathbb F_{103}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{103}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widehat{Q}_Q
=63s_2s_4s_9s_{29}\in\mathbb F_{103}[x],`),
      displayMath(String.raw`\deg s_j=j
\qquad\bigl(j\in\{2,4,9,29\}\bigr),`),
      paragraph([
        "かつ各 ",
        math(String.raw`s_j\in\mathbb F_{103}[x]`),
        " はモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`2,4,9,29`),
        " の置換を一つ含む。これを ",
        math(String.raw`\upsilon`),
        " とする。互いに素な巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\upsilon)
&=\operatorname{lcm}(2,4,9,29)
&&\bigl(\because\ \upsilon\text{ の巡回分解}\bigr)\\
&=1044.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`1044\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`1044\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_two_modular_cycle_constraints"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=26246220f,
\qquad
f\in\mathbb N_{>0},
\qquad
f\mid\frac{43!}{596505}.`),
      displayMath(String.raw`26246220=11\cdot2386020.`),
      displayMath(String.raw`2386020\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(1044,2386020)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`207583740\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`207583740\mid44d.`),
      displayMath(String.raw`4\cdot51895935\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`51895935\mid11d.`),
      displayMath(String.raw`\gcd(51895935,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`51895935\mid d.`),
      paragraph([
        math(String.raw`g:=d/51895935\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=51895935g.`),
      displayMath(String.raw`51895935g\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`g\mid\frac{43!}{51895935}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot51895935g.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=2283421140g.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{2283421140g\,\middle|\,g\in\mathbb N_{>0},\ g\mid\frac{43!}{51895935}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数百三十一における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-131-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{93620266740h\,\middle|\,h\in\mathbb N_{>0},\ h\mid\frac{43!}{2127733335}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=131\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{131}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=18\ne0\in\mathbb F_{131}.`),
      paragraph([
        math(String.raw`\breve{Q}_Q\in\mathbb F_{131}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{131}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\breve{Q}_Q
=63t_1t_2t_{41}\in\mathbb F_{131}[x],`),
      displayMath(String.raw`\deg t_j=j
\qquad\bigl(j\in\{1,2,41\}\bigr),`),
      paragraph([
        "かつ各 ",
        math(String.raw`t_j\in\mathbb F_{131}[x]`),
        " はモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,2,41`),
        " の置換を一つ含む。これを ",
        math(String.raw`\tau`),
        " とする。互いに素な巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\tau)
&=\operatorname{lcm}(1,2,41)
&&\bigl(\because\ \tau\text{ の巡回分解}\bigr)\\
&=82.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`82\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`82\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_103_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`207583740\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(82,207583740)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`8510933340\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`8510933340\mid44d.`),
      displayMath(String.raw`4\cdot2127733335\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`2127733335\mid11d.`),
      displayMath(String.raw`\gcd(2127733335,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`2127733335\mid d.`),
      paragraph([
        math(String.raw`h:=d/2127733335\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=2127733335h.`),
      displayMath(String.raw`2127733335h\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`h\mid\frac{43!}{2127733335}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot2127733335h.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=93620266740h.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{93620266740h\,\middle|\,h\in\mathbb N_{>0},\ h\mid\frac{43!}{2127733335}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_149_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数百四十九における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_149_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-149-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{468101333700i\,\middle|\,i\in\mathbb N_{>0},\ i\mid\frac{43!}{10638666675}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=149\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{149}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=57\ne0\in\mathbb F_{149}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(149)}\in\mathbb F_{149}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{149}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(149)}
=63u_1u_{2,1}u_{2,2}u_4u_{5,1}u_{5,2}u_{25}\in\mathbb F_{149}[x],`),
      displayMath(String.raw`\deg u_1=1,\quad
\deg u_{2,1}=\deg u_{2,2}=2,\quad
\deg u_4=4,\quad
\deg u_{5,1}=\deg u_{5,2}=5,\quad
\deg u_{25}=25,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{149}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,2,2,4,5,5,25`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{149}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{149})
&=\operatorname{lcm}(1,2,2,4,5,5,25)
&&\bigl(\because\ \sigma_{149}\text{ の巡回分解}\bigr)\\
&=100.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`100\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`100\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`8510933340\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(100,8510933340)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`42554666700\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`42554666700\mid44d.`),
      displayMath(String.raw`4\cdot10638666675\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`10638666675\mid11d.`),
      displayMath(String.raw`\gcd(10638666675,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`10638666675\mid d.`),
      paragraph([
        math(String.raw`i:=d/10638666675\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=10638666675i.`),
      displayMath(String.raw`10638666675i\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`i\mid\frac{43!}{10638666675}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot10638666675i.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=468101333700i.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{468101333700i\,\middle|\,i\in\mathbb N_{>0},\ i\mid\frac{43!}{10638666675}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数百六十三における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-163-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{17319749346900j\,\middle|\,j\in\mathbb N_{>0},\ j\mid\frac{43!}{393630666975}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=163\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{163}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=2\ne0\in\mathbb F_{163}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(163)}\in\mathbb F_{163}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{163}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(163)}
=63v_1v_6v_{37}\in\mathbb F_{163}[x],`),
      displayMath(String.raw`\deg v_1=1,\qquad
\deg v_6=6,\qquad
\deg v_{37}=37,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{163}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,6,37`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{163}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{163})
&=\operatorname{lcm}(1,6,37)
&&\bigl(\because\ \sigma_{163}\text{ の巡回分解}\bigr)\\
&=222.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`222\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`222\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_149_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`42554666700\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(222,42554666700)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`1574522667900\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`1574522667900\mid44d.`),
      displayMath(String.raw`4\cdot393630666975\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`393630666975\mid11d.`),
      displayMath(String.raw`\gcd(393630666975,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`393630666975\mid d.`),
      paragraph([
        math(String.raw`j:=d/393630666975\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=393630666975j.`),
      displayMath(String.raw`393630666975j\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`j\mid\frac{43!}{393630666975}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot393630666975j.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=17319749346900j.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{17319749346900j\,\middle|\,j\in\mathbb N_{>0},\ j\mid\frac{43!}{393630666975}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数百六十七における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-167-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{34639498693800k\,\middle|\,k\in\mathbb N_{>0},\ k\mid\frac{43!}{787261333950}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=167\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{167}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=143\ne0\in\mathbb F_{167}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(167)}\in\mathbb F_{167}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{167}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(167)}
=63v_1v_2v_{4,1}v_{4,2}v_6v_8v_{19}\in\mathbb F_{167}[x],`),
      displayMath(String.raw`\deg v_1=1,\qquad
\deg v_2=2,\qquad
\deg v_{4,1}=\deg v_{4,2}=4,\qquad
\deg v_6=6,\qquad
\deg v_8=8,\qquad
\deg v_{19}=19,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{167}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,2,4,4,6,8,19`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{167}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{167})
&=\operatorname{lcm}(1,2,4,4,6,8,19)
&&\bigl(\because\ \sigma_{167}\text{ の巡回分解}\bigr)\\
&=456.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`456\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`456\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_163_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`1574522667900\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(456,1574522667900)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`3149045335800\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`3149045335800\mid44d.`),
      displayMath(String.raw`4\cdot787261333950\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`787261333950\mid11d.`),
      displayMath(String.raw`\gcd(787261333950,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`787261333950\mid d.`),
      paragraph([
        math(String.raw`k:=d/787261333950\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=787261333950k.`),
      displayMath(String.raw`787261333950k\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`k\mid\frac{43!}{787261333950}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot787261333950k.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=34639498693800k.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{34639498693800k\,\middle|\,k\in\mathbb N_{>0},\ k\mid\frac{43!}{787261333950}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_229_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数二百二十九における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_229_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-229-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{103918496081400m\,\middle|\,m\in\mathbb N_{>0},\ m\mid\frac{43!}{2361784001850}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=229\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{229}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=83\ne0\in\mathbb F_{229}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(229)}\in\mathbb F_{229}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{229}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(229)}
=63v_1v_3v_{13}v_{27}\in\mathbb F_{229}[x],`),
      displayMath(String.raw`\deg v_1=1,\qquad
\deg v_3=3,\qquad
\deg v_{13}=13,\qquad
\deg v_{27}=27,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{229}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,3,13,27`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{229}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{229})
&=\operatorname{lcm}(1,3,13,27)
&&\bigl(\because\ \sigma_{229}\text{ の巡回分解}\bigr)\\
&=351.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`351\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`351\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_167_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`3149045335800\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(351,3149045335800)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`9447136007400\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`9447136007400\mid44d.`),
      displayMath(String.raw`4\cdot2361784001850\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`2361784001850\mid11d.`),
      displayMath(String.raw`\gcd(2361784001850,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`2361784001850\mid d.`),
      paragraph([
        math(String.raw`m:=d/2361784001850\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=2361784001850m.`),
      displayMath(String.raw`2361784001850m\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`m\mid\frac{43!}{2361784001850}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot2361784001850m.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=103918496081400m.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{103918496081400m\,\middle|\,m\in\mathbb N_{>0},\ m\mid\frac{43!}{2361784001850}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数二百三十三における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-233-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{1766614433383800n\,\middle|\,n\in\mathbb N_{>0},\ n\mid\frac{43!}{40150328031450}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=233\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{233}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=212\ne0\in\mathbb F_{233}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(233)}\in\mathbb F_{233}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{233}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(233)}
=63w_1w_2w_{3,1}w_{3,2}w_4w_{14}w_{17}\in\mathbb F_{233}[x],`),
      displayMath(String.raw`\deg w_1=1,\qquad
\deg w_2=2,\qquad
\deg w_{3,1}=\deg w_{3,2}=3,\qquad
\deg w_4=4,\qquad
\deg w_{14}=14,\qquad
\deg w_{17}=17,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{233}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,2,3,3,4,14,17`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{233}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{233})
&=\operatorname{lcm}(1,2,3,3,4,14,17)
&&\bigl(\because\ \sigma_{233}\text{ の巡回分解}\bigr)\\
&=1428.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`1428\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`1428\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_229_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`9447136007400\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(1428,9447136007400)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`160601312125800\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`160601312125800\mid44d.`),
      displayMath(String.raw`4\cdot40150328031450\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`40150328031450\mid11d.`),
      displayMath(String.raw`\gcd(40150328031450,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`40150328031450\mid d.`),
      paragraph([
        math(String.raw`n:=d/40150328031450\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=40150328031450n.`),
      displayMath(String.raw`40150328031450n\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`n\mid\frac{43!}{40150328031450}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot40150328031450n.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=1766614433383800n.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{1766614433383800n\,\middle|\,n\in\mathbb N_{>0},\ n\mid\frac{43!}{40150328031450}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数二百九十三における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-293-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{54765047434897800r\,\middle|\,r\in\mathbb N_{>0},\ r\mid\frac{43!}{1244660168974950}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=293\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{293}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=76\ne0\in\mathbb F_{293}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(293)}\in\mathbb F_{293}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{293}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(293)}
=63w_1w_{12}w_{31}\in\mathbb F_{293}[x],`),
      displayMath(String.raw`\deg w_1=1,\qquad
\deg w_{12}=12,\qquad
\deg w_{31}=31,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{293}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,12,31`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{293}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{293})
&=\operatorname{lcm}(1,12,31)
&&\bigl(\because\ \sigma_{293}\text{ の巡回分解}\bigr)\\
&=372.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`372\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`372\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_233_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`160601312125800\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(372,160601312125800)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`4978640675899800\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`4978640675899800\mid44d.`),
      displayMath(String.raw`4\cdot1244660168974950\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`1244660168974950\mid11d.`),
      displayMath(String.raw`\gcd(1244660168974950,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`1244660168974950\mid d.`),
      paragraph([
        math(String.raw`r:=d/1244660168974950\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=1244660168974950r.`),
      displayMath(String.raw`1244660168974950r\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`r\mid\frac{43!}{1244660168974950}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot1244660168974950r.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=54765047434897800r.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{54765047434897800r\,\middle|\,r\in\mathbb N_{>0},\ r\mid\frac{43!}{1244660168974950}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数三百六十七における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-367-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{109530094869795600s\,\middle|\,s\in\mathbb N_{>0},\ s\mid\frac{43!}{2489320337949900}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=367\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{367}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=48\ne0\in\mathbb F_{367}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(367)}\in\mathbb F_{367}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{367}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(367)}
=63w_{1,1}w_{1,2}w_{1,3}w_7w_8w_{10}w_{16}\in\mathbb F_{367}[x],`),
      displayMath(String.raw`\deg w_{1,1}=\deg w_{1,2}=\deg w_{1,3}=1,\qquad
\deg w_7=7,\qquad
\deg w_8=8,\qquad
\deg w_{10}=10,\qquad
\deg w_{16}=16,`),
      paragraph([
        "かつ各因子は ",
        math(String.raw`\mathbb F_{367}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,1,1,7,8,10,16`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{367}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{367})
&=\operatorname{lcm}(1,1,1,7,8,10,16)
&&\bigl(\because\ \sigma_{367}\text{ の巡回分解}\bigr)\\
&=560.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`560\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`560\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_293_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`4978640675899800\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(560,4978640675899800)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`9957281351799600\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`9957281351799600\mid44d.`),
      displayMath(String.raw`4\cdot2489320337949900\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`2489320337949900\mid11d.`),
      displayMath(String.raw`\gcd(2489320337949900,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`2489320337949900\mid d.`),
      paragraph([
        math(String.raw`s:=d/2489320337949900\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=2489320337949900s.`),
      displayMath(String.raw`2489320337949900s\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`s\mid\frac{43!}{2489320337949900}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot2489320337949900s.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=109530094869795600s.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{109530094869795600s\,\middle|\,s\in\mathbb N_{>0},\ s\mid\frac{43!}{2489320337949900}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数三百八十九における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-389-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{4709794079401210800t\,\middle|\,t\in\mathbb N_{>0},\ t\mid\frac{43!}{107040774531845700}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=389\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{389}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=28\ne0\in\mathbb F_{389}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(389)}\in\mathbb F_{389}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{389}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(389)}=63w_1w_{43}\in\mathbb F_{389}[x],`),
      displayMath(String.raw`\deg w_1=1,
\qquad
\deg w_{43}=43,`),
      paragraph([
        "かつ二因子は ",
        math(String.raw`\mathbb F_{389}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`1,43`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{389}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{389})
&=\operatorname{lcm}(1,43)
&&\bigl(\because\ \sigma_{389}\text{ の巡回分解}\bigr)\\
&=43.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`43\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`43\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_367_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`9957281351799600\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(43,9957281351799600)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`428163098127382800\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`428163098127382800\mid44d.`),
      displayMath(String.raw`4\cdot107040774531845700\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`107040774531845700\mid11d.`),
      displayMath(String.raw`\gcd(107040774531845700,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`107040774531845700\mid d.`),
      paragraph([
        math(String.raw`t:=d/107040774531845700\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=107040774531845700t.`),
      displayMath(String.raw`107040774531845700t\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`t\mid\frac{43!}{107040774531845700}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot107040774531845700t.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=4709794079401210800t.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{4709794079401210800t\,\middle|\,t\in\mathbb N_{>0},\ t\mid\frac{43!}{107040774531845700}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数の素数七百九における有限体分解型による絞り込み" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-prime-709-modular-cycle-constraint"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{9419588158802421600u\,\middle|\,u\in\mathbb N_{>0},\ u\mid\frac{43!}{214081549063691400}\right\}.`),
      paragraph([
        "複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、素数を ",
        math(String.raw`p:=709\in\mathbb N`),
        " とする。",
        math(String.raw`\operatorname{lc}(Q_Q)\in\mathbb Z`),
        " を先頭係数、",
        math(String.raw`\operatorname{disc}(Q_Q)\in\mathbb Z`),
        " を判別式と書く。整数係数による厳密計算から、",
      ]),
      displayMath(String.raw`\operatorname{lc}(Q_Q)\bmod p=63\ne0\in\mathbb F_{709}.`),
      displayMath(String.raw`\operatorname{disc}(Q_Q)\bmod p=489\ne0\in\mathbb F_{709}.`),
      paragraph([
        math(String.raw`\widetilde{Q}_Q^{(709)}\in\mathbb F_{709}[x]`),
        " を ",
        math(String.raw`Q_Q`),
        " の係数を ",
        math(String.raw`\mathbb F_{709}`),
        " へ移した多項式とする。有限体上の厳密因数分解により、",
      ]),
      displayMath(String.raw`\widetilde{Q}_Q^{(709)}=63w_{12}w_{32}\in\mathbb F_{709}[x],`),
      displayMath(String.raw`\deg w_{12}=12,
\qquad
\deg w_{32}=32,`),
      paragraph([
        "かつ二因子は ",
        math(String.raw`\mathbb F_{709}[x]`),
        " のモニック既約多項式である。先頭係数と判別式が ",
        math(String.raw`p`),
        " で零でないので、Dedekind の有限体分解型定理により、",
        math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`),
        " は四十四根上で巡回長 ",
        math(String.raw`12,32`),
        " の置換を一つ含む。これを ",
        math(String.raw`\sigma_{709}`),
        " とする。巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{ord}(\sigma_{709})
&=\operatorname{lcm}(12,32)
&&\bigl(\because\ \sigma_{709}\text{ の巡回分解}\bigr)\\
&=96.
\end{aligned}`),
      paragraph(["Lagrange の定理により、"]),
      displayMath(String.raw`96\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_divides_factorial"),
        " の証明で得た有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      displayMath(String.raw`96\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`428163098127382800\mid[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`\operatorname{lcm}(96,428163098127382800)\mid[K_Q:\mathbb Q].`),
      displayMath(String.raw`856326196254765600\mid[K_Q:\mathbb Q].`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"), " より、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0},
\qquad
d\mid43!.`),
      displayMath(String.raw`856326196254765600\mid44d.`),
      displayMath(String.raw`4\cdot214081549063691400\mid4\cdot11d.`),
      paragraph(["正整数の整除関係における四の消去により、"]),
      displayMath(String.raw`214081549063691400\mid11d.`),
      displayMath(String.raw`\gcd(214081549063691400,11)=1.`),
      paragraph(["Euclid の補題により、"]),
      displayMath(String.raw`214081549063691400\mid d.`),
      paragraph([
        math(String.raw`u:=d/214081549063691400\in\mathbb N_{>0}`),
        " と置く。すると",
      ]),
      displayMath(String.raw`d=214081549063691400u.`),
      displayMath(String.raw`214081549063691400u\mid43!.`),
      paragraph(["正整数の整除関係における共通因子の消去により、"]),
      displayMath(String.raw`u\mid\frac{43!}{214081549063691400}.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
=44\cdot214081549063691400u.`),
      displayMath(String.raw`[K_Q:\mathbb Q]=9419588158802421600u.`),
      displayMath(String.raw`[K_Q:\mathbb Q]
\in\left\{9419588158802421600u\,\middle|\,u\in\mathbb N_{>0},\ u\mid\frac{43!}{214081549063691400}\right\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体次数に対する単一有限体分解型制約の飽和" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_degree_single_prime_cycle_constraint_saturation"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-degree-single-prime-cycle-constraint-saturation"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体を ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " とする。次数四十四の既約因子の先頭係数と判別式を法として零にしない任意の素数 ",
        math(String.raw`p\in\mathbb N`),
        " について、その有限体分解型から得られる一つの置換位数制約を既存制約へ加えても、",
      ]),
      displayMath(String.raw`214081549063691400\mid d,
\qquad
[K_Q:\mathbb Q]=44d,
\qquad
d\in\mathbb N_{>0}`),
      paragraph(["より強い整除条件を ", math(String.raw`d`), " に課すことはできない。"]),
      paragraph(["複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。"]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint"), " より、"]),
      displayMath(String.raw`D:=856326196254765600\mid[K_Q:\mathbb Q],`),
      displayMath(String.raw`q:=214081549063691400\mid d.`),
      paragraph([
        math(String.raw`L\in\mathbb N_{>0}`),
        " を一から四十四までの正整数の最小公倍数とする。素因数指数ごとの有限計算により、",
      ]),
      displayMath(String.raw`L:=\operatorname{lcm}(1,2,\ldots,44)=9419588158802421600=11D.`),
      paragraph([
        math(String.raw`p\in\mathbb N`),
        " を主張の条件を満たす素数とし、その有限体分解型が与える四十四根上の置換を ",
        math(String.raw`\sigma_p`),
        "、その位数を ",
        math(String.raw`o_p\in\mathbb N_{>0}`),
        " とする。",
        math(String.raw`\sigma_p`),
        " の各巡回長は一以上四十四以下なので、巡回置換の積の位数公式により、",
      ]),
      displayMath(String.raw`o_p\mid L.`),
      paragraph(["Dedekind の有限体分解型定理により ", math(String.raw`\sigma_p`), " は ", math(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)`), " の元である。Lagrange の定理と有限 Galois 拡大の次数公式により、"]),
      displayMath(String.raw`o_p\mid\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|=[K_Q:\mathbb Q].`),
      paragraph(["正整数の最小公倍数の性質により、"]),
      displayMath(String.raw`D\mid\operatorname{lcm}(D,o_p).`),
      displayMath(String.raw`\operatorname{lcm}(D,o_p)\mid L.`),
      displayMath(String.raw`\operatorname{lcm}(D,o_p)\mid[K_Q:\mathbb Q].`),
      paragraph([math(String.raw`L/D=11`), " は素数なので、"]),
      displayMath(String.raw`\operatorname{lcm}(D,o_p)\in\{D,11D\}.`),
      displayMath(String.raw`\gcd(D,44)=4.`),
      displayMath(String.raw`\frac{D}{\gcd(D,44)}=q.`),
      displayMath(String.raw`\gcd(11D,44)=44.`),
      displayMath(String.raw`\frac{11D}{\gcd(11D,44)}=q.`),
      paragraph(["したがって、二つの場合のいずれでも、"]),
      displayMath(String.raw`\frac{\operatorname{lcm}(D,o_p)}{
  \gcd(\operatorname{lcm}(D,o_p),44)
}=q.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_irreducible_factor_multiple"),
        " の次数表示と正整数の整除関係における最大公約数による因子消去により、",
      ]),
      displayMath(String.raw`\operatorname{lcm}(D,o_p)\mid44d.`),
      displayMath(String.raw`
\frac{\operatorname{lcm}(D,o_p)}{
  \gcd(\operatorname{lcm}(D,o_p),44)
}\mid d.`),
      displayMath(String.raw`q\mid d.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_709_modular_cycle_constraint"), " で既に ", math(String.raw`q\mid d`), " を得ているので、単一の有限体分解型から得る置換位数制約ではこれを強められない。"]),
    ],
  },
  {
    id: "arithmetic_invariants_definition_fixed_quotient_fisher_root_set",
    kind: "definition",
    title: { text: "固定剰余類格子の次数四十四因子の根集合" },
    labels: ["def_fixed_quotient_fisher_root_set"],
    habitat: "Qbar",
    statement: [
      paragraph([ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"), " の既約因子 ", math(String.raw`Q_Q\in\mathbb Z[x]`), " の根集合を"]),
      displayMath(String.raw`\mathcal R_Q:=\{\alpha\in\overline{\mathbb Q}\mid Q_Q(\alpha)=0\}`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "arithmetic_invariants_definition_fixed_quotient_galois_restriction_representation",
    kind: "definition",
    title: { text: "固定剰余類格子の Galois 制限表現" },
    labels: ["def_fixed_quotient_galois_restriction_representation"],
    habitat: "Qbar",
    statement: [
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"), " の分解体 ", math(String.raw`K_Q`), " と ", ref("def_fixed_quotient_fisher_root_set"), " の根集合に対し、体自己同型の制限表現を"]),
      displayMath(String.raw`\rho_Q:\operatorname{Gal}(K_Q/\mathbb Q)\longrightarrow\operatorname{Sym}(\mathcal R_Q),\qquad \rho_Q(\sigma):=\sigma|_{\mathcal R_Q}`),
      paragraph(["と定める。分解体の自己同型は根集合を保つため well-defined である。"]),
    ],
  },
  {
    id: "arithmetic_invariants_definition_fixed_quotient_galois_permutation_image",
    kind: "definition",
    title: { text: "固定剰余類格子の Galois 置換像" },
    labels: ["def_fixed_quotient_galois_permutation_image"],
    habitat: "Qbar",
    statement: [
      paragraph([ref("def_fixed_quotient_galois_restriction_representation"), " の像を"]),
      displayMath(String.raw`\Gamma_Q:=\rho_Q(\operatorname{Gal}(K_Q/\mathbb Q))\leq\operatorname{Sym}(\mathcal R_Q)`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "固定剰余類格子の Fisher 分解体 Galois 群の全対称群同定" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-full-symmetric-galois-group"],
    statement: [
      paragraph([
        ref("def_fixed_quotient_galois_permutation_image"), " の Galois 置換像を取る。このとき",
      ]),
      displayMath(String.raw`\Gamma_Q=\operatorname{Sym}(\mathcal R_Q)`),
      paragraph(["である。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。"]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " より ",
        math(String.raw`Q_Q`),
        " は ",
        math(String.raw`\mathbb Q[x]`),
        " 上で既約かつ分離的であり、",
      ]),
      displayMath(String.raw`|\mathcal R_Q|=44.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " の分解体の構成により、",
      ]),
      displayMath(String.raw`\Gamma_Q=\rho_Q\!\left(\operatorname{Gal}(K_Q/\mathbb Q)\right)
\subseteq\operatorname{Sym}(\mathcal R_Q).`),
      paragraph([
        math(String.raw`Q_Q`),
        " の既約性により、",
        math(String.raw`\Gamma_Q`),
        " の ",
        math(String.raw`\mathcal R_Q`),
        " への作用は推移的である。",
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_389_modular_cycle_constraint"),
        " の有限体分解型により、",
        math(String.raw`\Gamma_Q`),
        " は一根 ",
        math(String.raw`\alpha_0\in\mathcal R_Q`),
        " を固定し、",
        math(String.raw`\mathcal R_Q\setminus\{\alpha_0\}`),
        " を一つの四十三巡回とする置換 ",
        math(String.raw`\sigma_{389}\in \Gamma_Q`),
        " を含む。",
      ]),
      paragraph([
        math(String.raw`\mathcal B\subset\mathcal R_Q`),
        " を ",
        math(String.raw`\alpha_0\in\mathcal B`),
        " を満たす ",
        math(String.raw`\Gamma_Q`),
        " のブロックとする。",
        math(String.raw`\mathcal B\ne\{\alpha_0\}`),
        " ならば ",
        math(String.raw`\beta\in\mathcal B\setminus\{\alpha_0\}`),
        " を一つ選べる。任意の ",
        math(String.raw`\gamma\in\mathcal R_Q\setminus\{\alpha_0\}`),
        " に対し、四十三巡回の推移性から、ある ",
        math(String.raw`j\in\{0,1,\ldots,42\}`),
        " が存在して",
      ]),
      displayMath(String.raw`\sigma_{389}^{j}(\beta)=\gamma.`),
      paragraph([
        math(String.raw`\sigma_{389}^{j}`),
        " は ",
        math(String.raw`\alpha_0`),
        " を固定するので、",
      ]),
      displayMath(String.raw`\alpha_0\in
\sigma_{389}^{j}(\mathcal B)\cap\mathcal B.`),
      paragraph(["ブロックの定義により、"]),
      displayMath(String.raw`\sigma_{389}^{j}(\mathcal B)=\mathcal B.`),
      displayMath(String.raw`\gamma=\sigma_{389}^{j}(\beta)\in\mathcal B.`),
      paragraph([
        math(String.raw`\gamma`),
        " は ",
        math(String.raw`\mathcal R_Q\setminus\{\alpha_0\}`),
        " の任意の元だったので、",
      ]),
      displayMath(String.raw`\mathcal B=\mathcal R_Q.`),
      paragraph([
        math(String.raw`\mathcal C\subset\mathcal R_Q`),
        " を任意の空でないブロックとし、",
        math(String.raw`\delta\in\mathcal C`),
        " を選ぶ。作用の推移性により、ある ",
        math(String.raw`g\in \Gamma_Q`),
        " が存在して ",
        math(String.raw`g(\delta)=\alpha_0`),
        " となる。",
        math(String.raw`g(\mathcal C)`),
        " は ",
        math(String.raw`\alpha_0`),
        " を含むブロックなので、一元集合または ",
        math(String.raw`\mathcal R_Q`),
        " である。したがって ",
        math(String.raw`\mathcal C`),
        " も一元集合または ",
        math(String.raw`\mathcal R_Q`),
        " である。ゆえに ",
        math(String.raw`\Gamma_Q`),
        " の作用は原始的である。",
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_prime_131_modular_cycle_constraint"),
        " の有限体分解型により、",
        math(String.raw`\Gamma_Q`),
        " は巡回長 ",
        math(String.raw`1,2,41`),
        " の置換 ",
        math(String.raw`\sigma_{131}`),
        " を含む。",
      ]),
      displayMath(String.raw`\gcd(2,41)=1.`),
      paragraph(["よって、"]),
      displayMath(String.raw`\sigma_{131}^{2}`),
      paragraph(["は四十一巡回と三つの不動点からなる。"]),
      displayMath(String.raw`41\le44-3.`),
      paragraph([
        math(String.raw`41\in\mathbb N`),
        " は素数である。原始的な四十四文字上の置換群が素数長 ",
        math(String.raw`p\le44-3`),
        " の巡回置換を含むとき交代群を含むという Jordan の素数巡回定理により、",
      ]),
      displayMath(String.raw`\operatorname{Alt}(\mathcal R_Q)\subset \Gamma_Q.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_degree_modular_cycle_constraint"),
        " の有限体分解型により、",
        math(String.raw`\Gamma_Q`),
        " は巡回長 ",
        math(String.raw`1,2,5,13,23`),
        " の置換 ",
        math(String.raw`\sigma_{107}`),
        " を含む。巡回置換の符号公式により、",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{sgn}(\sigma_{107})
&=(-1)^{(1-1)+(2-1)+(5-1)+(13-1)+(23-1)}
&&\bigl(\because\ \sigma_{107}\text{ の巡回分解}\bigr)\\
&=(-1)^{39}\\
&=-1.
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`\Gamma_Q`),
        " は ",
        math(String.raw`\operatorname{Alt}(\mathcal R_Q)`),
        " を含み、かつ奇置換を含む。交代群が全対称群の指数二の部分群であることから、",
      ]),
      displayMath(String.raw`\Gamma_Q=\operatorname{Sym}(\mathcal R_Q).`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_exact_degree",
    kind: "theorem",
    standing: "mainTheorem",
    title: { text: "固定剰余類格子の Fisher 分解体の厳密次数" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_exact_degree"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-exact-degree"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " で構成した分解体 ",
        math(String.raw`K_Q\subset\overline{\mathbb Q}`),
        " の次数は厳密に",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44!`),
      paragraph(["である。複素平面への埋め込み、数値近似、距離、偏角、実数、極限、積分を用いない。"]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " より ",
        math(String.raw`K_Q/\mathbb Q`),
        " は有限 Galois 拡大である。有限 Galois 拡大の次数公式により、",
      ]),
      displayMath(String.raw`[K_Q:\mathbb Q]
=\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|.`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group"), " より、"]),
      displayMath(String.raw`\left|\operatorname{Gal}(K_Q/\mathbb Q)\right|
=\left|\operatorname{Sym}(\mathcal R_Q)\right|.`),
      paragraph(["有限集合上の全対称群の位数公式により、"]),
      displayMath(String.raw`\left|\operatorname{Sym}(\mathcal R_Q)\right|
=|\mathcal R_Q|!.`),
      paragraph([ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"), " より、"]),
      displayMath(String.raw`|\mathcal R_Q|!=44!.`),
      paragraph(["したがって、"]),
      displayMath(String.raw`[K_Q:\mathbb Q]=44!.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 分解体 Galois 群の非可解性" },
    labels: ["theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-splitting-field-galois-group-nonsolvable"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group"),
        " で定めた忠実置換表現の像 ",
        math(String.raw`\Gamma_Q=\rho_Q(\operatorname{Gal}(K_Q/\mathbb Q))`),
        " を用いる。交換子部分群を用いて導来列を",
      ]),
      displayMath(String.raw`\Gamma_Q^{(0)}:=\Gamma_Q,
\qquad
\Gamma_Q^{(r+1)}:=[\Gamma_Q^{(r)},\Gamma_Q^{(r)}]
\quad(r\in\mathbb N)`),
      paragraph(["と定める。このとき、任意の ", math(String.raw`r\in\mathbb N`), " に対して"]),
      displayMath(String.raw`\Gamma_Q^{(r)}\ne\{\operatorname{id}_{\mathcal R_Q}\}`),
      paragraph(["である。したがって ", math(String.raw`\Gamma_Q`), " は可解群ではない。有限集合と有限置換群だけを用い、実数、複素数、極限、積分を用いない。"]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_full_symmetric_galois_group"), " より、"]),
      displayMath(String.raw`\Gamma_Q
=\operatorname{Sym}(\mathcal R_Q).`),
      paragraph(["導来列の定義より、"]),
      displayMath(String.raw`\Gamma_Q^{(0)}=\Gamma_Q.`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\Gamma_Q^{(0)}
=\operatorname{Sym}(\mathcal R_Q).`),
      paragraph([ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"), " より、"]),
      displayMath(String.raw`|\mathcal R_Q|=44.`),
      paragraph(["導来列の定義より、"]),
      displayMath(String.raw`\Gamma_Q^{(1)}
=[\operatorname{Sym}(\mathcal R_Q),\operatorname{Sym}(\mathcal R_Q)].`),
      paragraph(["三元以上の有限集合上の全対称群の交換子部分群は交代群なので、"]),
      displayMath(String.raw`[\operatorname{Sym}(\mathcal R_Q),\operatorname{Sym}(\mathcal R_Q)]
=\operatorname{Alt}(\mathcal R_Q).`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\Gamma_Q^{(1)}=\operatorname{Alt}(\mathcal R_Q).`),
      paragraph([
        math(String.raw`44\ge5`),
        " なので、五元以上の有限集合上の交代群が非可換単純群であることを適用する。交換子部分群は正規部分群であり、非可換性により自明群ではない。単純性により、",
      ]),
      displayMath(String.raw`[\operatorname{Alt}(\mathcal R_Q),\operatorname{Alt}(\mathcal R_Q)]
=\operatorname{Alt}(\mathcal R_Q).`),
      paragraph(["以上を基底段階とし、導来列の定義を帰納段階に用いると、任意の ", math(String.raw`r\in\mathbb N_{>0}`), " に対して、"]),
      displayMath(String.raw`\Gamma_Q^{(r)}
=\operatorname{Alt}(\mathcal R_Q).`),
      paragraph(["特に任意の ", math(String.raw`r\in\mathbb N`), " に対して、"]),
      displayMath(String.raw`\Gamma_Q^{(r)}\ne\{\operatorname{id}_{\mathcal R_Q}\}.`),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 既約因子の根式非可解性" },
    labels: ["theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-irreducible-factor-not-solvable-by-radicals"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"),
        " の次数四十四の既約因子を ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " とし、その根集合を ",
        math(String.raw`\mathcal R_Q\subset\overline{\mathbb Q}`),
        " とする。このとき、次の条件を満たす部分体の有限列は存在しない。",
      ]),
      displayMath(String.raw`\mathbb Q=F_0\subset F_1\subset\cdots\subset F_m\subset\overline{\mathbb Q},
\qquad
\mathcal R_Q\subset F_m,`),
      displayMath(String.raw`\forall i\in\{1,\ldots,m\}\quad
\exists a_i\in F_i\quad
\exists n_i\in\mathbb N_{>0}\quad
F_i=F_{i-1}(a_i),
\qquad
a_i^{n_i}\in F_{i-1}.`),
      paragraph([
        "したがって ",
        math(String.raw`Q_Q`),
        " は ",
        math(String.raw`\mathbb Q`),
        " 上で根式によって解けない。実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"), " より、"]),
      displayMath(String.raw`Q_Q\in\mathbb Q[x]`),
      paragraph(["は既約な次数四十四の多項式である。また有理数体の標数は零なので、"]),
      displayMath(String.raw`\operatorname{char}(\mathbb Q)=0.`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_splitting_field_finite_degree"),
        " の構成より、",
      ]),
      displayMath(String.raw`K_Q=\mathbb Q(\mathcal R_Q)`),
      paragraph(["は ", math(String.raw`Q_Q`), " の分解体である。標数零の多項式に対する根式可解性の Galois 判定より、"]),
      displayMath(String.raw`\begin{aligned}
&\exists m\in\mathbb N\ \exists F_0,\ldots,F_m\subset\overline{\mathbb Q}\quad
\mathbb Q=F_0\subset\cdots\subset F_m,
\quad \mathcal R_Q\subset F_m,\\
&\qquad\forall i\in\{1,\ldots,m\}\ \exists a_i\in F_i\ \exists n_i\in\mathbb N_{>0}\quad
F_i=F_{i-1}(a_i),\quad a_i^{n_i}\in F_{i-1}
\\
&\iff \operatorname{Gal}(K_Q/\mathbb Q)\text{ は可解群である}.
\end{aligned}`),
      paragraph([ref("theorem_fixed_quotient_fisher_splitting_field_galois_group_nonsolvable"), " より、"]),
      displayMath(String.raw`\operatorname{Gal}(K_Q/\mathbb Q)\text{ は可解群ではない}.`),
      paragraph(["したがって、上の同値性の左辺は偽である。ゆえに所定の有限列は存在せず、", math(String.raw`Q_Q`), " は ", math(String.raw`\mathbb Q`), " 上で根式によって解けない。"]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_partition_polynomial_not_solvable_by_radicals",
    kind: "theorem",
    title: { text: "固定剰余類格子の Ising 分配多項式の根式非可解性" },
    labels: ["theorem_fixed_quotient_partition_polynomial_not_solvable_by_radicals"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-partition-polynomial-not-solvable-by-radicals"],
    statement: [
      paragraph([
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " の固定剰余類格子の Ising 分配多項式を ",
        math(String.raw`Z_Q\in\mathbb Z[x]`),
        " とし、その根集合を ",
        math(String.raw`\mathcal Z_Q:=\{\alpha\in\overline{\mathbb Q}\mid Z_Q(\alpha)=0\}`),
        " とする。このとき、次の条件を満たす部分体の有限列は存在しない。",
      ]),
      displayMath(String.raw`\mathbb Q=F_0\subset F_1\subset\cdots\subset F_m\subset\overline{\mathbb Q},
\qquad
\mathcal Z_Q\subset F_m,`),
      displayMath(String.raw`\forall i\in\{1,\ldots,m\}\quad
\exists a_i\in F_i\quad
\exists n_i\in\mathbb N_{>0}\quad
F_i=F_{i-1}(a_i),
\qquad
a_i^{n_i}\in F_{i-1}.`),
      paragraph([
        "したがって ",
        math(String.raw`Z_Q`),
        " は ",
        math(String.raw`\mathbb Q`),
        " 上で根式によって解けない。実数、複素数、極限、積分を用いない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"),
        " より、次数四十四の既約因子 ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " に対して、",
      ]),
      displayMath(String.raw`Z_Q(x)=2(x+1)^{12}Q_Q(x).`),
      paragraph([
        ref("theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals"),
        " の根集合を ",
        math(String.raw`\mathcal R_Q:=\{\alpha\in\overline{\mathbb Q}\mid Q_Q(\alpha)=0\}`),
        " とする。任意の ",
        math(String.raw`\alpha\in\mathcal R_Q`),
        " について、根集合の定義より、",
      ]),
      displayMath(String.raw`Q_Q(\alpha)=0.`),
      paragraph([ref("theorem_fixed_quotient_partition_polynomial_irreducible_factorization"), " を ", math(String.raw`\alpha`), " で評価すると、"]),
      displayMath(String.raw`\begin{aligned}
Z_Q(\alpha)
&=2(\alpha+1)^{12}Q_Q(\alpha)
&&\bigl(\because\ Z_Q(x)=2(x+1)^{12}Q_Q(x)\bigr)\\
&=0
&&\bigl(\because\ Q_Q(\alpha)=0\bigr).
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\mathcal R_Q\subset\mathcal Z_Q.`),
      paragraph([
        "所定の有限列が存在すると仮定する。このとき ",
        math(String.raw`\mathcal Z_Q\subset F_m`),
        " と ",
        math(String.raw`\mathcal R_Q\subset\mathcal Z_Q`),
        " に包含関係の推移律を適用して、",
      ]),
      displayMath(String.raw`\mathcal R_Q\subset F_m.`),
      paragraph([ref("theorem_fixed_quotient_fisher_irreducible_factor_not_solvable_by_radicals"), " に反する。ゆえに所定の有限列は存在せず、", math(String.raw`Z_Q`), " は ", math(String.raw`\mathbb Q`), " 上で根式によって解けない。"]),
    ],
  },
  {
    id: "arithmetic_invariants_theorem_fixed_quotient_fisher_zero_rational_rectangle_isolation",
    kind: "theorem",
    title: { text: "固定剰余類格子の Fisher 零点の有理矩形根分離証明書" },
    labels: ["theorem_fixed_quotient_fisher_zero_rational_rectangle_isolation"],
    habitat: "Qbar",
    verification: ["sagemath/check/fixed-quotient-fisher-zero-root-isolation-data"],
    statement: [
      paragraph([
        math(String.raw`\mathbb Q^{\mathrm{rc}}`),
        " を有理数体の実閉包とし、",
        math(String.raw`\mathbb A:=\mathbb Q^{\mathrm{rc}}[\mathsf i]`),
        " を ",
        math(String.raw`\mathsf i^2=-1`),
        " により得る代数的閉体とする。これを ",
        math(String.raw`\overline{\mathbb Q}`),
        " の一つの具体的な模型として固定する。",
      ]),
      paragraph([
        math(String.raw`a,b,c,d\in\mathbb Q`),
        "、",
        math(String.raw`a<b`),
        "、",
        math(String.raw`c<d`),
        " に対して、有理矩形を",
      ]),
      displayMath(String.raw`\mathcal R(a,b;c,d):=
\left\{
  u+\mathsf i v\in\mathbb A
  \;\middle|\;
  a\le u\le b,\ c\le v\le d
\right\}`),
      paragraph(["と定める。次の二十二個の上半平面矩形を固定する。"]),
      displayMath(String.raw`\begin{aligned}
\mathcal R_1^+&=\mathcal R(-105/32,-209/64;61/16,245/64),&
\mathcal R_2^+&=\mathcal R(-191/256,-95/128;31/32,249/256),\\
\mathcal R_3^+&=\mathcal R(-241/512,-15/32;37/64,149/256),&
\mathcal R_4^+&=\mathcal R(-227/512,-113/256;93/128,187/256),\\
\mathcal R_5^+&=\mathcal R(-113/256,-225/512;59/128,237/512),&
\mathcal R_6^+&=\mathcal R(-195/512,-97/256;167/256,21/32).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathcal R_7^+&=\mathcal R(-137/512,-17/64;191/256,3/4),&
\mathcal R_8^+&=\mathcal R(-239/2048,-119/1024;191/256,3/4),\\
\mathcal R_9^+&=\mathcal R(129/2048,65/1024;93/128,187/256),&
\mathcal R_{10}^+&=\mathcal R(5/32,161/1024;79/128,159/256),\\
\mathcal R_{11}^+&=\mathcal R(197/1024,99/512;181/256,91/128),&
\mathcal R_{12}^+&=\mathcal R(23/64,185/512;25/32,201/256).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathcal R_{13}^+&=\mathcal R(247/512,31/64;39/16,157/64),&
\mathcal R_{14}^+&=\mathcal R(125/256,251/512;175/256,11/16),\\
\mathcal R_{15}^+&=\mathcal R(143/256,9/16;67/128,135/256),&
\mathcal R_{16}^+&=\mathcal R(151/256,19/32;101/256,203/512),\\
\mathcal R_{17}^+&=\mathcal R(39/64,157/256;65/64,131/128),&
\mathcal R_{18}^+&=\mathcal R(39/64,157/256;37/128,149/512).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathcal R_{19}^+&=\mathcal R(81/128,163/256;51/256,205/1024),&
\mathcal R_{20}^+&=\mathcal R(85/128,171/256;227/2048,57/512),\\
\mathcal R_{21}^+&=\mathcal R(171/256,43/64;103/128,207/256),&
\mathcal R_{22}^+&=\mathcal R(181/256,91/128;249/512,125/256).
\end{aligned}`),
      paragraph([
        "各 ",
        math(String.raw`j\in\{1,\ldots,22\}`),
        " に対し、",
        math(String.raw`\mathcal R_j^-:=\{u-\mathsf i v\mid u+\mathsf i v\in\mathcal R_j^+\}`),
        " と置く。この四十四個の有理矩形は互いに交わらず、各 ",
        math(String.raw`\mathcal R_j^\varepsilon`),
        "（",
        math(String.raw`\varepsilon\in\{+,-\}`),
        "）には ",
        math(String.raw`Q_Q`),
        " の根がちょうど一つ存在する。その根を ",
        math(String.raw`\alpha_j^\varepsilon\in\mathbb A`),
        " と書くと、",
      ]),
      displayMath(String.raw`\left\{\alpha\in\mathbb A\mid Q_Q(\alpha)=0\right\}
=\left\{\alpha_j^\varepsilon\mid
  j\in\{1,\ldots,22\},\ \varepsilon\in\{+,-\}
\right\},
\qquad
\alpha_j^- = \overline{\alpha_j^+}.`),
      paragraph([
        "したがって、二十二個の有理数四つ組と共役操作が、次数 ",
        math("44"),
        " の既約因子の全ての根を互いに区別する有限な根分離証明書である。矩形の端点と比較は ",
        math(String.raw`\mathbb Q^{\mathrm{rc}}`),
        " に属し、浮動小数点近似、複素平面への数値描画、距離、偏角、極限、積分を用いない。見かけだけの ",
        math(String.raw`\mathbb R/\mathbb C`),
        " 脱出は、実閉包とその代数的二次拡大へ置き換えて除去されている。",
      ]),
    ],
    proof: [
      paragraph([ref("theorem_fixed_quotient_fisher_zero_multiplicity_data"), " より"]),
      displayMath(String.raw`\deg Q_Q=44,
\qquad
\gcd_{\mathbb Q[x]}(Q_Q,Q_Q')=1.`),
      paragraph([
        "表示した全端点を共通分母へ移した整数として比較すると、四十四個の矩形は二つずつ互いに交わらない。整数係数多項式に対する認証付き複素根分離を ",
        math(String.raw`Q_Q`),
        " と各有理矩形へ適用すると、",
      ]),
      displayMath(String.raw`\#\left\{\alpha\in\mathcal R_j^\varepsilon
  \mid Q_Q(\alpha)=0\right\}=1
\qquad
\bigl(j\in\{1,\ldots,22\},\ \varepsilon\in\{+,-\}\bigr).`),
      displayMath(String.raw`\sum_{j=1}^{22}\sum_{\varepsilon\in\{+,-\}}1
=44
=\deg Q_Q.`),
      paragraph([
        "したがって矩形内の四十四根が ",
        math(String.raw`Q_Q`),
        " の全ての根である。さらに ",
        math(String.raw`Q_Q\in\mathbb Z[x]`),
        " の係数は共役で不変であり、",
        math(String.raw`\mathcal R_j^-`),
        " は ",
        math(String.raw`\mathcal R_j^+`),
        " の共役像なので、各矩形内の根の一意性より",
      ]),
      displayMath(String.raw`\alpha_j^- = \overline{\alpha_j^+}
\qquad
\bigl(j\in\{1,\ldots,22\}\bigr).`),
      paragraph([
        "根の個数、矩形の非交差、包含、共役対応は、有理端点の外向き区間演算と整数係数多項式の厳密評価で検算されている。よって表示した有限データは数値近似を正本としない根分離証明書である。",
      ]),
    ],
  },
]);
