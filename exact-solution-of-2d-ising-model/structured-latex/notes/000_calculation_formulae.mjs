import { defineNotes, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「計算公式」に紐づく参照用ノート。文書本体ではないので最終成果物には載らない。

export default defineNotes([
  {
    id: "note_calc_formulae_018_real_scalar_multiple_is_not_scalar_action",
    targets: ["angle_representation_of_rr"],
    title: { text: "積 ·_real がスカラー積にならない反例" },
    sourcePath: "_old/typst/parts/000_計算公式/018_definition_RRの角度表現.typ",
    body: [
      paragraph([
        "この積 ",
        math("\\cdot_{\\mathrm{real}}"),
        " は、例えば次のようになり、スカラー積とはならない。",
      ]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{2}\cdot_{\mathrm{real}}\left(-2\cdot_{\mathrm{real}}[\pi/2]_{\sim_{\mathrm{angle}}}\right)
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}\left(\left[-2\cdot s_{[0,2\pi)}([\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}\right)\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}([-2\cdot\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot s_{[0,2\pi)}([-\pi]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
\left[\frac{1}{2}\cdot\pi\right]_{\sim_{\mathrm{angle}}}
\\
&=
\pi/2
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\left(\frac{1}{2}\cdot(-2)\right)\cdot_{\mathrm{real}}[\pi/2]_{\sim_{\mathrm{angle}}}
&=
\left[-1\cdot s_{[0,2\pi)}([\pi/2]_{\sim_{\mathrm{angle}}})\right]_{\sim_{\mathrm{angle}}}
\\
&=
[-1\cdot\pi/2]_{\sim_{\mathrm{angle}}}
\\
&=
-\pi/2
\end{aligned}`),
      paragraph(["より、スカラー積とはならない。"]),
    ],
  },
  {
    id: "note_calculation_formulae_021_polar_equivalence_class_properties",
    targets: ["polar_equivalence_class"],
    title: { text: "極座標表現の同値類の性質（原文の remark）" },
    sourcePath: "_old/typst/parts/000_計算公式/020_remark_極座標表現の同値類の性質.typ",
    body: [
      displayMath(String.raw`[(r,\theta)]_{\sim} = [(r,\theta + 2n\pi)]_{\sim}\quad \forall n \in \mathbb{Z}`),
      displayMath(
        String.raw`[(0,\theta)]_{\sim} = [(0,\theta')]_{\sim}\quad \forall \theta,\theta' \in \mathbb{R}`,
      ),
    ],
  },
  {
    id: "note_calculation_formulae_029_supplementary_computation",
    targets: ["isomorphism_of_phi_cartesian"],
    title: { text: "原文 note の補足計算（x<0 のときの sin(arctan(y/x)) と符号の根拠、具体例）" },
    sourcePath: "parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ",
    body: [
      paragraph([
        "（原文の note の補足計算）",
        math(String.raw`x<0`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sin(\arctan(y/x))
&= \sin\!\left(\arcsin\!\frac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) \\
&= \frac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}} \\
&= \frac{y}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}} \\
&= \frac{y}{-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}} \\
&= \frac{y}{-\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}} \\
&= -\frac{y}{\sqrt{x^2(1+(y/x)^2)}^{\,\mathbb{R}_{\geq 0}}} \\
&= -\frac{y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x<0`),
        " における符号の根拠は、",
        math(String.raw`-\sqrt{a}^{\,\mathbb{R}_{\geq 0}}=x`),
        " となる ",
        math(String.raw`a`),
        " が ",
        math(String.raw`\sqrt{a}^{\,\mathbb{R}_{\geq 0}}=-x`),
        "、両辺を自乗して ",
        math(String.raw`a=(-x)^2`),
        "、すなわち ",
        math(String.raw`x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}`),
        " であること。",
      ]),
      paragraph([
        "また例えば ",
        math(String.raw`(x,y)=(-1/2,\ \sqrt{3}^{\,\mathbb{R}_{\geq 0}}/2)`),
        " のとき ",
        math(String.raw`\cos(\arctan(y/x)+\pi)=-\cos(\arctan(-\sqrt{3}^{\,\mathbb{R}_{\geq 0}}))=-\sqrt{1-\tfrac{3}{4}}^{\,\mathbb{R}_{\geq 0}}=-\tfrac{1}{2}`),
        "、",
        math(String.raw`\sin(\arctan(y/x))=-\sqrt{3}^{\,\mathbb{R}_{\geq 0}}/2`),
        "。",
      ]),
    ],
  },
  {
    id: "note_calculation_formulae_037_arg_calculation_tip",
    targets: ["arg_of_product_of_complex_numbers"],
    title: { text: "arg 計算のコツ（原文の note）" },
    sourcePath: "_old/typst/parts/000_計算公式/036_note_arg計算のコツ_極座標表現を使った偏角の計算方法.typ",
    body: [
      paragraph([math(String.raw`\arg`), " 計算のコツ："]),
      paragraph([
        math(String.raw`\phi_{\mathrm{polar}}(z_i)=[(r_i,\theta_i)]_{\sim}`),
        " で、",
        math(String.raw`\arg^{[0,2\pi)}(z_i)`),
        " の範囲がわかっているとき、",
        math(String.raw`z_1 z_2`),
        " の偏角を計算するには、まず",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z_1 z_2)
= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\phi_{\mathrm{polar}}(z_2))\right)
= s_{[0,2\pi)}\!\left([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        "と変形し、",
        math(String.raw`?\leq\theta_1+\theta_2-2(n_1+n_2)\pi<?`),
        " の形の不等式から場合分けするとよい。",
      ]),
    ],
  },
  {
    id: "note_calculation_formulae_042_negative_real_case",
    targets: ["square_of_sqrt"],
    title: { text: "負の実数の場合（原文の remark）" },
    sourcePath: "_old/typst/parts/000_計算公式/041_claim_自乗のsqrtとremark_負の実数の場合.typ",
    body: [
      paragraph([
        math(String.raw`z \in \mathbb{R}_{<0}`),
        " のとき ",
        math(String.raw`\arg^{[0,2\pi)}(z) = \pi`),
        " であるから ",
        math(String.raw`z = -\sqrt{z^2}`),
        "。",
      ]),
    ],
  },
  {
    id: "note_calculation_formulae_043_condition_for_naive_identity",
    targets: ["inverse_of_sqrt_cc"],
    title: { text: "素朴な等式が成り立つ必要十分条件（原文の remark）" },
    sourcePath: "_old/typst/parts/000_計算公式/042_claim_CCの逆数のsqrtとremark.typ",
    body: [
      paragraph([
        math(String.raw`z \in \mathbb{C}^\times`),
        " について: ",
        math(String.raw`\sqrt{1/z} = 1/\sqrt{z}`),
        " iff ",
        math(String.raw`z \in \mathbb{R}_{>0}`),
        "。",
      ]),
    ],
  },
  {
    id: "note_calculation_formulae_044_condition_for_naive_identity",
    targets: ["sqrt_cc_of_inverse"],
    title: { text: "素朴な等式が成り立つ必要十分条件（原文の remark）" },
    sourcePath: "_old/typst/parts/000_計算公式/043_claim_CCのsqrtの逆数とremark.typ",
    body: [
      paragraph([
        math(String.raw`z \in \mathbb{C}^\times`),
        " について: ",
        math(String.raw`(\sqrt{z})^{-1} = \sqrt{1/z}`),
        " iff ",
        math(String.raw`z \in \mathbb{R}_{>0}`),
        "。",
      ]),
    ],
  },
]);
