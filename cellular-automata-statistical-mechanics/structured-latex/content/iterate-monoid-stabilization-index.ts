/**
 * 章「反復モノイドの衝突開始位置と主イデアル列の安定位置」。
 * 反復写像の衝突が初めて始まる指数と、後尾主イデアル列が初めて
 * 安定する指数が一致することを、有限集合と自然数だけから示す。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_stabilization_index_definition_collision_start",
    kind: "definition",
    title: { text: "衝突開始位置" },
    labels: ["def_iterate_monoid_collision_start"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid"),
        " の反復写像の列に対し、",
        math(String.raw`n\in\mathbb{N}`),
        " が衝突開始位置であるとは、ある ",
        math(String.raw`p\in\mathbb{N}_{>0}`),
        " が存在して",
      ]),
      displayMath(String.raw`F^n=F^{n+p}`),
      paragraph([
        "となることをいう。",
        ref("claim_iterate_map_collision_finite_representatives"),
        " により衝突開始位置は存在するので、その最小値を ",
        math(String.raw`\mu_F\in\mathbb{N}`),
        " と書く。最小値の存在には自然数の整列性だけを使う。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_stabilization_index_claim_tail_equality_iff_collision",
    kind: "claim",
    title: { text: "隣り合う後尾主イデアルの等号は同じ位置で始まる衝突と同値である" },
    labels: ["claim_iterate_monoid_tail_equality_iff_collision_start"],
    habitat: "N",
    statement: [
      paragraph(["すべての ", math(String.raw`n\in\mathbb{N}`), " について、"]),
      displayMath(String.raw`I_n(F)=I_{n+1}(F)\quad\Longleftrightarrow\quad
\exists p\in\mathbb{N}_{>0},\ F^n=F^{n+p}`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        math(String.raw`I_n(F)=I_{n+1}(F)`),
        " と仮定する。",
        ref("def_iterate_monoid_tail"),
        " より ",
        math(String.raw`F^n=F^{n+0}\in I_n(F)`),
        " である。集合の等号により ",
        math(String.raw`F^n\in I_{n+1}(F)`),
        " だから、ある ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在して",
      ]),
      displayMath(String.raw`F^n=F^{(n+1)+k}=F^{n+(1+k)}`),
      paragraph([
        "となる。",
        math(String.raw`p:=1+k\in\mathbb{N}_{>0}`),
        " と置けば右辺を得る。",
      ]),
      paragraph([
        "逆に、",
        math(String.raw`p\in\mathbb{N}_{>0}`),
        " と ",
        math(String.raw`F^n=F^{n+p}`),
        " が与えられたとする。",
        math(String.raw`n<n+p`),
        " なので、",
        ref("claim_iterate_collision_stabilizes_tails"),
        " を衝突指数 ",
        math(String.raw`i=n`),
        "、",
        math(String.raw`j=n+p`),
        " と、",
        math(String.raw`n+1\ge n`),
        " に適用して",
      ]),
      displayMath(String.raw`I_{n+1}(F)=I_n(F)`),
      paragraph(["を得る。集合の等号の対称律により左辺を得る。"]),
    ],
  },

  {
    id: "iterate_monoid_stabilization_index_claim_strict_then_stable",
    kind: "claim",
    title: { text: "主イデアル列は衝突開始位置まで厳密に減少し、その後は一定である" },
    labels: ["claim_iterate_monoid_tails_strict_then_stable"],
    habitat: "N",
    statement: [
      paragraph([
        ref("def_iterate_monoid_collision_start"),
        " の最小衝突開始位置 ",
        math(String.raw`\mu_F`),
        " に対し、",
      ]),
      displayMath(String.raw`n<\mu_F\ \Longrightarrow\ I_{n+1}(F)\subsetneq I_n(F)`),
      displayMath(String.raw`n\ge\mu_F\ \Longrightarrow\ I_n(F)=I_{\mu_F}(F)`),
      paragraph(["が成り立つ。"])],
    proof: [
      paragraph([
        math(String.raw`n<\mu_F`),
        " とする。",
        ref("claim_iterate_monoid_tails_descend"),
        " により ",
        math(String.raw`I_{n+1}(F)\subseteq I_n(F)`),
        " である。等号なら、",
        ref("claim_iterate_monoid_tail_equality_iff_collision_start"),
        " により ",
        math(String.raw`n`),
        " が衝突開始位置となり、",
        math(String.raw`\mu_F`),
        " の最小性と矛盾する。したがって包含は真である。",
      ]),
      paragraph([
        "一方、",
        math(String.raw`\mu_F`),
        " は衝突開始位置なので、ある ",
        math(String.raw`p\in\mathbb{N}_{>0}`),
        " について ",
        math(String.raw`F^{\mu_F}=F^{\mu_F+p}`),
        " である。",
        ref("claim_iterate_collision_stabilizes_tails"),
        " を ",
        math(String.raw`i=\mu_F`),
        "、",
        math(String.raw`j=\mu_F+p`),
        " に適用すると、すべての ",
        math(String.raw`n\ge\mu_F`),
        " について ",
        math(String.raw`I_n(F)=I_{\mu_F}(F)`),
        " を得る。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_stabilization_index_claim_first_stable_equals_collision_start",
    kind: "claim",
    title: { text: "最初の安定位置は最小衝突開始位置に等しい" },
    labels: ["claim_iterate_monoid_first_stable_equals_min_collision_start"],
    habitat: "finite",
    statement: [
      paragraph([
        "最初に ",
        math(String.raw`I_n(F)=I_{n+1}(F)`),
        " となる ",
        math(String.raw`n\in\mathbb{N}`),
        " は ",
        math(String.raw`\mu_F`),
        " に等しい。したがって、有限集合と自己写像の有限表から ",
        math(String.raw`\mu_F`),
        " を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_iterate_monoid_tails_strict_then_stable"),
        " より、",
        math(String.raw`n<\mu_F`),
        " では隣り合う後尾集合は等しくなく、",
        math(String.raw`n=\mu_F`),
        " では等しい。よって最初の安定位置は ",
        math(String.raw`\mu_F`),
        " である。",
        ref("claim_iterate_monoid_tail_finite_decidability"),
        " は最初の安定位置を有限決定するので、同じ走査が ",
        math(String.raw`\mu_F`),
        " を有限決定する。検査は有限集合と自然数だけで閉じ、無限極限、位相、実数、複素数を使わない。",
      ]),
    ],
  },
]);
