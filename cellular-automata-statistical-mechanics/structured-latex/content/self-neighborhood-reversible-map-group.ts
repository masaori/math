/**
 * 章「自己近傍舞台の可逆大域写像群」。
 * 各セルが自分自身だけを見る有限舞台について、可逆大域写像の合成構造を局所真理値表から決定する。
 * 有限集合、写像、自然数だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "self_neighborhood_reversible_map_group_heading",
    kind: "heading",
    level: 1,
    title: { text: "自己近傍舞台の可逆大域写像群" },
    labels: [],
  },

  {
    id: "self_neighborhood_reversible_map_group_definition_stage",
    kind: "definition",
    title: { text: "有限自己近傍舞台と反転集合が定める大域写像" },
    labels: ["def_finite_self_neighborhood_flip_map"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " の各 ", math(String.raw`v\in V`), " に対して ",
        math(String.raw`N_{\mathrm{self}}(v):=\{v\}`), " と置く。有限部分集合 ",
        math(String.raw`S\subseteq V`), " に対し、写像 ",
        math(String.raw`F_S:A^V\to A^V`), " を",
      ]),
      displayMath(String.raw`(F_Sx)(v):=\begin{cases}\nu(x(v))&v\in S,\\x(v)&v\notin S\end{cases}`),
      paragraph([
        "で定める。ここで ", math(String.raw`A=\{0,1\}`), " と ",
        math(String.raw`\nu:A\to A`), " は ", ref("def_state_set"), " と ",
        ref("def_negation_map"), " の状態集合と否定写像である。",
        math(String.raw`F_S`), " は各セルで恒等写像または否定写像を使うので、",
        math(String.raw`(V,N_{\mathrm{self}})`), " 上の 2 値セルオートマトンの大域写像である（",
        ref("def_global_map"), "）。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_pointwise_form",
    kind: "claim",
    title: { text: "自己近傍舞台では大域写像が各セルの値写像で書ける" },
    labels: ["claim_general_self_neighborhood_pointwise_form"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), " と ",
        ref("def_finite_self_neighborhood_flip_map"), " の ",
        math(String.raw`N_{\mathrm{self}}`), " が定める有限舞台 ",
        math(String.raw`(V,N_{\mathrm{self}})`), " 上の局所規則の族 ",
        math(String.raw`(f_v)_{v\in V}`), " と、各 ", math(String.raw`v\in V`),
        " に対する写像 ", math(String.raw`g_v:A\to A`), " を",
      ]),
      displayMath(String.raw`g_v(a):=f_v(z_a)\qquad\bigl(z_a\in A^{\{v\}},\ z_a(v):=a\bigr)`),
      paragraph(["と定めると、その大域写像 ", math(String.raw`F`), " について"]),
      displayMath(String.raw`(F\,x)(v)=g_v\bigl(x(v)\bigr)\qquad(x\in A^{V},\ v\in V)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`x\in A^{V}`), " と ", math(String.raw`v\in V`), " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
(F\,x)(v)
&=f_v\bigl(\rho^{V}_{N_{\mathrm{self}}(v)}\,x\bigr)\qquad(\because\ \blkref{def_global_map})\\
&=f_v\bigl(\rho^{V}_{\{v\}}\,x\bigr)\qquad(\because\ \blkref{def_finite_self_neighborhood_flip_map})\\
&=f_v\bigl(z_{x(v)}\bigr)\qquad(\because\ \blkref{def_restriction_map}\ \text{より}\ (\rho^{V}_{\{v\}}\,x)(v)=x(v)\ \text{で、写像の外延性})\\
&=g_v\bigl(x(v)\bigr)\qquad(\because\ g_v\ \text{の定義})
\end{aligned}`),
      paragraph(["が成り立つ。"]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_binary_bijection",
    kind: "claim",
    title: { text: "2 元状態集合上の全単射は恒等写像か否定写像である" },
    labels: ["claim_binary_bijection_is_identity_or_negation"],
    habitat: "finite",
    statement: [
      paragraph([
        "全単射 ", math(String.raw`g:A\to A`), " について ",
        math(String.raw`g=\mathrm{id}_{A}`), " または ", math(String.raw`g=\nu`),
        " である（", ref("def_state_set"), " と ", ref("def_negation_map"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`g(0)\in A=\{0,1\}`), " なので二つの場合がある（",
        ref("def_state_set"), "）。", math(String.raw`g(0)=0`), " の場合、",
        math(String.raw`g`), " が単射なので ", math(String.raw`g(1)\neq g(0)=0`),
        " であり ", math(String.raw`g(1)=1`), " なので、写像の外延性より ",
        math(String.raw`g=\mathrm{id}_{A}`), " である。",
        math(String.raw`g(0)=1`), " の場合、同じく ",
        math(String.raw`g(1)\neq g(0)=1`), " であり ", math(String.raw`g(1)=0`),
        " なので、写像の外延性より ", math(String.raw`g=\nu`), " である（",
        ref("def_negation_map"), "）。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_reversible_pointwise_bijective",
    kind: "claim",
    title: { text: "自己近傍舞台の可逆な大域写像の各セルの値写像は全単射である" },
    labels: ["claim_general_self_neighborhood_reversible_pointwise_bijective"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`(V,N_{\mathrm{self}})`), " 上の大域写像 ", math(String.raw`F`),
        " が単射であれば、", ref("claim_general_self_neighborhood_pointwise_form"), " の ",
        math(String.raw`g_v:A\to A`), " は全ての ", math(String.raw`v\in V`),
        " について全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`v\in V`), " と ", math(String.raw`a,a'\in A`), " を取り、",
        math(String.raw`g_v(a)=g_v(a')`), " とする。",
        math(String.raw`x:=\iota^{V}_{\{v\}}\,z_a`), "・",
        math(String.raw`x':=\iota^{V}_{\{v\}}\,z_{a'}`), " と置く（",
        ref("def_base_value_extension"), "）。", ref("def_base_value_extension"),
        " により ", math(String.raw`x(v)=a`), "・", math(String.raw`x'(v)=a'`),
        " であり、", math(String.raw`u\in V\setminus\{v\}`), " については ",
        math(String.raw`x(u)=0=x'(u)`), " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
(F\,x)(v)&=g_v(a)=g_v(a')=(F\,x')(v)\qquad(\because\ \blkref{claim_general_self_neighborhood_pointwise_form}\ \text{と仮定})\\
(F\,x)(u)&=g_u(0)=(F\,x')(u)\qquad(\because\ \blkref{claim_general_self_neighborhood_pointwise_form}\ \text{と}\ x(u)=0=x'(u),\ u\in V\setminus\{v\})
\end{aligned}`),
      paragraph([
        "となり、写像の外延性より ", math(String.raw`F\,x=F\,x'`), " である。",
        math(String.raw`F`), " の単射性より ", math(String.raw`x=x'`), " なので ",
        math(String.raw`a=x(v)=x'(v)=a'`), " である。よって ", math(String.raw`g_v`),
        " は単射であり、", math(String.raw`A`), " は有限集合なので（",
        ref("def_state_set"), "）単射な自己写像は全単射である。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_classification",
    kind: "claim",
    title: { text: "可逆大域写像は反転集合によって一意に分類される" },
    labels: ["claim_self_neighborhood_reversible_maps_classified_by_flip_sets"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限自己近傍舞台 ", math(String.raw`(V,N_{\mathrm{self}})`), " 上の可逆な大域写像全体を ",
        math(String.raw`\mathcal R_{\mathrm{self}}(V)`), " とする。このとき",
      ]),
      displayMath(String.raw`\mathcal P(V)\longrightarrow\mathcal R_{\mathrm{self}}(V),\qquad S\longmapsto F_S`),
      paragraph([
        "は全単射である。したがって ",
        math(String.raw`|\mathcal R_{\mathrm{self}}(V)|=2^{|V|}`), " であり、局所真理値表から有限決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`S\subseteq V`), " を取る。", ref("def_negation_map"), " により ",
        math(String.raw`\nu(\nu(a))=a`), " なので、各 ", math(String.raw`x\in A^V`), " と ",
        math(String.raw`v\in V`), " について場合分けすると",
      ]),
      displayMath(String.raw`(F_S(F_Sx))(v)=x(v)\qquad(\because\ v\in S\ \text{なら}\ \nu^2=\mathrm{id}_A,\ v\notin S\ \text{なら恒等写像})`),
      paragraph([
        "である。写像の外延性より ", math(String.raw`F_S\circ F_S=\mathrm{id}_{A^V}`),
        " なので ", math(String.raw`F_S`), " は全単射であり、写像は well-defined である。",
      ]),
      paragraph([
        "次に ", math(String.raw`F\in\mathcal R_{\mathrm{self}}(V)`), " を取る。",
        ref("claim_general_self_neighborhood_reversible_pointwise_bijective"),
        " により各セルの値写像 ", math(String.raw`g_v:A\to A`), " は全単射であり、",
        ref("claim_binary_bijection_is_identity_or_negation"), " により ",
        math(String.raw`g_v=\mathrm{id}_A`), " または ", math(String.raw`g_v=\nu`),
        " である。そこで",
      ]),
      displayMath(String.raw`S_F:=\{v\in V:g_v=\nu\}`),
      paragraph([
        "と置く。", ref("claim_general_self_neighborhood_pointwise_form"), " により各 ",
        math(String.raw`x\in A^V`), " と ", math(String.raw`v\in V`), " について ",
        math(String.raw`(Fx)(v)=g_v(x(v))`), " なので、",
        math(String.raw`v\in S_F`), " なら ", math(String.raw`(Fx)(v)=\nu(x(v))=(F_{S_F}x)(v)`),
        " であり、", math(String.raw`v\notin S_F`), " なら ",
        math(String.raw`(Fx)(v)=x(v)=(F_{S_F}x)(v)`), " である。二度の写像の外延性より ",
        math(String.raw`F=F_{S_F}`), " なので全射である。",
      ]),
      paragraph([
        math(String.raw`F_S=F_T`), " とする。", math(String.raw`v\in S`), " かつ ",
        math(String.raw`v\notin T`), " なら、定値零配位 ", math(String.raw`x_0(v):=0`), " に対して ",
        math(String.raw`(F_Sx_0)(v)=1`), " かつ ", math(String.raw`(F_Tx_0)(v)=0`),
        " となり矛盾する。よって ", math(String.raw`S\subseteq T`), " である。同じ議論で ",
        math(String.raw`T\subseteq S`), " なので ", math(String.raw`S=T`), " であり単射である。",
        "最後に有限集合の冪集合の元数は ", math(String.raw`2^{|V|}`), " なので元数公式が従う。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_composition",
    kind: "claim",
    title: { text: "合成は反転集合の対称差に一致する" },
    labels: ["claim_self_neighborhood_flip_composition_symmetric_difference"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`S,T\subseteq V`), " に対し、対称差を ",
        math(String.raw`S\mathbin{\triangle}T:=(S\setminus T)\cup(T\setminus S)`), " と定めると",
      ]),
      displayMath(String.raw`F_S\circ F_T=F_{S\mathbin{\triangle}T}=F_T\circ F_S`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`x\in A^V`), " と ", math(String.raw`v\in V`), " を取る。",
        math(String.raw`v\in S`), " と ", math(String.raw`v\in T`), " の真理値には四通りある。",
      ]),
      displayMath(String.raw`((F_S\circ F_T)x)(v)=\begin{cases}x(v)&v\in S\cap T,\\\nu(x(v))&v\in S\setminus T,\\\nu(x(v))&v\in T\setminus S,\\x(v)&v\notin S\cup T.\end{cases}`),
      paragraph([
        "第一の場合は ", math(String.raw`\nu(\nu(x(v)))=x(v)`), "、第二・第三の場合は否定を一度、",
        "第四の場合は恒等写像を二度適用した結果である。この表は ",
        ref("def_finite_self_neighborhood_flip_map"), " による ",
        math(String.raw`(F_{S\mathbin{\triangle}T}x)(v)`), " の表と一致する。",
        "写像の外延性より最初の等号が従う。対称差の定義は ",
        math(String.raw`S`), " と ", math(String.raw`T`), " を交換しても変わらないので二つ目の等号も従う。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_group",
    kind: "claim",
    title: { text: "可逆大域写像は合成について有限可換群をなす" },
    labels: ["claim_self_neighborhood_reversible_maps_finite_commutative_group"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`\mathcal R_{\mathrm{self}}(V)`), " は写像の合成について元数 ",
        math(String.raw`2^{|V|}`), " の有限可換群をなす。単位元は ",
        math(String.raw`F_{\varnothing}`), " で、各元 ", math(String.raw`F_S`),
        " は自分自身を逆元に持つ。",
      ]),
    ],
    proof: [
      paragraph([
        "閉性と可換性は ", ref("claim_self_neighborhood_flip_composition_symmetric_difference"),
        " から従う。写像の合成は結合的である。", ref("def_finite_self_neighborhood_flip_map"),
        " により ", math(String.raw`F_{\varnothing}=\mathrm{id}_{A^V}`), " である。さらに",
      ]),
      displayMath(String.raw`\begin{aligned}
F_S\circ F_S&=F_{S\mathbin{\triangle}S}\qquad(\because\ \blkref{claim_self_neighborhood_flip_composition_symmetric_difference})\\
F_{S\mathbin{\triangle}S}&=F_{\varnothing}\qquad(\because\ S\mathbin{\triangle}S=\varnothing)\\
F_{\varnothing}&=\mathrm{id}_{A^V}\qquad(\because\ \blkref{def_finite_self_neighborhood_flip_map})
\end{aligned}`),
      paragraph([
        "なので各元は逆元を持つ。元数は ",
        ref("claim_self_neighborhood_reversible_maps_classified_by_flip_sets"), " で既に示した。",
      ]),
    ],
  },

  {
    id: "self_neighborhood_reversible_map_group_claim_cycle_type",
    kind: "claim",
    title: { text: "恒等写像以外の全ての可逆写像は固定点を持たない対合である" },
    labels: ["claim_self_neighborhood_reversible_map_cycle_types_general"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`V\neq\varnothing`), " とする。", math(String.raw`S=\varnothing`), " なら ",
        math(String.raw`F_S`), " の巡回型は ", math(String.raw`2^{|V|}`), " 個の 1 からなる。",
        math(String.raw`S\neq\varnothing`), " なら ", math(String.raw`F_S`), " は固定点を持たず、",
        "その巡回型は ", math(String.raw`2^{|V|-1}`), " 個の 2 からなる。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`S=\varnothing`), " の場合は ",
        ref("claim_self_neighborhood_reversible_maps_finite_commutative_group"), " により恒等写像なので、",
        math(String.raw`2^{|V|}`), " 個の配位がそれぞれ一元の周期軌道をなす。",
      ]),
      paragraph([
        math(String.raw`S\neq\varnothing`), " とし、", math(String.raw`v\in S`), " を一つ取る。任意の ",
        math(String.raw`x\in A^V`), " について ", math(String.raw`(F_Sx)(v)=\nu(x(v))\neq x(v)`),
        " なので ", math(String.raw`F_Sx\neq x`), " であり固定点はない。一方 ",
        ref("claim_self_neighborhood_reversible_maps_finite_commutative_group"), " により ",
        math(String.raw`F_S^2=\mathrm{id}_{A^V}`), " なので、全ての周期軌道の元数は 2 である。",
        ref("claim_bijective_self_map_orbits_partition_carrier"), " により周期軌道が ",
        math(String.raw`2^{|V|}`), " 個の配位を分割するので、軌道の個数は ",
        math(String.raw`2^{|V|}/2=2^{|V|-1}`), " である。",
      ]),
    ],
  },
]);
