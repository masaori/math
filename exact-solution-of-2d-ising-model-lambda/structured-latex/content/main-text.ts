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
    id: "partition_polynomial_definition_cardinality_notation",
    kind: "definition",
    title: { text: "有限集合の元の個数の記法" },
    labels: ["def_cardinality_notation"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`X`),
        " に対し ",
        math(String.raw`|X|`),
        " でその元の個数（",
        math(String.raw`\mathbb{N}`),
        " の元）を表す。この記法をこれ以外の意味（絶対値・ノルム）では使わない。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_residue_maps",
    kind: "definition",
    title: { text: "整数と剰余類を行き来する 2 つの写像" },
    labels: ["def_residue_maps"],
    habitat: "Z",
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`L\ge1`),
        " を固定する。",
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
    ],
  },

  {
    id: "partition_polynomial_definition_residue_addition_notation",
    kind: "definition",
    title: { text: "剰余類の加法の記法" },
    labels: ["def_residue_addition_notation"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の加法を ",
        math(String.raw`+_{\mathbb{Z}/L\mathbb{Z}}`),
        " と書き、",
        math(String.raw`\mathbb{Z}`),
        " の加法 ",
        math(String.raw`+`),
        " と区別する。また ",
        math(String.raw`\bar1:=\pi(1)\in\mathbb{Z}/L\mathbb{Z}`),
        " と置く（",
        math(String.raw`\pi`),
        " は ",
        ref("def_residue_maps"),
        "）。",
        math(String.raw`\bar1`),
        " と ",
        math(String.raw`1`),
        " は別の対象であり、書き分ける。",
      ]),
    ],
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
    ],
    statement: [
      paragraph([
        "格子とは、頂点集合",
      ]),
      displayMath(String.raw`V_L:=(\mathbb{Z}/L\mathbb{Z})\times(\mathbb{Z}/L\mathbb{Z})`),
      paragraph([
        "と、横向きの辺の番号の集合・縦向きの辺の番号の集合",
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
        "と、端点写像 ",
        math(String.raw`\partial_0,\partial_1:E_L\to V_L`),
        "（",
        ref("def_boundary_maps"),
        "）の 5 つ組 ",
        math(String.raw`(V_L,E_{L,\mathrm{h}},E_{L,\mathrm{v}},\partial_0,\partial_1)`),
        " のことである。",
      ]),
      paragraph([
        math(String.raw`V_L`),
        " の元を ",
        math(String.raw`(i,j)`),
        " と書き、第 1 成分 ",
        math(String.raw`i`),
        " を行番号、第 2 成分 ",
        math(String.raw`j`),
        " を列番号と呼ぶ。すなわち行番号が等しい頂点どうしが同じ行に属する。この呼び方は以下で固定し、",
        "第 1 成分を列番号と読むことはしない。",
      ]),
      paragraph([
        math(String.raw`E_{L,\mathrm{h}}`),
        " と ",
        math(String.raw`E_{L,\mathrm{v}}`),
        " は番号の範囲が重ならないので互いに素であり、どの ",
        math(String.raw`e\in E_L`),
        " もちょうど一方に属する。",
        "横向きと縦向きを最初から別の集合にしておくのは、後の章で破れボンド数を",
        "「同じ行の中の破れ」と「隣り合う行の間の破れ」に分けるとき、この分割をそのまま使うためである。",
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
        " である（連続する整数の個数。記法は ",
        ref("def_cardinality_notation"),
        "）。両者は互いに素なので ",
        math(String.raw`|E_L|=L^2+L^2=2L^2`),
        " となる。",
      ]),
      paragraph([
        "辺そのものを頂点の 2 元集合 ",
        math(String.raw`\{u,w\}`),
        " として定義しないのは、",
        math(String.raw`L\le2`),
        " のとき異なる辺が同じ 2 元集合になってしまうからである（",
        math(String.raw`L=1`),
        " では両端が一致して 1 元集合になり、",
        math(String.raw`L=2`),
        " では横向きの 2 本が同じ 2 点を結ぶ）。2 元集合の集合として数えると本数が ",
        math(String.raw`2L^2`),
        " からずれ、以下の主張が小さい ",
        math(String.raw`L`),
        " で成り立たなくなる。番号を付けておけば、同じ 2 点を結ぶ辺が複数あっても別の辺として数えられる。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_edge_numbering",
    kind: "definition",
    title: { text: "頂点から辺の番号を与える写像" },
    labels: ["def_edge_numbering"],
    habitat: "Z",
    statement: [
      paragraph([
        "頂点 ",
        math(String.raw`(i,j)\in V_L`),
        "（",
        ref("def_lattice"),
        "）に対し、番号を与える写像 ",
        math(String.raw`n_{\mathrm{h}},n_{\mathrm{v}}:V_L\to\mathbb{Z}`),
        " を",
      ]),
      displayMath(
        String.raw`n_{\mathrm{h}}(i,j):=L\cdot s(i)+s(j)+1,\qquad
n_{\mathrm{v}}(i,j):=L^2+L\cdot s(i)+s(j)+1`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`s`),
        " は ",
        ref("def_residue_maps"),
        "。右辺は ",
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
    ],
  },

  {
    id: "partition_polynomial_definition_boundary_maps",
    kind: "definition",
    title: { text: "端点写像" },
    labels: ["def_boundary_maps"],
    habitat: "N",
    lean: [
      "Ising2DLambda.PartitionPolynomial.boundary0",
      "Ising2DLambda.PartitionPolynomial.boundary1",
    ],
    statement: [
      paragraph([
        "端点写像 ",
        math(String.raw`\partial_0,\partial_1:E_L\to V_L`),
        " は、",
        ref("def_edge_numbering"),
        " の全単射の逆向きに定める。",
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
        "と定める（加法の記法は ",
        ref("def_residue_addition_notation"),
        "）。行番号・列番号を進める操作が ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中の加法であることが、周期境界条件そのものである。",
        math(String.raw`\bar1`),
        " を足すのであって ",
        math(String.raw`1`),
        " を足すのではない。",
      ]),
      paragraph([
        "この定め方により、横向きの辺は両端の行番号が等しく（同じ行の中）、",
        "縦向きの辺は両端の列番号が等しく行番号だけが ",
        math(String.raw`\bar1`),
        " 異なる（隣り合う行の間）。",
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
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.OrbitPermFamily",
      "Ising2DLambda.AlgebraicEigenvalue.OrbitFamily",
      "Ising2DLambda.AlgebraicEigenvalue.OrbitFamilyBijective",
    ],
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
    id: "algebraic_eigenvalue_definition_orbit_restriction_family",
    kind: "definition",
    title: { text: "軌道を保つ置換が定める、軌道ごとの置換の組" },
    labels: ["def_orbit_restriction_family"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.restrictionFamily"],
    verification: ["sagemath/check/shift-char-family-sum"],
    statement: [
      paragraph([
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " を任意に取る（",
        ref("def_orbit_preserving_permutation"),
        "）。軌道の全体 ",
        math(String.raw`\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）の各元 ",
        math(String.raw`O`),
        " へ ",
        math(String.raw`\varphi`),
        " の ",
        math(String.raw`O`),
        " への制限（",
        ref("def_orbit_restriction"),
        "）を対応させる対応を",
      ]),
      displayMath(
        String.raw`\mathrm{res}(\varphi)\;:\;\mathcal{O}_L\longrightarrow\bigcup_{O\in\mathcal{O}_L}\{\,\text{写像}\ O\to O\,\},\qquad \bigl(\mathrm{res}(\varphi)\bigr)(O):=\varphi\!\restriction_{O}`,
      ),
      paragraph([
        "と書き、",
        math(String.raw`\varphi`),
        " が定める軌道ごとの置換の組と呼ぶ。",
      ]),
      paragraph([
        math(String.raw`\mathrm{res}(\varphi)\in\mathfrak{A}_L`),
        "（",
        ref("def_orbit_permutation_family"),
        "）であることは、定めるだけでは言えず示す必要がある。",
        ref("claim_orbit_restriction_bijective"),
        " より、任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について ",
        math(String.raw`\varphi\!\restriction_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である。したがって ",
        math(String.raw`\mathrm{res}(\varphi)`),
        " は ",
        math(String.raw`\mathcal{O}_L`),
        " の各元 ",
        math(String.raw`O`),
        " へ ",
        math(String.raw`O`),
        " の上の全単射を 1 つずつ対応させており、",
        math(String.raw`\mathfrak{A}_L`),
        " の元である。",
      ]),
      paragraph([
        "記号について 2 つ断っておく。第一に、",
        math(String.raw`\mathrm{res}(\varphi)`),
        " は 1 つの写像ではなく写像の組であり、その ",
        math(String.raw`O`),
        " における値 ",
        math(String.raw`\bigl(\mathrm{res}(\varphi)\bigr)(O)`),
        " が写像である。第二に、",
        math(String.raw`\mathrm{res}`),
        " の定義域は ",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " であって ",
        math(String.raw`\mathfrak{S}_L`),
        " ではない（",
        math(String.raw`\varphi\!\restriction_{O}`),
        " が ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像として定まるのは ",
        math(String.raw`\varphi`),
        " が軌道を保つ場合だけである）。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_gluing_restriction_family",
    kind: "claim",
    title: { text: "制限の組を貼り合わせるともとの置換に戻る" },
    labels: ["claim_gluing_restriction_family"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.glue_restrictionFamily"],
    verification: ["sagemath/check/shift-char-family-sum"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\varphi\in\mathfrak{S}^{\mathcal{O}}_L`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{gl}\bigl(\mathrm{res}(\varphi)\bigr)=\varphi`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{res}`),
        " は ",
        ref("def_orbit_restriction_family"),
        "、",
        math(String.raw`\mathrm{gl}`),
        " は ",
        ref("def_orbit_gluing"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_orbit_gluing_orbit_preserving"),
        " より ",
        math(String.raw`\mathrm{gl}\bigl(\mathrm{res}(\varphi)\bigr)\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である。",
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{gl}\bigl(\mathrm{res}(\varphi)\bigr)\!\restriction_{O}
&=\bigl(\mathrm{res}(\varphi)\bigr)(O)
&&(\because\ \blkref{claim_orbit_gluing_restriction})\\
&=\varphi\!\restriction_{O}
&&(\because\ \blkref{def_orbit_restriction_family})
\end{aligned}`),
      paragraph([
        math(String.raw`O`),
        " は任意だったので、",
        math(String.raw`\mathrm{gl}\bigl(\mathrm{res}(\varphi)\bigr)`),
        " と ",
        math(String.raw`\varphi`),
        " は各軌道への制限が一致する。",
        ref("claim_orbit_restriction_determines"),
        " より ",
        math(String.raw`\mathrm{gl}\bigl(\mathrm{res}(\varphi)\bigr)=\varphi`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_restriction_family_gluing",
    kind: "claim",
    title: { text: "貼り合わせの制限の組はもとの組に戻る" },
    labels: ["claim_restriction_family_gluing"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.restrictionFamily_glue"],
    verification: ["sagemath/check/shift-char-family-sum"],
    statement: [
      paragraph([
        "任意の ",
        math(String.raw`\alpha\in\mathfrak{A}_L`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{res}\bigl(\mathrm{gl}(\alpha)\bigr)=\alpha`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{A}_L`),
        " は ",
        ref("def_orbit_permutation_family"),
        "、",
        math(String.raw`\mathrm{gl}`),
        " は ",
        ref("def_orbit_gluing"),
        "、",
        math(String.raw`\mathrm{res}`),
        " は ",
        ref("def_orbit_restriction_family"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_orbit_gluing_orbit_preserving"),
        " より ",
        math(String.raw`\mathrm{gl}(\alpha)\in\mathfrak{S}^{\mathcal{O}}_L`),
        " なので ",
        math(String.raw`\mathrm{res}\bigl(\mathrm{gl}(\alpha)\bigr)`),
        " が定まる。",
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{res}\bigl(\mathrm{gl}(\alpha)\bigr)\bigr)(O)
&=\mathrm{gl}(\alpha)\!\restriction_{O}
&&(\because\ \blkref{def_orbit_restriction_family})\\
&=\alpha(O)
&&(\because\ \blkref{claim_orbit_gluing_restriction})
\end{aligned}`),
      paragraph([
        math(String.raw`O`),
        " は任意だったので、2 つの組は ",
        math(String.raw`\mathcal{O}_L`),
        " のどの元でも同じ値を取る。したがって ",
        math(String.raw`\mathrm{res}\bigl(\mathrm{gl}(\alpha)\bigr)=\alpha`),
        " である。",
      ]),
      paragraph([
        "前の主張（",
        ref("claim_gluing_restriction_family"),
        "）と合わせて、",
        math(String.raw`\mathrm{res}`),
        " と ",
        math(String.raw`\mathrm{gl}`),
        " は互いに逆な写像であり、",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " と ",
        math(String.raw`\mathfrak{A}_L`),
        " は 1 対 1 に対応する。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_sum_family",
    kind: "claim",
    title: {
      text: "シフト行列の特性多項式は、軌道ごとの置換の組にわたる和である",
    },
    labels: ["claim_shift_char_sum_family"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_family",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_sum_of_inverse",
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_sum_family_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-family-sum"],
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
        String.raw`\chi_U=\sum_{\alpha\in\mathfrak{A}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\alpha(O)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{A}_L`),
        " は ",
        ref("def_orbit_permutation_family"),
        "、",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "）。前の主張との違いは和の添字だけであり、",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " から ",
        math(String.raw`\mathfrak{A}_L`),
        " へ取り替えてある。",
      ]),
    ],
    proof: [
      paragraph([
        "和が定まることを先に見る。",
        ref("claim_gluing_restriction_family"),
        " と ",
        ref("claim_restriction_family_gluing"),
        " より ",
        math(String.raw`\mathrm{res}`),
        " と ",
        math(String.raw`\mathrm{gl}`),
        " は互いに逆な写像であり、",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は有限集合 ",
        math(String.raw`\mathfrak{S}_L`),
        " の部分集合なので、",
        math(String.raw`\mathfrak{A}_L`),
        " も有限集合である。したがって右辺の和は有限個の項の和である。",
      ]),
      paragraph([
        "求めたい値から始める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_U
&=\sum_{\varphi\in\mathfrak{S}^{\mathcal{O}}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\varphi\!\restriction_{O}\bigr)
&&(\because\ \blkref{claim_shift_char_sum_orbit_preserving})\\
&=\sum_{\alpha\in\mathfrak{A}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\mathrm{gl}(\alpha)\!\restriction_{O}\bigr)
&&(\because\ \blkref{claim_gluing_restriction_family}\ \text{と}\ \blkref{claim_restriction_family_gluing})\\
&=\sum_{\alpha\in\mathfrak{A}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\alpha(O)\bigr)
&&(\because\ \blkref{claim_orbit_gluing_restriction})
\end{aligned}`),
      paragraph([
        "第 2 の等号は和の添字の取り替えである。",
        math(String.raw`\mathrm{res}:\mathfrak{S}^{\mathcal{O}}_L\to\mathfrak{A}_L`),
        " と ",
        math(String.raw`\mathrm{gl}:\mathfrak{A}_L\to\mathfrak{S}^{\mathcal{O}}_L`),
        " が互いに逆なので、",
        math(String.raw`\varphi`),
        " にわたる有限和は ",
        math(String.raw`\alpha=\mathrm{res}(\varphi)`),
        " にわたる有限和と同じ項を同じ回数ずつ足し合わせている。",
        math(String.raw`\varphi=\mathrm{gl}(\alpha)`),
        " を代入したのが右辺である。",
      ]),
      paragraph([
        "第 3 の等号は、",
        math(String.raw`\mathcal{O}_L`),
        " の各元 ",
        math(String.raw`O`),
        " について ",
        math(String.raw`\mathrm{gl}(\alpha)\!\restriction_{O}=\alpha(O)`),
        " を積の各因子へ当てたものである。",
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
    id: "algebraic_eigenvalue_definition_orbit_bijection_set",
    kind: "definition",
    title: { text: "1 つの軌道の上の全単射の全体" },
    labels: ["def_orbit_bijection_set"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.OrbitBij"],
    verification: ["sagemath/check/orbit-family-insert"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射の全体を",
      ]),
      displayMath(
        String.raw`\mathfrak{B}_{O}:=\bigl\{\,\psi \;\bigm|\; \psi\ \text{は}\ O\ \text{から}\ O\ \text{への全単射}\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        math(String.raw`\mathfrak{S}_L`),
        "（",
        ref("def_permutation_sign"),
        "）の部分集合ではない。",
        math(String.raw`\mathfrak{S}_L`),
        " の元の定義域は ",
        math(String.raw`R_L`),
        " であり、",
        math(String.raw`\mathfrak{B}_{O}`),
        " の元の定義域は ",
        math(String.raw`O`),
        " だからである。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{B}_{O}`),
        " は空ではなく、有限集合である。",
        math(String.raw`O`),
        " の恒等写像が元であり、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像の全体が有限集合 ",
        math(String.raw`O`),
        " の元の個数で決まる有限集合だからである。",
      ]),
      paragraph([
        "この記号を用いると ",
        ref("def_orbit_permutation_family"),
        " の ",
        math(String.raw`\mathfrak{A}_L`),
        " は、",
        math(String.raw`\mathcal{O}_L`),
        " の各元 ",
        math(String.raw`O`),
        " へ ",
        math(String.raw`\mathfrak{B}_{O}`),
        " の元を 1 つずつ選ぶ選び方の全体である。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_family_on_subset",
    kind: "definition",
    title: { text: "軌道の部分集合ごとの置換の組" },
    labels: ["def_orbit_family_on_subset"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.OrbitPermFamilyOn"],
    verification: ["sagemath/check/orbit-family-insert"],
    statement: [
      paragraph([
        math(String.raw`s\subset\mathcal{O}_L`),
        " を任意に取る（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "）。",
        math(String.raw`s`),
        " の各元 ",
        math(String.raw`O`),
        " へ ",
        math(String.raw`\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）の元を 1 つずつ対応させる対応の全体を",
      ]),
      displayMath(
        String.raw`\mathfrak{A}(s):=\bigl\{\,\alpha \;\bigm|\; \alpha\ \text{は}\ s\ \text{の各元}\ O\ \text{へ}\ \mathfrak{B}_{O}\ \text{の元}\ \alpha(O)\ \text{を対応させる}\,\bigr\}`,
      ),
      paragraph([
        "と置く。",
      ]),
      paragraph([
        math(String.raw`s=\mathcal{O}_L`),
        " と取ったものが ",
        ref("def_orbit_permutation_family"),
        " の ",
        math(String.raw`\mathfrak{A}_L`),
        " である（",
        math(String.raw`\mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L`),
        "）。",
        math(String.raw`s`),
        " を動かせるようにしたのは、次の主張と分配則の証明が ",
        math(String.raw`s`),
        " の元の個数についての帰納法によるためである。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{A}(\emptyset)`),
        " はちょうど 1 つの元を持つ。",
        math(String.raw`\emptyset`),
        " の元へ対応を与える対応は、何も対応させない対応ただ 1 つだからである。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_family_insert_bijection",
    kind: "claim",
    title: {
      text: "軌道を 1 つ足した組の全体は、その軌道の上の全単射と残りの組との対に 1 対 1 に対応する",
    },
    labels: ["claim_orbit_family_insert_bijection"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_leftInverse",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_rightInverse",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.insertFamily_leftInverse",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.insertFamily_rightInverse",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_leftInverse_from_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFamilyInsert_rightInverse_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-family-insert"],
    statement: [
      paragraph([
        math(String.raw`s\subset\mathcal{O}_L`),
        " と ",
        math(String.raw`O_0\in\mathcal{O}_L`),
        " を、",
        math(String.raw`O_0\notin s`),
        " を満たすように任意に取る。写像",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ins}&\;:\;\mathfrak{B}_{O_0}\times\mathfrak{A}(s)\longrightarrow\mathfrak{A}(\{O_0\}\cup s),
&\bigl(\mathrm{ins}(\psi,\alpha)\bigr)(O)&:=\begin{cases}\psi&(O=O_0)\\ \alpha(O)&(O\in s)\end{cases}\\
\mathrm{spl}&\;:\;\mathfrak{A}(\{O_0\}\cup s)\longrightarrow\mathfrak{B}_{O_0}\times\mathfrak{A}(s),
&\mathrm{spl}(\beta)&:=\bigl(\beta(O_0),\ \beta\!\restriction_{s}\bigr)
\end{aligned}`),
      paragraph([
        "は互いに逆である（",
        math(String.raw`\beta\!\restriction_{s}`),
        " は ",
        math(String.raw`\beta`),
        " の ",
        math(String.raw`s`),
        " の元への対応だけを取り出した組である）。すなわち",
      ]),
      displayMath(
        String.raw`\mathrm{spl}\bigl(\mathrm{ins}(\psi,\alpha)\bigr)=(\psi,\alpha),\qquad \mathrm{ins}\bigl(\mathrm{spl}(\beta)\bigr)=\beta`,
      ),
      paragraph([
        "が任意の ",
        math(String.raw`\psi\in\mathfrak{B}_{O_0}`),
        "、",
        math(String.raw`\alpha\in\mathfrak{A}(s)`),
        "、",
        math(String.raw`\beta\in\mathfrak{A}(\{O_0\}\cup s)`),
        " について成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\mathrm{ins}(\psi,\alpha)`),
        " が ",
        math(String.raw`\mathfrak{A}(\{O_0\}\cup s)`),
        " の元であることを先に見る。",
        math(String.raw`\{O_0\}\cup s`),
        " の元 ",
        math(String.raw`O`),
        " は ",
        math(String.raw`O=O_0`),
        " か ",
        math(String.raw`O\in s`),
        " のいずれかであり、",
        math(String.raw`O_0\notin s`),
        " よりこの 2 つは同時には起こらないので、場合分けはちょうど 1 つの値を与える。",
        "前者では値が ",
        math(String.raw`\psi\in\mathfrak{B}_{O_0}`),
        "、後者では値が ",
        math(String.raw`\alpha(O)\in\mathfrak{B}_{O}`),
        " であり、いずれも ",
        ref("def_orbit_family_on_subset"),
        " が要求する所属を満たす。",
      ]),
      paragraph([
        math(String.raw`\mathrm{spl}(\beta)`),
        " が ",
        math(String.raw`\mathfrak{B}_{O_0}\times\mathfrak{A}(s)`),
        " の元であることも同様である。",
        math(String.raw`O_0\in\{O_0\}\cup s`),
        " より ",
        math(String.raw`\beta(O_0)\in\mathfrak{B}_{O_0}`),
        " であり、",
        math(String.raw`s\subset\{O_0\}\cup s`),
        " より ",
        math(String.raw`s`),
        " の各元 ",
        math(String.raw`O`),
        " について ",
        math(String.raw`\beta(O)\in\mathfrak{B}_{O}`),
        " である。",
      ]),
      paragraph([
        "第 1 の等式を示す。",
        math(String.raw`\mathrm{ins}(\psi,\alpha)`),
        " を ",
        math(String.raw`\gamma`),
        " と書く。第 1 成分は",
      ]),
      displayMath(String.raw`\begin{aligned}
\gamma(O_0)
&=\psi
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{の定義と}\ O_0=O_0)
\end{aligned}`),
      paragraph([
        "である。第 2 成分は、",
        math(String.raw`s`),
        " の任意の元 ",
        math(String.raw`O`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\gamma\!\restriction_{s}\bigr)(O)
&=\gamma(O)
&&(\because\ \text{取り出しの定義})\\
&=\alpha(O)
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{の定義と}\ O\in s,\ O\ne O_0)
\end{aligned}`),
      paragraph([
        "である。ここで ",
        math(String.raw`O\ne O_0`),
        " は ",
        math(String.raw`O\in s`),
        " と ",
        math(String.raw`O_0\notin s`),
        " による。",
        math(String.raw`O`),
        " は任意だったので ",
        math(String.raw`\gamma\!\restriction_{s}=\alpha`),
        " であり、あわせて ",
        math(String.raw`\mathrm{spl}(\gamma)=(\psi,\alpha)`),
        " である。",
      ]),
      paragraph([
        "第 2 の等式を示す。",
        math(String.raw`\{O_0\}\cup s`),
        " の任意の元 ",
        math(String.raw`O`),
        " について、",
        math(String.raw`O=O_0`),
        " か ",
        math(String.raw`O\ne O_0`),
        " かで場合を分ける（",
        math(String.raw`O\in s`),
        " かどうかでは分けない）。",
      ]),
      paragraph([
        math(String.raw`O=O_0`),
        " のとき",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{ins}(\mathrm{spl}(\beta))\bigr)(O_0)
&=\beta(O_0)
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{と}\ \mathrm{spl}\ \text{の定義})
\end{aligned}`),
      paragraph([
        math(String.raw`O\ne O_0`),
        " のとき、",
        math(String.raw`O\in\{O_0\}\cup s`),
        " と合わせて ",
        math(String.raw`O\in s`),
        " であり",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{ins}(\mathrm{spl}(\beta))\bigr)(O)
&=\bigl(\beta\!\restriction_{s}\bigr)(O)
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{と}\ \mathrm{spl}\ \text{の定義と}\ O\ne O_0)\\
&=\beta(O)
&&(\because\ \text{取り出しの定義})
\end{aligned}`),
      paragraph([
        "である。どちらの場合も値が ",
        math(String.raw`\beta(O)`),
        " に一致し、",
        math(String.raw`O`),
        " は任意だったので ",
        math(String.raw`\mathrm{ins}(\mathrm{spl}(\beta))=\beta`),
        " である。",
      ]),
      paragraph([
        "第 2 の等式は ",
        math(String.raw`O_0\notin s`),
        " を使っていない。場合分けが ",
        math(String.raw`O=O_0`),
        " か否かだけによっており、どちらの場合も値が ",
        math(String.raw`\beta`),
        " 自身から取られるからである。",
        math(String.raw`O_0\notin s`),
        " が要るのは第 1 の等式の側であり、そこでは ",
        math(String.raw`\psi`),
        " と ",
        math(String.raw`\alpha`),
        " という別々に与えられた 2 つのものを突き合わせるため、",
        math(String.raw`O_0\in s`),
        " だと ",
        math(String.raw`O_0`),
        " における値が食い違いうる。",
      ]),
      paragraph([
        "この主張は、次のセクションで有限積の分配則を ",
        math(String.raw`s`),
        " の元の個数についての帰納法で示すときの、一歩の部分である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_family_distributive",
    kind: "claim",
    title: {
      text: "軌道の部分集合にわたる有限積の分配則",
    },
    labels: ["claim_orbit_family_distributive"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamily",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_family",
      "Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamily_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-family-distributive"],
    statement: [
      paragraph([
        "各 ",
        math(String.raw`O\in\mathcal{O}_L`),
        " と各 ",
        math(String.raw`\psi\in\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）へ ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`g(O,\psi)`),
        " を与える対応 ",
        math(String.raw`g`),
        " を任意に取る。このとき、任意の ",
        math(String.raw`s\subset\mathcal{O}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\prod_{O\in s}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}g(O,\psi)\Bigr)=\sum_{\alpha\in\mathfrak{A}(s)}\ \prod_{O\in s}g\bigl(O,\alpha(O)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{A}(s)`),
        " は ",
        ref("def_orbit_family_on_subset"),
        "）。両辺とも ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の有限和と有限積である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s`),
        " の元の個数についての帰納法で示す。",
      ]),
      paragraph([
        "出発点は ",
        math(String.raw`s=\emptyset`),
        " の場合である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{O\in\emptyset}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}g(O,\psi)\Bigr)
&=1
&&(\because\ \text{空集合にわたる有限積は}\ 1\ \text{である})\\
&=\sum_{\alpha\in\mathfrak{A}(\emptyset)}1
&&(\because\ \blkref{def_orbit_family_on_subset}\ \text{の}\ \mathfrak{A}(\emptyset)\ \text{がちょうど 1 元であること})\\
&=\sum_{\alpha\in\mathfrak{A}(\emptyset)}\ \prod_{O\in\emptyset}g\bigl(O,\alpha(O)\bigr)
&&(\because\ \text{空集合にわたる有限積は}\ 1\ \text{である})
\end{aligned}`),
      paragraph([
        "一歩を示す。",
        math(String.raw`s\subset\mathcal{O}_L`),
        " について主張が成り立つとし、",
        math(String.raw`O_0\in\mathcal{O}_L`),
        " を ",
        math(String.raw`O_0\notin s`),
        " を満たすように取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{O\in\{O_0\}\cup s}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}g(O,\psi)\Bigr)
&=\Bigl(\sum_{\psi\in\mathfrak{B}_{O_0}}g(O_0,\psi)\Bigr)\cdot\prod_{O\in s}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}g(O,\psi)\Bigr)
&&(\because\ \text{元を 1 つ足した集合にわたる有限積は、その元での値と残りの積である}\ (O_0\notin s))\\
&=\Bigl(\sum_{\psi\in\mathfrak{B}_{O_0}}g(O_0,\psi)\Bigr)\cdot\sum_{\alpha\in\mathfrak{A}(s)}\ \prod_{O\in s}g\bigl(O,\alpha(O)\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=\sum_{\psi\in\mathfrak{B}_{O_0}}\Bigl(g(O_0,\psi)\cdot\sum_{\alpha\in\mathfrak{A}(s)}\ \prod_{O\in s}g\bigl(O,\alpha(O)\bigr)\Bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の有限和と元の積についての分配則})\\
&=\sum_{\psi\in\mathfrak{B}_{O_0}}\ \sum_{\alpha\in\mathfrak{A}(s)}\Bigl(g(O_0,\psi)\cdot\prod_{O\in s}g\bigl(O,\alpha(O)\bigr)\Bigr)
&&(\because\ \text{同じ分配則を各}\ \psi\ \text{の項へ})\\
&=\sum_{(\psi,\alpha)\in\mathfrak{B}_{O_0}\times\mathfrak{A}(s)}\Bigl(g(O_0,\psi)\cdot\prod_{O\in s}g\bigl(O,\alpha(O)\bigr)\Bigr)
&&(\because\ \text{2 重の有限和は積集合にわたる有限和である})\\
&=\sum_{(\psi,\alpha)\in\mathfrak{B}_{O_0}\times\mathfrak{A}(s)}\Bigl(g\bigl(O_0,(\mathrm{ins}(\psi,\alpha))(O_0)\bigr)\cdot\prod_{O\in s}g\bigl(O,(\mathrm{ins}(\psi,\alpha))(O)\bigr)\Bigr)
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{の定義と}\ O_0=O_0,\ (O\in s\ \Rightarrow\ O\ne O_0))\\
&=\sum_{\beta\in\mathfrak{A}(\{O_0\}\cup s)}\Bigl(g\bigl(O_0,\beta(O_0)\bigr)\cdot\prod_{O\in s}g\bigl(O,\beta(O)\bigr)\Bigr)
&&(\because\ \blkref{claim_orbit_family_insert_bijection}\ \text{の}\ \mathrm{ins}\ \text{と}\ \mathrm{spl}\ \text{が互いに逆であること})\\
&=\sum_{\beta\in\mathfrak{A}(\{O_0\}\cup s)}\ \prod_{O\in\{O_0\}\cup s}g\bigl(O,\beta(O)\bigr)
&&(\because\ \text{元を 1 つ足した集合にわたる有限積は、その元での値と残りの積である}\ (O_0\notin s))
\end{aligned}`),
      paragraph([
        "第 6 の等号で ",
        math(String.raw`O\in s`),
        " から ",
        math(String.raw`O\ne O_0`),
        " が出るのは ",
        math(String.raw`O_0\notin s`),
        " による。第 7 の等号は、互いに逆な 2 つの写像が与える 1 対 1 対応で和の添字を",
        "取り替えたものであり、和の項は取り替えの前後で同じ元である。",
      ]),
      paragraph([
        "証明が ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " について使ったのは、積の結合則と可換性、単位元 ",
        math(String.raw`1`),
        "、および有限和と元の積についての分配則だけである。",
        "「元を 1 つ足した集合にわたる有限積は、その元での値と残りの積である」と",
        "「2 重の有限和は積集合にわたる有限和である」は、いずれも集合の元の個数についての",
        "帰納法でこれらから出る。引き算も、零因子が無いことも使っていない。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の和と積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_orbit_product",
    kind: "claim",
    title: {
      text: "シフト行列の特性多項式は、軌道ごとの和の積である",
    },
    labels: ["claim_shift_char_orbit_product"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_prod_orbit_sum",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_pi",
      "Ising2DLambda.AlgebraicEigenvalue.prod_sum_eq_sum_prod_orbitFamilyAll_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-orbit-product"],
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
        String.raw`\chi_U=\prod_{O\in\mathcal{O}_L}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "）。",
        math(String.raw`2^{L}`),
        " 個の行配位にわたる置換の全体についての和として定義された特性多項式が、",
        "軌道ごとに閉じた和の積として書けたことになる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("claim_orbit_family_distributive"),
        " の対応 ",
        math(String.raw`g`),
        " として、各 ",
        math(String.raw`O\in\mathcal{O}_L`),
        " と各 ",
        math(String.raw`\psi\in\mathfrak{B}_{O}`),
        " へ ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)`),
        " を与えるものを取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_U
&=\sum_{\alpha\in\mathfrak{A}_L}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\alpha(O)\bigr)
&&(\because\ \blkref{claim_shift_char_sum_family})\\
&=\sum_{\alpha\in\mathfrak{A}(\mathcal{O}_L)}\ \prod_{O\in\mathcal{O}_L}W_{O}\bigl(\mathrm{ch}(U),\alpha(O)\bigr)
&&(\because\ \blkref{def_orbit_family_on_subset}\ \text{の}\ \mathfrak{A}(\mathcal{O}_L)=\mathfrak{A}_L)\\
&=\prod_{O\in\mathcal{O}_L}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)
&&(\because\ \blkref{claim_orbit_family_distributive}\ \text{を}\ s=\mathcal{O}_L\ \text{と取ったもの})
\end{aligned}`),
      paragraph([
        "第 3 の等号は分配則を右辺から左辺へ向けて使っている。",
        ref("claim_orbit_family_distributive"),
        " は等式なので、どちらの向きに読んでもよい。",
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
    id: "algebraic_eigenvalue_claim_shift_orbit_preserving",
    kind: "claim",
    title: { text: "巡回シフトは軌道を保つ置換である" },
    labels: ["claim_shift_orbit_preserving"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShift_orbitPreserving",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.self_apply_mem_orbit",
      "Ising2DLambda.AlgebraicEigenvalue.rowShift_orbitPreserving_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-bijection-id-or-shift"],
    statement: [
      paragraph([
        ref("def_row_config_shift"),
        " の巡回シフト ",
        math(String.raw`S`),
        " は ",
        math(String.raw`S\in\mathfrak{S}^{\mathcal{O}}_L`),
        " を満たす（",
        math(String.raw`\mathfrak{S}^{\mathcal{O}}_L`),
        " は ",
        ref("def_orbit_preserving_permutation"),
        "）。したがって任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について制限 ",
        math(String.raw`S\!\restriction_{O}`),
        "（",
        ref("def_orbit_restriction"),
        "）が定まり、",
        math(String.raw`S\!\restriction_{O}\in\mathfrak{B}_{O}`),
        " である（",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`S`),
        " は ",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`R_L`),
        " への全単射なので（",
        ref("claim_row_config_shift_bijective"),
        "）",
        math(String.raw`S\in\mathfrak{S}_L`),
        " である（",
        ref("def_row_permutation"),
        "）。",
        math(String.raw`\tau\in R_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
S(\tau)
&=S\bigl(S^{[0]}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=S^{[1]}(\tau)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]}\ \text{の}\ k=0\ \text{の場合})
\end{aligned}`),
      paragraph([
        "なので ",
        math(String.raw`S(\tau)\in O(\tau)`),
        " である（",
        ref("def_row_config_orbit"),
        "）。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`S\in\mathfrak{S}^{\mathcal{O}}_L`),
        " である（",
        ref("def_orbit_preserving_permutation"),
        "）。",
      ]),
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る。",
        ref("def_orbit_restriction"),
        " より ",
        math(String.raw`S\!\restriction_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像であり、",
        ref("claim_orbit_restriction_bijective"),
        " よりそれは全単射である。したがって ",
        math(String.raw`S\!\restriction_{O}\in\mathfrak{B}_{O}`),
        " である（",
        ref("def_orbit_bijection_set"),
        "）。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_bijection_id_or_shift",
    kind: "claim",
    title: {
      text: "各行配位をそれ自身かその像へ送る軌道の上の全単射は、恒等写像か巡回シフトの制限である",
    },
    labels: ["claim_orbit_bijection_id_or_shift"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitBij_eq_id_or_shift",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_id_or_apply_of_fixed_or_apply",
      "Ising2DLambda.AlgebraicEigenvalue.orbitBij_eq_id_or_shift_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-bijection-id-or-shift"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        " と ",
        math(String.raw`\psi\in\mathfrak{B}_{O}`),
        " を任意に取る（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "）。任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\psi(\tau)=\tau`),
        " または ",
        math(String.raw`\psi(\tau)=S(\tau)`),
        " が成り立つならば、",
        math(String.raw`\psi=\mathrm{id}_{O}`),
        " または ",
        math(String.raw`\psi=S\!\restriction_{O}`),
        " である（",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "、",
        math(String.raw`S\!\restriction_{O}`),
        " は ",
        ref("claim_shift_orbit_preserving"),
        " で定まる ",
        math(String.raw`\mathfrak{B}_{O}`),
        " の元）。実数体は現れない。",
      ]),
      paragraph([
        math(String.raw`\mathrm{id}_{O}`),
        " は ",
        math(String.raw`O`),
        " の恒等写像である。この主張は、",
        math(String.raw`\chi_U`),
        " の軌道ごとの和（",
        ref("claim_shift_char_orbit_product"),
        "）に零元でない項を与えうるのが、この 2 つの全単射だけであることを言うためのものである。",
      ]),
    ],
    proof: [
      paragraph([
        "証明の中だけで使う記号として、",
        math(String.raw`\psi`),
        " が動かさない行配位の全体",
      ]),
      displayMath(
        String.raw`F:=\bigl\{\,\tau\in O \;\bigm|\; \psi(\tau)=\tau \,\bigr\}\subset O`,
      ),
      paragraph([
        "を置く。場合分けは ",
        math(String.raw`F=\emptyset`),
        " か否かによる。両立しないので一続きの式変形にはできない。",
      ]),
      paragraph([
        math(String.raw`F=\emptyset`),
        " の場合。",
        math(String.raw`\tau\in O`),
        " を任意に取ると ",
        math(String.raw`\tau\notin F`),
        " なので ",
        math(String.raw`\psi(\tau)\ne\tau`),
        " であり、仮定の 2 つの場合のうち第 1 は起こらない。",
      ]),
      displayMath(String.raw`\begin{aligned}
\psi(\tau)
&=S(\tau)
&&(\because\ \text{仮定の第 2 の場合})\\
&=\bigl(S\!\restriction_{O}\bigr)(\tau)
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\psi=S\!\restriction_{O}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`F\ne\emptyset`),
        " の場合。まず、",
        math(String.raw`F`),
        " が 1 つ前の行配位について閉じていることを見る。",
        math(String.raw`\tau\in F`),
        " と ",
        math(String.raw`\tau'\in O`),
        " が ",
        math(String.raw`S(\tau')=\tau`),
        " を満たすとする。仮定より ",
        math(String.raw`\psi(\tau')=\tau'`),
        " または ",
        math(String.raw`\psi(\tau')=S(\tau')`),
        " である。第 2 の場合には",
      ]),
      displayMath(String.raw`\begin{aligned}
\psi(\tau')
&=S(\tau')
&&(\because\ \text{この場合の仮定})\\
&=\tau
&&(\because\ \tau'\ \text{の取り方})\\
&=\psi(\tau)
&&(\because\ \tau\in F)
\end{aligned}`),
      paragraph([
        "となり、",
        math(String.raw`\psi`),
        " は ",
        math(String.raw`O`),
        " の上の全単射なので（",
        ref("def_orbit_bijection_set"),
        "）とくに単射であり、そこから ",
        math(String.raw`\tau'=\tau`),
        " が出る。このとき ",
        math(String.raw`\psi(\tau')=\psi(\tau)=\tau=\tau'`),
        " なので、いずれの場合も ",
        math(String.raw`\psi(\tau')=\tau'`),
        "、すなわち ",
        math(String.raw`\tau'\in F`),
        " である。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`F=O`),
        " を示す。",
        math(String.raw`F\ne\emptyset`),
        " なので ",
        math(String.raw`\tau_0\in F`),
        " を 1 つ取り、",
        math(String.raw`e:=e(\tau_0)`),
        " と置く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        math(String.raw`\tau_0\in O`),
        " と ",
        ref("claim_row_config_orbit_mem_eq"),
        " より ",
        math(String.raw`O(\tau_0)=O`),
        " である。",
      ]),
      paragraph([
        math(String.raw`j\in\mathbb{N}`),
        " が ",
        math(String.raw`j\le e`),
        " を満たすとき ",
        math(String.raw`S^{[e-j]}(\tau_0)\in F`),
        " であることを、",
        math(String.raw`j`),
        " についての帰納法で示す（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。",
      ]),
      paragraph([
        math(String.raw`j=0`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[e-0]}(\tau_0)
&=S^{[e]}(\tau_0)
&&(\because\ e-0=e)\\
&=\tau_0
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{と}\ e(\tau_0)\mid e)
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`\tau_0\in F`),
        " なので ",
        math(String.raw`S^{[e-0]}(\tau_0)\in F`),
        " である。",
      ]),
      paragraph([
        math(String.raw`j`),
        " について成り立つとし、",
        math(String.raw`j+1\le e`),
        " とする。",
        math(String.raw`\tau:=S^{[e-j]}(\tau_0)`),
        " と ",
        math(String.raw`\tau':=S^{[e-j-1]}(\tau_0)`),
        " と置く。",
        math(String.raw`j+1\le e`),
        " より ",
        math(String.raw`j\le e`),
        " なので帰納法の仮定が使え、",
        math(String.raw`\tau\in F`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
S(\tau')
&=S\bigl(S^{[e-j-1]}(\tau_0)\bigr)
&&(\because\ \tau'\ \text{の置き方})\\
&=S^{[(e-j-1)+1]}(\tau_0)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S^{[e-j]}(\tau_0)
&&(\because\ (e-j-1)+1=e-j\ \text{（}j+1\le e\ \text{より}\ e-j-1\in\mathbb{N}\text{）})\\
&=\tau
&&(\because\ \tau\ \text{の置き方})
\end{aligned}`),
      paragraph([
        "であり ",
        math(String.raw`\tau'\in O`),
        " である（",
        ref("def_row_config_orbit"),
        " と ",
        math(String.raw`O(\tau_0)=O`),
        "）。したがって 1 つ前の行配位についての閉性より ",
        math(String.raw`\tau'\in F`),
        "、すなわち ",
        math(String.raw`S^{[e-(j+1)]}(\tau_0)\in F`),
        " である。これで帰納法が終わる。",
      ]),
      paragraph([
        "最後に ",
        math(String.raw`\tau\in O`),
        " を任意に取る。",
        math(String.raw`O=O(\tau_0)`),
        " なので ",
        math(String.raw`\tau=S^{[k]}(\tau_0)`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在する（",
        ref("def_row_config_orbit"),
        "）。",
        math(String.raw`e\ge1`),
        " なので自然数の除法より ",
        math(String.raw`k=e\,q+r`),
        " かつ ",
        math(String.raw`r<e`),
        " を満たす ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau
&=S^{[k]}(\tau_0)
&&(\because\ k\ \text{の取り方})\\
&=S^{[r+e\,q]}(\tau_0)
&&(\because\ k=e\,q+r)\\
&=S^{[r]}\bigl(S^{[e\,q]}(\tau_0)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[r]}(\tau_0)
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{と}\ e(\tau_0)\mid e\,q)\\
&=S^{[e-(e-r)]}(\tau_0)
&&(\because\ r<e\ \text{より}\ e-(e-r)=r)
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`r<e`),
        " より ",
        math(String.raw`e-r\in\mathbb{N}`),
        " であり、",
        math(String.raw`r\ge0`),
        " より ",
        math(String.raw`e-r\le e`),
        " である。したがって上の帰納法の結論を ",
        math(String.raw`j=e-r`),
        " として当てられて ",
        math(String.raw`S^{[e-(e-r)]}(\tau_0)\in F`),
        " であり、上の式変形より ",
        math(String.raw`\tau\in F`),
        " である。",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`F=O`),
        "、すなわち任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\psi(\tau)=\tau`),
        " であり ",
        math(String.raw`\psi=\mathrm{id}_{O}`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像、および自然数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_permutation_sign_values",
    kind: "claim",
    title: {
      text: "軌道の上の全単射の符号は +1 か -1 であり、恒等写像の符号は +1 である",
    },
    labels: ["claim_orbit_permutation_sign_values"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_eq_one_or_neg_one",
      "Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_mul_self",
      "Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_id",
    ],
    verification: ["sagemath/check/orbit-permutation-sign-values"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）を任意に取る。",
        ref("def_orbit_bijection_set"),
        " の ",
        math(String.raw`\mathfrak{B}_{O}`),
        "（",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射の全体）について、",
        ref("def_orbit_permutation_sign"),
        " の符号 ",
        math(String.raw`\mathrm{sgn}_{O}`),
        " は次の 3 つを満たす。",
      ]),
      list([
        [
          "任意の ",
          math(String.raw`\psi\in\mathfrak{B}_{O}`),
          " について ",
          math(String.raw`\mathrm{sgn}_{O}(\psi)=+1`),
          " または ",
          math(String.raw`\mathrm{sgn}_{O}(\psi)=-1`),
          " である。",
        ],
        [
          "任意の ",
          math(String.raw`\psi\in\mathfrak{B}_{O}`),
          " について ",
          math(String.raw`\mathrm{sgn}_{O}(\psi)\cdot\mathrm{sgn}_{O}(\psi)=1`),
          " である。",
        ],
        [
          math(String.raw`\mathrm{sgn}_{O}(\mathrm{id}_{O})=+1`),
          " である（",
          math(String.raw`\mathrm{id}_{O}`),
          " は ",
          math(String.raw`O`),
          " の上の恒等写像である）。",
        ],
      ]),
      paragraph([
        "いずれも ",
        math(String.raw`\mathbb{Z}`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "第一の主張。",
        ref("def_orbit_inversion_count"),
        " の転倒数 ",
        math(String.raw`\mathrm{inv}_{O}(\psi)`),
        " は自然数であり、自然数は偶数か奇数のいずれかである。この 2 つの場合に分ける。",
      ]),
      paragraph([
        "転倒数が偶数の場合。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " があって ",
        math(String.raw`\mathrm{inv}_{O}(\psi)=2k`),
        " である（",
        math(String.raw`\because`),
        " 偶数の定義）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi)
&=(-1)^{\mathrm{inv}_{O}(\psi)}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=(-1)^{2k}
&&(\because\ \mathrm{inv}_{O}(\psi)=2k)\\
&=\bigl((-1)^{2}\bigr)^{k}
&&(\because\ \text{指数法則})\\
&=1^{k}
&&(\because\ (-1)^{2}=1)\\
&=1
&&(\because\ 1\ \text{の冪は}\ 1)
\end{aligned}`),
      paragraph([
        "転倒数が奇数の場合。ある ",
        math(String.raw`k\in\mathbb{N}`),
        " があって ",
        math(String.raw`\mathrm{inv}_{O}(\psi)=2k+1`),
        " である（",
        math(String.raw`\because`),
        " 奇数の定義）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi)
&=(-1)^{\mathrm{inv}_{O}(\psi)}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=(-1)^{2k+1}
&&(\because\ \mathrm{inv}_{O}(\psi)=2k+1)\\
&=(-1)^{2k}\cdot(-1)
&&(\because\ \text{指数法則})\\
&=\bigl((-1)^{2}\bigr)^{k}\cdot(-1)
&&(\because\ \text{指数法則})\\
&=1^{k}\cdot(-1)
&&(\because\ (-1)^{2}=1)\\
&=1\cdot(-1)
&&(\because\ 1\ \text{の冪は}\ 1)\\
&=-1
&&(\because\ 1\ \text{は乗法の単位元})
\end{aligned}`),
      paragraph([
        "いずれの場合も ",
        math(String.raw`\mathrm{sgn}_{O}(\psi)=+1`),
        " または ",
        math(String.raw`\mathrm{sgn}_{O}(\psi)=-1`),
        " である。",
      ]),
      paragraph(["第二の主張。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi)\cdot\mathrm{sgn}_{O}(\psi)
&=(-1)^{\mathrm{inv}_{O}(\psi)}\cdot(-1)^{\mathrm{inv}_{O}(\psi)}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=\bigl((-1)^{2}\bigr)^{\mathrm{inv}_{O}(\psi)}
&&(\because\ \text{指数法則})\\
&=1^{\mathrm{inv}_{O}(\psi)}
&&(\because\ (-1)^{2}=1)\\
&=1
&&(\because\ 1\ \text{の冪は}\ 1)
\end{aligned}`),
      paragraph([
        "第三の主張。",
        math(String.raw`(\tau,\tau')\in F(O,O)`),
        " ならば ",
        math(String.raw`\tau\prec\tau'`),
        " であり（",
        ref("def_cross_orbit_ordered_pairs"),
        " で ",
        math(String.raw`O'=O`),
        " と取ったもの）、",
        ref("claim_row_config_order_linear"),
        " の三分律から ",
        math(String.raw`\tau'\prec\tau`),
        " は成り立たない。",
        math(String.raw`\mathrm{id}_{O}(\tau)=\tau`),
        " かつ ",
        math(String.raw`\mathrm{id}_{O}(\tau')=\tau'`),
        " なので、",
        ref("def_orbit_inversion_count"),
        " の転倒数の定義に現れる集合は空であり ",
        math(String.raw`\mathrm{inv}_{O}(\mathrm{id}_{O})=0`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\mathrm{id}_{O})
&=(-1)^{\mathrm{inv}_{O}(\mathrm{id}_{O})}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=(-1)^{0}
&&(\because\ \mathrm{inv}_{O}(\mathrm{id}_{O})=0)\\
&=1
&&(\because\ \text{0 乗は}\ 1)
\end{aligned}`),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と順序、自然数、および整数 ",
        math(String.raw`-1`),
        " の冪だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_transposition",
    kind: "definition",
    title: { text: "軌道の 2 点を入れ替える写像（互換）" },
    labels: ["def_orbit_transposition"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitTransposition"],
    verification: ["sagemath/check/orbit-transposition"],
    statement: [
      paragraph([
        math(String.raw`\tau_a\in R_L`),
        " と ",
        math(String.raw`\tau_b\in R_L`),
        " を任意に取る（",
        math(String.raw`R_L`),
        " は ",
        ref("def_row_configuration"),
        "）。写像 ",
        math(String.raw`t_{\tau_a,\tau_b}:R_L\to R_L`),
        " を",
      ]),
      displayMath(String.raw`t_{\tau_a,\tau_b}(\tau):=
\begin{cases}
\tau_b & (\tau=\tau_a\ \text{のとき})\\
\tau_a & (\tau\neq\tau_a\ \text{かつ}\ \tau=\tau_b\ \text{のとき})\\
\tau   & (\tau\neq\tau_a\ \text{かつ}\ \tau\neq\tau_b\ \text{のとき})
\end{cases}`),
      paragraph([
        "で定める。3 つの場合は互いに排反で、",
        math(String.raw`R_L`),
        " のどの元もちょうど 1 つの場合に入るので、この対応は写像として定まる。",
      ]),
      paragraph([
        math(String.raw`\tau_a=\tau_b`),
        " である場合を除いていない。そのとき第 2 の場合には誰も入らず、",
        math(String.raw`t_{\tau_a,\tau_a}`),
        " は ",
        math(String.raw`R_L`),
        " の恒等写像である。",
      ]),
      paragraph([
        "定義域は ",
        math(String.raw`O`),
        " ではなく ",
        math(String.raw`R_L`),
        " である。",
        ref("def_orbit_bijection_set"),
        " の ",
        math(String.raw`\mathfrak{B}_{O}`),
        " の元として使うのは、これを ",
        math(String.raw`O`),
        " へ制限したものであり、制限してよいことは次の主張で示す。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその元の相等だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_transposition_bijective",
    kind: "claim",
    title: {
      text: "互換は 2 回合成すると恒等写像であり、その軌道への制限は軌道の上の全単射である",
    },
    labels: ["claim_orbit_transposition_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitTransposition_involutive",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTransposition_mem",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionRestriction",
    ],
    verification: ["sagemath/check/orbit-transposition"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_a\in O`),
        "、",
        math(String.raw`\tau_b\in O`),
        " を任意に取る。",
        ref("def_orbit_transposition"),
        " の ",
        math(String.raw`t_{\tau_a,\tau_b}`),
        " について次の 3 つが成り立つ。",
      ]),
      list([
        [
          "任意の ",
          math(String.raw`\tau\in R_L`),
          " について ",
          math(String.raw`t_{\tau_a,\tau_b}\bigl(t_{\tau_a,\tau_b}(\tau)\bigr)=\tau`),
          " である。",
        ],
        [
          "任意の ",
          math(String.raw`\tau\in O`),
          " について ",
          math(String.raw`t_{\tau_a,\tau_b}(\tau)\in O`),
          " である。",
        ],
        [
          math(String.raw`t_{\tau_a,\tau_b}`),
          " の ",
          math(String.raw`O`),
          " への制限は ",
          math(String.raw`\mathfrak{B}_{O}`),
          "（",
          ref("def_orbit_bijection_set"),
          "）の元である。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "第一の主張。",
        ref("def_orbit_transposition"),
        " の 3 つの場合に分ける。",
      ]),
      paragraph([
        math(String.raw`\tau=\tau_a`),
        " の場合。",
        math(String.raw`t_{\tau_a,\tau_b}(\tau)=\tau_b`),
        " である（",
        math(String.raw`\because`),
        " 第 1 の場合）。ここでさらに ",
        math(String.raw`\tau_b=\tau_a`),
        " か否かで分ける。",
        math(String.raw`\tau_b=\tau_a`),
        " ならば ",
        math(String.raw`t_{\tau_a,\tau_b}(\tau_b)=t_{\tau_a,\tau_b}(\tau_a)=\tau_b=\tau_a=\tau`),
        " である（",
        math(String.raw`\because`),
        " 第 1 の場合と ",
        math(String.raw`\tau_b=\tau_a`),
        "）。",
        math(String.raw`\tau_b\neq\tau_a`),
        " ならば ",
        math(String.raw`t_{\tau_a,\tau_b}(\tau_b)=\tau_a=\tau`),
        " である（",
        math(String.raw`\because`),
        " 第 2 の場合）。",
      ]),
      paragraph([
        math(String.raw`\tau\neq\tau_a`),
        " かつ ",
        math(String.raw`\tau=\tau_b`),
        " の場合。",
        math(String.raw`t_{\tau_a,\tau_b}(\tau)=\tau_a`),
        " であり（",
        math(String.raw`\because`),
        " 第 2 の場合）、",
        math(String.raw`t_{\tau_a,\tau_b}(\tau_a)=\tau_b=\tau`),
        " である（",
        math(String.raw`\because`),
        " 第 1 の場合）。",
      ]),
      paragraph([
        math(String.raw`\tau\neq\tau_a`),
        " かつ ",
        math(String.raw`\tau\neq\tau_b`),
        " の場合。",
        math(String.raw`t_{\tau_a,\tau_b}(\tau)=\tau`),
        " であり（",
        math(String.raw`\because`),
        " 第 3 の場合）、もう一度当てても同じ場合に入るので ",
        math(String.raw`t_{\tau_a,\tau_b}(\tau)=\tau`),
        " である。",
      ]),
      paragraph([
        "第二の主張。同じ 3 つの場合に分ける。第 1 の場合の値は ",
        math(String.raw`\tau_b`),
        " であり、仮定より ",
        math(String.raw`\tau_b\in O`),
        " である。第 2 の場合の値は ",
        math(String.raw`\tau_a`),
        " であり、仮定より ",
        math(String.raw`\tau_a\in O`),
        " である。第 3 の場合の値は ",
        math(String.raw`\tau`),
        " であり、仮定より ",
        math(String.raw`\tau\in O`),
        " である。",
      ]),
      paragraph([
        "第三の主張。第二の主張より ",
        math(String.raw`t_{\tau_a,\tau_b}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像を定める。この写像を ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}`),
        " と書く。第一の主張より、任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}\bigl(t^{O}_{\tau_a,\tau_b}(\tau)\bigr)=\tau`),
        " である。すなわち ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}`),
        " は自分自身を逆写像に持ち、逆写像を持つ写像は全単射である。したがって ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}`),
        " は全単射であり、",
        ref("def_orbit_bijection_set"),
        " より ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}\in\mathfrak{B}_{O}`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と元の相等だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_inversion_set",
    kind: "definition",
    title: { text: "軌道の上の全単射の転倒対の集合" },
    labels: ["def_orbit_inversion_set"],
    habitat: "N",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.orbitInversionSet"],
    verification: ["sagemath/check/orbit-transposition-sign"],
    statement: [
      paragraph([
        ref("def_orbit_inversion_count"),
        " の転倒数 ",
        math(String.raw`\mathrm{inv}_{O}(\psi)`),
        " は、ある集合の元の個数として定めた。これから先はその集合そのものを分けて数えるので、",
        "集合の側に名前を与える。",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射 ",
        math(String.raw`\psi`),
        " を任意に取り",
      ]),
      displayMath(
        String.raw`\mathrm{Inv}_{O}(\psi):=\bigl\{\,(\tau,\tau')\in F(O,O) \;\bigm|\; \psi(\tau')\prec\psi(\tau)\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`F(O,O)`),
        " は ",
        ref("def_cross_orbit_ordered_pairs"),
        " で ",
        math(String.raw`O'=O`),
        " と取ったもの、",
        math(String.raw`\prec`),
        " は ",
        ref("def_row_config_order"),
        "）。",
        math(String.raw`F(O,O)`),
        " が有限集合なので ",
        math(String.raw`\mathrm{Inv}_{O}(\psi)`),
        " も有限集合であり、",
        ref("def_orbit_inversion_count"),
        " の右辺はこの集合の元の個数だったので",
      ]),
      displayMath(
        String.raw`\mathrm{inv}_{O}(\psi)=\bigl|\mathrm{Inv}_{O}(\psi)\bigr|\in\mathbb{N}`,
      ),
      paragraph([
        "である。これは定義の書き換えであって、新しい主張ではない。",
      ]),
      paragraph([
        math(String.raw`\mathrm{Inv}_{O}(\psi)`),
        " は集合、",
        math(String.raw`\mathrm{inv}_{O}(\psi)`),
        " はその元の個数であり、大文字と小文字で別の対象を表す。",
        "この 2 つを同じ記号で書かない。台を ",
        math(String.raw`P_L`),
        " に取った ",
        math(String.raw`\mathrm{Inv}(\varphi)`),
        "（",
        ref("def_inversion_pairs"),
        "）とも別の対象であり、下付きの ",
        math(String.raw`O`),
        " で区別する。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と順序と数え上げだけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_transposition_sign",
    kind: "claim",
    title: { text: "互換の軌道への制限の符号は -1 である" },
    labels: ["claim_orbit_transposition_sign"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitInversionSet_eq",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTransposition_inversionCount",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTransposition_sign",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.inversionCountOn_transposition",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.signOn_transposition",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTransposition_sign_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-transposition-sign"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_a\in O`),
        "、",
        math(String.raw`\tau_b\in O`),
        " を、",
        math(String.raw`\tau_a\prec\tau_b`),
        " を満たすように任意に取る（",
        math(String.raw`\prec`),
        " は ",
        ref("def_row_config_order"),
        "）。",
        ref("claim_orbit_transposition_bijective"),
        " の第三の主張により ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}\in\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）である。この元について次の 2 つが成り立つ。",
      ]),
      list([
        [
          math(String.raw`\mathrm{inv}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)`),
          "（",
          ref("def_orbit_inversion_count"),
          "）は奇数である。すなわち、ある ",
          math(String.raw`n\in\mathbb{N}`),
          " について ",
          math(String.raw`\mathrm{inv}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)=2n+1`),
          " である。",
        ],
        [
          math(String.raw`\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)=-1`),
          " である（",
          ref("def_orbit_permutation_sign"),
          "）。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "準備として記号を 4 つ置く。以下 ",
        math(String.raw`\psi:=t^{O}_{\tau_a,\tau_b}`),
        " と書き（",
        ref("def_orbit_transposition"),
        " と ",
        ref("claim_orbit_transposition_bijective"),
        "）、",
      ]),
      displayMath(String.raw`\begin{aligned}
M&:=\bigl\{\,\tau\in O \;\bigm|\; \tau_a\prec\tau\ \text{かつ}\ \tau\prec\tau_b\,\bigr\},\\
A&:=\bigl\{\,(\tau_a,\tau) \;\bigm|\; \tau\in M\,\bigr\},\\
B&:=\bigl\{\,(\tau,\tau_b) \;\bigm|\; \tau\in M\,\bigr\},\\
C&:=\bigl\{\,(\tau_a,\tau_b)\,\bigr\}
\end{aligned}`),
      paragraph([
        "と置く。",
        math(String.raw`M\subset O`),
        " は有限集合 ",
        math(String.raw`O`),
        " の部分集合なので有限集合であり、",
        math(String.raw`A`),
        "、",
        math(String.raw`B`),
        "、",
        math(String.raw`C`),
        " も有限集合である。",
        "示すことは ",
        math(String.raw`\mathrm{Inv}_{O}(\psi)=A\cup B\cup C`),
        "（",
        ref("def_orbit_inversion_set"),
        "）であり、これは集合の等号なので両包含で示す。",
      ]),
      paragraph([
        "第一の主張。まず ",
        math(String.raw`A\cup B\cup C\subset\mathrm{Inv}_{O}(\psi)`),
        " を示す。",
      ]),
      paragraph([
        math(String.raw`C`),
        " について。",
        math(String.raw`\tau_a\in O`),
        " と ",
        math(String.raw`\tau_b\in O`),
        " と ",
        math(String.raw`\tau_a\prec\tau_b`),
        " より ",
        math(String.raw`(\tau_a,\tau_b)\in F(O,O)`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_cross_orbit_ordered_pairs"),
        "）。",
        math(String.raw`\tau_a\prec\tau_b`),
        " より ",
        math(String.raw`\tau_b\ne\tau_a`),
        " である（",
        math(String.raw`\because`),
        " 三分律。",
        ref("claim_row_config_order_linear"),
        "）。したがって ",
        math(String.raw`\psi(\tau_a)=\tau_b`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        " の第 1 の場合）、",
        math(String.raw`\psi(\tau_b)=\tau_a`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        " の第 2 の場合）。よって ",
        math(String.raw`\psi(\tau_b)\prec\psi(\tau_a)`),
        " は ",
        math(String.raw`\tau_a\prec\tau_b`),
        " そのものであり、成り立つ。",
      ]),
      paragraph([
        math(String.raw`A`),
        " について。",
        math(String.raw`\tau\in M`),
        " を任意に取る。",
        math(String.raw`\tau_a\prec\tau`),
        " より ",
        math(String.raw`(\tau_a,\tau)\in F(O,O)`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_cross_orbit_ordered_pairs"),
        "）。",
        math(String.raw`\tau_a\prec\tau`),
        " より ",
        math(String.raw`\tau\ne\tau_a`),
        "、",
        math(String.raw`\tau\prec\tau_b`),
        " より ",
        math(String.raw`\tau\ne\tau_b`),
        " である（",
        math(String.raw`\because`),
        " 三分律。",
        ref("claim_row_config_order_linear"),
        "）。したがって ",
        math(String.raw`\psi(\tau)=\tau`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        " の第 3 の場合）、",
        math(String.raw`\psi(\tau_a)=\tau_b`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        " の第 1 の場合）。よって ",
        math(String.raw`\psi(\tau)\prec\psi(\tau_a)`),
        " は ",
        math(String.raw`\tau\prec\tau_b`),
        " そのものであり、",
        math(String.raw`\tau\in M`),
        " より成り立つ。",
      ]),
      paragraph([
        math(String.raw`B`),
        " について。",
        math(String.raw`\tau\in M`),
        " を任意に取る。",
        math(String.raw`\tau\prec\tau_b`),
        " より ",
        math(String.raw`(\tau,\tau_b)\in F(O,O)`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_cross_orbit_ordered_pairs"),
        "）。上と同じ理由で ",
        math(String.raw`\psi(\tau)=\tau`),
        " であり、",
        math(String.raw`\psi(\tau_b)=\tau_a`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        " の第 2 の場合）。よって ",
        math(String.raw`\psi(\tau_b)\prec\psi(\tau)`),
        " は ",
        math(String.raw`\tau_a\prec\tau`),
        " そのものであり、",
        math(String.raw`\tau\in M`),
        " より成り立つ。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`\mathrm{Inv}_{O}(\psi)\subset A\cup B\cup C`),
        " を示す。",
        math(String.raw`(\tau,\tau')\in\mathrm{Inv}_{O}(\psi)`),
        " を任意に取る。定義より ",
        math(String.raw`\tau\in O`),
        "、",
        math(String.raw`\tau'\in O`),
        "、",
        math(String.raw`\tau\prec\tau'`),
        "、",
        math(String.raw`\psi(\tau')\prec\psi(\tau)`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_inversion_set"),
        " と ",
        ref("def_cross_orbit_ordered_pairs"),
        "）。",
        math(String.raw`\tau`),
        " と ",
        math(String.raw`\tau'`),
        " のそれぞれが ",
        math(String.raw`\tau_a`),
        " と一致するか、",
        math(String.raw`\tau_b`),
        " と一致するか、どちらとも一致しないかで場合に分ける（",
        math(String.raw`\tau_a\ne\tau_b`),
        " なので、1 つの元がこの 3 つのうちちょうど 1 つに入る）。",
      ]),
      list([
        [
          math(String.raw`\tau\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau\ne\tau_b`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_b`),
          " の場合。",
          math(String.raw`\psi(\tau)=\tau`),
          " かつ ",
          math(String.raw`\psi(\tau')=\tau'`),
          " なので（",
          math(String.raw`\because`),
          " ",
          ref("def_orbit_transposition"),
          " の第 3 の場合）、",
          math(String.raw`\psi(\tau')\prec\psi(\tau)`),
          " は ",
          math(String.raw`\tau'\prec\tau`),
          " である。これは ",
          math(String.raw`\tau\prec\tau'`),
          " と両立しない（",
          math(String.raw`\because`),
          " 三分律。",
          ref("claim_row_config_order_linear"),
          "）ので、この場合は起こらない。",
        ],
        [
          math(String.raw`\tau=\tau_a`),
          " かつ ",
          math(String.raw`\tau'=\tau_b`),
          " の場合。",
          math(String.raw`(\tau,\tau')=(\tau_a,\tau_b)\in C`),
          " である。",
        ],
        [
          math(String.raw`\tau=\tau_b`),
          " かつ ",
          math(String.raw`\tau'=\tau_a`),
          " の場合。",
          math(String.raw`\tau\prec\tau'`),
          " は ",
          math(String.raw`\tau_b\prec\tau_a`),
          " であり、仮定 ",
          math(String.raw`\tau_a\prec\tau_b`),
          " と両立しない（",
          math(String.raw`\because`),
          " 三分律。",
          ref("claim_row_config_order_linear"),
          "）ので、この場合は起こらない。",
        ],
        [
          math(String.raw`\tau=\tau_a`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_b`),
          " の場合。",
          math(String.raw`\psi(\tau)=\tau_b`),
          " かつ ",
          math(String.raw`\psi(\tau')=\tau'`),
          " なので（",
          math(String.raw`\because`),
          " ",
          ref("def_orbit_transposition"),
          " の第 1・第 3 の場合）、",
          math(String.raw`\psi(\tau')\prec\psi(\tau)`),
          " は ",
          math(String.raw`\tau'\prec\tau_b`),
          " である。また ",
          math(String.raw`\tau\prec\tau'`),
          " は ",
          math(String.raw`\tau_a\prec\tau'`),
          " である。したがって ",
          math(String.raw`\tau'\in M`),
          " であり、",
          math(String.raw`(\tau,\tau')=(\tau_a,\tau')\in A`),
          " である。",
        ],
        [
          math(String.raw`\tau'=\tau_b`),
          " かつ ",
          math(String.raw`\tau\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau\ne\tau_b`),
          " の場合。",
          math(String.raw`\psi(\tau')=\tau_a`),
          " かつ ",
          math(String.raw`\psi(\tau)=\tau`),
          " なので（",
          math(String.raw`\because`),
          " ",
          ref("def_orbit_transposition"),
          " の第 2・第 3 の場合）、",
          math(String.raw`\psi(\tau')\prec\psi(\tau)`),
          " は ",
          math(String.raw`\tau_a\prec\tau`),
          " である。また ",
          math(String.raw`\tau\prec\tau'`),
          " は ",
          math(String.raw`\tau\prec\tau_b`),
          " である。したがって ",
          math(String.raw`\tau\in M`),
          " であり、",
          math(String.raw`(\tau,\tau')=(\tau,\tau_b)\in B`),
          " である。",
        ],
        [
          math(String.raw`\tau=\tau_b`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau'\ne\tau_b`),
          " の場合。",
          math(String.raw`\psi(\tau)=\tau_a`),
          " かつ ",
          math(String.raw`\psi(\tau')=\tau'`),
          " なので（",
          math(String.raw`\because`),
          " ",
          ref("def_orbit_transposition"),
          " の第 2・第 3 の場合）、",
          math(String.raw`\psi(\tau')\prec\psi(\tau)`),
          " は ",
          math(String.raw`\tau'\prec\tau_a`),
          " である。また ",
          math(String.raw`\tau\prec\tau'`),
          " は ",
          math(String.raw`\tau_b\prec\tau'`),
          " である。",
          math(String.raw`\tau_a\prec\tau_b`),
          " と ",
          math(String.raw`\tau_b\prec\tau'`),
          " から ",
          math(String.raw`\tau_a\prec\tau'`),
          " が出る（",
          math(String.raw`\because`),
          " 推移律。",
          ref("claim_row_config_order_linear"),
          "）。これは ",
          math(String.raw`\tau'\prec\tau_a`),
          " と両立しない（",
          math(String.raw`\because`),
          " 三分律。",
          ref("claim_row_config_order_linear"),
          "）ので、この場合は起こらない。",
        ],
        [
          math(String.raw`\tau'=\tau_a`),
          " かつ ",
          math(String.raw`\tau\ne\tau_a`),
          " かつ ",
          math(String.raw`\tau\ne\tau_b`),
          " の場合。",
          math(String.raw`\tau\prec\tau'`),
          " は ",
          math(String.raw`\tau\prec\tau_a`),
          " である。",
          math(String.raw`\tau\prec\tau_a`),
          " と ",
          math(String.raw`\tau_a\prec\tau_b`),
          " から ",
          math(String.raw`\tau\prec\tau_b`),
          " が出る（",
          math(String.raw`\because`),
          " 推移律。",
          ref("claim_row_config_order_linear"),
          "）。一方 ",
          math(String.raw`\psi(\tau')=\tau_b`),
          " かつ ",
          math(String.raw`\psi(\tau)=\tau`),
          " なので（",
          math(String.raw`\because`),
          " ",
          ref("def_orbit_transposition"),
          " の第 1・第 3 の場合）、",
          math(String.raw`\psi(\tau')\prec\psi(\tau)`),
          " は ",
          math(String.raw`\tau_b\prec\tau`),
          " である。これは ",
          math(String.raw`\tau\prec\tau_b`),
          " と両立しない（",
          math(String.raw`\because`),
          " 三分律。",
          ref("claim_row_config_order_linear"),
          "）ので、この場合は起こらない。",
        ],
      ]),
      paragraph([
        math(String.raw`\tau=\tau_a`),
        " かつ ",
        math(String.raw`\tau'=\tau_a`),
        " の場合と ",
        math(String.raw`\tau=\tau_b`),
        " かつ ",
        math(String.raw`\tau'=\tau_b`),
        " の場合は、",
        math(String.raw`\tau\prec\tau'`),
        " が ",
        math(String.raw`\tau\prec\tau`),
        " となって三分律に反するので起こらない（",
        ref("claim_row_config_order_linear"),
        "）。以上ですべての場合を尽くしたので、",
        math(String.raw`\mathrm{Inv}_{O}(\psi)=A\cup B\cup C`),
        " である。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`A`),
        "、",
        math(String.raw`B`),
        "、",
        math(String.raw`C`),
        " が互いに素であることを見る。",
        math(String.raw`A`),
        " の元の第 2 成分は ",
        math(String.raw`M`),
        " の元であり、",
        math(String.raw`\tau\in M`),
        " ならば ",
        math(String.raw`\tau\prec\tau_b`),
        " から ",
        math(String.raw`\tau\ne\tau_b`),
        " なので（",
        math(String.raw`\because`),
        " 三分律。",
        ref("claim_row_config_order_linear"),
        "）、",
        math(String.raw`A\cap C=\varnothing`),
        " である。",
        math(String.raw`B`),
        " の元の第 1 成分は ",
        math(String.raw`M`),
        " の元であり、",
        math(String.raw`\tau\in M`),
        " ならば ",
        math(String.raw`\tau_a\prec\tau`),
        " から ",
        math(String.raw`\tau\ne\tau_a`),
        " なので、",
        math(String.raw`B\cap C=\varnothing`),
        " である。",
        math(String.raw`A`),
        " の元の第 1 成分は ",
        math(String.raw`\tau_a`),
        " であり、",
        math(String.raw`B`),
        " の元の第 1 成分は ",
        math(String.raw`M`),
        " の元なので直前に見たとおり ",
        math(String.raw`\tau_a`),
        " と異なる。よって ",
        math(String.raw`A\cap B=\varnothing`),
        " である。",
      ]),
      paragraph([
        "また ",
        math(String.raw`f_A(\tau):=(\tau_a,\tau)`),
        " と置くと、",
        math(String.raw`f_A`),
        " は ",
        math(String.raw`M`),
        " から ",
        math(String.raw`A`),
        " への全単射である。単射であるのは、",
        math(String.raw`f_A(\tau)=f_A(\tau')`),
        " ならば第 2 成分を比べて ",
        math(String.raw`\tau=\tau'`),
        " が出るからである。全射であるのは、",
        math(String.raw`A`),
        " の元がいずれも ",
        math(String.raw`\tau\in M`),
        " を用いて ",
        math(String.raw`(\tau_a,\tau)=f_A(\tau)`),
        " と書けるからであり、これは ",
        math(String.raw`A`),
        " をその形の元の全体として定めたことそのものである。同様に ",
        math(String.raw`f_B(\tau):=(\tau,\tau_b)`),
        " は ",
        math(String.raw`M`),
        " から ",
        math(String.raw`B`),
        " への全単射である（単射性は第 1 成分を比べることによる）。全単射があれば元の個数は等しいので ",
        math(String.raw`|A|=|M|`),
        " かつ ",
        math(String.raw`|B|=|M|`),
        " であり、",
        math(String.raw`C`),
        " は 1 元集合なので ",
        math(String.raw`|C|=1`),
        " である。",
      ]),
      paragraph(["以上より第一の主張が出る。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{inv}_{O}(\psi)
&=\bigl|\mathrm{Inv}_{O}(\psi)\bigr|
&&(\because\ \blkref{def_orbit_inversion_set})\\
&=\bigl|A\cup B\cup C\bigr|
&&(\because\ \text{上で示した集合の等号})\\
&=|A|+|B|+|C|
&&(\because\ \text{互いに素な有限集合の合併の個数は個数の和})\\
&=|M|+|M|+1
&&(\because\ \text{上で示した全単射と}\ |C|=1)\\
&=2|M|+1
&&(\because\ \text{自然数の和})
\end{aligned}`),
      paragraph([
        "すなわち ",
        math(String.raw`n:=|M|\in\mathbb{N}`),
        " と取れば ",
        math(String.raw`\mathrm{inv}_{O}(\psi)=2n+1`),
        " である。",
      ]),
      paragraph(["第二の主張。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi)
&=(-1)^{\mathrm{inv}_{O}(\psi)}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=(-1)^{2n+1}
&&(\because\ \text{第一の主張})\\
&=\bigl((-1)^{2}\bigr)^{n}\cdot(-1)^{1}
&&(\because\ \text{整数の冪の指数法則})\\
&=1^{n}\cdot(-1)
&&(\because\ (-1)^{2}=1)\\
&=-1
&&(\because\ 1\ \text{の冪は}\ 1)
\end{aligned}`),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と順序と数え上げ、および整数 ",
        math(String.raw`-1`),
        " の冪だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_orbit_transposition_composite",
    kind: "definition",
    title: { text: "軌道の上の互換の反復合成" },
    labels: ["def_orbit_transposition_composite"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_mem_of_mem_orbitSet",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite",
    ],
    verification: ["sagemath/check/orbit-transposition-composite"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_0\in O`),
        " を任意に取る。",
        math(String.raw`O\in\mathcal{O}_L`),
        " より ",
        math(String.raw`O=O(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が取れ（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_orbit_set"),
        "）、",
        math(String.raw`\tau_0\in O(\tau_1)`),
        " より ",
        math(String.raw`O(\tau_0)=O(\tau_1)=O`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_mem_eq"),
        "）。任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`S^{[k]}(\tau_0)\in O(\tau_0)`),
        " なので（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_orbit"),
        "。",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）、",
        math(String.raw`S^{[k]}(\tau_0)\in O`),
        " である。",
      ]),
      paragraph([
        "したがって ",
        ref("claim_orbit_transposition_bijective"),
        " の第三の主張により、互換 ",
        math(String.raw`t_{\tau_0,\,S^{[k]}(\tau_0)}`),
        "（",
        ref("def_orbit_transposition"),
        "）の ",
        math(String.raw`O`),
        " への制限 ",
        math(String.raw`t^{O}_{\tau_0,\,S^{[k]}(\tau_0)}`),
        " は ",
        math(String.raw`\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）の元である。これを用いて、写像 ",
        math(String.raw`\Psi^{O,\tau_0}_{k}:O\to O`),
        " を ",
        math(String.raw`k\in\mathbb{N}`),
        " についての再帰で",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{0}&:=\mathrm{id}_{O},\\
\Psi^{O,\tau_0}_{k+1}&:=t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}\circ\Psi^{O,\tau_0}_{k}
\end{aligned}`),
      paragraph([
        "と定める（",
        math(String.raw`\mathrm{id}_{O}`),
        " は ",
        math(String.raw`O`),
        " の恒等写像）。下付きの ",
        math(String.raw`k`),
        " は合成した互換の個数であり、上付きの ",
        math(String.raw`O,\tau_0`),
        " はこの写像が軌道と基点の取り方に依存することを記号に残すためのものである。",
      ]),
      paragraph([
        "合成の順に注意する。",
        math(String.raw`\Psi^{O,\tau_0}_{k+1}`),
        " は ",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " を先に作用させてから互換 ",
        math(String.raw`t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}`),
        " を作用させたものであり、添字の小さい互換ほど先に作用する。",
        math(String.raw`k=0`),
        " のときは互換を 1 つも合成していない。",
      ]),
      paragraph([
        "この定義に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と元の相等だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_transposition_composite_bijective",
    kind: "claim",
    title: { text: "互換の反復合成は軌道の上の全単射である" },
    labels: ["claim_orbit_transposition_composite_bijective"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.bijective_comp_of_bijective",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_bijective",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionCompositeBij",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.compositeUpTo",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.compositeUpTo_bijective",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_bijective_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-transposition-composite"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_0\in O`),
        " を任意に取る。任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\Psi^{O,\tau_0}_{k}\in\mathfrak{B}_{O}`),
      paragraph([
        "である（",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " は ",
        ref("def_orbit_transposition_composite"),
        "、",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "）。実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射 ",
        math(String.raw`f`),
        " と ",
        math(String.raw`g`),
        " について合成 ",
        math(String.raw`g\circ f`),
        " が ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射であることを見る。",
        math(String.raw`g(f(\tau))=g(f(\tau'))`),
        " ならば ",
        math(String.raw`g`),
        " が単射であることから ",
        math(String.raw`f(\tau)=f(\tau')`),
        "、さらに ",
        math(String.raw`f`),
        " が単射であることから ",
        math(String.raw`\tau=\tau'`),
        " が出るので、",
        math(String.raw`g\circ f`),
        " は単射である。",
        math(String.raw`\tau''\in O`),
        " を任意に取ると、",
        math(String.raw`g`),
        " が全射であることから ",
        math(String.raw`g(\tau')=\tau''`),
        " を満たす ",
        math(String.raw`\tau'\in O`),
        " が取れ、",
        math(String.raw`f`),
        " が全射であることから ",
        math(String.raw`f(\tau)=\tau'`),
        " を満たす ",
        math(String.raw`\tau\in O`),
        " が取れる。このとき ",
        math(String.raw`g(f(\tau))=\tau''`),
        " なので、",
        math(String.raw`g\circ f`),
        " は全射である。",
      ]),
      paragraph([
        "そのうえで ",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の場合。",
        math(String.raw`\Psi^{O,\tau_0}_{0}=\mathrm{id}_{O}`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition_composite"),
        "）、恒等写像は自分自身を逆写像に持つので ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である。よって ",
        math(String.raw`\Psi^{O,\tau_0}_{0}\in\mathfrak{B}_{O}`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_bijection_set"),
        "）。",
      ]),
      paragraph([
        math(String.raw`k`),
        " について成り立つと仮定して ",
        math(String.raw`k+1`),
        " について示す。",
        math(String.raw`t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}\in\mathfrak{B}_{O}`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition_composite"),
        " でこれを見た）。帰納法の仮定より ",
        math(String.raw`\Psi^{O,\tau_0}_{k}\in\mathfrak{B}_{O}`),
        " なので、この 2 つはいずれも ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_bijection_set"),
        "）、上の準備により合成 ",
        math(String.raw`t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}\circ\Psi^{O,\tau_0}_{k}`),
        " も ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である。これは ",
        math(String.raw`\Psi^{O,\tau_0}_{k+1}`),
        " そのものなので（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition_composite"),
        "）、",
        math(String.raw`\Psi^{O,\tau_0}_{k+1}\in\mathfrak{B}_{O}`),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、およびその上の写像と元の相等だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_row_shift_iterate_distinct_below_period",
    kind: "claim",
    title: { text: "最小周期より小さい反復の回数は、行く先で見分けられる" },
    labels: ["claim_row_shift_iterate_distinct_below_period"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_index_eq_of_lt_period",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eq_of_le_of_symm",
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_index_eq_of_lt_period_from_necSuf",
    ],
    verification: ["sagemath/check/row-shift-iterate-distinct"],
    statement: [
      paragraph([
        math(String.raw`\tau\in R_L`),
        "（",
        ref("def_row_configuration"),
        "）を任意に取り、その最小周期を ",
        math(String.raw`e(\tau)`),
        " と書く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        math(String.raw`a\in\mathbb{N}`),
        " と ",
        math(String.raw`b\in\mathbb{N}`),
        " が ",
        math(String.raw`a<e(\tau)`),
        "、",
        math(String.raw`b<e(\tau)`),
        "、および",
      ]),
      displayMath(String.raw`S^{[a]}(\tau)=S^{[b]}(\tau)`),
      paragraph([
        "を満たすならば ",
        math(String.raw`a=b`),
        " である（",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。実数体は現れない。",
      ]),
      paragraph([
        "この主張は ",
        ref("claim_row_config_orbit_card"),
        " の証明の中で ",
        math(String.raw`\eta_\tau`),
        " の単射性として一度示したものであるが、そこでは ",
        math(String.raw`\eta_\tau`),
        " についての言明として述べたので、",
        math(String.raw`S^{[k]}`),
        " についての言明としては引けない。互換の反復合成の議論で ",
        math(String.raw`S^{[a]}(\tau_0)`),
        " と ",
        math(String.raw`S^{[b]}(\tau_0)`),
        " が相異なることを何度も使うので、独立した主張として置き直す。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`a\le b`),
        " を満たす場合を示す。",
        math(String.raw`a\le b`),
        " より ",
        math(String.raw`b-a\in\mathbb{N}`),
        " が定まり",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[a]}\bigl(S^{[b-a]}(\tau)\bigr)
&=S^{[a+(b-a)]}(\tau)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[b]}(\tau)
&&(\because\ a\le b\ \text{なので}\ a+(b-a)=b)\\
&=S^{[a]}(\tau)
&&(\because\ \text{仮定})
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
        math(String.raw`e(\tau)\mid b-a`),
        " である。そこで ",
        math(String.raw`b-a=e(\tau)\,q`),
        " を満たす ",
        math(String.raw`q\in\mathbb{N}`),
        " を取る。",
        math(String.raw`q\ge1`),
        " とすると ",
        math(String.raw`b-a=e(\tau)\,q\ge e(\tau)\cdot1=e(\tau)`),
        " となるが、",
        math(String.raw`b-a\le b<e(\tau)`),
        " に反する。よって ",
        math(String.raw`q=0`),
        "、すなわち ",
        math(String.raw`b-a=0`),
        " であり、",
        math(String.raw`a\le b`),
        " と合わせて ",
        math(String.raw`a=b`),
        " である。",
      ]),
      paragraph([
        "そのうえで一般の場合を示す。自然数の大小は全順序なので ",
        math(String.raw`a\le b`),
        " と ",
        math(String.raw`b\le a`),
        " の少なくとも一方が成り立つ。",
      ]),
      paragraph([
        math(String.raw`a\le b`),
        " の場合。仮定 ",
        math(String.raw`b<e(\tau)`),
        " と ",
        math(String.raw`S^{[a]}(\tau)=S^{[b]}(\tau)`),
        " に上の準備を当てて ",
        math(String.raw`a=b`),
        " を得る。",
      ]),
      paragraph([
        math(String.raw`b\le a`),
        " の場合。仮定 ",
        math(String.raw`a<e(\tau)`),
        " と ",
        math(String.raw`S^{[b]}(\tau)=S^{[a]}(\tau)`),
        "（等号は対称なので、仮定の両辺を入れ替えたもの）に、",
        math(String.raw`a`),
        " と ",
        math(String.raw`b`),
        " を入れ替えて上の準備を当てると ",
        math(String.raw`b=a`),
        " を得る。すなわち ",
        math(String.raw`a=b`),
        " である。",
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
    id: "algebraic_eigenvalue_claim_orbit_transposition_composite_values",
    kind: "claim",
    title: { text: "互換の反復合成が基点の反復に与える値" },
    labels: ["claim_orbit_transposition_composite_values"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShiftIterate_ne_of_ne_of_lt_period",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_apply_rowShiftIterate",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.composite_apply_of_rec",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_apply_rowShiftIterate_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-transposition-composite-values"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_0\in O`),
        " を任意に取り、",
        math(String.raw`\tau_0`),
        " の最小周期を ",
        math(String.raw`e(\tau_0)`),
        " と書く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k<e(\tau_0)`),
        " を満たすとする。このとき ",
        math(String.raw`r<e(\tau_0)`),
        " を満たす任意の ",
        math(String.raw`r\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`\Psi^{O,\tau_0}_{k}\bigl(S^{[r]}(\tau_0)\bigr)=
\begin{cases}
S^{[r+1]}(\tau_0) & (r<k\ \text{のとき})\\
\tau_0            & (r=k\ \text{のとき})\\
S^{[r]}(\tau_0)   & (r>k\ \text{のとき})
\end{cases}`),
      paragraph([
        "である（",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " は ",
        ref("def_orbit_transposition_composite"),
        "、",
        math(String.raw`S^{[k]}`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。実数体は現れない。",
      ]),
      paragraph([
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " の定義域は ",
        math(String.raw`O`),
        " であり、",
        math(String.raw`S^{[r]}(\tau_0)\in O`),
        " なので（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition_composite"),
        " でこれを見た）、左辺は定まっている。",
      ]),
      paragraph([
        "3 つの場合を言葉で述べると、",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " は基点から数えて ",
        math(String.raw`k`),
        " 番目までの反復を 1 つ先へ送り、",
        math(String.raw`k`),
        " 番目を基点へ戻し、それより先の反復を動かさない、ということである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`r<e(\tau_0)`),
        " と ",
        math(String.raw`j<e(\tau_0)`),
        " を満たす ",
        math(String.raw`r\in\mathbb{N}`),
        " と ",
        math(String.raw`j\in\mathbb{N}`),
        " について、",
        math(String.raw`r\neq j`),
        " ならば ",
        math(String.raw`S^{[r]}(\tau_0)\neq S^{[j]}(\tau_0)`),
        " であることを見る。これは ",
        ref("claim_row_shift_iterate_distinct_below_period"),
        " の対偶である。以下では、",
        ref("def_orbit_transposition"),
        " の 3 つの場合のどれに入るかを、この事実で判定する。",
      ]),
      paragraph([
        "そのうえで ",
        math(String.raw`k`),
        " についての帰納法で示す。示す言明は「",
        math(String.raw`k<e(\tau_0)`),
        " ならば、",
        math(String.raw`r<e(\tau_0)`),
        " を満たす任意の ",
        math(String.raw`r\in\mathbb{N}`),
        " について上の等式が成り立つ」である。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の場合。",
        math(String.raw`r<e(\tau_0)`),
        " を任意に取る。",
        math(String.raw`r<0`),
        " を満たす ",
        math(String.raw`r\in\mathbb{N}`),
        " は無いので、第 1 の場合は起こらない。",
      ]),
      paragraph([
        math(String.raw`r=0`),
        " のとき、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{0}\bigl(S^{[0]}(\tau_0)\bigr)
&=\mathrm{id}_{O}\bigl(S^{[0]}(\tau_0)\bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=S^{[0]}(\tau_0)
&&(\because\ \mathrm{id}_{O}\ \text{は}\ O\ \text{の恒等写像})\\
&=\tau_0
&&(\because\ \blkref{def_row_config_shift_iterate})
\end{aligned}`),
      paragraph([
        "であり、これは第 2 の場合の値である。",
      ]),
      paragraph([
        math(String.raw`r>0`),
        " のとき、",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{0}\bigl(S^{[r]}(\tau_0)\bigr)
&=\mathrm{id}_{O}\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=S^{[r]}(\tau_0)
&&(\because\ \mathrm{id}_{O}\ \text{は}\ O\ \text{の恒等写像})
\end{aligned}`),
      paragraph([
        "であり、これは第 3 の場合の値である。",
      ]),
      paragraph([
        math(String.raw`k`),
        " について成り立つと仮定して ",
        math(String.raw`k+1`),
        " について示す。",
        math(String.raw`k+1<e(\tau_0)`),
        " とする。",
        math(String.raw`k<k+1`),
        " なので ",
        math(String.raw`k<e(\tau_0)`),
        " であり、帰納法の仮定が使える。以下 ",
        math(String.raw`t:=t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}`),
        " と書く（",
        ref("def_orbit_transposition"),
        " の互換の ",
        math(String.raw`O`),
        " への制限。",
        ref("def_orbit_transposition_composite"),
        " でこれが ",
        math(String.raw`\mathfrak{B}_{O}`),
        " の元であることを見た）。",
        math(String.raw`t`),
        " の定義における第 1 の点は ",
        math(String.raw`\tau_0`),
        "、第 2 の点は ",
        math(String.raw`S^{[k+1]}(\tau_0)`),
        " である。",
        math(String.raw`r<e(\tau_0)`),
        " を任意に取り、4 つの場合に分ける。",
      ]),
      paragraph([
        math(String.raw`r<k`),
        " の場合。",
        math(String.raw`r+1\le k<k+1<e(\tau_0)`),
        " より ",
        math(String.raw`r+1<e(\tau_0)`),
        " であり、",
        math(String.raw`r+1\neq0`),
        " と ",
        math(String.raw`r+1\neq k+1`),
        " から、準備により ",
        math(String.raw`S^{[r+1]}(\tau_0)\neq\tau_0`),
        " かつ ",
        math(String.raw`S^{[r+1]}(\tau_0)\neq S^{[k+1]}(\tau_0)`),
        " である（",
        math(String.raw`\tau_0=S^{[0]}(\tau_0)`),
        " は ",
        ref("def_row_config_shift_iterate"),
        "）。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{k+1}\bigl(S^{[r]}(\tau_0)\bigr)
&=t\Bigl(\Psi^{O,\tau_0}_{k}\bigl(S^{[r]}(\tau_0)\bigr)\Bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=t\bigl(S^{[r+1]}(\tau_0)\bigr)
&&(\because\ \text{帰納法の仮定の第 1 の場合})\\
&=S^{[r+1]}(\tau_0)
&&(\because\ \blkref{def_orbit_transposition}\ \text{の第 3 の場合})
\end{aligned}`),
      paragraph([
        "であり、これは ",
        math(String.raw`r<k+1`),
        " すなわち第 1 の場合の値である。",
      ]),
      paragraph([
        math(String.raw`r=k`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{k+1}\bigl(S^{[k]}(\tau_0)\bigr)
&=t\Bigl(\Psi^{O,\tau_0}_{k}\bigl(S^{[k]}(\tau_0)\bigr)\Bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=t(\tau_0)
&&(\because\ \text{帰納法の仮定の第 2 の場合})\\
&=S^{[k+1]}(\tau_0)
&&(\because\ \blkref{def_orbit_transposition}\ \text{の第 1 の場合})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`r+1=k+1`),
        " なのでこれは第 1 の場合の値である。",
      ]),
      paragraph([
        math(String.raw`r=k+1`),
        " の場合。",
        math(String.raw`k+1\neq0`),
        " と ",
        math(String.raw`k+1<e(\tau_0)`),
        " から、準備により ",
        math(String.raw`S^{[k+1]}(\tau_0)\neq\tau_0`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{k+1}\bigl(S^{[k+1]}(\tau_0)\bigr)
&=t\Bigl(\Psi^{O,\tau_0}_{k}\bigl(S^{[k+1]}(\tau_0)\bigr)\Bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=t\bigl(S^{[k+1]}(\tau_0)\bigr)
&&(\because\ \text{帰納法の仮定の第 3 の場合。}\ k+1>k)\\
&=\tau_0
&&(\because\ \blkref{def_orbit_transposition}\ \text{の第 2 の場合})
\end{aligned}`),
      paragraph([
        "であり、これは第 2 の場合の値である。",
      ]),
      paragraph([
        math(String.raw`r>k+1`),
        " の場合。",
        math(String.raw`r\neq0`),
        " と ",
        math(String.raw`r\neq k+1`),
        " と ",
        math(String.raw`r<e(\tau_0)`),
        " から、準備により ",
        math(String.raw`S^{[r]}(\tau_0)\neq\tau_0`),
        " かつ ",
        math(String.raw`S^{[r]}(\tau_0)\neq S^{[k+1]}(\tau_0)`),
        " である。よって",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{k+1}\bigl(S^{[r]}(\tau_0)\bigr)
&=t\Bigl(\Psi^{O,\tau_0}_{k}\bigl(S^{[r]}(\tau_0)\bigr)\Bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=t\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \text{帰納法の仮定の第 3 の場合。}\ r>k+1>k)\\
&=S^{[r]}(\tau_0)
&&(\because\ \blkref{def_orbit_transposition}\ \text{の第 3 の場合})
\end{aligned}`),
      paragraph([
        "であり、これは第 3 の場合の値である。以上で 4 つの場合が尽くされた（",
        math(String.raw`r<k+1`),
        " は ",
        math(String.raw`r<k`),
        " と ",
        math(String.raw`r=k`),
        " に分かれる）。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と元の相等、および ",
        math(String.raw`\mathbb{N}`),
        " だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_transposition_composite_is_shift",
    kind: "claim",
    title: { text: "巡回シフトの制限は軌道の元の個数より 1 つ少ない個数の互換の合成である" },
    labels: ["claim_orbit_transposition_composite_is_shift"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_eq_rowShiftRestriction",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.composite_eq_of_values",
      "Ising2DLambda.AlgebraicEigenvalue.orbitTranspositionComposite_eq_rowShiftRestriction_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-transposition-composite-is-shift"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_0\in O`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`\Psi^{O,\tau_0}_{\lvert O\rvert-1}=S\!\restriction_{O}`),
      paragraph([
        "である（",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " は ",
        ref("def_orbit_transposition_composite"),
        "、",
        math(String.raw`S\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        " の制限で ",
        ref("claim_shift_orbit_preserving"),
        " により定まる）。実数体は現れない。",
      ]),
      paragraph([
        "左辺は ",
        math(String.raw`\lvert O\rvert-1`),
        " 個の互換を合成したものである（",
        ref("def_orbit_transposition_composite"),
        " の下付きの添字は合成した互換の個数である）。",
        "すなわちこの主張は、軌道の上の巡回シフトの制限が ",
        math(String.raw`\lvert O\rvert-1`),
        " 個の互換の合成として書けることを述べている。",
      ]),
      paragraph([
        "左辺の下付きの添字は ",
        math(String.raw`\tau_0`),
        " に依存しない一方、写像 ",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " 自体は基点 ",
        math(String.raw`\tau_0`),
        " に依存する。この主張は、",
        math(String.raw`k=\lvert O\rvert-1`),
        " と取ったものに限っては基点の取り方によらず同じ写像になることも述べている。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として ",
        math(String.raw`e:=e(\tau_0)`),
        " と置く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        math(String.raw`O\in\mathcal{O}_L`),
        " より ",
        math(String.raw`O=O(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が取れ（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_orbit_set"),
        "）、",
        math(String.raw`\tau_0\in O(\tau_1)`),
        " より ",
        math(String.raw`O(\tau_0)=O(\tau_1)=O`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_mem_eq"),
        "）。したがって ",
        ref("claim_row_config_orbit_card"),
        " より ",
        math(String.raw`\lvert O\rvert=\lvert O(\tau_0)\rvert=e`),
        " である。",
        ref("def_row_config_shift_minimal_period"),
        " より ",
        math(String.raw`e\ge1`),
        " なので ",
        math(String.raw`e-1\in\mathbb{N}`),
        " が定まり、",
        math(String.raw`e-1<e`),
        " である。",
      ]),
      paragraph([
        "2 つの写像はどちらも ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への写像なので、各点での値が一致することを示せばよい。",
        math(String.raw`\tau\in O`),
        " を任意に取る。",
        math(String.raw`O=O(\tau_0)`),
        " なので ",
        math(String.raw`\tau=S^{[k]}(\tau_0)`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在する（",
        ref("def_row_config_orbit"),
        "）。",
        math(String.raw`e\ge1`),
        " なので自然数の除法より ",
        math(String.raw`k=e\,q+r`),
        " かつ ",
        math(String.raw`r<e`),
        " を満たす ",
        math(String.raw`q,r\in\mathbb{N}`),
        " が取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tau
&=S^{[k]}(\tau_0)
&&(\because\ k\ \text{の取り方})\\
&=S^{[r+e\,q]}(\tau_0)
&&(\because\ k=e\,q+r)\\
&=S^{[r]}\bigl(S^{[e\,q]}(\tau_0)\bigr)
&&(\because\ \blkref{claim_row_config_shift_iterate_add})\\
&=S^{[r]}(\tau_0)
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{と}\ e\mid e\,q)
\end{aligned}`),
      paragraph([
        "である。以下 ",
        math(String.raw`r<e-1`),
        " の場合と ",
        math(String.raw`r=e-1`),
        " の場合に分ける（",
        math(String.raw`r<e`),
        " より ",
        math(String.raw`r>e-1`),
        " は起こらない）。",
      ]),
      paragraph([
        math(String.raw`r<e-1`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{e-1}(\tau)
&=\Psi^{O,\tau_0}_{e-1}\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \text{上の式変形})\\
&=S^{[r+1]}(\tau_0)
&&(\because\ \blkref{claim_orbit_transposition_composite_values}\ \text{の第 1 の場合。}\ e-1<e,\ r<e)\\
&=S\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S(\tau)
&&(\because\ \text{上の式変形})\\
&=\bigl(S\!\restriction_{O}\bigr)(\tau)
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        math(String.raw`r=e-1`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Psi^{O,\tau_0}_{e-1}(\tau)
&=\Psi^{O,\tau_0}_{e-1}\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \text{上の式変形})\\
&=\tau_0
&&(\because\ \blkref{claim_orbit_transposition_composite_values}\ \text{の第 2 の場合。}\ e-1<e,\ r<e)\\
&=S^{[e]}(\tau_0)
&&(\because\ \blkref{claim_row_config_shift_period_divides}\ \text{と}\ e\mid e)\\
&=S^{[r+1]}(\tau_0)
&&(\because\ r=e-1\ \text{と}\ e\ge1\ \text{より}\ r+1=e)\\
&=S\bigl(S^{[r]}(\tau_0)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[k+1]}=S\circ S^{[k]})\\
&=S(\tau)
&&(\because\ \text{上の式変形})\\
&=\bigl(S\!\restriction_{O}\bigr)(\tau)
&&(\because\ \blkref{def_orbit_restriction})
\end{aligned}`),
      paragraph([
        "である。どちらの場合も ",
        math(String.raw`\Psi^{O,\tau_0}_{e-1}(\tau)=\bigl(S\!\restriction_{O}\bigr)(\tau)`),
        " であり、",
        math(String.raw`\tau`),
        " は任意だったので ",
        math(String.raw`\Psi^{O,\tau_0}_{e-1}=S\!\restriction_{O}`),
        " である。",
        math(String.raw`\lvert O\rvert=e`),
        " なのでこれが示すべき等式である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合、その上の写像と数え上げ、および ",
        math(String.raw`\mathbb{N}`),
        " の大小と除法だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_permutation_sign_mul",
    kind: "claim",
    title: { text: "軌道の上の全単射の符号は合成について乗法的である" },
    labels: ["claim_orbit_permutation_sign_mul"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_comp",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.signOn_comp",
      "Ising2DLambda.AlgebraicEigenvalue.orbitPermSign_comp_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-permutation-sign-mul"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\psi_1,\psi_2\in\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）を任意に取る。このとき ",
        math(String.raw`\psi_1\circ\psi_2\in\mathfrak{B}_{O}`),
        " であり、",
      ]),
      displayMath(
        String.raw`\mathrm{sgn}_{O}(\psi_1\circ\psi_2)=\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)`,
      ),
      paragraph([
        "が成り立つ（",
        ref("def_orbit_permutation_sign"),
        "）。両辺は ",
        math(String.raw`\mathbb{Z}`),
        " の元であり、実数体は現れない。",
      ]),
      paragraph([
        "これは ",
        ref("claim_permutation_sign_mul"),
        " を、台を ",
        math(String.raw`P_L`),
        " から ",
        math(String.raw`F(O,O)`),
        "（",
        ref("def_orbit_inversion_count"),
        "）へ取り替えて写したものである。",
        math(String.raw`\mathrm{sgn}_{O}`),
        " と ",
        math(String.raw`\mathrm{sgn}`),
        " は定義域の違う別の写像なので、前者についての言明として別に示す。",
      ]),
    ],
    proof: [
      paragraph([
        "準備の第一。",
        math(String.raw`\psi_1\circ\psi_2`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である。実際、",
        math(String.raw`\psi_1(\psi_2(\tau))=\psi_1(\psi_2(\tau'))`),
        " ならば ",
        math(String.raw`\psi_1`),
        " の単射性から ",
        math(String.raw`\psi_2(\tau)=\psi_2(\tau')`),
        " が出て、",
        math(String.raw`\psi_2`),
        " の単射性から ",
        math(String.raw`\tau=\tau'`),
        " である。また ",
        math(String.raw`\tau''\in O`),
        " に対し ",
        math(String.raw`\psi_1`),
        " の全射性から ",
        math(String.raw`\psi_1(\upsilon)=\tau''`),
        " を満たす ",
        math(String.raw`\upsilon\in O`),
        " が取れ、",
        math(String.raw`\psi_2`),
        " の全射性から ",
        math(String.raw`\psi_2(\tau)=\upsilon`),
        " を満たす ",
        math(String.raw`\tau\in O`),
        " が取れる。よって ",
        math(String.raw`\psi_1\circ\psi_2\in\mathfrak{B}_{O}`),
        " である（",
        ref("def_orbit_bijection_set"),
        "）。",
      ]),
      paragraph([
        "準備の第二。",
        math(String.raw`\psi_2`),
        " が定める写像 ",
        math(String.raw`\mathrm{srt}_{\psi_2}:F(O,O)\to F(O,O)`),
        " を",
      ]),
      displayMath(String.raw`\mathrm{srt}_{\psi_2}(\tau,\tau'):=
\begin{cases}
\bigl(\psi_2(\tau),\psi_2(\tau')\bigr) & \bigl(\psi_2(\tau)\prec\psi_2(\tau')\ \text{のとき}\bigr)\\
\bigl(\psi_2(\tau'),\psi_2(\tau)\bigr) & \bigl(\psi_2(\tau')\prec\psi_2(\tau)\ \text{のとき}\bigr)
\end{cases}`),
      paragraph([
        "で定める（記号 ",
        math(String.raw`\mathrm{srt}`),
        " は、像の 2 成分を ",
        math(String.raw`\prec`),
        " について並べ直すことを表す名前である）。これが定まることを見る。",
        math(String.raw`(\tau,\tau')\in F(O,O)`),
        " なら ",
        math(String.raw`\tau\prec\tau'`),
        " なので ",
        ref("claim_row_config_order_linear"),
        " の三分律から ",
        math(String.raw`\tau\ne\tau'`),
        " であり、",
        math(String.raw`\psi_2`),
        " が単射なので ",
        math(String.raw`\psi_2(\tau)\ne\psi_2(\tau')`),
        " である。ふたたび三分律から ",
        math(String.raw`\psi_2(\tau)\prec\psi_2(\tau')`),
        " と ",
        math(String.raw`\psi_2(\tau')\prec\psi_2(\tau)`),
        " のちょうど一方が成り立つ。",
        math(String.raw`\psi_2`),
        " の値は ",
        math(String.raw`O`),
        " に属するので、どちらの場合も右辺は ",
        math(String.raw`F(O,O)`),
        " の元である（",
        ref("def_cross_orbit_ordered_pairs"),
        " で ",
        math(String.raw`O'=O`),
        " と取ったもの）。",
      ]),
      paragraph([
        "準備の第三。",
        math(String.raw`\mathrm{srt}_{\psi_2}`),
        " は全単射である。実際、",
        math(String.raw`\psi_2`),
        " の逆写像 ",
        math(String.raw`\psi_2^{-1}`),
        " から同じ作り方で得られる写像 ",
        math(String.raw`\mathrm{srt}_{\psi_2^{-1}}:F(O,O)\to F(O,O)`),
        " が逆写像になる。",
        math(String.raw`(\tau,\tau')\in F(O,O)`),
        " について、",
        math(String.raw`\psi_2(\tau)\prec\psi_2(\tau')`),
        " の場合は ",
        math(String.raw`\mathrm{srt}_{\psi_2}(\tau,\tau')=(\psi_2(\tau),\psi_2(\tau'))`),
        " であり、その 2 成分を ",
        math(String.raw`\psi_2^{-1}`),
        " で戻すと ",
        math(String.raw`\tau,\tau'`),
        " で、",
        math(String.raw`\tau\prec\tau'`),
        " なので ",
        math(String.raw`\mathrm{srt}_{\psi_2^{-1}}(\mathrm{srt}_{\psi_2}(\tau,\tau'))=(\tau,\tau')`),
        " である。",
        math(String.raw`\psi_2(\tau')\prec\psi_2(\tau)`),
        " の場合は ",
        math(String.raw`\mathrm{srt}_{\psi_2}(\tau,\tau')=(\psi_2(\tau'),\psi_2(\tau))`),
        " であり、その 2 成分を ",
        math(String.raw`\psi_2^{-1}`),
        " で戻すと ",
        math(String.raw`\tau',\tau`),
        " で、やはり ",
        math(String.raw`\tau\prec\tau'`),
        " なので ",
        math(String.raw`\mathrm{srt}_{\psi_2^{-1}}(\mathrm{srt}_{\psi_2}(\tau,\tau'))=(\tau,\tau')`),
        " である。",
        math(String.raw`\psi_2`),
        " と ",
        math(String.raw`\psi_2^{-1}`),
        " を入れ替えれば同じ議論で ",
        math(String.raw`\mathrm{srt}_{\psi_2}(\mathrm{srt}_{\psi_2^{-1}}(\tau,\tau'))=(\tau,\tau')`),
        " が出る。",
      ]),
      paragraph([
        "以上を準備として、",
        math(String.raw`F(O,O)`),
        " の 3 つの部分集合",
      ]),
      displayMath(String.raw`\begin{aligned}
A&:=\bigl\{\,(\tau,\tau')\in F(O,O) \bigm| (\psi_1\circ\psi_2)(\tau')\prec(\psi_1\circ\psi_2)(\tau)\,\bigr\},\\
B&:=\bigl\{\,(\tau,\tau')\in F(O,O) \bigm| \psi_2(\tau')\prec\psi_2(\tau)\,\bigr\},\\
C&:=\bigl\{\,(\tau,\tau')\in F(O,O) \bigm| \psi_1\bigl(\mathrm{srt}_{\psi_2}(\tau,\tau')_2\bigr)\prec\psi_1\bigl(\mathrm{srt}_{\psi_2}(\tau,\tau')_1\bigr)\,\bigr\}
\end{aligned}`),
      paragraph([
        "を置く（",
        math(String.raw`(\upsilon,\upsilon')_1:=\upsilon`),
        "、",
        math(String.raw`(\upsilon,\upsilon')_2:=\upsilon'`),
        " は対の成分を取り出す記号である）。",
        ref("def_orbit_inversion_count"),
        " の転倒数の定義から ",
        math(String.raw`|A|=\mathrm{inv}_{O}(\psi_1\circ\psi_2)`),
        " と ",
        math(String.raw`|B|=\mathrm{inv}_{O}(\psi_2)`),
        " である。また ",
        math(String.raw`C`),
        " は ",
        math(String.raw`\mathrm{srt}_{\psi_2}`),
        " による ",
        math(String.raw`\{(\upsilon,\upsilon')\in F(O,O)\mid\psi_1(\upsilon')\prec\psi_1(\upsilon)\}`),
        " の逆像であり、",
        math(String.raw`\mathrm{srt}_{\psi_2}`),
        " が全単射なので ",
        math(String.raw`|C|=\mathrm{inv}_{O}(\psi_1)`),
        " である。",
      ]),
      paragraph([
        "各 ",
        math(String.raw`(\tau,\tau')\in F(O,O)`),
        " について、",
        math(String.raw`A,B,C`),
        " のうちその対が属するものの個数は偶数である。場合を分けて確かめる。",
      ]),
      paragraph([
        math(String.raw`\psi_2(\tau)\prec\psi_2(\tau')`),
        " の場合。三分律から ",
        math(String.raw`\psi_2(\tau')\prec\psi_2(\tau)`),
        " は成り立たないので、その対は ",
        math(String.raw`B`),
        " に属さない。このとき ",
        math(String.raw`\mathrm{srt}_{\psi_2}(\tau,\tau')=(\psi_2(\tau),\psi_2(\tau'))`),
        " なので ",
        math(String.raw`C`),
        " の条件は ",
        math(String.raw`\psi_1(\psi_2(\tau'))\prec\psi_1(\psi_2(\tau))`),
        " であり、これは ",
        math(String.raw`A`),
        " の条件と同じである。よって属するものの個数は ",
        math(String.raw`0`),
        " 個か ",
        math(String.raw`2`),
        " 個であり、いずれも偶数である。",
      ]),
      paragraph([
        math(String.raw`\psi_2(\tau')\prec\psi_2(\tau)`),
        " の場合。その対は ",
        math(String.raw`B`),
        " に属する。このとき ",
        math(String.raw`\mathrm{srt}_{\psi_2}(\tau,\tau')=(\psi_2(\tau'),\psi_2(\tau))`),
        " なので ",
        math(String.raw`C`),
        " の条件は ",
        math(String.raw`\psi_1(\psi_2(\tau))\prec\psi_1(\psi_2(\tau'))`),
        " である。",
        math(String.raw`\tau\ne\tau'`),
        " と ",
        math(String.raw`\psi_1\circ\psi_2`),
        " が単射であることから ",
        math(String.raw`\psi_1(\psi_2(\tau))\ne\psi_1(\psi_2(\tau'))`),
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
        math(String.raw`F(O,O)`),
        " の部分集合 ",
        math(String.raw`X`),
        " に対して写像 ",
        math(String.raw`f_X:F(O,O)\to\mathbb{Z}`),
        " を",
      ]),
      displayMath(String.raw`f_X(\tau,\tau'):=
\begin{cases}
-1 & \bigl((\tau,\tau')\in X\ \text{のとき}\bigr)\\
+1 & \bigl((\tau,\tau')\notin X\ \text{のとき}\bigr)
\end{cases}`),
      paragraph([
        "で定める。いま見たことは、各 ",
        math(String.raw`(\tau,\tau')\in F(O,O)`),
        " について ",
        math(String.raw`f_A(\tau,\tau')\cdot f_C(\tau,\tau')\cdot f_B(\tau,\tau')=1`),
        " が成り立つことを言っている（",
        math(String.raw`-1`),
        " が偶数個掛かるからである）。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi_1\circ\psi_2)\cdot\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)
&=(-1)^{\mathrm{inv}_{O}(\psi_1\circ\psi_2)}\cdot(-1)^{\mathrm{inv}_{O}(\psi_1)}\cdot(-1)^{\mathrm{inv}_{O}(\psi_2)}
&&(\because\ \blkref{def_orbit_permutation_sign})\\
&=(-1)^{|A|}\cdot(-1)^{|C|}\cdot(-1)^{|B|}
&&(\because\ |A|=\mathrm{inv}_{O}(\psi_1\circ\psi_2),\ |C|=\mathrm{inv}_{O}(\psi_1),\ |B|=\mathrm{inv}_{O}(\psi_2))\\
&=\prod_{(\tau,\tau')\in F(O,O)}f_A(\tau,\tau')\cdot\prod_{(\tau,\tau')\in F(O,O)}f_C(\tau,\tau')\cdot\prod_{(\tau,\tau')\in F(O,O)}f_B(\tau,\tau')
&&(\because\ \text{属するときだけ}\ -1\ \text{を掛けた有限積は}\ (-1)\ \text{の個数乗})\\
&=\prod_{(\tau,\tau')\in F(O,O)}\bigl(f_A(\tau,\tau')\cdot f_C(\tau,\tau')\cdot f_B(\tau,\tau')\bigr)
&&(\because\ \text{有限積の各因子ごとのまとめ})\\
&=\prod_{(\tau,\tau')\in F(O,O)}1
&&(\because\ \text{属するものの個数が偶数})\\
&=1
&&(\because\ 1\ \text{の有限積は}\ 1)
\end{aligned}`),
      paragraph([
        "である。これを使って",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}(\psi_1\circ\psi_2)
&=\mathrm{sgn}_{O}(\psi_1\circ\psi_2)\cdot1\cdot1\\
&=\mathrm{sgn}_{O}(\psi_1\circ\psi_2)\cdot\bigl(\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_1)\bigr)\cdot\bigl(\mathrm{sgn}_{O}(\psi_2)\cdot\mathrm{sgn}_{O}(\psi_2)\bigr)
&&(\because\ \blkref{claim_orbit_permutation_sign_values}\ \text{の第二の主張})\\
&=\bigl(\mathrm{sgn}_{O}(\psi_1\circ\psi_2)\cdot\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)\bigr)\cdot\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)\\
&=1\cdot\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)
&&(\because\ \text{直前の等式})\\
&=\mathrm{sgn}_{O}(\psi_1)\cdot\mathrm{sgn}_{O}(\psi_2)
&&(\because\ 1\ \text{は乗法の単位元})
\end{aligned}`),
      paragraph(["を得る。"]),
      paragraph([
        "以上で使ったのは、",
        math(String.raw`\prec`),
        " の三分律、",
        math(String.raw`O`),
        " の上の全単射が単射であること、有限集合の数え上げ、そして整数の積だけである。",
        ref("claim_row_config_order_linear"),
        " の推移律は一度も使っていない。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_transposition_composite_sign",
    kind: "claim",
    title: { text: "互換の反復合成の符号は -1 の反復の回数乗である" },
    labels: ["claim_orbit_transposition_composite_sign"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.ambientComposite_sign",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.value_of_iterated_step",
      "Ising2DLambda.AlgebraicEigenvalue.ambientComposite_sign_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-transposition-composite-sign"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau_0\in O`),
        " を任意に取り、",
        math(String.raw`\tau_0`),
        " の最小周期を ",
        math(String.raw`e(\tau_0)`),
        " と書く（",
        ref("def_row_config_shift_minimal_period"),
        "）。",
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k<e(\tau_0)`),
        " を満たすならば",
      ]),
      displayMath(String.raw`\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)=(-1)^{k}`),
      paragraph([
        "である（",
        math(String.raw`\Psi^{O,\tau_0}_{k}`),
        " は ",
        ref("def_orbit_transposition_composite"),
        "、",
        math(String.raw`\mathrm{sgn}_{O}`),
        " は ",
        ref("def_orbit_permutation_sign"),
        "）。左辺が定まるのは ",
        math(String.raw`\Psi^{O,\tau_0}_{k}\in\mathfrak{B}_{O}`),
        " による（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_transposition_composite_bijective"),
        "）。両辺は ",
        math(String.raw`\mathbb{Z}`),
        " の元であり、実数体は現れない。",
      ]),
      paragraph([
        "上界の条件 ",
        math(String.raw`k<e(\tau_0)`),
        " は外せない。",
        math(String.raw`k=e(\tau_0)`),
        " のとき合成する互換は ",
        math(String.raw`t^{O}_{\tau_0,\tau_0}`),
        " すなわち恒等写像であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_transposition"),
        "、",
        ref("def_row_config_shift_minimal_period"),
        "）、符号は ",
        math(String.raw`-1`),
        " 倍されないからである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備の第一。",
        math(String.raw`j\in\mathbb{N}`),
        " が ",
        math(String.raw`1\le j`),
        " と ",
        math(String.raw`j<e(\tau_0)`),
        " を満たすならば ",
        math(String.raw`\tau_0\neq S^{[j]}(\tau_0)`),
        " である。実際、",
        math(String.raw`\tau_0=S^{[j]}(\tau_0)`),
        " と仮定すると ",
        math(String.raw`S^{[0]}(\tau_0)=\tau_0=S^{[j]}(\tau_0)`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_shift_iterate"),
        "）、",
        math(String.raw`0<e(\tau_0)`),
        " と ",
        math(String.raw`j<e(\tau_0)`),
        " から ",
        math(String.raw`0=j`),
        " が出る（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_shift_iterate_distinct_below_period"),
        "）。これは ",
        math(String.raw`1\le j`),
        " に反する。",
      ]),
      paragraph([
        "準備の第二。",
        math(String.raw`\tau_a\in O`),
        " と ",
        math(String.raw`\tau_b\in O`),
        " が ",
        math(String.raw`\tau_a\neq\tau_b`),
        " を満たすならば ",
        math(String.raw`\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)=-1`),
        " である。",
        math(String.raw`\tau_a\prec\tau_b`),
        " と ",
        math(String.raw`\tau_b\prec\tau_a`),
        " のちょうど一方が成り立つので（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_order_linear"),
        " の三分律）、2 つの場合に分ける。",
      ]),
      paragraph([
        math(String.raw`\tau_a\prec\tau_b`),
        " の場合は ",
        ref("claim_orbit_transposition_sign"),
        " の第二の主張そのものである。",
      ]),
      paragraph([
        math(String.raw`\tau_b\prec\tau_a`),
        " の場合。まず 2 つの互換が写像として一致すること、すなわち任意の ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`t_{\tau_a,\tau_b}(\tau)=t_{\tau_b,\tau_a}(\tau)`),
        " であることを、",
        ref("def_orbit_transposition"),
        " の 3 つの場合で見る。",
        math(String.raw`\tau=\tau_a`),
        " のとき、左辺は第 1 の場合で ",
        math(String.raw`\tau_b`),
        "、右辺は ",
        math(String.raw`\tau\neq\tau_b`),
        "（",
        math(String.raw`\because`),
        " ",
        math(String.raw`\tau_a\neq\tau_b`),
        "）かつ ",
        math(String.raw`\tau=\tau_a`),
        " なので第 2 の場合で ",
        math(String.raw`\tau_b`),
        " である。",
        math(String.raw`\tau\neq\tau_a`),
        " かつ ",
        math(String.raw`\tau=\tau_b`),
        " のとき、左辺は第 2 の場合で ",
        math(String.raw`\tau_a`),
        "、右辺は第 1 の場合で ",
        math(String.raw`\tau_a`),
        " である。",
        math(String.raw`\tau\neq\tau_a`),
        " かつ ",
        math(String.raw`\tau\neq\tau_b`),
        " のとき、どちらも第 3 の場合で ",
        math(String.raw`\tau`),
        " である。よって ",
        math(String.raw`t^{O}_{\tau_a,\tau_b}=t^{O}_{\tau_b,\tau_a}`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_a,\tau_b}\bigr)
&=\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_b,\tau_a}\bigr)
&&(\because\ \text{2 つの互換は写像として一致する})\\
&=-1
&&(\because\ \blkref{claim_orbit_transposition_sign}\ \text{の第二の主張と}\ \tau_b\prec\tau_a)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([
        "そのうえで ",
        math(String.raw`k`),
        " についての帰納法で示す。示す言明は「",
        math(String.raw`k<e(\tau_0)`),
        " ならば ",
        math(String.raw`\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)=(-1)^{k}`),
        "」である。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{0}\bigr)
&=\mathrm{sgn}_{O}\bigl(\mathrm{id}_{O}\bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=+1
&&(\because\ \blkref{claim_orbit_permutation_sign_values}\ \text{の第三の主張})\\
&=(-1)^{0}
&&(\because\ \text{整数の}\ 0\ \text{乗は}\ 1)
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " について成り立つと仮定して ",
        math(String.raw`k+1`),
        " について示す。",
        math(String.raw`k+1<e(\tau_0)`),
        " とする。",
        math(String.raw`k<k+1`),
        " なので ",
        math(String.raw`k<e(\tau_0)`),
        " であり、帰納法の仮定が使える。また ",
        math(String.raw`1\le k+1`),
        " と ",
        math(String.raw`k+1<e(\tau_0)`),
        " から ",
        math(String.raw`\tau_0\neq S^{[k+1]}(\tau_0)`),
        " である（",
        math(String.raw`\because`),
        " 準備の第一）。",
        math(String.raw`\tau_0\in O`),
        " と ",
        math(String.raw`S^{[k+1]}(\tau_0)\in O`),
        " は ",
        ref("def_orbit_transposition_composite"),
        " で見たとおりであり、",
        math(String.raw`t^{O}_{\tau_0,S^{[k+1]}(\tau_0)}\in\mathfrak{B}_{O}`),
        "（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_transposition_bijective"),
        " の第三の主張）、",
        math(String.raw`\Psi^{O,\tau_0}_{k}\in\mathfrak{B}_{O}`),
        "（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_transposition_composite_bijective"),
        "）である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k+1}\bigr)
&=\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}\circ\Psi^{O,\tau_0}_{k}\bigr)
&&(\because\ \blkref{def_orbit_transposition_composite})\\
&=\mathrm{sgn}_{O}\bigl(t^{O}_{\tau_0,\,S^{[k+1]}(\tau_0)}\bigr)\cdot\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)
&&(\because\ \blkref{claim_orbit_permutation_sign_mul})\\
&=(-1)\cdot\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{k}\bigr)
&&(\because\ \text{準備の第二と}\ \tau_0\neq S^{[k+1]}(\tau_0))\\
&=(-1)\cdot(-1)^{k}
&&(\because\ \text{帰納法の仮定})\\
&=(-1)^{k+1}
&&(\because\ \text{整数の冪の定義})
\end{aligned}`),
      paragraph([
        "以上で使ったのは、",
        math(String.raw`\prec`),
        " の三分律、有限集合の元の相等、そして整数の積だけである。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_shift_restriction_sign",
    kind: "claim",
    title: {
      text: "軌道の上の巡回シフトの制限の符号は -1 の (軌道の元の個数 - 1) 乗である",
    },
    labels: ["claim_orbit_shift_restriction_sign"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftOrbitRestriction_sign",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.value_at_top_of_iterated",
      "Ising2DLambda.AlgebraicEigenvalue.shiftOrbitRestriction_sign_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-shift-restriction-sign"],
    statement: [
      paragraph([
        math(String.raw`O\in\mathcal{O}_L`),
        " を任意に取る（",
        ref("def_row_config_orbit_set"),
        "）。このとき",
      ]),
      displayMath(String.raw`\mathrm{sgn}_{O}\bigl(S\!\restriction_{O}\bigr)=(-1)^{\lvert O\rvert-1}`),
      paragraph([
        "である（",
        math(String.raw`S\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        " の制限で ",
        ref("claim_shift_orbit_preserving"),
        " により定まり、",
        math(String.raw`\mathrm{sgn}_{O}`),
        " は ",
        ref("def_orbit_permutation_sign"),
        "）。",
        math(String.raw`\lvert O\rvert\ge1`),
        " なので ",
        math(String.raw`\lvert O\rvert-1\in\mathbb{N}`),
        " が定まる（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_partition"),
        " の第一の主張）。両辺は ",
        math(String.raw`\mathbb{Z}`),
        " の元であり、実数体は現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("claim_row_config_orbit_partition"),
        " の第一の主張より ",
        math(String.raw`O`),
        " は空でないので ",
        math(String.raw`\tau_0\in O`),
        " が取れる。",
        math(String.raw`O\in\mathcal{O}_L`),
        " より ",
        math(String.raw`O=O(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が取れ（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_orbit_set"),
        "）、",
        math(String.raw`\tau_0\in O(\tau_1)`),
        " より ",
        math(String.raw`O(\tau_0)=O(\tau_1)=O`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_mem_eq"),
        "）。したがって ",
        math(String.raw`\lvert O\rvert=\lvert O(\tau_0)\rvert=e(\tau_0)`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_card"),
        "）。",
        ref("def_row_config_shift_minimal_period"),
        " より ",
        math(String.raw`e(\tau_0)\ge1`),
        " なので ",
        math(String.raw`\lvert O\rvert-1<e(\tau_0)`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{sgn}_{O}\bigl(S\!\restriction_{O}\bigr)
&=\mathrm{sgn}_{O}\bigl(\Psi^{O,\tau_0}_{\lvert O\rvert-1}\bigr)
&&(\because\ \blkref{claim_orbit_transposition_composite_is_shift}\ \text{を右辺から左辺へ用いる})\\
&=(-1)^{\lvert O\rvert-1}
&&(\because\ \blkref{claim_orbit_transposition_composite_sign}\ \text{と}\ \lvert O\rvert-1<e(\tau_0))
\end{aligned}`),
      paragraph([
        "右辺は ",
        math(String.raw`\tau_0`),
        " を含まないので、この値は基点の取り方によらない。",
        "以上で使ったのは有限集合の数え上げと整数の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_factor_zero",
    kind: "claim",
    title: {
      text: "行の添字にもその像にも当たらない値を取る軌道の上の全単射の因子は零元である",
    },
    labels: ["claim_orbit_factor_zero"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.orbitFactor_eq_zero_of_entry_zero",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-factor-zero"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\psi\in\mathfrak{B}_{O}`),
        "（",
        ref("def_orbit_bijection_set"),
        "）を任意に取る。",
        math(String.raw`\psi(\tau_1)\ne\tau_1`),
        " かつ ",
        math(String.raw`\psi(\tau_1)\ne S(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in O`),
        " が存在するならば",
      ]),
      displayMath(String.raw`W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)=\iota\bigl(\kappa(0)\bigr)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
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
        "すなわちこの因子は零元であり、",
        ref("claim_shift_char_orbit_product"),
        " の軌道ごとの和に寄与しない。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体は現れない。",
      ]),
      paragraph([
        ref("claim_shift_char_term_zero"),
        " は同じことを台 ",
        math(String.raw`R_L`),
        " の上の置換について述べたものである。",
        "台が軌道 ",
        math(String.raw`O`),
        " に変わると項の形も符号の写像も変わる（",
        math(String.raw`\mathrm{sgn}`),
        " ではなく ",
        math(String.raw`\mathrm{sgn}_{O}`),
        " を使う）ので、別の主張として置き直す。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)
&=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\psi))\bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\psi(\tau)}
&&(\because\ \blkref{def_orbit_term_factor})\\
&=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\psi))\bigr)\cdot\mathrm{ch}(U)_{\tau_1,\psi(\tau_1)}\cdot\prod_{\tau\in O\setminus\{\tau_1\}}\mathrm{ch}(U)_{\tau,\psi(\tau)}
&&(\because\ \text{有限積から 1 つの因子を括り出す})\\
&=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\psi))\bigr)\cdot\iota\bigl(\kappa(0)\bigr)\cdot\prod_{\tau\in O\setminus\{\tau_1\}}\mathrm{ch}(U)_{\tau,\psi(\tau)}
&&(\because\ \psi(\tau_1)\ne\tau_1\ \text{かつ}\ \psi(\tau_1)\ne S(\tau_1)\ \text{と}\ \blkref{claim_shift_char_matrix_entry_zero})\\
&=\iota\bigl(\kappa(0)\bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の零元を掛けると零元})
\end{aligned}`),
      paragraph([
        "である。第 3 の等号で ",
        ref("claim_shift_char_matrix_entry_zero"),
        " を当てられるのは、",
        math(String.raw`\tau_1\in O\subset R_L`),
        " かつ ",
        math(String.raw`\psi(\tau_1)\in O\subset R_L`),
        " であって、この主張が ",
        math(String.raw`R_L`),
        " の任意の 2 元についてのものだからである。",
      ]),
      paragraph([
        "この主張の対偶により、軌道ごとの和のうち零元でありうるものを除いて残るのは、",
        "任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\psi(\tau)=\tau`),
        " または ",
        math(String.raw`\psi(\tau)=S(\tau)`),
        " を満たす ",
        math(String.raw`\psi`),
        " の因子だけである。そのような ",
        math(String.raw`\psi`),
        " が ",
        math(String.raw`\mathrm{id}_{O}`),
        " と ",
        math(String.raw`S\!\restriction_{O}`),
        " の 2 つに限ることは ",
        ref("claim_orbit_bijection_id_or_shift"),
        " で既に示してある。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と有限集合 ",
        math(String.raw`R_L`),
        " とその部分集合だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_fixed_iff_card_one",
    kind: "claim",
    title: {
      text: "軌道の元が巡回シフトで動かないことと、その軌道の元の個数が 1 であることは同値である",
    },
    labels: ["claim_orbit_fixed_iff_card_one"],
    habitat: "N",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rowShift_eq_self_iff_card_orbit_eq_one",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.step_eq_self_iff_period_eq_one",
      "Ising2DLambda.AlgebraicEigenvalue.rowShift_eq_self_iff_card_orbit_eq_one_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-fixed-iff-card-one"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau\in O`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`S(\tau)=\tau\iff\lvert O\rvert=1`),
      paragraph([
        "が成り立つ（",
        math(String.raw`S`),
        " は ",
        ref("def_row_config_shift"),
        "）。",
        "両辺に現れるのは有限集合 ",
        math(String.raw`R_L`),
        " の元の相等と ",
        math(String.raw`\mathbb{N}`),
        " の元の相等だけであり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張は、シフト行列の特性行列の対角成分 ",
        math(String.raw`\mathrm{ch}(U)_{\tau,\tau}`),
        " を軌道ごとに決めるために要る。",
        ref("def_shift_matrix"),
        " の場合分けは ",
        math(String.raw`\tau=S(\tau)`),
        " か否かによっており、それが軌道の元の個数で判定できることをここで示す。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`O\in\mathcal{O}_L`),
        " より ",
        math(String.raw`O=O(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が取れ（",
        math(String.raw`\because`),
        " ",
        ref("def_row_config_orbit_set"),
        "）、",
        math(String.raw`\tau\in O(\tau_1)`),
        " より ",
        math(String.raw`O(\tau)=O(\tau_1)=O`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_orbit_mem_eq"),
        "）。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\lvert O\rvert
&=\lvert O(\tau)\rvert
&&(\because\ O=O(\tau))\\
&=e(\tau)
&&(\because\ \blkref{claim_row_config_orbit_card})
\end{aligned}`),
      paragraph([
        "である。また",
      ]),
      displayMath(String.raw`\begin{aligned}
S^{[1]}(\tau)
&=\bigl(S\circ S^{[0]}\bigr)(\tau)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ k=0\ \text{の場合})\\
&=S\bigl(\mathrm{id}_{R_L}(\tau)\bigr)
&&(\because\ \blkref{def_row_config_shift_iterate}\ \text{の}\ S^{[0]}=\mathrm{id}_{R_L})\\
&=S(\tau)
&&(\because\ \text{恒等写像の値})
\end{aligned}`),
      paragraph([
        "である。以下、この 2 つを準備として 2 つの向きを別々に示す。",
      ]),
      paragraph([
        "第一の向き。",
        math(String.raw`S(\tau)=\tau`),
        " を仮定する。準備の第二より ",
        math(String.raw`S^{[1]}(\tau)=S(\tau)=\tau`),
        " であるから、",
        math(String.raw`e(\tau)`),
        " は ",
        math(String.raw`1`),
        " を割り切る（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_shift_period_divides"),
        "）。すなわち ",
        math(String.raw`1=e(\tau)\,q`),
        " を満たす ",
        math(String.raw`q\in\mathbb{N}`),
        " が存在する。",
        math(String.raw`e(\tau)\ge1`),
        " かつ ",
        math(String.raw`q\ge1`),
        " なので（",
        math(String.raw`\because`),
        " どちらかが ",
        math(String.raw`0`),
        " なら積が ",
        math(String.raw`0`),
        " になる）、",
        math(String.raw`e(\tau)\ge2`),
        " とすると ",
        math(String.raw`e(\tau)\,q\ge2`),
        " となって ",
        math(String.raw`1=e(\tau)\,q`),
        " に反する。よって ",
        math(String.raw`e(\tau)=1`),
        " であり、準備の第一より ",
        math(String.raw`\lvert O\rvert=e(\tau)=1`),
        " である。",
      ]),
      paragraph([
        "第二の向き。",
        math(String.raw`\lvert O\rvert=1`),
        " を仮定する。準備の第一より ",
        math(String.raw`e(\tau)=\lvert O\rvert=1`),
        " であり、",
        math(String.raw`1=1\cdot1`),
        " なので ",
        math(String.raw`e(\tau)`),
        " は ",
        math(String.raw`1`),
        " を割り切る。よって ",
        math(String.raw`S^{[1]}(\tau)=\tau`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_shift_period_divides"),
        " を右辺から左辺へ用いる）、準備の第二より ",
        math(String.raw`S(\tau)=S^{[1]}(\tau)=\tau`),
        " である。",
      ]),
      paragraph([
        "以上で使ったのは有限集合 ",
        math(String.raw`R_L`),
        " の元の相等、その部分集合の元の個数、および ",
        math(String.raw`\mathbb{N}`),
        " の積と大小だけである。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_diagonal_entry",
    kind: "claim",
    title: {
      text: "シフト行列の特性行列の対角成分は、その軌道の元の個数で決まる",
    },
    labels: ["claim_shift_char_diagonal_entry"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_diag_of_two_le",
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_diag_of_card_one",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.entry_of_not_right",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.entry_of_right",
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_diag_of_two_le_from_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.charMatrix_shiftMatrix_diag_of_card_one_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-diagonal-entry"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）と ",
        math(String.raw`\tau\in O`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`\mathrm{ch}(U)_{\tau,\tau}=
\begin{cases}
t & (\lvert O\rvert\ge2\ \text{のとき})\\
t+\iota\bigl(-\kappa(1)\bigr) & (\lvert O\rvert=1\ \text{のとき})
\end{cases}`),
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
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        math(String.raw`\tau\in O`),
        " より ",
        math(String.raw`\lvert O\rvert\ge1`),
        " なので、この 2 つの場合はすべての場合を尽くしており、かつ重ならない。",
      ]),
      paragraph([
        "既に示した ",
        ref("claim_shift_char_matrix_entry_zero"),
        " は対角成分を扱っていない。ここで残りの成分のうち対角成分の値を決めることで、",
        "軌道ごとの因子に現れる恒等写像の項を計算できるようになる。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("def_characteristic_matrix"),
        " の ",
        math(String.raw`\tau=\tau'`),
        " の場合により",
      ]),
      displayMath(String.raw`\mathrm{ch}(U)_{\tau,\tau}=t+\iota\bigl(-U_{\tau,\tau}\bigr)`),
      paragraph([
        "である。以下、2 つの場合を別々に示す。",
      ]),
      paragraph([
        "第一の場合。",
        math(String.raw`\lvert O\rvert\ge2`),
        " を仮定する。このとき ",
        math(String.raw`\lvert O\rvert\ne1`),
        " なので ",
        math(String.raw`S(\tau)\ne\tau`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_fixed_iff_card_one"),
        " の対偶）。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ch}(U)_{\tau,\tau}
&=t+\iota\bigl(-U_{\tau,\tau}\bigr)
&&(\because\ \text{準備})\\
&=t+\iota\bigl(-\kappa(0)\bigr)
&&(\because\ \blkref{def_shift_matrix}\ \text{の}\ \tau\ne S(\tau)\ \text{の場合})\\
&=t+\iota\bigl(\kappa(0)\bigr)
&&(\because\ \kappa(0)\ \text{は}\ \mathbb{Z}[x]\ \text{の零元であり、零元の加法の逆元は零元})\\
&=t
&&(\because\ \blkref{def_second_constant_embedding}\ \text{より}\ \iota(\kappa(0))\ \text{は}\ \mathbb{Z}[x][t]\ \text{の零元})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第二の場合。",
        math(String.raw`\lvert O\rvert=1`),
        " を仮定する。このとき ",
        math(String.raw`S(\tau)=\tau`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_fixed_iff_card_one"),
        " を右辺から左辺へ用いる）。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ch}(U)_{\tau,\tau}
&=t+\iota\bigl(-U_{\tau,\tau}\bigr)
&&(\because\ \text{準備})\\
&=t+\iota\bigl(-\kappa(1)\bigr)
&&(\because\ \blkref{def_shift_matrix}\ \text{の}\ \tau=S(\tau)\ \text{の場合})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " と ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元、および有限集合 ",
        math(String.raw`O`),
        " の元の個数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_identity_factor",
    kind: "claim",
    title: {
      text: "恒等写像の因子は、その軌道の元の個数で決まる",
    },
    labels: ["claim_orbit_identity_factor"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_id_of_two_le",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_id_of_card_one",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.unitSignProd_eq_pow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.unitSignProd_eq_single",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_id_of_two_le_from_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_id_of_card_one_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-identity-factor"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）を任意に取り、",
        math(String.raw`\mathrm{id}_{O}`),
        " を ",
        math(String.raw`O`),
        " の上の恒等写像とする。このとき",
      ]),
      displayMath(String.raw`W_{O}\bigl(\mathrm{ch}(U),\mathrm{id}_{O}\bigr)=
\begin{cases}
t^{\lvert O\rvert} & (\lvert O\rvert\ge2\ \text{のとき})\\
t+\iota\bigl(-\kappa(1)\bigr) & (\lvert O\rvert=1\ \text{のとき})
\end{cases}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "右辺の ",
        math(String.raw`t^{\lvert O\rvert}`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`t`),
        " の自然数冪である。",
      ]),
      paragraph([
        ref("claim_orbit_factor_zero"),
        " により、軌道ごとの和で零元でありうるのは ",
        math(String.raw`\mathrm{id}_{O}`),
        " と ",
        math(String.raw`S\!\restriction_{O}`),
        " の因子だけである（",
        ref("claim_orbit_bijection_id_or_shift"),
        "）。ここでその一方、恒等写像の側の値を決める。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("claim_row_config_orbit_partition"),
        " の第一の主張より ",
        math(String.raw`O`),
        " は空でないので ",
        math(String.raw`\lvert O\rvert\ge1`),
        " であり、",
        math(String.raw`\lvert O\rvert\ge2`),
        " と ",
        math(String.raw`\lvert O\rvert=1`),
        " の 2 つの場合はすべての場合を尽くしており、かつ重ならない。",
        "また ",
        math(String.raw`\mathrm{id}_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射なので ",
        math(String.raw`\mathrm{id}_{O}\in\mathfrak{B}_{O}`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_bijection_set"),
        "）。",
      ]),
      paragraph([
        "まず両方の場合に共通する段を出す。",
      ]),
      displayMath(String.raw`\begin{aligned}
W_{O}\bigl(\mathrm{ch}(U),\mathrm{id}_{O}\bigr)
&=\iota\bigl(\kappa(\mathrm{sgn}_{O}(\mathrm{id}_{O}))\bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\mathrm{id}_{O}(\tau)}
&&(\because\ \blkref{def_orbit_term_factor})\\
&=\iota\bigl(\kappa(1)\bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\mathrm{id}_{O}(\tau)}
&&(\because\ \blkref{claim_orbit_permutation_sign_values}\ \text{の第 3 の主張})\\
&=\iota\bigl(\kappa(1)\bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\tau}
&&(\because\ \mathrm{id}_{O}(\tau)=\tau)\\
&=\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\tau}
&&(\because\ \blkref{def_second_constant_embedding}\ \text{より}\ \iota(\kappa(1))\ \text{は}\ \mathbb{Z}[x][t]\ \text{の単位元})
\end{aligned}`),
      paragraph([
        "である。以下、2 つの場合を別々に示す。",
      ]),
      paragraph([
        "第一の場合。",
        math(String.raw`\lvert O\rvert\ge2`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\tau}
&=\prod_{\tau\in O}t
&&(\because\ \blkref{claim_shift_char_diagonal_entry}\ \text{の第一の場合を各}\ \tau\in O\ \text{へ当てる})\\
&=t^{\lvert O\rvert}
&&(\because\ \text{等しい因子の有限積は、因子の個数を指数とする冪である})
\end{aligned}`),
      paragraph([
        "である。第 2 の等号で使った「等しい因子の有限積は、因子の個数を指数とする冪である」は、",
        math(String.raw`O`),
        " の元の個数についての帰納法で出る（空の積は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元、",
        math(String.raw`t^{0}`),
        " も単位元であり、これが出発点である。1 つ元を足す段は ",
        math(String.raw`t^{k+1}=t^{k}\cdot t`),
        " による）。",
      ]),
      paragraph([
        "第二の場合。",
        math(String.raw`\lvert O\rvert=1`),
        " を仮定する。このとき ",
        math(String.raw`O=\{\tau_1\}`),
        " を満たす ",
        math(String.raw`\tau_1\in O`),
        " が取れる（",
        math(String.raw`\because`),
        " 元の個数が ",
        math(String.raw`1`),
        " である有限集合は 1 元集合である）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,\tau}
&=\mathrm{ch}(U)_{\tau_1,\tau_1}
&&(\because\ \text{1 元集合にわたる有限積は 1 つの因子である})\\
&=t+\iota\bigl(-\kappa(1)\bigr)
&&(\because\ \blkref{claim_shift_char_diagonal_entry}\ \text{の第二の場合を}\ \tau_1\in O\ \text{へ当てる})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と有限集合 ",
        math(String.raw`O`),
        " の元の個数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_shift_restriction_factor",
    kind: "claim",
    title: {
      text: "軌道の元の個数が 2 以上のとき、巡回シフトの制限の因子は単位元の加法についての逆元である",
    },
    labels: ["claim_orbit_shift_restriction_factor"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_shift_of_two_le",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.signedProd_eq_unit",
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_shift_of_two_le_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-shift-restriction-factor"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）を任意に取り、",
        math(String.raw`\lvert O\rvert\ge2`),
        " を仮定する。このとき",
      ]),
      displayMath(
        String.raw`W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)=\iota\bigl(-\kappa(1)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`S\!\restriction_{O}`),
        " は ",
        ref("def_orbit_restriction"),
        " の制限で ",
        ref("claim_shift_orbit_preserving"),
        " により定まり、",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "右辺の ",
        math(String.raw`\iota(-\kappa(1))`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元 ",
        math(String.raw`\iota(\kappa(1))`),
        " の加法についての逆元である。",
      ]),
      paragraph([
        ref("claim_orbit_factor_zero"),
        " と ",
        ref("claim_orbit_bijection_id_or_shift"),
        " により、軌道ごとの和で零元でありうるのは ",
        math(String.raw`\mathrm{id}_{O}`),
        " と ",
        math(String.raw`S\!\restriction_{O}`),
        " の因子だけである。その一方は ",
        ref("claim_orbit_identity_factor"),
        " で決めた。ここで残りの一方、巡回シフトの制限の側の値を決める。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        math(String.raw`\lvert O\rvert=1`),
        " を除いてあるのは、その場合に ",
        math(String.raw`S\!\restriction_{O}`),
        " と ",
        math(String.raw`\mathrm{id}_{O}`),
        " が写像として一致し、この主張が ",
        ref("claim_orbit_identity_factor"),
        " の第二の場合と食い違うためである",
        "（そのときの値は ",
        math(String.raw`t+\iota(-\kappa(1))`),
        " であって ",
        math(String.raw`\iota(-\kappa(1))`),
        " ではない）。",
      ]),
    ],
    proof: [
      paragraph([
        "準備を 4 つ置く。以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`S`),
        " は軌道を保つ置換なので（",
        math(String.raw`\because`),
        " ",
        ref("claim_shift_orbit_preserving"),
        "）その制限 ",
        math(String.raw`S\!\restriction_{O}`),
        " が定まり、それは ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_restriction_bijective"),
        "）。したがって ",
        math(String.raw`S\!\restriction_{O}\in\mathfrak{B}_{O}`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_bijection_set"),
        "）、",
        math(String.raw`W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)`),
        " が定まっている。",
      ]),
      paragraph([
        "第二に、",
        ref("def_constant_polynomial"),
        " より ",
        math(String.raw`\kappa`),
        " は和を保つので ",
        math(String.raw`\kappa(-1)=-\kappa(1)`),
        " であり、したがって ",
        math(String.raw`\iota\bigl(\kappa(-1)\bigr)=u`),
        " である。",
      ]),
      paragraph([
        "第三に、任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`\lvert O\rvert\ne1`),
        " なので ",
        math(String.raw`S(\tau)\ne\tau`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_fixed_iff_card_one"),
        " の対偶）、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ch}(U)_{\tau,S(\tau)}
&=\iota\bigl(-U_{\tau,S(\tau)}\bigr)
&&(\because\ \blkref{def_characteristic_matrix}\ \text{の}\ \tau\ne\tau'\ \text{の場合})\\
&=\iota\bigl(-\kappa(1)\bigr)
&&(\because\ \blkref{def_shift_matrix}\ \text{の}\ \tau'=S(\tau)\ \text{の場合})\\
&=u
&&(\because\ u\ \text{の置き方})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第四に、",
      ]),
      displayMath(String.raw`\begin{aligned}
u\cdot u
&=\iota\bigl(-\kappa(1)\bigr)\cdot\iota\bigl(-\kappa(1)\bigr)
&&(\because\ u\ \text{の置き方})\\
&=\iota\Bigl(\bigl(-\kappa(1)\bigr)\cdot\bigl(-\kappa(1)\bigr)\Bigr)
&&(\because\ \blkref{def_second_constant_embedding}\ \text{より}\ \iota\ \text{は積を保つ})\\
&=\iota\bigl(\kappa(1)\cdot\kappa(1)\bigr)
&&(\because\ \mathbb{Z}[x]\ \text{の中で加法の逆元どうしの積はもとの元どうしの積に等しい})\\
&=\iota\bigl(\kappa(1)\bigr)
&&(\because\ \blkref{def_constant_polynomial}\ \text{より}\ \kappa(1)\ \text{は}\ \mathbb{Z}[x]\ \text{の単位元})
\end{aligned}`),
      paragraph([
        "であり、",
        ref("def_second_constant_embedding"),
        " より ",
        math(String.raw`\iota(\kappa(1))`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元である。",
      ]),
      paragraph([
        "以上のもとで、",
      ]),
      displayMath(String.raw`\begin{aligned}
W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)
&=\iota\Bigl(\kappa\bigl(\mathrm{sgn}_{O}(S\!\restriction_{O})\bigr)\Bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,(S\restriction_{O})(\tau)}
&&(\because\ \blkref{def_orbit_term_factor})\\
&=\iota\Bigl(\kappa\bigl((-1)^{\lvert O\rvert-1}\bigr)\Bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,(S\restriction_{O})(\tau)}
&&(\because\ \blkref{claim_orbit_shift_restriction_sign})\\
&=\iota\Bigl(\kappa\bigl((-1)^{\lvert O\rvert-1}\bigr)\Bigr)\cdot\prod_{\tau\in O}\mathrm{ch}(U)_{\tau,S(\tau)}
&&(\because\ \blkref{def_orbit_restriction}\ \text{より}\ (S\!\restriction_{O})(\tau)=S(\tau))\\
&=\iota\Bigl(\kappa\bigl((-1)^{\lvert O\rvert-1}\bigr)\Bigr)\cdot\prod_{\tau\in O}u
&&(\because\ \text{準備の第三})\\
&=\iota\Bigl(\kappa\bigl((-1)^{\lvert O\rvert-1}\bigr)\Bigr)\cdot u^{\lvert O\rvert}
&&(\because\ \text{等しい因子の有限積は、因子の個数を指数とする冪である})\\
&=\Bigl(\iota\bigl(\kappa(-1)\bigr)\Bigr)^{\lvert O\rvert-1}\cdot u^{\lvert O\rvert}
&&(\because\ \blkref{claim_const_embedding_prod}\ \text{を}\ \lvert O\rvert-1\ \text{個の添字それぞれに}\ n_i=-1\ \text{を取って当てる})\\
&=u^{\lvert O\rvert-1}\cdot u^{\lvert O\rvert}
&&(\because\ \text{準備の第二})\\
&=u^{(\lvert O\rvert-1)+\lvert O\rvert}
&&(\because\ \text{冪の指数法則})\\
&=u^{2(\lvert O\rvert-1)+1}
&&(\because\ \lvert O\rvert\ge1\ \text{より}\ (\lvert O\rvert-1)+\lvert O\rvert=2(\lvert O\rvert-1)+1)\\
&=(u\cdot u)^{\lvert O\rvert-1}\cdot u
&&(\because\ \text{冪の指数法則})\\
&=\Bigl(\iota\bigl(\kappa(1)\bigr)\Bigr)^{\lvert O\rvert-1}\cdot u
&&(\because\ \text{準備の第四})\\
&=u
&&(\because\ \text{単位元の自然数冪は単位元であり、単位元を掛けても変わらない})
\end{aligned}`),
      paragraph([
        "である。",
        math(String.raw`u=\iota(-\kappa(1))`),
        " なので、これが示すべき等式である。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x]`),
        " と ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元、整数の冪、および有限集合 ",
        math(String.raw`O`),
        " の元の個数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_sum_two_terms",
    kind: "claim",
    title: {
      text:
        "軌道ごとの和は、軌道の元の個数を指数とする冪と、単位元の加法についての逆元との和である",
    },
    labels: ["claim_orbit_sum_two_terms"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitFactor_shiftMatrix_eq_zero_of_not_mem_pair",
      "Ising2DLambda.AlgebraicEigenvalue.orbitSum_shiftMatrix_eq_sum_pair",
      "Ising2DLambda.AlgebraicEigenvalue.orbitSum_shiftMatrix",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_sum_pair_of_outside_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_add_of_outside_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_eq_single_of_outside_zero",
      "Ising2DLambda.AlgebraicEigenvalue.orbitSum_shiftMatrix_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-sum-two-terms"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)=t^{\lvert O\rvert}+\iota\bigl(-\kappa(1)\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "これが ",
        ref("claim_shift_char_orbit_product"),
        " の各因子の値であり、通常 ",
        math(String.raw`t^{\lvert O\rvert}-1`),
        " と書かれる元である（",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の引き算を使わずに書くため、単位元 ",
        math(String.raw`\iota(\kappa(1))`),
        " の加法についての逆元 ",
        math(String.raw`\iota(-\kappa(1))`),
        " を足す形で述べる）。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        "軌道の元の個数が ",
        math(String.raw`1`),
        " のときも同じ式である。その場合は和の項が 1 つしかないが（",
        math(String.raw`S\!\restriction_{O}`),
        " と ",
        math(String.raw`\mathrm{id}_{O}`),
        " が写像として一致するため）、その 1 項の値 ",
        math(String.raw`t+\iota(-\kappa(1))`),
        " が ",
        math(String.raw`\lvert O\rvert=1`),
        " での右辺に一致する。",
      ]),
    ],
    proof: [
      paragraph([
        "準備を 3 つ置く。以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        "、",
        math(String.raw`G:=\{\mathrm{id}_{O},\,S\!\restriction_{O}\}\subset\mathfrak{B}_{O}`),
        " と書く。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\mathrm{id}_{O}`),
        " は ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射であり、",
        math(String.raw`S`),
        " は軌道を保つ置換なので（",
        math(String.raw`\because`),
        " ",
        ref("claim_shift_orbit_preserving"),
        "）その制限 ",
        math(String.raw`S\!\restriction_{O}`),
        " も ",
        math(String.raw`O`),
        " から ",
        math(String.raw`O`),
        " への全単射である（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_restriction_bijective"),
        "）。したがって ",
        math(String.raw`G\subset\mathfrak{B}_{O}`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("def_orbit_bijection_set"),
        "）。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`\psi\in\mathfrak{B}_{O}`),
        " が ",
        math(String.raw`\psi\notin G`),
        " を満たすならば ",
        math(String.raw`W_{O}(\mathrm{ch}(U),\psi)=\iota(\kappa(0))`),
        " である。実際、",
        math(String.raw`\psi\ne\mathrm{id}_{O}`),
        " かつ ",
        math(String.raw`\psi\ne S\!\restriction_{O}`),
        " なので、",
        ref("claim_orbit_bijection_id_or_shift"),
        " の対偶より ",
        math(String.raw`\psi(\tau_1)\ne\tau_1`),
        " かつ ",
        math(String.raw`\psi(\tau_1)\ne S(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in O`),
        " が存在し、",
        ref("claim_orbit_factor_zero"),
        " が使える。",
        ref("def_second_constant_embedding"),
        " より ",
        math(String.raw`\iota(\kappa(0))`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の零元である。",
      ]),
      paragraph([
        "第三に、",
        ref("claim_row_config_orbit_partition"),
        " の第一の主張より ",
        math(String.raw`O`),
        " は空でないので ",
        math(String.raw`\lvert O\rvert\ge1`),
        " であり、",
        math(String.raw`\lvert O\rvert\ge2`),
        " と ",
        math(String.raw`\lvert O\rvert=1`),
        " の 2 つの場合はすべての場合を尽くしており、かつ重ならない。",
      ]),
      paragraph([
        "まず両方の場合に共通する段を出す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)
&=\sum_{\psi\in G}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)
&&(\because\ \text{準備の第一・第二と、有限和の添字は外で項が零元である部分集合へ狭めてよいこと})
\end{aligned}`),
      paragraph([
        "である。以下、2 つの場合を別々に示す。",
      ]),
      paragraph([
        "第一の場合。",
        math(String.raw`\lvert O\rvert\ge2`),
        " を仮定する。",
        math(String.raw`O`),
        " は空でないので ",
        math(String.raw`\tau_2\in O`),
        " が取れ、",
        math(String.raw`\lvert O\rvert\ne1`),
        " より ",
        math(String.raw`S(\tau_2)\ne\tau_2`),
        " である（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_fixed_iff_card_one"),
        " の対偶）。",
        ref("def_orbit_restriction"),
        " より ",
        math(String.raw`(S\!\restriction_{O})(\tau_2)=S(\tau_2)\ne\tau_2=\mathrm{id}_{O}(\tau_2)`),
        " なので ",
        math(String.raw`S\!\restriction_{O}\ne\mathrm{id}_{O}`),
        " であり、",
        math(String.raw`G`),
        " はちょうど 2 元からなる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\psi\in G}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)
&=W_{O}\bigl(\mathrm{ch}(U),\mathrm{id}_{O}\bigr)+W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)
&&(\because\ \text{2 元集合にわたる有限和は 2 つの項の和である})\\
&=t^{\lvert O\rvert}+W_{O}\bigl(\mathrm{ch}(U),S\!\restriction_{O}\bigr)
&&(\because\ \blkref{claim_orbit_identity_factor}\ \text{の第一の場合})\\
&=t^{\lvert O\rvert}+u
&&(\because\ \blkref{claim_orbit_shift_restriction_factor}\ \text{と}\ u\ \text{の置き方})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        "第二の場合。",
        math(String.raw`\lvert O\rvert=1`),
        " を仮定する。任意の ",
        math(String.raw`\tau\in O`),
        " について ",
        math(String.raw`S(\tau)=\tau`),
        " であり（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_fixed_iff_card_one"),
        "）、",
        ref("def_orbit_restriction"),
        " より ",
        math(String.raw`(S\!\restriction_{O})(\tau)=S(\tau)=\tau=\mathrm{id}_{O}(\tau)`),
        " なので ",
        math(String.raw`S\!\restriction_{O}=\mathrm{id}_{O}`),
        " であり、",
        math(String.raw`G=\{\mathrm{id}_{O}\}`),
        " はちょうど 1 元からなる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\sum_{\psi\in G}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)
&=W_{O}\bigl(\mathrm{ch}(U),\mathrm{id}_{O}\bigr)
&&(\because\ \text{1 元集合にわたる有限和は 1 つの項である})\\
&=t+u
&&(\because\ \blkref{claim_orbit_identity_factor}\ \text{の第二の場合と}\ u\ \text{の置き方})\\
&=t^{\lvert O\rvert}+u
&&(\because\ \lvert O\rvert=1\ \text{より}\ t^{\lvert O\rvert}=t)
\end{aligned}`),
      paragraph([
        "である。どちらの場合も値は ",
        math(String.raw`t^{\lvert O\rvert}+u`),
        " であり、",
        math(String.raw`u=\iota(-\kappa(1))`),
        " なので、これが示すべき等式である。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と有限集合 ",
        math(String.raw`O`),
        " およびその上の全単射の全体の元だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_power_sum_telescope",
    kind: "claim",
    title: {
      text:
        "倍数を指数とする冪と単位元の逆元との和は、約数を指数とするそれと冪の有限和との積である",
    },
    labels: ["claim_power_sum_telescope"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.one_add_negUnitSecond",
      "Ising2DLambda.AlgebraicEigenvalue.add_negUnitSecond_mul_eq_zero",
      "Ising2DLambda.AlgebraicEigenvalue.powerSumTelescope",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.add_mul_self_eq_zero_of_one_add_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_add_eq_mul_geom",
      "Ising2DLambda.AlgebraicEigenvalue.powerSumTelescope_from_necSuf",
    ],
    verification: ["sagemath/check/power-sum-telescope"],
    statement: [
      paragraph([
        "自然数 ",
        math(String.raw`d\in\mathbb{N}`),
        " と ",
        math(String.raw`k\in\mathbb{N}`),
        " を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`t^{dk}+\iota\bigl(-\kappa(1)\bigr)
=\Bigl(t^{d}+\iota\bigl(-\kappa(1)\bigr)\Bigr)\cdot\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<k\}}t^{dj}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        "通常 ",
        math(String.raw`t^{dk}-1=(t^{d}-1)(1+t^{d}+\dots+t^{d(k-1)})`),
        " と書かれる等式である（",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の引き算を使わずに書くため、単位元 ",
        math(String.raw`\iota(\kappa(1))`),
        " の加法についての逆元 ",
        math(String.raw`\iota(-\kappa(1))`),
        " を足す形で述べる）。",
        "これを使うのは、",
        ref("claim_shift_char_orbit_product"),
        " の各因子の値（",
        ref("claim_orbit_sum_two_terms"),
        "）が ",
        math(String.raw`d=\lvert O\rvert`),
        " と取ったこの左辺の形をしており、軌道の元の個数が格子の一辺を割り切ること（",
        ref("claim_row_config_minimal_period_divides_L"),
        " と ",
        ref("claim_row_config_orbit_card"),
        "）から ",
        math(String.raw`L=\lvert O\rvert k`),
        " と書けるためである。",
      ]),
    ],
    proof: [
      paragraph([
        "準備を 2 つ置く。以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書き、",
        math(String.raw`\sum_{j<n}`),
        " は ",
        math(String.raw`\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<n\}}`),
        " の略記とする。",
      ]),
      paragraph([
        "第一に、",
        math(String.raw`\iota(\kappa(1))`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元、",
        math(String.raw`\iota(\kappa(0))`),
        " は零元である（",
        math(String.raw`\because`),
        " ",
        ref("def_constant_polynomial"),
        " と ",
        ref("def_second_constant_embedding"),
        "）。",
      ]),
      paragraph([
        "第二に、",
        math(String.raw`\kappa(1)+\bigl(-\kappa(1)\bigr)=\kappa(0)`),
        " が ",
        math(String.raw`\mathbb{Z}[x]`),
        " で成り立ち、",
        math(String.raw`\iota`),
        " は和を和へ写すので（",
        math(String.raw`\because`),
        " ",
        ref("def_second_constant_embedding"),
        "）",
        math(String.raw`\iota(\kappa(1))+u=\iota(\kappa(0))`),
        " である。すなわち ",
        math(String.raw`u`),
        " は単位元の加法についての逆元である。",
      ]),
      paragraph([
        math(String.raw`d`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき。添字の集合は ",
        math(String.raw`\{j'\in\mathbb{N}\mid j'<0\}=\emptyset`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
t^{d\cdot 0}+u
&=t^{0}+u
&&(\because\ d\cdot 0=0)\\
&=\iota\bigl(\kappa(1)\bigr)+u
&&(\because\ t^{0}=\iota(\kappa(1)))\\
&=\iota\bigl(\kappa(0)\bigr)
&&(\because\ \text{準備の第二})\\
&=\bigl(t^{d}+u\bigr)\cdot\iota\bigl(\kappa(0)\bigr)
&&(\because\ \text{零元を掛けた積は零元である})\\
&=\bigl(t^{d}+u\bigr)\cdot\sum_{j<0}t^{dj}
&&(\because\ \text{空集合にわたる有限和は零元である})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`k`),
        " で成り立つと仮定し、",
        math(String.raw`k+1`),
        " で示す。",
        math(String.raw`\{j'\in\mathbb{N}\mid j'<k+1\}`),
        " は ",
        math(String.raw`\{j'\in\mathbb{N}\mid j'<k\}`),
        " に ",
        math(String.raw`k`),
        " を足したものであり、",
        math(String.raw`k`),
        " は ",
        math(String.raw`\{j'\in\mathbb{N}\mid j'<k\}`),
        " に属さない。",
      ]),
      displayMath(String.raw`\begin{aligned}
t^{d(k+1)}+u
&=t^{d(k+1)}+\iota\bigl(\kappa(0)\bigr)+u
&&(\because\ \text{零元を足しても変わらない})\\
&=t^{d(k+1)}+\Bigl(\iota\bigl(\kappa(0)\bigr)\cdot t^{dk}\Bigr)+u
&&(\because\ \text{零元を掛けた積は零元である})\\
&=t^{d(k+1)}+\Bigl(\bigl(\iota\bigl(\kappa(1)\bigr)+u\bigr)\cdot t^{dk}\Bigr)+u
&&(\because\ \text{準備の第二})\\
&=t^{d(k+1)}+\Bigl(\iota\bigl(\kappa(1)\bigr)\cdot t^{dk}+u\cdot t^{dk}\Bigr)+u
&&(\because\ \mathbb{Z}[x][t]\ \text{の分配則})\\
&=t^{d(k+1)}+\Bigl(t^{dk}+u\cdot t^{dk}\Bigr)+u
&&(\because\ \text{準備の第一})\\
&=\bigl(t^{dk}+u\bigr)+\bigl(t^{d(k+1)}+u\cdot t^{dk}\bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の加法の結合則と可換則})\\
&=\bigl(t^{dk}+u\bigr)+\bigl(t^{d}\cdot t^{dk}+u\cdot t^{dk}\bigr)
&&(\because\ t^{d}\cdot t^{dk}=t^{d+dk}\ \text{と}\ d+dk=d(k+1))\\
&=\bigl(t^{dk}+u\bigr)+\bigl(t^{d}+u\bigr)\cdot t^{dk}
&&(\because\ \mathbb{Z}[x][t]\ \text{の分配則})\\
&=\bigl(t^{d}+u\bigr)\cdot\sum_{j<k}t^{dj}+\bigl(t^{d}+u\bigr)\cdot t^{dk}
&&(\because\ \text{帰納法の仮定})\\
&=\bigl(t^{d}+u\bigr)\cdot\Bigl(\sum_{j<k}t^{dj}+t^{dk}\Bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の分配則})\\
&=\bigl(t^{d}+u\bigr)\cdot\sum_{j<k+1}t^{dj}
&&(\because\ \text{添字の集合に属さない元を 1 つ足した有限和は、もとの和とその項の和である})
\end{aligned}`),
      paragraph([
        "である。これで帰納法が閉じた。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と自然数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_sum_divides_pow_L",
    kind: "claim",
    title: {
      text:
        "軌道ごとの和は、格子の一辺を指数とする冪と単位元の逆元との和の因子である",
    },
    labels: ["claim_orbit_sum_divides_pow_L"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.orbitCard_dvd_L",
      "Ising2DLambda.AlgebraicEigenvalue.orbitSum_mul_geom_eq_pow_L",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_add_dvd_pow_add_of_dvd",
      "Ising2DLambda.AlgebraicEigenvalue.orbitSum_mul_geom_eq_pow_L_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-sum-divides-pow-L"],
    statement: [
      paragraph([
        "軌道 ",
        math(String.raw`O\in\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）を任意に取る。このとき ",
        math(String.raw`L=\lvert O\rvert\cdot k`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在し、その ",
        math(String.raw`k`),
        " について",
      ]),
      displayMath(
        String.raw`t^{L}+\iota\bigl(-\kappa(1)\bigr)
=\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)\cdot\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<k\}}t^{\lvert O\rvert j}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`U`),
        " は ",
        ref("def_shift_matrix"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "、",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`L`),
        " は ",
        ref("def_lattice"),
        "）。",
        "すなわち ",
        ref("claim_shift_char_orbit_product"),
        " に現れる各因子は、",
        math(String.raw`t^{L}+\iota(-\kappa(1))`),
        " を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中で割り切る。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書き、",
        math(String.raw`\sum_{j<n}`),
        " は ",
        math(String.raw`\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<n\}}`),
        " の略記とする。",
      ]),
      paragraph([
        "まず ",
        math(String.raw`k`),
        " を作る。",
        ref("def_row_config_orbit_set"),
        " より ",
        math(String.raw`O=O(\tau_0)`),
        " を満たす ",
        math(String.raw`\tau_0\in R_L`),
        " が取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lvert O\rvert
&=\lvert O(\tau_0)\rvert
&&(\because\ O=O(\tau_0))\\
&=e(\tau_0)
&&(\because\ \blkref{claim_row_config_orbit_card})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`e(\tau_0)`),
        " は ",
        math(String.raw`L`),
        " を割り切るので（",
        math(String.raw`\because`),
        " ",
        ref("claim_row_config_minimal_period_divides_L"),
        "）、",
        math(String.raw`L=e(\tau_0)\cdot k=\lvert O\rvert\cdot k`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在する（",
        math(String.raw`\because`),
        " 自然数の整除の定義）。この ",
        math(String.raw`k`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
t^{L}+u
&=t^{\lvert O\rvert k}+u
&&(\because\ L=\lvert O\rvert\cdot k)\\
&=\bigl(t^{\lvert O\rvert}+u\bigr)\cdot\sum_{j<k}t^{\lvert O\rvert j}
&&(\because\ \blkref{claim_power_sum_telescope}\ \text{の}\ d=\lvert O\rvert\ \text{の場合})\\
&=\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)\cdot\sum_{j<k}t^{\lvert O\rvert j}
&&(\because\ \blkref{claim_orbit_sum_two_terms})
\end{aligned}`),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と自然数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_prod_pair_eq_pow_card",
    kind: "claim",
    title: {
      text:
        "各因子の積が同じ値であるとき、軌道の集合にわたる 2 つの有限積の積は、その値の個数を指数とする冪である",
    },
    labels: ["claim_prod_pair_eq_pow_card"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.prod_pair_eq_pow_card",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_pair_eq_pow_card_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.prod_pair_eq_pow_card_from_necSuf",
    ],
    verification: ["sagemath/check/prod-pair-eq-pow-card"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{O}_L`),
        "（",
        ref("def_row_config_orbit_set"),
        "）の部分集合 ",
        math(String.raw`s`),
        "、2 つの写像 ",
        math(String.raw`a:\mathcal{O}_L\to\mathbb{Z}[x][t]`),
        "、",
        math(String.raw`b:\mathcal{O}_L\to\mathbb{Z}[x][t]`),
        "、および ",
        math(String.raw`c\in\mathbb{Z}[x][t]`),
        " を任意に取る（",
        math(String.raw`\mathbb{Z}[x][t]`),
        " は ",
        ref("def_second_polynomial_ring"),
        "）。すべての ",
        math(String.raw`O\in s`),
        " について ",
        math(String.raw`a(O)\cdot b(O)=c`),
        " が成り立つと仮定する。このとき",
      ]),
      displayMath(
        String.raw`\Bigl(\prod_{O\in s}a(O)\Bigr)\cdot\prod_{O\in s}b(O)=c^{\lvert s\rvert}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\lvert s\rvert\in\mathbb{N}`),
        " は有限集合 ",
        math(String.raw`s`),
        " の元の個数）。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        "これを使うのは、",
        ref("claim_shift_char_orbit_product"),
        " の各因子が ",
        math(String.raw`t^{L}+\iota(-\kappa(1))`),
        " を割り切ること（",
        ref("claim_orbit_sum_divides_pow_L"),
        "）から、",
        math(String.raw`\chi_U`),
        " がその冪を割り切ることを出すためである。",
        "割り切ることを「積が与えられた値になる相手が存在すること」として述べているので、",
        "相手の側を写像 ",
        math(String.raw`b`),
        " として受け取っている。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s`),
        " の元の個数についての帰納法で示す。",
        "仮定「すべての ",
        math(String.raw`O\in s`),
        " について ",
        math(String.raw`a(O)\cdot b(O)=c`),
        "」は部分集合へ遺伝するので、帰納法の各段でそのまま使える。",
      ]),
      paragraph([
        math(String.raw`s=\emptyset`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{O\in\emptyset}a(O)\Bigr)\cdot\prod_{O\in\emptyset}b(O)
&=\iota\bigl(\kappa(1)\bigr)\cdot\prod_{O\in\emptyset}b(O)
&&(\because\ \text{空集合にわたる有限積は単位元である})\\
&=\iota\bigl(\kappa(1)\bigr)\cdot\iota\bigl(\kappa(1)\bigr)
&&(\because\ \text{空集合にわたる有限積は単位元である})\\
&=\iota\bigl(\kappa(1)\bigr)
&&(\because\ \iota(\kappa(1))\ \text{は}\ \mathbb{Z}[x][t]\ \text{の単位元である})\\
&=c^{0}
&&(\because\ \text{零乗は単位元である})\\
&=c^{\lvert\emptyset\rvert}
&&(\because\ \lvert\emptyset\rvert=0)
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`s`),
        " で成り立つと仮定し、",
        math(String.raw`s`),
        " に属さない ",
        math(String.raw`O_0\in\mathcal{O}_L`),
        " を足した ",
        math(String.raw`s\cup\{O_0\}`),
        " で示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\prod_{O\in s\cup\{O_0\}}a(O)\Bigr)\cdot\prod_{O\in s\cup\{O_0\}}b(O)
&=\Bigl(\bigl(\prod_{O\in s}a(O)\bigr)\cdot a(O_0)\Bigr)\cdot\prod_{O\in s\cup\{O_0\}}b(O)
&&(\because\ \text{添字の集合に属さない元を 1 つ足した有限積は、もとの積とその項の積である})\\
&=\Bigl(\bigl(\prod_{O\in s}a(O)\bigr)\cdot a(O_0)\Bigr)\cdot\Bigl(\bigl(\prod_{O\in s}b(O)\bigr)\cdot b(O_0)\Bigr)
&&(\because\ \text{添字の集合に属さない元を 1 つ足した有限積は、もとの積とその項の積である})\\
&=\Bigl(\bigl(\prod_{O\in s}a(O)\bigr)\cdot\bigl(\prod_{O\in s}b(O)\bigr)\Bigr)\cdot\bigl(a(O_0)\cdot b(O_0)\bigr)
&&(\because\ \mathbb{Z}[x][t]\ \text{の乗法の結合則と可換則})\\
&=c^{\lvert s\rvert}\cdot\bigl(a(O_0)\cdot b(O_0)\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=c^{\lvert s\rvert}\cdot c
&&(\because\ \text{仮定を}\ O=O_0\ \text{に当てたもの})\\
&=c^{\lvert s\rvert+1}
&&(\because\ \mathbb{Z}[x][t]\ \text{の冪の定義})\\
&=c^{\lvert s\cup\{O_0\}\rvert}
&&(\because\ \text{属さない元を 1 つ足した有限集合の元の個数は 1 増える})
\end{aligned}`),
      paragraph([
        "である。これで帰納法が閉じた。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`\mathcal{O}_L`),
        " とその部分集合、その上の写像、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の有限積と自然数だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_dvd_pow_L",
    kind: "claim",
    title: {
      text:
        "シフト行列の特性多項式は、格子の一辺を指数とする冪と単位元の逆元との和の、軌道の個数を指数とする冪の因子である",
    },
    labels: ["claim_shift_char_dvd_pow_L"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_dvd_pow_L",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_dvd_pow_card_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_dvd_pow_L_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-dvd-pow-L"],
    statement: [
      paragraph([
        "シフト行列 ",
        math(String.raw`U`),
        "（",
        ref("def_shift_matrix"),
        "）の特性多項式 ",
        math(String.raw`\chi_U`),
        "（",
        ref("def_characteristic_polynomial"),
        "）について、",
      ]),
      displayMath(
        String.raw`\chi_U\cdot g=\bigl(t^{L}+\iota(-\kappa(1))\bigr)^{\lvert\mathcal{O}_L\rvert}`,
      ),
      paragraph([
        "を満たす ",
        math(String.raw`g\in\mathbb{Z}[x][t]`),
        " が存在する（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`\lvert\mathcal{O}_L\rvert\in\mathbb{N}`),
        " はその元の個数、",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`L`),
        " は ",
        ref("def_lattice"),
        "）。",
        "すなわち ",
        math(String.raw`\chi_U`),
        " は ",
        math(String.raw`t^{L}+\iota(-\kappa(1))`),
        " の ",
        math(String.raw`\lvert\mathcal{O}_L\rvert`),
        " 乗を ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中で割り切る。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書く。",
      ]),
      paragraph([
        "まず 2 つの写像を置く。",
        math(String.raw`a:\mathcal{O}_L\to\mathbb{Z}[x][t]`),
        " を ",
        math(
          String.raw`a(O):=\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)`,
        ),
        " で定める（",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        "）。",
        "次に、任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について ",
        math(String.raw`a(O)\cdot h=t^{L}+u`),
        " を満たす ",
        math(String.raw`h\in\mathbb{Z}[x][t]`),
        " が存在するので（",
        math(String.raw`\because`),
        " ",
        ref("claim_orbit_sum_divides_pow_L"),
        " が与える ",
        math(String.raw`h=\sum_{j\in\{j'\in\mathbb{N}\,\mid\,j'<k\}}t^{\lvert O\rvert j}`),
        "）、各 ",
        math(String.raw`O`),
        " についてそのような ",
        math(String.raw`h`),
        " を 1 つ選び、その対応を ",
        math(String.raw`b:\mathcal{O}_L\to\mathbb{Z}[x][t]`),
        " とする（",
        math(String.raw`\mathcal{O}_L`),
        " は有限集合なので選び方は有限個の選択で済む）。",
        "定義より、任意の ",
        math(String.raw`O\in\mathcal{O}_L`),
        " について ",
        math(String.raw`a(O)\cdot b(O)=t^{L}+u`),
        " が成り立つ。",
      ]),
      paragraph([
        "そのうえで ",
        math(String.raw`g:=\prod_{O\in\mathcal{O}_L}b(O)\in\mathbb{Z}[x][t]`),
        " と置く。この ",
        math(String.raw`g`),
        " について次が成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_U\cdot g
&=\chi_U\cdot\prod_{O\in\mathcal{O}_L}b(O)
&&(\because\ g\ \text{の定義})\\
&=\Bigl(\prod_{O\in\mathcal{O}_L}a(O)\Bigr)\cdot\prod_{O\in\mathcal{O}_L}b(O)
&&(\because\ \blkref{claim_shift_char_orbit_product}\ \text{と}\ a\ \text{の定義})\\
&=\bigl(t^{L}+u\bigr)^{\lvert\mathcal{O}_L\rvert}
&&(\because\ \blkref{claim_prod_pair_eq_pow_card}\ \text{の}\ s=\mathcal{O}_L,\ c=t^{L}+u\ \text{の場合})
\end{aligned}`),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`\mathcal{O}_L`),
        " とその上の写像、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の有限積と自然数だけであり、実数体も複素数体も現れない。",
        "この整除関係は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中で述べられており、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " へはまだ入っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_orbit_factorization",
    kind: "claim",
    title: {
      text:
        "シフト行列の特性多項式は、軌道ごとに、その軌道の元の個数を指数とする冪と単位元の逆元との和を掛け合わせたものである",
    },
    labels: ["claim_shift_char_orbit_factorization"],
    habitat: "Z",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_prod_orbit_factor",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.prod_congr_of_eq_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.charPoly_shiftMatrix_eq_prod_orbit_factor_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-orbit-factorization"],
    statement: [
      paragraph([
        "シフト行列 ",
        math(String.raw`U`),
        "（",
        ref("def_shift_matrix"),
        "）の特性多項式 ",
        math(String.raw`\chi_U`),
        "（",
        ref("def_characteristic_polynomial"),
        "）について、",
      ]),
      displayMath(
        String.raw`\chi_U=\prod_{O\in\mathcal{O}_L}\Bigl(t^{\lvert O\rvert}+\iota\bigl(-\kappa(1)\bigr)\Bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        "、",
        math(String.raw`\lvert O\rvert\in\mathbb{N}`),
        " は軌道 ",
        math(String.raw`O`),
        " の元の個数、",
        math(String.raw`t`),
        " は ",
        ref("def_indeterminate_element"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。",
        "すなわち、",
        math(String.raw`2^{L}`),
        " 個の行配位にわたる置換の全体についての和として定義された ",
        math(String.raw`\chi_U`),
        " が、軌道ごとの因子の積として明示的に書けたことになる。",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の等式であり、実数体も複素数体も現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\chi_U
&=\prod_{O\in\mathcal{O}_L}\Bigl(\sum_{\psi\in\mathfrak{B}_{O}}W_{O}\bigl(\mathrm{ch}(U),\psi\bigr)\Bigr)
&&(\because\ \blkref{claim_shift_char_orbit_product})\\
&=\prod_{O\in\mathcal{O}_L}\bigl(t^{\lvert O\rvert}+u\bigr)
&&(\because\ \blkref{claim_orbit_sum_two_terms}\ \text{を各}\ O\in\mathcal{O}_L\ \text{の因子へ当てた})
\end{aligned}`),
      paragraph([
        "第 2 の等号で使ったのは、有限積の各因子が等しければ有限積が等しいことである",
        "（",
        math(String.raw`\mathcal{O}_L`),
        " の各元 ",
        math(String.raw`O`),
        " について ",
        math(String.raw`\sum_{\psi\in\mathfrak{B}_{O}}W_{O}(\mathrm{ch}(U),\psi)=t^{\lvert O\rvert}+u`),
        " が成り立つので、積を取っても等しい）。",
        math(String.raw`\mathfrak{B}_{O}`),
        " は ",
        ref("def_orbit_bijection_set"),
        "、",
        math(String.raw`W_{O}`),
        " は ",
        ref("def_orbit_term_factor"),
        "、",
        math(String.raw`\mathrm{ch}`),
        " は ",
        ref("def_characteristic_matrix"),
        " である。",
      ]),
      paragraph([
        "現れるのは有限集合 ",
        math(String.raw`\mathcal{O}_L`),
        " とその元の個数、および ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の有限積と冪だけであり、実数体も複素数体も現れない。",
        "この等式は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中で述べられており、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " へはまだ入っていない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_def_algebraic_numbers",
    kind: "definition",
    title: { text: "代数的数の全体" },
    labels: ["def_algebraic_numbers"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.Qbar"],
    verification: ["sagemath/check/root-of-unity-divisor"],
    statement: [
      paragraph([
        "有理数体 ",
        math(String.raw`\mathbb{Q}`),
        " の代数閉包を 1 つ固定し、それを ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " と書く。すなわち ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は次の 3 条件を満たす体である。",
      ]),
      list([
        [
          math(String.raw`\mathbb{Q}`),
          " は ",
          math(String.raw`\overline{\mathbb{Q}}`),
          " の部分体である。",
        ],
        [
          math(String.raw`\overline{\mathbb{Q}}`),
          " を係数とする次数 1 以上の多項式は ",
          math(String.raw`\overline{\mathbb{Q}}`),
          " の中に根を持つ（代数閉であること）。",
        ],
        [
          math(String.raw`\overline{\mathbb{Q}}`),
          " の各元 ",
          math(String.raw`z`),
          " について、",
          math(String.raw`z`),
          " を根に持つ ",
          math(String.raw`\mathbb{Q}`),
          " 係数の零でない多項式が存在する（各元が ",
          math(String.raw`\mathbb{Q}`),
          " 上代数的であること）。",
        ],
      ]),
      paragraph([
        "この 3 条件を満たす体が存在すること、および 2 つあれば ",
        math(String.raw`\mathbb{Q}`),
        " を動かさない体の同型で移り合うことは既知である。",
        "以下ではその 1 つを固定して使い、どれを固定したかに依存する主張は述べない。",
      ]),
      paragraph([
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である（",
        math(String.raw`\mathbb{Q}`),
        " 係数の零でない多項式の全体が可算であり、そのそれぞれが有限個の根しか持たないことによる）。",
        "したがってここで実数体にも複素数体にも脱出していない。",
        "複素数体の部分体として取ることもできるが、そうすると非可算な集合を経由することになるので、",
        "本文ではそのような取り方をしない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_def_root_of_unity_set",
    kind: "definition",
    title: { text: "1 の冪根の全体" },
    labels: ["def_root_of_unity_set"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.RootOfUnity"],
    verification: ["sagemath/check/root-of-unity-divisor"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。",
        math(String.raw`n`),
        " 乗すると 1 になる代数的数の全体を",
      ]),
      displayMath(
        String.raw`\mu_{n}:=\bigl\{\,z\in\overline{\mathbb{Q}} \;\bigm|\; z^{n}=1\,\bigr\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "、",
        math(String.raw`z^{n}`),
        " は体 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の積の ",
        math(String.raw`n`),
        " 回の反復で、",
        math(String.raw`z^{0}=1`),
        " と約束する）。",
        math(String.raw`\mu_{n}`),
        " の元を 1 の ",
        math(String.raw`n`),
        " 乗根と呼ぶ。",
      ]),
      paragraph([
        math(String.raw`\mu_{n}`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の部分集合であり、実数体も複素数体も現れない。",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\mu_{0}=\overline{\mathbb{Q}}`),
        " である（",
        math(String.raw`z^{0}=1`),
        " がすべての ",
        math(String.raw`z`),
        " について成り立つため）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_divisor",
    kind: "claim",
    title: {
      text: "約数を指数として 1 になる代数的数は、その倍数を指数としても 1 になる",
    },
    labels: ["claim_root_of_unity_divisor"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_dvd",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_eq_one_of_dvd_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_dvd_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-divisor"],
    statement: [
      paragraph([
        math(String.raw`d\in\mathbb{N}`),
        " と ",
        math(String.raw`n\in\mathbb{N}`),
        " が ",
        math(String.raw`d\mid n`),
        "（",
        math(String.raw`n=dk`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " が存在すること）を満たすとする。このとき",
      ]),
      displayMath(String.raw`\mu_{d}\subset\mu_{n}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mu_{d}`),
        " と ",
        math(String.raw`\mu_{n}`),
        " は ",
        ref("def_root_of_unity_set"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z\in\mu_{d}`),
        " を任意に取る。",
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " かつ ",
        math(String.raw`z^{d}=1`),
        " である。",
        "仮定 ",
        math(String.raw`d\mid n`),
        " により ",
        math(String.raw`n=dk`),
        " を満たす ",
        math(String.raw`k\in\mathbb{N}`),
        " を 1 つ取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
z^{n}
&=z^{dk}
&&(\because\ n=dk)\\
&=\bigl(z^{d}\bigr)^{k}
&&(\because\ \text{体}\ \overline{\mathbb{Q}}\ \text{の積の反復についての指数法則})\\
&=1^{k}
&&(\because\ z^{d}=1)\\
&=1
&&(\because\ \text{単位元の反復積は単位元である})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " かつ ",
        math(String.raw`z^{n}=1`),
        " であり、",
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`z\in\mu_{n}`),
        " である。",
        math(String.raw`z\in\mu_{d}`),
        " は任意だったので ",
        math(String.raw`\mu_{d}\subset\mu_{n}`),
        " である。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元とその積の反復、および自然数の積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_def_second_evaluation",
    kind: "definition",
    title: { text: "もう 1 つの不定元の多項式の代数的数における値" },
    labels: ["def_second_evaluation"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.evalSecond"],
    verification: ["sagemath/check/orbit-factor-root"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "）。",
        ref("def_second_polynomial_ring"),
        " の ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`f`),
        " に対し、その値を",
      ]),
      displayMath(
        String.raw`\mathrm{ev}_{\xi,z}(f):=\sum_{k:\ \mathrm{cf}_k(f)\ne\kappa(0)}\bigl(\mathrm{cf}_k(f)\bigr)(\xi)\cdot z^{\,k}\ \in\ \overline{\mathbb{Q}}`,
      ),
      paragraph([
        "で定める。ここで ",
        math(String.raw`\mathrm{cf}_k(f)\in\mathbb{Z}[x]`),
        " は ",
        ref("def_second_polynomial_ring"),
        " の係数、",
        math(String.raw`\bigl(\mathrm{cf}_k(f)\bigr)(\xi)\in\overline{\mathbb{Q}}`),
        " は ",
        ref("def_partition_polynomial"),
        " で約束した意味での代入（可換環 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " とその元 ",
        math(String.raw`\xi`),
        " についての評価）であり、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        " である。和は有限個の項からなる（",
        math(String.raw`\mathrm{cf}_k(f)\ne\kappa(0)`),
        " となる ",
        math(String.raw`k`),
        " は有限個だから）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{ev}_{\xi,z}:\mathbb{Z}[x][t]\to\overline{\mathbb{Q}}`),
        " は和と積を保ち、",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の零元を ",
        math(String.raw`0`),
        " へ、単位元を ",
        math(String.raw`1`),
        " へ送る（多項式環からの代入が環準同型であることの、係数環を ",
        math(String.raw`\mathrm{ev}_{\xi}`),
        " で送る場合である。",
        ref("def_partition_polynomial"),
        " で置いた約束と同じもので、証明すべきことではない）。",
        "とくに加法についての逆元を逆元へ送る。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和・有限積だけであり、実数体も複素数体も現れない",
        "（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である。",
        ref("def_algebraic_numbers"),
        "）。",
        "不定元 ",
        math(String.raw`x`),
        " に入れる ",
        math(String.raw`\xi`),
        " と不定元 ",
        math(String.raw`t`),
        " に入れる ",
        math(String.raw`z`),
        " は別の記号にしてある。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_orbit_factor_root",
    kind: "claim",
    title: {
      text: "軌道ごとの因子の値を 0 にする代数的数は 1 の冪根である",
    },
    labels: ["claim_orbit_factor_root"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_orbitFactor_eval_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eval₂_X_pow_add_C_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_orbitFactor_eval_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/orbit-factor-root"],
    statement: [
      paragraph([
        math(String.raw`m\in\mathbb{N}`),
        "、",
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "、",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\mathrm{ev}_{\xi,z}\bigl(t^{\,m}+\iota(-\kappa(1))\bigr)=0
\ \Longrightarrow\ z\in\mu_{m}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{ev}_{\xi,z}`),
        " は ",
        ref("def_second_evaluation"),
        "、",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "、",
        math(String.raw`\mu_{m}`),
        " は ",
        ref("def_root_of_unity_set"),
        "）。",
      ]),
      paragraph([
        "左辺に現れる ",
        math(String.raw`t^{\,m}+\iota(-\kappa(1))`),
        " は、",
        ref("claim_shift_char_orbit_factorization"),
        " が与えたシフト行列の特性多項式の因子",
        "（元の個数が ",
        math(String.raw`m`),
        " である軌道に対応するもの）そのものである。",
      ]),
    ],
    proof: [
      paragraph([
        "仮定 ",
        math(String.raw`\mathrm{ev}_{\xi,z}\bigl(t^{\,m}+\iota(-\kappa(1))\bigr)=0`),
        " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ev}_{\xi,z}\bigl(t^{\,m}+\iota(-\kappa(1))\bigr)
&=\mathrm{ev}_{\xi,z}\bigl(t^{\,m}\bigr)+\mathrm{ev}_{\xi,z}\bigl(\iota(-\kappa(1))\bigr)
&&(\because\ \blkref{def_second_evaluation}\ \text{の}\ \mathrm{ev}_{\xi,z}\ \text{が和を保つこと})\\
&=z^{\,m}+\mathrm{ev}_{\xi,z}\bigl(\iota(-\kappa(1))\bigr)
&&(\because\ \blkref{def_second_evaluation}\ \text{で}\ \mathrm{cf}_k(t^{m})\ \text{が}\ k=m\ \text{のときだけ}\ \kappa(1)\ \text{であること})\\
&=z^{\,m}+\bigl(-\kappa(1)\bigr)(\xi)
&&(\because\ \blkref{def_second_constant_embedding}\ \text{により}\ \mathrm{cf}_0(\iota(a))=a\ \text{かつ}\ k\ge1\ \text{で}\ \kappa(0))\\
&=z^{\,m}-\bigl(\kappa(1)\bigr)(\xi)
&&(\because\ \text{代入は加法についての逆元を逆元へ送ること})\\
&=z^{\,m}-1
&&(\because\ \blkref{def_constant_polynomial}\ \text{により}\ \kappa(1)\ \text{は定数多項式}\ 1\ \text{であること})
\end{aligned}`),
      paragraph([
        "したがって ",
        math(String.raw`z^{\,m}-1=0`),
        " であり、",
        math(String.raw`z^{\,m}=1`),
        " である。",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " なので、",
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`z\in\mu_{m}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`m=0`),
        " の場合も除いていない。そのとき ",
        math(String.raw`t^{0}+\iota(-\kappa(1))`),
        " は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の零元であって仮定は自動的に満たされ、",
        math(String.raw`\mu_{0}=\overline{\mathbb{Q}}`),
        " なので結論も自動的に成り立つ（",
        ref("def_root_of_unity_set"),
        "）。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和・有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_second_evaluation_prod",
    kind: "claim",
    title: { text: "代数的数における値を取る写像は、有限積を有限積へ写す" },
    labels: ["claim_second_evaluation_prod"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.evalSecond_prod",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.map_prod_of_mul",
      "Ising2DLambda.AlgebraicEigenvalue.evalSecond_prod_from_necSuf",
    ],
    verification: ["sagemath/check/second-evaluation-prod"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る。有限集合 ",
        math(String.raw`s`),
        " と、その各元 ",
        math(String.raw`i\in s`),
        " へ ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元 ",
        math(String.raw`f_i`),
        " を与える写像を任意に取る（",
        math(String.raw`\mathbb{Z}[x][t]`),
        " は ",
        ref("def_second_polynomial_ring"),
        "）。このとき",
      ]),
      displayMath(
        String.raw`\mathrm{ev}_{\xi,z}\Bigl(\textstyle\prod_{i\in s}f_i\Bigr)=\prod_{i\in s}\mathrm{ev}_{\xi,z}(f_i)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{ev}_{\xi,z}`),
        " は ",
        ref("def_second_evaluation"),
        "）。左辺の積は ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の中の有限積、右辺の積は ",
        math(String.raw`\overline{\mathbb{Q}}`),
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
        math(String.raw`\mathrm{ev}_{\xi,z}`),
        " が ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の単位元へ与える値、右辺は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の単位元 ",
        math(String.raw`1`),
        " であり、",
        ref("def_second_evaluation"),
        " が単位元を単位元へ送ることから両者は等しい（空の積は単位元である）。",
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
\mathrm{ev}_{\xi,z}\Bigl(\textstyle\prod_{i\in s\cup\{a\}}f_i\Bigr)
&=\mathrm{ev}_{\xi,z}\Bigl(f_a\cdot\textstyle\prod_{i\in s}f_i\Bigr)
&&(\because\ \text{有限積から因子を}\ 1\ \text{つ括り出す})\\
&=\mathrm{ev}_{\xi,z}(f_a)\cdot\mathrm{ev}_{\xi,z}\Bigl(\textstyle\prod_{i\in s}f_i\Bigr)
&&(\because\ \blkref{def_second_evaluation}\ \text{の}\ \mathrm{ev}_{\xi,z}\ \text{が積を保つこと})\\
&=\mathrm{ev}_{\xi,z}(f_a)\cdot\prod_{i\in s}\mathrm{ev}_{\xi,z}(f_i)
&&(\because\ \text{帰納法の仮定})\\
&=\prod_{i\in s\cup\{a\}}\mathrm{ev}_{\xi,z}(f_i)
&&(\because\ \text{有限積へ因子を}\ 1\ \text{つ戻す})
\end{aligned}`),
      paragraph([
        "この証明が ",
        math(String.raw`\mathrm{ev}_{\xi,z}`),
        " について使っているのは、単位元を単位元へ送ることと積を保つことだけである。",
        "和を保つことは使っていない（この証明に和が一度も現れない）。",
        "したがって ",
        ref("claim_const_embedding_prod"),
        " と同じ論法であり、必要十分版も同じものを使う。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_prod_eq_zero",
    kind: "claim",
    title: { text: "代数的数の有限積が 0 ならば、0 である因子がある" },
    labels: ["claim_qbar_prod_eq_zero"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.exists_eq_zero_of_prod_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.exists_eq_zero_of_prod_eq_zero_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.exists_eq_zero_of_prod_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-prod-zero"],
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`s`),
        " と、その各元 ",
        math(String.raw`i\in s`),
        " へ ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元 ",
        math(String.raw`c_i`),
        " を与える写像を任意に取る（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "）。このとき",
      ]),
      displayMath(
        String.raw`\prod_{i\in s}c_i=0
\ \Longrightarrow\ c_{i_0}=0\ \text{を満たす}\ i_0\in s\ \text{が存在する}`,
      ),
      paragraph([
        "が成り立つ。積は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の中の有限積であり、",
        math(String.raw`0`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の零元である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`s`),
        " の元の個数についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`s`),
        " が空のとき、空の積は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の単位元 ",
        math(String.raw`1`),
        " である。",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は体なので ",
        math(String.raw`1\ne0`),
        " であり（",
        ref("def_algebraic_numbers"),
        "）、仮定 ",
        math(String.raw`\prod_{i\in s}c_i=0`),
        " を満たす写像は無い。したがって主張は成り立つ。",
      ]),
      paragraph([
        math(String.raw`s`),
        " について主張が成り立つとし、",
        math(String.raw`s`),
        " に属さない元 ",
        math(String.raw`a`),
        " を 1 つ足した ",
        math(String.raw`s\cup\{a\}`),
        " について ",
        math(String.raw`\prod_{i\in s\cup\{a\}}c_i=0`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
0&=\prod_{i\in s\cup\{a\}}c_i
&&(\because\ \text{仮定})\\
&=c_a\cdot\prod_{i\in s}c_i
&&(\because\ \text{有限積から因子を}\ 1\ \text{つ括り出す})
\end{aligned}`),
      paragraph([
        math(String.raw`c_a=0`),
        " の場合は ",
        math(String.raw`i_0=a`),
        " と取れば結論が出る（",
        math(String.raw`a\in s\cup\{a\}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`c_a\ne0`),
        " の場合を見る。",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は体なので ",
        math(String.raw`c_a`),
        " は積についての逆元 ",
        math(String.raw`c_a^{-1}\in\overline{\mathbb{Q}}`),
        " を持つ（",
        ref("def_algebraic_numbers"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\prod_{i\in s}c_i
&=1\cdot\prod_{i\in s}c_i
&&(\because\ 1\ \text{は積の単位元})\\
&=\bigl(c_a^{-1}\cdot c_a\bigr)\cdot\prod_{i\in s}c_i
&&(\because\ c_a^{-1}\ \text{は}\ c_a\ \text{の積についての逆元})\\
&=c_a^{-1}\cdot\Bigl(c_a\cdot\prod_{i\in s}c_i\Bigr)
&&(\because\ \text{積の結合則})\\
&=c_a^{-1}\cdot 0
&&(\because\ \text{上の鎖で得た}\ c_a\cdot\prod_{i\in s}c_i=0)\\
&=0
&&(\because\ \text{零元との積は零元である})
\end{aligned}`),
      paragraph([
        "帰納法の仮定から ",
        math(String.raw`c_{i_0}=0`),
        " を満たす ",
        math(String.raw`i_0\in s`),
        " が存在し、",
        math(String.raw`s\subset s\cup\{a\}`),
        " なので ",
        math(String.raw`i_0\in s\cup\{a\}`),
        " である。",
      ]),
      paragraph([
        "この証明が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の結合則と可換性、単位元 ",
        math(String.raw`1`),
        "、零元 ",
        math(String.raw`0`),
        " とその吸収律（零元との積は零元である）、零元でない元が積についての逆元を持つこと、",
        "および ",
        math(String.raw`1\ne0`),
        " だけである。和も分配則も、代数閉であることも使っていない",
        "（零元の吸収律は、体では分配則から出るが、ここでは仮定として置いたものだけを使っている）。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_char_root_of_unity",
    kind: "claim",
    title: {
      text: "シフト行列の特性多項式の値を 0 にする代数的数は 1 の $L$ 乗根である",
    },
    labels: ["claim_shift_char_root_of_unity"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_charPoly_shiftMatrix_eval_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mem_of_prod_eval_eq_zero_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_of_charPoly_shiftMatrix_eval_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/shift-char-root-of-unity"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "）。このとき",
      ]),
      displayMath(
        String.raw`\mathrm{ev}_{\xi,z}\bigl(\chi_U\bigr)=0
\ \Longrightarrow\ z\in\mu_{L}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\chi_U`),
        " は ",
        ref("def_shift_matrix"),
        " の特性多項式（",
        ref("def_characteristic_polynomial"),
        "）、",
        math(String.raw`\mathrm{ev}_{\xi,z}`),
        " は ",
        ref("def_second_evaluation"),
        "、",
        math(String.raw`\mu_{L}`),
        " は ",
        ref("def_root_of_unity_set"),
        "、",
        math(String.raw`L`),
        " は ",
        ref("def_lattice"),
        " の一辺の長さ）。",
        "すなわち、シフト行列の固有値として現れうる代数的数は 1 の ",
        math(String.raw`L`),
        " 乗根に限られる。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`u:=\iota\bigl(-\kappa(1)\bigr)\in\mathbb{Z}[x][t]`),
        " と書く（",
        math(String.raw`\iota`),
        " は ",
        ref("def_second_constant_embedding"),
        "、",
        math(String.raw`\kappa`),
        " は ",
        ref("def_constant_polynomial"),
        "）。仮定 ",
        math(String.raw`\mathrm{ev}_{\xi,z}(\chi_U)=0`),
        " を置く。",
      ]),
      displayMath(String.raw`\begin{aligned}
0&=\mathrm{ev}_{\xi,z}\bigl(\chi_U\bigr)
&&(\because\ \text{仮定})\\
&=\mathrm{ev}_{\xi,z}\Bigl(\prod_{O\in\mathcal{O}_L}\bigl(t^{\lvert O\rvert}+u\bigr)\Bigr)
&&(\because\ \blkref{claim_shift_char_orbit_factorization})\\
&=\prod_{O\in\mathcal{O}_L}\mathrm{ev}_{\xi,z}\bigl(t^{\lvert O\rvert}+u\bigr)
&&(\because\ \blkref{claim_second_evaluation_prod})
\end{aligned}`),
      paragraph([
        ref("claim_qbar_prod_eq_zero"),
        " を族 ",
        math(String.raw`O\mapsto\mathrm{ev}_{\xi,z}(t^{\lvert O\rvert}+u)`),
        " へ当てて、",
        math(String.raw`\mathrm{ev}_{\xi,z}\bigl(t^{\lvert O_0\rvert}+u\bigr)=0`),
        " を満たす ",
        math(String.raw`O_0\in\mathcal{O}_L`),
        " を 1 つ取る（",
        math(String.raw`\mathcal{O}_L`),
        " は ",
        ref("def_row_config_orbit_set"),
        " であり有限集合である）。",
        ref("claim_orbit_factor_root"),
        " を ",
        math(String.raw`m=\lvert O_0\rvert`),
        " として当てると ",
        math(String.raw`z\in\mu_{\lvert O_0\rvert}`),
        " である。",
      ]),
      paragraph([
        ref("def_row_config_orbit_set"),
        " により ",
        math(String.raw`O_0=O(\tau_0)`),
        " を満たす ",
        math(String.raw`\tau_0\in R_L`),
        " を 1 つ取る（",
        math(String.raw`O(\tau_0)`),
        " は ",
        ref("def_row_config_orbit"),
        "、",
        math(String.raw`R_L`),
        " は ",
        ref("def_row_configuration"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\lvert O_0\rvert
&=\lvert O(\tau_0)\rvert
&&(\because\ O_0=O(\tau_0))\\
&=e(\tau_0)
&&(\because\ \blkref{claim_row_config_orbit_card})
\end{aligned}`),
      paragraph([
        ref("claim_row_config_minimal_period_divides_L"),
        " により ",
        math(String.raw`e(\tau_0)`),
        " は ",
        math(String.raw`L`),
        " を割り切るので、上の鎖と合わせて ",
        math(String.raw`\lvert O_0\rvert`),
        " は ",
        math(String.raw`L`),
        " を割り切る（",
        math(String.raw`e(\tau_0)`),
        " は ",
        ref("def_row_config_shift_minimal_period"),
        "）。したがって ",
        ref("claim_root_of_unity_divisor"),
        " により ",
        math(String.raw`\mu_{\lvert O_0\rvert}\subset\mu_{L}`),
        " であり、",
        math(String.raw`z\in\mu_{\lvert O_0\rvert}`),
        " と合わせて ",
        math(String.raw`z\in\mu_{L}`),
        " である。",
      ]),
      paragraph([
        "この段が新しく使っているのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の有限積と、上の各行で引いた既出の主張だけである。",
        "現れるのは ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の元と ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と自然数の整除だけであり、実数体も複素数体も現れない",
        "（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である。",
        ref("def_algebraic_numbers"),
        "）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_matrix",
    kind: "definition",
    title: { text: "代数的数を成分とする行列" },
    labels: ["def_qbar_matrix"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.QbarRowMatrix"],
    verification: ["sagemath/check/qbar-action-product"],
    statement: [
      paragraph([
        ref("def_matrix_over_row_configs"),
        " と同じ添字集合を使い、成分だけを ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " に取り替えた行列を扱う（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "）。写像 ",
        math(String.raw`A:R_L\times R_L\to\overline{\mathbb{Q}}`),
        " のことを代数的数を成分とする行列と呼び、その全体の集合を ",
        math(String.raw`\mathrm{Mat}_{R_L}\bigl(\overline{\mathbb{Q}}\bigr)`),
        " と書く（",
        math(String.raw`R_L`),
        " は ",
        ref("def_row_configuration"),
        "）。値 ",
        math(String.raw`A(\tau,\tau')`),
        " を成分と呼び ",
        math(String.raw`A_{\tau,\tau'}`),
        " と書く。",
      ]),
      paragraph([
        "成分の型が違うので、これは ",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " とは別の対象である。",
        "実数体も複素数体も現れない（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_matrix_product",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の積" },
    labels: ["def_qbar_matrix_product"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarRowMatrixProduct"],
    verification: ["sagemath/check/qbar-action-product"],
    statement: [
      paragraph([
        math(String.raw`A,B\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）に対し積 ",
        math(String.raw`AB\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " を",
      ]),
      displayMath(
        String.raw`(AB)_{\tau,\tau''}:=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,B_{\tau',\tau''}\qquad(\tau,\tau''\in R_L)`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`R_L`),
        " は有限集合なので右辺は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の有限個の元の和であり、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元として確定する）。",
      ]),
      paragraph([
        "成分の型が違うので、これは ",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " とその積とは別の対象である。同じ記号 ",
        math(String.raw`AB`),
        " を使うが、どちらの積かは行列の成分がどちらの集合の元かで決まる。",
        "実数体も複素数体も現れない（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_vector",
    kind: "definition",
    title: { text: "代数的数を成分とする列ベクトル" },
    labels: ["def_qbar_vector"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.QbarRowVector"],
    verification: ["sagemath/check/qbar-action-product"],
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`v:R_L\to\overline{\mathbb{Q}}`),
        " のことを列ベクトルと呼び、その全体の集合を ",
        math(String.raw`V_L:=\bigl\{\,v\mid v:R_L\to\overline{\mathbb{Q}}\,\bigr\}`),
        " と書く。値 ",
        math(String.raw`v(\tau)`),
        " を成分と呼ぶ（行列の成分と違い、添字は 1 つである）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_matrix_action",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の列ベクトルへの作用" },
    labels: ["def_qbar_matrix_action"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarAction"],
    verification: ["sagemath/check/qbar-action-product"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        " に対し、",
        math(String.raw`A`),
        " の ",
        math(String.raw`v`),
        " への作用 ",
        math(String.raw`A\cdot v\in V_L`),
        " を",
      ]),
      displayMath(
        String.raw`(A\cdot v)(\tau):=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,v(\tau')\qquad(\tau\in R_L)`,
      ),
      paragraph([
        "で定める（右辺は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の有限個の元の和である）。",
        "作用を表す点 ",
        math(String.raw`\cdot`),
        " は、行列どうしの積（",
        ref("def_qbar_matrix_product"),
        "）と区別するために書く。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_action_product",
    kind: "claim",
    title: { text: "行列の積の作用は、作用を 2 度施したものである" },
    labels: ["claim_qbar_action_product"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_product",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_product_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_product_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-action-product"],
    statement: [
      paragraph([
        math(String.raw`A,B\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`(AB)\cdot v=A\cdot(B\cdot v)`),
      paragraph([
        "が成り立つ（左辺の ",
        math(String.raw`AB`),
        " は ",
        ref("def_qbar_matrix_product"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((AB)\cdot v\bigr)(\tau)
&=\sum_{\tau''\in R_L}(AB)_{\tau,\tau''}\,v(\tau'')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\sum_{\tau''\in R_L}\Bigl(\sum_{\tau'\in R_L}A_{\tau,\tau'}\,B_{\tau',\tau''}\Bigr)v(\tau'')
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=\sum_{\tau''\in R_L}\ \sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\,B_{\tau',\tau''}\bigr)v(\tau'')
&&(\because\ \text{有限和と元の積についての分配則})\\
&=\sum_{\tau''\in R_L}\ \sum_{\tau'\in R_L}A_{\tau,\tau'}\bigl(B_{\tau',\tau''}\,v(\tau'')\bigr)
&&(\because\ \text{積の結合則})\\
&=\sum_{\tau'\in R_L}\ \sum_{\tau''\in R_L}A_{\tau,\tau'}\bigl(B_{\tau',\tau''}\,v(\tau'')\bigr)
&&(\because\ \text{有限和の順序の入れ替え})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\sum_{\tau''\in R_L}B_{\tau',\tau''}\,v(\tau'')
&&(\because\ \text{元と有限和の積についての分配則})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,(B\cdot v)(\tau')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\bigl(A\cdot(B\cdot v)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_matrix_action})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の結合則と、有限和と元の積についての分配則",
        "（両側）だけである。加法の逆元も、零元でない元の逆元も、体であることも使っていない。",
        "有限和の順序の入れ替えが使えるのは ",
        math(String.raw`R_L`),
        " が有限集合で、加法が可換かつ結合的だからである。",
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和・有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_vector_add",
    kind: "definition",
    title: { text: "代数的数を成分とする列ベクトルの和" },
    labels: ["def_qbar_vector_add"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarVectorAdd"],
    verification: ["sagemath/check/qbar-action-linear"],
    statement: [
      paragraph([
        math(String.raw`v,w\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）に対し、和 ",
        math(String.raw`v\oplus w\in V_L`),
        " を",
      ]),
      displayMath(String.raw`(v\oplus w)(\tau):=v(\tau)+w(\tau)\qquad(\tau\in R_L)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`+`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の加法であり、左辺の ",
        math(String.raw`\oplus`),
        " は列ベクトルどうしの演算である。",
        "同じ記号を使うと、どちらの集合の演算かが式に書かれないので、記号を分けて書く。",
        "実数体も複素数体も現れない（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_vector_smul",
    kind: "definition",
    title: { text: "代数的数を成分とする列ベクトルのスカラー倍" },
    labels: ["def_qbar_vector_smul"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarVectorSmul"],
    verification: ["sagemath/check/qbar-action-linear"],
    statement: [
      paragraph([
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）に対し、スカラー倍 ",
        math(String.raw`z\odot v\in V_L`),
        " を",
      ]),
      displayMath(String.raw`(z\odot v)(\tau):=z\,v(\tau)\qquad(\tau\in R_L)`),
      paragraph([
        "で定める。右辺の積は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " のものであり、左辺の ",
        math(String.raw`\odot`),
        " は代数的数と列ベクトルの演算である。",
        "和（",
        ref("def_qbar_vector_add"),
        "）と同じ理由で記号を分けて書く。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_action_add",
    kind: "claim",
    title: { text: "行列の作用は列ベクトルの和を保つ" },
    labels: ["claim_qbar_action_add"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_add",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_add_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_add_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-action-linear"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v,w\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`A\cdot(v\oplus w)=(A\cdot v)\oplus(A\cdot w)`),
      paragraph([
        "が成り立つ（点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\oplus`),
        " は ",
        ref("def_qbar_vector_add"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot(v\oplus w)\bigr)(\tau)
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,(v\oplus w)(\tau')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\bigl(v(\tau')+w(\tau')\bigr)
&&(\because\ \blkref{def_qbar_vector_add})\\
&=\sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\,v(\tau')+A_{\tau,\tau'}\,w(\tau')\bigr)
&&(\because\ \text{元と 2 元の和の積についての分配則})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,v(\tau')+\sum_{\tau'\in R_L}A_{\tau,\tau'}\,w(\tau')
&&(\because\ \text{有限和の項ごとの分割})\\
&=(A\cdot v)(\tau)+(A\cdot w)(\tau)
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\bigl((A\cdot v)\oplus(A\cdot w)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_add})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、元と 2 元の和の積についての分配則と、",
        "加法が可換モノイドであること（有限和を項ごとに分けるのに要る）だけである。",
        "積の結合則も可換性も、加法の逆元も、体であることも使っていない。",
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_action_smul",
    kind: "claim",
    title: { text: "行列の作用は列ベクトルのスカラー倍を保つ" },
    labels: ["claim_qbar_action_smul"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_smul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_smul_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_smul_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-action-linear"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`A\cdot(z\odot v)=z\odot(A\cdot v)`),
      paragraph([
        "が成り立つ（点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\odot`),
        " は ",
        ref("def_qbar_vector_smul"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot(z\odot v)\bigr)(\tau)
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,(z\odot v)(\tau')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\bigl(z\,v(\tau')\bigr)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=\sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\,z\bigr)v(\tau')
&&(\because\ \text{積の結合則})\\
&=\sum_{\tau'\in R_L}\bigl(z\,A_{\tau,\tau'}\bigr)v(\tau')
&&(\because\ \text{積の可換性})\\
&=\sum_{\tau'\in R_L}z\bigl(A_{\tau,\tau'}\,v(\tau')\bigr)
&&(\because\ \text{積の結合則})\\
&=z\sum_{\tau'\in R_L}A_{\tau,\tau'}\,v(\tau')
&&(\because\ \text{元と有限和の積についての分配則})\\
&=z\,(A\cdot v)(\tau)
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\bigl(z\odot(A\cdot v)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の結合則と可換性、および元と有限和の積についての",
        "分配則だけである。",
        math(String.raw`z`),
        " を成分の左へ移す箇所で積の可換性を使っており、",
        "そこが前の主張（和を保つこと）との違いである。",
        "加法の逆元も、零元でない元の逆元も、体であることも使っていない。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_zero_vector",
    kind: "definition",
    title: { text: "零ベクトル" },
    labels: ["def_qbar_zero_vector"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarZeroVector"],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        "零ベクトル ",
        math(String.raw`o_L\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を",
      ]),
      displayMath(String.raw`o_L(\tau):=0\qquad(\tau\in R_L)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`0`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の零元である。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_eigenvector",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の固有ベクトル" },
    labels: ["def_qbar_eigenvector"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.IsQbarEigenvector"],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`v\in V_L`),
        " について、",
      ]),
      displayMath(String.raw`A\cdot v=z\odot v\quad\text{かつ}\quad v\ne o_L`),
      paragraph([
        "が成り立つとき、",
        math(String.raw`v`),
        " は ",
        math(String.raw`A`),
        " の ",
        math(String.raw`z`),
        " に属する固有ベクトルであるという（点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\odot`),
        " は ",
        ref("def_qbar_vector_smul"),
        "、",
        math(String.raw`o_L`),
        " は ",
        ref("def_qbar_zero_vector"),
        "）。",
        "零ベクトルを除くのは、除かないと任意の ",
        math(String.raw`z`),
        " について ",
        math(String.raw`o_L`),
        " が条件を満たしてしまい、",
        math(String.raw`z`),
        " が ",
        math(String.raw`A`),
        " から何も決まらなくなるためである。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_eigenvalue",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の固有値" },
    labels: ["def_qbar_eigenvalue"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.IsQbarEigenvalue"],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " について、",
        math(String.raw`z`),
        " に属する ",
        math(String.raw`A`),
        " の固有ベクトル（",
        ref("def_qbar_eigenvector"),
        "）が少なくとも 1 つ存在するとき、",
        math(String.raw`z`),
        " は ",
        math(String.raw`A`),
        " の固有値であるという。",
      ]),
      paragraph([
        "固有ベクトルは ",
        math(String.raw`V_L`),
        " の元、固有値は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元であり、別の集合の対象である。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_eigenspace",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の固有空間" },
    labels: ["def_qbar_eigenspace"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarEigenspace"],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " に対し、",
      ]),
      displayMath(
        String.raw`E_{A}(z):=\{\,v\in V_L\mid A\cdot v=z\odot v\,\}\subset V_L`,
      ),
      paragraph([
        "と定める。",
        "固有ベクトルの定義（",
        ref("def_qbar_eigenvector"),
        "）と違い、条件から ",
        math(String.raw`v\ne o_L`),
        " を外してある。",
        "外すのは、外さないと和とスカラー倍で閉じなくなるためである",
        "（",
        math(String.raw`v`),
        " が条件を満たすとき ",
        math(String.raw`0\odot v=o_L`),
        " も満たすので、零ベクトルを除いた集合はスカラー倍で閉じない。",
        "ここで ",
        math(String.raw`0\odot v=o_L`),
        " は、各 ",
        math(String.raw`\tau\in R_L`),
        " について ",
        math(String.raw`(0\odot v)(\tau)=0\,v(\tau)=0=o_L(\tau)`),
        " であることによる。第 1 の等号はスカラー倍の定義（",
        ref("def_qbar_vector_smul"),
        "）、第 2 の等号は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の零元との積が零元であること、第 3 の等号は零ベクトルの定義（",
        ref("def_qbar_zero_vector"),
        "）である）。",
        "したがって ",
        math(String.raw`E_A(z)`),
        " の元は固有ベクトルとは限らず、",
        math(String.raw`o_L`),
        " 以外の元がちょうど ",
        math(String.raw`z`),
        " に属する固有ベクトルである。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_eigenspace_add",
    kind: "claim",
    title: { text: "固有空間は和で閉じる" },
    labels: ["claim_qbar_eigenspace_add"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarEigenspace_add",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eigenspace_add_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarEigenspace_add_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る。",
        math(String.raw`v,w\in E_{A}(z)`),
        "（",
        ref("def_qbar_eigenspace"),
        "）ならば ",
        math(String.raw`v\oplus w\in E_{A}(z)`),
        "（",
        ref("def_qbar_vector_add"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "示すべきは ",
        math(String.raw`A\cdot(v\oplus w)=z\odot(v\oplus w)`),
        " である。両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot(v\oplus w)\bigr)(\tau)
&=\bigl((A\cdot v)\oplus(A\cdot w)\bigr)(\tau)
&&(\because\ \blkref{claim_qbar_action_add})\\
&=(A\cdot v)(\tau)+(A\cdot w)(\tau)
&&(\because\ \blkref{def_qbar_vector_add})\\
&=(z\odot v)(\tau)+(z\odot w)(\tau)
&&(\because\ v,w\in E_{A}(z)\ \text{すなわち}\ \blkref{def_qbar_eigenspace})\\
&=z\,v(\tau)+z\,w(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=z\bigl(v(\tau)+w(\tau)\bigr)
&&(\because\ \text{元と 2 元の和の積についての分配則})\\
&=z\,(v\oplus w)(\tau)
&&(\because\ \blkref{def_qbar_vector_add})\\
&=\bigl(z\odot(v\oplus w)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので 2 つの写像は等しく、",
        math(String.raw`v\oplus w\in E_{A}(z)`),
        " である。",
      ]),
      paragraph([
        "この段が使っているのは、作用が和を保つこと（",
        ref("claim_qbar_action_add"),
        "）と、スカラー倍が和に配ること（第 5 段の分配則）の 2 つだけである。",
        math(String.raw`A`),
        " の成分についても ",
        math(String.raw`z`),
        " についても、それ以外の性質は使っていない。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_eigenspace_smul",
    kind: "claim",
    title: { text: "固有空間はスカラー倍で閉じる" },
    labels: ["claim_qbar_eigenspace_smul"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarEigenspace_smul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eigenspace_smul_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarEigenspace_smul_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " と ",
        math(String.raw`z,c\in\overline{\mathbb{Q}}`),
        " を任意に取る。",
        math(String.raw`v\in E_{A}(z)`),
        " ならば ",
        math(String.raw`c\odot v\in E_{A}(z)`),
        "（",
        ref("def_qbar_vector_smul"),
        "）である。",
      ]),
    ],
    proof: [
      paragraph([
        "示すべきは ",
        math(String.raw`A\cdot(c\odot v)=z\odot(c\odot v)`),
        " である。両辺は ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot(c\odot v)\bigr)(\tau)
&=\bigl(c\odot(A\cdot v)\bigr)(\tau)
&&(\because\ \blkref{claim_qbar_action_smul})\\
&=c\,(A\cdot v)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=c\,(z\odot v)(\tau)
&&(\because\ v\in E_{A}(z)\ \text{すなわち}\ \blkref{def_qbar_eigenspace})\\
&=c\bigl(z\,v(\tau)\bigr)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=(c\,z)\,v(\tau)
&&(\because\ \text{積の結合則})\\
&=(z\,c)\,v(\tau)
&&(\because\ \text{積の可換性})\\
&=z\bigl(c\,v(\tau)\bigr)
&&(\because\ \text{積の結合則})\\
&=z\,(c\odot v)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=\bigl(z\odot(c\odot v)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので 2 つの写像は等しく、",
        math(String.raw`c\odot v\in E_{A}(z)`),
        " である。",
      ]),
      paragraph([
        "この段が使っているのは、作用がスカラー倍を保つこと（",
        ref("claim_qbar_action_smul"),
        "）と、2 つのスカラー倍が交換できること（第 5 段から第 7 段の、結合則・可換性・結合則）の",
        "2 つだけである。前の主張（和で閉じること）が積の可換性を使わなかったのに対し、",
        "この主張は ",
        math(String.raw`c`),
        " と ",
        math(String.raw`z`),
        " の順を入れ替える箇所で使っている。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_identity_matrix",
    kind: "definition",
    title: { text: "代数的数を成分とする単位行列" },
    labels: ["def_qbar_identity_matrix"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarIdentityMatrix"],
    verification: ["sagemath/check/qbar-identity-action"],
    statement: [
      paragraph([
        "単位行列 ",
        math(String.raw`I^{\overline{\mathbb{Q}}}_L\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）を",
      ]),
      displayMath(String.raw`\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}:=\begin{cases}1&(\tau'=\tau)\\0&(\tau'\ne\tau)\end{cases}\qquad(\tau,\tau'\in R_L)`),
      paragraph([
        "で定める。右辺の ",
        math(String.raw`1`),
        " と ",
        math(String.raw`0`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の単位元と零元である。",
        "場合分けが意味をもつのは、",
        math(String.raw`R_L`),
        " の 2 元が等しいか否かが判定できるからである（行配位は有限集合 ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の上の写像なので、値を突き合わせれば決まる）。",
      ]),
      paragraph([
        "成分の型が違うので、これは ",
        ref("def_identity_matrix"),
        " で置いた ",
        math(String.raw`\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " の単位行列 ",
        math(String.raw`I`),
        " とは別の対象である。上付きの ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は、どちらの集合の単位行列かを記号に残すためのものである。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_identity_action",
    kind: "claim",
    title: { text: "単位行列の作用は列ベクトルを動かさない" },
    labels: ["claim_qbar_identity_action"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarIdentity_action",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarIdentity_action_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-identity-action"],
    statement: [
      paragraph([
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`I^{\overline{\mathbb{Q}}}_L\cdot v=v`),
      paragraph([
        "が成り立つ（左辺の単位行列は ",
        ref("def_qbar_identity_matrix"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(I^{\overline{\mathbb{Q}}}_L\cdot v\bigr)(\tau)
&=\sum_{\tau'\in R_L}\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}\,v(\tau')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau}\,v(\tau)
+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}\,v(\tau')
&&(\because\ \text{有限和から }\tau'=\tau\text{ の 1 項を分ける})\\
&=1\cdot v(\tau)+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0\cdot v(\tau')
&&(\because\ \blkref{def_qbar_identity_matrix})\\
&=v(\tau)+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0\cdot v(\tau')
&&(\because\ \text{単位元との積})\\
&=v(\tau)+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0
&&(\because\ \text{零元との積})\\
&=v(\tau)+0
&&(\because\ \text{零元だけの有限和は零元である})\\
&=v(\tau)
&&(\because\ \text{零元を足しても変わらない})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、単位元との積・零元との積・零元との和の 3 つだけである",
        "（加法の逆元も、零元でない元の逆元も、積の可換性も、体であることも使っていない）。",
        math(String.raw`R_L`),
        " について使っているのは、有限集合であることと 2 元の相等が判定できることの 2 つだけである",
        "（1 項を分ける段と、場合分けの段でそれぞれ効く）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_matrix_power",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の冪" },
    labels: ["def_qbar_matrix_power"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarMatrixPow"],
    verification: ["sagemath/check/qbar-action-pow"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`k\in\mathbb{N}`),
        " に対し、冪 ",
        math(String.raw`A^{k}\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " を ",
        math(String.raw`k`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`A^{0}:=I^{\overline{\mathbb{Q}}}_L,\qquad A^{k+1}:=A\,A^{k}\qquad(k\in\mathbb{N})`),
      paragraph([
        "と定める（右辺の単位行列は ",
        ref("def_qbar_identity_matrix"),
        "、積は ",
        ref("def_qbar_matrix_product"),
        "）。",
      ]),
      paragraph([
        "2 点、",
        ref("def_matrix_over_row_configs"),
        " で置いた ",
        math(String.raw`\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " の冪との違いを書いておく。第一に、成分の型が違うので別の対象である",
        "（同じ記号 ",
        math(String.raw`A^{k}`),
        " を使うが、どちらの冪かは行列の成分がどちらの集合の元かで決まる）。",
        "第二に、出発点と一歩の取り方が違う。",
        math(String.raw`\mathbb{Z}[x]`),
        " の側は ",
        math(String.raw`A^{1}:=A`),
        " から始めて ",
        math(String.raw`A^{k+1}:=A^{k}A`),
        " と右から掛けるが、ここでは ",
        math(String.raw`A^{0}:=I^{\overline{\mathbb{Q}}}_L`),
        " から始めて左から掛ける。左から掛けるのは、次の主張の帰納法の一歩で ",
        math(String.raw`A^{k+1}`),
        " から左の因子 ",
        math(String.raw`A`),
        " を 1 つ外し、残りへ帰納法の仮定を当てるためである",
        "（",
        ref("claim_qbar_action_product"),
        " が外せるのは左の因子である）。",
        math(String.raw`k=0`),
        " から始めるのは、その出発点が ",
        ref("claim_qbar_identity_action"),
        " でそのまま済むためである。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_action_iterate",
    kind: "definition",
    title: { text: "代数的数を成分とする行列の作用の反復" },
    labels: ["def_qbar_action_iterate"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarActionIterate"],
    verification: ["sagemath/check/qbar-action-pow"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）と ",
        math(String.raw`k\in\mathbb{N}`),
        " に対し、作用（",
        ref("def_qbar_matrix_action"),
        "）を ",
        math(String.raw`k`),
        " 回反復した列ベクトル ",
        math(String.raw`\mathrm{it}^{[k]}_{A}(v)\in V_L`),
        " を ",
        math(String.raw`k`),
        " についての帰納法で",
      ]),
      displayMath(String.raw`\mathrm{it}^{[0]}_{A}(v):=v,\qquad \mathrm{it}^{[k+1]}_{A}(v):=A\cdot\bigl(\mathrm{it}^{[k]}_{A}(v)\bigr)\qquad(k\in\mathbb{N})`),
      paragraph([
        "と定める。上付きの角括弧は、これが積の反復ではなく作用の反復であることを記号に残すための",
        "ものである（",
        ref("def_row_config_shift_iterate"),
        " の ",
        math(String.raw`S^{[k]}`),
        " と同じ約束である）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_action_pow",
    kind: "claim",
    title: { text: "行列の冪の作用は、作用を反復したものである" },
    labels: ["claim_qbar_action_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_pow_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-action-pow"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`A^{k}\cdot v=\mathrm{it}^{[k]}_{A}(v)`),
      paragraph([
        "が成り立つ（左辺の冪は ",
        ref("def_qbar_matrix_power"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "、右辺は ",
        ref("def_qbar_action_iterate"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A`),
        " と ",
        math(String.raw`v`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{0}\cdot v
&=I^{\overline{\mathbb{Q}}}_L\cdot v
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=v
&&(\because\ \blkref{claim_qbar_identity_action})\\
&=\mathrm{it}^{[0]}_{A}(v)
&&(\because\ \blkref{def_qbar_action_iterate})
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " の場合に ",
        math(String.raw`A^{k}\cdot v=\mathrm{it}^{[k]}_{A}(v)`),
        " が成り立つとして、",
        math(String.raw`k+1`),
        " の場合を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{k+1}\cdot v
&=\bigl(A\,A^{k}\bigr)\cdot v
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=A\cdot\bigl(A^{k}\cdot v\bigr)
&&(\because\ \blkref{claim_qbar_action_product})\\
&=A\cdot\bigl(\mathrm{it}^{[k]}_{A}(v)\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=\mathrm{it}^{[k+1]}_{A}(v)
&&(\because\ \blkref{def_qbar_action_iterate})
\end{aligned}`),
      paragraph([
        "よって任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について新しく使っているものは無い。使っているのは上の各行で引いた 2 つの主張",
        "（単位行列の作用が列ベクトルを動かさないことと、行列の積の作用が作用を 2 度施した",
        "ものであること）と、2 つの定義の再帰の式だけである。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_eigenvector_pow",
    kind: "claim",
    title: { text: "固有ベクトルへ行列の冪を作用させると、固有値の冪のスカラー倍になる" },
    labels: ["claim_qbar_eigenvector_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow_smul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_pow_smul_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_pow_smul_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-eigenvector-pow"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）が ",
        math(String.raw`A\cdot v=z\odot v`),
        " を満たすとする。このとき任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`A^{k}\cdot v=z^{k}\odot v`),
      paragraph([
        "が成り立つ（左辺の冪は ",
        ref("def_qbar_matrix_power"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\odot`),
        " は ",
        ref("def_qbar_vector_smul"),
        "、右辺の ",
        math(String.raw`z^{k}`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の積の反復で ",
        math(String.raw`z^{0}=1`),
        "・",
        math(String.raw`z^{k+1}=z^{k}z`),
        " と約束したもの（",
        ref("def_root_of_unity_set"),
        "）である）。",
      ]),
      paragraph([
        "仮定は ",
        ref("def_qbar_eigenvector"),
        " の 2 条件のうち等式の側だけである。",
        math(String.raw`v\ne o_L`),
        " は使わないので、",
        math(String.raw`z`),
        " に属する固有ベクトルにはこの主張がそのまま当たる。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、スカラー倍についての 2 つの等式を作る。",
        "第一に、任意の ",
        math(String.raw`w\in V_L`),
        " と任意の ",
        math(String.raw`\tau\in R_L`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
(1\odot w)(\tau)
&=1\,w(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=w(\tau)
&&(\because\ \overline{\mathbb{Q}}\ \text{の単位元との積})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\tau`),
        " は任意なので ",
        math(String.raw`1\odot w=w`),
        " である。第二に、任意の ",
        math(String.raw`y,z\in\overline{\mathbb{Q}}`),
        " と任意の ",
        math(String.raw`w\in V_L`),
        " と任意の ",
        math(String.raw`\tau\in R_L`),
        " について",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((y\,z)\odot w\bigr)(\tau)
&=(y\,z)\,w(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=y\,\bigl(z\,w(\tau)\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=y\,\bigl((z\odot w)(\tau)\bigr)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=\bigl(y\odot(z\odot w)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})
\end{aligned}`),
      paragraph([
        "であり、",
        math(String.raw`\tau`),
        " は任意なので ",
        math(String.raw`(y\,z)\odot w=y\odot(z\odot w)`),
        " である。",
      ]),
      paragraph([
        math(String.raw`A`),
        " と ",
        math(String.raw`v`),
        " と ",
        math(String.raw`z`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{0}\cdot v
&=I^{\overline{\mathbb{Q}}}_L\cdot v
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=v
&&(\because\ \blkref{claim_qbar_identity_action})\\
&=1\odot v
&&(\because\ \text{準備の第 1 の等式})\\
&=z^{0}\odot v
&&(\because\ z^{0}=1\ \text{の約束。}\ \blkref{def_root_of_unity_set})
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " の場合に ",
        math(String.raw`A^{k}\cdot v=z^{k}\odot v`),
        " が成り立つとして、",
        math(String.raw`k+1`),
        " の場合を示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{k+1}\cdot v
&=\bigl(A\,A^{k}\bigr)\cdot v
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=A\cdot\bigl(A^{k}\cdot v\bigr)
&&(\because\ \blkref{claim_qbar_action_product})\\
&=A\cdot\bigl(z^{k}\odot v\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=z^{k}\odot\bigl(A\cdot v\bigr)
&&(\because\ \blkref{claim_qbar_action_smul})\\
&=z^{k}\odot\bigl(z\odot v\bigr)
&&(\because\ \text{仮定}\ A\cdot v=z\odot v)\\
&=\bigl(z^{k}z\bigr)\odot v
&&(\because\ \text{準備の第 2 の等式})\\
&=z^{k+1}\odot v
&&(\because\ z^{k+1}=z^{k}z\ \text{の約束。}\ \blkref{def_root_of_unity_set})
\end{aligned}`),
      paragraph([
        "よって任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、単位元との積と積の結合則だけである",
        "（準備の 2 つの等式でだけ使う。逆元も、可換性も、体であることも使わない）。",
        "行列については上の各行で引いた 3 つの主張だけを使う。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_matrix_eval",
    kind: "definition",
    title: { text: "整係数多項式を成分とする行列の、代数的数における値" },
    labels: ["def_qbar_matrix_eval"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval"],
    verification: ["sagemath/check/qbar-matrix-eval"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        " を任意に取る（",
        ref("def_algebraic_numbers"),
        "）。",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        " に対し、行列 ",
        math(String.raw`\mathrm{Ev}_{\xi}(A)\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）を、その成分により",
      ]),
      displayMath(
        String.raw`\bigl(\mathrm{Ev}_{\xi}(A)\bigr)_{\tau,\tau'}:=\bigl(A_{\tau,\tau'}\bigr)(\xi)\qquad(\tau,\tau'\in R_L)`,
      ),
      paragraph([
        "で定める。ここで ",
        math(String.raw`\bigl(A_{\tau,\tau'}\bigr)(\xi)\in\overline{\mathbb{Q}}`),
        " は ",
        ref("def_partition_polynomial"),
        " で約束した意味での代入（可換環 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " とその元 ",
        math(String.raw`\xi`),
        " についての評価）である。",
      ]),
      paragraph([
        "丸括弧が付いたものだけが代入である。",
        math(String.raw`A_{\tau,\tau'}\in\mathbb{Z}[x]`),
        " は多項式そのもの、",
        math(String.raw`\bigl(A_{\tau,\tau'}\bigr)(\xi)\in\overline{\mathbb{Q}}`),
        " はその値であり、",
        math(String.raw`\mathrm{Ev}_{\xi}`),
        " は行列を行列へ送る写像であって行列の成分ではない。",
      ]),
      paragraph([
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和・有限積だけであり、実数体も複素数体も現れない（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である。",
        ref("def_algebraic_numbers"),
        "）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_matrix_eval_product",
    kind: "claim",
    title: { text: "成分ごとの評価は行列の積を保つ" },
    labels: ["claim_qbar_matrix_eval_product"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_product",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.matEval_product_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_product_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-matrix-eval"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`A,B\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        "（",
        ref("def_matrix_over_row_configs"),
        "）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\mathrm{Ev}_{\xi}(AB)=\mathrm{Ev}_{\xi}(A)\,\mathrm{Ev}_{\xi}(B)`,
      ),
      paragraph([
        "が成り立つ（左辺の積は ",
        ref("def_matrix_product"),
        " の ",
        math(String.raw`\mathbb{Z}[x]`),
        " の行列の積、右辺の積は ",
        ref("def_qbar_matrix_product"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の行列の積であり、別の演算である。",
        math(String.raw`\mathrm{Ev}_{\xi}`),
        " は ",
        ref("def_qbar_matrix_eval"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_qbar_matrix"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau''\in R_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{Ev}_{\xi}(AB)\bigr)_{\tau,\tau''}
&=\bigl((AB)_{\tau,\tau''}\bigr)(\xi)
&&(\because\ \blkref{def_qbar_matrix_eval})\\
&=\Bigl(\sum_{\tau'\in R_L}A_{\tau,\tau'}\,B_{\tau',\tau''}\Bigr)(\xi)
&&(\because\ \blkref{def_matrix_product})\\
&=\sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\,B_{\tau',\tau''}\bigr)(\xi)
&&(\because\ \text{代入が有限和を保つこと。}\ \blkref{def_partition_polynomial})\\
&=\sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\bigr)(\xi)\,\bigl(B_{\tau',\tau''}\bigr)(\xi)
&&(\because\ \text{代入が積を保つこと。}\ \blkref{def_partition_polynomial})\\
&=\sum_{\tau'\in R_L}\bigl(\mathrm{Ev}_{\xi}(A)\bigr)_{\tau,\tau'}\,\bigl(\mathrm{Ev}_{\xi}(B)\bigr)_{\tau',\tau''}
&&(\because\ \blkref{def_qbar_matrix_eval}\ \text{を 2 箇所へ適用})\\
&=\bigl(\mathrm{Ev}_{\xi}(A)\,\mathrm{Ev}_{\xi}(B)\bigr)_{\tau,\tau''}
&&(\because\ \blkref{def_qbar_matrix_product})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau`),
        " と ",
        math(String.raw`\tau''`),
        " は任意なので、2 つの行列のすべての成分が等しく、主張が成り立つ。",
      ]),
      paragraph([
        "この段が使っているのは、代入が有限和と積を保つこと（",
        ref("def_partition_polynomial"),
        " で置いた約束であり、証明すべきことではない）と、2 つの積の定義だけである。",
        math(String.raw`R_L`),
        " が有限集合であること（",
        ref("def_row_configuration"),
        "）から和は有限個の項からなる。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_matrix_eval_identity",
    kind: "claim",
    title: { text: "成分ごとの評価は単位行列を単位行列へ写す" },
    labels: ["claim_qbar_matrix_eval_identity"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_identity",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.matEval_identity_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_identity_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-matrix-eval-identity"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。",
        ref("def_identity_matrix"),
        " の単位行列 ",
        math(String.raw`I\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " と ",
        ref("def_qbar_identity_matrix"),
        " の単位行列 ",
        math(String.raw`I^{\overline{\mathbb{Q}}}_L\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " について",
      ]),
      displayMath(String.raw`\mathrm{Ev}_{\xi}(I)=I^{\overline{\mathbb{Q}}}_L`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{Ev}_{\xi}`),
        " は ",
        ref("def_qbar_matrix_eval"),
        "）。左辺と右辺は成分の型が違う 2 つの単位行列を結ぶ等式であり、同一視ではない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_qbar_matrix"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau'\in R_L`),
        " を任意に取る。",
        ref("def_row_configuration"),
        " の行配位の 2 元が等しいか否かは判定できるので、次の 2 つの場合に分かれる。",
      ]),
      paragraph([
        math(String.raw`\tau=\tau'`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{Ev}_{\xi}(I)\bigr)_{\tau,\tau'}
&=\bigl(I_{\tau,\tau'}\bigr)(\xi)
&&(\because\ \blkref{def_qbar_matrix_eval})\\
&=\bigl(\kappa(1)\bigr)(\xi)
&&(\because\ \blkref{def_identity_matrix}\ \text{の}\ \tau=\tau'\ \text{の場合})\\
&=1
&&(\because\ \text{代入が単位元を単位元へ送ること}\ \blkref{def_partition_polynomial}\text{。}\ \kappa(1)\ \text{が}\ \mathbb{Z}[x]\ \text{の単位元であることは}\ \blkref{def_constant_polynomial})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}
&&(\because\ \blkref{def_qbar_identity_matrix}\ \text{の}\ \tau'=\tau\ \text{の場合})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\ne\tau'`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{Ev}_{\xi}(I)\bigr)_{\tau,\tau'}
&=\bigl(I_{\tau,\tau'}\bigr)(\xi)
&&(\because\ \blkref{def_qbar_matrix_eval})\\
&=\bigl(\kappa(0)\bigr)(\xi)
&&(\because\ \blkref{def_identity_matrix}\ \text{の}\ \tau\ne\tau'\ \text{の場合})\\
&=0
&&(\because\ \text{代入が零元を零元へ送ること}\ \blkref{def_partition_polynomial}\text{。}\ \kappa(0)\ \text{が}\ \mathbb{Z}[x]\ \text{の零元であることは}\ \blkref{def_constant_polynomial})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}
&&(\because\ \blkref{def_qbar_identity_matrix}\ \text{の}\ \tau'\ne\tau\ \text{の場合})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau`),
        " と ",
        math(String.raw`\tau'`),
        " は任意なので、2 つの行列のすべての成分が等しく、主張が成り立つ。",
      ]),
      paragraph([
        "この段が使っているのは、代入が ",
        math(String.raw`\mathbb{Z}[x]`),
        " の単位元と零元をそれぞれ ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の単位元と零元へ送ること（",
        ref("def_partition_polynomial"),
        " で置いた約束であり、証明すべきことではない）と、2 つの単位行列の定義だけである。",
        "有限和も有限積も現れず、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_matrix_product_assoc",
    kind: "claim",
    title: { text: "代数的数を成分とする行列の積は結合的である" },
    labels: ["claim_qbar_matrix_product_assoc"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixProduct_assoc",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_product_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixProduct_assoc_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-matrix-product-assoc"],
    statement: [
      paragraph([
        math(String.raw`A,B,C\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`(AB)C=A(BC)`),
      paragraph([
        "が成り立つ（積はいずれも ",
        ref("def_qbar_matrix_product"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_qbar_matrix"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau'''\in R_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl((AB)C\bigr)_{\tau,\tau'''}
&=\sum_{\tau''\in R_L}(AB)_{\tau,\tau''}\,C_{\tau'',\tau'''}
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=\sum_{\tau''\in R_L}\Bigl(\sum_{\tau'\in R_L}A_{\tau,\tau'}\,B_{\tau',\tau''}\Bigr)C_{\tau'',\tau'''}
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=\sum_{\tau''\in R_L}\ \sum_{\tau'\in R_L}\bigl(A_{\tau,\tau'}\,B_{\tau',\tau''}\bigr)C_{\tau'',\tau'''}
&&(\because\ \text{有限和と元の積についての分配則})\\
&=\sum_{\tau''\in R_L}\ \sum_{\tau'\in R_L}A_{\tau,\tau'}\bigl(B_{\tau',\tau''}\,C_{\tau'',\tau'''}\bigr)
&&(\because\ \text{積の結合則})\\
&=\sum_{\tau'\in R_L}\ \sum_{\tau''\in R_L}A_{\tau,\tau'}\bigl(B_{\tau',\tau''}\,C_{\tau'',\tau'''}\bigr)
&&(\because\ \text{有限和の順序の入れ替え})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\sum_{\tau''\in R_L}B_{\tau',\tau''}\,C_{\tau'',\tau'''}
&&(\because\ \text{元と有限和の積についての分配則})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,(BC)_{\tau',\tau'''}
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=\bigl(A(BC)\bigr)_{\tau,\tau'''}
&&(\because\ \blkref{def_qbar_matrix_product})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau`),
        " と ",
        math(String.raw`\tau'''`),
        " は任意なので、2 つの行列のすべての成分が等しく、主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の結合則と、有限和と元の積についての分配則（両側）だけである",
        "（積の可換性も、単位元も、加法の逆元も、零元でない元の逆元も、体であることも使っていない）。",
        "有限和の順序の入れ替えが使えるのは ",
        ref("def_row_configuration"),
        " の ",
        math(String.raw`R_L`),
        " が有限集合で、加法が可換かつ結合的だからである。",
        "現れるのは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元と有限和・有限積だけであり、実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張は ",
        ref("claim_qbar_action_product"),
        "（列ベクトルへの作用についての結合性）とは別の主張である。",
        "あちらは行列 2 つと列ベクトル 1 つ、こちらは行列 3 つについての等式であり、",
        "行列の冪を右から掛ける形へ書き直すにはこちらが要る。",
        "ただし証明の中身は同じ有限和の書き換えであり、",
        ref("claim_qbar_action_product"),
        " の証明で列ベクトルを ",
        math(String.raw`C`),
        " の第 ",
        math(String.raw`\tau'''`),
        " 列と取ったものに等しい（Lean では、この 2 つの主張が同じ必要十分版の 2 つの特殊化として",
        "得られることを導出で見せている）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_identity_matrix_unit",
    kind: "claim",
    title: { text: "代数的数を成分とする単位行列は積の単位元である" },
    labels: ["claim_qbar_identity_matrix_unit"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarIdentityMatrix_mul",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrix_mul_qbarIdentityMatrix",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.identity_action_right_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarIdentityMatrix_mul_from_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrix_mul_qbarIdentityMatrix_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-identity-matrix-unit"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`I^{\overline{\mathbb{Q}}}_L\,A=A\qquad\text{かつ}\qquad A\,I^{\overline{\mathbb{Q}}}_L=A`),
      paragraph([
        "が成り立つ（単位行列は ",
        ref("def_qbar_identity_matrix"),
        "、積は ",
        ref("def_qbar_matrix_product"),
        "）。",
      ]),
      paragraph([
        "これは ",
        ref("claim_qbar_identity_action"),
        "（単位行列の作用が列ベクトルを動かさないこと）とは別の主張である。",
        "あちらは行列 1 つと列ベクトル 1 つ、こちらは行列 2 つについての等式であり、",
        "右から掛ける側は列ベクトルへの作用としては書けない。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_qbar_matrix"),
        " の行列は ",
        math(String.raw`R_L\times R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像なので、2 つの行列が等しいこととすべての成分が等しいことは同じである。",
        math(String.raw`\tau,\tau''\in R_L`),
        " を任意に取る。",
      ]),
      paragraph(["左から掛ける側。"]),
      displayMath(String.raw`\begin{aligned}
\bigl(I^{\overline{\mathbb{Q}}}_L\,A\bigr)_{\tau,\tau''}
&=\sum_{\tau'\in R_L}\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}\,A_{\tau',\tau''}
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau}\,A_{\tau,\tau''}
+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau'}\,A_{\tau',\tau''}
&&(\because\ \text{有限和から }\tau'=\tau\text{ の 1 項を分ける})\\
&=1\cdot A_{\tau,\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0\cdot A_{\tau',\tau''}
&&(\because\ \blkref{def_qbar_identity_matrix})\\
&=A_{\tau,\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0\cdot A_{\tau',\tau''}
&&(\because\ \text{単位元との積})\\
&=A_{\tau,\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau}}0
&&(\because\ \text{零元との積})\\
&=A_{\tau,\tau''}+0
&&(\because\ \text{零元だけの有限和は零元である})\\
&=A_{\tau,\tau''}
&&(\because\ \text{零元を足しても変わらない})
\end{aligned}`),
      paragraph([
        "右から掛ける側。分けるのは ",
        math(String.raw`\tau'=\tau''`),
        " の項であり、単位行列の成分は第 2 添字が第 1 添字に等しいときに ",
        math(String.raw`1`),
        " なので、残る項では第 2 添字 ",
        math(String.raw`\tau''`),
        " が第 1 添字 ",
        math(String.raw`\tau'`),
        " と異なる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\,I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau,\tau''}
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\,\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau',\tau''}
&&(\because\ \blkref{def_qbar_matrix_product})\\
&=A_{\tau,\tau''}\,\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau'',\tau''}
+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau''}}A_{\tau,\tau'}\,\bigl(I^{\overline{\mathbb{Q}}}_L\bigr)_{\tau',\tau''}
&&(\because\ \text{有限和から }\tau'=\tau''\text{ の 1 項を分ける})\\
&=A_{\tau,\tau''}\cdot1+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau''}}A_{\tau,\tau'}\cdot0
&&(\because\ \blkref{def_qbar_identity_matrix})\\
&=A_{\tau,\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau''}}A_{\tau,\tau'}\cdot0
&&(\because\ \text{単位元との積})\\
&=A_{\tau,\tau''}+\sum_{\substack{\tau'\in R_L\\ \tau'\ne\tau''}}0
&&(\because\ \text{零元との積})\\
&=A_{\tau,\tau''}+0
&&(\because\ \text{零元だけの有限和は零元である})\\
&=A_{\tau,\tau''}
&&(\because\ \text{零元を足しても変わらない})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau`),
        " と ",
        math(String.raw`\tau''`),
        " は任意なので、2 つの等式のいずれも全成分で成り立ち、主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、単位元との積・零元との積・零元との和だけである",
        "（積の可換性も、積の結合則も、分配則も、加法の逆元も、零元でない元の逆元も、",
        "体であることも使っていない）。",
        "ただし左から掛ける側が使うのは ",
        math(String.raw`1\cdot a=a`),
        " と ",
        math(String.raw`0\cdot a=0`),
        "、右から掛ける側が使うのは ",
        math(String.raw`a\cdot1=a`),
        " と ",
        math(String.raw`a\cdot0=0`),
        " であり、積の可換性を使わない以上この 2 組は別々に要る。",
        math(String.raw`R_L`),
        " について使っているのは、有限集合であることと 2 元の相等が判定できることの 2 つだけである。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_matrix_pow_succ_right",
    kind: "claim",
    title: { text: "代数的数を成分とする行列の冪は右から掛けても得られる" },
    labels: ["claim_qbar_matrix_pow_succ_right"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixPow_succ_right",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_succ_right_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixPow_succ_right_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-matrix-pow-succ-right"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`k\in\mathbb{N}`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`A^{k+1}=A^{k}A`),
      paragraph([
        "が成り立つ（冪は ",
        ref("def_qbar_matrix_power"),
        "、積は ",
        ref("def_qbar_matrix_product"),
        "）。",
      ]),
      paragraph([
        ref("def_qbar_matrix_power"),
        " の冪は ",
        math(String.raw`A^{k+1}:=A\,A^{k}`),
        " と左から掛けて定めてあるので、右から掛けた形は定義ではなく主張である。",
        "これが要るのは、",
        ref("def_matrix_over_row_configs"),
        " の冪が右から掛ける形で定めてあり、",
        ref("def_qbar_matrix_eval"),
        " が冪を保つことを ",
        math(String.raw`k`),
        " についての帰納法で示すときに、一歩の向きを揃える必要があるためである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`A`),
        " を固定し、",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=0`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{0+1}
&=A\,A^{0}
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=A\,I^{\overline{\mathbb{Q}}}_L
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=A
&&(\because\ \blkref{claim_qbar_identity_matrix_unit})\\
&=I^{\overline{\mathbb{Q}}}_L\,A
&&(\because\ \blkref{claim_qbar_identity_matrix_unit})\\
&=A^{0}A
&&(\because\ \blkref{def_qbar_matrix_power})
\end{aligned}`),
      paragraph([
        math(String.raw`k`),
        " について ",
        math(String.raw`A^{k+1}=A^{k}A`),
        " が成り立つとする（帰納法の仮定）。",
        math(String.raw`k+1`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
A^{(k+1)+1}
&=A\,A^{k+1}
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=A\,\bigl(A^{k}A\bigr)
&&(\because\ \text{帰納法の仮定})\\
&=\bigl(A\,A^{k}\bigr)A
&&(\because\ \blkref{claim_qbar_matrix_product_assoc})\\
&=A^{k+1}A
&&(\because\ \blkref{def_qbar_matrix_power})
\end{aligned}`),
      paragraph([
        "以上より、任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、",
        ref("claim_qbar_matrix_product_assoc"),
        " と ",
        ref("claim_qbar_identity_matrix_unit"),
        " の 2 つだけである",
        "（成分の性質は、その 2 つの主張が要求するもの以上には使っていない）。",
        "とくに、出発点で単位行列を左右の両側から掛けるので、",
        ref("claim_qbar_identity_matrix_unit"),
        " の左右 2 つの等式がどちらも要る。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_matrix_eval_pow",
    kind: "claim",
    title: { text: "成分ごとの評価は行列の冪を保つ" },
    labels: ["claim_qbar_matrix_eval_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_pow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eval_pow_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMatrixEval_pow_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-matrix-eval-pow"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`A\in\mathrm{Mat}_{R_L}\bigl(\mathbb{Z}[x]\bigr)`),
        "（",
        ref("def_matrix_over_row_configs"),
        "）と、",
        math(String.raw`k\ge1`),
        " を満たす整数 ",
        math(String.raw`k`),
        " を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\mathrm{Ev}_{\xi}\bigl(A^{k}\bigr)=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{k}`,
      ),
      paragraph([
        "が成り立つ（左辺の冪は ",
        ref("def_matrix_over_row_configs"),
        " の ",
        math(String.raw`\mathbb{Z}[x]`),
        " の行列の冪、右辺の冪は ",
        ref("def_qbar_matrix_power"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の行列の冪であり、別の演算である。",
        math(String.raw`\mathrm{Ev}_{\xi}`),
        " は ",
        ref("def_qbar_matrix_eval"),
        "）。",
      ]),
      paragraph([
        math(String.raw`k\ge1`),
        " に限るのは、",
        ref("def_matrix_over_row_configs"),
        " の冪が ",
        math(String.raw`A^{1}:=A`),
        " から始めて ",
        math(String.raw`k\ge1`),
        " についてだけ定めてあるためである",
        "（",
        math(String.raw`\mathbb{Z}[x]`),
        " の行列については単位行列を使う冪の出発点を置いていない）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\xi`),
        " と ",
        math(String.raw`A`),
        " を固定し、",
        math(String.raw`k\ge1`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        math(String.raw`k=1`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{Ev}_{\xi}\bigl(A^{1}\bigr)
&=\mathrm{Ev}_{\xi}(A)
&&(\because\ \blkref{def_matrix_over_row_configs})\\
&=\mathrm{Ev}_{\xi}(A)\,I^{\overline{\mathbb{Q}}}_L
&&(\because\ \blkref{claim_qbar_identity_matrix_unit})\\
&=\mathrm{Ev}_{\xi}(A)\,\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{0}
&&(\because\ \blkref{def_qbar_matrix_power})\\
&=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{1}
&&(\because\ \blkref{def_qbar_matrix_power})
\end{aligned}`),
      paragraph([
        math(String.raw`k\ge1`),
        " について ",
        math(String.raw`\mathrm{Ev}_{\xi}(A^{k})=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{k}`),
        " が成り立つとする（帰納法の仮定）。",
        math(String.raw`k+1`),
        " のとき。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{Ev}_{\xi}\bigl(A^{k+1}\bigr)
&=\mathrm{Ev}_{\xi}\bigl(A^{k}A\bigr)
&&(\because\ \blkref{def_matrix_over_row_configs})\\
&=\mathrm{Ev}_{\xi}\bigl(A^{k}\bigr)\,\mathrm{Ev}_{\xi}(A)
&&(\because\ \blkref{claim_qbar_matrix_eval_product})\\
&=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{k}\,\mathrm{Ev}_{\xi}(A)
&&(\because\ \text{帰納法の仮定})\\
&=\bigl(\mathrm{Ev}_{\xi}(A)\bigr)^{k+1}
&&(\because\ \blkref{claim_qbar_matrix_pow_succ_right})
\end{aligned}`),
      paragraph([
        "以上より、",
        math(String.raw`k\ge1`),
        " を満たす任意の整数 ",
        math(String.raw`k`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "2 つの冪は出発点も一歩の向きも違うので、一歩を合わせるために ",
        ref("claim_qbar_matrix_pow_succ_right"),
        " が要る。これが最後の段である。",
        "出発点の側は、",
        math(String.raw`\mathbb{Z}[x]`),
        " の冪が ",
        math(String.raw`k=1`),
        " から始まるので、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の側でも ",
        math(String.raw`k=1`),
        " に合わせる必要があり、そこで ",
        ref("claim_qbar_identity_matrix_unit"),
        " の右から掛ける側を使う。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、上の各行で引いた 3 つの主張だけである",
        "（代入については ",
        ref("claim_qbar_matrix_eval_product"),
        " を通してしか触れていない）。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_smul_eq_zero",
    kind: "claim",
    title: { text: "零でない列ベクトルのスカラー倍が零ベクトルならば、スカラーは 0 である" },
    labels: ["claim_qbar_smul_eq_zero"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarSmul_eq_zero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.smul_eq_zero_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarSmul_eq_zero_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-smul-eq-zero"],
    statement: [
      paragraph([
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。",
        math(String.raw`z\odot v=o_L`),
        "（",
        ref("def_qbar_vector_smul"),
        "、",
        ref("def_qbar_zero_vector"),
        "）かつ ",
        math(String.raw`v\ne o_L`),
        " ならば ",
        math(String.raw`z=0`),
        " である（",
        math(String.raw`0`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の零元）。",
      ]),
      paragraph([
        math(String.raw`v\ne o_L`),
        " という仮定は落とせない。",
        math(String.raw`v=o_L`),
        " のときは任意の ",
        math(String.raw`z`),
        " について ",
        math(String.raw`z\odot v=o_L`),
        " が成り立つからである。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`V_L`),
        " の元は ",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像であり（",
        ref("def_qbar_vector"),
        "）、2 つの写像が等しいことは各点で値が等しいことである。",
        "したがって ",
        math(String.raw`v\ne o_L`),
        " から、",
        math(String.raw`v(\tau_1)\ne o_L(\tau_1)`),
        " を満たす ",
        math(String.raw`\tau_1\in R_L`),
        " が存在する（",
        ref("def_row_configuration"),
        "）。この ",
        math(String.raw`\tau_1`),
        " を 1 つ固定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
v(\tau_1)&\ne o_L(\tau_1)
&&(\because\ \tau_1\ \text{の取り方})\\
&=0
&&(\because\ \blkref{def_qbar_zero_vector})
\end{aligned}`),
      paragraph([
        "すなわち ",
        math(String.raw`v(\tau_1)\ne0`),
        " である。次に、この点での値を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,v(\tau_1)
&=(z\odot v)(\tau_1)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=o_L(\tau_1)
&&(\because\ \text{仮定}\ z\odot v=o_L)\\
&=0
&&(\because\ \blkref{def_qbar_zero_vector})
\end{aligned}`),
      paragraph([
        math(String.raw`\overline{\mathbb{Q}}`),
        " は体なので ",
        math(String.raw`v(\tau_1)`),
        " は積についての逆元 ",
        math(String.raw`v(\tau_1)^{-1}\in\overline{\mathbb{Q}}`),
        " を持つ（",
        ref("def_algebraic_numbers"),
        "。",
        math(String.raw`v(\tau_1)\ne0`),
        " は上で示した）。",
      ]),
      displayMath(String.raw`\begin{aligned}
z&=z\cdot1
&&(\because\ 1\ \text{は積の単位元})\\
&=z\cdot\bigl(v(\tau_1)\,v(\tau_1)^{-1}\bigr)
&&(\because\ v(\tau_1)^{-1}\ \text{は}\ v(\tau_1)\ \text{の積についての逆元})\\
&=\bigl(z\,v(\tau_1)\bigr)\,v(\tau_1)^{-1}
&&(\because\ \text{積の結合則})\\
&=0\cdot v(\tau_1)^{-1}
&&(\because\ \text{上の鎖で得た}\ z\,v(\tau_1)=0)\\
&=0
&&(\because\ \text{零元との積は零元である})
\end{aligned}`),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、零でない元が積についての逆元を持つことだけである",
        "（",
        ref("def_algebraic_numbers"),
        "。代数閉であることも、各元が ",
        math(String.raw`\mathbb{Q}`),
        " 上代数的であることも使っていない）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_shift_matrix_eigenvalue_root_of_unity",
    kind: "claim",
    title: { text: "シフト行列の固有値は 1 の L 乗根である" },
    labels: ["claim_shift_matrix_eigenvalue_root_of_unity"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_eigenvalue_rootOfUnity",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.eigenvalue_pow_eq_one_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.shiftMatrix_eigenvalue_rootOfUnity_from_necSuf",
    ],
    verification: ["sagemath/check/shift-matrix-eigenvalue-root-of-unity"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取り、",
        ref("def_shift_matrix"),
        " のシフト行列 ",
        math(String.raw`U\in\mathrm{Mat}_{R_L}(\mathbb{Z}[x])`),
        " を ",
        ref("def_qbar_matrix_eval"),
        " で運んだ行列 ",
        math(String.raw`\mathrm{Ev}_{\xi}(U)\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        " を考える。",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " が ",
        math(String.raw`\mathrm{Ev}_{\xi}(U)`),
        " の固有値（",
        ref("def_qbar_eigenvalue"),
        "）ならば",
      ]),
      displayMath(String.raw`z\in\mu_{L}`),
      paragraph([
        "である（",
        math(String.raw`\mu_{L}`),
        " は ",
        ref("def_root_of_unity_set"),
        "。すなわち ",
        math(String.raw`z^{L}=1`),
        "）。",
      ]),
      paragraph([
        "この主張は ",
        math(String.raw`\xi`),
        " の取り方によらない。",
        ref("def_shift_matrix"),
        " のシフト行列の成分は ",
        math(String.raw`\kappa(1)`),
        " と ",
        math(String.raw`\kappa(0)`),
        " という定数多項式だけであり（",
        ref("def_constant_polynomial"),
        "）、代入しても値は ",
        math(String.raw`1`),
        " と ",
        math(String.raw`0`),
        " のままだからである。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_qbar_eigenvalue"),
        " より、",
        math(String.raw`\mathrm{Ev}_{\xi}(U)\cdot v=z\odot v`),
        " かつ ",
        math(String.raw`v\ne o_L`),
        " を満たす ",
        math(String.raw`v\in V_L`),
        " が存在する（",
        ref("def_qbar_eigenvector"),
        "、",
        ref("def_qbar_vector"),
        "）。この ",
        math(String.raw`v`),
        " を 1 つ固定する。",
        ref("def_lattice"),
        " の格子は ",
        math(String.raw`L\ge1`),
        " を満たす。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\mathrm{Ev}_{\xi}(U)\bigr)^{L}
&=\mathrm{Ev}_{\xi}\bigl(U^{L}\bigr)
&&(\because\ \blkref{claim_qbar_matrix_eval_pow}\text{。}\ L\ge1\ \text{は}\ \blkref{def_lattice})\\
&=\mathrm{Ev}_{\xi}(I)
&&(\because\ \blkref{theorem_shift_matrix_order})\\
&=I^{\overline{\mathbb{Q}}}_L
&&(\because\ \blkref{claim_qbar_matrix_eval_identity})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
z^{L}\odot v
&=\bigl(\mathrm{Ev}_{\xi}(U)\bigr)^{L}\cdot v
&&(\because\ \blkref{claim_qbar_eigenvector_pow}\ \text{を}\ k=L\ \text{で使った})\\
&=I^{\overline{\mathbb{Q}}}_L\cdot v
&&(\because\ \text{上の鎖})\\
&=v
&&(\because\ \blkref{claim_qbar_identity_action})
\end{aligned}`),
      paragraph([
        "次に、",
        math(String.raw`\bigl(z^{L}+(-1)\bigr)\odot v=o_L`),
        " を示す（",
        math(String.raw`-1`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の単位元 ",
        math(String.raw`1`),
        " の加法についての逆元である）。",
        math(String.raw`V_L`),
        " の元は ",
        math(String.raw`R_L`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " への写像なので、各点で値が等しいことを示せばよい（",
        ref("def_qbar_vector"),
        "）。",
        math(String.raw`\tau\in R_L`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(\bigl(z^{L}+(-1)\bigr)\odot v\bigr)(\tau)
&=\bigl(z^{L}+(-1)\bigr)\,v(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=z^{L}\,v(\tau)+(-1)\,v(\tau)
&&(\because\ \text{分配則})\\
&=\bigl(z^{L}\odot v\bigr)(\tau)+(-1)\,v(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=v(\tau)+(-1)\,v(\tau)
&&(\because\ \text{上の鎖で得た}\ z^{L}\odot v=v)\\
&=1\cdot v(\tau)+(-1)\,v(\tau)
&&(\because\ 1\ \text{は積の単位元})\\
&=\bigl(1+(-1)\bigr)\,v(\tau)
&&(\because\ \text{分配則})\\
&=0\cdot v(\tau)
&&(\because\ -1\ \text{は}\ 1\ \text{の加法についての逆元})\\
&=0
&&(\because\ \text{零元との積は零元である})\\
&=o_L(\tau)
&&(\because\ \blkref{def_qbar_zero_vector})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので ",
        math(String.raw`\bigl(z^{L}+(-1)\bigr)\odot v=o_L`),
        " である。",
        math(String.raw`v\ne o_L`),
        " と合わせて ",
        ref("claim_qbar_smul_eq_zero"),
        " を ",
        math(String.raw`z^{L}+(-1)`),
        " と ",
        math(String.raw`v`),
        " に当てると ",
        math(String.raw`z^{L}+(-1)=0`),
        " を得る。",
      ]),
      displayMath(String.raw`\begin{aligned}
z^{L}
&=z^{L}+0
&&(\because\ 0\ \text{は加法の単位元})\\
&=z^{L}+\bigl((-1)+1\bigr)
&&(\because\ -1\ \text{は}\ 1\ \text{の加法についての逆元})\\
&=\bigl(z^{L}+(-1)\bigr)+1
&&(\because\ \text{加法の結合則})\\
&=0+1
&&(\because\ \text{上で得た}\ z^{L}+(-1)=0)\\
&=1
&&(\because\ 0\ \text{は加法の単位元})
\end{aligned}`),
      paragraph([
        math(String.raw`z^{L}=1`),
        " すなわち ",
        math(String.raw`z\in\mu_{L}`),
        " である（",
        ref("def_root_of_unity_set"),
        "）。",
      ]),
      paragraph([
        "この道筋は行列式の理論を経由していない。",
        ref("claim_shift_char_root_of_unity"),
        " は特性多項式 ",
        math(String.raw`\chi_U`),
        " の値を 0 にする代数的数が ",
        math(String.raw`\mu_{L}`),
        " に属することを述べており、こちらは固有ベクトルを持つ代数的数が ",
        math(String.raw`\mu_{L}`),
        " に属することを述べている。",
        "2 つの主張は結論が同じ集合への所属であっても仮定が違うので、一方から他方は出ない。",
        "橋を渡すには「非自明な核を持つ行列の行列式が零元であること」とその逆が要り、",
        "本文にはまだ無い。固有ベクトルの側だけで済ませたのは、",
        ref("theorem_shift_matrix_order"),
        " の ",
        math(String.raw`U^{L}=I`),
        " を運べば足り、その理論を新たに立てずに済むからである。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、上の各行で引いた主張と、体の四則の規則",
        "（分配則・単位元・加法の逆元・零元との積）だけである。実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_commuting_preserves_eigenspace",
    kind: "claim",
    title: { text: "可換な行列は固有空間を保つ" },
    labels: ["claim_qbar_commuting_preserves_eigenspace"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarCommuting_preserves_eigenspace",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.commuting_preserves_eigenspace_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarCommuting_preserves_eigenspace_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-commuting-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A,B\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を任意に取る。",
        math(String.raw`AB=BA`),
        "（",
        ref("def_qbar_matrix_product"),
        "）ならば、",
        math(String.raw`v\in E_{A}(z)`),
        "（",
        ref("def_qbar_eigenspace"),
        "）を満たす任意の ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）について",
      ]),
      displayMath(String.raw`B\cdot v\in E_{A}(z)`),
      paragraph([
        "である（点は ",
        ref("def_qbar_matrix_action"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "示すべきは ",
        math(String.raw`A\cdot(B\cdot v)=z\odot(B\cdot v)`),
        " である（",
        ref("def_qbar_eigenspace"),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
A\cdot(B\cdot v)
&=(AB)\cdot v
&&(\because\ \blkref{claim_qbar_action_product}\ \text{を右辺から左辺へ使った})\\
&=(BA)\cdot v
&&(\because\ \text{仮定}\ AB=BA)\\
&=B\cdot(A\cdot v)
&&(\because\ \blkref{claim_qbar_action_product})\\
&=B\cdot(z\odot v)
&&(\because\ v\in E_{A}(z)\ \text{すなわち}\ \blkref{def_qbar_eigenspace})\\
&=z\odot(B\cdot v)
&&(\because\ \blkref{claim_qbar_action_smul})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`B\cdot v`),
        " は ",
        ref("def_qbar_eigenspace"),
        " の条件を満たし、",
        math(String.raw`B\cdot v\in E_{A}(z)`),
        " である。",
      ]),
      paragraph([
        "この段が使っているのは、行列の積の作用が作用を 2 度施したものであること（",
        ref("claim_qbar_action_product"),
        "）と、作用がスカラー倍を保つこと（",
        ref("claim_qbar_action_smul"),
        "）の 2 つと、仮定の等式だけである。",
        "固有ベクトルではなく固有空間について述べたのは、",
        math(String.raw`B\cdot v`),
        " が零ベクトルになりうるからである",
        "（零ベクトルは固有ベクトルではないが ",
        math(String.raw`E_{A}(z)`),
        " には属する）。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "これはシフト行列 ",
        math(String.raw`U`),
        " と転送行列 ",
        math(String.raw`T`),
        " の可換性（",
        ref("theorem_shift_matrix_commutes"),
        "）を、固有空間の言葉へ翻訳するための段である。",
        math(String.raw`\mathrm{Ev}_{\xi}`),
        " で ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " へ運んだ 2 つの行列が可換であること（",
        ref("claim_qbar_matrix_eval_product"),
        " による）と合わせると、転送行列がシフト行列の各固有空間をそれ自身へ写すことになる。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_shift_transfer_commute",
    kind: "claim",
    title: { text: "評価で運んだシフト行列と転送行列は可換である" },
    labels: ["claim_qbar_shift_transfer_commute"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarShiftTransfer_comm",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.map_comm_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarShiftTransfer_comm_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-shift-transfer-commute"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。",
        ref("def_shift_matrix"),
        " の ",
        math(String.raw`U`),
        " と ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`T`),
        " を ",
        ref("def_qbar_matrix_eval"),
        " で運んだ 2 つの行列について",
      ]),
      displayMath(
        String.raw`\mathrm{Ev}_{\xi}(U)\,\mathrm{Ev}_{\xi}(T)=\mathrm{Ev}_{\xi}(T)\,\mathrm{Ev}_{\xi}(U)`,
      ),
      paragraph([
        "が成り立つ（両辺の積は ",
        ref("def_qbar_matrix_product"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の行列の積であり、",
        ref("theorem_shift_matrix_commutes"),
        " の ",
        math(String.raw`\mathbb{Z}[x]`),
        " の行列の積とは別の演算である）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathrm{Ev}_{\xi}(U)\,\mathrm{Ev}_{\xi}(T)
&=\mathrm{Ev}_{\xi}(UT)
&&(\because\ \blkref{claim_qbar_matrix_eval_product}\ \text{を右辺から左辺へ使った})\\
&=\mathrm{Ev}_{\xi}(TU)
&&(\because\ \blkref{theorem_shift_matrix_commutes})\\
&=\mathrm{Ev}_{\xi}(T)\,\mathrm{Ev}_{\xi}(U)
&&(\because\ \blkref{claim_qbar_matrix_eval_product})
\end{aligned}`),
      paragraph([
        "この段が使っているのは、成分ごとの評価が行列の積を保つこと（",
        ref("claim_qbar_matrix_eval_product"),
        "）と、",
        math(String.raw`\mathbb{Z}[x]`),
        " の行列としての可換性（",
        ref("theorem_shift_matrix_commutes"),
        "）の 2 つだけである。",
        "とくに、可換性そのものを ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の側で示し直してはいない。可換性は ",
        math(String.raw`\mathbb{Z}[x]`),
        " の側で既に示してあり、この段はそれを写像で運んでいるだけである。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張と ",
        ref("claim_qbar_commuting_preserves_eigenspace"),
        " を合わせると、",
        math(String.raw`\mathrm{Ev}_{\xi}(T)`),
        " が ",
        math(String.raw`\mathrm{Ev}_{\xi}(U)`),
        " の各固有空間をそれ自身へ写すことになる。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_transfer_preserves_shift_eigenspace",
    kind: "claim",
    title: { text: "転送行列はシフト行列の各固有空間をそれ自身へ写す" },
    labels: ["claim_qbar_transfer_preserves_shift_eigenspace"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarTransfer_preserves_shift_eigenspace",
      "Ising2DLambda.AlgebraicEigenvalue.qbarTransfer_preserves_shift_eigenspace_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-transfer-preserves-shift-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`\xi\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。",
        ref("def_shift_matrix"),
        " の ",
        math(String.raw`U`),
        " と ",
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`T`),
        " を ",
        ref("def_qbar_matrix_eval"),
        " で運んだ行列について、",
        math(String.raw`v\in E_{\mathrm{Ev}_{\xi}(U)}(z)`),
        "（",
        ref("def_qbar_eigenspace"),
        "）を満たす任意の ",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）について",
      ]),
      displayMath(
        String.raw`\mathrm{Ev}_{\xi}(T)\cdot v\in E_{\mathrm{Ev}_{\xi}(U)}(z)`,
      ),
      paragraph([
        "である（点は ",
        ref("def_qbar_matrix_action"),
        "）。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathrm{Ev}_{\xi}(U)\cdot\bigl(\mathrm{Ev}_{\xi}(T)\cdot v\bigr)
&=z\odot\bigl(\mathrm{Ev}_{\xi}(T)\cdot v\bigr)
&&\left(\because\ \begin{aligned}
&\blkref{claim_qbar_commuting_preserves_eigenspace}\ \text{を}\
A=\mathrm{Ev}_{\xi}(U),\ B=\mathrm{Ev}_{\xi}(T)\ \text{に当てた}\\
&\text{その仮定}\ AB=BA\ \text{は}\ \blkref{claim_qbar_shift_transfer_commute}
\end{aligned}\right)
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`\mathrm{Ev}_{\xi}(T)\cdot v`),
        " は ",
        ref("def_qbar_eigenspace"),
        " の条件を満たし、",
        math(String.raw`\mathrm{Ev}_{\xi}(T)\cdot v\in E_{\mathrm{Ev}_{\xi}(U)}(z)`),
        " である。",
      ]),
      paragraph([
        "この段は組み立てだけである。新しい論法は無く、既に示した 2 つの主張（",
        ref("claim_qbar_commuting_preserves_eigenspace"),
        "、",
        ref("claim_qbar_shift_transfer_commute"),
        "）を、この章が扱う 2 つの行列へ当てている。",
        "とくに、",
        math(String.raw`v`),
        " が零ベクトルでないことは仮定していない（",
        ref("def_qbar_eigenspace"),
        " が零ベクトルを含むため、この主張は ",
        math(String.raw`v=o_L`),
        " のときも中身のある形で成り立つ）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_vector_sum",
    kind: "definition",
    title: { text: "代数的数を成分とする列ベクトルの有限和" },
    labels: ["def_qbar_vector_sum"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarVectorSum"],
    verification: ["sagemath/check/qbar-action-sum"],
    statement: [
      paragraph([
        "集合 ",
        math(String.raw`I`),
        " とその有限部分集合 ",
        math(String.raw`s\subset I`),
        "、および写像 ",
        math(String.raw`i\mapsto v_i`),
        "（",
        math(String.raw`I`),
        " から ",
        math(String.raw`V_L`),
        " への写像。",
        ref("def_qbar_vector"),
        "）に対し、有限和 ",
        math(String.raw`\bigoplus_{i\in s}v_i\in V_L`),
        " を",
      ]),
      displayMath(
        String.raw`\Bigl(\bigoplus_{i\in s}v_i\Bigr)(\tau):=\sum_{i\in s}v_i(\tau)\qquad(\tau\in R_L)`,
      ),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の有限個の元の和であり、左辺の ",
        math(String.raw`\bigoplus`),
        " は列ベクトルどうしの演算である。2 元の和（",
        ref("def_qbar_vector_add"),
        "）と同じ理由で、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の加法とは記号を分けて書く。",
      ]),
      paragraph([
        "定義を成分ごとに置いたのは、",
        math(String.raw`\oplus`),
        " を繰り返す形で定めると、足す順序に依らないことを別に示す必要が生じるからである",
        "（成分ごとに置けば、それは ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の有限和が持つ性質にそのまま帰着する）。",
        "とくに ",
        math(String.raw`s=\emptyset`),
        " のとき ",
        math(String.raw`\bigoplus_{i\in s}v_i=o_L`),
        "（",
        ref("def_qbar_zero_vector"),
        "）である。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_action_sum",
    kind: "claim",
    title: { text: "行列の作用は列ベクトルの有限和を保つ" },
    labels: ["claim_qbar_action_sum"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_sum",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.action_sum_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarAction_sum_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-action-sum"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）、集合 ",
        math(String.raw`I`),
        " の有限部分集合 ",
        math(String.raw`s`),
        "、および写像 ",
        math(String.raw`i\mapsto v_i`),
        "（",
        math(String.raw`I`),
        " から ",
        math(String.raw`V_L`),
        " への写像）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`A\cdot\Bigl(\bigoplus_{i\in s}v_i\Bigr)=\bigoplus_{i\in s}\bigl(A\cdot v_i\bigr)`,
      ),
      paragraph([
        "が成り立つ（点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\bigoplus`),
        " は ",
        ref("def_qbar_vector_sum"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(A\cdot\Bigl(\bigoplus_{i\in s}v_i\Bigr)\Bigr)(\tau)
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\Bigl(\bigoplus_{i\in s}v_i\Bigr)(\tau')
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\sum_{\tau'\in R_L}A_{\tau,\tau'}\Bigl(\sum_{i\in s}v_i(\tau')\Bigr)
&&(\because\ \blkref{def_qbar_vector_sum})\\
&=\sum_{\tau'\in R_L}\ \sum_{i\in s}A_{\tau,\tau'}\,v_i(\tau')
&&(\because\ \text{元と有限和の積についての分配則})\\
&=\sum_{i\in s}\ \sum_{\tau'\in R_L}A_{\tau,\tau'}\,v_i(\tau')
&&(\because\ \text{有限和の順序の入れ替え})\\
&=\sum_{i\in s}\bigl(A\cdot v_i\bigr)(\tau)
&&(\because\ \blkref{def_qbar_matrix_action})\\
&=\Bigl(\bigoplus_{i\in s}\bigl(A\cdot v_i\bigr)\Bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_sum})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、元と有限和の積についての分配則と、",
        "加法が可換モノイドであること（有限和の順序を入れ替えるのに要る）だけである。",
        "積の結合則も可換性も、加法の逆元も、体であることも使っていない。",
        "有限和の順序の入れ替えが使えるのは、",
        math(String.raw`R_L`),
        " も ",
        math(String.raw`s`),
        " も有限集合だからである。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "2 元の和についての同じ主張（",
        ref("claim_qbar_action_add"),
        "）を項の個数について繰り返せば得られる形だが、繰り返しの帰納法を書く代わりに、",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の有限和が持つ性質へ直接帰着させた（有限和の定義を成分ごとに置いた",
        ref("def_qbar_vector_sum"),
        " の利点である）。",
      ]),
      paragraph([
        "この主張は、シフト行列の固有空間たちが列ベクトルの全体を張ることを示すための足場である。",
        "そこでは、与えられた列ベクトルを固有空間の元の有限和として書き、",
        "その両辺へ行列を作用させる。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_smul_sum",
    kind: "claim",
    title: { text: "スカラー倍は列ベクトルの有限和を保つ" },
    labels: ["claim_qbar_smul_sum"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarSmul_sum",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.smul_sum_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarSmul_sum_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-smul-sum"],
    statement: [
      paragraph([
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）、集合 ",
        math(String.raw`I`),
        " の有限部分集合 ",
        math(String.raw`s`),
        "、および写像 ",
        math(String.raw`i\mapsto v_i`),
        "（",
        math(String.raw`I`),
        " から ",
        math(String.raw`V_L`),
        " への写像。",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`z\odot\Bigl(\bigoplus_{i\in s}v_i\Bigr)=\bigoplus_{i\in s}\bigl(z\odot v_i\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\odot`),
        " は ",
        ref("def_qbar_vector_smul"),
        "、",
        math(String.raw`\bigoplus`),
        " は ",
        ref("def_qbar_vector_sum"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、その ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(z\odot\Bigl(\bigoplus_{i\in s}v_i\Bigr)\Bigr)(\tau)
&=z\,\Bigl(\bigoplus_{i\in s}v_i\Bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=z\,\Bigl(\sum_{i\in s}v_i(\tau)\Bigr)
&&(\because\ \blkref{def_qbar_vector_sum})\\
&=\sum_{i\in s}z\,v_i(\tau)
&&(\because\ \text{元と有限和の積についての分配則})\\
&=\sum_{i\in s}\bigl(z\odot v_i\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=\Bigl(\bigoplus_{i\in s}\bigl(z\odot v_i\bigr)\Bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_sum})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので、2 つの写像は等しい。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、元と有限和の積についての分配則だけである。",
        "積の結合則も可換性も、加法の逆元も、体であることも使っていない。",
        "行列の作用が有限和を保つこと（",
        ref("claim_qbar_action_sum"),
        "）が有限和の順序の入れ替えを要したのと違い、こちらは和が 1 つしか現れないので、",
        "入れ替えは要らない。",
        "また ",
        math(String.raw`s`),
        " が有限であることは分配則を有限個の項へ当てるために要るが、",
        math(String.raw`R_L`),
        " の有限性はこの段では使っていない（各 ",
        math(String.raw`\tau`),
        " ごとに独立な等式だからである）。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張は、1 の ",
        math(String.raw`L`),
        " 乗根 ",
        math(String.raw`z`),
        " ごとに列ベクトルを固有空間へ落とす写像を作り、",
        "その像が固有空間に入ることを示すための足場である。",
        "そこでは、有限和として定めた列ベクトルへ ",
        math(String.raw`z`),
        " を掛ける操作を、各項へ掛ける操作に取り替える必要がある。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_projector",
    kind: "definition",
    title: { text: "列ベクトルを固有空間へ落とす写像" },
    labels: ["def_qbar_projector"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarProjector"],
    verification: ["sagemath/check/qbar-projector-action"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）と ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。写像 ",
        math(String.raw`P_{A,z}\colon V_L\to V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を",
      ]),
      displayMath(
        String.raw`P_{A,z}(v):=\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k}\cdot v\bigr)\qquad(v\in V_L)`,
      ),
      paragraph([
        "で定める。ここで ",
        math(String.raw`A^{k}`),
        " は ",
        ref("def_qbar_matrix_power"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "、",
        math(String.raw`\odot`),
        " は ",
        ref("def_qbar_vector_smul"),
        " であり、",
        math(String.raw`\bigoplus_{k=0}^{L-1}`),
        " は ",
        ref("def_qbar_vector_sum"),
        " の有限和を、添字集合を ",
        math(String.raw`I=\mathbb{N}`),
        "、その有限部分集合を ",
        math(String.raw`s=\{0,1,\dots,L-1\}`),
        " と取ったものである。",
      ]),
      paragraph([
        "指数について 2 点を書いておく。第一に、",
        math(String.raw`k`),
        " は ",
        math(String.raw`0\le k\le L-1`),
        " を走るので ",
        math(String.raw`L-k\in\mathbb{N}`),
        " であり、",
        math(String.raw`1\le L-k\le L`),
        " である。冪 ",
        math(String.raw`z^{\,L-k}\in\overline{\mathbb{Q}}`),
        " は ",
        ref("def_root_of_unity_set"),
        " で置いた約束（",
        math(String.raw`z^{0}:=1`),
        "、",
        math(String.raw`z^{j+1}:=z^{j}z`),
        "）による。第二に、",
        math(String.raw`z^{-k}`),
        " と書かないのは、負の指数の冪を定めるには ",
        math(String.raw`z`),
        " が零元でないことと逆元を取ることが要るからである。",
        math(String.raw`z^{\,L-k}`),
        " と書けば、この 2 つのどちらも要らない。",
      ]),
      paragraph([
        "この定義は ",
        math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
        " も ",
        math(String.raw`z^{L}=1`),
        " も仮定しない（",
        math(String.raw`A`),
        " と ",
        math(String.raw`z`),
        " は任意である）。この 2 つを使うのは、像が固有空間に入ることを示す段である。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_projector_action",
    kind: "claim",
    title: { text: "落とす写像への行列の作用は冪の指数を 1 つ進める" },
    labels: ["claim_qbar_projector_action"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarProjector_action",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.projector_action_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarProjector_action_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-projector-action"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）、",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "、",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`A\cdot P_{A,z}(v)=\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k+1}\cdot v\bigr)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`P_{A,z}`),
        " は ",
        ref("def_qbar_projector"),
        "、点は ",
        ref("def_qbar_matrix_action"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の鎖の第 2 段から第 5 段では、有限和の各項に同じ主張を当てている",
        "（一ステップ一定理の例外である「同じ定理を複数箇所へ同時適用する場合」に当たる）。",
        "有限和が各項で決まること（",
        ref("def_qbar_vector_sum"),
        " が成分ごとの和として定めてあること）から、各項が等しければ有限和も等しい。",
      ]),
      displayMath(String.raw`\begin{aligned}
A\cdot P_{A,z}(v)
&=A\cdot\Bigl(\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k}\cdot v\bigr)\Bigr)
&&(\because\ \blkref{def_qbar_projector})\\
&=\bigoplus_{k=0}^{L-1}A\cdot\Bigl(z^{\,L-k}\odot\bigl(A^{k}\cdot v\bigr)\Bigr)
&&(\because\ \blkref{claim_qbar_action_sum})\\
&=\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\Bigl(A\cdot\bigl(A^{k}\cdot v\bigr)\Bigr)
&&(\because\ \blkref{claim_qbar_action_smul})\\
&=\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl((A\,A^{k})\cdot v\bigr)
&&(\because\ \blkref{claim_qbar_action_product})\\
&=\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k+1}\cdot v\bigr)
&&(\because\ \blkref{def_qbar_matrix_power})
\end{aligned}`),
      paragraph([
        "この段が使っているのは 4 つの等式だけである。作用が有限和を保つこと（",
        ref("claim_qbar_action_sum"),
        "）、作用がスカラー倍を保つこと（",
        ref("claim_qbar_action_smul"),
        "）、作用が行列の積と両立すること（",
        ref("claim_qbar_action_product"),
        "）、そして冪の一歩の式 ",
        math(String.raw`A^{k+1}=A\,A^{k}`),
        "（",
        ref("def_qbar_matrix_power"),
        "）である。",
      ]),
      paragraph([
        "とくに、係数 ",
        math(String.raw`z^{\,L-k}`),
        " が冪の形であることは使っていない（各 ",
        math(String.raw`k`),
        " に勝手な ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元を割り当てても同じ鎖が通る）。",
        math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
        " も ",
        math(String.raw`z^{L}=1`),
        " も使っていない。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張は、",
        math(String.raw`P_{A,z}(v)`),
        " の像が固有空間 ",
        math(String.raw`E_{A}(z)`),
        "（",
        ref("def_qbar_eigenspace"),
        "）に入ることを示すための前半である。",
        "残りは、右辺の添字を 1 つずらして ",
        math(String.raw`k=L`),
        " の項を ",
        math(String.raw`k=0`),
        " の項へ巻き戻すことであり、そこで ",
        math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
        " と ",
        math(String.raw`z^{L}=1`),
        " を使う。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_projector_image_eigenspace",
    kind: "claim",
    title: { text: "落とす写像の像は固有空間に入る" },
    labels: ["claim_qbar_projector_image_eigenspace"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarProjector_mem_eigenspace",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.projector_image_eigenspace_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarProjector_mem_eigenspace_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-projector-image-eigenspace"],
    statement: [
      paragraph([
        math(String.raw`A\in\mathrm{Mat}_{R_L}(\overline{\mathbb{Q}})`),
        "（",
        ref("def_qbar_matrix"),
        "）、",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "、",
        math(String.raw`v\in V_L`),
        "（",
        ref("def_qbar_vector"),
        "）を任意に取る。",
        math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
        "（",
        ref("def_qbar_matrix_power"),
        "、",
        ref("def_qbar_identity_matrix"),
        "）と ",
        math(String.raw`z^{L}=1`),
        " を仮定すると",
      ]),
      displayMath(
        String.raw`P_{A,z}(v)\in E_{A}(z)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`P_{A,z}`),
        " は ",
        ref("def_qbar_projector"),
        "、",
        math(String.raw`E_{A}(z)`),
        " は ",
        ref("def_qbar_eigenspace"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "先に準備を 3 つ置く。",
      ]),
      paragraph([
        "準備 1。",
        math(String.raw`\tau\in R_L`),
        " を任意に取り、",
        math(String.raw`k\in\mathbb{N}`),
        " に対し ",
        math(String.raw`a_k:=\bigl(A^{k}\cdot v\bigr)(\tau)\in\overline{\mathbb{Q}}`),
        " と置く（点は ",
        ref("def_qbar_matrix_action"),
        "）。",
        math(String.raw`a_k`),
        " は ",
        math(String.raw`\tau`),
        " にも依るが、以下の議論では ",
        math(String.raw`\tau`),
        " を固定したままなので添字に書かない。",
      ]),
      paragraph([
        "準備 2。",
        math(String.raw`a_L=a_0`),
        " である。実際",
      ]),
      displayMath(String.raw`\begin{aligned}
a_L&=\bigl(A^{L}\cdot v\bigr)(\tau)
&&(\because\ \text{準備 1})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\cdot v\bigr)(\tau)
&&(\because\ \text{仮定}\ A^{L}=I^{\overline{\mathbb{Q}}}_L)\\
&=v(\tau)
&&(\because\ \blkref{claim_qbar_identity_action})\\
&=\bigl(I^{\overline{\mathbb{Q}}}_L\cdot v\bigr)(\tau)
&&(\because\ \blkref{claim_qbar_identity_action})\\
&=\bigl(A^{0}\cdot v\bigr)(\tau)
&&(\because\ \blkref{def_qbar_matrix_power}\ \text{の}\ A^{0}:=I^{\overline{\mathbb{Q}}}_L)\\
&=a_0
&&(\because\ \text{準備 1})
\end{aligned}`),
      paragraph([
        "準備 3。",
        math(String.raw`z^{\,L+1}=z`),
        " である。実際",
      ]),
      displayMath(String.raw`\begin{aligned}
z^{\,L+1}&=z^{L}\,z
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ z^{j+1}:=z^{j}z)\\
&=1\cdot z
&&(\because\ \text{仮定}\ z^{L}=1)\\
&=z
\end{aligned}`),
      paragraph([
        ref("def_qbar_eigenspace"),
        " により示すべきことは ",
        math(String.raw`A\cdot P_{A,z}(v)=z\odot P_{A,z}(v)`),
        " である。両辺は ",
        math(String.raw`V_L`),
        " の元、すなわち ",
        math(String.raw`R_L`),
        " 上の写像なので、準備 1 で取った ",
        math(String.raw`\tau`),
        " における値が等しいことを示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl(A\cdot P_{A,z}(v)\bigr)(\tau)
&=\Bigl(\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k+1}\cdot v\bigr)\Bigr)(\tau)
&&(\because\ \blkref{claim_qbar_projector_action})\\
&=\sum_{k=0}^{L-1}\bigl(z^{\,L-k}\odot\bigl(A^{k+1}\cdot v\bigr)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_sum})\\
&=\sum_{k=0}^{L-1}z^{\,L-k}\,\bigl(A^{k+1}\cdot v\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})\\
&=\sum_{k=0}^{L-1}z^{\,L-k}\,a_{k+1}
&&(\because\ \text{準備 1})\\
&=\sum_{j=1}^{L}z^{\,L-j+1}\,a_{j}
&&(\because\ k\mapsto k+1\ \text{が}\ \{0,\dots,L-1\}\ \text{から}\ \{1,\dots,L\}\ \text{への全単射で、対応する項が等しい})\\
&=\Bigl(\sum_{j=1}^{L-1}z^{\,L-j+1}\,a_{j}\Bigr)+z^{\,1}\,a_{L}
&&(\because\ \text{有限和から}\ j=L\ \text{の 1 項を分ける。}\ L-L+1=1)\\
&=\Bigl(\sum_{j=1}^{L-1}z^{\,L-j+1}\,a_{j}\Bigr)+z\,a_{0}
&&(\because\ \text{準備 2、および}\ z^{1}=z)\\
&=\Bigl(\sum_{j=1}^{L-1}z^{\,L-j+1}\,a_{j}\Bigr)+z^{\,L+1}\,a_{0}
&&(\because\ \text{準備 3})\\
&=\sum_{k=0}^{L-1}z^{\,L-k+1}\,a_{k}
&&(\because\ \text{有限和へ}\ k=0\ \text{の 1 項を戻す。}\ L-0+1=L+1)\\
&=\sum_{k=0}^{L-1}z\,\bigl(z^{\,L-k}\,a_{k}\bigr)
&&(\because\ z^{\,L-k+1}=z^{\,L-k}z\ \text{と積の可換則})\\
&=z\,\sum_{k=0}^{L-1}z^{\,L-k}\,a_{k}
&&(\because\ \text{元と有限和の積についての分配則})\\
&=z\,\sum_{k=0}^{L-1}\bigl(z^{\,L-k}\odot\bigl(A^{k}\cdot v\bigr)\bigr)(\tau)
&&(\because\ \text{準備 1 と}\ \blkref{def_qbar_vector_smul})\\
&=z\,\Bigl(\bigoplus_{k=0}^{L-1}z^{\,L-k}\odot\bigl(A^{k}\cdot v\bigr)\Bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_sum})\\
&=z\,\bigl(P_{A,z}(v)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_projector})\\
&=\bigl(z\odot P_{A,z}(v)\bigr)(\tau)
&&(\because\ \blkref{def_qbar_vector_smul})
\end{aligned}`),
      paragraph([
        math(String.raw`\tau\in R_L`),
        " は任意だったので ",
        math(String.raw`A\cdot P_{A,z}(v)=z\odot P_{A,z}(v)`),
        " であり、",
        ref("def_qbar_eigenspace"),
        " により ",
        math(String.raw`P_{A,z}(v)\in E_{A}(z)`),
        " である。",
      ]),
      paragraph([
        "2 点、注意を書いておく。第一に、",
        math(String.raw`j=L`),
        " の項を分ける段と ",
        math(String.raw`k=0`),
        " の項を戻す段は ",
        math(String.raw`L\ge1`),
        " でなければ書けない（",
        math(String.raw`L=1`),
        " のときは残りの和 ",
        math(String.raw`\sum_{j=1}^{0}`),
        " が空和になるだけで、鎖はそのまま通る）。",
        "格子の一辺 ",
        math(String.raw`L`),
        " は ",
        math(String.raw`L\ge1`),
        " なのでこれは満たされている。",
        "第二に、2 つの仮定 ",
        math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
        "（準備 2 で使う）と ",
        math(String.raw`z^{L}=1`),
        "（準備 3 で使う）を使うのは、この主張が初めてである。",
        "落とす写像の定義（",
        ref("def_qbar_projector"),
        "）と、それへの作用が冪の指数を 1 つ進めること（",
        ref("claim_qbar_projector_action"),
        "）は、どちらもこの 2 つの仮定を置かずに述べてある",
        "（この証明はその 2 つを根拠として引いているが、引いている先が仮定を使っていない、という意味である）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_mul_pow",
    kind: "claim",
    title: { text: "代数的数の積の冪は、冪の積である" },
    labels: ["claim_qbar_mul_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarMul_pow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_pow_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarMul_pow_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-mul-pow"],
    statement: [
      paragraph([
        math(String.raw`w,z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`(wz)^{n}=w^{n}z^{n}`),
      paragraph([
        "が成り立つ（冪は ",
        ref("def_root_of_unity_set"),
        " で置いた約束、すなわち ",
        math(String.raw`y^{0}:=1`),
        " と ",
        math(String.raw`y^{j+1}:=y^{j}y`),
        " による）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(wz)^{0}&=1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{0}:=1)\\
&=1\cdot 1
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=w^{0}\cdot 1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{0}:=1)\\
&=w^{0}z^{0}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{0}:=1)
\end{aligned}`),
      paragraph([
        "一歩。",
        math(String.raw`n\in\mathbb{N}`),
        " について ",
        math(String.raw`(wz)^{n}=w^{n}z^{n}`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(wz)^{n+1}&=(wz)^{n}(wz)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{j+1}:=y^{j}y)\\
&=\bigl(w^{n}z^{n}\bigr)(wz)
&&(\because\ \text{帰納法の仮定})\\
&=w^{n}\bigl(z^{n}(wz)\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=w^{n}\bigl((z^{n}w)z\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=w^{n}\bigl((wz^{n})z\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の可換則を}\ z^{n}\ \text{と}\ w\ \text{に当てる})\\
&=w^{n}\bigl(w(z^{n}z)\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=\bigl(w^{n}w\bigr)\bigl(z^{n}z\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=w^{n+1}\bigl(z^{n}z\bigr)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{j+1}:=y^{j}y)\\
&=w^{n+1}z^{n+1}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の}\ y^{j+1}:=y^{j}y)
\end{aligned}`),
      paragraph([
        "したがってすべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について ",
        math(String.raw`(wz)^{n}=w^{n}z^{n}`),
        " である。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の単位元・積の結合則・および ",
        math(String.raw`z^{n}`),
        " と ",
        math(String.raw`w`),
        " という 2 元についての可換則だけである。",
        "加法も零元も分配則も、逆元の存在も、体であることも使っていない。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "この主張は、1 の ",
        math(String.raw`L`),
        " 乗根の全体 ",
        math(String.raw`\mu_L`),
        "（",
        ref("def_root_of_unity_set"),
        "）が積で閉じることを示すための足場である。",
        "そこから、",
        math(String.raw`\mu_L`),
        " の元を掛ける操作が ",
        math(String.raw`\mu_L`),
        " の全単射であることを経て、",
        math(String.raw`\mu_L`),
        " の元の冪の総和（指数が ",
        math(String.raw`L`),
        " の倍数なら元の個数、そうでなければ零元）へ進む。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_mul",
    kind: "claim",
    title: { text: "1 の冪根の全体は積で閉じている" },
    labels: ["claim_root_of_unity_mul"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_mul",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mul_mem_pow_eq_one_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_mul_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-mul"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。",
        math(String.raw`w\in\mu_{n}`),
        " と ",
        math(String.raw`z\in\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）を任意に取る。このとき",
      ]),
      displayMath(String.raw`wz\in\mu_{n}`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " かつ ",
        math(String.raw`w^{n}=1`),
        " であり、同じく ",
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " かつ ",
        math(String.raw`z^{n}=1`),
        " である。",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は体なので積で閉じており（",
        ref("def_algebraic_numbers"),
        "）、",
        math(String.raw`wz\in\overline{\mathbb{Q}}`),
        " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
(wz)^{n}&=w^{n}z^{n}
&&(\because\ \blkref{claim_qbar_mul_pow})\\
&=1\cdot z^{n}
&&(\because\ w^{n}=1)\\
&=1\cdot 1
&&(\because\ z^{n}=1)\\
&=1
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})
\end{aligned}`),
      paragraph([
        "よって ",
        math(String.raw`wz\in\overline{\mathbb{Q}}`),
        " かつ ",
        math(String.raw`(wz)^{n}=1`),
        " であり、",
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`wz\in\mu_{n}`),
        " である。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積で閉じていること・積の単位元・および ",
        ref("claim_qbar_mul_pow"),
        " が使う性質（結合則と 2 元についての可換則）だけである。",
        "加法も零元も分配則も、逆元の存在も、代数閉であることも使っていない。",
        math(String.raw`n=0`),
        " のときも鎖はそのまま通る（",
        math(String.raw`\mu_{0}=\overline{\mathbb{Q}}`),
        " なので主張は自明だが、鎖はそれを使っていない）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_pow",
    kind: "claim",
    title: { text: "1 の冪根の冪は 1 の冪根である" },
    labels: ["claim_root_of_unity_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_pow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_mem_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnity_pow_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-pow"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`w\in\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）を任意に取る。このとき任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について",
      ]),
      displayMath(String.raw`w^{k}\in\mu_{n}`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`k=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
w^{0}&=1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ y^{0}=1)\\
1^{n}&=1
&&(\because\ \text{単位元の反復積は単位元である})
\end{aligned}`),
      paragraph([
        math(String.raw`1\in\overline{\mathbb{Q}}`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " が体であること（",
        ref("def_algebraic_numbers"),
        "）による。よって ",
        ref("def_root_of_unity_set"),
        " により ",
        math(String.raw`w^{0}=1\in\mu_{n}`),
        " である。",
      ]),
      paragraph([
        "一歩（",
        math(String.raw`k`),
        " のとき ",
        math(String.raw`w^{k}\in\mu_{n}`),
        " が成り立つと仮定して ",
        math(String.raw`k+1`),
        " のときを示す）。",
      ]),
      displayMath(String.raw`\begin{aligned}
w^{k+1}&=w^{k}\,w
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ y^{j+1}=y^{j}y)\\
&\in\mu_{n}
&&(\because\ \blkref{claim_root_of_unity_mul}\ \text{を}\ w^{k}\in\mu_{n}\ \text{（帰納法の仮定）と}\ w\in\mu_{n}\ \text{（仮定）へ当てる})
\end{aligned}`),
      paragraph([
        "以上より、任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`w^{k}\in\mu_{n}`),
        " である。",
      ]),
      paragraph([
        "この段が使っているのは、",
        math(String.raw`\mu_{n}`),
        " が 1 を含むことと積で閉じていること（",
        ref("claim_root_of_unity_mul"),
        "）の 2 つだけである。",
        math(String.raw`w`),
        " が 1 の冪根であることは、",
        math(String.raw`w\in\mu_{n}`),
        " という所属としてしか使っていない。",
        "実数体も複素数体も現れない（元は代数的数、指数は自然数である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_def_root_of_unity_mul_map",
    kind: "definition",
    title: { text: "1 の冪根を掛ける写像" },
    labels: ["def_root_of_unity_mul_map"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.mulMap"],
    verification: ["sagemath/check/root-of-unity-mul-map"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`w\in\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）を任意に取る。写像",
      ]),
      displayMath(
        String.raw`\theta^{(n)}_{w}:\mu_{n}\to\mu_{n},\qquad
\theta^{(n)}_{w}(z):=wz`,
      ),
      paragraph([
        "を定める。ここで ",
        math(String.raw`wz`),
        " は体 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の積（",
        ref("def_algebraic_numbers"),
        "）である。行き先が ",
        math(String.raw`\mu_{n}`),
        " に収まること、すなわち ",
        math(String.raw`z\in\mu_{n}`),
        " ならば ",
        math(String.raw`wz\in\mu_{n}`),
        " であることは ",
        ref("claim_root_of_unity_mul"),
        " による（これを言わないと写像として定まらない）。",
      ]),
      paragraph([
        "上付きの ",
        math(String.raw`(n)`),
        " と下付きの ",
        math(String.raw`w`),
        " は、この写像が ",
        math(String.raw`n`),
        " と ",
        math(String.raw`w`),
        " の取り方に依存することを記号に残すためのものである。",
        "掛ける操作を表す文字に ",
        math(String.raw`m`),
        " を使わない（",
        math(String.raw`m`),
        " は多重度 ",
        math(String.raw`\Omega_L(m)`),
        " の添字に固定してある）ので ",
        math(String.raw`\theta`),
        " とした。",
        "実数体も複素数体も現れない（定義域も値域も代数的数の部分集合である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_mul_map_bijective",
    kind: "claim",
    title: { text: "1 の冪根を掛ける写像は全単射である" },
    labels: ["claim_root_of_unity_mul_map_bijective"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.mulMap_bijective",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.mulMap_bijective_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.mulMap_bijective_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-mul-map"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を ",
        math(String.raw`n\ge1`),
        " を満たすように任意に取り、",
        math(String.raw`w\in\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）を任意に取る。このとき ",
        ref("def_root_of_unity_mul_map"),
        " の写像 ",
        math(String.raw`\theta^{(n)}_{w}`),
        " は全単射であり、その逆写像は ",
        math(String.raw`\theta^{(n)}_{w^{n-1}}`),
        " である。すなわち任意の ",
        math(String.raw`z\in\mu_{n}`),
        " について",
      ]),
      displayMath(String.raw`\theta^{(n)}_{w^{n-1}}\bigl(\theta^{(n)}_{w}(z)\bigr)=z,
\qquad
\theta^{(n)}_{w}\bigl(\theta^{(n)}_{w^{n-1}}(z)\bigr)=z`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        ref("claim_root_of_unity_pow"),
        " を ",
        math(String.raw`k=n-1`),
        " に当てて ",
        math(String.raw`w^{n-1}\in\mu_{n}`),
        " を得る。したがって ",
        ref("def_root_of_unity_mul_map"),
        " により写像 ",
        math(String.raw`\theta^{(n)}_{w^{n-1}}:\mu_{n}\to\mu_{n}`),
        " が定まる。この 2 つの元の積は次のように 1 である。",
      ]),
      displayMath(String.raw`\begin{aligned}
w^{n-1}\,w&=w^{(n-1)+1}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ y^{j+1}=y^{j}y)\\
&=w^{n}
&&(\because\ n\ge1\ \text{より}\ (n-1)+1=n)\\
&=1
&&(\because\ w\in\mu_{n}\ \text{と}\ \blkref{def_root_of_unity_set})
\end{aligned}`),
      paragraph([
        math(String.raw`z\in\mu_{n}`),
        " を任意に取る。第 1 の往復は次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\theta^{(n)}_{w^{n-1}}\bigl(\theta^{(n)}_{w}(z)\bigr)&=\theta^{(n)}_{w^{n-1}}(wz)
&&(\because\ \blkref{def_root_of_unity_mul_map}\ \text{を}\ \theta^{(n)}_{w}\ \text{へ})\\
&=w^{n-1}(wz)
&&(\because\ \blkref{def_root_of_unity_mul_map}\ \text{を}\ \theta^{(n)}_{w^{n-1}}\ \text{へ})\\
&=(w^{n-1}w)z
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=1\cdot z
&&(\because\ \text{準備の等式}\ w^{n-1}w=1)\\
&=z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})
\end{aligned}`),
      paragraph([
        "第 2 の往復は次のとおりである。",
      ]),
      displayMath(String.raw`\begin{aligned}
\theta^{(n)}_{w}\bigl(\theta^{(n)}_{w^{n-1}}(z)\bigr)&=\theta^{(n)}_{w}(w^{n-1}z)
&&(\because\ \blkref{def_root_of_unity_mul_map}\ \text{を}\ \theta^{(n)}_{w^{n-1}}\ \text{へ})\\
&=w(w^{n-1}z)
&&(\because\ \blkref{def_root_of_unity_mul_map}\ \text{を}\ \theta^{(n)}_{w}\ \text{へ})\\
&=(w\,w^{n-1})z
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=(w^{n-1}w)z
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の可換則})\\
&=1\cdot z
&&(\because\ \text{準備の等式}\ w^{n-1}w=1)\\
&=z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})
\end{aligned}`),
      paragraph([
        "単射性。",
        math(String.raw`z_1\in\mu_{n}`),
        " と ",
        math(String.raw`z_2\in\mu_{n}`),
        " が ",
        math(String.raw`\theta^{(n)}_{w}(z_1)=\theta^{(n)}_{w}(z_2)`),
        " を満たすとする。",
      ]),
      displayMath(String.raw`\begin{aligned}
z_1&=\theta^{(n)}_{w^{n-1}}\bigl(\theta^{(n)}_{w}(z_1)\bigr)
&&(\because\ \text{第 1 の往復を}\ z_1\ \text{へ})\\
&=\theta^{(n)}_{w^{n-1}}\bigl(\theta^{(n)}_{w}(z_2)\bigr)
&&(\because\ \theta^{(n)}_{w}(z_1)=\theta^{(n)}_{w}(z_2))\\
&=z_2
&&(\because\ \text{第 1 の往復を}\ z_2\ \text{へ})
\end{aligned}`),
      paragraph([
        "全射性。",
        math(String.raw`z\in\mu_{n}`),
        " を任意に取る。",
        ref("def_root_of_unity_mul_map"),
        " により ",
        math(String.raw`\theta^{(n)}_{w^{n-1}}(z)\in\mu_{n}`),
        " であり、第 2 の往復により ",
        math(String.raw`\theta^{(n)}_{w}\bigl(\theta^{(n)}_{w^{n-1}}(z)\bigr)=z`),
        " である。すなわち ",
        math(String.raw`z`),
        " は ",
        math(String.raw`\theta^{(n)}_{w}`),
        " の像に属する。",
      ]),
      paragraph([
        "以上より ",
        math(String.raw`\theta^{(n)}_{w}`),
        " は単射かつ全射、すなわち全単射であり、2 つの往復が恒等写像であることから ",
        math(String.raw`\theta^{(n)}_{w^{n-1}}`),
        " がその逆写像である。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積の結合則・積の可換則・積の単位元の 3 つだけである。",
        "加法も零元も分配則も、逆元の存在も、代数閉であることも使っていない。",
        math(String.raw`w`),
        " が 1 の冪根であることは、",
        math(String.raw`w^{n-1}w=1`),
        " という 1 つの等式（と可換則から出る ",
        math(String.raw`w\,w^{n-1}=1`),
        "）としてしか使っていない。",
        math(String.raw`n\ge1`),
        " が要るのは準備の第 2 段 ",
        math(String.raw`(n-1)+1=n`),
        " だけである（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`\mu_{0}=\overline{\mathbb{Q}}`),
        " なので ",
        math(String.raw`w=0`),
        " が取れてしまい、掛ける操作は全単射でない）。",
        "実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_power_sum_invariant",
    kind: "claim",
    title: {
      text: "1 の冪根の全体にわたる冪の和は、1 の冪根の冪を掛けても動かない",
    },
    labels: ["claim_root_of_unity_power_sum_invariant"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.powerSum_mul_invariant",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.sum_mul_invariant_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.powerSum_mul_invariant_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-power-sum-invariant"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を ",
        math(String.raw`n\ge1`),
        " を満たすように任意に取り、",
        math(String.raw`\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）が有限集合であると仮定する。",
        math(String.raw`m\in\mathbb{N}`),
        " を任意に取り、",
      ]),
      displayMath(String.raw`S_{n,m}:=\sum_{z\in\mu_{n}}z^{m}\in\overline{\mathbb{Q}}`),
      paragraph([
        "と置く（右辺は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の有限個の元の和であり、仮定した有限性によって定まる）。このとき任意の ",
        math(String.raw`w\in\mu_{n}`),
        " について",
      ]),
      displayMath(String.raw`w^{m}\,S_{n,m}=S_{n,m}`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in\mu_{n}`),
        " を任意に取る。",
        ref("claim_root_of_unity_mul_map_bijective"),
        " により ",
        math(String.raw`\theta^{(n)}_{w}:\mu_{n}\to\mu_{n}`),
        "（",
        ref("def_root_of_unity_mul_map"),
        "）は全単射である。",
      ]),
      displayMath(String.raw`\begin{aligned}
w^{m}S_{n,m}&=w^{m}\sum_{z\in\mu_{n}}z^{m}
&&(\because\ S_{n,m}\ \text{の定義})\\
&=\sum_{z\in\mu_{n}}w^{m}z^{m}
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則を有限和へ})\\
&=\sum_{z\in\mu_{n}}(wz)^{m}
&&(\because\ \blkref{claim_qbar_mul_pow}\ \text{を}\ w\ \text{と}\ z\ \text{へ})\\
&=\sum_{z\in\mu_{n}}\bigl(\theta^{(n)}_{w}(z)\bigr)^{m}
&&(\because\ \blkref{def_root_of_unity_mul_map}\ \text{を}\ \theta^{(n)}_{w}\ \text{へ})\\
&=\sum_{y\in\mu_{n}}y^{m}
&&(\because\ \blkref{claim_root_of_unity_mul_map_bijective}\ \text{による添字の取り替え})\\
&=S_{n,m}
&&(\because\ S_{n,m}\ \text{の定義})
\end{aligned}`),
      paragraph([
        "第 5 の等号は和の添字の取り替えである。",
        math(String.raw`\theta^{(n)}_{w}:\mu_{n}\to\mu_{n}`),
        " が全単射で、逆写像が ",
        math(String.raw`\theta^{(n)}_{w^{n-1}}`),
        " なので、",
        math(String.raw`z`),
        " にわたる有限和は ",
        math(String.raw`y=\theta^{(n)}_{w}(z)`),
        " にわたる有限和と同じ項を同じ回数ずつ足し合わせている（",
        math(String.raw`z=\theta^{(n)}_{w^{n-1}}(y)`),
        " が対応を戻す）。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、有限和が定まること（加法の結合則と可換則）と、",
        "積が有限和へ分配されることの 2 つだけである。",
        math(String.raw`\mu_{n}`),
        " の有限性は仮定であって、ここでは示していない（",
        math(String.raw`\mu_{n}`),
        " がちょうど ",
        math(String.raw`n`),
        " 個の元を持つことは別の段で示す）。",
        "実数体も複素数体も現れない（元は代数的数、指数は自然数である）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_geometric_telescope",
    kind: "claim",
    title: {
      text: "代数的数の冪の有限和は、1 を引いたものを掛けると伸縮する",
    },
    labels: ["claim_qbar_geometric_telescope"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarGeometricTelescope",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.geometric_telescope_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarGeometricTelescope_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-geometric-telescope"],
    statement: [
      paragraph([
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取り、",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`G_{n}(z):=\sum_{k=0}^{n-1}z^{k}\in\overline{\mathbb{Q}}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`n=0`),
        " のときは空和であり ",
        math(String.raw`G_{0}(z)=0`),
        "、",
        math(String.raw`n+1`),
        " のときは ",
        math(String.raw`G_{n+1}(z)=G_{n}(z)+z^{n}`),
        " である）。このとき",
      ]),
      displayMath(String.raw`(z-1)\,G_{n}(z)=z^{n}-1`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z\in\overline{\mathbb{Q}}`),
        " を固定する。",
      ]),
      paragraph([
        "準備。任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`z\,z^{k}=z^{k}z`),
        " が成り立つ（冪の約束（",
        ref("def_root_of_unity_set"),
        "）が与えるのは ",
        math(String.raw`z^{k+1}=z^{k}z`),
        " の向きだけなので、",
        math(String.raw`z\,z^{k}`),
        " をこれへ結び付けるにはこの等式が要る）。",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,z^{0}&=z\cdot 1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)\\
&=z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=1\cdot z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=z^{0}z
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)
\end{aligned}`),
      paragraph([
        math(String.raw`z\,z^{k}=z^{k}z`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,z^{k+1}&=z\bigl(z^{k}z\bigr)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{k+1}=z^{k}z)\\
&=\bigl(z\,z^{k}\bigr)z
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=\bigl(z^{k}z\bigr)z
&&(\because\ \text{帰納法の仮定})\\
&=z^{k+1}z
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{k+1}=z^{k}z)
\end{aligned}`),
      paragraph([
        "以下、主張を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(z-1)\,G_{0}(z)&=(z-1)\cdot 0
&&(\because\ G_{0}(z)\ \text{は空和である})\\
&=0
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の零元})\\
&=1-1
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の逆元})\\
&=z^{0}-1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)
\end{aligned}`),
      paragraph([
        "一歩（",
        math(String.raw`n`),
        " から ",
        math(String.raw`n+1`),
        " へ）。",
        math(String.raw`(z-1)\,G_{n}(z)=z^{n}-1`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(z-1)\,G_{n+1}(z)&=(z-1)\bigl(G_{n}(z)+z^{n}\bigr)
&&(\because\ G_{n+1}(z)\ \text{の定義})\\
&=(z-1)\,G_{n}(z)+(z-1)z^{n}
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則})\\
&=(z^{n}-1)+(z-1)z^{n}
&&(\because\ \text{帰納法の仮定})\\
&=(z^{n}-1)+\bigl(z\,z^{n}-1\cdot z^{n}\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則})\\
&=(z^{n}-1)+\bigl(z\,z^{n}-z^{n}\bigr)
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=(z^{n}-1)+\bigl(z^{n}z-z^{n}\bigr)
&&(\because\ \text{準備の}\ z\,z^{n}=z^{n}z)\\
&=(z^{n}-1)+\bigl(z^{n+1}-z^{n}\bigr)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{n+1}=z^{n}z)\\
&=z^{n+1}-1
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の結合則と可換則により}\ z^{n}\ \text{が相殺する})
\end{aligned}`),
      paragraph([
        "出発点と一歩により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、加法群であること（結合則・可換則・零元・加法の逆元）と、",
        "積が和へ分配されること、積が結合的であること（準備の段で使う）、積の単位元があること、",
        "そして零元との積が零元であることだけである。",
        "積の可換則も、積の逆元の存在も、代数閉であることも使っていない（",
        math(String.raw`z`),
        " は自分自身の冪とだけ掛け合わされ、",
        math(String.raw`z\,z^{k}=z^{k}z`),
        " は準備の段で結合則から出している）。",
        "実数体も複素数体も現れない（元は代数的数、指数は自然数である）。",
      ]),
      paragraph([
        "これは、",
        math(String.raw`\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）の元 ",
        math(String.raw`z`),
        " が ",
        math(String.raw`z\ne1`),
        " を満たすとき ",
        math(String.raw`G_{n}(z)=0`),
        " を出すための足場である（",
        math(String.raw`z^{n}-1=0`),
        " と、体に零因子が無いことによる）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_no_zero_divisors",
    kind: "claim",
    title: {
      text: "代数的数の積が零元ならば、零元でない方で割って他方が零元と分かる",
    },
    labels: ["claim_qbar_no_zero_divisors"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarNoZeroDivisors",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.no_zero_divisors_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarNoZeroDivisors_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-no-zero-divisors"],
    statement: [
      paragraph([
        math(String.raw`a,b\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）が ",
        math(String.raw`ab=0`),
        " と ",
        math(String.raw`a\ne0`),
        " を満たすとする。このとき",
      ]),
      displayMath(String.raw`b=0`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は体であり（",
        ref("def_algebraic_numbers"),
        "）、",
        math(String.raw`a\ne0`),
        " であるから、",
        math(String.raw`a^{-1}a=1`),
        " を満たす ",
        math(String.raw`a^{-1}\in\overline{\mathbb{Q}}`),
        " が取れる。",
      ]),
      displayMath(String.raw`\begin{aligned}
b&=1\cdot b
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=\bigl(a^{-1}a\bigr)b
&&(\because\ \text{準備で取った}\ a^{-1}\ \text{の性質}\ a^{-1}a=1)\\
&=a^{-1}(ab)
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=a^{-1}\cdot 0
&&(\because\ \text{仮定}\ ab=0)\\
&=0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元との積は零元})
\end{aligned}`),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、積が結合的であること、積の単位元があること、",
        "零元との積が零元であること、そして ",
        math(String.raw`a\ne0`),
        " に対して ",
        math(String.raw`a^{-1}a=1`),
        " を満たす元が取れることだけである。",
        "積の可換則も、加法についての性質も、代数閉であることも使っていない。",
        "実数体も複素数体も現れない。",
      ]),
      paragraph([
        "これは、",
        math(String.raw`\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）の元 ",
        math(String.raw`z`),
        " が ",
        math(String.raw`z\ne1`),
        " を満たすとき、伸縮の等式（",
        ref("claim_qbar_geometric_telescope"),
        "）の左辺 ",
        math(String.raw`(z-1)G_{n}(z)`),
        " が零元であることから ",
        math(String.raw`G_{n}(z)=0`),
        " を出すための段であり、",
        "1 の冪根の全体にわたる冪の和 ",
        math(String.raw`S_{n,m}`),
        " について ",
        math(String.raw`(w^{m}-1)S_{n,m}=0`),
        "（",
        ref("claim_root_of_unity_power_sum_invariant"),
        "）から ",
        math(String.raw`S_{n,m}=0`),
        " を出すための段でもある。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_geometric_sum_zero",
    kind: "claim",
    title: {
      text: "1 でない 1 の冪根の、冪の有限和は零元である",
    },
    labels: ["claim_root_of_unity_geometric_sum_zero"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnityGeometricSumZero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.geometric_sum_zero_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnityGeometricSumZero_from_necSuf",
    ],
    verification: ["sagemath/check/root-of-unity-geometric-sum-zero"],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`z\in\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）が ",
        math(String.raw`z\ne1`),
        " を満たすとする。このとき、",
        math(String.raw`G_{n}(z)=\sum_{k=0}^{n-1}z^{k}`),
        "（",
        ref("claim_qbar_geometric_telescope"),
        " で置いた元）について",
      ]),
      displayMath(String.raw`G_{n}(z)=0`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "準備。",
        math(String.raw`z-1\ne0`),
        " である。実際、",
        math(String.raw`z-1=0`),
        " とすると両辺に ",
        math(String.raw`1`),
        " を足して ",
        math(String.raw`z=1`),
        " となり、仮定 ",
        math(String.raw`z\ne1`),
        " に反する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(z-1)\,G_{n}(z)&=z^{n}-1
&&(\because\ \text{伸縮の等式})\\
&=1-1
&&(\because\ z\in\mu_{n}\ \text{すなわち}\ z^{n}=1)\\
&=0
&&(\because\ \overline{\mathbb{Q}}\ \text{の同じ元どうしの差は零元})
\end{aligned}`),
      paragraph([
        "第 1 の等号は ",
        ref("claim_qbar_geometric_telescope"),
        "、第 2 の等号は ",
        ref("def_root_of_unity_set"),
        " による。",
      ]),
      paragraph([
        "この等式に、積が零元ならば零元でない方で割って他方が零元と分かること（",
        ref("claim_qbar_no_zero_divisors"),
        "）を ",
        math(String.raw`a=z-1`),
        "、",
        math(String.raw`b=G_{n}(z)`),
        " として当てる。仮定 ",
        math(String.raw`ab=0`),
        " は上の等式であり、仮定 ",
        math(String.raw`a\ne0`),
        " は準備で示した ",
        math(String.raw`z-1\ne0`),
        " である。よって ",
        math(String.raw`G_{n}(z)=0`),
        " を得る。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について新たに使っているのは、引いた 2 つの主張が要求する性質のほかに、",
        "同じ元どうしの差が零元であること、および ",
        math(String.raw`z-1=0`),
        " と ",
        math(String.raw`z=1`),
        " が同値であること（加法群であること）だけである。",
        "積の可換則も、代数閉であることも使っていない。実数体も複素数体も現れない。",
      ]),
      paragraph([
        "これは、1 の冪根の全体にわたる冪の和 ",
        math(String.raw`S_{n,m}`),
        "（",
        ref("claim_root_of_unity_power_sum_invariant"),
        "）を、原始根を取って ",
        math(String.raw`G_{n}`),
        " の値として書き直す経路のための段である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_power_difference_factorization",
    kind: "claim",
    title: {
      text: "代数的数の冪の差は、もとの 2 元の差を因子に持つ",
    },
    labels: ["claim_qbar_power_difference_factorization"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPowerDifferenceFactorization",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.power_difference_factorization_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPowerDifferenceFactorization_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-power-difference-factorization"],
    statement: [
      paragraph([
        math(String.raw`z,w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取り、",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。",
        math(String.raw`H_{n}(z,w)\in\overline{\mathbb{Q}}`),
        " を ",
        math(String.raw`n`),
        " についての次の約束で定める。",
      ]),
      displayMath(
        String.raw`H_{0}(z,w):=0,\qquad H_{n+1}(z,w):=H_{n}(z,w)\,w+z^{n}`,
      ),
      paragraph([
        "このとき",
      ]),
      displayMath(String.raw`(z-w)\,H_{n}(z,w)=z^{n}-w^{n}`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`z,w\in\overline{\mathbb{Q}}`),
        " を固定する。",
      ]),
      paragraph([
        "準備。任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`z\,z^{k}=z^{k}z`),
        " が成り立つ（冪の約束（",
        ref("def_root_of_unity_set"),
        "）が与えるのは ",
        math(String.raw`z^{k+1}=z^{k}z`),
        " の向きだけなので、",
        math(String.raw`z\,z^{k}`),
        " をこれへ結び付けるにはこの等式が要る。",
        "この主張の眼目は ",
        math(String.raw`z`),
        " と ",
        math(String.raw`w`),
        " が可換であること以外を使わない点にあるので、ここを積の可換則で埋めることはできない）。",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,z^{0}&=z\cdot 1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)\\
&=z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=1\cdot z
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=z^{0}z
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)
\end{aligned}`),
      paragraph([
        math(String.raw`z\,z^{k}=z^{k}z`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
z\,z^{k+1}&=z\bigl(z^{k}z\bigr)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{k+1}=z^{k}z)\\
&=\bigl(z\,z^{k}\bigr)z
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=\bigl(z^{k}z\bigr)z
&&(\because\ \text{帰納法の仮定})\\
&=z^{k+1}z
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{k+1}=z^{k}z)
\end{aligned}`),
      paragraph([
        "以下、主張を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(z-w)\,H_{0}(z,w)&=(z-w)\cdot 0
&&(\because\ H_{0}(z,w)=0\ \text{の約束})\\
&=0
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の零元})\\
&=1-1
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の逆元})\\
&=z^{0}-1
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{0}=1)\\
&=z^{0}-w^{0}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{0}=1)
\end{aligned}`),
      paragraph([
        "一歩（",
        math(String.raw`n`),
        " から ",
        math(String.raw`n+1`),
        " へ）。",
        math(String.raw`(z-w)\,H_{n}(z,w)=z^{n}-w^{n}`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(z-w)\,H_{n+1}(z,w)&=(z-w)\bigl(H_{n}(z,w)\,w+z^{n}\bigr)
&&(\because\ H_{n+1}(z,w)\ \text{の約束})\\
&=(z-w)\bigl(H_{n}(z,w)\,w\bigr)+(z-w)z^{n}
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則})\\
&=\bigl((z-w)H_{n}(z,w)\bigr)w+(z-w)z^{n}
&&(\because\ \overline{\mathbb{Q}}\ \text{の積の結合則})\\
&=\bigl(z^{n}-w^{n}\bigr)w+(z-w)z^{n}
&&(\because\ \text{帰納法の仮定})\\
&=\bigl(z^{n}w-w^{n}w\bigr)+(z-w)z^{n}
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則})\\
&=\bigl(z^{n}w-w^{n+1}\bigr)+(z-w)z^{n}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{n+1}=w^{n}w)\\
&=\bigl(z^{n}w-w^{n+1}\bigr)+\bigl(z\,z^{n}-w\,z^{n}\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の分配則})\\
&=\bigl(z^{n}w-w^{n+1}\bigr)+\bigl(z^{n}z-w\,z^{n}\bigr)
&&(\because\ \text{準備の等式}\ z\,z^{n}=z^{n}z)\\
&=\bigl(z^{n}w-w^{n+1}\bigr)+\bigl(z^{n+1}-w\,z^{n}\bigr)
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ z^{n+1}=z^{n}z)\\
&=\bigl(z^{n}w-w^{n+1}\bigr)+\bigl(z^{n+1}-z^{n}w\bigr)
&&(\because\ z\ \text{と}\ w\ \text{が可換であること})\\
&=z^{n+1}-w^{n+1}
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の結合則と可換則により}\ z^{n}w\ \text{が相殺する})
\end{aligned}`),
      paragraph([
        "出発点と一歩により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この段が ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " について使っているのは、加法群であること（結合則・可換則・零元・加法の逆元）、",
        "積が和へ分配されること、積が結合的であること、積の単位元があること、",
        "零元との積が零元であること、そして ",
        math(String.raw`z`),
        " と ",
        math(String.raw`w`),
        " が可換であることだけである（一歩の鎖で ",
        math(String.raw`z`),
        " と ",
        math(String.raw`w`),
        " の可換性を使っているのは第 10 の等号の 1 箇所",
        "（",
        math(String.raw`w\,z^{n}=z^{n}w`),
        "）だけである。第 8 の等号の ",
        math(String.raw`z\,z^{n}=z^{n}z`),
        " は同じ元どうしの入れ替えであり、準備の段で積の結合則と単位元だけから示してある）。",
        "積の逆元の存在も、代数閉であることも使っていない。実数体も複素数体も現れない",
        "（元は代数的数、指数は自然数である）。",
      ]),
      paragraph([
        math(String.raw`w=1`),
        " と取ると ",
        math(String.raw`H_{n}(z,1)`),
        " の約束は ",
        math(String.raw`G_{n}(z)`),
        "（",
        ref("claim_qbar_geometric_telescope"),
        "）の約束に一致し、この主張は伸縮の等式に一致する。",
        "すなわちこれは伸縮の等式を 2 元へ広げたものである。",
      ]),
      paragraph([
        "これは、",
        math(String.raw`\mu_{n}`),
        "（",
        ref("def_root_of_unity_set"),
        "）がちょうど ",
        math(String.raw`n`),
        " 個の元を持つことを示すための足場である。",
        "その論法は「",
        math(String.raw`z^{n}-1`),
        " の根が高々 ",
        math(String.raw`n`),
        " 個であること」を経由し、そこで根 ",
        math(String.raw`w`),
        " を持つ多項式が ",
        math(String.raw`(t-w)`),
        " を因子に持つことを使う。この主張はその因数分解を与える等式である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_polynomial_ring",
    kind: "definition",
    title: { text: "代数的数を係数とする 1 変数多項式" },
    labels: ["def_qbar_polynomial_ring"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.QbarPoly"],
    verification: ["sagemath/check/qbar-poly-power-difference-factorization"],
    statement: [
      paragraph([
        "根の個数を数える場所を用意する。",
        ref("def_second_polynomial_ring"),
        " の不定元 ",
        math(String.raw`t`),
        " を同じ名前で使い、",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を係数環とする ",
        math(String.raw`t`),
        " の多項式環を ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " と書く。",
      ]),
      paragraph([
        math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        " と ",
        math(String.raw`k\in\mathbb{N}`),
        " に対して、",
        math(String.raw`f`),
        " の ",
        math(String.raw`t^{k}`),
        " の係数を ",
        math(String.raw`\mathrm{ac}_k(f)\in\overline{\mathbb{Q}}`),
        " と書く（",
        math(String.raw`\mathbb{Z}[x][t]`),
        " の係数を表す ",
        math(String.raw`\mathrm{cf}_k`),
        " とは別の記号にする。係数環が違うので同じ記号では書かない）。",
        math(String.raw`\mathrm{ac}_k(f)\ne 0`),
        " となる ",
        math(String.raw`k`),
        " は有限個であり、和と積は係数の言葉で",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_k(f+g)&=\mathrm{ac}_k(f)+\mathrm{ac}_k(g)\\
\mathrm{ac}_k(f\cdot g)&=\sum_{i=0}^{k}\mathrm{ac}_i(f)\cdot\mathrm{ac}_{k-i}(g)
\end{aligned}
\qquad(f,g\in\overline{\mathbb{Q}}[t],\ k\in\mathbb{N})`),
      paragraph([
        "で与えられる。これは多項式環の演算の定義であって、証明すべきことではない。",
        "冪は ",
        math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        " と ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`f^{0}:=1`),
        "、",
        math(String.raw`f^{k+1}:=f^{k}f`),
        " で約束する（",
        math(String.raw`1`),
        " は ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の積の単位元、すなわち ",
        math(String.raw`\mathrm{ac}_0=1`),
        " で他の係数が ",
        math(String.raw`0`),
        " の元である）。",
        "この約束は ",
        ref("def_root_of_unity_set"),
        " で ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元に置いた約束と同じ形だが、住む環が違うので別に置く。",
      ]),
      paragraph([
        "不定元 ",
        math(String.raw`t`),
        " 自身の係数は ",
        math(String.raw`\mathrm{ac}_1(t)=1`),
        " であり、",
        math(String.raw`j\in\mathbb{N}`),
        " が ",
        math(String.raw`j\ne 1`),
        " を満たすとき ",
        math(String.raw`\mathrm{ac}_j(t)=0`),
        " である。",
        "また、係数がすべて等しい 2 つの多項式は等しい（",
        math(String.raw`f,g\in\overline{\mathbb{Q}}[t]`),
        " について、すべての ",
        math(String.raw`k\in\mathbb{N}`),
        " で ",
        math(String.raw`\mathrm{ac}_k(f)=\mathrm{ac}_k(g)`),
        " ならば ",
        math(String.raw`f=g`),
        "）。",
        "いずれも多項式環の作り方そのものであって、証明すべきことではない",
        "（多項式とは、有限個を除いて零である係数の族にほかならない）。",
      ]),
      paragraph([
        "現れるのは代数的数、有限和、有限積だけであり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_constant_embedding",
    kind: "definition",
    title: { text: "代数的数を定数多項式として送る写像" },
    labels: ["def_qbar_constant_embedding"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarConst"],
    verification: ["sagemath/check/qbar-poly-power-difference-factorization"],
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`\widehat{\ \cdot\ }:\overline{\mathbb{Q}}\to\overline{\mathbb{Q}}[t]`),
        " を、",
        math(String.raw`a\in\overline{\mathbb{Q}}`),
        " に対して ",
        math(String.raw`\mathrm{ac}_0(\widehat{a})=a`),
        " かつ ",
        math(String.raw`k\ge1`),
        " で ",
        math(String.raw`\mathrm{ac}_k(\widehat{a})=0`),
        " となる ",
        ref("def_qbar_polynomial_ring"),
        " の元 ",
        math(String.raw`\widehat{a}`),
        " を返す写像として定める。",
      ]),
      paragraph([
        "係数の言葉で書いた和と積の定義（",
        ref("def_qbar_polynomial_ring"),
        "）から、",
        math(String.raw`a,b\in\overline{\mathbb{Q}}`),
        " について ",
        math(String.raw`\widehat{a+b}=\widehat{a}+\widehat{b}`),
        "、",
        math(String.raw`\widehat{a\,b}=\widehat{a}\,\widehat{b}`),
        "、",
        math(String.raw`\widehat{1}=1`),
        "、",
        math(String.raw`\widehat{0}=0`),
        " が成り立つ。",
      ]),
      paragraph([
        "係数の集合の元 ",
        math(String.raw`a`),
        " と、それを定数として送った多項式 ",
        math(String.raw`\widehat{a}`),
        " を同じ記号では書かない（",
        ref("def_second_constant_embedding"),
        " と同じ約束である。",
        "同一視をせず、行き来はこの写像だけを通る）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_poly_power_difference_factorization",
    kind: "claim",
    title: {
      text: "不定元と定数の冪の差は、その 2 元の差を因子に持つ",
    },
    labels: ["claim_qbar_poly_power_difference_factorization"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyPowerDifferenceFactorization",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.power_difference_factorization_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyPowerDifferenceFactorization_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-poly-power-difference-factorization"],
    statement: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取り、",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。",
        ref("def_qbar_polynomial_ring"),
        " の元 ",
        math(String.raw`K_{n}(w)\in\overline{\mathbb{Q}}[t]`),
        " を ",
        math(String.raw`n`),
        " についての次の約束で定める（",
        math(String.raw`\widehat{w}`),
        " は ",
        ref("def_qbar_constant_embedding"),
        " による定数多項式である）。",
      ]),
      displayMath(
        String.raw`K_{0}(w):=0,\qquad K_{n+1}(w):=K_{n}(w)\,\widehat{w}+t^{\,n}`,
      ),
      paragraph([
        "このとき",
      ]),
      displayMath(String.raw`(t-\widehat{w})\,K_{n}(w)=t^{\,n}-\widehat{w}^{\,n}`),
      paragraph([
        "が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " を固定する。",
        "以下の計算はすべて ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        "（",
        ref("def_qbar_polynomial_ring"),
        "）の中で行う。",
      ]),
      paragraph([
        "準備。任意の ",
        math(String.raw`k\in\mathbb{N}`),
        " について ",
        math(String.raw`t\,t^{k}=t^{k}t`),
        " が成り立つ（冪の約束（",
        ref("def_qbar_polynomial_ring"),
        "）が与えるのは ",
        math(String.raw`t^{k+1}=t^{k}t`),
        " の向きだけなので、",
        math(String.raw`t\,t^{k}`),
        " をこれへ結び付けるにはこの等式が要る）。",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      displayMath(String.raw`\begin{aligned}
t\,t^{0}&=t\cdot 1
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{0}=1)\\
&=t
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}[t]\ \text{の積の単位元})\\
&=1\cdot t
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}[t]\ \text{の積の単位元})\\
&=t^{0}t
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{0}=1)
\end{aligned}`),
      paragraph([
        math(String.raw`t\,t^{k}=t^{k}t`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
t\,t^{k+1}&=t\bigl(t^{k}t\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{k+1}=t^{k}t)\\
&=\bigl(t\,t^{k}\bigr)t
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の積の結合則})\\
&=\bigl(t^{k}t\bigr)t
&&(\because\ \text{帰納法の仮定})\\
&=t^{k+1}t
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{k+1}=t^{k}t)
\end{aligned}`),
      paragraph([
        "以下、主張を ",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
(t-\widehat{w})\,K_{0}(w)&=(t-\widehat{w})\cdot 0
&&(\because\ K_{0}(w)=0\ \text{の約束})\\
&=0
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}[t]\ \text{の積の零元})\\
&=1-1
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の加法の逆元})\\
&=t^{0}-1
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{0}=1)\\
&=t^{0}-\widehat{w}^{\,0}
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ \widehat{w}^{\,0}=1)
\end{aligned}`),
      paragraph([
        "一歩（",
        math(String.raw`n`),
        " から ",
        math(String.raw`n+1`),
        " へ）。",
        math(String.raw`(t-\widehat{w})\,K_{n}(w)=t^{\,n}-\widehat{w}^{\,n}`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
(t-\widehat{w})\,K_{n+1}(w)&=(t-\widehat{w})\bigl(K_{n}(w)\,\widehat{w}+t^{\,n}\bigr)
&&(\because\ K_{n+1}(w)\ \text{の約束})\\
&=(t-\widehat{w})\bigl(K_{n}(w)\,\widehat{w}\bigr)+(t-\widehat{w})t^{\,n}
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の分配則})\\
&=\bigl((t-\widehat{w})K_{n}(w)\bigr)\widehat{w}+(t-\widehat{w})t^{\,n}
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の積の結合則})\\
&=\bigl(t^{\,n}-\widehat{w}^{\,n}\bigr)\widehat{w}+(t-\widehat{w})t^{\,n}
&&(\because\ \text{帰納法の仮定})\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n}\widehat{w}\bigr)+(t-\widehat{w})t^{\,n}
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の分配則})\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n+1}\bigr)+(t-\widehat{w})t^{\,n}
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ \widehat{w}^{\,n+1}=\widehat{w}^{\,n}\widehat{w})\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n+1}\bigr)+\bigl(t\,t^{\,n}-\widehat{w}\,t^{\,n}\bigr)
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の分配則})\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n+1}\bigr)+\bigl(t^{\,n}t-\widehat{w}\,t^{\,n}\bigr)
&&(\because\ \text{準備の等式}\ t\,t^{\,n}=t^{\,n}t)\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n+1}\bigr)+\bigl(t^{\,n+1}-\widehat{w}\,t^{\,n}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{\,n+1}=t^{\,n}t)\\
&=\bigl(t^{\,n}\widehat{w}-\widehat{w}^{\,n+1}\bigr)+\bigl(t^{\,n+1}-t^{\,n}\widehat{w}\bigr)
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の積の可換則})\\
&=t^{\,n+1}-\widehat{w}^{\,n+1}
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の加法の結合則と可換則により}\ t^{\,n}\widehat{w}\ \text{が相殺する})
\end{aligned}`),
      paragraph([
        "出発点と一歩により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "第 10 の等号で引いた ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の積の可換則（この鎖で使うのは ",
        math(String.raw`\widehat{w}\,t^{\,n}=t^{\,n}\widehat{w}`),
        " の場合である）は、係数の言葉で書いた積の定義（",
        ref("def_qbar_polynomial_ring"),
        "）と ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の積の可換則から出る。",
        "係数どうしの積が可換なら多項式どうしの積も可換だからである。",
        "ここを「",
        math(String.raw`t`),
        " と ",
        math(String.raw`\widehat{w}`),
        " が可換であること」で埋めることはできない。",
        "この鎖が必要とするのは ",
        math(String.raw`\widehat{w}`),
        " と ",
        math(String.raw`t^{\,n}`),
        " の可換性であり、それを ",
        math(String.raw`t`),
        " との可換性から出すには ",
        math(String.raw`n`),
        " についての帰納法がもう 1 本要るからである",
        "（住む環が可換である以上、その 1 本を立てるより積の可換則を引くほうが短い。",
        "2 元の可換性だけで足りることは Lean の必要十分版が示す）。",
      ]),
      paragraph([
        "この主張は ",
        ref("claim_qbar_power_difference_factorization"),
        "（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の 2 元についての同じ等式）と同じ鎖であり、住む環だけが ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " から ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " へ変わっている。",
        "同じ鎖を 2 度書いているのは、人手証明を一般の環へ持ち上げないという規則による",
        "（持ち上げるのは Lean の必要十分版だけで、そこでは 2 つは同じ 1 本の定理の別々の特殊化である）。",
      ]),
      paragraph([
        "これは、",
        math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        " が ",
        math(String.raw`w`),
        " を根に持つとき ",
        math(String.raw`f`),
        " が ",
        math(String.raw`(t-\widehat{w})`),
        " を因子に持つこと（因数定理）を示すための足場である。",
        "そこでは ",
        math(String.raw`f`),
        " を係数と冪の有限和に分け、各項へこの等式を当てて ",
        math(String.raw`(t-\widehat{w})`),
        " をくくり出す。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_poly_indeterminate_power_coefficient",
    kind: "claim",
    title: {
      text: "不定元の冪の係数は、番号が指数と一致するときだけ単位元である",
    },
    labels: ["claim_qbar_poly_indeterminate_power_coefficient"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyIndeterminatePowerCoefficient",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.indeterminate_power_coefficient_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyIndeterminatePowerCoefficient_from_necSuf",
    ],
    verification: [
      "sagemath/check/qbar-poly-indeterminate-power-coefficient",
    ],
    statement: [
      paragraph([
        math(String.raw`k\in\mathbb{N}`),
        " と ",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取る。",
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " において",
      ]),
      displayMath(String.raw`\mathrm{ac}_j\bigl(t^{\,k}\bigr)=
\begin{cases}
1 & (j=k)\\
0 & (j\ne k)
\end{cases}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`1`),
        " と ",
        math(String.raw`0`),
        " は係数環 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の積の単位元と加法の零元であり、",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " のそれではない）。",
      ]),
    ],
    proof: [
      paragraph([
        "係数の計算はすべて ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の中で行う。",
        math(String.raw`k`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`k=0`),
        "）。",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_j\bigl(t^{\,0}\bigr)&=\mathrm{ac}_j(1)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{0}=1)\\
&=\begin{cases}
1 & (j=0)\\
0 & (j\ne 0)
\end{cases}
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の}\ 1\ \text{の係数})
\end{aligned}`),
      paragraph([
        "これは ",
        math(String.raw`k=0`),
        " の場合の主張そのものである。",
      ]),
      paragraph([
        "一歩（",
        math(String.raw`k`),
        " から ",
        math(String.raw`k+1`),
        " へ）。すべての ",
        math(String.raw`j\in\mathbb{N}`),
        " について ",
        math(String.raw`\mathrm{ac}_j(t^{\,k})`),
        " が ",
        math(String.raw`j=k`),
        " のとき ",
        math(String.raw`1`),
        "、そうでないとき ",
        math(String.raw`0`),
        " であることを仮定する。",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`j=0`),
        " の場合と ",
        math(String.raw`j\ge 1`),
        " の場合に分ける（この 2 つで ",
        math(String.raw`\mathbb{N}`),
        " を尽くす）。",
      ]),
      paragraph([
        "場合 1（",
        math(String.raw`j=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_0\bigl(t^{\,k+1}\bigr)&=\mathrm{ac}_0\bigl(t^{\,k}t\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{\,k+1}=t^{\,k}t)\\
&=\sum_{i=0}^{0}\mathrm{ac}_i\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{0-i}(t)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の積の係数})\\
&=\mathrm{ac}_0\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{0}(t)
&&(\because\ \text{和の項が}\ i=0\ \text{の}\ 1\ \text{つだけであること})\\
&=\mathrm{ac}_0\bigl(t^{\,k}\bigr)\cdot 0
&&(\because\ 0\ne 1\ \text{なので}\ \blkref{def_qbar_polynomial_ring}\ \text{より}\ \mathrm{ac}_0(t)=0)\\
&=0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元との積は零元})
\end{aligned}`),
      paragraph([
        "一方 ",
        math(String.raw`0\ne k+1`),
        " なので、これは ",
        math(String.raw`j=0`),
        " における主張である。",
      ]),
      paragraph([
        "場合 2（",
        math(String.raw`j\ge 1`),
        "）。",
        math(String.raw`j=j'+1`),
        " となる ",
        math(String.raw`j'\in\mathbb{N}`),
        " を取る。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_{j'+1}\bigl(t^{\,k+1}\bigr)&=\mathrm{ac}_{j'+1}\bigl(t^{\,k}t\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{\,k+1}=t^{\,k}t)\\
&=\sum_{i=0}^{j'+1}\mathrm{ac}_i\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{j'+1-i}(t)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の積の係数})\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{1}(t)
+\sum_{\substack{0\le i\le j'+1\\ i\ne j'}}\mathrm{ac}_i\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{j'+1-i}(t)
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の結合則と可換則により}\ i=j'\ \text{の項を取り出す})\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{1}(t)
+\sum_{\substack{0\le i\le j'+1\\ i\ne j'}}\mathrm{ac}_i\bigl(t^{\,k}\bigr)\cdot 0
&&(\because\ i\ne j'\ \text{では}\ j'+1-i\ne 1\ \text{なので}\ \blkref{def_qbar_polynomial_ring}\ \text{より}\ \mathrm{ac}_{j'+1-i}(t)=0)\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{1}(t)
+\sum_{\substack{0\le i\le j'+1\\ i\ne j'}}0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元との積は零元})\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{1}(t)+0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元だけからなる有限和は零元})\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot\mathrm{ac}_{1}(t)
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元})\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)\cdot 1
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{より}\ \mathrm{ac}_1(t)=1)\\
&=\mathrm{ac}_{j'}\bigl(t^{\,k}\bigr)
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元})\\
&=\begin{cases}
1 & (j'=k)\\
0 & (j'\ne k)
\end{cases}
&&(\because\ \text{帰納法の仮定})
\end{aligned}`),
      paragraph([
        math(String.raw`j'=k`),
        " と ",
        math(String.raw`j'+1=k+1`),
        " は同値なので（",
        math(String.raw`\mathbb{N}`),
        " の後者は単射である）、これは ",
        math(String.raw`j=j'+1`),
        " における主張である。",
      ]),
      paragraph([
        "場合 1 と場合 2 ですべての ",
        math(String.raw`j\in\mathbb{N}`),
        " を尽くしたので一歩が言えた。",
        "出発点と一歩により、すべての ",
        math(String.raw`k\in\mathbb{N}`),
        " とすべての ",
        math(String.raw`j\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この主張は、多項式 ",
        math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        " をその係数を用いた単項式の有限和 ",
        math(String.raw`\sum_{k}\widehat{\mathrm{ac}_k(f)}\,t^{\,k}`),
        "（",
        math(String.raw`\widehat{\ \cdot\ }`),
        " は ",
        ref("def_qbar_constant_embedding"),
        "）へ分解するための足場である。",
        "分解が書ければ、各項へ ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " を当てて ",
        math(String.raw`(t-\widehat{w})`),
        " をくくり出せる（因数定理）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_definition_qbar_poly_evaluation",
    kind: "definition",
    title: {
      text: "代数的数を係数とする多項式の、代数的数における値",
    },
    labels: ["def_qbar_poly_evaluation"],
    habitat: "Qbar",
    lean: ["Ising2DLambda.AlgebraicEigenvalue.qbarPolyEval"],
    verification: ["sagemath/check/qbar-poly-monomial-decomposition"],
    statement: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " を任意に取る（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は ",
        ref("def_algebraic_numbers"),
        "）。",
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の元 ",
        math(String.raw`f`),
        " に対し、その値を",
      ]),
      displayMath(
        String.raw`\mathrm{aev}_{w}(f):=\sum_{k:\ \mathrm{ac}_k(f)\ne 0}\mathrm{ac}_k(f)\cdot w^{\,k}\ \in\ \overline{\mathbb{Q}}`,
      ),
      paragraph([
        "で定める。ここで ",
        math(String.raw`\mathrm{ac}_k(f)\in\overline{\mathbb{Q}}`),
        " は ",
        ref("def_qbar_polynomial_ring"),
        " の係数であり、",
        math(String.raw`w^{\,k}`),
        " は ",
        ref("def_root_of_unity_set"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元の冪の約束による。",
        "和は有限個の項からなる（",
        math(String.raw`\mathrm{ac}_k(f)\ne 0`),
        " となる ",
        math(String.raw`k`),
        " は有限個だから）。",
      ]),
      paragraph([
        math(String.raw`\mathrm{aev}_{w}:\overline{\mathbb{Q}}[t]\to\overline{\mathbb{Q}}`),
        " は和と積を保ち、",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の零元を ",
        math(String.raw`0`),
        " へ、単位元を ",
        math(String.raw`1`),
        " へ送る（多項式環からの代入が環準同型であることの、係数環を動かさない場合である。",
        ref("def_second_evaluation"),
        " で ",
        math(String.raw`\mathbb{Z}[x][t]`),
        " について置いた約束と同じ形のもので、証明すべきことではない）。",
        "とくに加法についての逆元を逆元へ送る。",
      ]),
      paragraph([
        math(String.raw`a\in\overline{\mathbb{Q}}`),
        " について ",
        math(String.raw`\mathrm{aev}_{w}(\widehat{a})=a`),
        " であり（",
        ref("def_qbar_constant_embedding"),
        " より ",
        math(String.raw`\widehat{a}`),
        " は ",
        math(String.raw`\mathrm{ac}_0=a`),
        " で他の係数が ",
        math(String.raw`0`),
        " の元だから）、また ",
        math(String.raw`\mathrm{aev}_{w}(t)=w`),
        " である（",
        ref("def_qbar_polynomial_ring"),
        " より ",
        math(String.raw`\mathrm{ac}_1(t)=1`),
        " で他の係数が ",
        math(String.raw`0`),
        " だから）。",
      ]),
      paragraph([
        "現れるのは代数的数と有限和・有限積だけであり、実数体も複素数体も現れない",
        "（",
        math(String.raw`\overline{\mathbb{Q}}`),
        " は可算集合である。",
        ref("def_algebraic_numbers"),
        "）。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_poly_monomial_decomposition",
    kind: "claim",
    title: {
      text: "多項式は、その係数を定数として送ったものと不定元の冪との積の有限和に等しい",
    },
    labels: ["claim_qbar_poly_monomial_decomposition"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyMonomialDecomposition",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.monomial_decomposition_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyMonomialDecomposition_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-poly-monomial-decomposition"],
    statement: [
      paragraph([
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の元 ",
        math(String.raw`f`),
        " と ",
        math(String.raw`n\in\mathbb{N}`),
        " を、「",
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k>n`),
        " を満たすならば ",
        math(String.raw`\mathrm{ac}_k(f)=0`),
        " である」を満たすように取る（",
        ref("def_qbar_polynomial_ring"),
        " より ",
        math(String.raw`\mathrm{ac}_k(f)\ne 0`),
        " となる ",
        math(String.raw`k`),
        " は有限個なので、そのような ",
        math(String.raw`n`),
        " は必ず取れる）。このとき",
      ]),
      displayMath(
        String.raw`f=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\cdot t^{\,k}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\widehat{\ \cdot\ }`),
        " は ",
        ref("def_qbar_constant_embedding"),
        "、和と積は ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " のものである）。",
      ]),
    ],
    proof: [
      paragraph([
        "係数の計算はすべて係数環 ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の中で行う。",
        "まず準備として、",
        math(String.raw`a\in\overline{\mathbb{Q}}`),
        " と ",
        math(String.raw`k\in\mathbb{N}`),
        " と ",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`\mathrm{ac}_j\bigl(\widehat{a}\,t^{\,k}\bigr)`),
        " を求める。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_j\bigl(\widehat{a}\,t^{\,k}\bigr)
&=\sum_{i=0}^{j}\mathrm{ac}_i\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j-i}\bigl(t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の積の係数})\\
&=\mathrm{ac}_0\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)
+\sum_{i=1}^{j}\mathrm{ac}_i\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j-i}\bigl(t^{\,k}\bigr)
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法の結合則と可換則により}\ i=0\ \text{の項を取り出す})\\
&=\mathrm{ac}_0\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)
+\sum_{i=1}^{j}0\cdot\mathrm{ac}_{j-i}\bigl(t^{\,k}\bigr)
&&(\because\ i\ge 1\ \text{では}\ \blkref{def_qbar_constant_embedding}\ \text{より}\ \mathrm{ac}_i(\widehat{a})=0)\\
&=\mathrm{ac}_0\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)+\sum_{i=1}^{j}0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元との積は零元})\\
&=\mathrm{ac}_0\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)+0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元だけからなる有限和は零元})\\
&=\mathrm{ac}_0\bigl(\widehat{a}\bigr)\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元})\\
&=a\cdot\mathrm{ac}_{j}\bigl(t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{より}\ \mathrm{ac}_0(\widehat{a})=a)\\
&=a\cdot\begin{cases}
1 & (j=k)\\
0 & (j\ne k)
\end{cases}
&&(\because\ \blkref{claim_qbar_poly_indeterminate_power_coefficient})\\
&=\begin{cases}
a & (j=k)\\
0 & (j\ne k)
\end{cases}
&&(\because\ 1\ \text{は}\ \overline{\mathbb{Q}}\ \text{の積の単位元、}\ 0\ \text{との積は零元})
\end{aligned}`),
      paragraph([
        "以下、この結果を「準備の段」と呼ぶ。",
        "次に ",
        math(String.raw`g:=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\cdot t^{\,k}\in\overline{\mathbb{Q}}[t]`),
        " と置き、",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取って ",
        math(String.raw`\mathrm{ac}_j(g)=\mathrm{ac}_j(f)`),
        " を示す。",
        math(String.raw`j\le n`),
        " の場合と ",
        math(String.raw`j>n`),
        " の場合に分ける（この 2 つで ",
        math(String.raw`\mathbb{N}`),
        " を尽くす）。",
      ]),
      paragraph([
        "場合 1（",
        math(String.raw`j\le n`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_j(g)
&=\sum_{k=0}^{n}\mathrm{ac}_j\bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数を有限和へ繰り返し当てる})\\
&=\mathrm{ac}_j\bigl(\widehat{\mathrm{ac}_j(f)}\,t^{\,j}\bigr)
+\sum_{\substack{0\le k\le n\\ k\ne j}}\mathrm{ac}_j\bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}\bigr)
&&(\because\ j\le n\ \text{より}\ k=j\ \text{の項が和の範囲にあり、}\ \overline{\mathbb{Q}}\ \text{の加法の結合則と可換則で取り出せる})\\
&=\mathrm{ac}_j(f)
+\sum_{\substack{0\le k\le n\\ k\ne j}}\mathrm{ac}_j\bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}\bigr)
&&(\because\ \text{準備の段を}\ a=\mathrm{ac}_j(f)\ \text{と}\ k=j\ \text{へ当てる})\\
&=\mathrm{ac}_j(f)+\sum_{\substack{0\le k\le n\\ k\ne j}}0
&&(\because\ k\ne j\ \text{なので準備の段})\\
&=\mathrm{ac}_j(f)+0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元だけからなる有限和は零元})\\
&=\mathrm{ac}_j(f)
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元})
\end{aligned}`),
      paragraph([
        "場合 2（",
        math(String.raw`j>n`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_j(g)
&=\sum_{k=0}^{n}\mathrm{ac}_j\bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数を有限和へ繰り返し当てる})\\
&=\sum_{k=0}^{n}0
&&(\because\ 0\le k\le n<j\ \text{より}\ k\ne j\ \text{なので準備の段})\\
&=0
&&(\because\ \overline{\mathbb{Q}}\ \text{の零元だけからなる有限和は零元})\\
&=\mathrm{ac}_j(f)
&&(\because\ j>n\ \text{についての仮定})
\end{aligned}`),
      paragraph([
        "場合 1 と場合 2 ですべての ",
        math(String.raw`j\in\mathbb{N}`),
        " を尽くしたので、すべての ",
        math(String.raw`j\in\mathbb{N}`),
        " について ",
        math(String.raw`\mathrm{ac}_j(g)=\mathrm{ac}_j(f)`),
        " である。",
        "係数がすべて等しい 2 つの多項式は等しい（",
        ref("def_qbar_polynomial_ring"),
        "）ので ",
        math(String.raw`f=g`),
        "、すなわち主張の等式が成り立つ。",
      ]),
      paragraph([
        "この分解が書けたので、次はその各項へ ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " を当てて ",
        math(String.raw`(t-\widehat{w})`),
        " をくくり出せる（因数定理）。",
        "そこで根であることを述べるために ",
        ref("def_qbar_poly_evaluation"),
        " の ",
        math(String.raw`\mathrm{aev}_{w}`),
        " を使う。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_constant_embedding_pow",
    kind: "claim",
    title: {
      text: "定数として送る写像は冪を冪へ写す",
    },
    labels: ["claim_qbar_constant_embedding_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarConstEmbeddingPow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.constant_embedding_pow_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarConstEmbeddingPow_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-const-embedding-pow"],
    statement: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`\widehat{w^{\,n}}=\widehat{w}^{\,n}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\widehat{\ \cdot\ }`),
        " は ",
        ref("def_qbar_constant_embedding"),
        "。左辺の冪は ",
        ref("def_root_of_unity_set"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元の冪の約束、右辺の冪は ",
        ref("def_qbar_polynomial_ring"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の元の冪の約束である。",
        "2 つの冪は住む環が違う別々の約束なので、この等式は約束からは出ず、示すべき主張である）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " を固定し、",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat{w^{\,0}}&=\widehat{1}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{0}=1)\\
&=1
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{の}\ \widehat{1}=1)\\
&=\widehat{w}^{\,0}
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ \widehat{w}^{\,0}=1)
\end{aligned}`),
      paragraph([
        "一歩（",
        math(String.raw`n`),
        " から ",
        math(String.raw`n+1`),
        " へ）。",
        math(String.raw`\widehat{w^{\,n}}=\widehat{w}^{\,n}`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\widehat{w^{\,n+1}}&=\widehat{w^{\,n}w}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{n+1}=w^{n}w)\\
&=\widehat{w^{\,n}}\,\widehat{w}
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{の}\ \widehat{a\,b}=\widehat{a}\,\widehat{b})\\
&=\widehat{w}^{\,n}\,\widehat{w}
&&(\because\ \text{帰納法の仮定})\\
&=\widehat{w}^{\,n+1}
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ \widehat{w}^{\,n+1}=\widehat{w}^{\,n}\widehat{w})
\end{aligned}`),
      paragraph([
        "出発点と一歩により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "これは因数定理の鎖の一段のための足場である。",
        "そこでは根の条件 ",
        math(String.raw`\mathrm{aev}_{w}(f)=0`),
        "（",
        ref("def_qbar_poly_evaluation"),
        "）を定数として送った ",
        math(String.raw`\widehat{\mathrm{aev}_{w}(f)}`),
        " を係数ごとの項 ",
        math(String.raw`\widehat{\mathrm{ac}_k(f)}\,\widehat{w}^{\,k}`),
        " の有限和へ開くとき、",
        math(String.raw`\widehat{w^{\,k}}`),
        " を ",
        math(String.raw`\widehat{w}^{\,k}`),
        " へ書き換える段でこの主張を使う。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_evaluation_indeterminate_pow",
    kind: "claim",
    title: {
      text: "代入は不定元の冪を代数的数の冪へ写す",
    },
    labels: ["claim_qbar_evaluation_indeterminate_pow"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyEvalIndeterminatePow",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.constant_embedding_pow_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyEvalIndeterminatePow_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-evaluation-indeterminate-pow"],
    statement: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取る。このとき",
      ]),
      displayMath(String.raw`\mathrm{aev}_{w}\bigl(t^{\,n}\bigr)=w^{\,n}`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{aev}_{w}`),
        " は ",
        ref("def_qbar_poly_evaluation"),
        "。左辺の冪は ",
        ref("def_qbar_polynomial_ring"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の元の冪の約束、右辺の冪は ",
        ref("def_root_of_unity_set"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元の冪の約束である）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " を固定し、",
        math(String.raw`n`),
        " についての帰納法で示す。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{aev}_{w}\bigl(t^{\,0}\bigr)
&=\mathrm{aev}_{w}(1)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{0}=1)\\
&=1
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より}\ \mathrm{aev}_{w}\ \text{は単位元を保つ})\\
&=w^{\,0}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{0}=1)
\end{aligned}`),
      paragraph([
        "一歩（",
        math(String.raw`n`),
        " から ",
        math(String.raw`n+1`),
        " へ）。",
        math(String.raw`\mathrm{aev}_{w}(t^{\,n})=w^{\,n}`),
        " を仮定する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{aev}_{w}\bigl(t^{\,n+1}\bigr)
&=\mathrm{aev}_{w}\bigl(t^{\,n}t\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の約束}\ t^{n+1}=t^{n}t)\\
&=\mathrm{aev}_{w}\bigl(t^{\,n}\bigr)\,\mathrm{aev}_{w}(t)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より}\ \mathrm{aev}_{w}\ \text{は積を保つ})\\
&=w^{\,n}\,\mathrm{aev}_{w}(t)
&&(\because\ \text{帰納法の仮定})\\
&=w^{\,n}w
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{の}\ \mathrm{aev}_{w}(t)=w)\\
&=w^{\,n+1}
&&(\because\ \blkref{def_root_of_unity_set}\ \text{の約束}\ w^{n+1}=w^{n}w)
\end{aligned}`),
      paragraph([
        "出発点と一歩により、すべての ",
        math(String.raw`n\in\mathbb{N}`),
        " について主張が成り立つ。",
      ]),
      paragraph([
        "この主張は、多項式の値を係数の有限和で書く次の段で、",
        math(String.raw`\mathrm{aev}_{w}(t^{\,k})`),
        " を ",
        math(String.raw`w^{\,k}`),
        " へ書き換えるために使う。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_evaluation_coefficient_sum",
    kind: "claim",
    title: {
      text: "多項式の値は係数の有限和で書ける",
    },
    labels: ["claim_qbar_evaluation_coefficient_sum"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyEvalCoefficientSum",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.finite_sum_map_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPolyEvalCoefficientSum_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-evaluation-coefficient-sum"],
    statement: [
      paragraph([
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\overline{\mathbb{Q}}[t]`),
        " の元 ",
        math(String.raw`f`),
        " と ",
        math(String.raw`n\in\mathbb{N}`),
        " を、「",
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k>n`),
        " を満たすならば ",
        math(String.raw`\mathrm{ac}_k(f)=0`),
        " である」を満たすように取り（",
        ref("claim_qbar_poly_monomial_decomposition"),
        " と同じ取り方である）、",
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。このとき",
      ]),
      displayMath(
        String.raw`\mathrm{aev}_{w}(f)=\sum_{k=0}^{n}\mathrm{ac}_k(f)\cdot w^{\,k}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{aev}_{w}`),
        " は ",
        ref("def_qbar_poly_evaluation"),
        "。右辺の和と積は ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " のもの、",
        math(String.raw`w^{\,k}`),
        " は ",
        ref("def_root_of_unity_set"),
        " で置いた ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の元の冪の約束である）。",
        ref("def_qbar_poly_evaluation"),
        " の和は係数が零でない項だけを走るが、この右辺は ",
        math(String.raw`0`),
        " から ",
        math(String.raw`n`),
        " までのすべての ",
        math(String.raw`k`),
        " を走る。この 2 つが等しいことが主張である。",
      ]),
    ],
    proof: [
      displayMath(String.raw`\begin{aligned}
\mathrm{aev}_{w}(f)
&=\mathrm{aev}_{w}\Bigl(\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\cdot t^{\,k}\Bigr)
&&(\because\ \blkref{claim_qbar_poly_monomial_decomposition})\\
&=\sum_{k=0}^{n}\mathrm{aev}_{w}\bigl(\widehat{\mathrm{ac}_k(f)}\cdot t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より}\ \mathrm{aev}_{w}\ \text{は和を保つ。有限和へ繰り返し当てる})\\
&=\sum_{k=0}^{n}\mathrm{aev}_{w}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{aev}_{w}\bigl(t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より}\ \mathrm{aev}_{w}\ \text{は積を保つ。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\mathrm{ac}_k(f)\cdot\mathrm{aev}_{w}\bigl(t^{\,k}\bigr)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{の}\ \mathrm{aev}_{w}(\widehat{a})=a\ \text{を各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\mathrm{ac}_k(f)\cdot w^{\,k}
&&(\because\ \blkref{claim_qbar_evaluation_indeterminate_pow}\ \text{を各項へ同時に当てる})
\end{aligned}`),
      paragraph([
        "終点は主張の右辺である。",
      ]),
      paragraph([
        "この主張は、因数定理の段で使う。",
        math(String.raw`f`),
        " から ",
        math(String.raw`\widehat{\mathrm{aev}_{w}(f)}`),
        " を引いた差を係数の有限和で書き直し、各項へ ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " を当てて ",
        math(String.raw`(t-\widehat{w})`),
        " をくくり出す。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_factor_theorem",
    kind: "claim",
    title: { text: "根を持つ多項式は一次式を因子に持つ" },
    labels: ["claim_qbar_factor_theorem"],
    habitat: "Qbar",
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorTheorem",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.factor_from_finite_sum_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorTheorem_from_necSuf",
    ],
    verification: ["sagemath/check/qbar-factor-theorem"],
    statement: [
      paragraph([
        ref("def_qbar_polynomial_ring"),
        " の元 ", math(String.raw`f\in\overline{\mathbb{Q}}[t]`), " と ",
        math(String.raw`n\in\mathbb{N}`), " を、", math(String.raw`k>n`),
        " ならば ", math(String.raw`\mathrm{ac}_k(f)=0`), " となるように取り、",
        math(String.raw`w\in\overline{\mathbb{Q}}`), " を任意に取る。",
        ref("def_qbar_poly_evaluation"), " の値が ",
        math(String.raw`\mathrm{aev}_{w}(f)=0`), " を満たすならば、",
      ]),
      displayMath(
        String.raw`g:=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)\in\overline{\mathbb{Q}}[t]`,
      ),
      paragraph([
        "と置くと（",
        math(String.raw`\widehat{\ \cdot\ }`),
        " は ",
        ref("def_qbar_constant_embedding"),
        "、",
        math(String.raw`K_k(w)`),
        " は ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " の約束）、",
      ]),
      displayMath(String.raw`f=(t-\widehat{w})g`),
      paragraph([
        "が成り立つ。特に、この等式を満たす ",
        math(String.raw`g\in\overline{\mathbb{Q}}[t]`),
        " が存在する。商 ",
        math(String.raw`g`),
        " を式で指定して主張するのは、あとの議論（相異なる根の個数を数える帰納法）が、",
        "同じ ",
        math(String.raw`g`),
        " について本主張の等式と ",
        ref("claim_qbar_factor_quotient_coeff_bound"),
        " の係数上界を同時に使うためである（存在だけを主張すると、2 つの主張が同じ商を指す保証がない）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の計算はすべて ", math(String.raw`\overline{\mathbb{Q}}[t]`), " の中で行う。",
      ]),
      displayMath(String.raw`\begin{aligned}
f
&=f-\widehat{\mathrm{aev}_{w}(f)}
&&(\because\ \mathrm{aev}_{w}(f)=0\ \text{と}\ \blkref{def_qbar_constant_embedding}\ \text{の}\ \widehat{0}=0)\\
&=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,t^{\,k}
-\widehat{\sum_{k=0}^{n}\mathrm{ac}_k(f)\,w^{\,k}}
&&(\because\ \blkref{claim_qbar_poly_monomial_decomposition}\ \text{と}\ \blkref{claim_qbar_evaluation_coefficient_sum})\\
&=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,t^{\,k}
-\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)\,w^{\,k}}
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{より定数として送る写像は和を保つ。有限和へ繰り返し当てる})\\
&=\sum_{k=0}^{n}\Bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}
-\widehat{\mathrm{ac}_k(f)\,w^{\,k}}\Bigr)
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の有限和と加法の逆元の分配})\\
&=\sum_{k=0}^{n}\Bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}
-\widehat{\mathrm{ac}_k(f)}\cdot\widehat{w^{\,k}}\Bigr)
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{より定数として送る写像は積を保つ。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\Bigl(\widehat{\mathrm{ac}_k(f)}\,t^{\,k}
-\widehat{\mathrm{ac}_k(f)}\cdot\widehat{w}^{\,k}\Bigr)
&&(\because\ \blkref{claim_qbar_constant_embedding_pow}\ \text{を各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\bigl(t^{\,k}-\widehat{w}^{\,k}\bigr)
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の分配則で各項をくくる})\\
&=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,(t-\widehat{w})K_k(w)
&&(\because\ \blkref{claim_qbar_poly_power_difference_factorization}\ \text{を各項へ同時に当てる})\\
&=(t-\widehat{w})\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)
&&(\because\ \overline{\mathbb{Q}}[t]\ \text{の積の結合則・可換則と有限和への分配則})\\
&=(t-\widehat{w})g
&&(\because\ g\ \text{の定め方})
\end{aligned}`),
      paragraph(["終点が求める等式である。"]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_pow_diff_sum_coeff_bound",
    kind: "claim",
    title: { text: "冪の差の因数分解の商の係数は、その番号以上で零である" },
    labels: ["claim_qbar_pow_diff_sum_coeff_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/qbar-pow-diff-sum-coeff-bound"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarPowDiffSumCoeffBound",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.pow_diff_sum_coeff_bound_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarPowDiffSumCoeffBound_from_necSuf",
    ],
    statement: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）と ",
        math(String.raw`n\in\mathbb{N}`),
        " を任意に取り、",
        math(String.raw`K_{n}(w)\in\overline{\mathbb{Q}}[t]`),
        " を ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " の約束（",
        math(String.raw`K_{0}(w)=0`),
        "、",
        math(String.raw`K_{n+1}(w)=K_{n}(w)\,\widehat{w}+t^{\,n}`),
        "）で取る。このとき、",
        math(String.raw`j\in\mathbb{N}`),
        " が ",
        math(String.raw`n\le j`),
        " を満たすならば",
      ]),
      displayMath(String.raw`\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)=0`),
      paragraph([
        "が成り立つ（",
        math(String.raw`\mathrm{ac}_{j}`),
        " は ",
        ref("def_qbar_polynomial_ring"),
        " の係数）。この主張は、根の個数を次数で抑える段で使う。",
        ref("claim_qbar_factor_theorem"),
        " が構成した商 ",
        math(String.raw`g=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)`),
        " の係数が ",
        math(String.raw`n-1`),
        " より先で尽きることが、ここから出る。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        " を固定する。以下の係数はすべて ",
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\mathrm{ac}_{j}`),
        " であり、値の計算はすべて ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の中で行う。",
        math(String.raw`n`),
        " についての帰納法で示す（",
        math(String.raw`j`),
        " は各段の中で任意に取る）。",
      ]),
      paragraph([
        "出発点（",
        math(String.raw`n=0`),
        "）。",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取る（",
        math(String.raw`0\le j`),
        " は常に成り立つ）。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_{j}\bigl(K_{0}(w)\bigr)
&=\mathrm{ac}_{j}(0)
&&(\because\ \blkref{claim_qbar_poly_power_difference_factorization}\ \text{の約束}\ K_{0}(w)=0)\\
&=0
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の零元はすべての係数が零の族である})
\end{aligned}`),
      paragraph([
        "一歩。「",
        math(String.raw`n\le j'`),
        " を満たす任意の ",
        math(String.raw`j'\in\mathbb{N}`),
        " について ",
        math(String.raw`\mathrm{ac}_{j'}(K_{n}(w))=0`),
        "」を仮定し、",
        math(String.raw`n+1\le j`),
        " を満たす ",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取る。",
        math(String.raw`n+1\le j`),
        " から ",
        math(String.raw`j\ne n`),
        "、",
        math(String.raw`n\le j`),
        "、および ",
        math(String.raw`1\le j`),
        " が従う。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_{j}\bigl(K_{n+1}(w)\bigr)
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\,\widehat{w}+t^{\,n}\bigr)
&&(\because\ \blkref{claim_qbar_poly_power_difference_factorization}\ \text{の約束}\ K_{n+1}(w)=K_{n}(w)\,\widehat{w}+t^{\,n})\\
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\,\widehat{w}\bigr)+\mathrm{ac}_{j}\bigl(t^{\,n}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数})\\
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\,\widehat{w}\bigr)+0
&&(\because\ j\ne n\ \text{なので}\ \blkref{claim_qbar_poly_indeterminate_power_coefficient})\\
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\,\widehat{w}\bigr)
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元})\\
&=\sum_{i=0}^{j}\mathrm{ac}_{i}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{j-i}\bigl(\widehat{w}\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の積の係数})\\
&=\Bigl(\sum_{i=0}^{j-1}\mathrm{ac}_{i}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{j-i}\bigl(\widehat{w}\bigr)\Bigr)
+\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{0}\bigl(\widehat{w}\bigr)
&&(\because\ 1\le j\ \text{なので有限和から}\ i=j\ \text{の項を分ける})\\
&=\Bigl(\sum_{i=0}^{j-1}\mathrm{ac}_{i}\bigl(K_{n}(w)\bigr)\cdot 0\Bigr)
+\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{0}\bigl(\widehat{w}\bigr)
&&(\because\ i\le j-1\ \text{の各項では}\ 1\le j-i\ \text{なので}\ \blkref{def_qbar_constant_embedding}\ \text{を各項へ同時に当てる})\\
&=\Bigl(\sum_{i=0}^{j-1}0\Bigr)
+\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{0}\bigl(\widehat{w}\bigr)
&&(\because\ \text{零を掛けると零。各項へ同時に当てる})\\
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)\cdot\mathrm{ac}_{0}\bigl(\widehat{w}\bigr)
&&(\because\ 0\ \text{は加法の単位元。有限和の各項へ繰り返し当てる})\\
&=\mathrm{ac}_{j}\bigl(K_{n}(w)\bigr)\cdot w
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{の}\ \mathrm{ac}_{0}(\widehat{w})=w)\\
&=0\cdot w
&&(\because\ n\le j\ \text{なので帰納法の仮定を}\ j'=j\ \text{へ当てる})\\
&=0
&&(\because\ \text{零を掛けると零})
\end{aligned}`),
      paragraph([
        "終点は主張の右辺である。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_factor_quotient_coeff_bound",
    kind: "claim",
    title: { text: "因数定理の商の係数は、上界の番号以上で零である" },
    labels: ["claim_qbar_factor_quotient_coeff_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/qbar-factor-quotient-coeff-bound"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorQuotientCoeffBound",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.factor_quotient_coeff_bound_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorQuotientCoeffBound_from_necSuf",
    ],
    statement: [
      paragraph([
        ref("def_qbar_polynomial_ring"),
        " の元 ",
        math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        " と ",
        math(String.raw`n\in\mathbb{N}`),
        " を、「",
        math(String.raw`k\in\mathbb{N}`),
        " が ",
        math(String.raw`k>n`),
        " を満たすならば ",
        math(String.raw`\mathrm{ac}_k(f)=0`),
        " である」を満たすように取り（",
        ref("claim_qbar_poly_monomial_decomposition"),
        " と同じ取り方である）、",
        math(String.raw`w\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。",
        ref("claim_qbar_factor_theorem"),
        " が構成した商と同じ式で",
      ]),
      displayMath(
        String.raw`g:=\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)\in\overline{\mathbb{Q}}[t]`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`\widehat{\mathrm{ac}_k(f)}`),
        " は係数を ",
        ref("def_qbar_constant_embedding"),
        " の定数として送る写像で送った定数多項式、",
        math(String.raw`K_k(w)`),
        " は ",
        ref("claim_qbar_poly_power_difference_factorization"),
        " の約束）。このとき、",
        math(String.raw`j\in\mathbb{N}`),
        " が ",
        math(String.raw`n\le j`),
        " を満たすならば",
      ]),
      displayMath(String.raw`\mathrm{ac}_{j}(g)=0`),
      paragraph([
        "が成り立つ。",
        ref("claim_qbar_factor_theorem"),
        " が商を構成するときに使った根の条件 ",
        math(String.raw`\mathrm{aev}_{w}(f)=0`),
        " は、この主張では使わない（商の係数がどこで尽きるかは、",
        math(String.raw`w`),
        " が根であるかによらない）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の係数はすべて ",
        ref("def_qbar_polynomial_ring"),
        " の ",
        math(String.raw`\mathrm{ac}_{j}`),
        " であり、値の計算はすべて ",
        math(String.raw`\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）の中で行う。",
        math(String.raw`n\le j`),
        " を満たす ",
        math(String.raw`j\in\mathbb{N}`),
        " を任意に取る。",
        math(String.raw`0\le k\le n`),
        " を満たす各 ",
        math(String.raw`k`),
        " について ",
        math(String.raw`k\le n\le j`),
        " すなわち ",
        math(String.raw`k\le j`),
        " が従うことを、鎖の中で使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_{j}(g)
&=\mathrm{ac}_{j}\Bigl(\sum_{k=0}^{n}\widehat{\mathrm{ac}_k(f)}\,K_k(w)\Bigr)
&&(\because\ g\ \text{の定め方})\\
&=\sum_{k=0}^{n}\mathrm{ac}_{j}\bigl(\widehat{\mathrm{ac}_k(f)}\,K_k(w)\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数。有限和へ繰り返し当てる})\\
&=\sum_{k=0}^{n}\ \sum_{i=0}^{j}\mathrm{ac}_{i}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j-i}\bigl(K_k(w)\bigr)
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の積の係数。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\Bigl(\mathrm{ac}_{0}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j}\bigl(K_k(w)\bigr)
+\sum_{i=1}^{j}\mathrm{ac}_{i}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j-i}\bigl(K_k(w)\bigr)\Bigr)
&&(\because\ \text{有限和から}\ i=0\ \text{の項を分ける。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\Bigl(\mathrm{ac}_{0}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j}\bigl(K_k(w)\bigr)
+\sum_{i=1}^{j}0\cdot\mathrm{ac}_{j-i}\bigl(K_k(w)\bigr)\Bigr)
&&(\because\ 1\le i\ \text{の各項では}\ \blkref{def_qbar_constant_embedding}\ \text{の正次数の係数が零。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\Bigl(\mathrm{ac}_{0}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j}\bigl(K_k(w)\bigr)
+\sum_{i=1}^{j}0\Bigr)
&&(\because\ \text{零を掛けると零。各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\mathrm{ac}_{0}\bigl(\widehat{\mathrm{ac}_k(f)}\bigr)\cdot\mathrm{ac}_{j}\bigl(K_k(w)\bigr)
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元。有限和の各項へ繰り返し当てる})\\
&=\sum_{k=0}^{n}\mathrm{ac}_k(f)\cdot\mathrm{ac}_{j}\bigl(K_k(w)\bigr)
&&(\because\ \blkref{def_qbar_constant_embedding}\ \text{の}\ \mathrm{ac}_{0}(\widehat{a})=a\ \text{を各項へ同時に当てる})\\
&=\sum_{k=0}^{n}\mathrm{ac}_k(f)\cdot 0
&&(\because\ \text{各項で}\ k\le j\ \text{なので}\ \blkref{claim_qbar_pow_diff_sum_coeff_bound}\ \text{を各項へ同時に当てる})\\
&=\sum_{k=0}^{n}0
&&(\because\ \text{零を掛けると零。各項へ同時に当てる})\\
&=0
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元。有限和へ繰り返し当てる})
\end{aligned}`),
      paragraph([
        "終点は主張の右辺である。この主張は、零でない多項式の相異なる根の個数を次数で抑える帰納法の一歩で、",
        "商の係数の上界を 1 つ下げるために使う。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_factor_quotient_other_root_zero",
    kind: "claim",
    title: { text: "一次因子を取り除いた商は、もとの根と相異なる根で零になる" },
    labels: ["claim_qbar_factor_quotient_other_root_zero"],
    habitat: "Qbar",
    verification: ["sagemath/check/qbar-factor-quotient-other-root-zero"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorQuotientOtherRootZero",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.factor_quotient_other_root_zero_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarFactorQuotientOtherRootZero_from_necSuf",
    ],
    statement: [
      paragraph([
        ref("def_qbar_polynomial_ring"),
        " の元 ",
        math(String.raw`f,g\in\overline{\mathbb{Q}}[t]`),
        " と ",
        math(String.raw`w,w'\in\overline{\mathbb{Q}}`),
        "（",
        ref("def_algebraic_numbers"),
        "）を任意に取る。",
        math(String.raw`f=(t-\widehat{w})g`),
        "、",
        math(String.raw`\mathrm{aev}_{w'}(f)=0`),
        "、",
        math(String.raw`w'\ne w`),
        " が成り立つならば",
      ]),
      displayMath(String.raw`\mathrm{aev}_{w'}(g)=0`),
      paragraph([
        "が成り立つ。特に、",
        ref("claim_qbar_factor_theorem"),
        " で根 ",
        math(String.raw`w`),
        " に対応する一次因子を取り除いた商は、",
        math(String.raw`w`),
        " と相異なる根 ",
        math(String.raw`w'`),
        " を根として保つ。",
      ]),
    ],
    proof: [
      paragraph([
        "以下の計算はすべて ",
        math(String.raw`\overline{\mathbb{Q}}`),
        " の中で行う。まず、仮定と ",
        ref("def_qbar_poly_evaluation"),
        " の和・加法の逆元・積を保つ性質から",
      ]),
      displayMath(String.raw`\begin{aligned}
0
&=\mathrm{aev}_{w'}(f)
&&(\because\ \mathrm{aev}_{w'}(f)=0)\\
&=\mathrm{aev}_{w'}\bigl((t-\widehat{w})g\bigr)
&&(\because\ f=(t-\widehat{w})g)\\
&=\mathrm{aev}_{w'}(t-\widehat{w})\,\mathrm{aev}_{w'}(g)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より値を取る写像は積を保つ})\\
&=\bigl(\mathrm{aev}_{w'}(t)-\mathrm{aev}_{w'}(\widehat{w})\bigr)\,\mathrm{aev}_{w'}(g)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{より値を取る写像は和と加法の逆元を保つ})\\
&=(w'-w)\,\mathrm{aev}_{w'}(g)
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{の}\ \mathrm{aev}_{w'}(t)=w'\ \text{と}\ \mathrm{aev}_{w'}(\widehat{w})=w)
\end{aligned}`),
      paragraph([
        "次に ",
        math(String.raw`w'-w\ne0`),
        " を確かめる。もし ",
        math(String.raw`w'-w=0`),
        " ならば",
      ]),
      displayMath(String.raw`\begin{aligned}
w'
&=(w'-w)+w
&&(\because\ \overline{\mathbb{Q}}\ \text{の加法と加法の逆元})\\
&=0+w
&&(\because\ w'-w=0)\\
&=w
&&(\because\ 0\ \text{は}\ \overline{\mathbb{Q}}\ \text{の加法の単位元})
\end{aligned}`),
      paragraph([
        "となり、仮定 ",
        math(String.raw`w'\ne w`),
        " に反する。したがって ",
        math(String.raw`w'-w\ne0`),
        " である。上の鎖を左右逆に読めば ",
        math(String.raw`(w'-w)\,\mathrm{aev}_{w'}(g)=0`),
        " であるから、",
        ref("claim_qbar_no_zero_divisors"),
        " を ",
        math(String.raw`a=w'-w`),
        "、",
        math(String.raw`b=\mathrm{aev}_{w'}(g)`),
        " として当てると ",
        math(String.raw`\mathrm{aev}_{w'}(g)=0`),
        " を得る。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_qbar_distinct_roots_card_bound",
    kind: "claim",
    title: { text: "零でない多項式の相異なる根は係数の上界を超えない" },
    labels: ["claim_qbar_distinct_roots_card_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/qbar-distinct-roots-card-bound"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.qbarDistinctRootsCardLe",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.distinct_roots_card_le_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.qbarDistinctRootsCardLe_from_necSuf",
    ],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`), "、", math(String.raw`f\in\overline{\mathbb{Q}}[t]`),
        "、有限集合 ", math(String.raw`s\subset\overline{\mathbb{Q}}`), " が次を満たすとする。",
      ]),
      list([
        [math(String.raw`f\ne0`), " である。"],
        [math(String.raw`n<k`), " ならば ", math(String.raw`\mathrm{ac}_k(f)=0`), " である。"],
        [math(String.raw`w\in s`), " ならば ", math(String.raw`\mathrm{aev}_{w}(f)=0`), " である。"],
      ]),
      paragraph(["このとき ", math(String.raw`\lvert s\rvert\le n`), " である。有限集合なので、その元は初めから相異なる。"]),
    ],
    proof: [
      paragraph([math(String.raw`n`), " について帰納法で示す。"]),
      paragraph(["出発点として ", math(String.raw`n=0`), " とする。もし ", math(String.raw`s\ne\varnothing`),
        " ならば ", math(String.raw`w\in s`), " を 1 つ取れる。", ref("claim_qbar_factor_theorem"), " より、"]),
      displayMath(String.raw`g:=\widehat{\mathrm{ac}_0(f)}K_0(w)\in\overline{\mathbb{Q}}[t]`),
      paragraph(["と置くと ", math(String.raw`f=(t-\widehat w)g`), " である。一方、", ref("claim_qbar_factor_quotient_coeff_bound"),
        " を任意の ", math(String.raw`j\in\mathbb{N}`), " に当てると ", math(String.raw`\mathrm{ac}_j(g)=0`),
        " である。すべての係数が零である 2 つの多項式は等しいので ", math(String.raw`g=0`), " であり、"]),
      displayMath(String.raw`\begin{aligned}
f
&=(t-\widehat w)g \quad(\because\ \blkref{claim_qbar_factor_theorem})\\
&=(t-\widehat w)0 \quad(\because\ g=0)\\
&=0 \quad(\because\ \text{零元との積})
\end{aligned}`),
      paragraph(["となって ", math(String.raw`f\ne0`), " に反する。したがって ", math(String.raw`s=\varnothing`),
        " であり、", math(String.raw`\lvert s\rvert=0`), " である。"]),
      paragraph(["次に、ある ", math(String.raw`n\in\mathbb{N}`), " で主張が成り立つと仮定し、係数の上界を ",
        math(String.raw`n+1`), " とする。", math(String.raw`s=\varnothing`), " なら結論は直ちに成り立つので、",
        math(String.raw`s\ne\varnothing`), " とし、", math(String.raw`w\in s`), " を 1 つ取る。"]),
      displayMath(String.raw`g:=\sum_{k=0}^{n+1}\widehat{\mathrm{ac}_k(f)}K_k(w)\in\overline{\mathbb{Q}}[t]`),
      paragraph(["と置く。", ref("claim_qbar_factor_theorem"), " より ", math(String.raw`f=(t-\widehat w)g`),
        " である。もし ", math(String.raw`g=0`), " なら上と同じ 3 段の鎖で ", math(String.raw`f=0`),
        " となるので、", math(String.raw`g\ne0`), " である。", ref("claim_qbar_factor_quotient_coeff_bound"),
        " より ", math(String.raw`n<j`), " ならば ", math(String.raw`\mathrm{ac}_j(g)=0`), " である。また、",
        math(String.raw`w'\in s\setminus\{w\}`), " ならば ", math(String.raw`w'\ne w`), " であり、",
        ref("claim_qbar_factor_quotient_other_root_zero"), " より ", math(String.raw`\mathrm{aev}_{w'}(g)=0`), " である。"]),
      paragraph(["したがって帰納法の仮定を ", math(String.raw`g`), " と ", math(String.raw`s\setminus\{w\}`),
        " に当てることができ、"]),
      displayMath(String.raw`\lvert s\setminus\{w\}\rvert\le n`),
      paragraph(["を得る。", math(String.raw`w\in s`), " なので、"]),
      displayMath(String.raw`\begin{aligned}
\lvert s\rvert
&=\lvert s\setminus\{w\}\rvert+1 \quad(\because\ w\in s)\\
&\le n+1 \quad(\because\ \text{帰納法の仮定})
\end{aligned}`),
      paragraph(["である。これで帰納法が閉じた。この議論に実数体も複素数体も現れず、代数的数と有限集合の中で閉じている。"]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_subset_card_bound",
    kind: "claim",
    title: { text: "1 の冪根の全体の有限部分集合の元の個数は指数を超えない" },
    labels: ["claim_root_of_unity_subset_card_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/root-of-unity-subset-card-bound"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnitySubsetCardLe",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.root_of_unity_subset_card_le_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnitySubsetCardLe_from_necSuf",
    ],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`), " が ", math(String.raw`n\ge1`),
        " を満たすとし、有限集合 ", math(String.raw`s\subset\overline{\mathbb{Q}}`),
        " が「", math(String.raw`w\in s`), " ならば ", math(String.raw`w\in\mu_{n}`),
        "」を満たすとする（", math(String.raw`\mu_{n}`), " は ", ref("def_root_of_unity_set"),
        "）。このとき ", math(String.raw`\lvert s\rvert\le n`), " である。",
      ]),
      paragraph([
        "仮定 ", math(String.raw`n\ge1`), " は外せない。",
        math(String.raw`n=0`), " のときは ", math(String.raw`\mu_{0}=\overline{\mathbb{Q}}`),
        "（", ref("def_root_of_unity_set"), "）なので、1 つの元だけからなる有限部分集合が反例になる。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、", ref("def_qbar_polynomial_ring"), " の元",
      ]),
      displayMath(String.raw`f:=t^{\,n}+\widehat{-1}\ \in\overline{\mathbb{Q}}[t]`),
      paragraph([
        "を置く（", math(String.raw`t^{\,n}`), " は ", ref("def_qbar_polynomial_ring"),
        " の冪の約束、", math(String.raw`\widehat{-1}`), " は ", math(String.raw`\overline{\mathbb{Q}}`),
        " の元 ", math(String.raw`-1`), " を ", ref("def_qbar_constant_embedding"),
        " で定数として送ったものである）。",
        ref("claim_qbar_distinct_roots_card_bound"),
        " を ", math(String.raw`f`), "、", math(String.raw`s`), "、", math(String.raw`n`),
        " に当てるために、その 3 つの仮定を順に確かめる。",
      ]),
      paragraph(["第 1 に ", math(String.raw`f\ne0`), " である。番号 0 の係数を計算すると、"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_0(f)
&=\mathrm{ac}_0(t^{\,n})+\mathrm{ac}_0(\widehat{-1})
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数})\\
&=0+\mathrm{ac}_0(\widehat{-1})
&&(\because\ \blkref{claim_qbar_poly_indeterminate_power_coefficient}\text{。}\ n\ge1\ \text{より}\ 0\ne n)\\
&=0+(-1)
&&(\because\ \blkref{def_qbar_constant_embedding})\\
&=-1
&&(\because\ \text{零元との和})
\end{aligned}`),
      paragraph([
        "であり、体 ", math(String.raw`\overline{\mathbb{Q}}`), " では ",
        math(String.raw`-1\ne0`), " である（もし ", math(String.raw`-1=0`),
        " なら両辺に 1 を足して ", math(String.raw`0=1`),
        " となり、", ref("def_algebraic_numbers"), " の体であることに反する）。",
        "零元はすべての係数が零の族なので（", ref("def_qbar_polynomial_ring"), "）、",
        math(String.raw`f\ne0`), " である。",
      ]),
      paragraph([
        "第 2 に、", math(String.raw`k\in\mathbb{N}`), " が ", math(String.raw`n<k`),
        " を満たすとき ", math(String.raw`\mathrm{ac}_k(f)=0`), " である。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ac}_k(f)
&=\mathrm{ac}_k(t^{\,n})+\mathrm{ac}_k(\widehat{-1})
&&(\because\ \blkref{def_qbar_polynomial_ring}\ \text{の和の係数})\\
&=0+\mathrm{ac}_k(\widehat{-1})
&&(\because\ \blkref{claim_qbar_poly_indeterminate_power_coefficient}\text{。}\ n<k\ \text{より}\ k\ne n)\\
&=0+0
&&(\because\ \blkref{def_qbar_constant_embedding}\text{。}\ n<k\ \text{と}\ n\ge1\ \text{より}\ k\ge1)\\
&=0
&&(\because\ \text{零元との和})
\end{aligned}`),
      paragraph([
        "第 3 に、", math(String.raw`w\in s`), " ならば ",
        math(String.raw`\mathrm{aev}_{w}(f)=0`), " である。仮定より ",
        math(String.raw`w\in\mu_{n}`), "、すなわち ", math(String.raw`w^{\,n}=1`),
        " なので（", ref("def_root_of_unity_set"), "）、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{aev}_{w}(f)
&=\mathrm{aev}_{w}(t^{\,n})+\mathrm{aev}_{w}(\widehat{-1})
&&(\because\ \blkref{def_qbar_poly_evaluation}\ \text{は和を保つ})\\
&=w^{\,n}+\mathrm{aev}_{w}(\widehat{-1})
&&(\because\ \blkref{claim_qbar_evaluation_indeterminate_pow})\\
&=w^{\,n}+(-1)
&&(\because\ \blkref{def_qbar_poly_evaluation}\text{。}\ \mathrm{aev}_{w}(\widehat{a})=a)\\
&=1+(-1)
&&(\because\ w^{\,n}=1)\\
&=0
&&(\because\ \text{加法の逆元})
\end{aligned}`),
      paragraph([
        "である。以上の 3 つにより ", ref("claim_qbar_distinct_roots_card_bound"),
        " を ", math(String.raw`f`), "、", math(String.raw`s`), "、", math(String.raw`n`),
        " に当てることができ、", math(String.raw`\lvert s\rvert\le n`),
        " を得る。この議論に実数体も複素数体も現れず、代数的数と有限集合の中で閉じている。",
      ]),
    ],
  },

  {
    id: "algebraic_eigenvalue_claim_root_of_unity_finite_card_bound",
    kind: "claim",
    title: { text: "1 の冪根の全体は有限であり元の個数は指数を超えない" },
    labels: ["claim_root_of_unity_finite_card_bound"],
    habitat: "Qbar",
    verification: ["sagemath/check/root-of-unity-finite-card-bound"],
    lean: [
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnityFiniteCardLe",
      "Ising2DLambda.NecSuf.AlgebraicEigenvalue.finite_ncard_le_of_finset_card_le_necSuf",
      "Ising2DLambda.AlgebraicEigenvalue.rootOfUnityFiniteCardLe_from_necSuf",
    ],
    statement: [
      paragraph([
        math(String.raw`n\in\mathbb{N}`), " が ", math(String.raw`n\ge1`),
        " を満たすとする。このとき ", math(String.raw`\mu_n`), "（",
        ref("def_root_of_unity_set"), "）は有限集合であり、",
        math(String.raw`\lvert\mu_n\rvert\le n`), " である。",
      ]),
    ],
    proof: [
      paragraph([
        "まず有限性を背理法で示す。", math(String.raw`\mu_n`), " が無限集合であると仮定する。",
        "無限集合から任意の有限個数の相異なる元を取れるので、",
        math(String.raw`\mu_n`), " の有限部分集合 ", math(String.raw`s`), " で",
      ]),
      displayMath(String.raw`\lvert s\rvert=n+1`),
      paragraph([
        "を満たすものがある。一方、", ref("claim_root_of_unity_subset_card_bound"),
        " をこの ", math(String.raw`s`), " に当てると ", math(String.raw`\lvert s\rvert\le n`),
        " である。したがって",
      ]),
      displayMath(String.raw`\begin{aligned}
n+1
&=\lvert s\rvert
&& (\because\ \lvert s\rvert=n+1)\\
&\le n
&& (\because\ \blkref{claim_root_of_unity_subset_card_bound})
\end{aligned}`),
      paragraph([
        "となるが、自然数について ", math(String.raw`n<n+1`), " なので矛盾する。ゆえに ",
        math(String.raw`\mu_n`), " は有限集合である。",
      ]),
      paragraph([
        "有限集合になった ", math(String.raw`\mu_n`), " 自身を有限部分集合として ",
        ref("claim_root_of_unity_subset_card_bound"), " に当てると、",
      ]),
      displayMath(String.raw`\lvert\mu_n\rvert\le n`),
      paragraph([
        "を得る。この議論に実数体も複素数体も現れず、代数的数の集合と自然数の大小だけで閉じている。",
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
          "）、軌道を保つ置換の符号が軌道ごとの符号の積であること（",
          ref("claim_permutation_sign_orbit_product"),
          "）、シフト行列の特性多項式が軌道ごとの和の積であること（",
          ref("claim_shift_char_orbit_product"),
          "）、および各軌道の和の値（",
          ref("claim_orbit_sum_two_terms"),
          "）、倍数を指数とする冪と単位元の逆元との和の分解（",
          ref("claim_power_sum_telescope"),
          "）、および各軌道の和が ",
          math(String.raw`t^{L}+\iota(-\kappa(1))`),
          " を割ること（",
          ref("claim_orbit_sum_divides_pow_L"),
          "）、および軌道の集合にわたる 2 つの有限積の積が共通の値の個数を指数とする冪であること（",
          ref("claim_prod_pair_eq_pow_card"),
          "）、および ",
          math(String.raw`\chi_U`),
          " が ",
          math(String.raw`t^{L}+\iota(-\kappa(1))`),
          " の冪を割ること（",
          ref("claim_shift_char_dvd_pow_L"),
          "）、および ",
          math(String.raw`\chi_U`),
          " が軌道ごとの因子の積として明示的に書けること（",
          ref("claim_shift_char_orbit_factorization"),
          "）、および代数的数の全体（",
          ref("def_algebraic_numbers"),
          "）と 1 の冪根の全体（",
          ref("def_root_of_unity_set"),
          "）を置いて、約数を指数として 1 になる代数的数がその倍数を指数としても 1 になること（",
          ref("claim_root_of_unity_divisor"),
          "）、および ",
          math(String.raw`\mathbb{Z}[x][t]`),
          " の元を代数的数で評価する写像（",
          ref("def_second_evaluation"),
          "）を置いて、軌道ごとの因子の値を 0 にする代数的数が 1 の ",
          math(String.raw`\lvert O\rvert`),
          " 乗根であること（",
          ref("claim_orbit_factor_root"),
          "）、および代数的数における値を取る写像が有限積を有限積へ写すこと（",
          ref("claim_second_evaluation_prod"),
          "）、および代数的数の有限積が 0 ならば 0 である因子があること（",
          ref("claim_qbar_prod_eq_zero"),
          "）、およびシフト行列の特性多項式の値を 0 にする代数的数が 1 の ",
          math(String.raw`L`),
          " 乗根であること（",
          ref("claim_shift_char_root_of_unity"),
          "）、および代数的数を成分とする行列と列ベクトル（",
          ref("def_qbar_matrix"),
          "、",
          ref("def_qbar_vector"),
          "）を置いて、行列の積の作用が作用を 2 度施したものであること（",
          ref("claim_qbar_action_product"),
          "）、および列ベクトルの和とスカラー倍（",
          ref("def_qbar_vector_add"),
          "、",
          ref("def_qbar_vector_smul"),
          "）を置いて、作用がその 2 つを保つこと（",
          ref("claim_qbar_action_add"),
          "、",
          ref("claim_qbar_action_smul"),
          "）、および零ベクトル・固有ベクトル・固有値・固有空間（",
          ref("def_qbar_zero_vector"),
          "、",
          ref("def_qbar_eigenvector"),
          "、",
          ref("def_qbar_eigenvalue"),
          "、",
          ref("def_qbar_eigenspace"),
          "）を置いて、固有空間が和とスカラー倍で閉じること（",
          ref("claim_qbar_eigenspace_add"),
          "、",
          ref("claim_qbar_eigenspace_smul"),
          "）、および代数的数を成分とする単位行列（",
          ref("def_qbar_identity_matrix"),
          "）を置いて、その作用が列ベクトルを動かさないこと（",
          ref("claim_qbar_identity_action"),
          "）、および代数的数を成分とする行列の冪と作用の反復（",
          ref("def_qbar_matrix_power"),
          "、",
          ref("def_qbar_action_iterate"),
          "）を置いて、行列の冪の作用が作用を反復したものであること（",
          ref("claim_qbar_action_pow"),
          "）、および固有ベクトルへ行列の冪を作用させると固有値の冪のスカラー倍になること（",
          ref("claim_qbar_eigenvector_pow"),
          "）、および整係数多項式を成分とする行列を代数的数で評価する写像（",
          ref("def_qbar_matrix_eval"),
          "）を置いて、それが行列の積を保つこと（",
          ref("claim_qbar_matrix_eval_product"),
          "）、およびそれが単位行列を単位行列へ写すこと（",
          ref("claim_qbar_matrix_eval_identity"),
          "）、および代数的数を成分とする行列の積が結合的であること（",
          ref("claim_qbar_matrix_product_assoc"),
          "）、および単位行列が積の単位元であること（",
          ref("claim_qbar_identity_matrix_unit"),
          "）、および冪が右から掛けても得られること（",
          ref("claim_qbar_matrix_pow_succ_right"),
          "）、および成分ごとの評価が行列の冪を保つこと（",
          ref("claim_qbar_matrix_eval_pow"),
          "）、および零でない列ベクトルのスカラー倍が零ベクトルならばスカラーが 0 であること（",
          ref("claim_qbar_smul_eq_zero"),
          "）、およびシフト行列の固有値が 1 の ",
          math(String.raw`L`),
          " 乗根であること（",
          ref("claim_shift_matrix_eigenvalue_root_of_unity"),
          "）、および可換な行列が固有空間を保つこと（",
          ref("claim_qbar_commuting_preserves_eigenspace"),
          "）、および評価で運んだシフト行列と転送行列が可換であること（",
          ref("claim_qbar_shift_transfer_commute"),
          "）、および転送行列がシフト行列の各固有空間をそれ自身へ写すこと（",
          ref("claim_qbar_transfer_preserves_shift_eigenspace"),
          "）、および列ベクトルの有限和（",
          ref("def_qbar_vector_sum"),
          "）を置いて、行列の作用がそれを保つこと（",
          ref("claim_qbar_action_sum"),
          "）、およびスカラー倍が列ベクトルの有限和を保つこと（",
          ref("claim_qbar_smul_sum"),
          "）、および列ベクトルを固有空間へ落とす写像（",
          ref("def_qbar_projector"),
          "）を置いて、それへの行列の作用が冪の指数を 1 つ進めること（",
          ref("claim_qbar_projector_action"),
          "）、および ",
          math(String.raw`A^{L}=I^{\overline{\mathbb{Q}}}_L`),
          " と ",
          math(String.raw`z^{L}=1`),
          " のもとで ",
          math(String.raw`P_{A,z}(v)`),
          " の像が固有空間に入ること（",
          ref("claim_qbar_projector_image_eigenspace"),
          "）、および代数的数の積の冪が冪の積であること（",
          ref("claim_qbar_mul_pow"),
          "）、および 1 の冪根の全体が積で閉じていること（",
          ref("claim_root_of_unity_mul"),
          "）、および 1 の冪根の冪が 1 の冪根であること（",
          ref("claim_root_of_unity_pow"),
          "）、および 1 の冪根を掛ける写像（",
          ref("def_root_of_unity_mul_map"),
          "）が全単射であること（",
          ref("claim_root_of_unity_mul_map_bijective"),
          "）、および 1 の冪根の全体にわたる冪の和が 1 の冪根の冪を掛けても動かないこと（",
          ref("claim_root_of_unity_power_sum_invariant"),
          "）、および代数的数の冪の有限和が 1 を引いたものを掛けると伸縮すること（",
          ref("claim_qbar_geometric_telescope"),
          "）、および代数的数の積が零元ならば零元でない方で割って他方が零元と分かること（",
          ref("claim_qbar_no_zero_divisors"),
          "）、および 1 でない 1 の冪根の冪の有限和が零元であること（",
          ref("claim_root_of_unity_geometric_sum_zero"),
          "）、および根を持つ多項式が一次式を因子に持つこと（",
          ref("claim_qbar_factor_theorem"),
          "）、および冪の差の因数分解の商と因数定理の商について係数が尽きる位置を抑えること（",
          ref("claim_qbar_pow_diff_sum_coeff_bound"),
          "、",
          ref("claim_qbar_factor_quotient_coeff_bound"),
          "）、および一次因子を取り除いた商が、もとの根と相異なる根で零になること（",
          ref("claim_qbar_factor_quotient_other_root_zero"),
          "）、および零でない多項式の相異なる根が係数の上界を超えないこと（",
          ref("claim_qbar_distinct_roots_card_bound"),
          "）、および 1 の冪根の全体の有限部分集合の元の個数が指数を超えないこと（",
          ref("claim_root_of_unity_subset_card_bound"),
          "）までは上で済んでいる。",
          "および ",
          math(String.raw`\mu_n`),
          " 自身が有限集合で元の個数が ",
          math(String.raw`n`),
          " 以下であること（",
          ref("claim_root_of_unity_finite_card_bound"),
          "）までは上で済んでいる。次に書くのは、因数定理の商の根における値が零でないこと（単根性）、",
          math(String.raw`t^{\,n}+\widehat{-1}`),
          " が ",
          math(String.raw`n`),
          " 個の相異なる根を持つこと（下界）、それらを合わせて ",
          math(String.raw`\mu_n`),
          " がちょうど ",
          math(String.raw`n`),
          " 個の元を持つこと（有限性の仮定を外すため）と、そこから出る ",
          math(String.raw`\mu_L`),
          " の元の冪の総和（指数が ",
          math(String.raw`L`),
          " の倍数なら元の個数、そうでなければ 0）、",
          "そして最後に、シフト行列の固有空間たちが列ベクトルの全体を張ることを組み立てる。",
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
