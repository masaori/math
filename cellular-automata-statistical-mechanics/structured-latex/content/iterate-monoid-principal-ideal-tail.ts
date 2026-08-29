/**
 * 章「反復モノイドの主イデアル列」。
 * 反復写像の指数を下から切った集合が、反復モノイドの主イデアルであり、
 * 指数とともに包含で減少し、反復写像の衝突後には安定することを示す。
 *
 * 有限集合と自然数だけを使う。Green 関係や既存の半群論は先取りせず、
 * 写像の合成と反復回数の加法だけから証明する。R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_principal_ideal_tail_heading",
    kind: "heading",
    level: 1,
    title: { text: "反復モノイドの主イデアル列" },
    labels: [],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_definition",
    kind: "definition",
    title: { text: "反復写像の後尾集合" },
    labels: ["def_iterate_monoid_tail"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid"),
        " の反復モノイド ",
        math(String.raw`P_F`),
        " と ",
        math(String.raw`n\in\mathbb{N}`),
        " に対し、",
      ]),
      displayMath(String.raw`I_n(F):=\{\,F^{n+k}\mid k\in\mathbb{N}\,\}\subseteq P_F`),
      paragraph([
        "と定め、",
        math(String.raw`n`),
        " から始まる反復写像の後尾集合と呼ぶ。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_claim_principal_ideal",
    kind: "claim",
    title: { text: "後尾集合は一つの反復写像が生成する主イデアルである" },
    labels: ["claim_iterate_monoid_tail_is_principal_ideal"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について、",
      ]),
      displayMath(String.raw`I_n(F)=\{\,F^n\circ G\mid G\in P_F\,\}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`H\in I_n(F)`),
        " とする。",
        ref("def_iterate_monoid_tail"),
        " により、ある ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`H=F^{n+k}`),
        " である。",
        ref("claim_iterate_composition_addition"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
H
&=F^{n+k}
  \quad(\because\ H=F^{n+k})\\
&=F^n\circ F^k
  \quad(\because\ \blkref{claim_iterate_composition_addition})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`F^k\in P_F`),
        "（",
        ref("def_iterate_monoid"),
        "）なので右辺の集合に属する。逆に ",
        math(String.raw`G\in P_F`),
        " とする。",
        ref("def_iterate_monoid"),
        " により、ある ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`G=F^k`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
F^n\circ G
&=F^n\circ F^k
  \quad(\because\ G=F^k)\\
&=F^{n+k}
  \quad(\because\ \blkref{claim_iterate_composition_addition})
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_iterate_monoid_tail"),
        " より ",
        math(String.raw`F^n\circ G\in I_n(F)`),
        " である。両包含から集合の等号を得る。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_claim_absorption",
    kind: "claim",
    title: { text: "後尾集合は反復写像の合成を吸収する" },
    labels: ["claim_iterate_monoid_tail_absorbs_composition"],
    habitat: "finite",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n\in\mathbb{N}`),
        "、",
        math(String.raw`G\in P_F`),
        "、",
        math(String.raw`H\in I_n(F)`),
        " について、",
      ]),
      displayMath(String.raw`G\circ H\in I_n(F)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid"),
        " と ",
        ref("def_iterate_monoid_tail"),
        " により、ある ",
        math(String.raw`a,b\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`G=F^a`),
        "、",
        math(String.raw`H=F^{n+b}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
G\circ H
&=F^a\circ F^{n+b}
  \quad(\because\ G=F^a\ \text{かつ}\ H=F^{n+b})\\
&=F^{a+(n+b)}
  \quad(\because\ \blkref{claim_iterate_composition_addition})\\
&=F^{n+(a+b)}
  \quad(\because\ \mathbb{N}\text{ の加法の結合律と交換律})
\end{aligned}`),
      paragraph([
        math(String.raw`a+b\in\mathbb{N}`),
        " なので、",
        ref("def_iterate_monoid_tail"),
        " より ",
        math(String.raw`G\circ H\in I_n(F)`),
        " である。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_claim_descending",
    kind: "claim",
    title: { text: "後尾集合は包含について減少する" },
    labels: ["claim_iterate_monoid_tails_descend"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について、",
      ]),
      displayMath(String.raw`I_{n+1}(F)\subseteq I_n(F)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`H\in I_{n+1}(F)`),
        " とする。",
        ref("def_iterate_monoid_tail"),
        " により、ある ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`H=F^{(n+1)+k}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
H
&=F^{(n+1)+k}
  \quad(\because\ H=F^{(n+1)+k})\\
&=F^{n+(1+k)}
  \quad(\because\ \mathbb{N}\text{ の加法の結合律})
\end{aligned}`),
      paragraph([
        math(String.raw`1+k\in\mathbb{N}`),
        " なので、",
        ref("def_iterate_monoid_tail"),
        " より ",
        math(String.raw`H\in I_n(F)`),
        " である。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_claim_collision_stabilizes",
    kind: "claim",
    title: { text: "反復写像の衝突後は後尾集合が安定する" },
    labels: ["claim_iterate_collision_stabilizes_tails"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`i,j\in\mathbb{N}`),
        " が ",
        math(String.raw`i<j`),
        " かつ ",
        math(String.raw`F^i=F^j`),
        " を満たすなら、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について、",
      ]),
      displayMath(String.raw`n\ge i\quad\Longrightarrow\quad I_n(F)=I_i(F)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`n\ge i`),
        " とし、",
        math(String.raw`d:=n-i\in\mathbb{N}`),
        "、",
        math(String.raw`p:=j-i\in\mathbb{N}_{>0}`),
        " と置く。まず ",
        math(String.raw`H\in I_n(F)`),
        " とする。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`H=F^{n+k}`),
        " なので、",
      ]),
      displayMath(String.raw`\begin{aligned}
H
&=F^{n+k}
  \quad(\because\ H=F^{n+k})\\
&=F^{i+(d+k)}
  \quad(\because\ n=i+d)
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`H\in I_i(F)`),
        " である。逆に ",
        math(String.raw`H\in I_i(F)`),
        " とする。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`H=F^{i+k}`),
        " である。",
        ref("claim_iterate_collision_gives_repeating_tail"),
        " を ",
        math(String.raw`d`),
        " 回繰り返すと",
      ]),
      displayMath(String.raw`F^{i+k+dp}=F^{i+k}`),
      paragraph([
        "を得る。また ",
        math(String.raw`p\ge1`),
        " と ",
        math(String.raw`k\ge0`),
        " より ",
        math(String.raw`k+dp\ge d`),
        " なので、",
        math(String.raw`q:=k+dp-d\in\mathbb{N}`),
        " と置ける。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
H
&=F^{i+k}
  \quad(\because\ H=F^{i+k})\\
&=F^{i+k+dp}
  \quad(\because\ F^{i+k+dp}=F^{i+k})\\
&=F^{(i+d)+q}
  \quad(\because\ q=k+dp-d)\\
&=F^{n+q}
  \quad(\because\ n=i+d)
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_iterate_monoid_tail"),
        " より ",
        math(String.raw`H\in I_n(F)`),
        " である。両包含から集合の等号を得る。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_principal_ideal_tail_claim_finite_decidability",
    kind: "claim",
    title: { text: "後尾集合の列と安定開始位置は有限決定できる" },
    labels: ["claim_iterate_monoid_tail_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合と自己写像の有限表から、相異なる後尾集合の列と、最初に ",
        math(String.raw`I_n(F)=I_{n+1}(F)`),
        " となる ",
        math(String.raw`n\in\mathbb{N}`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_finite_decidability"),
        " により、",
        math(String.raw`P_F`),
        " の全ての元と合成表を有限決定できる。各 ",
        math(String.raw`n\in\mathbb{N}`),
        " について、",
        ref("claim_iterate_monoid_tail_is_principal_ideal"),
        " の右辺を有限集合 ",
        math(String.raw`P_F`),
        " 上で走査すれば ",
        math(String.raw`I_n(F)`),
        " が得られる。",
        ref("claim_iterate_map_collision_finite_representatives"),
        " により有限範囲で ",
        math(String.raw`F^i=F^j`),
        " を満たす ",
        math(String.raw`i<j`),
        " が見つかり、",
        ref("claim_iterate_collision_stabilizes_tails"),
        " により ",
        math(String.raw`n\ge i`),
        " では新しい後尾集合は現れない。したがって ",
        math(String.raw`I_0(F),I_1(F),\ldots,I_i(F)`),
        " だけを比較すれば、相異なる後尾集合の列と最初の等号位置を決定できる。",
      ]),
      paragraph([
        "この検査は有限集合と自然数だけで閉じる。無限反復の極限、位相、実数、複素数は使わない。",
      ]),
    ],
  },
]);
