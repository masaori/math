import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

const SYMBOL_NOTE =
  "2026-09-26: 記号を列数 M_col・行数 N_row・結合定数 K_1, K_2 に統一し、行列の添字の番号付け ord を明示した。";
const SINGLE_DEFINITION_NOTE =
  "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。";

export default defineBlocks([
  {
    id: "heading_partition_function_2d_ising",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 2 },
    title: { text: "2次元ising模型の分配関数" },
    labels: [],
  },
  {
    id: "partition_function_2d_ising_001_definition_lattice_size",
    kind: "definition",
    origin: { path: "_old/typst/parts/001_2次元ising模型の分配関数/000_definition_格子サイズ.typ", ordinal: 1 },
    title: { text: "格子サイズ" },
    labels: ["def_lattice_size"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}, N_{\mathrm{row}} \in \mathbb{Z}_{\geq 1}`),
        " とし、これらを格子のサイズとする。格子は ",
        math(String.raw`N_{\mathrm{row}}`),
        " 本の行と ",
        math(String.raw`M_{\mathrm{col}}`),
        " 本の列からなる。すなわち ",
        math(String.raw`M_{\mathrm{col}}`),
        " は 1 つの行に並ぶサイトの数（列数）、",
        math(String.raw`N_{\mathrm{row}}`),
        " は行の数（行数）である。",
      ]),
    ],
    conversion: { status: "converted", notes: [SYMBOL_NOTE] },
  },
  {
    id: "partition_function_2d_ising_002_definition_partition_function",
    kind: "definition",
    origin: {
      path: "_old/typst/parts/001_2次元ising模型の分配関数/001_definition_2次元ising模型の分配関数.typ",
      ordinal: 2,
    },
    title: { text: "2次元ising模型の分配関数" },
    labels: ["def_partition_function_2d_ising"],
    statement: [
      paragraph([
        ref("def_lattice_size"),
        " の列数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " と行数 ",
        math(String.raw`N_{\mathrm{row}}`),
        " を固定する。",
        math(String.raw`Z : \mathbb{R}_{>0} \times \mathbb{R}_{>0} \to \mathbb{R}_{>0}`),
        " を以下のように定める。",
      ]),
      paragraph([
        "スピン配置の全体を",
      ]),
      displayMath(
        String.raw`\mathfrak{S} := \mathrm{Map}(\{1,\dots,N_{\mathrm{row}}\}\times\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`s \in \mathfrak{S}`),
        " の値 ",
        math(String.raw`s(i,j)`),
        " の第 1 引数 ",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        " は行、第 2 引数 ",
        math(String.raw`j\in\{1,\dots,M_{\mathrm{col}}\}`),
        " は列を表す。",
      ]),
      paragraph([
        math(String.raw`s`),
        " の定義域は ",
        math(String.raw`\{1,\dots,N_{\mathrm{row}}\}\times\{1,\dots,M_{\mathrm{col}}\}`),
        " であって ",
        math(String.raw`s(N_{\mathrm{row}}+1,j)`),
        "、",
        math(String.raw`s(i,M_{\mathrm{col}}+1)`),
        " はそのままでは定義されない。以下では ",
        math(String.raw`s`),
        " を両方向に周期的に延長したもの（周期境界条件）を用いる。すなわち ",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        "、",
        math(String.raw`j\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して",
      ]),
      displayMath(
        String.raw`s(N_{\mathrm{row}}+1, j) := s(1, j), \qquad s(i, M_{\mathrm{col}}+1) := s(i, 1)`,
      ),
      paragraph([
        "と定める。結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " のうち、",
        math(String.raw`K_1`),
        " は同じ行の隣り合うサイトの組 ",
        math(String.raw`s(i,j)\,s(i,j+1)`),
        " を、",
        math(String.raw`K_2`),
        " は隣り合う行の同じ列のサイトの組 ",
        math(String.raw`s(i,j)\,s(i+1,j)`),
        " を結ぶ。",
      ]),
      displayMath(
        String.raw`Z(K_1, K_2) := \sum_{s \in \mathfrak{S}} \exp\!\left(\sum_{\substack{i\in\{1,\dots,N_{\mathrm{row}}\}\\j\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,s(i,j)\,s(i,j+1) + K_2\,s(i,j)\,s(i+1,j)\bigr)\right)`,
      ),
      paragraph([
        "周期境界条件のもとで被加数の指数の肩はすべて ",
        math(String.raw`\mathbb{R}`),
        " の元として定まる。",
        math(String.raw`\mathfrak{S}`),
        " は有限集合（",
        math(String.raw`|\mathfrak{S}| = 2^{M_{\mathrm{col}} N_{\mathrm{row}}}`),
        "）であり、各項は ",
        math(String.raw`\mathbb{R}_{>0}`),
        " の元であるから、右辺は有限和として無条件に定まる（収束の議論を要しない）。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は周期境界条件（s(M+1,j)=s(1,j), s(i,N+1)=s(i,1)）を明示していないが、" +
          "これが無いと総和の被加数 s(M+1,j), s(i,N+1) が未定義になり定義自体が成立しない。" +
          "定義が意味をもつために必要な規約なので statement に明記した。",
        SYMBOL_NOTE +
          "旧版の Z(J, J') は第 1 引数（周期 M）方向に J、第 2 引数（周期 N）方向に J' を置いていた。" +
          "新しい記号では第 1 引数を行 i（周期 N_row）、第 2 引数を列 j（周期 M_col）とし、" +
          "同じ行の隣接に K_1（旧 J'）、隣接行の同じ列に K_2（旧 J）を置く。すなわち Z(K_1, K_2) は旧版の Z(J, J') で J = K_2、J' = K_1 としたものに等しい。",
      ],
    },
  },
  {
    id: "partition_function_2d_ising_definition_row_configurations",
    kind: "definition",
    origin: { path: "structured-latex/content/001_partition_function_2d_ising.ts", ordinal: 3 },
    title: { text: "1 行ぶんのスピン配置の全体" },
    labels: ["def_row_configurations"],
    statement: [
      paragraph([
        ref("def_lattice_size"),
        " の列数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " について、1 つの行に並ぶ ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個のサイトのスピン配置の全体を",
      ]),
      displayMath(String.raw`\mathfrak{M} := \mathrm{Map}(\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`),
      paragraph(["と定める。"]),
    ],
    conversion: { status: "added", notes: [SYMBOL_NOTE] },
  },
  {
    id: "partition_function_2d_ising_definition_row_configuration_numbering",
    kind: "definition",
    origin: { path: "structured-latex/content/001_partition_function_2d_ising.ts", ordinal: 4 },
    title: { text: "1 行ぶんのスピン配置の番号付け" },
    labels: ["def_row_configuration_numbering"],
    statement: [
      paragraph([
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M}`),
        " について、写像 ",
        math(String.raw`\mathrm{ord} : \mathfrak{M} \to \mathbb{Z}`),
        " を",
      ]),
      displayMath(
        String.raw`\mathrm{ord}(\mu) := 1 + \sum_{m=1}^{M_{\mathrm{col}}} \frac{1-\mu(m)}{2}\cdot 2^{M_{\mathrm{col}}-m}
\qquad (\mu \in \mathfrak{M})`,
      ),
      paragraph([
        "で定める。",
        math(String.raw`\mu(m) \in \{-1,1\}`),
        " より ",
        math(String.raw`\tfrac{1-\mu(m)}{2}`),
        " は ",
        math(String.raw`\mu(m)=1`),
        " のとき ",
        math(String.raw`0`),
        "、",
        math(String.raw`\mu(m)=-1`),
        " のとき ",
        math(String.raw`1`),
        " であり、右辺は整数の有限和である。",
      ]),
    ],
    conversion: { status: "added", notes: [SYMBOL_NOTE] },
  },
  {
    id: "partition_function_2d_ising_claim_row_configuration_numbering_bijective",
    kind: "claim",
    origin: { path: "structured-latex/content/001_partition_function_2d_ising.ts", ordinal: 5 },
    title: { text: "1 行ぶんのスピン配置の番号付けは全単射" },
    labels: ["row_configuration_numbering_bijective"],
    statement: [
      paragraph([
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        " の値はすべて ",
        math(String.raw`\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " に属し、",
        math(String.raw`\mathrm{ord} : \mathfrak{M} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " は全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中だけで ",
        math(String.raw`b_m(\mu) := \tfrac{1-\mu(m)}{2} \in \{0,1\}`),
        "（",
        math(String.raw`\mu\in\mathfrak{M}`),
        "、",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        "）と書く。",
        math(String.raw`b_m(\mu)=0 \iff \mu(m)=1`),
        " である。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`n\in\mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`\sum_{t=0}^{n-1}2^{t}=2^{n}-1`),
        " を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n=0`),
        " のときは空和で ",
        math(String.raw`0=2^0-1`),
        "。",
        math(String.raw`n`),
        " で成り立つとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{t=0}^{n}2^t
&=\sum_{t=0}^{n-1}2^t+2^n
   &&(\because \text{有限和の最後の項を分ける}) \\
&=(2^n-1)+2^n
   &&(\because \text{帰納法の仮定}) \\
&=2\cdot 2^n-1
   &&(\because \text{加法の結合則と }2^n+2^n=2\cdot 2^n) \\
&=2^{n+1}-1
   &&(\because \text{指数法則}\ 2\cdot 2^n=2^{n+1})
\end{aligned}`,
      ),
      paragraph(["中間目標: 値域。", math(String.raw`\mu\in\mathfrak{M}`), " を任意に取る。"]),
      displayMath(
        String.raw`\begin{aligned}
0
&\le \sum_{m=1}^{M_{\mathrm{col}}} b_m(\mu)\,2^{M_{\mathrm{col}}-m}
   &&(\because \text{各項は }b_m(\mu)\ge 0\text{ と }2^{M_{\mathrm{col}}-m}>0\text{ の積で非負}) \\
&\le \sum_{m=1}^{M_{\mathrm{col}}} 2^{M_{\mathrm{col}}-m}
   &&(\because \text{各項で }b_m(\mu)\le 1\text{ かつ }2^{M_{\mathrm{col}}-m}>0) \\
&= \sum_{t=0}^{M_{\mathrm{col}}-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M_{\mathrm{col}}-m) \\
&= 2^{M_{\mathrm{col}}}-1
   &&(\because \text{準備の等比和を }n:=M_{\mathrm{col}}\text{ で})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`1 \le \mathrm{ord}(\mu) \le 2^{M_{\mathrm{col}}}`),
        " であり、",
        math(String.raw`\mathrm{ord}(\mu)\in\mathbb{Z}`),
        " だから ",
        math(String.raw`\mathrm{ord}(\mu)\in\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "。",
      ]),
      paragraph([
        "中間目標: 単射性。",
        math(String.raw`\mu,\mu'\in\mathfrak{M}`),
        "、",
        math(String.raw`\mu\neq\mu'`),
        " とし、",
        math(String.raw`\mu(k)\neq\mu'(k)`),
        " となる最小の ",
        math(String.raw`k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " をとる。必要なら ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`\mu'`),
        " を入れ替えて ",
        math(String.raw`\mu(k)=-1,\ \mu'(k)=1`),
        "、すなわち ",
        math(String.raw`b_k(\mu)=1,\ b_k(\mu')=0`),
        " としてよい。",
        math(String.raw`l<k`),
        " では ",
        math(String.raw`b_l(\mu)=b_l(\mu')`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{ord}(\mu)-\mathrm{ord}(\mu')
&= \sum_{l=1}^{M_{\mathrm{col}}}\bigl(b_l(\mu)-b_l(\mu')\bigr)2^{M_{\mathrm{col}}-l}
   &&(\because \blkref{def_row_configuration_numbering}\text{ の差を項ごとに取る}) \\
&= \sum_{l=k}^{M_{\mathrm{col}}}\bigl(b_l(\mu)-b_l(\mu')\bigr)2^{M_{\mathrm{col}}-l}
   &&(\because l<k\text{ では項が }0) \\
&= 2^{M_{\mathrm{col}}-k} + \sum_{l=k+1}^{M_{\mathrm{col}}}\bigl(b_l(\mu)-b_l(\mu')\bigr)2^{M_{\mathrm{col}}-l}
   &&(\because l=k\text{ の項を分ける。}b_k(\mu)-b_k(\mu')=1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`b_l(\mu)-b_l(\mu')\in\{-1,0,1\}`),
        " より、残りの和について次が成り立つ。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left|\sum_{l=k+1}^{M_{\mathrm{col}}}\bigl(b_l(\mu)-b_l(\mu')\bigr)2^{M_{\mathrm{col}}-l}\right|
&\le \sum_{l=k+1}^{M_{\mathrm{col}}}\bigl|b_l(\mu)-b_l(\mu')\bigr|\,2^{M_{\mathrm{col}}-l}
   &&(\because \text{三角不等式と }2^{M_{\mathrm{col}}-l}>0) \\
&\le \sum_{l=k+1}^{M_{\mathrm{col}}}2^{M_{\mathrm{col}}-l}
   &&(\because \text{各項で }|b_l(\mu)-b_l(\mu')|\le 1) \\
&= \sum_{t=0}^{M_{\mathrm{col}}-k-1}2^{t}
   &&(\because \text{添字の置き換え }t:=M_{\mathrm{col}}-l) \\
&= 2^{M_{\mathrm{col}}-k}-1
   &&(\because \text{準備の等比和を }n:=M_{\mathrm{col}}-k\text{ で}) \\
&< 2^{M_{\mathrm{col}}-k}
   &&(\because 2^{M_{\mathrm{col}}-k}-1<2^{M_{\mathrm{col}}-k})
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\mathrm{ord}(\mu)-\mathrm{ord}(\mu')\neq 0`),
        " であり、",
        math(String.raw`\mathrm{ord}`),
        " は単射である。",
      ]),
      paragraph([
        "中間目標: 全単射性。",
        math(String.raw`\mathfrak{M}`),
        " の元は ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の各サイトに ",
        math(String.raw`\{-1,1\}`),
        " の 2 通りの値を独立に割り当てたものだから ",
        math(String.raw`|\mathfrak{M}| = 2^{M_{\mathrm{col}}} = |\{1,\dots,2^{M_{\mathrm{col}}}\}|`),
        " である。元数の等しい有限集合の間の単射は全射でもある（像は ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の元をもつ ",
        math(String.raw`\{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " の部分集合、すなわち全体）。ゆえに ",
        math(String.raw`\mathrm{ord}`),
        " は全単射である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        SYMBOL_NOTE +
          "旧版は行・列の番号と 𝔐 の間の全単射を「ひとつ固定して同一視する（取り方に依らない）」としていた。" +
          "その全単射を 2 進展開の式 ord として明示し、全単射であることをこの主張で示した。論法は <def_kronecker> の番号付け ν の証明と同じである。",
      ],
    },
  },
  {
    id: "partition_function_2d_ising_003_definition_transfer_matrix",
    kind: "definition",
    origin: { path: "_old/typst/parts/001_2次元ising模型の分配関数/002_definition_転送行列.typ", ordinal: 3 },
    title: { text: "転送行列" },
    labels: ["def_transfer_matrix"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M}`),
        "、",
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        " を用いる。",
        math(String.raw`\mu \in \mathfrak{M}`),
        " の定義域は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " であって ",
        math(String.raw`\mu(M_{\mathrm{col}}+1)`),
        " はそのままでは定義されないため、",
        ref("def_partition_function_2d_ising"),
        " と同じく周期的に延長して",
      ]),
      displayMath(String.raw`\mu(M_{\mathrm{col}}+1) := \mu(1)`),
      paragraph([
        "とする。",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}}, \mathbb{C})`),
        " を、",
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1)_{\mathrm{ord}(\mu),\,\mathrm{ord}(\mu')} &:= \delta_{\mu=\mu'} \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\,\mu(m+1)\right) \\
(V_2)_{\mathrm{ord}(\mu),\,\mathrm{ord}(\mu')} &:= \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\,\mu'(m)\right)
\end{aligned}`,
      ),
      paragraph([
        "で定める。",
        ref("row_configuration_numbering_bijective"),
        " より ",
        math(String.raw`\mathrm{ord} : \mathfrak{M} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " は全単射なので、各 ",
        math(String.raw`(k,l)\in\{1,\dots,2^{M_{\mathrm{col}}}\}^2`),
        " はただ 1 つの ",
        math(String.raw`(\mu,\mu')\in\mathfrak{M}\times\mathfrak{M}`),
        " について ",
        math(String.raw`(k,l)=(\mathrm{ord}(\mu),\mathrm{ord}(\mu'))`),
        " と書ける。ゆえにこの式ですべての成分がただ 1 通りに定まる。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`\delta_{\mu=\mu'} \in \{0,1\}`),
        " は、",
        math(String.raw`\mu = \mu'`),
        "（写像として一致、すなわち ",
        math(String.raw`\forall m\in\{1,\dots,M_{\mathrm{col}}\},\ \mu(m)=\mu'(m)`),
        "）のとき ",
        math(String.raw`1`),
        "、そうでないとき ",
        math(String.raw`0`),
        " とする。",
      ]),
      paragraph([
        "指数の肩は ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`\mu(m),\mu'(m)\in\{-1,1\}\subset\mathbb{R}`),
        " の有限個の積和なので ",
        math(String.raw`\mathbb{R}`),
        " の元であり、",
        math(String.raw`\exp`),
        " の値は ",
        math(String.raw`\mathbb{R}_{>0} \subset \mathbb{C}`),
        " に属する。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文は (V_1) の行内相互作用に J、(V_2) の行間相互作用に J' を割り当てているが、" +
          "def_partition_function_2d_ising の Z(J,J') では J が第1引数方向（周期 M）、J' が第2引数方向（周期 N）の" +
          "結合定数である。tr((V_1V_2)^M) では転送の回数が M（第1引数方向）、各 μ の成分数が N（第2引数方向）に" +
          "対応するため、原文どおりでは J と J' が入れ替わり、M≠N のとき Z(J,J') と一致しない" +
          "（成立するのは Z(J',J) との一致）。主張 Z(J,J')=tr((V_1V_2)^M) が成り立つよう、" +
          "補助的な定義である V_1, V_2 の側で J と J' を入れ替えて訂正した。" +
          "原文は周期境界条件 μ(N+1)=μ(1) と添え字集合の 2^N 次元との同一視も明示していないため、" +
          "定義が意味をもつために必要な事項として補った。",
        SYMBOL_NOTE +
          "旧版の「行・列の番号と 𝔐 の間の全単射をひとつ固定して同一視する（取り方に依らない）」を、" +
          "<def_row_configuration_numbering> の ord による成分の指定へ置き換えた。",
        SINGLE_DEFINITION_NOTE,
      ],
    },
  },
  {
    id: "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
    kind: "claim",
    standing: "mainTheorem",
    origin: {
      path: "_old/typst/parts/001_2次元ising模型の分配関数/003_claim_転送行列による分配関数の表式.typ",
      ordinal: 4,
    },
    title: { text: "転送行列による分配関数の表式" },
    labels: ["partition_function_via_transfer_matrix"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z`),
        " と ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " について、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " のとき",
      ]),
      displayMath(String.raw`Z(K_1, K_2) = \mathrm{tr}\!\left((V_1 V_2)^{N_{\mathrm{row}}}\right)`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M}`),
        "、",
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        "、",
        ref("def_transfer_matrix"),
        " の周期規約 ",
        math(String.raw`\mu(M_{\mathrm{col}}+1)=\mu(1)`),
        " を用い、",
        math(String.raw`A := V_1 V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく。行方向の周期規約として、",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})})\in\mathfrak{M}^{N_{\mathrm{row}}}`),
        " に対し ",
        math(String.raw`\mu^{(N_{\mathrm{row}}+1)} := \mu^{(1)}`),
        " と置く。",
      ]),
      paragraph([
        "本証明に現れる総和はすべて有限集合上の和であり、値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。したがって和の順序交換・結合・分配は ",
        math(String.raw`\mathbb{C}`),
        " の可換環の公理から有限帰納法で従い、収束や極限の議論を一切要しない。",
      ]),
      paragraph([
        "準備として、写像 ",
        math(String.raw`g : \{1,\dots,2^{M_{\mathrm{col}}}\} \to \mathbb{C}`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{k=1}^{2^{M_{\mathrm{col}}}} g(k) = \sum_{\nu\in\mathfrak{M}} g(\mathrm{ord}(\nu))
\qquad \bigl(\because\ \blkref{row_configuration_numbering_bijective}\text{ の全単射による有限和の添字の付け替え}\bigr)
\tag{R}`,
      ),

      paragraph(["中間目標: 転送行列の積の成分。"]),
      paragraph([
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}} (V_1)_{\mathrm{ord}(\mu),k}\,(V_2)_{k,\mathrm{ord}(\mu')}
&&(\because\ \blkref{mat_mult}) \\
&= \sum_{\nu \in \mathfrak{M}} (V_1)_{\mathrm{ord}(\mu),\mathrm{ord}(\nu)}\,(V_2)_{\mathrm{ord}(\nu),\mathrm{ord}(\mu')}
&&(\because\ (\mathrm{R})) \\
&= \sum_{\nu \in \mathfrak{M}} \delta_{\mu=\nu}
   \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu(m+1)\right)
   \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \nu(m)\mu'(m)\right)
&&(\because\ \blkref{def_transfer_matrix}) \\
&= \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu(m+1)\right)
   \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu'(m)\right)
&&(\because\ \delta_{\mu=\nu}\ \text{は}\ \nu=\mu\ \text{のときだけ}\ 1\ \text{で他は}\ 0) \\
&= \exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu(m+1) + K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu'(m)\right)
&&(\because\ \blkref{theorem_exp_product}\ \text{を}\ n=1,\ K=\mathbb{R}\ \text{へ適用する}) \\
&= \exp\!\left(\sum_{m=1}^{M_{\mathrm{col}}} \bigl(K_1\,\mu(m)\mu(m+1) + K_2\,\mu(m)\mu'(m)\bigr)\right)
&&(\because\ \mathbb{R}\ \text{の分配則と有限和の項別加法})
\end{aligned}`,
      ),
      paragraph(["中間目標: 行列の冪の成分。"]),
      paragraph([
        "任意の ",
        math(String.raw`r \in \mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`\mu^{(1)}, \mu^{(r+1)} \in \mathfrak{M}`),
        " に対して次が成り立つことを、",
        math(String.raw`r`),
        " についての帰納法で示す。",
      ]),
      displayMath(
        String.raw`\left(A^r\right)_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(r+1)})}
= \sum_{(\mu^{(2)},\dots,\mu^{(r)}) \in \mathfrak{M}^{r-1}} \ \prod_{k=1}^{r} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
\tag{*}`,
      ),
      paragraph([
        math(String.raw`r = 1`),
        " の場合である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A^1\right)_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(2)})}
&= A_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(2)})}
&&(\because\ \text{行列の}\ 1\ \text{乗はその行列自身である}) \\
&= \prod_{k=1}^{1} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&&(\because\ \text{因子が}\ 1\ \text{つの有限積はその因子である}) \\
&= \sum_{(\ ) \in \mathfrak{M}^{0}} \ \prod_{k=1}^{1} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&&(\because\ \mathfrak{M}^{0}\ \text{は空列のみからなる}\ 1\ \text{点集合である})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`r`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つと仮定し、",
        math(String.raw`\mu^{(1)}, \mu^{(r+2)} \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A^{r+1}\right)_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(r+2)})}
&= \sum_{l=1}^{2^{M_{\mathrm{col}}}} \left(A^{r}\right)_{\mathrm{ord}(\mu^{(1)}),l} \, A_{l,\mathrm{ord}(\mu^{(r+2)})}
&&(\because\ A^{r+1}=A^r A\ \text{と}\ \blkref{mat_mult}) \\
&= \sum_{\mu^{(r+1)} \in \mathfrak{M}} \left(A^{r}\right)_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(r+1)})} \, A_{\mathrm{ord}(\mu^{(r+1)}),\mathrm{ord}(\mu^{(r+2)})}
&&(\because\ (\mathrm{R})) \\
&= \sum_{\mu^{(r+1)} \in \mathfrak{M}} \left(
     \sum_{(\mu^{(2)},\dots,\mu^{(r)}) \in \mathfrak{M}^{r-1}} \prod_{k=1}^{r} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
   \right) A_{\mathrm{ord}(\mu^{(r+1)}),\mathrm{ord}(\mu^{(r+2)})}
&&(\because\ \text{帰納法の仮定}\ (\ast)) \\
&= \sum_{\mu^{(r+1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(r)}) \in \mathfrak{M}^{r-1}}
   \left( \prod_{k=1}^{r} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})} \right) A_{\mathrm{ord}(\mu^{(r+1)}),\mathrm{ord}(\mu^{(r+2)})}
&&(\because\ \text{有限和に対する分配則}\ \left(\textstyle\sum_\lambda x_\lambda\right) y = \textstyle\sum_\lambda x_\lambda y) \\
&= \sum_{(\mu^{(2)},\dots,\mu^{(r+1)}) \in \mathfrak{M}^{r}} \ \prod_{k=1}^{r+1} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&&(\because\ \mathfrak{M} \times \mathfrak{M}^{r-1} \to \mathfrak{M}^{r}\ \text{の全単射による添え字の付け替えと、末尾の因子を有限積へ入れること})
\end{aligned}`,
      ),
      paragraph([
        "よってすべての ",
        math(String.raw`r \in \mathbb{Z}_{\ge 1}`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つ。",
      ]),

      paragraph(["中間目標: トレースの展開。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(A^{N_{\mathrm{row}}}\right)
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}} \left(A^{N_{\mathrm{row}}}\right)_{k,k}
&&(\because\ \blkref{def_trace}) \\
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \left(A^{N_{\mathrm{row}}}\right)_{\mathrm{ord}(\mu^{(1)}),\mathrm{ord}(\mu^{(1)})}
&&(\because\ (\mathrm{R})) \\
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(N_{\mathrm{row}})}) \in \mathfrak{M}^{N_{\mathrm{row}}-1}} \ \prod_{k=1}^{N_{\mathrm{row}}} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&&(\because\ (\ast)\ \text{を}\ r=N_{\mathrm{row}},\ \mu^{(N_{\mathrm{row}}+1)}=\mu^{(1)}\ \text{として}) \\
&= \sum_{(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) \in \mathfrak{M}^{N_{\mathrm{row}}}} \ \prod_{k=1}^{N_{\mathrm{row}}} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&&(\because\ \mathfrak{M} \times \mathfrak{M}^{N_{\mathrm{row}}-1} \to \mathfrak{M}^{N_{\mathrm{row}}}\ \text{の全単射による添え字の付け替え})
\end{aligned}`,
      ),

      paragraph(["中間目標: 指数の積を指数の和へ。"]),
      paragraph([
        "準備として、任意の ",
        math(String.raw`n \in \mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`x_1,\dots,x_n \in \mathbb{R}`),
        " について ",
        math(String.raw`\prod_{k=1}^{n} \exp(x_k) = \exp\!\left(\sum_{k=1}^{n} x_k\right)`),
        " を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
        math(String.raw`n = 1`),
        " のときは両辺とも ",
        math(String.raw`\exp(x_1)`),
        " である。",
        math(String.raw`n`),
        " で成り立つとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{k=1}^{n+1} \exp(x_k)
&= \left(\prod_{k=1}^{n} \exp(x_k)\right)\exp(x_{n+1})
&&(\because\ \text{有限積から末尾の因子を分けること}) \\
&= \exp\!\left(\sum_{k=1}^{n} x_k\right)\exp(x_{n+1})
&&(\because\ \text{帰納法の仮定}) \\
&= \exp\!\left(\sum_{k=1}^{n+1} x_k\right)
&&(\because\ \blkref{theorem_exp_product}\ \text{を}\ n=1,\ K=\mathbb{R}\ \text{へ適用する})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) \in \mathfrak{M}^{N_{\mathrm{row}}}`),
        "（および ",
        math(String.raw`\mu^{(N_{\mathrm{row}}+1)} = \mu^{(1)}`),
        "）を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{k=1}^{N_{\mathrm{row}}} A_{\mathrm{ord}(\mu^{(k)}),\mathrm{ord}(\mu^{(k+1)})}
&= \prod_{k=1}^{N_{\mathrm{row}}} \exp\!\left(\sum_{m=1}^{M_{\mathrm{col}}} \bigl(K_1\,\mu^{(k)}(m)\mu^{(k)}(m+1) + K_2\,\mu^{(k)}(m)\mu^{(k+1)}(m)\bigr)\right)
&&(\because\ \text{上で示した転送行列の積の成分}) \\
&= \exp\!\left(\sum_{k=1}^{N_{\mathrm{row}}} \ \sum_{m=1}^{M_{\mathrm{col}}} \bigl(K_1\,\mu^{(k)}(m)\mu^{(k)}(m+1) + K_2\,\mu^{(k)}(m)\mu^{(k+1)}(m)\bigr)\right)
&&(\because\ \text{直前に示した指数の積の法則}) \\
&= \exp\!\left(\sum_{\substack{k\in\{1,\dots,N_{\mathrm{row}}\}\\m\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,\mu^{(k)}(m)\mu^{(k)}(m+1) + K_2\,\mu^{(k)}(m)\mu^{(k+1)}(m)\bigr)\right)
&&(\because\ \text{有限集合}\ \{1,\dots,N_{\mathrm{row}}\}\times\{1,\dots,M_{\mathrm{col}}\}\ \text{上の和を二重和として書き直すこと})
\end{aligned}`,
      ),

      paragraph([
        "中間目標: ",
        math(String.raw`\mathfrak{M}^{N_{\mathrm{row}}}`),
        " と ",
        math(String.raw`\mathfrak{S}`),
        " の全単射。全単射の構成なので、一続きの式変形にはしない。",
      ]),
      paragraph([
        "写像 ",
        math(String.raw`\Phi : \mathfrak{M}^{N_{\mathrm{row}}} \to \mathfrak{S}`),
        " を、",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) \in \mathfrak{M}^{N_{\mathrm{row}}}`),
        " に対し",
      ]),
      displayMath(
        String.raw`\Phi(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) := s, \qquad
s(i,j) := \mu^{(i)}(j) \quad (i\in\{1,\dots,N_{\mathrm{row}}\},\ j\in\{1,\dots,M_{\mathrm{col}}\})`,
      ),
      paragraph([
        "で定める。すなわち第 ",
        math(String.raw`i`),
        " 行のスピン配置が ",
        math(String.raw`\mu^{(i)}`),
        " である。",
      ]),
      paragraph([
        "（well-defined 性）各 ",
        math(String.raw`\mu^{(i)}`),
        " は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\} \to \{-1,1\}`),
        " の写像だから、",
        math(String.raw`s`),
        " は ",
        math(String.raw`\{1,\dots,N_{\mathrm{row}}\}\times\{1,\dots,M_{\mathrm{col}}\}`),
        " の各元に ",
        math(String.raw`\{-1,1\}`),
        " の元をただ1つ対応させる。ゆえに ",
        math(String.raw`s \in \mathfrak{S}`),
        "。",
      ]),
      paragraph([
        "（単射性）",
        math(String.raw`\Phi(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) = \Phi(\nu^{(1)},\dots,\nu^{(N_{\mathrm{row}})})`),
        " とすると、すべての ",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        "、",
        math(String.raw`j\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\mu^{(i)}(j) = \nu^{(i)}(j)`),
        "。写像の外延性より各 ",
        math(String.raw`i`),
        " で ",
        math(String.raw`\mu^{(i)} = \nu^{(i)}`),
        " であり、組として ",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) = (\nu^{(1)},\dots,\nu^{(N_{\mathrm{row}})})`),
        "。",
      ]),
      paragraph([
        "（全射性）",
        math(String.raw`s \in \mathfrak{S}`),
        " を任意にとり、",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        " ごとに ",
        math(String.raw`\mu^{(i)} : \{1,\dots,M_{\mathrm{col}}\} \to \{-1,1\}`),
        " を ",
        math(String.raw`\mu^{(i)}(j) := s(i,j)`),
        " で定めれば ",
        math(String.raw`\mu^{(i)} \in \mathfrak{M}`),
        " であり、",
        math(String.raw`\Phi(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) = s`),
        "。",
      ]),
      paragraph([
        "よって ",
        math(String.raw`\Phi`),
        " は全単射である。",
      ]),
      paragraph([
        "（周期規約の整合）",
        math(String.raw`s = \Phi(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})})`),
        " とし、",
        math(String.raw`s`),
        " を ",
        ref("def_partition_function_2d_ising"),
        " の規約で周期的に延長する。",
        math(String.raw`j\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、行方向の端では",
      ]),
      displayMath(String.raw`\begin{aligned}
s(N_{\mathrm{row}}+1,j)
&=s(1,j)
&&\bigl(\because\ \blkref{def_partition_function_2d_ising}\text{ の周期境界条件}\bigr)\\
&=\mu^{(1)}(j)
&&\bigl(\because\ \Phi\text{ の定義}\bigr)\\
&=\mu^{(N_{\mathrm{row}}+1)}(j)
&&\bigl(\because\ \mu^{(N_{\mathrm{row}}+1)}=\mu^{(1)}\text{（行方向の周期規約）}\bigr)
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        " について、列方向の端では",
      ]),
      displayMath(String.raw`\begin{aligned}
s(i,M_{\mathrm{col}}+1)
&=s(i,1)
&&\bigl(\because\ \blkref{def_partition_function_2d_ising}\text{ の周期境界条件}\bigr)\\
&=\mu^{(i)}(1)
&&\bigl(\because\ \Phi\text{ の定義}\bigr)\\
&=\mu^{(i)}(M_{\mathrm{col}}+1)
&&\bigl(\because\ \blkref{def_transfer_matrix}\text{ の周期規約}\ \mu(M_{\mathrm{col}}+1)=\mu(1)\bigr)
\end{aligned}`),
      paragraph([
        "である。端でない添字では ",
        math(String.raw`\Phi`),
        " の定義そのものなので、すべての ",
        math(String.raw`i\in\{1,\dots,N_{\mathrm{row}}\}`),
        "、",
        math(String.raw`j\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について",
      ]),
      displayMath(
        String.raw`s(i,j)=\mu^{(i)}(j),\qquad s(i,j+1)=\mu^{(i)}(j+1),\qquad s(i+1,j)=\mu^{(i+1)}(j)
\tag{P}`,
      ),
      paragraph(["が成り立つ。"]),

      paragraph(["中間目標: 分配関数との一致。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left((V_1V_2)^{N_{\mathrm{row}}}\right)
&= \sum_{(\mu^{(1)},\dots,\mu^{(N_{\mathrm{row}})}) \in \mathfrak{M}^{N_{\mathrm{row}}}}
   \exp\!\left(\sum_{\substack{k\in\{1,\dots,N_{\mathrm{row}}\}\\m\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,\mu^{(k)}(m)\mu^{(k)}(m+1) + K_2\,\mu^{(k)}(m)\mu^{(k+1)}(m)\bigr)\right)
&&(\because\ \text{上で示したトレースの展開と、直前に示した積の表式}) \\
&= \sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,N_{\mathrm{row}}\}\\j\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,s(i,j)\,s(i,j+1) + K_2\,s(i,j)\,s(i+1,j)\bigr)\right)
&&(\because\ \Phi\ \text{が全単射であることによる添え字の付け替えと}\ (\mathrm{P})) \\
&= Z(K_1,K_2)
&&(\because\ \blkref{def_partition_function_2d_ising})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は (V_1 V_2) の (μ,μ') 成分の計算までで、trace 展開による Z との一致は原文自体が未記載（TODO）だった。" +
          "成分計算は原文の全ステップを保ったうえで（def_transfer_matrix で訂正した J↔J' の入れ替えを反映）、" +
          "A^m の成分公式の帰納法・トレースの展開・指数の積の和への変換・𝔐^M と 𝔖 の全単射・有限和の添え字付け替えを新規に補い、証明を完成させた。",
        "2026-08-09: 式変形の書き方を統一した。Step 1〜Step 6 という番号での区切りを" +
          "それぞれの中間目標の名前（転送行列の積の成分・行列の冪の成分・トレースの展開・" +
          "指数の積を指数の和へ・𝔐^M と 𝔖 の全単射・分配関数との一致）へ変え、" +
          "各式変形の後ろに置かれていた「3行目では…」「4行目は…」という日本語の説明を、" +
          "各行の行末の (∵ …) へ移した。m=1 の場合と冪の成分の帰納法の出発点も" +
          "一続きの鎖にした。式変形の段は減っていない（m=1 の場合で 3 段に分けたぶん増えている）。" +
          "他の Step を「Step 3 の規約」のように番号で指していた箇所は、" +
          "規約を証明の冒頭の準備へ移して名前で指すようにした。",
        SYMBOL_NOTE +
          "行列の成分を ord(μ) で指すため、行列の積とトレースの和を ord の全単射で 𝔐 上の和へ付け替える段 (R) を加えた。" +
          "格子の第 1 引数を行にしたため、旧版の最後の加法の交換律の段は不要になった。" +
          "周期規約の整合は、延長後の s について s(i,j+1)=μ^{(i)}(j+1), s(i+1,j)=μ^{(i+1)}(j) を端で確かめる形に直した。",
        "2026-09-26: 旧 <partition_function_in_pauli_form>（分配関数をパウリ行列表示の転送行列で書く主張）はこの主張と同一になったため削除し、参照をこの主張へ付け替えた。",
      ],
    },
  },
]);
