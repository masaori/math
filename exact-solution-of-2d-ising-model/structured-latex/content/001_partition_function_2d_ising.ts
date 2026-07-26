import { defineBlocks, paragraph, math, displayMath, ref } from "../schema.ts";

export default defineBlocks([
  {
    id: "heading_partition_function_2d_ising",
    kind: "heading",
    level: 2,
    sourcePath: "_old/typst/main.typ",
    sourceOrdinal: 2,
    title: { text: "2次元ising模型の分配関数" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "partition_function_2d_ising_001_definition_lattice_size",
    kind: "definition",
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/000_definition_格子サイズ.typ",
    sourceOrdinal: 1,
    title: { text: "格子サイズ" },
    labels: [],
    statement: [
      paragraph([math(String.raw`M, N \in \mathbb{N}`), " を格子のサイズとする。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "partition_function_2d_ising_002_definition_partition_function",
    kind: "definition",
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/001_definition_2次元ising模型の分配関数.typ",
    sourceOrdinal: 2,
    title: { text: "2次元ising模型の分配関数" },
    labels: ["def_partition_function_2d_ising"],
    statement: [
      paragraph([
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
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/002_definition_転送行列.typ",
    sourceOrdinal: 3,
    title: { text: "転送行列" },
    labels: ["def_transfer_matrix"],
    statement: [
      paragraph([
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
    sourcePath: "_old/typst/parts/001_2次元ising模型の分配関数/003_claim_転送行列による分配関数の表式.typ",
    sourceOrdinal: 4,
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
        " を添え字として書く。",
      ]),
      paragraph([
        "本証明に現れる総和はすべて有限集合上の和であり、値は ",
        math(String.raw`\mathbb{C}`),
        " の元である。したがって和の順序交換・結合・分配は ",
        math(String.raw`\mathbb{C}`),
        " の可換環の公理から有限帰納法で従い、収束や極限の議論を一切要しない。",
      ]),

      paragraph([math(String.raw`\textbf{Step 1: } A = V_1V_2 \text{ の成分}`)]),
      paragraph([
        math(String.raw`\mu, \mu' \in \mathfrak{M}`),
        " に対して、行列の積の定義（",
        math(String.raw`(BC)_{\mu,\mu'} = \sum_{\nu} B_{\mu,\nu}C_{\nu,\mu'}`),
        "、和は添え字集合 ",
        math(String.raw`\mathfrak{M}`),
        " 全体をわたる）より、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(V_1 V_2)_{\mu,\mu'}
&= \sum_{\nu \in \mathfrak{M}} (V_1)_{\mu,\nu}(V_2)_{\nu,\mu'} \\
&= \sum_{\nu \in \mathfrak{M}} \delta_{\mu=\nu}
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\nu(j)\mu'(j)\right) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1)\right)
   \exp\!\left(\sum_{j\in\{1,\dots,N\}} J\,\mu(j)\mu'(j)\right) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} J'\,\mu(j)\mu(j+1) + \sum_{j\in\{1,\dots,N\}} J\,\mu(j)\mu'(j)\right) \\
&= \exp\!\left(\sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu(j)\mu(j+1) + J\,\mu(j)\mu'(j)\bigr)\right)
\end{aligned}`,
      ),
      paragraph([
        "3行目では ",
        math(String.raw`\delta_{\mu=\nu}`),
        " が ",
        math(String.raw`\nu = \mu`),
        " のときのみ ",
        math(String.raw`1`),
        "、他は ",
        math(String.raw`0`),
        " であることから、有限和の中で ",
        math(String.raw`\nu = \mu`),
        " の項だけが残ることを用いた。4行目は ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n = 1`),
        "、",
        math(String.raw`K = \mathbb{R}`),
        " として適用したものである（",
        math(String.raw`\mathrm{Mat}(1,\mathbb{R}) \cong \mathbb{R}`),
        " と同一視すれば、任意の ",
        math(String.raw`a, b \in \mathbb{R}`),
        " は ",
        math(String.raw`ab = ba`),
        " を満たすので仮定は自動的に成り立ち、",
        math(String.raw`\exp(a)\exp(b) = \exp(a+b)`),
        " を得る）。5行目は有限和どうしの項別加法（",
        math(String.raw`\mathbb{R}`),
        " における分配則・結合則）である。",
      ]),

      paragraph([math(String.raw`\textbf{Step 2: } A^m \text{ の成分（} m \text{ についての帰納法）}`)]),
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
        " のとき：右辺の添え字集合 ",
        math(String.raw`\mathfrak{M}^{0}`),
        " は空列のみからなる1点集合なので、右辺は ",
        math(String.raw`\prod_{k=1}^{1} A_{\mu^{(k)},\mu^{(k+1)}} = A_{\mu^{(1)},\mu^{(2)}}`),
        " の1項のみからなり、左辺 ",
        math(String.raw`(A^1)_{\mu^{(1)},\mu^{(2)}} = A_{\mu^{(1)},\mu^{(2)}}`),
        " と一致する。",
      ]),
      paragraph([
        math(String.raw`m`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つと仮定する。",
        math(String.raw`A^{m+1} = A^m A`),
        " と行列の積の定義より、",
        math(String.raw`\mu^{(1)}, \mu^{(m+2)} \in \mathfrak{M}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(A^{m+1}\right)_{\mu^{(1)},\mu^{(m+2)}}
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \left(A^{m}\right)_{\mu^{(1)},\mu^{(m+1)}} \, A_{\mu^{(m+1)},\mu^{(m+2)}} \\
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \left(
     \sum_{(\mu^{(2)},\dots,\mu^{(m)}) \in \mathfrak{M}^{m-1}} \prod_{k=1}^{m} A_{\mu^{(k)},\mu^{(k+1)}}
   \right) A_{\mu^{(m+1)},\mu^{(m+2)}} \\
&= \sum_{\mu^{(m+1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(m)}) \in \mathfrak{M}^{m-1}}
   \left( \prod_{k=1}^{m} A_{\mu^{(k)},\mu^{(k+1)}} \right) A_{\mu^{(m+1)},\mu^{(m+2)}} \\
&= \sum_{(\mu^{(2)},\dots,\mu^{(m+1)}) \in \mathfrak{M}^{m}} \ \prod_{k=1}^{m+1} A_{\mu^{(k)},\mu^{(k+1)}}
\end{aligned}`,
      ),
      paragraph([
        "2行目は帰納法の仮定 ",
        math(String.raw`(\ast)`),
        "、3行目は有限和に対する分配則（",
        math(String.raw`\left(\sum_\lambda x_\lambda\right) y = \sum_\lambda x_\lambda y`),
        "）、4行目は有限集合上の二重和を直積集合上の一重和にまとめる操作（",
        math(String.raw`\mathfrak{M} \times \mathfrak{M}^{m-1} \to \mathfrak{M}^{m}`),
        " の自然な全単射による添え字の付け替え。有限和なので順序に依らず等号が成り立つ）である。よってすべての ",
        math(String.raw`m \in \mathbb{Z}_{\ge 1}`),
        " で ",
        math(String.raw`(\ast)`),
        " が成り立つ。",
      ]),

      paragraph([math(String.raw`\textbf{Step 3: } \mathrm{tr}(A^M) \text{ の展開}`)]),
      paragraph([
        "トレースの定義 ",
        math(String.raw`\mathrm{tr}(B) := \sum_{\mu \in \mathfrak{M}} B_{\mu,\mu}`),
        " に ",
        math(String.raw`(\ast)`),
        " を ",
        math(String.raw`m = M`),
        " として適用する。左辺の対角成分は ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        " とおいた場合にあたるので、以下ではこの同一視",
      ]),
      displayMath(String.raw`\mu^{(M+1)} := \mu^{(1)}`),
      paragraph([
        "を規約とする（これが行方向の周期境界条件にあたる）。すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(A^M\right)
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \left(A^M\right)_{\mu^{(1)},\mu^{(1)}} \\
&= \sum_{\mu^{(1)} \in \mathfrak{M}} \ \sum_{(\mu^{(2)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M-1}} \ \prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}} \\
&= \sum_{(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}} \ \prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}}
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、Step 2 の 4 行目と同じく有限集合上の二重和を直積集合 ",
        math(String.raw`\mathfrak{M} \times \mathfrak{M}^{M-1} \cong \mathfrak{M}^{M}`),
        " 上の一重和にまとめたものである。",
      ]),

      paragraph([math(String.raw`\textbf{Step 4: } \text{指数の積を指数の和へ}`)]),
      paragraph([
        "まず、任意の ",
        math(String.raw`m \in \mathbb{Z}_{\ge 1}`),
        " と ",
        math(String.raw`x_1,\dots,x_m \in \mathbb{R}`),
        " に対して",
      ]),
      displayMath(String.raw`\prod_{k=1}^{m} \exp(x_k) = \exp\!\left(\sum_{k=1}^{m} x_k\right)`),
      paragraph([
        "が成り立つ。実際、",
        math(String.raw`m = 1`),
        " のときは両辺とも ",
        math(String.raw`\exp(x_1)`),
        " である。",
        math(String.raw`m`),
        " で成り立つとすると、",
      ]),
      displayMath(
        String.raw`\prod_{k=1}^{m+1} \exp(x_k)
= \left(\prod_{k=1}^{m} \exp(x_k)\right)\exp(x_{m+1})
= \exp\!\left(\sum_{k=1}^{m} x_k\right)\exp(x_{m+1})
= \exp\!\left(\sum_{k=1}^{m+1} x_k\right)`,
      ),
      paragraph([
        "であり（最後の等号は Step 1 と同じく ",
        ref("theorem_exp_product"),
        " の ",
        math(String.raw`n = 1, K = \mathbb{R}`),
        " の場合）、帰納法により主張を得る。",
      ]),
      paragraph([
        "Step 1 で得た ",
        math(String.raw`A`),
        " の成分の表式をこれに代入すると、",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}`),
        "（および ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        "）に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\prod_{k=1}^{M} A_{\mu^{(k)},\mu^{(k+1)}}
&= \prod_{k=1}^{M} \exp\!\left(\sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right) \\
&= \exp\!\left(\sum_{k\in\{1,\dots,M\}} \ \sum_{j\in\{1,\dots,N\}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right) \\
&= \exp\!\left(\sum_{\substack{k\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、有限集合 ",
        math(String.raw`\{1,\dots,M\}\times\{1,\dots,N\}`),
        " 上の和を二重和として書き直したものである（有限和なので和の順序交換は無条件に許される）。",
      ]),

      paragraph([math(String.raw`\textbf{Step 5: } \mathfrak{M}^{M} \text{ と } \mathfrak{S} \text{ の全単射}`)]),
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
        " は全単射である（両辺の濃度も ",
        math(String.raw`|\mathfrak{M}^{M}| = (2^N)^M = 2^{MN} = |\mathfrak{S}|`),
        " で整合する）。",
      ]),
      paragraph([
        "（周期規約の整合）",
        math(String.raw`s = \Phi(\mu^{(1)},\dots,\mu^{(M)})`),
        " とおくと、Step 3 の規約 ",
        math(String.raw`\mu^{(M+1)} = \mu^{(1)}`),
        " は ",
        math(String.raw`s(M+1,j) = \mu^{(M+1)}(j) = \mu^{(1)}(j) = s(1,j)`),
        " を、",
        ref("def_transfer_matrix"),
        " の規約 ",
        math(String.raw`\mu^{(i)}(N+1) = \mu^{(i)}(1)`),
        " は ",
        math(String.raw`s(i,N+1) = s(i,1)`),
        " を与える。これらは ",
        ref("def_partition_function_2d_ising"),
        " で置いた周期境界条件そのものである。ゆえに指数の肩に現れる記号は、両辺で同じ規約のもとに解釈される。",
      ]),

      paragraph([math(String.raw`\textbf{Step 6: } Z(J,J') \text{ との一致}`)]),
      paragraph([
        "Step 4 の表式を Step 3 に代入し、Step 5 の全単射 ",
        math(String.raw`\Phi`),
        " により添え字を ",
        math(String.raw`(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}`),
        " から ",
        math(String.raw`s \in \mathfrak{S}`),
        " へ付け替える（有限集合上の和は、添え字集合の全単射による付け替えで不変）。",
        math(String.raw`s(i,j) = \mu^{(i)}(j)`),
        " を代入して、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left((V_1V_2)^M\right)
&= \sum_{(\mu^{(1)},\dots,\mu^{(M)}) \in \mathfrak{M}^{M}}
   \exp\!\left(\sum_{\substack{k\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,\mu^{(k)}(j)\mu^{(k)}(j+1) + J\,\mu^{(k)}(j)\mu^{(k+1)}(j)\bigr)\right) \\
&= \sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J'\,s(i,j)s(i,j+1) + J\,s(i,j)s(i+1,j)\bigr)\right) \\
&= \sum_{s \in \mathfrak{S}}
   \exp\!\left(\sum_{\substack{i\in\{1,\dots,M\}\\j\in\{1,\dots,N\}}} \bigl(J\,s(i,j)s(i+1,j) + J'\,s(i,j)s(i,j+1)\bigr)\right) \\
&= Z(J,J')
\end{aligned}`,
      ),
      paragraph([
        "3行目は各被加数の中での加法の交換律、4行目は ",
        ref("def_partition_function_2d_ising"),
        " の定義式そのものである。以上より ",
        math(String.raw`Z(J,J') = \mathrm{tr}\!\left((V_1V_2)^M\right)`),
        " が示された。",
      ]),
    ],
    conversion: {
      status: "converted",
      notes: [
        "原文の proof は (V_1 V_2) の (μ,μ') 成分の計算までで、trace 展開による Z との一致は原文自体が未記載（TODO）だった。" +
          "成分計算は原文の全ステップを保ったうえで（def_transfer_matrix で訂正した J↔J' の入れ替えを反映）、" +
          "A^m の成分公式の帰納法・トレースの展開・指数の積の和への変換・𝔐^M と 𝔖 の全単射・有限和の添え字付け替えを新規に補い、証明を完成させた。",
      ],
    },
  },
]);
