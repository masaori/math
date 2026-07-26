import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "calculation_formulae_031_definition_abs_arg",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/030_definition_絶対値と偏角_abs_arg.typ",
    sourceOrdinal: 31,
    title: { text: "絶対値, 偏角" },
    labels: ["def_abs_arg"],
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
    id: "calculation_formulae_031b_claim_abs_basic_properties",
    kind: "claim",
    sourcePath: "structured-latex/content/000_calculation_formulae_30_44.ts",
    sourceOrdinal: 31,
    title: { text: "絶対値の基本性質" },
    labels: ["abs_basic_properties"],
    statement: [
      paragraph([
        ref("def_abs_arg"),
        " の絶対値 ",
        math(String.raw`|\cdot| : \mathbb{C}\to\mathbb{R}_{\ge 0}`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`z=(x,y)\in\mathbb{C}`),
          " について ",
          math(String.raw`|z|=\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}`),
          "。",
        ],
        [
          "(2) ",
          math(String.raw`z=(x,y)\in\mathbb{C}`),
          " について ",
          math(String.raw`|z|^2=x^2+y^2`),
          "。",
        ],
        [
          "(3) ",
          math(String.raw`|z|=0\iff z=0_{\mathbb{C}}`),
          "。",
        ],
        [
          "(4) ",
          math(String.raw`z_1,z_2\in\mathbb{C}`),
          " について ",
          math(String.raw`|z_1z_2|=|z_1|\,|z_2|`),
          "。",
        ],
        [
          "(5) ",
          math(String.raw`z_1,z_2\in\mathbb{C}`),
          " について ",
          math(String.raw`|z_1+z_2|\le|z_1|+|z_2|`),
          "。",
        ],
        [
          "(6) ",
          math(String.raw`x\in\mathbb{R}`),
          " について ",
          math(String.raw`|\iota_{\mathbb{R}\to\mathbb{C}}(x)|=|x|`),
          "（右辺は実数の絶対値）。",
        ],
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\mathbb{C}`),
        " の加法は ",
        ref("complex_numbers_form_a_field"),
        " で定めた ",
        math(String.raw`\mathbb{R}^2`),
        " の成分ごとの加法である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0: ",
        math(String.raw`\operatorname{pr}_1`),
        " が well-defined であること。",
        ref("first_and_second_projections"),
        " は ",
        math(String.raw`\operatorname{pr}_1([(r,\theta)]_{\sim}):=r`),
        " と代表元を用いて定めている。",
        math(String.raw`(r,\theta)\sim(r',\theta')`),
        " とすると ",
        ref("polar_equivalence_class"),
        " より ",
        math(String.raw`r=r'=0`),
        " または ",
        math(String.raw`r=r'`),
        " であり、いずれの場合も ",
        math(String.raw`r=r'`),
        "。よって値は代表元によらない。",
      ]),
      paragraph([
        "Step 1: (1) の証明。",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`|z|=\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))`),
        " であるから、",
        ref("def_phi_polar"),
        " の場合分けに従って計算する。",
      ]),
      displayMath(
        String.raw`\operatorname{pr}_1(\phi_{\mathrm{polar}}(x,y))=
\begin{cases}
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})} & (x>0),\\
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})} & (x<0,\ y\ge 0),\\
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})} & (x<0,\ y<0),\\
y & (x=0,\ y>0),\\
-y & (x=0,\ y<0),\\
0 & (x=0,\ y=0).
\end{cases}`,
      ),
      paragraph([
        "上 3 つの場合は主張の形をしている。残りの 3 つの場合を確かめる。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\sqrt{a}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        math(String.raw`u\ge 0`),
        " かつ ",
        math(String.raw`u^2=a`),
        " を満たす唯一の ",
        math(String.raw`u`),
        " である。",
      ]),
      list([
        [
          math(String.raw`x=0,\ y>0`),
          " のとき ",
          math(String.raw`x^2+y^2=y^2`),
          " であり、",
          math(String.raw`y>0`),
          " すなわち ",
          math(String.raw`y\ge 0`),
          " かつ ",
          math(String.raw`y^2=y^2`),
          " であるから ",
          math(String.raw`\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}=y`),
          "。",
        ],
        [
          math(String.raw`x=0,\ y<0`),
          " のとき ",
          math(String.raw`x^2+y^2=y^2=(-y)^2`),
          " であり、",
          math(String.raw`-y>0`),
          " すなわち ",
          math(String.raw`-y\ge 0`),
          " であるから ",
          math(String.raw`\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}=-y`),
          "。",
        ],
        [
          math(String.raw`x=0,\ y=0`),
          " のとき ",
          math(String.raw`x^2+y^2=0`),
          " であり ",
          math(String.raw`0\ge 0`),
          " かつ ",
          math(String.raw`0^2=0`),
          " であるから ",
          math(String.raw`\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}=0`),
          "。",
        ],
      ]),
      paragraph([
        "以上より、すべての場合で ",
        math(String.raw`|z|=\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}`),
        "。",
      ]),
      paragraph([
        "Step 2: (2) の証明。",
        math(String.raw`x^2+y^2\ge 0`),
        " であり、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a`),
        "（",
        math(String.raw`a\ge 0`),
        "）であるから、",
      ]),
      displayMath(
        String.raw`|z|^2=\left(\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}\right)^2=x^2+y^2
\quad (\because \text{Step 1})`,
      ),
      paragraph([
        "Step 3: 補題（非負実数の平方の比較）。",
        math(String.raw`u,v\in\mathbb{R}_{\ge 0}`),
        " について ",
        math(String.raw`u^2\le v^2\Rightarrow u\le v`),
        " が成り立つ。実際、対偶を示す。",
        math(String.raw`u>v\ (\ge 0)`),
        " とすると ",
        math(String.raw`u>0`),
        " であり、",
      ]),
      displayMath(
        String.raw`u^2=u\cdot u>v\cdot u\ge v\cdot v=v^2
\quad (\because u>v,\ u>0,\ v\ge 0)`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`u^2>v^2`),
        "。特に ",
        math(String.raw`u,v\ge 0`),
        " かつ ",
        math(String.raw`u^2=v^2`),
        " ならば ",
        math(String.raw`u\le v`),
        " かつ ",
        math(String.raw`v\le u`),
        " より ",
        math(String.raw`u=v`),
        "。",
      ]),
      paragraph([
        "Step 4: (3) の証明。",
        math(String.raw`|z|=0`),
        " とすると Step 2 より ",
        math(String.raw`x^2+y^2=|z|^2=0`),
        "。",
        ref("multiplicative_group_of_cc"),
        " の Step 4 で示したとおり ",
        math(String.raw`x^2+y^2=0\iff(x,y)=(0,0)`),
        " であるから ",
        math(String.raw`z=0_{\mathbb{C}}`),
        "。逆に ",
        math(String.raw`z=0_{\mathbb{C}}=(0,0)`),
        " なら Step 1 より ",
        math(String.raw`|z|=\sqrt{0}^{(\mathbb{R}_{\ge 0})}=0`),
        "。",
      ]),
      paragraph([
        "Step 5: (4) の証明。",
        math(String.raw`z_1=(a,b),\ z_2=(c,d)`),
        " とすると ",
        ref("definition_of_cc"),
        " より ",
        math(String.raw`z_1z_2=(ac-bd,\ ad+bc)`),
        " であるから、Step 2 と ",
        ref("multiplicative_group_of_cc"),
        " の Step 5 の恒等式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_1z_2|^2
&= (ac-bd)^2+(ad+bc)^2 \quad (\because \text{Step 2}) \\
&= (a^2+b^2)(c^2+d^2) \\
&= |z_1|^2|z_2|^2 \quad (\because \text{Step 2}) \\
&= \left(|z_1|\,|z_2|\right)^2
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`|z_1z_2|\ge 0`),
        " かつ ",
        math(String.raw`|z_1|\,|z_2|\ge 0`),
        " であるから、Step 3 より ",
        math(String.raw`|z_1z_2|=|z_1|\,|z_2|`),
        "。",
      ]),
      paragraph([
        "Step 6: Cauchy--Schwarz の不等式（2 成分の場合）。",
        math(String.raw`a,b,c,d\in\mathbb{R}`),
        " について次の恒等式（Lagrange の恒等式）が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(ac+bd)^2+(ad-bc)^2
&= a^2c^2+2abcd+b^2d^2+a^2d^2-2abcd+b^2c^2 \\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2 \\
&= (a^2+b^2)(c^2+d^2)
\quad (\because \mathbb{R} \text{ の分配律})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(ad-bc)^2\ge 0`),
        " であるから ",
        math(String.raw`(ac+bd)^2\le(a^2+b^2)(c^2+d^2)=\left(|z_1|\,|z_2|\right)^2`),
        "（最後の等号は Step 2）。",
        math(String.raw`ac+bd\le 0`),
        " のときは ",
        math(String.raw`ac+bd\le 0\le|z_1|\,|z_2|`),
        "。",
        math(String.raw`ac+bd>0`),
        " のときは Step 3 を ",
        math(String.raw`u=ac+bd,\ v=|z_1|\,|z_2|`),
        " に適用して ",
        math(String.raw`ac+bd\le|z_1|\,|z_2|`),
        "。いずれの場合も",
      ]),
      displayMath(String.raw`ac+bd\le|z_1|\,|z_2|`),
      paragraph([
        "Step 7: (5) の証明。",
        math(String.raw`z_1+z_2=(a+c,\ b+d)`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_1+z_2|^2
&= (a+c)^2+(b+d)^2 \quad (\because \text{Step 2}) \\
&= (a^2+b^2)+(c^2+d^2)+2(ac+bd)
\quad (\because \mathbb{R} \text{ の分配律}) \\
&= |z_1|^2+|z_2|^2+2(ac+bd) \quad (\because \text{Step 2}) \\
&\le |z_1|^2+|z_2|^2+2|z_1|\,|z_2| \quad (\because \text{Step 6}) \\
&= \left(|z_1|+|z_2|\right)^2
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`|z_1+z_2|\ge 0`),
        " かつ ",
        math(String.raw`|z_1|+|z_2|\ge 0`),
        " であるから、Step 3 より ",
        math(String.raw`|z_1+z_2|\le|z_1|+|z_2|`),
        "。",
      ]),
      paragraph([
        "Step 8: (6) の証明。",
        ref("inclusion_rr_to_cc"),
        " より ",
        math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}(x)=(x,0)`),
        " であるから、Step 1 より",
      ]),
      displayMath(
        String.raw`\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|
=\sqrt{x^2+0^2}^{(\mathbb{R}_{\ge 0})}
=\sqrt{x^2}^{(\mathbb{R}_{\ge 0})}`,
      ),
      paragraph([
        math(String.raw`x\ge 0`),
        " のときは ",
        math(String.raw`x\ge 0`),
        " かつ ",
        math(String.raw`x^2=x^2`),
        " より ",
        math(String.raw`\sqrt{x^2}^{(\mathbb{R}_{\ge 0})}=x=|x|`),
        "、",
        math(String.raw`x<0`),
        " のときは ",
        math(String.raw`-x>0`),
        " かつ ",
        math(String.raw`(-x)^2=x^2`),
        " より ",
        math(String.raw`\sqrt{x^2}^{(\mathbb{R}_{\ge 0})}=-x=|x|`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。行列ノルムの劣乗法性（labels: matrix_norm_submultiplicativity）の" +
          "証明が K=CC の場合に必要とする絶対値の性質（成分表示・乗法性・三角不等式）を、" +
          "絶対値の定義（labels: def_abs_arg）の直後にまとめて置いた。",
      ],
    },
  },
  {
    id: "calculation_formulae_032_claim_arg_of_product",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/031_claim_複素数の積のarg.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/032_claim_複素数の商のarg.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/033_claim_複素数の積のargがpiのときのarg同士の関係.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/034_claim_CCの自乗のarg.typ",
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
    sourcePath: "_old/typst/parts/000_計算公式/035_claim_CCの逆数のarg.typ",
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
  // 旧 calculation_formulae_037（arg 計算のコツ）は計算の進め方の助言であって主張ではないため、
  // notes/000_calculation_formulae.ts（targets: arg_of_product_of_complex_numbers）へ移設した。
  {
    id: "calculation_formulae_038_definition_sqrt_of_complex_number",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/037_definition_CCのsqrt_複素数の平方根の定義.typ",
    sourceOrdinal: 38,
    title: { tex: String.raw`\mathbb{C}\text{の}\sqrt{\cdot}` },
    labels: ["def_sqrt_cc"],
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
    sourcePath: "_old/typst/parts/000_計算公式/038_claim_CCのsqrtの極座標表現による展開.typ",
    sourceOrdinal: 39,
    title: null,
    labels: ["sqrt_expansion_via_polar"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とし、",
        math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " を ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " なる代表元とする（",
        ref("def_phi_polar"),
        "、",
        ref("polar_equivalence_class"),
        "）。",
        math(String.raw`n\in\mathbb{Z}`),
        " を ",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " を満たすものとすると（このような ",
        math(String.raw`n`),
        " は各 ",
        math(String.raw`\theta\in\mathbb{R}`),
        " に対してただ一つ存在する。",
        ref("angle_section_existence_uniqueness"),
        "）、",
      ]),
      displayMath(
        String.raw`\sqrt{z}
= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\; \frac{\theta}{2}-n\pi\right)\right]_{\sim}\right)`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\sqrt{\cdot}:\mathbb{C}\to\mathbb{C}`),
        " は ",
        ref("def_sqrt_cc"),
        " の複素数の平方根、",
        math(String.raw`\sqrt{\cdot}^{\,\mathbb{R}_{\ge 0}}:\mathbb{R}_{\ge 0}\to\mathbb{R}_{\ge 0}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        " の非負実数の平方根、",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は ",
        ref("def_phi_cartesian"),
        " の写像である。右辺の ",
        math(String.raw`\theta/2-n\pi`),
        " は実数体 ",
        math(String.raw`\mathbb{R}`),
        " 内の演算（",
        math(String.raw`\theta`),
        " と ",
        math(String.raw`1/2`),
        " の積、および ",
        math(String.raw`n\pi`),
        " との差）である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        " を満たす ",
        math(String.raw`n\in\mathbb{Z}`),
        " の存在と一意性は ",
        ref("angle_section_existence_uniqueness"),
        " で証明済みである（",
        ref("section_of_angle_representation"),
        " の定義もこの主張を根拠にしている）。これにより本主張の仮定の意味が確定する。",
      ]),
      paragraph([
        "特に、この一意性から ",
        ref("section_of_angle_representation"),
        " の ",
        math(String.raw`s_{[0,2\pi)}`),
        " について",
      ]),
      displayMath(
        String.raw`s_{[0,2\pi)}\!\left([\theta]_{\sim_{\mathrm{angle}}}\right)=\theta-2n\pi`,
      ),
      paragraph(["が成り立つ。"]),
      paragraph([
        "Step 2: 主張の右辺が代表元 ",
        math(String.raw`(r,\theta)`),
        " の取り方によらないこと。",
        math(String.raw`(r,\theta)\sim(r',\theta')`),
        " とし、",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " をそれぞれ ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        "、",
        math(String.raw`0\le\theta'-2n'\pi<2\pi`),
        " を満たすもの（Step 1 により一意）とする。",
        ref("polar_equivalence_class"),
        " より次の 2 つの場合がある。",
      ]),
      list([
        [
          math(String.raw`r=r'=0`),
          " のとき。",
          ref("definition_of_sqrt_r_positive"),
          " より ",
          math(String.raw`\sqrt{0}^{\,\mathbb{R}_{\ge 0}}=0`),
          " であるから、両辺の内側の対はそれぞれ ",
          math(String.raw`(0,\theta/2-n\pi)`),
          " と ",
          math(String.raw`(0,\theta'/2-n'\pi)`),
          " であり、第 1 成分がともに ",
          math(String.raw`0`),
          " なので ",
          ref("polar_equivalence_class"),
          " の定義（",
          math(String.raw`r=r'=0`),
          " の場合）により同値、すなわち同じ同値類を定める。",
        ],
        [
          math(String.raw`r=r'`),
          " かつ ",
          math(String.raw`\theta\sim_{\mathrm{angle}}\theta'`),
          " のとき。",
          ref("angle_equivalence_class"),
          " より ",
          math(String.raw`\theta-\theta'=2k\pi`),
          " なる ",
          math(String.raw`k\in\mathbb{Z}`),
          " が存在する。すると ",
          math(String.raw`\theta-2(n'+k)\pi=\theta'-2n'\pi\in[0,2\pi)`),
          " であり、",
          math(String.raw`n'+k\in\mathbb{Z}`),
          " だから Step 1 の一意性より ",
          math(String.raw`n=n'+k`),
          "。よって",
        ],
      ]),
      displayMath(
        String.raw`\frac{\theta}{2}-n\pi
=\frac{\theta'+2k\pi}{2}-(n'+k)\pi
=\frac{\theta'}{2}+k\pi-n'\pi-k\pi
=\frac{\theta'}{2}-n'\pi`,
      ),
      paragraph([
        "であり、第 1 成分も ",
        math(String.raw`\sqrt{r}^{\,\mathbb{R}_{\ge 0}}=\sqrt{r'}^{\,\mathbb{R}_{\ge 0}}`),
        " で一致するから、両者は同じ対であり同じ同値類を定める。いずれの場合も右辺は代表元によらない。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`r\ne 0`),
        " の場合。",
        ref("first_and_second_projections"),
        " より",
      ]),
      displayMath(
        String.raw`\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))=\operatorname{pr}_1([(r,\theta)]_{\sim})=r,
\qquad
\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))=\operatorname{pr}_2([(r,\theta)]_{\sim})=[\theta]_{\sim_{\mathrm{angle}}}`,
      ),
      paragraph([
        "（第 2 式は ",
        math(String.raw`r\ne 0`),
        " の場合の定義による。）したがって ",
        ref("def_sqrt_cc"),
        " の定義式に代入して、Step 1 の末尾の等式 ",
        math(String.raw`s_{[0,2\pi)}([\theta]_{\sim_{\mathrm{angle}}})=\theta-2n\pi`),
        " を用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left(\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))\right)\right)\right]_{\sim}\right)
\quad (\because \text{定義}) \\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left([\theta]_{\sim_{\mathrm{angle}}}\right)\right)\right]_{\sim}\right) \\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}(\theta-2n\pi)\right)\right]_{\sim}\right)
\quad (\because \text{Step 1}) \\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
\quad (\because \mathbb{R} \text{ の分配律})
\end{aligned}`,
      ),
      paragraph(["これは主張の右辺そのものである。"]),
      paragraph([
        "Step 4: ",
        math(String.raw`r=0`),
        " の場合。このとき ",
        ref("first_and_second_projections"),
        " より ",
        math(String.raw`\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))=0`),
        " かつ ",
        math(String.raw`\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))=[0]_{\sim_{\mathrm{angle}}}`),
        "（",
        math(String.raw`r=0`),
        " の場合の定義）である。",
        math(String.raw`0\le 0-2\cdot 0\cdot\pi=0<2\pi`),
        " より Step 1 の一意性から ",
        math(String.raw`s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})=0`),
        "。また ",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\sqrt{0}^{\,\mathbb{R}_{\ge 0}}=0`),
        "。よって ",
        ref("def_sqrt_cc"),
        " と ",
        ref("def_phi_cartesian"),
        " より",
      ]),
      displayMath(
        String.raw`\sqrt{z}
=\phi_{\mathrm{cartesian}}\!\left(\left[(0,\ \tfrac{1}{2}\cdot 0)\right]_{\sim}\right)
=\phi_{\mathrm{cartesian}}\!\left(\left[(0,0)\right]_{\sim}\right)
=(0\cdot\cos 0,\ 0\cdot\sin 0)=(0,0)=0_{\mathbb{C}}`,
      ),
      paragraph([
        "一方、主張の右辺は ",
        math(String.raw`\sqrt{r}^{\,\mathbb{R}_{\ge 0}}=\sqrt{0}^{\,\mathbb{R}_{\ge 0}}=0`),
        " であるから、",
        ref("def_phi_cartesian"),
        " より",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
=\left(0\cdot\cos\!\left(\tfrac{\theta}{2}-n\pi\right),\ 0\cdot\sin\!\left(\tfrac{\theta}{2}-n\pi\right)\right)
=(0,0)=0_{\mathbb{C}}`,
      ),
      paragraph([
        "（",
        math(String.raw`\cos,\sin`),
        " の値は ",
        math(String.raw`\mathbb{R}`),
        " の元であり、",
        math(String.raw`\mathbb{R}`),
        " において ",
        math(String.raw`0\cdot a=0`),
        " である。）よって両辺は一致する。",
      ]),
      paragraph([
        "Step 5: 結論。Step 3 と Step 4 により、",
        math(String.raw`r\ne 0`),
        " と ",
        math(String.raw`r=0`),
        " のいずれの場合も主張の等式が成り立つ。Step 2 により右辺は代表元の取り方によらないので、主張は ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " なる任意の代表元 ",
        math(String.raw`(r,\theta)`),
        " について成り立つ。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_040_claim_sqrt_commutativity_condition",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/039_claim_sqrtと積が可換になる条件_argの範囲による場合分け.typ",
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
        math(String.raw`r_1, r_2 \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta_1, \theta_2 \in \mathbb{R}`),
        " を用いて ",
        math(String.raw`\phi_{\mathrm{polar}}(z_1)=[(r_1,\theta_1)]_{\sim}`),
        "、",
        math(String.raw`\phi_{\mathrm{polar}}(z_2)=[(r_2,\theta_2)]_{\sim}`),
        " とする。まず ",
        math(String.raw`\sqrt{z_1 z_2}`),
        " を ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " で表す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z_1 z_2}
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1 z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2))))]_{\sim}\right) \\
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1)\phi_{\mathrm{polar}}(z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\phi_{\mathrm{polar}}(z_2))))]_{\sim}\right) \quad (\because \phi_{\mathrm{polar}} \text{ の同型性}) \\
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{\mathrm{pr}_1([(r_1,\theta_1)]_{\sim}[(r_2,\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1,\theta_1)]_{\sim}[(r_2,\theta_2)]_{\sim})))]_{\sim}\right) \\
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{\mathrm{pr}_1([(r_1 r_2,\theta_1+\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1 r_2,\theta_1+\theta_2)]_{\sim})))]_{\sim}\right) \\
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}))]_{\sim}\right) \\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})\right)
\end{aligned}`,
      ),
      paragraph(["次に ", math(String.raw`\sqrt{z_1}\sqrt{z_2}`), " を計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z_1}\sqrt{z_2}
&= \phi_{\mathrm{cartesian}}\!\left([(\sqrt{r_1}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}}))]_{\sim}\right)\,
\phi_{\mathrm{cartesian}}\!\left([(\sqrt{r_2}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}}))]_{\sim}\right) \\
&= \left(\sqrt{r_1}^{\,\mathbb{R}_{\geq 0}}\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_1}^{\,\mathbb{R}_{\geq 0}}\sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\right)
\left(\sqrt{r_2}^{\,\mathbb{R}_{\geq 0}}\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_2}^{\,\mathbb{R}_{\geq 0}}\sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right) \\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\!\left(\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}}) - \sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right),\right. \\
&\qquad \left.\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\!\left(\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}}) + \sin\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)\right) \\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\!\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right),\ \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\!\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)\right)
\end{aligned}`,
      ),
      paragraph([
        "i. ",
        math(String.raw`r_1=0`),
        " または ",
        math(String.raw`r_2=0`),
        " のとき、",
        math(String.raw`\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}=0`),
        " より両者はともに ",
        math(String.raw`(0,0)`),
        " に等しく ",
        math(String.raw`\sqrt{z_1 z_2}=\sqrt{z_1}\sqrt{z_2}`),
        "。",
      ]),
      paragraph([
        "ii. ",
        math(String.raw`r_1\neq 0`),
        " かつ ",
        math(String.raw`r_2\neq 0`),
        " のとき、",
        math(String.raw`n_1, n_2 \in \mathbb{Z}`),
        " で ",
        math(String.raw`0\leq\theta_1-2n_1\pi<2\pi`),
        "、",
        math(String.raw`0\leq\theta_2-2n_2\pi<2\pi`),
        " を満たすものがそれぞれただ一つ存在する。このとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\!\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
&= \cos\!\tfrac{1}{2}\!\left(\theta_1-2n_1\pi+\theta_2-2n_2\pi\right) \\
&= \cos\!\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right) \\
&= \begin{cases}
\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は偶数}) \\
-\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は奇数})
\end{cases}
\end{aligned}`,
      ),
      paragraph(["同様に"]),
      displayMath(
        String.raw`\sin\!\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
= \begin{cases}
\sin\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は偶数}) \\
-\sin\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は奇数})
\end{cases}`,
      ),
      paragraph([
        "また ",
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<4\pi`),
        " であるから、次で場合分けする。",
      ]),
      paragraph([
        "ii.a ",
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<2\pi`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \cos\!\tfrac{1}{2}\!\left(\theta_1+\theta_2-2(n_1+n_2)\pi\right)
= \cos\!\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right) \\
&= \begin{cases}
\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は偶数}) \\
-\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は奇数})
\end{cases}
\end{aligned}`,
      ),
      paragraph([
        "同様に ",
        math(String.raw`\sin`),
        " も一致するので、この場合 ",
        math(String.raw`\sqrt{z_1 z_2}=\sqrt{z_1}\sqrt{z_2}`),
        "。",
      ]),
      paragraph([
        "ii.b ",
        math(String.raw`2\pi\leq\theta_1+\theta_2-2(n_1+n_2)\pi<4\pi`),
        " のとき、",
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2+1)\pi<2\pi`),
        " より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cos\!\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \cos\!\tfrac{1}{2}\!\left(\theta_1+\theta_2-2(n_1+n_2+1)\pi\right)
= \cos\!\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2+1)\pi\right) \\
&= \begin{cases}
\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2+1 \text{ は偶数}) \\
-\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2+1 \text{ は奇数})
\end{cases}
= \begin{cases}
-\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は偶数}) \\
\cos\tfrac{\theta_1+\theta_2}{2} & (n_1+n_2 \text{ は奇数})
\end{cases}
\end{aligned}`,
      ),
      paragraph([
        "同様に ",
        math(String.raw`\sin`),
        " も符号が反転するので、この場合 ",
        math(String.raw`\sqrt{z_1 z_2}=-\sqrt{z_1}\sqrt{z_2}`),
        "。",
      ]),
      paragraph([
        "以上より、",
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<2\pi \iff 0\leq\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)<2\pi`),
        " などから結論を得る。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_041_claim_sqrt_squared_is_original",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/040_claim_sqrtの2乗は元に戻る.typ",
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
        ref("sqrt_expansion_via_polar"),
        " より ",
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
    sourcePath: "_old/typst/parts/000_計算公式/041_claim_自乗のsqrtとremark_負の実数の場合.typ",
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
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_043_claim_sqrt_of_reciprocal",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/042_claim_CCの逆数のsqrtとremark.typ",
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
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_044_claim_reciprocal_of_sqrt",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/043_claim_CCのsqrtの逆数とremark.typ",
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
    conversion: { status: "converted" },
  },
  {
    id: "calculation_formulae_045_theorem_euler_formula_cos_sin",
    kind: "theorem",
    sourcePath: "_old/typst/parts/000_計算公式/044_theorem_cos_sinのEuler表示.typ",
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
