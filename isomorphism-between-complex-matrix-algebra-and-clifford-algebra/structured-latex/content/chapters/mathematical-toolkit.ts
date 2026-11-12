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
    id: "mathematical_toolkit_claim_scalar_multiple_of_zero_vector_is_zero_vector",
    kind: "claim",
    title: { text: "零ベクトルのスカラー倍は零ベクトルである" },
    labels: ["claim_scalar_multiple_of_zero_vector_is_zero_vector"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。このとき、",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\lambda\cdot_V 0_V=0_V`),
    ],
    proof: [
      paragraph([
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda\cdot_V 0_V
&=\lambda\cdot_V(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=(\lambda\cdot_{\mathbb{C}}0_{\mathbb{C}})\cdot_V 0_V
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_V 0_V
&&\left(\because\ \lambda\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=0_V
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_form_sends_zero_vector_to_zero",
    kind: "claim",
    title: { text: "線型形式は零ベクトルを 0 へ移す" },
    labels: ["claim_linear_form_sends_zero_vector_to_zero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`g:V\to\mathbb{C}`),
        " を ", math(String.raw`V`), " 上の線型形式（", ref("def_linear_form"), "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`g(0_V)=0_{\mathbb{C}}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
g(0_V)
&=g(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=0_V\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\cdot_{\mathbb{C}}g(0_V)
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ g(0_V)\in\mathbb{C}\ \text{と}\ 0_{\mathbb{C}}\cdot_{\mathbb{C}}g(0_V)=0_{\mathbb{C}}\right).
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
    id: "mathematical_toolkit_claim_linear_combinations_with_equal_terms_are_equal",
    kind: "claim",
    title: { text: "項ごとに等しい二つの線型結合は等しい" },
    labels: ["claim_linear_combinations_with_equal_terms_are_equal"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`V`), " の元 ", math(String.raw`x_k,\ y_k`),
        " と ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_k,\ \mu_k`), " が一つずつ与えられ、すべての ", math(String.raw`k\in\{1,\dots,n\}`),
        " について ", math(String.raw`\lambda_k\cdot_V x_k=\mu_k\cdot_V y_k`), " が成り立つとする。このとき、線型結合（", ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k=\sum_{k=1}^{n}\mu_k\cdot_V y_k`),
    ],
    proof: [
      paragraph([
        "線型結合の定義（", ref("def_linear_combination"), "）が二つの族について帰納的に定める ", math(String.raw`V`), " の元を、順に ",
        math(String.raw`L^{\lambda}_m`), "、", math(String.raw`L^{\mu}_m`), "（", math(String.raw`m\in\{0,1,\dots,n\}`), "）と書く。すなわち ",
        math(String.raw`L^{\lambda}_0:=0_V`), "、", math(String.raw`L^{\lambda}_m:=L^{\lambda}_{m-1}+_V(\lambda_m\cdot_V x_m)`), "、",
        math(String.raw`L^{\mu}_0:=0_V`), "、", math(String.raw`L^{\mu}_m:=L^{\mu}_{m-1}+_V(\mu_m\cdot_V y_m)`), "（", math(String.raw`1\le m\le n`),
        "）である。すべての ", math(String.raw`m`), " について ", math(String.raw`L^{\lambda}_m=L^{\mu}_m`), " であることを ", math(String.raw`m`),
        " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。",
        math(String.raw`m=0`), " のとき、", math(String.raw`L^{\lambda}_0=0_V=L^{\mu}_0`), " である（", ref("def_linear_combination"), "）。",
        math(String.raw`1\le m\le n`), " とし、", math(String.raw`L^{\lambda}_{m-1}=L^{\mu}_{m-1}`), " を仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{\lambda}_m
&=L^{\lambda}_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ L^{\lambda}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{\mu}_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{\mu}_{m-1}+_V(\mu_m\cdot_V y_m)
&&\left(\because\ \text{仮定}\ \lambda_m\cdot_V x_m=\mu_m\cdot_V y_m\right)\\
&=L^{\mu}_m
&&\left(\because\ L^{\mu}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_combination_of_zero_terms_is_zero",
    kind: "claim",
    title: { text: "どの項も零ベクトルである線型結合は零ベクトルである" },
    labels: ["claim_linear_combination_of_zero_terms_is_zero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`V`), " の元 ", math(String.raw`x_k`),
        " と ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_k`), " が一つずつ与えられ、すべての ", math(String.raw`k\in\{1,\dots,n\}`),
        " について ", math(String.raw`\lambda_k\cdot_V x_k=0_V`), " が成り立つとする。このとき、線型結合（", ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k=0_V`),
    ],
    proof: [
      paragraph([
        math(String.raw`L_m`), "（", math(String.raw`m\in\{0,1,\dots,n\}`), "）を線型結合の定義（", ref("def_linear_combination"),
        "）の部分和とする。すべての ", math(String.raw`m`), " について ", math(String.raw`L_m=0_V`), " であることを ", math(String.raw`m`),
        " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。", math(String.raw`m=0`), " のとき、", math(String.raw`L_0=0_V`),
        " である（", ref("def_linear_combination"), "）。", math(String.raw`1\le m\le n`), " とし、", math(String.raw`L_{m-1}=0_V`),
        " を仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_V+_V 0_V
&&\left(\because\ \text{仮定}\ \lambda_m\cdot_V x_m=0_V\right)\\
&=0_V
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_of_linear_combinations_with_same_coefficients",
    kind: "claim",
    title: { text: "同じ係数の二つの線型結合の和は、族の元ごとの和の線型結合である" },
    labels: ["claim_sum_of_linear_combinations_with_same_coefficients"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`V`), " の元 ", math(String.raw`x_k,\ y_k`),
        " と ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_k`), " が一つずつ与えられているとする。このとき、線型結合（",
        ref("def_linear_combination"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)+_V\left(\sum_{k=1}^{n}\lambda_k\cdot_V y_k\right)=\sum_{k=1}^{n}\lambda_k\cdot_V(x_k+_V y_k)`),
    ],
    proof: [
      paragraph([
        "線型結合の定義（", ref("def_linear_combination"), "）が三つの族について帰納的に定める ", math(String.raw`V`), " の元を、順に ",
        math(String.raw`L^{x}_m`), "、", math(String.raw`L^{y}_m`), "、", math(String.raw`L^{x+y}_m`), "（", math(String.raw`m\in\{0,1,\dots,n\}`),
        "）と書く。すなわち ", math(String.raw`L^{x}_0=L^{y}_0=L^{x+y}_0:=0_V`), "、", math(String.raw`L^{x}_m:=L^{x}_{m-1}+_V(\lambda_m\cdot_V x_m)`), "、",
        math(String.raw`L^{y}_m:=L^{y}_{m-1}+_V(\lambda_m\cdot_V y_m)`), "、", math(String.raw`L^{x+y}_m:=L^{x+y}_{m-1}+_V\bigl(\lambda_m\cdot_V(x_m+_V y_m)\bigr)`),
        "（", math(String.raw`1\le m\le n`), "）である。すべての ", math(String.raw`m`), " について ", math(String.raw`L^{x}_m+_V L^{y}_m=L^{x+y}_m`),
        " であることを ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。", math(String.raw`m=0`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{x}_0+_V L^{y}_0
&=0_V+_V 0_V
&&\left(\because\ L^{x}_0,\ L^{y}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=L^{x+y}_0
&&\left(\because\ L^{x+y}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`), " とし、", math(String.raw`L^{x}_{m-1}+_V L^{y}_{m-1}=L^{x+y}_{m-1}`), " を仮定する（帰納法の仮定）。",
        math(String.raw`V`), " の元 ", math(String.raw`c:=\lambda_m\cdot_V x_m`), " と ", math(String.raw`d:=\lambda_m\cdot_V y_m`), " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{x}_m+_V L^{y}_m
&=\bigl(L^{x}_{m-1}+_V c\bigr)+_V\bigl(L^{y}_{m-1}+_V d\bigr)
&&\left(\because\ L^{x}_m,\ L^{y}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{x}_{m-1}+_V\Bigl(c+_V\bigl(L^{y}_{m-1}+_V d\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{x}_{m-1}+_V\Bigl(\bigl(c+_V L^{y}_{m-1}\bigr)+_V d\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{x}_{m-1}+_V\Bigl(\bigl(L^{y}_{m-1}+_V c\bigr)+_V d\Bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{x}_{m-1}+_V\Bigl(L^{y}_{m-1}+_V\bigl(c+_V d\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(L^{x}_{m-1}+_V L^{y}_{m-1}\bigr)+_V\bigl(c+_V d\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{x+y}_{m-1}+_V\bigl(c+_V d\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{x+y}_{m-1}+_V\bigl((\lambda_m\cdot_V x_m)+_V(\lambda_m\cdot_V y_m)\bigr)
&&\left(\because\ c,\ d\ \text{の置き方}\right)\\
&=L^{x+y}_{m-1}+_V\bigl(\lambda_m\cdot_V(x_m+_V y_m)\bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{x+y}_m
&&\left(\because\ L^{x+y}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_splitting_linear_combination_into_first_and_last_terms",
    kind: "claim",
    title: { text: "線型結合は、前の n 項の線型結合と後ろの n' 項の線型結合の和である" },
    labels: ["claim_splitting_linear_combination_into_first_and_last_terms"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n,n'\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`\{1,\dots,n+n'\}`),
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
        " が一つずつ与えられているとする。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n+n'}\lambda_k\cdot_V x_k=\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)+_V\left(\sum_{j=1}^{n'}\lambda_{n+j}\cdot_V x_{n+j}\right)`),
      paragraph([
        "右辺の一つ目の和は、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " に ",
        math(String.raw`x_k`),
        " と ",
        math(String.raw`\lambda_k`),
        " を与える族の線型結合であり、二つ目の和は、",
        math(String.raw`j\in\{1,\dots,n'\}`),
        " に ",
        math(String.raw`x_{n+j}`),
        " と ",
        math(String.raw`\lambda_{n+j}`),
        " を与える族の線型結合である。",
      ]),
    ],
    proof: [
      paragraph([
        "左辺の線型結合について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める元を ",
        math(String.raw`L_m\in V`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n+n'\}`),
        "）、右辺の二つ目の線型結合について定める元を ",
        math(String.raw`L'_m\in V`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n'\}`),
        "）と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L_0:=0_V`),
          "、",
          math(String.raw`L_m:=L_{m-1}+_V(\lambda_m\cdot_V x_m)`),
          "（",
          math(String.raw`1\le m\le n+n'`),
          "）",
        ],
        [
          math(String.raw`L'_0:=0_V`),
          "、",
          math(String.raw`L'_m:=L'_{m-1}+_V(\lambda_{n+m}\cdot_V x_{n+m})`),
          "（",
          math(String.raw`1\le m\le n'`),
          "）",
        ],
      ]),
      paragraph([
        "右辺の一つ目の線型結合について線型結合の定義が定める元は、",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " で ",
        math(String.raw`L_m`),
        " と同じ式（",
        math(String.raw`L_0:=0_V`),
        "、",
        math(String.raw`L_m:=L_{m-1}+_V(\lambda_m\cdot_V x_m)`),
        "）で定まるので、",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k=L_n`),
        " である。また ",
        math(String.raw`\sum_{k=1}^{n+n'}\lambda_k\cdot_V x_k=L_{n+n'}`),
        "、",
        math(String.raw`\sum_{j=1}^{n'}\lambda_{n+j}\cdot_V x_{n+j}=L'_{n'}`),
        " である。",
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n'\}`),
        " について ",
        math(String.raw`L_{n+m}=L_n+_V L'_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
L_{n+0}
&=L_n
&&\left(\because\ n+0=n\right)\\
&=L_n+_V 0_V
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=L_n+_V L'_0
&&\left(\because\ L'_0\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n'`),
        " とし、",
        math(String.raw`L_{n+m-1}=L_n+_V L'_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`1\le n+m\le n+n'`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_{n+m}
&=L_{n+m-1}+_V(\lambda_{n+m}\cdot_V x_{n+m})
&&\left(\because\ L_{n+m}\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=(L_n+_V L'_{m-1})+_V(\lambda_{n+m}\cdot_V x_{n+m})
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L_n+_V\bigl(L'_{m-1}+_V(\lambda_{n+m}\cdot_V x_{n+m})\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L_n+_V L'_m
&&\left(\because\ L'_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n'\}`),
        " について ",
        math(String.raw`L_{n+m}=L_n+_V L'_m`),
        " が示された。これを ",
        math(String.raw`m=n'`),
        " で使い、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n+n'}\lambda_k\cdot_V x_k
&=L_{n+n'}
&&\left(\because\ L_m\ \text{の定め方。}\blkref{def_linear_combination}\right)\\
&=L_n+_V L'_{n'}
&&\left(\because\ \text{上の帰納法の}\ m=n'\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)+_V L'_{n'}
&&\left(\because\ \text{一つ目の線型結合は}\ L_n\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)+_V\left(\sum_{j=1}^{n'}\lambda_{n+j}\cdot_V x_{n+j}\right)
&&\left(\because\ L'_m\ \text{の定め方。}\blkref{def_linear_combination}\right).
\end{aligned}`),
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
  {
    id: "mathematical_toolkit_claim_ordered_sum_with_kronecker_delta_picks_term",
    kind: "claim",
    title: { text: "ℂ の中の番号順の和で、第 k 項にクロネッカーのデルタを掛けた和は第 j 項になる" },
    labels: ["claim_ordered_sum_with_kronecker_delta_picks_term"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " とし、",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_k`),
        " が一つずつ与えられているとする。",
        math(String.raw`j\in\{1,\dots,n\}`),
        " とし、",
        math(String.raw`\{1,\dots,n\}`),
        " の二元についてのクロネッカーのデルタ ",
        math(String.raw`\delta_{k,j}\in\mathbb{C}`),
        "（",
        ref("def_kronecker_delta"),
        " で ",
        math(String.raw`X:=\{1,\dots,n\}`),
        " としたもの）を取る。このとき、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）について次の ",
        math(String.raw`\mathbb{C}`),
        " の等式が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{\mathbb{C},\,k=1}^{n}\alpha_k\cdot_{\mathbb{C}}\delta_{k,j}=\alpha_j`),
      paragraph([
        "左辺は、",
        math(String.raw`\beta_k:=\alpha_k\cdot_{\mathbb{C}}\delta_{k,j}\in\mathbb{C}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）と置いたときの ",
        math(String.raw`\beta_1,\dots,\beta_n`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\beta_k:=\alpha_k\cdot_{\mathbb{C}}\delta_{k,j}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）について、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の和の定義（",
        ref("def_ordered_sum_in_complex_numbers"),
        "）が帰納的に定める ",
        math(String.raw`\mathbb{C}`),
        " の元を ",
        math(String.raw`S_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）と書く。すなわち ",
        math(String.raw`S_0:=0_{\mathbb{C}}`),
        "、",
        math(String.raw`S_m:=S_{m-1}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})`),
        "（",
        math(String.raw`1\le m\le n`),
        "）であり、主張の左辺は ",
        math(String.raw`S_n`),
        " である。",
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について次が成り立つことを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      displayMath(String.raw`S_m=
\begin{cases}
  0_{\mathbb{C}} & (m<j),\\
  \alpha_j & (m\ge j).
\end{cases}`),
      paragraph([
        math(String.raw`n\ge j`),
        " なので、",
        math(String.raw`m=n`),
        " の場合が主張 ",
        math(String.raw`S_n=\alpha_j`),
        " である。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき：",
        math(String.raw`j\ge 1`),
        " なので ",
        math(String.raw`0<j`),
        " であり、",
        math(String.raw`S_0=0_{\mathbb{C}}`),
        " は ",
        math(String.raw`S_0`),
        " の定義（",
        ref("def_ordered_sum_in_complex_numbers"),
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
S_m
&=S_{m-1}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ S_m\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}0_{\mathbb{C}})
&&\left(\because\ m\neq j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ \alpha\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=j`),
        " のとき：",
        math(String.raw`m-1<j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
S_m
&=S_{m-1}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ S_m\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}1_{\mathbb{C}})
&&\left(\because\ m=j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}\alpha_m
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right)\\
&=\alpha_m
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=\alpha_j
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
S_m
&=S_{m-1}+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ S_m\ \text{の定義。}\blkref{def_ordered_sum_in_complex_numbers}\right)\\
&=\alpha_j+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}\delta_{m,j})
&&\left(\because\ \text{帰納法の仮定。}\ m-1\ge j\right)\\
&=\alpha_j+_{\mathbb{C}}(\alpha_m\cdot_{\mathbb{C}}0_{\mathbb{C}})
&&\left(\because\ m\neq j\ \text{と}\ \blkref{def_kronecker_delta}\right)\\
&=\alpha_j+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ \mathbb{C}\ \text{の中で}\ \alpha\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=\alpha_j
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について帰納法の主張が示された。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_dual_basis_spans_dual_space",
    kind: "claim",
    title: { text: "双対基底は双対空間を線型結合で張る" },
    labels: ["claim_dual_basis_spans_dual_space"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        " をその双対空間（",
        ref("def_dual_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        " を ",
        math(String.raw`V`),
        " の基底（",
        ref("def_basis"),
        "）、",
        math(String.raw`f:\{1,\dots,n\}\to V^{*}`),
        " を基底 ",
        math(String.raw`b`),
        " の双対基底（",
        ref("def_dual_basis"),
        "）とする。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`b_k:=b(k)\in V`),
        "、",
        math(String.raw`f_k:=f(k)\in V^{*}`),
        " と書く。双対空間は ℂ-線型空間である（",
        ref("claim_dual_space_is_complex_vector_space"),
        "）ので、",
        math(String.raw`V^{*}`),
        " の中の線型結合（",
        ref("def_linear_combination"),
        "）が定まる。",
      ]),
      paragraph([
        "このとき、すべての ",
        math(String.raw`g\in V^{*}`),
        " について、",
        math(String.raw`V^{*}`),
        " の中の次の等式が成り立つ。",
      ]),
      displayMath(String.raw`g=\sum_{k=1}^{n}g(b_k)\cdot_{V^{*}}f_k`),
      paragraph([
        "右辺は、係数 ",
        math(String.raw`g(b_1),\dots,g(b_n)\in\mathbb{C}`),
        " と族 ",
        math(String.raw`f`),
        " による ",
        math(String.raw`V^{*}`),
        " の中の線型結合である。したがって族 ",
        math(String.raw`f`),
        " は ",
        math(String.raw`V^{*}`),
        " を線型結合で張る（",
        ref("def_spanning_family"),
        "）。この主張は、",
        math(String.raw`f`),
        " が一次独立であること（",
        math(String.raw`f`),
        " が ",
        math(String.raw`V^{*}`),
        " の基底であること）を主張しない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`g\in V^{*}`),
        " を任意に取り、",
        math(String.raw`V^{*}`),
        " の元 ",
        math(String.raw`h`),
        " を次で定める。",
      ]),
      displayMath(String.raw`h:=\sum_{k=1}^{n}g(b_k)\cdot_{V^{*}}f_k\in V^{*}`),
      paragraph([
        math(String.raw`h`),
        " は ",
        math(String.raw`V^{*}`),
        " の元なので、",
        math(String.raw`V`),
        " 上の線型形式（",
        ref("def_linear_form"),
        "）である（",
        ref("def_dual_space"),
        "）。示すべきことは ",
        math(String.raw`V^{*}`),
        " の等式 ",
        math(String.raw`h=g`),
        " であり、",
        math(String.raw`V^{*}`),
        " の元の等しさはすべての ",
        math(String.raw`x\in V`),
        " での値の等しさである（",
        ref("def_dual_space"),
        "）。",
      ]),
      paragraph([
        "まず、基底の元での値が一致することを示す。",
        math(String.raw`n\ge 1`),
        " のとき、",
        math(String.raw`j\in\{1,\dots,n\}`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
h(b_j)
&=\sum_{\mathbb{C},\,k=1}^{n}g(b_k)\cdot_{\mathbb{C}}f_k(b_j)
&&\left(\because\ \text{双対空間の元の線型結合の値（}x=b_j\text{）。}\blkref{claim_value_of_linear_combination_in_dual_space}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{n}g(b_k)\cdot_{\mathbb{C}}\delta_{k,j}
&&\left(\because\ \text{各}\ k\ \text{で双対基底の条件}\ f_k(b_j)=\delta_{k,j}\text{。}\blkref{def_dual_basis}\right)\\
&=g(b_j)
&&\left(\because\ \alpha_k:=g(b_k)\ \text{として、デルタを掛けた和は第}\ j\ \text{項。}\blkref{claim_ordered_sum_with_kronecker_delta_picks_term}\right).
\end{aligned}`),
      paragraph([
        "したがって、すべての ",
        math(String.raw`j\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`h(b_j)=g(b_j)`),
        " である。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合なので、この主張は空に成り立つ。",
      ]),
      paragraph([
        "次に、",
        math(String.raw`x\in V`),
        " を任意に取る。基底 ",
        math(String.raw`b`),
        " は ",
        math(String.raw`V`),
        " を線型結合で張る（",
        ref("def_basis"),
        "）ので、",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\mu_k`),
        " を一つずつ与える与え方であって ",
        math(String.raw`\sum_{k=1}^{n}\mu_k\cdot_V b_k=x`),
        " を満たすものが存在する（",
        ref("def_spanning_family"),
        "）。そのような与え方を一つ取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
h(x)
&=h\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)
&&\left(\because\ \mu_k\ \text{の取り方}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{n}\mu_k\cdot_{\mathbb{C}}h(b_k)
&&\left(\because\ h\ \text{は線型形式。}\blkref{claim_linear_form_maps_linear_combination_to_ordered_sum}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{n}\mu_k\cdot_{\mathbb{C}}g(b_k)
&&\left(\because\ \text{各}\ k\ \text{で上で示した}\ h(b_k)=g(b_k)\right)\\
&=g\left(\sum_{k=1}^{n}\mu_k\cdot_V b_k\right)
&&\left(\because\ g\ \text{は線型形式。}\blkref{claim_linear_form_maps_linear_combination_to_ordered_sum}\right)\\
&=g(x)
&&\left(\because\ \mu_k\ \text{の取り方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意だったので、",
        math(String.raw`V^{*}`),
        " の元として ",
        math(String.raw`h=g`),
        " である（",
        ref("def_dual_space"),
        "）。これは主張の等式 ",
        math(String.raw`g=\sum_{k=1}^{n}g(b_k)\cdot_{V^{*}}f_k`),
        " である。",
        math(String.raw`g`),
        " は任意だったので、",
        math(String.raw`V^{*}`),
        " の各元は族 ",
        math(String.raw`f`),
        " の線型結合で書け、",
        math(String.raw`f`),
        " は ",
        math(String.raw`V^{*}`),
        " を線型結合で張る（",
        ref("def_spanning_family"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_dual_basis_is_linearly_independent",
    kind: "claim",
    title: { text: "双対基底は一次独立である" },
    labels: ["claim_dual_basis_is_linearly_independent"],
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
        "）、",
        math(String.raw`f:\{1,\dots,n\}\to V^{*}`),
        " を ",
        math(String.raw`b`),
        " の双対基底（",
        ref("def_dual_basis"),
        "）とする。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`b_k:=b(k)\in V`),
        "、",
        math(String.raw`f_k:=f(k)\in V^{*}`),
        " と書く。このとき、",
        math(String.raw`f`),
        " は ℂ-線型空間 ",
        math(String.raw`(V^{*},+_{V^{*}},\cdot_{V^{*}},0_{V^{*}})`),
        "（",
        ref("def_dual_space"),
        "、",
        ref("claim_dual_space_is_complex_vector_space"),
        "）の元の番号付けた族として一次独立（",
        ref("def_linear_independence"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_k`),
        " が一つずつ与えられていて、",
        math(String.raw`V^{*}`),
        " の中の線型結合（",
        ref("def_linear_combination"),
        "）が ",
        math(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_{V^{*}}f_k=0_{V^{*}}`),
        " を満たすとする。",
        math(String.raw`j\in\{1,\dots,n\}`),
        " を任意に取る（このとき ",
        math(String.raw`n\ge 1`),
        " である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda_j
&=\sum_{\mathbb{C},\,k=1}^{n}\lambda_k\cdot_{\mathbb{C}}\delta_{k,j}
&&\left(\because\ \alpha_k:=\lambda_k\ \text{として、デルタを掛けた和は第}\ j\ \text{項。}\blkref{claim_ordered_sum_with_kronecker_delta_picks_term}\right)\\
&=\sum_{\mathbb{C},\,k=1}^{n}\lambda_k\cdot_{\mathbb{C}}f_k(b_j)
&&\left(\because\ \text{各}\ k\ \text{で双対基底の条件}\ f_k(b_j)=\delta_{k,j}\text{。}\blkref{def_dual_basis}\right)\\
&=\left(\sum_{k=1}^{n}\lambda_k\cdot_{V^{*}}f_k\right)(b_j)
&&\left(\because\ \text{双対空間の元の線型結合の値（}x=b_j\text{）。}\blkref{claim_value_of_linear_combination_in_dual_space}\right)\\
&=0_{V^{*}}(b_j)
&&\left(\because\ \lambda_k\ \text{についての仮定}\right)\\
&=z_V(b_j)
&&\left(\because\ 0_{V^{*}}:=z_V\text{。}\blkref{def_dual_space}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ z_V\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j`),
        " は任意だったので、すべての ",
        math(String.raw`j\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\lambda_j=0_{\mathbb{C}}`),
        " である（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合なので空に成り立つ）。したがって ",
        math(String.raw`f`),
        " は一次独立である（",
        ref("def_linear_independence"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_direct_sum_of_two_vector_spaces",
    kind: "definition",
    title: { text: "二つの ℂ-線型空間の直和" },
    labels: ["def_direct_sum_of_two_vector_spaces"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。",
        math(String.raw`V_1`),
        " の元 ",
        math(String.raw`x_1`),
        " と ",
        math(String.raw`V_2`),
        " の元 ",
        math(String.raw`x_2`),
        " の順序対 ",
        math(String.raw`(x_1,x_2)`),
        " 全体の集合（直積集合 ",
        math(String.raw`V_1\times V_2`),
        "）を ",
        math(String.raw`V_1\oplus V_2`),
        " と書く。写像 ",
        math(String.raw`+_{V_1\oplus V_2}:(V_1\oplus V_2)\times(V_1\oplus V_2)\to V_1\oplus V_2`),
        " と ",
        math(String.raw`\cdot_{V_1\oplus V_2}:\mathbb{C}\times(V_1\oplus V_2)\to V_1\oplus V_2`),
        "、元 ",
        math(String.raw`0_{V_1\oplus V_2}\in V_1\oplus V_2`),
        " を次で定める。以下、",
        math(String.raw`x_1,y_1`),
        " は ",
        math(String.raw`V_1`),
        " の任意の元、",
        math(String.raw`x_2,y_2`),
        " は ",
        math(String.raw`V_2`),
        " の任意の元、",
        math(String.raw`\mu`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [
          math(String.raw`(x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2):=(x_1+_{V_1}y_1,\ x_2+_{V_2}y_2)`),
          "（成分ごとの加法）",
        ],
        [
          math(String.raw`\mu\cdot_{V_1\oplus V_2}(x_1,x_2):=(\mu\cdot_{V_1}x_1,\ \mu\cdot_{V_2}x_2)`),
          "（成分ごとのスカラー倍）",
        ],
        [math(String.raw`0_{V_1\oplus V_2}:=(0_{V_1},0_{V_2})`), "（成分ごとの零）"],
      ]),
      paragraph([
        "右辺の順序対の第一成分は ",
        math(String.raw`V_1`),
        " の元、第二成分は ",
        math(String.raw`V_2`),
        " の元である。",
        math(String.raw`+_{V_1}`),
        " と ",
        math(String.raw`\cdot_{V_1}`),
        " の値は ",
        math(String.raw`V_1`),
        " に、",
        math(String.raw`+_{V_2}`),
        " と ",
        math(String.raw`\cdot_{V_2}`),
        " の値は ",
        math(String.raw`V_2`),
        " に入り、",
        math(String.raw`0_{V_1}\in V_1`),
        "、",
        math(String.raw`0_{V_2}\in V_2`),
        " だからである（",
        ref("def_complex_vector_space"),
        "）。これにより ",
        math(String.raw`+_{V_1\oplus V_2}`),
        " と ",
        math(String.raw`\cdot_{V_1\oplus V_2}`),
        " は値域を ",
        math(String.raw`V_1\oplus V_2`),
        " とする写像として定まり、",
        math(String.raw`0_{V_1\oplus V_2}`),
        " は ",
        math(String.raw`V_1\oplus V_2`),
        " の元として定まる。",
      ]),
      paragraph([
        "組 ",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " を ",
        math(String.raw`V_1`),
        " と ",
        math(String.raw`V_2`),
        " の直和と呼ぶ。",
        math(String.raw`V_1\oplus V_2`),
        " の二つの元 ",
        math(String.raw`(x_1,x_2)`),
        " と ",
        math(String.raw`(y_1,y_2)`),
        " が等しいとは、順序対として等しいこと、すなわち ",
        math(String.raw`V_1`),
        " の等式 ",
        math(String.raw`x_1=y_1`),
        " と ",
        math(String.raw`V_2`),
        " の等式 ",
        math(String.raw`x_2=y_2`),
        " がともに成り立つことである。",
      ]),
      paragraph([
        math(String.raw`V_1`),
        " と ",
        math(String.raw`V_2`),
        " は ",
        math(String.raw`V_1\oplus V_2`),
        " の部分集合ではない。",
        math(String.raw`V_1`),
        " の元や ",
        math(String.raw`V_2`),
        " の元から ",
        math(String.raw`V_1\oplus V_2`),
        " の元を作るときは、直和の成分への埋め込み写像に名前を付けて、その写像を通す（埋め込み写像はこの定義では定めない）。",
        "この組が ℂ-線型空間の公理（",
        ref("def_complex_vector_space"),
        "）を満たすことは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_direct_sum_of_two_vector_spaces_is_complex_vector_space",
    kind: "claim",
    title: { text: "二つの ℂ-線型空間の直和は ℂ-線型空間である" },
    labels: ["claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）とする。このとき組 ",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`V_1\oplus V_2`),
        " の元は順序対なので（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、その任意の三元を ",
        math(String.raw`(x_1,x_2),(y_1,y_2),(z_1,z_2)`),
        "（",
        math(String.raw`x_1,y_1,z_1\in V_1`),
        "、",
        math(String.raw`x_2,y_2,z_2\in V_2`),
        "）と書く。",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。",
      ]),
      paragraph([
        "ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。どの条件も ",
        math(String.raw`V_1\oplus V_2`),
        " の二つの元の等式であり、",
        math(String.raw`V_1\oplus V_2`),
        " の二つの元が等しいことは、第一成分どうしの ",
        math(String.raw`V_1`),
        " の等式と、第二成分どうしの ",
        math(String.raw`V_2`),
        " の等式がともに成り立つことである（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）。以下の式変形で「各成分に適用」と書いた行は、第一成分に ",
        math(String.raw`V_1`),
        " の公理、第二成分に ",
        math(String.raw`V_2`),
        " の同じ名前の公理を適用し、その二つの等式から順序対の等式を得る行である。",
      ]),
      paragraph(["加法の結合法則 ", math(String.raw`\bigl((x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)\bigr)+_{V_1\oplus V_2}(z_1,z_2)=(x_1,x_2)+_{V_1\oplus V_2}\bigl((y_1,y_2)+_{V_1\oplus V_2}(z_1,z_2)\bigr)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)\bigr)+_{V_1\oplus V_2}(z_1,z_2)
&=(x_1+_{V_1}y_1,\ x_2+_{V_2}y_2)+_{V_1\oplus V_2}(z_1,z_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl((x_1+_{V_1}y_1)+_{V_1}z_1,\ (x_2+_{V_2}y_2)+_{V_2}z_2\bigr)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(x_1+_{V_1}(y_1+_{V_1}z_1),\ x_2+_{V_2}(y_2+_{V_2}z_2)\bigr)
&&\left(\because\ \text{加法の結合法則を各成分に適用。}\blkref{def_complex_vector_space}\right)\\
&=(x_1,x_2)+_{V_1\oplus V_2}(y_1+_{V_1}z_1,\ y_2+_{V_2}z_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(x_1,x_2)+_{V_1\oplus V_2}\bigl((y_1,y_2)+_{V_1\oplus V_2}(z_1,z_2)\bigr)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph(["加法の交換法則 ", math(String.raw`(x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)=(y_1,y_2)+_{V_1\oplus V_2}(x_1,x_2)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)
&=(x_1+_{V_1}y_1,\ x_2+_{V_2}y_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(y_1+_{V_1}x_1,\ y_2+_{V_2}x_2)
&&\left(\because\ \text{加法の交換法則を各成分に適用。}\blkref{def_complex_vector_space}\right)\\
&=(y_1,y_2)+_{V_1\oplus V_2}(x_1,x_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph(["加法の単位元 ", math(String.raw`(x_1,x_2)+_{V_1\oplus V_2}0_{V_1\oplus V_2}=(x_1,x_2)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(x_1,x_2)+_{V_1\oplus V_2}0_{V_1\oplus V_2}
&=(x_1,x_2)+_{V_1\oplus V_2}(0_{V_1},0_{V_2})
&&\left(\because\ 0_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(x_1+_{V_1}0_{V_1},\ x_2+_{V_2}0_{V_2})
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(x_1,x_2)
&&\left(\because\ \text{加法の単位元を各成分に適用。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元は次のとおりである。",
        math(String.raw`V_1`),
        " の加法の逆元の条件（",
        ref("def_complex_vector_space"),
        "）により、",
        math(String.raw`x_1+_{V_1}x_1'=0_{V_1}`),
        " を満たす ",
        math(String.raw`x_1'\in V_1`),
        " を一つ選ぶ。同じく ",
        math(String.raw`V_2`),
        " の加法の逆元の条件により、",
        math(String.raw`x_2+_{V_2}x_2'=0_{V_2}`),
        " を満たす ",
        math(String.raw`x_2'\in V_2`),
        " を一つ選ぶ。このとき ",
        math(String.raw`(x_1',x_2')\in V_1\oplus V_2`),
        " は ",
        math(String.raw`(x_1,x_2)+_{V_1\oplus V_2}(x_1',x_2')=0_{V_1\oplus V_2}`),
        " を満たす。これは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x_1,x_2)+_{V_1\oplus V_2}(x_1',x_2')
&=(x_1+_{V_1}x_1',\ x_2+_{V_2}x_2')
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(0_{V_1},0_{V_2})
&&\left(\because\ x_1'\ \text{と}\ x_2'\ \text{の選び方を各成分に適用}\right)\\
&=0_{V_1\oplus V_2}
&&\left(\because\ 0_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則 ", math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V_1\oplus V_2}(x_1,x_2)=\lambda\cdot_{V_1\oplus V_2}\bigl(\mu\cdot_{V_1\oplus V_2}(x_1,x_2)\bigr)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V_1\oplus V_2}(x_1,x_2)
&=\bigl((\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V_1}x_1,\ (\lambda\cdot_{\mathbb{C}}\mu)\cdot_{V_2}x_2\bigr)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{V_1}(\mu\cdot_{V_1}x_1),\ \lambda\cdot_{V_2}(\mu\cdot_{V_2}x_2)\bigr)
&&\left(\because\ \text{スカラー倍の結合法則を各成分に適用。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}(\mu\cdot_{V_1}x_1,\ \mu\cdot_{V_2}x_2)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}\bigl(\mu\cdot_{V_1\oplus V_2}(x_1,x_2)\bigr)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元 ", math(String.raw`1_{\mathbb{C}}\cdot_{V_1\oplus V_2}(x_1,x_2)=(x_1,x_2)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot_{V_1\oplus V_2}(x_1,x_2)
&=(1_{\mathbb{C}}\cdot_{V_1}x_1,\ 1_{\mathbb{C}}\cdot_{V_2}x_2)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=(x_1,x_2)
&&\left(\because\ \text{スカラー倍の単位元を各成分に適用。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則 ", math(String.raw`\lambda\cdot_{V_1\oplus V_2}\bigl((x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)\bigr)=\lambda\cdot_{V_1\oplus V_2}(x_1,x_2)+_{V_1\oplus V_2}\lambda\cdot_{V_1\oplus V_2}(y_1,y_2)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\cdot_{V_1\oplus V_2}\bigl((x_1,x_2)+_{V_1\oplus V_2}(y_1,y_2)\bigr)
&=\lambda\cdot_{V_1\oplus V_2}(x_1+_{V_1}y_1,\ x_2+_{V_2}y_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{V_1}(x_1+_{V_1}y_1),\ \lambda\cdot_{V_2}(x_2+_{V_2}y_2)\bigr)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{V_1}x_1+_{V_1}\lambda\cdot_{V_1}y_1,\ \lambda\cdot_{V_2}x_2+_{V_2}\lambda\cdot_{V_2}y_2\bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則を各成分に適用。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\cdot_{V_1}x_1,\ \lambda\cdot_{V_2}x_2)+_{V_1\oplus V_2}(\lambda\cdot_{V_1}y_1,\ \lambda\cdot_{V_2}y_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}(x_1,x_2)+_{V_1\oplus V_2}\lambda\cdot_{V_1\oplus V_2}(y_1,y_2)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義を二か所に適用。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則 ", math(String.raw`(\lambda+_{\mathbb{C}}\mu)\cdot_{V_1\oplus V_2}(x_1,x_2)=\lambda\cdot_{V_1\oplus V_2}(x_1,x_2)+_{V_1\oplus V_2}\mu\cdot_{V_1\oplus V_2}(x_1,x_2)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda+_{\mathbb{C}}\mu)\cdot_{V_1\oplus V_2}(x_1,x_2)
&=\bigl((\lambda+_{\mathbb{C}}\mu)\cdot_{V_1}x_1,\ (\lambda+_{\mathbb{C}}\mu)\cdot_{V_2}x_2\bigr)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{V_1}x_1+_{V_1}\mu\cdot_{V_1}x_1,\ \lambda\cdot_{V_2}x_2+_{V_2}\mu\cdot_{V_2}x_2\bigr)
&&\left(\because\ \text{スカラーの加法についての分配法則を各成分に適用。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\cdot_{V_1}x_1,\ \lambda\cdot_{V_2}x_2)+_{V_1\oplus V_2}(\mu\cdot_{V_1}x_1,\ \mu\cdot_{V_2}x_2)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}(x_1,x_2)+_{V_1\oplus V_2}\mu\cdot_{V_1\oplus V_2}(x_1,x_2)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義を二か所に適用。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        "八つの条件が満たされたので、組 ",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_embedding_into_first_component_of_direct_sum",
    kind: "definition",
    title: { text: "直和の第一成分への埋め込み写像" },
    labels: ["def_embedding_into_first_component_of_direct_sum"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`V_1\oplus V_2`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）とする。写像 ",
        math(String.raw`\mathrm{in}_1:V_1\to V_1\oplus V_2`),
        " を次で定め、直和の第一成分への埋め込み写像と呼ぶ。",
      ]),
      displayMath(String.raw`\mathrm{in}_1(x):=(x,\ 0_{V_2})\qquad(x\in V_1)`),
      paragraph([
        "右辺の順序対の第一成分 ",
        math(String.raw`x`),
        " は ",
        math(String.raw`V_1`),
        " の元、第二成分 ",
        math(String.raw`0_{V_2}`),
        " は ",
        math(String.raw`V_2`),
        " の元である（",
        ref("def_complex_vector_space"),
        "）。したがって右辺は ",
        math(String.raw`V_1\oplus V_2`),
        " の元であり（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{in}_1`),
        " は値域を ",
        math(String.raw`V_1\oplus V_2`),
        " とする写像として定まる。",
      ]),
      paragraph([
        math(String.raw`V_1`),
        " の元 ",
        math(String.raw`x`),
        " と ",
        math(String.raw`V_1\oplus V_2`),
        " の元 ",
        math(String.raw`\mathrm{in}_1(x)`),
        " は別の集合の元であり、記号を使い回さない。",
        math(String.raw`V_1`),
        " の元から ",
        math(String.raw`V_1\oplus V_2`),
        " の元を作るときは、この写像 ",
        math(String.raw`\mathrm{in}_1`),
        " を通す。",
        math(String.raw`\mathrm{in}_1`),
        " が線型写像（",
        ref("def_linear_map"),
        "）であることは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_embedding_into_first_component_is_linear_map",
    kind: "claim",
    title: { text: "直和の第一成分への埋め込み写像は線型写像である" },
    labels: ["claim_embedding_into_first_component_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{in}_1:V_1\to V_1\oplus V_2`),
        " を直和の第一成分への埋め込み写像（",
        ref("def_embedding_into_first_component_of_direct_sum"),
        "）とする。直和は ℂ-線型空間である（",
        ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"),
        "）。このとき ",
        math(String.raw`\mathrm{in}_1`),
        " は ",
        math(String.raw`V_1`),
        " から ",
        math(String.raw`V_1\oplus V_2`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。すなわち、",
        math(String.raw`V_1`),
        " の任意の元 ",
        math(String.raw`x,y`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`\mathrm{in}_1(x+_{V_1}y)=\mathrm{in}_1(x)+_{V_1\oplus V_2}\mathrm{in}_1(y)`), "（加法を保つ）"],
        [math(String.raw`\mathrm{in}_1(\lambda\cdot_{V_1}x)=\lambda\cdot_{V_1\oplus V_2}\mathrm{in}_1(x)`), "（スカラー倍を保つ）"],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y`),
        " を ",
        math(String.raw`V_1`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。準備として、",
        math(String.raw`V_2`),
        " の中の等式 ",
        math(String.raw`\lambda\cdot_{V_2}0_{V_2}=0_{V_2}`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda\cdot_{V_2}0_{V_2}
&=\lambda\cdot_{V_2}(0_{\mathbb{C}}\cdot_{V_2}0_{V_2})
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}V=V_2,\ x=0_{V_2}\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=(\lambda\cdot_{\mathbb{C}}0_{\mathbb{C}})\cdot_{V_2}0_{V_2}
&&\left(\because\ V_2\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_{V_2}0_{V_2}
&&\left(\because\ \lambda\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}\right)\\
&=0_{V_2}
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}V=V_2,\ x=0_{V_2}\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph(["加法を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{in}_1(x+_{V_1}y)
&=(x+_{V_1}y,\ 0_{V_2})
&&\left(\because\ \mathrm{in}_1\ \text{の定義。}\blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=(x+_{V_1}y,\ 0_{V_2}+_{V_2}0_{V_2})
&&\left(\because\ V_2\ \text{の加法の単位元（}x=0_{V_2}\text{）。}\blkref{def_complex_vector_space}\right)\\
&=(x,\ 0_{V_2})+_{V_1\oplus V_2}(y,\ 0_{V_2})
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\mathrm{in}_1(x)+_{V_1\oplus V_2}\mathrm{in}_1(y)
&&\left(\because\ \mathrm{in}_1\ \text{の定義を二か所に適用。}\blkref{def_embedding_into_first_component_of_direct_sum}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{in}_1(\lambda\cdot_{V_1}x)
&=(\lambda\cdot_{V_1}x,\ 0_{V_2})
&&\left(\because\ \mathrm{in}_1\ \text{の定義。}\blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=(\lambda\cdot_{V_1}x,\ \lambda\cdot_{V_2}0_{V_2})
&&\left(\because\ \text{準備の等式}\ \lambda\cdot_{V_2}0_{V_2}=0_{V_2}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}(x,\ 0_{V_2})
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}\mathrm{in}_1(x)
&&\left(\because\ \mathrm{in}_1\ \text{の定義。}\blkref{def_embedding_into_first_component_of_direct_sum}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`\mathrm{in}_1`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_embedding_into_second_component_of_direct_sum",
    kind: "definition",
    title: { text: "直和の第二成分への埋め込み写像" },
    labels: ["def_embedding_into_second_component_of_direct_sum"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`V_1\oplus V_2`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）とする。写像 ",
        math(String.raw`\mathrm{in}_2:V_2\to V_1\oplus V_2`),
        " を次で定め、直和の第二成分への埋め込み写像と呼ぶ。",
      ]),
      displayMath(String.raw`\mathrm{in}_2(y):=(0_{V_1},\ y)\qquad(y\in V_2)`),
      paragraph([
        "右辺の順序対の第一成分 ",
        math(String.raw`0_{V_1}`),
        " は ",
        math(String.raw`V_1`),
        " の元、第二成分 ",
        math(String.raw`y`),
        " は ",
        math(String.raw`V_2`),
        " の元である（",
        ref("def_complex_vector_space"),
        "）。したがって右辺は ",
        math(String.raw`V_1\oplus V_2`),
        " の元であり（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{in}_2`),
        " は値域を ",
        math(String.raw`V_1\oplus V_2`),
        " とする写像として定まる。",
      ]),
      paragraph([
        math(String.raw`V_2`),
        " の元 ",
        math(String.raw`y`),
        " と ",
        math(String.raw`V_1\oplus V_2`),
        " の元 ",
        math(String.raw`\mathrm{in}_2(y)`),
        " は別の集合の元であり、記号を使い回さない。",
        math(String.raw`V_2`),
        " の元から ",
        math(String.raw`V_1\oplus V_2`),
        " の元を作るときは、この写像 ",
        math(String.raw`\mathrm{in}_2`),
        " を通す。",
        math(String.raw`\mathrm{in}_2`),
        " が線型写像（",
        ref("def_linear_map"),
        "）であることは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_embedding_into_second_component_is_linear_map",
    kind: "claim",
    title: { text: "直和の第二成分への埋め込み写像は線型写像である" },
    labels: ["claim_embedding_into_second_component_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{in}_2:V_2\to V_1\oplus V_2`),
        " を直和の第二成分への埋め込み写像（",
        ref("def_embedding_into_second_component_of_direct_sum"),
        "）とする。直和は ℂ-線型空間である（",
        ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"),
        "）。このとき ",
        math(String.raw`\mathrm{in}_2`),
        " は ",
        math(String.raw`V_2`),
        " から ",
        math(String.raw`V_1\oplus V_2`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。すなわち、",
        math(String.raw`V_2`),
        " の任意の元 ",
        math(String.raw`y,z`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`\mathrm{in}_2(y+_{V_2}z)=\mathrm{in}_2(y)+_{V_1\oplus V_2}\mathrm{in}_2(z)`), "（加法を保つ）"],
        [math(String.raw`\mathrm{in}_2(\lambda\cdot_{V_2}y)=\lambda\cdot_{V_1\oplus V_2}\mathrm{in}_2(y)`), "（スカラー倍を保つ）"],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y,z`),
        " を ",
        math(String.raw`V_2`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{in}_2(y+_{V_2}z)
&=(0_{V_1},\ y+_{V_2}z)
&&\left(\because\ \mathrm{in}_2\ \text{の定義。}\blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=(0_{V_1}+_{V_1}0_{V_1},\ y+_{V_2}z)
&&\left(\because\ V_1\ \text{の加法の単位元（}x=0_{V_1}\text{）。}\blkref{def_complex_vector_space}\right)\\
&=(0_{V_1},\ y)+_{V_1\oplus V_2}(0_{V_1},\ z)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\mathrm{in}_2(y)+_{V_1\oplus V_2}\mathrm{in}_2(z)
&&\left(\because\ \mathrm{in}_2\ \text{の定義を二か所に適用。}\blkref{def_embedding_into_second_component_of_direct_sum}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{in}_2(\lambda\cdot_{V_2}y)
&=(0_{V_1},\ \lambda\cdot_{V_2}y)
&&\left(\because\ \mathrm{in}_2\ \text{の定義。}\blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=(\lambda\cdot_{V_1}0_{V_1},\ \lambda\cdot_{V_2}y)
&&\left(\because\ \text{零ベクトルのスカラー倍は零ベクトル（}V=V_1\text{）。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}(0_{V_1},\ y)
&&\left(\because\ \cdot_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\lambda\cdot_{V_1\oplus V_2}\mathrm{in}_2(y)
&&\left(\because\ \mathrm{in}_2\ \text{の定義。}\blkref{def_embedding_into_second_component_of_direct_sum}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`\mathrm{in}_2`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_direct_sum_element_is_sum_of_embedded_components",
    kind: "claim",
    title: { text: "直和の元は二つの埋め込み写像の像の和である" },
    labels: ["claim_direct_sum_element_is_sum_of_embedded_components"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{in}_1:V_1\to V_1\oplus V_2`),
        " を直和の第一成分への埋め込み写像（",
        ref("def_embedding_into_first_component_of_direct_sum"),
        "）、",
        math(String.raw`\mathrm{in}_2:V_2\to V_1\oplus V_2`),
        " を直和の第二成分への埋め込み写像（",
        ref("def_embedding_into_second_component_of_direct_sum"),
        "）とする。このとき ",
        math(String.raw`V_1`),
        " の任意の元 ",
        math(String.raw`x`),
        " と ",
        math(String.raw`V_2`),
        " の任意の元 ",
        math(String.raw`y`),
        " について、",
        math(String.raw`V_1\oplus V_2`),
        " の中で次の等式が成り立つ。",
      ]),
      displayMath(String.raw`(x,\ y)=\mathrm{in}_1(x)+_{V_1\oplus V_2}\mathrm{in}_2(y)`),
    ],
    proof: [
      paragraph([
        math(String.raw`x`),
        " を ",
        math(String.raw`V_1`),
        " の任意の元、",
        math(String.raw`y`),
        " を ",
        math(String.raw`V_2`),
        " の任意の元とする。",
        math(String.raw`V_1\oplus V_2`),
        " の元の等しさは成分ごとの等しさなので（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、第一成分を書き換える行では ",
        math(String.raw`V_1`),
        " の公理を、第二成分を書き換える行では ",
        math(String.raw`V_2`),
        " の公理を当てる。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x,\ y)
&=(x+_{V_1}0_{V_1},\ y)
&&\left(\because\ V_1\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=(x+_{V_1}0_{V_1},\ y+_{V_2}0_{V_2})
&&\left(\because\ V_2\ \text{の加法の単位元（}x=y\text{）。}\blkref{def_complex_vector_space}\right)\\
&=(x+_{V_1}0_{V_1},\ 0_{V_2}+_{V_2}y)
&&\left(\because\ V_2\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=(x,\ 0_{V_2})+_{V_1\oplus V_2}(0_{V_1},\ y)
&&\left(\because\ +_{V_1\oplus V_2}\ \text{の定義。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\mathrm{in}_1(x)+_{V_1\oplus V_2}(0_{V_1},\ y)
&&\left(\because\ \mathrm{in}_1\ \text{の定義。}\blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=\mathrm{in}_1(x)+_{V_1\oplus V_2}\mathrm{in}_2(y)
&&\left(\because\ \mathrm{in}_2\ \text{の定義。}\blkref{def_embedding_into_second_component_of_direct_sum}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_definition_complex_numbers_as_complex_vector_space",
    kind: "definition",
    title: { text: "ℂ に ℂ-線型空間の構造を与える組" },
    labels: ["def_complex_numbers_as_complex_vector_space"],
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`+_{\mathbb{C}^{\mathrm{vec}}}:\mathbb{C}\times\mathbb{C}\to\mathbb{C}`),
        " と ",
        math(String.raw`\cdot_{\mathbb{C}^{\mathrm{vec}}}:\mathbb{C}\times\mathbb{C}\to\mathbb{C}`),
        "、元 ",
        math(String.raw`0_{\mathbb{C}^{\mathrm{vec}}}\in\mathbb{C}`),
        " を次で定める。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元で、ベクトルの側に置くもの、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元で、スカラーの側に置くものを表す。",
        math(String.raw`+_{\mathbb{C}},\ \cdot_{\mathbb{C}},\ 0_{\mathbb{C}}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の加法・乗法・加法の単位元である（",
        ref("def_complex_vector_space"),
        " の冒頭の記号）。",
      ]),
      list([
        [math(String.raw`x+_{\mathbb{C}^{\mathrm{vec}}}y:=x+_{\mathbb{C}}y`)],
        [math(String.raw`\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x:=\lambda\cdot_{\mathbb{C}}x`)],
        [math(String.raw`0_{\mathbb{C}^{\mathrm{vec}}}:=0_{\mathbb{C}}`)],
      ]),
      paragraph([
        "右辺はどれも ",
        math(String.raw`\mathbb{C}`),
        " の加法・乗法・加法の単位元で、値は ",
        math(String.raw`\mathbb{C}`),
        " に入る。これにより ",
        math(String.raw`+_{\mathbb{C}^{\mathrm{vec}}}`),
        " と ",
        math(String.raw`\cdot_{\mathbb{C}^{\mathrm{vec}}}`),
        " は値域を ",
        math(String.raw`\mathbb{C}`),
        " とする写像として定まり、",
        math(String.raw`0_{\mathbb{C}^{\mathrm{vec}}}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の元として定まる。",
      ]),
      paragraph([
        "組 ",
        math(String.raw`(\mathbb{C},+_{\mathbb{C}^{\mathrm{vec}}},\cdot_{\mathbb{C}^{\mathrm{vec}}},0_{\mathbb{C}^{\mathrm{vec}}})`),
        " を ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " と書く。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の元とは ",
        math(String.raw`\mathbb{C}`),
        " の元のことであり、二つの元が等しいとは ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことである。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）の定義の ",
        math(String.raw`V`),
        " に当てるときは、",
        math(String.raw`+_V,\ \cdot_V,\ 0_V`),
        " を ",
        math(String.raw`+_{\mathbb{C}^{\mathrm{vec}}},\ \cdot_{\mathbb{C}^{\mathrm{vec}}},\ 0_{\mathbb{C}^{\mathrm{vec}}}`),
        " と書く。",
        math(String.raw`\mathbb{C}`),
        " の乗法 ",
        math(String.raw`\cdot_{\mathbb{C}}`),
        " とスカラー倍 ",
        math(String.raw`\cdot_{\mathbb{C}^{\mathrm{vec}}}`),
        " は値が等しい写像だが、",
        math(String.raw`\mathbb{C}`),
        " の環としての演算と ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の線型空間としての演算のどちらを使った行かを式に残すため、記号の添字で区別し、行き来には上の三つの定義だけを通す。",
        "この組が ℂ-線型空間の公理（",
        ref("def_complex_vector_space"),
        "）を満たすことは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_complex_numbers_as_vector_space_is_complex_vector_space",
    kind: "claim",
    title: { text: "ℂ に ℂ-線型空間の構造を与える組は ℂ-線型空間である" },
    labels: ["claim_complex_numbers_as_vector_space_is_complex_vector_space"],
    statement: [
      paragraph([
        "組 ",
        math(String.raw`(\mathbb{C},+_{\mathbb{C}^{\mathrm{vec}}},\cdot_{\mathbb{C}^{\mathrm{vec}}},0_{\mathbb{C}^{\mathrm{vec}}})`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "）は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y,z`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元でベクトルの側に置くもの、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元でスカラーの側に置くものとする。",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        " の元の等しさは ",
        math(String.raw`\mathbb{C}`),
        " の元としての等しさなので（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "）、以下の各式変形は ",
        math(String.raw`\mathbb{C}`),
        " の中の等式の連なりである。ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。",
      ]),
      paragraph(["加法の結合法則 ", math(String.raw`(x+_{\mathbb{C}^{\mathrm{vec}}}y)+_{\mathbb{C}^{\mathrm{vec}}}z=x+_{\mathbb{C}^{\mathrm{vec}}}(y+_{\mathbb{C}^{\mathrm{vec}}}z)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(x+_{\mathbb{C}^{\mathrm{vec}}}y)+_{\mathbb{C}^{\mathrm{vec}}}z
&=(x+_{\mathbb{C}^{\mathrm{vec}}}y)+_{\mathbb{C}}z
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(x+_{\mathbb{C}}y)+_{\mathbb{C}}z
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=x+_{\mathbb{C}}(y+_{\mathbb{C}}z)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=x+_{\mathbb{C}}(y+_{\mathbb{C}^{\mathrm{vec}}}z)
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=x+_{\mathbb{C}^{\mathrm{vec}}}(y+_{\mathbb{C}^{\mathrm{vec}}}z)
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["加法の交換法則 ", math(String.raw`x+_{\mathbb{C}^{\mathrm{vec}}}y=y+_{\mathbb{C}^{\mathrm{vec}}}x`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
x+_{\mathbb{C}^{\mathrm{vec}}}y
&=x+_{\mathbb{C}}y
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=y+_{\mathbb{C}}x
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=y+_{\mathbb{C}^{\mathrm{vec}}}x
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["加法の単位元 ", math(String.raw`x+_{\mathbb{C}^{\mathrm{vec}}}0_{\mathbb{C}^{\mathrm{vec}}}=x`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
x+_{\mathbb{C}^{\mathrm{vec}}}0_{\mathbb{C}^{\mathrm{vec}}}
&=x+_{\mathbb{C}}0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=x+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=x
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元は、",
        math(String.raw`x`),
        " に対して、",
        math(String.raw`x+_{\mathbb{C}}x'=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`x'`),
        "（",
        math(String.raw`x`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の加法の逆元）を一つ選べば、",
        math(String.raw`x+_{\mathbb{C}^{\mathrm{vec}}}x'=0_{\mathbb{C}^{\mathrm{vec}}}`),
        " を満たす。これは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
x+_{\mathbb{C}^{\mathrm{vec}}}x'
&=x+_{\mathbb{C}}x'
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ x'\ \text{の選び方}\right)\\
&=0_{\mathbb{C}^{\mathrm{vec}}}
&&\left(\because\ 0_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則 ", math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^{\mathrm{vec}}}x=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}(\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x)`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^{\mathrm{vec}}}x
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}x
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}x)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}(\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元 ", math(String.raw`1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}x=x`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot_{\mathbb{C}^{\mathrm{vec}}}x
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}x
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=x
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則 ", math(String.raw`\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}(x+_{\mathbb{C}^{\mathrm{vec}}}y)=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x+_{\mathbb{C}^{\mathrm{vec}}}\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}y`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}(x+_{\mathbb{C}^{\mathrm{vec}}}y)
&=\lambda\cdot_{\mathbb{C}}(x+_{\mathbb{C}^{\mathrm{vec}}}y)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}}(x+_{\mathbb{C}}y)
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(\lambda\cdot_{\mathbb{C}}x)+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}y)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x)+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}y)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義を二か所に適用。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x+_{\mathbb{C}^{\mathrm{vec}}}\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}y
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則 ", math(String.raw`(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^{\mathrm{vec}}}x=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x+_{\mathbb{C}^{\mathrm{vec}}}\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x`), " は次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^{\mathrm{vec}}}x
&=(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}x
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=(\lambda\cdot_{\mathbb{C}}x)+_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}x)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x)+_{\mathbb{C}}(\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x)
&&\left(\because\ \cdot_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義を二か所に適用。}\blkref{def_complex_numbers_as_complex_vector_space}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}x+_{\mathbb{C}^{\mathrm{vec}}}\mu\cdot_{\mathbb{C}^{\mathrm{vec}}}x
&&\left(\because\ +_{\mathbb{C}^{\mathrm{vec}}}\ \text{の定義。}\blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "八つの条件が満たされたので、組 ",
        math(String.raw`(\mathbb{C},+_{\mathbb{C}^{\mathrm{vec}}},\cdot_{\mathbb{C}^{\mathrm{vec}}},0_{\mathbb{C}^{\mathrm{vec}}})`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_finite_set_sum_heading",
    kind: "heading",
    level: 2,
    title: { text: "有限集合の上の和" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_numbering_of_finite_set",
    kind: "definition",
    title: { text: "有限集合の番号付け" },
    labels: ["def_numbering_of_finite_set"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を集合、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        " を写像とする（",
        math(String.raw`n=0`),
        " のとき ",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合で、",
        math(String.raw`e`),
        " は空集合からの写像である）。",
        math(String.raw`e`),
        " が次の二つをともに満たすとき、組 ",
        math(String.raw`(n,e)`),
        " を ",
        math(String.raw`X`),
        " の番号付けと呼ぶ。",
      ]),
      list([
        [
          "（単射）",
          math(String.raw`k,l\in\{1,\dots,n\}`),
          " について、",
          math(String.raw`e(k)=e(l)`),
          " ならば ",
          math(String.raw`k=l`),
          "。",
        ],
        [
          "（全射）",
          math(String.raw`X`),
          " の各元 ",
          math(String.raw`x`),
          " について、",
          math(String.raw`e(k)=x`),
          " を満たす ",
          math(String.raw`k\in\{1,\dots,n\}`),
          " がある。",
        ],
      ]),
      paragraph([
        math(String.raw`X`),
        " が番号付けを少なくとも一つもつとき、",
        math(String.raw`X`),
        " を有限集合と呼ぶ。",
      ]),
      paragraph([
        math(String.raw`(n,e)`),
        " を ",
        math(String.raw`X`),
        " の番号付けとする。",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " について、",
        math(String.raw`e(k)=x`),
        " を満たす ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " は、全射の条件によって少なくとも一つあり、単射の条件によって高々一つである。この ",
        math(String.raw`k`),
        " を ",
        math(String.raw`e^{-1}(x)`),
        " と書き、写像 ",
        math(String.raw`e^{-1}:X\to\{1,\dots,n\}`),
        " を ",
        math(String.raw`e`),
        " の逆写像と呼ぶ。",
        math(String.raw`e^{-1}`),
        " の定義から、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`e(e^{-1}(x))=x`),
        " が成り立つ。また ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`k`),
        " は ",
        math(String.raw`e(k)=e(k)`),
        " を満たすので、",
        math(String.raw`e(k)`),
        " に対してただ一つに決まる番号であり、",
        math(String.raw`e^{-1}(e(k))=k`),
        " が成り立つ。",
      ]),
      paragraph([
        "番号付けは ",
        math(String.raw`X`),
        " の各元に番号 ",
        math(String.raw`1,\dots,n`),
        " を一つずつ割り当てるものであり、",
        math(String.raw`X`),
        " の上の順序や演算は使わない。",
        math(String.raw`X`),
        " の元と番号の行き来は、",
        math(String.raw`e`),
        " と ",
        math(String.raw`e^{-1}`),
        " の二つの写像だけを通す。",
        "一つの有限集合には一般に複数の番号付けがある。",
        "二つの番号付けの ",
        math(String.raw`n`),
        " が等しいこと、および番号付けを使って定める量が番号付けの取り方によらないことは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_moving_term_of_linear_combination_to_last",
    kind: "claim",
    title: { text: "線型結合の第 j 項を最後へ移しても値は変わらない" },
    labels: ["claim_moving_term_of_linear_combination_to_last"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
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
        " が一つずつ与えられているとする。",
        math(String.raw`j\in\{1,\dots,n\}`),
        " とし、写像 ",
        math(String.raw`\rho_j:\{1,\dots,n-1\}\to\{1,\dots,n\}`),
        " を次で定める（",
        math(String.raw`n=1`),
        " のとき ",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合で、",
        math(String.raw`\rho_j`),
        " は空集合からの写像である）。",
      ]),
      displayMath(String.raw`\rho_j(k):=
\begin{cases}
  k & (k<j),\\
  k+1 & (k\ge j).
\end{cases}`),
      paragraph([
        "値が ",
        math(String.raw`\{1,\dots,n\}`),
        " に入るのは、",
        math(String.raw`k<j`),
        " なら ",
        math(String.raw`1\le k<j\le n`),
        "、",
        math(String.raw`k\ge j`),
        " なら ",
        math(String.raw`2\le j+1\le k+1\le (n-1)+1=n`),
        " だからである。",
        math(String.raw`k\in\{1,\dots,n-1\}`),
        " について ",
        math(String.raw`\tilde{x}_k:=x_{\rho_j(k)}\in V`),
        "、",
        math(String.raw`\tilde{\lambda}_k:=\lambda_{\rho_j(k)}\in\mathbb{C}`),
        " と置く（第 ",
        math(String.raw`j`),
        " 項を除き、残りを番号の順のまま詰めた族と係数）。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\lambda_k\cdot_V x_k
=\Bigl(\sum_{k=1}^{n-1}\tilde{\lambda}_k\cdot_V\tilde{x}_k\Bigr)+_V(\lambda_j\cdot_V x_j)`),
    ],
    proof: [
      paragraph([
        "係数 ",
        math(String.raw`\lambda_1,\dots,\lambda_n`),
        " と ",
        math(String.raw`x_1,\dots,x_n`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元を ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）と書き、係数 ",
        math(String.raw`\tilde{\lambda}_1,\dots,\tilde{\lambda}_{n-1}`),
        " と ",
        math(String.raw`\tilde{x}_1,\dots,\tilde{x}_{n-1}`),
        " について同じ定義が定める ",
        math(String.raw`V`),
        " の元を ",
        math(String.raw`\tilde{L}_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n-1\}`),
        "）と書く。すなわち ",
        math(String.raw`L_0:=0_V`),
        "、",
        math(String.raw`L_m:=L_{m-1}+_V(\lambda_m\cdot_V x_m)`),
        "（",
        math(String.raw`1\le m\le n`),
        "）、",
        math(String.raw`\tilde{L}_0:=0_V`),
        "、",
        math(String.raw`\tilde{L}_m:=\tilde{L}_{m-1}+_V(\tilde{\lambda}_m\cdot_V\tilde{x}_m)`),
        "（",
        math(String.raw`1\le m\le n-1`),
        "）であり、主張の左辺は ",
        math(String.raw`L_n`),
        "、右辺は ",
        math(String.raw`\tilde{L}_{n-1}+_V(\lambda_j\cdot_V x_j)`),
        " である。",
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について次が成り立つことを、",
        math(String.raw`m`),
        " についての帰納法で示す（",
        math(String.raw`m<j`),
        " なら ",
        math(String.raw`m\le j-1\le n-1`),
        "、",
        math(String.raw`m\ge j`),
        " なら ",
        math(String.raw`0\le j-1\le m-1\le n-1`),
        " なので、右辺の ",
        math(String.raw`\tilde{L}`),
        " の添字は ",
        math(String.raw`\{0,1,\dots,n-1\}`),
        " に入る）。",
      ]),
      displayMath(String.raw`L_m=
\begin{cases}
  \tilde{L}_m & (m<j),\\
  \tilde{L}_{m-1}+_V(\lambda_j\cdot_V x_j) & (m\ge j).
\end{cases}`),
      paragraph([
        math(String.raw`n\ge j`),
        " なので、",
        math(String.raw`m=n`),
        " の場合が主張 ",
        math(String.raw`L_n=\tilde{L}_{n-1}+_V(\lambda_j\cdot_V x_j)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき：",
        math(String.raw`j\ge 1`),
        " なので ",
        math(String.raw`0<j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_0
&=0_V
&&\left(\because\ L_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\tilde{L}_0
&&\left(\because\ \tilde{L}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
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
        " である。また ",
        math(String.raw`1\le m\le j-1\le n-1`),
        " なので ",
        math(String.raw`m\in\{1,\dots,n-1\}`),
        " であり、",
        math(String.raw`m<j`),
        " から ",
        math(String.raw`\rho_j(m)=m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\tilde{L}_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=\tilde{L}_{m-1}+_V(\lambda_{\rho_j(m)}\cdot_V x_{\rho_j(m)})
&&\left(\because\ \rho_j(m)=m\right)\\
&=\tilde{L}_{m-1}+_V(\tilde{\lambda}_m\cdot_V\tilde{x}_m)
&&\left(\because\ \tilde{\lambda}_m,\ \tilde{x}_m\ \text{の定義}\right)\\
&=\tilde{L}_m
&&\left(\because\ \tilde{L}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=j`),
        " のとき：",
        math(String.raw`m-1<j`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\tilde{L}_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1<j\right)\\
&=\tilde{L}_{m-1}+_V(\lambda_j\cdot_V x_j)
&&\left(\because\ m=j\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m>j`),
        " のとき：",
        math(String.raw`m-1\ge j`),
        " である。また ",
        math(String.raw`1\le j\le m-1\le n-1`),
        " なので ",
        math(String.raw`m-1\in\{1,\dots,n-1\}`),
        " であり、",
        math(String.raw`m-1\ge j`),
        " から ",
        math(String.raw`\rho_j(m-1)=(m-1)+1=m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m
&=L_{m-1}+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\bigl(\tilde{L}_{m-2}+_V(\lambda_j\cdot_V x_j)\bigr)+_V(\lambda_m\cdot_V x_m)
&&\left(\because\ \text{帰納法の仮定。}\ m-1\ge j\right)\\
&=\tilde{L}_{m-2}+_V\bigl((\lambda_j\cdot_V x_j)+_V(\lambda_m\cdot_V x_m)\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\tilde{L}_{m-2}+_V\bigl((\lambda_m\cdot_V x_m)+_V(\lambda_j\cdot_V x_j)\bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(\tilde{L}_{m-2}+_V(\lambda_m\cdot_V x_m)\bigr)+_V(\lambda_j\cdot_V x_j)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(\tilde{L}_{m-2}+_V(\lambda_{\rho_j(m-1)}\cdot_V x_{\rho_j(m-1)})\bigr)+_V(\lambda_j\cdot_V x_j)
&&\left(\because\ \rho_j(m-1)=m\right)\\
&=\bigl(\tilde{L}_{m-2}+_V(\tilde{\lambda}_{m-1}\cdot_V\tilde{x}_{m-1})\bigr)+_V(\lambda_j\cdot_V x_j)
&&\left(\because\ \tilde{\lambda}_{m-1},\ \tilde{x}_{m-1}\ \text{の定義}\right)\\
&=\tilde{L}_{m-1}+_V(\lambda_j\cdot_V x_j)
&&\left(\because\ \tilde{L}_{m-1}\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "二行目の帰納法の仮定は、",
        math(String.raw`m-1\ge j`),
        " の場合の等式 ",
        math(String.raw`L_{m-1}=\tilde{L}_{(m-1)-1}+_V(\lambda_j\cdot_V x_j)`),
        " である。",
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について帰納法の主張が示された。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_reindexing_linear_combination_by_bijection",
    kind: "claim",
    title: { text: "番号を全単射で付け替えても線型結合は変わらない" },
    labels: ["claim_reindexing_linear_combination_by_bijection"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`n,n'\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`\{1,\dots,n'\}`),
        " の各元 ",
        math(String.raw`i`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`y_i`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\mu_i`),
        " が一つずつ与えられているとする。写像 ",
        math(String.raw`\sigma:\{1,\dots,n\}\to\{1,\dots,n'\}`),
        " について、組 ",
        math(String.raw`(n,\sigma)`),
        " が集合 ",
        math(String.raw`\{1,\dots,n'\}`),
        " の番号付け（",
        ref("def_numbering_of_finite_set"),
        "）であるとする（すなわち ",
        math(String.raw`\sigma`),
        " は単射かつ全射である）。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n}\mu_{\sigma(k)}\cdot_V y_{\sigma(k)}
=\sum_{i=1}^{n'}\mu_i\cdot_V y_i`),
      paragraph([
        "左辺は、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " に ",
        math(String.raw`y_{\sigma(k)}\in V`),
        " と ",
        math(String.raw`\mu_{\sigma(k)}\in\mathbb{C}`),
        " を与える族の線型結合である。",
        math(String.raw`n=n'`),
        " であることは仮定せず、主張もしない。",
      ]),
    ],
    proof: [
      paragraph([
        "次の命題 ",
        math(String.raw`Q(n)`),
        " がすべての ",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について成り立つことを、",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`Q(n)`),
        " の場合が主張である。",
      ]),
      list([
        [
          math(String.raw`Q(n)`),
          "：すべての ",
          math(String.raw`n'\in\mathbb{Z}_{\ge 0}`),
          "、",
          math(String.raw`\{1,\dots,n'\}`),
          " で添字づけたすべての ",
          math(String.raw`V`),
          " の元の族 ",
          math(String.raw`y`),
          " と ",
          math(String.raw`\mathbb{C}`),
          " の元の族 ",
          math(String.raw`\mu`),
          "、",
          math(String.raw`(n,\sigma)`),
          " が ",
          math(String.raw`\{1,\dots,n'\}`),
          " の番号付けであるすべての写像 ",
          math(String.raw`\sigma:\{1,\dots,n\}\to\{1,\dots,n'\}`),
          " について、主張の等式が成り立つ。",
        ],
      ]),
      paragraph([
        math(String.raw`n=0`),
        " のとき：",
        math(String.raw`n'\ge 1`),
        " と仮定すると、",
        math(String.raw`1\in\{1,\dots,n'\}`),
        " であり、番号付けの全射の条件（",
        ref("def_numbering_of_finite_set"),
        "）から ",
        math(String.raw`\sigma(k)=1`),
        " を満たす ",
        math(String.raw`k\in\{1,\dots,0\}`),
        " がある。",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合なのでこれは起こらない。したがって ",
        math(String.raw`n'=0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{0}\mu_{\sigma(k)}\cdot_V y_{\sigma(k)}
&=0_V
&&\left(\because\ \text{線型結合の}\ L_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{i=1}^{0}\mu_i\cdot_V y_i
&&\left(\because\ n'=0\ \text{と、線型結合の}\ L_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`n\ge 1`),
        " とし、",
        math(String.raw`Q(n-1)`),
        " が成り立つと仮定する（帰納法の仮定）。",
        math(String.raw`n'`),
        "、",
        math(String.raw`y`),
        "、",
        math(String.raw`\mu`),
        "、",
        math(String.raw`\sigma`),
        " を ",
        math(String.raw`Q(n)`),
        " のとおりにとる。まず次の準備をする。",
      ]),
      list([
        [
          "（",
          math(String.raw`n'\ge 1`),
          "）",
          math(String.raw`n\ge 1`),
          " なので ",
          math(String.raw`1\in\{1,\dots,n\}`),
          " であり、",
          math(String.raw`\sigma(1)\in\{1,\dots,n'\}`),
          " から ",
          math(String.raw`1\le\sigma(1)\le n'`),
          " である。",
        ],
        [
          "（",
          math(String.raw`j`),
          " の定義）",
          math(String.raw`n'\in\{1,\dots,n'\}`),
          " なので、",
          math(String.raw`j:=\sigma^{-1}(n')\in\{1,\dots,n\}`),
          " と置く（",
          math(String.raw`\sigma^{-1}`),
          " は番号付け ",
          math(String.raw`(n,\sigma)`),
          " の逆写像。",
          ref("def_numbering_of_finite_set"),
          "）。同じ定義から ",
          math(String.raw`\sigma(j)=\sigma(\sigma^{-1}(n'))=n'`),
          " である。",
          math(String.raw`\rho_j:\{1,\dots,n-1\}\to\{1,\dots,n\}`),
          " を、第 ",
          math(String.raw`j`),
          " 項を最後へ移す主張（",
          ref("claim_moving_term_of_linear_combination_to_last"),
          "）の写像とする。",
        ],
        [
          "（",
          math(String.raw`\rho_j`),
          " は値 ",
          math(String.raw`j`),
          " をとらない）",
          math(String.raw`k\in\{1,\dots,n-1\}`),
          " について、",
          math(String.raw`k<j`),
          " なら ",
          math(String.raw`\rho_j(k)=k<j`),
          "、",
          math(String.raw`k\ge j`),
          " なら ",
          math(String.raw`\rho_j(k)=k+1>j`),
          " なので、",
          math(String.raw`\rho_j(k)\ne j`),
          " である。",
        ],
        [
          "（",
          math(String.raw`\rho_j`),
          " は単射）",
          math(String.raw`k,l\in\{1,\dots,n-1\}`),
          " が ",
          math(String.raw`\rho_j(k)=\rho_j(l)`),
          " を満たすとする。",
          math(String.raw`k<j`),
          " かつ ",
          math(String.raw`l<j`),
          " なら ",
          math(String.raw`k=\rho_j(k)=\rho_j(l)=l`),
          "。",
          math(String.raw`k\ge j`),
          " かつ ",
          math(String.raw`l\ge j`),
          " なら ",
          math(String.raw`k+1=l+1`),
          " から ",
          math(String.raw`k=l`),
          "。",
          math(String.raw`k<j\le l`),
          " なら ",
          math(String.raw`\rho_j(k)=k<j<l+1=\rho_j(l)`),
          " となり仮定に反する。",
          math(String.raw`l<j\le k`),
          " も同様に仮定に反する。",
        ],
        [
          "（",
          math(String.raw`\tau`),
          " の定義）",
          math(String.raw`k\in\{1,\dots,n-1\}`),
          " について、",
          math(String.raw`\sigma(\rho_j(k))\in\{1,\dots,n'\}`),
          " であり、",
          math(String.raw`\sigma(\rho_j(k))=n'=\sigma(j)`),
          " とすると ",
          math(String.raw`\sigma`),
          " の単射性から ",
          math(String.raw`\rho_j(k)=j`),
          " となり、前の項に反する。したがって ",
          math(String.raw`\sigma(\rho_j(k))\in\{1,\dots,n'-1\}`),
          " であり、写像 ",
          math(String.raw`\tau:\{1,\dots,n-1\}\to\{1,\dots,n'-1\}`),
          " を ",
          math(String.raw`\tau(k):=\sigma(\rho_j(k))`),
          " で定める。",
        ],
        [
          "（",
          math(String.raw`\tau`),
          " は単射）",
          math(String.raw`\tau(k)=\tau(l)`),
          " なら、",
          math(String.raw`\sigma`),
          " の単射性から ",
          math(String.raw`\rho_j(k)=\rho_j(l)`),
          "、",
          math(String.raw`\rho_j`),
          " の単射性から ",
          math(String.raw`k=l`),
          " である。",
        ],
        [
          "（",
          math(String.raw`\tau`),
          " は全射）",
          math(String.raw`i\in\{1,\dots,n'-1\}`),
          " とする。",
          math(String.raw`\sigma`),
          " の全射性から ",
          math(String.raw`\sigma(l)=i`),
          " を満たす ",
          math(String.raw`l\in\{1,\dots,n\}`),
          " がある。",
          math(String.raw`\sigma(j)=n'\ne i`),
          " なので ",
          math(String.raw`l\ne j`),
          " である。",
          math(String.raw`l<j`),
          " なら ",
          math(String.raw`k:=l`),
          " と置くと ",
          math(String.raw`1\le k\le j-1\le n-1`),
          " かつ ",
          math(String.raw`\rho_j(k)=k=l`),
          "。",
          math(String.raw`l>j`),
          " なら ",
          math(String.raw`k:=l-1`),
          " と置くと ",
          math(String.raw`1\le j\le k\le n-1`),
          " かつ ",
          math(String.raw`\rho_j(k)=k+1=l`),
          "。どちらの場合も ",
          math(String.raw`\tau(k)=\sigma(l)=i`),
          " である。",
        ],
        [
          "（残りの族）",
          math(String.raw`i\in\{1,\dots,n'-1\}`),
          " について ",
          math(String.raw`\hat{y}_i:=y_i\in V`),
          "、",
          math(String.raw`\hat{\mu}_i:=\mu_i\in\mathbb{C}`),
          " と置く（",
          math(String.raw`\{1,\dots,n'-1\}`),
          " で添字づけた族）。",
          math(String.raw`k\in\{1,\dots,n-1\}`),
          " について ",
          math(String.raw`\tau(k)\in\{1,\dots,n'-1\}`),
          " なので、",
          math(String.raw`\hat{y}_{\tau(k)}=y_{\sigma(\rho_j(k))}`),
          "、",
          math(String.raw`\hat{\mu}_{\tau(k)}=\mu_{\sigma(\rho_j(k))}`),
          " である。したがって、",
          math(String.raw`k\in\{1,\dots,n-1\}`),
          " で添字づけた二つの族 ",
          math(String.raw`k\mapsto(\mu_{\sigma(\rho_j(k))},y_{\sigma(\rho_j(k))})`),
          " と ",
          math(String.raw`k\mapsto(\hat{\mu}_{\tau(k)},\hat{y}_{\tau(k)})`),
          " は各 ",
          math(String.raw`k`),
          " で同じ値をとり、線型結合の定義（",
          ref("def_linear_combination"),
          "）が両者に定める元は同じ漸化式で決まるので等しい。",
        ],
        [
          "（残りの族の線型結合）族 ",
          math(String.raw`y,\mu`),
          " の線型結合の定義（",
          ref("def_linear_combination"),
          "）が定める元を ",
          math(String.raw`L_m`),
          "（",
          math(String.raw`m\in\{0,\dots,n'\}`),
          "）、族 ",
          math(String.raw`\hat{y},\hat{\mu}`),
          " について同じ定義が定める元を ",
          math(String.raw`\hat{L}_m`),
          "（",
          math(String.raw`m\in\{0,\dots,n'-1\}`),
          "）と書く。",
          math(String.raw`m\in\{0,\dots,n'-1\}`),
          " について ",
          math(String.raw`\hat{L}_m=L_m`),
          " が ",
          math(String.raw`m`),
          " の帰納法で成り立つ：",
          math(String.raw`\hat{L}_0=0_V=L_0`),
          "、",
          math(String.raw`1\le m\le n'-1`),
          " なら ",
          math(String.raw`\hat{L}_m=\hat{L}_{m-1}+_V(\hat{\mu}_m\cdot_V\hat{y}_m)=L_{m-1}+_V(\mu_m\cdot_V y_m)=L_m`),
          "（二つ目の等号は帰納法の仮定と ",
          math(String.raw`\hat{y}_m,\hat{\mu}_m`),
          " の定義）。とくに ",
          math(String.raw`\sum_{i=1}^{n'-1}\hat{\mu}_i\cdot_V\hat{y}_i=\hat{L}_{n'-1}=L_{n'-1}`),
          " である。",
        ],
        [
          "（帰納法の仮定を当てる条件）",
          math(String.raw`\tau`),
          " は単射かつ全射なので、",
          math(String.raw`(n-1,\tau)`),
          " は ",
          math(String.raw`\{1,\dots,n'-1\}`),
          " の番号付けである（",
          ref("def_numbering_of_finite_set"),
          "）。",
        ],
      ]),
      paragraph([
        "以上の準備のもとで、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\mu_{\sigma(k)}\cdot_V y_{\sigma(k)}
&=\Bigl(\sum_{k=1}^{n-1}\mu_{\sigma(\rho_j(k))}\cdot_V y_{\sigma(\rho_j(k))}\Bigr)+_V\bigl(\mu_{\sigma(j)}\cdot_V y_{\sigma(j)}\bigr)
&&\left(\because\ \blkref{claim_moving_term_of_linear_combination_to_last}\ \text{を}\ x_k:=y_{\sigma(k)},\ \lambda_k:=\mu_{\sigma(k)}\ \text{で}\right)\\
&=\Bigl(\sum_{k=1}^{n-1}\hat{\mu}_{\tau(k)}\cdot_V\hat{y}_{\tau(k)}\Bigr)+_V\bigl(\mu_{\sigma(j)}\cdot_V y_{\sigma(j)}\bigr)
&&\left(\because\ \hat{y}_{\tau(k)}=y_{\sigma(\rho_j(k))},\ \hat{\mu}_{\tau(k)}=\mu_{\sigma(\rho_j(k))}\right)\\
&=\Bigl(\sum_{i=1}^{n'-1}\hat{\mu}_i\cdot_V\hat{y}_i\Bigr)+_V\bigl(\mu_{\sigma(j)}\cdot_V y_{\sigma(j)}\bigr)
&&\left(\because\ \text{帰納法の仮定}\ Q(n-1)\ \text{を}\ n'-1,\ \hat{y},\ \hat{\mu},\ \tau\ \text{で}\right)\\
&=\Bigl(\sum_{i=1}^{n'-1}\hat{\mu}_i\cdot_V\hat{y}_i\Bigr)+_V\bigl(\mu_{n'}\cdot_V y_{n'}\bigr)
&&\left(\because\ \sigma(j)=n'\right)\\
&=L_{n'-1}+_V\bigl(\mu_{n'}\cdot_V y_{n'}\bigr)
&&\left(\because\ \hat{L}_{n'-1}=L_{n'-1}\right)\\
&=L_{n'}
&&\left(\because\ L_{n'}\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{i=1}^{n'}\mu_i\cdot_V y_i
&&\left(\because\ \text{線型結合の記号の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で ",
        math(String.raw`Q(n)`),
        " が示され、帰納法が完了する。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_sum_over_finite_set",
    kind: "definition",
    title: { text: "番号の付いていない有限集合の上の和" },
    labels: ["def_sum_over_finite_set"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x`),
        " が一つずつ与えられているとする。",
        math(String.raw`X`),
        " の番号付け ",
        math(String.raw`(n,e)`),
        " を一つ選び、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x`),
        " を次で定める。",
      ]),
      displayMath(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x:=\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}`),
      paragraph([
        "右辺は、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " に ",
        math(String.raw`v_{e(k)}\in V`),
        " と ",
        math(String.raw`\lambda_{e(k)}\in\mathbb{C}`),
        " を与える族の線型結合（",
        ref("def_linear_combination"),
        "）である。左辺の記号は和の範囲を集合 ",
        math(String.raw`X`),
        " で書き、右辺の番号順の和 ",
        math(String.raw`\sum_{k=1}^{n}`),
        " と記号の形で区別する。",
      ]),
      paragraph([
        "（番号付けの取り方によらないこと）",
        math(String.raw`(n',e')`),
        " を ",
        math(String.raw`X`),
        " のもう一つの番号付けとし、",
        math(String.raw`e'^{-1}:X\to\{1,\dots,n'\}`),
        " をその逆写像とする（",
        ref("def_numbering_of_finite_set"),
        "）。写像 ",
        math(String.raw`\sigma:\{1,\dots,n\}\to\{1,\dots,n'\}`),
        " を ",
        math(String.raw`\sigma(k):=e'^{-1}(e(k))`),
        " で定める。",
      ]),
      list([
        [
          "（",
          math(String.raw`e'\circ\sigma=e`),
          "）",
          math(String.raw`k\in\{1,\dots,n\}`),
          " について、",
          math(String.raw`e'(\sigma(k))=e'(e'^{-1}(e(k)))=e(k)`),
          " である（",
          math(String.raw`e'(e'^{-1}(x))=x`),
          "。",
          ref("def_numbering_of_finite_set"),
          "）。",
        ],
        [
          "（",
          math(String.raw`\sigma`),
          " は単射）",
          math(String.raw`k,l\in\{1,\dots,n\}`),
          " が ",
          math(String.raw`\sigma(k)=\sigma(l)`),
          " を満たすとき、前の項から ",
          math(String.raw`e(k)=e'(\sigma(k))=e'(\sigma(l))=e(l)`),
          " であり、",
          math(String.raw`e`),
          " の単射性から ",
          math(String.raw`k=l`),
          " である。",
        ],
        [
          "（",
          math(String.raw`\sigma`),
          " は全射）",
          math(String.raw`i\in\{1,\dots,n'\}`),
          " について ",
          math(String.raw`k:=e^{-1}(e'(i))\in\{1,\dots,n\}`),
          " と置くと、",
          math(String.raw`\sigma(k)=e'^{-1}(e(e^{-1}(e'(i))))=e'^{-1}(e'(i))=i`),
          " である（",
          math(String.raw`e(e^{-1}(x))=x`),
          " と ",
          math(String.raw`e'^{-1}(e'(i))=i`),
          "。",
          ref("def_numbering_of_finite_set"),
          "）。",
        ],
        [
          "（付け替えの主張を当てる族）",
          math(String.raw`i\in\{1,\dots,n'\}`),
          " について ",
          math(String.raw`y_i:=v_{e'(i)}\in V`),
          "、",
          math(String.raw`\mu_i:=\lambda_{e'(i)}\in\mathbb{C}`),
          " と置く。",
          math(String.raw`k\in\{1,\dots,n\}`),
          " について、最初の項から ",
          math(String.raw`y_{\sigma(k)}=v_{e'(\sigma(k))}=v_{e(k)}`),
          "、",
          math(String.raw`\mu_{\sigma(k)}=\lambda_{e'(\sigma(k))}=\lambda_{e(k)}`),
          " である。したがって ",
          math(String.raw`\{1,\dots,n\}`),
          " で添字づけた二つの族 ",
          math(String.raw`k\mapsto(\mu_{\sigma(k)},y_{\sigma(k)})`),
          " と ",
          math(String.raw`k\mapsto(\lambda_{e(k)},v_{e(k)})`),
          " は各 ",
          math(String.raw`k`),
          " で同じ値をとり、線型結合の定義（",
          ref("def_linear_combination"),
          "）が両者に定める元は同じ漸化式で決まるので等しい。",
        ],
      ]),
      paragraph([
        math(String.raw`\sigma`),
        " は単射かつ全射なので、",
        math(String.raw`(n,\sigma)`),
        " は ",
        math(String.raw`\{1,\dots,n'\}`),
        " の番号付けである（",
        ref("def_numbering_of_finite_set"),
        "）。以上の準備のもとで、",
        math(String.raw`(n,e)`),
        " で定めた右辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}
&=\sum_{k=1}^{n}\mu_{\sigma(k)}\cdot_V y_{\sigma(k)}
&&\left(\because\ \mu_{\sigma(k)}=\lambda_{e(k)},\ y_{\sigma(k)}=v_{e(k)}\right)\\
&=\sum_{i=1}^{n'}\mu_i\cdot_V y_i
&&\left(\because\ \blkref{claim_reindexing_linear_combination_by_bijection}\ \text{を}\ y,\ \mu,\ \sigma\ \text{で}\right)\\
&=\sum_{i=1}^{n'}\lambda_{e'(i)}\cdot_V v_{e'(i)}
&&\left(\because\ y_i,\ \mu_i\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "最後の辺は番号付け ",
        math(String.raw`(n',e')`),
        " で定めた右辺である。したがって ",
        math(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x`),
        " は選んだ番号付けによらず ",
        math(String.raw`V`),
        " の元として一つに決まる。",
        math(String.raw`X`),
        " が空集合のときは、番号付けは ",
        math(String.raw`n=0`),
        " のものに限られ（空集合への写像 ",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        " があるのは定義域 ",
        math(String.raw`\{1,\dots,n\}`),
        " が空集合のときだけである）、",
        math(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x=0_V`),
        " である（",
        ref("def_linear_combination"),
        " の ",
        math(String.raw`L_0`),
        "）。",
      ]),
      paragraph([
        math(String.raw`\mathbb{C}`),
        " の元の ",
        math(String.raw`X`),
        " の上の和は、この定義を ",
        math(String.raw`V:=\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "。ℂ-線型空間であることは ",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）に当てて ",
        math(String.raw`\sum_{x\in X}\lambda_x\cdot_{\mathbb{C}^{\mathrm{vec}}}v_x`),
        " と書く。係数を持たない和は、係数をすべて ",
        math(String.raw`1_{\mathbb{C}}`),
        " にした ",
        math(String.raw`\sum_{x\in X}1_{\mathbb{C}}\cdot_V v_x`),
        " と書き、係数を省いた記号は置かない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_of_sums_over_finite_set_with_same_family",
    kind: "claim",
    title: { text: "同じ族の二つの有限集合の上の和の和は、係数ごとの和による有限集合の上の和である" },
    labels: ["claim_sum_of_sums_over_finite_set_with_same_family"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x`),
        "、",
        math(String.raw`\mu_x`),
        " が一つずつ与えられているとする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)+_V\left(\sum_{x\in X}\mu_x\cdot_V v_x\right)=\sum_{x\in X}(\lambda_x+_{\mathbb{C}}\mu_x)\cdot_V v_x`),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、以下の三つの和はすべてこの ",
        math(String.raw`(n,e)`),
        " で定義を開く。有限集合の上の和は番号付けの取り方によらないので（",
        ref("def_sum_over_finite_set"),
        "）、三つの和に同じ番号付けを使ってよい。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`\nu_x:=\lambda_x+_{\mathbb{C}}\mu_x\in\mathbb{C}`),
        " を与える。また ",
        math(String.raw`\{1,\dots,n\}`),
        " で添字づけた族を、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        "、",
        math(String.raw`b_k:=b(k):=v_{e(k)}`),
        " と、",
        math(String.raw`\alpha_k:=\lambda_{e(k)}\in\mathbb{C}`),
        "、",
        math(String.raw`\beta_k:=\mu_{e(k)}\in\mathbb{C}`),
        " で定める。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`\nu`),
        " の定義から ",
        math(String.raw`\nu_{e(k)}=\lambda_{e(k)}+_{\mathbb{C}}\mu_{e(k)}=\alpha_k+_{\mathbb{C}}\beta_k`),
        " である。",
      ]),
      paragraph(["主張の左辺から始める。"]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)+_V\left(\sum_{x\in X}\mu_x\cdot_V v_x\right)
&=\left(\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}\right)+_V\left(\sum_{k=1}^{n}\mu_{e(k)}\cdot_V v_{e(k)}\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で二つの和に}\right)\\
&=\left(\sum_{k=1}^{n}\alpha_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\beta_k\cdot_V b_k\right)
&&\left(\because\ \alpha_k,\ \beta_k,\ b_k\ \text{の定義}\right)\\
&=\sum_{k=1}^{n}(\alpha_k+_{\mathbb{C}}\beta_k)\cdot_V b_k
&&\left(\because\ \blkref{claim_sum_of_linear_combinations_of_same_family}\ \text{を}\ b,\ \alpha,\ \beta\ \text{で}\right)\\
&=\sum_{k=1}^{n}\nu_{e(k)}\cdot_V v_{e(k)}
&&\left(\because\ \nu_{e(k)}=\alpha_k+_{\mathbb{C}}\beta_k,\ b_k\ \text{の定義}\right)\\
&=\sum_{x\in X}\nu_x\cdot_V v_x
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=\sum_{x\in X}(\lambda_x+_{\mathbb{C}}\mu_x)\cdot_V v_x
&&\left(\because\ \nu_x\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`X`),
        " が空集合のときは ",
        math(String.raw`n=0`),
        " であり、上の式変形はそのまま成り立つ（",
        ref("def_linear_combination"),
        " と ",
        ref("claim_sum_of_linear_combinations_of_same_family"),
        " は ",
        math(String.raw`n=0`),
        " を含む）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_scalar_multiple_of_sum_over_finite_set",
    kind: "claim",
    title: { text: "有限集合の上の和のスカラー倍は、係数のスカラー倍による有限集合の上の和である" },
    labels: ["claim_scalar_multiple_of_sum_over_finite_set"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x`),
        " が一つずつ与えられているとし、",
        math(String.raw`\rho\in\mathbb{C}`),
        " とする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\rho\cdot_V\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)=\sum_{x\in X}(\rho\cdot_{\mathbb{C}}\lambda_x)\cdot_V v_x`),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、以下の二つの和はどちらもこの ",
        math(String.raw`(n,e)`),
        " で定義を開く。有限集合の上の和は番号付けの取り方によらないので（",
        ref("def_sum_over_finite_set"),
        "）、二つの和に同じ番号付けを使ってよい。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`\nu_x:=\rho\cdot_{\mathbb{C}}\lambda_x\in\mathbb{C}`),
        " を与える。また ",
        math(String.raw`\{1,\dots,n\}`),
        " で添字づけた族を、",
        math(String.raw`b:\{1,\dots,n\}\to V`),
        "、",
        math(String.raw`b_k:=b(k):=v_{e(k)}`),
        " と、",
        math(String.raw`\alpha_k:=\lambda_{e(k)}\in\mathbb{C}`),
        " で定める。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`\nu`),
        " の定義から ",
        math(String.raw`\nu_{e(k)}=\rho\cdot_{\mathbb{C}}\lambda_{e(k)}=\rho\cdot_{\mathbb{C}}\alpha_k`),
        " である。",
      ]),
      paragraph(["主張の左辺から始める。"]),
      displayMath(String.raw`\begin{aligned}
\rho\cdot_V\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)
&=\rho\cdot_V\left(\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=\rho\cdot_V\left(\sum_{k=1}^{n}\alpha_k\cdot_V b_k\right)
&&\left(\because\ \alpha_k,\ b_k\ \text{の定義}\right)\\
&=\sum_{k=1}^{n}(\rho\cdot_{\mathbb{C}}\alpha_k)\cdot_V b_k
&&\left(\because\ \blkref{claim_scalar_multiple_of_linear_combination}\ \text{を}\ b,\ \alpha,\ \mu=\rho\ \text{で}\right)\\
&=\sum_{k=1}^{n}\nu_{e(k)}\cdot_V v_{e(k)}
&&\left(\because\ \nu_{e(k)}=\rho\cdot_{\mathbb{C}}\alpha_k,\ b_k\ \text{の定義}\right)\\
&=\sum_{x\in X}\nu_x\cdot_V v_x
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=\sum_{x\in X}(\rho\cdot_{\mathbb{C}}\lambda_x)\cdot_V v_x
&&\left(\because\ \nu_x\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`X`),
        " が空集合のときは ",
        math(String.raw`n=0`),
        " であり、上の式変形はそのまま成り立つ（",
        ref("def_linear_combination"),
        " と ",
        ref("claim_scalar_multiple_of_linear_combination"),
        " は ",
        math(String.raw`n=0`),
        " を含む）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_of_sums_over_finite_set_with_same_coefficients",
    kind: "claim",
    title: { text: "同じ係数の二つの有限集合の上の和の和は、族ごとの和による有限集合の上の和である" },
    labels: ["claim_sum_of_sums_over_finite_set_with_same_coefficients"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x`),
        "、",
        math(String.raw`w_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x`),
        " が一つずつ与えられているとする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)+_V\left(\sum_{x\in X}\lambda_x\cdot_V w_x\right)=\sum_{x\in X}\lambda_x\cdot_V(v_x+_V w_x)`),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、以下の三つの和はすべてこの ",
        math(String.raw`(n,e)`),
        " で定義を開く。有限集合の上の和は番号付けの取り方によらないので（",
        ref("def_sum_over_finite_set"),
        "）、三つの和に同じ番号付けを使ってよい。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`u_x:=v_x+_V w_x\in V`),
        " を与える。また ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`b_k:=v_{e(k)}`),
        "、",
        math(String.raw`c_k:=w_{e(k)}`),
        "、",
        math(String.raw`d_k:=u_{e(k)}`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_k:=\lambda_{e(k)}`),
        " を置く。",
        math(String.raw`u`),
        " の定義から ",
        math(String.raw`d_k=v_{e(k)}+_V w_{e(k)}=b_k+_V c_k`),
        " である。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b_1,\dots,b_n`),
        "、",
        math(String.raw`c_1,\dots,c_n`),
        "、",
        math(String.raw`d_1,\dots,d_n`),
        " のそれぞれと係数 ",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）を、順に ",
        math(String.raw`L^{b}_m`),
        "、",
        math(String.raw`L^{c}_m`),
        "、",
        math(String.raw`L^{d}_m`),
        " と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L^{b}_0:=0_V`),
          "、",
          math(String.raw`L^{b}_m:=L^{b}_{m-1}+_V(\alpha_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{c}_0:=0_V`),
          "、",
          math(String.raw`L^{c}_m:=L^{c}_{m-1}+_V(\alpha_m\cdot_V c_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{d}_0:=0_V`),
          "、",
          math(String.raw`L^{d}_m:=L^{d}_{m-1}+_V(\alpha_m\cdot_V d_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{b}_m+_V L^{c}_m=L^{d}_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
L^{b}_0+_V L^{c}_0
&=0_V+_V 0_V
&&\left(\because\ L^{b}_0,\ L^{c}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=L^{d}_0
&&\left(\because\ L^{d}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`L^{b}_{m-1}+_V L^{c}_{m-1}=L^{d}_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。式を短くするため、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`p:=\alpha_m\cdot_V b_m`),
        " と ",
        math(String.raw`q:=\alpha_m\cdot_V c_m`),
        " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{b}_m+_V L^{c}_m
&=\bigl(L^{b}_{m-1}+_V p\bigr)+_V\bigl(L^{c}_{m-1}+_V q\bigr)
&&\left(\because\ L^{b}_m,\ L^{c}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{b}_{m-1}+_V\Bigl(p+_V\bigl(L^{c}_{m-1}+_V q\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{b}_{m-1}+_V\Bigl(\bigl(p+_V L^{c}_{m-1}\bigr)+_V q\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{b}_{m-1}+_V\Bigl(\bigl(L^{c}_{m-1}+_V p\bigr)+_V q\Bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{b}_{m-1}+_V\Bigl(L^{c}_{m-1}+_V\bigl(p+_V q\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(L^{b}_{m-1}+_V L^{c}_{m-1}\bigr)+_V\bigl(p+_V q\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{d}_{m-1}+_V\bigl(p+_V q\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{d}_{m-1}+_V\bigl((\alpha_m\cdot_V b_m)+_V(\alpha_m\cdot_V c_m)\bigr)
&&\left(\because\ p,\ q\ \text{の置き方}\right)\\
&=L^{d}_{m-1}+_V\bigl(\alpha_m\cdot_V(b_m+_V c_m)\bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=L^{d}_{m-1}+_V(\alpha_m\cdot_V d_m)
&&\left(\because\ d_m=b_m+_V c_m\right)\\
&=L^{d}_m
&&\left(\because\ L^{d}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{b}_m+_V L^{c}_m=L^{d}_m`),
        " が示された（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる）。これを ",
        math(String.raw`m=n`),
        " で使い、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)+_V\left(\sum_{x\in X}\lambda_x\cdot_V w_x\right)
&=\left(\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}\right)+_V\left(\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V w_{e(k)}\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で二つの和に}\right)\\
&=\left(\sum_{k=1}^{n}\alpha_k\cdot_V b_k\right)+_V\left(\sum_{k=1}^{n}\alpha_k\cdot_V c_k\right)
&&\left(\because\ \alpha_k,\ b_k,\ c_k\ \text{の定義}\right)\\
&=L^{b}_n+_V L^{c}_n
&&\left(\because\ L^{b}_n,\ L^{c}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{d}_n
&&\left(\because\ \text{上の帰納法の}\ m=n\right)\\
&=\sum_{k=1}^{n}\alpha_k\cdot_V d_k
&&\left(\because\ L^{d}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V u_{e(k)}
&&\left(\because\ \alpha_k,\ d_k\ \text{の定義}\right)\\
&=\sum_{x\in X}\lambda_x\cdot_V u_x
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=\sum_{x\in X}\lambda_x\cdot_V(v_x+_V w_x)
&&\left(\because\ u_x\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_map_maps_sum_over_finite_set_to_sum_of_values",
    kind: "claim",
    title: { text: "線型写像は有限集合の上の和を、値の有限集合の上の和へ移す" },
    labels: ["claim_linear_map_maps_sum_over_finite_set_to_sum_of_values"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to U`),
        " を線型写像（",
        ref("def_linear_map"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x`),
        " が一つずつ与えられているとする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`f\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)=\sum_{x\in X}\lambda_x\cdot_U f(v_x)`),
      paragraph([
        "左辺の和は ",
        math(String.raw`V`),
        " の中の和、右辺の和は、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`U`),
        " の元 ",
        math(String.raw`f(v_x)`),
        " と係数 ",
        math(String.raw`\lambda_x`),
        " を与えたときの ",
        math(String.raw`U`),
        " の中の和である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、以下の二つの和はどちらもこの ",
        math(String.raw`(n,e)`),
        " で定義を開く。有限集合の上の和は番号付けの取り方によらないので（",
        ref("def_sum_over_finite_set"),
        "）、",
        math(String.raw`V`),
        " の中の和と ",
        math(String.raw`U`),
        " の中の和に同じ番号付けを使ってよい。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`u_x:=f(v_x)\in U`),
        " を与える。また ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`b_k:=v_{e(k)}`),
        "、",
        math(String.raw`U`),
        " の元 ",
        math(String.raw`c_k:=u_{e(k)}`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_k:=\lambda_{e(k)}`),
        " を置く。",
        math(String.raw`u`),
        " の定義から ",
        math(String.raw`c_k=f(v_{e(k)})=f(b_k)`),
        " である。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b_1,\dots,b_n`),
        "（",
        math(String.raw`V`),
        " の中）と族 ",
        math(String.raw`c_1,\dots,c_n`),
        "（",
        math(String.raw`U`),
        " の中）のそれぞれと係数 ",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める元 ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）を、順に ",
        math(String.raw`L^{b}_m\in V`),
        "、",
        math(String.raw`L^{c}_m\in U`),
        " と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L^{b}_0:=0_V`),
          "、",
          math(String.raw`L^{b}_m:=L^{b}_{m-1}+_V(\alpha_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{c}_0:=0_U`),
          "、",
          math(String.raw`L^{c}_m:=L^{c}_{m-1}+_U(\alpha_m\cdot_U c_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`f(L^{b}_m)=L^{c}_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
f(L^{b}_0)
&=f(0_V)
&&\left(\because\ L^{b}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=f(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\ \text{を}\ V\ \text{と}\ x=0_V\ \text{で}\right)\\
&=0_{\mathbb{C}}\cdot_U f(0_V)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=0_U
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\ \text{を}\ U\ \text{と}\ x=f(0_V)\ \text{で}\right)\\
&=L^{c}_0
&&\left(\because\ L^{c}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`f(L^{b}_{m-1})=L^{c}_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
f(L^{b}_m)
&=f\bigl(L^{b}_{m-1}+_V(\alpha_m\cdot_V b_m)\bigr)
&&\left(\because\ L^{b}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=f(L^{b}_{m-1})+_U f(\alpha_m\cdot_V b_m)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=L^{c}_{m-1}+_U f(\alpha_m\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{c}_{m-1}+_U\bigl(\alpha_m\cdot_U f(b_m)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=L^{c}_{m-1}+_U(\alpha_m\cdot_U c_m)
&&\left(\because\ c_m=f(b_m)\right)\\
&=L^{c}_m
&&\left(\because\ L^{c}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`f(L^{b}_m)=L^{c}_m`),
        " が示された（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる）。これを ",
        math(String.raw`m=n`),
        " で使い、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
f\left(\sum_{x\in X}\lambda_x\cdot_V v_x\right)
&=f\left(\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ V\ \text{と}\ (n,e)\ \text{で}\right)\\
&=f\left(\sum_{k=1}^{n}\alpha_k\cdot_V b_k\right)
&&\left(\because\ \alpha_k,\ b_k\ \text{の定義}\right)\\
&=f(L^{b}_n)
&&\left(\because\ L^{b}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{c}_n
&&\left(\because\ \text{上の帰納法の}\ m=n\right)\\
&=\sum_{k=1}^{n}\alpha_k\cdot_U c_k
&&\left(\because\ L^{c}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{k=1}^{n}\lambda_{e(k)}\cdot_U u_{e(k)}
&&\left(\because\ \alpha_k,\ c_k\ \text{の定義}\right)\\
&=\sum_{x\in X}\lambda_x\cdot_U u_x
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ U\ \text{と}\ (n,e)\ \text{で}\right)\\
&=\sum_{x\in X}\lambda_x\cdot_U f(v_x)
&&\left(\because\ u_x\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_map_maps_linear_combination_to_linear_combination_of_values",
    kind: "claim",
    title: { text: "線型写像は線型結合を、値の線型結合へ移す" },
    labels: ["claim_linear_map_maps_linear_combination_to_linear_combination_of_values"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to U`),
        " を線型写像（",
        ref("def_linear_map"),
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
        " が一つずつ与えられているとする。このとき、線型結合（",
        ref("def_linear_combination"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`f\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)=\sum_{k=1}^{n}\lambda_k\cdot_U f(x_k)`),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{id}_n:\{1,\dots,n\}\to\{1,\dots,n\}`),
        " を恒等写像とする。",
        math(String.raw`\mathrm{id}_n`),
        " は単射かつ全射なので、",
        math(String.raw`(n,\mathrm{id}_n)`),
        " は有限集合 ",
        math(String.raw`\{1,\dots,n\}`),
        " の番号付けである（",
        ref("def_numbering_of_finite_set"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
f\left(\sum_{k=1}^{n}\lambda_k\cdot_V x_k\right)
&=f\left(\sum_{k\in\{1,\dots,n\}}\lambda_k\cdot_V x_k\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ V\ \text{と番号付け}\ (n,\mathrm{id}_n)\ \text{で}\right)\\
&=\sum_{k\in\{1,\dots,n\}}\lambda_k\cdot_U f(x_k)
&&\left(\because\ \blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{k=1}^{n}\lambda_k\cdot_U f(x_k)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ U\ \text{と番号付け}\ (n,\mathrm{id}_n)\ \text{で}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_over_finite_set_with_kronecker_delta_picks_term",
    kind: "claim",
    title: { text: "有限集合の上の和で、係数をクロネッカーのデルタにすると一項が取り出される" },
    labels: ["claim_sum_over_finite_set_with_kronecker_delta_picks_term"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`y`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_y`),
        " が一つずつ与えられているとする。",
        math(String.raw`x\in X`),
        " とし、",
        math(String.raw`X`),
        " の二元についてのクロネッカーのデルタ ",
        math(String.raw`\delta_{x,y}\in\mathbb{C}`),
        "（",
        ref("def_kronecker_delta"),
        "）を、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`y`),
        " の係数に取る。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{y\in X}\delta_{x,y}\cdot_V v_y=v_x`),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、逆写像を ",
        math(String.raw`e^{-1}:X\to\{1,\dots,n\}`),
        " と書く（",
        ref("def_numbering_of_finite_set"),
        "）。主張の和はこの ",
        math(String.raw`(n,e)`),
        " で定義を開く（",
        ref("def_sum_over_finite_set"),
        "。番号付けの取り方によらない）。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`j:=e^{-1}(x)\in\{1,\dots,n\}`),
        " と置く。",
        math(String.raw`j`),
        " は ",
        math(String.raw`\{1,\dots,n\}`),
        " の元なので ",
        math(String.raw`\{1,\dots,n\}`),
        " は空集合でなく、",
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        " である。",
        math(String.raw`e(j)=e(e^{-1}(x))=x`),
        " である（",
        ref("def_numbering_of_finite_set"),
        "）。",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`b_k:=v_{e(k)}`),
        " を置く。",
      ]),
      paragraph([
        "次に、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`X`),
        " の二元についてのデルタ ",
        math(String.raw`\delta_{x,e(k)}`),
        " と、",
        math(String.raw`\{1,\dots,n\}`),
        " の二元についてのデルタ ",
        math(String.raw`\delta_{k,j}`),
        "（どちらも ",
        ref("def_kronecker_delta"),
        "。集合 ",
        math(String.raw`X`),
        " をそれぞれ ",
        math(String.raw`X`),
        " と ",
        math(String.raw`\{1,\dots,n\}`),
        " に当てたもの）が ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことを、",
        math(String.raw`k=j`),
        " と ",
        math(String.raw`k\neq j`),
        " に分けて示す。",
      ]),
      list([
        [
          "（",
          math(String.raw`k=j`),
          " のとき）",
          math(String.raw`e(k)=e(j)=x`),
          " なので、",
          math(String.raw`\delta_{x,e(k)}=1_{\mathbb{C}}`),
          " である。また ",
          math(String.raw`\delta_{k,j}=1_{\mathbb{C}}`),
          " である（どちらも ",
          ref("def_kronecker_delta"),
          "）。",
        ],
        [
          "（",
          math(String.raw`k\neq j`),
          " のとき）",
          math(String.raw`e(k)=x`),
          " と仮定すると、",
          math(String.raw`k=e^{-1}(e(k))=e^{-1}(x)=j`),
          " となり（",
          math(String.raw`e^{-1}(e(k))=k`),
          "。",
          ref("def_numbering_of_finite_set"),
          "）、",
          math(String.raw`k\neq j`),
          " に反する。よって ",
          math(String.raw`x\neq e(k)`),
          " であり、",
          math(String.raw`\delta_{x,e(k)}=0_{\mathbb{C}}`),
          " である。また ",
          math(String.raw`\delta_{k,j}=0_{\mathbb{C}}`),
          " である（どちらも ",
          ref("def_kronecker_delta"),
          "）。",
        ],
      ]),
      paragraph([
        "したがって、すべての ",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\delta_{x,e(k)}=\delta_{k,j}`),
        " である。以上の準備のもとで、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{y\in X}\delta_{x,y}\cdot_V v_y
&=\sum_{k=1}^{n}\delta_{x,e(k)}\cdot_V v_{e(k)}
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{と係数}\ \lambda_y:=\delta_{x,y}\ \text{で}\right)\\
&=\sum_{k=1}^{n}\delta_{k,j}\cdot_V b_k
&&\left(\because\ \delta_{x,e(k)}=\delta_{k,j},\ b_k\ \text{の定義}\right)\\
&=b_j
&&\left(\because\ \blkref{claim_family_member_is_kronecker_delta_linear_combination}\ \text{を}\ n\in\mathbb{Z}_{\ge 1},\ b,\ j\ \text{で}\right)\\
&=v_{e(j)}
&&\left(\because\ b_j\ \text{の定義}\right)\\
&=v_x
&&\left(\because\ e(j)=x\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_interchange_of_double_sum_over_finite_sets",
    kind: "claim",
    title: { text: "二つの有限集合の上の二重和は、和の順序を入れ替えても変わらない" },
    labels: ["claim_interchange_of_double_sum_over_finite_sets"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " と ",
        math(String.raw`Y`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の元 ",
        math(String.raw`x`),
        " と ",
        math(String.raw`Y`),
        " の元 ",
        math(String.raw`y`),
        " の組ごとに、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_{x,y}`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_{x,y}`),
        " が一つずつ与えられているとする。有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）で、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`s_x:=\sum_{y\in Y}\lambda_{x,y}\cdot_V v_{x,y}`),
        " を、",
        math(String.raw`Y`),
        " の各元 ",
        math(String.raw`y`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`t_y:=\sum_{x\in X}\lambda_{x,y}\cdot_V v_{x,y}`),
        " を与える。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{x\in X}1_{\mathbb{C}}\cdot_V s_x=\sum_{y\in Y}1_{\mathbb{C}}\cdot_V t_y`),
      paragraph([
        "左辺は ",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`s_x`),
        " を与えた族の、右辺は ",
        math(String.raw`Y`),
        " の各元 ",
        math(String.raw`y`),
        " に ",
        math(String.raw`t_y`),
        " を与えた族の、係数をすべて ",
        math(String.raw`1_{\mathbb{C}}`),
        " にした有限集合の上の和である（",
        ref("def_sum_over_finite_set"),
        " の、係数を持たない和の書き方）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " と ",
        math(String.raw`Y`),
        " は有限集合なので、",
        math(String.raw`X`),
        " の番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）と ",
        math(String.raw`Y`),
        " の番号付け ",
        math(String.raw`(n',e')`),
        "（",
        math(String.raw`n'\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e':\{1,\dots,n'\}\to Y`),
        "）が少なくとも一つずつある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つずつ選び、",
        math(String.raw`X`),
        " の上の和はすべて ",
        math(String.raw`(n,e)`),
        " で、",
        math(String.raw`Y`),
        " の上の和はすべて ",
        math(String.raw`(n',e')`),
        " で定義を開く（",
        ref("def_sum_over_finite_set"),
        "。番号付けの取り方によらない）。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " と ",
        math(String.raw`l\in\{1,\dots,n'\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`a_{k,l}:=\lambda_{e(k),e'(l)}\cdot_V v_{e(k),e'(l)}`),
        " を置き、線型結合の定義（",
        ref("def_linear_combination"),
        "）と同じ漸化式で、",
        math(String.raw`V`),
        " の元の三つの部分和を次のとおり定める。",
      ]),
      list([
        [
          "（行の部分和）",
          math(String.raw`k\in\{1,\dots,n\}`),
          " について、",
          math(String.raw`B^{k}_0:=0_V`),
          "、",
          math(String.raw`B^{k}_{m'}:=B^{k}_{m'-1}+_V a_{k,m'}`),
          "（",
          math(String.raw`1\le m'\le n'`),
          "）。",
        ],
        [
          "（列の部分和）",
          math(String.raw`l\in\{1,\dots,n'\}`),
          " について、",
          math(String.raw`C^{l}_0:=0_V`),
          "、",
          math(String.raw`C^{l}_{m}:=C^{l}_{m-1}+_V a_{m,l}`),
          "（",
          math(String.raw`1\le m\le n`),
          "）。",
        ],
        [
          "（列の部分和の部分和）",
          math(String.raw`m\in\{0,1,\dots,n\}`),
          " について、",
          math(String.raw`D_{m,0}:=0_V`),
          "、",
          math(String.raw`D_{m,m'}:=D_{m,m'-1}+_V\bigl(1_{\mathbb{C}}\cdot_V C^{m'}_{m}\bigr)`),
          "（",
          math(String.raw`1\le m'\le n'`),
          "）。",
        ],
      ]),
      paragraph([
        math(String.raw`B^{k}_{m'}`),
        " は、",
        math(String.raw`l\in\{1,\dots,n'\}`),
        " に ",
        math(String.raw`v_{e(k),e'(l)}`),
        " と係数 ",
        math(String.raw`\lambda_{e(k),e'(l)}`),
        " を与える族について線型結合の定義が定める ",
        math(String.raw`L_{m'}`),
        " であり、",
        math(String.raw`C^{l}_{m}`),
        " は、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " に ",
        math(String.raw`v_{e(k),e'(l)}`),
        " と係数 ",
        math(String.raw`\lambda_{e(k),e'(l)}`),
        " を与える族について線型結合の定義が定める ",
        math(String.raw`L_{m}`),
        " であり、",
        math(String.raw`D_{m,m'}`),
        " は、",
        math(String.raw`l\in\{1,\dots,n'\}`),
        " に ",
        math(String.raw`C^{l}_{m}`),
        " と係数 ",
        math(String.raw`1_{\mathbb{C}}`),
        " を与える族について線型結合の定義が定める ",
        math(String.raw`L_{m'}`),
        " である（",
        ref("def_linear_combination"),
        "）。したがって、",
        math(String.raw`s_x`),
        "・",
        math(String.raw`t_y`),
        " の定義と有限集合の上の和の定義（",
        ref("def_sum_over_finite_set"),
        "）から、次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`k\in\{1,\dots,n\}`),
          " について ",
          math(String.raw`s_{e(k)}=\sum_{l=1}^{n'}\lambda_{e(k),e'(l)}\cdot_V v_{e(k),e'(l)}=B^{k}_{n'}`),
          "。",
        ],
        [
          math(String.raw`l\in\{1,\dots,n'\}`),
          " について ",
          math(String.raw`t_{e'(l)}=\sum_{k=1}^{n}\lambda_{e(k),e'(l)}\cdot_V v_{e(k),e'(l)}=C^{l}_{n}`),
          "。",
        ],
      ]),
      paragraph([
        "（",
        math(String.raw`D_{0,m'}=0_V`),
        "）すべての ",
        math(String.raw`m'\in\{0,1,\dots,n'\}`),
        " について ",
        math(String.raw`D_{0,m'}=0_V`),
        " であることを、",
        math(String.raw`m'`),
        " についての帰納法で示す。",
        math(String.raw`m'=0`),
        " のときは ",
        math(String.raw`D_{0,0}`),
        " の定義そのものである。",
        math(String.raw`1\le m'\le n'`),
        " とし、",
        math(String.raw`D_{0,m'-1}=0_V`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
D_{0,m'}
&=D_{0,m'-1}+_V\bigl(1_{\mathbb{C}}\cdot_V C^{m'}_{0}\bigr)
&&\left(\because\ D_{0,m'}\ \text{の定義}\right)\\
&=0_V+_V\bigl(1_{\mathbb{C}}\cdot_V C^{m'}_{0}\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=0_V+_V\bigl(1_{\mathbb{C}}\cdot_V 0_V\bigr)
&&\left(\because\ C^{m'}_{0}\ \text{の定義}\right)\\
&=0_V+_V 0_V
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "（",
        math(String.raw`D_{m-1,m'}+_V B^{m}_{m'}=D_{m,m'}`),
        "）",
        math(String.raw`m\in\{1,\dots,n\}`),
        " を一つ固定し、すべての ",
        math(String.raw`m'\in\{0,1,\dots,n'\}`),
        " について ",
        math(String.raw`D_{m-1,m'}+_V B^{m}_{m'}=D_{m,m'}`),
        " であることを、",
        math(String.raw`m'`),
        " についての帰納法で示す。",
        math(String.raw`m'=0`),
        " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
D_{m-1,0}+_V B^{m}_{0}
&=0_V+_V 0_V
&&\left(\because\ D_{m-1,0},\ B^{m}_{0}\ \text{の定義}\right)\\
&=0_V
&&\left(\because\ 0_V\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=D_{m,0}
&&\left(\because\ D_{m,0}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m'\le n'`),
        " とし、",
        math(String.raw`D_{m-1,m'-1}+_V B^{m}_{m'-1}=D_{m,m'-1}`),
        " が成り立つと仮定する（帰納法の仮定）。式を短くするため、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`p:=1_{\mathbb{C}}\cdot_V C^{m'}_{m-1}`),
        " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
D_{m-1,m'}+_V B^{m}_{m'}
&=\bigl(D_{m-1,m'-1}+_V p\bigr)+_V\bigl(B^{m}_{m'-1}+_V a_{m,m'}\bigr)
&&\left(\because\ D_{m-1,m'},\ B^{m}_{m'}\ \text{の定義と}\ p\ \text{の置き方}\right)\\
&=D_{m-1,m'-1}+_V\Bigl(p+_V\bigl(B^{m}_{m'-1}+_V a_{m,m'}\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=D_{m-1,m'-1}+_V\Bigl(\bigl(p+_V B^{m}_{m'-1}\bigr)+_V a_{m,m'}\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=D_{m-1,m'-1}+_V\Bigl(\bigl(B^{m}_{m'-1}+_V p\bigr)+_V a_{m,m'}\Bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=D_{m-1,m'-1}+_V\Bigl(B^{m}_{m'-1}+_V\bigl(p+_V a_{m,m'}\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(D_{m-1,m'-1}+_V B^{m}_{m'-1}\bigr)+_V\bigl(p+_V a_{m,m'}\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=D_{m,m'-1}+_V\bigl(p+_V a_{m,m'}\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=D_{m,m'-1}+_V\bigl((1_{\mathbb{C}}\cdot_V C^{m'}_{m-1})+_V a_{m,m'}\bigr)
&&\left(\because\ p\ \text{の置き方}\right)\\
&=D_{m,m'-1}+_V\bigl(C^{m'}_{m-1}+_V a_{m,m'}\bigr)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=D_{m,m'-1}+_V C^{m'}_{m}
&&\left(\because\ C^{m'}_{m}\ \text{の定義}\right)\\
&=D_{m,m'-1}+_V\bigl(1_{\mathbb{C}}\cdot_V C^{m'}_{m}\bigr)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=D_{m,m'}
&&\left(\because\ D_{m,m'}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "（外側の部分和）",
        math(String.raw`X`),
        " の上の和の族 ",
        math(String.raw`k\mapsto s_{e(k)}`),
        " と係数 ",
        math(String.raw`1_{\mathbb{C}}`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が定める ",
        math(String.raw`V`),
        " の元を ",
        math(String.raw`R_0:=0_V`),
        "、",
        math(String.raw`R_m:=R_{m-1}+_V\bigl(1_{\mathbb{C}}\cdot_V s_{e(m)}\bigr)`),
        "（",
        math(String.raw`1\le m\le n`),
        "）と書く。すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`R_m=D_{m,n'}`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m=0`),
        " のときは、",
        math(String.raw`R_0=0_V=D_{0,n'}`),
        " である（",
        math(String.raw`R_0`),
        " の定義と、上で示した ",
        math(String.raw`D_{0,m'}=0_V`),
        " の ",
        math(String.raw`m'=n'`),
        "）。",
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`R_{m-1}=D_{m-1,n'}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
R_m
&=R_{m-1}+_V\bigl(1_{\mathbb{C}}\cdot_V s_{e(m)}\bigr)
&&\left(\because\ R_m\ \text{の定義}\right)\\
&=D_{m-1,n'}+_V\bigl(1_{\mathbb{C}}\cdot_V s_{e(m)}\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=D_{m-1,n'}+_V s_{e(m)}
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=D_{m-1,n'}+_V B^{m}_{n'}
&&\left(\because\ s_{e(m)}=B^{m}_{n'}\right)\\
&=D_{m,n'}
&&\left(\because\ \text{上で示した}\ D_{m-1,m'}+_V B^{m}_{m'}=D_{m,m'}\ \text{の}\ m'=n'\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`R_m=D_{m,n'}`),
        " が示された（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足り、",
        math(String.raw`n'=0`),
        " のときも同じ帰納法がそのまま通る）。これを ",
        math(String.raw`m=n`),
        " で使い、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in X}1_{\mathbb{C}}\cdot_V s_x
&=\sum_{k=1}^{n}1_{\mathbb{C}}\cdot_V s_{e(k)}
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=R_n
&&\left(\because\ R_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=D_{n,n'}
&&\left(\because\ \text{上の帰納法の}\ m=n\right)\\
&=\sum_{l=1}^{n'}1_{\mathbb{C}}\cdot_V C^{l}_{n}
&&\left(\because\ D_{n,n'}\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{l=1}^{n'}1_{\mathbb{C}}\cdot_V t_{e'(l)}
&&\left(\because\ C^{l}_{n}=t_{e'(l)}\right)\\
&=\sum_{y\in Y}1_{\mathbb{C}}\cdot_V t_y
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n',e')\ \text{で}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_over_finite_set_depends_only_on_terms",
    kind: "claim",
    title: { text: "有限集合の上の和は、各項の値だけで決まる" },
    labels: ["claim_sum_over_finite_set_depends_only_on_terms"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`X`),
        " を有限集合（",
        ref("def_numbering_of_finite_set"),
        "）とし、",
        math(String.raw`X`),
        " の各元 ",
        math(String.raw`x`),
        " に ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`v_x,\ u_x`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\lambda_x,\ \mu_x`),
        " が一つずつ与えられていて、すべての ",
        math(String.raw`x\in X`),
        " について ",
        math(String.raw`\lambda_x\cdot_V v_x=\mu_x\cdot_V u_x`),
        " が成り立つとする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x=\sum_{x\in X}\mu_x\cdot_V u_x`),
      paragraph([
        "係数どうし ",
        math(String.raw`\lambda_x,\ \mu_x`),
        " や元どうし ",
        math(String.raw`v_x,\ u_x`),
        " が等しいことは仮定しない。仮定するのは、各 ",
        math(String.raw`x`),
        " の項 ",
        math(String.raw`\lambda_x\cdot_V v_x`),
        " と ",
        math(String.raw`\mu_x\cdot_V u_x`),
        " が ",
        math(String.raw`V`),
        " の元として等しいことだけである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " は有限集合なので、番号付け ",
        math(String.raw`(n,e)`),
        "（",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`e:\{1,\dots,n\}\to X`),
        "）が少なくとも一つある（",
        ref("def_numbering_of_finite_set"),
        "）。それを一つ選び、二つの和をどちらもこの ",
        math(String.raw`(n,e)`),
        " で定義を開く。有限集合の上の和は番号付けの取り方によらないので（",
        ref("def_sum_over_finite_set"),
        "）、二つの和に同じ番号付けを使ってよい。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`k\in\{1,\dots,n\}`),
        " について、",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`b_k:=v_{e(k)}`),
        "、",
        math(String.raw`c_k:=u_{e(k)}`),
        " と ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_k:=\lambda_{e(k)}`),
        "、",
        math(String.raw`\beta_k:=\mu_{e(k)}`),
        " を置く。仮定を ",
        math(String.raw`x=e(k)`),
        " に当てると ",
        math(String.raw`\alpha_k\cdot_V b_k=\lambda_{e(k)}\cdot_V v_{e(k)}=\mu_{e(k)}\cdot_V u_{e(k)}=\beta_k\cdot_V c_k`),
        " である。",
      ]),
      paragraph([
        "族 ",
        math(String.raw`b_1,\dots,b_n`),
        " と係数 ",
        math(String.raw`\alpha_1,\dots,\alpha_n`),
        "、族 ",
        math(String.raw`c_1,\dots,c_n`),
        " と係数 ",
        math(String.raw`\beta_1,\dots,\beta_n`),
        " について、線型結合の定義（",
        ref("def_linear_combination"),
        "）が帰納的に定める ",
        math(String.raw`V`),
        " の元 ",
        math(String.raw`L_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        "）を、順に ",
        math(String.raw`L^{b}_m`),
        "、",
        math(String.raw`L^{c}_m`),
        " と書く。すなわち次である。",
      ]),
      list([
        [
          math(String.raw`L^{b}_0:=0_V`),
          "、",
          math(String.raw`L^{b}_m:=L^{b}_{m-1}+_V(\alpha_m\cdot_V b_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
        [
          math(String.raw`L^{c}_0:=0_V`),
          "、",
          math(String.raw`L^{c}_m:=L^{c}_{m-1}+_V(\beta_m\cdot_V c_m)`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        "すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{b}_m=L^{c}_m`),
        " であることを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      paragraph([math(String.raw`m=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
L^{b}_0
&=0_V
&&\left(\because\ L^{b}_0\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{c}_0
&&\left(\because\ L^{c}_0\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`1\le m\le n`),
        " とし、",
        math(String.raw`L^{b}_{m-1}=L^{c}_{m-1}`),
        " が成り立つと仮定する（帰納法の仮定）。",
      ]),
      displayMath(String.raw`\begin{aligned}
L^{b}_m
&=L^{b}_{m-1}+_V(\alpha_m\cdot_V b_m)
&&\left(\because\ L^{b}_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{c}_{m-1}+_V(\alpha_m\cdot_V b_m)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=L^{c}_{m-1}+_V(\beta_m\cdot_V c_m)
&&\left(\because\ \alpha_m\cdot_V b_m=\beta_m\cdot_V c_m\right)\\
&=L^{c}_m
&&\left(\because\ L^{c}_m\ \text{の定義。}\blkref{def_linear_combination}\right).
\end{aligned}`),
      paragraph([
        "以上で、すべての ",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について ",
        math(String.raw`L^{b}_m=L^{c}_m`),
        " が示された（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`m=0`),
        " の場合だけで足りる）。これを ",
        math(String.raw`m=n`),
        " で使い、主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in X}\lambda_x\cdot_V v_x
&=\sum_{k=1}^{n}\lambda_{e(k)}\cdot_V v_{e(k)}
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right)\\
&=\sum_{k=1}^{n}\alpha_k\cdot_V b_k
&&\left(\because\ \alpha_k,\ b_k\ \text{の定義}\right)\\
&=L^{b}_n
&&\left(\because\ L^{b}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L^{c}_n
&&\left(\because\ \text{上の帰納法の}\ m=n\right)\\
&=\sum_{k=1}^{n}\beta_k\cdot_V c_k
&&\left(\because\ L^{c}_n\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=\sum_{k=1}^{n}\mu_{e(k)}\cdot_V u_{e(k)}
&&\left(\because\ \beta_k,\ c_k\ \text{の定義}\right)\\
&=\sum_{x\in X}\mu_x\cdot_V u_x
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を}\ (n,e)\ \text{で}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "ℂ-代数" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_complex_algebra",
    kind: "definition",
    title: { text: "ℂ-代数" },
    labels: ["def_complex_algebra"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`A`),
        "、写像 ",
        math(String.raw`+_A:A\times A\to A`),
        "、",
        math(String.raw`\cdot_A:A\times A\to A`),
        "、",
        math(String.raw`\ast_A:\mathbb{C}\times A\to A`),
        "、元 ",
        math(String.raw`0_A\in A`),
        " と ",
        math(String.raw`1_A\in A`),
        " の組 ",
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " が次をすべて満たすとき、これを ℂ-代数と呼び、",
        math(String.raw`+_A`),
        " を加法、",
        math(String.raw`\cdot_A`),
        " を乗法、",
        math(String.raw`\ast_A`),
        " をスカラー倍と呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`A`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [
          "組 ",
          math(String.raw`(A,+_A,\cdot_A,0_A,1_A)`),
          " は単位元をもつ環（",
          ref("def_unital_ring"),
          "）である",
        ],
        [
          "組 ",
          math(String.raw`(A,+_A,\ast_A,0_A)`),
          " は ℂ-線型空間（",
          ref("def_complex_vector_space"),
          "）である",
        ],
        [
          math(String.raw`\lambda\ast_A(x\cdot_A y)=(\lambda\ast_A x)\cdot_A y`),
          "（スカラー倍と乗法の両立、左の因子）",
        ],
        [
          math(String.raw`\lambda\ast_A(x\cdot_A y)=x\cdot_A(\lambda\ast_A y)`),
          "（スカラー倍と乗法の両立、右の因子）",
        ],
      ]),
      paragraph([
        "二つの組は同じ集合 ",
        math(String.raw`A`),
        "、同じ加法 ",
        math(String.raw`+_A`),
        "、同じ加法の単位元 ",
        math(String.raw`0_A`),
        " をもつ。乗法 ",
        math(String.raw`\cdot_A`),
        " とスカラー倍 ",
        math(String.raw`\ast_A`),
        " は定義域の異なる別の写像なので、別の記号で書く。",
        "演算と単位元には、それが属する代数を必ず添字で書く。乗法の交換法則は仮定しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_complex_algebra_homomorphism",
    kind: "definition",
    title: { text: "ℂ-代数の準同型" },
    labels: ["def_complex_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とする。写像 ",
        math(String.raw`\varphi:A\to B`),
        " が次の二つを満たすとき、",
        math(String.raw`\varphi`),
        " を ",
        math(String.raw`A`),
        " から ",
        math(String.raw`B`),
        " への ℂ-代数の準同型と呼ぶ。",
      ]),
      list([
        [
          math(String.raw`\varphi`),
          " は、環の組 ",
          math(String.raw`(A,+_A,\cdot_A,0_A,1_A)`),
          " から環の組 ",
          math(String.raw`(B,+_B,\cdot_B,0_B,1_B)`),
          " への環の準同型（",
          ref("def_ring_homomorphism"),
          "）である",
        ],
        [
          math(String.raw`\varphi`),
          " は、線型空間の組 ",
          math(String.raw`(A,+_A,\ast_A,0_A)`),
          " から線型空間の組 ",
          math(String.raw`(B,+_B,\ast_B,0_B)`),
          " への線型写像（",
          ref("def_linear_map"),
          "）である",
        ],
      ]),
      paragraph([
        "二つの組は ",
        ref("def_complex_algebra"),
        " の一つ目と二つ目の条件で与えられた組である。二つの条件を、",
        math(String.raw`x,y`),
        " を ",
        math(String.raw`A`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元として、",
        ref("def_ring_homomorphism"),
        " と ",
        ref("def_linear_map"),
        " の定義に従って書き出すと次のとおりである。",
      ]),
      list([
        [math(String.raw`\varphi(x+_A y)=\varphi(x)+_B\varphi(y)`), "（加法を保つ。二つの条件のどちらにも含まれる）"],
        [math(String.raw`\varphi(x\cdot_A y)=\varphi(x)\cdot_B\varphi(y)`), "（乗法を保つ）"],
        [math(String.raw`\varphi(1_A)=1_B`), "（乗法の単位元を保つ）"],
        [math(String.raw`\varphi(\lambda\ast_A x)=\lambda\ast_B\varphi(x)`), "（スカラー倍を保つ）"],
      ]),
      paragraph([
        "左辺の演算と単位元は ",
        math(String.raw`A`),
        " のもの、右辺の演算と単位元は ",
        math(String.raw`B`),
        " のものであり、添字で区別する。",
        "加法の単位元を保つこと ",
        math(String.raw`\varphi(0_A)=0_B`),
        " は、",
        ref("def_ring_homomorphism"),
        " と ",
        ref("def_linear_map"),
        " と同じく条件に含めない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_underlying_ring_and_vector_space_of_algebra",
    kind: "definition",
    title: { text: "代数から環と線型空間を取り出す対応と記号の規則" },
    labels: ["def_underlying_ring_and_vector_space_of_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とする。二つの組を次で定める。",
      ]),
      list([
        [math(String.raw`U_{\mathrm{ring}}(A):=(A,+_A,\cdot_A,0_A,1_A)`), "（",
          math(String.raw`A`), " の環）"],
        [math(String.raw`U_{\mathrm{vec}}(A):=(A,+_A,\ast_A,0_A)`), "（",
          math(String.raw`A`), " の線型空間）"],
      ]),
      paragraph([
        ref("def_complex_algebra"),
        " の一つ目の条件により ",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        " は単位元をもつ環（",
        ref("def_unital_ring"),
        "）であり、二つ目の条件により ",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
        math(String.raw`U_{\mathrm{ring}}`),
        " と ",
        math(String.raw`U_{\mathrm{vec}}`),
        " は、ℂ-代数を一つ与えるごとに組を一つ定める対応である。ℂ-代数の全体は集合とは限らないので、集合の間の写像としては扱わない。",
      ]),
      paragraph([
        "三つの組 ",
        math(String.raw`A`),
        "・",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        "・",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " は同じ集合 ",
        math(String.raw`A`),
        " を台集合にもつ。",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        " の元・",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        " の元とは ",
        math(String.raw`A`),
        " の元のことであり、二つの元が等しいとは ",
        math(String.raw`A`),
        " の元として等しいことである。二つの対応が区別するのは、元に施す演算の組だけである。",
      ]),
      paragraph(["以後、次の規則で書く。"]),
      list([
        [
          "単位元をもつ環についての定義・主張を ",
          math(String.raw`A`),
          " に当てるときは、",
          math(String.raw`R:=U_{\mathrm{ring}}(A)`),
          " に当てる。このとき ",
          math(String.raw`+_R,\ \cdot_R,\ 0_R,\ 1_R`),
          " を ",
          math(String.raw`+_A,\ \cdot_A,\ 0_A,\ 1_A`),
          " と書く。",
        ],
        [
          "ℂ-線型空間についての定義・主張を ",
          math(String.raw`A`),
          " に当てるときは、",
          math(String.raw`V:=U_{\mathrm{vec}}(A)`),
          " に当てる。このとき ",
          math(String.raw`+_V,\ \cdot_V,\ 0_V`),
          " を ",
          math(String.raw`+_A,\ \ast_A,\ 0_A`),
          " と書く。線型空間のスカラー倍 ",
          math(String.raw`\cdot_V`),
          " に当たるのは ",
          math(String.raw`A`),
          " のスカラー倍 ",
          math(String.raw`\ast_A`),
          " であり、",
          math(String.raw`A`),
          " の乗法 ",
          math(String.raw`\cdot_A`),
          " ではない。",
        ],
        [
          "特に、",
          math(String.raw`A`),
          " の元の線型結合（",
          ref("def_linear_combination"),
          "）と有限集合の上の和（",
          ref("def_sum_over_finite_set"),
          "）は ",
          math(String.raw`U_{\mathrm{vec}}(A)`),
          " のものであり、",
          math(String.raw`\sum_{x\in X}\lambda_x\ast_A a_x`),
          " と書く。",
        ],
        [
          math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
          " をもう一つの ℂ-代数とする。ℂ-代数の準同型 ",
          math(String.raw`\varphi:A\to B`),
          "（",
          ref("def_complex_algebra_homomorphism"),
          "）は、その一つ目の条件により ",
          math(String.raw`U_{\mathrm{ring}}(A)`),
          " から ",
          math(String.raw`U_{\mathrm{ring}}(B)`),
          " への環の準同型（",
          ref("def_ring_homomorphism"),
          "）であり、二つ目の条件により ",
          math(String.raw`U_{\mathrm{vec}}(A)`),
          " から ",
          math(String.raw`U_{\mathrm{vec}}(B)`),
          " への線型写像（",
          ref("def_linear_map"),
          "）である。環の準同型・線型写像についての主張を ",
          math(String.raw`\varphi`),
          " に当てるときは、この二つを通して当てる。",
        ],
        [
          "「",
          math(String.raw`A`),
          " を環とみなす」「",
          math(String.raw`A`),
          " を線型空間とみなす」とは書かない。環または線型空間として使うときは、",
          math(String.raw`U_{\mathrm{ring}}(A)`),
          " または ",
          math(String.raw`U_{\mathrm{vec}}(A)`),
          " と書く。",
        ],
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_ordered_product_in_algebra",
    kind: "definition",
    title: { text: "代数の中の番号順の積" },
    labels: ["def_ordered_product_in_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`\{1,\dots,n\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`x_k`),
        " が一つずつ与えられているとする（",
        math(String.raw`n=0`),
        " のときは何も与えられていない）。",
        math(String.raw`m\in\{0,1,\dots,n\}`),
        " について、",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`\Pi_m`),
        " を次で帰納的に定める。",
      ]),
      list([
        [math(String.raw`\Pi_0:=1_A`)],
        [
          math(String.raw`\Pi_m:=\Pi_{m-1}\cdot_A x_m`),
          "（",
          math(String.raw`1\le m\le n`),
          "）",
        ],
      ]),
      paragraph([
        math(String.raw`\Pi_n`),
        " を、",
        math(String.raw`x_1,\dots,x_n`),
        " の ",
        math(String.raw`A`),
        " の中の番号順の積と呼び、",
        math(String.raw`\prod_{A,\,k=1}^{n}x_k`),
        " と書く。",
        math(String.raw`n=0`),
        " のとき ",
        math(String.raw`\prod_{A,\,k=1}^{0}x_k=1_A`),
        " である。",
      ]),
      paragraph([
        "演算は ",
        math(String.raw`A`),
        " の乗法 ",
        math(String.raw`\cdot_A`),
        " と乗法の単位元 ",
        math(String.raw`1_A`),
        " だけであり、これは ",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）の乗法と乗法の単位元である。積の記号の添字 ",
        math(String.raw`A`),
        " でそれを示す。",
      ]),
      paragraph([
        "積は番号 ",
        math(String.raw`1,\dots,n`),
        " の順に、それまでの積の右側へ因子を掛けていく一つの式として定めている。",
        math(String.raw`A`),
        " の乗法は可換とは限らないので、因子の順序を入れ替えても積が変わらないことは主張しない。",
        "番号の逆順 ",
        math(String.raw`n,\dots,1`),
        " の積が要るときは、逆順に並べ直した族 ",
        math(String.raw`y_k:=x_{n+1-k}`),
        "（",
        math(String.raw`k\in\{1,\dots,n\}`),
        "）の番号順の積 ",
        math(String.raw`\prod_{A,\,k=1}^{n}y_k`),
        " として書く。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_subalgebra",
    kind: "definition",
    title: { text: "部分代数" },
    labels: ["def_subalgebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`B`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。",
        math(String.raw`B`),
        " が次をすべて満たすとき、",
        math(String.raw`B`),
        " を ",
        math(String.raw`A`),
        " の部分代数と呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`B`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`1_A\in B`), "（乗法の単位元を含む）"],
        [math(String.raw`x+_A y\in B`), "（加法で閉じている）"],
        [math(String.raw`x\cdot_A y\in B`), "（乗法で閉じている）"],
        [math(String.raw`\lambda\ast_A x\in B`), "（スカラー倍で閉じている）"],
      ]),
      paragraph([
        "演算と単位元はどれも ",
        math(String.raw`A`),
        " のものであり、添字 ",
        math(String.raw`A`),
        " で示す。",
        math(String.raw`B`),
        " は ",
        math(String.raw`A`),
        " の部分集合として定めており、",
        math(String.raw`B`),
        " の上に演算を制限した組が ℂ-代数であることは主張しない。",
        "加法の単位元 ",
        math(String.raw`0_A`),
        " が ",
        math(String.raw`B`),
        " に入ることは条件に含めない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_subset_generates_algebra",
    kind: "definition",
    title: { text: "部分集合が代数を生成すること" },
    labels: ["def_subset_generates_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。次が成り立つとき、",
        math(String.raw`X`),
        " は ",
        math(String.raw`A`),
        " を生成すると言う。",
      ]),
      list([
        [
          math(String.raw`A`),
          " の部分代数（",
          ref("def_subalgebra"),
          "）",
          math(String.raw`B`),
          " で ",
          math(String.raw`X\subseteq B`),
          " を満たすものは、どれも ",
          math(String.raw`B=A`),
          " である。",
        ],
      ]),
      paragraph([
        "この定義は ",
        math(String.raw`X`),
        " を含む部分代数の性質として直接述べており、",
        math(String.raw`X`),
        " が生成する部分代数を（",
        math(String.raw`X`),
        " を含む部分代数全体の共通部分などとして）作ることはしない。",
        math(String.raw`A`),
        " の元を ",
        math(String.raw`X`),
        " の元の和・積・スカラー倍の式で書けることも、この定義には含めない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_homomorphisms_agreeing_on_generators_are_equal",
    kind: "claim",
    title: { text: "生成元で一致する二つの準同型は等しい" },
    labels: ["claim_homomorphisms_agreeing_on_generators_are_equal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）、",
        math(String.raw`\varphi:A\to B`),
        " と ",
        math(String.raw`\psi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " を生成する ",
        math(String.raw`A`),
        " の部分集合（",
        ref("def_subset_generates_algebra"),
        "）とする。",
        math(String.raw`X`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=\psi(x)`),
        " が成り立つとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " について ",
        math(String.raw`\varphi(a)=\psi(a)`),
        " が成り立つ。すなわち、写像として ",
        math(String.raw`\varphi=\psi`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`A`),
        " の部分集合 ",
        math(String.raw`E`),
        " を次で定める。",
      ]),
      displayMath(String.raw`E:=\{\,a\in A:\ \varphi(a)=\psi(a)\,\}.`),
      paragraph([
        math(String.raw`E`),
        " が ",
        math(String.raw`A`),
        " の部分代数（",
        ref("def_subalgebra"),
        "）の四条件を満たすことを示す。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`E`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。",
        math(String.raw`x\in E`),
        " と ",
        math(String.raw`y\in E`),
        " は ",
        math(String.raw`E`),
        " の定義により ",
        math(String.raw`\varphi(x)=\psi(x)`),
        " と ",
        math(String.raw`\varphi(y)=\psi(y)`),
        " のことである。",
      ]),
      paragraph(["乗法の単位元を含むこと（",
        math(String.raw`1_A\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(1_A)
&=1_B
&&\left(\because\ \varphi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right)\\
&=\psi(1_A)
&&\left(\because\ \psi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right).
\end{aligned}`),
      paragraph(["加法で閉じていること（",
        math(String.raw`x+_A y\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x+_A y)
&=\varphi(x)+_B\varphi(y)
&&\left(\because\ \varphi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right)\\
&=\psi(x)+_B\varphi(y)
&&\left(\because\ x\in E\right)\\
&=\psi(x)+_B\psi(y)
&&\left(\because\ y\in E\right)\\
&=\psi(x+_A y)
&&\left(\because\ \psi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right).
\end{aligned}`),
      paragraph(["乗法で閉じていること（",
        math(String.raw`x\cdot_A y\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x\cdot_A y)
&=\varphi(x)\cdot_B\varphi(y)
&&\left(\because\ \varphi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right)\\
&=\psi(x)\cdot_B\varphi(y)
&&\left(\because\ x\in E\right)\\
&=\psi(x)\cdot_B\psi(y)
&&\left(\because\ y\in E\right)\\
&=\psi(x\cdot_A y)
&&\left(\because\ \psi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right).
\end{aligned}`),
      paragraph(["スカラー倍で閉じていること（",
        math(String.raw`\lambda\ast_A x\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(\lambda\ast_A x)
&=\lambda\ast_B\varphi(x)
&&\left(\because\ \varphi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_linear_map}\right)\\
&=\lambda\ast_B\psi(x)
&&\left(\because\ x\in E\right)\\
&=\psi(\lambda\ast_A x)
&&\left(\because\ \psi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_linear_map}\right).
\end{aligned}`),
      paragraph([
        "四条件が満たされたので、",
        math(String.raw`E`),
        " は ",
        math(String.raw`A`),
        " の部分代数である（",
        ref("def_subalgebra"),
        "）。仮定により ",
        math(String.raw`X`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=\psi(x)`),
        " なので、",
        math(String.raw`X\subseteq E`),
        " である。",
        math(String.raw`X`),
        " は ",
        math(String.raw`A`),
        " を生成するので、",
        math(String.raw`E=A`),
        " である（",
        ref("def_subset_generates_algebra"),
        "）。したがって ",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " は ",
        math(String.raw`E`),
        " の元であり、",
        math(String.raw`E`),
        " の定義により ",
        math(String.raw`\varphi(a)=\psi(a)`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_ideal_and_quotient_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "両側イデアルと商代数" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_two_sided_ideal",
    kind: "definition",
    title: { text: "両側イデアル" },
    labels: ["def_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。",
        math(String.raw`I`),
        " が次をすべて満たすとき、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアルと呼ぶ。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`I`),
        " の任意の元、",
        math(String.raw`a`),
        " は ",
        math(String.raw`A`),
        " の任意の元を表す。",
      ]),
      list([
        [math(String.raw`0_A\in I`), "（加法の単位元を含む）"],
        [math(String.raw`x+_A y\in I`), "（加法で閉じている）"],
        [math(String.raw`a\cdot_A x\in I`), "（",
          math(String.raw`A`), " の元を左から掛けても ", math(String.raw`I`), " に入る）"],
        [math(String.raw`x\cdot_A a\in I`), "（",
          math(String.raw`A`), " の元を右から掛けても ", math(String.raw`I`), " に入る）"],
      ]),
      paragraph([
        "演算と単位元はどれも ",
        math(String.raw`A`),
        " のものであり、添字 ",
        math(String.raw`A`),
        " で示す。三つ目と四つ目の条件で掛ける ",
        math(String.raw`a`),
        " は ",
        math(String.raw`I`),
        " の元に限らず、",
        math(String.raw`A`),
        " の元すべてを動く。",
        math(String.raw`I`),
        " は ",
        math(String.raw`A`),
        " の部分集合として定めており、",
        math(String.raw`I`),
        " の上に演算を制限した組が ℂ-代数であることは主張しない（",
        math(String.raw`1_A\in I`),
        " は求めない）。",
        "スカラー倍で閉じていること、加法の逆元を含むことは条件に含めない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_two_sided_ideal_generated_by_subset",
    kind: "definition",
    title: { text: "部分集合が生成する両側イデアル" },
    labels: ["def_two_sided_ideal_generated_by_subset"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。",
        math(String.raw`A`),
        " の部分集合 ",
        math(String.raw`\langle X\rangle_A`),
        " を次で定め、",
        math(String.raw`X`),
        " が生成する両側イデアルと呼ぶ。",
      ]),
      displayMath(String.raw`\langle X\rangle_A:=\{\,a\in A\ :\ X\subseteq I\ \text{を満たす}\ A\ \text{の両側イデアル}\ I\ \text{のどれについても}\ a\in I\,\}.`),
      paragraph([
        "ここで両側イデアルは ",
        ref("def_two_sided_ideal"),
        " のものである。右辺は ",
        math(String.raw`A`),
        " の元についての条件で ",
        math(String.raw`A`),
        " の部分集合を切り出しているので、",
        math(String.raw`\langle X\rangle_A`),
        " は ",
        math(String.raw`A`),
        " と ",
        math(String.raw`X`),
        " だけから一つに決まる。記号は添字 ",
        math(String.raw`A`),
        " で、どの代数の中で生成するかを示す。",
        math(String.raw`\langle X\rangle_A`),
        " が両側イデアルであること、",
        math(String.raw`X`),
        " を含むこと、",
        math(String.raw`X`),
        " を含むどの両側イデアルにも含まれることは、この定義には含めず、続く三つの主張で示す。",
        math(String.raw`\langle X\rangle_A`),
        " の元を ",
        math(String.raw`X`),
        " の元の和と積の式で書けることは主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal",
    kind: "claim",
    title: { text: "部分集合が生成する両側イデアルは両側イデアルである" },
    labels: ["claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。",
        math(String.raw`X`),
        " が生成する両側イデアル ",
        math(String.raw`\langle X\rangle_A`),
        "（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）は、",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`X\subseteq I`),
        " を満たす ",
        math(String.raw`A`),
        " の両側イデアル ",
        math(String.raw`I`),
        "（",
        ref("def_two_sided_ideal"),
        "）全体の集合を ",
        math(String.raw`\mathcal{J}_X`),
        " と書く。",
        math(String.raw`\langle X\rangle_A`),
        " の定義（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）により、",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`b`),
        " について次の二つは同値である。",
      ]),
      displayMath(String.raw`b\in\langle X\rangle_A
\quad\Longleftrightarrow\quad
\mathcal{J}_X\ \text{のどの元}\ I\ \text{についても}\ b\in I .`),
      paragraph([
        "この同値の右辺を確かめることで、",
        math(String.raw`\langle X\rangle_A`),
        " が両側イデアルの定義（",
        ref("def_two_sided_ideal"),
        "）の四条件を満たすことを示す。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`\langle X\rangle_A`),
        " の任意の元、",
        math(String.raw`a`),
        " は ",
        math(String.raw`A`),
        " の任意の元、",
        math(String.raw`I`),
        " は ",
        math(String.raw`\mathcal{J}_X`),
        " の任意の元とする。",
        math(String.raw`x\in\langle X\rangle_A`),
        " と ",
        math(String.raw`y\in\langle X\rangle_A`),
        " と上の同値により、",
        math(String.raw`x\in I`),
        " かつ ",
        math(String.raw`y\in I`),
        " である。",
      ]),
      list([
        [
          "加法の単位元を含むこと：",
          math(String.raw`I`),
          " は両側イデアルなので ",
          math(String.raw`0_A\in I`),
          " である（",
          ref("def_two_sided_ideal"),
          " の一つ目の条件）。",
          math(String.raw`I`),
          " は ",
          math(String.raw`\mathcal{J}_X`),
          " の任意の元なので、上の同値により ",
          math(String.raw`0_A\in\langle X\rangle_A`),
          " である。",
        ],
        [
          "加法で閉じていること：",
          math(String.raw`x\in I`),
          " かつ ",
          math(String.raw`y\in I`),
          " と、",
          math(String.raw`I`),
          " が両側イデアルであることから ",
          math(String.raw`x+_A y\in I`),
          " である（",
          ref("def_two_sided_ideal"),
          " の二つ目の条件）。",
          math(String.raw`I`),
          " は ",
          math(String.raw`\mathcal{J}_X`),
          " の任意の元なので、上の同値により ",
          math(String.raw`x+_A y\in\langle X\rangle_A`),
          " である。",
        ],
        [
          math(String.raw`A`),
          " の元を左から掛けても入ること：",
          math(String.raw`x\in I`),
          " と、",
          math(String.raw`I`),
          " が両側イデアルであることから ",
          math(String.raw`a\cdot_A x\in I`),
          " である（",
          ref("def_two_sided_ideal"),
          " の三つ目の条件）。",
          math(String.raw`I`),
          " は ",
          math(String.raw`\mathcal{J}_X`),
          " の任意の元なので、上の同値により ",
          math(String.raw`a\cdot_A x\in\langle X\rangle_A`),
          " である。",
        ],
        [
          math(String.raw`A`),
          " の元を右から掛けても入ること：",
          math(String.raw`x\in I`),
          " と、",
          math(String.raw`I`),
          " が両側イデアルであることから ",
          math(String.raw`x\cdot_A a\in I`),
          " である（",
          ref("def_two_sided_ideal"),
          " の四つ目の条件）。",
          math(String.raw`I`),
          " は ",
          math(String.raw`\mathcal{J}_X`),
          " の任意の元なので、上の同値により ",
          math(String.raw`x\cdot_A a\in\langle X\rangle_A`),
          " である。",
        ],
      ]),
      paragraph([
        "四条件が満たされたので、",
        math(String.raw`\langle X\rangle_A`),
        " は ",
        math(String.raw`A`),
        " の両側イデアルである（",
        ref("def_two_sided_ideal"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_two_sided_ideal_generated_by_subset_contains_subset",
    kind: "claim",
    title: { text: "部分集合が生成する両側イデアルはその部分集合を含む" },
    labels: ["claim_two_sided_ideal_generated_by_subset_contains_subset"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " の部分集合とする。このとき ",
        math(String.raw`X\subseteq\langle X\rangle_A`),
        " である。ここで ",
        math(String.raw`\langle X\rangle_A`),
        " は ",
        math(String.raw`X`),
        " が生成する両側イデアル（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x`),
        " を ",
        math(String.raw`X`),
        " の任意の元とする。",
        math(String.raw`X`),
        " は ",
        math(String.raw`A`),
        " の部分集合なので ",
        math(String.raw`x\in A`),
        " である。",
        math(String.raw`I`),
        " を、",
        math(String.raw`X\subseteq I`),
        " を満たす ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）の任意の一つとする。",
        math(String.raw`x\in X`),
        " と ",
        math(String.raw`X\subseteq I`),
        " から ",
        math(String.raw`x\in I`),
        " である（部分集合の定義）。",
      ]),
      paragraph([
        math(String.raw`I`),
        " は ",
        math(String.raw`X\subseteq I`),
        " を満たす両側イデアルの任意の一つなので、",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`x`),
        " は ",
        math(String.raw`\langle X\rangle_A`),
        " の定義（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）の条件を満たし、",
        math(String.raw`x\in\langle X\rangle_A`),
        " である。",
        math(String.raw`x`),
        " は ",
        math(String.raw`X`),
        " の任意の元なので、",
        math(String.raw`X\subseteq\langle X\rangle_A`),
        " である（部分集合の定義）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset",
    kind: "claim",
    title: { text: "部分集合が生成する両側イデアルは、その部分集合を含むどの両側イデアルにも含まれる" },
    labels: ["claim_two_sided_ideal_generated_by_subset_is_contained_in_every_ideal_containing_subset"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`X`),
        " を ",
        math(String.raw`A`),
        " の部分集合とし、",
        math(String.raw`J`),
        " を ",
        math(String.raw`X\subseteq J`),
        " を満たす ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき ",
        math(String.raw`\langle X\rangle_A\subseteq J`),
        " である。ここで ",
        math(String.raw`\langle X\rangle_A`),
        " は ",
        math(String.raw`X`),
        " が生成する両側イデアル（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a`),
        " を ",
        math(String.raw`\langle X\rangle_A`),
        " の任意の元とする。",
        math(String.raw`\langle X\rangle_A`),
        " の定義（",
        ref("def_two_sided_ideal_generated_by_subset"),
        "）により、",
        math(String.raw`X\subseteq I`),
        " を満たす ",
        math(String.raw`A`),
        " の両側イデアル ",
        math(String.raw`I`),
        " のどれについても ",
        math(String.raw`a\in I`),
        " である。",
        math(String.raw`J`),
        " は ",
        math(String.raw`X\subseteq J`),
        " を満たす ",
        math(String.raw`A`),
        " の両側イデアルなので、この条件を ",
        math(String.raw`I:=J`),
        " に当てて ",
        math(String.raw`a\in J`),
        " である。",
      ]),
      paragraph([
        math(String.raw`a`),
        " は ",
        math(String.raw`\langle X\rangle_A`),
        " の任意の元なので、",
        math(String.raw`\langle X\rangle_A\subseteq J`),
        " である（部分集合の定義）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_kernel_of_algebra_homomorphism_is_two_sided_ideal",
    kind: "claim",
    title: { text: "ℂ-代数の準同型が零へ移す元の全体は両側イデアルである" },
    labels: ["claim_kernel_of_algebra_homomorphism_is_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " と ", math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`), " を ℂ-代数（",
        ref("def_complex_algebra"), "）、", math(String.raw`\varphi:A\to B`), " を ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"),
        "）とし、", math(String.raw`A`), " の部分集合 ", math(String.raw`K_\varphi`), " を次で定める。",
      ]),
      displayMath(String.raw`K_\varphi:=\{\,x\in A:\ \varphi(x)=0_B\,\}`),
      paragraph([
        "このとき ", math(String.raw`K_\varphi`), " は ", math(String.raw`A`), " の両側イデアル（", ref("def_two_sided_ideal"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、", math(String.raw`B`), " の任意の元 ", math(String.raw`c`), " について ", math(String.raw`c\cdot_B 0_B=0_B`), " と ",
        math(String.raw`0_B\cdot_B c=0_B`), " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
c\cdot_B 0_B
&=c\cdot_B\bigl(0_{\mathbb{C}}\ast_B 0_B\bigr)
&&\left(\because\ U_{\mathrm{vec}}(B)\ \text{で}\ 0_{\mathbb{C}}\ast_B 0_B=0_B\text{。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_B\bigl(c\cdot_B 0_B\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right),
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0_B\cdot_B c
&=\bigl(0_{\mathbb{C}}\ast_B 0_B\bigr)\cdot_B c
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=0_{\mathbb{C}}\ast_B\bigl(0_B\cdot_B c\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=0_B
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "両側イデアルの四条件を確かめる。", math(String.raw`x,y`), " を ", math(String.raw`K_\varphi`), " の任意の元、", math(String.raw`a`),
        " を ", math(String.raw`A`), " の任意の元とする。", math(String.raw`x\in K_\varphi`), " と ", math(String.raw`y\in K_\varphi`), " は ",
        math(String.raw`\varphi(x)=0_B`), " と ", math(String.raw`\varphi(y)=0_B`), " のことである。",
      ]),
      paragraph([
        "（加法の単位元を含むこと）", math(String.raw`\varphi`), " は ", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(B)`), " への線型写像なので（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）、",
        math(String.raw`\varphi(0_A)=0_B`), " である（", ref("claim_linear_map_sends_zero_to_zero"), "）。",
      ]),
      paragraph(["（加法で閉じていること）"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x+_A y)
&=\varphi(x)+_B\varphi(y)
&&\left(\because\ \varphi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=0_B+_B 0_B
&&\left(\because\ x,y\in K_\varphi\right)\\
&=0_B
&&\left(\because\ 0_B\ \text{は}\ U_{\mathrm{vec}}(B)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["（左から掛けて閉じていること）"]),
      displayMath(String.raw`\begin{aligned}
\varphi(a\cdot_A x)
&=\varphi(a)\cdot_B\varphi(x)
&&\left(\because\ \varphi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\varphi(a)\cdot_B 0_B
&&\left(\because\ x\in K_\varphi\right)\\
&=0_B
&&\left(\because\ \text{準備の一つ目の等式で}\ c:=\varphi(a)\right).
\end{aligned}`),
      paragraph(["（右から掛けて閉じていること）"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x\cdot_A a)
&=\varphi(x)\cdot_B\varphi(a)
&&\left(\because\ \varphi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=0_B\cdot_B\varphi(a)
&&\left(\because\ x\in K_\varphi\right)\\
&=0_B
&&\left(\because\ \text{準備の二つ目の等式で}\ c:=\varphi(a)\right).
\end{aligned}`),
      paragraph([
        "四条件が満たされたので、", math(String.raw`K_\varphi`), " は ", math(String.raw`A`), " の両側イデアルである（", ref("def_two_sided_ideal"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_congruence_modulo_two_sided_ideal",
    kind: "definition",
    title: { text: "両側イデアルを法とする合同" },
    labels: ["def_congruence_modulo_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`-1_{\mathbb{C}}`),
        " は ",
        math(String.raw`1_{\mathbb{C}}`),
        " の加法の逆元（",
        math(String.raw`1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`\mathbb{C}`),
        " の元）である。",
        math(String.raw`A`),
        " の二つの元 ",
        math(String.raw`a,b`),
        " が",
      ]),
      displayMath(String.raw`a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)\in I`),
      paragraph([
        "を満たすとき、",
        math(String.raw`a`),
        " は ",
        math(String.raw`I`),
        " を法として ",
        math(String.raw`b`),
        " と合同であると言い、",
        math(String.raw`a\equiv_I b`),
        " と書く。",
      ]),
      paragraph([
        "演算はどれも ",
        math(String.raw`A`),
        " のものであり、添字 ",
        math(String.raw`A`),
        " で示す。記号の添字 ",
        math(String.raw`I`),
        " で、どの両側イデアルを法とするかを示す。",
        math(String.raw`b`),
        " を引く操作には、",
        math(String.raw`A`),
        " のスカラー倍で一つに決まる元 ",
        math(String.raw`(-1_{\mathbb{C}})\ast_A b`),
        " を使う。単位元をもつ環の定義（",
        ref("def_unital_ring"),
        "）は加法の逆元の存在だけを条件にしており、逆元を一つの元として名指していないので、",
        math(String.raw`A`),
        " の引き算の記号は置かない。",
        math(String.raw`\equiv_I`),
        " が反射的・対称的・推移的であることは、この定義には含めず、続く主張で示す。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_two_sided_ideal_is_closed_under_scalar_multiplication",
    kind: "claim",
    title: { text: "両側イデアルはスカラー倍で閉じている" },
    labels: ["claim_two_sided_ideal_is_closed_under_scalar_multiplication"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " と ",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\lambda\ast_A x\in I`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\lambda\in\mathbb{C}`),
        " と ",
        math(String.raw`x\in I`),
        " を任意にとる。",
        math(String.raw`I`),
        " は ",
        math(String.raw`A`),
        " の部分集合なので ",
        math(String.raw`x\in A`),
        " である。",
        math(String.raw`a:=\lambda\ast_A 1_A`),
        " と置く。スカラー倍 ",
        math(String.raw`\ast_A`),
        " は ",
        math(String.raw`\mathbb{C}\times A\to A`),
        " の写像なので ",
        math(String.raw`a\in A`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_A x
&=\lambda\ast_A(1_A\cdot_A x)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=(\lambda\ast_A 1_A)\cdot_A x
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=a\cdot_A x
&&\left(\because\ a\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`a\in A`),
        " と ",
        math(String.raw`x\in I`),
        " なので、両側イデアルの三つ目の条件（",
        math(String.raw`A`),
        " の元を左から掛けても ",
        math(String.raw`I`),
        " に入る。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`a\cdot_A x\in I`),
        " である。上の等式により ",
        math(String.raw`\lambda\ast_A x\in I`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_reflexive",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同は反射的である" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_reflexive"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " について ",
        math(String.raw`a\equiv_I a`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a\in A`),
        " を任意にとる。ℂ-線型空間についての定義・主張は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
      ]),
      displayMath(String.raw`\begin{aligned}
a+_A\bigl((-1_{\mathbb{C}})\ast_A a\bigr)
&=(1_{\mathbb{C}}\ast_A a)+_A\bigl((-1_{\mathbb{C}})\ast_A a\bigr)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A a
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\ast_A a
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_congruence_modulo_two_sided_ideal}\right)\\
&=0_A
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=a\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "両側イデアルの一つ目の条件（",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`0_A\in I`),
        " である。上の等式により ",
        math(String.raw`a+_A\bigl((-1_{\mathbb{C}})\ast_A a\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`a\equiv_I a`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_symmetric",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同は対称的である" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_symmetric"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,b`),
        " について、",
        math(String.raw`a\equiv_I b`),
        " ならば ",
        math(String.raw`b\equiv_I a`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b\in A`),
        " を ",
        math(String.raw`a\equiv_I b`),
        " を満たすようにとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " である。ℂ-線型空間についての定義は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
      ]),
      displayMath(String.raw`\begin{aligned}
b+_A\bigl((-1_{\mathbb{C}})\ast_A a\bigr)
&=\bigl((-1_{\mathbb{C}})\ast_A a\bigr)+_A b
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A a\bigr)+_A(1_{\mathbb{C}}\ast_A b)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A a\bigr)+_A\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A b\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の中で}\ (-1_{\mathbb{C}})\cdot_{\mathbb{C}}(-1_{\mathbb{C}})=1_{\mathbb{C}}\right)\\
&=\bigl((-1_{\mathbb{C}})\ast_A a\bigr)+_A\Bigl((-1_{\mathbb{C}})\ast_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(-1_{\mathbb{C}})\ast_A\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(-1_{\mathbb{C}})\ast_A x
&&\left(\because\ x\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`-1_{\mathbb{C}}\in\mathbb{C}`),
        " と ",
        math(String.raw`x\in I`),
        " なので、両側イデアルはスカラー倍で閉じている（",
        math(String.raw`\lambda:=-1_{\mathbb{C}}`),
        "。",
        ref("claim_two_sided_ideal_is_closed_under_scalar_multiplication"),
        "）ことにより ",
        math(String.raw`(-1_{\mathbb{C}})\ast_A x\in I`),
        " である。上の等式により ",
        math(String.raw`b+_A\bigl((-1_{\mathbb{C}})\ast_A a\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`b\equiv_I a`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_transitive",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同は推移的である" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_transitive"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,b,c`),
        " について、",
        math(String.raw`a\equiv_I b`),
        " かつ ",
        math(String.raw`b\equiv_I c`),
        " ならば ",
        math(String.raw`a\equiv_I c`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b,c\in A`),
        " を ",
        math(String.raw`a\equiv_I b`),
        " かつ ",
        math(String.raw`b\equiv_I c`),
        " を満たすようにとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)`),
        " と ",
        math(String.raw`y:=b+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " かつ ",
        math(String.raw`y\in I`),
        " である。ℂ-線型空間についての定義・主張は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。準備として、",
        math(String.raw`(-1_{\mathbb{C}})\ast_A b`),
        " と ",
        math(String.raw`b`),
        " の和を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((-1_{\mathbb{C}})\ast_A b\bigr)+_A b
&=\bigl((-1_{\mathbb{C}})\ast_A b\bigr)+_A(1_{\mathbb{C}}\ast_A b)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\ast_A b
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A b
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=0_{\mathbb{C}}\ast_A b
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_congruence_modulo_two_sided_ideal}\right)\\
&=0_A
&&\left(\because\ \text{零のスカラー倍は零ベクトル（}x=b\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "これを使って、",
        math(String.raw`a`),
        " から ",
        math(String.raw`c`),
        " を引いた元を ",
        math(String.raw`x`),
        " と ",
        math(String.raw`y`),
        " の和で書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
a+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)
&=(a+_A 0_A)+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(a+_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A b\bigr)+_A b\Bigr)\Bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)
&&\left(\because\ \text{上の準備の等式}\right)\\
&=\Bigl(\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)\Bigr)+_A b\Bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A b\bigr)\Bigr)+_A\Bigl(b+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=x+_A y
&&\left(\because\ x\ \text{と}\ y\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in I`),
        " と ",
        math(String.raw`y\in I`),
        " なので、両側イデアルの二つ目の条件（加法で閉じている。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`x+_A y\in I`),
        " である。上の等式により ",
        math(String.raw`a+_A\bigl((-1_{\mathbb{C}})\ast_A c\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`a\equiv_I c`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_residue_class_modulo_two_sided_ideal",
    kind: "definition",
    title: { text: "両側イデアルを法とする剰余類" },
    labels: ["def_residue_class_modulo_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a`),
        " について、",
        math(String.raw`A`),
        " の部分集合",
      ]),
      displayMath(String.raw`[a]_I:=\{\,b\in A:\ a\equiv_I b\,\}`),
      paragraph([
        "を、",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`a`),
        " の剰余類と呼ぶ。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
      paragraph([
        math(String.raw`[a]_I`),
        " は ",
        math(String.raw`A`),
        " の元ではなく ",
        math(String.raw`A`),
        " の部分集合であり、",
        math(String.raw`a`),
        " と ",
        math(String.raw`[a]_I`),
        " を同じものとして扱わない。",
        math(String.raw`a`),
        " から ",
        math(String.raw`[a]_I`),
        " へ移るときは、続く射影の定義で名前を付ける写像を通す。",
        "記号の添字 ",
        math(String.raw`I`),
        " で、どの両側イデアルを法とするかを示す。",
        "二つの剰余類が等しいことと代表が合同であることの同値は、この定義には含めず、続く主張で示す。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_residue_classes_are_equal_iff_congruent",
    kind: "claim",
    title: { text: "剰余類が等しいことと代表が合同であることの同値" },
    labels: ["claim_residue_classes_are_equal_iff_congruent"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,b`),
        " について、",
      ]),
      displayMath(String.raw`[a]_I=[b]_I\iff a\equiv_I b`),
      paragraph([
        "である。ここで ",
        math(String.raw`[a]_I,[b]_I`),
        " は ",
        math(String.raw`I`),
        " を法とする剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）であり、左辺の等号は ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b\in A`),
        " をとる。剰余類の定義（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）により、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`c`),
        " について次の二つが成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
c\in[a]_I&\iff a\equiv_I c
&&\left(\because\ \blkref{def_residue_class_modulo_two_sided_ideal}\right),\\
c\in[b]_I&\iff b\equiv_I c
&&\left(\because\ \blkref{def_residue_class_modulo_two_sided_ideal}\right).
\end{aligned}`),
      paragraph([
        "（",
        math(String.raw`\Rightarrow`),
        "）",
        math(String.raw`[a]_I=[b]_I`),
        " と仮定する。合同の反射性（",
        ref("claim_congruence_modulo_two_sided_ideal_is_reflexive"),
        "）を ",
        math(String.raw`b`),
        " に当てて ",
        math(String.raw`b\equiv_I b`),
        " であり、上の二つ目の同値（",
        math(String.raw`c:=b`),
        "）により ",
        math(String.raw`b\in[b]_I`),
        " である。仮定 ",
        math(String.raw`[a]_I=[b]_I`),
        " により ",
        math(String.raw`b\in[a]_I`),
        " であり、上の一つ目の同値（",
        math(String.raw`c:=b`),
        "）により ",
        math(String.raw`a\equiv_I b`),
        " である。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Leftarrow`),
        "）",
        math(String.raw`a\equiv_I b`),
        " と仮定する。合同の対称性（",
        ref("claim_congruence_modulo_two_sided_ideal_is_symmetric"),
        "）により ",
        math(String.raw`b\equiv_I a`),
        " でもある。",
        math(String.raw`[a]_I\subseteq[b]_I`),
        " と ",
        math(String.raw`[b]_I\subseteq[a]_I`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`[a]_I\subseteq[b]_I`),
        " を示す。",
        math(String.raw`c\in[a]_I`),
        " をとる。上の一つ目の同値により ",
        math(String.raw`a\equiv_I c`),
        " である。",
        math(String.raw`b\equiv_I a`),
        " と ",
        math(String.raw`a\equiv_I c`),
        " に合同の推移性（",
        ref("claim_congruence_modulo_two_sided_ideal_is_transitive"),
        "。",
        math(String.raw`(a,b,c)`),
        " を ",
        math(String.raw`(b,a,c)`),
        " に当てる）を当てて ",
        math(String.raw`b\equiv_I c`),
        " であり、上の二つ目の同値により ",
        math(String.raw`c\in[b]_I`),
        " である。",
      ]),
      paragraph([
        math(String.raw`[b]_I\subseteq[a]_I`),
        " を示す。",
        math(String.raw`c\in[b]_I`),
        " をとる。上の二つ目の同値により ",
        math(String.raw`b\equiv_I c`),
        " である。",
        math(String.raw`a\equiv_I b`),
        " と ",
        math(String.raw`b\equiv_I c`),
        " に合同の推移性（",
        ref("claim_congruence_modulo_two_sided_ideal_is_transitive"),
        "）を当てて ",
        math(String.raw`a\equiv_I c`),
        " であり、上の一つ目の同値により ",
        math(String.raw`c\in[a]_I`),
        " である。",
      ]),
      paragraph([
        "二つの包含により、",
        math(String.raw`A`),
        " の部分集合として ",
        math(String.raw`[a]_I=[b]_I`),
        " である（二つの集合は、互いに他方に含まれるとき等しい）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_quotient_set_modulo_two_sided_ideal",
    kind: "definition",
    title: { text: "両側イデアルを法とする商集合" },
    labels: ["def_quotient_set_modulo_two_sided_ideal"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。集合",
      ]),
      displayMath(String.raw`A/I:=\{\,[a]_I:\ a\in A\,\}`),
      paragraph([
        "を、",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`A`),
        " の商集合と呼ぶ。ここで ",
        math(String.raw`[a]_I`),
        " は ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`a`),
        " の剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）である。",
        math(String.raw`A/I`),
        " の元は ",
        math(String.raw`A`),
        " の部分集合であり、",
        math(String.raw`A`),
        " の元ではない。",
        "集合 ",
        math(String.raw`X`),
        " が ",
        math(String.raw`A/I`),
        " の元であるとは、",
        math(String.raw`A`),
        " のある元 ",
        math(String.raw`a`),
        " について ",
        math(String.raw`X=[a]_I`),
        " となることである。",
      ]),
      paragraph([
        "この定義は ",
        math(String.raw`A/I`),
        " を集合として定めるだけで、",
        math(String.raw`A/I`),
        " の上の加法・乗法・スカラー倍・零元・単位元は定めない。",
        "それらは続く商代数の演算の定義で、代表のとり方によらないことを示してから定める。",
        math(String.raw`A`),
        " の元から ",
        math(String.raw`A/I`),
        " の元へは、続く射影の定義で名前を付ける写像を通して移る。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_projection_onto_quotient_set",
    kind: "definition",
    title: { text: "商集合への射影" },
    labels: ["def_projection_onto_quotient_set"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。写像",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I&:A\to A/I,\\
\pi_I(a)&:=[a]_I\qquad(a\in A)
\end{aligned}`),
      paragraph([
        "を、",
        math(String.raw`I`),
        " を法とする商集合への射影と呼ぶ。ここで ",
        math(String.raw`A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`A`),
        " の商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`[a]_I`),
        " は ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`a`),
        " の剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）である。",
      ]),
      paragraph([
        "値 ",
        math(String.raw`[a]_I`),
        " が終域 ",
        math(String.raw`A/I`),
        " に属することは、商集合の定義（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）で ",
        math(String.raw`X:=[a]_I`),
        " の代表に ",
        math(String.raw`a`),
        " 自身をとれば成り立つ。",
        math(String.raw`\pi_I(a)`),
        " は ",
        math(String.raw`a`),
        " だけで決まる式で与えるので、代表のとり方によらないことを示す必要はない。",
      ]),
      paragraph([
        math(String.raw`A`),
        " の元から ",
        math(String.raw`A/I`),
        " の元へは、この写像 ",
        math(String.raw`\pi_I`),
        " だけを通して移り、",
        math(String.raw`a`),
        " と ",
        math(String.raw`\pi_I(a)`),
        " を同じものとして扱わない。",
        "この定義は ",
        math(String.raw`\pi_I`),
        " を集合の間の写像として定めるだけで、",
        math(String.raw`\pi_I`),
        " が全射であること、",
        math(String.raw`A/I`),
        " の上の演算を保つことは、続く主張で示す。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_set_is_surjective",
    kind: "claim",
    title: { text: "商集合への射影は全射である" },
    labels: ["claim_projection_onto_quotient_set_is_surjective"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`A`),
        " の商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の任意の元 ",
        math(String.raw`X`),
        " について、",
      ]),
      displayMath(String.raw`\pi_I(a)=X`),
      paragraph([
        "を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a`),
        " が存在する。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）であり、等号は ",
        math(String.raw`A/I`),
        " の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X\in A/I`),
        " をとる。商集合の定義（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）により、",
        math(String.raw`X=[a]_I`),
        " を満たす ",
        math(String.raw`a\in A`),
        " がある。この ",
        math(String.raw`a`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a)&=[a]_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=X
&&\left(\because\ X=[a]_I\right)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`X`),
        " は ",
        math(String.raw`A/I`),
        " の任意の元であったから、主張が成り立つ。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同は加法と両立する" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a',b,b'`),
        " について、",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " ならば ",
        math(String.raw`a+_A b\equiv_I a'+_A b'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,a',b,b'\in A`),
        " を ",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " を満たすようにとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)`),
        " と ",
        math(String.raw`y:=b+_A\bigl((-1_{\mathbb{C}})\ast_A b'\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " かつ ",
        math(String.raw`y\in I`),
        " である。ℂ-線型空間についての定義は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
        math(String.raw`u:=(-1_{\mathbb{C}})\ast_A a'`),
        " と ",
        math(String.raw`v:=(-1_{\mathbb{C}})\ast_A b'`),
        " と置く。スカラー倍 ",
        math(String.raw`\ast_A`),
        " は ",
        math(String.raw`\mathbb{C}\times A\to A`),
        " の写像なので ",
        math(String.raw`u,v\in A`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a+_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'+_A b')\bigr)
&=(a+_A b)+_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A b'\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(a+_A b)+_A(u+_A v)
&&\left(\because\ u\ \text{と}\ v\ \text{の定義}\right)\\
&=a+_A\bigl(b+_A(u+_A v)\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=a+_A\bigl((b+_A u)+_A v\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=a+_A\bigl((u+_A b)+_A v\bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=a+_A\bigl(u+_A(b+_A v)\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(a+_A u)+_A(b+_A v)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)\Bigr)+_A\Bigl(b+_A\bigl((-1_{\mathbb{C}})\ast_A b'\bigr)\Bigr)
&&\left(\because\ u\ \text{と}\ v\ \text{の定義}\right)\\
&=x+_A y
&&\left(\because\ x\ \text{と}\ y\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in I`),
        " と ",
        math(String.raw`y\in I`),
        " なので、両側イデアルの二つ目の条件（加法で閉じている。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`x+_A y\in I`),
        " である。上の等式により ",
        math(String.raw`(a+_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'+_A b')\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`a+_A b\equiv_I a'+_A b'`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同は乗法と両立する" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a',b,b'`),
        " について、",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " ならば ",
        math(String.raw`a\cdot_A b\equiv_I a'\cdot_A b'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,a',b,b'\in A`),
        " を ",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " を満たすようにとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)`),
        " と ",
        math(String.raw`y:=b+_A\bigl((-1_{\mathbb{C}})\ast_A b'\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " かつ ",
        math(String.raw`y\in I`),
        " である。ℂ-線型空間についての定義・主張は ",
        math(String.raw`U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        " に、単位元をもつ環についての定義は ",
        math(String.raw`U_{\mathrm{ring}}(A)=(A,+_A,\cdot_A,0_A,1_A)`),
        " に当てる（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）。",
        math(String.raw`p:=a'\cdot_A b`),
        " と置く。乗法 ",
        math(String.raw`\cdot_A`),
        " は ",
        math(String.raw`A\times A\to A`),
        " の写像なので ",
        math(String.raw`p\in A`),
        " である。準備として、",
        math(String.raw`(-1_{\mathbb{C}})\ast_A p`),
        " と ",
        math(String.raw`p`),
        " の和を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((-1_{\mathbb{C}})\ast_A p\bigr)+_A p
&=\bigl((-1_{\mathbb{C}})\ast_A p\bigr)+_A(1_{\mathbb{C}}\ast_A p)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\ast_A p
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A p
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=0_{\mathbb{C}}\ast_A p
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_congruence_modulo_two_sided_ideal}\right)\\
&=0_A
&&\left(\because\ \text{零のスカラー倍は零ベクトル（ベクトルに}\ p\ \text{を当てる）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "これを使って、",
        math(String.raw`a\cdot_A b`),
        " から ",
        math(String.raw`a'\cdot_A b'`),
        " を引いた元を ",
        math(String.raw`x\cdot_A b`),
        " と ",
        math(String.raw`a'\cdot_A y`),
        " の和で書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)
&=\bigl((a\cdot_A b)+_A 0_A\bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl((a\cdot_A b)+_A\Bigl(\bigl((-1_{\mathbb{C}})\ast_A p\bigr)+_A p\Bigr)\Bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)
&&\left(\because\ \text{上の準備の等式}\right)\\
&=\Bigl(\Bigl((a\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A p\bigr)\Bigr)+_A p\Bigr)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl((a\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A p\bigr)\Bigr)+_A\Bigl(p+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)\Bigr)
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl((a\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b)\bigr)\Bigr)+_A\Bigl((a'\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)\Bigr)
&&\left(\because\ p\ \text{の定義}\right)\\
&=\Bigl((a\cdot_A b)+_A\bigl(((-1_{\mathbb{C}})\ast_A a')\cdot_A b\bigr)\Bigr)+_A\Bigl((a'\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\Bigl((a\cdot_A b)+_A\bigl(((-1_{\mathbb{C}})\ast_A a')\cdot_A b\bigr)\Bigr)+_A\Bigl((a'\cdot_A b)+_A\bigl(a'\cdot_A((-1_{\mathbb{C}})\ast_A b')\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\Bigl(\bigl(a+_A((-1_{\mathbb{C}})\ast_A a')\bigr)\cdot_A b\Bigr)+_A\Bigl((a'\cdot_A b)+_A\bigl(a'\cdot_A((-1_{\mathbb{C}})\ast_A b')\bigr)\Bigr)
&&\left(\because\ \text{分配法則（和に右から掛ける側）。}\blkref{def_unital_ring}\right)\\
&=\Bigl(\bigl(a+_A((-1_{\mathbb{C}})\ast_A a')\bigr)\cdot_A b\Bigr)+_A\Bigl(a'\cdot_A\bigl(b+_A((-1_{\mathbb{C}})\ast_A b')\bigr)\Bigr)
&&\left(\because\ \text{分配法則（和に左から掛ける側）。}\blkref{def_unital_ring}\right)\\
&=(x\cdot_A b)+_A(a'\cdot_A y)
&&\left(\because\ x\ \text{と}\ y\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in I`),
        " と ",
        math(String.raw`b\in A`),
        " なので、両側イデアルの四つ目の条件（",
        math(String.raw`A`),
        " の元を右から掛けても ",
        math(String.raw`I`),
        " に入る。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`x\cdot_A b\in I`),
        " である。",
        math(String.raw`a'\in A`),
        " と ",
        math(String.raw`y\in I`),
        " なので、両側イデアルの三つ目の条件（",
        math(String.raw`A`),
        " の元を左から掛けても ",
        math(String.raw`I`),
        " に入る。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`a'\cdot_A y\in I`),
        " である。両側イデアルの二つ目の条件（加法で閉じている。",
        ref("def_two_sided_ideal"),
        "）により ",
        math(String.raw`(x\cdot_A b)+_A(a'\cdot_A y)\in I`),
        " である。上の等式により ",
        math(String.raw`(a\cdot_A b)+_A\bigl((-1_{\mathbb{C}})\ast_A(a'\cdot_A b')\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`a\cdot_A b\equiv_I a'\cdot_A b'`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication",
    kind: "claim",
    title: { text: "両側イデアルを法とする合同はスカラー倍と両立する" },
    labels: ["claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " と ",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a'`),
        " について、",
        math(String.raw`a\equiv_I a'`),
        " ならば ",
        math(String.raw`\lambda\ast_A a\equiv_I \lambda\ast_A a'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\lambda\in\mathbb{C}`),
        " と、",
        math(String.raw`a\equiv_I a'`),
        " を満たす ",
        math(String.raw`a,a'\in A`),
        " をとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " である。ℂ-線型空間についての定義は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\lambda\ast_A a)+_A\bigl((-1_{\mathbb{C}})\ast_A(\lambda\ast_A a')\bigr)
&=(\lambda\ast_A a)+_A\Bigl(\bigl((-1_{\mathbb{C}})\cdot_{\mathbb{C}}\lambda\bigr)\ast_A a'\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\ast_A a)+_A\Bigl(\bigl(\lambda\cdot_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_A a'\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=(\lambda\ast_A a)+_A\Bigl(\lambda\ast_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)\Bigr)
&&\left(\because\ \text{スカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_A\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)\Bigr)
&&\left(\because\ \text{ベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_A x
&&\left(\because\ x\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in I`),
        " なので、両側イデアルがスカラー倍で閉じていること（",
        ref("claim_two_sided_ideal_is_closed_under_scalar_multiplication"),
        "）により ",
        math(String.raw`\lambda\ast_A x\in I`),
        " である。上の等式により ",
        math(String.raw`(\lambda\ast_A a)+_A\bigl((-1_{\mathbb{C}})\ast_A(\lambda\ast_A a')\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`\lambda\ast_A a\equiv_I \lambda\ast_A a'`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_addition_does_not_depend_on_representatives",
    kind: "claim",
    title: { text: "商集合の上の加法は代表のとり方によらない" },
    labels: ["claim_quotient_addition_does_not_depend_on_representatives"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a',b,b'`),
        " について、",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " かつ ",
        math(String.raw`\pi_I(b)=\pi_I(b')`),
        " ならば",
      ]),
      displayMath(String.raw`\pi_I(a+_A b)=\pi_I(a'+_A b')`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）であり、等号はどれも ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,a',b,b'\in A`),
        " を ",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " かつ ",
        math(String.raw`\pi_I(b)=\pi_I(b')`),
        " を満たすようにとる。まず ",
        math(String.raw`[a]_I=[a']_I`),
        " と ",
        math(String.raw`[b]_I=[b']_I`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
[a]_I&=\pi_I(a)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=\pi_I(a')
&&\left(\because\ \text{仮定}\ \pi_I(a)=\pi_I(a')\right)\\
&=[a']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right),\\[4pt]
[b]_I&=\pi_I(b)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=\pi_I(b')
&&\left(\because\ \text{仮定}\ \pi_I(b)=\pi_I(b')\right)\\
&=[b']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right).
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`[a]_I`),
        " などは ",
        math(String.raw`I`),
        " を法とする剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）である。剰余類が等しいことと代表が合同であることの同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Rightarrow`),
        " を二つの等式に当てて、",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。合同が加法と両立すること（",
        ref("claim_congruence_modulo_two_sided_ideal_is_compatible_with_addition"),
        "）により ",
        math(String.raw`a+_A b\equiv_I a'+_A b'`),
        " であり、同じ同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Leftarrow`),
        " を、その主張の ",
        math(String.raw`a`),
        " に ",
        math(String.raw`a+_A b`),
        "、",
        math(String.raw`b`),
        " に ",
        math(String.raw`a'+_A b'`),
        " を当てて使い、",
        math(String.raw`[a+_A b]_I=[a'+_A b']_I`),
        " である。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a+_A b)&=[a+_A b]_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=[a'+_A b']_I
&&\left(\because\ [a+_A b]_I=[a'+_A b']_I\right)\\
&=\pi_I(a'+_A b')
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_multiplication_does_not_depend_on_representatives",
    kind: "claim",
    title: { text: "商集合の上の乗法は代表のとり方によらない" },
    labels: ["claim_quotient_multiplication_does_not_depend_on_representatives"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a',b,b'`),
        " について、",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " かつ ",
        math(String.raw`\pi_I(b)=\pi_I(b')`),
        " ならば",
      ]),
      displayMath(String.raw`\pi_I(a\cdot_A b)=\pi_I(a'\cdot_A b')`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）であり、等号はどれも ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,a',b,b'\in A`),
        " を ",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " かつ ",
        math(String.raw`\pi_I(b)=\pi_I(b')`),
        " を満たすようにとる。まず ",
        math(String.raw`[a]_I=[a']_I`),
        " と ",
        math(String.raw`[b]_I=[b']_I`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
[a]_I&=\pi_I(a)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=\pi_I(a')
&&\left(\because\ \text{仮定}\ \pi_I(a)=\pi_I(a')\right)\\
&=[a']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right),\\[4pt]
[b]_I&=\pi_I(b)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=\pi_I(b')
&&\left(\because\ \text{仮定}\ \pi_I(b)=\pi_I(b')\right)\\
&=[b']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right).
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`[a]_I`),
        " などは ",
        math(String.raw`I`),
        " を法とする剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）である。剰余類が等しいことと代表が合同であることの同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Rightarrow`),
        " を二つの等式に当てて、",
        math(String.raw`a\equiv_I a'`),
        " かつ ",
        math(String.raw`b\equiv_I b'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。合同が乗法と両立すること（",
        ref("claim_congruence_modulo_two_sided_ideal_is_compatible_with_multiplication"),
        "）により ",
        math(String.raw`a\cdot_A b\equiv_I a'\cdot_A b'`),
        " であり、同じ同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Leftarrow`),
        " を、その主張の ",
        math(String.raw`a`),
        " に ",
        math(String.raw`a\cdot_A b`),
        "、",
        math(String.raw`b`),
        " に ",
        math(String.raw`a'\cdot_A b'`),
        " を当てて使い、",
        math(String.raw`[a\cdot_A b]_I=[a'\cdot_A b']_I`),
        " である。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a\cdot_A b)&=[a\cdot_A b]_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=[a'\cdot_A b']_I
&&\left(\because\ [a\cdot_A b]_I=[a'\cdot_A b']_I\right)\\
&=\pi_I(a'\cdot_A b')
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_scalar_multiplication_does_not_depend_on_representatives",
    kind: "claim",
    title: { text: "商集合の上のスカラー倍は代表のとり方によらない" },
    labels: ["claim_quotient_scalar_multiplication_does_not_depend_on_representatives"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " と ",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a'`),
        " について、",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " ならば",
      ]),
      displayMath(String.raw`\pi_I(\lambda\ast_A a)=\pi_I(\lambda\ast_A a')`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）であり、等号はどれも ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\lambda\in\mathbb{C}`),
        " と、",
        math(String.raw`\pi_I(a)=\pi_I(a')`),
        " を満たす ",
        math(String.raw`a,a'\in A`),
        " をとる。まず ",
        math(String.raw`[a]_I=[a']_I`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
[a]_I&=\pi_I(a)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=\pi_I(a')
&&\left(\because\ \text{仮定}\ \pi_I(a)=\pi_I(a')\right)\\
&=[a']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right).
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`[a]_I`),
        " などは ",
        math(String.raw`I`),
        " を法とする剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）である。剰余類が等しいことと代表が合同であることの同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Rightarrow`),
        " をこの等式に当てて、",
        math(String.raw`a\equiv_I a'`),
        " である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。合同がスカラー倍と両立すること（",
        ref("claim_congruence_modulo_two_sided_ideal_is_compatible_with_scalar_multiplication"),
        "）により ",
        math(String.raw`\lambda\ast_A a\equiv_I \lambda\ast_A a'`),
        " であり、同じ同値（",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）の ",
        math(String.raw`\Leftarrow`),
        " を、その主張の ",
        math(String.raw`a`),
        " に ",
        math(String.raw`\lambda\ast_A a`),
        "、",
        math(String.raw`b`),
        " に ",
        math(String.raw`\lambda\ast_A a'`),
        " を当てて使い、",
        math(String.raw`[\lambda\ast_A a]_I=[\lambda\ast_A a']_I`),
        " である。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(\lambda\ast_A a)&=[\lambda\ast_A a]_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=[\lambda\ast_A a']_I
&&\left(\because\ [\lambda\ast_A a]_I=[\lambda\ast_A a']_I\right)\\
&=\pi_I(\lambda\ast_A a')
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_quotient_algebra_operations",
    kind: "definition",
    title: { text: "商集合の上の演算（商代数の演算）" },
    labels: ["def_quotient_algebra_operations"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`A`),
        " の商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`\pi_I:A\to A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）とする。",
        math(String.raw`X,Y`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とし、射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により ",
        math(String.raw`\pi_I(a)=X`),
        " かつ ",
        math(String.raw`\pi_I(b)=Y`),
        " を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a,b`),
        " をとる。写像 ",
        math(String.raw`+_{A/I}:A/I\times A/I\to A/I`),
        "、",
        math(String.raw`\cdot_{A/I}:A/I\times A/I\to A/I`),
        "、",
        math(String.raw`\ast_{A/I}:\mathbb{C}\times A/I\to A/I`),
        " と、元 ",
        math(String.raw`0_{A/I},1_{A/I}\in A/I`),
        " を",
      ]),
      displayMath(String.raw`\begin{aligned}
X+_{A/I}Y&:=\pi_I(a+_A b),\\
X\cdot_{A/I}Y&:=\pi_I(a\cdot_A b),\\
\lambda\ast_{A/I}X&:=\pi_I(\lambda\ast_A a),\\
0_{A/I}&:=\pi_I(0_A),\\
1_{A/I}&:=\pi_I(1_A)
\end{aligned}`),
      paragraph([
        "で定める。右辺はどれも ",
        math(String.raw`\pi_I`),
        " の値なので ",
        math(String.raw`A/I`),
        " に属する。",
      ]),
      paragraph([
        "右辺は代表 ",
        math(String.raw`a,b`),
        " のとり方によらない。",
        math(String.raw`\pi_I(a')=X`),
        " かつ ",
        math(String.raw`\pi_I(b')=Y`),
        " を満たす別の ",
        math(String.raw`a',b'\in A`),
        " をとると、",
        math(String.raw`\pi_I(a)=X=\pi_I(a')`),
        " かつ ",
        math(String.raw`\pi_I(b)=Y=\pi_I(b')`),
        " である。加法については商集合の上の加法が代表のとり方によらないこと（",
        ref("claim_quotient_addition_does_not_depend_on_representatives"),
        "）により ",
        math(String.raw`\pi_I(a+_A b)=\pi_I(a'+_A b')`),
        "、乗法については商集合の上の乗法が代表のとり方によらないこと（",
        ref("claim_quotient_multiplication_does_not_depend_on_representatives"),
        "）により ",
        math(String.raw`\pi_I(a\cdot_A b)=\pi_I(a'\cdot_A b')`),
        "、スカラー倍については商集合の上のスカラー倍が代表のとり方によらないこと（",
        ref("claim_quotient_scalar_multiplication_does_not_depend_on_representatives"),
        "）により ",
        math(String.raw`\pi_I(\lambda\ast_A a)=\pi_I(\lambda\ast_A a')`),
        " である。",
        math(String.raw`0_{A/I}`),
        " と ",
        math(String.raw`1_{A/I}`),
        " は代表を選ばない式で与えるので、代表のとり方によらないことを示す必要はない。",
      ]),
      paragraph([
        "この定義は組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
        " を定めるだけである。この組が ℂ-代数（",
        ref("def_complex_algebra"),
        "）の公理を満たすこと、",
        math(String.raw`\pi_I`),
        " がこれらの演算を保つことは、続く主張で示す。",
        math(String.raw`A`),
        " の演算と ",
        math(String.raw`A/I`),
        " の演算は別の写像なので、添字 ",
        math(String.raw`A`),
        " と ",
        math(String.raw`A/I`),
        " で書き分ける。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_set_preserves_addition",
    kind: "claim",
    title: { text: "商集合への射影は加法を保つ" },
    labels: ["claim_projection_onto_quotient_set_preserves_addition"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,b`),
        " について",
      ]),
      displayMath(String.raw`\pi_I(a+_A b)=\pi_I(a)+_{A/I}\pi_I(b)`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`+_{A/I}`),
        " は商集合の上の加法（",
        ref("def_quotient_algebra_operations"),
        "）であり、等号は ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b\in A`),
        " をとり、",
        math(String.raw`X:=\pi_I(a)`),
        "、",
        math(String.raw`Y:=\pi_I(b)`),
        " と置く。",
        math(String.raw`X,Y`),
        " は ",
        math(String.raw`A/I`),
        " の元であり、",
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " は ",
        math(String.raw`\pi_I(a)=X`),
        " かつ ",
        math(String.raw`\pi_I(b)=Y`),
        " を満たすので、商集合の上の演算の定義（",
        ref("def_quotient_algebra_operations"),
        "）の代表に ",
        math(String.raw`a,b`),
        " 自身をとれる。その定義で右辺が代表のとり方によらないことは、商集合の上の加法が代表のとり方によらないこと（",
        ref("claim_quotient_addition_does_not_depend_on_representatives"),
        "）で示されている。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a+_A b)&=X+_{A/I}Y
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{の加法、代表}\ a,b\right)\\
&=\pi_I(a)+_{A/I}\pi_I(b)
&&\left(\because\ X=\pi_I(a),\ Y=\pi_I(b)\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_set_preserves_multiplication",
    kind: "claim",
    title: { text: "商集合への射影は乗法を保つ" },
    labels: ["claim_projection_onto_quotient_set_preserves_multiplication"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,b`),
        " について",
      ]),
      displayMath(String.raw`\pi_I(a\cdot_A b)=\pi_I(a)\cdot_{A/I}\pi_I(b)`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`\cdot_{A/I}`),
        " は商集合の上の乗法（",
        ref("def_quotient_algebra_operations"),
        "）であり、等号は ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,b\in A`),
        " をとり、",
        math(String.raw`X:=\pi_I(a)`),
        "、",
        math(String.raw`Y:=\pi_I(b)`),
        " と置く。",
        math(String.raw`X,Y`),
        " は ",
        math(String.raw`A/I`),
        " の元であり、",
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " は ",
        math(String.raw`\pi_I(a)=X`),
        " かつ ",
        math(String.raw`\pi_I(b)=Y`),
        " を満たすので、商集合の上の演算の定義（",
        ref("def_quotient_algebra_operations"),
        "）の代表に ",
        math(String.raw`a,b`),
        " 自身をとれる。その定義で右辺が代表のとり方によらないことは、商集合の上の乗法が代表のとり方によらないこと（",
        ref("claim_quotient_multiplication_does_not_depend_on_representatives"),
        "）で示されている。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a\cdot_A b)&=X\cdot_{A/I}Y
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{の乗法、代表}\ a,b\right)\\
&=\pi_I(a)\cdot_{A/I}\pi_I(b)
&&\left(\because\ X=\pi_I(a),\ Y=\pi_I(b)\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_set_preserves_scalar_multiplication",
    kind: "claim",
    title: { text: "商集合への射影はスカラー倍を保つ" },
    labels: ["claim_projection_onto_quotient_set_preserves_scalar_multiplication"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`\mathbb{C}`),
        " の任意の元 ",
        math(String.raw`\lambda`),
        " と ",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " について",
      ]),
      displayMath(String.raw`\pi_I(\lambda\ast_A a)=\lambda\ast_{A/I}\pi_I(a)`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`\ast_{A/I}`),
        " は商集合の上のスカラー倍（",
        ref("def_quotient_algebra_operations"),
        "）であり、等号は ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\lambda\in\mathbb{C}`),
        " と ",
        math(String.raw`a\in A`),
        " をとり、",
        math(String.raw`X:=\pi_I(a)`),
        " と置く。",
        math(String.raw`X`),
        " は ",
        math(String.raw`A/I`),
        " の元であり、",
        math(String.raw`a`),
        " は ",
        math(String.raw`\pi_I(a)=X`),
        " を満たすので、商集合の上の演算の定義（",
        ref("def_quotient_algebra_operations"),
        "）の代表に ",
        math(String.raw`a`),
        " 自身をとれる。その定義で右辺が代表のとり方によらないことは、商集合の上のスカラー倍が代表のとり方によらないこと（",
        ref("claim_quotient_scalar_multiplication_does_not_depend_on_representatives"),
        "）で示されている。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(\lambda\ast_A a)&=\lambda\ast_{A/I}X
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{のスカラー倍、代表}\ a\right)\\
&=\lambda\ast_{A/I}\pi_I(a)
&&\left(\because\ X=\pi_I(a)\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_set_operations_form_unital_ring",
    kind: "claim",
    title: { text: "商集合の上の演算の組は単位元をもつ環である" },
    labels: ["claim_quotient_set_operations_form_unital_ring"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、組",
      ]),
      displayMath(String.raw`(A/I,+_{A/I},\cdot_{A/I},0_{A/I},1_{A/I})`),
      paragraph([
        "は単位元をもつ環（",
        ref("def_unital_ring"),
        "）である。ここで ",
        math(String.raw`A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`+_{A/I},\ \cdot_{A/I},\ 0_{A/I},\ 1_{A/I}`),
        " は商集合の上の加法・乗法・零元・単位元（",
        ref("def_quotient_algebra_operations"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "商集合の上の演算の定義（",
        ref("def_quotient_algebra_operations"),
        "）により、",
        math(String.raw`+_{A/I}`),
        " と ",
        math(String.raw`\cdot_{A/I}`),
        " は ",
        math(String.raw`A/I\times A/I\to A/I`),
        " の写像、",
        math(String.raw`0_{A/I}`),
        " と ",
        math(String.raw`1_{A/I}`),
        " は ",
        math(String.raw`A/I`),
        " の元である。残りは単位元をもつ環（",
        ref("def_unital_ring"),
        "）の七つの条件である。",
        math(String.raw`\pi_I:A\to A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）とする。",
        math(String.raw`X,Y,Z`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元とし、射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により ",
        math(String.raw`\pi_I(a)=X`),
        "、",
        math(String.raw`\pi_I(b)=Y`),
        "、",
        math(String.raw`\pi_I(c)=Z`),
        " を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a,b,c`),
        " をとる。",
        math(String.raw`A`),
        " の環の公理は、",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
      ]),
      paragraph(["加法の結合法則。"]),
      displayMath(String.raw`\begin{aligned}
(X+_{A/I}Y)+_{A/I}Z
&=\bigl(\pi_I(a)+_{A/I}\pi_I(b)\bigr)+_{A/I}\pi_I(c)
&&\left(\because\ a,b,c\ \text{のとり方}\right)\\
&=\pi_I(a+_A b)+_{A/I}\pi_I(c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((a+_A b)+_A c\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(a+_A(b+_A c)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の結合法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=\pi_I(a)+_{A/I}\pi_I(b+_A c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\pi_I(a)+_{A/I}\bigl(\pi_I(b)+_{A/I}\pi_I(c)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=X+_{A/I}(Y+_{A/I}Z)
&&\left(\because\ a,b,c\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["加法の交換法則。"]),
      displayMath(String.raw`\begin{aligned}
X+_{A/I}Y
&=\pi_I(a)+_{A/I}\pi_I(b)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\pi_I(a+_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(b+_A a)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の交換法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=\pi_I(b)+_{A/I}\pi_I(a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=Y+_{A/I}X
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["加法の単位元。"]),
      displayMath(String.raw`\begin{aligned}
X+_{A/I}0_{A/I}
&=\pi_I(a)+_{A/I}0_{A/I}
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(a)+_{A/I}\pi_I(0_A)
&&\left(\because\ 0_{A/I}\ \text{の定義。}\blkref{def_quotient_algebra_operations}\right)\\
&=\pi_I(a+_A 0_A)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(a)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の加法の単位元。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=X
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元。",
        math(String.raw`U_{\mathrm{ring}}(A)`),
        " の加法の逆元の条件（",
        ref("def_unital_ring"),
        "）により、",
        math(String.raw`a+_A a'=0_A`),
        " を満たす ",
        math(String.raw`a'\in A`),
        " がある。",
        math(String.raw`X':=\pi_I(a')`),
        " と置くと、",
        math(String.raw`X'`),
        " は ",
        math(String.raw`\pi_I`),
        " の値なので ",
        math(String.raw`A/I`),
        " の元であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
X+_{A/I}X'
&=\pi_I(a)+_{A/I}X'
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(a)+_{A/I}\pi_I(a')
&&\left(\because\ X'\ \text{の定義}\right)\\
&=\pi_I(a+_A a')
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(0_A)
&&\left(\because\ a'\ \text{のとり方}\right)\\
&=0_{A/I}
&&\left(\because\ 0_{A/I}\ \text{の定義。}\blkref{def_quotient_algebra_operations}\right)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph(["乗法の結合法則。"]),
      displayMath(String.raw`\begin{aligned}
(X\cdot_{A/I}Y)\cdot_{A/I}Z
&=\bigl(\pi_I(a)\cdot_{A/I}\pi_I(b)\bigr)\cdot_{A/I}\pi_I(c)
&&\left(\because\ a,b,c\ \text{のとり方}\right)\\
&=\pi_I(a\cdot_A b)\cdot_{A/I}\pi_I(c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((a\cdot_A b)\cdot_A c\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(a\cdot_A(b\cdot_A c)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=\pi_I(a)\cdot_{A/I}\pi_I(b\cdot_A c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=\pi_I(a)\cdot_{A/I}\bigl(\pi_I(b)\cdot_{A/I}\pi_I(c)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=X\cdot_{A/I}(Y\cdot_{A/I}Z)
&&\left(\because\ a,b,c\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["乗法の単位元。"]),
      displayMath(String.raw`\begin{aligned}
X\cdot_{A/I}1_{A/I}
&=\pi_I(a)\cdot_{A/I}1_{A/I}
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(a)\cdot_{A/I}\pi_I(1_A)
&&\left(\because\ 1_{A/I}\ \text{の定義。}\blkref{def_quotient_algebra_operations}\right)\\
&=\pi_I(a\cdot_A 1_A)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(a)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=X
&&\left(\because\ a\ \text{のとり方}\right),\\[4pt]
1_{A/I}\cdot_{A/I}X
&=1_{A/I}\cdot_{A/I}\pi_I(a)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(1_A)\cdot_{A/I}\pi_I(a)
&&\left(\because\ 1_{A/I}\ \text{の定義。}\blkref{def_quotient_algebra_operations}\right)\\
&=\pi_I(1_A\cdot_A a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(a)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=X
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["分配法則。"]),
      displayMath(String.raw`\begin{aligned}
X\cdot_{A/I}(Y+_{A/I}Z)
&=\pi_I(a)\cdot_{A/I}\bigl(\pi_I(b)+_{A/I}\pi_I(c)\bigr)
&&\left(\because\ a,b,c\ \text{のとり方}\right)\\
&=\pi_I(a)\cdot_{A/I}\pi_I(b+_A c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(a\cdot_A(b+_A c)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((a\cdot_A b)+_A(a\cdot_A c)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（左の因子が共通）。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=\pi_I(a\cdot_A b)+_{A/I}\pi_I(a\cdot_A c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\bigl(\pi_I(a)\cdot_{A/I}\pi_I(b)\bigr)+_{A/I}\bigl(\pi_I(a)\cdot_{A/I}\pi_I(c)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を二つの項に}\right)\\
&=(X\cdot_{A/I}Y)+_{A/I}(X\cdot_{A/I}Z)
&&\left(\because\ a,b,c\ \text{のとり方}\right),\\[4pt]
(X+_{A/I}Y)\cdot_{A/I}Z
&=\bigl(\pi_I(a)+_{A/I}\pi_I(b)\bigr)\cdot_{A/I}\pi_I(c)
&&\left(\because\ a,b,c\ \text{のとり方}\right)\\
&=\pi_I(a+_A b)\cdot_{A/I}\pi_I(c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((a+_A b)\cdot_A c\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((a\cdot_A c)+_A(b\cdot_A c)\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（右の因子が共通）。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_unital_ring}\right)\\
&=\pi_I(a\cdot_A c)+_{A/I}\pi_I(b\cdot_A c)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\bigl(\pi_I(a)\cdot_{A/I}\pi_I(c)\bigr)+_{A/I}\bigl(\pi_I(b)\cdot_{A/I}\pi_I(c)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を二つの項に}\right)\\
&=(X\cdot_{A/I}Z)+_{A/I}(Y\cdot_{A/I}Z)
&&\left(\because\ a,b,c\ \text{のとり方}\right).
\end{aligned}`),
      paragraph([
        "七つの条件がすべて成り立つので、組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},0_{A/I},1_{A/I})`),
        " は単位元をもつ環（",
        ref("def_unital_ring"),
        "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_set_operations_form_complex_vector_space",
    kind: "claim",
    title: { text: "商集合の上の演算の組は ℂ-線型空間である" },
    labels: ["claim_quotient_set_operations_form_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、組",
      ]),
      displayMath(String.raw`(A/I,+_{A/I},\ast_{A/I},0_{A/I})`),
      paragraph([
        "は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。ここで ",
        math(String.raw`A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`+_{A/I},\ \ast_{A/I},\ 0_{A/I}`),
        " は商集合の上の加法・スカラー倍・零元（",
        ref("def_quotient_algebra_operations"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "商集合の上の演算の定義（",
        ref("def_quotient_algebra_operations"),
        "）により、",
        math(String.raw`+_{A/I}`),
        " は ",
        math(String.raw`A/I\times A/I\to A/I`),
        " の写像、",
        math(String.raw`\ast_{A/I}`),
        " は ",
        math(String.raw`\mathbb{C}\times A/I\to A/I`),
        " の写像、",
        math(String.raw`0_{A/I}`),
        " は ",
        math(String.raw`A/I`),
        " の元である。残りは ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）の八つの条件である。",
      ]),
      paragraph([
        "加法の結合法則・加法の交換法則・加法の単位元・加法の逆元の四つの条件は、単位元をもつ環（",
        ref("def_unital_ring"),
        "）の同じ名前の四つの条件と、同じ ",
        math(String.raw`+_{A/I}`),
        " と ",
        math(String.raw`0_{A/I}`),
        " についての同じ式である。商集合の上の演算の組が単位元をもつ環であること（",
        ref("claim_quotient_set_operations_form_unital_ring"),
        "）により、この四つは成り立つ。",
      ]),
      paragraph([
        "残りはスカラー倍についての四つの条件である。",
        math(String.raw`\pi_I:A\to A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）とする。",
        math(String.raw`X,Y`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とし、射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により ",
        math(String.raw`\pi_I(a)=X`),
        "、",
        math(String.raw`\pi_I(b)=Y`),
        " を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a,b`),
        " をとる。",
        math(String.raw`A`),
        " の線型空間の公理は、",
        math(String.raw`U_{\mathrm{vec}}(A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
      ]),
      paragraph(["スカラー倍の結合法則。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda\cdot_{\mathbb{C}}\mu)\ast_{A/I}X
&=(\lambda\cdot_{\mathbb{C}}\mu)\ast_{A/I}\pi_I(a)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I\bigl((\lambda\cdot_{\mathbb{C}}\mu)\ast_A a\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(\lambda\ast_A(\mu\ast_A a)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_complex_vector_space}\right)\\
&=\lambda\ast_{A/I}\pi_I(\mu\ast_A a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=\lambda\ast_{A/I}\bigl(\mu\ast_{A/I}\pi_I(a)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=\lambda\ast_{A/I}(\mu\ast_{A/I}X)
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元。"]),
      displayMath(String.raw`\begin{aligned}
1_{\mathbb{C}}\ast_{A/I}X
&=1_{\mathbb{C}}\ast_{A/I}\pi_I(a)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(1_{\mathbb{C}}\ast_A a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I(a)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の単位元。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_complex_vector_space}\right)\\
&=X
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_{A/I}(X+_{A/I}Y)
&=\lambda\ast_{A/I}\bigl(\pi_I(a)+_{A/I}\pi_I(b)\bigr)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\lambda\ast_{A/I}\pi_I(a+_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(\lambda\ast_A(a+_A b)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((\lambda\ast_A a)+_A(\lambda\ast_A b)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のベクトルの加法についての分配法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_complex_vector_space}\right)\\
&=\pi_I(\lambda\ast_A a)+_{A/I}\pi_I(\lambda\ast_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\bigl(\lambda\ast_{A/I}\pi_I(a)\bigr)+_{A/I}\bigl(\lambda\ast_{A/I}\pi_I(b)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を二つの項に}\right)\\
&=(\lambda\ast_{A/I}X)+_{A/I}(\lambda\ast_{A/I}Y)
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則。"]),
      displayMath(String.raw`\begin{aligned}
(\lambda+_{\mathbb{C}}\mu)\ast_{A/I}X
&=(\lambda+_{\mathbb{C}}\mu)\ast_{A/I}\pi_I(a)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I\bigl((\lambda+_{\mathbb{C}}\mu)\ast_A a\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((\lambda\ast_A a)+_A(\mu\ast_A a)\bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラーの加法についての分配法則。}\blkref{def_underlying_ring_and_vector_space_of_algebra}\text{、}\blkref{def_complex_vector_space}\right)\\
&=\pi_I(\lambda\ast_A a)+_{A/I}\pi_I(\mu\ast_A a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\bigl(\lambda\ast_{A/I}\pi_I(a)\bigr)+_{A/I}\bigl(\mu\ast_{A/I}\pi_I(a)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を二つの項に}\right)\\
&=(\lambda\ast_{A/I}X)+_{A/I}(\mu\ast_{A/I}X)
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph([
        "八つの条件がすべて成り立つので、組 ",
        math(String.raw`(A/I,+_{A/I},\ast_{A/I},0_{A/I})`),
        " は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_quotient_algebra_is_complex_algebra",
    kind: "claim",
    title: { text: "商集合の上の演算の組は ℂ-代数である（商代数）" },
    labels: ["claim_quotient_algebra_is_complex_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、組",
      ]),
      displayMath(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
      paragraph([
        "は ℂ-代数（",
        ref("def_complex_algebra"),
        "）である。ここで ",
        math(String.raw`A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`+_{A/I},\ \cdot_{A/I},\ \ast_{A/I},\ 0_{A/I},\ 1_{A/I}`),
        " は商集合の上の加法・乗法・スカラー倍・零元・単位元（",
        ref("def_quotient_algebra_operations"),
        "）である。この ℂ-代数を ",
        math(String.raw`I`),
        " を法とする商代数と呼び、組と同じ記号 ",
        math(String.raw`A/I`),
        " で書く。",
      ]),
    ],
    proof: [
      paragraph([
        "ℂ-代数（",
        ref("def_complex_algebra"),
        "）の四つの条件を順に確かめる。",
      ]),
      paragraph([
        "一つ目の条件。組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},0_{A/I},1_{A/I})`),
        " は、商集合の上の演算の組が単位元をもつ環であること（",
        ref("claim_quotient_set_operations_form_unital_ring"),
        "）により、単位元をもつ環である。",
      ]),
      paragraph([
        "二つ目の条件。組 ",
        math(String.raw`(A/I,+_{A/I},\ast_{A/I},0_{A/I})`),
        " は、商集合の上の演算の組が ℂ-線型空間であること（",
        ref("claim_quotient_set_operations_form_complex_vector_space"),
        "）により、ℂ-線型空間である。",
      ]),
      paragraph([
        "残りはスカラー倍と乗法の両立の二つの条件である。",
        math(String.raw`\pi_I:A\to A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）とする。",
        math(String.raw`X,Y`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とし、射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により ",
        math(String.raw`\pi_I(a)=X`),
        "、",
        math(String.raw`\pi_I(b)=Y`),
        " を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a,b`),
        " をとる。",
      ]),
      paragraph(["スカラー倍と乗法の両立、左の因子。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_{A/I}(X\cdot_{A/I}Y)
&=\lambda\ast_{A/I}\bigl(\pi_I(a)\cdot_{A/I}\pi_I(b)\bigr)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\lambda\ast_{A/I}\pi_I(a\cdot_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(\lambda\ast_A(a\cdot_A b)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl((\lambda\ast_A a)\cdot_A b\bigr)
&&\left(\because\ A\ \text{のスカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\pi_I(\lambda\ast_A a)\cdot_{A/I}\pi_I(b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=\bigl(\lambda\ast_{A/I}\pi_I(a)\bigr)\cdot_{A/I}\pi_I(b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=(\lambda\ast_{A/I}X)\cdot_{A/I}Y
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["スカラー倍と乗法の両立、右の因子。"]),
      displayMath(String.raw`\begin{aligned}
\lambda\ast_{A/I}(X\cdot_{A/I}Y)
&=\lambda\ast_{A/I}\bigl(\pi_I(a)\cdot_{A/I}\pi_I(b)\bigr)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\lambda\ast_{A/I}\pi_I(a\cdot_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(\lambda\ast_A(a\cdot_A b)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\ \text{を右辺から左辺へ}\right)\\
&=\pi_I\bigl(a\cdot_A(\lambda\ast_A b)\bigr)
&&\left(\because\ A\ \text{のスカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\pi_I(a)\cdot_{A/I}\pi_I(\lambda\ast_A b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=\pi_I(a)\cdot_{A/I}\bigl(\lambda\ast_{A/I}\pi_I(b)\bigr)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=X\cdot_{A/I}(\lambda\ast_{A/I}Y)
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph([
        "四つの条件がすべて成り立つので、組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
        " は ℂ-代数（",
        ref("def_complex_algebra"),
        "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_algebra_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "商代数への射影は ℂ-代数の準同型である" },
    labels: ["claim_projection_onto_quotient_algebra_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`I`),
        " を法とする商集合への射影 ",
        math(String.raw`\pi_I:A\to A/I`),
        "（",
        ref("def_projection_onto_quotient_set"),
        "）は、",
        math(String.raw`A`),
        " から ",
        math(String.raw`I`),
        " を法とする商代数 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
        "（",
        ref("claim_quotient_algebra_is_complex_algebra"),
        "）への ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "終域の組が ℂ-代数であることは ",
        ref("claim_quotient_algebra_is_complex_algebra"),
        " で示されている。",
        ref("def_complex_algebra_homomorphism"),
        " の二つの条件を、",
        ref("def_ring_homomorphism"),
        " と ",
        ref("def_linear_map"),
        " の定義に従って書き出した四つの等式を確かめる。",
        math(String.raw`a,b`),
        " を ",
        math(String.raw`A`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。",
      ]),
      paragraph(["加法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a+_A b)&=\pi_I(a)+_{A/I}\pi_I(b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_addition}\right).
\end{aligned}`),
      paragraph(["乗法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\pi_I(a\cdot_A b)&=\pi_I(a)\cdot_{A/I}\pi_I(b)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right).
\end{aligned}`),
      paragraph(["乗法の単位元を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\pi_I(1_A)&=1_{A/I}
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{の単位元}\ 1_{A/I}:=\pi_I(1_A)\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\pi_I(\lambda\ast_A a)&=\lambda\ast_{A/I}\pi_I(a)
&&\left(\because\ \blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right).
\end{aligned}`),
      paragraph([
        "加法・乗法・乗法の単位元を保つので、",
        math(String.raw`\pi_I`),
        " は環の組 ",
        math(String.raw`(A,+_A,\cdot_A,0_A,1_A)`),
        " から環の組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},0_{A/I},1_{A/I})`),
        " への環の準同型（",
        ref("def_ring_homomorphism"),
        "）である。加法・スカラー倍を保つので、",
        math(String.raw`\pi_I`),
        " は線型空間の組 ",
        math(String.raw`(A,+_A,\ast_A,0_A)`),
        " から線型空間の組 ",
        math(String.raw`(A/I,+_{A/I},\ast_{A/I},0_{A/I})`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。したがって ",
        math(String.raw`\pi_I`),
        " は ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_quotient_set_sends_ideal_elements_to_zero",
    kind: "claim",
    title: { text: "商集合への射影は両側イデアルの元を零へ移す" },
    labels: ["claim_projection_onto_quotient_set_sends_ideal_elements_to_zero"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。このとき、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について",
      ]),
      displayMath(String.raw`\pi_I(x)=0_{A/I}`),
      paragraph([
        "である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`0_{A/I}`),
        " は商集合の上の演算の零元（",
        ref("def_quotient_algebra_operations"),
        "）であり、等号は ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元、すなわち ",
        math(String.raw`A`),
        " の部分集合としての等号である。",
        math(String.raw`I`),
        " は ",
        math(String.raw`A`),
        " の部分集合なので、",
        math(String.raw`x`),
        " は ",
        math(String.raw`A`),
        " の元でもあり、",
        math(String.raw`\pi_I(x)`),
        " は定まる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x\in I`),
        " をとる。ℂ-線型空間についての定義・主張は、",
        math(String.raw`V:=U_{\mathrm{vec}}(A)=(A,+_A,\ast_A,0_A)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。",
        math(String.raw`x`),
        " が ",
        math(String.raw`I`),
        " を法として ",
        math(String.raw`0_A`),
        " と合同であることを先に示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
x+_A\bigl((-1_{\mathbb{C}})\ast_A 0_A\bigr)
&=x+_A 0_A
&&\left(\because\ \text{零ベクトルのスカラー倍は零ベクトル（}\lambda=-1_{\mathbb{C}}\text{）。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=x
&&\left(\because\ 0_A\ \text{は加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "仮定 ",
        math(String.raw`x\in I`),
        " と上の等式により ",
        math(String.raw`x+_A\bigl((-1_{\mathbb{C}})\ast_A 0_A\bigr)\in I`),
        " であり、合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "。",
        math(String.raw`a`),
        " に ",
        math(String.raw`x`),
        "、",
        math(String.raw`b`),
        " に ",
        math(String.raw`0_A`),
        " を当てる）により ",
        math(String.raw`x\equiv_I 0_A`),
        " である。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi_I(x)&=[x]_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=[0_A]_I
&&\left(\because\ x\equiv_I 0_A\ \text{と、剰余類が等しいことと代表が合同であることの同値の}\ \Leftarrow\ \text{（}a\ \text{に}\ x\text{、}b\ \text{に}\ 0_A\ \text{を当てる）。}\blkref{claim_residue_classes_are_equal_iff_congruent}\right)\\
&=\pi_I(0_A)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=0_{A/I}
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{の零元}\ 0_{A/I}:=\pi_I(0_A)\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements",
    kind: "claim",
    title: { text: "両側イデアルの元を零へ移す準同型は、合同な元に同じ値をとる" },
    labels: ["claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`\varphi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）とし、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=0_B`),
        " であるとする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a,a'`),
        " について、",
        math(String.raw`a\equiv_I a'`),
        " ならば",
      ]),
      displayMath(String.raw`\varphi(a)=\varphi(a')`),
      paragraph([
        "である。ここで ",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）であり、等号は ",
        math(String.raw`B`),
        " の元としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a,a'\in A`),
        " を ",
        math(String.raw`a\equiv_I a'`),
        " を満たすようにとる。",
        math(String.raw`x:=a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)`),
        " と置く。合同の定義（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）により ",
        math(String.raw`x\in I`),
        " であり、仮定により ",
        math(String.raw`\varphi(x)=0_B`),
        " である。ℂ-線型空間についての定義・主張は、",
        math(String.raw`U_{\mathrm{vec}}(B)=(B,+_B,\ast_B,0_B)`),
        "（",
        ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）に当てる。準備として、",
        math(String.raw`y:=\varphi(a')\in B`),
        " と置き、",
        math(String.raw`(-1_{\mathbb{C}})\ast_B y`),
        " と ",
        math(String.raw`y`),
        " の和を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((-1_{\mathbb{C}})\ast_B y\bigr)+_B y
&=\bigl((-1_{\mathbb{C}})\ast_B y\bigr)+_B(1_{\mathbb{C}}\ast_B y)
&&\left(\because\ \text{スカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl((-1_{\mathbb{C}})+_{\mathbb{C}}1_{\mathbb{C}}\bigr)\ast_B y
&&\left(\because\ \text{スカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\ast_B y
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=0_{\mathbb{C}}\ast_B y
&&\left(\because\ -1_{\mathbb{C}}\ \text{は}\ 1_{\mathbb{C}}\ \text{の加法の逆元。}\blkref{def_congruence_modulo_two_sided_ideal}\right)\\
&=0_B
&&\left(\because\ \text{零のスカラー倍は零ベクトル（その主張の}\ x\ \text{に}\ y\ \text{を当てる）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
      paragraph(["これを使って、"]),
      displayMath(String.raw`\begin{aligned}
\varphi(a)
&=\varphi(a)+_B 0_B
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\varphi(a)+_B\Bigl(\bigl((-1_{\mathbb{C}})\ast_B y\bigr)+_B y\Bigr)
&&\left(\because\ \text{上の準備の等式}\right)\\
&=\Bigl(\varphi(a)+_B\bigl((-1_{\mathbb{C}})\ast_B y\bigr)\Bigr)+_B y
&&\left(\because\ \text{加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\Bigl(\varphi(a)+_B\bigl((-1_{\mathbb{C}})\ast_B\varphi(a')\bigr)\Bigr)+_B y
&&\left(\because\ y\ \text{の定義}\right)\\
&=\Bigl(\varphi(a)+_B\varphi\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)\Bigr)+_B y
&&\left(\because\ \varphi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_linear_map}\right)\\
&=\varphi\Bigl(a+_A\bigl((-1_{\mathbb{C}})\ast_A a'\bigr)\Bigr)+_B y
&&\left(\because\ \varphi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_linear_map}\right)\\
&=\varphi(x)+_B y
&&\left(\because\ x\ \text{の定義}\right)\\
&=0_B+_B y
&&\left(\because\ x\in I\ \text{と仮定}\right)\\
&=y+_B 0_B
&&\left(\because\ \text{加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=y
&&\left(\because\ \text{加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\varphi(a')
&&\left(\because\ y\ \text{の定義}\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_map_induced_on_quotient_algebra",
    kind: "definition",
    title: { text: "両側イデアルの元を零へ移す準同型が商代数の上に誘導する写像" },
    labels: ["def_map_induced_on_quotient_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`\varphi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）とし、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=0_B`),
        " であるとする。",
        math(String.raw`A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`A`),
        " の商集合（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`\pi_I:A\to A/I`),
        " を ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）とする。",
        math(String.raw`X`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元とし、射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により ",
        math(String.raw`\pi_I(a)=X`),
        " を満たす ",
        math(String.raw`A`),
        " の元 ",
        math(String.raw`a`),
        " をとる。写像",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}&:A/I\to B,\\
\overline{\varphi}(X)&:=\varphi(a)
\end{aligned}`),
      paragraph([
        "を、",
        math(String.raw`\varphi`),
        " が ",
        math(String.raw`I`),
        " を法とする商代数の上に誘導する写像と呼ぶ。右辺は ",
        math(String.raw`\varphi`),
        " の値なので ",
        math(String.raw`B`),
        " に属する。",
      ]),
      paragraph([
        "右辺は代表 ",
        math(String.raw`a`),
        " のとり方によらない。",
        math(String.raw`\pi_I(a')=X`),
        " を満たす別の ",
        math(String.raw`a'\in A`),
        " をとると、",
      ]),
      displayMath(String.raw`\begin{aligned}
[a]_I&=\pi_I(a)
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)\\
&=X
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\pi_I(a')
&&\left(\because\ a'\ \text{のとり方}\right)\\
&=[a']_I
&&\left(\because\ \blkref{def_projection_onto_quotient_set}\right)
\end{aligned}`),
      paragraph([
        "であり、剰余類が等しいことと代表が合同であることの同値の ",
        math(String.raw`\Rightarrow`),
        "（",
        math(String.raw`b`),
        " に ",
        math(String.raw`a'`),
        " を当てる。",
        ref("claim_residue_classes_are_equal_iff_congruent"),
        "）により ",
        math(String.raw`a\equiv_I a'`),
        " である。両側イデアルの元を零へ移す準同型は合同な元に同じ値をとること（",
        ref("claim_homomorphism_vanishing_on_ideal_takes_equal_values_on_congruent_elements"),
        "）により ",
        math(String.raw`\varphi(a)=\varphi(a')`),
        " である。ここで ",
        math(String.raw`[a]_I`),
        " は ",
        math(String.raw`I`),
        " を法とする ",
        math(String.raw`a`),
        " の剰余類（",
        ref("def_residue_class_modulo_two_sided_ideal"),
        "）、",
        math(String.raw`\equiv_I`),
        " は ",
        math(String.raw`I`),
        " を法とする合同（",
        ref("def_congruence_modulo_two_sided_ideal"),
        "）である。",
      ]),
      paragraph([
        "この定義は ",
        math(String.raw`\overline{\varphi}`),
        " を集合 ",
        math(String.raw`A/I`),
        " から ",
        math(String.raw`B`),
        " への写像として定めるだけである。",
        math(String.raw`\overline{\varphi}\circ\pi_I=\varphi`),
        " であること、",
        math(String.raw`\overline{\varphi}`),
        " が商代数 ",
        math(String.raw`A/I`),
        "（",
        ref("claim_quotient_algebra_is_complex_algebra"),
        "）から ",
        math(String.raw`B`),
        " への ℂ-代数の準同型であることは、続く主張で示す。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_induced_map_composed_with_projection_is_original_homomorphism",
    kind: "claim",
    title: { text: "誘導される写像と商集合への射影の合成は、元の準同型である" },
    labels: ["claim_induced_map_composed_with_projection_is_original_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`\varphi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）とし、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=0_B`),
        " であるとする。このとき、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " について",
      ]),
      displayMath(String.raw`\overline{\varphi}\bigl(\pi_I(a)\bigr)=\varphi(a)`),
      paragraph([
        "である。すなわち ",
        math(String.raw`\overline{\varphi}\circ\pi_I=\varphi`),
        " である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`\overline{\varphi}:A/I\to B`),
        " は ",
        math(String.raw`\varphi`),
        " が ",
        math(String.raw`I`),
        " を法とする商代数の上に誘導する写像（",
        ref("def_map_induced_on_quotient_algebra"),
        "）であり、等号は ",
        math(String.raw`B`),
        " の元としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a\in A`),
        " をとり、",
        math(String.raw`X:=\pi_I(a)`),
        " と置く。",
        math(String.raw`X`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合 ",
        math(String.raw`A/I`),
        "（",
        ref("def_quotient_set_modulo_two_sided_ideal"),
        "）の元であり、",
        math(String.raw`a`),
        " は ",
        math(String.raw`\pi_I(a)=X`),
        " を満たすので、誘導される写像の定義（",
        ref("def_map_induced_on_quotient_algebra"),
        "）の代表に ",
        math(String.raw`a`),
        " 自身をとれる。その定義で右辺が代表のとり方によらないことは、その定義の中で示されている。これを使って、",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}\bigl(\pi_I(a)\bigr)&=\overline{\varphi}(X)
&&\left(\because\ X\ \text{の定義}\right)\\
&=\varphi(a)
&&\left(\because\ \blkref{def_map_induced_on_quotient_algebra}\text{、代表}\ a\right)
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_induced_map_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "誘導される写像は ℂ-代数の準同型である" },
    labels: ["claim_induced_map_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`\varphi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）とし、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=0_B`),
        " であるとする。このとき、",
        math(String.raw`\varphi`),
        " が ",
        math(String.raw`I`),
        " を法とする商代数の上に誘導する写像 ",
        math(String.raw`\overline{\varphi}:A/I\to B`),
        "（",
        ref("def_map_induced_on_quotient_algebra"),
        "）は、",
        math(String.raw`I`),
        " を法とする商代数 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
        "（",
        ref("claim_quotient_algebra_is_complex_algebra"),
        "）から ",
        math(String.raw`B`),
        " への ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "始域の組が ℂ-代数であることは ",
        ref("claim_quotient_algebra_is_complex_algebra"),
        " で示されている。",
        ref("def_complex_algebra_homomorphism"),
        " の二つの条件を、",
        ref("def_ring_homomorphism"),
        " と ",
        ref("def_linear_map"),
        " の定義に従って書き出した四つの等式を確かめる。",
        math(String.raw`X,Y`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により、",
        math(String.raw`\pi_I(a)=X`),
        " を満たす ",
        math(String.raw`a\in A`),
        " と、",
        math(String.raw`\pi_I(b)=Y`),
        " を満たす ",
        math(String.raw`b\in A`),
        " をとる。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）である。",
      ]),
      paragraph(["加法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}(X+_{A/I}Y)
&=\overline{\varphi}\bigl(\pi_I(a)+_{A/I}\pi_I(b)\bigr)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\overline{\varphi}\bigl(\pi_I(a+_A b)\bigr)
&&\left(\because\ \text{射影は加法を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_addition}\right)\\
&=\varphi(a+_A b)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\varphi(a)+_B\varphi(b)
&&\left(\because\ \varphi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right)\\
&=\overline{\varphi}\bigl(\pi_I(a)\bigr)+_B\overline{\varphi}\bigl(\pi_I(b)\bigr)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\overline{\varphi}(X)+_B\overline{\varphi}(Y)
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["乗法を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}(X\cdot_{A/I}Y)
&=\overline{\varphi}\bigl(\pi_I(a)\cdot_{A/I}\pi_I(b)\bigr)
&&\left(\because\ a,b\ \text{のとり方}\right)\\
&=\overline{\varphi}\bigl(\pi_I(a\cdot_A b)\bigr)
&&\left(\because\ \text{射影は乗法を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_multiplication}\right)\\
&=\varphi(a\cdot_A b)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\varphi(a)\cdot_B\varphi(b)
&&\left(\because\ \varphi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right)\\
&=\overline{\varphi}\bigl(\pi_I(a)\bigr)\cdot_B\overline{\varphi}\bigl(\pi_I(b)\bigr)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\overline{\varphi}(X)\cdot_B\overline{\varphi}(Y)
&&\left(\because\ a,b\ \text{のとり方}\right).
\end{aligned}`),
      paragraph(["乗法の単位元を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}(1_{A/I})
&=\overline{\varphi}\bigl(\pi_I(1_A)\bigr)
&&\left(\because\ \blkref{def_quotient_algebra_operations}\ \text{の単位元}\ 1_{A/I}:=\pi_I(1_A)\right)\\
&=\varphi(1_A)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=1_B
&&\left(\because\ \varphi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_ring_homomorphism}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと。"]),
      displayMath(String.raw`\begin{aligned}
\overline{\varphi}(\lambda\ast_{A/I}X)
&=\overline{\varphi}\bigl(\lambda\ast_{A/I}\pi_I(a)\bigr)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\overline{\varphi}\bigl(\pi_I(\lambda\ast_A a)\bigr)
&&\left(\because\ \text{射影はスカラー倍を保つ。}\blkref{claim_projection_onto_quotient_set_preserves_scalar_multiplication}\right)\\
&=\varphi(\lambda\ast_A a)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\lambda\ast_B\varphi(a)
&&\left(\because\ \varphi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\text{、}\blkref{def_linear_map}\right)\\
&=\lambda\ast_B\overline{\varphi}\bigl(\pi_I(a)\bigr)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\lambda\ast_B\overline{\varphi}(X)
&&\left(\because\ a\ \text{のとり方}\right).
\end{aligned}`),
      paragraph([
        "加法・乗法・乗法の単位元を保つので、",
        math(String.raw`\overline{\varphi}`),
        " は環の組 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},0_{A/I},1_{A/I})`),
        " から環の組 ",
        math(String.raw`(B,+_B,\cdot_B,0_B,1_B)`),
        " への環の準同型（",
        ref("def_ring_homomorphism"),
        "）である。加法・スカラー倍を保つので、",
        math(String.raw`\overline{\varphi}`),
        " は線型空間の組 ",
        math(String.raw`(A/I,+_{A/I},\ast_{A/I},0_{A/I})`),
        " から線型空間の組 ",
        math(String.raw`(B,+_B,\ast_B,0_B)`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。したがって ",
        math(String.raw`\overline{\varphi}`),
        " は ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique",
    kind: "claim",
    title: { text: "射影との合成が元の準同型になる商代数からの準同型はただ一つである" },
    labels: ["claim_homomorphism_from_quotient_algebra_composing_with_projection_is_unique"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`),
        " と ",
        math(String.raw`(B,+_B,\cdot_B,\ast_B,0_B,1_B)`),
        " を ℂ-代数（",
        ref("def_complex_algebra"),
        "）とし、",
        math(String.raw`I`),
        " を ",
        math(String.raw`A`),
        " の両側イデアル（",
        ref("def_two_sided_ideal"),
        "）とする。",
        math(String.raw`\varphi:A\to B`),
        " を ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）とし、",
        math(String.raw`I`),
        " の任意の元 ",
        math(String.raw`x`),
        " について ",
        math(String.raw`\varphi(x)=0_B`),
        " であるとする。",
        math(String.raw`\psi:A/I\to B`),
        " を、",
        math(String.raw`I`),
        " を法とする商代数 ",
        math(String.raw`(A/I,+_{A/I},\cdot_{A/I},\ast_{A/I},0_{A/I},1_{A/I})`),
        "（",
        ref("claim_quotient_algebra_is_complex_algebra"),
        "）から ",
        math(String.raw`B`),
        " への ℂ-代数の準同型（",
        ref("def_complex_algebra_homomorphism"),
        "）で、",
        math(String.raw`A`),
        " の任意の元 ",
        math(String.raw`a`),
        " について ",
        math(String.raw`\psi\bigl(\pi_I(a)\bigr)=\varphi(a)`),
        " を満たすものとする。このとき、",
        math(String.raw`A/I`),
        " の任意の元 ",
        math(String.raw`X`),
        " について",
      ]),
      displayMath(String.raw`\psi(X)=\overline{\varphi}(X)`),
      paragraph([
        "である。すなわち ",
        math(String.raw`\psi=\overline{\varphi}`),
        " である。ここで ",
        math(String.raw`\pi_I:A\to A/I`),
        " は ",
        math(String.raw`I`),
        " を法とする商集合への射影（",
        ref("def_projection_onto_quotient_set"),
        "）、",
        math(String.raw`\overline{\varphi}:A/I\to B`),
        " は ",
        math(String.raw`\varphi`),
        " が ",
        math(String.raw`I`),
        " を法とする商代数の上に誘導する写像（",
        ref("def_map_induced_on_quotient_algebra"),
        "）であり、等号は ",
        math(String.raw`B`),
        " の元としての等号である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`X`),
        " を ",
        math(String.raw`A/I`),
        " の任意の元とする。射影が全射であること（",
        ref("claim_projection_onto_quotient_set_is_surjective"),
        "）により、",
        math(String.raw`\pi_I(a)=X`),
        " を満たす ",
        math(String.raw`a\in A`),
        " をとる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\psi(X)&=\psi\bigl(\pi_I(a)\bigr)
&&\left(\because\ a\ \text{のとり方}\right)\\
&=\varphi(a)
&&\left(\because\ \psi\ \text{についての仮定}\right)\\
&=\overline{\varphi}\bigl(\pi_I(a)\bigr)
&&\left(\because\ \overline{\varphi}\circ\pi_I=\varphi\text{。}\blkref{claim_induced_map_composed_with_projection_is_original_homomorphism}\right)\\
&=\overline{\varphi}(X)
&&\left(\because\ a\ \text{のとり方}\right)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`X`),
        " は ",
        math(String.raw`A/I`),
        " の任意の元なので、",
        math(String.raw`\psi`),
        " と ",
        math(String.raw`\overline{\varphi}`),
        " は ",
        math(String.raw`A/I`),
        " のすべての元で同じ値をとり、写像として等しい。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_basis_of_direct_sum_of_two_vector_spaces",
    kind: "claim",
    title: { text: "二つの基底を埋め込み写像で移して並べた族は、直和の基底である" },
    labels: ["claim_basis_of_direct_sum_of_two_vector_spaces"],
    statement: [
      paragraph([
        math(String.raw`(V_1,+_{V_1},\cdot_{V_1},0_{V_1})`),
        " と ",
        math(String.raw`(V_2,+_{V_2},\cdot_{V_2},0_{V_2})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`(V_1\oplus V_2,+_{V_1\oplus V_2},\cdot_{V_1\oplus V_2},0_{V_1\oplus V_2})`),
        " をその直和（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）とする。直和は ℂ-線型空間である（",
        ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"),
        "）。",
        math(String.raw`\mathrm{in}_1:V_1\to V_1\oplus V_2`),
        " と ",
        math(String.raw`\mathrm{in}_2:V_2\to V_1\oplus V_2`),
        " を成分への埋め込み写像（",
        ref("def_embedding_into_first_component_of_direct_sum"),
        "、",
        ref("def_embedding_into_second_component_of_direct_sum"),
        "）とする。",
      ]),
      paragraph([
        math(String.raw`n,n'\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`b:\{1,\dots,n\}\to V_1`),
        " を ",
        math(String.raw`V_1`),
        " の基底、",
        math(String.raw`b':\{1,\dots,n'\}\to V_2`),
        " を ",
        math(String.raw`V_2`),
        " の基底（",
        ref("def_basis"),
        "）とし、",
        math(String.raw`b_i:=b(i)`),
        "、",
        math(String.raw`b'_j:=b'(j)`),
        " と書く。",
        math(String.raw`\{1,\dots,n+n'\}`),
        " の各元は、",
        math(String.raw`i\in\{1,\dots,n\}`),
        " であるか、ただ一つの ",
        math(String.raw`j\in\{1,\dots,n'\}`),
        " によって ",
        math(String.raw`n+j`),
        " と書けるかのどちらか一方である。そこで ",
        math(String.raw`V_1\oplus V_2`),
        " の元の番号付けた族（",
        ref("def_linear_independence"),
        "）",
        math(String.raw`c:\{1,\dots,n+n'\}\to V_1\oplus V_2`),
        " を次で定め、",
        math(String.raw`c_k:=c(k)`),
        " と書く。",
      ]),
      list([
        [
          math(String.raw`c(i):=\mathrm{in}_1(b_i)`),
          "（",
          math(String.raw`i\in\{1,\dots,n\}`),
          "）",
        ],
        [
          math(String.raw`c(n+j):=\mathrm{in}_2(b'_j)`),
          "（",
          math(String.raw`j\in\{1,\dots,n'\}`),
          "）",
        ],
      ]),
      paragraph([
        "このとき、",
        math(String.raw`c`),
        " は ",
        math(String.raw`V_1\oplus V_2`),
        " の基底である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\mathrm{id}_m:\{1,\dots,m\}\to\{1,\dots,m\}`),
        " を恒等写像とする。",
        math(String.raw`\mathrm{id}_m`),
        " は単射かつ全射なので、",
        math(String.raw`(m,\mathrm{id}_m)`),
        " は有限集合 ",
        math(String.raw`\{1,\dots,m\}`),
        " の番号付けである（",
        ref("def_numbering_of_finite_set"),
        "）。",
      ]),
      paragraph([
        "次に、",
        math(String.raw`\{1,\dots,n+n'\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\kappa_k`),
        " が一つずつ与えられているとき、次の等式（以下、成分の等式と呼ぶ）が成り立つことを示す。",
      ]),
      displayMath(String.raw`\sum_{k=1}^{n+n'}\kappa_k\cdot_{V_1\oplus V_2}c_k=\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i,\ \sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j\right)`),
      displayMath(String.raw`\begin{aligned}
&\sum_{k=1}^{n+n'}\kappa_k\cdot_{V_1\oplus V_2}c_k\\
&\quad=\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1\oplus V_2}c_i\right)+_{V_1\oplus V_2}\left(\sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_1\oplus V_2}c_{n+j}\right)
&&\left(\because\ \blkref{claim_splitting_linear_combination_into_first_and_last_terms}\right)\\
&\quad=\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1\oplus V_2}\mathrm{in}_1(b_i)\right)+_{V_1\oplus V_2}\left(\sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_1\oplus V_2}\mathrm{in}_2(b'_j)\right)
&&\left(\because\ c\ \text{の定義}\right)\\
&\quad=\left(\sum_{i\in\{1,\dots,n\}}\kappa_i\cdot_{V_1\oplus V_2}\mathrm{in}_1(b_i)\right)+_{V_1\oplus V_2}\left(\sum_{j\in\{1,\dots,n'\}}\kappa_{n+j}\cdot_{V_1\oplus V_2}\mathrm{in}_2(b'_j)\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (n,\mathrm{id}_n),\ (n',\mathrm{id}_{n'})\ \text{で}\right)\\
&\quad=\mathrm{in}_1\left(\sum_{i\in\{1,\dots,n\}}\kappa_i\cdot_{V_1}b_i\right)+_{V_1\oplus V_2}\mathrm{in}_2\left(\sum_{j\in\{1,\dots,n'\}}\kappa_{n+j}\cdot_{V_2}b'_j\right)
&&\left(\because\ \mathrm{in}_1,\mathrm{in}_2\ \text{は線型写像。}\blkref{claim_embedding_into_first_component_is_linear_map}\text{、}\blkref{claim_embedding_into_second_component_is_linear_map}\text{、}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&\quad=\mathrm{in}_1\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i\right)+_{V_1\oplus V_2}\mathrm{in}_2\left(\sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j\right)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (n,\mathrm{id}_n),\ (n',\mathrm{id}_{n'})\ \text{で}\right)\\
&\quad=\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i,\ \sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j\right)
&&\left(\because\ \blkref{claim_direct_sum_element_is_sum_of_embedded_components}\right).
\end{aligned}`),
      paragraph([
        "（一次独立）",
        math(String.raw`\{1,\dots,n+n'\}`),
        " の各元 ",
        math(String.raw`k`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\kappa_k`),
        " が与えられていて ",
        math(String.raw`\sum_{k=1}^{n+n'}\kappa_k\cdot_{V_1\oplus V_2}c_k=0_{V_1\oplus V_2}`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i,\ \sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j\right)
&=\sum_{k=1}^{n+n'}\kappa_k\cdot_{V_1\oplus V_2}c_k
&&\left(\because\ \text{成分の等式}\right)\\
&=0_{V_1\oplus V_2}
&&\left(\because\ \kappa_k\ \text{についての仮定}\right)\\
&=(0_{V_1},\ 0_{V_2})
&&\left(\because\ \text{成分ごとの零。}\blkref{def_direct_sum_of_two_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        "二つの組が等しいので成分ごとに等しく、",
        math(String.raw`\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i=0_{V_1}`),
        " かつ ",
        math(String.raw`\sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j=0_{V_2}`),
        " である。",
        math(String.raw`b`),
        " は一次独立なので（",
        ref("def_basis"),
        "。係数を ",
        math(String.raw`i\mapsto\kappa_i`),
        " として ",
        ref("def_linear_independence"),
        " を当てる）、すべての ",
        math(String.raw`i\in\{1,\dots,n\}`),
        " について ",
        math(String.raw`\kappa_i=0_{\mathbb{C}}`),
        " である。",
        math(String.raw`b'`),
        " は一次独立なので（",
        ref("def_basis"),
        "。係数を ",
        math(String.raw`j\mapsto\kappa_{n+j}`),
        " として ",
        ref("def_linear_independence"),
        " を当てる）、すべての ",
        math(String.raw`j\in\{1,\dots,n'\}`),
        " について ",
        math(String.raw`\kappa_{n+j}=0_{\mathbb{C}}`),
        " である。",
        math(String.raw`\{1,\dots,n+n'\}`),
        " の各元は ",
        math(String.raw`i`),
        " か ",
        math(String.raw`n+j`),
        " の形なので、すべての ",
        math(String.raw`k\in\{1,\dots,n+n'\}`),
        " について ",
        math(String.raw`\kappa_k=0_{\mathbb{C}}`),
        " であり、",
        math(String.raw`c`),
        " は一次独立である（",
        ref("def_linear_independence"),
        "）。",
      ]),
      paragraph([
        "（張ること）",
        math(String.raw`V_1\oplus V_2`),
        " の元は組なので（",
        ref("def_direct_sum_of_two_vector_spaces"),
        "）、",
        math(String.raw`x_1\in V_1`),
        "、",
        math(String.raw`x_2\in V_2`),
        " による元 ",
        math(String.raw`(x_1,x_2)`),
        " を任意に取る。",
        math(String.raw`b`),
        " と ",
        math(String.raw`b'`),
        " は張るので（",
        ref("def_basis"),
        "、",
        ref("def_spanning_family"),
        "）、",
        math(String.raw`\mu_i\in\mathbb{C}`),
        "（",
        math(String.raw`i\in\{1,\dots,n\}`),
        "）で ",
        math(String.raw`\sum_{i=1}^{n}\mu_i\cdot_{V_1}b_i=x_1`),
        " を満たすものと、",
        math(String.raw`\nu_j\in\mathbb{C}`),
        "（",
        math(String.raw`j\in\{1,\dots,n'\}`),
        "）で ",
        math(String.raw`\sum_{j=1}^{n'}\nu_j\cdot_{V_2}b'_j=x_2`),
        " を満たすものを取る。",
        math(String.raw`\kappa_i:=\mu_i`),
        "（",
        math(String.raw`i\in\{1,\dots,n\}`),
        "）、",
        math(String.raw`\kappa_{n+j}:=\nu_j`),
        "（",
        math(String.raw`j\in\{1,\dots,n'\}`),
        "）と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{k=1}^{n+n'}\kappa_k\cdot_{V_1\oplus V_2}c_k
&=\left(\sum_{i=1}^{n}\kappa_i\cdot_{V_1}b_i,\ \sum_{j=1}^{n'}\kappa_{n+j}\cdot_{V_2}b'_j\right)
&&\left(\because\ \text{成分の等式}\right)\\
&=\left(\sum_{i=1}^{n}\mu_i\cdot_{V_1}b_i,\ \sum_{j=1}^{n'}\nu_j\cdot_{V_2}b'_j\right)
&&\left(\because\ \kappa_k\ \text{の定義}\right)\\
&=(x_1,\ x_2)
&&\left(\because\ \mu_i,\ \nu_j\ \text{の取り方}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`(x_1,x_2)`),
        " は任意だったので、",
        math(String.raw`c`),
        " は ",
        math(String.raw`V_1\oplus V_2`),
        " を線型結合で張る（",
        ref("def_spanning_family"),
        "）。一次独立と合わせて、",
        math(String.raw`c`),
        " は ",
        math(String.raw`V_1\oplus V_2`),
        " の基底である（",
        ref("def_basis"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_tensor_product_heading",
    kind: "heading",
    level: 2,
    title: { text: "テンソル積" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_tuples_of_vector_space_elements",
    kind: "definition",
    title: { text: "線型空間の元の k 個の組" },
    labels: ["def_tuples_of_vector_space_elements"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`\{1,\dots,k\}`),
        " から ",
        math(String.raw`V`),
        " への写像全体の集合を ",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " と書き、その元を ",
        math(String.raw`V`),
        " の元の ",
        math(String.raw`k`),
        " 個の組と呼ぶ。",
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        " と ",
        math(String.raw`s\in\{1,\dots,k\}`),
        " について、",
        math(String.raw`v(s)\in V`),
        " を ",
        math(String.raw`v`),
        " の第 ",
        math(String.raw`s`),
        " 成分と呼ぶ（",
        math(String.raw`k=0`),
        " のとき ",
        math(String.raw`\{1,\dots,k\}`),
        " は空集合であり、",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " の元は空集合からの写像ただ一つである）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_tuple_with_one_component_replaced",
    kind: "definition",
    title: { text: "一つの成分を置き換えた組" },
    labels: ["def_tuple_with_one_component_replaced"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        "（",
        ref("def_tuples_of_vector_space_elements"),
        "）、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`x\in V`),
        " について、",
        math(String.raw`v`),
        " の第 ",
        math(String.raw`r`),
        " 成分を ",
        math(String.raw`x`),
        " に置き換えた組 ",
        math(String.raw`v[r\mapsto x]\in V^{\{1,\dots,k\}}`),
        " を次で定める。",
      ]),
      list([
        [math(String.raw`v[r\mapsto x](r):=x`)],
        [
          math(String.raw`v[r\mapsto x](s):=v(s)`),
          "（",
          math(String.raw`s\in\{1,\dots,k\}`),
          "、",
          math(String.raw`s\neq r`),
          "）",
        ],
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_k_multilinear_map",
    kind: "definition",
    title: { text: "k 重線型写像" },
    labels: ["def_k_multilinear_map"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。写像 ",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        "（",
        ref("def_tuples_of_vector_space_elements"),
        "）が次をすべて満たすとき、",
        math(String.raw`h`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像と呼ぶ。以下、",
        math(String.raw`v`),
        " は ",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " の任意の元、",
        math(String.raw`r`),
        " は ",
        math(String.raw`\{1,\dots,k\}`),
        " の任意の元、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`V`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表し、",
        math(String.raw`v[r\mapsto x]`),
        " は第 ",
        math(String.raw`r`),
        " 成分を置き換えた組（",
        ref("def_tuple_with_one_component_replaced"),
        "）である。",
      ]),
      list([
        [
          math(String.raw`h\bigl(v[r\mapsto x+_V y]\bigr)=h\bigl(v[r\mapsto x]\bigr)+_U h\bigl(v[r\mapsto y]\bigr)`),
          "（",
          math(String.raw`r`),
          " 番目の成分について加法を保つ）",
        ],
        [
          math(String.raw`h\bigl(v[r\mapsto \lambda\cdot_V x]\bigr)=\lambda\cdot_U h\bigl(v[r\mapsto x]\bigr)`),
          "（",
          math(String.raw`r`),
          " 番目の成分についてスカラー倍を保つ）",
        ],
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のときは ",
        math(String.raw`r`),
        " をとれないので条件は無く、",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " から ",
        math(String.raw`U`),
        " への任意の写像が ",
        math(String.raw`0`),
        " 重線型写像である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_k_fold_tensor_product",
    kind: "definition",
    title: { text: "k 重テンソル積" },
    labels: ["def_k_fold_tensor_product"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。ℂ-線型空間 ",
        math(String.raw`(T,+_T,\cdot_T,0_T)`),
        " と、",
        math(String.raw`V`),
        " から ",
        math(String.raw`T`),
        " への ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）",
        math(String.raw`\tau:V^{\{1,\dots,k\}}\to T`),
        " の組 ",
        math(String.raw`(T,\tau)`),
        " が次の条件を満たすとき、",
        math(String.raw`(T,\tau)`),
        " を ",
        math(String.raw`V`),
        " の ",
        math(String.raw`k`),
        " 重テンソル積と呼ぶ。",
      ]),
      list([
        [
          "任意の ℂ-線型空間 ",
          math(String.raw`(U,+_U,\cdot_U,0_U)`),
          " と、",
          math(String.raw`V`),
          " から ",
          math(String.raw`U`),
          " への任意の ",
          math(String.raw`k`),
          " 重線型写像 ",
          math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
          " について、",
          math(String.raw`T`),
          " から ",
          math(String.raw`U`),
          " への線型写像（",
          ref("def_linear_map"),
          "）",
          math(String.raw`\overline{h}:T\to U`),
          " で ",
          math(String.raw`\overline{h}\circ\tau=h`),
          "、すなわちすべての ",
          math(String.raw`v\in V^{\{1,\dots,k\}}`),
          " について ",
          math(String.raw`\overline{h}\bigl(\tau(v)\bigr)=h(v)`),
          " を満たすものが、ただ一つ存在する。",
        ],
      ]),
      paragraph([
        "この条件を ",
        math(String.raw`k`),
        " 重テンソル積の普遍性と呼ぶ。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_set_of_maps_between_initial_segments",
    kind: "definition",
    title: { text: "{1,…,k} から {1,…,n} への写像全体の集合" },
    labels: ["def_set_of_maps_between_initial_segments"],
    statement: [
      paragraph([
        math(String.raw`n,k\in\mathbb{Z}_{\ge 0}`),
        " について、",
        math(String.raw`\{1,\dots,k\}`),
        " から ",
        math(String.raw`\{1,\dots,n\}`),
        " への写像全体の集合を ",
        math(String.raw`X_{n,k}:=\{1,\dots,n\}^{\{1,\dots,k\}}`),
        " と書く。",
        math(String.raw`X_{n,k}`),
        " の二元 ",
        math(String.raw`x,y`),
        " が等しいとは、すべての ",
        math(String.raw`s\in\{1,\dots,k\}`),
        " について ",
        math(String.raw`x(s)=y(s)`),
        " であることである。",
        math(String.raw`k=0`),
        " のとき ",
        math(String.raw`\{1,\dots,0\}`),
        " は空集合であり、",
        math(String.raw`X_{n,0}`),
        " の元は空集合からの写像ただ一つである。それを ",
        math(String.raw`\varnothing_n`),
        " と書く。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_power_of_nonnegative_integer",
    kind: "definition",
    title: { text: "非負整数の冪" },
    labels: ["def_power_of_nonnegative_integer"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について、整数 ",
        math(String.raw`n^k\in\mathbb{Z}_{\ge 0}`),
        " を ",
        math(String.raw`k`),
        " についての帰納法で次のように定める。",
      ]),
      list([
        [math(String.raw`n^0:=1`)],
        [
          math(String.raw`n^k:=n\cdot n^{k-1}`),
          "（",
          math(String.raw`k\ge 1`),
          "）",
        ],
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_base_n_numbering_of_maps",
    kind: "definition",
    title: { text: "{1,…,k} から {1,…,n} への写像全体の n 進の番号付けの写像" },
    labels: ["def_base_n_numbering_of_maps"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について、写像 ",
        math(String.raw`\eta_{n,k}:\{1,\dots,n^k\}\to X_{n,k}`),
        "（",
        ref("def_power_of_nonnegative_integer"),
        "、",
        ref("def_set_of_maps_between_initial_segments"),
        "）を、",
        math(String.raw`k`),
        " についての帰納法で次のように定める。",
      ]),
      list([
        [
          math(String.raw`k=0`),
          " のとき、",
          math(String.raw`\{1,\dots,n^0\}=\{1\}`),
          " であり（",
          ref("def_power_of_nonnegative_integer"),
          "）、",
          math(String.raw`\eta_{n,0}(1):=\varnothing_n`),
          " とする。",
        ],
        [
          math(String.raw`k\ge 1`),
          " のとき、",
          math(String.raw`m\in\{1,\dots,n^k\}`),
          " について、",
          math(String.raw`m=(a-1)\cdot n^{k-1}+r`),
          " を満たす ",
          math(String.raw`a\in\{1,\dots,n\}`),
          " と ",
          math(String.raw`r\in\{1,\dots,n^{k-1}\}`),
          " の組がただ一つあり（下で確かめる）、",
          math(String.raw`\eta_{n,k}(m)\in X_{n,k}`),
          " を ",
          math(String.raw`\eta_{n,k}(m)(s):=\eta_{n,k-1}(r)(s)`),
          "（",
          math(String.raw`s\in\{1,\dots,k-1\}`),
          "）、",
          math(String.raw`\eta_{n,k}(m)(k):=a`),
          " で定める。",
        ],
      ]),
      paragraph([
        math(String.raw`k\ge 1`),
        " の場合の組 ",
        math(String.raw`(a,r)`),
        " の存在と一意性を確かめる。",
        math(String.raw`m\in\{1,\dots,n^k\}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
1
&\le m
&&\left(\because\ m\in\{1,\dots,n^k\}\right)\\
&\le n^k
&&\left(\because\ m\in\{1,\dots,n^k\}\right)\\
&=n\cdot n^{k-1}
&&\left(\because\ \blkref{def_power_of_nonnegative_integer}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`n`),
        " と ",
        math(String.raw`n^{k-1}`),
        " は非負整数で、どちらかが ",
        math(String.raw`0`),
        " なら積は ",
        math(String.raw`0`),
        " なので、",
        math(String.raw`n\ge 1`),
        " かつ ",
        math(String.raw`n^{k-1}\ge 1`),
        " である。",
        math(String.raw`\mathbb{Z}`),
        " の中の余りのある割り算（割る数 ",
        math(String.raw`n^{k-1}\ge 1`),
        "）により、",
        math(String.raw`m-1=q\cdot n^{k-1}+\rho`),
        " を満たす ",
        math(String.raw`q\in\mathbb{Z}_{\ge 0}`),
        " と ",
        math(String.raw`\rho\in\{0,\dots,n^{k-1}-1\}`),
        " がただ一つある（",
        math(String.raw`m-1\ge 0`),
        " なので ",
        math(String.raw`q\ge 0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
q\cdot n^{k-1}
&\le q\cdot n^{k-1}+\rho
&&\left(\because\ \rho\ge 0\right)\\
&=m-1
&&\left(\because\ q,\ \rho\ \text{の取り方}\right)\\
&\le n^k-1
&&\left(\because\ m\le n^k\right)\\
&=n\cdot n^{k-1}-1
&&\left(\because\ \blkref{def_power_of_nonnegative_integer}\right)\\
&<n\cdot n^{k-1}.
\end{aligned}`),
      paragraph([
        math(String.raw`n^{k-1}\ge 1`),
        " なので、",
        math(String.raw`q\cdot n^{k-1}<n\cdot n^{k-1}`),
        " から ",
        math(String.raw`q<n`),
        "、すなわち ",
        math(String.raw`q\le n-1`),
        " である。",
        math(String.raw`a:=q+1\in\{1,\dots,n\}`),
        "、",
        math(String.raw`r:=\rho+1\in\{1,\dots,n^{k-1}\}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
(a-1)\cdot n^{k-1}+r
&=q\cdot n^{k-1}+(\rho+1)
&&\left(\because\ a=q+1,\ r=\rho+1\right)\\
&=(q\cdot n^{k-1}+\rho)+1
&&\left(\because\ \text{加法の結合法則}\right)\\
&=(m-1)+1
&&\left(\because\ q,\ \rho\ \text{の取り方}\right)\\
&=m.
\end{aligned}`),
      paragraph([
        "逆に ",
        math(String.raw`a'\in\{1,\dots,n\}`),
        "、",
        math(String.raw`r'\in\{1,\dots,n^{k-1}\}`),
        " が ",
        math(String.raw`m=(a'-1)\cdot n^{k-1}+r'`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
m-1
&=\bigl((a'-1)\cdot n^{k-1}+r'\bigr)-1
&&\left(\because\ m=(a'-1)\cdot n^{k-1}+r'\right)\\
&=(a'-1)\cdot n^{k-1}+(r'-1)
&&\left(\because\ \text{加法の結合法則}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`a'-1\in\mathbb{Z}_{\ge 0}`),
        " かつ ",
        math(String.raw`r'-1\in\{0,\dots,n^{k-1}-1\}`),
        " なので、割り算の一意性から ",
        math(String.raw`a'-1=q`),
        "、",
        math(String.raw`r'-1=\rho`),
        "、すなわち ",
        math(String.raw`(a',r')=(a,r)`),
        " である。",
        math(String.raw`r\in\{1,\dots,n^{k-1}\}`),
        " なので、帰納的に定まっている ",
        math(String.raw`\eta_{n,k-1}(r)\in X_{n,k-1}`),
        " が使え、",
        math(String.raw`\eta_{n,k}(m)`),
        " は ",
        math(String.raw`\{1,\dots,k\}`),
        " の各元に ",
        math(String.raw`\{1,\dots,n\}`),
        " の元を一つずつ与える。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_base_n_numbering_is_numbering_of_maps",
    kind: "claim",
    title: { text: "n 進の番号付けの写像は {1,…,k} から {1,…,n} への写像全体の番号付けを与え、写像全体は有限集合である" },
    labels: ["claim_base_n_numbering_is_numbering_of_maps"],
    statement: [
      paragraph([
        math(String.raw`n,k\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`X_{n,k}`),
        "（",
        ref("def_set_of_maps_between_initial_segments"),
        "）、",
        math(String.raw`n^k`),
        "（",
        ref("def_power_of_nonnegative_integer"),
        "）、",
        math(String.raw`\eta_{n,k}:\{1,\dots,n^k\}\to X_{n,k}`),
        "（",
        ref("def_base_n_numbering_of_maps"),
        "）をとる。このとき組 ",
        math(String.raw`(n^k,\eta_{n,k})`),
        " は ",
        math(String.raw`X_{n,k}`),
        " の番号付け（",
        ref("def_numbering_of_finite_set"),
        "）である。したがって ",
        math(String.raw`X_{n,k}`),
        " は有限集合（",
        ref("def_numbering_of_finite_set"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で、",
        math(String.raw`\eta_{n,k}`),
        " が単射の条件と全射の条件（",
        ref("def_numbering_of_finite_set"),
        "）を満たすことを示す。",
        math(String.raw`X_{n,k}`),
        " の二元の等しさは、",
        ref("def_set_of_maps_between_initial_segments"),
        " のとおり各点の値で確かめる。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき。",
        math(String.raw`\{1,\dots,n^0\}=\{1\}`),
        " である（",
        ref("def_power_of_nonnegative_integer"),
        "）。単射の条件: ",
        math(String.raw`m,m'\in\{1\}`),
        " なら ",
        math(String.raw`m=1=m'`),
        " である。全射の条件: ",
        math(String.raw`X_{n,0}`),
        " の元は ",
        math(String.raw`\varnothing_n`),
        " ただ一つであり（",
        ref("def_set_of_maps_between_initial_segments"),
        "）、",
        math(String.raw`\eta_{n,0}(1)=\varnothing_n`),
        " である（",
        ref("def_base_n_numbering_of_maps"),
        "）。",
      ]),
      paragraph([
        math(String.raw`k\ge 1`),
        " とし、",
        math(String.raw`(n^{k-1},\eta_{n,k-1})`),
        " が ",
        math(String.raw`X_{n,k-1}`),
        " の番号付けであると仮定する（帰納法の仮定）。",
        math(String.raw`m\in\{1,\dots,n^k\}`),
        " について ",
        ref("def_base_n_numbering_of_maps"),
        " の組を ",
        math(String.raw`(a_m,r_m)`),
        " と書く。すなわち ",
        math(String.raw`a_m\in\{1,\dots,n\}`),
        "、",
        math(String.raw`r_m\in\{1,\dots,n^{k-1}\}`),
        "、",
        math(String.raw`m=(a_m-1)\cdot n^{k-1}+r_m`),
        " である。",
      ]),
      paragraph([
        "単射の条件を示す。",
        math(String.raw`m,m'\in\{1,\dots,n^k\}`),
        " が ",
        math(String.raw`\eta_{n,k}(m)=\eta_{n,k}(m')`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
a_m
&=\eta_{n,k}(m)(k)
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right)\\
&=\eta_{n,k}(m')(k)
&&\left(\because\ \eta_{n,k}(m)=\eta_{n,k}(m')\right)\\
&=a_{m'}
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`s\in\{1,\dots,k-1\}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\eta_{n,k-1}(r_m)(s)
&=\eta_{n,k}(m)(s)
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right)\\
&=\eta_{n,k}(m')(s)
&&\left(\because\ \eta_{n,k}(m)=\eta_{n,k}(m')\right)\\
&=\eta_{n,k-1}(r_{m'})(s)
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`X_{n,k-1}`),
        " の元として ",
        math(String.raw`\eta_{n,k-1}(r_m)=\eta_{n,k-1}(r_{m'})`),
        " であり（",
        ref("def_set_of_maps_between_initial_segments"),
        "）、帰納法の仮定の単射の条件から ",
        math(String.raw`r_m=r_{m'}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
m
&=(a_m-1)\cdot n^{k-1}+r_m
&&\left(\because\ (a_m,r_m)\ \text{の取り方}\right)\\
&=(a_{m'}-1)\cdot n^{k-1}+r_{m'}
&&\left(\because\ a_m=a_{m'},\ r_m=r_{m'}\right)\\
&=m'
&&\left(\because\ (a_{m'},r_{m'})\ \text{の取り方}\right).
\end{aligned}`),
      paragraph([
        "全射の条件を示す。",
        math(String.raw`x\in X_{n,k}`),
        " とし、",
        math(String.raw`a:=x(k)\in\{1,\dots,n\}`),
        "、",
        math(String.raw`x'\in X_{n,k-1}`),
        " を ",
        math(String.raw`x'(s):=x(s)`),
        "（",
        math(String.raw`s\in\{1,\dots,k-1\}`),
        "）と置く。帰納法の仮定の全射の条件から、",
        math(String.raw`\eta_{n,k-1}(r)=x'`),
        " を満たす ",
        math(String.raw`r\in\{1,\dots,n^{k-1}\}`),
        " がある。",
        math(String.raw`m:=(a-1)\cdot n^{k-1}+r`),
        " と置く。",
        math(String.raw`m\in\{1,\dots,n^k\}`),
        " であることを確かめる。",
      ]),
      displayMath(String.raw`\begin{aligned}
1
&\le r
&&\left(\because\ r\in\{1,\dots,n^{k-1}\}\right)\\
&\le (a-1)\cdot n^{k-1}+r
&&\left(\because\ a-1\ge 0,\ n^{k-1}\ge 0\right)\\
&=m
&&\left(\because\ m\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
m
&=(a-1)\cdot n^{k-1}+r
&&\left(\because\ m\ \text{の定義}\right)\\
&\le (n-1)\cdot n^{k-1}+r
&&\left(\because\ a\le n,\ n^{k-1}\ge 0\right)\\
&\le (n-1)\cdot n^{k-1}+n^{k-1}
&&\left(\because\ r\le n^{k-1}\right)\\
&=n\cdot n^{k-1}
&&\left(\because\ \text{分配法則}\right)\\
&=n^k
&&\left(\because\ \blkref{def_power_of_nonnegative_integer}\right).
\end{aligned}`),
      paragraph([
        ref("def_base_n_numbering_of_maps"),
        " の組の一意性から ",
        math(String.raw`(a_m,r_m)=(a,r)`),
        " である。",
        math(String.raw`s\in\{1,\dots,k-1\}`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
\eta_{n,k}(m)(s)
&=\eta_{n,k-1}(r_m)(s)
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right)\\
&=\eta_{n,k-1}(r)(s)
&&\left(\because\ r_m=r\right)\\
&=x'(s)
&&\left(\because\ r\ \text{の取り方}\ \eta_{n,k-1}(r)=x'\right)\\
&=x(s)
&&\left(\because\ x'\ \text{の定義}\right).
\end{aligned}`),
      paragraph(["また、"]),
      displayMath(String.raw`\begin{aligned}
\eta_{n,k}(m)(k)
&=a_m
&&\left(\because\ \eta_{n,k}\ \text{の定義。}\blkref{def_base_n_numbering_of_maps}\right)\\
&=a
&&\left(\because\ a_m=a\right)\\
&=x(k)
&&\left(\because\ a\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\eta_{n,k}(m)=x`),
        " である（",
        ref("def_set_of_maps_between_initial_segments"),
        "）。",
      ]),
      paragraph([
        "以上で、すべての ",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(n^k,\eta_{n,k})`),
        " が ",
        math(String.raw`X_{n,k}`),
        " の番号付けであることが示された。",
        math(String.raw`X_{n,k}`),
        " は番号付けを少なくとも一つもつので、有限集合である（",
        ref("def_numbering_of_finite_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_complex_valued_maps_on_set",
    kind: "definition",
    title: { text: "集合上の ℂ 値写像の集合と各点ごとの演算" },
    labels: ["def_complex_valued_maps_on_set"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を集合とする。",
        math(String.raw`X`),
        " から ",
        math(String.raw`\mathbb{C}`),
        " への写像全体の集合を ",
        math(String.raw`\mathbb{C}^X`),
        " と書く。",
        math(String.raw`A,B\in\mathbb{C}^X`),
        " が等しいとは、写像として等しいこと、すなわちすべての ",
        math(String.raw`x\in X`),
        " について ",
        math(String.raw`A(x)=B(x)`),
        " であることである。",
      ]),
      paragraph([
        "写像 ",
        math(String.raw`+_{\mathbb{C}^X}:\mathbb{C}^X\times\mathbb{C}^X\to\mathbb{C}^X`),
        "、",
        math(String.raw`\cdot_{\mathbb{C}^X}:\mathbb{C}\times\mathbb{C}^X\to\mathbb{C}^X`),
        " と元 ",
        math(String.raw`0_{\mathbb{C}^X}\in\mathbb{C}^X`),
        " を、",
        math(String.raw`A,B\in\mathbb{C}^X`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        "、",
        math(String.raw`x\in X`),
        " での値で次のように定める。",
      ]),
      list([
        [math(String.raw`(A+_{\mathbb{C}^X}B)(x):=A(x)+_{\mathbb{C}}B(x)`), "（各点ごとの和）"],
        [math(String.raw`(\lambda\cdot_{\mathbb{C}^X}A)(x):=\lambda\cdot_{\mathbb{C}}A(x)`), "（各点ごとのスカラー倍）"],
        [math(String.raw`0_{\mathbb{C}^X}(x):=0_{\mathbb{C}}`), "（零写像）"],
      ]),
      paragraph([
        "三つの右辺はどれも ",
        math(String.raw`x\in X`),
        " ごとに ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定めるので、左辺は ",
        math(String.raw`\mathbb{C}^X`),
        " の元として一つに決まる。演算には ",
        math(String.raw`\mathbb{C}^X`),
        " を添字で書き、値の側の ",
        math(String.raw`\mathbb{C}`),
        " の演算 ",
        math(String.raw`+_{\mathbb{C}},\ \cdot_{\mathbb{C}}`),
        " と区別する。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_complex_valued_maps_form_complex_vector_space",
    kind: "claim",
    title: { text: "集合上の ℂ 値写像の集合は、各点ごとの和とスカラー倍で ℂ-線型空間である" },
    labels: ["claim_complex_valued_maps_on_set_form_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`X`),
        " を集合とする。組 ",
        math(String.raw`(\mathbb{C}^X,+_{\mathbb{C}^X},\cdot_{\mathbb{C}^X},0_{\mathbb{C}^X})`),
        "（",
        ref("def_complex_valued_maps_on_set"),
        "）は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A,B,C`),
        " を ",
        math(String.raw`\mathbb{C}^X`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。どの条件も ",
        math(String.raw`\mathbb{C}^X`),
        " の二つの元の等式であり、",
        math(String.raw`\mathbb{C}^X`),
        " の二つの元が等しいことは、すべての ",
        math(String.raw`x\in X`),
        " について ",
        math(String.raw`x`),
        " での値どうしが ",
        math(String.raw`\mathbb{C}`),
        " の元として等しいことである（",
        ref("def_complex_valued_maps_on_set"),
        "）。以下の各式変形は、",
        math(String.raw`x\in X`),
        " を任意に固定した ",
        math(String.raw`\mathbb{C}`),
        " の中の等式の連なりである。",
      ]),
      paragraph(["加法の結合法則 ", math(String.raw`(A+_{\mathbb{C}^X}B)+_{\mathbb{C}^X}C=A+_{\mathbb{C}^X}(B+_{\mathbb{C}^X}C)`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((A+_{\mathbb{C}^X}B)+_{\mathbb{C}^X}C\bigr)(x)
&=(A+_{\mathbb{C}^X}B)(x)+_{\mathbb{C}}C(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=(A(x)+_{\mathbb{C}}B(x))+_{\mathbb{C}}C(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=A(x)+_{\mathbb{C}}(B(x)+_{\mathbb{C}}C(x))
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=A(x)+_{\mathbb{C}}(B+_{\mathbb{C}^X}C)(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\bigl(A+_{\mathbb{C}^X}(B+_{\mathbb{C}^X}C)\bigr)(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["加法の交換法則 ", math(String.raw`A+_{\mathbb{C}^X}B=B+_{\mathbb{C}^X}A`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathbb{C}^X}B)(x)
&=A(x)+_{\mathbb{C}}B(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=B(x)+_{\mathbb{C}}A(x)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=(B+_{\mathbb{C}^X}A)(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["加法の単位元 ", math(String.raw`A+_{\mathbb{C}^X}0_{\mathbb{C}^X}=A`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathbb{C}^X}0_{\mathbb{C}^X})(x)
&=A(x)+_{\mathbb{C}}(0_{\mathbb{C}^X})(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=A(x)+_{\mathbb{C}}0_{\mathbb{C}}
&&\left(\because\ 0_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=A(x)
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元は次のとおりである。",
        math(String.raw`\mathbb{C}`),
        " の各元は ",
        math(String.raw`\mathbb{C}`),
        " の加法の逆元をただ一つもつので、",
        math(String.raw`a\in\mathbb{C}`),
        " の加法の逆元を ",
        math(String.raw`-_{\mathbb{C}}a\in\mathbb{C}`),
        " と書く（",
        math(String.raw`a+_{\mathbb{C}}(-_{\mathbb{C}}a)=0_{\mathbb{C}}`),
        "）。写像 ",
        math(String.raw`A':X\to\mathbb{C}`),
        " を ",
        math(String.raw`A'(x):=-_{\mathbb{C}}A(x)`),
        "（",
        math(String.raw`x\in X`),
        "）で定めると、",
        math(String.raw`A'\in\mathbb{C}^X`),
        " であり（",
        ref("def_complex_valued_maps_on_set"),
        "）、",
        math(String.raw`A+_{\mathbb{C}^X}A'=0_{\mathbb{C}^X}`),
        " を満たす。これは、すべての ",
        math(String.raw`x\in X`),
        " について次の値の等式が成り立つことである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(A+_{\mathbb{C}^X}A')(x)
&=A(x)+_{\mathbb{C}}A'(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=A(x)+_{\mathbb{C}}(-_{\mathbb{C}}A(x))
&&\left(\because\ A'\ \text{の定義}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ -_{\mathbb{C}}A(x)\ \text{は}\ A(x)\ \text{の}\ \mathbb{C}\ \text{の加法の逆元}\right)\\
&=(0_{\mathbb{C}^X})(x)
&&\left(\because\ 0_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則 ", math(String.raw`(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^X}A=\lambda\cdot_{\mathbb{C}^X}(\mu\cdot_{\mathbb{C}^X}A)`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^X}A\bigr)(x)
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}A(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}A(x))
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(\mu\cdot_{\mathbb{C}^X}A)(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}^X}(\mu\cdot_{\mathbb{C}^X}A)\bigr)(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元 ", math(String.raw`1_{\mathbb{C}}\cdot_{\mathbb{C}^X}A=A`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
(1_{\mathbb{C}}\cdot_{\mathbb{C}^X}A)(x)
&=1_{\mathbb{C}}\cdot_{\mathbb{C}}A(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=A(x)
&&\left(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の乗法の単位元}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則 ", math(String.raw`\lambda\cdot_{\mathbb{C}^X}(A+_{\mathbb{C}^X}B)=(\lambda\cdot_{\mathbb{C}^X}A)+_{\mathbb{C}^X}(\lambda\cdot_{\mathbb{C}^X}B)`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\cdot_{\mathbb{C}^X}(A+_{\mathbb{C}^X}B)\bigr)(x)
&=\lambda\cdot_{\mathbb{C}}(A+_{\mathbb{C}^X}B)(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\lambda\cdot_{\mathbb{C}}(A(x)+_{\mathbb{C}}B(x))
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=(\lambda\cdot_{\mathbb{C}}A(x))+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}B(x))
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}^X}A)(x)+_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}^X}B)(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義を二か所に適用。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\bigl((\lambda\cdot_{\mathbb{C}^X}A)+_{\mathbb{C}^X}(\lambda\cdot_{\mathbb{C}^X}B)\bigr)(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則 ", math(String.raw`(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^X}A=(\lambda\cdot_{\mathbb{C}^X}A)+_{\mathbb{C}^X}(\mu\cdot_{\mathbb{C}^X}A)`), " は、すべての ", math(String.raw`x\in X`), " について次の値の等式が成り立つことである。"]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}^X}A\bigr)(x)
&=(\lambda+_{\mathbb{C}}\mu)\cdot_{\mathbb{C}}A(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=(\lambda\cdot_{\mathbb{C}}A(x))+_{\mathbb{C}}(\mu\cdot_{\mathbb{C}}A(x))
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}^X}A)(x)+_{\mathbb{C}}(\mu\cdot_{\mathbb{C}^X}A)(x)
&&\left(\because\ \cdot_{\mathbb{C}^X}\ \text{の定義を二か所に適用。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\bigl((\lambda\cdot_{\mathbb{C}^X}A)+_{\mathbb{C}^X}(\mu\cdot_{\mathbb{C}^X}A)\bigr)(x)
&&\left(\because\ +_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph([
        "八つの条件が満たされたので、組 ",
        math(String.raw`(\mathbb{C}^X,+_{\mathbb{C}^X},\cdot_{\mathbb{C}^X},0_{\mathbb{C}^X})`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_ordered_product_in_complex_numbers",
    kind: "definition",
    title: { text: "ℂ の中の番号順の積" },
    labels: ["def_ordered_product_in_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とし、",
        math(String.raw`\{1,\dots,k\}`),
        " の各元 ",
        math(String.raw`r`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_r`),
        " が一つずつ与えられているとする（",
        math(String.raw`k=0`),
        " のときは何も与えられていない）。",
        math(String.raw`m\in\{0,1,\dots,k\}`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`P_m`),
        " を次で帰納的に定める。",
      ]),
      list([
        [math(String.raw`P_0:=1_{\mathbb{C}}`)],
        [
          math(String.raw`P_m:=P_{m-1}\cdot_{\mathbb{C}}\alpha_m`),
          "（",
          math(String.raw`1\le m\le k`),
          "）",
        ],
      ]),
      paragraph([
        math(String.raw`P_k`),
        " を ",
        math(String.raw`\alpha_1,\dots,\alpha_k`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の積と呼び、",
        math(String.raw`\prod_{\mathbb{C},\,r=1}^{k}\alpha_r`),
        " と書く。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_is_additive_in_one_factor",
    kind: "claim",
    title: { text: "ℂ の中の番号順の積は、一つの因子についての和を積の和へ移す" },
    labels: ["claim_ordered_product_is_additive_in_one_factor"],
    statement: [
      paragraph([
        math(String.raw`k\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        " とし、",
        math(String.raw`\{1,\dots,k\}`),
        " の各元 ",
        math(String.raw`s`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_s,\ \alpha'_s,\ \alpha''_s`),
        " が一つずつ与えられていて、次を満たすとする。",
      ]),
      list([
        [
          math(String.raw`s\neq r`),
          " のとき ",
          math(String.raw`\alpha_s=\alpha'_s=\alpha''_s`),
        ],
        [math(String.raw`\alpha_r=\alpha'_r+_{\mathbb{C}}\alpha''_r`)],
      ]),
      paragraph([
        "このとき、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の積（",
        ref("def_ordered_product_in_complex_numbers"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\prod_{\mathbb{C},\,s=1}^{k}\alpha_s=\left(\prod_{\mathbb{C},\,s=1}^{k}\alpha'_s\right)+_{\mathbb{C}}\left(\prod_{\mathbb{C},\,s=1}^{k}\alpha''_s\right)`),
    ],
    proof: [
      paragraph([
        "三つの積について番号順の積の定義（",
        ref("def_ordered_product_in_complex_numbers"),
        "）が帰納的に定める元を、順に ",
        math(String.raw`P_m,\ P'_m,\ P''_m\in\mathbb{C}`),
        "（",
        math(String.raw`m\in\{0,1,\dots,k\}`),
        "）と書く。",
        math(String.raw`m`),
        " についての帰納法で、",
        math(String.raw`m<r`),
        " なら ",
        math(String.raw`P_m=P'_m=P''_m`),
        "、",
        math(String.raw`m\ge r`),
        " なら ",
        math(String.raw`P_m=P'_m+_{\mathbb{C}}P''_m`),
        " であることを示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき、",
        math(String.raw`0<r`),
        " であり、",
        math(String.raw`P_0=1_{\mathbb{C}}=P'_0=P''_0`),
        " である（",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
        math(String.raw`1\le m\le k`),
        " とし、",
        math(String.raw`m-1`),
        " について主張が成り立つとする（帰納法の仮定）。",
      ]),
      paragraph([
        math(String.raw`m<r`),
        " のとき、",
        math(String.raw`m-1<r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{m-1}=P'_{m-1}=P''_{m-1}`),
        " であり、",
        math(String.raw`m\neq r`),
        " なので ",
        math(String.raw`\alpha_m=\alpha'_m=\alpha''_m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_m
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ P_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P'_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\ P_{m-1}=P'_{m-1}\right)\\
&=P'_{m-1}\cdot_{\mathbb{C}}\alpha'_m
&&\left(\because\ \alpha_m=\alpha'_m\right)\\
&=P'_m
&&\left(\because\ P'_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
P_m
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ P_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P''_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\ P_{m-1}=P''_{m-1}\right)\\
&=P''_{m-1}\cdot_{\mathbb{C}}\alpha''_m
&&\left(\because\ \alpha_m=\alpha''_m\right)\\
&=P''_m
&&\left(\because\ P''_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=r`),
        " のとき、",
        math(String.raw`m-1=r-1<r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{r-1}=P'_{r-1}=P''_{r-1}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_r
&=P_{r-1}\cdot_{\mathbb{C}}\alpha_r
&&\left(\because\ P_r\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P_{r-1}\cdot_{\mathbb{C}}(\alpha'_r+_{\mathbb{C}}\alpha''_r)
&&\left(\because\ \alpha_r=\alpha'_r+_{\mathbb{C}}\alpha''_r\right)\\
&=(P_{r-1}\cdot_{\mathbb{C}}\alpha'_r)+_{\mathbb{C}}(P_{r-1}\cdot_{\mathbb{C}}\alpha''_r)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(P'_{r-1}\cdot_{\mathbb{C}}\alpha'_r)+_{\mathbb{C}}(P''_{r-1}\cdot_{\mathbb{C}}\alpha''_r)
&&\left(\because\ \text{帰納法の仮定}\ P_{r-1}=P'_{r-1}=P''_{r-1}\right)\\
&=P'_r+_{\mathbb{C}}P''_r
&&\left(\because\ P'_r,\ P''_r\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m>r`),
        " のとき、",
        math(String.raw`m-1\ge r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{m-1}=P'_{m-1}+_{\mathbb{C}}P''_{m-1}`),
        " であり、",
        math(String.raw`m\neq r`),
        " なので ",
        math(String.raw`\alpha_m=\alpha'_m=\alpha''_m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_m
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ P_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=(P'_{m-1}+_{\mathbb{C}}P''_{m-1})\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=(P'_{m-1}\cdot_{\mathbb{C}}\alpha_m)+_{\mathbb{C}}(P''_{m-1}\cdot_{\mathbb{C}}\alpha_m)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=(P'_{m-1}\cdot_{\mathbb{C}}\alpha'_m)+_{\mathbb{C}}(P''_{m-1}\cdot_{\mathbb{C}}\alpha''_m)
&&\left(\because\ \alpha_m=\alpha'_m=\alpha''_m\right)\\
&=P'_m+_{\mathbb{C}}P''_m
&&\left(\because\ P'_m,\ P''_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`r\le k`),
        " なので、これを ",
        math(String.raw`m=k`),
        " で使うと ",
        math(String.raw`\prod_{\mathbb{C},\,s=1}^{k}\alpha_s=P_k=P'_k+_{\mathbb{C}}P''_k`),
        " であり、右辺は主張の右辺である（",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_is_homogeneous_in_one_factor",
    kind: "claim",
    title: { text: "ℂ の中の番号順の積は、一つの因子のスカラー倍を積のスカラー倍へ移す" },
    labels: ["claim_ordered_product_is_homogeneous_in_one_factor"],
    statement: [
      paragraph([
        math(String.raw`k\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " とし、",
        math(String.raw`\{1,\dots,k\}`),
        " の各元 ",
        math(String.raw`s`),
        " に ",
        math(String.raw`\mathbb{C}`),
        " の元 ",
        math(String.raw`\alpha_s,\ \alpha'_s`),
        " が一つずつ与えられていて、次を満たすとする。",
      ]),
      list([
        [
          math(String.raw`s\neq r`),
          " のとき ",
          math(String.raw`\alpha_s=\alpha'_s`),
        ],
        [math(String.raw`\alpha_r=\lambda\cdot_{\mathbb{C}}\alpha'_r`)],
      ]),
      paragraph([
        "このとき、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の積（",
        ref("def_ordered_product_in_complex_numbers"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\prod_{\mathbb{C},\,s=1}^{k}\alpha_s=\lambda\cdot_{\mathbb{C}}\prod_{\mathbb{C},\,s=1}^{k}\alpha'_s`),
    ],
    proof: [
      paragraph([
        "二つの積について番号順の積の定義（",
        ref("def_ordered_product_in_complex_numbers"),
        "）が帰納的に定める元を、順に ",
        math(String.raw`P_m,\ P'_m\in\mathbb{C}`),
        "（",
        math(String.raw`m\in\{0,1,\dots,k\}`),
        "）と書く。",
        math(String.raw`m`),
        " についての帰納法で、",
        math(String.raw`m<r`),
        " なら ",
        math(String.raw`P_m=P'_m`),
        "、",
        math(String.raw`m\ge r`),
        " なら ",
        math(String.raw`P_m=\lambda\cdot_{\mathbb{C}}P'_m`),
        " であることを示す。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " のとき、",
        math(String.raw`0<r`),
        " であり、",
        math(String.raw`P_0=1_{\mathbb{C}}=P'_0`),
        " である（",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
        math(String.raw`1\le m\le k`),
        " とし、",
        math(String.raw`m-1`),
        " について主張が成り立つとする（帰納法の仮定）。",
      ]),
      paragraph([
        math(String.raw`m<r`),
        " のとき、",
        math(String.raw`m-1<r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{m-1}=P'_{m-1}`),
        " であり、",
        math(String.raw`m\neq r`),
        " なので ",
        math(String.raw`\alpha_m=\alpha'_m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_m
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ P_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P'_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\ P_{m-1}=P'_{m-1}\right)\\
&=P'_{m-1}\cdot_{\mathbb{C}}\alpha'_m
&&\left(\because\ \alpha_m=\alpha'_m\right)\\
&=P'_m
&&\left(\because\ P'_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m=r`),
        " のとき、",
        math(String.raw`m-1=r-1<r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{r-1}=P'_{r-1}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_r
&=P_{r-1}\cdot_{\mathbb{C}}\alpha_r
&&\left(\because\ P_r\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=P_{r-1}\cdot_{\mathbb{C}}(\lambda\cdot_{\mathbb{C}}\alpha'_r)
&&\left(\because\ \alpha_r=\lambda\cdot_{\mathbb{C}}\alpha'_r\right)\\
&=(P_{r-1}\cdot_{\mathbb{C}}\lambda)\cdot_{\mathbb{C}}\alpha'_r
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=(\lambda\cdot_{\mathbb{C}}P_{r-1})\cdot_{\mathbb{C}}\alpha'_r
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(P_{r-1}\cdot_{\mathbb{C}}\alpha'_r)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(P'_{r-1}\cdot_{\mathbb{C}}\alpha'_r)
&&\left(\because\ \text{帰納法の仮定}\ P_{r-1}=P'_{r-1}\right)\\
&=\lambda\cdot_{\mathbb{C}}P'_r
&&\left(\because\ P'_r\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`m>r`),
        " のとき、",
        math(String.raw`m-1\ge r`),
        " なので帰納法の仮定から ",
        math(String.raw`P_{m-1}=\lambda\cdot_{\mathbb{C}}P'_{m-1}`),
        " であり、",
        math(String.raw`m\neq r`),
        " なので ",
        math(String.raw`\alpha_m=\alpha'_m`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
P_m
&=P_{m-1}\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ P_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right)\\
&=(\lambda\cdot_{\mathbb{C}}P'_{m-1})\cdot_{\mathbb{C}}\alpha_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\lambda\cdot_{\mathbb{C}}(P'_{m-1}\cdot_{\mathbb{C}}\alpha_m)
&&\left(\because\ \mathbb{C}\ \text{の乗法の結合法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}(P'_{m-1}\cdot_{\mathbb{C}}\alpha'_m)
&&\left(\because\ \alpha_m=\alpha'_m\right)\\
&=\lambda\cdot_{\mathbb{C}}P'_m
&&\left(\because\ P'_m\ \text{の定義。}\blkref{def_ordered_product_in_complex_numbers}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`r\le k`),
        " なので、これを ",
        math(String.raw`m=k`),
        " で使うと ",
        math(String.raw`\prod_{\mathbb{C},\,s=1}^{k}\alpha_s=P_k=\lambda\cdot_{\mathbb{C}}P'_k`),
        " であり、右辺は主張の右辺である（",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_construction_of_k_fold_tensor_product",
    kind: "definition",
    title: { text: "基底の座標による k 重テンソル積の構成" },
    labels: ["def_construction_of_k_fold_tensor_product"],
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
        " の基底（",
        ref("def_basis"),
        "）、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。",
        math(String.raw`X:=X_{n,k}=\{1,\dots,n\}^{\{1,\dots,k\}}`),
        "（",
        ref("def_set_of_maps_between_initial_segments"),
        "）と置き、",
        math(String.raw`T:=\mathbb{C}^X`),
        " を各点ごとの演算による ℂ-線型空間（",
        ref("def_complex_valued_maps_on_set"),
        "、",
        ref("claim_complex_valued_maps_on_set_form_complex_vector_space"),
        "）とする。",
      ]),
      paragraph([
        "写像 ",
        math(String.raw`\tau:V^{\{1,\dots,k\}}\to T`),
        "（",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " は ",
        ref("def_k_multilinear_map"),
        " の組の集合）を、",
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        " と ",
        math(String.raw`x\in X`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の中の番号順の積（",
        ref("def_ordered_product_in_complex_numbers"),
        "）で次のように定める。",
      ]),
      displayMath(String.raw`\tau(v)(x):=\prod_{\mathbb{C},\,r=1}^{k}\beta^{b}_{x(r)}\bigl(v(r)\bigr)`),
      paragraph([
        "ここで ",
        math(String.raw`\beta^{b}_{i}:V\to\mathbb{C}`),
        "（",
        math(String.raw`i\in\{1,\dots,n\}`),
        "）は基底 ",
        math(String.raw`b`),
        " についての第 ",
        math(String.raw`i`),
        " 座標の写像（",
        ref("claim_coordinate_map_is_linear_form"),
        "）である。",
        math(String.raw`k\ge 1`),
        " で ",
        math(String.raw`x\in X`),
        " があれば ",
        math(String.raw`x(1)\in\{1,\dots,n\}`),
        " なので ",
        math(String.raw`n\ge 1`),
        " であり、座標の写像が定まる。",
        math(String.raw`k=0`),
        " のときは右辺は空の積 ",
        math(String.raw`1_{\mathbb{C}}`),
        " であり、座標の写像を使わない。右辺は ",
        math(String.raw`x\in X`),
        " ごとに ",
        math(String.raw`\mathbb{C}`),
        " の元を一つ定めるので、",
        math(String.raw`\tau(v)`),
        " は ",
        math(String.raw`T`),
        " の元として一つに決まる。",
      ]),
      paragraph([
        "組 ",
        math(String.raw`(T,\tau)`),
        " を、基底 ",
        math(String.raw`b`),
        " の座標による ",
        math(String.raw`V`),
        " の ",
        math(String.raw`k`),
        " 重テンソル積の構成と呼び、",
        math(String.raw`V^{\otimes_b k}:=T`),
        "、",
        math(String.raw`\tau_{b,k}:=\tau`),
        " とも書く。",
        math(String.raw`\tau`),
        " が ",
        math(String.raw`k`),
        " 重線型写像であることと、",
        math(String.raw`(T,\tau)`),
        " が ",
        math(String.raw`k`),
        " 重テンソル積（",
        ref("def_k_fold_tensor_product"),
        "）であることは、この定義では主張しない。後の主張で示す。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_coordinate_product_map_is_k_multilinear",
    kind: "claim",
    title: { text: "基底の座標の積で定めた写像は k 重線型写像である" },
    labels: ["claim_coordinate_product_map_is_k_multilinear"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のものとする。このとき ",
        math(String.raw`\tau:V^{\{1,\dots,k\}}\to T`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`T`),
        " への ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k=0`),
        " のときは条件が無い（",
        ref("def_k_multilinear_map"),
        "）。",
        math(String.raw`k\ge 1`),
        " とし、",
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`y,z\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る。",
        math(String.raw`T`),
        " の元の等しさは各 ",
        math(String.raw`x\in X`),
        " での値の等しさなので（",
        ref("def_complex_valued_maps_on_set"),
        "）、",
        math(String.raw`x\in X`),
        " を任意に取る。",
        math(String.raw`s\in\{1,\dots,k\}`),
        " について ",
        math(String.raw`\mathbb{C}`),
        " の元を次で置く。",
      ]),
      list([
        [math(String.raw`\alpha_s:=\beta^{b}_{x(s)}\bigl(v[r\mapsto y+_V z](s)\bigr)`)],
        [math(String.raw`\alpha'_s:=\beta^{b}_{x(s)}\bigl(v[r\mapsto y](s)\bigr)`)],
        [math(String.raw`\alpha''_s:=\beta^{b}_{x(s)}\bigl(v[r\mapsto z](s)\bigr)`)],
        [math(String.raw`\gamma_s:=\beta^{b}_{x(s)}\bigl(v[r\mapsto \lambda\cdot_V y](s)\bigr)`)],
      ]),
      paragraph([
        math(String.raw`s\neq r`),
        " のとき、四つの組の第 ",
        math(String.raw`s`),
        " 成分はどれも ",
        math(String.raw`v(s)`),
        " なので（",
        ref("def_tuple_with_one_component_replaced"),
        "）、",
        math(String.raw`\alpha_s=\alpha'_s=\alpha''_s=\gamma_s`),
        " である。",
        math(String.raw`s=r`),
        " では次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha_r
&=\beta^{b}_{x(r)}(y+_V z)
&&\left(\because\ v[r\mapsto y+_V z](r)=y+_V z\text{。}\blkref{def_tuple_with_one_component_replaced}\right)\\
&=\beta^{b}_{x(r)}(y)+_{\mathbb{C}}\beta^{b}_{x(r)}(z)
&&\left(\because\ \beta^{b}_{x(r)}\ \text{は線型形式。}\blkref{claim_coordinate_map_is_linear_form}\text{、}\blkref{def_linear_form}\right)\\
&=\alpha'_r+_{\mathbb{C}}\alpha''_r
&&\left(\because\ \alpha'_r,\ \alpha''_r\ \text{の定義と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_r
&=\beta^{b}_{x(r)}(\lambda\cdot_V y)
&&\left(\because\ v[r\mapsto \lambda\cdot_V y](r)=\lambda\cdot_V y\text{。}\blkref{def_tuple_with_one_component_replaced}\right)\\
&=\lambda\cdot_{\mathbb{C}}\beta^{b}_{x(r)}(y)
&&\left(\because\ \beta^{b}_{x(r)}\ \text{は線型形式。}\blkref{claim_coordinate_map_is_linear_form}\text{、}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\alpha'_r
&&\left(\because\ \alpha'_r\ \text{の定義と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph(["加法を保つこと："]),
      displayMath(String.raw`\begin{aligned}
\tau\bigl(v[r\mapsto y+_V z]\bigr)(x)
&=\prod_{\mathbb{C},\,s=1}^{k}\alpha_s
&&\left(\because\ \tau\ \text{の定義。}\blkref{def_construction_of_k_fold_tensor_product}\right)\\
&=\left(\prod_{\mathbb{C},\,s=1}^{k}\alpha'_s\right)+_{\mathbb{C}}\left(\prod_{\mathbb{C},\,s=1}^{k}\alpha''_s\right)
&&\left(\because\ \blkref{claim_ordered_product_is_additive_in_one_factor}\right)\\
&=\tau\bigl(v[r\mapsto y]\bigr)(x)+_{\mathbb{C}}\tau\bigl(v[r\mapsto z]\bigr)(x)
&&\left(\because\ \tau\ \text{の定義を二か所に適用。}\blkref{def_construction_of_k_fold_tensor_product}\right)\\
&=\Bigl(\tau\bigl(v[r\mapsto y]\bigr)+_{T}\tau\bigl(v[r\mapsto z]\bigr)\Bigr)(x)
&&\left(\because\ +_{T}=+_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つこと："]),
      displayMath(String.raw`\begin{aligned}
\tau\bigl(v[r\mapsto \lambda\cdot_V y]\bigr)(x)
&=\prod_{\mathbb{C},\,s=1}^{k}\gamma_s
&&\left(\because\ \tau\ \text{の定義。}\blkref{def_construction_of_k_fold_tensor_product}\right)\\
&=\lambda\cdot_{\mathbb{C}}\prod_{\mathbb{C},\,s=1}^{k}\alpha'_s
&&\left(\because\ \blkref{claim_ordered_product_is_homogeneous_in_one_factor}\right)\\
&=\lambda\cdot_{\mathbb{C}}\tau\bigl(v[r\mapsto y]\bigr)(x)
&&\left(\because\ \tau\ \text{の定義。}\blkref{def_construction_of_k_fold_tensor_product}\right)\\
&=\Bigl(\lambda\cdot_{T}\tau\bigl(v[r\mapsto y]\bigr)\Bigr)(x)
&&\left(\because\ \cdot_{T}=\cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`x\in X`),
        " は任意だったので、",
        math(String.raw`T`),
        " の元として二つの条件の等式が成り立ち（",
        ref("def_complex_valued_maps_on_set"),
        "）、",
        math(String.raw`\tau`),
        " は ",
        math(String.raw`k`),
        " 重線型写像である（",
        ref("def_k_multilinear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta",
    kind: "claim",
    title: { text: "基底の元の組での座標の積は、写像のクロネッカーのデルタである" },
    labels: ["claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のものとし、",
        math(String.raw`x\in X`),
        " について ",
        math(String.raw`b\circ x\in V^{\{1,\dots,k\}}`),
        " を ",
        math(String.raw`(b\circ x)(r):=b_{x(r)}`),
        "（",
        math(String.raw`r\in\{1,\dots,k\}`),
        "）で定める。このとき、すべての ",
        math(String.raw`x,y\in X`),
        " について、集合 ",
        math(String.raw`X`),
        " の二元のクロネッカーのデルタ（",
        ref("def_kronecker_delta"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`\tau(b\circ x)(y)=\delta_{x,y}`),
    ],
    proof: [
      paragraph([
        math(String.raw`k=0`),
        " のとき、",
        math(String.raw`X`),
        " の元は ",
        math(String.raw`\varnothing_n`),
        " ただ一つなので ",
        math(String.raw`x=y`),
        " であり、",
        math(String.raw`\tau(b\circ x)(y)`),
        " は空の積 ",
        math(String.raw`1_{\mathbb{C}}`),
        " である（",
        ref("def_construction_of_k_fold_tensor_product"),
        "、",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
        math(String.raw`\delta_{x,y}=1_{\mathbb{C}}`),
        " なので主張が成り立つ。",
      ]),
      paragraph([
        math(String.raw`k\ge 1`),
        " のとき、",
        math(String.raw`x(1)\in\{1,\dots,n\}`),
        " なので ",
        math(String.raw`n\ge 1`),
        " である。",
        math(String.raw`r\in\{1,\dots,k\}`),
        " について ",
        math(String.raw`\alpha_r:=\beta^{b}_{y(r)}\bigl((b\circ x)(r)\bigr)\in\mathbb{C}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\alpha_r
&=\beta^{b}_{y(r)}\bigl(b_{x(r)}\bigr)
&&\left(\because\ b\circ x\ \text{の定義}\right)\\
&=\delta_{y(r),x(r)}
&&\left(\because\ \text{座標の写像の族は双対基底。}\blkref{claim_coordinate_maps_form_dual_basis}\right).
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`\delta_{y(r),x(r)}`),
        " は ",
        math(String.raw`\{1,\dots,n\}`),
        " の二元のクロネッカーのデルタである。",
        math(String.raw`\alpha_1,\dots,\alpha_k`),
        " の番号順の積の定義（",
        ref("def_ordered_product_in_complex_numbers"),
        "）が定める元を ",
        math(String.raw`P_m`),
        "（",
        math(String.raw`m\in\{0,1,\dots,k\}`),
        "）と書く。",
        math(String.raw`m`),
        " についての帰納法で、「すべての ",
        math(String.raw`s\in\{1,\dots,m\}`),
        " について ",
        math(String.raw`y(s)=x(s)`),
        "」なら ",
        math(String.raw`P_m=1_{\mathbb{C}}`),
        "、そうでなければ ",
        math(String.raw`P_m=0_{\mathbb{C}}`),
        " であることを示す。",
        math(String.raw`m=0`),
        " のとき、条件は空に成り立ち、",
        math(String.raw`P_0=1_{\mathbb{C}}`),
        " である。",
        math(String.raw`1\le m\le k`),
        " とし、",
        math(String.raw`m-1`),
        " について成り立つとする。",
        math(String.raw`P_m=P_{m-1}\cdot_{\mathbb{C}}\delta_{y(m),x(m)}`),
        " である（",
        ref("def_ordered_product_in_complex_numbers"),
        "）。",
      ]),
      list([
        [
          "すべての ",
          math(String.raw`s\in\{1,\dots,m\}`),
          " について ",
          math(String.raw`y(s)=x(s)`),
          " のとき、帰納法の仮定から ",
          math(String.raw`P_{m-1}=1_{\mathbb{C}}`),
          "、また ",
          math(String.raw`\delta_{y(m),x(m)}=1_{\mathbb{C}}`),
          " なので、",
          math(String.raw`P_m=1_{\mathbb{C}}\cdot_{\mathbb{C}}1_{\mathbb{C}}=1_{\mathbb{C}}`),
          " である。",
        ],
        [
          math(String.raw`y(s)\neq x(s)`),
          " となる ",
          math(String.raw`s\in\{1,\dots,m-1\}`),
          " があるとき、帰納法の仮定から ",
          math(String.raw`P_{m-1}=0_{\mathbb{C}}`),
          " なので、",
          math(String.raw`P_m=0_{\mathbb{C}}\cdot_{\mathbb{C}}\delta_{y(m),x(m)}=0_{\mathbb{C}}`),
          " である。",
        ],
        [
          "すべての ",
          math(String.raw`s\in\{1,\dots,m-1\}`),
          " について ",
          math(String.raw`y(s)=x(s)`),
          " で、",
          math(String.raw`y(m)\neq x(m)`),
          " のとき、",
          math(String.raw`\delta_{y(m),x(m)}=0_{\mathbb{C}}`),
          " なので、",
          math(String.raw`P_m=P_{m-1}\cdot_{\mathbb{C}}0_{\mathbb{C}}=0_{\mathbb{C}}`),
          " である。",
        ],
      ]),
      paragraph([
        "三つの場合は ",
        math(String.raw`m`),
        " についての二つの場合を尽くす。これを ",
        math(String.raw`m=k`),
        " で使う。「すべての ",
        math(String.raw`s\in\{1,\dots,k\}`),
        " について ",
        math(String.raw`y(s)=x(s)`),
        "」は写像として ",
        math(String.raw`x=y`),
        " であることなので、",
        math(String.raw`\tau(b\circ x)(y)=P_k`),
        " は ",
        math(String.raw`x=y`),
        " なら ",
        math(String.raw`1_{\mathbb{C}}`),
        "、そうでなければ ",
        math(String.raw`0_{\mathbb{C}}`),
        " であり、",
        math(String.raw`\delta_{x,y}`),
        " に等しい（",
        ref("def_construction_of_k_fold_tensor_product"),
        "、",
        ref("def_kronecker_delta"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_coordinate_tensor_space_element_is_sum_of_basis_tensors",
    kind: "claim",
    title: { text: "構成したテンソル積の元は、基底の元の組の像の有限集合の上の和である" },
    labels: ["claim_coordinate_tensor_space_element_is_sum_of_basis_tensors"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のもの、",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）を ",
        ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとする。",
        math(String.raw`X`),
        " は有限集合である（",
        ref("claim_base_n_numbering_is_numbering_of_maps"),
        "）。このとき、すべての ",
        math(String.raw`F\in T`),
        " について、",
        math(String.raw`T`),
        " の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）で次が成り立つ。",
      ]),
      displayMath(String.raw`F=\sum_{x\in X}F(x)\cdot_T\tau(b\circ x)`),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in X`),
        " を任意に取り、写像 ",
        math(String.raw`\mathrm{ev}_y:T\to\mathbb{C}`),
        " を ",
        math(String.raw`\mathrm{ev}_y(G):=G(y)`),
        " で定める。",
        math(String.raw`\mathrm{ev}_y`),
        " は ",
        math(String.raw`T`),
        " から ℂ-線型空間 ",
        math(String.raw`\mathbb{C}^{\mathrm{vec}}`),
        "（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "、",
        ref("claim_complex_numbers_as_vector_space_is_complex_vector_space"),
        "）への線型写像（",
        ref("def_linear_map"),
        "）である。実際、",
        math(String.raw`G,G'\in T`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ev}_y(G+_T G')
&=G(y)+_{\mathbb{C}}G'(y)
&&\left(\because\ +_T=+_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\mathrm{ev}_y(G)+_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ev}_y(G')
&&\left(\because\ \blkref{def_complex_numbers_as_complex_vector_space}\right),\\
\mathrm{ev}_y(\lambda\cdot_T G)
&=\lambda\cdot_{\mathbb{C}}G(y)
&&\left(\because\ \cdot_T=\cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\lambda\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ev}_y(G)
&&\left(\because\ \blkref{def_complex_numbers_as_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "また各 ",
        math(String.raw`x\in X`),
        " について、",
        math(String.raw`\mathbb{C}`),
        " の乗法の交換法則とクロネッカーのデルタの定義（",
        ref("def_kronecker_delta"),
        "。",
        math(String.raw`\delta_{x,y}`),
        " と ",
        math(String.raw`\delta_{y,x}`),
        " はともに ",
        math(String.raw`x=y`),
        " のとき ",
        math(String.raw`1_{\mathbb{C}}`),
        "、そうでないとき ",
        math(String.raw`0_{\mathbb{C}}`),
        "）から ",
        math(String.raw`F(x)\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{x,y}=\delta_{y,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}F(x)`),
        " である（",
        ref("def_complex_numbers_as_complex_vector_space"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{x\in X}F(x)\cdot_T\tau(b\circ x)\right)(y)
&=\mathrm{ev}_y\left(\sum_{x\in X}F(x)\cdot_T\tau(b\circ x)\right)
&&\left(\because\ \mathrm{ev}_y\ \text{の定義}\right)\\
&=\sum_{x\in X}F(x)\cdot_{\mathbb{C}^{\mathrm{vec}}}\mathrm{ev}_y\bigl(\tau(b\circ x)\bigr)
&&\left(\because\ \mathrm{ev}_y\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{x\in X}F(x)\cdot_{\mathbb{C}^{\mathrm{vec}}}\delta_{x,y}
&&\left(\because\ \mathrm{ev}_y\ \text{の定義と}\ \blkref{claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta}\right)\\
&=\sum_{x\in X}\delta_{y,x}\cdot_{\mathbb{C}^{\mathrm{vec}}}F(x)
&&\left(\because\ \text{各項で上の等式。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=F(y)
&&\left(\because\ \blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\ \text{を}\ \mathbb{C}^{\mathrm{vec}}\ \text{と}\ v_x:=F(x)\ \text{で}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`y\in X`),
        " は任意だったので、",
        math(String.raw`T`),
        " の元として主張の等式が成り立つ（",
        ref("def_complex_valued_maps_on_set"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_map_from_coordinate_tensor_space_induced_by_multilinear_map",
    kind: "definition",
    title: { text: "k 重線型写像が構成したテンソル積の上に定める写像" },
    labels: ["def_map_from_coordinate_tensor_space_induced_by_multilinear_map"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のもの、",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）を ",
        ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとし、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）とする。",
        math(String.raw`X`),
        " は有限集合なので（",
        ref("claim_base_n_numbering_is_numbering_of_maps"),
        "）、写像 ",
        math(String.raw`\overline{h}:T\to U`),
        " を ",
        math(String.raw`U`),
        " の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"),
        "）で次のように定める。",
      ]),
      displayMath(String.raw`\overline{h}(F):=\sum_{x\in X}F(x)\cdot_U h(b\circ x)\qquad(F\in T)`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_coordinate_tensor_space_is_linear",
    kind: "claim",
    title: { text: "k 重線型写像が構成したテンソル積の上に定める写像は線型写像である" },
    labels: ["claim_map_from_coordinate_tensor_space_is_linear"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のもの、",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）を ",
        ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとし、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`\overline{h}:T\to U`),
        " を ",
        ref("def_map_from_coordinate_tensor_space_induced_by_multilinear_map"),
        " のものとする。",
        "このとき ",
        math(String.raw`\overline{h}`),
        " は ",
        math(String.raw`T`),
        " から ",
        math(String.raw`U`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F,G\in T`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\overline{h}(F+_T G)
&=\sum_{x\in X}(F+_T G)(x)\cdot_U h(b\circ x)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right)\\
&=\sum_{x\in X}\bigl(F(x)+_{\mathbb{C}}G(x)\bigr)\cdot_U h(b\circ x)
&&\left(\because\ +_T=+_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\left(\sum_{x\in X}F(x)\cdot_U h(b\circ x)\right)+_U\left(\sum_{x\in X}G(x)\cdot_U h(b\circ x)\right)
&&\left(\because\ \blkref{claim_sum_of_sums_over_finite_set_with_same_family}\right)\\
&=\overline{h}(F)+_U\overline{h}(G)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\overline{h}(\lambda\cdot_T F)
&=\sum_{x\in X}(\lambda\cdot_T F)(x)\cdot_U h(b\circ x)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right)\\
&=\sum_{x\in X}\bigl(\lambda\cdot_{\mathbb{C}}F(x)\bigr)\cdot_U h(b\circ x)
&&\left(\because\ \cdot_T=\cdot_{\mathbb{C}^X}\ \text{の定義。}\blkref{def_complex_valued_maps_on_set}\right)\\
&=\lambda\cdot_U\left(\sum_{x\in X}F(x)\cdot_U h(b\circ x)\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\right)\\
&=\lambda\cdot_U\overline{h}(F)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_map_after_k_multilinear_map_is_k_multilinear",
    kind: "claim",
    title: { text: "k 重線型写像の後に線型写像を合成した写像は k 重線型写像である" },
    labels: ["claim_linear_map_after_k_multilinear_map_is_k_multilinear"],
    statement: [
      paragraph([
        math(String.raw`V,\ U,\ U'`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`f:U\to U'`),
        " を線型写像（",
        ref("def_linear_map"),
        "）とする。このとき ",
        math(String.raw`f\circ h:V^{\{1,\dots,k\}}\to U'`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U'`),
        " への ",
        math(String.raw`k`),
        " 重線型写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る（",
        math(String.raw`k=0`),
        " のときは条件が無い）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(f\circ h)\bigl(v[r\mapsto x+_V y]\bigr)
&=f\Bigl(h\bigl(v[r\mapsto x]\bigr)+_U h\bigl(v[r\mapsto y]\bigr)\Bigr)
&&\left(\because\ h\ \text{は}\ k\ \text{重線型。}\blkref{def_k_multilinear_map}\right)\\
&=f\Bigl(h\bigl(v[r\mapsto x]\bigr)\Bigr)+_{U'}f\Bigl(h\bigl(v[r\mapsto y]\bigr)\Bigr)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=(f\circ h)\bigl(v[r\mapsto x]\bigr)+_{U'}(f\circ h)\bigl(v[r\mapsto y]\bigr)
&&\left(\because\ \text{合成の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(f\circ h)\bigl(v[r\mapsto \lambda\cdot_V x]\bigr)
&=f\Bigl(\lambda\cdot_U h\bigl(v[r\mapsto x]\bigr)\Bigr)
&&\left(\because\ h\ \text{は}\ k\ \text{重線型。}\blkref{def_k_multilinear_map}\right)\\
&=\lambda\cdot_{U'}f\Bigl(h\bigl(v[r\mapsto x]\bigr)\Bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_{U'}(f\circ h)\bigl(v[r\mapsto x]\bigr)
&&\left(\because\ \text{合成の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal",
    kind: "claim",
    title: { text: "基底の元の組で値が一致する二つの k 重線型写像は等しい" },
    labels: ["claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のもの、",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）を ",
        ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとし、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`g,g':V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）とする。すべての ",
        math(String.raw`x\in X`),
        " について ",
        math(String.raw`g(b\circ x)=g'(b\circ x)`),
        " ならば、",
        math(String.raw`g=g'`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`j\in\{0,1,\dots,k\}`),
        " について、",
        math(String.raw`V^{\{1,\dots,k\}}`),
        " の部分集合 ",
        math(String.raw`B_j`),
        " を、「すべての ",
        math(String.raw`s\in\{j+1,\dots,k\}`),
        " について、",
        math(String.raw`v(s)=b_i`),
        " となる ",
        math(String.raw`i\in\{1,\dots,n\}`),
        " がある」を満たす ",
        math(String.raw`v`),
        " 全体とする。",
        math(String.raw`j`),
        " についての帰納法で、すべての ",
        math(String.raw`v\in B_j`),
        " について ",
        math(String.raw`g(v)=g'(v)`),
        " であることを示す。",
      ]),
      paragraph([
        math(String.raw`j=0`),
        " のとき、",
        math(String.raw`v\in B_0`),
        " とする。各 ",
        math(String.raw`s\in\{1,\dots,k\}`),
        " について ",
        math(String.raw`v(s)=b_i`),
        " となる ",
        math(String.raw`i\in\{1,\dots,n\}`),
        " を一つ選んで ",
        math(String.raw`x(s):=i`),
        " と置くと、",
        math(String.raw`x\in X`),
        " であり、すべての ",
        math(String.raw`s`),
        " について ",
        math(String.raw`v(s)=b_{x(s)}=(b\circ x)(s)`),
        "、すなわち ",
        math(String.raw`v=b\circ x`),
        " である。仮定から ",
        math(String.raw`g(v)=g(b\circ x)=g'(b\circ x)=g'(v)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`1\le j\le k`),
        " とし、すべての ",
        math(String.raw`w\in B_{j-1}`),
        " について ",
        math(String.raw`g(w)=g'(w)`),
        " であると仮定する（帰納法の仮定）。",
        math(String.raw`v\in B_j`),
        " とする。",
        math(String.raw`b`),
        " は ",
        math(String.raw`V`),
        " を張るので（",
        ref("def_basis"),
        "、",
        ref("def_spanning_family"),
        "）、",
        math(String.raw`\mu_i\in\mathbb{C}`),
        "（",
        math(String.raw`i\in\{1,\dots,n\}`),
        "）で ",
        math(String.raw`\sum_{i=1}^{n}\mu_i\cdot_V b_i=v(j)`),
        " を満たすものを取る。",
        math(String.raw`v[j\mapsto v(j)]=v`),
        " である（",
        ref("def_tuple_with_one_component_replaced"),
        "）。各 ",
        math(String.raw`i`),
        " について ",
        math(String.raw`v[j\mapsto b_i]`),
        " の第 ",
        math(String.raw`s`),
        " 成分（",
        math(String.raw`s\in\{j,\dots,k\}`),
        "）は ",
        math(String.raw`b`),
        " の元なので、",
        math(String.raw`v[j\mapsto b_i]\in B_{j-1}`),
        " である。また ",
        math(String.raw`k`),
        " 重線型写像の定義から、",
        math(String.raw`y\mapsto g\bigl(v[j\mapsto y]\bigr)`),
        " と ",
        math(String.raw`y\mapsto g'\bigl(v[j\mapsto y]\bigr)`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への線型写像である（",
        ref("def_k_multilinear_map"),
        "、",
        ref("def_linear_map"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
g(v)
&=g\left(v\left[j\mapsto \sum_{i=1}^{n}\mu_i\cdot_V b_i\right]\right)
&&\left(\because\ v=v[j\mapsto v(j)]\ \text{と}\ \mu_i\ \text{の取り方}\right)\\
&=\sum_{i=1}^{n}\mu_i\cdot_U g\bigl(v[j\mapsto b_i]\bigr)
&&\left(\because\ y\mapsto g(v[j\mapsto y])\ \text{は線型写像。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{i=1}^{n}\mu_i\cdot_U g'\bigl(v[j\mapsto b_i]\bigr)
&&\left(\because\ v[j\mapsto b_i]\in B_{j-1}\ \text{と帰納法の仮定}\right)\\
&=g'\left(v\left[j\mapsto \sum_{i=1}^{n}\mu_i\cdot_V b_i\right]\right)
&&\left(\because\ y\mapsto g'(v[j\mapsto y])\ \text{は線型写像。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=g'(v)
&&\left(\because\ \mu_i\ \text{の取り方と}\ v=v[j\mapsto v(j)]\right).
\end{aligned}`),
      paragraph([
        math(String.raw`B_k`),
        " の条件は ",
        math(String.raw`\{k+1,\dots,k\}`),
        " が空集合なので空に成り立ち、",
        math(String.raw`B_k=V^{\{1,\dots,k\}}`),
        " である。",
        math(String.raw`j=k`),
        " の場合から、すべての ",
        math(String.raw`v\in V^{\{1,\dots,k\}}`),
        " について ",
        math(String.raw`g(v)=g'(v)`),
        "、すなわち ",
        math(String.raw`g=g'`),
        " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_coordinate_tensor_space_composed_with_tau_is_original",
    kind: "claim",
    title: { text: "k 重線型写像が構成したテンソル積の上に定める写像を座標の積の写像に合成すると、元の k 重線型写像になる" },
    labels: ["claim_map_from_coordinate_tensor_space_composed_with_tau_is_original"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`X`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のもの、",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）を ",
        ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとし、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`\overline{h}:T\to U`),
        " を ",
        ref("def_map_from_coordinate_tensor_space_induced_by_multilinear_map"),
        " のものとする。",
        "このとき ",
        math(String.raw`\overline{h}\circ\tau=h`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tau`),
        " は ",
        math(String.raw`k`),
        " 重線型写像（",
        ref("claim_coordinate_product_map_is_k_multilinear"),
        "）、",
        math(String.raw`\overline{h}`),
        " は線型写像（",
        ref("claim_map_from_coordinate_tensor_space_is_linear"),
        "）なので、",
        math(String.raw`\overline{h}\circ\tau`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像である（",
        ref("claim_linear_map_after_k_multilinear_map_is_k_multilinear"),
        "）。",
        math(String.raw`x\in X`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\overline{h}\circ\tau)(b\circ x)
&=\sum_{y\in X}\tau(b\circ x)(y)\cdot_U h(b\circ y)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right)\\
&=\sum_{y\in X}\delta_{x,y}\cdot_U h(b\circ y)
&&\left(\because\ \blkref{claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta}\right)\\
&=h(b\circ x)
&&\left(\because\ \blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\ \text{を}\ U\ \text{と}\ v_y:=h(b\circ y)\ \text{で}\right).
\end{aligned}`),
      paragraph([
        "二つの ",
        math(String.raw`k`),
        " 重線型写像 ",
        math(String.raw`\overline{h}\circ\tau`),
        " と ",
        math(String.raw`h`),
        " は、すべての基底の元の組 ",
        math(String.raw`b\circ x`),
        "（",
        math(String.raw`x\in X`),
        "）で値が一致するので、",
        math(String.raw`\overline{h}\circ\tau=h`),
        " である（",
        ref("claim_k_multilinear_maps_agreeing_on_basis_tuples_are_equal"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_construction_is_k_fold_tensor_product",
    kind: "claim",
    title: { text: "基底の座標による構成は k 重テンソル積である" },
    labels: ["claim_construction_is_k_fold_tensor_product"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`b`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`T`),
        "、",
        math(String.raw`\tau`),
        " を ",
        ref("def_construction_of_k_fold_tensor_product"),
        " のものとする。このとき組 ",
        math(String.raw`(T,\tau)=(V^{\otimes_b k},\tau_{b,k})`),
        " は ",
        math(String.raw`V`),
        " の ",
        math(String.raw`k`),
        " 重テンソル積（",
        ref("def_k_fold_tensor_product"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`T`),
        " は ℂ-線型空間であり（",
        ref("claim_complex_valued_maps_on_set_form_complex_vector_space"),
        "）、",
        math(String.raw`\tau`),
        " は ",
        math(String.raw`k`),
        " 重線型写像である（",
        ref("claim_coordinate_product_map_is_k_multilinear"),
        "）。",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間、",
        math(String.raw`h:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`k`),
        " 重線型写像とする。",
      ]),
      paragraph([
        "（存在）",
        ref("def_map_from_coordinate_tensor_space_induced_by_multilinear_map"),
        " の ",
        math(String.raw`\overline{h}:T\to U`),
        " は線型写像であり（",
        ref("claim_map_from_coordinate_tensor_space_is_linear"),
        "）、",
        math(String.raw`\overline{h}\circ\tau=h`),
        " を満たす（",
        ref("claim_map_from_coordinate_tensor_space_composed_with_tau_is_original"),
        "）。",
      ]),
      paragraph([
        "（一意性）",
        math(String.raw`g:T\to U`),
        " を、",
        math(String.raw`g\circ\tau=h`),
        " を満たす線型写像とする。",
        math(String.raw`F\in T`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
g(F)
&=g\left(\sum_{x\in X}F(x)\cdot_T\tau(b\circ x)\right)
&&\left(\because\ \blkref{claim_coordinate_tensor_space_element_is_sum_of_basis_tensors}\right)\\
&=\sum_{x\in X}F(x)\cdot_U g\bigl(\tau(b\circ x)\bigr)
&&\left(\because\ g\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{x\in X}F(x)\cdot_U h(b\circ x)
&&\left(\because\ g\circ\tau=h\right)\\
&=\overline{h}(F)
&&\left(\because\ \overline{h}\ \text{の定義。}\blkref{def_map_from_coordinate_tensor_space_induced_by_multilinear_map}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`F`),
        " は任意だったので ",
        math(String.raw`g=\overline{h}`),
        " である。したがって ",
        math(String.raw`\overline{h}\circ\tau=h`),
        " を満たす線型写像 ",
        math(String.raw`T\to U`),
        " はただ一つ存在し、",
        math(String.raw`(T,\tau)`),
        " は ",
        math(String.raw`k`),
        " 重テンソル積の普遍性をもつ（",
        ref("def_k_fold_tensor_product"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_tensor_algebra_heading",
    kind: "heading",
    level: 2,
    title: { text: "テンソル代数" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_direct_sum_of_family_of_vector_spaces",
    kind: "definition",
    title: { text: "番号付けた ℂ-線型空間の族の直和の集合" },
    labels: ["def_direct_sum_of_family_of_vector_spaces"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(E_j,+_{E_j},\cdot_{E_j},0_{E_j})`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とする。各 ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " に ",
        math(String.raw`E_j`),
        " の元 ",
        math(String.raw`x_j`),
        " を一つずつ与える族 ",
        math(String.raw`x=(x_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " のうち、次の条件を満たすもの全体の集合を ",
        math(String.raw`D:=\bigoplus_{j\in\mathbb{Z}_{\ge 0}}E_j`),
        " と書く。",
      ]),
      list([
        [
          math(String.raw`N\in\mathbb{Z}_{\ge 0}`),
          " が存在して、",
          math(String.raw`j>N`),
          " を満たすすべての ",
          math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
          " について ",
          math(String.raw`x_j=0_{E_j}`),
          " である（有限個を除いて零）。",
        ],
      ]),
      paragraph([
        "この条件を満たす ",
        math(String.raw`N`),
        " を ",
        math(String.raw`x`),
        " の零の境と呼ぶ。",
        math(String.raw`x_j\in E_j`),
        " を ",
        math(String.raw`x`),
        " の第 ",
        math(String.raw`j`),
        " 成分と呼び、",
        math(String.raw`D`),
        " の元を表す式 ",
        math(String.raw`w`),
        " の第 ",
        math(String.raw`j`),
        " 成分を ",
        math(String.raw`(w)_j`),
        " とも書く。",
        math(String.raw`D`),
        " の二つの元 ",
        math(String.raw`x`),
        " と ",
        math(String.raw`y`),
        " が等しいとは、すべての ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`E_j`),
        " の等式 ",
        math(String.raw`x_j=y_j`),
        " が成り立つことである。",
      ]),
      paragraph([
        math(String.raw`E_j`),
        " は ",
        math(String.raw`D`),
        " の部分集合ではない。",
        math(String.raw`E_j`),
        " の元から ",
        math(String.raw`D`),
        " の元を作るときは、名前を付けた埋め込み写像（",
        ref("def_embedding_into_component_of_direct_sum_of_family"),
        "）を通す。",
        math(String.raw`D`),
        " の上の加法・スカラー倍・零は ",
        ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        " で定める。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_componentwise_sum_lies_in_direct_sum_of_family",
    kind: "claim",
    title: { text: "直和の二つの元の成分ごとの和は、直和の元である" },
    labels: ["claim_componentwise_sum_lies_in_direct_sum_of_family"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`D`),
        " を ",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        " のものとし、",
        math(String.raw`x,y\in D`),
        " とする。このとき、各 ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " に ",
        math(String.raw`x_j+_{E_j}y_j\in E_j`),
        " を与える族 ",
        math(String.raw`(x_j+_{E_j}y_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " は ",
        math(String.raw`D`),
        " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N_x\in\mathbb{Z}_{\ge 0}`),
        " を ",
        math(String.raw`x`),
        " の零の境、",
        math(String.raw`N_y\in\mathbb{Z}_{\ge 0}`),
        " を ",
        math(String.raw`y`),
        " の零の境とし（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）、",
        math(String.raw`N:=\max(N_x,N_y)\in\mathbb{Z}_{\ge 0}`),
        " と置く。",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " が ",
        math(String.raw`j>N`),
        " を満たすとする。このとき ",
        math(String.raw`j>N_x`),
        " かつ ",
        math(String.raw`j>N_y`),
        " なので、",
        math(String.raw`x_j=0_{E_j}`),
        " かつ ",
        math(String.raw`y_j=0_{E_j}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
x_j+_{E_j}y_j
&=0_{E_j}+_{E_j}y_j
&&\left(\because\ x_j=0_{E_j}\right)\\
&=0_{E_j}+_{E_j}0_{E_j}
&&\left(\because\ y_j=0_{E_j}\right)\\
&=0_{E_j}
&&\left(\because\ E_j\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`N`),
        " は族 ",
        math(String.raw`(x_j+_{E_j}y_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " の零の境の条件を満たし、この族は ",
        math(String.raw`D`),
        " の元である（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family",
    kind: "claim",
    title: { text: "直和の元の成分ごとのスカラー倍は、直和の元である" },
    labels: ["claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`D`),
        " を ",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        " のものとし、",
        math(String.raw`\lambda\in\mathbb{C}`),
        "、",
        math(String.raw`x\in D`),
        " とする。このとき、各 ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " に ",
        math(String.raw`\lambda\cdot_{E_j}x_j\in E_j`),
        " を与える族 ",
        math(String.raw`(\lambda\cdot_{E_j}x_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " は ",
        math(String.raw`D`),
        " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N\in\mathbb{Z}_{\ge 0}`),
        " を ",
        math(String.raw`x`),
        " の零の境とする（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）。",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " が ",
        math(String.raw`j>N`),
        " を満たすとき、",
        math(String.raw`x_j=0_{E_j}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda\cdot_{E_j}x_j
&=\lambda\cdot_{E_j}0_{E_j}
&&\left(\because\ x_j=0_{E_j}\right)\\
&=0_{E_j}
&&\left(\because\ \text{零ベクトルのスカラー倍（}V=E_j\text{）。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`N`),
        " は族 ",
        math(String.raw`(\lambda\cdot_{E_j}x_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " の零の境の条件を満たし、この族は ",
        math(String.raw`D`),
        " の元である（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_operations_on_direct_sum_of_family_of_vector_spaces",
    kind: "definition",
    title: { text: "番号付けた ℂ-線型空間の族の直和の演算" },
    labels: ["def_operations_on_direct_sum_of_family_of_vector_spaces"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " と ",
        math(String.raw`D=\bigoplus_{j\in\mathbb{Z}_{\ge 0}}E_j`),
        " を ",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        " のものとする。写像 ",
        math(String.raw`+_D:D\times D\to D`),
        " と ",
        math(String.raw`\cdot_D:\mathbb{C}\times D\to D`),
        "、元 ",
        math(String.raw`0_D\in D`),
        " を次で定める。以下、",
        math(String.raw`x,y`),
        " は ",
        math(String.raw`D`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の任意の元を表す。",
      ]),
      list([
        [
          math(String.raw`x+_D y:=(x_j+_{E_j}y_j)_{j\in\mathbb{Z}_{\ge 0}}`),
          "（成分ごとの加法。右辺が ",
          math(String.raw`D`),
          " の元であることは ",
          ref("claim_componentwise_sum_lies_in_direct_sum_of_family"),
          "）",
        ],
        [
          math(String.raw`\lambda\cdot_D x:=(\lambda\cdot_{E_j}x_j)_{j\in\mathbb{Z}_{\ge 0}}`),
          "（成分ごとのスカラー倍。右辺が ",
          math(String.raw`D`),
          " の元であることは ",
          ref("claim_componentwise_scalar_multiple_lies_in_direct_sum_of_family"),
          "）",
        ],
        [
          math(String.raw`0_D:=(0_{E_j})_{j\in\mathbb{Z}_{\ge 0}}`),
          "（成分ごとの零。すべての成分が零なので ",
          math(String.raw`0`),
          " が零の境の条件を満たし、右辺は ",
          math(String.raw`D`),
          " の元である）",
        ],
      ]),
      paragraph([
        "すなわち、すべての ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(x+_D y)_j=x_j+_{E_j}y_j`),
        "、",
        math(String.raw`(\lambda\cdot_D x)_j=\lambda\cdot_{E_j}x_j`),
        "、",
        math(String.raw`(0_D)_j=0_{E_j}`),
        " である。組 ",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        " を族 ",
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " の直和と呼ぶ。この組が ℂ-線型空間であることは、この定義では主張しない（",
        ref("claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"),
        " で示す）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space",
    kind: "claim",
    title: { text: "番号付けた ℂ-線型空間の族の直和は ℂ-線型空間である" },
    labels: ["claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " を ",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        " のもの、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        " をその直和（",
        ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        "）とする。このとき組 ",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        " は ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y,z`),
        " を ",
        math(String.raw`D`),
        " の任意の元、",
        math(String.raw`\lambda,\mu`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とする。ℂ-線型空間の定義（",
        ref("def_complex_vector_space"),
        "）の八つの条件を順に示す。どの条件も ",
        math(String.raw`D`),
        " の二つの元の等式であり、",
        math(String.raw`D`),
        " の二つの元が等しいことは、すべての ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " について第 ",
        math(String.raw`j`),
        " 成分どうしの ",
        math(String.raw`E_j`),
        " の等式が成り立つことである（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）。以下、",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " を任意に取り、第 ",
        math(String.raw`j`),
        " 成分の等式を示す。",
      ]),
      paragraph(["加法の結合法則："]),
      displayMath(String.raw`\begin{aligned}
\bigl((x+_D y)+_D z\bigr)_j
&=(x+_D y)_j+_{E_j}z_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=(x_j+_{E_j}y_j)+_{E_j}z_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=x_j+_{E_j}(y_j+_{E_j}z_j)
&&\left(\because\ E_j\ \text{の加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=x_j+_{E_j}(y+_D z)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\bigl(x+_D(y+_D z)\bigr)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph(["加法の交換法則："]),
      displayMath(String.raw`\begin{aligned}
(x+_D y)_j
&=x_j+_{E_j}y_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=y_j+_{E_j}x_j
&&\left(\because\ E_j\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=(y+_D x)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph(["加法の単位元："]),
      displayMath(String.raw`\begin{aligned}
(x+_D 0_D)_j
&=x_j+_{E_j}(0_D)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=x_j+_{E_j}0_{E_j}
&&\left(\because\ 0_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=x_j
&&\left(\because\ E_j\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph([
        "加法の逆元：",
        math(String.raw`x':=(-1_{\mathbb{C}})\cdot_D x\in D`),
        " と置く（",
        ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        "）。",
        math(String.raw`x+_D x'=0_D`),
        " であることを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x+_D x')_j
&=x_j+_{E_j}x'_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=x_j+_{E_j}(-1_{\mathbb{C}})\cdot_{E_j}x_j
&&\left(\because\ x'\ \text{と}\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=1_{\mathbb{C}}\cdot_{E_j}x_j+_{E_j}(-1_{\mathbb{C}})\cdot_{E_j}x_j
&&\left(\because\ E_j\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})\bigr)\cdot_{E_j}x_j
&&\left(\because\ E_j\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=0_{\mathbb{C}}\cdot_{E_j}x_j
&&\left(\because\ 1_{\mathbb{C}}+_{\mathbb{C}}(-1_{\mathbb{C}})=0_{\mathbb{C}}\right)\\
&=0_{E_j}
&&\left(\because\ \text{零のスカラー倍（}V=E_j\text{）。}\blkref{claim_zero_scalar_multiple_is_zero_vector}\right)\\
&=(0_D)_j
&&\left(\because\ 0_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラー倍の結合法則："]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda\cdot_{\mathbb{C}}\mu)\cdot_D x\bigr)_j
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_{E_j}x_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\lambda\cdot_{E_j}(\mu\cdot_{E_j}x_j)
&&\left(\because\ E_j\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\cdot_{E_j}(\mu\cdot_D x)_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_D(\mu\cdot_D x)\bigr)_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラー倍の単位元："]),
      displayMath(String.raw`\begin{aligned}
(1_{\mathbb{C}}\cdot_D x)_j
&=1_{\mathbb{C}}\cdot_{E_j}x_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=x_j
&&\left(\because\ E_j\ \text{のスカラー倍の単位元。}\blkref{def_complex_vector_space}\right).
\end{aligned}`),
      paragraph(["ベクトルの加法についての分配法則："]),
      displayMath(String.raw`\begin{aligned}
\bigl(\lambda\cdot_D(x+_D y)\bigr)_j
&=\lambda\cdot_{E_j}(x+_D y)_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\lambda\cdot_{E_j}(x_j+_{E_j}y_j)
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\lambda\cdot_{E_j}x_j+_{E_j}\lambda\cdot_{E_j}y_j
&&\left(\because\ E_j\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\cdot_D x)_j+_{E_j}(\lambda\cdot_D y)_j
&&\left(\because\ \cdot_D\ \text{の定義を二か所に適用。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=(\lambda\cdot_D x+_D\lambda\cdot_D y)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph(["スカラーの加法についての分配法則："]),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda+_{\mathbb{C}}\mu)\cdot_D x\bigr)_j
&=(\lambda+_{\mathbb{C}}\mu)\cdot_{E_j}x_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\lambda\cdot_{E_j}x_j+_{E_j}\mu\cdot_{E_j}x_j
&&\left(\because\ E_j\ \text{のスカラーの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\cdot_D x)_j+_{E_j}(\mu\cdot_D x)_j
&&\left(\because\ \cdot_D\ \text{の定義を二か所に適用。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=(\lambda\cdot_D x+_D\mu\cdot_D x)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j`),
        " は任意だったので、八つの条件が ",
        math(String.raw`D`),
        " の等式として満たされ（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）、組 ",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        " は ℂ-線型空間である（",
        ref("def_complex_vector_space"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_embedding_into_component_of_direct_sum_of_family",
    kind: "definition",
    title: { text: "番号付けた族の直和の成分への埋め込み写像" },
    labels: ["def_embedding_into_component_of_direct_sum_of_family"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        " を ",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        " のもの、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        " をその直和（",
        ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        "）とし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。写像 ",
        math(String.raw`\mathrm{emb}_k:E_k\to D`),
        " を、",
        math(String.raw`y\in E_k`),
        " について次で定め、直和の第 ",
        math(String.raw`k`),
        " 成分への埋め込み写像と呼ぶ。",
      ]),
      list([
        [math(String.raw`\bigl(\mathrm{emb}_k(y)\bigr)_k:=y`)],
        [
          math(String.raw`\bigl(\mathrm{emb}_k(y)\bigr)_j:=0_{E_j}`),
          "（",
          math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
          "、",
          math(String.raw`j\neq k`),
          "）",
        ],
      ]),
      paragraph([
        "第 ",
        math(String.raw`k`),
        " 成分 ",
        math(String.raw`y`),
        " は ",
        math(String.raw`E_k`),
        " の元、",
        math(String.raw`j\neq k`),
        " の第 ",
        math(String.raw`j`),
        " 成分 ",
        math(String.raw`0_{E_j}`),
        " は ",
        math(String.raw`E_j`),
        " の元である。",
        math(String.raw`j>k`),
        " ならば ",
        math(String.raw`j\neq k`),
        " なので第 ",
        math(String.raw`j`),
        " 成分は ",
        math(String.raw`0_{E_j}`),
        " であり、",
        math(String.raw`k`),
        " が零の境の条件を満たす。したがって右辺の族は ",
        math(String.raw`D`),
        " の元であり（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{emb}_k`),
        " は値域を ",
        math(String.raw`D`),
        " とする写像として定まる。",
        math(String.raw`E_k`),
        " の元 ",
        math(String.raw`y`),
        " と ",
        math(String.raw`D`),
        " の元 ",
        math(String.raw`\mathrm{emb}_k(y)`),
        " は別の集合の元であり、記号を使い回さない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_embedding_into_component_of_direct_sum_of_family_is_linear_map",
    kind: "claim",
    title: { text: "番号付けた族の直和の成分への埋め込み写像は線型写像である" },
    labels: ["claim_embedding_into_component_of_direct_sum_of_family_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`\mathrm{emb}_k:E_k\to D`),
        " を ",
        ref("def_embedding_into_component_of_direct_sum_of_family"),
        " のものとする。",
        math(String.raw`D`),
        " は ℂ-線型空間である（",
        ref("claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"),
        "）。このとき ",
        math(String.raw`\mathrm{emb}_k`),
        " は ",
        math(String.raw`E_k`),
        " から ",
        math(String.raw`D`),
        " への線型写像（",
        ref("def_linear_map"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y,z`),
        " を ",
        math(String.raw`E_k`),
        " の任意の元、",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " の任意の元とし、",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " を任意に取る。",
        math(String.raw`D`),
        " の元の等しさは各成分の等しさなので（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）、第 ",
        math(String.raw`j`),
        " 成分を比べる。",
      ]),
      paragraph([
        "加法を保つこと（",
        math(String.raw`j=k`),
        " のとき）：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{emb}_k(y+_{E_k}z)\bigr)_k
&=y+_{E_k}z
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\bigl(\mathrm{emb}_k(y)\bigr)_k+_{E_k}\bigl(\mathrm{emb}_k(z)\bigr)_k
&&\left(\because\ \mathrm{emb}_k\ \text{の定義を二か所に適用。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\bigl(\mathrm{emb}_k(y)+_D\mathrm{emb}_k(z)\bigr)_k
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        "加法を保つこと（",
        math(String.raw`j\neq k`),
        " のとき）：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{emb}_k(y+_{E_k}z)\bigr)_j
&=0_{E_j}
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=0_{E_j}+_{E_j}0_{E_j}
&&\left(\because\ E_j\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(\mathrm{emb}_k(y)\bigr)_j+_{E_j}\bigl(\mathrm{emb}_k(z)\bigr)_j
&&\left(\because\ \mathrm{emb}_k\ \text{の定義を二か所に適用。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\bigl(\mathrm{emb}_k(y)+_D\mathrm{emb}_k(z)\bigr)_j
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        "スカラー倍を保つこと（",
        math(String.raw`j=k`),
        " のとき）：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{emb}_k(\lambda\cdot_{E_k}y)\bigr)_k
&=\lambda\cdot_{E_k}y
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\lambda\cdot_{E_k}\bigl(\mathrm{emb}_k(y)\bigr)_k
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\bigl(\lambda\cdot_D\mathrm{emb}_k(y)\bigr)_k
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        "スカラー倍を保つこと（",
        math(String.raw`j\neq k`),
        " のとき）：",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{emb}_k(\lambda\cdot_{E_k}y)\bigr)_j
&=0_{E_j}
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\lambda\cdot_{E_j}0_{E_j}
&&\left(\because\ \text{零ベクトルのスカラー倍（}V=E_j\text{）。}\blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=\lambda\cdot_{E_j}\bigl(\mathrm{emb}_k(y)\bigr)_j
&&\left(\because\ \mathrm{emb}_k\ \text{の定義。}\blkref{def_embedding_into_component_of_direct_sum_of_family}\right)\\
&=\bigl(\lambda\cdot_D\mathrm{emb}_k(y)\bigr)_j
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j`),
        " は任意だったので、",
        math(String.raw`\mathrm{emb}_k(y+_{E_k}z)=\mathrm{emb}_k(y)+_D\mathrm{emb}_k(z)`),
        " と ",
        math(String.raw`\mathrm{emb}_k(\lambda\cdot_{E_k}y)=\lambda\cdot_D\mathrm{emb}_k(y)`),
        " が成り立ち（",
        ref("def_direct_sum_of_family_of_vector_spaces"),
        "）、",
        math(String.raw`\mathrm{emb}_k`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_concatenation_of_tuples",
    kind: "definition",
    title: { text: "二つの組をつなげた組" },
    labels: ["def_concatenation_of_tuples"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、",
        math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`),
        " とする。写像 ",
        math(String.raw`\mathrm{cat}_{k,l}:V^{\{1,\dots,k\}}\times V^{\{1,\dots,l\}}\to V^{\{1,\dots,k+l\}}`),
        "（",
        ref("def_tuples_of_vector_space_elements"),
        "）を、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`s\in\{1,\dots,k+l\}`),
        " について次で定め、",
        math(String.raw`\mathrm{cat}_{k,l}(u,u')`),
        " を ",
        math(String.raw`u`),
        " と ",
        math(String.raw`u'`),
        " をつなげた組と呼ぶ。",
      ]),
      list([
        [
          math(String.raw`\mathrm{cat}_{k,l}(u,u')(s):=u(s)`),
          "（",
          math(String.raw`1\le s\le k`),
          " のとき）",
        ],
        [
          math(String.raw`\mathrm{cat}_{k,l}(u,u')(s):=u'(s-k)`),
          "（",
          math(String.raw`k+1\le s\le k+l`),
          " のとき）",
        ],
      ]),
      paragraph([
        math(String.raw`\{1,\dots,k+l\}`),
        " の各元はちょうど一方の場合に入る。二つ目の場合は ",
        math(String.raw`1\le s-k\le l`),
        " なので ",
        math(String.raw`u'(s-k)`),
        " が定まる。どちらの値も ",
        math(String.raw`V`),
        " の元なので、",
        math(String.raw`\mathrm{cat}_{k,l}(u,u')`),
        " は ",
        math(String.raw`V^{\{1,\dots,k+l\}}`),
        " の元として一つに決まる。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_concatenation_commutes_with_replacing_component_of_first_tuple",
    kind: "claim",
    title: { text: "前の組の成分を置き換えてからつなげた組は、つなげた組の同じ番号の成分を置き換えた組である" },
    labels: ["claim_concatenation_commutes_with_replacing_component_of_first_tuple"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_concatenation_of_tuples"),
        " のものとし、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`x\in V`),
        " とする。このとき次が成り立つ（",
        math(String.raw`[r\mapsto x]`),
        " は ",
        ref("def_tuple_with_one_component_replaced"),
        "）。",
      ]),
      displayMath(String.raw`\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)=\mathrm{cat}_{k,l}(u,u')[r\mapsto x]`),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V^{\{1,\dots,k+l\}}`),
        " の元、すなわち写像なので、",
        math(String.raw`s\in\{1,\dots,k+l\}`),
        " を任意に取り、",
        math(String.raw`s`),
        " での値を比べる。",
        math(String.raw`r\le k`),
        " なので、",
        math(String.raw`s=r`),
        "、",
        math(String.raw`s\le k`),
        " かつ ",
        math(String.raw`s\neq r`),
        "、",
        math(String.raw`s\ge k+1`),
        "（このとき ",
        math(String.raw`s\neq r`),
        "）の三つの場合に分ける。",
      ]),
      paragraph([math(String.raw`s=r`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)(r)
&=u[r\mapsto x](r)
&&\left(\because\ 1\le r\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=x
&&\left(\because\ \blkref{def_tuple_with_one_component_replaced}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[r\mapsto x](r)
&&\left(\because\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([math(String.raw`s\le k`), " かつ ", math(String.raw`s\neq r`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)(s)
&=u[r\mapsto x](s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u(s)
&&\left(\because\ s\neq r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right)\\
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[r\mapsto x](s)
&&\left(\because\ s\neq r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([math(String.raw`s\ge k+1`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)(s)
&=u'(s-k)
&&\left(\because\ k+1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ k+1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[r\mapsto x](s)
&&\left(\because\ s\neq r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`s`),
        " は任意だったので、両辺は写像として等しい。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_concatenation_commutes_with_replacing_component_of_second_tuple",
    kind: "claim",
    title: { text: "後ろの組の成分を置き換えてからつなげた組は、つなげた組の番号をずらした成分を置き換えた組である" },
    labels: ["claim_concatenation_commutes_with_replacing_component_of_second_tuple"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_concatenation_of_tuples"),
        " のものとし、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,l\}`),
        "、",
        math(String.raw`x\in V`),
        " とする。このとき ",
        math(String.raw`k+r\in\{1,\dots,k+l\}`),
        " であり、次が成り立つ（",
        math(String.raw`[r\mapsto x]`),
        " は ",
        ref("def_tuple_with_one_component_replaced"),
        "）。",
      ]),
      displayMath(String.raw`\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)=\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]`),
    ],
    proof: [
      paragraph([
        math(String.raw`1\le r\le l`),
        " から ",
        math(String.raw`k+1\le k+r\le k+l`),
        " である。",
        math(String.raw`s\in\{1,\dots,k+l\}`),
        " を任意に取り、",
        math(String.raw`s=k+r`),
        "、",
        math(String.raw`s\le k`),
        "（このとき ",
        math(String.raw`s\neq k+r`),
        "）、",
        math(String.raw`s\ge k+1`),
        " かつ ",
        math(String.raw`s\neq k+r`),
        " の三つの場合に分けて ",
        math(String.raw`s`),
        " での値を比べる。",
      ]),
      paragraph([math(String.raw`s=k+r`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)(k+r)
&=u'[r\mapsto x]\bigl((k+r)-k\bigr)
&&\left(\because\ k+1\le k+r\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u'[r\mapsto x](r)
&&\left(\because\ (k+r)-k=r\right)\\
&=x
&&\left(\because\ \blkref{def_tuple_with_one_component_replaced}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x](k+r)
&&\left(\because\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([math(String.raw`s\le k`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)(s)
&=u(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x](s)
&&\left(\because\ s\neq k+r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([math(String.raw`s\ge k+1`), " かつ ", math(String.raw`s\neq k+r`), " のとき（",
        math(String.raw`s-k\neq r`), "）："]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)(s)
&=u'[r\mapsto x](s-k)
&&\left(\because\ k+1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u'(s-k)
&&\left(\because\ s-k\neq r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right)\\
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ k+1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x](s)
&&\left(\because\ s\neq k+r\ \text{と}\ \blkref{def_tuple_with_one_component_replaced}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`s`),
        " は任意だったので、両辺は写像として等しい。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map",
    kind: "claim",
    title: { text: "k+l 重線型写像に後ろの組を固定して入れた写像は k 重線型写像である" },
    labels: ["claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_concatenation_of_tuples"),
        " のもの、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`g:V^{\{1,\dots,k+l\}}\to U`),
        " を ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k+l`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        " とする。写像 ",
        math(String.raw`g_{\bullet,u'}:V^{\{1,\dots,k\}}\to U`),
        " を ",
        math(String.raw`g_{\bullet,u'}(u):=g\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
        " で定める。このとき ",
        math(String.raw`g_{\bullet,u'}`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`k`),
        " 重線型写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,k\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る（",
        math(String.raw`k=0`),
        " のときは条件が無い）。",
        math(String.raw`r\in\{1,\dots,k+l\}`),
        " でもある。",
      ]),
      displayMath(String.raw`\begin{aligned}
g_{\bullet,u'}\bigl(u[r\mapsto x+_V y]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u[r\mapsto x+_V y],u'\bigr)\Bigr)
&&\left(\because\ g_{\bullet,u'}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[r\mapsto x+_V y]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_first_tuple}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[r\mapsto x]\bigr)+_U g\bigl(\mathrm{cat}_{k,l}(u,u')[r\mapsto y]\bigr)
&&\left(\because\ g\ \text{は第}\ r\ \text{成分について加法を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)\Bigr)+_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u[r\mapsto y],u'\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_first_tuple}\ \text{を二か所に適用}\right)\\
&=g_{\bullet,u'}\bigl(u[r\mapsto x]\bigr)+_U g_{\bullet,u'}\bigl(u[r\mapsto y]\bigr)
&&\left(\because\ g_{\bullet,u'}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g_{\bullet,u'}\bigl(u[r\mapsto \lambda\cdot_V x]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u[r\mapsto \lambda\cdot_V x],u'\bigr)\Bigr)
&&\left(\because\ g_{\bullet,u'}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[r\mapsto \lambda\cdot_V x]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_first_tuple}\right)\\
&=\lambda\cdot_U g\bigl(\mathrm{cat}_{k,l}(u,u')[r\mapsto x]\bigr)
&&\left(\because\ g\ \text{は第}\ r\ \text{成分についてスカラー倍を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\lambda\cdot_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u[r\mapsto x],u'\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_first_tuple}\right)\\
&=\lambda\cdot_U g_{\bullet,u'}\bigl(u[r\mapsto x]\bigr)
&&\left(\because\ g_{\bullet,u'}\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_fixing_first_tuple_of_multilinear_map_gives_multilinear_map",
    kind: "claim",
    title: { text: "k+l 重線型写像に前の組を固定して入れた写像は l 重線型写像である" },
    labels: ["claim_fixing_first_tuple_of_multilinear_map_gives_multilinear_map"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_concatenation_of_tuples"),
        " のもの、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`g:V^{\{1,\dots,k+l\}}\to U`),
        " を ",
        math(String.raw`k+l`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        " とする。写像 ",
        math(String.raw`g_{u,\bullet}:V^{\{1,\dots,l\}}\to U`),
        " を ",
        math(String.raw`g_{u,\bullet}(u'):=g\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
        " で定める。このとき ",
        math(String.raw`g_{u,\bullet}`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`l`),
        " 重線型写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,l\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る（",
        math(String.raw`l=0`),
        " のときは条件が無い）。",
        math(String.raw`k+r\in\{1,\dots,k+l\}`),
        " である（",
        ref("claim_concatenation_commutes_with_replacing_component_of_second_tuple"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
g_{u,\bullet}\bigl(u'[r\mapsto x+_V y]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x+_V y]\bigr)\Bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x+_V y]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)+_U g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto y]\bigr)
&&\left(\because\ g\ \text{は第}\ k+r\ \text{成分について加法を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)\Bigr)+_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto y]\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\ \text{を二か所に適用}\right)\\
&=g_{u,\bullet}\bigl(u'[r\mapsto x]\bigr)+_U g_{u,\bullet}\bigl(u'[r\mapsto y]\bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g_{u,\bullet}\bigl(u'[r\mapsto \lambda\cdot_V x]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto \lambda\cdot_V x]\bigr)\Bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto \lambda\cdot_V x]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=\lambda\cdot_U g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)
&&\left(\because\ g\ \text{は第}\ k+r\ \text{成分についてスカラー倍を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\lambda\cdot_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=\lambda\cdot_U g_{u,\bullet}\bigl(u'[r\mapsto x]\bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_pointwise_sum_of_linear_maps_is_linear_map",
    kind: "claim",
    title: { text: "二つの線型写像の各点ごとの和は線型写像である" },
    labels: ["claim_pointwise_sum_of_linear_maps_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f,g:V\to U`),
        " を線型写像（",
        ref("def_linear_map"),
        "）とする。写像 ",
        math(String.raw`f\boxplus g:V\to U`),
        " を ",
        math(String.raw`(f\boxplus g)(x):=f(x)+_U g(x)`),
        "（",
        math(String.raw`x\in V`),
        "）で定める。このとき ",
        math(String.raw`f\boxplus g`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への線型写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(f\boxplus g)(x+_V y)
&=f(x+_V y)+_U g(x+_V y)
&&\left(\because\ f\boxplus g\ \text{の定義}\right)\\
&=\bigl(f(x)+_U f(y)\bigr)+_U g(x+_V y)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=\bigl(f(x)+_U f(y)\bigr)+_U\bigl(g(x)+_U g(y)\bigr)
&&\left(\because\ g\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=f(x)+_U\Bigl(f(y)+_U\bigl(g(x)+_U g(y)\bigr)\Bigr)
&&\left(\because\ U\ \text{の加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=f(x)+_U\Bigl(\bigl(f(y)+_U g(x)\bigr)+_U g(y)\Bigr)
&&\left(\because\ U\ \text{の加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=f(x)+_U\Bigl(\bigl(g(x)+_U f(y)\bigr)+_U g(y)\Bigr)
&&\left(\because\ U\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=f(x)+_U\Bigl(g(x)+_U\bigl(f(y)+_U g(y)\bigr)\Bigr)
&&\left(\because\ U\ \text{の加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\bigl(f(x)+_U g(x)\bigr)+_U\bigl(f(y)+_U g(y)\bigr)
&&\left(\because\ U\ \text{の加法の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(f\boxplus g)(x)+_U(f\boxplus g)(y)
&&\left(\because\ f\boxplus g\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(f\boxplus g)(\lambda\cdot_V x)
&=f(\lambda\cdot_V x)+_U g(\lambda\cdot_V x)
&&\left(\because\ f\boxplus g\ \text{の定義}\right)\\
&=\lambda\cdot_U f(x)+_U g(\lambda\cdot_V x)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_U f(x)+_U\lambda\cdot_U g(x)
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_U\bigl(f(x)+_U g(x)\bigr)
&&\left(\because\ U\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\cdot_U(f\boxplus g)(x)
&&\left(\because\ f\boxplus g\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`f\boxplus g`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_pointwise_scalar_multiple_of_linear_map_is_linear_map",
    kind: "claim",
    title: { text: "線型写像の各点ごとのスカラー倍は線型写像である" },
    labels: ["claim_pointwise_scalar_multiple_of_linear_map_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " と ",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`f:V\to U`),
        " を線型写像（",
        ref("def_linear_map"),
        "）、",
        math(String.raw`\mu\in\mathbb{C}`),
        " とする。写像 ",
        math(String.raw`\mu\boxdot f:V\to U`),
        " を ",
        math(String.raw`(\mu\boxdot f)(x):=\mu\cdot_U f(x)`),
        "（",
        math(String.raw`x\in V`),
        "）で定める。このとき ",
        math(String.raw`\mu\boxdot f`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への線型写像である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\mu\boxdot f)(x+_V y)
&=\mu\cdot_U f(x+_V y)
&&\left(\because\ \mu\boxdot f\ \text{の定義}\right)\\
&=\mu\cdot_U\bigl(f(x)+_U f(y)\bigr)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=\mu\cdot_U f(x)+_U\mu\cdot_U f(y)
&&\left(\because\ U\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=(\mu\boxdot f)(x)+_U(\mu\boxdot f)(y)
&&\left(\because\ \mu\boxdot f\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
(\mu\boxdot f)(\lambda\cdot_V x)
&=\mu\cdot_U f(\lambda\cdot_V x)
&&\left(\because\ \mu\boxdot f\ \text{の定義}\right)\\
&=\mu\cdot_U\bigl(\lambda\cdot_U f(x)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=(\mu\cdot_{\mathbb{C}}\lambda)\cdot_U f(x)
&&\left(\because\ U\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=(\lambda\cdot_{\mathbb{C}}\mu)\cdot_U f(x)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\cdot_U\bigl(\mu\cdot_U f(x)\bigr)
&&\left(\because\ U\ \text{のスカラー倍の結合法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda\cdot_U(\mu\boxdot f)(x)
&&\left(\because\ \mu\boxdot f\ \text{の定義}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、",
        math(String.raw`\mu\boxdot f`),
        " は線型写像である（",
        ref("def_linear_map"),
        "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_linear_map_appending_fixed_tuple",
    kind: "definition",
    title: { text: "後ろに固定した組をつなげることが k 重テンソル積の上に定める線型写像" },
    labels: ["def_linear_map_appending_fixed_tuple"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）とし、各 ",
        math(String.raw`j\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`(T_j,\tau_j)`),
        " を ",
        math(String.raw`V`),
        " の ",
        math(String.raw`j`),
        " 重テンソル積（",
        ref("def_k_fold_tensor_product"),
        "）とする。",
        math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`\tau_{k+l}:V^{\{1,\dots,k+l\}}\to T_{k+l}`),
        " は ",
        math(String.raw`k+l`),
        " 重線型写像なので、",
        math(String.raw`(\tau_{k+l})_{\bullet,u'}(u):=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
        "（",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "。",
        ref("def_concatenation_of_tuples"),
        "）で定まる写像 ",
        math(String.raw`(\tau_{k+l})_{\bullet,u'}:V^{\{1,\dots,k\}}\to T_{k+l}`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`T_{k+l}`),
        " への ",
        math(String.raw`k`),
        " 重線型写像である（",
        ref("claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map"),
        " を ",
        math(String.raw`U=T_{k+l}`),
        "、",
        math(String.raw`g=\tau_{k+l}`),
        " で）。",
        math(String.raw`(T_k,\tau_k)`),
        " の ",
        math(String.raw`k`),
        " 重テンソル積の普遍性（",
        ref("def_k_fold_tensor_product"),
        "）を ",
        math(String.raw`U=T_{k+l}`),
        "、",
        math(String.raw`h=(\tau_{k+l})_{\bullet,u'}`),
        " に当てると、線型写像 ",
        math(String.raw`T_k\to T_{k+l}`),
        " で、すべての ",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        " について次を満たすものがただ一つ存在する。これを ",
        math(String.raw`\rho_{u'}:T_k\to T_{k+l}`),
        " と書き、後ろに ",
        math(String.raw`u'`),
        " をつなげる線型写像と呼ぶ。",
      ]),
      displayMath(String.raw`\rho_{u'}\bigl(\tau_k(u)\bigr)=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
      paragraph([
        math(String.raw`\rho_{u'}`),
        " は ",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " にもよるが、記号には ",
        math(String.raw`u'`),
        " だけを添える。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_appending_map_value_is_multilinear_in_appended_tuple",
    kind: "claim",
    title: { text: "テンソルを一つ固定すると、後ろにつなげる組についての値は l 重線型写像である" },
    labels: ["claim_appending_map_value_is_multilinear_in_appended_tuple"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        "、",
        math(String.raw`\rho_{u'}`),
        "（",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "）を ",
        ref("def_linear_map_appending_fixed_tuple"),
        " のものとし、",
        math(String.raw`F\in T_k`),
        " とする。写像 ",
        math(String.raw`\rho_{\bullet}(F):V^{\{1,\dots,l\}}\to T_{k+l}`),
        " を ",
        math(String.raw`\rho_{\bullet}(F)(u'):=\rho_{u'}(F)`),
        " で定める。このとき ",
        math(String.raw`\rho_{\bullet}(F)`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`T_{k+l}`),
        " への ",
        math(String.raw`l`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,l\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る（",
        math(String.raw`l=0`),
        " のときは条件が無い）。",
        math(String.raw`V^{\{1,\dots,l\}}`),
        " の元を ",
        math(String.raw`a:=u'[r\mapsto x+_V y]`),
        "、",
        math(String.raw`b:=u'[r\mapsto x]`),
        "、",
        math(String.raw`c:=u'[r\mapsto y]`),
        "、",
        math(String.raw`d:=u'[r\mapsto \lambda\cdot_V x]`),
        " と置く（",
        ref("def_tuple_with_one_component_replaced"),
        "）。",
        math(String.raw`T_{k+l}`),
        " は ℂ-線型空間であり（",
        ref("def_k_fold_tensor_product"),
        "）、",
        math(String.raw`\rho_b`),
        "、",
        math(String.raw`\rho_c`),
        " は線型写像なので、",
        math(String.raw`\rho_b\boxplus\rho_c:T_k\to T_{k+l}`),
        " と ",
        math(String.raw`\lambda\boxdot\rho_b:T_k\to T_{k+l}`),
        " は線型写像である（",
        ref("claim_pointwise_sum_of_linear_maps_is_linear_map"),
        "、",
        ref("claim_pointwise_scalar_multiple_of_linear_map_is_linear_map"),
        "）。",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\rho_b\boxplus\rho_c)\bigl(\tau_k(u)\bigr)
&=\rho_b\bigl(\tau_k(u)\bigr)+_{T_{k+l}}\rho_c\bigl(\tau_k(u)\bigr)
&&\left(\because\ \rho_b\boxplus\rho_c\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_maps_is_linear_map}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,b)\bigr)+_{T_{k+l}}\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,c)\bigr)
&&\left(\because\ \rho_b,\ \rho_c\ \text{の性質を二か所に適用。}\blkref{def_linear_map_appending_fixed_tuple}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)+_{T_{k+l}}\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto y]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\ \text{を二か所に適用}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x+_V y]\bigr)
&&\left(\because\ \tau_{k+l}\ \text{は第}\ k+r\ \text{成分について加法を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,a)\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=(\tau_{k+l})_{\bullet,a}(u)
&&\left(\because\ (\tau_{k+l})_{\bullet,a}\ \text{の定義。}\blkref{def_linear_map_appending_fixed_tuple}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(\lambda\boxdot\rho_b)\bigl(\tau_k(u)\bigr)
&=\lambda\cdot_{T_{k+l}}\rho_b\bigl(\tau_k(u)\bigr)
&&\left(\because\ \lambda\boxdot\rho_b\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_map_is_linear_map}\right)\\
&=\lambda\cdot_{T_{k+l}}\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,b)\bigr)
&&\left(\because\ \rho_b\ \text{の性質。}\blkref{def_linear_map_appending_fixed_tuple}\right)\\
&=\lambda\cdot_{T_{k+l}}\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto \lambda\cdot_V x]\bigr)
&&\left(\because\ \tau_{k+l}\ \text{は第}\ k+r\ \text{成分についてスカラー倍を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,d)\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=(\tau_{k+l})_{\bullet,d}(u)
&&\left(\because\ (\tau_{k+l})_{\bullet,d}\ \text{の定義。}\blkref{def_linear_map_appending_fixed_tuple}\right).
\end{aligned}`),
      paragraph([
        "したがって線型写像 ",
        math(String.raw`\rho_b\boxplus\rho_c`),
        " と ",
        math(String.raw`\rho_a`),
        " はどちらも、",
        math(String.raw`\tau_k`),
        " と合成すると ",
        math(String.raw`(\tau_{k+l})_{\bullet,a}`),
        " になる（",
        math(String.raw`\rho_a`),
        " については ",
        ref("def_linear_map_appending_fixed_tuple"),
        "）。",
        math(String.raw`(T_k,\tau_k)`),
        " の普遍性の一意性（",
        ref("def_k_fold_tensor_product"),
        "）から ",
        math(String.raw`\rho_b\boxplus\rho_c=\rho_a`),
        " である。同じく ",
        math(String.raw`\lambda\boxdot\rho_b`),
        " と ",
        math(String.raw`\rho_d`),
        " はどちらも ",
        math(String.raw`\tau_k`),
        " と合成すると ",
        math(String.raw`(\tau_{k+l})_{\bullet,d}`),
        " になるので、",
        math(String.raw`\lambda\boxdot\rho_b=\rho_d`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\rho_{\bullet}(F)\bigl(u'[r\mapsto x+_V y]\bigr)
&=\rho_a(F)
&&\left(\because\ \rho_{\bullet}(F)\ \text{と}\ a\ \text{の定義}\right)\\
&=(\rho_b\boxplus\rho_c)(F)
&&\left(\because\ \rho_a=\rho_b\boxplus\rho_c\right)\\
&=\rho_b(F)+_{T_{k+l}}\rho_c(F)
&&\left(\because\ \rho_b\boxplus\rho_c\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_maps_is_linear_map}\right)\\
&=\rho_{\bullet}(F)\bigl(u'[r\mapsto x]\bigr)+_{T_{k+l}}\rho_{\bullet}(F)\bigl(u'[r\mapsto y]\bigr)
&&\left(\because\ \rho_{\bullet}(F)\ \text{と}\ b,\ c\ \text{の定義}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\rho_{\bullet}(F)\bigl(u'[r\mapsto \lambda\cdot_V x]\bigr)
&=\rho_d(F)
&&\left(\because\ \rho_{\bullet}(F)\ \text{と}\ d\ \text{の定義}\right)\\
&=(\lambda\boxdot\rho_b)(F)
&&\left(\because\ \rho_d=\lambda\boxdot\rho_b\right)\\
&=\lambda\cdot_{T_{k+l}}\rho_b(F)
&&\left(\because\ \lambda\boxdot\rho_b\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_map_is_linear_map}\right)\\
&=\lambda\cdot_{T_{k+l}}\rho_{\bullet}(F)\bigl(u'[r\mapsto x]\bigr)
&&\left(\because\ \rho_{\bullet}(F)\ \text{と}\ b\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_definition_product_of_tensors",
    kind: "definition",
    title: { text: "k 重テンソル積の元と l 重テンソル積の元の積" },
    labels: ["def_product_of_tensors"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_linear_map_appending_fixed_tuple"),
        " のものとし、",
        math(String.raw`F\in T_k`),
        " とする。",
        math(String.raw`\rho_{\bullet}(F):V^{\{1,\dots,l\}}\to T_{k+l}`),
        " は ",
        math(String.raw`l`),
        " 重線型写像である（",
        ref("claim_appending_map_value_is_multilinear_in_appended_tuple"),
        "）。",
        math(String.raw`(T_l,\tau_l)`),
        " の ",
        math(String.raw`l`),
        " 重テンソル積の普遍性（",
        ref("def_k_fold_tensor_product"),
        "）を ",
        math(String.raw`U=T_{k+l}`),
        "、",
        math(String.raw`h=\rho_{\bullet}(F)`),
        " に当てると、線型写像 ",
        math(String.raw`T_l\to T_{k+l}`),
        " で、すべての ",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        " について次を満たすものがただ一つ存在する。これを ",
        math(String.raw`\theta_F:T_l\to T_{k+l}`),
        " と書く。",
      ]),
      displayMath(String.raw`\theta_F\bigl(\tau_l(u')\bigr)=\rho_{u'}(F)`),
      paragraph([
        "写像 ",
        math(String.raw`m_{k,l}:T_k\times T_l\to T_{k+l}`),
        " を次で定め、",
        math(String.raw`m_{k,l}(F,G)`),
        " を ",
        math(String.raw`F`),
        " と ",
        math(String.raw`G`),
        " のテンソルの積と呼ぶ。",
      ]),
      displayMath(String.raw`m_{k,l}(F,G):=\theta_F(G)\qquad(F\in T_k,\ G\in T_l)`),
      paragraph([
        "この定義は ",
        math(String.raw`V`),
        " の基底も、",
        math(String.raw`T_j`),
        " の作り方も使わず、",
        math(String.raw`k`),
        " 重・",
        math(String.raw`l`),
        " 重テンソル積の普遍性と、",
        math(String.raw`\tau_{k+l}`),
        " が ",
        math(String.raw`k+l`),
        " 重線型写像であることだけを使う。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_of_pure_tensors_is_pure_tensor_of_concatenation",
    kind: "claim",
    title: { text: "組の像どうしのテンソルの積は、つなげた組の像である" },
    labels: ["claim_product_of_pure_tensors_is_pure_tensor_of_concatenation"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        "、",
        math(String.raw`m_{k,l}`),
        " を ",
        ref("def_product_of_tensors"),
        " のものとし、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`m_{k,l}\bigl(\tau_k(u),\tau_l(u')\bigr)=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
m_{k,l}\bigl(\tau_k(u),\tau_l(u')\bigr)
&=\theta_{\tau_k(u)}\bigl(\tau_l(u')\bigr)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right)\\
&=\rho_{u'}\bigl(\tau_k(u)\bigr)
&&\left(\because\ \theta_{\tau_k(u)}\ \text{の性質。}\blkref{def_product_of_tensors}\right)\\
&=\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)
&&\left(\because\ \rho_{u'}\ \text{の性質。}\blkref{def_linear_map_appending_fixed_tuple}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_of_tensors_is_linear_in_second_factor",
    kind: "claim",
    title: { text: "テンソルの積は後ろの因子について線型である" },
    labels: ["claim_product_of_tensors_is_linear_in_second_factor"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        "、",
        math(String.raw`m_{k,l}`),
        " を ",
        ref("def_product_of_tensors"),
        " のものとし、",
        math(String.raw`F\in T_k`),
        " とする。このとき、",
        math(String.raw`G,G'\in T_l`),
        " と ",
        math(String.raw`\lambda\in\mathbb{C}`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`m_{k,l}(F,G+_{T_l}G')=m_{k,l}(F,G)+_{T_{k+l}}m_{k,l}(F,G')`)],
        [math(String.raw`m_{k,l}(F,\lambda\cdot_{T_l}G)=\lambda\cdot_{T_{k+l}}m_{k,l}(F,G)`)],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta_F:T_l\to T_{k+l}`),
        " は線型写像である（",
        ref("def_product_of_tensors"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{k,l}(F,G+_{T_l}G')
&=\theta_F(G+_{T_l}G')
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right)\\
&=\theta_F(G)+_{T_{k+l}}\theta_F(G')
&&\left(\because\ \theta_F\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=m_{k,l}(F,G)+_{T_{k+l}}m_{k,l}(F,G')
&&\left(\because\ m_{k,l}\ \text{の定義を二か所に適用。}\blkref{def_product_of_tensors}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
m_{k,l}(F,\lambda\cdot_{T_l}G)
&=\theta_F(\lambda\cdot_{T_l}G)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right)\\
&=\lambda\cdot_{T_{k+l}}\theta_F(G)
&&\left(\because\ \theta_F\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_{T_{k+l}}m_{k,l}(F,G)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_of_tensors_is_linear_in_first_factor",
    kind: "claim",
    title: { text: "テンソルの積は前の因子について線型である" },
    labels: ["claim_product_of_tensors_is_linear_in_first_factor"],
    statement: [
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        "、",
        math(String.raw`m_{k,l}`),
        " を ",
        ref("def_product_of_tensors"),
        " のものとし、",
        math(String.raw`G\in T_l`),
        " とする。このとき、",
        math(String.raw`F,F'\in T_k`),
        " と ",
        math(String.raw`\lambda\in\mathbb{C}`),
        " について次の二つが成り立つ。",
      ]),
      list([
        [math(String.raw`m_{k,l}(F+_{T_k}F',G)=m_{k,l}(F,G)+_{T_{k+l}}m_{k,l}(F',G)`)],
        [math(String.raw`m_{k,l}(\lambda\cdot_{T_k}F,G)=\lambda\cdot_{T_{k+l}}m_{k,l}(F,G)`)],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\theta_F`),
        "、",
        math(String.raw`\theta_{F'}`),
        " は線型写像 ",
        math(String.raw`T_l\to T_{k+l}`),
        " なので（",
        ref("def_product_of_tensors"),
        "）、",
        math(String.raw`\theta_F\boxplus\theta_{F'}`),
        " と ",
        math(String.raw`\lambda\boxdot\theta_F`),
        " は線型写像である（",
        ref("claim_pointwise_sum_of_linear_maps_is_linear_map"),
        "、",
        ref("claim_pointwise_scalar_multiple_of_linear_map_is_linear_map"),
        "）。",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        " を任意に取る。各 ",
        math(String.raw`\rho_{u'}`),
        " は線型写像である（",
        ref("def_linear_map_appending_fixed_tuple"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\theta_F\boxplus\theta_{F'})\bigl(\tau_l(u')\bigr)
&=\theta_F\bigl(\tau_l(u')\bigr)+_{T_{k+l}}\theta_{F'}\bigl(\tau_l(u')\bigr)
&&\left(\because\ \theta_F\boxplus\theta_{F'}\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_maps_is_linear_map}\right)\\
&=\rho_{u'}(F)+_{T_{k+l}}\rho_{u'}(F')
&&\left(\because\ \theta_F,\ \theta_{F'}\ \text{の性質を二か所に適用。}\blkref{def_product_of_tensors}\right)\\
&=\rho_{u'}(F+_{T_k}F')
&&\left(\because\ \rho_{u'}\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=\rho_{\bullet}(F+_{T_k}F')(u')
&&\left(\because\ \rho_{\bullet}(F+_{T_k}F')\ \text{の定義。}\blkref{claim_appending_map_value_is_multilinear_in_appended_tuple}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(\lambda\boxdot\theta_F)\bigl(\tau_l(u')\bigr)
&=\lambda\cdot_{T_{k+l}}\theta_F\bigl(\tau_l(u')\bigr)
&&\left(\because\ \lambda\boxdot\theta_F\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_map_is_linear_map}\right)\\
&=\lambda\cdot_{T_{k+l}}\rho_{u'}(F)
&&\left(\because\ \theta_F\ \text{の性質。}\blkref{def_product_of_tensors}\right)\\
&=\rho_{u'}(\lambda\cdot_{T_k}F)
&&\left(\because\ \rho_{u'}\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\rho_{\bullet}(\lambda\cdot_{T_k}F)(u')
&&\left(\because\ \rho_{\bullet}(\lambda\cdot_{T_k}F)\ \text{の定義。}\blkref{claim_appending_map_value_is_multilinear_in_appended_tuple}\right).
\end{aligned}`),
      paragraph([
        "したがって線型写像 ",
        math(String.raw`\theta_F\boxplus\theta_{F'}`),
        " と ",
        math(String.raw`\theta_{F+_{T_k}F'}`),
        " はどちらも、",
        math(String.raw`\tau_l`),
        " と合成すると ",
        math(String.raw`\rho_{\bullet}(F+_{T_k}F')`),
        " になる（",
        math(String.raw`\theta_{F+_{T_k}F'}`),
        " については ",
        ref("def_product_of_tensors"),
        "）。",
        math(String.raw`(T_l,\tau_l)`),
        " の普遍性の一意性（",
        ref("def_k_fold_tensor_product"),
        "）から ",
        math(String.raw`\theta_F\boxplus\theta_{F'}=\theta_{F+_{T_k}F'}`),
        " である。同じく ",
        math(String.raw`\lambda\boxdot\theta_F`),
        " と ",
        math(String.raw`\theta_{\lambda\cdot_{T_k}F}`),
        " はどちらも ",
        math(String.raw`\tau_l`),
        " と合成すると ",
        math(String.raw`\rho_{\bullet}(\lambda\cdot_{T_k}F)`),
        " になるので、",
        math(String.raw`\lambda\boxdot\theta_F=\theta_{\lambda\cdot_{T_k}F}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{k,l}(F+_{T_k}F',G)
&=\theta_{F+_{T_k}F'}(G)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right)\\
&=(\theta_F\boxplus\theta_{F'})(G)
&&\left(\because\ \theta_{F+_{T_k}F'}=\theta_F\boxplus\theta_{F'}\right)\\
&=\theta_F(G)+_{T_{k+l}}\theta_{F'}(G)
&&\left(\because\ \theta_F\boxplus\theta_{F'}\ \text{の定義。}\blkref{claim_pointwise_sum_of_linear_maps_is_linear_map}\right)\\
&=m_{k,l}(F,G)+_{T_{k+l}}m_{k,l}(F',G)
&&\left(\because\ m_{k,l}\ \text{の定義を二か所に適用。}\blkref{def_product_of_tensors}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
m_{k,l}(\lambda\cdot_{T_k}F,G)
&=\theta_{\lambda\cdot_{T_k}F}(G)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right)\\
&=(\lambda\boxdot\theta_F)(G)
&&\left(\because\ \theta_{\lambda\cdot_{T_k}F}=\lambda\boxdot\theta_F\right)\\
&=\lambda\cdot_{T_{k+l}}\theta_F(G)
&&\left(\because\ \lambda\boxdot\theta_F\ \text{の定義。}\blkref{claim_pointwise_scalar_multiple_of_linear_map_is_linear_map}\right)\\
&=\lambda\cdot_{T_{k+l}}m_{k,l}(F,G)
&&\left(\because\ m_{k,l}\ \text{の定義。}\blkref{def_product_of_tensors}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_map_sends_zero_to_zero",
    kind: "claim",
    title: { text: "線型写像は零ベクトルを零ベクトルへ移す" },
    labels: ["claim_linear_map_sends_zero_to_zero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`f:V\to U`), " を線型写像（", ref("def_linear_map"), "）とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`f(0_V)=0_U`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
f(0_V)
&=f(0_{\mathbb{C}}\cdot_V 0_V)
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\ \text{を}\ V\ \text{と}\ x=0_V\ \text{で}\right)\\
&=0_{\mathbb{C}}\cdot_U f(0_V)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=0_U
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\ \text{を}\ U\ \text{と}\ x=f(0_V)\ \text{で}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_composition_of_linear_maps_is_linear_map",
    kind: "claim",
    title: { text: "二つの線型写像の合成は線型写像である" },
    labels: ["claim_composition_of_linear_maps_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), "、", math(String.raw`(U,+_U,\cdot_U,0_U)`), "、",
        math(String.raw`(W,+_W,\cdot_W,0_W)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`f:V\to U`), " と ", math(String.raw`g:U\to W`), " を線型写像（", ref("def_linear_map"),
        "）とする。このとき合成 ", math(String.raw`g\circ f:V\to W`), "（", math(String.raw`(g\circ f)(x):=g\bigl(f(x)\bigr)`),
        "）は ", math(String.raw`V`), " から ", math(String.raw`W`), " への線型写像である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`x,y\in V`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。"]),
      displayMath(String.raw`\begin{aligned}
(g\circ f)(x+_V y)
&=g\bigl(f(x+_V y)\bigr)
&&\left(\because\ g\circ f\ \text{の定義}\right)\\
&=g\bigl(f(x)+_U f(y)\bigr)
&&\left(\because\ f\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=g\bigl(f(x)\bigr)+_W g\bigl(f(y)\bigr)
&&\left(\because\ g\ \text{は加法を保つ。}\blkref{def_linear_map}\right)\\
&=(g\circ f)(x)+_W(g\circ f)(y)
&&\left(\because\ g\circ f\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
(g\circ f)(\lambda\cdot_V x)
&=g\bigl(f(\lambda\cdot_V x)\bigr)
&&\left(\because\ g\circ f\ \text{の定義}\right)\\
&=g\bigl(\lambda\cdot_U f(x)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_W g\bigl(f(x)\bigr)
&&\left(\because\ g\ \text{はスカラー倍を保つ。}\blkref{def_linear_map}\right)\\
&=\lambda\cdot_W(g\circ f)(x)
&&\left(\because\ g\circ f\ \text{の定義}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`g\circ f`), " は線型写像である（", ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_linear_maps_agreeing_on_pure_tensors_are_equal",
    kind: "claim",
    title: { text: "組の像で値が一致する k 重テンソル積からの二つの線型写像は等しい" },
    labels: ["claim_linear_maps_agreeing_on_pure_tensors_are_equal"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(U,+_U,\cdot_U,0_U)`), " を ℂ-線型空間（",
        ref("def_complex_vector_space"), "）、", math(String.raw`k\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`(T,\tau)`), " を ", math(String.raw`V`), " の ", math(String.raw`k`), " 重テンソル積（",
        ref("def_k_fold_tensor_product"), "）、", math(String.raw`f,g:T\to U`), " を線型写像（", ref("def_linear_map"),
        "）とする。すべての ", math(String.raw`v\in V^{\{1,\dots,k\}}`), " について ",
        math(String.raw`f\bigl(\tau(v)\bigr)=g\bigl(\tau(v)\bigr)`), " が成り立つとき、写像として ",
        math(String.raw`f=g`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`h:=f\circ\tau:V^{\{1,\dots,k\}}\to U`), " と置く。", math(String.raw`\tau`), " は ",
        math(String.raw`k`), " 重線型写像なので（", ref("def_k_fold_tensor_product"), "）、", math(String.raw`h`),
        " は ", math(String.raw`k`), " 重線型写像である（", ref("claim_linear_map_after_k_multilinear_map_is_k_multilinear"),
        "）。", math(String.raw`h`), " の定義から ", math(String.raw`f\circ\tau=h`), " であり、仮定から、すべての ",
        math(String.raw`v\in V^{\{1,\dots,k\}}`), " について ",
        math(String.raw`g\bigl(\tau(v)\bigr)=f\bigl(\tau(v)\bigr)=h(v)`), "、すなわち ", math(String.raw`g\circ\tau=h`),
        " である。", math(String.raw`k`), " 重テンソル積の普遍性（", ref("def_k_fold_tensor_product"),
        "）により、", math(String.raw`\overline{h}\circ\tau=h`), " を満たす線型写像 ", math(String.raw`\overline{h}:T\to U`),
        " はただ一つなので、", math(String.raw`f=g`), " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_concatenation_of_tuples_is_associative",
    kind: "claim",
    title: { text: "組をつなげることは結合的である" },
    labels: ["claim_concatenation_of_tuples_is_associative"],
    statement: [
      paragraph([
        math(String.raw`V`), " を ", ref("def_concatenation_of_tuples"), " のものとし、",
        math(String.raw`k,l,p\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`u\in V^{\{1,\dots,k\}}`), "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`), "、", math(String.raw`u''\in V^{\{1,\dots,p\}}`),
        " とする。", math(String.raw`(k+l)+p=k+(l+p)`), " なので両辺は同じ集合 ",
        math(String.raw`V^{\{1,\dots,k+l+p\}}`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\mathrm{cat}_{k+l,p}\bigl(\mathrm{cat}_{k,l}(u,u'),u''\bigr)=\mathrm{cat}_{k,l+p}\bigl(u,\mathrm{cat}_{l,p}(u',u'')\bigr)`),
    ],
    proof: [
      paragraph([
        "左辺を ", math(String.raw`w`), "、右辺を ", math(String.raw`w'`), " と置く。",
        math(String.raw`s\in\{1,\dots,k+l+p\}`), " を任意に取り、", math(String.raw`s\le k`), "、",
        math(String.raw`k+1\le s\le k+l`), "、", math(String.raw`k+l+1\le s`),
        " の三つの場合に分けて ", math(String.raw`s`), " での値を比べる。",
      ]),
      paragraph([math(String.raw`s\le k`), " のとき（このとき ", math(String.raw`s\le k+l`), "）："]),
      displayMath(String.raw`\begin{aligned}
w(s)
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ 1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=w'(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right).
\end{aligned}`),
      paragraph([math(String.raw`k+1\le s\le k+l`), " のとき（このとき ", math(String.raw`1\le s-k\le l`), "）："]),
      displayMath(String.raw`\begin{aligned}
w(s)
&=\mathrm{cat}_{k,l}(u,u')(s)
&&\left(\because\ 1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u'(s-k)
&&\left(\because\ k+1\le s\le k+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=\mathrm{cat}_{l,p}(u',u'')(s-k)
&&\left(\because\ 1\le s-k\le l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=w'(s)
&&\left(\because\ k+1\le s\le k+(l+p)\ \text{と}\ \blkref{def_concatenation_of_tuples}\right).
\end{aligned}`),
      paragraph([math(String.raw`k+l+1\le s`), " のとき（このとき ", math(String.raw`l+1\le s-k\le l+p`), "）："]),
      displayMath(String.raw`\begin{aligned}
w(s)
&=u''\bigl(s-(k+l)\bigr)
&&\left(\because\ (k+l)+1\le s\le (k+l)+p\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u''\bigl((s-k)-l\bigr)
&&\left(\because\ s-(k+l)=(s-k)-l\right)\\
&=\mathrm{cat}_{l,p}(u',u'')(s-k)
&&\left(\because\ l+1\le s-k\le l+p\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=w'(s)
&&\left(\because\ k+1\le s\le k+(l+p)\ \text{と}\ \blkref{def_concatenation_of_tuples}\right).
\end{aligned}`),
      paragraph([math(String.raw`s`), " は任意だったので、", math(String.raw`w=w'`), " である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_of_tensors_is_associative",
    kind: "claim",
    title: { text: "テンソルの積は結合的である" },
    labels: ["claim_product_of_tensors_is_associative"],
    statement: [
      paragraph([
        math(String.raw`V`), " と ", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), " を ",
        ref("def_product_of_tensors"), " のものとし、各 ", math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`),
        " について ", math(String.raw`m_{k,l}:T_k\times T_l\to T_{k+l}`), " を同じ定義のテンソルの積とする。",
        math(String.raw`k,l,p\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`F\in T_k`), "、", math(String.raw`G\in T_l`), "、",
        math(String.raw`H\in T_p`), " とする。", math(String.raw`(k+l)+p=k+(l+p)`), " なので両辺は同じ ",
        math(String.raw`T_{k+l+p}`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`m_{k+l,p}\bigl(m_{k,l}(F,G),H\bigr)=m_{k,l+p}\bigl(F,m_{l,p}(G,H)\bigr)`),
    ],
    proof: [
      paragraph([
        "準備として、", math(String.raw`a,c\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`X\in T_a`), "、",
        math(String.raw`Y\in T_c`), " について、写像 ", math(String.raw`m_{a,c}(X,\bullet):T_c\to T_{a+c}`), " を ",
        math(String.raw`Z\mapsto m_{a,c}(X,Z)`), "、写像 ", math(String.raw`m_{a,c}(\bullet,Y):T_a\to T_{a+c}`), " を ",
        math(String.raw`Z\mapsto m_{a,c}(Z,Y)`), " で定める。この二つは線型写像である（",
        ref("claim_product_of_tensors_is_linear_in_second_factor"), "、",
        ref("claim_product_of_tensors_is_linear_in_first_factor"), "、", ref("def_linear_map"), "）。",
      ]),
      paragraph([
        "（組の像が三つのとき）", math(String.raw`u\in V^{\{1,\dots,k\}}`), "、", math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、", math(String.raw`u''\in V^{\{1,\dots,p\}}`), " とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{k+l,p}\bigl(m_{k,l}(\tau_k(u),\tau_l(u')),\tau_p(u'')\bigr)
&=m_{k+l,p}\Bigl(\tau_{k+l}\bigl(\mathrm{cat}_{k,l}(u,u')\bigr),\tau_p(u'')\Bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\tau_{k+l+p}\Bigl(\mathrm{cat}_{k+l,p}\bigl(\mathrm{cat}_{k,l}(u,u'),u''\bigr)\Bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\tau_{k+l+p}\Bigl(\mathrm{cat}_{k,l+p}\bigl(u,\mathrm{cat}_{l,p}(u',u'')\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_of_tuples_is_associative}\right)\\
&=m_{k,l+p}\Bigl(\tau_k(u),\tau_{l+p}\bigl(\mathrm{cat}_{l,p}(u',u'')\bigr)\Bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=m_{k,l+p}\bigl(\tau_k(u),m_{l,p}(\tau_l(u'),\tau_p(u''))\bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right).
\end{aligned}`),
      paragraph([
        "（前の二つが組の像のとき）", math(String.raw`u,u'`), " を上のものとする。線型写像 ",
        math(String.raw`m_{k+l,p}\bigl(m_{k,l}(\tau_k(u),\tau_l(u')),\bullet\bigr):T_p\to T_{k+l+p}`), " と、線型写像の合成 ",
        math(String.raw`m_{k,l+p}(\tau_k(u),\bullet)\circ m_{l,p}(\tau_l(u'),\bullet):T_p\to T_{k+l+p}`), "（",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）は、前の段により ", math(String.raw`\tau_p(u'')`),
        " で値が一致する。", ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ",
        math(String.raw`(T_p,\tau_p)`), " に当てると二つは等しく、すべての ", math(String.raw`H\in T_p`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`m_{k+l,p}\bigl(m_{k,l}(\tau_k(u),\tau_l(u')),H\bigr)=m_{k,l+p}\bigl(\tau_k(u),m_{l,p}(\tau_l(u'),H)\bigr)`),
      paragraph([
        "（前の一つが組の像のとき）", math(String.raw`u`), " を上のもの、", math(String.raw`H\in T_p`), " とする。二つの合成 ",
        math(String.raw`m_{k+l,p}(\bullet,H)\circ m_{k,l}(\tau_k(u),\bullet):T_l\to T_{k+l+p}`), " と ",
        math(String.raw`m_{k,l+p}(\tau_k(u),\bullet)\circ m_{l,p}(\bullet,H):T_l\to T_{k+l+p}`), " は線型写像であり（",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）、前の段により、すべての ",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`), " について ", math(String.raw`\tau_l(u')`), " で値が一致する。",
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_l,\tau_l)`),
        " に当てると二つは等しく、すべての ", math(String.raw`G\in T_l`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`m_{k+l,p}\bigl(m_{k,l}(\tau_k(u),G),H\bigr)=m_{k,l+p}\bigl(\tau_k(u),m_{l,p}(G,H)\bigr)`),
      paragraph([
        "（一般のとき）", math(String.raw`G\in T_l`), "、", math(String.raw`H\in T_p`), " とする。合成 ",
        math(String.raw`m_{k+l,p}(\bullet,H)\circ m_{k,l}(\bullet,G):T_k\to T_{k+l+p}`), " と線型写像 ",
        math(String.raw`m_{k,l+p}\bigl(\bullet,m_{l,p}(G,H)\bigr):T_k\to T_{k+l+p}`), " は線型写像であり（",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）、前の段により、すべての ",
        math(String.raw`u\in V^{\{1,\dots,k\}}`), " について ", math(String.raw`\tau_k(u)`), " で値が一致する。",
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_k,\tau_k)`),
        " に当てると二つは等しく、", math(String.raw`F\in T_k`), " での値が主張の等式である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_empty_tuple_of_vector_space_elements",
    kind: "definition",
    title: { text: "空の組" },
    labels: ["def_empty_tuple_of_vector_space_elements"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）とする。",
        math(String.raw`V^{\{1,\dots,0\}}`), "（", ref("def_tuples_of_vector_space_elements"),
        "）の元は空集合から ", math(String.raw`V`), " への写像ただ一つである。この元を ",
        math(String.raw`\varepsilon_V\in V^{\{1,\dots,0\}}`), " と書き、空の組と呼ぶ。すべての ",
        math(String.raw`v\in V^{\{1,\dots,0\}}`), " について ", math(String.raw`v=\varepsilon_V`), " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_concatenation_with_empty_tuple_on_left",
    kind: "claim",
    title: { text: "空の組を前につなげても組は変わらない" },
    labels: ["claim_concatenation_with_empty_tuple_on_left"],
    statement: [
      paragraph([
        math(String.raw`V`), " を ", ref("def_concatenation_of_tuples"), " のもの、", math(String.raw`l\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`), " とし、", math(String.raw`\varepsilon_V`), " を空の組（",
        ref("def_empty_tuple_of_vector_space_elements"), "）とする。", math(String.raw`0+l=l`), " なので両辺は ",
        math(String.raw`V^{\{1,\dots,l\}}`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\mathrm{cat}_{0,l}(\varepsilon_V,u')=u'`),
    ],
    proof: [
      paragraph([math(String.raw`s\in\{1,\dots,l\}`), " を任意に取る。", math(String.raw`0+1\le s\le 0+l`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{0,l}(\varepsilon_V,u')(s)
&=u'(s-0)
&&\left(\because\ 0+1\le s\le 0+l\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u'(s)
&&\left(\because\ s-0=s\right).
\end{aligned}`),
      paragraph([math(String.raw`s`), " は任意だったので、両辺は写像として等しい。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_concatenation_with_empty_tuple_on_right",
    kind: "claim",
    title: { text: "空の組を後ろにつなげても組は変わらない" },
    labels: ["claim_concatenation_with_empty_tuple_on_right"],
    statement: [
      paragraph([
        math(String.raw`V`), " を ", ref("def_concatenation_of_tuples"), " のもの、", math(String.raw`k\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`), " とし、", math(String.raw`\varepsilon_V`), " を空の組（",
        ref("def_empty_tuple_of_vector_space_elements"), "）とする。", math(String.raw`k+0=k`), " なので両辺は ",
        math(String.raw`V^{\{1,\dots,k\}}`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`\mathrm{cat}_{k,0}(u,\varepsilon_V)=u`),
    ],
    proof: [
      paragraph([math(String.raw`s\in\{1,\dots,k\}`), " を任意に取る。", math(String.raw`1\le s\le k`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k,0}(u,\varepsilon_V)(s)
&=u(s)
&&\left(\because\ 1\le s\le k\ \text{と}\ \blkref{def_concatenation_of_tuples}\right).
\end{aligned}`),
      paragraph([math(String.raw`s`), " は任意だったので、両辺は写像として等しい。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_with_image_of_empty_tuple_on_left",
    kind: "claim",
    title: { text: "空の組の像を前から掛けてもテンソルは変わらない" },
    labels: ["claim_product_with_image_of_empty_tuple_on_left"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), " と、テンソルの積 ",
        math(String.raw`m_{k,l}`), "（", math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`), "）を ", ref("def_product_of_tensors"),
        " のもの、", math(String.raw`\varepsilon_V`), " を空の組（", ref("def_empty_tuple_of_vector_space_elements"),
        "）とし、", math(String.raw`l\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`G\in T_l`), " とする。",
        math(String.raw`0+l=l`), " なので左辺は ", math(String.raw`T_l`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`m_{0,l}\bigl(\tau_0(\varepsilon_V),G\bigr)=G`),
    ],
    proof: [
      paragraph([
        "線型写像 ", math(String.raw`m_{0,l}\bigl(\tau_0(\varepsilon_V),\bullet\bigr):T_l\to T_l`), "（",
        ref("claim_product_of_tensors_is_linear_in_second_factor"), "）と、恒等写像 ", math(String.raw`\mathrm{id}_{T_l}`),
        " を比べる。恒等写像は加法とスカラー倍を保つので線型写像である（", ref("def_linear_map"), "）。",
        math(String.raw`u'\in V^{\{1,\dots,l\}}`), " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{0,l}\bigl(\tau_0(\varepsilon_V),\tau_l(u')\bigr)
&=\tau_l\bigl(\mathrm{cat}_{0,l}(\varepsilon_V,u')\bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\tau_l(u')
&&\left(\because\ \blkref{claim_concatenation_with_empty_tuple_on_left}\right)\\
&=\mathrm{id}_{T_l}\bigl(\tau_l(u')\bigr)
&&\left(\because\ \text{恒等写像の定義}\right).
\end{aligned}`),
      paragraph([
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_l,\tau_l)`),
        " に当てると、二つの線型写像は等しい。", math(String.raw`G`), " での値が主張の等式である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_product_with_image_of_empty_tuple_on_right",
    kind: "claim",
    title: { text: "空の組の像を後ろから掛けてもテンソルは変わらない" },
    labels: ["claim_product_with_image_of_empty_tuple_on_right"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`m_{k,l}`),
        "、", math(String.raw`\varepsilon_V`), " を ", ref("claim_product_with_image_of_empty_tuple_on_left"), " のものとし、",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`F\in T_k`), " とする。", math(String.raw`k+0=k`),
        " なので左辺は ", math(String.raw`T_k`), " の元であり、次が成り立つ。",
      ]),
      displayMath(String.raw`m_{k,0}\bigl(F,\tau_0(\varepsilon_V)\bigr)=F`),
    ],
    proof: [
      paragraph([
        "線型写像 ", math(String.raw`m_{k,0}\bigl(\bullet,\tau_0(\varepsilon_V)\bigr):T_k\to T_k`), "（",
        ref("claim_product_of_tensors_is_linear_in_first_factor"), "）と、線型写像である恒等写像 ",
        math(String.raw`\mathrm{id}_{T_k}`), "（", ref("def_linear_map"), "）を比べる。",
        math(String.raw`u\in V^{\{1,\dots,k\}}`), " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
m_{k,0}\bigl(\tau_k(u),\tau_0(\varepsilon_V)\bigr)
&=\tau_k\bigl(\mathrm{cat}_{k,0}(u,\varepsilon_V)\bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\tau_k(u)
&&\left(\because\ \blkref{claim_concatenation_with_empty_tuple_on_right}\right)\\
&=\mathrm{id}_{T_k}\bigl(\tau_k(u)\bigr)
&&\left(\because\ \text{恒等写像の定義}\right).
\end{aligned}`),
      paragraph([
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_k,\tau_k)`),
        " に当てると、二つの線型写像は等しい。", math(String.raw`F`), " での値が主張の等式である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_vector_space_of_tensor_algebra",
    kind: "definition",
    title: { text: "テンソル代数の台の線型空間" },
    labels: ["def_vector_space_of_tensor_algebra"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`), "、", math(String.raw`b:\{1,\dots,n\}\to V`), " を ", math(String.raw`V`),
        " の基底（", ref("def_basis"), "）とする。各 ", math(String.raw`j\in\mathbb{Z}_{\ge 0}`), " について ",
        math(String.raw`T_j:=V^{\otimes_b j}`), "、", math(String.raw`\tau_j:=\tau_{b,j}`), " と置く（",
        ref("def_construction_of_k_fold_tensor_product"), "）。", math(String.raw`(T_j,\tau_j)`), " は ",
        math(String.raw`V`), " の ", math(String.raw`j`), " 重テンソル積である（",
        ref("claim_construction_is_k_fold_tensor_product"), "）。各 ", math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`),
        " について、", math(String.raw`m_{k,l}:T_k\times T_l\to T_{k+l}`), " をこの族のテンソルの積（",
        ref("def_product_of_tensors"), "）とする。",
      ]),
      paragraph([
        "族 ", math(String.raw`(T_j)_{j\in\mathbb{Z}_{\ge 0}}`), " の直和（", ref("def_direct_sum_of_family_of_vector_spaces"), "、",
        ref("def_operations_on_direct_sum_of_family_of_vector_spaces"), "）を ",
        math(String.raw`(D,+_D,\cdot_D,0_D)`), " と書き、", math(String.raw`V`), " のテンソル代数の台の線型空間と呼ぶ。",
        "これは ℂ-線型空間である（", ref("claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"), "）。",
        math(String.raw`\mathrm{emb}_k:T_k\to D`), " を第 ", math(String.raw`k`), " 成分への埋め込み写像（",
        ref("def_embedding_into_component_of_direct_sum_of_family"), "）とする。",
        math(String.raw`D`), " は基底 ", math(String.raw`b`), " の取り方にもよるが、記号には ", math(String.raw`b`), " を添えない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_numbering_of_initial_segment_from_zero",
    kind: "claim",
    title: { text: "{0,…,N} の番号付け" },
    labels: ["claim_numbering_of_initial_segment_from_zero"],
    statement: [
      paragraph([
        math(String.raw`N\in\mathbb{Z}_{\ge 0}`), " とし、写像 ", math(String.raw`e:\{1,\dots,N+1\}\to\{0,\dots,N\}`), " を ",
        math(String.raw`e(s):=s-1`), " で定める。このとき ", math(String.raw`(N+1,e)`), " は ",
        math(String.raw`\{0,\dots,N\}`), " の番号付け（", ref("def_numbering_of_finite_set"), "）であり、",
        math(String.raw`\{0,\dots,N\}`), " は有限集合である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`1\le s\le N+1`), " なら ", math(String.raw`0\le s-1\le N`), " なので、", math(String.raw`e`),
        " の値は ", math(String.raw`\{0,\dots,N\}`), " に入る。（単射）", math(String.raw`e(s)=e(t)`), " なら ",
        math(String.raw`s=e(s)+1=e(t)+1=t`), " である。（全射）", math(String.raw`i\in\{0,\dots,N\}`), " について ",
        math(String.raw`s:=i+1\in\{1,\dots,N+1\}`), " は ", math(String.raw`e(s)=i`), " を満たす。したがって ",
        math(String.raw`(N+1,e)`), " は番号付けであり（", ref("def_numbering_of_finite_set"), "）、",
        math(String.raw`\{0,\dots,N\}`), " は有限集合である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_sum_over_finite_set_of_zero_terms_is_zero",
    kind: "claim",
    title: { text: "どの項も零ベクトルである有限集合の上の和は零ベクトルである" },
    labels: ["claim_sum_over_finite_set_of_zero_terms_is_zero"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`X`), " を有限集合（", ref("def_numbering_of_finite_set"), "）とし、", math(String.raw`X`),
        " の各元 ", math(String.raw`x`), " に ", math(String.raw`V`), " の元 ", math(String.raw`v_x`), " と ",
        math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_x`), " が一つずつ与えられていて、すべての ",
        math(String.raw`x\in X`), " について ", math(String.raw`\lambda_x\cdot_V v_x=0_V`), " が成り立つとする。このとき、有限集合の上の和（",
        ref("def_sum_over_finite_set"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\sum_{x\in X}\lambda_x\cdot_V v_x=0_V`),
    ],
    proof: [
      paragraph([
        "すべての ", math(String.raw`x\in X`), " について ", math(String.raw`\lambda_x\cdot_V v_x=0_V=0_{\mathbb{C}}\cdot_V v_x`),
        " である（仮定と ", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。また ",
        math(String.raw`0_{\mathbb{C}}=0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{x\in X}\lambda_x\cdot_V v_x
&=\sum_{x\in X}0_{\mathbb{C}}\cdot_V v_x
&&\left(\because\ \text{各項が等しい。}\blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{x\in X}(0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}})\cdot_V v_x
&&\left(\because\ 0_{\mathbb{C}}=0_{\mathbb{C}}\cdot_{\mathbb{C}}0_{\mathbb{C}}\right)\\
&=0_{\mathbb{C}}\cdot_V\left(\sum_{x\in X}0_{\mathbb{C}}\cdot_V v_x\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\ \text{を}\ \rho=0_{\mathbb{C}}\ \text{で}\right)\\
&=0_V
&&\left(\because\ \blkref{claim_zero_scalar_multiple_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum",
    kind: "claim",
    title: { text: "テンソル代数の台の二つの元の成分のテンソルの積の和は、台の元である" },
    labels: ["claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum"],
    statement: [
      paragraph([
        math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`m_{k,l}`), "、", math(String.raw`D`),
        " を ", ref("def_vector_space_of_tensor_algebra"), " のものとし、", math(String.raw`x,y\in D`), " とする。各 ",
        math(String.raw`p\in\mathbb{Z}_{\ge 0}`), " と ", math(String.raw`i\in\{0,\dots,p\}`), " について ",
        math(String.raw`i+(p-i)=p`), " なので ", math(String.raw`m_{i,p-i}(x_i,y_{p-i})\in T_p`), " である。",
        math(String.raw`\{0,\dots,p\}`), " は有限集合なので（", ref("claim_numbering_of_initial_segment_from_zero"), "）、",
        math(String.raw`T_p`), " の元 ",
      ]),
      displayMath(String.raw`c_p:=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}(x_i,y_{p-i})`),
      paragraph([
        "が定まる（", ref("def_sum_over_finite_set"), "）。このとき族 ", math(String.raw`c=(c_p)_{p\in\mathbb{Z}_{\ge 0}}`), " は ",
        math(String.raw`D`), " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N_x,N_y\in\mathbb{Z}_{\ge 0}`), " を ", math(String.raw`x,y`), " の零の境とし（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）、", math(String.raw`N:=N_x+N_y`), " と置く。",
        math(String.raw`p>N`), " とし、", math(String.raw`i\in\{0,\dots,p\}`), " を任意に取る。写像 ",
        math(String.raw`m_{i,p-i}(\bullet,G)`), " と ", math(String.raw`m_{i,p-i}(F,\bullet)`), " は線型写像なので（",
        ref("claim_product_of_tensors_is_linear_in_first_factor"), "、", ref("claim_product_of_tensors_is_linear_in_second_factor"),
        "）、零ベクトルを零ベクトルへ移す（", ref("claim_linear_map_sends_zero_to_zero"), "）。",
        math(String.raw`i>N_x`), " なら ", math(String.raw`x_i=0_{T_i}`), " なので ",
        math(String.raw`m_{i,p-i}(x_i,y_{p-i})=m_{i,p-i}(0_{T_i},y_{p-i})=0_{T_p}`), " である。",
        math(String.raw`i\le N_x`), " なら ", math(String.raw`p-i\ge p-N_x>N_y`), " なので ", math(String.raw`y_{p-i}=0_{T_{p-i}}`),
        " であり、", math(String.raw`m_{i,p-i}(x_i,y_{p-i})=m_{i,p-i}(x_i,0_{T_{p-i}})=0_{T_p}`), " である。どちらの場合も ",
        math(String.raw`1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}(x_i,y_{p-i})=1_{\mathbb{C}}\cdot_{T_p}0_{T_p}=0_{T_p}`), " である（",
        ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "）。",
        ref("claim_sum_over_finite_set_of_zero_terms_is_zero"), " により ", math(String.raw`c_p=0_{T_p}`),
        " である。したがって ", math(String.raw`N`), " は ", math(String.raw`c`), " の零の境の条件を満たし、",
        math(String.raw`c\in D`), " である（", ref("def_direct_sum_of_family_of_vector_spaces"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_product_and_unit_of_tensor_algebra",
    kind: "definition",
    title: { text: "テンソル代数の積と単位元" },
    labels: ["def_product_and_unit_of_tensor_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`m_{k,l}`), "、",
        math(String.raw`D`), "、", math(String.raw`\mathrm{emb}_k`), " を ", ref("def_vector_space_of_tensor_algebra"),
        " のもの、", math(String.raw`\varepsilon_V`), " を空の組（", ref("def_empty_tuple_of_vector_space_elements"),
        "）とする。写像 ", math(String.raw`\star_D:D\times D\to D`), " と元 ", math(String.raw`1_D\in D`), " を次で定める。",
      ]),
      list([
        [
          math(String.raw`(x\star_D y)_p:=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}(x_i,y_{p-i})`),
          "（", math(String.raw`x,y\in D`), "、", math(String.raw`p\in\mathbb{Z}_{\ge 0}`), "。右辺の族が ",
          math(String.raw`D`), " の元であることは ", ref("claim_convolution_of_tensor_algebra_elements_lies_in_direct_sum"), "）",
        ],
        [math(String.raw`1_D:=\mathrm{emb}_0\bigl(\tau_0(\varepsilon_V)\bigr)`)],
      ]),
      paragraph([
        math(String.raw`\star_D`), " を ", math(String.raw`D`), " の上のテンソル代数の積、", math(String.raw`1_D`),
        " をテンソル代数の単位元と呼ぶ。", math(String.raw`\star_D`), " は ", math(String.raw`D`), " のスカラー倍 ",
        math(String.raw`\cdot_D`), " とは定義域の異なる別の写像であり、記号で区別する。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_projection_onto_component_of_direct_sum_of_family_is_linear_map",
    kind: "claim",
    title: { text: "番号付けた族の直和の成分を取り出す写像は線型写像である" },
    labels: ["claim_projection_onto_component_of_direct_sum_of_family_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`), " を ", ref("def_direct_sum_of_family_of_vector_spaces"), " のもの、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`), " をその直和（", ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        "）とし、", math(String.raw`k\in\mathbb{Z}_{\ge 0}`), " とする。写像 ", math(String.raw`\mathrm{pr}_k:D\to E_k`), " を ",
        math(String.raw`\mathrm{pr}_k(x):=x_k`), " で定める。このとき ", math(String.raw`\mathrm{pr}_k`), " は線型写像（",
        ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`x,y\in D`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{pr}_k(x+_D y)
&=(x+_D y)_k
&&\left(\because\ \mathrm{pr}_k\ \text{の定義}\right)\\
&=x_k+_{E_k}y_k
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\mathrm{pr}_k(x)+_{E_k}\mathrm{pr}_k(y)
&&\left(\because\ \mathrm{pr}_k\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\mathrm{pr}_k(\lambda\cdot_D x)
&=(\lambda\cdot_D x)_k
&&\left(\because\ \mathrm{pr}_k\ \text{の定義}\right)\\
&=\lambda\cdot_{E_k}x_k
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right)\\
&=\lambda\cdot_{E_k}\mathrm{pr}_k(x)
&&\left(\because\ \mathrm{pr}_k\ \text{の定義}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`\mathrm{pr}_k`), " は線型写像である（", ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tensor_algebra_product_is_linear_in_second_factor",
    kind: "claim",
    title: { text: "テンソル代数の積は後ろの因子について線型である" },
    labels: ["claim_tensor_algebra_product_is_linear_in_second_factor"],
    statement: [
      paragraph([
        math(String.raw`D`), " と ", math(String.raw`\star_D`), " を ", ref("def_product_and_unit_of_tensor_algebra"),
        " のものとし、", math(String.raw`x\in D`), " とする。このとき、", math(String.raw`y,y'\in D`), " と ",
        math(String.raw`\lambda\in\mathbb{C}`), " について次の二つが成り立つ。すなわち写像 ",
        math(String.raw`x\star_D\bullet:D\to D`), "（", math(String.raw`z\mapsto x\star_D z`), "）は線型写像（",
        ref("def_linear_map"), "）である。",
      ]),
      list([
        [math(String.raw`x\star_D(y+_D y')=x\star_D y+_D x\star_D y'`)],
        [math(String.raw`x\star_D(\lambda\cdot_D y)=\lambda\cdot_D(x\star_D y)`)],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`p\in\mathbb{Z}_{\ge 0}`), " を任意に取り、第 ", math(String.raw`p`), " 成分を比べる（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）。", math(String.raw`i\in\{0,\dots,p\}`), " について ",
        math(String.raw`a_i:=m_{i,p-i}(x_i,y_{p-i})`), "、", math(String.raw`a'_i:=m_{i,p-i}(x_i,y'_{p-i})`),
        " と置く（", math(String.raw`T_p`), " の元）。各 ", math(String.raw`i`), " について、",
        math(String.raw`m_{i,p-i}(x_i,\bullet)`), " は線型写像なので（", ref("claim_product_of_tensors_is_linear_in_second_factor"),
        "）、", math(String.raw`m_{i,p-i}(x_i,y_{p-i}+_{T_{p-i}}y'_{p-i})=a_i+_{T_p}a'_i`), "、",
        math(String.raw`m_{i,p-i}(x_i,\lambda\cdot_{T_{p-i}}y_{p-i})=\lambda\cdot_{T_p}a_i`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(x\star_D(y+_D y')\bigr)_p
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(x_i,(y+_D y')_{p-i}\bigr)
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(x_i,y_{p-i}+_{T_{p-i}}y'_{p-i}\bigr)
&&\left(\because\ +_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}(a_i+_{T_p}a'_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a_i\right)+_{T_p}\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a'_i\right)
&&\left(\because\ \blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=(x\star_D y)_p+_{T_p}(x\star_D y')_p
&&\left(\because\ \star_D\ \text{の定義を二か所に適用。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=(x\star_D y+_D x\star_D y')_p
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl(x\star_D(\lambda\cdot_D y)\bigr)_p
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(x_i,(\lambda\cdot_D y)_{p-i}\bigr)
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(x_i,\lambda\cdot_{T_{p-i}}y_{p-i}\bigr)
&&\left(\because\ \cdot_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}(\lambda\cdot_{T_p}a_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}\lambda)\cdot_{T_p}a_i
&&\left(\because\ T_p\ \text{のスカラー倍の結合法則（}\blkref{def_complex_vector_space}\text{）と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}(\lambda\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{T_p}a_i
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\cdot_{T_p}\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a_i\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\ \text{を}\ \rho=\lambda\ \text{で}\right)\\
&=\lambda\cdot_{T_p}(x\star_D y)_p
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\bigl(\lambda\cdot_D(x\star_D y)\bigr)_p
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([math(String.raw`p`), " は任意だったので、二つの等式が ", math(String.raw`D`), " の等式として成り立つ。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tensor_algebra_product_is_linear_in_first_factor",
    kind: "claim",
    title: { text: "テンソル代数の積は前の因子について線型である" },
    labels: ["claim_tensor_algebra_product_is_linear_in_first_factor"],
    statement: [
      paragraph([
        math(String.raw`D`), " と ", math(String.raw`\star_D`), " を ", ref("def_product_and_unit_of_tensor_algebra"),
        " のものとし、", math(String.raw`y\in D`), " とする。このとき、", math(String.raw`x,x'\in D`), " と ",
        math(String.raw`\lambda\in\mathbb{C}`), " について次の二つが成り立つ。すなわち写像 ",
        math(String.raw`\bullet\star_D y:D\to D`), "（", math(String.raw`z\mapsto z\star_D y`), "）は線型写像（",
        ref("def_linear_map"), "）である。",
      ]),
      list([
        [math(String.raw`(x+_D x')\star_D y=x\star_D y+_D x'\star_D y`)],
        [math(String.raw`(\lambda\cdot_D x)\star_D y=\lambda\cdot_D(x\star_D y)`)],
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`p\in\mathbb{Z}_{\ge 0}`), " を任意に取り、第 ", math(String.raw`p`), " 成分を比べる（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）。", math(String.raw`i\in\{0,\dots,p\}`), " について ",
        math(String.raw`a_i:=m_{i,p-i}(x_i,y_{p-i})`), "、", math(String.raw`a'_i:=m_{i,p-i}(x'_i,y_{p-i})`),
        " と置く。各 ", math(String.raw`i`), " について、", math(String.raw`m_{i,p-i}(\bullet,y_{p-i})`), " は線型写像なので（",
        ref("claim_product_of_tensors_is_linear_in_first_factor"), "）、",
        math(String.raw`m_{i,p-i}(x_i+_{T_i}x'_i,y_{p-i})=a_i+_{T_p}a'_i`), "、",
        math(String.raw`m_{i,p-i}(\lambda\cdot_{T_i}x_i,y_{p-i})=\lambda\cdot_{T_p}a_i`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((x+_D x')\star_D y\bigr)_p
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl((x+_D x')_i,y_{p-i}\bigr)
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(x_i+_{T_i}x'_i,y_{p-i}\bigr)
&&\left(\because\ +_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}(a_i+_{T_p}a'_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a_i\right)+_{T_p}\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a'_i\right)
&&\left(\because\ \blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=(x\star_D y)_p+_{T_p}(x'\star_D y)_p
&&\left(\because\ \star_D\ \text{の定義を二か所に適用。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=(x\star_D y+_D x'\star_D y)_p
&&\left(\because\ +_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl((\lambda\cdot_D x)\star_D y\bigr)_p
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl((\lambda\cdot_D x)_i,y_{p-i}\bigr)
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}m_{i,p-i}\bigl(\lambda\cdot_{T_i}x_i,y_{p-i}\bigr)
&&\left(\because\ \cdot_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}(\lambda\cdot_{T_p}a_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}(1_{\mathbb{C}}\cdot_{\mathbb{C}}\lambda)\cdot_{T_p}a_i
&&\left(\because\ T_p\ \text{のスカラー倍の結合法則（}\blkref{def_complex_vector_space}\text{）と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in\{0,\dots,p\}}(\lambda\cdot_{\mathbb{C}}1_{\mathbb{C}})\cdot_{T_p}a_i
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\cdot_{T_p}\left(\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}a_i\right)
&&\left(\because\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\ \text{を}\ \rho=\lambda\ \text{で}\right)\\
&=\lambda\cdot_{T_p}(x\star_D y)_p
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\bigl(\lambda\cdot_D(x\star_D y)\bigr)_p
&&\left(\because\ \cdot_D\ \text{の定義。}\blkref{def_operations_on_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([math(String.raw`p`), " は任意だったので、二つの等式が ", math(String.raw`D`), " の等式として成り立つ。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tensor_algebra_product_of_embedded_tensors",
    kind: "claim",
    title: { text: "成分へ埋め込んだテンソルどうしのテンソル代数の積は、テンソルの積の埋め込みである" },
    labels: ["claim_tensor_algebra_product_of_embedded_tensors"],
    statement: [
      paragraph([
        math(String.raw`D`), "、", math(String.raw`\mathrm{emb}_k`), "、", math(String.raw`m_{k,l}`), "、", math(String.raw`\star_D`),
        " を ", ref("def_product_and_unit_of_tensor_algebra"), " のものとし、", math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`F\in T_k`), "、", math(String.raw`G\in T_l`), " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`\mathrm{emb}_k(F)\star_D\mathrm{emb}_l(G)=\mathrm{emb}_{k+l}\bigl(m_{k,l}(F,G)\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`x:=\mathrm{emb}_k(F)`), "、", math(String.raw`y:=\mathrm{emb}_l(G)`), " と置き、",
        math(String.raw`p\in\mathbb{Z}_{\ge 0}`), " を任意に取る。", math(String.raw`i\in\{0,\dots,p\}`), " について ",
        math(String.raw`w_i:=m_{i,p-i}(x_i,y_{p-i})\in T_p`), " と置く。線型写像 ", math(String.raw`m_{i,p-i}(\bullet,y_{p-i})`),
        " と ", math(String.raw`m_{i,p-i}(x_i,\bullet)`), "（", ref("claim_product_of_tensors_is_linear_in_first_factor"), "、",
        ref("claim_product_of_tensors_is_linear_in_second_factor"), "）は零ベクトルを零ベクトルへ移す（",
        ref("claim_linear_map_sends_zero_to_zero"), "）。", math(String.raw`i\neq k`), " なら ", math(String.raw`x_i=0_{T_i}`),
        "（", ref("def_embedding_into_component_of_direct_sum_of_family"), "）なので ", math(String.raw`w_i=0_{T_p}`), " である。",
      ]),
      paragraph([
        math(String.raw`p=k+l`), " のとき：", math(String.raw`k\in\{0,\dots,p\}`), "、", math(String.raw`p-k=l`), " であり、",
        math(String.raw`w_k=m_{k,l}(x_k,y_l)=m_{k,l}(F,G)`), " である（", ref("def_embedding_into_component_of_direct_sum_of_family"),
        "）。", math(String.raw`\{0,\dots,p\}`), " の元についてのクロネッカーのデルタ（", ref("def_kronecker_delta"), "）を使うと、",
        math(String.raw`i=k`), " なら ", math(String.raw`1_{\mathbb{C}}\cdot_{T_p}w_i=\delta_{k,i}\cdot_{T_p}w_i`), "、",
        math(String.raw`i\neq k`), " なら ", math(String.raw`1_{\mathbb{C}}\cdot_{T_p}w_i=0_{T_p}=\delta_{k,i}\cdot_{T_p}w_i`),
        " である（", ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "、", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x\star_D y)_{k+l}
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}w_i
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\sum_{i\in\{0,\dots,p\}}\delta_{k,i}\cdot_{T_p}w_i
&&\left(\because\ \text{上の各項の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=w_k
&&\left(\because\ \blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=m_{k,l}(F,G)
&&\left(\because\ \text{上の}\ w_k\ \text{の値}\right)\\
&=\Bigl(\mathrm{emb}_{k+l}\bigl(m_{k,l}(F,G)\bigr)\Bigr)_{k+l}
&&\left(\because\ \blkref{def_embedding_into_component_of_direct_sum_of_family}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`p\neq k+l`), " のとき：", math(String.raw`i\neq k`), " なら上のとおり ", math(String.raw`w_i=0_{T_p}`),
        " である。", math(String.raw`i=k`), " なら ", math(String.raw`p-k\neq l`), " なので ", math(String.raw`y_{p-k}=0_{T_{p-k}}`),
        " であり（", ref("def_embedding_into_component_of_direct_sum_of_family"), "）、", math(String.raw`w_k=0_{T_p}`),
        " である。したがってすべての ", math(String.raw`i`), " で ", math(String.raw`1_{\mathbb{C}}\cdot_{T_p}w_i=0_{T_p}`), " である（",
        ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(x\star_D y)_p
&=\sum_{i\in\{0,\dots,p\}}1_{\mathbb{C}}\cdot_{T_p}w_i
&&\left(\because\ \star_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=0_{T_p}
&&\left(\because\ \blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=\Bigl(\mathrm{emb}_{k+l}\bigl(m_{k,l}(F,G)\bigr)\Bigr)_p
&&\left(\because\ p\neq k+l\ \text{と}\ \blkref{def_embedding_into_component_of_direct_sum_of_family}\right).
\end{aligned}`),
      paragraph([math(String.raw`p`), " は任意だったので、両辺は ", math(String.raw`D`), " の元として等しい（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_element_of_direct_sum_of_family_is_sum_of_embedded_components",
    kind: "claim",
    title: { text: "番号付けた族の直和の元は、成分の埋め込みの有限集合の上の和である" },
    labels: ["claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"],
    statement: [
      paragraph([
        math(String.raw`(E_j)_{j\in\mathbb{Z}_{\ge 0}}`), " を ", ref("def_direct_sum_of_family_of_vector_spaces"), " のもの、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`), " をその直和（", ref("def_operations_on_direct_sum_of_family_of_vector_spaces"),
        "）、", math(String.raw`\mathrm{emb}_i:E_i\to D`), " を第 ", math(String.raw`i`), " 成分への埋め込み写像（",
        ref("def_embedding_into_component_of_direct_sum_of_family"), "）とする。", math(String.raw`x\in D`), " とし、",
        math(String.raw`N\in\mathbb{Z}_{\ge 0}`), " を ", math(String.raw`x`), " の零の境とする。", math(String.raw`\{0,\dots,N\}`),
        " は有限集合なので（", ref("claim_numbering_of_initial_segment_from_zero"), "）、", math(String.raw`D`),
        " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`x=\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)`),
    ],
    proof: [
      paragraph([
        "右辺を ", math(String.raw`s`), " と置く。", math(String.raw`j\in\mathbb{Z}_{\ge 0}`), " を任意に取り、",
        math(String.raw`i\in\{0,\dots,N\}`), " について ", math(String.raw`v_i:=\mathrm{pr}_j\bigl(\mathrm{emb}_i(x_i)\bigr)\in E_j`),
        " と置く（", math(String.raw`\mathrm{pr}_j`), " は ", ref("claim_projection_onto_component_of_direct_sum_of_family_is_linear_map"),
        "）。", ref("def_embedding_into_component_of_direct_sum_of_family"), " から、", math(String.raw`i=j`), " なら ",
        math(String.raw`v_j=x_j`), "、", math(String.raw`i\neq j`), " なら ", math(String.raw`v_i=0_{E_j}`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
s_j
&=\mathrm{pr}_j(s)
&&\left(\because\ \mathrm{pr}_j\ \text{の定義}\right)\\
&=\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\cdot_{E_j}v_i
&&\left(\because\ \mathrm{pr}_j\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j\le N`), " のとき：", math(String.raw`j\in\{0,\dots,N\}`), " である。", math(String.raw`i=j`), " なら ",
        math(String.raw`1_{\mathbb{C}}\cdot_{E_j}v_i=\delta_{j,i}\cdot_{E_j}v_i`), "、", math(String.raw`i\neq j`), " なら ",
        math(String.raw`1_{\mathbb{C}}\cdot_{E_j}v_i=0_{E_j}=\delta_{j,i}\cdot_{E_j}v_i`), " である（", ref("def_kronecker_delta"), "、",
        ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "、", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\cdot_{E_j}v_i
&=\sum_{i\in\{0,\dots,N\}}\delta_{j,i}\cdot_{E_j}v_i
&&\left(\because\ \text{上の各項の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=v_j
&&\left(\because\ \blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=x_j
&&\left(\because\ \text{上の}\ v_j\ \text{の値}\right).
\end{aligned}`),
      paragraph([
        math(String.raw`j>N`), " のとき：すべての ", math(String.raw`i\in\{0,\dots,N\}`), " で ", math(String.raw`i\neq j`),
        " なので ", math(String.raw`1_{\mathbb{C}}\cdot_{E_j}v_i=1_{\mathbb{C}}\cdot_{E_j}0_{E_j}=0_{E_j}`), " である（",
        ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\cdot_{E_j}v_i
&=0_{E_j}
&&\left(\because\ \blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=x_j
&&\left(\because\ j>N\ \text{と零の境の条件。}\blkref{def_direct_sum_of_family_of_vector_spaces}\right).
\end{aligned}`),
      paragraph([math(String.raw`j`), " は任意だったので、", math(String.raw`s=x`), " である（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tensor_algebra_product_is_associative",
    kind: "claim",
    title: { text: "テンソル代数の積は結合的である" },
    labels: ["claim_tensor_algebra_product_is_associative"],
    statement: [
      paragraph([
        math(String.raw`D`), " と ", math(String.raw`\star_D`), " を ", ref("def_product_and_unit_of_tensor_algebra"),
        " のものとし、", math(String.raw`x,y,z\in D`), " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`(x\star_D y)\star_D z=x\star_D(y\star_D z)`),
    ],
    proof: [
      paragraph([
        math(String.raw`N_x,N_y,N_z\in\mathbb{Z}_{\ge 0}`), " を ", math(String.raw`x,y,z`), " の零の境とし、",
        math(String.raw`I:=\{0,\dots,N_x\}`), "、", math(String.raw`J:=\{0,\dots,N_y\}`), "、", math(String.raw`K:=\{0,\dots,N_z\}`),
        "、", math(String.raw`a_i:=\mathrm{emb}_i(x_i)`), "（", math(String.raw`i\in I`), "）、", math(String.raw`b_j:=\mathrm{emb}_j(y_j)`),
        "（", math(String.raw`j\in J`), "）、", math(String.raw`c_k:=\mathrm{emb}_k(z_k)`), "（", math(String.raw`k\in K`), "）と置く。",
        ref("claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"), " により ",
        math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i`), "、", math(String.raw`y=\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j`), "、",
        math(String.raw`z=\sum_{k\in K}1_{\mathbb{C}}\cdot_D c_k`), " である。写像 ", math(String.raw`w\star_D\bullet`), " と ",
        math(String.raw`\bullet\star_D w`), "（", math(String.raw`w\in D`), "）は線型写像なので（",
        ref("claim_tensor_algebra_product_is_linear_in_second_factor"), "、", ref("claim_tensor_algebra_product_is_linear_in_first_factor"),
        "）、以下で ", ref("claim_linear_map_maps_sum_over_finite_set_to_sum_of_values"), " を当てられる。",
      ]),
      paragraph(["（埋め込んだテンソルが三つのとき）", math(String.raw`i\in I`), "、", math(String.raw`j\in J`), "、",
        math(String.raw`k\in K`), " とする。"]),
      displayMath(String.raw`\begin{aligned}
(a_i\star_D b_j)\star_D c_k
&=\mathrm{emb}_{i+j}\bigl(m_{i,j}(x_i,y_j)\bigr)\star_D c_k
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=\mathrm{emb}_{i+j+k}\Bigl(m_{i+j,k}\bigl(m_{i,j}(x_i,y_j),z_k\bigr)\Bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=\mathrm{emb}_{i+j+k}\Bigl(m_{i,j+k}\bigl(x_i,m_{j,k}(y_j,z_k)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_product_of_tensors_is_associative}\right)\\
&=a_i\star_D\mathrm{emb}_{j+k}\bigl(m_{j,k}(y_j,z_k)\bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=a_i\star_D(b_j\star_D c_k)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right).
\end{aligned}`),
      paragraph(["（埋め込んだテンソルが前の二つのとき）", math(String.raw`i\in I`), "、", math(String.raw`j\in J`), " とする。"]),
      displayMath(String.raw`\begin{aligned}
(a_i\star_D b_j)\star_D z
&=(a_i\star_D b_j)\star_D\sum_{k\in K}1_{\mathbb{C}}\cdot_D c_k
&&\left(\because\ z\ \text{の分解}\right)\\
&=\sum_{k\in K}1_{\mathbb{C}}\cdot_D\bigl((a_i\star_D b_j)\star_D c_k\bigr)
&&\left(\because\ (a_i\star_D b_j)\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{k\in K}1_{\mathbb{C}}\cdot_D\bigl(a_i\star_D(b_j\star_D c_k)\bigr)
&&\left(\because\ \text{前の段と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a_i\star_D\sum_{k\in K}1_{\mathbb{C}}\cdot_D(b_j\star_D c_k)
&&\left(\because\ a_i\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a_i\star_D\left(b_j\star_D\sum_{k\in K}1_{\mathbb{C}}\cdot_D c_k\right)
&&\left(\because\ b_j\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a_i\star_D(b_j\star_D z)
&&\left(\because\ z\ \text{の分解}\right).
\end{aligned}`),
      paragraph(["（埋め込んだテンソルが前の一つのとき）", math(String.raw`i\in I`), " とする。"]),
      displayMath(String.raw`\begin{aligned}
(a_i\star_D y)\star_D z
&=\left(a_i\star_D\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j\right)\star_D z
&&\left(\because\ y\ \text{の分解}\right)\\
&=\left(\sum_{j\in J}1_{\mathbb{C}}\cdot_D(a_i\star_D b_j)\right)\star_D z
&&\left(\because\ a_i\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{j\in J}1_{\mathbb{C}}\cdot_D\bigl((a_i\star_D b_j)\star_D z\bigr)
&&\left(\because\ \bullet\star_D z\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{j\in J}1_{\mathbb{C}}\cdot_D\bigl(a_i\star_D(b_j\star_D z)\bigr)
&&\left(\because\ \text{前の段と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=a_i\star_D\sum_{j\in J}1_{\mathbb{C}}\cdot_D(b_j\star_D z)
&&\left(\because\ a_i\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a_i\star_D\left(\left(\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j\right)\star_D z\right)
&&\left(\because\ \bullet\star_D z\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=a_i\star_D(y\star_D z)
&&\left(\because\ y\ \text{の分解}\right).
\end{aligned}`),
      paragraph(["（一般のとき）"]),
      displayMath(String.raw`\begin{aligned}
(x\star_D y)\star_D z
&=\left(\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i\right)\star_D y\right)\star_D z
&&\left(\because\ x\ \text{の分解}\right)\\
&=\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D(a_i\star_D y)\right)\star_D z
&&\left(\because\ \bullet\star_D y\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\bigl((a_i\star_D y)\star_D z\bigr)
&&\left(\because\ \bullet\star_D z\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\bigl(a_i\star_D(y\star_D z)\bigr)
&&\left(\because\ \text{前の段と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i\right)\star_D(y\star_D z)
&&\left(\because\ \bullet\star_D(y\star_D z)\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=x\star_D(y\star_D z)
&&\left(\because\ x\ \text{の分解}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_unit_of_tensor_algebra_is_left_unit",
    kind: "claim",
    title: { text: "テンソル代数の単位元は左から掛けても元を変えない" },
    labels: ["claim_unit_of_tensor_algebra_is_left_unit"],
    statement: [
      paragraph([
        math(String.raw`D`), "、", math(String.raw`\star_D`), "、", math(String.raw`1_D`), " を ", ref("def_product_and_unit_of_tensor_algebra"),
        " のものとし、", math(String.raw`x\in D`), " とする。このとき ", math(String.raw`1_D\star_D x=x`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N`), " を ", math(String.raw`x`), " の零の境、", math(String.raw`I:=\{0,\dots,N\}`), " とすると ",
        math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)`), " である（",
        ref("claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"), "）。各 ", math(String.raw`i\in I`), " について ",
        math(String.raw`0+i=i`), " なので次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
1_D\star_D\mathrm{emb}_i(x_i)
&=\mathrm{emb}_0\bigl(\tau_0(\varepsilon_V)\bigr)\star_D\mathrm{emb}_i(x_i)
&&\left(\because\ 1_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\mathrm{emb}_i\Bigl(m_{0,i}\bigl(\tau_0(\varepsilon_V),x_i\bigr)\Bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=\mathrm{emb}_i(x_i)
&&\left(\because\ \blkref{claim_product_with_image_of_empty_tuple_on_left}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
1_D\star_D x
&=1_D\star_D\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)
&&\left(\because\ x\ \text{の分解}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\bigl(1_D\star_D\mathrm{emb}_i(x_i)\bigr)
&&\left(\because\ 1_D\star_D\bullet\ \text{は線型写像（}\blkref{claim_tensor_algebra_product_is_linear_in_second_factor}\text{）。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=x
&&\left(\because\ x\ \text{の分解}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_unit_of_tensor_algebra_is_right_unit",
    kind: "claim",
    title: { text: "テンソル代数の単位元は右から掛けても元を変えない" },
    labels: ["claim_unit_of_tensor_algebra_is_right_unit"],
    statement: [
      paragraph([
        math(String.raw`D`), "、", math(String.raw`\star_D`), "、", math(String.raw`1_D`), " を ", ref("def_product_and_unit_of_tensor_algebra"),
        " のものとし、", math(String.raw`x\in D`), " とする。このとき ", math(String.raw`x\star_D 1_D=x`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`N`), " を ", math(String.raw`x`), " の零の境、", math(String.raw`I:=\{0,\dots,N\}`), " とすると ",
        math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)`), " である（",
        ref("claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"), "）。各 ", math(String.raw`i\in I`), " について ",
        math(String.raw`i+0=i`), " なので次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{emb}_i(x_i)\star_D 1_D
&=\mathrm{emb}_i(x_i)\star_D\mathrm{emb}_0\bigl(\tau_0(\varepsilon_V)\bigr)
&&\left(\because\ 1_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=\mathrm{emb}_i\Bigl(m_{i,0}\bigl(x_i,\tau_0(\varepsilon_V)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=\mathrm{emb}_i(x_i)
&&\left(\because\ \blkref{claim_product_with_image_of_empty_tuple_on_right}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
x\star_D 1_D
&=\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)\right)\star_D 1_D
&&\left(\because\ x\ \text{の分解}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\bigl(\mathrm{emb}_i(x_i)\star_D 1_D\bigr)
&&\left(\because\ \bullet\star_D 1_D\ \text{は線型写像（}\blkref{claim_tensor_algebra_product_is_linear_in_first_factor}\text{）。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=x
&&\left(\because\ x\ \text{の分解}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tensor_algebra_is_complex_algebra",
    kind: "claim",
    title: { text: "テンソル代数は ℂ-代数である" },
    labels: ["claim_tensor_algebra_is_complex_algebra"],
    statement: [
      paragraph([
        math(String.raw`(D,+_D,\cdot_D,0_D)`), "、", math(String.raw`\star_D`), "、", math(String.raw`1_D`), " を ",
        ref("def_product_and_unit_of_tensor_algebra"), " のものとする。このとき組 ",
        math(String.raw`(D,+_D,\star_D,\cdot_D,0_D,1_D)`), " は ℂ-代数（", ref("def_complex_algebra"), "）であり、乗法は ",
        math(String.raw`\star_D`), "、スカラー倍は ", math(String.raw`\cdot_D`), " である。",
      ]),
      paragraph([
        "この ℂ-代数を ", math(String.raw`V`), " のテンソル代数と呼び、", math(String.raw`T(V)`), " と書く。演算と単位元は ",
        math(String.raw`+_{T(V)}:=+_D`), "、", math(String.raw`\cdot_{T(V)}:=\star_D`), "、", math(String.raw`\ast_{T(V)}:=\cdot_D`), "、",
        math(String.raw`0_{T(V)}:=0_D`), "、", math(String.raw`1_{T(V)}:=1_D`), " と書く。",
      ]),
    ],
    proof: [
      paragraph([
        "（単位元をもつ環であること）", ref("def_unital_ring"), " の加法についての四つの条件は、",
        math(String.raw`(D,+_D,\cdot_D,0_D)`), " が ℂ-線型空間であること（", ref("claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"),
        "）の加法についての四つの条件（", ref("def_complex_vector_space"), "）と同じ等式である。乗法の結合法則は ",
        ref("claim_tensor_algebra_product_is_associative"), "、乗法の単位元は ", ref("claim_unit_of_tensor_algebra_is_right_unit"), " と ",
        ref("claim_unit_of_tensor_algebra_is_left_unit"), "、分配法則は ", ref("claim_tensor_algebra_product_is_linear_in_second_factor"),
        " と ", ref("claim_tensor_algebra_product_is_linear_in_first_factor"), " の加法の等式である。",
      ]),
      paragraph([
        "（ℂ-線型空間であること）", ref("claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space"), " である。",
      ]),
      paragraph([
        "（スカラー倍と乗法の両立）", math(String.raw`\lambda\in\mathbb{C}`), "、", math(String.raw`x,y\in D`), " について、",
        ref("claim_tensor_algebra_product_is_linear_in_first_factor"), " のスカラー倍の等式から ",
        math(String.raw`\lambda\cdot_D(x\star_D y)=(\lambda\cdot_D x)\star_D y`), "、",
        ref("claim_tensor_algebra_product_is_linear_in_second_factor"), " のスカラー倍の等式から ",
        math(String.raw`\lambda\cdot_D(x\star_D y)=x\star_D(\lambda\cdot_D y)`), " である。",
      ]),
      paragraph(["四つの条件が満たされたので、組は ℂ-代数である（", ref("def_complex_algebra"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_one_element_tuple",
    kind: "definition",
    title: { text: "一つの元の組" },
    labels: ["def_one_element_tuple"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）とする。",
        math(String.raw`v\in V`), " について、", math(String.raw`\langle v\rangle\in V^{\{1\}}`), "（", ref("def_tuples_of_vector_space_elements"),
        "。", math(String.raw`k=1`), "）を ", math(String.raw`\langle v\rangle(1):=v`), " で定め、", math(String.raw`v`),
        " だけからなる組と呼ぶ。", math(String.raw`\{1\}`), " の元は ", math(String.raw`1`), " だけなので、",
        math(String.raw`u\in V^{\{1\}}`), " について ", math(String.raw`u=\langle u(1)\rangle`), " であり、",
        math(String.raw`x,y\in V`), " について ", math(String.raw`\langle x\rangle[1\mapsto y]=\langle y\rangle`), "（",
        ref("def_tuple_with_one_component_replaced"), "）である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_embedding_of_vector_space_into_tensor_algebra",
    kind: "definition",
    title: { text: "線型空間からテンソル代数への埋め込み" },
    labels: ["def_embedding_of_vector_space_into_tensor_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`\mathrm{emb}_k`), " を ",
        ref("def_vector_space_of_tensor_algebra"), " のもの、", math(String.raw`T(V)`), " をテンソル代数（",
        ref("claim_tensor_algebra_is_complex_algebra"), "）とする。写像 ", math(String.raw`\iota:V\to T(V)`), " を次で定め、",
        math(String.raw`V`), " からテンソル代数への埋め込みと呼ぶ（", math(String.raw`\langle v\rangle`), " は ",
        ref("def_one_element_tuple"), "）。",
      ]),
      displayMath(String.raw`\iota(v):=\mathrm{emb}_1\Bigl(\tau_1\bigl(\langle v\rangle\bigr)\Bigr)\qquad(v\in V)`),
      paragraph([
        math(String.raw`V`), " は ", math(String.raw`T(V)`), " の部分集合ではない。", math(String.raw`V`), " の元から ",
        math(String.raw`T(V)`), " の元を作るときは ", math(String.raw`\iota`), " を通す。", math(String.raw`\iota`),
        " の像を ", math(String.raw`\iota(V):=\{\iota(v):v\in V\}`), " と書く。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map",
    kind: "claim",
    title: { text: "線型空間からテンソル代数への埋め込みは線型写像である" },
    labels: ["claim_embedding_of_vector_space_into_tensor_algebra_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`T(V)`), "、", math(String.raw`\iota`), " を ",
        ref("def_embedding_of_vector_space_into_tensor_algebra"), " のものとする。このとき ", math(String.raw`\iota`), " は ",
        math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(T(V))`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"),
        "）への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in V`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
        math(String.raw`\langle x\rangle[1\mapsto z]=\langle z\rangle`), "（", math(String.raw`z\in V`), "。", ref("def_one_element_tuple"),
        "）を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau_1\bigl(\langle x+_V y\rangle\bigr)
&=\tau_1\bigl(\langle x\rangle[1\mapsto x+_V y]\bigr)
&&\left(\because\ \blkref{def_one_element_tuple}\right)\\
&=\tau_1\bigl(\langle x\rangle[1\mapsto x]\bigr)+_{T_1}\tau_1\bigl(\langle x\rangle[1\mapsto y]\bigr)
&&\left(\because\ \tau_1\ \text{は第}\ 1\ \text{成分について加法を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\tau_1\bigl(\langle x\rangle\bigr)+_{T_1}\tau_1\bigl(\langle y\rangle\bigr)
&&\left(\because\ \blkref{def_one_element_tuple}\ \text{を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tau_1\bigl(\langle\lambda\cdot_V x\rangle\bigr)
&=\tau_1\bigl(\langle x\rangle[1\mapsto\lambda\cdot_V x]\bigr)
&&\left(\because\ \blkref{def_one_element_tuple}\right)\\
&=\lambda\cdot_{T_1}\tau_1\bigl(\langle x\rangle[1\mapsto x]\bigr)
&&\left(\because\ \tau_1\ \text{は第}\ 1\ \text{成分についてスカラー倍を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\lambda\cdot_{T_1}\tau_1\bigl(\langle x\rangle\bigr)
&&\left(\because\ \blkref{def_one_element_tuple}\right).
\end{aligned}`),
      paragraph([
        "したがって写像 ", math(String.raw`v\mapsto\tau_1(\langle v\rangle)`), " は ", math(String.raw`V`), " から ",
        math(String.raw`T_1`), " への線型写像である（", ref("def_linear_map"), "）。", math(String.raw`\iota`),
        " はこれと線型写像 ", math(String.raw`\mathrm{emb}_1`), "（", ref("claim_embedding_into_component_of_direct_sum_of_family_is_linear_map"),
        "）の合成であり、", math(String.raw`U_{\mathrm{vec}}(T(V))=(D,+_D,\cdot_D,0_D)`), " なので（",
        ref("claim_tensor_algebra_is_complex_algebra"), "）、線型写像である（", ref("claim_composition_of_linear_maps_is_linear_map"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_subalgebra_is_closed_under_sums_over_finite_sets",
    kind: "claim",
    title: { text: "部分代数は有限集合の上の和で閉じている" },
    labels: ["claim_subalgebra_is_closed_under_sums_over_finite_sets"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`B`),
        " を ", math(String.raw`A`), " の部分代数（", ref("def_subalgebra"), "）、", math(String.raw`X`), " を有限集合（",
        ref("def_numbering_of_finite_set"), "）とし、", math(String.raw`X`), " の各元 ", math(String.raw`x`), " に ",
        math(String.raw`B`), " の元 ", math(String.raw`v_x`), " と ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_x`),
        " が一つずつ与えられているとする。このとき、", math(String.raw`U_{\mathrm{vec}}(A)`), " の中の有限集合の上の和（",
        ref("def_sum_over_finite_set"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"), "）について ",
        math(String.raw`\sum_{x\in X}\lambda_x\ast_A v_x\in B`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`(n,e)`), " を ", math(String.raw`X`), " の番号付けとし、", math(String.raw`k\in\{1,\dots,n\}`), " について ",
        math(String.raw`y_k:=v_{e(k)}\in B`), "、", math(String.raw`\mu_k:=\lambda_{e(k)}`), " と置く。定義により ",
        math(String.raw`\sum_{x\in X}\lambda_x\ast_A v_x=L_n`), " であり、", math(String.raw`L_0:=0_A`), "、",
        math(String.raw`L_m:=L_{m-1}+_A(\mu_m\ast_A y_m)`), " である（", ref("def_sum_over_finite_set"), "、",
        ref("def_linear_combination"), "）。すべての ", math(String.raw`m\in\{0,\dots,n\}`), " で ", math(String.raw`L_m\in B`),
        " であることを ", math(String.raw`m`), " の帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`m=0`), " のとき：", math(String.raw`L_0=0_A=0_{\mathbb{C}}\ast_A 1_A`), "（",
        ref("claim_zero_scalar_multiple_is_zero_vector"), " を ", math(String.raw`U_{\mathrm{vec}}(A)`), " に当てる）であり、",
        math(String.raw`1_A\in B`), " と、", math(String.raw`B`), " がスカラー倍で閉じていることから ", math(String.raw`L_0\in B`),
        " である（", ref("def_subalgebra"), "）。",
      ]),
      paragraph([
        math(String.raw`1\le m\le n`), " で ", math(String.raw`L_{m-1}\in B`), " とする（帰納法の仮定）。",
        math(String.raw`y_m\in B`), " なので、スカラー倍で閉じていることから ", math(String.raw`\mu_m\ast_A y_m\in B`),
        "、加法で閉じていることから ", math(String.raw`L_m=L_{m-1}+_A(\mu_m\ast_A y_m)\in B`), " である（", ref("def_subalgebra"), "）。",
        math(String.raw`m=n`), " のときが主張である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_tuple_is_concatenation_of_initial_part_and_last_component",
    kind: "claim",
    title: { text: "組は、最後の成分を除いた組と最後の成分だけの組をつなげたものである" },
    labels: ["claim_tuple_is_concatenation_of_initial_part_and_last_component"],
    statement: [
      paragraph([
        math(String.raw`V`), " を ", ref("def_concatenation_of_tuples"), " のもの、", math(String.raw`k\in\mathbb{Z}_{\ge 1}`), "、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`), " とし、", math(String.raw`u^{-}\in V^{\{1,\dots,k-1\}}`), " を ",
        math(String.raw`u^{-}(s):=u(s)`), "（", math(String.raw`s\in\{1,\dots,k-1\}`), "）で定める。",
        math(String.raw`(k-1)+1=k`), " なので右辺は ", math(String.raw`V^{\{1,\dots,k\}}`), " の元であり、次が成り立つ（",
        math(String.raw`\langle\cdot\rangle`), " は ", ref("def_one_element_tuple"), "）。",
      ]),
      displayMath(String.raw`u=\mathrm{cat}_{k-1,1}\bigl(u^{-},\langle u(k)\rangle\bigr)`),
    ],
    proof: [
      paragraph([
        math(String.raw`s\in\{1,\dots,k\}`), " を任意に取る。", math(String.raw`s\le k-1`), " のとき：",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k-1,1}\bigl(u^{-},\langle u(k)\rangle\bigr)(s)
&=u^{-}(s)
&&\left(\because\ 1\le s\le k-1\ \text{と}\ \blkref{def_concatenation_of_tuples}\right)\\
&=u(s)
&&\left(\because\ u^{-}\ \text{の定義}\right).
\end{aligned}`),
      paragraph([math(String.raw`s=k`), " のとき：", math(String.raw`(k-1)+1\le k\le (k-1)+1`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cat}_{k-1,1}\bigl(u^{-},\langle u(k)\rangle\bigr)(k)
&=\langle u(k)\rangle\bigl(k-(k-1)\bigr)
&&\left(\because\ \blkref{def_concatenation_of_tuples}\right)\\
&=\langle u(k)\rangle(1)
&&\left(\because\ k-(k-1)=1\right)\\
&=u(k)
&&\left(\because\ \blkref{def_one_element_tuple}\right).
\end{aligned}`),
      paragraph([math(String.raw`s`), " は任意だったので、両辺は写像として等しい。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_embedded_image_of_tuple_lies_in_subalgebra_containing_image_of_embedding",
    kind: "claim",
    title: { text: "埋め込みの像を含むテンソル代数の部分代数は、組の像の埋め込みを含む" },
    labels: ["claim_embedded_image_of_tuple_lies_in_subalgebra_containing_image_of_embedding"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`\mathrm{emb}_k`), "、",
        math(String.raw`T(V)`), "、", math(String.raw`\iota`), " を ", ref("def_embedding_of_vector_space_into_tensor_algebra"),
        " のものとし、", math(String.raw`B`), " を ", math(String.raw`\iota(V)\subseteq B`), " を満たす ", math(String.raw`T(V)`),
        " の部分代数（", ref("def_subalgebra"), "）とする。このとき、すべての ", math(String.raw`k\in\mathbb{Z}_{\ge 0}`), " と ",
        math(String.raw`u\in V^{\{1,\dots,k\}}`), " について ", math(String.raw`\mathrm{emb}_k\bigl(\tau_k(u)\bigr)\in B`), " である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`k`), " についての帰納法で示す。"]),
      paragraph([
        math(String.raw`k=0`), " のとき：", math(String.raw`u=\varepsilon_V`), " なので（", ref("def_empty_tuple_of_vector_space_elements"),
        "）、", math(String.raw`\mathrm{emb}_0(\tau_0(u))=\mathrm{emb}_0(\tau_0(\varepsilon_V))=1_D=1_{T(V)}`), " であり（",
        ref("def_product_and_unit_of_tensor_algebra"), "、", ref("claim_tensor_algebra_is_complex_algebra"), "）、部分代数は乗法の単位元を含むので ",
        math(String.raw`B`), " の元である（", ref("def_subalgebra"), "）。",
      ]),
      paragraph([
        math(String.raw`k\ge 1`), " とし、", math(String.raw`V^{\{1,\dots,k-1\}}`), " のすべての組について主張が成り立つとする（帰納法の仮定）。",
        math(String.raw`u^{-}`), " を ", ref("claim_tuple_is_concatenation_of_initial_part_and_last_component"), " のものとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{emb}_k\bigl(\tau_k(u)\bigr)
&=\mathrm{emb}_k\Bigl(\tau_k\bigl(\mathrm{cat}_{k-1,1}(u^{-},\langle u(k)\rangle)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_tuple_is_concatenation_of_initial_part_and_last_component}\right)\\
&=\mathrm{emb}_k\Bigl(m_{k-1,1}\bigl(\tau_{k-1}(u^{-}),\tau_1(\langle u(k)\rangle)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\mathrm{emb}_{k-1}\bigl(\tau_{k-1}(u^{-})\bigr)\star_D\mathrm{emb}_1\bigl(\tau_1(\langle u(k)\rangle)\bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=\mathrm{emb}_{k-1}\bigl(\tau_{k-1}(u^{-})\bigr)\cdot_{T(V)}\iota\bigl(u(k)\bigr)
&&\left(\because\ \cdot_{T(V)}=\star_D\ \text{（}\blkref{claim_tensor_algebra_is_complex_algebra}\text{）と}\ \iota\ \text{の定義（}\blkref{def_embedding_of_vector_space_into_tensor_algebra}\text{）}\right).
\end{aligned}`),
      paragraph([
        "帰納法の仮定から ", math(String.raw`\mathrm{emb}_{k-1}(\tau_{k-1}(u^{-}))\in B`), "、仮定 ", math(String.raw`\iota(V)\subseteq B`),
        " から ", math(String.raw`\iota(u(k))\in B`), " であり、", math(String.raw`B`), " は乗法で閉じているので（", ref("def_subalgebra"),
        "）、", math(String.raw`\mathrm{emb}_k(\tau_k(u))\in B`), " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_image_of_embedding_generates_tensor_algebra",
    kind: "claim",
    title: { text: "埋め込みの像はテンソル代数を生成する" },
    labels: ["claim_image_of_embedding_generates_tensor_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`T(V)`), "、", math(String.raw`\iota`), " を ", ref("def_embedding_of_vector_space_into_tensor_algebra"),
        " のものとする。このとき ", math(String.raw`\iota(V)`), " は ", math(String.raw`T(V)`), " を生成する（", ref("def_subset_generates_algebra"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`b:\{1,\dots,n\}\to V`), " を ", ref("def_vector_space_of_tensor_algebra"), " の基底とする。",
        math(String.raw`B`), " を ", math(String.raw`\iota(V)\subseteq B`), " を満たす ", math(String.raw`T(V)`), " の部分代数とし、",
        math(String.raw`x\in D`), " を任意に取る。", math(String.raw`N`), " を ", math(String.raw`x`), " の零の境、",
        math(String.raw`I:=\{0,\dots,N\}`), " とすると ", math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)`),
        " である（", ref("claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"), "）。",
      ]),
      paragraph([
        math(String.raw`i\in I`), " を任意に取る。", math(String.raw`X_i:=X_{n,i}`), " は有限集合であり（",
        ref("claim_base_n_numbering_is_numbering_of_maps"), "）、", math(String.raw`\xi\in X_i`), " について ",
        math(String.raw`b\circ\xi\in V^{\{1,\dots,i\}}`), " を ", ref("claim_coordinate_product_map_at_basis_tuples_is_kronecker_delta"),
        " のものとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{emb}_i(x_i)
&=\mathrm{emb}_i\left(\sum_{\xi\in X_i}x_i(\xi)\cdot_{T_i}\tau_i(b\circ\xi)\right)
&&\left(\because\ T_i=V^{\otimes_b i}\ \text{と}\ \blkref{claim_coordinate_tensor_space_element_is_sum_of_basis_tensors}\right)\\
&=\sum_{\xi\in X_i}x_i(\xi)\cdot_D\mathrm{emb}_i\bigl(\tau_i(b\circ\xi)\bigr)
&&\left(\because\ \mathrm{emb}_i\ \text{は線型写像（}\blkref{claim_embedding_into_component_of_direct_sum_of_family_is_linear_map}\text{）。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right).
\end{aligned}`),
      paragraph([
        "各 ", math(String.raw`\mathrm{emb}_i(\tau_i(b\circ\xi))`), " は ", math(String.raw`B`), " の元であり（",
        ref("claim_embedded_image_of_tuple_lies_in_subalgebra_containing_image_of_embedding"), "）、", math(String.raw`\cdot_D=\ast_{T(V)}`),
        " なので（", ref("claim_tensor_algebra_is_complex_algebra"), "）、", ref("claim_subalgebra_is_closed_under_sums_over_finite_sets"),
        " により ", math(String.raw`\mathrm{emb}_i(x_i)\in B`), " である。もう一度 ", ref("claim_subalgebra_is_closed_under_sums_over_finite_sets"),
        " を当てると ", math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D\mathrm{emb}_i(x_i)\in B`), " である。",
        math(String.raw`x`), " は任意だったので ", math(String.raw`D\subseteq B`), " であり、", math(String.raw`B\subseteq D`),
        " と合わせて ", math(String.raw`B=D`), " である。したがって ", math(String.raw`\iota(V)`), " は ", math(String.raw`T(V)`),
        " を生成する（", ref("def_subset_generates_algebra"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_left_multiplication_in_algebra_is_linear_map",
    kind: "claim",
    title: { text: "代数の固定した元を左から掛ける写像は線型写像である" },
    labels: ["claim_left_multiplication_in_algebra_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`a\in A`),
        " とする。写像 ", math(String.raw`a\cdot_A\bullet:A\to A`), " を ", math(String.raw`x\mapsto a\cdot_A x`), " で定める。このとき ",
        math(String.raw`a\cdot_A\bullet`), " は ", math(String.raw`U_{\mathrm{vec}}(A)`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`),
        " への線型写像（", ref("def_linear_map"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"), "）である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`x,y\in A`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
        math(String.raw`a\cdot_A(x+_A y)=a\cdot_A x+_A a\cdot_A y`), " は ", math(String.raw`U_{\mathrm{ring}}(A)`), " の分配法則（",
        ref("def_unital_ring"), "）であり、", math(String.raw`a\cdot_A(\lambda\ast_A x)=\lambda\ast_A(a\cdot_A x)`),
        " はスカラー倍と乗法の両立の右の因子の条件（", ref("def_complex_algebra"), "）である。二つの条件が満たされたので線型写像である（",
        ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_right_multiplication_in_algebra_is_linear_map",
    kind: "claim",
    title: { text: "代数の固定した元を右から掛ける写像は線型写像である" },
    labels: ["claim_right_multiplication_in_algebra_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`a\in A`),
        " とする。写像 ", math(String.raw`\bullet\cdot_A a:A\to A`), " を ", math(String.raw`x\mapsto x\cdot_A a`), " で定める。このとき ",
        math(String.raw`\bullet\cdot_A a`), " は ", math(String.raw`U_{\mathrm{vec}}(A)`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`),
        " への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`x,y\in A`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
        math(String.raw`(x+_A y)\cdot_A a=x\cdot_A a+_A y\cdot_A a`), " は ", math(String.raw`U_{\mathrm{ring}}(A)`), " の分配法則（",
        ref("def_unital_ring"), "）であり、", math(String.raw`(\lambda\ast_A x)\cdot_A a=\lambda\ast_A(x\cdot_A a)`),
        " はスカラー倍と乗法の両立の左の因子の条件（", ref("def_complex_algebra"), "）である。二つの条件が満たされたので線型写像である（",
        ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_anticommutator_with_linear_combination_in_algebra",
    kind: "claim",
    title: { text: "代数の中の線型結合と一つの元の反交換子は、項ごとの反交換子の線型結合である" },
    labels: ["claim_anticommutator_with_linear_combination_in_algebra"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`a\in A`), "、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`), " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`l`), " に ", math(String.raw`A`),
        " の元 ", math(String.raw`r_l`), " と ", math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\mu_l`), " が一つずつ与えられているとする。",
        math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（", ref("def_linear_combination"),
        "）を ", math(String.raw`R:=\sum_{l=1}^{n}\mu_l\ast_A r_l`), " と置く。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`R\cdot_A a+_A a\cdot_A R=\sum_{l=1}^{n}\mu_l\ast_A\bigl(r_l\cdot_A a+_A a\cdot_A r_l\bigr)`),
    ],
    proof: [
      paragraph([
        "写像 ", math(String.raw`\bullet\cdot_A a`), " と ", math(String.raw`a\cdot_A\bullet`), " は ", math(String.raw`U_{\mathrm{vec}}(A)`), " から ",
        math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像である（", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_left_multiplication_in_algebra_is_linear_map"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
R\cdot_A a+_A a\cdot_A R
&=\left(\sum_{l=1}^{n}\mu_l\ast_A(r_l\cdot_A a)\right)+_A a\cdot_A R
&&\left(\because\ f:=\bullet\cdot_A a\ \text{に当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\left(\sum_{l=1}^{n}\mu_l\ast_A(r_l\cdot_A a)\right)+_A\left(\sum_{l=1}^{n}\mu_l\ast_A(a\cdot_A r_l)\right)
&&\left(\because\ f:=a\cdot_A\bullet\ \text{に当てる。}\blkref{claim_linear_map_maps_linear_combination_to_linear_combination_of_values}\right)\\
&=\sum_{l=1}^{n}\mu_l\ast_A\bigl(r_l\cdot_A a+_A a\cdot_A r_l\bigr)
&&\left(\because\ x_l:=r_l\cdot_A a\text{、}y_l:=a\cdot_A r_l\text{。}\blkref{claim_sum_of_linear_combinations_with_same_coefficients}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_square_of_linear_combination_of_anticommuting_square_zero_elements",
    kind: "claim",
    title: { text: "平方が零で互いに反交換する代数の元の線型結合は、平方が零である" },
    labels: ["claim_square_of_linear_combination_of_anticommuting_square_zero_elements_is_zero"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " とし、", math(String.raw`\{1,\dots,n\}`), " の各元 ", math(String.raw`k`), " に ", math(String.raw`A`), " の元 ", math(String.raw`p_k`), " と ",
        math(String.raw`\mathbb{C}`), " の元 ", math(String.raw`\lambda_k`), " が一つずつ与えられているとする。", math(String.raw`p`), " は次の二つを満たすとする。",
      ]),
      list([
        ["すべての ", math(String.raw`k\in\{1,\dots,n\}`), " について ", math(String.raw`p_k\cdot_A p_k=0_A`), "。"],
        [
          math(String.raw`k\neq l`), " であるすべての ", math(String.raw`k,l\in\{1,\dots,n\}`), " について ",
          math(String.raw`p_k\cdot_A p_l+_A p_l\cdot_A p_k=0_A`), "。",
        ],
      ]),
      paragraph([
        "このとき、", math(String.raw`U_{\mathrm{vec}}(A)`), "（", ref("def_underlying_ring_and_vector_space_of_algebra"), "）の中の線型結合（",
        ref("def_linear_combination"), "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\left(\sum_{k=1}^{n}\lambda_k\ast_A p_k\right)\cdot_A\left(\sum_{k=1}^{n}\lambda_k\ast_A p_k\right)=0_A`),
    ],
    proof: [
      paragraph([
        math(String.raw`L_m`), "（", math(String.raw`m\in\{0,1,\dots,n\}`), "）を線型結合の定義（", ref("def_linear_combination"),
        "）の部分和とする（", math(String.raw`L_0=0_A`), "、", math(String.raw`L_m=L_{m-1}+_A(\lambda_m\ast_A p_m)`), "）。部分和の式は番号 ",
        math(String.raw`m`), " までの項だけで定まるので、", math(String.raw`L_m`), " は、族を ", math(String.raw`\{1,\dots,m\}`), " に制限した線型結合 ",
        math(String.raw`\sum_{k=1}^{m}\lambda_k\ast_A p_k`), " と同じ元である。すべての ", math(String.raw`m`), " について ", math(String.raw`L_m\cdot_A L_m=0_A`),
        " であることを ", math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m=n`), " の場合が主張である。",
      ]),
      paragraph([
        "準備。", math(String.raw`1\le m\le n`), " とし、", math(String.raw`e:=\lambda_m\ast_A p_m\in A`), " と置く。", math(String.raw`k\in\{1,\dots,m-1\}`),
        " については ", math(String.raw`k\neq m`), " なので、次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lambda_k\ast_A\bigl(p_k\cdot_A e+_A e\cdot_A p_k\bigr)
&=\lambda_k\ast_A\bigl(p_k\cdot_A(\lambda_m\ast_A p_m)+_A(\lambda_m\ast_A p_m)\cdot_A p_k\bigr)
&&\left(\because\ e\ \text{の置き方}\right)\\
&=\lambda_k\ast_A\Bigl(\lambda_m\ast_A(p_k\cdot_A p_m)+_A(\lambda_m\ast_A p_m)\cdot_A p_k\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda_k\ast_A\Bigl(\lambda_m\ast_A(p_k\cdot_A p_m)+_A\lambda_m\ast_A(p_m\cdot_A p_k)\Bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda_k\ast_A\Bigl(\lambda_m\ast_A\bigl(p_k\cdot_A p_m+_A p_m\cdot_A p_k\bigr)\Bigr)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のベクトルの加法についての分配法則。}\blkref{def_complex_vector_space}\right)\\
&=\lambda_k\ast_A(\lambda_m\ast_A 0_A)
&&\left(\because\ \text{二つ目の仮定。}k\neq m\right)\\
&=\lambda_k\ast_A 0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
      paragraph(["したがって次が成り立つ（", math(String.raw`\star`), "）。"]),
      displayMath(String.raw`\begin{aligned}
L_{m-1}\cdot_A e+_A e\cdot_A L_{m-1}
&=\sum_{k=1}^{m-1}\lambda_k\ast_A\bigl(p_k\cdot_A e+_A e\cdot_A p_k\bigr)
&&\left(\because\ n:=m-1\text{、}r:=p\text{、}\mu:=\lambda\text{、}a:=e\text{。}\blkref{claim_anticommutator_with_linear_combination_in_algebra}\right)\\
&=0_A
&&\left(\because\ \text{上の等式で各項が}\ 0_A\text{。}\blkref{claim_linear_combination_of_zero_terms_is_zero}\right).
\end{aligned}`),
      paragraph([
        "本題。", math(String.raw`m=0`), " のとき、", math(String.raw`L_0\cdot_A L_0=0_A\cdot_A 0_A=0_A`), " である（", math(String.raw`L_0=0_A`),
        "。写像 ", math(String.raw`0_A\cdot_A\bullet`), " は線型写像なので零を零へ移す。", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_linear_map_sends_zero_to_zero"), "）。", math(String.raw`1\le m\le n`), " とし、", math(String.raw`L_{m-1}\cdot_A L_{m-1}=0_A`),
        " を仮定する（帰納法の仮定）。", math(String.raw`e`), " は準備のものとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
L_m\cdot_A L_m
&=\bigl(L_{m-1}+_A e\bigr)\cdot_A\bigl(L_{m-1}+_A e\bigr)
&&\left(\because\ L_m\ \text{の定義。}\blkref{def_linear_combination}\right)\\
&=L_{m-1}\cdot_A\bigl(L_{m-1}+_A e\bigr)+_A e\cdot_A\bigl(L_{m-1}+_A e\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（左の因子の和）。}\blkref{def_unital_ring}\right)\\
&=\bigl(L_{m-1}\cdot_A L_{m-1}+_A L_{m-1}\cdot_A e\bigr)+_A\bigl(e\cdot_A L_{m-1}+_A e\cdot_A e\bigr)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則（右の因子の和）を二か所に適用。}\blkref{def_unital_ring}\right)\\
&=\bigl(0_A+_A L_{m-1}\cdot_A e\bigr)+_A\bigl(e\cdot_A L_{m-1}+_A e\cdot_A e\bigr)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\bigl(L_{m-1}\cdot_A e+_A 0_A\bigr)+_A\bigl(e\cdot_A L_{m-1}+_A e\cdot_A e\bigr)
&&\left(\because\ \text{加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=L_{m-1}\cdot_A e+_A\bigl(e\cdot_A L_{m-1}+_A e\cdot_A e\bigr)
&&\left(\because\ \text{加法の単位元。}\blkref{def_unital_ring}\right)\\
&=\bigl(L_{m-1}\cdot_A e+_A e\cdot_A L_{m-1}\bigr)+_A e\cdot_A e
&&\left(\because\ \text{加法の結合法則。}\blkref{def_unital_ring}\right)\\
&=0_A+_A e\cdot_A e
&&\left(\because\ (\star)\right)\\
&=e\cdot_A e+_A 0_A
&&\left(\because\ \text{加法の交換法則。}\blkref{def_unital_ring}\right)\\
&=e\cdot_A e
&&\left(\because\ \text{加法の単位元。}\blkref{def_unital_ring}\right)\\
&=(\lambda_m\ast_A p_m)\cdot_A(\lambda_m\ast_A p_m)
&&\left(\because\ e\ \text{の置き方}\right)\\
&=\lambda_m\ast_A\bigl(p_m\cdot_A(\lambda_m\ast_A p_m)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda_m\ast_A\bigl(\lambda_m\ast_A(p_m\cdot_A p_m)\bigr)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda_m\ast_A(\lambda_m\ast_A 0_A)
&&\left(\because\ \text{一つ目の仮定}\right)\\
&=\lambda_m\ast_A 0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right)\\
&=0_A
&&\left(\because\ \blkref{claim_scalar_multiple_of_zero_vector_is_zero_vector}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_in_algebra_is_additive_in_one_factor",
    kind: "claim",
    title: { text: "代数の中の番号順の積は、一つの因子についての和を積の和へ移す" },
    labels: ["claim_ordered_product_in_algebra_is_additive_in_one_factor"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、",
        math(String.raw`k\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`r\in\{1,\dots,k\}`), " とし、", math(String.raw`\{1,\dots,k\}`),
        " の各元 ", math(String.raw`s`), " に ", math(String.raw`A`), " の元 ", math(String.raw`w_s,\ w'_s,\ w''_s`),
        " が一つずつ与えられていて、", math(String.raw`s\neq r`), " なら ", math(String.raw`w_s=w'_s=w''_s`), "、",
        math(String.raw`w_r=w'_r+_A w''_r`), " であるとする。このとき、代数の中の番号順の積（", ref("def_ordered_product_in_algebra"),
        "）について次が成り立つ。",
      ]),
      displayMath(String.raw`\prod_{A,\,s=1}^{k}w_s=\left(\prod_{A,\,s=1}^{k}w'_s\right)+_A\left(\prod_{A,\,s=1}^{k}w''_s\right)`),
    ],
    proof: [
      paragraph([
        "三つの族の部分積を ", math(String.raw`\Pi_m,\ \Pi'_m,\ \Pi''_m`), "（", math(String.raw`m\in\{0,\dots,k\}`), "）と書く（",
        ref("def_ordered_product_in_algebra"), "）。", math(String.raw`m`), " の帰納法で、", math(String.raw`m<r`), " なら ",
        math(String.raw`\Pi_m=\Pi'_m=\Pi''_m`), "、", math(String.raw`m\ge r`), " なら ", math(String.raw`\Pi_m=\Pi'_m+_A\Pi''_m`),
        " であることを示す。", math(String.raw`m=0`), " のとき ", math(String.raw`0<r`), " であり、",
        math(String.raw`\Pi_0=1_A=\Pi'_0=\Pi''_0`), " である。", math(String.raw`1\le m\le k`), " とし、", math(String.raw`m-1`),
        " について主張が成り立つとする（帰納法の仮定）。",
      ]),
      paragraph([
        math(String.raw`m<r`), " のとき、", math(String.raw`m-1<r`), " なので帰納法の仮定から ",
        math(String.raw`\Pi_{m-1}=\Pi'_{m-1}=\Pi''_{m-1}`), " であり、", math(String.raw`m\neq r`), " なので ",
        math(String.raw`w_m=w'_m=w''_m`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A w_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi'_{m-1}\cdot_A w_m
&&\left(\because\ \text{帰納法の仮定}\ \Pi_{m-1}=\Pi'_{m-1}\right)\\
&=\Pi'_{m-1}\cdot_A w'_m
&&\left(\because\ w_m=w'_m\right)\\
&=\Pi'_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A w_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi''_{m-1}\cdot_A w_m
&&\left(\because\ \text{帰納法の仮定}\ \Pi_{m-1}=\Pi''_{m-1}\right)\\
&=\Pi''_{m-1}\cdot_A w''_m
&&\left(\because\ w_m=w''_m\right)\\
&=\Pi''_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`m=r`), " のとき、", math(String.raw`r-1<r`), " なので帰納法の仮定から ",
        math(String.raw`\Pi_{r-1}=\Pi'_{r-1}=\Pi''_{r-1}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_r
&=\Pi_{r-1}\cdot_A w_r
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{r-1}\cdot_A(w'_r+_A w''_r)
&&\left(\because\ w_r=w'_r+_A w''_r\right)\\
&=\Pi_{r-1}\cdot_A w'_r+_A\Pi_{r-1}\cdot_A w''_r
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\Pi'_{r-1}\cdot_A w'_r+_A\Pi''_{r-1}\cdot_A w''_r
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\Pi'_r+_A\Pi''_r
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph([math(String.raw`m>r`), " のとき、", math(String.raw`m-1\ge r`), " かつ ", math(String.raw`m\neq r`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A w_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=(\Pi'_{m-1}+_A\Pi''_{m-1})\cdot_A w_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\Pi'_{m-1}\cdot_A w_m+_A\Pi''_{m-1}\cdot_A w_m
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の分配法則。}\blkref{def_unital_ring}\right)\\
&=\Pi'_{m-1}\cdot_A w'_m+_A\Pi''_{m-1}\cdot_A w''_m
&&\left(\because\ w_m=w'_m=w''_m\right)\\
&=\Pi'_m+_A\Pi''_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph([math(String.raw`r\le k`), " なので、", math(String.raw`m=k`), " のときが主張である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_in_algebra_is_homogeneous_in_one_factor",
    kind: "claim",
    title: { text: "代数の中の番号順の積は、一つの因子のスカラー倍を積のスカラー倍へ移す" },
    labels: ["claim_ordered_product_in_algebra_is_homogeneous_in_one_factor"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、",
        math(String.raw`k\in\mathbb{Z}_{\ge 1}`), "、", math(String.raw`r\in\{1,\dots,k\}`), "、", math(String.raw`\lambda\in\mathbb{C}`),
        " とし、", math(String.raw`\{1,\dots,k\}`), " の各元 ", math(String.raw`s`), " に ", math(String.raw`A`), " の元 ",
        math(String.raw`w_s,\ w'_s`), " が一つずつ与えられていて、", math(String.raw`s\neq r`), " なら ", math(String.raw`w_s=w'_s`), "、",
        math(String.raw`w_r=\lambda\ast_A w'_r`), " であるとする。このとき次が成り立つ（", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      displayMath(String.raw`\prod_{A,\,s=1}^{k}w_s=\lambda\ast_A\prod_{A,\,s=1}^{k}w'_s`),
    ],
    proof: [
      paragraph([
        "二つの族の部分積を ", math(String.raw`\Pi_m,\ \Pi'_m`), " と書く（", ref("def_ordered_product_in_algebra"), "）。",
        math(String.raw`m`), " の帰納法で、", math(String.raw`m<r`), " なら ", math(String.raw`\Pi_m=\Pi'_m`), "、",
        math(String.raw`m\ge r`), " なら ", math(String.raw`\Pi_m=\lambda\ast_A\Pi'_m`), " であることを示す。",
        math(String.raw`m=0`), " のとき ", math(String.raw`\Pi_0=1_A=\Pi'_0`), " である。", math(String.raw`1\le m\le k`),
        " とし、", math(String.raw`m-1`), " について主張が成り立つとする（帰納法の仮定）。", math(String.raw`m<r`), " のとき、",
        math(String.raw`m-1<r`), " なので ", math(String.raw`\Pi_{m-1}=\Pi'_{m-1}`), " であり、", math(String.raw`m\neq r`), " なので ",
        math(String.raw`w_m=w'_m`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A w_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi'_{m-1}\cdot_A w_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\Pi'_{m-1}\cdot_A w'_m
&&\left(\because\ w_m=w'_m\right)\\
&=\Pi'_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`m=r`), " のとき、帰納法の仮定から ", math(String.raw`\Pi_{r-1}=\Pi'_{r-1}`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_r
&=\Pi_{r-1}\cdot_A w_r
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\Pi_{r-1}\cdot_A(\lambda\ast_A w'_r)
&&\left(\because\ w_r=\lambda\ast_A w'_r\right)\\
&=\lambda\ast_A(\Pi_{r-1}\cdot_A w'_r)
&&\left(\because\ \text{スカラー倍と乗法の両立、右の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda\ast_A(\Pi'_{r-1}\cdot_A w'_r)
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=\lambda\ast_A\Pi'_r
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`m>r`), " のとき、", math(String.raw`m-1\ge r`), " かつ ", math(String.raw`m\neq r`), " である。"]),
      displayMath(String.raw`\begin{aligned}
\Pi_m
&=\Pi_{m-1}\cdot_A w_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=(\lambda\ast_A\Pi'_{m-1})\cdot_A w_m
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=(\lambda\ast_A\Pi'_{m-1})\cdot_A w'_m
&&\left(\because\ w_m=w'_m\right)\\
&=\lambda\ast_A(\Pi'_{m-1}\cdot_A w'_m)
&&\left(\because\ \text{スカラー倍と乗法の両立、左の因子。}\blkref{def_complex_algebra}\right)\\
&=\lambda\ast_A\Pi'_m
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`m=k`), " のときが主張である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_in_algebra_splits_into_first_and_last_factors",
    kind: "claim",
    title: { text: "代数の中の番号順の積は、前の k 個の積と後ろの l 個の積の積である" },
    labels: ["claim_ordered_product_in_algebra_splits_into_first_and_last_factors"],
    statement: [
      paragraph([
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、",
        math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`), " とし、", math(String.raw`\{1,\dots,k+l\}`), " の各元 ", math(String.raw`s`),
        " に ", math(String.raw`A`), " の元 ", math(String.raw`w_s`), " が一つずつ与えられているとする。このとき、代数の中の番号順の積（",
        ref("def_ordered_product_in_algebra"), "）について次が成り立つ。右辺の後ろの積は、", math(String.raw`t\in\{1,\dots,l\}`),
        " に ", math(String.raw`w_{k+t}`), " を与える族の積である。",
      ]),
      displayMath(String.raw`\prod_{A,\,s=1}^{k+l}w_s=\left(\prod_{A,\,s=1}^{k}w_s\right)\cdot_A\left(\prod_{A,\,t=1}^{l}w_{k+t}\right)`),
    ],
    proof: [
      paragraph([
        math(String.raw`P:=\prod_{A,\,s=1}^{k}w_s`), " と置き、", math(String.raw`j\in\{0,\dots,l\}`), " について ",
        math(String.raw`\prod_{A,\,s=1}^{k+j}w_s=P\cdot_A\prod_{A,\,t=1}^{j}w_{k+t}`), " を ", math(String.raw`j`),
        " の帰納法で示す（左辺は族 ", math(String.raw`w`), " の部分積、右辺の積は族 ", math(String.raw`t\mapsto w_{k+t}`),
        " の部分積である。", ref("def_ordered_product_in_algebra"), "）。",
      ]),
      paragraph([math(String.raw`j=0`), " のとき："]),
      displayMath(String.raw`\begin{aligned}
\prod_{A,\,s=1}^{k}w_s
&=P
&&\left(\because\ P\ \text{の定義}\right)\\
&=P\cdot_A 1_A
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right)\\
&=P\cdot_A\prod_{A,\,t=1}^{0}w_{k+t}
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`1\le j\le l`), " とし、", math(String.raw`j-1`), " で成り立つとする（帰納法の仮定）。"]),
      displayMath(String.raw`\begin{aligned}
\prod_{A,\,s=1}^{k+j}w_s
&=\left(\prod_{A,\,s=1}^{k+j-1}w_s\right)\cdot_A w_{k+j}
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right)\\
&=\left(P\cdot_A\prod_{A,\,t=1}^{j-1}w_{k+t}\right)\cdot_A w_{k+j}
&&\left(\because\ \text{帰納法の仮定}\right)\\
&=P\cdot_A\left(\left(\prod_{A,\,t=1}^{j-1}w_{k+t}\right)\cdot_A w_{k+j}\right)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の結合法則。}\blkref{def_unital_ring}\right)\\
&=P\cdot_A\prod_{A,\,t=1}^{j}w_{k+t}
&&\left(\because\ \blkref{def_ordered_product_in_algebra}\right).
\end{aligned}`),
      paragraph([math(String.raw`j=l`), " のときが主張である。"]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_ordered_product_of_values_of_linear_map_on_tuple",
    kind: "definition",
    title: { text: "組の成分の線型写像による値の、代数の中の番号順の積" },
    labels: ["def_ordered_product_of_values_of_linear_map_on_tuple"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、",
        math(String.raw`f:V\to A`), " を ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像（",
        ref("def_linear_map"), "、", ref("def_underlying_ring_and_vector_space_of_algebra"), "）、", math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " とする。写像 ", math(String.raw`\mu^f_k:V^{\{1,\dots,k\}}\to A`), " を、代数の中の番号順の積（", ref("def_ordered_product_in_algebra"),
        "）で次のように定める。",
      ]),
      displayMath(String.raw`\mu^f_k(u):=\prod_{A,\,s=1}^{k}f\bigl(u(s)\bigr)\qquad\bigl(u\in V^{\{1,\dots,k\}}\bigr)`),
      paragraph([math(String.raw`k=0`), " のとき ", math(String.raw`\mu^f_0(\varepsilon_V)=1_A`), " である（",
        ref("def_empty_tuple_of_vector_space_elements"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear",
    kind: "claim",
    title: { text: "組の成分の線型写像による値の番号順の積は k 重線型写像である" },
    labels: ["claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`A`), "、", math(String.raw`f`), "、", math(String.raw`k`), "、", math(String.raw`\mu^f_k`), " を ",
        ref("def_ordered_product_of_values_of_linear_map_on_tuple"), " のものとする。このとき ", math(String.raw`\mu^f_k`), " は ",
        math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への ", math(String.raw`k`), " 重線型写像（",
        ref("def_k_multilinear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u\in V^{\{1,\dots,k\}}`), "、", math(String.raw`r\in\{1,\dots,k\}`), "、", math(String.raw`x,y\in V`), "、",
        math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る（", math(String.raw`k=0`), " のときは条件が無い）。",
        math(String.raw`s\in\{1,\dots,k\}`), " について ", math(String.raw`w_s:=f\bigl(u[r\mapsto x+_V y](s)\bigr)`), "、",
        math(String.raw`w'_s:=f\bigl(u[r\mapsto x](s)\bigr)`), "、", math(String.raw`w''_s:=f\bigl(u[r\mapsto y](s)\bigr)`), "、",
        math(String.raw`w'''_s:=f\bigl(u[r\mapsto\lambda\cdot_V x](s)\bigr)`), " と置く。", ref("def_tuple_with_one_component_replaced"),
        " から、", math(String.raw`s\neq r`), " ならどれも ", math(String.raw`f(u(s))`), " に等しく、", math(String.raw`s=r`), " では ",
        math(String.raw`w_r=f(x+_V y)=f(x)+_A f(y)=w'_r+_A w''_r`), "、", math(String.raw`w'''_r=f(\lambda\cdot_V x)=\lambda\ast_A f(x)=\lambda\ast_A w'_r`),
        " である（", math(String.raw`f`), " は線型写像。", ref("def_linear_map"), "）。",
        ref("claim_ordered_product_in_algebra_is_additive_in_one_factor"), " から ",
        math(String.raw`\mu^f_k(u[r\mapsto x+_V y])=\mu^f_k(u[r\mapsto x])+_A\mu^f_k(u[r\mapsto y])`), "、",
        ref("claim_ordered_product_in_algebra_is_homogeneous_in_one_factor"), " から ",
        math(String.raw`\mu^f_k(u[r\mapsto\lambda\cdot_V x])=\lambda\ast_A\mu^f_k(u[r\mapsto x])`), " である（",
        ref("def_ordered_product_of_values_of_linear_map_on_tuple"), "）。二つの条件が満たされたので ", math(String.raw`k`),
        " 重線型写像である（", ref("def_k_multilinear_map"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_map_from_tensor_algebra_extending_linear_map",
    kind: "definition",
    title: { text: "線型写像がテンソル代数の上に定める写像" },
    labels: ["def_map_from_tensor_algebra_extending_linear_map"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`(T_j,\tau_j)_{j\in\mathbb{Z}_{\ge 0}}`), "、", math(String.raw`D`), " を ",
        ref("def_vector_space_of_tensor_algebra"), " のもの、", math(String.raw`A`), "、", math(String.raw`f`), "、", math(String.raw`\mu^f_k`),
        " を ", ref("def_ordered_product_of_values_of_linear_map_on_tuple"), " のものとする。各 ", math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について、", math(String.raw`\mu^f_k`), " は ", math(String.raw`k`), " 重線型写像なので（",
        ref("claim_ordered_product_of_values_of_linear_map_on_tuple_is_multilinear"), "）、", math(String.raw`(T_k,\tau_k)`),
        " の普遍性（", ref("def_k_fold_tensor_product"), "）を ", math(String.raw`U=U_{\mathrm{vec}}(A)`), "、", math(String.raw`h=\mu^f_k`),
        " に当てると、線型写像 ", math(String.raw`T_k\to U_{\mathrm{vec}}(A)`), " で、すべての ", math(String.raw`u\in V^{\{1,\dots,k\}}`),
        " について次を満たすものがただ一つ存在する。これを ", math(String.raw`F_k:T_k\to A`), " と書く。",
      ]),
      displayMath(String.raw`F_k\bigl(\tau_k(u)\bigr)=\mu^f_k(u)`),
      paragraph([
        "写像 ", math(String.raw`F:D\to A`), " を、", math(String.raw`x\in D`), " と ", math(String.raw`x`), " の零の境 ",
        math(String.raw`N`), "（", ref("def_direct_sum_of_family_of_vector_spaces"), "）について、", math(String.raw`U_{\mathrm{vec}}(A)`),
        " の中の有限集合の上の和（", ref("def_sum_over_finite_set"), "、", ref("claim_numbering_of_initial_segment_from_zero"), "）で次のように定める。",
      ]),
      displayMath(String.raw`F(x):=\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\ast_A F_i(x_i)`),
      paragraph([
        "（零の境の取り方によらないこと）", math(String.raw`N\le N'`), " を ", math(String.raw`x`), " の二つの零の境とする（二つの零の境は大小のどちらかなので、この場合だけ示せばよい）。",
        math(String.raw`d:=N'-N`), " と置き、", math(String.raw`\{0,\dots,N\}`), "・", math(String.raw`\{0,\dots,N'\}`), " の番号付けを ",
        ref("claim_numbering_of_initial_segment_from_zero"), " の ", math(String.raw`e(s)=s-1`), " で取り、", math(String.raw`s\in\{1,\dots,N'+1\}`),
        " について ", math(String.raw`g_s:=F_{s-1}(x_{s-1})`), " と置く。", math(String.raw`t\in\{1,\dots,d\}`), " について ",
        math(String.raw`N+t>N`), " なので ", math(String.raw`x_{N+t}=0_{T_{N+t}}`), " であり、", math(String.raw`F_{N+t}`),
        " は線型写像なので ", math(String.raw`1_{\mathbb{C}}\ast_A g_{N+1+t}=1_{\mathbb{C}}\ast_A F_{N+t}(0_{T_{N+t}})=1_{\mathbb{C}}\ast_A 0_A=0_A`),
        " である（", ref("claim_linear_map_sends_zero_to_zero"), "、", ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "）。",
        math(String.raw`(d,\mathrm{id})`), " は ", math(String.raw`\{1,\dots,d\}`), " の番号付けである（", ref("def_numbering_of_finite_set"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{i\in\{0,\dots,N'\}}1_{\mathbb{C}}\ast_A F_i(x_i)
&=\sum_{s=1}^{N'+1}1_{\mathbb{C}}\ast_A g_s
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (N'+1,e)\ \text{で}\right)\\
&=\left(\sum_{s=1}^{N+1}1_{\mathbb{C}}\ast_A g_s\right)+_A\left(\sum_{t=1}^{d}1_{\mathbb{C}}\ast_A g_{N+1+t}\right)
&&\left(\because\ \blkref{claim_splitting_linear_combination_into_first_and_last_terms}\ \text{を}\ n=N+1,\ n'=d\ \text{で}\right)\\
&=\left(\sum_{s=1}^{N+1}1_{\mathbb{C}}\ast_A g_s\right)+_A 0_A
&&\left(\because\ \text{番号付け}\ (d,\mathrm{id})\ \text{の}\ \blkref{def_sum_over_finite_set}\ \text{と}\ \blkref{claim_sum_over_finite_set_of_zero_terms_is_zero}\right)\\
&=\sum_{s=1}^{N+1}1_{\mathbb{C}}\ast_A g_s
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{の加法の単位元。}\blkref{def_complex_vector_space}\right)\\
&=\sum_{i\in\{0,\dots,N\}}1_{\mathbb{C}}\ast_A F_i(x_i)
&&\left(\because\ \blkref{def_sum_over_finite_set}\ \text{を番号付け}\ (N+1,e)\ \text{で}\right).
\end{aligned}`),
      paragraph([
        "したがって ", math(String.raw`F(x)`), " は零の境の取り方によらず ", math(String.raw`A`), " の元として一つに決まる。",
        math(String.raw`x`), " の零の境 ", math(String.raw`N`), " より大きい ", math(String.raw`N'`), " も零の境の条件を満たすので（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）、", math(String.raw`F(x)`), " は ", math(String.raw`x`),
        " の零の境以上の任意の ", math(String.raw`N'`), " で計算してよい。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_tensor_algebra_extending_linear_map_is_linear_map",
    kind: "claim",
    title: { text: "線型写像がテンソル代数の上に定める写像は線型写像である" },
    labels: ["claim_map_from_tensor_algebra_extending_linear_map_is_linear_map"],
    statement: [
      paragraph([
        math(String.raw`D`), "、", math(String.raw`A`), "、", math(String.raw`F`), " を ", ref("def_map_from_tensor_algebra_extending_linear_map"),
        " のものとする。このとき ", math(String.raw`F`), " は ", math(String.raw`(D,+_D,\cdot_D,0_D)`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`),
        " への線型写像（", ref("def_linear_map"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x,y\in D`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取り、", math(String.raw`N`), " を ",
        math(String.raw`x`), " の零の境と ", math(String.raw`y`), " の零の境の大きい方、", math(String.raw`I:=\{0,\dots,N\}`), " とする。",
        math(String.raw`N`), " は ", math(String.raw`x`), " と ", math(String.raw`y`), " の零の境の条件を満たし、", math(String.raw`j>N`),
        " なら ", math(String.raw`(x+_D y)_j=0_{T_j}+_{T_j}0_{T_j}=0_{T_j}`), "、", math(String.raw`(\lambda\cdot_D x)_j=\lambda\cdot_{T_j}0_{T_j}=0_{T_j}`),
        " なので（", ref("def_operations_on_direct_sum_of_family_of_vector_spaces"), "、", ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"),
        "）、", math(String.raw`x+_D y`), " と ", math(String.raw`\lambda\cdot_D x`), " の零の境の条件も満たす（",
        ref("def_direct_sum_of_family_of_vector_spaces"), "）。各 ", math(String.raw`F_i`), " は線型写像なので、",
        math(String.raw`F_i(x_i+_{T_i}y_i)=F_i(x_i)+_A F_i(y_i)`), "、", math(String.raw`F_i(\lambda\cdot_{T_i}x_i)=\lambda\ast_A F_i(x_i)`),
        " である（", ref("def_map_from_tensor_algebra_extending_linear_map"), "、", ref("def_linear_map"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(x+_D y)
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i\bigl((x+_D y)_i\bigr)
&&\left(\because\ F\ \text{の定義。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i(x_i+_{T_i}y_i)
&&\left(\because\ +_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A\bigl(F_i(x_i)+_A F_i(y_i)\bigr)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i(x_i)+_A\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i(y_i)
&&\left(\because\ \blkref{claim_sum_of_sums_over_finite_set_with_same_coefficients}\right)\\
&=F(x)+_A F(y)
&&\left(\because\ F\ \text{の定義を二か所に適用。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
F(\lambda\cdot_D x)
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i\bigl((\lambda\cdot_D x)_i\bigr)
&&\left(\because\ F\ \text{の定義。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i(\lambda\cdot_{T_i}x_i)
&&\left(\because\ \cdot_D\ \text{の定義と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A\bigl(\lambda\ast_A F_i(x_i)\bigr)
&&\left(\because\ \text{上の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in I}(1_{\mathbb{C}}\cdot_{\mathbb{C}}\lambda)\ast_A F_i(x_i)
&&\left(\because\ U_{\mathrm{vec}}(A)\ \text{のスカラー倍の結合法則（}\blkref{def_complex_vector_space}\text{）と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\sum_{i\in I}(\lambda\cdot_{\mathbb{C}}1_{\mathbb{C}})\ast_A F_i(x_i)
&&\left(\because\ \mathbb{C}\ \text{の乗法の交換法則}\right)\\
&=\lambda\ast_A\sum_{i\in I}1_{\mathbb{C}}\ast_A F_i(x_i)
&&\left(\because\ \blkref{claim_scalar_multiple_of_sum_over_finite_set}\ \text{を}\ \rho=\lambda\ \text{で}\right)\\
&=\lambda\ast_A F(x)
&&\left(\because\ F\ \text{の定義。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right).
\end{aligned}`),
      paragraph(["二つの条件が満たされたので、", math(String.raw`F`), " は線型写像である（", ref("def_linear_map"), "）。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_tensor_algebra_on_embedded_tensor",
    kind: "claim",
    title: { text: "線型写像がテンソル代数の上に定める写像の、成分へ埋め込んだテンソルでの値" },
    labels: ["claim_map_from_tensor_algebra_on_embedded_tensor"],
    statement: [
      paragraph([
        math(String.raw`\mathrm{emb}_k`), "、", math(String.raw`F_k`), "、", math(String.raw`F`), " を ", ref("def_map_from_tensor_algebra_extending_linear_map"),
        " のもの（", math(String.raw`\mathrm{emb}_k`), " は ", ref("def_vector_space_of_tensor_algebra"), "）とし、", math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        "、", math(String.raw`G\in T_k`), " とする。このとき ", math(String.raw`F\bigl(\mathrm{emb}_k(G)\bigr)=F_k(G)`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`x:=\mathrm{emb}_k(G)`), " と置く。", math(String.raw`k`), " は ", math(String.raw`x`), " の零の境の条件を満たす（",
        ref("def_embedding_into_component_of_direct_sum_of_family"), "）。", math(String.raw`i\in\{0,\dots,k\}`), " について ",
        math(String.raw`g_i:=F_i(x_i)`), " と置くと、", math(String.raw`g_k=F_k(G)`), "、", math(String.raw`i\neq k`), " なら ",
        math(String.raw`g_i=F_i(0_{T_i})=0_A`), " である（", ref("def_embedding_into_component_of_direct_sum_of_family"), "、",
        ref("claim_linear_map_sends_zero_to_zero"), "）。したがってどの ", math(String.raw`i`), " でも ",
        math(String.raw`1_{\mathbb{C}}\ast_A g_i=\delta_{k,i}\ast_A g_i`), " である（", ref("def_kronecker_delta"), "、",
        ref("claim_scalar_multiple_of_zero_vector_is_zero_vector"), "、", ref("claim_zero_scalar_multiple_is_zero_vector"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(x)
&=\sum_{i\in\{0,\dots,k\}}1_{\mathbb{C}}\ast_A g_i
&&\left(\because\ F\ \text{の定義を零の境}\ k\ \text{で。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right)\\
&=\sum_{i\in\{0,\dots,k\}}\delta_{k,i}\ast_A g_i
&&\left(\because\ \text{上の各項の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=g_k
&&\left(\because\ \blkref{claim_sum_over_finite_set_with_kronecker_delta_picks_term}\right)\\
&=F_k(G)
&&\left(\because\ \text{上の}\ g_k\ \text{の値}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_extension_on_tensor_powers_sends_product_of_tensors_to_product",
    kind: "claim",
    title: { text: "各 k 重テンソル積の上の写像は、テンソルの積を代数の積へ移す" },
    labels: ["claim_extension_on_tensor_powers_sends_product_of_tensors_to_product"],
    statement: [
      paragraph([
        math(String.raw`m_{k,l}`), " を ", ref("def_vector_space_of_tensor_algebra"), " のもの、", math(String.raw`A`), "、", math(String.raw`F_k`),
        " を ", ref("def_map_from_tensor_algebra_extending_linear_map"), " のものとし、", math(String.raw`k,l\in\mathbb{Z}_{\ge 0}`), "、",
        math(String.raw`G\in T_k`), "、", math(String.raw`H\in T_l`), " とする。このとき次が成り立つ。",
      ]),
      displayMath(String.raw`F_{k+l}\bigl(m_{k,l}(G,H)\bigr)=F_k(G)\cdot_A F_l(H)`),
    ],
    proof: [
      paragraph([
        "（組の像が二つのとき）", math(String.raw`u\in V^{\{1,\dots,k\}}`), "、", math(String.raw`u'\in V^{\{1,\dots,l\}}`), " とし、",
        math(String.raw`c:=\mathrm{cat}_{k,l}(u,u')`), " と置く。", ref("def_concatenation_of_tuples"), " から、", math(String.raw`s\in\{1,\dots,k\}`),
        " で ", math(String.raw`f(c(s))=f(u(s))`), "、", math(String.raw`t\in\{1,\dots,l\}`), " で ", math(String.raw`f(c(k+t))=f(u'(t))`),
        " であり、因子の族が各番号で等しい番号順の積は等しい（", ref("def_ordered_product_in_algebra"), " の漸化式）。",
      ]),
      displayMath(String.raw`\begin{aligned}
F_{k+l}\bigl(m_{k,l}(\tau_k(u),\tau_l(u'))\bigr)
&=F_{k+l}\bigl(\tau_{k+l}(c)\bigr)
&&\left(\because\ \blkref{claim_product_of_pure_tensors_is_pure_tensor_of_concatenation}\right)\\
&=\prod_{A,\,s=1}^{k+l}f\bigl(c(s)\bigr)
&&\left(\because\ F_{k+l}\ \text{の性質と}\ \mu^f_{k+l}\ \text{の定義。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\text{、}\blkref{def_ordered_product_of_values_of_linear_map_on_tuple}\right)\\
&=\left(\prod_{A,\,s=1}^{k}f\bigl(c(s)\bigr)\right)\cdot_A\left(\prod_{A,\,t=1}^{l}f\bigl(c(k+t)\bigr)\right)
&&\left(\because\ \blkref{claim_ordered_product_in_algebra_splits_into_first_and_last_factors}\right)\\
&=\left(\prod_{A,\,s=1}^{k}f\bigl(u(s)\bigr)\right)\cdot_A\left(\prod_{A,\,t=1}^{l}f\bigl(u'(t)\bigr)\right)
&&\left(\because\ \text{上の因子の等式}\right)\\
&=F_k\bigl(\tau_k(u)\bigr)\cdot_A F_l\bigl(\tau_l(u')\bigr)
&&\left(\because\ \mu^f_k,\ \mu^f_l\ \text{の定義と}\ F_k,\ F_l\ \text{の性質。}\blkref{def_ordered_product_of_values_of_linear_map_on_tuple}\text{、}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right).
\end{aligned}`),
      paragraph([
        "（前が組の像のとき）", math(String.raw`u`), " を上のものとする。二つの写像 ", math(String.raw`F_{k+l}\circ m_{k,l}(\tau_k(u),\bullet)`),
        " と ", math(String.raw`\bigl(F_k(\tau_k(u))\cdot_A\bullet\bigr)\circ F_l`), "（", math(String.raw`T_l\to A`), "）は線型写像の合成なので線型写像であり（",
        ref("claim_product_of_tensors_is_linear_in_second_factor"), "、", ref("claim_left_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）、前の段によりすべての ", math(String.raw`\tau_l(u')`), " で値が一致する。",
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_l,\tau_l)`), " に当てると二つは等しく、すべての ",
        math(String.raw`H\in T_l`), " について ", math(String.raw`F_{k+l}(m_{k,l}(\tau_k(u),H))=F_k(\tau_k(u))\cdot_A F_l(H)`), " である。",
      ]),
      paragraph([
        "（一般のとき）", math(String.raw`H\in T_l`), " とする。二つの写像 ", math(String.raw`F_{k+l}\circ m_{k,l}(\bullet,H)`), " と ",
        math(String.raw`\bigl(\bullet\cdot_A F_l(H)\bigr)\circ F_k`), "（", math(String.raw`T_k\to A`), "）は線型写像であり（",
        ref("claim_product_of_tensors_is_linear_in_first_factor"), "、", ref("claim_right_multiplication_in_algebra_is_linear_map"), "、",
        ref("claim_composition_of_linear_maps_is_linear_map"), "）、前の段によりすべての ", math(String.raw`\tau_k(u)`), " で値が一致する。",
        ref("claim_linear_maps_agreeing_on_pure_tensors_are_equal"), " を ", math(String.raw`(T_k,\tau_k)`), " に当てると二つは等しく、",
        math(String.raw`G`), " での値が主張の等式である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism",
    kind: "claim",
    title: { text: "線型写像がテンソル代数の上に定める写像は ℂ-代数の準同型である" },
    labels: ["claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism"],
    statement: [
      paragraph([
        math(String.raw`T(V)`), " をテンソル代数（", ref("claim_tensor_algebra_is_complex_algebra"), "）、", math(String.raw`A`), "、",
        math(String.raw`F`), " を ", ref("def_map_from_tensor_algebra_extending_linear_map"), " のものとする。このとき ", math(String.raw`F`),
        " は ", math(String.raw`T(V)`), " から ", math(String.raw`A`), " への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "（線型写像であること）", ref("claim_map_from_tensor_algebra_extending_linear_map_is_linear_map"), " である（",
        math(String.raw`U_{\mathrm{vec}}(T(V))=(D,+_D,\cdot_D,0_D)`), "）。これで加法を保つこととスカラー倍を保つことが済む。",
      ]),
      paragraph(["（乗法の単位元を保つこと）"]),
      displayMath(String.raw`\begin{aligned}
F(1_{T(V)})
&=F\Bigl(\mathrm{emb}_0\bigl(\tau_0(\varepsilon_V)\bigr)\Bigr)
&&\left(\because\ 1_{T(V)}=1_D\ \text{の定義。}\blkref{def_product_and_unit_of_tensor_algebra}\right)\\
&=F_0\bigl(\tau_0(\varepsilon_V)\bigr)
&&\left(\because\ \blkref{claim_map_from_tensor_algebra_on_embedded_tensor}\right)\\
&=\mu^f_0(\varepsilon_V)
&&\left(\because\ F_0\ \text{の性質。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right)\\
&=1_A
&&\left(\because\ \blkref{def_ordered_product_of_values_of_linear_map_on_tuple}\right).
\end{aligned}`),
      paragraph([
        "（乗法を保つこと）", math(String.raw`x,y\in D`), " とし、", math(String.raw`I:=\{0,\dots,N_x\}`), "、", math(String.raw`J:=\{0,\dots,N_y\}`),
        "（", math(String.raw`N_x,N_y`), " は零の境）、", math(String.raw`a_i:=\mathrm{emb}_i(x_i)`), "、", math(String.raw`b_j:=\mathrm{emb}_j(y_j)`),
        " と置くと、", math(String.raw`x=\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i`), "、", math(String.raw`y=\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j`),
        " である（", ref("claim_element_of_direct_sum_of_family_is_sum_of_embedded_components"), "）。線型写像 ", math(String.raw`F`), "、",
        math(String.raw`w\star_D\bullet`), "、", math(String.raw`\bullet\star_D w`), "、", math(String.raw`c\cdot_A\bullet`), "、", math(String.raw`\bullet\cdot_A c`),
        "（", ref("claim_tensor_algebra_product_is_linear_in_second_factor"), "、", ref("claim_tensor_algebra_product_is_linear_in_first_factor"), "、",
        ref("claim_left_multiplication_in_algebra_is_linear_map"), "、", ref("claim_right_multiplication_in_algebra_is_linear_map"), "）に ",
        ref("claim_linear_map_maps_sum_over_finite_set_to_sum_of_values"), " を当てる。",
        math(String.raw`i\in I`), "、", math(String.raw`j\in J`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
F(a_i\star_D b_j)
&=F\Bigl(\mathrm{emb}_{i+j}\bigl(m_{i,j}(x_i,y_j)\bigr)\Bigr)
&&\left(\because\ \blkref{claim_tensor_algebra_product_of_embedded_tensors}\right)\\
&=F_{i+j}\bigl(m_{i,j}(x_i,y_j)\bigr)
&&\left(\because\ \blkref{claim_map_from_tensor_algebra_on_embedded_tensor}\right)\\
&=F_i(x_i)\cdot_A F_j(y_j)
&&\left(\because\ \blkref{claim_extension_on_tensor_powers_sends_product_of_tensors_to_product}\right)\\
&=F(a_i)\cdot_A F(b_j)
&&\left(\because\ \blkref{claim_map_from_tensor_algebra_on_embedded_tensor}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph([math(String.raw`i\in I`), " について次が成り立つ。"]),
      displayMath(String.raw`\begin{aligned}
F(a_i\star_D y)
&=F\left(a_i\star_D\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j\right)
&&\left(\because\ y\ \text{の分解}\right)\\
&=F\left(\sum_{j\in J}1_{\mathbb{C}}\cdot_D(a_i\star_D b_j)\right)
&&\left(\because\ a_i\star_D\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{j\in J}1_{\mathbb{C}}\ast_A F(a_i\star_D b_j)
&&\left(\because\ F\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{j\in J}1_{\mathbb{C}}\ast_A\bigl(F(a_i)\cdot_A F(b_j)\bigr)
&&\left(\because\ \text{前の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=F(a_i)\cdot_A\sum_{j\in J}1_{\mathbb{C}}\ast_A F(b_j)
&&\left(\because\ F(a_i)\cdot_A\bullet\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=F(a_i)\cdot_A F\left(\sum_{j\in J}1_{\mathbb{C}}\cdot_D b_j\right)
&&\left(\because\ F\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=F(a_i)\cdot_A F(y)
&&\left(\because\ y\ \text{の分解}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
F(x\cdot_{T(V)}y)
&=F\left(\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i\right)\star_D y\right)
&&\left(\because\ \cdot_{T(V)}=\star_D\ \text{と}\ x\ \text{の分解}\right)\\
&=F\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D(a_i\star_D y)\right)
&&\left(\because\ \bullet\star_D y\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A F(a_i\star_D y)
&&\left(\because\ F\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=\sum_{i\in I}1_{\mathbb{C}}\ast_A\bigl(F(a_i)\cdot_A F(y)\bigr)
&&\left(\because\ \text{前の等式と}\ \blkref{claim_sum_over_finite_set_depends_only_on_terms}\right)\\
&=\left(\sum_{i\in I}1_{\mathbb{C}}\ast_A F(a_i)\right)\cdot_A F(y)
&&\left(\because\ \bullet\cdot_A F(y)\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=F\left(\sum_{i\in I}1_{\mathbb{C}}\cdot_D a_i\right)\cdot_A F(y)
&&\left(\because\ F\ \text{は線型写像。}\blkref{claim_linear_map_maps_sum_over_finite_set_to_sum_of_values}\right)\\
&=F(x)\cdot_A F(y)
&&\left(\because\ x\ \text{の分解}\right).
\end{aligned}`),
      paragraph(["以上で ", ref("def_complex_algebra_homomorphism"), " の条件がすべて満たされた。"]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding",
    kind: "claim",
    title: { text: "線型写像がテンソル代数の上に定める写像を埋め込みと合成すると、元の線型写像になる" },
    labels: ["claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding"],
    statement: [
      paragraph([
        math(String.raw`\iota`), " を ", ref("def_embedding_of_vector_space_into_tensor_algebra"), " のもの、", math(String.raw`f`), "、",
        math(String.raw`F`), " を ", ref("def_map_from_tensor_algebra_extending_linear_map"), " のものとする。このとき、すべての ",
        math(String.raw`v\in V`), " について ", math(String.raw`F\bigl(\iota(v)\bigr)=f(v)`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
F\bigl(\iota(v)\bigr)
&=F\Bigl(\mathrm{emb}_1\bigl(\tau_1(\langle v\rangle)\bigr)\Bigr)
&&\left(\because\ \iota\ \text{の定義。}\blkref{def_embedding_of_vector_space_into_tensor_algebra}\right)\\
&=F_1\bigl(\tau_1(\langle v\rangle)\bigr)
&&\left(\because\ \blkref{claim_map_from_tensor_algebra_on_embedded_tensor}\right)\\
&=\mu^f_1\bigl(\langle v\rangle\bigr)
&&\left(\because\ F_1\ \text{の性質。}\blkref{def_map_from_tensor_algebra_extending_linear_map}\right)\\
&=1_A\cdot_A f\bigl(\langle v\rangle(1)\bigr)
&&\left(\because\ \blkref{def_ordered_product_of_values_of_linear_map_on_tuple}\text{、}\blkref{def_ordered_product_in_algebra}\right)\\
&=1_A\cdot_A f(v)
&&\left(\because\ \blkref{def_one_element_tuple}\right)\\
&=f(v)
&&\left(\because\ U_{\mathrm{ring}}(A)\ \text{の乗法の単位元。}\blkref{def_unital_ring}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_universal_property_of_tensor_algebra",
    kind: "claim",
    title: { text: "テンソル代数の普遍性" },
    labels: ["claim_universal_property_of_tensor_algebra"],
    statement: [
      paragraph([
        math(String.raw`V`), "、", math(String.raw`T(V)`), "、", math(String.raw`\iota`), " を ", ref("def_embedding_of_vector_space_into_tensor_algebra"),
        " のもの、", math(String.raw`(A,+_A,\cdot_A,\ast_A,0_A,1_A)`), " を ℂ-代数（", ref("def_complex_algebra"), "）、", math(String.raw`f:V\to A`),
        " を ", math(String.raw`V`), " から ", math(String.raw`U_{\mathrm{vec}}(A)`), " への線型写像（", ref("def_linear_map"), "）とする。このとき、",
        math(String.raw`T(V)`), " から ", math(String.raw`A`), " への ℂ-代数の準同型（", ref("def_complex_algebra_homomorphism"), "）",
        math(String.raw`\Phi`), " で ", math(String.raw`\Phi\circ\iota=f`), " を満たすものが、ただ一つ存在する。",
      ]),
    ],
    proof: [
      paragraph([
        "（存在）", ref("def_map_from_tensor_algebra_extending_linear_map"), " の ", math(String.raw`F`), " は ℂ-代数の準同型であり（",
        ref("claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism"), "）、", math(String.raw`F\circ\iota=f`),
        " を満たす（", ref("claim_map_from_tensor_algebra_extending_linear_map_composed_with_embedding"), "）。",
      ]),
      paragraph([
        "（一意性）", math(String.raw`\Phi,\Phi'`), " を、", math(String.raw`\Phi\circ\iota=f`), "、", math(String.raw`\Phi'\circ\iota=f`),
        " を満たす ℂ-代数の準同型とする。", math(String.raw`\iota(V)`), " の任意の元は ", math(String.raw`v\in V`), " によって ",
        math(String.raw`\iota(v)`), " と書け、", math(String.raw`\Phi(\iota(v))=f(v)=\Phi'(\iota(v))`), " である。", math(String.raw`\iota(V)`),
        " は ", math(String.raw`T(V)`), " を生成するので（", ref("claim_image_of_embedding_generates_tensor_algebra"), "）、",
        ref("claim_homomorphisms_agreeing_on_generators_are_equal"), " により ", math(String.raw`\Phi=\Phi'`), " である。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_quadratic_form_heading",
    kind: "heading",
    level: 2,
    title: { text: "二次形式" },
    labels: [],
  },
  {
    id: "mathematical_toolkit_definition_polarization_of_map_to_complex_numbers",
    kind: "definition",
    title: { text: "ℂ への写像の偏極" },
    labels: ["def_polarization_of_map_to_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q:V\to\mathbb{C}`),
        " を写像とする。", math(String.raw`a\in\mathbb{C}`), " の加法の逆元を ", math(String.raw`-_{\mathbb{C}}a\in\mathbb{C}`), " と書く（",
        math(String.raw`a+_{\mathbb{C}}(-_{\mathbb{C}}a)=0_{\mathbb{C}}`), "）。写像 ", math(String.raw`B_q:V\times V\to\mathbb{C}`),
        " を次で定め、", math(String.raw`q`), " の偏極と呼ぶ。",
      ]),
      displayMath(String.raw`B_q(x,y):=\Bigl(q(x+_V y)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(x)\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(y)\bigr)\qquad(x,y\in V)`),
      paragraph([
        "右辺の ", math(String.raw`x+_V y`), " は ", math(String.raw`V`), " の元であり、", math(String.raw`q`), " の三つの値とその加法の逆元、それらの ",
        math(String.raw`\mathbb{C}`), " の中の和は ", math(String.raw`\mathbb{C}`), " の元である。これにより ", math(String.raw`B_q`),
        " は値域を ", math(String.raw`\mathbb{C}`), " とする写像として定まる。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_quadratic_form",
    kind: "definition",
    title: { text: "二次形式" },
    labels: ["def_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）とする。写像 ", math(String.raw`q:V\to\mathbb{C}`),
        " が次の二つを満たすとき、", math(String.raw`q`), " を ", math(String.raw`V`), " 上の二次形式と呼ぶ。", math(String.raw`B_q`), " は ",
        math(String.raw`q`), " の偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）である。",
      ]),
      list([
        [math(String.raw`q(\lambda\cdot_V x)=\lambda\cdot_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}q(x)\bigr)`), "（", math(String.raw`x\in V`), "、",
          math(String.raw`\lambda\in\mathbb{C}`), "）"],
        ["各 ", math(String.raw`y\in V`), " について、写像 ", math(String.raw`B_q(\bullet,y):V\to\mathbb{C}`), "、", math(String.raw`x\mapsto B_q(x,y)`),
          " は ", math(String.raw`V`), " 上の線型形式（", ref("def_linear_form"), "）である"],
      ]),
      paragraph([
        math(String.raw`q`), " が二次形式のとき、", math(String.raw`B_q`), " を ", math(String.raw`q`), " に付随する双線型形式と呼ぶ。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_polarization_identity",
    kind: "claim",
    title: { text: "偏極の等式" },
    labels: ["claim_polarization_identity"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q:V\to\mathbb{C}`),
        " を写像、", math(String.raw`B_q`), " をその偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）とする。このとき、すべての ",
        math(String.raw`x,y\in V`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`\bigl(q(x)+_{\mathbb{C}}q(y)\bigr)+_{\mathbb{C}}B_q(x,y)=q(x+_V y)`),
    ],
    proof: [
      paragraph([
        math(String.raw`a:=q(x)`), "、", math(String.raw`b:=q(y)`), "、", math(String.raw`c:=q(x+_V y)`), " と置く。", math(String.raw`a,b,c\in\mathbb{C}`),
        " であり、", math(String.raw`B_q(x,y)=\bigl(c+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}b)`), " である（",
        ref("def_polarization_of_map_to_complex_numbers"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(a+_{\mathbb{C}}b\bigr)+_{\mathbb{C}}B_q(x,y)
&=\bigl(a+_{\mathbb{C}}b\bigr)+_{\mathbb{C}}\Bigl(\bigl(c+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}b)\Bigr)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right)\\
&=\bigl(a+_{\mathbb{C}}b\bigr)+_{\mathbb{C}}\Bigl(c+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}b)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\bigl(a+_{\mathbb{C}}b\bigr)+_{\mathbb{C}}\Bigl(\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}b)\bigr)+_{\mathbb{C}}c\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\Bigl(\bigl(a+_{\mathbb{C}}b\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}b)\bigr)\Bigr)+_{\mathbb{C}}c
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\Bigl(a+_{\mathbb{C}}\Bigl(b+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}b)\bigr)\Bigr)\Bigr)+_{\mathbb{C}}c
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\Bigl(a+_{\mathbb{C}}\Bigl(b+_{\mathbb{C}}\bigl((-_{\mathbb{C}}b)+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)\Bigr)\Bigr)+_{\mathbb{C}}c
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\Bigl(a+_{\mathbb{C}}\Bigl(\bigl(b+_{\mathbb{C}}(-_{\mathbb{C}}b)\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}a)\Bigr)\Bigr)+_{\mathbb{C}}c
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\Bigl(a+_{\mathbb{C}}\bigl(0_{\mathbb{C}}+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)\Bigr)+_{\mathbb{C}}c
&&\left(\because\ -_{\mathbb{C}}b\ \text{は}\ b\ \text{の加法の逆元}\right)\\
&=\bigl(a+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}c
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=0_{\mathbb{C}}+_{\mathbb{C}}c
&&\left(\because\ -_{\mathbb{C}}a\ \text{は}\ a\ \text{の加法の逆元}\right)\\
&=c
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元}\right)\\
&=q(x+_V y)
&&\left(\because\ c\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_polarization_is_symmetric",
    kind: "claim",
    title: { text: "偏極は二つの引数の入れ替えで変わらない" },
    labels: ["claim_polarization_is_symmetric"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q:V\to\mathbb{C}`),
        " を写像、", math(String.raw`B_q`), " をその偏極（", ref("def_polarization_of_map_to_complex_numbers"), "）とする。このとき、すべての ",
        math(String.raw`x,y\in V`), " について ", math(String.raw`B_q(x,y)=B_q(y,x)`), " である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
B_q(x,y)
&=\Bigl(q(x+_V y)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(x)\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(y)\bigr)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right)\\
&=\Bigl(q(y+_V x)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(x)\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(y)\bigr)
&&\left(\because\ V\ \text{の加法の交換法則。}\blkref{def_complex_vector_space}\right)\\
&=q(y+_V x)+_{\mathbb{C}}\Bigl(\bigl(-_{\mathbb{C}}q(x)\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(y)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=q(y+_V x)+_{\mathbb{C}}\Bigl(\bigl(-_{\mathbb{C}}q(y)\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(x)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の交換法則}\right)\\
&=\Bigl(q(y+_V x)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(y)\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q(x)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=B_q(y,x)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_definition_nondegenerate_quadratic_form",
    kind: "definition",
    title: { text: "非退化な二次形式" },
    labels: ["def_nondegenerate_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、", math(String.raw`q`), " を ", math(String.raw`V`),
        " 上の二次形式（", ref("def_quadratic_form"), "）、", math(String.raw`B_q`), " をそれに付随する双線型形式とする。次を満たすとき、",
        math(String.raw`q`), " は非退化であるという。",
      ]),
      list([
        [math(String.raw`x\in V`), " が、すべての ", math(String.raw`y\in V`), " について ", math(String.raw`B_q(x,y)=0_{\mathbb{C}}`), " を満たすならば、",
          math(String.raw`x=0_V`), " である"],
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_isometry_of_quadratic_spaces",
    kind: "definition",
    title: { text: "等長写像" },
    labels: ["def_isometry_of_quadratic_spaces"],
    statement: [
      paragraph([
        math(String.raw`(V,+_V,\cdot_V,0_V)`), " と ", math(String.raw`(V',+_{V'},\cdot_{V'},0_{V'})`), " を ℂ-線型空間（", ref("def_complex_vector_space"),
        "）、", math(String.raw`q`), " を ", math(String.raw`V`), " 上の二次形式、", math(String.raw`q'`), " を ", math(String.raw`V'`),
        " 上の二次形式（", ref("def_quadratic_form"), "）とする。線型写像（", ref("def_linear_map"), "）", math(String.raw`\theta:V\to V'`),
        " が、すべての ", math(String.raw`x\in V`), " について ", math(String.raw`q'\bigl(\theta(x)\bigr)=q(x)`), " を満たすとき、",
        math(String.raw`\theta`), " を ", math(String.raw`(V,q)`), " から ", math(String.raw`(V',q')`), " への等長写像と呼ぶ。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_definition_split_quadratic_form",
    kind: "definition",
    title: { text: "線型空間とその双対空間の直和の上の、対による二次の写像" },
    labels: ["def_split_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`(W,+_W,\cdot_W,0_W)`), " を ℂ-線型空間（", ref("def_complex_vector_space"), "）、",
        math(String.raw`(W^{*},+_{W^{*}},\cdot_{W^{*}},0_{W^{*}})`), " をその双対空間（", ref("def_dual_space"), "、",
        ref("claim_dual_space_is_complex_vector_space"), "）、", math(String.raw`W\oplus W^{*}`), " をこの二つの直和（",
        ref("def_direct_sum_of_two_vector_spaces"), "、", ref("claim_direct_sum_of_two_vector_spaces_is_complex_vector_space"),
        "）とする。写像 ", math(String.raw`q_W:W\oplus W^{*}\to\mathbb{C}`), " を次で定める。",
      ]),
      displayMath(String.raw`q_W\bigl((w,f)\bigr):=f(w)\qquad(w\in W,\ f\in W^{*})`),
      paragraph([
        math(String.raw`W\oplus W^{*}`), " の元は ", math(String.raw`w\in W`), " と ", math(String.raw`f\in W^{*}`), " の順序対 ", math(String.raw`(w,f)`),
        " であり（", ref("def_direct_sum_of_two_vector_spaces"), "）、", math(String.raw`f`), " は ", math(String.raw`W`), " 上の線型形式なので ",
        math(String.raw`f(w)\in\mathbb{C}`), " である（", ref("def_dual_space"), "、", ref("def_linear_form"), "）。これにより ",
        math(String.raw`q_W`), " は値域を ", math(String.raw`\mathbb{C}`), " とする写像として定まる。", math(String.raw`q_W`),
        " が二次形式であることは、この定義では主張しない。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_value_of_polarization_of_split_quadratic_form",
    kind: "claim",
    title: { text: "対による二次の写像の偏極の値" },
    labels: ["claim_value_of_polarization_of_split_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`W`), "、", math(String.raw`W^{*}`), "、", math(String.raw`q_W`), " を ", ref("def_split_quadratic_form"), " のもの、",
        math(String.raw`B_{q_W}`), " を ", math(String.raw`q_W`), " の偏極（", ref("def_polarization_of_map_to_complex_numbers"),
        "）とする。このとき、すべての ", math(String.raw`w,w'\in W`), "、", math(String.raw`f,f'\in W^{*}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`B_{q_W}\bigl((w,f),(w',f')\bigr)=f(w')+_{\mathbb{C}}f'(w)`),
    ],
    proof: [
      paragraph([
        math(String.raw`a:=f(w)`), "、", math(String.raw`b:=f(w')`), "、", math(String.raw`c:=f'(w)`), "、", math(String.raw`d:=f'(w')`),
        " と置く。どれも ", math(String.raw`\mathbb{C}`), " の元である（", ref("def_linear_form"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
&B_{q_W}\bigl((w,f),(w',f')\bigr)\\
&=\Bigl(q_W\bigl((w,f)+_{W\oplus W^{*}}(w',f')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q_W((w,f))\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q_W((w',f'))\bigr)
&&\left(\because\ \blkref{def_polarization_of_map_to_complex_numbers}\right)\\
&=\Bigl(q_W\bigl((w+_W w',\ f+_{W^{*}}f')\bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q_W((w,f))\bigr)\Bigr)+_{\mathbb{C}}\bigl(-_{\mathbb{C}}q_W((w',f'))\bigr)
&&\left(\because\ \text{直和の加法。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\Bigl(\bigl(f+_{W^{*}}f'\bigr)(w+_W w')+_{\mathbb{C}}(-_{\mathbb{C}}a)\Bigr)+_{\mathbb{C}}(-_{\mathbb{C}}d)
&&\left(\because\ q_W\ \text{の定義を三か所に適用。}\blkref{def_split_quadratic_form}\right)\\
&=\Bigl(\bigl(f(w+_W w')+_{\mathbb{C}}f'(w+_W w')\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}a)\Bigr)+_{\mathbb{C}}(-_{\mathbb{C}}d)
&&\left(\because\ +_{W^{*}}\ \text{は各点ごとの和。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\Bigl(\bigl((a+_{\mathbb{C}}b)+_{\mathbb{C}}(c+_{\mathbb{C}}d)\bigr)+_{\mathbb{C}}(-_{\mathbb{C}}a)\Bigr)+_{\mathbb{C}}(-_{\mathbb{C}}d)
&&\left(\because\ f,\ f'\ \text{は加法を保つ（二か所に適用）。}\blkref{def_linear_form}\right)\\
&=\bigl((a+_{\mathbb{C}}b)+_{\mathbb{C}}(c+_{\mathbb{C}}d)\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}d)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=\bigl((b+_{\mathbb{C}}c)+_{\mathbb{C}}(a+_{\mathbb{C}}d)\bigr)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}d)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則と交換法則による項の並べ替え}\right)\\
&=(b+_{\mathbb{C}}c)+_{\mathbb{C}}\Bigl((a+_{\mathbb{C}}d)+_{\mathbb{C}}\bigl((-_{\mathbb{C}}a)+_{\mathbb{C}}(-_{\mathbb{C}}d)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則}\right)\\
&=(b+_{\mathbb{C}}c)+_{\mathbb{C}}\Bigl(\bigl(a+_{\mathbb{C}}(-_{\mathbb{C}}a)\bigr)+_{\mathbb{C}}\bigl(d+_{\mathbb{C}}(-_{\mathbb{C}}d)\bigr)\Bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則と交換法則による項の並べ替え}\right)\\
&=(b+_{\mathbb{C}}c)+_{\mathbb{C}}\bigl(0_{\mathbb{C}}+_{\mathbb{C}}0_{\mathbb{C}}\bigr)
&&\left(\because\ \text{加法の逆元を二か所に適用}\right)\\
&=b+_{\mathbb{C}}c
&&\left(\because\ 0_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の加法の単位元（二か所に適用）}\right)\\
&=f(w')+_{\mathbb{C}}f'(w)
&&\left(\because\ b,\ c\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_split_quadratic_form_is_quadratic_form",
    kind: "claim",
    title: { text: "対による二次の写像は二次形式である" },
    labels: ["claim_split_quadratic_form_is_quadratic_form"],
    statement: [
      paragraph([
        math(String.raw`W`), "、", math(String.raw`W^{*}`), "、", math(String.raw`q_W`), " を ", ref("def_split_quadratic_form"), " のものとする。このとき ",
        math(String.raw`q_W`), " は ", math(String.raw`W\oplus W^{*}`), " 上の二次形式（", ref("def_quadratic_form"), "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "（一つ目の条件）", math(String.raw`w\in W`), "、", math(String.raw`f\in W^{*}`), "、", math(String.raw`\lambda\in\mathbb{C}`), " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
q_W\bigl(\lambda\cdot_{W\oplus W^{*}}(w,f)\bigr)
&=q_W\bigl((\lambda\cdot_W w,\ \lambda\cdot_{W^{*}}f)\bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{W^{*}}f\bigr)(\lambda\cdot_W w)
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}f(\lambda\cdot_W w)
&&\left(\because\ \cdot_{W^{*}}\ \text{は各点ごとのスカラー倍。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}f(w)\bigr)
&&\left(\because\ f\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\Bigl(\lambda\cdot_{\mathbb{C}}q_W\bigl((w,f)\bigr)\Bigr)
&&\left(\because\ \blkref{def_split_quadratic_form}\right).
\end{aligned}`),
      paragraph([
        "（二つ目の条件）", math(String.raw`(w',f')\in W\oplus W^{*}`), " を固定し、", math(String.raw`g:=B_{q_W}\bigl(\bullet,(w',f')\bigr)`),
        " と置く。", math(String.raw`(w_1,f_1),(w_2,f_2),(w,f)\in W\oplus W^{*}`), "、", math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る。加法を保つことは次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
g\bigl((w_1,f_1)+_{W\oplus W^{*}}(w_2,f_2)\bigr)
&=g\bigl((w_1+_W w_2,\ f_1+_{W^{*}}f_2)\bigr)
&&\left(\because\ \text{直和の加法。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(f_1+_{W^{*}}f_2\bigr)(w')+_{\mathbb{C}}f'(w_1+_W w_2)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right)\\
&=\bigl(f_1(w')+_{\mathbb{C}}f_2(w')\bigr)+_{\mathbb{C}}f'(w_1+_W w_2)
&&\left(\because\ +_{W^{*}}\ \text{は各点ごとの和。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_sum_of_linear_forms_is_linear_form}\right)\\
&=\bigl(f_1(w')+_{\mathbb{C}}f_2(w')\bigr)+_{\mathbb{C}}\bigl(f'(w_1)+_{\mathbb{C}}f'(w_2)\bigr)
&&\left(\because\ f'\ \text{は加法を保つ。}\blkref{def_linear_form}\right)\\
&=\bigl(f_1(w')+_{\mathbb{C}}f'(w_1)\bigr)+_{\mathbb{C}}\bigl(f_2(w')+_{\mathbb{C}}f'(w_2)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の加法の結合法則と交換法則による項の並べ替え}\right)\\
&=g\bigl((w_1,f_1)\bigr)+_{\mathbb{C}}g\bigl((w_2,f_2)\bigr)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\ \text{を二か所に適用}\right).
\end{aligned}`),
      paragraph(["スカラー倍を保つことは次のとおりである。"]),
      displayMath(String.raw`\begin{aligned}
g\bigl(\lambda\cdot_{W\oplus W^{*}}(w,f)\bigr)
&=g\bigl((\lambda\cdot_W w,\ \lambda\cdot_{W^{*}}f)\bigr)
&&\left(\because\ \text{直和のスカラー倍。}\blkref{def_direct_sum_of_two_vector_spaces}\right)\\
&=\bigl(\lambda\cdot_{W^{*}}f\bigr)(w')+_{\mathbb{C}}f'(\lambda\cdot_W w)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(w')\bigr)+_{\mathbb{C}}f'(\lambda\cdot_W w)
&&\left(\because\ \cdot_{W^{*}}\ \text{は各点ごとのスカラー倍。}\blkref{def_dual_space}\text{、}\blkref{claim_pointwise_scalar_multiple_of_linear_form_is_linear_form}\right)\\
&=\bigl(\lambda\cdot_{\mathbb{C}}f(w')\bigr)+_{\mathbb{C}}\bigl(\lambda\cdot_{\mathbb{C}}f'(w)\bigr)
&&\left(\because\ f'\ \text{はスカラー倍を保つ。}\blkref{def_linear_form}\right)\\
&=\lambda\cdot_{\mathbb{C}}\bigl(f(w')+_{\mathbb{C}}f'(w)\bigr)
&&\left(\because\ \mathbb{C}\ \text{の分配法則}\right)\\
&=\lambda\cdot_{\mathbb{C}}g\bigl((w,f)\bigr)
&&\left(\because\ \blkref{claim_value_of_polarization_of_split_quadratic_form}\right).
\end{aligned}`),
      paragraph([
        "二つの条件が満たされたので、", math(String.raw`g`), " は ", math(String.raw`W\oplus W^{*}`), " 上の線型形式であり（", ref("def_linear_form"),
        "）、", math(String.raw`(w',f')`), " は任意だったので、", math(String.raw`q_W`), " は二次形式の二つの条件を満たす（", ref("def_quadratic_form"), "）。",
      ]),
    ],
  },
  {
    id: "mathematical_toolkit_claim_split_quadratic_form_vanishes_on_first_component",
    kind: "claim",
    title: { text: "対による二次の写像は、第一成分への埋め込みの像で 0 になる" },
    labels: ["claim_split_quadratic_form_vanishes_on_first_component"],
    statement: [
      paragraph([
        math(String.raw`W`), "、", math(String.raw`W^{*}`), "、", math(String.raw`q_W`), " を ", ref("def_split_quadratic_form"), " のもの、",
        math(String.raw`\mathrm{in}_1:W\to W\oplus W^{*}`), " を直和の第一成分への埋め込み写像（", ref("def_embedding_into_first_component_of_direct_sum"),
        "）とする。このとき、すべての ", math(String.raw`w\in W`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`q_W\bigl(\mathrm{in}_1(w)\bigr)=0_{\mathbb{C}}`),
    ],
    proof: [
      paragraph([
        math(String.raw`z_W:W\to\mathbb{C}`), " を ", ref("claim_zero_map_is_linear_form"), " の零写像とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
q_W\bigl(\mathrm{in}_1(w)\bigr)
&=q_W\bigl((w,\ 0_{W^{*}})\bigr)
&&\left(\because\ \blkref{def_embedding_into_first_component_of_direct_sum}\right)\\
&=0_{W^{*}}(w)
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=z_W(w)
&&\left(\because\ 0_{W^{*}}:=z_W\text{。}\blkref{def_dual_space}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ z_W\ \text{の定義。}\blkref{claim_zero_map_is_linear_form}\right).
\end{aligned}`),
    ],
  },
  {
    id: "mathematical_toolkit_claim_split_quadratic_form_vanishes_on_second_component",
    kind: "claim",
    title: { text: "対による二次の写像は、第二成分への埋め込みの像で 0 になる" },
    labels: ["claim_split_quadratic_form_vanishes_on_second_component"],
    statement: [
      paragraph([
        math(String.raw`W`), "、", math(String.raw`W^{*}`), "、", math(String.raw`q_W`), " を ", ref("def_split_quadratic_form"), " のもの、",
        math(String.raw`\mathrm{in}_2:W^{*}\to W\oplus W^{*}`), " を直和の第二成分への埋め込み写像（", ref("def_embedding_into_second_component_of_direct_sum"),
        "）とする。このとき、すべての ", math(String.raw`g\in W^{*}`), " について次が成り立つ。",
      ]),
      displayMath(String.raw`q_W\bigl(\mathrm{in}_2(g)\bigr)=0_{\mathbb{C}}`),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
q_W\bigl(\mathrm{in}_2(g)\bigr)
&=q_W\bigl((0_W,\ g)\bigr)
&&\left(\because\ \blkref{def_embedding_into_second_component_of_direct_sum}\right)\\
&=g(0_W)
&&\left(\because\ \blkref{def_split_quadratic_form}\right)\\
&=0_{\mathbb{C}}
&&\left(\because\ g\ \text{は}\ W\ \text{上の線型形式。}\blkref{def_dual_space}\text{、}\blkref{claim_linear_form_sends_zero_vector_to_zero}\right).
\end{aligned}`),
    ],
  },
]);
