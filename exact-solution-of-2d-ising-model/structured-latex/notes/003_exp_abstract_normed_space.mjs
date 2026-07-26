import { defineNotes, paragraph, math, displayMath, list, ref } from "../schema.mjs";

// 章「線型写像のexp」に紐づく参照用ノート。文書本体ではない。
//
// ここに集めたのは、exp 級数の収束を「体 K（R または C）上の抽象的な有限次元ノルム線型空間 V」と
// その自己準同型 X : V -> V について述べる経路である。これはもともと
// content/003_exp_linear_map.mjs の本文ブロック
// exp_linear_map_001_theorem_exp_series_pointwise_converges（labels: exp_converges）と
// exp_linear_map_002_definition_exp_of_endomorphism（labels: def_exp）の記述そのものだったが、
// README のゴール設定（4 節「主張は複素行列について具体的に述べる。一般の環・体へ持ち上げない」、
// 3 節 4「暗黙に使われている未定義の概念を残さない」、6 節「採用しなかった経路の扱い」）
// に従ってここへ退避した。**ゴールに照らして本文には採用しなかった。**
// 理由: 読者に線型空間の一般論（基底の存在、座標写像、線型同型、次元、ノルム線型空間の公理）を
// 先に要求するため。
//
// 本文が採ったのは、Mat(n,K) の行列と Mat(n,K) 上の K-線型写像について具体的に述べる経路であり、
// labels: exp_converges と labels: def_exp で自己完結している。

const NOT_ADOPTED = paragraph([
  "【ゴールに照らして本文には採用しなかった。理由: 読者に線型空間の一般論（基底の存在・座標写像・",
  "線型同型・次元・ノルム線型空間の公理）を先に要求し、本筋と無関係なところで負担を生むため。】",
  "本文（",
  ref("exp_converges"),
  "、",
  ref("def_exp"),
  "）は、行列と行列上の線型写像について具体的に述べることで同じ結論に到達しており、",
  "抽象的なノルム線型空間をいっさい経由しない。",
]);

export default defineNotes([
  {
    id: "note_exp_linear_map_001_theorem_exp_series_pointwise_converges_abstract",
    targets: ["exp_converges"],
    title: {
      text: "抽象的な有限次元ノルム線型空間での exp 級数の各点収束（本文不採用）",
    },
    sourcePath:
      "_old/typst/parts/003_線型写像のexp/000_theorem_線型写像のexpの級数が各点収束すること.typ",
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/003_exp_linear_map.mjs のブロック ",
        "exp_linear_map_001_theorem_exp_series_pointwise_converges の記述。",
        "以下は退避時点のものを要約したものであり、厳密である必要はない。）",
      ]),
      paragraph([
        "主張: 体 ",
        math(String.raw`K`),
        " を ",
        math(String.raw`\mathbb{R}`),
        " または ",
        math(String.raw`\mathbb{C}`),
        "、",
        math(String.raw`V`),
        " を有限次元 ",
        math(String.raw`K`),
        "-ノルム線型空間（ノルムを ",
        math(String.raw`\|\cdot\|_V`),
        " と書く）とする。線型写像 ",
        math(String.raw`X : V \to V`),
        " について",
      ]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
      paragraph(["は線型写像 ", math(String.raw`V \to V`), " に各点収束する。"]),
      paragraph(["証明の道筋は次の通りだった。"]),
      list([
        [
          math(String.raw`d := \dim_K V`),
          " とおく。",
          math(String.raw`d=0`),
          " なら ",
          math(String.raw`V=\{0\}`),
          " で部分和はすべて零写像なので自明。以下 ",
          math(String.raw`d\ge 1`),
          "。",
        ],
        [
          math(String.raw`V`),
          " の基底 ",
          math(String.raw`e_1,\dots,e_d`),
          " をとり、座標写像 ",
          math(String.raw`c : V \to K^d,\ c\!\left(\sum_i w_ie_i\right):=(w_1,\dots,w_d)`),
          " が線型同型であることを使う。",
          math(String.raw`X(e_j)=\sum_i A_{ij}e_i`),
          " で行列 ",
          math(String.raw`A\in\mathrm{Mat}(d,K)`),
          " を定めると ",
          math(String.raw`c(X^n(v))=A^n c(v)`),
          "。",
        ],
        [
          "行列側の級数 ",
          math(String.raw`S:=\sum_{m\ge 0}\frac{1}{m!}A^m`),
          " の ",
          math(String.raw`\mathrm{Mat}(d,K)`),
          " での収束（本文の ",
          ref("matrix_exp_series_converges"),
          "）に帰着させる。",
        ],
        [
          math(String.raw`C:=\sqrt{\sum_i\|e_i\|_V^2}^{\,(\mathbb{R}_{\ge 0})}`),
          " とおくと、三角不等式と Cauchy--Schwarz の不等式だけで片側評価 ",
          math(String.raw`\left\|c^{-1}(t)\right\|_V \le C\,\|t\|`),
          "（",
          math(String.raw`t\in K^d`),
          "）が得られる。これにより ",
          math(String.raw`V`),
          " のノルムが基底から定まるノルムと異なりうる点を処理でき、",
          "有限次元ノルムの同値性定理は不要だった。",
        ],
        [
          "以上から ",
          math(String.raw`T(v):=c^{-1}(S\,c(v))`),
          " とおくと ",
          math(String.raw`\|T_N(v)-T(v)\|_V \le C\,\|S_N-S\|\cdot\|c(v)\| \to 0`),
          " となり各点収束する。",
          math(String.raw`T`),
          " は線型写像の合成なので線型。",
        ],
      ]),
      paragraph([
        "本文へ採用しなかった理由（README 4 節・3 節 4）は 2 つある。第 1 に、",
        "主張が抽象的な ",
        math(String.raw`V`),
        " について述べられているため、読者は線型空間・基底の存在・次元・線型同型の一般論を",
        "先に要求される。第 2 に、証明が「ノルム線型空間の公理」を使っているのに、",
        "本文には「ノルム線型空間」を定義したブロックが無かった（本文にあるのは ",
        ref("def_matrix_norm"),
        " による ",
        math(String.raw`K^d`),
        " と ",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " のノルムだけである）。すなわち未定義の概念が本文に残っていた。",
      ]),
      paragraph([
        "本文で実際に必要なのは次の 2 つの形だけであり、いずれも抽象論なしで直接書ける。",
      ]),
      list([
        [
          math(String.raw`\mathrm{Mat}(n,K)`),
          " の行列が ",
          math(String.raw`K^n`),
          " の数ベクトルに作用する場合（転送行列 ",
          math(String.raw`V_1, V_2`),
          " はこちら。",
          ref("def_end_iso"),
          " の同一視により ",
          math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
          " の行列として扱われる）。",
        ],
        [
          math(String.raw`\mathrm{Mat}(n,K)`),
          " 上の ",
          math(String.raw`K`),
          "-線型写像の場合（",
          ref("def_ad_X_matrix"),
          " の ",
          math(String.raw`\mathrm{ad}_X(Z)=[X,Z]`),
          " はこちら）。この場合の収束は、行列単位 ",
          math(String.raw`E^{(k,l)}`),
          " による展開 ",
          math(String.raw`Y=\sum_{k,l}y_{kl}E^{(k,l)}`),
          "（行列の成分の定義からその場で確かめられる等式であり、",
          "「基底が存在する」という一般論ではない）と Cauchy--Schwarz の不等式から得られる評価 ",
          math(String.raw`\|\Phi(Y)\|\le c_\Phi\|Y\|`),
          " だけで従う。",
        ],
      ]),
    ],
  },
  {
    id: "note_exp_linear_map_002_definition_exp_of_endomorphism_abstract",
    targets: ["def_exp"],
    title: { text: "有限次元線型空間の自己準同型としての exp の定義（本文不採用）" },
    sourcePath:
      "_old/typst/parts/003_線型写像のexp/001_definition_有限次元線型空間の自己準同型のexpの定義.typ",
    body: [
      NOT_ADOPTED,
      paragraph([
        "（もと content/003_exp_linear_map.mjs のブロック ",
        "exp_linear_map_002_definition_exp_of_endomorphism の記述。以下は退避時点のまま。）",
      ]),
      paragraph(["有限次元線型空間 ", math(String.raw`V`)]),
      paragraph([
        math(String.raw`\exp : \mathrm{End}(V) \to \mathrm{End}(V)`),
        " を以下のように定める。線型写像 ",
        math(String.raw`X \in \mathrm{End}(V)`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp(X) := \sum_{n=0}^{\infty} \frac{1}{n!} \underbrace{X \circ X \circ \cdots \circ X}_{n \text{ times}}`,
      ),
      paragraph([
        "本文ではこの定義を、",
        ref("def_exp"),
        " の (1)（",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " の行列の exp）と (2)（",
        math(String.raw`\mathrm{Mat}(n,K)`),
        " 上の ",
        math(String.raw`K`),
        "-線型写像の exp）の 2 つに具体化して置き換えた。",
        "本文で exp が適用される対象はこの 2 通りだけであり、",
        math(String.raw`\mathrm{End}(V)`),
        " という抽象的な対象を導入する必要はない。",
      ]),
    ],
  },
]);
