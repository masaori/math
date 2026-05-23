import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "TV1_hatZ_hatY_001_claim_commutator_H_Z_Y",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ",
    sourceOrdinal: 1,
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ と } \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu \text{ の交換関係}` },
    labels: ["commutator_of_H_and_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(
        String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= 2 e^{-i 2\pi\mu/M} \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= 2 e^{-i 2\pi\mu/M} \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Y}_\mu]
&= -2 e^{i 2\pi\mu/M} \hat{Z}_\mu^{(\pm)} \\
[H_2, \hat{Z}_\mu^{(-)}]
&= -2 \hat{Y}_\mu \\
[H_2, \hat{Y}_\mu]
&= 2 \hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]`),
        " について：",
        math(String.raw`H_1^{(\pm)}`),
        " を ",
        ref("transfer_matrix_012_claim_H1_H2_via_hatZ_hatY"),
        " の表式で展開し、",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " の反交換関係 ",
        math(String.raw`[\hat{Z}_{-j}^{(\pm)}, \hat{Z}_\mu^{(\pm)}]_+ = 2M\,\delta^M_{-j+\mu,0}\,I`),
        " を用いると、",
      ]),
      displayMath(
        String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
= 2 \sum_{\substack{j \in \{1,\dots,M\} \\ -j+\mu \equiv 0 \pmod{M}}}
  e^{-i 2\pi j/M} \hat{Y}_j
= 2 e^{-i 2\pi\mu/M} \hat{Y}_\mu`,
      ),
      paragraph([
        "残りの関係式も同様（",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        "、",
        ref("exp_sum"),
        " を繰り返し適用）。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の長大な計算展開を要点のみに圧縮。[H2, hatZ^(+)] の式は省略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_002_claim_nesting_commutator",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ",
    sourceOrdinal: 2,
    title: null,
    labels: ["nesting_of_commutator_of_H_and_Z"],
    statement: [
      paragraph([math(String.raw`n \geq 0`), " とする。"]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_1)^n e^{-i 2\pi\mu/M} \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（ただし ",  math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Z}_\mu^{(\pm)}`), "）"]),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_1)^n e^{i 2\pi\mu/M} \hat{Z}_\mu^{(\pm)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([todo("TODO: 帰納法で示す（", ref("commutator_of_H_and_Z_Y"), " を繰り返し適用）")]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文は note で n=0,1,2,3,4 の具体例を詳述している。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/002_claim_cosh_sinhの展開係数への変換.typ",
    sourceOrdinal: 3,
    title: null,
    labels: [],
    statement: [
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \begin{cases}
i K_1^n e^{-i 2\pi\mu/M} \hat{Y}_\mu & (n \text{ 奇数}) \\
K_1^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["（(h1.y), (h2.y) も同様）"]),
    ],
    proof: [
      paragraph([
        ref("nesting_of_commutator_of_H_and_Z"),
        " に ",
        math(String.raw`K_1 \to \tfrac{i}{2}K_1`),
        " （それぞれ適切なスケール）を代入して ",
        math(String.raw`(-1)^{(n-1)/2} \cdot i^n = i`),
        " 等を計算すると得られる。",
      ]),
    ],
    conversion: { status: "partially_simplified", notes: ["原文の代入計算を圧縮。"] },
  },
  {
    id: "TV1_hatZ_hatY_004_claim_sinh_cosh_taylor",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/003_claim_sinh_coshのテイラー展開.typ",
    sourceOrdinal: 4,
    title: { tex: String.raw`\sinh, \cosh \text{ のテイラー展開}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_005_claim_extract_taylor_coefficient",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ",
    sourceOrdinal: 5,
    title: null,
    labels: ["extract_taylor_coefficient_of_Z_Y"],
    statement: [
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}(\cdots)
= -i e^{i 2\pi\mu/M}\sinh(K_1)\hat{Z}_\mu^{(\pm)} + \cosh(K_1)\hat{Y}_\mu`,
      ),
      paragraph(["(h2.z−)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{[i K_2^* H_2,\dots,[i K_2^* H_2,\hat{Z}_\mu^{(-)}]\dots]}_{n}
= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}(\cdots)
= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        ref("TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion"),
        " を偶数項・奇数項に分けると、",
      ]),
      displayMath(
        String.raw`\text{(h1.z) 左辺} = \left(\sum_{\substack{n\geq 0 \\ n \text{ 偶}}} \frac{K_1^n}{n!}\right)\hat{Z}_\mu^{(\pm)} + i e^{-i 2\pi\mu/M}\left(\sum_{\substack{n\geq 1 \\ n \text{ 奇}}} \frac{K_1^n}{n!}\right)\hat{Y}_\mu = \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu`,
      ),
      paragraph(["他の場合も同様。"]),
    ],
    conversion: { status: "partially_simplified", notes: ["原文の (h1.y) の証明中に誤植あり（expの符号）。"] },
  },
  {
    id: "TV1_hatZ_hatY_006_claim_exp_conjugation",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/005_claim_exp_X_Y_exp_minus_X.typ",
    sourceOrdinal: 6,
    title: null,
    labels: ["exp_X_Y_exp_-X"],
    statement: [
      displayMath(
        String.raw`\exp(X)\,Y\,\exp(-X)
= \mathrm{Ad}_{\exp(X)}(Y)
= \exp(\mathrm{ad}_X)(Y)
= \sum_{n=0}^{\infty} \frac{1}{n!}
  \underbrace{[X,[X,\dots,[X,Y]\dots]]}_{n}`,
      ),
      paragraph([
        "（",
        math(String.raw`n=0`),
        " のとき括弧なしで ",
        math(String.raw`Y`),
        "）",
      ]),
    ],
    proof: [
      paragraph([
        "（暫定）リー群・リー環の掘り下げを避けて一旦受け入れる（",
        ref("brianhall_3.35"),
        " 参照）。行列級数の直接計算でも示せると思われる。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_007_definition_automorphism_groups",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/006_definition_自己同型群_内部自己同型群_外部自己同型群.typ",
    sourceOrdinal: 7,
    title: { text: "自己同型群・内部自己同型群・外部自己同型群" },
    labels: [],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`\mathrm{Aut}(G) := \{\varphi \mid \varphi : G \to G,\; \varphi \text{ は群同型}\}`,
      ),
      paragraph(["を ", math(String.raw`G`), " の自己同型群という。"]),
      paragraph([
        math(String.raw`g \in G`),
        " について ",
        math(String.raw`\varphi_g : G \to G,\; h \mapsto ghg^{-1}`),
        " と定め、",
        math(String.raw`\varphi : G \to \mathrm{Aut}(G),\; g \mapsto \varphi_g`),
        " の像 ",
        math(String.raw`\mathrm{Im}(\varphi)`),
        " を内部自己同型群 ",
        math(String.raw`\mathrm{Inn}(G)`),
        " という。",
      ]),
      displayMath(
        String.raw`\mathrm{Out}(G) := \mathrm{Aut}(G)/\mathrm{Inn}(G) \quad \text{（外部自己同型群）}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_008_definition_exact_sequence_aut",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/007_definition_自己同型群の完全列.typ",
    sourceOrdinal: 8,
    title: { text: "自己同型群の完全列" },
    labels: [],
    statement: [
      paragraph(["群 ", math(String.raw`G`), " について、"]),
      displayMath(
        String.raw`1 \to Z(G) \to G \to \mathrm{Aut}(G) \to \mathrm{Out}(G) \to 1`,
      ),
      paragraph(["は完全列をなす。"]),
      paragraph([todo("TODO: Ker, Im の定義、Z(G) の定義、完全列の定義")]),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_009_definition_ring_multiplicative_group",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/008_definition_環の乗法群.typ",
    sourceOrdinal: 9,
    title: { text: "環の乗法群" },
    labels: [],
    statement: [
      paragraph(["環 ", math(String.raw`\mathbf{R} = (R, +_R, \cdot_R)`), " について、"]),
      displayMath(
        String.raw`\mathbf{R}^\times := \{r \in \mathbf{R} \mid r \text{ は } \cdot_R \text{ について可逆}\}`,
      ),
      paragraph([
        math(String.raw`\mathbf{R}^\times`),
        " は ",
        math(String.raw`\cdot_R`),
        " について群をなす。これを ",
        math(String.raw`\mathbf{R}`),
        " の乗法群という。",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_010_definition_clifford_group",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/009_definition_TODO_クリフォード群.typ",
    sourceOrdinal: 10,
    title: { text: "クリフォード群（TODO）" },
    labels: [],
    statement: [
      list([
        ["クリフォード群の定義（2×2 パウリ行列のテンソル積から構成）"],
        [math(String.raw`T_g`), " の定義をクリフォード群の元に限定する"],
        [
          math(String.raw`T`),
          " の（定数倍を除いた）単射性が重要と考えられるため示す",
        ],
      ]),
      paragraph([todo("TODO: 3つのアプローチを検討中")]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_011_definition_T_g",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/010_definition_T_g.typ",
    sourceOrdinal: 11,
    title: { tex: String.raw`T_g \text{ の定義}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`g \in (\mathrm{Mat}(2,\mathbb{C})^{\otimes M})^\times`),
        " について、",
      ]),
      displayMath(
        String.raw`T_g : \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \to \mathrm{Mat}(2,\mathbb{C})^{\otimes M}, \quad h \mapsto g \cdot h \cdot g^{-1}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_012_claim_TV1_TV2_actions",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/011_claim_ホロノミック量子場_p142下段.typ",
    sourceOrdinal: 12,
    title: { text: "ホロノミック量子場 p142 下段" },
    labels: ["ホロノミック量子場_p142下段_1"],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu \\
T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
&= -i e^{i 2\pi\mu/M}\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu \\
T_{V_2}(\hat{Z}_\mu^{(-)})
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu \\
T_{V_2}(\hat{Y}_\mu)
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})`),
        " について：",
      ]),
      displayMath(
        String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
= e^{\frac{i}{2}K_1 H_1^{(\pm)}} \hat{Z}_\mu^{(-)} e^{-\frac{i}{2}K_1 H_1^{(\pm)}}
\overset{\text{\ref{exp_X_Y_exp_-X}}}{=} \sum_{n=0}^\infty \frac{1}{n!}[\cdots]_n
\overset{\text{\ref{extract_taylor_coefficient_of_Z_Y}}}{=} \cosh(K_1)\hat{Z}_\mu^{(-)} + i e^{-i 2\pi\mu/M}\sinh(K_1)\hat{Y}_\mu`,
      ),
      paragraph([
        math(String.raw`T_{V_2}(\hat{Z}_\mu^{(-)})`),
        " について：",
        math(String.raw`(2s_2)^{M/2}`),
        " のスカラーは共役で打ち消し合い、",
        ref("extract_taylor_coefficient_of_Z_Y"),
        " (h2.z−) から直接。",
      ]),
    ],
    conversion: { status: "partially_simplified", notes: ["原文の行列表示も省略。"] },
  },
  {
    id: "TV1_hatZ_hatY_013_definition_product_maps",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/012_definition_T_V1_T_V2の直積写像.typ",
    sourceOrdinal: 13,
    title: null,
    labels: [],
    statement: [
      displayMath(
        String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(X, Y) := \left(T_{(V_1^{(\pm)})^{1/2}}(X),\; T_{(V_1^{(\pm)})^{1/2}}(Y)\right)`,
      ),
      displayMath(
        String.raw`\left(T_{V_2} \times T_{V_2}\right)(X, Y) := \left(T_{V_2}(X),\; T_{V_2}(Y)\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_014_claim_product_action_computation",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/013_claim_T_V1_T_V2のhatZ_hatYへの直積作用の計算.typ",
    sourceOrdinal: 14,
    title: null,
    labels: ["calc_of_TxT_hatZxhatY"],
    statement: [
      displayMath(
        String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh K_1 & -i e^{i\theta_\mu}\sinh K_1 \\
i e^{-i\theta_\mu}\sinh K_1 & \cosh K_1
\end{pmatrix}`,
      ),
      displayMath(
        String.raw`\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh 2K_2^* & i\sinh 2K_2^* \\
-i\sinh 2K_2^* & \cosh 2K_2^*
\end{pmatrix}`,
      ),
      paragraph(["ただし ", math(String.raw`\theta_\mu := 2\pi\mu/M`), "。"]),
    ],
    proof: [
      paragraph([
        ref("ホロノミック量子場_p142下段_1"),
        " の各成分を行列形式にまとめると得られる。",
      ]),
    ],
    conversion: { status: "partially_simplified" },
  },
  {
    id: "TV1_hatZ_hatY_015_claim_linearity_of_T",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/014_claim_T_Vの線型性.typ",
    sourceOrdinal: 15,
    title: null,
    labels: ["linearity_of_T"],
    statement: [
      paragraph([
        math(String.raw`\forall a, b \in \mathbb{C}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V_1^{(\pm)})^{1/2}}(a\hat{Z}_\mu^{(-)} + b\hat{Y}_\mu)
= a\,T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}) + b\,T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)`,
      ),
      displayMath(
        String.raw`T_{V_2}(a\hat{Z}_\mu^{(-)} + b\hat{Y}_\mu)
= a\,T_{V_2}(\hat{Z}_\mu^{(-)}) + b\,T_{V_2}(\hat{Y}_\mu)`,
      ),
    ],
    proof: [paragraph(["表式より、それぞれただの1次関数なので自明。"])],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_016_definition_T_V",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/015_definition_T_V.typ",
    sourceOrdinal: 16,
    title: { tex: String.raw`T_{(V)} \text{ の定義}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\forall X \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について、",
      ]),
      displayMath(
        String.raw`T_{(V)}(X) := T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_017_definition_A_theta",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/016_definition_A_theta.typ",
    sourceOrdinal: 17,
    title: { tex: String.raw`A(\theta) \text{ の定義}` },
    labels: ["def_A_theta"],
    statement: [
      paragraph([math(String.raw`\theta \in \mathbb{C}`), " について、"]),
      displayMath(
        String.raw`A(\theta) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta &
i e^{i\theta} s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) \\
-i e^{-i\theta} s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2) &
c_1 c_2^* - s_1 s_2^*\cos\theta
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_018_claim_T_V_action",
    kind: "claim",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/017_claim_T_VのhatZ_hatYへの作用.typ",
    sourceOrdinal: 18,
    title: { tex: String.raw`T_{(V)} \text{ の } \hat{Z}, \hat{Y} \text{ への作用}` },
    labels: ["T_V_hatZ_hatY"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\; T_{(V)}(\hat{Y}_\mu)\right)
= \left(\hat{Z}_\mu^{(-)},\; \hat{Y}_\mu\right) A\!\left(\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    proof: [
      displayMath(
        String.raw`T_{(V)}(\hat{Z}_\mu^{(-)})
= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})\right)\right)`,
      ),
      paragraph([
        ref("ホロノミック量子場_p142下段_1"),
        " と ",
        ref("calc_of_TxT_hatZxhatY"),
        " から行列の積として計算すると",
      ]),
      displayMath(
        String.raw`(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu) \cdot B_1(\theta_\mu) \cdot B_2 \cdot B_1(\theta_\mu) = (\hat{Z}_\mu^{(-)}, \hat{Y}_\mu) \cdot A(\theta_\mu)`,
      ),
      paragraph([
        "（Mathematica による数値検証済み、具体的な行列積の計算は略）",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の行列積計算は非常に長い。0426時点で Mathematica で確認済みとして略。"],
    },
  },
  {
    id: "TV1_hatZ_hatY_019_definition_theta_mu",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/018_definition_theta_mu.typ",
    sourceOrdinal: 19,
    title: { tex: String.raw`\theta_\mu \text{ の定義}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(String.raw`\theta_\mu := \frac{2\pi\mu}{M}`),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "TV1_hatZ_hatY_020_definition_gamma1_gamma2",
    kind: "definition",
    sourcePath: "parts/008_T_V1_hatZとhatZ_hatYの関係/019_definition_A_thetaの対角化の準備.typ",
    sourceOrdinal: 20,
    title: { tex: String.raw`\gamma_1(\theta_\mu), \gamma_2(\theta_\mu) \text{ の定義}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\gamma_1(\theta_\mu) := c_1 c_2^* - s_1 s_2^*\cos\theta_\mu \in \mathbb{R}`,
      ),
      displayMath(
        String.raw`\gamma_2(\theta_\mu) := i e^{i\theta_\mu} s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2) \in \mathbb{C}`,
      ),
      paragraph(["とおくと、"]),
      displayMath(
        String.raw`A(\theta_\mu) = \begin{pmatrix}
\gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu)
\end{pmatrix}`,
      ),
    ],
    conversion: { status: "converted" },
  },
]);
