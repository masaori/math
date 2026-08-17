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
]);
