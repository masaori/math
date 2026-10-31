import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/014_even_sector_T_action.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_T_action",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`V^{(+)} \text{ による共役作用}` },
    labels: [],
  },




  {
    id: "evensectorT_claim_V_plus_factors_invertible",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`V^{(+)} \text{ の可逆性}` },
    labels: ["V_plus_factors_invertible"],
    statement: [
      paragraph([
        ref("def_V_plus"),
        " で定めた ",
        math(String.raw`V^{(+)}`),
        " は可逆である。すなわち、",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R^\times`),
        " の元である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("V1_plus_half_invertible"),
        " と ",
        ref("V2_invertible"),
        " により、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        math(String.raw`V_2`),
        " は可逆である。",
      ]),
      paragraph([
        ref("def_invertible_elements_of_R"),
        " (ii) より",
      ]),
      displayMath(
        String.raw`\left(V_1^{(+)}\right)^{1/2}V_2\in R^\times,
\qquad R=\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        ref("V1_plus_half_invertible"),
        " と ",
        ref("def_invertible_elements_of_R"),
        " (ii) より",
      ]),
      displayMath(
        String.raw`\left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}
\in R^\times`,
      ),
      paragraph([ref("def_V_plus"), " より"]),
      displayMath(String.raw`V^{(+)}\in R^\times`),
    ],
    conversion: { status: "added" },
  },


  {
    id: "evensectorT_claim_T_V_plus_is_conjugation",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`T_{(V^{(+)})} = T_{V^{(+)}}` },
    labels: ["T_V_plus_is_conjugation"],
    statement: [
      paragraph([
        ref("def_T_V_plus"),
        " で合成として定めた ",
        math(String.raw`T_{(V^{(+)})}`),
        " は、",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)}`),
        " による共役そのものに一致する。",
      ]),
      displayMath(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
    ],
    proof: [
      paragraph([
        ref("V1_plus_half_invertible"),
        " と ",
        ref("V2_invertible"),
        " により、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
        " と ",
        math(String.raw`V_2`),
        " は可逆である。また ",
        ref("def_invertible_elements_of_R"),
        " (ii) より、",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}V_2`),
        " も可逆である。したがって、",
        ref("conjugation_is_ring_homomorphism"),
        " の合成則 ",
        math(String.raw`T_g \circ T_h = T_{gh}`),
        " を、まず ",
        math(String.raw`g = \left(V_1^{(+)}\right)^{1/2}`),
        "、",
        math(String.raw`h = V_2`),
        " に、次に ",
        math(String.raw`g = \left(V_1^{(+)}\right)^{1/2}V_2`),
        "、",
        math(String.raw`h = \left(V_1^{(+)}\right)^{1/2}`),
        " に適用できる。よって、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}
&=T_{\left(V_1^{(+)}\right)^{1/2}}\circ T_{V_2}\circ T_{\left(V_1^{(+)}\right)^{1/2}}
&&\bigl(\because\ \blkref{def_T_V_plus}\bigr)\\
&= T_{\left(V_1^{(+)}\right)^{1/2}V_2}\circ T_{\left(V_1^{(+)}\right)^{1/2}}
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の合成則}\bigr)\\
&= T_{\left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}}
&&\bigl(\because\ \blkref{conjugation_is_ring_homomorphism}\text{ の合成則}\bigr)\\
&= T_{V^{(+)}}
&&\bigl(\because\ \blkref{def_V_plus}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "ここで合成則は最初に左の 2 つへ、次にその結果と残りの 1 つへ適用した。合成の順序は ",
        math(String.raw`T_{(V^{(+)})}(X) = T_{\left(V_1^{(+)}\right)^{1/2}}\left(T_{V_2}\left(T_{\left(V_1^{(+)}\right)^{1/2}}(X)\right)\right)`),
        " の定義どおりである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_T_V は T_{(V)} を (V_1^{(±)})^{1/2}, V_2 の共役の合成として定義しているが、why_008_applies_only_to_minus_sector で確定したとおりその V は実質 (-) 専用である。偶セクターの議論と混同しないよう、本章では V^{(+)} / T_{(V^{(+)})} という別記号を導入し、008 章の def_T_V を参照せずに定義し直した。",
        "008 章は (V_1^{(±)})^{1/2} を「exp(iK_1H_1^{(±)}) の 1/2 乗」と書いたうえで proof の中で exp((1/2)iK_1H_1^{(±)}) と読み替えている（TV1_hatZ_hatY_012_claim_TV1_TV2_actions の proof）。本章では最初から exp((i/2)K_1H_1^{(+)}) を定義とし、それが V_1^{(+)} の平方根であることを (2) で示した（読み替えを暗黙にしない）。",
        "T_{(V^{(+)})} = T_{V^{(+)}}（合成が積による共役に一致すること）は数値でも確認済み（sagemath/check/047_claim_even_sector_T_action/check_04, 「合成=共役」列）。",
      ],
    },
  },










]);
