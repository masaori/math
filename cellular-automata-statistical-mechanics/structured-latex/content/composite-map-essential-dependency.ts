/**
 * 章「合成写像の本質的依存台」。
 * 有限配位集合上の二つの写像について、合成の各セルの本質的依存台が、二つの
 * 本質的依存台割り当ての合成近傍に含まれることと、その包含が真になりうることを示す。
 * 有限集合、写像、有限真理値表だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "composite_map_essential_dependency_heading",
    kind: "heading",
    level: 1,
    title: { text: "合成写像の本質的依存台" },
    labels: [],
  },

  {
    id: "composite_map_essential_dependency_definition_cell_map",
    kind: "definition",
    title: { text: "有限配位写像の各セルの値写像" },
    labels: ["def_finite_configuration_map_cell_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と状態集合 ", math(String.raw`A=\{0,1\}`),
        "（", ref("def_state_set"), "）を取り、写像 ",
        math(String.raw`F:A^V\to A^V`), " を取る。各 ", math(String.raw`v\in V`),
        " に対し、写像 ", math(String.raw`F_v:A^V\to A`), " を",
      ]),
      displayMath(String.raw`F_v(x):=F(x)(v)\qquad(x\in A^V)`),
      paragraph(["で定め、", math(String.raw`F`), " の ", math(String.raw`v`), " での値写像と呼ぶ。"])],
  },

  {
    id: "composite_map_essential_dependency_definition_assignment",
    kind: "definition",
    title: { text: "有限配位写像の本質的依存台割り当て" },
    labels: ["def_global_map_essential_dependency_assignment"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_finite_configuration_map_cell_map"), " の写像 ", math(String.raw`F:A^V\to A^V`),
        " に対し、写像 ", math(String.raw`D_F:V\to\{V\text{ の部分集合}\}`), " を",
      ]),
      displayMath(String.raw`D_F(v):=\operatorname{supp}(F_v)\subseteq V\qquad(v\in V)`),
      paragraph([
        "で定め、本質的依存台割り当てと呼ぶ。本質的依存台は ",
        ref("def_essential_dependency_support"), " で定義される。", math(String.raw`V`),
        " は有限なので、", math(String.raw`D_F`), " は有限近傍割り当てである。",
      ]),
    ],
  },

  {
    id: "composite_map_essential_dependency_claim_upper_bound",
    kind: "claim",
    title: { text: "合成写像の本質的依存台は合成近傍に含まれる" },
    labels: ["claim_composite_map_support_bounded_by_composed_support"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " 上の任意の二写像 ",
        math(String.raw`F,G:A^V\to A^V`), " について、各 ", math(String.raw`v\in V`), " で",
      ]),
      displayMath(String.raw`D_{F\circ G}(v)\subseteq(D_F\star D_G)(v)`),
      paragraph([
        "が成り立つ。ここで ", math(String.raw`D_F,D_G,D_{F\circ G}`), " は ",
        ref("def_global_map_essential_dependency_assignment"), "、", math(String.raw`\star`),
        " は ", ref("def_composed_neighborhood"), " で定義される。両辺とこの包含の成否は、",
        "二つの有限真理値表から有限回の等号判定で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`u\in V`), " について、", math(String.raw`G_u:A^V\to A`),
        " は ", math(String.raw`D_G(u)=\operatorname{supp}(G_u)`), " 上の局所規則で表せる（",
        ref("claim_support_is_minimum_representing_set"), "）。したがって ",
        math(String.raw`G`), " は近傍割り当て ", math(String.raw`D_G`),
        " 上の局所規則族が定める大域写像である。同様に ", math(String.raw`F`),
        " は近傍割り当て ", math(String.raw`D_F`), " 上の局所規則族が定める大域写像である。",
      ]),
      paragraph([
        ref("claim_global_map_composition_representable_on_composed_neighborhood"), " をこの二つの",
        "局所規則族へ適用すると、", math(String.raw`F\circ G`), " は近傍割り当て ",
        math(String.raw`D_F\star D_G`), " 上の局所規則族で表せる。ゆえに各 ",
        math(String.raw`v\in V`), " について値写像 ", math(String.raw`(F\circ G)_v`),
        " は ", math(String.raw`(D_F\star D_G)(v)`), " 上の局所規則で表せる。",
        ref("claim_representable_implies_support_subset"), " より",
      ]),
      displayMath(String.raw`\begin{aligned}
D_{F\circ G}(v)
&=\operatorname{supp}((F\circ G)_v)\qquad(\because\ \blkref{def_global_map_essential_dependency_assignment})\\
&\subseteq(D_F\star D_G)(v)\qquad(\because\ \blkref{claim_representable_implies_support_subset})
\end{aligned}`),
      paragraph([
        "を得る。有限決定については、", ref("claim_support_finite_decidability"),
        " により三つの本質的依存台割り当てを有限決定でき、", ref("def_composed_neighborhood"),
        " の有限合併と有限集合の包含判定により残りを決定できる。",
      ]),
    ],
  },

  {
    id: "composite_map_essential_dependency_definition_strict_witness",
    kind: "definition",
    title: { text: "合成近傍の上界が真に大きくなる有限反例" },
    labels: ["def_composite_support_strict_inclusion_witness"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる二元からなる有限集合 ", math(String.raw`V_{\mathrm{s}}:=\{a,b\}`),
        " を取る。写像 ", math(String.raw`G,F:A^{V_{\mathrm{s}}}\to A^{V_{\mathrm{s}}}`), " を",
      ]),
      displayMath(String.raw`\begin{aligned}
G(x)(a)&:=x(a),&G(x)(b)&:=x(a),\\
F(y)(a)&:=\begin{cases}0&(y(a)=y(b))\\1&(y(a)\neq y(b)),\end{cases}
&F(y)(b)&:=0
\end{aligned}`),
      paragraph([
        "で定める。これは有限集合の元の等号による場合分けだけで定まる二つの有限真理値表である。",
      ]),
    ],
  },

  {
    id: "composite_map_essential_dependency_claim_strict",
    kind: "claim",
    title: { text: "合成本質的依存台の上界は等号になるとは限らない" },
    labels: ["claim_composite_map_support_bound_can_be_strict"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_composite_support_strict_inclusion_witness"), " の ", math(String.raw`F,G`), " について",
      ]),
      displayMath(String.raw`D_{F\circ G}(a)=\varnothing\subsetneq\{a\}=(D_F\star D_G)(a)`),
      paragraph([
        "である。したがって ", ref("claim_composite_map_support_bounded_by_composed_support"),
        " の包含は一般には等号でない。合成の中で、異なる中間セルを通る同じ入力依存が相殺されうる。",
      ]),
    ],
    proof: [
      paragraph([
        "任意の ", math(String.raw`x\in A^{V_{\mathrm{s}}}`), " について ",
        math(String.raw`G(x)(a)=G(x)(b)=x(a)`), " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
((F\circ G)(x))(a)
&=F(G(x))(a)\qquad(\because\ \text{写像の合成の定義})\\
&=0\qquad(\because\ G(x)(a)=G(x)(b),\ \blkref{def_composite_support_strict_inclusion_witness})
\end{aligned}`),
      paragraph([
        "である。よって ", math(String.raw`(F\circ G)_a`), " は定値写像であり、",
        math(String.raw`D_{F\circ G}(a)=\varnothing`), " である（",
        ref("def_essential_dependency"), "、", ref("def_global_map_essential_dependency_assignment"), "）。",
      ]),
      paragraph([
        "一方、", math(String.raw`F_a`), " では ", math(String.raw`y(a)`), " だけ、または ",
        math(String.raw`y(b)`), " だけを入れ替えると二値の等号・不等号が入れ替わるので ",
        math(String.raw`D_F(a)=\{a,b\}`), " である。", math(String.raw`G_a=G_b`),
        " はともに入力の ", math(String.raw`a`), " だけに依存するので ",
        math(String.raw`D_G(a)=D_G(b)=\{a\}`), " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
(D_F\star D_G)(a)
&=\bigcup_{u\in D_F(a)}D_G(u)\qquad(\because\ \blkref{def_composed_neighborhood})\\
&=D_G(a)\cup D_G(b)\qquad(\because\ D_F(a)=\{a,b\})\\
&=\{a\}\qquad(\because\ D_G(a)=D_G(b)=\{a\})
\end{aligned}`),
      paragraph([
        "となる。", math(String.raw`a\in\{a\}`), " なので ",
        math(String.raw`\varnothing\subsetneq\{a\}`), " であり、主張が従う。",
      ]),
    ],
  },
]);
