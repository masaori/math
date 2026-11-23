import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 旧 calculation_formulae_021（極座標表現の同値類の性質の remark）は、定義から直ちに従う
// 読み手向けの補足であり出版本文には載らないため、
// notes/000_calculation_formulae.ts（targets: polar_equivalence_class）へ移設した。
export default defineBlocks([
  {
    id: "calculation_formulae_claim_polar_multiplication_well_defined",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 23 },
    title: {
      text: "極座標表現の積は代表元の取り方によらない",
    },
    labels: ["polar_multiplication_well_defined"],
    statement: [
      paragraph([
        math(String.raw`\sim`),
        " を ",
        ref("polar_equivalence_class"),
        " の同値関係とする。",
        math(String.raw`(r,\theta),(\tilde r,\tilde\theta),(r',\theta'),(\tilde r',\tilde\theta')\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " が",
      ]),
      displayMath(String.raw`(r,\theta)\sim(\tilde r,\tilde\theta) \quad\text{かつ}\quad (r',\theta')\sim(\tilde r',\tilde\theta')`),
      paragraph(["を満たすならば"]),
      displayMath(String.raw`(rr',\theta+\theta')\sim(\tilde r\tilde r',\tilde\theta+\tilde\theta')`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("polar_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim`),
        " と ",
        ref("angle_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim_{\mathrm{angle}}`),
        " を用いる。",
        math(String.raw`\mathbb{R}`),
        " は ",
        ref("polar_equivalence_class"),
        " の台集合から受け継いだもので、この証明が使うのは ",
        math(String.raw`\mathbb{R}`),
        " の四則だけである（極限・完備性は使わない）。",
        ref("polar_equivalence_class"),
        " の定義（",
        math(String.raw`(s,\varphi),(s',\varphi')\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " に対して）",
      ]),
      displayMath(
        String.raw`(s,\varphi)\sim(s',\varphi')\overset{\mathrm{def}}{\Longleftrightarrow}
s=s'=0\ \lor\ \left(s=s'\land\varphi\sim_{\mathrm{angle}}\varphi'\right)`,
      ),
      paragraph(["に従って、次の 2 つの場合に分ける。"]),
      paragraph([
        "場合 (a): ",
        math(String.raw`r=\tilde r=0`),
        " または ",
        math(String.raw`r'=\tilde r'=0`),
        " のとき。",
        math(String.raw`r=\tilde r=0`),
        " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
rr'
&= 0\cdot r'
&&(\because\ r=0)\\
&= 0
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to r'))\\
&= 0\cdot\tilde r'
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to\tilde r')\ \text{を右辺から左辺へ})\\
&= \tilde r\tilde r'
&&(\because\ \tilde r=0)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`r'=\tilde r'=0`),
        " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
rr'
&= r\cdot 0
&&(\because\ r'=0)\\
&= 0
&&(\because\ \blkref{real_times_zero_is_zero}\ (x\to r))\\
&= \tilde r\cdot 0
&&(\because\ \blkref{real_times_zero_is_zero}\ (x\to\tilde r)\ \text{を右辺から左辺へ})\\
&= \tilde r\tilde r'
&&(\because\ \tilde r'=0)
\end{aligned}`),
      paragraph([
        "である。いずれの場合も鎖が ",
        math(String.raw`0`),
        " を通るので、",
        math(String.raw`(rr',\theta+\theta')`),
        " と ",
        math(String.raw`(\tilde r\tilde r',\tilde\theta+\tilde\theta')`),
        " は第 1 成分がともに ",
        math(String.raw`0`),
        " であり、",
        ref("polar_equivalence_class"),
        " の第 1 の選言により ",
        math(String.raw`(rr',\theta+\theta')\sim(\tilde r\tilde r',\tilde\theta+\tilde\theta')`),
        "。",
      ]),
      paragraph([
        "場合 (b): 場合 (a) でないとき。このとき ",
        math(String.raw`(r,\theta)\sim(\tilde r,\tilde\theta)`),
        " の定義における第 1 の選言 ",
        math(String.raw`r=\tilde r=0`),
        " は偽であるから第 2 の選言が成り立ち、",
        math(String.raw`r=\tilde r`),
        " かつ ",
        math(String.raw`\theta\sim_{\mathrm{angle}}\tilde\theta`),
        "。同様に ",
        math(String.raw`r'=\tilde r'`),
        " かつ ",
        math(String.raw`\theta'\sim_{\mathrm{angle}}\tilde\theta'`),
        "。",
      ]),
      paragraph([
        ref("angle_equivalence_class"),
        " より ",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " が存在して ",
        math(String.raw`\theta-\tilde\theta=2n\pi`),
        "、",
        math(String.raw`\theta'-\tilde\theta'=2n'\pi`),
        " であるから、",
      ]),
      displayMath(String.raw`\begin{aligned}
(\theta+\theta')-(\tilde\theta+\tilde\theta')
&= (\theta-\tilde\theta)+(\theta'-\tilde\theta')
&&(\because\ \mathbb{R}\ \text{の和と差の整理})\\
&= 2n\pi+(\theta'-\tilde\theta')
&&(\because\ \theta-\tilde\theta=2n\pi)\\
&= 2n\pi+2n'\pi
&&(\because\ \theta'-\tilde\theta'=2n'\pi)\\
&= 2(n+n')\pi
&&(\because\ \mathbb{R}\ \text{の分配律})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`n+n'\in\mathbb{Z}`),
        " であるから ",
        math(String.raw`\theta+\theta'\sim_{\mathrm{angle}}\tilde\theta+\tilde\theta'`),
        "（",
        ref("angle_equivalence_class"),
        "）。また",
      ]),
      displayMath(String.raw`\begin{aligned}
rr'
&= \tilde rr'
&&(\because\ r=\tilde r)\\
&= \tilde r\tilde r'
&&(\because\ r'=\tilde r')
\end{aligned}`),
      paragraph([
        "であるから、第 2 の選言により ",
        math(String.raw`(rr',\theta+\theta')\sim(\tilde r\tilde r',\tilde\theta+\tilde\theta')`),
        "。いずれの場合も主張の同値が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 「（極座標表現）の乗法群」の証明の冒頭に「準備」として置いていた well-defined 性を、" +
          "積を使う全ての箇所の前提であり 1 ブロック 1 主張の規律に当たるため、独立した主張として切り出し、極座標表現の演算の定義の前に置いた。" +
          "別の代表元の記号を (r_1,θ_1) から (r̃,θ̃) に改めた（結合律の段の (r_1,θ_1) と意味が衝突していたため）。計算は変えていない。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 場合 (a) の鎖が「ℝ では 0 を因子にもつ積は 0」を名前だけで根拠にしていたので、r = r̃ = 0 の鎖と r' = r̃' = 0 の鎖に分け、それぞれ 0 を代入する行と real_zero_times_is_zero・real_times_zero_is_zero（同じファイルの後ろのブロック）の参照の行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/polar_multiplication_well_defined/ の場合 (a) を割った鎖に合わせた。",
      ],
    },
  },
  {
    id: "calculation_formulae_022_definition_operations_on_polar_representation",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/021_definition_極座標表現の演算.typ", ordinal: 22 },
    title: {
      text: "極座標表現の演算",
    },
    labels: ["operations_on_polar_representation"],
    statement: [
      paragraph([ref("polar_equivalence_class"), " の同値類に対して演算を定める。"]),
      paragraph([
        math(String.raw`\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)`),
        " に二項演算 ",
        math(String.raw`\cdot`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\cdot : \left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)\times\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)\to\left((\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim\right)`,
      ),
      displayMath(
        String.raw`\left([(r,\theta)]_{\sim},[(r',\theta')]_{\sim}\right)\mapsto[(rr',\theta+\theta')]_{\sim}`,
      ),
      paragraph([
        "右辺が同値類の代表元の取り方によらないことは ",
        ref("polar_multiplication_well_defined"),
        " による。",
      ]),
      paragraph(["この構造を「極座標表現」と呼ぶ。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_claim_monoid_of_polar_representation",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 23 },
    title: {
      text: "極座標表現は積についてモノイドをなす",
    },
    labels: ["monoid_of_polar_representation"],
    statement: [
      paragraph([
        "（極座標表現）",
        math(String.raw`=(\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim`),
        "（",
        math(String.raw`\sim`),
        " は ",
        ref("polar_equivalence_class"),
        " の同値関係）は、",
        ref("operations_on_polar_representation"),
        " の二項演算 ",
        math(String.raw`\cdot`),
        " についてモノイドをなす。すなわち ",
        math(String.raw`\cdot`),
        " は結合律を満たし、",
      ]),
      displayMath(String.raw`e:=[(1,0)]_{\sim}`),
      paragraph(["は ", math(String.raw`\cdot`), " の単位元である。"]),
    ],
    proof: [
      paragraph([
        "二項演算 ",
        math(String.raw`\cdot`),
        " は ",
        ref("operations_on_polar_representation"),
        " で定め、",
        ref("polar_multiplication_well_defined"),
        " により代表元の取り方によらない。",
        math(String.raw`\mathbb{R}`),
        " は ",
        ref("polar_equivalence_class"),
        " の台集合から受け継いだもので、この証明が使うのは ",
        math(String.raw`\mathbb{R}`),
        " の積と和の結合律・単位元と、非負の数の積が非負であることだけである。",
      ]),
      paragraph([
        "結合律。",
        math(String.raw`[(r_1,\theta_1)]_{\sim},[(r_2,\theta_2)]_{\sim},[(r_3,\theta_3)]_{\sim}\in(\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}\right)\cdot[(r_3,\theta_3)]_{\sim}
&= [(r_1r_2,\theta_1+\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [((r_1r_2)r_3,\ (\theta_1+\theta_2)+\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(r_1(r_2r_3),\ (\theta_1+\theta_2)+\theta_3)]_{\sim}
&&(\because\ \mathbb{R}\ \text{の積の結合律})\\
&= [(r_1(r_2r_3),\ \theta_1+(\theta_2+\theta_3))]_{\sim}
&&(\because\ \mathbb{R}\ \text{の和の結合律})\\
&= [(r_1,\theta_1)]_{\sim}\cdot[(r_2r_3,\theta_2+\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(r_1,\theta_1)]_{\sim}\cdot\left([(r_2,\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim}\right)
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})
\end{aligned}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_1,r_2,r_3\in\mathbb{R}_{\ge 0}`),
        " の積は ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " に属するので、各段の右辺は ",
        math(String.raw`(\text{極座標表現})`),
        " の元である。",
      ]),
      paragraph([
        "単位元。",
        math(String.raw`e=[(1,0)]_{\sim}\in(\text{極座標表現})`),
        "（",
        math(String.raw`1\in\mathbb{R}_{\ge 0}`),
        "）であり、",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot e
&= [(r,\theta)]_{\sim}\cdot[(1,0)]_{\sim}
&&(\because\ e\ \text{の定め方})\\
&= [(r\cdot 1,\ \theta+0)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(r,\ \theta+0)]_{\sim}
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= [(r,\theta)]_{\sim}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \theta)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["であり、また"]),
      displayMath(String.raw`\begin{aligned}
e\cdot[(r,\theta)]_{\sim}
&= [(1,0)]_{\sim}\cdot[(r,\theta)]_{\sim}
&&(\because\ e\ \text{の定め方})\\
&= [(1\cdot r,\ 0+\theta)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(r,\ 0+\theta)]_{\sim}
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= [(r,\theta)]_{\sim}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to \theta)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。結合律と単位元の 2 つより、",
        math(String.raw`(\text{極座標表現})`),
        " は ",
        math(String.raw`\cdot`),
        " について単位元 ",
        math(String.raw`e`),
        " をもつ結合的な二項演算をもつ、すなわちモノイドをなす。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 「（極座標表現）の乗法群」の証明の「結合律」「単位元」「モノイドであること」の段を、" +
          "1 ブロック 1 主張の規律に従って独立した主張として切り出した。計算は変えていない。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 単位元の 2 本の鎖の 4 行が「1 は ℝ の積の単位元」「0 は ℝ の和の単位元」を参照なしで根拠にしていたので、ℝ が体であることを述べる set_and_algebra_notation の参照と、使った形（右から掛ける側は x·1 = x の x → r と x + 0 = x の x → θ、左から掛ける側は 1·x = x の x → r と 0 + x = x の x → θ）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_polar_zero_class_criterion",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 23 },
    title: {
      text: "極座標表現の元が半径零の類に等しいことの判定",
    },
    labels: ["polar_zero_class_criterion"],
    statement: [
      paragraph([
        math(String.raw`\sim`),
        " を ",
        ref("polar_equivalence_class"),
        " の同値関係とする。",
      ]),
      paragraph([math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`), " に対して"]),
      displayMath(String.raw`[(r,\theta)]_{\sim}=[(0,0)]_{\sim}\iff r=0`),
    ],
    proof: [
      paragraph([
        ref("polar_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim`),
        " を用いる。両向きに分けて示す。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Leftarrow`),
        "）",
        math(String.raw`r=0`),
        " ならば ",
        math(String.raw`(0,\theta)`),
        " と ",
        math(String.raw`(0,0)`),
        " は第 1 成分がともに ",
        math(String.raw`0`),
        " であるから、",
        ref("polar_equivalence_class"),
        " の第 1 の選言により ",
        math(String.raw`(0,\theta)\sim(0,0)`),
        "、すなわち ",
        math(String.raw`[(r,\theta)]_{\sim}=[(0,0)]_{\sim}`),
        "。",
      ]),
      paragraph([
        "（",
        math(String.raw`\Rightarrow`),
        "）",
        math(String.raw`[(r,\theta)]_{\sim}=[(0,0)]_{\sim}`),
        " すなわち ",
        math(String.raw`(r,\theta)\sim(0,0)`),
        " のとき、",
        ref("polar_equivalence_class"),
        " の第 1 の選言が成り立つならば ",
        math(String.raw`r=0`),
        "、第 2 の選言が成り立つならば ",
        math(String.raw`r=0`),
        "（右辺の第 1 成分が ",
        math(String.raw`0`),
        " だから）。いずれの場合も ",
        math(String.raw`r=0`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 「（極座標表現）の乗法群」の証明の「零元との一致の判定」の段を、群の主張と逆元の主張の両方が引くため、" +
          "1 ブロック 1 主張の規律に従って独立した主張として切り出した。「零元」は定義の無い語なので使わない。計算は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_inverse_in_polar_representation",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 23 },
    title: {
      text: "極座標表現の半径が正の元は両側の逆元をもつ",
    },
    labels: ["inverse_in_polar_representation"],
    statement: [
      paragraph([
        math(String.raw`\sim`),
        " を ",
        ref("polar_equivalence_class"),
        " の同値関係、",
        math(String.raw`\cdot`),
        " を ",
        ref("operations_on_polar_representation"),
        " の二項演算とし、",
        math(String.raw`(\text{極座標表現})=(\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        "、",
        math(String.raw`r\ne 0`),
        " とし、",
        math(String.raw`e=[(1,0)]_{\sim}`),
        " を ",
        ref("monoid_of_polar_representation"),
        " の単位元とする。",
        math(String.raw`c:=[(1/r,-\theta)]_{\sim}\in(\text{極座標表現})`),
        " は",
      ]),
      displayMath(String.raw`[(r,\theta)]_{\sim}\cdot c=c\cdot[(r,\theta)]_{\sim}=e`),
      paragraph(["を満たす。"]),
    ],
    proof: [
      paragraph([
        ref("operations_on_polar_representation"),
        " の二項演算 ",
        math(String.raw`\cdot`),
        " と、",
        ref("monoid_of_polar_representation"),
        " の単位元 ",
        math(String.raw`e`),
        " を用いる。",
        math(String.raw`\mathbb{R}`),
        " は ",
        ref("polar_equivalence_class"),
        " の台集合から受け継いだもので、この証明が使うのは ",
        math(String.raw`\mathbb{R}`),
        " の四則と順序だけである（極限・完備性は使わない）。",
      ]),
      paragraph([
        math(String.raw`r\in\mathbb{R}_{\ge 0}`),
        " かつ ",
        math(String.raw`r\ne 0`),
        " より ",
        math(String.raw`r>0`),
        " であるから ",
        math(String.raw`1/r\in\mathbb{R}_{>0}\subset\mathbb{R}_{\ge 0}`),
        " が定まり、",
        math(String.raw`c=[(1/r,-\theta)]_{\sim}\in(\text{極座標表現})`),
        "。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot[(1/r,-\theta)]_{\sim}
&= [(r\cdot(1/r),\ \theta+(-\theta))]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(1,\ \theta+(-\theta))]_{\sim}
&&(\because\ r>0\ \text{より}\ r\cdot(1/r)=1)\\
&= [(1,0)]_{\sim}
&&(\because\ -\theta\ \text{は}\ \theta\ \text{の}\ \mathbb{R}\ \text{における加法の逆元})\\
&= e
&&(\because\ e\ \text{の定め方。}\blkref{monoid_of_polar_representation})
\end{aligned}`),
      paragraph(["であり、また"]),
      displayMath(String.raw`\begin{aligned}
[(1/r,-\theta)]_{\sim}\cdot[(r,\theta)]_{\sim}
&= [((1/r)\cdot r,\ (-\theta)+\theta)]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&= [(1,\ (-\theta)+\theta)]_{\sim}
&&(\because\ r>0\ \text{より}\ (1/r)\cdot r=1)\\
&= [(1,0)]_{\sim}
&&(\because\ -\theta\ \text{は}\ \theta\ \text{の}\ \mathbb{R}\ \text{における加法の逆元})\\
&= e
&&(\because\ e\ \text{の定め方。}\blkref{monoid_of_polar_representation})
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 「（極座標表現）の乗法群」の主張のうち逆元の形と、証明の「逆元の存在」の段を、" +
          "1 ブロック 1 主張の規律に従って独立した主張として切り出した。一意性は right_inverse_in_polar_representation_is_unique に分けた。計算は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_right_inverse_in_polar_representation_is_unique",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 23 },
    title: {
      text: "極座標表現の半径が正の元に右から掛けて単位元になる元はただ一つ",
    },
    labels: ["right_inverse_in_polar_representation_is_unique"],
    statement: [
      paragraph([
        math(String.raw`\sim`),
        " を ",
        ref("polar_equivalence_class"),
        " の同値関係、",
        math(String.raw`\cdot`),
        " を ",
        ref("operations_on_polar_representation"),
        " の二項演算とし、",
        math(String.raw`(\text{極座標表現})=(\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim`),
        " とする。",
      ]),
      paragraph([
        math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        "、",
        math(String.raw`r\ne 0`),
        " とし、",
        math(String.raw`e=[(1,0)]_{\sim}`),
        " を ",
        ref("monoid_of_polar_representation"),
        " の単位元とする。",
        math(String.raw`b\in(\text{極座標表現})`),
        " が",
      ]),
      displayMath(String.raw`[(r,\theta)]_{\sim}\cdot b=e`),
      paragraph(["を満たすならば"]),
      displayMath(String.raw`b=[(1/r,-\theta)]_{\sim}`),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        ref("operations_on_polar_representation"),
        " の二項演算 ",
        math(String.raw`\cdot`),
        " と、",
        ref("monoid_of_polar_representation"),
        " の単位元 ",
        math(String.raw`e`),
        " と結合律を用いる。",
        math(String.raw`a:=[(r,\theta)]_{\sim}`),
        "、",
        math(String.raw`c:=[(1/r,-\theta)]_{\sim}`),
        " とおくと、",
        ref("inverse_in_polar_representation"),
        " より ",
        math(String.raw`c\in(\text{極座標表現})`),
        " かつ ",
        math(String.raw`c\cdot a=e`),
        "。",
      ]),
      paragraph([
        math(String.raw`b\in(\text{極座標表現})`),
        " が ",
        math(String.raw`a\cdot b=e`),
        " を満たすとすると、",
      ]),
      displayMath(String.raw`\begin{aligned}
b
&= e\cdot b
&&(\because\ e\ \text{は}\ \cdot\ \text{の単位元。}\blkref{monoid_of_polar_representation})\\
&= (c\cdot a)\cdot b
&&(\because\ c\cdot a=e\text{。}\blkref{inverse_in_polar_representation})\\
&= c\cdot(a\cdot b)
&&(\because\ \cdot\ \text{の結合律。}\blkref{monoid_of_polar_representation})\\
&= c\cdot e
&&(\because\ a\cdot b=e)\\
&= c
&&(\because\ e\ \text{は}\ \cdot\ \text{の単位元。}\blkref{monoid_of_polar_representation})
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 「（極座標表現）の乗法群」の証明の「逆元の一意性」の段を、1 ブロック 1 主張の規律に従って独立した主張として切り出した。" +
          "下流（φ_polar(z^{-1}) の計算）は φ_polar(z^{-1}) が (極座標表現)^× に入ることも左からの積が e になることも示さずに逆元の形を引くので、" +
          "(極座標表現) 全体の元について、右から掛けた積 a·b = e だけを条件として述べる。" +
          "旧版は一般の集合 S について両側の逆元の一意性を述べていたが、人手証明を具体に固定する規律に従い、極座標表現の元と · で述べた。",
      ],
    },
  },
  {
    id: "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/022_claim_極座標表現の乗法群.typ", ordinal: 23 },
    title: {
      text: "（極座標表現）の乗法群",
    },
    labels: ["multiplicative_group_of_polar_representation"],
    statement: [
      paragraph([
        math(String.raw`\sim`),
        " を ",
        ref("polar_equivalence_class"),
        " の同値関係、",
        math(String.raw`\cdot`),
        " を ",
        ref("operations_on_polar_representation"),
        " の二項演算とし、",
        math(String.raw`(\text{極座標表現})=(\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim`),
        " とする。",
      ]),
      displayMath(
        String.raw`(\text{極座標表現})^{\times} := (\text{極座標表現})\setminus\{[(0,0)]_{\sim}\}`,
      ),
      paragraph(["は二項演算 ", math(String.raw`\cdot`), " について群をなす。"]),
    ],
    proof: [
      paragraph([
        ref("operations_on_polar_representation"),
        " の二項演算 ",
        math(String.raw`\cdot`),
        " と、",
        ref("monoid_of_polar_representation"),
        " の単位元 ",
        math(String.raw`e=[(1,0)]_{\sim}`),
        " を用いる。",
        math(String.raw`\mathbb{R}`),
        " は ",
        ref("polar_equivalence_class"),
        " の台集合から受け継いだもので、この証明が使うのは ",
        math(String.raw`\mathbb{R}`),
        " の四則と順序だけである（極限・完備性は使わない）。",
      ]),
      paragraph([
        "積で閉じること。",
        math(String.raw`[(r,\theta)]_{\sim},[(r',\theta')]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると、",
        ref("polar_zero_class_criterion"),
        " より ",
        math(String.raw`r\ne 0`),
        " かつ ",
        math(String.raw`r'\ne 0`),
        "。",
        math(String.raw`r,r'\in\mathbb{R}_{\ge 0}`),
        " かつ ",
        math(String.raw`r,r'\ne 0`),
        " より ",
        math(String.raw`r>0`),
        " かつ ",
        math(String.raw`r'>0`),
        " であるから ",
        math(String.raw`rr'>0`),
        "、特に ",
        math(String.raw`rr'\ne 0`),
        "。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim}
&= [(rr',\theta+\theta')]_{\sim}
&&(\because\ \text{極座標表現の積の定義。}\blkref{operations_on_polar_representation})\\
&\ne [(0,0)]_{\sim}
&&(\because\ rr'\ne 0\ \text{と}\ \blkref{polar_zero_class_criterion})
\end{aligned}`),
      paragraph([
        "すなわち積は ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " に属する。",
      ]),
      paragraph([
        "単位元を含むこと。",
        math(String.raw`1\ne 0`),
        " と ",
        ref("polar_zero_class_criterion"),
        " より ",
        math(String.raw`e=[(1,0)]_{\sim}\ne[(0,0)]_{\sim}`),
        " であり、",
        math(String.raw`e\in(\text{極座標表現})^{\times}`),
        "。",
      ]),
      paragraph([
        "逆元をもつこと。",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると、",
        ref("polar_zero_class_criterion"),
        " より ",
        math(String.raw`r\ne 0`),
        " であり、",
        math(String.raw`r\in\mathbb{R}_{\ge 0}`),
        " と合わせて ",
        math(String.raw`r>0`),
        " である。",
        ref("inverse_in_polar_representation"),
        " より ",
        math(String.raw`[(1/r,-\theta)]_{\sim}`),
        " は ",
        math(String.raw`[(r,\theta)]_{\sim}\cdot[(1/r,-\theta)]_{\sim}=[(1/r,-\theta)]_{\sim}\cdot[(r,\theta)]_{\sim}=e`),
        " を満たす。",
        math(String.raw`r>0`),
        " より ",
        math(String.raw`1/r\ne 0`),
        " なので、",
        ref("polar_zero_class_criterion"),
        " より ",
        math(String.raw`[(1/r,-\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        "。",
      ]),
      paragraph([
        "結論。",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " は ",
        math(String.raw`\cdot`),
        " について閉じており、",
        ref("monoid_of_polar_representation"),
        " より結合律を満たし、単位元 ",
        math(String.raw`e`),
        " を含み、各元が ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " の中に逆元をもつ。したがって ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " は ",
        math(String.raw`\cdot`),
        " について群をなす。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "二項演算 · の well-defined 性は極座標表現の演算の定義に含まれていないが、" +
          "本主張（モノイド・群であること）の前提として必要なので準備として示した。",
        "2026-08-08: 式変形の書き方を統一した。中身は変えていない。" +
          "全体は well-defined 性・結合律・単位元・零元との一致の判定・逆元など" +
          "独立した中間目標へ分かれるので 1 つの鎖にはせず、" +
          "その中に現れる計算をそれぞれ一続きの式にして各行の末尾へ (∵ …) を付けた。" +
          "結合律の段は ℝ の積の結合律と和の結合律を 1 行で同時に使っていたので 2 段へ分け、" +
          "単位元と逆元の段は 2 つの向きの計算が 1 つの整列した式に詰まっていたので" +
          "別々の鎖に分けたうえで、暗黙だった単位元の適用を段として明示した" +
          "（したがって段は増えており、減った段は無い）。" +
          "あわせて Step の番号を内容の分かる名前へ改め、" +
          "証明の中の相互参照（「Step 4 より」等）も名前で指すようにした" +
          "（リポジトリの規約「文書・定理を番号や記号で管理しない」）。",
        "2026-11-01: SageMath の検算のレビューで、1 ブロック 1 主張の規律に従い、" +
          "主張の「（極座標表現）はモノイドをなす」と逆元の形、証明の well-defined 性・結合律・単位元・[(0,0)] との一致の判定・逆元の存在と一意性の段を、" +
          "polar_multiplication_well_defined・monoid_of_polar_representation・polar_zero_class_criterion・" +
          "inverse_in_polar_representation（存在）・right_inverse_in_polar_representation_is_unique（一意性）へ切り出した。" +
          "下流の逆元の形の参照は一意性の主張へ付け替えた。計算は変えていない。" +
          "付け替えの後、この主張を引く本文は無いが、元の論文の主張そのものであり、切り出した主張がそろって (極座標表現)^× の群の構造を与えることを" +
          "述べる結論の位置にあるので残す（どこからも使われない主張を退避するかは、検算の作業とは別に章立ての棚卸しで判断する）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_multiplication_is_commutative",
    kind: "claim",
    title: {
      tex: "\\mathbb{C}\\text{の積の可換律}",
    },
    labels: ["complex_multiplication_is_commutative"],
    statement: [
      paragraph([
        ref("definition_of_cc"),
        " の積について、任意の ",
        math(String.raw`z,w\in\mathbb{C}`),
        " に対して",
      ]),
      displayMath(String.raw`w\cdot z=z\cdot w`),
      paragraph([
        "が成り立つ（",
        math(String.raw`z`),
        " と ",
        math(String.raw`w`),
        " は ",
        math(String.raw`0_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）でもよい）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z=(a,b),\ w=(c,d)`),
        " と書く（",
        math(String.raw`a,b,c,d\in\mathbb{R}`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
w\cdot z
&= (c,d)\cdot(a,b)
&&(\because\ w=(c,d),\ z=(a,b))\\
&= (ca-db,\ cb+da)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (ac-bd,\ cb+da)
&&\bigl(\because\ \mathbb{R}\ \text{の積の可換律}\ xy = yx\ (x \to c,\ y \to a\ \text{と}\ x \to d,\ y \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= (ac-bd,\ bc+ad)
&&\bigl(\because\ \mathbb{R}\ \text{の積の可換律}\ xy = yx\ (x \to c,\ y \to b\ \text{と}\ x \to d,\ y \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= (ac-bd,\ ad+bc)
&&\bigl(\because\ \mathbb{R}\ \text{の和の可換律}\ x + y = y + x\ (x \to bc,\ y \to ad)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (a,b)\cdot(c,d)
&&(\because\ \blkref{definition_of_cc}\ \text{の積を右辺から左辺へ})\\
&= z\cdot w
&&(\because\ z=(a,b),\ w=(c,d))
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。ℂ の全元についての積の可換律は multiplicative_group_of_cc の証明の中の段にしか無く、その主張は「ℂ^× は群をなす」だけなので、complex_numbers_form_a_field の右からの分配律の鎖が 0_ℂ になりうる元 (c,d)+(e,f) に可換律を当てるとき引ける主張が無かった。multiplicative_group_of_cc の証明の「積の可換律」の段の鎖を、式を変えずにこの主張の証明へ移した（鎖の両端を主張の両辺 w·z・z·w に揃え、z, w を成分に開く行と閉じる行を足した。ℝ の積と和の可換律の行は、同じファイルの ℝ の単位元の行と同じく set_and_algebra_notation の参照と使った形と代入の行にした）。Lean の具体版は無い（Lean の ℂ は mathlib の Complex で、可換律は使う側が mul_comm で閉じている）。数値検証: sagemath/check/complex_multiplication_is_commutative/check_component_chain.sage。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_multiplication_is_associative",
    kind: "claim",
    title: {
      tex: "\\mathbb{C}\\text{の積の結合律}",
    },
    labels: ["complex_multiplication_is_associative"],
    statement: [
      paragraph([
        ref("definition_of_cc"),
        " の積について、任意の ",
        math(String.raw`z,w,u\in\mathbb{C}`),
        " に対して",
      ]),
      displayMath(String.raw`(z\cdot w)\cdot u=z\cdot(w\cdot u)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`z`),
        "・",
        math(String.raw`w`),
        "・",
        math(String.raw`u`),
        " は ",
        math(String.raw`0_{\mathbb{C}}`),
        "（",
        ref("inclusion_rr_to_cc"),
        "）でもよい）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z=(a,b),\ w=(c,d),\ u=(e,f)`),
        " と書く（",
        math(String.raw`a,b,c,d,e,f\in\mathbb{R}`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(z\cdot w)\cdot u
&= \left((a,b)\cdot(c,d)\right)\cdot(e,f)
&&(\because\ z=(a,b),\ w=(c,d),\ u=(e,f))\\
&= (ac-bd,\ ad+bc)\cdot(e,f)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \left((ac-bd)e-(ad+bc)f,\ (ac-bd)f+(ad+bc)e\right)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \left(\bigl(ac+(-(bd))\bigr)e+\bigl(-((ad+bc)f)\bigr),\ \bigl(ac+(-(bd))\bigr)f+(ad+bc)e\right)
&&\bigl(\because\ \text{差の定義}\ y-t = y+(-t)\ \bigl(y \to ac,\ t \to bd\ \text{を 2 箇所と}\ y \to (ac-bd)e,\ t \to (ad+bc)f\bigr)\ \text{（}\blkref{def_real_difference}\text{）}\text{を 3 箇所へ適用}\bigr)\\
&= \left(\bigl((ac)e+(-(bd))e\bigr)+\Bigl(-\bigl((ad)f+(bc)f\bigr)\Bigr),\ \bigl((ac)f+(-(bd))f\bigr)+\bigl((ad)e+(bc)e\bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x+y)t = xt+yt\ \bigl(x \to ac,\ y \to -(bd),\ t \to e;\ x \to ad,\ y \to bc,\ t \to f;\ x \to ac,\ y \to -(bd),\ t \to f;\ x \to ad,\ y \to bc,\ t \to e\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 4 箇所へ適用}\bigr)\\
&= \left(\bigl((ac)e+(-((bd)e))\bigr)+\Bigl(-\bigl((ad)f+(bc)f\bigr)\Bigr),\ \bigl((ac)f+(-((bd)f))\bigr)+\bigl((ad)e+(bc)e\bigr)\right)
&&\bigl(\because\ \blkref{real_negation_times_is_negation_of_product}\ (x \to bd,\ t \to e\ \text{と}\ x \to bd,\ t \to f)\ \text{を 2 箇所へ適用}\bigr)\\
&= \left(\bigl((ac)e+(-((bd)e))\bigr)+\bigl((-((ad)f))+(-((bc)f))\bigr),\ \bigl((ac)f+(-((bd)f))\bigr)+\bigl((ad)e+(bc)e\bigr)\right)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ \bigl(x \to (ad)f,\ y \to (bc)f\bigr)\bigr)\\
&= \left(\bigl(a(ce)+(-(b(de)))\bigr)+\bigl((-(a(df)))+(-(b(cf)))\bigr),\ \bigl(a(cf)+(-(b(df)))\bigr)+\bigl(a(de)+b(ce)\bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の積の結合律}\ (xy)t = x(yt)\ \bigl((x,y,t) \to (a,c,e),(b,d,e),(a,d,f),(b,c,f),(a,c,f),(b,d,f),(a,d,e),(b,c,e)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 8 箇所へ適用}\bigr)\\
&= \left(a(ce)+\Bigl((-(b(de)))+\bigl((-(a(df)))+(-(b(cf)))\bigr)\Bigr),\ a(cf)+\Bigl((-(b(df)))+\bigl(a(de)+b(ce)\bigr)\Bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to a(ce),\ y \to -(b(de)),\ t \to (-(a(df)))+(-(b(cf)))\ \text{と}\ x \to a(cf),\ y \to -(b(df)),\ t \to a(de)+b(ce)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \left(a(ce)+\Bigl(\bigl((-(a(df)))+(-(b(cf)))\bigr)+(-(b(de)))\Bigr),\ a(cf)+\Bigl(\bigl(a(de)+b(ce)\bigr)+(-(b(df)))\Bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律}\ x+y = y+x\ \bigl(x \to -(b(de)),\ y \to (-(a(df)))+(-(b(cf)))\ \text{と}\ x \to -(b(df)),\ y \to a(de)+b(ce)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \left(a(ce)+\Bigl((-(a(df)))+\bigl((-(b(cf)))+(-(b(de)))\bigr)\Bigr),\ a(cf)+\Bigl(a(de)+\bigl(b(ce)+(-(b(df)))\bigr)\Bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to -(a(df)),\ y \to -(b(cf)),\ t \to -(b(de))\ \text{と}\ x \to a(de),\ y \to b(ce),\ t \to -(b(df))\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \left(\bigl(a(ce)+(-(a(df)))\bigr)+\bigl((-(b(cf)))+(-(b(de)))\bigr),\ \bigl(a(cf)+a(de)\bigr)+\bigl(b(ce)+(-(b(df)))\bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to a(ce),\ y \to -(a(df)),\ t \to (-(b(cf)))+(-(b(de)))\ \text{と}\ x \to a(cf),\ y \to a(de),\ t \to b(ce)+(-(b(df)))\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ右辺から左辺へ適用}\bigr)\\
&= \left(\bigl(a(ce)+(-(a(df)))\bigr)+\bigl(-(b(cf)+b(de))\bigr),\ \bigl(a(cf)+a(de)\bigr)+\bigl(b(ce)+(-(b(df)))\bigr)\right)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ \bigl(x \to b(cf),\ y \to b(de)\bigr)\ \text{を右辺から左辺へ}\bigr)\\
&= \left(\bigl(a(ce)+a(-(df))\bigr)+\bigl(-(b(cf)+b(de))\bigr),\ \bigl(a(cf)+a(de)\bigr)+\bigl(b(ce)+b(-(df))\bigr)\right)
&&\bigl(\because\ \blkref{real_times_negation_is_negation_of_product}\ (x \to a,\ t \to df\ \text{と}\ x \to b,\ t \to df)\ \text{を 2 箇所へ右辺から左辺へ適用}\bigr)\\
&= \left(a\bigl(ce+(-(df))\bigr)+\bigl(-(b(cf+de))\bigr),\ a(cf+de)+b\bigl(ce+(-(df))\bigr)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ x(y+t) = xy+xt\ \bigl(x \to a,\ y \to ce,\ t \to -(df);\ x \to b,\ y \to cf,\ t \to de;\ x \to a,\ y \to cf,\ t \to de;\ x \to b,\ y \to ce,\ t \to -(df)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 4 箇所へ右辺から左辺へ適用}\bigr)\\
&= \left(a(ce-df)-b(cf+de),\ a(cf+de)+b(ce-df)\right)
&&\bigl(\because\ \text{差の定義}\ y-t = y+(-t)\ \bigl(y \to ce,\ t \to df\ \text{を 2 箇所と}\ y \to a(ce-df),\ t \to b(cf+de)\bigr)\ \text{（}\blkref{def_real_difference}\text{）}\text{を 3 箇所へ右辺から左辺へ適用}\bigr)\\
&= (a,b)\cdot(ce-df,\ cf+de)
&&(\because\ \blkref{definition_of_cc}\ \text{の積を右辺から左辺へ})\\
&= (a,b)\cdot\left((c,d)\cdot(e,f)\right)
&&(\because\ \blkref{definition_of_cc}\ \text{の積を右辺から左辺へ})\\
&= z\cdot(w\cdot u)
&&(\because\ z=(a,b),\ w=(c,d),\ u=(e,f))
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。ℂ の全元についての積の結合律は multiplicative_group_of_cc の証明の中の段にしか無く、その主張は「ℂ^× は群をなす」だけなので、complex_numbers_form_a_field の積のモノイド構造の段落が 0_ℂ を含む全ての元についての結合律を引ける主張が無かった。multiplicative_group_of_cc の証明の「積の結合律」の段の鎖を、式を変えずにこの主張の証明へ移した（鎖の両端を主張の両辺 (z·w)·u・z·(w·u) に揃え、z, w, u を成分に開く行と閉じる行を足し、「ℂ の積の定義」を definition_of_cc の参照にした。鎖の後に置いていた第 3・第 5 の等号の説明の段落（2 つの定理を同時に当てた断り）は、日本語を鎖の後に置かない規律に従って削った。2 つの定理を 1 行で当てている点は台帳の新しい件で扱う）。Lean の具体版は無い（Lean の ℂ は mathlib の Complex で、結合律は使う側が mul_assoc で閉じている）。数値検証: sagemath/check/complex_multiplication_is_associative/check_component_chain.sage。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 鎖の第 4〜第 6 の等号（ℝ の分配律と積の結合律を 1 行で、和の可換律と結合律を 1 行で当てていた行）を、1 行に 1 つの等式だけを当てる 13 行に割った。差は def_real_difference で和と符号反転に開いてから並べ替え、最後に閉じた。各行に使った形と代入を書き、ℝ の法則には set_and_algebra_notation を参照した。符号反転の等式 (−x)t = −(xt)・x(−t) = −(xt)・−(x+y) = (−x)+(−y) は、000_calculation_formulae_00_09.ts の finite_sum_of_negated_real_numbers の (−a)+(−b) = −(a+b) と同じく、ℝ で成り立つ等式として 1 行に 1 つ当てた。積 ace のような括弧の無い書き方をやめ、(ac)e・a(ce) と括弧を書いた。鎖の両端と主張は不変。数値検証: 同じ check_component_chain.sage を 19 行に合わせた。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: (−x)t = −(xt) を 2 箇所へ当てる行の根拠「ℝ で (−x)t = −(xt)（set_and_algebra_notation）」を、この回に足した主張 real_negation_times_is_negation_of_product（x → bd, t → e と x → bd, t → f）の参照にした（文書の並びでは後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: x(−t) = −(xt) を 2 箇所へ右辺から左辺へ当てる行の根拠「ℝ で x(−t) = −(xt)（set_and_algebra_notation）」を、この回に足した主張 real_times_negation_is_negation_of_product（x → a, t → df と x → b, t → df）の参照にした（同じファイルの後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: −(x+y) = (−x)+(−y) を当てる 2 行の根拠「ℝ で −(x+y) = (−x)+(−y)（set_and_algebra_notation）」を、この回に足した主張 real_negation_of_sum_is_sum_of_negations（x → (ad)f, y → (bc)f と、x → b(cf), y → b(de) を右辺から左辺へ）の参照にした（同じファイルの後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_one_is_multiplicative_identity",
    kind: "claim",
    title: {
      tex: "1_{\\mathbb{C}}\\text{は}\\mathbb{C}\\text{の積の単位元}",
    },
    labels: ["complex_one_is_multiplicative_identity"],
    statement: [
      paragraph([
        ref("definition_of_cc"),
        " の積と ",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`1_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(1)`),
        " について、任意の ",
        math(String.raw`z\in\mathbb{C}`),
        " に対して",
      ]),
      displayMath(String.raw`z\cdot 1_{\mathbb{C}}=z,\qquad 1_{\mathbb{C}}\cdot z=z`),
      paragraph([
        "が成り立つ（",
        math(String.raw`z`),
        " は ",
        math(String.raw`0_{\mathbb{C}}`),
        " でもよい）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z=(a,b)`),
        " と書く（",
        math(String.raw`a,b\in\mathbb{R}`),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
z\cdot 1_{\mathbb{C}}
&= (a,b)\cdot 1_{\mathbb{C}}
&&(\because\ z=(a,b))\\
&= (a,b)\cdot(1,0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 1_{\mathbb{C}}=(1,0))\\
&= (a\cdot 1-b\cdot 0,\ a\cdot 0+b\cdot 1)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= (a-b\cdot 0,\ a\cdot 0+b)
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to a,\ x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= (a-0,\ 0+b)
&&(\because\ \blkref{real_times_zero_is_zero}\ (x\to b,\ x\to a)\ \text{を 2 箇所へ適用})\\
&= (a,\ 0+b)
&&(\because\ \blkref{real_minus_zero_is_self}\ (a\to a))\\
&= (a,b)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= z
&&(\because\ z=(a,b))
\end{aligned}`,
      ),
      paragraph(["であり、また"]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot z
&= z\cdot 1_{\mathbb{C}}
&&(\because\ \blkref{complex_multiplication_is_commutative}\ (w \to 1_{\mathbb{C}},\ z \to z))\\
&= z
&&(\because\ \text{上の鎖})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。ℂ の全元について 1_ℂ が積の単位元であることは multiplicative_group_of_cc の証明の中の段にしか無く、その主張は「ℂ^× は群をなす」だけなので、complex_numbers_form_a_field の積のモノイド構造の段落が 0_ℂ を含む全ての元についての単位元を引ける主張が無かった。multiplicative_group_of_cc の証明の「積の単位元」の段の 2 本の鎖を、式を変えずにこの主張の証明へ移した（鎖の両端を主張の両辺に揃え、z を成分に開く行と閉じる行を足し、1_ℂ = (1,0) の根拠を inclusion_rr_to_cc の参照にした）。Lean の具体版は無い（Lean の ℂ は mathlib の Complex で、単位元は使う側が mul_one・one_mul で閉じている）。数値検証: sagemath/check/complex_one_is_multiplicative_identity/check_component_chain.sage。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_product_of_sums_of_two_squares_identity",
    kind: "claim",
    title: {
      tex: "2\\text{ つの平方和の積の恒等式}",
    },
    labels: ["product_of_sums_of_two_squares_identity"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`a,b,c,d\in\mathbb{R}`),
        " に対して",
      ]),
      displayMath(String.raw`(ac-bd)^2+(ad+bc)^2=\left(a^2+b^2\right)\left(c^2+d^2\right)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(ad)(bc)
&= a\bigl(d(bc)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の積の結合律}\ (xy)t = x(yt)\ (x \to a,\ y \to d,\ t \to bc)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\bigl((db)c\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の積の結合律}\ (xy)t = x(yt)\ (x \to d,\ y \to b,\ t \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= a\bigl((bd)c\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の積の可換律}\ xy = yx\ (x \to d,\ y \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\bigl(c(bd)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の積の可換律}\ xy = yx\ (x \to bd,\ y \to c)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (ac)(bd)
&&\bigl(\because\ \mathbb{R}\ \text{の積の結合律}\ (xy)t = x(yt)\ (x \to a,\ y \to c,\ t \to bd)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
      paragraph(["である。"]),
      displayMath(
        String.raw`\begin{aligned}
(ac-bd)^2+(ad+bc)^2
&= (ac-bd)(ac-bd)+(ad+bc)(ad+bc)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ \text{の}\ r^2 = r\,r\ (r \to ac-bd;\ r \to ad+bc)\ \text{を 2 箇所へ適用}\bigr)\\
&= \Bigl(ac+\bigl(-(bd)\bigr)\Bigr)\Bigl(ac+\bigl(-(bd)\bigr)\Bigr)+(ad+bc)(ad+bc)
&&\bigl(\because\ \text{差の定義}\ y-t = y+(-t)\ (y \to ac,\ t \to bd)\ \text{（}\blkref{def_real_difference}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \biggl((ac)\Bigl(ac+\bigl(-(bd)\bigr)\Bigr)+\bigl(-(bd)\bigr)\Bigl(ac+\bigl(-(bd)\bigr)\Bigr)\biggr)+\bigl((ad)(ad+bc)+(bc)(ad+bc)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x+y)t = xt+yt\ \bigl(x \to ac,\ y \to -(bd),\ t \to ac+\bigl(-(bd)\bigr);\ x \to ad,\ y \to bc,\ t \to ad+bc\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \biggl(\Bigl((ac)(ac)+(ac)\bigl(-(bd)\bigr)\Bigr)+\Bigl(\bigl(-(bd)\bigr)(ac)+\bigl(-(bd)\bigr)\bigl(-(bd)\bigr)\Bigr)\biggr)+\Bigl(\bigl((ad)(ad)+(ad)(bc)\bigr)+\bigl((bc)(ad)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ x(y+t) = xy+xt\ \bigl(x \to ac,\ y \to ac,\ t \to -(bd);\ x \to -(bd),\ y \to ac,\ t \to -(bd);\ x \to ad,\ y \to ad,\ t \to bc;\ x \to bc,\ y \to ad,\ t \to bc\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 4 箇所へ適用}\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\Bigl(\bigl(-(bd)\bigr)(ac)+\bigl(-(bd)\bigr)\bigl(-(bd)\bigr)\Bigr)\Biggr)+\Bigl(\bigl((ad)(ad)+(ad)(bc)\bigr)+\bigl((bc)(ad)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \blkref{real_times_negation_is_negation_of_product}\ (x \to ac,\ t \to bd)\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\biggl(\Bigl(-\bigl((bd)(ac)\bigr)\Bigr)+\bigl(-(bd)\bigr)\bigl(-(bd)\bigr)\biggr)\Biggr)+\Bigl(\bigl((ad)(ad)+(ad)(bc)\bigr)+\bigl((bc)(ad)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \blkref{real_negation_times_is_negation_of_product}\ (x \to bd,\ t \to ac)\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\biggl(\Bigl(-\bigl((bd)(ac)\bigr)\Bigr)+(bd)(bd)\biggr)\Biggr)+\Bigl(\bigl((ad)(ad)+(ad)(bc)\bigr)+\bigl((bc)(ad)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ \text{の}\ (-a)(-b) = ab\ \text{を文字を}\ p, q\ \text{に替えた}\ (-p)(-q) = pq\ (p \to bd,\ q \to bd)\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)\Biggr)+\Bigl(\bigl((ad)(ad)+(ad)(bc)\bigr)+\bigl((ad)(bc)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の積の可換律}\ xy = yx\ (x \to bd,\ y \to ac;\ x \to bc,\ y \to ad)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)\Biggr)+\Bigl(\bigl((ad)(ad)+(ac)(bd)\bigr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \text{上の}\ (ad)(bc) = (ac)(bd)\ \text{を 2 箇所へ適用}\bigr)\\
&= \biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)+\Bigl(\bigl((ad)(ad)+(ac)(bd)\bigr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr),\ y \to \Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd),\ t \to \bigl((ad)(ad)+(ac)(bd)\bigr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\Biggl(\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)+\bigl((ad)(ad)+(ac)(bd)\bigr)\Biggr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to \Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd),\ y \to (ad)(ad)+(ac)(bd),\ t \to (ac)(bd)+(bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\Biggl(\Biggl(\bigl((ad)(ad)+(ac)(bd)\bigr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)\Biggr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律}\ x+y = y+x\ \bigl(x \to \Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd),\ y \to (ad)(ad)+(ac)(bd)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\Biggl(\bigl((ad)(ad)+(ac)(bd)\bigr)+\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Biggr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ad)(ad)+(ac)(bd),\ y \to \Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd),\ t \to (ac)(bd)+(bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \Biggl(\biggl((ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\bigl((ad)(ad)+(ac)(bd)\bigr)\Biggr)+\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ac)(ac)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr),\ y \to (ad)(ad)+(ac)(bd),\ t \to \biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(bd)(bd)\biggr)+\bigl((ac)(bd)+(bc)(bc)\bigr)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \Biggl((ac)(ac)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+\bigl((ad)(ad)+(ac)(bd)\bigr)\biggr)\Biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+\Bigl((bd)(bd)+\bigl((ac)(bd)+(bc)(bc)\bigr)\Bigr)\biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ac)(ac),\ y \to -\bigl((ac)(bd)\bigr),\ t \to (ad)(ad)+(ac)(bd);\ x \to -\bigl((ac)(bd)\bigr),\ y \to (bd)(bd),\ t \to (ac)(bd)+(bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \Biggl((ac)(ac)+\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(ad)(ad)\biggr)+(ac)(bd)\Biggr)\Biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+\Bigl(\bigl((bd)(bd)+(ac)(bd)\bigr)+(bc)(bc)\Bigr)\biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to -\bigl((ac)(bd)\bigr),\ y \to (ad)(ad),\ t \to (ac)(bd);\ x \to (bd)(bd),\ y \to (ac)(bd),\ t \to (bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ右辺から左辺へ適用}\bigr)\\
&= \Biggl((ac)(ac)+\Biggl(\biggl((ad)(ad)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+(ac)(bd)\Biggr)\Biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+\Bigl(\bigl((ac)(bd)+(bd)(bd)\bigr)+(bc)(bc)\Bigr)\biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律}\ x+y = y+x\ \bigl(x \to -\bigl((ac)(bd)\bigr),\ y \to (ad)(ad);\ x \to (bd)(bd),\ y \to (ac)(bd)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \Biggl((ac)(ac)+\Biggl((ad)(ad)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(ac)(bd)\biggr)\Biggr)\Biggr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+\Bigl((ac)(bd)+\bigl((bd)(bd)+(bc)(bc)\bigr)\Bigr)\biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ad)(ad),\ y \to -\bigl((ac)(bd)\bigr),\ t \to (ac)(bd);\ x \to (ac)(bd),\ y \to (bd)(bd),\ t \to (bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \Biggl(\bigl((ac)(ac)+(ad)(ad)\bigr)+\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(ac)(bd)\biggr)\Biggr)+\Biggl(\biggl(\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(ac)(bd)\biggr)+\bigl((bd)(bd)+(bc)(bc)\bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x+y)+t = x+(y+t)\ \bigl(x \to (ac)(ac),\ y \to (ad)(ad),\ t \to \Bigl(-\bigl((ac)(bd)\bigr)\Bigr)+(ac)(bd);\ x \to -\bigl((ac)(bd)\bigr),\ y \to (ac)(bd),\ t \to (bd)(bd)+(bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ右辺から左辺へ適用}\bigr)\\
&= \Biggl(\bigl((ac)(ac)+(ad)(ad)\bigr)+\biggl((ac)(bd)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)\Biggr)+\Biggl(\biggl((ac)(bd)+\Bigl(-\bigl((ac)(bd)\bigr)\Bigr)\biggr)+\bigl((bd)(bd)+(bc)(bc)\bigr)\Biggr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律}\ x+y = y+x\ \bigl(x \to -\bigl((ac)(bd)\bigr),\ y \to (ac)(bd)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= \Bigl(\bigl((ac)(ac)+(ad)(ad)\bigr)+0\Bigr)+\Bigl(0+\bigl((bd)(bd)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ \bigl(z \to (ac)(bd)\bigr)\ \text{を 2 箇所へ適用}\bigr)\\
&= \bigl((ac)(ac)+(ad)(ad)\bigr)+\Bigl(0+\bigl((bd)(bd)+(bc)(bc)\bigr)\Bigr)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ \bigl(x \to (ac)(ac)+(ad)(ad)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((ac)(ac)+(ad)(ad)\bigr)+\bigl((bd)(bd)+(bc)(bc)\bigr)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ \bigl(x \to (bd)(bd)+(bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((ac)(ac)+(ad)(ad)\bigr)+\bigl((bc)(bc)+(bd)(bd)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律}\ x+y = y+x\ \bigl(x \to (bd)(bd),\ y \to (bc)(bc)\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((ac)^2+(ad)^2\bigr)+\bigl((bc)^2+(bd)^2\bigr)
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ \text{の}\ r^2 = r\,r\ (r \to ac;\ r \to ad;\ r \to bc;\ r \to bd)\ \text{を 4 箇所へ右辺から左辺へ適用}\bigr)\\
&= (a^2c^2+a^2d^2)+(b^2c^2+b^2d^2)
&&\bigl(\because\ \blkref{product_of_real_powers_is_power_of_product}\ \text{の}\ a^m\,b^m = (ab)^m\ \text{を文字を}\ p, q\ \text{に替えた}\ p^m\,q^m = (pq)^m\ (p \to a,\ q \to c,\ m \to 2;\ p \to a,\ q \to d,\ m \to 2;\ p \to b,\ q \to c,\ m \to 2;\ p \to b,\ q \to d,\ m \to 2)\ \text{を 4 箇所へ右辺から左辺へ適用}\bigr)\\
&= a^2(c^2+d^2)+b^2(c^2+d^2)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ x(y+t) = xy+xt\ (x \to a^2,\ y \to c^2,\ t \to d^2;\ x \to b^2,\ y \to c^2,\ t \to d^2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ右辺から左辺へ適用}\bigr)\\
&= \left(a^2+b^2\right)\left(c^2+d^2\right)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x+y)t = xt+yt\ (x \to a^2,\ y \to b^2,\ t \to c^2+d^2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。この恒等式は multiplicative_group_of_cc の証明の「積について閉じること」の段にしか無く、その主張は「ℂ^× は群をなす」だけなので、abs_basic_properties の (4)（積の絶対値）の鎖が引ける主張が無かった。その段の鎖を、式を変えずにこの主張の証明へ移した（鎖の両端は主張の両辺のまま）。1 行で 2 つ以上の定理を当てている行（第 1・第 2・第 5 の等号）は台帳の件で扱う。Lean の具体版は無い（Lean の ℂ は mathlib の Complex で、この恒等式を述べる宣言は置いていない）。数値検証: sagemath/check/product_of_sums_of_two_squares_identity/check_identity_chain.sage。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 鎖の第 1・第 2・第 5 の等号（ℝ の分配律と積の結合律・可換律を 1 行で、和の可換律と結合律を 1 行で、分配律と積の可換律を 1 行で当てていた行）を、1 行に 1 つの等式だけを当てる 28 行に割った。二乗は square_of_real_number_is_product で積に開き、差は def_real_difference で和と符号反転に開いてから分配則で展開し、符号反転の等式 x(−t) = −(xt)・(−x)t = −(xt)、real_negation_times_negation_is_product の (−a)(−b) = ab（文字を p, q に替えて書いた。文書の並びでは後ろのブロック。依存先にこの主張は無く循環しない）と積の可換則で交差項を (ac)(bd) と (ad)(bc) にそろえた。(ad)(bc) = (ac)(bd) は積の結合則と可換則の 5 行の鎖として主の鎖の前に置き、主の鎖ではその参照で替えた。和の並べ替えは加法の結合則・可換則を 1 行に 1 つずつ当て、z + (−z) = 0（def_real_difference）と 0 の単位元で交差項を消し、square_of_real_number_is_product と product_of_real_powers_is_power_of_product（文字を証明の a, b と衝突しない p, q に替えて書いた）を右辺から左辺へ当てて a^2c^2 などに閉じ、分配則を右辺から左辺へ当てて (a^2+b^2)(c^2+d^2) にした。各行に形と代入を書き、ℝ の法則は set_and_algebra_notation を参照した。積と和の括弧はすべて書いた。鎖の両端と主張は不変。数値検証: 同じ check_identity_chain.sage を 2 本の鎖と根拠の等式の実例に合わせた。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: (−(bd))(ac) = −((bd)(ac)) の行の根拠「ℝ で (−x)t = −(xt)（set_and_algebra_notation）」を、この回に足した主張 real_negation_times_is_negation_of_product（x → bd, t → ac）の参照にした（文書の並びでは後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: (ac)(−(bd)) = −((ac)(bd)) の行の根拠「ℝ で x(−t) = −(xt)（set_and_algebra_notation）」を、この回に足した主張 real_times_negation_is_negation_of_product（x → ac, t → bd）の参照にした（同じファイルの後ろのブロック。依存先にこの主張は無く循環しない）。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/023_claim_CCの乗法群.typ", ordinal: 24 },
    title: {
      tex: "\\mathbb{C}\\text{の乗法群}",
    },
    labels: ["multiplicative_group_of_cc"],
    statement: [
      displayMath(String.raw`\mathbb{C}^{\times}:=\mathbb{C}\setminus\{(0,0)\}`),
      paragraph(["は群をなす。"]),
      paragraph([
        math(String.raw`z\in\mathbb{C},\ z\ne 0`),
        " に対して逆元を ",
        math(String.raw`z^{-1}`),
        " と書き、",
      ]),
      displayMath(String.raw`z^{-1}=1/z`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("definition_of_cc"),
        " の積",
      ]),
      displayMath(String.raw`(a,b)\cdot(c,d):=(ac-bd,\ ad+bc)`),
      paragraph([
        "を用いる（",
        math(String.raw`a,b,c,d\in\mathbb{R}`),
        "）。また ",
        ref("inclusion_rr_to_cc"),
        " より ",
        math(String.raw`1_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(1)=(1,0)`),
        "、",
        math(String.raw`0_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(0)=(0,0)`),
        " である。",
      ]),
      paragraph([
        "証明は独立した中間目標へ分かれるので、以下ではそれぞれに名前を付けて示す。",
      ]),
      paragraph([
        "積の結合律は ",
        ref("complex_multiplication_is_associative"),
        "、",
        math(String.raw`1_{\mathbb{C}}`),
        " が積の単位元であることは ",
        ref("complex_one_is_multiplicative_identity"),
        " である（どちらも ",
        math(String.raw`\mathbb{C}`),
        " の全元について成り立つ）。",
      ]),
      paragraph([
        "零でないことと平方和が正であることの同値。",
        math(String.raw`z=(a,b)\in\mathbb{C}`),
        " について ",
        math(String.raw`z\ne(0,0)\iff a^2+b^2>0`),
        " を示す。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2+b^2
&\ge 0+b^2
&&(\because\ \mathbb{R}\ \text{では平方は非負であることと、和が順序を保つこと})\\
&\ge 0+0
&&(\because\ \mathbb{R}\ \text{では平方は非負であることと、和が順序を保つこと})\\
&= 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。次に ",
        math(String.raw`a^2+b^2=0`),
        " と仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2
&= a^2+0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to a^2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= a^2+\left(b^2+(-b^2)\right)
&&(\because\ -b^2\ \text{は}\ b^2\ \text{の和の逆元})\\
&= \left(a^2+b^2\right)+(-b^2)
&&(\because\ \mathbb{R}\ \text{の和の結合律})\\
&= 0+(-b^2)
&&(\because\ \text{仮定}\ a^2+b^2=0)\\
&= -b^2
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -b^2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&\le 0
&&(\because\ b^2\ge 0\ \text{と、和の逆元が順序を反転すること})
\end{aligned}`,
      ),
      paragraph([
        "となり、",
        math(String.raw`a^2\ge 0`),
        " と併せて ",
        math(String.raw`a^2=0`),
        "、したがって ",
        math(String.raw`a=0`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " では ",
        math(String.raw`x\ne 0`),
        " なら ",
        math(String.raw`x^2>0`),
        " だから）。",
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " を入れ替えれば同じ議論で ",
        math(String.raw`b=0`),
        " を得る。逆に ",
        math(String.raw`a=b=0`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2+b^2
&= 0^2+0^2
&&(\because\ \text{仮定}\ a=b=0)\\
&= 0\cdot 0+0\cdot 0
&&(\because\ \blkref{square_of_real_number_is_product}\ (r\to 0)\ \text{を 2 箇所へ適用})\\
&= 0+0
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to 0)\ \text{を 2 箇所へ適用})\\
&= 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "である。ゆえに ",
        math(String.raw`a^2+b^2=0\iff z=(0,0)`),
        " であり、これと ",
        math(String.raw`a^2+b^2\ge 0`),
        " を併せて ",
        math(String.raw`z\ne(0,0)\iff a^2+b^2>0`),
        " を得る。",
      ]),
      paragraph([
        math(String.raw`\mathbb{C}^{\times}`),
        " が積について閉じること。",
        math(String.raw`z=(a,b),\ w=(c,d)\in\mathbb{C}^{\times}`),
        " とすると、上で示した同値より ",
        math(String.raw`a^2+b^2>0`),
        " かつ ",
        math(String.raw`c^2+d^2>0`),
        " であるから ",
        math(String.raw`(a^2+b^2)(c^2+d^2)>0`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " では正の元どうしの積は正）。",
        ref("product_of_sums_of_two_squares_identity"),
        " より ",
        math(String.raw`zw=(ac-bd,\ ad+bc)`),
        " の 2 つの成分の平方和は正であり、再び上の同値より ",
        math(String.raw`zw\ne(0,0)`),
        "、すなわち ",
        math(String.raw`zw\in\mathbb{C}^{\times}`),
        " である。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1^2+0^2
&= 1\cdot 1+0\cdot 0
&&(\because\ \blkref{square_of_real_number_is_product}\ (r\to 1,\ r\to 0)\ \text{を 2 箇所へ適用})\\
&= 1+0\cdot 0
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1+0
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to 0))\\
&= 1
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&> 0
&&(\because\ \mathbb{R}\ \text{の順序})
\end{aligned}`,
      ),
      paragraph([
        "より ",
        math(String.raw`1_{\mathbb{C}}\in\mathbb{C}^{\times}`),
        " である。",
      ]),
      paragraph([
        "逆元の存在。",
        math(String.raw`z=(a,b)\in\mathbb{C}^{\times}`),
        " とすると、上で示した同値より ",
        math(String.raw`a^2+b^2>0`),
        " であるから",
      ]),
      displayMath(
        String.raw`w:=\left(\frac{a}{a^2+b^2},\ \frac{-b}{a^2+b^2}\right)\in\mathbb{R}^2=\mathbb{C}`,
      ),
      paragraph(["が定まり、"]),
      displayMath(
        String.raw`\begin{aligned}
z\cdot w
&= (a,b)\cdot\left(\frac{a}{a^2+b^2},\ \frac{-b}{a^2+b^2}\right)
&&(\because\ w\ \text{の定め方})\\
&= \left(a\cdot\frac{a}{a^2+b^2}-b\cdot\frac{-b}{a^2+b^2},\
   a\cdot\frac{-b}{a^2+b^2}+b\cdot\frac{a}{a^2+b^2}\right)
&&\Bigl(\because\ \blkref{definition_of_cc}\ \text{の積}\ \bigl(a\to a,\ b\to b,\ c\to\frac{a}{a^2+b^2},\ d\to\frac{-b}{a^2+b^2}\bigr)\Bigr)\\
&= \left(\frac{a^2}{a^2+b^2}-\frac{-b^2}{a^2+b^2},\
   \frac{-ab}{a^2+b^2}+\frac{ab}{a^2+b^2}\right)
&&(\because\ \mathbb{R}\ \text{の分数と積の関係を 4 箇所へ適用})\\
&= \left(\frac{a^2-(-b^2)}{a^2+b^2},\ \frac{(-ab)+ab}{a^2+b^2}\right)
&&(\because\ \mathbb{R}\ \text{の分母の等しい分数の差と和})\\
&= \left(\frac{a^2+b^2}{a^2+b^2},\ \frac{0}{a^2+b^2}\right)
&&(\because\ -(-b^2)=b^2\ \text{と、}\ -ab\ \text{が}\ ab\ \text{の和の逆元であること})\\
&= \left(1,\ \frac{0}{a^2+b^2}\right)
&&(\because\ a^2+b^2\ne 0\ \text{による約分})\\
&= (1,\ 0)
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を分子にもつ分数は}\ 0)\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 1_{\mathbb{C}}=(1,0)\ \text{を右辺から左辺へ})
\end{aligned}`,
      ),
      paragraph(["である。さらに"]),
      displayMath(
        String.raw`\begin{aligned}
w\cdot z
&= z\cdot w
&&(\because\ \blkref{complex_multiplication_is_commutative})\\
&= 1_{\mathbb{C}}
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`w=(0,0)`),
        " とすると ",
        ref("definition_of_cc"),
        " の積の定義より ",
        math(String.raw`zw=(0,0)`),
        " となって ",
        math(String.raw`zw=1_{\mathbb{C}}\ne(0,0)`),
        " に矛盾するから ",
        math(String.raw`w\ne(0,0)`),
        "、すなわち ",
        math(String.raw`w\in\mathbb{C}^{\times}`),
        " である。",
      ]),
      paragraph([
        "逆元の一意性。単位元 ",
        math(String.raw`e`),
        " をもつ結合的な二項演算をもつ集合 ",
        math(String.raw`S`),
        " において、",
        math(String.raw`s\in S`),
        " に対し ",
        math(String.raw`t,t'\in S`),
        " がともに ",
        math(String.raw`st=ts=e`),
        "、",
        math(String.raw`st'=t's=e`),
        " を満たすとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
t
&= t\,e
&&(\because\ e\ \text{は単位元})\\
&= t\,(s t')
&&(\because\ st'=e)\\
&= (t s)\,t'
&&(\because\ \text{結合律})\\
&= e\,t'
&&(\because\ ts=e)\\
&= t'
&&(\because\ e\ \text{は単位元})
\end{aligned}`,
      ),
      paragraph([
        "であるから逆元は一意である。よって ",
        math(String.raw`z\in\mathbb{C}^{\times}`),
        " の逆元を ",
        math(String.raw`z^{-1}`),
        " と書くことができ、",
      ]),
      displayMath(
        String.raw`z^{-1}=\left(\frac{a}{a^2+b^2},\ \frac{-b}{a^2+b^2}\right)
\qquad (z=(a,b))`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "結論と記法。上で示したところにより ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は積について閉じ、結合律（",
        ref("complex_multiplication_is_associative"),
        "）を満たし、単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        "（",
        ref("complex_one_is_multiplicative_identity"),
        "）を含み、各元が逆元をもつ。したがって ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は群をなす（",
        ref("complex_multiplication_is_commutative"),
        " により可換群である）。",
      ]),
      paragraph([
        "主張の最後の等式 ",
        math(String.raw`z^{-1}=1/z`),
        " は記法の約束である。すなわち ",
        math(String.raw`w\in\mathbb{C},\ z\in\mathbb{C}^{\times}`),
        " に対して商を ",
        math(String.raw`w/z:=w\cdot z^{-1}`),
        " と定めると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1/z
&= 1_{\mathbb{C}}\cdot z^{-1}
&&(\because\ \text{商の定め方})\\
&= z^{-1}
&&(\because\ \blkref{complex_one_is_multiplicative_identity}\ (z \to z^{-1}))
\end{aligned}`,
      ),
      paragraph(["であり、両記法は一致する。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "原文の z^{-1}=1/z は、商 w/z := w z^{-1} を定めたうえでの記法の一致として解釈した。",
        "2026-08-09: 式変形の書き方を統一した。Step 1〜Step 8 の番号を内容の分かる名前へ改め、" +
          "証明の中の相互参照（「Step 4 より」等）も名前で指すようにした。" +
          "各計算を一続きの整列した式にし、根拠を行末の (∵ …) へ揃えた。" +
          "結合律は、両辺を別々に展開して「第 1 成分・第 2 成分がそれぞれ一致する」と日本語で継いでいたのを、" +
          "左辺から右辺までの 1 つの鎖へつないだ。単位元・平方和の同値・積で閉じること・逆元の存在は、" +
          "根拠の書かれていなかった段（1 が積の単位元、0 を因子にもつ積が 0、和の逆元、約分など）を" +
          "それぞれ独立した段として明示した。段は増えており、減った段は無い。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 積の単位元の鎖・平方和の同値の a = b = 0 の鎖・1_C の平方和の鎖の「ℝ では 0 を因子にもつ積は 0」を、real_times_zero_is_zero・real_zero_times_is_zero（同じファイルの後ろのブロック）の参照に替えた。平方を積に開く段は square_of_real_number_is_product の参照の行に、1 は積の単位元と 0 を因子にもつ積を束ねた行は 2 行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/121_multiplicative_group_of_cc/check_02_zero_factor_rows.sage。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 積の単位元の鎖の最後の行 (a − 0, 0 + b) = (a, b) は、体の公理でない a − 0 = a と和の単位元 0 + b = b を「0 は和の単位元。2 箇所へ適用」1 つで束ねていたので、real_minus_zero_is_self（a → a。同じファイルの後ろのブロック）の参照の行と 0 は和の単位元の行の 2 行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/121_multiplicative_group_of_cc/check_02_zero_factor_rows.sage。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: この証明の 7 行が「ℝ では 0 は和の単位元」を参照なしで根拠にしていたので、ℝ が体であることを述べる set_and_algebra_notation の参照と、使った形（積の単位元の鎖の最後の行は左から足す 0 + x = x の x → b、平方和の非負の鎖・a = b = 0 の平方和の鎖は 0 + x = x の x → 0、a² = 0 の鎖は x + 0 = x の x → a² を右辺から左辺へと 0 + x = x の x → −b²、閉性の恒等式は x + 0 = x、1_C の平方和の鎖は x + 0 = x の x → 1）の行に替えた。鎖の両端と段の数は不変。Lean の具体版は無い。数値検証: sagemath/check/121_multiplicative_group_of_cc/check_03_additive_identity_rows.sage。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 積の単位元の鎖の (a·1 − b·0, a·0 + b·1) を消す行と、1_C の平方和の鎖の 1·1 を消す行が「ℝ では 1 は積の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（x·1 = x の x → a, x → b と x → 1）の行にした。式・鎖の両端・段数は不変。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 「積の可換律」の段の鎖は ℂ の全元についての主張で、この主張（ℂ^× は群をなす）からは引けなかったので、鎖の式を変えずに新しい主張 complex_multiplication_is_commutative（このブロックの直前）の証明へ移した。この証明の中で可換律を使う 2 行（1_C·(a,b) = (a,b)·1_C と w·z = z·w）と結論の「可換群である」は、その主張の参照に替えた。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 「積の結合律」「積の単位元」の段の鎖は ℂ の全元についての主張で、その鎖のために置いていた (a,b),(c,d),(e,f) ∈ ℂ の前置きは使われなくなったので削った（残る段は z = (a,b) を段ごとに置き、閉性の恒等式の a,b,c,d ∈ ℝ は積の式の前置きにある）。この主張（ℂ^× は群をなす）からは引けなかったので、鎖の式を変えずに新しい主張 complex_multiplication_is_associative・complex_one_is_multiplicative_identity（このブロックの直前）の証明へ移し、ここではその参照を置いた。1/z = z^{-1} の鎖の「上で示した 1_C が積の単位元であること」と結論の結合律・単位元も、その主張の参照に替えた。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 「積について閉じること」の段の恒等式 (ac−bd)²+(ad+bc)² = (a²+b²)(c²+d²) は、abs_basic_properties の (4) の鎖が「multiplicative_group_of_cc の「積について閉じること」の恒等式」として証明の中の段を引いていた。この主張（ℂ^× は群をなす）からは引けないので、鎖の式を変えずに新しい主張 product_of_sums_of_two_squares_identity（このブロックの直前）の証明へ移し、ここではその参照を置いた。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 「逆元の存在」の鎖の 2 行が参照の無い根拠（「C の積の定義」「1_C = (1,0)」）だったので、definition_of_cc の積（a → a, b → b, c → a/(a²+b²), d → −b/(a²+b²)）と inclusion_rr_to_cc の 1_C = (1,0) を右辺から左辺へ、の参照に替えた。式・鎖の両端・段数は不変。数値検証: sagemath/check/121_multiplicative_group_of_cc/check_inverse_chain_cited_rows.sage。",
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 「逆元の一意性」の段は S の元を a, b, b' と書いており、同じ証明の z=(a,b) の実数の成分 a, b と文字が衝突していたので、S の元を s, t, t' に替えた（a → s, b → t, b' → t'。単位元 e と鎖の形・段数は不変）。この証明の中で s, t は他に使っていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_025_claim_complex_numbers_form_a_field",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/024_claim_CCは体をなす.typ", ordinal: 25 },
    title: {
      tex: "\\mathbb{C}\\text{は体}",
    },
    labels: ["complex_numbers_form_a_field"],
    statement: [paragraph([math(String.raw`\mathbb{C}`), " は体をなす。"])],
    proof: [
      paragraph([
        "加法について。",
        ref("definition_of_cc"),
        " は ",
        math(String.raw`\mathbf{C}=\mathbf{R}^2`),
        " 上の加法と積を定めている。その成分ごとの加法は ",
        math(String.raw`\mathbb{R}^2`),
        " の実数成分を足す次の式",
      ]),
      displayMath(String.raw`(a,b)+(c,d):=(a+c,\ b+d) \qquad (a,b,c,d\in\mathbb{R})`),
      paragraph([
        "である。以下ではこの加法と ",
        ref("definition_of_cc"),
        " の積について、体の公理をすべて確かめる。",
      ]),
      paragraph([
        "示すべきことは次の 5 つである。",
      ]),
      list([
        [
          math(String.raw`(\mathbb{C},+)`),
          " は可換群である（加法の群構造）。",
        ],
        [
          "積は結合的・可換であり単位元 ",
          math(String.raw`1_{\mathbb{C}}`),
          " をもつ（積のモノイド構造）。",
        ],
        ["分配律が成り立つ。"],
        [
          math(String.raw`1_{\mathbb{C}}\ne 0_{\mathbb{C}}`),
          " である（単位元と零元の相違）。",
        ],
        [
          math(String.raw`0_{\mathbb{C}}`),
          " 以外の元は積について可逆である（逆元の存在）。",
        ],
      ]),
      paragraph([
        "以下 ",
        math(String.raw`a,b,c,d,e,f\in\mathbb{R}`),
        " とし、",
        math(String.raw`(a,b),(c,d),(e,f)\in\mathbb{C}`),
        " とする。",
      ]),
      paragraph(["加法の結合律。"]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((a,b)+(c,d)\bigr)+(e,f)
&= (a+c,\ b+d)+(e,f)
&&(\because\ \text{成分ごとの加法の定義})\\
&= \bigl((a+c)+e,\ (b+d)+f\bigr)
&&(\because\ \text{成分ごとの加法の定義})\\
&= \bigl(a+(c+e),\ b+(d+f)\bigr)
&&(\because\ \mathbb{R}\ \text{の和の結合律を 2 箇所へ適用})\\
&= (a,b)+(c+e,\ d+f)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (a,b)+\bigl((c,d)+(e,f)\bigr)
&&(\because\ \text{成分ごとの加法の定義})
\end{aligned}`,
      ),
      paragraph(["加法の可換律。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)+(c,d)
&= (a+c,\ b+d)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (c+a,\ d+b)
&&(\because\ \mathbb{R}\ \text{の和の可換律を 2 箇所へ適用})\\
&= (c,d)+(a,b)
&&(\because\ \text{成分ごとの加法の定義})
\end{aligned}`,
      ),
      paragraph(["加法の単位元。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)+0_{\mathbb{C}}
&= (a,b)+(0,0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 0_{\mathbb{C}}=(0,0))\\
&= (a+0,\ b+0)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (a,b)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to a,\ x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)
\end{aligned}`,
      ),
      paragraph(["加法の逆元。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)+(-a,-b)
&= (a+(-a),\ b+(-b))
&&(\because\ \text{成分ごとの加法の定義})\\
&= (0,0)
&&(\because\ \mathbb{R}\ \text{の和の逆元を 2 箇所へ適用})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 0_{\mathbb{C}}=(0,0))
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`-a,-b\in\mathbb{R}`),
        " なので ",
        math(String.raw`(-a,-b)\in\mathbb{R}^2=\mathbb{C}`),
        " である。以上の 4 つより ",
        math(String.raw`(\mathbb{C},+)`),
        " は可換群である。",
      ]),
      paragraph([
        "この加法の逆元は ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-z:=(-1_{\mathbb{C}})\cdot z`),
        " と一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot(a,b)
&= (-1,0)\cdot(a,b)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{より}\ -1_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(-1)=(-1,0))\\
&= \bigl((-1)a-0\cdot b,\ (-1)b+0\cdot a\bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \bigl((-1)a-0,\ (-1)b+0\bigr)
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to b,\ x\to a)\ \text{を 2 箇所へ適用})\\
&= \bigl((-1)a,\ (-1)b+0\bigr)
&&(\because\ \blkref{real_minus_zero_is_self}\ (a\to (-1)a))\\
&= \bigl((-1)a,\ (-1)b\bigr)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to (-1)b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-a,-b)
&&(\because\ \blkref{real_minus_one_times_is_negation}\ (a\to a,\ a\to b)\ \text{を 2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph([
        "積のモノイド構造。積の可換律は ",
        ref("complex_multiplication_is_commutative"),
        "、積の結合律は ",
        ref("complex_multiplication_is_associative"),
        "、",
        math(String.raw`1_{\mathbb{C}}`),
        " が積の単位元であることは ",
        ref("complex_one_is_multiplicative_identity"),
        " である。",
      ]),
      paragraph(["左からの分配律。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)\cdot\bigl((c,d)+(e,f)\bigr)
&= (a,b)\cdot(c+e,\ d+f)
&&(\because\ \text{成分ごとの加法の定義})\\
&= \bigl(a(c+e)-b(d+f),\ a(d+f)+b(c+e)\bigr)
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \bigl(ac+ae-(bd+bf),\ ad+af+(bc+be)\bigr)
&&(\because\ \mathbb{R}\ \text{の分配律を 4 箇所へ適用})\\
&= \bigl((ac-bd)+(ae-bf),\ (ad+bc)+(af+be)\bigr)
&&(\because\ \mathbb{R}\ \text{の和の可換律・結合律、および和の逆元の分配})\\
&= (ac-bd,\ ad+bc)+(ae-bf,\ af+be)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f)
&&(\because\ \blkref{definition_of_cc}\ \text{の積を 2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph([
        "第 4 の等号の「和の逆元の分配」とは ",
        math(String.raw`-(bd+bf)=(-bd)+(-bf)`),
        " のことである。",
      ]),
      paragraph(["右からの分配律。"]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((c,d)+(e,f)\bigr)\cdot(a,b)
&= (a,b)\cdot\bigl((c,d)+(e,f)\bigr)
&&\bigl(\because\ \blkref{complex_multiplication_is_commutative}\ (w \to (c,d)+(e,f),\ z \to (a,b))\bigr)\\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f)
&&(\because\ \text{上で示した左からの分配律})\\
&= (c,d)\cdot(a,b)+(e,f)\cdot(a,b)
&&\bigl(\because\ \blkref{complex_multiplication_is_commutative}\ (w \to (a,b),\ z \to (c,d)\ \text{と}\ w \to (a,b),\ z \to (e,f))\ \text{を 2 箇所へ適用}\bigr)
\end{aligned}`,
      ),
      paragraph(["単位元と零元の相違。"]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}
&= (1,0)
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 1_{\mathbb{C}}=(1,0))\\
&\ne (0,0)
&&(\because\ \mathbb{R}\ \text{において}\ 1\ne 0\ \text{であり、第 1 成分が異なる})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の}\ 0_{\mathbb{C}}=(0,0))
\end{aligned}`,
      ),
      paragraph([
        "逆元の存在。",
        ref("multiplicative_group_of_cc"),
        " より ",
        math(String.raw`\mathbb{C}^{\times}=\mathbb{C}\setminus\{(0,0)\}`),
        " は積について群をなす。したがって ",
        math(String.raw`z\ne 0_{\mathbb{C}}`),
        " なる ",
        math(String.raw`z\in\mathbb{C}`),
        " は ",
        math(String.raw`z\in\mathbb{C}^{\times}`),
        " であり、積に関する逆元 ",
        math(String.raw`z^{-1}\in\mathbb{C}^{\times}`),
        " をもつ。",
      ]),
      paragraph([
        "結論。以上で 5 つがすべて成り立つので、",
        math(String.raw`\mathbb{C}`),
        " は体をなす。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。",
        "2026-08-09: 式変形を一続きの鎖にし、根拠を行末の (∵ …) へ揃えた。" +
          "Step 1〜Step 6 の番号は内容の分かる名前（加法の結合律・積のモノイド構造・" +
          "左からの分配律・単位元と零元の相違・逆元の存在・結論など）へ改めた。" +
          "加法の 4 つの性質・単位元と零元の相違・分配律の各段に、暗黙だった根拠" +
          "（成分ごとの加法の定義、R の和の結合律・可換律・逆元、0 が和の単位元であること、" +
          "-1_C = (-1,0) であること）を書き足してある。段は増えており、減った段は無い。",
        "原文の CC の定義は「CC := RR^2 に以下の演算を入れたもの」として積のみを明示しており、" +
          "加法が明示されていない。体であることを述べるには加法が必要なので、" +
          "本証明では RR^2 の成分ごとの加法を採ることを冒頭で明示した。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: -z と (-1_C)·z の一致の鎖の最後の行が「1 は積の単位元、0 を因子にもつ積は 0、0 は和の単位元」を 1 行で当てていたので、real_zero_times_is_zero（同じファイルの後ろのブロック）の参照の行・0 は和の単位元の行・1 は積の単位元の行の 3 行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/114_complex_numbers_form_a_field/check_02_negation_rows.sage。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 同じ鎖の ((−1)a − 0, (−1)b + 0) = ((−1)a, (−1)b) の行は、体の公理でない a − 0 = a と和の単位元 x + 0 = x を「0 は和の単位元。2 箇所へ適用」1 つで束ねていたので、real_minus_zero_is_self（a → (−1)a。同じファイルの後ろのブロック）の参照の行と 0 は和の単位元の行の 2 行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/114_complex_numbers_form_a_field/check_02_negation_rows.sage。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 同じ鎖の最後の行 ((−1)a, (−1)b) = (−a, −b) は、−a が加法の逆元なのに「1 は積の単位元」だけで済ませていた（(−1)a = −(1·a) の段が無い）ので、real_minus_one_times_is_negation（a → a, a → b。同じファイルの後ろのブロック）の参照に替えた。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/114_complex_numbers_form_a_field/check_02_negation_rows.sage。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 式変形の後に置いていた、引いたブロックを挙げる段落を削り、その行の (∵ …) で名前だけで書いていた根拠を \\blkref{<ラベル>} に替えた（docs/context/証明の書き方.md の「根拠は式変形の各行から引く。証明の末尾に参照の一覧を置かない」）。式・鎖の両端・段数は不変。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 右からの分配律の鎖は multiplicative_group_of_cc の積の可換律を 0_ℂ になりうる元 (c,d)+(e,f) に当てていたが、その主張は「ℂ^× は群をなす」だけで、ℂ の全元についての可換律は証明の中の段にしか無かった。新しく足した主張 complex_multiplication_is_commutative の参照と代入の行に替え、積のモノイド構造の段落も可換律はその主張を引く形にした。式・鎖の両端・段数は不変。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 加法の単位元の鎖の (a + 0, b + 0) を消す行と、−z と (−1_C)·z の一致の鎖の (−1)b + 0 を消す行が「ℝ では 0 は和の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（x + 0 = x の x → a, x → b と x → (−1)b）の行にした。式・鎖の両端・段数は不変。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 積のモノイド構造の段落は、積の結合律と単位元を multiplicative_group_of_cc の証明の段から引き、0_ℂ を含む全ての元に使っていた。その段を独立した主張 complex_multiplication_is_associative・complex_one_is_multiplicative_identity にしたので、段落をその参照に替えた。",
      ],
    },
  },
  {
    id: "calc_formulae_definition_complex_quotient",
    kind: "definition",
    title: { text: "複素数の商" },
    labels: ["def_complex_quotient"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        "、",
        math(String.raw`w \in \mathbb{C}^{\times}`),
        "（",
        math(String.raw`w \neq 0_{\mathbb{C}}`),
        "）について、商 ",
        math(String.raw`\dfrac{z}{w} \in \mathbb{C}`),
        " を",
      ]),
      displayMath(String.raw`\frac{z}{w} := z\,w^{-1}`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`w^{-1}`),
        " は ",
        ref("multiplicative_group_of_cc"),
        " の逆元、積は ",
        ref("definition_of_cc"),
        " の積である。",
        math(String.raw`z = 1_{\mathbb{C}}`),
        " のとき、",
        math(String.raw`\dfrac{1_{\mathbb{C}}}{w} = 1_{\mathbb{C}}\,w^{-1} = w^{-1}`),
        "（",
        ref("complex_numbers_form_a_field"),
        " の積の単位元）であり、",
        ref("multiplicative_group_of_cc"),
        " の記法 ",
        math(String.raw`w^{-1} = 1/w`),
        " と一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明）: 原文（Typst）に対応ブロックは無い。ℂ の分数は本文全体で使われていたが、定めるブロックが無く、" +
          "exp_of_negative_i_real_as_cos_minus_i_sin の主鎖が「2_C ≠ 0_C による分数」「分配法則」「i ≠ 0_C による分数」を 1 行で当てていた。" +
          "一ステップ一定理に割るために足した（multiplicative_group_of_cc の 1/z = z^{-1} とは、1_C z^{-1} = z^{-1} で一致する）。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_real_inclusion_of_one_half_is_inverse_of_two",
    kind: "claim",
    title: { tex: String.raw`\bigl(\tfrac12\bigr)_{\mathbb{C}} = 2_{\mathbb{C}}^{-1}` },
    labels: ["real_inclusion_of_one_half_is_inverse_of_two"],
    lean: ["Ising2D.real_inclusion_half_eq_inv_two"],
    statement: [
      paragraph([
        math(String.raw`r_{\mathbb{C}}`),
        " を ",
        ref("inclusion_rr_to_cc"),
        " の略記とし、",
        math(String.raw`2_{\mathbb{C}} = (2_{\mathbb{R}})_{\mathbb{C}} = (2, 0) \in \mathbb{C}`),
        " である。",
        math(String.raw`2_{\mathbb{C}} \neq 0_{\mathbb{C}} = (0, 0)`),
        "（実部が ",
        math(String.raw`2 \neq 0`),
        "）なので、",
        math(String.raw`2_{\mathbb{C}}`),
        " は ",
        ref("complex_numbers_form_a_field"),
        " の逆元 ",
        math(String.raw`2_{\mathbb{C}}^{-1} \in \mathbb{C}`),
        "（",
        math(String.raw`2_{\mathbb{C}}\,2_{\mathbb{C}}^{-1} = 1_{\mathbb{C}}`),
        "）をもつ。このとき",
      ]),
      displayMath(String.raw`\bigl(\tfrac12\bigr)_{\mathbb{C}} = 2_{\mathbb{C}}^{-1}`),
      paragraph(["が成り立つ（", math(String.raw`\tfrac12 \in \mathbb{R}`), " は ", math(String.raw`2`), " の ", math(String.raw`\mathbb{R}`), " の逆数）。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\bigl(\tfrac12\bigr)_{\mathbb{C}}
&= \bigl(\tfrac12\bigr)_{\mathbb{C}}\,1_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})\\
&= \bigl(\tfrac12\bigr)_{\mathbb{C}}\bigl(2_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}\bigr)
&&(\because\ 2_{\mathbb{C}}^{-1}\ \text{は}\ 2_{\mathbb{C}}\ \text{の}\ \blkref{complex_numbers_form_a_field}\ \text{の逆元（主張の前置き）})\\
&= \Bigl(\bigl(\tfrac12\bigr)_{\mathbb{C}}\,2_{\mathbb{C}}\Bigr)2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \bigl(\tfrac12\cdot 2\bigr)_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{real_inclusion_preserves_product}\ (a \to \tfrac12,\ b \to 2)\text{。}2_{\mathbb{C}} = (2_{\mathbb{R}})_{\mathbb{C}})\\
&= (1)_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}
&&(\because\ \mathbb{R}\ \text{で}\ \tfrac12\cdot 2 = 1)\\
&= 1_{\mathbb{C}}\,2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ 1_{\mathbb{C}} = (1)_{\mathbb{C}})\\
&= 2_{\mathbb{C}}^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_V1_plus_square_root の i/2 := i·2_C^{-1}（cosh_sinh_coefficient_conversion_for_check と同じ読み）から、real_multiple_of_hermitian_is_hermitian などが使う (1/2)_C の形へ移るために足した（V_plus_is_positive_definite の (V_1^{(+)})^{1/2} の鎖が右辺から左辺へ引く）。complex_numbers_form_a_field を引くので、その後ろに置いた。Lean の具体版は Ising2D.real_inclusion_half_eq_inv_two。",
      ],
    },
  },
  {
    id: "calc_formulae_claim_real_inclusion_preserves_inverse",
    kind: "claim",
    title: { tex: String.raw`\bigl(r^{-1}\bigr)_{\mathbb{C}} = \bigl(r_{\mathbb{C}}\bigr)^{-1}` },
    labels: ["real_inclusion_preserves_inverse"],
    lean: ["Ising2D.real_inclusion_inv", "Ising2D.real_inclusion_ne_zero"],
    statement: [
      paragraph([
        math(String.raw`r \in \mathbb{R}`),
        "、",
        math(String.raw`r \neq 0`),
        " とし、",
        math(String.raw`r^{-1} \in \mathbb{R}`),
        " を ",
        math(String.raw`r`),
        " の ",
        math(String.raw`\mathbb{R}`),
        " の逆数（",
        math(String.raw`\mathbb{R}`),
        " は体 ",
        ref("set_and_algebra_notation"),
        "）とする。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。このとき ",
        math(String.raw`r_{\mathbb{C}} \in \mathbb{C}^{\times}`),
        "（",
        ref("multiplicative_group_of_cc"),
        "）であり（したがって右辺の逆元は定まる）",
      ]),
      displayMath(String.raw`\bigl(r^{-1}\bigr)_{\mathbb{C}} = \bigl(r_{\mathbb{C}}\bigr)^{-1}`),
      paragraph([
        "が成り立つ。右辺の逆元は ",
        ref("multiplicative_group_of_cc"),
        " の逆元である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備（",
        math(String.raw`r_{\mathbb{C}} \in \mathbb{C}^{\times}`),
        "）。",
        ref("inclusion_rr_to_cc"),
        " より ",
        math(String.raw`r_{\mathbb{C}} = (r, 0)`),
        " である。",
        math(String.raw`(r, 0) = (0, 0)`),
        " と仮定すると、",
        ref("definition_of_cc"),
        " の ",
        math(String.raw`\mathbb{R}^2`),
        " の元の等号は成分ごとなので ",
        math(String.raw`r = 0`),
        " となり、",
        math(String.raw`r \neq 0`),
        " に反する。したがって ",
        math(String.raw`r_{\mathbb{C}} \in \mathbb{C}^{\times} = \mathbb{C}\setminus\{(0,0)\}`),
        " であり、",
        ref("multiplicative_group_of_cc"),
        " の逆元 ",
        math(String.raw`\bigl(r_{\mathbb{C}}\bigr)^{-1}`),
        " が定まる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(r^{-1}\bigr)_{\mathbb{C}}
&= \bigl(r^{-1}\bigr)_{\mathbb{C}}\,1_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元を右辺から左辺へ})\\
&= \bigl(r^{-1}\bigr)_{\mathbb{C}}\Bigl(r_{\mathbb{C}}\,\bigl(r_{\mathbb{C}}\bigr)^{-1}\Bigr)
&&\bigl(\because\ \blkref{multiplicative_group_of_cc}\ \text{の逆元}\ (r_{\mathbb{C}} \in \mathbb{C}^{\times})\ \text{を右辺から左辺へ}\bigr)\\
&= \Bigl(\bigl(r^{-1}\bigr)_{\mathbb{C}}\,r_{\mathbb{C}}\Bigr)\bigl(r_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の結合律})\\
&= \bigl(r^{-1} r\bigr)_{\mathbb{C}}\,\bigl(r_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{real_inclusion_preserves_product}\ (a \to r^{-1},\ b \to r))\\
&= (1)_{\mathbb{C}}\,\bigl(r_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \mathbb{R}\ \text{で}\ r^{-1} r = 1\ (r \neq 0))\\
&= 1_{\mathbb{C}}\,\bigl(r_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{inclusion_rr_to_cc}\ \text{の略記}\ 1_{\mathbb{C}} = (1)_{\mathbb{C}})\\
&= \bigl(r_{\mathbb{C}}\bigr)^{-1}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。frobenius_inner_product_axioms の Step 5 場合 2 が「ι_{ℝ→ℂ} が積と逆元を保つこと」を名前だけで根拠にしていたので、逆元の側を主張にした（積の側は real_inclusion_preserves_product）。real_inclusion_of_one_half_is_inverse_of_two と同じ鎖を一般の r ≠ 0 で書いた。Lean の具体版は Ising2D.real_inclusion_inv。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_zero_times_is_zero",
    kind: "claim",
    title: { text: "実数に 0 を左から掛けると 0 になる" },
    labels: ["real_zero_times_is_zero"],
    lean: ["Ising2D.real_zero_times_is_zero"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " とする。和・積・",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`0\cdot x = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-z`),
        "（",
        math(String.raw`z \in \mathbb{R}`),
        "）は ",
        ref("def_real_difference"),
        " の加法の逆元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
0\cdot x
&= 0\cdot x + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to 0\cdot x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= 0\cdot x + \bigl(0\cdot x + (-(0\cdot x))\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 0\cdot x)\ \text{を右辺から左辺へ}\bigr)\\
&= (0\cdot x + 0\cdot x) + (-(0\cdot x))
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (0 + 0)\cdot x + (-(0\cdot x))
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (a + b)c = ac + bc\ (a, b \to 0,\ c \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0\cdot x + (-(0\cdot x))
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 0\cdot x)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。0 を掛けると 0 になることは体の公理に含まれないのに、condition_of_commutativity_of_sqrt_and_product の r_1 = 0・r_2 = 0 の鎖と complex_zero_times_is_zero の証明が「ℝ で 0·x = 0」「0 を因子にもつ積は 0」を名前だけで根拠にしていたので、体の公理から示す主張として足した。Lean の具体版は Ising2D.real_zero_times_is_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroTimesIsZero.lean）、必要十分版は Ising2D.NecSuf.zero_mul_of_rightDistrib（NecSuf/ZeroMulOfRightDistrib.lean）。数値検証: sagemath/check/real_zero_times_is_zero/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: 0·x = 0·x + 0（y + 0 = y の y → 0·x を右辺から左辺へ）と (0 + 0)·x を 0·x にする行（y → 0）。主張の変数 x と取り違えないよう、形の変数を y にした。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_times_zero_is_zero",
    kind: "claim",
    title: { text: "実数に 0 を右から掛けると 0 になる" },
    labels: ["real_times_zero_is_zero"],
    lean: ["Ising2D.real_times_zero_is_zero"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " とする。和・積・",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`x\cdot 0 = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "証明の中の ",
        math(String.raw`-z`),
        "（",
        math(String.raw`z \in \mathbb{R}`),
        "）は ",
        ref("def_real_difference"),
        " の加法の逆元である。",
      ]),
      displayMath(String.raw`\begin{aligned}
x\cdot 0
&= x\cdot 0 + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to x\cdot 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= x\cdot 0 + \bigl(x\cdot 0 + (-(x\cdot 0))\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to x\cdot 0)\ \text{を右辺から左辺へ}\bigr)\\
&= (x\cdot 0 + x\cdot 0) + (-(x\cdot 0))
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= x\cdot (0 + 0) + (-(x\cdot 0))
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ a(b + c) = ab + ac\ (a \to x,\ b, c \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= x\cdot 0 + (-(x\cdot 0))
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ y + 0 = y\ (y \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to x\cdot 0)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。0 を右から掛けると 0 になることは体の公理に含まれないのに、complex_times_zero_is_zero・real_inclusion_preserves_product・sqrt_expansion_via_polar・relation_of_gamma_2_theta_tilde の証明が「ℝ で x·0 = 0（ℝ は体）」を名前だけで根拠にしていたので、real_zero_times_is_zero と同じ手順（分配則だけを左からの形に替える）で示す主張として足した。Lean の具体版は Ising2D.real_times_zero_is_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesZeroIsZero.lean）、必要十分版は Ising2D.NecSuf.mul_zero_of_leftDistrib（NecSuf/MulZeroOfLeftDistrib.lean）。数値検証: sagemath/check/real_times_zero_is_zero/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: x·0 = x·0 + 0（y + 0 = y の y → x·0 を右辺から左辺へ）と x·(0 + 0) を x·0 にする行（y → 0）。主張の変数 x と取り違えないよう、形の変数を y にした。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_negation_of_zero_is_zero",
    kind: "claim",
    title: { text: "実数の 0 の符号を反転しても 0 である" },
    labels: ["real_negation_of_zero_is_zero"],
    lean: ["Ising2D.real_negation_of_zero_is_zero"],
    statement: [
      paragraph([
        math(String.raw`-0`),
        " を ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to 0`),
        "）とする。和と ",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`-0 = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
-0
&= -0 + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to -0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= 0 + (-0)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 0)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。−0 = 0 は体の公理に含まれないのに、本文の ℝ の計算が「ℝ で a − 0 = a（ℝ は体）」の形でこれを暗に使っていたので、real_minus_zero_is_self の準備として足した。Lean の具体版は Ising2D.real_negation_of_zero_is_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfZeroIsZero.lean）、必要十分版は Ising2D.NecSuf.neg_zero_of_addComm（NecSuf/NegZeroOfAddComm.lean）。数値検証: sagemath/check/real_negation_of_zero_is_zero/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: −0 = −0 + 0（x + 0 = x の x → −0 を右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_minus_zero_is_self",
    kind: "claim",
    title: { text: "実数から 0 を引いても変わらない" },
    labels: ["real_minus_zero_is_self"],
    lean: ["Ising2D.real_minus_zero_is_self"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " とする。差は ",
        ref("def_real_difference"),
        " のもの、和と ",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`a - 0 = a`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a - 0
&= a + (-0)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to a,\ z \to 0)\bigr)\\
&= a + 0
&&\bigl(\because\ \blkref{real_negation_of_zero_is_zero}\bigr)\\
&= a
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。a − 0 = a は体の公理に含まれないのに、cosine_zero・inverse_of_sqrt_cc・relation_of_gamma_2_theta_tilde などの証明が「ℝ で a − 0 = a（ℝ は体）」を名前だけで根拠にしていたので、示す主張として足した。Lean の具体版は Ising2D.real_minus_zero_is_self（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusZeroIsSelf.lean）、必要十分版は Ising2D.NecSuf.sub_zero_of_negZero（NecSuf/SubZeroOfNegZero.lean）。数値検証: sagemath/check/real_minus_zero_is_self/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: a + 0 = a（x + 0 = x の x → a）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_minus_one_times_is_negation",
    kind: "claim",
    title: { text: "実数に −1 を左から掛けると符号が反転する" },
    labels: ["real_minus_one_times_is_negation"],
    lean: ["Ising2D.real_minus_one_times_is_negation"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " とする。",
        math(String.raw`-1`),
        " と ",
        math(String.raw`-a`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to 1`),
        "、",
        math(String.raw`z \to a`),
        "）、和・積・",
        math(String.raw`0`),
        "・",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`(-1)\cdot a = -a`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-1)\cdot a
&= (-1)\cdot a + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to (-1)\cdot a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= (-1)\cdot a + \bigl(a + (-a)\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl((-1)\cdot a + a\bigr) + (-a)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((-1)\cdot a + 1\cdot a\bigr) + (-a)
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \bigl((-1) + 1\bigr)\cdot a + (-a)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x + y)c = xc + yc\ (x \to -1,\ y \to 1,\ c \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \bigl(1 + (-1)\bigr)\cdot a + (-a)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0\cdot a + (-a)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 1)\bigr)\\
&= 0 + (-a)
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x \to a)\bigr)\\
&= (-a) + 0
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -a
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to -a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。(−1)·a = −a は体の公理に含まれない（−a は加法の逆元として定めた）のに、complex_numbers_form_a_field の (−1_C)·(a,b) の鎖の最後の行が「1 は積の単位元」だけで ((−1)a, (−1)b) = (−a, −b) を済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_minus_one_times_is_negation（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealMinusOneTimesIsNegation.lean）、必要十分版は Ising2D.NecSuf.neg_one_mul_of_rightDistrib（NecSuf/NegOneMulOfRightDistrib.lean）。数値検証: sagemath/check/real_minus_one_times_is_negation/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: (−1)·a = (−1)·a + 0（x + 0 = x の x → (−1)·a を右辺から左辺へ）、a = 1·a（1·x = x の x → a を右辺から左辺へ）、(−a) + 0 = −a（x + 0 = x の x → −a）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_double_negation",
    kind: "claim",
    title: { text: "実数の符号を 2 度反転するともとに戻る" },
    labels: ["real_double_negation"],
    lean: ["Ising2D.real_double_negation"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " とする。",
        math(String.raw`-a`),
        " と ",
        math(String.raw`-(-a)`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to a`),
        "、",
        math(String.raw`z \to -a`),
        "）、和と ",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`-(-a) = a`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
-(-a)
&= -(-a) + 0
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to -(-a))\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= -(-a) + \bigl(a + (-a)\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= -(-a) + \bigl((-a) + a\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl(-(-a) + (-a)\bigr) + a
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((-a) + (-(-a))\bigr) + a
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0 + a
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to -a)\bigr)\\
&= a + 0
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。−(−a) = a は体の公理に含まれない（−a は加法の逆元として定めた）のに、phi_cartesian_after_phi_polar_is_identity の x = 0, y < 0 の鎖が「負号を 2 度施すともとに戻る」だけで (−y)(−1) = y を済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_double_negation（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealDoubleNegation.lean）、必要十分版は Ising2D.NecSuf.neg_neg_of_addCommGroup（NecSuf/NegNegOfAddCommGroup.lean）。数値検証: sagemath/check/real_double_negation/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: −(−a) = −(−a) + 0（x + 0 = x の x → −(−a) を右辺から左辺へ）と a + 0 = a（x → a）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_negation_times_negation_is_product",
    kind: "claim",
    title: { text: "符号を反転した実数どうしの積は、もとの実数どうしの積に等しい" },
    labels: ["real_negation_times_negation_is_product"],
    lean: ["Ising2D.real_negation_times_negation_is_product"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " とする。",
        math(String.raw`-a`),
        "・",
        math(String.raw`-b`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to a`),
        "、",
        math(String.raw`z \to b`),
        "）、積は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`(-a)\cdot(-b) = a\cdot b`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-a)\cdot(-b)
&= \bigl((-1)\cdot a\bigr)\cdot(-b)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to a)\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl((-1)\cdot a\bigr)\cdot\bigl((-1)\cdot b\bigr)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to b)\ \text{を右辺から左辺へ}\bigr)\\
&= (-1)\cdot\Bigl(a\cdot\bigl((-1)\cdot b\bigr)\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot\Bigl(\bigl(a\cdot(-1)\bigr)\cdot b\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot\Bigl(\bigl((-1)\cdot a\bigr)\cdot b\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot\bigl((-1)\cdot(a\cdot b)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot\bigl(-(a\cdot b)\bigr)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to a\cdot b)\bigr)\\
&= -\bigl(-(a\cdot b)\bigr)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to -(a\cdot b))\bigr)\\
&= a\cdot b
&&\bigl(\because\ \blkref{real_double_negation}\ (a \to a\cdot b)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。(−a)(−b) = ab は体の公理に含まれない（−a は加法の逆元として定めた）のに、abs_basic_properties の (1) の x = 0, y < 0 の鎖と (6) の x < 0 の鎖が「ℝ では (−y)^2 = y^2」「(−x)^2 = x^2」の名前だけで済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_negation_times_negation_is_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesNegationIsProduct.lean）、必要十分版は Ising2D.NecSuf.neg_mul_neg_of_rightDistrib（NecSuf/NegMulNegOfRightDistrib.lean）。数値検証: sagemath/check/real_negation_times_negation_is_product/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_plus_or_minus_one_times_itself_is_one",
    kind: "claim",
    title: { text: "−1 か 1 の実数は、自分自身との積が 1" },
    labels: ["real_plus_or_minus_one_times_itself_is_one"],
    lean: ["Ising2D.real_plus_or_minus_one_times_itself_is_one"],
    statement: [
      paragraph([
        math(String.raw`\sigma \in \{-1,1\} \subset \mathbb{R}`),
        " とする。",
        math(String.raw`-1`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to 1`),
        "）、積と ",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`\sigma\cdot\sigma = 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\sigma = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
1\cdot 1
&= 1
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ p\cdot 1 = p\ (p \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\sigma = -1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
(-1)\cdot(-1)
&= 1\cdot 1
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ (a \to 1,\ b \to 1)\bigr)\\
&= 1
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ p\cdot 1 = p\ (p \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\sigma`),
        " は ",
        math(String.raw`-1`),
        " か ",
        math(String.raw`1`),
        " なので、どちらの場合も ",
        math(String.raw`\sigma\cdot\sigma = 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-20（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w47)。スピンの値の二乗が 1 の件）: 原文（Typst）に対応ブロックは無い。open_chain_endpoint_product_sum の Step 2 の M_col ≥ 3 の鎖の 9 行目が「s(m+1)s(m+1) = 1」をラベルで引かずに当てていたので、示す主張として足した。Lean の具体版は Ising2D.real_plus_or_minus_one_times_itself_is_one（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealPlusOrMinusOneTimesItselfIsOne.lean）、必要十分版は Ising2D.NecSuf.mul_self_eq_one_of_eq_one_or_eq_neg_one（NecSuf/MulSelfEqOneOfEqOneOrEqNegOne.lean）。数値検証: sagemath/check/real_plus_or_minus_one_times_itself_is_one/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_negation_times_is_negation_of_product",
    kind: "claim",
    title: { text: "符号を反転した実数に右から実数を掛けると、積の符号が反転する" },
    labels: ["real_negation_times_is_negation_of_product"],
    lean: ["Ising2D.real_negation_times_is_negation_of_product"],
    statement: [
      paragraph([
        math(String.raw`x, t \in \mathbb{R}`),
        " とする。",
        math(String.raw`-x`),
        "・",
        math(String.raw`-(x\cdot t)`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to x`),
        "、",
        math(String.raw`z \to x\cdot t`),
        "）、積は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`(-x)\cdot t = -(x\cdot t)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(-x)\cdot t
&= \bigl((-1)\cdot x\bigr)\cdot t
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to x)\ \text{を右辺から左辺へ}\bigr)\\
&= (-1)\cdot(x\cdot t)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律}\ (p\cdot q)\cdot r = p\cdot(q\cdot r)\ (p \to -1,\ q \to x,\ r \to t)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -(x\cdot t)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to x\cdot t)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。(−x)t = −(xt) は体の公理に含まれない（−x は加法の逆元として定めた）のに、complex_multiplication_is_associative・product_of_sums_of_two_squares_identity の鎖、real_abs_of_product・complex_conjugate_of_product・conjugate_index_of_check_Z_Y・recover_Z_Y_from_check_Z_Y・trace_of_check_Vprime・eigenvalues_of_V_plus の行が「ℝ で (−x)t = −(xt)」（または右辺から左辺へ）を名前だけで済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_negation_times_is_negation_of_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationTimesIsNegationOfProduct.lean）、必要十分版は Ising2D.NecSuf.neg_mul_of_rightDistrib（NecSuf/NegMulOfRightDistrib.lean）。数値検証: sagemath/check/real_negation_times_is_negation_of_product/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_times_negation_is_negation_of_product",
    kind: "claim",
    title: { text: "実数に右から符号を反転した実数を掛けると、積の符号が反転する" },
    labels: ["real_times_negation_is_negation_of_product"],
    lean: ["Ising2D.real_times_negation_is_negation_of_product"],
    statement: [
      paragraph([
        math(String.raw`x, t \in \mathbb{R}`),
        " とする。",
        math(String.raw`-t`),
        "・",
        math(String.raw`-(x\cdot t)`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to t`),
        "、",
        math(String.raw`z \to x\cdot t`),
        "）、積は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`x\cdot(-t) = -(x\cdot t)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
x\cdot(-t)
&= (-t)\cdot x
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律}\ p\cdot q = q\cdot p\ (p \to x,\ q \to -t)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -(t\cdot x)
&&\bigl(\because\ \blkref{real_negation_times_is_negation_of_product}\ \text{の}\ (-x)\cdot t = -(x\cdot t)\ \text{を文字を}\ p, q\ \text{に替えた}\ (-p)\cdot q = -(p\cdot q)\ (p \to t,\ q \to x)\bigr)\\
&= -(x\cdot t)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律}\ p\cdot q = q\cdot p\ (p \to t,\ q \to x)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。x(−t) = −(xt) は体の公理に含まれない（−t は加法の逆元として定めた）のに、complex_multiplication_is_associative・product_of_sums_of_two_squares_identity の鎖、real_abs_of_product・complex_conjugate_of_product・conjugate_index_of_check_Z_Y・anticommutator_of_check_Z_Y・periodicity_of_check_fermi・trace_of_check_Vprime・trace_of_epsilon_V_plus_via_check_eigenvalues の行が「ℝ で x(−t) = −(xt)」（または右辺から左辺へ）を名前だけで済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_times_negation_is_negation_of_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesNegationIsNegationOfProduct.lean）、必要十分版は Ising2D.NecSuf.mul_neg_of_comm_rightDistrib（NecSuf/MulNegOfCommRightDistrib.lean）。数値検証: sagemath/check/real_times_negation_is_negation_of_product/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_negation_of_sum_is_sum_of_negations",
    kind: "claim",
    title: { text: "実数の和の符号を反転すると、符号を反転した実数の和になる" },
    labels: ["real_negation_of_sum_is_sum_of_negations"],
    lean: ["Ising2D.real_negation_of_sum_is_sum_of_negations"],
    statement: [
      paragraph([
        math(String.raw`x, y \in \mathbb{R}`),
        " とする。",
        math(String.raw`-(x+y)`),
        "・",
        math(String.raw`-x`),
        "・",
        math(String.raw`-y`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to x+y`),
        "、",
        math(String.raw`z \to x`),
        "、",
        math(String.raw`z \to y`),
        "）、和・積・",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、証明で使う ",
        math(String.raw`-1`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to 1`),
        "）である。このとき",
      ]),
      displayMath(String.raw`-(x+y) = (-x)+(-y)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
-(x+y)
&= (-1)\cdot(x+y)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to x+y)\ \text{を右辺から左辺へ}\bigr)\\
&= (-1)\cdot x+(-1)\cdot y
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ p(q+r) = pq+pr\ (p \to -1,\ q \to x,\ r \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-x)+(-y)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to x\ \text{と}\ a \to y)\ \text{を 2 箇所へ適用}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-18（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。−(x+y) = (−x)+(−y) は体の公理に含まれない（−z は加法の逆元として定めた）のに、complex_conjugate_of_sum・complex_conjugate_of_product・finite_sum_of_negated_real_numbers・real_abs_triangle_inequality・complex_multiplication_is_associative の 2 行・cosh_addition_formula・sinh_addition_formula・anticommutator_of_check_Z_Y・periodicity_of_check_fermi の行が「ℝ で −(x+y) = (−x)+(−y)」（または右辺から左辺へ）を名前だけで済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_negation_of_sum_is_sum_of_negations（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfSumIsSumOfNegations.lean）、必要十分版は Ising2D.NecSuf.neg_add_of_distrib（NecSuf/NegAddOfDistrib.lean）。数値検証: sagemath/check/real_negation_of_sum_is_sum_of_negations/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_zero_divided_is_zero",
    kind: "claim",
    title: { text: "0 を 0 でない実数で割ると 0 になる" },
    labels: ["real_zero_divided_is_zero"],
    lean: ["Ising2D.real_zero_divided_is_zero"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        "、",
        math(String.raw`x \neq 0`),
        " とする。商は ",
        ref("def_real_quotient"),
        " のもの、積・",
        math(String.raw`0`),
        "・",
        math(String.raw`x^{-1} \in \mathbb{R}`),
        "（",
        math(String.raw`x`),
        " の乗法の逆元）は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`\frac{0}{x} = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\frac{0}{x}
&= 0\cdot x^{-1}
&&\bigl(\because\ \blkref{def_real_quotient}\ (y \to 0,\ z \to x)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x \to x^{-1})\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。0/x = 0 は体の公理に含まれないのに、arctan_zero・zero_in_closed_interval_from_minus_half_pi_to_half_pi・inverse_of_sqrt_cc・relation_of_gamma_2_theta_tilde の証明が「ℝ で 0/x = 0（x ≠ 0）（ℝ は体）」を名前だけで根拠にしていたので、示す主張として足した。x ≠ 0 は def_real_quotient が商を定めるために要る。Lean の具体版は Ising2D.real_zero_divided_is_zero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroDividedIsZero.lean）、必要十分版は Ising2D.NecSuf.zero_div_of_zeroMul（NecSuf/ZeroDivOfZeroMul.lean）。数値検証: sagemath/check/real_zero_divided_is_zero/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_product_of_nonzero_is_nonzero",
    kind: "claim",
    title: { text: "0 でない実数どうしの積は 0 でない" },
    labels: ["real_product_of_nonzero_is_nonzero"],
    lean: ["Ising2D.real_product_of_nonzero_is_nonzero"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        "、",
        math(String.raw`a \neq 0`),
        "、",
        math(String.raw`b \neq 0`),
        " とする。積・",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである。このとき",
      ]),
      displayMath(String.raw`a\cdot b \neq 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`a\cdot b = 0`),
        " と仮定して矛盾を導く。",
        math(String.raw`a^{-1} \in \mathbb{R}`),
        " は ",
        math(String.raw`a`),
        " の乗法の逆元（",
        math(String.raw`a \neq 0`),
        " なので ",
        ref("set_and_algebra_notation"),
        " の体 ",
        math(String.raw`\mathbb{R}`),
        " に在り、",
        math(String.raw`a^{-1}\cdot a = 1`),
        " を満たす）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
b
&= 1\cdot b
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= (a^{-1}\cdot a)\cdot b
&&\bigl(\because\ a\ \text{の乗法の逆元}\ a^{-1}\cdot a = 1\ (a \neq 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= a^{-1}\cdot(a\cdot b)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a^{-1}\cdot 0
&&\bigl(\because\ \text{仮定}\ a\cdot b = 0\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x \to a^{-1})\bigr)
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`b \neq 0`),
        " に反する。したがって ",
        math(String.raw`a\cdot b \neq 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。0 でない実数どうしの積が 0 でないことは体の公理に含まれないのに、range_of_args_of_square_of_complex_numbers の r ≠ 0 の場合が「実数の積は、因子がどちらも 0 でなければ 0 でない」の地の文だけで r·r ≠ 0 を済ませていたので、示す主張として足した。Lean の具体版は Ising2D.real_product_of_nonzero_is_nonzero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfNonzeroIsNonzero.lean）、必要十分版は Ising2D.NecSuf.mul_ne_zero_of_leftInverse（NecSuf/MulNeZeroOfLeftInverse.lean）。数値検証: sagemath/check/real_product_of_nonzero_is_nonzero/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: b = 1·b（1·x = x の x → b を右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_product_of_inverses_is_inverse_of_product",
    kind: "claim",
    title: { text: "0 でない実数の逆元どうしの積は積の逆元" },
    labels: ["real_product_of_inverses_is_inverse_of_product"],
    lean: ["Ising2D.real_product_of_inverses_is_inverse_of_product"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        "、",
        math(String.raw`a \neq 0`),
        "、",
        math(String.raw`b \neq 0`),
        " とする。積・",
        math(String.raw`0`),
        "・",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものであり、",
        ref("real_product_of_nonzero_is_nonzero"),
        " より ",
        math(String.raw`a\cdot b \neq 0`),
        " である。",
        math(String.raw`a^{-1}`),
        "・",
        math(String.raw`b^{-1}`),
        "・",
        math(String.raw`(a\cdot b)^{-1}`),
        " は ",
        ref("def_real_quotient"),
        " の乗法の逆元（",
        math(String.raw`z\,z^{-1} = 1_{\mathbb{R}}`),
        " を満たす元。",
        math(String.raw`z \to a,\ b,\ a\cdot b`),
        "）である。このとき",
      ]),
      displayMath(String.raw`a^{-1}\cdot b^{-1} = (a\cdot b)^{-1}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["準備として、"]),
      displayMath(String.raw`\begin{aligned}
(a\cdot b)\cdot\left(a^{-1}\cdot b^{-1}\right)
&= a\cdot\left(b\cdot\left(a^{-1}\cdot b^{-1}\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\cdot\left(\left(b\cdot a^{-1}\right)\cdot b^{-1}\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= a\cdot\left(\left(a^{-1}\cdot b\right)\cdot b^{-1}\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\cdot\left(a^{-1}\cdot\left(b\cdot b^{-1}\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\cdot\left(a^{-1}\cdot 1\right)
&&\bigl(\because\ \blkref{def_real_quotient}\ \text{の乗法の逆元}\ z\,z^{-1} = 1_{\mathbb{R}}\ (z \to b \neq 0)\bigr)\\
&= a\cdot a^{-1}
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to a^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1
&&\bigl(\because\ \blkref{def_real_quotient}\ \text{の乗法の逆元}\ z\,z^{-1} = 1_{\mathbb{R}}\ (z \to a \neq 0)\bigr)
\end{aligned}`),
      paragraph(["である。これを用いて"]),
      displayMath(String.raw`\begin{aligned}
a^{-1}\cdot b^{-1}
&= 1\cdot\left(a^{-1}\cdot b^{-1}\right)
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to a^{-1}\cdot b^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= \left((a\cdot b)\cdot(a\cdot b)^{-1}\right)\cdot\left(a^{-1}\cdot b^{-1}\right)
&&\bigl(\because\ \blkref{def_real_quotient}\ \text{の乗法の逆元}\ z\,z^{-1} = 1_{\mathbb{R}}\ (z \to a\cdot b \neq 0)\ \text{を右辺から左辺へ}\bigr)\\
&= \left((a\cdot b)^{-1}\cdot(a\cdot b)\right)\cdot\left(a^{-1}\cdot b^{-1}\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (a\cdot b)^{-1}\cdot\left((a\cdot b)\cdot\left(a^{-1}\cdot b^{-1}\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (a\cdot b)^{-1}\cdot 1
&&\bigl(\because\ \text{準備の}\ (a\cdot b)\cdot\left(a^{-1}\cdot b^{-1}\right) = 1\bigr)\\
&= (a\cdot b)^{-1}
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to (a\cdot b)^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-16（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup のノルムの鎖が「ℝ で (1/p)(1/q) = 1/(pq)」を名前だけで根拠にしていた。逆元の積が積の逆元であることは体の公理に含まれないので、その行を def_real_quotient と乗法の単位元とこの主張の 5 行に割るために足した。逆元の一意性は使わず、(a·b)^{-1} に 1 を掛ける形の鎖で示す。Lean の具体版は Ising2D.real_product_of_inverses_is_inverse_of_product（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealProductOfInversesIsInverseOfProduct.lean）、必要十分版は Ising2D.NecSuf.mul_of_rightInverses_eq_rightInverse_of_mul（NecSuf/MulOfRightInversesEqRightInverseOfMul.lean）。数値検証: sagemath/check/real_product_of_inverses_is_inverse_of_product/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: a^{-1}·1 = a^{-1}（x·1 = x の x → a^{-1}）、a^{-1}·b^{-1} = 1·(a^{-1}·b^{-1})（1·x = x を右辺から左辺へ）、(a·b)^{-1}·1 = (a·b)^{-1}（x·1 = x）の 3 行は形が参照の後ろにあったので並びを直した。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_zero_less_than_one",
    kind: "claim",
    title: { text: "実数の 0 は 1 より小さい" },
    labels: ["real_zero_less_than_one"],
    lean: ["Ising2D.real_zero_less_than_one"],
    statement: [
      paragraph([
        math(String.raw`0`),
        "・",
        math(String.raw`1`),
        "・順序 ",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のものである（",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x \leq y`),
        " かつ ",
        math(String.raw`x \neq y`),
        " のこと）。このとき",
      ]),
      displayMath(String.raw`0 < 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備。体 ",
        math(String.raw`\mathbb{R}`),
        "（",
        ref("set_and_algebra_notation"),
        "）の公理より ",
        math(String.raw`0 \neq 1`),
        " である。",
        math(String.raw`-1 \in \mathbb{R}`),
        " は ",
        ref("def_real_difference"),
        " の ",
        math(String.raw`1`),
        " の加法の逆元である。",
        math(String.raw`\mathbb{R}`),
        " の順序は全順序（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）なので ",
        math(String.raw`0 \leq 1`),
        " か ",
        math(String.raw`1 \leq 0`),
        " であり、",
        math(String.raw`0 \neq 1`),
        " と合わせて ",
        math(String.raw`0 < 1`),
        " か ",
        math(String.raw`1 < 0`),
        " である。",
        math(String.raw`0 < 1`),
        " の場合は主張そのものである。",
        math(String.raw`1 < 0`),
        " の場合にも ",
        math(String.raw`0 < 1`),
        " となることを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&= 1 + (-1)
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 1)\ \text{を右辺から左辺へ}\bigr)\\
&< 0 + (-1)
&&\bigl(\because\ \text{場合の仮定}\ 1 < 0\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x < y \Rightarrow x + c < y + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 1,\ y \to 0,\ c \to -1\bigr)\\
&= -1
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0
&< (-1)\cdot(-1)
&&\bigl(\because\ \text{上の鎖の}\ 0 < -1\ \text{を 2 つの因子へ当て、}\mathbb{R}\ \text{で正の数どうしの積は正（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 1\cdot 1
&&\bigl(\because\ \blkref{real_negation_times_negation_is_product}\ (a \to 1,\ b \to 1)\bigr)\\
&= 1
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "したがって、どちらの場合も ",
        math(String.raw`0 < 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。本文は ℝ の 0 < 1・0 < 2・2 ≠ 0 を名前だけで根拠にしており（zero_in_closed_interval_from_minus_half_pi_to_half_pi・inverse_of_sqrt_cc・relation_of_gamma_2_theta_tilde ほか）、0 < 1 は順序体の公理に含まれないので、ℝ の 2 を定めて 0 < 2 を示す前段として示す主張にした。Lean の具体版は Ising2D.real_zero_less_than_one（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanOne.lean）、必要十分版は Ising2D.NecSuf.zero_lt_one_of_orderedAxioms（NecSuf/ZeroLtOneOfOrderedAxioms.lean）。数値検証: sagemath/check/real_zero_less_than_one/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: 0 + (−1) = −1（0 + x = x の x → −1）と 1·1 = 1（x·1 = x の x → 1）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_zero_less_than_two",
    kind: "claim",
    title: { text: "実数の 0 は 2 より小さい" },
    labels: ["real_zero_less_than_two"],
    lean: ["Ising2D.real_zero_less_than_two"],
    statement: [
      paragraph([
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x \leq y`),
        " かつ ",
        math(String.raw`x \neq y`),
        " のこと）、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        " である。このとき",
      ]),
      displayMath(String.raw`0 < 2`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`1 < 2`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
1
&= 0 + 1
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&< 1 + 1
&&\bigl(\because\ \blkref{real_zero_less_than_one}\ \text{の}\ 0 < 1\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x < y \Rightarrow x + c < y + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 0,\ y \to 1,\ c \to 1\bigr)\\
&= 2
&&\bigl(\because\ \blkref{def_real_two}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["本体。"]),
      displayMath(String.raw`\begin{aligned}
0 < 1\ \land\ 1 < 2
&\Longrightarrow 0 < 2
&&\bigl(\because\ \text{左の}\ 0 < 1\ \text{は}\ \blkref{real_zero_less_than_one}\text{、}1 < 2\ \text{は準備の鎖。}\mathbb{R}\ \text{の順序の推移律（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。本文は ℝ の 0 < 2 を名前だけで根拠にしており（zero_in_closed_interval_from_minus_half_pi_to_half_pi の準備の 0 < 2^{-1} など）、2 を def_real_two で定めたので、その 2 について 0 < 2 を real_zero_less_than_one から示す主張にした。Lean の具体版は Ising2D.real_zero_less_than_two（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealZeroLessThanTwo.lean）、必要十分版は Ising2D.NecSuf.zero_lt_two_of_orderedAxioms（NecSuf/ZeroLtTwoOfOrderedAxioms.lean）。数値検証: sagemath/check/real_zero_less_than_two/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: 1 = 0 + 1（0 + x = x の x → 1 を右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_two_is_nonzero",
    kind: "claim",
    title: { text: "実数の 2 は 0 でない" },
    labels: ["real_two_is_nonzero"],
    lean: ["Ising2D.real_two_is_nonzero"],
    statement: [
      paragraph([
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x \leq y`),
        " かつ ",
        math(String.raw`x \neq y`),
        " のこと）、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        " である。このとき",
      ]),
      displayMath(String.raw`2 \neq 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
0 < 2
&\Longrightarrow 0 \neq 2
&&\bigl(\because\ \text{左の}\ 0 < 2\ \text{は}\ \blkref{real_zero_less_than_two}\text{。}\mathbb{R}\ \text{の}\ x < y\ \text{は}\ x \leq y\ \text{かつ}\ x \neq y\ \text{のことなので、その後半}\ (x \to 0,\ y \to 2)\bigr)\\
&\Longrightarrow 2 \neq 0
&&\bigl(\because\ \text{等号の対称律}\ x = y \Rightarrow y = x\ (x \to 2,\ y \to 0)\ \text{の対偶}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。本文は ℝ の 2 ≠ 0 を名前だけで根拠にしており（inverse_of_sqrt_cc の 0/2 = 0 の行、relation_of_gamma_2_theta_tilde ほか）、2 を def_real_two で定めたので、その 2 について 2 ≠ 0 を real_zero_less_than_two から示す主張にした。Lean の具体版は Ising2D.real_two_is_nonzero（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwoIsNonzero.lean）、必要十分版は Ising2D.NecSuf.ne_zero_of_zero_lt（NecSuf/NeZeroOfZeroLt.lean）。数値検証: sagemath/check/real_two_is_nonzero/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_one_minus_half_is_half",
    kind: "claim",
    title: { text: "実数で 1 から 1/2 を引くと 1/2 になる" },
    labels: ["real_one_minus_half_is_half"],
    lean: ["Ising2D.real_one_minus_half_is_half"],
    statement: [
      paragraph([
        "和・積・",
        math(String.raw`0`),
        "・",
        math(String.raw`1`),
        "・加法の逆元 ",
        math(String.raw`-x`),
        "・乗法の逆元 ",
        math(String.raw`x^{-1}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、差は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\tfrac12 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to 1,\ z \to 2`),
        "。",
        math(String.raw`2 \neq 0`),
        " は ",
        ref("real_two_is_nonzero"),
        "）である。このとき",
      ]),
      displayMath(String.raw`1 - \tfrac12 = \tfrac12`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
1 - \tfrac12
&= 1 + \left(-\left(\tfrac12\right)\right)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to 1,\ z \to \tfrac12)\bigr)\\
&= 2\cdot 2^{-1} + \left(-\left(\tfrac12\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の逆元}\ x\cdot x^{-1} = 1\ (x \to 2\text{。}2 \neq 0\ \text{は}\ \blkref{real_two_is_nonzero})\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= (1 + 1)\cdot 2^{-1} + \left(-\left(\tfrac12\right)\right)
&&\bigl(\because\ \blkref{def_real_two}\ \text{を左の因子の}\ 2\ \text{だけへ}\bigr)\\
&= \left(1\cdot 2^{-1} + 1\cdot 2^{-1}\right) + \left(-\left(\tfrac12\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x + y)t = xt + yt\ (x, y \to 1,\ t \to 2^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \left(\tfrac12 + \tfrac12\right) + \left(-\left(\tfrac12\right)\right)
&&\bigl(\because\ \blkref{def_real_quotient}\ (y \to 1,\ z \to 2)\ \text{を右辺から左辺へ、2 箇所へ}\bigr)\\
&= \tfrac12 + \left(\tfrac12 + \left(-\left(\tfrac12\right)\right)\right)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x, y, t \to \tfrac12)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \tfrac12 + 0
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \tfrac12)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \tfrac12
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \tfrac12)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_of_epsilon_V_plus_via_check_eigenvalues の Step 4 の 2 本目の和の鎖が「ℝ で 1 − 1/2 = 1/2」を名前だけで根拠にしていたので、示す主張として足した（eigenvalues_of_V_plus の同じ行は別の回で扱う）。Lean の具体版は Ising2D.real_one_minus_half_is_half（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealOneMinusHalfIsHalf.lean）、必要十分版は Ising2D.NecSuf.one_sub_half_eq_half'（NecSuf/OneSubHalfEqHalf.lean）。数値検証: sagemath/check/real_one_minus_half_is_half/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_times_half_is_quotient_by_two",
    kind: "claim",
    title: { text: "実数に 1/2 を掛けると 2 で割った商になる" },
    labels: ["real_times_half_is_quotient_by_two"],
    lean: ["Ising2D.real_times_half_is_quotient_by_two"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " とする。積・",
        math(String.raw`1`),
        "・乗法の逆元 ",
        math(String.raw`x^{-1}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\tfrac12 \in \mathbb{R}`),
        " と ",
        math(String.raw`\tfrac{a}{2} \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to 1,\ z \to 2`),
        " と ",
        math(String.raw`y \to a,\ z \to 2`),
        "。",
        math(String.raw`2 \neq 0`),
        " は ",
        ref("real_two_is_nonzero"),
        "）である。このとき",
      ]),
      displayMath(String.raw`a\cdot\tfrac12 = \tfrac{a}{2}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a\cdot\tfrac12
&= a\cdot\left(1\cdot 2^{-1}\right)
&&\bigl(\because\ \blkref{def_real_quotient}\ (y \to 1,\ z \to 2)\bigr)\\
&= a\cdot 2^{-1}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to 2^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \tfrac{a}{2}
&&\bigl(\because\ \blkref{def_real_quotient}\ (y \to a,\ z \to 2)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_of_epsilon_V_plus_via_check_eigenvalues の Step 4 の 2 本目の和の鎖が「ℝ で a·1/2 = a/2」を名前だけで根拠にしていたので、示す主張として足した（eigenvalues_of_V_plus の同じ形の行は別の回で扱う）。Lean の具体版は Ising2D.real_times_half_is_quotient_by_two（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTimesHalfIsQuotientByTwo.lean）、必要十分版は Ising2D.NecSuf.mul_one_div_eq_div'（NecSuf/MulOneDivEqDiv.lean）。数値検証: sagemath/check/real_times_half_is_quotient_by_two/。",
        "2026-11-20（Lean の通しの証明のゴールラインの確認）: 上の「eigenvalues_of_V_plus の同じ形の行」は、trace_of_check_Vprime の Step 2・Step 3 の鎖の 2 か所（a → γ(θ̃_μ)、a → −γ(θ̃_μ)）だった。この主張の参照に替えた。主張は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_twice_quotient_by_two_is_original",
    kind: "claim",
    title: { text: "実数を 2 で割った商に 2 を掛けるともとの実数に戻る" },
    labels: ["real_twice_quotient_by_two_is_original"],
    lean: ["Ising2D.real_twice_quotient_by_two_is_original"],
    statement: [
      paragraph([
        math(String.raw`b \in \mathbb{R}`),
        " とする。積・",
        math(String.raw`1`),
        "・乗法の逆元 ",
        math(String.raw`x^{-1}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\tfrac{b}{2} \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to b,\ z \to 2`),
        "。",
        math(String.raw`2 \neq 0`),
        " は ",
        ref("real_two_is_nonzero"),
        "）である。このとき",
      ]),
      displayMath(String.raw`2\cdot\tfrac{b}{2} = b`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
2\cdot\tfrac{b}{2}
&= 2\cdot\left(b\cdot 2^{-1}\right)
&&\bigl(\because\ \blkref{def_real_quotient}\ (y \to b,\ z \to 2)\bigr)\\
&= 2\cdot\left(2^{-1}\cdot b\right)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の交換律}\ xy = yx\ (x \to b,\ y \to 2^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \left(2\cdot 2^{-1}\right)\cdot b
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律}\ (xy)t = x(yt)\ (x \to 2,\ y \to 2^{-1},\ t \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 1\cdot b
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の逆元}\ x\cdot x^{-1} = 1\ (x \to 2\text{。}2 \neq 0\ \text{は}\ \blkref{real_two_is_nonzero})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= b
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。trace_of_epsilon_V_plus_via_check_eigenvalues の Step 4 の 2 本目の和の鎖が「ℝ で 2 ≠ 0 なので b = 2·(b/2)」を名前だけで根拠にしていたので、示す主張として足した（ℂ の twice_times_inverse_of_two_is_original_in_cc に当たる ℝ の主張）。Lean の具体版は Ising2D.real_twice_quotient_by_two_is_original（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealTwiceQuotientByTwoIsOriginal.lean）、必要十分版は Ising2D.NecSuf.mul_div_cancel_of_right_inverse'（NecSuf/MulDivCancelOfRightInverse.lean）。数値検証: sagemath/check/real_twice_quotient_by_two_is_original/。",
        "2026-11-20（Lean の通しの証明のゴールラインの確認）: trace_of_check_Vprime の Step 2・Step 3 の鎖の「ℝ で 2 ≠ 0 なので b = 2·(b/2)」の各 1 か所も、この主張を右辺から左辺へ当てる参照に替えた（Lean は Ising2D.CheckFermiSetup.prod_step2_cosh の段）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_sum_of_two_equal_terms_is_twice",
    kind: "claim",
    title: { text: "同じ実数を二つ足すと 2 倍になる" },
    labels: ["real_sum_of_two_equal_terms_is_twice"],
    lean: ["Ising2D.real_sum_of_two_equal_terms_is_twice"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        " とする。和・積・",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        " である。このとき",
      ]),
      displayMath(String.raw`a + a = 2\cdot a`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
a + a
&= 1\cdot a + 1\cdot a
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ 2 か所に同時適用}\bigr)\\
&= (1 + 1)\cdot a
&&\bigl(\because\ \mathbb{R}\ \text{の分配律}\ (x+y)t = xt+yt\ (x \to 1,\ y \to 1,\ t \to a)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 2\cdot a
&&\bigl(\because\ \blkref{def_real_two}\ \text{の}\ 2 := 1 + 1\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w25)。開鎖のスピン和の c + c = 2c の件）: 原文（Typst）に対応ブロックは無い。open_chain_partition_sum・open_chain_endpoint_product_sum の最後の鎖が「u に依らない実数 c の二元集合 {-1,1} 上の和は c + c = 2c」を名前だけで根拠にしていたので、後半の c + c = 2c を示す主張として足した。Lean の具体版は Ising2D.real_sum_of_two_equal_terms_is_twice（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealSumOfTwoEqualTermsIsTwice.lean）、必要十分版は Ising2D.NecSuf.add_self_eq_two_mul'（NecSuf/AddSelfEqTwoMul.lean）。数値検証: sagemath/check/real_sum_of_two_equal_terms_is_twice/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_half_plus_half_is_original",
    kind: "claim",
    title: { text: "実数を 2 で割った商を二つ足すともとの実数に戻る" },
    labels: ["real_half_plus_half_is_original"],
    lean: ["Ising2D.real_half_plus_half_is_original"],
    statement: [
      paragraph([
        math(String.raw`b \in \mathbb{R}`),
        " とする。和・積・",
        math(String.raw`1`),
        "・乗法の逆元 ",
        math(String.raw`x^{-1}`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\tfrac{b}{2} \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to b,\ z \to 2`),
        "。",
        math(String.raw`2 \neq 0`),
        " は ",
        ref("real_two_is_nonzero"),
        "）である。このとき",
      ]),
      displayMath(String.raw`\tfrac{b}{2} + \tfrac{b}{2} = b`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\tfrac{b}{2} + \tfrac{b}{2}
&= 2\cdot\tfrac{b}{2}
&&\bigl(\because\ \blkref{real_sum_of_two_equal_terms_is_twice}\ (a \to \tfrac{b}{2})\bigr)\\
&= b
&&\bigl(\because\ \blkref{real_twice_quotient_by_two_is_original}\ (b \to b)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。全実数上の sin・cos を定める準備の主張（real_section_minus_half_pi_in_principal_interval・reflected_real_section_in_principal_interval・principal_angle_plus_half_pi_at_most_pi）がそれぞれ π/2 + π/2 = π の 2 行の鎖を持っていたので、b → π で引ける主張にまとめた。Lean の具体版は Ising2D.real_half_plus_half_is_original（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealHalfPlusHalfIsOriginal.lean）。数値検証: sagemath/check/real_half_plus_half_is_original/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_inverse_of_positive_is_positive",
    kind: "claim",
    title: { text: "正の実数の乗法の逆元は正" },
    labels: ["real_inverse_of_positive_is_positive"],
    lean: ["Ising2D.real_inverse_of_positive_is_positive"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        "、",
        math(String.raw`0 < a`),
        " とする。和・積・",
        math(String.raw`0`),
        "・",
        math(String.raw`1`),
        "・順序 ",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x \leq y`),
        " かつ ",
        math(String.raw`x \neq y`),
        " のこと）である。",
        math(String.raw`0 < a`),
        " から ",
        math(String.raw`a \neq 0`),
        " が従い（証明の準備で示す）、",
        math(String.raw`a^{-1} \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の ",
        math(String.raw`z^{-1}`),
        "（",
        math(String.raw`z \to a`),
        "）、すなわち ",
        math(String.raw`a`),
        " の乗法の逆元（",
        math(String.raw`a\cdot a^{-1} = 1`),
        "）である。このとき",
      ]),
      displayMath(String.raw`0 < a^{-1}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`a \neq 0`),
        " を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
0 < a
&\Longrightarrow 0 \neq a
&&\bigl(\because\ \mathbb{R}\ \text{の}\ x < y\ \text{は}\ x \leq y\ \text{かつ}\ x \neq y\ \text{のことなので、その後半}\ (x \to 0,\ y \to a)\bigr)\\
&\Longrightarrow a \neq 0
&&\bigl(\because\ \text{等号の対称律}\ x = y \Rightarrow y = x\ (x \to a,\ y \to 0)\ \text{の対偶}\bigr)
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`a^{-1}`),
        " が在る。",
        math(String.raw`-a^{-1}`),
        "・",
        math(String.raw`-1`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to a^{-1}`),
        "、",
        math(String.raw`z \to 1`),
        "）である。次に ",
        math(String.raw`a^{-1} \neq 0`),
        " を示す。",
        math(String.raw`a^{-1} = 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
1
&= a\cdot a^{-1}
&&\bigl(\because\ a\ \text{の乗法の逆元}\ a\cdot a^{-1} = 1\ (a \neq 0)\ \text{（}\mathbb{R}\ \text{は体 }\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= a\cdot 0
&&\bigl(\because\ \text{仮定}\ a^{-1} = 0\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x \to a)\bigr)
\end{aligned}`),
      paragraph([
        "となり、体 ",
        math(String.raw`\mathbb{R}`),
        "（",
        ref("set_and_algebra_notation"),
        "）の公理 ",
        math(String.raw`0 \neq 1`),
        " に反する。したがって ",
        math(String.raw`a^{-1} \neq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{-1} \neq 0
&\Longrightarrow 0 \neq a^{-1}
&&\bigl(\because\ \text{等号の対称律}\ x = y \Rightarrow y = x\ (x \to 0,\ y \to a^{-1})\ \text{の対偶}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\mathbb{R}`),
        " の順序は全順序（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）なので ",
        math(String.raw`0 \leq a^{-1}`),
        " か ",
        math(String.raw`a^{-1} \leq 0`),
        " であり、前者は ",
        math(String.raw`0 \neq a^{-1}`),
        " と、後者は ",
        math(String.raw`a^{-1} \neq 0`),
        " と合わせて（",
        math(String.raw`x < y`),
        " の意味）",
        math(String.raw`0 < a^{-1}`),
        " か ",
        math(String.raw`a^{-1} < 0`),
        " である。",
        math(String.raw`0 < a^{-1}`),
        " の場合は主張そのものである。",
        math(String.raw`a^{-1} < 0`),
        " の場合が起きないことを示す。この場合には次の 3 本の鎖が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&= a^{-1} + (-a^{-1})
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to a^{-1})\ \text{を右辺から左辺へ}\bigr)\\
&< 0 + (-a^{-1})
&&\bigl(\because\ \text{場合の仮定}\ a^{-1} < 0\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x < y \Rightarrow x + c < y + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to a^{-1},\ y \to 0,\ c \to -a^{-1}\bigr)\\
&= -a^{-1}
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -a^{-1})\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0
&< a\cdot(-a^{-1})
&&\bigl(\because\ \text{主張の仮定}\ 0 < a\ \text{と上の鎖の}\ 0 < -a^{-1}\ \text{と、}\mathbb{R}\ \text{で正の数どうしの積は正（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= a\cdot\bigl((-1)\cdot a^{-1}\bigr)
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to a^{-1})\ \text{を右辺から左辺へ}\bigr)\\
&= \bigl(a\cdot(-1)\bigr)\cdot a^{-1}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \bigl((-1)\cdot a\bigr)\cdot a^{-1}
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot\bigl(a\cdot a^{-1}\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (-1)\cdot 1
&&\bigl(\because\ a\ \text{の乗法の逆元}\ a\cdot a^{-1} = 1\ (a \neq 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -1
&&\bigl(\because\ \blkref{real_minus_one_times_is_negation}\ (a \to 1)\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
1
&= 0 + 1
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&< (-1) + 1
&&\bigl(\because\ \text{上の鎖の}\ 0 < -1\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x < y \Rightarrow x + c < y + c\ \text{（}\blkref{set_and_algebra_notation}\text{）の}\ x \to 0,\ y \to -1,\ c \to 1\bigr)\\
&= 1 + (-1)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の可換律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to 1)\bigr)
\end{aligned}`),
      paragraph(["最後の鎖の ", math(String.raw`1 < 0`), " から矛盾を導く。"]),
      displayMath(String.raw`\begin{aligned}
0 < 1\ \land\ 1 < 0
&\Longrightarrow 0 < 0
&&\bigl(\because\ \text{左の}\ 0 < 1\ \text{は}\ \blkref{real_zero_less_than_one}\text{、}1 < 0\ \text{は最後の鎖。}\mathbb{R}\ \text{の順序の推移律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&\Longrightarrow 0 \neq 0
&&\bigl(\because\ \mathbb{R}\ \text{の}\ x < y\ \text{は}\ x \leq y\ \text{かつ}\ x \neq y\ \text{のことなので、その後半}\ (x \to 0,\ y \to 0)\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`0 \neq 0`),
        " は等号の反射律 ",
        math(String.raw`0 = 0`),
        " に反するので、",
        math(String.raw`a^{-1} < 0`),
        " の場合は起きない。したがって ",
        math(String.raw`0 < a^{-1}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。正の数の乗法の逆元が正であることは順序体の公理に含まれないのに、zero_in_closed_interval_from_minus_half_pi_to_half_pi の準備の 0 < 2^{-1} ほかが「ℝ で正の数の逆数は正（ℝ は順序体）」を名前だけで根拠にしていたので、示す主張として足した。Lean の具体版は Ising2D.real_inverse_of_positive_is_positive（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealInverseOfPositiveIsPositive.lean）、必要十分版は Ising2D.NecSuf.inv_pos_of_orderedAxioms（NecSuf/InvPosOfOrderedAxioms.lean）。数値検証: sagemath/check/real_inverse_of_positive_is_positive/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: 0 + (−a^{-1}) = −a^{-1}（0 + x = x の x → −a^{-1}）と 1 = 0 + 1（x → 1 を右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_negation_of_positive_is_negative",
    kind: "claim",
    title: { text: "正の実数の加法の逆元は負" },
    labels: ["real_negation_of_positive_is_negative"],
    lean: ["Ising2D.real_negation_of_positive_is_negative"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}`),
        "、",
        math(String.raw`0 < a`),
        " とする。和・",
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`x < y`),
        " は ",
        math(String.raw`x \leq y`),
        " かつ ",
        math(String.raw`x \neq y`),
        " のこと）、",
        math(String.raw`-a \in \mathbb{R}`),
        " は ",
        ref("def_real_difference"),
        " の加法の逆元（",
        math(String.raw`z \to a`),
        "）である。このとき",
      ]),
      displayMath(String.raw`-a < 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
-a
&= 0 + (-a)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -a)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&< a + (-a)
&&\bigl(\because\ \text{主張の仮定}\ 0 < a\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ x < y \Rightarrow x + c < y + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ x \to 0,\ y \to a,\ c \to -a\bigr)\\
&= 0
&&\bigl(\because\ \blkref{def_real_difference}\ \text{の加法の逆元}\ z + (-z) = 0\ (z \to a)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。正の数の加法の逆元が負であることは順序体の公理に含まれないのに、trace_of_epsilon_V_plus_via_check_eigenvalues の Step 7 の ȟ = −1 の背理の鎖の 4 行目が「ℝ で a > 0 なら −a < 0」を名前だけで根拠にしていたので、示す主張として足した。Lean の具体版は Ising2D.real_negation_of_positive_is_negative（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealNegationOfPositiveIsNegative.lean）、必要十分版は Ising2D.NecSuf.neg_lt_zero_of_zero_lt（NecSuf/NegLtZeroOfZeroLt.lean）。数値検証: sagemath/check/real_negation_of_positive_is_negative/。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: −a = 0 + (−a)（0 + x = x の x → −a を右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_less_than_is_asymmetric",
    kind: "claim",
    title: { text: "実数の狭義の順序は非対称" },
    labels: ["real_less_than_is_asymmetric"],
    lean: ["Ising2D.real_less_than_is_asymmetric"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        " とする。順序 ",
        math(String.raw`\leq`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`<`),
        " は ",
        ref("def_real_strict_order"),
        " の狭義の順序である。",
        math(String.raw`a < b`),
        " ならば、",
        math(String.raw`b < a`),
        " は成り立たない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`b < a`),
        " と仮定する。",
        math(String.raw`a < b`),
        " の定義（",
        ref("def_real_strict_order"),
        "）から ",
        math(String.raw`a \leq b`),
        " と ",
        math(String.raw`a \neq b`),
        "、",
        math(String.raw`b < a`),
        " の定義（",
        ref("def_real_strict_order"),
        "）から ",
        math(String.raw`b \leq a`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
a
&= b
&&\bigl(\because\ a \leq b\ \text{と}\ b \leq a\ \text{に、}\mathbb{R}\ \text{の順序の反対称律（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）を当てる}\bigr)
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`a \neq b`),
        " に反する。よって ",
        math(String.raw`b < a`),
        " は成り立たない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。狭義の順序の非対称律は順序体の公理に含まれないのに、trace_of_epsilon_V_plus_via_check_eigenvalues の Step 7 の ȟ = −1 の背理が「r < 0 となり r > 0 に反する」を散文だけで根拠にしていたので、示す主張として足した。Lean の具体版は Ising2D.real_less_than_is_asymmetric（MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimRealLessThanIsAsymmetric.lean）、必要十分版は Ising2D.NecSuf.not_lt_of_lt_of_antisymm（NecSuf/NotLtOfLtOfAntisymm.lean）。数値検証: sagemath/check/real_less_than_is_asymmetric/。",
        "2026-11-22（Lean の点検の直し、未定義の記号）: 主張の中で断っていた < の意味を、新しく足した定義のブロック def_real_strict_order への参照に替え、証明の「a < b の定義から」の二か所もそれを引く形にした。論法は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_zero_times_is_zero",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 25 },
    title: { text: "複素数に 0 を左から掛けると 0 になる" },
    labels: ["complex_zero_times_is_zero"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とする。積は ",
        ref("definition_of_cc"),
        "、",
        math(String.raw`0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`0_{\mathbb{C}}\,z = 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (a, b)`),
        "（",
        math(String.raw`a, b \in \mathbb{R}`),
        "）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{C}}\,z
&= (0, 0)\,(a, b)
&&\bigl(\because\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0) = (0,0)\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (0\cdot a - 0\cdot b,\ 0\cdot b + 0\cdot a)
&&\bigl(\because\ \text{複素数の積の定義 }\blkref{definition_of_cc}\bigr)\\
&= (0 - 0,\ 0 + 0)
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ \text{を 4 箇所へ}\ (x \to a,\ x \to b,\ x \to b,\ x \to a)\bigr)\\
&= (0,\ 0 + 0)
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to 0)\bigr)\\
&= (0,\ 0)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。0 を掛けると 0 になることは体の公理に含まれず、本文のどのブロックも述べていなかった。" +
          "単位行列との積（identity_matrix_is_left_unit_of_mat_mult・identity_matrix_is_right_unit_of_mat_mult）の証明が使うので、定義から計算する形で足した。",
        "2026-11-01: 右から 0 を掛ける形は complex_times_zero_is_zero へ移した。この主張を引くのは identity_matrix_is_left_unit_of_mat_mult である。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 3 行目の根拠「ℝ で 0·x = 0（ℝ は体）を 4 箇所へ適用」は名前だけだった（0 を掛けると 0 になることは体の公理に含まれない）ので、足した主張 real_zero_times_is_zero（x → a, b, b, a）の参照に替えた。式は変えていない。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 4 行目の名前だけの根拠「ℝ で 0 − 0 = 0」を real_minus_zero_is_self（a → 0）の参照に替えた（式は不変）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 鎖の (0, 0 + 0) = (0, 0) の行が「ℝ で 0 + 0 = 0」を参照なしで根拠にしていたので、ℝ が体であることを述べる set_and_algebra_notation の参照と使った形（x + 0 = x の x → 0）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_times_zero_is_zero",
    kind: "claim",
    origin: { path: "structured-latex/content/000_calculation_formulae_20_29.ts", ordinal: 25 },
    title: { text: "複素数に 0 を右から掛けると 0 になる" },
    labels: ["complex_times_zero_is_zero"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とする。積は ",
        ref("definition_of_cc"),
        "、",
        math(String.raw`0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`z\,0_{\mathbb{C}} = 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (a, b)`),
        "（",
        math(String.raw`a, b \in \mathbb{R}`),
        "）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,0_{\mathbb{C}}
&= (a, b)\,(0, 0)
&&\bigl(\because\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0) = (0,0)\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (a\cdot 0 - b\cdot 0,\ a\cdot 0 + b\cdot 0)
&&\bigl(\because\ \text{複素数の積の定義 }\blkref{definition_of_cc}\bigr)\\
&= (0 - 0,\ 0 + 0)
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ \text{を 4 箇所へ}\ (x \to a,\ x \to b,\ x \to a,\ x \to b)\bigr)\\
&= (0,\ 0 + 0)
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to 0)\bigr)\\
&= (0,\ 0)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to 0)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{inclusion_rr_to_cc}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-01: 原文（Typst）に対応ブロックは無い。identity_matrix_is_right_unit_of_mat_mult の証明が、右から 0 を掛けた項 A_{ij}0_C を" +
          "積の交換律で 0_C A_{ij} にしてから complex_zero_times_is_zero を使っていた。Lean の必要十分版で、この主張に乗法の可換則が効いていないことが分かったので、" +
          "右から掛ける形を定義から計算する主張として足し、その証明が直接引けるようにした。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 3 行目の根拠「ℝ で x·0 = 0（ℝ は体）を 4 箇所へ適用」は名前だけだった（0 を掛けると 0 になることは体の公理に含まれない）ので、足した主張 real_times_zero_is_zero（x → a, b, a, b）の参照に替えた。式は変えていない。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 4 行目の名前だけの根拠「ℝ で 0 − 0 = 0」を real_minus_zero_is_self（a → 0）の参照に替えた（式は不変）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 鎖の (0, 0 + 0) = (0, 0) の行が「ℝ で 0 + 0 = 0」を参照なしで根拠にしていたので、ℝ が体であることを述べる set_and_algebra_notation の参照と使った形（x + 0 = x の x → 0）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_zero_plus_is_original",
    kind: "claim",
    title: { text: "複素数に 0 を左から足しても変わらない" },
    labels: ["complex_zero_plus_is_original"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とする。和は ",
        ref("definition_of_cc"),
        "、",
        math(String.raw`0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`0_{\mathbb{C}} + z = z`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`z = (a, b)`),
        "（",
        math(String.raw`a, b \in \mathbb{R}`),
        "）と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
0_{\mathbb{C}} + z
&= (0, 0) + (a, b)
&&\bigl(\because\ 0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0) = (0,0)\ \blkref{inclusion_rr_to_cc}\bigr)\\
&= (0 + a,\ 0 + b)
&&\bigl(\because\ \text{複素数の和の定義 }\blkref{definition_of_cc}\bigr)\\
&= (a,\ b)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to a,\ x \to b)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ適用}\bigr)\\
&= z
&&(\because\ z = (a, b))
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。Z_Y_generate_algebra の Step 1 の第 2 式と Step 3 の R_{12}・R_{21} の鎖が、" +
          "「加法の単位元」で 0_C + z = z（左から足す形）を消していたが、complex_numbers_form_a_field が示すのは z + 0_C = z（右から足す形）だけで、左から足す形は加法の可換律を合わせないと出ない。" +
          "complex_zero_times_is_zero・complex_times_zero_is_zero と同じく、定義から計算する主張として足した。Lean の具体版は無く、使う側は zero_add で閉じる（complex_zero_times_is_zero の zero_mul と同じ扱い）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: (0 + a, 0 + b) = (a, b)（0 + x = x の x → a, x → b を 2 箇所へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_complex_minus_zero_is_self",
    kind: "claim",
    title: { text: "複素数から 0 を引いても変わらない" },
    labels: ["complex_minus_zero_is_self"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とする。差は ",
        ref("def_complex_difference"),
        "、和は ",
        ref("definition_of_cc"),
        "、",
        math(String.raw`0_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(0)`),
        " と ",
        math(String.raw`-1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1)`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`z - 0_{\mathbb{C}} = z`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
z - 0_{\mathbb{C}}
&= z + (-0_{\mathbb{C}})
&&\bigl(\because\ \blkref{def_complex_difference}\ (z \to z,\ w \to 0_{\mathbb{C}})\bigr)\\
&= z + (-1_{\mathbb{C}})\,0_{\mathbb{C}}
&&\bigl(\because\ \blkref{multiply_by_minus_one}\ (z \to 0_{\mathbb{C}})\bigr)\\
&= z + 0_{\mathbb{C}}
&&\bigl(\because\ \blkref{complex_times_zero_is_zero}\ (z \to -1_{\mathbb{C}})\bigr)\\
&= z
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法の単位元}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-16（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。exp_of_diagonal_matrix の非対角成分の極限の鎖が ℂ の 0_C − 0_C = 0_C を「0 − 0 = 0」と名前だけで根拠にしていた。z − 0_C = z は体の公理に含まれない（差は def_complex_difference で加法の逆元を足すこととして定めた）ので、real_minus_zero_is_self の ℂ の側として示す主張を足した。Lean の具体版は置かない（complex_zero_times_is_zero・complex_times_zero_is_zero・complex_zero_plus_is_original と同じく、ℂ の元の基本の計算は使う側が mathlib の sub_zero で閉じる。exp_of_diagonal_matrix の Lean の具体版 matrixExp_diagonal_apply は非対角成分の極限の鎖を持たない）。数値検証: sagemath/check/complex_minus_zero_is_self/。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_finite_product_of_complex_numbers",
    kind: "definition",
    title: { text: "複素数の有限積" },
    labels: ["def_finite_product_of_complex_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        " について、有限積 ",
        math(String.raw`\prod_{j=1}^{m} z_j \in \mathbb{C}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\prod_{j=1}^{1} z_j := z_1,
\qquad
\prod_{j=1}^{m+1} z_j := \Bigl(\prod_{j=1}^{m} z_j\Bigr)\, z_{m+1}`),
      paragraph([
        "と定める（左から順に掛ける）。積は ",
        ref("definition_of_cc"),
        " の積である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。クロネッカー積の成分（def_kronecker）をはじめ本文が有限積を使っていたが、定めるブロックが無かった。" +
          "site_sigma_z_is_diagonal（σ_m^z は対角行列）の証明で、0 の因子を持つ有限積が 0 であることを引くのに要るので足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_finite_product_of_real_numbers",
    kind: "definition",
    title: { text: "実数の有限積" },
    labels: ["def_finite_product_of_real_numbers"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " について、有限積 ",
        math(String.raw`\prod_{j=1}^{m} r_j \in \mathbb{R}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\prod_{j=1}^{1} r_j := r_1,
\qquad
\prod_{j=1}^{m+1} r_j := \Bigl(\prod_{j=1}^{m} r_j\Bigr)\, r_{m+1}`),
      paragraph([
        "と定める（左から順に掛ける。",
        ref("def_finite_product_of_complex_numbers"),
        " と同じ帰納法である）。積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 2 が exp(ǧ(ε)) を実数の有限積 Π_μ exp(γ(θ̃_μ)(ε_μ − 1/2)) に書いていたが、本文は複素数の有限積（def_finite_product_of_complex_numbers）しか定めていなかったので足した。Lean は ℝ の Finset.prod（2 つの式は Fin.prod_univ_one・Fin.prod_univ_castSucc）で、必要十分版は Ising2D.NecSuf.finProdLeft（R := ℝ）である。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_positive_reals_is_positive",
    kind: "claim",
    title: { text: "正の実数の有限積は正" },
    labels: ["finite_product_of_positive_reals_is_positive"],
    lean: ["Ising2D.finite_product_of_positive_reals_is_positive"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " がすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " について ",
        math(String.raw`r_j > 0`),
        " を満たすとする。有限積は ",
        ref("def_finite_product_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} r_j > 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} r_j
&= r_1
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&> 0
&&\bigl(\because\ \text{仮定}\ r_1 > 0\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、すべての ",
        math(String.raw`j \in \{1,\dots,m+1\}`),
        " について ",
        math(String.raw`r_j > 0`),
        " を満たす ",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " を取る。帰納法の仮定（",
        math(String.raw`r_1,\dots,r_m`),
        " に当てる）より ",
        math(String.raw`\prod_{j=1}^{m} r_j > 0`),
        "、仮定より ",
        math(String.raw`r_{m+1} > 0`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} r_j
&= \Bigl(\prod_{j=1}^{m} r_j\Bigr)\, r_{m+1}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\bigr)\\
&> 0
&&\bigl(\because\ \mathbb{R}\ \text{で}\ a > 0,\ b > 0\ \text{なら}\ ab > 0\ \bigl(a \to \textstyle\prod_{j=1}^{m} r_j,\ b \to r_{m+1}\bigr)\ \text{に前置きの 2 つの不等号を当てる}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_check_Vprime の Step 4 が Π_μ 2cosh(γ(θ̃_μ)/2) > 0 を「正数の有限積は正」と名前だけで根拠にしていたので、引けるよう足した。Lean は Ising2D.finite_product_of_positive_reals_is_positive（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfPositiveRealsIsPositive.lean）。数値検証: sagemath/check/finite_product_of_positive_reals_is_positive/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_constant_real_is_power",
    kind: "claim",
    title: { text: "実数の定数の有限積は冪に等しい" },
    labels: ["finite_product_of_constant_real_is_power"],
    lean: ["Ising2D.finite_product_of_constant_real_is_power"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r \in \mathbb{R}`),
        " について、",
        math(String.raw`\prod_{j=1}^{m} r \in \mathbb{R}`),
        " を ",
        ref("def_finite_product_of_real_numbers"),
        "（",
        math(String.raw`r_j \to r`),
        "、すなわちすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " で因子を ",
        math(String.raw`r`),
        " とした有限積）とし、",
        math(String.raw`r^m \in \mathbb{R}`),
        " を ",
        ref("def_power_of_real_number"),
        " の冪とする。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} r = r^m`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} r
&= r
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to r)\bigr)\\
&= 1\, r
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to r)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&= r^0\, r
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to r)\ \text{を右辺から左辺へ}\bigr)\\
&= r^1
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to r,\ m \to 0)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} r
&= \Bigl(\prod_{j=1}^{m} r\Bigr)\, r
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to r)\bigr)\\
&= r^m\, r
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= r^{m+1}
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to r)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup が x^{(+)} の各成分を「(a_+)_{i_k} = 1/√2 なので (1/√2)^{M_col}」と散文の 1 文で述べていたので、成分の値の鎖から引けるよう足した。Lean は Ising2D.finite_product_of_constant_real_is_power（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfConstantRealIsPower.lean）。数値検証: sagemath/check/finite_product_of_constant_real_is_power/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（検査は落とさない。def_finite_product_of_real_numbers の近くに置くか、定義の置き場を前へ移すかは、状態台帳の前方参照の件と合わせて扱う）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: m = 1 の鎖の r = 1·r の行が「1 は ℝ の乗法の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（1·x = x の x → r を右辺から左辺へ）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_product_of_real_powers_is_power_of_product",
    kind: "claim",
    title: { text: "同じ指数の実数の冪の積は積の冪に等しい" },
    labels: ["product_of_real_powers_is_power_of_product"],
    lean: ["Ising2D.product_of_real_powers_is_power_of_product"],
    statement: [
      paragraph([
        math(String.raw`a, b \in \mathbb{R}`),
        "、",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " とする。冪は ",
        ref("def_power_of_real_number"),
        " の冪、積は ",
        math(String.raw`\mathbb{R}`),
        " の積である。このとき",
      ]),
      displayMath(String.raw`a^m\, b^m = (ab)^m`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
a^0\, b^0
&= 1\cdot 1
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to a,\ a \to b)\ \text{を 2 箇所へ同時に}\bigr)\\
&= 1
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (ab)^0
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to ab)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
a^{m+1}\, b^{m+1}
&= \left(a^m\, a\right)\left(b^m\, b\right)
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to a,\ a \to b)\ \text{を 2 箇所へ同時に}\bigr)\\
&= \left(a^m\, b^m\right)\left(ab\right)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (pq)(rs) = (pr)(qs)\ \text{（乗法の交換律と結合律）}\bigr)\\
&= (ab)^m\,(ab)
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= (ab)^{m+1}
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to ab)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup のノルムの鎖が ((1/√2)^{M_col})^2 = 2^{-M_col} と、本文に定義の無い実数の負の整数の冪と「指数法則」を名前だけで使っていたので、((1/√2)^{M_col})^2 から 1 までを一ステップ一定理でつなぐために足した。Lean は Ising2D.product_of_real_powers_is_power_of_product（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimProductOfRealPowersIsPowerOfProduct.lean）。数値検証: sagemath/check/product_of_real_powers_is_power_of_product/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（finite_product_of_constant_real_is_power と同じ扱い）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: m = 0 の鎖の 1·1 = 1 の行が「1 は ℝ の乗法の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（x·1 = x の x → 1）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_power_of_real_one_is_one",
    kind: "claim",
    title: { text: "実数の 1 の冪は 1" },
    labels: ["power_of_real_one_is_one"],
    lean: ["Ising2D.power_of_real_one_is_one"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " とする。",
        math(String.raw`1 \in \mathbb{R}`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の単位元、冪は ",
        ref("def_power_of_real_number"),
        " の冪である。このとき",
      ]),
      displayMath(String.raw`1^m = 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
1^0
&= 1
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^0 := 1\ (a \to 1)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
1^{m+1}
&= 1^m\cdot 1
&&\bigl(\because\ \blkref{def_power_of_real_number}\ \text{の}\ a^{m+1} := a^m a\ (a \to 1)\bigr)\\
&= 1\cdot 1
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= 1
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup のノルムの鎖の最後の行 1^{M_col} = 1 を引けるよう足した。Lean は Ising2D.power_of_real_one_is_one（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimPowerOfRealOneIsOne.lean）。数値検証: sagemath/check/power_of_real_one_is_one/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（finite_product_of_constant_real_is_power と同じ扱い）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 帰納法の段の鎖の 1·1 = 1 の行が「1 は ℝ の乗法の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（x·1 = x の x → 1）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_sqrt_of_real_one_is_one",
    kind: "claim",
    title: { text: "1 の平方根は 1" },
    labels: ["sqrt_of_real_one_is_one"],
    lean: ["Ising2D.sqrt_of_real_one_is_one"],
    statement: [
      paragraph([
        math(String.raw`1 \in \mathbb{R}`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の乗法の単位元、",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        " の平方根である。このとき",
      ]),
      displayMath(String.raw`\sqrt{1}^{(\mathbb{R}_{\ge 0})} = 1`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`1 \ge 0`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の順序で成り立つので ",
        math(String.raw`1 \in \mathbb{R}_{\ge 0}`),
        " であり、",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`x \to 1`),
        " と ",
        math(String.raw`y \to 1`),
        " の両方に当てられる。",
        ref("definition_of_sqrt_r_positive"),
        "（",
        math(String.raw`x \to 1`),
        "）により、",
        math(String.raw`\sqrt{1}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        math(String.raw`y \ge 0 \land y^2 = 1`),
        " を満たすただ一つの ",
        math(String.raw`y \in \mathbb{R}_{\ge 0}`),
        " である（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。二乗 ",
        math(String.raw`y^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。",
        math(String.raw`y \to 1`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
1^2
&= 1
&&\bigl(\because\ \blkref{power_of_real_one_is_one}\ (m \to 2)\bigr)
\end{aligned}`),
      paragraph([
        "である。よって ",
        math(String.raw`y \to 1`),
        " は ",
        math(String.raw`y \ge 0 \land y^2 = 1`),
        " を満たし、そのような ",
        math("y"),
        " はただ一つ（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "、",
        math(String.raw`x \to 1`),
        "）なので ",
        math(String.raw`\sqrt{1}^{(\mathbb{R}_{\ge 0})} = 1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_rayleigh_sup・trace_power_upper_bound・trace_power_sandwich のノルムの鎖の最後の行 √1 = 1 が、definition_of_sqrt_r_positive（x → 1）と 1^2 = 1 の 2 つの事実を 1 行で使っていたので、1 行 1 事実で引けるよう足した。Lean は Ising2D.sqrt_of_real_one_is_one（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSqrtOfRealOneIsOne.lean）。数値検証: sagemath/check/sqrt_of_real_one_is_one/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（power_of_real_one_is_one と同じ扱い）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_sqrt_of_real_zero_is_zero",
    kind: "claim",
    title: { text: "0 の平方根は 0" },
    labels: ["sqrt_of_real_zero_is_zero"],
    lean: ["Ising2D.sqrt_of_real_zero_is_zero"],
    statement: [
      paragraph([
        math(String.raw`0 \in \mathbb{R}`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の加法の単位元、",
        math(String.raw`\sqrt{\cdot}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        ref("definition_of_sqrt_r_positive"),
        " の平方根である。このとき",
      ]),
      displayMath(String.raw`\sqrt{0}^{(\mathbb{R}_{\ge 0})} = 0`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`0 \ge 0`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の順序で成り立つので ",
        math(String.raw`0 \in \mathbb{R}_{\ge 0}`),
        " であり、",
        ref("definition_of_sqrt_r_positive"),
        " の ",
        math(String.raw`x \to 0`),
        " と ",
        math(String.raw`y \to 0`),
        " の両方に当てられる。",
        ref("definition_of_sqrt_r_positive"),
        "（",
        math(String.raw`x \to 0`),
        "）により、",
        math(String.raw`\sqrt{0}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        math(String.raw`y \ge 0 \land y^2 = 0`),
        " を満たすただ一つの ",
        math(String.raw`y \in \mathbb{R}_{\ge 0}`),
        " である（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。二乗 ",
        math(String.raw`y^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）である。",
        math(String.raw`y \to 0`),
        " について、",
      ]),
      displayMath(String.raw`\begin{aligned}
0^2
&= 0\cdot 0
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to 0)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x \to 0)\bigr)
\end{aligned}`),
      paragraph([
        "である。よって ",
        math(String.raw`y \to 0`),
        " は ",
        math(String.raw`y \ge 0 \land y^2 = 0`),
        " を満たし、そのような ",
        math("y"),
        " はただ一つ（",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "、",
        math(String.raw`x \to 0`),
        "）なので ",
        math(String.raw`\sqrt{0}^{(\mathbb{R}_{\ge 0})} = 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-08（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。relation_of_gamma_2_theta_tilde の準備の第五の cos(π/2) の鎖の最後の行 √0 = 0 が、0 ≥ 0・0^2 = 0・definition_of_sqrt_r_positive の一意性を 1 行で使っていたので、1 行 1 事実で引けるよう足した（sqrt_of_real_one_is_one と同じ形）。Lean は Ising2D.sqrt_of_real_zero_is_zero（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSqrtOfRealZeroIsZero.lean）。数値検証: sagemath/check/sqrt_of_real_zero_is_zero/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（sqrt_of_real_one_is_one と同じ扱い）。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 鎖の最後の行の根拠が名前だけの「ℝ で 0·x = 0（ℝ は体）の x → 0」だった（0 を掛けると 0 になることは体の公理に含まれない）ので、real_zero_times_is_zero（x → 0）の参照に替えた（式は不変）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_sqrt_of_positive_real_is_positive",
    kind: "claim",
    title: { text: "正の実数の平方根は正" },
    labels: ["sqrt_of_positive_real_is_positive"],
    lean: ["Ising2D.sqrt_of_positive_real_is_positive"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}_{>0}`),
        " について ",
        math(String.raw`x \in \mathbb{R}_{\ge 0}`),
        " であり、",
        ref("definition_of_sqrt_r_positive"),
        " の平方根について",
      ]),
      displayMath(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})} > 0`),
      paragraph(["が成り立つ。", math(String.raw`>`), " は ", math(String.raw`\mathbb{R}`), " の順序である。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`x > 0`),
        " なので ",
        math(String.raw`x \ge 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序で ",
        math(String.raw`x \ge 0`),
        " は ",
        math(String.raw`x > 0`),
        " または ",
        math(String.raw`x = 0`),
        " のこと）であり、",
        math(String.raw`y := \sqrt{x}^{(\mathbb{R}_{\ge 0})} \in \mathbb{R}`),
        " が定まる。",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`y \ge 0`),
        " かつ ",
        math(String.raw`y^2 = x`),
        " である（二乗 ",
        math(String.raw`y^2`),
        " は ",
        ref("def_power_of_real_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "））。",
        math(String.raw`y \neq 0`),
        " を背理法で示す。",
        math(String.raw`y = 0`),
        " と仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
x
&= y^2
&&\bigl(\because\ \blkref{definition_of_sqrt_r_positive}\ \text{の}\ y^2 = x\ \text{を右辺から左辺へ}\bigr)\\
&= 0^2
&&(\because\ \text{仮定}\ y = 0)\\
&= 0\cdot 0
&&\bigl(\because\ \blkref{square_of_real_number_is_product}\ (r \to 0)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x \to 0)\bigr)
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`x > 0`),
        " に反する（",
        math(String.raw`x = 0`),
        " なら ",
        math(String.raw`x > 0`),
        " は ",
        math(String.raw`0 > 0`),
        " となり、",
        math(String.raw`\mathbb{R}`),
        " の順序 ",
        math(String.raw`<`),
        " の非反射律に反する）。よって ",
        math(String.raw`y \neq 0`),
        " である。",
        math(String.raw`y \ge 0`),
        " は ",
        math(String.raw`y > 0`),
        " または ",
        math(String.raw`y = 0`),
        " のことなので（",
        math(String.raw`\mathbb{R}`),
        " の順序）、",
        math(String.raw`\sqrt{x}^{(\mathbb{R}_{\ge 0})} = y > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-11（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。diagonalization_check_P_D の Step 1 が「M_col ≥ 2 より √M_col > 0」の根拠に sqrt_nonnegative_existence_uniqueness（存在と一意性だけを述べる）を引いていたので、正であることを引けるよう足した。Lean は Ising2D.sqrt_of_positive_real_is_positive（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSqrtOfPositiveRealIsPositive.lean）。数値検証: sagemath/check/sqrt_of_positive_real_is_positive/。引く def_power_of_real_number は 020_critical_point.ts にあり、文書の並びでは後に来る（sqrt_of_real_zero_is_zero と同じ扱い）。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: 鎖の最後の行の根拠が名前だけの「ℝ で 0·x = 0（ℝ は体）の x → 0」だった（0 を掛けると 0 になることは体の公理に含まれない）ので、real_zero_times_is_zero（x → 0）の参照に替えた（式は不変）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_inclusion_preserves_finite_product",
    kind: "claim",
    title: { text: "実数の有限積の包含は包含の有限積に等しい" },
    labels: ["real_inclusion_preserves_finite_product"],
    lean: ["Ising2D.real_inclusion_preserves_finite_product"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_m \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} (r_j)_{\mathbb{C}} = \Bigl(\prod_{j=1}^{m} r_j\Bigr)_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、左辺の積は ",
        ref("def_finite_product_of_complex_numbers"),
        " の有限積、右辺の積は ",
        ref("def_finite_product_of_real_numbers"),
        " の有限積である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} (r_j)_{\mathbb{C}}
&= (r_1)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_complex_numbers}\bigr)\\
&= \Bigl(\prod_{j=1}^{1} r_j\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} (r_j)_{\mathbb{C}}
&= \Bigl(\prod_{j=1}^{m} (r_j)_{\mathbb{C}}\Bigr)\,(r_{m+1})_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_complex_numbers}\bigr)\\
&= \Bigl(\prod_{j=1}^{m} r_j\Bigr)_{\mathbb{C}}\,(r_{m+1})_{\mathbb{C}}
&&\bigl(\because\ \text{帰納法の仮定（}r_1,\dots,r_m\ \text{に当てる）}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{m} r_j\Bigr)\, r_{m+1}\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{real_inclusion_preserves_product}\ \bigl(a \to \textstyle\prod_{j=1}^{m} r_j,\ b \to r_{m+1}\bigr)\bigr)\\
&= \Bigl(\prod_{j=1}^{m+1} r_j\Bigr)_{\mathbb{C}}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。def_sector_rayleigh_sup の x^{(+)} を実数のベクトルとして書き直すときに、その包含 ι(x^{(+)}) が複素数のベクトルのクロネッカー積 ι(a_+)⊠⋯⊠ι(a_+) に等しいことを成分の有限積で示すのに要るので足した（real_inclusion_preserves_finite_sum の積の版）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_real_products",
    kind: "claim",
    title: { text: "実数の積の有限積は有限積の積" },
    labels: ["finite_product_of_real_products"],
    lean: ["Ising2D.finite_product_of_real_products"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`x_1,\dots,x_m,\ y_1,\dots,y_m \in \mathbb{R}`),
        " とする。有限積は ",
        ref("def_finite_product_of_real_numbers"),
        " による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} \left(x_j y_j\right) = \Bigl(\prod_{j=1}^{m} x_j\Bigr)\Bigl(\prod_{j=1}^{m} y_j\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} \left(x_j y_j\right)
&= x_1 y_1
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to x_j y_j)\bigr)\\
&= \Bigl(\prod_{j=1}^{1} x_j\Bigr)\Bigl(\prod_{j=1}^{1} y_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to x_j,\ r_j \to y_j)\ \text{を 2 箇所へ同時に、右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} \left(x_j y_j\right)
&= \Bigl(\prod_{j=1}^{m} \left(x_j y_j\right)\Bigr)\left(x_{m+1} y_{m+1}\right)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to x_j y_j)\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{m} x_j\Bigr)\Bigl(\prod_{j=1}^{m} y_j\Bigr)\Bigr)\left(x_{m+1} y_{m+1}\right)
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= \Bigl(\Bigl(\prod_{j=1}^{m} x_j\Bigr)x_{m+1}\Bigr)\Bigl(\Bigl(\prod_{j=1}^{m} y_j\Bigr)y_{m+1}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{で}\ (ab)(cd) = (ac)(bd)\ \text{（乗法の交換律と結合律）}\bigr)\\
&= \Bigl(\prod_{j=1}^{m+1} x_j\Bigr)\Bigl(\prod_{j=1}^{m+1} y_j\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ (r_j \to x_j,\ r_j \to y_j)\ \text{を 2 箇所へ同時に、右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["である。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-04: 原文（Typst）に対応ブロックは無い。trace_of_epsilon_V_plus_via_check_eigenvalues の Step 4 が、符号の有限積と exp の有限積の積を一つの有限積へまとめる行に引けるよう足した。数値検証: sagemath/check/finite_product_of_real_products/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_real_numbers_splits_off_first_factor",
    kind: "claim",
    title: { text: "実数の有限積から先頭の因子を外へ出せる" },
    labels: ["finite_product_of_real_numbers_splits_off_first_factor"],
    lean: ["Ising2D.finite_product_of_real_numbers_splits_off_first_factor"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " とする。有限積は ",
        ref("def_finite_product_of_real_numbers"),
        " による（右辺の ",
        math(String.raw`\prod_{j=1}^{m} r_{j+1}`),
        " は、",
        math(String.raw`j = 1,\dots,m`),
        " の ",
        math(String.raw`r_{j+1}`),
        " の有限積）。積は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " の積である。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m+1} r_j = r_1\Bigl(\prod_{j=1}^{m} r_{j+1}\Bigr)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で、任意の ",
        math(String.raw`r_1,\dots,r_{m+1} \in \mathbb{R}`),
        " について示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{2} r_j
&= \Bigl(\prod_{j=1}^{1} r_j\Bigr) r_2
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{m+1} r_j := \bigl(\prod_{j=1}^{m} r_j\bigr) r_{m+1}\ (m \to 1)\bigr)\\
&= r_1 r_2
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{1} r_j := r_1\bigr)\\
&= r_1\Bigl(\prod_{j=1}^{1} r_{j+1}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{1} r_j := r_1\ (r_j \to r_{j+1})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定する。",
        math(String.raw`r_1,\dots,r_{m+2} \in \mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+2} r_j
&= \Bigl(\prod_{j=1}^{m+1} r_j\Bigr) r_{m+2}
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{m+1} r_j := \bigl(\prod_{j=1}^{m} r_j\bigr) r_{m+1}\ (m \to m+1)\bigr)\\
&= \Bigl(r_1\Bigl(\prod_{j=1}^{m} r_{j+1}\Bigr)\Bigr) r_{m+2}
&&\bigl(\because\ \text{帰納法の仮定}\ (r_1,\dots,r_{m+1}\ \text{に当てる})\bigr)\\
&= r_1\Bigl(\Bigl(\prod_{j=1}^{m} r_{j+1}\Bigr) r_{m+2}\Bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の結合律}\ (xy)t = x(yt)\ \bigl(x \to r_1,\ y \to \textstyle\prod_{j=1}^{m} r_{j+1},\ t \to r_{m+2}\bigr)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= r_1\Bigl(\prod_{j=1}^{m+1} r_{j+1}\Bigr)
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{m+1} r_j := \bigl(\prod_{j=1}^{m} r_j\bigr) r_{m+1}\ (r_j \to r_{j+1})\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`m+1`),
        " でも成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w22)。open_chain_endpoint_product_sum の並べ替えの行を割る件の準備）: 原文（Typst）に対応ブロックは無い。open_chain_endpoint_product_sum の Step 2 の M_col ≥ 3 の鎖の 2 行目が、有限積の先頭の因子 s(1) を外へ出す段を「ℝ の乗法の可換則と結合則を有限積の因子の並べ替えへ」の 1 行に含めており、引ける主張が本文に無かったので足した（末尾の因子を外へ出すのは def_finite_product_of_real_numbers の帰納の式そのもの）。乗法の可換則は使わない。Lean の具体版は Ising2D.finite_product_of_real_numbers_splits_off_first_factor（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealNumbersSplitsOffFirstFactor.lean）、必要十分版は Ising2D.NecSuf.finProdLeft_succ_first（NecSuf/FiniteProductLeftFirstFactor.lean）。数値検証: sagemath/check/finite_product_of_real_numbers_splits_off_first_factor/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_real_ones",
    kind: "claim",
    title: { text: "実数の 1 の有限積は 1" },
    labels: ["finite_product_of_real_ones"],
    lean: ["Ising2D.finite_product_of_real_ones"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`\prod_{j=1}^{m} 1 = 1`),
        " が成り立つ。有限積は ",
        ref("def_finite_product_of_real_numbers"),
        " による（",
        math(String.raw`r_1 = \dots = r_m = 1`),
        "）。",
        math(String.raw`1`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " の乗法の単位元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} 1
&= 1
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{1} r_j := r_1\ (r_j \to 1)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`m`),
        " で成り立つと仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} 1
&= \Bigl(\prod_{j=1}^{m} 1\Bigr)\, 1
&&\bigl(\because\ \blkref{def_finite_product_of_real_numbers}\ \text{の}\ \textstyle\prod_{j=1}^{m+1} r_j := \bigl(\prod_{j=1}^{m} r_j\bigr) r_{m+1}\ (r_j \to 1)\bigr)\\
&= 1 \cdot 1
&&\bigl(\because\ \text{帰納法の仮定}\bigr)\\
&= 1
&&\bigl(\because\ \mathbb{R}\ \text{の乗法の単位元}\ p\cdot 1 = p\ (p \to 1)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`m+1`),
        " でも成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-19（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p38w46)。1 の有限積の行を割る件）: 原文（Typst）に対応ブロックは無い。open_chain_endpoint_product_sum の Step 2 の M_col ≥ 3 の鎖の最後の行が「1 の有限積は 1」を名前だけで根拠にしており、本文には複素数の finite_product_of_complex_ones しか無かったので、実数の主張を足した。Lean の具体版は Ising2D.finite_product_of_real_ones（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimFiniteProductOfRealOnes.lean）、必要十分版は Ising2D.NecSuf.finProdLeft_const_one'（NecSuf/FiniteProductLeft.lean。効くのは 1·1 = 1 だけ）。数値検証: sagemath/check/finite_product_of_real_ones/。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_power_of_complex_number",
    kind: "definition",
    title: { text: "複素数の冪" },
    labels: ["def_power_of_complex_number"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " と ",
        math(String.raw`m \in \mathbb{Z}_{\geq 0}`),
        " について、冪 ",
        math(String.raw`z^m \in \mathbb{C}`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`z^0 := 1_{\mathbb{C}},
\qquad
z^{m+1} := z^m\, z`),
      paragraph([
        "と定める。積は ",
        ref("definition_of_cc"),
        " の積、",
        math(String.raw`1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。check_joint_eigenspace_decomposition の Step 4 の最後の行 2^0 = 1 が「冪の零乗」を名前だけで根拠にしていたので足した。" +
          "行列の冪（def_exp (1) の A^0 := I、A^{m+1} := A^m A）と同じ形に揃えた。Lean の ℂ の冪は Monoid.npow で、二つの式は pow_zero・pow_succ である。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_square_of_complex_number_is_product",
    kind: "claim",
    title: { text: "複素数の二乗は、その複素数を二つ掛けた積に等しい" },
    labels: ["square_of_complex_number_is_product"],
    lean: ["Ising2D.square_of_complex_number_is_product"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " とする。二乗 ",
        math(String.raw`z^2`),
        " は ",
        ref("def_power_of_complex_number"),
        " の冪（",
        math(String.raw`m = 2`),
        "）、積は ",
        ref("definition_of_cc"),
        " の積である。このとき",
      ]),
      displayMath(String.raw`z^2 = z\,z`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
z^2
&= z^1\,z
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^{m+1} := z^m\, z\ (m \to 1)\bigr)\\
&= (z^0\,z)\,z
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^{m+1} := z^m\, z\ (m \to 0)\bigr)\\
&= (1_{\mathbb{C}}\,z)\,z
&&\bigl(\because\ \blkref{def_power_of_complex_number}\ \text{の}\ z^0 := 1_{\mathbb{C}}\bigr)\\
&= z\,z
&&\bigl(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-10（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。det_A_theta_tilde の鎖の冪の行が「def_power_of_complex_number より z^2 = (1_ℂz)z = zz」と、冪の定義の 3 つの式と積の単位元を 1 行で当てていたので、主張として切り出して引くようにした。square_of_real_number_is_product と同じ 4 行の鎖にした。Lean は Ising2D.square_of_complex_number_is_product（MathematicalTools/TrigonometricEstimatesFiniteSumsAndIntegrals/ClaimSquareOfComplexNumberIsProduct.lean）。数値検証: sagemath/check/square_of_complex_number_is_product/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_with_zero_factor_is_zero",
    kind: "claim",
    title: { text: "0 の因子を持つ複素数の有限積は 0" },
    labels: ["finite_product_with_zero_factor_is_zero"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        "、",
        math(String.raw`n \in \{1,\dots,m\}`),
        " とし、",
        math(String.raw`z_n = 0_{\mathbb{C}}`),
        " とする。有限積は ",
        ref("def_finite_product_of_complex_numbers"),
        "、",
        math(String.raw`0_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} z_j = 0_{\mathbb{C}}`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`n = 1`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} z_j
&= z_1
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= 0_{\mathbb{C}}
&&(\because\ n = 1\ \text{と}\ z_n = 0_{\mathbb{C}})
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`z_1,\dots,z_{m+1} \in \mathbb{C}`),
        "、",
        math(String.raw`n \in \{1,\dots,m+1\}`),
        "、",
        math(String.raw`z_n = 0_{\mathbb{C}}`),
        " とする。",
        math(String.raw`n = m+1`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} z_j
&= \Bigl(\prod_{j=1}^{m} z_j\Bigr)\, z_{m+1}
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= \Bigl(\prod_{j=1}^{m} z_j\Bigr)\, 0_{\mathbb{C}}
&&(\because\ n = m+1\ \text{と}\ z_n = 0_{\mathbb{C}})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{complex_times_zero_is_zero})
\end{aligned}`),
      paragraph([
        math(String.raw`n \in \{1,\dots,m\}`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} z_j
&= \Bigl(\prod_{j=1}^{m} z_j\Bigr)\, z_{m+1}
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= 0_{\mathbb{C}}\, z_{m+1}
&&(\because\ \text{帰納法の仮定を}\ z_1,\dots,z_m\ \text{と}\ n\ \text{へ})\\
&= 0_{\mathbb{C}}
&&(\because\ \blkref{complex_zero_times_is_zero})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。site_sigma_z_is_diagonal（σ_m^z は対角行列）の証明が、クロネッカー積の成分の積の一つの因子が 0 であることから成分が 0 になることを引くので足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_complex_ones",
    kind: "claim",
    title: { text: "1 の有限積は 1" },
    labels: ["finite_product_of_complex_ones"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        " について ",
        math(String.raw`\prod_{j=1}^{m} 1_{\mathbb{C}} = 1_{\mathbb{C}}`),
        " が成り立つ。有限積は ",
        ref("def_finite_product_of_complex_numbers"),
        "、",
        math(String.raw`1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      paragraph([math(String.raw`m`), " についての帰納法で示す。", math(String.raw`m = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} 1_{\mathbb{C}}
&= 1_{\mathbb{C}}
&&(\because\ \blkref{def_finite_product_of_complex_numbers})
\end{aligned}`),
      paragraph([math(String.raw`m`), " で成り立つと仮定すると"]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} 1_{\mathbb{C}}
&= \Bigl(\prod_{j=1}^{m} 1_{\mathbb{C}}\Bigr)\, 1_{\mathbb{C}}
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= 1_{\mathbb{C}}\, 1_{\mathbb{C}}
&&(\because\ \text{帰納法の仮定})\\
&= 1_{\mathbb{C}}
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の積の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。config_basis_vector_own_component（f_I の第 ν(I) 成分は 1）の証明が使うので足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_product_of_real_inclusions_is_real",
    kind: "claim",
    title: { text: "実数の包含の有限積は実数の包含" },
    labels: ["finite_product_of_real_inclusions_is_real"],
    lean: ["Ising2D.finite_product_of_real_inclusions_is_real"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        " とし、各 ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " について ",
        math(String.raw`z_j = (r_j)_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`r_j \in \mathbb{R}`),
        " が存在するとする。有限積は ",
        ref("def_finite_product_of_complex_numbers"),
        "、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`\prod_{j=1}^{m} z_j = r_{\mathbb{C}}`),
      paragraph([
        "を満たす ",
        math(String.raw`r \in \mathbb{R}`),
        " が存在する。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき、仮定の ",
        math(String.raw`r_1 \in \mathbb{R}`),
        " を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{1} z_j
&= z_1
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= (r_1)_{\mathbb{C}}
&&(\because\ \text{仮定を}\ j = 1\ \text{で})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`r := r_1`),
        " が求めるものである。",
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`z_1,\dots,z_{m+1} \in \mathbb{C}`),
        " の各 ",
        math(String.raw`z_j`),
        " が ",
        math(String.raw`z_j = (r_j)_{\mathbb{C}}`),
        "（",
        math(String.raw`r_j \in \mathbb{R}`),
        "）を満たすとする。帰納法の仮定を ",
        math(String.raw`z_1,\dots,z_m`),
        " に適用して、",
        math(String.raw`\prod_{j=1}^{m} z_j = s_{\mathbb{C}}`),
        " を満たす ",
        math(String.raw`s \in \mathbb{R}`),
        " を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{j=1}^{m+1} z_j
&= \Bigl(\prod_{j=1}^{m} z_j\Bigr)\, z_{m+1}
&&(\because\ \blkref{def_finite_product_of_complex_numbers})\\
&= s_{\mathbb{C}}\, z_{m+1}
&&(\because\ s\ \text{の取り方})\\
&= s_{\mathbb{C}}\, (r_{m+1})_{\mathbb{C}}
&&(\because\ \text{仮定を}\ j = m+1\ \text{で})\\
&= (s\, r_{m+1})_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_product}\ (a \to s,\ b \to r_{m+1}))
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`r := s\, r_{m+1} \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の積）が求めるものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 3 が「クロネッカー積の成分は各因子の成分の積なので実」を名前だけで述べていたので、クロネッカー積の成分の実性（kronecker_of_real_entry_matrices_has_real_entries）を示すのに引けるよう足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_finite_sum_with_single_nonzero_term",
    kind: "claim",
    title: { text: "一つの項のほかが 0 の有限和はその項に等しい" },
    labels: ["finite_sum_with_single_nonzero_term"],
    lean: ["Ising2D.finite_sum_with_single_nonzero_term_succ", "Ising2D.finite_sum_with_single_nonzero_term_fintype"],
    statement: [
      paragraph([
        math(String.raw`m \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`z_1,\dots,z_m \in \mathbb{C}`),
        "、",
        math(String.raw`n \in \{1,\dots,m\}`),
        " とし、",
        math(String.raw`j \neq n`),
        " のすべての ",
        math(String.raw`j \in \{1,\dots,m\}`),
        " について ",
        math(String.raw`z_j = 0_{\mathbb{C}}`),
        " とする。有限和は ",
        ref("def_finite_sum_of_complex_numbers"),
        "、",
        math(String.raw`0_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記による。このとき",
      ]),
      displayMath(String.raw`\sum_{j=1}^{m} z_j = z_n`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のとき ",
        math(String.raw`n = 1`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{1} z_j
&= z_1
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= z_n
&&(\because\ n = 1)
\end{aligned}`),
      paragraph([
        math(String.raw`m`),
        " で成り立つと仮定し、",
        math(String.raw`z_1,\dots,z_{m+1} \in \mathbb{C}`),
        "、",
        math(String.raw`n \in \{1,\dots,m+1\}`),
        " が仮定を満たすとする。",
        math(String.raw`n = m+1`),
        " のとき、",
        math(String.raw`j \in \{1,\dots,m\}`),
        " はどれも ",
        math(String.raw`j \neq n`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} z_j
&= \Bigl(\sum_{j=1}^{m} z_j\Bigr) + z_{m+1}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= \Bigl(\sum_{j=1}^{m} 0_{\mathbb{C}}\Bigr) + z_{m+1}
&&(\because\ j \leq m\ \text{のとき}\ z_j = 0_{\mathbb{C}}\ \text{を各項へ同時に適用})\\
&= 0_{\mathbb{C}} + z_{m+1}
&&(\because\ \blkref{finite_sum_of_complex_zeros})\\
&= z_{m+1}
&&(\because\ \blkref{complex_zero_plus_is_original}\ (z \to z_{m+1}))\\
&= z_n
&&(\because\ n = m+1)
\end{aligned}`),
      paragraph([
        math(String.raw`n \in \{1,\dots,m\}`),
        " のとき、",
        math(String.raw`m+1 \neq n`),
        " なので ",
        math(String.raw`z_{m+1} = 0_{\mathbb{C}}`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{j=1}^{m+1} z_j
&= \Bigl(\sum_{j=1}^{m} z_j\Bigr) + z_{m+1}
&&(\because\ \blkref{def_finite_sum_of_complex_numbers})\\
&= z_n + z_{m+1}
&&(\because\ \text{帰納法の仮定を}\ z_1,\dots,z_m\ \text{と}\ n\ \text{へ})\\
&= z_n + 0_{\mathbb{C}}
&&(\because\ z_{m+1} = 0_{\mathbb{C}})\\
&= z_n
&&(\because\ \blkref{complex_numbers_form_a_field}\ \text{の加法の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。site_sigma_z_product_diagonal_entry（σ_m^zσ_{m'}^z の対角成分）の証明が、行列と基底ベクトルの積の成分の和を一つの項に縮めるのに使うので足した。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: n = m+1 の鎖で左から足す 0_C を消す行の根拠を、complex_numbers_form_a_field の「加法の単位元」（右から足す z + 0_C = z しか示していない）から complex_zero_plus_is_original に替えた。式は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_027_definition_phi_polar",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/000_計算公式/026_definition_極座標表現のCCへの写像_phi_polar.typ",
      ordinal: 27,
    },
    title: {
      text: "複素数から極座標同値類への写像",
    },
    labels: ["def_phi_polar"],
    statement: [
      paragraph([ref("polar_equivalence_class"), " の同値類と、", ref("definition_of_sqrt_r_positive"), "、", ref("def_arctan"), " を用いる。"]),
      paragraph([
        math(String.raw`\phi_{\mathrm{polar}} : \mathbb{C} \to (\text{極座標表現})`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(x,y):=
\begin{cases}
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x))\right]_{\sim} & (x>0),\\
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x)+\pi)\right]_{\sim} & (x<0,\ y\ge 0),\\
	\left[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\ge 0}},\arctan(y/x)-\pi)\right]_{\sim} & (x<0,\ y<0),\\
\left[(y,\pi/2)\right]_{\sim} & (x=0,\ y>0),\\
\left[(-y,-\pi/2)\right]_{\sim} & (x=0,\ y<0),\\
\left[(0,0)\right]_{\sim} & (x=0,\ y=0).
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_028_definition_phi_cartesian",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ",
      ordinal: 28,
    },
    title: {
      text: "極座標同値類から複素数への写像",
    },
    labels: ["def_phi_cartesian"],
    statement: [
      paragraph([ref("polar_equivalence_class"), " の商集合と ", ref("angle_equivalence_class"), " の関係を使う。以下の式に必要な正弦・余弦は、現在の ", ref("def_sin"), " と ", ref("def_cos"), " では主値区間に限られている。全実数上への拡張と周期性が未整備のため、以下の写像定義と代表元独立性の説明は未完である。"]),
      paragraph([
        math(String.raw`\phi_{\mathrm{cartesian}} : (\text{極座標表現}) \to \mathbb{C}`),
        " を次で定める。",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim}) := (r\cos\theta,\ r\sin\theta)`,
      ),
      paragraph([
        "この右辺は同値類の代表元の取り方によらないので、",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は well-defined である。実際、",
      ]),
      displayMath(
        String.raw`[\theta]_{\sim_{\mathrm{angle}}}=[\theta']_{\sim_{\mathrm{angle}}}
\Rightarrow \exists n\in\mathbb{Z}\ \text{s.t.}\ \theta-\theta'=2n\pi
\Rightarrow \cos\theta=\cos\theta',\ \sin\theta=\sin\theta'`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "定義の well-defined 性（代表元によらないこと）は、原文では note に置かれていたが" +
          "定義の妥当性そのものなので statement へ格上げした。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_phi_cartesian_after_phi_polar_is_identity",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ",
      ordinal: 29,
    },
    title: {
      tex: "\\phi_{\\mathrm{cartesian}}\\circ\\phi_{\\mathrm{polar}}=\\mathrm{id}_{\\mathbb{C}}",
    },
    labels: ["phi_cartesian_after_phi_polar_is_identity"],
    statement: [
      paragraph([ref("def_phi_polar"), " と ", ref("def_phi_cartesian"), " の写像を用いる。", ref("def_phi_cartesian"), " は正弦・余弦が主値区間でしか定まっていないため未完であり（", math(String.raw`x<0`), " の場合は主値区間の外の角を使う）、この主張もそれが整うまで未完である。"]),
      paragraph([
        math(String.raw`(x,y)\in\mathbb{C}`),
        " について、",
        math(String.raw`(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)=(x,y)`),
        "。すなわち ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_phi_polar"),
        " の場合分けに沿って場合ごとに示す。",
        "場合分けなので全体を 1 つの式変形にはできないが、各場合の中の計算はそれぞれ一続きにする。",
      ]),
      paragraph([
        math(String.raw`x>0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x>0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,(y/x)}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \arctan\ \text{の}\ \cos,\sin\text{。}\blkref{cos_arctan_sin_arctan})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x>0\ \text{なので分母と分子に}\ x\ \text{を掛けられる})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x>0\ \text{と平方根の一意性から}\ x=\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\text{。}\blkref{definition_of_sqrt_r_positive}\ \blkref{sqrt_nonnegative_existence_uniqueness})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{平方根の一意性から}\ \sqrt{a}\sqrt{b}=\sqrt{ab}\text{。}\blkref{sqrt_nonnegative_existence_uniqueness})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x^2\bigl(1+(y/x)^2\bigr)=x^2+y^2)\\
&= (x,\ y)
&&(\because\ x>0\ \text{なので}\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\ne0\ \text{で約分できる})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x<0`),
        " の場合。",
        math(String.raw`y\geq 0`),
        " と ",
        math(String.raw`y<0`),
        " で ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " の値は違うが、いずれも同じ式に着く。まず ",
        math(String.raw`y\geq 0`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)+\pi\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x<0,\ y\geq0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos\bigl(\arctan(y/x)+\pi\bigr),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin\bigl(\arctan(y/x)+\pi\bigr)\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= \Bigl(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))\Bigr)
&&(\because\ \cos(\theta+\pi)=-\cos\theta,\ \sin(\theta+\pi)=-\sin\theta)
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`y<0`),
        " のとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)-\pi\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x<0,\ y<0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos\bigl(\arctan(y/x)-\pi\bigr),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin\bigl(\arctan(y/x)-\pi\bigr)\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= \Bigl(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))\Bigr)
&&(\because\ \cos(\theta-\pi)=-\cos\theta,\ \sin(\theta-\pi)=-\sin\theta)
\end{aligned}`,
      ),
      paragraph([
        "である。いずれの場合も同じ式に着いたので、そこから続けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\Bigl(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))\Bigr)\\
&\quad= \left(-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,(y/x)}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \arctan\ \text{の}\ \cos,\sin\text{。}\blkref{cos_arctan_sin_arctan})\\
&\quad= \left(-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x<0\ \text{なので分母と分子に}\ x\ \text{を掛けられる})\\
&\quad= \left(-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x<0\ \text{のとき}\ x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\text{。}\blkref{negative_number_to_sqrt})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{分子の負号と分母の負号が相殺する})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ (-x)^2=x^2)\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{平方根の一意性から}\ \sqrt{a}\sqrt{b}=\sqrt{ab}\text{。}\blkref{sqrt_nonnegative_existence_uniqueness})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x^2\bigl(1+(y/x)^2\bigr)=x^2+y^2)\\
&\quad= (x,\ y)
&&(\because\ x<0\ \text{なので}\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\ne0\ \text{で約分できる})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y>0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\bigl([(y,\ \pi/2)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y>0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \bigl(y\cos(\pi/2),\ y\sin(\pi/2)\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (y\cdot 0,\ y\cdot 1)
&&(\because\ \cos(\pi/2)=0,\ \sin(\pi/2)=1)\\
&= (0,\ y\cdot 1)
&&(\because\ \blkref{real_times_zero_is_zero}\ (x\to y))\\
&= (0,\ y)
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ x\cdot 1 = x\ (x \to y)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= (x,\ y)
&&(\because\ x=0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y<0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\bigl([(-y,\ -\pi/2)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y<0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \bigl((-y)\cos(-\pi/2),\ (-y)\sin(-\pi/2)\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= \bigl((-y)\cdot 0,\ (-y)\cdot(-1)\bigr)
&&(\because\ \cos(-\pi/2)=0,\ \sin(-\pi/2)=-1)\\
&= \bigl(0,\ (-y)\cdot(-1)\bigr)
&&(\because\ \blkref{real_times_zero_is_zero}\ (x\to -y))\\
&= \bigl(0,\ (-1)\cdot(-y)\bigr)
&&(\because\ \mathbb{R}\ \text{の乗法の可換律（}\blkref{set_and_algebra_notation}\text{）})\\
&= \bigl(0,\ -(-y)\bigr)
&&(\because\ \blkref{real_minus_one_times_is_negation}\ (a\to -y))\\
&= (0,\ y)
&&(\because\ \blkref{real_double_negation}\ (a\to y))\\
&= (x,\ y)
&&(\because\ x=0)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y=0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl(\phi_{\mathrm{polar}}(x,y)\bigr)
&&(\because\ \text{写像の合成の定義})\\
&= \phi_{\mathrm{cartesian}}\bigl([(0,\ 0)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y=0\ \text{の場合。}\blkref{def_phi_polar})\\
&= (0\cdot\cos 0,\ 0\cdot\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (0,\ 0)
&&(\because\ \blkref{real_zero_times_is_zero}\ (x\to\cos 0,\ x\to\sin 0)\ \text{を 2 箇所へ適用})\\
&= (x,\ y)
&&(\because\ x=0\ \text{かつ}\ y=0)
\end{aligned}`,
      ),
      paragraph([
        "以上で ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " の定義のすべての場合について ",
        math(String.raw`(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)=(x,y)`),
        " が示され、",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-11-01、1 ブロック 1 主張に従い、isomorphism_of_phi_cartesian の証明の後半（合成が恒等写像であることの場合分けの計算）を" +
          "この主張として切り出した。同時に、各場合の末尾の参照の一覧を各行の \\blkref に移し、各場合の最初の行を写像の合成の定義と φ_polar の定義の二行に分けた。計算は変えていない。",
        "2026-11-14（Lean の通しの証明のゴールラインの確認）: x = 0 の三つの場合の鎖の「0 を因子にもつ積は 0」を、real_times_zero_is_zero・real_zero_times_is_zero（同じファイルの前のブロック）の参照に替え、1 は積の単位元・負号を 2 度施すことと束ねていた 2 行はそれぞれ 2 行に割った。鎖の両端は不変。Lean の具体版は無い。数値検証: sagemath/check/phi_cartesian_after_phi_polar_is_identity/ の x = 0 の鎖を割った行に合わせた。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: x = 0, y < 0 の鎖の「負号を 2 度施すともとに戻る」で (−y)(−1) = y を済ませていた 1 行を、ℝ の乗法の可換則・real_minus_one_times_is_negation（a → −y）・real_double_negation（a → y）の 3 行に割った。鎖の両端と主張は不変。Lean の具体版は無い。数値検証: sagemath/check/phi_cartesian_after_phi_polar_is_identity/ の同じ鎖を割った行に合わせた。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: x = 0, y > 0 の鎖の y·1 = y の行が「ℝ では 1 は積の単位元」を参照なしで根拠にしていたので、set_and_algebra_notation の参照と使った形（x·1 = x の x → y）の行にした。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ",
      ordinal: 29,
    },
    title: {
      tex: "\\phi_{\\mathrm{cartesian}}\\text{の同型性}",
    },
    labels: ["isomorphism_of_phi_cartesian"],
    statement: [
      paragraph(["（TODO: 原稿注記「体として同型を示す」あり）"]),
      paragraph([
        math(String.raw`A,B\in(\text{極座標表現})`),
        " に対して次が成り立つ。",
      ]),
      list([
        [
          math(
            String.raw`\phi_{\mathrm{cartesian}}(A\cdot B)=\phi_{\mathrm{cartesian}}(A)\cdot\phi_{\mathrm{cartesian}}(B)`,
          ),
          "（モノイド準同型）",
        ],
        [math(String.raw`\phi_{\mathrm{cartesian}}`), " は全単射。"],
      ]),
    ],
    proof: [
      paragraph([
        "モノイド準同型性。",
        math(String.raw`[(r,\theta)]_{\sim}, [(r',\theta')]_{\sim} \in (\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\bigl([(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim}\bigr)
&= \phi_{\mathrm{cartesian}}\bigl([(rr',\theta+\theta')]_{\sim}\bigr)
&&(\because\ \blkref{operations_on_polar_representation})\\
&= \bigl(rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta')\bigr)
&&(\because\ \blkref{def_phi_cartesian})\\
&= \bigl(rr'(\cos\theta\cos\theta'-\sin\theta\sin\theta'),\ rr'(\cos\theta\sin\theta'+\sin\theta\cos\theta')\bigr)
&&(\because\ \text{三角関数の加法定理})\\
&= \bigl(rr'\cos\theta\cos\theta'-rr'\sin\theta\sin\theta',\ rr'\cos\theta\sin\theta'+rr'\sin\theta\cos\theta'\bigr)
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= \bigl((r\cos\theta)(r'\cos\theta')-(r\sin\theta)(r'\sin\theta'),\ (r\cos\theta)(r'\sin\theta')+(r\sin\theta)(r'\cos\theta')\bigr)
&&(\because\ \mathbb{R}\ \text{の積の可換律と結合律})\\
&= (r\cos\theta,\ r\sin\theta)\cdot(r'\cos\theta',\ r'\sin\theta')
&&(\because\ \blkref{definition_of_cc}\ \text{の積})\\
&= \phi_{\mathrm{cartesian}}\bigl([(r,\theta)]_{\sim}\bigr)\cdot\phi_{\mathrm{cartesian}}\bigl([(r',\theta')]_{\sim}\bigr)
&&(\because\ \blkref{def_phi_cartesian})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph([
        "全単射性。",
        ref("phi_cartesian_after_phi_polar_is_identity"),
        " により ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " であるから、",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全射である。単射性の導出は原文に無く、この証明は未完である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の part 2 は phi_cartesian ∘ phi_polar = id_CC を示すところまでで、全単射（特に単射性）の明示的な導出は原文にない。ここでは原文の計算を全ステップ忠実に再現した。",
        "2026-11-01、合成が恒等写像であることの場合分けの計算を phi_cartesian_after_phi_polar_is_identity へ切り出し、全単射性の段落はそれを引く形にした。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: 式変形の後に置いていた、引いたブロックを挙げる段落を削り、その行の (∵ …) で名前だけで書いていた根拠を \\blkref{<ラベル>} に替えた（docs/context/証明の書き方.md の「根拠は式変形の各行から引く。証明の末尾に参照の一覧を置かない」）。式・鎖の両端・段数は不変。",
      ],
    },
  },
  {
    id: "calculation_formulae_030_definition_first_and_second_projections",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/029_definition_第1座標と第2座標_pr1_pr2.typ", ordinal: 30 },
    title: {
      text: "第1座標, 第2座標",
    },
    labels: ["first_and_second_projections"],
    statement: [
      paragraph([ref("polar_equivalence_class"), " の同値類から、半径と ", ref("angle_equivalence_class"), " による角度の同値類を取り出す。"]),
      paragraph([math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})`), " について、"]),
      displayMath(
        String.raw`\operatorname{pr}_1 : (\text{極座標表現})\to\mathbb{R}_{\ge 0},\quad
[(r,\theta)]_{\sim}\mapsto r`,
      ),
      displayMath(
        String.raw`\operatorname{pr}_2 : (\text{極座標表現})\to(\text{角度表現}),\quad
[(r,\theta)]_{\sim}\mapsto
\begin{cases}
[0]_{\sim_{\mathrm{angle}}} & (r=0),\\
[\theta]_{\sim_{\mathrm{angle}}} & (r\ne 0).
\end{cases}`,
      ),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_claim_angle_section_integer_of_zero_is_zero",
    kind: "claim",
    title: { text: "角度 0 に対する切断の整数は 0" },
    labels: ["angle_section_integer_of_zero_is_zero"],
    statement: [
      paragraph([
        ref("angle_section_existence_uniqueness"),
        " を ",
        math(String.raw`\theta \to 0`),
        " に当てて得られる、",
        math(String.raw`0 \leq 0 - 2n\pi < 2\pi`),
        " を満たすただ一つの ",
        math(String.raw`n \in \mathbb{Z}`),
        " は ",
        math(String.raw`n = 0`),
        " である。ここで和・積・順序は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、差は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う値を先に置く。",
        ref("pi_is_positive"),
        " の ",
        math(String.raw`0<\pi`),
        " と ",
        math(String.raw`0<2`),
        " から、",
        math(String.raw`\mathbb{R}`),
        " で正の数どうしの積は正（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）なので ",
        math(String.raw`0<2\pi`),
        " である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
0-2\cdot 0\cdot\pi
&= 0-0\cdot\pi
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x\to 2)\bigr)\\
&= 0-0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x\to\pi)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to 0)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0\leq 0`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序の反射律。",
        ref("set_and_algebra_notation"),
        "）と ",
        math(String.raw`0<2\pi`),
        " にこの値を当てると ",
        math(String.raw`0\leq 0-2\cdot 0\cdot\pi<2\pi`),
        " であり、",
        math(String.raw`n=0`),
        " は条件を満たす。",
        ref("angle_section_existence_uniqueness"),
        " の一意性より、",
        math(String.raw`\theta \to 0`),
        " について条件を満たす整数は ",
        math(String.raw`0`),
        " だけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。同じ準備（0 − 2·0·π = 0 の 3 行の鎖と 0 < 2π の地の文から θ → 0 の整数を 0 と定めること）が range_of_args_of_square_of_complex_numbers・sqrt_expansion_via_polar・inverse_of_sqrt_cc の 3 ブロックに重複していたので、1 つの主張にまとめた。Lean の具体版は無い（Lean は角度表現の切断 s_{[0,2π)} を形式化していない）。数値検証: sagemath/check/angle_section_integer_of_zero_is_zero/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_angle_section_of_zero_is_zero",
    kind: "claim",
    title: { text: "角度表現の切断は 0 の同値類を 0 へ送る" },
    labels: ["angle_section_of_zero_is_zero"],
    statement: [
      paragraph([
        ref("section_of_angle_representation"),
        " の切断 ",
        math(String.raw`s_{[0,2\pi)}`),
        " について",
      ]),
      displayMath(String.raw`s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right) = 0`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`[0]_{\sim_{\mathrm{angle}}}`),
        " は ",
        ref("angle_equivalence_class"),
        " の同値類、右辺の ",
        math(String.raw`0`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " の ",
        math(String.raw`0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う記号を先に置く。",
        math(String.raw`n_0 \in \mathbb{Z}`),
        " を、",
        ref("angle_section_existence_uniqueness"),
        " を ",
        math(String.raw`\theta \to 0`),
        " に当てて得られる ",
        math(String.raw`0 \leq 0 - 2n_0\pi < 2\pi`),
        " を満たすただ一つの整数とする。",
      ]),
      displayMath(String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)
&= 0-2n_0\pi
&&\bigl(\because\ \blkref{section_of_angle_representation}\ (\theta \to 0,\ n \to n_0)\bigr)\\
&= 0-2\cdot 0\cdot\pi
&&\bigl(\because\ \blkref{angle_section_integer_of_zero_is_zero}\ \text{の}\ n_0 = 0\bigr)\\
&= 0-0\cdot\pi
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x\to 2)\bigr)\\
&= 0-0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x\to\pi)\bigr)\\
&= 0
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to 0)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。range_of_args_of_square_of_complex_numbers・sqrt_expansion_via_polar の r = 0 の場合と condition_of_commutativity_of_sqrt_and_product の r_1 = 0 の場合が s_{[0,2π)}([0]) = 0 をそれぞれの準備から（condition_of_commutativity_of_sqrt_and_product は「角度切断の一意性を θ = 0, n = 0 へ当てた」の名前だけで）出していたので、1 つの主張にした。Lean の具体版は無い（Lean は角度表現の切断 s_{[0,2π)} を形式化していない）。数値検証: sagemath/check/angle_section_of_zero_is_zero/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_angle_section_integer_of_pi_is_zero",
    kind: "claim",
    title: { text: "角度 π に対する切断の整数は 0" },
    labels: ["angle_section_integer_of_pi_is_zero"],
    statement: [
      paragraph([
        ref("angle_section_existence_uniqueness"),
        " を ",
        math(String.raw`\theta \to \pi`),
        " に当てて得られる、",
        math(String.raw`0 \leq \pi - 2n\pi < 2\pi`),
        " を満たすただ一つの ",
        math(String.raw`n \in \mathbb{Z}`),
        " は ",
        math(String.raw`n = 0`),
        " である。ここで和・積・順序は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、差は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う値を先に置く。",
        ref("pi_is_positive"),
        " の ",
        math(String.raw`0<\pi`),
        " から、",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi
&= 0+\pi
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to \pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を右辺から左辺へ}\bigr)\\
&< \pi+\pi
&&\bigl(\because\ 0<\pi\ \text{の両辺に}\ \pi\ \text{を足す。}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\bigr)\\
&= 1\cdot\pi+1\cdot\pi
&&\bigl(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の乗法の単位元}\ 1\cdot x = x\ (x \to \pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\text{を 2 箇所へ、右辺から左辺へ}\bigr)\\
&= (1+1)\,\pi
&&\bigl(\because\ \mathbb{R}\ \text{の分配律（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= 2\pi
&&\bigl(\because\ \blkref{def_real_two}\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph([
        "である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
\pi-2\cdot 0\cdot\pi
&= \pi-0\cdot\pi
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x\to 2)\bigr)\\
&= \pi-0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x\to\pi)\bigr)\\
&= \pi
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to \pi)\bigr)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`0<\pi`),
        " から ",
        math(String.raw`0\leq\pi`),
        "（",
        math(String.raw`\mathbb{R}`),
        " の順序。",
        ref("set_and_algebra_notation"),
        "）である。",
        math(String.raw`0\leq\pi`),
        " と上の ",
        math(String.raw`\pi<2\pi`),
        " に、上の値 ",
        math(String.raw`\pi-2\cdot 0\cdot\pi=\pi`),
        " を当てると ",
        math(String.raw`0\leq \pi-2\cdot 0\cdot\pi<2\pi`),
        " であり、",
        math(String.raw`n=0`),
        " は条件を満たす。",
        ref("angle_section_existence_uniqueness"),
        " の一意性より、",
        math(String.raw`\theta \to \pi`),
        " について条件を満たす整数は ",
        math(String.raw`0`),
        " だけである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-15（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。relation_of_gamma_2_theta_tilde の準備の地の文が、0 < π だけを根拠に角度 0 と π の整数がどちらも 0 であるとしていた（π < 2π と π − 2·0·π = π が書かれていなかった）ので、角度 π の側を 1 つの主張にした（角度 0 の側は angle_section_integer_of_zero_is_zero）。Lean の具体版は無い（Lean は角度表現の切断 s_{[0,2π)} を形式化していない）。数値検証: sagemath/check/angle_section_integer_of_pi_is_zero/。",
        "2026-11-15（Lean の通しの証明のゴールラインの確認、状態台帳の (d4c44p15f15p51d)。「ℝ で 1 + 1 = 2」の名前だけの根拠の件）: 準備の π < 2π の鎖の最後の行 (1+1)π = 2π の根拠「ℝ で 1 + 1 = 2」は名前だけだったので、def_real_two を右辺から左辺へ当てる参照に替えた（式の両端と主張は不変）。",
        "2026-11-17（Lean の通しの証明のゴールラインの確認）: ℝ の単位元を set_and_algebra_notation で引く行に、使った形と代入が書かれていない、または形が参照の後ろに置かれていたので、multiplicative_group_of_cc・monoid_of_polar_representation の同じ行と同じ「0（1）は ℝ の加法（乗法）の単位元 形 (代入)（参照）」の並びにした: π = 0 + π（0 + x = x の x → π を右辺から左辺へ）と π + π = 1·π + 1·π（1·x = x の x → π を 2 箇所へ、右辺から左辺へ）。式・鎖の両端・段数は不変。SageMath の検算 check_unit_rows_cite_set_and_algebra_notation.sage を足した。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_real_section_minus_half_pi_in_principal_interval",
    kind: "claim",
    title: { tex: String.raw`0 \leq x \leq \pi \text{ なら } x - \pi/2 \in [-\pi/2,\pi/2]` },
    labels: ["real_section_minus_half_pi_in_principal_interval"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " が ",
        math(String.raw`0 \leq x \leq \pi`),
        " を満たすとする。和・",
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`\leq`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、差と加法の逆元 ",
        math(String.raw`-z`),
        " は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi/2 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "。",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "）、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率であり、",
        math(String.raw`-\pi/2`),
        " は ",
        math(String.raw`-(\pi/2)`),
        " を表す。このとき",
      ]),
      displayMath(String.raw`-\pi/2 \leq x - \pi/2 \leq \pi/2`),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`x - \pi/2`),
        " は ",
        ref("def_sin"),
        " の定義域 ",
        math(String.raw`[-\pi/2,\pi/2]`),
        " に入る。",
      ]),
    ],
    proof: [
      paragraph(["左側の不等号を示す。"]),
      displayMath(String.raw`\begin{aligned}
-\pi/2
&= 0 + (-\pi/2)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\leq x + (-\pi/2)
&&\bigl(\because\ \text{仮定の}\ 0 \leq x\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a \leq b \Rightarrow a + c \leq b + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to 0,\ b \to x,\ c \to -\pi/2\bigr)\\
&= x - \pi/2
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to x,\ z \to \pi/2)\ \text{を右辺から左辺へ}\bigr)
\end{aligned}`),
      paragraph(["右側の不等号を示す。"]),
      displayMath(String.raw`\begin{aligned}
x - \pi/2
&= x + (-\pi/2)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to x,\ z \to \pi/2)\bigr)\\
&\leq \pi + (-\pi/2)
&&\bigl(\because\ \text{仮定の}\ x \leq \pi\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a \leq b \Rightarrow a + c \leq b + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to x,\ b \to \pi,\ c \to -\pi/2\bigr)\\
&= (\pi/2 + \pi/2) + (-\pi/2)
&&\bigl(\because\ \blkref{real_half_plus_half_is_original}\ (b \to \pi)\ \text{を右辺から左辺へ}\bigr)\\
&= \pi/2 + \bigl(\pi/2 + (-\pi/2)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x, y \to \pi/2,\ t \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \pi/2 + 0
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \pi/2
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_sin_on_all_reals・def_cos_on_all_reals の一つ目の場合の引数が def_sin・def_cos の定義域に入ることを示すために足した。Lean の具体版はまだ無い。証明は π の性質を使わない（0 < π も使わない）ので、π を実数の変数に置いた形で人手と 1 対 1 の具体版を置ける。状態台帳の同じ件の次の一歩とした。数値検証: sagemath/check/real_section_minus_half_pi_in_principal_interval/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_reflected_real_section_in_principal_interval",
    kind: "claim",
    title: { tex: String.raw`\pi < x < 2\pi \text{ なら } (\pi + \pi/2) - x \in [-\pi/2,\pi/2]` },
    labels: ["reflected_real_section_in_principal_interval"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " が ",
        math(String.raw`\pi < x < 2\pi`),
        " を満たすとする。和・積・",
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`\leq`),
        "・",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`a < b`),
        " は ",
        math(String.raw`a \leq b`),
        " かつ ",
        math(String.raw`a \neq b`),
        " のこと）、差と加法の逆元 ",
        math(String.raw`-z`),
        " は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\pi/2 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "）、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率であり、",
        math(String.raw`-\pi/2`),
        " は ",
        math(String.raw`-(\pi/2)`),
        " を表す。このとき",
      ]),
      displayMath(String.raw`-\pi/2 \leq (\pi + \pi/2) - x \leq \pi/2`),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`(\pi + \pi/2) - x`),
        " は ",
        ref("def_sin"),
        " の定義域 ",
        math(String.raw`[-\pi/2,\pi/2]`),
        " に入る。",
      ]),
    ],
    proof: [
      paragraph([
        "準備の第一。仮定の ",
        math(String.raw`\pi < x`),
        " と ",
        math(String.raw`x < 2\pi`),
        " に ",
        math(String.raw`\mathbb{R}`),
        " の順序と符号反転 ",
        math(String.raw`a < b \Rightarrow -b < -a`),
        "（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）を ",
        math(String.raw`a \to \pi,\ b \to x`),
        " と ",
        math(String.raw`a \to x,\ b \to 2\pi`),
        " で当てて、",
      ]),
      displayMath(String.raw`-x < -\pi,\qquad -(2\pi) < -x`),
      paragraph(["である。準備の第二。"]),
      displayMath(String.raw`\begin{aligned}
(\pi + \pi/2) + (-\pi)
&= (\pi/2 + \pi) + (-\pi)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の交換律}\ x + y = y + x\ (x \to \pi,\ y \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \pi/2 + \bigl(\pi + (-\pi)\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \pi/2,\ y \to \pi,\ t \to -\pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \pi/2 + 0
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \pi/2
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph(["右側の不等号を示す。"]),
      displayMath(String.raw`\begin{aligned}
(\pi + \pi/2) - x
&= (\pi + \pi/2) + (-x)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \pi + \pi/2,\ z \to x)\bigr)\\
&< (\pi + \pi/2) + (-\pi)
&&\bigl(\because\ \text{準備の第一の}\ -x < -\pi\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a < b \Rightarrow c + a < c + b\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to -x,\ b \to -\pi,\ c \to \pi + \pi/2\bigr)\\
&= \pi/2
&&\bigl(\because\ \text{準備の第二}\bigr)
\end{aligned}`),
      paragraph(["左側の不等号を示す。"]),
      displayMath(String.raw`\begin{aligned}
(\pi + \pi/2) - x
&= (\pi + \pi/2) + (-x)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \pi + \pi/2,\ z \to x)\bigr)\\
&> (\pi + \pi/2) + \bigl(-(2\pi)\bigr)
&&\bigl(\because\ \text{準備の第一の}\ -(2\pi) < -x\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a < b \Rightarrow c + a < c + b\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to -(2\pi),\ b \to -x,\ c \to \pi + \pi/2\bigr)\\
&= (\pi + \pi/2) + \bigl(-(\pi + \pi)\bigr)
&&\bigl(\because\ \blkref{real_sum_of_two_equal_terms_is_twice}\ (a \to \pi)\ \text{を右辺から左辺へ}\bigr)\\
&= (\pi + \pi/2) + \bigl((-\pi) + (-\pi)\bigr)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ (x, y \to \pi)\bigr)\\
&= \bigl((\pi + \pi/2) + (-\pi)\bigr) + (-\pi)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \pi + \pi/2,\ y, t \to -\pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= \pi/2 + (-\pi)
&&\bigl(\because\ \text{準備の第二}\bigr)\\
&= \pi/2 + \bigl(-(\pi/2 + \pi/2)\bigr)
&&\bigl(\because\ \blkref{real_half_plus_half_is_original}\ (b \to \pi)\ \text{を右辺から左辺へ}\bigr)\\
&= \pi/2 + \bigl((-\pi/2) + (-\pi/2)\bigr)
&&\bigl(\because\ \blkref{real_negation_of_sum_is_sum_of_negations}\ (x, y \to \pi/2)\bigr)\\
&= \bigl(\pi/2 + (-\pi/2)\bigr) + (-\pi/2)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \pi/2,\ y, t \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&= 0 + (-\pi/2)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= -\pi/2
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
      paragraph([
        "狭義の不等号 ",
        math(String.raw`(\pi + \pi/2) - x < \pi/2`),
        "・",
        math(String.raw`-\pi/2 < (\pi + \pi/2) - x`),
        " は、",
        math(String.raw`<`),
        " の意味（",
        math(String.raw`a < b`),
        " は ",
        math(String.raw`a \leq b`),
        " かつ ",
        math(String.raw`a \neq b`),
        "）より、それぞれ等号を含む不等号 ",
        math(String.raw`\leq`),
        " を含意する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_sin_on_all_reals・def_cos_on_all_reals の二つ目の場合の引数が def_sin・def_cos の定義域に入ることを示すために足した。Lean の具体版はまだ無い。証明は π の性質を使わない（0 < π も使わない）ので、π を実数の変数に置いた形で人手と 1 対 1 の具体版を置ける。状態台帳の同じ件の次の一歩とした。数値検証: sagemath/check/reflected_real_section_in_principal_interval/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_principal_angle_plus_half_pi_at_most_pi",
    kind: "claim",
    title: { tex: String.raw`\theta \leq \pi/2 \text{ なら } \theta + \pi/2 \leq \pi` },
    labels: ["principal_angle_plus_half_pi_at_most_pi"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " が ",
        math(String.raw`\theta \leq \pi/2`),
        " を満たすとする。和・順序 ",
        math(String.raw`\leq`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、",
        math(String.raw`\pi/2 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "。",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "）、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率である。このとき",
      ]),
      displayMath(String.raw`\theta + \pi/2 \leq \pi`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\theta + \pi/2
&\leq \pi/2 + \pi/2
&&\bigl(\because\ \text{仮定の}\ \theta \leq \pi/2\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a \leq b \Rightarrow a + c \leq b + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to \theta,\ b \to \pi/2,\ c \to \pi/2\bigr)\\
&= \pi
&&\bigl(\because\ \blkref{real_half_plus_half_is_original}\ (b \to \pi)\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。angle_section_of_principal_angle_plus_half_pi・sin_on_all_reals_agrees_on_principal_interval・cos_on_all_reals_agrees_on_principal_interval が同じ θ + π/2 ≤ π の鎖を持たないよう、1 つの主張にした。Lean の具体版はまだ無い。証明は π の性質を使わないので、π を実数の変数に置いた形で人手と 1 対 1 の具体版を置ける。状態台帳の同じ件の次の一歩とした。数値検証: sagemath/check/principal_angle_plus_half_pi_at_most_pi/。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_angle_section_of_theta_plus_half_pi",
    kind: "definition",
    title: { tex: String.raw`\xi_\theta := s_{[0,2\pi)}([\theta + \pi/2])` },
    labels: ["def_angle_section_of_theta_plus_half_pi"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("section_of_angle_representation"),
        " の切断 ",
        math(String.raw`s_{[0,2\pi)}`),
        " と ",
        ref("angle_equivalence_class"),
        " の同値類を使って",
      ]),
      displayMath(String.raw`\xi_\theta := s_{[0,2\pi)}\!\left([\theta + \pi/2]_{\sim_{\mathrm{angle}}}\right) \in \mathbb{R}`),
      paragraph([
        "と定める。ここで和・積・順序 ",
        math(String.raw`\leq`),
        "・",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの、差は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi/2 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "）、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率である。",
        ref("angle_section_existence_uniqueness"),
        "（",
        math(String.raw`\theta \to \theta + \pi/2`),
        "）の整数を ",
        math(String.raw`n`),
        " とすると、",
        ref("section_of_angle_representation"),
        " より ",
        math(String.raw`\xi_\theta = (\theta + \pi/2) - 2n\pi`),
        " であり、",
        math(String.raw`n`),
        " の条件より ",
        math(String.raw`0 \leq \xi_\theta < 2\pi`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_sin_on_all_reals・def_cos_on_all_reals が場合分けに使う量を、1 ブロック 1 定義にするために独立させた。" +
          "θ + π/2 を [0, 2π) へ送ってから π/2 を引くと θ − 2nπ ∈ [−π/2, π + π/2) になり、その前半（ξ_θ ≤ π）はそのまま、後半（π < ξ_θ）は π − (θ − 2nπ) = (π + π/2) − ξ_θ へ折り返して、def_sin・def_cos の定義域 [−π/2, π/2] へ戻す。Lean の具体版は無い（Lean は本文の弧の長さによる sin・cos と角度表現の切断 s_{[0,2π)} を形式化していない。angle_section_of_zero_is_zero と同じ理由）。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_sin_on_all_reals",
    kind: "definition",
    title: { text: "全実数上の sin" },
    labels: ["def_sin_on_all_reals"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_angle_section_of_theta_plus_half_pi"),
        " の ",
        math(String.raw`\xi_\theta`),
        "（",
        math(String.raw`0 \leq \xi_\theta < 2\pi`),
        "）を使う。",
        math(String.raw`\mathbb{R}`),
        " の順序は全順序なので（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）、",
        math(String.raw`\xi_\theta \leq \pi`),
        " と ",
        math(String.raw`\pi < \xi_\theta`),
        "（",
        math(String.raw`<`),
        " は ",
        math(String.raw`\leq`),
        " かつ ",
        math(String.raw`\neq`),
        " のこと）の少なくとも一方が成り立ち、両方が成り立てば順序の反対称律より ",
        math(String.raw`\xi_\theta = \pi`),
        " となって ",
        math(String.raw`\pi < \xi_\theta`),
        " の ",
        math(String.raw`\neq`),
        " に反するので、ちょうど一方が成り立つ。",
        math(String.raw`\sin_{\mathbb{R}} : \mathbb{R} \to \mathbb{R}`),
        " を次で定める。",
      ]),
      list([
        [
          paragraph([
            math(String.raw`\xi_\theta \leq \pi`),
            " のとき、",
            ref("real_section_minus_half_pi_in_principal_interval"),
            "（",
            math(String.raw`x \to \xi_\theta`),
            "。",
            math(String.raw`0 \leq \xi_\theta`),
            "）より ",
            math(String.raw`\xi_\theta - \pi/2 \in [-\pi/2,\pi/2]`),
            " なので、",
          ]),
          displayMath(String.raw`\sin_{\mathbb{R}}(\theta) := \sin(\xi_\theta - \pi/2)`),
          paragraph(["と定める。"]),
        ],
        [
          paragraph([
            math(String.raw`\pi < \xi_\theta`),
            " のとき、",
            ref("reflected_real_section_in_principal_interval"),
            "（",
            math(String.raw`x \to \xi_\theta`),
            "。",
            math(String.raw`\xi_\theta < 2\pi`),
            "）より ",
            math(String.raw`(\pi + \pi/2) - \xi_\theta \in [-\pi/2,\pi/2]`),
            " なので、",
          ]),
          displayMath(String.raw`\sin_{\mathbb{R}}(\theta) := \sin\bigl((\pi + \pi/2) - \xi_\theta\bigr)`),
          paragraph(["と定める。"]),
        ],
      ]),
      paragraph([
        "右辺の ",
        math(String.raw`\sin`),
        " は ",
        ref("def_sin"),
        " の ",
        math(String.raw`[-\pi/2,\pi/2]`),
        " 上の関数、差は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi/2`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "）である。",
        math(String.raw`\sin_{\mathbb{R}}`),
        " を全実数上の正弦と呼ぶ（",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\pi`),
        " と ",
        ref("def_sin"),
        " の値が弧の長さで定まる実数だからである）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_sin は [−π/2, π/2] の上だけの関数で、euler_formula_cos_sin・def_phi_cartesian・def_gamma1_gamma2_of_theta ほかが全実数の引数の sin を定義なしに使っていたので、主値区間の値と角度表現の切断から全実数上の関数を定めた。主値区間の上で def_sin と一致することは sin_on_all_reals_agrees_on_principal_interval で示す。2π 周期性・奇関数であること・特殊値・Euler の公式との関係は別の主張で扱う（まだ無い）。Lean の具体版は無い（Lean は本文の弧の長さによる sin・cos と角度表現の切断 s_{[0,2π)} を形式化していない。angle_section_of_zero_is_zero と同じ理由）。",
      ],
    },
  },
  {
    id: "calculation_formulae_definition_cos_on_all_reals",
    kind: "definition",
    title: { text: "全実数上の cos" },
    labels: ["def_cos_on_all_reals"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_angle_section_of_theta_plus_half_pi"),
        " の ",
        math(String.raw`\xi_\theta`),
        "（",
        math(String.raw`0 \leq \xi_\theta < 2\pi`),
        "）を使う。",
        math(String.raw`\mathbb{R}`),
        " の順序は全順序なので（",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）、",
        math(String.raw`\xi_\theta \leq \pi`),
        " と ",
        math(String.raw`\pi < \xi_\theta`),
        "（",
        math(String.raw`<`),
        " は ",
        math(String.raw`\leq`),
        " かつ ",
        math(String.raw`\neq`),
        " のこと）の少なくとも一方が成り立ち、両方が成り立てば順序の反対称律より ",
        math(String.raw`\xi_\theta = \pi`),
        " となって ",
        math(String.raw`\pi < \xi_\theta`),
        " の ",
        math(String.raw`\neq`),
        " に反するので、ちょうど一方が成り立つ。",
        math(String.raw`\cos_{\mathbb{R}} : \mathbb{R} \to \mathbb{R}`),
        " を次で定める。",
      ]),
      list([
        [
          paragraph([
            math(String.raw`\xi_\theta \leq \pi`),
            " のとき、",
            ref("real_section_minus_half_pi_in_principal_interval"),
            "（",
            math(String.raw`x \to \xi_\theta`),
            "。",
            math(String.raw`0 \leq \xi_\theta`),
            "）より ",
            math(String.raw`\xi_\theta - \pi/2 \in [-\pi/2,\pi/2]`),
            " なので、",
          ]),
          displayMath(String.raw`\cos_{\mathbb{R}}(\theta) := \cos(\xi_\theta - \pi/2)`),
          paragraph(["と定める。"]),
        ],
        [
          paragraph([
            math(String.raw`\pi < \xi_\theta`),
            " のとき、",
            ref("reflected_real_section_in_principal_interval"),
            "（",
            math(String.raw`x \to \xi_\theta`),
            "。",
            math(String.raw`\xi_\theta < 2\pi`),
            "）より ",
            math(String.raw`(\pi + \pi/2) - \xi_\theta \in [-\pi/2,\pi/2]`),
            " なので、",
          ]),
          displayMath(String.raw`\cos_{\mathbb{R}}(\theta) := -\cos\bigl((\pi + \pi/2) - \xi_\theta\bigr)`),
          paragraph(["と定める。"]),
        ],
      ]),
      paragraph([
        "右辺の ",
        math(String.raw`\cos`),
        " は ",
        ref("def_cos"),
        " の ",
        math(String.raw`[-\pi/2,\pi/2]`),
        " 上の関数、差と ",
        math(String.raw`-\cos(\cdot)`),
        " の加法の逆元は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`\pi/2`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "）である。",
        math(String.raw`\cos_{\mathbb{R}}`),
        " を全実数上の余弦と呼ぶ（",
        math(String.raw`\mathbb{R}`),
        " を使うのは、",
        math(String.raw`\pi`),
        " と ",
        ref("def_cos"),
        " の値が弧の長さで定まる実数だからである）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_cos は [−π/2, π/2] の上だけの関数で、euler_formula_cos_sin・def_gamma1_gamma2_of_theta・gamma1_lower_bound_all_theta ほかが全実数の引数の cos を定義なしに使っていたので、主値区間の値と角度表現の切断から全実数上の関数を定めた。二つ目の場合の符号は cos(π − t) = −cos t に合わせた。主値区間の上で def_cos と一致することは cos_on_all_reals_agrees_on_principal_interval で示す。2π 周期性・偶関数であること・特殊値・Euler の公式との関係は別の主張で扱う（まだ無い）。Lean の具体版は無い（Lean は本文の弧の長さによる sin・cos と角度表現の切断 s_{[0,2π)} を形式化していない。angle_section_of_zero_is_zero と同じ理由）。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_angle_section_of_principal_angle_plus_half_pi",
    kind: "claim",
    title: { tex: String.raw`\theta \in [-\pi/2,\pi/2] \text{ なら } s_{[0,2\pi)}([\theta + \pi/2]) = \theta + \pi/2` },
    labels: ["angle_section_of_principal_angle_plus_half_pi"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " が ",
        math(String.raw`-\pi/2 \leq \theta \leq \pi/2`),
        " を満たすとする。和・積・",
        math(String.raw`0`),
        "・順序 ",
        math(String.raw`\leq`),
        "・",
        math(String.raw`<`),
        " は ",
        ref("set_and_algebra_notation"),
        " の順序体 ",
        math(String.raw`\mathbb{R}`),
        " のもの（",
        math(String.raw`a < b`),
        " は ",
        math(String.raw`a \leq b`),
        " かつ ",
        math(String.raw`a \neq b`),
        " のこと）、差と加法の逆元 ",
        math(String.raw`-z`),
        " は ",
        ref("def_real_difference"),
        " のもの、",
        math(String.raw`2`),
        " は ",
        ref("def_real_two"),
        " の ",
        math(String.raw`2 = 1 + 1 \in \mathbb{R}`),
        "、",
        math(String.raw`\pi/2 \in \mathbb{R}`),
        " は ",
        ref("def_real_quotient"),
        " の商（",
        math(String.raw`y \to \pi,\ z \to 2`),
        "）、",
        math(String.raw`\pi \in \mathbb{R}`),
        " は ",
        ref("pi_is_positive"),
        " の円周率であり、",
        math(String.raw`-\pi/2`),
        " は ",
        math(String.raw`-(\pi/2)`),
        " を表す。このとき ",
        ref("section_of_angle_representation"),
        " の切断 ",
        math(String.raw`s_{[0,2\pi)}`),
        " について",
      ]),
      displayMath(String.raw`s_{[0,2\pi)}\!\left([\theta + \pi/2]_{\sim_{\mathrm{angle}}}\right) = \theta + \pi/2`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["準備の第一。"]),
      displayMath(String.raw`\begin{aligned}
(\theta + \pi/2) - 2\cdot 0\cdot\pi
&= (\theta + \pi/2) - 0\cdot\pi
&&\bigl(\because\ \blkref{real_times_zero_is_zero}\ (x\to 2)\bigr)\\
&= (\theta + \pi/2) - 0
&&\bigl(\because\ \blkref{real_zero_times_is_zero}\ (x\to\pi)\bigr)\\
&= \theta + \pi/2
&&\bigl(\because\ \blkref{real_minus_zero_is_self}\ (a \to \theta + \pi/2)\bigr)
\end{aligned}`),
      paragraph(["準備の第二（", math(String.raw`0 \leq \theta + \pi/2`), "）。"]),
      displayMath(String.raw`\begin{aligned}
0
&= (-\pi/2) + \pi/2
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ (-x) + x = 0\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&\leq \theta + \pi/2
&&\bigl(\because\ \text{仮定の}\ -\pi/2 \leq \theta\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a \leq b \Rightarrow a + c \leq b + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to -\pi/2,\ b \to \theta,\ c \to \pi/2\bigr)
\end{aligned}`),
      paragraph(["準備の第三（", math(String.raw`\theta + \pi/2 < 2\pi`), "）。"]),
      displayMath(String.raw`\begin{aligned}
\theta + \pi/2
&\leq \pi
&&\bigl(\because\ \text{仮定の}\ \theta \leq \pi/2\ \text{と}\ \blkref{principal_angle_plus_half_pi_at_most_pi}\ (\theta \to \theta)\bigr)\\
&= 0 + \pi
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ 0 + x = x\ (x \to \pi)\ \text{（}\blkref{set_and_algebra_notation}\text{）を右辺から左辺へ}\bigr)\\
&< \pi + \pi
&&\bigl(\because\ \blkref{pi_is_positive}\ \text{の}\ 0 < \pi\ \text{と、}\mathbb{R}\ \text{の順序と加法の両立}\ a < b \Rightarrow a + c < b + c\ \text{（}\mathbb{R}\ \text{は順序体 }\blkref{set_and_algebra_notation}\text{）の}\ a \to 0,\ b \to \pi,\ c \to \pi\bigr)\\
&= 2\pi
&&\bigl(\because\ \blkref{real_sum_of_two_equal_terms_is_twice}\ (a \to \pi)\bigr)
\end{aligned}`),
      paragraph([
        "この鎖の両端から ",
        math(String.raw`\theta + \pi/2 < 2\pi`),
        " を得る（",
        math(String.raw`\mathbb{R}`),
        " の順序の推移律 ",
        math(String.raw`a \leq b,\ b < c \Rightarrow a < c`),
        "。",
        math(String.raw`\mathbb{R}`),
        " は順序体 ",
        ref("set_and_algebra_notation"),
        "）。準備の第二と第三に準備の第一の値を当てると ",
        math(String.raw`0 \leq (\theta + \pi/2) - 2\cdot 0\cdot\pi < 2\pi`),
        " であり、",
        math(String.raw`n = 0`),
        " は ",
        ref("angle_section_existence_uniqueness"),
        "（",
        math(String.raw`\theta \to \theta + \pi/2`),
        "）の条件を満たす。その一意性より、条件を満たす整数は ",
        math(String.raw`0`),
        " だけである。主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta + \pi/2]_{\sim_{\mathrm{angle}}}\right)
&= (\theta + \pi/2) - 2\cdot 0\cdot\pi
&&\bigl(\because\ \blkref{section_of_angle_representation}\ (\theta \to \theta + \pi/2,\ n \to 0)\bigr)\\
&= \theta + \pi/2
&&\bigl(\because\ \text{準備の第一}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_angle_section_of_theta_plus_half_pi の ξ_θ が主値区間の θ で θ + π/2 になることを、sin_on_all_reals_agrees_on_principal_interval・cos_on_all_reals_agrees_on_principal_interval の共通の準備として足した。Lean の具体版は無い（Lean は角度表現の切断 s_{[0,2π)} を形式化していない。angle_section_of_zero_is_zero と同じ理由）。数値検証: sagemath/check/angle_section_of_principal_angle_plus_half_pi/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_sin_on_all_reals_agrees_on_principal_interval",
    kind: "claim",
    title: { text: "全実数上の sin は主値区間で sin の定義と一致する" },
    labels: ["sin_on_all_reals_agrees_on_principal_interval"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " が ",
        math(String.raw`-\pi/2 \leq \theta \leq \pi/2`),
        " を満たすとする（記号の所属は ",
        ref("angle_section_of_principal_angle_plus_half_pi"),
        " と同じ）。このとき ",
        ref("def_sin_on_all_reals"),
        " の ",
        math(String.raw`\sin_{\mathbb{R}}`),
        " と ",
        ref("def_sin"),
        " の ",
        math(String.raw`\sin`),
        " について",
      ]),
      displayMath(String.raw`\sin_{\mathbb{R}}(\theta) = \sin(\theta)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["準備。"]),
      displayMath(String.raw`\begin{aligned}
\xi_\theta
&= s_{[0,2\pi)}\!\left([\theta + \pi/2]_{\sim_{\mathrm{angle}}}\right)
&&\bigl(\because\ \blkref{def_angle_section_of_theta_plus_half_pi}\bigr)\\
&= \theta + \pi/2
&&\bigl(\because\ \blkref{angle_section_of_principal_angle_plus_half_pi}\ (\theta \to \theta)\bigr)\\
&\leq \pi
&&\bigl(\because\ \text{仮定の}\ \theta \leq \pi/2\ \text{と}\ \blkref{principal_angle_plus_half_pi_at_most_pi}\ (\theta \to \theta)\bigr)
\end{aligned}`),
      paragraph([
        "より ",
        math(String.raw`\xi_\theta \leq \pi`),
        " であり、",
        ref("def_sin_on_all_reals"),
        " の一つ目の場合に当たる。主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sin_{\mathbb{R}}(\theta)
&= \sin(\xi_\theta - \pi/2)
&&\bigl(\because\ \blkref{def_sin_on_all_reals}\ \text{の一つ目の場合。準備の}\ \xi_\theta \leq \pi\bigr)\\
&= \sin\bigl((\theta + \pi/2) - \pi/2\bigr)
&&\bigl(\because\ \text{準備の}\ \xi_\theta = \theta + \pi/2\bigr)\\
&= \sin\bigl((\theta + \pi/2) + (-\pi/2)\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \theta + \pi/2,\ z \to \pi/2)\bigr)\\
&= \sin\bigl(\theta + (\pi/2 + (-\pi/2))\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \theta,\ y \to \pi/2,\ t \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \sin(\theta + 0)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \sin(\theta)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \theta)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_sin_on_all_reals の sin_ℝ が def_sin の拡張であることを示すために足した。Lean の具体版は無い（Lean は本文の弧の長さによる sin と角度表現の切断を形式化していない）。数値検証: sagemath/check/sin_on_all_reals_agrees_on_principal_interval/。",
      ],
    },
  },
  {
    id: "calculation_formulae_claim_cos_on_all_reals_agrees_on_principal_interval",
    kind: "claim",
    title: { text: "全実数上の cos は主値区間で cos の定義と一致する" },
    labels: ["cos_on_all_reals_agrees_on_principal_interval"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " が ",
        math(String.raw`-\pi/2 \leq \theta \leq \pi/2`),
        " を満たすとする（記号の所属は ",
        ref("angle_section_of_principal_angle_plus_half_pi"),
        " と同じ）。このとき ",
        ref("def_cos_on_all_reals"),
        " の ",
        math(String.raw`\cos_{\mathbb{R}}`),
        " と ",
        ref("def_cos"),
        " の ",
        math(String.raw`\cos`),
        " について",
      ]),
      displayMath(String.raw`\cos_{\mathbb{R}}(\theta) = \cos(\theta)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph(["準備。"]),
      displayMath(String.raw`\begin{aligned}
\xi_\theta
&= s_{[0,2\pi)}\!\left([\theta + \pi/2]_{\sim_{\mathrm{angle}}}\right)
&&\bigl(\because\ \blkref{def_angle_section_of_theta_plus_half_pi}\bigr)\\
&= \theta + \pi/2
&&\bigl(\because\ \blkref{angle_section_of_principal_angle_plus_half_pi}\ (\theta \to \theta)\bigr)\\
&\leq \pi
&&\bigl(\because\ \text{仮定の}\ \theta \leq \pi/2\ \text{と}\ \blkref{principal_angle_plus_half_pi_at_most_pi}\ (\theta \to \theta)\bigr)
\end{aligned}`),
      paragraph([
        "より ",
        math(String.raw`\xi_\theta \leq \pi`),
        " であり、",
        ref("def_cos_on_all_reals"),
        " の一つ目の場合に当たる。主張の左辺から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos_{\mathbb{R}}(\theta)
&= \cos(\xi_\theta - \pi/2)
&&\bigl(\because\ \blkref{def_cos_on_all_reals}\ \text{の一つ目の場合。準備の}\ \xi_\theta \leq \pi\bigr)\\
&= \cos\bigl((\theta + \pi/2) - \pi/2\bigr)
&&\bigl(\because\ \text{準備の}\ \xi_\theta = \theta + \pi/2\bigr)\\
&= \cos\bigl((\theta + \pi/2) + (-\pi/2)\bigr)
&&\bigl(\because\ \blkref{def_real_difference}\ (y \to \theta + \pi/2,\ z \to \pi/2)\bigr)\\
&= \cos\bigl(\theta + (\pi/2 + (-\pi/2))\bigr)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の結合律}\ (x + y) + t = x + (y + t)\ (x \to \theta,\ y \to \pi/2,\ t \to -\pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \cos(\theta + 0)
&&\bigl(\because\ \mathbb{R}\ \text{の加法の逆元}\ x + (-x) = 0\ (x \to \pi/2)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)\\
&= \cos(\theta)
&&\bigl(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の加法の単位元}\ x + 0 = x\ (x \to \theta)\ \text{（}\blkref{set_and_algebra_notation}\text{）}\bigr)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-21（Lean の通しの証明のゴールラインの確認、状態台帳の「本文が定義のブロック無しに使っている語の解消」の全実数上の sin・cos の件）: 原文（Typst）に対応ブロックは無い。def_cos_on_all_reals の cos_ℝ が def_cos の拡張であることを示すために足した。Lean の具体版は無い（Lean は本文の弧の長さによる cos と角度表現の切断を形式化していない）。数値検証: sagemath/check/cos_on_all_reals_agrees_on_principal_interval/。",
      ],
    },
  },
]);
