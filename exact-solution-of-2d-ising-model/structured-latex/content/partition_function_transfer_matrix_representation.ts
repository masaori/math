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
      displayMath(String.raw`\bigl(Z(K_1, K_2)\bigr)_{\mathbb{C}} = \mathrm{tr}\!\left((V_1 V_2)^{N_{\mathrm{row}}}\right)`),
      paragraph([
        "が成り立つ。",
        math(String.raw`Z(K_1,K_2) \in \mathbb{R}_{>0}`),
        " で右辺は ",
        math(String.raw`\mathbb{C}`),
        " の元なので、左辺は ",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`r_{\mathbb{C}}`),
        " で ",
        math(String.raw`\mathbb{C}`),
        " へ送って比べる。",
      ]),
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
&&(\because\ \blkref{theorem_exp_product}\ \text{を}\ n=1,\ K=\mathbb{R}\ \text{へ適用する。}\ \mathbb{C}\ \text{の積を実数の積の包含へまとめるのは}\ \blkref{real_inclusion_preserves_product}) \\
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
&&(\because\ \text{直前に示した指数の積の法則。}\ \mathbb{C}\ \text{の積を実数の積の包含へまとめるのは}\ \blkref{real_inclusion_preserves_finite_product}\ (m \to N_{\mathrm{row}}\text{、}r_j \to \text{1 行目の第}\ j\ \text{因子の指数の値})) \\
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
   \Bigl(\exp\!\left(\sum_{\substack{k\in\{1,\dots,N_{\mathrm{row}}\}\\m\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,\mu^{(k)}(m)\mu^{(k)}(m+1) + K_2\,\mu^{(k)}(m)\mu^{(k+1)}(m)\bigr)\right)\Bigr)_{\mathbb{C}}
&&(\because\ \text{上で示したトレースの展開と、直前に示した積の表式。}) \\
&= \sum_{s \in \mathfrak{S}}
   \Bigl(\exp\!\left(\sum_{\substack{i\in\{1,\dots,N_{\mathrm{row}}\}\\j\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,s(i,j)\,s(i,j+1) + K_2\,s(i,j)\,s(i+1,j)\bigr)\right)\Bigr)_{\mathbb{C}}
&&(\because\ \Phi\ \text{が全単射であることによる添え字の付け替えと}\ (\mathrm{P})) \\
&= \Bigl(\sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,N_{\mathrm{row}}\}\\j\in\{1,\dots,M_{\mathrm{col}}\}}} \bigl(K_1\,s(i,j)\,s(i,j+1) + K_2\,s(i,j)\,s(i+1,j)\bigr)\right)\Bigr)_{\mathbb{C}}
&&(\because\ \blkref{real_inclusion_preserves_finite_sum}\ (m \to 2^{M_{\mathrm{col}}N_{\mathrm{row}}}\text{、}\mathfrak{S}\ \text{の元を一つの並べ方で添字}\ 1,\dots,m\ \text{に並べ、両辺の和に同じ並べ方を使う})) \\
&= \bigl(Z(K_1,K_2)\bigr)_{\mathbb{C}}
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: 主張の左辺 Z(K_1,K_2) は def_partition_function_2d_ising で ℝ_{>0} の元、右辺のトレースは ℂ の元で、二つを等号で結んでいた。左辺を inclusion_rr_to_cc の (Z(K_1,K_2))_ℂ と書き、分配関数との一致の鎖の各項を (exp(…))_ℂ と書いて、最後に real_inclusion_preserves_finite_sum で包含を和の外へ出す行を足した（Lean の partition_function_via_transfer_matrix は元から ((Z : ℝ) : ℂ) = tr(…) の形である）。def_transfer_matrix が成分 exp(…) ∈ ℝ_{>0} を ℂ の元として書いていること（ℝ_{>0} ⊂ ℂ の包含の同一視）は、論文全体の実数の帰属の件として残っている。そのため、転送行列の積の成分と指数の積を指数の和へ書く二つの鎖は exp の値を ℂ の元として掛けており、成分を (exp(…))_ℂ と書いて real_inclusion_preserves_product で積の包含へまとめる段は、鎖の 1 行目の根拠に名前で挙げるだけになっている（Lean は ← Complex.ofReal_prod で書いている）。同一視を直すときに段として開く。𝔖 の上の和は本文に定義が無く（有限集合の添字の付け方の件）、1..m に並べて読む。",
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 実数の値の包含を積の外へ出す根拠の置き場を Lean の段に揃えた。上の 2026-11-06 の記録の「分配関数との一致の鎖の 1 行目に real_inclusion_preserves_product を因子ごとに挙げる」をやめ、N_row 個の因子の積の包含は「指数の積を指数の和へ」の鎖の 2 行目に有限積の real_inclusion_preserves_finite_product（m → N_row）で、2 因子の積の包含は「転送行列の積の成分」の鎖の 5 行目に real_inclusion_preserves_product で挙げた。Lean は ← Complex.ofReal_prod・← Complex.ofReal_mul をやめ、具体版 real_inclusion_preserves_finite_product・real_inclusion_mul を引く。exp の値を ℂ の元として掛けている同一視は残っているので、どちらも根拠に名前で挙げる形のままである。",
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
        ref("def_pauli_matrices"),
        " で定めた二次の Pauli 行列 ",
        math(String.raw`\sigma^x,\sigma^y,\sigma^z`),
        "、",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        " とした単位行列 ",
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
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 定義の文で二次の Pauli 行列と単位行列を引く出典を、pauli_matrix_products（Pauli 行列の積の主張）から、Pauli 行列は定義 def_pauli_matrices、I_{Mat(2,C)} は def_identity_matrix（n = 2）に替えた（Pauli 行列の定義を主張から分けたため）。定めた行列族は不変。",
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
    id: "transfer_matrix_claim_distinct_site_pauli_matrices_commute",
    kind: "claim",
    title: { text: "相異なるサイトに置いた Pauli 行列は可換" },
    labels: ["distinct_site_pauli_matrices_commute"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`),
        " とし、",
        ref("def_site_pauli_matrices"),
        " のサイトごとの Pauli 行列 ",
        math(String.raw`\sigma_k^a \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を用いる。",
        math(String.raw`j,k\in\{1,\dots,M_{\mathrm{col}}\}`),
        " が ",
        math(String.raw`j\neq k`),
        " を満たし、",
        math(String.raw`a,b\in\{x,y,z\}`),
        " ならば、",
      ]),
      displayMath(String.raw`\sigma_j^a\,\sigma_k^b = \sigma_k^b\,\sigma_j^a`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " と書き、",
        math(String.raw`i\in\{1,\dots,M_{\mathrm{col}}\}`),
        " に対して ",
        math(String.raw`x_i, y_i \in \mathrm{Mat}(2,\mathbb{C})`),
        " を",
      ]),
      displayMath(
        String.raw`x_i := \begin{cases} \sigma^a & (i = j) \\ I & (i \neq j) \end{cases},
\qquad
y_i := \begin{cases} \sigma^b & (i = k) \\ I & (i \neq k) \end{cases}`,
      ),
      paragraph(["と置く。"]),
      displayMath(
        String.raw`\sigma_j^a = x_1\boxtimes\cdots\boxtimes x_{M_{\mathrm{col}}},\qquad
\sigma_k^b = y_1\boxtimes\cdots\boxtimes y_{M_{\mathrm{col}}}
\quad (\because \blkref{def_site_pauli_matrices})`,
      ),
      paragraph([
        "各 ",
        math(String.raw`i\in\{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`y_ix_i = x_iy_i`),
        " を、",
        math(String.raw`i`),
        " の場合に分けて示す。",
        math(String.raw`i = j`),
        " のとき（",
        math(String.raw`j\neq k`),
        " より ",
        math(String.raw`i\neq k`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y_ix_i
&= I\,\sigma^a
   \quad (\because x_i,\ y_i \text{ の定義}) \\
&= \sigma^a
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ (m \to 2,\ n \to 2,\ A \to \sigma^a)) \\
&= \sigma^a\,I
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (m \to 2,\ n \to 2,\ A \to \sigma^a)\ \text{を右辺から左辺へ}) \\
&= x_iy_i
   \quad (\because x_i,\ y_i \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`i = k`),
        " のとき（",
        math(String.raw`j\neq k`),
        " より ",
        math(String.raw`i\neq j`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y_ix_i
&= \sigma^b\,I
   \quad (\because x_i,\ y_i \text{ の定義}) \\
&= \sigma^b
   \quad (\because \blkref{identity_matrix_is_right_unit_of_mat_mult}\ (m \to 2,\ n \to 2,\ A \to \sigma^b)) \\
&= I\,\sigma^b
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\ (m \to 2,\ n \to 2,\ A \to \sigma^b)\ \text{を右辺から左辺へ}) \\
&= x_iy_i
   \quad (\because x_i,\ y_i \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`i\neq j`),
        " かつ ",
        math(String.raw`i\neq k`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y_ix_i
&= I\,I
   \quad (\because x_i,\ y_i \text{ の定義}) \\
&= x_iy_i
   \quad (\because x_i,\ y_i \text{ の定義})
\end{aligned}`,
      ),
      paragraph(["これらを使うと、"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_j^a\,\sigma_k^b
&= (x_1\boxtimes\cdots\boxtimes x_{M_{\mathrm{col}}})(y_1\boxtimes\cdots\boxtimes y_{M_{\mathrm{col}}})
   \quad (\because \text{準備の}\ \sigma_j^a,\ \sigma_k^b\ \text{の表示}) \\
&= (y_1\boxtimes\cdots\boxtimes y_{M_{\mathrm{col}}})(x_1\boxtimes\cdots\boxtimes x_{M_{\mathrm{col}}})
   \quad (\because \blkref{tensor_commutation_from_all_sites}\ (M \to M_{\mathrm{col}})\ \text{と、全ての}\ i\ \text{についての}\ y_ix_i = x_iy_i) \\
&= \sigma_k^b\,\sigma_j^a
   \quad (\because \text{準備の}\ \sigma_j^a,\ \sigma_k^b\ \text{の表示})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-03（Lean の通しの証明のゴールラインの確認）: 原文（Typst）に対応ブロックは無い。iH_is_real_symmetric の Step 0 が「相異なるサイトに置かれた σ_j^a と σ_k^b は可換である」を、kronecker_product_rule (1) と「各サイトでは一方が I」の散文で述べていたので、tensor_commutation_from_all_sites で引ける主張として足した。",
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
      displayMath(String.raw`\sigma_m^z\, f_{\iota(\mu)} = \mu(m)_{\mathbb{C}}\, f_{\iota(\mu)}`),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`\mu(m)\in\{-1,1\}\subset\mathbb{R}`),
        "、",
        math(String.raw`\mu(m)_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(\mu(m))`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記、右辺は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍、左辺の積は ",
        ref("mat_mult"),
        " の数ベクトルへの作用である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("def_pauli_matrices"),
        " の ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " と ",
        ref("def_end_iso"),
        " の ",
        math(String.raw`e_1 = (1,0),\ e_2 = (0,1)`),
        " について（成分の ",
        math(String.raw`1, 0, -1`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記の ",
        math(String.raw`1_{\mathbb{C}}, 0_{\mathbb{C}}, -1_{\mathbb{C}}`),
        " である）、",
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
\quad (\because \blkref{def_pauli_matrices},\blkref{def_end_iso}) \\
&=
\begin{pmatrix}
  1\cdot 1 + 0\cdot 0 \\
  0\cdot 1 + (-1)\cdot 0
\end{pmatrix}
\quad (\because \blkref{mat_mult}) \\
&=
\begin{pmatrix}
  1 + 0 \\
  0 + 0
\end{pmatrix}
\quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元},\ \blkref{complex_zero_times_is_zero},\ \blkref{complex_times_zero_is_zero}) \\
&=
\begin{pmatrix}
  1 \\
  0
\end{pmatrix}
\quad (\because \blkref{complex_numbers_form_a_field}\text{ の加法の単位元}) \\
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
\quad (\because \blkref{def_pauli_matrices},\blkref{def_end_iso}) \\
&=
\begin{pmatrix}
  1\cdot 0 + 0\cdot 1 \\
  0\cdot 0 + (-1)\cdot 1
\end{pmatrix}
\quad (\because \blkref{mat_mult}) \\
&=
\begin{pmatrix}
  0 + 0 \\
  0 + (-1)
\end{pmatrix}
\quad (\because \blkref{complex_times_zero_is_zero},\ \blkref{complex_zero_times_is_zero},\ \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元}) \\
&=
\begin{pmatrix}
  0 \\
  -1
\end{pmatrix}
\quad (\because \blkref{complex_numbers_form_a_field}\text{ の加法の単位元}) \\
&=
\begin{pmatrix}
  (-1_{\mathbb{C}})\,0_{\mathbb{C}} \\
  (-1_{\mathbb{C}})\,1_{\mathbb{C}}
\end{pmatrix}
\quad (\because \blkref{complex_times_zero_is_zero},\ \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元}) \\
&=
\begin{pmatrix}
  -(0_{\mathbb{C}}) \\
  -(1_{\mathbb{C}})
\end{pmatrix}
\quad (\because \blkref{multiply_by_minus_one}) \\
&= -e_2
\quad (\because \blkref{def_end_iso},\blkref{def_matrix_negation}).
\end{aligned}`,
      ),
      paragraph([
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota(\mu) = (i_1,\dots,i_{M_{\mathrm{col}}})`),
        " の第 ",
        math(String.raw`m`),
        " 成分 ",
        math(String.raw`i_m`),
        " について、二つの場合に分ける。",
        math(String.raw`\mu(m) = 1`),
        " のとき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_{i_m}
&= \sigma^z e_1
\quad (\because \blkref{def_config_basis_iso}\text{ より } i_m = 1) \\
&= e_1
\quad (\because \text{上の }\sigma^z e_1 = e_1) \\
&= 1_{\mathbb{C}}\,e_1
\quad (\because \blkref{scalar_multiple_by_one}) \\
&= \mu(m)_{\mathbb{C}}\,e_{i_m}
\quad (\because \mu(m) = 1\text{ より }\mu(m)_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(1) = 1_{\mathbb{C}}\ \blkref{inclusion_rr_to_cc},\ i_m = 1).
\end{aligned}`,
      ),
      paragraph([math(String.raw`\mu(m) = -1`), " のとき、"]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z e_{i_m}
&= \sigma^z e_2
\quad (\because \blkref{def_config_basis_iso}\text{ より } i_m = 2) \\
&= -e_2
\quad (\because \text{上の }\sigma^z e_2 = -e_2) \\
&= (-1_{\mathbb{C}})\,e_2
\quad (\because \blkref{negation_is_scalar_multiple_by_minus_one}) \\
&= \mu(m)_{\mathbb{C}}\,e_{i_m}
\quad (\because \mu(m) = -1\text{ より }\mu(m)_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1) = -1_{\mathbb{C}}\ \blkref{inclusion_rr_to_cc},\ i_m = 2).
\end{aligned}`,
      ),
      paragraph([
        "どちらの場合も ",
        math(String.raw`\sigma^z e_{i_m} = \mu(m)_{\mathbb{C}}\,e_{i_m}`),
        " である。これを使って、",
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
   \quad (\because \blkref{kronecker_product_rule}\ (3)) \\
&= e_{i_1}\boxtimes\cdots\boxtimes(\sigma^z e_{i_m})\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \blkref{identity_matrix_is_left_unit_of_mat_mult}\text{ を第 }m\text{ 因子以外へ同時に適用}) \\
&= e_{i_1}\boxtimes\cdots\boxtimes\left(\mu(m)_{\mathbb{C}}\,e_{i_m}\right)\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}
   \quad (\because \text{上の }\sigma^z e_{i_m}=\mu(m)_{\mathbb{C}}\,e_{i_m}) \\
&= \mu(m)_{\mathbb{C}}\,\left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)
   \quad (\because \blkref{kronecker_multilinear}\text{ の数ベクトルの場合を }c = \mu(m)_{\mathbb{C}}\text{ で}) \\
&= \mu(m)_{\mathbb{C}}\, f_{\iota(\mu)}
   \quad (\because \blkref{def_config_basis_iso})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移した。",
        "2026-11-02: SageMath の検算（sagemath/check/sigma_z_diagonal_action/）のレビューで、1 ブロックに 4 つの主張（σ_m^z の固有ベクトルの等式・積の等式・二つの対角性）があったので、" +
          "この主張を σ_m^z f_{ι(μ)} = μ(m)_C f_{ι(μ)} だけにし、ほかを sigma_z_product_action・site_sigma_z_is_diagonal・site_sigma_z_product_is_diagonal に分けた。" +
          "スカラーを inclusion_rr_to_cc の μ(m)_C と書き、場合分けを (∵) 付きの鎖に、ラベルの無かった根拠（行列と列ベクトルの積・恒等行列の作用）をラベル参照にした。",
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 証明の準備で σ^z の成分を引く段落と、σ^z e_1・σ^z e_2 の鎖の 1 行目の根拠（2 行）の出典を、pauli_matrix_products（Pauli 行列の積の主張）から Pauli 行列の定義 def_pauli_matrices に替えた（Pauli 行列の定義を主張から分けたため）。式は不変。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_sigma_z_product_action",
    kind: "claim",
    title: { tex: String.raw`\sigma_m^z\sigma_{m'}^z \text{ の基底 } f_{\iota(\mu)} \text{ への作用}` },
    labels: ["sigma_z_product_action"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        "、",
        math(String.raw`m, m' \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
      ]),
      displayMath(String.raw`\sigma_m^z\sigma_{m'}^z\, f_{\iota(\mu)} = \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}\, f_{\iota(\mu)}`),
      paragraph([
        "が成り立つ。記号は ",
        ref("sigma_z_diagonal_action"),
        " のものである。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^z\sigma_{m'}^z f_{\iota(\mu)}
&= \sigma_m^z\left(\sigma_{m'}^z f_{\iota(\mu)}\right)
   \quad (\because \blkref{mat_mult_associative}) \\
&= \sigma_m^z\left(\mu(m')_{\mathbb{C}}\,f_{\iota(\mu)}\right)
   \quad (\because \blkref{sigma_z_diagonal_action}\text{ を }m'\text{ で}) \\
&= \mu(m')_{\mathbb{C}}\left(\sigma_m^z f_{\iota(\mu)}\right)
   \quad (\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= \mu(m')_{\mathbb{C}}\left(\mu(m)_{\mathbb{C}}\,f_{\iota(\mu)}\right)
   \quad (\because \blkref{sigma_z_diagonal_action}\text{ を }m\text{ で}) \\
&= \left(\mu(m')_{\mathbb{C}}\,\mu(m)_{\mathbb{C}}\right)f_{\iota(\mu)}
   \quad (\because \blkref{scalar_multiple_is_associative}) \\
&= \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}\,f_{\iota(\mu)}
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の交換律}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sigma_z_diagonal_action の「とくに」の積の等式を独立の主張にした（1 ブロック 1 主張）。結合律の行を足し、ラベルの無かった根拠（行列作用の線型性・スカラー倍の結合律）をラベル参照にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_site_sigma_z_is_diagonal",
    kind: "claim",
    title: { tex: String.raw`\sigma_m^z \text{ は対角行列}` },
    labels: ["site_sigma_z_is_diagonal"],
    statement: [
      paragraph([
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        ref("def_site_pauli_matrices"),
        " の ",
        math(String.raw`\sigma_m^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " は対角行列（",
        ref("def_diagonal_matrix"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`s, t \in \{1,2\}`),
        "、",
        math(String.raw`s \neq t`),
        " について ",
        math(String.raw`(I_{\mathrm{Mat}(2,\mathbb{C})})_{st} = \delta_{st} = 0_{\mathbb{C}}`),
        "（",
        ref("def_identity_matrix"),
        "、",
        ref("def_kronecker_delta"),
        "）、",
        math(String.raw`(\sigma^z)_{st} = 0_{\mathbb{C}}`),
        "（",
        ref("def_pauli_matrices"),
        "）である。第 ",
        math(String.raw`p`),
        " 因子（",
        math(String.raw`p \in \{1,\dots,M_{\mathrm{col}}\}`),
        "）を ",
        math(String.raw`A_p := \sigma^z`),
        "（",
        math(String.raw`p = m`),
        "）、",
        math(String.raw`A_p := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        math(String.raw`p \neq m`),
        "）とおくと、どの ",
        math(String.raw`p`),
        " についても ",
        math(String.raw`s \neq t \Rightarrow (A_p)_{st} = 0_{\mathbb{C}}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        math(String.raw`k \neq l`),
        " を取る。",
        ref("def_kronecker"),
        " の ",
        math(String.raw`\nu`),
        " は全単射なので ",
        math(String.raw`k = \nu(K)`),
        "、",
        math(String.raw`l = \nu(L)`),
        " となる ",
        math(String.raw`K = (k_1,\dots,k_{M_{\mathrm{col}}}),\ L = (l_1,\dots,l_{M_{\mathrm{col}}}) \in \mathcal{I}`),
        " がある。",
        math(String.raw`k \neq l`),
        " より ",
        math(String.raw`K \neq L`),
        " なので、",
        math(String.raw`k_n \neq l_n`),
        " となる ",
        math(String.raw`n \in \{1,\dots,M_{\mathrm{col}}\}`),
        " がある。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sigma_m^z)_{kl}
&= \left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)_{\nu(K),\nu(L)}
   \quad (\because \blkref{def_site_pauli_matrices}) \\
&= \prod_{p=1}^{M_{\mathrm{col}}}(A_p)_{k_p l_p}
   \quad (\because \blkref{def_kronecker}\ (2)) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{finite_product_with_zero_factor_is_zero}\text{ を、準備の }(A_n)_{k_n l_n} = 0_{\mathbb{C}}\ (k_n \neq l_n)\text{ で}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sigma_z_diagonal_action の「これらはすべて基底 (f_I) に関して対角行列である」を、対角行列の定義（def_diagonal_matrix）に沿って成分で述べる独立の主張にした。" +
          "旧い証明は「基底の各元が固有ベクトルなので」と書いていたが、f_I の成分が δ であることを経ずに成分の意味の対角性へ渡していたので、クロネッカー積の成分から直接示す形にした。",
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 証明の準備で (σ^z)_{st} = 0_C（s ≠ t）を引く出典を、pauli_matrix_products（Pauli 行列の積の主張）から Pauli 行列の定義 def_pauli_matrices に替えた（Pauli 行列の定義を主張から分けたため）。式は不変。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_site_sigma_z_product_is_diagonal",
    kind: "claim",
    title: { tex: String.raw`\sigma_m^z\sigma_{m'}^z \text{ は対角行列}` },
    labels: ["site_sigma_z_product_is_diagonal"],
    statement: [
      paragraph([
        math(String.raw`m, m' \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        math(String.raw`\sigma_m^z\sigma_{m'}^z \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        ref("mat_mult"),
        " の積）は対角行列（",
        ref("def_diagonal_matrix"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        math(String.raw`k \neq l`),
        " を取る。",
        math(String.raw`q \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " について、",
        math(String.raw`q \neq k`),
        " なら ",
        math(String.raw`(\sigma_m^z)_{kq} = 0_{\mathbb{C}}`),
        "（",
        ref("site_sigma_z_is_diagonal"),
        "）なので ",
        math(String.raw`(\sigma_m^z)_{kq}(\sigma_{m'}^z)_{ql} = 0_{\mathbb{C}}\,(\sigma_{m'}^z)_{ql} = 0_{\mathbb{C}}`),
        "（",
        ref("complex_zero_times_is_zero"),
        "）、",
        math(String.raw`q = k`),
        " なら ",
        math(String.raw`(\sigma_{m'}^z)_{ql} = (\sigma_{m'}^z)_{kl} = 0_{\mathbb{C}}`),
        "（",
        ref("site_sigma_z_is_diagonal"),
        " を ",
        math(String.raw`m'`),
        " で）なので ",
        math(String.raw`(\sigma_m^z)_{kq}(\sigma_{m'}^z)_{ql} = (\sigma_m^z)_{kq}\,0_{\mathbb{C}} = 0_{\mathbb{C}}`),
        "（",
        ref("complex_times_zero_is_zero"),
        "）である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m'}^z)_{kl}
&= \sum_{q=1}^{2^{M_{\mathrm{col}}}}(\sigma_m^z)_{kq}(\sigma_{m'}^z)_{ql}
   \quad (\because \blkref{mat_mult}) \\
&= \sum_{q=1}^{2^{M_{\mathrm{col}}}} 0_{\mathbb{C}}
   \quad (\because \text{上の各項が }0_{\mathbb{C}}\text{ であることを各 }q\text{ へ同時に適用}) \\
&= 0_{\mathbb{C}}
   \quad (\because \blkref{finite_sum_of_complex_zeros}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: sigma_z_diagonal_action の「これらはすべて基底 (f_I) に関して対角行列である」のうち積の側を、対角行列の定義（def_diagonal_matrix）に沿って成分で述べる独立の主張にした。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_config_basis_vector_own_component",
    kind: "claim",
    title: { tex: String.raw`f_I \text{ の第 } \nu(I) \text{ 成分は } 1` },
    labels: ["config_basis_vector_own_component"],
    statement: [
      paragraph([
        ref("def_end_iso"),
        " を ",
        math(String.raw`M := M_{\mathrm{col}}`),
        " として用いたときの ",
        math(String.raw`f_I \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " と、",
        ref("def_kronecker"),
        " の番号付け ",
        math(String.raw`\nu`),
        " について、",
        math(String.raw`I = (i_1,\dots,i_{M_{\mathrm{col}}}) \in \mathcal{I}`),
        " ならば",
      ]),
      displayMath(String.raw`(f_I)_{\nu(I)} = 1_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。",
        math(String.raw`1_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(f_I)_{\nu(I)}
&= \left(e_{i_1}\boxtimes\cdots\boxtimes e_{i_{M_{\mathrm{col}}}}\right)_{\nu(I)}
   \quad (\because \blkref{def_end_iso}) \\
&= \prod_{k=1}^{M_{\mathrm{col}}} (e_{i_k})_{i_k}
   \quad (\because \blkref{def_kronecker}\ (1)) \\
&= \prod_{k=1}^{M_{\mathrm{col}}} 1_{\mathbb{C}}
   \quad (\because \blkref{def_end_iso}\text{ の }e_1 = (1,0),\ e_2 = (0,1)\text{ より }(e_1)_1 = (e_2)_2 = 1_{\mathbb{C}}\text{ を各因子へ同時に適用}) \\
&= 1_{\mathbb{C}}
   \quad (\because \blkref{finite_product_of_complex_ones}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。同じ計算は tensor_basis の証明の Step 1 の中にあったが主張ではなかった。site_sigma_z_product_diagonal_entry の証明が引くので足した。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_site_sigma_z_product_diagonal_entry",
    kind: "claim",
    title: { tex: String.raw`\sigma_m^z\sigma_{m'}^z \text{ の対角成分}` },
    labels: ["site_sigma_z_product_diagonal_entry"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        "、",
        math(String.raw`m, m' \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について、",
        math(String.raw`k := \nu(\iota(\mu)) \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "（",
        ref("def_kronecker"),
        " の ",
        math(String.raw`\nu`),
        "、",
        ref("def_config_basis_iso"),
        " の ",
        math(String.raw`\iota`),
        "）とおくと",
      ]),
      displayMath(String.raw`(\sigma_m^z\sigma_{m'}^z)_{kk} = \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}`),
      paragraph([
        "が成り立つ。記号は ",
        ref("sigma_z_diagonal_action"),
        " のものである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        math(String.raw`l \neq k`),
        " について、",
        ref("site_sigma_z_product_is_diagonal"),
        " より ",
        math(String.raw`(\sigma_m^z\sigma_{m'}^z)_{kl} = 0_{\mathbb{C}}`),
        " なので、",
        ref("complex_zero_times_is_zero"),
        " より ",
        math(String.raw`(\sigma_m^z\sigma_{m'}^z)_{kl}\,(f_{\iota(\mu)})_l = 0_{\mathbb{C}}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\sigma_m^z\sigma_{m'}^z)_{kk}
&= (\sigma_m^z\sigma_{m'}^z)_{kk}\,1_{\mathbb{C}}
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元}) \\
&= (\sigma_m^z\sigma_{m'}^z)_{kk}\,(f_{\iota(\mu)})_{k}
   \quad (\because \blkref{config_basis_vector_own_component}\text{ を }I = \iota(\mu)\text{ で}) \\
&= \sum_{l=1}^{2^{M_{\mathrm{col}}}} (\sigma_m^z\sigma_{m'}^z)_{kl}\,(f_{\iota(\mu)})_{l}
   \quad (\because \blkref{finite_sum_with_single_nonzero_term}\text{ を、準備の }l \neq k\text{ の項が }0_{\mathbb{C}}\text{ であることで}) \\
&= \left(\sigma_m^z\sigma_{m'}^z\, f_{\iota(\mu)}\right)_{k}
   \quad (\because \blkref{mat_mult}) \\
&= \left(\mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}\, f_{\iota(\mu)}\right)_{k}
   \quad (\because \blkref{sigma_z_product_action}) \\
&= \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}\, (f_{\iota(\mu)})_{k}
   \quad (\because \blkref{def_matrix_scalar_multiple}) \\
&= \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}\, 1_{\mathbb{C}}
   \quad (\because \blkref{config_basis_vector_own_component}\text{ を }I = \iota(\mu)\text{ で}) \\
&= \mu(m)_{\mathbb{C}}\,\mu(m')_{\mathbb{C}}
   \quad (\because \blkref{complex_numbers_form_a_field}\text{ の乗法の単位元}).
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: 原文（Typst）に対応ブロックは無い。first_transfer_matrix_pauli_form の証明が「D の対角成分は d(μ)」を、固有ベクトルの等式から f_I の成分を経ずに読んでいたので、成分で述べる主張にした。",
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
        "（",
        ref("def_finite_sum_of_matrices"),
        " の有限和）とおく。",
        math(String.raw`m \in \{1,\dots,M_{\mathrm{col}}\}`),
        " について ",
        math(String.raw`m^{+} := m+1`),
        "（",
        math(String.raw`m \leq M_{\mathrm{col}}-1`),
        "）、",
        math(String.raw`m^{+} := 1`),
        "（",
        math(String.raw`m = M_{\mathrm{col}}`),
        "）とおく。",
        math(String.raw`m^{+} \in \{1,\dots,M_{\mathrm{col}}\}`),
        " であり、",
        ref("def_site_pauli_periodic_extension"),
        " より ",
        math(String.raw`\sigma_{m+1}^z = \sigma_{m^{+}}^z`),
        "、",
        ref("def_transfer_matrix"),
        " の周期規約 ",
        math(String.raw`\mu(M_{\mathrm{col}}+1) := \mu(1)`),
        " より ",
        math(String.raw`\mu(m+1) = \mu(m^{+})`),
        " である。",
        math(String.raw`\mu \in \mathfrak{M}`),
        " について ",
        math(String.raw`d(\mu) := \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\mu(m+1) \in \mathbb{R}`),
        " とおく。",
      ]),
      paragraph([
        "中間目標: ",
        math(String.raw`D`),
        " は対角行列（",
        ref("def_diagonal_matrix"),
        "）である。",
        math(String.raw`k, l \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        "、",
        math(String.raw`k \neq l`),
        " を取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{kl}
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)_{kl}
   &&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m^{+}}^z\right)_{kl}
   &&(\because \sigma_{m+1}^z = \sigma_{m^{+}}^z\text{ を各項へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}} 0_{\mathbb{C}}
   &&(\because \blkref{site_sigma_z_product_is_diagonal}\text{ を各 }(m, m^{+})\text{ へ同時に適用}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{finite_sum_of_complex_zeros}).
\end{aligned}`,
      ),
      paragraph([
        "中間目標: ",
        math(String.raw`D`),
        " の対角成分。",
        math(String.raw`\mu \in \mathfrak{M}`),
        " を任意に取り、",
        math(String.raw`k := \nu(\iota(\mu))`),
        " とおく。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{kk}
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m+1}^z\right)_{kk}
   &&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\sigma_m^z\sigma_{m^{+}}^z\right)_{kk}
   &&(\because \sigma_{m+1}^z = \sigma_{m^{+}}^z\text{ を各項へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\mu(m)_{\mathbb{C}}\,\mu(m^{+})_{\mathbb{C}}
   &&(\because \blkref{site_sigma_z_product_diagonal_entry}\text{ を各 }(m, m^{+})\text{ へ同時に適用}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}}\left(\mu(m)\,\mu(m^{+})\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_product}\text{ を各項へ同時に適用}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu(m^{+})\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \left(\sum_{m=1}^{M_{\mathrm{col}}}\mu(m)\,\mu(m+1)\right)_{\mathbb{C}}
   &&(\because \mu(m+1) = \mu(m^{+})\text{ を各項へ同時に適用}) \\
&= d(\mu)_{\mathbb{C}}
   &&(\because d(\mu)\text{ の定義}).
\end{aligned}`,
      ),
      paragraph([
        "中間目標: ",
        math(String.raw`K_1 D`),
        "（",
        ref("def_matrix_scalar_multiple"),
        " の ",
        math(String.raw`(K_1)_{\mathbb{C}}`),
        " 倍）も対角行列で、対角成分は ",
        math(String.raw`(K_1)_{\mathbb{C}}\,d(\mu)_{\mathbb{C}}`),
        " である。",
        math(String.raw`k \neq l`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(K_1 D)_{kl}
&= (K_1)_{\mathbb{C}}\,D_{kl}
   &&(\because \blkref{def_matrix_scalar_multiple}) \\
&= (K_1)_{\mathbb{C}}\,0_{\mathbb{C}}
   &&(\because \text{上の }D\text{ が対角行列であること}) \\
&= 0_{\mathbb{C}}
   &&(\because \blkref{complex_times_zero_is_zero}),
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`k = \nu(\iota(\mu))`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(K_1 D)_{kk}
&= (K_1)_{\mathbb{C}}\,D_{kk}
   &&(\because \blkref{def_matrix_scalar_multiple}) \\
&= (K_1)_{\mathbb{C}}\,d(\mu)_{\mathbb{C}}
   &&(\because \text{上の }D\text{ の対角成分}).
\end{aligned}`,
      ),
      paragraph([
        ref("def_kronecker"),
        " の ",
        math(String.raw`\nu`),
        " と ",
        ref("config_numbering_equals_kronecker_numbering"),
        "・",
        ref("row_configuration_numbering_bijective"),
        " より、どの ",
        math(String.raw`k \in \{1,\dots,2^{M_{\mathrm{col}}}\}`),
        " も ",
        math(String.raw`\nu(\iota(\mu))`),
        " の形に書ける。",
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
\exp\!\left((K_1)_{\mathbb{C}}\,d(\mu)_{\mathbb{C}}\right) & (\nu(\iota(\mu)) = \nu(\iota(\mu'))) \\
0_{\mathbb{C}} & (\nu(\iota(\mu)) \neq \nu(\iota(\mu')))
\end{cases}
  &&(\because \blkref{exp_of_diagonal_matrix}\text{ を、上の対角行列 }K_1 D\text{ とその対角成分へ}) \\
&= \begin{cases}
\exp\!\left((K_1\,d(\mu))_{\mathbb{C}}\right) & (\nu(\iota(\mu)) = \nu(\iota(\mu'))) \\
0_{\mathbb{C}} & (\nu(\iota(\mu)) \neq \nu(\iota(\mu')))
\end{cases}
  &&(\because \blkref{real_inclusion_preserves_product}) \\
&= \begin{cases}
\left(\exp\!\left(K_1 d(\mu)\right)\right)_{\mathbb{C}} & (\nu(\iota(\mu)) = \nu(\iota(\mu'))) \\
0_{\mathbb{C}} & (\nu(\iota(\mu)) \neq \nu(\iota(\mu')))
\end{cases}
  &&(\because \blkref{complex_exp_of_real_argument}) \\
&= \begin{cases}
\left(\exp\!\left(K_1 d(\mu)\right)\right)_{\mathbb{C}} & (\mathrm{ord}(\mu) = \mathrm{ord}(\mu')) \\
0_{\mathbb{C}} & (\mathrm{ord}(\mu) \neq \mathrm{ord}(\mu'))
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
        "2026-11-02: sigma_z_diagonal_action を 4 つの主張に分けたのに合わせ、「D は基底 (f_I) に関して対角行列で、対角成分は d(μ)」を、site_sigma_z_product_is_diagonal・site_sigma_z_product_diagonal_entry と有限和の成分（finite_sum_of_matrices_entrywise）から成分で示す鎖にした。" +
          "D f_{ι(μ)} の固有ベクトルの鎖は使われなくなったので外した。K_1 と d(μ) を ℂ へ送る写像（inclusion_rr_to_cc）と、複素数の exp と実数の exp の一致（complex_exp_of_real_argument）を鎖に書いた。",
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
        "が成り立つ（逆写像の定義）。（実対数による ",
        math(String.raw`\mathbb R`),
        " 脱出）この項は実数指数関数の全単射性と実対数を用いるため、有限な複素行列計算から実数解析へ移る先行定義である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "第一の双対結合定数を定める前提として、正の実数上の実対数と、0<y<1 なら log y<0 となる符号性を一つの独立定義として置いた。数学的道具立ての既存分類・節境界は変更していない。",
        "2026-11-02: 1 ブロック 1 主張に従い、定義の中で述べていた「log の狭義単調増加」と「0<y<1 なら log y<0」を、主張 real_log_strictly_increasing・real_log_negative_below_one へ分けた。狭義単調増加は証明なしで述べていたので、exp の狭義単調増加からの背理法の証明を付けた。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_real_log_strictly_increasing",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "正の実数上の実対数は狭義単調増加" },
    labels: ["real_log_strictly_increasing"],
    statement: [
      paragraph([
        ref("def_real_logarithm_positive"),
        " の実対数について、",
        math(String.raw`u,v\in\mathbb{R}_{>0}`),
        " が ",
        math(String.raw`u<v`),
        " を満たすなら ",
        math(String.raw`\log u<\log v`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb R`),
        " 脱出）",
        math(String.raw`u,v\in\mathbb{R}_{>0}`),
        "、",
        math(String.raw`u<v`),
        " とする。",
        ref("def_real_logarithm_positive"),
        " より ",
        math(String.raw`\log u,\log v\in\mathbb{R}`),
        " である。",
        math(String.raw`\log u<\log v`),
        " でないと仮定する。",
        math(String.raw`\mathbb{R}`),
        " の順序の三分律より、",
        math(String.raw`\log v<\log u`),
        " または ",
        math(String.raw`\log v=\log u`),
        " である。",
      ]),
      paragraph([math(String.raw`\log v<\log u`), " の場合。"]),
      displayMath(String.raw`\begin{aligned}
v
&=\exp(\log v)
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
&<\exp(\log u)
&&\left(\because\ \log v<\log u\text{ と }\blkref{real_exp_strictly_increasing}\right)\\
&=u
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`u<v`),
        " と両立しない（",
        math(String.raw`\mathbb{R}`),
        " の順序の非対称性）。",
      ]),
      paragraph([math(String.raw`\log v=\log u`), " の場合。"]),
      displayMath(String.raw`\begin{aligned}
v
&=\exp(\log v)
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)\\
&=\exp(\log u)
&&\left(\because\ \log v=\log u\right)\\
&=u
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\exp(\log y)=y\right)
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`u<v`),
        " と両立しない（",
        math(String.raw`\mathbb{R}`),
        " の順序の非反射性）。どちらの場合も矛盾するので、",
        math(String.raw`\log u<\log v`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: def_real_logarithm_positive の定義の中で証明なしに述べていた「狭義単調増加な全単射の逆写像も狭義単調増加」を、この主張として分け、exp の狭義単調増加からの背理法で示した。",
      ],
    },
  },
  {
    id: "transfer_matrix_claim_real_log_negative_below_one",
    kind: "claim",
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 1 },
    title: { text: "1 より小さい正の実数の実対数は負" },
    labels: ["real_log_negative_below_one"],
    statement: [
      paragraph([
        ref("def_real_logarithm_positive"),
        " の実対数について、",
        math(String.raw`y\in\mathbb{R}`),
        " が ",
        math(String.raw`0<y<1`),
        " を満たすなら ",
        math(String.raw`\log y<0`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "（実対数による ",
        math(String.raw`\mathbb R`),
        " 脱出）",
        math(String.raw`y\in\mathbb{R}`),
        "、",
        math(String.raw`0<y<1`),
        " とする。",
        math(String.raw`0<y`),
        " と ",
        math(String.raw`0<1`),
        " より ",
        math(String.raw`y,1\in\mathbb{R}_{>0}`),
        " であり、",
        ref("def_real_logarithm_positive"),
        " より ",
        math(String.raw`\log y,\log 1\in\mathbb{R}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\log y
&<\log 1
&&\left(\because\ y<1\text{ と }\blkref{real_log_strictly_increasing}\right)\\
&=\log(\exp 0)
&&\left(\because\ \blkref{scalar_exp_zero}\right)\\
&=0
&&\left(\because\ \blkref{def_real_logarithm_positive}\text{ の }\log(\exp x)=x\right)
\end{aligned}`),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-11-02: def_real_logarithm_positive の定義の中に置いていた「0<y<1 なら log y<0」とその証明を、この主張として分けた。log の狭義単調増加の根拠を、新しい主張 real_log_strictly_increasing への参照にした。",
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
&&\left(\because\ \blkref{real_log_negative_below_one}\right)
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
&&\left(\because\ \blkref{real_log_negative_below_one}\right)
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
        " を用いる。この主張では、複素行列の成分に書いた実数 ",
        math(String.raw`a`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の像 ",
        math(String.raw`a_{\mathbb{C}}`),
        " の略記であり、実数 ",
        math(String.raw`a`),
        " と複素行列 ",
        math(String.raw`X`),
        " の積 ",
        math(String.raw`aX`),
        " は ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍 ",
        math(String.raw`a_{\mathbb{C}}X`),
        " の略記である（証明では ",
        math(String.raw`a_{\mathbb{C}}`),
        " と明示して書く）。",
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
        "（",
        ref("indexed_hyperbolic_abbreviations_positive"),
        "）の非負平方根 ",
        math(String.raw`\sqrt{2s_2}^{\,(\mathbb{R}_{\ge 0})}`),
        "（",
        ref("definition_of_sqrt_r_positive"),
        "）、",
        math(String.raw`\sigma^x`),
        " は ",
        ref("def_pauli_matrices"),
        " の Pauli 行列、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        " (1) の行列の exp である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う記号を先に置く。",
        math(String.raw`I := I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "（",
        ref("def_identity_matrix"),
        " で ",
        math(String.raw`n = 2`),
        "）、",
        math(String.raw`\tau \in \mathbb{R}`),
        " とし、",
        math(String.raw`B_\tau := \tau_{\mathbb{C}}\,\sigma^x \in \mathrm{Mat}(2,\mathbb{C})`),
        " とおく。",
        math(String.raw`m \in \mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`b^{(m)} \in \mathrm{Mat}(2,\mathbb{C})`),
        " を、",
        math(String.raw`m`),
        " が偶数なら ",
        math(String.raw`b^{(m)} := I`),
        "、奇数なら ",
        math(String.raw`b^{(m)} := \sigma^x`),
        " と定め、実数 ",
        math(String.raw`\beta^{(m)}_{ij} \in \mathbb{R}\ (i, j \in \{1,2\})`),
        " を",
      ]),
      displayMath(
        String.raw`\beta^{(m)}_{11} = \beta^{(m)}_{22} := \frac{1 + (-1)^m}{2},
\qquad
\beta^{(m)}_{12} = \beta^{(m)}_{21} := \frac{1 - (-1)^m}{2}`,
      ),
      paragraph([
        "と定める。",
        ref("def_pauli_matrices"),
        " の ",
        math(String.raw`\sigma^x`),
        " の成分と、",
        ref("def_identity_matrix"),
        "・",
        ref("def_kronecker_delta"),
        " の ",
        math(String.raw`I_{ij} = \delta_{ij}`),
        " より、",
        math(String.raw`(b^{(m)})_{ij} = \bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}}`),
        " である。4 通りを書き下すと、",
        ref("inclusion_rr_to_cc"),
        " の略記 ",
        math(String.raw`1_{\mathbb{C}} = (1)_{\mathbb{C}}`),
        "、",
        math(String.raw`0_{\mathbb{C}} = (0)_{\mathbb{C}}`),
        " により",
      ]),
      displayMath(
        String.raw`\begin{array}{c|cc}
 & i = j & i \ne j \\ \hline
m\ \text{偶数} & (b^{(m)})_{ij} = I_{ij} = \delta_{ij} = 1_{\mathbb{C}} = (1)_{\mathbb{C}} = \bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}} & (b^{(m)})_{ij} = I_{ij} = \delta_{ij} = 0_{\mathbb{C}} = (0)_{\mathbb{C}} = \bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}} \\
m\ \text{奇数} & (b^{(m)})_{ij} = (\sigma^x)_{ij} = 0_{\mathbb{C}} = (0)_{\mathbb{C}} = \bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}} & (b^{(m)})_{ij} = (\sigma^x)_{ij} = 1_{\mathbb{C}} = (1)_{\mathbb{C}} = \bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}}
\end{array}`,
      ),
      paragraph([
        "である。",
        math(String.raw`x \in \mathbb{R}`),
        " と ",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`E_N(x) := \sum_{m=0}^{N}\frac{x^m}{m!} \in \mathbb{R}`),
        "（",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " の部分和）とおく。さらに ",
        math(String.raw`t := \tanh K_2 \in \mathbb{R}`),
        "、",
        math(String.raw`r := \sqrt{t}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`),
        "、",
        math(String.raw`q := (2s_2)^{1/2} = \sqrt{2s_2}^{\,(\mathbb{R}_{\ge 0})} \in \mathbb{R}_{\ge 0}`),
        " とおく。",
        ref("def_positive_coupling_tanh"),
        " より ",
        math(String.raw`0 < t < 1`),
        "、",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`r^2 = t`),
        "・",
        math(String.raw`q^2 = 2s_2`),
        " である。",
        math(String.raw`r = 0`),
        " なら ",
        math(String.raw`t = r^2 = 0`),
        " となって ",
        math(String.raw`0 < t`),
        " に反するので ",
        math(String.raw`r > 0`),
        " である。",
        ref("def_second_dual_coupling_constant"),
        " より ",
        math(String.raw`K_2^* \in \mathbb{R}_{>0}`),
        " なので ",
        ref("indexed_hyperbolic_abbreviations_positive"),
        " が当てはまり、",
        math(String.raw`s_2 > 0`),
        " から同じく ",
        math(String.raw`q > 0`),
        " である。最後に、",
        math(String.raw`x, y \in \mathbb{R}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x_{\mathbb{C}} - y_{\mathbb{C}}
&= x_{\mathbb{C}} + \bigl(-y_{\mathbb{C}}\bigr)
&&(\because \blkref{def_complex_difference}) \\
&= x_{\mathbb{C}} + (-1_{\mathbb{C}})\,y_{\mathbb{C}}
&&(\because \blkref{multiply_by_minus_one}) \\
&= x_{\mathbb{C}} + (-1)_{\mathbb{C}}\,y_{\mathbb{C}}
&&(\because \blkref{inclusion_rr_to_cc}\ \text{の}\ -1_{\mathbb{C}} = \iota_{\mathbb{R}\to\mathbb{C}}(-1) = (-1)_{\mathbb{C}}) \\
&= x_{\mathbb{C}} + \bigl((-1)\,y\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \bigl(x + (-1)\,y\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}\ \text{を 2 項へ当てた}) \\
&= (x - y)_{\mathbb{C}}
&&(\because \text{実数の四則})
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph([
        "中間目標: ",
        math(String.raw`B_\tau`),
        " の冪 ",
        math(String.raw`B_\tau^{\,m} = (\tau^m)_{\mathbb{C}}\,b^{(m)}`),
        "。",
        math(String.raw`p \in \mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`B_\tau^{\,2p} = (\tau^{2p})_{\mathbb{C}}\,I`),
        " かつ ",
        math(String.raw`B_\tau^{\,2p+1} = (\tau^{2p+1})_{\mathbb{C}}\,\sigma^x`),
        " を ",
        math(String.raw`p`),
        " の帰納法で示す。冪は ",
        ref("def_exp"),
        " (1) の ",
        math(String.raw`A^0 := I,\ A^{m+1} := A^m A`),
        " である。",
        math(String.raw`p = 0`),
        " の偶数の冪は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B_\tau^{\,0}
&= I
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^0 := I) \\
&= 1_{\mathbb{C}}\,I
&&(\because \blkref{scalar_multiple_by_one}) \\
&= (\tau^{0})_{\mathbb{C}}\,I
&&(\because \tau^0 = 1)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`B_\tau^{\,2p} = (\tau^{2p})_{\mathbb{C}}\,I`),
        " を仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
B_\tau^{\,2p+1}
&= B_\tau^{\,2p}\,B_\tau
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^m A) \\
&= \bigl((\tau^{2p})_{\mathbb{C}}\,I\bigr)\,B_\tau
&&(\because \text{帰納法の仮定}) \\
&= \bigl((\tau^{2p})_{\mathbb{C}}\,I\bigr)\bigl(\tau_{\mathbb{C}}\,\sigma^x\bigr)
&&(\because B_\tau\ \text{の定義}) \\
&= (\tau^{2p})_{\mathbb{C}}\bigl(I\,(\tau_{\mathbb{C}}\,\sigma^x)\bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= (\tau^{2p})_{\mathbb{C}}\bigl(\tau_{\mathbb{C}}\,\sigma^x\bigr)
&&(\because \blkref{identity_matrix_is_left_unit_of_mat_mult}) \\
&= \bigl((\tau^{2p})_{\mathbb{C}}\,\tau_{\mathbb{C}}\bigr)\sigma^x
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= (\tau^{2p}\,\tau)_{\mathbb{C}}\,\sigma^x
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= (\tau^{2p+1})_{\mathbb{C}}\,\sigma^x
&&(\because \text{実数の冪}\ \tau^{k}\tau = \tau^{k+1})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
B_\tau^{\,2p+2}
&= B_\tau^{\,2p+1}\,B_\tau
&&(\because \blkref{def_exp}\ (1)\ \text{の}\ A^{m+1} := A^m A) \\
&= \bigl((\tau^{2p+1})_{\mathbb{C}}\,\sigma^x\bigr)\,B_\tau
&&(\because \text{直前の式}) \\
&= \bigl((\tau^{2p+1})_{\mathbb{C}}\,\sigma^x\bigr)\bigl(\tau_{\mathbb{C}}\,\sigma^x\bigr)
&&(\because B_\tau\ \text{の定義}) \\
&= (\tau^{2p+1})_{\mathbb{C}}\bigl(\sigma^x\,(\tau_{\mathbb{C}}\,\sigma^x)\bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_left_factor}) \\
&= (\tau^{2p+1})_{\mathbb{C}}\bigl(\tau_{\mathbb{C}}\,(\sigma^x\sigma^x)\bigr)
&&(\because \blkref{scalar_multiple_factors_out_of_right_factor}) \\
&= (\tau^{2p+1})_{\mathbb{C}}\bigl(\tau_{\mathbb{C}}\,I\bigr)
&&(\because \blkref{pauli_matrix_products}\ \text{の}\ \sigma^x\sigma^x = I) \\
&= \bigl((\tau^{2p+1})_{\mathbb{C}}\,\tau_{\mathbb{C}}\bigr)I
&&(\because \blkref{scalar_multiple_is_associative}) \\
&= (\tau^{2p+1}\,\tau)_{\mathbb{C}}\,I
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= (\tau^{2p+2})_{\mathbb{C}}\,I
&&(\because \text{実数の冪}\ \tau^{k}\tau = \tau^{k+1})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`p`),
        " での二つの等式が ",
        math(String.raw`p`),
        " の奇数の冪と ",
        math(String.raw`p+1`),
        " の偶数の冪の等式を与える。",
        math(String.raw`b^{(m)}`),
        " の定義により、これは ",
        math(String.raw`B_\tau^{\,m} = (\tau^m)_{\mathbb{C}}\,b^{(m)}\ (m \in \mathbb{Z}_{\ge 0})`),
        " である。",
      ]),
      paragraph([
        "中間目標: 指数級数の各項の成分。",
        math(String.raw`m \in \mathbb{Z}_{\ge 0}`),
        "、",
        math(String.raw`i, j \in \{1,2\}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\tfrac{1}{m!}\,B_\tau^{\,m}\Bigr)_{ij}
&= \Bigl(\tfrac{1}{m!}\Bigr)_{\mathbb{C}}\bigl(B_\tau^{\,m}\bigr)_{ij}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \Bigl(\tfrac{1}{m!}\Bigr)_{\mathbb{C}}\bigl((\tau^{m})_{\mathbb{C}}\,b^{(m)}\bigr)_{ij}
&&(\because \text{冪の中間目標}) \\
&= \Bigl(\tfrac{1}{m!}\Bigr)_{\mathbb{C}}\Bigl((\tau^{m})_{\mathbb{C}}\,\bigl(b^{(m)}\bigr)_{ij}\Bigr)
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \Bigl(\tfrac{1}{m!}\Bigr)_{\mathbb{C}}\Bigl((\tau^{m})_{\mathbb{C}}\,\bigl(\beta^{(m)}_{ij}\bigr)_{\mathbb{C}}\Bigr)
&&(\because (b^{(m)})_{ij} = (\beta^{(m)}_{ij})_{\mathbb{C}}) \\
&= \Bigl(\tfrac{1}{m!}\Bigr)_{\mathbb{C}}\bigl(\tau^{m}\,\beta^{(m)}_{ij}\bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product}) \\
&= \Bigl(\tfrac{1}{m!}\,\tau^{m}\,\beta^{(m)}_{ij}\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_product})
\end{aligned}`,
      ),
      paragraph(["であり、その実数は"]),
      displayMath(
        String.raw`\begin{aligned}
\tfrac{1}{m!}\,\tau^{m}\,\beta^{(m)}_{11}
&= \tfrac{1}{m!}\,\tau^{m}\,\frac{1 + (-1)^m}{2}
&&(\because \beta^{(m)}_{11}\ \text{の定義}) \\
&= \frac{\tau^m + (-1)^m\tau^m}{2\cdot m!}
&&(\because \text{実数の分配則}) \\
&= \frac{\tau^m + (-\tau)^m}{2\cdot m!}
&&(\because \text{実数の冪}\ (-1)^m\tau^m = (-\tau)^m),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\tfrac{1}{m!}\,\tau^{m}\,\beta^{(m)}_{12}
&= \tfrac{1}{m!}\,\tau^{m}\,\frac{1 - (-1)^m}{2}
&&(\because \beta^{(m)}_{12}\ \text{の定義}) \\
&= \frac{\tau^m - (-1)^m\tau^m}{2\cdot m!}
&&(\because \text{実数の分配則}) \\
&= \frac{\tau^m - (-\tau)^m}{2\cdot m!}
&&(\because \text{実数の冪}\ (-1)^m\tau^m = (-\tau)^m)
\end{aligned}`,
      ),
      paragraph([
        "である（",
        math(String.raw`\beta^{(m)}_{22} = \beta^{(m)}_{11}`),
        "、",
        math(String.raw`\beta^{(m)}_{21} = \beta^{(m)}_{12}`),
        "）。",
      ]),
      paragraph([
        "中間目標: 部分和の成分。",
        math(String.raw`N \in \mathbb{Z}_{\ge 0}`),
        " について ",
        math(String.raw`S_N := \sum_{m=0}^{N}\frac{1}{m!}B_\tau^{\,m} \in \mathrm{Mat}(2,\mathbb{C})`),
        " とおく。",
        math(String.raw`(i,j) = (1,1), (2,2)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S_N)_{ij}
&= \sum_{m=0}^{N}\Bigl(\tfrac{1}{m!}\,B_\tau^{\,m}\Bigr)_{ij}
&&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=0}^{N}\Bigl(\frac{\tau^m + (-\tau)^m}{2\cdot m!}\Bigr)_{\mathbb{C}}
&&(\because \text{各項の成分の中間目標}) \\
&= \Bigl(\sum_{m=0}^{N}\frac{\tau^m + (-\tau)^m}{2\cdot m!}\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \Bigl(\frac{1}{2}\Bigl(\sum_{m=0}^{N}\frac{\tau^m}{m!} + \sum_{m=0}^{N}\frac{(-\tau)^m}{m!}\Bigr)\Bigr)_{\mathbb{C}}
&&(\because \text{実数の有限和の分配則}) \\
&= \Bigl(\frac{E_N(\tau) + E_N(-\tau)}{2}\Bigr)_{\mathbb{C}}
&&(\because E_N\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`(i,j) = (1,2), (2,1)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(S_N)_{ij}
&= \sum_{m=0}^{N}\Bigl(\tfrac{1}{m!}\,B_\tau^{\,m}\Bigr)_{ij}
&&(\because \blkref{finite_sum_of_matrices_entrywise}) \\
&= \sum_{m=0}^{N}\Bigl(\frac{\tau^m - (-\tau)^m}{2\cdot m!}\Bigr)_{\mathbb{C}}
&&(\because \text{各項の成分の中間目標}) \\
&= \Bigl(\sum_{m=0}^{N}\frac{\tau^m - (-\tau)^m}{2\cdot m!}\Bigr)_{\mathbb{C}}
&&(\because \blkref{real_inclusion_preserves_finite_sum}) \\
&= \Bigl(\frac{1}{2}\Bigl(\sum_{m=0}^{N}\frac{\tau^m}{m!} - \sum_{m=0}^{N}\frac{(-\tau)^m}{m!}\Bigr)\Bigr)_{\mathbb{C}}
&&(\because \text{実数の有限和の分配則}) \\
&= \Bigl(\frac{E_N(\tau) - E_N(-\tau)}{2}\Bigr)_{\mathbb{C}}
&&(\because E_N\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "中間目標: 部分和の成分の極限。",
        math(String.raw`u_N := \bigl|E_N(\tau) - \exp(\tau)\bigr|`),
        "、",
        math(String.raw`v_N := \bigl|E_N(-\tau) - \exp(-\tau)\bigr|`),
        " とおく（",
        math(String.raw`\mathbb{R}`),
        " の絶対値）。",
        math(String.raw`(i,j) = (1,1), (2,2)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl|(S_N)_{ij} - (\cosh\tau)_{\mathbb{C}}\bigr|
&= \Bigl|\Bigl(\frac{E_N(\tau) + E_N(-\tau)}{2}\Bigr)_{\mathbb{C}} - (\cosh\tau)_{\mathbb{C}}\Bigr|
&&(\because \text{部分和の成分の中間目標}) \\
&= \Bigl|\Bigl(\frac{E_N(\tau) + E_N(-\tau)}{2} - \cosh\tau\Bigr)_{\mathbb{C}}\Bigr|
&&(\because \text{準備の}\ x_{\mathbb{C}} - y_{\mathbb{C}} = (x - y)_{\mathbb{C}}) \\
&= \Bigl|\frac{E_N(\tau) + E_N(-\tau)}{2} - \cosh\tau\Bigr|
&&(\because \blkref{abs_basic_properties}\ (6)) \\
&= \Bigl|\frac{E_N(\tau) + E_N(-\tau)}{2} - \frac{\exp(\tau) + \exp(-\tau)}{2}\Bigr|
&&(\because \blkref{def_cosh_sinh}) \\
&= \Bigl|\frac{\bigl(E_N(\tau) - \exp(\tau)\bigr) + \bigl(E_N(-\tau) - \exp(-\tau)\bigr)}{2}\Bigr|
&&(\because \text{実数の四則}) \\
&\le \frac{u_N + v_N}{2}
&&(\because \text{実数の絶対値の三角不等式})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`(i,j) = (1,2), (2,1)`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\bigl|(S_N)_{ij} - (\sinh\tau)_{\mathbb{C}}\bigr|
&= \Bigl|\Bigl(\frac{E_N(\tau) - E_N(-\tau)}{2}\Bigr)_{\mathbb{C}} - (\sinh\tau)_{\mathbb{C}}\Bigr|
&&(\because \text{部分和の成分の中間目標}) \\
&= \Bigl|\Bigl(\frac{E_N(\tau) - E_N(-\tau)}{2} - \sinh\tau\Bigr)_{\mathbb{C}}\Bigr|
&&(\because \text{準備の}\ x_{\mathbb{C}} - y_{\mathbb{C}} = (x - y)_{\mathbb{C}}) \\
&= \Bigl|\frac{E_N(\tau) - E_N(-\tau)}{2} - \sinh\tau\Bigr|
&&(\because \blkref{abs_basic_properties}\ (6)) \\
&= \Bigl|\frac{E_N(\tau) - E_N(-\tau)}{2} - \frac{\exp(\tau) - \exp(-\tau)}{2}\Bigr|
&&(\because \blkref{def_cosh_sinh}) \\
&= \Bigl|\frac{\bigl(E_N(\tau) - \exp(\tau)\bigr) - \bigl(E_N(-\tau) - \exp(-\tau)\bigr)}{2}\Bigr|
&&(\because \text{実数の四則}) \\
&\le \frac{u_N + v_N}{2}
&&(\because \text{実数の絶対値の三角不等式})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("scalar_exp_is_limit_of_partial_sums"),
        " を ",
        math(String.raw`K = \mathbb{R}`),
        "、",
        math(String.raw`x = \tau`),
        " と ",
        math(String.raw`x = -\tau`),
        " へ当てると、",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`K`),
        " の列の収束の意味で ",
        math(String.raw`u_N \to 0`),
        "、",
        math(String.raw`v_N \to 0`),
        " である。",
        math(String.raw`\varepsilon \in \mathbb{R}_{>0}`),
        " に対し、",
        math(String.raw`N \ge N_1`),
        " で ",
        math(String.raw`u_N < \varepsilon`),
        "、",
        math(String.raw`N \ge N_2`),
        " で ",
        math(String.raw`v_N < \varepsilon`),
        " となる ",
        math(String.raw`N_1, N_2 \in \mathbb{Z}_{\ge 0}`),
        " を取ると、",
        math(String.raw`N \ge \max(N_1, N_2)`),
        " で ",
        math(String.raw`(u_N + v_N)/2 < \varepsilon`),
        " である。よって ",
        ref("def_matrix_norm"),
        " の ",
        math(String.raw`\mathbb{C}`),
        " の列の収束の意味で ",
        math(String.raw`(S_N)_{ij} \to (\cosh\tau)_{\mathbb{C}}\ ((i,j) = (1,1),(2,2))`),
        "、",
        math(String.raw`(S_N)_{ij} \to (\sinh\tau)_{\mathbb{C}}\ ((i,j) = (1,2),(2,1))`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " への脱出: 極限）。一方 ",
        ref("exp_converges"),
        " (1b) より ",
        math(String.raw`(S_N)_{ij} \to \bigl(\exp(B_\tau)\bigr)_{ij}`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(\tau\sigma^x)
&= \exp(B_\tau)
&&(\because \text{主張の記法の約束と}\ B_\tau\ \text{の定義}) \\
&= \begin{pmatrix} (\cosh\tau)_{\mathbb{C}} & (\sinh\tau)_{\mathbb{C}} \\ (\sinh\tau)_{\mathbb{C}} & (\cosh\tau)_{\mathbb{C}} \end{pmatrix}
&&(\because \text{四つの成分へ}\ \blkref{scalar_limit_is_unique}\ \text{を同時適用。行列は成分で定まる})
\end{aligned}`,
      ),
      paragraph([
        "である。",
        math(String.raw`\tau = K_2^*`),
        " として",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(2s_2)^{1/2}\exp\!\left(K_2^*\sigma^x\right)
&= q_{\mathbb{C}}\,\exp\!\left(B_{K_2^*}\right)
&&(\because q\ \text{の定義と主張の記法の約束}) \\
&= q_{\mathbb{C}}\begin{pmatrix} (\cosh K_2^*)_{\mathbb{C}} & (\sinh K_2^*)_{\mathbb{C}} \\ (\sinh K_2^*)_{\mathbb{C}} & (\cosh K_2^*)_{\mathbb{C}} \end{pmatrix}
&&(\because \text{直前の式に}\ \tau = K_2^*\ \text{を代入}) \\
&= \begin{pmatrix} q_{\mathbb{C}}(\cosh K_2^*)_{\mathbb{C}} & q_{\mathbb{C}}(\sinh K_2^*)_{\mathbb{C}} \\ q_{\mathbb{C}}(\sinh K_2^*)_{\mathbb{C}} & q_{\mathbb{C}}(\cosh K_2^*)_{\mathbb{C}} \end{pmatrix}
&&(\because \blkref{def_matrix_scalar_multiple}) \\
&= \begin{pmatrix} (q\cosh K_2^*)_{\mathbb{C}} & (q\sinh K_2^*)_{\mathbb{C}} \\ (q\sinh K_2^*)_{\mathbb{C}} & (q\cosh K_2^*)_{\mathbb{C}} \end{pmatrix}
&&(\because \blkref{real_inclusion_preserves_product})
\end{aligned}`,
      ),
      paragraph([
        "である。以下で次の 2 つの実数の等式を示す。",
      ]),
      displayMath(
        String.raw`q\cosh K_2^* = \exp(K_2), \qquad
q\sinh K_2^* = \exp(-K_2)`,
      ),
      paragraph([
        "中間目標: ",
        math(String.raw`\exp(\pm K_2^*)`),
        " を ",
        math(String.raw`r`),
        " で書く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-2K_2^*)
&= \exp\!\Bigl(-2\cdot\bigl(-\tfrac{1}{2}\log(\tanh K_2)\bigr)\Bigr)
&&(\because \blkref{def_second_dual_coupling_constant}) \\
&= \exp\!\Bigl(-2\cdot\bigl(-\tfrac{1}{2}\log t\bigr)\Bigr)
&&(\because t\ \text{の定義}) \\
&= \exp(\log t)
&&(\because -2\cdot\bigl(-\tfrac{1}{2}\bigr) = 1) \\
&= t
&&(\because \blkref{def_real_logarithm_positive}\ \text{の}\ \exp(\log y) = y)
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\bigl(\exp(-K_2^*)\bigr)^2
&= \exp(-K_2^*)\exp(-K_2^*)
&&(\because \text{実数の二乗}) \\
&= \exp(-2K_2^*)
&&(\because \blkref{scalar_exp_product}) \\
&= t
&&(\because \text{直前の式})
\end{aligned}`,
      ),
      paragraph([
        ref("real_exp_positive"),
        " より ",
        math(String.raw`\exp(-K_2^*) \in \mathbb{R}_{\ge 0}`),
        " であり、その二乗は ",
        math(String.raw`t`),
        " なので、",
        ref("sqrt_nonnegative_existence_uniqueness"),
        " の一意性と ",
        ref("definition_of_sqrt_r_positive"),
        " より ",
        math(String.raw`\exp(-K_2^*) = r`),
        " である。また",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(K_2^*)\,r
&= \exp(K_2^*)\exp(-K_2^*)
&&(\because \exp(-K_2^*) = r) \\
&= \exp(0)
&&(\because \blkref{scalar_exp_product}) \\
&= 1
&&(\because \blkref{scalar_exp_zero})
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`r > 0`),
        " なので ",
        math(String.raw`\exp(K_2^*) = 1/r`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\cosh K_2^*
&= \frac{\exp(K_2^*) + \exp(-K_2^*)}{2}
&&(\because \blkref{def_cosh_sinh}) \\
&= \frac{1/r + r}{2}
&&(\because \exp(K_2^*) = 1/r,\ \exp(-K_2^*) = r\ \text{を同時に代入}) \\
&= \frac{1 + r^2}{2r}
&&(\because \text{分子・分母に}\ r\ \text{を掛ける}) \\
&= \frac{1 + t}{2r}
&&(\because r^2 = t),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sinh K_2^*
&= \frac{\exp(K_2^*) - \exp(-K_2^*)}{2}
&&(\because \blkref{def_cosh_sinh}) \\
&= \frac{1/r - r}{2}
&&(\because \exp(K_2^*) = 1/r,\ \exp(-K_2^*) = r\ \text{を同時に代入}) \\
&= \frac{1 - r^2}{2r}
&&(\because \text{分子・分母に}\ r\ \text{を掛ける}) \\
&= \frac{1 - t}{2r}
&&(\because r^2 = t)
\end{aligned}`,
      ),
      paragraph([
        "である。",
        ref("cosh_sinh_basic_properties"),
        " (3) より ",
        math(String.raw`\cosh K_2 > 0`),
        "、",
        math(String.raw`\sinh K_2 > 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
1 + t
&= 1 + \frac{\sinh K_2}{\cosh K_2}
&&(\because \blkref{def_positive_coupling_tanh}) \\
&= \frac{\cosh K_2 + \sinh K_2}{\cosh K_2}
&&(\because \text{通分}) \\
&= \frac{\exp(K_2)}{\cosh K_2}
&&(\because \blkref{cosh_sinh_basic_properties}\ (1)),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
1 - t
&= 1 - \frac{\sinh K_2}{\cosh K_2}
&&(\because \blkref{def_positive_coupling_tanh}) \\
&= \frac{\cosh K_2 - \sinh K_2}{\cosh K_2}
&&(\because \text{通分}) \\
&= \frac{\exp(-K_2)}{\cosh K_2}
&&(\because \blkref{cosh_sinh_basic_properties}\ (1))
\end{aligned}`,
      ),
      paragraph(["である。"]),
      paragraph([
        "中間目標: 前因子 ",
        math(String.raw`q/(2r) = \cosh K_2`),
        "。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Bigl(\frac{q}{2r}\Bigr)^2
&= \frac{q^2}{4r^2}
&&(\because \text{分数の二乗}) \\
&= \frac{2s_2}{4r^2}
&&(\because q^2 = 2s_2) \\
&= \frac{2s_2}{4t}
&&(\because r^2 = t) \\
&= \frac{2\sinh 2K_2}{4t}
&&(\because \blkref{def_indexed_hyperbolic_abbreviations}\ \text{の}\ s_2 = \sinh 2K_2) \\
&= \frac{2\cdot 2\sinh\bigl(\tfrac{2K_2}{2}\bigr)\cosh\bigl(\tfrac{2K_2}{2}\bigr)}{4t}
&&(\because \blkref{sinh_double_angle_formula}\ \text{を}\ x = 2K_2\ \text{へ当てた}) \\
&= \frac{2\cdot 2\sinh K_2\cosh K_2}{4t}
&&(\because \tfrac{2K_2}{2} = K_2) \\
&= \frac{\sinh K_2\cosh K_2}{t}
&&(\because 2\cdot 2 = 4\ \text{で約分}) \\
&= \sinh K_2\cosh K_2\cdot\frac{\cosh K_2}{\sinh K_2}
&&(\because \blkref{def_positive_coupling_tanh}\ \text{の}\ t = \tfrac{\sinh K_2}{\cosh K_2}) \\
&= (\cosh K_2)^2
&&(\because \sinh K_2 \ne 0\ \text{で約分})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`q > 0`),
        "、",
        math(String.raw`r > 0`),
        " より ",
        math(String.raw`q/(2r) > 0`),
        "、また ",
        math(String.raw`\cosh K_2 > 0`),
        " なので、",
        ref("cosh_sinh_basic_properties"),
        " (4) より ",
        math(String.raw`q/(2r) = \cosh K_2`),
        " である。",
      ]),
      paragraph(["中間目標: 示すべき 2 つの等式。"]),
      displayMath(
        String.raw`\begin{aligned}
q\cosh K_2^*
&= q\,\frac{1+t}{2r}
&&(\because \cosh K_2^* = \tfrac{1+t}{2r}) \\
&= \frac{q}{2r}\,(1+t)
&&(\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1+t)
&&(\because \tfrac{q}{2r} = \cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(K_2)}{\cosh K_2}
&&(\because 1+t = \tfrac{\exp(K_2)}{\cosh K_2}) \\
&= \exp(K_2)
&&(\because \cosh K_2 \ne 0\ \text{で約分}),
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
q\sinh K_2^*
&= q\,\frac{1-t}{2r}
&&(\because \sinh K_2^* = \tfrac{1-t}{2r}) \\
&= \frac{q}{2r}\,(1-t)
&&(\because \text{積の並べ替え}) \\
&= \cosh K_2 \cdot (1-t)
&&(\because \tfrac{q}{2r} = \cosh K_2) \\
&= \cosh K_2 \cdot \frac{\exp(-K_2)}{\cosh K_2}
&&(\because 1-t = \tfrac{\exp(-K_2)}{\cosh K_2}) \\
&= \exp(-K_2)
&&(\because \cosh K_2 \ne 0\ \text{で約分})
\end{aligned}`,
      ),
      paragraph(["中間目標: 結論。"]),
      displayMath(
        String.raw`\begin{aligned}
A
&= \begin{pmatrix} (\exp K_2)_{\mathbb{C}} & (\exp(-K_2))_{\mathbb{C}} \\ (\exp(-K_2))_{\mathbb{C}} & (\exp K_2)_{\mathbb{C}} \end{pmatrix}
&&(\because A\ \text{の定義と主張の記法の約束}) \\
&= \begin{pmatrix} (q\cosh K_2^*)_{\mathbb{C}} & (q\sinh K_2^*)_{\mathbb{C}} \\ (q\sinh K_2^*)_{\mathbb{C}} & (q\cosh K_2^*)_{\mathbb{C}} \end{pmatrix}
&&(\because \text{示すべき 2 つの等式を四つの成分へ同時に代入}) \\
&= (2s_2)^{1/2}\exp\!\left(K_2^*\sigma^x\right)
&&(\because \text{上で求めた}\ (2s_2)^{1/2}\exp(K_2^*\sigma^x)\ \text{の成分})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。分配関数の転送行列の章から転送行列の章へ移し、K_2^* と s_2 の参照先を <def_second_dual_coupling_constant> と <def_indexed_hyperbolic_abbreviations> にした。番号で区切っていた四つの段を中間目標の名前へ変えた。",
        "2026-11-02: SageMath の検算を付けるときに証明を書き直した。倍角公式とテイラー展開の根拠が cosh_sinh_basic_properties を引いていた（そこには無い）。倍角公式は sinh_double_angle_formula へ付け替え、テイラー展開（本文の sinh_cosh_taylor_series には証明が無い）には頼らず、部分和の成分を 1 行 1 列の exp の部分和の半和 (E_N(τ)±E_N(-τ))/2 で書き、scalar_exp_is_limit_of_partial_sums と三角不等式で極限を取る形にした。行列の冪の指数法則・加法則（本文に無い）を def_exp (1) の冪の定義による一つの帰納法に、非負実数の平方根が積を保つこと（本文に無い）を二乗の比較（cosh_sinh_basic_properties (4)）に置き換えた。閉じた形の変数と tanh K_2 が同じ記号 t だったので、閉じた形の変数を τ にした。実数のスカラー倍と行列の実数の成分を a_C の略記として主張に書き、証明では a_C と明示した。",
        "2026-11-13（Lean の通しの証明のゴールラインの確認）: 主張の文で σ^x を引く出典と、証明で σ^x の成分を引く段落の出典を、pauli_matrix_products（Pauli 行列の積の主張）から Pauli 行列の定義 def_pauli_matrices に替えた（Pauli 行列の定義を主張から分けたため）。σ^xσ^x = I を引く行（積の公式）は替えていない。証明の記号を置く段落に、出典の無かった I を I := I_{Mat(2,C)}（def_identity_matrix で n = 2）として足した。式は不変。",
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
        " で成分級数として定めた行列の指数関数である。実数 ",
        math(String.raw`a`),
        " と行列 ",
        math(String.raw`X`),
        " の積 ",
        math(String.raw`aX`),
        " は、",
        ref("inclusion_rr_to_cc"),
        " の ",
        math(String.raw`a_{\mathbb{C}}`),
        " による ",
        ref("def_matrix_scalar_multiple"),
        " のスカラー倍 ",
        math(String.raw`a_{\mathbb{C}}X`),
        " の略記である（証明でも略記で書き、包含を式の外へ出す行だけ ",
        math(String.raw`a_{\mathbb{C}}`),
        " と明示して書く）。",
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
&= \left(\exp\!\left(K_2\sum_{m=1}^{M_{\mathrm{col}}} \mu(m)\mu'(m)\right)\right)_{\mathbb{C}}
   &&(\because \blkref{def_transfer_matrix}) \\
&= \left(\exp\!\left(\sum_{m=1}^{M_{\mathrm{col}}} K_2\,\bigl(\mu(m)\mu'(m)\bigr)\right)\right)_{\mathbb{C}}
   &&(\because \mathbb{R}\text{ の分配則}) \\
&= \left(\prod_{m=1}^{M_{\mathrm{col}}}\exp\!\left(K_2\,\bigl(\mu(m)\mu'(m)\bigr)\right)\right)_{\mathbb{C}}
   &&(\because \blkref{theorem_exp_product}\text{ を }n=1,\ K=\mathbb{R}\text{ で有限和へ繰り返し適用}) \\
&= \prod_{m=1}^{M_{\mathrm{col}}}\left(\exp\!\left(K_2\,\bigl(\mu(m)\mu'(m)\bigr)\right)\right)_{\mathbb{C}}
   &&(\because \blkref{real_inclusion_preserves_finite_product}\ (m \to M_{\mathrm{col}}\text{、}r_m \to \exp(K_2(\mu(m)\mu'(m))))) \\
&= \prod_{m=1}^{M_{\mathrm{col}}} A_{i_m j_m}
   &&(\because A\text{ の成分（}\blkref{two_by_two_transfer_identity}\text{ の略記で }A_{ij}=(\exp(K_2\varsigma_i\varsigma_j))_{\mathbb{C}}\text{）と }\varsigma_{i_m}=\mu(m),\ \varsigma_{j_m}=\mu'(m)\text{ を全因子へ同時適用}) \\
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
&= \left(\bigl((2s_2)^{1/2}\bigr)_{\mathbb{C}}\right)^{M_{\mathrm{col}}}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{kronecker_multilinear}\text{ で各因子のスカラー }\bigl((2s_2)^{1/2}\bigr)_{\mathbb{C}}\text{ を前へ出す}) \\
&= \left(\bigl((2s_2)^{1/2}\bigr)^{M_{\mathrm{col}}}\right)_{\mathbb{C}}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because \blkref{real_inclusion_preserves_power}\ (r \to (2s_2)^{1/2},\ m \to M_{\mathrm{col}})\text{ を右辺から左辺へ}) \\
&= \left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\right)_{\mathbb{C}}
  \underbrace{\exp(K_2^*\sigma^x) \boxtimes \cdots \boxtimes \exp(K_2^*\sigma^x)}_{M_{\mathrm{col}}}
   &&(\because s_2=\sinh 2K_2\text{ と }\blkref{def_second_transfer_matrix_prefactor}) \\
&= \left((2\sinh 2K_2)^{M_{\mathrm{col}}/2}\right)_{\mathbb{C}}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
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
        "2026-11-09（Lean の通しの証明のゴールラインの確認）: 実数の値の包含の段を、一ステップ一定理で式に出した。「V_2 を A のクロネッカー冪で書く」の鎖は、def_transfer_matrix の成分を (exp(…))_ℂ と書き、theorem_exp_product の行のあとに real_inclusion_preserves_finite_product（m → M_col）の 1 行を足した。A の成分は two_by_two_transfer_identity の略記で (exp(K_2ς_iς_j))_ℂ と読むので、包含を因子ごとに出した行から A の成分の行へ直接進む（K_2μ(m)μ'(m) は K_2(μ(m)μ'(m)) と括弧を明示した）。「結論」の鎖は、スカラー ((2s_2)^{1/2})_ℂ を前へ出した行のあとに real_inclusion_preserves_power（r → (2s_2)^{1/2}、m → M_col）の行を足し、前係数を ((2 sinh 2K_2)^{M_col/2})_ℂ と書いた。主張の実数と行列の積 aX は a_ℂX の略記であること（証明でも略記で書き、包含を式の外へ出す行だけ a_ℂ と明示すること）を主張の本文に書いた。Lean は Complex.ofReal_prod・Complex.ofReal_pow・push_cast をやめ、具体版 real_inclusion_preserves_finite_product（M_col = 0 も含む版）・real_inclusion_of_power を同じ行の単位で引き、A の成分の略記の読み方を補題 twoByTwo_apply_eq_real_inclusion（real_inclusion_mul・Complex.ofReal_exp）で置く。",
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
        String.raw`\bigl(Z(K_1, K_2)\bigr)_{\mathbb{C}} = \mathrm{tr}\!\left(\left(
  \exp\!\left(K_1 \sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^z\sigma_{m+1}^z\right)
  (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
\right)^{N_{\mathrm{row}}}\right)`,
      ),
      paragraph([
        "が成り立つ。ここに現れる ",
        math(String.raw`\exp`),
        " は、",
        ref("def_exp"),
        " で成分級数として定めた行列の指数関数、",
        math(String.raw`r_{\mathbb{C}}`),
        " は ",
        ref("inclusion_rr_to_cc"),
        " の略記である。",
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
\bigl(Z(K_1, K_2)\bigr)_{\mathbb{C}}
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
        "2026-11-06（Lean の通しの証明のゴールラインの確認）: partition_function_via_transfer_matrix の左辺を (Z(K_1,K_2))_ℂ と書き直したのに合わせ、主張と鎖の左辺を (Z(K_1,K_2))_ℂ にした。",
      ],
    },
  },
]);
