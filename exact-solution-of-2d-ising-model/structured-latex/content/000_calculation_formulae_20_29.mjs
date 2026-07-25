import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 旧 calculation_formulae_021（極座標表現の同値類の性質の remark）は、定義から直ちに従う
// 読み手向けの補足であり出版本文には載らないため、
// notes/000_calculation_formulae.mjs（targets: polar_equivalence_class）へ移設した。
export default defineBlocks([
  {
    id: "calculation_formulae_022_definition_operations_on_polar_representation",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/021_definition_極座標表現の演算.typ",
    sourceOrdinal: 22,
    title: {
      text: "極座標表現の演算",
    },
    labels: ["operations_on_polar_representation"],
    statement: [
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
      paragraph(["この構造を「極座標表現」と呼ぶ。"]),
    ],
    conversion: {
      status: "converted",
    },
  },
  {
    id: "calculation_formulae_023_claim_multiplicative_group_of_polar_representation",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/022_claim_極座標表現の乗法群.typ",
    sourceOrdinal: 23,
    title: {
      text: "（極座標表現）の乗法群",
    },
    labels: [],
    statement: [
      paragraph(["（極座標表現）は二項演算 ", math(String.raw`\cdot`), " についてモノイドをなす。"]),
      displayMath(
        String.raw`(\text{極座標表現})^{\times} := (\text{極座標表現})\setminus\{[(0,0)]_{\sim}\}`,
      ),
      paragraph(["は二項演算 ", math(String.raw`\cdot`), " について群をなす。"]),
      paragraph([
        math(String.raw`[(r,\theta)]_{\sim}`),
        "（",
        math(String.raw`r\ne 0`),
        "）の逆元は",
      ]),
      displayMath(String.raw`\left([(r,\theta)]_{\sim}\right)^{-1}=[(1/r,-\theta)]_{\sim}`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("polar_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim`),
        "、",
        ref("angle_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim_{\mathrm{angle}}`),
        "、および ",
        ref("operations_on_polar_representation"),
        " の二項演算 ",
        math(String.raw`\cdot`),
        " を用いる。また ",
        math(String.raw`(\text{極座標表現}) = (\mathbb{R}_{\ge 0}\times\mathbb{R})/\sim`),
        " である。",
      ]),
      paragraph([
        "Step 0: 二項演算 ",
        math(String.raw`\cdot`),
        " が well-defined であること。",
      ]),
      paragraph([
        ref("operations_on_polar_representation"),
        " は同値類の代表元を用いて ",
        math(String.raw`[(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim}:=[(rr',\theta+\theta')]_{\sim}`),
        " と定めているので、右辺が代表元の取り方によらないことを確かめる必要がある。すなわち ",
        math(String.raw`(r,\theta),(r_1,\theta_1),(r',\theta'),(r_1',\theta_1')\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " が",
      ]),
      displayMath(String.raw`(r,\theta)\sim(r_1,\theta_1) \quad\text{かつ}\quad (r',\theta')\sim(r_1',\theta_1')`),
      paragraph([
        "を満たすとき ",
        math(String.raw`(rr',\theta+\theta')\sim(r_1r_1',\theta_1+\theta_1')`),
        " を示す。",
        ref("polar_equivalence_class"),
        " の定義",
      ]),
      displayMath(
        String.raw`(r,\theta)\sim(r',\theta')\overset{\mathrm{def}}{\Longleftrightarrow}
r=r'=0\ \lor\ \left(r=r'\land\theta\sim_{\mathrm{angle}}\theta'\right)`,
      ),
      paragraph(["に従って、次の 2 つの場合に分ける。"]),
      paragraph([
        "場合 (a): ",
        math(String.raw`r=r_1=0`),
        " または ",
        math(String.raw`r'=r_1'=0`),
        " のとき。",
      ]),
      displayMath(
        String.raw`rr' = 0 = r_1r_1'
\quad (\because \mathbb{R} \text{ では } 0 \text{ を因子にもつ積は } 0)`,
      ),
      paragraph([
        "であるから、",
        math(String.raw`(rr',\theta+\theta')`),
        " と ",
        math(String.raw`(r_1r_1',\theta_1+\theta_1')`),
        " は第 1 成分がともに ",
        math(String.raw`0`),
        " であり、",
        ref("polar_equivalence_class"),
        " の第 1 の選言により ",
        math(String.raw`(rr',\theta+\theta')\sim(r_1r_1',\theta_1+\theta_1')`),
        "。",
      ]),
      paragraph([
        "場合 (b): 場合 (a) でないとき。このとき ",
        math(String.raw`(r,\theta)\sim(r_1,\theta_1)`),
        " の定義における第 1 の選言 ",
        math(String.raw`r=r_1=0`),
        " は偽であるから第 2 の選言が成り立ち、",
        math(String.raw`r=r_1`),
        " かつ ",
        math(String.raw`\theta\sim_{\mathrm{angle}}\theta_1`),
        "。同様に ",
        math(String.raw`r'=r_1'`),
        " かつ ",
        math(String.raw`\theta'\sim_{\mathrm{angle}}\theta_1'`),
        "。",
      ]),
      paragraph([
        ref("angle_equivalence_class"),
        " より ",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " が存在して ",
        math(String.raw`\theta-\theta_1=2n\pi`),
        "、",
        math(String.raw`\theta'-\theta_1'=2n'\pi`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\theta+\theta')-(\theta_1+\theta_1')
&= (\theta-\theta_1)+(\theta'-\theta_1') \\
&= 2n\pi+2n'\pi \\
&= 2(n+n')\pi
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`n+n'\in\mathbb{Z}`),
        " であるから ",
        math(String.raw`\theta+\theta'\sim_{\mathrm{angle}}\theta_1+\theta_1'`),
        "（",
        ref("angle_equivalence_class"),
        "）。また ",
        math(String.raw`rr'=r_1r_1'`),
        " であるから、第 2 の選言により ",
        math(String.raw`(rr',\theta+\theta')\sim(r_1r_1',\theta_1+\theta_1')`),
        "。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\cdot`),
        " は well-defined である。",
      ]),
      paragraph(["Step 1: 結合律。"]),
      paragraph([
        math(String.raw`[(r_1,\theta_1)]_{\sim},[(r_2,\theta_2)]_{\sim},[(r_3,\theta_3)]_{\sim}\in(\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}\right)\cdot[(r_3,\theta_3)]_{\sim}
&= [(r_1r_2,\theta_1+\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim} \\
&= [((r_1r_2)r_3,\ (\theta_1+\theta_2)+\theta_3)]_{\sim} \\
&= [(r_1(r_2r_3),\ \theta_1+(\theta_2+\theta_3))]_{\sim}
\quad (\because \mathbb{R} \text{ の積と和の結合律}) \\
&= [(r_1,\theta_1)]_{\sim}\cdot[(r_2r_3,\theta_2+\theta_3)]_{\sim} \\
&= [(r_1,\theta_1)]_{\sim}\cdot\left([(r_2,\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim}\right)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`r_1,r_2,r_3\in\mathbb{R}_{\ge 0}`),
        " の積は ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " に属するので、各段の右辺は ",
        math(String.raw`(\text{極座標表現})`),
        " の元である。）",
      ]),
      paragraph([
        "Step 2: 単位元。",
        math(String.raw`e:=[(1,0)]_{\sim}\in(\text{極座標表現})`),
        " とおくと、",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})`),
        " に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot e
&= [(r\cdot 1,\ \theta+0)]_{\sim} \\
&= [(r,\theta)]_{\sim} \\
e\cdot[(r,\theta)]_{\sim}
&= [(1\cdot r,\ 0+\theta)]_{\sim} \\
&= [(r,\theta)]_{\sim}
\end{aligned}`,
      ),
      paragraph([
        "Step 3: Step 1 と Step 2 より、",
        math(String.raw`(\text{極座標表現})`),
        " は ",
        math(String.raw`\cdot`),
        " について単位元 ",
        math(String.raw`e=[(1,0)]_{\sim}`),
        " をもつ結合的な二項演算をもつ、すなわちモノイドをなす。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`[(r,\theta)]_{\sim}=[(0,0)]_{\sim}\iff r=0`),
        "。",
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
        " であるから第 1 の選言により ",
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
        " のとき、第 1 の選言が成り立つならば ",
        math(String.raw`r=0`),
        "、第 2 の選言が成り立つならば ",
        math(String.raw`r=0`),
        "（右辺の第 1 成分が ",
        math(String.raw`0`),
        " だから）。いずれの場合も ",
        math(String.raw`r=0`),
        "。",
      ]),
      paragraph([
        "Step 5: ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " は ",
        math(String.raw`\cdot`),
        " について閉じ、単位元を含む。",
      ]),
      paragraph([
        math(String.raw`[(r,\theta)]_{\sim},[(r',\theta')]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると、Step 4 より ",
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
        "。よって Step 4 より",
      ]),
      displayMath(
        String.raw`[(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim}
= [(rr',\theta+\theta')]_{\sim}
\ne [(0,0)]_{\sim}`,
      ),
      paragraph([
        "すなわち積は ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " に属する。また ",
        math(String.raw`1\ne 0`),
        " より Step 4 から ",
        math(String.raw`e=[(1,0)]_{\sim}\ne[(0,0)]_{\sim}`),
        " であり ",
        math(String.raw`e\in(\text{極座標表現})^{\times}`),
        "。",
      ]),
      paragraph([
        "Step 6: 逆元の存在。",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると Step 5 の議論より ",
        math(String.raw`r>0`),
        " であるから ",
        math(String.raw`1/r\in\mathbb{R}_{>0}\subset\mathbb{R}_{\ge 0}`),
        " が定まり ",
        math(String.raw`[(1/r,-\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        "（",
        math(String.raw`1/r\ne 0`),
        " と Step 4）。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot[(1/r,-\theta)]_{\sim}
&= [(r\cdot(1/r),\ \theta+(-\theta))]_{\sim} \\
&= [(1,0)]_{\sim} = e \\
[(1/r,-\theta)]_{\sim}\cdot[(r,\theta)]_{\sim}
&= [((1/r)\cdot r,\ (-\theta)+\theta)]_{\sim} \\
&= [(1,0)]_{\sim} = e
\end{aligned}`,
      ),
      paragraph([
        "Step 7: 逆元の一意性。単位元 ",
        math(String.raw`e`),
        " をもつ結合的な二項演算をもつ集合 ",
        math(String.raw`S`),
        " において、",
        math(String.raw`a\in S`),
        " に対し ",
        math(String.raw`b,b'\in S`),
        " がともに ",
        math(String.raw`ab=ba=e`),
        "、",
        math(String.raw`ab'=b'a=e`),
        " を満たすとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
b
&= b\,e \quad (\because e \text{ は単位元}) \\
&= b\,(a b') \quad (\because ab'=e) \\
&= (b a)\,b' \quad (\because \text{結合律}) \\
&= e\,b' \quad (\because ba=e) \\
&= b'
\end{aligned}`,
      ),
      paragraph([
        "であるから逆元は一意である。よって Step 6 の ",
        math(String.raw`[(1/r,-\theta)]_{\sim}`),
        " が ",
        math(String.raw`[(r,\theta)]_{\sim}`),
        " の唯一の逆元であり、",
      ]),
      displayMath(String.raw`\left([(r,\theta)]_{\sim}\right)^{-1}=[(1/r,-\theta)]_{\sim}`),
      paragraph([
        "Step 8: 結論。Step 5 より ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " は ",
        math(String.raw`\cdot`),
        " について閉じており、Step 1 より結合律を満たし、Step 2・Step 5 より単位元 ",
        math(String.raw`e`),
        " を含み、Step 6 より各元が逆元をもつ。したがって ",
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
          "本主張（モノイド・群であること）の前提として必要なので Step 0 で示した。",
      ],
    },
  },
  {
    id: "calculation_formulae_024_claim_multiplicative_group_of_complex_numbers",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/023_claim_CCの乗法群.typ",
    sourceOrdinal: 24,
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
      paragraph(["Step 1: 積の可換律。"]),
      displayMath(
        String.raw`\begin{aligned}
(c,d)\cdot(a,b)
&= (ca-db,\ cb+da) \\
&= (ac-bd,\ ad+bc)
\quad (\because \mathbb{R} \text{ の積の可換律と和の可換律}) \\
&= (a,b)\cdot(c,d)
\end{aligned}`,
      ),
      paragraph(["Step 2: 積の結合律。", math(String.raw`(e,f)\in\mathbb{C}`), " をとると、"]),
      displayMath(
        String.raw`\begin{aligned}
\left((a,b)\cdot(c,d)\right)\cdot(e,f)
&= (ac-bd,\ ad+bc)\cdot(e,f) \\
&= \left((ac-bd)e-(ad+bc)f,\ (ac-bd)f+(ad+bc)e\right) \\
&= \left(ace-bde-adf-bcf,\ acf-bdf+ade+bce\right)
\quad (\because \mathbb{R} \text{ の分配律}) \\
(a,b)\cdot\left((c,d)\cdot(e,f)\right)
&= (a,b)\cdot(ce-df,\ cf+de) \\
&= \left(a(ce-df)-b(cf+de),\ a(cf+de)+b(ce-df)\right) \\
&= \left(ace-adf-bcf-bde,\ acf+ade+bce-bdf\right)
\quad (\because \mathbb{R} \text{ の分配律})
\end{aligned}`,
      ),
      paragraph([
        "両者の第 1 成分・第 2 成分はそれぞれ ",
        math(String.raw`\mathbb{R}`),
        " の和の可換律・結合律により一致するので、積は結合的である。",
      ]),
      paragraph(["Step 3: 単位元。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)\cdot 1_{\mathbb{C}}
&= (a,b)\cdot(1,0) \\
&= (a\cdot 1-b\cdot 0,\ a\cdot 0+b\cdot 1) \\
&= (a,b)
\end{aligned}`,
      ),
      paragraph([
        "であり、Step 1 より ",
        math(String.raw`1_{\mathbb{C}}\cdot(a,b)=(a,b)`),
        "。よって ",
        math(String.raw`1_{\mathbb{C}}`),
        " は積の単位元である。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`z=(a,b)\in\mathbb{C}`),
        " について ",
        math(String.raw`z\ne(0,0)\iff a^2+b^2>0`),
        "。",
      ]),
      paragraph([
        math(String.raw`a^2\ge 0`),
        " かつ ",
        math(String.raw`b^2\ge 0`),
        " より ",
        math(String.raw`a^2+b^2\ge 0`),
        " である。",
        math(String.raw`a^2+b^2=0`),
        " とすると ",
        math(String.raw`a^2=-b^2\le 0`),
        " かつ ",
        math(String.raw`a^2\ge 0`),
        " より ",
        math(String.raw`a^2=0`),
        "、同様に ",
        math(String.raw`b^2=0`),
        "、よって ",
        math(String.raw`a=b=0`),
        "。逆に ",
        math(String.raw`a=b=0`),
        " なら ",
        math(String.raw`a^2+b^2=0`),
        "。ゆえに ",
        math(String.raw`a^2+b^2=0\iff z=(0,0)`),
        " であり、",
        math(String.raw`a^2+b^2\ge 0`),
        " と併せて ",
        math(String.raw`z\ne(0,0)\iff a^2+b^2>0`),
        "。",
      ]),
      paragraph([
        "Step 5: ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は積について閉じる。次の恒等式が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(ac-bd)^2+(ad+bc)^2
&= a^2c^2-2abcd+b^2d^2+a^2d^2+2abcd+b^2c^2 \\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2 \\
&= (a^2+b^2)(c^2+d^2)
\quad (\because \mathbb{R} \text{ の分配律})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`z=(a,b),w=(c,d)\in\mathbb{C}^{\times}`),
        " とすると Step 4 より ",
        math(String.raw`a^2+b^2>0`),
        " かつ ",
        math(String.raw`c^2+d^2>0`),
        " であるから ",
        math(String.raw`(a^2+b^2)(c^2+d^2)>0`),
        "。上の恒等式より ",
        math(String.raw`zw=(ac-bd,\ ad+bc)`),
        " の 2 つの成分の平方和は正であり、再び Step 4 より ",
        math(String.raw`zw\ne(0,0)`),
        "、すなわち ",
        math(String.raw`zw\in\mathbb{C}^{\times}`),
        "。また ",
        math(String.raw`1^2+0^2=1>0`),
        " より ",
        math(String.raw`1_{\mathbb{C}}\in\mathbb{C}^{\times}`),
        "。",
      ]),
      paragraph([
        "Step 6: 逆元の存在。",
        math(String.raw`z=(a,b)\in\mathbb{C}^{\times}`),
        " とすると Step 4 より ",
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
&= \left(a\cdot\frac{a}{a^2+b^2}-b\cdot\frac{-b}{a^2+b^2},\
   a\cdot\frac{-b}{a^2+b^2}+b\cdot\frac{a}{a^2+b^2}\right) \\
&= \left(\frac{a^2+b^2}{a^2+b^2},\ \frac{-ab+ab}{a^2+b^2}\right) \\
&= (1,0) = 1_{\mathbb{C}}
\end{aligned}`,
      ),
      paragraph([
        "Step 1 より ",
        math(String.raw`w\cdot z=z\cdot w=1_{\mathbb{C}}`),
        "。また Step 5 と同じ議論により ",
        math(String.raw`zw=1_{\mathbb{C}}\ne(0,0)`),
        " から ",
        math(String.raw`w\ne(0,0)`),
        " が従う（",
        math(String.raw`w=(0,0)`),
        " なら ",
        math(String.raw`zw=(0,0)`),
        " となり矛盾）。よって ",
        math(String.raw`w\in\mathbb{C}^{\times}`),
        "。",
      ]),
      paragraph([
        "Step 7: 逆元の一意性。単位元 ",
        math(String.raw`e`),
        " をもつ結合的な二項演算をもつ集合 ",
        math(String.raw`S`),
        " において、",
        math(String.raw`a\in S`),
        " に対し ",
        math(String.raw`b,b'\in S`),
        " がともに ",
        math(String.raw`ab=ba=e`),
        "、",
        math(String.raw`ab'=b'a=e`),
        " を満たすとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
b
&= b\,e \quad (\because e \text{ は単位元}) \\
&= b\,(a b') \quad (\because ab'=e) \\
&= (b a)\,b' \quad (\because \text{結合律}) \\
&= e\,b' \quad (\because ba=e) \\
&= b'
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
        "Step 8: 結論と記法。Step 5 より ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は積について閉じ、Step 2 より結合律を満たし、Step 3・Step 5 より単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " を含み、Step 6 より各元が逆元をもつ。したがって ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は群をなす（Step 1 より可換群である）。",
      ]),
      paragraph([
        "主張の最後の等式 ",
        math(String.raw`z^{-1}=1/z`),
        " は記法の約束である。すなわち ",
        math(String.raw`w\in\mathbb{C},\ z\in\mathbb{C}^{\times}`),
        " に対して商を ",
        math(String.raw`w/z:=w\cdot z^{-1}`),
        " と定めると、Step 3 より",
      ]),
      displayMath(
        String.raw`1/z = 1_{\mathbb{C}}\cdot z^{-1} = z^{-1}`,
      ),
      paragraph(["であり、両記法は一致する。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。" +
          "原文の z^{-1}=1/z は、商 w/z := w z^{-1} を定めたうえでの記法の一致として解釈した。",
      ],
    },
  },
  {
    id: "calculation_formulae_025_claim_complex_numbers_form_a_field",
    kind: "claim",
    sourcePath: "_old/typst/parts/000_計算公式/024_claim_CCは体をなす.typ",
    sourceOrdinal: 25,
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
        math(String.raw`\mathbb{C}:=\mathbb{R}^2`),
        " と定めたうえで積のみを明示しているので、加法は ",
        math(String.raw`\mathbb{R}^2`),
        " が標準的にもつ成分ごとの加法",
      ]),
      displayMath(String.raw`(a,b)+(c,d):=(a+c,\ b+d) \qquad (a,b,c,d\in\mathbb{R})`),
      paragraph([
        "とする。以下ではこの加法と ",
        ref("definition_of_cc"),
        " の積について、体の公理をすべて確かめる。",
      ]),
      paragraph([
        "示すべきことは次の (i)〜(v) である。",
      ]),
      list([
        [
          "(i) ",
          math(String.raw`(\mathbb{C},+)`),
          " は可換群である。",
        ],
        [
          "(ii) 積は結合的・可換であり単位元 ",
          math(String.raw`1_{\mathbb{C}}`),
          " をもつ。",
        ],
        ["(iii) 分配律が成り立つ。"],
        [
          "(iv) ",
          math(String.raw`1_{\mathbb{C}}\ne 0_{\mathbb{C}}`),
          "。",
        ],
        [
          "(v) ",
          math(String.raw`0_{\mathbb{C}}`),
          " 以外の元は積について可逆である。",
        ],
      ]),
      paragraph([
        "Step 1: (i)。",
        math(String.raw`(a,b),(c,d),(e,f)\in\mathbb{C}`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left((a,b)+(c,d)\right)+(e,f)
&= (a+c,\ b+d)+(e,f) \\
&= \left((a+c)+e,\ (b+d)+f\right) \\
&= \left(a+(c+e),\ b+(d+f)\right)
\quad (\because \mathbb{R} \text{ の和の結合律}) \\
&= (a,b)+(c+e,\ d+f) \\
&= (a,b)+\left((c,d)+(e,f)\right)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(a,b)+(c,d)
&= (a+c,\ b+d) \\
&= (c+a,\ d+b)
\quad (\because \mathbb{R} \text{ の和の可換律}) \\
&= (c,d)+(a,b)
\end{aligned}`,
      ),
      paragraph([
        ref("inclusion_rr_to_cc"),
        " より ",
        math(String.raw`0_{\mathbb{C}}=(0,0)`),
        " であり、",
      ]),
      displayMath(
        String.raw`(a,b)+0_{\mathbb{C}} = (a+0,\ b+0) = (a,b)`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`0_{\mathbb{C}}`),
        " は加法の単位元である。また ",
        math(String.raw`(-a,-b)\in\mathbb{R}^2=\mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`(a,b)+(-a,-b) = (a+(-a),\ b+(-b)) = (0,0) = 0_{\mathbb{C}}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`(a,b)`),
        " は加法に関する逆元をもつ。以上より ",
        math(String.raw`(\mathbb{C},+)`),
        " は可換群である。",
      ]),
      paragraph([
        "なお ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-z:=(-1_{\mathbb{C}})\cdot z`),
        " は、この加法逆元と一致する。実際 ",
        ref("inclusion_rr_to_cc"),
        " より ",
        math(String.raw`-1_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(-1)=(-1,0)`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot(a,b)
&= (-1,0)\cdot(a,b) \\
&= \left((-1)a-0\cdot b,\ (-1)b+0\cdot a\right) \\
&= (-a,-b)
\end{aligned}`,
      ),
      paragraph([
        "Step 2: (ii)。積の結合律・可換律・単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " の存在は ",
        ref("multiplicative_group_of_cc"),
        " の Step 1〜Step 3 で示した（これらは ",
        math(String.raw`\mathbb{C}`),
        " の全元について成り立つ主張である）。",
      ]),
      paragraph(["Step 3: (iii)。分配律を確かめる。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)\cdot\left((c,d)+(e,f)\right)
&= (a,b)\cdot(c+e,\ d+f) \\
&= \left(a(c+e)-b(d+f),\ a(d+f)+b(c+e)\right) \\
&= \left(ac+ae-bd-bf,\ ad+af+bc+be\right)
\quad (\because \mathbb{R} \text{ の分配律}) \\
&= \left((ac-bd)+(ae-bf),\ (ad+bc)+(af+be)\right)
\quad (\because \mathbb{R} \text{ の和の可換律・結合律}) \\
&= (ac-bd,\ ad+bc)+(ae-bf,\ af+be) \\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f)
\end{aligned}`,
      ),
      paragraph([
        "右からの分配律は、",
        ref("multiplicative_group_of_cc"),
        " の Step 1（積の可換律）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left((c,d)+(e,f)\right)\cdot(a,b)
&= (a,b)\cdot\left((c,d)+(e,f)\right) \\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f) \\
&= (c,d)\cdot(a,b)+(e,f)\cdot(a,b)
\end{aligned}`,
      ),
      paragraph(["として従う。"]),
      paragraph([
        "Step 4: (iv)。",
        math(String.raw`\mathbb{R}`),
        " において ",
        math(String.raw`1\ne 0`),
        " であるから、第 1 成分を比べて ",
        math(String.raw`1_{\mathbb{C}}=(1,0)\ne(0,0)=0_{\mathbb{C}}`),
        "。",
      ]),
      paragraph([
        "Step 5: (v)。",
        ref("multiplicative_group_of_cc"),
        " より ",
        math(String.raw`\mathbb{C}^{\times}=\mathbb{C}\setminus\{(0,0)\}`),
        " は積について群をなす。特に ",
        math(String.raw`z\ne 0_{\mathbb{C}}`),
        " なる ",
        math(String.raw`z`),
        " は積に関する逆元 ",
        math(String.raw`z^{-1}\in\mathbb{C}^{\times}`),
        " をもつ。",
      ]),
      paragraph([
        "Step 6: 結論。Step 1〜Step 5 より (i)〜(v) がすべて成り立つので、",
        math(String.raw`\mathbb{C}`),
        " は体をなす。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は TODO のみ。ここで証明を与えた。",
        "原文の CC の定義は「CC := RR^2 に以下の演算を入れたもの」として積のみを明示しており、" +
          "加法が明示されていない。体であることを述べるには加法が必要なので、" +
          "本証明では RR^2 の成分ごとの加法を採ることを冒頭で明示した。",
      ],
    },
  },
  {
    id: "calculation_formulae_027_definition_phi_polar",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/026_definition_極座標表現のCCへの写像_phi_polar.typ",
    sourceOrdinal: 27,
    title: {
      tex: "\\text{極座標表現の}\\mathbb{C}\\text{への写像}",
    },
    labels: ["def_phi_polar"],
    statement: [
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
    sourcePath: "_old/typst/parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ",
    sourceOrdinal: 28,
    title: {
      tex: "\\mathbb{C}\\text{の極座標表現への写像}",
    },
    labels: [],
    statement: [
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
    id: "calculation_formulae_029_claim_isomorphism_of_phi_cartesian",
    kind: "claim",
    sourcePath:
      "_old/typst/parts/000_計算公式/028_claim_phi_cartesianの同型性_モノイド準同型と全単射.typ",
    sourceOrdinal: 29,
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
        "1. モノイド準同型性。",
        math(String.raw`[(r,\theta)]_{\sim}, [(r',\theta')]_{\sim} \in (\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim}\cdot[(r',\theta')]_{\sim})
&= \phi_{\mathrm{cartesian}}([(rr',\theta+\theta')]_{\sim}) \\
&= (rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))
\end{aligned}`,
      ),
      paragraph(["また、"]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(r,\theta)]_{\sim})\cdot\phi_{\mathrm{cartesian}}([(r',\theta')]_{\sim})
&= (r\cos\theta,\ r\sin\theta)\cdot(r'\cos\theta',\ r'\sin\theta') \\
&= (rr'\cos\theta\cos\theta' - rr'\sin\theta\sin\theta',\ rr'\cos\theta\sin\theta' + rr'\sin\theta\cos\theta') \\
&= (rr'(\cos\theta\cos\theta'-\sin\theta\sin\theta'),\ rr'(\cos\theta\sin\theta'+\sin\theta\cos\theta')) \\
&= (rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta'))
\end{aligned}`,
      ),
      paragraph([
        "よって両者は一致する（積 ",
        math(String.raw`(a,b)\cdot(c,d) := (ac-bd,\ ad+bc)`),
        " と三角関数の加法定理を用いた）。",
      ]),
      paragraph([
        "2. 全単射性。合成 ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}`),
        " を計算する。以下で ",
        math(String.raw`\cos(\arctan(y/x))=\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}`),
        "、",
        math(String.raw`\sin(\arctan(y/x))=\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}`),
        "（",
        ref("cos_arctan_sin_arctan"),
        "）と、",
        math(String.raw`x<0`),
        " のとき ",
        math(String.raw`x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}`),
        "（",
        ref("negative_number_to_sqrt"),
        "）を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\!\left(
\begin{cases}
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x))]_{\sim} & (x>0) \\
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)+\pi)]_{\sim} & (x<0,\ y\geq 0) \\
[(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)-\pi)]_{\sim} & (x<0,\ y<0) \\
[(y,\ \pi/2)]_{\sim} & (x=0 \wedge y>0) \\
[(-y,\ -\pi/2)]_{\sim} & (x=0 \wedge y<0) \\
[(0,0)]_{\sim} & (x=0 \wedge y=0)
\end{cases}\right) \\[4pt]
&= \begin{cases}
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x>0) \\
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)+\pi),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x)+\pi)) & (x<0,\ y\geq 0) \\
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)-\pi),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x)-\pi)) & (x<0,\ y<0) \\
(y\cos(\pi/2),\ y\sin(\pi/2)) & (x=0 \wedge y>0) \\
(-y\cos(-\pi/2),\ -y\sin(-\pi/2)) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= \begin{cases}
(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x>0) \\
(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))) & (x<0) \\
(y\cos(\pi/2),\ y\sin(\pi/2)) & (x=0 \wedge y>0) \\
(-y\cos(-\pi/2),\ -y\sin(-\pi/2)) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&\overset{(\ast)}{=} \begin{cases}
\left(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(-\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{1}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ -\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\dfrac{y/x}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&\overset{(\ast\ast)}{=} \begin{cases}
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= \begin{cases}
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x>0) \\
\left(\dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\ \dfrac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right) & (x<0) \\
(0,\ y) & (x=0 \wedge y>0) \\
(0,\ y) & (x=0 \wedge y<0) \\
(0,0) & (x=0 \wedge y=0)
\end{cases} \\[4pt]
&= (x,y)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(\ast)`),
        " は ",
        ref("cos_arctan_sin_arctan"),
        " による（",
        math(String.raw`x=0`),
        " の行では ",
        math(String.raw`\cos(\pm\pi/2)=0`),
        "、",
        math(String.raw`\sin(\pi/2)=1`),
        "、",
        math(String.raw`\sin(-\pi/2)=-1`),
        " を用いた）。",
        math(String.raw`(\ast\ast)`),
        " は分母・分子に ",
        math(String.raw`x`),
        " を掛け、",
        ref("negative_number_to_sqrt"),
        " により ",
        math(String.raw`x>0`),
        " のとき ",
        math(String.raw`x=\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}`),
        "、",
        math(String.raw`x<0`),
        " のとき ",
        math(String.raw`x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}`),
        " を用いた（",
        math(String.raw`x<0`),
        " では負号が分母の負号と相殺する）。続いて ",
        math(String.raw`x^2(1+(y/x)^2)=x^2+y^2`),
        "、",
        math(String.raw`(-x)^2=x^2`),
        " による。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の part 2 は phi_cartesian ∘ phi_polar = id_CC を示すところまでで、全単射（特に単射性）の明示的な導出は原文にない。ここでは原文の計算を全ステップ忠実に再現した。",
      ],
    },
  },
  {
    id: "calculation_formulae_030_definition_first_and_second_projections",
    kind: "definition",
    sourcePath: "_old/typst/parts/000_計算公式/029_definition_第1座標と第2座標_pr1_pr2.typ",
    sourceOrdinal: 30,
    title: {
      text: "第1座標, 第2座標",
    },
    labels: ["first_and_second_projections"],
    statement: [
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
]);
