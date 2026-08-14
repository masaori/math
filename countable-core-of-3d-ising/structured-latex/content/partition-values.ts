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
]);
