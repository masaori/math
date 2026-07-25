import { defineBlocks, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

export default defineBlocks([
  {
    id: "heading_diagonalization_appendix_B",
    kind: "heading",
    level: 1,
    sourcePath: "main.typ",
    sourceOrdinal: 5,
    title: { text: "対角化の計算 (ホロノミック量子場 付録B)" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "heading_transfer_matrix",
    kind: "heading",
    level: 2,
    sourcePath: "main.typ",
    sourceOrdinal: 6,
    title: { text: "転送行列" },
    labels: [],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_001_definition_symbols",
    kind: "definition",
    sourcePath: "parts/004_転送行列/000_definition_転送行列の記号の定義.typ",
    sourceOrdinal: 1,
    title: { text: "記号の定義" },
    labels: ["def_transfer_matrix_symbols"],
    statement: [
      list([
        [
          math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
          ": ",
          math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
          " 上の単位行列",
        ],
        [
          math(String.raw`\sigma_k^x := I_{\mathrm{Mat}(2,\mathbb{C})} \otimes \cdots \otimes \overbrace{\sigma^x}^{k\text{th}} \otimes \cdots \otimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`\sigma_k^y := I_{\mathrm{Mat}(2,\mathbb{C})} \otimes \cdots \otimes \overbrace{\sigma^y}^{k\text{th}} \otimes \cdots \otimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`\sigma_k^z := I_{\mathrm{Mat}(2,\mathbb{C})} \otimes \cdots \otimes \overbrace{\sigma^z}^{k\text{th}} \otimes \cdots \otimes I_{\mathrm{Mat}(2,\mathbb{C})} \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} := I_{\mathrm{Mat}(2,\mathbb{C})} \otimes \cdots \otimes I_{\mathrm{Mat}(2,\mathbb{C})}`),
        ],
        [
          math(String.raw`V_1 := \exp\!\left(i K_1 \left(\sigma_1^z\sigma_2^z + \sigma_2^z\sigma_3^z + \cdots + \sigma_M^z\sigma_1^z\right)\right) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`V_2 := (2\sinh 2K_2)^{M/2} \exp\!\left(K_2^* \left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_M^x\right)\right) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        ],
        [
          math(String.raw`Z_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^z \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
          "（ただし ",
          math(String.raw`Z_1 := \sigma_1^z`),
          "、",
          math(String.raw`Z_{M+1} := Z_1`),
          "。ホロノミック量子場では ",
          math(String.raw`p_m`),
          "）",
        ],
        [
          math(String.raw`Y_m := \sigma_1^x \cdots \sigma_{m-1}^x \sigma_m^y \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
          "（ただし ",
          math(String.raw`Y_1 := \sigma_1^y`),
          "、",
          math(String.raw`Y_{M+1} := Y_1`),
          "。ホロノミック量子場では ",
          math(String.raw`q_m`),
          "）",
        ],
        [
          math(String.raw`\varepsilon := \sigma_1^x \cdots \sigma_M^x = i^M (Z_1 Y_1)(Z_2 Y_2) \cdots (Z_M Y_M) \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
          "（右辺は ",
          math(String.raw`Z_m Y_m`),
          " の積であって和ではない。",
          math(String.raw`Z_m Y_m = \sigma_m^z \sigma_m^y = -i\,\sigma_m^x`),
          " より ",
          math(String.raw`i^M(-i)^M \sigma_1^x \cdots \sigma_M^x = \sigma_1^x \cdots \sigma_M^x`),
          " で一致する）",
        ],
        [
          math(String.raw`K_1^* := -\tfrac{1}{2}\log(\tanh K_1) \iff \sinh(2K_1)\sinh(2K_1^*) = 1`),
        ],
        [
          math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2) \iff \sinh(2K_2)\sinh(2K_2^*) = 1`),
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
    conversion: {
      status: "converted",
      notes: [
        '旧 main.typ には、見出し「対角化の計算」直下に同内容のインライン #definition("記号の定義") が' +
          "重複して置かれていた。相違は双対関係の注記のみで、そちらは旧版の sinh(K_i)sinh(K_i^*)=1" +
          "（parts/004/000 で sinh(2K_i)sinh(2K_i^*)=1 に訂正済み）。よって重複ブロックは作らず、" +
          "本ブロックへ集約した（インライン側にのみ在った σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, " +
          "p_m/q_m の対応は本ブロックへ補記済み）。",
      ],
    },
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
    labels: ["H1_H2_via_hatZ_hatY"],
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
        " について（以下 ",
        ref("def_hatZ_hatY"),
        " の展開と ",
        ref("exp_sum"),
        " を用いる）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M Y_{k_1}\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\right)}^{\hat{Y}_j}\,
\overbrace{\left(\sum_{k_2=1}^M\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}Z_{k_2}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\right)}^{\hat{Z}_{-j}^{(\pm)}}\,
\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(Y_{k_1}\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\right)
\left(\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}Z_{k_2}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\right)
\exp\!\left(-i\frac{2\pi j}{M}\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\exp\!\left(-i\frac{2\pi j}{M}\right)
(Y_{k_1}Z_{k_2}) \quad (\text{符号を前に、}YZ\text{を後ろに移動}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i\frac{2\pi j}{M}(k_1-k_2+1)\right)(Y_{k_1}Z_{k_2}) \quad (\text{exp をまとめる}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left(-(k_1-k_2+1)\,i\frac{2\pi j}{M}\right)\right)(Y_{k_1}Z_{k_2}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M\,\delta^M_{-(k_1-k_2+1),\,0}(Y_{k_1}Z_{k_2}) \quad (\because \text{exp\_sum}) \\
&= \frac{1}{M}\sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}}
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M(Y_{k_1}Z_{k_2})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`k_2\geq 2`),
        " の項と ",
        math(String.raw`k_2=1`),
        " の項に分けると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&= \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ k_2\in\{2,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}} M(Y_{k_1}Z_{k_2})
+ \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ -k_1\equiv 0 \pmod{M}}} \mp M(Y_{k_1}Z_1) \\
&= (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1}Z_M) + (\mp Y_M Z_1) \\
&= H_1^{(\pm)}
\end{aligned}`,
      ),
      paragraph([
        "ここで第 1 項は、",
        math(String.raw`k_1\in\{1,\dots,M\}`),
        "、",
        math(String.raw`k_2\in\{2,\dots,M\}`),
        "、",
        math(String.raw`-(k_1-k_2+1)\equiv 0 \pmod{M}`),
        " すなわち ",
        math(String.raw`k_1\equiv k_2-1 \pmod{M}`),
        " より ",
        math(String.raw`k_2-1\in\{1,\dots,M-1\}`),
        " かつ ",
        math(String.raw`k_1=k_2-1`),
        " に限る（",
        math(String.raw`\{1,\dots,M-1\}`),
        " の範囲で合同を満たす ",
        math(String.raw`k_1`),
        " は一意）。第 2 項は ",
        math(String.raw`-k_1\equiv 0 \pmod{M}`),
        " かつ ",
        math(String.raw`k_1\in\{1,\dots,M\}`),
        " より ",
        math(String.raw`k_1=M`),
        "。",
      ]),
      paragraph([math(String.raw`H_2`), " について、"]),
      displayMath(
        String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M\begin{cases}1 & (k_1\neq 1)\\ +1 & (k_1=1)\end{cases}Z_{k_1}\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)\right)}^{\hat{Z}_{-j}^{(-)}}\,
\overbrace{\left(\sum_{k_2=1}^M Y_{k_2}\exp\!\left(-i k_2\frac{2\pi j}{M}\right)\right)}^{\hat{Y}_j} \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(Z_{k_1}\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)\right)\left(Y_{k_2}\exp\!\left(-i k_2\frac{2\pi j}{M}\right)\right) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\exp\!\left(-i k_1\frac{2\pi(-j)}{M}-i k_2\frac{2\pi j}{M}\right)Z_{k_1}Y_{k_2} \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left((k_1-k_2)\,i\frac{2\pi j}{M}\right)\right)Z_{k_1}Y_{k_2} \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M M\,\delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} \quad (\because \text{exp\_sum}) \\
&= \sum_{k_1,k_2=1}^M \delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} \\
&= \sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ k_1-k_2\equiv 0 \pmod{M}}} Z_{k_1}Y_{k_2}
= \sum_{\substack{k_1\in\{1,\dots,M\}\\ k_1=k_2}} Z_{k_1}Y_{k_2} \\
&= Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M \\
&= H_2
\end{aligned}`,
      ),
    ],
    conversion: { status: "converted" },
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
  {
    id: "transfer_matrix_014_claim_recover_Z_Y_from_hatZ_hatY",
    kind: "claim",
    sourcePath: "parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ",
    sourceOrdinal: 14,
    title: { tex: String.raw`\hat{Z}, \hat{Y} \text{ から } Z, Y \text{ の復元}` },
    labels: ["recover_Z_Y_from_hatZ_hatY"],
    statement: [
      paragraph([
        ref("def_hatZ_hatY"),
        " の記号のもと、",
        math(String.raw`\hat{Z}^{(-)}`),
        " は全 ",
        math(String.raw`j`),
        " について重み ",
        math(String.raw`+1`),
        "（uniform）であり、すなわち ",
        math(String.raw`\hat{Z}_\mu^{(-)} = \sum_{j=1}^M Z_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)`),
        " である。各 ",
        math(String.raw`m \in \{1,\dots,M\}`),
        " について、次が成り立つ。",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Y_m`,
      ),
      displayMath(
        String.raw`\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Z_m`,
      ),
      paragraph(["ゆえに、"]),
      displayMath(
        String.raw`Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
      displayMath(
        String.raw`Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    proof: [
      paragraph([
        math(String.raw`m \in \{1,\dots,M\}`),
        " を任意に固定する。補題（",
        math(String.raw`\mu`),
        " についての指数和の直交性）: ",
        math(String.raw`j \in \{1,\dots,M\}`),
        " を固定し ",
        math(String.raw`k := m-j \in \mathbb{Z}`),
        " とおく。",
        ref("exp_sum"),
        " の主張において和の変数を ",
        math(String.raw`j \leftrightarrow \mu`),
        "、定数を ",
        math(String.raw`k = m-j`),
        " と読み替えることで、",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) = M\,\delta^M_{(m-j,\,0)} \quad (\because \text{exp\_sum})`,
      ),
      paragraph([
        "が成り立つ。さらに ",
        math(String.raw`m, j \in \{1,\dots,M\}`),
        " より ",
        math(String.raw`-(M-1)\leq m-j\leq M-1`),
        "、すなわち ",
        math(String.raw`|m-j|<M`),
        " であるから、",
        math(String.raw`m-j\equiv 0 \pmod{M}`),
        " と ",
        math(String.raw`m=j`),
        " は同値である。したがって、",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right)
= \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because \text{exp\_sum})`,
      ),
      paragraph(["が成り立つ（以下この等式を ", math(String.raw`(\ast)`), " と呼ぶ）。"]),
      paragraph(["Step 1: ", math(String.raw`\hat{Y}`), " からの復元。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M Y_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Y}_\mu,\hat{Z}_\mu^{(-)} \text{ の定義}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M Y_j \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right) \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M Y_j \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M Y_j \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because (\ast)) \\
&= M Y_m
\end{aligned}`,
      ),
      paragraph(["Step 2: ", math(String.raw`\hat{Z}^{(-)}`), " からの復元。"]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M Z_j \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Y}_\mu,\hat{Z}_\mu^{(-)} \text{ の定義}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M Z_j \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right) \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M Z_j \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M Z_j \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because (\ast)) \\
&= M Z_m
\end{aligned}`,
      ),
      paragraph([
        "Step 3: 復元式。Step 1・Step 2 で得た等式の両辺を ",
        math(String.raw`M`),
        " で割って、",
      ]),
      displayMath(
        String.raw`Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right), \qquad
Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)`,
      ),
    ],
    conversion: { status: "converted" },
  },
  {
    id: "transfer_matrix_015_claim_Z_Y_generate_algebra",
    kind: "claim",
    sourcePath: "parts/004_転送行列/014_claim_Z_YはMat2C^Mを環として生成する.typ",
    sourceOrdinal: 15,
    title: { tex: String.raw`Z, Y \text{ は } \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \text{ を環として生成する}` },
    labels: ["Z_Y_generate_algebra"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        "（004 章冒頭の記号の定義）で定義された ",
        math(String.raw`Z_1,\dots,Z_M, Y_1,\dots,Y_M \in \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " について、集合 ",
        math(String.raw`S := \{Z_1,\dots,Z_M, Y_1,\dots,Y_M\}`),
        " を考える。ここで ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " を ",
        math(String.raw`\mathbb{C}`),
        " 上の単位的結合多元環（積と ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、単位元 ",
        math(String.raw`I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        " を含む）とみなす。",
      ]),
      paragraph([
        "このとき、",
        math(String.raw`S`),
        " を含む最小の ",
        math(String.raw`\mathbb{C}`),
        "-部分多元環（",
        math(String.raw`S`),
        " の各元、単位元、それらの積、",
        math(String.raw`\mathbb{C}`),
        "-線型結合をすべて含み、積と線型結合について閉じる最小の部分集合。これを ",
        math(String.raw`\mathcal{A}`),
        " とおく）は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " 全体に一致する。すなわち ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        math(String.raw`\sigma^x, \sigma^y, \sigma^z \in \mathrm{Mat}(2,\mathbb{C})`),
        " を標準的な Pauli 行列 ",
        math(String.raw`\sigma^x=\begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^y=\begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        "、",
        math(String.raw`\sigma^z=\begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " とする。",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のとおり、第 ",
        math(String.raw`k`),
        " テンソル因子のみが対応する Pauli 行列で、他の因子はすべて ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " であるものとする。",
      ]),
      paragraph(["Step 1: 単一サイトの Pauli 行列の積公式。成分計算により、"]),
      displayMath(
        String.raw`\sigma^x\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix} = \begin{pmatrix}1&0\\0&1\end{pmatrix} = I_{\mathrm{Mat}(2,\mathbb{C})} \quad (\because \text{行列の積の成分計算})`,
      ),
      displayMath(
        String.raw`\sigma^y\sigma^z = \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix} = \begin{pmatrix}0&i\\i&0\end{pmatrix} = i\begin{pmatrix}0&1\\1&0\end{pmatrix} = i\,\sigma^x \quad (\because \text{行列の積の成分計算})`,
      ),
      paragraph([
        "第 2 式の両辺に ",
        math(String.raw`-i`),
        " を掛けると ",
        math(String.raw`\sigma^x = -i\,\sigma^y\sigma^z`),
        "（",
        math(String.raw`i^{-1}=-i`),
        "）。これらをテンソル積に持ち上げる。",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の積は各因子ごとの積であり ",
        math(String.raw`(A_1\otimes\cdots\otimes A_M)(B_1\otimes\cdots\otimes B_M) = (A_1 B_1)\otimes\cdots\otimes(A_M B_M)`),
        "（",
        math(String.raw`\because \text{テンソル積上の積の定義}`),
        "）。第 ",
        math(String.raw`k`),
        " 因子のみが非自明な ",
        math(String.raw`\sigma_k^a`),
        " どうしの積は（",
        math(String.raw`I:=I_{\mathrm{Mat}(2,\mathbb{C})}`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_k^b
&= (I\otimes\cdots\otimes\overbrace{\sigma^a}^{k\text{th}}\otimes\cdots\otimes I)(I\otimes\cdots\otimes\overbrace{\sigma^b}^{k\text{th}}\otimes\cdots\otimes I) \\
&= (II)\otimes\cdots\otimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\otimes\cdots\otimes(II) \quad (\because \text{テンソル積上の積の定義}) \\
&= I\otimes\cdots\otimes\overbrace{(\sigma^a\sigma^b)}^{k\text{th}}\otimes\cdots\otimes I \quad (\because II=I)
\end{aligned}`,
      ),
      paragraph([
        "これより ",
        math(String.raw`\sigma_k^x\sigma_k^x = I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        "、",
        math(String.raw`\sigma_k^x = -i\,\sigma_k^y\sigma_k^z`),
        " を得る。また異なるサイト ",
        math(String.raw`k\neq l`),
        " の ",
        math(String.raw`\sigma_k^a, \sigma_l^b`),
        " は可換である（",
        math(String.raw`k<l`),
        " として）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_k^a \sigma_l^b
&= (I\otimes\cdots\otimes\overbrace{\sigma^a}^{k\text{th}}\otimes\cdots\otimes I)(I\otimes\cdots\otimes\overbrace{\sigma^b}^{l\text{th}}\otimes\cdots\otimes I) \\
&= I\otimes\cdots\otimes\overbrace{\sigma^a}^{k\text{th}}\otimes\cdots\otimes\overbrace{\sigma^b}^{l\text{th}}\otimes\cdots\otimes I \quad (\because \text{テンソル積上の積の定義}) \\
&= (I\otimes\cdots\otimes\overbrace{\sigma^b}^{l\text{th}}\otimes\cdots\otimes I)(I\otimes\cdots\otimes\overbrace{\sigma^a}^{k\text{th}}\otimes\cdots\otimes I) \quad (\because \text{テンソル積上の積の定義}) \\
&= \sigma_l^b \sigma_k^a
\end{aligned}`,
      ),
      paragraph([
        "Step 2: ",
        math(String.raw`\mathcal{A}`),
        " が各 ",
        math(String.raw`\sigma_k^x, \sigma_k^y, \sigma_k^z`),
        " を含むこと。各 ",
        math(String.raw`m`),
        " について「",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x \in \mathcal{A}`),
        "」を仮定とする ",
        math(String.raw`m`),
        " に関する帰納法で示す。",
        math(String.raw`m=1`),
        " のとき ",
        math(String.raw`\sigma_1^z=Z_1\in\mathcal{A}`),
        "、",
        math(String.raw`\sigma_1^y=Y_1\in\mathcal{A}`),
        "、Step 1 より ",
        math(String.raw`\sigma_1^x = -i\,\sigma_1^y\sigma_1^z = -i\,Y_1 Z_1 \in \mathcal{A}`),
        "。",
      ]),
      paragraph([
        math(String.raw`m\geq 2`),
        " とし ",
        math(String.raw`\sigma_1^x,\dots,\sigma_{m-1}^x\in\mathcal{A}`),
        " を仮定する。",
        math(String.raw`P_{m-1}:=\sigma_1^x\sigma_2^x\cdots\sigma_{m-1}^x`),
        " とおくと ",
        math(String.raw`P_{m-1}\in\mathcal{A}`),
        "（",
        math(String.raw`m=1`),
        " では空積 ",
        math(String.raw`P_0:=I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}`),
        "）。異サイトの可換性と ",
        math(String.raw`\sigma_k^x\sigma_k^x=I`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}P_{m-1}
&= (\sigma_1^x\cdots\sigma_{m-1}^x)(\sigma_1^x\cdots\sigma_{m-1}^x) \\
&= (\sigma_1^x\sigma_1^x)(\sigma_2^x\sigma_2^x)\cdots(\sigma_{m-1}^x\sigma_{m-1}^x) \quad (\because \text{異サイトの可換性}) \\
&= I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}} \quad (\because \sigma_k^x\sigma_k^x=I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}})
\end{aligned}`,
      ),
      paragraph([
        "ゆえに ",
        math(String.raw`P_{m-1}`),
        " は可逆で ",
        math(String.raw`P_{m-1}^{-1}=P_{m-1}\in\mathcal{A}`),
        "。定義より ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z = P_{m-1}\sigma_m^z`),
        " であるから、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{m-1}Z_m
&= P_{m-1}P_{m-1}\sigma_m^z \quad (\because Z_m = P_{m-1}\sigma_m^z) \\
&= I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}\sigma_m^z \quad (\because P_{m-1}P_{m-1}=I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}) \\
&= \sigma_m^z
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`P_{m-1}, Z_m\in\mathcal{A}`),
        " かつ ",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`\sigma_m^z = P_{m-1}Z_m\in\mathcal{A}`),
        "。同様に ",
        math(String.raw`Y_m = P_{m-1}\sigma_m^y`),
        " より ",
        math(String.raw`\sigma_m^y = P_{m-1}Y_m\in\mathcal{A}`),
        "、さらに Step 1 より ",
        math(String.raw`\sigma_m^x = -i\,\sigma_m^y\sigma_m^z\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\sigma_m^x,\sigma_m^y,\sigma_m^z\in\mathcal{A}`),
        " が示され、帰納法により すべての ",
        math(String.raw`k\in\{1,\dots,M\}`),
        " について ",
        math(String.raw`\sigma_k^x,\sigma_k^y,\sigma_k^z\in\mathcal{A}`),
        "。",
      ]),
      paragraph([
        "Step 3: ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        "。まず ",
        math(String.raw`\mathcal{B}:=\{I_{\mathrm{Mat}(2,\mathbb{C})}, \sigma^x, \sigma^y, \sigma^z\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 上の基底である。実際、任意の ",
        math(String.raw`A=\begin{pmatrix}a_{11}&a_{12}\\a_{21}&a_{22}\end{pmatrix}`),
        " に対し",
      ]),
      displayMath(
        String.raw`A = \frac{a_{11}+a_{22}}{2}I_{\mathrm{Mat}(2,\mathbb{C})} + \frac{a_{12}+a_{21}}{2}\sigma^x + \frac{i(a_{12}-a_{21})}{2}\sigma^y + \frac{a_{11}-a_{22}}{2}\sigma^z \quad (\because \text{成分比較})`,
      ),
      paragraph([
        " が成り立つので ",
        math(String.raw`\mathcal{B}`),
        " は張り、",
        math(String.raw`\dim_{\mathbb{C}}\mathrm{Mat}(2,\mathbb{C})=4=\#\mathcal{B}`),
        " より基底である。次に ",
        math(String.raw`\mathcal{B}^{\otimes M}:=\{e_1\otimes\cdots\otimes e_M: e_1,\dots,e_M\in\mathcal{B}\}`),
        " は ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の基底である（",
        ref("tensor_basis"),
        "）。一方、各 ",
        math(String.raw`e_1\otimes\cdots\otimes e_M`),
        " について、各 ",
        math(String.raw`k`),
        " で ",
        math(String.raw`\sigma_k^{a_k}:=I\otimes\cdots\otimes\overbrace{e_k}^{k\text{th}}\otimes\cdots\otimes I`),
        " とおくと、Step 1 の異サイト積公式を繰り返して",
      ]),
      displayMath(
        String.raw`\sigma_1^{a_1}\sigma_2^{a_2}\cdots\sigma_M^{a_M} = e_1\otimes e_2\otimes\cdots\otimes e_M \quad (\because \text{テンソル積上の積の定義})`,
      ),
      paragraph([
        "Step 2 より各 ",
        math(String.raw`\sigma_k^{a_k}\in\mathcal{A}`),
        "（",
        math(String.raw`I_{(\mathrm{Mat}(2,\mathbb{C}))^{\otimes M}}\in\mathcal{A}`),
        " も含む）であり、",
        math(String.raw`\mathcal{A}`),
        " は積について閉じるから ",
        math(String.raw`e_1\otimes\cdots\otimes e_M = \sigma_1^{a_1}\cdots\sigma_M^{a_M}\in\mathcal{A}`),
        "。よって ",
        math(String.raw`\mathcal{B}^{\otimes M}\subseteq\mathcal{A}`),
        "。",
        math(String.raw`\mathcal{A}`),
        " は ",
        math(String.raw`\mathbb{C}`),
        "-線型結合について閉じ、",
        math(String.raw`\mathcal{B}^{\otimes M}`),
        " は基底であるから",
      ]),
      displayMath(
        String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M} = \mathrm{span}_{\mathbb{C}}(\mathcal{B}^{\otimes M}) \subseteq \mathcal{A} \quad (\because \mathcal{A} \text{ は } \mathbb{C}\text{-線型結合について閉じる})`,
      ),
      paragraph([
        "一方 ",
        math(String.raw`\mathcal{A}\subseteq\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " は定義より明らかであるから ",
        math(String.raw`\mathcal{A} = \mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        "。",
      ]),
    ],
    conversion: { status: "converted" },
  },
]);
