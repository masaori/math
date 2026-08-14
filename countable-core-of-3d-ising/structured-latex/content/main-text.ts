/**
 * 本文（章は見出しブロックで区切る）。
 *
 * 冒頭の章は主標的（可算コアの同定）の帰無モデルであり、自由境界の族について
 * 二部性からの回文性を証明する。それ以降の章は、当初本体に据えていた枠組み
 * 「有限の証拠で臨界点の切断を定める」（降格した従属標的）に属する。
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
    id: "null_model_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 二部性からの回文性（自由境界）" },
    labels: [],
  },

  {
    id: "null_model_remark_positioning",
    kind: "remark",
    title: { text: "この章の位置づけ（主標的の帰無モデル）" },
    labels: ["remark_null_model_positioning"],
    habitat: "none",
    statement: [
      paragraph([
        "この章はプロジェクトの主標的（可算コアの同定）に属する。測定の前に、",
        "格子の構造から強制される部分（帰無モデル）を証明して分離する。",
        "強制された構造をあとから発見と呼ばないためである。",
      ]),
      paragraph([
        "この章の族は自由境界である。すなわち箱の外側の格子点に値を割り当てず、",
        "内部辺だけを数える。後の章の族（外側を ",
        math(String.raw`+1`),
        " に固定し、境界辺も数える）とは別の族であり、混ぜて比べない。",
        "自由境界の量には free を添えて区別する。",
      ]),
      paragraph([
        "この章では、格子点・箱・内部辺・配位の定義（",
        ref("def_site_set"),
        "、",
        ref("def_box"),
        "、",
        ref("def_inner_edges"),
        "、",
        ref("def_configuration"),
        " の前段）をそのまま使う。外側の固定（",
        ref("def_configuration"),
        " の後段）はこの章では使わない。",
      ]),
    ],
  },

  {
    id: "null_model_definition_free_broken_count",
    kind: "definition",
    title: { text: "自由境界の破れ数" },
    labels: ["def_free_broken_count"],
    habitat: "N",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " に対し",
      ]),
      displayMath(
        String.raw`m^{\mathrm{free}}_L(\sigma)=\#\{\,\{u,v\}\in E_L\ :\ \sigma(u)\ne\sigma(v)\,\}\ \in\ \mathbb{N}`,
      ),
      paragraph([
        "と置き、自由境界の破れ数と呼ぶ。数える範囲は内部辺 ",
        math(String.raw`E_L`),
        "（",
        ref("def_inner_edges"),
        "）だけであり、境界辺 ",
        math(String.raw`B_L`),
        " は現れない。",
      ]),
    ],
  },

  {
    id: "null_model_definition_free_multiplicity",
    kind: "definition",
    title: { text: "自由境界の多重度" },
    labels: ["def_free_multiplicity"],
    habitat: "N",
    statement: [
      paragraph(["自然数 ", math(String.raw`m`), " に対し"]),
      displayMath(
        String.raw`\Omega^{\mathrm{free}}_L(m)=\#\{\,\sigma\in\Sigma_L\ :\ m^{\mathrm{free}}_L(\sigma)=m\,\}\ \in\ \mathbb{N}`,
      ),
      paragraph(["と置き、自由境界の多重度と呼ぶ。"]),
    ],
  },

  {
    id: "null_model_claim_adjacent_parity",
    kind: "claim",
    title: { text: "隣接する二つの格子点の座標和の偶奇は異なる" },
    labels: ["claim_adjacent_parity"],
    habitat: "Z",
    statement: [
      paragraph([
        "格子点 ",
        math(String.raw`u,v\in\Lambda_{\mathrm{site}}`),
        " が隣接するならば、整数 ",
        math(String.raw`u_1+u_2+u_3`),
        " と ",
        math(String.raw`v_1+v_2+v_3`),
        " の偶奇は異なる。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_site_set"),
        " の等式では三つの非負整数 ",
        math(String.raw`|u_1-v_1|,|u_2-v_2|,|u_3-v_3|`),
        " の和が ",
        math(String.raw`1`),
        " なので、ただ一つの添字 ",
        math(String.raw`i\in\{1,2,3\}`),
        " について ",
        math(String.raw`|u_i-v_i|=1`),
        " であり、他の二つの添字 ",
        math(String.raw`j`),
        " では ",
        math(String.raw`u_j=v_j`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(u_1+u_2+u_3)-(v_1+v_2+v_3)
&=\sum_{j=1}^{3}(u_j-v_j)
&&(\because\ \text{和の並べ替え})\\
&=u_i-v_i
&&(\because\ i\ \text{以外の項は}\ u_j=v_j\ \text{より}\ 0)\\
&\in\{+1,-1\}
&&(\because\ |u_i-v_i|=1)
\end{aligned}`,
      ),
      paragraph([
        "二つの整数の差が奇数なので、両者の偶奇は異なる。",
      ]),
    ],
  },

  {
    id: "null_model_definition_odd_sites",
    kind: "definition",
    title: { text: "座標和が奇数の格子点の集合" },
    labels: ["def_odd_sites"],
    habitat: "Z",
    statement: [
      displayMath(
        String.raw`V^{\mathrm{odd}}_L=\{\,u\in V_L\ :\ u_1+u_2+u_3\ \text{は奇数}\,\}`,
      ),
      paragraph([
        "と置く。",
        math(String.raw`V^{\mathrm{odd}}_L`),
        " は ",
        math(String.raw`V_L`),
        " の部分集合である。",
      ]),
    ],
  },

  {
    id: "null_model_definition_odd_flip",
    kind: "definition",
    title: { text: "奇数側だけ反転する写像" },
    labels: ["def_odd_flip"],
    habitat: "Z",
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`T:\Sigma_L\to\Sigma_L`),
        " を、配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " と格子点 ",
        math(String.raw`u\in V_L`),
        " に対して",
      ]),
      displayMath(
        String.raw`(T\sigma)(u)=\begin{cases}-\sigma(u)&(u\in V^{\mathrm{odd}}_L)\\ \sigma(u)&(u\in V_L\setminus V^{\mathrm{odd}}_L)\end{cases}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`\sigma`),
        " の値は ",
        math(String.raw`\{+1,-1\}`),
        " に属し、",
        math(String.raw`-(+1)=-1`),
        "、",
        math(String.raw`-(-1)=+1`),
        " なので、",
        math(String.raw`T\sigma`),
        " は確かに ",
        math(String.raw`\Sigma_L`),
        " の元である（",
        ref("def_configuration"),
        " の前段）。",
      ]),
    ],
  },

  {
    id: "null_model_claim_odd_flip_involution",
    kind: "claim",
    title: { text: "奇数側だけ反転する写像は全単射である" },
    labels: ["claim_odd_flip_involution"],
    habitat: "Z",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について ",
        math(String.raw`T(T\sigma)=\sigma`),
        " が成り立つ。したがって ",
        math(String.raw`T`),
        " は全単射である。",
      ]),
    ],
    proof: [
      paragraph([
        "格子点 ",
        math(String.raw`u\in V_L`),
        " を任意に取り、場合を分ける。",
      ]),
      list([
        [
          math(String.raw`u\in V^{\mathrm{odd}}_L`),
          " のとき。",
          math(String.raw`(T(T\sigma))(u)=-(T\sigma)(u)=-(-\sigma(u))=\sigma(u)`),
          " である（",
          ref("def_odd_flip"),
          " を二回適用し、符号反転を二回すると元に戻る）。",
        ],
        [
          math(String.raw`u\in V_L\setminus V^{\mathrm{odd}}_L`),
          " のとき。",
          math(String.raw`(T(T\sigma))(u)=(T\sigma)(u)=\sigma(u)`),
          " である（",
          ref("def_odd_flip"),
          " を二回適用）。",
        ],
      ]),
      paragraph([
        "どの ",
        math(String.raw`u`),
        " でも値が一致するので写像として ",
        math(String.raw`T(T\sigma)=\sigma`),
        " である。よって ",
        math(String.raw`T`),
        " は自分自身を逆写像に持つ。逆写像を持つ写像は全単射である。",
      ]),
    ],
  },

  {
    id: "null_model_claim_odd_flip_reverses_edges",
    kind: "claim",
    title: { text: "奇数側だけ反転する写像は各内部辺の破れを反転する" },
    labels: ["claim_odd_flip_reverses_edges"],
    habitat: "Z",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`\sigma\in\Sigma_L`),
        " とすべての内部辺 ",
        math(String.raw`\{u,v\}\in E_L`),
        " について、",
        math(String.raw`(T\sigma)(u)\ne(T\sigma)(v)`),
        " と ",
        math(String.raw`\sigma(u)=\sigma(v)`),
        " は同値である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`u`),
        " と ",
        math(String.raw`v`),
        " は隣接する（",
        ref("def_inner_edges"),
        "）ので、座標和の偶奇が異なる（",
        ref("claim_adjacent_parity"),
        "）。よって一方だけが ",
        math(String.raw`V^{\mathrm{odd}}_L`),
        " に属する（",
        ref("def_odd_sites"),
        "）。記号を入れ替えても主張は ",
        math(String.raw`u`),
        " と ",
        math(String.raw`v`),
        " について対称なので、",
        math(String.raw`u\in V^{\mathrm{odd}}_L`),
        "、",
        math(String.raw`v\notin V^{\mathrm{odd}}_L`),
        " としてよい。このとき",
      ]),
      displayMath(
        String.raw`(T\sigma)(u)=-\sigma(u),\qquad (T\sigma)(v)=\sigma(v)\qquad(\because\ \blkref{def_odd_flip})`,
      ),
      paragraph([
        "である。値は ",
        math(String.raw`\{+1,-1\}`),
        " に属するので、",
        math(String.raw`-\sigma(u)\ne\sigma(v)`),
        " と ",
        math(String.raw`-\sigma(u)=-\sigma(v)`),
        " は同値であり、後者は両辺の符号を反転して ",
        math(String.raw`\sigma(u)=\sigma(v)`),
        " と同値である。",
      ]),
    ],
  },

  {
    id: "null_model_claim_free_broken_complement",
    kind: "claim",
    title: { text: "奇数側だけ反転すると自由境界の破れ数は補数になる" },
    labels: ["claim_free_broken_complement"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について",
      ]),
      displayMath(
        String.raw`m^{\mathrm{free}}_L(T\sigma)=\#E_L-m^{\mathrm{free}}_L(\sigma)`,
      ),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "破れている内部辺の集合を ",
        math(String.raw`D^{\mathrm{free}}(\sigma)=\{\,\{u,v\}\in E_L\ :\ \sigma(u)\ne\sigma(v)\,\}`),
        " と書く（",
        ref("def_free_broken_count"),
        " の数えている集合である）。各内部辺 ",
        math(String.raw`\{u,v\}\in E_L`),
        " について、",
        math(String.raw`(T\sigma)(u)\ne(T\sigma)(v)`),
        " と ",
        math(String.raw`\sigma(u)=\sigma(v)`),
        " は同値（",
        ref("claim_odd_flip_reverses_edges"),
        "）なので、",
        math(String.raw`\{u,v\}\in D^{\mathrm{free}}(T\sigma)`),
        " と ",
        math(String.raw`\{u,v\}\notin D^{\mathrm{free}}(\sigma)`),
        " は同値である。すなわち",
      ]),
      displayMath(
        String.raw`D^{\mathrm{free}}(T\sigma)=E_L\setminus D^{\mathrm{free}}(\sigma)`,
      ),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
m^{\mathrm{free}}_L(T\sigma)
&=\#D^{\mathrm{free}}(T\sigma)
&&(\because\ \blkref{def_free_broken_count})\\
&=\#\bigl(E_L\setminus D^{\mathrm{free}}(\sigma)\bigr)
&&(\because\ \text{前段の集合の等式})\\
&=\#E_L-\#D^{\mathrm{free}}(\sigma)
&&(\because\ \text{有限集合の部分集合の補集合の元の個数})\\
&=\#E_L-m^{\mathrm{free}}_L(\sigma)
&&(\because\ \blkref{def_free_broken_count})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
  },

  {
    id: "null_model_claim_free_palindrome",
    kind: "claim",
    title: { text: "自由境界の多重度は回文である" },
    labels: ["claim_free_palindrome"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての自然数 ",
        math(String.raw`m`),
        " について",
      ]),
      displayMath(
        String.raw`\Omega^{\mathrm{free}}_L(m)=\Omega^{\mathrm{free}}_L(\#E_L-m)`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`m>\#E_L`),
        " のときは両辺とも ",
        math(String.raw`0`),
        " であり、右辺の引数は自然数の範囲を出るが、そのときは対応する配位が無いので ",
        math(String.raw`\Omega^{\mathrm{free}}_L`),
        " の値を ",
        math(String.raw`0`),
        " と読む）。",
      ]),
    ],
    proof: [
      paragraph([
        "自然数 ",
        math(String.raw`m`),
        " を固定し、",
        math(String.raw`S_m=\{\,\sigma\in\Sigma_L\ :\ m^{\mathrm{free}}_L(\sigma)=m\,\}`),
        " と置く（",
        math(String.raw`\Omega^{\mathrm{free}}_L(m)=\#S_m`),
        " である。",
        ref("def_free_multiplicity"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\sigma\in S_m`),
        " ならば ",
        math(String.raw`m^{\mathrm{free}}_L(T\sigma)=\#E_L-m`),
        "（",
        ref("claim_free_broken_complement"),
        "）なので ",
        math(String.raw`T\sigma\in S_{\#E_L-m}`),
        " である。すなわち ",
        math(String.raw`T`),
        " は ",
        math(String.raw`S_m`),
        " から ",
        math(String.raw`S_{\#E_L-m}`),
        " への写像を定める。同じ理由で ",
        math(String.raw`T`),
        " は ",
        math(String.raw`S_{\#E_L-m}`),
        " から ",
        math(String.raw`S_{m}`),
        " への写像も定める（",
        math(String.raw`\#E_L-(\#E_L-m)=m`),
        "）。",
      ]),
      paragraph([
        "この二つの写像は互いに逆である（",
        math(String.raw`T(T\sigma)=\sigma`),
        "。",
        ref("claim_odd_flip_involution"),
        "）。逆写像を持つ写像は全単射なので、",
        math(String.raw`S_m`),
        " と ",
        math(String.raw`S_{\#E_L-m}`),
        " のあいだに全単射がある。有限集合のあいだに全単射があれば元の個数は等しいので ",
        math(String.raw`\#S_m=\#S_{\#E_L-m}`),
        "、すなわち主張の等式が成り立つ。",
      ]),
    ],
  },

  {
    id: "positioning_remark_demoted_target",
    kind: "remark",
    title: { text: "この文書の位置づけ（降格した従属標的）" },
    labels: ["remark_demoted_positioning"],
    habitat: "none",
    statement: [
      paragraph([
        "この文書の以下の全章は、プロジェクトが当初本体に据えていた枠組み",
        "「有限の証拠で臨界点の切断を定める」に属する。この枠組みは、",
        "有限の証拠と模型を結ぶ定理（有限の箱ごとの主張の族から、許される唯一の脱出である",
        "箱の大きさの極限を一回だけ使って無限体積の言明へ渡す定理。健全性の橋と呼ぶ）が",
        "無いまま置かれているため、従属標的へ降格した。",
        "橋が架かるまで、この文書の主張は証拠の存在で定義された有理数の集合についての主張であり、",
        "模型の相転移と結びついていない。",
      ]),
      paragraph([
        "プロジェクトの主標的は可算コアの同定（有限格子の可算データの上で、極限で効く部分と",
        "極限で潰れる部分を分離すること）へ移した。既知の欠陥は低温側の証拠の章の冒頭の注記",
        ref("remark_known_defects"),
        " に列挙する。個々の定義と証明済みの主張はその範囲では正しいので、そのまま残す。",
      ]),
    ],
  },

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
    ],
  },

  {
    id: "separating_set_definition_minimal_separating_set",
    kind: "definition",
    title: { text: "極小分離集合" },
    labels: ["def_minimal_separating_set"],
    habitat: "N",
    statement: [
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
        "）。",
      ]),
      paragraph([
        "次に、",
        math(String.raw`D(\sigma)`),
        " の部分集合であって分離集合であるものの全体を考える。",
        math(String.raw`D(\sigma)`),
        " は有限集合なので部分集合は有限個であり、この全体は有限の族である。前段より ",
        math(String.raw`D(\sigma)`),
        " 自身が属するので空でない。その中で元の個数が最小のものを一つ取り ",
        math(String.raw`F`),
        " と置く。",
        math(String.raw`F`),
        " の任意の真部分集合は、元の個数が ",
        math(String.raw`F`),
        " より少なく、かつ ",
        math(String.raw`D(\sigma)`),
        " の部分集合なので、個数の最小性より分離集合でない。よって ",
        math(String.raw`F`),
        " は極小分離集合であり（",
        ref("def_minimal_separating_set"),
        "）、",
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
    id: "separating_set_definition_reachable_set",
    kind: "definition",
    title: { text: "辺集合を避けた到達集合" },
    labels: ["def_reachable_set"],
    habitat: "N",
    statement: [
      paragraph([
        "辺の集合 ",
        math(String.raw`F\subseteq E_L\cup B_L`),
        " に対し、次を満たす格子点 ",
        math(String.raw`u\in V_L`),
        " の全体を ",
        math(String.raw`W_F\subseteq V_L`),
        " と書き、",
        math(String.raw`F`),
        " を避けた到達集合と呼ぶ。ある整数 ",
        math(String.raw`k\ge0`),
        " と格子点の列 ",
        math(String.raw`(v_0,v_1,\dots,v_k)`),
        " が存在して、次の四つが成り立つ。",
      ]),
      list([
        [math(String.raw`v_0=o`), " かつ ", math(String.raw`v_k=u`), " である。"],
        [
          math(String.raw`0\le j\le k`),
          " のすべての ",
          math(String.raw`j`),
          " について ",
          math(String.raw`v_j\in V_L`),
          " である。",
        ],
        [
          math(String.raw`0\le j\le k-1`),
          " のすべての ",
          math(String.raw`j`),
          " について ",
          math(String.raw`v_j`),
          " と ",
          math(String.raw`v_{j+1}`),
          " は隣接する。",
        ],
        [
          math(String.raw`0\le j\le k-1`),
          " のすべての ",
          math(String.raw`j`),
          " について ",
          math(String.raw`\{v_j,v_{j+1}\}\notin F`),
          " である。",
        ],
      ]),
      paragraph([
        math(String.raw`k=0`),
        " の列 ",
        math(String.raw`(o)`),
        " は四つの条件をすべて満たす（後の三つは範囲が空なので成り立つ）ので、どの ",
        math(String.raw`F`),
        " についても ",
        math(String.raw`o\in W_F`),
        " である。",
      ]),
    ],
  },

  {
    id: "separating_set_definition_edge_boundary",
    kind: "definition",
    title: { text: "格子点の集合の辺境界" },
    labels: ["def_edge_boundary"],
    habitat: "N",
    statement: [
      paragraph([
        "格子点の集合 ",
        math(String.raw`W\subseteq V_L`),
        " に対し",
      ]),
      displayMath(
        String.raw`\partial W=\{\,\{u,v\}\in E_L\ :\ u\in W,\ v\in V_L\setminus W\,\}
\ \cup\ \{\,\{u,w\}\in B_L\ :\ u\in W\,\}`,
      ),
      paragraph([
        "と置き、",
        math(String.raw`W`),
        " の辺境界と呼ぶ。",
        math(String.raw`\partial W`),
        " は ",
        math(String.raw`E_L\cup B_L`),
        " の部分集合であり、有限集合である。",
      ]),
    ],
  },

  {
    id: "separating_set_claim_edge_boundary_is_separating",
    kind: "claim",
    title: { text: "到達集合の辺境界は分離集合である" },
    labels: ["claim_edge_boundary_is_separating"],
    habitat: "N",
    statement: [
      paragraph([
        "どの辺の集合 ",
        math(String.raw`F\subseteq E_L\cup B_L`),
        " についても、",
        math(String.raw`\partial W_F`),
        " は分離集合である。",
      ]),
    ],
    proof: [
      paragraph([
        "原点から箱の外へ至る道 ",
        math(String.raw`(v_0,\dots,v_k)`),
        " を任意に取る（",
        ref("def_path"),
        "）。集合 ",
        math(String.raw`M=\{\,m\ :\ 0\le m\le k,\ v_m\notin W_F\,\}`),
        " を考える。",
        math(String.raw`v_k\in\Lambda_{\mathrm{site}}\setminus V_L`),
        " かつ ",
        math(String.raw`W_F\subseteq V_L`),
        "（",
        ref("def_reachable_set"),
        "）なので ",
        math(String.raw`v_k\notin W_F`),
        "、すなわち ",
        math(String.raw`k\in M`),
        " であり、",
        math(String.raw`M`),
        " は空でない。",
        math(String.raw`M`),
        " は自然数の空でない有限集合なので最小の元を持つ。それを ",
        math(String.raw`m`),
        " と置く。",
      ]),
      paragraph([
        math(String.raw`v_0=o\in W_F`),
        "（",
        ref("def_reachable_set"),
        " の後段）なので ",
        math(String.raw`0\notin M`),
        "、すなわち ",
        math(String.raw`m\ge1`),
        " である。",
        math(String.raw`m`),
        " の最小性より ",
        math(String.raw`m-1\notin M`),
        "、すなわち ",
        math(String.raw`v_{m-1}\in W_F`),
        " である。辺 ",
        math(String.raw`e=\{v_{m-1},v_m\}`),
        " について場合を分ける。",
      ]),
      list([
        [
          math(String.raw`v_m\in V_L`),
          " のとき。",
          math(String.raw`v_{m-1}\in W_F\subseteq V_L`),
          " と ",
          math(String.raw`v_m\in V_L`),
          " と隣接性より ",
          math(String.raw`e\in E_L`),
          "（",
          ref("def_inner_edges"),
          "）。さらに ",
          math(String.raw`v_{m-1}\in W_F`),
          " かつ ",
          math(String.raw`v_m\in V_L\setminus W_F`),
          "（",
          math(String.raw`m\in M`),
          "）なので ",
          math(String.raw`e\in\partial W_F`),
          " である（",
          ref("def_edge_boundary"),
          "）。",
        ],
        [
          math(String.raw`v_m\notin V_L`),
          " のとき。",
          math(String.raw`v_{m-1}\in W_F\subseteq V_L`),
          " と隣接性より ",
          math(String.raw`e\in B_L`),
          "（",
          ref("def_boundary_edges"),
          "）。",
          math(String.raw`v_{m-1}\in W_F`),
          " なので ",
          math(String.raw`e\in\partial W_F`),
          " である（",
          ref("def_edge_boundary"),
          "）。",
        ],
      ]),
      paragraph([
        "どちらの場合も、道が通る辺の中に ",
        math(String.raw`\partial W_F`),
        " の元がある。道は任意だったので ",
        math(String.raw`\partial W_F`),
        " は分離集合である（",
        ref("def_separating_set"),
        "）。",
      ]),
    ],
  },

  {
    id: "separating_set_claim_separating_contains_edge_boundary",
    kind: "claim",
    title: { text: "分離集合は自分を避けた到達集合の辺境界を含む" },
    labels: ["claim_separating_contains_edge_boundary"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`F\subseteq E_L\cup B_L`),
        " が分離集合ならば ",
        math(String.raw`\partial W_F\subseteq F`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`e\in\partial W_F`),
        " を任意に取り、",
        math(String.raw`e\notin F`),
        " と仮定して矛盾を導く。",
        ref("def_edge_boundary"),
        " より次の二つの場合がある。",
      ]),
      list([
        [
          math(String.raw`e=\{u,v\}\in E_L`),
          "、",
          math(String.raw`u\in W_F`),
          "、",
          math(String.raw`v\in V_L\setminus W_F`),
          " のとき。",
          math(String.raw`u\in W_F`),
          " なので、",
          ref("def_reachable_set"),
          " の四条件を満たす列 ",
          math(String.raw`(v_0,\dots,v_k)`),
          "（",
          math(String.raw`v_k=u`),
          "）が取れる。列 ",
          math(String.raw`(v_0,\dots,v_k,v)`),
          " は、",
          math(String.raw`v\in V_L`),
          "、",
          math(String.raw`u`),
          " と ",
          math(String.raw`v`),
          " の隣接性、",
          math(String.raw`\{u,v\}=e\notin F`),
          " より、やはり四条件を満たす。よって ",
          math(String.raw`v\in W_F`),
          " となり ",
          math(String.raw`v\in V_L\setminus W_F`),
          " に矛盾する。",
        ],
        [
          math(String.raw`e=\{u,w\}\in B_L`),
          "、",
          math(String.raw`u\in W_F`),
          " のとき。",
          math(String.raw`u\in W_F`),
          " なので、",
          ref("def_reachable_set"),
          " の四条件を満たす列 ",
          math(String.raw`(v_0,\dots,v_k)`),
          "（",
          math(String.raw`v_k=u`),
          "）が取れる。列 ",
          math(String.raw`(v_0,\dots,v_k,w)`),
          " は原点から箱の外へ至る道である（",
          ref("def_path"),
          "。",
          math(String.raw`w\in\Lambda_{\mathrm{site}}\setminus V_L`),
          " は ",
          ref("def_boundary_edges"),
          " による）。この道が通る辺は ",
          math(String.raw`\{v_0,v_1\},\dots,\{v_{k-1},v_k\}`),
          "（いずれも ",
          math(String.raw`F`),
          " に属さない）と ",
          math(String.raw`e`),
          "（仮定より ",
          math(String.raw`F`),
          " に属さない）だけである。よってこの道は ",
          math(String.raw`F`),
          " の元を一つも通らず、",
          math(String.raw`F`),
          " が分離集合であること（",
          ref("def_separating_set"),
          "）に矛盾する。",
        ],
      ]),
      paragraph([
        "どちらの場合も矛盾したので ",
        math(String.raw`e\in F`),
        " である。",
        math(String.raw`e`),
        " は任意だったので ",
        math(String.raw`\partial W_F\subseteq F`),
        " である。",
      ]),
    ],
  },

  {
    id: "separating_set_claim_minimal_separating_is_edge_boundary",
    kind: "claim",
    title: { text: "極小分離集合は自分を避けた到達集合の辺境界に等しい" },
    labels: ["claim_minimal_separating_is_edge_boundary"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`F\subseteq E_L\cup B_L`),
        " が極小分離集合ならば ",
        math(String.raw`F=\partial W_F`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`F`),
        " は分離集合なので ",
        math(String.raw`\partial W_F\subseteq F`),
        " である（",
        ref("claim_separating_contains_edge_boundary"),
        "）。一方 ",
        math(String.raw`\partial W_F`),
        " は分離集合である（",
        ref("claim_edge_boundary_is_separating"),
        "）。",
      ]),
      paragraph([
        "もし ",
        math(String.raw`\partial W_F\ne F`),
        " ならば、",
        math(String.raw`\partial W_F`),
        " は ",
        math(String.raw`F`),
        " の真部分集合であって分離集合であることになり、",
        math(String.raw`F`),
        " が極小分離集合であること（",
        ref("def_minimal_separating_set"),
        "）に矛盾する。よって ",
        math(String.raw`F=\partial W_F`),
        " である。",
      ]),
    ],
  },

  {
    id: "dual_face_heading",
    kind: "heading",
    level: 1,
    title: { text: "格子辺に双対な面" },
    labels: [],
  },

  {
    id: "dual_face_definition_coordinate_vectors",
    kind: "definition",
    title: { text: "三つの座標単位ベクトル" },
    labels: ["def_coordinate_unit_vectors"],
    habitat: "Z",
    statement: [
      displayMath(
        String.raw`\varepsilon_1=(1,0,0),\qquad
\varepsilon_2=(0,1,0),\qquad
\varepsilon_3=(0,0,1)\qquad\in\mathbb{Z}^3`,
      ),
      paragraph(["と置く。"]),
    ],
  },

  {
    id: "dual_face_claim_oriented_edge_data",
    kind: "claim",
    title: { text: "格子辺の向きと始点は一意に定まる" },
    labels: ["claim_oriented_edge_data"],
    habitat: "Z",
    statement: [
      paragraph([
        "どの辺 ",
        math(String.raw`e\in E_L\cup B_L`),
        " に対しても、",
        math(String.raw`a(e)\in\mathbb{Z}^3`),
        " と ",
        math(String.raw`i(e)\in\{1,2,3\}`),
        " の組で",
      ]),
      displayMath(String.raw`e=\{a(e),a(e)+\varepsilon_{i(e)}\}`),
      paragraph(["を満たすものがただ一つ存在する。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`e=\{u,v\}`),
        " と書く。",
        ref("def_inner_edges"),
        " と ",
        ref("def_boundary_edges"),
        " より、",
        math(String.raw`u,v\in\mathbb{Z}^3`),
        " は隣接する。",
        ref("def_site_set"),
        " の等式では三つの非負整数の和が ",
        math(String.raw`1`),
        " なので、ただ一つの添字 ",
        math(String.raw`i\in\{1,2,3\}`),
        " について ",
        math(String.raw`|u_i-v_i|=1`),
        " であり、他の二つの座標差は ",
        math(String.raw`0`),
        " である。",
      ]),
      paragraph([
        math(String.raw`u_i<v_i`),
        " なら ",
        math(String.raw`a(e)=u`),
        " とし、",
        math(String.raw`v_i<u_i`),
        " なら ",
        math(String.raw`a(e)=v`),
        " とする。このとき ",
        math(String.raw`e=\{a(e),a(e)+\varepsilon_i\}`),
        " である。差が零でない座標と、その座標が小さい端点はいずれも一意なので、組 ",
        math(String.raw`(a(e),i(e))`),
        " は一意である。",
      ]),
    ],
  },

  {
    id: "dual_face_definition_vertex_set",
    kind: "definition",
    title: { text: "格子辺に双対な面の頂点集合" },
    labels: ["def_dual_face_vertex_set"],
    habitat: "Q",
    verification: ["sagemath/check/dual-face-vertex-set"],
    statement: [
      paragraph([
        "辺 ",
        math(String.raw`e\in E_L\cup B_L`),
        " を取り、",
        ref("claim_oriented_edge_data"),
        " の ",
        math(String.raw`a(e)`),
        " と ",
        math(String.raw`i(e)`),
        " を用いる。",
        math(String.raw`\{j,k\}=\{1,2,3\}\setminus\{i(e)\}`),
        " として",
      ]),
      displayMath(
        String.raw`P(e)=\left\{\,
a(e)+\frac12\varepsilon_{i(e)}
+\frac{s}{2}\varepsilon_j
+\frac{t}{2}\varepsilon_k
\ :\ s,t\in\{-1,+1\}\,\right\}\subset\mathbb{Q}^3`,
      ),
      paragraph([
        "と置き、",
        math(String.raw`P(e)`),
        " を ",
        math(String.raw`e`),
        " に双対な面の頂点集合と呼ぶ。",
        math(String.raw`j`),
        " と ",
        math(String.raw`k`),
        " を入れ替えても、",
        math(String.raw`(s,t)`),
        " の走る四つの組が入れ替わるだけなので、集合 ",
        math(String.raw`P(e)`),
        " は変わらない。ここでは連続な正方形を導入せず、四つの有理座標だけを面として扱う。",
      ]),
    ],
  },

  {
    id: "dual_face_claim_four_vertices",
    kind: "claim",
    title: { text: "双対な面の頂点は四つである" },
    labels: ["claim_dual_face_four_vertices"],
    habitat: "N",
    verification: ["sagemath/check/dual-face-vertex-set"],
    statement: [
      paragraph([
        "どの辺 ",
        math(String.raw`e\in E_L\cup B_L`),
        " についても ",
        math(String.raw`\#P(e)=4`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_dual_face_vertex_set"),
        " の右辺で、",
        math(String.raw`s`),
        " は第 ",
        math(String.raw`j`),
        " 座標を、",
        math(String.raw`t`),
        " は第 ",
        math(String.raw`k`),
        " 座標をそれぞれ ",
        math(String.raw`1`),
        " だけ異ならせる。したがって四つの組 ",
        math(String.raw`(s,t)\in\{-1,+1\}^2`),
        " は互いに異なる四つの点を与える。",
      ]),
    ],
  },

  {
    id: "dual_face_definition_adjacency",
    kind: "definition",
    title: { text: "双対な面の面隣接" },
    labels: ["def_dual_face_adjacency"],
    habitat: "N",
    verification: ["sagemath/check/dual-face-vertex-set"],
    statement: [
      paragraph([
        "二つの辺 ",
        math(String.raw`e,f\in E_L\cup B_L`),
        " に対し、",
        math(String.raw`\#(P(e)\cap P(f))=2`),
        " であるとき、",
        math(String.raw`P(e)`),
        " と ",
        math(String.raw`P(f)`),
        " は面隣接するという。これは有限な二つの部分集合の共通部分の元の個数についての等式である。",
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
        "未証明。極小分離集合が到達集合の辺境界に等しいことは、" +
          "本文の主張「極小分離集合は自分を避けた到達集合の辺境界に等しい」で示した。" +
          "残る作業は次の二つである。" +
          "(1) 辺境界に双対な面の集合が面隣接で連結であることを示す。" +
          "(2) 指定した一面から順に辿る対応で個数を上から抑え、定数 C を具体的な自然数として決める" +
          "（Peierls の輪郭の数え上げに当たる）。",
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
    id: "low_temperature_certificate_remark_known_defects",
    kind: "remark",
    title: { text: "この章の既知の欠陥（直すまで本体へ戻さない）" },
    labels: ["remark_known_defects"],
    habitat: "none",
    statement: [
      paragraph([
        "この章の枠組みには、",
        ref("remark_demoted_positioning"),
        " で述べた健全性の橋の不在に加えて、次の三つの欠陥があることが分かっている",
        "（2026-08-13 の外部レビューによる。経緯は方針文書",
        "「有限の証拠で臨界点の切断を定める」に記録してある）。",
      ]),
      list([
        [
          "観測点が箱の角にある。",
          ref("def_box"),
          " は箱を ",
          math(String.raw`0\le u_i\le L-1`),
          " と置き、観測点である原点 ",
          math(String.raw`o=(0,0,0)`),
          " は三つの座標方向すべてで箱の境界に接している。境界の影響が支配的で、",
          "箱の内部の点についての量になっていない。箱を原点について対称に取り直すか、",
          "観測点と境界の隔たりが箱とともに増える形へ直す必要がある。",
        ],
        [
          "証拠の定義が有限の検査になっていない。",
          ref("def_low_temperature_certificate"),
          " の二つ目の条件は、すべての整数 ",
          math(String.raw`L\ge1`),
          " とすべての自然数 ",
          math(String.raw`n`),
          " にわたる主張（",
          ref("claim_minimal_separating_growth"),
          "。未証明）であり、有限個の演算で判定できない。数え上げの上界は具体的な定数を持つ",
          "一度きりの定理として分離し、証拠の判定は有理数の不等式だけにする必要がある。",
          "分離するまで、",
          ref("def_low_temperature_rational_points"),
          " の集合が空でないことも示せていない。",
        ],
        [
          "上界が低温側を特徴づけていない。",
          ref("claim_certificate_gives_uniform_bound"),
          " の上界 ",
          math(String.raw`\tfrac12`),
          " は、証拠の付かない有理数の側でも同じ値が上界になりうる形であり、",
          "低温側だけを切り出せていない。有理数の隔たり ",
          math(String.raw`\delta>0`),
          " を伴う ",
          math(String.raw`\tfrac12-\delta`),
          " 以下の形の上界が要る。",
        ],
      ]),
    ],
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
&=\sum_{n=1}^{N}r^{\,n}-r\cdot\sum_{n=1}^{N}r^{\,n}
&&(\because\ \text{分配則})\\
&=\sum_{n=1}^{N}r^{\,n}-\sum_{n=1}^{N}r^{\,n+1}
&&(\because\ r\cdot r^{\,n}=r^{\,n+1}\ \text{（冪の法則）を各項へ同時適用})\\
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
        [math(String.raw`C\ge1`), " かつ ", math(String.raw`0<q<1`), " である。"],
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
        "証拠の一つ目の条件から ",
        math(String.raw`C\ge1`),
        " かつ ",
        math(String.raw`q>0`),
        " なので ",
        math(String.raw`Cq>0`),
        " である。三つ目の条件 ",
        math(String.raw`3Cq\le1`),
        " の両辺を正の数 ",
        math(String.raw`3`),
        " で割ると ",
        math(String.raw`Cq\le\tfrac13`),
        " である。よって ",
        math(String.raw`r=Cq`),
        " と置くと ",
        math(String.raw`0<r\le\tfrac13<1`),
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
&\le\frac{1/3}{1-r}
&&(\because\ r\le\tfrac13\ \text{と}\ 1-r>0\text{。正の分母の分数は分子を大きくすると増えるか等しい})\\
&\le\frac{1/3}{2/3}
&&(\because\ r\le\tfrac13\ \text{より}\ 1-r\ge\tfrac23>0\text{。正の分子の分数は分母を小さくすると増えるか等しい})\\
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
