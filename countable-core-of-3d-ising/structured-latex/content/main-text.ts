/**
 * 本文（章は見出しブロックで区切る）。
 *
 * この文書は主標的（可算コアの同定）だけで構成する。現在の内容は帰無モデルの最初の部分であり、
 * 有限箱の族について二部性からの回文性を証明している。
 *
 * 当初本体に据えていた枠組み「有限の証拠で臨界点の切断を定める」の章は、2026-08-14 に
 * `_old/demoted-critical-point-cut/` へ退避した（降格の理由と既知の欠陥はそこの README にある）。
 *
 * 立場（プロジェクト README が正本）:
 *   - 非可算へ出てよいのは、有限格子の量の列について箱の大きさを大きくする極限だけである。
 *     この文書には極限が 1 度も現れない。
 *   - **登場する集合はすべて有限である。** 無限格子（$\mathbb{Z}^3$ など）を土台に置かない。
 *     必要になったときに、必要な理由を書いてから導入する。
 *   - 相・臨界温度・自発磁化といった無限体積の語を主張に使わない。
 *   - 無限和・級数を書かない。有限和と、箱の大きさに依らない一様な有理数の不等式だけを使う。
 *
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_box_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限箱・辺・配位" },
    labels: [],
  },

  {
    id: "finite_box_definition_box",
    kind: "definition",
    title: { text: "一辺の長さ L の箱（有限集合）" },
    labels: ["def_box"],
    habitat: "Z",
    statement: [
      paragraph([
        "整数 ",
        math(String.raw`L\ge2`),
        " を固定する。整数の有限集合 ",
        math(String.raw`I_L=\{0,1,\dots,L-1\}`),
        " を使って",
      ]),
      displayMath(String.raw`V_L=I_L\times I_L\times I_L`),
      paragraph([
        "と置き、箱と呼ぶ。",
        math(String.raw`V_L`),
        " は有限集合であり ",
        math(String.raw`\#V_L=L\cdot L\cdot L`),
        " である。元 ",
        math(String.raw`a\in V_L`),
        " を ",
        math(String.raw`a=(a_1,a_2,a_3)`),
        " と書き、各 ",
        math(String.raw`a_i`),
        " は ",
        math(String.raw`I_L`),
        " の元（整数）である。",
      ]),
      paragraph([
        "**無限格子を土台に置かない。** この文書に現れる点はすべて ",
        math(String.raw`V_L`),
        " の元である。箱の外側の点も、外側への辺も導入しない（必要になった時点で、",
        "必要な理由を書いてから導入する）。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_edge_set",
    kind: "definition",
    title: { text: "辺の集合（始点と方向の組の有限集合）" },
    labels: ["def_edge_set"],
    habitat: "N",
    statement: [
      paragraph(["有限集合"]),
      displayMath(
        String.raw`E_L=\{\,(a,i)\ :\ a\in V_L,\ i\in\{1,2,3\},\ a_i\le L-2\,\}`,
      ),
      paragraph([
        "を辺の集合と呼ぶ。**辺は点の集合ではなく、始点と方向の組である。**",
        "格子の形を担うのは、次に定める端点写像だけであり、",
        math(String.raw`E_L`),
        " の定義には点の対が現れない。",
      ]),
      paragraph([
        math(String.raw`\#E_L=3\cdot L\cdot L\cdot(L-1)`),
        " である（方向 ",
        math(String.raw`i`),
        " ごとに、第 ",
        math(String.raw`i`),
        " 成分が ",
        math(String.raw`L-1`),
        " 通りのうち ",
        math(String.raw`L-2`),
        " 以下の ",
        math(String.raw`L-1`),
        " 通り、他の二成分が ",
        math(String.raw`L`),
        " 通りずつ）。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_endpoint_maps",
    kind: "definition",
    title: { text: "端点写像" },
    labels: ["def_endpoint_maps"],
    habitat: "Z",
    statement: [
      paragraph([
        "方向 ",
        math(String.raw`i\in\{1,2,3\}`),
        " に対し、第 ",
        math(String.raw`i`),
        " 成分が ",
        math(String.raw`1`),
        "、他の二成分が ",
        math(String.raw`0`),
        " である三つ組を ",
        math(String.raw`\varepsilon_i`),
        " と書く。二つの写像",
      ]),
      displayMath(
        String.raw`\partial_0:E_L\to V_L,\qquad \partial_0(a,i)=a,\qquad
\partial_1:E_L\to V_L,\qquad \partial_1(a,i)=a+\varepsilon_i`,
      ),
      paragraph([
        "を端点写像と呼ぶ。ここで ",
        math(String.raw`a+\varepsilon_i`),
        " は成分ごとの整数の和である。",
      ]),
      paragraph([
        math(String.raw`\partial_1`),
        " の値が ",
        math(String.raw`V_L`),
        " に属することは次から従う。",
        math(String.raw`(a,i)\in E_L`),
        " なら ",
        math(String.raw`a_i\le L-2`),
        " なので第 ",
        math(String.raw`i`),
        " 成分は ",
        math(String.raw`a_i+1\le L-1`),
        " であり、また ",
        math(String.raw`0\le a_i`),
        " から ",
        math(String.raw`0\le a_i+1`),
        " である。他の二成分は変わらない（",
        ref("def_edge_set"),
        "）。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_configuration",
    kind: "definition",
    title: { text: "配位" },
    labels: ["def_configuration"],
    habitat: "Z",
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`\sigma:V_L\to\{+1,-1\}`),
        " を配位と呼び、配位全体の集合を ",
        math(String.raw`\Sigma_L`),
        " と書く。",
        math(String.raw`\Sigma_L`),
        " は有限集合であり ",
        math(String.raw`\#\Sigma_L=2^{\#V_L}`),
        " である。",
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
        " に対し、破れている辺の集合と破れ数を",
      ]),
      displayMath(
        String.raw`D_L(\sigma)=\{\,e\in E_L\ :\ \sigma(\partial_0 e)\ne\sigma(\partial_1 e)\,\},\qquad
m_L(\sigma)=\#D_L(\sigma)\in\mathbb{N}`,
      ),
      paragraph([
        "と置く。数える範囲は ",
        math(String.raw`E_L`),
        " だけである（",
        ref("def_edge_set"),
        "）。両端の値は端点写像で取り出す（",
        ref("def_endpoint_maps"),
        "）。",
      ]),
    ],
  },

  {
    id: "finite_box_definition_multiplicity",
    kind: "definition",
    title: { text: "多重度" },
    labels: ["def_multiplicity"],
    habitat: "N",
    statement: [
      paragraph(["自然数 ", math(String.raw`m`), " に対し"]),
      displayMath(
        String.raw`\Omega_L(m)=\#\{\,\sigma\in\Sigma_L\ :\ m_L(\sigma)=m\,\}\ \in\ \mathbb{N}`,
      ),
      paragraph([
        "と置き、多重度と呼ぶ。",
        math(String.raw`m>\#E_L`),
        " のとき ",
        math(String.raw`\Omega_L(m)=0`),
        " である（",
        math(String.raw`m_L(\sigma)\le\#E_L`),
        " なので、条件を満たす配位が無い）。",
      ]),
    ],
  },

  {
    id: "null_model_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 二部性からの回文性" },
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
        "箱の構造から強制される部分（帰無モデル）を証明して分離する。",
        "強制された構造をあとから発見と呼ばないためである。",
      ]),
      paragraph([
        "この章で示す回文性は、境界の外を持たない族（",
        ref("def_box"),
        " の箱と ",
        ref("def_edge_set"),
        " の辺だけを使う族）についての主張である。",
        "別の族（外側に値を固定する族、辺を周期的に巻く族）を扱うときは、",
        "その族の定義を別に置き、量にも別の記号を与える。**族を混ぜて比べない。**",
      ]),
    ],
  },

  {
    id: "null_model_claim_edge_endpoints_parity",
    kind: "claim",
    title: { text: "辺の両端の座標和の偶奇は異なる" },
    labels: ["claim_edge_endpoints_parity"],
    habitat: "Z",
    statement: [
      paragraph([
        "すべての辺 ",
        math(String.raw`e\in E_L`),
        " について、整数 ",
        math(String.raw`s(\partial_0 e)`),
        " と ",
        math(String.raw`s(\partial_1 e)`),
        " の偶奇は異なる。ここで ",
        math(String.raw`s(a)=a_1+a_2+a_3`),
        " は座標の和である。",
      ]),
    ],
    proof: [
      paragraph([
        "辺を ",
        math(String.raw`e=(a,i)`),
        " と書く（",
        ref("def_edge_set"),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
s(\partial_1 e)-s(\partial_0 e)
&=s(a+\varepsilon_i)-s(a)
&&(\because\ \blkref{def_endpoint_maps})\\
&=\sum_{j=1}^{3}\bigl((a+\varepsilon_i)_j-a_j\bigr)
&&(\because\ \text{和の差は成分ごとの差の和})\\
&=\sum_{j=1}^{3}(\varepsilon_i)_j
&&(\because\ (a+\varepsilon_i)_j=a_j+(\varepsilon_i)_j)\\
&=1
&&(\because\ \varepsilon_i\ \text{は第}\ i\ \text{成分が}\ 1\ \text{で他は}\ 0)
\end{aligned}`,
      ),
      paragraph([
        "二つの整数の差が ",
        math(String.raw`1`),
        " なので、両者の偶奇は異なる。",
      ]),
    ],
  },

  {
    id: "null_model_definition_odd_sites",
    kind: "definition",
    title: { text: "座標和が奇数の点の集合" },
    labels: ["def_odd_sites"],
    habitat: "Z",
    statement: [
      displayMath(
        String.raw`V^{\mathrm{odd}}_L=\{\,a\in V_L\ :\ s(a)\ \text{は奇数}\,\}`,
      ),
      paragraph([
        "と置く（",
        math(String.raw`s(a)=a_1+a_2+a_3`),
        "）。これは有限集合 ",
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
        " と点 ",
        math(String.raw`a\in V_L`),
        " に対して",
      ]),
      displayMath(
        String.raw`(T\sigma)(a)=\begin{cases}-\sigma(a)&(a\in V^{\mathrm{odd}}_L)\\ \sigma(a)&(a\in V_L\setminus V^{\mathrm{odd}}_L)\end{cases}`,
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
        " は ",
        math(String.raw`\Sigma_L`),
        " の元である（",
        ref("def_configuration"),
        "）。",
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
        "点 ",
        math(String.raw`a\in V_L`),
        " を任意に取り、場合を分ける。",
      ]),
      list([
        [
          math(String.raw`a\in V^{\mathrm{odd}}_L`),
          " のとき。",
          math(String.raw`(T(T\sigma))(a)=-(T\sigma)(a)=-(-\sigma(a))=\sigma(a)`),
          " である（",
          ref("def_odd_flip"),
          " を二回適用し、符号反転を二回すると元に戻る）。",
        ],
        [
          math(String.raw`a\in V_L\setminus V^{\mathrm{odd}}_L`),
          " のとき。",
          math(String.raw`(T(T\sigma))(a)=(T\sigma)(a)=\sigma(a)`),
          " である（",
          ref("def_odd_flip"),
          " を二回適用）。",
        ],
      ]),
      paragraph([
        "どの ",
        math(String.raw`a`),
        " でも値が一致するので、写像として ",
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
    title: { text: "奇数側だけ反転する写像は各辺の破れを反転する" },
    labels: ["claim_odd_flip_reverses_edges"],
    habitat: "Z",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`\sigma\in\Sigma_L`),
        " とすべての辺 ",
        math(String.raw`e\in E_L`),
        " について、",
        math(String.raw`(T\sigma)(\partial_0 e)\ne(T\sigma)(\partial_1 e)`),
        " と ",
        math(String.raw`\sigma(\partial_0 e)=\sigma(\partial_1 e)`),
        " は同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "辺 ",
        math(String.raw`e`),
        " の両端の座標和の偶奇は異なる（",
        ref("claim_edge_endpoints_parity"),
        "）ので、両端のうちちょうど一方が ",
        math(String.raw`V^{\mathrm{odd}}_L`),
        " に属する（",
        ref("def_odd_sites"),
        "）。",
      ]),
      paragraph([
        "まず ",
        math(String.raw`\partial_0 e\in V^{\mathrm{odd}}_L`),
        " の場合を見る。このとき",
      ]),
      displayMath(
        String.raw`(T\sigma)(\partial_0 e)=-\sigma(\partial_0 e),\qquad
(T\sigma)(\partial_1 e)=\sigma(\partial_1 e)\qquad(\because\ \blkref{def_odd_flip})`,
      ),
      paragraph([
        "である。値は ",
        math(String.raw`\{+1,-1\}`),
        " に属するので、",
        math(String.raw`-\sigma(\partial_0 e)\ne\sigma(\partial_1 e)`),
        " と ",
        math(String.raw`-\sigma(\partial_0 e)=-\sigma(\partial_1 e)`),
        " は同値であり、後者は両辺の符号を反転して ",
        math(String.raw`\sigma(\partial_0 e)=\sigma(\partial_1 e)`),
        " と同値である。",
      ]),
      paragraph([
        "次に ",
        math(String.raw`\partial_1 e\in V^{\mathrm{odd}}_L`),
        " の場合を見る。このとき",
      ]),
      displayMath(
        String.raw`(T\sigma)(\partial_0 e)=\sigma(\partial_0 e),\qquad
(T\sigma)(\partial_1 e)=-\sigma(\partial_1 e)\qquad(\because\ \blkref{def_odd_flip})`,
      ),
      paragraph([
        "である。同じ理由で、",
        math(String.raw`\sigma(\partial_0 e)\ne-\sigma(\partial_1 e)`),
        " と ",
        math(String.raw`\sigma(\partial_0 e)=\sigma(\partial_1 e)`),
        " は同値である。",
      ]),
      paragraph([
        "両端のうちちょうど一方が奇数側なので、この二つで場合が尽きている。",
      ]),
    ],
  },

  {
    id: "null_model_claim_broken_complement",
    kind: "claim",
    title: { text: "奇数側だけ反転すると破れ数は補数になる" },
    labels: ["claim_broken_complement"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての ",
        math(String.raw`\sigma\in\Sigma_L`),
        " について",
      ]),
      displayMath(String.raw`m_L(T\sigma)=\#E_L-m_L(\sigma)`),
      paragraph(["が成り立つ。"]),
    ],
    proof: [
      paragraph([
        "各辺 ",
        math(String.raw`e\in E_L`),
        " について、",
        math(String.raw`e\in D_L(T\sigma)`),
        " と ",
        math(String.raw`e\notin D_L(\sigma)`),
        " は同値である（",
        ref("claim_odd_flip_reverses_edges"),
        " と ",
        ref("def_broken_count"),
        "）。すなわち",
      ]),
      displayMath(String.raw`D_L(T\sigma)=E_L\setminus D_L(\sigma)`),
      paragraph(["である。よって"]),
      displayMath(
        String.raw`\begin{aligned}
m_L(T\sigma)
&=\#D_L(T\sigma)
&&(\because\ \blkref{def_broken_count})\\
&=\#\bigl(E_L\setminus D_L(\sigma)\bigr)
&&(\because\ \text{前段の集合の等式})\\
&=\#E_L-\#D_L(\sigma)
&&(\because\ \text{有限集合の部分集合の補集合の元の個数})\\
&=\#E_L-m_L(\sigma)
&&(\because\ \blkref{def_broken_count})
\end{aligned}`,
      ),
      paragraph(["である。"]),
    ],
  },

  {
    id: "null_model_claim_palindrome",
    kind: "claim",
    standing: "mainTheorem",
    title: { text: "多重度は回文である" },
    labels: ["claim_palindrome"],
    habitat: "N",
    statement: [
      paragraph([
        "すべての自然数 ",
        math(String.raw`m`),
        " について ",
        math(String.raw`m\le\#E_L`),
        " ならば",
      ]),
      displayMath(String.raw`\Omega_L(m)=\Omega_L(\#E_L-m)`),
      paragraph([
        "が成り立つ（",
        math(String.raw`m>\#E_L`),
        " のときは左辺が ",
        math(String.raw`0`),
        " であり、右辺の引数が自然数の範囲を出るので、等式を主張しない。",
        ref("def_multiplicity"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "自然数 ",
        math(String.raw`m\le\#E_L`),
        " を固定し、",
        math(String.raw`S_m=\{\,\sigma\in\Sigma_L\ :\ m_L(\sigma)=m\,\}`),
        " と置く（",
        math(String.raw`\Omega_L(m)=\#S_m`),
        "。",
        ref("def_multiplicity"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\sigma\in S_m`),
        " ならば ",
        math(String.raw`m_L(T\sigma)=\#E_L-m`),
        "（",
        ref("claim_broken_complement"),
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
        math(String.raw`S_m`),
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
    id: "odd_period_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 奇数周期では回文でない" },
    labels: [],
  },

  {
    id: "odd_period_remark_positioning",
    kind: "remark",
    title: { text: "この章の位置づけ（別の族であること）" },
    labels: ["remark_odd_period_positioning"],
    habitat: "none",
    statement: [
      paragraph([
        "この章では、辺を周期的に巻く族（周期境界の族）を定義する。",
        "前章の族（",
        ref("def_edge_set"),
        " の辺だけを使う族）とは**別の族**であり、量にはすべて上付きの ",
        math(String.raw`\mathrm{per}`),
        " を付けて区別する。族を混ぜて比べない（",
        ref("remark_null_model_positioning"),
        "）。",
      ]),
      paragraph([
        "この章の結論は否定的な主張である。前章の回文性（",
        ref("claim_palindrome"),
        "）は二部性（辺の両端で座標和の偶奇が異なること。",
        ref("claim_edge_endpoints_parity"),
        "）から従ったが、周期が奇数のときは周期境界の族で回文性そのものが崩れる。",
        "回文性が箱の構造に強制された性質であって、族に依らない普遍的な性質ではないことを、",
        "反例で確定させる。",
      ]),
    ],
  },

  {
    id: "odd_period_definition_edge_set",
    kind: "definition",
    title: { text: "周期辺の集合" },
    labels: ["def_periodic_edge_set"],
    habitat: "N",
    statement: [
      paragraph(["有限集合"]),
      displayMath(
        String.raw`E^{\mathrm{per}}_L=\{\,(a,i)\ :\ a\in V_L,\ i\in\{1,2,3\}\,\}`,
      ),
      paragraph([
        "を周期辺の集合と呼ぶ（",
        ref("def_box"),
        "）。前章の ",
        math(String.raw`E_L`),
        " と違い、始点の第 ",
        math(String.raw`i`),
        " 成分に条件を置かない。",
        math(String.raw`\#E^{\mathrm{per}}_L=3\cdot L\cdot L\cdot L`),
        " である（方向が ",
        math(String.raw`3`),
        " 通り、始点が ",
        math(String.raw`\#V_L=L\cdot L\cdot L`),
        " 通り）。",
      ]),
    ],
  },

  {
    id: "odd_period_definition_endpoint_maps",
    kind: "definition",
    title: { text: "周期端点写像" },
    labels: ["def_periodic_endpoint_maps"],
    habitat: "Z",
    statement: [
      paragraph(["二つの写像を"]),
      displayMath(
        String.raw`\partial^{\mathrm{per}}_0:E^{\mathrm{per}}_L\to V_L,\qquad \partial^{\mathrm{per}}_0(a,i)=a`,
      ),
      displayMath(
        String.raw`\partial^{\mathrm{per}}_1:E^{\mathrm{per}}_L\to V_L,\qquad
\partial^{\mathrm{per}}_1(a,i)=\begin{cases}a+\varepsilon_i&(a_i\le L-2)\\ a-(L-1)\,\varepsilon_i&(a_i=L-1)\end{cases}`,
      ),
      paragraph([
        "と定め、周期端点写像と呼ぶ。ここで ",
        math(String.raw`a+\varepsilon_i`),
        "、",
        math(String.raw`a-(L-1)\,\varepsilon_i`),
        " は成分ごとの整数の和・差であり、",
        math(String.raw`\varepsilon_i`),
        " は前章と同じ三つ組である（",
        ref("def_endpoint_maps"),
        "）。",
      ]),
      paragraph([
        math(String.raw`\partial^{\mathrm{per}}_1`),
        " の値が ",
        math(String.raw`V_L`),
        " に属することは次から従う。",
        math(String.raw`a_i\le L-2`),
        " の場合は第 ",
        math(String.raw`i`),
        " 成分が ",
        math(String.raw`a_i+1\le L-1`),
        " かつ ",
        math(String.raw`0\le a_i+1`),
        " である。",
        math(String.raw`a_i=L-1`),
        " の場合は第 ",
        math(String.raw`i`),
        " 成分が ",
        math(String.raw`(L-1)-(L-1)=0`),
        " である。どちらの場合も他の二成分は変わらない。",
      ]),
    ],
  },

  {
    id: "odd_period_definition_broken_count",
    kind: "definition",
    title: { text: "周期族の破れ数" },
    labels: ["def_periodic_broken_count"],
    habitat: "N",
    statement: [
      paragraph([
        "配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        "（",
        ref("def_configuration"),
        "。点の集合は前章と同じ ",
        math(String.raw`V_L`),
        " なので配位の集合も同じ）に対し",
      ]),
      displayMath(
        String.raw`D^{\mathrm{per}}_L(\sigma)=\{\,e\in E^{\mathrm{per}}_L\ :\ \sigma(\partial^{\mathrm{per}}_0 e)\ne\sigma(\partial^{\mathrm{per}}_1 e)\,\},\qquad
m^{\mathrm{per}}_L(\sigma)=\#D^{\mathrm{per}}_L(\sigma)\in\mathbb{N}`,
      ),
      paragraph([
        "と置く。数える範囲は ",
        math(String.raw`E^{\mathrm{per}}_L`),
        " だけである（",
        ref("def_periodic_edge_set"),
        "）。両端の値は周期端点写像で取り出す（",
        ref("def_periodic_endpoint_maps"),
        "）。",
      ]),
    ],
  },

  {
    id: "odd_period_definition_multiplicity",
    kind: "definition",
    title: { text: "周期族の多重度" },
    labels: ["def_periodic_multiplicity"],
    habitat: "N",
    statement: [
      paragraph(["自然数 ", math(String.raw`m`), " に対し"]),
      displayMath(
        String.raw`\Omega^{\mathrm{per}}_L(m)=\#\{\,\sigma\in\Sigma_L\ :\ m^{\mathrm{per}}_L(\sigma)=m\,\}\ \in\ \mathbb{N}`,
      ),
      paragraph([
        "と置き、周期族の多重度と呼ぶ（",
        ref("def_periodic_broken_count"),
        "）。",
      ]),
    ],
  },

  {
    id: "odd_period_claim_constant_unbroken",
    kind: "claim",
    title: { text: "定数配位は周期辺を破らない" },
    labels: ["claim_periodic_constant_unbroken"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`\Omega^{\mathrm{per}}_L(0)\ge1`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "すべての点 ",
        math(String.raw`a\in V_L`),
        " で ",
        math(String.raw`\sigma^{+}(a)=+1`),
        " と定めた配位 ",
        math(String.raw`\sigma^{+}\in\Sigma_L`),
        " を取る（",
        ref("def_configuration"),
        "）。すべての辺 ",
        math(String.raw`e\in E^{\mathrm{per}}_L`),
        " について",
      ]),
      displayMath(
        String.raw`\sigma^{+}(\partial^{\mathrm{per}}_0 e)=+1=\sigma^{+}(\partial^{\mathrm{per}}_1 e)\qquad(\because\ \sigma^{+}\ \text{の定義})`,
      ),
      paragraph([
        "なので、破れの条件 ",
        math(String.raw`\sigma^{+}(\partial^{\mathrm{per}}_0 e)\ne\sigma^{+}(\partial^{\mathrm{per}}_1 e)`),
        " を満たす辺は無く ",
        math(String.raw`D^{\mathrm{per}}_L(\sigma^{+})=\emptyset`),
        "、よって ",
        math(String.raw`m^{\mathrm{per}}_L(\sigma^{+})=0`),
        " である（",
        ref("def_periodic_broken_count"),
        "）。したがって ",
        math(String.raw`\Omega^{\mathrm{per}}_L(0)`),
        " が数える集合は ",
        math(String.raw`\sigma^{+}`),
        " を含むので、元の個数は ",
        math(String.raw`1`),
        " 以上である（",
        ref("def_periodic_multiplicity"),
        "）。",
      ]),
    ],
  },

  {
    id: "odd_period_claim_no_all_broken",
    kind: "claim",
    title: { text: "奇数周期ではすべての周期辺を破る配位は無い" },
    labels: ["claim_periodic_no_all_broken"],
    habitat: "Z",
    statement: [
      paragraph([
        math(String.raw`L`),
        " が奇数ならば ",
        math(String.raw`\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L)=0`),
        " が成り立つ。",
      ]),
    ],
    proof: [
      paragraph([
        "背理法で示す。",
        math(String.raw`m^{\mathrm{per}}_L(\sigma)=\#E^{\mathrm{per}}_L`),
        " を満たす配位 ",
        math(String.raw`\sigma\in\Sigma_L`),
        " があったと仮定する。",
        math(String.raw`D^{\mathrm{per}}_L(\sigma)`),
        " は ",
        math(String.raw`E^{\mathrm{per}}_L`),
        " の部分集合で元の個数が全体と等しいので ",
        math(String.raw`D^{\mathrm{per}}_L(\sigma)=E^{\mathrm{per}}_L`),
        "、すなわちすべての辺 ",
        math(String.raw`e\in E^{\mathrm{per}}_L`),
        " で ",
        math(String.raw`\sigma(\partial^{\mathrm{per}}_0 e)\ne\sigma(\partial^{\mathrm{per}}_1 e)`),
        " である（",
        ref("def_periodic_broken_count"),
        "）。",
      ]),
      paragraph([
        "準備として二つ置く。第一に、値が ",
        math(String.raw`\{+1,-1\}`),
        " に属する二数 ",
        math(String.raw`u,v`),
        " について、",
        math(String.raw`u\ne v`),
        " と ",
        math(String.raw`u\cdot v=-1`),
        " は同値である（値の全場合 ",
        math(String.raw`(+1,+1),(+1,-1),(-1,+1),(-1,-1)`),
        " で積は ",
        math(String.raw`+1,-1,-1,+1`),
        "）。第二に、各 ",
        math(String.raw`k\in I_L`),
        " に対して点 ",
        math(String.raw`v_k=(k,0,0)\in V_L`),
        " と辺 ",
        math(String.raw`e_k=(v_k,1)\in E^{\mathrm{per}}_L`),
        " を置く（",
        ref("def_periodic_edge_set"),
        "）。周期端点写像の定義（",
        ref("def_periodic_endpoint_maps"),
        "）から、",
        math(String.raw`k\le L-2`),
        " のとき ",
        math(String.raw`\partial^{\mathrm{per}}_1 e_k=v_{k+1}`),
        "、",
        math(String.raw`k=L-1`),
        " のとき ",
        math(String.raw`\partial^{\mathrm{per}}_1 e_{L-1}=v_0`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
-1&=(-1)^{L}
&&(\because\ L\ \text{は奇数})\\
&=\prod_{k=0}^{L-1}(-1)
&&(\because\ \text{同じ数}\ L\ \text{個の積})\\
&=\prod_{k=0}^{L-1}\sigma(v_k)\cdot\sigma(\partial^{\mathrm{per}}_1 e_k)
&&(\because\ \text{各}\ e_k\ \text{は破れているので、準備の第一を各}\ k\ \text{へ適用})\\
&=\Bigl(\prod_{k=0}^{L-1}\sigma(v_k)\Bigr)\cdot\Bigl(\prod_{k=0}^{L-1}\sigma(\partial^{\mathrm{per}}_1 e_k)\Bigr)
&&(\because\ \text{整数の積の交換法則と結合法則})\\
&=\Bigl(\prod_{k=0}^{L-1}\sigma(v_k)\Bigr)\cdot\Bigl(\Bigl(\prod_{k=0}^{L-2}\sigma(v_{k+1})\Bigr)\cdot\sigma(v_0)\Bigr)
&&(\because\ \text{準備の第二で端点を書き換え、最後の因子を分けた})\\
&=\Bigl(\prod_{k=0}^{L-1}\sigma(v_k)\Bigr)\cdot\Bigl(\Bigl(\prod_{k=1}^{L-1}\sigma(v_{k})\Bigr)\cdot\sigma(v_0)\Bigr)
&&(\because\ \text{添字の置き換え}\ k+1\mapsto k)\\
&=\Bigl(\prod_{k=0}^{L-1}\sigma(v_k)\Bigr)\cdot\Bigl(\prod_{k=0}^{L-1}\sigma(v_{k})\Bigr)
&&(\because\ \text{整数の積の交換法則})\\
&=\Bigl(\prod_{k=0}^{L-1}\sigma(v_k)\Bigr)^{2}
&&(\because\ \text{同じ数の二個の積})
\end{aligned}`,
      ),
      paragraph([
        "最後の量は整数の二乗なので ",
        math(String.raw`0`),
        " 以上であり、",
        math(String.raw`-1`),
        " と等しくなれない（各 ",
        math(String.raw`\sigma(v_k)`),
        " は整数 ",
        math(String.raw`+1`),
        " または ",
        math(String.raw`-1`),
        " で、その積も整数である）。矛盾したので、仮定した配位は存在しない。",
        "したがって ",
        math(String.raw`\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L)`),
        " が数える集合は空で、元の個数は ",
        math(String.raw`0`),
        " である（",
        ref("def_periodic_multiplicity"),
        "）。",
      ]),
    ],
  },

  {
    id: "odd_period_claim_not_palindrome",
    kind: "claim",
    standing: "mainTheorem",
    title: { text: "奇数周期では多重度は回文でない" },
    labels: ["claim_periodic_not_palindrome"],
    habitat: "N",
    statement: [
      paragraph([
        math(String.raw`L`),
        " が奇数ならば",
      ]),
      displayMath(
        String.raw`\Omega^{\mathrm{per}}_L(0)\ne\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L-0)`,
      ),
      paragraph([
        "が成り立つ。すなわち、前章の回文性（",
        ref("claim_palindrome"),
        "）と同じ形の等式 ",
        math(String.raw`\Omega^{\mathrm{per}}_L(m)=\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L-m)`),
        " は、周期族では ",
        math(String.raw`m=0`),
        " ですでに成り立たない。",
      ]),
    ],
    proof: [
      displayMath(
        String.raw`\begin{aligned}
\Omega^{\mathrm{per}}_L(0)&\ge1
&&(\because\ \blkref{claim_periodic_constant_unbroken})\\
\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L-0)&=\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L)
&&(\because\ \#E^{\mathrm{per}}_L-0=\#E^{\mathrm{per}}_L)\\
&=0
&&(\because\ L\ \text{は奇数。}\blkref{claim_periodic_no_all_broken})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`1`),
        " 以上の自然数と ",
        math(String.raw`0`),
        " は等しくないので、二つの多重度は異なる。",
      ]),
    ],
  },
]);
