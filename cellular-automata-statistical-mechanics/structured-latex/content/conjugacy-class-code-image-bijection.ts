/**
 * 章「共役類の集合と写像符号の像の全単射」。
 * 一つの有限舞台上の大域写像全体を共役で割った集合が、写像符号の像と全単射になり、
 * 共役類の個数が有限決定できることを示す。
 *
 * 有限集合、自然数、写像の合成と全単射だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "conjugacy_class_code_image_bijection_heading",
    kind: "heading",
    level: 1,
    title: { text: "共役類の集合と写像符号の像の全単射" },
    labels: [],
  },

  {
    id: "conjugacy_class_code_image_bijection_definition_all_global_maps",
    kind: "definition",
    title: { text: "一つの有限舞台上の大域写像全体" },
    labels: ["def_conjugacy_class_all_global_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`V`), "（", ref("def_finite_stage"),
        "）と状態集合 ", math(String.raw`A=\{0,1\}`), "（", ref("def_state_set"),
        "）に対し、",
      ]),
      displayMath(String.raw`\mathcal M(V):=\{\,F\mid F:A^V\to A^V\ \text{は写像}\,\}`),
      paragraph([
        "と定める。", math(String.raw`A^V`), " は有限集合なので ",
        math(String.raw`\mathcal M(V)`), " も有限集合であり、",
      ]),
      displayMath(String.raw`|\mathcal M(V)|=\bigl(2^{|V|}\bigr)^{2^{|V|}}\in\mathbb{N}`),
      paragraph([
        "である。", ref("claim_support_subset_implies_representable"),
        " を近傍 ", math(String.raw`N(v)=V`), " について各セル ",
        math(String.raw`v\in V`), " に適用すると、",
        math(String.raw`\mathcal M(V)`), " の各元は舞台 ",
        math(String.raw`(V,N)`), "（", math(String.raw`N(v)=V`),
        "）上の 2 値セルオートマトン（", ref("def_finite_ca"),
        "）の大域写像（", ref("def_global_map"), "）である。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_definition_relation",
    kind: "definition",
    title: { text: "同一舞台上の共役関係" },
    labels: ["def_conjugacy_class_relation"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F,G\in\mathcal M(V)`), "（", ref("def_conjugacy_class_all_global_maps"),
        "）に対し、",
      ]),
      displayMath(String.raw`F\approx_V G\quad:\Longleftrightarrow\quad
F\ \text{から}\ G\ \text{への共役全単射}\ h:A^V\to A^V\ \text{が存在する}`),
      paragraph([
        "と定める（", ref("def_iterate_monoid_conjugacy_bijection"), "）。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_equivalence_relation",
    kind: "claim",
    title: { text: "同一舞台上の共役関係は同値関係である" },
    labels: ["claim_conjugacy_class_relation_is_equivalence"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_conjugacy_class_relation"), " の関係 ",
        math(String.raw`\approx_V`), " は有限集合 ",
        math(String.raw`\mathcal M(V)`), " 上の同値関係である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{id}:A^V\to A^V`), " を恒等写像、",
        math(String.raw`h:A^V\to A^W`), " が全単射のとき ",
        math(String.raw`h^{-1}:A^W\to A^V`), " をその逆写像とする。",
      ]),
      paragraph(["反射律。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{id}\circ F&=F\quad(\because\ \text{恒等写像の合成})\\
&=F\circ\mathrm{id}\quad(\because\ \text{恒等写像の合成}).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{id}`), " は全単射なので ",
        ref("def_iterate_monoid_conjugacy_bijection"), " により ",
        math(String.raw`F\approx_V F`), " である。",
      ]),
      paragraph([
        "対称律。", math(String.raw`h`), " を ", math(String.raw`F`), " から ",
        math(String.raw`G`), " への共役全単射とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
F\circ h^{-1}&=\mathrm{id}\circ(F\circ h^{-1})\quad(\because\ \text{恒等写像の合成})\\
&=(h^{-1}\circ h)\circ(F\circ h^{-1})\quad(\because\ h^{-1}\circ h=\mathrm{id})\\
&=h^{-1}\circ\bigl((h\circ F)\circ h^{-1}\bigr)\quad(\because\ \text{写像の合成の結合律})\\
&=h^{-1}\circ\bigl((G\circ h)\circ h^{-1}\bigr)\quad(\because\ h\circ F=G\circ h.\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=h^{-1}\circ\bigl(G\circ(h\circ h^{-1})\bigr)\quad(\because\ \text{写像の合成の結合律})\\
&=h^{-1}\circ(G\circ\mathrm{id})\quad(\because\ h\circ h^{-1}=\mathrm{id})\\
&=h^{-1}\circ G\quad(\because\ \text{恒等写像の合成}).
\end{aligned}`),
      paragraph([
        math(String.raw`h^{-1}`), " は全単射なので ",
        ref("def_iterate_monoid_conjugacy_bijection"), " により ",
        math(String.raw`h^{-1}`), " は ", math(String.raw`G`), " から ",
        math(String.raw`F`), " への共役全単射であり、",
        math(String.raw`G\approx_V F`), " である。",
      ]),
      paragraph([
        "推移律。", math(String.raw`h`), " を ", math(String.raw`F`), " から ",
        math(String.raw`G`), " への、", math(String.raw`k`), " を ",
        math(String.raw`G`), " から ", math(String.raw`H`), " への共役全単射とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
(k\circ h)\circ F&=k\circ(h\circ F)\quad(\because\ \text{写像の合成の結合律})\\
&=k\circ(G\circ h)\quad(\because\ h\circ F=G\circ h.\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=(k\circ G)\circ h\quad(\because\ \text{写像の合成の結合律})\\
&=(H\circ k)\circ h\quad(\because\ k\circ G=H\circ k.\ \blkref{def_iterate_monoid_conjugacy_bijection})\\
&=H\circ(k\circ h)\quad(\because\ \text{写像の合成の結合律}).
\end{aligned}`),
      paragraph([
        "全単射の合成は全単射なので ",
        ref("def_iterate_monoid_conjugacy_bijection"), " により ",
        math(String.raw`F\approx_V H`), " である。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_definition_quotient",
    kind: "definition",
    title: { text: "共役類の集合" },
    labels: ["def_conjugacy_class_quotient"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("claim_conjugacy_class_relation_is_equivalence"), " により ",
        math(String.raw`\approx_V`), " は同値関係なので、",
        math(String.raw`F\in\mathcal M(V)`), " の共役類を",
      ]),
      displayMath(String.raw`[F]_V:=\{\,G\in\mathcal M(V)\mid F\approx_V G\,\}`),
      paragraph(["と書き、共役類全体の集合を"]),
      displayMath(String.raw`\mathcal C(V):=\{\,[F]_V\mid F\in\mathcal M(V)\,\}`),
      paragraph([
        "と定める。", math(String.raw`\mathcal M(V)`), " が有限集合なので ",
        math(String.raw`\mathcal C(V)`), " も有限集合である。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_definition_code_image",
    kind: "definition",
    title: { text: "写像符号の像" },
    labels: ["def_conjugacy_class_code_image"],
    habitat: "countable",
    statement: [
      paragraph([
        ref("def_recursive_preimage_tree_code_map_code"), " の写像符号 ",
        math(String.raw`\mathcal K`), " について、",
      ]),
      displayMath(String.raw`\mathcal K(\mathcal M(V)):=\{\,\mathcal K(F)\mid F\in\mathcal M(V)\,\}`),
      paragraph([
        "と定める。", math(String.raw`\mathcal M(V)`),
        " が有限集合なのでこの集合も有限集合である。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_bijection",
    kind: "claim",
    title: { text: "共役類の集合は写像符号の像と全単射である" },
    labels: ["claim_conjugacy_class_code_image_bijection"],
    habitat: "countable",
    statement: [
      paragraph(["対応"]),
      displayMath(String.raw`\overline{\mathcal K}:\mathcal C(V)\to\mathcal K(\mathcal M(V)),
\qquad \overline{\mathcal K}\bigl([F]_V\bigr):=\mathcal K(F)`),
      paragraph([
        "は写像として定まり（代表 ", math(String.raw`F`), " の取り方に依存せず）、全単射である（",
        ref("def_conjugacy_class_quotient"), "、", ref("def_conjugacy_class_code_image"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        "写像として定まること。", math(String.raw`[F]_V=[G]_V`), " とすると ",
        math(String.raw`G\in[G]_V=[F]_V`), " なので ",
        ref("def_conjugacy_class_quotient"), " により ",
        math(String.raw`F\approx_V G`), " であり、",
        ref("def_conjugacy_class_relation"), " により ",
        math(String.raw`F`), " から ", math(String.raw`G`),
        " への共役全単射が存在する。",
        ref("claim_recursive_preimage_tree_code_complete_invariant"),
        " の右から左により ", math(String.raw`\mathcal K(F)=\mathcal K(G)`), " である。",
      ]),
      paragraph([
        "単射性。", math(String.raw`\overline{\mathcal K}([F]_V)=\overline{\mathcal K}([G]_V)`),
        " とすると ", math(String.raw`\mathcal K(F)=\mathcal K(G)`), " であり、",
        ref("claim_recursive_preimage_tree_code_complete_invariant"),
        " の左から右により ", math(String.raw`F`), " から ", math(String.raw`G`),
        " への共役全単射が存在する。",
        ref("def_conjugacy_class_relation"), " により ",
        math(String.raw`F\approx_V G`), " であり、",
        ref("claim_conjugacy_class_relation_is_equivalence"),
        " の対称律・推移律により ", math(String.raw`[F]_V=[G]_V`), " である。",
      ]),
      paragraph([
        "全射性。", math(String.raw`c\in\mathcal K(\mathcal M(V))`), " とすると ",
        ref("def_conjugacy_class_code_image"), " により ",
        math(String.raw`\mathcal K(F)=c`), " となる ",
        math(String.raw`F\in\mathcal M(V)`), " が存在し、",
        math(String.raw`\overline{\mathcal K}([F]_V)=c`), " である。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_count",
    kind: "claim",
    title: { text: "共役類の個数は符号の像の元数に等しく有限決定できる" },
    labels: ["claim_conjugacy_class_count_finite_decidability"],
    habitat: "finite",
    statement: [
      paragraph(["有限集合 ", math(String.raw`V`), " について"]),
      displayMath(String.raw`|\mathcal C(V)|=\bigl|\mathcal K(\mathcal M(V))\bigr|\in\mathbb{N}`),
      paragraph([
        "であり、この自然数は ", math(String.raw`V`),
        " から有限回の走査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_conjugacy_class_code_image_bijection"), " の全単射により ",
        math(String.raw`|\mathcal C(V)|=|\mathcal K(\mathcal M(V))|`), " である。",
      ]),
      paragraph([
        "有限決定。", ref("def_conjugacy_class_all_global_maps"), " により ",
        math(String.raw`\mathcal M(V)`), " は ",
        math(String.raw`\bigl(2^{|V|}\bigr)^{2^{|V|}}`),
        " 個の写像表として列挙でき、各 ",
        math(String.raw`F\in\mathcal M(V)`), " の写像符号 ",
        math(String.raw`\mathcal K(F)`), " は ",
        ref("claim_recursive_preimage_tree_code_finite_decidability"),
        " により有限走査で計算できる。写像符号は有限多重集合なので、二つの符号の等号も有限比較で決まり、",
        "列挙した ", math(String.raw`\bigl(2^{|V|}\bigr)^{2^{|V|}}`),
        " 個の符号から相異なるものを有限回の比較で選び出せる。その個数が ",
        math(String.raw`|\mathcal K(\mathcal M(V))|`), " である。",
      ]),
    ],
  },
]);
