/**
 * 本文（章は見出しブロックで区切る）。
 *
 * 章「分配多項式」: 有限格子の分配関数を、指数関数を経由せず整係数多項式として定義する。
 * 章「有限系の自由エントロピー」: 有理点での値の素因数分解として Φ_L(q) ∈ Λ を定める。
 * 章「転送行列」: 行配位を定め、破れボンド数を行内・行間へ分解し、転送行列 T を定義して、
 * 配位の重みが行に沿った成分の積であること・行列の冪の成分が道に沿った積の和であることを示す
 * （Z_L = Tr(T^L) そのものは未着手）。
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
    title: { text: "格子と配位" },
    labels: ["def_lattice", "def_configuration"],
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
        math(String.raw`\partial_0,\partial_1`),
        " を定めるために、番号を行と列へ分解する。除法の原理により、",
        math(String.raw`0\le k\le L^2-1`),
        " を満たす整数 ",
        math(String.raw`k`),
        " は",
      ]),
      displayMath(String.raw`k=iL+j,\qquad i,j\in\{0,1,\dots,L-1\}`),
      paragraph([
        "の形にただ一通りに書ける（",
        math(String.raw`k`),
        " を ",
        math(String.raw`L`),
        " で割った商が ",
        math(String.raw`i`),
        "、余りが ",
        math(String.raw`j`),
        "）。この分解を用いて、",
        math(String.raw`e\in E_{L,\mathrm{h}}`),
        " に対しては ",
        math(String.raw`e-1=iL+j`),
        " として",
      ]),
      displayMath(String.raw`\partial_0(e):=(i,j),\qquad \partial_1(e):=(i,\,j+1)`),
      paragraph([
        "と定め（行番号は変えず列番号だけを 1 進める。だから横向きである）、",
        math(String.raw`e\in E_{L,\mathrm{v}}`),
        " に対しては ",
        math(String.raw`e-L^2-1=iL+j`),
        " として",
      ]),
      displayMath(String.raw`\partial_0(e):=(i,j),\qquad \partial_1(e):=(i+1,\,j)`),
      paragraph([
        "と定める（どちらの場合も分解される整数は ",
        math(String.raw`0`),
        " 以上 ",
        math(String.raw`L^2-1`),
        " 以下なので、上の分解が使える）。ここで ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の元は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の元とみなし（各剰余類はこの範囲にちょうど 1 つの代表を持つ）、",
        math(String.raw`i+1`),
        " と ",
        math(String.raw`j+1`),
        " の加法は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中で行う。すなわち周期境界条件である。",
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
        " が存在したとする。",
        math(String.raw`A_{L,m}`),
        " の定義より ",
        math(String.raw`b(\sigma)=m`),
        "、",
        math(String.raw`A_{L,m'}`),
        " の定義より ",
        math(String.raw`b(\sigma)=m'`),
        " である。",
        ref("def_broken_bond_count"),
        " の ",
        math(String.raw`b`),
        " は写像であり、1 つの ",
        math(String.raw`\sigma`),
        " に対する値は 1 つなので ",
        math(String.raw`m=b(\sigma)=m'`),
        " となり、",
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
&&(\because\ \text{分配多項式の定義})\\
&=\sum_{m=0}^{2L^2}\ \sum_{\sigma\in A_{L,m}}x^{\,b(\sigma)}
&&(\because\ \text{配位全体は破れボンド数の値ごとに類別される})\\
&=\sum_{m=0}^{2L^2}\ \sum_{\sigma\in A_{L,m}}x^{\,m}
&&(\because\ \sigma\in A_{L,m}\ \Rightarrow\ b(\sigma)=m)\\
&=\sum_{m=0}^{2L^2}|A_{L,m}|\cdot x^{\,m}
&&(\because\ \text{同じ元を }|A_{L,m}|\text{ 個足した})\\
&=\sum_{m=0}^{2L^2}\Omega_L(m)\,x^{\,m}
&&(\because\ \text{多重度の定義})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_partition_polynomial"),
        "、",
        ref("claim_configuration_partition"),
        "、",
        ref("def_multiplicity"),
        "。",
      ]),
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
&&(\because\ \text{多重度の定義})\\
&=|\Sigma_L|
&&(\because\ \text{配位全体は破れボンド数の値ごとに類別される})\\
&=2^{L^2}
&&(\because\ \text{配位の定義})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_multiplicity"),
        "、",
        ref("claim_configuration_partition"),
        "、",
        ref("def_configuration"),
        "。",
      ]),
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
&&(\because\ \text{素因数分解の指数の加法性})\\
&=v_p(a'b)
&&(\because\ ab'=a'b)\\
&=v_p(a')+v_p(b)
&&(\because\ \text{素因数分解の指数の加法性})
\end{aligned}`),
      paragraph([
        "であり、両辺から ",
        math(String.raw`v_p(b)+v_p(b')`),
        " を引いて ",
        math(String.raw`v_p(a)-v_p(b)=v_p(a')-v_p(b')`),
        " を得る。",
      ]),
      paragraph([
        "引いたブロック: ",
        ref("def_prime_exponent"),
        "。",
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
&&(\because\ \text{分配多項式の定義})\\
&=\sum_{\sigma\in\Sigma_L}q^{\,b(\sigma)}
&&(\because\ \text{代入は環準同型なので和と積を保つ})\\
&\in\mathbb{Q}_{>0}
&&(\because\ \text{正の有理数を 1 個以上足したものは正})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_partition_polynomial"),
        "、",
        ref("def_configuration"),
        "、",
        ref("def_broken_bond_count"),
        "。",
      ]),
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
&&(\because\ \text{正の有理数の対数の定義})\\
&=w_p\Bigl(\frac{a_1a_2}{b_1b_2}\Bigr)
&&(\because\ \text{有理数の積の定義})\\
&=v_p(a_1a_2)-v_p(b_1b_2)
&&(\because\ \text{正の有理数の対数の定義、有理数の指数は表示によらない})\\
&=\bigl(v_p(a_1)+v_p(a_2)\bigr)-\bigl(v_p(b_1)+v_p(b_2)\bigr)
&&(\because\ \text{素因数分解の指数の加法性})\\
&=\bigl(v_p(a_1)-v_p(b_1)\bigr)+\bigl(v_p(a_2)-v_p(b_2)\bigr)
&&(\because\ \mathbb{Z}\ \text{の加法の可換性と結合性})\\
&=w_p(q_1)+w_p(q_2)
&&(\because\ \text{正の有理数の対数の定義})\\
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
        "引いたブロック: ",
        ref("def_rational_log"),
        "、",
        ref("claim_rational_exponent_well_defined"),
        "、",
        ref("def_prime_exponent"),
        "、",
        ref("def_log_order_group"),
        "。",
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
&&(\because\ \text{正の有理数の対数の定義})\\
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
&&(\because\ \text{対数の加法性、}q^{\,k},q\in\mathbb{Q}_{>0})\\
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
      paragraph([
        "引いたブロック: ",
        ref("claim_log_additive"),
        "、",
        ref("def_log_order_group"),
        "、",
        ref("def_rational_log"),
        "、",
        ref("def_prime_exponent"),
        "。",
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
&&(\because\ \text{有限系の自由エントロピーの定義、}1\in\mathbb{Q}_{>0})\\
&=\log\Bigl(\sum_{m=0}^{2L^2}\Omega_L(m)\cdot1^{\,m}\Bigr)
&&(\because\ \text{分配多項式の係数は多重度である、代入は環準同型})\\
&=\log\Bigl(\sum_{m=0}^{2L^2}\Omega_L(m)\Bigr)
&&(\because\ 1^{\,m}=1)\\
&=\log\bigl(2^{L^2}\bigr)
&&(\because\ \text{多重度の総和は配位の総数に等しい})\\
&=L^2\,\log 2
&&(\because\ \text{対数の冪の法則、}2\in\mathbb{Q}_{>0},\ L^2\in\mathbb{N})\\
&=L^2\sum_{p:\ w_p(2)\ne0}w_p(2)\,\ell_p
&&(\because\ \text{正の有理数の対数の定義})\\
&=L^2\sum_{p:\ v_p(2)\ne0}v_p(2)\,\ell_p
&&(\because\ w_p(2)=v_p(2)-v_p(1),\ v_p(1)=0)\\
&=L^2\,\ell_2
&&(\because\ 2\text{ は素数なので }v_2(2)=1,\ p\ne2\ \Rightarrow\ v_p(2)=0)
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_finite_free_entropy"),
        "、",
        ref("claim_value_at_rational_is_positive"),
        "、",
        ref("claim_coefficient_representation"),
        "、",
        ref("claim_coefficient_sum"),
        "、",
        ref("claim_log_power"),
        "、",
        ref("def_rational_log"),
        "、",
        ref("def_prime_exponent"),
        "、",
        ref("def_log_order_group"),
        "。",
      ]),
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
        String.raw`b_{\mathrm{h}}(\tau):=\bigl|\bigl\{\,j\in\mathbb{Z}/L\mathbb{Z} \;\bigm|\; \tau(j)\ne\tau(j+1)\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`j+1`),
        " の加法は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中で行う）。また 2 つの行配位 ",
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
        "各整数 ",
        math(String.raw`i\in\{0,1,\dots,L-1\}`),
        " に対し、辺の番号の集合",
      ]),
      displayMath(
        String.raw`E_{L,\mathrm{h},i}:=\bigl\{\,iL+j+1 \;\bigm|\; j\in\{0,1,\dots,L-1\}\,\bigr\},\qquad
E_{L,\mathrm{v},i}:=\bigl\{\,L^2+iL+j+1 \;\bigm|\; j\in\{0,1,\dots,L-1\}\,\bigr\}`,
      ),
      paragraph(["を定める。このとき次の 5 つが成り立つ。"]),
      list([
        [
          "各 ",
          math(String.raw`i`),
          " について、写像 ",
          math(String.raw`j\mapsto iL+j+1`),
          " は ",
          math(String.raw`\{0,1,\dots,L-1\}`),
          " から ",
          math(String.raw`E_{L,\mathrm{h},i}`),
          " への全単射であり、写像 ",
          math(String.raw`j\mapsto L^2+iL+j+1`),
          " は ",
          math(String.raw`\{0,1,\dots,L-1\}`),
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
          math(String.raw`E_{L,\mathrm{h}}=\bigcup_{i=0}^{L-1}E_{L,\mathrm{h},i}`),
          " かつ ",
          math(String.raw`E_{L,\mathrm{v}}=\bigcup_{i=0}^{L-1}E_{L,\mathrm{v},i}`),
          " である（",
          math(String.raw`E_{L,\mathrm{h}}`),
          " と ",
          math(String.raw`E_{L,\mathrm{v}}`),
          " は ",
          ref("def_lattice"),
          "）。",
        ],
        [
          "端点は番号から直接読める。すなわち ",
          math(String.raw`i,j\in\{0,1,\dots,L-1\}`),
          " に対し",
          math(String.raw`\ \partial_0(iL+j+1)=(i,j)`),
          "、",
          math(String.raw`\partial_1(iL+j+1)=(i,\,j+1)`),
          " であり、",
          math(String.raw`\partial_0(L^2+iL+j+1)=(i,j)`),
          "、",
          math(String.raw`\partial_1(L^2+iL+j+1)=(i+1,\,j)`),
          " である。ここで頂点の成分は ",
          math(String.raw`\{0,1,\dots,L-1\}`),
          " の元を ",
          math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
          " の元とみなしたものであり、",
          math(String.raw`i+1`),
          " と ",
          math(String.raw`j+1`),
          " の加法は ",
          math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
          " の中で行う（",
          ref("def_lattice"),
          " の約束）。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "番号が正しい範囲に入ること。",
        math(String.raw`i,j\in\{0,1,\dots,L-1\}`),
        " のとき",
      ]),
      displayMath(String.raw`0\le iL+j\le(L-1)L+(L-1)=L^2-1`),
      paragraph([
        "である（左の不等式は ",
        math(String.raw`i,j\ge0`),
        "、右の不等式は ",
        math(String.raw`i,j\le L-1`),
        " による）。したがって ",
        math(String.raw`1\le iL+j+1\le L^2`),
        " なので ",
        math(String.raw`E_{L,\mathrm{h},i}\subset E_{L,\mathrm{h}}`),
        " であり、",
        math(String.raw`L^2+1\le L^2+iL+j+1\le 2L^2`),
        " なので ",
        math(String.raw`E_{L,\mathrm{v},i}\subset E_{L,\mathrm{v}}`),
        " である（",
        ref("def_lattice"),
        " の番号の範囲）。",
      ]),
      paragraph([
        "分解の一意性。",
        ref("def_lattice"),
        " で使った除法の原理により、",
        math(String.raw`0\le k\le L^2-1`),
        " を満たす整数 ",
        math(String.raw`k`),
        " は ",
        math(String.raw`k=iL+j`),
        "（",
        math(String.raw`i,j\in\{0,1,\dots,L-1\}`),
        "）の形にただ一通りに書ける。いいかえると、",
        math(String.raw`(i,j)\mapsto iL+j`),
        " は ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の 2 つ組全体から ",
        math(String.raw`\{0,1,\dots,L^2-1\}`),
        " への全単射である。",
      ]),
      paragraph([
        "個数。",
        math(String.raw`i`),
        " を固定する。",
        math(String.raw`j\ne j'`),
        " ならば ",
        math(String.raw`iL+j\ne iL+j'`),
        " なので、写像 ",
        math(String.raw`j\mapsto iL+j+1`),
        " は ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " から ",
        math(String.raw`E_{L,\mathrm{h},i}`),
        " への全単射である（全射は定義から）。",
        math(String.raw`j\mapsto L^2+iL+j+1`),
        " についても、両辺から ",
        math(String.raw`L^2`),
        " を引けば同じ議論になり、",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " から ",
        math(String.raw`E_{L,\mathrm{v},i}`),
        " への全単射である。これで 1 つめが示せた。",
        "さらに全単射で写り合う有限集合の個数は等しいので ",
        math(String.raw`|E_{L,\mathrm{h},i}|=L`),
        " かつ ",
        math(String.raw`|E_{L,\mathrm{v},i}|=L`),
        " であり、2 つめも示せた。",
      ]),
      paragraph([
        "互いに素であること。",
        math(String.raw`i\ne i'`),
        " とし、",
        math(String.raw`E_{L,\mathrm{h},i}\cap E_{L,\mathrm{h},i'}`),
        " に元 ",
        math(String.raw`e`),
        " があったとする。すると ",
        math(String.raw`j,j'\in\{0,1,\dots,L-1\}`),
        " を取って ",
        math(String.raw`e=iL+j+1=i'L+j'+1`),
        " と書けるので ",
        math(String.raw`iL+j=i'L+j'`),
        " である。上の分解の一意性より ",
        math(String.raw`i=i'`),
        " となり仮定に反する。よって共通部分は空である。",
        math(String.raw`E_{L,\mathrm{v},i}`),
        " どうしについても、両辺から ",
        math(String.raw`L^2`),
        " を引けば同じ議論になる。これで 3 つめが示せた。",
      ]),
      paragraph([
        "合併。番号が正しい範囲に入ることから ",
        math(String.raw`\bigcup_{i=0}^{L-1}E_{L,\mathrm{h},i}\subset E_{L,\mathrm{h}}`),
        " である。逆に ",
        math(String.raw`e\in E_{L,\mathrm{h}}`),
        " を取ると ",
        ref("def_lattice"),
        " より ",
        math(String.raw`1\le e\le L^2`),
        " すなわち ",
        math(String.raw`0\le e-1\le L^2-1`),
        " なので、分解の一意性により ",
        math(String.raw`e-1=iL+j`),
        " と書ける。このとき ",
        math(String.raw`e=iL+j+1\in E_{L,\mathrm{h},i}`),
        " である。よって両方の包含が成り立ち、合併は ",
        math(String.raw`E_{L,\mathrm{h}}`),
        " に等しい。縦向きについては、",
        math(String.raw`e\in E_{L,\mathrm{v}}`),
        " が ",
        math(String.raw`L^2+1\le e\le2L^2`),
        " すなわち ",
        math(String.raw`0\le e-L^2-1\le L^2-1`),
        " を満たすことから、同じ議論で ",
        math(String.raw`E_{L,\mathrm{v}}`),
        " に等しいことが従う。これで 4 つめが示せた。",
      ]),
      paragraph([
        "端点。",
        math(String.raw`e=iL+j+1\in E_{L,\mathrm{h}}`),
        " のとき ",
        math(String.raw`e-1=iL+j`),
        " であり、分解の一意性により、この ",
        math(String.raw`(i,j)`),
        " は ",
        ref("def_lattice"),
        " が端点写像を定めるときに使う分解そのものである。したがって定義そのものから ",
        math(String.raw`\partial_0(e)=(i,j)`),
        "、",
        math(String.raw`\partial_1(e)=(i,\,j+1)`),
        " である。",
        math(String.raw`e=L^2+iL+j+1\in E_{L,\mathrm{v}}`),
        " のときは ",
        math(String.raw`e-L^2-1=iL+j`),
        " が定義で使う分解にあたるので、同じく ",
        math(String.raw`\partial_0(e)=(i,j)`),
        "、",
        math(String.raw`\partial_1(e)=(i+1,\,j)`),
        " である。これで 5 つめが示せた。",
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
        String.raw`b(\sigma)=\sum_{i=0}^{L-1}b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
+\sum_{i=0}^{L-1}b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+1}(\sigma)\bigr)`,
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
&&(\because\ \text{破れボンド数の定義})
\end{aligned}`),
      paragraph([
        "と置く。あわせて、各 ",
        math(String.raw`i\in\{0,1,\dots,L-1\}`),
        " について次の 2 つを準備する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\bigl|B(\sigma)\cap E_{L,\mathrm{h},i}\bigr|
&=\bigl|\bigl\{\,j \;\bigm|\; iL+j+1\in B(\sigma)\,\bigr\}\bigr|
&&(\because\ j\mapsto iL+j+1\ \text{が}\ E_{L,\mathrm{h},i}\ \text{への全単射})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \sigma((i,j))\ne\sigma((i,\,j+1))\,\bigr\}\bigr|
&&(\because\ \text{辺の集合は行ごとに分割される（端点の式）})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \bigl(\rho_i(\sigma)\bigr)(j)\ne\bigl(\rho_i(\sigma)\bigr)(j+1)\,\bigr\}\bigr|
&&(\because\ \text{行への制限の定義})\\
&=b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
&&(\because\ \text{行内破れ数の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\bigl|B(\sigma)\cap E_{L,\mathrm{v},i}\bigr|
&=\bigl|\bigl\{\,j \;\bigm|\; L^2+iL+j+1\in B(\sigma)\,\bigr\}\bigr|
&&(\because\ j\mapsto L^2+iL+j+1\ \text{が}\ E_{L,\mathrm{v},i}\ \text{への全単射})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \sigma((i,j))\ne\sigma((i+1,\,j))\,\bigr\}\bigr|
&&(\because\ \text{辺の集合は行ごとに分割される（端点の式）})\\
&=\bigl|\bigl\{\,j \;\bigm|\; \bigl(\rho_i(\sigma)\bigr)(j)\ne\bigl(\rho_{i+1}(\sigma)\bigr)(j)\,\bigr\}\bigr|
&&(\because\ \text{行への制限の定義})\\
&=b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+1}(\sigma)\bigr)
&&(\because\ \text{行間破れ数の定義})
\end{aligned}`),
      paragraph([
        "ここで ",
        math(String.raw`j`),
        " の動く範囲 ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " とみなす（",
        ref("def_lattice"),
        " の約束）。この対応のもとで ",
        math(String.raw`j+1`),
        " はどちらの側でも ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中の加法であり、",
        math(String.raw`j=L-1`),
        " のとき ",
        math(String.raw`0`),
        " になる。",
      ]),
      paragraph(["準備したものを使うと"]),
      displayMath(String.raw`\begin{aligned}
b(\sigma)
&=|B(\sigma)|
&&(\because\ \text{上の準備})\\
&=\bigl|B(\sigma)\cap E_{L,\mathrm{h}}\bigr|+\bigl|B(\sigma)\cap E_{L,\mathrm{v}}\bigr|
&&(\because\ E_L=E_{L,\mathrm{h}}\cup E_{L,\mathrm{v}}\ \text{は互いに素な合併})\\
&=\sum_{i=0}^{L-1}\bigl|B(\sigma)\cap E_{L,\mathrm{h},i}\bigr|
+\sum_{i=0}^{L-1}\bigl|B(\sigma)\cap E_{L,\mathrm{v},i}\bigr|
&&(\because\ \text{辺の集合は行ごとに分割される})\\
&=\sum_{i=0}^{L-1}b_{\mathrm{h}}\bigl(\rho_i(\sigma)\bigr)
+\sum_{i=0}^{L-1}b_{\mathrm{v}}\bigl(\rho_i(\sigma),\,\rho_{i+1}(\sigma)\bigr)
&&(\because\ \text{上の準備})
\end{aligned}`),
      paragraph([
        "を得る。互いに素な有限集合の合併の元の個数がそれぞれの個数の和であることを、",
        "2 行目と 3 行目で使っている。",
      ]),
      paragraph([
        "引いたブロック: ",
        ref("def_broken_bond_count"),
        "、",
        ref("def_lattice"),
        "、",
        ref("claim_edge_row_partition"),
        "、",
        ref("def_row_restriction"),
        "、",
        ref("def_intra_row_broken_count"),
        "、",
        ref("def_inter_row_broken_count"),
        "。",
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
&&(\because\ \text{行への制限の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\Bigl(\bigl(\mathrm{rows}(\mathrm{conf}(c))\bigr)(i)\Bigr)(j)
&=\bigl(\rho_i(\mathrm{conf}(c))\bigr)(j)
&&(\because\ \mathrm{rows}\ \text{の定義})\\
&=\bigl(\mathrm{conf}(c)\bigr)\bigl((i,j)\bigr)
&&(\because\ \text{行への制限の定義})\\
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
        "引いたブロック: ",
        ref("def_rows_map"),
        "、",
        ref("def_row_restriction"),
        "。",
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
        String.raw`\prod_{i=0}^{L-1}T_{\rho_i(\sigma),\,\rho_{i+1}(\sigma)}=x^{\,b(\sigma)}`,
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
\prod_{i=0}^{L-1}T_{\rho_i(\sigma),\,\rho_{i+1}(\sigma)}
&=\prod_{i=0}^{L-1}x^{\,b_{\mathrm{h}}(\rho_i(\sigma))+b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+1}(\sigma))}
&&(\because\ \text{転送行列の定義})\\
&=x^{\,\sum_{i=0}^{L-1}\bigl(b_{\mathrm{h}}(\rho_i(\sigma))+b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+1}(\sigma))\bigr)}
&&(\because\ x^{a}x^{a'}=x^{a+a'}\ \text{を}\ L-1\ \text{回})\\
&=x^{\,\sum_{i=0}^{L-1}b_{\mathrm{h}}(\rho_i(\sigma))
+\sum_{i=0}^{L-1}b_{\mathrm{v}}(\rho_i(\sigma),\,\rho_{i+1}(\sigma))}
&&(\because\ \text{有限個の自然数の和は項ごとに分けられる})\\
&=x^{\,b(\sigma)}
&&(\because\ \text{破れボンド数は行内の破れと行間の破れに分かれる})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_transfer_matrix"),
        "、",
        ref("claim_broken_bond_row_decomposition"),
        "。",
      ]),
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
        "引いたブロック: ",
        ref("def_matrix_over_row_configs"),
        "、",
        ref("def_row_walk"),
        "。",
      ]),
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
        "引いたブロック: ",
        ref("def_row_walk"),
        "。",
      ]),
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
        "引いたブロック: ",
        ref("def_matrix_over_row_configs"),
        "、",
        ref("def_row_walk"),
        "。",
      ]),
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
        "以下、整数 ",
        math(String.raw`a\in\mathbb{Z}`),
        " に対し、その ",
        math(String.raw`L`),
        " を法とする剰余類を ",
        math(String.raw`\overline{a}\in\mathbb{Z}/L\mathbb{Z}`),
        " と書く。",
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
        String.raw`\bigl(\Theta(c)\bigr)(i):=c(\overline{i})\qquad(i\in\{0,1,\dots,L\})`,
      ),
      paragraph([
        "で定める。右辺は ",
        math(String.raw`R_L`),
        " の元なので ",
        math(String.raw`\Theta(c)`),
        " は ",
        math(String.raw`W_{L,L}`),
        " の元であり、",
        math(String.raw`\overline{L}=\overline{0}`),
        " より ",
        math(String.raw`\bigl(\Theta(c)\bigr)(L)=c(\overline{0})=\bigl(\Theta(c)\bigr)(0)`),
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
        String.raw`\bigl(\Xi(p)\bigr)(\overline{a}):=p(a)\qquad(a\in\{0,1,\dots,L-1\})`,
      ),
      paragraph([
        "で定める。",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " のどの元も ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の中にちょうど 1 つ代表元を持つので、この式は ",
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
        " の元を任意に取り、その ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の中の代表元を ",
        math(String.raw`a`),
        " とすると",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Xi\bigl(\Theta(c)\bigr)\Bigr)(\overline{a})
&=\bigl(\Theta(c)\bigr)(a)
&&(\because\ \Xi\ \text{の定義})\\
&=c(\overline{a})
&&(\because\ \Theta\ \text{の定義})
\end{aligned}`),
      paragraph([
        "である。取った元は任意だったので、写像として ",
        math(String.raw`\Xi(\Theta(c))=c`),
        " である。",
      ]),
      paragraph([
        "引いたブロック: ",
        ref("def_walk_of_family"),
        "。",
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
        math(String.raw`\overline{i}`),
        " の代表元が ",
        math(String.raw`i`),
        " であるかどうかが違うので、一続きの式にはしない）。",
      ]),
      paragraph([
        math(String.raw`i\le L-1`),
        " の場合。",
        math(String.raw`i`),
        " 自身が ",
        math(String.raw`\overline{i}`),
        " の ",
        math(String.raw`\{0,1,\dots,L-1\}`),
        " の中の代表元であるから",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Theta\bigl(\Xi(p)\bigr)\Bigr)(i)
&=\bigl(\Xi(p)\bigr)(\overline{i})
&&(\because\ \Theta\ \text{の定義})\\
&=p(i)
&&(\because\ \Xi\ \text{の定義。}i\ \text{は}\ \overline{i}\ \text{の代表元})
\end{aligned}`),
      paragraph([
        "である。",
      ]),
      paragraph([
        math(String.raw`i=L`),
        " の場合。",
      ]),
      displayMath(String.raw`\begin{aligned}
\Bigl(\Theta\bigl(\Xi(p)\bigr)\Bigr)(L)
&=\bigl(\Xi(p)\bigr)(\overline{L})
&&(\because\ \Theta\ \text{の定義})\\
&=\bigl(\Xi(p)\bigr)(\overline{0})
&&(\because\ \overline{L}=\overline{0})\\
&=p(0)
&&(\because\ \Xi\ \text{の定義。}0\ \text{は}\ \overline{0}\ \text{の代表元})\\
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
        "引いたブロック: ",
        ref("def_closed_walk"),
        "、",
        ref("def_walk_of_family"),
        "。",
      ]),
      paragraph([
        "結論。以上より ",
        math(String.raw`\Theta`),
        " は ",
        math(String.raw`\Xi`),
        " を逆写像に持つ。逆写像を持つ写像は全単射である。",
        "以上は写像の値の計算と剰余類の代表元の取り扱いだけからなり、実数体も複素数体も現れない。",
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
        "準備 1（閉じた道の全体が、両端の値ごとに互いに素な類へ分かれること）。",
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
        "準備 2（行配位の族から作った閉じた道の重み）。配位 ",
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
&=\prod_{i=0}^{L-1}T_{\bigl(\mathrm{rows}(\sigma)\bigr)(\overline{i}),\,\bigl(\mathrm{rows}(\sigma)\bigr)(\overline{i+1})}
&&(\because\ \Theta\ \text{の定義})\\
&=\prod_{i=0}^{L-1}T_{\rho_i(\sigma),\,\rho_{i+1}(\sigma)}
&&(\because\ \mathrm{rows}\ \text{の定義})\\
&=x^{\,b(\sigma)}
&&(\because\ \text{配位の重みは行に沿った成分の積である})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_row_walk"),
        "、",
        ref("def_walk_of_family"),
        "、",
        ref("def_rows_map"),
        "、",
        ref("claim_transfer_weight_product"),
        "。",
        "第 3 の等号で、",
        math(String.raw`\rho`),
        " の添字（行番号）に剰余類を用いる約束（",
        ref("claim_transfer_weight_product"),
        " と同じ）をそのまま使っている。",
      ]),
      paragraph([
        "以上を用いて、右辺から左辺へたどる。",
      ]),
      displayMath(String.raw`\begin{aligned}
\operatorname{Tr}\bigl(T^{L}\bigr)
&=\sum_{\tau\in R_L}\bigl(T^{L}\bigr)_{\tau,\tau}
&&(\because\ \text{トレースの定義})\\
&=\sum_{\tau\in R_L}\ \sum_{p\in W_{L,L}(\tau,\tau)}w_T(p)
&&(\because\ \text{行列の冪の成分は道に沿った成分の積の和である})\\
&=\sum_{p\in W^{\mathrm{cl}}_{L}}w_T(p)
&&(\because\ \text{準備 1})\\
&=\sum_{c\in C_L}w_T\bigl(\Theta(c)\bigr)
&&(\because\ \Theta\ \text{が全単射})\\
&=\sum_{\sigma\in\Sigma_L}w_T\bigl(\Theta(\mathrm{rows}(\sigma))\bigr)
&&(\because\ \mathrm{rows}\ \text{が全単射})\\
&=\sum_{\sigma\in\Sigma_L}x^{\,b(\sigma)}
&&(\because\ \text{準備 2})\\
&=Z_L
&&(\because\ \text{分配多項式の定義})
\end{aligned}`),
      paragraph([
        "引いたブロック: ",
        ref("def_matrix_over_row_configs"),
        "、",
        ref("claim_matrix_pow_entry"),
        "、",
        ref("claim_closed_walk_bijection"),
        "、",
        ref("claim_rows_bijection"),
        "、",
        ref("def_partition_polynomial"),
        "。",
        "第 2 の等号は ",
        ref("claim_matrix_pow_entry"),
        " を ",
        math(String.raw`A=T`),
        "、",
        math(String.raw`k=L`),
        "、",
        math(String.raw`\tau''=\tau`),
        " として各 ",
        math(String.raw`\tau\in R_L`),
        " に用いたものである。",
      ]),
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
    id: "main_text_remark_planned_chapters",
    kind: "remark",
    title: { text: "この先に置く章（未着手）" },
    labels: ["remark_planned_chapters"],
    habitat: "none",
    statement: [
      paragraph([
        "本文はここまでで、以下は未着手である。",
        "読む順序と各章が扱う量の住処は README の「章立ての予定」の表が正本である。",
      ]),
      list([
        [
          todo("未着手"),
          "「有限系の自由エントロピー」の続き: 一般の ",
          math(String.raw`q`),
          " での ",
          math(String.raw`\Phi_L(q)`),
          " の性質（双対な点どうしの関係など）。加法性・冪の法則と ",
          math(String.raw`\Phi_L(1)=L^2\ell_2`),
          " までは上で済んでいる。",
        ],
        [
          todo("未着手"),
          "「転送行列」の続き: ",
          math(String.raw`Z_L=\operatorname{Tr}\bigl(T^L\bigr)`),
          " を示す。転送行列 ",
          math(String.raw`T`),
          " の定義、配位の重みが行に沿った成分の積であること、および行列の冪の成分が",
          "道に沿った成分の積の和であることまでは上で済んでいる。",
          "残るのは、トレースを取ると両端が一致する道にわたる和になることと、",
          "その道の全体が ",
          ref("def_row_family"),
          " の行配位の族の全体と 1 対 1 に対応することである。",
        ],
        [
          todo("未着手"),
          "「固有値の代数性」: 特性多項式が ",
          math(String.raw`\mathbb{Z}[x][\lambda]`),
          " に属することから固有値の代数性を出し、円分体上で対角化する。",
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
