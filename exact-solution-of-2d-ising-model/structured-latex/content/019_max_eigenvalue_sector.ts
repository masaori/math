import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/019_max_eigenvalue_sector.ts";

export default defineBlocks([
  {
    id: "heading_max_eigenvalue_sector",
    kind: "heading",
    level: 2,
    sourcePath: SRC,
    sourceOrdinal: 1,
    title: { tex: String.raw`\text{最大固有値はどちらのセクターから来るか：} c(M) = c_+(M)` },
    labels: [],
    conversion: { status: "added" },
  },

  {
    id: "sector_000_remark_overview",
    kind: "remark",
    sourcePath: SRC,
    sourceOrdinal: 2,
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        ref("sector_decomposition_of_rayleigh_sup"),
        " (3) は ",
        math(String.raw`c(M) = \max\left(c_+(M), c_-(M)\right)`),
        " を与えているだけで、**最大値がどちらのセクターから来るのかは決めていない**。",
        ref("onsager_exact_solution"),
        " はこの一点を避けて通れるように書いてある（",
        math(String.raw`c(M) \leq 2\,\Lambda^{(1/2)}_M`),
        " という粗い評価で済ませ、係数 ",
        math(String.raw`2`),
        " は ",
        math(String.raw`(\log 2)/M \to 0`),
        " で消える）。この章では、避けた一点を正面から決める：",
      ]),
      displayMath(
        String.raw`c_-(M) \ \leq\ c_+(M),
\qquad\text{したがって}\qquad
c(M) = c_+(M) = \Lambda^{(1/2)}_M`,
      ),
      paragraph([
        "**この主張は Onsager の自由エネルギーの表式そのものには不要である。**",
        ref("onsager_exact_solution"),
        " は既にこの章と独立に閉じている。ここで示すのは「最大固有値は偶セクター（",
        math(String.raw`\varepsilon`),
        " の固有値 ",
        math(String.raw`+1`),
        " の側）から来る」という、読者が転送行列の像をつかむために効く事実である。",
      ]),
      paragraph([
        "証明の筋は短い。",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " は標準基底のベクトルを別の標準基底のベクトルへ写す ",
        math(String.raw`0`),
        "／",
        math(String.raw`1`),
        " の**置換行列**であり（",
        ref("epsilon_is_flip_permutation"),
        "）、その置換は「全スピンの反転」である。したがって ",
        math(String.raw`x \in \mathcal{F}^{(-)}`),
        " の成分ごとの絶対値を取ったベクトル ",
        math(String.raw`u`),
        " は ",
        math(String.raw`\varepsilon u = u`),
        " を満たし、",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に落ちる（",
        ref("abs_of_sector_vector_is_even"),
        "）。一方 ",
        math(String.raw`W`),
        " の成分はすべて正（",
        ref("W_has_positive_entries"),
        "）なので、絶対値を取ると Rayleigh 商は減らない（",
        ref("rayleigh_quotient_under_absolute_value"),
        "）。この 2 つを合わせれば ",
        math(String.raw`c_-(M) \leq c_+(M)`),
        " が出る（",
        ref("c_minus_le_c_plus"),
        "）。",
      ]),
      paragraph([
        "この章で使う道具は、",
        math(String.raw`2^M`),
        " 次の実行列の成分計算・有限和・実数の三角不等式・上限の定義だけである。",
        "**新しい実数解析への移行はない**（",
        ref("remark_real_analysis_escape_point"),
        "）。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "sector_001_claim_epsilon_is_flip_permutation",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 3,
    title: { tex: String.raw`\varepsilon \text{ は「全スピン反転」の置換行列}` },
    labels: ["epsilon_is_flip_permutation"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_config_basis_iso"),
        " の全単射 ",
        math(String.raw`\iota : \mathfrak{M} \to \mathcal{I}`),
        " により ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の標準基底を ",
        math(String.raw`f_{\iota(s)}`),
        "（",
        math(String.raw`s \in \mathfrak{M}`),
        "）と書く。",
        math(String.raw`s \in \mathfrak{M}`),
        " に対し ",
        math(String.raw`(-s)(m) := -s(m)`),
        "（",
        math(String.raw`m \in \{1,\dots,M\}`),
        "）とおく。このとき次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \varepsilon\,f_{\iota(s)} = f_{\iota(-s)}
\qquad (s \in \mathfrak{M})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \varepsilon_{s,s'}
= \begin{cases} 1 & (s' = -s) \\ 0 & (s' \neq -s)\end{cases}
\qquad (s, s' \in \mathfrak{M})`),
          "。とくに ",
          math(String.raw`\varepsilon`),
          " の成分はすべて ",
          math(String.raw`0`),
          " か ",
          math(String.raw`1`),
          " である（**置換行列**）。ここで ",
          math(String.raw`\varepsilon_{s,s'} := \varepsilon_{\iota(s),\iota(s')}`),
          " と略記した（",
          ref("def_config_basis_iso"),
          " の同一視）。",
        ],
        [
          math(String.raw`\text{(3)}\quad x = \sum_{s\in\mathfrak{M}}x_s\,f_{\iota(s)}
\in \mathbb{C}^{2^M}
\ \Longrightarrow\ \left(\varepsilon x\right)_s = x_{-s}
\qquad (s \in \mathfrak{M})`),
        ],
        [
          math(String.raw`\text{(4)}\quad \|\varepsilon x\| = \|x\|
\qquad \left(x \in \mathbb{C}^{2^M}\right)`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("trace_of_epsilon_V_plus"),
        " の証明 Step 3 の (b) で示されている。要点だけ再掲すると、",
        ref("def_end_iso"),
        " の基底は ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_M}`),
        " であり、",
        ref("kronecker_product_rule"),
        " より ",
        math(String.raw`\sigma_m^x`),
        " は第 ",
        math(String.raw`m`),
        " 因子にだけ ",
        math(String.raw`\sigma^x`),
        " を作用させる。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^x`),
        " の成分から ",
        math(String.raw`\sigma^xe_1 = e_2`),
        "、",
        math(String.raw`\sigma^xe_2 = e_1`),
        " なので、",
        math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_M^x`),
        " は多重添字のすべての成分を ",
        math(String.raw`1 \leftrightarrow 2`),
        " で入れ替える。",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        "（",
        math(String.raw`+1\mapsto1`),
        "、",
        math(String.raw`-1\mapsto2`),
        "）のもとで、これは ",
        math(String.raw`s`),
        " を ",
        math(String.raw`-s`),
        " に取り替えることに他ならない。",
      ]),
      paragraph([
        "(2) 行列の成分の定義（",
        ref("mat_mult"),
        " と同じ約束）より ",
        math(String.raw`\varepsilon f_{\iota(s')}
= \sum_{s\in\mathfrak{M}}\varepsilon_{s,s'}f_{\iota(s)}`),
        " である。(1) より左辺は ",
        math(String.raw`f_{\iota(-s')}`),
        " なので、基底の表示の一意性から ",
        math(String.raw`\varepsilon_{s,s'} = 1`),
        "（",
        math(String.raw`s = -s'`),
        " のとき）、",
        math(String.raw`0`),
        "（それ以外）。",
        math(String.raw`s = -s'`),
        " と ",
        math(String.raw`s' = -s`),
        " は同値なので (2) の形になる。",
      ]),
      paragraph([
        "(3) (1) と行列の作用の ",
        math(String.raw`\mathbb{C}`),
        " 線型性から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\varepsilon x
&= \varepsilon\sum_{s\in\mathfrak{M}}x_s\,f_{\iota(s)} \\
&= \sum_{s\in\mathfrak{M}}x_s\left(\varepsilon f_{\iota(s)}\right)
   \quad (\because \text{行列の作用の } \mathbb{C} \text{ 線型性}) \\
&= \sum_{s\in\mathfrak{M}}x_s\,f_{\iota(-s)}
   \quad (\because \text{(1)}) \\
&= \sum_{s'\in\mathfrak{M}}x_{-s'}\,f_{\iota(s')}
   \quad (\because s \mapsto -s \text{ は } \mathfrak{M} \text{ の全単射なので }
   s' := -s \text{ と置き換えて足し直せる}) \\
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`s \mapsto -s`),
        " が全単射であることは ",
        math(String.raw`-(-s) = s`),
        " から従う。すなわちこの写像は自分自身の逆写像である。）基底の表示の一意性より ",
        math(String.raw`(\varepsilon x)_s = x_{-s}`),
        "。",
      ]),
      paragraph([
        "(4) (3) と、",
        math(String.raw`s \mapsto -s`),
        " が ",
        math(String.raw`\mathfrak{M}`),
        " の全単射であることから、有限和の項を並べ替えて",
      ]),
      displayMath(
        String.raw`\|\varepsilon x\|^2
= \sum_{s\in\mathfrak{M}}\left|\left(\varepsilon x\right)_s\right|^2
= \sum_{s\in\mathfrak{M}}\left|x_{-s}\right|^2
= \sum_{s'\in\mathfrak{M}}\left|x_{s'}\right|^2
= \|x\|^2
\quad (\because \text{(3) と } s' := -s \text{ による並べ替え})`,
      ),
      paragraph([
        "両辺は非負なので平方根を取って ",
        math(String.raw`\|\varepsilon x\| = \|x\|`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "018 章の trace_of_epsilon_V_plus の証明 Step 3 (b) が ε f_{ι(s)} = f_{ι(-s)} を示しているが、そこでは証明の途中の補助的な読み取りとして述べられているだけである。この章では ε の置換行列性そのものを繰り返し使うので、独立した主張として立て直した。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_01（M=2,…,6 で ε の全成分が 0/1、行番号 k の 1 が (2^M−1)−k の位置に立つこと、ε² = I、ε^⊤ = ε）。",
      ],
    },
  },

  {
    id: "sector_002_claim_abs_of_sector_vector_is_even",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 4,
    title: {
      tex: String.raw`x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}
\ \Longrightarrow\ |x| \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`,
    },
    labels: ["abs_of_sector_vector_is_even"],
    statement: [
      paragraph([
        math(String.raw`x \in \mathbb{R}^{2^M}`),
        " に対し、成分ごとの絶対値を取ったベクトルを",
      ]),
      displayMath(
        String.raw`|x| \in \mathbb{R}^{2^M}, \qquad
\left(|x|\right)_s := \left|x_s\right| \qquad (s \in \mathfrak{M})`,
      ),
      paragraph([
        "と書く（",
        ref("epsilon_is_flip_permutation"),
        " の成分表示による）。このとき、",
        ref("def_eigenspaces_of_epsilon"),
        " の ",
        math(String.raw`\mathcal{F}^{(\pm)}`),
        " について次が成り立つ（複号同順）。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^M}
\ \Longrightarrow\ \varepsilon\,|x| = |x|`),
          "、すなわち ",
          math(String.raw`|x| \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
          "。",
        ],
        [
          math(String.raw`\text{(2)}\quad \left\||x|\right\| = \|x\|
\qquad \left(x \in \mathbb{R}^{2^M}\right)`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(2) から示す。",
        math(String.raw`\left|\,|x_s|\,\right| = |x_s|`),
        " なので、",
      ]),
      displayMath(
        String.raw`\left\||x|\right\|^2
= \sum_{s\in\mathfrak{M}}\left|\,\left|x_s\right|\,\right|^2
= \sum_{s\in\mathfrak{M}}\left|x_s\right|^2
= \|x\|^2`,
      ),
      paragraph([
        "であり、両辺非負なので平方根を取ればよい。",
      ]),
      paragraph([
        "(1) ",
        math(String.raw`x \in \mathcal{F}^{(\pm)}`),
        " とする。",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`\varepsilon x = \pm x`),
        " であり、",
        ref("epsilon_is_flip_permutation"),
        " (3) より ",
        math(String.raw`(\varepsilon x)_s = x_{-s}`),
        " なので、成分ごとに",
      ]),
      displayMath(
        String.raw`x_{-s} = \pm\,x_s \qquad (s \in \mathfrak{M})
\quad (\because \text{def\_eigenspaces\_of\_epsilon と
epsilon\_is\_flip\_permutation (3)})`,
      ),
      paragraph([
        "が成り立つ。したがって各 ",
        math(String.raw`s \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\varepsilon\,|x|\right)_s
&= \left(|x|\right)_{-s}
   \quad \left(\because \text{epsilon\_is\_flip\_permutation (3) を } |x| \text{ に適用}\right) \\
&= \left|x_{-s}\right|
   \quad \left(\because |x| \text{ の定義}\right) \\
&= \left|\pm\,x_s\right|
   \quad \left(\because \text{直前の } x_{-s} = \pm x_s\right) \\
&= \left|x_s\right|
   \quad \left(\because |-t| = |t| \ (t \in \mathbb{R})\right) \\
&= \left(|x|\right)_s
   \quad \left(\because |x| \text{ の定義}\right)
\end{aligned}`,
      ),
      paragraph([
        "すべての成分が一致するので ",
        math(String.raw`\varepsilon|x| = |x|`),
        "、すなわち ",
        ref("def_eigenspaces_of_epsilon"),
        " より ",
        math(String.raw`|x| \in \mathcal{F}^{(+)}`),
        "。",
        math(String.raw`|x|`),
        " の成分は実数の絶対値なので ",
        math(String.raw`|x| \in \mathbb{R}^{2^M}`),
        " である。",
      ]),
      paragraph([
        "**",
        math(String.raw`\mathcal{F}^{(-)}`),
        " から出発しても行き先が ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " になる**のがこの主張の要点である。絶対値は符号 ",
        math(String.raw`\pm`),
        " を潰すので、",
        math(String.raw`x_{-s} = -x_s`),
        " であっても ",
        math(String.raw`|x_{-s}| = |x_s|`),
        " になるからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張が成り立つのは ε が 0/1 の置換行列だからで、一般の直交行列では成分ごとの絶対値との相性は無い。ε が「全スピン反転」という配置の置換であることが本質的に効いている。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_02（F^{(−)} の実基底から生成した多数のベクトル x について ε|x| = |x| と ‖|x|‖ = ‖x‖ を確認）。",
      ],
    },
  },

  {
    id: "sector_003_claim_rayleigh_under_absolute_value",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 5,
    title: { tex: String.raw`x^\top W x \leq |x|^\top W\,|x|` },
    labels: ["rayleigh_quotient_under_absolute_value"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_symmetrized_transfer_matrix"),
        " の ",
        math(String.raw`W`),
        " を考える。任意の ",
        math(String.raw`x \in \mathbb{R}^{2^M}`),
        " について",
      ]),
      displayMath(String.raw`x^\top W x \ \leq\ \left|x\right|^\top W\left|x\right|`),
      paragraph([
        "が成り立つ（",
        math(String.raw`|x|`),
        " は ",
        ref("abs_of_sector_vector_is_even"),
        " の記号）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("W_is_real_symmetric_positive_definite"),
        " より ",
        math(String.raw`W`),
        " の成分は実数である。",
        ref("W_has_positive_entries"),
        " より ",
        math(String.raw`W_{s,s'} > 0`),
        "（",
        math(String.raw`s, s' \in \mathfrak{M}`),
        "）であり、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " が全単射なので、これで ",
        math(String.raw`W`),
        " のすべての成分を尽くしている。",
      ]),
      paragraph([
        "行列の積とベクトルの内積の成分表示より ",
        math(String.raw`x^\top Wx = \sum_{s,s'\in\mathfrak{M}}x_s\,x_{s'}\,W_{s,s'}`),
        " である。有限和に実数の三角不等式を適用する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&= \sum_{s,s'\in\mathfrak{M}}x_s\,x_{s'}\,W_{s,s'} \\
&\leq \left|\sum_{s,s'\in\mathfrak{M}}x_s\,x_{s'}\,W_{s,s'}\right|
   \quad \left(\because t \leq |t| \ (t \in \mathbb{R})\right) \\
&\leq \sum_{s,s'\in\mathfrak{M}}\left|x_s\,x_{s'}\,W_{s,s'}\right|
   \quad (\because \text{有限個の実数の和に対する三角不等式}) \\
&= \sum_{s,s'\in\mathfrak{M}}\left|x_s\right|\left|x_{s'}\right|\,W_{s,s'}
   \quad \left(\because |ab| = |a||b| \text{ と } W_{s,s'} > 0
   \text{（W\_has\_positive\_entries）より } \left|W_{s,s'}\right| = W_{s,s'}\right) \\
&= \sum_{s,s'\in\mathfrak{M}}\left(|x|\right)_s\left(|x|\right)_{s'}W_{s,s'}
   \quad \left(\because \text{abs\_of\_sector\_vector\_is\_even の } |x| \text{ の定義}\right) \\
&= \left|x\right|^\top W\left|x\right|
   \quad (\because \text{再び成分表示})
\end{aligned}`,
      ),
      paragraph([
        "**",
        math(String.raw`W_{s,s'} > 0`),
        " が効いているのは 4 段目である**：",
        math(String.raw`|W_{s,s'}| = W_{s,s'}`),
        " でなければ最後の 2 段は成り立たない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "これは Perron–Frobenius の定理の証明で「正行列の最大固有ベクトルは符号を揃えられる」ことを示す際の核心の不等式にあたる。ただし本文では Perron–Frobenius の一般論は使わず、必要な向きの不等式を成分計算で直接出している（README のゴール設定 2 節・3 節）。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_02（乱数ベクトルを含む多数の x で x^⊤Wx ≤ |x|^⊤W|x| を確認）。",
      ],
    },
  },

  {
    id: "sector_004_theorem_c_minus_le_c_plus",
    kind: "theorem",
    sourcePath: SRC,
    sourceOrdinal: 6,
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
      paragraph(["について"]),
      displayMath(String.raw`c_-(M) \ \leq\ c_+(M)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取り、",
        math(String.raw`u := |x|`),
        "（",
        ref("abs_of_sector_vector_is_even"),
        " の記号）とおく。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`u`),
        " は ",
        math(String.raw`c_+(M)`),
        " を定める集合の候補である）。",
        ref("abs_of_sector_vector_is_even"),
        " (1) を ",
        math(String.raw`\mathcal{F}^{(-)}`),
        " の側に適用して ",
        math(String.raw`u \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        "、同 (2) より ",
        math(String.raw`\|u\| = \|x\| = 1`),
        "。よって ",
        math(String.raw`u`),
        " は ",
        math(String.raw`c_+(M)`),
        " を定める集合の添字条件を満たす。",
      ]),
      paragraph([
        "Step 2（不等式の連鎖）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&\leq u^\top W u
   \quad (\because \text{rayleigh\_quotient\_under\_absolute\_value と } u = |x|) \\
&\leq c_+(M)
   \quad (\because \text{Step 1 と sector\_decomposition\_of\_rayleigh\_sup の }
   c_+(M) \text{ の定義（上限）})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（上限を取る）。Step 2 は ",
        math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取って成り立つので、",
        math(String.raw`c_+(M)`),
        " は集合",
      ]),
      displayMath(
        String.raw`\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^M},\ \|x\| = 1 \,\right\}`,
      ),
      paragraph([
        "の上界である。",
        ref("sector_decomposition_of_rayleigh_sup"),
        " の ",
        math(String.raw`c_-(M)`),
        " はこの集合の上限（最小の上界）なので ",
        math(String.raw`c_-(M) \leq c_+(M)`),
        "。",
      ]),
      paragraph([
        "（この集合が空でないことは ",
        math(String.raw`M \geq 2`),
        " から従う。実際 ",
        math(String.raw`s_0 \in \mathfrak{M}`),
        " を 1 つ取ると ",
        math(String.raw`-s_0 \neq s_0`),
        " なので ",
        math(String.raw`w := \tfrac{1}{\sqrt2}\left(f_{\iota(s_0)} - f_{\iota(-s_0)}\right)`),
        " は ",
        ref("epsilon_is_flip_permutation"),
        " (1) より ",
        math(String.raw`\varepsilon w = \tfrac{1}{\sqrt2}
\left(f_{\iota(-s_0)} - f_{\iota(s_0)}\right) = -w`),
        " を満たす実の単位ベクトルである。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この不等式は「W の成分がすべて正である」ことだけから出ており、V^{(-)} の固有値（整数運動量の側）にはいっさい触れていない。実際 c_-(M) = Λ^{(0)}_M は一般には成り立たず（018 章 onsager_exact_solution の注記、高温側 (K_1,K_2) = (0.05,0.1) で比 0.1102）、c_-(M) の値そのものを求めるのは別の問題である。ここで必要なのは不等号だけである。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_03（M=2,3,4,5・6 組の (K_1,K_2) で c_−(M) ≤ c_+(M) を直接確認。比 c_−/c_+ も記録）。",
      ],
    },
  },

  {
    id: "sector_005_theorem_c_equals_c_plus",
    kind: "theorem",
    sourcePath: SRC,
    sourceOrdinal: 7,
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
        " について",
      ]),
      displayMath(
        String.raw`c(M) = c_+(M) = \Lambda^{(1/2)}_M
= (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu\in\check{\mathcal{M}}}\gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
        " は ",
        ref("def_check_index_set"),
        "、",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\tfrac12\right)}{M}`),
        " は ",
        ref("def_half_integer_modes"),
        "、",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        "）。",
      ]),
      paragraph([
        "とくに ",
        math(String.raw`c(M)`),
        " の**上限は達成され**、それを達成する単位ベクトルは ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に取れる。すなわち**最大値は偶セクターから来る**。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
c(M)
&= \max\left(c_+(M),\, c_-(M)\right)
   \quad (\because \text{sector\_decomposition\_of\_rayleigh\_sup (3)}) \\
&= c_+(M)
   \quad (\because \text{c\_minus\_le\_c\_plus の } c_-(M) \leq c_+(M)
   \text{ より } \max\left(c_+(M), c_-(M)\right) = c_+(M)) \\
&= \Lambda^{(1/2)}_M
   \quad (\because \text{c\_plus\_equals\_Lambda\_half\_integer})
\end{aligned}`,
      ),
      paragraph([
        "最後の表式は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " が与えているものである。",
      ]),
      paragraph([
        "上限が達成されることも同じ主張から従う。",
        ref("c_plus_equals_Lambda_half_integer"),
        " の証明 Step 3 で構成された ",
        math(String.raw`x_0 \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^M}`),
        "、",
        math(String.raw`\|x_0\| = 1`),
        " は ",
        math(String.raw`x_0^\top Wx_0 = \check\Lambda_{\max} = c_+(M)`),
        " を満たす。",
        math(String.raw`x_0`),
        " は ",
        math(String.raw`\mathbb{R}^{2^M}`),
        " の単位ベクトルでもあるので ",
        ref("def_rayleigh_sup"),
        " の ",
        math(String.raw`\mathcal{R}`),
        " の元でもあり、その値が上限 ",
        math(String.raw`c(M) = c_+(M)`),
        " に一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_03（M=2,3,4,5・6 組の (K_1,K_2) で c(M) = c_+(M) = Λ^{(1/2)}_M。W の最大固有値を直接求めて比較）。",
      ],
    },
  },

  {
    id: "sector_006_remark_step3_bound_is_equality",
    kind: "remark",
    sourcePath: SRC,
    sourceOrdinal: 8,
    title: {
      tex: String.raw`\text{018 章の } c(M) \leq 2\Lambda^{(1/2)}_M \text{ は等号へ改善される}`,
    },
    labels: ["remark_step3_bound_is_equality"],
    statement: [
      paragraph([
        ref("onsager_exact_solution"),
        " の証明 Step 3 は、",
        math(String.raw`W`),
        " の成分の正値性から",
      ]),
      displayMath(String.raw`c(M) \ \leq\ 2\,\Lambda^{(1/2)}_M`),
      paragraph([
        " という**粗い評価**を出していた。",
        ref("c_equals_c_plus"),
        " により、これは",
      ]),
      displayMath(String.raw`c(M) = \Lambda^{(1/2)}_M`),
      paragraph([
        " という等号へ改善される。すなわち ",
        ref("onsager_exact_solution"),
        " の Step 4 の挟み撃ち ",
        math(String.raw`\Lambda^{(1/2)}_M \leq c(M) \leq 2\Lambda^{(1/2)}_M`),
        " は、上下の評価が一致する。",
      ]),
      paragraph([
        "**それでも ",
        ref("onsager_exact_solution"),
        " の証明は書き換えない。** 理由は 2 つある。",
      ]),
      list([
        [
          "第 1 に、極限の値は変わらない。粗い評価の余りは ",
          math(String.raw`(\log 2)/M`),
          " であり、",
          math(String.raw`M \to \infty`),
          " で ",
          math(String.raw`0`),
          " に収束するので、",
          ref("onsager_exact_solution"),
          " の結論はどちらの評価からも同じである。",
        ],
        [
          "第 2 に、この章は ",
          ref("onsager_exact_solution"),
          " の**後**に置かれている。",
          ref("c_equals_c_plus"),
          " を ",
          ref("onsager_exact_solution"),
          " の証明の中で使うと、先に読む主張が後から出る主張に依存することになる。",
          "**この文書は頭から順に積み上げて読めることを要求している**ので、その依存は作らない。",
        ],
      ]),
      paragraph([
        "論理的な循環は無いことを確認しておく。",
        ref("c_equals_c_plus"),
        " が使うのは ",
        ref("sector_decomposition_of_rayleigh_sup"),
        "（011 章）、",
        ref("W_has_positive_entries"),
        "（011 章）、",
        ref("trace_of_epsilon_V_plus"),
        "（018 章、",
        math(String.raw`\varepsilon`),
        " が置換行列であることの出どころ）、",
        ref("c_plus_equals_Lambda_half_integer"),
        "（018 章）だけであり、",
        ref("onsager_exact_solution"),
        " は使っていない。したがって ",
        ref("onsager_exact_solution"),
        " の Step 3 を等号で置き換えることは論理的には可能である。上の第 2 の理由（読む順序）だけでそうしていない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "018 章 onsager_exact_solution の注記が「Step 3 の係数 2 は最良ではない（数値では c(M) = c_+(M) が全パラメータで成り立つ）」と記録していた点が、この章で本文の定理として確定した。",
        "数値検証: sagemath/check/054_claim_max_eigenvalue_sector/check_03（挟み撃ちの上下の評価と c(M) の値を並べて出力。c(M)/Λ^{(1/2)}_M = 1 と c(M)/(2Λ^{(1/2)}_M) = 1/2 を確認）。",
      ],
    },
  },
]);
