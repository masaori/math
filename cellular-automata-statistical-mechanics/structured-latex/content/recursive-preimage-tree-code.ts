/**
 * 章「周期成分に付随する再帰的前像木符号」。
 * 有限自己写像の周期辺を除いて得る前像木を、各頂点の非周期一段前像の符号の
 * 多重集合として葉から再帰的に符号化し、周期軌道を基点語の集合、写像全体を
 * その多重集合として符号化する。共役不変性と、符号一致から共役全単射を
 * 再帰構成する完全性、有限決定までを有限表から直接示す。
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
        "有限集合上の自己写像 ", math(String.raw`F:X\to X`),
        " と元 ", math(String.raw`y\in X`), " に対し、有限集合",
      ]),
      displayMath(String.raw`C_F(y):=\{\,z\in X\mid F(z)=y\ \text{かつ}\ z\notin\mathrm{Per}(F)\,\}`),
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
        "各 ", math(String.raw`y\in X`), " と各 ", math(String.raw`z\in C_F(y)`),
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
    title: { text: "最小前周期は元の個数より小さい" },
    labels: ["claim_recursive_preimage_tree_code_preperiod_upper_bound"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`y\in X`), " について ",
        math(String.raw`\mu(y)\le |X|-1`), " である。",
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
&\le |X|\quad(\because\ \blkref{claim_min_preperiod_period_bound})
\end{aligned}`),
      paragraph([
        "移項により ", math(String.raw`\mu(y)\le |X|-1`), " を得る。",
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
        math(String.raw`\mu(y)=|X|-1-j`), " を満たす各元 ", math(String.raw`y\in X`),
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
        math(String.raw`j=0`), " のとき ", math(String.raw`\mu(z)=|X|`), " は ",
        ref("claim_recursive_preimage_tree_code_preperiod_upper_bound"),
        " に反するので ", math(String.raw`C_F(y)`), " は空集合であり、",
        math(String.raw`c_F(y)=\{\!\{\,\}\!\}\in\mathbb M_0`), " である。",
        math(String.raw`j+1`), " のときは各 ", math(String.raw`z\in C_F(y)`), " が ",
        math(String.raw`\mu(z)=|X|-1-j`), " を満たし、帰納法の仮定により ",
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
      displayMath(String.raw`O_F(q):=\{\,F^n(q)\mid n\in\mathbb N\,\}\subseteq X`),
      paragraph([
        "と定め（", ref("def_global_map_iterate"), "）、周期軌道の集合を",
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
        "自己写像 ", math(String.raw`F`), " の符号を、有限多重集合",
      ]),
      displayMath(String.raw`\mathcal K(F):=\{\!\{\,K_F(O)\mid O\in\mathcal O_F\,\}\!\}`),
      paragraph([
        "と定める（", ref("def_recursive_preimage_tree_code_component_code"), "、",
        ref("def_recursive_preimage_tree_code_periodic_orbits"),
        "。相異なる軌道の成分符号が一致する場合も重複を保って数える）。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_conjugacy_invariance_claim",
    kind: "claim",
    title: { text: "共役全単射は再帰的前像木符号を保存する" },
    labels: ["claim_recursive_preimage_tree_code_conjugacy_invariance"],
    habitat: "countable",
    statement: [
      paragraph([
        "有限集合上の二つの自己写像 ",
        math(String.raw`F:X\to X`), " と ", math(String.raw`G:Y\to Y`),
        " の間に共役全単射 ", math(String.raw`h:X\to Y`), "（",
        ref("def_iterate_monoid_conjugacy_bijection"), "）が存在するなら、",
      ]),
      displayMath(String.raw`\mathcal K(F)=\mathcal K(G)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_conjugacy_transports_iterates"), " により、各 ",
        math(String.raw`y\in X`), " と各 ", math(String.raw`n\in\mathbb N`), " について ",
        math(String.raw`h(F^n(y))=G^n(h(y))`), " である。したがって各 ",
        math(String.raw`y\in X`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
h(y)\in\mathrm{Per}(G)
&\Longleftrightarrow \text{ある}\ n\in\mathbb N_{>0}\ \text{について}\ G^n(h(y))=h(y)
  \quad(\because\ \blkref{def_periodic_points})\\
&\Longleftrightarrow \text{ある}\ n\in\mathbb N_{>0}\ \text{について}\ h(F^n(y))=h(y)
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&\Longleftrightarrow \text{ある}\ n\in\mathbb N_{>0}\ \text{について}\ F^n(y)=y
  \quad(\because\ h\ \text{は単射})\\
&\Longleftrightarrow y\in\mathrm{Per}(F)
  \quad(\because\ \blkref{def_periodic_points}).
\end{aligned}`),
      paragraph(["この同値と共役条件、", math(String.raw`h`), " の全単射性により各 ", math(String.raw`y\in X`), " について"]),
      displayMath(String.raw`h(C_F(y))=C_G(h(y))\quad(\because\ \blkref{def_recursive_preimage_tree_code_children})`),
      paragraph([
        "である。最小前周期の大きい側からの帰納法で ",
        math(String.raw`c_F(y)=c_G(h(y))`), " を示す。非周期一段前像が空なら両辺は空多重集合である。",
        "各非周期一段前像で等号が成り立つと仮定すると、上の集合の全単射と多重集合の定義により",
      ]),
      displayMath(String.raw`\begin{aligned}
c_F(y)
&=\{\!\{\,c_F(z)\mid z\in C_F(y)\,\}\!\}
  \quad(\because\ \blkref{def_recursive_preimage_tree_code})\\
&=\{\!\{\,c_G(h(z))\mid z\in C_F(y)\,\}\!\}
  \quad(\because\ \text{帰納法の仮定})\\
&=\{\!\{\,c_G(u)\mid u\in C_G(h(y))\,\}\!\}
  \quad(\because\ h(C_F(y))=C_G(h(y)))\\
&=c_G(h(y))
  \quad(\because\ \blkref{def_recursive_preimage_tree_code}).
\end{aligned}`),
      paragraph([
        "よって周期軌道上の対応する基点語は等しい。", math(String.raw`h`),
        " は周期軌道を全単射に移すので成分符号を保存し、さらに周期軌道全体を全単射に移すので、",
        ref("def_recursive_preimage_tree_code_map_code"), " の有限多重集合も保存する。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_completeness_claim",
    kind: "claim",
    title: { text: "等しい写像符号から共役全単射を再帰構成できる" },
    labels: ["claim_recursive_preimage_tree_code_completeness"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の二つの自己写像 ",
        math(String.raw`F:X\to X`), " と ", math(String.raw`G:Y\to Y`), " について",
      ]),
      displayMath(String.raw`\mathcal K(F)=\mathcal K(G)`),
      paragraph([
        "ならば、共役全単射 ", math(String.raw`h:X\to Y`),
        " を有限回の選択と再帰だけで構成できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_recursive_preimage_tree_code_map_code"), " の多重集合の等号により、",
        math(String.raw`F`), " の各周期軌道を、同じ成分符号を持つ ", math(String.raw`G`),
        " の周期軌道へ重複度を保って一対一に対応させる。対応する軌道 ",
        math(String.raw`O\in\mathcal O_F`), " と ", math(String.raw`P\in\mathcal O_G`),
        " を固定する。成分符号の等号により、等しい基点語 ",
        math(String.raw`w_F(q)=w_G(r)`), " を持つ ", math(String.raw`q\in O`),
        " と ", math(String.raw`r\in P`), " を選べる。有限列の等号により長さも等しいので、",
        math(String.raw`\pi(q)=\pi(r)`), " である。各 ",
        math(String.raw`0\le n<\pi(q)`), " について周期点を",
      ]),
      displayMath(String.raw`h(F^n(q)):=G^n(r)`),
      paragraph([
        "と対応させる。この対応は二つの周期軌道の全単射であり、周期辺上で ",
        math(String.raw`h\circ F=G\circ h`), " を満たす。",
      ]),
      paragraph([
        "次に、対応済みの二点 ", math(String.raw`y\in X`), " と ",
        math(String.raw`u\in Y`), " が ", math(String.raw`c_F(y)=c_G(u)`),
        " を満たすとする。再帰符号の等号は、子符号ごとの重複度を含めた多重集合の等号だから、",
        math(String.raw`C_F(y)`), " の各元を、同じ符号を持つ ", math(String.raw`C_G(u)`),
        " の元へ一対一に対応させられる。各対応する子の組に同じ操作を繰り返す。",
        ref("claim_recursive_preimage_tree_code_child_preperiod_increment"),
        " により一段下るたびに最小前周期が一つ増え、",
        ref("claim_recursive_preimage_tree_code_preperiod_upper_bound"),
        " により増加回数は有限なので、この再帰は必ず空の子集合で止まる。",
      ]),
      paragraph([
        "こうして各対応する周期点に流入する非周期点の間に全単射を得る。",
        "異なる子が始める部分木は交わらない。実際、一点が二つの異なる子へそれぞれ ",
        math(String.raw`a,b\in\mathbb N`), " 回で到達するなら、",
        ref("claim_recursive_preimage_tree_code_child_preperiod_increment"),
        " を経路に沿って繰り返して ", math(String.raw`\mu(z)=\mu(y)+1+a=\mu(y)+1+b`),
        " となるので ", math(String.raw`a=b`), " である。決定的な写像の同じ回数の反復値は一意なので、",
        "二つの子は等しくなり矛盾する。",
        "また有限集合上の軌道の最終周期性（", ref("claim_eventual_periodicity"),
        "）により、全ての元はただ一つの周期軌道へ到達する。したがって全周期成分で得た対応は互いに交わらず、",
        "合わせると全単射 ", math(String.raw`h:X\to Y`), " になる。",
      ]),
      paragraph([
        "非周期点 ", math(String.raw`z`), " は、その親 ", math(String.raw`F(z)`),
        " の子として対応させたので ", math(String.raw`G(h(z))=h(F(z))`),
        " である。周期点では上の周期辺の対応により同じ等号が成り立つ。ゆえに全ての ",
        math(String.raw`z\in X`), " について ",
        math(String.raw`h(F(z))=G(h(z))`), " であり、", math(String.raw`h`),
        " は共役全単射である。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_complete_invariant_claim",
    kind: "claim",
    title: { text: "再帰的前像木符号は共役の完全不変量である" },
    labels: ["claim_recursive_preimage_tree_code_complete_invariant"],
    habitat: "countable",
    statement: [
      paragraph([
        "有限集合上の二つの自己写像 ",
        math(String.raw`F:X\to X`), " と ", math(String.raw`G:Y\to Y`), " について",
      ]),
      displayMath(String.raw`\mathcal K(F)=\mathcal K(G)
\quad\Longleftrightarrow\quad
F\ \text{から}\ G\ \text{への共役全単射が存在する}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "共役全単射が存在すれば ", ref("claim_recursive_preimage_tree_code_conjugacy_invariance"),
        " により符号は等しい。符号が等しければ ",
        ref("claim_recursive_preimage_tree_code_completeness"), " により共役全単射を構成できる。",
      ]),
    ],
  },
  {
    id: "recursive_preimage_tree_code_finite_decidability_claim",
    kind: "claim",
    title: { text: "再帰的前像木符号と共役は有限決定できる" },
    labels: ["claim_recursive_preimage_tree_code_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の二つの自己写像について、各写像符号の計算、符号の等号、",
        "共役全単射の存在、および符号が等しい場合の共役全単射の一つの構成は、",
        "二つの自己写像の有限表から有限回の走査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_finite_decidability"), " の冒頭の有限走査により、各自己写像の有限表から有限な元集合上の",
        "自己写像表を作れる。", ref("claim_min_preperiod_period_finite_decidability"),
        " により各元の最小前周期と最小周期を有限走査できるので、周期点、非周期一段前像、周期軌道を全て列挙できる。",
        ref("claim_recursive_preimage_tree_code_preperiod_upper_bound"),
        " の有限上界から最小前周期の大きい順に各再帰符号を計算し、各周期軌道の有限個の基点語、",
        "成分符号、写像符号を順に作れる。有限列・有限集合・有限多重集合の等号はいずれも有限比較で決まる。",
        "符号が等しい場合は ", ref("claim_recursive_preimage_tree_code_completeness"),
        " の各有限多重集合の一致から対応を選ぶ再帰により共役全単射を構成できる。",
        "符号が異なる場合は ", ref("claim_recursive_preimage_tree_code_complete_invariant"),
        " により共役全単射は存在しない。よって全て有限決定できる。",
      ]),
    ],
  },
]);
