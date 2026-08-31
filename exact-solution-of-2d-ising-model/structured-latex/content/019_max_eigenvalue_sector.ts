import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/019_max_eigenvalue_sector.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue_sector",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{最大固有値はどちらのセクターから来るか：} c(M) = c_+(M)` },
    labels: [],
  },

  {
    id: "sector_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        ref("sector_decomposition_of_rayleigh_sup"),
        " (3) により ",
        math(String.raw`c(M) = \max\left(c_+(M), c_-(M)\right)`),
        " である。",
        ref("onsager_exact_solution"),
        " はこの ",
        math(String.raw`\max`),
        " の値を決めずに、",
        math(String.raw`\Lambda^{(1/2)}_M \leq c(M) \leq 2\Lambda^{(1/2)}_M`),
        " という**粗い挟み撃ち**で自由エネルギーを出した（係数 ",
        math(String.raw`2`),
        " は ",
        math(String.raw`(\log 2)/M \to 0`),
        " で消えるので表式には影響しない）。",
      ]),
      paragraph([
        "この章では、その ",
        math(String.raw`\max`),
        " がどちらから来るかを確定させる：",
      ]),
      displayMath(
        String.raw`c_-(M) \ \leq\ c_+(M),
\qquad \text{したがって}\qquad
c(M) = c_+(M) = \Lambda^{(1/2)}_M`,
      ),
      paragraph([
        "**自由エネルギーの表式そのものにこの結果は不要である。** それでもこれを示すのは、",
        math(String.raw`W`),
        " の最大固有値が ",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " のセクター（偶セクター）から来る、という描像を本文で確定させるためである。",
      ]),
      paragraph([
        "筋は短い。",
        math(String.raw`\varepsilon`),
        " は標準基底のベクトルを別の標準基底のベクトルへ写す ",
        math(String.raw`0/1`),
        " の**置換行列**である（",
        ref("epsilon_is_sign_flip_permutation"),
        "）。そこで奇セクターの実ベクトル ",
        math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
        " に対し、成分ごとに絶対値を取ったベクトル ",
        math(String.raw`u`),
        "（",
        math(String.raw`u_k := |x_k|`),
        "）を作ると、符号がそろって ",
        math(String.raw`u`),
        " は**偶セクターに移る**（",
        ref("abs_vector_moves_to_even_sector"),
        "）。しかも ",
        math(String.raw`W`),
        " の成分がすべて正である（",
        ref("W_has_positive_entries"),
        "。この議論で実際に効くのは ",
        math(String.raw`W_{kl} \geq 0`),
        " という**非負性だけ**である）ため、絶対値を取ると二次形式の値は**減らない**。よって ",
        math(String.raw`c_+(M) \geq u^\top Wu \geq x^\top Wx`),
        " となり、",
        math(String.raw`x`),
        " について上限を取れば ",
        math(String.raw`c_+(M) \geq c_-(M)`),
        " を得る（",
        ref("c_minus_le_c_plus"),
        "）。",
      ]),
      paragraph([
        "この章で使う道具は、実行列の成分計算、有限個の実数の和・積・絶対値と三角不等式、",
        "および実数の上限だけである。**実数解析（積分・連続極限）へは移行しない**（",
        ref("remark_real_analysis_escape_point"),
        " の移行点は ",
        ref("onsager_exact_solution"),
        " の最後の等号だけのままである）。",
      ]),
      paragraph([
        "なお、示すのは ",
        math(String.raw`c_-(M) \leq c_+(M)`),
        " という**不等号だけ**であり、",
        math(String.raw`c_-(M)`),
        " の値そのものには立ち入らない。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "sector_001_claim_epsilon_is_permutation",
    kind: "claim",
    origin: { path: SRC, ordinal: 3 },
    title: {
      tex: String.raw`\varepsilon \text{ は不動点をもたない対合の置換行列}`,
    },
    labels: ["epsilon_is_sign_flip_permutation"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_config_basis_iso"),
        " の同一視のもとで ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の標準基底を ",
        math(String.raw`e_1,\dots,e_{2^M}`),
        " とする。",
        math(String.raw`k \in \{1,\dots,2^M\}`),
        " に対応するスピン配置を ",
        math(String.raw`s_k \in \mathfrak{M}`),
        "（",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M\},\{-1,1\})`),
        "。すなわち ",
        math(String.raw`e_k = f_{\iota(s_k)}`),
        "）と書き、写像 ",
        math(String.raw`\pi : \{1,\dots,2^M\} \to \{1,\dots,2^M\}`),
        " を",
      ]),
      displayMath(
        String.raw`\pi(k) := \left(\text{スピン配置 } -s_k \text{ に対応する番号}\right),
\qquad (-s_k)(m) := -\,s_k(m) \quad (m \in \{1,\dots,M\})`,
      ),
      paragraph([
        "で定める。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " について次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \varepsilon\,e_k = e_{\pi(k)}
\qquad (k \in \{1,\dots,2^M\})`),
          "。とくに ",
          math(String.raw`\varepsilon`),
          " の成分は ",
          math(String.raw`\varepsilon_{l,k} = \begin{cases}1 & (l = \pi(k)) \\ 0 & (l \neq \pi(k))\end{cases}`),
          " であり、**",
          math(String.raw`\varepsilon`),
          " は成分がすべて ",
          math(String.raw`0`),
          " または ",
          math(String.raw`1`),
          " の置換行列**である（各行・各列にちょうど 1 個の ",
          math(String.raw`1`),
          " がある）。",
        ],
        [
          math(String.raw`\text{(2)}\quad \pi(\pi(k)) = k, \qquad \pi(k) \neq k
\qquad (k \in \{1,\dots,2^M\})`),
          "（",
          math(String.raw`\pi`),
          " は不動点をもたない対合）。",
        ],
        [
          math(String.raw`\text{(3)}\quad \left(\varepsilon x\right)_k = x_{\pi(k)}
\qquad \left(x \in \mathbb{C}^{2^M},\ k \in \{1,\dots,2^M\}\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad x_0 := \frac{1}{\sqrt{2}}\left(e_1 - e_{\pi(1)}\right)
\ \in\ \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}, \qquad \|x_0\| = 1`),
          "（",
          ref("def_eigenspaces_of_epsilon"),
          " の ",
          math(String.raw`\mathcal{F}^{(-)}`),
          "）。**とくに ",
          math(String.raw`\mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
          " は単位ベクトルを含む。**",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("trace_of_epsilon_V_plus"),
        " の証明 Step 3 の (b) で ",
        math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`),
        "（",
        math(String.raw`s \in \mathfrak{M}`),
        "）が示されている。",
        math(String.raw`e_k = f_{\iota(s_k)}`),
        " と ",
        math(String.raw`\pi`),
        " の定義より ",
        math(String.raw`f_{\iota(-s_k)} = e_{\pi(k)}`),
        " なので ",
        math(String.raw`\varepsilon e_k = e_{\pi(k)}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\varepsilon`),
        " の第 ",
        math(String.raw`k`),
        " 列は ",
        math(String.raw`\varepsilon e_k`),
        " そのものだから、成分は ",
        math(String.raw`\varepsilon_{l,k} = \delta_{l,\pi(k)}`),
        "（",
        math(String.raw`l = \pi(k)`),
        " のとき ",
        math(String.raw`1`),
        "、そうでなければ ",
        math(String.raw`0`),
        "）である。よって各列にちょうど 1 個の ",
        math(String.raw`1`),
        " がある。",
        math(String.raw`s \mapsto -s`),
        " は ",
        math(String.raw`\mathfrak{M}`),
        " からそれ自身への全単射（(2) で示す ",
        math(String.raw`\pi\circ\pi = \mathrm{id}`),
        " が逆写像を与える）なので ",
        math(String.raw`\pi`),
        " も全単射であり、各行にもちょうど 1 個の ",
        math(String.raw`1`),
        " がある。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`-(-s_k) = s_k`),
        " なので、",
        math(String.raw`\pi`),
        " の定義から ",
        math(String.raw`\pi(\pi(k))`),
        " は ",
        math(String.raw`s_k`),
        " に対応する番号、すなわち ",
        math(String.raw`k`),
        " である。また ",
        math(String.raw`s_k(1) \in \{-1,1\}`),
        " より ",
        math(String.raw`-s_k(1) \neq s_k(1)`),
        " なので ",
        math(String.raw`-s_k \neq s_k`),
        "、番号の対応は全単射だから ",
        math(String.raw`\pi(k) \neq k`),
        "。",
      ]),
      paragraph(["(3) 行列とベクトルの積の定義に (1) の成分表示を入れる。"]),
      displayMath(
        String.raw`\begin{aligned}
\left(\varepsilon x\right)_k
&= \sum_{l=1}^{2^M}\varepsilon_{k,l}\,x_l
&& (\because \text{行列とベクトルの積の定義}) \\
&= \sum_{l=1}^{2^M}\delta_{k,\pi(l)}\,x_l
&& (\because \text{(1) の成分表示}) \\
&= x_{\pi^{-1}(k)}
&& (\because \pi \text{ は全単射なので } \pi(l) = k \text{ となる } l
   \text{ がちょうど 1 つ}) \\
&= x_{\pi(k)}
&& (\because \text{(2) より } \pi\circ\pi = \mathrm{id} \text{、すなわち }
   \pi^{-1} = \pi)
\end{aligned}`,
      ),
      paragraph([
        "(4) (2) より ",
        math(String.raw`\pi(1) \neq 1`),
        " なので ",
        math(String.raw`e_1`),
        " と ",
        math(String.raw`e_{\pi(1)}`),
        " は相異なる標準基底ベクトルであり、",
        math(String.raw`\|x_0\|^2 = \tfrac12\left(1 + 1\right) = 1`),
        "。成分は実数なので ",
        math(String.raw`x_0 \in \mathbb{R}^{2^M}`),
        "。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon\,x_0
&= \frac{1}{\sqrt{2}}\left(\varepsilon e_1 - \varepsilon e_{\pi(1)}\right)
&& (\because \text{行列の積の線型性}) \\
&= \frac{1}{\sqrt{2}}\left(e_{\pi(1)} - e_{\pi(\pi(1))}\right)
&& (\because \text{(1) を 2 箇所へ同時適用}) \\
&= \frac{1}{\sqrt{2}}\left(e_{\pi(1)} - e_{1}\right)
&& (\because \text{(2) の } \pi(\pi(1)) = 1) \\
&= -\,x_0
&& (\because x_0 \text{ の定義と実数の符号の分配})
\end{aligned}`,
      ),
      paragraph([
        "なので ",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`x_0 \in \mathcal{F}^{(-)}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "ε が置換行列であること自体は trace_of_epsilon_V_plus の証明 Step 3 (b) で既に確立している。ここで独立の主張として切り出したのは、この章の議論が「成分ごとの絶対値」というベクトルの成分レベルの操作を使うため、成分表示 (εx)_k = x_{π(k)} を明示的に持っておく必要があるからである。",
        "(4) は c_−(M) を定める集合が空でないこと（上限が定まること）の保証である。011 章の sector_decomposition_of_rayleigh_sup は c_±(M) を上限として定義しているが、集合が空でないことには触れていなかった。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_01（M=2,3,4,5 で ε の成分が 0/1、各行各列の和が 1、π が不動点なしの対合、(εx)_k = x_{π(k)}、dim(F^{(-)} ∩ R^{2^M}) = 2^{M−1}）。",
      ],
    },
  },

  {
    id: "sector_002_claim_abs_vector_moves_to_even_sector",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: {
      tex: String.raw`x \in \mathcal{F}^{(-)} \Longrightarrow u := \left(|x_k|\right)_k
\in \mathcal{F}^{(+)}, \quad u^\top Wu \geq x^\top Wx`,
    },
    labels: ["abs_vector_moves_to_even_sector"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " を考える（",
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W`),
        " は実行列とみなせる）。",
        math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
        "（",
        ref("def_eigenspaces_of_epsilon"),
        "）に対し、",
      ]),
      displayMath(
        String.raw`u \in \mathbb{R}^{2^M}, \qquad
u_k := \left|x_k\right| \quad \left(k \in \{1,\dots,2^M\}\right)`,
      ),
      paragraph(["と定める。このとき次が成り立つ。"]),
      list([
        [
          math(String.raw`\text{(1)}\quad \varepsilon\,u = u`),
          "、すなわち ",
          math(String.raw`u \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        ],
        [math(String.raw`\text{(2)}\quad \|u\| = \|x\|`)],
        [math(String.raw`\text{(3)}\quad u^\top W u \ \geq\ \left|x^\top Wx\right| \ \geq\ x^\top W x`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`x \in \mathcal{F}^{(-)}`),
        " なので ",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon x = -x`),
        " である。",
        ref("epsilon_is_sign_flip_permutation"),
        " (3) をこの等式の第 ",
        math(String.raw`k`),
        " 成分に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x_{\pi(k)}
&= \left(\varepsilon x\right)_k
&& (\because \text{epsilon\_is\_sign\_flip\_permutation (3)}) \\
&= \left(-x\right)_k
&& (\because \varepsilon x = -x) \\
&= -\,x_k
\qquad \left(k \in \{1,\dots,2^M\}\right)
&& (\because \text{スカラー倍の成分表示})
\end{aligned}`,
      ),
      paragraph([
        "を得る。同じ ",
        ref("epsilon_is_sign_flip_permutation"),
        " (3) を ",
        math(String.raw`u`),
        " に適用して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\varepsilon u\right)_k
&= u_{\pi(k)}
&& (\because \text{epsilon\_is\_sign\_flip\_permutation (3)}) \\
&= \left|x_{\pi(k)}\right|
&& (\because u \text{ の定義}) \\
&= \left|-x_k\right|
&& (\because \text{直前の } x_{\pi(k)} = -x_k) \\
&= \left|x_k\right|
&& (\because \text{実数の絶対値は符号を落とす}) \\
&= u_k
&& (\because u \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "すべての ",
        math(String.raw`k`),
        " で成分が一致するので ",
        math(String.raw`\varepsilon u = u`),
        " であり、",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`u \in \mathcal{F}^{(+)}`),
        "。成分 ",
        math(String.raw`|x_k|`),
        " は実数なので ",
        math(String.raw`u \in \mathbb{R}^{2^M}`),
        "。",
      ]),
      paragraph(["(2) ノルムの定義から成分ごとに計算する。"]),
      displayMath(
        String.raw`\begin{aligned}
\|u\|^2
&= \sum_{k=1}^{2^M}u_k^2
&& (\because \text{ノルムの定義}) \\
&= \sum_{k=1}^{2^M}\left|x_k\right|^2
&& (\because u \text{ の定義}) \\
&= \sum_{k=1}^{2^M}x_k^2
&& \left(\because |a|^2 = a^2 \ (a \in \mathbb{R})\right) \\
&= \|x\|^2
&& (\because \text{ノルムの定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\|u\| \geq 0`),
        "、",
        math(String.raw`\|x\| \geq 0`),
        " なので平方根を取って ",
        math(String.raw`\|u\| = \|x\|`),
        "。",
      ]),
      paragraph([
        "(3) ",
        ref("W_has_positive_entries"),
        " より ",
        math(String.raw`W_{kl} > 0`),
        "（すべての ",
        math(String.raw`k, l`),
        "）であり、とくに ",
        math(String.raw`W_{kl} \geq 0`),
        " である。以下で使うのはこの**非負性だけ**で、",
        math(String.raw`W_{kl} > 0`),
        " が真に必要な箇所はない（",
        math(String.raw`W_{kl} \geq 0`),
        " のとき ",
        math(String.raw`|x_kx_lW_{kl}| = |x_k||x_l|W_{kl}`),
        " が成り立つ）。二次形式を成分で書き下す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u^\top W u
&= \sum_{k=1}^{2^M}\sum_{l=1}^{2^M}u_k\,u_l\,W_{kl}
&& (\because \text{行列とベクトルの積と内積の成分表示}) \\
&= \sum_{k=1}^{2^M}\sum_{l=1}^{2^M}\left|x_k\right|\left|x_l\right|W_{kl}
&& (\because u \text{ の定義}) \\
&= \sum_{k=1}^{2^M}\sum_{l=1}^{2^M}\left|x_k\,x_l\,W_{kl}\right|
&& \left(\because W_{kl} \geq 0
   \text{ なので } |x_kx_lW_{kl}| = |x_k||x_l|W_{kl}\right) \\
&\geq \left|\sum_{k=1}^{2^M}\sum_{l=1}^{2^M}x_k\,x_l\,W_{kl}\right|
&& (\because \text{有限個の実数についての三角不等式}) \\
&= \left|x^\top W x\right|
&& (\because \text{行列とベクトルの積と内積の成分表示}) \\
&\geq x^\top W x
&& \left(\because |a| \geq a \ (a \in \mathbb{R})\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張が章 C′ の締めくくりの実質的な内容である。Perron–Frobenius の定理の「最大固有ベクトルは符号をそろえて取れる」という部分だけを、W の成分が正であることから直接、上限（sup）の言葉で取り出したものになっている。行列の対角化可能性もスペクトル定理も使っていない（011 章と同じ方針）。",
        "(3) の 1 つ目の不等号で使ったのは有限個の実数についての三角不等式だけである。等号が成り立つのは x の非零成分の符号が「W_{kl} の重みつきで」そろっている場合で、一般には真の不等号になる（数値では c_−(M) < c_+(M) が全ケースで成り立つ）。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_02（M=2,3,4,5・6 組の (K_1,K_2)・各 8 本の乱数ベクトルで εu = u の残差 0、‖u‖ = ‖x‖ の残差 ≤ 2.3e-16、(3) の違反 0 件）。",
      ],
    },
  },

  {
    id: "sector_003_theorem_c_minus_le_c_plus",
    kind: "theorem",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`c_-(M) \leq c_+(M)` },
    labels: ["c_minus_le_c_plus"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c_\pm(M) = \sup\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M},\ \|x\| = 1 \,\right\}`,
      ),
      paragraph([
        "について ",
        math(String.raw`c_-(M)`),
        " と ",
        math(String.raw`c_+(M)`),
        " はともに実数として定まり（右辺の集合は空でなく上に有界）、",
      ]),
      displayMath(String.raw`c_-(M) \ \leq\ c_+(M)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "Step 1（上限が定まること）。",
        math(String.raw`\mathcal{R}_\pm := \left\{x^\top Wx \mid
x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M},\ \|x\| = 1\right\}`),
        " とおく。",
        ref("epsilon_is_sign_flip_permutation"),
        " (4) の ",
        math(String.raw`x_0`),
        " により ",
        math(String.raw`\mathcal{R}_-\neq\emptyset`),
        " である。",
        math(String.raw`\mathcal{R}_+`),
        " については ",
        math(String.raw`v := e_1 + e_{\pi(1)}`),
        " を取る。第 ",
        math(String.raw`1`),
        " 成分が ",
        math(String.raw`1`),
        " 以上なので ",
        math(String.raw`v \neq 0`),
        " であり、",
        ref("epsilon_is_sign_flip_permutation"),
        " (1) と ",
        math(String.raw`\pi(\pi(1)) = 1`),
        "（同 (2)）から ",
        math(String.raw`\varepsilon v = e_{\pi(1)} + e_1 = v`),
        " なので ",
        math(String.raw`y_0 := v/\|v\|`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルであり、",
        math(String.raw`\mathcal{R}_+\neq\emptyset`),
        " である。",
      ]),
      paragraph([
        "（",
        math(String.raw`\mathcal{R}_+\neq\emptyset`),
        " に使ったのは ",
        ref("epsilon_is_sign_flip_permutation"),
        " (2) のうち ",
        math(String.raw`\pi\circ\pi = \mathrm{id}`),
        " の部分だけで、",
        math(String.raw`\pi(k) \neq k`),
        "（不動点をもたないこと）は使っていない。",
        math(String.raw`\pi(1) = 1`),
        " であれば ",
        math(String.raw`v = 2e_1`),
        " となるだけで、上の議論はそのまま通る。不動点をもたないことが本質的に効くのは ",
        math(String.raw`\mathcal{R}_-\neq\emptyset`),
        " の側、すなわち同 (4) の ",
        math(String.raw`x_0 = \tfrac{1}{\sqrt2}(e_1 - e_{\pi(1)})`),
        " が非零であるところである。）",
      ]),
      paragraph([
        "また ",
        math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}`),
        " の単位ベクトルは ",
        math(String.raw`\mathbb{R}^{2^M}`),
        " の単位ベクトルでもあるから ",
        math(String.raw`\mathcal{R}_\pm \subseteq \mathcal{R}`),
        "（",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        "）であり、同じところで示されている ",
        math(String.raw`\mathcal{R}`),
        " の上界 ",
        math(String.raw`\|W\|`),
        " が ",
        math(String.raw`\mathcal{R}_\pm`),
        " の上界にもなる。空でなく上に有界な実数集合は上限をもつので、",
        math(String.raw`c_\pm(M) \in \mathbb{R}`),
        " が定まる。",
      ]),
      paragraph([
        "Step 2（各点での比較）。",
        math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取り、",
        ref("abs_vector_moves_to_even_sector"),
        " の ",
        math(String.raw`u`),
        "（",
        math(String.raw`u_k = |x_k|`),
        "）を対応させる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&\leq u^\top W u
&& (\because \text{abs\_vector\_moves\_to\_even\_sector (3)}) \\
&\leq c_+(M)
&& \left(\because \text{abs\_vector\_moves\_to\_even\_sector (1)(2) より }
   u \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M},\ \|u\| = \|x\| = 1
   \text{ なので } u^\top Wu \in \mathcal{R}_+\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 3（上限を取る）。Step 2 より ",
        math(String.raw`c_+(M)`),
        " は ",
        math(String.raw`\mathcal{R}_-`),
        " の上界である。",
        math(String.raw`c_-(M) = \sup\mathcal{R}_-`),
        " は ",
        math(String.raw`\mathcal{R}_-`),
        " の上界のうち最小のものだから ",
        math(String.raw`c_-(M) \leq c_+(M)`),
        "。",
      ]),
      paragraph([
        "（Step 2・Step 3 が使っているのは ",
        ref("epsilon_is_sign_flip_permutation"),
        " (3) の成分表示（",
        ref("abs_vector_moves_to_even_sector"),
        " を通して）と ",
        math(String.raw`W`),
        " の成分の非負性だけである。",
        math(String.raw`\pi`),
        " が不動点をもたないことは**不等式の証明そのものには効いていない**。それが要るのは Step 1 で ",
        math(String.raw`\mathcal{R}_-`),
        " が空でない、すなわち ",
        math(String.raw`c_-(M)`),
        " が上限として意味をもつことを言う箇所だけである。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_03（M=2,3,4,5・6 組の (K_1,K_2) の 24 ケースすべてで c_−(M) ≤ c_+(M)。さらに c_−(M) を達成する単位ベクトル x_− を実際に取り、u = |x_−| について本文の 2 段の不等式 c_+(M) ≥ u^T W u ≥ c_−(M) が成り立つことも確かめた）。",
        "24 ケースすべてで真の不等号 c_−(M) < c_+(M) だった（比 c_−/c_+ は 0.110〜0.991）。本文は不等号しか主張していないが、等号が起こりうるかどうかは本文の議論には不要である。",
      ],
    },
  },

  {
    id: "sector_004_theorem_c_equals_c_plus",
    kind: "theorem",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`c(M) = c_+(M) = \Lambda^{(1/2)}_M` },
    labels: ["c_equals_c_plus"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`c(M)`),
        "、",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の ",
        math(String.raw`c_\pm(M)`),
        "、",
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " について",
      ]),
      displayMath(
        String.raw`c(M) = c_+(M) = \Lambda^{(1/2)}_M
= \left(2\sinh 2K_2\right)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\tilde\theta_\mu`),
        " は ",
        ref("def_half_integer_modes"),
        " の半整数運動量、",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        "）。**上限 ",
        math(String.raw`c(M)`),
        " は達成され、しかもそれを達成する単位ベクトルは偶セクター ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の中に取れる。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`c(M) = c_+(M)`),
        "）。",
        ref("sector_decomposition_of_rayleigh_sup"),
        " (3) と ",
        ref("c_minus_le_c_plus"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c(M)
&= \max\left(c_+(M),\, c_-(M)\right)
   \quad (\because \text{sector\_decomposition\_of\_rayleigh\_sup (3)}) \\
&= c_+(M)
   \quad (\because \text{c\_minus\_le\_c\_plus の } c_-(M) \leq c_+(M))
\end{aligned}`,
      ),
      paragraph([
        "Step 2（値の代入）。",
        ref("c_plus_equals_Lambda_half_integer"),
        " より ",
        math(String.raw`c_+(M) = \Lambda^{(1/2)}_M`),
        " なので、Step 1 と合わせて ",
        math(String.raw`c(M) = \Lambda^{(1/2)}_M`),
        "。右辺の閉じた表示は ",
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\delta = \tfrac12`),
        " の場合である。",
      ]),
      paragraph([
        "Step 3（達成されること）。",
        ref("c_plus_equals_Lambda_half_integer"),
        " の証明 Step 3 で、",
        math(String.raw`x_0 \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x_0\| = 1`),
        " かつ ",
        math(String.raw`x_0^\top Wx_0 = c_+(M)`),
        " を満たす ",
        math(String.raw`x_0`),
        " が構成されている。この ",
        math(String.raw`x_0`),
        " は ",
        math(String.raw`\mathbb{R}^{2^M}`),
        " の単位ベクトルでもあるから、Step 1 より ",
        math(String.raw`x_0^\top Wx_0 = c(M)`),
        " であり、",
        ref("def_rayleigh_sup"),
        " の上限は ",
        math(String.raw`x_0`),
        " で達成される。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "011 章の W_has_positive_entries の注記が「この正値性は最大固有値が偶セクターで達成されることの理由でもある（Perron–Frobenius）。本文ではその事実を使っていない」としていた点が、ここで本文の定理になった。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_04（M=2,3,4,5・6 組の (K_1,K_2) で c(M) = max(c_+,c_−) = c_+ = Λ^{(1/2)}_M の相対差 ≤ 2.0e-15）。",
      ],
    },
  },

  {
    id: "sector_005_remark_sandwich_becomes_equality",
    kind: "remark",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "Onsager の厳密解の証明で使った粗い評価との関係" },
    labels: [],
    statement: [
      paragraph([
        ref("onsager_exact_solution"),
        " の証明 Step 3 は、",
        ref("W_has_positive_entries"),
        " から ",
        math(String.raw`c(M) \leq 2\Lambda^{(1/2)}_M`),
        " という**粗い上からの評価**を出し、Step 2 の ",
        math(String.raw`c(M) \geq \Lambda^{(1/2)}_M`),
        " と合わせて",
      ]),
      displayMath(
        String.raw`\Lambda^{(1/2)}_M \ \leq\ c(M) \ \leq\ 2\,\Lambda^{(1/2)}_M`,
      ),
      paragraph([
        "としていた。",
        ref("c_equals_c_plus"),
        " により、この挟み撃ちは**左側の等号**",
      ]),
      displayMath(String.raw`c(M) = \Lambda^{(1/2)}_M`),
      paragraph([
        "へ改善される。すなわち係数 ",
        math(String.raw`2`),
        " は不要である。",
      ]),
      paragraph([
        "**それでも ",
        ref("onsager_exact_solution"),
        " の証明はそのままにしてある。** 理由は 2 つある。",
      ]),
      list([
        [
          "第一に、",
          ref("onsager_exact_solution"),
          " は文書順でこの章より**前**にあるので、そこで ",
          ref("c_equals_c_plus"),
          " を引くと「先に読んだ定理が後の章の定理に依存する」という参照の逆流が起きる。",
          "本文は先頭から順に読めば各段が既出のものだけで正当化される形を保つ。",
        ],
        [
          "第二に、自由エネルギーの表式にとって係数 ",
          math(String.raw`2`),
          " は無害である。",
          math(String.raw`\tfrac1M\log`),
          " を取ると差は ",
          math(String.raw`(\log 2)/M`),
          " で、",
          math(String.raw`M \to \infty`),
          " で ",
          math(String.raw`0`),
          " に収束する。",
        ],
      ]),
      paragraph([
        "この章が加えているのは、表式そのものではなく**最大固有値の所在**である：",
        math(String.raw`W`),
        " の Rayleigh 商の上限は偶セクター ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の中で達成され、奇セクターはそれを超えない。",
      ]),
      paragraph([
        "なお、この章は ",
        math(String.raw`c_-(M)`),
        " の**値**については何も述べていない。",
        math(String.raw`c_+(M) = \Lambda^{(1/2)}_M`),
        " と対をなす ",
        math(String.raw`c_-(M) = \Lambda^{(0)}_M`),
        " は**一般には成り立たない**（",
        ref("onsager_exact_solution"),
        " の注記に記録した高温側の反例がある）。奇セクターについては、",
        math(String.raw`V^{(-)}`),
        " の最大固有値の固有ベクトルがどちらのセクターに落ちるかを ",
        ref("max_eigenvector_in_even_sector"),
        " と同じようには決められない。この章の主張は ",
        math(String.raw`c_-(M) \leq c_+(M)`),
        " という**不等号だけ**であり、それには ",
        math(String.raw`c_-(M)`),
        " の値は要らない。",
      ]),
    ],
    conversion: { status: "added" },
  },
]);
