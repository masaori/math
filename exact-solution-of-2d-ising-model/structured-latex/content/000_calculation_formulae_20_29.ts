import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 旧 calculation_formulae_021（極座標表現の同値類の性質の remark）は、定義から直ちに従う
// 読み手向けの補足であり出版本文には載らないため、
// notes/000_calculation_formulae.ts（targets: polar_equivalence_class）へ移設した。
export default defineBlocks([
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
      paragraph(["この構造を「極座標表現」と呼ぶ。"]),
    ],
    conversion: {
      status: "converted",
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
        " である。証明は独立した中間目標へ分かれるので、以下ではそれぞれに名前を付けて示す。",
      ]),
      paragraph([
        "準備（二項演算が well-defined であること）。",
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
      displayMath(String.raw`\begin{aligned}
rr'
&= 0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)\\
&= r_1r_1'
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)
\end{aligned}`),
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
      displayMath(String.raw`\begin{aligned}
(\theta+\theta')-(\theta_1+\theta_1')
&= (\theta-\theta_1)+(\theta'-\theta_1')
&&(\because\ \mathbb{R}\ \text{の和と差の整理})\\
&= 2n\pi+(\theta'-\theta_1')
&&(\because\ \theta-\theta_1=2n\pi)\\
&= 2n\pi+2n'\pi
&&(\because\ \theta'-\theta_1'=2n'\pi)\\
&= 2(n+n')\pi
&&(\because\ \mathbb{R}\ \text{の分配則})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`n+n'\in\mathbb{Z}`),
        " であるから ",
        math(String.raw`\theta+\theta'\sim_{\mathrm{angle}}\theta_1+\theta_1'`),
        "（",
        ref("angle_equivalence_class"),
        "）。また",
      ]),
      displayMath(String.raw`\begin{aligned}
rr'
&= r_1r'
&&(\because\ r=r_1)\\
&= r_1r_1'
&&(\because\ r'=r_1')
\end{aligned}`),
      paragraph([
        "であるから、第 2 の選言により ",
        math(String.raw`(rr',\theta+\theta')\sim(r_1r_1',\theta_1+\theta_1')`),
        "。以上より ",
        math(String.raw`\cdot`),
        " は well-defined である。",
      ]),
      paragraph([
        "結合律。",
        math(String.raw`[(r_1,\theta_1)]_{\sim},[(r_2,\theta_2)]_{\sim},[(r_3,\theta_3)]_{\sim}\in(\text{極座標表現})`),
        " に対して、",
      ]),
      displayMath(String.raw`\begin{aligned}
\left([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}\right)\cdot[(r_3,\theta_3)]_{\sim}
&= [(r_1r_2,\theta_1+\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義})\\
&= [((r_1r_2)r_3,\ (\theta_1+\theta_2)+\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義})\\
&= [(r_1(r_2r_3),\ (\theta_1+\theta_2)+\theta_3)]_{\sim}
&&(\because\ \mathbb{R}\ \text{の積の結合律})\\
&= [(r_1(r_2r_3),\ \theta_1+(\theta_2+\theta_3))]_{\sim}
&&(\because\ \mathbb{R}\ \text{の和の結合律})\\
&= [(r_1,\theta_1)]_{\sim}\cdot[(r_2r_3,\theta_2+\theta_3)]_{\sim}
&&(\because\ \text{極座標表現の積の定義})\\
&= [(r_1,\theta_1)]_{\sim}\cdot\left([(r_2,\theta_2)]_{\sim}\cdot[(r_3,\theta_3)]_{\sim}\right)
&&(\because\ \text{極座標表現の積の定義})
\end{aligned}`),
      paragraph([
        "が成り立つ（積の定義は ",
        ref("operations_on_polar_representation"),
        "）。",
        math(String.raw`r_1,r_2,r_3\in\mathbb{R}_{\ge 0}`),
        " の積は ",
        math(String.raw`\mathbb{R}_{\ge 0}`),
        " に属するので、各段の右辺は ",
        math(String.raw`(\text{極座標表現})`),
        " の元である。",
      ]),
      paragraph([
        "単位元。",
        math(String.raw`e:=[(1,0)]_{\sim}\in(\text{極座標表現})`),
        " とおくと、",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})`),
        " に対して",
      ]),
      displayMath(String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot e
&= [(r\cdot 1,\ \theta+0)]_{\sim}
&&(\because\ \text{極座標表現の積の定義と}\ e\ \text{の定め方})\\
&= [(r,\ \theta+0)]_{\sim}
&&(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の積の単位元})\\
&= [(r,\theta)]_{\sim}
&&(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元})
\end{aligned}`),
      paragraph(["であり、また"]),
      displayMath(String.raw`\begin{aligned}
e\cdot[(r,\theta)]_{\sim}
&= [(1\cdot r,\ 0+\theta)]_{\sim}
&&(\because\ \text{極座標表現の積の定義と}\ e\ \text{の定め方})\\
&= [(r,\ 0+\theta)]_{\sim}
&&(\because\ 1\ \text{は}\ \mathbb{R}\ \text{の積の単位元})\\
&= [(r,\theta)]_{\sim}
&&(\because\ 0\ \text{は}\ \mathbb{R}\ \text{の和の単位元})
\end{aligned}`),
      paragraph([
        "である。したがって ",
        math(String.raw`e`),
        " は ",
        math(String.raw`\cdot`),
        " の単位元である。",
      ]),
      paragraph([
        "モノイドであること。結合律と単位元の 2 つより、",
        math(String.raw`(\text{極座標表現})`),
        " は ",
        math(String.raw`\cdot`),
        " について単位元 ",
        math(String.raw`e=[(1,0)]_{\sim}`),
        " をもつ結合的な二項演算をもつ、すなわちモノイドをなす。",
      ]),
      paragraph([
        "零元との一致の判定。",
        math(String.raw`[(r,\theta)]_{\sim}=[(0,0)]_{\sim}\iff r=0`),
        " を、両向きに分けて示す。",
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
        "積で閉じ、単位元を含むこと。",
        math(String.raw`[(r,\theta)]_{\sim},[(r',\theta')]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると、零元との一致の判定より ",
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
&&(\because\ \text{極座標表現の積の定義})\\
&\ne [(0,0)]_{\sim}
&&(\because\ rr'\ne 0\ \text{と零元との一致の判定})
\end{aligned}`),
      paragraph([
        "すなわち積は ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " に属する。また ",
        math(String.raw`1\ne 0`),
        " より零元との一致の判定から ",
        math(String.raw`e=[(1,0)]_{\sim}\ne[(0,0)]_{\sim}`),
        " であり ",
        math(String.raw`e\in(\text{極座標表現})^{\times}`),
        "。",
      ]),
      paragraph([
        "逆元の存在。",
        math(String.raw`[(r,\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        " とすると、直前の議論より ",
        math(String.raw`r>0`),
        " であるから ",
        math(String.raw`1/r\in\mathbb{R}_{>0}\subset\mathbb{R}_{\ge 0}`),
        " が定まり ",
        math(String.raw`[(1/r,-\theta)]_{\sim}\in(\text{極座標表現})^{\times}`),
        "（",
        math(String.raw`1/r\ne 0`),
        " と零元との一致の判定）。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
[(r,\theta)]_{\sim}\cdot[(1/r,-\theta)]_{\sim}
&= [(r\cdot(1/r),\ \theta+(-\theta))]_{\sim}
&&(\because\ \text{極座標表現の積の定義})\\
&= [(1,\ \theta+(-\theta))]_{\sim}
&&(\because\ r>0\ \text{より}\ r\cdot(1/r)=1)\\
&= [(1,0)]_{\sim}
&&(\because\ -\theta\ \text{は}\ \theta\ \text{の}\ \mathbb{R}\ \text{における加法の逆元})\\
&= e
&&(\because\ e\ \text{の定め方})
\end{aligned}`),
      paragraph(["であり、また"]),
      displayMath(String.raw`\begin{aligned}
[(1/r,-\theta)]_{\sim}\cdot[(r,\theta)]_{\sim}
&= [((1/r)\cdot r,\ (-\theta)+\theta)]_{\sim}
&&(\because\ \text{極座標表現の積の定義})\\
&= [(1,\ (-\theta)+\theta)]_{\sim}
&&(\because\ r>0\ \text{より}\ (1/r)\cdot r=1)\\
&= [(1,0)]_{\sim}
&&(\because\ -\theta\ \text{は}\ \theta\ \text{の}\ \mathbb{R}\ \text{における加法の逆元})\\
&= e
&&(\because\ e\ \text{の定め方})
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "逆元の一意性。単位元 ",
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
      displayMath(String.raw`\begin{aligned}
b
&= b\,e
&&(\because\ e\ \text{は単位元})\\
&= b\,(a b')
&&(\because\ ab'=e)\\
&= (b a)\,b'
&&(\because\ \text{結合律})\\
&= e\,b'
&&(\because\ ba=e)\\
&= b'
&&(\because\ e\ \text{は単位元})
\end{aligned}`),
      paragraph([
        "であるから逆元は一意である。よって逆元の存在で作った ",
        math(String.raw`[(1/r,-\theta)]_{\sim}`),
        " が ",
        math(String.raw`[(r,\theta)]_{\sim}`),
        " の唯一の逆元であり、",
      ]),
      displayMath(String.raw`\left([(r,\theta)]_{\sim}\right)^{-1}=[(1/r,-\theta)]_{\sim}`),
      paragraph([
        "結論。積で閉じることより ",
        math(String.raw`(\text{極座標表現})^{\times}`),
        " は ",
        math(String.raw`\cdot`),
        " について閉じており、結合律を満たし、単位元 ",
        math(String.raw`e`),
        " を含み、逆元の存在より各元が逆元をもつ。したがって ",
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
        "以下、",
        math(String.raw`(a,b),(c,d),(e,f)\in\mathbb{C}`),
        " は任意に取ったものとする（したがって ",
        math(String.raw`a,b,c,d,e,f\in\mathbb{R}`),
        "）。",
      ]),
      paragraph(["積の可換律。"]),
      displayMath(
        String.raw`\begin{aligned}
(c,d)\cdot(a,b)
&= (ca-db,\ cb+da)
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= (ac-bd,\ cb+da)
&&(\because\ \mathbb{R}\ \text{の積の可換律を 2 箇所へ適用})\\
&= (ac-bd,\ bc+ad)
&&(\because\ \mathbb{R}\ \text{の積の可換律を 2 箇所へ適用})\\
&= (ac-bd,\ ad+bc)
&&(\because\ \mathbb{R}\ \text{の和の可換律})\\
&= (a,b)\cdot(c,d)
&&(\because\ \mathbb{C}\ \text{の積の定義})
\end{aligned}`,
      ),
      paragraph(["積の結合律。"]),
      displayMath(
        String.raw`\begin{aligned}
\left((a,b)\cdot(c,d)\right)\cdot(e,f)
&= (ac-bd,\ ad+bc)\cdot(e,f)
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= \left((ac-bd)e-(ad+bc)f,\ (ac-bd)f+(ad+bc)e\right)
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= \left(ace-bde-adf-bcf,\ acf-bdf+ade+bce\right)
&&(\because\ \mathbb{R}\ \text{の分配律と積の結合律を 4 箇所へ適用})\\
&= \left(ace-adf-bcf-bde,\ acf+ade+bce-bdf\right)
&&(\because\ \mathbb{R}\ \text{の和の可換律と結合律})\\
&= \left(a(ce-df)-b(cf+de),\ a(cf+de)+b(ce-df)\right)
&&(\because\ \mathbb{R}\ \text{の分配律と積の結合律を 4 箇所へ適用})\\
&= (a,b)\cdot(ce-df,\ cf+de)
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= (a,b)\cdot\left((c,d)\cdot(e,f)\right)
&&(\because\ \mathbb{C}\ \text{の積の定義})
\end{aligned}`,
      ),
      paragraph([
        "第 3 の等号と第 5 の等号では、",
        math(String.raw`\mathbb{R}`),
        " の分配律と積の結合律を同時に使っている（例えば ",
        math(String.raw`(ac-bd)e=ace-bde`),
        " は分配律で 2 項に分けたうえで、各項の積の順序を結合律で括り直したものである）。",
        "同じ定理を複数箇所へ同時に適用しているので 1 行にまとめてある。",
      ]),
      paragraph(["積の単位元。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)\cdot 1_{\mathbb{C}}
&= (a,b)\cdot(1,0)
&&(\because\ 1_{\mathbb{C}}=(1,0))\\
&= (a\cdot 1-b\cdot 0,\ a\cdot 0+b\cdot 1)
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= (a-b\cdot 0,\ a\cdot 0+b)
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元。2 箇所へ適用})\\
&= (a-0,\ 0+b)
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0\text{。2 箇所へ適用})\\
&= (a,b)
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元。2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph(["であり、また"]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}\cdot(a,b)
&= (a,b)\cdot 1_{\mathbb{C}}
&&(\because\ \text{上で示した積の可換律})\\
&= (a,b)
&&(\because\ \text{上の計算})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`1_{\mathbb{C}}`),
        " は積の単位元である。",
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
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})
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
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= a^2+\left(b^2+(-b^2)\right)
&&(\because\ -b^2\ \text{は}\ b^2\ \text{の和の逆元})\\
&= \left(a^2+b^2\right)+(-b^2)
&&(\because\ \mathbb{R}\ \text{の和の結合律})\\
&= 0+(-b^2)
&&(\because\ \text{仮定}\ a^2+b^2=0)\\
&= -b^2
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
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
&= 0+0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0\text{。2 箇所へ適用})\\
&= 0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})
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
        " が積について閉じること。まず次の恒等式を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(ac-bd)^2+(ad+bc)^2
&= \left(a^2c^2-2abcd+b^2d^2\right)+\left(a^2d^2+2abcd+b^2c^2\right)
&&(\because\ \mathbb{R}\ \text{の分配律と積の結合律・可換律を 2 箇所へ適用})\\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2+\left((-2abcd)+2abcd\right)
&&(\because\ \mathbb{R}\ \text{の和の可換律と結合律})\\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2+0
&&(\because\ -2abcd\ \text{は}\ 2abcd\ \text{の和の逆元})\\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= \left(a^2+b^2\right)\left(c^2+d^2\right)
&&(\because\ \mathbb{R}\ \text{の分配律と積の可換律})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`z=(a,b),\ w=(c,d)\in\mathbb{C}^{\times}`),
        " とすると、上で示した同値より ",
        math(String.raw`a^2+b^2>0`),
        " かつ ",
        math(String.raw`c^2+d^2>0`),
        " であるから ",
        math(String.raw`(a^2+b^2)(c^2+d^2)>0`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " では正の元どうしの積は正）。この恒等式より ",
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
&= 1+0
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元、および}\ 0\ \text{を因子にもつ積は}\ 0)\\
&= 1
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
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
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
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
&&(\because\ 1_{\mathbb{C}}=(1,0))
\end{aligned}`,
      ),
      paragraph(["である。さらに"]),
      displayMath(
        String.raw`\begin{aligned}
w\cdot z
&= z\cdot w
&&(\because\ \text{上で示した積の可換律})\\
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
&= b\,e
&&(\because\ e\ \text{は単位元})\\
&= b\,(a b')
&&(\because\ ab'=e)\\
&= (b a)\,b'
&&(\because\ \text{結合律})\\
&= e\,b'
&&(\because\ ba=e)\\
&= b'
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
        " は積について閉じ、結合律を満たし、単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " を含み、各元が逆元をもつ。したがって ",
        math(String.raw`\mathbb{C}^{\times}`),
        " は群をなす（積の可換律も示したので可換群である）。",
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
&&(\because\ \text{上で示した}\ 1_{\mathbb{C}}\ \text{が積の単位元であること})
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
&&(\because\ \mathbb{R}\to\mathbb{C}\ \text{の包含写像}\ \text{の}\ 0_{\mathbb{C}}=(0,0))\\
&= (a+0,\ b+0)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (a,b)
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元。2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("inclusion_rr_to_cc"),
        " である。",
      ]),
      paragraph(["加法の逆元。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)+(-a,-b)
&= (a+(-a),\ b+(-b))
&&(\because\ \text{成分ごとの加法の定義})\\
&= (0,0)
&&(\because\ \mathbb{R}\ \text{の和の逆元を 2 箇所へ適用})\\
&= 0_{\mathbb{C}}
&&(\because\ \mathbb{R}\to\mathbb{C}\ \text{の包含写像}\ \text{の}\ 0_{\mathbb{C}}=(0,0))
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`-a,-b\in\mathbb{R}`),
        " なので ",
        math(String.raw`(-a,-b)\in\mathbb{R}^2=\mathbb{C}`),
        " である。以上の 4 つより ",
        math(String.raw`(\mathbb{C},+)`),
        " は可換群である。引いたブロックは ",
        ref("inclusion_rr_to_cc"),
        " である。",
      ]),
      paragraph([
        "この加法逆元は ",
        ref("multiply_by_minus_one"),
        " の ",
        math(String.raw`-z:=(-1_{\mathbb{C}})\cdot z`),
        " と一致する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(-1_{\mathbb{C}})\cdot(a,b)
&= (-1,0)\cdot(a,b)
&&(\because\ \mathbb{R}\to\mathbb{C}\ \text{の包含写像}\ \text{より}\ -1_{\mathbb{C}}=\iota_{\mathbb{R}\to\mathbb{C}}(-1)=(-1,0))\\
&= \bigl((-1)a-0\cdot b,\ (-1)b+0\cdot a\bigr)
&&(\because\ \mathbb{C}\ \text{の定義}\ \text{の積})\\
&= (-a,-b)
&&(\because\ \mathbb{R}\ \text{では}\ 1\ \text{は積の単位元、}\ 0\ \text{を因子にもつ積は}\ 0\text{、}\ 0\ \text{は和の単位元})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("inclusion_rr_to_cc"),
        " と ",
        ref("definition_of_cc"),
        " である。",
      ]),
      paragraph([
        "積のモノイド構造。積の結合律・可換律・単位元 ",
        math(String.raw`1_{\mathbb{C}}`),
        " の存在は ",
        ref("multiplicative_group_of_cc"),
        " の「積の可換律」「積の結合律」「積の単位元」で示した",
        "（これらは ",
        math(String.raw`\mathbb{C}`),
        " の全元について成り立つ主張である）。",
      ]),
      paragraph(["左からの分配律。"]),
      displayMath(
        String.raw`\begin{aligned}
(a,b)\cdot\bigl((c,d)+(e,f)\bigr)
&= (a,b)\cdot(c+e,\ d+f)
&&(\because\ \text{成分ごとの加法の定義})\\
&= \bigl(a(c+e)-b(d+f),\ a(d+f)+b(c+e)\bigr)
&&(\because\ \mathbb{C}\ \text{の定義}\ \text{の積})\\
&= \bigl(ac+ae-(bd+bf),\ ad+af+(bc+be)\bigr)
&&(\because\ \mathbb{R}\ \text{の分配律を 4 箇所へ適用})\\
&= \bigl((ac-bd)+(ae-bf),\ (ad+bc)+(af+be)\bigr)
&&(\because\ \mathbb{R}\ \text{の和の可換律・結合律、および和の逆元の分配})\\
&= (ac-bd,\ ad+bc)+(ae-bf,\ af+be)
&&(\because\ \text{成分ごとの加法の定義})\\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f)
&&(\because\ \mathbb{C}\ \text{の定義}\ \text{の積を 2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("definition_of_cc"),
        " である。第 4 の等号の「和の逆元の分配」とは ",
        math(String.raw`-(bd+bf)=(-bd)+(-bf)`),
        " のことである。",
      ]),
      paragraph(["右からの分配律。"]),
      displayMath(
        String.raw`\begin{aligned}
\bigl((c,d)+(e,f)\bigr)\cdot(a,b)
&= (a,b)\cdot\bigl((c,d)+(e,f)\bigr)
&&(\because\ \mathbb{C}\ \text{の乗法群}\ \text{の積の可換律})\\
&= (a,b)\cdot(c,d)+(a,b)\cdot(e,f)
&&(\because\ \text{上で示した左からの分配律})\\
&= (c,d)\cdot(a,b)+(e,f)\cdot(a,b)
&&(\because\ \mathbb{C}\ \text{の乗法群}\ \text{の積の可換律を 2 箇所へ適用})
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("multiplicative_group_of_cc"),
        " である。",
      ]),
      paragraph(["単位元と零元の相違。"]),
      displayMath(
        String.raw`\begin{aligned}
1_{\mathbb{C}}
&= (1,0)
&&(\because\ \mathbb{R}\to\mathbb{C}\ \text{の包含写像}\ \text{の}\ 1_{\mathbb{C}}=(1,0))\\
&\ne (0,0)
&&(\because\ \mathbb{R}\ \text{において}\ 1\ne 0\ \text{であり、第 1 成分が異なる})\\
&= 0_{\mathbb{C}}
&&(\because\ \mathbb{R}\to\mathbb{C}\ \text{の包含写像}\ \text{の}\ 0_{\mathbb{C}}=(0,0))
\end{aligned}`,
      ),
      paragraph([
        "引いたブロックは ",
        ref("inclusion_rr_to_cc"),
        " である。",
      ]),
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
    origin: {
      path: "_old/typst/parts/000_計算公式/027_definition_CCの極座標表現への写像_phi_cartesian.typ",
      ordinal: 28,
    },
    title: {
      tex: "\\mathbb{C}\\text{の極座標表現への写像}",
    },
    labels: ["def_phi_cartesian"],
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
&&(\because\ \text{極座標表現の演算})\\
&= \bigl(rr'\cos(\theta+\theta'),\ rr'\sin(\theta+\theta')\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
&= \bigl(rr'(\cos\theta\cos\theta'-\sin\theta\sin\theta'),\ rr'(\cos\theta\sin\theta'+\sin\theta\cos\theta')\bigr)
&&(\because\ \text{三角関数の加法定理})\\
&= \bigl(rr'\cos\theta\cos\theta'-rr'\sin\theta\sin\theta',\ rr'\cos\theta\sin\theta'+rr'\sin\theta\cos\theta'\bigr)
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= \bigl((r\cos\theta)(r'\cos\theta')-(r\sin\theta)(r'\sin\theta'),\ (r\cos\theta)(r'\sin\theta')+(r\sin\theta)(r'\cos\theta')\bigr)
&&(\because\ \mathbb{R}\ \text{の積の可換律と結合律})\\
&= (r\cos\theta,\ r\sin\theta)\cdot(r'\cos\theta',\ r'\sin\theta')
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= \phi_{\mathrm{cartesian}}\bigl([(r,\theta)]_{\sim}\bigr)\cdot\phi_{\mathrm{cartesian}}\bigl([(r',\theta')]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("operations_on_polar_representation"),
        "、",
        ref("def_phi_cartesian"),
        "、",
        ref("definition_of_cc"),
        "）。",
      ]),
      paragraph([
        "全単射性。合成 ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " の恒等写像であることを、",
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
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x>0\ \text{の場合})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos(\arctan(y/x)),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin(\arctan(y/x))\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,(y/x)}{\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \arctan\ \text{の}\ \cos,\sin)\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x>0\ \text{なので分母と分子に}\ x\ \text{を掛けられる})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x>0\ \text{と平方根の一意性から}\ x=\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{平方根の一意性から}\ \sqrt{a}\sqrt{b}=\sqrt{ab})\\
&= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x^2\bigl(1+(y/x)^2\bigr)=x^2+y^2)\\
&= (x,\ y)
&&(\because\ x>0\ \text{なので}\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\ne0\ \text{で約分できる})
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_phi_polar"),
        "、",
        ref("def_phi_cartesian"),
        "、",
        ref("cos_arctan_sin_arctan"),
        "、",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "、",
        ref("definition_of_sqrt_r_positive"),
        "）。",
      ]),
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
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)+\pi\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x<0,\ y\geq0\ \text{の場合})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos\bigl(\arctan(y/x)+\pi\bigr),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin\bigl(\arctan(y/x)+\pi\bigr)\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
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
&= \phi_{\mathrm{cartesian}}\Bigl(\bigl[\bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}},\ \arctan(y/x)-\pi\bigr)\bigr]_{\sim}\Bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x<0,\ y<0\ \text{の場合})\\
&= \Bigl(\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\cos\bigl(\arctan(y/x)-\pi\bigr),\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\sin\bigl(\arctan(y/x)-\pi\bigr)\Bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
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
&&(\because\ \arctan\ \text{の}\ \cos,\sin)\\
&\quad= \left(-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{x\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x<0\ \text{なので分母と分子に}\ x\ \text{を掛けられる})\\
&\quad= \left(-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
-\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x<0\ \text{のとき}\ x=-\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{(-x)^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{分子の負号と分母の負号が相殺する})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2}^{\,\mathbb{R}_{\geq 0}}\sqrt{1+(y/x)^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ (-x)^2=x^2)\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2\bigl(1+(y/x)^2\bigr)}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ \text{平方根の一意性から}\ \sqrt{a}\sqrt{b}=\sqrt{ab})\\
&\quad= \left(\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,x}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}},\
\frac{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\,y}{\sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}}\right)
&&(\because\ x^2\bigl(1+(y/x)^2\bigr)=x^2+y^2)\\
&\quad= (x,\ y)
&&(\because\ x<0\ \text{なので}\ \sqrt{x^2+y^2}^{\,\mathbb{R}_{\geq 0}}\ne0\ \text{で約分できる})
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_phi_polar"),
        "、",
        ref("def_phi_cartesian"),
        "、",
        ref("cos_arctan_sin_arctan"),
        "、",
        ref("negative_number_to_sqrt"),
        "、",
        ref("sqrt_nonnegative_existence_uniqueness"),
        "）。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y>0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl([(y,\ \pi/2)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y>0\ \text{の場合})\\
&= \bigl(y\cos(\pi/2),\ y\sin(\pi/2)\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
&= (y\cdot 0,\ y\cdot 1)
&&(\because\ \cos(\pi/2)=0,\ \sin(\pi/2)=1)\\
&= (0,\ y)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0,\ 1\ \text{は積の単位元})\\
&= (x,\ y)
&&(\because\ x=0)
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_phi_polar"),
        "、",
        ref("def_phi_cartesian"),
        "）。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y<0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl([(-y,\ -\pi/2)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y<0\ \text{の場合})\\
&= \bigl((-y)\cos(-\pi/2),\ (-y)\sin(-\pi/2)\bigr)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
&= \bigl((-y)\cdot 0,\ (-y)\cdot(-1)\bigr)
&&(\because\ \cos(-\pi/2)=0,\ \sin(-\pi/2)=-1)\\
&= (0,\ y)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0,\ \text{負号を 2 度施すともとに戻る})\\
&= (x,\ y)
&&(\because\ x=0)
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_phi_polar"),
        "、",
        ref("def_phi_cartesian"),
        "）。",
      ]),
      paragraph([
        math(String.raw`x=0`),
        " かつ ",
        math(String.raw`y=0`),
        " の場合。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}})(x,y)
&= \phi_{\mathrm{cartesian}}\bigl([(0,\ 0)]_{\sim}\bigr)
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y=0\ \text{の場合})\\
&= (0\cdot\cos 0,\ 0\cdot\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義})\\
&= (0,\ 0)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0)\\
&= (x,\ y)
&&(\because\ x=0\ \text{かつ}\ y=0)
\end{aligned}`,
      ),
      paragraph([
        "である（引いたブロックは ",
        ref("def_phi_polar"),
        "、",
        ref("def_phi_cartesian"),
        "）。",
      ]),
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
        "原文の part 2 は phi_cartesian ∘ phi_polar = id_CC を示すところまでで、全単射（特に単射性）の明示的な導出は原文にない。ここでは原文の計算を全ステップ忠実に再現した。",
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
