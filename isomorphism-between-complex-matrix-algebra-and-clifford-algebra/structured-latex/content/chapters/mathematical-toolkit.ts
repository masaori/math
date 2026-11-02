import { defineBlocks, displayMath, list, math, paragraph, ref } from "../../schema.ts";

export default defineBlocks([
  {
    id: "mathematical_toolkit_heading",
    kind: "heading",
    level: 1,
    title: { text: "数学的道具立て" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_ring_heading",
    kind: "heading",
    level: 2,
    title: { text: "環" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_unital_ring",
    kind: "definition",
    title: { text: "単位元をもつ環" },
    labels: ["def_unital_ring"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`R`),
        "、写像 ",
        math(String.raw`+_R:R\times R\to R`),
        " と ",
        math(String.raw`\cdot_R:R\times R\to R`),
        "、元 ",
        math(String.raw`0_R\in R`),
        " と ",
        math(String.raw`1_R\in R`),
        " の組 ",
        math(String.raw`(R,+_R,\cdot_R,0_R,1_R)`),
        " が次をすべて満たすとき、これを単位元をもつ環と呼ぶ。以下、",
        math(String.raw`x,y,z`),
        " は ",
        math(String.raw`R`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`(x+_R y)+_R z=x+_R(y+_R z)`), "（加法の結合法則）"],
        [math(String.raw`x+_R y=y+_R x`), "（加法の交換法則）"],
        [math(String.raw`x+_R 0_R=x`), "（加法の単位元）"],
        [
          "各 ",
          math(String.raw`x\in R`),
          " に対し ",
          math(String.raw`x+_R x'=0_R`),
          " を満たす ",
          math(String.raw`x'\in R`),
          " が存在する（加法の逆元）",
        ],
        [math(String.raw`(x\cdot_R y)\cdot_R z=x\cdot_R(y\cdot_R z)`), "（乗法の結合法則）"],
        [math(String.raw`x\cdot_R 1_R=x`), " かつ ", math(String.raw`1_R\cdot_R x=x`), "（乗法の単位元）"],
        [
          math(String.raw`x\cdot_R(y+_R z)=x\cdot_R y+_R x\cdot_R z`),
          " かつ ",
          math(String.raw`(x+_R y)\cdot_R z=x\cdot_R z+_R y\cdot_R z`),
          "（分配法則）",
        ],
      ]),
      paragraph([
        "演算と単位元には、それが属する環を必ず添字で書く。乗法の交換法則は仮定しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_ring_homomorphism",
    kind: "definition",
    title: { text: "環の準同型" },
    labels: ["def_ring_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`(R,+_R,\cdot_R,0_R,1_R)`),
        " と ",
        math(String.raw`(S,+_S,\cdot_S,0_S,1_S)`),
        " を単位元をもつ環（",
        ref("def_unital_ring"),
        "）とする。写像 ",
        math(String.raw`\varphi:R\to S`),
        " が次をすべて満たすとき、",
        math(String.raw`\varphi`),
        " を ",
        math(String.raw`R`),
        " から ",
        math(String.raw`S`),
        " への環の準同型と呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`R`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`\varphi(x+_R y)=\varphi(x)+_S\varphi(y)`), "（加法を保つ）"],
        [math(String.raw`\varphi(x\cdot_R y)=\varphi(x)\cdot_S\varphi(y)`), "（乗法を保つ）"],
        [math(String.raw`\varphi(1_R)=1_S`), "（乗法の単位元を保つ）"],
      ]),
      paragraph([
        "加法の単位元を保つこと ",
        math(String.raw`\varphi(0_R)=0_S`),
        " は条件に含めない。乗法の単位元を保つことは、加法と乗法を保つことからは従わないので条件に含める。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_vector_space_heading",
    kind: "heading",
    level: 2,
    title: { text: "ℂ-線型空間" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_complex_vector_space",
    kind: "definition",
    title: { text: "ℂ-線型空間" },
    labels: ["def_complex_vector_space"],
    statement: [
      paragraph([
        "複素数全体の集合 ",
        math(String.raw`\mathbb{C}`),
        " の加法と乗法を ",
        math(String.raw`+_{\mathbb{C}}`),
        " と ",
        math(String.raw`\cdot_{\mathbb{C}}`),
        "、その加法の単位元と乗法の単位元を ",
        math(String.raw`0_{\mathbb{C}}`),
        " と ",
        math(String.raw`1_{\mathbb{C}}`),
        " と書く。",
      ]),
      paragraph([
        "集合 ",
        math(String.raw`V`),
        "、写像 ",
        math(String.raw`+_V:V\times V\to V`),
        " と ",
        math(String.raw`\cdot_V:\mathbb{C}\times V\to V`),
        "、元 ",
        math(String.raw`0_V\in V`),
        " の組 ",
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " が次をすべて満たすとき、これを ℂ-線型空間と呼び、",
        math(String.raw`+_V`),
        " を加法、",
        math(String.raw`\cdot_V`),
        " をスカラー倍と呼ぶ。以下、",
        math(String.raw`x,y,z`),
        " は ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`(x+_V y)+_V z=x+_V(y+_V z)`), "（加法の結合法則）"],
        [math(String.raw`x+_V y=y+_V x`), "（加法の交換法則）"],
        [math(String.raw`x+_V 0_V=x`), "（加法の単位元）"],
        [
          "各 ",
          math(String.raw`x\in V`),
          " に対し ",
          math(String.raw`x+_V x'=0_V`),
          " を満たす ",
          math(String.raw`x'\in V`),
          " が存在する（加法の逆元）",
        ],
        [
          math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\cdot_V x=\lambda\cdot_V(\mu\cdot_V x)`),
          "（スカラー倍の結合法則）",
        ],
        [math(String.raw`1_{\mathbb{C}}\cdot_V x=x`), "（スカラー倍の単位元）"],
        [
          math(String.raw`\lambda\cdot_V(x+_V y)=\lambda\cdot_V x+_V\lambda\cdot_V y`),
          "（ベクトルの加法についての分配法則）",
        ],
        [
          math(String.raw`(\lambda+_{\mathbb{C}}\mu)\cdot_V x=\lambda\cdot_V x+_V\mu\cdot_V x`),
          "（スカラーの加法についての分配法則）",
        ],
      ]),
      paragraph([
        "演算と単位元には、それが属する線型空間を必ず添字で書く。スカラー倍は ",
        math(String.raw`\mathbb{C}`),
        " の乗法 ",
        math(String.raw`\cdot_{\mathbb{C}}`),
        " とは定義域の異なる別の写像であり、記号の添字で区別する。有限次元であることは仮定しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_linear_map",
    kind: "definition",
    title: { text: "線型写像" },
    labels: ["def_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。写像 ",
        math(String.raw`f:V\to U`),
        " が次をすべて満たすとき、",
        math(String.raw`f`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への線型写像と呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`f(x+_V y)=f(x)+_U f(y)`), "（加法を保つ）"],
        [math(String.raw`f(\lambda\cdot_V x)=\lambda\cdot_U f(x)`), "（スカラー倍を保つ）"],
      ]),
      paragraph([
        "左辺の演算は ",
        math(String.raw`V`),
        " のもの、右辺の演算は ",
        math(String.raw`U`),
        " のものであり、添字で区別する。加法の単位元を保つこと ",
        math(String.raw`f(0_V)=0_U`),
        " は条件に含めない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_linear_combination",
    kind: "definition",
    title: { text: "線型結合" },
    labels: ["def_linear_combination"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`x_k`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " が一つずつ与えられているとする（",
        math(String.raw`n=0`),
        " のときは何も与えられていない）。",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`L_m`),
        " を次で帰納的に定める。",
      ]),
      list([
        [math(String.raw`L_0:=0_V`)],
        [
          math(String.raw`L_m:=L_{m-1}+_V(\lambda_m\cdot_V x_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        math(String.raw`L_n`),
        " を、",
        math(String.raw`x_1,\dots,x_n`),
        " の係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        " による線型結合と呼び、",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k`),
        " と書く。",
      ]),
      paragraph([
        "和は番号 ",
        math(String.raw`1,\dots,n`),
        " の順に左から足していく一つの式として定めており、和の順序や括弧の付け方によらないことはここでは主張しない。",
        "番号の付いていない有限集合の上の和は、この定義では定まらない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_linear_form",
    kind: "definition",
    title: { text: "線型形式" },
    labels: ["def_linear_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。写像 ",
        math(String.raw`f:V\to\mathbb{C}`),
        " が次をすべて満たすとき、",
        math(String.raw`f`),
        " を ",
        math(String.raw`V`),
        " 上の線型形式と呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`f(x+_V y)=f(x)+_{\mathbb{C}}f(y)`), "（加法を保つ）"],
        [math(String.raw`f(\lambda\cdot_V x)=\lambda\cdot_{\mathbb{C}}f(x)`), "（スカラー倍を保つ）"],
      ]),
      paragraph([
        "左辺の演算は ",
        math(String.raw`V`),
        " の加法とスカラー倍、右辺の演算は ",
        math(String.raw`\mathbb{C}`),
        " の加法 ",
        math(String.raw`+_{\mathbb{C}}`),
        " と乗法 ",
        math(String.raw`\cdot_{\mathbb{C}}`),
        " である。",
        "線型形式は線型写像（",
        ref("def_linear_map"),
        "）の特別な場合としては定めない。そう定めるには、",
        math(String.raw`\mathbb{C}`),
        " に ℂ-線型空間の構造を与える組に名前を付け、それが ℂ-線型空間の公理を満たすことを先に示す必要がある。",
        "ここでは ",
        math(String.raw`\mathbb{C}`),
        " を線型空間とみなさず、値の側の演算を ",
        math(String.raw`\mathbb{C}`),
        " の加法と乗法で直接書く。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_pointwise_sum_of_linear_forms",
    kind: "claim",
    title: { text: "線型形式の各点ごとの和は線型形式である" },
    labels: ["claim_pointwise_sum_of_linear_forms_is_linear_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to\mathbb{C}`),
        " と ",
        math(String.raw`g:V\to\mathbb{C}`),
        " を ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）とする。写像 ",
        math(String.raw`s_{f,g}:V\to\mathbb{C}`),
        " を次で定める。",
      ]),
      displayMath(String.raw`s_{f,g}(x):=f(x)+_{\mathbb{C}}g(x)\qquad(x\in V)`),
      paragraph([
        "このとき ",
        math(String.raw`s_{f,g}`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y`),
        " を ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。線型形式の定義（",
        ref("def_linear_form"),
        "）の二つの条件を順に示す。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
s_{f,g}(x+_V y)
&=f(x+_V y)+_{\mathbb{C}}g(x+_V y)
&&\left(\because\ s_{f,g}\ \text{の定義}\right)\\
&=\bigl(f(x)+_{\mathbb{C}}f(y)\bigr)+_{\mathbb{C}}g(x+_V y)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=\bigl(f(x)+_{\mathbb{C}}f(y)\bigr)+_{\mathbb{C}}\bigl(g(x)+_{\mathbb{C}}g(y)\bigr)
&&\left(\because\ g\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=f(x)+_{\mathbb{C}}\Bigl(f(y)+_{\mathbb{C}}\bigl(g(x)+_{\mathbb{C}}g(y)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=f(x)+_{\mathbb{C}}\Bigl(\bigl(f(y)+_{\mathbb{C}}g(x)\bigr)+_{\mathbb{C}}g(y)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=f(x)+_{\mathbb{C}}\Bigl(\bigl(g(x)+_{\mathbb{C}}f(y)\bigr)+_{\mathbb{C}}g(y)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=f(x)+_{\mathbb{C}}\Bigl(g(x)+_{\mathbb{C}}\bigl(f(y)+_{\mathbb{C}}g(y)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\bigl(f(x)+_{\mathbb{C}}g(x)\bigr)+_{\mathbb{C}}\bigl(f(y)+_{\mathbb{C}}g(y)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=s_{f,g}(x)+_{\mathbb{C}}s_{f,g}(y)
&&\left(\because\ s_{f,g}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
s_{f,g}(\lambda\cdot_V x)
&=f(\lambda\cdot_V x)+_{\mathbb{C}}g(\lambda\cdot_V x)
&&\left(\because\ s_{f,g}\ \text{の定義}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}g(\lambda\cdot_V x)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}g(x)\bigr)
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(f(x)+_{\mathbb{C}}g(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}s_{f,g}(x)
&&\left(\because\ s_{f,g}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`s_{f,g}`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である（",
        ref("def_linear_form"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_pointwise_scalar_multiple_of_linear_form",
    kind: "claim",
    title: { text: "線型形式の各点ごとのスカラー倍は線型形式である" },
    labels: ["claim_pointwise_scalar_multiple_of_linear_form_is_linear_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to\mathbb{C}`),
        " を ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）、",
        math(String.raw`\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の元とする。写像 ",
        math(String.raw`m_{\mu,f}:V\to\mathbb{C}`),
        " を次で定める。",
      ]),
      displayMath(String.raw`m_{\mu,f}(x):=\mu\cdot_{\mathbb{C}}f(x)\qquad(x\in V)`),
      paragraph([
        "このとき ",
        math(String.raw`m_{\mu,f}`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y`),
        " を ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。線型形式の定義（",
        ref("def_linear_form"),
        "）の二つの条件を順に示す。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{\mu,f}(x+_V y)
&=\mu\cdot_{\mathbb{C}}f(x+_V y)
&&\left(\because\ m_{\mu,f}\ \text{の定義}\right)\\
&=\mu\cdot_{\mathbb{C}}\bigl(f(x)+_{\mathbb{C}}f(y)\bigr)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=\bigl(\mu\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}\bigl(\mu\cdot_{\mathbb{C}}f(y)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=m_{\mu,f}(x)+_{\mathbb{C}}m_{\mu,f}(y)
&&\left(\because\ m_{\mu,f}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
m_{\mu,f}(\lambda\cdot_V x)
&=\mu\cdot_{\mathbb{C}}f(\lambda\cdot_V x)
&&\left(\because\ m_{\mu,f}\ \text{の定義}\right)\\
&=\mu\cdot_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=(\mu\cdot_{\mathbb{C}}\lambda)\cdot_{\mathbb{C}}f(x)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}f(x)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(\mu\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}m_{\mu,f}(x)
&&\left(\because\ m_{\mu,f}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`m_{\mu,f}`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である（",
        ref("def_linear_form"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_zero_map_is_linear_form",
    kind: "claim",
    title: { text: "零写像は線型形式である" },
    labels: ["claim_zero_map_is_linear_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。写像 ",
        math(String.raw`z_V:V\to\mathbb{C}`),
        " を次で定める。",
      ]),
      displayMath(String.raw`z_V(x):=0_{\mathbb{C}}\qquad(x\in V)`),
      paragraph([
        "このとき ",
        math(String.raw`z_V`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y`),
        " を ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。線型形式の定義（",
        ref("def_linear_form"),
        "）の二つの条件を順に示す。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
z_V(x+_V y)
&=0_{\mathbb{C}}
&&\left(\because\ z_V\ \text{の定義}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=z_V(x)+_{\mathbb{C}}z_V(y)
&&\left(\because\ z_V\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
z_V(\lambda\cdot_V x)
&=0_{\mathbb{C}}
&&\left(\because\ z_V\ \text{の定義}\right)\\
&=\lambda\cdot_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の任意の元と}\ 0_{\mathbb{C}}\ \text{の積は}\ 0_{\mathbb{C}}\right)\\
&=\lambda\cdot_{\mathbb{C}}z_V(x)
&&\left(\because\ z_V\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`z_V`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である（",
        ref("def_linear_form"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_dual_space",
    kind: "definition",
    title: { text: "双対空間" },
    labels: ["def_dual_space"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）全体の集合を ",
        math(String.raw`V^{*}`),
        " と書く。写像 ",
        math(String.raw`+_{V^{*}}:V^{*}\times V^{*}\to V^{*}`),
        " と ",
        math(String.raw`\cdot_{V^{*}}:\mathbb{C}\times V^{*}\to V^{*}`),
        "、元 ",
        math(String.raw`0_{V^{*}}\in V^{*}`),
        " を次で定める。以下、",
        math(String.raw`f,g`),
        " は ",
        math(String.raw`V^{*}`),
        " の任意の元、",
        math(String.raw`\mu`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [
          math(String.raw`f+_{V^{*}}g:=s_{f,g}`),
          "（",
          math(String.raw`s_{f,g}`),
          " は ",
          ref("claim_pointwise_sum_of_linear_forms_is_linear_form"),
          " の各点ごとの和）",
        ],
        [
          math(String.raw`\mu\cdot_{V^{*}}f:=m_{\mu,f}`),
          "（",
          math(String.raw`m_{\mu,f}`),
          " は ",
          ref("claim_pointwise_scalar_multiple_of_linear_form_is_linear_form"),
          " の各点ごとのスカラー倍）",
        ],
        [
          math(String.raw`0_{V^{*}}:=z_V`),
          "（",
          math(String.raw`z_V`),
          " は ",
          ref("claim_zero_map_is_linear_form"),
          " の零写像）",
        ],
      ]),
      paragraph([
        "右辺の三つの写像が ",
        math(String.raw`V^{*}`),
        " の元であること、すなわち三つの写像の値が ",
        math(String.raw`V^{*}`),
        " に入ることは、それぞれ ",
        ref("claim_pointwise_sum_of_linear_forms_is_linear_form"),
        "、",
        ref("claim_pointwise_scalar_multiple_of_linear_form_is_linear_form"),
        "、",
        ref("claim_zero_map_is_linear_form"),
        " による。これにより ",
        math(String.raw`+_{V^{*}}`),
        " と ",
        math(String.raw`\cdot_{V^{*}}`),
        " は値域を ",
        math(String.raw`V^{*}`),
        " とする写像として定まり、",
        math(String.raw`0_{V^{*}}`),
        " は ",
        math(String.raw`V^{*}`),
        " の元として定まる。",
      ]),
      paragraph([
        "組 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " を ",
        math(String.raw`V`),
        " の双対空間と呼ぶ。",
        math(String.raw`V^{*}`),
        " の二つの元 ",
        math(String.raw`f,g`),
        " が等しいとは、写像として等しいこと、すなわちすべての ",
        math(String.raw`x\in V`),
        " について ",
        math(String.raw`f(x)=g(x)`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の等式として成り立つことである。",
        "この組が ℂ-線型空間の公理（",
        ref("def_complex_vector_space"),
        "）を満たすことは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_dual_space_is_complex_vector_space",
    kind: "claim",
    title: { text: "双対空間は ℂ-線型空間である" },
    labels: ["claim_dual_space_is_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " をその双対空間（",
        ref("def_dual_space"),
        "）とする。このとき組 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`f,g,h`),
        " を ",
        math(String.raw`V^{*}`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元、",
        math(String.raw`x`),
        " を ",
        math(String.raw`V`),
        " の任意の元とする。",
        math(String.raw`V^{*}`),
        " の元は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`\mathbb{C}`),
        " への写像なので、",
        math(String.raw`f(x)`),
        " などの値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。",
        math(String.raw`-1_{\mathbb{C}}`),
        " を、",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元（",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元）とする。",
      ]),
      paragraph([
        "ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。どの条件も ",
        math(String.raw`V^{*}`),
        " の二つの元の等式であり、",
        math(String.raw`V^{*}`),
        " の元の等しさは、すべての ",
        math(String.raw`x\in V`),
        " での値の等しさである（",
        ref("def_dual_space"),
        "）。以下の各式変形は任意の ",
        math(String.raw`x\in V`),
        " について成り立つので、各条件は ",
        math(String.raw`V^{*}`),
        " の等式として成り立つ。",
      ]),
      paragraph(["加法の結合法則 ", math(String.raw`(f+_{V^{*}}g)+_{V^{*}}h=f+_{V^{*}}(g+_{V^{*}}h)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((f+_{V^{*}}g)+_{V^{*}}h\bigr)(x)
&=s_{f+_{V^{*}}g,\,h}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=(f+_{V^{*}}g)(x)+_{\mathbb{C}}h(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=s_{f,g}(x)+_{\mathbb{C}}h(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=\bigl(f(x)+_{\mathbb{C}}g(x)\bigr)+_{\mathbb{C}}h(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=f(x)+_{\mathbb{C}}\bigl(g(x)+_{\mathbb{C}}h(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=f(x)+_{\mathbb{C}}s_{g,h}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=f(x)+_{\mathbb{C}}(g+_{V^{*}}h)(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=s_{f,\,g+_{V^{*}}h}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\bigl(f+_{V^{*}}(g+_{V^{*}}h)\bigr)(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph(["加法の交換法則 ", math(String.raw`f+_{V^{*}}g=g+_{V^{*}}f`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(f+_{V^{*}}g)(x)
&=s_{f,g}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=f(x)+_{\mathbb{C}}g(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=g(x)+_{\mathbb{C}}f(x)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=s_{g,f}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=(g+_{V^{*}}f)(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph(["加法の単位元 ", math(String.raw`f+_{V^{*}}0_{V^{*}}=f`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(f+_{V^{*}}0_{V^{*}})(x)
&=s_{f,\,0_{V^{*}}}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=f(x)+_{\mathbb{C}}0_{V^{*}}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=f(x)+_{\mathbb{C}}z_V(x)
&&\left(\because\ 0_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=f(x)+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ z_V\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right)\\
&=f(x)
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元は、",
        math(String.raw`f`),
        " に対して ",
        math(String.raw`f':=(-1_{\mathbb{C}})\cdot_{V^{*}}f\in V^{*}`),
        " と置けば ",
        math(String.raw`f+_{V^{*}}f'=0_{V^{*}}`),
        " を満たす。これは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(f+_{V^{*}}f')(x)
&=s_{f,f'}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=f(x)+_{\mathbb{C}}f'(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=f(x)+_{\mathbb{C}}m_{-1_{\mathbb{C}},f}(x)
&&\left(\because\ f'\ \text{と}\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=f(x)+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}f(x)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}f(x)
&&\left(\because\ -1_{\mathbb{C}}\ \text{の定め方}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の任意の元と}\ 0_{\mathbb{C}}\ \text{の積は}\ 0_{\mathbb{C}}\right)\\
&=z_V(x)
&&\left(\because\ z_V\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right)\\
&=0_{V^{*}}(x)
&&\left(\because\ 0_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則 ", math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V^{*}}f=\lambda\cdot_{V^{*}}(\mu\cdot_{V^{*}}f)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V^{*}}f\bigr)(x)
&=m_{\lambda\cdot_{\mathbb{C}}\mu,\,f}(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}f(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(\mu\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}m_{\mu,f}(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{V^{*}}f)(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=m_{\lambda,\,\mu\cdot_{V^{*}}f}(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{V^{*}}(\mu\cdot_{V^{*}}f)\bigr)(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元 ", math(String.raw`1_{\mathbb{C}}\cdot_{V^{*}}f=f`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(1_{\mathbb{C}}\cdot_{V^{*}}f)(x)
&=m_{1_{\mathbb{C}},f}(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}f(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=f(x)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則 ", math(String.raw`\lambda\cdot_{V^{*}}(f+_{V^{*}}g)=\lambda\cdot_{V^{*}}f+_{V^{*}}\lambda\cdot_{V^{*}}g`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\cdot_{V^{*}}(f+_{V^{*}}g)\bigr)(x)
&=m_{\lambda,\,f+_{V^{*}}g}(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=\lambda\cdot_{\mathbb{C}}(f+_{V^{*}}g)(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}s_{f,g}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(f(x)+_{\mathbb{C}}g(x)\bigr)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}g(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=m_{\lambda,f}(x)+_{\mathbb{C}}m_{\lambda,g}(x)
&&\left(\because\ m\ \text{の定義を二か所に適用。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=(\lambda\cdot_{V^{*}}f)(x)+_{\mathbb{C}}(\lambda\cdot_{V^{*}}g)(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義を二か所に適用。}\blkref{def_dual_space}\right)\\
&=s_{\lambda\cdot_{V^{*}}f,\,\lambda\cdot_{V^{*}}g}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{V^{*}}f+_{V^{*}}\lambda\cdot_{V^{*}}g\bigr)(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則 ", math(String.raw`(\lambda+_{\mathbb{C}}\mu)\cdot_{V^{*}}f=\lambda\cdot_{V^{*}}f+_{V^{*}}\mu\cdot_{V^{*}}f`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda+_{\mathbb{C}}\mu)\cdot_{V^{*}}f\bigr)(x)
&=m_{\lambda+_{\mathbb{C}}\mu,\,f}(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}f(x)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(x)\bigr)+_{\mathbb{C}}\bigl(\mu\cdot_{\mathbb{C}}f(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=m_{\lambda,f}(x)+_{\mathbb{C}}m_{\mu,f}(x)
&&\left(\because\ m\ \text{の定義を二か所に適用。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=(\lambda\cdot_{V^{*}}f)(x)+_{\mathbb{C}}(\mu\cdot_{V^{*}}f)(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義を二か所に適用。}\blkref{def_dual_space}\right)\\
&=s_{\lambda\cdot_{V^{*}}f,\,\mu\cdot_{V^{*}}f}(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{V^{*}}f+_{V^{*}}\mu\cdot_{V^{*}}f\bigr)(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right).
\end{aligned}`),
      paragraph([
        "八つの条件が満たされたので、組 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_linear_independence",
    kind: "definition",
    title: { text: "一次独立" },
    labels: ["def_linear_independence"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、写像 ",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族と呼ぶ（",
        math(String.raw`n=0`),
        " のときは定義域が空集合の写像である）。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`b_k:=b(k)\in V`),
        " と書く。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b`),
        " が次を満たすとき、",
        math(String.raw`b`),
        " は一次独立であるという。",
      ]),
      list([
        [
          math(String.raw`\{1,\dots,n\}`),
          " の各元 ",
          math(String.raw`k`),
          " に ",
          math(String.raw`\mathbb{C}`),
          " の元 ",
          math(String.raw`\lambda_k`),
          " を一つずつ与えるどの与え方についても、線型結合（",
          ref("def_linear_combination"),
          "）が ",
          math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=0_V`),
          " を満たすならば、すべての ",
          math(String.raw`k\in\{1,\dots,n\}`),
          " について ",
          math(String.raw`\lambda_k=0_{\mathbb{C}}`),
          " である。",
        ],
      ]),
      paragraph([
        "一次独立は写像 ",
        math(String.raw`b`),
        " の性質として定めており、像の集合 ",
        math(String.raw`\{b_1,\dots,b_n\}\subseteq V`),
        " の性質としては定めない。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合なので、結論「すべての ",
        math(String.raw`k`),
        " について ",
        math(String.raw`\lambda_k=0_{\mathbb{C}}`),
        "」は条件なしに成り立ち、定義域が空集合の族は一次独立である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_spanning_family",
    kind: "definition",
    title: { text: "線型結合で張る族" },
    labels: ["def_spanning_family"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とする。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`b_k:=b(k)\in V`),
        " と書く。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b`),
        " が次を満たすとき、",
        math(String.raw`b`),
        " は ",
        math(String.raw`V`),
        " を線型結合で張るという。",
      ]),
      list([
        [
          "各 ",
          math(String.raw`x\in V`),
          " に対し、",
          math(String.raw`\{1,\dots,n\}`),
          " の各元 ",
          math(String.raw`k`),
          " に ",
          math(String.raw`\mathbb{C}`),
          " の元 ",
          math(String.raw`\lambda_k`),
          " を一つずつ与える与え方であって、線型結合（",
          ref("def_linear_combination"),
          "）が ",
          math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=x`),
          " を満たすものが存在する。",
        ],
      ]),
      paragraph([
        "張ることは写像 ",
        math(String.raw`b`),
        " の性質として定めており、像の集合 ",
        math(String.raw`\{b_1,\dots,b_n\}\subseteq V`),
        " の性質としては定めない。係数の与え方が一つに決まることは要求しない。",
        math(String.raw`n=0`),
        " のときは線型結合が ",
        math(String.raw`0_V`),
        " だけなので（",
        ref("def_linear_combination"),
        "）、定義域が空集合の族が ",
        math(String.raw`V`),
        " を張るのは ",
        math(String.raw`V=\{0_V\}`),
        " のときに限る。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_basis",
    kind: "definition",
    title: { text: "基底" },
    labels: ["def_basis"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とする。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b`),
        " が次の二つを満たすとき、",
        math(String.raw`b`),
        " は ",
        math(String.raw`V`),
        " の基底であるという。",
      ]),
      list([
        [
          math(String.raw`b`),
          " は一次独立である（",
          ref("def_linear_independence"),
          "）。",
        ],
        [
          math(String.raw`b`),
          " は ",
          math(String.raw`V`),
          " を線型結合で張る（",
          ref("def_spanning_family"),
          "）。",
        ],
      ]),
      paragraph([
        "基底は写像 ",
        math(String.raw`b`),
        " として定めており、番号付けを持たない部分集合 ",
        math(String.raw`\{b_1,\dots,b_n\}\subseteq V`),
        " としては定めない。像の集合が同じでも、番号付けが違う二つの写像は別の族である。",
        "この定義は ",
        math(String.raw`V`),
        " が基底をもつことも、基底の長さ ",
        math(String.raw`n`),
        " が基底の取り方によらないことも主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_zero_scalar_multiple_is_zero_vector",
    kind: "claim",
    title: { text: "零のスカラー倍は零ベクトルである" },
    labels: ["claim_zero_scalar_multiple_is_zero_vector"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。このとき、",
        math(String.raw`V`),
        " の任意の元 ",
        math(String.raw`x`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`0_{\mathbb{C}}\cdot_V x=0_V`),
    ],
    proof: [
      paragraph([
        math(String.raw`x`),
        " を ",
        math(String.raw`V`),
        " の任意の元とする。加法の逆元の存在（",
        ref("def_complex_vector_space"),
        "）により、",
        math(String.raw`(0_{\mathbb{C}}\cdot_V x)+_V y'=0_V`),
        " を満たす ",
        math(String.raw`y'\in V`),
        " を一つ選ぶ。",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{C}}\cdot_V x
&=(0_{\mathbb{C}}\cdot_V x)+_V 0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=(0_{\mathbb{C}}\cdot_V x)+_V\bigl((0_{\mathbb{C}}\cdot_V x)+_V y'\bigr)
&&\left(\because\ y'\ \text{の選び方}\right)\\
&=\bigl((0_{\mathbb{C}}\cdot_V x)+_V(0_{\mathbb{C}}\cdot_V x)\bigr)+_V y'
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}})\cdot_V x\bigr)+_V y'
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(0_{\mathbb{C}}\cdot_V x)+_V y'
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=0_V
&&\left(\because\ y'\ \text{の選び方}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_of_linear_combinations_of_same_family",
    kind: "claim",
    title: { text: "同じ族の二つの線型結合の和は、係数ごとの和による線型結合である" },
    labels: ["claim_sum_of_linear_combinations_of_same_family"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " と ",
        math(String.raw`\mu_k`),
        " が一つずつ与えられているとする。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)=\sum_{k=1}^{n}(\lambda_k+_{\mathbb{C}}\mu_k)\cdot_V b_k`),
    ],
    proof: [
      paragraph([
        "係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        "、",
        math(String.raw`\mu_1,\dots,\mu_n`),
        "、",
        math(String.raw`\lambda_1+_{\mathbb{C}}\mu_1,\dots,\lambda_n+_{\mathbb{C}}\mu_n`),
        " のそれぞれと族 ",
        math(String.raw`b`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）を、順に ",
        math(String.raw`L^{\lambda}_m`),
        "、",
        math(String.raw`L^{\mu}_m`),
        "、",
        math(String.raw`L^{\lambda+\mu}_m`),
        " と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L^{\lambda}_0:=0_V`),
          "、",
          math(String.raw`L^{\lambda}_m:=L^{\lambda}_{m-1}+_V(\lambda_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{\mu}_0:=0_V`),
          "、",
          math(String.raw`L^{\mu}_m:=L^{\mu}_{m-1}+_V(\mu_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{\lambda+\mu}_0:=0_V`),
          "、",
          math(String.raw`L^{\lambda+\mu}_m:=L^{\lambda+\mu}_{m-1}+_V\bigl((\lambda_m+_{\mathbb{C}}\mu_m)\cdot_V b_m\bigr)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "主張の左辺は ",
        math(String.raw`L^{\lambda}_n+_V L^{\mu}_n`),
        "、右辺は ",
        math(String.raw`L^{\lambda+\mu}_n`),
        " である。すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{\lambda}_m+_V L^{\mu}_m=L^{\lambda+\mu}_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m=n`),
        " の場合が主張である。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
L^{\lambda}_0+_V L^{\mu}_0
&=0_V+_V 0_V
&&\left(\because\ L^{\lambda}_0,\ L^{\mu}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda+\mu}_0
&&\left(\because\ L^{\lambda+\mu}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`L^{\lambda}_{m-1}+_V L^{\mu}_{m-1}=L^{\lambda+\mu}_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。式を短くするため、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`c:=\lambda_m\cdot_V b_m`),
        " と ",
        math(String.raw`d:=\mu_m\cdot_V b_m`),
        " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{\lambda}_m+_V L^{\mu}_m
&=\bigl(L^{\lambda}_{m-1}+_V c\bigr)+_V\bigl(L^{\mu}_{m-1}+_V d\bigr)
&&\left(\because\ L^{\lambda}_m,\ L^{\mu}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{\lambda}_{m-1}+_V\Bigl(c+_V\bigl(L^{\mu}_{m-1}+_V d\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda}_{m-1}+_V\Bigl(\bigl(c+_V L^{\mu}_{m-1}\bigr)+_V d\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda}_{m-1}+_V\Bigl(\bigl(L^{\mu}_{m-1}+_V c\bigr)+_V d\Bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda}_{m-1}+_V\Bigl(L^{\mu}_{m-1}+_V\bigl(c+_V d\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(L^{\lambda}_{m-1}+_V L^{\mu}_{m-1}\bigr)+_V\bigl(c+_V d\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda+\mu}_{m-1}+_V\bigl(c+_V d\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{\lambda+\mu}_{m-1}+_V\bigl((\lambda_m\cdot_V b_m)+_V(\mu_m\cdot_V b_m)\bigr)
&&\left(\because\ c,\ d\ \text{の置き方}\right)\\
&=L^{\lambda+\mu}_{m-1}+_V\bigl((\lambda_m+_{\mathbb{C}}\mu_m)\cdot_V b_m\bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\lambda+\mu}_m
&&\left(\because\ L^{\lambda+\mu}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{\lambda}_m+_V L^{\mu}_m=L^{\lambda+\mu}_m`),
        " が示された。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_scalar_multiple_of_linear_combination",
    kind: "claim",
    title: { text: "線型結合のスカラー倍は、係数のスカラー倍による線型結合である" },
    labels: ["claim_scalar_multiple_of_linear_combination"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " が一つずつ与えられているとし、",
        math(String.raw`\mu\in\mathbb{C}`),
        " とする。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\mu\cdot_V\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)=\sum_{k=1}^{n}(\mu\cdot_{\mathbb{C}}\lambda_k)\cdot_V b_k`),
    ],
    proof: [
      paragraph([
        "係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        " と ",
        math(String.raw`\mu\cdot_{\mathbb{C}}\lambda_1,\dots,\mu\cdot_{\mathbb{C}}\lambda_n`),
        " のそれぞれと族 ",
        math(String.raw`b`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）を、順に ",
        math(String.raw`L^{\lambda}_m`),
        "、",
        math(String.raw`L^{\mu\lambda}_m`),
        " と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L^{\lambda}_0:=0_V`),
          "、",
          math(String.raw`L^{\lambda}_m:=L^{\lambda}_{m-1}+_V(\lambda_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{\mu\lambda}_0:=0_V`),
          "、",
          math(String.raw`L^{\mu\lambda}_m:=L^{\mu\lambda}_{m-1}+_V\bigl((\mu\cdot_{\mathbb{C}}\lambda_m)\cdot_V b_m\bigr)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "主張の左辺は ",
        math(String.raw`\mu\cdot_V L^{\lambda}_n`),
        "、右辺は ",
        math(String.raw`L^{\mu\lambda}_n`),
        " である。すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`\mu\cdot_V L^{\lambda}_m=L^{\mu\lambda}_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m=n`),
        " の場合が主張である。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mu\cdot_V L^{\lambda}_0
&=\mu\cdot_V 0_V
&&\left(\because\ L^{\lambda}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\mu\cdot_V(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=(\mu\cdot_{\mathbb{C}}0_{\mathbb{C}})\cdot_V 0_V
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_V 0_V
&&\left(\because\ \mu\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=0_V
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=L^{\mu\lambda}_0
&&\left(\because\ L^{\mu\lambda}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`\mu\cdot_V L^{\lambda}_{m-1}=L^{\mu\lambda}_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu\cdot_V L^{\lambda}_m
&=\mu\cdot_V\bigl(L^{\lambda}_{m-1}+_V(\lambda_m\cdot_V b_m)\bigr)
&&\left(\because\ L^{\lambda}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\bigl(\mu\cdot_V L^{\lambda}_{m-1}\bigr)+_V\bigl(\mu\cdot_V(\lambda_m\cdot_V b_m)\bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\mu\lambda}_{m-1}+_V\bigl(\mu\cdot_V(\lambda_m\cdot_V b_m)\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{\mu\lambda}_{m-1}+_V\bigl((\mu\cdot_{\mathbb{C}}\lambda_m)\cdot_V b_m\bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{\mu\lambda}_m
&&\left(\because\ L^{\mu\lambda}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`\mu\cdot_V L^{\lambda}_m=L^{\mu\lambda}_m`),
        " が示された。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_uniqueness_of_coefficients_of_linear_combination",
    kind: "claim",
    title: { text: "一次独立な族による線型結合の係数の一意性" },
    labels: ["claim_uniqueness_of_coefficients_of_linear_combination"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の一次独立な番号付けた族（",
        ref("def_linear_independence"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " と ",
        math(String.raw`\mu_k`),
        " が一つずつ与えられ、線型結合（",
        ref("def_linear_combination"),
        "）について",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=\sum_{k=1}^{n}\mu_k\cdot_V b_k`),
      paragraph([
        "が成り立つとする。このとき、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\lambda_k=\mu_k`),
        " である。",
      ]),
      paragraph([
        "仮定に使うのは族 ",
        math(String.raw`b`),
        " の一次独立性だけであり、",
        math(String.raw`b`),
        " が ",
        math(String.raw`V`),
        " を線型結合で張ることは使わない。",
        math(String.raw`V`),
        " の基底（",
        ref("def_basis"),
        "）は一次独立な族なので、基底による線型結合の係数はこの主張により一つに決まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`-1_{\mathbb{C}}`),
        " を、",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元（",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元）とする。",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`y`),
        " と、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " ごとの ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\nu_k`),
        " を次で置く。",
      ]),
      list([
        [math(String.raw`y:=\sum_{k=1}^{n}\mu_k\cdot_V b_k\in V`)],
        [
          math(String.raw`\nu_k:=\lambda_k+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)\in\mathbb{C}`),
          "（",
          math(String.raw`k\in\{1,\dots,n\}`),
          "）",
        ],
      ]),
      paragraph([
        "仮定は ",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=y`),
        " と書ける。まず、係数 ",
        math(String.raw`\nu_1,\dots,\nu_n`),
        " による線型結合が ",
        math(String.raw`0_V`),
        " であることを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\nu_k\cdot_V b_k
&=\sum_{k=1}^{n}\Bigl(\lambda_k+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)\Bigr)\cdot_V b_k
&&\left(\because\ \nu_k\ \text{の置き方}\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)\cdot_V b_k\right)
&&\left(\because\ \text{同じ族の線型結合の和。}\blkref{claim_sum_of_linear_combinations_of_same_family}\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)+_V\left((-1_{\mathbb{C}})\cdot_V\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)\right)
&&\left(\because\ \text{線型結合のスカラー倍（}\mu=-1_{\mathbb{C}}\text{）。}\blkref{claim_scalar_multiple_of_linear_combination}\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)+_V\bigl((-1_{\mathbb{C}})\cdot_V y\bigr)
&&\left(\because\ y\ \text{の置き方}\right)\\
&=y+_V\bigl((-1_{\mathbb{C}})\cdot_V y\bigr)
&&\left(\because\ \text{仮定}\right)\\
&=(1_{\mathbb{C}}\cdot_V y)+_V\bigl((-1_{\mathbb{C}})\cdot_V y\bigr)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_V y
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_V y
&&\left(\because\ -1_{\mathbb{C}}\ \text{の定め方}\right)\\
&=0_V
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=y\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "族 ",
        math(String.raw`b`),
        " は一次独立なので、一次独立の定義（",
        ref("def_linear_independence"),
        "）を係数 ",
        math(String.raw`\nu_1,\dots,\nu_n`),
        " に適用して、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\nu_k=0_{\mathbb{C}}`),
        " を得る。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " を任意に取る。次の式変形はすべて ",
        math(String.raw`\mathbb{C}`),
        " の中の計算である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu_k
&=0_{\mathbb{C}}+_{\mathbb{C}}\mu_k
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\nu_k+_{\mathbb{C}}\mu_k
&&\left(\because\ \nu_k=0_{\mathbb{C}}\right)\\
&=\Bigl(\lambda_k+_{\mathbb{C}}\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)\Bigr)+_{\mathbb{C}}\mu_k
&&\left(\because\ \nu_k\ \text{の置き方}\right)\\
&=\lambda_k+_{\mathbb{C}}\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)+_{\mathbb{C}}\mu_k\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\lambda_k+_{\mathbb{C}}\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\mu_k\bigr)+_{\mathbb{C}}\bigl(1_{\mathbb{C}}\cdot_{\mathbb{C}}\mu_k\bigr)\Bigr)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\lambda_k+_{\mathbb{C}}\Bigl(\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\cdot_{\mathbb{C}}\mu_k\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=\lambda_k+_{\mathbb{C}}\Bigl(\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{\mathbb{C}}\mu_k\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\lambda_k+_{\mathbb{C}}\bigl(0_{\mathbb{C}}\cdot_{\mathbb{C}}\mu_k\bigr)
&&\left(\because\ -1_{\mathbb{C}}\ \text{の定め方}\right)\\
&=\lambda_k+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}\mu_k=0_{\mathbb{C}}\right)\\
&=\lambda_k
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "したがって、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\lambda_k=\mu_k`),
        " である。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合なので、結論は条件なしに成り立つ。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_coordinate_map_is_linear_form",
    kind: "claim",
    title: { text: "基底についての座標の写像は線型形式である" },
    labels: ["claim_coordinate_map_is_linear_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の基底（",
        ref("def_basis"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`x\in V`),
        " に対し、",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " を一つずつ与える与え方であって、線型結合（",
        ref("def_linear_combination"),
        "）が ",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=x`),
        " を満たすものは、ちょうど一つ存在する。存在するのは ",
        math(String.raw`b`),
        " が ",
        math(String.raw`V`),
        " を線型結合で張るからであり（",
        ref("def_spanning_family"),
        "）、一つしかないのは ",
        math(String.raw`b`),
        " が一次独立だからである（",
        ref("claim_uniqueness_of_coefficients_of_linear_combination"),
        "）。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、この与え方が ",
        math(String.raw`k`),
        " に与える ",
        math(String.raw`\mathbb{C}`),
        " の元を ",
        math(String.raw`\beta^{b}_k(x)`),
        " と書く。これで写像 ",
        math(String.raw`\beta^{b}_k:V\to\mathbb{C}`),
        " が定まり、",
        math(String.raw`b`),
        " についての第 ",
        math(String.raw`k`),
        " 座標の写像と呼ぶ。定め方から、",
        math(String.raw`x\in V`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [
          math(String.raw`\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V b_k=x`),
          "。",
        ],
        [
          math(String.raw`\{1,\dots,n\}`),
          " の各元 ",
          math(String.raw`k`),
          " に ",
          math(String.raw`\mathbb{C}`),
          " の元 ",
          math(String.raw`\lambda_k`),
          " を一つずつ与える与え方が ",
          math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V b_k=x`),
          " を満たすならば、すべての ",
          math(String.raw`k\in\{1,\dots,n\}`),
          " について ",
          math(String.raw`\beta^{b}_k(x)=\lambda_k`),
          " である。",
        ],
      ]),
      paragraph([
        "このとき、各 ",
        math(String.raw`i\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`\beta^{b}_i`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）である。",
      ]),
      paragraph([
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合で座標の写像が一つも無いので、",
        math(String.raw`n\ge 1`),
        " とした。",
        math(String.raw`\beta^{b}_k`),
        " は族 ",
        math(String.raw`b`),
        " 全体に依存し、",
        math(String.raw`b_k`),
        " 一つだけからは決まらない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i\in\{1,\dots,n\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\rho\in\mathbb{C}`),
        " を任意に取り、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " ごとの ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " と ",
        math(String.raw`\mu_k`),
        " を次で置く。",
      ]),
      list([
        [math(String.raw`\lambda_k:=\beta^{b}_k(x)\in\mathbb{C}`)],
        [math(String.raw`\mu_k:=\beta^{b}_k(y)\in\mathbb{C}`)],
      ]),
      paragraph([
        "まず、係数 ",
        math(String.raw`\lambda_1+_{\mathbb{C}}\mu_1,\dots,\lambda_n+_{\mathbb{C}}\mu_n`),
        " による線型結合が ",
        math(String.raw`x+_V y`),
        " であることを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}(\lambda_k+_{\mathbb{C}}\mu_k)\cdot_V b_k
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)
&&\left(\because\ \text{同じ族の線型結合の和。}\blkref{claim_sum_of_linear_combinations_of_same_family}\right)\\
&=\left(\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\beta^{b}_k(y)\cdot_V b_k\right)
&&\left(\because\ \lambda_k,\ \mu_k\ \text{の置き方}\right)\\
&=x+_V y
&&\left(\because\ \text{主張の中の座標の写像の一つ目の性質を}\ x\ \text{と}\ y\ \text{に}\right).
\end{aligned}`),
      paragraph([
        "次に、係数 ",
        math(String.raw`\rho\cdot_{\mathbb{C}}\lambda_1,\dots,\rho\cdot_{\mathbb{C}}\lambda_n`),
        " による線型結合が ",
        math(String.raw`\rho\cdot_V x`),
        " であることを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}(\rho\cdot_{\mathbb{C}}\lambda_k)\cdot_V b_k
&=\rho\cdot_V\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)
&&\left(\because\ \text{線型結合のスカラー倍（}\mu=\rho\text{）。}\blkref{claim_scalar_multiple_of_linear_combination}\right)\\
&=\rho\cdot_V\left(\sum_{k=1}^{n}\beta^{b}_k(x)\cdot_V b_k\right)
&&\left(\because\ \lambda_k\ \text{の置き方}\right)\\
&=\rho\cdot_V x
&&\left(\because\ \text{主張の中の座標の写像の一つ目の性質を}\ x\ \text{に}\right).
\end{aligned}`),
      paragraph(["加法を保つこと："]),
      displayMath(String.raw`\begin{aligned}
\beta^{b}_i(x+_V y)
&=\lambda_i+_{\mathbb{C}}\mu_i
&&\left(\because\ \text{主張の中の座標の写像の二つ目の性質を}\ x+_V y\ \text{と係数}\ \lambda_k+_{\mathbb{C}}\mu_k\ \text{に。上の一つ目の式変形}\right)\\
&=\beta^{b}_i(x)+_{\mathbb{C}}\beta^{b}_i(y)
&&\left(\because\ \lambda_i,\ \mu_i\ \text{の置き方}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと："]),
      displayMath(String.raw`\begin{aligned}
\beta^{b}_i(\rho\cdot_V x)
&=\rho\cdot_{\mathbb{C}}\lambda_i
&&\left(\because\ \text{主張の中の座標の写像の二つ目の性質を}\ \rho\cdot_V x\ \text{と係数}\ \rho\cdot_{\mathbb{C}}\lambda_k\ \text{に。上の二つ目の式変形}\right)\\
&=\rho\cdot_{\mathbb{C}}\beta^{b}_i(x)
&&\left(\because\ \lambda_i\ \text{の置き方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x,y,\rho`),
        " は任意だったので、",
        math(String.raw`\beta^{b}_i`),
        " は線型形式の定義（",
        ref("def_linear_form"),
        "）の二つの条件を満たす。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_ordered_sum_in_complex_numbers",
    kind: "definition",
    title: { text: "ℂ の中の番号順の和" },
    labels: ["def_ordered_sum_in_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_k`),
        " が一つずつ与えられているとする（",
        math(String.raw`n=0`),
        " のときは何も与えられていない）。",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`S_m`),
        " を次で帰納的に定める。",
      ]),
      list([
        [math(String.raw`S_0:=0_{\mathbb{C}}`)],
        [
          math(String.raw`S_m:=S_{m-1}+_{\mathbb{C}}\alpha_m`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        math(String.raw`S_n`),
        " を、",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和と呼び、",
        math(String.raw`\sum_{\mathbb{C},\,k=1}^{n}\alpha_k`),
        " と書く。",
      ]),
      paragraph([
        "演算は ",
        math(String.raw`\mathbb{C}`),
        " の加法 ",
        math(String.raw`+_{\mathbb{C}}`),
        " と加法の単位元 ",
        math(String.raw`0_{\mathbb{C}}`),
        " だけであり、和の記号の添字 ",
        math(String.raw`\mathbb{C}`),
        " でそれを示す。線型結合（",
        ref("def_linear_combination"),
        "）の記号 ",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k`),
        " とは別の記号である。",
        math(String.raw`\mathbb{C}`),
        " に ℂ-線型空間の構造を与える組にはまだ名前を付けていないので、この和を ",
        math(String.raw`\mathbb{C}`),
        " の中の線型結合としては定めない。",
      ]),
      paragraph([
        "和は番号 ",
        math(String.raw`1,\dots,n`),
        " の順に左から足していく一つの式として定めており、和の順序や括弧の付け方によらないことはここでは主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_form_maps_linear_combination_to_ordered_sum",
    kind: "claim",
    title: { text: "線型形式は線型結合を、係数と値の積の ℂ の中の番号順の和へ移す" },
    labels: ["claim_linear_form_maps_linear_combination_to_ordered_sum"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to\mathbb{C}`),
        " を ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " が一つずつ与えられているとする。このとき、線型結合（",
        ref("def_linear_combination"),
        "）と ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`f\left(\sum_{k=1}^{n}\lambda_k\cdot_V b_k\right)=\sum_{\mathbb{C},\,k=1}^{n}\lambda_k\cdot_{\mathbb{C}}f(b_k)`),
      paragraph([
        "右辺は、",
        math(String.raw`\alpha_k:=\lambda_k\cdot_{\mathbb{C}}f(b_k)\in\mathbb{C}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）と置いたときの ",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和である。",
      ]),
    ],
    proof: [
      paragraph([
        "係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        " と族 ",
        math(String.raw`b`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元を ",
        math(String.raw`L_m`),
        "、",
        math(String.raw`\alpha_k:=\lambda_k\cdot_{\mathbb{C}}f(b_k)`),
        " について ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和の定義（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）が帰納的に定める ",
        math(String.raw`\mathbb{C}`),
        " の元を ",
        math(String.raw`S_m`),
        " と書く（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L_0:=0_V`),
          "、",
          math(String.raw`L_m:=L_{m-1}+_V(\lambda_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`S_0:=0_{\mathbb{C}}`),
          "、",
          math(String.raw`S_m:=S_{m-1}+_{\mathbb{C}}\bigl(\lambda_m\cdot_{\mathbb{C}}f(b_m)\bigr)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "主張の左辺は ",
        math(String.raw`f(L_n)`),
        "、右辺は ",
        math(String.raw`S_n`),
        " である。すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`f(L_m)=S_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m=n`),
        " の場合が主張である。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
f(L_0)
&=f(0_V)
&&\left(\because\ L_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=f(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}f(0_V)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}z=0_{\mathbb{C}}\right)\\
&=S_0
&&\left(\because\ S_0\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`f(L_{m-1})=S_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
f(L_m)
&=f\bigl(L_{m-1}+_V(\lambda_m\cdot_V b_m)\bigr)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=f(L_{m-1})+_{\mathbb{C}}f(\lambda_m\cdot_V b_m)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=S_{m-1}+_{\mathbb{C}}f(\lambda_m\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=S_{m-1}+_{\mathbb{C}}\bigl(\lambda_m\cdot_{\mathbb{C}}f(b_m)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=S_m
&&\left(\because\ S_m\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`f(L_m)=S_m`),
        " が示された。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_kronecker_delta",
    kind: "definition",
    title: { text: "クロネッカーのデルタ" },
    labels: ["def_kronecker_delta"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を集合とする。",
        math(String.raw`X`),
        " の元 ",
        math(String.raw`i`),
        " と ",
        math(String.raw`j`),
        " の組ごとに、",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\delta_{i,j}`),
        " を次で定め、クロネッカーのデルタと呼ぶ。",
      ]),
      displayMath(String.raw`\delta_{i,j}:=
\begin{cases}
  1_{\mathbb{C}} & (i=j),\\
  0_{\mathbb{C}} & (i\neq j).
\end{cases}`),
      paragraph([
        "値は ",
        math(String.raw`\mathbb{C}`),
        " の乗法の単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " と加法の単位元 ",
        math(String.raw`0_{\mathbb{C}}`),
        " のどちらかであり、整数の ",
        math(String.raw`1`),
        " と ",
        math(String.raw`0`),
        " ではない。",
        math(String.raw`\delta_{i,j}`),
        " を定めるのは ",
        math(String.raw`i`),
        " と ",
        math(String.raw`j`),
        " が同じ集合 ",
        math(String.raw`X`),
        " の元であるときだけであり、値は ",
        math(String.raw`X`),
        " の中で ",
        math(String.raw`i=j`),
        " が成り立つかどうかだけで決まる。",
        math(String.raw`X`),
        " の上の演算や順序は使わない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_family_member_is_kronecker_delta_linear_combination",
    kind: "claim",
    title: { text: "番号付けた族の第 j 元は、係数がクロネッカーのデルタの線型結合である" },
    labels: ["claim_family_member_is_kronecker_delta_linear_combination"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`j\in\{1,\dots,n\}`),
        " とし、",
        math(String.raw`\{1,\dots,n\}`),
        " の二元についてのクロネッカーのデルタ ",
        math(String.raw`\delta_{k,j}\in\mathbb{C}`),
        "（",
        ref("def_kronecker_delta"),
        " で ",
        math(String.raw`X:=\{1,\dots,n\}`),
        " としたもの）を係数に取る。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\delta_{k,j}\cdot_V b_k=b_j`),
    ],
    proof: [
      paragraph([
        "係数 ",
        math(String.raw`\delta_{1,j},\dots,\delta_{n,j}`),
        " と族 ",
        math(String.raw`b`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元を ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）と書く。すなわち ",
        math(String.raw`L_0:=0_V`),
        "、",
        math(String.raw`L_m:=L_{m-1}+_V(\delta_{m,j}\cdot_V b_m)`),
        "（",
        math(String.raw`1\le m\le n`),
        "）であり、主張の左辺は ",
        math(String.raw`L_n`),
        " である。",
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について次が成り立つことを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      displayMath(String.raw`L_m=
\begin{cases}
  0_V & (m<j),\\
  b_j & (m\ge j).
\end{cases}`),
      paragraph([
        math(String.raw`n\ge j`),
        " なので、",
        math(String.raw`m=n`),
        " の場合が主張 ",
        math(String.raw`L_n=b_j`),
        " である。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき：",
        math(String.raw`j\ge 1`),
        " なので ",
        math(String.raw`0<j`),
        " であり、",
        math(String.raw`L_0=0_V`),
        " は ",
        math(String.raw`L_0`),
        " の定義（",
        ref("def_linear_combination"),
        "）そのものである。",
      ]),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`m-1`),
        " について上の等式が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`m`),
        " と ",
        math(String.raw`j`),
        " の大小で三つに場合を分ける。",
      ]),
      paragraph([
        math(String.raw`m<j`),
        " のとき：",
        math(String.raw`m-1<j`),
        " かつ ",
        math(String.raw`m\neq j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=0_V+_V(0_{\mathbb{C}}\cdot_V b_m)
&&\left(\because\ m\neq j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=0_V+_V 0_V
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=j`),
        " のとき：",
        math(String.raw`m-1<j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=0_V+_V(1_{\mathbb{C}}\cdot_V b_m)
&&\left(\because\ m=j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=0_V+_V b_m
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=b_m+_V 0_V
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=b_m
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=b_j
&&\left(\because\ m=j\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m>j`),
        " のとき：",
        math(String.raw`m-1\ge j`),
        " かつ ",
        math(String.raw`m\neq j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=b_j+_V(\delta_{m,j}\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1\ge j\right)\\
&=b_j+_V(0_{\mathbb{C}}\cdot_V b_m)
&&\left(\because\ m\neq j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=b_j+_V 0_V
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=b_j
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について帰納法の主張が示された。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_dual_basis",
    kind: "definition",
    title: { text: "双対基底" },
    labels: ["def_dual_basis"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の基底（",
        ref("def_basis"),
        "）とする。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`b_k:=b(k)\in V`),
        " と書く。",
        math(String.raw`V`),
        " の双対空間 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        "（",
        ref("def_dual_space"),
        "）は ℂ-線型空間である（",
        ref("claim_dual_space_is_complex_vector_space"),
        "）ので、",
        math(String.raw`V^{*}`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）が定まる。",
      ]),
      paragraph([
        math(String.raw`f:\{1,\dots,n\}\to V^{*}`),
        " を ",
        math(String.raw`V^{*}`),
        " の元の番号付けた族とし、",
        math(String.raw`i\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`f_i:=f(i)\in V^{*}`),
        " と書く。族 ",
        math(String.raw`f`),
        " が次を満たすとき、",
        math(String.raw`f`),
        " は基底 ",
        math(String.raw`b`),
        " の双対基底であるという。",
      ]),
      list([
        [
          "すべての ",
          math(String.raw`i\in\{1,\dots,n\}`),
          " と ",
          math(String.raw`j\in\{1,\dots,n\}`),
          " について、",
          math(String.raw`\mathbb{C}`),
          " の等式 ",
          math(String.raw`f_i(b_j)=\delta_{i,j}`),
          " が成り立つ。ここで ",
          math(String.raw`\delta_{i,j}\in\mathbb{C}`),
          " は ",
          math(String.raw`X:=\{1,\dots,n\}`),
          " の二元についてのクロネッカーのデルタ（",
          ref("def_kronecker_delta"),
          "）である。",
        ],
      ]),
      paragraph([
        math(String.raw`f_i(b_j)`),
        " は線型形式 ",
        math(String.raw`f_i:V\to\mathbb{C}`),
        "（",
        ref("def_linear_form"),
        "）の ",
        math(String.raw`b_j\in V`),
        " での値であり、",
        math(String.raw`\mathbb{C}`),
        " の元である。双対基底は基底 ",
        math(String.raw`b`),
        " ごとに定める概念であり、同じ ",
        math(String.raw`V`),
        " でも基底が違えば条件が違う。",
        "この定義は、双対基底が存在することも、",
        math(String.raw`f`),
        " が ",
        math(String.raw`V^{*}`),
        " の基底であることも主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_coordinate_maps_form_dual_basis",
    kind: "claim",
    title: { text: "座標の写像の族は双対基底である（双対基底の存在）" },
    labels: ["claim_coordinate_maps_form_dual_basis"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の基底（",
        ref("def_basis"),
        "）とし、",
        math(String.raw`b_k:=b(k)`),
        " と書く。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`\beta^{b}_k:V\to\mathbb{C}`),
        " を ",
        math(String.raw`b`),
        " についての第 ",
        math(String.raw`k`),
        " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"),
        "）とする。",
        math(String.raw`\beta^{b}_k`),
        " は ",
        math(String.raw`V`),
        " 上の線型形式である（",
        ref("claim_coordinate_map_is_linear_form"),
        "）ので、双対空間 ",
        math(String.raw`V^{*}`),
        "（",
        ref("def_dual_space"),
        "）の元である。そこで、",
        math(String.raw`V^{*}`),
        " の元の番号付けた族 ",
        math(String.raw`\beta^{b}:\{1,\dots,n\}\to V^{*}`),
        " を ",
        math(String.raw`\beta^{b}(k):=\beta^{b}_k`),
        " で定める。",
      ]),
      paragraph([
        "このとき、",
        math(String.raw`\beta^{b}`),
        " は基底 ",
        math(String.raw`b`),
        " の双対基底（",
        ref("def_dual_basis"),
        "）である。すなわち、すべての ",
        math(String.raw`i\in\{1,\dots,n\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の等式 ",
        math(String.raw`\beta^{b}_i(b_j)=\delta_{i,j}`),
        " が成り立つ。ここで ",
        math(String.raw`\delta_{i,j}\in\mathbb{C}`),
        " は ",
        math(String.raw`X:=\{1,\dots,n\}`),
        " の二元についてのクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）である。",
      ]),
      paragraph([
        "座標の写像は ",
        math(String.raw`n\ge 1`),
        " のときに定めたので、",
        math(String.raw`n\ge 1`),
        " とした。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合であり、空集合から ",
        math(String.raw`V^{*}`),
        " へのただ一つの写像が、双対基底の条件を満たすべき ",
        math(String.raw`i,j`),
        " を持たないので双対基底である。この主張は双対基底の一意性も、",
        math(String.raw`\beta^{b}`),
        " が ",
        math(String.raw`V^{*}`),
        " の基底であることも主張しない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`i\in\{1,\dots,n\}`),
        " と ",
        math(String.raw`j\in\{1,\dots,n\}`),
        " を任意に取る。まず、",
        math(String.raw`b_j`),
        " の座標を係数とする線型結合（",
        ref("def_linear_combination"),
        "）が、係数 ",
        math(String.raw`\delta_{1,j},\dots,\delta_{n,j}`),
        " による線型結合に等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\beta^{b}_k(b_j)\cdot_V b_k
&=b_j
&&\left(\because\ \text{座標の写像の一つ目の性質を}\ x=b_j\ \text{に。}\blkref{claim_coordinate_map_is_linear_form}\right)\\
&=\sum_{k=1}^{n}\delta_{k,j}\cdot_V b_k
&&\left(\because\ \text{族の第}\ j\ \text{元はデルタを係数とする線型結合。}\blkref{claim_family_member_is_kronecker_delta_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "基底 ",
        math(String.raw`b`),
        " は一次独立である（",
        ref("def_basis"),
        "）。そこで、一次独立な族による線型結合の係数の一意性（",
        ref("claim_uniqueness_of_coefficients_of_linear_combination"),
        "）を、",
        math(String.raw`\lambda_k:=\beta^{b}_k(b_j)`),
        "、",
        math(String.raw`\mu_k:=\delta_{k,j}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）として上の等式に適用すると、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\beta^{b}_k(b_j)=\delta_{k,j}`),
        " を得る。これを ",
        math(String.raw`k=i`),
        " で読むと ",
        math(String.raw`\beta^{b}_i(b_j)=\delta_{i,j}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`i,j`),
        " は任意だったので、族 ",
        math(String.raw`\beta^{b}`),
        " は双対基底の定義（",
        ref("def_dual_basis"),
        "）の条件を満たす。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_value_of_linear_combination_in_dual_space",
    kind: "claim",
    title: { text: "双対空間の元の線型結合の点での値は、係数と値の積の ℂ の中の番号順の和である" },
    labels: ["claim_value_of_linear_combination_in_dual_space"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " をその双対空間（",
        ref("def_dual_space"),
        "）とする。双対空間は ℂ-線型空間である（",
        ref("claim_dual_space_is_complex_vector_space"),
        "）ので、",
        math(String.raw`V^{*}`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）と、",
        math(String.raw`V^{*}`),
        " の中の線型結合（",
        ref("def_linear_combination"),
        "）が定まる。",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`f:\{1,\dots,n\}\to V^{*}`),
        " を ",
        math(String.raw`V^{*}`),
        " の元の番号付けた族とし、",
        math(String.raw`f_k:=f(k)\in V^{*}`),
        " と書く。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " が一つずつ与えられているとする。このとき、すべての ",
        math(String.raw`x\in V`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）を使った次の ",
        math(String.raw`\mathbb{C}`),
        " の等式が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{k=1}^{n}\lambda_k\cdot_{V^{*}}f_k\right)(x)=\sum_{\mathbb{C},\,k=1}^{n}\lambda_k\cdot_{\mathbb{C}}f_k(x)`),
      paragraph([
        "左辺は、",
        math(String.raw`V^{*}`),
        " の中の線型結合 ",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_{V^{*}}f_k\in V^{*}`),
        "、すなわち ",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）の、",
        math(String.raw`x`),
        " での値である。右辺は、",
        math(String.raw`\alpha_k:=\lambda_k\cdot_{\mathbb{C}}f_k(x)\in\mathbb{C}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）と置いたときの ",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x\in V`),
        " を任意に取る。係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        " と族 ",
        math(String.raw`f`),
        " について、ℂ-線型空間 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " の中の線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V^{*}`),
        " の元を ",
        math(String.raw`L_r`),
        "、",
        math(String.raw`\alpha_k:=\lambda_k\cdot_{\mathbb{C}}f_k(x)`),
        " について ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和の定義（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）が帰納的に定める ",
        math(String.raw`\mathbb{C}`),
        " の元を ",
        math(String.raw`S_r`),
        " と書く（",
        math(String.raw`r\in\{0,1,\dots,n\}`),
        "）。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L_0:=0_{V^{*}}`),
          "、",
          math(String.raw`L_r:=L_{r-1}+_{V^{*}}(\lambda_r\cdot_{V^{*}}f_r)`),
          "（",
          math(String.raw`1\le r\le n`),
          "）",
        ],
        [
          math(String.raw`S_0:=0_{\mathbb{C}}`),
          "、",
          math(String.raw`S_r:=S_{r-1}+_{\mathbb{C}}\bigl(\lambda_r\cdot_{\mathbb{C}}f_r(x)\bigr)`),
          "（",
          math(String.raw`1\le r\le n`),
          "）",
        ],
      ]),
      paragraph([
        "主張の左辺は ",
        math(String.raw`L_n(x)`),
        "、右辺は ",
        math(String.raw`S_n`),
        " である。すべての ",
        math(String.raw`r\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L_r(x)=S_r`),
        " であることを、",
        math(String.raw`r`),
        " についての帰納法で示す。",
        math(String.raw`r=n`),
        " の場合が主張である。",
      ]),
      paragraph([math(String.raw`r=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
L_0(x)
&=0_{V^{*}}(x)
&&\left(\because\ L_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=z_V(x)
&&\left(\because\ 0_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ z_V\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right)\\
&=S_0
&&\left(\because\ S_0\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le r\le n`),
        " とし、",
        math(String.raw`L_{r-1}(x)=S_{r-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_r(x)
&=\bigl(L_{r-1}+_{V^{*}}(\lambda_r\cdot_{V^{*}}f_r)\bigr)(x)
&&\left(\because\ L_r\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=s_{L_{r-1},\,\lambda_r\cdot_{V^{*}}f_r}(x)
&&\left(\because\ +_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=L_{r-1}(x)+_{\mathbb{C}}(\lambda_r\cdot_{V^{*}}f_r)(x)
&&\left(\because\ s\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=S_{r-1}+_{\mathbb{C}}(\lambda_r\cdot_{V^{*}}f_r)(x)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=S_{r-1}+_{\mathbb{C}}m_{\lambda_r,f_r}(x)
&&\left(\because\ \cdot_{V^{*}}\ \text{の定義。}\blkref{def_dual_space}\right)\\
&=S_{r-1}+_{\mathbb{C}}\bigl(\lambda_r\cdot_{\mathbb{C}}f_r(x)\bigr)
&&\left(\because\ m\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=S_r
&&\left(\because\ S_r\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`r\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L_r(x)=S_r`),
        " が示された。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`r=0`),
        " の場合だけで足りる。",
        math(String.raw`x`),
        " は任意だったので、主張がすべての ",
        math(String.raw`x\in V`),
        " について成り立つ。",
      ]),
    ],
  },
]);
