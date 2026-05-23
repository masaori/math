import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "exp_linear_map_001_theorem_exp_series_pointwise_converges",
    kind: "theorem",
    sourcePath: "parts/003_線型写像のexp/000_theorem_線型写像のexpの級数が各点収束すること.typ",
    sourceOrdinal: 1,
    title: null,
    labels: ["exp_converges"],
    statement: [
      paragraph([
        "体 ",
        math(String.raw`K`),
        ": ",
        math(String.raw`\mathbb{R}`),
        " または ",
        math(String.raw`\mathbb{C}`),
        "、",
        math(String.raw`V`),
        ": 有限次元 ",
        math(String.raw`K`),
        "-ノルム線型空間",
      ]),
      paragraph([
        "線型写像 ",
        math(String.raw`X : V \to V`),
        " について、",
      ]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
      paragraph(["は線型写像 ", math(String.raw`V \to V`), " に各点収束する。"]),
    ],
    proof: [
      paragraph([
        math(String.raw`V`),
        " は有限次元なので基底 ",
        math(String.raw`E \subset V`),
        " が存在し、",
        math(String.raw`X`),
        " は有限次元行列 ",
        math(String.raw`A \in \mathrm{Mat}(d, K)`),
        " として表せる。",
      ]),
      paragraph([
        math(String.raw`v \in V`),
        " について、",
        math(String.raw`v`),
        " は数ベクトル ",
        math(String.raw`w \in K^d`),
        " として表せて、",
        math(String.raw`\left(\sum_{n=0}^{\infty} \frac{1}{n!} A^n\right)w`),
        " の各成分は絶対収束する。",
      ]),
      paragraph([todo("TODO: 証明略")]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文も「証明略」として詳細を省いている。"],
    },
  },
  {
    id: "exp_linear_map_002_definition_exp_of_endomorphism",
    kind: "definition",
    sourcePath: "parts/003_線型写像のexp/001_definition_有限次元線型空間の自己準同型のexpの定義.typ",
    sourceOrdinal: 2,
    title: null,
    labels: [],
    statement: [
      paragraph(["有限次元線型空間 ", math(String.raw`V`)]),
      paragraph([
        math(String.raw`\exp : \mathrm{End}(V) \to \mathrm{End}(V)`),
        " を以下のように定める。",
      ]),
      paragraph([
        "線型写像 ",
        math(String.raw`X \in \mathrm{End}(V)`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp(X) := \sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_linear_map_003_theorem_exp_product_formula_commuting_matrices",
    kind: "theorem",
    sourcePath: "parts/003_線型写像のexp/002_theorem_可換行列のexpの積公式.typ",
    sourceOrdinal: 3,
    title: { text: "可換行列の exp 積公式" },
    labels: ["theorem_exp_product"],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " または ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 1}`),
      ]),
      paragraph([
        math(String.raw`A, B \in \mathrm{Mat}(n, K)`),
        " が ",
        math(String.raw`AB = BA`),
        " を満たすとき、",
      ]),
      displayMath(String.raw`\exp(A)\exp(B) = \exp(A + B)`),
    ],
    proof: [
      paragraph([todo("TODO")]),
      paragraph([
        "前提として ",
        ref("exp_converges"),
        "（exp 級数の収束）を用いる。",
      ]),
      paragraph(["証明の骨格："]),
      list([
        [
          "二項定理（",
          math(String.raw`AB = BA`),
          " より）: ",
          math(String.raw`(A+B)^k = \sum_{j=0}^k \binom{k}{j} A^j B^{k-j}`),
        ],
        [
          "exp の定義を展開し、積 ",
          math(String.raw`\exp(A)\exp(B)`),
          " の部分和と ",
          math(String.raw`\exp(A+B)`),
          " の部分和を比較する。",
        ],
        [
          "exp 級数がノルム収束することから、劣乗法性 ",
          math(String.raw`\|XY\| \leq \|X\|\|Y\|`),
          " を用いて、部分和の差がノルムで 0 に収束することを示す。",
        ],
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文も証明のアウトラインのみで詳細は省いている。"],
    },
  },
  {
    id: "exp_linear_map_004_theorem_exp_zero_is_identity",
    kind: "theorem",
    sourcePath: "parts/003_線型写像のexp/003_theorem_零行列のexpはI.typ",
    sourceOrdinal: 4,
    title: { tex: String.raw`\exp(O) = I` },
    labels: ["theorem_exp_zero"],
    statement: [
      paragraph([
        math(String.raw`O`),
        " を零行列、",
        math(String.raw`I`),
        " を単位行列とするとき、",
      ]),
      displayMath(String.raw`\exp(O) = I`),
    ],
    proof: [
      paragraph([
        math(String.raw`\exp`),
        " の定義より、",
        math(String.raw`O^0 = I`),
        "、",
        math(String.raw`n \geq 1`),
        " のとき ",
        math(String.raw`O^n = O`),
        "（零行列の冪）であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(O)
&= \sum_{n=0}^{\infty} \frac{O^n}{n!} \\
&= \frac{I}{0!} + \sum_{n=1}^{\infty} \frac{O}{n!} \\
&= I + O \cdot \sum_{n=1}^{\infty} \frac{1}{n!} \\
&= I + O \\
&= I
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
