/**
 * 本文（章は見出しブロックで区切る）。
 *
 * この文書の目的は、3 次元 Ising 模型の臨界点を有理数の切断として扱う枠組みのうち、
 * **低温側の証拠**を有限のデータとして定義し、**何が未解決なのか**を主張として立てることである。
 *
 * 立場（プロジェクト README が正本）:
 *   - 非可算へ出てよいのは、有限格子の量の列について格子サイズを大きくする極限だけである。
 *     この文書には極限が 1 度も現れない（すべて有限格子ごとの主張である）。
 *   - 相・臨界温度・自発磁化といった無限体積の語を主張に使わない。
 *   - 無限和・級数を書かない。有限和と、格子サイズに依らない一様な有理数の不等式だけを使う。
 *
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref, todo } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_box_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限箱と配位" },
    labels: [],
  },

  {
    id: "finite_box_definition_cardinality_notation",
    kind: "definition",
    title: { text: "有限集合の元の個数の記法" },
    labels: ["def_cardinality_notation"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`X`),
        " に対し ",
        math(String.raw`\#X`),
        " でその元の個数（",
        math(String.raw`\mathbb{N}`),
        " の元）を表す。この記法をこれ以外の意味では使わない。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_site_set",
    kind: "definition",
    title: { text: "格子点の集合と隣接" },
    labels: ["def_site_set"],
    habitat: "Z",
    statement: [
      paragraph([
        "格子点の集合を ",
        math(String.raw`\Lambda_{\mathrm{site}}=\mathbb{Z}\times\mathbb{Z}\times\mathbb{Z}`),
        " とする。二つの格子点 ",
        math(String.raw`u=(u_1,u_2,u_3)`),
        "、",
        math(String.raw`v=(v_1,v_2,v_3)`),
        " が",
      ]),
      displayMath(String.raw`|u_1-v_1|+|u_2-v_2|+|u_3-v_3|=1`),
      paragraph([
        "を満たすとき、",
        math(String.raw`u`),
        " と ",
        math(String.raw`v`),
        " は隣接するという。ここで ",
        math(String.raw`|\cdot|`),
        " は整数の絶対値であり、和は整数の和である。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_box",
    kind: "definition",
    title: { text: "一辺の長さ L の箱" },
    labels: ["def_box"],
    habitat: "Z",
    statement: [
      paragraph(["整数 ", math(String.raw`L\ge1`), " に対し"]),
      displayMath(
        String.raw`V_L=\{\,u\in\Lambda_{\mathrm{site}}\ :\ 0\le u_i\le L-1\ (i=1,2,3)\,\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`\#V_L=L\cdot L\cdot L`),
        " である。原点 ",
        math(String.raw`o=(0,0,0)`),
        " は ",
        math(String.raw`V_L`),
        " に属する。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_inner_edges",
    kind: "definition",
    title: { text: "内部辺の集合" },
    labels: ["def_inner_edges"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`V_L`),
        " の二つの格子点の組で、隣接するものの集合を",
      ]),
      displayMath(
        String.raw`E_L=\{\,\{u,v\}\ :\ u\in V_L,\ v\in V_L,\ u\ \text{と}\ v\ \text{は隣接する}\,\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`\{u,v\}`),
        " は二つの格子点からなる集合であり、順序を持たない。",
        math(String.raw`E_L`),
        " は有限集合である。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_boundary_edges",
    kind: "definition",
    title: { text: "境界辺の集合" },
    labels: ["def_boundary_edges"],
    habitat: "N",
    statement: [
      paragraph(["箱の内から外へ出る組の集合を"]),
      displayMath(
        String.raw`B_L=\{\,\{u,w\}\ :\ u\in V_L,\ w\in\Lambda_{\mathrm{site}}\setminus V_L,\
u\ \text{と}\ w\ \text{は隣接する}\,\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`B_L`),
        " も有限集合である。以下、辺と呼ぶのは ",
        math(String.raw`E_L\cup B_L`),
        " の元だけである。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_configuration",
    kind: "definition",
    title: { text: "箱の中の配位と外側の固定" },
    labels: ["def_configuration"],
    habitat: "Z",
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`\sigma:V_L\to\{+1,-1\}`),
        " を配位と呼び、配位全体の集合を ",
        math(String.raw`\Sigma_L`),
        " と書く。",
        math(String.raw`\#\Sigma_L=2^{\#V_L}`),
        " である。",
      ]),
      paragraph([
        "箱の外側の格子点には値 ",
        math(String.raw`+1`),
        " を割り当てる（外側を固定する）。この割り当ては配位ごとに変わらないので、",
        math(String.raw`\sigma`),
        " の一部としては扱わず、次の破れ数の定義の中でだけ使う。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_broken_count",
    kind: "definition",
    title: { text: "配位が破っている辺の本数" },
    labels: ["def_broken_count"],
    habitat: "N",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " に対し、破れている内部辺の集合と破れている境界辺の集合を",
      ]),
      displayMath(
        String.raw`D_{\mathrm{in}}(\sigma)=\{\,\{u,v\}\in E_L\ :\ \sigma(u)\ne\sigma(v)\,\},\qquad
D_{\mathrm{bd}}(\sigma)=\{\,\{u,w\}\in B_L\ :\ \sigma(u)=-1\,\}`,
      ),
      paragraph([
        "と置き（境界辺の外側の値は ",
        math(String.raw`+1`),
        " に固定してあるので、破れることと ",
        math(String.raw`\sigma(u)=-1`),
        " は同じことである）、破れ辺集合と破れ数を",
      ]),
      displayMath(
        String.raw`D(\sigma)=D_{\mathrm{in}}(\sigma)\cup D_{\mathrm{bd}}(\sigma),\qquad
m_L(\sigma)=\#D(\sigma)\in\mathbb{N}`,
      ),
      paragraph(["と置く。"]),
    ],
  },

  {
    id: "partition_polynomial_heading",
    kind: "heading",
    level: 1,
    title: { text: "分配多項式と原点が負である割合" },
    labels: [],
  },

  {
    id: "partition_polynomial_definition_partition_polynomial",
    kind: "definition",
    title: { text: "外側を固定した分配多項式" },
    labels: ["def_partition_polynomial"],
    habitat: "Z",
    statement: [
      paragraph([math(String.raw`x`), " を不定元として"]),
      displayMath(String.raw`Z_L(x)=\sum_{\sigma\in\Sigma_L}x^{\,m_L(\sigma)}\ \in\ \mathbb{Z}[x]`),
      paragraph([
        "と置く。和は有限個（",
        math(String.raw`\#\Sigma_L`),
        " 個）の項にわたる。係数は配位の個数なので ",
        math(String.raw`\mathbb{N}`),
        " の元である。",
      ]),
      paragraph([
        "この定義に指数関数は現れない。逆温度を表す記号も置かない（プロジェクト ",
        "README「許される脱出」）。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_negative_origin_polynomial",
    kind: "definition",
    title: { text: "原点が負である配位の分配多項式" },
    labels: ["def_negative_origin_polynomial"],
    habitat: "Z",
    statement: [
      displayMath(
        String.raw`N_L(x)=\sum_{\sigma\in\Sigma_L,\ \sigma(o)=-1}x^{\,m_L(\sigma)}\ \in\ \mathbb{Z}[x]`,
      ),
      paragraph([
        "と置く。和の走る範囲は ",
        math(String.raw`\Sigma_L`),
        " の部分集合なので、これも有限和である。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_claim_partition_value_at_least_one",
    kind: "claim",
    title: { text: "有理点での分配多項式の値は 1 以上" },
    labels: ["claim_partition_value_at_least_one"],
    habitat: "Q",
    statement: [
      paragraph([
        "有理数 ",
        math(String.raw`q`),
        " が ",
        math(String.raw`0<q<1`),
        " を満たすならば ",
        math(String.raw`Z_L(q)\ge1`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        "すべての格子点で値 ",
        math(String.raw`+1`),
        " を取る配位を ",
        math(String.raw`\sigma^{+}`),
        " と書く。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
m_L(\sigma^{+})&=\#\bigl(D_{\mathrm{in}}(\sigma^{+})\cup D_{\mathrm{bd}}(\sigma^{+})\bigr)
&&(\because\ \text{破れ数の定義})\\
&=\#(\emptyset\cup\emptyset) &&(\because\ \sigma^{+}\ \text{はどの辺も破らない})\\
&=0 &&(\because\ \text{空集合の元の個数は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\sigma^{+}`),
        " の項は ",
        math(String.raw`q^{0}=1`),
        " である。他の項は ",
        math(String.raw`q>0`),
        " より正である。したがって和は ",
        math(String.raw`1`),
        " 以上である。",
      ]),
    ],
  },

  {
    id: "partition_polynomial_definition_negative_origin_ratio",
    kind: "definition",
    title: { text: "原点が負である割合" },
    labels: ["def_negative_origin_ratio"],
    habitat: "Q",
    statement: [
      paragraph(["有理関数"]),
      displayMath(String.raw`R_L(x)=\frac{N_L(x)}{Z_L(x)}`),
      paragraph([
        "を定める。有理数 ",
        math(String.raw`q`),
        " が ",
        math(String.raw`0<q<1`),
        " を満たすとき、",
        ref("claim_partition_value_at_least_one"),
        " より ",
        math(String.raw`Z_L(q)\ne0`),
        " なので ",
        math(String.raw`R_L(q)`),
        " は有理数として定まる。",
      ]),
      paragraph([
        "この量を確率とも期待値とも呼ばない。呼ばずに済むのは、以下の主張がすべて ",
        math(String.raw`R_L(q)`),
        " という有理数についての不等式だからである。",
      ]),
    ],
  },

  {
    id: "separating_set_heading",
    kind: "heading",
    level: 1,
    title: { text: "原点を箱の外から分離する辺集合" },
    labels: [],
  },

  {
    id: "separating_set_definition_path",
    kind: "definition",
    title: { text: "原点から箱の外へ至る道" },
    labels: ["def_path"],
    habitat: "N",
    statement: [
      paragraph([
        "格子点の列 ",
        math(String.raw`(v_0,v_1,\dots,v_k)`),
        " が次の三つを満たすとき、原点から箱の外へ至る道と呼ぶ。",
      ]),
      list([
        [math(String.raw`v_0=o`), " である。"],
        [
          math(String.raw`0\le j\le k-1`),
          " のとき ",
          math(String.raw`v_j\in V_L`),
          " であり、",
          math(String.raw`v_k\in\Lambda_{\mathrm{site}}\setminus V_L`),
          " である。",
        ],
        [
          math(String.raw`0\le j\le k-1`),
          " のとき ",
          math(String.raw`v_j`),
          " と ",
          math(String.raw`v_{j+1}`),
          " は隣接する。",
        ],
      ]),
      paragraph([
        "道が通る辺の集合を ",
        math(String.raw`\{\,\{v_j,v_{j+1}\}\ :\ 0\le j\le k-1\,\}`),
        " と書く。これは ",
        math(String.raw`E_L\cup B_L`),
        " の部分集合である。",
      ]),
    ],
  },

  {
    id: "separating_set_definition_separating_set",
    kind: "definition",
    title: { text: "分離集合" },
    labels: ["def_separating_set"],
    habitat: "N",
    statement: [
      paragraph([
        "辺の集合 ",
        math(String.raw`F\subseteq E_L\cup B_L`),
        " が、原点から箱の外へ至るどの道についても、その道が通る辺の中に ",
        math(String.raw`F`),
        " の元を少なくとも一つ含むとき、",
        math(String.raw`F`),
        " を分離集合と呼ぶ。",
      ]),
      paragraph([
        "分離集合 ",
        math(String.raw`F`),
        " のどの真部分集合も分離集合でないとき、",
        math(String.raw`F`),
        " を極小分離集合と呼ぶ。",
      ]),
    ],
  },

  {
    id: "separating_set_claim_negative_origin_has_separating_subset",
    kind: "claim",
    title: { text: "原点が負である配位の破れ辺集合は分離集合を含む" },
    labels: ["claim_negative_origin_has_separating_subset"],
    habitat: "N",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " が ",
        math(String.raw`\sigma(o)=-1`),
        " を満たすならば、",
        math(String.raw`D(\sigma)`),
        " は分離集合を部分集合として含む。",
      ]),
    ],
    proof: [
      paragraph([
        "原点から箱の外へ至る道 ",
        math(String.raw`(v_0,\dots,v_k)`),
        " を任意に取る。",
        math(String.raw`\sigma`),
        " の値を箱の外では ",
        math(String.raw`+1`),
        " として読むと、列 ",
        math(String.raw`(\sigma(v_0),\dots,\sigma(v_k))`),
        " は ",
        math(String.raw`-1`),
        " で始まり ",
        math(String.raw`+1`),
        " で終わる。よって",
      ]),
      displayMath(
        String.raw`\exists j\ (0\le j\le k-1):\quad \sigma(v_j)\ne\sigma(v_{j+1})`,
      ),
      paragraph([
        "である（そうでなければ列の値はすべて等しく、両端が異なることに反する）。この ",
        math(String.raw`j`),
        " について辺 ",
        math(String.raw`\{v_j,v_{j+1}\}`),
        " は破れているので ",
        math(String.raw`D(\sigma)`),
        " に属する（",
        ref("def_broken_count"),
        "）。すなわち ",
        math(String.raw`D(\sigma)`),
        " 自身が分離集合である（",
        ref("def_separating_set"),
        "）。分離集合は有限集合なので、元の個数について最小のものを取れば極小分離集合が得られ、それは ",
        math(String.raw`D(\sigma)`),
        " の部分集合である。",
      ]),
    ],
  },

  {
    id: "separating_set_definition_minimal_separating_count",
    kind: "definition",
    title: { text: "極小分離集合の個数" },
    labels: ["def_minimal_separating_count"],
    habitat: "N",
    statement: [
      paragraph(["自然数 ", math(String.raw`n`), " に対し"]),
      displayMath(
        String.raw`A_L(n)=\#\{\,F\subseteq E_L\cup B_L\ :\ F\ \text{は極小分離集合},\ \#F=n\,\}\ \in\ \mathbb{N}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`n>\#(E_L\cup B_L)`),
        " のとき ",
        math(String.raw`A_L(n)=0`),
        " である。",
      ]),
    ],
  },

  {
    id: "separating_set_claim_minimal_separating_growth",
    kind: "claim",
    title: { text: "極小分離集合の個数は指数で抑えられる（未証明）" },
    labels: ["claim_minimal_separating_growth"],
    habitat: "N",
    statement: [
      paragraph([
        "自然数 ",
        math(String.raw`C`),
        " が存在して、すべての整数 ",
        math(String.raw`L\ge1`),
        " とすべての自然数 ",
        math(String.raw`n`),
        " について ",
        math(String.raw`A_L(n)\le C^{\,n}`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      todo(
        "未証明。極小分離集合が原点を囲む連結な辺集合であることを示し、" +
          "指定した一辺から順に辿る対応で個数を上から抑える（Peierls の輪郭の数え上げに当たる）。" +
          "定数 C を具体的な自然数として決めるところまで書く必要がある。",
      ),
    ],
  },

  {
    id: "low_temperature_certificate_heading",
    kind: "heading",
    level: 1,
    title: { text: "低温側の証拠" },
    labels: [],
  },

  {
    id: "low_temperature_certificate_claim_finite_geometric_sum",
    kind: "claim",
    title: { text: "有限等比和の上界" },
    labels: ["claim_finite_geometric_sum"],
    habitat: "Q",
    statement: [
      paragraph([
        "有理数 ",
        math(String.raw`r`),
        " が ",
        math(String.raw`0<r<1`),
        " を満たし、",
        math(String.raw`N`),
        " が自然数ならば",
      ]),
      displayMath(String.raw`\sum_{n=1}^{N}r^{\,n}\le\frac{r}{1-r}`),
      paragraph(["が成り立つ。左辺は有限和であり、両辺は有理数である。"]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
(1-r)\cdot\sum_{n=1}^{N}r^{\,n}
&=\sum_{n=1}^{N}r^{\,n}-\sum_{n=1}^{N}r^{\,n+1}
&&(\because\ \text{分配則})\\
&=r-r^{\,N+1}
&&(\because\ \text{隣り合う項が打ち消す})\\
&\le r
&&(\because\ r^{\,N+1}>0)
\end{aligned}`,
      ),
      paragraph([
        "両辺を正の有理数 ",
        math(String.raw`1-r`),
        " で割ると主張を得る。",
      ]),
    ],
  },

  {
    id: "low_temperature_certificate_definition_certificate",
    kind: "definition",
    title: { text: "低温側の証拠" },
    labels: ["def_low_temperature_certificate"],
    habitat: "Q",
    statement: [
      paragraph([
        "自然数 ",
        math(String.raw`C`),
        " と有理数 ",
        math(String.raw`q`),
        " の組 ",
        math(String.raw`(C,q)`),
        " が次の三つを満たすとき、",
        math(String.raw`(C,q)`),
        " を低温側の証拠と呼ぶ。",
      ]),
      list([
        [math(String.raw`0<q<1`), " である。"],
        [
          "すべての整数 ",
          math(String.raw`L\ge1`),
          " とすべての自然数 ",
          math(String.raw`n`),
          " について ",
          math(String.raw`A_L(n)\le C^{\,n}`),
          " である。",
        ],
        [math(String.raw`3\,C\,q\le1`), " である。"],
      ]),
      paragraph([
        "三つ目は有理数の不等式であり、有限個の整数の演算で判定できる。二つ目は ",
        ref("claim_minimal_separating_growth"),
        " が主張する形の評価である。",
      ]),
    ],
  },

  {
    id: "low_temperature_certificate_claim_peierls_bound",
    kind: "claim",
    title: { text: "原点が負である割合の分離集合による上界（未証明）" },
    labels: ["claim_peierls_bound"],
    habitat: "Q",
    statement: [
      paragraph([
        "有理数 ",
        math(String.raw`q`),
        " が ",
        math(String.raw`0<q<1`),
        " を満たすならば、すべての整数 ",
        math(String.raw`L\ge1`),
        " について",
      ]),
      displayMath(
        String.raw`R_L(q)\ \le\ \sum_{n=1}^{\#(E_L\cup B_L)}A_L(n)\,q^{\,n}`,
      ),
      paragraph(["が成り立つ。右辺は有限和であり、両辺は有理数である。"]),
    ],
    proof: [
      todo(
        "未証明。極小分離集合 F を一つ固定し、F の内側の値を反転させる写像が単射であることを示して、" +
          "F を含む破れ辺集合を持つ配位の重みの和を Z_L(q) の項へ埋め込む（Peierls の反転写像）。" +
          "反転が破れ数をちょうど #F 減らすことの確認が要点であり、" +
          "分離集合が極小であることをどこで使うかも明示する必要がある。",
      ),
    ],
  },

  {
    id: "low_temperature_certificate_claim_uniform_bound",
    kind: "claim",
    title: { text: "証拠があれば原点が負である割合は箱の大きさに依らず 1/2 以下" },
    labels: ["claim_certificate_gives_uniform_bound"],
    habitat: "Q",
    statement: [
      paragraph([
        math(String.raw`(C,q)`),
        " が低温側の証拠ならば、すべての整数 ",
        math(String.raw`L\ge1`),
        " について ",
        math(String.raw`R_L(q)\le\tfrac12`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "証拠の三つ目の条件 ",
        math(String.raw`3Cq\le1`),
        " から ",
        math(String.raw`Cq\le\tfrac13<1`),
        " である。よって ",
        math(String.raw`r=Cq`),
        " と置くと ",
        math(String.raw`0<r<1`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
R_L(q)
&\le\sum_{n=1}^{\#(E_L\cup B_L)}A_L(n)\,q^{\,n}
&&(\because\ \blkref{claim_peierls_bound})\\
&\le\sum_{n=1}^{\#(E_L\cup B_L)}C^{\,n}\,q^{\,n}
&&(\because\ \text{証拠の二つ目の条件})\\
&=\sum_{n=1}^{\#(E_L\cup B_L)}r^{\,n}
&&(\because\ r=Cq\ \text{と冪の法則})\\
&\le\frac{r}{1-r}
&&(\because\ \blkref{claim_finite_geometric_sum})\\
&\le\frac{1/3}{1-1/3}
&&(\because\ r\le\tfrac13\ \text{と右辺が}\ r\ \text{について増加})\\
&=\frac12
&&(\because\ \text{有理数の計算})
\end{aligned}`,
      ),
      paragraph([
        "上界は ",
        math(String.raw`L`),
        " を含まない。すなわち箱の大きさに依らない一様な上界である。",
      ]),
    ],
  },

  {
    id: "low_temperature_certificate_definition_rational_points",
    kind: "definition",
    title: { text: "低温側の有理点の集合" },
    labels: ["def_low_temperature_rational_points"],
    habitat: "Q",
    statement: [
      displayMath(
        String.raw`\mathcal{C}=\{\,q\in\mathbb{Q}\ :\ 0<q<1,\
\text{ある自然数}\ C\ \text{について}\ (C,q)\ \text{は低温側の証拠である}\,\}`,
      ),
      paragraph([
        "と置く。これは有理数の集合であり、実数を含まない。",
        ref("def_low_temperature_certificate"),
        " の三つの条件のうち一つ目と三つ目は決定可能なので、",
        ref("claim_minimal_separating_growth"),
        " の定数 ",
        math(String.raw`C`),
        " が一つ決まれば、",
        math(String.raw`\mathcal{C}`),
        " の所属は有理数の不等式 ",
        math(String.raw`3Cq\le1`),
        " で判定できる。",
      ]),
    ],
  },

  {
    id: "open_problem_heading",
    kind: "heading",
    level: 1,
    title: { text: "未解決問題" },
    labels: [],
  },

  {
    id: "open_problem_remark_coverage",
    kind: "remark",
    title: { text: "低温側の証拠はどこまで届くか" },
    labels: ["remark_open_problem_coverage"],
    habitat: "Q",
    statement: [
      paragraph([
        ref("def_low_temperature_certificate"),
        " の形の証拠は、",
        math(String.raw`3Cq\le1`),
        " を満たす有理数しか捉えない。定数 ",
        math(String.raw`C`),
        " は格子の形だけから決まるので、この条件を満たさない有理数には何も言えない。",
      ]),
      paragraph([
        "未解決問題は次である。",
      ]),
      list([
        [
          math(String.raw`3Cq>1`),
          " を満たす有理数に対しても、有限のデータについての有理数の不等式で書ける証拠の族を作れるか。",
        ],
        [
          "作れるとして、その族は ",
          math(String.raw`\mathcal{C}`),
          " をどこまで広げるか。高温側の証拠が付く有理数の集合と合わせて、",
          math(String.raw`\{q\in\mathbb{Q}:0<q<1\}`),
          " の高々一つの元を除く全体を覆うか。",
        ],
        [
          "覆えないとして、どちらの証拠も付かない有理数の集合を、有限のデータで特徴づけられるか。",
        ],
      ]),
      paragraph([
        "二つ目が肯定されたときに初めて、この枠組みは臨界点を有理数の切断として定めたことになる。",
        "現状は片側の一部しか押さえていない。",
      ]),
    ],
  },

  {
    id: "open_problem_remark_escape_policy",
    kind: "remark",
    title: { text: "この文書に現れていない脱出" },
    labels: ["remark_escape_policy"],
    habitat: "none",
    statement: [
      paragraph([
        "この文書の主張はすべて、有限の箱ごとの主張、または有理数についての主張である。",
        "極限・上限・下限・積分・微分・実対数・指数関数・無限和はどこにも現れていない。",
      ]),
      paragraph([
        "プロジェクトの立場では、非可算へ出てよいのは有限格子の量の列について箱の大きさを",
        "大きくする極限だけである。この文書はその極限を取らない範囲に収めてある。",
      ]),
    ],
  },

  {
    id: "open_problem_remark_not_claimed",
    kind: "remark",
    title: { text: "主張していないこと" },
    labels: ["remark_not_claimed"],
    habitat: "none",
    statement: [
      paragraph([
        "低温側の証拠が付いた有理数について、この文書は「その値で系が秩序相にある」とも",
        "「自発磁化が正である」とも主張していない。これらは無限体積についての語であり、",
        "証拠から導くには箱の大きさの極限が要る。極限を取る主張は別に立てる。",
      ]),
      paragraph([
        "また ",
        ref("claim_minimal_separating_growth"),
        " と ",
        ref("claim_peierls_bound"),
        " は未証明である。したがって ",
        ref("claim_certificate_gives_uniform_bound"),
        " は現状これらを仮定した主張であり、証明済みの定理として扱ってはならない。",
      ]),
    ],
  },
]);
