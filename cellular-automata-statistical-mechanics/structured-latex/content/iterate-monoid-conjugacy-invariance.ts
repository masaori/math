/**
 * 章「有限大域写像の共役による安定ファイバー根付き木族の不変性」。
 * 二つの有限舞台上の 2 値 CA の大域写像を結ぶ共役全単射が、
 * 最小衝突開始位置・最小正周期・巡回冪等元を保存することを、
 * 有限集合、自然数、写像の合成と等号だけから導く。R / C は使わない。
 *
 * この章の現在の範囲は共役の定義と衝突・周期・冪等元の保存までである。
 * 安定像・安定ファイバー・根付き木の対応は次の層で同じ章へ追記する。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_conjugacy_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限大域写像の共役による安定ファイバー根付き木族の不変性" },
    labels: [],
  },
  {
    id: "iterate_monoid_conjugacy_definition_conjugacy",
    kind: "definition",
    title: { text: "大域写像の共役全単射" },
    labels: ["def_iterate_monoid_conjugacy_bijection"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), " 上の 2 値セルオートマトン（",
        ref("def_finite_ca"), "）の大域写像 ",
        math(String.raw`F:A^V\to A^V`), "（", ref("def_global_map"), "）と、有限舞台 ",
        math(String.raw`(W,M)`), " 上の 2 値セルオートマトンの大域写像 ",
        math(String.raw`G:A^W\to A^W`), " に対し、写像 ",
        math(String.raw`h:A^V\to A^W`), " が ", math(String.raw`F`), " から ",
        math(String.raw`G`), " への共役全単射であるとは、",
        math(String.raw`h`), " が全単射であり、かつ",
      ]),
      displayMath(String.raw`h\circ F=G\circ h`),
      paragraph([
        "が成り立つことをいう。ここで ", math(String.raw`A=\{0,1\}`),
        " は共通の状態集合（", ref("def_state_set"), "）、",
        math(String.raw`V,W`), " はそれぞれ有限集合（", ref("def_finite_stage"),
        "）であり、", math(String.raw`A^V,A^W`), " はともに有限集合である。以下この章では ",
        math(String.raw`F,G,h`), " を固定する。", math(String.raw`G`),
        " についての反復（", ref("def_global_map_iterate"), "）、衝突開始位置と最小衝突開始位置 ",
        math(String.raw`\mu_G`), "（", ref("def_iterate_monoid_collision_start"),
        "）、正周期の集合 ", math(String.raw`\Pi_G`), " と最小正周期 ",
        math(String.raw`\lambda_G`), "（", ref("def_iterate_monoid_minimal_positive_period"),
        "）、安定後の周期倍数指数 ", math(String.raw`D_G`), "（",
        ref("def_iterate_monoid_stable_period_multiple_exponents"), "）とその最小元 ",
        math(String.raw`e_G`), "（", ref("def_iterate_monoid_minimal_stable_period_multiple"),
        "）、巡回部の冪等元 ", math(String.raw`E_G:=G^{e_G}`), "（",
        ref("def_iterate_monoid_cycle_idempotent_candidate"),
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
        math(String.raw`y\in A^V`), " での値の等号で確かめる。基底 ",
        math(String.raw`n=0`), " では、各 ", math(String.raw`y\in A^V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(h\circ F^0)(y)
&=h(F^0\,y)\quad(\because\ \text{写像の合成の定義})\\
&=h(y)\quad(\because\ F^0\,y=y.\ \blkref{def_global_map_iterate})\\
&=G^0(h(y))\quad(\because\ G^0\,z=z.\ \blkref{def_global_map_iterate})\\
&=(G^0\circ h)(y)\quad(\because\ \text{写像の合成の定義}).
\end{aligned}`),
      paragraph([
        "帰納段では ", math(String.raw`h\circ F^n=G^n\circ h`),
        " を仮定する。各 ", math(String.raw`y\in A^V`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(h\circ F^{n+1})(y)
&=h(F^{n+1}\,y)\quad(\because\ \text{写像の合成の定義})\\
&=h(F(F^n\,y))\quad(\because\ F^{n+1}\,y=F(F^n\,y).\ \blkref{def_global_map_iterate})\\
&=G(h(F^n\,y))\quad(\because\ h\circ F=G\circ h\ \text{を}\ F^n\,y\ \text{で評価する。}\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=G(G^n(h(y)))\quad(\because\ \text{帰納法の仮定を}\ y\ \text{で評価する})\\
&=G^{n+1}(h(y))\quad(\because\ G^{n+1}\,z=G(G^n\,z).\ \blkref{def_global_map_iterate})\\
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
        math(String.raw`z\in A^W`), " を任意に取る。", math(String.raw`h`),
        " は全射なので（", ref("def_iterate_monoid_conjugacy_bijection"),
        "）、", math(String.raw`h(y)=z`), " を満たす ", math(String.raw`y\in A^V`),
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
        math(String.raw`y\in A^V`), " について",
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
        math(String.raw`y\in A^V`), " について",
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
]);
