import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "exp_conjugation_proof_001_definition_Ad_ad_lie",
    kind: "definition",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/000_リー群リー環アプローチの概要とAd_adの定義.typ",
    sourceOrdinal: 1,
    title: null,
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G`),
        ": リー群、",
        math(String.raw`\mathfrak{g}`),
        ": リー環",
      ]),
      displayMath(
        String.raw`\mathrm{Ad} : G \to \mathrm{Aut}(G), \quad g \mapsto (x \mapsto g x g^{-1})`,
      ),
      displayMath(
        String.raw`\mathrm{ad} : \mathfrak{g} \to \mathrm{End}(\mathfrak{g}), \quad X \mapsto (Y \mapsto [X, Y])`,
      ),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の概要説明（Lie群定理 5.49 の参照）を省略。"],
    },
  },
  {
    id: "exp_conjugation_proof_002_theorem_Ad_exp_lie",
    kind: "theorem",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ",
    sourceOrdinal: 2,
    title: null,
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G`),
        ": Lie群、",
        math(String.raw`\mathfrak{g}`),
        ": Lie環",
      ]),
      displayMath(String.raw`\mathrm{Ad}(\exp(X)) = \exp(\mathrm{ad}(X))`),
    ],
    proof: [
      paragraph([
        todo(
          "TODO: Aut(G) が Lie群であり End(g) がその Lie環であれば上の定理が直接使える。そうでない場合は別途示す必要がある。",
        ),
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_003_definition_M_n_C_convergence",
    kind: "definition",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/002_式変形アプローチの概要と行列空間の内積ノルム収束の定義.typ",
    sourceOrdinal: 3,
    title: { tex: String.raw`M(n;\mathbb{C}) \text{ の内積・ノルム・収束}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`M(n;\mathbb{C})`),
        " を ",
        math(String.raw`\mathbb{C}^{n \times n}`),
        " と同一視することで内積・ノルム・収束を以下のように定義する。",
      ]),
      list([
        [math(String.raw`M(n;\mathbb{C})`), " の内積：", todo("TODO")],
        [math(String.raw`M(n;\mathbb{C})`), " のノルム：", todo("TODO")],
        [math(String.raw`M(n;\mathbb{C})`), " の収束：", todo("TODO")],
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_004_theorem_ad_binomial",
    kind: "theorem",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/003_theorem_ad展開の二項定理的公式_BrianHall_exercise14.typ",
    sourceOrdinal: 4,
    title: { text: "ad 展開の二項定理的公式（Brian Hall exercise 14）" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`K := \mathbb{R}`),
        " もしくは ",
        math(String.raw`K := \mathbb{C}`),
        "、",
        math(String.raw`d \in \mathbb{Z}_{\geq 1}`),
        "、",
        math(String.raw`X, Y \in M(K, d)`),
        " について、",
      ]),
      displayMath(
        String.raw`\underbrace{[X,[X,\dots,[X,Y]\dots]]}_{m\text{ times}}
= \sum_{k=0}^{m} \binom{m}{k} X^k Y (-X)^{m-k}`,
      ),
    ],
    proof: [
      paragraph([todo("TODO: 帰納法で行ける")]),
      paragraph([
        "注意: この定理は Brian Hall「Lie Groups, Lie Algebras, and Representations」Exercise 14 の参考記述であり、このリポジトリでは未証明。証明の根拠として使用することは禁止する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_005_definition_GL_n_C",
    kind: "definition",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/004_definition_一般線型群GL(n,CC)とその群構造.typ",
    sourceOrdinal: 5,
    title: { tex: String.raw`\mathbf{GL}(n,\mathbb{C}) \text{ の定義}（\text{Brian Hall Definition 1.4}）` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\mathrm{GL}(n,\mathbb{C}) := \{x \in \mathrm{M}(n,\mathbb{C}) \mid x \text{ は可逆}\}`,
      ),
      paragraph([
        math(String.raw`\mathbf{GL}(n,\mathbb{C}) := (\mathrm{GL}(n,\mathbb{C}), \cdot)`),
        " は群をなす。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_006_definition_matrix_lie_group",
    kind: "definition",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/005_definition_Matrix_Lie群の定義.typ",
    sourceOrdinal: 6,
    title: { text: "Matrix Lie群（Brian Hall Definition 1.4）" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G \subset \mathbf{GL}(n,\mathbb{C})`),
        " が以下を満たすとき、",
        math(String.raw`G`),
        " を Matrix Lie群という：",
      ]),
      list([
        [math(String.raw`G`), " は部分群"],
        [
          math(String.raw`G`),
          " の元の列 ",
          math(String.raw`A_m`),
          " が ",
          math(String.raw`\mathrm{M}(n,\mathbb{C})`),
          " 上で収束するとき、",
          math(String.raw`A := \lim_{m\to\infty} A_m`),
          " について ",
          math(String.raw`A \in G`),
          " または ",
          math(String.raw`A \notin \mathbf{GL}(n,\mathbb{C})`),
        ],
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_007_definition_Ad_g_ad_X_matrix",
    kind: "definition",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/006_definition_Matrix_Lie群上のAd_gとad_Xの定義.typ",
    sourceOrdinal: 7,
    title: { text: "Ad_g と ad_X の定義（Brian Hall Definition 3.32）" },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`G`),
        ": Matrix Lie群、",
        math(String.raw`g \in G`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{Ad}_g : G \to G, \quad h \mapsto g h g^{-1}`,
      ),
      paragraph([
        math(String.raw`X \in \mathrm{M}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{ad}_X : \mathrm{M}(n,\mathbb{C}) \to \mathrm{M}(n,\mathbb{C}), \quad Y \mapsto [X, Y]`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_008_theorem_exp_ad_series",
    kind: "theorem",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/007_theorem_exp(ad_X)(Y)の級数展開_BrianHall_Prop3.35.typ",
    sourceOrdinal: 8,
    title: { tex: String.raw`e^{\mathrm{ad}_X}(Y) \text{ の級数展開}` },
    labels: ["brianhall_exc14"],
    statement: [
      paragraph([
        math(String.raw`\forall X, Y \in \mathrm{M}(n,\mathbb{C})`),
        " について、",
      ]),
      displayMath(
        String.raw`e^{\mathrm{ad}_X}(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n\text{ times}}
= Y + [X,Y] + \tfrac{1}{2}[X,[X,Y]] + \tfrac{1}{6}[X,[X,[X,Y]]] + \cdots`,
      ),
      paragraph([
        "（",
        math(String.raw`n=0`),
        " のときは ",
        math(String.raw`Y`),
        " とする）",
      ]),
    ],
    proof: [
      paragraph([
        "注意: Brian Hall「Lie Groups, Lie Algebras, and Representations」Proposition 3.35 の参考記述であり、このリポジトリでは未証明。証明の根拠として使用することは禁止する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "exp_conjugation_proof_009_theorem_exp_conjugation_main",
    kind: "theorem",
    sourcePath: "parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/008_theorem_exp(X)Yexp(-X)=Ad(exp(X))(Y)=exp(ad_X)(Y)_BrianHall_Prop3.35.typ",
    sourceOrdinal: 9,
    title: { tex: String.raw`e^X Y e^{-X} = \mathrm{Ad}_{e^X}(Y) = e^{\mathrm{ad}_X}(Y)` },
    labels: ["brianhall_3.35"],
    statement: [
      paragraph([
        math(String.raw`\forall X \in \mathrm{M}(n,\mathbb{C})`),
        " s.t. ",
        math(String.raw`\forall t \in \mathbb{R},\; \exp(tX) \in G`),
        "、",
        math(String.raw`\forall Y \in G`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp(X)\, Y\, \exp(-X) = \mathrm{Ad}_{\exp(X)}(Y) = \exp(\mathrm{ad}_X)(Y)`,
      ),
    ],
    proof: [
      paragraph([
        "注意: Brian Hall「Lie Groups, Lie Algebras, and Representations」Proposition 3.35 の参考記述であり、このリポジトリでは未証明。証明の根拠として使用することは禁止する。",
      ]),
    ],
    conversion: { status: "converted" },
  },
]);
