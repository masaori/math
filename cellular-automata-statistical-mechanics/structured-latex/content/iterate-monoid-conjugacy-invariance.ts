/**
 * 章「有限自己写像の共役による安定ファイバー根付き木族の不変性」。
 * 二つの有限集合上の自己写像を結ぶ共役全単射が、
 * 最小衝突開始位置・最小正周期・巡回冪等元・安定像・安定ファイバーと、
 * 一周期写像が定める根付き木の辺・深さ・分岐個数を保存することを、
 * 有限集合、自然数、写像の合成と等号だけから導く。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_conjugacy_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限自己写像の共役による安定ファイバー根付き木族の不変性" },
    labels: [],
  },
  {
    id: "iterate_monoid_conjugacy_definition_conjugacy",
    kind: "definition",
    title: { text: "自己写像の共役全単射" },
    labels: ["def_iterate_monoid_conjugacy_bijection"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X,Y`), " と自己写像 ",
        math(String.raw`F:X\to X`), "、",
        math(String.raw`G:Y\to Y`), " に対し、写像 ",
        math(String.raw`h:X\to Y`), " が ", math(String.raw`F`), " から ",
        math(String.raw`G`), " への共役全単射であるとは、",
        math(String.raw`h`), " が全単射であり、かつ",
      ]),
      displayMath(String.raw`h\circ F=G\circ h`),
      paragraph([
        "が成り立つことをいう。以下この章では ",
        math(String.raw`F,G,h`), " を固定する。", math(String.raw`G`),
        " についての反復（", ref("def_finite_self_map_iterate"), "）、衝突開始位置と最小衝突開始位置 ",
        math(String.raw`\mu_G`), "（", ref("def_iterate_monoid_collision_start"),
        "）、正周期の集合 ", math(String.raw`\Pi_G`), " と最小正周期 ",
        math(String.raw`\lambda_G`), "（", ref("def_iterate_monoid_minimal_positive_period"),
        "）、安定後の周期倍数指数 ", math(String.raw`D_G`), "（",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), "）とその最小元 ",
        math(String.raw`e_G`), "（", ref("def_iterate_monoid_minimal_stable_period_multiple"),
        "）、巡回部の冪等元 ", math(String.raw`E_G:=G^{e_G}`), "（",
        ref("def_iterate_monoid_cycle_idempotent_candidate"),
        "）、安定像 ", math(String.raw`Q_G`), "（", ref("def_iterate_monoid_stable_image"),
        "）、安定ファイバー ", math(String.raw`B_G(r)`), "（",
        ref("def_iterate_monoid_stable_fiber"), "）、一周期写像 ",
        math(String.raw`R_G:=G^{\lambda_G}`), "（", ref("def_iterate_monoid_one_period_map"),
        "）、根付き辺集合 ", math(String.raw`T_G(r)`), "（",
        ref("def_iterate_monoid_fiber_tree_edges"), "）と深さ ",
        math(String.raw`d_G(z)`), "（", ref("def_iterate_monoid_fiber_tree_depth"),
        "）は、各定義の ", math(String.raw`F`), " を ", math(String.raw`G`),
        " に置き換えて同じ文で定める。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_iterates",
    kind: "claim",
    title: { text: "共役全単射は反復を移送する" },
    labels: ["claim_iterate_monoid_conjugacy_transports_iterates"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`n\in\mathbb{N}`), " について"]),
      displayMath(String.raw`h\circ F^n=G^n\circ h`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n`), " についての帰納法で示す。写像の等号は各 ",
        math(String.raw`y\in X`), " での値の等号で確かめる。基底 ",
        math(String.raw`n=0`), " では、各 ", math(String.raw`y\in X`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(h\circ F^0)(y)
&=h(F^0\,y)\quad(\because\ \text{写像の合成の定義})\\
&=h(y)\quad(\because\ F^0\,y=y.\ \blkref{def_finite_self_map_iterate})\\
&=G^0(h(y))\quad(\because\ G^0\,z=z.\ \blkref{def_finite_self_map_iterate})\\
&=(G^0\circ h)(y)\quad(\because\ \text{写像の合成の定義}).
\end{aligned}`),
      paragraph([
        "帰納段では ", math(String.raw`h\circ F^n=G^n\circ h`),
        " を仮定する。各 ", math(String.raw`y\in X`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(h\circ F^{n+1})(y)
&=h(F^{n+1}\,y)\quad(\because\ \text{写像の合成の定義})\\
&=h(F(F^n\,y))\quad(\because\ F^{n+1}\,y=F(F^n\,y).\ \blkref{def_finite_self_map_iterate})\\
&=G(h(F^n\,y))\quad(\because\ h\circ F=G\circ h\ \text{を}\ F^n\,y\ \text{で評価する。}\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=G(G^n(h(y)))\quad(\because\ \text{帰納法の仮定を}\ y\ \text{で評価する})\\
&=G^{n+1}(h(y))\quad(\because\ G^{n+1}\,z=G(G^n\,z).\ \blkref{def_finite_self_map_iterate})\\
&=(G^{n+1}\circ h)(y)\quad(\because\ \text{写像の合成の定義}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_reflects_iterate_equality",
    kind: "claim",
    title: { text: "反復写像の等号は共役の両側で同値である" },
    labels: ["claim_iterate_monoid_conjugacy_iterate_equality_equivalence"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`m,n\in\mathbb{N}`), " について"]),
      displayMath(String.raw`F^m=F^n\ \Longleftrightarrow\ G^m=G^n`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`F^m=F^n`), " を仮定する。",
        math(String.raw`z\in Y`), " を任意に取る。", math(String.raw`h`),
        " は全射なので（", ref("def_iterate_monoid_conjugacy_bijection"),
        "）、", math(String.raw`h(y)=z`), " を満たす ", math(String.raw`y\in X`),
        " が存在する。",
      ]),
      displayMath(String.raw`\begin{aligned}
G^m(z)
&=G^m(h(y))\quad(\because\ z=h(y))\\
&=h(F^m(y))\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&=h(F^n(y))\quad(\because\ \text{仮定}\ F^m=F^n)\\
&=G^n(h(y))\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&=G^n(z)\quad(\because\ z=h(y)).
\end{aligned}`),
      paragraph([
        math(String.raw`z`), " は任意なので ", math(String.raw`G^m=G^n`),
        " である。逆に ", math(String.raw`G^m=G^n`), " を仮定する。各 ",
        math(String.raw`y\in X`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
h(F^m(y))
&=G^m(h(y))\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&=G^n(h(y))\quad(\because\ \text{仮定}\ G^m=G^n)\\
&=h(F^n(y))\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates}).
\end{aligned}`),
      paragraph([
        math(String.raw`h`), " は単射なので（",
        ref("def_iterate_monoid_conjugacy_bijection"), "）、",
        math(String.raw`F^m(y)=F^n(y)`), " である。", math(String.raw`y`),
        " は任意なので ", math(String.raw`F^m=F^n`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_preserves_collision_start",
    kind: "claim",
    title: { text: "共役全単射は最小衝突開始位置を保存する" },
    labels: ["claim_iterate_monoid_conjugacy_preserves_collision_start"],
    habitat: "N",
    statement: [
      paragraph([
        "各 ", math(String.raw`n\in\mathbb{N}`), " について、",
        math(String.raw`n`), " が ", math(String.raw`F`),
        " の衝突開始位置であることと ", math(String.raw`G`),
        " の衝突開始位置であることは同値である。したがって",
      ]),
      displayMath(String.raw`\mu_F=\mu_G`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`), " と ",
        math(String.raw`p\in\mathbb{N}_{>0}`), " を任意に取る。",
        ref("claim_iterate_monoid_conjugacy_iterate_equality_equivalence"),
        " を ", math(String.raw`m=n`), "、", math(String.raw`n=n+p`),
        " に適用すると",
      ]),
      displayMath(String.raw`F^n=F^{n+p}\ \Longleftrightarrow\ G^n=G^{n+p}`),
      paragraph([
        "である。よって「ある ", math(String.raw`p\in\mathbb{N}_{>0}`),
        " が存在して ", math(String.raw`F^n=F^{n+p}`),
        "」と「ある ", math(String.raw`p\in\mathbb{N}_{>0}`),
        " が存在して ", math(String.raw`G^n=G^{n+p}`),
        "」は同値であり、", ref("def_iterate_monoid_collision_start"),
        " により ", math(String.raw`F`), " の衝突開始位置の集合と ",
        math(String.raw`G`), " の衝突開始位置の集合は ",
        math(String.raw`\mathbb{N}`), " の部分集合として等しい。等しい空でない自然数集合の最小値は等しいので、",
        ref("def_iterate_monoid_collision_start"), " の最小値として ",
        math(String.raw`\mu_F=\mu_G`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_preserves_minimal_period",
    kind: "claim",
    title: { text: "共役全単射は最小正周期を保存する" },
    labels: ["claim_iterate_monoid_conjugacy_preserves_minimal_period"],
    habitat: "N",
    statement: [
      displayMath(String.raw`\Pi_F=\Pi_G`),
      paragraph(["であり、したがって"]),
      displayMath(String.raw`\lambda_F=\lambda_G`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`p\in\mathbb{N}_{>0}`), " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
p\in\Pi_F
&\Longleftrightarrow F^{\mu_F}=F^{\mu_F+p}\quad(\because\ \blkref{def_iterate_monoid_minimal_positive_period})\\
&\Longleftrightarrow G^{\mu_F}=G^{\mu_F+p}\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_iterate_equality_equivalence})\\
&\Longleftrightarrow G^{\mu_G}=G^{\mu_G+p}\quad(\because\ \mu_F=\mu_G.\ \blkref{claim_iterate_monoid_conjugacy_preserves_collision_start})\\
&\Longleftrightarrow p\in\Pi_G\quad(\because\ \blkref{def_iterate_monoid_minimal_positive_period}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`\Pi_F=\Pi_G`),
        " である。等しい空でない自然数集合の最小値は等しいので、",
        ref("def_iterate_monoid_minimal_positive_period"), " の最小値として ",
        math(String.raw`\lambda_F=\lambda_G`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_cycle_idempotent",
    kind: "claim",
    title: { text: "共役全単射は巡回部の冪等元を移送する" },
    labels: ["claim_iterate_monoid_conjugacy_transports_cycle_idempotent"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`e_F=e_G`),
      paragraph(["であり、かつ"]),
      displayMath(String.raw`h\circ E_F=E_G\circ h`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph(["まず指数の集合の等号を示す。各 ", math(String.raw`n\in\mathbb{N}`), " について"]),
      displayMath(String.raw`\begin{aligned}
n\in D_F
&\Longleftrightarrow \mu_F\le n\ \text{かつ}\ \lambda_F\mid n\quad(\because\ \blkref{def_iterate_monoid_stable_period_multiple_exponents})\\
&\Longleftrightarrow \mu_G\le n\ \text{かつ}\ \lambda_F\mid n\quad(\because\ \mu_F=\mu_G.\ \blkref{claim_iterate_monoid_conjugacy_preserves_collision_start})\\
&\Longleftrightarrow \mu_G\le n\ \text{かつ}\ \lambda_G\mid n\quad(\because\ \lambda_F=\lambda_G.\ \blkref{claim_iterate_monoid_conjugacy_preserves_minimal_period})\\
&\Longleftrightarrow n\in D_G\quad(\because\ \blkref{def_iterate_monoid_stable_period_multiple_exponents}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`D_F=D_G`),
        " である。等しい空でない自然数集合の最小値は等しいので、",
        ref("def_iterate_monoid_minimal_stable_period_multiple"), " の最小値として ",
        math(String.raw`e_F=e_G`), " である。次に、各 ",
        math(String.raw`y\in X`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(h\circ E_F)(y)
&=h(E_F(y))\quad(\because\ \text{写像の合成の定義})\\
&=h(F^{e_F}(y))\quad(\because\ E_F=F^{e_F}.\ \blkref{def_iterate_monoid_cycle_idempotent_candidate})\\
&=G^{e_F}(h(y))\quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&=G^{e_G}(h(y))\quad(\because\ e_F=e_G)\\
&=E_G(h(y))\quad(\because\ E_G=G^{e_G}.\ \blkref{def_iterate_monoid_cycle_idempotent_candidate})\\
&=(E_G\circ h)(y)\quad(\because\ \text{写像の合成の定義}).
\end{aligned}`),
      paragraph([
        math(String.raw`y`), " は任意なので ",
        math(String.raw`h\circ E_F=E_G\circ h`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_stable_image",
    kind: "claim",
    title: { text: "共役全単射は安定像を全単射に移す" },
    labels: ["claim_iterate_monoid_conjugacy_transports_stable_image"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`h(Q_F)=Q_G`),
      paragraph(["である。したがって ", math(String.raw`h|_{Q_F}:Q_F\to Q_G`), " は全単射である。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
h(Q_F)
&=\{h(E_F(y))\mid y\in X\}
  \quad(\because\ \blkref{def_iterate_monoid_stable_image})\\
&=\{E_G(h(y))\mid y\in X\}
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_cycle_idempotent})\\
&=\{E_G(z)\mid z\in Y\}
  \quad(\because\ h:X\to Y\ \text{は全射}.\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=Q_G
  \quad(\because\ \blkref{def_iterate_monoid_stable_image}).
\end{aligned}`),
      paragraph([
        math(String.raw`h`), " は全単射なので、その ", math(String.raw`Q_F`),
        " への制限は像 ", math(String.raw`h(Q_F)=Q_G`), " への全単射である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_stable_fibers",
    kind: "claim",
    title: { text: "共役全単射は安定ファイバーを全単射に移す" },
    labels: ["claim_iterate_monoid_conjugacy_transports_stable_fibers"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`q\in Q_F`), " について"]),
      displayMath(String.raw`h(B_F(q))=B_G(h(q))`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`q\in Q_F`), " と ",
        ref("claim_iterate_monoid_conjugacy_transports_stable_image"), " より ",
        math(String.raw`h(q)\in h(Q_F)=Q_G`), " なので、",
        ref("def_iterate_monoid_stable_fiber"), " により ",
        math(String.raw`B_G(h(q))`), " が定まる。次に ",
        math(String.raw`z\in Y`), " を任意に取る。", math(String.raw`h`),
        " の全射性により、", math(String.raw`z=h(y)`), " を満たす ",
        math(String.raw`y\in X`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\in h(B_F(q))
&\Longleftrightarrow y\in B_F(q)
  \quad(\because\ z=h(y)\ \text{と}\ h\ \text{の単射性})\\
&\Longleftrightarrow E_F(y)=q
  \quad(\because\ \blkref{def_iterate_monoid_stable_fiber})\\
&\Longleftrightarrow h(E_F(y))=h(q)
  \quad(\because\ h\ \text{の単射性})\\
&\Longleftrightarrow E_G(h(y))=h(q)
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_cycle_idempotent})\\
&\Longleftrightarrow z\in B_G(h(q))
  \quad(\because\ z=h(y)\ \text{と}\ \blkref{def_iterate_monoid_stable_fiber}).
\end{aligned}`),
      paragraph([math(String.raw`z`), " は任意なので二つの集合は等しい。"]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_one_period_map",
    kind: "claim",
    title: { text: "共役全単射は一周期写像を移送する" },
    labels: ["claim_iterate_monoid_conjugacy_transports_one_period_map"],
    habitat: "finite",
    statement: [displayMath(String.raw`h\circ R_F=R_G\circ h`)],
    proof: [
      displayMath(String.raw`\begin{aligned}
h\circ R_F
&=h\circ F^{\lambda_F}
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map})\\
&=G^{\lambda_F}\circ h
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_iterates})\\
&=G^{\lambda_G}\circ h
  \quad(\because\ \lambda_F=\lambda_G.\ \blkref{claim_iterate_monoid_conjugacy_preserves_minimal_period})\\
&=R_G\circ h
  \quad(\because\ \blkref{def_iterate_monoid_one_period_map}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_tree_edges",
    kind: "claim",
    title: { text: "共役全単射は根付き辺を保存し反映する" },
    labels: ["claim_iterate_monoid_conjugacy_transports_tree_edges"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`q\in Q_F`), " と ", math(String.raw`y,z\in B_F(q)`), " について"]),
      displayMath(String.raw`(y,z)\in T_F(q)\ \Longleftrightarrow\ (h(y),h(z))\in T_G(h(q))`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`q\in Q_F`), " と ",
        ref("claim_iterate_monoid_conjugacy_transports_stable_image"), " より ",
        math(String.raw`h(q)\in Q_G`), " なので、",
        ref("def_iterate_monoid_fiber_tree_edges"), " により ",
        math(String.raw`T_G(h(q))`), " が定まる。",
      ]),
      displayMath(String.raw`\begin{aligned}
(y,z)\in T_F(q)
&\Longleftrightarrow y\ne q\ \text{かつ}\ z=R_F(y)
  \quad(\because\ \blkref{def_iterate_monoid_fiber_tree_edges})\\
&\Longleftrightarrow h(y)\ne h(q)\ \text{かつ}\ h(z)=h(R_F(y))
  \quad(\because\ h\ \text{の単射性})\\
&\Longleftrightarrow h(y)\ne h(q)\ \text{かつ}\ h(z)=R_G(h(y))
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_one_period_map})\\
&\Longleftrightarrow (h(y),h(z))\in T_G(h(q))
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_stable_fibers}\ \text{と}\ \blkref{def_iterate_monoid_fiber_tree_edges}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_transports_one_period_iterates",
    kind: "claim",
    title: { text: "共役全単射は一周期写像の全反復を移送する" },
    labels: ["claim_iterate_monoid_conjugacy_transports_one_period_iterates"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`n\in\mathbb N`), " について"]),
      displayMath(String.raw`h\circ R_F^n=R_G^n\circ h`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " についての帰納法で示す。基底 ", math(String.raw`n=0`), " では"]),
      displayMath(String.raw`\begin{aligned}
h\circ R_F^0
&=h
  \quad(\because\ R_F^0\ \text{は恒等写像}.\ \blkref{def_finite_self_map_iterate})\\
&=R_G^0\circ h
  \quad(\because\ R_G^0\ \text{は恒等写像}.\ \blkref{def_finite_self_map_iterate}).
\end{aligned}`),
      paragraph([math(String.raw`h\circ R_F^n=R_G^n\circ h`), " を仮定すると"]),
      displayMath(String.raw`\begin{aligned}
h\circ R_F^{n+1}
&=h\circ R_F\circ R_F^n
  \quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=R_G\circ h\circ R_F^n
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_one_period_map})\\
&=R_G\circ R_G^n\circ h
  \quad(\because\ \text{帰納法の仮定})\\
&=R_G^{n+1}\circ h
  \quad(\because\ \blkref{def_finite_self_map_iterate}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_one_period_iterate_power",
    kind: "claim",
    title: { text: "一周期写像の反復は最小正周期の倍数乗に一致する" },
    labels: ["claim_iterate_monoid_conjugacy_one_period_iterate_power"],
    habitat: "finite",
    statement: [
      paragraph(["すべての ", math(String.raw`n\in\mathbb N`), " について、写像 ", math(String.raw`X\to X`), " として"]),
      displayMath(String.raw`R_F^n=F^{n\lambda_F}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " についての帰納法で示す。基底 ", math(String.raw`n=0`), " では"]),
      displayMath(String.raw`\begin{aligned}
R_F^0
&=F^0
  \quad(\because\ \text{どちらも恒等写像}.\ \blkref{def_finite_self_map_iterate})\\
&=F^{0\cdot\lambda_F}
  \quad(\because\ 0\cdot\lambda_F=0).
\end{aligned}`),
      paragraph([math(String.raw`R_F^n=F^{n\lambda_F}`), " を仮定すると"]),
      displayMath(String.raw`\begin{aligned}
R_F^{n+1}
&=R_F\circ R_F^n
  \quad(\because\ \blkref{def_finite_self_map_iterate})\\
&=R_F\circ F^{n\lambda_F}
  \quad(\because\ \text{帰納法の仮定})\\
&=F^{(n+1)\lambda_F}
  \quad(\because\ \blkref{claim_iterate_monoid_one_period_step_composition}).
\end{aligned}`),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_preserves_tree_depth",
    kind: "claim",
    title: { text: "共役全単射は根への深さを保存する" },
    labels: ["claim_iterate_monoid_conjugacy_preserves_tree_depth"],
    habitat: "N",
    statement: [
      paragraph(["すべての ", math(String.raw`q\in Q_F`), " と ", math(String.raw`y\in B_F(q)`), " について"]),
      displayMath(String.raw`d_G(h(y))=d_F(y)`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "まず ", math(String.raw`y\in B_F(q)`), " より ",
        math(String.raw`E_F(y)=q`), " である（",
        ref("def_iterate_monoid_stable_fiber"), "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
E_G(h(y))
&=h(E_F(y))
  \quad(\because\ h\circ E_F=E_G\circ h\ \text{を}\ y\ \text{で評価する。}\ \blkref{claim_iterate_monoid_conjugacy_transports_cycle_idempotent})\\
&=h(q)
  \quad(\because\ E_F(y)=q).
\end{aligned}`),
      paragraph([
        "よって ", ref("claim_iterate_monoid_stable_fiber_unique_representative"),
        " により ", math(String.raw`h(y)`), " の属する安定ファイバーの添字は ",
        math(String.raw`h(q)`), " であり、", ref("def_iterate_monoid_fiber_tree_depth"),
        " により ", math(String.raw`d_G(h(y))=\min\{\,d\in\mathbb N\mid G^{d\lambda_G}(h(y))=h(q)\,\}`),
        " である。次に、各 ", math(String.raw`d\in\mathbb N`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{d\lambda_F}(y)=q
&\Longleftrightarrow R_F^d(y)=q
  \quad(\because\ R_F^d=F^{d\lambda_F}\ \text{を}\ y\ \text{で評価する。}\ \blkref{claim_iterate_monoid_conjugacy_one_period_iterate_power})\\
&\Longleftrightarrow h(R_F^d(y))=h(q)
  \quad(\because\ h\ \text{の単射性})\\
&\Longleftrightarrow R_G^d(h(y))=h(q)
  \quad(\because\ \blkref{claim_iterate_monoid_conjugacy_transports_one_period_iterates}\ \text{を}\ y\ \text{で評価する})\\
&\Longleftrightarrow G^{d\lambda_G}(h(y))=h(q)
  \quad(\because\ R_G^d=G^{d\lambda_G}\ \text{を}\ h(y)\ \text{で評価する。}\ \blkref{claim_iterate_monoid_conjugacy_one_period_iterate_power}).
\end{aligned}`),
      paragraph([
        "よって ", math(String.raw`\{d\in\mathbb N\mid F^{d\lambda_F}(y)=q\}`), " と ",
        math(String.raw`\{d\in\mathbb N\mid G^{d\lambda_G}(h(y))=h(q)\}`),
        " は等しい。前者は ", ref("def_iterate_monoid_fiber_tree_depth"),
        " が示すとおり空でない（", ref("claim_iterate_monoid_one_period_map_reaches_root"),
        "）。等しい空でない自然数集合の最小元は等しいので、",
        ref("def_iterate_monoid_fiber_tree_depth"), " の最小元として ",
        math(String.raw`d_G(h(y))=d_F(y)`), " である。",
      ]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_preserves_tree_branching",
    kind: "claim",
    title: { text: "共役全単射は根付き木の分岐個数を保存する" },
    labels: ["claim_iterate_monoid_conjugacy_preserves_tree_branching"],
    habitat: "N",
    statement: [
      paragraph(["すべての ", math(String.raw`q\in Q_F`), " と ", math(String.raw`z\in B_F(q)`), " について"]),
      displayMath(String.raw`|\{y\in B_F(q)\mid (y,z)\in T_F(q)\}|=|\{w\in B_G(h(q))\mid (w,h(z))\in T_G(h(q))\}|`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_conjugacy_transports_stable_fibers"), " により ",
        math(String.raw`y\mapsto h(y)`), " は ", math(String.raw`B_F(q)`), " から ",
        math(String.raw`B_G(h(q))`), " への全単射である。さらに ",
        ref("claim_iterate_monoid_conjugacy_transports_tree_edges"), " により",
      ]),
      displayMath(String.raw`(y,z)\in T_F(q)\ \Longleftrightarrow\ (h(y),h(z))\in T_G(h(q))`),
      paragraph(["である。したがってこの制限は等式の両辺で数えている二つの有限集合の間の全単射であり、有限集合の個数は等しい。"]),
    ],
  },
  {
    id: "iterate_monoid_conjugacy_claim_invariant_family_finite_decidability",
    kind: "claim",
    title: { text: "軌道と安定構造の有限決定" },
    labels: ["claim_iterate_monoid_conjugacy_invariant_family_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合上の自己写像の有限表から、", math(String.raw`\mu_F,\lambda_F,E_F`),
        "、安定像、全安定ファイバー、および各ファイバーの根付き辺・深さ・分岐個数を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_tail_finite_decidability"), " により ", math(String.raw`\mu_F`),
        " を、", ref("claim_iterate_monoid_minimal_period_finite_decidability"), " により ", math(String.raw`\lambda_F`),
        " を、", ref("claim_iterate_monoid_cycle_idempotent_finite_decidability"), " により ", math(String.raw`E_F`),
        " を有限決定できる。", ref("claim_iterate_monoid_stable_fibers_finite_decidability"),
        " により安定像と全ファイバーを有限決定でき、", ref("claim_iterate_monoid_fiber_tree_finite_decidability"),
        " により各根付き木の辺・深さ・分岐個数を有限決定できる。全て有限集合上の有限走査である。",
      ]),
      paragraph(["この検査は有限集合と自然数だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },
]);
