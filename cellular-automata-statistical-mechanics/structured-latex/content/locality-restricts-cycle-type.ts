/**
 * 章「局所性による巡回型の制限」。
 * 近傍を制限した有限舞台の上で可逆な大域写像を集め、その巡回型として実現される分割の集合が
 * 配位数の分割全体の真部分集合になりうることを、具体舞台の反例として示す。
 *
 * 有限集合、自然数、有限多重集合だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "locality_restricts_cycle_type_heading",
    kind: "heading",
    level: 1,
    title: { text: "局所性による巡回型の制限" },
    labels: [],
  },

  {
    id: "locality_restricts_cycle_type_definition_stage_global_maps",
    kind: "definition",
    title: { text: "近傍を制限した有限舞台上の大域写像全体" },
    labels: ["def_stage_global_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), "（", ref("def_finite_stage"), "）に対し、",
      ]),
      displayMath(String.raw`\mathcal M(V,N):=\{\,F\ :\ F\ \text{は}\ (V,N)\ \text{上のある}\ 2\ \text{値セルオートマトンの大域写像}\,\}`),
      paragraph([
        "と定める（", ref("def_finite_ca"), " と ", ref("def_global_map"), "）。",
        math(String.raw`\mathcal M(V,N)`), " の各元は ", math(String.raw`A^{V}`),
        " から ", math(String.raw`A^{V}`), " への写像なので、",
        ref("def_conjugacy_class_all_self_maps"), " により ",
        math(String.raw`\mathcal M(V,N)\subseteq\mathcal M(V)`), " である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_stage_global_maps_count",
    kind: "claim",
    title: { text: "局所規則の族から大域写像への対応は単射である" },
    labels: ["claim_stage_global_maps_count"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), " 上の大域写像全体 ",
        math(String.raw`\mathcal M(V,N)`), "（", ref("def_stage_global_maps"), "）について、局所規則の族 ",
        math(String.raw`(f_v)_{v\in V}`), " に大域写像 ", math(String.raw`F`),
        " を対応させる写像は単射である。したがって",
      ]),
      displayMath(String.raw`|\mathcal M(V,N)|=\prod_{v\in V}2^{2^{|N(v)|}}\in\mathbb{N}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "族 ", math(String.raw`(f_v)_{v\in V}`), " と ", math(String.raw`(g_v)_{v\in V}`),
        " の大域写像を ", math(String.raw`F`), "・", math(String.raw`G`),
        " とし、", math(String.raw`F=G`), " とする。",
        math(String.raw`v\in V`), " と ", math(String.raw`z\in A^{N(v)}`),
        " を任意に取り、", math(String.raw`x:=\iota^{V}_{N(v)}\,z\in A^{V}`),
        " と置く（", ref("def_base_value_extension"), "）。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
f_v(z)
&=f_v\bigl(\rho^{V}_{N(v)}(\iota^{V}_{N(v)}\,z)\bigr)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の}\ \rho^{V}_{N(v)}\circ\iota^{V}_{N(v)}=\mathrm{id}_{A^{N(v)}})\\
&=f_v\bigl(\rho^{V}_{N(v)}\,x\bigr)\qquad(\because\ x\ \text{の定義})\\
&=(F\,x)(v)\qquad(\because\ \blkref{def_global_map})\\
&=(G\,x)(v)\qquad(\because\ F=G)\\
&=g_v\bigl(\rho^{V}_{N(v)}\,x\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=g_v\bigl(\rho^{V}_{N(v)}(\iota^{V}_{N(v)}\,z)\bigr)\qquad(\because\ x\ \text{の定義})\\
&=g_v(z)\qquad(\because\ \blkref{def_base_value_extension}\ \text{の}\ \rho^{V}_{N(v)}\circ\iota^{V}_{N(v)}=\mathrm{id}_{A^{N(v)}})
\end{aligned}`),
      paragraph([
        "が成り立つ。写像の外延性より ", math(String.raw`f_v=g_v`),
        " であり、", math(String.raw`v`), " は任意なので二つの族は等しい。",
        "よって対応は単射であり、",
        math(String.raw`\mathcal M(V,N)`), " の元数は局所規則の族の個数に等しい。",
        "各 ", math(String.raw`v`), " について ", math(String.raw`A^{N(v)}`),
        " は ", math(String.raw`2^{|N(v)|}`), " 元の有限集合なので（", ref("def_local_truth_table"),
        "）、", math(String.raw`f_v`), " の個数は ", math(String.raw`2^{2^{|N(v)|}}`),
        " であり、族の個数は積の法則によりその ", math(String.raw`v\in V`), " にわたる積である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_definition_stage_reversible_maps",
    kind: "definition",
    title: { text: "近傍を制限した有限舞台上の可逆な大域写像全体" },
    labels: ["def_stage_reversible_global_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`(V,N)`), " に対し、",
      ]),
      displayMath(String.raw`\mathcal M^{\times}(V,N):=\{\,F\in\mathcal M(V,N)\ :\ F\ \text{は単射}\,\}`),
      paragraph([
        "と定める（単射性は ", ref("def_finite_self_map_injective_surjective"), "）。",
        ref("def_stage_global_maps"), " の包含と ", ref("def_bijective_self_maps"),
        " により ", math(String.raw`\mathcal M^{\times}(V,N)\subseteq\mathcal M^{\times}(V)`),
        " である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_definition_realized_cycle_types",
    kind: "definition",
    title: { text: "舞台が実現する巡回型の集合" },
    labels: ["def_stage_realized_cycle_types"],
    habitat: "finite",
    statement: [
      paragraph(["有限舞台 ", math(String.raw`(V,N)`), " に対し、"]),
      displayMath(String.raw`\mathrm{CT}(V,N):=\{\,\mathrm{ct}(F)\ :\ F\in\mathcal M^{\times}(V,N)\,\}`),
      paragraph([
        "と定める（", ref("def_stage_reversible_global_maps"), " と ",
        ref("def_reversible_cycle_type"), "）。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_realized_subset",
    kind: "claim",
    title: { text: "実現される巡回型は配位数の分割であり有限決定できる" },
    labels: ["claim_stage_realized_cycle_types_decidable"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`\mathrm{CT}(V,N)\subseteq\operatorname{Part}(2^{|V|})`), "（",
        ref("def_carrier_cardinality_partitions"),
        "）であり、この集合は有限個の局所規則の族の走査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F\in\mathcal M^{\times}(V,N)`), " は ",
        ref("def_stage_reversible_global_maps"), " により ",
        math(String.raw`\mathcal M^{\times}(V)`), " の元なので、",
        ref("claim_reversible_cycle_type_sum"), " により ",
        math(String.raw`\mathrm{ct}(F)\in\operatorname{Part}(2^{|V|})`), " である。",
      ]),
      paragraph([
        "決定の手順は次のとおりである。",
        ref("claim_stage_global_maps_count"), " により局所規則の族は ",
        math(String.raw`\prod_{v\in V}2^{2^{|N(v)|}}`),
        " 個の有限個であり、その各々について大域写像 ", math(String.raw`F`), " が ",
        ref("def_global_map"), " の右辺の有限回の評価で定まる。",
        math(String.raw`F`), " の単射性は ",
        ref("claim_finite_self_map_injectivity_finite_decidability"),
        " により有限検査で決まり、単射な ", math(String.raw`F`), " の巡回型は ",
        ref("claim_bijective_self_map_orbits_partition_carrier"),
        " により有限集合 ", math(String.raw`A^{V}`),
        " を周期軌道へ分けて各軌道の元数を数えれば得られる。",
        "得られた有限多重集合を重複を除いて集めたものが ",
        math(String.raw`\mathrm{CT}(V,N)`), " であり、有限多重集合の等号は元と重複度の比較で決まる。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_definition_self_neighborhood_stage",
    kind: "definition",
    title: { text: "自分自身だけを近傍とする 3 セルの舞台" },
    labels: ["def_self_neighborhood_stage"],
    habitat: "finite",
    statement: [
      paragraph([
        "相異なる 3 元からなる有限集合 ",
        math(String.raw`V_{\bullet}:=\{v_1,v_2,v_3\}`),
        " と、各 ", math(String.raw`v\in V_{\bullet}`), " に対する ",
        math(String.raw`N_{\bullet}(v):=\{v\}`),
        " の組 ", math(String.raw`(V_{\bullet},N_{\bullet})`),
        " を考える。これは ", ref("def_finite_stage"), " の有限舞台であり、",
        math(String.raw`|V_{\bullet}|=3`), "・",
        math(String.raw`|A^{V_{\bullet}}|=2^{3}=8`), " である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_pointwise_bijection",
    kind: "claim",
    title: { text: "この舞台では大域写像が単射であることと各セルの値写像が全単射であることは同値である" },
    labels: ["claim_self_neighborhood_injective_iff_pointwise_bijective"],
    habitat: "finite",
    statement: [
      paragraph([
        "舞台 ", math(String.raw`(V_{\bullet},N_{\bullet})`), "（",
        ref("def_self_neighborhood_stage"), "）上の局所規則の族 ",
        math(String.raw`(f_v)_{v\in V_{\bullet}}`), " と、各 ",
        math(String.raw`v\in V_{\bullet}`), " に対する写像 ",
        math(String.raw`g_v:A\to A`), " を",
      ]),
      displayMath(String.raw`g_v(a):=f_v(z_a)\qquad\bigl(z_a\in A^{\{v\}},\ z_a(v):=a\bigr)`),
      paragraph([
        "と定める。このとき大域写像 ", math(String.raw`F`), " について",
      ]),
      displayMath(String.raw`(F\,x)(v)=g_v\bigl(x(v)\bigr)\qquad(x\in A^{V_{\bullet}},\ v\in V_{\bullet})`),
      paragraph([
        "が成り立ち、", math(String.raw`F`), " が単射であることと、全ての ",
        math(String.raw`v\in V_{\bullet}`), " について ", math(String.raw`g_v`),
        " が全単射であることは同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず各 ", math(String.raw`x\in A^{V_{\bullet}}`), " と ",
        math(String.raw`v\in V_{\bullet}`), " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
(F\,x)(v)
&=f_v\bigl(\rho^{V_{\bullet}}_{N_{\bullet}(v)}\,x\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\bigl(\rho^{V_{\bullet}}_{\{v\}}\,x\bigr)\qquad(\because\ \blkref{def_self_neighborhood_stage})\\
&=f_v\bigl(z_{x(v)}\bigr)\qquad(\because\ \blkref{def_restriction_map}\ \text{より}\ (\rho^{V_{\bullet}}_{\{v\}}\,x)(v)=x(v)\ \text{で、写像の外延性})\\
&=g_v\bigl(x(v)\bigr)\qquad(\because\ g_v\ \text{の定義})
\end{aligned}`),
      paragraph([
        "が成り立つ。",
      ]),
      paragraph([
        "全ての ", math(String.raw`g_v`), " が全単射であるとし、",
        math(String.raw`F\,x=F\,x'`), " とする。各 ", math(String.raw`v`),
        " について ", math(String.raw`g_v(x(v))=(F\,x)(v)=(F\,x')(v)=g_v(x'(v))`),
        " であり、", math(String.raw`g_v`), " が単射なので ",
        math(String.raw`x(v)=x'(v)`), " である。写像の外延性より ",
        math(String.raw`x=x'`), " なので ", math(String.raw`F`), " は単射である。",
      ]),
      paragraph([
        "逆に ", math(String.raw`F`), " が単射であるとし、",
        math(String.raw`v\in V_{\bullet}`), " と ",
        math(String.raw`a,a'\in A`), " について ",
        math(String.raw`g_v(a)=g_v(a')`), " とする。",
        math(String.raw`x:=\iota^{V_{\bullet}}_{\{v\}}\,z_a`), "・",
        math(String.raw`x':=\iota^{V_{\bullet}}_{\{v\}}\,z_{a'}`),
        " と置く（", ref("def_base_value_extension"), "）。",
        ref("def_base_value_extension"), " により ",
        math(String.raw`x(v)=a`), "・", math(String.raw`x'(v)=a'`),
        " であり、", math(String.raw`u\in V_{\bullet}\setminus\{v\}`),
        " については ", math(String.raw`x(u)=0=x'(u)`), " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
(F\,x)(v)&=g_v(a)=g_v(a')=(F\,x')(v)\qquad(\because\ \text{上で示した}\ (F\,x)(v)=g_v(x(v))\ \text{と仮定})\\
(F\,x)(u)&=g_u(0)=(F\,x')(u)\qquad(\because\ \text{同じ式と}\ x(u)=0=x'(u),\ u\in V_{\bullet}\setminus\{v\})
\end{aligned}`),
      paragraph([
        "となり、写像の外延性より ", math(String.raw`F\,x=F\,x'`), " である。",
        math(String.raw`F`), " の単射性より ", math(String.raw`x=x'`),
        " なので ", math(String.raw`a=x(v)=x'(v)=a'`), " である。",
        "よって ", math(String.raw`g_v`), " は単射であり、",
        math(String.raw`A`), " は有限集合なので（", ref("def_state_set"),
        "）単射な自己写像は全単射である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_involution",
    kind: "claim",
    title: { text: "この舞台の可逆な大域写像は 2 回の反復で恒等写像になる" },
    labels: ["claim_self_neighborhood_involution"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F\in\mathcal M^{\times}(V_{\bullet},N_{\bullet})`), " について ",
        math(String.raw`F^{2}=\mathrm{id}_{A^{V_{\bullet}}}`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_self_neighborhood_injective_iff_pointwise_bijective"), " により各 ",
        math(String.raw`g_v:A\to A`), " は全単射である。",
        math(String.raw`g_v(0)\in A=\{0,1\}`), " なので二つの場合がある（",
        ref("def_state_set"), "）。",
        math(String.raw`g_v(0)=0`), " の場合、", math(String.raw`g_v`),
        " が単射なので ", math(String.raw`g_v(1)\neq 0`), " であり ",
        math(String.raw`g_v(1)=1`), " なので ", math(String.raw`g_v=\mathrm{id}_{A}`),
        " である。", math(String.raw`g_v(0)=1`), " の場合、同じく ",
        math(String.raw`g_v(1)\neq 1`), " であり ", math(String.raw`g_v(1)=0`),
        " なので ", math(String.raw`g_v=\nu`), " である（", ref("def_negation_map"), "）。",
        "どちらの場合も ", math(String.raw`g_v\circ g_v=\mathrm{id}_{A}`),
        " である（", math(String.raw`\nu`), " については ",
        math(String.raw`\nu(\nu(0))=\nu(1)=0`), " と ",
        math(String.raw`\nu(\nu(1))=\nu(0)=1`), "）。したがって各 ",
        math(String.raw`x\in A^{V_{\bullet}}`), " と ",
        math(String.raw`v\in V_{\bullet}`), " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(F^{2}x)(v)
&=(F(F\,x))(v)\qquad(\because\ \blkref{def_finite_self_map_iterate})\\
&=g_v\bigl((F\,x)(v)\bigr)\qquad(\because\ \blkref{claim_self_neighborhood_injective_iff_pointwise_bijective})\\
&=g_v\bigl(g_v(x(v))\bigr)\qquad(\because\ \blkref{claim_self_neighborhood_injective_iff_pointwise_bijective})\\
&=x(v)\qquad(\because\ g_v\circ g_v=\mathrm{id}_{A})
\end{aligned}`),
      paragraph([
        "が成り立ち、写像の外延性より ",
        math(String.raw`F^{2}=\mathrm{id}_{A^{V_{\bullet}}}`), " である。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_realized_set",
    kind: "claim",
    title: { text: "この舞台が実現する巡回型は二つだけである" },
    labels: ["claim_self_neighborhood_realized_cycle_types"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_stage_realized_cycle_types"), " の集合について",
      ]),
      displayMath(String.raw`\mathrm{CT}(V_{\bullet},N_{\bullet})=\bigl\{\ \{\!\{1,1,1,1,1,1,1,1\}\!\},\ \{\!\{2,2,2,2\}\!\}\ \bigr\}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`F\in\mathcal M^{\times}(V_{\bullet},N_{\bullet})`),
        " を取り、", ref("claim_self_neighborhood_injective_iff_pointwise_bijective"),
        " の ", math(String.raw`(g_v)_{v\in V_{\bullet}}`),
        " を対応させる。", ref("claim_self_neighborhood_involution"),
        " の証明により各 ", math(String.raw`g_v`), " は ",
        math(String.raw`\mathrm{id}_{A}`), " か ", math(String.raw`\nu`),
        " である。全ての ", math(String.raw`g_v`), " が ",
        math(String.raw`\mathrm{id}_{A}`), " である場合と、ある ",
        math(String.raw`w\in V_{\bullet}`), " で ", math(String.raw`g_w=\nu`),
        " である場合に分ける。",
      ]),
      paragraph([
        "前者では各 ", math(String.raw`x`), " と ", math(String.raw`v`),
        " について ", math(String.raw`(F\,x)(v)=g_v(x(v))=x(v)`),
        " なので ", math(String.raw`F=\mathrm{id}_{A^{V_{\bullet}}}`),
        " である。このとき各 ", math(String.raw`x`), " の周期軌道は ",
        math(String.raw`\{x\}`), " であり（", ref("def_recursive_preimage_tree_code_periodic_orbits"),
        " と ", ref("def_min_period"), "）、その元数は ", math(String.raw`1`),
        " である。", ref("claim_bijective_self_map_orbits_partition_carrier"),
        " により周期軌道は ", math(String.raw`A^{V_{\bullet}}`), " を分割するので軌道は ",
        math(String.raw`8`), " 個あり、", ref("def_reversible_cycle_type"), " により ",
        math(String.raw`\mathrm{ct}(F)=\{\!\{1,1,1,1,1,1,1,1\}\!\}`), " である。",
      ]),
      paragraph([
        "後者では任意の ", math(String.raw`x`), " について ",
        math(String.raw`(F\,x)(w)=\nu(x(w))\neq x(w)`), " であり（",
        ref("def_negation_map"), " により ", math(String.raw`\nu(a)\neq a`),
        "）、よって ", math(String.raw`F\,x\neq x`), " である。",
        ref("claim_self_neighborhood_involution"), " により ",
        math(String.raw`F^{2}x=x`), " なので、", ref("def_min_period"),
        " により最小周期は ", math(String.raw`\pi(x)=2`), " である。",
        ref("claim_periodic_orbit_card_eq_min_period"),
        " により各周期軌道の元数は ", math(String.raw`2`), " であり、",
        ref("claim_bijective_self_map_orbits_partition_carrier"),
        " により軌道の元数の総和は ", math(String.raw`8`), " なので軌道は ",
        math(String.raw`4`), " 個ある。よって ",
        math(String.raw`\mathrm{ct}(F)=\{\!\{2,2,2,2\}\!\}`), " である。",
      ]),
      paragraph([
        "逆に二つの値がどちらも実現することを見る。全ての ",
        math(String.raw`g_v`), " を ", math(String.raw`\mathrm{id}_{A}`),
        " とした族は ", ref("claim_self_neighborhood_injective_iff_pointwise_bijective"),
        " により単射な大域写像を与え、その巡回型は前段により ",
        math(String.raw`\{\!\{1,1,1,1,1,1,1,1\}\!\}`), " である。",
        math(String.raw`g_{v_1}:=\nu`), "・", math(String.raw`g_{v_2}:=g_{v_3}:=\mathrm{id}_{A}`),
        " とした族も同じ理由で単射な大域写像を与え、その巡回型は後段により ",
        math(String.raw`\{\!\{2,2,2,2\}\!\}`), " である。以上より両包含が示された。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_claim_proper_subset",
    kind: "claim",
    title: { text: "近傍を制限した舞台では実現しない分割が存在する" },
    labels: ["claim_locality_restricts_cycle_type"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`\{\!\{8\}\!\}\in\operatorname{Part}(2^{|V_{\bullet}|})\setminus\mathrm{CT}(V_{\bullet},N_{\bullet})`),
        " であり、したがって",
      ]),
      displayMath(String.raw`\mathrm{CT}(V_{\bullet},N_{\bullet})\subsetneq\operatorname{Part}(2^{|V_{\bullet}|})`),
      paragraph([
        "である。すなわち ", ref("claim_reversible_cycle_type_realizes_every_partition"),
        " の主張は、近傍を制限した有限舞台の上の可逆な大域写像に限ると成り立たない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\{\!\{8\}\!\}`), " は正の自然数からなる有限多重集合で、その重複度つき和は ",
        math(String.raw`8=2^{3}=2^{|V_{\bullet}|}`), " なので ",
        ref("def_carrier_cardinality_partitions"), " により ",
        math(String.raw`\operatorname{Part}(2^{|V_{\bullet}|})`), " の元である。",
        "一方 ", ref("claim_self_neighborhood_realized_cycle_types"), " により ",
        math(String.raw`\mathrm{CT}(V_{\bullet},N_{\bullet})`),
        " の元は二つだけであり、", math(String.raw`\{\!\{8\}\!\}`),
        " はそのどちらとも異なる（重複度つき和が同じでも、",
        math(String.raw`8`), " を元に持つ多重集合は ",
        math(String.raw`\{\!\{1,1,1,1,1,1,1,1\}\!\}`), " とも ",
        math(String.raw`\{\!\{2,2,2,2\}\!\}`), " とも一致しない）。",
        "よって ", math(String.raw`\{\!\{8\}\!\}`), " は差集合に属する。",
        ref("claim_stage_realized_cycle_types_decidable"), " により ",
        math(String.raw`\mathrm{CT}(V_{\bullet},N_{\bullet})\subseteq\operatorname{Part}(2^{|V_{\bullet}|})`),
        " なので、真の包含が従う。",
      ]),
      paragraph([
        ref("claim_reversible_cycle_type_realizes_every_partition"), " は近傍 ",
        math(String.raw`N(v)=V`), " の舞台の大域写像全体 ",
        math(String.raw`\mathcal M^{\times}(V)`),
        " について述べられている（", ref("def_conjugacy_class_all_self_maps"),
        "）。いま示したのは、同じ配位集合の上でも近傍を ",
        math(String.raw`N_{\bullet}(v)=\{v\}`),
        " に制限すると実現される巡回型が減ることである。",
      ]),
    ],
  },

  {
    id: "locality_restricts_cycle_type_remark_counting_criterion_insufficient",
    kind: "remark",
    title: { text: "この反例は局所規則の個数の比較からは出ない" },
    labels: ["remark_locality_counting_criterion_insufficient"],
    habitat: "N",
    statement: [
      paragraph([
        "一般に ", math(String.raw`|\mathcal M(V,N)|<|\operatorname{Part}(2^{|V|})|`),
        " ならば ", ref("def_stage_realized_cycle_types"), " の ",
        math(String.raw`\mathrm{CT}(V,N)`), " は ",
        math(String.raw`\operatorname{Part}(2^{|V|})`),
        " の真部分集合である（像の元数は定義域の元数以下だから）。",
        "しかし舞台 ", math(String.raw`(V_{\bullet},N_{\bullet})`), " ではこの十分条件は使えない。",
        ref("claim_stage_global_maps_count"), " により ",
        math(String.raw`|\mathcal M(V_{\bullet},N_{\bullet})|=\bigl(2^{2^{1}}\bigr)^{3}=4^{3}=64`),
        " である一方、", math(String.raw`8`), " の分割の個数は ",
        math(String.raw`22`), " であり、", math(String.raw`64>22`),
        " だからである。上の反例は個数の比較ではなく、実現される巡回型を直接決定して得た。",
      ]),
    ],
  },
]);
