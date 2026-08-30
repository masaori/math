import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_partition_function_2d_ising",
    kind: "heading",
    level: 2,
    origin: { path: "_old/typst/main.typ", ordinal: 2 },
    title: { text: "2次元ising模型の分配関数" },
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
        math(String.raw`M, N \in \mathbb{N}`),
        " かつ ",
        math(String.raw`M \geq 1,\ N \geq 1`),
        " とし、",
        math(String.raw`M, N`),
        " を格子のサイズとする。",
      ]),
    ],
    conversion: { status: "converted" },
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
        " の格子サイズ ",
        math(String.raw`M, N`),
        " を固定する。",
        math(String.raw`Z : \mathbb{R}_{>0} \times \mathbb{R}_{>0} \to \mathbb{R}_{>0}`),
        " を以下のように定める。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{S} := \mathrm{Map}(\{1,\dots,M\}\times\{1,\dots,N\},\{-1,1\})`),
        " として、",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`s \in \mathfrak{S}`),
        " の定義域は ",
        math(String.raw`\{1,\dots,M\}\times\{1,\dots,N\}`),
        " であって ",
        math(String.raw`s(M+1,j)`),
        "、",
        math(String.raw`s(i,N+1)`),
        " はそのままでは定義されない。以下では ",
        math(String.raw`s`),
        " を両方向に周期的に延長したもの（周期境界条件）を用いる。すなわち ",
        math(String.raw`i\in\{1,\dots,M\}`),
        "、",
        math(String.raw`j\in\{1,\dots,N\}`),
        " に対して",
      ]),
      displayMath(String.raw`s(M+1, j) := s(1, j), \qquad s(i, N+1) := s(i, 1)`),
      paragraph([
        "と定める。この規約のもとで、下式の被加数はすべて ",
        math(String.raw`\mathbb{R}`),
        " の元として定まる。",
      ]),
      displayMath(
        String.raw`Z(J, J') := \sum_{s \in \mathfrak{S}} \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J\,s(i,j)s(i+1,j) + J'\,s(i,j)s(i,j+1)\bigr)\right)`,
      ),
      paragraph([
        math(String.raw`\mathfrak{S}`),
        " は有限集合（",
        math(String.raw`|\mathfrak{S}| = 2^{MN}`),
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
        math(String.raw`J, J' \in \mathbb{R}_{>0}`),
        " を固定し、",
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^N, \mathbb{C})`),
        " を以下のように定める。",
      ]),
      paragraph([
        math(String.raw`\mathfrak{M} := \mathrm{Map}(\{1,\dots,N\},\{-1,1\})`),
        " とおく。",
        math(String.raw`|\mathfrak{M}| = 2^N`),
        " であるから、",
        math(String.raw`\mathfrak{M}`),
        " の元の対 ",
        math(String.raw`(\mu,\mu') \in \mathfrak{M}\times\mathfrak{M}`),
        " を ",
        math(String.raw`\mathrm{Mat}(2^N,\mathbb{C})`),
        " の成分の添え字として用いることができる（行・列の番号 ",
        math(String.raw`\{1,\dots,2^N\}`),
        " と ",
        math(String.raw`\mathfrak{M}`),
        " の間の全単射をひとつ固定して同一視する。以下の議論は、この全単射の取り方に依らない）。",
      ]),
      paragraph([
        math(String.raw`\mu \in \mathfrak{M}`),
        " の定義域は ",
        math(String.raw`\{1,\dots,N\}`),
        " であって ",
        math(String.raw`\mu(N+1)`),
        " はそのままでは定義されないため、",
        ref("def_partition_function_2d_ising"),
        " と同じく周期的に延長したものを用いる。すなわち",
      ]),
      displayMath(String.raw`\mu(N+1) := \mu(1)`),
      paragraph(["と定める。このとき、"]),
      displayMath(
        String.raw`\begin{aligned}
(V_1)_{\mu,\mu'} &:= \delta_{\mu=\mu'} \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\,\mu(j+1)\right) \\
(V_2)_{\mu,\mu'} &:= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\mu(j)\,\mu'(j)\right)
\end{aligned}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\delta_{\mu=\mu'} \in \{0,1\}`),
        " は、",
        math(String.raw`\mu = \mu'`),
        "（写像として一致、すなわち ",
        math(String.raw`\forall j\in\{1,\dots,N\},\ \mu(j)=\mu'(j)`),
        "）のとき ",
        math(String.raw`1`),
        "、そうでないとき ",
        math(String.raw`0`),
        " とする。",
      ]),
      paragraph([
        "指数の肩は ",
        math(String.raw`J, J' \in \mathbb{R}_{>0}`),
        " と ",
        math(String.raw`\mu(j),\mu'(j)\in\{-1,1\}\subset\mathbb{R}`),
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
      ],
    },
  },
  {
    id: "partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix",
    kind: "claim",
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
        math(String.raw`V_1, V_2 \in \mathrm{Mat}(2^N,\mathbb{C})`),
        " について、",
        math(String.raw`J, J' \in \mathbb{R}_{>0}`),
        " のとき",
      ]),
      displayMath(String.raw`Z(J, J') = \mathrm{tr}\!\left((V_1 V_2)^M\right)`),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("def_transfer_matrix"),
        " の記号 ",
        math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,N\},\{-1,1\})`),
        "（",
        math(String.raw`|\mathfrak{M}| = 2^N`),
        "、周期規約 ",
        math(String.raw`\mu(N+1)=\mu(1)`),
        "）を用い、",
        math(String.raw`A := V_1 V_2 \in \mathrm{Mat}(2^N,\mathbb{C})`),
        " とおく。",
        math(String.raw`A`),
        " の成分も ",
        math(String.raw`\mathfrak{M}\times\mathfrak{M}`),
        " を添え字として書く。行方向の周期規約として ",
        math(String.raw`\mu^{(M+1)} := \mu^{(1)}`),
        " を置く。",
      ]),
      paragraph([
        "本証明に現れる総和はすべて有限集合上の和であり、値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。したがって和の順序交換・結合・分配は ",
        math(String.raw`\mathbb{C}`),
        " の可換環の公理から有限帰納法で従い、収束や極限の議論を一切要しない。",
      ]),

      paragraph(["中間目標: 転送行列の積の成分。"]),
      paragraph([
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1 V_2)_{\mu,\mu'}
&= \sum_{\nu \in \mathfrak{M}} (V_1)_{\mu,\nu}(V_2)_{\nu,\mu'}
&&(\because\ \text{行列の積の定義}) \\
&= \sum_{\nu \in \mathfrak{M}} \delta_{\mu=\nu}
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\nu(j)\mu'(j)\right)
&&(\because\ V_1,\ V_2\ \text{の定義}) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\mu(j)\mu'(j)\right)
&&(\because\ \delta_{\mu=\nu}\ \text{は}\ \nu=\mu\ \text{のときだけ}\ 1\ \text{で他は}\ 0\ \text{である}) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1) + \sum_{j\in\{1,\dots,N\}} J\,\mu(j)\mu'(j)\right)
&&(\because\ \text{指数の積は指数の和である}\ (n=1,\ K=\mathbb{R})) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu(j)\mu(j+1) + J\,\mu(j)\mu'(j)\bigr)\right)
&&(\because\ \mathbb{R}\ \text{の分配則と結合則による有限和の項別加法})
\end{aligned}`,
      ),
      paragraph([
        "引いたのは ",
        ref("def_transfer_matrix"),
        " と ",
        ref("theorem_exp_product"),
        " である（後者は ",
        math(String.raw`\mathrm{Mat}(1,\mathbb{R}) \cong \mathbb{R}`),
        " と同一視すれば任意の ",
        math(String.raw`a,b\in\mathbb{R}`),
        " が ",
        math(String.raw`ab=ba`),
        " を満たすので、仮定は自動的に成り立つ）。",
      ]),

      paragraph(["中間目標: 行列の冪の成分。"]),
      paragraph([
        "任意の ",
        math(String.raw`m \in \mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`\mu^{(1)}, \mu^{(m+1)} \in \mathfrak{M}`),
        " に対して次が成り立つことを、",
        math(String.raw`m`),
        " についての帰納法で示す。",
      ]),
      displayMath(
        String.raw`\left(A^m\right)_{\mu^{(1)},\mu^{(m+1)}}
= \sum_{(\mu^{(2)},\dots,\mu^{(m)}) \in \mathfrak{M}^{m-1}} \ \prod_{k=1}^{m} A_{\mu^{(k)},\mu^{(k+1)}}
\tag{*}`,
      ),
      paragraph([
        math(String.raw`m = 1`),
        " の場合である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A^1\right)_{\mu^{(1)},\mu^{(2)}}
&= A_{\mu^{(1)},\mu^{(2)}}
&&(\because\ \text{行列の}\ 1\ \text{乗はその行列自身である}) \\
&= \prod_{k=1}^{1} A_{\mu^{(k)},\mu^{(k+1)}}
&&(\because\ \text{因子が}\ 1\ \text{つの有限積はその因子である}) \\
&= \sum_{(\ ) \in \mathfrak{M}^{0}} \ \prod_{k=1}^{1} A_{\mu^{(k)},\mu^{(k+1)}}
&&(\because\ \mathfrak{M}^{0}\ \text{は空列のみからなる}\ 1\ \text{点集合である})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`m`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つと仮定し、",
        math(String.raw`\mu^{(1)}, \mu^{(m+2)} \in \mathfrak{M}`),
        " を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A^{m+1}\right)_{\mu^{(1)},\mu^{(m+2)}}
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \left(A^{m}\right)_{\mu^{(1)},\mu^{(m+1)}} \, A_{\mu^{(m+1)},\mu^{(m+2)}}
&&(\because\ A^{m+1}=A^m A\ \text{と行列の積の定義}) \\
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \left(
     \sum_{(\mu^{(2)},\dots,\mu^{(m)}) \in \mathfrak{M}^{m-1}} \prod_{k=1}^{m} A_{\mu^{(k)},\mu^{(k+1)}}
   \right) A_{\mu^{(m+1)},\mu^{(m+2)}}
&&(\because\ \text{帰納法の仮定}\ (\ast)) \\
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(m)}) \in \mathfrak{M}^{m-1}}
   \left( \prod_{k=1}^{m} A_{\mu^{(k)},\mu^{(k+1)}} \right) A_{\mu^{(m+1)},\mu^{(m+2)}}
&&(\because\ \text{有限和に対する分配則}\ \left(\sum_\lambda x_\lambda\right) y = \sum_\lambda x_\lambda y) \\
&= \sum_{(\mu^{(2)},\dots,\mu^{(m+1)}) \in \mathfrak{M}^{m}} \ \prod_{k=1}^{m+1} A_{\mu^{(k)},\mu^{(k+1)}}
&&(\because\ \mathfrak{M} \times \mathfrak{M}^{m-1} \to \mathfrak{M}^{m}\ \text{の全単射による添え字の付け替えと、末尾の因子を有限積へ入れること})
\end{aligned}`,
      ),
      paragraph([
        "有限和なので添え字の付け替えは順序に依らず等号を与える。よってすべての ",
        math(String.raw`m \in \mathbb{Z}_{\ge 1}`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つ。",
      ]),

      paragraph(["中間目標: トレースの展開。"]),
      paragraph([
        "冒頭で置いた行方向の周期規約 ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        " のもとで、対角成分に ",
        math(String.raw`(\ast)`),
        " を ",
        math(String.raw`m = M`),
        " として当てる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(A^M\right)
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \left(A^M\right)_{\mu^{(1)},\mu^{(1)}}
&&(\because\ \text{トレースの定義}\ \mathrm{tr}(B) = \sum_{\mu} B_{\mu,\mu}) \\
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M-1}} \ \prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}}
&&(\because\ (\ast)\ \text{を}\ m=M,\ \mu^{(M+1)}=\mu^{(1)}\ \text{として}) \\
&= \sum_{(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}} \ \prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}}
&&(\because\ \mathfrak{M} \times \mathfrak{M}^{M-1} \to \mathfrak{M}^{M}\ \text{の全単射による添え字の付け替え})
\end{aligned}`,
      ),

      paragraph(["中間目標: 指数の積を指数の和へ。"]),
      paragraph([
        "準備として、任意の ",
        math(String.raw`m \in \mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " について ",
        math(String.raw`\prod_{k=1}^{m} \exp(x_k) = \exp\!\left(\sum_{k=1}^{m} x_k\right)`),
        " を ",
        math(String.raw`m`),
        " についての帰納法で示す。",
        math(String.raw`m = 1`),
        " のときは両辺とも ",
        math(String.raw`\exp(x_1)`),
        " である。",
        math(String.raw`m`),
        " で成り立つとする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{k=1}^{m+1} \exp(x_k)
&= \left(\prod_{k=1}^{m} \exp(x_k)\right)\exp(x_{m+1})
&&(\because\ \text{有限積から末尾の因子を分けること}) \\
&= \exp\!\left(\sum_{k=1}^{m} x_k\right)\exp(x_{m+1})
&&(\because\ \text{帰納法の仮定}) \\
&= \exp\!\left(\sum_{k=1}^{m+1} x_k\right)
&&(\because\ \text{指数の積は指数の和である}\ (n=1,\ K=\mathbb{R}))
\end{aligned}`,
      ),
      paragraph([
        "最後の行で引いたのは ",
        ref("theorem_exp_product"),
        " である。",
      ]),
      paragraph([
        math(String.raw`(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}`),
        "（および ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        "）を任意に取る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}}
&= \prod_{k=1}^{M} \exp\!\left(\sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right)
&&(\because\ \text{上で示した転送行列の積の成分}) \\
&= \exp\!\left(\sum_{k\in\{1,\dots,M\}} \ \sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right)
&&(\because\ \text{直前に示した指数の積の法則}) \\
&= \exp\!\left(\sum_{\substack{k\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right)
&&(\because\ \text{有限集合}\ \{1,\dots,M\}\times\{1,\dots,N\}\ \text{上の和を二重和として書き直すこと})
\end{aligned}`,
      ),

      paragraph([
        "中間目標: ",
        math(String.raw`\mathfrak{M}^{M}`),
        " と ",
        math(String.raw`\mathfrak{S}`),
        " の全単射。両包含ではなく全単射の構成なので、一続きの式変形にはしない。",
      ]),
      paragraph([
        "写像 ",
        math(String.raw`\Phi : \mathfrak{M}^{M} \to \mathfrak{S}`),
        " を次で定める。",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}`),
        " に対し、",
      ]),
      displayMath(
        String.raw`\Phi(\mu^{(1)},\dots,\mu^{(M)}) := s, \qquad
s(i,j) := \mu^{(i)}(j) \quad (i\in\{1,\dots,M\},\ j\in\{1,\dots,N\})`,
      ),
      paragraph([
        "（well-defined 性）各 ",
        math(String.raw`\mu^{(i)}`),
        " は ",
        math(String.raw`\{1,\dots,N\} \to \{-1,1\}`),
        " の写像だから、",
        math(String.raw`s`),
        " は ",
        math(String.raw`\{1,\dots,M\}\times\{1,\dots,N\}`),
        " の各元に ",
        math(String.raw`\{-1,1\}`),
        " の元をただ1つ対応させる。ゆえに ",
        math(String.raw`s \in \mathfrak{S}`),
        "。",
      ]),
      paragraph([
        "（単射性）",
        math(String.raw`\Phi(\mu^{(1)},\dots,\mu^{(M)}) = \Phi(\nu^{(1)},\dots,\nu^{(M)})`),
        " とすると、すべての ",
        math(String.raw`i\in\{1,\dots,M\}`),
        "、",
        math(String.raw`j\in\{1,\dots,N\}`),
        " について ",
        math(String.raw`\mu^{(i)}(j) = \nu^{(i)}(j)`),
        "。写像の外延性より各 ",
        math(String.raw`i`),
        " で ",
        math(String.raw`\mu^{(i)} = \nu^{(i)}`),
        " であり、組として ",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(M)}) = (\nu^{(1)},\dots,\nu^{(M)})`),
        "。",
      ]),
      paragraph([
        "（全射性）",
        math(String.raw`s \in \mathfrak{S}`),
        " を任意にとり、",
        math(String.raw`i\in\{1,\dots,M\}`),
        " ごとに ",
        math(String.raw`\mu^{(i)} : \{1,\dots,N\} \to \{-1,1\}`),
        " を ",
        math(String.raw`\mu^{(i)}(j) := s(i,j)`),
        " で定めれば ",
        math(String.raw`\mu^{(i)} \in \mathfrak{M}`),
        " であり、",
        math(String.raw`\Phi(\mu^{(1)},\dots,\mu^{(M)}) = s`),
        "。",
      ]),
      paragraph([
        "よって ",
        math(String.raw`\Phi`),
        " は全単射である。両辺の濃度も",
      ]),
      displayMath(String.raw`\begin{aligned}
|\mathfrak{M}^{M}|
&= (2^N)^M
&&\bigl(\because\ \mathfrak{M}^{M}\text{ は }M\text{ 個の直積で、}|\mathfrak{M}|=2^N\text{（}\{1,\dots,N\}\text{ から }\{-1,1\}\text{ への写像の総数）}\bigr)\\
&= 2^{MN}
&&\bigl(\because\ \text{指数法則 }(a^m)^n=a^{mn}\bigr)\\
&= |\mathfrak{S}|
&&\bigl(\because\ \mathfrak{S}\text{ は }\{1,\dots,M\}\times\{1,\dots,N\}\text{ から }\{-1,1\}\text{ への写像全体で、その総数は }2^{MN}\bigr)
\end{aligned}`),
      paragraph(["で整合する。"]),
      paragraph([
        "（周期規約の整合）",
        math(String.raw`s = \Phi(\mu^{(1)},\dots,\mu^{(M)})`),
        " とおくと、冒頭で置いた規約 ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        " から",
      ]),
      displayMath(String.raw`\begin{aligned}
s(M+1,j)
&=\mu^{(M+1)}(j)
&&\bigl(\because\ s(i,j)=\mu^{(i)}(j)\text{（}\Phi\text{ の定義）}\bigr)\\
&=\mu^{(1)}(j)
&&\bigl(\because\ \mu^{(M+1)}=\mu^{(1)}\text{（周期規約）}\bigr)\\
&=s(1,j)
&&\bigl(\because\ s(i,j)=\mu^{(i)}(j)\text{（}\Phi\text{ の定義）}\bigr)
\end{aligned}`),
      paragraph([
        "を得る。また、",
        ref("def_transfer_matrix"),
        " の規約 ",
        math(String.raw`\mu^{(i)}(N+1) = \mu^{(i)}(1)`),
        " は ",
        math(String.raw`s(i,N+1) = s(i,1)`),
        " を与える。これらは ",
        ref("def_partition_function_2d_ising"),
        " で置いた周期境界条件そのものである。ゆえに指数の肩に現れる記号は、両辺で同じ規約のもとに解釈される。",
      ]),

      paragraph(["中間目標: 分配関数との一致。"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left((V_1V_2)^M\right)
&= \sum_{(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}}
   \exp\!\left(\sum_{\substack{k\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right)
&&(\because\ \text{上で示したトレースの展開と、直前に示した積の表式}) \\
&= \sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,s(i,j)s(i,j+1) + J\,s(i,j)s(i+1,j)\bigr)\right)
&&(\because\ \Phi\ \text{が全単射であることによる添え字の付け替えと}\ s(i,j)=\mu^{(i)}(j)) \\
&= \sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J\,s(i,j)s(i+1,j) + J'\,s(i,j)s(i,j+1)\bigr)\right)
&&(\because\ \mathbb{R}\ \text{の加法の交換律}) \\
&= Z(J,J')
&&(\because\ \text{分配関数の定義式そのもの})
\end{aligned}`,
      ),
      paragraph([
        "最後の行で引いたのは ",
        ref("def_partition_function_2d_ising"),
        " である。",
      ]),
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
      ],
    },
  },
]);
