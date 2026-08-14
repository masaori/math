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
]);
