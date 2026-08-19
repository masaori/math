/**
 * 章「周期成分に付随する再帰的前像木符号」。
 * 有限自己写像の周期辺を除いて得る前像木を、各頂点の非周期一段前像の符号の
 * 多重集合として葉から再帰的に符号化し、周期軌道を基点語の集合、写像全体を
 * その多重集合として符号化する。本章は定義と再帰の well-defined 性までを置き、
 * 共役不変性・完全性・有限決定は後続で扱う。
 * 有限集合、自然数、写像の等号と入れ子有限多重集合だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "recursive_preimage_tree_code_heading",
    kind: "heading",
    level: 1,
    title: { text: "周期成分に付随する再帰的前像木符号" },
    labels: [],
  },
  {
    id: "recursive_preimage_tree_code_multiset_hierarchy_definition",
    kind: "definition",
    title: { text: "入れ子有限多重集合の階層" },
    labels: ["def_recursive_preimage_tree_code_multiset_hierarchy"],
    habitat: "countable",
    statement: [
      paragraph([
        "空多重集合を ", math(String.raw`\{\!\{\,\}\!\}`), " と書く。集合の列 ",
        math(String.raw`(\mathbb M_k)_{k\in\mathbb N}`), " を",
      ]),
      displayMath(String.raw`\mathbb M_0:=\{\,\{\!\{\,\}\!\}\,\},\qquad
\mathbb M_{k+1}:=\{\,m\mid m\ \text{は}\ \mathbb M_k\ \text{の元だけを要素とする有限多重集合}\,\}`),
      paragraph([
        "と定める。多重集合は要素の重複を保って数え、順序を持たない。各 ",
        math(String.raw`k\in\mathbb N`), " について空多重集合はその要素条件を空虚に満たすので ",
        math(String.raw`\{\!\{\,\}\!\}\in\mathbb M_k`), " である。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_children_definition",
    kind: "definition",
    title: { text: "非周期一段前像" },
    labels: ["def_recursive_preimage_tree_code_children"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台上の 2 値セルオートマトンの大域写像 ", math(String.raw`F:A^V\to A^V`),
        " と配位 ", math(String.raw`y\in A^V`), " に対し、有限集合",
      ]),
      displayMath(String.raw`C_F(y):=\{\,z\in A^V\mid F(z)=y\ \text{かつ}\ z\notin\mathrm{Per}(F)\,\}`),
      paragraph([
        "を ", math(String.raw`y`), " の非周期一段前像の集合と呼ぶ。ここで ",
        math(String.raw`\mathrm{Per}(F)`), " は ", ref("def_periodic_points"),
        " の周期点集合である。周期点から出る辺 ",
        math(String.raw`(q,F(q))\ (q\in\mathrm{Per}(F))`),
        " を除いた前像関係だけを残すことに当たる。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_child_preperiod_increment_claim",
    kind: "claim",
    title: { text: "非周期一段前像の最小前周期は一つ大きい" },
    labels: ["claim_recursive_preimage_tree_code_child_preperiod_increment"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in A^V`), " と各 ", math(String.raw`z\in C_F(y)`),
        " について ", math(String.raw`\mu(z)=\mu(y)+1`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_recursive_preimage_tree_code_children"), " により ",
        math(String.raw`F(z)=y`), " かつ ", math(String.raw`z\notin\mathrm{Per}(F)`), " である。",
        ref("claim_periodic_iff_min_preperiod_zero"), " の対偶により ",
        math(String.raw`\mu(z)\ne0`), " であり、", math(String.raw`\mathbb N`),
        " の元なので ", math(String.raw`\mu(z)>0`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)&=\mu(F(z))\quad(\because\ F(z)=y)\\
&=\mu(z)-1\quad(\because\ \blkref{claim_iterate_monoid_min_preperiod_decrements}\ \text{を}\ z\ \text{へ適用},\ \mu(z)>0)
\end{aligned}`),
      paragraph([
        "移項により ", math(String.raw`\mu(z)=\mu(y)+1`), " を得る。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_preperiod_upper_bound_claim",
    kind: "claim",
    title: { text: "最小前周期は配位の個数より小さい" },
    labels: ["claim_recursive_preimage_tree_code_preperiod_upper_bound"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in A^V`), " について ",
        math(String.raw`\mu(y)\le 2^{|V|}-1`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_min_period"), " により ", math(String.raw`(\mu(y),\pi(y))\in P(y)`),
        " であり、", ref("def_periodicity_pairs"), " により ", math(String.raw`\pi(y)\ge1`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mu(y)+1&\le\mu(y)+\pi(y)\quad(\because\ \pi(y)\ge1)\\
&\le 2^{|V|}\quad(\because\ \blkref{claim_min_preperiod_period_bound})
\end{aligned}`),
      paragraph([
        "移項により ", math(String.raw`\mu(y)\le 2^{|V|}-1`), " を得る。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_definition",
    kind: "definition",
    title: { text: "再帰的前像木符号" },
    labels: ["def_recursive_preimage_tree_code"],
    habitat: "countable",
    statement: [
      paragraph([
        math(String.raw`j\in\mathbb N`), " に関する帰納法で、",
        math(String.raw`\mu(y)=2^{|V|}-1-j`), " を満たす各配位 ", math(String.raw`y\in A^V`),
        " に対し、その再帰的前像木符号 ",
        math(String.raw`c_F(y)\in\mathbb M_{j}`), "（", ref("def_recursive_preimage_tree_code_multiset_hierarchy"),
        "）を",
      ]),
      displayMath(String.raw`c_F(y):=\{\!\{\,c_F(z)\mid z\in C_F(y)\,\}\!\}`),
      paragraph([
        "（", ref("def_recursive_preimage_tree_code_children"), " の各元 ",
        math(String.raw`z`), " の符号を重複を保って集めた有限多重集合）と定める。",
        "この帰納法は well-defined である。実際、各 ", math(String.raw`z\in C_F(y)`),
        " は ", math(String.raw`\mu(z)=\mu(y)+1`), " を満たす（",
        ref("claim_recursive_preimage_tree_code_child_preperiod_increment"), "）。",
        math(String.raw`j=0`), " のとき ", math(String.raw`\mu(z)=2^{|V|}`), " は ",
        ref("claim_recursive_preimage_tree_code_preperiod_upper_bound"),
        " に反するので ", math(String.raw`C_F(y)`), " は空集合であり、",
        math(String.raw`c_F(y)=\{\!\{\,\}\!\}\in\mathbb M_0`), " である。",
        math(String.raw`j+1`), " のときは各 ", math(String.raw`z\in C_F(y)`), " が ",
        math(String.raw`\mu(z)=2^{|V|}-1-j`), " を満たし、帰納法の仮定により ",
        math(String.raw`c_F(z)\in\mathbb M_{j}`), " が定義済みなので、",
        ref("def_recursive_preimage_tree_code_multiset_hierarchy"), " により ",
        math(String.raw`c_F(y)\in\mathbb M_{j+1}`), " である。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_periodic_orbits_definition",
    kind: "definition",
    title: { text: "周期軌道の集合" },
    labels: ["def_recursive_preimage_tree_code_periodic_orbits"],
    habitat: "finite",
    statement: [
      paragraph([
        "各周期点 ", math(String.raw`q\in\mathrm{Per}(F)`), " に対し、その周期軌道を",
      ]),
      displayMath(String.raw`O_F(q):=\{\,F^n(q)\mid n\in\mathbb N\,\}\subseteq A^V`),
      paragraph([
        "と定め（", ref("def_global_map_iterate"), "。", math(String.raw`A^V`),
        " の部分集合なので有限集合である）、周期軌道の集合を",
      ]),
      displayMath(String.raw`\mathcal O_F:=\{\,O_F(q)\mid q\in\mathrm{Per}(F)\,\}`),
      paragraph(["と定める。"]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_base_word_definition",
    kind: "definition",
    title: { text: "周期点の基点語" },
    labels: ["def_recursive_preimage_tree_code_base_word"],
    habitat: "countable",
    statement: [
      paragraph([
        "各周期点 ", math(String.raw`q\in\mathrm{Per}(F)`), " に対し、その基点語を、長さ ",
        math(String.raw`\pi(q)`), "（", ref("def_min_period"), "）の有限列",
      ]),
      displayMath(String.raw`w_F(q):=\bigl(c_F(F^n(q))\bigr)_{n=0}^{\pi(q)-1}`),
      paragraph([
        "と定める（", ref("def_recursive_preimage_tree_code"), "、",
        ref("def_global_map_iterate"), "）。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_component_code_definition",
    kind: "definition",
    title: { text: "周期軌道の成分符号" },
    labels: ["def_recursive_preimage_tree_code_component_code"],
    habitat: "countable",
    statement: [
      paragraph([
        "各周期軌道 ", math(String.raw`O\in\mathcal O_F`), " に対し、その成分符号を有限集合",
      ]),
      displayMath(String.raw`K_F(O):=\{\,w_F(q)\mid q\in O\,\}`),
      paragraph([
        "と定める（", ref("def_recursive_preimage_tree_code_base_word"), "）。基点 ",
        math(String.raw`q`), " を ", math(String.raw`O`),
        " の全ての元にわたって動かした基点語全体なので、この集合は基点の選び方に依存しない。",
        "周期上の符号列の巡回同値類は、この集合をその代表として表す。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_map_code_definition",
    kind: "definition",
    title: { text: "写像全体の符号" },
    labels: ["def_recursive_preimage_tree_code_map_code"],
    habitat: "countable",
    statement: [
      paragraph([
        "大域写像 ", math(String.raw`F`), " の符号を、有限多重集合",
      ]),
      displayMath(String.raw`\mathcal K(F):=\{\!\{\,K_F(O)\mid O\in\mathcal O_F\,\}\!\}`),
      paragraph([
        "と定める（", ref("def_recursive_preimage_tree_code_component_code"), "、",
        ref("def_recursive_preimage_tree_code_periodic_orbits"),
        "。相異なる軌道の成分符号が一致する場合も重複を保って数える）。",
      ]),
    ],
  },
]);
