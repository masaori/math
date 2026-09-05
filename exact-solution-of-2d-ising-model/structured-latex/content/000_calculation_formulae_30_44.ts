import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "calculation_formulae_031_definition_abs_arg",
    kind: "definition",
    origin: { path: "_old/typst/parts/000_計算公式/030_definition_絶対値と偏角_abs_arg.typ", ordinal: 31 },
    title: { text: "絶対値, 偏角" },
    labels: ["def_abs_arg"],
    statement: [
      paragraph([ref("def_phi_polar"), "、", ref("first_and_second_projections"), "、", ref("section_of_angle_representation"), " を用いる。"]),
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
    origin: { path: "structured-latex/content/000_calculation_formulae_30_44.ts", ordinal: 31 },
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
        "証明の中で使うものを先に置く。",
        math(String.raw`z=(x,y)\in\mathbb{C}`),
        "、",
        math(String.raw`z_1=(a,b)\in\mathbb{C}`),
        "、",
        math(String.raw`z_2=(c,d)\in\mathbb{C}`),
        " と書く（",
        math(String.raw`x,y,a,b,c,d\in\mathbb{R}`),
        "）。",
      ]),
      paragraph([
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
        " である。よって値は代表元によらない。",
      ]),
      paragraph([
        "非負実数の平方の比較。",
        math(String.raw`u,v\in\mathbb{R}_{\ge 0}`),
        " について ",
        math(String.raw`u^2\le v^2`),
        " ならば ",
        math(String.raw`u\le v`),
        " である。対偶を示す。",
        math(String.raw`u>v\ (\ge 0)`),
        " とすると ",
        math(String.raw`u>0`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u^2
&= u\cdot u
&&(\because\ \text{平方の定め方})\\
&> v\cdot u
&&(\because\ u>v\ \text{と}\ u>0\text{。正の元を掛けても大小は保たれる})\\
&\ge v\cdot v
&&(\because\ u\ge v\ \text{と}\ v\ge 0\text{。非負の元を掛けても大小は保たれる})\\
&= v^2
&&(\because\ \text{平方の定め方})
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`u^2>v^2`),
        " である。とくに ",
        math(String.raw`u,v\ge 0`),
        " かつ ",
        math(String.raw`u^2=v^2`),
        " ならば ",
        math(String.raw`u\le v`),
        " かつ ",
        math(String.raw`v\le u`),
        " より ",
        math(String.raw`u=v`),
        " である。",
      ]),
      paragraph([
        "以下、6 つの主張を順に示す。",
      ]),
      paragraph([
        "(1) 成分による表示。",
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
        "上 3 つの場合は主張の形をしている。残りの 3 つの場合を確かめる。以下、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\sqrt{s}^{(\mathbb{R}_{\ge 0})}`),
        " は ",
        math(String.raw`u\ge 0`),
        " かつ ",
        math(String.raw`u^2=s`),
        " を満たす唯一の ",
        math(String.raw`u`),
        " であることを使う。",
      ]),
      paragraph([
        math(String.raw`x=0,\ y>0`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}
&= \sqrt{0^2+y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ x=0)\\
&= \sqrt{0+y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)\\
&= \sqrt{y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= y
&&(\because\ y>0\ \text{なので}\ y\ge 0\ \text{であり}\ y^2=y^2\text{。平方根の一意性})\\
&= \operatorname{pr}_1(\phi_{\mathrm{polar}}(x,y))
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y>0\ \text{の場合})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x=0,\ y<0`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}
&= \sqrt{0^2+y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ x=0)\\
&= \sqrt{0+y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)\\
&= \sqrt{y^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= \sqrt{(-y)^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ (-y)^2=y^2)\\
&= -y
&&(\because\ y<0\ \text{なので}\ -y\ge 0\ \text{であり}\ (-y)^2=(-y)^2\text{。平方根の一意性})\\
&= \operatorname{pr}_1(\phi_{\mathrm{polar}}(x,y))
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y<0\ \text{の場合})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x=0,\ y=0`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}
&= \sqrt{0^2+0^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ x=0\ \text{かつ}\ y=0)\\
&= \sqrt{0+0}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0\text{。2 箇所へ適用})\\
&= \sqrt{0}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= 0
&&(\because\ 0\ge 0\ \text{であり}\ 0^2=0\text{。平方根の一意性})\\
&= \operatorname{pr}_1(\phi_{\mathrm{polar}}(x,y))
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x=0,\ y=0\ \text{の場合})
\end{aligned}`,
      ),
      paragraph([
        "以上より、すべての場合で ",
        math(String.raw`|z|=\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}`),
        " である。",
      ]),
      paragraph([
        "(2) 絶対値の平方。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z|^2
&= \left(\sqrt{x^2+y^2}^{(\mathbb{R}_{\ge 0})}\right)^2
&&(\because\ \text{上で示した成分による表示})\\
&= x^2+y^2
&&(\because\ x^2+y^2\ge 0\ \text{と、平方根の定義}\ \left(\sqrt{s}^{(\mathbb{R}_{\ge 0})}\right)^2=s)
\end{aligned}`,
      ),
      paragraph([
        "(3) 絶対値が ",
        math(String.raw`0`),
        " であることと ",
        math(String.raw`z=0_{\mathbb{C}}`),
        " であることの同値。2 つの向きを別々に示す。",
      ]),
      paragraph([
        math(String.raw`|z|=0`),
        " とすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^2+y^2
&= |z|^2
&&(\because\ \text{上で示した絶対値の平方})\\
&= 0^2
&&(\because\ \text{仮定}\ |z|=0)\\
&= 0
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("multiplicative_group_of_cc"),
        " の「零でないことと平方和が正であることの同値」で示したとおり ",
        math(String.raw`x^2+y^2=0\iff(x,y)=(0,0)`),
        " であるから ",
        math(String.raw`z=0_{\mathbb{C}}`),
        " である。逆に ",
        math(String.raw`z=0_{\mathbb{C}}=(0,0)`),
        " とすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z|
&= \sqrt{0^2+0^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{上で示した成分による表示と}\ z=(0,0))\\
&= 0
&&(\because\ \text{上の}\ x=0,\ y=0\ \text{の場合の計算})
\end{aligned}`,
      ),
      paragraph([
        "(4) 積の絶対値。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_1z_2|^2
&= \left|(ac-bd,\ ad+bc)\right|^2
&&(\because\ \mathbb{C}\ \text{の積の定義})\\
&= (ac-bd)^2+(ad+bc)^2
&&(\because\ \text{上で示した絶対値の平方})\\
&= (a^2+b^2)(c^2+d^2)
&&(\because\ \text{複素数の乗法群の「積について閉じること」の恒等式})\\
&= |z_1|^2|z_2|^2
&&(\because\ \text{上で示した絶対値の平方。2 箇所へ適用})\\
&= \left(|z_1|\,|z_2|\right)^2
&&(\because\ \mathbb{R}\ \text{の積の可換律と結合律})
\end{aligned}`,
      ),
      paragraph([
        ref("definition_of_cc"),
        "、",
        ref("multiplicative_group_of_cc"),
        "。",
        math(String.raw`|z_1z_2|\ge 0`),
        " かつ ",
        math(String.raw`|z_1|\,|z_2|\ge 0`),
        " であるから、上で示した非負実数の平方の比較より ",
        math(String.raw`|z_1z_2|=|z_1|\,|z_2|`),
        " である。",
      ]),
      paragraph([
        "Lagrange の恒等式。",
        math(String.raw`a,b,c,d\in\mathbb{R}`),
        " について次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(ac+bd)^2+(ad-bc)^2
&= \left(a^2c^2+2abcd+b^2d^2\right)+\left(a^2d^2-2abcd+b^2c^2\right)
&&(\because\ \mathbb{R}\ \text{の分配律。2 箇所へ適用})\\
&= \left(a^2c^2+b^2d^2+a^2d^2+b^2c^2\right)+\left(2abcd+(-2abcd)\right)
&&(\because\ \mathbb{R}\ \text{の和の可換律と結合律})\\
&= \left(a^2c^2+b^2d^2+a^2d^2+b^2c^2\right)+0
&&(\because\ -2abcd\ \text{は}\ 2abcd\ \text{の和の逆元})\\
&= a^2c^2+b^2d^2+a^2d^2+b^2c^2
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})\\
&= (a^2+b^2)(c^2+d^2)
&&(\because\ \mathbb{R}\ \text{の分配律})
\end{aligned}`,
      ),
      paragraph([
        "Cauchy--Schwarz の不等式（2 成分の場合）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(ac+bd)^2
&\le (ac+bd)^2+(ad-bc)^2
&&(\because\ \mathbb{R}\ \text{では平方は非負であることと、和が順序を保つこと})\\
&= (a^2+b^2)(c^2+d^2)
&&(\because\ \text{上で示した Lagrange の恒等式})\\
&= |z_1|^2|z_2|^2
&&(\because\ \text{上で示した絶対値の平方。2 箇所へ適用})\\
&= \left(|z_1|\,|z_2|\right)^2
&&(\because\ \mathbb{R}\ \text{の積の可換律と結合律})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`ac+bd\le 0`),
        " のときは ",
        math(String.raw`ac+bd\le 0\le|z_1|\,|z_2|`),
        " である。",
        math(String.raw`ac+bd>0`),
        " のときは、上で示した非負実数の平方の比較を ",
        math(String.raw`u=ac+bd`),
        "、",
        math(String.raw`v=|z_1|\,|z_2|`),
        " に適用して ",
        math(String.raw`ac+bd\le|z_1|\,|z_2|`),
        " である。いずれの場合も",
      ]),
      displayMath(String.raw`ac+bd\le|z_1|\,|z_2|`),
      paragraph([
        "が成り立つ。",
      ]),
      paragraph([
        "(5) 三角不等式。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
|z_1+z_2|^2
&= \left|(a+c,\ b+d)\right|^2
&&(\because\ \mathbb{C}\ \text{の成分ごとの加法})\\
&= (a+c)^2+(b+d)^2
&&(\because\ \text{上で示した絶対値の平方})\\
&= \left(a^2+b^2\right)+\left(c^2+d^2\right)+2(ac+bd)
&&(\because\ \mathbb{R}\ \text{の分配律と、和の可換律・結合律})\\
&= |z_1|^2+|z_2|^2+2(ac+bd)
&&(\because\ \text{上で示した絶対値の平方。2 箇所へ適用})\\
&\le |z_1|^2+|z_2|^2+2|z_1|\,|z_2|
&&(\because\ \text{上で示した Cauchy--Schwarz の不等式と、和が順序を保つこと})\\
&= \left(|z_1|+|z_2|\right)^2
&&(\because\ \mathbb{R}\ \text{の分配律})
\end{aligned}`,
      ),
      paragraph([
        ref("complex_numbers_form_a_field"),
        "。",
        math(String.raw`|z_1+z_2|\ge 0`),
        " かつ ",
        math(String.raw`|z_1|+|z_2|\ge 0`),
        " であるから、上で示した非負実数の平方の比較より ",
        math(String.raw`|z_1+z_2|\le|z_1|+|z_2|`),
        " である。",
      ]),
      paragraph([
        "(6) 実数の絶対値との一致。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|
&= \left|(x,0)\right|
&&(\because\ \mathbb{R}\ \text{から}\ \mathbb{C}\ \text{への包含写像の定め方})\\
&= \sqrt{x^2+0^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \text{上で示した成分による表示})\\
&= \sqrt{x^2+0}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{を因子にもつ積は}\ 0)\\
&= \sqrt{x^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ 0\ \text{は和の単位元})
\end{aligned}`,
      ),
      paragraph([
        ref("inclusion_rr_to_cc"),
        "。あとは ",
        math(String.raw`x`),
        " の符号で場合を分ける。",
        math(String.raw`x\ge 0`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{x^2}^{(\mathbb{R}_{\ge 0})}
&= x
&&(\because\ x\ge 0\ \text{であり}\ x^2=x^2\text{。平方根の一意性})\\
&= |x|
&&(\because\ x\ge 0\ \text{における実数の絶対値の定め方})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`x<0`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{x^2}^{(\mathbb{R}_{\ge 0})}
&= \sqrt{(-x)^2}^{(\mathbb{R}_{\ge 0})}
&&(\because\ \mathbb{R}\ \text{では}\ (-x)^2=x^2)\\
&= -x
&&(\because\ x<0\ \text{なので}\ -x\ge 0\ \text{であり}\ (-x)^2=(-x)^2\text{。平方根の一意性})\\
&= |x|
&&(\because\ x<0\ \text{における実数の絶対値の定め方})
\end{aligned}`,
      ),
      paragraph([
        "である。いずれの場合も ",
        math(String.raw`\left|\iota_{\mathbb{R}\to\mathbb{C}}(x)\right|=|x|`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。行列ノルムの劣乗法性（labels: matrix_norm_submultiplicativity）の" +
          "証明が K=CC の場合に必要とする絶対値の性質（成分表示・乗法性・三角不等式）を、" +
          "絶対値の定義（labels: def_abs_arg）の直後にまとめて置いた。",
        "2026-08-09: 証明を「一続きの式変形＋行末の (∵ …)」の形へ書き換えた。" +
          "もっとも大きく直したのは 3 点である。第一に、(1) の残り 3 つの場合は" +
          "「x^2+y^2=y^2 であり y>0 すなわち y>=0 かつ y^2=y^2 であるから」のように" +
          "根拠を日本語の地の文へ並べていたので、場合ごとの鎖へ分け、0 を因子にもつ積が 0 であること・" +
          "0 が和の単位元であること・(-y)^2=y^2 であることをそれぞれ別の段にした。" +
          "第二に、Lagrange の恒等式で 2abcd が消える行を、和の逆元と和の単位元の 2 段へ分けた。" +
          "第三に、Cauchy--Schwarz の不等式は原文が (ad-bc)^2>=0 から結論までを日本語で継いでいたので、" +
          "(ac+bd)^2 から (|z_1||z_2|)^2 までの 1 つの鎖にした。" +
          "(4)(5)(6) の各行に欠けていた根拠（積の可換律・結合律、和が順序を保つこと、包含写像の定め方など）も補った。" +
          "段は増えており、減った段は無い。" +
          "あわせて Step 0〜Step 8 の番号を内容の分かる名前へ改め、証明の中の相互参照" +
          "（「Step 2 より」等）も名前で指すようにした（リポジトリの規約「文書・定理を番号や記号で管理しない」）。" +
          "この生成器は \\blkref を定義していないので、(∵ …) の中には引いたブロックの題を書き、" +
          "式の直後に ref で挙げている。",
      ],
    },
  },
  {
    id: "calculation_formulae_032_claim_arg_of_product",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/031_claim_複素数の積のarg.typ", ordinal: 32 },
    title: null,
    labels: ["arg_of_product_of_complex_numbers"],
    statement: [
      paragraph([ref("def_phi_polar"), " と ", ref("section_of_angle_representation"), " を使う。非零性との同値には ", ref("abs_basic_properties"), "、積の計算には ", ref("operations_on_polar_representation"), " を用いる。"]),
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
        "）とする。さらに ",
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        " とする（",
        ref("def_abs_arg"),
        " と ",
        ref("first_and_second_projections"),
        " により ",
        math(String.raw`r_i = |z_i|`),
        " なので、これは ",
        math(String.raw`z_1 \neq 0`),
        " かつ ",
        math(String.raw`z_2 \neq 0`),
        " と同じことである）。このとき",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z_1 z_2) =
\begin{cases}
\arg^{[0,2\pi)}(z_1) + \arg^{[0,2\pi)}(z_2) & (0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi) \\
\arg^{[0,2\pi)}(z_1) + \arg^{[0,2\pi)}(z_2) - 2\pi & (2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi)
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        " を落とすと主張は成り立たない。たとえば ",
        math(String.raw`z_1 = 0`),
        "、",
        math(String.raw`z_2 = (0,1)`),
        " では左辺が ",
        math(String.raw`0`),
        "、右辺が ",
        math(String.raw`\pi/2`),
        " になる。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 2 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は積を保つ。実際 ",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射なモノイド準同型であり、かつ ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " なので、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " の逆写像である。全単射なモノイド準同型の逆写像はモノイド準同型なので",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z_1 z_2)=\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2)`,
      ),
      paragraph([
        "である。第二に、",
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        " なので ",
        math(String.raw`r_1 r_2 \neq 0`),
        " である（実数の積は、因子がどちらも ",
        math(String.raw`0`),
        " でなければ ",
        math(String.raw`0`),
        " でない）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1 z_2)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義。}\blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2))\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim})\right)
&&(\because\ r_i,\theta_i\ \text{の取り方})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1 r_2,\theta_1+\theta_2)]_{\sim})\right)
&&(\because\ \text{極座標表現の演算。}\blkref{operations_on_polar_representation})\\
&= s_{[0,2\pi)}\!\left([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r\neq0\ \text{の場合（}\blkref{first_and_second_projections}\text{）と}\ r_1 r_2\neq0)
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`\theta_1+\theta_2-2(n_1+n_2)\pi`),
        " の値で 2 つに分かれる。",
      ]),
      paragraph([
        math(String.raw`0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi`),
        " のとき。この不等式は ",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数が ",
        math(String.raw`n_1+n_2`),
        " であることを言っているので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}\right)
&= \theta_1+\theta_2-2(n_1+n_2)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、この場合の不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= (\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)+(\theta_2-2n_2\pi)
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi`),
        " のとき。両辺から ",
        math(String.raw`2\pi`),
        " を引けば ",
        math(String.raw`0 \leq \theta_1+\theta_2-2(n_1+n_2+1)\pi < 2\pi`),
        " なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`n_1+n_2+1`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}\right)
&= \theta_1+\theta_2-2(n_1+n_2+1)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、いま見た不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= (\theta_1+\theta_2-2(n_1+n_2)\pi)-2\pi
&&(\because\ 2(n_1+n_2+1)\pi=2(n_1+n_2)\pi+2\pi)\\
&= (\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)-2\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)+(\theta_2-2n_2\pi)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形を一続きにし、根拠を行末の (∵ …) へ移すときに、原文が暗黙に使っていた " +
          "r_1 ≠ 0 かつ r_2 ≠ 0（すなわち z_1 ≠ 0 かつ z_2 ≠ 0）を仮定として明示した。" +
          "第2座標 pr_2 は r = 0 のとき [0] を返すので、この仮定が無いと " +
          "pr_2([(r_1 r_2, θ_1+θ_2)]) = [θ_1+θ_2] の段が成り立たない。" +
          "実際 z_1 = 0、z_2 = (0,1) は反例であり、その旨を statement に書いた。",
      ],
    },
  },
  {
    id: "calculation_formulae_033_claim_arg_of_quotient",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/032_claim_複素数の商のarg.typ", ordinal: 33 },
    title: null,
    labels: ["arg_of_quotient_of_complex_numbers"],
    statement: [
      paragraph([ref("def_phi_polar"), " と ", ref("section_of_angle_representation"), " を使う。非零性との同値には ", ref("abs_basic_properties"), "、積の計算には ", ref("operations_on_polar_representation"), " を用いる。"]),
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        " について、",
        math(String.raw`r_1, r_2 \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta_1, \theta_2 \in \mathbb{R}`),
        " を用いて ",
        math(String.raw`\phi_{\mathrm{polar}}(z_i) = [(r_i,\theta_i)]_{\sim}`),
        " とし、",
        math(String.raw`\arg^{[0,2\pi)}(z_i) = \theta_i - 2n_i\pi`),
        "（",
        math(String.raw`n_i \in \mathbb{Z}`),
        "）とする。さらに ",
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        " とする（",
        ref("def_abs_arg"),
        " と ",
        ref("first_and_second_projections"),
        " により ",
        math(String.raw`r_i = |z_i|`),
        " なので、これは ",
        math(String.raw`z_1 \neq 0`),
        " かつ ",
        math(String.raw`z_2 \neq 0`),
        " と同じことである）。このとき",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{z_1}{z_2}\right) =
\begin{cases}
\arg^{[0,2\pi)}(z_1) - \arg^{[0,2\pi)}(z_2) & (0 \leq \theta_1-\theta_2-2(n_1-n_2)\pi < 2\pi) \\
\arg^{[0,2\pi)}(z_1) - \arg^{[0,2\pi)}(z_2) + 2\pi & (-2\pi < \theta_1-\theta_2-2(n_1-n_2)\pi < 0)
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`r_2 \neq 0`),
        " は商 ",
        math(String.raw`z_1/z_2`),
        " が定まるために要る（",
        ref("multiplicative_group_of_cc"),
        "）。",
        math(String.raw`r_1 \neq 0`),
        " も落とせない。たとえば ",
        math(String.raw`z_1 = 0`),
        "、",
        math(String.raw`z_2 = (0,1)`),
        " では左辺が ",
        math(String.raw`0`),
        "、右辺が ",
        math(String.raw`-\pi/2+2\pi`),
        " になる。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 4 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は積を保つ。実際 ",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射なモノイド準同型であり、かつ ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " なので、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " の逆写像である。全単射なモノイド準同型の逆写像はモノイド準同型なので",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z z')=\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z')`,
      ),
      paragraph([
        "が任意の ",
        math(String.raw`z,z'\in\mathbb{C}`),
        " について成り立つ。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は逆元を逆元へ写す。",
        math(String.raw`r_2\neq0`),
        " すなわち ",
        math(String.raw`z_2\neq 0`),
        " なので ",
        math(String.raw`z_2^{-1}\in\mathbb{C}`),
        " が定まり（",
        ref("multiplicative_group_of_cc"),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{polar}}(z_2)\cdot\phi_{\mathrm{polar}}(z_2^{-1})
&= \phi_{\mathrm{polar}}(z_2\,z_2^{-1})
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと})\\
&= \phi_{\mathrm{polar}}(1_{\mathbb{C}})
&&(\because\ z_2^{-1}\ \text{が}\ z_2\ \text{の逆元であること})\\
&= [(1,0)]_{\sim}
&&(\because\ \text{モノイド準同型の逆写像は単位元を単位元へ写すこと})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって ",
        math(String.raw`\phi_{\mathrm{polar}}(z_2^{-1})`),
        " は ",
        math(String.raw`\phi_{\mathrm{polar}}(z_2)=[(r_2,\theta_2)]_{\sim}`),
        " の逆元であり、",
        ref("multiplicative_group_of_polar_representation"),
        " の逆元の形（",
        math(String.raw`r_2\neq0`),
        " の場合）により",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z_2^{-1})=[(1/r_2,-\theta_2)]_{\sim}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第三に、",
        math(String.raw`r_1\neq0`),
        " かつ ",
        math(String.raw`r_2\neq0`),
        " なので ",
        math(String.raw`r_1/r_2\neq0`),
        " である（実数の商は、分子が ",
        math(String.raw`0`),
        " でなければ ",
        math(String.raw`0`),
        " でない）。",
      ]),
      paragraph([
        "第四に、",
        math(String.raw`\arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi`),
        " と ",
        math(String.raw`\arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi`),
        " はどちらも ",
        math(String.raw`[0,2\pi)`),
        " の元なので（",
        ref("def_abs_arg"),
        "）、その差について",
      ]),
      displayMath(
        String.raw`-2\pi < \theta_1-\theta_2-2(n_1-n_2)\pi < 2\pi`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\frac{z_1}{z_2}\right)
&= \arg^{[0,2\pi)}(z_1 z_2^{-1})
&&(\because\ \mathbb{C}\text{の乗法群 の}\ z^{-1}=1/z\text{。}\blkref{multiplicative_group_of_cc})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2^{-1}))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義。}\blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2^{-1}))\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1,\theta_1)]_{\sim}\cdot[(1/r_2,-\theta_2)]_{\sim})\right)
&&(\because\ r_1,\theta_1\ \text{の取り方と、上で見た}\ \phi_{\mathrm{polar}}(z_2^{-1})\ \text{の形})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1\cdot(1/r_2),\ \theta_1+(-\theta_2))]_{\sim})\right)
&&(\because\ \text{極座標表現の演算。}\blkref{operations_on_polar_representation})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r_1/r_2,\ \theta_1-\theta_2)]_{\sim})\right)
&&(\because\ \mathbb{R}\ \text{の商と差の定義})\\
&= s_{[0,2\pi)}\!\left([\theta_1-\theta_2]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r\neq0\ \text{の場合（}\blkref{first_and_second_projections}\text{）と}\ r_1/r_2\neq0)
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`\theta_1-\theta_2-2(n_1-n_2)\pi`),
        " の値で 2 つに分かれる。第四の準備によりこの値は ",
        math(String.raw`(-2\pi,2\pi)`),
        " にあるので、この 2 つで尽きている。",
      ]),
      paragraph([
        math(String.raw`0 \leq \theta_1-\theta_2-2(n_1-n_2)\pi < 2\pi`),
        " のとき。この不等式は ",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数が ",
        math(String.raw`n_1-n_2`),
        " であることを言っているので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta_1-\theta_2]_{\sim_{\mathrm{angle}}}\right)
&= \theta_1-\theta_2-2(n_1-n_2)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、この場合の不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= (\theta_1-2n_1\pi)-(\theta_2-2n_2\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)-(\theta_2-2n_2\pi)
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)-\arg^{[0,2\pi)}(z_2)
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`-2\pi < \theta_1-\theta_2-2(n_1-n_2)\pi < 0`),
        " のとき。各辺に ",
        math(String.raw`2\pi`),
        " を足せば ",
        math(String.raw`0 < \theta_1-\theta_2-2(n_1-n_2-1)\pi < 2\pi`),
        " なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`n_1-n_2-1`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta_1-\theta_2]_{\sim_{\mathrm{angle}}}\right)
&= \theta_1-\theta_2-2(n_1-n_2-1)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、いま見た不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= (\theta_1-\theta_2-2(n_1-n_2)\pi)+2\pi
&&(\because\ 2(n_1-n_2-1)\pi=2(n_1-n_2)\pi-2\pi)\\
&= (\theta_1-2n_1\pi)-(\theta_2-2n_2\pi)+2\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)-(\theta_2-2n_2\pi)+2\pi
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)-\arg^{[0,2\pi)}(z_2)+2\pi
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は証明が「積の場合と同様の計算による」の一文と、途中の式 1 本と、" +
          "「場合分けして結論を得る」の一文だけで、計算の中身が書かれていなかった。" +
          "積の場合と同じ形の一続きの鎖へ書き下し、各行の末尾へ (∵ …) を付けた。" +
          "原文が暗黙に使っていた段を 4 つ明示した。z_1/z_2 = z_1 z_2^{-1} と読み替える段、" +
          "φ_polar が逆元を逆元へ写すこと（積を保つことと単位元を保つことから出る）、" +
          "極座標表現の逆元の形 [(1/r_2, -θ_2)]、そして差 θ_1-θ_2-2(n_1-n_2)π が " +
          "(-2π, 2π) に入ること（原文は範囲を根拠なく書いていた。arg が [0,2π) の元であることから出る）。" +
          "段は増えており、減った段は無い。" +
          "あわせて、原文の「同様の設定のもと」を書き下し、r_1 ≠ 0 かつ r_2 ≠ 0 を仮定として明示した。" +
          "r_2 ≠ 0 は商が定まるために要り、r_1 ≠ 0 は pr_2 が r = 0 のとき [0] を返すために要る。" +
          "z_1 = 0、z_2 = (0,1) が反例であることを statement に書いた（積の場合と同じ穴である）。" +
          "引用のために「（極座標表現）の乗法群」へラベル multiplicative_group_of_polar_representation を付けた" +
          "（内容は変えていない）。",
      ],
    },
  },
  {
    id: "calculation_formulae_034_claim_range_of_args_when_product_arg_is_pi",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/000_計算公式/033_claim_複素数の積のargがpiのときのarg同士の関係.typ",
      ordinal: 34,
    },
    title: null,
    labels: ["range_of_args_of_multiple_of_complex_numbers"],
    statement: [
      paragraph([ref("def_phi_polar"), "、", ref("def_abs_arg"), " を使い、半径の非零性と複素数の非零性の同値には ", ref("abs_basic_properties"), " を用いる。"]),
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
        "）とする。さらに ",
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        "（すなわち ",
        math(String.raw`z_1 \neq 0`),
        " かつ ",
        math(String.raw`z_2 \neq 0`),
        "）とし、",
        math(String.raw`\arg^{[0,2\pi)}(z_1 z_2) = \pi`),
        " とする。このとき",
      ]),
      displayMath(
        String.raw`\begin{cases}
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) = \pi & (0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi) \\
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2) = \pi+2\pi & (2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi)
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。場合分けの条件に現れる整数は ",
        math(String.raw`n_1+n_2`),
        " であって、条件を満たす整数が存在すること（",
        math(String.raw`\exists m\in\mathbb{Z}`),
        "）ではない。",
        ref("angle_section_existence_uniqueness"),
        " により ",
        math(String.raw`0 \leq \theta_1+\theta_2-2m\pi < 2\pi`),
        " を満たす整数 ",
        math(String.raw`m`),
        " はつねに存在し、同様に ",
        math(String.raw`2\pi \leq \theta_1+\theta_2-2m'\pi < 4\pi`),
        " を満たす整数 ",
        math(String.raw`m'`),
        " もつねに存在する（",
        math(String.raw`m'=m-1`),
        " と取ればよい）ので、存在の形で書くと 2 つの場合がつねに同時に成り立ち、",
        math(String.raw`\pi = \pi+2\pi`),
        " という偽の等式が出てしまう。",
      ]),
      paragraph([
        math(String.raw`r_1 \neq 0`),
        " かつ ",
        math(String.raw`r_2 \neq 0`),
        " が要るのは ",
        ref("arg_of_product_of_complex_numbers"),
        " を使うためである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`0 \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 2\pi`),
        " のとき。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)
&= \arg^{[0,2\pi)}(z_1 z_2)
&&(\because\ \text{この場合の不等式と 複素数の積の}\ \arg\ \text{の主張（}\blkref{arg_of_product_of_complex_numbers}\text{）})\\
&= \pi
&&(\because\ \arg^{[0,2\pi)}(z_1 z_2)=\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。あわせて、この場合の ",
        math(String.raw`\theta_1+\theta_2`),
        " の値も定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\theta_1+\theta_2-2(n_1+n_2)\pi
&= (\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)+(\theta_2-2n_2\pi)
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})\\
&= \pi
&&(\because\ \text{いま示したこと})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`2\pi \leq \theta_1+\theta_2-2(n_1+n_2)\pi < 4\pi`),
        " のとき。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)
&= \left(\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)-2\pi\right)+2\pi
&&(\because\ \mathbb{R}\ \text{の加法の逆元と単位元})\\
&= \arg^{[0,2\pi)}(z_1 z_2)+2\pi
&&(\because\ \text{この場合の不等式と 複素数の積の}\ \arg\ \text{の主張（}\blkref{arg_of_product_of_complex_numbers}\text{）})\\
&= \pi+2\pi
&&(\because\ \arg^{[0,2\pi)}(z_1 z_2)=\pi\ \text{という仮定})
\end{aligned}`,
      ),
      paragraph([
        "である。あわせて、この場合の ",
        math(String.raw`\theta_1+\theta_2`),
        " の値も定まる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\theta_1+\theta_2-2(n_1+n_2+1)\pi
&= (\theta_1+\theta_2-2(n_1+n_2)\pi)-2\pi
&&(\because\ 2(n_1+n_2+1)\pi=2(n_1+n_2)\pi+2\pi)\\
&= (\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)-2\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z_1)+(\theta_2-2n_2\pi)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z_1)=\theta_1-2n_1\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z_2)=\theta_2-2n_2\pi\ \text{という仮定})\\
&= \pi
&&(\because\ \text{いま示したこと})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は証明が「s_{[0,2π)}([θ_1+θ_2]) = π から場合分け」の一文と、" +
          "各場合について「θ_1+θ_2-2(n_1+n_2)π = π ゆえ」という日本語 1 行だけだった。" +
          "各場合を一続きの鎖へ書き下し、各行の末尾へ (∵ …) を付けた。" +
          "「ゆえ」が隠していたのは積の arg の主張そのものなので、" +
          "そこを (∵ …) で題を挙げ、行末の \\blkref（arg_of_product_of_complex_numbers）で引く形にした。" +
          "原文が書いていた等式 θ_1+θ_2-2(n_1+n_2)π = π（第 2 の場合は θ_1+θ_2-2(n_1+n_2+1)π = π）も" +
          "鎖として残してある。段は増えており、減った段は無い。" +
          "あわせて、原文の statement が場合分けの条件を「∃m ∈ Z s.t. 0 ≤ θ_1+θ_2-2mπ < 2π」" +
          "の形で書いていたのを、積の arg の主張と同じ n_1+n_2 の形へ直した。" +
          "存在の形では、角度表現の切断の存在と一意性により 2 つの条件がつねに同時に満たされ" +
          "（第 2 の条件は m' = m-1 で満たせる）、π = π+2π という偽の等式が出てしまうためである。" +
          "その理由を statement に書いた。" +
          "さらに、原文が (r_1, r_2 ≠ 0) と書くだけで r_i, θ_i, n_i を定義していなかったので、" +
          "積の arg の主張と同じ設定を書き下した。",
      ],
    },
  },
  {
    id: "calculation_formulae_035_claim_arg_of_square",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/034_claim_CCの自乗のarg.typ", ordinal: 35 },
    title: { tex: String.raw`\mathbb{C}\text{の自乗の}\arg` },
    labels: ["range_of_args_of_square_of_complex_numbers"],
    statement: [
      paragraph([ref("def_phi_polar"), "、", ref("operations_on_polar_representation"), "、", ref("section_of_angle_representation"), " を用いる。"]),
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " について、",
        math(String.raw`r \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta \in \mathbb{R}`),
        " を用いて ",
        math(String.raw`\phi_{\mathrm{polar}}(z) = [(r,\theta)]_{\sim}`),
        " とし、",
        math(String.raw`\arg^{[0,2\pi)}(z) = \theta - 2n\pi`),
        "（",
        math(String.raw`n \in \mathbb{Z}`),
        "）とする。このとき",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}(z^2) =
\begin{cases}
2\arg^{[0,2\pi)}(z) & (0 \leq \arg^{[0,2\pi)}(z) < \pi) \\
2\arg^{[0,2\pi)}(z) - 2\pi & (\pi \leq \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`\arg^{[0,2\pi)}(z) \in [0,2\pi)`),
        " なので、2 つの場合はちょうど一方だけが成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 1 つ先に置く。",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は積を保つ。実際 ",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射なモノイド準同型であり、かつ ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " なので、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " の逆写像である。全単射なモノイド準同型の逆写像はモノイド準同型なので",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z^2)=\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z)`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`r`),
        " が ",
        math(String.raw`0`),
        " かどうかで分かれる。",
        ref("first_and_second_projections"),
        " の ",
        math(String.raw`\mathrm{pr}_2`),
        " が ",
        math(String.raw`r=0`),
        " のとき ",
        math(String.raw`[0]_{\sim_{\mathrm{angle}}}`),
        " を返す定義になっているためである。",
      ]),
      paragraph([
        math(String.raw`r = 0`),
        " のとき。まず",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義（}\blkref{def_abs_arg}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\theta)]_{\sim})\right)
&&(\because\ r=0\ \text{という、この場合の仮定})\\
&= s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r=0\ \text{の場合（}\blkref{first_and_second_projections}\text{）})\\
&= 0-2\cdot 0\cdot\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と}\ 0\leq 0-2\cdot0\cdot\pi<2\pi)\\
&= 0
&&(\because\ 0\ \text{を因子にもつ積は}\ 0\ \text{であり、}\ 0\ \text{は和の単位元})
\end{aligned}`,
      ),
      paragraph([
        "であり、したがって ",
        math(String.raw`0 \leq \arg^{[0,2\pi)}(z) < \pi`),
        " すなわち第 1 の場合にあたる。一方",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z^2)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z^2))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義（}\blkref{def_abs_arg}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z))\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと（}\blkref{isomorphism_of_phi_cartesian}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\theta)]_{\sim}\cdot[(0,\theta)]_{\sim})\right)
&&(\because\ r=0\ \text{という、この場合の仮定})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0\cdot 0,\theta+\theta)]_{\sim})\right)
&&(\because\ \text{極座標表現の演算（}\blkref{operations_on_polar_representation}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\theta+\theta)]_{\sim})\right)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0)\\
&= s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r=0\ \text{の場合（}\blkref{first_and_second_projections}\text{）})\\
&= 0
&&(\because\ \text{いま見た}\ \arg^{[0,2\pi)}(z)\ \text{の計算の最後の 2 段})\\
&= 2\cdot 0
&&(\because\ 0\ \text{を因子にもつ積は}\ 0)\\
&= 2\arg^{[0,2\pi)}(z)
&&(\because\ \text{いま見た}\ \arg^{[0,2\pi)}(z)=0)
\end{aligned}`,
      ),
      paragraph([
        "であり、主張の第 1 の場合の等式が成り立つ。",
      ]),
      paragraph([
        math(String.raw`r \neq 0`),
        " のとき。",
        math(String.raw`r \neq 0`),
        " なので ",
        math(String.raw`r \cdot r \neq 0`),
        " である（実数の積は、因子がどちらも ",
        math(String.raw`0`),
        " でなければ ",
        math(String.raw`0`),
        " でない）。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z^2)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z^2))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義（}\blkref{def_abs_arg}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z))\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと（}\blkref{isomorphism_of_phi_cartesian}\text{）})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r,\theta)]_{\sim}\cdot[(r,\theta)]_{\sim})\right)
&&(\because\ r,\theta\ \text{の取り方})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(r\cdot r,\theta+\theta)]_{\sim})\right)
&&(\because\ \text{極座標表現の演算（}\blkref{operations_on_polar_representation}\text{）})\\
&= s_{[0,2\pi)}\!\left([\theta+\theta]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r\neq0\ \text{の場合（}\blkref{first_and_second_projections}\text{）と}\ r\cdot r\neq0)
\end{aligned}`,
      ),
      paragraph([
        "である。ここから先は ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " の値でさらに 2 つに分かれる。",
      ]),
      paragraph([
        math(String.raw`0 \leq \theta-2n\pi < \pi`),
        " のとき。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&0 \leq \theta-2n\pi < \pi\\
\Longrightarrow\ &0 \leq 2(\theta-2n\pi) < 2\pi
&&(\because\ \text{各辺に正の数 }2\text{ を掛けても不等号は保たれる})\\
\Longrightarrow\ &0 \leq (\theta+\theta)-2(2n)\pi < 2\pi
&&(\because\ \mathbb{R}\ \text{の分配律})
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`2n`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta+\theta]_{\sim_{\mathrm{angle}}}\right)
&= (\theta+\theta)-2(2n)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、いま見た不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= (\theta-2n\pi)+(\theta-2n\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z)+(\theta-2n\pi)
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z)+\arg^{[0,2\pi)}(z)
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= 2\arg^{[0,2\pi)}(z)
&&(\because\ \mathbb{R}\ \text{の分配律と}\ 1\ \text{が積の単位元であること})
\end{aligned}`,
      ),
      paragraph([
        "である。この場合の条件 ",
        math(String.raw`0 \leq \theta-2n\pi < \pi`),
        " は、仮定 ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " により主張の第 1 の場合の条件 ",
        math(String.raw`0 \leq \arg^{[0,2\pi)}(z) < \pi`),
        " と同じである。",
      ]),
      paragraph([
        math(String.raw`\pi \leq \theta-2n\pi < 2\pi`),
        " のとき。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\pi \leq \theta-2n\pi < 2\pi\\
\Longrightarrow\ &2\pi \leq 2(\theta-2n\pi) < 4\pi
&&(\because\ \text{各辺に正の数 }2\text{ を掛けても不等号は保たれる})\\
\Longrightarrow\ &2\pi \leq (\theta+\theta)-2(2n)\pi < 4\pi
&&(\because\ \mathbb{R}\ \text{の分配律})\\
\Longrightarrow\ &0 \leq (\theta+\theta)-2(2n)\pi-2\pi < 2\pi
&&(\because\ \text{各辺から }2\pi\text{ を引いても不等号は保たれる})\\
\Longrightarrow\ &0 \leq (\theta+\theta)-2(2n+1)\pi < 2\pi
&&(\because\ 2(2n)\pi+2\pi=2(2n+1)\pi)
\end{aligned}`,
      ),
      paragraph([
        "なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`2n+1`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([\theta+\theta]_{\sim_{\mathrm{angle}}}\right)
&= (\theta+\theta)-2(2n+1)\pi
&&(\because\ \text{角度表現の切断 の定義（}\blkref{section_of_angle_representation}\text{）と、いま見た不等式（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= \left((\theta+\theta)-2(2n)\pi\right)-2\pi
&&(\because\ 2(2n+1)\pi=2(2n)\pi+2\pi)\\
&= (\theta-2n\pi)+(\theta-2n\pi)-2\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= \arg^{[0,2\pi)}(z)+(\theta-2n\pi)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= \arg^{[0,2\pi)}(z)+\arg^{[0,2\pi)}(z)-2\pi
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= 2\arg^{[0,2\pi)}(z)-2\pi
&&(\because\ \mathbb{R}\ \text{の分配律と}\ 1\ \text{が積の単位元であること})
\end{aligned}`,
      ),
      paragraph([
        "である。この場合の条件も、仮定 ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " により主張の第 2 の場合の条件 ",
        math(String.raw`\pi \leq \arg^{[0,2\pi)}(z) < 2\pi`),
        " と同じである。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形を一続きにし、根拠を行末の (∵ …) へ移した。原文の証明は " +
          "arg(z²) = s([2θ]) の 1 行と「0 ≤ 2(θ-2nπ) < 4π の場合分けによる」の 1 文だけで、" +
          "φ_polar が積を保つこと・極座標表現の演算・pr_2 の適用・角度表現の切断が" +
          "一意に定める整数の同定がいずれも書かれていなかったので、すべて段として明示した。" +
          "積の場合（arg_of_product_of_complex_numbers）と同じ形に揃えてある。",
        "積の場合と違い、r ≠ 0 を仮定に足していない。主張は r = 0 でも成り立つからである" +
          "（pr_2 が r = 0 で [0] を返すので arg(z) = 0 かつ arg(z²) = 0 となり、" +
          "第 1 の場合の等式 0 = 2·0 が成り立つ）。そこで r = 0 の場合を別の場合として" +
          "先に片付け、r ≠ 0 の場合だけで pr_2([(r·r, θ+θ)]) = [θ+θ] の段を使う形にした。" +
          "成り立つ主張に不要な仮定を足すのは主張を弱めることになるので、そうしなかった。",
        "原文は r, θ, n を導入していなかった（証明の中で θ と n を断りなく使っていた）ので、" +
          "積の場合と同じ設定を statement に書き下した。",
      ],
    },
  },
  {
    id: "calculation_formulae_036_claim_arg_of_reciprocal",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/035_claim_CCの逆数のarg.typ", ordinal: 36 },
    title: { tex: String.raw`\mathbb{C}\text{の逆数の}\arg` },
    labels: ["range_of_args_of_reciprocal_of_complex_numbers"],
    statement: [
      paragraph([ref("def_phi_polar"), " と ", ref("section_of_angle_representation"), " を使い、半径の非零性と複素数の非零性の同値には ", ref("abs_basic_properties"), " を用いる。"]),
      paragraph([
        math(String.raw`z \in \mathbb{C}`),
        " について、",
        math(String.raw`r \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta \in \mathbb{R}`),
        " を用いて ",
        math(String.raw`\phi_{\mathrm{polar}}(z) = [(r,\theta)]_{\sim}`),
        " とし、",
        math(String.raw`\arg^{[0,2\pi)}(z) = \theta - 2n\pi`),
        "（",
        math(String.raw`n \in \mathbb{Z}`),
        "）とする。さらに ",
        math(String.raw`r \neq 0`),
        " とする（",
        ref("def_abs_arg"),
        " と ",
        ref("first_and_second_projections"),
        " により ",
        math(String.raw`r = |z|`),
        " なので、これは ",
        math(String.raw`z \neq 0`),
        " と同じことである）。このとき",
      ]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right) =
\begin{cases}
0 & (\arg^{[0,2\pi)}(z)=0) \\
2\pi - \arg^{[0,2\pi)}(z) & (0<\arg^{[0,2\pi)}(z)<2\pi)
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。",
        math(String.raw`r \neq 0`),
        " は逆数 ",
        math(String.raw`1/z`),
        " が定まるために要る（",
        ref("multiplicative_group_of_cc"),
        "）。",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`\arg^{[0,2\pi)}(z) \in [0,2\pi)`),
        " なので、2 つの場合はちょうど一方だけが成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 3 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は積を保つ。実際 ",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射なモノイド準同型であり、かつ ",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " なので、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " の逆写像である。全単射なモノイド準同型の逆写像はモノイド準同型なので",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z z')=\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z')`,
      ),
      paragraph([
        "が任意の ",
        math(String.raw`z,z'\in\mathbb{C}`),
        " について成り立つ。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " は逆元を逆元へ写す。",
        math(String.raw`r\neq0`),
        " すなわち ",
        math(String.raw`z\neq 0`),
        " なので ",
        math(String.raw`z^{-1}\in\mathbb{C}`),
        " が定まり（",
        ref("multiplicative_group_of_cc"),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z^{-1})
&= \phi_{\mathrm{polar}}(z\,z^{-1})
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと})\\
&= \phi_{\mathrm{polar}}(1_{\mathbb{C}})
&&(\because\ z^{-1}\ \text{が}\ z\ \text{の逆元であること})\\
&= [(1,0)]_{\sim}
&&(\because\ \text{モノイド準同型の逆写像は単位元を単位元へ写すこと})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって ",
        math(String.raw`\phi_{\mathrm{polar}}(z^{-1})`),
        " は ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " の逆元であり、",
        ref("multiplicative_group_of_polar_representation"),
        " の逆元の形（",
        math(String.raw`r\neq0`),
        " の場合）により",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z^{-1})=[(1/r,-\theta)]_{\sim}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第三に、",
        math(String.raw`r\neq0`),
        " なので ",
        math(String.raw`1/r\neq0`),
        " である（実数の商は、分子が ",
        math(String.raw`0`),
        " でなければ ",
        math(String.raw`0`),
        " でない）。",
      ]),
      paragraph([
        "本体に入る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right)
&= \arg^{[0,2\pi)}(z^{-1})
&&(\because\ \mathbb{C}\text{の乗法群 の}\ z^{-1}=1/z\text{。}\blkref{multiplicative_group_of_cc})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z^{-1}))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義。}\blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(1/r,-\theta)]_{\sim})\right)
&&(\because\ \text{上で見た}\ \phi_{\mathrm{polar}}(z^{-1})\ \text{の形})\\
&= s_{[0,2\pi)}\!\left([-\theta]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r\neq0\ \text{の場合と}\ 1/r\neq0\text{。}\blkref{first_and_second_projections})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " の値で 2 つに分かれる。",
        ref("def_abs_arg"),
        " よりこの値は ",
        math(String.raw`[0,2\pi)`),
        " にあるので、この 2 つで尽きている。",
      ]),
      paragraph([
        math(String.raw`\theta-2n\pi = 0`),
        " のとき。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-\theta-2(-n)\pi
&= -(\theta-2n\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= 0
&&(\because\ \theta-2n\pi = 0\ \text{という、この場合の条件})
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`0 \leq 0 < 2\pi`),
        " なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`-n`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([-\theta]_{\sim_{\mathrm{angle}}}\right)
&= -\theta-2(-n)\pi
&&(\because\ \text{角度表現の切断 の定義と、いま見た不等式。}\blkref{section_of_angle_representation}\ \blkref{angle_section_existence_uniqueness})\\
&= -(\theta-2n\pi)
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= -\arg^{[0,2\pi)}(z)
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= -0
&&(\because\ \arg^{[0,2\pi)}(z)=0\ \text{という、この場合の条件})\\
&= 0
&&(\because\ 0\ \text{の加法の逆元は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "である。この場合の条件 ",
        math(String.raw`\theta-2n\pi=0`),
        " は、仮定 ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " により主張の第 1 の場合の条件 ",
        math(String.raw`\arg^{[0,2\pi)}(z)=0`),
        " と同じである。",
      ]),
      paragraph([
        math(String.raw`0 < \theta-2n\pi < 2\pi`),
        " のとき。各辺に ",
        math(String.raw`-1`),
        " を掛けて向きを入れ替えると ",
        math(String.raw`-2\pi < -(\theta-2n\pi) < 0`),
        " であり、さらに各辺へ ",
        math(String.raw`2\pi`),
        " を足せば ",
        math(String.raw`0 < -\theta-2(-n-1)\pi < 2\pi`),
        " なので、",
        ref("angle_section_existence_uniqueness"),
        " が一意に定める整数は ",
        math(String.raw`-n-1`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_{[0,2\pi)}\!\left([-\theta]_{\sim_{\mathrm{angle}}}\right)
&= -\theta-2(-n-1)\pi
&&(\because\ \text{角度表現の切断 の定義と、いま見た不等式。}\blkref{section_of_angle_representation}\ \blkref{angle_section_existence_uniqueness})\\
&= \left(-\theta-2(-n)\pi\right)+2\pi
&&(\because\ 2(-n-1)\pi=2(-n)\pi-2\pi)\\
&= -(\theta-2n\pi)+2\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律と分配律})\\
&= -\arg^{[0,2\pi)}(z)+2\pi
&&(\because\ \arg^{[0,2\pi)}(z)=\theta-2n\pi\ \text{という仮定})\\
&= 2\pi-\arg^{[0,2\pi)}(z)
&&(\because\ \mathbb{R}\ \text{の加法の交換律と差の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。この場合の条件も、仮定 ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " により主張の第 2 の場合の条件 ",
        math(String.raw`0<\arg^{[0,2\pi)}(z)<2\pi`),
        " と同じである。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形を一続きにし、根拠を行末の (∵ …) へ移した。原文の証明は 3 つの等号を並べた式 1 本と、" +
          "「0 ≤ θ-2nπ < 2π より -2π < -θ+2nπ ≤ 0 を場合分けして結論を得る」の 1 文だけで、" +
          "φ_polar が逆元を逆元へ写すこと・極座標表現の逆元の形・pr_2 の適用・" +
          "角度表現の切断が一意に定める整数の同定がいずれも書かれていなかったので、" +
          "すべて段として明示した。商の場合（arg_of_quotient_of_complex_numbers）と" +
          "同じ形（準備 3 つ・本体の 4 段の鎖・場合ごとの 5 段の鎖）へ揃えてある。" +
          "段は増えており、減った段は無い。",
        "自乗の場合（range_of_args_of_square_of_complex_numbers）と違い、r ≠ 0 を仮定に足した。" +
          "自乗では r = 0 でも主張が成り立つので足さなかったが、逆数では z = 0 のとき 1/z が" +
          "そもそも定まらない（ℂ の乗法群）。すなわちこれは主張を弱める仮定ではなく、" +
          "主張が意味を持つために要る仮定である。商の場合の r_2 ≠ 0 と同じ扱いにした。",
        "原文は r, θ, n を導入せずに証明の中で θ と n を使っていたので、" +
          "商の場合と同じ設定を statement に書き下した。",
        "原文の場合分けの範囲 -2π < -θ+2nπ ≤ 0 は、arg(z) = θ-2nπ ∈ [0,2π) から出る。" +
          "本文ではこれを「arg(z) = 0 の場合」と「0 < arg(z) < 2π の場合」の 2 つに書き直した。" +
          "主張の場合分けが arg(z) の値で書かれているので、そちらに揃えた方が" +
          "どちらの場合の等式を示しているのかが一目で分かるためである。",
      ],
    },
  },
  // 旧 calculation_formulae_037（arg 計算のコツ）は計算の進め方の助言であって主張ではないため、
  // notes/000_calculation_formulae.ts（targets: arg_of_product_of_complex_numbers）へ移設した。
  {
    id: "calculation_formulae_038_definition_sqrt_of_complex_number",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/000_計算公式/037_definition_CCのsqrt_複素数の平方根の定義.typ",
      ordinal: 38,
    },
    title: { tex: String.raw`\mathbb{C}\text{の}\sqrt{\cdot}` },
    labels: ["def_sqrt_cc"],
    statement: [
      paragraph([ref("definition_of_sqrt_r_positive"), "、", ref("def_phi_polar"), "、", ref("def_phi_cartesian"), "、", ref("first_and_second_projections"), "、", ref("section_of_angle_representation"), "、", ref("polar_equivalence_class"), " を用いる。半角の値域は ", math(String.raw`[0,\pi)`), " であり、現行の正弦・余弦の定義域を超える。逆方向写像が未完のため、以下の平方根写像の定義も未完である。"]),
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
    origin: { path: "_old/typst/parts/000_計算公式/038_claim_CCのsqrtの極座標表現による展開.typ", ordinal: 39 },
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
      paragraph(["証明の中で使うものを 2 つ先に置く。"]),
      paragraph([
        "第一に、",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        " を満たす ",
        math(String.raw`n\in\mathbb{Z}`),
        " は各 ",
        math(String.raw`\theta\in\mathbb{R}`),
        " に対してただ一つ存在する（",
        ref("angle_section_existence_uniqueness"),
        "）。この一意性により ",
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
        "第二に、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\sqrt{0}^{\,\mathbb{R}_{\ge 0}}=0`),
        " である。",
      ]),
      paragraph([
        "主張の右辺が代表元 ",
        math(String.raw`(r,\theta)`),
        " の取り方によらないことを先に見る。",
        math(String.raw`(r,\theta)\sim(r',\theta')`),
        " とし、",
        math(String.raw`n,n'\in\mathbb{Z}`),
        " をそれぞれ ",
        math(String.raw`0\le\theta-2n\pi<2\pi`),
        "、",
        math(String.raw`0\le\theta'-2n'\pi<2\pi`),
        " を満たすもの（準備の第一により一意）とする。",
        ref("polar_equivalence_class"),
        " より次の 2 つの場合がある。",
      ]),
      paragraph([
        math(String.raw`r=r'=0`),
        " のとき。準備の第二より両辺の内側の対はそれぞれ ",
        math(String.raw`(0,\theta/2-n\pi)`),
        " と ",
        math(String.raw`(0,\theta'/2-n'\pi)`),
        " であり、第 1 成分がともに ",
        math(String.raw`0`),
        " なので ",
        ref("polar_equivalence_class"),
        "（",
        math(String.raw`r=r'=0`),
        " の場合）により同値、すなわち同じ同値類を定める。",
      ]),
      paragraph([
        math(String.raw`r=r'`),
        " かつ ",
        math(String.raw`\theta\sim_{\mathrm{angle}}\theta'`),
        " のとき。",
        ref("angle_equivalence_class"),
        " より ",
        math(String.raw`\theta-\theta'=2k\pi`),
        " なる ",
        math(String.raw`k\in\mathbb{Z}`),
        " が存在する。このとき ",
        math(String.raw`\theta-2(n'+k)\pi=\theta'-2n'\pi\in[0,2\pi)`),
        " かつ ",
        math(String.raw`n'+k\in\mathbb{Z}`),
        " なので、準備の第一の一意性より ",
        math(String.raw`n=n'+k`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\theta}{2}-n\pi
&= \frac{\theta'+2k\pi}{2}-(n'+k)\pi
&&(\because\ \theta=\theta'+2k\pi\ \text{（}\blkref{angle_equivalence_class}\text{）と}\ n=n'+k\ \text{（}\blkref{angle_section_existence_uniqueness}\text{）})\\
&= \frac{\theta'}{2}+k\pi-(n'+k)\pi
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= \frac{\theta'}{2}+k\pi-n'\pi-k\pi
&&(\because\ \mathbb{R}\ \text{の分配律})\\
&= \frac{\theta'}{2}-n'\pi
&&(\because\ \mathbb{R}\ \text{の加法の結合律・交換律})
\end{aligned}`,
      ),
      paragraph([
        "であり、第 1 成分も ",
        math(String.raw`\sqrt{r}^{\,\mathbb{R}_{\ge 0}}=\sqrt{r'}^{\,\mathbb{R}_{\ge 0}}`),
        " で一致するから、両者は同じ対であり同じ同値類を定める。いずれの場合も右辺は代表元によらない。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`r`),
        " の値で 2 つに分かれる。",
      ]),
      paragraph([
        math(String.raw`r\ne 0`),
        " のとき。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left(\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))\right)\right)\right]_{\sim}\right)
&&(\because\ \mathbb{C}\ \text{の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{def_sqrt_cc})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left(\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))\right)\right)\right]_{\sim}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ \operatorname{pr}_1\ \text{と}\ \phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}\text{。}\blkref{first_and_second_projections})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left([\theta]_{\sim_{\mathrm{angle}}}\right)\right)\right]_{\sim}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ \operatorname{pr}_2\ \text{の}\ r\ne0\ \text{の場合。}\blkref{first_and_second_projections})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}(\theta-2n\pi)\right)\right]_{\sim}\right)
&&(\because\ \text{準備の第一。}\blkref{angle_section_existence_uniqueness})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&&(\because\ \mathbb{R}\ \text{の分配律})
\end{aligned}`,
      ),
      paragraph([
        "であり、これは主張の右辺そのものである。",
      ]),
      paragraph([
        math(String.raw`r=0`),
        " のとき。まず左辺を計算する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sqrt{z}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\operatorname{pr}_1(\phi_{\mathrm{polar}}(z))}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left(\operatorname{pr}_2(\phi_{\mathrm{polar}}(z))\right)\right)\right]_{\sim}\right)
&&(\because\ \mathbb{C}\ \text{の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{def_sqrt_cc})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{0}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)\right)\right]_{\sim}\right)
&&(\because\ \text{第1座標, 第2座標 の}\ r=0\ \text{の場合。}\blkref{first_and_second_projections})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{1}{2}\cdot s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)\right)\right]_{\sim}\right)
&&(\because\ \text{準備の第二。}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{1}{2}\cdot 0\right)\right]_{\sim}\right)
&&(\because\ 0\le 0-2\cdot0\cdot\pi<2\pi\ \text{と準備の第一})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[(0,0)\right]_{\sim}\right)
&&(\because\ \mathbb{R}\ \text{で}\ a\cdot 0=0)\\
&= (0\cdot\cos 0,\ 0\cdot\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (0,0)=0_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{で}\ 0\cdot a=0)
\end{aligned}`,
      ),
      paragraph(["次に右辺を計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{0}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&&(\because\ r=0\ \text{という、この場合の条件})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&&(\because\ \text{準備の第二。}\blkref{definition_of_sqrt_r_positive})\\
&= \left(0\cdot\cos\!\left(\tfrac{\theta}{2}-n\pi\right),\ 0\cdot\sin\!\left(\tfrac{\theta}{2}-n\pi\right)\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (0,0)=0_{\mathbb{C}}
&&(\because\ \mathbb{R}\ \text{で}\ 0\cdot a=0)
\end{aligned}`,
      ),
      paragraph([
        "であり、両辺は一致する。",
        math(String.raw`\cos,\sin`),
        " の値は ",
        math(String.raw`\mathbb{R}`),
        " の元なので、最後の段は ",
        math(String.raw`\mathbb{R}`),
        " の中の計算である。",
      ]),
      paragraph([
        "以上より、",
        math(String.raw`r\ne 0`),
        " と ",
        math(String.raw`r=0`),
        " のいずれの場合も主張の等式が成り立つ。右辺は代表元の取り方によらないので、主張は ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " なる任意の代表元 ",
        math(String.raw`(r,\theta)`),
        " について成り立つ。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形を一続きにし、根拠を行末の (∵ …) へ移した。原文は Step 1 から Step 5 までの " +
          "5 段構成で、式と式の間に日本語の説明が挟まっていた。準備（n の一意性から出る " +
          "s_{[0,2π)}([θ]) = θ-2nπ と、√0 = 0）を冒頭にまとめ、そのうえで代表元によらないこと・" +
          "r ≠ 0 の場合・r = 0 の場合の計算をそれぞれ一続きの鎖にした。" +
          "段は増えており、減った段は無い（r = 0 の場合は左辺 7 段・右辺 4 段へ、" +
          "代表元によらないことの計算は 4 段へ、それぞれ書き下した）。",
        "原文が Step 番号で並べていた「準備」と「本体」を分けた。Step 1（n の一意性）と " +
          "√0 = 0 は式変形ではなく準備なので冒頭へ移し、Step 2（代表元によらないこと）・" +
          "Step 3（r ≠ 0）・Step 4（r = 0）・Step 5（結論）は、独立した中間目標なので " +
          "そのまま順に置いた（番号は外し、条件で呼ぶ形にした）。",
        "原文が 1 本の式に 3 つの等号を並べていた θ/2 - nπ の計算を、1 行 1 等号の 4 段へ割った。" +
          "原文は θ = θ'+2kπ と n = n'+k をどちらの段で使ったのかが式に書かれていなかった。",
        "主張と仮定は変えていない（r ≠ 0 の仮定を足す必要はない。r = 0 でも主張は成り立ち、" +
          "原文もその場合を Step 4 で扱っている）。",
      ],
    },
  },
  {
    id: "calculation_formulae_040_claim_sqrt_commutativity_condition",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/000_計算公式/039_claim_sqrtと積が可換になる条件_argの範囲による場合分け.typ",
      ordinal: 40,
    },
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
        "証明の中で使うものを 3 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " は全単射なモノイド準同型であり、",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " なので ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " はその逆写像である。全単射なモノイド準同型の逆写像はモノイド準同型なので",
      ]),
      displayMath(
        String.raw`\phi_{\mathrm{polar}}(z_1 z_2)=\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2)`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第二に、",
        ref("operations_on_polar_representation"),
        " より",
      ]),
      displayMath(
        String.raw`[(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}=[(r_1 r_2,\ \theta_1+\theta_2)]_{\sim}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第三に、",
        ref("angle_section_existence_uniqueness"),
        " より、各 ",
        math(String.raw`\theta\in\mathbb{R}`),
        " に対して ",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " を満たす ",
        math(String.raw`n\in\mathbb{Z}`),
        " がただ一つ存在する。この一意性により、",
        ref("section_of_angle_representation"),
        " の ",
        math(String.raw`s_{[0,2\pi)}`),
        " について ",
        math(String.raw`s_{[0,2\pi)}([\theta]_{\sim_{\mathrm{angle}}})=\theta-2n\pi`),
        " が成り立つ。",
      ]),
      paragraph([
        "ここから先は ",
        math(String.raw`r_1 r_2`),
        " が ",
        math(String.raw`0`),
        " かどうかで分かれる。",
        ref("first_and_second_projections"),
        " の ",
        math(String.raw`\mathrm{pr}_2`),
        " が ",
        math(String.raw`r=0`),
        " のとき ",
        math(String.raw`[0]_{\sim_{\mathrm{angle}}}`),
        " を返す定義になっているため、",
        math(String.raw`\mathrm{pr}_2([(r,\theta)]_{\sim})=[\theta]_{\sim_{\mathrm{angle}}}`),
        " と書けるのは ",
        math(String.raw`r\neq 0`),
        " のときだけだからである。",
      ]),
      paragraph([
        math(String.raw`r_1=0`),
        " または ",
        math(String.raw`r_2=0`),
        " のとき。まず左辺は",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1 z_2}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1 z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2)))\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{def_sqrt_cc})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2)))\right)\right]_{\sim}\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと。}\blkref{isomorphism_of_phi_cartesian})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}))\right)\right]_{\sim}\right)
&&(\because\ r_1,r_2,\theta_1,\theta_2\ \text{の取り方})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1([(r_1 r_2,\theta_1+\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1 r_2,\theta_1+\theta_2)]_{\sim}))\right)\right]_{\sim}\right)
&&(\because\ \text{極座標表現の積。}\blkref{operations_on_polar_representation})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})\right)\right]_{\sim}\right)
&&(\because\ \text{第1座標, 第2座標 の定義と}\ r_1 r_2=0\ \blkref{first_and_second_projections})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{1}{2}\cdot s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})\right)\right]_{\sim}\right)
&&(\because\ r_1 r_2=0\ \text{と非負実数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{definition_of_sqrt_r_positive})\\
&= \left(0\cdot\cos\tfrac{1}{2}s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}}),\ 0\cdot\sin\tfrac{1}{2}s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (0,0)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r_1=0`),
        " の場合は右辺の第 1 因子が",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r_1}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{\theta_1}{2}-n_1\pi\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{の極座標表現による展開。}\blkref{sqrt_expansion_via_polar})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(0,\ \tfrac{\theta_1}{2}-n_1\pi\right)\right]_{\sim}\right)
&&(\because\ r_1=0\ \text{と非負実数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{definition_of_sqrt_r_positive})\\
&= \left(0\cdot\cos\left(\tfrac{\theta_1}{2}-n_1\pi\right),\ 0\cdot\sin\left(\tfrac{\theta_1}{2}-n_1\pi\right)\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (0,0)
&&(\because\ 0\ \text{を因子にもつ積は}\ 0)
\end{aligned}`),
      paragraph([
        "となる。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1}\sqrt{z_2}
&= (0,0)\cdot\sqrt{z_2}
&&(\because\ \sqrt{z_1}=(0,0)\ \text{という直前の計算})\\
&= (0,0)
&&(\because\ \mathbb{C}\ \text{の零元を因子にもつ積は零元})
\end{aligned}`),
      paragraph([
        math(String.raw`(0,0)`),
        " は ",
        math(String.raw`\mathbb{C}`),
        " の零元である。",
        math(String.raw`r_2=0`),
        " の場合も第 2 因子について同じ計算になる。したがってこの場合",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1 z_2}
&= (0,0)
&&(\because\ \text{上で計算した左辺})\\
&= \sqrt{z_1}\sqrt{z_2}
&&(\because\ r_1=0\ \text{または}\ r_2=0\ \text{のときの直前の計算})
\end{aligned}`),
      paragraph([
        "この場合が主張のどちらの場合にあたるかも見ておく。",
        math(String.raw`r_1=0`),
        " なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義。}\blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\theta_1)]_{\sim})\right)
&&(\because\ r_1=0\ \text{という、この場合の仮定})\\
&= s_{[0,2\pi)}\!\left([0]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の定義。}\blkref{first_and_second_projections})\\
&= 0
&&(\because\ \text{角度切断の一意性を}\ \theta=0,\ n=0\ \text{へ当てた。}\blkref{angle_section_existence_uniqueness})
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_abs_arg"),
        " より ",
        math(String.raw`\arg^{[0,2\pi)}(z_2)\in[0,2\pi)`),
        " なので ",
        math(String.raw`0\leq\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)<2\pi`),
        " すなわち主張の第 1 の場合にあたり、いま示した等式はその場合の等式である。",
        math(String.raw`r_2=0`),
        " の場合も同じである。",
      ]),
      paragraph([
        math(String.raw`r_1\neq 0`),
        " かつ ",
        math(String.raw`r_2\neq 0`),
        " のとき。実数の積は因子がどちらも ",
        math(String.raw`0`),
        " でなければ ",
        math(String.raw`0`),
        " でないので ",
        math(String.raw`r_1 r_2\neq 0`),
        " である。",
        math(String.raw`n_1,n_2\in\mathbb{Z}`),
        " を ",
        math(String.raw`0\leq\theta_1-2n_1\pi<2\pi`),
        "、",
        math(String.raw`0\leq\theta_2-2n_2\pi<2\pi`),
        " を満たすもの（準備の第三によりそれぞれただ一つ存在する）とする。まず左辺は",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1 z_2}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1 z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1 z_2)))\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{def_sqrt_cc})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2))}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1)\cdot\phi_{\mathrm{polar}}(z_2)))\right)\right]_{\sim}\right)
&&(\because\ \phi_{\mathrm{polar}}\ \text{が積を保つこと。}\blkref{isomorphism_of_phi_cartesian})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1,\theta_1)]_{\sim}\cdot[(r_2,\theta_2)]_{\sim}))\right)\right]_{\sim}\right)
&&(\because\ r_1,r_2,\theta_1,\theta_2\ \text{の取り方})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{\mathrm{pr}_1([(r_1 r_2,\theta_1+\theta_2)]_{\sim})}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}(\mathrm{pr}_2([(r_1 r_2,\theta_1+\theta_2)]_{\sim}))\right)\right]_{\sim}\right)
&&(\because\ \text{極座標表現の積。}\blkref{operations_on_polar_representation})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}\cdot s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})\right)\right]_{\sim}\right)
&&(\because\ \text{第1座標, 第2座標 の定義と}\ r_1 r_2\neq 0\ \blkref{first_and_second_projections})\\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})
\end{aligned}`),
      paragraph([
        "である。次に右辺は",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z_1}\sqrt{z_2}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r_1}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\right)\right]_{\sim}\right)\cdot
\phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r_2}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{と第1座標, 第2座標 の定義を}\ r_1,r_2\neq 0\ \text{へ当てた。}\blkref{def_sqrt_cc}\blkref{first_and_second_projections})\\
&= \left(\sqrt{r_1}^{\,\mathbb{R}_{\geq 0}}\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_1}^{\,\mathbb{R}_{\geq 0}}\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\right)\cdot
\left(\sqrt{r_2}^{\,\mathbb{R}_{\geq 0}}\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}}),\ \sqrt{r_2}^{\,\mathbb{R}_{\geq 0}}\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\!\left(\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})-\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right),\right.\\
&\qquad\left.\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\!\left(\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})+\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)\right)
&&(\because\ \mathbb{C}\ \text{の積の定義と}\ \sqrt{r_1}^{\,\mathbb{R}_{\geq 0}}\sqrt{r_2}^{\,\mathbb{R}_{\geq 0}}=\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}})\\
&= \left(\sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\cos\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right),\ \sqrt{r_1 r_2}^{\,\mathbb{R}_{\geq 0}}\sin\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)\right)
&&(\because\ \text{三角関数の加法定理})
\end{aligned}`),
      paragraph([
        "である。両者を比べるために、右辺に現れる角を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
&= \tfrac{1}{2}\!\left((\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)\right)
&&(\because\ \text{角度切断の一意性を}\ \theta_1,\theta_2\ \text{へ当てた。}\blkref{angle_section_existence_uniqueness})\\
&= \tfrac{1}{2}\!\left(\theta_1+\theta_2-2(n_1+n_2)\pi\right)
&&(\because\ \text{実数の加法の交換則・結合則と分配則})\\
&= \tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi
&&(\because\ \text{実数の分配則})
\end{aligned}`),
      paragraph([
        "また、",
      ]),
      displayMath(String.raw`\begin{aligned}
&0\leq\theta_1-2n_1\pi<2\pi,\qquad 0\leq\theta_2-2n_2\pi<2\pi\\
\Longrightarrow\ &0\leq(\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)<4\pi
&&(\because\ \text{二つの不等式の辺々を加えた})\\
\Longrightarrow\ &0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<4\pi
&&(\because\ \mathbb{R}\ \text{の加法の交換則・結合則と分配則})
\end{aligned}`),
      paragraph(["であるから、ここで場合を 2 つに分ける。"]),
      paragraph([
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2)\pi<2\pi`),
        " の場合。左辺に現れる角は",
      ]),
      displayMath(String.raw`\begin{aligned}
\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \tfrac{1}{2}\!\left(\theta_1+\theta_2-2(n_1+n_2)\pi\right)
&&(\because\ \text{角度切断の一意性を}\ \theta=\theta_1+\theta_2,\ n=n_1+n_2\ \text{へ当てた。いまの場合分けがその範囲の条件である。}\blkref{angle_section_existence_uniqueness})\\
&= \tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi
&&(\because\ \text{実数の分配則})
\end{aligned}`),
      paragraph([
        "であり、右辺に現れる角と一致する。したがって左辺と右辺の 2 つの成分がそれぞれ一致し、",
        math(String.raw`\sqrt{z_1 z_2}=\sqrt{z_1}\sqrt{z_2}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`2\pi\leq\theta_1+\theta_2-2(n_1+n_2)\pi<4\pi`),
        " の場合。このとき ",
        math(String.raw`0\leq\theta_1+\theta_2-2(n_1+n_2+1)\pi<2\pi`),
        " なので、左辺に現れる角は",
      ]),
      displayMath(String.raw`\begin{aligned}
\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \tfrac{1}{2}\!\left(\theta_1+\theta_2-2(n_1+n_2+1)\pi\right)
&&(\because\ \text{角度切断の一意性を}\ \theta=\theta_1+\theta_2,\ n=n_1+n_2+1\ \text{へ当てた。}\blkref{angle_section_existence_uniqueness})\\
&= \tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi-\pi
&&(\because\ \text{実数の分配則})
\end{aligned}`),
      paragraph([
        "である。したがって左辺の 2 つの成分は",
      ]),
      displayMath(String.raw`\begin{aligned}
\cos\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \cos\left(\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right)-\pi\right)
&&(\because\ \text{いま計算した角})\\
&= -\cos\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right)
&&(\because\ \cos(x-\pi)=-\cos x)\\
&= -\cos\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
&&(\because\ \text{右辺に現れる角の計算})
\end{aligned}`),
      paragraph([
        "および",
      ]),
      displayMath(String.raw`\begin{aligned}
\sin\tfrac{1}{2}s_{[0,2\pi)}([\theta_1+\theta_2]_{\sim_{\mathrm{angle}}})
&= \sin\left(\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right)-\pi\right)
&&(\because\ \text{いま計算した角})\\
&= -\sin\left(\tfrac{\theta_1+\theta_2}{2}-(n_1+n_2)\pi\right)
&&(\because\ \sin(x-\pi)=-\sin x)\\
&= -\sin\tfrac{1}{2}\!\left(s_{[0,2\pi)}([\theta_1]_{\sim_{\mathrm{angle}}})+s_{[0,2\pi)}([\theta_2]_{\sim_{\mathrm{angle}}})\right)
&&(\because\ \text{右辺に現れる角の計算})
\end{aligned}`),
      paragraph([
        "となり、2 つの成分がどちらも符号を変えたものになるので ",
        math(String.raw`\sqrt{z_1 z_2}=-\sqrt{z_1}\sqrt{z_2}`),
        " である。",
      ]),
      paragraph([
        "最後に、場合分けの条件を主張の形へ書き直す。",
        math(String.raw`r_1\neq 0`),
        " かつ ",
        math(String.raw`r_2\neq 0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z_1)+\arg^{[0,2\pi)}(z_2)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_1))\right)+s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(z_2))\right)
&&(\because\ \text{絶対値, 偏角 の}\ \arg^{[0,2\pi)}\ \text{の定義。}\blkref{def_abs_arg})\\
&= s_{[0,2\pi)}\!\left([\theta_1]_{\sim_{\mathrm{angle}}}\right)+s_{[0,2\pi)}\!\left([\theta_2]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第1座標, 第2座標 の定義と}\ r_1,r_2\neq 0\ \blkref{first_and_second_projections})\\
&= (\theta_1-2n_1\pi)+(\theta_2-2n_2\pi)
&&(\because\ \text{角度切断の一意性。}\blkref{angle_section_existence_uniqueness})\\
&= \theta_1+\theta_2-2(n_1+n_2)\pi
&&(\because\ \text{実数の加法の交換則・結合則と分配則})
\end{aligned}`),
      paragraph(["なので、2 つの場合分けの条件は主張の 2 つの場合の条件と一致する。"]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-09-03）: 二つの角度切断の不等式を足して場合分けの範囲を得る操作を、散文から二段の含意の鎖へ開いた。内容・根拠・参照は変えていない。",
        "式変形を一続きにし、根拠を行末の (∵ …) へ移した。原文は 2 つの長い式変形の間と " +
          "場合分けの間に日本語の説明が挟まっており、各行の根拠（φ_polar が積を保つこと・" +
          "極座標表現の演算・pr_1 と pr_2 の適用・φ_cartesian の定義・三角関数の加法定理・" +
          "角度表現の切断が一意に定める整数の同定）が書かれていなかったので、すべて段として明示した。" +
          "段は増えており、減った段は無い。",
        "原文の場合分けの順序を変えた。原文は 2 つの式変形を先に済ませてから r_1 r_2 = 0 かどうかで " +
          "分けていたが、pr_2([(r,θ)]) = [θ] と書けるのは r ≠ 0 のときだけである" +
          "（第1座標, 第2座標 の pr_2 は r = 0 で [0] を返す）。原文の第 1 の式変形はこの段を " +
          "r_1 r_2 = 0 の場合にも当てており、そこだけ正しくなかった（結論は第 1 成分が 0 に " +
          "なるので変わらない）。そこで r_1 r_2 が 0 かどうかで先に分け、0 でない場合だけで " +
          "その段を使う形にした。",
        "原文が書いていなかった「r_1 = 0 または r_2 = 0 の場合が主張のどちらの場合にあたるか」を " +
          "足した。主張は場合ごとに符号が違うので、どちらの場合かを言わないと等式が主張のどの行に " +
          "対応するのか決まらない。r_1 = 0 なら arg(z_1) = 0 であり、arg(z_2) ∈ [0,2π) なので " +
          "第 1 の場合（符号が +1 の場合）にあたる。",
        "cos と sin の符号反転を、原文の「n_1+n_2 の偶奇による場合分け」ではなく " +
          "cos(x-π) = -cos x、sin(x-π) = -sin x で書いた。原文は偶奇の場合分けを 2 度（右辺と左辺で）" +
          "行っており、同じ角の比較なら偶奇に踏み込む必要がないためである。" +
          "主張と仮定は変えていない。",
        "引いた定義・主張の参照は、それを適用した各式変形行の行末へ置いた。",
      ],
    },
  },
  {
    id: "calculation_formulae_041_claim_sqrt_squared_is_original",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/040_claim_sqrtの2乗は元に戻る.typ", ordinal: 41 },
    title: { text: "sqrt の2乗は元に戻る" },
    labels: ["sqrt_squared_is_original"],
    statement: [
      paragraph([math(String.raw`z \in \mathbb{C}`), " について、", math(String.raw`\sqrt{z}\sqrt{z}=z`)]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 3 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " を ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " なる代表元とし（",
        ref("def_phi_polar"),
        "、",
        ref("polar_equivalence_class"),
        "）、",
        math(String.raw`n\in\mathbb{Z}`),
        " を ",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " を満たすものとする（",
        ref("angle_section_existence_uniqueness"),
        " により各 ",
        math(String.raw`\theta\in\mathbb{R}`),
        " に対してただ一つ存在する）。",
      ]),
      paragraph([
        "第二に、",
        ref("isomorphism_of_phi_cartesian"),
        " より ",
        math(String.raw`\phi_{\mathrm{cartesian}}`),
        " はモノイド準同型であり、",
        math(String.raw`\phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        "第三に、",
        ref("polar_equivalence_class"),
        " の同値関係 ",
        math(String.raw`\sim`),
        " は第 2 成分の ",
        math(String.raw`2\pi`),
        " の整数倍の差を同一視するので、",
        math(String.raw`[(r,\theta-2n\pi)]_{\sim}=[(r,\theta)]_{\sim}`),
        " である。",
      ]),
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{z}\sqrt{z}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
   \cdot\phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{の極座標表現による展開。}\blkref{sqrt_expansion_via_polar})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}
   \cdot\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\ \tfrac{\theta}{2}-n\pi\right)\right]_{\sim}\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{が積を保つこと。}\blkref{isomorphism_of_phi_cartesian})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{r}^{\,\mathbb{R}_{\geq 0}}\cdot\sqrt{r}^{\,\mathbb{R}_{\geq 0}},\ \left(\tfrac{\theta}{2}-n\pi\right)+\left(\tfrac{\theta}{2}-n\pi\right)\right)\right]_{\sim}\right)
&&(\because\ \text{極座標表現の演算。}\blkref{operations_on_polar_representation})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(r,\ \left(\tfrac{\theta}{2}-n\pi\right)+\left(\tfrac{\theta}{2}-n\pi\right)\right)\right]_{\sim}\right)
&&(\because\ \text{非負実数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(r,\ \theta-2n\pi\right)\right]_{\sim}\right)
&&(\because\ \text{実数の和の計算})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(r,\ \theta\right)\right]_{\sim}\right)
&&(\because\ \text{極座標表現の同値関係。}\blkref{polar_equivalence_class})\\
&= \phi_{\mathrm{cartesian}}\!\left(\phi_{\mathrm{polar}}(z)\right)
&&(\because\ r,\theta\ \text{の取り方。}\blkref{def_phi_polar}\ \blkref{polar_equivalence_class})\\
&= z
&&(\because\ \phi_{\mathrm{cartesian}}\circ\phi_{\mathrm{polar}}=\mathrm{id}_{\mathbb{C}}\ \blkref{isomorphism_of_phi_cartesian})
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は 3 行の式で、根拠は途中の 1 行に " +
          "sqrt(r)·sqrt(r)=r と書かれているだけだった。φ_cartesian が積を保つこと・" +
          "極座標表現の演算・非負実数の sqrt の定義・同値関係 ~ が 2π の整数倍の差を" +
          "同一視すること・φ_cartesian ∘ φ_polar = id をすべて段として明示し、" +
          "行末へ (∵ …) を付けた。段は増えており、減った段は無い。" +
          "原文が r,θ,n を導入せずに使っていたので、準備として書き下した。" +
          "主張と仮定は変えていない。" +
          "原文の [sqrt(r), θ/2-nπ]_~ という書き方（同値類の中の対に括弧が無い）は、" +
          "同じファイルの他の証明と同じ [(r,θ)]_~ の形へ揃えた。" +
          "この生成器は \\blkref を定義していないので、(∵ …) の中には引いたブロックの題を書き、" +
          "式の直後にラベル参照を並べる形にした（同じファイルの他の証明と同じ扱い）。" +
          "2026-09-03 の式変形統一で、現在は利用できる \\blkref を各適用行へ置き、" +
          "証明末尾の参照一覧を削除した。式変形・根拠・内容は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_042_claim_square_of_sqrt",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/041_claim_自乗のsqrtとremark_負の実数の場合.typ", ordinal: 42 },
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
      paragraph([
        "証明の中で使う記号を先に置く。",
        math(String.raw`\alpha:=\arg^{[0,2\pi)}(z)\in\mathbb{R}`),
        " と書く（",
        ref("def_abs_arg"),
        "）。主張の場合分けは ",
        math(String.raw`\alpha`),
        " の値によるものである。",
      ]),
      paragraph([
        math(String.raw`0\leq\alpha<\pi`),
        " の場合。このとき ",
        math(String.raw`0\leq\alpha+\alpha<2\pi`),
        " なので、",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " は ",
        math(String.raw`z_1=z_2=z`),
        " について第 1 の場合を与える。",
      ]),
      displayMath(String.raw`\begin{aligned}
z
&=\sqrt{z}\sqrt{z}
&&(\because\ \text{sqrt の2乗は元に戻る})\\
&=\sqrt{z\cdot z}
&&(\because\ \text{sqrt と積が可換になる条件の第 1 の場合})\\
&=\sqrt{z^2}
&&(\because\ z\cdot z=z^{2})
\end{aligned}`),
      paragraph([
        "（第 1 の等号で引いたのは ",
        ref("sqrt_squared_is_original"),
        "。）",
      ]),
      paragraph([
        math(String.raw`\pi\leq\alpha<2\pi`),
        " の場合。このとき ",
        math(String.raw`2\pi\leq\alpha+\alpha<4\pi`),
        " なので、",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " は ",
        math(String.raw`z_1=z_2=z`),
        " について第 2 の場合、すなわち ",
        math(String.raw`\sqrt{z\cdot z}=-\sqrt{z}\sqrt{z}`),
        " を与える。",
      ]),
      displayMath(String.raw`\begin{aligned}
z
&=\sqrt{z}\sqrt{z}
&&(\because\ \text{sqrt の2乗は元に戻る})\\
&=-\bigl(-\sqrt{z}\sqrt{z}\bigr)
&&(\because\ \mathbb{C}\ \text{の元}\ w\ \text{について}\ -(-w)=w)\\
&=-\sqrt{z\cdot z}
&&(\because\ \text{sqrt と積が可換になる条件の第 2 の場合})\\
&=-\sqrt{z^2}
&&(\because\ z\cdot z=z^{2})
\end{aligned}`),
      paragraph([
        "（第 1 の等号で引いたのは ",
        ref("sqrt_squared_is_original"),
        "。）",
      ]),
      paragraph([
        "2 つの場合は ",
        math(String.raw`\alpha\in[0,2\pi)`),
        " を尽くしているので、主張を得る。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は「sqrt と積が可換になる条件より」の 1 文と " +
          "場合分けの式 1 本、そして「sqrt(z)sqrt(z)=z より結論を得る」の 1 文だけで、" +
          "z から出発する式変形が書かれていなかった。場合ごとに z から始まる一続きの鎖にし、" +
          "行末へ (∵ …) を付けた。段は増えており、減った段は無い。" +
          "原文が 2arg(z) と書いていた条件は、引く先の主張が arg(z_1)+arg(z_2) の形をしているので " +
          "α+α の形へ書き直した（同じ量だが、どの主張のどの場合を当てているのかを式に残すため）。" +
          "第 2 の場合の符号の反転は -(-w)=w の 1 段として明示した。主張と仮定は変えていない。" +
          "引く先の「sqrt の2乗は元に戻る」はラベルを持っていなかったので、" +
          "ラベル参照で引けるように sqrt_squared_is_original を与えた。" +
          "この生成器は \\blkref を定義していないので、(∵ …) の中には引いたブロックの題を書き、" +
          "式の直後にラベル参照を並べる形にした（同じファイルの他の証明と同じ扱い）。" +
          "式変形の書き方の統一（2026-09-03）。証明末尾の参照一覧を削除し、" +
          "sqrt_squared_is_original は各式変形の直後へ移した。" +
          "残る 2 件（可換条件と偏角の定義）は使用箇所の散文で既に引かれている。" +
          "式変形・根拠・内容は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_043_claim_sqrt_of_reciprocal",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/042_claim_CCの逆数のsqrtとremark.typ", ordinal: 43 },
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
        "証明の中で使うものを 4 つ先に置く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`(r,\theta)\in\mathbb{R}_{\ge 0}\times\mathbb{R}`),
        " を ",
        math(String.raw`\phi_{\mathrm{polar}}(z)=[(r,\theta)]_{\sim}`),
        " なる代表元とし（",
        ref("def_phi_polar"),
        "、",
        ref("polar_equivalence_class"),
        "）、",
        math(String.raw`n\in\mathbb{Z}`),
        " を ",
        math(String.raw`0\leq\theta-2n\pi<2\pi`),
        " を満たすものとする（",
        ref("angle_section_existence_uniqueness"),
        "）。このとき ",
        math(String.raw`\arg^{[0,2\pi)}(z)=\theta-2n\pi`),
        " である（",
        ref("def_abs_arg"),
        "）。",
      ]),
      paragraph([
        "第二に、仮定 ",
        math(String.raw`z\neq 0`),
        " により逆数 ",
        math(String.raw`1/z`),
        " が定まる（",
        ref("multiplicative_group_of_cc"),
        "）。",
      ]),
      paragraph([
        "第三に、",
        math(String.raw`\sqrt{z}\neq 0_{\mathbb{C}}`),
        " である。実際 ",
        math(String.raw`\sqrt{z}=0_{\mathbb{C}}`),
        " とすると",
      ]),
      displayMath(String.raw`\begin{aligned}
z
&= \sqrt{z}\sqrt{z}
&&(\because\ \text{sqrt の2乗は元に戻る。}\blkref{sqrt_squared_is_original})\\
&= 0_{\mathbb{C}}\cdot 0_{\mathbb{C}}
&&(\because\ \text{この場合の仮定を 2 箇所へ適用})\\
&= 0_{\mathbb{C}}
&&(\because\ \mathbb{C}\ \text{の積の定義。}\blkref{definition_of_cc})
\end{aligned}`),
      paragraph([
        "となって ",
        math(String.raw`z\neq 0`),
        " に反する。したがって逆数 ",
        math(String.raw`1/\sqrt{z}`),
        " が定まる（",
        ref("multiplicative_group_of_cc"),
        "）。",
      ]),
      paragraph([
        "第四に、",
        math(String.raw`\sqrt{1_{\mathbb{C}}}=1_{\mathbb{C}}`),
        " である。まず ",
        math(String.raw`\phi_{\mathrm{polar}}`),
        " の値を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}(1_{\mathbb{C}})
&= \phi_{\mathrm{polar}}((1,0))
&&(\because\ 1_{\mathbb{C}}=(1,0),\ \blkref{definition_of_cc}\ \blkref{inclusion_rr_to_cc})\\
&= \left[\left(\sqrt{1^2+0^2}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/1)\right)\right]_{\sim}
&&(\because\ \phi_{\mathrm{polar}}\ \text{の定義の}\ x>0\ \text{の場合。}\blkref{def_phi_polar})\\
&= \left[\left(\sqrt{1}^{\,\mathbb{R}_{\ge 0}},\ \arctan(0/1)\right)\right]_{\sim}
&&(\because\ \mathbb{R}\ \text{の計算}\ 1^2+0^2=1)\\
&= \left[\left(1,\ \arctan(0/1)\right)\right]_{\sim}
&&(\because\ \text{非負実数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{definition_of_sqrt_r_positive})\\
&= \left[\left(1,\ \arctan 0\right)\right]_{\sim}
&&(\because\ \mathbb{R}\ \text{の計算}\ 0/1=0)\\
&= \left[\left(1,\ 0\right)\right]_{\sim}
&&(\because\ \arctan 0=0)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`0\leq 0-2\cdot 0\cdot\pi<2\pi`),
        " なので、この代表元に対する整数は ",
        math(String.raw`0`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{1_{\mathbb{C}}}
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(\sqrt{1}^{\,\mathbb{R}_{\ge 0}},\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \text{複素数の}\ \sqrt{\cdot}\ \text{の極座標表現による展開。}\blkref{sqrt_expansion_via_polar})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(1,\ \tfrac{0}{2}-0\cdot\pi\right)\right]_{\sim}\right)
&&(\because\ \text{非負実数の}\ \sqrt{\cdot}\ \text{の定義。}\blkref{definition_of_sqrt_r_positive})\\
&= \phi_{\mathrm{cartesian}}\!\left(\left[\left(1,\ 0\right)\right]_{\sim}\right)
&&(\because\ \mathbb{R}\ \text{の計算})\\
&= (1\cdot\cos 0,\ 1\cdot\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義。}\blkref{def_phi_cartesian})\\
&= (1\cdot 1,\ 1\cdot\sin 0)
&&(\because\ \cos 0=1)\\
&= (1\cdot 1,\ 1\cdot 0)
&&(\because\ \sin 0=0)\\
&= (1,\ 0)
&&(\because\ \mathbb{R}\ \text{の積の計算を 2 箇所へ適用})\\
&= 1_{\mathbb{C}}
&&(\because\ 1_{\mathbb{C}}=(1,0),\ \blkref{definition_of_cc}\ \blkref{inclusion_rr_to_cc})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`\arg^{[0,2\pi)}(z)=0`),
        " の場合。まず 2 つの偏角の和を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z)+\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right)
&= 0+\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right)
&&(\because\ \text{この場合の仮定})\\
&= 0+0
&&(\because\ \mathbb{C}\ \text{の逆数の}\ \arg\ \text{の第 1 の場合。}\blkref{range_of_args_of_reciprocal_of_complex_numbers})\\
&= 0
&&(\because\ \mathbb{R}\ \text{の和の計算})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`0\leq 0<2\pi`),
        " なので、以下では ",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " の第 1 の場合が当たる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\frac{1}{z}}
&= 1_{\mathbb{C}}\cdot\sqrt{\frac{1}{z}}
&&(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元})\\
&= \left(\frac{1}{\sqrt{z}}\cdot\sqrt{z}\right)\cdot\sqrt{\frac{1}{z}}
&&(\because\ \text{準備の第三で取った}\ 1/\sqrt{z}\ \text{の定め方})\\
&= \frac{1}{\sqrt{z}}\cdot\left(\sqrt{z}\cdot\sqrt{\frac{1}{z}}\right)
&&(\because\ \mathbb{C}\ \text{の積の結合律})\\
&= \frac{1}{\sqrt{z}}\cdot\sqrt{z\cdot\frac{1}{z}}
&&(\because\ \text{sqrt と積が可換になる条件の第 1 の場合})\\
&= \frac{1}{\sqrt{z}}\cdot\sqrt{1_{\mathbb{C}}}
&&(\because\ \text{準備の第二で取った}\ 1/z\ \text{の定め方})\\
&= \frac{1}{\sqrt{z}}\cdot 1_{\mathbb{C}}
&&(\because\ \text{準備の第四})\\
&= \frac{1}{\sqrt{z}}
&&(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元})
\end{aligned}`),
      paragraph([
        math(String.raw`0<\arg^{[0,2\pi)}(z)<2\pi`),
        " の場合。まず 2 つの偏角の和を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}(z)+\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right)
&= \arg^{[0,2\pi)}(z)+\left(2\pi-\arg^{[0,2\pi)}(z)\right)
&&(\because\ \mathbb{C}\ \text{の逆数の}\ \arg\ \text{の第 2 の場合。}\blkref{range_of_args_of_reciprocal_of_complex_numbers})\\
&= 2\pi
&&(\because\ \mathbb{R}\ \text{の和の計算})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`2\pi\leq 2\pi<4\pi`),
        " なので、以下では ",
        ref("condition_of_commutativity_of_sqrt_and_product"),
        " の第 2 の場合が当たる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\frac{1}{z}}
&= 1_{\mathbb{C}}\cdot\sqrt{\frac{1}{z}}
&&(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元})\\
&= \left(\frac{1}{\sqrt{z}}\cdot\sqrt{z}\right)\cdot\sqrt{\frac{1}{z}}
&&(\because\ \text{準備の第三で取った}\ 1/\sqrt{z}\ \text{の定め方})\\
&= \frac{1}{\sqrt{z}}\cdot\left(\sqrt{z}\cdot\sqrt{\frac{1}{z}}\right)
&&(\because\ \mathbb{C}\ \text{の積の結合律})\\
&= \frac{1}{\sqrt{z}}\cdot\left(-\left(-\left(\sqrt{z}\cdot\sqrt{\frac{1}{z}}\right)\right)\right)
&&(\because\ -(-w)=w)\\
&= \frac{1}{\sqrt{z}}\cdot\left(-\sqrt{z\cdot\frac{1}{z}}\right)
&&(\because\ \text{sqrt と積が可換になる条件の第 2 の場合})\\
&= \frac{1}{\sqrt{z}}\cdot\left(-\sqrt{1_{\mathbb{C}}}\right)
&&(\because\ \text{準備の第二で取った}\ 1/z\ \text{の定め方})\\
&= \frac{1}{\sqrt{z}}\cdot\left(-1_{\mathbb{C}}\right)
&&(\because\ \text{準備の第四})\\
&= -\left(\frac{1}{\sqrt{z}}\cdot 1_{\mathbb{C}}\right)
&&(\because\ \mathbb{C}\ \text{の積と符号の関係}\ a\cdot(-b)=-(a\cdot b))\\
&= -\frac{1}{\sqrt{z}}
&&(\because\ 1_{\mathbb{C}}\ \text{は}\ \mathbb{C}\ \text{の積の単位元})
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は日本語 2 文だけで、" +
          "偏角の和の計算も、sqrt(1/z) から出発する式変形も 1 行も書かれていなかった。" +
          "場合ごとに sqrt(1/z) から始まる一続きの鎖（第 1 の場合 7 段、第 2 の場合 9 段）にし、" +
          "行末へ (∵ …) を付けた。段は増えており、減った段は無い。" +
          "原文が暗黙にしていた根拠を準備として書き下した。とくに " +
          "sqrt(z) ≠ 0（1/sqrt(z) が定まるために要る）と sqrt(1_C) = 1_C は、" +
          "原文が「= ±1」と書いたところで黙って使っていたものである。" +
          "第 2 の場合の符号は、可換条件が sqrt(z_1 z_2) = -sqrt(z_1)sqrt(z_2) の向きなので、" +
          "-(-w) = w を 1 段挟んで向きを合わせた。主張と仮定は変えていない。" +
          "この生成器は \\blkref を定義していないので、(∵ …) の中には引いたブロックの題を書き、" +
          "式の直後にラベル参照を並べる形にした（同じファイルの他の証明と同じ扱い）。" +
          "式変形の書き方の統一（2026-09-03）。証明末尾の参照一覧を削除し、" +
          "各参照を実際に使う準備または式変形の行末へ移した。内容・式変形・根拠・参照は不変である。",
      ],
    },
  },
  {
    id: "calculation_formulae_044_claim_reciprocal_of_sqrt",
    kind: "claim",
    origin: { path: "_old/typst/parts/000_計算公式/043_claim_CCのsqrtの逆数とremark.typ", ordinal: 44 },
    title: { tex: String.raw`\mathbb{C}\text{の}\sqrt{\cdot}\text{の逆数}` },
    labels: ["sqrt_cc_of_inverse"],
    statement: [
      paragraph([
        math(String.raw`z \in \mathbb{C},\ z \neq 0`),
        " について、",
      ]),
      displayMath(
        String.raw`(\sqrt{z})^{-1} = \frac{1}{\sqrt{z}} =
\begin{cases}
\sqrt{1/z} & (\arg^{[0,2\pi)}(z) = 0) \\
-\sqrt{1/z} & (0 < \arg^{[0,2\pi)}(z) < 2\pi)
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを 1 つ先に置く。",
        math(String.raw`z \neq 0`),
        " なので ",
        ref("inverse_of_sqrt_cc"),
        " の準備の第三と同じ議論により ",
        math(String.raw`\sqrt{z}\neq 0`),
        " であり、",
        math(String.raw`\mathbb{C}`),
        " の乗法群（",
        ref("multiplicative_group_of_cc"),
        "）の中で ",
        math(String.raw`\sqrt{z}`),
        " の逆元 ",
        math(String.raw`(\sqrt{z})^{-1}`),
        " が定まる。",
        math(String.raw`1/\sqrt{z}`),
        " はこの逆元の別の書き方である。",
      ]),
      paragraph([
        math(String.raw`\arg^{[0,2\pi)}(z) = 0`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sqrt{z})^{-1}
&= \frac{1}{\sqrt{z}}
&&(\because\ 1/\sqrt{z}\ \text{は逆元}\ (\sqrt{z})^{-1}\ \text{の別の書き方である})\\
&= \sqrt{\frac{1}{z}}
&&(\because\ \mathbb{C}\ \text{の逆数の}\ \sqrt{\cdot}\ \text{の第 1 の場合。}\blkref{inverse_of_sqrt_cc})
\end{aligned}`),
      paragraph([
        math(String.raw`0 < \arg^{[0,2\pi)}(z) < 2\pi`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
(\sqrt{z})^{-1}
&= \frac{1}{\sqrt{z}}
&&(\because\ 1/\sqrt{z}\ \text{は逆元}\ (\sqrt{z})^{-1}\ \text{の別の書き方である})\\
&= -\left(-\frac{1}{\sqrt{z}}\right)
&&(\because\ -(-w)=w)\\
&= -\sqrt{\frac{1}{z}}
&&(\because\ \mathbb{C}\ \text{の逆数の}\ \sqrt{\cdot}\ \text{の第 2 の場合。}\blkref{inverse_of_sqrt_cc})
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文の証明は「ℂ の逆数の sqrt より。」の 1 文だけで、" +
          "(sqrt(z))^{-1} から出発する式変形が 1 行も書かれていなかった。" +
          "場合ごとに (sqrt(z))^{-1} から始まる一続きの鎖（第 1 の場合 2 段、第 2 の場合 3 段）にし、" +
          "行末へ (∵ …) を付けた。段は増えており、減った段は無い。" +
          "第 2 の場合は、引く先が sqrt(1/z) = -1/sqrt(z) の向きなので、" +
          "-(-w) = w を 1 段挟んで向きを合わせた。" +
          "仮定を 1 つ足した。原文の主張には z ≠ 0 が無かったが、(sqrt(z))^{-1} が定まるためにも、" +
          "引く先の主張（ℂ の逆数の sqrt）の仮定を満たすためにも要る。" +
          "これは書き方の統一ではなく、原文に欠けていた仮定の補いである。" +
          "式変形の書き方の統一（2026-09-04）。証明末尾の参照一覧を削除し、" +
          "inverse_of_sqrt_cc は実際に使う二つの式変形行の行末へ移した。" +
          "multiplicative_group_of_cc は逆元を取る準備で既に引かれている。" +
          "式変形・根拠・内容は変えていない。",
      ],
    },
  },
  {
    id: "calculation_formulae_045_theorem_euler_formula_cos_sin",
    kind: "theorem",
    origin: { path: "_old/typst/parts/000_計算公式/044_theorem_cos_sinのEuler表示.typ", ordinal: 45 },
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
      paragraph([
        "準備として、Eulerの公式 ",
        math(String.raw`e^{i\varphi} = \cos\varphi + i\sin\varphi`),
        " を ",
        math(String.raw`\varphi=-\theta`),
        " で使う形を書いておく。",
      ]),
      displayMath(String.raw`\begin{aligned}
e^{-i\theta}
&=\cos(-\theta) + i\sin(-\theta)
&&(\because\ \text{Eulerの公式})\\
&=\cos\theta + i\,(-\sin\theta)
&&(\because\ \cos\ \text{は偶関数、}\sin\ \text{は奇関数})\\
&=\cos\theta - i\sin\theta
\end{aligned}`),
      paragraph(["第 1 の等式を示す。"]),
      displayMath(String.raw`\begin{aligned}
\cos\theta
&=\frac{2\cos\theta}{2}\\
&=\frac{(\cos\theta + i\sin\theta) + (\cos\theta - i\sin\theta)}{2}
&&(\because\ i\sin\theta\ \text{を足して引いた})\\
&=\frac{e^{i\theta} + (\cos\theta - i\sin\theta)}{2}
&&(\because\ \text{Eulerの公式})\\
&=\frac{e^{i\theta} + e^{-i\theta}}{2}
&&(\because\ \text{上の準備})
\end{aligned}`),
      paragraph([
        "第 2 の等式を示す。",
        math(String.raw`2i\neq0`),
        " なので割ってよい。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sin\theta
&=\frac{2i\sin\theta}{2i}\\
&=\frac{(\cos\theta + i\sin\theta) - (\cos\theta - i\sin\theta)}{2i}
&&(\because\ \cos\theta\ \text{を足して引いた})\\
&=\frac{e^{i\theta} - (\cos\theta - i\sin\theta)}{2i}
&&(\because\ \text{Eulerの公式})\\
&=\frac{e^{i\theta} - e^{-i\theta}}{2i}
&&(\because\ \text{上の準備})
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "式変形の書き方の統一（2026-08-09）。原文は「辺々加えると／辺々引くと」の 1 文で" +
        "主張の左辺から始まる式変形が 1 行も無かったので、cos θ と sin θ のそれぞれから始まる" +
        "一続きの鎖（各 4 段）にし、行末へ (∵ …) を付けた。" +
        "原文が黙って使っていた 2 つ——e^{-iθ} を cos θ - i sin θ に書き換えるのに要る" +
        "cos の偶性と sin の奇性、および 2i ≠ 0——を明示した。段は増えており、減った段は無い。",
      ],
    },
  },
]);
