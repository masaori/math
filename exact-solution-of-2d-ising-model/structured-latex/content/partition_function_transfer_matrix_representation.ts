import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「分配関数」の章「転送行列による表示」。章立て（`tools/chapter-plan.ts`）でこの章に割り当てた項を、章の中の依存順に並べる。
 * 章の最後は、この章のゴールの式を主張するブロックである。
 */

const SYMBOL_NOTE =
  "2026-09-26: 記号を列数 M_col・行数 N_row・結合定数 K_1, K_2 に統一し、行列の添字の番号付け ord を明示した。";
const SINGLE_DEFINITION_NOTE =
  "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。";

export default defineBlocks([
  {
    id: "heading_part_partition_function",
    kind: "heading",
    level: 1,
    title: { text: "分配関数" },
    labels: [],
  },
  {
    id: "heading_chapter_transfer_matrix_representation",
    kind: "heading",
    level: 2,
    title: { text: "転送行列による表示" },
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
  {
    id: "transfer_matrix_000_definition_site_pauli_matrices",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "サイトごとの Pauli 行列族" },
    labels: ["def_site_pauli_matrices"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とする。",
        ref("pauli_matrix_products"),
        " で定めた二次の Pauli 行列 ",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z`),
        " と単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "、および ",
        ref("def_kronecker"),
        " のクロネッカー積を用いる。",
      ]),
      paragraph([
        math(String.raw`1\leq k\leq M_{\mathrm{col}}`),
        " と ",
        math(String.raw`a\in\{x,y,z\}`),
        " に対して、サイト ",
        math(String.raw`k`),
        " だけに ",
        math(String.raw`\sigma^a`),
        " を置く行列を",
      ]),
      displayMath(
        String.raw`\sigma_k^a := I_{\mathrm{Mat}(2,\mathbb{C})}\boxtimes\cdots\boxtimes\overbrace{\sigma^a}^{k\text{th}}\boxtimes\cdots\boxtimes I_{\mathrm{Mat}(2,\mathbb{C})}\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "と定める。これにより ",
        math(String.raw`(\sigma_k^a)_{\substack{1\leq k\leq M_{\mathrm{col}}\\ a\in\{x,y,z\}}}`),
        " は一つの添字つき行列族として定まる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、サイトごとの三つの Pauli 行列を一つの添字つき行列族として分離した。旧ラベルからの後続参照は、残した複合定義が本定義を明示参照することで意味を保つ。",
      ],
    },
  },
  {
    id: "transfer_matrix_definition_site_pauli_periodic_extension",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 2 },
    title: { text: "サイトごとの Pauli 行列族の周期的な延長" },
    labels: ["def_site_pauli_periodic_extension"],
    statement: [
      paragraph([
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族 ",
        math(String.raw`(\sigma_k^z)_{1\leq k\leq M_{\mathrm{col}}}`),
        " の添字は ",
        math(String.raw`\{1,\dots,M_{\mathrm{col}}\}`),
        " に限られ、",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z`),
        " はそのままでは定義されない。",
        ref("def_transfer_matrix"),
        " の周期規約 ",
        math(String.raw`\mu(M_{\mathrm{col}}+1):=\mu(1)`),
        " と同じく周期的に延長して",
      ]),
      displayMath(String.raw`\sigma_{M_{\mathrm{col}}+1}^z := \sigma_1^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
      paragraph(["と定める。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。旧 <def_first_transfer_matrix_pauli> の中にあった周期規約 σ^z_{M_col+1} := σ^z_1 を独立した定義にした。",
      ],
    },
  },
  {
    id: "bridge_001_definition_config_basis",
    kind: "definition",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 3 },
    title: { text: "スピン配置から多重添字への写像" },
    labels: ["def_config_basis_iso"],
    statement: [
      paragraph([
        ref("def_row_configurations"),
        " の ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`),
        " と、",
        ref("def_end_iso"),
        " を ",
        math(String.raw`M := M_{\mathrm{col}}`),
        " として用いたときの多重添字の集合 ",
        math(String.raw`\mathcal{I} = \{1,2\}^{M_{\mathrm{col}}}`),
        "・基底 ",
        math(String.raw`f_I = e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}} \in \mathcal{F} = \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " を用いる。写像 ",
        math(String.raw`\iota : \mathfrak{M} \to \mathcal{I}`),
        " を",
      ]),
      displayMath(
        String.raw`\iota(\mu) := (i_1,\dots,i_{M_{\mathrm{col}}}), \qquad
i_m := \begin{cases} 1 & (\mu(m) = +1) \\ 2 & (\mu(m) = -1) \end{cases}
\qquad (m\in\{1,\dots,M_{\mathrm{col}}\})`,
      ),
      paragraph([
        "で定める。以後、スピン配置 ",
        math(String.raw`\mu\in\mathfrak{M}`),
        " に対応する ",
        math(String.raw`\mathcal{F}`),
        " の基底ベクトルを ",
        math(String.raw`f_{\iota(\mu)}`),
        " と書く。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "分配関数の転送行列の章から転送行列の章へ移した。旧版の「転送行列の定義の全単射として ι を取る（取り方に依らない）」という同一視は、" +
          "<def_transfer_matrix> が番号付け ord を明示したため不要になり削除した。ord と ι の関係は <config_numbering_equals_kronecker_numbering> で示す。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_config_numbering_equals_kronecker_numbering",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 3 },
    title: { text: "スピン配置の番号付けはクロネッカー積の番号付けと一致する" },
    labels: ["config_numbering_equals_kronecker_numbering"],
    statement: [
      paragraph([
        ref("def_row_configuration_numbering"),
        " の ",
        math(String.raw`\mathrm{ord}`),
        "、",
        ref("def_kronecker"),
        " を ",
        math(String.raw`M := M_{\mathrm{col}}`),
        " として用いたときの番号付け ",
        math(String.raw`\nu : \{1,2\}^{M_{\mathrm{col}}} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " について、任意の ",
        math(String.raw`\mu\in\mathfrak{M}`),
        " で",
      ]),
      displayMath(String.raw`\mathrm{ord}(\mu) = \nu(\iota(\mu))`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`\iota(\mu) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        " とおく。各 ",
        math(String.raw`m\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        math(String.raw`\mu(m)=1`),
        " なら ",
        math(String.raw`i_m-1 = 0 = \tfrac{1-\mu(m)}{2}`),
        "、",
        math(String.raw`\mu(m)=-1`),
        " なら ",
        math(String.raw`i_m-1 = 1 = \tfrac{1-\mu(m)}{2}`),
        " であるから（",
        ref("def_config_basis_iso"),
        "）、",
        math(String.raw`i_m - 1 = \tfrac{1-\mu(m)}{2}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\nu(\iota(\mu))
&= 1 + \sum_{m=1}^{M_{\mathrm{col}}} (i_m - 1)\,2^{M_{\mathrm{col}}-m}
   &&(\because \blkref{def_kronecker}\text{ の }\nu\text{ の定義}) \\
&= 1 + \sum_{m=1}^{M_{\mathrm{col}}} \frac{1-\mu(m)}{2}\cdot 2^{M_{\mathrm{col}}-m}
   &&(\because \text{各 }m\text{ で }i_m-1=\tfrac{1-\mu(m)}{2}) \\
&= \mathrm{ord}(\mu)
   &&(\because \blkref{def_row_configuration_numbering})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "成分で定義した V_1, V_2 の番号 ord(μ) と、クロネッカー積で作るパウリ行列の番号 ν(ι(μ)) が同じ番号であることを主張として置いた。",
      ],
    },
  },
  {
    id: "bridge_002_claim_sigma_z_diagonal_action",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 4 },
    title: { tex: String.raw`\sigma_m^z \text{ の基底 } f_{\iota(\mu)} \text{ への作用}` },
    labels: ["sigma_z_diagonal_action"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        "、",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\sigma_m^z\, f_{\iota(\mu)} = \mu(m)\, f_{\iota(\mu)}`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`m, m' \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`\sigma_m^z\sigma_{m'}^z f_{\iota(\mu)} = \mu(m)\mu(m')f_{\iota(\mu)}`),
        " であり、これらはすべて基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " に関して対角行列である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " と ",
        ref("def_end_iso"),
        " の ",
        math(String.raw`e_1 = (1,0),\ e_2 = (0,1)`),
        " より、",
        math(String.raw`\mathbb{C}^2`),
        " の中で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_1
&=
\begin{pmatrix}
  1 & 0 \\
  0 & -1
\end{pmatrix}
\begin{pmatrix}
  1 \\
  0
\end{pmatrix}
\quad (\because \blkref{pauli_matrix_products},\blkref{def_end_iso}) \\
&=
\begin{pmatrix}
  1 \\
  0
\end{pmatrix}
\quad (\because \text{行列と列ベクトルの積}) \\
&= e_1
\quad (\because \blkref{def_end_iso}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_2
&=
\begin{pmatrix}
  1 & 0 \\
  0 & -1
\end{pmatrix}
\begin{pmatrix}
  0 \\
  1
\end{pmatrix}
\quad (\because \blkref{pauli_matrix_products},\blkref{def_end_iso}) \\
&=
\begin{pmatrix}
  0 \\
  -1
\end{pmatrix}
\quad (\because \text{行列と列ベクトルの積}) \\
&= -e_2
\quad (\because \blkref{def_end_iso}).
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        " は ",
        math(String.raw`\mu(m) = +1`),
        " のとき ",
        math(String.raw`i_m = 1`),
        "、",
        math(String.raw`\mu(m) = -1`),
        " のとき ",
        math(String.raw`i_m = 2`),
        " と定めたから、いずれの場合も ",
        math(String.raw`\sigma^z e_{i_m} = \mu(m)\,e_{i_m}`),
        " と一言で書ける。",
      ]),
      paragraph([
        ref("def_site_pauli_matrices"),
        " の ",
        math(String.raw`\sigma_m^z = I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I`),
        "（第 ",
        math(String.raw`m`),
        " 因子だけが ",
        math(String.raw`\sigma^z`),
        "）より",
      ]),
      paragraph([
        ref("kronecker_product_rule"),
        "（クロネッカー積の積は因子ごとの積）と ",
        ref("kronecker_multilinear"),
        " を順に用いると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\, f_{\iota(\mu)}
&= \left(I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I\right)
   f_{\iota(\mu)}
   \quad (\because \blkref{def_site_pauli_matrices}) \\
&= \left(I \boxtimes\cdots\boxtimes \sigma^z \boxtimes\cdots\boxtimes I\right)
   \left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_m}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)
   \quad (\because \blkref{def_config_basis_iso}) \\
&= (I e_{i_1})\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes(I e_{i_{M_{\mathrm{col}}}})
   \quad (\because \blkref{kronecker_product_rule}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \text{恒等行列の作用}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes\left(\mu(m)e_{i_m}\right)\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \sigma^z e_{i_m}=\mu(m)e_{i_m}) \\
&= \mu(m)\,\left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)
   \quad (\because \blkref{kronecker_multilinear}) \\
&= \mu(m)\, f_{\iota(\mu)}
   \quad (\because \blkref{def_config_basis_iso})
\end{aligned}`,
      ),
      paragraph(["積については、いま示した作用を 2 回用いると"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\sigma_{m'}^z f_{\iota(\mu)}
&= \sigma_m^z\left(\mu(m')f_{\iota(\mu)}\right)
   \quad (\because \sigma_{m'}^z f_{\iota(\mu)}=\mu(m')f_{\iota(\mu)}) \\
&= \mu(m')\sigma_m^z f_{\iota(\mu)}
   \quad (\because \text{行列作用の線型性}) \\
&= \mu(m')\left(\mu(m)f_{\iota(\mu)}\right)
   \quad (\because \sigma_m^z f_{\iota(\mu)}=\mu(m)f_{\iota(\mu)}) \\
&= \left(\mu(m')\mu(m)\right)f_{\iota(\mu)}
   \quad (\because \text{スカラー倍の結合律}) \\
&= \mu(m)\mu(m')f_{\iota(\mu)}
   \quad (\because \text{複素数の乗法の交換律}).
\end{aligned}`,
      ),
      paragraph([
        "基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " の各元が固有ベクトルなので、これらの行列は基底 ",
        math(String.raw`(f_I)`),
        " に関して対角行列である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移した。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_first_transfer_matrix_pauli_form",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    title: { tex: String.raw`V_1 \text{ のパウリ行列表示}` },
    labels: ["first_transfer_matrix_pauli_form"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた ",
        math(String.raw`V_1 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（結合定数 ",
        math(String.raw`K_1\in\mathbb{R}_{>0}`),
        "）は、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族と ",
        ref("def_site_pauli_periodic_extension"),
        " の周期的な延長を用いて",
      ]),
      displayMath(
        String.raw`V_1 = \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
= \exp\!\left(K_1 \left(\sigma_1^z\sigma_2^z + \sigma_2^z\sigma_3^z + \cdots + \sigma_{M_{\mathrm{col}}}^z\sigma_1^z\right)\right)`,
      ),
      paragraph([
        "と表せる。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`D := \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " とおく。",
        ref("def_site_pauli_periodic_extension"),
        " より ",
        math(String.raw`\sigma_{M_{\mathrm{col}}+1}^z=\sigma_1^z`),
        " なので、周期端を分けると ",
        math(String.raw`D=\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z+\sigma_{M_{\mathrm{col}}}^z\sigma_1^z`),
        " であり、",
        ref("sigma_z_diagonal_action"),
        " を前半の和では ",
        math(String.raw`1\leq m\leq M_{\mathrm{col}}-1`),
        " の ",
        math(String.raw`(m,m+1)`),
        " に、周期端では ",
        math(String.raw`(M_{\mathrm{col}},1)`),
        " に適用できる。",
      ]),
      paragraph(["中間目標: ", math(String.raw`D`), " の対角成分。", math(String.raw`\mu \in \mathfrak{M}`), " を任意に取る。"]),
      displayMath(
        String.raw`\begin{aligned}
D\, f_{\iota(\mu)}
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z+\sigma_{M_{\mathrm{col}}}^z\sigma_1^z\right)f_{\iota(\mu)}
   &&(\because D\text{ の定義と }\blkref{def_site_pauli_periodic_extension}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\left(\sigma_m^z\sigma_{m+1}^z f_{\iota(\mu)}\right)
   +\sigma_{M_{\mathrm{col}}}^z\sigma_1^z f_{\iota(\mu)}
   &&(\because \text{行列の有限和とベクトルの積の分配則}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}-1}\Bigl(\mu(m)\mu(m+1)\,f_{\iota(\mu)}\Bigr)
   +\mu(M_{\mathrm{col}})\mu(1)\,f_{\iota(\mu)}
   &&(\because \blkref{sigma_z_diagonal_action}\text{ を前半では }(m,m+1)\text{、周期端では }(M_{\mathrm{col}},1)\text{ へ}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}-1}\mu(m)\mu(m+1)+\mu(M_{\mathrm{col}})\mu(1)\right)f_{\iota(\mu)}
   &&(\because \text{スカラー倍の有限和の括り出し（分配則）}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right) f_{\iota(\mu)}
   &&(\because \blkref{def_transfer_matrix}\text{ の周期規約 }\mu(M_{\mathrm{col}}+1)=\mu(1))
\end{aligned}`,
      ),
      paragraph([
        "であるから、",
        ref("sigma_z_diagonal_action"),
        " と同じく ",
        math(String.raw`D`),
        " は基底 ",
        math(String.raw`(f_I)_{I\in\mathcal{I}}`),
        " に関して対角行列であり、その ",
        math(String.raw`\iota(\mu)`),
        " 番目（行・列番号では ",
        math(String.raw`\nu(\iota(\mu))`),
        " 番目）の対角成分は ",
        math(String.raw`d(\mu) := \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)`),
        " である。",
        math(String.raw`K_1 D`),
        " も対角行列で、対角成分は ",
        math(String.raw`K_1 d(\mu)`),
        " である。",
      ]),
      paragraph([
        "中間目標: 成分の一致。",
        math(String.raw`\mu,\mu' \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp(K_1 D)\right)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
&= \left(\exp(K_1 D)\right)_{\nu(\iota(\mu)),\nu(\iota(\mu'))}
  &&(\because \blkref{config_numbering_equals_kronecker_numbering}) \\
&= \begin{cases}
\exp\!\left(K_1 d(\mu)\right) & (\nu(\iota(\mu)) = \nu(\iota(\mu'))) \\
0 & (\nu(\iota(\mu)) \neq \nu(\iota(\mu')))
\end{cases}
  &&(\because \blkref{exp_of_diagonal_matrix}\text{ を対角行列 }K_1 D\text{ へ}) \\
&= \begin{cases}
\exp\!\left(K_1 d(\mu)\right) & (\mathrm{ord}(\mu) = \mathrm{ord}(\mu')) \\
0 & (\mathrm{ord}(\mu) \neq \mathrm{ord}(\mu'))
\end{cases}
  &&(\because \blkref{config_numbering_equals_kronecker_numbering}) \\
&= \delta_{\mu=\mu'}\exp\!\left(K_1\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1)\right)
  &&(\because \blkref{row_configuration_numbering_bijective}\text{ の単射性より }\mathrm{ord}(\mu)=\mathrm{ord}(\mu')\iff\mu=\mu') \\
&= (V_1)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
  &&(\because \blkref{def_transfer_matrix})
\end{aligned}`,
      ),
      paragraph([
        ref("row_configuration_numbering_bijective"),
        " の全射性より、すべての行・列番号の組 ",
        math(String.raw`(k,l)\in\{1,\dots,2^{M_{\mathrm{col}}}\}^2`),
        " は ",
        math(String.raw`(\mathrm{ord}(\mu),\mathrm{ord}(\mu'))`),
        " の形に書ける。したがってすべての成分が一致し、",
        math(String.raw`V_1 = \exp(K_1 D)`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "旧 <def_first_transfer_matrix_pauli>（V_1 をパウリ行列で定義していたブロック）と旧 <V1_component_equals_pauli>（成分定義との一致の主張）を統合した。" +
          "証明は旧 <V1_component_equals_pauli> の証明を、成分の番号を ord で指す形に直したものである。",
        "原文の V_1 の定義は exp(√-1 K_1 (σ^z_1σ^z_2 + ⋯ + σ^z_Mσ^z_1)) と虚数単位を含んでいたが、これは誤りなので K_1 に訂正済みである。Y_m Z_{m+1} = -√-1 σ^z_mσ^z_{m+1} なので、虚数単位は Jordan--Wigner 置換から生じる。",
        "M=2,3,4 と複数の K_1 について、成分定義の V_1 とパウリ表示の V_1 が残差 0.00e+00 で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_01_V1_bridge.sage）。",
      ],
    },
  },
  {
    id: "transfer_matrix_000g_definition_positive_coupling_tanh",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "正の結合定数上の双曲線正接" },
    labels: ["def_positive_coupling_tanh"],
    statement: [
      paragraph([
        ref("def_cosh_sinh"),
        " の双曲線余弦・双曲線正弦を用いる。このイジング模型で用いる正の結合定数を ",
        math(String.raw`K\in\mathbb{R}_{>0}`),
        " とする。このとき",
      ]),
      displayMath(String.raw`\tanh K:=\frac{\sinh K}{\cosh K}\in\{y\in\mathbb{R}\mid 0<y<1\}`),
      paragraph(["と定める。右辺が指定した集合の元になることを以下で確認する。"]),
    ],
    proof: [
      paragraph([ref("cosh_sinh_basic_properties"), " の (3) を次の行で用いる。"]),
      displayMath(String.raw`\begin{aligned}
\cosh K&>\sinh K>0
&&(\because\ \blkref{cosh_sinh_basic_properties}\text{ の (3)})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh K>0
&\Longrightarrow \cosh K\ne0
&&(\because\ \mathbb{R}\text{ の正の元は零でない})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K\in\mathbb{R}_{>0}
&\Longrightarrow K\in\mathbb{R}
&&(\because\ \mathbb{R}_{>0}\subset\mathbb{R})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K\in\mathbb{R}
&\Longrightarrow \sinh K,\cosh K\in\mathbb{R}
&&(\because\ \blkref{def_cosh_sinh})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\sinh K,\cosh K\in\mathbb{R}\ \land\ \cosh K\ne0
&\Longrightarrow \frac{\sinh K}{\cosh K}\in\mathbb{R}
&&(\because\ \mathbb{R}\text{ の零でない元による除法の閉性})
\end{aligned}`),
      paragraph(["定義した実数の商の正値性は"]),
      displayMath(String.raw`\begin{aligned}
\tanh K
&=\frac{\sinh K}{\cosh K}
&&(\because\ \tanh\ \text{の定義})\\
&>0
&&(\because\ \sinh K>0\ \text{かつ}\ \cosh K>0)
\end{aligned}`),
      paragraph(["上側の評価は"]),
      displayMath(String.raw`\begin{aligned}
\tanh K
&=\frac{\sinh K}{\cosh K}
&&(\because\ \tanh\ \text{の定義})\\
&<\frac{\cosh K}{\cosh K}
&&(\because\ \sinh K<\cosh K\ \text{かつ}\ \cosh K>0)\\
&=1
&&(\because\ \cosh K\ne0)
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math(String.raw`\tanh K\in\{y\in\mathbb{R}\mid 0<y<1\}`),
        " であり、定義可能性が確認できた。この項は実数の指数関数から定めた双曲線関数を正の実数上で割るため、有限な複素行列計算から実数解析へ移る先行定義である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "第一の双対結合定数を定める前提として、このイジング模型で用いる正の結合定数に対する双曲線正接を、値域を余域へ含めた一つの定義として独立させた。数学的道具立ての既存分類・節境界は変更していない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000h_definition_real_logarithm_positive",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "正の実数上の実対数" },
    labels: ["def_real_logarithm_positive"],
    statement: [
      paragraph([
        ref("def_scalar_exp"),
        " の実数の exp を考える。",
        ref("real_exp_positive"),
        " と ",
        ref("real_exp_strictly_increasing"),
        " より、",
        math(String.raw`\exp:\mathbb{R}\longrightarrow\mathbb{R}_{>0}`),
        " は狭義単調増加な単射である。全射であることは実解析の標準的な事実（連続性と中間値の定理）として用いる。その逆写像を正の実数上の実対数と呼び、",
      ]),
      displayMath(String.raw`\log:\mathbb{R}_{>0}\longrightarrow\mathbb{R}`),
      paragraph([
        "と書く。したがって、任意の ",
        math(String.raw`y\in\mathbb{R}_{>0}`),
        " と ",
        math(String.raw`x\in\mathbb{R}`),
        " に対して",
      ]),
      displayMath(String.raw`\exp(\log y)=y,\qquad \log(\exp x)=x`),
      paragraph([
        "が成り立つ。狭義単調増加な全単射の逆写像も狭義単調増加なので、",
      ]),
      displayMath(String.raw`0<u<v\Longrightarrow\log u<\log v\qquad(u,v\in\mathbb{R}_{>0})`),
      paragraph([
        "である。とくに、",
        math(String.raw`y\in\mathbb{R}`),
        " が ",
        math(String.raw`0<y<1`),
        " を満たすならば ",
        math(String.raw`\log y<0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in\mathbb{R}`),
        " かつ ",
        math(String.raw`0<y<1`),
        " とする。実対数の定義より ",
        math(String.raw`y,1\in\mathbb{R}_{>0}`),
        " および ",
        math(String.raw`\log y,\log 1\in\mathbb{R}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\log y
&<\log 1
&&\left(\because\ 0<y<1\text{ と }\log\text{ の狭義単調増加性}\right)\\
&=\log(\exp 0)
&&\left(\because\ \blkref{scalar_exp_zero}\right)\\
&=0
&&\left(\because\ \log\text{ は }\exp\text{ の逆写像}\right)
\end{aligned}`),
      paragraph([
        "ゆえに ",
        math(String.raw`0<y<1`),
        " ならば ",
        math(String.raw`\log y<0`),
        " である。（実対数による ",
        math(String.raw`\mathbb R`),
        " 脱出）この項は実数指数関数の全単射性、実対数、および実数の順序を用いるため、有限な複素行列計算から実数解析へ移る先行定義である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "第一の双対結合定数を定める前提として、正の実数上の実対数と、0<y<1 なら log y<0 となる符号性を一つの独立定義として置いた。数学的道具立ての既存分類・節境界は変更していない。",
      ],
    },
  },
  {
    id: "transfer_matrix_000i_definition_first_dual_coupling_constant",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第一の双対結合定数" },
    labels: ["def_first_dual_coupling_constant"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_1\in\mathbb{R}_{>0}`),
        " をとる。",
        ref("def_positive_coupling_tanh"),
        " の双曲線正接と ",
        ref("def_real_logarithm_positive"),
        " の実対数を用いて、第一の双対結合定数を",
      ]),
      displayMath(String.raw`K_1^*:=-\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}_{>0}`),
      paragraph(["と定める。右辺の定義可能性と正値性を以下で確認する。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、実数値の双曲線正接と実対数、および実数の順序を用いる。以下の各量の所属と符号を一段ずつ確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_1\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_1<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1
&\Longrightarrow \tanh K_1\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_1\in\mathbb{R}_{>0}
&\Longrightarrow \log(\tanh K_1)\in\mathbb{R}
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_1<1
&\Longrightarrow \log(\tanh K_1)<0
&&\left(\because\ \blkref{def_real_logarithm_positive}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ は体であり、逆元と符号反転について閉じている}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&<0
&&\left(\because\ \mathbb{R}\text{ の分数の大小}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}\in\mathbb{R}\ \land\ \log(\tanh K_1)\in\mathbb{R}
&\Longrightarrow -\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ の乗法についての閉性}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}<0\ \land\ \log(\tanh K_1)<0
&\Longrightarrow -\frac{1}{2}\log(\tanh K_1)>0
&&\left(\because\ \text{負の実数二つの積は正である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*&=-\frac{1}{2}\log(\tanh K_1)
&&\left(\because\ K_1^*\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*=-\frac{1}{2}\log(\tanh K_1)\ \land\ -\frac{1}{2}\log(\tanh K_1)\in\mathbb{R}
&\Longrightarrow K_1^*\in\mathbb{R}
&&\left(\because\ \text{等しい対象による所属の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*=-\frac{1}{2}\log(\tanh K_1)\ \land\ -\frac{1}{2}\log(\tanh K_1)>0
&\Longrightarrow K_1^*>0
&&\left(\because\ \text{等しい実数による左辺の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_1^*\in\mathbb{R}\ \land\ K_1^*>0
&\Longrightarrow K_1^*\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      paragraph(["以上により、第一の双対結合定数は正の実数として定まる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、第一の双対結合定数の定義と正値性だけを独立させた。二つの双対関係、第二の双対結合定数、双曲線関数の略記、およびそれらの正値性には進んでいない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000k_definition_second_dual_coupling_constant",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "第二の双対結合定数" },
    labels: ["def_second_dual_coupling_constant"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        " をとる。",
        ref("def_positive_coupling_tanh"),
        " の双曲線正接と ",
        ref("def_real_logarithm_positive"),
        " の実対数を用いて、第二の双対結合定数を",
      ]),
      displayMath(String.raw`K_2^*:=-\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}_{>0}`),
      paragraph(["と定める。右辺の定義可能性と正値性を以下で確認する。"]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb{R}`),
        " 脱出）この証明では、実数値の双曲線正接と実対数、および実数の順序を用いる。以下の各量の所属と符号を一段ずつ確認する。",
      ]),
      displayMath(String.raw`\begin{aligned}
K_2\in\mathbb{R}_{>0}
&\Longrightarrow 0<\tanh K_2<1
&&\left(\because\ \blkref{def_positive_coupling_tanh}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2
&\Longrightarrow \tanh K_2\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tanh K_2\in\mathbb{R}_{>0}
&\Longrightarrow \log(\tanh K_2)\in\mathbb{R}
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log:\mathbb{R}_{>0}\to\mathbb{R}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
0<\tanh K_2<1
&\Longrightarrow \log(\tanh K_2)<0
&&\left(\because\ \blkref{def_real_logarithm_positive}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ は体であり、逆元と符号反転について閉じている}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}&<0
&&\left(\because\ \mathbb{R}\text{ の分数の大小}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}\in\mathbb{R}\ \land\ \log(\tanh K_2)\in\mathbb{R}
&\Longrightarrow -\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}
&&\left(\because\ \mathbb{R}\text{ の乗法についての閉性}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
-\frac{1}{2}<0\ \land\ \log(\tanh K_2)<0
&\Longrightarrow -\frac{1}{2}\log(\tanh K_2)>0
&&\left(\because\ \text{負の実数二つの積は正である}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*&=-\frac{1}{2}\log(\tanh K_2)
&&\left(\because\ K_2^*\text{ の定義}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*=-\frac{1}{2}\log(\tanh K_2)\ \land\ -\frac{1}{2}\log(\tanh K_2)\in\mathbb{R}
&\Longrightarrow K_2^*\in\mathbb{R}
&&\left(\because\ \text{等しい対象による所属の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*=-\frac{1}{2}\log(\tanh K_2)\ \land\ -\frac{1}{2}\log(\tanh K_2)>0
&\Longrightarrow K_2^*>0
&&\left(\because\ \text{等しい実数による左辺の置換}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
K_2^*\in\mathbb{R}\ \land\ K_2^*>0
&\Longrightarrow K_2^*\in\mathbb{R}_{>0}
&&\left(\because\ \mathbb{R}_{>0}\text{ の定義}\right)
\end{aligned}`),
      paragraph(["以上により、第二の双対結合定数は正の実数として定まる。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧来の複合定義から、第二の双対結合定数の定義と正値性だけを独立させた。第二の双対関係、双曲線関数の略記、およびそれらの正値性には進んでいない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_000m_definition_indexed_hyperbolic_abbreviations",
    kind: "definition",
    origin: { path: "_old/typst/parts/004_転送行列/000_definition_転送行列の記号の定義.typ", ordinal: 1 },
    title: { text: "双曲線関数の添字つき略記" },
    labels: ["def_indexed_hyperbolic_abbreviations"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の正の結合定数 ",
        math(String.raw`K_1,K_2\in\mathbb{R}_{>0}`),
        "、および ",
        ref("def_first_dual_coupling_constant"),
        " と ",
        ref("def_second_dual_coupling_constant"),
        " で定めた双対結合定数 ",
        math(String.raw`K_1^*,K_2^*`),
        " に対し、各 ",
        math(String.raw`i\in\{1,2\}`),
        " について次の略記を定める。",
      ]),
      list([
        [
          math(String.raw`c_i := \cosh 2K_i,\quad s_i := \sinh 2K_i,\quad c_i^* := \cosh 2K_i^*,\quad s_i^* := \sinh 2K_i^*`),
        ],
      ]),
      paragraph([
        "右辺の双曲線余弦と双曲線正弦は ",
        ref("def_cosh_sinh"),
        " で定めた実数値関数である。したがって各 ",
        math(String.raw`i\in\{1,2\}`),
        " について ",
        math(String.raw`c_i,s_i,c_i^*,s_i^*\in\mathbb{R}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "残余複合定義から双曲線関数の添字つき略記だけを独立した定義へ分離した。略記の正値性は <indexed_hyperbolic_abbreviations_positive> へ分離した。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照先を分配関数の定義の結合定数にした。",
      ],
    },
  },
  {
    id: "bridge_005_claim_two_by_two_transfer_identity",
    kind: "claim",
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 7 },
    title: { tex: String.raw`2\times 2 \text{ の転送行列の恒等式}` },
    labels: ["two_by_two_transfer_identity"],
    statement: [
      paragraph([
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " とし、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`),
        "、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の ",
        math(String.raw`s_2 = \sinh 2K_2`),
        " を用いる。",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`A := \begin{pmatrix} \exp(K_2) & \exp(-K_2) \\ \exp(-K_2) & \exp(K_2) \end{pmatrix}`,
      ),
      paragraph([
        "（すなわち ",
        math(String.raw`A_{ij} = \exp(K_2\,\varsigma_i\,\varsigma_j)`),
        "、",
        math(String.raw`\varsigma_1 := +1,\ \varsigma_2 := -1`),
        "）と定めると、",
      ]),
      displayMath(String.raw`A = (2 s_2)^{1/2}\exp\!\left(K_2^*\,\sigma^x\right)`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`(2s_2)^{1/2}`),
        " は正の実数 ",
        math(String.raw`2s_2`),
        " の非負平方根（",
        ref("definition_of_sqrt_r_positive"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "中間目標: ",
        math(String.raw`\exp(t\sigma^x)`),
        " の閉じた形。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        " である。したがって ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^{2p}
&= \left((\sigma^x)^2\right)^p
   \quad (\because \text{行列の冪の指数法則}) \\
&= I^p
   \quad (\because (\sigma^x)^2=I) \\
&= I
   \quad (\because \text{単位行列の自然数冪}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(\sigma^x)^{2p+1}
&= (\sigma^x)^{2p}\sigma^x
   \quad (\because \text{行列の冪の加法則}) \\
&= I\sigma^x
   \quad (\because (\sigma^x)^{2p}=I) \\
&= \sigma^x
   \quad (\because \text{単位行列の作用})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        math(String.raw`t \in \mathbb{R}`),
        " について ",
        ref("def_exp"),
        " の級数を偶数項と奇数項に分けると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(t\sigma^x)
&= \left(\sum_{p=0}^{\infty}\frac{t^{2p}}{(2p)!}\right) I
+ \left(\sum_{p=0}^{\infty}\frac{t^{2p+1}}{(2p+1)!}\right)\sigma^x
   \quad (\because \text{絶対収束する指数級数を偶数項と奇数項へ分割し、}(\sigma^x)^{2p}=I,\ (\sigma^x)^{2p+1}=\sigma^x\text{ を適用}) \\
&= \cosh(t)\,I + \sinh(t)\,\sigma^x
   \quad (\because \cosh,\sinh\text{ のテイラー展開})
\end{aligned}`,
      ),
      paragraph([
        "（級数の分割は ",
        ref("exp_converges"),
        " の絶対収束と ",
        ref("real_exp_series_converges"),
        " による。最後の等号は ",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh, \sinh`),
        " のテイラー展開。）したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\exp\!\left(K_2^*\sigma^x\right)
&= (2s_2)^{1/2}\bigl(\cosh(K_2^*)\,I + \sinh(K_2^*)\,\sigma^x\bigr)
   \quad (\because \text{上の閉じた形に } t = K_2^* \text{ を代入}) \\
&= \begin{pmatrix}
(2s_2)^{1/2}\cosh K_2^* & (2s_2)^{1/2}\sinh K_2^* \\
(2s_2)^{1/2}\sinh K_2^* & (2s_2)^{1/2}\cosh K_2^*
\end{pmatrix}
   \quad (\because I,\ \sigma^x \text{ の成分を書き下し、スカラー倍を各成分へ掛ける})
\end{aligned}`,
      ),
      paragraph([
        "なので、示すべきは次の 2 つの等式である。",
      ]),
      displayMath(
        String.raw`(2s_2)^{1/2}\cosh K_2^* = \exp(K_2), \qquad
(2s_2)^{1/2}\sinh K_2^* = \exp(-K_2)`,
      ),
      paragraph([
        "中間目標: ",
        math(String.raw`\cosh K_2^*, \sinh K_2^*`),
        " を ",
        math(String.raw`K_2`),
        " で書く。",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^* = -\tfrac12\log(\tanh K_2)`),
        " より ",
        math(String.raw`\log(\tanh K_2) = -2K_2^*`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-2K_2^*)
&= \exp(\log(\tanh K_2))
   \quad (\because \log(\tanh K_2) = -2K_2^* \text{ を指数へ代入}) \\
&= \tanh K_2
   \quad (\because \exp \text{ と } \log \text{ は互いに逆写像})
\end{aligned}`,
      ),
      paragraph([
        "以後 ",
        math(String.raw`t := \tanh K_2`),
        " と置く。",
      ]),
      paragraph([
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`0 < t < 1`),
        " である（",
        ref("cosh_sinh_basic_properties"),
        " の ",
        math(String.raw`\cosh x > \sinh x > 0\ (x>0)`),
        "）。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-K_2^*)
&= \left(\exp(-2K_2^*)\right)^{1/2}
   \quad (\because \text{指数法則 } \exp(-2K_2^*) = (\exp(-K_2^*))^2 \text{ と } \exp(-K_2^*) > 0 \text{ の正の平方根}) \\
&= t^{1/2}
   \quad (\because \exp(-2K_2^*) = t),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\exp(K_2^*)
&= \frac{1}{\exp(-K_2^*)}
   \quad (\because \text{指数法則 } \exp(K_2^*)\exp(-K_2^*) = 1) \\
&= \frac{1}{t^{1/2}}
   \quad (\because \exp(-K_2^*) = t^{1/2}) \\
&= t^{-1/2}
   \quad (\because \text{負冪の定義 } t^{-1/2} = 1/t^{1/2})
\end{aligned}`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
\cosh K_2^*
&= \frac{\exp(K_2^*) + \exp(-K_2^*)}{2}
   \quad (\because \cosh \text{ の定義 } \cosh x = \tfrac{\exp(x)+\exp(-x)}{2}) \\
&= \frac{t^{-1/2} + t^{1/2}}{2}
   \quad (\because \exp(K_2^*) = t^{-1/2},\ \exp(-K_2^*) = t^{1/2}) \\
&= \frac{1+t}{2\,t^{1/2}}
   \quad (\because \text{分子・分母に } t^{1/2} \text{ を掛ける}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh K_2^*
&= \frac{\exp(K_2^*) - \exp(-K_2^*)}{2}
   \quad (\because \sinh \text{ の定義 } \sinh x = \tfrac{\exp(x)-\exp(-x)}{2}) \\
&= \frac{t^{-1/2} - t^{1/2}}{2}
   \quad (\because \exp(K_2^*) = t^{-1/2},\ \exp(-K_2^*) = t^{1/2}) \\
&= \frac{1-t}{2\,t^{1/2}}
   \quad (\because \text{分子・分母に } t^{1/2} \text{ を掛ける}).
\end{aligned}`,
      ),
      paragraph([
        "さらに ",
        math(String.raw`t = \tanh K_2 = \dfrac{\sinh K_2}{\cosh K_2}`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1 + t
&= 1 + \frac{\sinh K_2}{\cosh K_2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= \frac{\cosh K_2 + \sinh K_2}{\cosh K_2}
   \quad (\because \text{通分}) \\
&= \frac{\exp(K_2)}{\cosh K_2}
   \quad (\because \cosh x + \sinh x = \exp(x)),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1 - t
&= 1 - \frac{\sinh K_2}{\cosh K_2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= \frac{\cosh K_2 - \sinh K_2}{\cosh K_2}
   \quad (\because \text{通分}) \\
&= \frac{\exp(-K_2)}{\cosh K_2}
   \quad (\because \cosh x - \sinh x = \exp(-x)).
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\cosh x \pm \sinh x = \exp(\pm x)`),
        " は ",
        ref("cosh_sinh_basic_properties"),
        " による。）",
      ]),
      paragraph(["中間目標: 前因子。まず"]),
      displayMath(String.raw`\begin{aligned}
2s_2
&= 2\sinh 2K_2
   \quad (\because s_2 = \sinh 2K_2 \text{ の代入}) \\
&= 2\left(2\sinh K_2\cosh K_2\right)
   \quad (\because \text{倍角公式 }\sinh 2K_2 = 2\sinh K_2\cosh K_2) \\
&= 4\sinh K_2\cosh K_2
   \quad (\because \text{数の積の結合則})
\end{aligned}`),
      paragraph([
        "である（倍角公式は ",
        ref("cosh_sinh_basic_properties"),
        " による）。",
        math(String.raw`\sinh K_2, \cosh K_2 > 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}
&= \left(4\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because 2s_2 = 4\sinh K_2\cosh K_2 \text{ の代入}) \\
&= 4^{1/2}\left(\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because \text{非負実数の平方根は積を保つ}) \\
&= 2\left(\sinh K_2\,\cosh K_2\right)^{1/2}
   \quad (\because 4^{1/2} = 2)
\end{aligned}`,
      ),
      displayMath(
        String.raw`t^{1/2} = \left(\frac{\sinh K_2}{\cosh K_2}\right)^{1/2}
   \quad (\because t = \tanh K_2 = \tfrac{\sinh K_2}{\cosh K_2} \text{ の代入})`,
      ),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{(2s_2)^{1/2}}{2\,t^{1/2}}
&= \frac{2\left(\sinh K_2\cosh K_2\right)^{1/2}}{2}
   \left(\frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{直前の 2 式の代入}) \\
&= \left(\sinh K_2\cosh K_2\right)^{1/2}
   \left(\frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{約分 } \tfrac{2}{2} = 1) \\
&= \left(\sinh K_2\cosh K_2 \cdot \frac{\cosh K_2}{\sinh K_2}\right)^{1/2}
   \quad (\because \text{非負実数の平方根は積を保つ}) \\
&= \left(\cosh^2 K_2\right)^{1/2}
   \quad (\because \text{約分 } \tfrac{\sinh K_2}{\sinh K_2} = 1) \\
&= \cosh K_2
   \quad (\because \cosh K_2 > 0)
\end{aligned}`,
      ),
      paragraph(["中間目標: 結論。上の二つの中間目標で得た式を合わせて"]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\cosh K_2^*
&= (2s_2)^{1/2}\,\frac{1+t}{2\,t^{1/2}}
   \quad (\because \cosh K_2^* \text{ を } K_2 \text{ で書いた式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1+t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1+t)
   \quad (\because \tfrac{(2s_2)^{1/2}}{2\,t^{1/2}}=\cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(K_2)}{\cosh K_2}
   \quad (\because 1+t=\tfrac{\exp(K_2)}{\cosh K_2}) \\
&= \exp(K_2)
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\sinh K_2^*
&= (2s_2)^{1/2}\,\frac{1-t}{2\,t^{1/2}}
   \quad (\because \sinh K_2^* \text{ を } K_2 \text{ で書いた式}) \\
&= \frac{(2s_2)^{1/2}}{2\,t^{1/2}}\,(1-t)
   \quad (\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1-t)
   \quad (\because \tfrac{(2s_2)^{1/2}}{2\,t^{1/2}}=\cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(-K_2)}{\cosh K_2}
   \quad (\because 1-t=\tfrac{\exp(-K_2)}{\cosh K_2}) \\
&= \exp(-K_2)
   \quad (\because \text{約分 } \tfrac{\cosh K_2}{\cosh K_2} = 1).
\end{aligned}`,
      ),
      paragraph(["これで主張の 2 式が示された。"]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移し、K_2^* と s_2 の参照先を <def_second_dual_coupling_constant> と <def_indexed_hyperbolic_abbreviations> にした。番号で区切っていた四つの段を中間目標の名前へ変えた。",
      ],
    },
  },
  {
    id: "transfer_matrix_definition_second_transfer_matrix_prefactor",
    kind: "definition",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 5 },
    title: { text: "第二の転送行列のパウリ行列表示の前係数" },
    labels: ["def_second_transfer_matrix_prefactor"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        " と ",
        ref("def_lattice_size"),
        " の列数 ",
        math(String.raw`M_{\mathrm{col}}`),
        " について、",
        ref("definition_of_sqrt_r_positive"),
        " の非負平方根を用いて",
      ]),
      displayMath(
        String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}:=\left(\sqrt{2\sinh 2K_2}^{\,(\mathbb{R}_{\geq 0})}\right)^{M_{\mathrm{col}}}\in\mathbb{R}_{>0}`,
      ),
      paragraph([
        "と定める。ここに現れる ",
        math(String.raw`\sinh`),
        " は ",
        ref("def_cosh_sinh"),
        " の双曲線正弦である。",
        math(String.raw`K_2>0`),
        " と ",
        ref("cosh_sinh_basic_properties"),
        " より ",
        math(String.raw`2\sinh 2K_2>0`),
        " なので、平方根は正の実数として定まり、その ",
        math(String.raw`M_{\mathrm{col}}`),
        " 乗も正の実数である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。旧 <def_second_transfer_matrix_pauli> の中にあった前係数の定義を独立した定義にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_second_transfer_matrix_pauli_form",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 6 },
    title: { tex: String.raw`V_2 \text{ のパウリ行列表示}` },
    labels: ["second_transfer_matrix_pauli_form"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " で成分により定めた ",
        math(String.raw`V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（結合定数 ",
        math(String.raw`K_2\in\mathbb{R}_{>0}`),
        "）は、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        "、",
        ref("def_second_transfer_matrix_prefactor"),
        " の前係数、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族を用いて",
      ]),
      displayMath(
        String.raw`V_2 = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\left(\sigma_1^x+\sigma_2^x+\cdots+\sigma_{M_{\mathrm{col}}}^x\right)\right)`,
      ),
      paragraph([
        "と表せる。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("two_by_two_transfer_identity"),
        " の ",
        math(String.raw`A \in \mathrm{Mat}(2,\mathbb{C})`),
        "（",
        math(String.raw`A_{ij} = \exp(K_2\varsigma_i\varsigma_j)`),
        "、",
        math(String.raw`\varsigma_1 = +1,\ \varsigma_2 = -1`),
        "）と、",
        ref("def_indexed_hyperbolic_abbreviations"),
        " の ",
        math(String.raw`s_2=\sinh 2K_2`),
        " を用いる。",
        math(String.raw`\mu,\mu'\in\mathfrak{M}`),
        " について ",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota(\mu) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        "、",
        math(String.raw`\iota(\mu') = (j_1,\dots,j_{M_{\mathrm{col}}})`),
        " と書くと、",
        math(String.raw`\iota`),
        " の定義より ",
        math(String.raw`\varsigma_{i_m} = \mu(m)`),
        "、",
        math(String.raw`\varsigma_{j_m} = \mu'(m)`),
        " である。",
      ]),
      paragraph([
        "中間目標: ",
        math(String.raw`V_2`),
        " を ",
        math(String.raw`A`),
        " のクロネッカー冪で書く。",
        math(String.raw`\mu,\mu'\in\mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_2)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
&= \exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu'(m)\right)
   &&(\because \blkref{def_transfer_matrix}) \\
&= \exp\!\left(\sum_{m=1}^{M_{\mathrm{col}}} K_2\,\mu(m)\mu'(m)\right)
   &&(\because \mathbb{R}\text{ の分配則}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\exp\!\left(K_2\,\mu(m)\mu'(m)\right)
   &&(\because \blkref{theorem_exp_product}\text{ を }n=1,\ K=\mathbb{R}\text{ で有限和へ繰り返し適用}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}} A_{i_m j_m}
   &&(\because A\text{ の成分と }\varsigma_{i_m}=\mu(m),\ \varsigma_{j_m}=\mu'(m)\text{ を全因子へ同時適用}) \\
&= \left(\underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}\right)_{\nu(\iota(\mu)),\nu(\iota(\mu'))}
   &&(\because \blkref{def_kronecker}\text{ (2) のクロネッカー積の成分}) \\
&= \left(\underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}\right)_{\mathrm{ord}(\mu),\mathrm{ord}(\mu')}
   &&(\because \blkref{config_numbering_equals_kronecker_numbering})
\end{aligned}`,
      ),
      paragraph([
        ref("row_configuration_numbering_bijective"),
        " の全射性より、すべての行・列番号の組は ",
        math(String.raw`(\mathrm{ord}(\mu),\mathrm{ord}(\mu'))`),
        " の形に書けるので、",
        math(String.raw`V_2 = A \boxtimes \cdots \boxtimes A`),
        "（",
        math(String.raw`M_{\mathrm{col}}`),
        " 個）である。",
      ]),
      paragraph([
        "中間目標: 1 因子の ",
        math(String.raw`\exp`),
        " をサイト演算子の ",
        math(String.raw`\exp`),
        " にする。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " を固定する。",
        ref("def_site_pauli_matrices"),
        " の ",
        math(String.raw`\sigma_m^x = I\boxtimes\cdots\boxtimes\sigma^x\boxtimes\cdots\boxtimes I`),
        "（第 ",
        math(String.raw`m`),
        " 因子だけが ",
        math(String.raw`\sigma^x`),
        "）について、",
        ref("kronecker_product_rule"),
        " (1) を繰り返し使うと ",
        math(String.raw`p \in \mathbb{Z}_{\geq 0}`),
        " で",
      ]),
      displayMath(
        String.raw`(\sigma_m^x)^{p}
= I\boxtimes\cdots\boxtimes(\sigma^x)^{p}\boxtimes\cdots\boxtimes I
\quad (\because \blkref{kronecker_product_rule}\text{ (1) と }I^p=I)`,
      ),
      paragraph([
        "であり（",
        math(String.raw`I \cdot I = I`),
        " なので他の因子は ",
        math(String.raw`I`),
        " のまま）、部分和と ",
        ref("kronecker_multilinear"),
        " の線型性、および ",
        ref("def_kronecker"),
        " (2) の成分表示による成分ごとの収束（",
        ref("exp_of_diagonal_matrix"),
        " の極限の段と同じ評価 ",
        math(String.raw`|B_{kl}| \leq \|B\|`),
        "）から",
      ]),
      displayMath(
        String.raw`\exp\!\left(K_2^*\sigma_m^x\right)
= I\boxtimes\cdots\boxtimes\exp\!\left(K_2^*\sigma^x\right)\boxtimes\cdots\boxtimes I
\quad (\because \text{指数級数の部分和へ直前の冪の等式を適用し、成分ごとの極限を取る})`,
      ),
      paragraph([
        "中間目標: 積にまとめる。相異なる ",
        math(String.raw`m \neq m'`),
        " について ",
        math(String.raw`\sigma_m^x`),
        " と ",
        math(String.raw`\sigma_{m'}^x`),
        " は可換である（",
        ref("kronecker_product_rule"),
        " (1) より、積はどちらの順でも「第 ",
        math(String.raw`m`),
        " 因子と第 ",
        math(String.raw`m'`),
        " 因子が ",
        math(String.raw`\sigma^x`),
        "、他が ",
        math(String.raw`I`),
        "」になる）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
&= \prod_{m=1}^{M_{\mathrm{col}}}\exp\!\left(K_2^*\sigma_m^x\right)
   &&(\because \blkref{theorem_exp_product}\text{ を互いに可換な }K_2^*\sigma_m^x\text{ の有限和へ繰り返し適用}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\left(I\boxtimes\cdots\boxtimes\exp\!\left(K_2^*\sigma^x\right)\boxtimes\cdots\boxtimes I\right)
   &&(\because \text{直前の中間目標の等式を全因子へ同時適用}) \\
&= \underbrace{\exp(K_2^*\sigma^x)\boxtimes\cdots\boxtimes\exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{kronecker_product_rule}\text{ (1) で因子ごとの積にまとめる})
\end{aligned}`,
      ),
      paragraph(["中間目標: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
V_2
&= \underbrace{A \boxtimes \cdots \boxtimes A}_{M_{\mathrm{col}}}
   &&(\because V_2\text{ を }A\text{ のクロネッカー冪で書いた式}) \\
&= \underbrace{\left((2s_2)^{1/2}\exp(K_2^*\sigma^x)\right) \boxtimes \cdots \boxtimes \left((2s_2)^{1/2}\exp(K_2^*\sigma^x)\right)}_{M_{\mathrm{col}}}
   &&(\because \blkref{two_by_two_transfer_identity}\text{ を全因子へ同時適用}) \\
&= \left((2s_2)^{1/2}\right)^{M_{\mathrm{col}}}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{kronecker_multilinear}\text{ で各因子のスカラーを前へ出す}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because s_2=\sinh 2K_2\text{ と }\blkref{def_second_transfer_matrix_prefactor}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
   &&(\because \text{積にまとめた式})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。" +
          "旧 <def_second_transfer_matrix_pauli>（V_2 をパウリ行列で定義していたブロック）と旧 <V2_component_equals_pauli>（成分定義との一致の主張）を統合した。" +
          "証明は旧 <V2_component_equals_pauli> の証明を、成分の番号を ord で指し、V_2 から始まる一続きの結論の式へ組み直したものである。前係数の定義は <def_second_transfer_matrix_prefactor> へ分けた。",
        "V_2 の exp の意味（どの代数のどの位相での級数か）が書かれていなかったため、<def_exp> の exp であることを明示した（定義が意味をもつために必要な事項）。",
        "M=2,3,4 と複数の K_2 について、成分定義の V_2 とパウリ表示の V_2 が残差 1e-14 以下で一致することを確認した（sagemath/check/043_claim_transfer_matrix_bridge/check_02_V2_bridge.sage）。2×2 の恒等式も同ファイルで確認している。",
      ],
    },
  },
  {
    id: "transfer_matrix_representation_claim_partition_function_via_pauli_transfer_matrices",
    kind: "claim",
    standing: "mainTheorem",
    title: { text: "Pauli 行列で書いた転送行列による分配関数の表式" },
    labels: ["partition_function_via_pauli_transfer_matrices"],
    statement: [
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z`),
        "、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列族 ",
        math(String.raw`\sigma_m^x, \sigma_m^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        ref("def_site_pauli_periodic_extension"),
        " の周期的な延長、",
        ref("def_second_dual_coupling_constant"),
        " の ",
        math(String.raw`K_2^*\in\mathbb{R}_{>0}`),
        "、",
        ref("def_second_transfer_matrix_prefactor"),
        " の前係数 ",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}\in\mathbb{R}_{>0}`),
        " について、",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        " のとき",
      ]),
      displayMath(
        String.raw`Z(K_1, K_2) = \mathrm{tr}\!\left(\left(
  \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
\right)^{N_{\mathrm{row}}}\right)`,
      ),
      paragraph([
        "が成り立つ。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z(K_1, K_2)
&= \mathrm{tr}\!\left((V_1 V_2)^{N_{\mathrm{row}}}\right)
&&(\because\ \blkref{partition_function_via_transfer_matrix}) \\
&= \mathrm{tr}\!\left(\left(
  \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
  V_2
\right)^{N_{\mathrm{row}}}\right)
&&(\because\ \blkref{first_transfer_matrix_pauli_form}) \\
&= \mathrm{tr}\!\left(\left(
  \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
\right)^{N_{\mathrm{row}}}\right)
&&(\because\ \blkref{second_transfer_matrix_pauli_form})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、転送行列による表示の章のゴールの式を一つの主張として立てた。既存の三つの主張を代入するだけで、新しい証明は無い。",
      ],
    },
  },
]);
