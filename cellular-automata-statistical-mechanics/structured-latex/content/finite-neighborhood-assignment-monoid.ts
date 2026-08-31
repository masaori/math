/**
 * 章「有限近傍割り当ての合成モノイド」。
 * 有限舞台上の近傍割り当て全体が、合成近傍と自己近傍について有限モノイドをなし、
 * 一般には可換でないことを示す。有限集合、写像、自然数だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_neighborhood_assignment_monoid_definition_assignment_space",
    kind: "definition",
    title: { text: "有限舞台上の近傍割り当て全体" },
    labels: ["def_finite_neighborhood_assignment_space"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " に対し、",
      ]),
      displayMath(String.raw`\mathcal N(V):=\{N\mid N:V\to\mathcal P(V)\}`),
      paragraph([
        "と定める。", math(String.raw`V`), " が有限なので、各 ", math(String.raw`N(v)`),
        " は有限集合であり、", math(String.raw`N\in\mathcal N(V)`), " は ",
        ref("def_finite_stage"), " の近傍割り当てである。",
      ]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_definition_identity",
    kind: "definition",
    title: { text: "自己近傍割り当て" },
    labels: ["def_identity_neighborhood_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の写像 ",
        math(String.raw`I_V:V\to\mathcal P(V)`), " を",
      ]),
      displayMath(String.raw`I_V(v):=\{v\}\qquad(v\in V)`),
      paragraph(["で定め、自己近傍割り当てと呼ぶ。"]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_claim_identity",
    kind: "claim",
    title: { text: "自己近傍割り当ては合成近傍の単位元である" },
    labels: ["claim_identity_neighborhood_assignment_is_composition_identity"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の ", math(String.raw`N\in\mathcal N(V)`), " について",
      ]),
      displayMath(String.raw`I_V\star N=N=N\star I_V`),
      paragraph(["が成り立つ（", ref("def_composed_neighborhood"), "）。"]),
    ],
    proof: [
      paragraph(["任意の ", math(String.raw`v\in V`), " を取る。まず"]),
      displayMath(String.raw`\begin{aligned}
(I_V\star N)(v)
&=\bigcup_{u\in I_V(v)}N(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\{v\}}N(u)\qquad(\because\ \blkref{def_identity_neighborhood_assignment})\\
&=N(v)\qquad(\because\ \text{一元集合を添字とする合併})
\end{aligned}`),
      paragraph(["である。また"]),
      displayMath(String.raw`\begin{aligned}
(N\star I_V)(v)
&=\bigcup_{u\in N(v)}I_V(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in N(v)}\{u\}\qquad(\because\ \blkref{def_identity_neighborhood_assignment})\\
&=N(v)\qquad(\because\ \text{一元集合の合併})
\end{aligned}`),
      paragraph([
        "である。", math(String.raw`v`), " は任意なので、写像の外延性より二つの等号が従う。",
      ]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_claim_associativity",
    kind: "claim",
    title: { text: "合成近傍は結合的である" },
    labels: ["claim_composed_neighborhood_associative"],
    habitat: "finite",
    statement: [
      paragraph([
        "任意の ", math(String.raw`N,M,L\in\mathcal N(V)`), " について",
      ]),
      displayMath(String.raw`(N\star M)\star L=N\star(M\star L)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`v,w\in V`), " を取る。合成近傍の定義を一段ずつ展開すると",
      ]),
      displayMath(String.raw`\begin{aligned}
w\in((N\star M)\star L)(v)
&\Longleftrightarrow \exists u\in(N\star M)(v),\ w\in L(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow \exists r\in N(v),\ \exists u\in M(r),\ w\in L(u)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow \exists r\in N(v),\ w\in(M\star L)(r)
  \qquad(\because\ \blkref{def_composed_neighborhood})\\
&\Longleftrightarrow w\in(N\star(M\star L))(v)
  \qquad(\because\ \blkref{def_composed_neighborhood})
\end{aligned}`),
      paragraph([
        "である。", math(String.raw`w`), " の任意性と集合の外延性により各 ",
        math(String.raw`v`), " で二つの近傍が等しく、", math(String.raw`v`),
        " の任意性と写像の外延性により主張が従う。",
      ]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_claim_monoid",
    kind: "claim",
    title: { text: "近傍割り当て全体はモノイドをなす" },
    labels: ["claim_finite_neighborhood_assignments_form_monoid"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`\mathcal N(V)`), " は ", math(String.raw`\star`), " と ",
        math(String.raw`I_V`), " についてモノイドをなす。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_composed_neighborhood"), " により二つの近傍割り当ての積は再び近傍割り当てである。",
        ref("claim_composed_neighborhood_associative"), " により結合律が成り立ち、",
        ref("claim_identity_neighborhood_assignment_is_composition_identity"), " により ",
        math(String.raw`I_V`), " は両側単位元である。よってモノイドである。",
      ]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_claim_cardinality_decidable",
    kind: "claim",
    title: { text: "近傍割り当てモノイドの元数と有限決定" },
    labels: ["claim_finite_neighborhood_assignment_monoid_cardinality_decidable"],
    habitat: "N",
    statement: [
      paragraph([ref("claim_finite_neighborhood_assignments_form_monoid"), " のモノイドについて"]),
      displayMath(String.raw`|\mathcal N(V)|=(2^{|V|})^{|V|}=2^{|V|^2}`),
      paragraph(["であり、その元・積・単位元・合成表は有限決定できる。"]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`v\in V`), " には ", math(String.raw`2^{|V|}`),
        " 個の部分集合から一つを独立に割り当てるので",
      ]),
      displayMath(String.raw`\begin{aligned}
|\mathcal N(V)|
&=(2^{|V|})^{|V|}\qquad(\because\ \text{有限集合から有限集合への写像の個数})\\
&=2^{|V|^2}\qquad(\because\ \text{自然数の冪の法則})
\end{aligned}`),
      paragraph([
        "である。", math(String.raw`\mathcal N(V)`), " を全列挙し、各積を有限合併で計算すれば、",
        "元・積・単位元・合成表を有限回の所属判定で決定できる。",
      ]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_definition_noncommutative_witness",
    kind: "definition",
    title: { text: "合成近傍の非可換性を示す有限舞台" },
    labels: ["def_noncommutative_neighborhood_assignment_witness"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる元からなる有限集合 ", math(String.raw`V_{\mathrm{nc}}:=\{a,b,c\}`),
        " 上の近傍割り当て ", math(String.raw`N,M\in\mathcal N(V_{\mathrm{nc}})`),
        "（", ref("def_finite_neighborhood_assignment_space"), "）を",
      ]),
      displayMath(String.raw`\begin{aligned}
&N(a):=\{b\},\qquad N(b):=N(c):=\varnothing,\\
&M(b):=\{c\},\qquad M(a):=M(c):=\varnothing
\end{aligned}`),
      paragraph(["で定める。"]),
    ],
  },

  {
    id: "finite_neighborhood_assignment_monoid_claim_noncommutative",
    kind: "claim",
    title: { text: "近傍割り当ての合成は一般には可換でない" },
    labels: ["claim_neighborhood_assignment_composition_not_commutative"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_noncommutative_neighborhood_assignment_witness"), " の有限舞台で ",
        math(String.raw`N\star M\neq M\star N`), " である。したがって有限モノイド ",
        math(String.raw`(\mathcal N(V),\star,I_V)`), " は一般には可換でない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(N\star M)(a)
&=\bigcup_{u\in N(a)}M(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=M(b)\qquad(\because\ \blkref{def_noncommutative_neighborhood_assignment_witness})\\
&=\{c\}\qquad(\because\ \blkref{def_noncommutative_neighborhood_assignment_witness}),\\[4pt]
(M\star N)(a)
&=\bigcup_{u\in M(a)}N(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=\bigcup_{u\in\varnothing}N(u)\qquad(\because\ \blkref{def_noncommutative_neighborhood_assignment_witness})\\
&=\varnothing\qquad(\because\ \text{空集合を添字とする合併})
\end{aligned}`),
      paragraph([
        math(String.raw`c\in\{c\}`), " かつ ", math(String.raw`c\notin\varnothing`),
        " なので二つの ", math(String.raw`a`), " での値は異なる。よって写像も異なる。",
      ]),
    ],
  },
]);
