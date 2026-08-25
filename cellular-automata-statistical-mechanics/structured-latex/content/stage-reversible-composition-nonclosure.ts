/**
 * 章「固定近傍による可逆大域写像族の合成非閉性」。
 * 固定した近傍で表せる可逆大域写像の集合は、一般には合成で閉じないことを有限反例で示す。
 * 有限集合、写像、有限真理値表だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "fixed_neighborhood_composition_nonclosure_heading",
    kind: "heading",
    level: 1,
    title: { text: "固定近傍による可逆大域写像族の合成非閉性" },
    labels: [],
  },

  {
    id: "fixed_neighborhood_composition_nonclosure_definition_cyclic_dependency_stage",
    kind: "definition",
    title: { text: "3 セルの巡回依存舞台と座標送り写像" },
    labels: ["def_three_cell_cyclic_dependency_stage"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる元からなる有限集合 ", math(String.raw`V_{\circlearrowright}:=\{a,b,c\}`),
        " と写像 ", math(String.raw`s:V_{\circlearrowright}\to V_{\circlearrowright}`), " を",
      ]),
      displayMath(String.raw`s(a):=b,\qquad s(b):=c,\qquad s(c):=a`),
      paragraph([
        "で定め、各 ", math(String.raw`v\in V_{\circlearrowright}`), " の近傍を ",
        math(String.raw`N_{\circlearrowright}(v):=\{s(v)\}`), " とする。さらに写像 ",
        math(String.raw`F:A^{V_{\circlearrowright}}\to A^{V_{\circlearrowright}}`), " を",
      ]),
      displayMath(String.raw`(F x)(v):=x(s(v))\qquad\bigl(x\in A^{V_{\circlearrowright}},\ v\in V_{\circlearrowright}\bigr)`),
      paragraph([
        "で定める。各セルの局所規則は一元集合 ", math(String.raw`N_{\circlearrowright}(v)`),
        " 上の入力を ", math(String.raw`s(v)`), " で評価する有限真理値表なので、",
        math(String.raw`F\in\mathcal M(V_{\circlearrowright},N_{\circlearrowright})`), " である（",
        ref("def_stage_global_maps"), "）。",
      ]),
    ],
  },

  {
    id: "fixed_neighborhood_composition_nonclosure_claim_shift_is_reversible",
    kind: "claim",
    title: { text: "座標送り写像は可逆である" },
    labels: ["claim_three_cell_cyclic_shift_reversible"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_three_cell_cyclic_dependency_stage"), " の大域写像 ", math(String.raw`F`), " は全単射であり、",
        math(String.raw`F\in\mathcal M^{\times}(V_{\circlearrowright},N_{\circlearrowright})`), " である（",
        ref("def_stage_reversible_global_maps"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        "写像 ", math(String.raw`G:A^{V_{\circlearrowright}}\to A^{V_{\circlearrowright}}`), " を ",
        math(String.raw`(Gx)(v):=x(s(s(v)))`), " で定める。",
        ref("def_three_cell_cyclic_dependency_stage"), " の三つの値を順に代入すると、全ての ",
        math(String.raw`v\in V_{\circlearrowright}`), " で ", math(String.raw`s(s(s(v)))=v`), " である。よって任意の ",
        math(String.raw`x\in A^{V_{\circlearrowright}}`), " と ", math(String.raw`v\in V_{\circlearrowright}`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
((F\circ G)x)(v)
&=(Gx)(s(v))\qquad(\because\ \blkref{def_three_cell_cyclic_dependency_stage})\\
&=x(s(s(s(v))))\qquad(\because\ G\ \text{の定義})\\
&=x(v)\qquad(\because\ s(s(s(v)))=v),\\[4pt]
((G\circ F)x)(v)
&=(Fx)(s(s(v)))\qquad(\because\ G\ \text{の定義})\\
&=x(s(s(s(v))))\qquad(\because\ \blkref{def_three_cell_cyclic_dependency_stage})\\
&=x(v)\qquad(\because\ s(s(s(v)))=v)
\end{aligned}`),
      paragraph([
        "が成り立つ。写像の外延性より ", math(String.raw`F\circ G=\mathrm{id}`), " かつ ",
        math(String.raw`G\circ F=\mathrm{id}`), " なので ", math(String.raw`F`), " は全単射である。",
      ]),
    ],
  },

  {
    id: "fixed_neighborhood_composition_nonclosure_claim_reversible_maps_not_closed",
    kind: "claim",
    title: { text: "固定近傍で表せる可逆大域写像は合成で閉じるとは限らない" },
    labels: ["claim_fixed_neighborhood_reversible_maps_not_composition_closed"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_three_cell_cyclic_dependency_stage"), " の有限舞台では ",
        math(String.raw`F\in\mathcal M^{\times}(V_{\circlearrowright},N_{\circlearrowright})`), " である一方、",
      ]),
      displayMath(String.raw`F\circ F\notin\mathcal M(V_{\circlearrowright},N_{\circlearrowright})`),
      paragraph([
        "である。したがって ", math(String.raw`\mathcal M^{\times}(V,N)`),
        " は一般の有限舞台 ", math(String.raw`(V,N)`), " について合成で閉じるとは限らず、群とは限らない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_three_cell_cyclic_shift_reversible"), " により最初の所属は成り立つ。写像 ",
        math(String.raw`g_a:A^{V_{\circlearrowright}}\to A`), " を ",
        math(String.raw`g_a(x):=((F\circ F)x)(a)`), " で定める。任意の ",
        math(String.raw`x\in A^{V_{\circlearrowright}}`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
g_a(x)
&=(F(Fx))(a)\qquad(\because\ g_a\ \text{と写像の合成の定義})\\
&=(Fx)(b)\qquad(\because\ \blkref{def_three_cell_cyclic_dependency_stage}\ \text{の}\ s(a)=b)\\
&=x(c)\qquad(\because\ \blkref{def_three_cell_cyclic_dependency_stage}\ \text{の}\ s(b)=c)
\end{aligned}`),
      paragraph([
        "である。定値零配位 ", math(String.raw`x_0\in A^{V_{\circlearrowright}}`), " を ",
        math(String.raw`x_0(v):=0`), " で定め、", ref("def_flip_map"), " の一点反転写像で ",
        math(String.raw`x_1:=\varphi_c x_0`), " と置く。このとき ",
        math(String.raw`x_0(c)=0`), " かつ ", math(String.raw`x_1(c)=1`), " なので、上の等式から",
      ]),
      displayMath(String.raw`g_a(x_0)=0\neq1=g_a(x_1)`),
      paragraph([
        "である。よって ", ref("def_essential_dependency"), " と ",
        ref("def_essential_dependency_support"), " により ",
        math(String.raw`c\in\operatorname{supp}(g_a)`), " である。一方、",
        ref("def_three_cell_cyclic_dependency_stage"), " により ",
        math(String.raw`N_{\circlearrowright}(a)=\{b\}`), " かつ ", math(String.raw`c\notin\{b\}`),
        " なので ", math(String.raw`\operatorname{supp}(g_a)\nsubseteq N_{\circlearrowright}(a)`), " である。",
      ]),
      paragraph([
        math(String.raw`F\circ F\in\mathcal M(V_{\circlearrowright},N_{\circlearrowright})`),
        " と仮定すると、その ", math(String.raw`a`), " 座標写像 ", math(String.raw`g_a`),
        " は ", math(String.raw`N_{\circlearrowright}(a)`), " 上の局所規則で表せる。すると ",
        ref("claim_representable_implies_support_subset"), " により ",
        math(String.raw`\operatorname{supp}(g_a)\subseteq N_{\circlearrowright}(a)`),
        " となり、直前の非包含と矛盾する。したがって仮定は偽である。",
      ]),
    ],
  },
]);
