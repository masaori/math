import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
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
]);
