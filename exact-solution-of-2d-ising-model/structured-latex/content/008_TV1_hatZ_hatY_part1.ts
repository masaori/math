import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」の前半（文書順）。
// 収録範囲は parts/008 の 000〜017, 036, 018, 019（文書順はソースのファイル名連番と
// 一致しないため、ファイル名に連番範囲は入れない）。並びが文書順の正準表現。
export default defineBlocks([
  {
    id: "heading_TV1_hatZ_hatY",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 10 },
    title: { tex: String.raw`\text{共役写像 } T_g \text{ と行列 } A(\theta)` },
    labels: [],
  },
  {
    id: "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ",
      ordinal: 4,
    },
    title: { tex: String.raw`\sinh, \cosh \text{ のテイラー展開}` },
    labels: ["sinh_cosh_taylor_series"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}`),
        " とする。双曲線正弦と双曲線余弦は ",
        ref("def_cosh_sinh"),
        " の定義による。",
      ]),
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_006_claim_exp_conjugation",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/005_claim_exp_X_Y_exp_minus_X.typ",
      ordinal: 6,
    },
    title: null,
    labels: ["exp_X_Y_exp_-X"],
    statement: [
      paragraph([
        math(String.raw`d\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`X, Y\in\mathrm{Mat}(d,\mathbb{C})`),
        " とする。",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "、",
        math(String.raw`\mathrm{ad}_X:\mathrm{Mat}(d,\mathbb{C})\to\mathrm{Mat}(d,\mathbb{C}),\ Z\mapsto[X,Z]=XZ-ZX`),
        " は ",
        ref("def_ad_X_matrix"),
        "、",
        math(String.raw`\mathrm{Ad}_{g}(Y):=gYg^{-1}`),
        "（",
        math(String.raw`g`),
        " は正則行列）も ",
        ref("def_ad_X_matrix"),
        " の記号とする。このとき ",
        math(String.raw`\exp(X)`),
        " は正則であり、右辺の級数は ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " において収束して、",
      ]),
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)
= \mathrm{Ad}_{\exp(X)}(Y)
= \exp(\mathrm{ad}_X)(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`n=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "本主張は行列環 ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " 上の主張であり、Lie 群・Lie 環の理論を使わずに証明できる。",
        ref("matrix_exp_conjugation"),
        " を ",
        math(String.raw`K:=\mathbb{C}`),
        "、",
        math(String.raw`n:=d`),
        " として適用する。同ブロックは ",
        ref("ad_binomial"),
        "（純代数的な ad 展開公式）と ",
        ref("real_exp_series_converges"),
        "・",
        ref("matrix_norm_submultiplicativity"),
        "・",
        ref("matrix_exp_series_converges"),
        "（指数級数の絶対収束と行列ノルムの劣乗法性）だけから証明されており、Lie 群論には依存しない。",
      ]),
      paragraph([
        "Step 1: ",
        ref("matrix_exp_conjugation"),
        " (1) より級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " は ",
        math(String.raw`\mathrm{Mat}(d,\mathbb{C})`),
        " において収束し、(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(X)\,Y\,\exp(-X)
&= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
&&\left(\because\ \text{「行列の exp による共役と交換子級数」(2)}\right) \\
&= \exp\!\left(\mathrm{ad}_X\right)(Y)
&&\left(\because\ \text{行列への線型写像 }\mathrm{ad}_X\text{ の exp の定義}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        ref("ad_binomial"),
        " の再帰の定義 ",
        math(String.raw`\mathrm{ad}_X^{0}(Y)=Y`),
        "、",
        math(String.raw`\mathrm{ad}_X^{m+1}(Y)=[X,\mathrm{ad}_X^{m}(Y)]`),
        " を出発点にすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ad}_X^{0}(Y)
&= Y
&&\left(\because\ \mathrm{ad}_X\text{ の反復の定義}\right), \\
\mathrm{ad}_X^{m+1}(Y)
&= [X,\mathrm{ad}_X^{m}(Y)]
&&\left(\because\ \mathrm{ad}_X\text{ の反復の定義}\right), \\
\mathrm{ad}_X^{m}(Y)
&= \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m}
&&\left(\because\ m\in\mathbb{Z}_{\ge 0}\text{ について上の二式を反復}\right)
\end{aligned}`,
      ),
      paragraph([
        "最後の式では ",
        math(String.raw`m=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        " と読む。したがって Step 1 の中辺は主張の最右辺に一致する。",
      ]),
      paragraph([
        "Step 3: ",
        ref("matrix_exp_conjugation"),
        " (3) より ",
        math(String.raw`\exp(X)`),
        " は正則で ",
        math(String.raw`\exp(X)^{-1}=\exp(-X)`),
        " であるから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{Ad}_{\exp(X)}(Y)
&= \exp(X)\,Y\,\exp(X)^{-1}
&&\left(\because\ \mathrm{Ad}_{g}(Y)=gYg^{-1}\text{ の定義}\right) \\
&= \exp(X)\,Y\,\exp(-X)
&&\left(\because\ \exp(X)^{-1}=\exp(-X)\right)
\end{aligned}`,
      ),
      paragraph([
        "以上より主張のすべての等号が成り立つ。なお、本証明で非可算集合 ",
        math(String.raw`\mathbb{R}/\mathbb{C}`),
        " の解析（極限）を使うのは ",
        ref("matrix_exp_conjugation"),
        " の内部の収束議論だけであり、その根拠は ",
        ref("matrix_completeness"),
        "（",
        math(String.raw`\mathbb{R}`),
        " の完備性）である。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文（Typst）の proof は「リー群・リー環の掘り下げを避けて一旦受け入れる」" +
          "という暫定記述だった。本主張は行列環上の主張なので、" +
          "labels: matrix_exp_conjugation（005 で Lie 群論に依存せず完全証明済み）から" +
          "完全な証明へ書き換えた。statement 側にも X, Y の所属集合（Mat(d,C)）と" +
          "記号の定義元を明示した。",
        "級数展開・反復交換子・共役写像の三つの計算を、一続きの式変形と行末の根拠へ揃えた（2026-08-15）。参照先と証明内容は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_009_definition_invertible_elements",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ",
      ordinal: 9,
    },
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C}) \text{ の可逆元}` },
    labels: ["def_invertible_elements_of_R"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 1}`),
        " とする。行列の積は ",
        ref("mat_mult"),
        "、複素係数の演算は ",
        ref("complex_numbers_form_a_field"),
        " による。",
      ]),
      paragraph([
        math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`),
        " と書き、その単位元を ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " と書く。",
        math(String.raw`g \in R`),
        " が可逆であるとは、",
      ]),
      displayMath(String.raw`\exists h \in R,\quad g\,h = I \ \text{ かつ } \ h\,g = I`),
      paragraph([
        "が成り立つことをいう。可逆な元全体の集合を",
      ]),
      displayMath(
        String.raw`R^\times := \{\, g \in R \mid g \text{ は可逆} \,\}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`g \in R^\times`),
        " に対して上の ",
        math(String.raw`h`),
        " はただ 1 つに定まり、これを ",
        math(String.raw`g^{-1}`),
        " と書く。さらに次が成り立つ。",
      ]),
      list([
        ["(i) ", math(String.raw`I \in R^\times`), " であり ", math(String.raw`I^{-1} = I`), "。"],
        [
          "(ii) ",
          math(String.raw`g_1, g_2 \in R^\times`),
          " なら ",
          math(String.raw`g_1 g_2 \in R^\times`),
          " であり ",
          math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
          "。",
        ],
        [
          "(iii) ",
          math(String.raw`g \in R^\times`),
          " なら ",
          math(String.raw`g^{-1} \in R^\times`),
          " であり ",
          math(String.raw`(g^{-1})^{-1} = g`),
          "。",
        ],
        [
          "(iv) ",
          math(String.raw`c \in \mathbb{C}\setminus\{0\}`),
          " なら ",
          math(String.raw`c\,I \in R^\times`),
          " であり ",
          math(String.raw`(cI)^{-1} = c^{-1}I`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "（逆元の一意性）",
        math(String.raw`h_1, h_2 \in R`),
        " がともに ",
        math(String.raw`g h_1 = h_1 g = I`),
        "、",
        math(String.raw`g h_2 = h_2 g = I`),
        " を満たすとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
h_1
&= h_1 I
&&(\because\ \text{単位行列との積})\\
&= h_1 (g h_2)
&&(\because\ g h_2 = I\ \text{の代入})\\
&= (h_1 g) h_2
&&(\because\ \text{行列の積の結合律})\\
&= I h_2
&&(\because\ h_1 g = I\ \text{の代入})\\
&= h_2
&&(\because\ \text{単位行列との積})
\end{aligned}`,
      ),
      paragraph(["であるから、逆元はただ 1 つである。"]),
      paragraph([
        "(i) ",
        math(String.raw`I\,I = I`),
        " より ",
        math(String.raw`I`),
        " は可逆で ",
        math(String.raw`I^{-1} = I`),
        "。",
      ]),
      paragraph([
        "(ii) ",
        math(String.raw`h := g_2^{-1}g_1^{-1}`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(g_1g_2)h
&= g_1 g_2 g_2^{-1} g_1^{-1}
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入と行列の積の結合律})\\
&= g_1 I g_1^{-1}
&&(\because\ g_2 g_2^{-1} = I)\\
&= g_1g_1^{-1}
&&(\because\ \text{単位行列との積})\\
&= I
&&(\because\ g_1 g_1^{-1} = I)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
h(g_1g_2)
&= g_2^{-1} g_1^{-1} g_1 g_2
&&(\because\ h = g_2^{-1}g_1^{-1}\ \text{の代入と行列の積の結合律})\\
&= g_2^{-1} I g_2
&&(\because\ g_1^{-1} g_1 = I)\\
&= g_2^{-1}g_2
&&(\because\ \text{単位行列との積})\\
&= I
&&(\because\ g_2^{-1} g_2 = I)
\end{aligned}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`g_1g_2 \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g_1g_2)^{-1} = g_2^{-1}g_1^{-1}`),
        "。",
      ]),
      paragraph([
        "(iii) ",
        math(String.raw`g g^{-1} = g^{-1} g = I`),
        " は、",
        math(String.raw`g^{-1}`),
        " に対して ",
        math(String.raw`g`),
        " が逆元の条件を満たすことをそのまま述べている。よって ",
        math(String.raw`g^{-1} \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(g^{-1})^{-1} = g`),
        "。",
      ]),
      paragraph(["(iv) 次の 2 つの一続きの変形による。"]),
      displayMath(
        String.raw`\begin{aligned}
(cI)(c^{-1}I)
&= (cc^{-1})I
&&(\because\ \text{スカラー倍の単位行列は積と可換（スカラー倍と単位行列の積の整理）})\\
&= I
&&(\because\ c\,c^{-1} = 1\ \text{と単位行列のスカラー }1\text{ 倍})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(c^{-1}I)(cI)
&= (c^{-1}c)I
&&(\because\ \text{スカラー倍の単位行列は積と可換（スカラー倍と単位行列の積の整理）})\\
&= I
&&(\because\ c^{-1}c = 1\ \text{と単位行列のスカラー }1\text{ 倍})
\end{aligned}`,
      ),
      paragraph([
        "（スカラー倍と単位行列の積の整理は ",
        ref("scalar_identity_commutes"),
        " による。）であるから ",
        math(String.raw`cI \in R^\times`),
        " であり、逆元の一意性より ",
        math(String.raw`(cI)^{-1} = c^{-1}I`),
        "。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。I_{(Mat(2,C))^{⊗M}} を 2^M 次の単位行列 I_{Mat(2^M,C)} へ、Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "原文（parts/008/008）は「環 R の乗法群 R^×」という一般の環についての定義だった。README 2 節「環・体などの一般論に持ち上げた証明は使わない」・3 節 2「脇道の一般論なら具体的な形に落として本文に書く」に従い、Mat(2,C)^{⊗M} の可逆元についての具体的な定義へ書き換え、以降の証明で実際に使う性質（逆元の一意性、単位元・積・逆元・スカラー倍についての可逆性）だけを主張として立てた。一般の環についての元の記述は notes/008_group_theory_general.ts へ移した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_011_definition_T_g",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ",
      ordinal: 11,
    },
    title: { tex: String.raw`T_g \text{ の定義}` },
    labels: ["def_T_g"],
    statement: [
      paragraph([
        ref("def_invertible_elements_of_R"),
        " の記号を使い、",
        math(String.raw`g \in (\mathrm{Mat}(2^M,\mathbb{C}))^\times`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g : \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{Mat}(2^M,\mathbb{C}), \quad h \mapsto g \cdot h \cdot g^{-1}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_015_claim_linearity_of_T",
    kind: "claim",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ",
      ordinal: 15,
    },
    title: { tex: String.raw`T_g \text{ の } \mathbb{C} \text{ 線型性}` },
    labels: ["linearity_of_T"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`M\in\mathbb{N}_{>0}`),
        " をとる。",
        ref("def_invertible_elements_of_R"),
        " の ",
        math(String.raw`R:=\mathrm{Mat}(2^M,\mathbb{C})`),
        " と ",
        math(String.raw`R^\times`),
        " を用いる。任意の ",
        math(String.raw`g\in R^\times`),
        "、",
        math(String.raw`a,b\in\mathbb{C}`),
        "、",
        math(String.raw`X,W\in R`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g(aX+bW)=a\,T_g(X)+b\,T_g(W)`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_T_g"),
        " の定義を用い、行列積の左右の分配と、複素スカラー倍と行列積の両立を一回ずつ適用する。",
      ]),
      displayMath(String.raw`\begin{aligned}
T_g(aX+bW)
&=g(aX+bW)g^{-1}
&&\left(\because\ \blkref{def_T_g}\right)\\
&=\bigl(g(aX)+g(bW)\bigr)g^{-1}
&&\left(\because\ \text{左からの行列積の分配法則}\right)\\
&=g(aX)g^{-1}+g(bW)g^{-1}
&&\left(\because\ \text{右からの行列積の分配法則}\right)\\
&=a(gX)g^{-1}+b(gW)g^{-1}
&&\left(\because\ \text{左からの行列積と複素スカラー倍の両立}\right)\\
&=a(gXg^{-1})+b(gWg^{-1})
&&\left(\because\ \text{右からの行列積と複素スカラー倍の両立}\right)\\
&=a\,T_g(X)+b\,T_g(W)
&&\left(\because\ \blkref{def_T_g}\right).
\end{aligned}`),
    ],
    conversion: {
      status: "converted",
      notes: [
        "2026-09-02 の論文構成再編で、二つの転送行列に限った未証明の記述から、任意の可逆な有限複素行列による共役写像の線型性へ立て直した。イジング固有の特殊化は 014_even_sector_T_action.ts 側へ分離した。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_016a_claim_duality_c2_star",
    kind: "claim",
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 17 },
    title: { tex: String.raw`K_2 \text{ と } K_2^* \text{ の双対関係}` },
    labels: ["duality_c2_star_eq_s2_star_c2"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号（",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2)`),
        "、",
        math(String.raw`c_2 := \cosh 2K_2`),
        "、",
        math(String.raw`s_2 := \sinh 2K_2`),
        "、",
        math(String.raw`c_2^* := \cosh 2K_2^*`),
        "、",
        math(String.raw`s_2^* := \sinh 2K_2^*`),
        "）について、",
      ]),
      displayMath(
        String.raw`s_2^* = \frac{1}{s_2}, \qquad c_2^* = \frac{c_2}{s_2}, \qquad
\text{したがって} \quad c_2^* = s_2^*\, c_2`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`0 < \tanh K_2 < 1`),
        " であり ",
        math(String.raw`\log(\tanh K_2)`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の中で定義される。",
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        " から必要な指数の表示を先に作る。",
      ]),
      displayMath(String.raw`\begin{aligned}
-2K_2^*
&=\log(\tanh K_2)
&&(\because\ K_2^*=-\tfrac12\log(\tanh K_2)\text{ と }\mathbb R\text{ の四則})\\
e^{-2K_2^*}
&=e^{\log(\tanh K_2)}
&&(\because\ \text{直前の等式の両辺の指数})\\
&=\tanh K_2
&&(\because\ 0<\tanh K_2\text{ と実対数・指数の逆写像性})\\
e^{2K_2^*}
&=(\tanh K_2)^{-1}
&&(\because\ \text{直前の等式の逆数と }\tanh K_2\ne0).
\end{aligned}`),
      paragraph([
        math(String.raw`\sinh K_2 > 0,\ \cosh K_2 > 0`),
        " であるから、以下の分母はいずれも ",
        math(String.raw`0`),
        " ではない。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s_2^*
&=\sinh 2K_2^*
&&(\because\ s_2^*=\sinh 2K_2^*\text{ の定義})\\
&= \frac{e^{2K_2^*} - e^{-2K_2^*}}{2}
&&(\because \sinh x = \tfrac{1}{2}(e^{x}-e^{-x})) \\
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
&&(\because \text{準備の } e^{2K_2^*} = (\tanh K_2)^{-1},\ e^{-2K_2^*} = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} - \frac{\sinh K_2}{\cosh K_2}\right)
&&(\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&&(\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{1}{\sinh 2K_2}
&&(\because \cosh^2 x - \sinh^2 x = 1,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{1}{s_2}
&&(\because s_2 = \sinh 2K_2\ \text{の定義})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
c_2^*
&=\cosh 2K_2^*
&&(\because\ c_2^*=\cosh 2K_2^*\text{ の定義})\\
&= \frac{e^{2K_2^*} + e^{-2K_2^*}}{2}
&&(\because \cosh x = \tfrac{1}{2}(e^{x}+e^{-x})) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
&&(\because \text{準備の } e^{2K_2^*} = (\tanh K_2)^{-1},\ e^{-2K_2^*} = \tanh K_2) \\
&= \frac{1}{2}\left(\frac{\cosh K_2}{\sinh K_2} + \frac{\sinh K_2}{\cosh K_2}\right)
&&(\because \tanh x = \tfrac{\sinh x}{\cosh x}\ \text{とその逆数}) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&&(\because \text{通分。分母 } \sinh K_2\cosh K_2 \neq 0\ \text{は準備で確認済み}) \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
&&(\because \cosh^2 x + \sinh^2 x = \cosh 2x,\ 2\sinh x\cosh x = \sinh 2x) \\
&= \frac{c_2}{s_2}
&&(\because c_2 = \cosh 2K_2\ \text{の定義})
\end{aligned}`,
      ),
      paragraph(["この 2 式より"]),
      displayMath(String.raw`\begin{aligned}
c_2^*
&= \frac{c_2}{s_2}&&(\because\ \text{上の鎖})\\
&= c_2\cdot\frac{1}{s_2}&&(\because\ \mathbb{R}\ \text{の除法は逆数との積}\ (s_2\ne0\ \text{は準備で確認済み}))\\
&= c_2\, s_2^*&&(\because\ \text{もう一方の鎖の}\ s_2^* = \tfrac{1}{s_2})\\
&= s_2^*\, c_2&&(\because\ \mathbb{R}\ \text{の乗法の可換性})
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文には独立したブロックが無いが、同じ計算（e^{-2K_2^*}=tanh K_2 から s_2^*=1/s_2, c_2^*=c_2/s_2 を出す）が part2 の equation_of_a_theta_mu の証明の Step 16 内に埋め込まれていた。B_1 B_2 B_1 = A(θ) の計算（T_V_hatZ_hatY）で c_2^* = s_2^* c_2 をラベル参照する必要があるため、独立した claim として切り出した。",
        "2026-09-01 の式変形統一で、指数表示の準備を行末根拠つきの鎖へ移し、s_2^* と c_2^* の各鎖の先頭に定義の等号を独立した行として置き、全根拠を行末列へ揃えた。内容・参照は変えていない。",
      ],
    },
  },
  {
    id: "TV1_hatZ_hatY_017_definition_A_theta",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/016_definition_A_theta.typ",
      ordinal: 17,
    },
    title: { tex: String.raw`A(\theta) \text{ の定義}` },
    labels: ["def_A_theta"],
    statement: [
      paragraph([math(String.raw`\theta \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`A(\theta) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta &
i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) \\
-i e^{-i\theta} s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2) &
c_1 c_2^* - s_1 s_2^*\cos\theta
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
