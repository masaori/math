import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_exp_linear_map",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 4,
    title: { text: "線型写像のexp" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "exp_linear_map_000a_claim_real_exp_series_converges",
    kind: "claim",
    sourcePath: "structured-latex/content/003_exp_linear_map.mjs",
    sourceOrdinal: 1,
    title: { text: "非負実数の指数級数の収束" },
    labels: ["real_exp_series_converges"],
    statement: [
      paragraph([
        math(String.raw`a \in \mathbb{R}_{\ge 0}`),
        " とし、",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`E_N(a) := \sum_{m=0}^{N}\frac{a^m}{m!}
\qquad (a^0 := 1,\ 0! := 1)`,
      ),
      paragraph(["とおく。このとき次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`(E_N(a))_{N\ge 0}`),
          " は単調非減少かつ上に有界であり、収束する。その極限を ",
          math(String.raw`E(a) := \sum_{m=0}^{\infty}\frac{a^m}{m!}`),
          " と書く。",
        ],
        [
          "(2) すべての ",
          math(String.raw`N`),
          " について ",
          math(String.raw`E_N(a)\le E(a)`),
          "。",
        ],
        [
          "(3) 剰余 ",
          math(String.raw`R_N(a) := E(a)-E_N(a)`),
          " は非負であり ",
          math(String.raw`R_N(a)\to 0\ (N\to\infty)`),
          "。さらに ",
          math(String.raw`p,q\in\mathbb{Z}_{\ge 1},\ p\le q`),
          " について ",
          math(String.raw`\sum_{m=p}^{q}\dfrac{a^m}{m!}\le R_{p-1}(a)`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: 単調非減少性。",
        math(String.raw`a\ge 0`),
        " より各項 ",
        math(String.raw`a^m/m!\ge 0`),
        " であるから",
      ]),
      displayMath(
        String.raw`E_{N+1}(a)-E_N(a)=\frac{a^{N+1}}{(N+1)!}\ge 0`,
      ),
      paragraph([
        "Step 2: 上に有界であること。Archimedes の原理より ",
        math(String.raw`m_0\in\mathbb{Z}_{\ge 1}`),
        " で ",
        math(String.raw`m_0\ge 2a`),
        " を満たすものがとれる。",
        math(String.raw`m\ge m_0`),
        " のとき ",
        math(String.raw`m+1>m_0\ge 2a`),
        " すなわち ",
        math(String.raw`a/(m+1)\le 1/2`),
        " であるから",
      ]),
      displayMath(
        String.raw`\frac{a^{m+1}}{(m+1)!}=\frac{a}{m+1}\cdot\frac{a^m}{m!}
\le\frac{1}{2}\cdot\frac{a^m}{m!}
\qquad (m\ge m_0)`,
      ),
      paragraph([
        "これを ",
        math(String.raw`k`),
        " に関する帰納法で繰り返すと ",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\frac{a^{m_0+k}}{(m_0+k)!}\le\left(\frac{1}{2}\right)^k\frac{a^{m_0}}{m_0!}`,
      ),
      paragraph([
        "（",
        math(String.raw`k=0`),
        " は等号。",
        math(String.raw`k`),
        " から ",
        math(String.raw`k+1`),
        " へは上の不等式を ",
        math(String.raw`m=m_0+k\ (\ge m_0)`),
        " に適用する。）よって ",
        math(String.raw`N\ge m_0`),
        " のとき等比数列の和の公式より",
      ]),
      displayMath(
        String.raw`\sum_{m=m_0}^{N}\frac{a^m}{m!}
\le\frac{a^{m_0}}{m_0!}\sum_{k=0}^{N-m_0}\left(\frac{1}{2}\right)^k
=\frac{a^{m_0}}{m_0!}\left(2-\left(\frac{1}{2}\right)^{N-m_0}\right)
\le\frac{2a^{m_0}}{m_0!}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`N\ge m_0`),
        " について ",
        math(String.raw`E_N(a)\le E_{m_0-1}(a)+\dfrac{2a^{m_0}}{m_0!}=:C`),
        "。",
        math(String.raw`N<m_0`),
        " のときは Step 1 より ",
        math(String.raw`E_N(a)\le E_{m_0-1}(a)\le C`),
        "。よって ",
        math(String.raw`(E_N(a))`),
        " は ",
        math(String.raw`C`),
        " で上に有界である。",
      ]),
      paragraph([
        "Step 3: (1)。単調非減少かつ上に有界な実数列は収束する（",
        math(String.raw`\mathbb{R}`),
        " の連続性、すなわち上に有界な集合が上限をもつことによる）。よって ",
        math(String.raw`E(a):=\lim_{N\to\infty}E_N(a)`),
        " が存在する。",
      ]),
      paragraph([
        "Step 4: (2)。単調非減少な収束列の極限はその上限であるから、すべての ",
        math(String.raw`N`),
        " について ",
        math(String.raw`E_N(a)\le E(a)`),
        "。",
      ]),
      paragraph([
        "Step 5: (3)。(2) より ",
        math(String.raw`R_N(a)=E(a)-E_N(a)\ge 0`),
        " であり、",
        math(String.raw`E_N(a)\to E(a)`),
        " より ",
        math(String.raw`R_N(a)\to 0`),
        "。また ",
        math(String.raw`1\le p\le q`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{m=p}^{q}\frac{a^m}{m!}=E_q(a)-E_{p-1}(a)\le E(a)-E_{p-1}(a)=R_{p-1}(a)
\quad (\because (2))`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。exp 級数の収束（labels: exp_converges）と" +
          "可換行列の exp 積公式（labels: theorem_exp_product）の証明が土台として使う" +
          "実数の指数級数の収束と剰余評価を、章の冒頭に置いた。",
      ],
    },
  },
  {
    id: "exp_linear_map_000b_claim_matrix_exp_series_converges",
    kind: "claim",
    sourcePath: "structured-latex/content/003_exp_linear_map.mjs",
    sourceOrdinal: 1,
    title: { text: "行列の exp 級数はノルム収束する" },
    labels: ["matrix_exp_series_converges"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`A \in \mathrm{Mat}(n,K)`),
        " とし、ノルムと収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
        math(String.raw`A^0 := I`),
        "（単位行列）とおき",
      ]),
      displayMath(String.raw`S_N(A) := \sum_{m=0}^{N}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K)`),
      paragraph(["とおくと、次が成り立つ。"]),
      list([
        [
          "(1) ",
          math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}A^m := \lim_{N\to\infty}S_N(A)`),
          " は ",
          math(String.raw`\mathrm{Mat}(n,K)`),
          " において存在する。",
        ],
        [
          "(2) ",
          math(String.raw`M_A := \|I\| + E(\|A\|)`),
          "（",
          math(String.raw`E`),
          " は ",
          ref("real_exp_series_converges"),
          " の極限）とおくと、すべての ",
          math(String.raw`N`),
          " について ",
          math(String.raw`\|S_N(A)\| \le M_A`),
          " であり、",
          math(String.raw`\left\|\sum_{m=0}^{\infty}\frac{1}{m!}A^m\right\| \le M_A`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1: ",
        math(String.raw`m\ge 1`),
        " について ",
        math(String.raw`\|A^m\|\le\|A\|^m`),
        "。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のときは等号。",
        math(String.raw`m`),
        " で成り立つとすると ",
        ref("matrix_norm_submultiplicativity"),
        " より",
      ]),
      displayMath(
        String.raw`\|A^{m+1}\|=\|A^m A\|\le\|A^m\|\cdot\|A\|\le\|A\|^m\cdot\|A\|=\|A\|^{m+1}`,
      ),
      paragraph([
        "Step 2: 実数級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\left\|\frac{1}{m!}A^m\right\|`),
        " の収束。",
        ref("matrix_norm_triangle_inequality"),
        " (2) より ",
        math(String.raw`\left\|\frac{1}{m!}A^m\right\|=\frac{1}{m!}\|A^m\|`),
        "（",
        math(String.raw`1/m!>0`),
        " なので ",
        math(String.raw`|1/m!|=1/m!`),
        "）であるから、Step 1 より",
      ]),
      displayMath(
        String.raw`\sum_{m=0}^{N}\left\|\frac{1}{m!}A^m\right\|
= \|I\| + \sum_{m=1}^{N}\frac{\|A^m\|}{m!}
\le \|I\| + \sum_{m=1}^{N}\frac{\|A\|^m}{m!}
\le \|I\| + E(\|A\|) = M_A`,
      ),
      paragraph([
        "（最後の不等号は ",
        ref("real_exp_series_converges"),
        " (2) による。）この実数級数は非負項なので部分和は単調非減少であり、いま ",
        math(String.raw`M_A`),
        " で上に有界であるから収束する（",
        math(String.raw`\mathbb{R}`),
        " の連続性）。",
      ]),
      paragraph([
        "Step 3: (1)。Step 2 と ",
        ref("matrix_completeness"),
        " (2)（絶対収束判定）より ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}A^m`),
        " は ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " において収束する。",
      ]),
      paragraph([
        "Step 4: (2)。",
        ref("matrix_norm_triangle_inequality"),
        " (3) を繰り返し用いると ",
        math(String.raw`\|S_N(A)\|\le\sum_{m=0}^{N}\left\|\frac{1}{m!}A^m\right\|\le M_A`),
        "。また ",
        ref("matrix_completeness"),
        " (2) の後半より ",
        math(String.raw`\left\|\sum_{m=0}^{\infty}\frac{1}{m!}A^m\right\|\le\sum_{m=0}^{\infty}\left\|\frac{1}{m!}A^m\right\|\le M_A`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "原文（Typst）に対応ブロックは無い。原文の exp 級数の収束（labels: exp_converges）は" +
          "「各点収束」だけを主張しているが、可換行列の exp 積公式（labels: theorem_exp_product）の証明は" +
          "Mat(n,K) におけるノルム収束を必要とするため、独立した主張として切り出した。",
      ],
    },
  },
  {
    id: "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    kind: "theorem",
    sourcePath: "_old/typst/parts/003_線型写像のexp/000_theorem_線型写像のexpの級数が各点収束すること.typ",
    sourceOrdinal: 1,
    title: null,
    labels: ["exp_converges"],
    statement: [
      paragraph([
        "体 ",
        math(String.raw`K`),
        ": ",
        math(String.raw`\mathbb{R}`),
        " または ",
        math(String.raw`\mathbb{C}`),
        "、",
        math(String.raw`V`),
        ": 有限次元 ",
        math(String.raw`K`),
        "-ノルム線型空間",
      ]),
      paragraph([
        "線型写像 ",
        math(String.raw`X : V \to V`),
        " について、",
      ]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
      paragraph(["は線型写像 ", math(String.raw`V \to V`), " に各点収束する。"]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`V`),
        " のノルムを ",
        math(String.raw`\|\cdot\|_V`),
        " と書く。ノルム線型空間の公理として、",
        math(String.raw`v,v'\in V`),
        "、",
        math(String.raw`\lambda\in K`),
        " について",
      ]),
      displayMath(
        String.raw`\|v\|_V\ge 0,\qquad
\left(\|v\|_V=0\iff v=0\right),\qquad
\|\lambda v\|_V=|\lambda|\,\|v\|_V,\qquad
\|v+v'\|_V\le\|v\|_V+\|v'\|_V`,
      ),
      paragraph([
        "を用いる。",
        math(String.raw`K^d`),
        " と ",
        math(String.raw`\mathrm{Mat}(d,K)`),
        " のノルム ",
        math(String.raw`\|\cdot\|`),
        " と収束は ",
        ref("def_matrix_norm"),
        " のものとする。",
        math(String.raw`d := \dim_K V`),
        " とおく。",
      ]),
      paragraph([
        "Step 0: ",
        math(String.raw`d=0`),
        " の場合。このとき ",
        math(String.raw`V=\{0\}`),
        " であり、",
        math(String.raw`V`),
        " 上の線型写像は零写像のみである。部分和はすべて零写像であり、各 ",
        math(String.raw`v\in V`),
        " について部分和の値は ",
        math(String.raw`0`),
        " で一定だから零写像（線型写像）に各点収束する。以下 ",
        math(String.raw`d\ge 1`),
        " とする。",
      ]),
      paragraph([
        "Step 1: 座標写像と行列表現。",
        math(String.raw`V`),
        " は有限次元なので基底 ",
        math(String.raw`E=\{e_1,\dots,e_d\}\subset V`),
        " が存在する。",
        math(String.raw`v\in V`),
        " を ",
        math(String.raw`v=\sum_{i=1}^{d}w_ie_i`),
        "（",
        math(String.raw`w_i\in K`),
        " は一意）と表し、",
      ]),
      displayMath(
        String.raw`c : V \to K^d, \qquad c(v) := (w_1,\dots,w_d)`,
      ),
      paragraph([
        "とおくと ",
        math(String.raw`c`),
        " は線型同型写像である（基底による座標表示の一意性）。",
        math(String.raw`X`),
        " は線型なので ",
        math(String.raw`X(e_j)`),
        " を基底で展開して ",
        math(String.raw`X(e_j)=\sum_{i=1}^{d}A_{ij}e_i`),
        "（",
        math(String.raw`A_{ij}\in K`),
        "）と書ける。",
        math(String.raw`A:=(A_{ij})\in\mathrm{Mat}(d,K)`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
X(v)
&= X\!\left(\sum_{j=1}^{d}w_je_j\right) \\
&= \sum_{j=1}^{d}w_jX(e_j) \quad (\because X \text{ の線型性}) \\
&= \sum_{j=1}^{d}w_j\sum_{i=1}^{d}A_{ij}e_i \\
&= \sum_{i=1}^{d}\left(\sum_{j=1}^{d}A_{ij}w_j\right)e_i
\quad (\because \text{有限和の順序交換})
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`c(X(v))=A\,c(v)`),
        "。これを ",
        math(String.raw`n`),
        " 回繰り返すと（",
        math(String.raw`n`),
        " に関する帰納法。",
        math(String.raw`n=0`),
        " では ",
        math(String.raw`X^0=\mathrm{id}_V`),
        "、",
        math(String.raw`A^0=I`),
        " で成立）",
      ]),
      displayMath(String.raw`c(X^n(v))=A^n\,c(v) \qquad (n\in\mathbb{Z}_{\ge 0})`),
      paragraph([
        "Step 2: 行列側の級数の収束。",
        ref("matrix_exp_series_converges"),
        " より",
      ]),
      displayMath(
        String.raw`S := \sum_{m=0}^{\infty}\frac{1}{m!}A^m
= \lim_{N\to\infty}S_N, \qquad S_N := \sum_{m=0}^{N}\frac{1}{m!}A^m`,
      ),
      paragraph([
        "が ",
        math(String.raw`\mathrm{Mat}(d,K)`),
        " において存在する。すなわち ",
        math(String.raw`\|S_N-S\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 3: 座標から ",
        math(String.raw`V`),
        " のノルムへの評価。",
      ]),
      displayMath(
        String.raw`C := \sqrt{\sum_{i=1}^{d}\|e_i\|_V^2}^{\,(\mathbb{R}_{\ge 0})} \in\mathbb{R}_{\ge 0}`,
      ),
      paragraph([
        " とおく。",
        math(String.raw`t=(t_1,\dots,t_d)\in K^d`),
        " について ",
        math(String.raw`c^{-1}(t)=\sum_{i=1}^{d}t_ie_i`),
        " であるから、",
        math(String.raw`V`),
        " の三角不等式を ",
        math(String.raw`d`),
        " 項に繰り返し適用して（項数に関する帰納法）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|c^{-1}(t)\|_V
&= \left\|\sum_{i=1}^{d}t_ie_i\right\|_V \\
&\le \sum_{i=1}^{d}\|t_ie_i\|_V \quad (\because \text{三角不等式の反復}) \\
&= \sum_{i=1}^{d}|t_i|\,\|e_i\|_V \quad (\because \|\lambda v\|_V=|\lambda|\|v\|_V) \\
&\le \sqrt{\sum_{i=1}^{d}|t_i|^2}^{\,(\mathbb{R}_{\ge 0})}\cdot
     \sqrt{\sum_{i=1}^{d}\|e_i\|_V^2}^{\,(\mathbb{R}_{\ge 0})} \\
&= C\,\|t\|
\end{aligned}`,
      ),
      paragraph([
        "最後から 2 番目の不等号は次による。",
        ref("matrix_norm_triangle_inequality"),
        " の Step 4（Cauchy--Schwarz の不等式）を ",
        math(String.raw`u_i=|t_i|,\ v_i=\|e_i\|_V`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\left(\sum_{i=1}^{d}|t_i|\,\|e_i\|_V\right)^2
\le\left(\sum_{i=1}^{d}|t_i|^2\right)\left(\sum_{i=1}^{d}\|e_i\|_V^2\right)
= \|t\|^2C^2=(C\,\|t\|)^2`,
      ),
      paragraph([
        "（中央の等号は ",
        math(String.raw`\left(\sqrt{a}^{(\mathbb{R}_{\ge 0})}\right)^2=a`),
        " による）。左辺の平方の中身 ",
        math(String.raw`\sum_i|t_i|\,\|e_i\|_V`),
        " と ",
        math(String.raw`C\|t\|`),
        " はともに非負であるから、",
        ref("matrix_norm_triangle_inequality"),
        " の Step 0 より ",
        math(String.raw`\sum_i|t_i|\,\|e_i\|_V\le C\|t\|`),
        "。",
      ]),
      paragraph([
        "Step 4: 各点収束。",
        math(String.raw`T_N := \sum_{n=0}^{N}\frac{1}{n!}X^n`),
        "（有限和なので ",
        math(String.raw`V`),
        " 上の線型写像）とおき、",
      ]),
      displayMath(String.raw`T : V\to V, \qquad T(v) := c^{-1}\!\left(S\,c(v)\right)`),
      paragraph([
        " とおく。",
        math(String.raw`c`),
        " の線型性と Step 1 より、",
      ]),
      displayMath(
        String.raw`c(T_N(v))
= c\!\left(\sum_{n=0}^{N}\frac{1}{n!}X^n(v)\right)
= \sum_{n=0}^{N}\frac{1}{n!}c\!\left(X^n(v)\right)
= \sum_{n=0}^{N}\frac{1}{n!}A^n\,c(v)
= S_N\,c(v)`,
      ),
      paragraph([
        "である。",
        math(String.raw`c^{-1}`),
        " は線型であるから ",
        math(String.raw`v\in V`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|T_N(v)-T(v)\|_V
&= \left\|c^{-1}\!\left(S_N\,c(v)\right)-c^{-1}\!\left(S\,c(v)\right)\right\|_V \\
&= \left\|c^{-1}\!\left((S_N-S)\,c(v)\right)\right\|_V
\quad (\because c^{-1} \text{ の線型性}) \\
&\le C\,\left\|(S_N-S)\,c(v)\right\| \quad (\because \text{Step 3}) \\
&\le C\,\|S_N-S\|\cdot\|c(v)\|
\end{aligned}`,
      ),
      paragraph([
        "最後の不等号は ",
        ref("matrix_norm_vector_bound"),
        " による。",
        math(String.raw`C`),
        " と ",
        math(String.raw`\|c(v)\|`),
        " は ",
        math(String.raw`N`),
        " によらない非負定数であり、Step 2 より ",
        math(String.raw`\|S_N-S\|\to 0`),
        " であるから ",
        math(String.raw`\|T_N(v)-T(v)\|_V\to 0`),
        "。すなわち各 ",
        math(String.raw`v\in V`),
        " について ",
        math(String.raw`T_N(v)\to T(v)`),
        " が ",
        math(String.raw`V`),
        " において成り立つ。",
      ]),
      paragraph([
        "Step 5: 極限が線型写像であること。",
        math(String.raw`T=c^{-1}\circ(\,\cdot\,\mapsto S\,\cdot\,)\circ c`),
        " は線型写像の合成（",
        math(String.raw`c`),
        "、行列 ",
        math(String.raw`S`),
        " の左からの積、",
        math(String.raw`c^{-1}`),
        " はいずれも線型）であるから線型写像である。",
      ]),
      paragraph([
        "以上より、",
        math(String.raw`\sum_{n=0}^{\infty}\frac{1}{n!}X^n`),
        " は線型写像 ",
        math(String.raw`T : V\to V`),
        " に各点収束する。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は「有限次元行列表現に帰着し、各成分が絶対収束する（証明略）」として TODO を置いていた。" +
          "ここでは原文の道筋（基底による行列表現への帰着、絶対収束）を保ったまま証明を完成させた。" +
          "行列側のノルム収束は別ブロック（labels: matrix_exp_series_converges）に切り出している。",
        "原文の「各成分は絶対収束する」を、Mat(d,K) におけるノルムでの絶対収束" +
          "（labels: matrix_completeness の絶対収束判定）として実装した。" +
          "V のノルムが基底から定まるノルムと異なりうる点は、Step 3 の評価 ||c^{-1}(t)||_V <= C ||t|| " +
          "（三角不等式と Cauchy--Schwarz のみを使う片側評価）で処理しており、" +
          "有限次元ノルムの同値性定理は使っていない。",
      ],
    },
  },
  {
    id: "exp_linear_map_002_definition_exp_of_endomorphism",
    kind: "definition",
    sourcePath: "_old/typst/parts/003_線型写像のexp/001_definition_有限次元線型空間の自己準同型のexpの定義.typ",
    sourceOrdinal: 2,
    title: null,
    labels: ["def_exp"],
    statement: [
      paragraph(["有限次元線型空間 ", math(String.raw`V`)]),
      paragraph([
        math(String.raw`\exp : \mathrm{End}(V) \to \mathrm{End}(V)`),
        " を以下のように定める。",
      ]),
      paragraph([
        "線型写像 ",
        math(String.raw`X \in \mathrm{End}(V)`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp(X) := \sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    kind: "theorem",
    sourcePath: "_old/typst/parts/003_線型写像のexp/002_theorem_可換行列のexpの積公式.typ",
    sourceOrdinal: 3,
    title: { text: "可換行列の exp 積公式" },
    labels: ["theorem_exp_product"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
      ]),
      paragraph([
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " が ",
        math(String.raw`AB = BA`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\exp(A)\exp(B) = \exp(A + B)`),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " を ",
        math(String.raw`K^n`),
        " の自己準同型全体と同一視し、",
        ref("def_exp"),
        " の ",
        math(String.raw`\exp`),
        " を",
      ]),
      displayMath(
        String.raw`\exp(A)=\sum_{m=0}^{\infty}\frac{1}{m!}A^m \in \mathrm{Mat}(n,K)`,
      ),
      paragraph([
        "（",
        ref("def_matrix_norm"),
        " の意味での収束）として扱う。この級数が収束することは ",
        ref("matrix_exp_series_converges"),
        " による。記号を",
      ]),
      displayMath(
        String.raw`S_N := \sum_{m=0}^{N}\frac{1}{m!}A^m, \qquad
T_N := \sum_{m=0}^{N}\frac{1}{m!}B^m, \qquad
C_N := \sum_{k=0}^{N}\frac{1}{k!}(A+B)^k`,
      ),
      paragraph([
        " と定め、",
        math(String.raw`a:=\|A\|,\ b:=\|B\|\in\mathbb{R}_{\ge 0}`),
        " とおく。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`A`),
        " は ",
        math(String.raw`B`),
        " の冪と可換である。すなわち ",
        math(String.raw`m\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`AB^m=B^mA`),
        "。",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=0`),
        " のときは ",
        math(String.raw`AI=A=IA`),
        "。",
        math(String.raw`m`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
AB^{m+1}
&= (AB^m)B \\
&= (B^mA)B \quad (\because \text{帰納法の仮定}) \\
&= B^m(AB) \quad (\because \text{積の結合律}) \\
&= B^m(BA) \quad (\because AB=BA) \\
&= B^{m+1}A
\end{aligned}`,
      ),
      paragraph([
        "Step 2: 二項定理。",
        math(String.raw`k\in\mathbb{Z}_{\ge 0}`),
        " について",
      ]),
      displayMath(
        String.raw`(A+B)^k=\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}`,
      ),
      paragraph([
        "を ",
        math(String.raw`k`),
        " に関する帰納法で示す。",
        math(String.raw`k=0`),
        " のときは両辺とも ",
        math(String.raw`I`),
        "。",
        math(String.raw`k`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(A+B)^{k+1}
&= (A+B)^k(A+B) \\
&= \left(\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}\right)(A+B)
\quad (\because \text{帰納法の仮定}) \\
&= \sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}A
 + \sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}B
\quad (\because \text{積の分配律}) \\
&= \sum_{j=0}^{k}\binom{k}{j}A^{j+1}B^{k-j}
 + \sum_{j=0}^{k}\binom{k}{j}A^{j}B^{k-j+1}
\quad (\because \text{Step 1}) \\
&= \sum_{j=1}^{k+1}\binom{k}{j-1}A^{j}B^{k+1-j}
 + \sum_{j=0}^{k}\binom{k}{j}A^{j}B^{k+1-j}
\quad (\text{第 1 和で } j \to j-1 \text{ と添字を付け替えた}) \\
&= \sum_{j=0}^{k+1}\left(\binom{k}{j-1}+\binom{k}{j}\right)A^{j}B^{k+1-j}
\quad \left(\binom{k}{-1}:=0,\ \binom{k}{k+1}:=0\right) \\
&= \sum_{j=0}^{k+1}\binom{k+1}{j}A^{j}B^{k+1-j}
\quad (\because \text{Pascal の関係式})
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 部分和の書き換え。",
        math(String.raw`\binom{k}{j}\frac{1}{k!}=\frac{1}{j!\,(k-j)!}`),
        " であるから、Step 2 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_N
&= \sum_{k=0}^{N}\frac{1}{k!}\sum_{j=0}^{k}\binom{k}{j}A^jB^{k-j}
\quad (\because \text{Step 2}) \\
&= \sum_{k=0}^{N}\sum_{j=0}^{k}\frac{1}{j!\,(k-j)!}A^jB^{k-j} \\
&= \sum_{(j,l)\in D_N}\frac{1}{j!\,l!}A^jB^{l}
\quad (l:=k-j,\ D_N:=\{(j,l)\in\mathbb{Z}_{\ge 0}^2 \mid j+l\le N\})
\end{aligned}`,
      ),
      paragraph(["一方、有限和の積を展開して"]),
      displayMath(
        String.raw`\begin{aligned}
S_NT_N
&= \left(\sum_{j=0}^{N}\frac{1}{j!}A^j\right)\left(\sum_{l=0}^{N}\frac{1}{l!}B^l\right) \\
&= \sum_{(j,l)\in Q_N}\frac{1}{j!\,l!}A^jB^{l}
\quad (\because \text{積の分配律},\ Q_N:=\{0,1,\dots,N\}^2)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(j,l)\in D_N`),
        " ならば ",
        math(String.raw`j\le j+l\le N`),
        " かつ ",
        math(String.raw`l\le N`),
        " であるから ",
        math(String.raw`D_N\subseteq Q_N`),
        "。よって",
      ]),
      displayMath(
        String.raw`S_NT_N-C_N=\sum_{(j,l)\in Q_N\setminus D_N}\frac{1}{j!\,l!}A^jB^{l}`,
      ),
      paragraph([
        "Step 4: 各項のノルム評価。",
        math(String.raw`\|I\|\ge 1`),
        " である（",
        ref("def_matrix_norm"),
        " より ",
        math(String.raw`\|I\|=\sqrt{n}^{\,(\mathbb{R}_{\ge 0})}`),
        " であり ",
        math(String.raw`n\ge 1`),
        "）。",
        ref("matrix_exp_series_converges"),
        " の Step 1 より ",
        math(String.raw`j\ge 1`),
        " で ",
        math(String.raw`\|A^j\|\le a^j`),
        "、",
        math(String.raw`j=0`),
        " では ",
        math(String.raw`\|A^0\|=\|I\|`),
        " であるから、いずれの場合も",
      ]),
      displayMath(String.raw`\|A^j\|\le\|I\|\,a^j \qquad (j\in\mathbb{Z}_{\ge 0})`),
      paragraph([
        math(String.raw`B`),
        " についても同様。よって ",
        ref("matrix_norm_submultiplicativity"),
        " と ",
        ref("matrix_norm_triangle_inequality"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\left\|\frac{1}{j!\,l!}A^jB^{l}\right\|
= \frac{\|A^jB^l\|}{j!\,l!}
\le \frac{\|A^j\|\,\|B^l\|}{j!\,l!}
\le \|I\|^2\cdot\frac{a^j}{j!}\cdot\frac{b^l}{l!}`,
      ),
      paragraph([
        "Step 5: ",
        math(String.raw`\|S_NT_N-C_N\|\to 0`),
        "。まず添字集合を評価する。",
        math(String.raw`(j,l)\in Q_N\setminus D_N`),
        " とすると ",
        math(String.raw`j+l>N`),
        " であるから ",
        math(String.raw`2j>N`),
        " または ",
        math(String.raw`2l>N`),
        " である（もし ",
        math(String.raw`2j\le N`),
        " かつ ",
        math(String.raw`2l\le N`),
        " なら ",
        math(String.raw`j+l\le N`),
        " となり矛盾）。",
        math(String.raw`P_N\in\mathbb{Z}_{\ge 1}`),
        " を ",
        math(String.raw`P_N\ge (N+1)/2`),
        " を満たす最小の整数とすると、整数 ",
        math(String.raw`j`),
        " について ",
        math(String.raw`2j>N`),
        " は ",
        math(String.raw`2j\ge N+1`),
        " すなわち ",
        math(String.raw`j\ge P_N`),
        " と同値であるから",
      ]),
      displayMath(
        String.raw`Q_N\setminus D_N\subseteq
\left(\{P_N,\dots,N\}\times\{0,\dots,N\}\right)
\cup\left(\{0,\dots,N\}\times\{P_N,\dots,N\}\right)`,
      ),
      paragraph([
        "（",
        math(String.raw`P_N>N`),
        " のときは対応する部分は空集合とする。）",
        ref("matrix_norm_triangle_inequality"),
        " (3) を有限個の項に繰り返し用い、Step 4 の評価と、非負項を付け加えても和が増えるだけであることを使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\|S_NT_N-C_N\|
&\le \sum_{(j,l)\in Q_N\setminus D_N}\left\|\frac{1}{j!\,l!}A^jB^{l}\right\| \\
&\le \|I\|^2\sum_{(j,l)\in Q_N\setminus D_N}\frac{a^j}{j!}\cdot\frac{b^l}{l!}
\quad (\because \text{Step 4}) \\
&\le \|I\|^2\left(
\left(\sum_{j=P_N}^{N}\frac{a^j}{j!}\right)\left(\sum_{l=0}^{N}\frac{b^l}{l!}\right)
+\left(\sum_{j=0}^{N}\frac{a^j}{j!}\right)\left(\sum_{l=P_N}^{N}\frac{b^l}{l!}\right)
\right) \\
&\le \|I\|^2\left(R_{P_N-1}(a)\,E(b)+E(a)\,R_{P_N-1}(b)\right)
\end{aligned}`,
      ),
      paragraph([
        "最後の不等号は ",
        ref("real_exp_series_converges"),
        " の (2)(3) による。",
        math(String.raw`P_N\ge (N+1)/2`),
        " より ",
        math(String.raw`P_N-1\to\infty`),
        " であり、",
        ref("real_exp_series_converges"),
        " (3) より ",
        math(String.raw`R_{P_N-1}(a)\to 0`),
        "、",
        math(String.raw`R_{P_N-1}(b)\to 0`),
        "。",
        math(String.raw`\|I\|^2,\ E(a),\ E(b)`),
        " は ",
        math(String.raw`N`),
        " によらない定数であるから ",
        math(String.raw`\|S_NT_N-C_N\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 6: ",
        math(String.raw`S_NT_N\to\exp(A)\exp(B)`),
        "。",
        ref("matrix_norm_triangle_inequality"),
        " (3)、",
        ref("matrix_norm_submultiplicativity"),
        "、および ",
        ref("matrix_exp_series_converges"),
        " (2) の評価 ",
        math(String.raw`\|S_N\|\le M_A`),
        "、",
        math(String.raw`\|\exp(B)\|\le M_B`),
        "（",
        math(String.raw`M_A=\|I\|+E(\|A\|)`),
        "、",
        math(String.raw`M_B=\|I\|+E(\|B\|)`),
        " は ",
        ref("matrix_exp_series_converges"),
        " (2) をそれぞれ ",
        math(String.raw`A`),
        "、",
        math(String.raw`B`),
        " に適用したもの）より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|S_NT_N-\exp(A)\exp(B)\right\|
&\le \left\|S_NT_N-S_N\exp(B)\right\|+\left\|S_N\exp(B)-\exp(A)\exp(B)\right\| \\
&= \left\|S_N\left(T_N-\exp(B)\right)\right\|+\left\|\left(S_N-\exp(A)\right)\exp(B)\right\| \\
&\le \|S_N\|\cdot\left\|T_N-\exp(B)\right\|+\left\|S_N-\exp(A)\right\|\cdot\|\exp(B)\| \\
&\le M_A\left\|T_N-\exp(B)\right\|+M_B\left\|S_N-\exp(A)\right\|
\end{aligned}`,
      ),
      paragraph([
        ref("matrix_exp_series_converges"),
        " (1) より ",
        math(String.raw`\|S_N-\exp(A)\|\to 0`),
        "、",
        math(String.raw`\|T_N-\exp(B)\|\to 0`),
        " であるから右辺は ",
        math(String.raw`0`),
        " に収束する。",
      ]),
      paragraph([
        "Step 7: ",
        math(String.raw`C_N\to\exp(A+B)`),
        "。",
        ref("matrix_exp_series_converges"),
        " を行列 ",
        math(String.raw`A+B`),
        " に適用すれば、",
        math(String.raw`C_N`),
        " は ",
        math(String.raw`\exp(A+B)`),
        " の部分和列であるから ",
        math(String.raw`\|C_N-\exp(A+B)\|\to 0`),
        "。",
      ]),
      paragraph([
        "Step 8: 結論。",
        ref("matrix_norm_triangle_inequality"),
        " (3) より各 ",
        math(String.raw`N`),
        " について",
      ]),
      displayMath(
        String.raw`0\le\left\|\exp(A)\exp(B)-\exp(A+B)\right\|
\le\left\|\exp(A)\exp(B)-S_NT_N\right\|
+\left\|S_NT_N-C_N\right\|
+\left\|C_N-\exp(A+B)\right\|`,
      ),
      paragraph([
        "右辺は Step 5・Step 6・Step 7 より ",
        math(String.raw`N\to\infty`),
        " で ",
        math(String.raw`0`),
        " に収束する（",
        math(String.raw`\|\exp(A)\exp(B)-S_NT_N\|=\|S_NT_N-\exp(A)\exp(B)\|`),
        " は ",
        ref("matrix_norm_triangle_inequality"),
        " (2) を ",
        math(String.raw`c=-1`),
        " に適用し ",
        math(String.raw`|-1|=1`),
        " を用いて得られる）。左辺は ",
        math(String.raw`N`),
        " によらない非負定数であるから ",
        math(String.raw`\left\|\exp(A)\exp(B)-\exp(A+B)\right\|=0`),
        " であり、",
        ref("matrix_norm_triangle_inequality"),
        " (1) より",
      ]),
      displayMath(String.raw`\exp(A)\exp(B)=\exp(A+B)`),
      paragraph([
        "なお、この証明で用いたのは行列の積・和の計算と ",
        ref("def_matrix_norm"),
        " のノルムに関する評価のみであり、微分は用いていない。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は証明の骨格（3 ステップの outline）と結語のみで、詳細計算は原文自体が省いていた。" +
          "ここでは原文の骨格（二項定理・部分和の比較・劣乗法性によるノルム評価）に沿って証明を完成させた。",
        "部分和の差の評価では、実数の指数関数の加法定理 e^a e^b = e^(a+b) を使わずに済むよう、" +
          "j+l>N かつ j,l<=N なら j または l が N/2 より大きいことを用いて剰余の積で抑える経路をとった" +
          "（labels: real_exp_series_converges の剰余評価のみで完結する）。",
      ],
    },
  },
  {
    id: "exp_linear_map_004_theorem_exp_zero_is_identity",
    kind: "theorem",
    sourcePath: "_old/typst/parts/003_線型写像のexp/003_theorem_零行列のexpはI.typ",
    sourceOrdinal: 4,
    title: { tex: String.raw`\exp(O) = I` },
    labels: ["theorem_exp_zero"],
    statement: [
      paragraph([
        math(String.raw`O`),
        " を零行列、",
        math(String.raw`I`),
        " を単位行列とするとき、",
      ]),
      displayMath(String.raw`\exp(O) = I`),
    ],
    proof: [
      paragraph([
        math(String.raw`\exp`),
        " の定義より、",
        math(String.raw`O^0 = I`),
        "、",
        math(String.raw`n \geq 1`),
        " のとき ",
        math(String.raw`O^n = O`),
        "（零行列の冪）であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(O)
&= \sum_{n=0}^{\infty} \frac{O^n}{n!} \\
&= \frac{I}{0!} + \sum_{n=1}^{\infty} \frac{O}{n!} \\
&= I + O \cdot \sum_{n=1}^{\infty} \frac{1}{n!} \\
&= I + O \\
&= I
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
