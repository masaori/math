import { defineNotes, paragraph, math, displayMath, list, todo, ref } from "../schema.ts";

// 章「e^X Y e^{-X} = e^{ad(X)}(Y) の証明」に紐づく参照用ノート。文書本体ではない。
//
// ここに集めたのは、指数関数の共役をリー群・リー環の一般論（随伴表現 Ad / ad、
// リー群上の Ad(exp X) = exp(ad X)、GL(n,C)、Matrix Lie 群）で扱う経路である。
// これらはもともと content/005_exp_conjugation_proof.ts の本文ブロックだったが、
// README のゴール設定（1 節「典型例がリー群・リー環である」、6 節「採用しなかった経路の扱い」）
// に従ってここへ退避した。**ゴールに照らして本文には採用しなかった。**
// 理由: リー群の一般論を先に理解しないと証明を追えなくなり、本筋と無関係なところで
// 読者の負担を生むため。
//
// 本文が採ったのは級数展開だけで済ませる経路であり、
// labels: ad_binomial（純代数の ad 展開公式）と labels: matrix_exp_conjugation
// （行列版 e^X Y e^{-X} = e^{ad_X}(Y)）で自己完結している。

const NOT_ADOPTED = paragraph([
  "【ゴールに照らして本文には採用しなかった。理由: リー群の一般論を先に理解しないと証明を追えなくなり、",
  "本筋と無関係なところで読者の負担を生むため。】本文（",
  ref("matrix_exp_conjugation"),
  "）は級数展開だけで同じ結論に到達しており、リー群・リー環をいっさい経由しない。",
]);

export default defineNotes([
  {
    id: "note_exp_conjugation_lie_001_definition_Ad_ad_lie",
    targets: ["matrix_exp_conjugation"],
    title: { text: "リー群・リー環アプローチの概要と Ad, ad の定義（本文不採用）" },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/000_リー群リー環アプローチの概要とAd_adの定義.typ",
      ordinal: 1,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_001_definition_Ad_ad_lie。labels は付いていなかった。以下は原文のまま。）",
      ]),
      paragraph(["リー群・リー環を使うアプローチの概要（参考: 「Lie群とLie環1」定理 5.49）。"]),
      paragraph([
        math(String.raw`G, H`),
        ": Lie群、連続な準同型写像 ",
        math(String.raw`\phi : G \to H`),
        " について、",
      ]),
      list([
        [math(String.raw`\phi`), " は ", math(String.raw`C^{\omega}`), " 級である。"],
        [
          "Lie環 ",
          math(String.raw`\mathfrak{g} := \mathrm{Lie}(G)`),
          " から ",
          math(String.raw`\mathfrak{h} := \mathrm{Lie}(H)`),
          " への準同型写像 ",
          math(String.raw`\mathrm{d}\phi_e : \mathfrak{g} \to \mathfrak{h}`),
          " が存在し、",
          math(String.raw`\phi(\exp(X)) = \exp(\mathrm{d}\phi_e(X))`),
          " を満たす。",
        ],
      ]),
      paragraph([
        "この定理の証明を参考に、以下の定理を示したい。以下、",
        math(String.raw`\mathrm{Ad}`),
        "、",
        math(String.raw`\mathrm{ad}`),
        " を定める。",
      ]),
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
      paragraph([
        "（もとブロックの変換メモ: 原文冒頭の概要説明（Lie群・Lie環アプローチと参考定理 5.49）と ",
        "Ad, ad の定義を忠実に反映した。）",
      ]),
    ],
  },
  {
    id: "note_exp_conjugation_lie_002_theorem_Ad_exp_lie",
    targets: ["matrix_exp_conjugation"],
    title: { tex: String.raw`\text{リー群上の } \mathrm{Ad}(\exp(X)) = \exp(\mathrm{ad}(X))\ \text{（本文不採用）}` },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ",
      ordinal: 2,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_002_theorem_Ad_exp_lie。labels は付いていなかった。以下は原文のまま。）",
      ]),
      paragraph([
        math(String.raw`G`),
        ": Lie群、",
        math(String.raw`\mathfrak{g}`),
        ": Lie環",
      ]),
      displayMath(String.raw`\mathrm{Ad}(\exp(X)) = \exp(\mathrm{ad}(X))`),
      paragraph([
        "本プロジェクトで実際に必要なのは、この一般の Lie 群に対する主張ではなく、行列環 ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        "（",
        math(String.raw`K=\mathbb{R}`),
        " または ",
        math(String.raw`\mathbb{C}`),
        "）における",
      ]),
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)=\exp\!\left(\mathrm{ad}_X\right)(Y)
\qquad \left(X,Y\in\mathrm{Mat}(n,K)\right)`,
      ),
      paragraph([
        "だけである。この行列版は ",
        ref("matrix_exp_conjugation"),
        " で証明済みであり、その証明は Lie 群論をいっさい使わず、",
        ref("ad_binomial"),
        "（純代数的な ad 展開公式）と ",
        ref("real_exp_series_converges"),
        "・",
        ref("matrix_norm_submultiplicativity"),
        "・",
        ref("matrix_exp_series_converges"),
        "（指数級数の絶対収束と行列ノルムの劣乗法性）だけから自己完結している。以降の議論はすべて ",
        ref("matrix_exp_conjugation"),
        " を根拠として使い、本ブロックの一般 Lie 群版を根拠として使うことはない。",
      ]),
      paragraph(["（もとブロックの proof）"]),
      paragraph([
        "本ブロックの一般 Lie 群版は未証明である。理由は、このリポジトリに Lie 群・Lie 環・",
        math(String.raw`\mathrm{Lie}(G)`),
        "・",
        math(String.raw`\mathrm{Aut}(G)`),
        " の Lie 群構造を定義したブロックが存在せず（",
        ref("def_frobenius_inner_product"),
        " から先で扱っているのは行列環 ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " とその上のノルム位相だけである）、主張の記号が意味をもつ土台自体が未整備だからである。",
      ]),
      paragraph([
        todo(
          "TODO（一般 Lie 群版）: 多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備し、Aut(G) が Lie 群で End(g) がその Lie 環であることを示したうえで証明する。本プロジェクトで必要な行列版は matrix_exp_conjugation で証明済みであり、この TODO は本論の依存関係には入らない。",
        ),
      ]),
      paragraph([
        "（もとブロックの変換メモ: 原文（Typst）の proof も TODO のみ。一般 Lie 群版は土台",
        "（Lie 群・Lie 環の定義ブロック）がリポジトリに存在しないため未証明のまま残し、",
        "本論で必要な行列版（labels: matrix_exp_conjugation）を新規に追加して証明した旨を statement に明記した。）",
      ]),
    ],
  },
  {
    id: "note_exp_conjugation_lie_003_definition_GL_n_C",
    targets: ["def_ad_X_matrix"],
    title: { tex: String.raw`\mathbf{GL}(n,\mathbb{C}) \text{ の定義}（\text{Brian Hall Definition 1.4}）\text{（本文不採用）}` },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/004_definition_一般線型群GL(n,CC)とその群構造.typ",
      ordinal: 3,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_005_definition_GL_n_C。labels は付いていなかった。以下は原文のまま。）",
      ]),
      displayMath(
        String.raw`\mathrm{GL}(n,\mathbb{C}) := \{x \in \mathrm{M}(n,\mathbb{C}) \mid x \text{ は可逆}\}`,
      ),
      paragraph([
        math(String.raw`\mathbf{GL}(n,\mathbb{C}) := (\mathrm{GL}(n,\mathbb{C}), \cdot)`),
        " は群をなす。",
      ]),
    ],
  },
  {
    id: "note_exp_conjugation_lie_004_definition_matrix_lie_group",
    targets: ["def_ad_X_matrix"],
    title: { text: "Matrix Lie群（Brian Hall Definition 1.4）（本文不採用）" },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/005_definition_Matrix_Lie群の定義.typ",
      ordinal: 4,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_006_definition_matrix_lie_group、labels: def_matrix_lie_group。",
        "本文から外したのでこのラベルは content 側に存在しない。以下は原文のまま。）",
      ]),
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
  },
  {
    id: "note_exp_conjugation_lie_005_definition_Ad_g_ad_X_matrix",
    targets: ["def_ad_X_matrix"],
    title: { text: "Ad_g と ad_X の定義（Brian Hall Definition 3.32）（本文不採用）" },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/006_definition_Matrix_Lie群上のAd_gとad_Xの定義.typ",
      ordinal: 5,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_007_definition_Ad_g_ad_X_matrix、labels: def_ad_X_matrix。",
        "本文では、Matrix Lie群 ",
        math(String.raw`G`),
        " を経由しない具体版の定義ブロック（同じ labels: def_ad_X_matrix）へ置き換えた。以下は原文のまま。）",
      ]),
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
  },
  {
    id: "note_exp_conjugation_lie_006_theorem_matrix_lie_group_version",
    targets: ["matrix_exp_conjugation"],
    title: { tex: String.raw`\text{Matrix Lie群版: } e^X Y e^{-X} = \mathrm{Ad}_{e^X}(Y) = e^{\mathrm{ad}_X}(Y)\text{（本文不採用）}` },
    origin: {
      path: "_old/typst/parts/005_exp(X)Yexp(-X)=exp(ad(X))(Y)の証明/008_theorem_exp(X)Yexp(-X)=Ad(exp(X))(Y)=exp(ad_X)(Y)_BrianHall_Prop3.35.typ",
      ordinal: 6,
    },
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/005_exp_conjugation_proof.ts のブロック ",
        "exp_conjugation_proof_009_theorem_exp_conjugation_main、labels: brianhall_3.35。",
        "本文に残した ",
        ref("matrix_exp_conjugation"),
        " が同じ等式を Matrix Lie群を使わずに述べているので、本ブロックは本文から外した。",
        "以下は原文のままだが、Matrix Lie群の定義への参照だけは本文から外れたため、",
        "ノート note_exp_conjugation_lie_004_definition_matrix_lie_group への言及に置き換えてある。）",
      ]),
      paragraph([
        math(String.raw`n\in\mathbb{Z}_{\ge 1}`),
        "、",
        math(String.raw`G\subset\mathbf{GL}(n,\mathbb{C})`),
        " を note_exp_conjugation_lie_004_definition_matrix_lie_group の意味の Matrix Lie群とする。",
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
      paragraph([
        "ここで ",
        math(String.raw`\mathrm{Ad}_{g}`),
        "、",
        math(String.raw`\mathrm{ad}_X`),
        " は ",
        ref("def_ad_X_matrix"),
        "、",
        math(String.raw`\exp`),
        " は ",
        ref("def_exp"),
        "、",
        math(String.raw`\exp(\mathrm{ad}_X)(Y)`),
        " は ",
        ref("brianhall_exc14"),
        " の級数 ",
        math(String.raw`\sum_{m=0}^{\infty}\frac{1}{m!}\mathrm{ad}_X^{m}(Y)`),
        " である。",
      ]),
      paragraph(["（もとブロックの proof）"]),
      paragraph([
        "Step 0: 記号がどの集合に属するか。",
        math(String.raw`G\subset\mathbf{GL}(n,\mathbb{C})\subset\mathrm{M}(n,\mathbb{C})`),
        " であるから ",
        math(String.raw`Y\in G\subset\mathrm{M}(n,\mathbb{C})`),
        " であり、仮定より ",
        math(String.raw`X\in\mathrm{M}(n,\mathbb{C})`),
        "。したがって ",
        ref("matrix_exp_conjugation"),
        " を ",
        math(String.raw`K:=\mathbb{C}`),
        "、この ",
        math(String.raw`X,Y`),
        " に対して適用できる。",
      ]),
      paragraph([
        "Step 1: 等式そのもの。",
        ref("matrix_exp_conjugation"),
        " (2) より",
      ]),
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)
= \sum_{m=0}^{\infty}\frac{1}{m!}\,\mathrm{ad}_X^{m}(Y)
= \exp\!\left(\mathrm{ad}_X\right)(Y)`,
      ),
      paragraph([
        "であり、",
        ref("matrix_exp_conjugation"),
        " (3) より ",
        math(String.raw`\exp(X)`),
        " は正則で ",
        math(String.raw`\exp(X)^{-1}=\exp(-X)`),
        " であるから、",
        ref("def_ad_X_matrix"),
        " の ",
        math(String.raw`\mathrm{Ad}_{\exp(X)}`),
        " について",
      ]),
      displayMath(
        String.raw`\mathrm{Ad}_{\exp(X)}(Y)=\exp(X)\,Y\,\exp(X)^{-1}=\exp(X)\,Y\,\exp(-X)`,
      ),
      paragraph([
        "。以上を合わせて主張の 2 つの等号を得る。",
      ]),
      paragraph([
        "Step 2: 仮定 ",
        math(String.raw`\forall t\in\mathbb{R},\ \exp(tX)\in G`),
        " と ",
        math(String.raw`Y\in G`),
        " が使われる箇所。",
        ref("def_ad_X_matrix"),
        " の ",
        math(String.raw`\mathrm{Ad}_g`),
        " は ",
        math(String.raw`G\to G`),
        " の写像として定義されているので、",
        math(String.raw`\mathrm{Ad}_{\exp(X)}(Y)`),
        " という記号が意味をもつためには ",
        math(String.raw`\exp(X)\in G`),
        " かつ ",
        math(String.raw`\exp(X)Y\exp(X)^{-1}\in G`),
        " が必要である。前者は仮定を ",
        math(String.raw`t=1`),
        " として適用すれば得られ、後者は ",
        math(String.raw`G`),
        " が ",
        math(String.raw`\mathbf{GL}(n,\mathbb{C})`),
        " の部分群である（note_exp_conjugation_lie_004_definition_matrix_lie_group の第 1 条件）ことから ",
        math(String.raw`\exp(X)\in G,\ \exp(X)^{-1}\in G,\ Y\in G`),
        " の積として従う。",
      ]),
      paragraph([
        "すなわち、仮定 ",
        math(String.raw`\forall t\in\mathbb{R},\ \exp(tX)\in G`),
        "・",
        math(String.raw`Y\in G`),
        " は ",
        math(String.raw`\mathrm{Ad}_{\exp(X)}`),
        " を ",
        math(String.raw`G`),
        " 上の写像として読むためだけに使われ、等式 ",
        math(String.raw`\exp(X)Y\exp(-X)=\exp(\mathrm{ad}_X)(Y)`),
        " 自体は ",
        ref("matrix_exp_conjugation"),
        " により任意の ",
        math(String.raw`X,Y\in\mathrm{M}(n,\mathbb{C})`),
        " について成り立つ。note_exp_conjugation_lie_004_definition_matrix_lie_group の第 2 条件",
        "（極限に関する閉性）は本証明では使わない。",
      ]),
      paragraph([
        "（もとブロックの変換メモ: 原文（Typst）の proof は Brian Hall Prop 3.35 への参照のみで、",
        "構造化側でも「未証明につき使用禁止」の注記を置いていた。しかし本ブロックの主張は ",
        "labels: matrix_exp_conjugation（行列版、content 側で完全証明済み）の系であり、",
        "G に関する仮定は Ad_{exp X} を G 上の写像として読むためにしか使われない。",
        "そのことを含めて証明を書き、使用禁止の注記を撤回した。）",
      ]),
    ],
  },
]);
