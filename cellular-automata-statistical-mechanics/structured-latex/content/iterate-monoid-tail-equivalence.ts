/**
 * 章「反復モノイドの主イデアル同値と有限鎖」。
 * 反復写像が生成する主イデアルの等しさと包含だけから、同値関係と有限な鎖を抽出する。
 *
 * 有限集合、自然数、写像合成だけを使う。既存半群論の名称は一次文献確認前なので
 * 同定せず、R / C は使わない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "iterate_monoid_tail_equivalence_definition_generated_ideal",
    kind: "definition",
    title: { text: "反復写像が生成する主イデアル" },
    labels: ["def_iterate_monoid_generated_ideal"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid"),
        " の反復モノイド ",
        math(String.raw`P_F`),
        " とその元 ",
        math(String.raw`G\in P_F`),
        " に対し、",
      ]),
      displayMath(String.raw`J_F(G):=\{\,G\circ H\mid H\in P_F\,\}\subseteq P_F`),
      paragraph([
        "と定める。",
        ref("claim_iterate_monoid_tail_is_principal_ideal"),
        " により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について ",
        math(String.raw`J_F(F^n)=I_n(F)`),
        " である。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_definition_relation",
    kind: "definition",
    title: { text: "主イデアル同値" },
    labels: ["def_iterate_monoid_principal_ideal_equivalence"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid"), " の ", math(String.raw`G,H\in P_F`),
        " と ", ref("def_iterate_monoid_generated_ideal"), " の主イデアル ",
        math(String.raw`J_F`),
        " に対し、",
      ]),
      displayMath(String.raw`G\sim_F H\quad\Longleftrightarrow\quad J_F(G)=J_F(H)`),
      paragraph(["と定める。これを主イデアル同値と呼ぶ。"]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_claim_equivalence_relation",
    kind: "claim",
    title: { text: "主イデアル同値は同値関係である" },
    labels: ["claim_iterate_monoid_principal_ideal_equivalence_relation"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_principal_ideal_equivalence"),
        " の関係 ",
        math(String.raw`\sim_F`),
        " は有限集合 ",
        math(String.raw`P_F`),
        " 上の同値関係である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`G\in P_F`), " とする。集合の等号の反射律より"]),
      displayMath(String.raw`J_F(G)=J_F(G)`),
      paragraph([
        "なので ",
        ref("def_iterate_monoid_principal_ideal_equivalence"),
        " より ",
        math(String.raw`G\sim_F G`),
        " である。",
      ]),
      paragraph([
        math(String.raw`G,H\in P_F`),
        " と ",
        math(String.raw`G\sim_F H`),
        " を仮定する。",
        ref("def_iterate_monoid_principal_ideal_equivalence"),
        " と集合の等号の対称律より",
      ]),
      displayMath(String.raw`J_F(H)=J_F(G)`),
      paragraph([
        "なので ",
        math(String.raw`H\sim_F G`),
        " である。さらに ",
        math(String.raw`K\in P_F`),
        " と ",
        math(String.raw`H\sim_F K`),
        " を仮定する。集合の等号の推移律より",
      ]),
      displayMath(String.raw`J_F(G)=J_F(K)`),
      paragraph([
        "なので ",
        ref("def_iterate_monoid_principal_ideal_equivalence"),
        " より ",
        math(String.raw`G\sim_F K`),
        " である。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_claim_generated_ideals_comparable",
    kind: "claim",
    title: { text: "任意の二つの生成主イデアルは包含で比較できる" },
    labels: ["claim_iterate_monoid_generated_ideals_comparable"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`G,H\in P_F`),
        " について、",
      ]),
      displayMath(String.raw`J_F(G)\subseteq J_F(H)\quad\text{または}\quad J_F(H)\subseteq J_F(G)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        ref("def_iterate_monoid"),
        " により、ある ",
        math(String.raw`m,n\in\mathbb{N}`),
        " が存在して ",
        math(String.raw`G=F^m`),
        "、",
        math(String.raw`H=F^n`),
        " である。",
        math(String.raw`m\le n`),
        " と ",
        math(String.raw`n\le m`),
        " に場合分けする。",
      ]),
      paragraph([math(String.raw`m\le n`), " の場合、ある ", math(String.raw`d\in\mathbb{N}`), " について ", math(String.raw`n=m+d`), " なので、"]),
      displayMath(String.raw`I_n(F)\subseteq I_m(F)`),
      paragraph([
        "である（",
        ref("def_iterate_monoid_tail"),
        " において指数へ ",
        math(String.raw`d`),
        " を加えた元はすべて ",
        math(String.raw`I_m(F)`),
        " に属する）。",
        ref("claim_iterate_monoid_tail_is_principal_ideal"),
        " と ",
        ref("def_iterate_monoid_generated_ideal"),
        " より",
      ]),
      displayMath(String.raw`J_F(H)\subseteq J_F(G)`),
      paragraph([
        "を得る。",
        math(String.raw`n\le m`),
        " の場合も ",
        math(String.raw`m,n`),
        " を入れ替えた同じ論証により ",
        math(String.raw`J_F(G)\subseteq J_F(H)`),
        " を得る。",
      ]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_definition_ideal_chain",
    kind: "definition",
    title: { text: "生成主イデアルの集合" },
    labels: ["def_iterate_monoid_generated_ideal_chain"],
    habitat: "finite",
    statement: [
      paragraph([ref("def_iterate_monoid"), " の ", math(String.raw`P_F`),
        " と ", ref("def_iterate_monoid_generated_ideal"), " の ", math(String.raw`J_F`), " に対し、"]),
      displayMath(String.raw`\mathcal{J}_F:=\{\,J_F(G)\mid G\in P_F\,\}`),
      paragraph(["と定める。"]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_claim_finite_chain_decidable",
    kind: "claim",
    title: { text: "生成主イデアルは有限決定可能な鎖をなす" },
    labels: ["claim_iterate_monoid_generated_ideal_finite_chain_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_iterate_monoid_generated_ideal_chain"),
        " の集合 ",
        math(String.raw`\mathcal{J}_F`),
        " は有限であり、包含関係により任意の二元を比較できる。有限集合と自己写像の有限表から、",
        math(String.raw`\mathcal{J}_F`),
        " の全ての元、包含関係、主イデアル同値の各同値類を有限回の元の等号検査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`P_F`),
        " は有限集合であり（",
        ref("claim_iterate_powers_form_finite_commutative_monoid"),
        "）、",
        math(String.raw`\mathcal{J}_F`),
        " は写像 ",
        math(String.raw`G\mapsto J_F(G)`),
        " による ",
        math(String.raw`P_F`),
        " の像なので有限集合である。",
        ref("claim_iterate_monoid_generated_ideals_comparable"),
        " により、その任意の二元は包含で比較できる。",
      ]),
      paragraph([
        ref("claim_iterate_monoid_finite_decidability"),
        " により ",
        math(String.raw`P_F`),
        " と合成表を有限決定できる。各 ",
        math(String.raw`G\in P_F`),
        " について有限集合 ",
        math(String.raw`P_F`),
        " の全ての ",
        math(String.raw`H`),
        " を走査して ",
        math(String.raw`G\circ H`),
        " を集めれば ",
        math(String.raw`J_F(G)`),
        " が得られる。得られた有限部分集合どうしの等号と包含を走査すれば、",
        math(String.raw`\mathcal{J}_F`),
        "、その包含関係、および ",
        ref("def_iterate_monoid_principal_ideal_equivalence"),
        " の同値類が決まる。",
      ]),
      paragraph(["この検査は有限集合と自然数だけで閉じる。実数、複素数、極限、完備化は使わない。"]),
    ],
  },

  {
    id: "iterate_monoid_tail_equivalence_remark_external_name",
    kind: "remark",
    title: { text: "既存半群論との名称上の同定は保留する" },
    labels: ["remark_iterate_monoid_principal_ideal_external_name_deferred"],
    habitat: "finite",
    statement: [
      paragraph([
        "ここでは主イデアルの等号と包含から直接定義・証明できる内容だけを述べた。既存半群論の関係との同定、",
        "その既知性、分類定理との接続は一次文献を確認する別の層に残し、この章では主張しない。",
      ]),
    ],
  },
]);
