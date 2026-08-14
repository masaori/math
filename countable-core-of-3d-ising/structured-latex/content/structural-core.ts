/**
 * 帰無モデルの回文性から、整数座標の算術を落とす。
 *
 * 有限集合、方向ごとの部分後続写像、二色塗り分けだけを置く。
 * 非可算な量は現れない。
 */

import { defineBlocks, displayMath, list, math, paragraph, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "structural_core_heading",
    kind: "heading",
    level: 1,
    title: { text: "帰無モデル: 箱から整数の算術を落とす" },
    labels: [],
  },

  {
    id: "structural_core_definition_bipartite_successor_system",
    kind: "definition",
    title: { text: "有限二部後続系" },
    labels: ["def_bipartite_successor_system"],
    habitat: "N",
    statement: [
      paragraph([
        "有限集合 ",
        math(String.raw`V`),
        " と方向の有限集合 ",
        math(String.raw`I=\{1,2,3\}`),
        " を取る。各 ",
        math(String.raw`i\in I`),
        " に対し、部分集合 ",
        math(String.raw`A_i\subseteq V`),
        " と単射 ",
        math(String.raw`\operatorname{succ}_i:A_i\to V`),
        " を取る。辺の有限集合と二つの端点写像を",
      ]),
      displayMath(
        String.raw`E=\{\,(a,i)\ :\ i\in I,\ a\in A_i\,\},\qquad
\partial_0(a,i)=a,\qquad
\partial_1(a,i)=\operatorname{succ}_i(a)`,
      ),
      paragraph([
        "で定める。さらに写像 ",
        math(String.raw`c:V\to\{0,1\}`),
        " を取り、すべての ",
        math(String.raw`e\in E`),
        " について",
      ]),
      displayMath(String.raw`c(\partial_0e)\ne c(\partial_1e)`),
      paragraph([
        "が成り立つと仮定する。このデータ全体を有限二部後続系と呼ぶ。",
        "ここでは整数の加法、順序、座標和を置かない。",
      ]),
    ],
  },

  {
    id: "structural_core_definition_configuration",
    kind: "definition",
    title: { text: "有限二部後続系の配位" },
    labels: ["def_structural_configuration"],
    habitat: "Z",
    statement: [
      paragraph([
        "有限二部後続系（",
        ref("def_bipartite_successor_system"),
        "）を固定する。写像 ",
        math(String.raw`\sigma:V\to\{+1,-1\}`),
        " を配位と呼び、配位の有限集合を",
      ]),
      displayMath(String.raw`\Sigma=\{\,\sigma:V\to\{+1,-1\}\,\}`),
      paragraph(["と書く。"])],
  },

  {
    id: "structural_core_definition_broken_count",
    kind: "definition",
    title: { text: "有限二部後続系の破れ辺と破れ数" },
    labels: ["def_structural_broken_count"],
    habitat: "N",
    statement: [
      paragraph(["配位 ", math(String.raw`\sigma\in\Sigma`), " に対して"]),
      displayMath(
        String.raw`D(\sigma)=\{\,e\in E:\sigma(\partial_0e)\ne\sigma(\partial_1e)\,\},\qquad
b(\sigma)=\#D(\sigma)`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`D(\sigma)`),
        " は有限集合 ",
        math(String.raw`E`),
        " の部分集合であり、",
        math(String.raw`b(\sigma)\in\mathbb N`),
        " である。",
      ]),
    ],
  },

  {
    id: "structural_core_definition_multiplicity",
    kind: "definition",
    title: { text: "有限二部後続系の多重度" },
    labels: ["def_structural_multiplicity"],
    habitat: "N",
    statement: [
      paragraph(["自然数 ", math(String.raw`m\in\mathbb N`), " に対して"]),
      displayMath(String.raw`\Omega_E(m)=\#\{\,\sigma\in\Sigma:b(\sigma)=m\,\}`),
      paragraph(["と定める。右辺は有限集合の元の個数なので自然数である。"]),
    ],
  },

  {
    id: "structural_core_definition_color_flip",
    kind: "definition",
    title: { text: "色 1 の点だけを反転する写像" },
    labels: ["def_structural_color_flip"],
    habitat: "Z",
    statement: [
      paragraph([
        "写像 ",
        math(String.raw`T:\Sigma\to\Sigma`),
        " を、配位 ",
        math(String.raw`\sigma\in\Sigma`),
        " と点 ",
        math(String.raw`a\in V`),
        " に対して",
      ]),
      displayMath(
        String.raw`(T\sigma)(a)=
\begin{cases}
  -\sigma(a)&(c(a)=1),\\
  \sigma(a)&(c(a)=0)
\end{cases}`,
      ),
      paragraph([
        "と定める。",
        math(String.raw`c(a)\in\{0,1\}`),
        " なので二つの場合で全点を尽くす。",
      ]),
    ],
  },

  {
    id: "structural_core_claim_palindrome",
    kind: "claim",
    title: { text: "回文性に整数の算術は要らない" },
    labels: ["claim_structural_palindrome"],
    habitat: "N",
    statement: [
      paragraph([
        "有限二部後続系について、すべての自然数 ",
        math(String.raw`m\le\#E`),
        " に対して",
      ]),
      displayMath(String.raw`\Omega_E(m)=\Omega_E(\#E-m)`),
      paragraph([
        "が成り立つ。したがって、",
        ref("claim_palindrome"),
        " の回文性に、整数の加法、順序、座標和は要らない。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ",
        math(String.raw`T`),
        " が対合であることを示す。点 ",
        math(String.raw`a\in V`),
        " を任意に取る。",
      ]),
      list([
        [
          math(String.raw`c(a)=1`),
          " ならば ",
          math(String.raw`(T(T\sigma))(a)=-(-\sigma(a))=\sigma(a)`),
          " である（",
          ref("def_structural_color_flip"),
          " を二回適用）。",
        ],
        [
          math(String.raw`c(a)=0`),
          " ならば ",
          math(String.raw`(T(T\sigma))(a)=(T\sigma)(a)=\sigma(a)`),
          " である（",
          ref("def_structural_color_flip"),
          " を二回適用）。",
        ],
      ]),
      paragraph([
        "よって ",
        math(String.raw`T(T\sigma)=\sigma`),
        " であり、",
        math(String.raw`T`),
        " は自分自身を逆写像に持つ全単射である。",
      ]),
      paragraph([
        "次に辺 ",
        math(String.raw`e\in E`),
        " を任意に取る。両端の色は異なる（",
        ref("def_bipartite_successor_system"),
        "）ので、両端のうちちょうど一方でだけ符号が反転する。値は ",
        math(String.raw`\{+1,-1\}`),
        " に属するから、",
      ]),
      displayMath(
        String.raw`(T\sigma)(\partial_0e)\ne(T\sigma)(\partial_1e)
\quad\Longleftrightarrow\quad
\sigma(\partial_0e)=\sigma(\partial_1e)
\qquad(\because\ \blkref{def_structural_color_flip})`,
      ),
      paragraph([
        "である。これは各辺で成り立つので、",
        ref("def_structural_broken_count"),
        " より",
      ]),
      displayMath(String.raw`D(T\sigma)=E\setminus D(\sigma)`),
      paragraph(["である。したがって"]),
      displayMath(
        String.raw`\begin{aligned}
b(T\sigma)
&=\#D(T\sigma)
&&(\because\ \blkref{def_structural_broken_count})\\
&=\#\bigl(E\setminus D(\sigma)\bigr)
&&(\because\ \text{前段の集合の等式})\\
&=\#E-\#D(\sigma)
&&(\because\ \text{有限集合の部分集合の補集合の元の個数})\\
&=\#E-b(\sigma)
&&(\because\ \blkref{def_structural_broken_count})
\end{aligned}`,
      ),
      paragraph([
        "である。自然数 ",
        math(String.raw`m\le\#E`),
        " を固定し、",
        math(String.raw`S_m=\{\,\sigma\in\Sigma:b(\sigma)=m\,\}`),
        " と置く。前段の等式により ",
        math(String.raw`T`),
        " は ",
        math(String.raw`S_m`),
        " から ",
        math(String.raw`S_{\#E-m}`),
        " への写像を定める。同じ等式と ",
        math(String.raw`\#E-(\#E-m)=m`),
        " により、",
        math(String.raw`T`),
        " は ",
        math(String.raw`S_{\#E-m}`),
        " から ",
        math(String.raw`S_m`),
        " への写像も定める。さらに ",
        math(String.raw`T(T\sigma)=\sigma`),
        " なので、この二つの写像は互いに逆であり、どちらも全単射である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\Omega_E(m)
&=\#S_m
&&(\because\ \blkref{def_structural_multiplicity})\\
&=\#S_{\#E-m}
&&(\because\ T:S_m\to S_{\#E-m}\ \text{は全単射})\\
&=\Omega_E(\#E-m)
&&(\because\ \blkref{def_structural_multiplicity})
\end{aligned}`,
      ),
      paragraph([
        "となる。証明で使ったのは、有限性、辺の端点、二色塗り分け、符号反転、有限集合の補集合だけである。",
        "特に ",
        math(String.raw`\operatorname{succ}_i`),
        " の単射性も使っていない。単射性は箱を方向ごとの列として表すための構造であり、",
        "回文性そのものには不要である。",
      ]),
    ],
  },
]);
