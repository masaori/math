/**
 * 章「分配多項式」。
 *
 * 有限格子の分配関数を、指数関数を経由せず整係数多項式として定義する。
 * この章に ℝ/ℂ は現れない（数え上げ ℕ と多項式環 ℤ[x] だけで閉じる）。
 *
 * 文書順はこの配列の並びが正本である（README「章立ての予定」の表が読む順序の正本）。
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
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`L\ge1`),
        " を固定する。格子とは、頂点集合",
      ]),
      displayMath(String.raw`V_L:=(\mathbb{Z}/L\mathbb{Z})\times(\mathbb{Z}/L\mathbb{Z})`),
      paragraph([
        "と、辺の添字集合",
      ]),
      displayMath(String.raw`E_L:=V_L\times\{\mathrm{h},\mathrm{v}\}`),
      paragraph([
        "および、各添字に 2 つの頂点を割り当てる写像 ",
        math(String.raw`\partial_0,\partial_1:E_L\to V_L`),
      ]),
      displayMath(
        String.raw`\partial_0\bigl((i,j),\mathrm{h}\bigr)=(i,j),\quad \partial_1\bigl((i,j),\mathrm{h}\bigr)=(i+1,j),
\qquad
\partial_0\bigl((i,j),\mathrm{v}\bigr)=(i,j),\quad \partial_1\bigl((i,j),\mathrm{v}\bigr)=(i,j+1)`,
      ),
      paragraph([
        "の組 ",
        math(String.raw`(V_L,E_L,\partial_0,\partial_1)`),
        " のことである（添字の加法は ",
        math(String.raw`\mathbb{Z}/L\mathbb{Z}`),
        " の中で行う。すなわち周期境界条件）。",
      ]),
      paragraph([
        "辺を頂点対の集合ではなく添字の族として定義したのは、",
        math(String.raw`L\le2`),
        " のとき異なる添字が同じ頂点対を指すからである（",
        math(String.raw`L=1`),
        " では ",
        math(String.raw`\partial_0=\partial_1`),
        "、",
        math(String.raw`L=2`),
        " では水平方向の 2 本が同じ 2 点を結ぶ）。頂点対の集合として数えると本数が ",
        math(String.raw`2L^2`),
        " からずれ、以下の主張が小さい ",
        math(String.raw`L`),
        " で成り立たなくなる。以後の数え上げはすべて添字ごとに行う。",
      ]),
      paragraph([
        math(String.raw`V_L`),
        " は有限集合で、その元の個数は ",
        math(String.raw`|V_L|=L^2\in\mathbb{N}`),
        "、",
        math(String.raw`E_L`),
        " も有限集合で ",
        math(String.raw`|E_L|=2L^2\in\mathbb{N}`),
        " である（",
        math(String.raw`|E_L|=|V_L|\cdot|\{\mathrm{h},\mathrm{v}\}|=L^2\cdot2`),
        "）。",
      ]),
      paragraph([
        "配位とは写像 ",
        math(String.raw`\sigma:V_L\to\{+1,-1\}`),
        " のことである。配位全体の集合を ",
        math(String.raw`\Sigma_L:=\{+1,-1\}^{V_L}`),
        " と書く。",
        math(String.raw`\Sigma_L`),
        " は有限集合で ",
        math(String.raw`|\Sigma_L|=2^{L^2}\in\mathbb{N}`),
        " である（有限集合 ",
        math(String.raw`V_L`),
        " から 2 元集合への写像の個数）。",
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
    statement: [
      paragraph([
        ref("def_configuration"),
        " の配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " と ",
        ref("def_lattice"),
        " の辺の添字 ",
        math(String.raw`e\in E_L`),
        " に対し、",
        math(String.raw`\sigma(\partial_0 e)\ne\sigma(\partial_1 e)`),
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
        math(String.raw`m(\sigma)`),
        " を、破れている辺の添字の個数",
      ]),
      displayMath(
        String.raw`m(\sigma):=\bigl|\bigl\{\,e\in E_L \;\bigm|\; \sigma(\partial_0 e)\ne\sigma(\partial_1 e)\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める。有限集合の部分集合の元の個数なので ",
        math(String.raw`m(\sigma)\in\mathbb{N}`),
        " であり、",
        math(String.raw`0\le m(\sigma)\le|E_L|=2L^2`),
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
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`m\in\{0,1,\dots,2L^2\}`),
        " に対し、多重度 ",
        math(String.raw`\Omega_L(m)`),
        " を",
      ]),
      displayMath(
        String.raw`\Omega_L(m):=\bigl|\bigl\{\,\sigma\in\Sigma_L \;\bigm|\; m(\sigma)=m\,\bigr\}\bigr|`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`m(\sigma)`),
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
    statement: [
      paragraph([
        math(String.raw`x`),
        " を不定元とし、多項式環 ",
        math(String.raw`\mathbb{Z}[x]`),
        " の中で分配多項式を",
      ]),
      displayMath(
        String.raw`Z_L(x):=\sum_{\sigma\in\Sigma_L}x^{\,m(\sigma)}
=\sum_{m=0}^{2L^2}\Omega_L(m)\,x^{\,m}\ \in\ \mathbb{Z}[x]`,
      ),
      paragraph([
        "で定める（",
        math(String.raw`m(\sigma)`),
        " は ",
        ref("def_broken_bond_count"),
        "、",
        math(String.raw`\Omega_L(m)`),
        " は ",
        ref("def_multiplicity"),
        "）。2 つの表示が一致するのは、有限和 ",
        math(String.raw`\sum_{\sigma\in\Sigma_L}`),
        " を ",
        math(String.raw`m(\sigma)`),
        " の値ごとの類に分けて数えたものが ",
        math(String.raw`\Omega_L(m)`),
        " だからである。",
      ]),
      paragraph([
        "係数 ",
        math(String.raw`\Omega_L(m)\in\mathbb{N}\subset\mathbb{Z}`),
        "、指数 ",
        math(String.raw`m\in\mathbb{N}`),
        " であり、",
        math(String.raw`Z_L(x)`),
        " は有限和なので ",
        math(String.raw`\mathbb{Z}[x]`),
        " の元として確定する。",
      ]),
      paragraph([
        "この定義では ",
        math(String.raw`x`),
        " に何も代入しない。 物理の分配関数を得るには ",
        math(String.raw`x=e^{-2\beta J}`),
        " を代入するが、その代入は実数体への脱出であり、脱出を宣言したブロックでのみ行う（README「形式変数のまま進む」）。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_claim_coefficient_sum",
    kind: "claim",
    title: { text: "多重度の総和は配位の総数に等しい" },
    labels: ["claim_coefficient_sum"],
    habitat: "N",
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
      paragraph([
        "Step 1（多重度の定義を配位の類別として読む）。",
        ref("def_multiplicity"),
        " により、",
        math(String.raw`\Omega_L(m)`),
        " は集合 ",
        math(String.raw`A_m:=\{\sigma\in\Sigma_L\mid m(\sigma)=m\}`),
        " の元の個数である。",
      ]),
      paragraph([
        "Step 2（類別であること）。",
        ref("def_broken_bond_count"),
        " により、各 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " に対し ",
        math(String.raw`m(\sigma)`),
        " はただ 1 つの値 ",
        math(String.raw`m\in\{0,1,\dots,2L^2\}`),
        " を取る。したがって ",
        math(String.raw`\sigma`),
        " はちょうど 1 つの ",
        math(String.raw`A_m`),
        " に属し、",
      ]),
      displayMath(String.raw`\Sigma_L=\bigsqcup_{m=0}^{2L^2}A_m`),
      paragraph(["は互いに素な有限個の集合への分割である。"]),
      paragraph([
        "Step 3（有限集合の分割の元の個数）。互いに素な有限個の有限集合の合併の元の個数は、",
        "各集合の元の個数の和である。Step 2 の分割にこれを適用して",
      ]),
      displayMath(String.raw`|\Sigma_L|=\sum_{m=0}^{2L^2}|A_m|=\sum_{m=0}^{2L^2}\Omega_L(m)`),
      paragraph(["を得る（最後の等号は Step 1）。"]),
      paragraph([
        "Step 4（配位の総数）。",
        ref("def_configuration"),
        " により ",
        math(String.raw`|\Sigma_L|=2^{L^2}`),
        " である。",
      ]),
      paragraph([
        "Step 5（結論）。Step 3 の左辺へ Step 4 を代入して ",
        math(String.raw`\sum_{m=0}^{2L^2}\Omega_L(m)=2^{L^2}`),
        " を得る。",
      ]),
      paragraph([
        "以上の各ステップは有限集合の元の個数の計算だけからなり、実数体も複素数体も現れない。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_remark_planned_chapters",
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
        [todo("有限系の自由エントロピー: Φ_L = log Z_L(q) ∈ Λ（有理点 q での値の素因数分解）")],
        [todo("転送行列: T(x) ∈ M_{2^L}(ℤ[x]) と Z_L(x) = Tr T(x)^L")],
        [todo("固有値の代数性: 特性多項式 ∈ ℤ[x][λ]、円分体上での対角化")],
        [todo("Fisher 零点: 零点 ∈ ℚ̄、Kramers–Wannier 双対、自己双対点 x_c = √2 − 1")],
        [todo("零点の詰め寄り: 相転移を ℚ 上の量化言明として書く")],
        [todo("熱力学極限: 自由エネルギー密度・零点密度（ここが ℝ 脱出）")],
        [todo("臨界指数を零点列で書く: 先頭零点列 {x_1(L)} ⊂ ℚ̄ と有限サイズスケーリング")],
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
