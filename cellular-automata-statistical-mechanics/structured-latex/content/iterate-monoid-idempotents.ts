/**
 * 章「反復モノイドの冪等元」。
 * 前章で得た有限可換モノイドを、反復写像どうしの衝突だけからさらに調べる。
 *
 * - 衝突 F^i = F^j が時刻 i 以後の周期 p=j-i を与えること
 * - 正の指数をもつ冪等な反復写像が必ず存在すること
 * - 冪等元全体が自己写像の有限表から決定できること
 * - 非単位冪等元の存在と冪等元の一意性は一般には成り立たないこと
 *
 * 有限集合と自然数だけを使い、極限、実数、複素数は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_idempotents_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの冪等元" },
    labels: [],
  },

  {
    id: "iterate_monoid_idempotents_definition",
    kind: "definition",
    title: { text: "反復モノイドの冪等元" },
    labels: ["def_iterate_monoid_idempotent"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid"),
        " の反復モノイド ",
        math(String.raw`(P_F,\circ)`),
        " に対し、",
      ]),
      displayMath(String.raw`\operatorname{Idem}(P_F):=\{\,G\in P_F\mid G\circ G=G\,\}`),
      paragraph([
        "と定める。この集合の元を冪等元と呼ぶ。指数 ",
        math(String.raw`e\in\mathbb{N}`),
        " が ",
        math(String.raw`F^e\in\operatorname{Idem}(P_F)`),
        " を満たすとき、",
        math(String.raw`e`),
        " を冪等指数と呼ぶ。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_idempotents_claim_collision_period",
    kind: "claim",
    title: { text: "反復写像の衝突は以後の周期を与える" },
    labels: ["claim_iterate_collision_gives_eventual_period"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`i,j\in\mathbb{N}`),
        " が ",
        math(String.raw`i<j`),
        " かつ ",
        math(String.raw`F^i=F^j`),
        " を満たし、",
        math(String.raw`p:=j-i\in\mathbb{N}_{>0}`),
        " とする。このとき、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について、",
      ]),
      displayMath(String.raw`n\ge i\quad\Longrightarrow\quad F^{n+p}=F^n`),
      paragraph(["が写像として成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n\ge i`),
        " とし、",
        math(String.raw`k:=n-i\in\mathbb{N}`),
        " と置く。すると ",
        math(String.raw`n=i+k`),
        " かつ ",
        math(String.raw`j=i+p`),
        " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^{n+p}
&=F^{(i+k)+p}
  \quad(\because\ n=i+k)\\
&=F^{(i+p)+k}
  \quad(\because\ \mathbb{N}\text{ の加法の結合律と交換律})\\
&=F^{j+k}
  \quad(\because\ j=i+p)\\
&=F^j\circ F^k
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^i\circ F^k
  \quad(\because\ F^i=F^j)\\
&=F^{i+k}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^n
  \quad(\because\ n=i+k)
\end{aligned}`),
    ],
  },

  {
    id: "iterate_monoid_idempotents_claim_positive_power_exists",
    kind: "claim",
    title: { text: "正の冪等指数は必ず存在する" },
    labels: ["claim_positive_idempotent_iterate_exists"],
    habitat: "N",
    statement: [
      paragraph([
        "ある ",
        math(String.raw`e\in\mathbb{N}_{>0}`),
        " が存在して、",
      ]),
      displayMath(String.raw`F^e\circ F^e=F^e`),
      paragraph(["が写像として成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_map_collision_finite_representatives"),
        " により、",
        math(String.raw`0\le i<j`),
        " かつ ",
        math(String.raw`F^i=F^j`),
        " を満たす ",
        math(String.raw`i,j\in\mathbb{N}`),
        " が存在する。",
        math(String.raw`p:=j-i\in\mathbb{N}_{>0}`),
        " と置く。",
      ]),
      paragraph([
        math(String.raw`i=0`),
        " のときは ",
        math(String.raw`e:=p\in\mathbb{N}_{>0}`),
        " と置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
F^e\circ F^e
&=F^p\circ F^p
  \quad(\because\ e=p)\\
&=F^0\circ F^0
  \quad(\because\ F^p=F^j=F^i=F^0)\\
&=F^0
  \quad(\because\ F^0=\operatorname{id}_{X})\\
&=F^e
  \quad(\because\ F^p=F^0\text{ かつ }e=p)
\end{aligned}`),
      paragraph([
        math(String.raw`i\ge1`),
        " のときは ",
        math(String.raw`e:=ip\in\mathbb{N}_{>0}`),
        " と置く。",
        math(String.raw`p\ge1`),
        " より ",
        math(String.raw`e=ip\ge i`),
        " である。",
        ref("claim_iterate_collision_gives_eventual_period"),
        " を、指数 ",
        math(String.raw`e,e+p,\ldots,e+(i-1)p`),
        " に順に適用すると、",
      ]),
      displayMath(String.raw`\begin{aligned}
F^e\circ F^e
&=F^{e+e}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{e+ip}
  \quad(\because\ e=ip)\\
&=F^e
  \quad(\because\ \blkref{claim_iterate_collision_gives_eventual_period}\text{ を }i\text{ 回適用})
\end{aligned}`),
      paragraph(["となる。どちらの場合も正の冪等指数が得られる。"]),
    ],
  },

  {
    id: "iterate_monoid_idempotents_claim_finite_decidability",
    kind: "claim",
    title: { text: "冪等元全体は自己写像の有限表から決定できる" },
    labels: ["claim_iterate_monoid_idempotents_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " と自己写像 ", math(String.raw`F:X\to X`),
        " の有限表から、集合 ",
        math(String.raw`\operatorname{Idem}(P_F)`),
        " の全ての元を有限回の ", math(String.raw`X`), " の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_finite_decidability"),
        " により、",
        math(String.raw`P_F`),
        " の全ての元と合成表を有限回の ", math(String.raw`X`), " の元の等号検査で決定できる。合成表の各 ",
        math(String.raw`G\in P_F`),
        " の対角成分 ",
        math(String.raw`G\circ G`),
        " と ",
        math(String.raw`G`),
        " を比較し、等しい元だけを集めれば、",
        ref("def_iterate_monoid_idempotent"),
        " の集合と一致する。有限集合の全走査なので終了する。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_idempotents_claim_nonidentity_not_forced",
    kind: "claim",
    title: { text: "単位元でない冪等元の存在は強制されない" },
    labels: ["claim_nonidentity_idempotent_not_forced"],
    habitat: "finite",
    statement: [
      paragraph([
        "反復モノイドの冪等元（", ref("def_iterate_monoid_idempotent"),
        "）に、単位元でないものが存在するとは限らない。",
      ]),
    ],
    proof: [
      paragraph([
        "一元集合 ", math(String.raw`X:=\{x\}`), " と恒等写像 ",
        math(String.raw`F:=\operatorname{id}_{X}:X\to X`),
        " を取る。このとき全ての ",
        math(String.raw`n\in\mathbb{N}`),
        " について ",
        math(String.raw`F^n=\operatorname{id}_{X}`),
        " なので、",
      ]),
      displayMath(String.raw`P_F=\{\operatorname{id}_{X}\}`),
      paragraph([
        "である。したがって ",
        math(String.raw`\operatorname{Idem}(P_F)`),
        " は単位元だけからなる。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_idempotents_claim_uniqueness_fails",
    kind: "claim",
    title: { text: "冪等元の一意性は成り立たない" },
    labels: ["claim_iterate_monoid_idempotent_uniqueness_fails"],
    habitat: "finite",
    statement: [
      paragraph(["反復モノイドの冪等元（", ref("def_iterate_monoid_idempotent"),
        "）は一意とは限らない。"]),
    ],
    proof: [
      paragraph([
        "二元集合 ", math(String.raw`X:=\{0,1\}`), " と定値自己写像 ",
        math(String.raw`F:X\to X`), "、", math(String.raw`F(x):=0`),
        " を取る。",
      ]),
      displayMath(String.raw`F\circ F=F`),
      paragraph([
        "である。また ",
        math(String.raw`F^0=\operatorname{id}_{X}`),
        " も冪等である。また ", math(String.raw`1\in X`), " について、",
      ]),
      displayMath(String.raw`F(1)=0\neq1=F^0(1)`),
      paragraph([
        "なので ",
        math(String.raw`F\neq F^0`),
        " である。したがって ",
        math(String.raw`F,F^0\in\operatorname{Idem}(P_F)`),
        " は相異なる。",
      ]),
    ],
  },
]);
