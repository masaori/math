/**
 * 本文（章は見出しブロックで区切る）。
 *
 * 章「分配多項式」: 有限格子の分配関数を、指数関数を経由せず整係数多項式として定義する。
 * 章「有限系の自由エントロピー」: 有理点での値の素因数分解として Φ_L(q) ∈ Λ を定める。
 * 章「転送行列」: 行配位を定め、破れボンド数を行内・行間へ分解し、転送行列 T を定義して、
 * 配位の重みが行に沿った成分の積であること・行列の冪の成分が道に沿った積の和であること・
 * Z_L = Tr(T^L) を示す。
 * 章「固有値の代数性」: 行配位の集合の線形順序と、その上の置換の符号を用意し、行列式を
 * 置換にわたる和として定義する（特性多項式そのものは未着手）。
 * どの章にも ℝ/ℂ は現れない。
 *
 * 文書順はこの配列の並びが正本である（README「章立ての予定」の表が読む順序の正本）。
 * 本文を 1 ファイルに置いているのは、システムが content/ のファイル名昇順を文書順とみなす一方、
 * リポジトリの規約がファイル名の連番を禁じているためである（分ける方法は未決。MEMORY.md 参照）。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref, todo } from "../schema.ts";

export default defineBlocks([
  {
    id: "partition_polynomial_heading",
    kind: "heading",
    level: 1,
    title: { text: "分配多項式" },
    labels: [],
  },

  {
    id: "partition_polynomial_definition_lattice_and_configuration",
    kind: "definition",
    title: { text: "格子" },
    labels: ["def_lattice"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.Vertex",
      "Ising2DLambda.PartitionPolynomial.Edge",
      "Ising2DLambda.PartitionPolynomial.boundary0",
      "Ising2DLambda.PartitionPolynomial.boundary1",
      "Ising2DLambda.PartitionPolynomial.Config",
      "Ising2DLambda.PartitionPolynomial.card_config",
    ],
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`L\ge1`),
        " を固定する。格子とは、頂点集合",
      ]),
      displayMath(String.raw`V_L:=(\mathbb{Z}/L\mathbb{Z})\times(\mathbb{Z}/L\mathbb{Z})`),
      paragraph([
        "の元を ",
        math(String.raw`(i,j)`),
        " と書き、第 1 成分 ",
        math(String.raw`i`),
        " を行番号、第 2 成分 ",
        math(String.raw`j`),
        " を列番号と呼ぶ。すなわち行番号が等しい頂点どうしが同じ行に属する。この呼び方は以下で固定し、",
        "第 1 成分を列番号と読むことはしない。",
      ]),
      paragraph([
        "次に、横向きの辺の番号の集合・縦向きの辺の番号の集合",
      ]),
      displayMath(
        String.raw`E_{L,\mathrm{h}}:=\{1,2,\dots,L^2\},\qquad
E_{L,\mathrm{v}}:=\{L^2+1,\,L^2+2,\dots,2L^2\}`,
      ),
      paragraph([
        "および、その合併",
      ]),
      displayMath(String.raw`E_L:=E_{L,\mathrm{h}}\cup E_{L,\mathrm{v}}=\{1,2,\dots,2L^2\}`),
      paragraph([
        "と、各番号に 2 つの頂点（その辺の両端）を割り当てる写像 ",
        math(String.raw`\partial_0,\partial_1:E_L\to V_L`),
        " の 5 つ組 ",
        math(String.raw`(V_L,E_{L,\mathrm{h}},E_{L,\mathrm{v}},\partial_0,\partial_1)`),
        " のことである。",
        math(String.raw`E_{L,\mathrm{h}}`),
        " と ",
        math(String.raw`E_{L,\mathrm{v}}`),
        " は番号の範囲が重ならないので互いに素であり、どの ",
        math(String.raw`e\in E_L`),
        " もちょうど一方に属する。",
      ]),
      paragraph([
        "横向きと縦向きを最初から別の集合にしておくのは、後の章で破れボンド数を",
        "「同じ行の中の破れ」と「隣り合う行の間の破れ」に分けるとき、この分割をそのまま使うためである。",
        "上で定める端点写像により、横向きの辺は両端の行番号が等しく（同じ行の中）、",
        "縦向きの辺は両端の列番号が等しく行番号が 1 だけ異なる（隣り合う行の間）。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}`),
        " と ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " を行き来する写像に名前を与える。一方は自然な射影",
      ]),
      displayMath(String.raw`\pi:\mathbb{Z}\to\mathbb{Z}/L\mathbb{Z},\qquad \pi(n):=n+L\mathbb{Z}`),
      paragraph([
        "であり、もう一方は代表を取る写像",
      ]),
      displayMath(
        String.raw`s:\mathbb{Z}/L\mathbb{Z}\to\mathbb{Z},\qquad
0\le s(y)\le L-1\ \text{かつ}\ \pi(s(y))=y`,
      ),
      paragraph([
        "である。各 ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " に対しこの条件を満たす整数はちょうど 1 つなので（除法の原理）、",
        math(String.raw`s`),
        " は写像として定まる。以下、この 2 本以外の経路で ",
        math(String.raw`\mathbb{Z}`),
        " と ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " を行き来しない。とくに、整数を剰余類と「みなす」ことはしない。",
      ]),
      paragraph([
        "また、",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の加法を ",
        math(String.raw`+_{\mathbb{Z}/L\mathbb{Z}}`),
        " と書き、",
        math(String.raw`\mathbb{Z}`),
        " の加法 ",
        math(String.raw`+`),
        " と区別する。",
        math(String.raw`\bar1:=\pi(1)\in\mathbb{Z}/L\mathbb{Z}`),
        " と置く。",
      ]),
      paragraph([
        "頂点 ",
        math(String.raw`(i,j)\in V_L`),
        " に対し、番号を与える写像 ",
        math(String.raw`n_{\mathrm{h}},n_{\mathrm{v}}:V_L\to\mathbb{Z}`),
        " を",
      ]),
      displayMath(
        String.raw`n_{\mathrm{h}}(i,j):=L\cdot s(i)+s(j)+1,\qquad
n_{\mathrm{v}}(i,j):=L^2+L\cdot s(i)+s(j)+1`,
      ),
      paragraph([
        "で定める（右辺は ",
        math(String.raw`\mathbb{Z}`),
        " の中の計算である）。",
        math(String.raw`0\le s(i),s(j)\le L-1`),
        " より ",
        math(String.raw`n_{\mathrm{h}}(i,j)\in E_{L,\mathrm{h}}`),
        " かつ ",
        math(String.raw`n_{\mathrm{v}}(i,j)\in E_{L,\mathrm{v}}`),
        " であり、どちらも全単射である（",
        ref("claim_edge_row_partition"),
        "）。",
      ]),
      paragraph([
        "端点写像はこの全単射の逆向きに定める。",
        math(String.raw`e\in E_{L,\mathrm{h}}`),
        " に対しては ",
        math(String.raw`e=n_{\mathrm{h}}(i,j)`),
        " を満たす唯一の ",
        math(String.raw`(i,j)\in V_L`),
        " を取り",
      ]),
      displayMath(
        String.raw`\partial_0(e):=(i,\,j),\qquad
\partial_1(e):=\bigl(i,\ j+_{\mathbb{Z}/L\mathbb{Z}}\bar1\bigr)`,
      ),
      paragraph([
        "と定め（行番号を変えず列番号だけを進める。だから横向きである）、",
        math(String.raw`e\in E_{L,\mathrm{v}}`),
        " に対しては ",
        math(String.raw`e=n_{\mathrm{v}}(i,j)`),
        " を満たす唯一の ",
        math(String.raw`(i,j)\in V_L`),
        " を取り",
      ]),
      displayMath(
        String.raw`\partial_0(e):=(i,\,j),\qquad
\partial_1(e):=\bigl(i+_{\mathbb{Z}/L\mathbb{Z}}\bar1,\ j\bigr)`,
      ),
      paragraph([
        "と定める。行番号・列番号を進める操作が ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中の加法であることが、周期境界条件そのものである。",
        math(String.raw`\bar1`),
        " を足すのであって ",
        math(String.raw`1`),
        " を足すのではない。",
      ]),
      paragraph([
        "辺そのものを頂点の 2 元集合 ",
        math(String.raw`\{u,w\}`),
        " として定義しないのは、",
        math(String.raw`L\le2`),
        " のとき異なる辺が同じ 2 元集合になってしまうからである（",
        math(String.raw`L=1`),
        " では ",
        math(String.raw`\partial_0(e)=\partial_1(e)`),
        " で 1 元集合になり、",
        math(String.raw`L=2`),
        " では横向きの 2 本が同じ 2 点を結ぶ）。2 元集合の集合として数えると本数が ",
        math(String.raw`2L^2`),
        " からずれ、以下の主張が小さい ",
        math(String.raw`L`),
        " で成り立たなくなる。番号を付けておけば、同じ 2 点を結ぶ辺が複数あっても別の辺として数えられる。",
      ]),
      paragraph([
        "以下、有限集合 ",
        math(String.raw`X`),
        " に対し ",
        math(String.raw`|X|`),
        " でその元の個数（",
        math(String.raw`\mathbb{N}`),
        " の元）を表す。この記法をこれ以外の意味（絶対値・ノルム）では使わない。",
      ]),
      paragraph([
        math(String.raw`V_L`),
        " は有限集合で ",
        math(String.raw`|V_L|=L^2`),
        "、",
        math(String.raw`E_{L,\mathrm{h}}`),
        " と ",
        math(String.raw`E_{L,\mathrm{v}}`),
        " はいずれも有限集合で ",
        math(String.raw`|E_{L,\mathrm{h}}|=|E_{L,\mathrm{v}}|=L^2`),
        " である（連続する整数の個数）。両者は互いに素なので ",
        math(String.raw`|E_L|=L^2+L^2=2L^2`),
        " となる。",
      ]),
    ],
  },


  {
    id: "partition_polynomial_definition_configuration",
    kind: "definition",
    title: { text: "配位" },
    labels: ["def_configuration"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.Config",
      "Ising2DLambda.PartitionPolynomial.card_config",
    ],
    statement: [
      paragraph([
        "配位とは写像 ",
        math(String.raw`\sigma:V_L\to\{+1,-1\}`),
        " のことである。配位全体の集合を",
      ]),
      displayMath(
        String.raw`\Sigma_L:=\bigl\{\,\sigma \;\bigm|\; \sigma\ \text{は}\ V_L\ \text{から}\ \{+1,-1\}\ \text{への写像}\,\bigr\}`,
      ),
      paragraph([
        "と書く（写像全体の集合を冪の記法 ",
        math(String.raw`\{+1,-1\}^{V_L}`),
        " で表すことはしない。指数と紛れるため）。",
        math(String.raw`\Sigma_L`),
        " は有限集合で ",
        math(String.raw`|\Sigma_L|=2^{L^2}`),
        " である（各頂点に独立に 2 通りの値を割り当てるので、",
        math(String.raw`|V_L|=L^2`),
        " 個の 2 通りの積）。",
      ]),
      paragraph([
        "この定義に現れる対象はすべて有限集合とその上の写像であり、実数体も複素数体も使っていない。値 ",
        math(String.raw`\pm1`),
        " は ",
        math(String.raw`\mathbb{Z}`),
        " の元として読む。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_broken_bond_count",
    kind: "definition",
    title: { text: "破れボンド数" },
    labels: ["def_broken_bond_count"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.brokenBondCount",
      "Ising2DLambda.PartitionPolynomial.brokenBondCount_le",
    ],
    statement: [
      paragraph([
        ref("def_configuration"),
        " の配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " と ",
        ref("def_lattice"),
        " の辺の番号 ",
        math(String.raw`e\in E_L`),
        " に対し、",
        math(String.raw`\sigma(\partial_0(e))\ne\sigma(\partial_1(e))`),
        " が成り立つとき「辺 ",
        math(String.raw`e`),
        " は ",
        math(String.raw`\sigma`),
        " のもとで破れている」という。",
      ]),
      paragraph([
        "配位 ",
        math(String.raw`\sigma`),
        " の破れボンド数 ",
        math(String.raw`b(\sigma)`),
        " を、破れている辺の番号の個数",
      ]),
      displayMath(
        String.raw`b(\sigma):=\bigl|\bigl\{\,e\in E_L \;\bigm|\; \sigma(\partial_0(e))\ne\sigma(\partial_1(e))\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める。有限集合の部分集合の元の個数なので ",
        math(String.raw`b(\sigma)\in\mathbb{N}`),
        " であり、",
        math(String.raw`0\le b(\sigma)\le|E_L|=2L^2`),
        " が成り立つ。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_multiplicity",
    kind: "definition",
    title: { text: "多重度" },
    labels: ["def_multiplicity"],
    habitat: "N",
    lean: ["Ising2DLambda.PartitionPolynomial.multiplicity"],
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`m\in\{0,1,\dots,2L^2\}`),
        " に対し、多重度 ",
        math(String.raw`\Omega_L(m)`),
        " を",
      ]),
      displayMath(
        String.raw`\Omega_L(m):=\bigl|\bigl\{\,\sigma\in\Sigma_L \;\bigm|\; b(\sigma)=m\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`b(\sigma)`),
        " は ",
        ref("def_broken_bond_count"),
        "）。有限集合 ",
        math(String.raw`\Sigma_L`),
        " の部分集合の元の個数なので ",
        math(String.raw`\Omega_L(m)\in\mathbb{N}`),
        " である。",
      ]),
      paragraph([
        "多重度は数え上げだけで定義されており、温度・エネルギーといった量を含まない。",
        "これがこの章の主張のすべてを可算側に留める理由である。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_partition_polynomial",
    kind: "definition",
    title: { text: "分配多項式" },
    labels: ["def_partition_polynomial"],
    habitat: "Z",
    lean: ["Ising2DLambda.PartitionPolynomial.partitionPolynomial"],
    statement: [
      paragraph([
        math(String.raw`x`),
        " を不定元とし、多項式環 ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で分配多項式を",
      ]),
      displayMath(String.raw`Z_L:=\sum_{\sigma\in\Sigma_L}x^{\,b(\sigma)}\ \in\ \mathbb{Z}[x]`),
      paragraph([
        "で定める（",
        math(String.raw`b(\sigma)`),
        " は ",
        ref("def_broken_bond_count"),
        "）。有限個の項の和なので右辺は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として確定する。",
      ]),
      paragraph([
        "和の各項の指数は ",
        math(String.raw`b(\sigma)\in\mathbb{N}`),
        "、係数はいずれも ",
        math(String.raw`1\in\mathbb{Z}`),
        " である。この定義は多重度を用いていない。",
        "多重度を用いた形（各 ",
        math(String.raw`x^{\,m}`),
        " の係数が ",
        math(String.raw`\Omega_L(m)`),
        " であること）は定義ではなく、下で証明する。",
      ]),
      paragraph([
        "記法について 2 点を約束する。第一に、",
        math(String.raw`Z_L`),
        " は多項式そのものを表し、",
        math(String.raw`x`),
        " は不定元であって数ではない。第二に、可換環 ",
        math(String.raw`R`),
        " と元 ",
        math(String.raw`r\in R`),
        " に対する代入（評価）の結果を ",
        math(String.raw`Z_L(r)\in R`),
        " と書く。すなわち丸括弧が付いたものだけが代入の結果であり、",
        math(String.raw`Z_L`),
        " と ",
        math(String.raw`Z_L(r)`),
        " は別の対象である。",
      ]),
      paragraph([
        "この定義では代入を行わない。物理の分配関数を得るには ",
        math(String.raw`x`),
        " へ ",
        math(String.raw`e^{-2\beta J}`),
        " を代入するが、その代入は実数体への脱出であり、脱出を宣言したブロックでのみ行う（README「形式変数のまま進む」）。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_claim_configuration_partition",
    kind: "claim",
    title: { text: "配位全体は破れボンド数の値ごとに類別される" },
    labels: ["claim_configuration_partition"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.biUnion_brokenFiber",
      "Ising2DLambda.PartitionPolynomial.brokenFiber_pairwise_disjoint",
      "Ising2DLambda.NecSuf.PartitionPolynomial.biUnion_fiber",
      "Ising2DLambda.NecSuf.PartitionPolynomial.fiber_pairwise_disjoint",
    ],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " と各 ",
        math(String.raw`m\in\{0,1,\dots,2L^2\}`),
        " に対し、破れボンド数が ",
        math(String.raw`m`),
        " である配位の集合を",
      ]),
      displayMath(
        String.raw`A_{L,m}:=\bigl\{\,\sigma\in\Sigma_L \;\bigm|\; b(\sigma)=m\,\bigr\}`,
      ),
      paragraph([
        "と書く（",
        math(String.raw`\Sigma_L`),
        " は ",
        ref("def_configuration"),
        "、",
        math(String.raw`b(\sigma)`),
        " は ",
        ref("def_broken_bond_count"),
        "）。右辺は ",
        math(String.raw`L`),
        " にも依存するので、添字には ",
        math(String.raw`m`),
        " だけでなく ",
        math(String.raw`L`),
        " も書く。このとき次の 2 つが成り立つ。",
      ]),
      list([
        [
          "（被覆）",
          math(String.raw`\Sigma_L=\bigcup_{m=0}^{2L^2}A_{L,m}`),
          " である。",
        ],
        [
          "（互いに素）",
          math(String.raw`m,m'\in\{0,1,\dots,2L^2\}`),
          " が ",
          math(String.raw`m\ne m'`),
          " を満たすならば ",
          math(String.raw`A_{L,m}\cap A_{L,m'}=\varnothing`),
          " である。",
        ],
      ]),
      paragraph([
        "すなわち ",
        math(String.raw`\{A_{L,m}\}_{m=0}^{2L^2}`),
        " は ",
        math(String.raw`\Sigma_L`),
        " の互いに素な有限個の部分集合への分割である。",
      ]),
    ],
    proof: [
      paragraph([
        "示すことは 2 つある。合併が ",
        math(String.raw`\Sigma_L`),
        " に等しいことと、互いに素であることである。",
      ]),
      paragraph([
        "合併が等しいこと。",
        math(String.raw`A_{L,m}`),
        " の定義より ",
        math(String.raw`A_{L,m}\subset\Sigma_L`),
        " なので、合併も ",
        math(String.raw`\Sigma_L`),
        " に含まれる。逆を示す。任意の ",
        math(String.raw`\sigma\in\Sigma_L`),
        " に対し、",
        ref("def_broken_bond_count"),
        " より ",
        math(String.raw`b(\sigma)\in\mathbb{N}`),
        " かつ ",
        math(String.raw`b(\sigma)\le 2L^2`),
        " である。そこで ",
        math(String.raw`m:=b(\sigma)`),
        " と置くと ",
        math(String.raw`m\in\{0,1,\dots,2L^2\}`),
        " であり、",
        math(String.raw`b(\sigma)=m`),
        " なので ",
        math(String.raw`\sigma\in A_{L,m}`),
        " である。よって ",
        math(String.raw`\sigma`),
        " は合併に属する。",
      ]),
      paragraph([
        "互いに素であること。",
        math(String.raw`m\ne m'`),
        " とし、",
        math(String.raw`\sigma\in A_{L,m}\cap A_{L,m'}`),
        " が存在したとする。この ",
        math(String.raw`\sigma`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
m
&=b(\sigma)
&&(\because\ \sigma\in A_{L,m}\ \text{と}\ A_{L,m}\ \text{の定義})\\
&=m'
&&(\because\ b\ \text{は写像なので}\ \sigma\ \text{に対する値は 1 つであり、}
\sigma\in A_{L,m'}\ \text{と}\ A_{L,m'}\ \text{の定義})
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`m\ne m'`),
        " に反する。したがってそのような ",
        math(String.raw`\sigma`),
        " は存在せず、",
        math(String.raw`A_{L,m}\cap A_{L,m'}=\varnothing`),
        " である。",
      ]),
      paragraph([
        "以上の 2 つは有限集合の包含関係と写像の一意性だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_claim_coefficient_representation",
    kind: "claim",
    title: { text: "分配多項式の係数は多重度である" },
    labels: ["claim_coefficient_representation"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity",
      "Ising2DLambda.PartitionPolynomial.partitionPolynomial_eq_sum_multiplicity_from_necSuf",
      "Ising2DLambda.NecSuf.PartitionPolynomial.sum_comp_eq_sum_nsmul",
    ],
    verification: ["sagemath/check/partition-polynomial-coefficient-representation"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " について、多項式環 ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で",
      ]),
      displayMath(String.raw`Z_L=\sum_{m=0}^{2L^2}\Omega_L(m)\,x^{\,m}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`Z_L`),
        " は ",
        ref("def_partition_polynomial"),
        "、",
        math(String.raw`\Omega_L(m)`),
        " は ",
        ref("def_multiplicity"),
        "）。すなわち ",
        math(String.raw`\Omega_L(m)\in\mathbb{N}\subset\mathbb{Z}`),
        " は ",
        math(String.raw`Z_L`),
        " の ",
        math(String.raw`x^{\,m}`),
        " の係数である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
Z_L
&=\sum_{\sigma\in\Sigma_L}x^{\,b(\sigma)}
&&(\because\ \blkref{def_partition_polynomial})\\
&=\sum_{m=0}^{2L^2}\ \sum_{\sigma\in A_{L,m}}x^{\,b(\sigma)}
&&(\because\ \blkref{claim_configuration_partition})\\
&=\sum_{m=0}^{2L^2}\ \sum_{\sigma\in A_{L,m}}x^{\,m}
&&(\because\ \sigma\in A_{L,m}\ \Rightarrow\ b(\sigma)=m)\\
&=\sum_{m=0}^{2L^2}|A_{L,m}|\cdot x^{\,m}
&&(\because\ \text{同じ元を }|A_{L,m}|\text{ 個足した})\\
&=\sum_{m=0}^{2L^2}\Omega_L(m)\,x^{\,m}
&&(\because\ \blkref{def_multiplicity})
\end{aligned}`),
      paragraph([
        "以上は有限和の組み替えと数え上げだけからなり、",
        math(String.raw`x`),
        " への代入を行っていない。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_claim_coefficient_sum",
    kind: "claim",
    title: { text: "多重度の総和は配位の総数に等しい" },
    labels: ["claim_coefficient_sum"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.multiplicity_sum_eq_two_pow",
      "Ising2DLambda.PartitionPolynomial.multiplicity_sum_eq_two_pow_from_necSuf",
      "Ising2DLambda.NecSuf.PartitionPolynomial.sum_card_fiber_eq_card",
    ],
    verification: ["sagemath/check/partition-polynomial-coefficient-sum"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " について",
      ]),
      displayMath(String.raw`\sum_{m=0}^{2L^2}\Omega_L(m)=2^{L^2}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\Omega_L(m)`),
        " は ",
        ref("def_multiplicity"),
        "）。両辺は ",
        math(String.raw`\mathbb{N}`),
        " の元である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\sum_{m=0}^{2L^2}\Omega_L(m)
&=\sum_{m=0}^{2L^2}|A_{L,m}|
&&(\because\ \blkref{def_multiplicity})\\
&=|\Sigma_L|
&&(\because\ \blkref{claim_configuration_partition})\\
&=2^{L^2}
&&(\because\ \blkref{def_configuration})
\end{aligned}`),
      paragraph([
        "以上は有限集合の元の個数の計算だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "free_entropy_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限系の自由エントロピー" },
    labels: [],
  },

  {
    id: "free_entropy_definition_prime_exponent",
    kind: "definition",
    title: { text: "素因数分解の指数" },
    labels: ["def_prime_exponent"],
    habitat: "N",
    lean: ["Ising2DLambda.FreeEntropy.primeExponent"],
    statement: [
      paragraph([
        "素数全体の集合を ",
        math(String.raw`\mathcal{P}=\{2,3,5,7,\dots\}`),
        " と書く。これは無限集合だが可算である。",
      ]),
      paragraph([
        "1 以上の整数 ",
        math(String.raw`n`),
        " を取る。算術の基本定理により、相異なる有限個の素数 ",
        math(String.raw`p_1,\dots,p_k\in\mathcal{P}`),
        "（",
        math(String.raw`k\in\mathbb{N}`),
        "）と 1 以上の整数 ",
        math(String.raw`e_1,\dots,e_k`),
        " が存在して",
      ]),
      displayMath(String.raw`n=\prod_{i=1}^{k}p_i^{\,e_i}`),
      paragraph([
        "と書け、この表示は素数の並べ方の違いを除いてただ一通りである。",
        "右辺は有限個の因子の積であり、無限個の素数にわたる積は書いていない。",
        math(String.raw`n=1`),
        " のときは ",
        math(String.raw`k=0`),
        " であり、右辺は空積すなわち ",
        math(String.raw`1`),
        " である。",
      ]),
      paragraph([
        "この表示を用いて、素数 ",
        math(String.raw`p\in\mathcal{P}`),
        " に対し ",
        math(String.raw`v_p(n)\in\mathbb{N}`),
        " を",
      ]),
      displayMath(
        String.raw`v_p(n):=\begin{cases}e_i&(\text{ある}\ i\ \text{について}\ p=p_i\ \text{であるとき})\\[2pt]0&(\text{どの}\ i\ \text{についても}\ p\ne p_i\ \text{であるとき})\end{cases}`,
      ),
      paragraph([
        "で定め、これを ",
        math(String.raw`n`),
        " における ",
        math(String.raw`p`),
        " の指数と呼ぶ。",
        math(String.raw`p_1,\dots,p_k`),
        " は相異なるので、第一の場合の ",
        math(String.raw`i`),
        " は高々 1 つであり、右辺は定まる。",
        "また表示が並べ方を除いて一通りであることから、",
        math(String.raw`v_p(n)`),
        " は表示の取り方によらず ",
        math(String.raw`n`),
        " と ",
        math(String.raw`p`),
        " だけで決まる。",
      ]),
      paragraph([
        "定義より ",
        math(String.raw`v_p(n)\ne0`),
        " となる素数 ",
        math(String.raw`p`),
        " は ",
        math(String.raw`p_1,\dots,p_k`),
        " のいずれかなので、そのような素数は有限個（高々 ",
        math(String.raw`k`),
        " 個）である。したがって次の積は有限積として意味を持ち、",
      ]),
      displayMath(String.raw`n=\prod_{p:\ v_p(n)\ne0}p^{\,v_p(n)}`),
      paragraph([
        "が成り立つ（指数が ",
        math(String.raw`0`),
        " の素数を落としても因子 ",
        math(String.raw`p^{0}=1`),
        " が消えるだけである）。以後、素数を走る積はすべてこの形の有限積として書く。",
      ]),
      paragraph([
        "定義から直ちに次の 2 つが従う。第一に ",
        math(String.raw`v_p(1)=0`),
        " である（",
        math(String.raw`1`),
        " の表示は ",
        math(String.raw`k=0`),
        " の空積であり、どの素数も因子に持たない）。第二に、1 以上の整数 ",
        math(String.raw`m,n`),
        " に対し",
      ]),
      displayMath(String.raw`v_p(mn)=v_p(m)+v_p(n)`),
      paragraph([
        "が成り立つ（指数の加法性）。これを示す。まず有限集合",
      ]),
      displayMath(
        String.raw`S:=\{\,p\in\mathcal{P}\mid v_p(m)\ne0\,\}\cup\{\,p\in\mathcal{P}\mid v_p(n)\ne0\,\}`,
      ),
      paragraph([
        "を取る（有限集合 2 つの合併なので有限である）。",
        math(String.raw`S`),
        " の外の素数では ",
        math(String.raw`m`),
        " も ",
        math(String.raw`n`),
        " も指数が ",
        math(String.raw`0`),
        " なので、上の有限積の因子を ",
        math(String.raw`S`),
        " まで増やしても値は変わらず",
      ]),
      displayMath(
        String.raw`m=\prod_{p\in S}p^{\,v_p(m)},\qquad n=\prod_{p\in S}p^{\,v_p(n)}`,
      ),
      paragraph([
        "である。両辺どうしを掛け、同じ素数の冪をまとめると",
      ]),
      displayMath(String.raw`mn=\prod_{p\in S}p^{\,v_p(m)+v_p(n)}`),
      paragraph([
        "を得る。右辺は ",
        math(String.raw`mn`),
        " を相異なる有限個の素数の冪の積として書いたものなので、算術の基本定理の一意性より、",
        math(String.raw`S`),
        " に属する素数 ",
        math(String.raw`p`),
        " については指数が一致して ",
        math(String.raw`v_p(mn)=v_p(m)+v_p(n)`),
        " である。",
        math(String.raw`S`),
        " に属さない素数 ",
        math(String.raw`p`),
        " については、同じ一意性より ",
        math(String.raw`mn`),
        " の因子に現れないので ",
        math(String.raw`v_p(mn)=0`),
        " であり、",
        math(String.raw`v_p(m)=v_p(n)=0`),
        " だから両辺とも ",
        math(String.raw`0`),
        " で等しい。",
      ]),
      paragraph([
        "この定義に現れるのは 1 以上の整数と自然数だけであり、実数体も複素数体も使っていない。",
        "指数関数も実対数も現れないことに注意する。",
      ]),
    ],
  },

  {
    id: "free_entropy_definition_log_order_group",
    kind: "definition",
    title: { text: "対数順序群" },
    labels: ["def_log_order_group"],
    habitat: "Lambda",
    lean: [
      "Ising2DLambda.FreeEntropy.LogOrderGroup",
      "Ising2DLambda.FreeEntropy.generator",
    ],
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`\lambda:\mathcal{P}\to\mathbb{Z}`),
        " のうち、",
        math(String.raw`\lambda(p)\ne0`),
        " となる素数 ",
        math(String.raw`p`),
        " が有限個であるもの全体の集合を",
      ]),
      displayMath(
        String.raw`\Lambda:=\bigl\{\,\lambda \;\bigm|\; \lambda\ \text{は}\ \mathcal{P}\ \text{から}\ \mathbb{Z}\ \text{への写像で、}\ \lambda(p)\ne0\ \text{となる}\ p\ \text{は有限個}\,\bigr\}`,
      ),
      paragraph([
        "と書き、加法を素数ごとに",
      ]),
      displayMath(String.raw`(\lambda+\mu)(p):=\lambda(p)+\mu(p)\qquad(p\in\mathcal{P})`),
      paragraph([
        "で定める（右辺の加法は ",
        math(String.raw`\mathbb{Z}`),
        " の中で行う）。",
        math(String.raw`\lambda+\mu`),
        " も有限個の素数でしか ",
        math(String.raw`0`),
        " と異なる値を取らないので ",
        math(String.raw`\Lambda`),
        " の元である（2 つの有限集合の合併は有限）。零写像を単位元、",
        math(String.raw`(-\lambda)(p):=-\lambda(p)`),
        " を逆元として、",
        math(String.raw`\Lambda`),
        " は加法についてアーベル群になる。これを対数順序群と呼ぶ。",
      ]),
      paragraph([
        "整数倍の記法も定めておく。",
        math(String.raw`\lambda\in\Lambda`),
        " と ",
        math(String.raw`n\in\mathbb{Z}`),
        " に対し ",
        math(String.raw`n\lambda\in\Lambda`),
        " を、素数ごとの積",
      ]),
      displayMath(String.raw`(n\lambda)(p):=n\cdot\lambda(p)\qquad(p\in\mathcal{P})`),
      paragraph([
        "で定める（右辺の積は ",
        math(String.raw`\mathbb{Z}`),
        " の中で行う）。",
        math(String.raw`\lambda(p)=0`),
        " なら ",
        math(String.raw`(n\lambda)(p)=0`),
        " なので台は増えず、",
        math(String.raw`n\lambda`),
        " は ",
        math(String.raw`\Lambda`),
        " の元である。",
        math(String.raw`n\ge0`),
        " のとき ",
        math(String.raw`n\lambda`),
        " は ",
        math(String.raw`\lambda`),
        " を ",
        math(String.raw`n`),
        " 個足したものに一致する（素数ごとに ",
        math(String.raw`\mathbb{Z}`),
        " の中で同じことを言っているだけである）。",
      ]),
      paragraph([
        "各素数 ",
        math(String.raw`p`),
        " に対し ",
        math(String.raw`\ell_p\in\Lambda`),
        " を",
      ]),
      displayMath(
        String.raw`\ell_p(p):=1,\qquad \ell_p(p'):=0\quad(p'\in\mathcal{P},\ p'\ne p)`,
      ),
      paragraph([
        "で定める。台が有限なので、",
        math(String.raw`\Lambda`),
        " の各元 ",
        math(String.raw`\lambda`),
        " は有限和",
      ]),
      displayMath(String.raw`\lambda=\sum_{p:\ \lambda(p)\ne0}\lambda(p)\,\ell_p`),
      paragraph([
        "としてただ一通りに書ける。記号 ",
        math(String.raw`\ell_p`),
        " は「",
        math(String.raw`p`),
        " の対数」と読むが、これは形式的な記号であって、実数としての自然対数の値を参照しない。",
        "実数体の元は一切登場しない。",
      ]),
      paragraph([
        "名前に「順序」という語が入っているが、ここで定めたのは加法群としての構造だけであり、",
        math(String.raw`\Lambda`),
        " に順序は定めていない。本章では順序を使わないためである。",
        "順序が必要になる箇所（零点の詰め寄りを述べるとき）で、そこで必要な形の順序を定義し、",
        "それが定義できることもそこで示す。",
        "対数順序群という呼び名は、その段階を先取りした名前として使っている。",
      ]),
    ],
  },

  {
    id: "free_entropy_claim_rational_exponent_well_defined",
    kind: "claim",
    title: { text: "有理数の指数は表示の取り方によらない" },
    labels: ["claim_rational_exponent_well_defined"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.FreeEntropy.rationalExponent_well_defined",
      "Ising2DLambda.FreeEntropy.rationalExponent_well_defined_from_necSuf",
      "Ising2DLambda.NecSuf.FreeEntropy.sub_eq_sub_of_mul_eq_mul",
    ],
    verification: ["sagemath/check/free-entropy-definition"],
    statement: [
      paragraph([
        "素数 ",
        math(String.raw`p\in\mathcal{P}`),
        " と、1 以上の整数 ",
        math(String.raw`a,b,a',b'`),
        " を取る。有理数として ",
        math(String.raw`\dfrac{a}{b}=\dfrac{a'}{b'}`),
        " が成り立つならば、",
      ]),
      displayMath(String.raw`v_p(a)-v_p(b)=v_p(a')-v_p(b')`),
      paragraph([
        "が ",
        math(String.raw`\mathbb{Z}`),
        " の中で成り立つ（",
        math(String.raw`v_p`),
        " は ",
        ref("def_prime_exponent"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`ab'=a'b`),
        " である（仮定 ",
        math(String.raw`a/b=a'/b'`),
        " の両辺に ",
        math(String.raw`bb'\ne0`),
        " を掛けた。両辺は 1 以上の整数の積なので 1 以上の整数）。",
      ]),
      displayMath(String.raw`\begin{aligned}
v_p(a)+v_p(b')
&=v_p(ab')
&&(\because\ \blkref{def_prime_exponent})\\
&=v_p(a'b)
&&(\because\ ab'=a'b)\\
&=v_p(a')+v_p(b)
&&(\because\ \blkref{def_prime_exponent})
\end{aligned}`),
      paragraph([
        "であり、両辺から ",
        math(String.raw`v_p(b)+v_p(b')`),
        " を引いて ",
        math(String.raw`v_p(a)-v_p(b)=v_p(a')-v_p(b')`),
        " を得る。",
      ]),
      paragraph([
        "以上は整数の演算と素因数分解の一意性だけからなり、実数体も複素数体も現れない。",
        "引き算のためだけに ",
        math(String.raw`\mathbb{N}`),
        " から ",
        math(String.raw`\mathbb{Z}`),
        " へ出ているが、どちらも可算である。",
      ]),
    ],
  },

  {
    id: "free_entropy_definition_rational_log",
    kind: "definition",
    title: { text: "正の有理数の対数" },
    labels: ["def_rational_log"],
    habitat: "Lambda",
    lean: [
      "Ising2DLambda.FreeEntropy.rationalExponent",
      "Ising2DLambda.FreeEntropy.logRat",
    ],
    statement: [
      paragraph([
        "正の有理数全体の集合を ",
        math(String.raw`\mathbb{Q}_{>0}`),
        " と書く。各 ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " は、1 以上の整数 ",
        math(String.raw`a,b`),
        " を用いて ",
        math(String.raw`q=a/b`),
        " と書ける。素数 ",
        math(String.raw`p`),
        " に対し",
      ]),
      displayMath(String.raw`w_p(q):=v_p(a)-v_p(b)\ \in\ \mathbb{Z}`),
      paragraph([
        "と定める（",
        math(String.raw`v_p`),
        " は ",
        ref("def_prime_exponent"),
        "）。この値は ",
        math(String.raw`q`),
        " の表示 ",
        math(String.raw`a/b`),
        " の取り方によらない（",
        ref("claim_rational_exponent_well_defined"),
        "）ので、",
        math(String.raw`w_p(q)`),
        " は ",
        math(String.raw`q`),
        " だけで決まる。関数の名前を ",
        math(String.raw`v_p`),
        " と分けてあるのは、定義域が異なるからである（",
        math(String.raw`v_p`),
        " は 1 以上の整数に、",
        math(String.raw`w_p`),
        " は正の有理数に定義されている）。",
      ]),
      paragraph([
        math(String.raw`w_p(q)\ne0`),
        " となる素数 ",
        math(String.raw`p`),
        " は有限個である。実際 ",
        math(String.raw`w_p(q)=v_p(a)-v_p(b)`),
        " なので、",
        math(String.raw`w_p(q)\ne0`),
        " ならば ",
        math(String.raw`v_p(a)\ne0`),
        " または ",
        math(String.raw`v_p(b)\ne0`),
        " であり、",
        ref("def_prime_exponent"),
        " よりそのような ",
        math(String.raw`p`),
        " はどちらについても有限個だからである。したがって写像 ",
        math(String.raw`p\mapsto w_p(q)`),
        " は ",
        ref("def_log_order_group"),
        " の ",
        math(String.raw`\Lambda`),
        " の元である。これを",
      ]),
      displayMath(String.raw`\log q:=\sum_{p:\ w_p(q)\ne0}w_p(q)\,\ell_p\ \in\ \Lambda`),
      paragraph([
        "と書き、",
        math(String.raw`q`),
        " の対数と呼ぶ。1 以上の整数 ",
        math(String.raw`n`),
        " については ",
        math(String.raw`n=n/1`),
        " と ",
        math(String.raw`v_p(1)=0`),
        " より ",
        math(String.raw`w_p(n)=v_p(n)`),
        " となるので、整数に対する指数と矛盾しない。",
      ]),
      paragraph([
        "この対数は級数でも極限でもなく、素因数分解そのものである。値は ",
        math(String.raw`\Lambda`),
        " の元であって、実数ではない。",
      ]),
    ],
  },

  {
    id: "free_entropy_claim_value_at_rational_is_positive",
    kind: "claim",
    title: { text: "分配多項式の正の有理点での値は正の有理数である" },
    labels: ["claim_value_at_rational_is_positive"],
    habitat: "Q",
    lean: [
      "Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos",
      "Ising2DLambda.FreeEntropy.partitionPolynomial_eval_pos_from_necSuf",
      "Ising2DLambda.NecSuf.FreeEntropy.sum_pow_pos",
    ],
    verification: ["sagemath/check/free-entropy-definition"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " と各 ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " について、",
        ref("def_partition_polynomial"),
        " の分配多項式へ ",
        math(String.raw`q`),
        " を代入した値は",
      ]),
      displayMath(String.raw`Z_L(q)\in\mathbb{Q}_{>0}`),
      paragraph([
        "を満たす。ここで代入は ",
        ref("def_partition_polynomial"),
        " の約束どおり、可換環 ",
        math(String.raw`\mathbb{Q}`),
        " とその元 ",
        math(String.raw`q`),
        " についての評価である。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、各 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について ",
        math(String.raw`q^{\,b(\sigma)}>0`),
        " である。実際 ",
        math(String.raw`b(\sigma)\in\mathbb{N}`),
        " であり（",
        ref("def_broken_bond_count"),
        "）、正の有理数を ",
        math(String.raw`b(\sigma)`),
        " 個掛けたものは正である（",
        math(String.raw`b(\sigma)=0`),
        " のときは空積で ",
        math(String.raw`q^{0}=1>0`),
        "）。また ",
        math(String.raw`|\Sigma_L|=2^{L^2}\ge1`),
        " なので（",
        ref("def_configuration"),
        "）、下の和は少なくとも 1 個の項を持つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
Z_L(q)
&=\Bigl(\sum_{\sigma\in\Sigma_L}x^{\,b(\sigma)}\Bigr)(q)
&&(\because\ \blkref{def_partition_polynomial})\\
&=\sum_{\sigma\in\Sigma_L}q^{\,b(\sigma)}
&&(\because\ \text{代入は環準同型なので和と積を保つ})\\
&\in\mathbb{Q}_{>0}
&&(\because\ \text{正の有理数を 1 個以上足したものは正})
\end{aligned}`),
      paragraph([
        "以上は有理数の四則と有限和だけからなり、実数体も複素数体も現れない。",
        "代入したのは有理数であって、指数関数の値ではない。",
      ]),
    ],
  },

  {
    id: "free_entropy_definition_finite_free_entropy",
    kind: "definition",
    title: { text: "有限系の自由エントロピー" },
    labels: ["def_finite_free_entropy"],
    habitat: "Lambda",
    lean: ["Ising2DLambda.FreeEntropy.freeEntropy"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " と各 ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " に対し、有限系の自由エントロピーを",
      ]),
      displayMath(String.raw`\Phi_L(q):=\log Z_L(q)\ \in\ \Lambda`),
      paragraph([
        "で定める（",
        math(String.raw`\log`),
        " は ",
        ref("def_rational_log"),
        "、",
        math(String.raw`Z_L(q)`),
        " は ",
        ref("def_partition_polynomial"),
        " への代入）。",
        ref("claim_value_at_rational_is_positive"),
        " により ",
        math(String.raw`Z_L(q)`),
        " は正の有理数なので ",
        math(String.raw`\log`),
        " の定義域に入っており、右辺は ",
        math(String.raw`\Lambda`),
        " の元として確定する。",
      ]),
      paragraph([
        math(String.raw`\Phi_L`),
        " は ",
        math(String.raw`\mathbb{Q}_{>0}`),
        " から ",
        math(String.raw`\Lambda`),
        " への写像であり、",
        math(String.raw`\Phi_L(q)`),
        " はその値である。",
        math(String.raw`\Phi_L`),
        " と ",
        math(String.raw`\Phi_L(q)`),
        " を同じ記号で書くことはしない。",
      ]),
      paragraph([
        "具体例を 1 つ挙げる。",
        math(String.raw`L=2`),
        "、",
        math(String.raw`q=1/2`),
        " のとき ",
        math(String.raw`Z_2=2+12x^4+2x^8`),
        " なので",
      ]),
      displayMath(
        String.raw`Z_2(1/2)=2+\frac{12}{2^4}+\frac{2}{2^8}=\frac{353}{2^7},\qquad
\Phi_2(1/2)=\ell_{353}-7\,\ell_2\ \in\ \Lambda`,
      ),
      paragraph([
        "である（",
        math(String.raw`353`),
        " は素数）。自由エントロピーは分配多項式の値の素因数分解の指数ベクトルそのものであり、",
        "実数を経由しない。",
      ]),
    ],
  },

  {
    id: "free_entropy_claim_log_additive",
    kind: "claim",
    title: { text: "対数の加法性" },
    labels: ["claim_log_additive"],
    habitat: "Lambda",
    lean: [
      "Ising2DLambda.FreeEntropy.logRat_mul",
      "Ising2DLambda.FreeEntropy.logRat_mul_from_necSuf",
      "Ising2DLambda.NecSuf.FreeEntropy.sub_add_sub_of_mul",
    ],
    verification: ["sagemath/check/free-entropy-additivity"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`q_1,q_2\in\mathbb{Q}_{>0}`),
        " について",
      ]),
      displayMath(String.raw`\log(q_1q_2)=\log q_1+\log q_2`),
      paragraph([
        "が成り立つ。左辺の積は ",
        math(String.raw`\mathbb{Q}_{>0}`),
        " の中の積、右辺の和は ",
        ref("def_log_order_group"),
        " で定めた ",
        math(String.raw`\Lambda`),
        " の加法である（",
        math(String.raw`\log`),
        " は ",
        ref("def_rational_log"),
        "）。",
      ]),
      paragraph([
        "この性質が、",
        math(String.raw`\log`),
        " を対数と呼ぶ根拠である。掛け算を足し算へ移すという要求だけから、",
        "実数を持ち出さずにこの写像が得られている。",
      ]),
    ],
    proof: [
      paragraph([
        "1 以上の整数 ",
        math(String.raw`a_1,b_1,a_2,b_2`),
        " を取って ",
        math(String.raw`q_1=a_1/b_1`),
        "、",
        math(String.raw`q_2=a_2/b_2`),
        " と書く。素数 ",
        math(String.raw`p`),
        " を固定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\log(q_1q_2)\bigr)(p)
&=w_p(q_1q_2)
&&(\because\ \blkref{def_rational_log})\\
&=w_p\Bigl(\frac{a_1a_2}{b_1b_2}\Bigr)
&&(\because\ \text{有理数の積の定義})\\
&=v_p(a_1a_2)-v_p(b_1b_2)
&&(\because\ \text{正の有理数の対数の定義、有理数の指数は表示によらない})\\
&=\bigl(v_p(a_1)+v_p(a_2)\bigr)-\bigl(v_p(b_1)+v_p(b_2)\bigr)
&&(\because\ \blkref{def_prime_exponent})\\
&=\bigl(v_p(a_1)-v_p(b_1)\bigr)+\bigl(v_p(a_2)-v_p(b_2)\bigr)
&&(\because\ \mathbb{Z}\ \text{の加法の可換性と結合性})\\
&=w_p(q_1)+w_p(q_2)
&&(\because\ \blkref{def_rational_log})\\
&=\bigl(\log q_1+\log q_2\bigr)(p)
&&(\because\ \Lambda\ \text{の加法は素数ごとの }\mathbb{Z}\text{ の加法})
\end{aligned}`),
      paragraph([
        "が成り立つ。写像としてすべての素数で値が等しいので、",
        math(String.raw`\Lambda`),
        " の元として ",
        math(String.raw`\log(q_1q_2)=\log q_1+\log q_2`),
        " である。",
      ]),
      paragraph([
        "以上は整数の演算と素因数分解の一意性だけからなり、実数体も複素数体も現れない。",
        "指数関数も実対数も使っていない。",
      ]),
    ],
  },

  {
    id: "free_entropy_claim_log_power",
    kind: "claim",
    title: { text: "対数の冪の法則" },
    labels: ["claim_log_power"],
    habitat: "Lambda",
    lean: [
      "Ising2DLambda.FreeEntropy.logRat_pow",
      "Ising2DLambda.FreeEntropy.logRat_pow_from_necSuf",
      "Ising2DLambda.NecSuf.FreeEntropy.map_pow_eq_nsmul",
    ],
    verification: ["sagemath/check/free-entropy-additivity"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`q\in\mathbb{Q}_{>0}`),
        " と任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\log\bigl(q^{\,k}\bigr)=k\,\log q`),
      paragraph([
        "が成り立つ。右辺の整数倍は ",
        ref("def_log_order_group"),
        " で定めたものである。とくに ",
        math(String.raw`k=0`),
        " のとき ",
        math(String.raw`\log 1=0`),
        " であり、右辺の ",
        math(String.raw`0`),
        " は ",
        math(String.raw`\Lambda`),
        " の単位元（零写像）である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`q`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき、各素数 ",
        math(String.raw`p`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\log(q^{0})\bigr)(p)
&=\bigl(\log 1\bigr)(p)
&&(\because\ q^{0}=1)\\
&=w_p(1)
&&(\because\ \blkref{def_rational_log})\\
&=v_p(1)-v_p(1)
&&(\because\ 1=1/1)\\
&=0
&&\\
&=\bigl(0\cdot\log q\bigr)(p)
&&(\because\ \Lambda\ \text{の整数倍の定義})
\end{aligned}`),
      paragraph([
        "であり、両辺は ",
        math(String.raw`\Lambda`),
        " の単位元（零写像）として等しい。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`\log(q^{\,k})=k\,\log q`),
        " が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\log\bigl(q^{\,k+1}\bigr)
&=\log\bigl(q^{\,k}\cdot q\bigr)
&&(\because\ \text{冪の定義})\\
&=\log\bigl(q^{\,k}\bigr)+\log q
&&(\because\ \blkref{claim_log_additive}\text{、}q^{\,k},q\in\mathbb{Q}_{>0})\\
&=k\,\log q+\log q
&&(\because\ \text{帰納法の仮定})\\
&=(k+1)\,\log q
&&(\because\ \Lambda\ \text{の整数倍の定義と }\mathbb{Z}\ \text{の分配則})
\end{aligned}`),
      paragraph([
        "となる。したがって k=0 の場合と合わせて、すべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`\log(q^{\,k})=k\,\log q`),
        " が成り立つ。",
      ]),
    ],
  },

  {
    id: "free_entropy_claim_free_entropy_at_one",
    kind: "claim",
    title: { text: "すべての配位を等しく数える点での自由エントロピー" },
    labels: ["claim_free_entropy_at_one"],
    habitat: "Lambda",
    lean: [
      "Ising2DLambda.FreeEntropy.freeEntropy_at_one",
      "Ising2DLambda.FreeEntropy.partitionPolynomial_eval_one",
      "Ising2DLambda.FreeEntropy.logRat_two",
    ],
    verification: ["sagemath/check/free-entropy-additivity"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`L\ge1`),
        " について",
      ]),
      displayMath(String.raw`\Phi_L(1)=L^2\,\ell_2\ \in\ \Lambda`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\Phi_L`),
        " は ",
        ref("def_finite_free_entropy"),
        "、",
        math(String.raw`\ell_2`),
        " は ",
        ref("def_log_order_group"),
        " の素数 ",
        math(String.raw`2`),
        " に対する生成元）。",
      ]),
      paragraph([
        math(String.raw`x`),
        " に ",
        math(String.raw`1`),
        " を代入することは、破れボンドの本数によらずすべての配位を重み ",
        math(String.raw`1`),
        " で数えることにあたる。",
        "この点での自由エントロピーは配位の総数の対数に一致する、というのがこの主張の内容である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\Phi_L(1)
&=\log Z_L(1)
&&(\because\ \blkref{def_finite_free_entropy}\text{、}1\in\mathbb{Q}_{>0})\\
&=\log\Bigl(\sum_{m=0}^{2L^2}\Omega_L(m)\cdot1^{\,m}\Bigr)
&&(\because\ \blkref{claim_coefficient_representation}\text{、代入は環準同型})\\
&=\log\Bigl(\sum_{m=0}^{2L^2}\Omega_L(m)\Bigr)
&&(\because\ 1^{\,m}=1)\\
&=\log\bigl(2^{L^2}\bigr)
&&(\because\ \blkref{claim_coefficient_sum})\\
&=L^2\,\log 2
&&(\because\ \blkref{claim_log_power}\text{、}2\in\mathbb{Q}_{>0},\ L^2\in\mathbb{N})\\
&=L^2\sum_{p:\ w_p(2)\ne0}w_p(2)\,\ell_p
&&(\because\ \blkref{def_rational_log})\\
&=L^2\sum_{p:\ v_p(2)\ne0}v_p(2)\,\ell_p
&&(\because\ w_p(2)=v_p(2)-v_p(1),\ v_p(1)=0)\\
&=L^2\,\ell_2
&&(\because\ 2\text{ は素数なので }v_2(2)=1,\ p\ne2\ \Rightarrow\ v_p(2)=0)
\end{aligned}`),
      paragraph([
        "以上は有限和の数え上げ、整数の演算、素因数分解だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_heading",
    kind: "heading",
    level: 1,
    title: { text: "転送行列" },
    labels: [],
  },

  {
    id: "transfer_matrix_definition_row_configuration",
    kind: "definition",
    title: { text: "行配位と、配位の行への制限" },
    labels: ["def_row_configuration", "def_row_restriction"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.RowConfig",
      "Ising2DLambda.TransferMatrix.card_rowConfig",
      "Ising2DLambda.TransferMatrix.rowRestriction",
    ],
    statement: [
      paragraph([
        ref("def_lattice"),
        " の格子を固定する。行配位とは写像 ",
        math(String.raw`\tau:\mathbb{Z}/L\mathbb{Z}\to\{+1,-1\}`),
        " のことである。行配位全体の集合を",
      ]),
      displayMath(
        String.raw`R_L:=\bigl\{\,\tau \;\bigm|\; \tau\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{から}\ \{+1,-1\}\ \text{への写像}\,\bigr\}`,
      ),
      paragraph([
        "と書く（",
        ref("def_configuration"),
        " と同じく、写像全体の集合を冪の記法では書かない）。",
        math(String.raw`R_L`),
        " は有限集合で ",
        math(String.raw`|R_L|=2^{L}`),
        " である（",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の元の個数が ",
        math(String.raw`L`),
        " で、その各元に独立に 2 通りの値を割り当てるため）。",
      ]),
      paragraph([
        "次に、行番号 ",
        math(String.raw`i\in\mathbb{Z}/L\mathbb{Z}`),
        " ごとに、配位をその行へ制限する写像 ",
        math(String.raw`\rho_i:\Sigma_L\to R_L`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(\rho_i(\sigma)\bigr)(j):=\sigma\bigl((i,j)\bigr)\qquad(\sigma\in\Sigma_L,\ j\in\mathbb{Z}/L\mathbb{Z})`,
      ),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`(i,j)`),
        " は ",
        ref("def_lattice"),
        " の頂点であり、第 1 成分が行番号、第 2 成分が列番号である。",
        math(String.raw`\rho_i(\sigma)`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " から ",
        math(String.raw`\{+1,-1\}`),
        " への写像なので ",
        math(String.raw`R_L`),
        " の元である。",
      ]),
      paragraph([
        "記号について 1 点を約束する。行への制限を ",
        math(String.raw`\sigma_i`),
        " とは書かず、つねに ",
        math(String.raw`\rho_i(\sigma)`),
        " と書く。",
        math(String.raw`\sigma`),
        " は格子全体の配位（",
        math(String.raw`\Sigma_L`),
        " の元）を表す記号として固定してあり、添字を付けた形に別の意味を持たせないためである。",
        math(String.raw`\tau`),
        " は 1 行分の配位（",
        math(String.raw`R_L`),
        " の元）を表す記号として使う。",
      ]),
      paragraph([
        "この定義に現れる対象はすべて有限集合とその上の写像であり、実数体も複素数体も使っていない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_row_broken_counts",
    kind: "definition",
    title: { text: "行内破れ数と行間破れ数" },
    labels: ["def_intra_row_broken_count", "def_inter_row_broken_count"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.intraRowBrokenCount",
      "Ising2DLambda.TransferMatrix.interRowBrokenCount",
      "Ising2DLambda.TransferMatrix.intraRowBrokenCount_le",
      "Ising2DLambda.TransferMatrix.interRowBrokenCount_le",
    ],
    statement: [
      paragraph([
        ref("def_row_configuration"),
        " の行配位 ",
        math(String.raw`\tau\in R_L`),
        " に対し、行内破れ数 ",
        math(String.raw`b_{\mathrm{h}}(\tau)`),
        " を",
      ]),
      displayMath(
        String.raw`b_{\mathrm{h}}(\tau):=\bigl|\bigl\{\,j\in\mathbb{Z}/L\mathbb{Z} \;\bigm|\; \tau(j)\ne\tau(j+_{\mathbb{Z}/L\mathbb{Z}}\bar1)\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`+_{\mathbb{Z}/L\mathbb{Z}}`),
        " と ",
        math(String.raw`\bar1`),
        " は ",
        ref("def_lattice"),
        " の ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の加法と ",
        math(String.raw`\pi(1)`),
        " である）。また 2 つの行配位 ",
        math(String.raw`\tau,\tau'\in R_L`),
        " に対し、行間破れ数 ",
        math(String.raw`b_{\mathrm{v}}(\tau,\tau')`),
        " を",
      ]),
      displayMath(
        String.raw`b_{\mathrm{v}}(\tau,\tau'):=\bigl|\bigl\{\,j\in\mathbb{Z}/L\mathbb{Z} \;\bigm|\; \tau(j)\ne\tau'(j)\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める。どちらも有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の部分集合の元の個数なので ",
        math(String.raw`\mathbb{N}`),
        " の元であり、",
        math(String.raw`0\le b_{\mathrm{h}}(\tau)\le L`),
        "、",
        math(String.raw`0\le b_{\mathrm{v}}(\tau,\tau')\le L`),
        " が成り立つ。",
      ]),
      paragraph([
        "添字の ",
        math(String.raw`\mathrm{h}`),
        " と ",
        math(String.raw`\mathrm{v}`),
        " は ",
        ref("def_lattice"),
        " の横向きの辺の集合 ",
        math(String.raw`E_{L,\mathrm{h}}`),
        " と縦向きの辺の集合 ",
        math(String.raw`E_{L,\mathrm{v}}`),
        " と同じ意味で使っている。横向きの辺は同じ行の中を結び、縦向きの辺は隣り合う 2 行の間を結ぶからである。",
      ]),
      paragraph([
        "定義域が異なる 3 つの別の写像であることを明示しておく。",
        ref("def_broken_bond_count"),
        " の ",
        math(String.raw`b`),
        " は ",
        math(String.raw`\Sigma_L`),
        " 上の写像、",
        math(String.raw`b_{\mathrm{h}}`),
        " は ",
        math(String.raw`R_L`),
        " 上の写像、",
        math(String.raw`b_{\mathrm{v}}`),
        " は ",
        math(String.raw`R_L`),
        " の 2 つ組の上の写像である。同じ文字 ",
        math(String.raw`b`),
        " を使っているのは、下で示すとおりこれらが 1 つの等式で結ばれるからであって、",
        "同じ写像だからではない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_edge_row_partition",
    kind: "claim",
    title: { text: "辺の集合は行ごとに分割される" },
    labels: ["claim_edge_row_partition"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.edgeOfRow",
      "Ising2DLambda.TransferMatrix.edgeOfSum_injective",
      "Ising2DLambda.TransferMatrix.edgeEquiv",
      "Ising2DLambda.TransferMatrix.edgeOfRow_boundary0",
      "Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_horizontal",
      "Ising2DLambda.TransferMatrix.edgeOfRow_boundary1_vertical",
    ],
    verification: ["sagemath/check/transfer-matrix-row-decomposition"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`i\in\mathbb{Z}/L\mathbb{Z}`),
        " に対し、第 ",
        math(String.raw`i`),
        " 行の辺の番号の集合を",
      ]),
      displayMath(
        String.raw`E_{L,\mathrm{h},i}:=\bigl\{\,n_{\mathrm{h}}(i,j) \;\bigm|\; j\in\mathbb{Z}/L\mathbb{Z}\,\bigr\},\qquad
E_{L,\mathrm{v},i}:=\bigl\{\,n_{\mathrm{v}}(i,j) \;\bigm|\; j\in\mathbb{Z}/L\mathbb{Z}\,\bigr\}`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`n_{\mathrm{h}},n_{\mathrm{v}}`),
        " は ",
        ref("def_lattice"),
        "）。このとき次の 5 つが成り立つ。",
      ]),
      list([
        [
          math(String.raw`n_{\mathrm{h}}:V_L\to E_{L,\mathrm{h}}`),
          " と ",
          math(String.raw`n_{\mathrm{v}}:V_L\to E_{L,\mathrm{v}}`),
          " は全単射である。とくに各 ",
          math(String.raw`i`),
          " について ",
          math(String.raw`j\mapsto n_{\mathrm{h}}(i,j)`),
          " は ",
          math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
          " から ",
          math(String.raw`E_{L,\mathrm{h},i}`),
          " への全単射であり、",
          math(String.raw`j\mapsto n_{\mathrm{v}}(i,j)`),
          " は ",
          math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
          " から ",
          math(String.raw`E_{L,\mathrm{v},i}`),
          " への全単射である。",
        ],
        [
          "各 ",
          math(String.raw`i`),
          " について ",
          math(String.raw`|E_{L,\mathrm{h},i}|=L`),
          " かつ ",
          math(String.raw`|E_{L,\mathrm{v},i}|=L`),
          " である。",
        ],
        [
          math(String.raw`i\ne i'`),
          " ならば ",
          math(String.raw`E_{L,\mathrm{h},i}\cap E_{L,\mathrm{h},i'}=\varnothing`),
          " かつ ",
          math(String.raw`E_{L,\mathrm{v},i}\cap E_{L,\mathrm{v},i'}=\varnothing`),
          " である。",
        ],
        [
          math(String.raw`E_{L,\mathrm{h}}=\bigcup_{i\in\mathbb{Z}/L\mathbb{Z}}E_{L,\mathrm{h},i}`),
          " かつ ",
          math(String.raw`E_{L,\mathrm{v}}=\bigcup_{i\in\mathbb{Z}/L\mathbb{Z}}E_{L,\mathrm{v},i}`),
          " である。",
        ],
        [
          "端点は番号から直接読める。すなわち ",
          math(String.raw`(i,j)\in V_L`),
          " に対し",
          math(String.raw`\ \partial_0\bigl(n_{\mathrm{h}}(i,j)\bigr)=(i,j)`),
          "、",
          math(String.raw`\partial_1\bigl(n_{\mathrm{h}}(i,j)\bigr)=(i,\ j+_{\mathbb{Z}/L\mathbb{Z}}\bar1)`),
          "、",
          math(String.raw`\partial_0\bigl(n_{\mathrm{v}}(i,j)\bigr)=(i,j)`),
          "、",
          math(String.raw`\partial_1\bigl(n_{\mathrm{v}}(i,j)\bigr)=(i+_{\mathbb{Z}/L\mathbb{Z}}\bar1,\ j)`),
          " である。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "準備として、代表を取る写像 ",
        math(String.raw`s`),
        "（",
        ref("def_lattice"),
        "）は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " から ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " への全単射である。実際 ",
        math(String.raw`\pi\circ s=\mathrm{id}`),
        " なので単射であり、",
        math(String.raw`a\in\{0,1,\dots,L-1\}`),
        " に対し ",
        math(String.raw`s(\pi(a))=a`),
        " なので全射である（",
        math(String.raw`s(\pi(a))`),
        " と ",
        math(String.raw`a`),
        " はどちらも ",
        math(String.raw`\pi(a)`),
        " の代表であり、代表は一意）。",
      ]),
      paragraph([
        "また除法の原理により、写像 ",
        math(String.raw`(a,b)\mapsto La+b`),
        " は ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の 2 つ組全体から ",
        math(String.raw`\{0,1,\dots,L^2-1\}`),
        " への全単射である。",
      ]),
      paragraph(["1 つめ。合成として"]),
      displayMath(String.raw`\begin{aligned}
n_{\mathrm{h}}
&=\bigl((i,j)\mapsto L\cdot s(i)+s(j)+1\bigr)
&&(\because\ n_{\mathrm{h}}\ \text{の定義})\\
&=(k\mapsto k+1)\circ\bigl((a,b)\mapsto La+b\bigr)\circ(s\times s)
&&(\because\ \text{写像の合成の定義})
\end{aligned}`),
      paragraph([
        "であり、右辺の 3 つはいずれも全単射である（",
        math(String.raw`s\times s`),
        " は上の準備、真ん中は除法の原理、",
        math(String.raw`k\mapsto k+1`),
        " は ",
        math(String.raw`\{0,\dots,L^2-1\}`),
        " から ",
        math(String.raw`E_{L,\mathrm{h}}=\{1,\dots,L^2\}`),
        " への全単射）。全単射の合成は全単射なので ",
        math(String.raw`n_{\mathrm{h}}:V_L\to E_{L,\mathrm{h}}`),
        " は全単射である。",
        math(String.raw`n_{\mathrm{v}}`),
        " は最後の写像を ",
        math(String.raw`k\mapsto L^2+k+1`),
        " に取り替えただけなので同じ議論が通る。",
        math(String.raw`i`),
        " を固定した制限も、単射写像の制限として単射であり、像への写像として全射である。",
      ]),
      paragraph([
        "2 つめ。全単射で写り合う有限集合の個数は等しく、",
        math(String.raw`|\mathbb{Z}/L\mathbb{Z}|=L`),
        " である。",
      ]),
      paragraph([
        "3 つめ。",
        math(String.raw`e\in E_{L,\mathrm{h},i}\cap E_{L,\mathrm{h},i'}`),
        " があれば ",
        math(String.raw`e=n_{\mathrm{h}}(i,j)=n_{\mathrm{h}}(i',j')`),
        " を満たす ",
        math(String.raw`j,j'`),
        " が取れる。1 つめの単射性より ",
        math(String.raw`(i,j)=(i',j')`),
        " となり ",
        math(String.raw`i=i'`),
        " である。対偶を取れば主張を得る。縦向きも同様である。",
      ]),
      paragraph([
        "4 つめ。1 つめの全射性より、任意の ",
        math(String.raw`e\in E_{L,\mathrm{h}}`),
        " は ",
        math(String.raw`e=n_{\mathrm{h}}(i,j)`),
        " と書けるので ",
        math(String.raw`e\in E_{L,\mathrm{h},i}`),
        " である。逆の包含は各 ",
        math(String.raw`E_{L,\mathrm{h},i}`),
        " が ",
        math(String.raw`n_{\mathrm{h}}`),
        " の像の部分集合であることによる。縦向きも同様である。",
      ]),
      paragraph([
        "5 つめ。",
        ref("def_lattice"),
        " は ",
        math(String.raw`\partial_0,\partial_1`),
        " を「",
        math(String.raw`e=n_{\mathrm{h}}(i,j)`),
        " を満たす唯一の ",
        math(String.raw`(i,j)`),
        "」を使って定めており、1 つめによりその ",
        math(String.raw`(i,j)`),
        " が実際に唯一存在する。したがって主張は定義そのものである。",
      ]),
      paragraph([
        "以上の各ステップは整数の大小比較と除法の原理、有限集合の数え上げだけからなり、",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_broken_bond_row_decomposition",
    kind: "claim",
    title: { text: "破れボンド数は行内の破れと行間の破れに分かれる" },
    labels: ["claim_broken_bond_row_decomposition"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.brokenBondCount_eq_row_decomposition",
      "Ising2DLambda.TransferMatrix.brokenBondCount_eq_row_decomposition_from_necSuf",
      "Ising2DLambda.NecSuf.TransferMatrix.card_filter_eq_sum_add_sum",
    ],
    verification: ["sagemath/check/transfer-matrix-row-decomposition"],
    statement: [
      paragraph([
        "任意の配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について",
      ]),
      displayMath(
        String.raw`b(\sigma)=\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
+\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`b`),
        " は ",
        ref("def_broken_bond_count"),
        "、",
        math(String.raw`b_{\mathrm{h}}`),
        " と ",
        math(String.raw`b_{\mathrm{v}}`),
        " は ",
        ref("def_intra_row_broken_count"),
        "、",
        math(String.raw`\rho_i`),
        " は ",
        ref("def_row_restriction"),
        "）。",
      ]),
      paragraph([
        "和の添字 ",
        math(String.raw`i`),
        " は整数として ",
        math(String.raw`0`),
        " から ",
        math(String.raw`L-1`),
        " まで動かし、",
        math(String.raw`\rho`),
        " の添字（行番号）としてはその剰余類を用いる（",
        ref("def_lattice"),
        " の約束）。",
        math(String.raw`\rho_{i+1}`),
        " の ",
        math(String.raw`i+1`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中で 1 を足したものであり、",
        math(String.raw`i=L-1`),
        " のときは ",
        math(String.raw`\rho_0`),
        " になる（周期境界条件）。",
      ]),
      paragraph([
        "右辺の第 1 の和が同じ行の中の破れ、第 2 の和が隣り合う 2 行の間の破れである。",
        "両辺とも ",
        math(String.raw`\mathbb{N}`),
        " の元であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " を固定する。この証明の中だけで使う記号として、破れている辺の番号の集合を",
      ]),
      displayMath(String.raw`\begin{aligned}
B(\sigma)&:=\bigl\{\,e\in E_L \;\bigm|\; \sigma(\partial_0(e))\ne\sigma(\partial_1(e))\,\bigr\}\\[2pt]
b(\sigma)&=|B(\sigma)|
&&(\because\ \blkref{def_broken_bond_count})
\end{aligned}`),
      paragraph([
        "と置く。あわせて、各 ",
        math(String.raw`i\in\mathbb{Z}/L\mathbb{Z}`),
        " について次の 2 つを準備する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|B(\sigma)\cap E_{L,\mathrm{h},i}\bigr|
&=\bigl|\bigl\{\,j\in\mathbb{Z}/L\mathbb{Z} \;\bigm|\; n_{\mathrm{h}}(i,j)\in B(\sigma)\,\bigr\}\bigr|
&&(\because\ j\mapsto n_{\mathrm{h}}(i,j)\ \text{が}\ E_{L,\mathrm{h},i}\ \text{への全単射})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \sigma\bigl((i,j)\bigr)\ne\sigma\bigl((i,\ j+_{\mathbb{Z}/L\mathbb{Z}}\bar1)\bigr)\,\bigr\}\bigr|
&&(\because\ \blkref{claim_edge_row_partition}\text{（端点の式）})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \bigl(\rho_i(\sigma)\bigr)(j)\ne\bigl(\rho_i(\sigma)\bigr)(j+_{\mathbb{Z}/L\mathbb{Z}}\bar1)\,\bigr\}\bigr|
&&(\because\ \blkref{def_row_restriction})\\
&=b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
&&(\because\ \blkref{def_intra_row_broken_count})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl|B(\sigma)\cap E_{L,\mathrm{v},i}\bigr|
&=\bigl|\bigl\{\,j\in\mathbb{Z}/L\mathbb{Z} \;\bigm|\; n_{\mathrm{v}}(i,j)\in B(\sigma)\,\bigr\}\bigr|
&&(\because\ j\mapsto n_{\mathrm{v}}(i,j)\ \text{が}\ E_{L,\mathrm{v},i}\ \text{への全単射})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \sigma\bigl((i,j)\bigr)\ne\sigma\bigl((i+_{\mathbb{Z}/L\mathbb{Z}}\bar1,\ j)\bigr)\,\bigr\}\bigr|
&&(\because\ \blkref{claim_edge_row_partition}\text{（端点の式）})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \bigl(\rho_i(\sigma)\bigr)(j)\ne\bigl(\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)\bigr)(j)\,\bigr\}\bigr|
&&(\because\ \blkref{def_row_restriction})\\
&=b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)\bigr)
&&(\because\ \blkref{def_inter_row_broken_count})
\end{aligned}`),
      paragraph(["準備したものを使うと"]),
      displayMath(String.raw`\begin{aligned}
b(\sigma)
&=|B(\sigma)|
&&(\because\ \text{上の準備})\\
&=\bigl|B(\sigma)\cap E_{L,\mathrm{h}}\bigr|+\bigl|B(\sigma)\cap E_{L,\mathrm{v}}\bigr|
&&(\because\ E_L=E_{L,\mathrm{h}}\cup E_{L,\mathrm{v}}\ \text{は互いに素な合併})\\
&=\sum_{i\in\mathbb{Z}/L\mathbb{Z}}\bigl|B(\sigma)\cap E_{L,\mathrm{h},i}\bigr|
+\sum_{i\in\mathbb{Z}/L\mathbb{Z}}\bigl|B(\sigma)\cap E_{L,\mathrm{v},i}\bigr|
&&(\because\ \blkref{claim_edge_row_partition})\\
&=\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
+\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)\bigr)
&&(\because\ \text{上の準備})
\end{aligned}`),
      paragraph([
        "を得る。互いに素な有限集合の合併の元の個数がそれぞれの個数の和であることを、",
        "2 行目と 3 行目で使っている。",
      ]),
      paragraph([
        "以上は有限集合の数え上げと整数の演算だけからなり、実数体も複素数体も現れない。",
        "この分解が転送行列を作る足場になる。第 1 の和は行ごとに閉じており、",
        "第 2 の和は隣り合う 2 行だけを結ぶからである。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_row_family",
    kind: "definition",
    title: { text: "行配位の族と、配位を行の並びとして読む写像" },
    labels: ["def_row_family", "def_rows_map"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.RowFamily",
      "Ising2DLambda.TransferMatrix.rowsOf",
      "Ising2DLambda.TransferMatrix.configOfRows",
    ],
    statement: [
      paragraph([
        ref("def_row_configuration"),
        " の行配位を並べたものを扱う。行配位の族とは写像 ",
        math(String.raw`c:\mathbb{Z}/L\mathbb{Z}\to R_L`),
        " のことであり、その全体の集合を",
      ]),
      displayMath(
        String.raw`C_L:=\bigl\{\,c \;\bigm|\; c\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{から}\ R_L\ \text{への写像}\,\bigr\}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`c(i)\in R_L`),
        " が第 ",
        math(String.raw`i`),
        " 行の配位を表す。",
      ]),
      paragraph([
        "配位をその行の並びとして読む写像 ",
        math(String.raw`\mathrm{rows}:\Sigma_L\to C_L`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(\mathrm{rows}(\sigma)\bigr)(i):=\rho_i(\sigma)\qquad(\sigma\in\Sigma_L,\ i\in\mathbb{Z}/L\mathbb{Z})`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`\rho_i`),
        " は ",
        ref("def_row_restriction"),
        "）。逆向きに、行配位の族から配位を作る写像 ",
        math(String.raw`\mathrm{conf}:C_L\to\Sigma_L`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(\mathrm{conf}(c)\bigr)\bigl((i,j)\bigr):=\bigl(c(i)\bigr)(j)\qquad(c\in C_L,\ (i,j)\in V_L)`,
      ),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`\{+1,-1\}`),
        " の元なので ",
        math(String.raw`\mathrm{conf}(c)`),
        " は ",
        math(String.raw`V_L`),
        " から ",
        math(String.raw`\{+1,-1\}`),
        " への写像であり、",
        ref("def_configuration"),
        " により ",
        math(String.raw`\Sigma_L`),
        " の元である。",
      ]),
      paragraph([
        math(String.raw`C_L`),
        " は有限集合で ",
        math(String.raw`|C_L|=\bigl(2^{L}\bigr)^{L}=2^{L^2}`),
        " である（",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の ",
        math(String.raw`L`),
        " 個の元それぞれに ",
        math(String.raw`R_L`),
        " の ",
        math(String.raw`2^{L}`),
        " 通りを独立に割り当てるため）。ここに現れる対象はすべて有限集合とその上の写像である。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_matrix_over_row_configs",
    kind: "definition",
    title: { text: "行配位を添字とする行列と、その積・冪・トレース" },
    labels: ["def_matrix_over_row_configs", "def_matrix_product", "def_matrix_trace"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.TransferMatrix.RowMatrix",
      "Ising2DLambda.TransferMatrix.rowMatrixProduct",
      "Ising2DLambda.TransferMatrix.rowMatrixPow",
      "Ising2DLambda.TransferMatrix.rowMatrixTrace",
    ],
    statement: [
      paragraph([
        "行と列を ",
        ref("def_row_configuration"),
        " の行配位で添字づけた行列を扱う。写像 ",
        math(String.raw`A:R_L\times R_L\to\mathbb{Z}[x]`),
        " のことを行列と呼び、その全体の集合を ",
        math(String.raw`\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        " と書く。値 ",
        math(String.raw`A(\tau,\tau')`),
        " を成分と呼び ",
        math(String.raw`A_{\tau,\tau'}`),
        " と書く。",
      ]),
      paragraph([
        math(String.raw`R_L`),
        " は ",
        math(String.raw`2^{L}`),
        " 個の元をもつ有限集合なので、その元に ",
        math(String.raw`1`),
        " から ",
        math(String.raw`2^{L}`),
        " までの番号を付ければ、この集合は通常の ",
        math(String.raw`2^{L}`),
        " 次正方行列の集合 ",
        math(String.raw`M_{2^{L}}\bigl(\mathbb{Z}[x]\bigr)`),
        " と同じものになる。以下では番号を付けず、添字を行配位のまま扱う",
        "（番号の付け方に依存しない形で書くため）。",
      ]),
      paragraph([
        "積・冪・トレースを次で定める。",
        math(String.raw`A,B\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " に対し積 ",
        math(String.raw`AB`),
        " を",
      ]),
      displayMath(
        String.raw`(AB)_{\tau,\tau''}:=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,B_{\tau',\tau''}\qquad(\tau,\tau''\in R_L)`,
      ),
      paragraph([
        "で定める（有限個の項の和なので右辺は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として確定する）。整数 ",
        math(String.raw`k\ge1`),
        " に対し冪 ",
        math(String.raw`A^{k}`),
        " を、",
        math(String.raw`A^{1}:=A`),
        " と ",
        math(String.raw`A^{k+1}:=A^{k}A`),
        " により帰納的に定める。トレース ",
        math(String.raw`\operatorname{Tr}A\in\mathbb{Z}[x]`),
        " を",
      ]),
      displayMath(String.raw`\operatorname{Tr}A:=\sum_{\tau\in R_L}A_{\tau,\tau}`),
      paragraph([
        "で定める。以上の演算はすべて ",
        math(String.raw`\mathbb{Z}[x]`),
        " の有限個の元の和と積だけを使っており、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_transfer_matrix",
    kind: "definition",
    title: { text: "転送行列" },
    labels: ["def_transfer_matrix"],
    habitat: "Z",
    lean: ["Ising2DLambda.TransferMatrix.transferMatrix"],
    statement: [
      paragraph([
        "転送行列 ",
        math(String.raw`T\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        " を、その成分により",
      ]),
      displayMath(
        String.raw`T_{\tau,\tau'}:=x^{\,b_{\mathrm{h}}(\tau)+b_{\mathrm{v}}(\tau,\tau')}\qquad(\tau,\tau'\in R_L)`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`b_{\mathrm{h}}`),
        " と ",
        math(String.raw`b_{\mathrm{v}}`),
        " は ",
        ref("def_intra_row_broken_count"),
        "、行列の集合は ",
        ref("def_matrix_over_row_configs"),
        "）。指数は ",
        math(String.raw`\mathbb{N}`),
        " の元なので、各成分は不定元 ",
        math(String.raw`x`),
        " の冪であり ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元である。",
      ]),
      paragraph([
        "この定義には代入が現れない。姉妹プロジェクトのように指数関数 ",
        math(String.raw`e^{K\sigma\sigma'}`),
        " の形を経由すると、その時点で実数体を呼ぶことになる。ここでは行内・行間の破れの本数という",
        "数え上げの量だけを指数に置いており、",
        ref("def_partition_polynomial"),
        " と同じく形式変数のまま進む（README「形式変数のまま進む」）。",
      ]),
      paragraph([
        "成分の指数が ",
        math(String.raw`b_{\mathrm{h}}(\tau)`),
        " と ",
        math(String.raw`b_{\mathrm{v}}(\tau,\tau')`),
        " の和になっているのは、",
        ref("claim_broken_bond_row_decomposition"),
        " の分解に合わせたためである。第 1 項が第 ",
        math(String.raw`i`),
        " 行の中の破れ、第 2 項が第 ",
        math(String.raw`i`),
        " 行と第 ",
        math(String.raw`i+1`),
        " 行の間の破れを担う。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_rows_bijection",
    kind: "claim",
    title: { text: "配位全体と行配位の族全体は 1 対 1 に対応する" },
    labels: ["claim_rows_bijection"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.rowsEquiv",
      "Ising2DLambda.TransferMatrix.configOfRows_rowsOf",
      "Ising2DLambda.TransferMatrix.rowsOf_configOfRows",
      "Ising2DLambda.NecSuf.TransferMatrix.uncurryEquiv",
    ],
    verification: ["sagemath/check/transfer-matrix-trace-formula"],
    statement: [
      paragraph([
        ref("def_rows_map"),
        " の写像 ",
        math(String.raw`\mathrm{rows}:\Sigma_L\to C_L`),
        " は全単射であり、その逆写像は ",
        math(String.raw`\mathrm{conf}:C_L\to\Sigma_L`),
        " である。",
      ]),
      paragraph([
        "すなわち、配位を与えることと、各行の行配位を独立に与えることは同じことである。",
        "両辺の集合はどちらも有限集合であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        "、行配位の族 ",
        math(String.raw`c\in C_L`),
        "、頂点 ",
        math(String.raw`(i,j)\in V_L`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\mathrm{conf}\bigl(\mathrm{rows}(\sigma)\bigr)\Bigr)\bigl((i,j)\bigr)
&=\Bigl(\bigl(\mathrm{rows}(\sigma)\bigr)(i)\Bigr)(j)
&&(\because\ \mathrm{conf}\ \text{の定義})\\
&=\bigl(\rho_i(\sigma)\bigr)(j)
&&(\because\ \mathrm{rows}\ \text{の定義})\\
&=\sigma\bigl((i,j)\bigr)
&&(\because\ \blkref{def_row_restriction})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Bigl(\bigl(\mathrm{rows}(\mathrm{conf}(c))\bigr)(i)\Bigr)(j)
&=\bigl(\rho_i(\mathrm{conf}(c))\bigr)(j)
&&(\because\ \mathrm{rows}\ \text{の定義})\\
&=\bigl(\mathrm{conf}(c)\bigr)\bigl((i,j)\bigr)
&&(\because\ \blkref{def_row_restriction})\\
&=\bigl(c(i)\bigr)(j)
&&(\because\ \mathrm{conf}\ \text{の定義})
\end{aligned}`),
      paragraph([
        math(String.raw`(i,j)`),
        " は任意だったので、写像として ",
        math(String.raw`\mathrm{conf}\circ\mathrm{rows}=\mathrm{id}`),
        " かつ ",
        math(String.raw`\mathrm{rows}\circ\mathrm{conf}=\mathrm{id}`),
        " である。したがって ",
        math(String.raw`\mathrm{rows}`),
        " は ",
        math(String.raw`\mathrm{conf}`),
        " を逆写像に持ち、逆写像を持つ写像は全単射である。",
      ]),
      paragraph([
        "以上は写像の値の計算だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_weight_product",
    kind: "claim",
    title: { text: "配位の重みは、行に沿った転送行列の成分の積である" },
    labels: ["claim_transfer_weight_product"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.TransferMatrix.transfer_weight_product",
      "Ising2DLambda.TransferMatrix.transfer_weight_product_from_necSuf",
      "Ising2DLambda.NecSuf.TransferMatrix.prod_pow_add_eq_pow",
    ],
    verification: ["sagemath/check/transfer-matrix-trace-formula"],
    statement: [
      paragraph([
        "任意の配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について、",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で",
      ]),
      displayMath(
        String.raw`\prod_{i\in\mathbb{Z}/L\mathbb{Z}}T_{\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)}=x^{\,b(\sigma)}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T`),
        " は ",
        ref("def_transfer_matrix"),
        "、",
        math(String.raw`\rho_i`),
        " は ",
        ref("def_row_restriction"),
        "、",
        math(String.raw`b`),
        " は ",
        ref("def_broken_bond_count"),
        "）。",
      ]),
      paragraph([
        "積の添字 ",
        math(String.raw`i`),
        " は整数として ",
        math(String.raw`0`),
        " から ",
        math(String.raw`L-1`),
        " まで動かし、",
        math(String.raw`\rho`),
        " の添字（行番号）としてはその剰余類を用いる（",
        ref("claim_broken_bond_row_decomposition"),
        " と同じ約束）。",
        math(String.raw`\mathbb{Z}[x]`),
        " は可換環なので、積の順序は結果に影響しない。",
      ]),
      paragraph([
        "右辺は ",
        ref("def_partition_polynomial"),
        " の分配多項式の和の各項そのものである。すなわちこの主張は、",
        "分配多項式の 1 つの項が、転送行列の成分を行に沿って掛けたものとして得られることを述べている。",
      ]),
    ],
    proof: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " を固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{i\in\mathbb{Z}/L\mathbb{Z}}T_{\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)}
&=\prod_{i=0}^{L-1}x^{\,b_{\mathrm{h}}(\rho_i(\sigma))+b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma))}
&&(\because\ \blkref{def_transfer_matrix})\\
&=x^{\,\sum_{i\in\mathbb{Z}/L\mathbb{Z}}\bigl(b_{\mathrm{h}}(\rho_i(\sigma))+b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma))\bigr)}
&&(\because\ x^{a}x^{a'}=x^{a+a'}\ \text{を}\ L-1\ \text{回})\\
&=x^{\,\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{h}}(\rho_i(\sigma))
+\sum_{i\in\mathbb{Z}/L\mathbb{Z}}b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma))}
&&(\because\ \text{有限個の自然数の和は項ごとに分けられる})\\
&=x^{\,b(\sigma)}
&&(\because\ \blkref{claim_broken_bond_row_decomposition})
\end{aligned}`),
      paragraph([
        "以上は自然数の和と ",
        math(String.raw`\mathbb{Z}[x]`),
        " の積だけからなり、実数体も複素数体も現れない。",
        "残るのは、この積を行配位の族全体にわたって足し上げたものが ",
        math(String.raw`\operatorname{Tr}\bigl(T^{L}\bigr)`),
        " に等しいことであり、それは次の節で示す。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_row_walk",
    kind: "definition",
    title: { text: "行配位の道と、道に沿った成分の積" },
    labels: ["def_row_walk", "def_walk_weight"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.TransferMatrix.RowWalk",
      "Ising2DLambda.TransferMatrix.rowWalksBetween",
      "Ising2DLambda.TransferMatrix.walkWeight",
    ],
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`k\ge1`),
        " を固定する。長さ ",
        math(String.raw`k`),
        " の道とは写像",
      ]),
      displayMath(String.raw`p:\{0,1,\dots,k\}\to R_L`),
      paragraph([
        "のことであり（",
        math(String.raw`R_L`),
        " は ",
        ref("def_row_configuration"),
        "）、その全体の集合を ",
        math(String.raw`W_{L,k}`),
        " と書く。定義域は整数の集合 ",
        math(String.raw`\{0,1,\dots,k\}`),
        " であって剰余類の集合ではない。",
        ref("def_row_family"),
        " の行配位の族 ",
        math(String.raw`c:\mathbb{Z}/L\mathbb{Z}\to R_L`),
        " とは定義域が違う別の対象である（族は ",
        math(String.raw`L`),
        " 個の行を周期的に並べたもの、道は ",
        math(String.raw`k+1`),
        " 個の行配位を一列に並べたものである）。",
      ]),
      paragraph([
        "両端を指定した道の全体を、",
        math(String.raw`\tau,\tau''\in R_L`),
        " に対し",
      ]),
      displayMath(
        String.raw`W_{L,k}(\tau,\tau''):=\bigl\{\,p\in W_{L,k} \;\bigm|\; p(0)=\tau,\ p(k)=\tau''\,\bigr\}`,
      ),
      paragraph([
        "と書く。",
        math(String.raw`W_{L,k}`),
        " は有限集合 ",
        math(String.raw`R_L`),
        " への写像の全体なので有限集合であり、",
        math(String.raw`W_{L,k}(\tau,\tau'')`),
        " はその部分集合なので有限集合である。",
      ]),
      paragraph([
        "行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        "（",
        ref("def_matrix_over_row_configs"),
        "）と道 ",
        math(String.raw`p\in W_{L,k}`),
        " に対し、道に沿った成分の積を",
      ]),
      displayMath(
        String.raw`w_A(p):=\prod_{i=0}^{k-1}A_{p(i),\,p(i+1)}\ \in\ \mathbb{Z}[x]`,
      ),
      paragraph([
        "で定める。積の添字 ",
        math(String.raw`i`),
        " は整数として ",
        math(String.raw`0`),
        " から ",
        math(String.raw`k-1`),
        " まで動かし、",
        math(String.raw`i+1`),
        " も整数の足し算である（剰余は取らない）。因子は ",
        math(String.raw`k`),
        " 個であり、有限個の ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元の積なので右辺は確定する。",
      ]),
      paragraph([
        "記号について。",
        math(String.raw`w_A`),
        " の添字 ",
        math(String.raw`A`),
        " は、どの行列の成分を掛けるかを表す。",
        ref("def_transfer_matrix"),
        " の転送行列 ",
        math(String.raw`T`),
        " について使うときは ",
        math(String.raw`w_T(p)`),
        " と書く。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_matrix_pow_entry",
    kind: "claim",
    title: { text: "行列の冪の成分は、道に沿った成分の積の和である" },
    labels: ["claim_matrix_pow_entry"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.TransferMatrix.rowMatrixPow_apply",
      "Ising2DLambda.TransferMatrix.rowMatrixPow_apply_from_necSuf",
      "Ising2DLambda.NecSuf.TransferMatrix.matPow_apply_eq_sum_walkWeight",
    ],
    verification: ["sagemath/check/transfer-matrix-power-entry"],
    statement: [
      paragraph([
        "任意の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        "、任意の整数 ",
        math(String.raw`k\ge1`),
        "、任意の行配位 ",
        math(String.raw`\tau,\tau''\in R_L`),
        " について、",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で",
      ]),
      displayMath(
        String.raw`\bigl(A^{k}\bigr)_{\tau,\tau''}=\sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)`,
      ),
      paragraph([
        "が成り立つ（冪は ",
        ref("def_matrix_over_row_configs"),
        "、",
        math(String.raw`W_{L,k}(\tau,\tau'')`),
        " と ",
        math(String.raw`w_A`),
        " は ",
        ref("def_row_walk"),
        "）。右辺は有限集合の上の和なので ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として確定する。",
      ]),
      paragraph([
        "両辺とも ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "行列 ",
        math(String.raw`A`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。主張は ",
        math(String.raw`\tau,\tau''`),
        " についての全称命題の形で回す（帰納法の仮定を、後で別の組 ",
        math(String.raw`(\tau,\tau'')`),
        " に対して使うため）。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`k=1`),
        " の場合）。",
        math(String.raw`W_{L,1}(\tau,\tau'')`),
        " の元 ",
        math(String.raw`p`),
        " は定義域 ",
        math(String.raw`\{0,1\}`),
        " 上の写像であって ",
        math(String.raw`p(0)=\tau`),
        " と ",
        math(String.raw`p(1)=\tau''`),
        " を満たすものであり、この 2 つの値で写像が決まるので、",
        math(String.raw`W_{L,1}(\tau,\tau'')=\{p\}`),
        " である。この ",
        math(String.raw`p`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A^{1}\bigr)_{\tau,\tau''}
&=A_{\tau,\tau''}
&&(\because\ \text{行列の冪の定義 }A^{1}=A)\\
&=A_{p(0),\,p(1)}
&&(\because\ p(0)=\tau,\ p(1)=\tau'')\\
&=\prod_{i=0}^{0}A_{p(i),\,p(i+1)}
&&(\because\ \text{因子が }1\text{ 個の積})\\
&=w_A(p)
&&(\because\ \text{道に沿った成分の積の定義})\\
&=\sum_{p'\in W_{L,1}(\tau,\tau'')}w_A(p')
&&(\because\ W_{L,1}(\tau,\tau'')=\{p\})
\end{aligned}`),
      paragraph([
        "帰納法の仮定。ある整数 ",
        math(String.raw`k\ge1`),
        " について、任意の ",
        math(String.raw`\tau,\tau''\in R_L`),
        " で",
      ]),
      displayMath(
        String.raw`\bigl(A^{k}\bigr)_{\tau,\tau''}=\sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)`,
      ),
      paragraph([
        "が成り立つと仮定する。以下、",
        math(String.raw`\tau,\tau'''\in R_L`),
        " を任意に取り、",
        math(String.raw`k+1`),
        " の場合を示す。",
      ]),
      paragraph([
        "道の延長が 1 対 1 対応であること（写像を構成するので一続きの式にはしない）。組の集合",
      ]),
      displayMath(
        String.raw`P:=\bigl\{\,(\tau'',p) \;\bigm|\; \tau''\in R_L,\ p\in W_{L,k}(\tau,\tau'')\,\bigr\}`,
      ),
      paragraph([
        "から ",
        math(String.raw`W_{L,k+1}(\tau,\tau''')`),
        " への写像 ",
        math(String.raw`\Phi`),
        " を、",
        math(String.raw`\Phi(\tau'',p)=q`),
        " が",
      ]),
      displayMath(
        String.raw`q(i):=p(i)\quad(0\le i\le k),\qquad q(k+1):=\tau'''`,
      ),
      paragraph([
        "で与えられる写像 ",
        math(String.raw`q:\{0,1,\dots,k+1\}\to R_L`),
        " であるとして定める。",
        math(String.raw`q(0)=p(0)=\tau`),
        " と ",
        math(String.raw`q(k+1)=\tau'''`),
        " より ",
        math(String.raw`q\in W_{L,k+1}(\tau,\tau''')`),
        " である。逆向きの写像 ",
        math(String.raw`\Psi`),
        " を、",
        math(String.raw`q\in W_{L,k+1}(\tau,\tau''')`),
        " に対し",
      ]),
      displayMath(
        String.raw`\Psi(q):=\bigl(q(k),\ q|_{\{0,1,\dots,k\}}\bigr)`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`q|_{\{0,1,\dots,k\}}`),
        " は定義域を狭めた写像）。狭めた写像は ",
        math(String.raw`0`),
        " で ",
        math(String.raw`\tau`),
        " をとり ",
        math(String.raw`k`),
        " で ",
        math(String.raw`q(k)`),
        " をとるので ",
        math(String.raw`W_{L,k}(\tau,q(k))`),
        " の元であり、",
        math(String.raw`\Psi(q)\in P`),
        " である。",
      ]),
      paragraph([
        "この 2 つが互いに逆であることを見る。",
        math(String.raw`(\tau'',p)\in P`),
        " に対し、",
        math(String.raw`\Phi(\tau'',p)`),
        " の定義域を ",
        math(String.raw`\{0,1,\dots,k\}`),
        " へ狭めたものは ",
        math(String.raw`p`),
        " であり、その ",
        math(String.raw`k`),
        " での値は ",
        math(String.raw`p(k)=\tau''`),
        " なので ",
        math(String.raw`\Psi(\Phi(\tau'',p))=(\tau'',p)`),
        " である。逆に ",
        math(String.raw`q\in W_{L,k+1}(\tau,\tau''')`),
        " に対し、",
        math(String.raw`\Phi(\Psi(q))`),
        " は ",
        math(String.raw`0\le i\le k`),
        " で ",
        math(String.raw`q(i)`),
        " をとり、",
        math(String.raw`k+1`),
        " で ",
        math(String.raw`\tau'''=q(k+1)`),
        " をとるので、写像として ",
        math(String.raw`q`),
        " に等しい。ゆえに ",
        math(String.raw`\Phi`),
        " は全単射である。",
      ]),
      paragraph([
        "対応する項が等しいこと。",
        math(String.raw`(\tau'',p)\in P`),
        " と ",
        math(String.raw`q=\Phi(\tau'',p)`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
w_A(q)
&=\prod_{i=0}^{k}A_{q(i),\,q(i+1)}
&&(\because\ \text{道に沿った成分の積の定義})\\
&=\Bigl(\prod_{i=0}^{k-1}A_{q(i),\,q(i+1)}\Bigr)A_{q(k),\,q(k+1)}
&&(\because\ \text{因子が }k+1\text{ 個あるうちの }i=k\text{ の項を分けた})\\
&=\Bigl(\prod_{i=0}^{k-1}A_{p(i),\,p(i+1)}\Bigr)A_{\tau'',\tau'''}
&&(\because\ 0\le i\le k\ \text{で}\ q(i)=p(i),\ q(k)=p(k)=\tau'',\ q(k+1)=\tau''')\\
&=w_A(p)\,A_{\tau'',\tau'''}
&&(\because\ \text{道に沿った成分の積の定義})
\end{aligned}`),
      paragraph([
        math(String.raw`k+1`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A^{k+1}\bigr)_{\tau,\tau'''}
&=\sum_{\tau''\in R_L}\bigl(A^{k}\bigr)_{\tau,\tau''}\,A_{\tau'',\tau'''}
&&(\because\ \text{行列の冪の定義 }A^{k+1}=A^{k}A\text{ と行列の積の定義})\\
&=\sum_{\tau''\in R_L}\Bigl(\sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)\Bigr)A_{\tau'',\tau'''}
&&(\because\ \text{帰納法の仮定を各 }\tau''\in R_L\text{ について使った})\\
&=\sum_{\tau''\in R_L}\ \sum_{p\in W_{L,k}(\tau,\tau'')}w_A(p)\,A_{\tau'',\tau'''}
&&(\because\ \text{有限和と 1 つの元との積は項ごとの積の和})\\
&=\sum_{(\tau'',p)\in P}w_A(p)\,A_{\tau'',\tau'''}
&&(\because\ \text{二重和を組の集合 }P\text{ の上の 1 つの和として読んだ})\\
&=\sum_{q\in W_{L,k+1}(\tau,\tau''')}w_A(q)
&&(\because\ \Phi\ \text{が全単射で、対応する項が等しい})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau,\tau'''`),
        " は任意だったので ",
        math(String.raw`k+1`),
        " の場合が示され、",
        math(String.raw`k\ge1`),
        " についての帰納法で主張が成り立つ。",
      ]),
      paragraph([
        "以上は有限個の ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元の和と積、および有限集合の間の 1 対 1 対応だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_definition_closed_walk",
    kind: "definition",
    title: { text: "閉じた道と、行配位の族から作る閉じた道" },
    labels: ["def_closed_walk", "def_walk_of_family"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.closedRowWalks",
      "Ising2DLambda.TransferMatrix.walkOfFamily",
      "Ising2DLambda.TransferMatrix.familyOfWalk",
    ],
    statement: [
      paragraph([
        ref("def_row_walk"),
        " の道のうち、長さが格子の一辺 ",
        math(String.raw`L`),
        " に等しく、両端の値が一致するものの全体を",
      ]),
      displayMath(
        String.raw`W^{\mathrm{cl}}_{L}:=\bigl\{\,p\in W_{L,L} \;\bigm|\; p(0)=p(L)\,\bigr\}`,
      ),
      paragraph([
        "と書き、その元を閉じた道と呼ぶ。",
        math(String.raw`L\ge1`),
        " なので ",
        math(String.raw`W_{L,L}`),
        " は定義されており、",
        math(String.raw`W^{\mathrm{cl}}_{L}`),
        " はその部分集合なので有限集合である。",
      ]),
      paragraph([
        "以下、整数から剰余類へ移るときは ",
        ref("def_lattice"),
        " の射影 ",
        math(String.raw`\pi`),
        " を、剰余類から整数へ移るときは同じ定義の代表を取る写像 ",
        math(String.raw`s`),
        " を用いる。この 2 本以外の経路は使わない。",
      ]),
      paragraph([
        ref("def_row_family"),
        " の行配位の族 ",
        math(String.raw`c\in C_L`),
        " から閉じた道を作る写像 ",
        math(String.raw`\Theta:C_L\to W^{\mathrm{cl}}_{L}`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(\Theta(c)\bigr)(i):=c\bigl(\pi(i)\bigr)\qquad(i\in\{0,1,\dots,L\})`,
      ),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`R_L`),
        " の元なので ",
        math(String.raw`\Theta(c)`),
        " は ",
        math(String.raw`W_{L,L}`),
        " の元であり、",
        math(String.raw`\pi(L)=\pi(0)`),
        " より ",
        math(
          String.raw`\bigl(\Theta(c)\bigr)(L)=c\bigl(\pi(0)\bigr)=\bigl(\Theta(c)\bigr)(0)`,
        ),
        " なので閉じている。すなわち右辺は ",
        math(String.raw`W^{\mathrm{cl}}_{L}`),
        " の元である。",
      ]),
      paragraph([
        "逆向きに、閉じた道から行配位の族を作る写像 ",
        math(String.raw`\Xi:W^{\mathrm{cl}}_{L}\to C_L`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(\Xi(p)\bigr)(y):=p\bigl(s(y)\bigr)\qquad(y\in\mathbb{Z}/L\mathbb{Z})`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`s`),
        " は ",
        ref("def_lattice"),
        " の代表を取る写像）。",
        math(String.raw`0\le s(y)\le L-1`),
        " なので右辺は定義され、この式は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " のすべての元に対して値をちょうど 1 つ定めており、右辺は ",
        math(String.raw`R_L`),
        " の元である。したがって ",
        math(String.raw`\Xi(p)`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " から ",
        math(String.raw`R_L`),
        " への写像、すなわち ",
        math(String.raw`C_L`),
        " の元である。",
      ]),
      paragraph([
        "記号について。",
        math(String.raw`\Theta`),
        " と ",
        math(String.raw`\Xi`),
        " が結ぶのは、周期的な添字の上の写像（族）と、一列に並んだ添字の上の写像（道）である。",
        "両者が別の対象であることは ",
        ref("def_row_walk"),
        " で述べたとおりであり、この 2 つの写像はその間の翻訳を担う。",
        "ここに現れる対象はすべて有限集合とその上の写像であり、実数体は現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_claim_closed_walk_bijection",
    kind: "claim",
    title: { text: "行配位の族全体と閉じた道全体は 1 対 1 に対応する" },
    labels: ["claim_closed_walk_bijection"],
    habitat: "N",
    lean: [
      "Ising2DLambda.TransferMatrix.familyOfWalk_walkOfFamily",
      "Ising2DLambda.TransferMatrix.walkOfFamily_familyOfWalk",
      "Ising2DLambda.TransferMatrix.closedWalkEquiv",
    ],
    verification: ["sagemath/check/transfer-matrix-trace"],
    statement: [
      paragraph([
        ref("def_walk_of_family"),
        " の写像 ",
        math(String.raw`\Theta:C_L\to W^{\mathrm{cl}}_{L}`),
        " は全単射であり、その逆写像は ",
        math(String.raw`\Xi`),
        " である。",
      ]),
      paragraph([
        "すなわち、",
        math(String.raw`L`),
        " 個の行を周期的に並べて与えることと、",
        math(String.raw`L+1`),
        " 個の行配位を両端が一致するように一列に並べて与えることは、同じことである。",
        "両辺の集合はどちらも有限集合であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\Xi\circ\Theta`),
        " が恒等写像であること。行配位の族 ",
        math(String.raw`c\in C_L`),
        " と ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の元 ",
        math(String.raw`y`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Xi\bigl(\Theta(c)\bigr)\Bigr)(y)
&=\bigl(\Theta(c)\bigr)\bigl(s(y)\bigr)
&&(\because\ \Xi\ \text{の定義})\\
&=c\Bigl(\pi\bigl(s(y)\bigr)\Bigr)
&&(\because\ \Theta\ \text{の定義})\\
&=c(y)
&&(\because\ s\ \text{の定義（}\pi(s(y))=y\text{）})
\end{aligned}`),
      paragraph([
        "である。取った元は任意だったので、写像として ",
        math(String.raw`\Xi(\Theta(c))=c`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\Theta\circ\Xi`),
        " が恒等写像であること。閉じた道 ",
        math(String.raw`p\in W^{\mathrm{cl}}_{L}`),
        " と ",
        math(String.raw`i\in\{0,1,\dots,L\}`),
        " を任意に取る。",
        math(String.raw`i\le L-1`),
        " か ",
        math(String.raw`i=L`),
        " のいずれかであるから、場合を分ける（この 2 つの場合で ",
        math(String.raw`s\bigl(\pi(i)\bigr)`),
        " が ",
        math(String.raw`i`),
        " に等しいかどうかが違うので、一続きの式にはしない）。",
      ]),
      paragraph([
        math(String.raw`i\le L-1`),
        " の場合。このとき ",
        math(String.raw`0\le i\le L-1`),
        " かつ ",
        math(String.raw`\pi(i)=\pi(i)`),
        " であり、この 2 条件を満たす整数はちょうど 1 つなので（",
        ref("def_lattice"),
        "）",
        math(String.raw`s\bigl(\pi(i)\bigr)=i`),
        " である。ゆえに",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Theta\bigl(\Xi(p)\bigr)\Bigr)(i)
&=\bigl(\Xi(p)\bigr)\bigl(\pi(i)\bigr)
&&(\because\ \Theta\ \text{の定義})\\
&=p\Bigl(s\bigl(\pi(i)\bigr)\Bigr)
&&(\because\ \Xi\ \text{の定義})\\
&=p(i)
&&(\because\ s(\pi(i))=i)
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`i=L`),
        " の場合。このとき ",
        math(String.raw`0\le 0\le L-1`),
        " かつ ",
        math(String.raw`\pi(0)=\pi(0)`),
        " なので、上と同じ理由で ",
        math(String.raw`s\bigl(\pi(0)\bigr)=0`),
        " である。ゆえに",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Theta\bigl(\Xi(p)\bigr)\Bigr)(L)
&=\bigl(\Xi(p)\bigr)\bigl(\pi(L)\bigr)
&&(\because\ \Theta\ \text{の定義})\\
&=\bigl(\Xi(p)\bigr)\bigl(\pi(0)\bigr)
&&(\because\ \pi(L)=\pi(0))\\
&=p\Bigl(s\bigl(\pi(0)\bigr)\Bigr)
&&(\because\ \Xi\ \text{の定義})\\
&=p(0)
&&(\because\ s(\pi(0))=0)\\
&=p(L)
&&(\because\ p\ \text{が閉じた道であること})
\end{aligned}`),
      paragraph([
        "である。どちらの場合も値が一致し、",
        math(String.raw`i`),
        " は任意だったので、写像として ",
        math(String.raw`\Theta(\Xi(p))=p`),
        " である。",
      ]),
      paragraph([
        "結論。以上より ",
        math(String.raw`\Theta`),
        " は ",
        math(String.raw`\Xi`),
        " を逆写像に持つ。逆写像を持つ写像は全単射である。",
        "以上は写像の値の計算と、射影 ",
        math(String.raw`\pi`),
        " と代表を取る写像 ",
        math(String.raw`s`),
        " の性質だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "transfer_matrix_theorem_partition_polynomial_is_trace",
    kind: "theorem",
    title: { text: "分配多項式は転送行列の冪のトレースである" },
    labels: ["theorem_partition_polynomial_is_trace"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.TransferMatrix.partitionPolynomial_eq_trace",
      "Ising2DLambda.TransferMatrix.partitionPolynomial_eq_trace_from_necSuf",
      "Ising2DLambda.NecSuf.TransferMatrix.trace_matPow_eq_sum_cyclicWeight",
    ],
    verification: ["sagemath/check/transfer-matrix-trace"],
    statement: [
      paragraph([
        math(String.raw`\mathbb{Z}[x]`),
        " の中で",
      ]),
      displayMath(String.raw`Z_L=\operatorname{Tr}\bigl(T^{L}\bigr)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`Z_L`),
        " は ",
        ref("def_partition_polynomial"),
        "、",
        math(String.raw`T`),
        " は ",
        ref("def_transfer_matrix"),
        "、冪とトレースは ",
        ref("def_matrix_over_row_configs"),
        "）。",
      ]),
      paragraph([
        "左辺は ",
        math(String.raw`2^{L^2}`),
        " 個の配位にわたる和として定義された多項式であり、右辺は ",
        math(String.raw`2^{L}`),
        " 次の行列の冪の対角成分の和である。両辺とも ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、実数体も複素数体も現れない。",
        "指数関数を経由していないので、この等式には代入も脱出も含まれない。",
      ]),
    ],
    proof: [
      paragraph([
        "先に 2 つの準備を置き、そのあとで ",
        math(String.raw`Z_L`),
        " から始まる 1 つの式変形を書く。",
      ]),
      paragraph([
        "準備（閉じた道の類別）。",
        math(String.raw`\tau\in R_L`),
        " に対し ",
        ref("def_row_walk"),
        " の ",
        math(String.raw`W_{L,L}(\tau,\tau)`),
        " を考える。その元は ",
        math(String.raw`p(0)=\tau=p(L)`),
        " を満たすので ",
        math(String.raw`W^{\mathrm{cl}}_{L}`),
        " に属する。逆に ",
        math(String.raw`p\in W^{\mathrm{cl}}_{L}`),
        " は ",
        math(String.raw`\tau:=p(0)`),
        " と置けば ",
        math(String.raw`p(L)=p(0)=\tau`),
        " なので ",
        math(String.raw`W_{L,L}(\tau,\tau)`),
        " に属する。さらに ",
        math(String.raw`\tau\ne\tau'`),
        " なら ",
        math(String.raw`W_{L,L}(\tau,\tau)`),
        " と ",
        math(String.raw`W_{L,L}(\tau',\tau')`),
        " は互いに素である（両方に属する道は ",
        math(String.raw`\tau=p(0)=\tau'`),
        " を満たすため）。ゆえに ",
        math(String.raw`W^{\mathrm{cl}}_{L}`),
        " は ",
        math(String.raw`\tau`),
        " ごとの ",
        math(String.raw`W_{L,L}(\tau,\tau)`),
        " の互いに素な合併であり、その上の和は各類の上の和の和に等しい。",
      ]),
      paragraph([
        "準備（族から作った閉じた道の重み）。配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " を任意に取り、",
        ref("def_rows_map"),
        " の ",
        math(String.raw`\mathrm{rows}(\sigma)\in C_L`),
        " から作った閉じた道 ",
        math(String.raw`\Theta(\mathrm{rows}(\sigma))`),
        " の重みを計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
w_T\bigl(\Theta(\mathrm{rows}(\sigma))\bigr)
&=\prod_{i=0}^{L-1}T_{\bigl(\Theta(\mathrm{rows}(\sigma))\bigr)(i),\,\bigl(\Theta(\mathrm{rows}(\sigma))\bigr)(i+1)}
&&(\because\ \text{道に沿った成分の積の定義})\\
&=\prod_{i=0}^{L-1}T_{\bigl(\mathrm{rows}(\sigma)\bigr)(\pi(i)),\,\bigl(\mathrm{rows}(\sigma)\bigr)(\pi(i+1))}
&&(\because\ \Theta\ \text{の定義})\\
&=\prod_{i=0}^{L-1}T_{\bigl(\mathrm{rows}(\sigma)\bigr)(\pi(i)),\,\bigl(\mathrm{rows}(\sigma)\bigr)(\pi(i)+_{\mathbb{Z}/L\mathbb{Z}}\bar1)}
&&(\because\ \pi(i+1)=\pi(i)+_{\mathbb{Z}/L\mathbb{Z}}\pi(1)\ \text{と}\ \bar1=\pi(1))\\
&=\prod_{y\in\mathbb{Z}/L\mathbb{Z}}T_{\bigl(\mathrm{rows}(\sigma)\bigr)(y),\,\bigl(\mathrm{rows}(\sigma)\bigr)(y+_{\mathbb{Z}/L\mathbb{Z}}\bar1)}
&&(\because\ \pi\ \text{の}\ \{0,1,\dots,L-1\}\ \text{への制限が}\ \mathbb{Z}/L\mathbb{Z}\ \text{への全単射})\\
&=\prod_{y\in\mathbb{Z}/L\mathbb{Z}}T_{\rho_y(\sigma),\,\rho_{y+_{\mathbb{Z}/L\mathbb{Z}}\bar1}(\sigma)}
&&(\because\ \mathrm{rows}\ \text{の定義})\\
&=x^{\,b(\sigma)}
&&(\because\ \text{配位の重みは行に沿った成分の積である})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Z_L
&=\sum_{\sigma\in\Sigma_L}x^{\,b(\sigma)}
&&(\because\ \blkref{def_partition_polynomial})\\
&=\sum_{\sigma\in\Sigma_L}w_T\bigl(\Theta(\mathrm{rows}(\sigma))\bigr)
&&(\because\ \text{準備（族から作った閉じた道の重み）})\\
&=\sum_{c\in C_L}w_T\bigl(\Theta(c)\bigr)
&&(\because\ \mathrm{rows}\ \text{が全単射})\\
&=\sum_{p\in W^{\mathrm{cl}}_{L}}w_T(p)
&&(\because\ \Theta\ \text{が全単射})\\
&=\sum_{\tau\in R_L}\ \sum_{p\in W_{L,L}(\tau,\tau)}w_T(p)
&&(\because\ \text{準備（閉じた道の類別）})\\
&=\sum_{\tau\in R_L}\bigl(T^{L}\bigr)_{\tau,\tau}
&&(\because\ \text{行列の冪の成分は道に沿った成分の積の和である})\\
&=\operatorname{Tr}\bigl(T^{L}\bigr)
&&(\because\ \text{トレースの定義})
\end{aligned}`),
      paragraph([
        "以上は有限集合の間の 1 対 1 対応と ",
        math(String.raw`\mathbb{Z}[x]`),
        " の有限個の元の和・積だけからなり、実数体も複素数体も現れない。",
        "分配多項式は ",
        math(String.raw`2^{L^2}`),
        " 個の項の和として定義されているが、この等式により ",
        math(String.raw`2^{L}`),
        " 次の行列の冪から計算できることになる。",
        "次の章では、この行列の固有値が特性多項式の根として代数的数であることを見る。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_heading",
    kind: "heading",
    level: 1,
    title: { text: "固有値の代数性" },
    labels: [],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_order",
    kind: "definition",
    title: { text: "スピン値の番号と、行配位の辞書式順序" },
    labels: ["def_spin_index", "def_row_config_order"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.spinIndex",
      "Ising2DLambda.AlgebraicEigenvalue.differingIndex",
      "Ising2DLambda.AlgebraicEigenvalue.firstDifference",
      "Ising2DLambda.AlgebraicEigenvalue.rowConfigLess",
    ],
    verification: ["sagemath/check/row-config-order"],
    statement: [
      paragraph([
        "この章の目標は、",
        ref("def_transfer_matrix"),
        " の転送行列の特性多項式が ",
        math(String.raw`\mathbb{Z}[x][t]`),
        "（",
        ref("def_second_polynomial_ring"),
        "）に属することを示し、そこから固有値が代数的であることを出すことである。",
        "特性多項式は行列式で定め、行列式は添字集合の置換にわたる和として定め、",
        "置換の符号は転倒数（順序が入れ替わる対の個数）で定める。",
        "転倒数を書くには添字集合に線形順序が要る。この定義はその順序を与える。",
      ]),
      paragraph([
        ref("def_row_configuration"),
        " の行配位に番号を付けて ",
        math(String.raw`\{0,1,\dots,2^{L}-1\}`),
        " の大小を借りることもできるが、そうすると番号の付け方に依存した定義になる。",
        "ここでは ",
        math(String.raw`R_L`),
        " そのものの上に順序を定める。",
      ]),
      paragraph([
        "まずスピン値に番号を与える写像 ",
        math(String.raw`\varepsilon:\{+1,-1\}\to\{0,1\}`),
        " を",
      ]),
      displayMath(String.raw`\varepsilon(+1):=0,\qquad \varepsilon(-1):=1`),
      paragraph([
        "で定める。",
        math(String.raw`+1\ne-1`),
        " かつ ",
        math(String.raw`0\ne1`),
        " なので ",
        math(String.raw`\varepsilon`),
        " は全単射である。",
      ]),
      paragraph([
        "次に、2 つの行配位 ",
        math(String.raw`\tau,\tau'\in R_L`),
        " に対し、値の異なる列番号の集合を",
      ]),
      displayMath(
        String.raw`D(\tau,\tau'):=\bigl\{\,k\in\{0,1,\dots,L-1\} \;\bigm|\; \tau\bigl(\pi(k)\bigr)\ne\tau'\bigl(\pi(k)\bigr)\,\bigr\}\subset\mathbb{N}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`\pi`),
        " は ",
        ref("def_lattice"),
        " の射影）。定義から ",
        math(String.raw`D(\tau,\tau')=D(\tau',\tau)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\tau\ne\tau'`),
        " のとき ",
        math(String.raw`D(\tau,\tau')`),
        " は空でない。実際 ",
        math(String.raw`\tau\ne\tau'`),
        " なら ",
        math(String.raw`\tau(y)\ne\tau'(y)`),
        " となる ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " があり、",
        math(String.raw`k:=s(y)`),
        " と置けば ",
        math(String.raw`0\le k\le L-1`),
        " かつ ",
        math(String.raw`\pi(k)=\pi(s(y))=y`),
        " なので ",
        math(String.raw`k\in D(\tau,\tau')`),
        " である（",
        math(String.raw`s`),
        " は ",
        ref("def_lattice"),
        " の代表を取る写像）。",
      ]),
      paragraph([
        "自然数の空でない部分集合は最小元をもつので（自然数の整列性）、",
        math(String.raw`\tau\ne\tau'`),
        " のとき ",
        math(String.raw`k_0(\tau,\tau'):=\min D(\tau,\tau')\in\mathbb{N}`),
        " が定まる。",
        math(String.raw`D`),
        " が対称なので ",
        math(String.raw`k_0(\tau,\tau')=k_0(\tau',\tau)`),
        " である。",
      ]),
      paragraph([
        "これを用いて ",
        math(String.raw`R_L`),
        " の上の関係 ",
        math(String.raw`\prec`),
        " を",
      ]),
      displayMath(
        String.raw`\tau\prec\tau'\ :\Longleftrightarrow\ \tau\ne\tau'\ \text{かつ}\ \varepsilon\Bigl(\tau\bigl(\pi(k_0(\tau,\tau'))\bigr)\Bigr)<\varepsilon\Bigl(\tau'\bigl(\pi(k_0(\tau,\tau'))\bigr)\Bigr)`,
      ),
      paragraph([
        "で定め、これを行配位の辞書式順序と呼ぶ。右辺の不等号は ",
        math(String.raw`\mathbb{N}`),
        " の大小である。",
        "ここに現れるのは有限集合とその上の写像、および自然数の大小だけであり、実数体は現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_order_linear",
    kind: "claim",
    title: { text: "行配位の辞書式順序は線形順序である" },
    labels: ["claim_row_config_order_linear"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trichotomy",
      "Ising2DLambda.AlgebraicEigenvalue.rowConfigLess_trans",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.lexLess_trichotomy",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.lexLess_trans",
    ],
    verification: ["sagemath/check/row-config-order"],
    statement: [
      paragraph([
        ref("def_row_config_order"),
        " の関係 ",
        math(String.raw`\prec`),
        " について次の 2 つが成り立つ。",
      ]),
      list([
        [
          "三分律: 任意の ",
          math(String.raw`\tau,\tau'\in R_L`),
          " について、",
          math(String.raw`\tau\prec\tau'`),
          "、",
          math(String.raw`\tau=\tau'`),
          "、",
          math(String.raw`\tau'\prec\tau`),
          " のうちちょうど 1 つが成り立つ。",
        ],
        [
          "推移律: 任意の ",
          math(String.raw`\tau,\tau',\tau''\in R_L`),
          " について、",
          math(String.raw`\tau\prec\tau'`),
          " かつ ",
          math(String.raw`\tau'\prec\tau''`),
          " ならば ",
          math(String.raw`\tau\prec\tau''`),
          " である。",
        ],
      ]),
      paragraph([
        "すなわち ",
        math(String.raw`\prec`),
        " は ",
        math(String.raw`R_L`),
        " の上の狭義の線形順序である。",
        "両者はどちらも有限集合の元についての言明であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`\tau\ne\tau'`),
        " のとき ",
        math(String.raw`k_0:=k_0(\tau,\tau')`),
        " は ",
        math(String.raw`D(\tau,\tau')`),
        " の最小元なので、次の 2 つが成り立つ（",
        ref("def_row_config_order"),
        "）。第一に ",
        math(String.raw`\tau(\pi(k_0))\ne\tau'(\pi(k_0))`),
        "。第二に ",
        math(String.raw`k<k_0`),
        " なる ",
        math(String.raw`k\in\{0,1,\dots,L-1\}`),
        " については ",
        math(String.raw`\tau(\pi(k))=\tau'(\pi(k))`),
        "。",
      ]),
      paragraph([
        "三分律。",
        math(String.raw`\tau=\tau'`),
        " の場合、",
        math(String.raw`\prec`),
        " の定義は左右の相異なることを要求するので ",
        math(String.raw`\tau\prec\tau'`),
        " も ",
        math(String.raw`\tau'\prec\tau`),
        " も成り立たず、",
        math(String.raw`\tau=\tau'`),
        " だけが成り立つ。",
      ]),
      paragraph([
        math(String.raw`\tau\ne\tau'`),
        " の場合、",
        math(String.raw`k_0:=k_0(\tau,\tau')`),
        " が定まり、準備の第一により ",
        math(String.raw`\tau(\pi(k_0))\ne\tau'(\pi(k_0))`),
        " である。",
        math(String.raw`\varepsilon`),
        " は全単射なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\bigl(\tau(\pi(k_0))\bigr)
&\ne\varepsilon\bigl(\tau'(\pi(k_0))\bigr)
&&(\because\ \varepsilon\ \text{が単射で}\ \tau(\pi(k_0))\ne\tau'(\pi(k_0)))
\end{aligned}`),
      paragraph([
        "であり、相異なる 2 つの自然数についてはちょうど一方が他方より小さい。",
        math(String.raw`k_0(\tau',\tau)=k_0`),
        " なので、",
        math(String.raw`\tau\prec\tau'`),
        " と ",
        math(String.raw`\tau'\prec\tau`),
        " のちょうど一方が成り立ち、",
        math(String.raw`\tau=\tau'`),
        " は成り立たない。",
      ]),
      paragraph([
        "推移律の証明にはもう 1 つ準備が要る。準備の第三として、",
        math(String.raw`\tau,\tau''\in R_L`),
        " と ",
        math(String.raw`k\in\{0,1,\dots,L-1\}`),
        " が次の 2 つを満たすならば ",
        math(String.raw`\tau\prec\tau''`),
        " である。",
      ]),
      list([
        [
          math(String.raw`k`),
          " 未満のすべての ",
          math(String.raw`j\in\{0,1,\dots,L-1\}`),
          " について ",
          math(String.raw`\tau(\pi(j))=\tau''(\pi(j))`),
          " である。",
        ],
        [
          math(String.raw`\varepsilon\bigl(\tau(\pi(k))\bigr)<\varepsilon\bigl(\tau''(\pi(k))\bigr)`),
          " である。",
        ],
      ]),
      paragraph([
        "実際、第二の条件の両辺は相異なるので ",
        math(String.raw`\varepsilon`),
        " が単射であることから ",
        math(String.raw`\tau(\pi(k))\ne\tau''(\pi(k))`),
        " であり、したがって ",
        math(String.raw`\tau\ne\tau''`),
        " かつ ",
        math(String.raw`k\in D(\tau,\tau'')`),
        " である。第一の条件から ",
        math(String.raw`k`),
        " 未満の元は ",
        math(String.raw`D(\tau,\tau'')`),
        " に属さない。ゆえに ",
        math(String.raw`k_0(\tau,\tau'')=k`),
        " であり、第二の条件が ",
        ref("def_row_config_order"),
        " の不等式そのものになる。",
      ]),
      paragraph([
        "推移律。",
        math(String.raw`\tau\prec\tau'`),
        " かつ ",
        math(String.raw`\tau'\prec\tau''`),
        " とし、",
        math(String.raw`k_0:=k_0(\tau,\tau')`),
        "、",
        math(String.raw`k_1:=k_0(\tau',\tau'')`),
        " と置く。",
        math(String.raw`k_0<k_1`),
        "、",
        math(String.raw`k_0=k_1`),
        "、",
        math(String.raw`k_1<k_0`),
        " のいずれかであるから場合を分ける（最小元の位置によって値の比べ方が変わるので、",
        "一続きの式にはしない）。いずれの場合も、準備の第三の 2 つの条件を ",
        math(String.raw`k=k_0`),
        " または ",
        math(String.raw`k=k_1`),
        " について確かめる。",
      ]),
      paragraph([
        math(String.raw`k_0<k_1`),
        " の場合。",
        math(String.raw`k=k_0`),
        " について準備の第三を用いる。第一の条件は、",
        math(String.raw`j<k_0`),
        " なる ",
        math(String.raw`j`),
        " について ",
        math(String.raw`j<k_0<k_1`),
        " なので準備の第二を 2 回用いて ",
        math(String.raw`\tau(\pi(j))=\tau'(\pi(j))=\tau''(\pi(j))`),
        " から従う。第二の条件は、",
        math(String.raw`k_0<k_1`),
        " より準備の第二を ",
        math(String.raw`\tau',\tau''`),
        " に用いて得られる ",
        math(String.raw`\tau'(\pi(k_0))=\tau''(\pi(k_0))`),
        " を使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\bigl(\tau(\pi(k_0))\bigr)
&<\varepsilon\bigl(\tau'(\pi(k_0))\bigr)
&&(\because\ \tau\prec\tau'\ \text{と}\ k_0=k_0(\tau,\tau'))\\
&=\varepsilon\bigl(\tau''(\pi(k_0))\bigr)
&&(\because\ \tau'(\pi(k_0))=\tau''(\pi(k_0)))
\end{aligned}`),
      paragraph([
        "から従う。よって準備の第三により ",
        math(String.raw`\tau\prec\tau''`),
        " である。",
      ]),
      paragraph([
        math(String.raw`k_1<k_0`),
        " の場合。",
        math(String.raw`k=k_1`),
        " について準備の第三を用いる。第一の条件は、",
        math(String.raw`j<k_1`),
        " なる ",
        math(String.raw`j`),
        " について ",
        math(String.raw`j<k_1<k_0`),
        " なので準備の第二を 2 回用いて ",
        math(String.raw`\tau(\pi(j))=\tau'(\pi(j))=\tau''(\pi(j))`),
        " から従う。第二の条件は、",
        math(String.raw`k_1<k_0`),
        " より準備の第二を ",
        math(String.raw`\tau,\tau'`),
        " に用いて得られる ",
        math(String.raw`\tau(\pi(k_1))=\tau'(\pi(k_1))`),
        " を使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\bigl(\tau(\pi(k_1))\bigr)
&=\varepsilon\bigl(\tau'(\pi(k_1))\bigr)
&&(\because\ \tau(\pi(k_1))=\tau'(\pi(k_1)))\\
&<\varepsilon\bigl(\tau''(\pi(k_1))\bigr)
&&(\because\ \tau'\prec\tau''\ \text{と}\ k_1=k_0(\tau',\tau''))
\end{aligned}`),
      paragraph([
        "から従う。よって準備の第三により ",
        math(String.raw`\tau\prec\tau''`),
        " である。",
      ]),
      paragraph([
        math(String.raw`k_0=k_1`),
        " の場合。",
        math(String.raw`k=k_0`),
        " について準備の第三を用いる。第一の条件は、",
        math(String.raw`j<k_0`),
        " なる ",
        math(String.raw`j`),
        " について ",
        math(String.raw`j<k_0`),
        " と ",
        math(String.raw`j<k_1`),
        " の両方が成り立つので準備の第二を 2 回用いて ",
        math(String.raw`\tau(\pi(j))=\tau'(\pi(j))=\tau''(\pi(j))`),
        " から従う。第二の条件は",
      ]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\bigl(\tau(\pi(k_0))\bigr)
&<\varepsilon\bigl(\tau'(\pi(k_0))\bigr)
&&(\because\ \tau\prec\tau'\ \text{と}\ k_0=k_0(\tau,\tau'))\\
&<\varepsilon\bigl(\tau''(\pi(k_0))\bigr)
&&(\because\ \tau'\prec\tau''\ \text{と}\ k_0=k_1=k_0(\tau',\tau''))
\end{aligned}`),
      paragraph([
        "と自然数の大小の推移律から従う。よって準備の第三により ",
        math(String.raw`\tau\prec\tau''`),
        " である。",
      ]),
      paragraph([
        "以上は有限集合の元の比較と自然数の大小だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_permutation_sign",
    kind: "definition",
    title: { text: "行配位の置換、転倒数、そして符号" },
    labels: ["def_row_permutation", "def_inversion_count", "def_permutation_sign"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orderedPairs",
      "Ising2DLambda.AlgebraicEigenvalue.inversionCount",
      "Ising2DLambda.AlgebraicEigenvalue.permSign",
    ],
    verification: ["sagemath/check/permutation-sign"],
    statement: [
      paragraph([
        "行列式を置換にわたる和として定めるために、",
        ref("def_row_configuration"),
        " の行配位の集合 ",
        math(String.raw`R_L`),
        " の上の置換と、その符号を定める。",
        "符号は ",
        ref("def_row_config_order"),
        " の順序 ",
        math(String.raw`\prec`),
        " に対する転倒数で定める。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`R_L`),
        " の置換とは全単射 ",
        math(String.raw`\varphi:R_L\to R_L`),
        " のことであり、その全体を ",
        math(String.raw`\mathfrak{S}_L`),
        " と書く。",
        math(String.raw`R_L`),
        " は有限集合なので ",
        math(String.raw`\mathfrak{S}_L`),
        " も有限集合である。",
        "2 つの置換 ",
        math(String.raw`\varphi,\psi\in\mathfrak{S}_L`),
        " の合成 ",
        math(String.raw`\varphi\circ\psi`),
        "（",
        math(String.raw`(\varphi\circ\psi)(\tau)=\varphi(\psi(\tau))`),
        "）は再び置換であり、恒等写像 ",
        math(String.raw`\mathrm{id}_{R_L}`),
        " も置換である。全単射 ",
        math(String.raw`\varphi`),
        " には逆写像 ",
        math(String.raw`\varphi^{-1}\in\mathfrak{S}_L`),
        " がある。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`\prec`),
        " について順序づけられた対の集合を",
      ]),
      displayMath(
        String.raw`P_L:=\bigl\{\,(\tau,\tau')\in R_L\times R_L \;\bigm|\; \tau\prec\tau'\,\bigr\}`,
      ),
      paragraph([
        "と置き（",
        math(String.raw`R_L\times R_L`),
        " が有限集合なので ",
        math(String.raw`P_L`),
        " も有限集合）、置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " の転倒数を",
      ]),
      displayMath(
        String.raw`\mathrm{inv}(\varphi):=\bigl|\,\bigl\{\,(\tau,\tau')\in P_L \;\bigm|\; \varphi(\tau')\prec\varphi(\tau)\,\bigr\}\,\bigr|\in\mathbb{N}`,
      ),
      paragraph([
        "で定める。すなわち ",
        math(String.raw`\mathrm{inv}(\varphi)`),
        " は、",
        math(String.raw`\varphi`),
        " によって順序が入れ替わる対の個数である。",
        "これは有限集合の元の個数なので自然数である。",
      ]),
      paragraph([
        "第三に、置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " の符号を",
      ]),
      displayMath(String.raw`\mathrm{sgn}(\varphi):=(-1)^{\mathrm{inv}(\varphi)}\in\mathbb{Z}`),
      paragraph([
        "で定める。右辺は整数 ",
        math(String.raw`-1`),
        " の自然数冪であり、",
        math(String.raw`\mathbb{Z}`),
        " の中の計算である。",
        "ここに現れるのは有限集合とその上の写像、数え上げ、および整数の積だけであり、実数体は現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_permutation_sign_values",
    kind: "claim",
    title: { text: "符号は +1 か -1 であり、恒等写像の符号は +1 である" },
    labels: ["claim_permutation_sign_values"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.permSign_eq_one_or_neg_one",
      "Ising2DLambda.AlgebraicEigenvalue.permSign_mul_self",
      "Ising2DLambda.AlgebraicEigenvalue.permSign_id",
    ],
    verification: ["sagemath/check/permutation-sign"],
    statement: [
      paragraph([
        ref("def_permutation_sign"),
        " の符号について次の 3 つが成り立つ。",
      ]),
      list([
        [
          "任意の ",
          math(String.raw`\varphi\in\mathfrak{S}_L`),
          " について ",
          math(String.raw`\mathrm{sgn}(\varphi)=+1`),
          " または ",
          math(String.raw`\mathrm{sgn}(\varphi)=-1`),
          " である。",
        ],
        [
          "任意の ",
          math(String.raw`\varphi\in\mathfrak{S}_L`),
          " について ",
          math(String.raw`\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\varphi)=1`),
          " である。",
        ],
        [
          math(String.raw`\mathrm{sgn}(\mathrm{id}_{R_L})=+1`),
          " である。",
        ],
      ]),
      paragraph([
        "いずれも ",
        math(String.raw`\mathbb{Z}`),
        " の中の等式であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "第一の主張。自然数 ",
        math(String.raw`n`),
        " が偶数なら ",
        math(String.raw`(-1)^n=+1`),
        "、奇数なら ",
        math(String.raw`(-1)^n=-1`),
        " であり、自然数は偶数か奇数のいずれかである。",
        math(String.raw`n=\mathrm{inv}(\varphi)`),
        " と置けばよい。",
      ]),
      paragraph(["第二の主張。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\varphi)
&=(-1)^{\mathrm{inv}(\varphi)}\cdot(-1)^{\mathrm{inv}(\varphi)}
&&(\because\ \text{符号の定義})\\
&=\bigl((-1)^{2}\bigr)^{\mathrm{inv}(\varphi)}
&&(\because\ \text{指数法則})\\
&=1^{\mathrm{inv}(\varphi)}
&&(\because\ (-1)^{2}=1)\\
&=1
&&(\because\ 1\ \text{の冪は}\ 1)
\end{aligned}`),
      paragraph([
        "第三の主張。",
        math(String.raw`(\tau,\tau')\in P_L`),
        " ならば ",
        math(String.raw`\tau\prec\tau'`),
        " であり、",
        ref("claim_row_config_order_linear"),
        " の三分律から ",
        math(String.raw`\tau'\prec\tau`),
        " は成り立たない。",
        math(String.raw`\mathrm{id}_{R_L}(\tau)=\tau`),
        " なので、転倒数の定義に現れる集合は空であり ",
        math(String.raw`\mathrm{inv}(\mathrm{id}_{R_L})=0`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}(\mathrm{id}_{R_L})
&=(-1)^{\mathrm{inv}(\mathrm{id}_{R_L})}
&&(\because\ \text{符号の定義})\\
&=(-1)^{0}
&&(\because\ \mathrm{inv}(\mathrm{id}_{R_L})=0)\\
&=1
&&(\because\ \text{0 乗は}\ 1)
\end{aligned}`),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_permutation_sign_mul",
    kind: "claim",
    title: { text: "符号は合成について乗法的である" },
    labels: ["claim_permutation_sign_mul"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.permSign_comp",
      "Ising2DLambda.AlgebraicEigenvalue.permSign_comp_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sign_comp",
    ],
    verification: ["sagemath/check/permutation-sign"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi,\psi\in\mathfrak{S}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{sgn}(\varphi\circ\psi)=\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)`,
      ),
      paragraph([
        "が成り立つ（",
        ref("def_permutation_sign"),
        "）。両辺は ",
        math(String.raw`\mathbb{Z}`),
        " の元であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`\psi`),
        " が定める写像 ",
        math(String.raw`\Psi:P_L\to P_L`),
        " を",
      ]),
      displayMath(String.raw`\Psi(\tau,\tau'):=
\begin{cases}
\bigl(\psi(\tau),\psi(\tau')\bigr) & \bigl(\psi(\tau)\prec\psi(\tau')\ \text{のとき}\bigr)\\
\bigl(\psi(\tau'),\psi(\tau)\bigr) & \bigl(\psi(\tau')\prec\psi(\tau)\ \text{のとき}\bigr)
\end{cases}`),
      paragraph([
        "で定める。これが定まることを見る。",
        math(String.raw`(\tau,\tau')\in P_L`),
        " なら ",
        math(String.raw`\tau\prec\tau'`),
        " なので三分律から ",
        math(String.raw`\tau\ne\tau'`),
        " であり、",
        math(String.raw`\psi`),
        " が単射なので ",
        math(String.raw`\psi(\tau)\ne\psi(\tau')`),
        " である。ふたたび三分律から ",
        math(String.raw`\psi(\tau)\prec\psi(\tau')`),
        " と ",
        math(String.raw`\psi(\tau')\prec\psi(\tau)`),
        " のちょうど一方が成り立つ。どちらの場合も右辺は ",
        math(String.raw`P_L`),
        " の元である。",
      ]),
      paragraph([
        math(String.raw`\Psi`),
        " は全単射である。実際 ",
        math(String.raw`\psi^{-1}`),
        " から同じ作り方で得られる写像 ",
        math(String.raw`\Psi':P_L\to P_L`),
        " が逆写像になる。",
        math(String.raw`(\tau,\tau')\in P_L`),
        " について、",
        math(String.raw`\psi(\tau)\prec\psi(\tau')`),
        " の場合は ",
        math(String.raw`\Psi(\tau,\tau')=(\psi(\tau),\psi(\tau'))`),
        " であり、その 2 成分を ",
        math(String.raw`\psi^{-1}`),
        " で戻すと ",
        math(String.raw`\tau,\tau'`),
        " で、",
        math(String.raw`\tau\prec\tau'`),
        " なので ",
        math(String.raw`\Psi'(\Psi(\tau,\tau'))=(\tau,\tau')`),
        " である。",
        math(String.raw`\psi(\tau')\prec\psi(\tau)`),
        " の場合は ",
        math(String.raw`\Psi(\tau,\tau')=(\psi(\tau'),\psi(\tau))`),
        " であり、その 2 成分を ",
        math(String.raw`\psi^{-1}`),
        " で戻すと ",
        math(String.raw`\tau',\tau`),
        " で、やはり ",
        math(String.raw`\tau\prec\tau'`),
        " なので ",
        math(String.raw`\Psi'(\Psi(\tau,\tau'))=(\tau,\tau')`),
        " である。",
        math(String.raw`\psi`),
        " と ",
        math(String.raw`\psi^{-1}`),
        " を入れ替えれば同じ議論で ",
        math(String.raw`\Psi(\Psi'(\tau,\tau'))=(\tau,\tau')`),
        " が出る。",
      ]),
      paragraph([
        "次に、",
        math(String.raw`P_L`),
        " の 3 つの部分集合",
      ]),
      displayMath(String.raw`\begin{aligned}
A&:=\bigl\{\,(\tau,\tau')\in P_L \bigm| (\varphi\circ\psi)(\tau')\prec(\varphi\circ\psi)(\tau)\,\bigr\},\\
B&:=\bigl\{\,(\tau,\tau')\in P_L \bigm| \psi(\tau')\prec\psi(\tau)\,\bigr\},\\
C&:=\bigl\{\,(\tau,\tau')\in P_L \bigm| \varphi\bigl(\Psi(\tau,\tau')_2\bigr)\prec\varphi\bigl(\Psi(\tau,\tau')_1\bigr)\,\bigr\}
\end{aligned}`),
      paragraph([
        "を置く（",
        math(String.raw`(\upsilon,\upsilon')_1:=\upsilon`),
        "、",
        math(String.raw`(\upsilon,\upsilon')_2:=\upsilon'`),
        " は対の成分を取り出す記号である）。転倒数の定義から ",
        math(String.raw`|A|=\mathrm{inv}(\varphi\circ\psi)`),
        " と ",
        math(String.raw`|B|=\mathrm{inv}(\psi)`),
        " である。また ",
        math(String.raw`C`),
        " は ",
        math(String.raw`\Psi`),
        " による ",
        math(String.raw`\{(\upsilon,\upsilon')\in P_L\mid\varphi(\upsilon')\prec\varphi(\upsilon)\}`),
        " の逆像であり、",
        math(String.raw`\Psi`),
        " が全単射なので ",
        math(String.raw`|C|=\mathrm{inv}(\varphi)`),
        " である。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`(\tau,\tau')\in P_L`),
        " について、",
        math(String.raw`A,B,C`),
        " のうちその対が属するものの個数は偶数である。場合を分けて確かめる。",
      ]),
      paragraph([
        math(String.raw`\psi(\tau)\prec\psi(\tau')`),
        " の場合。三分律から ",
        math(String.raw`\psi(\tau')\prec\psi(\tau)`),
        " は成り立たないので、その対は ",
        math(String.raw`B`),
        " に属さない。このとき ",
        math(String.raw`\Psi(\tau,\tau')=(\psi(\tau),\psi(\tau'))`),
        " なので ",
        math(String.raw`C`),
        " の条件は ",
        math(String.raw`\varphi(\psi(\tau'))\prec\varphi(\psi(\tau))`),
        " であり、これは ",
        math(String.raw`A`),
        " の条件と同じである。よって属するものの個数は ",
        math(String.raw`0`),
        " 個か ",
        math(String.raw`2`),
        " 個であり、いずれも偶数である。",
      ]),
      paragraph([
        math(String.raw`\psi(\tau')\prec\psi(\tau)`),
        " の場合。その対は ",
        math(String.raw`B`),
        " に属する。このとき ",
        math(String.raw`\Psi(\tau,\tau')=(\psi(\tau'),\psi(\tau))`),
        " なので ",
        math(String.raw`C`),
        " の条件は ",
        math(String.raw`\varphi(\psi(\tau))\prec\varphi(\psi(\tau'))`),
        " である。",
        math(String.raw`\tau\ne\tau'`),
        " と ",
        math(String.raw`\varphi\circ\psi`),
        " が単射であることから ",
        math(String.raw`\varphi(\psi(\tau))\ne\varphi(\psi(\tau'))`),
        " なので、三分律により ",
        math(String.raw`A`),
        " の条件と ",
        math(String.raw`C`),
        " の条件のちょうど一方が成り立つ。よって属するものの個数は ",
        math(String.raw`B`),
        " のぶんと合わせてちょうど ",
        math(String.raw`2`),
        " 個であり、偶数である。",
      ]),
      paragraph([
        "準備として、",
        math(String.raw`P_L`),
        " の部分集合 ",
        math(String.raw`X`),
        " に対して写像 ",
        math(String.raw`f_X:P_L\to\mathbb{Z}`),
        " を",
      ]),
      displayMath(String.raw`f_X(\tau,\tau'):=
\begin{cases}
-1 & \bigl((\tau,\tau')\in X\ \text{のとき}\bigr)\\
+1 & \bigl((\tau,\tau')\notin X\ \text{のとき}\bigr)
\end{cases}`),
      paragraph([
        "で定める。いま見たことは、各 ",
        math(String.raw`(\tau,\tau')\in P_L`),
        " について ",
        math(String.raw`f_A(\tau,\tau')\cdot f_C(\tau,\tau')\cdot f_B(\tau,\tau')=1`),
        " が成り立つことを言っている（",
        math(String.raw`-1`),
        " が偶数個掛かるからである）。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}(\varphi\circ\psi)\cdot\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)
&=(-1)^{\mathrm{inv}(\varphi\circ\psi)}\cdot(-1)^{\mathrm{inv}(\varphi)}\cdot(-1)^{\mathrm{inv}(\psi)}
&&(\because\ \text{符号の定義})\\
&=(-1)^{|A|}\cdot(-1)^{|C|}\cdot(-1)^{|B|}
&&(\because\ |A|=\mathrm{inv}(\varphi\circ\psi),\ |C|=\mathrm{inv}(\varphi),\ |B|=\mathrm{inv}(\psi))\\
&=\prod_{(\tau,\tau')\in P_L}f_A(\tau,\tau')\cdot\prod_{(\tau,\tau')\in P_L}f_C(\tau,\tau')\cdot\prod_{(\tau,\tau')\in P_L}f_B(\tau,\tau')
&&(\because\ \text{属するときだけ}\ -1\ \text{を掛けた有限積は}\ (-1)\ \text{の個数乗})\\
&=\prod_{(\tau,\tau')\in P_L}\bigl(f_A(\tau,\tau')\cdot f_C(\tau,\tau')\cdot f_B(\tau,\tau')\bigr)
&&(\because\ \text{有限積の各因子ごとのまとめ})\\
&=\prod_{(\tau,\tau')\in P_L}1
&&(\because\ \text{属するものの個数が偶数})\\
&=1
&&(\because\ 1\ \text{の有限積は}\ 1)
\end{aligned}`),
      paragraph([
        "である。これを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}(\varphi\circ\psi)
&=\mathrm{sgn}(\varphi\circ\psi)\cdot1\cdot1\\
&=\mathrm{sgn}(\varphi\circ\psi)\cdot\bigl(\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\varphi)\bigr)\cdot\bigl(\mathrm{sgn}(\psi)\cdot\mathrm{sgn}(\psi)\bigr)
&&(\because\ \text{符号の 2 乗は}\ 1)\\
&=\bigl(\mathrm{sgn}(\varphi\circ\psi)\cdot\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)\bigr)\cdot\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)\\
&=1\cdot\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)
&&(\because\ \text{直前の等式})\\
&=\mathrm{sgn}(\varphi)\cdot\mathrm{sgn}(\psi)
\end{aligned}`),
      paragraph(["を得る。"]),
      paragraph([
        "以上で使ったのは、",
        math(String.raw`\prec`),
        " の三分律、置換が単射であること、有限集合の数え上げ、そして整数の積だけである。",
        ref("claim_row_config_order_linear"),
        " の推移律は一度も使っていない。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_determinant",
    kind: "definition",
    title: { text: "定数多項式を与える写像、単位行列、そして行列式" },
    labels: ["def_constant_polynomial", "def_identity_matrix", "def_determinant"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.constPoly",
      "Ising2DLambda.AlgebraicEigenvalue.identityRowMatrix",
      "Ising2DLambda.AlgebraicEigenvalue.determinant",
    ],
    verification: ["sagemath/check/determinant"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " の行列式を、",
        ref("def_permutation_sign"),
        " の符号を係数とする置換にわたる和として定める。",
        "その前に、整数を成分として書くための写像と単位行列を用意する。",
      ]),
      paragraph([
        "第一に、整数 ",
        math(String.raw`n\in\mathbb{Z}`),
        " に対して定数多項式を与える写像 ",
        math(String.raw`\kappa:\mathbb{Z}\to\mathbb{Z}[x]`),
        " を、",
        math(String.raw`\kappa(n)`),
        " は ",
        math(String.raw`x^{0}`),
        " の係数が ",
        math(String.raw`n`),
        " で他の係数がすべて ",
        math(String.raw`0`),
        " である多項式、として定める。",
        math(String.raw`\kappa`),
        " は和と積を保ち、",
        math(String.raw`\kappa(0)`),
        " は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の零元、",
        math(String.raw`\kappa(1)`),
        " は単位元である。",
        "整数を ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として扱う経路はこの写像だけとし、整数と定数多項式を同じ記号で書くことはしない",
        "（どちらの集合の中で計算しているかを式に残すため）。",
      ]),
      paragraph([
        "第二に、単位行列 ",
        math(String.raw`I\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " を",
      ]),
      displayMath(String.raw`I_{\tau,\tau'}:=
\begin{cases}
\kappa(1) & (\tau=\tau'\ \text{のとき})\\
\kappa(0) & (\tau\ne\tau'\ \text{のとき})
\end{cases}
\qquad(\tau,\tau'\in R_L)`),
      paragraph([
        "で定める。",
      ]),
      paragraph([
        "第三に、行列式 ",
        math(String.raw`\det A\in\mathbb{Z}[x]`),
        " を",
      ]),
      displayMath(
        String.raw`\det A:=\sum_{\varphi\in\mathfrak{S}_L}\kappa\bigl(\mathrm{sgn}(\varphi)\bigr)\cdot\prod_{\tau\in R_L}A_{\tau,\varphi(\tau)}`,
      ),
      paragraph([
        "で定める。右辺が ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として確定することを見る。",
        ref("def_row_permutation"),
        " の ",
        math(String.raw`\mathfrak{S}_L`),
        " は有限集合であり ",
        math(String.raw`R_L`),
        " も有限集合なので、和も積も有限個の項からなる。",
        math(String.raw`\mathbb{Z}[x]`),
        " の積は可換かつ結合的なので、",
        math(String.raw`\prod_{\tau\in R_L}`),
        " は因子を並べる順序によらず定まる",
        "（すなわちこの積を書くのに ",
        ref("def_row_config_order"),
        " の順序 ",
        math(String.raw`\prec`),
        " は要らない。",
        math(String.raw`\prec`),
        " が要るのは符号 ",
        math(String.raw`\mathrm{sgn}(\varphi)`),
        " を転倒数で定める箇所だけである）。",
      ]),
      paragraph([
        "以上に現れるのは有限集合の上の和と積、整数、および整係数多項式だけであり、",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_permutation_moves_two",
    kind: "claim",
    title: { text: "恒等写像でない置換は少なくとも 2 つの行配位を動かす" },
    labels: ["claim_permutation_moves_two"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.two_le_card_movedBy",
      "Ising2DLambda.AlgebraicEigenvalue.two_le_card_movedBy_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.two_le_card_moved",
    ],
    verification: ["sagemath/check/determinant"],
    statement: [
      paragraph([
        ref("def_row_permutation"),
        " の置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " が ",
        math(String.raw`\varphi\ne\mathrm{id}_{R_L}`),
        " を満たすとき、",
        math(String.raw`\varphi`),
        " が動かす行配位の集合",
      ]),
      displayMath(
        String.raw`M(\varphi):=\bigl\{\,\tau\in R_L \;\bigm|\; \varphi(\tau)\ne\tau\,\bigr\}`,
      ),
      paragraph([
        "について ",
        math(String.raw`|M(\varphi)|\ge2`),
        " が成り立つ。左辺は有限集合の元の個数なので ",
        math(String.raw`\mathbb{N}`),
        " の元であり、実数体は現れない。",
      ]),
      paragraph([
        "この主張は、次のセクションで特性多項式の次数を数えるときに使う。",
        "恒等置換の項だけが特性多項式の不定元 ",
        math(String.raw`t`),
        " を ",
        math(String.raw`|R_L|`),
        " 個ぶん含み、他の項は 2 個以上少ない、という形で効く。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\varphi\ne\mathrm{id}_{R_L}`),
        " なので、",
        math(String.raw`\varphi(\tau_1)\ne\tau_1`),
        " となる ",
        math(String.raw`\tau_1\in R_L`),
        " が取れる。",
        math(String.raw`\tau_2:=\varphi(\tau_1)`),
        " と置く。",
      ]),
      paragraph([
        "第一に ",
        math(String.raw`\tau_1\ne\tau_2`),
        " である。これは ",
        math(String.raw`\tau_2=\varphi(\tau_1)\ne\tau_1`),
        " が ",
        math(String.raw`\tau_1`),
        " の取り方そのものだからである。",
      ]),
      paragraph([
        "第二に ",
        math(String.raw`\varphi(\tau_2)\ne\tau_2`),
        " である。仮に ",
        math(String.raw`\varphi(\tau_2)=\tau_2`),
        " が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi\bigl(\varphi(\tau_1)\bigr)
&=\varphi(\tau_2)
&&(\because\ \tau_2=\varphi(\tau_1))\\
&=\tau_2
&&(\because\ \text{仮定})\\
&=\varphi(\tau_1)
&&(\because\ \tau_2=\varphi(\tau_1))
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`\varphi`),
        " が単射であることから ",
        math(String.raw`\varphi(\tau_1)=\tau_1`),
        " が出る。これは ",
        math(String.raw`\tau_1`),
        " の取り方に反する。したがって ",
        math(String.raw`\varphi(\tau_2)\ne\tau_2`),
        " である。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\tau_1\in M(\varphi)`),
        " と ",
        math(String.raw`\tau_2\in M(\varphi)`),
        " がともに成り立ち、この 2 つは相異なる。",
        "相異なる 2 元を含む有限集合の元の個数は 2 以上なので ",
        math(String.raw`|M(\varphi)|\ge2`),
        " である。",
      ]),
      paragraph([
        "使ったのは、置換が単射であることと有限集合の数え上げだけである。",
        ref("def_row_config_order"),
        " の順序も、行配位であることも、格子の形も使っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_determinant_diagonal",
    kind: "claim",
    title: { text: "対角行列の行列式は対角成分の積である" },
    labels: ["claim_determinant_diagonal"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.determinant_diagonal",
      "Ising2DLambda.AlgebraicEigenvalue.determinant_identity",
      "Ising2DLambda.AlgebraicEigenvalue.determinant_diagonal_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.det_diagonal",
    ],
    verification: ["sagemath/check/determinant"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " が、相異なる任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について ",
        math(String.raw`A_{\tau,\tau'}=\kappa(0)`),
        " を満たすとする。このとき",
      ]),
      displayMath(String.raw`\det A=\prod_{\tau\in R_L}A_{\tau,\tau}`),
      paragraph([
        "が成り立つ。とくに ",
        ref("def_identity_matrix"),
        " の単位行列について ",
        math(String.raw`\det I=\kappa(1)`),
        " である。いずれも ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中の等式であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、恒等写像でない置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " の項が ",
        math(String.raw`\kappa(0)`),
        " になることを見る。",
        math(String.raw`\varphi\ne\mathrm{id}_{R_L}`),
        " なので ",
        math(String.raw`\varphi(\tau_1)\ne\tau_1`),
        " となる ",
        math(String.raw`\tau_1\in R_L`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
\kappa\bigl(\mathrm{sgn}(\varphi)\bigr)\cdot\prod_{\tau\in R_L}A_{\tau,\varphi(\tau)}
&=\kappa\bigl(\mathrm{sgn}(\varphi)\bigr)\cdot A_{\tau_1,\varphi(\tau_1)}\cdot\prod_{\tau\in R_L\setminus\{\tau_1\}}A_{\tau,\varphi(\tau)}
&&(\because\ \text{有限積から 1 つの因子を括り出す})\\
&=\kappa\bigl(\mathrm{sgn}(\varphi)\bigr)\cdot\kappa(0)\cdot\prod_{\tau\in R_L\setminus\{\tau_1\}}A_{\tau,\varphi(\tau)}
&&(\because\ \varphi(\tau_1)\ne\tau_1\ \text{と仮定})\\
&=\kappa(0)
&&(\because\ \mathbb{Z}[x]\ \text{の零元を掛けると零元})
\end{aligned}`),
      paragraph([
        "である。これを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\det A
&=\sum_{\varphi\in\mathfrak{S}_L}\kappa\bigl(\mathrm{sgn}(\varphi)\bigr)\cdot\prod_{\tau\in R_L}A_{\tau,\varphi(\tau)}
&&(\because\ \text{行列式の定義})\\
&=\kappa\bigl(\mathrm{sgn}(\mathrm{id}_{R_L})\bigr)\cdot\prod_{\tau\in R_L}A_{\tau,\mathrm{id}_{R_L}(\tau)}
&&(\because\ \text{恒等写像でない置換の項は}\ \kappa(0)\ \text{であり、零元は和に寄与しない})\\
&=\kappa(1)\cdot\prod_{\tau\in R_L}A_{\tau,\mathrm{id}_{R_L}(\tau)}
&&(\because\ \mathrm{sgn}(\mathrm{id}_{R_L})=1)\\
&=\kappa(1)\cdot\prod_{\tau\in R_L}A_{\tau,\tau}
&&(\because\ \mathrm{id}_{R_L}(\tau)=\tau)\\
&=\prod_{\tau\in R_L}A_{\tau,\tau}
&&(\because\ \kappa(1)\ \text{は}\ \mathbb{Z}[x]\ \text{の単位元})
\end{aligned}`),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "単位行列 ",
        math(String.raw`I`),
        " は仮定を満たすので、いま示したことが使えて",
      ]),
      displayMath(String.raw`\begin{aligned}
\det I
&=\prod_{\tau\in R_L}I_{\tau,\tau}
&&(\because\ \text{いま示した等式})\\
&=\prod_{\tau\in R_L}\kappa(1)
&&(\because\ \text{単位行列の定義})\\
&=\kappa(1)
&&(\because\ \text{単位元の有限積は単位元})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "使ったのは、",
        math(String.raw`\mathbb{Z}[x]`),
        " の和と積についての次の性質（零元を掛けると零元、単位元を掛けても変わらない、",
        "有限和と有限積が定まる、積は可換）と、",
        "恒等写像の符号が ",
        math(String.raw`1`),
        " であることだけである。",
        "引き算は一度も使っていない（符号が ",
        math(String.raw`-1`),
        " になる項は、恒等写像でない置換の項として消えているので現れない）。",
        "転倒数の作り方も、",
        ref("claim_permutation_sign_mul"),
        " の乗法性も使っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_polynomial",
    kind: "definition",
    title: { text: "整係数多項式を係数とする、もう 1 つの不定元の多項式" },
    labels: ["def_second_polynomial_ring"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.SecondPoly"],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        "特性多項式を書く場所を用意する。",
        ref("def_partition_polynomial"),
        " の不定元 ",
        math(String.raw`x`),
        " とは別の不定元 ",
        math(String.raw`t`),
        " を取り、",
        math(String.raw`\mathbb{Z}[x]`),
        " を係数環とする ",
        math(String.raw`t`),
        " の多項式環を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " と書く。",
      ]),
      paragraph([
        math(String.raw`f\in\mathbb{Z}[x][t]`),
        " と ",
        math(String.raw`k\in\mathbb{N}`),
        " に対して、",
        math(String.raw`f`),
        " の ",
        math(String.raw`t^{k}`),
        " の係数を ",
        math(String.raw`\mathrm{cf}_k(f)\in\mathbb{Z}[x]`),
        " と書く（",
        math(String.raw`\mathbb{Z}[x]`),
        " の零元と単位元は ",
        ref("def_constant_polynomial"),
        " の ",
        math(String.raw`\kappa(0)`),
        "、",
        math(String.raw`\kappa(1)`),
        " と書き、整数の ",
        math(String.raw`0`),
        "、",
        math(String.raw`1`),
        " と同じ記号では書かない）。",
        math(String.raw`\mathrm{cf}_k(f)\ne\kappa(0)`),
        " となる ",
        math(String.raw`k`),
        " は有限個であり、",
      ]),
      displayMath(String.raw`f=\sum_{k:\ \mathrm{cf}_k(f)\ne\kappa(0)}\mathrm{cf}_k(f)\cdot t^{\,k}`),
      paragraph([
        "が成り立つ。和と積は係数の言葉で",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k(f+g)&=\mathrm{cf}_k(f)+\mathrm{cf}_k(g)\\
\mathrm{cf}_k(f\cdot g)&=\sum_{i=0}^{k}\mathrm{cf}_i(f)\cdot\mathrm{cf}_{k-i}(g)
\end{aligned}
\qquad(f,g\in\mathbb{Z}[x][t],\ k\in\mathbb{N})`),
      paragraph([
        "で与えられる。これは多項式環の演算の定義であって、証明すべきことではない。",
        "以下の主張はすべてこの 2 つの等式だけから出る。",
      ]),
      paragraph([
        "不定元の名前について 1 点を約束する。この不定元を ",
        math(String.raw`\lambda`),
        " と書かない。",
        math(String.raw`\lambda`),
        " は ",
        ref("def_log_order_group"),
        " の元を表す記号として固定してあり、同じ記号に 2 つの意味を持たせないためである。",
      ]),
      paragraph([
        "現れるのは整数、有限和、有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_constant_embedding",
    kind: "definition",
    title: { text: "整係数多項式を定数として送る写像" },
    labels: ["def_second_constant_embedding"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.constSecond"],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        math(String.raw`a\in\mathbb{Z}[x]`),
        " に対して、",
        ref("def_second_polynomial_ring"),
        " の ",
        math(String.raw`t`),
        " について定数である元を与える写像 ",
        math(String.raw`\iota:\mathbb{Z}[x]\to\mathbb{Z}[x][t]`),
        " を",
      ]),
      displayMath(String.raw`\mathrm{cf}_0\bigl(\iota(a)\bigr):=a,
\qquad
\mathrm{cf}_k\bigl(\iota(a)\bigr):=\kappa(0)\quad(k\ge1)`),
      paragraph([
        "で定める。",
        math(String.raw`\iota`),
        " は和と積を保ち、",
        math(String.raw`\iota\bigl(\kappa(0)\bigr)`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の零元、",
        math(String.raw`\iota\bigl(\kappa(1)\bigr)`),
        " は単位元である（",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\mathbb{Z}[x]`),
        " の元を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元として扱う経路はこの写像だけとし、両者を同じ記号で書くことはしない",
        "（",
        ref("def_constant_polynomial"),
        " で整数と定数多項式を書き分けたのと同じ理由である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_degree_bound",
    kind: "definition",
    title: { text: "次数が与えられた自然数以下である元の全体" },
    labels: ["def_second_degree_bound"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.DegLe"],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " に対して、",
        ref("def_second_polynomial_ring"),
        " の元のうち次数が ",
        math(String.raw`n`),
        " 以下であるものの全体を",
      ]),
      displayMath(
        String.raw`\mathcal{D}_n:=\bigl\{\,f\in\mathbb{Z}[x][t] \;\bigm|\; \text{任意の}\ k\in\mathbb{N}\ \text{について}\ k>n\ \text{ならば}\ \mathrm{cf}_k(f)=\kappa(0)\,\bigr\}`,
      ),
      paragraph([
        "と書く。",
      ]),
      paragraph([
        "次数そのものを写像として定めず、上界の条件を満たす元の全体として定めている。",
        "こうするのは、零多項式の次数をいくつと決めるかという約束が要らなくなるためであり、",
        "以下で必要になるのが上界だけだからである。",
        "定義から、",
        math(String.raw`n\le n'`),
        " ならば ",
        math(String.raw`\mathcal{D}_n\subset\mathcal{D}_{n'}`),
        " である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_monic",
    kind: "definition",
    title: { text: "モニックな、次数がちょうど与えられた自然数である元の全体" },
    labels: ["def_second_monic"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.MonicDeg"],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\mathcal{M}_n:=\bigl\{\,f\in\mathcal{D}_n \;\bigm|\; \mathrm{cf}_n(f)=\kappa(1)\,\bigr\}`,
      ),
      paragraph([
        "と書き、この集合の元をモニックな次数 ",
        math(String.raw`n`),
        " の元と呼ぶ（",
        math(String.raw`\mathcal{D}_n`),
        " は ",
        ref("def_second_degree_bound"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "すなわち ",
        math(String.raw`t^{\,n}`),
        " の係数が ",
        math(String.raw`\mathbb{Z}[x]`),
        " の単位元であり、それより高い次数の係数がすべて ",
        math(String.raw`0`),
        " である元のことである。",
      ]),
      paragraph([
        "この呼び方が意味をもつこと、すなわち ",
        math(String.raw`f`),
        " に対して ",
        math(String.raw`f\in\mathcal{M}_n`),
        " となる ",
        math(String.raw`n`),
        " が高々 1 つであることを見る。",
        math(String.raw`n\ne n''`),
        " として ",
        math(String.raw`f\in\mathcal{M}_n`),
        " と ",
        math(String.raw`f\in\mathcal{M}_{n''}`),
        " がともに成り立つとする。",
        math(String.raw`n<n''`),
        " としてよい。このとき ",
        math(String.raw`f\in\mathcal{D}_n`),
        " と ",
        math(String.raw`n''>n`),
        " から ",
        math(String.raw`\mathrm{cf}_{n''}(f)=\kappa(0)`),
        " が出るが、",
        math(String.raw`f\in\mathcal{M}_{n''}`),
        " から ",
        math(String.raw`\mathrm{cf}_{n''}(f)=\kappa(1)`),
        " も出る。",
        ref("def_constant_polynomial"),
        " の定め方から ",
        math(String.raw`\kappa(0)`),
        " と ",
        math(String.raw`\kappa(1)`),
        " は ",
        math(String.raw`x^{0}`),
        " の係数が異なるので ",
        math(String.raw`\kappa(1)\ne\kappa(0)`),
        " であり、これは矛盾である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_degree_sum",
    kind: "claim",
    title: { text: "次数が n 以下である元の有限和は、次数が n 以下である" },
    labels: ["claim_second_degree_sum"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.degLe_sum",
      "Ising2DLambda.AlgebraicEigenvalue.degLe_sum_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_sum",
    ],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        "、有限集合 ",
        math(String.raw`S`),
        "、および各 ",
        math(String.raw`s\in S`),
        " について ",
        math(String.raw`f_s\in\mathcal{D}_n`),
        " が与えられているとする（",
        math(String.raw`\mathcal{D}_n`),
        " は ",
        ref("def_second_degree_bound"),
        "）。このとき",
      ]),
      displayMath(String.raw`\sum_{s\in S}f_s\ \in\ \mathcal{D}_n`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k>n`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k\Bigl(\sum_{s\in S}f_s\Bigr)
&=\sum_{s\in S}\mathrm{cf}_k(f_s)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の和の係数、}S\ \text{の元の個数についての帰納法})\\
&=\sum_{s\in S}\kappa(0)
&&(\because\ f_s\in\mathcal{D}_n\ \text{と}\ k>n)\\
&=\kappa(0)
&&(\because\ \text{零元の有限和は零元})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k>n`),
        " を満たす ",
        math(String.raw`k`),
        " は任意だったので ",
        math(String.raw`\sum_{s\in S}f_s\in\mathcal{D}_n`),
        " である。",
      ]),
      paragraph([
        "使ったのは和の係数が係数の和であることと有限和の性質だけであり、",
        "積も引き算も使っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_degree_prod",
    kind: "claim",
    title: { text: "次数の上界は有限積で足し合わされる" },
    labels: ["claim_second_degree_prod"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.degLe_mul",
      "Ising2DLambda.AlgebraicEigenvalue.degLe_prod",
      "Ising2DLambda.AlgebraicEigenvalue.degLe_prod_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_mul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_prod",
    ],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`S`),
        "、および各 ",
        math(String.raw`s\in S`),
        " について ",
        math(String.raw`n_s\in\mathbb{N}`),
        " と ",
        math(String.raw`f_s\in\mathcal{D}_{n_s}`),
        " が与えられているとする（",
        math(String.raw`\mathcal{D}_n`),
        " は ",
        ref("def_second_degree_bound"),
        "）。このとき",
      ]),
      displayMath(
        String.raw`\prod_{s\in S}f_s\ \in\ \mathcal{D}_{\,\sum_{s\in S}n_s}`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、2 つの元の積について示す。",
        math(String.raw`f\in\mathcal{D}_m`),
        "、",
        math(String.raw`g\in\mathcal{D}_n`),
        " とし、",
        math(String.raw`k>m+n`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " と ",
        math(String.raw`0\le i\le k`),
        " を取る。",
        math(String.raw`i>m`),
        " のときは",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_i(f)\cdot\mathrm{cf}_{k-i}(g)
&=\kappa(0)\cdot\mathrm{cf}_{k-i}(g)
&&(\because\ f\in\mathcal{D}_m\ \text{と}\ i>m)\\
&=\kappa(0)
&&(\because\ \mathbb{Z}[x]\ \text{の零元を掛けると零元})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`i\le m`),
        " のときは ",
        math(String.raw`k-i\ge k-m>n`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_i(f)\cdot\mathrm{cf}_{k-i}(g)
&=\mathrm{cf}_i(f)\cdot\kappa(0)
&&(\because\ g\in\mathcal{D}_n\ \text{と}\ k-i>n)\\
&=\kappa(0)
&&(\because\ \mathbb{Z}[x]\ \text{の零元を掛けると零元})
\end{aligned}`),
      paragraph([
        "である。どちらの場合も項は ",
        math(String.raw`\kappa(0)`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k(f\cdot g)
&=\sum_{i=0}^{k}\mathrm{cf}_i(f)\cdot\mathrm{cf}_{k-i}(g)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の積の係数})\\
&=\sum_{i=0}^{k}\kappa(0)
&&(\because\ \text{上の 2 つの場合})\\
&=\kappa(0)
&&(\because\ \text{零元の有限和は零元})
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`f\cdot g\in\mathcal{D}_{m+n}`),
        " を得る。",
      ]),
      paragraph([
        "本体は ",
        math(String.raw`S`),
        " の元の個数についての帰納法である。",
        math(String.raw`S=\emptyset`),
        " のとき、空積は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元 ",
        math(String.raw`\iota(\kappa(1))`),
        " であり、",
        math(String.raw`k>0=\sum_{s\in\emptyset}n_s`),
        " ならば ",
        math(String.raw`\mathrm{cf}_k(\iota(\kappa(1)))=\kappa(0)`),
        " なので（",
        ref("def_second_constant_embedding"),
        "）、これは ",
        math(String.raw`\mathcal{D}_0`),
        " の元である。",
      ]),
      paragraph([
        "帰納の一歩では、",
        math(String.raw`s_0\notin S'`),
        " として ",
        math(String.raw`S=S'\cup\{s_0\}`),
        " と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{s\in S}f_s
&=f_{s_0}\cdot\prod_{s\in S'}f_s
&&(\because\ \text{有限積から 1 つの因子を括り出す})
\end{aligned}`),
      paragraph([
        "であり、帰納法の仮定より ",
        math(String.raw`\prod_{s\in S'}f_s\in\mathcal{D}_{\sum_{s\in S'}n_s}`),
        " である。準備を ",
        math(String.raw`f=f_{s_0}`),
        "、",
        math(String.raw`g=\prod_{s\in S'}f_s`),
        " に当てると",
      ]),
      displayMath(
        String.raw`\prod_{s\in S}f_s\ \in\ \mathcal{D}_{\,n_{s_0}+\sum_{s\in S'}n_s}=\mathcal{D}_{\,\sum_{s\in S}n_s}`,
      ),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "使ったのは積の係数の形と、零元を掛けると零元になることだけである。",
        "引き算も、零因子が無いことも使っていない",
        "（上界の主張なので、最高次の係数が消えないことを要求していない）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_monic_prod",
    kind: "claim",
    title: { text: "モニックな元の有限積はモニックであり、その次数は次数の和である" },
    labels: ["claim_second_monic_prod"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_mul",
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_prod",
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_prod_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_mul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_prod",
    ],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`S`),
        "、および各 ",
        math(String.raw`s\in S`),
        " について ",
        math(String.raw`n_s\in\mathbb{N}`),
        " と ",
        math(String.raw`f_s\in\mathcal{M}_{n_s}`),
        " が与えられているとする（",
        math(String.raw`\mathcal{M}_n`),
        " は ",
        ref("def_second_monic"),
        "）。このとき",
      ]),
      displayMath(
        String.raw`\prod_{s\in S}f_s\ \in\ \mathcal{M}_{\,\sum_{s\in S}n_s}`,
      ),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、2 つの元の積について示す。",
        math(String.raw`f\in\mathcal{M}_m`),
        "、",
        math(String.raw`g\in\mathcal{M}_n`),
        " とする。",
        math(String.raw`f\in\mathcal{D}_m`),
        " かつ ",
        math(String.raw`g\in\mathcal{D}_n`),
        " なので ",
        ref("claim_second_degree_prod"),
        " の準備より ",
        math(String.raw`f\cdot g\in\mathcal{D}_{m+n}`),
        " である。残るのは ",
        math(String.raw`t^{\,m+n}`),
        " の係数であり、",
        math(String.raw`0\le i\le m+n`),
        " について、",
        math(String.raw`i>m`),
        " のときは ",
        math(String.raw`\mathrm{cf}_i(f)=\kappa(0)`),
        "、",
        math(String.raw`i<m`),
        " のときは ",
        math(String.raw`m+n-i>n`),
        " より ",
        math(String.raw`\mathrm{cf}_{m+n-i}(g)=\kappa(0)`),
        " なので、いずれの場合も項は ",
        math(String.raw`\kappa(0)`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_{m+n}(f\cdot g)
&=\sum_{i=0}^{m+n}\mathrm{cf}_i(f)\cdot\mathrm{cf}_{m+n-i}(g)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の積の係数})\\
&=\mathrm{cf}_m(f)\cdot\mathrm{cf}_{n}(g)
&&(\because\ i\ne m\ \text{の項は}\ \kappa(0)\ \text{であり、零元は和に寄与しない})\\
&=\kappa(1)\cdot\kappa(1)
&&(\because\ \blkref{def_second_monic})\\
&=\kappa(1)
&&(\because\ \kappa(1)\ \text{は}\ \mathbb{Z}[x]\ \text{の単位元})
\end{aligned}`),
      paragraph([
        "となり ",
        math(String.raw`f\cdot g\in\mathcal{M}_{m+n}`),
        " を得る。",
      ]),
      paragraph([
        "本体は ",
        math(String.raw`S`),
        " の元の個数についての帰納法である。",
        math(String.raw`S=\emptyset`),
        " のとき、空積は単位元 ",
        math(String.raw`\iota(\kappa(1))`),
        " であり ",
        math(String.raw`\mathrm{cf}_0(\iota(\kappa(1)))=\kappa(1)`),
        " なので（",
        ref("def_second_constant_embedding"),
        "）、これは ",
        math(String.raw`\mathcal{M}_0`),
        " の元である。",
        "帰納の一歩は ",
        ref("claim_second_degree_prod"),
        " の本体と同じく 1 つの因子を括り出し、準備を当てればよい。",
      ]),
      paragraph([
        "使ったのは積の係数の形、零元を掛けると零元になること、そして ",
        math(String.raw`\kappa(1)`),
        " が単位元であることだけである。引き算も、零因子が無いことも使っていない",
        "（最高次の係数が単位元であることから、積の最高次の係数が消えないことが直接に出る）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_monic_add_lower",
    kind: "claim",
    title: { text: "モニックな元に次数の低い元を足してもモニックである" },
    labels: ["claim_second_monic_add_lower"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_add_of_degLe",
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_add_of_degLe_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_add_of_degLe",
    ],
    verification: ["sagemath/check/second-polynomial-degree"],
    statement: [
      paragraph([
        math(String.raw`n,n'\in\mathbb{N}`),
        " が ",
        math(String.raw`n'<n`),
        " を満たし、",
        math(String.raw`f\in\mathcal{M}_n`),
        " と ",
        math(String.raw`g\in\mathcal{D}_{n'}`),
        " が与えられているとする（",
        ref("def_second_degree_bound"),
        "、",
        ref("def_second_monic"),
        "）。このとき",
      ]),
      displayMath(String.raw`f+g\ \in\ \mathcal{M}_n`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "第一に、",
        math(String.raw`k>n`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k(f+g)
&=\mathrm{cf}_k(f)+\mathrm{cf}_k(g)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の和の係数})\\
&=\kappa(0)+\kappa(0)
&&(\because\ f\in\mathcal{D}_n\ \text{と}\ k>n,\ \ g\in\mathcal{D}_{n'}\ \text{と}\ k>n>n')\\
&=\kappa(0)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`f+g\in\mathcal{D}_n`),
        " である。第二に",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_n(f+g)
&=\mathrm{cf}_n(f)+\mathrm{cf}_n(g)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の和の係数})\\
&=\kappa(1)+\kappa(0)
&&(\because\ \blkref{def_second_monic}\text{、および}\ g\in\mathcal{D}_{n'}\ \text{と}\ n>n')\\
&=\kappa(1)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元})
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math(String.raw`f+g\in\mathcal{M}_n`),
        " を得る。",
      ]),
      paragraph([
        "この主張が次のセクションで効く形は次のとおりである。特性多項式は ",
        ref("def_determinant"),
        " の和であり、恒等置換の項がモニックな次数 ",
        math(String.raw`|R_L|`),
        " の元、他の項の和が次数 ",
        math(String.raw`|R_L|-2`),
        " 以下の元になる。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_matrix",
    kind: "definition",
    title: { text: "もう 1 つの不定元の多項式を成分とする、行配位を添字とする行列" },
    labels: ["def_second_matrix"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.SecondRowMatrix"],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " と同じ形の行列を、成分が ",
        ref("def_second_polynomial_ring"),
        " の ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " である場合について書き下す。すなわち写像 ",
        math(String.raw`B:R_L\times R_L\to\mathbb{Z}[x][t]`),
        " のことを行列と呼び、その全体の集合を ",
        math(String.raw`\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x][t]\bigr)`),
        " と書く。値 ",
        math(String.raw`B(\tau,\tau')`),
        " を成分と呼び ",
        math(String.raw`B_{\tau,\tau'}`),
        " と書く。",
      ]),
      paragraph([
        "成分の住む集合が違うので、",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " とは別の集合である。",
        "一般の可換環を成分とする行列としてまとめて述べることはしない",
        "（人手証明は具体的な対象について書く。抽象化は Lean の必要十分版の側で行う）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_second_determinant",
    kind: "definition",
    title: { text: "もう 1 つの不定元の多項式を成分とする行列の行列式" },
    labels: ["def_second_determinant"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.secondDeterminant"],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_second_matrix"),
        " の行列 ",
        math(String.raw`B\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x][t]\bigr)`),
        " の行列式 ",
        math(String.raw`\mathrm{det}_{t}\,B\in\mathbb{Z}[x][t]`),
        " を",
      ]),
      displayMath(
        String.raw`\mathrm{det}_{t}\,B:=\sum_{\varphi\in\mathfrak{S}_L}\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`\mathfrak{S}_L`),
        " と ",
        math(String.raw`\mathrm{sgn}`),
        " は ",
        ref("def_permutation_sign"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "）。",
        "整数である符号を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元として使う経路は ",
        math(String.raw`\iota\circ\kappa`),
        " だけであり、新しい写像は導入しない。",
      ]),
      paragraph([
        ref("def_determinant"),
        " の ",
        math(String.raw`\det`),
        " とは値の住む集合が違うので、記号を分けて ",
        math(String.raw`\mathrm{det}_{t}`),
        " と書く。",
        "右辺が定まる理由は ",
        ref("def_determinant"),
        " と同じである。和も積も有限個の項からなり、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積は可換かつ結合的なので ",
        math(String.raw`\prod_{\tau\in R_L}`),
        " は因子を並べる順序によらない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_indeterminate_t",
    kind: "definition",
    title: { text: "不定元 t 自身が定める元" },
    labels: ["def_indeterminate_element"],
    habitat: "Z",
    lean: ["Polynomial.X"],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_second_polynomial_ring"),
        " の不定元 ",
        math(String.raw`t`),
        " そのものを ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と見るときの係数を書いておく。すなわち",
      ]),
      displayMath(String.raw`\mathrm{cf}_1(t):=\kappa(1),
\qquad
\mathrm{cf}_k(t):=\kappa(0)\quad(k\ne1)`),
      paragraph([
        "である（",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "以下では係数の言葉だけで議論するので、この 2 つの等式が ",
        math(String.raw`t`),
        " について使う唯一の性質である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_characteristic_matrix",
    kind: "definition",
    title: { text: "転送行列の型の行列に対する特性行列" },
    labels: ["def_characteristic_matrix"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.charMatrix"],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " に対して、",
        ref("def_second_matrix"),
        " の行列 ",
        math(String.raw`\mathrm{ch}(A)\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x][t]\bigr)`),
        " を",
      ]),
      displayMath(String.raw`\mathrm{ch}(A)_{\tau,\tau'}:=
\begin{cases}
t+\iota\bigl(-A_{\tau,\tau}\bigr) & (\tau=\tau'\ \text{のとき})\\
\iota\bigl(-A_{\tau,\tau'}\bigr) & (\tau\ne\tau'\ \text{のとき})
\end{cases}
\qquad(\tau,\tau'\in R_L)`),
      paragraph([
        "で定める（",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "）。",
      ]),
      paragraph([
        "これは通常 ",
        math(String.raw`tI-A`),
        " と書かれる行列であるが、符号の反転を ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で先に済ませてある。",
        math(String.raw`-A_{\tau,\tau'}`),
        " は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の加法についての逆元であり、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元として扱う経路は ",
        math(String.raw`\iota`),
        " だけである。",
        "こう書くと、以下の議論に ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の引き算が一度も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_characteristic_polynomial",
    kind: "definition",
    title: { text: "転送行列の型の行列に対する特性多項式" },
    labels: ["def_characteristic_polynomial"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.charPoly"],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " の特性多項式 ",
        math(String.raw`\chi_A\in\mathbb{Z}[x][t]`),
        " を",
      ]),
      displayMath(String.raw`\chi_A:=\mathrm{det}_{t}\bigl(\mathrm{ch}(A)\bigr)`),
      paragraph([
        "で定める（",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`\mathrm{det}_{t}`),
        " は ",
        ref("def_second_determinant"),
        "）。",
        "とくに ",
        ref("def_transfer_matrix"),
        " の転送行列 ",
        math(String.raw`T`),
        " に対する ",
        math(String.raw`\chi_T`),
        " が、この章の目標である。",
      ]),
      paragraph([
        "現れるのは整数、有限和、有限積、および ",
        math(String.raw`\mathbb{Z}[x]`),
        " と ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_const_degree_zero",
    kind: "claim",
    title: { text: "定数として送った元の次数は 0 以下である" },
    labels: ["claim_second_const_degree_zero"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.degLe_constSecond",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.degLe_C",
    ],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`a\in\mathbb{Z}[x]`),
        " について ",
        math(String.raw`\iota(a)\in\mathcal{D}_0`),
        " である（",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\mathcal{D}_0`),
        " は ",
        ref("def_second_degree_bound"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k>0`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k\bigl(\iota(a)\bigr)
&=\kappa(0)
&&(\because\ \blkref{def_second_constant_embedding}\ \text{と}\ k\ge1)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`k>0`),
        " を満たす ",
        math(String.raw`k`),
        " は任意だったので ",
        math(String.raw`\iota(a)\in\mathcal{D}_0`),
        " である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_linear_monic",
    kind: "claim",
    title: { text: "不定元に定数を足したものはモニックな次数 1 の元である" },
    labels: ["claim_second_linear_monic"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_indeterminate_add_constSecond",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_X_add_C",
    ],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`a\in\mathbb{Z}[x]`),
        " について ",
        math(String.raw`t+\iota(a)\in\mathcal{M}_1`),
        " である（",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\mathcal{M}_1`),
        " は ",
        ref("def_second_monic"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "第一に、",
        math(String.raw`k>1`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_k\bigl(t+\iota(a)\bigr)
&=\mathrm{cf}_k(t)+\mathrm{cf}_k\bigl(\iota(a)\bigr)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の和の係数})\\
&=\kappa(0)+\kappa(0)
&&(\because\ \blkref{def_indeterminate_element}\ \text{と}\ k\ne1,\ \ \blkref{def_second_constant_embedding}\ \text{と}\ k\ge1)\\
&=\kappa(0)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`t+\iota(a)\in\mathcal{D}_1`),
        " である。第二に",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{cf}_1\bigl(t+\iota(a)\bigr)
&=\mathrm{cf}_1(t)+\mathrm{cf}_1\bigl(\iota(a)\bigr)
&&(\because\ \blkref{def_second_polynomial_ring}\ \text{の和の係数})\\
&=\kappa(1)+\kappa(0)
&&(\because\ \blkref{def_indeterminate_element}\ \text{、および}\ \blkref{def_second_constant_embedding}\ \text{と}\ 1\ge1)\\
&=\kappa(1)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元})
\end{aligned}`),
      paragraph([
        "である。以上より ",
        math(String.raw`t+\iota(a)\in\mathcal{M}_1`),
        " を得る。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_characteristic_polynomial_monic",
    kind: "claim",
    title: {
      text: "特性多項式はモニックであり、その次数は行配位の個数に等しい",
    },
    labels: ["claim_characteristic_polynomial_monic"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_charPoly",
      "Ising2DLambda.AlgebraicEigenvalue.monicDeg_charPoly_from_necSuf",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monicDeg_charDet",
    ],
    verification: ["sagemath/check/characteristic-polynomial"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の任意の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " について",
      ]),
      displayMath(String.raw`\chi_A\ \in\ \mathcal{M}_{2^{L}}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\chi_A`),
        " は ",
        ref("def_characteristic_polynomial"),
        "、",
        math(String.raw`\mathcal{M}_n`),
        " は ",
        ref("def_second_monic"),
        "）。",
        "とくに ",
        ref("def_transfer_matrix"),
        " の転送行列について ",
        math(String.raw`\chi_T\in\mathcal{M}_{2^{L}}`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う記号を先に置く。",
        ref("def_row_permutation"),
        " の置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " に対して",
      ]),
      displayMath(
        String.raw`u(\varphi):=\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(A)_{\tau,\varphi(\tau)}\ \in\ \mathbb{Z}[x][t]`,
      ),
      paragraph([
        "と置く（",
        ref("def_second_determinant"),
        " の和の各項である）。また ",
        ref("claim_permutation_moves_two"),
        " の ",
        math(String.raw`M(\varphi)=\{\tau\in R_L\mid\varphi(\tau)\ne\tau\}`),
        " を使う。",
        math(String.raw`|R_L|=2^{L}`),
        " であり（",
        ref("def_row_configuration"),
        "）、",
        math(String.raw`L\ge1`),
        " なので ",
        math(String.raw`2^{L}\ge2`),
        " である。",
      ]),
      paragraph([
        "準備の第一は、恒等写像の項がモニックな次数 ",
        math(String.raw`2^{L}`),
        " の元であることである。",
        math(String.raw`\mathrm{id}_{R_L}(\tau)=\tau`),
        " なので各因子は ",
        math(String.raw`t+\iota(-A_{\tau,\tau})`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\tau\in R_L}\mathrm{ch}(A)_{\tau,\mathrm{id}_{R_L}(\tau)}
&=\prod_{\tau\in R_L}\bigl(t+\iota(-A_{\tau,\tau})\bigr)
&&(\because\ \blkref{def_characteristic_matrix})\\
&\in\ \mathcal{M}_{\,\sum_{\tau\in R_L}1}
&&(\because\ \blkref{claim_second_linear_monic}\ \text{、}\ \blkref{claim_second_monic_prod})\\
&=\mathcal{M}_{\,|R_L|}=\mathcal{M}_{\,2^{L}}
&&(\because\ \blkref{def_row_configuration}\ \text{の}\ |R_L|=2^{L})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "準備の第二は、恒等写像でない ",
        math(String.raw`\varphi`),
        " について ",
        math(String.raw`u(\varphi)\in\mathcal{D}_{2^{L}-2}`),
        " であることである。各 ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`n_\tau:=0\ (\tau\in M(\varphi))`),
        "、",
        math(String.raw`n_\tau:=1\ (\tau\notin M(\varphi))`),
        " と置くと、",
        math(String.raw`\tau\in M(\varphi)`),
        " の因子は ",
        math(String.raw`\iota(-A_{\tau,\varphi(\tau)})\in\mathcal{D}_0`),
        "（",
        ref("claim_second_const_degree_zero"),
        "）、",
        math(String.raw`\tau\notin M(\varphi)`),
        " の因子は ",
        math(String.raw`t+\iota(-A_{\tau,\tau})\in\mathcal{M}_1\subset\mathcal{D}_1`),
        "（",
        ref("claim_second_linear_monic"),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\tau\in R_L}n_\tau
&=|R_L|-|M(\varphi)|
&&(\because\ n_\tau\ \text{は}\ M(\varphi)\ \text{の外でだけ}\ 1)\\
&\le|R_L|-2
&&(\because\ \blkref{claim_permutation_moves_two})\\
&=2^{L}-2
&&(\because\ \blkref{def_row_configuration}\ \text{の}\ |R_L|=2^{L})
\end{aligned}`),
      paragraph([
        "なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\tau\in R_L}\mathrm{ch}(A)_{\tau,\varphi(\tau)}
&\in\ \mathcal{D}_{\,\sum_{\tau\in R_L}n_\tau}
&&(\because\ \blkref{claim_second_degree_prod})\\
&\subset\ \mathcal{D}_{\,2^{L}-2}
&&(\because\ \blkref{def_second_degree_bound}\ \text{の}\ \mathcal{D}_n\subset\mathcal{D}_{n'}\ (n\le n'))
\end{aligned}`),
      paragraph([
        "であり、係数 ",
        math(String.raw`\iota(\kappa(\mathrm{sgn}(\varphi)))`),
        " は ",
        ref("claim_second_const_degree_zero"),
        " より ",
        math(String.raw`\mathcal{D}_0`),
        " の元だから、2 つの元の積についての ",
        ref("claim_second_degree_prod"),
        " を当てて ",
        math(String.raw`u(\varphi)\in\mathcal{D}_{0+(2^{L}-2)}=\mathcal{D}_{2^{L}-2}`),
        " を得る。",
      ]),
      paragraph([
        "準備の第三は、恒等写像でない項の総和が ",
        math(String.raw`\mathcal{D}_{2^{L}-2}`),
        " の元であることである。これは準備の第二と ",
        ref("claim_second_degree_sum"),
        " から出る。",
      ]),
      paragraph([
        "以上のもとで",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_A
&=\mathrm{det}_{t}\bigl(\mathrm{ch}(A)\bigr)
&&(\because\ \blkref{def_characteristic_polynomial})\\
&=\sum_{\varphi\in\mathfrak{S}_L}u(\varphi)
&&(\because\ \blkref{def_second_determinant}\ \text{と}\ u\ \text{の定め方})\\
&=u(\mathrm{id}_{R_L})+\sum_{\varphi\in\mathfrak{S}_L,\ \varphi\ne\mathrm{id}_{R_L}}u(\varphi)
&&(\because\ \text{有限和から 1 つの項を括り出す})\\
&=\iota\bigl(\kappa(1)\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(A)_{\tau,\mathrm{id}_{R_L}(\tau)}+\sum_{\varphi\ne\mathrm{id}_{R_L}}u(\varphi)
&&(\because\ \blkref{claim_permutation_sign_values}\ \text{の}\ \mathrm{sgn}(\mathrm{id}_{R_L})=1)\\
&=\prod_{\tau\in R_L}\mathrm{ch}(A)_{\tau,\mathrm{id}_{R_L}(\tau)}+\sum_{\varphi\ne\mathrm{id}_{R_L}}u(\varphi)
&&(\because\ \blkref{def_second_constant_embedding}\ \text{の}\ \iota(\kappa(1))\ \text{は単位元})
\end{aligned}`),
      paragraph([
        "である。第 1 項は準備の第一より ",
        math(String.raw`\mathcal{M}_{2^{L}}`),
        " の元、第 2 項は準備の第三より ",
        math(String.raw`\mathcal{D}_{2^{L}-2}`),
        " の元であり、",
        math(String.raw`2^{L}\ge2`),
        " から ",
        math(String.raw`2^{L}-2<2^{L}`),
        " なので、",
        ref("claim_second_monic_add_lower"),
        " より ",
        math(String.raw`\chi_A\in\mathcal{M}_{2^{L}}`),
        " を得る。",
      ]),
      paragraph([
        "使ったのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の和と積、",
        math(String.raw`\iota(\kappa(1))`),
        " が単位元であること、恒等写像の符号が ",
        math(String.raw`1`),
        " であること、そして恒等写像でない置換が 2 点以上を動かすことだけである。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の引き算は一度も使っていない",
        "（符号の反転は ",
        ref("def_characteristic_matrix"),
        " で ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中に閉じ込めてある）。",
        "符号の乗法性（",
        ref("claim_permutation_sign_mul"),
        "）も使っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_column_translation",
    kind: "definition",
    title: { text: "列番号の平行移動" },
    labels: ["def_column_translation"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.columnTranslation"],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`\gamma:\mathbb{Z}/L\mathbb{Z}\to\mathbb{Z}/L\mathbb{Z}`),
        " を",
      ]),
      displayMath(
        String.raw`\gamma(y):=y+_{\mathbb{Z}/L\mathbb{Z}}\bar1\qquad(y\in\mathbb{Z}/L\mathbb{Z})`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`+_{\mathbb{Z}/L\mathbb{Z}}`),
        " と ",
        math(String.raw`\bar1`),
        " は ",
        ref("def_lattice"),
        "）。",
        ref("def_lattice"),
        " の格子で列番号が ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の元であることから、この写像は列番号を 1 つ進める操作にあたる。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " とその加法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_column_translation_bijective",
    kind: "claim",
    title: { text: "列番号の平行移動は全単射である" },
    labels: ["claim_column_translation_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslationEquiv",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.translationEquiv",
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslation_eq_necSuf",
    ],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        ref("def_column_translation"),
        " の ",
        math(String.raw`\gamma`),
        " は全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う写像を先に置く。",
        math(String.raw`-\bar1`),
        " を ",
        math(String.raw`\bar1`),
        " の ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " における加法の逆元とし、写像 ",
        math(String.raw`\gamma':\mathbb{Z}/L\mathbb{Z}\to\mathbb{Z}/L\mathbb{Z}`),
        " を ",
        math(String.raw`\gamma'(y):=y+_{\mathbb{Z}/L\mathbb{Z}}(-\bar1)`),
        " で定める。",
      ]),
      paragraph([
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma'\bigl(\gamma(y)\bigr)
&=\bigl(y+_{\mathbb{Z}/L\mathbb{Z}}\bar1\bigr)+_{\mathbb{Z}/L\mathbb{Z}}(-\bar1)
&&(\because\ \blkref{def_column_translation}\ \text{と}\ \gamma'\ \text{の定め方})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\bigl(\bar1+_{\mathbb{Z}/L\mathbb{Z}}(-\bar1)\bigr)
&&(\because\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の結合則})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}0
&&(\because\ -\bar1\ \text{は}\ \bar1\ \text{の加法の逆元})\\
&=y
&&(\because\ 0\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の単位元})
\end{aligned}`),
      paragraph([
        "であり、また",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma\bigl(\gamma'(y)\bigr)
&=\bigl(y+_{\mathbb{Z}/L\mathbb{Z}}(-\bar1)\bigr)+_{\mathbb{Z}/L\mathbb{Z}}\bar1
&&(\because\ \blkref{def_column_translation}\ \text{と}\ \gamma'\ \text{の定め方})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\bigl((-\bar1)+_{\mathbb{Z}/L\mathbb{Z}}\bar1\bigr)
&&(\because\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の結合則})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}0
&&(\because\ -\bar1\ \text{は}\ \bar1\ \text{の加法の逆元})\\
&=y
&&(\because\ 0\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の単位元})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`y`),
        " は任意だったので ",
        math(String.raw`\gamma'\circ\gamma`),
        " と ",
        math(String.raw`\gamma\circ\gamma'`),
        " はともに ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の恒等写像である。したがって ",
        math(String.raw`\gamma`),
        " は全単射で、その逆写像は ",
        math(String.raw`\gamma'`),
        " である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_shift",
    kind: "definition",
    title: { text: "行配位の巡回シフト" },
    labels: ["def_row_config_shift"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowShift"],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        ref("def_row_configuration"),
        " の行配位 ",
        math(String.raw`\tau\in R_L`),
        " に対し、その巡回シフト ",
        math(String.raw`S(\tau)`),
        " を",
      ]),
      displayMath(
        String.raw`\bigl(S(\tau)\bigr)(y):=\tau\bigl(\gamma(y)\bigr)\qquad(y\in\mathbb{Z}/L\mathbb{Z})`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`\gamma`),
        " は ",
        ref("def_column_translation"),
        "）。",
        math(String.raw`S(\tau)`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " から ",
        math(String.raw`\{+1,-1\}`),
        " への写像なので ",
        math(String.raw`R_L`),
        " の元であり、",
        math(String.raw`S:R_L\to R_L`),
        " は写像である。",
      ]),
      paragraph([
        "行配位を 1 列ぶんずらす操作である。次のセクションで転送行列をこの操作で分けるために使う。",
        "この定義に現れるのは有限集合とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_bijective",
    kind: "claim",
    title: { text: "行配位の巡回シフトは全単射である" },
    labels: ["claim_row_config_shift_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftEquiv",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.precompEquiv",
      "Ising2DLambda.AlgebraicEigenvalue.rowShift_eq_necSuf",
    ],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        ref("def_row_config_shift"),
        " の ",
        math(String.raw`S:R_L\to R_L`),
        " は全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う写像を先に置く。",
        ref("claim_column_translation_bijective"),
        " の逆写像を ",
        math(String.raw`\gamma'`),
        " と書き、写像 ",
        math(String.raw`S':R_L\to R_L`),
        " を ",
        math(String.raw`\bigl(S'(\tau)\bigr)(y):=\tau\bigl(\gamma'(y)\bigr)`),
        " で定める。",
      ]),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " と ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S'(S(\tau))\bigr)(y)
&=\bigl(S(\tau)\bigr)\bigl(\gamma'(y)\bigr)
&&(\because\ S'\ \text{の定め方})\\
&=\tau\bigl(\gamma(\gamma'(y))\bigr)
&&(\because\ \blkref{def_row_config_shift})\\
&=\tau(y)
&&(\because\ \blkref{claim_column_translation_bijective}\ \text{の}\ \gamma\circ\gamma'=\mathrm{id})
\end{aligned}`),
      paragraph([
        "であり、また",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S(S'(\tau))\bigr)(y)
&=\bigl(S'(\tau)\bigr)\bigl(\gamma(y)\bigr)
&&(\because\ \blkref{def_row_config_shift})\\
&=\tau\bigl(\gamma'(\gamma(y))\bigr)
&&(\because\ S'\ \text{の定め方})\\
&=\tau(y)
&&(\because\ \blkref{claim_column_translation_bijective}\ \text{の}\ \gamma'\circ\gamma=\mathrm{id})
\end{aligned}`),
      paragraph([
        "である。2 つの写像が等しいとは定義域のすべての元での値が等しいことなので、",
        math(String.raw`y`),
        " が任意であることから ",
        math(String.raw`S'(S(\tau))=\tau`),
        " かつ ",
        math(String.raw`S(S'(\tau))=\tau`),
        " である。さらに ",
        math(String.raw`\tau`),
        " が任意であることから ",
        math(String.raw`S'\circ S`),
        " と ",
        math(String.raw`S\circ S'`),
        " はともに ",
        math(String.raw`R_L`),
        " の恒等写像であり、",
        math(String.raw`S`),
        " は全単射で逆写像は ",
        math(String.raw`S'`),
        " である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_intra_row_shift_invariant",
    kind: "claim",
    title: { text: "行内破れ数は巡回シフトで変わらない" },
    labels: ["claim_intra_row_shift_invariant"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.intraRowBrokenCount_rowShift",
      "Ising2DLambda.AlgebraicEigenvalue.card_filter_columnTranslation",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv",
      "Ising2DLambda.AlgebraicEigenvalue.intraRowBrokenCount_rowShift_from_necSuf",
    ],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`b_{\mathrm{h}}\bigl(S(\tau)\bigr)=b_{\mathrm{h}}(\tau)`),
        " である（",
        math(String.raw`b_{\mathrm{h}}`),
        " は ",
        ref("def_intra_row_broken_count"),
        "、",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う集合を先に置く。",
      ]),
      displayMath(
        String.raw`X:=\bigl\{\,z\in\mathbb{Z}/L\mathbb{Z}\;\bigm|\;\tau(z)\ne\tau\bigl(\gamma(z)\bigr)\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`\gamma`),
        " は ",
        ref("def_column_translation"),
        "）。",
        ref("def_intra_row_broken_count"),
        " が ",
        math(String.raw`b_{\mathrm{h}}(\tau)`),
        " を定めるのに使う集合は ",
        math(
          String.raw`\bigl\{\,z\in\mathbb{Z}/L\mathbb{Z}\;\bigm|\;\tau(z)\ne\tau(z+_{\mathbb{Z}/L\mathbb{Z}}\bar1)\,\bigr\}`,
        ),
        " であり、",
        ref("def_column_translation"),
        " の ",
        math(String.raw`\gamma(z)=z+_{\mathbb{Z}/L\mathbb{Z}}\bar1`),
        " によりこれは ",
        math(String.raw`X`),
        " に等しい。したがって ",
        math(String.raw`b_{\mathrm{h}}(\tau)=|X|`),
        " である。",
      ]),
      paragraph([
        "また ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S(\tau)\bigr)(y)\ne\bigl(S(\tau)\bigr)\bigl(y+_{\mathbb{Z}/L\mathbb{Z}}\bar1\bigr)
&\iff \bigl(S(\tau)\bigr)(y)\ne\bigl(S(\tau)\bigr)\bigl(\gamma(y)\bigr)
&&(\because\ \blkref{def_column_translation})\\
&\iff \tau\bigl(\gamma(y)\bigr)\ne\tau\bigl(\gamma(\gamma(y))\bigr)
&&(\because\ \blkref{def_row_config_shift}\ \text{を 2 箇所へ適用})\\
&\iff \gamma(y)\in X
&&(\because\ X\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "である。したがって ",
        math(String.raw`b_{\mathrm{h}}(S(\tau))`),
        " を定める集合は ",
        math(String.raw`X`),
        " の ",
        math(String.raw`\gamma`),
        " による逆像 ",
        math(String.raw`\gamma^{-1}(X)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
b_{\mathrm{h}}\bigl(S(\tau)\bigr)
&=\bigl|\gamma^{-1}(X)\bigr|
&&(\because\ \blkref{def_intra_row_broken_count}\ \text{と上の同値})\\
&=|X|
&&(\because\ \blkref{claim_column_translation_bijective}\ \text{より}\ \gamma\ \text{は}\ \gamma^{-1}(X)\ \text{から}\ X\ \text{への全単射})\\
&=b_{\mathrm{h}}(\tau)
&&(\because\ X\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "を得る。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_inter_row_shift_invariant",
    kind: "claim",
    title: { text: "行間破れ数は 2 つの行配位を同時に巡回シフトしても変わらない" },
    labels: ["claim_inter_row_shift_invariant"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.interRowBrokenCount_rowShift",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_filter_comp_equiv",
      "Ising2DLambda.AlgebraicEigenvalue.interRowBrokenCount_rowShift_from_necSuf",
    ],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について ",
        math(String.raw`b_{\mathrm{v}}\bigl(S(\tau),S(\tau')\bigr)=b_{\mathrm{v}}(\tau,\tau')`),
        " である（",
        math(String.raw`b_{\mathrm{v}}`),
        " は ",
        ref("def_inter_row_broken_count"),
        "、",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う集合を先に置く。",
      ]),
      displayMath(
        String.raw`Y:=\bigl\{\,z\in\mathbb{Z}/L\mathbb{Z}\;\bigm|\;\tau(z)\ne\tau'(z)\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
        ref("def_inter_row_broken_count"),
        " の ",
        math(String.raw`b_{\mathrm{v}}(\tau,\tau')`),
        " を定める集合はこの ",
        math(String.raw`Y`),
        " そのものであり、",
        math(String.raw`b_{\mathrm{v}}(\tau,\tau')=|Y|`),
        " である。",
      ]),
      paragraph([
        "また ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S(\tau)\bigr)(y)\ne\bigl(S(\tau')\bigr)(y)
&\iff \tau\bigl(\gamma(y)\bigr)\ne\tau'\bigl(\gamma(y)\bigr)
&&(\because\ \blkref{def_row_config_shift}\ \text{を 2 箇所へ適用})\\
&\iff \gamma(y)\in Y
&&(\because\ Y\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "である。したがって ",
        math(String.raw`b_{\mathrm{v}}(S(\tau),S(\tau'))`),
        " を定める集合は ",
        math(String.raw`\gamma^{-1}(Y)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
b_{\mathrm{v}}\bigl(S(\tau),S(\tau')\bigr)
&=\bigl|\gamma^{-1}(Y)\bigr|
&&(\because\ \blkref{def_inter_row_broken_count}\ \text{と上の同値})\\
&=|Y|
&&(\because\ \blkref{claim_column_translation_bijective}\ \text{より}\ \gamma\ \text{は}\ \gamma^{-1}(Y)\ \text{から}\ Y\ \text{への全単射})\\
&=b_{\mathrm{v}}(\tau,\tau')
&&(\because\ Y\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "を得る。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_transfer_matrix_shift_invariant",
    kind: "claim",
    title: { text: "転送行列の成分は行と列を同時に巡回シフトしても変わらない" },
    labels: ["claim_transfer_matrix_shift_invariant"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.transferMatrix_rowShift",
    ],
    verification: ["sagemath/check/row-config-shift"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について",
      ]),
      displayMath(String.raw`T_{S(\tau),S(\tau')}=T_{\tau,\tau'}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`T`),
        " は ",
        ref("def_transfer_matrix"),
        "、",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
T_{S(\tau),S(\tau')}
&=x^{\,b_{\mathrm{h}}(S(\tau))+b_{\mathrm{v}}(S(\tau),S(\tau'))}
&&(\because\ \blkref{def_transfer_matrix})\\
&=x^{\,b_{\mathrm{h}}(\tau)+b_{\mathrm{v}}(S(\tau),S(\tau'))}
&&(\because\ \blkref{claim_intra_row_shift_invariant})\\
&=x^{\,b_{\mathrm{h}}(\tau)+b_{\mathrm{v}}(\tau,\tau')}
&&(\because\ \blkref{claim_inter_row_shift_invariant})\\
&=T_{\tau,\tau'}
&&(\because\ \blkref{def_transfer_matrix})
\end{aligned}`),
      paragraph([
        "を得る。指数は ",
        math(String.raw`\mathbb{N}`),
        " の元、成分は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_shift_matrix",
    kind: "definition",
    title: { text: "シフト行列" },
    labels: ["def_shift_matrix"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.shiftMatrix"],
    verification: ["sagemath/check/shift-matrix"],
    statement: [
      paragraph([
        "シフト行列 ",
        math(String.raw`U\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        " を、その成分により",
      ]),
      displayMath(String.raw`U_{\tau,\tau'}:=
\begin{cases}
\kappa(1) & (\tau'=S(\tau)\ \text{のとき})\\
\kappa(0) & (\tau'\ne S(\tau)\ \text{のとき})
\end{cases}
\qquad(\tau,\tau'\in R_L)`),
      paragraph([
        "で定める（",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、行列の集合は ",
        ref("def_matrix_over_row_configs"),
        "）。",
        ref("def_row_config_shift"),
        " の ",
        math(String.raw`S`),
        " は写像なので、各 ",
        math(String.raw`\tau\in R_L`),
        " に対し ",
        math(String.raw`\tau'=S(\tau)`),
        " となる ",
        math(String.raw`\tau'`),
        " はちょうど 1 つであり、場合分けはすべての対 ",
        math(String.raw`(\tau,\tau')`),
        " に対してどちらか一方だけに当たる。",
      ]),
      paragraph([
        "成分は ",
        math(String.raw`\kappa`),
        " の像なので ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_matrix_left",
    kind: "claim",
    title: { text: "シフト行列を左から掛けると行の添字がシフトされる" },
    labels: ["claim_shift_matrix_left"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_mul_apply",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_mul_apply",
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_mul_apply_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix"],
    statement: [
      paragraph([
        "任意の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " と任意の ",
        math(String.raw`\tau,\tau''\in R_L`),
        " について",
      ]),
      displayMath(String.raw`(UA)_{\tau,\tau''}=A_{S(\tau),\tau''}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、積は ",
        ref("def_matrix_product"),
        "）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
(UA)_{\tau,\tau''}
&=\sum_{\tau'\in R_L}U_{\tau,\tau'}\,A_{\tau',\tau''}
&&(\because\ \blkref{def_matrix_product})\\
&=U_{\tau,S(\tau)}\,A_{S(\tau),\tau''}
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S(\tau)}}U_{\tau,\tau'}\,A_{\tau',\tau''}
&&(\because\ R_L\ \text{を}\ \{S(\tau)\}\ \text{とその補集合へ分けた}) \\
&=\kappa(1)\cdot A_{S(\tau),\tau''}
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S(\tau)}}\kappa(0)\cdot A_{\tau',\tau''}
&&(\because\ \blkref{def_shift_matrix}\ \text{を 2 箇所へ適用})\\
&=A_{S(\tau),\tau''}
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S(\tau)}}\kappa(0)\cdot A_{\tau',\tau''}
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(1)\ \text{は}\ \mathbb{Z}[x]\ \text{の単位元})\\
&=A_{S(\tau),\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne S(\tau)}}\kappa(0)
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(0)\ \text{は零元で、零元と任意の元の積は零元})\\
&=A_{S(\tau),\tau''}+\kappa(0)
&&(\because\ \text{零元の有限個の和は零元})\\
&=A_{S(\tau),\tau''}
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(0)\ \text{は零元})
\end{aligned}`),
      paragraph([
        "を得る。第 2 の等号で和を 2 つに分けられるのは、",
        ref("def_row_config_shift"),
        " の ",
        math(String.raw`S`),
        " が写像であることから ",
        math(String.raw`S(\tau)`),
        " が ",
        math(String.raw`R_L`),
        " のただ 1 つの元として定まり、",
        math(String.raw`R_L`),
        " が ",
        math(String.raw`\{S(\tau)\}`),
        " とその補集合の互いに素な合併になるからである。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " の有限個の元の和と積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_matrix_right",
    kind: "claim",
    title: { text: "シフト行列を右から掛けると列の添字が逆向きにシフトされる" },
    labels: ["claim_shift_matrix_right"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.mul_shiftMatrix_apply",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_permMatrix_apply",
      "Ising2DLambda.AlgebraicEigenvalue.mul_shiftMatrix_apply_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix"],
    statement: [
      paragraph([
        ref("claim_row_config_shift_bijective"),
        " の逆写像を ",
        math(String.raw`S'`),
        " と書く。任意の行列 ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " と任意の ",
        math(String.raw`\tau,\tau''\in R_L`),
        " について",
      ]),
      displayMath(String.raw`(AU)_{\tau,\tau''}=A_{\tau,S'(\tau'')}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、積は ",
        ref("def_matrix_product"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う同値を先に置く。",
        math(String.raw`\tau',\tau''\in R_L`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau''=S(\tau')
&\iff S'(\tau'')=S'\bigl(S(\tau')\bigr)
&&(\because\ S'\ \text{は写像であり、かつ単射})\\
&\iff S'(\tau'')=\tau'
&&(\because\ \blkref{claim_row_config_shift_bijective}\ \text{の}\ S'\circ S=\mathrm{id})
\end{aligned}`),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`\tau''=S(\tau')`),
        " となる ",
        math(String.raw`\tau'`),
        " はちょうど ",
        math(String.raw`S'(\tau'')`),
        " だけである。",
      ]),
      displayMath(String.raw`\begin{aligned}
(AU)_{\tau,\tau''}
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,U_{\tau',\tau''}
&&(\because\ \blkref{def_matrix_product})\\
&=A_{\tau,S'(\tau'')}\,U_{S'(\tau''),\tau''}
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S'(\tau'')}}A_{\tau,\tau'}\,U_{\tau',\tau''}
&&(\because\ R_L\ \text{を}\ \{S'(\tau'')\}\ \text{とその補集合へ分けた})\\
&=A_{\tau,S'(\tau'')}\cdot\kappa(1)
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S'(\tau'')}}A_{\tau,\tau'}\cdot\kappa(0)
&&(\because\ \blkref{def_shift_matrix}\ \text{と上の同値を 2 箇所へ適用})\\
&=A_{\tau,S'(\tau'')}
  +\sum_{\substack{\tau'\in R_L\\ \tau'\ne S'(\tau'')}}A_{\tau,\tau'}\cdot\kappa(0)
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(1)\ \text{は}\ \mathbb{Z}[x]\ \text{の単位元})\\
&=A_{\tau,S'(\tau'')}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne S'(\tau'')}}\kappa(0)
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(0)\ \text{は零元で、任意の元と零元の積は零元})\\
&=A_{\tau,S'(\tau'')}+\kappa(0)
&&(\because\ \text{零元の有限個の和は零元})\\
&=A_{\tau,S'(\tau'')}
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa(0)\ \text{は零元})
\end{aligned}`),
      paragraph([
        "を得る。現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " の有限個の元の和と積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_theorem_shift_matrix_commutes",
    kind: "theorem",
    title: { text: "シフト行列と転送行列は可換である" },
    labels: ["theorem_shift_matrix_commutes"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_transferMatrix_comm",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_comm",
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_transferMatrix_comm_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix"],
    statement: [
      paragraph([
        ref("def_shift_matrix"),
        " の ",
        math(String.raw`U`),
        " と ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`T`),
        " について",
      ]),
      displayMath(String.raw`UT=TU`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\mathbb{Z}[x]`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau''\in R_L`),
        " を任意に取り、",
        ref("claim_row_config_shift_bijective"),
        " の逆写像を ",
        math(String.raw`S'`),
        " と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
(UT)_{\tau,\tau''}
&=T_{S(\tau),\tau''}
&&(\because\ \blkref{claim_shift_matrix_left})\\
&=T_{S(\tau),\,S(S'(\tau''))}
&&(\because\ \blkref{claim_row_config_shift_bijective}\ \text{の}\ S\circ S'=\mathrm{id})\\
&=T_{\tau,\,S'(\tau'')}
&&(\because\ \blkref{claim_transfer_matrix_shift_invariant})\\
&=(TU)_{\tau,\tau''}
&&(\because\ \blkref{claim_shift_matrix_right})
\end{aligned}`),
      paragraph([
        "を得る。",
        math(String.raw`\tau,\tau''`),
        " は任意だったので ",
        math(String.raw`UT=TU`),
        " である。",
      ]),
      paragraph([
        "この可換性が、次のセクションで転送行列を巡回シフトの固有空間へ分けるための足場である。",
        "成分は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、この証明にも実数体も複素数体も現れない。",
      ]),
    ],
  },


  {
    id: "algebraic_eigenvalue_definition_column_translation_iterate",
    kind: "definition",
    title: { text: "列番号の平行移動の反復" },
    labels: ["def_column_translation_iterate"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate"],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        ref("def_column_translation"),
        " の ",
        math(String.raw`\gamma`),
        " を ",
        math(String.raw`k`),
        " 回施す写像 ",
        math(String.raw`\gamma^{[k]}:\mathbb{Z}/L\mathbb{Z}\to\mathbb{Z}/L\mathbb{Z}`),
        " を、",
        math(String.raw`k\in\mathbb{N}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\gamma^{[0]}:=\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}},
\qquad
\gamma^{[k+1]}:=\gamma^{[k]}\circ\gamma`),
      paragraph([
        "により定める（",
        math(String.raw`\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}}`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の恒等写像）。",
      ]),
      paragraph([
        "冪の記法 ",
        math(String.raw`\gamma^{k}`),
        " を使わず角括弧を付けた ",
        math(String.raw`\gamma^{[k]}`),
        " と書くのは、この上付き文字が積の反復ではなく合成の反復であることを記号に残すためである",
        "（1 つの記号に 2 つの意味を持たせない）。",
      ]),
      paragraph([
        "合成の順を ",
        math(String.raw`\gamma^{[k]}\circ\gamma`),
        " と定め ",
        math(String.raw`\gamma\circ\gamma^{[k]}`),
        " と定めないのは、次の ",
        ref("def_row_config_shift_iterate"),
        " の反復と段ごとに噛み合わせるためである。",
        "どちらの順で定めても同じ写像になるが、その一致を言うには別に 1 つ証明が要るので、",
        "はじめから噛み合う側に固定する。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_column_translation_iterate_apply",
    kind: "claim",
    title: { text: "反復した平行移動は剰余類を足す操作である" },
    labels: ["claim_column_translation_iterate_apply"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_apply",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterRight_add_apply",
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_apply_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " と任意の ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`\gamma^{[k]}(y)=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\gamma^{[k]}`),
        " は ",
        ref("def_column_translation_iterate"),
        "、",
        math(String.raw`\pi`),
        " と ",
        math(String.raw`+_{\mathbb{Z}/L\mathbb{Z}}`),
        " は ",
        ref("def_lattice"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき、",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma^{[0]}(y)
&=y
&&(\because\ \blkref{def_column_translation_iterate}\ \text{の}\ \gamma^{[0]}=\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}0
&&(\because\ 0\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の単位元})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(0)
&&(\because\ \blkref{def_lattice}\ \text{の}\ \pi\ \text{について}\ \pi(0)=0+L\mathbb{Z}=L\mathbb{Z}=0)
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`k`),
        " について主張が成り立つとする。",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma^{[k+1]}(y)
&=\gamma^{[k]}\bigl(\gamma(y)\bigr)
&&(\because\ \blkref{def_column_translation_iterate}\ \text{の}\ \gamma^{[k+1]}=\gamma^{[k]}\circ\gamma)\\
&=\gamma(y)+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)
&&(\because\ \text{帰納法の仮定を}\ \gamma(y)\ \text{へ適用})\\
&=\bigl(y+_{\mathbb{Z}/L\mathbb{Z}}\bar1\bigr)+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)
&&(\because\ \blkref{def_column_translation})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\bigl(\bar1+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)\bigr)
&&(\because\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の結合則})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\bigl(\pi(1)+_{\mathbb{Z}/L\mathbb{Z}}\pi(k)\bigr)
&&(\because\ \blkref{def_lattice}\ \text{の}\ \bar1=\pi(1))\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(1+k)
&&(\because\ \pi\ \text{は加法を保つ})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(k+1)
&&(\because\ \mathbb{Z}\ \text{の加法の可換性})
\end{aligned}`),
      paragraph([
        "である。したがってすべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "第 6 の等号で使った「",
        math(String.raw`\pi`),
        " は加法を保つ」は、",
        ref("def_lattice"),
        " の ",
        math(String.raw`\pi(n)=n+L\mathbb{Z}`),
        " と剰余類の加法の定め方 ",
        math(String.raw`(a+L\mathbb{Z})+_{\mathbb{Z}/L\mathbb{Z}}(b+L\mathbb{Z})=(a+b)+L\mathbb{Z}`),
        " から直ちに従う。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}`),
        " と有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の加法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_column_translation_period",
    kind: "claim",
    title: { text: "平行移動を L 回施すと恒等写像になる" },
    labels: ["claim_column_translation_period"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_period",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterRight_add_period",
      "Ising2DLambda.AlgebraicEigenvalue.columnTranslationIterate_period_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        math(String.raw`\gamma^{[L]}=\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}}`),
        " である（",
        math(String.raw`\gamma^{[L]}`),
        " は ",
        ref("def_column_translation_iterate"),
        " で ",
        math(String.raw`k=L`),
        " としたもの）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma^{[L]}(y)
&=y+_{\mathbb{Z}/L\mathbb{Z}}\pi(L)
&&(\because\ \blkref{claim_column_translation_iterate_apply})\\
&=y+_{\mathbb{Z}/L\mathbb{Z}}0
&&(\because\ \blkref{def_lattice}\ \text{の}\ \pi\ \text{について}\ \pi(L)=L+L\mathbb{Z}=L\mathbb{Z}=0)\\
&=y
&&(\because\ 0\ \text{は}\ \mathbb{Z}/L\mathbb{Z}\ \text{の加法の単位元})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`y`),
        " は任意だったので ",
        math(String.raw`\gamma^{[L]}=\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}}`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の加法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_shift_iterate",
    kind: "definition",
    title: { text: "行配位の巡回シフトの反復" },
    labels: ["def_row_config_shift_iterate"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate"],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        ref("def_row_config_shift"),
        " の ",
        math(String.raw`S`),
        " を ",
        math(String.raw`k`),
        " 回施す写像 ",
        math(String.raw`S^{[k]}:R_L\to R_L`),
        " を、",
        math(String.raw`k\in\mathbb{N}`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`S^{[0]}:=\mathrm{id}_{R_L},
\qquad
S^{[k+1]}:=S\circ S^{[k]}`),
      paragraph([
        "により定める（",
        math(String.raw`\mathrm{id}_{R_L}`),
        " は ",
        math(String.raw`R_L`),
        " の恒等写像）。上付きの角括弧の意味は ",
        ref("def_column_translation_iterate"),
        " と同じである。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_iterate_apply",
    kind: "claim",
    title: { text: "反復した巡回シフトは反復した平行移動による引き戻しである" },
    labels: ["claim_row_config_shift_iterate_apply"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_apply",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.precompIterate_apply",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_apply_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`k\in\mathbb{N}`),
        "、任意の ",
        math(String.raw`\tau\in R_L`),
        "、任意の ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " について",
      ]),
      displayMath(String.raw`\bigl(S^{[k]}(\tau)\bigr)(y)=\tau\bigl(\gamma^{[k]}(y)\bigr)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "、",
        math(String.raw`\gamma^{[k]}`),
        " は ",
        ref("def_column_translation_iterate"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。帰納法の仮定は「その ",
        math(String.raw`k`),
        " について、すべての ",
        math(String.raw`\tau\in R_L`),
        " とすべての ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " で等式が成り立つ」とする（次の段で ",
        math(String.raw`y`),
        " を動かしたところへ適用するため）。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき、",
        math(String.raw`\tau\in R_L`),
        " と ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S^{[0]}(\tau)\bigr)(y)
&=\tau(y)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=\tau\bigl(\gamma^{[0]}(y)\bigr)
&&(\because\ \blkref{def_column_translation_iterate}\ \text{の}\ \gamma^{[0]}=\mathrm{id}_{\mathbb{Z}/L\mathbb{Z}})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`k`),
        " について主張が成り立つとする。",
        math(String.raw`\tau\in R_L`),
        " と ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S^{[k+1]}(\tau)\bigr)(y)
&=\Bigl(S\bigl(S^{[k]}(\tau)\bigr)\Bigr)(y)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=\bigl(S^{[k]}(\tau)\bigr)\bigl(\gamma(y)\bigr)
&&(\because\ \blkref{def_row_config_shift})\\
&=\tau\Bigl(\gamma^{[k]}\bigl(\gamma(y)\bigr)\Bigr)
&&(\because\ \text{帰納法の仮定を}\ \gamma(y)\ \text{へ適用})\\
&=\tau\bigl(\gamma^{[k+1]}(y)\bigr)
&&(\because\ \blkref{def_column_translation_iterate}\ \text{の}\ \gamma^{[k+1]}=\gamma^{[k]}\circ\gamma)
\end{aligned}`),
      paragraph([
        "である。したがってすべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "第 3 の等号で帰納法の仮定を ",
        math(String.raw`y`),
        " ではなく ",
        math(String.raw`\gamma(y)`),
        " へ適用している。",
        ref("def_column_translation_iterate"),
        " が反復の順を ",
        math(String.raw`\gamma^{[k]}\circ\gamma`),
        " と定めているのはこのためである。",
      ]),
      paragraph([
        "現れるのは有限集合とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_period",
    kind: "claim",
    title: { text: "巡回シフトを L 回施すと恒等写像になる" },
    labels: ["claim_row_config_shift_period"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_period",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.precompIterate_period",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_period_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        math(String.raw`S^{[L]}=\mathrm{id}_{R_L}`),
        " である（",
        math(String.raw`S^{[L]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        " で ",
        math(String.raw`k=L`),
        " としたもの）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        " と ",
        math(String.raw`y\in\mathbb{Z}/L\mathbb{Z}`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(S^{[L]}(\tau)\bigr)(y)
&=\tau\bigl(\gamma^{[L]}(y)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_apply})\\
&=\tau(y)
&&(\because\ \blkref{claim_column_translation_period})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`y`),
        " は任意だったので、",
        ref("def_row_configuration"),
        " の行配位が ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " から ",
        math(String.raw`\{+1,-1\}`),
        " への写像であることから ",
        math(String.raw`S^{[L]}(\tau)=\tau`),
        " である。",
        math(String.raw`\tau`),
        " も任意だったので ",
        math(String.raw`S^{[L]}=\mathrm{id}_{R_L}`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_matrix_pow",
    kind: "claim",
    title: { text: "シフト行列の冪は反復したシフトの行列である" },
    labels: ["claim_shift_matrix_pow"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_apply",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_pow_apply",
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_apply_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        "任意の整数 ",
        math(String.raw`k\ge1`),
        " と任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について",
      ]),
      displayMath(String.raw`\bigl(U^{k}\bigr)_{\tau,\tau'}=
\begin{cases}
\kappa(1) & (\tau'=S^{[k]}(\tau)\ \text{のとき})\\
\kappa(0) & (\tau'\ne S^{[k]}(\tau)\ \text{のとき})
\end{cases}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、冪は ",
        ref("def_matrix_over_row_configs"),
        "、",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う等式を先に置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[1]}
&=S\circ S^{[0]}
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S\circ\mathrm{id}_{R_L}
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=S
&&(\because\ \text{恒等写像との合成})
\end{aligned}`),
      paragraph([
        "また ",
        ref("claim_row_config_shift_bijective"),
        " の逆写像を ",
        math(String.raw`S'`),
        " と書く。",
      ]),
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=1`),
        " のとき、",
        math(String.raw`\tau,\tau'\in R_L`),
        " を任意に取ると ",
        math(String.raw`\bigl(U^{1}\bigr)_{\tau,\tau'}=U_{\tau,\tau'}`),
        " であり（",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`A^{1}=A`),
        "）、",
        ref("def_shift_matrix"),
        " よりこれは ",
        math(String.raw`\tau'=S(\tau)`),
        " のとき ",
        math(String.raw`\kappa(1)`),
        "、そうでないとき ",
        math(String.raw`\kappa(0)`),
        " である。上の ",
        math(String.raw`S^{[1]}=S`),
        " により、この条件は ",
        math(String.raw`\tau'=S^{[1]}(\tau)`),
        " と同じものである。",
      ]),
      paragraph([
        math(String.raw`k\ge1`),
        " について主張が成り立つとする。",
        math(String.raw`\tau,\tau''\in R_L`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(U^{k+1}\bigr)_{\tau,\tau''}
&=\bigl(U^{k}U\bigr)_{\tau,\tau''}
&&(\because\ \blkref{def_matrix_over_row_configs}\ \text{の}\ A^{k+1}=A^{k}A)\\
&=\bigl(U^{k}\bigr)_{\tau,\,S'(\tau'')}
&&(\because\ \blkref{claim_shift_matrix_right}\ \text{を}\ A=U^{k}\ \text{へ適用})
\end{aligned}`),
      paragraph([
        "である。帰納法の仮定より、右辺は ",
        math(String.raw`S'(\tau'')=S^{[k]}(\tau)`),
        " のとき ",
        math(String.raw`\kappa(1)`),
        "、そうでないとき ",
        math(String.raw`\kappa(0)`),
        " である。この条件については",
      ]),
      displayMath(String.raw`\begin{aligned}
S'(\tau'')=S^{[k]}(\tau)
&\iff \tau''=S\bigl(S^{[k]}(\tau)\bigr)
&&(\because\ \blkref{claim_row_config_shift_bijective}\ \text{の}\ S\circ S'=\mathrm{id}_{R_L}\ \text{と}\ S'\circ S=\mathrm{id}_{R_L})\\
&\iff \tau''=S^{[k+1]}(\tau)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})
\end{aligned}`),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`\bigl(U^{k+1}\bigr)_{\tau,\tau''}`),
        " は ",
        math(String.raw`\tau''=S^{[k+1]}(\tau)`),
        " のとき ",
        math(String.raw`\kappa(1)`),
        "、そうでないとき ",
        math(String.raw`\kappa(0)`),
        " であり、",
        math(String.raw`k+1`),
        " についても主張が成り立つ。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " の有限個の元の和と積、および有限集合の上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_theorem_shift_matrix_order",
    kind: "theorem",
    title: { text: "シフト行列の L 乗は単位行列である" },
    labels: ["theorem_shift_matrix_order"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_L",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.permMatrix_pow_eq_identity",
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_pow_L_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-order"],
    statement: [
      paragraph([
        ref("def_shift_matrix"),
        " の ",
        math(String.raw`U`),
        " と ",
        ref("def_constant_polynomial"),
        " の単位行列 ",
        math(String.raw`I`),
        " について",
      ]),
      displayMath(String.raw`U^{L}=I`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\mathbb{Z}[x]`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau'\in R_L`),
        " を任意に取り、",
        math(String.raw`\tau'=\tau`),
        " の場合とそうでない場合に分ける。",
        ref("def_lattice"),
        " の格子は ",
        math(String.raw`L\ge1`),
        " を満たすので、",
        ref("claim_shift_matrix_pow"),
        " を ",
        math(String.raw`k=L`),
        " に対して使ってよい。",
      ]),
      paragraph([
        math(String.raw`\tau'=\tau`),
        " のとき、",
        ref("claim_row_config_shift_period"),
        " より ",
        math(String.raw`S^{[L]}(\tau)=\tau=\tau'`),
        " なので",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(U^{L}\bigr)_{\tau,\tau'}
&=\kappa(1)
&&(\because\ \blkref{claim_shift_matrix_pow}\ \text{の}\ \tau'=S^{[L]}(\tau)\ \text{の場合})\\
&=I_{\tau,\tau'}
&&(\because\ \blkref{def_identity_matrix}\ \text{の}\ \tau=\tau'\ \text{の場合})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`\tau'\ne\tau`),
        " のとき、",
        ref("claim_row_config_shift_period"),
        " より ",
        math(String.raw`S^{[L]}(\tau)=\tau`),
        " なので ",
        math(String.raw`\tau'\ne S^{[L]}(\tau)`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(U^{L}\bigr)_{\tau,\tau'}
&=\kappa(0)
&&(\because\ \blkref{claim_shift_matrix_pow}\ \text{の}\ \tau'\ne S^{[L]}(\tau)\ \text{の場合})\\
&=I_{\tau,\tau'}
&&(\because\ \blkref{def_identity_matrix}\ \text{の}\ \tau\ne\tau'\ \text{の場合})
\end{aligned}`),
      paragraph([
        "である。いずれの場合も成分が一致し、",
        math(String.raw`\tau,\tau'`),
        " は任意だったので ",
        math(String.raw`U^{L}=I`),
        " である。",
      ]),
      paragraph([
        "この定理は、シフト行列を「",
        math(String.raw`L`),
        " 乗すると単位行列になる行列」として特徴づける。",
        "この先は、個々の行配位がもとに戻るまでの回数（次の ",
        ref("def_row_config_shift_minimal_period"),
        "）を数え、それを使って特性多項式を分解し、最後にその根が 1 の ",
        math(String.raw`L`),
        " 乗根、すなわち円分体 ",
        math(String.raw`\mathbb{Q}(\omega)\subset\overline{\mathbb{Q}}`),
        " の元であることを見る。",
        "成分は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元であり、この証明にも実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_shift_minimal_period",
    kind: "definition",
    title: { text: "行配位の最小周期" },
    labels: ["def_row_config_shift_minimal_period"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod"],
    verification: ["sagemath/check/row-shift-minimal-period"],
    statement: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        " を任意に取る（",
        ref("def_row_configuration"),
        "）。",
        math(String.raw`\tau`),
        " をもとへ戻す反復の回数の全体を",
      ]),
      displayMath(String.raw`K(\tau):=\bigl\{\,k\in\mathbb{N}\ \bigm|\ k\ge1\ \text{かつ}\ S^{[k]}(\tau)=\tau\,\bigr\}\subset\mathbb{N}`),
      paragraph([
        "と置く（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。",
        ref("claim_row_config_shift_period"),
        " より ",
        math(String.raw`S^{[L]}(\tau)=\tau`),
        " であり、",
        ref("def_lattice"),
        " の格子は ",
        math(String.raw`L\ge1`),
        " を満たすので ",
        math(String.raw`L\in K(\tau)`),
        " である。したがって ",
        math(String.raw`K(\tau)`),
        " は空でなく、自然数の整列性により最小元を持つ。",
        "その最小元を ",
        math(String.raw`e(\tau)\in\mathbb{N}`),
        " と書き、",
        math(String.raw`\tau`),
        " の最小周期と呼ぶ。",
      ]),
      paragraph([
        "定義から次の 3 つが成り立つ。",
        math(String.raw`e(\tau)\ge1`),
        " であること。",
        math(String.raw`S^{[e(\tau)]}(\tau)=\tau`),
        " であること。そして ",
        math(String.raw`1\le k<e(\tau)`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " については ",
        math(String.raw`S^{[k]}(\tau)\ne\tau`),
        " であること。",
      ]),
      paragraph([
        "最小周期は行配位ごとに異なりうる量であって、",
        math(String.raw`L`),
        " と一致するとは限らない。たとえばすべての列で同じ値を取る行配位は ",
        math(String.raw`S`),
        " で動かないので最小周期が ",
        math(String.raw`1`),
        " である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の大小だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_iterate_add",
    kind: "claim",
    title: { text: "反復の回数は足し算になる" },
    labels: ["claim_row_config_shift_iterate_add"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_add",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_add",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_add_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-minimal-period"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`a,b\in\mathbb{N}`),
        " と任意の ",
        math(String.raw`\tau\in R_L`),
        " について",
      ]),
      displayMath(String.raw`S^{[a+b]}(\tau)=S^{[a]}\bigl(S^{[b]}(\tau)\bigr)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`a`),
        " についての帰納法で示す（",
        math(String.raw`b`),
        " と ",
        math(String.raw`\tau`),
        " は固定してよい）。",
      ]),
      paragraph([
        math(String.raw`a=0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[0+b]}(\tau)
&=S^{[b]}(\tau)
&&(\because\ 0\ \text{は}\ \mathbb{N}\ \text{の加法の単位元})\\
&=S^{[0]}\bigl(S^{[b]}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`a`),
        " について主張が成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[(a+1)+b]}(\tau)
&=S^{[(a+b)+1]}(\tau)
&&(\because\ \mathbb{N}\ \text{の加法の結合則と可換性})\\
&=S\bigl(S^{[a+b]}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S\Bigl(S^{[a]}\bigl(S^{[b]}(\tau)\bigr)\Bigr)
&&(\because\ \text{帰納法の仮定})\\
&=S^{[a+1]}\bigl(S^{[b]}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})
\end{aligned}`),
      paragraph([
        "である。したがってすべての ",
        math(String.raw`a\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の加法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_period_divides",
    kind: "claim",
    title: { text: "もとへ戻る反復の回数は最小周期の倍数である" },
    labels: ["claim_row_config_shift_period_divides"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_self_iff",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_eq_self_iff",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_eq_self_iff_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-minimal-period"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau\in R_L`),
        " と任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`S^{[k]}(\tau)=\tau
\iff
e(\tau)\ \text{は}\ k\ \text{を割り切る}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`e(\tau)`),
        " は ",
        ref("def_row_config_shift_minimal_period"),
        "）。ここで「",
        math(String.raw`e`),
        " は ",
        math(String.raw`k`),
        " を割り切る」とは、",
        math(String.raw`k=e\,q`),
        " を満たす ",
        math(String.raw`q\in\mathbb{N}`),
        " が存在することを言う。",
      ]),
    ],
    proof: [
      paragraph([
        "2 つの向きを別々に示す。以下 ",
        math(String.raw`e:=e(\tau)`),
        " と書く。",
      ]),
      paragraph([
        "割り切れるならばもとへ戻ること。",
        math(String.raw`k=e\,q`),
        " と書けるとして、",
        math(String.raw`q`),
        " についての帰納法で ",
        math(String.raw`S^{[e\,q]}(\tau)=\tau`),
        " を示す。",
        math(String.raw`q=0`),
        " のときは ",
        math(String.raw`S^{[0]}(\tau)=\tau`),
        " であり（",
        ref("def_row_config_shift_iterate"),
        " の ",
        math(String.raw`S^{[0]}=\mathrm{id}_{R_L}`),
        "）、",
        math(String.raw`q`),
        " について成り立つとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[e\,(q+1)]}(\tau)
&=S^{[e\,q+e]}(\tau)
&&(\because\ \mathbb{N}\ \text{の分配則})\\
&=S^{[e\,q]}\bigl(S^{[e]}(\tau)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[e\,q]}(\tau)
&&(\because\ \blkref{def_row_config_shift_minimal_period}\ \text{の}\ S^{[e(\tau)]}(\tau)=\tau)\\
&=\tau
&&(\because\ \text{帰納法の仮定})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "もとへ戻るならば割り切れること。",
        math(String.raw`S^{[k]}(\tau)=\tau`),
        " とする。",
        ref("def_row_config_shift_minimal_period"),
        " より ",
        math(String.raw`e\ge1`),
        " なので、自然数の除法により ",
        math(String.raw`k=e\,q+r`),
        " かつ ",
        math(String.raw`0\le r<e`),
        " を満たす ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が取れる。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau
&=S^{[k]}(\tau)
&&(\because\ \text{仮定})\\
&=S^{[r+e\,q]}(\tau)
&&(\because\ k=e\,q+r\ \text{と}\ \mathbb{N}\ \text{の加法の可換性})\\
&=S^{[r]}\bigl(S^{[e\,q]}(\tau)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[r]}(\tau)
&&(\because\ \text{上で示した「割り切れるならばもとへ戻る」})
\end{aligned}`),
      paragraph([
        "である。もし ",
        math(String.raw`r\ge1`),
        " ならば ",
        math(String.raw`r\in K(\tau)`),
        " であり、",
        math(String.raw`r<e`),
        " は ",
        math(String.raw`e`),
        " が ",
        math(String.raw`K(\tau)`),
        " の最小元であることに反する。したがって ",
        math(String.raw`r=0`),
        " であり ",
        math(String.raw`k=e\,q`),
        "、すなわち ",
        math(String.raw`e`),
        " は ",
        math(String.raw`k`),
        " を割り切る。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の加法・乗法・大小だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_minimal_period_divides_L",
    kind: "claim",
    title: { text: "最小周期は格子の一辺を割り切る" },
    labels: ["claim_row_config_minimal_period_divides_L"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_dvd_L",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.minimalPeriod_dvd_of_iterLeft_eq_self",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftMinimalPeriod_dvd_L_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-minimal-period"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau\in R_L`),
        " について、",
        math(String.raw`e(\tau)`),
        " は ",
        math(String.raw`L`),
        " を割り切る（",
        math(String.raw`e(\tau)`),
        " は ",
        ref("def_row_config_shift_minimal_period"),
        "、",
        math(String.raw`L`),
        " は ",
        ref("def_lattice"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_row_config_shift_period"),
        " より ",
        math(String.raw`S^{[L]}(\tau)=\tau`),
        " である。",
        ref("claim_row_config_shift_period_divides"),
        " を ",
        math(String.raw`k=L`),
        " に対して使うと、",
        math(String.raw`e(\tau)`),
        " は ",
        math(String.raw`L`),
        " を割り切る。",
      ]),
      paragraph([
        "この主張は、次のセクションで特性多項式を軌道ごとの因子へ分解するときに使う。",
        "軌道の大きさが ",
        math(String.raw`L`),
        " の約数であることから、各因子の根がすべて 1 の ",
        math(String.raw`L`),
        " 乗根になる。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の乗法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_shift_iterate_injective",
    kind: "claim",
    title: { text: "反復した巡回シフトは単射である" },
    labels: ["claim_row_config_shift_iterate_injective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_injective",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.iterLeft_injective",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_injective_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-orbit"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`S^{[k]}:R_L\to R_L`),
        " は単射である（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。すなわち任意の ",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " について ",
        math(String.raw`S^{[k]}(\tau_1)=S^{[k]}(\tau_2)`),
        " ならば ",
        math(String.raw`\tau_1=\tau_2`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき、",
        math(String.raw`S^{[0]}(\tau_1)=S^{[0]}(\tau_2)`),
        " を仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau_1
&=S^{[0]}(\tau_1)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=S^{[0]}(\tau_2)
&&(\because\ \text{仮定})\\
&=\tau_2
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`k`),
        " について主張が成り立つとする。",
        math(String.raw`S^{[k+1]}(\tau_1)=S^{[k+1]}(\tau_2)`),
        " を仮定すると",
      ]),
      displayMath(String.raw`\begin{aligned}
S\bigl(S^{[k]}(\tau_1)\bigr)
&=S^{[k+1]}(\tau_1)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S^{[k+1]}(\tau_2)
&&(\because\ \text{仮定})\\
&=S\bigl(S^{[k]}(\tau_2)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})
\end{aligned}`),
      paragraph([
        "である。",
        ref("claim_row_config_shift_bijective"),
        " より ",
        math(String.raw`S`),
        " は全単射、とくに単射なので ",
        math(String.raw`S^{[k]}(\tau_1)=S^{[k]}(\tau_2)`),
        " が従い、帰納法の仮定から ",
        math(String.raw`\tau_1=\tau_2`),
        " である。したがってすべての ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この主張は、次の ",
        ref("claim_row_config_orbit_card"),
        " で反復の回数が相異なるところでは行く先も相異なることを言うために使う。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_orbit",
    kind: "definition",
    title: { text: "行配位の軌道" },
    labels: ["def_row_config_orbit"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit"],
    verification: ["sagemath/check/row-shift-orbit"],
    statement: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        " を任意に取る（",
        ref("def_row_configuration"),
        "）。",
        math(String.raw`\tau`),
        " から巡回シフトの反復で到達できる行配位の全体を",
      ]),
      displayMath(
        String.raw`O(\tau):=\bigl\{\,\tau'\in R_L \;\bigm|\; \tau'=S^{[k]}(\tau)\ \text{を満たす}\ k\in\mathbb{N}\ \text{が存在する}\,\bigr\}\subset R_L`,
      ),
      paragraph([
        "と置き、",
        math(String.raw`\tau`),
        " の軌道と呼ぶ（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " と取れば ",
        math(String.raw`\tau=S^{[0]}(\tau)`),
        " なので ",
        math(String.raw`\tau\in O(\tau)`),
        " であり、とくに ",
        math(String.raw`O(\tau)`),
        " は空でない。",
        math(String.raw`O(\tau)`),
        " は有限集合 ",
        math(String.raw`R_L`),
        " の部分集合なので有限であり、その元の個数 ",
        math(String.raw`|O(\tau)|`),
        " は ",
        math(String.raw`\mathbb{N}`),
        " の元である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_orbit_card",
    kind: "claim",
    title: { text: "軌道の元の個数は最小周期に等しい" },
    labels: ["claim_row_config_orbit_card"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.card_rowShiftOrbit",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_orbit",
      "Ising2DLambda.AlgebraicEigenvalue.card_rowShiftOrbit_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-orbit"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau\in R_L`),
        " について",
      ]),
      displayMath(String.raw`|O(\tau)|=e(\tau)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "、",
        math(String.raw`e(\tau)`),
        " は ",
        ref("def_row_config_shift_minimal_period"),
        "）。両辺は ",
        math(String.raw`\mathbb{N}`),
        " の元であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを先に置く。以下 ",
        math(String.raw`e:=e(\tau)`),
        " と書く。反復の回数の集合",
      ]),
      displayMath(
        String.raw`J(\tau):=\bigl\{\,k\in\mathbb{N} \;\bigm|\; k<e\,\bigr\}\subset\mathbb{N}`,
      ),
      paragraph([
        "と、写像 ",
        math(String.raw`\eta_\tau:J(\tau)\to O(\tau)`),
        " を ",
        math(String.raw`\eta_\tau(k):=S^{[k]}(\tau)`),
        " で定める。行き先が ",
        math(String.raw`O(\tau)`),
        " に属することは ",
        ref("def_row_config_orbit"),
        " そのものである。",
      ]),
      paragraph([
        "さらに、後の 2 か所で使うことを先に置く。",
        math(String.raw`d\in\mathbb{N}`),
        " が ",
        math(String.raw`e\mid d`),
        " と ",
        math(String.raw`d<e`),
        " をともに満たすならば ",
        math(String.raw`d=0`),
        " である。実際 ",
        math(String.raw`d=e\,q`),
        " と書けて、もし ",
        math(String.raw`q\ge1`),
        " ならば ",
        math(String.raw`d=e\,q\ge e\cdot1=e`),
        " となり ",
        math(String.raw`d<e`),
        " に反するので ",
        math(String.raw`q=0`),
        "、すなわち ",
        math(String.raw`d=0`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\eta_\tau`),
        " が単射であること。",
        math(String.raw`a,b\in J(\tau)`),
        " が ",
        math(String.raw`\eta_\tau(a)=\eta_\tau(b)`),
        " を満たすとする。",
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " は対称なので ",
        math(String.raw`a\le b`),
        " としてよい。このとき ",
        math(String.raw`b-a\in\mathbb{N}`),
        " が定まり",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[a]}\bigl(S^{[b-a]}(\tau)\bigr)
&=S^{[a+(b-a)]}(\tau)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[b]}(\tau)
&&(\because\ a\le b\ \text{なので}\ a+(b-a)=b)\\
&=\eta_\tau(b)
&&(\because\ \eta_\tau\ \text{の定め方})\\
&=\eta_\tau(a)
&&(\because\ \text{仮定})\\
&=S^{[a]}(\tau)
&&(\because\ \eta_\tau\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "である。",
        ref("claim_row_config_shift_iterate_injective"),
        " より ",
        math(String.raw`S^{[a]}`),
        " は単射なので ",
        math(String.raw`S^{[b-a]}(\tau)=\tau`),
        " が従い、",
        ref("claim_row_config_shift_period_divides"),
        " より ",
        math(String.raw`e\mid b-a`),
        " である。また ",
        math(String.raw`b-a\le b<e`),
        " なので、上で置いたことから ",
        math(String.raw`b-a=0`),
        " すなわち ",
        math(String.raw`a=b`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\eta_\tau`),
        " が全射であること。",
        math(String.raw`\tau'\in O(\tau)`),
        " を任意に取る。",
        ref("def_row_config_orbit"),
        " より ",
        math(String.raw`\tau'=S^{[k]}(\tau)`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が取れる。",
        ref("def_row_config_shift_minimal_period"),
        " より ",
        math(String.raw`e\ge1`),
        " なので、自然数の除法により ",
        math(String.raw`k=e\,q+r`),
        " かつ ",
        math(String.raw`0\le r<e`),
        " を満たす ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が取れる。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau'
&=S^{[k]}(\tau)
&&(\because\ k\ \text{の取り方})\\
&=S^{[r+e\,q]}(\tau)
&&(\because\ k=e\,q+r\ \text{と}\ \mathbb{N}\ \text{の加法の可換性})\\
&=S^{[r]}\bigl(S^{[e\,q]}(\tau)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[r]}(\tau)
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{の}\ e\mid e\,q\ \text{の場合})\\
&=\eta_\tau(r)
&&(\because\ \eta_\tau\ \text{の定め方})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r<e`),
        " なので ",
        math(String.raw`r\in J(\tau)`),
        " であり、",
        math(String.raw`\tau'`),
        " は ",
        math(String.raw`\eta_\tau`),
        " の像に属する。",
      ]),
      paragraph([
        "以上で ",
        math(String.raw`\eta_\tau`),
        " は全単射である。全単射で結ばれた有限集合の元の個数は等しいので",
      ]),
      displayMath(String.raw`\begin{aligned}
|O(\tau)|
&=|J(\tau)|
&&(\because\ \eta_\tau:J(\tau)\to O(\tau)\ \text{が全単射})\\
&=e
&&(\because\ \mathbb{N}\ \text{の}\ e\ \text{未満の元は}\ 0,1,\dots,e-1\ \text{の}\ e\ \text{個})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "この主張は、次のセクションでシフト行列の特性多項式を軌道ごとの因子 ",
        math(String.raw`t^{|O(\tau)|}-1`),
        " の積へ分解するときに使う。",
        ref("claim_row_config_minimal_period_divides_L"),
        " と合わせると各軌道の元の個数が ",
        math(String.raw`L`),
        " の約数になるので、各因子が ",
        math(String.raw`t^{L}-1`),
        " を割り切ることが言える。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の加法・乗法・減法・大小だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_orbit_mem_eq",
    kind: "claim",
    title: { text: "軌道の元の軌道はもとの軌道に等しい" },
    labels: ["claim_row_config_orbit_mem_eq"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_mem",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit_eq_of_mem",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_mem_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-orbit-partition"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について、",
        math(String.raw`\tau'\in O(\tau)`),
        " ならば",
      ]),
      displayMath(String.raw`O(\tau')=O(\tau)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。両辺は有限集合 ",
        math(String.raw`R_L`),
        " の部分集合であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを先に置く。以下 ",
        math(String.raw`e:=e(\tau)`),
        " と書く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        ref("def_row_config_orbit"),
        " より ",
        math(String.raw`\tau'=S^{[m]}(\tau)`),
        " を満たす ",
        math(String.raw`m\in\mathbb{N}`),
        " が取れる。",
      ]),
      paragraph([
        "また、次の形の包含を 2 度使う。任意の ",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " について、",
        math(String.raw`\tau_2\in O(\tau_1)`),
        " ならば ",
        math(String.raw`O(\tau_2)\subset O(\tau_1)`),
        " である。実際 ",
        math(String.raw`\tau_2=S^{[n]}(\tau_1)`),
        " を満たす ",
        math(String.raw`n\in\mathbb{N}`),
        " を取り、",
        math(String.raw`\tau_3\in O(\tau_2)`),
        " を任意に取ると、",
        math(String.raw`\tau_3=S^{[k]}(\tau_2)`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が取れて",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau_3
&=S^{[k]}(\tau_2)
&&(\because\ k\ \text{の取り方})\\
&=S^{[k]}\bigl(S^{[n]}(\tau_1)\bigr)
&&(\because\ n\ \text{の取り方})\\
&=S^{[k+n]}(\tau_1)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})
\end{aligned}`),
      paragraph([
        "となるので ",
        math(String.raw`\tau_3\in O(\tau_1)`),
        " である（",
        ref("def_row_config_orbit"),
        "）。",
      ]),
      paragraph([
        "以下、2 つの包含を別々に示す。",
      ]),
      paragraph([
        math(String.raw`O(\tau')\subset O(\tau)`),
        " であること。これは上で置いた包含を ",
        math(String.raw`\tau_1:=\tau`),
        "、",
        math(String.raw`\tau_2:=\tau'`),
        " として当てたものである。",
      ]),
      paragraph([
        math(String.raw`O(\tau)\subset O(\tau')`),
        " であること。上で置いた包含を ",
        math(String.raw`\tau_1:=\tau'`),
        "、",
        math(String.raw`\tau_2:=\tau`),
        " として当てるために、",
        math(String.raw`\tau\in O(\tau')`),
        " を示せばよい。",
        ref("def_row_config_shift_minimal_period"),
        " より ",
        math(String.raw`e\ge1`),
        " なので ",
        math(String.raw`e-1\in\mathbb{N}`),
        " が定まり、",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[(e-1)\,m]}(\tau')
&=S^{[(e-1)\,m]}\bigl(S^{[m]}(\tau)\bigr)
&&(\because\ m\ \text{の取り方})\\
&=S^{[(e-1)\,m+m]}(\tau)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[e\,m]}(\tau)
&&(\because\ e\ge1\ \text{なので}\ (e-1)\,m+m=e\,m)\\
&=\tau
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{の}\ e\mid e\,m\ \text{の場合})
\end{aligned}`),
      paragraph([
        "である。したがって ",
        math(String.raw`\tau\in O(\tau')`),
        " であり（",
        ref("def_row_config_orbit"),
        "）、上で置いた包含から ",
        math(String.raw`O(\tau)\subset O(\tau')`),
        " が従う。",
      ]),
      paragraph([
        "以上の 2 つの包含から ",
        math(String.raw`O(\tau')=O(\tau)`),
        " である。",
      ]),
      paragraph([
        "この証明は ",
        math(String.raw`S`),
        " が全射であることを使っていない。逆向きに辿る代わりに、",
        math(String.raw`e\,m`),
        " 回の反復がもとへ戻ることを使って前向きに辿り着いているからである。",
        math(String.raw`S`),
        " が単射であることも使っていない。上の各段が使っているのは反復の回数の加法性（",
        ref("claim_row_config_shift_iterate_add"),
        "）と ",
        math(String.raw`S^{[e\,m]}(\tau)=\tau`),
        "（",
        ref("claim_row_config_shift_period_divides"),
        "）だけである。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{N}`),
        " の加法・乗法・減法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_orbit_disjoint_or_eq",
    kind: "claim",
    title: { text: "2 つの軌道は一致するか互いに素である" },
    labels: ["claim_row_config_orbit_disjoint_or_eq"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_inter_nonempty",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbit_eq_of_inter_nonempty",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbit_eq_of_inter_nonempty_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-orbit-partition"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " について、",
        math(String.raw`O(\tau_1)\cap O(\tau_2)`),
        " が空でないならば ",
        math(String.raw`O(\tau_1)=O(\tau_2)`),
        " である（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。すなわち 2 つの軌道は、一致するか、共通の元を持たないかのいずれかである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`O(\tau_1)\cap O(\tau_2)`),
        " が空でないとして、その元 ",
        math(String.raw`\tau_3`),
        " を 1 つ取る。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
O(\tau_1)
&=O(\tau_3)
&&(\because\ \tau_3\in O(\tau_1)\ \text{と}\ \blkref{claim_row_config_orbit_mem_eq})\\
&=O(\tau_2)
&&(\because\ \tau_3\in O(\tau_2)\ \text{と}\ \blkref{claim_row_config_orbit_mem_eq})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " の部分集合だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_orbit_set",
    kind: "definition",
    title: { text: "軌道の全体" },
    labels: ["def_row_config_orbit_set"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet"],
    verification: ["sagemath/check/row-shift-orbit-partition"],
    statement: [
      paragraph([
        "行配位の軌道として現れる集合の全体を",
      ]),
      displayMath(
        String.raw`\mathcal{O}_L:=\bigl\{\,O(\tau) \;\bigm|\; \tau\in R_L\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "、",
        math(String.raw`R_L`),
        " は ",
        ref("def_row_configuration"),
        "）。",
        math(String.raw`\mathcal{O}_L`),
        " の元は ",
        math(String.raw`R_L`),
        " の部分集合であって ",
        math(String.raw`R_L`),
        " の元ではない。",
      ]),
      paragraph([
        math(String.raw`R_L`),
        " は有限集合なので、その部分集合の全体も有限であり、",
        math(String.raw`\mathcal{O}_L`),
        " はその部分集合として有限である。したがって元の個数 ",
        math(String.raw`|\mathcal{O}_L|`),
        " は ",
        math(String.raw`\mathbb{N}`),
        " の元である。",
      ]),
      paragraph([
        math(String.raw`\mathcal{O}_L`),
        " は集合として定めており、同じ集合を 2 度数えることはない。すなわち ",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        math(String.raw`R_L`),
        " の各元へその軌道を対応させたものの像であり、したがって ",
        math(String.raw`|\mathcal{O}_L|\le|R_L|`),
        " である。",
      ]),
      paragraph([
        "この不等号は等号のこともあり、真の不等号のこともある。相異なる ",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " が同じ軌道を与えること（",
        math(String.raw`\tau_1\ne\tau_2`),
        " かつ ",
        math(String.raw`O(\tau_1)=O(\tau_2)`),
        "）がある場合は真に小さく、無い場合は等しい。",
        math(String.raw`L=1`),
        " では ",
        math(String.raw`\mathbb{Z}/1\mathbb{Z}`),
        " がただ 1 つの元からなるので ",
        math(String.raw`\gamma`),
        " は恒等写像であり（",
        ref("def_column_translation"),
        "）、したがって ",
        math(String.raw`S`),
        " も恒等写像である（",
        ref("def_row_config_shift"),
        "）。このとき ",
        math(String.raw`S^{[k]}(\tau)=\tau`),
        " なのでどの軌道も 1 元集合 ",
        math(String.raw`O(\tau)=\{\tau\}`),
        " であり（",
        ref("def_row_config_orbit"),
        "）、",
        math(String.raw`|\mathcal{O}_L|=|R_L|=2`),
        " となる。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、および ",
        math(String.raw`\mathbb{N}`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_orbit_partition",
    kind: "claim",
    title: { text: "軌道の全体は行配位の全体の分割である" },
    labels: ["claim_row_config_orbit_partition"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet_partition",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbitSet_partition",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftOrbitSet_partition_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-orbit-partition"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{O}_L`),
        " は次の 3 つを満たす（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。すなわち ",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        math(String.raw`R_L`),
        " の分割である。",
      ]),
      list([
        [
          math(String.raw`\mathcal{O}_L`),
          " のどの元も空でない。",
        ],
        [
          math(String.raw`\mathcal{O}_L`),
          " の相異なる 2 元は互いに素である。すなわち ",
          math(String.raw`O_1,O_2\in\mathcal{O}_L`),
          " が ",
          math(String.raw`O_1\ne O_2`),
          " を満たすならば ",
          math(String.raw`O_1\cap O_2=\emptyset`),
          " である。",
        ],
        [
          math(String.raw`\mathcal{O}_L`),
          " の元の合併は ",
          math(String.raw`R_L`),
          " に等しい。すなわち ",
          math(String.raw`\bigcup_{O\in\mathcal{O}_L}O=R_L`),
          " である。",
        ],
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合だけであり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "3 つを別々に示す。",
      ]),
      paragraph([
        "どの元も空でないこと。",
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取ると、",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O=O(\tau)`),
        " を満たす ",
        math(String.raw`\tau\in R_L`),
        " が取れる。",
        ref("def_row_config_orbit"),
        " で見たとおり ",
        math(String.raw`\tau\in O(\tau)`),
        " なので ",
        math(String.raw`O`),
        " は空でない。",
      ]),
      paragraph([
        "相異なる 2 元が互いに素であること。",
        math(String.raw`O_1,O_2\in\mathcal{O}_L`),
        " が ",
        math(String.raw`O_1\cap O_2\ne\emptyset`),
        " を満たすとする。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O_1=O(\tau_1)`),
        "、",
        math(String.raw`O_2=O(\tau_2)`),
        " を満たす ",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " が取れ、",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        " より ",
        math(String.raw`O_1=O(\tau_1)=O(\tau_2)=O_2`),
        " である。対偶を取れば、",
        math(String.raw`O_1\ne O_2`),
        " ならば ",
        math(String.raw`O_1\cap O_2=\emptyset`),
        " である。",
      ]),
      paragraph([
        "合併が ",
        math(String.raw`R_L`),
        " に等しいこと。両方の包含を見る。",
        math(String.raw`\mathcal{O}_L`),
        " のどの元も ",
        math(String.raw`R_L`),
        " の部分集合なので（",
        ref("def_row_config_orbit"),
        "）、合併も ",
        math(String.raw`R_L`),
        " の部分集合である。逆に ",
        math(String.raw`\tau\in R_L`),
        " を任意に取ると、",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O(\tau)\in\mathcal{O}_L`),
        " であり、",
        ref("def_row_config_orbit"),
        " で見たとおり ",
        math(String.raw`\tau\in O(\tau)`),
        " なので ",
        math(String.raw`\tau`),
        " は合併に属する。",
      ]),
      paragraph([
        "この主張は、次のセクションでシフト行列の特性多項式を軌道ごとの因子 ",
        math(String.raw`t^{|O|}-1`),
        " の積へ分解するときに使う。行列の添字集合 ",
        math(String.raw`R_L`),
        " が軌道たちへ分割されることが、行列式の各項を軌道ごとに分けて計算できることの根拠になる。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_matrix_entry_zero",
    kind: "claim",
    title: {
      text: "シフト行列の特性行列の成分は、列の添字が行の添字でもその像でもないとき零元である",
    },
    labels: ["claim_shift_char_matrix_entry_zero"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.charMatrix_eq_zero_of_ne",
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-characteristic-term"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\tau,\tau'\in R_L`),
        " について、",
        math(String.raw`\tau'\ne\tau`),
        " かつ ",
        math(String.raw`\tau'\ne S(\tau)`),
        " ならば",
      ]),
      displayMath(String.raw`\mathrm{ch}(U)_{\tau,\tau'}=\iota\bigl(\kappa(0)\bigr)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "）。",
        ref("def_second_constant_embedding"),
        " で見たとおり ",
        math(String.raw`\iota\bigl(\kappa(0)\bigr)`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の零元なので、この主張は「シフト行列の特性行列は、対角成分と ",
        math(String.raw`\tau'=S(\tau)`),
        " の成分を除いて零元である」と述べている。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体は現れない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathrm{ch}(U)_{\tau,\tau'}
&=\iota\bigl(-U_{\tau,\tau'}\bigr)
&&(\because\ \blkref{def_characteristic_matrix}\ \text{の}\ \tau\ne\tau'\ \text{の場合})\\
&=\iota\bigl(-\kappa(0)\bigr)
&&(\because\ \blkref{def_shift_matrix}\ \text{の}\ \tau'\ne S(\tau)\ \text{の場合})\\
&=\iota\bigl(\kappa(0)\bigr)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元であり、零元の加法の逆元は零元})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        ref("def_characteristic_matrix"),
        "、",
        ref("def_shift_matrix"),
        "、",
        ref("def_constant_polynomial"),
        "、",
        ref("def_second_constant_embedding"),
        " を引いた。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " と ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_term_zero",
    kind: "claim",
    title: {
      text: "行の添字にもその像にも当たらない値を取る置換の項は零元である",
    },
    labels: ["claim_shift_char_term_zero"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.term_eq_zero_of_entry_zero",
      "Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-characteristic-term"],
    statement: [
      paragraph([
        "置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " について、",
        math(String.raw`\varphi(\tau_1)\ne\tau_1`),
        " かつ ",
        math(String.raw`\varphi(\tau_1)\ne S(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が存在するとする。このとき ",
        ref("def_second_determinant"),
        " の和における ",
        math(String.raw`\varphi`),
        " の項について",
      ]),
      displayMath(
        String.raw`\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}=\iota\bigl(\kappa(0)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{S}_L`),
        " と ",
        math(String.raw`\mathrm{sgn}`),
        " は ",
        ref("def_permutation_sign"),
        "）。すなわちこの項は零元であり、",
        math(String.raw`\chi_U=\mathrm{det}_{t}\bigl(\mathrm{ch}(U)\bigr)`),
        " の和に寄与しない（",
        math(String.raw`\chi`),
        " は ",
        ref("def_characteristic_polynomial"),
        "）。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体は現れない。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&=\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\mathrm{ch}(U)_{\tau_1,\varphi(\tau_1)}\cdot\prod_{\tau\in R_L\setminus\{\tau_1\}}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&&(\because\ \text{有限積から 1 つの因子を括り出す})\\
&=\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\iota\bigl(\kappa(0)\bigr)\cdot\prod_{\tau\in R_L\setminus\{\tau_1\}}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&&(\because\ \varphi(\tau_1)\ne\tau_1\ \text{かつ}\ \varphi(\tau_1)\ne S(\tau_1)\ \text{と}\ \blkref{claim_shift_char_matrix_entry_zero})\\
&=\iota\bigl(\kappa(0)\bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の零元を掛けると零元})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        ref("claim_shift_char_matrix_entry_zero"),
        "、",
        ref("def_second_constant_embedding"),
        " を引いた。",
      ]),
      paragraph([
        "この主張の対偶により、",
        math(String.raw`\chi_U`),
        " の和のうち零元でありうるものを除いて残るのは、任意の ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`\varphi(\tau)=\tau`),
        " または ",
        math(String.raw`\varphi(\tau)=S(\tau)`),
        " を満たす置換 ",
        math(String.raw`\varphi`),
        " の項だけである。次の主張は、そのような置換が軌道を保つことを述べる。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と有限集合 ",
        math(String.raw`R_L`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_preserving_permutation",
    kind: "definition",
    title: { text: "軌道を保つ置換" },
    labels: ["def_orbit_preserving_permutation"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.OrbitPreserving"],
    verification: ["sagemath/check/shift-matrix-characteristic-term"],
    statement: [
      paragraph([
        "どの行配位もその軌道の中へ送る置換の全体を",
      ]),
      displayMath(
        String.raw`\mathfrak{S}^{\mathcal{O}}_L:=\bigl\{\,\varphi\in\mathfrak{S}_L \;\bigm|\; \text{任意の}\ \tau\in R_L\ \text{について}\ \varphi(\tau)\in O(\tau)\,\bigr\}`,
      ),
      paragraph([
        "と置き、その元を軌道を保つ置換と呼ぶ（",
        math(String.raw`\mathfrak{S}_L`),
        " は ",
        ref("def_permutation_sign"),
        "、",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。",
      ]),
      paragraph([
        "上付きの ",
        math(String.raw`\mathcal{O}`),
        " は ",
        ref("def_row_config_orbit_set"),
        " の軌道の全体 ",
        math(String.raw`\mathcal{O}_L`),
        " を指す添え名であって、冪でも像でもない。",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        math(String.raw`\mathfrak{S}_L`),
        " の部分集合であり、恒等写像 ",
        math(String.raw`\mathrm{id}_{R_L}`),
        " を元として持つ（",
        ref("def_row_config_orbit"),
        " で見たとおり ",
        math(String.raw`\tau\in O(\tau)`),
        " だから）。したがって空ではない。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_fixed_or_shift_preserves_orbit",
    kind: "claim",
    title: { text: "各行配位をそれ自身かその像へ送る置換は軌道を保つ" },
    labels: ["claim_fixed_or_shift_preserves_orbit"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_shift",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_map",
      "Ising2DLambda.AlgebraicEigenvalue.orbitPreserving_of_fixed_or_shift_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-characteristic-term"],
    statement: [
      paragraph([
        "置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " が、任意の ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`\varphi(\tau)=\tau`),
        " または ",
        math(String.raw`\varphi(\tau)=S(\tau)`),
        " を満たすならば ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        " を任意に取る。仮定より 2 つの場合がある。",
      ]),
      paragraph([
        math(String.raw`\varphi(\tau)=\tau`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(\tau)
&=\tau
&&(\because\ \text{この場合の仮定})\\
&=S^{[0]}(\tau)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`\varphi(\tau)\in O(\tau)`),
        " である（",
        ref("def_row_config_orbit"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\varphi(\tau)=S(\tau)`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(\tau)
&=S(\tau)
&&(\because\ \text{この場合の仮定})\\
&=S\bigl(S^{[0]}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=S^{[1]}(\tau)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]}\ \text{の}\ k=0\ \text{の場合})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`\varphi(\tau)\in O(\tau)`),
        " である（",
        ref("def_row_config_orbit"),
        "）。",
      ]),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\varphi(\tau)\in O(\tau)`),
        " であり、",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である（",
        ref("def_orbit_preserving_permutation"),
        "）。",
      ]),
      paragraph([
        ref("def_row_config_shift_iterate"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("def_orbit_preserving_permutation"),
        " を引いた。",
      ]),
      paragraph([
        ref("claim_shift_char_term_zero"),
        " と合わせると、",
        math(String.raw`\chi_U`),
        " の和のうち零元でない項を持ちうるのは ",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " の置換だけである。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_preserving_image",
    kind: "claim",
    title: { text: "軌道を保つ置換は各軌道をそれ自身へ写す" },
    labels: ["claim_orbit_preserving_image"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.image_orbit_eq_of_orbitPreserving",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.image_orbit_eq",
      "Ising2DLambda.AlgebraicEigenvalue.image_orbit_eq_of_orbitPreserving_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-characteristic-term"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\bigl\{\,\varphi(\tau) \;\bigm|\; \tau\in O\,\bigr\}=O`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "、",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。すなわち軌道を保つ置換は、どの軌道もその軌道自身の上へ写す。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを先に置く。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O=O(\tau_0)`),
        " を満たす ",
        math(String.raw`\tau_0\in R_L`),
        " が取れる。また像の集合を ",
        math(String.raw`\varphi(O):=\{\varphi(\tau)\mid\tau\in O\}`),
        " と書く。",
      ]),
      paragraph([
        math(String.raw`\varphi(O)\subset O`),
        " であること。",
        math(String.raw`\tau\in O`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
O(\tau)
&=O(\tau_0)
&&(\because\ \tau\in O=O(\tau_0)\ \text{と}\ \blkref{claim_row_config_orbit_mem_eq})\\
&=O
&&(\because\ \tau_0\ \text{の取り方})
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_orbit_preserving_permutation"),
        " より ",
        math(String.raw`\varphi(\tau)\in O(\tau)=O`),
        " である。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\varphi(O)\subset O`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\varphi(O)=O`),
        " であること。",
        math(String.raw`\varphi`),
        " は単射なので（",
        ref("def_permutation_sign"),
        " より ",
        math(String.raw`\varphi`),
        " は全単射）、",
      ]),
      displayMath(String.raw`\begin{aligned}
|\varphi(O)|
&=|O|
&&(\because\ \varphi\ \text{は単射なので}\ O\ \text{と}\ \varphi(O)\ \text{は 1 対 1 に対応する})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`O`),
        " は有限集合 ",
        math(String.raw`R_L`),
        " の部分集合なので有限であり、有限集合の部分集合であって元の個数がもとと等しいものは",
        "もとの集合に一致するから、",
        math(String.raw`\varphi(O)\subset O`),
        " と ",
        math(String.raw`|\varphi(O)|=|O|`),
        " から ",
        math(String.raw`\varphi(O)=O`),
        " が従う。",
      ]),
      paragraph([
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("def_row_config_orbit_set"),
        "、",
        ref("def_orbit_preserving_permutation"),
        "、",
        ref("def_permutation_sign"),
        " を引いた。",
      ]),
      paragraph([
        "この主張は、次のセクションで ",
        math(String.raw`\chi_U`),
        " の和を軌道ごとの行列式の積へ書き直すときに使う。軌道を保つ置換は各軌道の上の置換を",
        "定めるので、行列式の項を軌道ごとに分けて数えられるからである。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、および ",
        math(String.raw`\mathbb{N}`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_restriction",
    kind: "definition",
    title: { text: "軌道を保つ置換の、軌道への制限" },
    labels: ["def_orbit_restriction"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitRestriction"],
    verification: ["sagemath/check/orbit-restriction"],
    statement: [
      paragraph([
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "、",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。写像",
      ]),
      displayMath(
        String.raw`\varphi\!\restriction_{O}\;:\;O\longrightarrow O,\qquad \bigl(\varphi\!\restriction_{O}\bigr)(\tau):=\varphi(\tau)`,
      ),
      paragraph([
        "を ",
        math(String.raw`\varphi`),
        " の ",
        math(String.raw`O`),
        " への制限と呼ぶ。",
      ]),
      paragraph([
        "この写像の行き先が ",
        math(String.raw`O`),
        " であることは、定めるだけでは言えず示す必要がある。",
        ref("claim_orbit_preserving_image"),
        " より ",
        math(String.raw`\{\varphi(\tau)\mid\tau\in O\}=O`),
        " であり、とくに任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\varphi(\tau)\in O`),
        " である。したがって上の対応は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像として定まる。",
      ]),
      paragraph([
        "記号 ",
        math(String.raw`\varphi\!\restriction_{O}`),
        " の下付きの ",
        math(String.raw`O`),
        " は制限する先の集合を指す添え名であって、成分の添字ではない。",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像であり、",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`R_L`),
        " への写像である ",
        math(String.raw`\varphi`),
        " とは定義域も終域も異なる別の対象である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_restriction_bijective",
    kind: "claim",
    title: { text: "軌道への制限はその軌道の上の全単射である" },
    labels: ["claim_orbit_restriction_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_bijective",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.restriction_bijective",
      "Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_bijective_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-restriction"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である（",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\varphi\!\restriction_{O}`),
        " が単射であること。",
        math(String.raw`\tau_1,\tau_2\in O`),
        " が ",
        math(String.raw`\bigl(\varphi\!\restriction_{O}\bigr)(\tau_1)=\bigl(\varphi\!\restriction_{O}\bigr)(\tau_2)`),
        " を満たすとすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(\tau_1)
&=\bigl(\varphi\!\restriction_{O}\bigr)(\tau_1)
&&(\because\ \blkref{def_orbit_restriction})\\
&=\bigl(\varphi\!\restriction_{O}\bigr)(\tau_2)
&&(\because\ \text{この場合の仮定})\\
&=\varphi(\tau_2)
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\varphi`),
        " は全単射なので（",
        ref("def_permutation_sign"),
        "）とくに単射であり、",
        math(String.raw`\tau_1=\tau_2`),
        " が従う。",
      ]),
      paragraph([
        math(String.raw`\varphi\!\restriction_{O}`),
        " が全射であること。",
        math(String.raw`\tau'\in O`),
        " を任意に取る。",
        ref("claim_orbit_preserving_image"),
        " より ",
        math(String.raw`\{\varphi(\tau)\mid\tau\in O\}=O`),
        " なので、",
        math(String.raw`\tau'\in O`),
        " は左辺の元でもあり、",
        math(String.raw`\tau'=\varphi(\tau_3)`),
        " を満たす ",
        math(String.raw`\tau_3\in O`),
        " が取れる。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\varphi\!\restriction_{O}\bigr)(\tau_3)
&=\varphi(\tau_3)
&&(\because\ \blkref{def_orbit_restriction})\\
&=\tau'
&&(\because\ \tau_3\ \text{の取り方})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\tau'`),
        " は任意だったので ",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は全射である。",
      ]),
      paragraph([
        ref("def_orbit_restriction"),
        "、",
        ref("claim_orbit_preserving_image"),
        "、",
        ref("def_permutation_sign"),
        " を引いた。",
      ]),
      paragraph([
        "この主張により、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である。次のセクションで ",
        math(String.raw`\chi_U`),
        " の和を軌道ごとの積へ組み替えるとき、各軌道の因子はこの全単射にわたる和として現れる。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_restriction_determines",
    kind: "claim",
    title: { text: "制限の全体が一致する軌道を保つ置換は一致する" },
    labels: ["claim_orbit_restriction_determines"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.eq_of_orbitRestriction_eq",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.apply_eq_of_restriction_eq",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_of_agree_on_cover",
      "Ising2DLambda.AlgebraicEigenvalue.eq_of_orbitRestriction_eq_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-restriction"],
    statement: [
      paragraph([
        math(String.raw`\varphi,\psi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " が、任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について ",
        math(String.raw`\varphi\!\restriction_{O}=\psi\!\restriction_{O}`),
        " を満たすならば ",
        math(String.raw`\varphi=\psi`),
        " である（",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "）。",
      ]),
      paragraph([
        "すなわち軌道を保つ置換は、各軌道への制限の全体によって定まる。これは、軌道を保つ置換の全体と",
        "各軌道の上の置換の組の全体との対応が単射であることを述べている。",
        "実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        " を任意に取る。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O(\tau)\in\mathcal{O}_L`),
        " であり、",
        ref("def_row_config_orbit"),
        " より ",
        math(String.raw`\tau\in O(\tau)`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\varphi(\tau)
&=\bigl(\varphi\!\restriction_{O(\tau)}\bigr)(\tau)
&&(\because\ \blkref{def_orbit_restriction})\\
&=\bigl(\psi\!\restriction_{O(\tau)}\bigr)(\tau)
&&(\because\ \text{仮定を}\ O=O(\tau)\ \text{へ当てた})\\
&=\psi(\tau)
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\varphi=\psi`),
        " である。",
      ]),
      paragraph([
        ref("def_orbit_restriction"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("def_row_config_orbit_set"),
        " を引いた。",
      ]),
      paragraph([
        "この主張が使っているのは、軌道の全体が ",
        math(String.raw`R_L`),
        " を覆うこと（どの ",
        math(String.raw`\tau`),
        " も自分の軌道に属すること）だけである。軌道どうしが互いに素であること（",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        "）は、逆向きの構成（各軌道の上の置換の組から ",
        math(String.raw`R_L`),
        " の置換を貼り合わせること）で使う。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_permutation_family",
    kind: "definition",
    title: { text: "軌道ごとの置換の組" },
    labels: ["def_orbit_permutation_family"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyBijective"],
    verification: ["sagemath/check/orbit-gluing"],
    statement: [
      paragraph([
        "軌道の全体 ",
        math(String.raw`\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）の各元 ",
        math(String.raw`O`),
        " へ、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射を 1 つずつ対応させる対応の全体を",
      ]),
      displayMath(
        String.raw`\mathfrak{A}_L:=\bigl\{\,\alpha \;\bigm|\; \alpha\ \text{は}\ \mathcal{O}_L\ \text{の各元}\ O\ \text{へ}\ O\ \text{から}\ O\ \text{への全単射}\ \alpha(O)\ \text{を対応させる}\,\bigr\}`,
      ),
      paragraph([
        "と置き、その元を軌道ごとの置換の組と呼ぶ。",
      ]),
      paragraph([
        "記号について 2 つ断っておく。第一に、",
        math(String.raw`\alpha(O)`),
        " は ",
        math(String.raw`\alpha`),
        " を ",
        math(String.raw`\mathcal{O}_L`),
        " の元 ",
        math(String.raw`O`),
        " へ当てた結果であって、",
        math(String.raw`R_L`),
        " の元へ当てたものではない。",
        math(String.raw`\alpha(O)`),
        " 自身が ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像であり、その値は ",
        math(String.raw`\bigl(\alpha(O)\bigr)(\tau)`),
        " と丸括弧を 2 段に重ねて書く。第二に、",
        math(String.raw`\mathfrak{A}_L`),
        " の元は ",
        math(String.raw`\mathfrak{S}_L`),
        "（",
        ref("def_permutation_sign"),
        "）の元ではない。",
        math(String.raw`\mathfrak{S}_L`),
        " の元は ",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`R_L`),
        " への全単射 1 つであり、",
        math(String.raw`\mathfrak{A}_L`),
        " の元は軌道ごとに 1 つずつ与えられた全単射の組である。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{A}_L`),
        " は空ではない。各 ",
        math(String.raw`O\in\mathcal{O}_L`),
        " へ ",
        math(String.raw`O`),
        " の恒等写像を対応させたものが元になるからである。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_gluing",
    kind: "definition",
    title: { text: "軌道ごとの置換の組の貼り合わせ" },
    labels: ["def_orbit_gluing"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.glueFun"],
    verification: ["sagemath/check/orbit-gluing"],
    statement: [
      paragraph([
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " を任意に取る（",
        math(String.raw`\mathfrak{A}_L`),
        " は ",
        ref("def_orbit_permutation_family"),
        "）。写像",
      ]),
      displayMath(
        String.raw`\mathrm{gl}(\alpha)\;:\;R_L\longrightarrow R_L,\qquad \bigl(\mathrm{gl}(\alpha)\bigr)(\tau):=\bigl(\alpha(O(\tau))\bigr)(\tau)`,
      ),
      paragraph([
        "を ",
        math(String.raw`\alpha`),
        " の貼り合わせと呼ぶ（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。",
      ]),
      paragraph([
        "右辺が定まることは、次の 3 つによる。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O(\tau)\in\mathcal{O}_L`),
        " なので ",
        math(String.raw`\alpha(O(\tau))`),
        " が定まる。",
        ref("def_row_config_orbit"),
        " より ",
        math(String.raw`\tau\in O(\tau)`),
        " なので、その写像を ",
        math(String.raw`\tau`),
        " へ当てられる。そして ",
        math(String.raw`\alpha(O(\tau))`),
        " の値は ",
        math(String.raw`O(\tau)`),
        " の元であり、",
        math(String.raw`O(\tau)\subset R_L`),
        " なので ",
        math(String.raw`R_L`),
        " の元である。",
      ]),
      paragraph([
        "この定義では、",
        math(String.raw`\tau`),
        " の属する軌道として ",
        math(String.raw`O(\tau)`),
        " を選んでいる。",
        math(String.raw`\tau`),
        " を含む ",
        math(String.raw`\mathcal{O}_L`),
        " の元が ",
        math(String.raw`O(\tau)`),
        " のほかにもあれば、どれを選ぶかで値が変わりうる。そうならないことは ",
        ref("claim_row_config_orbit_mem_eq"),
        " による（",
        math(String.raw`\tau\in O`),
        " かつ ",
        math(String.raw`O=O(\tau_0)`),
        " ならば ",
        math(String.raw`O(\tau)=O(\tau_0)=O`),
        "）。この一意性は ",
        ref("claim_orbit_gluing_bijective"),
        " の全射性の段と ",
        ref("claim_orbit_gluing_restriction"),
        " で使う。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_gluing_bijective",
    kind: "claim",
    title: { text: "貼り合わせは行配位の全体の上の全単射である" },
    labels: ["claim_orbit_gluing_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.glueFun_bijective",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.glue_bijective",
      "Ising2DLambda.AlgebraicEigenvalue.glueFun_bijective_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-gluing"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " について ",
        math(String.raw`\mathrm{gl}(\alpha)`),
        " は ",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`R_L`),
        " への全単射である。すなわち ",
        math(String.raw`\mathrm{gl}(\alpha)\in\mathfrak{S}_L`),
        " である（",
        math(String.raw`\mathrm{gl}(\alpha)`),
        " は ",
        ref("def_orbit_gluing"),
        "、",
        math(String.raw`\mathfrak{S}_L`),
        " は ",
        ref("def_permutation_sign"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{gl}(\alpha)`),
        " が単射であること。",
        math(String.raw`\tau_1,\tau_2\in R_L`),
        " が ",
        math(String.raw`\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_1)=\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_2)`),
        " を満たすとし、この共通の値を ",
        math(String.raw`\tau_3`),
        " と置く。",
        math(String.raw`\alpha(O(\tau_1))`),
        " は ",
        math(String.raw`O(\tau_1)`),
        " から ",
        math(String.raw`O(\tau_1)`),
        " への写像なので（",
        ref("def_orbit_permutation_family"),
        "）",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau_3
&=\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_1)
&&(\because\ \tau_3\ \text{の置き方})\\
&=\bigl(\alpha(O(\tau_1))\bigr)(\tau_1)
&&(\because\ \blkref{def_orbit_gluing})\\
&\in O(\tau_1)
&&(\because\ \blkref{def_orbit_permutation_family})
\end{aligned}`),
      paragraph([
        "であり、同じ計算を ",
        math(String.raw`\tau_2`),
        " について行うと ",
        math(String.raw`\tau_3\in O(\tau_2)`),
        " である。したがって ",
        math(String.raw`O(\tau_1)\cap O(\tau_2)`),
        " は ",
        math(String.raw`\tau_3`),
        " を元に持ち空ではないので、",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        " より ",
        math(String.raw`O(\tau_1)=O(\tau_2)`),
        " である。この集合を ",
        math(String.raw`O`),
        " と置くと",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\alpha(O)\bigr)(\tau_1)
&=\bigl(\alpha(O(\tau_1))\bigr)(\tau_1)
&&(\because\ O=O(\tau_1))\\
&=\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_1)
&&(\because\ \blkref{def_orbit_gluing})\\
&=\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_2)
&&(\because\ \text{この場合の仮定})\\
&=\bigl(\alpha(O(\tau_2))\bigr)(\tau_2)
&&(\because\ \blkref{def_orbit_gluing})\\
&=\bigl(\alpha(O)\bigr)(\tau_2)
&&(\because\ O=O(\tau_2))
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\alpha(O)`),
        " は全単射なので（",
        ref("def_orbit_permutation_family"),
        "）とくに単射であり、",
        math(String.raw`\tau_1=\tau_2`),
        " が従う。ここで ",
        math(String.raw`\tau_1,\tau_2\in O`),
        " であることは ",
        ref("def_row_config_orbit"),
        " の ",
        math(String.raw`\tau\in O(\tau)`),
        " による。",
      ]),
      paragraph([
        math(String.raw`\mathrm{gl}(\alpha)`),
        " が全射であること。",
        math(String.raw`\tau'\in R_L`),
        " を任意に取る。",
        ref("def_row_config_orbit"),
        " より ",
        math(String.raw`\tau'\in O(\tau')`),
        " であり、",
        math(String.raw`\alpha(O(\tau'))`),
        " は ",
        math(String.raw`O(\tau')`),
        " から ",
        math(String.raw`O(\tau')`),
        " への全射なので（",
        ref("def_orbit_permutation_family"),
        "）、",
        math(String.raw`\bigl(\alpha(O(\tau'))\bigr)(\tau_4)=\tau'`),
        " を満たす ",
        math(String.raw`\tau_4\in O(\tau')`),
        " が取れる。このとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{gl}(\alpha)\bigr)(\tau_4)
&=\bigl(\alpha(O(\tau_4))\bigr)(\tau_4)
&&(\because\ \blkref{def_orbit_gluing})\\
&=\bigl(\alpha(O(\tau'))\bigr)(\tau_4)
&&(\because\ \tau_4\in O(\tau')\ \text{と}\ \blkref{claim_row_config_orbit_mem_eq})\\
&=\tau'
&&(\because\ \tau_4\ \text{の取り方})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\tau'`),
        " は任意だったので ",
        math(String.raw`\mathrm{gl}(\alpha)`),
        " は全射である。",
      ]),
      paragraph([
        ref("def_orbit_gluing"),
        "、",
        ref("def_orbit_permutation_family"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        " を引いた。",
      ]),
      paragraph([
        "単射性の証明で ",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        " を使ったところが、この節で軌道どうしが互いに素であることが効いている箇所である。",
        math(String.raw`\tau_1`),
        " と ",
        math(String.raw`\tau_2`),
        " が別々の軌道の上で動かされているとき、行き先が一致したという仮定だけから",
        "同じ軌道であることを出すのに、共通の元を持つ 2 つの軌道が一致することが要る。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_gluing_orbit_preserving",
    kind: "claim",
    title: { text: "貼り合わせは軌道を保つ置換である" },
    labels: ["claim_orbit_gluing_orbit_preserving"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.gluePerm_orbitPreserving",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.glue_mem_block",
      "Ising2DLambda.AlgebraicEigenvalue.glueFun_mem_orbit_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-gluing"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " について ",
        math(String.raw`\mathrm{gl}(\alpha)\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_orbit_gluing_bijective"),
        " より ",
        math(String.raw`\mathrm{gl}(\alpha)\in\mathfrak{S}_L`),
        " である。",
        ref("def_orbit_preserving_permutation"),
        " の条件を確かめる。",
        math(String.raw`\tau\in R_L`),
        " を任意に取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{gl}(\alpha)\bigr)(\tau)
&=\bigl(\alpha(O(\tau))\bigr)(\tau)
&&(\because\ \blkref{def_orbit_gluing})\\
&\in O(\tau)
&&(\because\ \blkref{def_orbit_permutation_family})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\mathrm{gl}(\alpha)\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である。",
      ]),
      paragraph([
        ref("claim_orbit_gluing_bijective"),
        "、",
        ref("def_orbit_gluing"),
        "、",
        ref("def_orbit_permutation_family"),
        "、",
        ref("def_orbit_preserving_permutation"),
        " を引いた。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_gluing_restriction",
    kind: "claim",
    title: { text: "貼り合わせの各軌道への制限はもとの組に一致する" },
    labels: ["claim_orbit_gluing_restriction"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_gluePerm",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.restriction_glue",
      "Ising2DLambda.AlgebraicEigenvalue.orbitRestriction_gluePerm_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-gluing"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " と ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{gl}(\alpha)\!\restriction_{O}=\alpha(O)`,
      ),
      paragraph([
        "である（",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "、",
        math(String.raw`\mathrm{gl}(\alpha)`),
        " は ",
        ref("def_orbit_gluing"),
        "）。左辺が定まることは ",
        ref("claim_orbit_gluing_orbit_preserving"),
        " による。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを先に置く。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O=O(\tau_0)`),
        " を満たす ",
        math(String.raw`\tau_0\in R_L`),
        " が取れる。",
      ]),
      paragraph([
        math(String.raw`\tau\in O`),
        " を任意に取る。まず軌道が ",
        math(String.raw`O`),
        " に定まることを見る。",
      ]),
      displayMath(String.raw`\begin{aligned}
O(\tau)
&=O(\tau_0)
&&(\because\ \tau\in O=O(\tau_0)\ \text{と}\ \blkref{claim_row_config_orbit_mem_eq})\\
&=O
&&(\because\ \tau_0\ \text{の取り方})
\end{aligned}`),
      paragraph([
        "である。これを使うと",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{gl}(\alpha)\!\restriction_{O}\bigr)(\tau)
&=\bigl(\mathrm{gl}(\alpha)\bigr)(\tau)
&&(\because\ \blkref{def_orbit_restriction})\\
&=\bigl(\alpha(O(\tau))\bigr)(\tau)
&&(\because\ \blkref{def_orbit_gluing})\\
&=\bigl(\alpha(O)\bigr)(\tau)
&&(\because\ O(\tau)=O)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\mathrm{gl}(\alpha)\!\restriction_{O}=\alpha(O)`),
        " である。",
      ]),
      paragraph([
        ref("def_orbit_restriction"),
        "、",
        ref("def_orbit_gluing"),
        "、",
        ref("def_row_config_orbit_set"),
        "、",
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("claim_orbit_gluing_orbit_preserving"),
        " を引いた。",
      ]),
      paragraph([
        "この主張と ",
        ref("claim_orbit_restriction_bijective"),
        "、",
        ref("claim_orbit_restriction_determines"),
        " を合わせると、軌道を保つ置換 ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " へその制限の組 ",
        math(String.raw`O\mapsto\varphi\!\restriction_{O}`),
        " を対応させる写像が ",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " から ",
        math(String.raw`\mathfrak{A}_L`),
        " への全単射であることが分かる。この対応が ",
        math(String.raw`\mathfrak{A}_L`),
        " に値を取ること（各 ",
        math(String.raw`O`),
        " で ",
        math(String.raw`\varphi\!\restriction_{O}`),
        " が ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射であること）は ",
        ref("claim_orbit_restriction_bijective"),
        " が、単射であることは ",
        ref("claim_orbit_restriction_determines"),
        " が、全射であることはこの主張が与える（",
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " に対して ",
        math(String.raw`\mathrm{gl}(\alpha)`),
        " が逆像である）。この 1 対 1 対応が、次のセクションで ",
        math(String.raw`\chi_U`),
        " の和を軌道ごとの積へ組み替えるときの土台になる。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_cross_orbit_ordered_pairs",
    kind: "definition",
    title: { text: "2 つの軌道にまたがる順序づけられた対の全体" },
    labels: ["def_cross_orbit_ordered_pairs"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.crossOrderedPairs"],
    verification: ["sagemath/check/cross-orbit-inversions"],
    statement: [
      paragraph([
        math(String.raw`O,O'\in\mathcal{O}_L`),
        " を任意に取る（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。第 1 成分が ",
        math(String.raw`O`),
        " に、第 2 成分が ",
        math(String.raw`O'`),
        " に属する対のうち ",
        ref("def_row_config_order"),
        " の順序 ",
        math(String.raw`\prec`),
        " について順序づけられているものの全体を",
      ]),
      displayMath(
        String.raw`F(O,O'):=\bigl\{\,(\tau,\tau')\in O\times O' \;\bigm|\; \tau\prec\tau'\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`O\times O'`),
        " は有限集合 ",
        math(String.raw`R_L`),
        " の部分集合どうしの直積なので有限集合であり、",
        math(String.raw`F(O,O')`),
        " も有限集合である。したがって ",
        math(String.raw`|F(O,O')|\in\mathbb{N}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`F(O,O')`),
        " は ",
        math(String.raw`P_L`),
        "（",
        ref("def_inversion_count"),
        "）の部分集合であるが、両者を同じ記号で書かない。",
        math(String.raw`P_L`),
        " は ",
        math(String.raw`R_L`),
        " 全体の上の対の集合であり、",
        math(String.raw`F(O,O')`),
        " は成分の属する軌道を指定した部分である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_cross_orbit_ordered_pairs_image",
    kind: "definition",
    title: { text: "置換で送ってから順序を見た、またがる対の全体" },
    labels: ["def_cross_orbit_ordered_pairs_image"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.crossOrderedPairsImage"],
    verification: ["sagemath/check/cross-orbit-inversions"],
    statement: [
      paragraph([
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）と ",
        math(String.raw`O,O'\in\mathcal{O}_L`),
        " を任意に取る。",
        ref("def_cross_orbit_ordered_pairs"),
        " の ",
        math(String.raw`F(O,O')`),
        " と同じ形で、順序を ",
        math(String.raw`\varphi`),
        " で送ったあとの値について見たものを",
      ]),
      displayMath(
        String.raw`F_\varphi(O,O'):=\bigl\{\,(\tau,\tau')\in O\times O' \;\bigm|\; \varphi(\tau)\prec\varphi(\tau')\,\bigr\}`,
      ),
      paragraph([
        "と置く。これも有限集合の部分集合なので有限集合であり、",
        math(String.raw`|F_\varphi(O,O')|\in\mathbb{N}`),
        " である。",
      ]),
      paragraph([
        "記号について 1 つ断っておく。下付きの ",
        math(String.raw`\varphi`),
        " は成分の添字ではなく、どの置換で送ってから順序を見るかを表す。",
        math(String.raw`F(O,O')`),
        " と ",
        math(String.raw`F_\varphi(O,O')`),
        " は同じ集合 ",
        math(String.raw`O\times O'`),
        " の部分集合であり、対を選ぶ条件だけが違う。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_cross_orbit_inversions",
    kind: "definition",
    title: { text: "2 つの軌道にまたがる転倒対の全体" },
    labels: ["def_cross_orbit_inversions"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.crossInversions"],
    verification: ["sagemath/check/cross-orbit-inversions"],
    statement: [
      paragraph([
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`O,O'\in\mathcal{O}_L`),
        " を任意に取る。",
        ref("def_inversion_count"),
        " の転倒数が数えている対のうち、2 つの成分が ",
        math(String.raw`O`),
        " と ",
        math(String.raw`O'`),
        " へ分かれて属するものの全体を",
      ]),
      displayMath(
        String.raw`J_\varphi(O,O'):=\bigl\{\,(\tau,\tau')\in P_L \;\bigm|\; \bigl(\,(\tau\in O\ \text{かつ}\ \tau'\in O')\ \text{または}\ (\tau\in O'\ \text{かつ}\ \tau'\in O)\,\bigr)\ \text{かつ}\ \varphi(\tau')\prec\varphi(\tau)\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`P_L`),
        " が有限集合なので ",
        math(String.raw`J_\varphi(O,O')`),
        " も有限集合であり、",
        math(String.raw`|J_\varphi(O,O')|\in\mathbb{N}`),
        " である。",
      ]),
      paragraph([
        "条件を 2 つに分けて書いているのは、",
        math(String.raw`P_L`),
        " の元が順序づけられた対であって、どちらの成分がどちらの軌道に属するかが決まっていないからである。",
        math(String.raw`\tau\prec\tau'`),
        " という条件と「",
        math(String.raw`\tau`),
        " が ",
        math(String.raw`O`),
        " に属する」という条件は独立であり、両方の並び方が起こりうる。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_cross_orbit_ordered_card",
    kind: "claim",
    title: { text: "軌道を保つ置換はまたがる順序づけられた対の個数を変えない" },
    labels: ["claim_cross_orbit_ordered_card"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.card_crossOrderedPairsImage",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_pairs_image_eq",
      "Ising2DLambda.AlgebraicEigenvalue.card_crossOrderedPairsImage_from_necSuf",
    ],
    verification: ["sagemath/check/cross-orbit-inversions"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`O,O'\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(String.raw`\bigl|F_\varphi(O,O')\bigr|=\bigl|F(O,O')\bigr|`),
      paragraph([
        "である（",
        math(String.raw`F(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        math(String.raw`F_\varphi(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs_image"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う写像を先に置く。",
      ]),
      displayMath(
        String.raw`\Upsilon\;:\;O\times O'\longrightarrow O\times O',\qquad \Upsilon(\tau,\tau'):=\bigl(\varphi(\tau),\varphi(\tau')\bigr)`,
      ),
      paragraph([
        "とする。行き先が ",
        math(String.raw`O\times O'`),
        " に収まることは ",
        ref("claim_orbit_preserving_image"),
        " による（",
        math(String.raw`\varphi(O)=O`),
        " と ",
        math(String.raw`\tau\in O`),
        " から ",
        math(String.raw`\varphi(\tau)\in O`),
        "、同様に ",
        math(String.raw`\varphi(\tau')\in O'`),
        "）。",
      ]),
      paragraph([
        math(String.raw`\Upsilon`),
        " が単射であること。",
        math(String.raw`\Upsilon(\tau_1,\tau_1')=\Upsilon(\tau_2,\tau_2')`),
        " とすると、成分ごとに ",
        math(String.raw`\varphi(\tau_1)=\varphi(\tau_2)`),
        " かつ ",
        math(String.raw`\varphi(\tau_1')=\varphi(\tau_2')`),
        " である。",
        math(String.raw`\varphi`),
        " は全単射なのでとくに単射であり（",
        ref("def_permutation_sign"),
        "）、",
        math(String.raw`\tau_1=\tau_2`),
        " かつ ",
        math(String.raw`\tau_1'=\tau_2'`),
        " が従う。",
      ]),
      paragraph([
        math(String.raw`\Upsilon`),
        " が全射であること。",
        math(String.raw`(\tau_3,\tau_3')\in O\times O'`),
        " を任意に取る。",
        ref("claim_orbit_preserving_image"),
        " の ",
        math(String.raw`\varphi(O)=O`),
        " より ",
        math(String.raw`\varphi(\tau_4)=\tau_3`),
        " を満たす ",
        math(String.raw`\tau_4\in O`),
        " が取れ、",
        math(String.raw`\varphi(O')=O'`),
        " より ",
        math(String.raw`\varphi(\tau_4')=\tau_3'`),
        " を満たす ",
        math(String.raw`\tau_4'\in O'`),
        " が取れる。このとき ",
        math(String.raw`\Upsilon(\tau_4,\tau_4')=(\tau_3,\tau_3')`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\Upsilon`),
        " が ",
        math(String.raw`F_\varphi(O,O')`),
        " を ",
        math(String.raw`F(O,O')`),
        " の中へ写すこと。",
        math(String.raw`(\tau,\tau')\in F_\varphi(O,O')`),
        " を取ると",
      ]),
      displayMath(String.raw`\begin{aligned}
\Upsilon(\tau,\tau')
&=\bigl(\varphi(\tau),\varphi(\tau')\bigr)
&&(\because\ \Upsilon\ \text{の置き方})\\
&\in F(O,O')
&&(\because\ \varphi(\tau)\prec\varphi(\tau')\ \text{と}\ \blkref{def_cross_orbit_ordered_pairs})
\end{aligned}`),
      paragraph([
        "である。逆に ",
        math(String.raw`(\tau,\tau')\in O\times O'`),
        " が ",
        math(String.raw`\Upsilon(\tau,\tau')\in F(O,O')`),
        " を満たすなら、",
        ref("def_cross_orbit_ordered_pairs"),
        " より ",
        math(String.raw`\varphi(\tau)\prec\varphi(\tau')`),
        " であり、",
        ref("def_cross_orbit_ordered_pairs_image"),
        " より ",
        math(String.raw`(\tau,\tau')\in F_\varphi(O,O')`),
        " である。",
      ]),
      paragraph([
        "以上より、",
        math(String.raw`\Upsilon`),
        " の ",
        math(String.raw`F_\varphi(O,O')`),
        " への制限は ",
        math(String.raw`F_\varphi(O,O')`),
        " から ",
        math(String.raw`F(O,O')`),
        " への全単射である。単射性は ",
        math(String.raw`\Upsilon`),
        " の単射性から、全射性は ",
        math(String.raw`\Upsilon`),
        " の全射性と、いま見た ",
        math(String.raw`\Upsilon(\tau,\tau')\in F(O,O')\Rightarrow(\tau,\tau')\in F_\varphi(O,O')`),
        " から従う。有限集合のあいだに全単射があるので個数が等しく、",
        math(String.raw`|F_\varphi(O,O')|=|F(O,O')|`),
        " である。",
      ]),
      paragraph([
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        ref("def_cross_orbit_ordered_pairs_image"),
        "、",
        ref("claim_orbit_preserving_image"),
        "、",
        ref("def_permutation_sign"),
        " を引いた。",
      ]),
      paragraph([
        "この主張が ",
        math(String.raw`\varphi`),
        " に要求しているのは ",
        math(String.raw`\varphi(O)=O`),
        " と ",
        math(String.raw`\varphi(O')=O'`),
        " の 2 つだけである。",
        math(String.raw`O`),
        " と ",
        math(String.raw`O'`),
        " が互いに素であることも、両者が相異なることも使っていない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_cross_orbit_inversions_even",
    kind: "claim",
    title: { text: "2 つの相異なる軌道にまたがる転倒対の個数は偶数である" },
    labels: ["claim_cross_orbit_inversions_even"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.card_crossInversions_eq_two_mul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_crossInv_eq_two_mul",
      "Ising2DLambda.AlgebraicEigenvalue.card_crossInversions_eq_two_mul_from_necSuf",
    ],
    verification: ["sagemath/check/cross-orbit-inversions"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " と、",
        math(String.raw`O\ne O'`),
        " を満たす任意の ",
        math(String.raw`O,O'\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\bigl|J_\varphi(O,O')\bigr|=2\cdot\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|`,
      ),
      paragraph([
        "である。とくに ",
        math(String.raw`|J_\varphi(O,O')|`),
        " は偶数である（",
        math(String.raw`J_\varphi(O,O')`),
        " は ",
        ref("def_cross_orbit_inversions"),
        "、",
        math(String.raw`F(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        math(String.raw`F_\varphi(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs_image"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使うものを先に置く。第一に、",
        math(String.raw`O\ne O'`),
        " と ",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        " より ",
        math(String.raw`O\cap O'=\emptyset`),
        " である。したがって ",
        math(String.raw`\tau\in O`),
        " かつ ",
        math(String.raw`\tau'\in O'`),
        " ならば ",
        math(String.raw`\tau\ne\tau'`),
        " であり、",
        ref("claim_orbit_preserving_image"),
        " より ",
        math(String.raw`\varphi(\tau)\in O`),
        " かつ ",
        math(String.raw`\varphi(\tau')\in O'`),
        " なので ",
        math(String.raw`\varphi(\tau)\ne\varphi(\tau')`),
        " でもある。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`(\tau,\tau')\in O\times O'`),
        " について、",
        ref("claim_row_config_order_linear"),
        " の三分律と ",
        math(String.raw`\tau\ne\tau'`),
        " から ",
        math(String.raw`\tau\prec\tau'`),
        " と ",
        math(String.raw`\tau'\prec\tau`),
        " のちょうど一方が成り立つ。",
        math(String.raw`\varphi(\tau)`),
        " と ",
        math(String.raw`\varphi(\tau')`),
        " についても同じことが言える。したがって ",
        ref("def_cross_orbit_ordered_pairs"),
        " と ",
        ref("def_cross_orbit_ordered_pairs_image"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
F(O,O')\setminus F_\varphi(O,O')
&=\bigl\{\,(\tau,\tau')\in O\times O' \;\bigm|\; \tau\prec\tau'\ \text{かつ}\ \varphi(\tau')\prec\varphi(\tau)\,\bigr\},\\
F_\varphi(O,O')\setminus F(O,O')
&=\bigl\{\,(\tau,\tau')\in O\times O' \;\bigm|\; \tau'\prec\tau\ \text{かつ}\ \varphi(\tau)\prec\varphi(\tau')\,\bigr\}
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第三に、この 2 つの個数が等しい。有限集合の個数について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|
&=\bigl|F(O,O')\bigr|-\bigl|F(O,O')\cap F_\varphi(O,O')\bigr|
&&(\because\ \text{有限集合の差の個数})\\
&=\bigl|F_\varphi(O,O')\bigr|-\bigl|F(O,O')\cap F_\varphi(O,O')\bigr|
&&(\because\ \blkref{claim_cross_orbit_ordered_card})\\
&=\bigl|F_\varphi(O,O')\bigr|-\bigl|F_\varphi(O,O')\cap F(O,O')\bigr|
&&(\because\ \text{共通部分の可換性})\\
&=\bigl|F_\varphi(O,O')\setminus F(O,O')\bigr|
&&(\because\ \text{有限集合の差の個数})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "本体に入る。",
        math(String.raw`J_\varphi(O,O')`),
        " を、第 1 成分がどちらの軌道に属するかで 2 つに分ける。",
      ]),
      displayMath(String.raw`\begin{aligned}
J_1&:=\bigl\{\,(\tau,\tau')\in J_\varphi(O,O') \;\bigm|\; \tau\in O\ \text{かつ}\ \tau'\in O'\,\bigr\},\\
J_2&:=\bigl\{\,(\tau,\tau')\in J_\varphi(O,O') \;\bigm|\; \tau\in O'\ \text{かつ}\ \tau'\in O\,\bigr\}
\end{aligned}`),
      paragraph([
        "と置く。",
        ref("def_cross_orbit_inversions"),
        " の条件が 2 つの場合のいずれかであることから ",
        math(String.raw`J_\varphi(O,O')=J_1\cup J_2`),
        " であり、",
        math(String.raw`O\cap O'=\emptyset`),
        " より同じ対が両方に属することはないので ",
        math(String.raw`J_1\cap J_2=\emptyset`),
        " である。",
      ]),
      paragraph([
        math(String.raw`J_1=F(O,O')\setminus F_\varphi(O,O')`),
        " であること。",
        math(String.raw`(\tau,\tau')`),
        " が ",
        math(String.raw`J_1`),
        " に属することは、",
        math(String.raw`\tau\in O`),
        "、",
        math(String.raw`\tau'\in O'`),
        "、",
        math(String.raw`\tau\prec\tau'`),
        "（",
        math(String.raw`P_L`),
        " に属することの中身。",
        ref("def_inversion_count"),
        "）、",
        math(String.raw`\varphi(\tau')\prec\varphi(\tau)`),
        " が同時に成り立つことであり、上で書き下した ",
        math(String.raw`F(O,O')\setminus F_\varphi(O,O')`),
        " の条件とちょうど同じである。",
      ]),
      paragraph([
        math(String.raw`J_2`),
        " と ",
        math(String.raw`F_\varphi(O,O')\setminus F(O,O')`),
        " が 1 対 1 に対応すること。成分を入れ替える写像 ",
        math(String.raw`\mathrm{sw}(\tau,\tau'):=(\tau',\tau)`),
        " を取る。",
        math(String.raw`(\tau,\tau')\in J_2`),
        " のとき ",
        math(String.raw`\tau'\in O`),
        " かつ ",
        math(String.raw`\tau\in O'`),
        " なので ",
        math(String.raw`\mathrm{sw}(\tau,\tau')\in O\times O'`),
        " であり、その条件は",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau\prec\tau'&\quad\text{すなわち}\quad \text{(第 2 成分)}\prec\text{(第 1 成分)},\\
\varphi(\tau')\prec\varphi(\tau)&\quad\text{すなわち}\quad \varphi(\text{第 1 成分})\prec\varphi(\text{第 2 成分})
\end{aligned}`),
      paragraph([
        "となる。これは上で書き下した ",
        math(String.raw`F_\varphi(O,O')\setminus F(O,O')`),
        " の条件そのものである。逆向きも同様で、",
        math(String.raw`(\tau_5,\tau_5')\in F_\varphi(O,O')\setminus F(O,O')`),
        " に対して ",
        math(String.raw`\mathrm{sw}(\tau_5,\tau_5')=(\tau_5',\tau_5)`),
        " は ",
        math(String.raw`\tau_5'\prec\tau_5`),
        " より ",
        math(String.raw`P_L`),
        " に属し、",
        math(String.raw`\tau_5'\in O'`),
        " かつ ",
        math(String.raw`\tau_5\in O`),
        " と ",
        math(String.raw`\varphi(\tau_5)\prec\varphi(\tau_5')`),
        " より ",
        math(String.raw`J_2`),
        " に属する。",
        math(String.raw`\mathrm{sw}`),
        " を 2 度施すともとに戻るので、この 2 つは互いに逆の写像であり ",
        math(String.raw`|J_2|=|F_\varphi(O,O')\setminus F(O,O')|`),
        " である。",
      ]),
      paragraph([
        "以上より",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|J_\varphi(O,O')\bigr|
&=|J_1|+|J_2|
&&(\because\ J_\varphi(O,O')=J_1\cup J_2\ \text{と}\ J_1\cap J_2=\emptyset)\\
&=\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|+|J_2|
&&(\because\ J_1=F(O,O')\setminus F_\varphi(O,O'))\\
&=\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|+\bigl|F_\varphi(O,O')\setminus F(O,O')\bigr|
&&(\because\ \mathrm{sw}\ \text{が与える 1 対 1 対応})\\
&=\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|+\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|
&&(\because\ \text{準備の第三})\\
&=2\cdot\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|
&&(\because\ \text{同じ数の 2 つ分の和})
\end{aligned}`),
      paragraph([
        "である。右辺は ",
        math(String.raw`2`),
        " の倍数なので ",
        math(String.raw`|J_\varphi(O,O')|`),
        " は偶数である。",
      ]),
      paragraph([
        ref("def_cross_orbit_inversions"),
        "、",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        ref("def_cross_orbit_ordered_pairs_image"),
        "、",
        ref("def_inversion_count"),
        "、",
        ref("claim_cross_orbit_ordered_card"),
        "、",
        ref("claim_row_config_orbit_disjoint_or_eq"),
        "、",
        ref("claim_row_config_order_linear"),
        "、",
        ref("claim_orbit_preserving_image"),
        " を引いた。",
      ]),
      paragraph([
        "軌道が相異なることは 2 か所で効いている。",
        math(String.raw`O\cap O'=\emptyset`),
        " を出すところと、そこから ",
        math(String.raw`\tau\ne\tau'`),
        " を出して三分律を当てるところである。",
        math(String.raw`O=O'`),
        " のときはこの主張は成り立つとは限らない。",
        math(String.raw`J_\varphi(O,O)`),
        " は軌道 ",
        math(String.raw`O`),
        " の中の転倒対の全体になり、その個数は ",
        math(String.raw`\varphi\!\restriction_{O}`),
        " の転倒数であって偶数とは限らないからである。",
      ]),
      paragraph([
        "この主張が、次のセクションで転倒数を軌道ごとの転倒数の和へ書き直すときに、",
        "またぐ対の寄与が符号に効かないことを与える。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_inversion_pairs",
    kind: "definition",
    title: { text: "置換の転倒対の全体" },
    labels: ["def_inversion_pairs"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.inversionPairs"],
    verification: ["sagemath/check/inversion-orbit-decomposition"],
    statement: [
      paragraph([
        ref("def_inversion_count"),
        " の転倒数 ",
        math(String.raw`\mathrm{inv}(\varphi)`),
        " は、ある集合の元の個数として定めた。これから先はその集合そのものを分けて数えるので、",
        "集合の側に名前を与える。",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " を任意に取り",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}(\varphi):=\bigl\{\,(\tau,\tau')\in P_L \;\bigm|\; \varphi(\tau')\prec\varphi(\tau)\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`P_L`),
        " と ",
        math(String.raw`\prec`),
        " は ",
        ref("def_inversion_count"),
        " と ",
        ref("def_row_config_order"),
        "）。",
        math(String.raw`P_L`),
        " が有限集合なので ",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        " も有限集合であり、",
        ref("def_inversion_count"),
        " の右辺はこの集合の元の個数だったので",
      ]),
      displayMath(String.raw`\mathrm{inv}(\varphi)=\bigl|\mathrm{Inv}(\varphi)\bigr|\in\mathbb{N}`),
      paragraph([
        "である。これは定義の書き換えであって、新しい主張ではない。",
      ]),
      paragraph([
        "記号について 1 つ断っておく。",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        " は集合、",
        math(String.raw`\mathrm{inv}(\varphi)`),
        " はその元の個数であり、大文字と小文字で別の対象を表す。",
        "この 2 つを同じ記号で書かない。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の対の集合、写像、順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_inversion_count",
    kind: "definition",
    title: { text: "軌道の上の全単射の転倒数" },
    labels: ["def_orbit_inversion_count"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitInversionCount"],
    verification: ["sagemath/check/inversion-orbit-decomposition"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射 ",
        math(String.raw`\psi`),
        " を任意に取る。",
        ref("def_cross_orbit_ordered_pairs"),
        " で置いた ",
        math(String.raw`F(O,O')`),
        " において ",
        math(String.raw`O'=O`),
        " と取った集合",
      ]),
      displayMath(
        String.raw`F(O,O)=\bigl\{\,(\tau,\tau')\in O\times O \;\bigm|\; \tau\prec\tau'\,\bigr\}`,
      ),
      paragraph([
        "を台として、",
        math(String.raw`\psi`),
        " の転倒数を",
      ]),
      displayMath(
        String.raw`\mathrm{inv}_{O}(\psi):=\bigl|\,\bigl\{\,(\tau,\tau')\in F(O,O) \;\bigm|\; \psi(\tau')\prec\psi(\tau)\,\bigr\}\,\bigr|\in\mathbb{N}`,
      ),
      paragraph([
        "で定める。有限集合の元の個数なので自然数である。",
      ]),
      paragraph([
        "これは ",
        ref("def_inversion_count"),
        " の転倒数を、台を ",
        math(String.raw`P_L`),
        " から ",
        math(String.raw`F(O,O)`),
        " へ取り替えて写したものである。",
        "台が違うので同じ記号では書けず、下付きに ",
        math(String.raw`O`),
        " を付けて区別する。この下付きの ",
        math(String.raw`O`),
        " は台に取った集合を指す添え名であって、成分の添字ではない。",
      ]),
      paragraph([
        "順序 ",
        math(String.raw`\prec`),
        " は ",
        math(String.raw`R_L`),
        " の上の順序（",
        ref("def_row_config_order"),
        "）をそのまま使う。",
        math(String.raw`O`),
        " の上に新しい順序を入れるのではなく、",
        math(String.raw`O\subset R_L`),
        " の元どうしを ",
        math(String.raw`R_L`),
        " の順序で比べている。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_cross_orbit_inversion_pairs",
    kind: "definition",
    title: { text: "軌道をまたぐ転倒対の全体" },
    labels: ["def_cross_orbit_inversion_pairs"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs"],
    verification: ["sagemath/check/inversion-orbit-decomposition"],
    statement: [
      paragraph([
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        " を任意に取る。",
        ref("def_inversion_pairs"),
        " の ",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        " のうち、2 つの成分が相異なる軌道に属するものの全体を",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}^{\ne}(\varphi):=\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; O(\tau)\ne O(\tau')\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。有限集合の部分集合なので有限集合であり、",
        math(String.raw`|\mathrm{Inv}^{\ne}(\varphi)|\in\mathbb{N}`),
        " である。",
      ]),
      paragraph([
        "記号について 1 つ断っておく。上付きの ",
        math(String.raw`\ne`),
        " は冪でも像でもなく、「2 つの成分の軌道が相異なる」という条件で絞ったことを表す。",
        ref("def_cross_orbit_inversions"),
        " の ",
        math(String.raw`J_\varphi(O,O')`),
        " が 2 つの軌道を指定して数えたものであるのに対し、",
        math(String.raw`\mathrm{Inv}^{\ne}(\varphi)`),
        " は軌道の対を指定せず、またぐ対をすべて集めたものである。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_inner_inversion_pairs",
    kind: "claim",
    title: { text: "1 つの軌道の中の転倒対の個数は、制限の転倒数である" },
    labels: ["claim_orbit_inner_inversion_pairs"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.innerInversionPairs_eq_filter",
      "Ising2DLambda.AlgebraicEigenvalue.card_innerInversionPairs",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.inner_eq_filter_crossPairs",
      "Ising2DLambda.AlgebraicEigenvalue.card_innerInversionPairs_from_necSuf",
    ],
    verification: ["sagemath/check/inversion-orbit-decomposition"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）と任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}=\bigl\{\,(\tau,\tau')\in F(O,O) \;\bigm|\; \bigl(\varphi\!\restriction_{O}\bigr)(\tau')\prec\bigl(\varphi\!\restriction_{O}\bigr)(\tau)\,\bigr\}`,
      ),
      paragraph([
        "であり、したがって両辺の元の個数を取って",
      ]),
      displayMath(
        String.raw`\bigl|\,\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}\,\bigr|=\mathrm{inv}_{O}\bigl(\varphi\!\restriction_{O}\bigr)`,
      ),
      paragraph([
        "である（",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        " は ",
        ref("def_inversion_pairs"),
        "、",
        math(String.raw`F(O,O)`),
        " は ",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "、",
        math(String.raw`\mathrm{inv}_{O}`),
        " は ",
        ref("def_orbit_inversion_count"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "示すのは集合の等号であり、個数の等号はそこから従う。",
        "個数だけを一致させる 1 対 1 対応を作るのではなく、両辺が同じ集合であることを言う。",
      ]),
      paragraph([
        "はじめに、",
        ref("def_orbit_restriction"),
        " より、任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\bigl(\varphi\!\restriction_{O}\bigr)(\tau)=\varphi(\tau)`),
        " である。制限は値を変えず、定義域と終域だけを ",
        math(String.raw`O`),
        " へ取り替えた写像だからである。",
      ]),
      paragraph([
        "そのうえで、条件を書き下して比べる。",
      ]),
      displayMath(String.raw`\begin{aligned}
&\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}\\
&=\bigl\{\,(\tau,\tau')\in P_L \;\bigm|\; \varphi(\tau')\prec\varphi(\tau)\ \text{かつ}\ \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}
&&(\because\ \blkref{def_inversion_pairs})\\
&=\bigl\{\,(\tau,\tau')\in R_L\times R_L \;\bigm|\; \tau\prec\tau'\ \text{かつ}\ \varphi(\tau')\prec\varphi(\tau)\ \text{かつ}\ \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}
&&(\because\ \blkref{def_inversion_count})\\
&=\bigl\{\,(\tau,\tau')\in O\times O \;\bigm|\; \tau\prec\tau'\ \text{かつ}\ \varphi(\tau')\prec\varphi(\tau)\,\bigr\}
&&(\because\ O\subset R_L)\\
&=\bigl\{\,(\tau,\tau')\in F(O,O) \;\bigm|\; \varphi(\tau')\prec\varphi(\tau)\,\bigr\}
&&(\because\ \blkref{def_cross_orbit_ordered_pairs})\\
&=\bigl\{\,(\tau,\tau')\in F(O,O) \;\bigm|\; \bigl(\varphi\!\restriction_{O}\bigr)(\tau')\prec\bigl(\varphi\!\restriction_{O}\bigr)(\tau)\,\bigr\}
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第 3 の等号だけ補っておく。",
        math(String.raw`O\subset R_L`),
        " なので、「",
        math(String.raw`(\tau,\tau')\in R_L\times R_L`),
        " かつ ",
        math(String.raw`\tau\in O`),
        " かつ ",
        math(String.raw`\tau'\in O`),
        "」と「",
        math(String.raw`(\tau,\tau')\in O\times O`),
        "」は同じ条件である。",
      ]),
      paragraph([
        "最後に両辺の元の個数を取り、右辺の個数が ",
        ref("def_orbit_inversion_count"),
        " により ",
        math(String.raw`\mathrm{inv}_{O}(\varphi\!\restriction_{O})`),
        " であることを使えば、主張の第 2 の等式が出る。",
      ]),
      paragraph([
        ref("def_inversion_pairs"),
        "、",
        ref("def_inversion_count"),
        "、",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        ref("def_orbit_restriction"),
        "、",
        ref("def_orbit_inversion_count"),
        " を引いた。",
      ]),
      paragraph([
        math(String.raw`\varphi`),
        " が軌道を保つことは、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " が定まるためだけに要る。",
        "集合の等号そのものは ",
        math(String.raw`\varphi`),
        " が軌道を保たなくても成り立つ。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_inversion_count_orbit_decomposition",
    kind: "claim",
    title: { text: "転倒数は、軌道ごとの転倒数の和と、またぐ転倒対の個数の和である" },
    labels: ["claim_inversion_count_orbit_decomposition"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.inversionCount_orbit_decomposition",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.inversion_count_decomposition",
      "Ising2DLambda.AlgebraicEigenvalue.inversionCount_orbit_decomposition_from_necSuf",
    ],
    verification: ["sagemath/check/inversion-orbit-decomposition"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{inv}(\varphi)=\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}\bigl(\varphi\!\restriction_{O}\bigr)+\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{inv}`),
        " は ",
        ref("def_inversion_count"),
        "、",
        math(String.raw`\mathrm{inv}_{O}`),
        " は ",
        ref("def_orbit_inversion_count"),
        "、",
        math(String.raw`\mathrm{Inv}^{\ne}(\varphi)`),
        " は ",
        ref("def_cross_orbit_inversion_pairs"),
        "、",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。右辺の和は有限集合 ",
        math(String.raw`\mathcal{O}_L`),
        " にわたる自然数の有限和である。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う記号を先に置く。各 ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`A(O):=\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; \tau\in O\ \text{かつ}\ \tau'\in O\,\bigr\}`,
      ),
      paragraph([
        "と置き、さらに",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}^{=}(\varphi):=\bigl\{\,(\tau,\tau')\in\mathrm{Inv}(\varphi) \;\bigm|\; O(\tau)=O(\tau')\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`\mathrm{Inv}^{=}(\varphi)`),
        " はこの証明の中だけで使う記号であり、",
        ref("def_cross_orbit_inversion_pairs"),
        " の ",
        math(String.raw`\mathrm{Inv}^{\ne}(\varphi)`),
        " とは条件が逆である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        " が 2 つに分かれること。任意の ",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}(\varphi)`),
        " について ",
        math(String.raw`O(\tau)=O(\tau')`),
        " と ",
        math(String.raw`O(\tau)\ne O(\tau')`),
        " のちょうど一方が成り立つので、",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}(\varphi)=\mathrm{Inv}^{=}(\varphi)\cup\mathrm{Inv}^{\ne}(\varphi),\qquad \mathrm{Inv}^{=}(\varphi)\cap\mathrm{Inv}^{\ne}(\varphi)=\emptyset`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathrm{Inv}^{=}(\varphi)`),
        " が軌道ごとの ",
        math(String.raw`A(O)`),
        " へ分かれること。2 つの包含を別々に見る。",
      ]),
      paragraph([
        math(String.raw`\subset`),
        " について。",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}^{=}(\varphi)`),
        " を取り、",
        math(String.raw`O:=O(\tau)`),
        " と置く。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O\in\mathcal{O}_L`),
        " である。",
        ref("claim_row_config_orbit_partition"),
        " の合併が ",
        math(String.raw`R_L`),
        " であることから ",
        math(String.raw`\tau`),
        " を含む軌道があり、",
        ref("claim_row_config_orbit_mem_eq"),
        " よりそれは ",
        math(String.raw`O(\tau)`),
        " に等しいので ",
        math(String.raw`\tau\in O`),
        " である。同じ理由で ",
        math(String.raw`\tau'\in O(\tau')=O`),
        " である。したがって ",
        math(String.raw`(\tau,\tau')\in A(O)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\supset`),
        " について。",
        math(String.raw`O\in\mathcal{O}_L`),
        " と ",
        math(String.raw`(\tau,\tau')\in A(O)`),
        " を取る。",
        math(String.raw`\tau\in O`),
        " かつ ",
        math(String.raw`\tau'\in O`),
        " なので、",
        ref("claim_row_config_orbit_mem_eq"),
        " を 2 度当てて ",
        math(String.raw`O(\tau)=O=O(\tau')`),
        " である。したがって ",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}^{=}(\varphi)`),
        " である。",
      ]),
      paragraph([
        "さらに、相異なる ",
        math(String.raw`O_1,O_2\in\mathcal{O}_L`),
        " について ",
        math(String.raw`A(O_1)\cap A(O_2)=\emptyset`),
        " である。共通の元 ",
        math(String.raw`(\tau,\tau')`),
        " があれば ",
        math(String.raw`\tau\in O_1\cap O_2`),
        " となり、",
        ref("claim_row_config_orbit_partition"),
        " の「相異なる 2 元は互いに素」に反するからである。",
      ]),
      paragraph([
        "Step 3: 個数を数える。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{inv}(\varphi)
&=\bigl|\mathrm{Inv}(\varphi)\bigr|
&&(\because\ \blkref{def_inversion_pairs})\\
&=\bigl|\mathrm{Inv}^{=}(\varphi)\bigr|+\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|
&&(\because\ \text{Step 1 の分割})\\
&=\sum_{O\in\mathcal{O}_L}\bigl|A(O)\bigr|+\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|
&&(\because\ \text{Step 2 の分割})\\
&=\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}\bigl(\varphi\!\restriction_{O}\bigr)+\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|
&&(\because\ \blkref{claim_orbit_inner_inversion_pairs})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        ref("def_inversion_pairs"),
        "、",
        ref("def_cross_orbit_inversion_pairs"),
        "、",
        ref("def_orbit_inversion_count"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("def_row_config_orbit_set"),
        "、",
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("claim_row_config_orbit_partition"),
        "、",
        ref("claim_orbit_inner_inversion_pairs"),
        " を引いた。",
      ]),
      paragraph([
        "この主張はまだ符号について何も言っていない。",
        math(String.raw`|\mathrm{Inv}^{\ne}(\varphi)|`),
        " が偶数であることを次のセクションで示し、そこで符号が軌道ごとの符号の積になることを得る。",
        ref("claim_cross_orbit_inversions_even"),
        " が与えているのは軌道の対を 1 つ指定したときの偶数性であり、",
        "またぐ対の全体についての偶数性はそれを軌道の対にわたって足し合わせて得る。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_config_min_unique",
    kind: "claim",
    title: { text: "行配位の空でない部分集合は最小元をちょうど 1 つ持つ" },
    labels: ["claim_row_config_min_unique"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.existsUnique_rowConfigMin",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.existsUnique_min",
      "Ising2DLambda.AlgebraicEigenvalue.existsUnique_rowConfigMin_from_necSuf",
    ],
    verification: ["sagemath/check/row-config-min"],
    statement: [
      paragraph([
        "空でない部分集合 ",
        math(String.raw`X\subset R_L`),
        " を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\tau_0\in X\quad\text{かつ}\quad\text{任意の}\ \tau\in X\ \text{について}\ \bigl(\tau=\tau_0\ \text{または}\ \tau_0\prec\tau\bigr)`,
      ),
      paragraph([
        "を満たす ",
        math(String.raw`\tau_0\in R_L`),
        " がちょうど 1 つ存在する（",
        math(String.raw`\prec`),
        " は ",
        ref("def_row_config_order"),
        "）。この条件を満たす元を ",
        math(String.raw`X`),
        " の最小元と呼ぶ。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "存在と一意性を別々に示す。",
      ]),
      paragraph([
        "存在について。",
        math(String.raw`X`),
        " の元の個数 ",
        math(String.raw`|X|\in\mathbb{N}`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`|X|=1`),
        " の場合。",
        math(String.raw`X=\{\tau_1\}`),
        " と書くと、任意の ",
        math(String.raw`\tau\in X`),
        " は ",
        math(String.raw`\tau=\tau_1`),
        " なので、",
        math(String.raw`\tau_1`),
        " が条件を満たす。",
      ]),
      paragraph([
        math(String.raw`|X|=n+1`),
        "（",
        math(String.raw`n\ge1`),
        "）の場合。元の個数が ",
        math(String.raw`n`),
        " である空でない部分集合については条件を満たす元が存在すると仮定する。",
        math(String.raw`X`),
        " から元 ",
        math(String.raw`\tau_1`),
        " を 1 つ取り、",
        math(String.raw`Y:=X\setminus\{\tau_1\}`),
        " と置く。",
        math(String.raw`|Y|=n\ge1`),
        " なので ",
        math(String.raw`Y`),
        " は空でなく、帰納法の仮定より ",
        math(String.raw`Y`),
        " の最小元 ",
        math(String.raw`\tau_2`),
        " が取れる。",
        math(String.raw`\tau_2\in Y`),
        " かつ ",
        math(String.raw`\tau_1\notin Y`),
        " なので ",
        math(String.raw`\tau_1\ne\tau_2`),
        " であり、",
        ref("claim_row_config_order_linear"),
        " の三分律より ",
        math(String.raw`\tau_1\prec\tau_2`),
        " と ",
        math(String.raw`\tau_2\prec\tau_1`),
        " のちょうど一方が成り立つ。",
      ]),
      paragraph([
        math(String.raw`\tau_1\prec\tau_2`),
        " の場合。",
        math(String.raw`\tau_1`),
        " が ",
        math(String.raw`X`),
        " の最小元である。任意の ",
        math(String.raw`\tau\in X`),
        " について、",
        math(String.raw`\tau=\tau_1`),
        " ならそのままである。",
        math(String.raw`\tau\ne\tau_1`),
        " なら ",
        math(String.raw`\tau\in Y`),
        " であり、",
        math(String.raw`\tau_2`),
        " が ",
        math(String.raw`Y`),
        " の最小元であることから ",
        math(String.raw`\tau=\tau_2`),
        " または ",
        math(String.raw`\tau_2\prec\tau`),
        " である。前者なら ",
        math(String.raw`\tau_1\prec\tau_2=\tau`),
        " であり、後者なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau_1&\prec\tau_2&&(\because\ \text{いまの場合分け})\\
&\prec\tau&&(\because\ \tau_2\ \text{が}\ Y\ \text{の最小元であること})
\end{aligned}`),
      paragraph([
        "と ",
        ref("claim_row_config_order_linear"),
        " の推移律から ",
        math(String.raw`\tau_1\prec\tau`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\tau_2\prec\tau_1`),
        " の場合。",
        math(String.raw`\tau_2`),
        " が ",
        math(String.raw`X`),
        " の最小元である。任意の ",
        math(String.raw`\tau\in X`),
        " について、",
        math(String.raw`\tau=\tau_1`),
        " なら ",
        math(String.raw`\tau_2\prec\tau_1=\tau`),
        " である。",
        math(String.raw`\tau\ne\tau_1`),
        " なら ",
        math(String.raw`\tau\in Y`),
        " であり、",
        math(String.raw`\tau_2`),
        " が ",
        math(String.raw`Y`),
        " の最小元であることから ",
        math(String.raw`\tau=\tau_2`),
        " または ",
        math(String.raw`\tau_2\prec\tau`),
        " である。",
      ]),
      paragraph([
        "一意性について。",
        math(String.raw`\tau_0`),
        " と ",
        math(String.raw`\tau_0'`),
        " がともに条件を満たすとする。",
        math(String.raw`\tau_0'\in X`),
        " なので ",
        math(String.raw`\tau_0'=\tau_0`),
        " または ",
        math(String.raw`\tau_0\prec\tau_0'`),
        " であり、",
        math(String.raw`\tau_0\in X`),
        " なので ",
        math(String.raw`\tau_0=\tau_0'`),
        " または ",
        math(String.raw`\tau_0'\prec\tau_0`),
        " である。",
        math(String.raw`\tau_0\ne\tau_0'`),
        " と仮定すると ",
        math(String.raw`\tau_0\prec\tau_0'`),
        " かつ ",
        math(String.raw`\tau_0'\prec\tau_0`),
        " となり、",
        ref("claim_row_config_order_linear"),
        " の三分律が「ちょうど 1 つ」を言っていることに反する。",
        "ゆえに ",
        math(String.raw`\tau_0=\tau_0'`),
        " である。",
      ]),
      paragraph([
        ref("def_row_config_order"),
        "、",
        ref("claim_row_config_order_linear"),
        " を引いた。",
      ]),
      paragraph([
        "この証明は三分律と推移律の両方を使う。",
        "前のいくつかの主張が三分律だけで通っていたのと違い、最小元の存在は推移律なしでは出ない",
        "（元を 1 つ足したときに、新しい元が古い最小元より小さいことから、",
        "他のすべての元より小さいことを出す段で使う）。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の順序と個数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_row_config_min",
    kind: "definition",
    title: { text: "行配位の空でない部分集合の最小元" },
    labels: ["def_row_config_min"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.rowConfigMin"],
    verification: ["sagemath/check/row-config-min"],
    statement: [
      paragraph([
        "空でない部分集合 ",
        math(String.raw`X\subset R_L`),
        " に対し、",
        ref("claim_row_config_min_unique"),
        " が与えるただ 1 つの最小元を",
      ]),
      displayMath(String.raw`\mu(X)\in R_L`),
      paragraph([
        "と書く。定義から",
      ]),
      displayMath(
        String.raw`\mu(X)\in X\quad\text{かつ}\quad\text{任意の}\ \tau\in X\ \text{について}\ \bigl(\tau=\mu(X)\ \text{または}\ \mu(X)\prec\tau\bigr)`,
      ),
      paragraph([
        "である。",
      ]),
      paragraph([
        "記号について 2 つ断っておく。第一に、",
        math(String.raw`\mu(X)`),
        " は ",
        math(String.raw`R_L`),
        " の元であって部分集合ではない（引数は集合、値は元である）。第二に、",
        math(String.raw`X`),
        " が空のときは ",
        ref("claim_row_config_min_unique"),
        " が使えず ",
        math(String.raw`\mu(X)`),
        " は定まらないので、空でない部分集合にのみ書く。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_min_ne",
    kind: "claim",
    title: { text: "相異なる軌道の最小元は相異なる" },
    labels: ["claim_orbit_min_ne"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_orbit_ne",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.ne_of_mem_of_mem_of_disjoint",
      "Ising2DLambda.AlgebraicEigenvalue.rowConfigMin_orbit_ne_from_necSuf",
    ],
    verification: ["sagemath/check/row-config-min"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`O,O'\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）について、",
        math(String.raw`O\ne O'`),
        " ならば ",
        math(String.raw`\mu(O)\ne\mu(O')`),
        " である（",
        math(String.raw`\mu`),
        " は ",
        ref("def_row_config_min"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_row_config_orbit_partition"),
        " より ",
        math(String.raw`\mathcal{O}_L`),
        " のどの元も空でないので、",
        ref("def_row_config_min"),
        " により ",
        math(String.raw`\mu(O)`),
        " と ",
        math(String.raw`\mu(O')`),
        " が定まり、",
        math(String.raw`\mu(O)\in O`),
        " かつ ",
        math(String.raw`\mu(O')\in O'`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\mu(O)=\mu(O')`),
        " と仮定すると、この行配位は ",
        math(String.raw`O`),
        " にも ",
        math(String.raw`O'`),
        " にも属するので ",
        math(String.raw`O\cap O'\ne\emptyset`),
        " となり、",
        ref("claim_row_config_orbit_partition"),
        " の「相異なる 2 元は互いに素」に反する。ゆえに ",
        math(String.raw`\mu(O)\ne\mu(O')`),
        " である。",
      ]),
      paragraph([
        ref("def_row_config_min"),
        "、",
        ref("def_row_config_orbit_set"),
        "、",
        ref("claim_row_config_orbit_partition"),
        " を引いた。",
      ]),
      paragraph([
        "この主張は、軌道の相異なる 2 つ組に向きを与えるために使う。",
        ref("claim_cross_orbit_inversions_even"),
        " が与える偶数性は軌道の対を 1 つ指定したときのものであり、",
        ref("claim_inversion_count_orbit_decomposition"),
        " の ",
        math(String.raw`|\mathrm{Inv}^{\ne}(\varphi)|`),
        " を数えるには、",
        math(String.raw`(O,O')`),
        " と ",
        math(String.raw`(O',O)`),
        " を 2 度数えないように順序対の全体を半分に分ける必要がある。",
        math(String.raw`\mu`),
        " が相異なる軌道に相異なる行配位を与えるので、",
        math(String.raw`\mu(O)\prec\mu(O')`),
        " かどうかでその分割ができる。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_oriented_orbit_pairs",
    kind: "definition",
    title: { text: "最小元で向きを付けた軌道の順序対の全体" },
    labels: ["def_oriented_orbit_pairs"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orientedOrbitPairs"],
    verification: ["sagemath/check/oriented-orbit-pairs"],
    statement: [
      paragraph([
        "軌道の順序対のうち、第 1 成分の最小元が第 2 成分の最小元より小さいものの全体を",
      ]),
      displayMath(
        String.raw`\mathcal{D}_L:=\bigl\{\,(O,O')\in\mathcal{O}_L\times\mathcal{O}_L \;\bigm|\; \mu(O)\prec\mu(O')\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`\mu`),
        " は ",
        ref("def_row_config_min"),
        "、",
        math(String.raw`\prec`),
        " は ",
        ref("def_row_config_order"),
        "）。",
        ref("claim_row_config_orbit_partition"),
        " より ",
        math(String.raw`\mathcal{O}_L`),
        " のどの元も空でないので、どの ",
        math(String.raw`O\in\mathcal{O}_L`),
        " についても ",
        math(String.raw`\mu(O)`),
        " が定まる。",
        math(String.raw`\mathcal{O}_L`),
        " が有限集合なので ",
        math(String.raw`\mathcal{D}_L`),
        " も有限集合である。",
      ]),
      paragraph([
        math(String.raw`\mathcal{D}_L`),
        " の元は第 1 成分と第 2 成分が相異なる。",
        math(String.raw`(O,O)\in\mathcal{D}_L`),
        " とすると ",
        math(String.raw`\mu(O)\prec\mu(O)`),
        " となるが、",
        ref("claim_row_config_order_linear"),
        " の三分律は ",
        math(String.raw`\mu(O)=\mu(O)`),
        " の場合に ",
        math(String.raw`\mu(O)\prec\mu(O)`),
        " が成り立たないことを言っているので、これは起こらない。",
      ]),
      paragraph([
        "記号について 1 つ断っておく。",
        math(String.raw`\mathcal{D}_L`),
        " の元は軌道の順序対であって行配位の対ではない（",
        ref("def_inversion_count"),
        " の ",
        math(String.raw`P_L`),
        " とは別の集合である）。",
        math(String.raw`\mathcal{D}_L`),
        " の添字 ",
        math(String.raw`L`),
        " は格子の一辺であり、成分を表す添字ではない。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_oriented_orbit_pairs_cross_disjoint",
    kind: "claim",
    title: { text: "向きを付けた相異なる軌道の対が与えるまたがる転倒対は交わらない" },
    labels: ["claim_oriented_orbit_pairs_cross_disjoint"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.crossInversions_disjoint",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.crossInv_disjoint",
      "Ising2DLambda.AlgebraicEigenvalue.crossInversions_disjoint_from_necSuf",
    ],
    verification: ["sagemath/check/oriented-orbit-pairs"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）と、",
        math(String.raw`(O_1,O_1')\ne(O_2,O_2')`),
        " を満たす任意の ",
        math(String.raw`(O_1,O_1'),(O_2,O_2')\in\mathcal{D}_L`),
        "（",
        ref("def_oriented_orbit_pairs"),
        "）について",
      ]),
      displayMath(
        String.raw`J_\varphi(O_1,O_1')\cap J_\varphi(O_2,O_2')=\emptyset`,
      ),
      paragraph([
        "である（",
        math(String.raw`J_\varphi`),
        " は ",
        ref("def_cross_orbit_inversions"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`(\tau,\tau')\in J_\varphi(O_1,O_1')\cap J_\varphi(O_2,O_2')`),
        " が存在すると仮定して矛盾を導く。",
      ]),
      paragraph([
        ref("def_cross_orbit_inversions"),
        " より、",
        math(String.raw`\tau\in O_1`),
        " かつ ",
        math(String.raw`\tau'\in O_1'`),
        " であるか、",
        math(String.raw`\tau\in O_1'`),
        " かつ ",
        math(String.raw`\tau'\in O_1`),
        " である。",
        ref("claim_row_config_orbit_mem_eq"),
        " により、前者なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(O(\tau),O(\tau')\bigr)&=(O_1,O_1')&&(\because\ \blkref{claim_row_config_orbit_mem_eq})
\end{aligned}`),
      paragraph([
        "であり、後者なら",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(O(\tau),O(\tau')\bigr)&=(O_1',O_1)&&(\because\ \blkref{claim_row_config_orbit_mem_eq})
\end{aligned}`),
      paragraph([
        "である（",
        math(String.raw`O(\tau)`),
        " は ",
        ref("def_row_config_orbit"),
        "）。同じことが ",
        math(String.raw`(O_2,O_2')`),
        " についても言えるので、",
        math(String.raw`(O_2,O_2')=(O_1,O_1')`),
        " または ",
        math(String.raw`(O_2,O_2')=(O_1',O_1)`),
        " である。",
      ]),
      paragraph([
        "後者は起こらない。",
        math(String.raw`(O_2,O_2')=(O_1',O_1)`),
        " とすると、",
        math(String.raw`(O_1,O_1')\in\mathcal{D}_L`),
        " から ",
        math(String.raw`\mu(O_1)\prec\mu(O_1')`),
        " が、",
        math(String.raw`(O_2,O_2')\in\mathcal{D}_L`),
        " から ",
        math(String.raw`\mu(O_1')\prec\mu(O_1)`),
        " が出るが、",
        ref("claim_row_config_order_linear"),
        " の三分律はこの 2 つが同時に成り立たないことを言っている。",
      ]),
      paragraph([
        "ゆえに ",
        math(String.raw`(O_2,O_2')=(O_1,O_1')`),
        " であり、仮定 ",
        math(String.raw`(O_1,O_1')\ne(O_2,O_2')`),
        " に反する。したがって共通部分は空である。",
      ]),
      paragraph([
        ref("def_cross_orbit_inversions"),
        "、",
        ref("def_oriented_orbit_pairs"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("claim_row_config_order_linear"),
        " を引いた。",
      ]),
      paragraph([
        "この証明が ",
        math(String.raw`\mathcal{D}_L`),
        " から取り出しているのは、",
        math(String.raw`(O,O')`),
        " と ",
        math(String.raw`(O',O)`),
        " が同時には属さないことだけである。",
        "最小元そのものは使っておらず、順序 ",
        math(String.raw`\prec`),
        " についても非対称性しか使っていない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_cross_orbit_inversion_pairs_union",
    kind: "claim",
    title: { text: "またぐ転倒対の全体は、向きを付けた軌道の対にわたる合併である" },
    labels: ["claim_cross_orbit_inversion_pairs_union"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs_eq_biUnion",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.crossInv_eq_biUnion",
      "Ising2DLambda.AlgebraicEigenvalue.crossOrbitInversionPairs_eq_biUnion_from_necSuf",
    ],
    verification: ["sagemath/check/oriented-orbit-pairs"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}^{\ne}(\varphi)=\bigcup_{(O,O')\in\mathcal{D}_L}J_\varphi(O,O')`,
      ),
      paragraph([
        "である（",
        math(String.raw`\mathrm{Inv}^{\ne}(\varphi)`),
        " は ",
        ref("def_cross_orbit_inversion_pairs"),
        "、",
        math(String.raw`\mathcal{D}_L`),
        " は ",
        ref("def_oriented_orbit_pairs"),
        "、",
        math(String.raw`J_\varphi`),
        " は ",
        ref("def_cross_orbit_inversions"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "両包含を別々に示す。",
      ]),
      paragraph([
        "左辺が右辺に含まれること。",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}^{\ne}(\varphi)`),
        " を任意に取ると、",
        ref("def_cross_orbit_inversion_pairs"),
        " より ",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}(\varphi)`),
        " かつ ",
        math(String.raw`O(\tau)\ne O(\tau')`),
        " である。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O(\tau),O(\tau')\in\mathcal{O}_L`),
        " であり、",
        ref("claim_orbit_min_ne"),
        " より ",
        math(String.raw`\mu(O(\tau))\ne\mu(O(\tau'))`),
        " なので、",
        ref("claim_row_config_order_linear"),
        " の三分律より ",
        math(String.raw`\mu(O(\tau))\prec\mu(O(\tau'))`),
        " と ",
        math(String.raw`\mu(O(\tau'))\prec\mu(O(\tau))`),
        " のちょうど一方が成り立つ。",
      ]),
      paragraph([
        math(String.raw`\mu(O(\tau))\prec\mu(O(\tau'))`),
        " の場合。",
        ref("def_oriented_orbit_pairs"),
        " より ",
        math(String.raw`(O(\tau),O(\tau'))\in\mathcal{D}_L`),
        " である。",
        math(String.raw`\tau\in O(\tau)`),
        " かつ ",
        math(String.raw`\tau'\in O(\tau')`),
        "（",
        ref("def_row_config_orbit"),
        " より）であり、",
        ref("def_inversion_pairs"),
        " より ",
        math(String.raw`(\tau,\tau')\in P_L`),
        " かつ ",
        math(String.raw`\varphi(\tau')\prec\varphi(\tau)`),
        " なので、",
        ref("def_cross_orbit_inversions"),
        " より ",
        math(String.raw`(\tau,\tau')\in J_\varphi(O(\tau),O(\tau'))`),
        " である。",
      ]),
      paragraph([
        math(String.raw`\mu(O(\tau'))\prec\mu(O(\tau))`),
        " の場合。同じく ",
        math(String.raw`(O(\tau'),O(\tau))\in\mathcal{D}_L`),
        " であり、",
        ref("def_cross_orbit_inversions"),
        " の条件の第 2 の側（",
        math(String.raw`\tau\in O'`),
        " かつ ",
        math(String.raw`\tau'\in O`),
        " の側）により ",
        math(String.raw`(\tau,\tau')\in J_\varphi(O(\tau'),O(\tau))`),
        " である。",
      ]),
      paragraph([
        "右辺が左辺に含まれること。",
        math(String.raw`(O,O')\in\mathcal{D}_L`),
        " と ",
        math(String.raw`(\tau,\tau')\in J_\varphi(O,O')`),
        " を任意に取る。",
        ref("def_cross_orbit_inversions"),
        " より ",
        math(String.raw`(\tau,\tau')\in P_L`),
        " かつ ",
        math(String.raw`\varphi(\tau')\prec\varphi(\tau)`),
        " なので、",
        ref("def_inversion_pairs"),
        " より ",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}(\varphi)`),
        " である。",
      ]),
      paragraph([
        "残るのは ",
        math(String.raw`O(\tau)\ne O(\tau')`),
        " である。",
        ref("def_cross_orbit_inversions"),
        " の条件は 2 つの場合に分かれる。",
        math(String.raw`\tau\in O`),
        " かつ ",
        math(String.raw`\tau'\in O'`),
        " の場合は、",
        ref("claim_row_config_orbit_mem_eq"),
        " より ",
        math(String.raw`O(\tau)=O`),
        " かつ ",
        math(String.raw`O(\tau')=O'`),
        " である。",
        math(String.raw`\tau\in O'`),
        " かつ ",
        math(String.raw`\tau'\in O`),
        " の場合は、同じく ",
        math(String.raw`O(\tau)=O'`),
        " かつ ",
        math(String.raw`O(\tau')=O`),
        " である。",
        ref("def_oriented_orbit_pairs"),
        " より ",
        math(String.raw`O\ne O'`),
        " なので、どちらの場合も ",
        math(String.raw`O(\tau)\ne O(\tau')`),
        " である。ゆえに ",
        ref("def_cross_orbit_inversion_pairs"),
        " より ",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}^{\ne}(\varphi)`),
        " である。",
      ]),
      paragraph([
        ref("def_cross_orbit_inversion_pairs"),
        "、",
        ref("def_cross_orbit_inversions"),
        "、",
        ref("def_inversion_pairs"),
        "、",
        ref("def_oriented_orbit_pairs"),
        "、",
        ref("def_row_config_orbit"),
        "、",
        ref("def_row_config_orbit_set"),
        "、",
        ref("claim_row_config_orbit_mem_eq"),
        "、",
        ref("claim_row_config_orbit_partition"),
        "、",
        ref("claim_orbit_min_ne"),
        "、",
        ref("claim_row_config_order_linear"),
        " を引いた。",
      ]),
      paragraph([
        "この証明は ",
        math(String.raw`\varphi`),
        " が軌道を保つことを使っていない。",
        "両辺とも ",
        math(String.raw`\varphi`),
        " を「値を比べる相手」としてしか使っておらず、像が軌道に収まることは要らないからである。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_cross_orbit_inversion_pairs_even",
    kind: "claim",
    title: { text: "またぐ転倒対の全体の個数は偶数である" },
    labels: ["claim_cross_orbit_inversion_pairs_even"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.card_crossOrbitInversionPairs_eq_two_mul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.card_biUnion_eq_two_mul",
      "Ising2DLambda.AlgebraicEigenvalue.card_crossOrbitInversionPairs_eq_two_mul_from_necSuf",
    ],
    verification: ["sagemath/check/oriented-orbit-pairs"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|=2\cdot\sum_{(O,O')\in\mathcal{D}_L}\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|`,
      ),
      paragraph([
        "である。とくに ",
        math(String.raw`|\mathrm{Inv}^{\ne}(\varphi)|`),
        " は偶数である（",
        math(String.raw`F(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        math(String.raw`F_\varphi(O,O')`),
        " は ",
        ref("def_cross_orbit_ordered_pairs_image"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "求めたい個数から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|
&=\Bigl|\bigcup_{(O,O')\in\mathcal{D}_L}J_\varphi(O,O')\Bigr|
&&(\because\ \blkref{claim_cross_orbit_inversion_pairs_union})\\
&=\sum_{(O,O')\in\mathcal{D}_L}\bigl|J_\varphi(O,O')\bigr|
&&(\because\ \blkref{claim_oriented_orbit_pairs_cross_disjoint})\\
&=\sum_{(O,O')\in\mathcal{D}_L}2\cdot\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|
&&(\because\ \blkref{claim_cross_orbit_inversions_even})\\
&=2\cdot\sum_{(O,O')\in\mathcal{D}_L}\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|
&&(\because\ \text{有限和の分配則})
\end{aligned}`),
      paragraph([
        "第 2 の等号は、互いに素な有限集合の族の合併の個数が個数の和であることによる。",
        "族が互いに素であることが ",
        ref("claim_oriented_orbit_pairs_cross_disjoint"),
        " である。",
      ]),
      paragraph([
        "第 3 の等号で ",
        ref("claim_cross_orbit_inversions_even"),
        " を当てるには ",
        math(String.raw`O\ne O'`),
        " が要る。これは ",
        ref("def_oriented_orbit_pairs"),
        " が ",
        math(String.raw`\mathcal{D}_L`),
        " の元について与えている。",
      ]),
      paragraph([
        ref("def_oriented_orbit_pairs"),
        "、",
        ref("def_cross_orbit_ordered_pairs"),
        "、",
        ref("def_cross_orbit_ordered_pairs_image"),
        "、",
        ref("claim_cross_orbit_inversion_pairs_union"),
        "、",
        ref("claim_oriented_orbit_pairs_cross_disjoint"),
        "、",
        ref("claim_cross_orbit_inversions_even"),
        " を引いた。",
      ]),
      paragraph([
        "これで ",
        ref("claim_inversion_count_orbit_decomposition"),
        " の第 2 項が偶数であることが言えた。",
        "符号 ",
        math(String.raw`\mathrm{sgn}(\varphi)=(-1)^{\mathrm{inv}(\varphi)}`),
        " を軌道ごとの符号の積へ分解するとき、この項は ",
        math(String.raw`(-1)`),
        " の冪に効かない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_permutation_sign",
    kind: "definition",
    title: { text: "軌道の上の全単射の符号" },
    labels: ["def_orbit_permutation_sign"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitPermSign"],
    verification: ["sagemath/check/orbit-permutation-sign"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射 ",
        math(String.raw`\psi`),
        " を任意に取る。",
        ref("def_orbit_inversion_count"),
        " の転倒数 ",
        math(String.raw`\mathrm{inv}_{O}(\psi)\in\mathbb{N}`),
        " を用いて、",
        math(String.raw`\psi`),
        " の符号を",
      ]),
      displayMath(
        String.raw`\mathrm{sgn}_{O}(\psi):=(-1)^{\mathrm{inv}_{O}(\psi)}\in\mathbb{Z}`,
      ),
      paragraph([
        "で定める。右辺は整数 ",
        math(String.raw`-1`),
        " の自然数冪であり、",
        math(String.raw`\mathbb{Z}`),
        " の中の計算である。",
      ]),
      paragraph([
        "これは ",
        ref("def_permutation_sign"),
        " の符号を、転倒数を ",
        math(String.raw`\mathrm{inv}`),
        " から ",
        math(String.raw`\mathrm{inv}_{O}`),
        " へ取り替えて写したものである。",
        "台が違うので同じ記号では書けず、下付きに ",
        math(String.raw`O`),
        " を付けて区別する。この下付きの ",
        math(String.raw`O`),
        " は台に取った集合を指す添え名であって、成分の添字ではない。",
      ]),
      paragraph([
        math(String.raw`\mathrm{sgn}_{O}(\psi)`),
        " の引数 ",
        math(String.raw`\psi`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射であって、",
        math(String.raw`R_L`),
        " の上の置換ではない。すなわち ",
        math(String.raw`\mathrm{sgn}_{O}`),
        " と ",
        math(String.raw`\mathrm{sgn}`),
        " は定義域が違う別の写像である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と順序と数え上げ、および整数の積だけであり、",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_permutation_sign_orbit_product",
    kind: "claim",
    title: { text: "軌道を保つ置換の符号は、軌道ごとの符号の積である" },
    labels: ["claim_permutation_sign_orbit_product"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.permSign_eq_prod_orbitPermSign",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_eq_prod_pow_of_even_remainder",
      "Ising2DLambda.AlgebraicEigenvalue.permSign_eq_prod_orbitPermSign_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-permutation-sign"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）について",
      ]),
      displayMath(
        String.raw`\mathrm{sgn}(\varphi)=\prod_{O\in\mathcal{O}_L}\mathrm{sgn}_{O}\bigl(\varphi\!\restriction_{O}\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{sgn}`),
        " は ",
        ref("def_permutation_sign"),
        "、",
        math(String.raw`\mathrm{sgn}_{O}`),
        " は ",
        ref("def_orbit_permutation_sign"),
        "、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "）。右辺は有限集合 ",
        math(String.raw`\mathcal{O}_L`),
        " にわたる整数の有限積である。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中で使う記号を先に置く。",
        ref("claim_cross_orbit_inversion_pairs_even"),
        " により",
      ]),
      displayMath(
        String.raw`k:=\sum_{(O,O')\in\mathcal{D}_L}\bigl|F(O,O')\setminus F_\varphi(O,O')\bigr|\in\mathbb{N}`,
      ),
      paragraph([
        "と置くと ",
        math(String.raw`\bigl|\mathrm{Inv}^{\ne}(\varphi)\bigr|=2k`),
        " である。",
      ]),
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}(\varphi)
&=(-1)^{\mathrm{inv}(\varphi)}
&&(\because\ \blkref{def_permutation_sign})\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})+\lvert\mathrm{Inv}^{\ne}(\varphi)\rvert}
&&(\because\ \blkref{claim_inversion_count_orbit_decomposition})\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}\cdot(-1)^{\lvert\mathrm{Inv}^{\ne}(\varphi)\rvert}
&&(\because\ \text{整数の冪の指数法則}\ a^{m+n}=a^{m}a^{n})\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}\cdot(-1)^{2k}
&&(\because\ \text{準備で置いた}\ \lvert\mathrm{Inv}^{\ne}(\varphi)\rvert=2k)\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}\cdot\bigl((-1)^{2}\bigr)^{k}
&&(\because\ \text{整数の冪の指数法則}\ a^{mn}=(a^{m})^{n})\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}\cdot 1^{k}
&&(\because\ (-1)^{2}=1)\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}\cdot 1
&&(\because\ 1^{k}=1)\\
&=(-1)^{\sum_{O\in\mathcal{O}_L}\mathrm{inv}_{O}(\varphi\restriction_{O})}
&&(\because\ 1\ \text{は整数の積の単位元である})\\
&=\prod_{O\in\mathcal{O}_L}(-1)^{\mathrm{inv}_{O}(\varphi\restriction_{O})}
&&(\because\ \text{有限和を指数とする冪は冪の有限積である})\\
&=\prod_{O\in\mathcal{O}_L}\mathrm{sgn}_{O}\bigl(\varphi\!\restriction_{O}\bigr)
&&(\because\ \blkref{def_orbit_permutation_sign})
\end{aligned}`),
      paragraph([
        "第 9 の等号で使った「有限和を指数とする冪は冪の有限積である」は、",
        math(String.raw`\mathcal{O}_L`),
        " の元の個数についての帰納法で ",
        math(String.raw`a^{m+n}=a^{m}a^{n}`),
        " から出る（空の和は ",
        math(String.raw`0`),
        "、空の積は ",
        math(String.raw`1`),
        " であり、",
        math(String.raw`a^{0}=1`),
        " が出発点である）。",
      ]),
      paragraph([
        ref("def_permutation_sign"),
        "、",
        ref("def_orbit_permutation_sign"),
        "、",
        ref("def_orbit_restriction"),
        "、",
        ref("def_cross_orbit_inversion_pairs"),
        "、",
        ref("claim_inversion_count_orbit_decomposition"),
        "、",
        ref("claim_cross_orbit_inversion_pairs_even"),
        " を引いた。",
      ]),
      paragraph([
        "この証明が ",
        math(String.raw`-1`),
        " について使っているのは ",
        math(String.raw`(-1)^{2}=1`),
        " だけである。",
        math(String.raw`-1`),
        " が ",
        math(String.raw`+1`),
        " と異なることも、",
        math(String.raw`\mathbb{Z}`),
        " に引き算があることも使っていない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と順序と数え上げ、および整数の積だけであり、",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_const_embedding_prod",
    kind: "claim",
    title: { text: "整数を係数へ送る写像は、有限積を有限積へ写す" },
    labels: ["claim_const_embedding_prod"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.constSecond_constPoly_prod",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.map_prod_of_mul",
      "Ising2DLambda.AlgebraicEigenvalue.constSecond_constPoly_prod_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-term-factorization"],
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`s`),
        " と、その各元 ",
        math(String.raw`i\in s`),
        " へ整数 ",
        math(String.raw`n_i\in\mathbb{Z}`),
        " を与える写像を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\iota\Bigl(\kappa\bigl(\textstyle\prod_{i\in s}n_i\bigr)\Bigr)=\prod_{i\in s}\iota\bigl(\kappa(n_i)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "）。左辺の積は ",
        math(String.raw`\mathbb{Z}`),
        " の中の有限積、右辺の積は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の有限積であり、住む集合が違う。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s`),
        " の元の個数についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`s`),
        " が空のとき、左辺は ",
        math(String.raw`\iota(\kappa(1))`),
        "、右辺は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元であり、",
        ref("def_second_constant_embedding"),
        " により両者は等しい（空の積は単位元である）。",
      ]),
      paragraph([
        math(String.raw`s`),
        " について主張が成り立つとし、",
        math(String.raw`s`),
        " に属さない元 ",
        math(String.raw`a`),
        " を 1 つ足した ",
        math(String.raw`s\cup\{a\}`),
        " を考える。",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota\Bigl(\kappa\bigl(\textstyle\prod_{i\in s\cup\{a\}}n_i\bigr)\Bigr)
&=\iota\Bigl(\kappa\bigl(n_a\cdot\textstyle\prod_{i\in s}n_i\bigr)\Bigr)
&&(\because\ \text{有限積から因子を}\ 1\ \text{つ括り出す})\\
&=\iota\Bigl(\kappa(n_a)\cdot\kappa\bigl(\textstyle\prod_{i\in s}n_i\bigr)\Bigr)
&&(\because\ \blkref{def_constant_polynomial}\ \text{の}\ \kappa\ \text{は積を保つ})\\
&=\iota\bigl(\kappa(n_a)\bigr)\cdot\iota\Bigl(\kappa\bigl(\textstyle\prod_{i\in s}n_i\bigr)\Bigr)
&&(\because\ \blkref{def_second_constant_embedding}\ \text{の}\ \iota\ \text{は積を保つ})\\
&=\iota\bigl(\kappa(n_a)\bigr)\cdot\prod_{i\in s}\iota\bigl(\kappa(n_i)\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=\prod_{i\in s\cup\{a\}}\iota\bigl(\kappa(n_i)\bigr)
&&(\because\ \text{有限積へ因子を}\ 1\ \text{つ戻す})
\end{aligned}`),
      paragraph([
        ref("def_constant_polynomial"),
        "、",
        ref("def_second_constant_embedding"),
        " を引いた。",
      ]),
      paragraph([
        "この証明が ",
        math(String.raw`\kappa`),
        " と ",
        math(String.raw`\iota`),
        " について使っているのは、単位元を単位元へ送ることと積を保つことだけである。",
        "和を保つことは使っていない（この証明に和が一度も現れない）。",
      ]),
      paragraph([
        "現れるのは有限集合と整数の積、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_prod_orbit_decomposition",
    kind: "claim",
    title: { text: "行配位の全体にわたる有限積は、軌道ごとの有限積の積である" },
    labels: ["claim_prod_orbit_decomposition"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.prod_eq_prod_orbit",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_eq_prod_of_partition",
      "Ising2DLambda.AlgebraicEigenvalue.prod_eq_prod_orbit_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-term-factorization"],
    statement: [
      paragraph([
        "各行配位 ",
        math(String.raw`\tau\in R_L`),
        " へ ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`f(\tau)`),
        " を与える写像 ",
        math(String.raw`f`),
        " を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\prod_{\tau\in R_L}f(\tau)=\prod_{O\in\mathcal{O}_L}\ \prod_{\tau\in O}f(\tau)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。両辺とも ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の有限積である。",
      ]),
    ],
    proof: [
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\tau\in R_L}f(\tau)
&=\prod_{\tau\in\bigcup_{O\in\mathcal{O}_L}O}f(\tau)
&&(\because\ \blkref{claim_row_config_orbit_partition}\ \text{の合併が}\ R_L\ \text{であること})\\
&=\prod_{O\in\mathcal{O}_L}\ \prod_{\tau\in O}f(\tau)
&&(\because\ \text{互いに素な族の合併にわたる有限積は、族の元ごとの有限積の積である})
\end{aligned}`),
      paragraph([
        ref("claim_row_config_orbit_partition"),
        " を引いた。",
      ]),
      paragraph([
        "第 2 の等号で使った「互いに素な族の合併にわたる有限積は、族の元ごとの有限積の積である」は、",
        math(String.raw`\mathcal{O}_L`),
        " の元の個数についての帰納法で、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積の結合則と可換性から出る（互いに素であることは、同じ因子を 2 度掛けないために要る）。",
        "使っているのは分割の 3 条件のうち合併と互いに素であることの 2 つだけで、",
        "どの元も空でないことは使っていない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_term_factor",
    kind: "definition",
    title: { text: "軌道の因子" },
    labels: ["def_orbit_term_factor"],
    habitat: "Z",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitFactor"],
    verification: ["sagemath/check/orbit-term-factorization"],
    statement: [
      paragraph([
        "行列 ",
        math(String.raw`B\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x][t]\bigr)`),
        "（",
        ref("def_second_matrix"),
        "）、軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）、および ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射 ",
        math(String.raw`\psi`),
        " を任意に取る。",
        math(String.raw`B`),
        " が定める ",
        math(String.raw`O`),
        " の因子を",
      ]),
      displayMath(
        String.raw`W_{O}(B,\psi):=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\psi))\bigr)\cdot\prod_{\tau\in O}B_{\tau,\psi(\tau)}\in\mathbb{Z}[x][t]`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`\mathrm{sgn}_{O}`),
        " は ",
        ref("def_orbit_permutation_sign"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "）。",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\psi(\tau)\in O\subset R_L`),
        " なので、成分 ",
        math(String.raw`B_{\tau,\psi(\tau)}`),
        " は定まっている。",
      ]),
      paragraph([
        "右辺の積は有限個の因子からなり、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積は可換かつ結合的なので、因子を並べる順序によらない。",
        "整数である符号を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元として使う経路は ",
        ref("def_second_determinant"),
        " と同じく ",
        math(String.raw`\iota\circ\kappa`),
        " だけである。",
      ]),
      paragraph([
        math(String.raw`W_{O}`),
        " の下付きの ",
        math(String.raw`O`),
        " は台に取った軌道を指す添え名であって、成分の添字ではない。",
        "第 1 引数に行列を書くのは、この因子が ",
        math(String.raw`B`),
        " ごとに違う元だからである。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と順序と数え上げ、整数の積、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_term_factorization",
    kind: "claim",
    title: { text: "軌道を保つ置換が与える項は、軌道ごとの因子の積である" },
    labels: ["claim_orbit_term_factorization"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.term_eq_prod_orbitFactor",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_prod_eq_prod_mul_of_decomp",
      "Ising2DLambda.AlgebraicEigenvalue.term_eq_prod_orbitFactor_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-term-factorization"],
    statement: [
      paragraph([
        "任意の行列 ",
        math(String.raw`B\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x][t]\bigr)`),
        "（",
        ref("def_second_matrix"),
        "）と任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）について",
      ]),
      displayMath(
        String.raw`\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}=\prod_{O\in\mathcal{O}_L}W_{O}\bigl(B,\varphi\!\restriction_{O}\bigr)`,
      ),
      paragraph([
        "が成り立つ（左辺は ",
        ref("def_second_determinant"),
        " の和の ",
        math(String.raw`\varphi`),
        " の項、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}
&=\iota\Bigl(\kappa\bigl(\textstyle\prod_{O\in\mathcal{O}_L}\mathrm{sgn}_{O}(\varphi\restriction_{O})\bigr)\Bigr)\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}
&&(\because\ \blkref{claim_permutation_sign_orbit_product})\\
&=\Bigl(\prod_{O\in\mathcal{O}_L}\iota\bigl(\kappa(\mathrm{sgn}_{O}(\varphi\restriction_{O}))\bigr)\Bigr)\cdot\prod_{\tau\in R_L}B_{\tau,\varphi(\tau)}
&&(\because\ \blkref{claim_const_embedding_prod})\\
&=\Bigl(\prod_{O\in\mathcal{O}_L}\iota\bigl(\kappa(\mathrm{sgn}_{O}(\varphi\restriction_{O}))\bigr)\Bigr)\cdot\prod_{O\in\mathcal{O}_L}\ \prod_{\tau\in O}B_{\tau,\varphi(\tau)}
&&(\because\ \blkref{claim_prod_orbit_decomposition})\\
&=\prod_{O\in\mathcal{O}_L}\Bigl(\iota\bigl(\kappa(\mathrm{sgn}_{O}(\varphi\restriction_{O}))\bigr)\cdot\prod_{\tau\in O}B_{\tau,\varphi(\tau)}\Bigr)
&&(\because\ \text{2 つの有限積の積は、成分ごとの積の有限積である})\\
&=\prod_{O\in\mathcal{O}_L}\Bigl(\iota\bigl(\kappa(\mathrm{sgn}_{O}(\varphi\restriction_{O}))\bigr)\cdot\prod_{\tau\in O}B_{\tau,(\varphi\restriction_{O})(\tau)}\Bigr)
&&(\because\ \blkref{def_orbit_restriction}\ \text{の}\ (\varphi\!\restriction_{O})(\tau)=\varphi(\tau))\\
&=\prod_{O\in\mathcal{O}_L}W_{O}\bigl(B,\varphi\!\restriction_{O}\bigr)
&&(\because\ \blkref{def_orbit_term_factor})
\end{aligned}`),
      paragraph([
        ref("def_permutation_sign"),
        "、",
        ref("def_orbit_permutation_sign"),
        "、",
        ref("def_orbit_restriction"),
        "、",
        ref("def_orbit_term_factor"),
        "、",
        ref("claim_permutation_sign_orbit_product"),
        "、",
        ref("claim_const_embedding_prod"),
        "、",
        ref("claim_prod_orbit_decomposition"),
        " を引いた。",
      ]),
      paragraph([
        "第 4 の等号で使った「2 つの有限積の積は、成分ごとの積の有限積である」は、",
        math(String.raw`\mathcal{O}_L`),
        " の元の個数についての帰納法で、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積の結合則と可換性から出る。",
      ]),
      paragraph([
        "この証明が使っているのは、符号の積表示と積の軌道ごとの分解という 2 つの分解、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積が可換かつ結合的であることだけである。",
        "順序 ",
        math(String.raw`\prec`),
        " も軌道の作り方もここには現れない（どちらも 2 つの分解を作る側にある）。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と数え上げ、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_non_orbit_preserving_term_zero",
    kind: "claim",
    title: { text: "軌道を保たない置換の項は零元である" },
    labels: ["claim_non_orbit_preserving_term_zero"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_zero_of_not_of_forall_or",
      "Ising2DLambda.AlgebraicEigenvalue.charTerm_shiftMatrix_eq_zero_of_not_orbitPreserving_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-sum"],
    statement: [
      paragraph([
        "置換 ",
        math(String.raw`\varphi\in\mathfrak{S}_L`),
        "（",
        ref("def_permutation_sign"),
        "）が ",
        math(String.raw`\varphi\notin\mathfrak{S}^{\mathcal{O}}_L`),
        "（",
        ref("def_orbit_preserving_permutation"),
        "）を満たすとする。このとき ",
        ref("def_second_determinant"),
        " の和における ",
        math(String.raw`\varphi`),
        " の項について",
      ]),
      displayMath(
        String.raw`\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}=\iota\bigl(\kappa(0)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "）。すなわちこの項は零元である。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_fixed_or_shift_preserves_orbit"),
        " の対偶により、仮定 ",
        math(String.raw`\varphi\notin\mathfrak{S}^{\mathcal{O}}_L`),
        " から「任意の ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`\varphi(\tau)=\tau`),
        " または ",
        math(String.raw`\varphi(\tau)=S(\tau)`),
        "」は成り立たない。すなわち ",
        math(String.raw`\varphi(\tau_1)=\tau_1`),
        " でも ",
        math(String.raw`\varphi(\tau_1)=S(\tau_1)`),
        " でもない ",
        math(String.raw`\tau_1\in R_L`),
        " が存在する。この ",
        math(String.raw`\tau_1`),
        " について求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&=\iota\bigl(\kappa(0)\bigr)
&&(\because\ \varphi(\tau_1)\ne\tau_1\ \text{かつ}\ \varphi(\tau_1)\ne S(\tau_1)\ \text{と}\ \blkref{claim_shift_char_term_zero})
\end{aligned}`),
      paragraph([
        ref("claim_fixed_or_shift_preserves_orbit"),
        "、",
        ref("claim_shift_char_term_zero"),
        " を引いた。",
      ]),
      paragraph([
        "この証明が使っているのは、2 つの主張を対偶でつなぐことだけである。",
        "行列が ",
        math(String.raw`\mathrm{ch}(U)`),
        " であることも、軌道の作り方も、ここには現れない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_sum_orbit_preserving",
    kind: "claim",
    title: {
      text: "シフト行列の特性多項式は、軌道を保つ置換にわたる軌道ごとの因子の積の和である",
    },
    labels: ["claim_shift_char_sum_orbit_preserving"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_orbitFactor",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_sum_subset_congr",
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_orbitFactor_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-sum"],
    statement: [
      paragraph([
        ref("def_shift_matrix"),
        " のシフト行列 ",
        math(String.raw`U`),
        " の特性多項式 ",
        math(String.raw`\chi_U`),
        "（",
        ref("def_characteristic_polynomial"),
        "）について",
      ]),
      displayMath(
        String.raw`\chi_U=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\varphi\!\restriction_{O}\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "、",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        "）。",
        "和の添字が ",
        math(String.raw`\mathfrak{S}_L`),
        " から ",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " へ狭まっている。",
      ]),
    ],
    proof: [
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_U
&=\mathrm{det}_{t}\bigl(\mathrm{ch}(U)\bigr)
&&(\because\ \blkref{def_characteristic_polynomial})\\
&=\sum_{\varphi\in\mathfrak{S}_L}\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&&(\because\ \blkref{def_second_determinant})\\
&=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\iota\bigl(\kappa(\mathrm{sgn}(\varphi))\bigr)\cdot\prod_{\tau\in R_L}\mathrm{ch}(U)_{\tau,\varphi(\tau)}
&&(\because\ \mathfrak{S}^{\mathcal{O}}_L\subset\mathfrak{S}_L\ \text{と}\ \blkref{claim_non_orbit_preserving_term_zero})\\
&=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\varphi\!\restriction_{O}\bigr)
&&(\because\ \blkref{claim_orbit_term_factorization})
\end{aligned}`),
      paragraph([
        ref("def_characteristic_polynomial"),
        "、",
        ref("def_second_determinant"),
        "、",
        ref("def_orbit_preserving_permutation"),
        "、",
        ref("claim_non_orbit_preserving_term_zero"),
        "、",
        ref("claim_orbit_term_factorization"),
        " を引いた。",
      ]),
      paragraph([
        "第 3 の等号で落とした項は ",
        math(String.raw`\mathfrak{S}_L\setminus\mathfrak{S}^{\mathcal{O}}_L`),
        " の元が与えるものであり、",
        ref("claim_non_orbit_preserving_term_zero"),
        " によりいずれも零元である。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の有限和から零元である項を落としても値は変わらない。",
      ]),
      paragraph([
        "第 4 の等号は ",
        ref("claim_orbit_term_factorization"),
        " を和の各項へ当てたものである。",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " であることは、この主張を当てるために要る（第 3 の等号で和を狭めたのはそのためでもある）。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の有限和と有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "main_text_remark_planned_chapters",
    kind: "remark",
    title: { text: "この先に書くこと" },
    labels: ["remark_planned_chapters"],
    habitat: "none",
    statement: [
      paragraph([
        "本文はここまでである。以下には 2 種類が混ざっている。",
        "既に書いた章の残り（「続き」と書いたもの）と、まだ手つかずの章である。",
        "読む順序と各章が扱う量の住処は README の「章立ての予定」の表が正本であり、",
        "実行の順序は docs/tasks/auto-loop-state.md のセクション表が正本である。",
        "ここに項目を足したら、必ずセクション表にも行を足すこと（足さないと実行の列に並ばず、落ちる）。",
      ]),
      list([
        [
          todo("残り"),
          "「有限系の自由エントロピー」の続き: 一般の ",
          math(String.raw`q`),
          " での ",
          math(String.raw`\Phi_L(q)`),
          " の性質（双対な点どうしの関係など）。加法性・冪の法則と ",
          math(String.raw`\Phi_L(1)=L^2\ell_2`),
          " までは上で済んでいる。",
        ],
        [
          todo("残り"),
          "「固有値の代数性」の続き: 特性多項式の根が ",
          math(String.raw`\overline{\mathbb{Q}}`),
          " に属すること（固有値の代数性）と、円分体上での対角化。",
          "特性多項式の定義（",
          ref("def_characteristic_polynomial"),
          "）とそれがモニックな ",
          math(String.raw`2^{L}`),
          " 次の元であること（",
          ref("claim_characteristic_polynomial_monic"),
          "）、",
          "添字集合の線形順序（",
          ref("claim_row_config_order_linear"),
          "）、置換の符号（",
          ref("claim_permutation_sign_mul"),
          "）、行列式の定義（",
          ref("def_determinant"),
          "）、次数を数えるのに使う 2 つの主張（",
          ref("claim_permutation_moves_two"),
          "、",
          ref("claim_determinant_diagonal"),
          "）、および ",
          ref("def_second_polynomial_ring"),
          " の次数とモニック性の 4 主張（",
          ref("claim_second_degree_sum"),
          "、",
          ref("claim_second_degree_prod"),
          "、",
          ref("claim_second_monic_prod"),
          "、",
          ref("claim_second_monic_add_lower"),
          "）、",
          "行配位の巡回シフトで転送行列の成分が変わらないこと（",
          ref("claim_transfer_matrix_shift_invariant"),
          "）、シフト行列が転送行列と可換であること（",
          ref("theorem_shift_matrix_commutes"),
          "）、その ",
          math(String.raw`L`),
          " 乗が単位行列であること（",
          ref("theorem_shift_matrix_order"),
          "）、および行配位の最小周期が ",
          math(String.raw`L`),
          " を割り切ること（",
          ref("claim_row_config_minimal_period_divides_L"),
          "）、および軌道の元の個数が最小周期に等しいこと（",
          ref("claim_row_config_orbit_card"),
          "）、行配位の全体が軌道たちへ分割されること（",
          ref("claim_row_config_orbit_partition"),
          "）、シフト行列の特性多項式の和で零元でない項を持ちうるのが軌道を保つ置換だけであること（",
          ref("claim_shift_char_term_zero"),
          "）、軌道を保つ置換の軌道への制限が全単射であること（",
          ref("claim_orbit_restriction_bijective"),
          "）、軌道ごとの置換の組の貼り合わせ（",
          ref("claim_orbit_gluing_bijective"),
          "）、2 つの相異なる軌道にまたがる転倒対の個数が偶数であること（",
          ref("claim_cross_orbit_inversions_even"),
          "）、転倒数が軌道ごとの転倒数の和とまたぐ転倒対の個数の和に分かれること（",
          ref("claim_inversion_count_orbit_decomposition"),
          "）、および行配位の空でない部分集合の最小元（",
          ref("claim_row_config_min_unique"),
          "、",
          ref("claim_orbit_min_ne"),
          "）までは上で済んでいる。",
        ],
        [
          todo("未着手"),
          "「Fisher 零点」: 零点が ",
          math(String.raw`\overline{\mathbb{Q}}`),
          " に属することと Kramers–Wannier 双対から、自己双対点 ",
          math(String.raw`x_c=\sqrt2-1`),
          " を出す。",
        ],
        [
          todo("未着手"),
          "「零点の詰め寄り」: 相転移を ",
          math(String.raw`\mathbb{Q}`),
          " 上の量化言明として書く。",
        ],
        [
          todo("未着手"),
          "「熱力学極限」: 自由エネルギー密度と零点密度を扱う。ここが実数体への脱出である。",
        ],
        [
          todo("未着手"),
          "「臨界指数を零点列で書く」: 先頭零点の列 ",
          math(String.raw`\{x_1(L)\}_L\subset\overline{\mathbb{Q}}`),
          " と有限サイズスケーリングを対応させる。",
        ],
      ]),
      paragraph([
        "各章を書くときは、",
        ref("def_partition_polynomial"),
        " の分配多項式を出発点に据え、",
        math(String.raw`x`),
        " への代入を伴う操作をすべて実数体への脱出として宣言すること。",
      ]),
    ],
  },
]);
