import { defineNotes, displayMath, math, paragraph, ref } from "../schema.ts";

// 章「数学的道具立て」に紐づく参照用ノート。文書本体ではないので最終成果物には載らない。

export default defineNotes([
  {
    id: "note_mathematical_toolkit_claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map_first_tuple_version",
    targets: ["claim_fixing_second_tuple_of_multilinear_map_gives_multilinear_map"],
    title: { text: "k+l 重線型写像に前の組を固定して入れた写像は l 重線型写像である" },
    body: [
      paragraph([
        "本文の「k+l 重線型写像に後ろの組を固定して入れた写像は k 重線型写像である」の、前の組を固定する版である。",
        "テンソルの積の前の因子についての線型性は、前に掛ける線型写像の和とスカラー倍で示すので、この主張を引く箇所が本文に無い。",
        "そのため本文から外し、ここに置く。",
      ]),
      paragraph([
        math(String.raw`V`),
        "、",
        math(String.raw`k`),
        "、",
        math(String.raw`l`),
        " を ",
        ref("def_concatenation_of_tuples"),
        " のもの、",
        math(String.raw`(U,+_U,\cdot_U,0_U)`),
        " を ℂ-線型空間（",
        ref("def_complex_vector_space"),
        "）、",
        math(String.raw`g:V^{\{1,\dots,k+l\}}\to U`),
        " を ",
        math(String.raw`k+l`),
        " 重線型写像（",
        ref("def_k_multilinear_map"),
        "）、",
        math(String.raw`u\in V^{\{1,\dots,k\}}`),
        " とする。写像 ",
        math(String.raw`g_{u,\bullet}:V^{\{1,\dots,l\}}\to U`),
        " を ",
        math(String.raw`g_{u,\bullet}(u'):=g\bigl(\mathrm{cat}_{k,l}(u,u')\bigr)`),
        " で定める。このとき ",
        math(String.raw`g_{u,\bullet}`),
        " は ",
        math(String.raw`V`),
        " から ",
        math(String.raw`U`),
        " への ",
        math(String.raw`l`),
        " 重線型写像である。",
      ]),
      paragraph([
        math(String.raw`u'\in V^{\{1,\dots,l\}}`),
        "、",
        math(String.raw`r\in\{1,\dots,l\}`),
        "、",
        math(String.raw`x,y\in V`),
        "、",
        math(String.raw`\lambda\in\mathbb{C}`),
        " を任意に取る（",
        math(String.raw`l=0`),
        " のときは条件が無い）。",
        math(String.raw`k+r\in\{1,\dots,k+l\}`),
        " である（",
        ref("claim_concatenation_commutes_with_replacing_component_of_second_tuple"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
g_{u,\bullet}\bigl(u'[r\mapsto x+_V y]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x+_V y]\bigr)\Bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x+_V y]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)+_U g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto y]\bigr)
&&\left(\because\ g\ \text{は第}\ k+r\ \text{成分について加法を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)\Bigr)+_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto y]\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\ \text{を二か所に適用}\right)\\
&=g_{u,\bullet}\bigl(u'[r\mapsto x]\bigr)+_U g_{u,\bullet}\bigl(u'[r\mapsto y]\bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義を二か所に適用}\right).
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g_{u,\bullet}\bigl(u'[r\mapsto \lambda\cdot_V x]\bigr)
&=g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto \lambda\cdot_V x]\bigr)\Bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right)\\
&=g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto \lambda\cdot_V x]\bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=\lambda\cdot_U g\bigl(\mathrm{cat}_{k,l}(u,u')[k+r\mapsto x]\bigr)
&&\left(\because\ g\ \text{は第}\ k+r\ \text{成分についてスカラー倍を保つ。}\blkref{def_k_multilinear_map}\right)\\
&=\lambda\cdot_U g\Bigl(\mathrm{cat}_{k,l}\bigl(u,u'[r\mapsto x]\bigr)\Bigr)
&&\left(\because\ \blkref{claim_concatenation_commutes_with_replacing_component_of_second_tuple}\right)\\
&=\lambda\cdot_U g_{u,\bullet}\bigl(u'[r\mapsto x]\bigr)
&&\left(\because\ g_{u,\bullet}\ \text{の定義}\right).
\end{aligned}`),
    ],
  },
]);
