/**
 * 章「共役類の集合と写像符号の像の全単射」。
 * 一つの有限集合上の自己写像全体を共役で割った集合が、写像符号の像と全単射になり、
 * 共役類の個数が有限決定できることを示す。
 *
 * 有限集合、自然数、写像の合成と全単射だけを使う。R / C は現れない。
 */

import { defineBlocks, displayMath, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "conjugacy_class_code_image_bijection_definition_all_self_maps",
    kind: "definition",
    title: { text: "一つの有限集合上の自己写像全体" },
    labels: ["def_conjugacy_class_all_self_maps"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限集合 ", math(String.raw`X`), " に対し、",
      ]),
      displayMath(String.raw`\operatorname{End}(X):=\{\,F\mid F:X\to X\ \text{は写像}\,\}`),
      paragraph(["と定める。"]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_all_self_maps_finite",
    kind: "claim",
    title: { text: "有限集合上の自己写像全体は有限集合である" },
    labels: ["claim_all_finite_self_maps_finite"],
    habitat: "finite",
    statement: [
      displayMath(String.raw`|\operatorname{End}(X)|=|X|^{|X|}\in\mathbb N`),
    ],
    proof: [
      paragraph([
        ref("def_conjugacy_class_all_self_maps"), " の各元は、有限集合 ",
        math(String.raw`X`), " の各元に対して像を一つ選ぶことで一意に定まる。各入力について ",
        math(String.raw`|X|`), " 通りの選択があり、入力は ", math(String.raw`|X|`),
        " 個なので、有限集合間の写像の個数より主張を得る。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_binary_ca_specialization",
    kind: "claim",
    title: { text: "全近傍の二値セルオートマトンは全ての自己写像を実現する" },
    labels: ["claim_all_self_maps_binary_ca_full_neighborhood_specialization"],
    habitat: "finite",
    statement: [
      paragraph([
        "有限舞台 ", math(String.raw`V`), " の二値配位空間を ", math(String.raw`X:=A^V`),
        " とする。各 ", math(String.raw`F\in\operatorname{End}(X)`), "（",
        ref("def_conjugacy_class_all_self_maps"), "）は、全ての ",
        math(String.raw`v\in V`), " で ", math(String.raw`N(v):=V`),
        " とする二値セルオートマトンの大域写像として実現できる。",
      ]),
    ],
    proof: [
      paragraph([
        "各 ", math(String.raw`v\in V`), " について局所規則を ",
        math(String.raw`f_v(y):=F(y)(v)`), " と定める。", ref("def_global_map"),
        " より、この局所規則族の大域写像は各 ", math(String.raw`y\in X`),
        " と ", math(String.raw`v\in V`), " で ", math(String.raw`F(y)(v)`),
        " に等しく、写像の外延性より ", math(String.raw`F`), " に等しい。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_definition_relation",
    kind: "definition",
    title: { text: "同一有限集合上の共役関係" },
    labels: ["def_conjugacy_class_relation"],
    habitat: "finite",
    statement: [
      paragraph([
        math(String.raw`F,G\in\operatorname{End}(X)`), "（", ref("def_conjugacy_class_all_self_maps"),
        "）に対し、",
      ]),
      displayMath(String.raw`F\approx_X G\quad:\Longleftrightarrow\quad
F\ \text{から}\ G\ \text{への共役全単射}\ h:X\to X\ \text{が存在する}`),
      paragraph([
        "と定める（", ref("def_iterate_monoid_conjugacy_bijection"), "）。",
      ]),
    ],
  },

  {
    id: "conjugacy_class_code_image_bijection_claim_equivalence_relation",
    kind: "claim",
    title: { text: "同一有限集合上の共役関係は同値関係である" },
    labels: ["claim_conjugacy_class_relation_is_equivalence"],
    habitat: "finite",
    statement: [
      paragraph([
        ref("def_conjugacy_class_relation"), " の関係 ",
        math(String.raw`\approx_X`), " は有限集合 ",
        math(String.raw`\operatorname{End}(X)`), " 上の同値関係である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{id}:X\to X`), " を恒等写像、",
        math(String.raw`h:X\to X`), " が全単射のとき ",
        math(String.raw`h^{-1}:X\to X`), " をその逆写像とする。",
      ]),
      paragraph(["反射律。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{id}\circ F&=F\quad(\because\ \text{恒等写像の合成})\\
&=F\circ\mathrm{id}\quad(\because\ \text{恒等写像の合成}).
\end{aligned}`),
      paragraph([
        math(String.raw`\mathrm{id}`), " は全単射なので ",
        ref("def_iterate_monoid_conjugacy_bijection"), " により ",
        math(String.raw`F\approx_X F`), " である。",
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
        math(String.raw`G\approx_X F`), " である。",
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
        math(String.raw`F\approx_X H`), " である。",
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
        math(String.raw`\approx_X`), " は同値関係なので、",
        math(String.raw`F\in\operatorname{End}(X)`), " の共役類を",
      ]),
      displayMath(String.raw`[F]_X:=\{\,G\in\operatorname{End}(X)\mid F\approx_X G\,\}`),
      paragraph(["と書き、共役類全体の集合を"]),
      displayMath(String.raw`\mathcal C(X):=\{\,[F]_X\mid F\in\operatorname{End}(X)\,\}`),
      paragraph([
        "と定める。",
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
      displayMath(String.raw`\mathcal K(\operatorname{End}(X)):=\{\,\mathcal K(F)\mid F\in\operatorname{End}(X)\,\}`),
      paragraph([
        "と定める。",
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
      displayMath(String.raw`\overline{\mathcal K}:\mathcal C(X)\to\mathcal K(\operatorname{End}(X)),
\qquad \overline{\mathcal K}\bigl([F]_X\bigr):=\mathcal K(F)`),
      paragraph([
        "は写像として定まり（代表 ", math(String.raw`F`), " の取り方に依存せず）、全単射である（",
        ref("def_conjugacy_class_quotient"), "、", ref("def_conjugacy_class_code_image"), "）。",
      ]),
    ],
    proof: [
      paragraph([
        "写像として定まること。", math(String.raw`[F]_X=[G]_X`), " とすると ",
        math(String.raw`G\in[G]_X=[F]_X`), " なので ",
        ref("def_conjugacy_class_quotient"), " により ",
        math(String.raw`F\approx_X G`), " であり、",
        ref("def_conjugacy_class_relation"), " により ",
        math(String.raw`F`), " から ", math(String.raw`G`),
        " への共役全単射が存在する。",
        ref("claim_recursive_preimage_tree_code_complete_invariant"),
        " の右から左により ", math(String.raw`\mathcal K(F)=\mathcal K(G)`), " である。",
      ]),
      paragraph([
        "単射性。", math(String.raw`\overline{\mathcal K}([F]_X)=\overline{\mathcal K}([G]_X)`),
        " とすると ", math(String.raw`\mathcal K(F)=\mathcal K(G)`), " であり、",
        ref("claim_recursive_preimage_tree_code_complete_invariant"),
        " の左から右により ", math(String.raw`F`), " から ", math(String.raw`G`),
        " への共役全単射が存在する。",
        ref("def_conjugacy_class_relation"), " により ",
        math(String.raw`F\approx_X G`), " であり、",
        ref("claim_conjugacy_class_relation_is_equivalence"),
        " の対称律・推移律により ", math(String.raw`[F]_X=[G]_X`), " である。",
      ]),
      paragraph([
        "全射性。", math(String.raw`c\in\mathcal K(\operatorname{End}(X))`), " とすると ",
        ref("def_conjugacy_class_code_image"), " により ",
        math(String.raw`\mathcal K(F)=c`), " となる ",
        math(String.raw`F\in\operatorname{End}(X)`), " が存在し、",
        math(String.raw`\overline{\mathcal K}([F]_X)=c`), " である。",
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
      paragraph(["有限集合 ", math(String.raw`X`), " について"]),
      displayMath(String.raw`|\mathcal C(X)|=\bigl|\mathcal K(\operatorname{End}(X))\bigr|\in\mathbb{N}`),
      paragraph([
        "であり、この自然数は ", math(String.raw`X`),
        " とその元の等号から有限回の走査で決定できる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_conjugacy_class_code_image_bijection"), " の全単射により ",
        math(String.raw`|\mathcal C(X)|=|\mathcal K(\operatorname{End}(X))|`), " である。",
      ]),
      paragraph([
        "有限決定。", ref("def_conjugacy_class_all_self_maps"), " により ",
        math(String.raw`\operatorname{End}(X)`), " は ",
        math(String.raw`\bigl(|X|\bigr)^{|X|}`),
        " 個の写像表として列挙でき、各 ",
        math(String.raw`F\in\operatorname{End}(X)`), " の写像符号 ",
        math(String.raw`\mathcal K(F)`), " は ",
        ref("claim_recursive_preimage_tree_code_finite_decidability"),
        " により有限走査で計算できる。写像符号は有限多重集合なので、二つの符号の等号も有限比較で決まり、",
        "列挙した ", math(String.raw`\bigl(|X|\bigr)^{|X|}`),
        " 個の符号から相異なるものを有限回の比較で選び出せる。その個数が ",
        math(String.raw`|\mathcal K(\operatorname{End}(X))|`), " である。",
      ]),
    ],
  },
]);
