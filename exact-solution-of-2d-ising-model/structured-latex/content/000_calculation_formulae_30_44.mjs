import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "calculation_formulae_031_definition_abs_arg",
    kind: "definition",
    sourcePath: "parts/000_計算公式/030_definition_絶対値と偏角_abs_arg.typ",
    sourceOrdinal: 31,
    title: { text: "絶対値, 偏角" },
    labels: [],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、"]),
      paragraph([
        math(String.raw`|\cdot| : \mathbb{C} \to \mathbb{R}_{\geq 0}`),
        " を",
      ]),
      displayMath(String.raw`|z| := \mathrm{pr}_1(\phi_{\mathrm{polar}}(z))`),
      paragraph(["と定め、", math(String.raw`z`), " の絶対値と呼ぶ。"]),
      paragraph([
        math(String.raw`\arg^{[0,2\pi)} : \mathbb{C} \to \mathbb{R}`),
        " を",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z) := s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z))\right)`,
      ),
      paragraph(["と定め、", math(String.raw`z`), " の偏角と呼ぶ。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_032_claim_arg_of_product",
    kind: "claim",
    sourcePath: "parts/000_計算公式/031_claim_複素数の積のarg.typ",
    sourceOrdinal: 32,
    title: null,
    labels: ["arg_of_product_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        " について、",
        math(String.raw`r_1, r_2 \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta_1, \theta_2 \in \mathbb{R}`),
        " を用いて",
        math(String.raw`\phi_{\mathrm{polar}}(z_i) = [(r_i,\theta_i)]_{\sim}`),
        " とし、",
        math(String.raw`\arg^{[0,2\pi)}(z_i) = \theta_i - 2n_i\pi`),
        "（",
        math(String.raw`n_i \in \mathbb{Z}`),
        "）とすると、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z_1 z_2) =
\begin{cases}
\arg^{[0,2\pi)}(z_1) + \arg^{[0,2\pi)}(z_2) & (0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi) \\
\arg^{[0,2\pi)}(z_1) + \arg^{[0,2\pi)}(z_2) - 2\pi & (2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi)
\end{cases}`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1 z_2)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2))\right) \\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\phi_{\mathrm{polar}}(z_2))\right) \\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1 r_2,\theta_1+\theta_2)]_{\sim})\right) \\
&= s_{[0,2\pi)}\!\left([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}\right)
\end{aligned}`,
      ),
      paragraph([math(String.raw`0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi`), " を場合分け："]),
      paragraph(["a. ",
        math(String.raw`0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi`),
        " のとき:",
      ]),
      displayMath(
        String.raw`s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
= \theta_1+\theta_2-2(n_1+n_2)\pi
= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)`,
      ),
      paragraph(["b. ",
        math(String.raw`2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi`),
        " のとき:",
      ]),
      displayMath(
        String.raw`s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
= \theta_1+\theta_2-2(n_1+n_2+1)\pi
= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)-2\pi`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_033_claim_arg_of_quotient",
    kind: "claim",
    sourcePath: "parts/000_計算公式/032_claim_複素数の商のarg.typ",
    sourceOrdinal: 33,
    title: null,
    labels: ["arg_of_quotient_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        " について同様の設定のもと、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{z_1}{z_2}\right) =
\begin{cases}
\arg^{[0,2\pi)}(z_1) - \arg^{[0,2\pi)}(z_2) & (0 \leq \theta_1-\theta_2-2(n_1-n_2)\pi < 2\pi) \\
\arg^{[0,2\pi)}(z_1) - \arg^{[0,2\pi)}(z_2) + 2\pi & (-2\pi < \theta_1-\theta_2-2(n_1-n_2)\pi < 0)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph(["積の場合と同様の計算による。"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{z_1}{z_2}\right)
= s_{[0,2\pi)}\!\left([\theta_1-\theta_2]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        math(String.raw`-2\pi < \theta_1-\theta_2-2(n_1-n_2)\pi < 2\pi`),
        " を場合分けして結論を得る。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    kind: "claim",
    sourcePath: "parts/000_計算公式/033_claim_複素数の積のargがpiのときのarg同士の関係.typ",
    sourceOrdinal: 34,
    title: null,
    labels: ["range_of_args_of_multiple_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        "（",
        math(String.raw`r_1, r_2 \neq 0`),
        "）について、",
        math(String.raw`\arg^{[0,2\pi)}(z_1 z_2) = \pi`),
        " とする。このとき、",
      ]),
      displayMath(
        String.raw`\begin{cases}
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) = \pi & (\exists m\in\mathbb{Z}\ \text{s.t.}\ 0\leq\theta_1+\theta_2-2m\pi<2\pi) \\
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) = \pi+2\pi & (\exists m\in\mathbb{Z}\ \text{s.t.}\ 2\pi\leq\theta_1+\theta_2-2m\pi<4\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\arg^{[0,2\pi)}(z_1 z_2) = s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}) = \pi`),
        " から場合分け。",
      ]),
      paragraph(["a. ", math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<2\pi`), " のとき: ",
        math(String.raw`\theta_1+\theta_2-2(n_1+n_2)\pi=\pi`),
        " ゆえ ",
        math(String.raw`\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)=\pi`),
        "。",
      ]),
      paragraph(["b. ", math(String.raw`2\pi\leq\theta_1+\theta_2-2(n_1+n_2)\pi<4\pi`), " のとき: ",
        math(String.raw`\theta_1+\theta_2-2(n_1+n_2+1)\pi=\pi`),
        " ゆえ ",
        math(String.raw`\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)=3\pi`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_035_claim_arg_of_square",
    kind: "claim",
    sourcePath: "parts/000_計算公式/034_claim_CCの自乗のarg.typ",
    sourceOrdinal: 35,
    title: { tex: String.raw`\mathbb{C}\text{の自乗の}\arg` },
    labels: ["range_of_args_of_square_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        "、",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z^2) =
\begin{cases}
2\arg^{[0,2\pi)}(z) & (0 \leq \arg^{[0,2\pi)}(z) < \pi) \\
2\arg^{[0,2\pi)}(z) - 2\pi & (\pi \leq \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z^2)
= s_{[0,2\pi)}\!\left([2\theta]_{\sim_{\mathrm{angle}}}\right)`,
      ),
      paragraph([
        math(String.raw`0\leq 2(\theta-2n\pi)<4\pi`),
        " の場合分けによる。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_036_claim_arg_of_reciprocal",
    kind: "claim",
    sourcePath: "parts/000_計算公式/035_claim_CCの逆数のarg.typ",
    sourceOrdinal: 36,
    title: { tex: String.raw`\mathbb{C}\text{の逆数の}\arg` },
    labels: ["range_of_args_of_reciprocal_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        "、",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right) =
\begin{cases}
0 & (\arg^{[0,2\pi)}(z)=0) \\
2\pi - \arg^{[0,2\pi)}(z) & (0<\arg^{[0,2\pi)}(z)<2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z^{-1})
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\!\left(\phi_{\mathrm{polar}}(z^{-1})\right)\right) \\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\!\left([(1/r,-\theta)]_{\sim}\right)\right)
= s_{[0,2\pi)}\!\left([-\theta]_{\sim_{\mathrm{angle}}}\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " より ",
        math(String.raw`-2\pi<-\theta+2n\pi\leq 0`),
        " を場合分けして結論を得る。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_037_note_arg_calculation_tip",
    kind: "note",
    sourcePath: "parts/000_計算公式/036_note_arg計算のコツ_極座標表現を使った偏角の計算方法.typ",
    sourceOrdinal: 37,
    title: null,
    labels: [],
    statement: [
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
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_038_definition_sqrt_of_complex_number",
    kind: "definition",
    sourcePath: "parts/000_計算公式/037_definition_CCのsqrt_複素数の平方根の定義.typ",
    sourceOrdinal: 38,
    title: { tex: String.raw`\mathbb{C}\text{の}\sqrt{\cdot}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\sqrt{\cdot} : \mathbb{C} \to \mathbb{C}`),
        " を以下のように定める。",
      ]),
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`\sqrt{z} := \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z))}^{\,\mathbb{R}_{\geq 0}},\; \frac{1}{2}\cdot s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z))\right)\right)\right]_{\sim}\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_039_claim_sqrt_expansion_via_polar",
    kind: "claim",
    sourcePath: "parts/000_計算公式/038_claim_CCのsqrtの極座標表現による展開.typ",
    sourceOrdinal: 39,
    title: null,
    labels: [],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        "、",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        "、",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        "（",
        math(String.raw`n\in\mathbb{Z}`),
        "）のとき、",
      ]),
      displayMath(
        String.raw`\sqrt{z}
= \phi_{\mathrm{cartesian}}\!\left(\left[\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\; \frac{\theta}{2}-n\pi\right]_{\sim}\right)`,
      ),
    ],
    proof: [todo("TODO（原文も TODO のまま）")],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_040_claim_sqrt_commutativity_condition",
    kind: "claim",
    sourcePath: "parts/000_計算公式/039_claim_sqrtと積が可換になる条件_argの範囲による場合分け.typ",
    sourceOrdinal: 40,
    title: { text: "sqrt と積が可換になる条件" },
    labels: ["condition_of_commutativity_of_sqrt_and_product"],
    statement: [
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        " について、",
      ]),
      displayMath(
        String.raw`\sqrt{z_1 z_2} =
\begin{cases}
\sqrt{z_1}\sqrt{z_2} & (0 \leq \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) < 2\pi) \\
-\sqrt{z_1}\sqrt{z_2} & (2\pi \leq \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) < 4\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\sqrt{z_1 z_2}`),
        " と ",
        math(String.raw`\sqrt{z_1}\sqrt{z_2}`),
        " をそれぞれ ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " で表し比較する。",
        math(String.raw`r_1=0`),
        " または ",
        math(String.raw`r_2=0`),
        " のときは自明。",
        math(String.raw`r_1,r_2\neq 0`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\sqrt{z_1 z_2}
= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\!\frac{s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim})}{2},\;
   \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\!\frac{s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim})}{2}\right)`,
      ),
      displayMath(
        String.raw`\sqrt{z_1}\sqrt{z_2}
= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\!\frac{(\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)}{2},\;
   \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\!\frac{(\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)}{2}\right)`,
      ),
      paragraph([
        math(String.raw`s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim})`),
        " の値が ",
        math(String.raw`[0,2\pi)`),
        " か ",
        math(String.raw`[2\pi,4\pi)`),
        " に属するかで cosおよびsinの符号が決まり、結論を得る。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の cos/sin 展開の詳細計算を要点のみに圧縮した。"],
    },
  },
  {
    id: "calculation_formulae_041_claim_sqrt_squared_is_original",
    kind: "claim",
    sourcePath: "parts/000_計算公式/040_claim_sqrtの2乗は元に戻る.typ",
    sourceOrdinal: 41,
    title: { text: "sqrt の2乗は元に戻る" },
    labels: [],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、", math(String.raw`\sqrt{z}\sqrt{z}=z`)]),
    ],
    proof: [
      paragraph([
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        "、",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " とすると ",
        math(String.raw`\sqrt{z}=\phi_{\mathrm{cartesian}}\!\left([\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\theta/2-n\pi]_{\sim}\right)`),
        " だから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z}\sqrt{z}
&= \phi_{\mathrm{cartesian}}\!\left([\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\theta/2-n\pi]_{\sim}\right)
   \cdot\phi_{\mathrm{cartesian}}\!\left([\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\theta/2-n\pi]_{\sim}\right) \\
&= \phi_{\mathrm{cartesian}}\!\left([r,\theta-2n\pi]_{\sim}\right)
   \quad(\because \sqrt{r}^{\,\mathbb{R}_{\geq 0}}\cdot\sqrt{r}^{\,\mathbb{R}_{\geq 0}}=r) \\
&= \phi_{\mathrm{cartesian}}\!\left([r,\theta]_{\sim}\right)
   = \phi_{\mathrm{cartesian}}(\phi_{\mathrm{polar}}(z)) = z
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_042_claim_square_of_sqrt",
    kind: "claim",
    sourcePath: "parts/000_計算公式/041_claim_自乗のsqrtとremark_負の実数の場合.typ",
    sourceOrdinal: 42,
    title: { tex: String.raw`z = \pm\sqrt{z^2}` },
    labels: ["square_of_sqrt"],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`z = \begin{cases}
\sqrt{z^2} & (0 \leq \arg^{[0,2\pi)}(z) < \pi) \\
-\sqrt{z^2} & (\pi \leq \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([ref("condition_of_commutativity_of_sqrt_and_product"), " より、"]),
      displayMath(
        String.raw`\sqrt{z}\sqrt{z} =
\begin{cases}
\sqrt{z^2} & (0 \leq 2\arg^{[0,2\pi)}(z) < 2\pi) \\
-\sqrt{z^2} & (2\pi \leq 2\arg^{[0,2\pi)}(z) < 4\pi)
\end{cases}`,
      ),
      paragraph([math(String.raw`\sqrt{z}\sqrt{z}=z`), " より結論を得る。"]),
    ],
    notes: [
      paragraph([
        math(String.raw`z \in \mathbb{R}_{<0}`),
        " のとき ",
        math(String.raw`\arg^{[0,2\pi)}(z) = \pi`),
        " であるから ",
        math(String.raw`z = -\sqrt{z^2}`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_043_claim_sqrt_of_reciprocal",
    kind: "claim",
    sourcePath: "parts/000_計算公式/042_claim_CCの逆数のsqrtとremark.typ",
    sourceOrdinal: 43,
    title: { tex: String.raw`\mathbb{C}\text{の逆数の}\sqrt{\cdot}` },
    labels: ["inverse_of_sqrt_cc"],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C},\ z \neq 0`), " について、"]),
      displayMath(
        String.raw`\sqrt{\frac{1}{z}} =
\begin{cases}
\dfrac{1}{\sqrt{z}} & (\arg^{[0,2\pi)}(z) = 0) \\[6pt]
-\dfrac{1}{\sqrt{z}} & (0 < \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`\arg^{[0,2\pi)}(z)+\arg^{[0,2\pi)}(1/z)`),
        " を計算すると、",
        math(String.raw`\theta-2n\pi=0`),
        " のとき ",
        math(String.raw`0`),
        "、",
        math(String.raw`0<\theta-2n\pi<2\pi`),
        " のとき ",
        math(String.raw`2\pi`),
        "。",
      ]),
      paragraph([
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " より ",
        math(String.raw`\sqrt{z}\cdot\sqrt{1/z}=\pm\sqrt{z\cdot(1/z)}=\pm 1`),
        " から結論。",
      ]),
    ],
    notes: [
      paragraph([
        math(String.raw`z \in \mathbb{C}^\times`),
        " について: ",
        math(String.raw`\sqrt{1/z} = 1/\sqrt{z}`),
        " iff ",
        math(String.raw`z \in \mathbb{R}_{>0}`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_044_claim_reciprocal_of_sqrt",
    kind: "claim",
    sourcePath: "parts/000_計算公式/043_claim_CCのsqrtの逆数とremark.typ",
    sourceOrdinal: 44,
    title: { tex: String.raw`\mathbb{C}\text{の}\sqrt{\cdot}\text{の逆数}` },
    labels: ["sqrt_cc_of_inverse"],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`(\sqrt{z})^{-1} = \frac{1}{\sqrt{z}} =
\begin{cases}
\sqrt{1/z} & (\arg^{[0,2\pi)}(z) = 0) \\
-\sqrt{1/z} & (0 < \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([ref("inverse_of_sqrt_cc"), " より。"]),
    ],
    notes: [
      paragraph([
        math(String.raw`z \in \mathbb{C}^\times`),
        " について: ",
        math(String.raw`(\sqrt{z})^{-1} = \sqrt{1/z}`),
        " iff ",
        math(String.raw`z \in \mathbb{R}_{>0}`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_045_theorem_euler_formula_cos_sin",
    kind: "theorem",
    sourcePath: "parts/000_計算公式/044_theorem_cos_sinのEuler表示.typ",
    sourceOrdinal: 45,
    title: { tex: String.raw`\cos,\sin\text{のEuler表示}` },
    labels: ["euler_formula_cos_sin"],
    statement: [
      paragraph([math(String.raw`\forall \theta \in \mathbb{R}`)]),
      displayMath(
        String.raw`\cos\theta = \frac{e^{i\theta} + e^{-i\theta}}{2}`,
      ),
      displayMath(
        String.raw`\sin\theta = \frac{e^{i\theta} - e^{-i\theta}}{2i}`,
      ),
    ],
    proof: [
      paragraph(["Eulerの公式 ", math(String.raw`e^{i\theta} = \cos\theta + i\sin\theta`), " より、"]),
      displayMath(
        String.raw`\begin{aligned}
e^{i\theta} &= \cos\theta + i\sin\theta \\
e^{-i\theta} &= \cos\theta - i\sin\theta
\end{aligned}`,
      ),
      paragraph(["辺々加えると ", math(String.raw`e^{i\theta}+e^{-i\theta}=2\cos\theta`), "、辺々引くと ", math(String.raw`e^{i\theta}-e^{-i\theta}=2i\sin\theta`), "。"]),
    ],
    conversion: { status: "converted" },
  },
]);
