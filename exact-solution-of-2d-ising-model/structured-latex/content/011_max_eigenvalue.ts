import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SRC = "structured-latex/content/011_max_eigenvalue.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ と、} W \text{ と } \varepsilon \text{ の性質}` },
    labels: [],
  },

  {
    id: "maxeig_remark_overview_c_plus_and_epsilon",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ と、} W \text{ と } \varepsilon \text{ の性質を示す道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の固有空間 ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について次を示す。",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルにわたる上限 ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " を定め（",
        ref("def_sector_rayleigh_sup"),
        "）、",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " について ",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
        " を示す（",
        ref("c_plus_le_c"),
        "）。",
        math(String.raw`W`),
        " が ",
        math(String.raw`\varepsilon`),
        " と可換で ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " を保つこと（",
        ref("epsilon_commutes_with_W"),
        "）、",
        math(String.raw`\varepsilon`),
        " が実対称であること（",
        ref("epsilon_is_real_symmetric"),
        "）を示す。これらと、",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " が ",
        math(String.raw`V^{(+)}`),
        " に一致すること ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        "（",
        ref("symmetrized_transfer_matrix_on_sectors"),
        "）は、",
        ref("onsager_exact_solution"),
        " で ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " を ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " で上下から挟むために使う。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、旧い案内文 maxeig_000_remark_overview を N→∞ の極限と最大固有値 c(M) の章の冒頭へ移し、ここに残る c_+(M) と ε の性質を述べる段落だけをこの案内文とした。「偶セクター」を「ε の固有値 +1 の固有空間」に直し、c(M) の出どころ（def_rayleigh_sup）を添えた。数学の中身は変えていない。",
      ],
    },
  },

  {
    id: "maxeig_004_claim_W_has_positive_entries",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`W \text{ の成分はすべて正}` },
    labels: ["W_has_positive_entries"],
    statement: [
      paragraph([
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " による番号付け（",
        ref("config_numbering_equals_kronecker_numbering"),
        "）のもとで、",
        ref("def_symmetrized_transfer_matrix"),
        " で定めた ",
        math(String.raw`W`),
        " のすべての成分は正の実数である：",
      ]),
      displayMath(
        String.raw`W_{\iota(\mu),\iota(\mu')} > 0 \qquad (\mu,\mu' \in \mathfrak{M})`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`V_1^{1/2}`),
        " は正の対角行列）。以下、周期端では ",
        math(String.raw`\mu(M_{\mathrm{col}}+1):=\mu(1)`),
        " と書く。",
        ref("def_transfer_matrix_square_root"),
        " の定義と ",
        ref("sigma_z_diagonal_action"),
        " より ",
        math(String.raw`D f_{\iota(\mu)} = \left(\sum_{m}\mu(m)\mu(m+1)\right)f_{\iota(\mu)}`),
        " なので ",
        math(String.raw`\tfrac12 K_1 D`),
        " は対角行列である。",
        ref("exp_of_diagonal_matrix"),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より",
      ]),
      displayMath(
        String.raw`\left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
= \begin{cases}
\exp\!\left(\tfrac{1}{2}K_1\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right) > 0 & (\mu = \mu') \\
0 & (\mu \neq \mu')
\end{cases}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`V_2`),
        " の成分は正）。",
        ref("def_transfer_matrix"),
        " と ",
        ref("config_numbering_equals_kronecker_numbering"),
        "（行・列番号 ",
        math(String.raw`\nu(\iota(\mu)) = \mathrm{ord}(\mu)`),
        "）より ",
        math(String.raw`(V_2)_{\iota(\mu),\iota(\mu')} = \exp\!\left(K_2\sum_{m}\mu(m)\mu'(m)\right)`),
        " である。指数は実数なので、",
        ref("cosh_sinh_basic_properties"),
        " に記録した実指数関数の正値性より、この値は正である。",
      ]),
      paragraph(["Step 3。"]),
      displayMath(
        String.raw`\begin{aligned}
W_{\iota(\mu),\iota(\mu')}
&= \left(V_1^{1/2}\,V_2\,V_1^{1/2}\right)_{\iota(\mu),\iota(\mu')}
   \quad (\because W = V_1^{1/2}V_2V_1^{1/2}) \\
&= \sum_{j=1}^{2^{M_{\mathrm{col}}}}\sum_{k=1}^{2^{M_{\mathrm{col}}}}
   \left(V_1^{1/2}\right)_{\iota(\mu),j}\left(V_2\right)_{j,k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{行列の積の定義}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}
   \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}\left(V_2\right)_{\iota(\mu),k}\left(V_1^{1/2}\right)_{k,\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } j\neq\iota(\mu)\ \text{の項は } 0) \\
&= \left(V_1^{1/2}\right)_{\iota(\mu),\iota(\mu)}
   \left(V_2\right)_{\iota(\mu),\iota(\mu')}
   \left(V_1^{1/2}\right)_{\iota(\mu'),\iota(\mu')}
   \quad (\because \text{Step 1 の対角性で } k\neq\iota(\mu')\ \text{の項は } 0)
\end{aligned}`,
      ),
      paragraph([
        "3 つの因子はいずれも正の実数なので、積も正である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この正値性は、最大固有値が偶セクター（ε の固有値 +1 の側）で達成されることの理由でもある（Perron–Frobenius）。本文ではその事実を使っていないが、docs/tasks/free-energy-roadmap に次章の指針として記録した。数値でも M=2,3,4 で最大が (+) セクターにあることを確認している。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
      ],
    },
  },

  {
    id: "maxeig_005_claim_psd_cauchy_schwarz",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "半正定値双線型形式の Cauchy–Schwarz の不等式" },
    labels: ["psd_cauchy_schwarz"],
    statement: [
      paragraph(["成分積は ", ref("mat_mult"), " の式を実数成分について用い、複素数への包含は ", ref("inclusion_rr_to_cc"), " による。"]),
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`P \in \mathrm{Mat}(n,\mathbb{R})`),
        " が対称かつ半正定値（",
        math(String.raw`\forall x \in \mathbb{R}^n : x^\top P x \geq 0`),
        "）とする。このとき任意の ",
        math(String.raw`x, y \in \mathbb{R}^n`),
        " について",
      ]),
      displayMath(
        String.raw`\left(y^\top P x\right)^2 \leq \left(x^\top P x\right)\left(y^\top P y\right)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        math(String.raw`q(t) := (y + t x)^\top P (y + t x)`),
        " と置く。半正定値性により、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について ",
        math(String.raw`0\leq q(t)`),
        " である。対称性を使って展開すると",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=(y+t x)^\top P(y+t x)
&&\bigl(\because\ q(t)\ \text{の定義}\bigr)\\
&=y^\top Py+t\,y^\top Px+t\,x^\top Py+t^2x^\top Px
&&\bigl(\because\ \text{転置・行列積の分配法則}\bigr)\\
&=y^\top Py+2t\,y^\top Px+t^2x^\top Px
&&\bigl(\because\ P^\top=P\ \text{より}\ x^\top Py=y^\top Px\bigr)\\
&=(x^\top Px)t^2+2(y^\top Px)t+y^\top Py
&&\bigl(\because\ \mathbb{R}\ \text{の加法と乗法の可換則}\bigr)
\end{aligned}`),
      paragraph([
        "(i) ",
        math(String.raw`a := x^\top Px > 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置き、",
        math(String.raw`t=-b/a`),
        " を上の式へ代入すると",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&\leq q(-b/a)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)\\
&=a\left(-\frac{b}{a}\right)^2+2b\left(-\frac{b}{a}\right)+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示へ}\ t=-b/a\ \text{を代入}\bigr)\\
&=\frac{b^2}{a}-\frac{2b^2}{a}+y^\top Py
&&\bigl(\because\ a>0\ \text{より}\ a\neq0\bigr)\\
&=y^\top Py-\frac{b^2}{a}
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\frac{b^2}{a}
&\leq y^\top Py
&&\bigl(\because\ 0\leq y^\top Py-b^2/a\ \text{の移項}\bigr)\\
b^2
&\leq a\,(y^\top Py)
&&\bigl(\because\ a>0\ \text{を両辺へ掛ける}\bigr)
\end{aligned}`),
      paragraph([
        "(ii) ",
        math(String.raw`a = 0`),
        " のとき。",
        math(String.raw`b:=y^\top Px`),
        " と置くと、すべての ",
        math(String.raw`t\in\mathbb{R}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
q(t)
&=2bt+y^\top Py
&&\bigl(\because\ \text{上の}\ q(t)\ \text{の表示と}\ a=0\bigr)\\
0
&\leq q(t)
&&\bigl(\because\ P\ \text{の半正定値性}\bigr)
\end{aligned}`),
      paragraph([math(String.raw`b\neq0`), " と仮定し、", math(String.raw`t_0:=-(y^\top Py+1)/(2b)`), " と置くと"]),
      displayMath(String.raw`\begin{aligned}
q(t_0)
&=2b\left(-\frac{y^\top Py+1}{2b}\right)+y^\top Py
&&\bigl(\because\ q(t)=2bt+y^\top Py\ \text{へ}\ t=t_0\ \text{を代入}\bigr)\\
&=-(y^\top Py+1)+y^\top Py
&&\bigl(\because\ b\neq0\bigr)\\
&=-1
&&\bigl(\because\ \mathbb{R}\ \text{の四則演算}\bigr)\\
&<0
&&\bigl(\because\ -1<0\bigr)
\end{aligned}`),
      paragraph(["これは半正定値性と矛盾するので ", math(String.raw`b=0`), " である。したがって"]),
      displayMath(String.raw`\begin{aligned}
(y^\top Px)^2
&=b^2
&&\bigl(\because\ b=y^\top Px\bigr)\\
&=0
&&\bigl(\because\ b=0\bigr)\\
&=(x^\top Px)(y^\top Py)
&&\bigl(\because\ a=x^\top Px=0\bigr)
\end{aligned}`),
    ],
    conversion: { status: "added" },
  },

  {
    id: "maxeig_010a_definition_sector_rayleigh_sup",
    kind: "definition",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+ \text{（}\mathcal{F}^{(+)}\text{ での上限）}` },
    labels: ["def_sector_rayleigh_sup"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathcal{R}_+ := \left\{\, x^\top W x \ \middle|\ x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\},
\qquad c_+(M_{\mathrm{col}}) := \sup \mathcal{R}_+`,
      ),
      paragraph([
        "とおく。この上限が定まること、すなわち ",
        math(String.raw`\mathcal{R}_+`),
        " が空でなく上に有界であることを先に確かめる。上に有界なのは ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}} \subseteq \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " より ",
        math(String.raw`\mathcal{R}_+ \subseteq \mathcal{R}`),
        "（",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        "）であり、",
        math(String.raw`\mathcal{R}`),
        " が成分の絶対値の有限和 ",
        math(String.raw`\sum_{i,j}|W_{ij}|`),
        " で上に有界だからである（",
        ref("def_rayleigh_sup"),
        " の有界性の評価）。空でないことは、",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルを具体的に作れることから従う。",
      ]),
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix} \in \mathrm{Mat}(2,\mathbb{C})`),
        " について",
      ]),
      displayMath(
        String.raw`a_+ := \frac{1}{\sqrt{2}}\begin{pmatrix}1 \\ 1\end{pmatrix} \in \mathbb{R}^2,
\qquad
\sigma^x a_+ = \frac{1}{\sqrt{2}}\begin{pmatrix}1 \\ 1\end{pmatrix} = a_+`,
      ),
      paragraph([
        "とおき（右の等式は ",
        math(String.raw`2\times 2`),
        " 行列と ",
        math(String.raw`2`),
        " 次元数ベクトルの積の計算そのもの）、",
        ref("def_kronecker"),
        " (1) の数ベクトルのクロネッカー積で",
      ]),
      displayMath(
        String.raw`x^{(+)} := \overbrace{a_+ \boxtimes a_+ \boxtimes \cdots \boxtimes a_+}^{M_{\mathrm{col}}}
\quad \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`,
      ),
      paragraph([
        "と定める（",
        ref("def_kronecker"),
        " (1) より成分は各因子の成分の積だから、",
        math(String.raw`x^{(+)}`),
        " の各成分は ",
        math(String.raw`2^{-M_{\mathrm{col}}/2}`),
        " という実数であり、とくに ",
        math(String.raw`x^{(+)} \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "）。",
        ref("epsilon_square_and_eigenvalues"),
        " の証明で得た ",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " と ",
        ref("kronecker_product_rule"),
        " (3) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,x^{(+)}
&= \left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)\left(a_+\boxtimes\cdots\boxtimes a_+\right)
   \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示と}\ x^{(+)}\ \text{の定義}) \\
&= \left(\sigma^xa_+\right)\boxtimes\cdots\boxtimes\left(\sigma^xa_+\right)
   \quad (\because \blkref{kronecker_product_rule}\ \text{(3)}) \\
&= a_+\boxtimes\cdots\boxtimes a_+
   \quad (\because \sigma^x a_+ = a_+\ \text{を各因子へ同時に適用}) \\
&= x^{(+)}
   \quad (\because x^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`x^{(+)} \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " である。さらに ",
        math(String.raw`x^{(+)}`),
        " の ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の成分はすべて ",
        math(String.raw`2^{-M_{\mathrm{col}}/2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left\|x^{(+)}\right\|^2
&= \sum_{I \in \mathcal{I}_{M_{\mathrm{col}}}}\left(2^{-M_{\mathrm{col}}/2}\right)^2
   \quad (\because \blkref{def_matrix_norm}\ \text{の数ベクトルのノルムの定義と各成分の値}) \\
&= 2^{M_{\mathrm{col}}}\cdot 2^{-M_{\mathrm{col}}}
   \quad (\because \#\mathcal{I}_{M_{\mathrm{col}}} = 2^{M_{\mathrm{col}}}\ \text{と}\ \left(2^{-M_{\mathrm{col}}/2}\right)^2 = 2^{-M_{\mathrm{col}}}) \\
&= 1
   \quad (\because \text{指数法則})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\mathcal{I}_{M_{\mathrm{col}}}`),
        " は ",
        ref("def_kronecker"),
        " の添字集合）。したがって ",
        math(String.raw`\left(x^{(+)}\right)^\top Wx^{(+)} \in \mathcal{R}_+`),
        " で ",
        math(String.raw`\mathcal{R}_+ \neq \emptyset`),
        " であり、上限 ",
        math(String.raw`c_+(M_{\mathrm{col}}) \in \mathbb{R}`),
        " が定まる。上限の存在は ",
        ref("def_rayleigh_sup"),
        " と同じく、空でなく上に有界な実数の集合が上限をもつという ",
        math(String.raw`\mathbb{R}`),
        " の性質による（実数への脱出）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、上限のセクター分解のブロックから、セクターごとの上限の定義とその整合性（値の集合が空でなく上に有界であること）を独立させた。式変形と根拠は分割前と同じである。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。ε のクロネッカー積表示の参照先を <epsilon_square_and_eigenvalues> の証明に直し（旧参照 <def_eigenspaces_of_epsilon> にはこの表示が無い）、ε x^{(+)} = x^{(+)} とノルムの計算を一行一等号の鎖に開いた。",
      ],
    },
  },

  {
    id: "maxeig_claim_c_plus_le_c",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})` },
    labels: ["c_plus_le_c"],
    statement: [
      paragraph([
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}}) \in \mathbb{R}`),
        " と ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M_{\mathrm{col}}) \in \mathbb{R}_{>0}`),
        " について、",
      ]),
      displayMath(String.raw`c_+(M_{\mathrm{col}}) \leq c(M_{\mathrm{col}})`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}} \subseteq \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " なので、",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルは ",
        math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルでもあり、",
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}_+`),
        " と ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        " について ",
        math(String.raw`\mathcal{R}_+ \subseteq \mathcal{R}`),
        " である。",
        math(String.raw`\mathcal{R}_+`),
        " は空でない（",
        ref("def_sector_rayleigh_sup"),
        "）。上限の比較は ",
        math(String.raw`\mathbb{R}`),
        " の中で行う（両辺の上限はいずれも ",
        math(String.raw`\mathbb{R}`),
        " の上限の存在によって定まった実数である）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c_+(M_{\mathrm{col}})
&= \sup \mathcal{R}_+
  \quad (\because \blkref{def_sector_rayleigh_sup}) \\
&\leq \sup \mathcal{R}
  \quad (\because \mathcal{R}_+ \subseteq \mathcal{R},\ \mathcal{R}_+ \neq \emptyset\ \text{と上限の単調性}) \\
&= c(M_{\mathrm{col}})
  \quad (\because \blkref{def_rayleigh_sup})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。最大値分解 c(M_col) = max(c_+(M_col), c_-(M_col)) のうち、最終定理が使う片側の不等式 c_+(M_col) ≤ c(M_col) だけを独立した主張として立てた（証明は最大値分解の証明の該当部分と同じ）。",
      ],
    },
  },

  {
    id: "maxeig_010b_claim_epsilon_commutes_with_W",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\varepsilon W = W\varepsilon` },
    labels: ["epsilon_commutes_with_W"],
    statement: [
      paragraph([
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " は全スピン反転行列 ",
        math(String.raw`\varepsilon`),
        " と可換である。したがって ",
        math(String.raw`W`),
        " は ",
        ref("def_even_eigenvectors_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " を保つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("epsilon_commutes_with_transfer_matrices"),
        " の Step 3 で ",
        math(String.raw`\varepsilon`),
        " が ",
        math(String.raw`D = \sum_m\sigma_m^z\sigma_{m+1}^z`),
        " と可換であることを示した。同 Step 2 と同じ議論（可換なら冪とも可換、部分和とも可換、極限とも可換）で ",
        math(String.raw`\varepsilon`),
        " は ",
        math(String.raw`V_1^{1/2} = \exp(\tfrac12 K_1D)`),
        " と可換であり、同 Step 2 より ",
        math(String.raw`V_2`),
        " とも可換である。よって次の等式鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon W
&= \varepsilon V_1^{1/2}V_2V_1^{1/2}
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}) \\
&= V_1^{1/2}\varepsilon V_2V_1^{1/2}
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= V_1^{1/2}V_2\varepsilon V_1^{1/2}
   \quad (\because \varepsilon V_2=V_2\varepsilon) \\
&= V_1^{1/2}V_2V_1^{1/2}\varepsilon
   \quad (\because \varepsilon V_1^{1/2}=V_1^{1/2}\varepsilon) \\
&= W\varepsilon
   \quad (\because W=V_1^{1/2}V_2V_1^{1/2}).
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`f \in \mathcal{F}^{(+)}`),
        " とすると、",
        ref("def_even_eigenvectors_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon f = f`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon(Wf)
&= (\varepsilon W)f
   \quad (\because \text{行列の積の結合則}) \\
&= (W\varepsilon)f
   \quad (\because \text{上の等式鎖 } \varepsilon W = W\varepsilon) \\
&= W(\varepsilon f)
   \quad (\because \text{行列の積の結合則}) \\
&= Wf
   \quad (\because \varepsilon f = f)
\end{aligned}`,
      ),
      paragraph([
        "なので ",
        math(String.raw`Wf \in \mathcal{F}^{(+)}`),
        "（",
        ref("def_even_eigenvectors_of_epsilon"),
        "）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-05 の分割で、上限のセクター分解のブロックから、全スピン反転行列との可換性と固有空間の保存を独立させた。式変形と根拠は分割前と同じである。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "maxeig_claim_epsilon_is_real_symmetric",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`\varepsilon^\top = \varepsilon` },
    labels: ["epsilon_is_real_symmetric"],
    statement: [
      paragraph([
        ref("def_global_spin_flip_matrix"),
        " の全スピン反転行列 ",
        math(String.raw`\varepsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は成分がすべて実数であり、転置について対称である。",
      ]),
      displayMath(String.raw`\varepsilon^\top = \varepsilon`),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        " の成分はすべて実数（",
        math(String.raw`0`),
        " または ",
        math(String.raw`1`),
        "）であり、",
        ref("def_kronecker"),
        " (1) よりクロネッカー積の成分は各因子の成分の積だから、",
        math(String.raw`\varepsilon = \sigma^x\boxtimes\cdots\boxtimes\sigma^x`),
        " の成分もすべて実数である。転置については",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon^\top
&=\left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)^\top
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示})\\
&=(\sigma^x)^\top\boxtimes\cdots\boxtimes(\sigma^x)^\top
  \quad (\because \blkref{kronecker_transpose})\\
&=\sigma^x\boxtimes\cdots\boxtimes\sigma^x
  \quad (\because \blkref{pauli_matrix_products}\ \text{の }\sigma^x\text{ の成分表示から }(\sigma^x)^\top=\sigma^x)\\
&=\varepsilon
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。旧 <sector_decomposition_of_rayleigh_sup> の証明の中にあった ε^⊤ = ε の導出を、最終定理が引く独立した主張として取り出した。",
      ],
    },
  },

]);
