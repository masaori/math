/**
 * 本文（章は見出しブロックで区切る）。
 *
 * この文書は主標的（可算コアの同定）だけで構成する。現在の内容は帰無モデルの最初の部分であり、
 * 自由境界の族について二部性からの回文性を証明している。
 *
 * 当初本体に据えていた枠組み「有限の証拠で臨界点の切断を定める」の章は、2026-08-14 に
 * `_old/demoted-critical-point-cut/` へ退避した（降格の理由と既知の欠陥はそこの README にある）。
 *
 * 立場（プロジェクト README が正本）:
 *   - 非可算へ出てよいのは、有限格子の量の列について格子サイズを大きくする極限だけである。
 *     この文書には極限が 1 度も現れない（すべて有限格子ごとの主張である）。
 *   - 相・臨界温度・自発磁化といった無限体積の語を主張に使わない。
 *   - 無限和・級数を書かない。有限和と、格子サイズに依らない一様な有理数の不等式だけを使う。
 *
 * 文書順はこの配列の並びが正本である。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "finite_box_heading",
    kind: "heading",
    level: 1,
    title: { text: "有限箱と配位" },
    labels: [],
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
]);
