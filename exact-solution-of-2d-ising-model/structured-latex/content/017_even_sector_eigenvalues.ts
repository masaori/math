import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/017_even_sector_eigenvalues.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_eigenvalues",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{定数 } c \text{ の決定と } V^{(+)} \text{ の固有値}` },
    labels: [],
  },

  {
    id: "evenEigen_claim_V_plus_inverse_is_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: {
      tex: String.raw`\left(V^{(+)}\right)^{-1}\text{ は正定値}`,
    },
    labels: ["V_plus_inverse_is_positive_definite"],
    statement: [
      paragraph([
        ref("V_plus_is_invertible"),
        " で明示した ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " は正定値（",
        ref("def_hermitian_positive_definite"),
        " の意味）である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`-\tfrac12S_1^{(+)}`),
        " と ",
        math(String.raw`-S_2`),
        " は実対称、したがってエルミートである。",
        ref("exp_hermitian_is_positive_definite"),
        " (1) より",
      ]),
      list([
        [
          math(String.raw`B_- := \exp(-\tfrac12S_1^{(+)})`),
          " はエルミートかつ正定値",
        ],
        [math(String.raw`A_- := \exp(-S_2)`), " は正定値"],
      ]),
      paragraph([
        math(String.raw`C_-:=\exp(\tfrac12S_1^{(+)})`),
        " と置く。二つの指数の中の行列は、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-\tfrac12S_1^{(+)})(\tfrac12S_1^{(+)})
&= -\tfrac14(S_1^{(+)})^2
   \quad (\because \text{スカラー倍と行列積の結合則}) \\
&= (\tfrac12S_1^{(+)})(-\tfrac12S_1^{(+)})
   \quad (\because \text{スカラーの積は可換})
\end{aligned}`,
      ),
      paragraph([
        "のように可換である。したがって ",
        ref("theorem_exp_product"),
        " と ",
        ref("theorem_exp_zero"),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B_-C_-
&= \exp(-\tfrac12S_1^{(+)})\exp(\tfrac12S_1^{(+)})
   \quad (\because B_-,\ C_- \text{ の定義}) \\
&= \exp\!\left((-\tfrac12S_1^{(+)})+(\tfrac12S_1^{(+)})\right)
   \quad (\because \text{可換な行列の指数関数の積公式}) \\
&= \exp(0)
   \quad (\because (-\tfrac12+\tfrac12)S_1^{(+)}=0) \\
&= I
   \quad (\because \exp(0)=I), \\
C_-B_-
&= \exp(\tfrac12S_1^{(+)})\exp(-\tfrac12S_1^{(+)})
   \quad (\because C_-,\ B_- \text{ の定義}) \\
&= \exp\!\left((\tfrac12S_1^{(+)})+(-\tfrac12S_1^{(+)})\right)
   \quad (\because \text{可換な行列の指数関数の積公式}) \\
&= \exp(0)
   \quad (\because (\tfrac12-\tfrac12)S_1^{(+)}=0) \\
&= I
   \quad (\because \exp(0)=I).
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`B_-`),
        " は可逆であり、その逆行列は ",
        math(String.raw`C_-`),
        " である。",
      ]),
      paragraph([
        math(String.raw`B_-`),
        " がエルミートなので ",
        math(String.raw`B_-^*=B_-`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-\tfrac12S_1^{(+)})\exp(-S_2)\exp(-\tfrac12S_1^{(+)})
&= B_-A_-B_-
   \quad (\because B_-,\ A_- \text{ の定義}) \\
&= B_-^*A_-B_-
   \quad (\because B_-^*=B_-)
\end{aligned}`,
      ),
      paragraph([
        ref("exp_hermitian_is_positive_definite"),
        " (2) より ",
        math(String.raw`B_-^*A_-B_-`),
        " は正定値である。",
        math(String.raw`s_2>0`),
        " より ",
        math(String.raw`(2s_2)^{-M_{\mathrm{col}}/2}>0`),
        " であるから、同 (3) より ",
        math(String.raw`(2s_2)^{-M_{\mathrm{col}}/2}B_-^*A_-B_-`),
        " は正定値である。",
      ]),
      paragraph([
        ref("V_plus_is_invertible"),
        " の明示式と ",
        math(String.raw`B_-^*=B_-`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(V^{(+)}\right)^{-1}
&= (2s_2)^{-M_{\mathrm{col}}/2}\exp(-\tfrac12S_1^{(+)})\exp(-S_2)\exp(-\tfrac12S_1^{(+)})
   \quad (\because \text{逆行列の明示式}) \\
&= (2s_2)^{-M_{\mathrm{col}}/2}B_-A_-B_-
   \quad (\because B_-,\ A_- \text{ の定義}) \\
&= (2s_2)^{-M_{\mathrm{col}}/2}B_-^*A_-B_-
   \quad (\because B_-^*=B_-).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " も正定値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧 V_plus_inverse_positive_and_trace_positivity の Step 1 を、一ブロック一主張として分離した。Lean の対応定理は Ising2D.VPlusInv_posDef。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_V_plus_inverse_positive_definite.sage。候補逆行列の全固有値が正であることを独立に検査する。",
      ],
    },
  },

  {
    id: "evenEigen_claim_V_plus_inverse_positive_and_traces",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)\text{ は正}`,
    },
    labels: ["V_plus_inverse_positive_and_trace_positivity"],
    statement: [
      displayMath(
        String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right) \in \mathbb{R}_{>0}.`,
      ),
    ],
    proof: [
      paragraph([
        ref("V_plus_inverse_is_positive_definite"),
        " と ",
        ref("exp_hermitian_is_positive_definite"),
        " (4) より ",
        math(String.raw`\mathrm{tr}((V^{(+)})^{-1})>0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧複合ブロックから逆行列のトレース正値性を一ブロック一主張として分離した。ラベルは後続参照の互換性のため維持している。Lean の対応定理は Ising2D.trace_VPlusInv_pos。",
        "本文は直前の逆行列の正定値性から正定値行列のトレース正値性を一段で適用する。数値検証は sagemath/check/050_claim_even_sector_eigenvalues/check_05_positive_definite_and_c.sage の逆行列トレース最小値による正値性検査に対応する。",
      ],
    },
  },
]);
