import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "transfer_matrix_001_definition_symbols",
    kind: "definition",
    sourcePath: "parts/004_転送行列/000_definition_転送行列の記号の定義.typ",
    sourceOrdinal: 1,
    title: { text: "記号の定義" },
    labels: [],
    statement: [
      list([
        [
          math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
          ": ",
          math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
          " 上の単位行列",
        ],
        [
          math(String.raw`\sigma_k^x := I \otimes \cdots \otimes \overbrace{\sigma^x}^{k\text{th}} \otimes \cdots \otimes I \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
          "（",
          math(String.raw`\sigma_k^y, \sigma_k^z`),
          " も同様）",
        ],
        [
          math(String.raw`V_1 := \exp\!\left(i K_1 \left(\sigma_1^z\sigma_2^z + \sigma_2^z\sigma_3^z + \cdots + \sigma_M^z\sigma_1^z\right)\right) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`V_2 := (2\sinh 2K_2)^{M/2} \exp\!\left(K_2^* \left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_M^x\right)\right) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`Z_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^z`),
          "（ただし ",
          math(String.raw`Z_1 := \sigma_1^z`),
          "、",
          math(String.raw`Z_{M+1} := Z_1`),
          "）",
        ],
        [
          math(String.raw`Y_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^y`),
          "（ただし ",
          math(String.raw`Y_1 := \sigma_1^y`),
          "、",
          math(String.raw`Y_{M+1} := Y_1`),
          "）",
        ],
        [
          math(String.raw`\varepsilon := \sigma_1^x \cdots \sigma_M^x = i^M (Z_1 Y_1 + \cdots + Z_M Y_M) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`K_i^* := -\tfrac{1}{2}\log(\tanh K_i) \iff \sinh K_i \sinh K_i^* = 1`),
        ],
        [
          math(String.raw`c_i := \cosh 2K_i,\quad s_i := \sinh 2K_i,\quad c_i^* := \cosh 2K_i^*,\quad s_i^* := \sinh 2K_i^*`),
        ],
      ]),
      paragraph([
        math(String.raw`K_i, K_i^* > 0`),
        " より、",
        math(String.raw`c_i, s_i, c_i^*, s_i^* > 0`),
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_002_claim_Z_Y_linearly_independent",
    kind: "claim",
    sourcePath: "parts/004_転送行列/001_claim_Z_mとY_mは線型独立.typ",
    sourceOrdinal: 2,
    title: { tex: String.raw`Z_m, Y_m \text{ は線型独立}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\{Z_1, \dots, Z_M, Y_1, \dots, Y_M\} \text{ は線型独立}`,
      ),
    ],
    proof: [paragraph([todo("TODO: 証明略")])],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_003_claim_V1_V2_in_Z_Y_epsilon",
    kind: "claim",
    sourcePath: "parts/004_転送行列/002_claim_V1V2をZYepsilonで表す.typ",
    sourceOrdinal: 3,
    title: { tex: String.raw`V_1, V_2 \text{ を } Z, Y, \varepsilon \text{ で表す}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
V_1 &= \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M - \varepsilon Y_M Z_1)\right) \\
V_2 &= (2s_2)^{M/2} \exp\!\left(i K_2^* (Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M)\right)
\end{aligned}`,
      ),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_004_definition_eigenspaces_of_epsilon",
    kind: "definition",
    sourcePath: "parts/004_転送行列/003_definition_epsilonの固有空間.typ",
    sourceOrdinal: 4,
    title: { tex: String.raw`\varepsilon \text{ の固有空間}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\mathcal{F} := (\mathbb{C}^2)^{\otimes M}, \qquad
\mathcal{F}^{(\pm)} := \{f \in \mathcal{F} \mid \varepsilon f = \pm f\}`,
      ),
      paragraph([
        "（",
        math(String.raw`\varepsilon^2 = 1`),
        " より ",
        math(String.raw`\varepsilon`),
        " の固有値は ",
        math(String.raw`\pm 1`),
        "）",
      ]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_005_definition_end_isomorphism",
    kind: "definition",
    sourcePath: "parts/004_転送行列/004_definition_EndFとMat2Cテンソル積Mの同型.typ",
    sourceOrdinal: 5,
    title: { tex: String.raw`\mathbf{end}: \mathrm{End}(\mathcal{F}) \to \mathrm{Mat}(2,\mathbb{C})^{\otimes M}` },
    labels: [],
    statement: [
      paragraph([
        math(String.raw`\mathrm{End}(\mathcal{F})`),
        " と ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の線型同型写像を一つ取り、",
      ]),
      displayMath(
        String.raw`\mathbf{end}: \mathrm{End}(\mathcal{F}) \to \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`,
      ),
      paragraph(["とおく。"]),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_006_claim_V1_restriction_to_eigenspaces",
    kind: "claim",
    sourcePath: "parts/004_転送行列/005_claim_V1の固有空間への制限.typ",
    sourceOrdinal: 6,
    title: { tex: String.raw`V_1 \text{ の固有空間への制限}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\left(\mathbf{end}(V_1)\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(\mathbf{end}\!\left(\exp\!\left(i K_1 (Y_1 Z_2 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1)\right)\right)\right)\big|_{\mathcal{F}^{(\pm)}}`,
      ),
    ],
    proof: [paragraph([todo("TODO")])],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_007_definition_V1_pm",
    kind: "definition",
    sourcePath: "parts/004_転送行列/006_definition_V1_plus_minusの定義.typ",
    sourceOrdinal: 7,
    title: { tex: String.raw`V_1^{(\pm)} \text{ の定義}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`V_1^{(\pm)} := \exp\!\left(i K_1 (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1)\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_008_definition_delta_M",
    kind: "definition",
    sourcePath: "parts/004_転送行列/007_definition_クロネッカーのデルタ_delta_M.typ",
    sourceOrdinal: 8,
    title: { tex: String.raw`\delta^M_{(\mu,\nu)} \text{ の定義}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\delta^M_{(\mu,\nu)} :=
\begin{cases}
1 & (\mu \equiv \nu \pmod{M}) \\
0 & (\mu \not\equiv \nu \pmod{M})
\end{cases}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_009_claim_exp_sum",
    kind: "claim",
    sourcePath: "parts/004_転送行列/008_claim_指数関数の和とクロネッカーのデルタの関係.typ",
    sourceOrdinal: 9,
    title: null,
    labels: ["exp_sum"],
    statement: [
      paragraph([math(String.raw`k \in \mathbb{Z}`), " について、"]),
      displayMath(
        String.raw`\sum_{j=1}^{M} \exp\!\left(\frac{2\pi i j k}{M}\right) = M\,\delta^M_{(k,0)}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`(a)\; k \equiv 0 \pmod{M}`),
        " のとき：",
        math(String.raw`l \in \mathbb{Z}`),
        " で ",
        math(String.raw`k = lM`),
        " とおくと、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M} e^{lM \cdot 2\pi i j/M}
= \sum_{j=1}^{M} e^{2\pi i l j}
= \sum_{j=1}^{M} (\cos 2\pi lj + i\sin 2\pi lj)
= \sum_{j=1}^{M} 1 = M`,
      ),
      paragraph([
        math(String.raw`(b)`),
        " その他のとき：等比数列の和の公式（公比 ",
        math(String.raw`r = e^{2\pi i k/M} \neq 1`),
        "）より、",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M} r^j
= r \cdot \frac{1 - r^M}{1 - r}
= r \cdot \frac{1 - e^{2\pi i k}}{1 - r}
= r \cdot \frac{1 - 1}{1 - r}
= 0`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_010_definition_hatZ_hatY",
    kind: "definition",
    sourcePath: "parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ",
    sourceOrdinal: 10,
    title: { tex: String.raw`\hat{Z}, \hat{Y} \text{ の定義}` },
    labels: ["def_hatZ_hatY"],
    statement: [
      paragraph([
        math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`),
        " とし、",
        math(String.raw`\mu \in \mathcal{M}`),
        " について、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\hat{Z}_\mu^{(\pm)}
&:= \sum_{j=1}^{M}
  \begin{cases} \mp 1 & (j = 1) \\ 1 & (j \neq 1) \end{cases}
  Z_j \exp\!\left(-i \frac{2\pi j \mu}{M}\right) \\
&= \mp Z_1 \exp\!\left(-i\frac{2\pi\mu}{M}\right)
  + \sum_{j=2}^{M} Z_j \exp\!\left(-i\frac{2\pi j\mu}{M}\right) \\
\hat{Y}_\mu
&:= \sum_{j=1}^{M} Y_j \exp\!\left(-i\frac{2\pi j\mu}{M}\right)
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_011_definition_H1_H2",
    kind: "definition",
    sourcePath: "parts/004_転送行列/010_definition_H1_H2の定義とV1V2の表式.typ",
    sourceOrdinal: 11,
    title: null,
    labels: [],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &:= Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1} Z_M \mp Y_M Z_1 \\
H_2 &:= Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M
\end{aligned}`,
      ),
      paragraph(["よって、"]),
      displayMath(
        String.raw`V_1^{(\pm)} = \exp\!\left(i K_1 H_1^{(\pm)}\right), \qquad
V_2 = (2s_2)^{M/2} \exp\!\left(i K_2^* H_2\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_012_claim_H1_H2_via_hatZ_hatY",
    kind: "claim",
    sourcePath: "parts/004_転送行列/011_claim_H1_H2をZhat_Yhatで表す.typ",
    sourceOrdinal: 12,
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ を } \hat{Z}, \hat{Y} \text{ で表す}` },
    labels: [],
    statement: [
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &= \frac{1}{M} \sum_{j=1}^{M}
  \hat{Y}_j\, \hat{Z}_{-j}^{(\pm)}\,
  \exp\!\left(-i\frac{2\pi j}{M}\right) \\
H_2 &= \frac{1}{M} \sum_{j=1}^{M} \hat{Z}_{-j}^{(-)}\, \hat{Y}_j
\end{aligned}`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`H_1^{(\pm)}`),
        " について：",
        math(String.raw`\hat{Y}_j`),
        " と ",
        math(String.raw`\hat{Z}_{-j}^{(\pm)}`),
        " を展開して積をとると、指数因子は",
      ]),
      displayMath(
        String.raw`e^{-ik_1 \cdot 2\pi j/M} \cdot e^{-ik_2 \cdot 2\pi(-j)/M} \cdot e^{-i \cdot 2\pi j/M}
= \exp\!\left(-i\frac{2\pi j(k_1 - k_2 + 1)}{M}\right)`,
      ),
      paragraph([
        math(String.raw`j`),
        " について和をとり ",
        ref("exp_sum"),
        " を適用すると ",
        math(String.raw`M\,\delta^M_{-(k_1-k_2+1),\,0}`),
        "。",
        math(String.raw`k_1, k_2 \in \{1,\dots,M\}`),
        " でこの条件を満たすのは ",
        math(String.raw`k_2 \geq 2`),
        " のとき ",
        math(String.raw`k_1 = k_2 - 1`),
        "（",
        math(String.raw`Y_1 Z_2 + \cdots + Y_{M-1} Z_M`),
        " を与える）、",
        math(String.raw`k_2 = 1`),
        " のとき ",
        math(String.raw`k_1 = M`),
        "（",
        math(String.raw`\mp Y_M Z_1`),
        " を与える）のみ。よって右辺 ",
        math(String.raw`= H_1^{(\pm)}`),
        "。",
      ]),
      paragraph([
        math(String.raw`H_2`),
        " について：同様に展開し ",
        ref("exp_sum"),
        " を適用すると ",
        math(String.raw`M\,\delta^M_{k_1-k_2,\,0}`),
        "。条件 ",
        math(String.raw`k_1 \equiv k_2 \pmod{M}`),
        " かつ ",
        math(String.raw`k_1, k_2 \in \{1,\dots,M\}`),
        " より ",
        math(String.raw`k_1 = k_2`),
        "。よって右辺 ",
        math(String.raw`= Z_1 Y_1 + \cdots + Z_M Y_M = H_2`),
        "。",
      ]),
    ],
    conversion: {
      status: "partially_simplified",
      notes: ["原文の長大なテンソル積展開を要点のみに圧縮。"],
    },
  },
  {
    id: "transfer_matrix_013_claim_hatZ_hatY_M_periodicity",
    kind: "claim",
    sourcePath: "parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ",
    sourceOrdinal: 13,
    title: { tex: String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)},\; \hat{Y}_M = \hat{Y}_{-M}` },
    labels: ["hatZ_hatY_M_periodicity"],
    statement: [
      displayMath(
        String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)}, \qquad \hat{Y}_M = \hat{Y}_{-M}`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_hatZ_hatY"),
        " より、各 ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\exp\!\left(-i j \frac{2\pi M}{M}\right)
= e^{-2\pi i j}
= 1
= e^{0}
= \exp\!\left(-i j \frac{2\pi(-M)}{M}\right)`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\hat{Z}_M`),
        " と ",
        math(String.raw`\hat{Z}_{-M}`),
        " の各 ",
        math(String.raw`j`),
        " 項の係数が一致する。",
        math(String.raw`\hat{Y}`),
        " も同様。",
      ]),
    ],
    conversion: { status: "converted" },
  },
]);
