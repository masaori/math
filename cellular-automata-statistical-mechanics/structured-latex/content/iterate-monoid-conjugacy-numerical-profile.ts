/**
 * 章「安定ファイバー根付き木族の数値プロファイルは共役を決定しない」。
 * 共役で保存される深さ別個数と分岐個数分布を数値プロファイルとして束ね、
 * それが完全不変量ではない 8 元上の反例と、共役自体の有限決定を記述する。
 * 有限集合、自然数、写像の等号だけを使い、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_conjugacy_numerical_profile_heading",
    kind: "heading",
    level: 1,
    title: { text: "安定ファイバー根付き木族の数値プロファイルは共役を決定しない" },
    labels: [],
  },
  {
    id: "iterate_monoid_conjugacy_numerical_profile_definition",
    kind: "definition",
    title: { text: "安定ファイバー根付き木族の数値プロファイル" },
    labels: ["def_iterate_monoid_conjugacy_numerical_profile"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合上の自己写像 ", math(String.raw`F:X\to X`),
        " に対し、各 ", math(String.raw`q\in Q_F`), " と ", math(String.raw`z\in B_F(q)`), " について",
      ]),
      displayMath(String.raw`b_F(q,z):=\left|\{\,y\in B_F(q)\mid (y,z)\in T_F(q)\,\}\right|\in\mathbb N`),
      paragraph([
        "と置く。", math(String.raw`q`), " の深さ別個数列と分岐個数多重集合をそれぞれ",
      ]),
      displayMath(String.raw`\mathcal L_F(q):=\left(\left|\{y\in B_F(q)\mid d_F(y)=k\}\right|\right)_{k=0}^{m_F},\qquad
\mathcal B_F(q):=\{\!\{\,b_F(q,z)\mid z\in B_F(q)\,\}\!\}`),
      paragraph(["と定め、"]),
      displayMath(String.raw`\mathcal P(F):=\left(\mu_F,\lambda_F,|Q_F|,
\{\!\{\,(\mathcal L_F(q),\mathcal B_F(q))\mid q\in Q_F\,\}\!\}\right)`),
      paragraph([
        "を数値プロファイルと呼ぶ。ここで ", math(String.raw`\mu_F,\lambda_F,Q_F,B_F(q),T_F(q),d_F`),
        " はそれぞれ ", ref("def_iterate_monoid_collision_start"), "、",
        ref("def_iterate_monoid_minimal_positive_period"), "、", ref("def_iterate_monoid_stable_image"), "、",
        ref("def_iterate_monoid_stable_fiber"), "、", ref("def_iterate_monoid_fiber_tree_edges"), "、",
        ref("def_iterate_monoid_fiber_tree_depth"), " で定めた対象である。多重集合は値の重複を保って数える。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_numerical_profile_invariance_claim",
    kind: "claim",
    title: { text: "数値プロファイルは共役で保存される" },
    labels: ["claim_iterate_monoid_conjugacy_numerical_profile_invariant"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_conjugacy_bijection"), " の共役全単射が ", math(String.raw`F`), " と ",
        math(String.raw`G`), " の間に存在するなら、", math(String.raw`\mathcal P(F)=\mathcal P(G)`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_conjugacy_preserves_collision_start"), " と ",
        ref("claim_iterate_monoid_conjugacy_preserves_minimal_period"), " により ",
        math(String.raw`\mu_F=\mu_G`), " かつ ", math(String.raw`\lambda_F=\lambda_G`), " である。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_conjugacy_transports_cycle_idempotent"), " により ",
        math(String.raw`e_F=e_G`), " でもある。", ref("def_iterate_monoid_root_reach_exponent"), " の ",
        math(String.raw`e_F=m_F\lambda_F`), " と ", math(String.raw`e_G=m_G\lambda_G`),
        "、および正の自然数による乗法の簡約則から ", math(String.raw`m_F=m_G`), " である。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_conjugacy_transports_stable_image"), " により ", math(String.raw`h`),
        " は ", math(String.raw`Q_F`), " から ", math(String.raw`Q_G`), " への全単射なので ",
        math(String.raw`|Q_F|=|Q_G|`), " である。",
      ]),
      paragraph([
        "各 ", math(String.raw`q\in Q_F`), " について、",
        ref("claim_iterate_monoid_conjugacy_transports_stable_fibers"), " は ",
        math(String.raw`B_F(q)`), " と ", math(String.raw`B_G(h(q))`), " を全単射に対応させる。さらに ",
        ref("claim_iterate_monoid_conjugacy_preserves_tree_depth"), " は対応する各元の深さを保つので ",
        math(String.raw`\mathcal L_F(q)=\mathcal L_G(h(q))`), " である。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_conjugacy_preserves_tree_branching"), " は対応する各元の分岐個数を保つので ",
        math(String.raw`\mathcal B_F(q)=\mathcal B_G(h(q))`), " である。したがって安定像上の多重集合も等しく、",
        ref("def_iterate_monoid_conjugacy_numerical_profile"), " の全成分が等しい。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_numerical_profile_counterexample_definition",
    kind: "definition",
    title: { text: "八元上の二つの自己写像" },
    labels: ["def_iterate_monoid_conjugacy_numerical_profile_counterexample"],
    habitat: "finite",
    statement: [
      paragraph([
        "8 元集合 ", math(String.raw`X`), " の元を ",
        math(String.raw`x_0,x_1,\ldots,x_7`), " と名付ける。二つの写像 ",
        math(String.raw`F,G:X\to X`), " を次の有限表で定める。",
      ]),
      displayMath(String.raw`\begin{array}{c|cccccccc}
y&x_0&x_1&x_2&x_3&x_4&x_5&x_6&x_7\\ \hline
F(y)&x_0&x_0&x_0&x_1&x_1&x_2&x_4&x_7\\
G(y)&x_0&x_0&x_0&x_1&x_1&x_2&x_5&x_7
\end{array}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_numerical_profile_counterexample_ca_specialization",
    kind: "claim",
    title: { text: "八元反例は三セル二値セルオートマトンとして実現できる" },
    labels: ["claim_iterate_monoid_conjugacy_numerical_profile_counterexample_ca_specialization"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_conjugacy_numerical_profile_counterexample"),
        " の二つの自己写像は、三元舞台の全近傍二値セルオートマトンの大域写像として実現できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`|V|=3`), " なら ", math(String.raw`|A^V|=8`), " である。",
        math(String.raw`X`), " と ", math(String.raw`A^V`), " の間の全単射で二つの自己写像を移し、",
        ref("claim_all_self_maps_binary_ca_full_neighborhood_specialization"), " をそれぞれに適用する。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_numerical_profile_counterexample_claim",
    kind: "claim",
    title: { text: "同じ数値プロファイルをもつ非共役な二つの自己写像が存在する" },
    labels: ["claim_iterate_monoid_conjugacy_numerical_profile_not_complete"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_conjugacy_numerical_profile_counterexample"), " の ", math(String.raw`F,G`),
        " は ", math(String.raw`\mathcal P(F)=\mathcal P(G)`), " を満たすが、両者の間に共役全単射は存在しない。",
      ]),
    ],
    proof: [
      paragraph(["表を一行ずつ合成すると、両写像について"]),
      displayMath(String.raw`F^2(x_6)=x_1\ne x_0=F^3(x_6),\qquad
G^2(x_6)=x_2\ne x_0=G^3(x_6)`),
      paragraph([
        "であり、他方で全ての ", math(String.raw`y\in X`), " について ",
        math(String.raw`F^3(y)=F^4(y)`), " かつ ", math(String.raw`G^3(y)=G^4(y)`),
        " である。さらに ", math(String.raw`F^0(x_1)=G^0(x_1)=x_1`), " だが正の反復では両方とも ",
        math(String.raw`x_0`), " へ移るので、反復回数 0 からの衝突はない。反復回数 1 については",
      ]),
      displayMath(String.raw`F(x_6)=x_4,\quad F^2(x_6)=x_1,\quad F^n(x_6)=x_0\ (n\ge3),`),
      displayMath(String.raw`G(x_6)=x_5,\quad G^2(x_6)=x_2,\quad G^n(x_6)=x_0\ (n\ge3)`),
      paragraph([
        "なので後続のどの反復写像とも等しくない。反復回数 2 も同じ二行の ",
        math(String.raw`x_1\ne x_0`), " と ", math(String.raw`x_2\ne x_0`),
        " により後続の反復写像と等しくない。したがって ", math(String.raw`\mu_F=\mu_G=3`),
        " であり、最初の再出現が一段後なので ", math(String.raw`\lambda_F=\lambda_G=1`), " である。",
      ]),
      paragraph([
        math(String.raw`E_F=F^3`), " と ", math(String.raw`E_G=G^3`), " の像はいずれも ",
        math(String.raw`\{x_0,x_7\}`), " であり、安定ファイバーはいずれも ",
        math(String.raw`B(x_0)=\{x_0,x_1,\ldots,x_6\}`), " と ",
        math(String.raw`B(x_7)=\{x_7\}`), " の二つである。",
      ]),
      paragraph(["大きい安定ファイバーの深さ別個数列と分岐個数多重集合は、両写像でそれぞれ"]),
      displayMath(String.raw`(1,2,3,1),\qquad \{\!\{0,0,0,1,1,2,2\}\!\}`),
      paragraph([
        "である。単元安定ファイバーでは、", ref("def_iterate_monoid_conjugacy_numerical_profile"),
        " の深さ別個数列の添字が ", math(String.raw`k=0`), " から ", math(String.raw`m_F=m_G=3`),
        " まで走り、深さ 0 の元が根の 1 個だけなので、両写像とも ", math(String.raw`(1,0,0,0)`), " と ",
        math(String.raw`\{\!\{0\}\!\}`), " である。したがって ",
        ref("def_iterate_monoid_conjugacy_numerical_profile"), " により ",
        math(String.raw`\mathcal P(F)=\mathcal P(G)`), " である。",
      ]),
      paragraph([
        "非共役性を示す。大きい根付き木で根 ", math(String.raw`x_0`), " の直前の頂点は両写像とも ",
        math(String.raw`x_1,x_2`), " である。ある頂点へ有限回の反復で到達する元全体をその頂点の子孫集合と呼ぶ。",
        math(String.raw`F`), " では ", math(String.raw`x_1,x_2`), " の子孫集合はそれぞれ",
      ]),
      displayMath(String.raw`\{x_1,x_3,x_4,x_6\},\qquad\{x_2,x_5\}`),
      paragraph(["で個数は 4 と 2 である。一方、", math(String.raw`G`), " ではそれぞれ"]),
      displayMath(String.raw`\{x_1,x_3,x_4\},\qquad\{x_2,x_5,x_6\}`),
      paragraph([
        "で個数は 3 と 3 である。共役全単射は ",
        ref("claim_iterate_monoid_conjugacy_transports_tree_edges"), " により根付き辺を保存し反映し、",
        ref("claim_iterate_monoid_conjugacy_transports_one_period_iterates"),
        " により有限反復での到達も保存し反映する。したがって根の直前の二頂点を全単射に対応させ、",
        "その子孫集合の個数の多重集合も保たなければならない。しかし ",
        math(String.raw`\{\!\{4,2\}\!\}\ne\{\!\{3,3\}\!\}`), " なので、そのような共役全単射は存在しない。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_finite_decidability_claim",
    kind: "claim",
    title: { text: "有限自己写像の共役は有限決定できる" },
    labels: ["claim_iterate_monoid_conjugacy_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "二つの有限集合上の自己写像の有限表から、その自己写像の間に共役全単射が存在するかを有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        "まず二つの台集合の元数を比較する。異なれば全単射は存在しない。等しければ、二つの有限集合の間の全単射を全て列挙する。",
        "各候補 ", math(String.raw`h`), " について、全ての元 ", math(String.raw`y`), " で ",
        math(String.raw`h(F(y))=G(h(y))`), " かを有限表から検査する。全候補が不成立なら共役は存在せず、",
        "一つでも成立すれば ", ref("def_iterate_monoid_conjugacy_bijection"), " の共役全単射である。",
      ]),
      paragraph([
        "この手続きは有限集合と自然数だけで閉じ、実数、複素数、極限、完備化を使わない。",
      ]),
    ],
  },
]);
