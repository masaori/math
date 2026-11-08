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
&&\left(\because\ \varphi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\psi(1_A)
&&\left(\because\ \psi\ \text{は乗法の単位元を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph(["加法で閉じていること（",
        math(String.raw`x+_A y\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x+_A y)
&=\varphi(x)+_B\varphi(y)
&&\left(\because\ \varphi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\psi(x)+_B\varphi(y)
&&\left(\because\ x\in E\right)\\
&=\psi(x)+_B\psi(y)
&&\left(\because\ y\in E\right)\\
&=\psi(x+_A y)
&&\left(\because\ \psi\ \text{は加法を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph(["乗法で閉じていること（",
        math(String.raw`x\cdot_A y\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(x\cdot_A y)
&=\varphi(x)\cdot_B\varphi(y)
&&\left(\because\ \varphi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\psi(x)\cdot_B\varphi(y)
&&\left(\because\ x\in E\right)\\
&=\psi(x)\cdot_B\psi(y)
&&\left(\because\ y\in E\right)\\
&=\psi(x\cdot_A y)
&&\left(\because\ \psi\ \text{は乗法を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
\end{aligned}`),
      paragraph(["スカラー倍で閉じていること（",
        math(String.raw`\lambda\ast_A x\in E`),
        "）は次の等式による。"]),
      displayMath(String.raw`\begin{aligned}
\varphi(\lambda\ast_A x)
&=\lambda\ast_B\varphi(x)
&&\left(\because\ \varphi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right)\\
&=\lambda\ast_B\psi(x)
&&\left(\because\ x\in E\right)\\
&=\psi(\lambda\ast_A x)
&&\left(\because\ \psi\ \text{はスカラー倍を保つ。}\blkref{def_complex_algebra_homomorphism}\right).
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
        math(String.raw`\mathcal{J}_X`),
        " が空でないこと（たとえば ",
        math(String.raw`A`),
        " 自身が属すること）は、この議論では使わない。",
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
        "この議論は ",
        math(String.raw`\langle X\rangle_A`),
        " が両側イデアルであること（",
        ref("claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal"),
        "）を使わない。",
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
        "この議論は ",
        math(String.raw`\langle X\rangle_A`),
        " が両側イデアルであること（",
        ref("claim_two_sided_ideal_generated_by_subset_is_two_sided_ideal"),
        "）も、",
        math(String.raw`X`),
        " を含むこと（",
        ref("claim_two_sided_ideal_generated_by_subset_contains_subset"),
        "）も使わない。",
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
&&\left(\because\ \text{環の組}\ (A,+_A,\cdot_A,0_A,1_A)\ \text{の乗法の単位元。}\blkref{def_complex_algebra}\text{、}\blkref{def_unital_ring}\right)\\
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
        "この議論は、両側イデアルの一つ目・二つ目・四つ目の条件と、スカラー倍と乗法の両立の右の因子を使わない。",
      ]),
    ],
  },
]);
