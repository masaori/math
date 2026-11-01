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
]);
