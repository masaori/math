/** 二章構成への分類境界と依存順は docs/tasks/成果の章立て.md を正本とする。 */

import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "mathematical_toolkit_heading",
    kind: "heading",
    level: 1,
    title: { text: "数学的道具立て" },
    labels: [],
  },

  {
    id: "toolkit_positive_rational_encoding_heading",
    kind: "heading",
    level: 2,
    title: { text: "正の有理数の有限符号化" },
    labels: [],
  },

  {
    id: "toolkit_positive_rational_encoding_heading_goal",
    kind: "remark",
    title: { text: "この節の入出力と主定理" },
    labels: [],
    habitat: "none",
    statement: [paragraph(["入力: 素因数分解の一意性。出力: 正の有理数を復元できる有限台の素指数データ。主定理・主張: 正の有理数の素指数データ。"])],
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
    id: "toolkit_polynomial_information_heading",
    kind: "heading",
    level: 2,
    title: { text: "多項式を決める情報・決めない情報" },
    labels: [],
  },

  {
    id: "toolkit_polynomial_information_heading_goal",
    kind: "remark",
    title: { text: "この節の入出力と主定理" },
    labels: [],
    habitat: "none",
    statement: [paragraph(["入力: 有理係数または代数的係数の一変数多項式。出力: 代数的不変量の非決定性と、係数復元に十分な零点データ。主定理・主張: 最高次係数と重複度を加えれば多項式が決まる。"])],
  },

  {
      id: "splitting_data_loss_claim_linear_counterexample",
      kind: "claim",
      standing: "mainTheorem",
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
      id: "discriminant_data_loss_claim_quadratic_counterexample",
      kind: "claim",
      standing: "mainTheorem",
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
      id: "irreducible_factor_degrees_claim_root_minimal_degrees",
      kind: "claim",
      standing: "mainTheorem",
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
      standing: "mainTheorem",
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
    id: "toolkit_power_gcd_heading",
    kind: "heading",
    level: 2,
    title: { text: "冪差・最大公約数・整除" },
    labels: [],
  },

  {
    id: "toolkit_power_gcd_heading_goal",
    kind: "remark",
    title: { text: "この節の入出力と主定理" },
    labels: [],
    habitat: "none",
    statement: [paragraph(["入力: 自然数の冪と Euclid の互除法。出力: 二つの冪差の最大公約数公式と、その整除上の帰結。主定理・主張: 冪から一を引いた二数の最大公約数は指数の最大公約数の冪から一を引いた数である。"])],
  },

  {
      id: "toolkit_claim_power_minus_one_divides_multiple_exponent_power_minus_one",
      kind: "claim",
      title: {
        text: "底の冪から 1 を引いた数は、指数を自然数倍した冪から 1 を引いた数を割る",
      },
      labels: ["claim_power_minus_one_divides_multiple_exponent"],
      habitat: "N",
      statement: [
        paragraph([
          "正の自然数 ",
          math(String.raw`c`),
          "、正の自然数 ",
          math(String.raw`n`),
          "、自然数 ",
          math(String.raw`k`),
          " について",
        ]),
        displayMath(
          String.raw`\bigl(c^{\,n}-1\bigr)\ \bigm|\ \bigl(c^{\,nk}-1\bigr)`,
        ),
        paragraph([
          "が成り立つ。ここで ",
          math(String.raw`c^{\,n}-1`),
          " と ",
          math(String.raw`c^{\,nk}-1`),
          " はともに自然数であり、主張は ",
          math(String.raw`\mathbb Z`),
          " の整除性だけからなる。有限個の積と有限和だけで閉じる。",
        ]),
      ],
      proof: [
        paragraph([
          "自然数 ",
          math(String.raw`k`),
          " についての帰納法で示す。示す命題を ",
          math(String.raw`P(k)`),
          "、すなわち「ある整数 ",
          math(String.raw`t_k`),
          " が存在して ",
          math(String.raw`c^{\,nk}-1=\bigl(c^{\,n}-1\bigr)t_k`),
          " が成り立つ」とする。",
        ]),
        paragraph([
          math(String.raw`k=0`),
          " のとき ",
          math(String.raw`c^{\,n\cdot0}-1=c^{\,0}-1=1-1=0=\bigl(c^{\,n}-1\bigr)\cdot0`),
          " なので ",
          math(String.raw`t_0=0`),
          " と取れて ",
          math(String.raw`P(0)`),
          " が成り立つ。",
        ]),
        paragraph([
          math(String.raw`P(k)`),
          " を仮定し、その整数を ",
          math(String.raw`t_k`),
          " とする。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  c^{\,n(k+1)}-1
  &=c^{\,nk+n}-1
  &&(\because\ n(k+1)=nk+n)\\
  &=c^{\,nk}\,c^{\,n}-1
  &&(\because\ \text{同じ底の冪の積})\\
  &=c^{\,nk}\,c^{\,n}-c^{\,nk}+c^{\,nk}-1
  &&(\because\ -c^{\,nk}+c^{\,nk}=0)\\
  &=c^{\,nk}\bigl(c^{\,n}-1\bigr)+\bigl(c^{\,nk}-1\bigr)
  &&(\because\ \text{分配則})\\
  &=c^{\,nk}\bigl(c^{\,n}-1\bigr)+\bigl(c^{\,n}-1\bigr)t_k
  &&(\because\ \text{帰納法の仮定 } P(k))\\
  &=\bigl(c^{\,n}-1\bigr)\bigl(c^{\,nk}+t_k\bigr)
  &&(\because\ \text{分配則})
  \end{aligned}`,
        ),
        paragraph([
          "なので ",
          math(String.raw`t_{k+1}:=c^{\,nk}+t_k`),
          " と取れて ",
          math(String.raw`P(k+1)`),
          " が成り立つ。よってすべての自然数 ",
          math(String.raw`k`),
          " について ",
          math(String.raw`P(k)`),
          " が成り立ち、整除の定義により主張を得る。",
        ]),
      ],
    },

  {
      id: "toolkit_claim_power_minus_one_gcd_reduces_exponent_difference",
      kind: "claim",
      title: {
        text: "底の冪から 1 を引いた二数の最大公約数は、指数の差へ還元できる",
      },
      labels: ["claim_power_minus_one_gcd_exponent_difference_step"],
      habitat: "N",
      statement: [
        paragraph([
          "正の自然数 ",
          math(String.raw`c`),
          " と、",
          math(String.raw`m>n`),
          " を満たす正の自然数 ",
          math(String.raw`m`),
          "、",
          math(String.raw`n`),
          " について",
        ]),
        displayMath(
          String.raw`\gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)=\gcd\bigl(c^{\,m-n}-1,\ c^{\,n}-1\bigr)`,
        ),
        paragraph([
          "が成り立つ。ここで ",
          math(String.raw`m-n`),
          " は ",
          math(String.raw`m>n`),
          " より正の自然数であり、ここに現れる三つの冪差 ",
          math(String.raw`c^{\,m}-1`),
          "、",
          math(String.raw`c^{\,n}-1`),
          "、",
          math(String.raw`c^{\,m-n}-1`),
          "、およびそれらの最大公約数はいずれも自然数である。主張は ",
          math(String.raw`\mathbb Z`),
          " の等式だけからなり、有限整数算術だけで閉じる。",
        ]),
      ],
      proof: [
        paragraph([
          "まず ",
          math(String.raw`c^{\,m}-1`),
          " を ",
          math(String.raw`c^{\,n}-1`),
          " と ",
          math(String.raw`c^{\,m-n}-1`),
          " で書き直す。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  c^{\,m}-1
  &=c^{\,(m-n)+n}-1
  &&(\because\ m>n \text{ より } m=(m-n)+n)\\
  &=c^{\,m-n}\,c^{\,n}-1
  &&(\because\ \text{同じ底の冪の積})\\
  &=c^{\,m-n}\,c^{\,n}-c^{\,m-n}+c^{\,m-n}-1
  &&(\because\ -c^{\,m-n}+c^{\,m-n}=0)\\
  &=c^{\,m-n}\bigl(c^{\,n}-1\bigr)+\bigl(c^{\,m-n}-1\bigr)
  &&(\because\ \text{分配則})
  \end{aligned}`,
        ),
        paragraph([
          "すなわち ",
          math(String.raw`q:=c^{\,m-n}`),
          " と置くと ",
          math(String.raw`c^{\,m}-1=q\bigl(c^{\,n}-1\bigr)+\bigl(c^{\,m-n}-1\bigr)`),
          " である。以下、両側の最大公約数を割り合うことで等号を示す。",
        ]),
        paragraph([
          math(String.raw`d:=\gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)`),
          " と置く。",
          math(String.raw`d\mid c^{\,m}-1`),
          " かつ ",
          math(String.raw`d\mid c^{\,n}-1`),
          " なので ",
          math(String.raw`d\mid q\bigl(c^{\,n}-1\bigr)`),
          " であり、上の等式から ",
          math(String.raw`d\mid\bigl(c^{\,m}-1\bigr)-q\bigl(c^{\,n}-1\bigr)=c^{\,m-n}-1`),
          " を得る。",
          math(String.raw`d`),
          " は ",
          math(String.raw`c^{\,m-n}-1`),
          " と ",
          math(String.raw`c^{\,n}-1`),
          " の公約数なので ",
          math(String.raw`d\mid\gcd\bigl(c^{\,m-n}-1,\ c^{\,n}-1\bigr)`),
          " である。",
        ]),
        paragraph([
          "逆に ",
          math(String.raw`e:=\gcd\bigl(c^{\,m-n}-1,\ c^{\,n}-1\bigr)`),
          " と置く。",
          math(String.raw`e\mid c^{\,n}-1`),
          " なので ",
          math(String.raw`e\mid q\bigl(c^{\,n}-1\bigr)`),
          " であり、",
          math(String.raw`e\mid c^{\,m-n}-1`),
          " と合わせて、上の等式から ",
          math(String.raw`e\mid q\bigl(c^{\,n}-1\bigr)+\bigl(c^{\,m-n}-1\bigr)=c^{\,m}-1`),
          " を得る。",
          math(String.raw`e`),
          " は ",
          math(String.raw`c^{\,m}-1`),
          " と ",
          math(String.raw`c^{\,n}-1`),
          " の公約数なので ",
          math(String.raw`e\mid d`),
          " である。",
        ]),
        paragraph([
          math(String.raw`d`),
          " と ",
          math(String.raw`e`),
          " は互いに割り合う自然数なので ",
          math(String.raw`d=e`),
          " であり、主張の等式を得る。",
        ]),
      ],
    },

  {
      id: "toolkit_claim_power_minus_one_gcd_reaches_exponent_gcd",
      kind: "claim",
      title: {
        text: "還元を繰り返すと指数はどちらも指数の最大公約数に到達する",
      },
      labels: ["claim_power_minus_one_gcd_reaches_exponent_gcd"],
      habitat: "N",
      statement: [
        paragraph([
          "正の自然数 ",
          math(String.raw`c`),
          " と正の自然数 ",
          math(String.raw`m`),
          "、",
          math(String.raw`n`),
          " について、",
          math(String.raw`g:=\gcd(m,n)`),
          " と置くと",
        ]),
        displayMath(
          String.raw`\gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)=\gcd\bigl(c^{\,g}-1,\ c^{\,g}-1\bigr)`,
        ),
        paragraph([
          "が成り立つ。ここで ",
          math(String.raw`g`),
          " は正の自然数であり、両辺に現れる冪差とその最大公約数はいずれも自然数である。主張は ",
          math(String.raw`\mathbb Z`),
          " の等式だけからなり、有限整数算術だけで閉じる。",
        ]),
      ],
      proof: [
        paragraph([
          "準備として、正の自然数 ",
          math(String.raw`m>n`),
          " について ",
          math(String.raw`\gcd(m-n,\ n)=\gcd(m,n)`),
          " を示す。",
          math(String.raw`t:=\gcd(m,n)`),
          " と置くと ",
          math(String.raw`t\mid m`),
          " かつ ",
          math(String.raw`t\mid n`),
          " なので ",
          math(String.raw`t\mid m-n`),
          " であり、",
          math(String.raw`t`),
          " は ",
          math(String.raw`m-n`),
          " と ",
          math(String.raw`n`),
          " の公約数だから ",
          math(String.raw`t\mid\gcd(m-n,\ n)`),
          " である。逆に ",
          math(String.raw`u:=\gcd(m-n,\ n)`),
          " と置くと ",
          math(String.raw`u\mid m-n`),
          " かつ ",
          math(String.raw`u\mid n`),
          " なので ",
          math(String.raw`u\mid (m-n)+n=m`),
          " であり、",
          math(String.raw`u`),
          " は ",
          math(String.raw`m`),
          " と ",
          math(String.raw`n`),
          " の公約数だから ",
          math(String.raw`u\mid t`),
          " である。互いに割り合う自然数は等しいので ",
          math(String.raw`\gcd(m-n,\ n)=\gcd(m,n)`),
          " を得る。",
        ]),
        paragraph([
          "本体は和 ",
          math(String.raw`m+n`),
          " についての強い帰納法で示す。正の自然数 ",
          math(String.raw`N`),
          " について、",
          math(String.raw`m+n=N`),
          " を満たすすべての正の自然数の組 ",
          math(String.raw`(m,n)`),
          " で主張の等式が成り立つことを ",
          math(String.raw`P(N)`),
          " と書き、",
          math(String.raw`N`),
          " 未満のすべての値で ",
          math(String.raw`P`),
          " が成り立つとして ",
          math(String.raw`P(N)`),
          " を示す。",
          math(String.raw`m`),
          " と ",
          math(String.raw`n`),
          " の大小で三つに分ける。",
        ]),
        paragraph([
          math(String.raw`m=n`),
          " のとき。このとき ",
          math(String.raw`g=\gcd(m,m)=m`),
          " なので、主張の右辺は ",
          math(String.raw`\gcd\bigl(c^{\,m}-1,\ c^{\,m}-1\bigr)`),
          " であり、左辺と同じ式である。",
        ]),
        paragraph([
          math(String.raw`m>n`),
          " のとき。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  \gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)
  &=\gcd\bigl(c^{\,m-n}-1,\ c^{\,n}-1\bigr)
  &&(\because\ \blkref{claim_power_minus_one_gcd_exponent_difference_step})\\
  &=\gcd\bigl(c^{\,\gcd(m-n,\,n)}-1,\ c^{\,\gcd(m-n,\,n)}-1\bigr)
  &&(\because\ (m-n)+n=m<m+n \text{ より帰納法の仮定})\\
  &=\gcd\bigl(c^{\,g}-1,\ c^{\,g}-1\bigr)
  &&(\because\ \gcd(m-n,\,n)=\gcd(m,n)=g)
  \end{aligned}`,
        ),
        paragraph([
          math(String.raw`m<n`),
          " のとき。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  \gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)
  &=\gcd\bigl(c^{\,n}-1,\ c^{\,m}-1\bigr)
  &&(\because\ \text{最大公約数は二つの引数の順序に依らない})\\
  &=\gcd\bigl(c^{\,n-m}-1,\ c^{\,m}-1\bigr)
  &&(\because\ \blkref{claim_power_minus_one_gcd_exponent_difference_step})\\
  &=\gcd\bigl(c^{\,\gcd(n-m,\,m)}-1,\ c^{\,\gcd(n-m,\,m)}-1\bigr)
  &&(\because\ (n-m)+m=n<m+n \text{ より帰納法の仮定})\\
  &=\gcd\bigl(c^{\,g}-1,\ c^{\,g}-1\bigr)
  &&(\because\ \gcd(n-m,\,m)=\gcd(n,m)=g)
  \end{aligned}`,
        ),
        paragraph([
          "三つの場合いずれでも主張の等式が成り立つので ",
          math(String.raw`P(N)`),
          " が成り立つ。強い帰納法により、すべての正の自然数の組 ",
          math(String.raw`(m,n)`),
          " について主張を得る。",
        ]),
      ],
    },

  {
      id: "toolkit_claim_power_minus_one_gcd_equals_power_of_exponent_gcd",
      kind: "claim",
      title: {
        text: "冪から一を引いた二つの数の最大公約数は指数の最大公約数の冪から一を引いた数である",
      },
      labels: ["claim_power_minus_one_gcd_equals_power_of_exponent_gcd"],
      habitat: "N",
      statement: [
        paragraph([
          "正の自然数 ",
          math(String.raw`c`),
          " と正の自然数 ",
          math(String.raw`m`),
          "、",
          math(String.raw`n`),
          " について",
        ]),
        displayMath(
          String.raw`\gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)=c^{\,\gcd(m,n)}-1`,
        ),
        paragraph([
          "が成り立つ。ここで ",
          math(String.raw`\gcd(m,n)`),
          " は正の自然数であり、両辺はいずれも自然数である。主張は ",
          math(String.raw`\mathbb Z`),
          " の等式だけからなり、有限整数算術だけで閉じる。",
        ]),
      ],
      proof: [
        paragraph([
          "準備として、自然数 ",
          math(String.raw`a`),
          " について ",
          math(String.raw`\gcd(a,a)=a`),
          " を示す。",
          math(String.raw`a`),
          " は ",
          math(String.raw`a`),
          " と ",
          math(String.raw`a`),
          " の公約数なので ",
          math(String.raw`a\mid\gcd(a,a)`),
          " であり、逆に最大公約数は第一引数を割るので ",
          math(String.raw`\gcd(a,a)\mid a`),
          " である。互いに割り合う自然数は等しいので ",
          math(String.raw`\gcd(a,a)=a`),
          " を得る。",
        ]),
        paragraph([
          math(String.raw`g:=\gcd(m,n)`),
          " と置く。",
          math(String.raw`m`),
          " と ",
          math(String.raw`n`),
          " はいずれも正の自然数なので ",
          math(String.raw`g`),
          " も正の自然数であり、",
          math(String.raw`g\mid m`),
          " かつ ",
          math(String.raw`g\mid n`),
          " である。したがって ",
          math(String.raw`c^{\,g}-1`),
          " は自然数であり、主張の右辺は意味をもつ。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  \gcd\bigl(c^{\,m}-1,\ c^{\,n}-1\bigr)
  &=\gcd\bigl(c^{\,g}-1,\ c^{\,g}-1\bigr)
  &&(\because\ \blkref{claim_power_minus_one_gcd_reaches_exponent_gcd})\\
  &=c^{\,g}-1
  &&(\because\ \text{上で示した }\gcd(a,a)=a\text{ に }a=c^{\,g}-1\text{ を適用})\\
  &=c^{\,\gcd(m,n)}-1
  &&(\because\ g=\gcd(m,n)\text{ の定義})
  \end{aligned}`,
        ),
        paragraph([
          "以上で主張の等式を得る。",
        ]),
      ],
    },

  {
      id: "toolkit_claim_divisibility_witness_for_every_positive_natural",
      kind: "claim",
      title: {
        text: "任意の正の自然数に対して所定の整除を満たす正の自然数が存在する",
      },
      labels: ["claim_box_free_divisibility_excludes_no_rational_point"],
      habitat: "N",
      statement: [
        paragraph([
          "任意の正の自然数 ",
          math(String.raw`a`),
          " に対して、正の自然数 ",
          math(String.raw`c`),
          " であって",
        ]),
        displayMath(
          String.raw`a\ \bigm|\ 2\,(c-1)`,
        ),
        paragraph([
          "を満たすものが存在する。主張は ",
          math(String.raw`\mathbb Z`),
          " の整除だけからなり、有限整数算術だけで閉じる。",
        ]),
      ],
      proof: [
        paragraph([
          math(String.raw`c:=a+1`),
          " と置く。",
          math(String.raw`a`),
          " は正の自然数なので ",
          math(String.raw`c=a+1`),
          " も正の自然数である。",
        ]),
        displayMath(
          String.raw`\begin{aligned}
  2\,(c-1)
  &=2\,\bigl((a+1)-1\bigr)
  &&(\because\ c=a+1)\\
  &=2a
  &&(\because\ (a+1)-1=a)
  \end{aligned}`,
        ),
        paragraph([
          math(String.raw`a\mid 2a`),
          " なので ",
          math(String.raw`a\mid 2(c-1)`),
          " を得る。",
        ]),
      ],
    }
]);
