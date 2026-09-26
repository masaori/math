import { defineNotes, paragraph, math, displayMath, list, ref } from "../schema.ts";
import type { Label } from "../schema.ts";

// 整数運動量の経路（本文不採用）。文書本体ではない。
//
// 整数運動量 θ_μ = 2πμ/M による Fourier 変換 Ẑ^{(±)}_μ, Ŷ_μ（μ ∈ 𝓜 = {−M,…,−1,1,…,M}）から、
// フェルミオン ψ_μ・V'・V の固有値へ進む経路である。もとは content/ の 004・007・008・009 章と
// 013 章の一部にあった本文ブロックで、内容はそのまま運んだ。退避したラベルへの参照は〔ラベル〕
// という文字列に置き換えてある（ノートは実在する本文ラベルしか参照できないため）。
//
// **本文には採用しなかった。** 理由: この経路は境界項の符号が +Y_M Z_1 の (−) セクターでしか
// 閉じない（位相 e^{-iMθ_μ} = +1 が境界の符号を出さない）。自由エネルギーに必要なのは (+) セクター
// だけであり、それは半整数運動量 θ̃_μ = 2π(μ−1/2)/M（e^{-iMθ̃_μ} = −1）の経路で本文に閉じている。
// 各ノートの targets は、本文の半整数運動量側で対応するブロックである。

const NOT_ADOPTED = paragraph<Label>([
  "【本文不採用の整数運動量の経路。理由: 整数運動量の Fourier 変換は境界項 +Y_M Z_1 をもつ (−) セクターでしか閉じず、",
  "自由エネルギーに必要な (+) セクターは半整数運動量の経路で本文に閉じているため。】",
]);

export default defineNotes([
  {
    id: "note_evensector_003_definition_half_integer_checkZ_integer_route_transfer_matrix_010a_definition_hatZ_pm",
    targets: ["def_half_integer_checkZ"],
    title: { tex: String.raw`\hat{Z}_\mu^{(\pm)} \text{ の定義}` },
    origin: { path: "_old/typst/parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の定義ブロック transfer_matrix_010a_definition_hatZ_pm。labels: def_hatZ_pm。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M\in\mathbb Z_{\geq1}`), " とする。自然数から整数への標準包含を ", math(String.raw`\iota_{\mathbb N\to\mathbb Z}:\mathbb N\to\mathbb Z`), "、整数から実数への標準包含を ", math(String.raw`\iota_{\mathbb Z\to\mathbb R}:\mathbb Z\to\mathbb R`), " と書く。これらは零、単位元、和、積、順序を保つものとする。", math(String.raw`M\geq1`), " なので、", math(String.raw`(M_{\mathbb N})_{\mathbb Z}=M`), " となる一意な ", math(String.raw`M_{\mathbb N}\in\mathbb N_{\geq1}`), " がある。ここで ", math(String.raw`(M_{\mathbb N})_{\mathbb Z}:=\iota_{\mathbb N\to\mathbb Z}(M_{\mathbb N})`), " である。また、", math(String.raw`M_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(M)\in\mathbb R_{>0}`), " と書く。", ref("inclusion_rr_to_cc"), " による複素数像を ", math(String.raw`M_{\mathbb C}:=(M_{\mathbb R})_{\mathbb C}\in\mathbb C`), " と書く。実数から複素数への包含の定義により ", math(String.raw`M_{\mathbb C}=(M_{\mathbb R},0_{\mathbb R})`), " であるから、", math(String.raw`M_{\mathbb R}>0_{\mathbb R}`), " だから ", math(String.raw`M_{\mathbb R}\ne0_{\mathbb R}`), " かつ ", math(String.raw`M_{\mathbb C}\ne0_{\mathbb C}`), " である。したがって以下の実位相の分母は零でない。複素スカラーの和と積には ", ref("complex_numbers_form_a_field"), " の体構造を用いる。"]),
      paragraph([math(String.raw`\mathcal M:=\{-M,\dots,-1,1,\dots,M\}\subset\mathbb Z`), " とする。", math(String.raw`\mu\in\mathcal M`), " と ", math(String.raw`j\in\{1,\dots,M_{\mathbb N}\}`), " に対して、"]),
      displayMath(String.raw`j_{\mathbb Z}:=\iota_{\mathbb N\to\mathbb Z}(j),\qquad
j_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(j_{\mathbb Z}),\qquad
\mu_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(\mu)`),
      paragraph(["と書く。包含写像が順序を保ち、", math(String.raw`1\leq j\leq M_{\mathbb N}`), " だから"]),
      displayMath(String.raw`1_{\mathbb Z}=\iota_{\mathbb N\to\mathbb Z}(1)
\leq j_{\mathbb Z}
\leq\iota_{\mathbb N\to\mathbb Z}(M_{\mathbb N})=M`),
      paragraph(["であり、", math(String.raw`j_{\mathbb Z}\in\{1,\dots,M\}`), " となる。正の整数指数 ", math(String.raw`2^M`), " は、その自然数像による ", math(String.raw`2^{M_{\mathbb N}}`), " の略記とする。したがって ", ref("def_jordan_wigner_Z_matrices"), " から ", math(String.raw`Z_{j_{\mathbb Z}}\in\mathrm{Mat}(2^M,\mathbb C)=\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`), " である。次に、"]),
      displayMath(String.raw`\phi_{j,\mu}:=-\frac{2\pi j_{\mathbb R}\mu_{\mathbb R}}{M_{\mathbb R}}\in\mathbb R,
\qquad i(\phi_{j,\mu})_{\mathbb C}\in\mathbb C`),
      paragraph(["とおく。ここで ", math(String.raw`\pi\in\mathbb R`), "、", math(String.raw`i=(0_{\mathbb R},1_{\mathbb R})\in\mathbb C`), " とする。ここで書いた複素指数の定義と所属は現行本文では未整備であり、", "現行のオイラー表示もその欠落を明記している。したがって複素指数の先行定義が整うまでは、この位相因子の所属を未解決として扱う。以下ではその所属を仮定し、二つの符号の各々について"]),
      displayMath(String.raw`\begin{aligned}
\hat{Z}_\mu^{(\pm)}
&:= \sum_{j=1}^{M_{\mathbb N}}
  \begin{cases} \mp 1_{\mathbb C} & (j = 1) \\ 1_{\mathbb C} & (j \neq 1) \end{cases}
  \exp(i(\phi_{j,\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C) \\
&= \begin{cases} \mp 1_{\mathbb C} & (1 = 1) \\ 1_{\mathbb C} & (1 \neq 1) \end{cases}
  \exp(i(\phi_{1,\mu})_{\mathbb C})Z_1
  + \sum_{j=2}^{M_{\mathbb N}}
    \begin{cases} \mp 1_{\mathbb C} & (j = 1) \\ 1_{\mathbb C} & (j \neq 1) \end{cases}
    \exp(i(\phi_{j,\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&(\because\ \text{有限和の最初の項 }j=1\text{ を分けた}) \\
&= (\mp1_{\mathbb C})\exp(i(\phi_{1,\mu})_{\mathbb C})Z_1
  + \sum_{j=2}^{M_{\mathbb N}}
    \begin{cases} \mp 1_{\mathbb C} & (j = 1) \\ 1_{\mathbb C} & (j \neq 1) \end{cases}
    \exp(i(\phi_{j,\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&(\because\ 1=1\text{ なので先頭の係数は }\mp1_{\mathbb C}) \\
&= (\mp1_{\mathbb C})\exp(i(\phi_{1,\mu})_{\mathbb C})Z_1
  + \sum_{j=2}^{M_{\mathbb N}}1_{\mathbb C}\exp(i(\phi_{j,\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&(\because\ 2\leq j\leq M_{\mathbb N}\text{ なら }j\ne1) \\
&= \mp \exp(i(\phi_{1,\mu})_{\mathbb C})Z_1
  + \sum_{j=2}^{M_{\mathbb N}} \exp(i(\phi_{j,\mu})_{\mathbb C})Z_{j_{\mathbb Z}}
&&(\because\ \mathbb C\text{ の単位元による積と }\mp1_{\mathbb C}\text{ 倍の定義})
\end{aligned}`),
      paragraph(["と定める。各スカラーと各 ", math(String.raw`Z_{j_{\mathbb Z}}`), " の積、およびその有限和は ", math(String.raw`\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`), " に属する。", math(String.raw`M_{\mathbb N}=1`), " では ", math(String.raw`\sum_{j=2}^{M_{\mathbb N}}`), " を空和、すなわち同じ行列空間の零行列とする。"]),
    ],
  },
  {
    id: "note_evensector_003_definition_half_integer_checkY_integer_route_transfer_matrix_010b_definition_hatY",
    targets: ["def_half_integer_checkY"],
    title: { tex: String.raw`\hat{Y}_\mu \text{ の定義}` },
    origin: { path: "_old/typst/parts/004_転送行列/009_definition_Zhat_Yhatの定義.typ", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の定義ブロック transfer_matrix_010b_definition_hatY。labels: def_hatY。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M\in\mathbb Z_{\geq1}`), " とする。自然数から整数への標準包含を ", math(String.raw`\iota_{\mathbb N\to\mathbb Z}:\mathbb N\to\mathbb Z`), "、整数から実数への標準包含を ", math(String.raw`\iota_{\mathbb Z\to\mathbb R}:\mathbb Z\to\mathbb R`), " と書く。これらは零、単位元、和、積、順序を保つものとする。", math(String.raw`M\geq1`), " なので、", math(String.raw`(M_{\mathbb N})_{\mathbb Z}=M`), " となる一意な ", math(String.raw`M_{\mathbb N}\in\mathbb N_{\geq1}`), " がある。ここで ", math(String.raw`(M_{\mathbb N})_{\mathbb Z}:=\iota_{\mathbb N\to\mathbb Z}(M_{\mathbb N})`), " である。また、", math(String.raw`M_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(M)\in\mathbb R_{>0}`), " と書く。", ref("inclusion_rr_to_cc"), " による複素数像を ", math(String.raw`M_{\mathbb C}:=(M_{\mathbb R})_{\mathbb C}\in\mathbb C`), " と書く。実数から複素数への包含の定義により ", math(String.raw`M_{\mathbb C}=(M_{\mathbb R},0_{\mathbb R})`), " であるから、", math(String.raw`M_{\mathbb R}>0_{\mathbb R}`), " だから ", math(String.raw`M_{\mathbb R}\ne0_{\mathbb R}`), " かつ ", math(String.raw`M_{\mathbb C}\ne0_{\mathbb C}`), " である。したがって以下の実位相の分母は零でない。複素スカラーの和と積には ", ref("complex_numbers_form_a_field"), " の体構造を用いる。"]),
      paragraph([math(String.raw`\mathcal M:=\{-M,\dots,-1,1,\dots,M\}\subset\mathbb Z`), " とする。", math(String.raw`\mu\in\mathcal M`), " と ", math(String.raw`j\in\{1,\dots,M_{\mathbb N}\}`), " に対して、"]),
      displayMath(String.raw`j_{\mathbb Z}:=\iota_{\mathbb N\to\mathbb Z}(j),\qquad
j_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(j_{\mathbb Z}),\qquad
\mu_{\mathbb R}:=\iota_{\mathbb Z\to\mathbb R}(\mu)`),
      paragraph(["と書く。包含写像が順序を保ち、", math(String.raw`1\leq j\leq M_{\mathbb N}`), " だから"]),
      displayMath(String.raw`1_{\mathbb Z}=\iota_{\mathbb N\to\mathbb Z}(1)
\leq j_{\mathbb Z}
\leq\iota_{\mathbb N\to\mathbb Z}(M_{\mathbb N})=M`),
      paragraph(["であり、", math(String.raw`j_{\mathbb Z}\in\{1,\dots,M\}`), " となる。正の整数指数 ", math(String.raw`2^M`), " は、その自然数像による ", math(String.raw`2^{M_{\mathbb N}}`), " の略記とする。したがって ", ref("def_jordan_wigner_Y_matrices"), " から ", math(String.raw`Y_{j_{\mathbb Z}}\in\mathrm{Mat}(2^M,\mathbb C)=\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`), " である。次に、"]),
      displayMath(String.raw`\psi_{j,\mu}:=-\frac{2\pi j_{\mathbb R}\mu_{\mathbb R}}{M_{\mathbb R}}\in\mathbb R,
\qquad i(\psi_{j,\mu})_{\mathbb C}\in\mathbb C`),
      paragraph(["とおく。ここで ", math(String.raw`\pi\in\mathbb R`), "、", math(String.raw`i=(0_{\mathbb R},1_{\mathbb R})\in\mathbb C`), " とする。ここで書いた複素指数の定義と所属は現行本文では未整備であり、", "現行のオイラー表示もその欠落を明記している。したがって複素指数の先行定義が整うまでは、この位相因子の所属を未解決として扱う。以下ではその所属を仮定して"]),
      displayMath(String.raw`\hat{Y}_\mu
:= \sum_{j=1}^{M_{\mathbb N}} \exp(i(\psi_{j,\mu})_{\mathbb C})Y_{j_{\mathbb Z}}
\in\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`),
      paragraph(["と定める。各スカラーと各 ", math(String.raw`Y_{j_{\mathbb Z}}`), " の積、およびその有限和は ", math(String.raw`\mathrm{Mat}(2^{M_{\mathbb N}},\mathbb C)`), " に属する。"]),
    ],
  },
  {
    id: "note_evensector_007_claim_H1_H2_via_check_Z_Y_integer_route_transfer_matrix_012_claim_H1_H2_via_hatZ_hatY",
    targets: ["H1_H2_via_check_Z_Y"],
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ を } \hat{Z}, \hat{Y} \text{ で表す}` },
    origin: { path: "_old/typst/parts/004_転送行列/011_claim_H1_H2をZhat_Yhatで表す.typ", ordinal: 12 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_012_claim_H1_H2_via_hatZ_hatY。labels: H1_H2_via_hatZ_hatY。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\begin{aligned}
H_1^{(\pm)} &= \frac{1}{M} \sum_{j=1}^{M}
  \hat{Y}_j\, \hat{Z}_{-j}^{(\pm)}\,
  \exp\!\left(-i\frac{2\pi j}{M}\right) \\
H_2 &= \frac{1}{M} \sum_{j=1}^{M} \hat{Z}_{-j}^{(-)}\, \hat{Y}_j
\end{aligned}`),
      paragraph(["証明."]),
      paragraph([math(String.raw`H_1^{(\pm)}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,\exp\!\left(-i\frac{2\pi j}{M}\right) &&(\because\ \text{主張の右辺を書き下したもの}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M \exp\!\left(-i k_1\frac{2\pi j}{M}\right)Y_{k_1}\right)}^{\hat{Y}_j}\,
\overbrace{\left(\sum_{k_2=1}^M\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)Z_{k_2}\right)}^{\hat{Z}_{-j}^{(\pm)}}\,
\exp\!\left(-i\frac{2\pi j}{M}\right) &&(\because\ \hat{Y}_j,\ \hat{Z}_{-j}^{(\pm)}\ \text{の定義 }\text{〔def\_hatY〕},\ \text{〔def\_hatZ\_pm〕}\text{ の展開}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(\exp\!\left(-i k_1\frac{2\pi j}{M}\right)Y_{k_1}\right)
\left(\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)Z_{k_2}\right)
\exp\!\left(-i\frac{2\pi j}{M}\right) &&(\because\ \text{有限和どうしの積は二重和である（分配則）}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i k_1\frac{2\pi j}{M}\right)\exp\!\left(-i k_2\frac{2\pi(-j)}{M}\right)\exp\!\left(-i\frac{2\pi j}{M}\right)
(Y_{k_1}Z_{k_2}) &&(\because\ \text{複素数の積の可換性と結合則（符号と exp を前へ、}YZ\text{ を後ろへ移した）}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\exp\!\left(-i\frac{2\pi j}{M}(k_1-k_2+1)\right)(Y_{k_1}Z_{k_2}) &&(\because\ \exp a\cdot\exp b=\exp(a+b)) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left(-(k_1-k_2+1)\,i\frac{2\pi j}{M}\right)\right)(Y_{k_1}Z_{k_2}) &&(\because\ \text{有限和の順序交換と、}j\text{ に依らない因子を和の外へ出すこと}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M\,\delta^M_{-(k_1-k_2+1),\,0}(Y_{k_1}Z_{k_2}) &&(\because\ \blkref{exp_sum}) \\
&= \frac{1}{M}\sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}}
\begin{cases}1 & (k_2\neq 1)\\ \mp 1 & (k_2=1)\end{cases}
M(Y_{k_1}Z_{k_2}) &&(\because\ \delta^M\ \text{が } 0 \text{ を与える項が落ちること}) \\
&= \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ k_2\in\{2,\dots,M\}\\ -(k_1-k_2+1)\equiv 0 \pmod{M}}} M(Y_{k_1}Z_{k_2})
+ \frac{1}{M}\sum_{\substack{k_1\in\{1,\dots,M\}\\ -k_1\equiv 0 \pmod{M}}} \mp M(Y_{k_1}Z_1) &&(\because\ k_2=1\ \text{の項とそれ以外（}k_2\in\{2,\dots,M\}\text{）の項へ和を分けた}) \\
&= (Y_1 Z_2 + Y_2 Z_3 + \cdots + Y_{M-1}Z_M) + (\mp Y_M Z_1) &&(\because\ \text{下記のとおり第 1 項は } k_1=k_2-1\text{、第 2 項は } k_1=M \text{ に限ること、および } \tfrac{1}{M}\cdot M=1) \\
&= H_1^{(\pm)} &&(\because\ \blkref{def_H1_pm})
\end{aligned}`),
      paragraph(["ここで第 1 項は、", math(String.raw`k_1\in\{1,\dots,M\}`), "、", math(String.raw`k_2\in\{2,\dots,M\}`), "、", math(String.raw`-(k_1-k_2+1)\equiv 0 \pmod{M}`), " すなわち ", math(String.raw`k_1\equiv k_2-1 \pmod{M}`), " より ", math(String.raw`k_2-1\in\{1,\dots,M-1\}`), " かつ ", math(String.raw`k_1=k_2-1`), " に限る（", math(String.raw`\{1,\dots,M-1\}`), " の範囲で合同を満たす ", math(String.raw`k_1`), " は一意）。第 2 項は ", math(String.raw`-k_1\equiv 0 \pmod{M}`), " かつ ", math(String.raw`k_1\in\{1,\dots,M\}`), " より ", math(String.raw`k_1=M`), "。"]),
      paragraph([math(String.raw`H_2`), " について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{右辺})
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,\hat{Y}_j &&(\because\ \text{主張の右辺を書き下したもの}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}
\overbrace{\left(\sum_{k_1=1}^M\begin{cases}1 & (k_1\neq 1)\\ +1 & (k_1=1)\end{cases}\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)Z_{k_1}\right)}^{\hat{Z}_{-j}^{(-)}}\,
\overbrace{\left(\sum_{k_2=1}^M \exp\!\left(-i k_2\frac{2\pi j}{M}\right)Y_{k_2}\right)}^{\hat{Y}_j} &&(\because\ \hat{Z}_{-j}^{(-)},\ \hat{Y}_j\ \text{の定義 }\text{〔def\_hatZ\_pm〕},\ \text{〔def\_hatY〕}\text{ の展開}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\left(\exp\!\left(-i k_1\frac{2\pi(-j)}{M}\right)Z_{k_1}\right)\left(\exp\!\left(-i k_2\frac{2\pi j}{M}\right)Y_{k_2}\right) &&(\because\ \text{有限和どうしの積は二重和である（分配則）。}k_1=1\ \text{の場合の係数も }+1\text{ である}) \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\sum_{k_1,k_2=1}^M
\exp\!\left(-i k_1\frac{2\pi(-j)}{M}-i k_2\frac{2\pi j}{M}\right)Z_{k_1}Y_{k_2} &&(\because\ \text{複素数の積の可換性と結合則、および }\exp a\cdot\exp b=\exp(a+b)) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M
\left(\sum_{j\in\{1,\dots,M\}}\exp\!\left((k_1-k_2)\,i\frac{2\pi j}{M}\right)\right)Z_{k_1}Y_{k_2} &&(\because\ \text{有限和の順序交換と、}j\text{ に依らない因子を和の外へ出すこと}) \\
&= \frac{1}{M}\sum_{k_1,k_2=1}^M M\,\delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} &&(\because\ \blkref{exp_sum}) \\
&= \sum_{k_1,k_2=1}^M \delta^M_{(k_1-k_2,\,0)}Z_{k_1}Y_{k_2} &&(\because\ \tfrac{1}{M}\cdot M=1) \\
&= \sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ k_1-k_2\equiv 0 \pmod{M}}} Z_{k_1}Y_{k_2} &&(\because\ \delta^M\ \text{が } 0 \text{ を与える項が落ちること}) \\
&= \sum_{\substack{k_1,k_2\in\{1,\dots,M\}\\ k_1=k_2}} Z_{k_1}Y_{k_2} &&(\because\ k_1,k_2\in\{1,\dots,M\}\ \text{では } k_1-k_2\equiv 0 \pmod{M} \text{ と } k_1=k_2 \text{ が同値}) \\
&= Z_1 Y_1 + Z_2 Y_2 + \cdots + Z_M Y_M &&(\because\ \text{和の添字を } k_1=k_2 \text{ で走らせて書き下したもの}) \\
&= H_2 &&(\because\ \blkref{def_H2})
\end{aligned}`),
    ],
  },
  {
    id: "note_evensector_003_claim_half_integer_checkZ_periodicity_integer_route_transfer_matrix_013_claim_hatZ_hatY_M_periodicity",
    targets: ["half_integer_checkZ_periodicity"],
    title: { tex: String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)},\; \hat{Y}_M = \hat{Y}_{-M}` },
    origin: { path: "_old/typst/parts/004_転送行列/012_claim_hatZ_hatYのM周期性.typ", ordinal: 13 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_013_claim_hatZ_hatY_M_periodicity。labels: hatZ_hatY_M_periodicity。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)}, \qquad \hat{Y}_M = \hat{Y}_{-M}`),
      paragraph(["証明."]),
      paragraph(["準備として、各 ", math(String.raw`j \in \{1,\dots,M\}`), " について係数が一致することを示す。"]),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-i \frac{2\pi j M}{M}\right)
&= \exp(-2\pi i j)
&&(\because\ M/M = 1)\\
&= \cos(2\pi j) - i\sin(2\pi j)
&&(\because\ \text{オイラーの公式})\\
&= \cos(2\pi j) + i\sin(2\pi j)
&&(\because\ j \in \mathbb{Z}\ \text{での三角関数の値})\\
&= \exp(2\pi i j)
&&(\because\ \text{オイラーの公式})\\
&= \exp\!\left(-i \frac{2\pi j (-M)}{M}\right)
&&(\because\ (-M)/M = -1)
\end{aligned}`),
      paragraph(["この係数の一致を各項に当てる。"]),
      displayMath(String.raw`\begin{aligned}
\hat{Z}_M^{(-)}
&= \sum_{j=1}^{M} \exp\!\left(-i \frac{2\pi j M}{M}\right)Z_j
&&(\because\ \text{定義}\ \hat{Z}_\mu^{(\pm)}\ \text{〔def\_hatZ\_pm〕}\ \text{で}\ \mu = M,\ \text{複号下では}\ j=1\ \text{の係数も}\ 1)\\
&= \sum_{j=1}^{M} \exp\!\left(-i \frac{2\pi j (-M)}{M}\right)Z_j
&&(\because\ \text{上で示した各}\ j\ \text{についての係数の一致})\\
&= \hat{Z}_{-M}^{(-)}
&&(\because\ \text{定義}\ \hat{Z}_\mu^{(\pm)}\ \text{〔def\_hatZ\_pm〕}\ \text{で}\ \mu = -M,\ \text{複号下では}\ j=1\ \text{の係数も}\ 1)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\hat{Y}_M
&= \sum_{j=1}^{M} \exp\!\left(-i \frac{2\pi j M}{M}\right)Y_j
&&(\because\ \text{定義}\ \hat{Y}_\mu\ \text{〔def\_hatY〕}\ \text{で}\ \mu = M)\\
&= \sum_{j=1}^{M} \exp\!\left(-i \frac{2\pi j (-M)}{M}\right)Y_j
&&(\because\ \text{上で示した各}\ j\ \text{についての係数の一致})\\
&= \hat{Y}_{-M}
&&(\because\ \text{定義}\ \hat{Y}_\mu\ \text{〔def\_hatY〕}\ \text{で}\ \mu = -M)
\end{aligned}`),
    ],
  },
  {
    id: "note_evensector_006_claim_recover_Z_Y_integer_route_transfer_matrix_014_claim_recover_Z_Y_from_hatZ_hatY",
    targets: ["recover_Z_Y_from_check_Z_Y"],
    title: { tex: String.raw`\hat{Z}, \hat{Y} \text{ から } Z, Y \text{ の復元}` },
    origin: { path: "_old/typst/parts/004_転送行列/013_claim_hatZ_hatYからZ_Yの復元.typ", ordinal: 14 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_014_claim_recover_Z_Y_from_hatZ_hatY。labels: recover_Z_Y_from_hatZ_hatY。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔def_hatZ_pm〕", " と ", "〔def_hatY〕", " の記号のもと、", math(String.raw`\hat{Z}^{(-)}`), " は全 ", math(String.raw`j`), " について重み ", math(String.raw`+1`), "（uniform）であり、すなわち ", math(String.raw`\hat{Z}_\mu^{(-)} = \sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)Z_j`), " である。各 ", math(String.raw`m \in \{1,\dots,M\}`), " について、次が成り立つ。"]),
      displayMath(String.raw`\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Y_m`),
      displayMath(String.raw`\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right) = M Z_m`),
      paragraph(["ゆえに、"]),
      displayMath(String.raw`Y_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)`),
      displayMath(String.raw`Z_m = \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)`),
      paragraph(["証明."]),
      paragraph([math(String.raw`m \in \{1,\dots,M\}`), " を任意に固定する。補題（", math(String.raw`\mu`), " についての指数和の直交性）: ", math(String.raw`j \in \{1,\dots,M\}`), " を固定し ", math(String.raw`k := m-j \in \mathbb{Z}`), " とおく。指数和の直交性で和の変数を ", math(String.raw`j \leftrightarrow \mu`), "、定数を ", math(String.raw`k = m-j`), " と読み替えることで、"]),
      displayMath(String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right) = M\,\delta^M_{(m-j,\,0)} \quad (\because \text{指数和の直交性}\ \blkref{exp_sum})`),
      paragraph(["が成り立つ。さらに ", math(String.raw`m, j \in \{1,\dots,M\}`), " より ", math(String.raw`-(M-1)\leq m-j\leq M-1`), "、すなわち ", math(String.raw`|m-j|<M`), " であるから、", math(String.raw`m-j\equiv 0 \pmod{M}`), " と ", math(String.raw`m=j`), " は同値である。したがって、"]),
      displayMath(String.raw`\sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right)
= \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases} \quad (\because \text{指数和の直交性}\ \blkref{exp_sum}\ \text{と }|m-j|<M)`),
      paragraph(["が成り立つ（以下この等式を ", math(String.raw`(\ast)`), " と呼ぶ）。"]),
      paragraph(["Step 1: ", math(String.raw`\hat{Y}`), " からの復元。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)Y_j\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Y}_\mu \text{ の定義}\ \text{〔def\_hatY〕}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)Y_j\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \text{有限和への右からの分配則}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right)Y_j \quad (\because \text{複素スカラーは複素行列と可換に移せる}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right)Y_j \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right)Y_j \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases}Y_j \quad (\because (\ast)) \\
&= M Y_m \quad (\because j\neq m \text{ の項は係数が } 0 \text{ なので落ち、残るのは } j=m \text{ の項だけである})
\end{aligned}`),
      paragraph(["Step 2: ", math(String.raw`\hat{Z}^{(-)}`), " からの復元。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right)
&= \sum_{\mu=1}^M \left(\sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)Z_j\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \hat{Z}_\mu^{(-)} \text{ の定義}\ \text{〔def\_hatZ\_pm〕}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)Z_j\exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \text{有限和への右からの分配則}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(-i j\frac{2\pi\mu}{M}\right)\exp\!\left(i m\frac{2\pi\mu}{M}\right)Z_j \quad (\because \text{複素スカラーは複素行列と可換に移せる}) \\
&= \sum_{\mu=1}^M \sum_{j=1}^M \exp\!\left(i(m-j)\frac{2\pi\mu}{M}\right)Z_j \quad (\because \text{指数法則}) \\
&= \sum_{j=1}^M \sum_{\mu=1}^M \exp\!\left((m-j)\cdot\frac{2\pi i\mu}{M}\right)Z_j \quad (\because \text{有限二重和の順序交換}) \\
&= \sum_{j=1}^M \begin{cases} M & (j=m) \\ 0 & (j\neq m) \end{cases}Z_j \quad (\because (\ast)) \\
&= M Z_m \quad (\because j\neq m \text{ の項は係数が } 0 \text{ なので落ち、残るのは } j=m \text{ の項だけである})
\end{aligned}`),
      paragraph(["Step 3: 復元式。", math(String.raw`M \geq 1`), " なので ", math(String.raw`\frac{1}{M} \in \mathbb{C}`), " が取れる。"]),
      displayMath(String.raw`\begin{aligned}
Y_m
&= \frac{1}{M}\cdot M\,Y_m \quad (\because \tfrac{1}{M}\cdot M = 1) \\
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu \exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \text{Step 1 の等式})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
Z_m
&= \frac{1}{M}\cdot M\,Z_m \quad (\because \tfrac{1}{M}\cdot M = 1) \\
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)} \exp\!\left(i m\frac{2\pi\mu}{M}\right) \quad (\because \text{Step 2 の等式})
\end{aligned}`),
    ],
  },
  {
    id: "note_evensector_005_claim_anticommutator_check_Z_Y_integer_route_hatZ_hatY_anticommutation_001_claim_anticommutation_relations",
    targets: ["anticommutator_of_check_Z_Y"],
    title: { tex: String.raw`\hat{Z}\text{と}\hat{Y}\text{の反交換関係}` },
    origin: { path: "_old/typst/parts/007_hatZとhatYの反交換関係/000_claim_hatZ同士_hatZとhatY_hatY同士の反交換関係.typ", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/007_hatZ_hatY_anticommutation.ts の主張ブロック hatZ_hatY_anticommutation_001_claim_anticommutation_relations。labels: anticommutator_of_hat_Z_and_hat_Y。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`), " は ", math(String.raw`Z_j, Y_j`), " の ", math(String.raw`\mathbb{C}`), "-線型結合であり、", ref("def_transfer_matrix_symbols"), " のとおり ", math(String.raw`Z_j, Y_j \in \mathrm{Mat}(2^M,\mathbb{C})`), " であるから、以下の等式はすべて ", math(String.raw`2^M`), " 次の複素行列の等式である。", math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " は ", math(String.raw`2^M`), " 次の単位行列を表す（", ref("def_kronecker"), "、", ref("kronecker_product_rule"), " (2)）。"]),
      displayMath(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})} \quad (\text{複合同順})`),
      displayMath(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
+ \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
\quad (\text{複合同順})`),
      displayMath(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`),
      displayMath(String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
      paragraph(["証明."]),
      paragraph(["はじめに記号を 1 つ置く。", math(String.raw`j \in \{1,\dots,M\}`), " について次のように置く。"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^{(\pm)}_j
&:=
\begin{cases}
  \mp 1 & (j=1),\\
  +1 & (j\neq 1)
\end{cases}
\in \{+1,-1\}
&& (\because\ \text{場合分けによる定義})
\end{aligned}`),
      paragraph(["〔def_hatZ_pm〕", " と ", "〔def_hatY〕", " の定義は ", math(String.raw`\hat{Z}_\mu^{(\pm)} = \sum_{j=1}^M \varepsilon^{(\pm)}_j\exp\!\left(-i\frac{2\pi j\mu}{M}\right)Z_j`), " と書ける。", math(String.raw`\varepsilon^{(\pm)}_j`), " は ", math(String.raw`\mathbb{C}`), " の元であり、行列の積と可換に動かせる。"]),
      paragraph([math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+`), " の計算:"]),
      displayMath(String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\pm)}]_+
&= \left[\sum_{j=1}^M \varepsilon^{(\pm)}_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right)Z_j,\ \sum_{k=1}^M \varepsilon^{(\pm)}_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)Z_k\right]_+
&&(\because\ \text{〔def\_hatZ\_pm〕}\ \text{と上で置いた記号}) \\
&= \left(\sum_{j=1}^M \varepsilon^{(\pm)}_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right)Z_j\right)\left(\sum_{k=1}^M \varepsilon^{(\pm)}_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)Z_k\right) \\
&\quad + \left(\sum_{k=1}^M \varepsilon^{(\pm)}_k\exp\!\left(-i \frac{2\pi k\nu}{M}\right)Z_k\right)\left(\sum_{j=1}^M \varepsilon^{(\pm)}_j\exp\!\left(-i \frac{2\pi j\mu}{M}\right)Z_j\right)
&&(\because\ \text{反交換子の定義}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)Z_j Z_k \\
&\quad + \sum_{j,k=1}^M \varepsilon^{(\pm)}_k\varepsilon^{(\pm)}_j\exp\!\left(-i\frac{2\pi}{M}(k\nu+j\mu)\right)Z_k Z_j
&&(\because\ \text{有限和どうしの積を二重和へ開いた（分配則）}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)(Z_j Z_k + Z_k Z_j)
&&(\because\ \text{2 つの二重和をまとめ、}\ \mathbb{C}\ \text{の係数を前へ出した}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)[Z_j, Z_k]_+
&&(\because\ \text{反交換子の定義}) \\
&= \sum_{j,k=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_k\exp\!\left(-i\frac{2\pi}{M}(j\mu+k\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\delta^M_{(j,k)}
&&(\because\ \blkref{anticommutator_of_Z_and_Y}\ \text{の第 1 式}) \\
&= \sum_{j=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \blkref{def_delta_M}\ \text{により}\ k\neq j\ \text{の項が消える}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \varepsilon^{(\pm)}_j \in \{+1,-1\}\ \text{なので}\ \varepsilon^{(\pm)}_j\varepsilon^{(\pm)}_j = 1) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ j\mu+j\nu = j(\mu+\nu)) \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \blkref{exp_sum}\ \text{を}\ k=-(\mu+\nu)\ \text{で使った})
\end{aligned}`),
      paragraph([math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+`), " の計算に入る前に、2 つの符号の積の値を求めておく。", math(String.raw`j=1`), " のとき（複合同順）"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^{(\pm)}_1\varepsilon^{(\mp)}_1
&= (\mp 1)(\pm 1)
&&(\because\ \varepsilon^{(\pm)}_j\ \text{の定義の}\ j=1\ \text{の場合を 2 つの符号へ当てた}) \\
&= -1
&&(\because\ \text{実数の積}\ (-1)(+1) = (+1)(-1) = -1)
\end{aligned}`),
      paragraph(["であり、", math(String.raw`j\neq 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j
&= (+1)(+1)
&&(\because\ \varepsilon^{(\pm)}_j\ \text{の定義の}\ j\neq 1\ \text{の場合を 2 つの符号へ当てた}) \\
&= +1
&&(\because\ \text{実数の積}\ 1\cdot 1 = 1)
\end{aligned}`),
      paragraph(["である。すなわち ", math(String.raw`j=1`), " の項だけ符号が反転する。"]),
      displayMath(String.raw`\begin{aligned}
[\hat{Z}_\mu^{(\pm)}, \hat{Z}_\nu^{(\mp)}]_+
&= \sum_{j=1}^M \varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{第 1 式の鎖の第 1 段から第 8 段までと同じ計算。第 2 の因子の符号だけが}\ \varepsilon^{(\mp)}\ \text{である}) \\
&= \varepsilon^{(\pm)}_1\varepsilon^{(\mp)}_1\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \sum_{j=2}^M \varepsilon^{(\pm)}_j\varepsilon^{(\mp)}_j\exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{有限和から}\ j=1\ \text{の項を分けた}) \\
&= (-1)\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \sum_{j=2}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
&&(\because\ \text{上で求めた符号の積の値}) \\
&= (-1)\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})} \\
&\quad + \left(\sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 - \exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ j=1\ \text{の項を足して引いた}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi}{M}(j\mu+j\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{同じ項どうしをまとめた}) \\
&= \sum_{j=1}^M \exp\!\left(-i\frac{2\pi j}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ j\mu+j\nu = j(\mu+\nu)) \\
&= 2M\,\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
 + \left(-2\exp\!\left(-i\frac{2\pi}{M}(\mu+\nu)\right)\cdot 2I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \blkref{exp_sum}\ \text{を}\ k=-(\mu+\nu)\ \text{で使い、}\blkref{def_delta_M}\text{ で書いた})
\end{aligned}`),
      paragraph([math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+`), "、", math(String.raw`[\hat{Y}_\mu, \hat{Y}_\nu]_+`), " についても同様（原文もこの 2 つは「同様」として詳細を省いている）。"]),
    ],
  },
  {
    id: "note_evensector_004_claim_commutator_H_check_Z_Y_integer_route_TV1_hatZ_hatY_001_claim_commutator_H_Z_Y",
    targets: ["commutator_of_H_and_check_Z_Y"],
    title: { tex: String.raw`H_1^{(\pm)}, H_2 \text{ と } \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu \text{ の交換関係}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ", ordinal: 1 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_001_claim_commutator_H_Z_Y。labels: commutator_of_H_and_Z_Y。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= 2 \exp(-i 2\pi\mu/M) \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= 2 \exp(-i 2\pi\mu/M) \hat{Y}_\mu \\
[H_1^{(\pm)}, \hat{Y}_\mu]
&= -2 \exp(i 2\pi\mu/M) \hat{Z}_\mu^{(\pm)} \\
[H_2, \hat{Z}_\mu^{(-)}]
&= -2 \hat{Y}_\mu \\
[H_2, \hat{Z}_\mu^{(+)}]
&= -2 \hat{Y}_\mu + \frac{4}{M}\sum_{j\in\{1,\dots,M\}}
   \exp(-i \frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j \\
[H_2, \hat{Y}_\mu]
&= 2 \hat{Z}_\mu^{(-)}
\end{aligned}`),
      paragraph(["証明."]),
      paragraph(["以下の各変形では ", "〔H1_H2_via_hatZ_hatY〕", " の表式と ", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の反交換関係を用いる。"]),
      paragraph(["(1) ", math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]`), " について、", math(String.raw`\mu \in \mathcal{M}`), " を任意に取る。準備として次の 3 つを先に用意する。"]),
      paragraph(["準備 1（", math(String.raw`\hat{Y}`), " の ", math(String.raw`M`), " ずれ）。", math(String.raw`\nu \in \mathbb{Z}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
\hat{Y}_{\nu+M}
&= \sum_{j=1}^{M} \exp\!\left(-i\frac{2\pi j(\nu+M)}{M}\right)Y_j
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= \sum_{j=1}^{M} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\exp\!\left(-i 2\pi j\right)Y_j
&&(\because\ \text{指数法則})\\
&= \sum_{j=1}^{M} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\cdot 1\,Y_j
&&(\because\ j \in \mathbb{Z}\ \text{でのオイラーの公式}\ \text{（$\hat{Z}_M^{(-)}=\hat{Z}_{-M}^{(-)},\ \hat{Y}_M=\hat{Y}_{-M}$ と同じ計算）})\\
&= \hat{Y}_{\nu}
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})
\end{aligned}`),
      paragraph(["準備 2（指数の ", math(String.raw`M`), " ずれ）。", math(String.raw`\nu \in \mathbb{Z}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(-i\frac{2\pi(\nu+M)}{M}\right)
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)\exp\!\left(-i 2\pi\right)
&&(\because\ \text{指数法則})\\
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)\cdot 1
&&(\because\ \text{オイラーの公式})\\
&= \exp\!\left(-i\frac{2\pi\nu}{M}\right)
&&(\because\ \text{複素数の四則})
\end{aligned}`),
      paragraph(["準備 3（和に残る ", math(String.raw`j`), " の決定）。", math(String.raw`j \in \{1,\dots,M\}`), " かつ ", math(String.raw`-j+\mu \equiv 0 \pmod{M}`), " を満たす ", math(String.raw`j`), " はちょうど 1 つであり、"]),
      displayMath(String.raw`j = \begin{cases}
M & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`),
      paragraph(["また、", math(String.raw`\hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}`), " である（", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の ", math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`), " を移項したもの）。以上のもとで、"]),
      displayMath(String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\exp(-i\frac{2\pi j}{M})\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\exp(-i\frac{2\pi j}{M})\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\exp(-i\frac{2\pi j}{M})\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \exp(-i\frac{2\pi j}{M})\hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Y}_j\hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}\ \text{すなわち $\hat{Z}$ と $\hat{Y}$ の反交換関係})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\pm)}
   + \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\pm)}]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z},\hat{Z}]_+\ \text{の値})\\
&= 2\sum_{j\in\{1,\dots,M\}} \delta^M_{-j+\mu,0}\, \exp(-i\frac{2\pi j}{M})\hat{Y}_j
&&(\because\ \text{単位行列との積とスカラーの整理})\\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義})\\
&= 2\begin{cases}
\exp(-i\frac{2\pi M}{M})\hat{Y}_M & (\mu = -M) \\
\exp(-i\frac{2\pi(M+\mu)}{M})\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\exp(-i\frac{2\pi\mu}{M})\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
&&(\because\ \text{準備 3})\\
&= 2\, \exp(-i\frac{2\pi\mu}{M})\hat{Y}_\mu
&&(\because\ \text{準備 1 と準備 2}\ (\nu = \mu\ \text{または}\ \nu = -M))
\end{aligned}`),
      paragraph(["引いたブロックは ", "〔def_hatZ_pm〕", "、", "〔def_hatY〕", "、", "〔hatZ_hatY_M_periodicity〕", "、", "〔H1_H2_via_hatZ_hatY〕", "、", "〔anticommutator_of_hat_Z_and_hat_Y〕", "、", ref("def_delta_M"), " である。"]),
      paragraph(["(2) ", math(String.raw`[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]`), " について、", math(String.raw`\mu \in \mathcal{M}`), " を任意に取る。準備 1 と準備 2 に加えて、次の 3 つを先に用意する。"]),
      paragraph(["準備 4（", math(String.raw`H_1^{(\pm)}`), " の表式）。"]),
      displayMath(String.raw`H_1^{(\pm)}
= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,\exp(-i\frac{2\pi j}{M})\right)
\qquad (\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す})`),
      paragraph(["準備 5（反交換関係の移項）。", math(String.raw`j \in \{1,\dots,M\}`), " について ", math(String.raw`\hat{Z}_\mu^{(\mp)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\mp)}`), " である（", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の ", math(String.raw`[\hat{Z}_\mu^{(\mp)}, \hat{Y}_j]_+ = 0`), " を移項したもの）。"]),
      paragraph(["準備 6（第 1 項の和に残る ", math(String.raw`j`), " の決定）。", math(String.raw`j \in \{1,\dots,M\}`), " かつ ", math(String.raw`-j+\mu \equiv 0 \pmod{M}`), " を満たす ", math(String.raw`j`), " はちょうど 1 つであり、"]),
      displayMath(String.raw`j = \begin{cases}
2M+\mu & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`),
      paragraph(["以上のもとで、"]),
      displayMath(String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Z}_\mu^{(\mp)}]
&= \left[\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\,\hat{Z}_{-j}^{(\pm)}\,\exp(-i\frac{2\pi j}{M})\right),\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{準備 4})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\exp(-i\frac{2\pi j}{M}),\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{交換子の定義と、有限和・スカラー倍についての分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left[\hat{Y}_j\hat{Z}_{-j}^{(\pm)},\ \hat{Z}_\mu^{(\mp)}\right]
&&(\because\ \text{スカラー倍を交換子の外へ出した})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   - \hat{Z}_\mu^{(\mp)}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Y}_j\hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{準備 5})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(\hat{Z}_{-j}^{(\pm)}\hat{Z}_\mu^{(\mp)}
   + \hat{Z}_\mu^{(\mp)}\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,[\hat{Z}_{-j}^{(\pm)},\hat{Z}_\mu^{(\mp)}]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(
   2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + \left(-2\,\exp(-i\frac{2\pi}{M}(-j+\mu))\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\mp)}]_+\ \text{の値})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\left(-2\,\exp(-i\frac{2\pi}{M}(-j+\mu))\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{分配則と、有限和の項ごとの分割})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M}-i\frac{2\pi}{M}(-j+\mu))\hat{Y}_j
&&(\because\ \text{単位行列との積とスカラーの整理、および指数法則})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi\mu}{M})\hat{Y}_j
&&(\because\ \text{指数の中の}\ j\ \text{が打ち消し合う})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} \exp(-i\frac{2\pi\mu}{M})\sum_{j\in\{1,\dots,M\}} \hat{Y}_j
&&(\because\ j\ \text{によらない因子を有限和の外へ出した})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} \exp(-i\frac{2\pi\mu}{M})\sum_{j\in\{1,\dots,M\}}\sum_{k=1}^{M} Y_k\, \exp(-i k\frac{2\pi j}{M})
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} \exp(-i\frac{2\pi\mu}{M})\sum_{k=1}^{M} Y_k\sum_{j\in\{1,\dots,M\}} \exp(-i k\frac{2\pi j}{M})
&&(\because\ \text{有限和の順序の入れ替えと、$k$ によらない因子を内側の和の外へ出した})\\
&= 2\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\,\delta^M_{-j+\mu,0}
   - \frac{4}{M} \exp(-i\frac{2\pi\mu}{M})\sum_{k=1}^{M} Y_k\, M\,\delta^M_{(k,0)}
&&(\because\ \text{指数和の公式})\\
&= 2\begin{cases}
\exp(-i\frac{2\pi(2M+\mu)}{M})\hat{Y}_{2M+\mu} & (\mu = -M) \\
\exp(-i\frac{2\pi(M+\mu)}{M})\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\exp(-i\frac{2\pi\mu}{M})\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases} - 0
&&\left(\because\ \begin{aligned}
&\text{第 1 項は準備 6}\\
&\text{第 2 項は原文が}\ 0\ \text{とおいている}
\end{aligned}\right)\\
&= 2\, \exp(-i\frac{2\pi\mu}{M})\hat{Y}_\mu
&&(\because\ \text{準備 1 と準備 2}\ (\nu = \mu\ \text{または}\ \nu = M+\mu))
\end{aligned}`),
      paragraph(["指数和の公式は ", ref("exp_sum"), " による。第 2 項を ", math(String.raw`0`), " とおく段は、原文の扱いをそのまま写したものであり、本文では確かめていない。"]),
      paragraph(["引いたブロックは ", "〔def_hatZ_pm〕", "、", "〔def_hatY〕", "、", "〔hatZ_hatY_M_periodicity〕", "、", "〔H1_H2_via_hatZ_hatY〕", "、", "〔anticommutator_of_hat_Z_and_hat_Y〕", "、", ref("def_delta_M"), "、", ref("exp_sum"), " である。"]),
      paragraph(["(3) ", math(String.raw`[H_1^{(\pm)}, \hat{Y}_\mu]`), " について、", math(String.raw`\mu \in \mathcal{M}`), " を任意に取る。準備として次の 3 つを先に用意する。"]),
      paragraph(["準備 1（", math(String.raw`\hat{Z}^{(\pm)}`), " の ", math(String.raw`M`), " ずれ）。", math(String.raw`\nu \in \mathbb{Z}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
\hat{Z}_{\nu+M}^{(\pm)}
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j(\nu+M)}{M}\right)
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})\\
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\exp\!\left(-i 2\pi j\right)
&&(\because\ \text{指数法則})\\
&= \sum_{j=1}^{M} Z_j^{(\pm)} \exp\!\left(-i\frac{2\pi j\nu}{M}\right)\cdot 1
&&(\because\ j \in \mathbb{Z}\ \text{でのオイラーの公式}\ \text{（$\hat{Z}_M^{(-)}=\hat{Z}_{-M}^{(-)}$ と同じ計算）})\\
&= \hat{Z}_{\nu}^{(\pm)}
&&(\because\ \text{$\hat{Z}, \hat{Y}$ の定義})
\end{aligned}`),
      paragraph(["準備 2（指数の ", math(String.raw`M`), " ずれ）。(1) の準備 2 をそのまま使う。すなわち ", math(String.raw`\nu \in \mathbb{Z}`), " について ", math(String.raw`\exp\!\left(-i\frac{2\pi(\nu+M)}{M}\right) = \exp\!\left(-i\frac{2\pi\nu}{M}\right)`), " である。"]),
      paragraph(["準備 3（和に残る ", math(String.raw`j`), " の決定）。", math(String.raw`j \in \{1,\dots,M\}`), " かつ ", math(String.raw`j+\mu \equiv 0 \pmod{M}`), " を満たす ", math(String.raw`j`), " はちょうど 1 つであり、"]),
      displayMath(String.raw`j = \begin{cases}
-\mu & (\mu \leq -1) \\
M-\mu & (1 \leq \mu \leq M-1) \\
M & (\mu = M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`),
      paragraph(["また、", math(String.raw`\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu = -\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}`), " である（", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の ", math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`), " を移項したもの）。以上のもとで、"]),
      displayMath(String.raw`\begin{aligned}
[H_1^{(\pm)}, \hat{Y}_\mu]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\exp(-i\frac{2\pi j}{M})\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\exp(-i\frac{2\pi j}{M})\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\exp(-i\frac{2\pi j}{M})\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \exp(-i\frac{2\pi j}{M})\hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(-\hat{Y}_j\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}
   - \hat{Y}_\mu\hat{Y}_j\hat{Z}_{-j}^{(\pm)}\right)
&&(\because\ \hat{Z}_{-j}^{(\pm)}\hat{Y}_\mu = -\hat{Y}_\mu\hat{Z}_{-j}^{(\pm)}\ \text{すなわち $\hat{Z}$ と $\hat{Y}$ の反交換関係})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(-\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Y}_j\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(-[\hat{Y}_j,\hat{Y}_\mu]_+\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi j}{M})\left(-2M\,\delta^M_{j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Y},\hat{Y}]_+\ \text{の値})\\
&= -2\sum_{j\in\{1,\dots,M\}} \delta^M_{j+\mu,0}\, \exp(-i\frac{2\pi j}{M})\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{単位行列との積とスカラーの整理})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ j+\mu\equiv 0 \pmod{M}}} \exp(-i\frac{2\pi j}{M})\hat{Z}_{-j}^{(\pm)}
&&(\because\ \text{$\delta^M$ の定義})\\
&= -2\begin{cases}
\exp(-i\frac{2\pi(-\mu)}{M})\hat{Z}_{-(-\mu)}^{(\pm)} & (\mu \leq -1) \\
\exp(-i\frac{2\pi(M-\mu)}{M})\hat{Z}_{-(M-\mu)}^{(\pm)} & (1 \leq \mu \leq M-1) \\
\exp(-i\frac{2\pi M}{M})\hat{Z}_{-M}^{(\pm)} & (\mu = M)
\end{cases}
&&(\because\ \text{準備 3})\\
&= -2\, \exp(-i\frac{2\pi(-\mu)}{M})\hat{Z}_{\mu}^{(\pm)}
&&(\because\ \text{準備 1 と準備 2}\ \text{（$1 \leq \mu \leq M-1$ では $\nu = -\mu$ として 1 度、$\mu = M$ では $\nu = -M, 0$ として 2 度当てる）})\\
&= -2\, \exp(i\frac{2\pi\mu}{M})\hat{Z}_{\mu}^{(\pm)}
&&(\because\ \text{指数の符号の整理})
\end{aligned}`),
      paragraph(["引いたブロックは ", "〔def_hatZ_pm〕", "、", "〔def_hatY〕", "、", "〔hatZ_hatY_M_periodicity〕", "、", "〔H1_H2_via_hatZ_hatY〕", "、", "〔anticommutator_of_hat_Z_and_hat_Y〕", "、", ref("def_delta_M"), " である。"]),
      paragraph(["(4) ", math(String.raw`[H_2, \hat{Z}_\mu^{(\pm)}]`), " について、", math(String.raw`\mu \in \mathcal{M}`), " を任意に取る。準備として次の 3 つを先に用意する。"]),
      paragraph(["準備 1（", math(String.raw`\hat{Z}`), " と ", math(String.raw`\hat{Y}`), " の入れ替え）。", math(String.raw`\hat{Z}_\mu^{(\pm)}\hat{Y}_j = -\hat{Y}_j\hat{Z}_\mu^{(\pm)}`), " である（", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の ", math(String.raw`[\hat{Z}_\mu^{(\pm)}, \hat{Y}_\nu]_+ = 0`), " を移項したもの）。"]),
      paragraph(["準備 2（和に残る ", math(String.raw`j`), " の決定）。", math(String.raw`j \in \{1,\dots,M\}`), " かつ ", math(String.raw`-j+\mu \equiv 0 \pmod{M}`), " を満たす ", math(String.raw`j`), " はちょうど 1 つであり、"]),
      displayMath(String.raw`j = \begin{cases}
M & (\mu = -M) \\
M+\mu & (-M+1 \leq \mu \leq -1) \\
\mu & (1 \leq \mu \leq M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`),
      paragraph(["準備 3（", math(String.raw`\hat{Y}`), " の ", math(String.raw`M`), " 周期性）。", math(String.raw`\nu \in \mathbb{Z}`), " について ", math(String.raw`\hat{Y}_{\nu+M} = \hat{Y}_\nu`), " である（", "〔hatZ_hatY_M_periodicity〕", "）。以上のもとで、まず ", math(String.raw`\hat{Z}`), " の符号によらず次まで進む。"]),
      displayMath(String.raw`\begin{aligned}
[H_2, \hat{Z}_\mu^{(\pm)}]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right)
&&(\because\ \text{スカラー倍は行列の積と可換に動かせる})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Z}_\mu^{(\pm)}
   - \sum_{j\in\{1,\dots,M\}}\hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}\hat{Y}_j
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{準備 1})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-\hat{Z}_{-j}^{(-)}\hat{Z}_\mu^{(\pm)}
   - \hat{Z}_\mu^{(\pm)}\hat{Z}_{-j}^{(-)}\right)\hat{Y}_j
&&(\because\ \text{分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_{-j}^{(-)},\hat{Z}_\mu^{(\pm)}]_+\right)\hat{Y}_j
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(\pm)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
&&(\because\ \text{反交換子は 2 つの引数の順序を入れ替えても変わらない})
\end{aligned}`),
      paragraph(["以下、", math(String.raw`\hat{Z}`), " の符号で分岐する（反交換子 ", math(String.raw`[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+`), " と ", math(String.raw`[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\mp)}]_+`), " の値が違うためである。", "〔anticommutator_of_hat_Z_and_hat_Y〕", "）。"]),
      paragraph(["(4.1) ", math(String.raw`[H_2, \hat{Z}_\mu^{(-)}]`), " について："]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(-)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Y}_j
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\pm)}]_+\ \text{の値})\\
&= -2\sum_{j\in\{1,\dots,M\}}\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\,\hat{Y}_j
&&(\because\ \text{スカラーの整理})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}} \hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義と単位行列との積})\\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
&&(\because\ \text{準備 2})\\
&= -2\,\hat{Y}_\mu
&&(\because\ \text{準備 3}\ \text{（$\mu=-M$ では $\nu=0,-M$ として 2 度、$-M+1\leq\mu\leq-1$ では $\nu=\mu$ として 1 度当てる）})
\end{aligned}`),
      paragraph(["(4.2) ", math(String.raw`[H_2, \hat{Z}_\mu^{(+)}]`), " について："]),
      displayMath(String.raw`\begin{aligned}
&\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-[\hat{Z}_\mu^{(+)},\hat{Z}_{-j}^{(-)}]_+\right)\hat{Y}_j \\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(
   -\left(2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + \left(-2\,\exp(-i\frac{2\pi}{M}(-j+\mu))\cdot 2\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\right)\right)\hat{Y}_j
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Z}^{(\pm)},\hat{Z}^{(\mp)}]_+\ \text{の値を}\ \nu=-j\ \text{で使う})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(
   -2M\,\delta^M_{-j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
   + 4\,\exp(-i\frac{2\pi}{M}(-j+\mu))\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)\hat{Y}_j
&&(\because\ \text{括弧の展開（負号を両項へ配る）と複素数の四則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,\hat{Y}_j
   + 4\,\exp(-i\frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j\right)
&&(\because\ \text{分配則と単位行列との積})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(-2M\,\delta^M_{-j+\mu,0}\,\hat{Y}_j\right)
   + \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(4\,\exp(-i\frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j\right)
&&(\because\ \text{項ごとの和の有限和は有限和どうしの和})\\
&= -2\sum_{\substack{j\in\{1,\dots,M\}\\ -j+\mu\equiv 0 \pmod{M}}}\hat{Y}_j
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j
&&(\because\ \text{$\delta^M$ の定義とスカラーの整理})\\
&= -2\begin{cases}
\hat{Y}_M & (\mu = -M) \\
\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
\hat{Y}_\mu & (1 \leq \mu \leq M)
\end{cases}
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j
&&(\because\ \text{準備 2})\\
&= -2\,\hat{Y}_\mu
   + \frac{4}{M}\sum_{j\in\{1,\dots,M\}} \exp(-i\frac{2\pi}{M}(-j+\mu))\,\hat{Y}_j
&&(\because\ \text{準備 3}\ \text{（$\mu=-M$ では $\nu=0,-M$ として 2 度、$-M+1\leq\mu\leq-1$ では $\nu=\mu$ として 1 度当てる）})
\end{aligned}`),
      paragraph(["第 2 項は消えない。", math(String.raw`\hat{Y}_j`), " の定義を入れて ", math(String.raw`j`), " について和を取ると ", math(String.raw`4\,\exp(-i\frac{2\pi\mu}{M})\,Y_1`), " になる（", "〔why_008_applies_only_to_minus_sector〕", " が ", math(String.raw`\left[H_2,\hat{Z}_\mu^{(+)}\right] = -2\hat{Y}_\mu + 4\,\exp(-i\frac{2\pi\mu}{M})\,Y_1`), " として使っている形である）。", "すなわち ", math(String.raw`[H_2, \hat{Z}_\mu^{(+)}] \neq -2\hat{Y}_\mu`), " であり、(4.1) と同じ形にはならない。"]),
      paragraph(["(5) ", math(String.raw`[H_2, \hat{Y}_\mu]`), " について、", math(String.raw`\mu \in \mathcal{M}`), " を任意に取る。準備として次の 3 つを先に用意する", "（以下この (5) の中でだけ準備 1〜3 と呼ぶ）。"]),
      paragraph(["準備 1（", math(String.raw`\hat{Y}`), " と ", math(String.raw`\hat{Z}`), " の入れ替え）。", math(String.raw`\hat{Y}_\mu\hat{Z}_{-j}^{(-)} = -\hat{Z}_{-j}^{(-)}\hat{Y}_\mu`), " である（", "〔anticommutator_of_hat_Z_and_hat_Y〕", " の ", math(String.raw`[\hat{Z}_\nu^{(\pm)}, \hat{Y}_{\nu'}]_+ = 0`), " を移項したもの）。"]),
      paragraph(["準備 2（和に残る ", math(String.raw`j`), " の決定）。", math(String.raw`j \in \{1,\dots,M\}`), " かつ ", math(String.raw`j+\mu \equiv 0 \pmod{M}`), " を満たす ", math(String.raw`j`), " はちょうど 1 つであり、"]),
      displayMath(String.raw`j = \begin{cases}
-\mu & (-M \leq \mu \leq -1) \\
M-\mu & (1 \leq \mu \leq M-1) \\
M & (\mu = M)
\end{cases}
\qquad (\because\ 1 \leq j \leq M\ \text{と合同式の条件})`),
      paragraph(["準備 3（", math(String.raw`\hat{Z}`), " の ", math(String.raw`M`), " 周期性）。", math(String.raw`\nu \in \mathbb{Z}`), " について ", math(String.raw`\hat{Z}_{\nu+M}^{(-)} = \hat{Z}_\nu^{(-)}`), " である（", "〔hatZ_hatY_M_periodicity〕", "）。以上のもとで、"]),
      displayMath(String.raw`\begin{aligned}
[H_2, \hat{Y}_\mu]
&= \left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{$H_1^{(\pm)}, H_2$ を $\hat{Z}, \hat{Y}$ で表す、と交換子の定義})\\
&= \frac{1}{M}\left(\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\hat{Y}_\mu
   - \hat{Y}_\mu\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)\right)
&&(\because\ \text{スカラー倍は行列の積と可換に動かせる})\\
&= \frac{1}{M}\left(\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \sum_{j\in\{1,\dots,M\}}\hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和と行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   - \hat{Y}_\mu\hat{Z}_{-j}^{(-)}\hat{Y}_j\right)
&&(\because\ \text{有限和どうしの差は項ごとの差の和})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Z}_{-j}^{(-)}\hat{Y}_j\hat{Y}_\mu
   + \hat{Z}_{-j}^{(-)}\hat{Y}_\mu\hat{Y}_j\right)
&&(\because\ \text{準備 1})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\left(\hat{Y}_j\hat{Y}_\mu
   + \hat{Y}_\mu\hat{Y}_j\right)
&&(\because\ \text{行列の積の分配則})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\,[\hat{Y}_j,\hat{Y}_\mu]_+
&&(\because\ \text{反交換子の定義})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}
   \left(2M\,\delta^M_{j+\mu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
&&(\because\ \text{$\hat{Z}$ と $\hat{Y}$ の反交換関係の}\ [\hat{Y},\hat{Y}]_+\ \text{の値})\\
&= \frac{1}{M}\sum_{j\in\{1,\dots,M\}} 2M\,\delta^M_{j+\mu,0}\,\hat{Z}_{-j}^{(-)}
&&(\because\ \text{単位行列との積と、スカラー倍を行列の前へ出すこと})\\
&= 2\sum_{\substack{j\in\{1,\dots,M\}\\ j+\mu\equiv 0 \pmod{M}}} \hat{Z}_{-j}^{(-)}
&&(\because\ \text{$\delta^M$ の定義とスカラーの整理})\\
&= 2\begin{cases}
\hat{Z}_\mu^{(-)} & (-M \leq \mu \leq -1) \\
\hat{Z}_{-M+\mu}^{(-)} & (1 \leq \mu \leq M-1) \\
\hat{Z}_{-M}^{(-)} & (\mu = M)
\end{cases}
&&(\because\ \text{準備 2})\\
&= 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{準備 3}\ \text{（$-M\leq\mu\leq-1$ では使わず、$1\leq\mu\leq M-1$ では $\nu=-M+\mu$ として 1 度、$\mu=M$ では $\nu=-M,0$ として 2 度当てる）})
\end{aligned}`),
      paragraph(["引いたブロックは ", "〔hatZ_hatY_M_periodicity〕", "、", "〔H1_H2_via_hatZ_hatY〕", "、", "〔anticommutator_of_hat_Z_and_hat_Y〕", "、", ref("def_delta_M"), " である。"]),
    ],
  },
  {
    id: "note_evensectorT_002_claim_nesting_commutator_integer_route_TV1_hatZ_hatY_002_claim_nesting_commutator",
    targets: ["nesting_of_commutator_of_H_and_check_Z"],
    title: null,
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ", ordinal: 2 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_002_claim_nesting_commutator。labels: nesting_of_commutator_of_H_and_Z。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`n \in \mathbb{Z}_{\geq 0}`), "、", math(String.raw`\mu \in \mathcal{M}`), " とする。以下に現れる ", math(String.raw`H_1^{(\pm)}, H_2, \hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`), " はすべて結合代数 ", math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`), " の元であり（", "〔H1_H2_via_hatZ_hatY〕", "、", "〔def_hatZ_pm〕", "、", "〔def_hatY〕", "）、", math(String.raw`K_1, K_2^* \in \mathbb{R}`), " はスカラー、", math(String.raw`[X, Y] := XY - YX`), " は同代数の交換子である。"]),
      paragraph(["また、", math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`), " を固定するごとに ", math(String.raw`n`), " 重の交換子を"]),
      displayMath(String.raw`\underbrace{[X,\dots,[X, W]\dots]}_{n}
:= \underbrace{\mathrm{ad}_X \circ \cdots \circ \mathrm{ad}_X}_{n}(W),
\qquad \mathrm{ad}_X(W) := [X, W]`),
      paragraph(["と定める（", math(String.raw`\mathrm{ad}_X : \mathrm{Mat}(2^M,\mathbb{C}) \to \mathrm{Mat}(2^M,\mathbb{C})`), " は ", math(String.raw`\mathbb{C}`), " 線型写像）。とくに ", math(String.raw`n = 0`), " の場合は恒等写像であり、0 重の交換子の値は作用素そのもの ", math(String.raw`W`), " である。"]),
      paragraph(["(h1.z)"]),
      displayMath(String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_1)^n \exp(-i 2\pi\mu/M) \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Z}_\mu^{(\pm)}`), "）"]),
      paragraph(["(h1.y)"]),
      displayMath(String.raw`\underbrace{[K_1 H_1^{(\pm)}, \dots, [K_1 H_1^{(\pm)}, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_1)^n \exp(i 2\pi\mu/M) \hat{Z}_\mu^{(\pm)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Y}_\mu`), "）"]),
      paragraph(["(h2.z−)"]),
      displayMath(String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Z}_\mu^{(-)}`), "）"]),
      paragraph(["(h2.y)"]),
      displayMath(String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`),
      paragraph(["（ただし ", math(String.raw`n=0`), " のとき値は ", math(String.raw`\hat{Y}_\mu`), "）"]),
      paragraph(["証明."]),
      paragraph(["以下、", math(String.raw`\theta := \dfrac{2\pi\mu}{M} \in \mathbb{R}`), " と略記する。証明はすべて ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " に関する帰納法であり、帰納段階では ", "〔commutator_of_H_and_Z_Y〕", " の 1 重の交換子の公式"]),
      displayMath(String.raw`\begin{aligned}
\text{(A)}\quad [H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] &= 2 \exp(-i\theta)\hat{Y}_\mu, &
\text{(B)}\quad [H_1^{(\pm)}, \hat{Y}_\mu] &= -2 \exp(i\theta)\hat{Z}_\mu^{(\pm)}, \\
\text{(C)}\quad [H_2, \hat{Z}_\mu^{(-)}] &= -2\,\hat{Y}_\mu, &
\text{(D)}\quad [H_2, \hat{Y}_\mu] &= 2\,\hat{Z}_\mu^{(-)}
\end{aligned}`),
      paragraph(["と、交換子の第 1 引数・第 2 引数についての ", math(String.raw`\mathbb{C}`), " 双線型性"]),
      displayMath(String.raw`[\alpha X, \beta W] = \alpha\beta\,[X, W]
\qquad (\alpha, \beta \in \mathbb{C},\ X, W \in \mathrm{Mat}(2^M,\mathbb{C}))`),
      paragraph(["のみを用いる。後者は次の一続きの計算による（スカラー倍が積と可換なことは ", ref("scalar_identity_commutes"), " による）。"]),
      displayMath(String.raw`\begin{aligned}
[\alpha X, \beta W]
&= (\alpha X)(\beta W) - (\beta W)(\alpha X)
&&(\because\ \text{交換子の定義})\\
&= \alpha\beta\,(XW) - \beta\alpha\,(WX)
&&(\because\ \text{スカラー倍が積と可換なこと})\\
&= \alpha\beta\,(XW - WX)
&&(\because\ \mathbb{C}\ \text{の積の可換則}\ \beta\alpha=\alpha\beta\ \text{と分配則})\\
&= \alpha\beta\,[X, W]
&&(\because\ \text{交換子の定義})
\end{aligned}`),
      paragraph(["各主張の右辺は ", math(String.raw`n`), " の偶奇で場合分けされているので、帰納段階は「", math(String.raw`n`), " 偶数 → ", math(String.raw`n+1`), " 奇数」「", math(String.raw`n`), " 奇数 → ", math(String.raw`n+1`), " 偶数」の 2 通りを別々に示す。"]),
      paragraph(["(h1.z) の証明。", math(String.raw`C_n := \underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]\dots]}_{n}`), " とおく。定義より ", math(String.raw`C_{n+1} = [K_1 H_1^{(\pm)},\, C_n]`), " が ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について成り立つ。"]),
      paragraph(["基底段階（", math(String.raw`n = 0`), "、偶数）。", math(String.raw`C_0`), " から主張の偶数側の右辺へ至る。"]),
      displayMath(String.raw`\begin{aligned}
C_0
&= \hat{Z}_\mu^{(\pm)}
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Z}_\mu^{(\pm)}
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_1)^{0}\hat{Z}_\mu^{(\pm)}
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_1\ \text{へ})
\end{aligned}`),
      paragraph(["帰納段階 1（", math(String.raw`n`), " 偶数 → ", math(String.raw`n+1`), " 奇数）。", math(String.raw`n`), " が偶数で ", math(String.raw`C_n = (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ C_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot 2 \exp(-i\theta)\hat{Y}_\mu
&&(\because\ \text{(A)}) \\
&= (-1)^{n/2}(2K_1)^{n+1} \exp(-i\theta)\hat{Y}_\mu
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{((n+1)-1)/2}(2K_1)^{n+1} \exp(-i\theta)\hat{Y}_\mu
&&(\because\ \tfrac{(n+1)-1}{2}=\tfrac{n}{2})
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が奇数のときの主張の右辺である。"]),
      paragraph(["帰納段階 2（", math(String.raw`n`), " 奇数 → ", math(String.raw`n+1`), " 偶数）。", math(String.raw`n`), " が奇数で ", math(String.raw`C_n = (-1)^{(n-1)/2}(2K_1)^n \exp(-i\theta)\hat{Y}_\mu`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(\pm)},\ C_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n-1)/2}(2K_1)^n \exp(-i\theta)\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n \exp(-i\theta)\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n \exp(-i\theta)\cdot\left(-2 \exp(i\theta)\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ \text{(B)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\,\exp(-i\theta)\exp(i\theta)\,\hat{Z}_\mu^{(\pm)}
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\exp(0)\hat{Z}_\mu^{(\pm)}
&&(\because\ \text{複素指数関数の積公式と}\ -i\theta+i\theta=0) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ \exp(0)=1) \\
&= (-1)^{(n-1)/2+1}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Z}_\mu^{(\pm)}
&&(\because\ \tfrac{n-1}{2}+1=\tfrac{n+1}{2})
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について (h1.z) が成り立つ。"]),
      paragraph(["(h1.y) の証明。", math(String.raw`D_n := \underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)}, \hat{Y}_\mu]\dots]}_{n}`), " とおく。", math(String.raw`D_{n+1} = [K_1 H_1^{(\pm)},\, D_n]`), "。"]),
      paragraph(["基底段階（", math(String.raw`n = 0`), "、偶数）。", math(String.raw`D_0`), " から主張の偶数側の右辺へ至る。"]),
      displayMath(String.raw`\begin{aligned}
D_0
&= \hat{Y}_\mu
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Y}_\mu
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_1)^{0}\hat{Y}_\mu
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_1\ \text{へ})
\end{aligned}`),
      paragraph(["帰納段階 1（", math(String.raw`n`), " 偶数 → ", math(String.raw`n+1`), " 奇数）。", math(String.raw`n`), " が偶数で ", math(String.raw`D_n = (-1)^{n/2}(2K_1)^n\hat{Y}_\mu`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ D_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{n/2}(2K_1)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(\pm)},\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot\left(-2 \exp(i\theta)\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ \text{(B)}) \\
&= (-1)\cdot(-1)^{n/2}(2K_1)^{n+1} \exp(i\theta)\hat{Z}_\mu^{(\pm)}
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{n/2+1}(2K_1)^{n+1} \exp(i\theta)\hat{Z}_\mu^{(\pm)}
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{((n+1)+1)/2}(2K_1)^{n+1} \exp(i\theta)\hat{Z}_\mu^{(\pm)}
&&(\because\ \tfrac{(n+1)+1}{2}=\tfrac{n}{2}+1)
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が奇数のときの主張の右辺である。"]),
      paragraph(["帰納段階 2（", math(String.raw`n`), " 奇数 → ", math(String.raw`n+1`), " 偶数）。", math(String.raw`n`), " が奇数で ", math(String.raw`D_n = (-1)^{(n+1)/2}(2K_1)^n \exp(i\theta)\hat{Z}_\mu^{(\pm)}`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(\pm)},\ D_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_1 H_1^{(\pm)},\ (-1)^{(n+1)/2}(2K_1)^n \exp(i\theta)\hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n \exp(i\theta)\left[H_1^{(\pm)},\ \hat{Z}_\mu^{(\pm)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n \exp(i\theta)\cdot 2 \exp(-i\theta)\hat{Y}_\mu
&&(\because\ \text{(A)}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\,\exp(i\theta)\exp(-i\theta)\,\hat{Y}_\mu
&&(\because\ 2K_1\cdot(2K_1)^{n}=(2K_1)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\hat{Y}_\mu
&&(\because\ \exp(i\theta)\exp(-i\theta)=\exp(0)=1)
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について (h1.y) が成り立つ。"]),
      paragraph(["(h2.z−) の証明。", math(String.raw`E_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \hat{Z}_\mu^{(-)}]\dots]}_{n}`), " とおく。", math(String.raw`E_{n+1} = [K_2^* H_2,\, E_n]`), "。この場合は位相因子が現れない（(C), (D) の右辺に ", math(String.raw`\exp(\pm i\theta)`), " が無い）。"]),
      paragraph(["基底段階（", math(String.raw`n = 0`), "、偶数）。", math(String.raw`E_0`), " から主張の偶数側の右辺へ至る。"]),
      displayMath(String.raw`\begin{aligned}
E_0
&= \hat{Z}_\mu^{(-)}
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Z}_\mu^{(-)}
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_2^*)^{0}\hat{Z}_\mu^{(-)}
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_2^*\ \text{へ})
\end{aligned}`),
      paragraph(["帰納段階 1（", math(String.raw`n`), " 偶数 → ", math(String.raw`n+1`), " 奇数）。", math(String.raw`n`), " が偶数で ", math(String.raw`E_n = (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ E_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
&&(\because\ \text{(C)}) \\
&= (-1)\cdot(-1)^{n/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{n/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{((n+1)+1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ \tfrac{(n+1)+1}{2}=\tfrac{n}{2}+1)
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が奇数のときの主張の右辺である。"]),
      paragraph(["帰納段階 2（", math(String.raw`n`), " 奇数 → ", math(String.raw`n+1`), " 偶数）。", math(String.raw`n`), " が奇数で ", math(String.raw`E_n = (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ E_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{(n+1)/2}(2K_2^*)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{(D)}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性})
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について (h2.z−) が成り立つ。"]),
      paragraph(["(h2.y) の証明。", math(String.raw`F_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \hat{Y}_\mu]\dots]}_{n}`), " とおく。", math(String.raw`F_{n+1} = [K_2^* H_2,\, F_n]`), "。"]),
      paragraph(["基底段階（", math(String.raw`n = 0`), "、偶数）。", math(String.raw`F_0`), " から主張の偶数側の右辺へ至る。"]),
      displayMath(String.raw`\begin{aligned}
F_0
&= \hat{Y}_\mu
&&(\because\ 0\ \text{重の交換子の規約}) \\
&= 1\cdot 1\cdot\hat{Y}_\mu
&&(\because\ 1\ \text{はスカラー倍の単位元}) \\
&= (-1)^{0/2}(2K_2^*)^{0}\hat{Y}_\mu
&&(\because\ \alpha^{0}=1\ \text{を}\ \alpha=-1\ \text{と}\ \alpha=2K_2^*\ \text{へ})
\end{aligned}`),
      paragraph(["帰納段階 1（", math(String.raw`n`), " 偶数 → ", math(String.raw`n+1`), " 奇数）。", math(String.raw`n`), " が偶数で ", math(String.raw`F_n = (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ F_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\hat{Y}_\mu\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \hat{Y}_\mu\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot 2\,\hat{Z}_\mu^{(-)}
&&(\because\ \text{(D)}) \\
&= (-1)^{n/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{((n+1)-1)/2}(2K_2^*)^{n+1}\hat{Z}_\mu^{(-)}
&&(\because\ \tfrac{(n+1)-1}{2}=\tfrac{n}{2})
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が奇数のときの主張の右辺である。"]),
      paragraph(["帰納段階 2（", math(String.raw`n`), " 奇数 → ", math(String.raw`n+1`), " 偶数）。", math(String.raw`n`), " が奇数で ", math(String.raw`F_n = (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}`), " と仮定する。"]),
      displayMath(String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ F_n\right]
&&(\because\ n\ \text{重の交換子の定義}) \\
&= \left[K_2^* H_2,\ (-1)^{(n-1)/2}(2K_2^*)^n\hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&&(\because\ \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\cdot\left(-2\,\hat{Y}_\mu\right)
&&(\because\ \text{(C)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ 2K_2^*\cdot(2K_2^*)^{n}=(2K_2^*)^{n+1}\ \text{とスカラーの積の可換性}) \\
&= (-1)^{(n-1)/2+1}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ (-1)\cdot(-1)^{k}=(-1)^{k+1}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\hat{Y}_\mu
&&(\because\ \tfrac{n-1}{2}+1=\tfrac{n+1}{2})
\end{aligned}`),
      paragraph(["最後の行が、", math(String.raw`n+1`), " が偶数のときの主張の右辺である。基底段階と 2 つの帰納段階により、すべての ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について (h2.y) が成り立つ。"]),
    ],
  },
  {
    id: "note_evensectorT_003_claim_coefficient_conversion_integer_route_TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion",
    targets: ["cosh_sinh_coefficient_conversion_for_check"],
    title: null,
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/002_claim_cosh_sinhの展開係数への変換.typ", ordinal: 3 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion。labels: cosh_sinh_coefficient_conversion。以下は本文にあったときの内容のまま。）"]),
      paragraph(["(h1.z)"]),
      displayMath(String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \begin{cases}
i K_1^n \exp(-i 2\pi\mu/M) \hat{Y}_\mu & (n \text{ 奇数}) \\
K_1^n \hat{Z}_\mu^{(\pm)} & (n \text{ 偶数})
\end{cases}`),
      paragraph(["(h1.y)"]),
      displayMath(String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i K_1^n \exp(i 2\pi\mu/M) \hat{Z}_\mu^{(\pm)} & (n \text{ 奇数}) \\
K_1^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`),
      paragraph(["(h2.z−)"]),
      displayMath(String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n \hat{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 偶数})
\end{cases}`),
      paragraph(["(h2.y)"]),
      displayMath(String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i (2K_2^*)^n \hat{Z}_\mu^{(-)} & (n \text{ 奇数}) \\
(2K_2^*)^n \hat{Y}_\mu & (n \text{ 偶数})
\end{cases}`),
      paragraph(["証明."]),
      paragraph(["以下、", math(String.raw`\theta := \dfrac{2\pi\mu}{M} \in \mathbb{R}`), " と略記する。まず 4 式すべてで用いる次の 2 つの補題を用意する。"]),
      paragraph(["補題 1（生成子のスカラー倍）：", math(String.raw`\alpha \in \mathbb{C}`), "、", math(String.raw`X, W \in \mathrm{Mat}(2^M,\mathbb{C})`), "、", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について"]),
      displayMath(String.raw`\underbrace{[\alpha X,\dots,[\alpha X, W]\dots]}_{n}
= \alpha^{n}\,\underbrace{[X,\dots,[X, W]\dots]}_{n}`),
      paragraph(["が成り立つ。実際、任意の ", math(String.raw`W`), " について"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}(W)
&= [\alpha X, W]
&&(\because\ \mathrm{ad}\ \text{の定義})\\
&= \alpha[X, W]
&&(\because\ \text{交換子の第 1 引数についての}\ \mathbb{C}\ \text{線型性})\\
&= \alpha\,\mathrm{ad}_X(W)
&&(\because\ \mathrm{ad}\ \text{の定義})
\end{aligned}`),
      paragraph(["であるから、線型写像として ", math(String.raw`\mathrm{ad}_{\alpha X} = \alpha\,\mathrm{ad}_X`), " が成り立つ。よって、任意の ", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}^{\,n}
&= (\alpha\,\mathrm{ad}_X)^n
&&(\because\ \text{上で示した}\ \mathrm{ad}_{\alpha X} = \alpha\,\mathrm{ad}_X)\\
&= \alpha^{n}\,\mathrm{ad}_X^{\,n}
&&(\because\ \mathrm{ad}_X\ \text{は}\ \mathbb{C}\ \text{線型なのでスカラー倍と可換であり、合成の各段からスカラーを前へ出せる。}\ n=0\ \text{のときは両辺とも恒等写像で}\ \alpha^{0}=1)
\end{aligned}`),
      paragraph(["が成り立つ。"]),
      paragraph(["補題 2（虚数単位の冪）：", math(String.raw`n \in \mathbb{Z}_{\geq 0}`), " について"]),
      displayMath(String.raw`i^{n} = \begin{cases}
i\,(-1)^{(n-1)/2} & (n \text{ 奇数}) \\
(-1)^{n/2} & (n \text{ 偶数})
\end{cases}`),
      paragraph(["が成り立つ。実際、", math(String.raw`n`), " が偶数のとき ", math(String.raw`n/2 \in \mathbb{Z}_{\geq 0}`), "、奇数のとき ", math(String.raw`(n-1)/2 \in \mathbb{Z}_{\geq 0}`), " なので、以下の指数はいずれも整数である。", math(String.raw`n`), " が偶数なら"]),
      displayMath(String.raw`\begin{aligned}
i^n
&= (i^2)^{n/2}
   \quad (\because \text{指数法則 } (i^2)^{n/2}=i^{2\cdot(n/2)}=i^{n}) \\
&= (-1)^{n/2}
   \quad (\because i^2=-1)
\end{aligned}`),
      paragraph(["であり、", math(String.raw`n`), " が奇数なら"]),
      displayMath(String.raw`\begin{aligned}
i^n
&= i\cdot i^{n-1}
   \quad (\because \text{指数法則 } i^{1+(n-1)}=i\cdot i^{n-1}) \\
&= i\,(i^2)^{(n-1)/2}
   \quad (\because \text{指数法則 } (i^2)^{(n-1)/2}=i^{2\cdot((n-1)/2)}=i^{n-1}) \\
&= i\,(-1)^{(n-1)/2}
   \quad (\because i^2=-1)
\end{aligned}`),
      paragraph(["である。"]),
      paragraph(["(h1.z) について、", "〔nesting_of_commutator_of_H_and_Z〕", " (h1.z) の生成子を ", math(String.raw`K_1 H_1^{(\pm)} \to \tfrac{i}{2}K_1 H_1^{(\pm)}`), " に置き換えて代入する。すなわち補題 1 を ", math(String.raw`\alpha = \tfrac{i}{2}`), "、", math(String.raw`X = K_1 H_1^{(\pm)}`), "、", math(String.raw`W = \hat{Z}_\mu^{(\pm)}`), " として使い、さらに補題 2 で ", math(String.raw`i^n`), " を書き換える。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(\pm)},\dots,\left[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_1)^{n} \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h1.z)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,(-1)^{(n-1)/2}\,2^{n}K_1^{n}\, \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,(-1)^{n/2}\,2^{n}K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \left(\tfrac{i}{2}\right)^{n} = i^{n}2^{-n},\ (2K_1)^n = 2^n K_1^n\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ 2^{-n}2^{n} = 1) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}\,K_1^{n}\, \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}\,K_1^{n}\, \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n-1}{2} = n-1,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
i\,K_1^{n}\, \exp(-i\theta)\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n-1} = 1,\ n\text{ 偶数なら }(-1)^{n} = 1) \\
&= \begin{cases}
i\,K_1^{n}\, \exp(-i 2\pi\mu/M)\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \theta = \tfrac{2\pi\mu}{M}\ \text{の定義})
\end{aligned}`),
      paragraph(["最後の行が (h1.z) の主張の右辺である。"]),
      paragraph(["(h1.y) について、同じく補題 1 を ", math(String.raw`\alpha = \tfrac{i}{2}`), "、", math(String.raw`X = K_1 H_1^{(\pm)}`), "、", math(String.raw`W = \hat{Y}_\mu`), " として使う。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(\pm)},\dots,\left[K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_1)^{n} \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h1.y)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,(-1)^{(n+1)/2}\,2^{n}K_1^{n}\, \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,(-1)^{n/2}\,2^{n}K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \left(\tfrac{i}{2}\right)^{n} = i^{n}2^{-n},\ (2K_1)^n = 2^n K_1^n\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ 2^{-n}2^{n} = 1) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}\,K_1^{n}\, \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}\,K_1^{n}\, \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n+1}{2} = n,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
-i\,K_1^{n}\, \exp(i\theta)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n} = -1,\ n\text{ 偶数なら }(-1)^{n} = 1) \\
&= \begin{cases}
-i\,K_1^{n}\, \exp(i 2\pi\mu/M)\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\,\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \theta = \tfrac{2\pi\mu}{M}\ \text{の定義})
\end{aligned}`),
      paragraph(["最後の行が (h1.y) の主張の右辺である。"]),
      paragraph(["(h2.z−) について、補題 1 を ", math(String.raw`\alpha = i`), "、", math(String.raw`X = K_2^* H_2`), "、", math(String.raw`W = \hat{Z}_\mu^{(-)}`), " として使う。今回は ", math(String.raw`\alpha = i`), " で 2 の冪が現れないので、", math(String.raw`(2K_2^*)^n`), " はそのまま残る。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h2.z−)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n+1}{2} = n,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
-i\,(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }(-1)^{n} = -1,\ n\text{ 偶数なら }(-1)^{n} = 1)
\end{aligned}`),
      paragraph(["最後の行が (h2.z−) の主張の右辺である。"]),
      paragraph(["(h2.y) について、補題 1 を ", math(String.raw`\alpha = i`), "、", math(String.raw`X = K_2^* H_2`), "、", math(String.raw`W = \hat{Y}_\mu`), " として使う。"]),
      displayMath(String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n}
&&(\because\ \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{交換子のネスト (h2.y)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&\left(\because\ \tfrac{n-1}{2}+\tfrac{n-1}{2} = n-1,\ \tfrac{n}{2}+\tfrac{n}{2} = n\right) \\
&= \begin{cases}
i\,(2K_2^*)^{n}\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(2K_2^*)^{n}\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n\text{ 奇数なら }n-1\text{ は偶数で }(-1)^{n-1} = 1,\ n\text{ 偶数なら }(-1)^{n} = 1)
\end{aligned}`),
      paragraph(["最後の行が (h2.y) の主張の右辺である。"]),
      paragraph(["以上 4 式が、", "〔nesting_of_commutator_of_H_and_Z〕", " の各式に補題 1・補題 2 を適用して得られた。"]),
    ],
  },
  {
    id: "note_evensectorT_004_claim_extract_taylor_integer_route_TV1_hatZ_hatY_005_claim_extract_taylor_coefficient",
    targets: ["extract_taylor_coefficient_of_check_Z_Y"],
    title: null,
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ", ordinal: 5 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_005_claim_extract_taylor_coefficient。labels: extract_taylor_coefficient_of_Z_Y。以下は本文にあったときの内容のまま。）"]),
      paragraph(["(h1.z)"]),
      displayMath(String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}\right]\dots\right]}_{n}
= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i \exp(-i 2\pi\mu/M)\sinh(K_1)\hat{Y}_\mu`),
      paragraph(["(h1.y)"]),
      displayMath(String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n}
= -i \exp(i 2\pi\mu/M)\sinh(K_1)\hat{Z}_\mu^{(\pm)} + \cosh(K_1)\hat{Y}_\mu`),
      paragraph(["(h2.z−)"]),
      displayMath(String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{[i K_2^* H_2,\dots,[i K_2^* H_2,\hat{Z}_\mu^{(-)}]\dots]}_{n}
= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu`),
      paragraph(["(h2.y)"]),
      displayMath(String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{[i K_2^* H_2,\dots,[i K_2^* H_2,\hat{Y}_\mu]\dots]}_{n}
= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu`),
      paragraph(["証明."]),
      paragraph(["以下、各級数を ", "〔cosh_sinh_coefficient_conversion〕", " により偶数項・奇数項に分け、", "〔nesting_of_commutator_of_H_and_Z〕", " 直後の sinh/cosh テイラー展開を用いる。"]),
      paragraph(["(h1.z) について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(\pm)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot K_1^{n}\cdot \exp(-i\frac{2\pi\mu}{M})\cdot\hat{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h1.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\hat{Z}_\mu^{(\pm)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,\exp(-i\frac{2\pi\mu}{M})\,\hat{Y}_\mu\right)
&&(\because\ K_1^{0}\hat{Z}_\mu^{(\pm)} = \tfrac{1}{0!}\hat{Z}_\mu^{(\pm)}\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\hat{Z}_\mu^{(\pm)}
   + i\,\exp(-i\frac{2\pi\mu}{M})\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\hat{Y}_\mu
&&(\because\ \hat{Z}_\mu^{(\pm)},\ \hat{Y}_\mu,\ i\,\exp(-i 2\pi\mu/M)\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(K_1)\hat{Z}_\mu^{(\pm)} + i\,\exp(-i\frac{2\pi\mu}{M})\sinh(K_1)\hat{Y}_\mu
&&(\because\ \text{「sinh, cosh のテイラー展開」})
\end{aligned}`),
      paragraph(["鎖の終点は主張の (h1.z) の右辺と字句どおり一致する。", "以下の 3 式でも、", math(String.raw`n = 0`), " の項を同じ理由で偶数側の和へ吸収する。"]),
      paragraph(["(h1.y) について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\cdot K_1^{n}\cdot \exp(i\frac{2\pi\mu}{M})\cdot\hat{Z}_\mu^{(\pm)} & (n\text{ 奇数}) \\
K_1^{n}\cdot\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h1.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\hat{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,K_1^{n}\,\exp(i\frac{2\pi\mu}{M})\,\hat{Z}_\mu^{(\pm)}\right)
&&(\because\ K_1^{0}\hat{Y}_\mu = \tfrac{1}{0!}\hat{Y}_\mu\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\hat{Y}_\mu
   - i\,\exp(i\frac{2\pi\mu}{M})\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\hat{Z}_\mu^{(\pm)}
&&(\because\ \hat{Y}_\mu,\ \hat{Z}_\mu^{(\pm)},\ (-i)\,\exp(i 2\pi\mu/M)\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(K_1)\hat{Y}_\mu - i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1)\hat{Z}_\mu^{(\pm)}
&&(\because\ \text{「sinh, cosh のテイラー展開」}) \\
&= -i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1)\hat{Z}_\mu^{(\pm)} + \cosh(K_1)\hat{Y}_\mu
&&(\because\ \text{行列の和の可換則により 2 つの項を並べ替えた})
\end{aligned}`),
      paragraph(["鎖の終点は主張の (h1.y) の右辺と字句どおり一致する。"]),
      paragraph(["(h2.z−) について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Z}_\mu^{(-)}
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\cdot (2K_2^*)^{n}\cdot\hat{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\cdot\hat{Z}_\mu^{(-)} & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h2.z−)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\hat{Z}_\mu^{(-)}\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,(2K_2^*)^{n}\,\hat{Y}_\mu\right)
&&(\because\ (2K_2^*)^{0}\hat{Z}_\mu^{(-)} = \tfrac{1}{0!}\hat{Z}_\mu^{(-)}\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Z}_\mu^{(-)}
   - i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Y}_\mu
&&(\because\ \hat{Z}_\mu^{(-)},\ \hat{Y}_\mu,\ -i\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu
&&(\because\ \text{「sinh, cosh のテイラー展開」})
\end{aligned}`),
      paragraph(["鎖の終点は主張の (h2.z−) の右辺と字句どおり一致する。"]),
      paragraph(["(h2.y) について、"]),
      displayMath(String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\hat{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\cdot (2K_2^*)^{n}\cdot\hat{Z}_\mu^{(-)} & (n\text{ 奇数}) \\
(2K_2^*)^{n}\cdot\hat{Y}_\mu & (n\text{ 偶数})
\end{cases}
&&(\because\ n = 0\ \text{の項を分け、}\ n \geq 1\ \text{の各項へ「cosh, sinh の展開係数への変換」の (h2.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\hat{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,(2K_2^*)^{n}\,\hat{Z}_\mu^{(-)}\right)
&&(\because\ (2K_2^*)^{0}\hat{Y}_\mu = \tfrac{1}{0!}\hat{Y}_\mu\ \text{なので}\ n = 0\ \text{の項を偶数側の和へ吸収した}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Y}_\mu
   + i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\hat{Z}_\mu^{(-)}
&&(\because\ \hat{Y}_\mu,\ \hat{Z}_\mu^{(-)},\ i\ \text{が}\ n\ \text{に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\hat{Y}_\mu + i\sinh(2K_2^*)\hat{Z}_\mu^{(-)}
&&(\because\ \text{「sinh, cosh のテイラー展開」}) \\
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
&&(\because\ \text{和の可換性で 2 項を並べ替えた})
\end{aligned}`),
      paragraph(["鎖の終点は主張の (h2.y) の右辺と字句どおり一致する。以上 4 式がいずれも statement の右辺と一致するので、主張が成り立つ。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_definition_pauli_group",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { text: "パウリ行列群" },
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_definition_pauli_group。labels: def_pauli_group。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M \in \mathbb{Z}_{\geq 1}`), " とし、", math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`), " と書く。", ref("pauli_matrix_products"), " の Pauli 行列 ", math(String.raw`\sigma^x, \sigma^y, \sigma^z`), " と単位行列 ", math(String.raw`\sigma^0 := I_{\mathrm{Mat}(2,\mathbb{C})}`), " を用い、", math(String.raw`\mathbb{A} := \{0, x, y, z\}`), " とおく。"]),
      paragraph([math(String.raw`M`), " 因子のパウリ行列群を"]),
      displayMath(String.raw`\mathcal{P}_M := \left\{\,i^{k}\,\sigma^{a_1}\boxtimes\sigma^{a_2}\boxtimes\cdots\boxtimes\sigma^{a_M}
\ \middle|\ k \in \{0,1,2,3\},\ (a_1,\dots,a_M) \in \mathbb{A}^M \right\} \subseteq R`),
      paragraph(["と定める。", math(String.raw`\mathcal{P}_M`), " は行列の積について群をなす（", ref("pauli_matrix_products"), " より各 ", math(String.raw`\sigma^a\sigma^b`), " は ", math(String.raw`i^k\sigma^c`), " の形になり、クロネッカー積どうしの積は各因子ごとの ", math(String.raw`2`), " 次の行列の積になる：", ref("kronecker_product_rule"), " (1)。スカラー倍を外へ出すのは ", ref("kronecker_multilinear"), "）。", math(String.raw`\#\mathcal{P}_M = 4\cdot 4^M`), " であり、とくに有限群である。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_010_definition_clifford_group",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { text: "クリフォード行列群" },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/009_definition_TODO_クリフォード群.typ", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_010_definition_clifford_group。labels: def_clifford_group。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M \in \mathbb{Z}_{\geq 1}`), " とし、", math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`), " と書く。", "〔def_pauli_group〕", " のパウリ行列群を ", math(String.raw`\mathcal{P}_M`), " とする。"]),
      paragraph(["クリフォード群を、", math(String.raw`R`), " の可逆元全体（", ref("def_invertible_elements_of_R"), "）", math(String.raw`R^\times`), " の中で ", math(String.raw`\mathcal{P}_M`), " を保つ元全体、すなわち ", math(String.raw`\mathcal{P}_M`), " の ", math(String.raw`R^\times`), " における正規化群として"]),
      displayMath(String.raw`\mathcal{C}_M := \left\{\, g \in R^\times \ \middle|\ g\,\mathcal{P}_M\,g^{-1} = \mathcal{P}_M \right\}`),
      paragraph(["と定める。", math(String.raw`\mathcal{C}_M`), " は ", math(String.raw`R^\times`), " の部分群である。単位元については ", math(String.raw`I\,\mathcal{P}_M\,I^{-1} = \mathcal{P}_M`), " なので ", math(String.raw`I \in \mathcal{C}_M`), "。積については、", math(String.raw`g_1, g_2 \in \mathcal{C}_M`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
(g_1g_2)\,\mathcal{P}_M\,(g_1g_2)^{-1}
&= g_1\left(g_2\,\mathcal{P}_M\,g_2^{-1}\right)g_1^{-1}
&&(\because\ (g_1g_2)^{-1} = g_2^{-1}g_1^{-1}\ \text{と行列の積の結合則})\\
&= g_1\,\mathcal{P}_M\,g_1^{-1}
&&(\because\ g_2 \in \mathcal{C}_M)\\
&= \mathcal{P}_M
&&(\because\ g_1 \in \mathcal{C}_M)
\end{aligned}`),
      paragraph(["なので ", math(String.raw`g_1g_2 \in \mathcal{C}_M`), "。逆元については、", math(String.raw`g\mathcal{P}_Mg^{-1} = \mathcal{P}_M`), " の両辺を左から ", math(String.raw`g^{-1}`), "、右から ", math(String.raw`g`), " で挟んで ", math(String.raw`g^{-1}\mathcal{P}_Mg = \mathcal{P}_M`), " なので ", math(String.raw`g^{-1} \in \mathcal{C}_M`), " である。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { tex: String.raw`V_2 \notin \mathcal{C}_M` },
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_010a_claim_V2_not_in_clifford_group。labels: V2_not_in_clifford_group。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_transfer_matrix_symbols"), " の ", math(String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(K_2^*\sum_{k=1}^{M}\sigma_k^x\right)`), " は ", "〔def_clifford_group〕", " のクリフォード群 ", math(String.raw`\mathcal{C}_M`), " に属さない。"]),
      paragraph(["したがって ", ref("def_T_g"), " の ", math(String.raw`T_g`), " の定義域をクリフォード群に限定すると、本証明で必要な ", math(String.raw`T_{V_2}`), " およびその合成 ", math(String.raw`T_{(V)}`), " が定義できなくなる。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: ", math(String.raw`\{\sigma^0, \sigma^x, \sigma^y, \sigma^z\}`), " が ", math(String.raw`\mathrm{Mat}(2,\mathbb{C})`), " の基底であること。", math(String.raw`a, b, c, d \in \mathbb{C}`), " について"]),
      displayMath(String.raw`a\sigma^0 + b\sigma^x + c\sigma^y + d\sigma^z
= \begin{pmatrix} a + d & b - ic \\ b + ic & a - d \end{pmatrix}`),
      paragraph(["が零行列なら、", math(String.raw`a+d = 0,\ a-d = 0`), " より ", math(String.raw`a = d = 0`), "、", math(String.raw`b - ic = 0,\ b + ic = 0`), " より辺々加えて ", math(String.raw`2b = 0`), " すなわち ", math(String.raw`b = 0`), "、したがって ", math(String.raw`c = 0`), "。よって 4 元は線型独立であり、", math(String.raw`\dim_\mathbb{C}\mathrm{Mat}(2,\mathbb{C}) = 4`), " なので基底である。", ref("tensor_basis"), " より ", math(String.raw`\{\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_M} \mid (a_1,\dots,a_M)\in\mathbb{A}^M\}`), " は ", math(String.raw`R`), " の基底である。"]),
      paragraph(["Step 2: ", math(String.raw`t \in \mathbb{C}`), " について ", math(String.raw`\exp(t\sigma^x) = \cosh(t)\sigma^0 + \sinh(t)\sigma^x`), "。", math(String.raw`(\sigma^x)^2 = \sigma^0`), "（", ref("pauli_matrix_products"), "）より ", math(String.raw`(\sigma^x)^n = \sigma^0`), "（", math(String.raw`n`), " 偶数）、", math(String.raw`(\sigma^x)^n = \sigma^x`), "（", math(String.raw`n`), " 奇数）であるから、", ref("def_exp"), " の級数を偶数項・奇数項に分けて"]),
      displayMath(String.raw`\exp(t\sigma^x)
= \sum_{n=0}^{\infty}\frac{t^n}{n!}(\sigma^x)^n
= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{t^n}{n!}\right)\sigma^0
+ \left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{t^n}{n!}\right)\sigma^x
= \cosh(t)\sigma^0 + \sinh(t)\sigma^x`),
      paragraph(["（級数の絶対収束は ", ref("matrix_exp_series_converges"), " による。偶奇の分割と ", math(String.raw`\cosh, \sinh`), " の級数は ", ref("real_exp_series_converges"), " の実指数級数の並べ替えである。）"]),
      paragraph(["Step 3: ", math(String.raw`\sigma_1^z := \sigma^z\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0 \in \mathcal{P}_M`), " の ", math(String.raw`V_2`), " による共役を計算する。", math(String.raw`k \neq l`), " のとき ", math(String.raw`\sigma_k^x`), " と ", math(String.raw`\sigma_l^x`), " はクロネッカー積の異なるサイトにのみ ", math(String.raw`\sigma^x`), " を置き（他のサイトは ", math(String.raw`\sigma^0 = I_{\mathrm{Mat}(2,\mathbb{C})}`), "）、", ref("kronecker_product_rule"), " (1) より積は各サイトごとの ", math(String.raw`2`), " 次の行列の積になるから可換であり、", ref("theorem_exp_product"), " より"]),
      displayMath(String.raw`\exp\!\left(K_2^*\sum_{k=1}^{M}\sigma_k^x\right)
= \prod_{k=1}^{M}\exp\!\left(K_2^*\sigma_k^x\right)`),
      paragraph(["また ", math(String.raw`k \neq 1`), " のとき ", math(String.raw`\exp(K_2^*\sigma_k^x)`), " は第 1 因子に ", math(String.raw`\sigma^0`), " をもつので ", math(String.raw`\sigma_1^z`), " と可換であり、共役の中で相殺する。スカラー ", math(String.raw`(2s_2)^{M/2}`), " も ", ref("scalar_identity_commutes"), " により相殺する。よって"]),
      displayMath(String.raw`V_2\,\sigma_1^z\,V_2^{-1}
= \exp\!\left(K_2^*\sigma_1^x\right)\sigma_1^z\exp\!\left(-K_2^*\sigma_1^x\right)
= \left(\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)\right)\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0`),
      paragraph(["Step 4: 第 1 因子を計算する。", ref("pauli_matrix_products"), " の ", math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`), " を ", math(String.raw`n`), " 回使うと ", math(String.raw`\sigma^z(\sigma^x)^n = (-\sigma^x)^n\sigma^z`), "、すなわち ", math(String.raw`(\sigma^x)^n\sigma^z = \sigma^z(-\sigma^x)^n`), " なので、級数の各項ごとに"]),
      displayMath(String.raw`\exp\!\left(K_2^*\sigma^x\right)\sigma^z
= \sum_{n=0}^{\infty}\frac{(K_2^*)^n}{n!}(\sigma^x)^n\sigma^z
= \sigma^z\sum_{n=0}^{\infty}\frac{(-K_2^*)^n}{n!}(\sigma^x)^n
= \sigma^z\exp\!\left(-K_2^*\sigma^x\right)`),
      paragraph(["また、", math(String.raw`c_2^* = \cosh 2K_2^*,\ s_2^* = \sinh 2K_2^*`), "（", ref("def_transfer_matrix_symbols"), "）と、成分計算（", ref("mat_mult"), "）による"]),
      displayMath(String.raw`\sigma^z\sigma^x
= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
= \begin{pmatrix}0&1\\-1&0\end{pmatrix}
= i\begin{pmatrix}0&-i\\i&0\end{pmatrix}
= i\,\sigma^y
\quad (\because \text{行列の積の成分計算とスカラー倍の定義})`),
      paragraph(["を使う。すると"]),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(K_2^*\sigma^x\right)\sigma^z\exp\!\left(-K_2^*\sigma^x\right)
&= \sigma^z\exp\!\left(-K_2^*\sigma^x\right)\exp\!\left(-K_2^*\sigma^x\right)
   \quad (\because \text{直前の式 } \exp(K_2^*\sigma^x)\sigma^z = \sigma^z\exp(-K_2^*\sigma^x)) \\
&= \sigma^z\exp\!\left(-2K_2^*\sigma^x\right)
   \quad (\because \text{可換な行列の exp 積公式}) \\
&= \sigma^z\left(\cosh(2K_2^*)\sigma^0 - \sinh(2K_2^*)\sigma^x\right)
   \quad (\because \text{Step 2},\ \cosh(-t)=\cosh t,\ \sinh(-t)=-\sinh t) \\
&= \cosh(2K_2^*)\,\sigma^z - \sinh(2K_2^*)\,\sigma^z\sigma^x
   \quad (\because \text{行列の積の分配則と}\ \sigma^z\sigma^0 = \sigma^z) \\
&= c_2^*\,\sigma^z - i\,s_2^*\,\sigma^y
   \quad (\because \text{上で計算した}\ \sigma^z\sigma^x = i\,\sigma^y\ \text{と略記}\ c_2^*,\ s_2^*)
\end{aligned}`),
      paragraph(["Step 5: 結論。", math(String.raw`K_2^* > 0`), " より ", math(String.raw`c_2^* > 0`), " かつ ", math(String.raw`s_2^* > 0`), "（", ref("def_transfer_matrix_symbols"), "）なので、Step 3・Step 4 より"]),
      displayMath(String.raw`V_2\,\sigma_1^z\,V_2^{-1}
= c_2^*\left(\sigma^z\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0\right)
- i\,s_2^*\left(\sigma^y\boxtimes\sigma^0\boxtimes\cdots\boxtimes\sigma^0\right)`),
      paragraph(["は Step 1 の基底に関して相異なる 2 つの基底元の係数がともに ", math(String.raw`0`), " でない。一方 ", math(String.raw`\mathcal{P}_M`), " の元 ", math(String.raw`i^k\sigma^{a_1}\boxtimes\cdots\boxtimes\sigma^{a_M}`), " は同じ基底に関して非零の係数をちょうど 1 つしかもたない。基底に関する表示の一意性より ", math(String.raw`V_2\sigma_1^zV_2^{-1} \notin \mathcal{P}_M`), "。したがって ", math(String.raw`V_2\mathcal{P}_MV_2^{-1} \neq \mathcal{P}_M`), " であり ", math(String.raw`V_2 \notin \mathcal{C}_M`), "。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { tex: String.raw`\mathrm{Mat}(2^M,\mathbb{C})^\times \text{ の全元と可換する可逆行列}` },
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 11 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_011a_claim_center_of_invertible_matrices_is_scalar。labels: center_of_multiplicative_group_is_scalar, invertible_matrix_centralizer_is_nonzero_scalar_identity。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`), "、", math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " とし、", math(String.raw`R^\times`), " を ", ref("def_invertible_elements_of_R"), " の可逆行列全体とする。さらに、", math(String.raw`R^\times`), " のすべての元と可換な ", math(String.raw`R^\times`), " の元全体を"]),
      displayMath(String.raw`C(R^\times) := \left\{\, W \in R^\times \;\middle|\; \forall h \in R^\times,\ W h = h W \,\right\}`),
      paragraph(["と書く。このとき"]),
      displayMath(String.raw`C(R^\times) = \{\, cI \mid c \in \mathbb{C}\setminus\{0\} \,\}`),
      paragraph(["である。すなわち、すべての可逆行列と可換する可逆行列は、非零複素数倍の単位行列に限る。"]),
      paragraph(["証明."]),
      paragraph(["まず右辺が左辺に含まれることを示す。", math(String.raw`c \in \mathbb{C}\setminus\{0\}`), " とする。", ref("def_invertible_elements_of_R"), " (iv) より ", math(String.raw`cI \in R^\times`), " であり、", ref("scalar_identity_commutes"), " より ", math(String.raw`cI`), " はすべての ", math(String.raw`h \in R^\times`), " と可換する。したがって ", math(String.raw`cI \in C(R^\times)`), " である。"]),
      paragraph(["次に左辺が右辺に含まれることを示す。", math(String.raw`W \in C(R^\times)`), " とする。", ref("tensor_basis"), " (1) の多重添字を使い、", math(String.raw`P,Q \in \mathcal{I}_M`), " に対応する行列単位を ", math(String.raw`E_{P,Q}`), " と書く。まず、この行列単位の積を確認する。"]),
      paragraph([math(String.raw`P=(p_1,\dots,p_M)`), "、", math(String.raw`Q=(q_1,\dots,q_M)`), "、", math(String.raw`K=(k_1,\dots,k_M)`), "、", math(String.raw`L=(l_1,\dots,l_M)`), " とする。また、", math(String.raw`q,k\in\{1,2\}`), " に対して ", math(String.raw`\delta_{qk}`), " を次のように定める。"]),
      displayMath(String.raw`\delta_{qk}:=
\begin{cases}
  1 & (q=k),\\
  0 & (q\neq k).
\end{cases}`),
      paragraph([ref("kronecker_product_rule"), " (1) と ", ref("kronecker_multilinear"), " を使うと、"]),
      displayMath(String.raw`\begin{aligned}
E_{P,Q}E_{K,L}
&= (E_{p_1q_1}E_{k_1l_1})\boxtimes\cdots\boxtimes(E_{p_Mq_M}E_{k_Ml_M})
&&\left(\because\ \text{クロネッカー積の積の規則}\right)\\
&= (\delta_{q_1k_1}E_{p_1l_1})\boxtimes\cdots\boxtimes(\delta_{q_Mk_M}E_{p_Ml_M})
&&\left(\because\ E_{pq}E_{kl}=\delta_{qk}E_{pl}\ \text{という }2\text{ 次行列の成分計算}\right)\\
&= \left(\prod_{r=1}^{M}\delta_{q_rk_r}\right)E_{P,L}
&&\left(\because\ \text{各因子についての複素スカラー倍の線型性}\right).
\end{aligned}`),
      paragraph([math(String.raw`\delta_{Q,K}:=\prod_{r=1}^{M}\delta_{q_rk_r}`), " と書けば、", math(String.raw`E_{P,Q}E_{K,L}=\delta_{Q,K}E_{P,L}`), " である。特に ", math(String.raw`E:=E_{P,Q}`), " とおくと、", math(String.raw`P\neq Q`), " なら ", math(String.raw`E^2=O`), "、", math(String.raw`P=Q`), " なら ", math(String.raw`E^2=E`), " である。"]),
      paragraph([math(String.raw`P\neq Q`), " の場合は ", math(String.raw`I+E`), " の逆行列が ", math(String.raw`I-E`), " である。実際、"]),
      displayMath(String.raw`\begin{aligned}
(I+E)(I-E)
&= I-E+E-E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I&&\left(\because\ E^2=O\right),\\
(I-E)(I+E)
&= I+E-E-E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I&&\left(\because\ E^2=O\right).
\end{aligned}`),
      paragraph([math(String.raw`P=Q`), " の場合は ", math(String.raw`I-2E`), " が自分自身を逆行列にもつ。実際、"]),
      displayMath(String.raw`\begin{aligned}
(I-2E)(I-2E)
&= I-2E-2E+4E^2&&\left(\because\ \text{行列積の分配律}\right)\\
&= I-4E+4E&&\left(\because\ E^2=E\right)\\
&= I&&\left(\because\ \text{同じ行列の差は零行列}\right).
\end{aligned}`),
      paragraph(["よって ", math(String.raw`P\neq Q`), " なら ", math(String.raw`U_{P,Q}:=I+E_{P,Q}`), "、", math(String.raw`P=Q`), " なら ", math(String.raw`U_{P,P}:=I-2E_{P,P}`), " とおけば、どちらも ", ref("def_invertible_elements_of_R"), " の定義により ", math(String.raw`R^\times`), " に属する。"]),
      paragraph([math(String.raw`P\neq Q`), " なら、", math(String.raw`WU_{P,Q}=U_{P,Q}W`), " を分配して両辺から ", math(String.raw`W`), " を引くと"]),
      displayMath(String.raw`\begin{aligned}
W+WE_{P,Q}
&= WU_{P,Q}&&\left(\because\ U_{P,Q}=I+E_{P,Q}\right)\\
&= U_{P,Q}W&&\left(\because\ W\in C(R^\times),\ U_{P,Q}\in R^\times\right)\\
&= W+E_{P,Q}W&&\left(\because\ U_{P,Q}=I+E_{P,Q}\right),
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`WE_{P,Q}=E_{P,Q}W`), " である。", math(String.raw`P=Q`), " なら同様に ", math(String.raw`WU_{P,P}=U_{P,P}W`), " から"]),
      displayMath(String.raw`\begin{aligned}
W-2WE_{P,P}
&= WU_{P,P}&&\left(\because\ U_{P,P}=I-2E_{P,P}\right)\\
&= U_{P,P}W&&\left(\because\ W\in C(R^\times),\ U_{P,P}\in R^\times\right)\\
&= W-2E_{P,P}W&&\left(\because\ U_{P,P}=I-2E_{P,P}\right),
\end{aligned}`),
      paragraph(["を得る。両辺から ", math(String.raw`W`), " を引き、非零複素数 ", math(String.raw`-2`), " を消去すると ", math(String.raw`WE_{P,P}=E_{P,P}W`), " である。ゆえにすべての ", math(String.raw`P,Q\in\mathcal I_M`), " について ", math(String.raw`WE_{P,Q}=E_{P,Q}W`), " が成り立つ。"]),
      paragraph([ref("tensor_basis"), " (1) より、任意の ", math(String.raw`x\in R`), " は一意に ", math(String.raw`x=\sum_{P,Q\in\mathcal I_M}x_{P,Q}E_{P,Q}`), "（", math(String.raw`x_{P,Q}\in\mathbb C`), "）と書ける。したがって"]),
      displayMath(String.raw`\begin{aligned}
Wx
&= \sum_{P,Q}x_{P,Q}\,WE_{P,Q}
&&\left(\because\ x\ \text{の基底展開と行列積の分配律}\right)\\
&= \sum_{P,Q}x_{P,Q}\,E_{P,Q}W
&&\left(\because\ WE_{P,Q}=E_{P,Q}W\right)\\
&= xW
&&\left(\because\ x\ \text{の基底展開と行列積の分配律}\right).
\end{aligned}`),
      paragraph([math(String.raw`x\in R`), " は任意だったので、", ref("centralizer_is_scalar"), " より、ある ", math(String.raw`c\in\mathbb C`), " が存在して ", math(String.raw`W=cI`), " である。もし ", math(String.raw`c=0`), " なら、どの行列 ", math(String.raw`B`), " に対しても ", math(String.raw`WB=OB=O\neq I`), " となり ", math(String.raw`W`), " は可逆でない。ところが ", math(String.raw`W\in R^\times`), " なので ", math(String.raw`c\neq0`), " である。以上より ", math(String.raw`W\in\{cI\mid c\in\mathbb C\setminus\{0\}\}`), " を得た。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_011a_claim_injectivity_of_T",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { tex: String.raw`T \text{ の（定数倍を除いた）単射性}` },
    origin: { path: "structured-latex/content/008_TV1_hatZ_hatY_part1.ts", ordinal: 11 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_011a_claim_injectivity_of_T。labels: injectivity_of_T_up_to_scalar。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`R := \mathrm{Mat}(2^M,\mathbb{C})`), "、", math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " とし、", math(String.raw`R^\times`), " を ", ref("def_invertible_elements_of_R"), " の可逆行列全体とする。これは ", ref("def_T_g"), " で共役写像を定める行列 ", math(String.raw`g`), " の許容範囲であり、各 ", math(String.raw`T_g`), " 自身の定義域は ", math(String.raw`R`), " である。このとき、"]),
      paragraph([math(String.raw`g,g'\in R^\times`), " について"]),
      displayMath(String.raw`T_g=T_{g'}\iff \exists c\in\mathbb C\setminus\{0\},\quad g'=c\,g`),
      paragraph(["が成り立つ。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: ", math(String.raw`u:=g^{-1}g'`), " とおくと、", math(String.raw`u\in R^\times`), " かつ ", math(String.raw`gu=g'`), " である。"]),
      paragraph([ref("def_invertible_elements_of_R"), " (iii) より ", math(String.raw`g^{-1}\in R^\times`), " であり、同 (ii) より ", math(String.raw`u=g^{-1}g'\in R^\times`), " である。また、"]),
      displayMath(String.raw`\begin{aligned}
gu
&=g\left(g^{-1}g'\right)
&&\left(\because\ u=g^{-1}g'\right)\\
&=\left(gg^{-1}\right)g'
&&\left(\because\ \text{行列積の結合律}\right)\\
&=Ig'
&&\left(\because\ gg^{-1}=I\right)\\
&=g'
&&\left(\because\ I\ \text{は積の単位元}\right).
\end{aligned}`),
      paragraph(["Step 2: 任意の ", math(String.raw`h\in R`), " について、", math(String.raw`T_g(h)=T_{g'}(h)`), " と ", math(String.raw`hu=uh`), " は同値である。"]),
      paragraph([math(String.raw`h\in R`), " を固定する。", ref("def_T_g"), " と、可逆行列を左または右から掛ける操作が逆行列によって戻せることから、"]),
      displayMath(String.raw`\begin{aligned}
T_g(h)=T_{g'}(h)
&\iff ghg^{-1}=g'hg'^{-1}
&&\left(\because\ T_g,T_{g'}\ \text{の定め方}\right)\\
&\iff g^{-1}\left(ghg^{-1}\right)=g^{-1}\left(g'hg'^{-1}\right)
&&\left(\because\ \text{両辺に左から可逆行列 }g^{-1}\text{ を掛ける同値変形}\right)\\
&\iff \left(g^{-1}g\right)hg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ \text{行列積の結合律}\right)\\
&\iff Ihg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ g^{-1}g=I\right)\\
&\iff hg^{-1}=\left(g^{-1}g'\right)hg'^{-1}
&&\left(\because\ I\ \text{は積の単位元}\right)\\
&\iff \left(hg^{-1}\right)g'=\left(\left(g^{-1}g'\right)hg'^{-1}\right)g'
&&\left(\because\ \text{両辺に右から可逆行列 }g'\text{ を掛ける同値変形}\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)h\left(g'^{-1}g'\right)
&&\left(\because\ \text{行列積の結合律}\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)hI
&&\left(\because\ g'^{-1}g'=I\right)\\
&\iff h\left(g^{-1}g'\right)=\left(g^{-1}g'\right)h
&&\left(\because\ I\ \text{は積の単位元}\right)\\
&\iff hu=uh
&&\left(\because\ u=g^{-1}g'\right).
\end{aligned}`),
      paragraph(["Step 3: ", math(String.raw`T_g=T_{g'}`), " ならば、ある ", math(String.raw`c\in\mathbb C\setminus\{0\}`), " が存在して ", math(String.raw`g'=cg`), " である。"]),
      paragraph([math(String.raw`T_g=T_{g'}`), " とする。すべての ", math(String.raw`h\in R^\times`), " について ", math(String.raw`T_g(h)=T_{g'}(h)`), " なので、Step 2 より ", math(String.raw`uh=hu`), " である。Step 1 の ", math(String.raw`u\in R^\times`), " と合わせると、", "〔invertible_matrix_centralizer_is_nonzero_scalar_identity〕", " より、ある ", math(String.raw`c\in\mathbb C\setminus\{0\}`), " が存在して ", math(String.raw`u=cI`), " である。したがって、"]),
      displayMath(String.raw`\begin{aligned}
g'
&=gu
&&\left(\because\ \text{Step 1}\right)\\
&=g(cI)
&&\left(\because\ u=cI\right)\\
&=c(gI)
&&\left(\because\ \text{複素スカラー倍と行列積の結合律}\right)\\
&=cg
&&\left(\because\ gI=g\right).
\end{aligned}`),
      paragraph(["Step 4: ある ", math(String.raw`c\in\mathbb C\setminus\{0\}`), " について ", math(String.raw`g'=cg`), " ならば、", math(String.raw`T_g=T_{g'}`), " である。"]),
      paragraph([math(String.raw`g'=cg`), " とする。すると"]),
      displayMath(String.raw`\begin{aligned}
u
&=g^{-1}g'
&&\left(\because\ u=g^{-1}g'\right)\\
&=g^{-1}(cg)
&&\left(\because\ g'=cg\right)\\
&=c\left(g^{-1}g\right)
&&\left(\because\ \text{複素スカラー倍と行列積の結合律}\right)\\
&=cI
&&\left(\because\ g^{-1}g=I\right).
\end{aligned}`),
      paragraph(["任意の ", math(String.raw`h\in R`), " に対し、"]),
      displayMath(String.raw`\begin{aligned}
uh
&=(cI)h
&&\left(\because\ u=cI\right)\\
&=h(cI)
&&\left(\because\ \blkref{scalar_identity_commutes}\right)\\
&=hu
&&\left(\because\ u=cI\right)
\end{aligned}`),
      paragraph(["である（", ref("scalar_identity_commutes"), "）。Step 2 の逆向きにより ", math(String.raw`T_g(h)=T_{g'}(h)`), " であり、", math(String.raw`h\in R`), " は任意なので ", math(String.raw`T_g=T_{g'}`), " を得る。Step 3 と Step 4 を合わせて主張が成り立つ。"]),
    ],
  },
  {
    id: "note_evensectorT_005_claim_T_actions_integer_route_TV1_hatZ_hatY_012_claim_TV1_TV2_actions",
    targets: ["T_actions_on_check_Z_Y"],
    title: { text: "ホロノミック量子場 p142 下段" },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/011_claim_ホロノミック量子場_p142下段.typ", ordinal: 12 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_012_claim_TV1_TV2_actions。labels: ホロノミック量子場_p142下段_1。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i \exp(-i 2\pi\mu/M)\sinh(K_1)\hat{Y}_\mu \\
T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
&= -i \exp(i 2\pi\mu/M)\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu \\
T_{V_2}(\hat{Z}_\mu^{(-)})
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu \\
T_{V_2}(\hat{Y}_\mu)
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
\end{aligned}`),
      paragraph(["証明."]),
      paragraph(["以下、", "〔extract_taylor_coefficient_of_Z_Y〕", " の (h1.z), (h1.y) は ", math(String.raw`\pm`), " の 2 つの符号選択について成り立つが、本主張では ", math(String.raw`\hat{Z}_\mu^{(-)}`), " に作用させるので、いずれも ", math(String.raw`\pm = -`), "（すなわち ", math(String.raw`H_1^{(-)}`), " と ", math(String.raw`\hat{Z}_\mu^{(-)}`), " の組）を選んで適用する。"]),
      paragraph([math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})`), " について、次の変形で ", ref("exp_X_Y_exp_-X"), " と ", "〔extract_taylor_coefficient_of_Z_Y〕", " を用いる。"]),
      displayMath(String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})
&= (V_1^{(\pm)})^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot(V_1^{(\pm)})^{-1/2}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left(\exp(i K_1 H_1^{(\pm)})\right)^{1/2}\cdot\hat{Z}_\mu^{(-)}\cdot\left(\exp(i K_1 H_1^{(\pm)})\right)^{-1/2}
   \quad (\because V_1^{(\pm)}\text{ の指数表示}) \\
&= \exp\!\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\cdot\hat{Z}_\mu^{(-)}\cdot\exp\!\left(-\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\right)
   \quad (\because \text{指数行列の平方根と逆元}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\dots,\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(K_1)\hat{Z}_\mu^{(-)} + i\,\exp(-i\frac{2\pi\mu}{M})\sinh(K_1)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,\exp(-i\frac{2\pi\mu}{M})\sinh(K_1)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`),
      paragraph([math(String.raw`T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)`), " について、作用させる元が ", math(String.raw`\hat{Z}_\mu^{(-)}`), " から ", math(String.raw`\hat{Y}_\mu`), " へ変わるだけで、共役の展開はまったく同じ手順である。"]),
      displayMath(String.raw`\begin{aligned}
T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)
&= (V_1^{(\pm)})^{1/2}\cdot\hat{Y}_\mu\cdot(V_1^{(\pm)})^{-1/2}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left(\exp(i K_1 H_1^{(\pm)})\right)^{1/2}\cdot\hat{Y}_\mu\cdot\left(\exp(i K_1 H_1^{(\pm)})\right)^{-1/2}
   \quad (\because V_1^{(\pm)}\text{ の指数表示}) \\
&= \exp\!\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\cdot\hat{Y}_\mu\cdot\exp\!\left(-\left(\tfrac{1}{2}i K_1 H_1^{(\pm)}\right)\right)
   \quad (\because \text{指数行列の平方根と逆元}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\dots,\left[\tfrac{1}{2}i K_1 H_1^{(\pm)},\hat{Y}_\mu\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= -i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出 (h1.y)}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`),
      paragraph(["最後の等号は、行ベクトルと列ベクトルの積の定義", math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`), " による（", math(String.raw`A, B \in \mathrm{Mat}(2^M,\mathbb{C})`), "、", math(String.raw`a, b \in \mathbb{C}`), "）。"]),
      paragraph([math(String.raw`T_{V_2}(\hat{Z}_\mu^{(-)})`), " について。", ref("V2_exponential_representation"), " の指数表示を用いる。準備として 2 つ置く。第一に、スカラー ", math(String.raw`(2s_2)^{M/2} \in \mathbb{C}^{\times}`), " は ", ref("scalar_identity_commutes"), " により ", math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`), " の任意の元と可換である。第二に、", math(String.raw`(2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1} = 1`), " である（", math(String.raw`\mathbb{C}^{\times}`), " の逆元の定義）。"]),
      displayMath(String.raw`\begin{aligned}
T_{V_2}(\hat{Z}_\mu^{(-)})
&= V_2\cdot\hat{Z}_\mu^{(-)}\cdot V_2^{-1}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)\cdot\hat{Z}_\mu^{(-)}\cdot\left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)^{-1}
   \quad (\because V_2\text{ の指数表示}) \\
&= (2s_2)^{M/2}\cdot\exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラー倍の行列の逆元 }(cA)^{-1}=c^{-1}A^{-1}) \\
&= (2s_2)^{M/2}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーは任意の元と可換（準備の第一）}) \\
&= \exp(i K_2^* H_2)\cdot\hat{Z}_\mu^{(-)}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーとその逆元の積は }1\text{（準備の第二）}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Z}_\mu^{(-)}\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= \cosh(2K_2^*)\hat{Z}_\mu^{(-)} - i\sinh(2K_2^*)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`),
      paragraph([math(String.raw`T_{V_2}(\hat{Y}_\mu)`), " についても、スカラー ", math(String.raw`(2s_2)^{M/2}`), " が共役で打ち消し合うことは同じで、作用させる元だけが ", math(String.raw`\hat{Y}_\mu`), " に変わる。"]),
      displayMath(String.raw`\begin{aligned}
T_{V_2}(\hat{Y}_\mu)
&= V_2\cdot\hat{Y}_\mu\cdot V_2^{-1}
   \quad (\because \text{共役写像 }T\text{ の定義}) \\
&= \left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)\cdot\hat{Y}_\mu\cdot\left((2s_2)^{M/2}\exp(i K_2^* H_2)\right)^{-1}
   \quad (\because V_2\text{ の指数表示}) \\
&= (2s_2)^{M/2}\cdot\exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラー倍の行列の逆元 }(cA)^{-1}=c^{-1}A^{-1}) \\
&= (2s_2)^{M/2}\cdot\left((2s_2)^{M/2}\right)^{-1}\cdot\exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーは任意の元と可換（準備の第一）}) \\
&= \exp(i K_2^* H_2)\cdot\hat{Y}_\mu\cdot\exp(i K_2^* H_2)^{-1}
   \quad (\because \text{スカラーとその逆元の積は }1\text{（準備の第二）}) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\hat{Y}_\mu\right]\dots\right]}_{n\text{ times}}
   \quad (\because \text{exp 共役の級数展開}) \\
&= i\sinh(2K_2^*)\hat{Z}_\mu^{(-)} + \cosh(2K_2^*)\hat{Y}_\mu
   \quad (\because \text{テイラー係数の抽出 (h2.y)}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \quad (\because \text{行ベクトルと列ベクトルの積の定義})
\end{aligned}`),
      paragraph(["以上 4 式が statement と一致する。"]),
    ],
  },
  {
    id: "note_evensectorT_008_claim_product_action_integer_route_TV1_hatZ_hatY_013_definition_product_maps",
    targets: ["calc_of_TxT_check_Z_Y"],
    title: null,
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/012_definition_T_V1_T_V2の直積写像.typ", ordinal: 13 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_013_definition_product_maps。labels: なし。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(X, Y) := \left(T_{(V_1^{(\pm)})^{1/2}}(X),\; T_{(V_1^{(\pm)})^{1/2}}(Y)\right)`),
      displayMath(String.raw`\left(T_{V_2} \times T_{V_2}\right)(X, Y) := \left(T_{V_2}(X),\; T_{V_2}(Y)\right)`),
    ],
  },
  {
    id: "note_evensectorT_008_claim_product_action_integer_route_TV1_hatZ_hatY_014_claim_product_action_computation",
    targets: ["calc_of_TxT_check_Z_Y"],
    title: null,
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/013_claim_T_V1_T_V2のhatZ_hatYへの直積作用の計算.typ", ordinal: 14 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_014_claim_product_action_computation。labels: calc_of_TxT_hatZxhatY。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh K_1 & -i \exp(i\theta_\mu)\sinh K_1 \\
i \exp(-i\theta_\mu)\sinh K_1 & \cosh K_1
\end{pmatrix}`),
      displayMath(String.raw`\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
= \begin{pmatrix}\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\end{pmatrix}
\begin{pmatrix}
\cosh 2K_2^* & i\sinh 2K_2^* \\
-i\sinh 2K_2^* & \cosh 2K_2^*
\end{pmatrix}`),
      paragraph(["ただし ", math(String.raw`\theta_\mu := 2\pi\mu/M`), "。"]),
      paragraph(["証明."]),
      paragraph(["直積写像の定義より各成分に分解し、", "〔ホロノミック量子場_p142下段_1〕", " の行列表示を代入して 2 列を並べる。"]),
      displayMath(String.raw`\begin{aligned}
\left(T_{(V_1^{(\pm)})^{1/2}} \times T_{(V_1^{(\pm)})^{1/2}}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right)
   \quad (\because \text{直積写像の定義}) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i\,\exp(-i\frac{2\pi\mu}{M})\sinh(K_1)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \right)
   \quad (\because \text{二つの共役作用の行列表示}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(K_1) & -i\,\exp(i\frac{2\pi\mu}{M})\sinh(K_1) \\
   i\,\exp(-i\frac{2\pi\mu}{M})\sinh(K_1) & \cosh(K_1)
   \end{pmatrix}
   \quad (\because \text{二つの列ベクトルを一つの行列の二列として並べる})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\left(T_{V_2} \times T_{V_2}\right)(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)
&= \left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \quad (\because \text{直積写像の定義}) \\
&= \left(
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix},\ \
   \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \right)
   \quad (\because \text{二つの共役作用の行列表示}) \\
&= \begin{pmatrix}\hat{Z}_\mu^{(-)}, & \hat{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(2K_2^*) & i\sinh(2K_2^*) \\
   -i\sinh(2K_2^*) & \cosh(2K_2^*)
   \end{pmatrix}
   \quad (\because \text{二つの列ベクトルを一つの行列の二列として並べる})
\end{aligned}`),
      paragraph(["ただし ", math(String.raw`\theta_\mu := 2\pi\mu/M`), " と書けば上記の ", math(String.raw`\exp(\pm i\frac{2\pi\mu}{M}) = \exp(\pm i\theta_\mu)`), " であり statement の形になる。"]),
    ],
  },
  {
    id: "note_evensectorT_definition_T_V_plus_integer_route_TV1_hatZ_hatY_016_definition_T_V",
    targets: ["def_T_V_plus"],
    title: { tex: String.raw`T_{(V)} \text{ の定義}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/015_definition_T_V.typ", ordinal: 16 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_016_definition_T_V。labels: def_T_V。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\forall X \in \mathrm{Mat}(2^M,\mathbb{C})`), " について、"]),
      displayMath(String.raw`T_{(V)}(X) := T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)`),
    ],
  },
  {
    id: "note_evensectorT_010_claim_T_V_plus_action_integer_route_TV1_hatZ_hatY_018_claim_T_V_action",
    targets: ["T_V_plus_check_Z_Y"],
    title: { tex: String.raw`T_{(V)} \text{ の } \hat{Z}, \hat{Y} \text{ への作用}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/017_claim_T_VのhatZ_hatYへの作用.typ", ordinal: 18 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_018_claim_T_V_action。labels: T_V_hatZ_hatY。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\; T_{(V)}(\hat{Y}_\mu)\right)
= \left(\hat{Z}_\mu^{(-)},\; \hat{Y}_\mu\right) A\!\left(\frac{2\pi\mu}{M}\right)`),
      paragraph(["証明."]),
      paragraph(["以下 ", math(String.raw`\theta_\mu := 2\pi\mu/M`), " とし、次の 2 行列を用いる（それぞれ ", "〔calc_of_TxT_hatZxhatY〕", " の ", math(String.raw`V_1, V_2`), " 分に対応）："]),
      displayMath(String.raw`B_1(\theta_\mu) := \begin{pmatrix}
\cosh(K_1) & -i \exp(i\theta_\mu)\sinh(K_1) \\
i \exp(-i\theta_\mu)\sinh(K_1) & \cosh(K_1)
\end{pmatrix}, \qquad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`),
      paragraph(["(z) ", math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)})`), " について、", math(String.raw`T`), " の線型性（", ref("linearity_of_T"), "）、", "〔calc_of_TxT_hatZxhatY〕", "、", "〔ホロノミック量子場_p142下段_1〕", " を用いる。"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\hat{Z}_\mu^{(-)})
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)})\right)\right)
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2}\ \text{と共役作用の合成則}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(\cosh(K_1)\hat{Z}_\mu^{(-)} + i \exp(-i\theta_\mu)\sinh(K_1)\hat{Y}_\mu\right)\right)
   \quad (\because \text{直積作用の計算}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\theta_\mu)\sinh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\theta_\mu)\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= \left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Z}_\mu^{(-)}),\ T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right) B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\theta_\mu)\sinh(K_1)\end{pmatrix}
   \quad (\because T\text{ の線型性}) \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i \exp(-i\theta_\mu)\sinh(K_1)\end{pmatrix}
   \quad (\because \text{直積作用の計算})
\end{aligned}`),
      paragraph(["(y) ", math(String.raw`T_{(V)}(\hat{Y}_\mu)`), " について、同様に、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\hat{Y}_\mu)
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(\hat{Y}_\mu)\right)\right)
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2}\ \text{と共役作用の合成則}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(-i \exp(i\theta_\mu)\sinh(K_1)\hat{Z}_\mu^{(-)} + \cosh(K_1)\hat{Y}_\mu\right)\right)
   \quad (\because \text{直積作用の計算}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(\left(T_{V_2}(\hat{Z}_\mu^{(-)}),\ T_{V_2}(\hat{Y}_\mu)\right)
   \begin{pmatrix}-i \exp(i\theta_\mu)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because T\text{ の線型性}) \\
&= T_{(V_1^{(\pm)})^{1/2}}\!\left((\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_2
   \begin{pmatrix}-i \exp(i\theta_\mu)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \text{直積作用の計算}) \\
&= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2
   \begin{pmatrix}-i \exp(i\theta_\mu)\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because T\text{ の線型性と直積作用の計算})
\end{aligned}`),
      paragraph(["よって、上記 2 列を並べると（2 つの列ベクトルはちょうど ", math(String.raw`B_1(\theta_\mu)`), " の 2 列）、"]),
      displayMath(String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu)
\quad (\because \text{直前の二列を並べ、}B_1(\theta_\mu)\text{ の二列の定義を用いた})`),
      paragraph(["最後に ", math(String.raw`B_1(\theta_\mu)\, B_2\, B_1(\theta_\mu) = A(\theta_\mu)`), "（", ref("def_A_theta"), "）を具体的な行列積で確かめる。以下、記号を"]),
      displayMath(String.raw`a := \cosh K_1 \in \mathbb{R},\quad b := \sinh K_1 \in \mathbb{R},\quad
C := \cosh 2K_2^* = c_2^* \in \mathbb{R},\quad S := \sinh 2K_2^* = s_2^* \in \mathbb{R},\quad
\theta := \theta_\mu \in \mathbb{R}`),
      paragraph(["と略記する（", math(String.raw`c_2^*, s_2^*`), " は ", ref("def_transfer_matrix_symbols"), " の記号）。倍角公式"]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2 &= \cosh^2 K_1 + \sinh^2 K_1
        &&(\because a = \cosh K_1,\ b = \sinh K_1\ \text{の略記}) \\
&= \cosh 2K_1
        &&(\because \text{双曲線関数の倍角公式}) \\
&= c_1
        &&(\because c_1 = \cosh 2K_1\ \text{の定義}) \\
2ab &= 2\sinh K_1 \cosh K_1
        &&(\because a = \cosh K_1,\ b = \sinh K_1\ \text{の略記}) \\
&= \sinh 2K_1
        &&(\because \text{双曲線関数の倍角公式}) \\
&= s_1
        &&(\because s_1 = \sinh 2K_1\ \text{の定義}) \\
a^2 - b^2 &= \cosh^2 K_1 - \sinh^2 K_1
        &&(\because a = \cosh K_1,\ b = \sinh K_1\ \text{の略記}) \\
&= 1
        &&(\because \cosh^2 K_1 - \sinh^2 K_1 = 1)
\end{aligned}`),
      paragraph(["を後で用いる。この記号で ", math(String.raw`B_1(\theta) = \begin{pmatrix} a & -i \exp(i\theta) b \\ i \exp(-i\theta) b & a\end{pmatrix}`), "、", math(String.raw`B_2 = \begin{pmatrix} C & i S \\ -i S & C\end{pmatrix}`), " である。"]),
      paragraph(["Step 1: ", math(String.raw`N := B_2\, B_1(\theta)`), " を成分ごとに計算する（行列の積は ", ref("mat_mult"), "）。"]),
      displayMath(String.raw`\begin{aligned}
N_{11} &= C\cdot a + (iS)\cdot\left(i \exp(-i\theta) b\right)
        &&(\because \text{行列積の定義}) \\
&= Ca + i^2 S b\, \exp(-i\theta)
        &&(\because \text{複素数の積の結合則と可換則}) \\
&= Ca - S b\, \exp(-i\theta)
        &&(\because i^2=-1) \\
N_{12} &= C\cdot\left(-i \exp(i\theta) b\right) + (iS)\cdot a
        &&(\because \text{行列積の定義}) \\
&= i\left(Sa - C b\, \exp(i\theta)\right)
        &&(\because \text{分配則と複素数の積の可換則}) \\
N_{21} &= (-iS)\cdot a + C\cdot\left(i \exp(-i\theta) b\right)
        &&(\because \text{行列積の定義}) \\
&= i\left(C b\, \exp(-i\theta) - Sa\right)
        &&(\because \text{分配則と複素数の積の可換則}) \\
N_{22} &= (-iS)\cdot\left(-i \exp(i\theta) b\right) + C\cdot a
        &&(\because \text{行列積の定義}) \\
&= i^2 S b\, \exp(i\theta) + Ca
        &&(\because (-i)(-i)=i^2\ \text{と複素数の積の結合則}) \\
&= Ca - S b\, \exp(i\theta)
        &&(\because i^2=-1\ \text{と加法の可換則})
\end{aligned}`),
      paragraph(["Step 2: ", math(String.raw`P := B_1(\theta)\, N = B_1(\theta)\, B_2\, B_1(\theta)`), " の (1,1) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{11}
&= a\, N_{11} + \left(-i \exp(i\theta) b\right) N_{21}
   &&(\because \text{行列積の定義}) \\
&= a\left(Ca - S b\, \exp(-i\theta)\right)
   + \left(-i \exp(i\theta) b\right)\cdot i\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because \text{Step 1 の }N_{11},N_{21}\text{ の表示}) \\
&= Ca^2 - S ab\, \exp(-i\theta)
   + \exp(i\theta) b\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because -i\cdot i = 1) \\
&= Ca^2 - S ab\, \exp(-i\theta) + C b^2 - S ab\, \exp(i\theta)
   &&(\because \exp(i\theta)\exp(-i\theta) = 1) \\
&= C\left(a^2 + b^2\right) - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because \text{分配則による括り出し}) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\cdot 2\cos\theta
   &&(\because a^2+b^2 = c_1,\ 2ab = s_1,\ \exp(i\theta)+\exp(-i\theta) = 2\cos\theta) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because C=c_2^*,\ S=s_2^*\ \text{の略記})
\end{aligned}`),
      paragraph(["（", math(String.raw`\exp(i\theta) + \exp(-i\theta) = 2\cos\theta`), " は ", ref("euler_formula_cos_sin"), " による。）これは ", ref("def_A_theta"), " の ", math(String.raw`A(\theta)`), " の (1,1) 成分 ", math(String.raw`c_1 c_2^* - s_1 s_2^*\cos\theta = \gamma_1(\theta)`), " に一致する。"]),
      paragraph(["Step 3: ", math(String.raw`P`), " の (2,2) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{22}
&= \left(i \exp(-i\theta) b\right) N_{12} + a\, N_{22}
   &&(\because \text{行列積の定義}) \\
&= \left(i \exp(-i\theta) b\right)\cdot i\left(Sa - C b\, \exp(i\theta)\right)
   + a\left(Ca - S b\, \exp(i\theta)\right)
   &&(\because \text{Step 1 の }N_{12},N_{22}\text{ の表示}) \\
&= -\exp(-i\theta) b\left(Sa - C b\, \exp(i\theta)\right) + Ca^2 - S ab\, \exp(i\theta)
   &&(\because i\cdot i = -1) \\
&= -S ab\, \exp(-i\theta) + C b^2 + Ca^2 - S ab\, \exp(i\theta)
   &&(\because \text{分配則と }\exp(-i\theta)\exp(i\theta)=1) \\
&= C\left(a^2 + b^2\right) - S ab\left(\exp(i\theta) + \exp(-i\theta)\right)
   &&(\because \text{加法の可換則と分配則による括り出し}) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   &&(\because a^2+b^2=c_1,\ 2ab=s_1,\ \exp(i\theta)+\exp(-i\theta)=2\cos\theta,\ C=c_2^*,\ S=s_2^*)
\end{aligned}`),
      paragraph(["これは ", math(String.raw`A(\theta)`), " の (2,2) 成分 ", math(String.raw`\gamma_1(\theta)`), " に一致する（(1,1) 成分と同一の式）。"]),
      paragraph(["Step 4: ", math(String.raw`P`), " の (1,2) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{12}
&= a\, N_{12} + \left(-i \exp(i\theta) b\right) N_{22}
   &&(\because \text{行列積の定義}) \\
&= a\cdot i\left(Sa - C b\, \exp(i\theta)\right)
   + \left(-i \exp(i\theta) b\right)\left(Ca - S b\, \exp(i\theta)\right)
   &&(\because \text{Step 1 の }N_{12},N_{22}\text{ の表示}) \\
&= i\left[S a^2 - C ab\, \exp(i\theta)\right]
   + i\left[-C ab\, \exp(i\theta) + S b^2 \exp(2i\theta)\right]
   &&(\because \text{分配則と複素数の積の結合則}) \\
&= i\left[S\left(a^2 + b^2 \exp(2i\theta)\right) - 2C ab\, \exp(i\theta)\right]
   &&(\because \text{分配則による括り出し})
\end{aligned}`),
      paragraph(["ここで括弧内の第 1 項を ", math(String.raw`\exp(i\theta)`), " でくくると、"]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2 \exp(2i\theta)
&= \exp(i\theta)\left(a^2 \exp(-i\theta) + b^2 \exp(i\theta)\right)
   &&(\because \exp(i\theta)\exp(-i\theta)=1\ \text{と指数法則}) \\
&= \exp(i\theta)\left(a^2(\cos\theta - i\sin\theta) + b^2(\cos\theta + i\sin\theta)\right)
   &&(\because \text{Euler の公式}) \\
&= \exp(i\theta)\left(\left(a^2 + b^2\right)\cos\theta - i\left(a^2 - b^2\right)\sin\theta\right)
   &&(\because \text{分配則による整理}) \\
&= \exp(i\theta)\left(c_1\cos\theta - i\sin\theta\right)
   &&(\because a^2+b^2 = c_1,\ a^2-b^2 = 1)
\end{aligned}`),
      paragraph(["また ", math(String.raw`2ab = s_1`), " なので、"]),
      displayMath(String.raw`\begin{aligned}
P_{12}
&= i\left[S\, \exp(i\theta)\left(c_1\cos\theta - i\sin\theta\right) - C s_1 \exp(i\theta)\right]
   &&(\because \text{直前の補助計算と }2ab=s_1) \\
&= i \exp(i\theta)\left[S\left(c_1\cos\theta - i\sin\theta\right) - C s_1\right]
   &&(\because \text{分配則による }\exp(i\theta)\text{ の括り出し}) \\
&= i \exp(i\theta)\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - c_2^*\, s_1\right]
   &&(\because S=s_2^*,\ C=c_2^*\ \text{の略記}) \\
&= i \exp(i\theta)\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - s_2^* c_2\, s_1\right]
   &&(\because c_2^* = s_2^* c_2) \\
&= i \exp(i\theta) s_2^*\left(c_1\cos\theta - i\sin\theta - s_1 c_2\right)
   &&(\because \text{分配則による }s_2^*\text{ の括り出し})
\end{aligned}`),
      paragraph(["ここで ", math(String.raw`c_2^* = s_2^* c_2`), " は ", ref("duality_c2_star_eq_s2_star_c2"), " による（この置き換えが、", ref("def_A_theta"), " の ", math(String.raw`\gamma_2`), " で ", math(String.raw`c_2^*`), " ではなく ", math(String.raw`c_2`), " が現れる理由である）。得られた ", math(String.raw`P_{12}`), " は ", math(String.raw`A(\theta)`), " の (1,2) 成分 ", math(String.raw`i \exp(i\theta) s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2) = \gamma_2(\theta)`), " に一致する。"]),
      paragraph(["Step 5: ", math(String.raw`P`), " の (2,1) 成分。"]),
      displayMath(String.raw`\begin{aligned}
P_{21}
&= \left(i \exp(-i\theta) b\right) N_{11} + a\, N_{21}
   &&(\because \text{行列積の定義}) \\
&= \left(i \exp(-i\theta) b\right)\left(Ca - S b\, \exp(-i\theta)\right)
   + a\cdot i\left(C b\, \exp(-i\theta) - Sa\right)
   &&(\because \text{Step 1 の }N_{11},N_{21}\text{ の表示}) \\
&= i\left[C ab\, \exp(-i\theta) - S b^2 \exp(-2i\theta)\right]
   + i\left[C ab\, \exp(-i\theta) - S a^2\right]
   &&(\because \text{分配則と複素数の積の結合則}) \\
&= -i\left[S\left(a^2 + b^2 \exp(-2i\theta)\right) - 2C ab\, \exp(-i\theta)\right]
   &&(\because \text{分配則による括り出し})
\end{aligned}`),
      paragraph(["括弧内は Step 4 の括弧内で ", math(String.raw`\theta`), " を ", math(String.raw`-\theta`), " に置き換えたものに他ならない。よって Step 4 と同じ計算（", math(String.raw`\cos(-\theta) = \cos\theta`), "、", math(String.raw`\sin(-\theta) = -\sin\theta`), " を用いる）により、"]),
      displayMath(String.raw`\begin{aligned}
S\left(a^2 + b^2 \exp(-2i\theta)\right) - 2C ab\, \exp(-i\theta)
&= \exp(-i\theta) s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
   &&(\because \text{Step 4 の補助計算で }\theta\text{ を }-\theta\text{ に置換}) \\
P_{21}
&= -i \exp(-i\theta) s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
   &&(\because \text{直前の等式を }P_{21}\text{ の表示へ代入}) \\
&= -\gamma_2(-\theta)
   &&(\because \gamma_2\text{ の定義と }\cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)
\end{aligned}`),
      paragraph(["実際、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta)
&= i \exp(-i\theta) s_2^*\left(c_1\cos(-\theta) - i\sin(-\theta) - s_1 c_2\right)
&& (\because\ \gamma_2\text{ の定義}) \\
&= i \exp(-i\theta) s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
&& (\because\ \cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)
\end{aligned}`),
      paragraph(["であるから ", math(String.raw`P_{21} = -\gamma_2(-\theta)`), " であり、これは ", ref("def_A_theta"), " の ", math(String.raw`A(\theta)`), " の (2,1) 成分 ", math(String.raw`-i \exp(-i\theta) s_2^*(c_1\cos\theta + i\sin\theta - s_1 c_2)`), " に一致する。"]),
      paragraph(["Step 6: Step 2〜5 により ", math(String.raw`P = B_1(\theta_\mu) B_2 B_1(\theta_\mu)`), " の 4 成分すべてが ", math(String.raw`A(\theta_\mu)`), " の対応成分に一致するので ", math(String.raw`B_1(\theta_\mu) B_2 B_1(\theta_\mu) = A(\theta_\mu)`), "。したがって statement を得る："]),
      displayMath(String.raw`\left(T_{(V)}(\hat{Z}_\mu^{(-)}),\ T_{(V)}(\hat{Y}_\mu)\right)
= (\hat{Z}_\mu^{(-)},\hat{Y}_\mu)\, A(\theta_\mu)
\quad (\because B_1(\theta_\mu)B_2B_1(\theta_\mu)=A(\theta_\mu))`),
    ],
  },
  {
    id: "note_evensectorT_009_claim_factorization_A_theta_integer_route_TV1_hatZ_hatY_037_claim_factorization_A_theta",
    targets: ["factorization_of_A_theta_general"],
    title: { tex: String.raw`A(\theta_\mu) \text{ の行列分解}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/036_claim_A_thetaの行列分解.typ", ordinal: 37 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の主張ブロック TV1_hatZ_hatY_037_claim_factorization_A_theta。labels: factorization_of_A_theta。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`B_1(\theta_\mu)
:= \begin{pmatrix}
\cosh K_1 & -i\exp(i\theta_\mu)\sinh K_1 \\
i\exp(-i\theta_\mu)\sinh K_1 & \cosh K_1
\end{pmatrix},
\quad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`),
      paragraph(["とおくと"]),
      displayMath(String.raw`A(\theta_\mu) = B_1(\theta_\mu) \cdot B_2 \cdot B_1(\theta_\mu)`),
      paragraph(["証明."]),
      paragraph(["〔calc_of_TxT_hatZxhatY〕", " より ", math(String.raw`T_{(V_1^{(\pm)})^{1/2}}`), " は ", math(String.raw`(\hat{Z}_\mu^{(-)}, \hat{Y}_\mu)`), " に右から ", math(String.raw`B_1(\theta_\mu)`), " を掛け、", math(String.raw`T_{(V_2)}`), " は右から ", math(String.raw`B_2`), " を掛ける。", math(String.raw`T_{(V)} = T_{(V_1^{(\pm)})^{1/2}} \circ T_{(V_2)} \circ T_{(V_1^{(\pm)})^{1/2}}`), " と ", ref("def_A_theta"), " の定義から ", math(String.raw`A(\theta_\mu) = B_1(\theta_\mu) B_2 B_1(\theta_\mu)`), "。"]),
    ],
  },
  {
    id: "note_Athetatilde_001_definition_gamma1_gamma2_integer_route_TV1_hatZ_hatY_019_definition_theta_mu",
    targets: ["def_gamma1_gamma2_of_theta"],
    title: { tex: String.raw`\theta_\mu \text{ の定義}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/018_definition_theta_mu.typ", ordinal: 19 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_019_definition_theta_mu。labels: def_theta_mu。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\theta_\mu := \frac{2\pi\mu}{M}`),
    ],
  },
  {
    id: "note_Athetatilde_001_definition_gamma1_gamma2_integer_route_TV1_hatZ_hatY_020_definition_gamma1_gamma2",
    targets: ["def_gamma1_gamma2_of_theta"],
    title: { tex: String.raw`\gamma_1(\theta_\mu), \gamma_2(\theta_\mu) \text{ の定義}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/019_definition_A_thetaの対角化の準備.typ", ordinal: 20 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part1.ts の定義ブロック TV1_hatZ_hatY_020_definition_gamma1_gamma2。labels: なし。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\gamma_1(\theta_\mu) := c_1 c_2^* - s_1 s_2^*\cos\theta_\mu \in \mathbb{R}`),
      displayMath(String.raw`\gamma_2(\theta_\mu) := i \exp(i\theta_\mu) s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2) \in \mathbb{C}`),
      paragraph(["とおくと、"]),
      displayMath(String.raw`A(\theta_\mu) = \begin{pmatrix}
\gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu)
\end{pmatrix}`),
    ],
  },
  {
    id: "note_Athetatilde_003_claim_relation_of_gamma2_integer_route_TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2",
    targets: ["relation_of_gamma_2_theta_tilde"],
    title: { tex: String.raw`\arg(\gamma_1(\theta_\mu))` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/020_claim_gamma1_gamma2の偏角.typ", ordinal: 21 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_021_claim_arg_gamma1_gamma2。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_transfer_matrix_symbols"), " の記号のもと ", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), "（したがって ", math(String.raw`K_1^*, K_2^* \in \mathbb{R}_{>0}`), "）とし、", math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), "、", math(String.raw`\theta_\mu := \dfrac{2\pi\mu}{M} \in \mathbb{R}`), " とする。", math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`\gamma_1(\theta) := c_1 c_2^* - s_1 s_2^*\cos\theta`), "（", ref("def_A_theta"), " の対角成分）は ", math(String.raw`\gamma_1(\theta_\mu) \in \mathbb{R} \subset \mathbb{C}`), " を満たし、その偏角（", ref("def_abs_arg"), "）は"]),
      displayMath(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu))
= \begin{cases}
0 & \quad (\cos\theta_\mu \leq c_1 c_2^* / (s_1 s_2^*)) \\
\pi & \quad (\text{otherwise})
\end{cases}`),
      paragraph(["さらに ", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), " のもとでは常に ", math(String.raw`\dfrac{c_1 c_2^*}{s_1 s_2^*} > 1 \geq \cos\theta_\mu`), " であるから、第 2 の場合（otherwise）は実際には起こらない。すなわちすべての ", math(String.raw`\mu \in \mathcal{M}`), " について ", math(String.raw`\gamma_1(\theta_\mu) > 0`), " であり ", math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = 0`), "。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: 正値性と所属集合。", ref("def_transfer_matrix_symbols"), " より ", math(String.raw`K_1, K_1^*, K_2, K_2^* \in \mathbb{R}_{>0}`), " のとき ", math(String.raw`c_1 = \cosh 2K_1`), "、", math(String.raw`s_1 = \sinh 2K_1`), "、", math(String.raw`c_2^* = \cosh 2K_2^*`), "、", math(String.raw`s_2^* = \sinh 2K_2^*`), " はいずれも正の実数である（", ref("cosh_sinh_basic_properties"), " (1)(3) を ", math(String.raw`x = 2K_1 > 0`), "、", math(String.raw`x = 2K_2^* > 0`), " に適用）。また ", math(String.raw`\mu \in \mathcal{M} \subset \mathbb{Z}`), "、", math(String.raw`M \in \mathbb{Z}_{\geq 1}`), " より ", math(String.raw`\theta_\mu \in \mathbb{R}`), " であり ", math(String.raw`\cos\theta_\mu \in \mathbb{R}`), "。よって ", math(String.raw`\gamma_1(\theta_\mu) = c_1 c_2^* - s_1 s_2^*\cos\theta_\mu`), " は実数の四則演算で得られる実数であり、", math(String.raw`\gamma_1(\theta_\mu) \in \mathbb{R}`), "。特に ", math(String.raw`s_1 s_2^* > 0`), " なので、以下でこれによる除算ができる。"]),
      paragraph(["Step 2: 符号の判定。", math(String.raw`s_1 s_2^* > 0`), " で割ると、実数の順序の性質より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)>0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu>0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*>s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の不等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu<\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})\\[3pt]
\gamma_1(\theta_\mu)=0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu=0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*=s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu=\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})\\[3pt]
\gamma_1(\theta_\mu)<0
&\iff c_1c_2^*-s_1s_2^*\cos\theta_\mu<0
&&(\because\ \gamma_1\ \text{の定義})\\
&\iff c_1c_2^*<s_1s_2^*\cos\theta_\mu
&&(\because\ \text{実数の不等式の両辺へ同じ数を足した})\\
&\iff \cos\theta_\mu>\frac{c_1c_2^*}{s_1s_2^*}
&&(\because\ s_1s_2^*>0\ \text{で両辺を割った})
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`\cos\theta_\mu \leq c_1 c_2^*/(s_1 s_2^*) \iff \gamma_1(\theta_\mu) \geq 0`), "、", math(String.raw`\text{otherwise} \iff \gamma_1(\theta_\mu) < 0`), "。"]),
      paragraph(["Step 3: 実数の偏角。", math(String.raw`t \in \mathbb{R}`), " を ", math(String.raw`\iota_{\mathbb{R}\to\mathbb{C}}(t) = (t, 0) \in \mathbb{C}`), "（", ref("inclusion_rr_to_cc"), "）と見る。", ref("def_phi_polar"), " の場合分けを ", math(String.raw`(x,y) = (t,0)`), " に適用すると、"]),
      displayMath(String.raw`\begin{aligned}
t>0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t))]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ x>0\ \text{の場合})\\
&=[(t,\ 0)]_{\sim}
&& (\because\ \sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})}=t,\ \arctan 0=0)\\[3pt]
t<0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})},\ \arctan(0/t)+\pi)]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ x<0,\ y\geq0\ \text{の場合})\\
&=[(-t,\ \pi)]_{\sim}
&& (\because\ \sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})}=-t,\ \arctan 0=0)\\[3pt]
t=0:\qquad
\phi_{\mathrm{polar}}(t,0)
&=[(0,\ 0)]_{\sim}
&& (\because\ \text{極座標表示の定義の}\ (x,y)=(0,0)\ \text{の場合})
\end{aligned}`),
      paragraph(["（", math(String.raw`t < 0`), " の行は ", math(String.raw`x = t < 0`), " かつ ", math(String.raw`y = 0 \geq 0`), " の場合であり、", math(String.raw`\arctan 0 = 0`), "、", math(String.raw`\sqrt{t^2}^{\,(\mathbb{R}_{\geq 0})} = -t > 0`), "。）よって ", ref("first_and_second_projections"), " と ", ref("def_abs_arg"), " より"]),
      displayMath(String.raw`\begin{aligned}
t>0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(t,\ 0)]_{\sim})\right)
&&(\because\ \text{上の}\ t>0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(t,\ 0)]_{\sim})\\
&=s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義の}\ r=t>0\ \text{の場合})\\
&=0
&&(\because\ 0\in[0,2\pi)\ \text{なので代表を返す写像}\ s_{[0,2\pi)}\ \text{はそのまま}\ 0\ \text{を返す})\\[3pt]
t<0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(-t,\ \pi)]_{\sim})\right)
&&(\because\ \text{上の}\ t<0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(-t,\ \pi)]_{\sim})\\
&=s_{[0,2\pi)}([\pi]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義の}\ r=-t>0\ \text{の場合})\\
&=\pi
&&(\because\ \pi\in[0,2\pi)\ \text{なので}\ s_{[0,2\pi)}\ \text{はそのまま}\ \pi\ \text{を返す})\\[3pt]
t=0:\qquad
\arg^{[0,2\pi)}(t)
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2(\phi_{\mathrm{polar}}(t,0))\right)
&&(\because\ \arg^{[0,2\pi)}\ \text{の定義})\\
&=s_{[0,2\pi)}\!\left(\mathrm{pr}_2([(0,\ 0)]_{\sim})\right)
&&(\because\ \text{上の}\ t=0\ \text{の場合の}\ \phi_{\mathrm{polar}}(t,0)=[(0,\ 0)]_{\sim})\\
&=s_{[0,2\pi)}([0]_{\sim_{\mathrm{angle}}})
&&(\because\ \mathrm{pr}_2\ \text{の定義は}\ r=0\ \text{のとき}\ [0]_{\sim_{\mathrm{angle}}}\ \text{を返す})\\
&=0
&&(\because\ 0\in[0,2\pi)\ \text{なので}\ s_{[0,2\pi)}\ \text{はそのまま}\ 0\ \text{を返す})
\end{aligned}`),
      paragraph(["（", math(String.raw`\arg^{[0,2\pi)}`), " と ", math(String.raw`s_{[0,2\pi)}`), " は ", ref("def_abs_arg"), "、", math(String.raw`\mathrm{pr}_2`), " は ", ref("first_and_second_projections"), "。", math(String.raw`t = 0`), " の場合が示すとおり、本リポジトリの規約では ", math(String.raw`\arg^{[0,2\pi)}(0_{\mathbb{C}}) = 0`), " である。）まとめると ", math(String.raw`\arg^{[0,2\pi)}(t) = 0 \iff t \geq 0`), "、", math(String.raw`\arg^{[0,2\pi)}(t) = \pi \iff t < 0`), "。"]),
      paragraph(["Step 4: 結論。Step 2 と Step 3 を合わせると、", math(String.raw`\cos\theta_\mu \leq c_1 c_2^*/(s_1 s_2^*)`), " のとき ", math(String.raw`\gamma_1(\theta_\mu) \geq 0`), " ゆえ ", math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = 0`), "、それ以外のとき ", math(String.raw`\gamma_1(\theta_\mu) < 0`), " ゆえ ", math(String.raw`\arg^{[0,2\pi)}(\gamma_1(\theta_\mu)) = \pi`), "。これで主張の場合分けが示された（境界 ", math(String.raw`\cos\theta_\mu = c_1 c_2^*/(s_1 s_2^*)`), " では ", math(String.raw`\gamma_1(\theta_\mu) = 0`), " となるが、上の規約により ", math(String.raw`\arg^{[0,2\pi)}(0_{\mathbb{C}}) = 0`), " なので、境界を ", math(String.raw`\arg = 0`), " 側に含める原文の場合分けは正しい）。"]),
      paragraph(["Step 5: 第 2 の場合が空であること。", ref("cosh_sinh_basic_properties"), " (1)(3) より ", math(String.raw`2K_1 > 0`), " に対して ", math(String.raw`c_1 = \cosh 2K_1 > \sinh 2K_1 = s_1 > 0`), "、同様に ", math(String.raw`2K_2^* > 0`), " に対して ", math(String.raw`c_2^* > s_2^* > 0`), "。正数どうしの不等式の積より"]),
      displayMath(String.raw`\begin{aligned}
c_1 c_2^*
&>s_1 c_2^*
&&(\because\ c_1>s_1\ \text{の両辺に正数}\ c_2^*\ \text{を掛けた})\\
s_1 c_2^*
&>s_1 s_2^*
&&(\because\ c_2^*>s_2^*\ \text{の両辺に正数}\ s_1\ \text{を掛けた})\\
s_1 s_2^*
&>0
&&(\because\ s_1>0\ \text{かつ}\ s_2^*>0)
\end{aligned}`),
      paragraph(["よって ", math(String.raw`s_1 s_2^* > 0`), " で割って ", math(String.raw`\dfrac{c_1 c_2^*}{s_1 s_2^*} > 1`), "。一方 ", math(String.raw`\theta_\mu \in \mathbb{R}`), " より ", math(String.raw`\cos\theta_\mu \leq 1 < \dfrac{c_1 c_2^*}{s_1 s_2^*}`), " であるから、Step 2 より常に ", math(String.raw`\gamma_1(\theta_\mu) > 0`), " であり、第 2 の場合（otherwise）を満たす ", math(String.raw`\mu \in \mathcal{M}`), " は存在しない。"]),
    ],
  },
  {
    id: "note_Athetatilde_002_claim_gamma2_nonzero_integer_route_TV1_hatZ_hatY_022_claim_gamma2_theta_is_0",
    targets: ["gamma_2_theta_tilde_nonzero"],
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ になる条件}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/021_claim_gamma2_thetaが0になる条件.typ", ordinal: 22 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_022_claim_gamma2_theta_is_0。labels: gamma_2_theta_is_0。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_transfer_matrix_symbols"), " の記号のもと ", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), "（したがって ", math(String.raw`K_2^* \in \mathbb{R}_{>0}`), "）とし、", math(String.raw`M \in \mathbb{Z}_{\geq 1}`), "、", math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), "、", math(String.raw`\theta_\mu := \dfrac{2\pi\mu}{M} \in \mathbb{R}`), " とする。この前提から ", math(String.raw`c_1, s_1, c_2, s_2^* > 0`), "、特に ", math(String.raw`s_2^* \neq 0`), " が従う（証明の Step 0。", math(String.raw`s_2^* \neq 0`), " は以下の同値のすべてに不可欠である）。", math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`\gamma_2(\theta) := i \exp(i\theta) s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2)`), "（", ref("def_A_theta"), " の ", math(String.raw`(1,2)`), " 成分）は次を満たす。"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu) = 0
&\iff \begin{cases} \sin\theta_\mu = 0 \\ c_2 s_1 - c_1\cos\theta_\mu = 0 \end{cases} \\
&\iff \begin{cases} \theta_\mu = 0,\ \pm\pi,\ \pm 2\pi,\ \dots \\ c_2 s_1 = c_1\cos\theta_\mu \end{cases} \\
&\iff \begin{cases} \mu = \pm M \\ c_2 s_1 = c_1\cos\theta_\mu \end{cases}
\iff \begin{cases} \mu = \pm M \\ c_1 = s_1 c_2 \end{cases}
\end{aligned}`),
      paragraph(["上の同値はいずれも「連立条件全体としての同値」である。特に第 2 段から第 3 段への同値において、", math(String.raw`\sin\theta_\mu = 0`), " という条件だけでは ", math(String.raw`\mu = \pm M`), " は従わない。実際 ", math(String.raw`M`), " が偶数のときは ", math(String.raw`\mu = \pm M/2 \in \mathcal{M}`), " も ", math(String.raw`\theta_\mu = \pm\pi`), "、", math(String.raw`\sin\theta_\mu = 0`), " を満たす。この ", math(String.raw`\mu`), " が排除されるのは、もう一方の条件 ", math(String.raw`c_2 s_1 = c_1\cos\theta_\mu = -c_1 < 0`), " が ", math(String.raw`c_1, s_1, c_2 > 0`), " と矛盾するからである（証明の Step 4 を参照）。"]),
      paragraph(["証明."]),
      paragraph(["Step 0: 記号と所属集合の確認。", ref("def_transfer_matrix_symbols"), " より ", math(String.raw`c_1 = \cosh 2K_1`), "、", math(String.raw`s_1 = \sinh 2K_1`), "、", math(String.raw`c_2 = \cosh 2K_2`), "、", math(String.raw`s_2^* = \sinh 2K_2^*`), " はいずれも実数であり、", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), " である。ここで ", math(String.raw`K_2^* > 0`), " を確認しておく：", ref("def_transfer_matrix_symbols"), " の ", math(String.raw`K_2^* := -\tfrac{1}{2}\log(\tanh K_2)`), " において、"]),
      displayMath(String.raw`\begin{aligned}
0
&<\tanh K_2
&& (\because\ K_2>0\ \text{における}\ \tanh\ \text{の正値性})\\
\tanh K_2
&<1
&& (\because\ K_2>0\ \text{における}\ \tanh\ \text{の上界})\\
\log(\tanh K_2)
&<0
&& (\because\ 0<\tanh K_2<1\ \text{における実対数の符号})\\
K_2^*=-\frac12\log(\tanh K_2)
&>0
&& (\because\ \text{負数に負数}\ -\tfrac12\ \text{を掛けた})
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`K_1, K_2, K_2^* \in \mathbb{R}_{>0}`), " であり、", math(String.raw`x > 0`), " で ", math(String.raw`\cosh x > 0`), "、", math(String.raw`\sinh x > 0`), " であることから"]),
      displayMath(String.raw`c_1 = \cosh 2K_1 > 0, \quad s_1 = \sinh 2K_1 > 0, \quad c_2 = \cosh 2K_2 > 0, \quad
s_2^* = \sinh 2K_2^* > 0`),
      paragraph(["特に ", math(String.raw`s_2^* \neq 0`), " である。この ", math(String.raw`s_2^* \neq 0`), " は Step 1（", math(String.raw`\gamma_2(\theta_\mu)`), " の第 1 因子が ", math(String.raw`0`), " でないこと）に不可欠であり、これが無いと第 1 の同値そのものが成り立たない（", math(String.raw`s_2^* = 0`), " ならすべての ", math(String.raw`\mu`), " について ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " になってしまう）。また ", math(String.raw`\mu \in \mathcal{M} \subset \mathbb{Z}`), "、", math(String.raw`M \in \mathbb{Z}_{\geq 1}`), " より ", math(String.raw`\theta_\mu = 2\pi\mu/M \in \mathbb{R}`), " であり、", math(String.raw`\cos\theta_\mu, \sin\theta_\mu \in \mathbb{R}`), "。"]),
      paragraph(["Step 1: 因子 ", math(String.raw`i\,\exp(i\theta_\mu) s_2^*`), " が ", math(String.raw`\mathbb{C}^\times`), " に属すること。準備として 3 つの因子の絶対値を確かめる。", ref("euler_formula_cos_sin"), " より ", math(String.raw`\exp(i\theta_\mu) = \cos\theta_\mu + i\sin\theta_\mu`), " であるから、"]),
      displayMath(String.raw`\begin{aligned}
\left|\exp(i\theta_\mu)\right|^2
&= (\cos\theta_\mu)^2 + (\sin\theta_\mu)^2
&& (\because\ \text{絶対値の基本性質 (2)})\\
&= 1
&& (\because\ \cos^2 t + \sin^2 t = 1)
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`|\exp(i\theta_\mu)| = 1`), "（絶対値は非負なので平方が 1 なら値も 1）。同様に ", math(String.raw`|i| = 1`), " であり、", math(String.raw`s_2^* > 0`), " より ", math(String.raw`|s_2^*| = s_2^*`), "（", ref("abs_basic_properties"), " (6)）。この準備のもとで、"]),
      displayMath(String.raw`\begin{aligned}
\left|i\,\exp(i\theta_\mu) s_2^*\right|
&= |i|\,\left|\exp(i\theta_\mu)\right|\,\left|s_2^*\right|
&& (\because\ \text{絶対値の乗法性。絶対値の基本性質 (4)})\\
&= 1\cdot\left|\exp(i\theta_\mu)\right|\,\left|s_2^*\right|
&& (\because\ |i| = 1)\\
&= 1\cdot 1\cdot\left|s_2^*\right|
&& (\because\ \left|\exp(i\theta_\mu)\right| = 1)\\
&= 1\cdot 1\cdot s_2^*
&& (\because\ |s_2^*| = s_2^*)\\
&= s_2^*
&& (\because\ 1\ \text{との積})\\
&> 0
&& (\because\ \text{Step 0 の}\ s_2^* > 0)
\end{aligned}`),
      paragraph(["であり、", ref("abs_basic_properties"), " (3) より ", math(String.raw`i\,\exp(i\theta_\mu) s_2^* \neq 0_{\mathbb{C}}`), "。"]),
      paragraph(["Step 2: 第 1 の同値。", math(String.raw`w_\mu := c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2 \in \mathbb{C}`), " とおくと ", math(String.raw`\gamma_2(\theta_\mu) = (i\,\exp(i\theta_\mu) s_2^*)\,w_\mu`), "。", math(String.raw`\mathbb{C}`), " は体（", ref("complex_numbers_form_a_field"), "）ゆえ整域であり、Step 1 より第 1 因子は ", math(String.raw`0_{\mathbb{C}}`), " でないから"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)=0_{\mathbb{C}}
&\iff \bigl(i\,\exp(i\theta_\mu)s_2^*\bigr)w_\mu=0_{\mathbb{C}}
&& (\because\ \gamma_2(\theta_\mu)=\bigl(i\,\exp(i\theta_\mu)s_2^*\bigr)w_\mu)\\
&\iff w_\mu=0_{\mathbb{C}}
&& (\because\ \mathbb{C}\ \text{は整域であり、Step 1 より第 1 因子は零元でない})
\end{aligned}`),
      paragraph(["ここで ", math(String.raw`c_1\cos\theta_\mu - s_1 c_2 \in \mathbb{R}`), "、", math(String.raw`-\sin\theta_\mu \in \mathbb{R}`), " であるから、", ref("definition_of_cc"), " の成分表示で"]),
      displayMath(String.raw`w_\mu
= \bigl(c_1\cos\theta_\mu-s_1c_2,\;-\sin\theta_\mu\bigr)\in\mathbb{R}^2=\mathbb{C}
\quad (\because\ \text{複素数の成分表示の定義})`),
      paragraph(["であり、", math(String.raw`\mathbb{C}`), " の零元は ", math(String.raw`(0,0)`), " であるから"]),
      displayMath(String.raw`\begin{aligned}
w_\mu=0_{\mathbb{C}}
&\iff \bigl(c_1\cos\theta_\mu-s_1c_2,\;-\sin\theta_\mu\bigr)=(0,0)
&& (\because\ w_\mu\ \text{の成分表示と}\ 0_{\mathbb{C}}=(0,0))\\
&\iff \begin{cases}
c_1\cos\theta_\mu-s_1c_2=0\\
-\sin\theta_\mu=0
\end{cases}
&& (\because\ \text{順序対の相等は各成分の相等と同値})\\
&\iff \begin{cases}
\sin\theta_\mu=0\\
c_2s_1-c_1\cos\theta_\mu=0
\end{cases}
&& (\because\ \text{各式を}\ -1\ \text{倍し、実数の積を交換した})
\end{aligned}`),
      paragraph(["これで第 1 の同値を得た。"]),
      paragraph(["Step 3: 第 2 の同値。第 2 式 ", math(String.raw`c_2 s_1 - c_1\cos\theta_\mu = 0`), " と ", math(String.raw`c_2 s_1 = c_1\cos\theta_\mu`), " は同じ式である。第 1 式については、実数 ", math(String.raw`t \in \mathbb{R}`), " に対する ", math(String.raw`\sin`), " の零点の特徴づけ ", math(String.raw`\sin t = 0 \iff \exists k \in \mathbb{Z}:\ t = k\pi`), " を用いると"]),
      displayMath(String.raw`\sin\theta_\mu = 0 \iff \theta_\mu \in \pi\mathbb{Z} = \{0,\ \pm\pi,\ \pm 2\pi,\ \dots\}`),
      paragraph(["となり、第 2 の同値を得る。"]),
      paragraph(["Step 3': 第 1 式だけを ", math(String.raw`\mu`), " の言葉に翻訳しておく（第 3 の同値を正しく述べるために必要）。", math(String.raw`\theta_\mu = 2\pi\mu/M`), " であるから、", math(String.raw`k \in \mathbb{Z}`), " を用いて"]),
      displayMath(String.raw`\begin{aligned}
\theta_\mu \in \pi\mathbb{Z}
&\iff \exists k \in \mathbb{Z}:\ \frac{2\pi\mu}{M} = k\pi
&& (\because\ \theta_\mu = 2\pi\mu/M\ \text{を代入し、}\pi\mathbb{Z}\ \text{の元であることを}\ k\ \text{の存在で書いた})\\
&\iff \exists k \in \mathbb{Z}:\ 2\mu = kM
&& (\because\ \text{両辺に}\ M/\pi\ \text{を掛けた。}\pi\ne0\ \text{かつ}\ M\ge1\ \text{なので同値})\\
&\iff M \mid 2\mu
&& (\because\ \text{整除}\ M\mid2\mu\ \text{の定義そのもの})
\end{aligned}`),
      paragraph(["ここで ", math(String.raw`M \mid 2\mu`), " を ", math(String.raw`M`), " の偶奇で言い換える。", math(String.raw`M`), " が奇数の場合。"]),
      displayMath(String.raw`M \mid 2\mu \iff M \mid \mu
\qquad (\because\ \gcd(M,2)=1\ \text{なので}\ M\ \text{が}\ 2\mu\ \text{を割れば}\ \mu\ \text{を割る。逆は倍を取るだけ})`),
      paragraph([math(String.raw`M`), " が偶数の場合。", math(String.raw`M = 2M'`), " とおくと"]),
      displayMath(String.raw`\begin{aligned}
M \mid 2\mu
&\iff 2M' \mid 2\mu
&& (\because\ M=2M'\ \text{を代入した})\\
&\iff M' \mid \mu
&& (\because\ \text{両辺の商の等式を}\ 2\ \text{で約した。}2\ne0\ \text{なので同値})
\end{aligned}`),
      paragraph([math(String.raw`M' = M/2`), " だから、これは ", math(String.raw`\mu \equiv 0 \pmod{M}`), " または ", math(String.raw`\mu \equiv M/2 \pmod{M}`), " と同値である。まとめると"]),
      displayMath(String.raw`\sin\theta_\mu = 0
\iff \begin{cases}
\mu \equiv 0 \pmod{M} & (M \text{ が奇数}) \\
\mu \equiv 0 \pmod{M} \ \text{または}\ \mu \equiv M/2 \pmod{M} & (M \text{ が偶数})
\end{cases}`),
      paragraph(["特に、", math(String.raw`M`), " が偶数のときは ", math(String.raw`\mu = \pm M/2 \in \mathcal{M}`), " も第 1 式を満たすので、", math(String.raw`\sin\theta_\mu = 0 \iff \mu = \pm M`), " は偽である。第 3 の同値が成り立つのは、あくまで第 2 式との連立の下だけである。"]),
      paragraph(["Step 4: 第 3 の同値。ここは連立条件の下ではじめて成立するので、両向きを分けて示す。"]),
      paragraph(["（", math(String.raw`\Rightarrow`), "）", math(String.raw`\theta_\mu \in \pi\mathbb{Z}`), " かつ ", math(String.raw`c_2 s_1 = c_1\cos\theta_\mu`), " とする。", math(String.raw`\theta_\mu = 2\pi\mu/M = k\pi`), "（", math(String.raw`k \in \mathbb{Z}`), "）は ", math(String.raw`2\mu = kM`), " と同値であり、これは ", math(String.raw`M \mid 2\mu`), " を意味する。", math(String.raw`\mu \in \mathcal{M}`), " より、"]),
      displayMath(String.raw`\begin{aligned}
1
&\leq |\mu|
&& (\because\ \mu\in\mathcal{M})\\
|\mu|
&\leq M
&& (\because\ \mu\in\mathcal{M})\\
2
&\leq 2|\mu|
&& (\because\ 1\leq|\mu|\ \text{の両辺を正数}\ 2\ \text{倍した})\\
2|\mu|
&\leq 2M
&& (\because\ |\mu|\leq M\ \text{の両辺を正数}\ 2\ \text{倍した})\\
M
&\mid 2|\mu|
&& (\because\ M\mid2\mu\ \text{ならば}\ M\mid|2\mu|=2|\mu|)
\end{aligned}`),
      paragraph(["である。この範囲で ", math(String.raw`M`), " の倍数は ", math(String.raw`M`), " と ", math(String.raw`2M`), " のみであるから、"]),
      displayMath(String.raw`\begin{aligned}
2|\mu|
&\in\{M,2M\}
&& (\because\ 2\leq2|\mu|\leq2M\ \text{かつ}\ M\mid2|\mu|)\\
|\mu|
&\in\{M/2,M\}
&& (\because\ \text{各候補を}\ 2\ \text{で割った})
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`|\mu| = M/2`), "（このとき ", math(String.raw`M`), " は偶数）または ", math(String.raw`|\mu| = M`), " である。"]),
      paragraph([math(String.raw`|\mu| = M/2`), " の場合は ", math(String.raw`\mu=\pm M/2`), " なので、"]),
      displayMath(String.raw`\begin{aligned}
\theta_\mu
&=\frac{2\pi(\pm M/2)}{M}
&& (\because\ \theta_\mu=2\pi\mu/M\ \text{へ}\ \mu=\pm M/2\ \text{を代入した})\\
&=\pm\pi
&& (\because\ M\geq1\ \text{なので}\ M\ne0\ \text{として約した})\\
\cos\theta_\mu
&=\cos(\pm\pi)
&& (\because\ \theta_\mu=\pm\pi)\\
&=-1
&& (\because\ \cos(\pm\pi)=-1)\\
c_2s_1
&=c_1\cos\theta_\mu
&& (\because\ \text{第 2 式})\\
&=-c_1
&& (\because\ \cos\theta_\mu=-1)
\end{aligned}`),
      paragraph(["一方、Step 0 の正値性から"]),
      displayMath(String.raw`\begin{aligned}
0
&<c_2s_1
&& (\because\ c_2>0\ \text{かつ}\ s_1>0)\\
c_2s_1
&=-c_1
&& (\because\ \text{上の第 2 式の計算})\\
-c_1
&<0
&& (\because\ c_1>0)
\end{aligned}`),
      paragraph(["となり矛盾する。よってこの場合は起こらず、", math(String.raw`|\mu| = M`), " すなわち ", math(String.raw`\mu = \pm M`), " である（第 2 式はそのまま保たれる）。"]),
      paragraph(["（", math(String.raw`\Leftarrow`), "）", math(String.raw`\mu = \pm M`), " とすると、"]),
      displayMath(String.raw`\begin{aligned}
\theta_\mu
&=\frac{2\pi(\pm M)}{M}
&& (\because\ \theta_\mu=2\pi\mu/M\ \text{へ}\ \mu=\pm M\ \text{を代入した})\\
&=\pm2\pi
&& (\because\ M\geq1\ \text{なので}\ M\ne0\ \text{として約した})\\
&\in\pi\mathbb{Z}
&& (\because\ \pm2\in\mathbb{Z})
\end{aligned}`),
      paragraph(["ゆえに第 1 式が成り立つ。第 2 式は連立条件の両側に同じ形で置かれているので、そのまま保たれる。"]),
      paragraph(["Step 5: 第 4 の同値。", math(String.raw`\mu = \pm M`), " とする。第 2 式について"]),
      displayMath(String.raw`\begin{aligned}
c_2 s_1 = c_1\cos\theta_\mu
&\iff c_2 s_1 = c_1\cos(\pm 2\pi)
&& (\because\ \theta_\mu = 2\pi\mu/M\ \text{に}\ \mu=\pm M\ \text{を代入すると}\ \theta_\mu=\pm2\pi)\\
&\iff c_2 s_1 = c_1 \cdot 1
&& (\because\ \cos(\pm 2\pi)=1)\\
&\iff c_2 s_1 = c_1
&& (\because\ 1\ \text{は実数の積の単位元})\\
&\iff c_1 = s_1 c_2
&& (\because\ \text{相等の対称性と、実数の積の交換})
\end{aligned}`),
      paragraph(["以上で主張のすべての同値が示された。"]),
    ],
  },
  {
    id: "note_Athetatilde_003_claim_relation_of_gamma2_integer_route_TV1_hatZ_hatY_023_claim_relation_of_gamma2",
    targets: ["relation_of_gamma_2_theta_tilde"],
    title: { tex: String.raw`\gamma_2(\theta_\mu) \text{ と } \gamma_2(-\theta_\mu) \text{ の関係}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/022_claim_gamma2_thetaとgamma2_minus_thetaの関係.typ", ordinal: 23 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_023_claim_relation_of_gamma2。labels: relation_of_gamma_2。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`),
      paragraph(["ゆえに、"]),
      displayMath(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`),
      paragraph(["証明."]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)
&=i\,\exp(-i\theta_\mu)s_2^*\bigl(c_1\cos\theta_\mu+i\sin\theta_\mu-s_1c_2\bigr)
&&(\because\ \blkref{def_A_theta}\ \text{の}\ \gamma_2\ \text{の定義と}\ \cos(-\theta)=\cos\theta,\ \sin(-\theta)=-\sin\theta)\\
&=-\Bigl((-i)\exp(-i\theta_\mu)s_2^*\bigl(c_1\cos\theta_\mu+i\sin\theta_\mu-s_1c_2\bigr)\Bigr)
&&(\because\ -(-i)=i)\\
&=-\overline{i\,\exp(i\theta_\mu)s_2^*\bigl(c_1\cos\theta_\mu-i\sin\theta_\mu-s_1c_2\bigr)}
&&(\because\ \text{複素共役は積を保ち、実数を固定し、}\ \overline{i}=-i,\ \overline{\exp(i\theta_\mu)}=\exp(-i\theta_\mu))\\
&=-\overline{\gamma_2(\theta_\mu)}
&&(\because\ \blkref{def_A_theta}\ \text{の}\ \gamma_2\ \text{の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&=\gamma_2(\theta_\mu)\Bigl(-\overline{\gamma_2(\theta_\mu)}\Bigr)
&&(\because\ \gamma_2(-\theta_\mu)=-\overline{\gamma_2(\theta_\mu)})\\
&=-\Bigl(\gamma_2(\theta_\mu)\overline{\gamma_2(\theta_\mu)}\Bigr)
&&(\because\ \mathbb{C}\ \text{の分配則})\\
&=-\lvert\gamma_2(\theta_\mu)\rvert^2
&&(\because\ \lvert z\rvert^2=z\overline z)
\end{aligned}`),
    ],
  },
  {
    id: "note_Athetatilde_003_claim_relation_of_gamma2_integer_route_TV1_hatZ_hatY_024_claim_arg_of_gamma2_mu",
    targets: ["relation_of_gamma_2_theta_tilde"],
    title: { tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)) = \pi` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/023_claim_gamma2_theta_muの積のarg.typ", ordinal: 24 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_024_claim_arg_of_gamma2_mu。labels: arg_of_gamma_2_mu。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)\bigr) = \pi`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&= \left(i\,\exp(i\theta_\mu)s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right)\left(i\,\exp(-i\theta_\mu)s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)\right)
&&(\because\ \blkref{def_A_theta}\ \text{の}\ \gamma_2\ \text{の定義})\\
&= \left(i\,\exp(i\theta_\mu)s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right)\left(i\,\exp(-i\theta_\mu)s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)\right)
&&(\because\ \cos\ \text{は偶関数、}\sin\ \text{は奇関数})\\
&= (i\cdot i)\left(\exp(i\theta_\mu)\exp(-i\theta_\mu)\right)(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ \mathbb{C}\ \text{の積の可換性と結合則で因子を並べ替えた})\\
&= (-1)\left(\exp(i\theta_\mu + i(-\theta_\mu))\right)(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ i\cdot i=-1\ \text{と指数法則})\\
&= (-1)(\exp(0))(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ i\theta_\mu + i(-\theta_\mu)=0)\\
&= -(s_2^*)^2(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)
&&(\because\ \exp(0)=1)\\
&= -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ (a-ib)(a+ib)=a^2+b^2\ \text{を}\ a=c_1\cos\theta_\mu - s_1 c_2,\ b=\sin\theta_\mu\ \text{へ当てた})\\
&= -(s_2^*)^2\left((c_1\cos\tfrac{2\pi\mu}{M} - s_1 c_2)^2 + (\sin\tfrac{2\pi\mu}{M})^2\right)
&&(\because\ \theta_\mu = \tfrac{2\pi\mu}{M})
\end{aligned}`),
      paragraph(["ここで ", math(String.raw`s_2^* > 0`), "（", ref("def_transfer_matrix_symbols"), "）より ", math(String.raw`(s_2^*)^2 > 0`), " である。また"]),
      displayMath(String.raw`\begin{aligned}
|\gamma_2(\theta_\mu)|^2
&= \left|i\,\exp(i\theta_\mu)s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)\right|^2
&&(\because\ \blkref{def_A_theta}\ \text{の}\ \gamma_2\ \text{の定義})\\
&= (s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ |i| = |\exp(i\theta_\mu)| = 1\ \text{と、絶対値は積を保つこと})
\end{aligned}`),
      paragraph(["である。この 2 つから"]),
      displayMath(String.raw`\begin{aligned}
(c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2
&= \dfrac{|\gamma_2(\theta_\mu)|^2}{(s_2^*)^2}
&&(\because\ \text{直前の等式の両辺を}\ (s_2^*)^2 > 0\ \text{で割った})\\
&> 0
&&(\because\ \gamma_2(\theta_\mu) \neq 0\ \text{より}\ |\gamma_2(\theta_\mu)|^2 > 0)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&= -(s_2^*)^2\left((c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2\right)
&&(\because\ \text{最初の式変形})\\
&< 0
&&(\because\ (s_2^*)^2 > 0\ \text{と直前の不等式の積は正であり、その}\ (-1)\ \text{倍は負})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)`), " は負の実数であり、負の実数の偏角は ", math(String.raw`\pi`), " であるから ", math(String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)) = \pi`), "。"]),
    ],
  },
  {
    id: "note_Athetatilde_003_claim_relation_of_gamma2_integer_route_TV1_hatZ_hatY_025_claim_arg_gamma2_sum",
    targets: ["relation_of_gamma_2_theta_tilde"],
    title: { tex: String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) + \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/024_claim_gamma2_theta_mu_gamma2_minus_theta_muのarg.typ", ordinal: 25 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_025_claim_arg_gamma2_sum。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について（", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`), " であるから、", math(String.raw`\gamma_2(\theta_\mu), \gamma_2(-\theta_\mu)`), " はともに非零であり、その偏角 ", math(String.raw`\arg^{[0,2\pi)}`), " が定義される）、", math(String.raw`r_+, r_- \in \mathbb{R}_{\geq 0}`), "、", math(String.raw`\theta_+, \theta_- \in \mathbb{R}`), " として ", math(String.raw`\gamma_2(\theta_\mu) = [(r_+, \theta_+)]`), "、", math(String.raw`\gamma_2(-\theta_\mu) = [(r_-, \theta_-)]`), " とするとき、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) + \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))
= \begin{cases}
\pi & (\exists m \in \mathbb{Z}:\; 0 \leq \theta_+ + \theta_- - 2m\pi < 2\pi) \\
\pi + 2\pi & (\exists m \in \mathbb{Z}:\; 2\pi \leq \theta_+ + \theta_- - 2m\pi < 4\pi)
\end{cases}`),
      paragraph(["証明."]),
      paragraph(["〔arg_of_gamma_2_mu〕", " と ", ref("range_of_args_of_multiple_of_complex_numbers"), " より。"]),
    ],
  },
  {
    id: "note_Athetatilde_003_claim_relation_of_gamma2_integer_route_TV1_hatZ_hatY_026_claim_arg_gamma2_quotient",
    targets: ["relation_of_gamma_2_theta_tilde"],
    title: { tex: String.raw`\arg^{[0,2\pi)}\!\bigl(\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu)\bigr)` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ", ordinal: 26 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_026_claim_arg_gamma2_quotient。labels: arg_of_gamma2_quotient。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について（", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)} \neq 0`), " でもあるから、商 ", math(String.raw`\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu) \in \mathbb{C}^\times`), " が定義される）、", math(String.raw`\varphi_\mu := \arg^{[0,2\pi)}(\gamma_2(\theta_\mu)) \in [0,2\pi)`), " とおくと、"]),
      displayMath(String.raw`\left|\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right| = 1,
\qquad
\arg^{[0,2\pi)}\!\Bigl(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\Bigr)
= s_{[0,2\pi)}\!\left([\,2\varphi_\mu + \pi\,]_{\sim_{\mathrm{angle}}}\right)`),
      paragraph(["すなわち ", math(String.raw`2\varphi_\mu + \pi`), " を ", math(String.raw`\bmod 2\pi`), " で ", math(String.raw`[0,2\pi)`), " へ還元したものであり、具体的には"]),
      displayMath(String.raw`\arg^{[0,2\pi)}\!\Bigl(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\Bigr)
= \begin{cases}
2\varphi_\mu + \pi & \left(0 \leq \varphi_\mu < \tfrac{\pi}{2}\right) \\
2\varphi_\mu - \pi & \left(\tfrac{\pi}{2} \leq \varphi_\mu < \tfrac{3\pi}{2}\right) \\
2\varphi_\mu - 3\pi & \left(\tfrac{3\pi}{2} \leq \varphi_\mu < 2\pi\right)
\end{cases}`),
      paragraph(["証明."]),
      paragraph(["以下 ", math(String.raw`z := \gamma_2(\theta_\mu) \in \mathbb{C}^\times`), "、", math(String.raw`r := |z| \in \mathbb{R}_{>0}`), "（", ref("abs_basic_properties"), " (3) より ", math(String.raw`z \neq 0 \Rightarrow r > 0`), "）、", math(String.raw`\varphi_\mu := \arg^{[0,2\pi)}(z) \in [0,2\pi)`), " と略記する。"]),
      paragraph(["Step 0: ", math(String.raw`\phi_{\mathrm{polar}}`), " が ", math(String.raw`\phi_{\mathrm{cartesian}}`), " の逆写像であること。", ref("isomorphism_of_phi_cartesian"), " より ", math(String.raw`\phi_{\mathrm{cartesian}}`), " は全単射であり、その証明中で ", math(String.raw`\phi_{\mathrm{cartesian}} \circ \phi_{\mathrm{polar}} = \mathrm{id}_{\mathbb{C}}`), " が示されている。全単射に右逆写像が存在すればそれは逆写像に一致するから ", math(String.raw`\phi_{\mathrm{polar}} = \phi_{\mathrm{cartesian}}^{-1}`), "。したがって ", math(String.raw`\phi_{\mathrm{cartesian}}([(\rho,\vartheta)]_{\sim}) = w`), " を確かめれば ", math(String.raw`\phi_{\mathrm{polar}}(w) = [(\rho,\vartheta)]_{\sim}`), " が従う。また同 claim より ", math(String.raw`\phi_{\mathrm{cartesian}}`), " はモノイド準同型なので、その逆写像 ", math(String.raw`\phi_{\mathrm{polar}}`), " もモノイド準同型である：", math(String.raw`\phi_{\mathrm{polar}}(w_1 w_2) = \phi_{\mathrm{polar}}(w_1)\cdot\phi_{\mathrm{polar}}(w_2)`), "（右辺の積は ", ref("operations_on_polar_representation"), "）。"]),
      paragraph(["Step 1: ", math(String.raw`\phi_{\mathrm{polar}}(z) = [(r, \varphi_\mu)]_{\sim}`), "。実際 ", math(String.raw`\phi_{\mathrm{polar}}(z) = [(\rho,\vartheta)]_{\sim}`), " とおくと、", ref("def_abs_arg"), " より ", math(String.raw`\rho = \mathrm{pr}_1(\phi_{\mathrm{polar}}(z)) = |z| = r > 0`), " であり、", math(String.raw`\rho \neq 0`), " ゆえ ", ref("first_and_second_projections"), " より ", math(String.raw`\mathrm{pr}_2(\phi_{\mathrm{polar}}(z)) = [\vartheta]_{\sim_{\mathrm{angle}}}`), "。よって ", math(String.raw`\varphi_\mu = s_{[0,2\pi)}([\vartheta]_{\sim_{\mathrm{angle}}}) = \vartheta - 2n\pi`), "（", ref("section_of_angle_representation"), " の ", math(String.raw`n \in \mathbb{Z}`), "）となり ", math(String.raw`[\vartheta]_{\sim_{\mathrm{angle}}} = [\varphi_\mu]_{\sim_{\mathrm{angle}}}`), "、", ref("polar_equivalence_class"), " より ", math(String.raw`[(\rho,\vartheta)]_{\sim} = [(r,\varphi_\mu)]_{\sim}`), "。"]),
      paragraph(["Step 2: 商の書き換え。", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2 = -r^2`), " であり、", math(String.raw`r > 0`), " より ", math(String.raw`-r^2 \neq 0`), " ゆえ ", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), "。", math(String.raw`\mathbb{C}`), " は体（", ref("complex_numbers_form_a_field"), "）だから、分子・分母に ", math(String.raw`z \neq 0`), " を掛けて"]),
      displayMath(String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{\gamma_2(\theta_\mu)\,\gamma_2(\theta_\mu)}{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}
&&(\because\ \text{分子と分母に同じ } \gamma_2(\theta_\mu) = z \neq 0 \text{ を掛けても商は変わらない}) \\
&= \frac{z^2}{-r^2}
&&(\because\ \text{分子は } z \text{ の定義、分母は上の積の等式 } \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = -r^2) \\
&= z^2 \cdot \left(-\frac{1}{r^2}\right)
&&(\because\ -r^2 \neq 0 \text{ による商から積への書き換え})
\end{aligned}`),
      paragraph(["Step 3: 各因子の極座標表現。Step 0 と Step 1 より"]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}(z^2)
&= \phi_{\mathrm{polar}}(z)\cdot\phi_{\mathrm{polar}}(z)
&& (\because\ \phi_{\mathrm{polar}}\ \text{の乗法性}) \\
&= [(r,\varphi_\mu)]_{\sim}\cdot[(r,\varphi_\mu)]_{\sim}
&& (\because\ \text{Step 1}) \\
&= [(r^2,\ 2\varphi_\mu)]_{\sim}
&& (\because\ \text{極座標表現の積の定義})
\end{aligned}`),
      paragraph(["また ", math(String.raw`-\dfrac{1}{r^2} \in \mathbb{R}_{<0}`), " については、", ref("def_phi_cartesian"), " より"]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\!\left(\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}\right)
&= \left(\tfrac{1}{r^2}\cos\pi,\ \tfrac{1}{r^2}\sin\pi\right)
&& (\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= \left(-\tfrac{1}{r^2},\ 0\right)
&& (\because\ \cos\pi=-1,\ \sin\pi=0) \\
&= -\frac{1}{r^2}
&& (\because\ \mathbb{R}\ \text{を}\ \mathbb{C}\ \text{の実軸と同一視する})
\end{aligned}`),
      paragraph(["であるから、Step 0 より ", math(String.raw`\phi_{\mathrm{polar}}\!\left(-\dfrac{1}{r^2}\right) = \left[\left(\dfrac{1}{r^2},\ \pi\right)\right]_{\sim}`), "。"]),
      paragraph(["Step 4: 商の極座標表現。"]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{polar}}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
&= \phi_{\mathrm{polar}}\!\left(z^2\cdot\left(-\tfrac{1}{r^2}\right)\right)
&&(\because\ \text{Step 2 の商から積への書き換え}) \\
&= \phi_{\mathrm{polar}}(z^2)\cdot\phi_{\mathrm{polar}}\!\left(-\tfrac{1}{r^2}\right)
&&(\because\ \text{Step 0 の }\phi_{\mathrm{polar}}\text{ の乗法性}) \\
&= [(r^2,\ 2\varphi_\mu)]_{\sim}\cdot\left[\left(\tfrac{1}{r^2},\ \pi\right)\right]_{\sim}
&&(\because\ \text{Step 3 の各因子の極座標表現}) \\
&= \left[\left(r^2\cdot\tfrac{1}{r^2},\ 2\varphi_\mu + \pi\right)\right]_{\sim}
&&(\because\ \text{極座標表現の積の定義}) \\
&= [(1,\ 2\varphi_\mu + \pi)]_{\sim}
&&(\because\ r^2\cdot\tfrac{1}{r^2} = 1)
\end{aligned}`),
      paragraph(["よって、絶対値は"]),
      displayMath(String.raw`\begin{aligned}
\left|\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right|
&= \mathrm{pr}_1\!\left([(1,\ 2\varphi_\mu+\pi)]_{\sim}\right)
&&(\because\ \text{絶対値の定義}) \\
&= 1
&&(\because\ \text{第 1 射影は代表の第 1 成分を返す})
\end{aligned}`),
      paragraph(["（", ref("def_abs_arg"), "、", ref("first_and_second_projections"), "）。第 1 成分 ", math(String.raw`1 \neq 0`), " なので ", math(String.raw`\mathrm{pr}_2`), " は ", math(String.raw`[2\varphi_\mu+\pi]_{\sim_{\mathrm{angle}}}`), " を返し、偏角は"]),
      displayMath(String.raw`\begin{aligned}
\arg^{[0,2\pi)}\!\left(\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}\right)
&= s_{[0,2\pi)}\!\left(\mathrm{pr}_2\!\left([(1,\ 2\varphi_\mu+\pi)]_{\sim}\right)\right)
&&(\because\ \text{偏角の定義}) \\
&= s_{[0,2\pi)}\!\left([\,2\varphi_\mu + \pi\,]_{\sim_{\mathrm{angle}}}\right)
&&(\because\ \text{第 2 射影は第 1 成分が零でないとき角の類を返す})
\end{aligned}`),
      paragraph(["（", ref("def_abs_arg"), "、", ref("first_and_second_projections"), "）。"]),
      paragraph(["Step 5: ", math(String.raw`\bmod 2\pi`), " の還元。", math(String.raw`0 \leq \varphi_\mu < 2\pi`), " より ", math(String.raw`\pi \leq 2\varphi_\mu + \pi < 5\pi`), " である。", ref("section_of_angle_representation"), " は ", math(String.raw`0 \leq (2\varphi_\mu+\pi) - 2n\pi < 2\pi`), " なる唯一の ", math(String.raw`n \in \mathbb{Z}`), " をとって ", math(String.raw`(2\varphi_\mu+\pi) - 2n\pi`), " を返すから、"]),
      displayMath(String.raw`\begin{aligned}
0 \leq \varphi_\mu < \tfrac{\pi}{2}
&\Rightarrow \pi \leq 2\varphi_\mu+\pi < 2\pi
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot0\cdot\pi < 2\pi
&&(\because\ \pi\geq0) \\
&\Rightarrow n=0
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu+\pi
&&(\because\ \text{区間 }[0,2\pi)\text{ への代表を返す写像の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tfrac{\pi}{2} \leq \varphi_\mu < \tfrac{3\pi}{2}
&\Rightarrow 2\pi \leq 2\varphi_\mu+\pi < 4\pi
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot1\cdot\pi < 2\pi
&&(\because\ \text{各辺から }2\pi\text{ を引く}) \\
&\Rightarrow n=1
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu-\pi
&&(\because\ (2\varphi_\mu+\pi)-2\pi=2\varphi_\mu-\pi)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\tfrac{3\pi}{2} \leq \varphi_\mu < 2\pi
&\Rightarrow 4\pi \leq 2\varphi_\mu+\pi < 5\pi
&&(\because\ \text{不等式の各辺を 2 倍して }\pi\text{ を足す}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot2\cdot\pi < \pi
&&(\because\ \text{各辺から }4\pi\text{ を引く}) \\
&\Rightarrow 0 \leq (2\varphi_\mu+\pi)-2\cdot2\cdot\pi < 2\pi
&&(\because\ \pi<2\pi) \\
&\Rightarrow n=2
&&(\because\ \text{条件を満たす }n\in\mathbb{Z}\text{ の一意性}) \\
&\Rightarrow \arg^{[0,2\pi)}=2\varphi_\mu-3\pi
&&(\because\ (2\varphi_\mu+\pi)-4\pi=2\varphi_\mu-3\pi)
\end{aligned}`),
      paragraph(["を得る。これで主張の場合分けが示された。"]),
      paragraph(["Step 6（補足）: ", math(String.raw`\varphi_\mu`), " 自身の書き下し。", math(String.raw`w_\mu := c_1\cos\theta_\mu - s_1 c_2 - i\sin\theta_\mu \in \mathbb{C}`), " とおくと ", math(String.raw`\gamma_2(\theta_\mu) = i\,\exp(i\theta_\mu) s_2^*\,w_\mu`), " であり、", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " より ", math(String.raw`w_\mu \neq 0`), "。", ref("def_phi_cartesian"), " と Step 0 より"]),
      displayMath(String.raw`\phi_{\mathrm{polar}}(i) = \left[\left(1,\ \tfrac{\pi}{2}\right)\right]_{\sim},
\qquad
\phi_{\mathrm{polar}}\!\left(\exp(i\theta_\mu)\right) = [(1,\ \theta_\mu)]_{\sim},
\qquad
\phi_{\mathrm{polar}}(s_2^*) = [(s_2^*,\ 0)]_{\sim}`),
      paragraph(["この 3 つの等式は、", ref("def_phi_cartesian"), " をそれぞれの類へ当てた次の 3 本の鎖で確かめられる", "（2 本目の鎖の Euler の公式は ", ref("euler_formula_cos_sin"), "）。"]),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}\!\left(\left[\left(1,\ \tfrac{\pi}{2}\right)\right]_{\sim}\right)
&= \left(\cos\tfrac{\pi}{2},\ \sin\tfrac{\pi}{2}\right)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= (0,\ 1)
&&(\because\ \cos\tfrac{\pi}{2}=0,\ \sin\tfrac{\pi}{2}=1) \\
&= i
&&(\because\ \mathbb{R}^2=\mathbb{C}\ \text{の同一視で}\ (0,1)\ \text{は}\ i)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(1,\ \theta_\mu)]_{\sim})
&= (\cos\theta_\mu,\ \sin\theta_\mu)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= \exp(i\theta_\mu)
&&(\because\ \text{Euler の公式})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\phi_{\mathrm{cartesian}}([(s_2^*,\ 0)]_{\sim})
&= (s_2^*\cos 0,\ s_2^*\sin 0)
&&(\because\ \phi_{\mathrm{cartesian}}\ \text{の定義}) \\
&= (s_2^*,\ 0)
&&(\because\ \cos 0=1,\ \sin 0=0) \\
&= s_2^*
&&(\because\ \mathbb{R}^2=\mathbb{C}\ \text{の同一視。}s_2^*>0\ \text{なので実軸上の点})
\end{aligned}`),
      paragraph([math(String.raw`\psi_\mu := \arg^{[0,2\pi)}(w_\mu)`), " とおくと Step 1 と同様に ", math(String.raw`\phi_{\mathrm{polar}}(w_\mu) = [(|w_\mu|, \psi_\mu)]_{\sim}`), " であるから、準同型性より"]),
      displayMath(String.raw`\phi_{\mathrm{polar}}(\gamma_2(\theta_\mu))
= \left[\left(s_2^*\,|w_\mu|,\ \tfrac{\pi}{2} + \theta_\mu + \psi_\mu\right)\right]_{\sim},
\qquad
\varphi_\mu = s_{[0,2\pi)}\!\left(\left[\theta_\mu + \tfrac{\pi}{2} + \psi_\mu\right]_{\sim_{\mathrm{angle}}}\right)`),
      paragraph(["ここで ", math(String.raw`w_\mu = (c_1\cos\theta_\mu - s_1 c_2,\ -\sin\theta_\mu) \in \mathbb{R}^2 = \mathbb{C}`), " であり、", math(String.raw`|w_\mu| = \sqrt{(c_1\cos\theta_\mu - s_1 c_2)^2 + (\sin\theta_\mu)^2}^{\,(\mathbb{R}_{\geq 0})}`), "、", math(String.raw`\psi_\mu`), " は ", ref("def_phi_polar"), " の場合分け（", math(String.raw`\arctan`), " による）で定まる。"]),
    ],
  },
  {
    id: "note_Athetatilde_004_claim_eigenvector_integer_route_TV1_hatZ_hatY_027_claim_eigenvector_A_theta",
    targets: ["eigenvector_of_A_theta_tilde"],
    title: { tex: String.raw`A(\theta_\mu) \text{ の固有値と固有ベクトル}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/026_claim_A_thetaの対角化_固有値と固有ベクトル.typ", ordinal: 27 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_027_claim_eigenvector_A_theta。labels: eigenvector_of_A_theta。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`A(\theta_\mu)`), " の固有値は"]),
      displayMath(String.raw`\lambda_{\pm,\mu}
:= \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}`),
      paragraph(["対応する固有ベクトルは："]),
      paragraph(["1) ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき: 任意の ", math(String.raw`v \in \mathbb{C}^2 \setminus \{0\}`)]),
      paragraph(["2) ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき: ", math(String.raw`c \in \mathbb{C}^\times`), " として"]),
      displayMath(String.raw`v_{\pm,\mu} = c \begin{pmatrix} \pm i\,\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)} \\ \gamma_2(-\theta_\mu) \end{pmatrix}`),
      paragraph(["証明."]),
      paragraph([math(String.raw`A(\theta_\mu)`), " の定義"]),
      displayMath(String.raw`A(\theta_\mu) :=
\begin{pmatrix}
c_1 c_2^* - s_1 s_2^*\cos\theta_\mu & i \exp(i\theta_\mu) s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2) \\
-i \exp(-i\theta_\mu) s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2) & c_1 c_2^* - s_1 s_2^*\cos\theta_\mu
\end{pmatrix}`),
      paragraph(["において ", math(String.raw`\gamma_1(\theta_\mu) := c_1 c_2^* - s_1 s_2^*\cos\theta_\mu`), "、", math(String.raw`\gamma_2(\theta_\mu) := i \exp(i\theta_\mu) s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)`), " とおくと、"]),
      displayMath(String.raw`A(\theta_\mu) = \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}`),
      paragraph(["とかける。ゆえに固有方程式は ", math(String.raw`\lambda \in \mathbb{C}`), " として"]),
      displayMath(String.raw`|A(\theta_\mu) - \lambda I| = 0`),
      displayMath(String.raw`\begin{aligned}
\text{(左辺)}
&= \begin{vmatrix} \gamma_1(\theta_\mu) - \lambda & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) - \lambda \end{vmatrix}
&& (\because\ A(\theta_\mu)\ \text{の成分表示}) \\
&= (\gamma_1(\theta_\mu) - \lambda)(\gamma_1(\theta_\mu) - \lambda) - \gamma_2(\theta_\mu)(-\gamma_2(-\theta_\mu))
&& (\because\ 2\times2\ \text{行列の行列式の定義}) \\
&= (\gamma_1(\theta_\mu) - \lambda)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{同じ元の積は 2 乗であり、負元を引くことは元を足すこと}) \\
&= \gamma_1(\theta_\mu)^2 - 2\lambda\gamma_1(\theta_\mu) + \lambda^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{平方の展開と複素数の積の可換則})
\end{aligned}`),
      paragraph(["より"]),
      displayMath(String.raw`\lambda^2 - 2\lambda\gamma_1(\theta_\mu) + \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 0`),
      paragraph(["である。以下の鎖の第 4 の等号では、根号の中の ", math(String.raw`4`), " が正の実数で偏角が ", math(String.raw`0`), " であることから ", ref("condition_of_commutativity_of_sqrt_and_product"), " を用いる。"]),
      displayMath(String.raw`\begin{aligned}
\lambda
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{(-2\gamma_1(\theta_\mu))^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ \text{2 次方程式の解の公式。係数は}\ a=1,\ b=-2\gamma_1(\theta_\mu),\ c=\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) \\
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{4\gamma_1(\theta_\mu)^2 - 4(\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ (-2\gamma_1(\theta_\mu))^2 = 4\gamma_1(\theta_\mu)^2\ \text{（負元の 2 乗は 2 乗、積の 2 乗）}) \\
&= \frac{2\gamma_1(\theta_\mu) \pm \sqrt{4\bigl(\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))\bigr)}}{2}
&& (\because\ \text{分配則で}\ 4\ \text{をくくる}) \\
&= \frac{2\gamma_1(\theta_\mu) \pm 2\sqrt{\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}}{2}
&& (\because\ \text{「sqrt と積が可換になる条件」より}\ \sqrt{4z}=\sqrt{4}\,\sqrt{z}=2\sqrt{z}) \\
&= \gamma_1(\theta_\mu) \pm \sqrt{\gamma_1(\theta_\mu)^2 - (\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))}
&& (\because\ \text{分子の各項と分母を}\ 2\ \text{で約分}) \\
&= \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \text{同じ元}\ \gamma_1(\theta_\mu)^2\ \text{を引いて消す})
\end{aligned}`),
      paragraph(["を得る。対応する固有ベクトルは ", math(String.raw`v := \begin{pmatrix} v_1 \\ v_2 \end{pmatrix} \in \mathbb{C}^2`), " として ", math(String.raw`A(\theta_\mu) v = \lambda v`), " すなわち ", math(String.raw`(A(\theta_\mu) - \lambda I)v = 0`), " を解けばよい。", math(String.raw`\lambda = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), " を代入すると対角成分は ", math(String.raw`\gamma_1(\theta_\mu) - (\gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}) = \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), " となり、"]),
      displayMath(String.raw`\begin{pmatrix}
\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0 \quad \cdots (*)`),
      paragraph(["1) ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき："]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " より ", math(String.raw`\gamma_2(-\theta_\mu) = 0`), "（", "〔relation_of_gamma_2〕", "）、かつ ", math(String.raw`\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} = 0`), " であるから ", math(String.raw`(*)`), " は"]),
      displayMath(String.raw`\begin{pmatrix} 0 & 0 \\ 0 & 0 \end{pmatrix}\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0`),
      paragraph(["となり、", math(String.raw`v`), " は ", math(String.raw`\mathbb{C}^2 \setminus \{0\}`), " の任意のベクトルをとる。この場合 ", math(String.raw`A(\theta_\mu) = I`), "（", math(String.raw`2 \times 2`), " 単位行列）となる（証明は ", "〔A_theta_is_identity_when_gamma2_zero〕", " を参照）。"]),
      paragraph(["2) ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき："]),
      paragraph([math(String.raw`\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`), " だから、", math(String.raw`(*)`), " の第 1 行に ", math(String.raw`\gamma_2(-\theta_\mu)/(\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})`), " を掛ける行基本変形を行うと、"]),
      displayMath(String.raw`\begin{aligned}
&\begin{pmatrix}
\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\dfrac{\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}
& \gamma_2(\theta_\mu)\cdot\dfrac{\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{第 1 行を零でない複素数で定数倍する行基本変形}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}{\mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{第 1 行の第 1 成分を約分し、第 2 成分の分子をまとめた}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \mp\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{z}\,\sqrt{z}=z\ \text{と}\ -z=(-1_{\mathbb{C}})z)
\end{aligned}`),
      paragraph(["ここで ", math(String.raw`\arg^{[0,2\pi)}(-1_{\mathbb{C}}) + \arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) = 2\pi`), "（負の実数 ", math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`), " の偏角は ", math(String.raw`\pi`), "、", "〔arg_of_gamma_2_mu〕", "）であるから、", ref("condition_of_commutativity_of_sqrt_and_product"), " より ", math(String.raw`\sqrt{-1_{\mathbb{C}}\cdot\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} = -\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), "。これを代入して符号 ", math(String.raw`\mp(-\,\cdot\,) = \pm(\,\cdot\,)`), " を整理すると、"]),
      displayMath(String.raw`\begin{aligned}
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\mp(-\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})} \\
-\gamma_2(-\theta_\mu) & \mp(-\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{根号と積が可換になる条件を分母と第 2 行へ代入した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \mp(-x)=\pm x\ \text{として符号を整理した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\pm\sqrt{-1_{\mathbb{C}}}} \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\ne0\ \text{なので約分した})
\end{aligned}`),
      paragraph(["さらに ", math(String.raw`\dfrac{1}{\pm x} = \pm\dfrac{1}{x}`), " と、", ref("inverse_of_sqrt_cc"), " および ", math(String.raw`0 < \arg^{[0,2\pi)}(-1_{\mathbb{C}}) = \pi < 2\pi`), " による ", math(String.raw`\dfrac{1_{\mathbb{C}}}{\sqrt{-1_{\mathbb{C}}}} = -\sqrt{\dfrac{1_{\mathbb{C}}}{-1_{\mathbb{C}}}} = -\sqrt{-1_{\mathbb{C}}}`), " を用いると、"]),
      displayMath(String.raw`\begin{aligned}
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \pm\left(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\dfrac{1_{\mathbb{C}}}{\sqrt{-1_{\mathbb{C}}}}\right) \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ 1/(\pm x)=\pm(1/x)\ \text{として逆数を積へ書き直した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp\left(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot\sqrt{-1_{\mathbb{C}}}\right) \\
-\gamma_2(-\theta_\mu) & \pm\sqrt{-1_{\mathbb{C}}}\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \text{複素平方根の逆数の公式を代入し、符号を整理した}) \\[4pt]
&\begin{pmatrix}
\gamma_2(-\theta_\mu) & \mp i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
-\gamma_2(-\theta_\mu) & \pm i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
\end{pmatrix}
\begin{pmatrix} v_1 \\ v_2 \end{pmatrix} = 0
&& (\because\ \sqrt{-1_{\mathbb{C}}}=i\ \text{と複素数の積の可換則})
\end{aligned}`),
      paragraph(["第 1 行 ", math(String.raw`\gamma_2(-\theta_\mu)\,v_1 \mp i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,v_2 = 0`), " より、", math(String.raw`c \in \mathbb{C}^\times`), " として"]),
      displayMath(String.raw`v = c \begin{pmatrix} \pm i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\ \gamma_2(-\theta_\mu) \end{pmatrix}`),
    ],
  },
  {
    id: "note_Athetatilde_005_claim_diagonalization_integer_route_TV1_hatZ_hatY_028_claim_P_mu_D_mu",
    targets: ["diagonalization_check_P_D"],
    title: { tex: String.raw`A(\theta_\mu) \text{ の対角化 } (P_\mu,\, D_\mu)` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/027_claim_A_thetaの対角化_P_muとD_mu.typ", ordinal: 28 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_028_claim_P_mu_D_mu。labels: diagonalization_P_D。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M \in \mathbb{Z}_{\geq 1}`), "、", math(String.raw`\mu \in \mathcal{M}`), "、", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき、", "〔eigenvector_of_A_theta〕", " の任意定数を ", math(String.raw`c = \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`), " と選んで、"]),
      displayMath(String.raw`P_\mu
:= \begin{pmatrix}
\dfrac{+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
& \dfrac{-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)} \\[8pt]
\dfrac{1}{2\sqrt{M}} & \dfrac{1}{2\sqrt{M}}
\end{pmatrix},
\quad
D_\mu := \begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix}`),
      paragraph(["とおく。このとき ", math(String.raw`\det P_\mu \neq 0`), " であり（したがって ", math(String.raw`P_\mu^{-1}`), " が存在し）、"]),
      displayMath(String.raw`\det P_\mu = \frac{i\,\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2M\,\gamma_2(-\theta_\mu)} \neq 0_{\mathbb{C}},
\qquad A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき ", math(String.raw`A(\theta_\mu) = I`), "（単位行列）。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: ", math(String.raw`P_\mu`), " の各成分が定義される（分母が ", math(String.raw`0`), " でない）こと。仮定 ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " と ", "〔relation_of_gamma_2〕", " の ", math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`), " より ", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), "（複素共役は ", math(String.raw`0`), " を ", math(String.raw`0`), " にしか写さない）。また ", math(String.raw`M \in \mathbb{Z}_{\geq 1}`), " より ", math(String.raw`\sqrt{M} > 0`), "。よって ", math(String.raw`2\sqrt{M}\,\gamma_2(-\theta_\mu) \neq 0`), " であり、", math(String.raw`P_\mu`), " の 4 成分はすべて定まる。"]),
      paragraph(["Step 2: ", math(String.raw`P_\mu`), " の 2 つの列が ", "〔eigenvector_of_A_theta〕", " の固有ベクトルであること。", "〔eigenvector_of_A_theta〕", " の固有ベクトルは任意定数 ", math(String.raw`c \in \mathbb{C}^\times`), " を用いて ", math(String.raw`v_{\pm,\mu} = c\bigl(\pm i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)},\ \gamma_2(-\theta_\mu)\bigr)^{\mathsf{T}}`), " であった。Step 1 より ", math(String.raw`c := \dfrac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)} \in \mathbb{C}^\times`), " と選べて、このとき第 2 成分は ", math(String.raw`c\,\gamma_2(-\theta_\mu) = \dfrac{1}{2\sqrt{M}}`), " となり、", math(String.raw`v_{+,\mu}, v_{-,\mu}`), " はそれぞれ上に書いた ", math(String.raw`P_\mu`), " の第 1 列・第 2 列に一致する。すなわち"]),
      displayMath(String.raw`A(\theta_\mu)\,v_{\pm,\mu} = \lambda_{\pm,\mu}\,v_{\pm,\mu}
\quad\Longrightarrow\quad
A(\theta_\mu)\,P_\mu = P_\mu D_\mu`),
      paragraph(["（右の等式は、行列の積を列ごとに見れば左辺の第 1 列が ", math(String.raw`A(\theta_\mu)v_{+,\mu} = \lambda_{+,\mu}v_{+,\mu}`), "、右辺の第 1 列が ", math(String.raw`v_{+,\mu}\lambda_{+,\mu}`), " で一致すること、第 2 列も同様であることによる。）"]),
      paragraph(["Step 3: ", math(String.raw`\det P_\mu`), " の計算。以下 ", math(String.raw`t := \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \in \mathbb{C}`), " と略記する。", math(String.raw`2 \times 2`), " 行列の行列式の定義より"]),
      displayMath(String.raw`\begin{aligned}
\det P_\mu
&= \frac{+i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\cdot\frac{1}{2\sqrt{M}}
 - \frac{-i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\cdot\frac{1}{2\sqrt{M}}
&& (\because\ 2\times2\ \text{行列式の定義}) \\[4pt]
&= \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
 - \frac{-i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{分数の積は、分子の積を分母の積で割ったもの}) \\[4pt]
&= \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
 + \frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{分子の負号を分数の外へ出し、負元を引くことは加えること}) \\[4pt]
&= 2\cdot\frac{i\,t}{2\sqrt{M}\,\gamma_2(-\theta_\mu)\cdot 2\sqrt{M}}
&& (\because\ \text{同じ項を 2 つ加えることは 2 倍すること}) \\[4pt]
&= 2\cdot\frac{i\,t}{4M\,\gamma_2(-\theta_\mu)}
&& (\because\ \text{積の可換性と}\ (2\sqrt{M})\cdot(2\sqrt{M})=4M\text{（}\sqrt{M}\ \text{の 2 乗は}\ M\text{）}) \\[4pt]
&= \frac{i\,t}{2M\,\gamma_2(-\theta_\mu)}
&& (\because\ \text{分子と分母を 2 で約分})
\end{aligned}`),
      paragraph(["Step 4: ", math(String.raw`\det P_\mu \neq 0`), "。", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`), " であり、仮定 ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " より ", math(String.raw`|\gamma_2(\theta_\mu)|^2 > 0`), " であるから ", math(String.raw`t^2 = -|\gamma_2(\theta_\mu)|^2 \neq 0_{\mathbb{C}}`), "、ゆえに ", math(String.raw`t \neq 0_{\mathbb{C}}`), "。さらに ", math(String.raw`i \neq 0`), "、", math(String.raw`2M \neq 0`), "（", math(String.raw`M \geq 1`), "）、Step 1 より ", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), "。", math(String.raw`\mathbb{C}`), " は体（", ref("complex_numbers_form_a_field"), "）ゆえ零因子を持たないから"]),
      displayMath(String.raw`\det P_\mu = \frac{i\,t}{2M\,\gamma_2(-\theta_\mu)} \neq 0_{\mathbb{C}}`),
      paragraph(["Step 5: 対角化。", math(String.raw`\det P_\mu \neq 0`), " より ", math(String.raw`P_\mu`), " は可逆であり ", math(String.raw`P_\mu^{-1}`), " が存在する。Step 2 の ", math(String.raw`A(\theta_\mu)P_\mu = P_\mu D_\mu`), " の両辺に右から ", math(String.raw`P_\mu^{-1}`), " を掛けて"]),
      displayMath(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`),
      paragraph(["Step 6: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " の場合。この場合は ", math(String.raw`P_\mu`), " が定義されない（Step 1 の分母が ", math(String.raw`0`), " になる）が、", "〔A_theta_is_identity_when_gamma2_zero〕", " より ", math(String.raw`A(\theta_\mu) = I`), " であって対角化は不要である。"]),
    ],
  },
  {
    id: "note_Athetatilde_005_claim_diagonalization_integer_route_TV1_hatZ_hatY_029_claim_a_theta_mu",
    targets: ["diagonalization_check_P_D"],
    title: { tex: String.raw`a(\theta_\mu)` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/028_claim_a_theta_mu.typ", ordinal: 29 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_029_claim_a_theta_mu。labels: equation_of_a_theta_mu。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " のとき、"]),
      displayMath(String.raw`\alpha_1 := \tanh K_1 \tanh K_2^*, \quad
\alpha_2 := (\tanh K_1)^{-1} \tanh K_2^*`),
      displayMath(String.raw`a(\theta_\mu)
:= \sqrt{\frac{(1 - \alpha_1 \exp(i\theta_\mu))(1 - \alpha_2^{-1} \exp(i\theta_\mu))}{(1 - \alpha_1 \exp(-i\theta_\mu))(1 - \alpha_2^{-1} \exp(-i\theta_\mu))}}`),
      paragraph(["と定めるとき、"]),
      displayMath(String.raw`a(\theta_\mu) = \sqrt{\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}
= \begin{cases}
\dfrac{\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
& \bigl(0 \leq \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu)) \leq \tfrac{\pi}{2}
  \text{ or } \tfrac{3\pi}{2} < \cdots < 2\pi\bigr) \\[6pt]
-\dfrac{\sqrt{\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
& \bigl(\tfrac{\pi}{2} < \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu)) \leq \tfrac{3\pi}{2}\bigr)
\end{cases}`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、以下 ", math(String.raw`\varphi := \arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))`), " と略記する。"]),
      paragraph(["Part A: ", math(String.raw`\dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}`), " と ", math(String.raw`\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}`), " の関係。"]),
      paragraph(["Step 1: ", ref("range_of_args_of_square_of_complex_numbers"), " より、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2)
= \begin{cases}
2\varphi & (0 \leq \varphi < \pi) \\
2\varphi - 2\pi & (\pi \leq \varphi < 2\pi)
\end{cases}`),
      paragraph(["特に、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0 \iff \varphi \in \{0, \pi\}`),
      paragraph(["Step 2: ", "〔arg_of_gamma_2_mu〕", " より、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) = \pi`),
      paragraph(["Step 3: ", ref("range_of_args_of_reciprocal_of_complex_numbers"), " より、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right)
= \begin{cases}
0 & (\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0) \\
2\pi - \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) & (0 < \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) < 2\pi)
\end{cases}`),
      paragraph(["Step 1 の結果を代入すると、"]),
      displayMath(String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right)
= \begin{cases}
0 & (\varphi = 0) \\
2\pi - 2\varphi & (0 < \varphi < \pi) \\
0 & (\varphi = \pi) \\
4\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}`),
      paragraph(["Step 4: 偏角の和は"]),
      displayMath(String.raw`\begin{aligned}
&\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)) + \arg^{[0,2\pi)}\!\left(\frac{1}{(\gamma_2(-\theta_\mu))^2}\right) \\
&= \pi + \begin{cases}
0 & (\varphi = 0) \\
2\pi - 2\varphi & (0 < \varphi < \pi) \\
0 & (\varphi = \pi) \\
4\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}
&& (\because\ \text{Step 2 と Step 3}) \\
&= \begin{cases}
\pi & (\varphi = 0) \\
3\pi - 2\varphi & (0 < \varphi < \pi) \\
\pi & (\varphi = \pi) \\
5\pi - 2\varphi & (\pi < \varphi < 2\pi)
\end{cases}
&& (\because\ \text{各場合で}\ \pi\ \text{を足す})
\end{aligned}`),
      paragraph(["Step 5: 和（以下 ", math(String.raw`\text{sum}`), " と書く）が ", math(String.raw`[0,2\pi)`), " と ", math(String.raw`[2\pi,4\pi)`), " のどちらに入るかを判定する。"]),
      displayMath(String.raw`\begin{aligned}
\varphi = 0 &\Rightarrow \text{sum} = \pi \in [0,2\pi)
&& (\because\ \text{Step 4 の第 1 の場合と}\ 0 \leq \pi < 2\pi) \\
0 < \varphi < \tfrac{\pi}{2} &\Rightarrow 2\pi < 3\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 2 の場合。各辺を}\ {-2}\ \text{倍して}\ 3\pi\ \text{を足すと不等号の向きが反転し、}(2\pi,3\pi) \subset [2\pi,4\pi)) \\
\varphi = \tfrac{\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 2 の場合へ}\ \varphi=\tfrac{\pi}{2}\ \text{を代入すると}\ 3\pi-\pi=2\pi) \\
\tfrac{\pi}{2} < \varphi < \pi &\Rightarrow \pi < 3\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi)
&& (\because\ \text{Step 4 の第 2 の場合。各辺を}\ {-2}\ \text{倍して}\ 3\pi\ \text{を足すと不等号の向きが反転し、}(\pi,2\pi) \subset [0,2\pi)) \\
\varphi = \pi &\Rightarrow \text{sum} = \pi \in [0,2\pi)
&& (\because\ \text{Step 4 の第 3 の場合と}\ 0 \leq \pi < 2\pi) \\
\pi < \varphi < \tfrac{3\pi}{2} &\Rightarrow 2\pi < 5\pi - 2\varphi < 3\pi \Rightarrow \text{sum} \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 4 の場合。各辺を}\ {-2}\ \text{倍して}\ 5\pi\ \text{を足すと不等号の向きが反転し、}(2\pi,3\pi) \subset [2\pi,4\pi)) \\
\varphi = \tfrac{3\pi}{2} &\Rightarrow \text{sum} = 2\pi \in [2\pi,4\pi)
&& (\because\ \text{Step 4 の第 4 の場合へ}\ \varphi=\tfrac{3\pi}{2}\ \text{を代入すると}\ 5\pi-3\pi=2\pi) \\
\tfrac{3\pi}{2} < \varphi < 2\pi &\Rightarrow \pi < 5\pi - 2\varphi < 2\pi \Rightarrow \text{sum} \in [0,2\pi)
&& (\because\ \text{Step 4 の第 4 の場合。各辺を}\ {-2}\ \text{倍して}\ 5\pi\ \text{を足すと不等号の向きが反転し、}(\pi,2\pi) \subset [0,2\pi))
\end{aligned}`),
      paragraph(["以上をまとめると、"]),
      displayMath(String.raw`\begin{cases}
0 \leq \text{sum} < 2\pi & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
2\pi \leq \text{sum} < 4\pi & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}`),
      paragraph(["Step 6: ", ref("condition_of_commutativity_of_sqrt_and_product"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
&= \begin{cases}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (0 \leq \text{sum} < 2\pi) \\
-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (2\pi \leq \text{sum} < 4\pi)
\end{cases}
&& (\because\ \text{根号と積の交換条件}) \\
&= \begin{cases}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot\dfrac{1}{(\gamma_2(-\theta_\mu))^2}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \text{Step 5 の 2 つの場合の記述}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \gamma_2(-\theta_\mu)\ne0\ \text{なので、分子と分母の共通因子}\ \gamma_2(-\theta_\mu)\ \text{を各場合で約分})
\end{aligned}`),
      paragraph(["Step 7: ", ref("square_of_sqrt"), " より ", math(String.raw`\sqrt{(\gamma_2(-\theta_\mu))^2} = \begin{cases}\gamma_2(-\theta_\mu) & (0 \leq \varphi < \pi) \\ -\gamma_2(-\theta_\mu) & (\pi \leq \varphi < 2\pi)\end{cases}`), "、また ", ref("inverse_of_sqrt_cc"), " より"]),
      displayMath(String.raw`\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
= \begin{cases}
\dfrac{1}{\sqrt{(\gamma_2(-\theta_\mu))^2}} & (\arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) = 0) \\
-\dfrac{1}{\sqrt{(\gamma_2(-\theta_\mu))^2}} & (0 < \arg^{[0,2\pi)}((\gamma_2(-\theta_\mu))^2) < 2\pi)
\end{cases}`),
      paragraph(["Step 1 の結果と合わせて場合分けすると、"]),
      displayMath(String.raw`\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}
= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)} & (\varphi = 0) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)} & (0 < \varphi < \pi) \\
-\dfrac{1}{-\gamma_2(-\theta_\mu)} & (\varphi = \pi) \\
-\left(-\dfrac{1}{-\gamma_2(-\theta_\mu)}\right) & (\pi < \varphi < 2\pi)
\end{cases}
= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)} & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)} & (0 < \varphi \leq \pi)
\end{cases}`),
      paragraph(["Step 8: Step 6 と Step 7 を組み合わせる。準備として、Step 7 の等式の両辺へ ", math(String.raw`\gamma_2(-\theta_\mu)`), " を掛けた等式を作る。"]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)
&= \begin{cases}
\dfrac{1}{\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu) & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-\dfrac{1}{\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu) & (0 < \varphi \leq \pi)
\end{cases}
&& (\because\ \text{Step 7 の 2 つの場合の記述}) \\
&= \begin{cases}
1 & (\varphi = 0 \text{ or } \pi < \varphi < 2\pi) \\
-1 & (0 < \varphi \leq \pi)
\end{cases}
&& (\because\ \gamma_2(-\theta_\mu)\ne0\ \text{と逆数との積})
\end{aligned}`),
      paragraph(["準備の等式の左辺は各場合で ", math(String.raw`\pm1`), " であり零でない。そこで、"]),
      displayMath(String.raw`\begin{aligned}
\frac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)}
&= \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\left(\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\right)^{-1}
&& \left(\because\ \sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\ne0\ \text{と}\ \mathbb{C}\ \text{の積の可換性から}\ \sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\,\bigl(\sqrt{\tfrac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\bigr)^{-1}=\tfrac{1}{\gamma_2(-\theta_\mu)}\right) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\varphi = 0 \text{ or } \tfrac{\pi}{2} < \varphi \leq \pi \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 < \varphi \leq \tfrac{\pi}{2} \text{ or } \pi < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
\cdot\left(\sqrt{\frac{1}{(\gamma_2(-\theta_\mu))^2}}\,\gamma_2(-\theta_\mu)\right)^{-1}
&& (\because\ \text{Step 6}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\varphi = 0) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1)^{-1} & (0 < \varphi \leq \tfrac{\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1)^{-1} & (\tfrac{\pi}{2} < \varphi \leq \pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\pi < \varphi \leq \tfrac{3\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1^{-1} & (\tfrac{3\pi}{2} < \varphi < 2\pi)
\end{cases}
&& (\because\ \text{準備の等式。2 つの場合分けを}\ \varphi\ \text{の区間の共通細分（5 区間）で重ねた}) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\varphi = 0) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (0 < \varphi \leq \tfrac{\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot(-1) & (\tfrac{\pi}{2} < \varphi \leq \pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\pi < \varphi \leq \tfrac{3\pi}{2}) \\
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}\cdot 1 & (\tfrac{3\pi}{2} < \varphi < 2\pi)
\end{cases}
&& (\because\ 1^{-1}=1\ \text{と}\ (-1)^{-1}=-1) \\
&= \begin{cases}
\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (0 \leq \varphi \leq \tfrac{\pi}{2} \text{ or } \tfrac{3\pi}{2} < \varphi < 2\pi) \\
-\sqrt{\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}} & (\tfrac{\pi}{2} < \varphi \leq \tfrac{3\pi}{2})
\end{cases}
&& (\because\ \text{各場合の符号の積の計算と、同符号の区間の合併})
\end{aligned}`),
      paragraph(["Part B: ", math(String.raw`\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}`), " の ", math(String.raw`\alpha_1, \alpha_2`), " 表式への変換。以下では ", math(String.raw`\dfrac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}`), " が ", math(String.raw`a(\theta_\mu)`), " の定義式の ", math(String.raw`\sqrt{\ }`), " の中身に等しいことを示す。"]),
      paragraph(["Steps 9–11: ", math(String.raw`\gamma_2`), " の定義を代入し、偶奇性を使って共通因子を約分する。"]),
      displayMath(String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{i\,\exp(i\theta_\mu)s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,\exp(-i\theta_\mu)s_2^*(c_1\cos(-\theta_\mu) - i\sin(-\theta_\mu) - s_1 c_2)}
&& (\because\ \gamma_2\ \text{の定義を分子と分母へ代入}) \\
&= \frac{i\,\exp(i\theta_\mu)s_2^*(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{i\,\exp(-i\theta_\mu)s_2^*(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}
&& (\because\ \cos(-\theta_\mu)=\cos\theta_\mu\ \text{かつ}\ \sin(-\theta_\mu)=-\sin\theta_\mu) \\
&= \frac{\exp(i\theta_\mu)(c_1\cos\theta_\mu - i\sin\theta_\mu - s_1 c_2)}{\exp(-i\theta_\mu)(c_1\cos\theta_\mu + i\sin\theta_\mu - s_1 c_2)}
&& (\because\ i\,s_2^*\ne0\ \text{なので分子と分母の共通因子を約分})
\end{aligned}`),
      paragraph(["Step 12: ", ref("euler_formula_cos_sin"), " より ", math(String.raw`\cos\theta_\mu = \dfrac{\exp(i\theta_\mu) + \exp(-i\theta_\mu)}{2}`), "、", math(String.raw`\sin\theta_\mu = \dfrac{\exp(i\theta_\mu) - \exp(-i\theta_\mu)}{2i}`), " を用いると、"]),
      displayMath(String.raw`\begin{aligned}
c_1\cos\theta_\mu - i\sin\theta_\mu
&= c_1\frac{\exp(i\theta_\mu) + \exp(-i\theta_\mu)}{2} - i\cdot\frac{\exp(i\theta_\mu) - \exp(-i\theta_\mu)}{2i}
&& (\because\ \text{「$\cos,\sin$ の Euler 表示」の }\cos\theta_\mu\text{ と }\sin\theta_\mu\text{ の表式を代入}) \\
&= c_1\frac{\exp(i\theta_\mu) + \exp(-i\theta_\mu)}{2} - \frac{\exp(i\theta_\mu) - \exp(-i\theta_\mu)}{2}
&& (\because\ i\cdot\tfrac{1}{2i}=\tfrac{1}{2}\text{。共通因子}\ i\ne0\ \text{の約分}) \\
&= \frac{(c_1 - 1)\exp(i\theta_\mu) + (c_1 + 1)\exp(-i\theta_\mu)}{2}
&& (\because\ \text{分配則で}\ \exp(i\theta_\mu),\ \exp(-i\theta_\mu)\ \text{の係数をまとめる})
\end{aligned}`),
      paragraph(["もう 1 本も同じ 3 段で計算する。"]),
      displayMath(String.raw`\begin{aligned}
c_1\cos\theta_\mu + i\sin\theta_\mu
&= c_1\frac{\exp(i\theta_\mu) + \exp(-i\theta_\mu)}{2} + i\cdot\frac{\exp(i\theta_\mu) - \exp(-i\theta_\mu)}{2i}
&& (\because\ \text{「$\cos,\sin$ の Euler 表示」の }\cos\theta_\mu\text{ と }\sin\theta_\mu\text{ の表式を代入}) \\
&= c_1\frac{\exp(i\theta_\mu) + \exp(-i\theta_\mu)}{2} + \frac{\exp(i\theta_\mu) - \exp(-i\theta_\mu)}{2}
&& (\because\ i\cdot\tfrac{1}{2i}=\tfrac{1}{2}\text{。共通因子}\ i\ne0\ \text{の約分}) \\
&= \frac{(c_1 + 1)\exp(i\theta_\mu) + (c_1 - 1)\exp(-i\theta_\mu)}{2}
&& (\because\ \text{分配則で}\ \exp(i\theta_\mu),\ \exp(-i\theta_\mu)\ \text{の係数をまとめる})
\end{aligned}`),
      paragraph(["Step 13: 分子分母へ代入し整理すると、"]),
      displayMath(String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&= \frac{\exp(i\theta_\mu)\left(\dfrac{(c_1 - 1)\exp(i\theta_\mu) + (c_1 + 1)\exp(-i\theta_\mu)}{2} - s_1 c_2\right)}{\exp(-i\theta_\mu)\left(\dfrac{(c_1 + 1)\exp(i\theta_\mu) + (c_1 - 1)\exp(-i\theta_\mu)}{2} - s_1 c_2\right)}
&& (\because\ \text{Steps 9--11 の比へ Step 12 の 2 つの計算結果を代入}) \\
&= \frac{\exp(i\theta_\mu)\left((c_1 - 1)\exp(i\theta_\mu) + (c_1 + 1)\exp(-i\theta_\mu) - 2 s_1 c_2\right)}{\exp(-i\theta_\mu)\left((c_1 + 1)\exp(i\theta_\mu) + (c_1 - 1)\exp(-i\theta_\mu) - 2 s_1 c_2\right)}
&& (\because\ \text{分子と分母の括弧内を共通分母 }2\text{ へ通分し、共通因子 }\tfrac12\text{ を約分}) \\
&= \frac{(c_1 - 1)\exp(2i\theta_\mu) + (c_1 + 1) - 2 s_1 c_2\, \exp(i\theta_\mu)}{(c_1 + 1) + (c_1 - 1)\exp(-2i\theta_\mu) - 2 s_1 c_2\, \exp(-i\theta_\mu)}
&& (\because\ \text{分配則と }\exp(i\theta_\mu)\exp(-i\theta_\mu)=\exp(-i\theta_\mu)\exp(i\theta_\mu)=1)
\end{aligned}`),
      paragraph(["Step 14: ", math(String.raw`x := \exp(i\theta_\mu)`), " とおく（", math(String.raw`x\,\exp(-i\theta_\mu) = \exp(i\theta_\mu)\exp(-i\theta_\mu) = 1`), " より ", math(String.raw`x \neq 0`), " であり、", math(String.raw`x^{-1} = \exp(-i\theta_\mu)`), "）。Step 13 の分子を書き直す。"]),
      displayMath(String.raw`\begin{aligned}
(c_1 - 1)\exp(2i\theta_\mu) + (c_1 + 1) - 2 s_1 c_2\, \exp(i\theta_\mu)
&= (c_1 - 1)x^2 - 2 s_1 c_2\, x + (c_1 + 1)
&& (\because\ x\ \text{の定義と指数法則}\ \exp(2i\theta_\mu)=(\exp(i\theta_\mu))^2\text{。項を}\ x\ \text{の降冪に並べ替え}) \\
&= (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^2 - \frac{2 s_1 c_2}{c_1 + 1}x + 1\right)
&& (\because\ c_1 > 0\ \text{より}\ c_1 + 1 \neq 0\text{。各項を}\ (c_1+1)\cdot\tfrac{\text{係数}}{c_1+1}\ \text{と書き、分配則でくくる})
\end{aligned}`),
      paragraph(["分母も同じ 2 段で書き直す。"]),
      displayMath(String.raw`\begin{aligned}
(c_1 + 1) + (c_1 - 1)\exp(-2i\theta_\mu) - 2 s_1 c_2\, \exp(-i\theta_\mu)
&= (c_1 - 1)x^{-2} - 2 s_1 c_2\, x^{-1} + (c_1 + 1)
&& (\because\ x^{-1} = \exp(-i\theta_\mu)\ \text{と指数法則}\ \exp(-2i\theta_\mu)=(\exp(-i\theta_\mu))^2\text{。項を}\ x^{-1}\ \text{の降冪に並べ替え}) \\
&= (c_1 + 1)\left(\frac{c_1 - 1}{c_1 + 1}x^{-2} - \frac{2 s_1 c_2}{c_1 + 1}x^{-1} + 1\right)
&& (\because\ c_1 > 0\ \text{より}\ c_1 + 1 \neq 0\text{。各項を}\ (c_1+1)\cdot\tfrac{\text{係数}}{c_1+1}\ \text{と書き、分配則でくくる})
\end{aligned}`),
      paragraph(["Step 15: ", math(String.raw`\dfrac{c_1 - 1}{c_1 + 1} = \alpha_1\alpha_2^{-1}`), " の証明。"]),
      displayMath(String.raw`\begin{aligned}
\alpha_1\alpha_2^{-1}
&= (\tanh K_1\tanh K_2^*)\cdot((\tanh K_1)^{-1}\tanh K_2^*)^{-1}
&& (\because\ \alpha_1,\alpha_2\ \text{の定義}) \\
&= (\tanh K_1\tanh K_2^*)\cdot(\tanh K_1(\tanh K_2^*)^{-1})
&& (\because\ \text{非零な積の逆数と逆数の逆数}) \\
&= (\tanh K_1)^2\cdot\bigl(\tanh K_2^*(\tanh K_2^*)^{-1}\bigr)
&& (\because\ \text{複素数の積の可換則と結合則}) \\
&= (\tanh K_1)^2\cdot 1
&& (\because\ \tanh K_2^*\neq0\ \text{と逆数の定義}) \\
&= (\tanh K_1)^2
&& (\because\ \text{積の単位元})
\end{aligned}`),
      paragraph(["一方、"]),
      displayMath(String.raw`\begin{aligned}
\frac{c_1 - 1}{c_1 + 1}
&= \frac{\cosh 2K_1 - 1}{\cosh 2K_1 + 1}
&& (\because\ c_1=\cosh 2K_1) \\
&= \frac{2\sinh^2 K_1}{2\cosh^2 K_1}
&& (\because\ \cosh 2x-1=2\sinh^2x\ \text{と}\ \cosh 2x+1=2\cosh^2x) \\
&= \frac{\sinh^2 K_1}{\cosh^2 K_1}
&& (\because\ 2\neq0\ \text{より分子と分母の共通因子}\ 2\ \text{を約分}) \\
&= \left(\frac{\sinh K_1}{\cosh K_1}\right)^2
&& (\because\ \text{分数の積}) \\
&= (\tanh K_1)^2
&& (\because\ \tanh\ \text{の定義})
\end{aligned}`),
      paragraph(["よって、"]),
      displayMath(String.raw`\begin{aligned}
\frac{c_1 - 1}{c_1 + 1}
&= (\tanh K_1)^2
&& (\because\ \text{上の第 2 の計算}) \\
&= \alpha_1\alpha_2^{-1}
&& (\because\ \text{上の第 1 の計算を逆向きに使う})
\end{aligned}\quad \cdots (\star)`),
      paragraph(["Step 16: ", math(String.raw`\dfrac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1}`), " の証明。まず"]),
      displayMath(String.raw`\begin{aligned}
\alpha_1 + \alpha_2^{-1}
&= \tanh K_1\tanh K_2^* + \left((\tanh K_1)^{-1}\tanh K_2^*\right)^{-1}
&& (\because\ \alpha_1,\alpha_2\ \text{の定義}) \\
&= \tanh K_1\tanh K_2^* + \tanh K_1(\tanh K_2^*)^{-1}
&& (\because\ \text{積の逆元は逆元の積であり、}((\tanh K_1)^{-1})^{-1} = \tanh K_1) \\
&= \tanh K_1\left(\tanh K_2^* + (\tanh K_2^*)^{-1}\right)
&& (\because\ \text{分配則で}\ \tanh K_1\ \text{をくくり出す})
\end{aligned}`),
      paragraph(["ここで、"]),
      displayMath(String.raw`\begin{aligned}
\tanh K_2^* + (\tanh K_2^*)^{-1}
&= \frac{\sinh K_2^*}{\cosh K_2^*} + \frac{\cosh K_2^*}{\sinh K_2^*}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\sinh^2 K_2^* + \cosh^2 K_2^*}{\sinh K_2^*\cosh K_2^*}
&& (\because\ \text{通分}) \\
&= \frac{\cosh 2K_2^*}{\sinh K_2^*\cosh K_2^*}
&& (\because\ \cosh^2 x + \sinh^2 x = \cosh 2x) \\
&= \frac{2\cosh 2K_2^*}{2\sinh K_2^*\cosh K_2^*}
&& (\because\ \text{分子と分母に 2 を掛ける}) \\
&= \frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`),
      paragraph([math(String.raw`K_2^* = -\tfrac{1}{2}\log(\tanh K_2)`), " すなわち ", math(String.raw`\exp(-2K_2^*) = \tanh K_2`), " より、"]),
      displayMath(String.raw`\begin{aligned}
\sinh 2K_2^*
&= \frac{\exp(2K_2^*) - \exp(-2K_2^*)}{2}
&& (\because\ \sinh\ \text{の定義}) \\
&= \frac{(\tanh K_2)^{-1} - \tanh K_2}{2}
&& (\because\ \exp(-2K_2^*) = \tanh K_2\ \text{と、その逆数}\ \exp(2K_2^*) = (\tanh K_2)^{-1}) \\
&= \frac{\dfrac{\cosh K_2}{\sinh K_2} - \dfrac{\sinh K_2}{\cosh K_2}}{2}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\cosh^2 K_2 - \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \text{通分}) \\
&= \frac{1}{2\sinh K_2\cosh K_2}
&& (\because\ \cosh^2 x - \sinh^2 x = 1) \\
&= \frac{1}{\sinh 2K_2}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\cosh 2K_2^*
&= \frac{\exp(2K_2^*) + \exp(-2K_2^*)}{2}
&& (\because\ \cosh\ \text{の定義}) \\
&= \frac{(\tanh K_2)^{-1} + \tanh K_2}{2}
&& (\because\ \exp(-2K_2^*) = \tanh K_2\ \text{と、その逆数}\ \exp(2K_2^*) = (\tanh K_2)^{-1}) \\
&= \frac{\dfrac{\cosh K_2}{\sinh K_2} + \dfrac{\sinh K_2}{\cosh K_2}}{2}
&& (\because\ \tanh\ \text{の定義と、分数の逆数}) \\
&= \frac{\cosh^2 K_2 + \sinh^2 K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \text{通分}) \\
&= \frac{\cosh 2K_2}{2\sinh K_2\cosh K_2}
&& (\because\ \cosh^2 x + \sinh^2 x = \cosh 2x) \\
&= \frac{\cosh 2K_2}{\sinh 2K_2}
&& (\because\ 2\sinh x\cosh x = \sinh 2x)
\end{aligned}`),
      paragraph(["よって、"]),
      displayMath(String.raw`\begin{aligned}
\frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&= 2\cdot\frac{\cosh 2K_2/\sinh 2K_2}{1/\sinh 2K_2}
&& (\because\ \text{上の 2 本の計算を代入}) \\
&= 2\cosh 2K_2
&& (\because\ \text{分子と分母に}\ \sinh 2K_2\ \text{を掛ける})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\alpha_1 + \alpha_2^{-1}
&= \tanh K_1\cdot\frac{2\cosh 2K_2^*}{\sinh 2K_2^*}
&& (\because\ \text{この Step の最初の鎖と、その次の鎖}) \\
&= \tanh K_1\cdot 2\cosh 2K_2
&& (\because\ \text{直前の計算}) \\
&= 2\tanh K_1\cosh 2K_2
&& (\because\ \text{積の可換性})
\end{aligned}`),
      paragraph(["一方、"]),
      displayMath(String.raw`\begin{aligned}
\frac{2 s_1 c_2}{c_1 + 1}
&= \frac{2\sinh 2K_1\cosh 2K_2}{\cosh 2K_1 + 1}
&& (\because\ s_1, c_1, c_2\ \text{の定義}) \\
&= \frac{2\cdot 2\sinh K_1\cosh K_1\cdot\cosh 2K_2}{\cosh 2K_1 + 1}
&& (\because\ \sinh 2x = 2\sinh x\cosh x) \\
&= \frac{2\cdot 2\sinh K_1\cosh K_1\cdot\cosh 2K_2}{2\cosh^2 K_1}
&& (\because\ \cosh 2x + 1 = 2\cosh^2 x) \\
&= \frac{2\sinh K_1\cosh 2K_2}{\cosh K_1}
&& (\because\ \text{分子と分母を}\ 2\cosh K_1\ \text{で割る}) \\
&= 2\tanh K_1\cosh 2K_2
&& (\because\ \tanh\ \text{の定義})
\end{aligned}`),
      paragraph(["よって、"]),
      displayMath(String.raw`\frac{2 s_1 c_2}{c_1 + 1} = \alpha_1 + \alpha_2^{-1} \quad (\because\ \text{両者とも}\ 2\tanh K_1\cosh 2K_2\ \text{に等しい}) \quad \cdots (\star\star)`),
      paragraph(["Step 17: 因数分解の検証。", math(String.raw`(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)`), " を展開すると、"]),
      displayMath(String.raw`\begin{aligned}
(1 - \alpha_1 x)(1 - \alpha_2^{-1}x)
&= 1-\alpha_2^{-1}x-\alpha_1x+\alpha_1\alpha_2^{-1}x^2
&& (\because\ \text{分配則}) \\
&= 1-(\alpha_1+\alpha_2^{-1})x+\alpha_1\alpha_2^{-1}x^2
&& (\because\ \text{分配則}) \\
&= 1-\frac{2s_1c_2}{c_1+1}x+\frac{c_1-1}{c_1+1}x^2
&& (\because\ (\star),(\star\star))
\end{aligned}`),
      paragraph(["よって"]),
      displayMath(String.raw`\begin{aligned}
(c_1+1)(1-\alpha_1x)(1-\alpha_2^{-1}x)
&=(c_1+1)\left(1-\frac{2s_1c_2}{c_1+1}x+\frac{c_1-1}{c_1+1}x^2\right)
&& (\because\ \text{上の計算}) \\
&=(c_1+1)-2s_1c_2x+(c_1-1)x^2
&& (\because\ c_1+1\ne0\ \text{と分配則})
\end{aligned}`),
      paragraph(["これは Step 14 の分子と一致する（", math(String.raw`x = \exp(i\theta_\mu)`), "）。同様に ", math(String.raw`y := \exp(-i\theta_\mu) = x^{-1}`), " とおくと ", math(String.raw`(c_1 + 1)(1 - \alpha_1 y)(1 - \alpha_2^{-1}y) = (c_1 + 1) - 2 s_1 c_2 y + (c_1 - 1)y^2`), " が Step 14 の分母と一致する。"]),
      paragraph(["Step 18: 結論。Step 14 と Step 17 より、"]),
      displayMath(String.raw`\begin{aligned}
\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}
&=\frac{(c_1+1)(1-\alpha_1\exp(i\theta_\mu))(1-\alpha_2^{-1}\exp(i\theta_\mu))}{(c_1+1)(1-\alpha_1\exp(-i\theta_\mu))(1-\alpha_2^{-1}\exp(-i\theta_\mu))}
&& (\because\ \text{Step 14 と Step 17}) \\
&=\frac{(1-\alpha_1\exp(i\theta_\mu))(1-\alpha_2^{-1}\exp(i\theta_\mu))}{(1-\alpha_1\exp(-i\theta_\mu))(1-\alpha_2^{-1}\exp(-i\theta_\mu))}
&& (\because\ c_1+1\ne0\ \text{による約分})
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`a(\theta_\mu)`), " の定義より、"]),
      displayMath(String.raw`\begin{aligned}
a(\theta_\mu)
&=\sqrt{\frac{(1-\alpha_1\exp(i\theta_\mu))(1-\alpha_2^{-1}\exp(i\theta_\mu))}{(1-\alpha_1\exp(-i\theta_\mu))(1-\alpha_2^{-1}\exp(-i\theta_\mu))}}
&& (\because\ a(\theta_\mu)\ \text{の定義}) \\
&=\sqrt{\frac{\gamma_2(\theta_\mu)}{\gamma_2(-\theta_\mu)}}
&& (\because\ \text{上の計算})
\end{aligned}`),
      paragraph(["Part A の Step 8 の結果と合わせて、Claim のステートメントが示された。"]),
    ],
  },
  {
    id: "note_evenfermi_001_definition_check_fermi_integer_route_TV1_hatZ_hatY_030_definition_fermi",
    targets: ["def_check_fermi"],
    title: { text: "フェルミオン" },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ", ordinal: 30 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の定義ブロック TV1_hatZ_hatY_030_definition_fermi。labels: def_fermi。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " についてのみ、", math(String.raw`\psi_\mu, \psi_\mu^\dagger \in \mathrm{Mat}(2^M,\mathbb{C})`), " を"]),
      displayMath(String.raw`\begin{aligned}
\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&:= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu
&&\left(\because\ \text{定義「フェルミオン」}\right)\\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
\begin{pmatrix}
+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & -i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
\gamma_2(-\theta_\mu) & \gamma_2(-\theta_\mu)
\end{pmatrix}
&&\left(\because\ \text{主張「}A(\theta_\mu)\text{ の対角化 }(P_\mu,D_\mu)\text{」の }P_\mu\text{ の表示}\right)
\end{aligned}`),
      paragraph(["すなわち"]),
      displayMath(String.raw`\psi_\mu^\dagger
= \frac{+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\hat{Z}_\mu^{(-)}
  + \frac{1}{2\sqrt{M}}\hat{Y}_\mu`),
      displayMath(String.raw`\psi_\mu
= \frac{-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}\hat{Z}_\mu^{(-)}
  + \frac{1}{2\sqrt{M}}\hat{Y}_\mu`),
      paragraph(["と定める。"]),
      paragraph(["この定義は正規化因子 ", math(String.raw`\dfrac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`), " を含むため、", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), " すなわち ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), "（", "〔relation_of_gamma_2〕", " より両者は同値）のときにのみ意味をもつ。", math(String.raw`\gamma_2(\theta_\mu) = 0`), " となる ", math(String.raw`\mu \in \mathcal{M}`), " については ", math(String.raw`P_\mu`), "（", "〔diagonalization_P_D〕", "）が定義されず、正規化因子 ", math(String.raw`\dfrac{1}{\gamma_2(-\theta_\mu)}`), " が ", math(String.raw`0`), " 除算となるため、", math(String.raw`\psi_\mu, \psi_\mu^\dagger`), " は定義されない（存在しない）。", "〔gamma_2_theta_is_0〕", " より ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " となるのは ", math(String.raw`\mu = \pm M`), " かつ臨界条件 ", math(String.raw`c_1 = s_1 c_2`), "（", ref("critical_condition_c1_eq_s1_c2"), " より Ising 臨界点 ", math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`), " に対応）を満たす場合に限られる。特に臨界点では ", math(String.raw`\psi_M, \psi_M^\dagger`), " が存在しない。この ", math(String.raw`\mu`), " に対する ", math(String.raw`T_{(V)}, T_{(V')}`), " の作用は ", "〔T_Vprime_fixes_hatZ_hatY_when_gamma2_zero〕", " および ", "〔T_V_eq_T_Vprime_on_hatZ_hatY〕", " の場合 2 で、フェルミオンを経由せず直接扱う。"]),
    ],
  },
  {
    id: "note_evenfermi_004_claim_commutation_V_plus_psi_integer_route_TV1_hatZ_hatY_031_claim_V_psi_commutator",
    targets: ["commutation_V_plus_check_psi"],
    title: { tex: String.raw`V \text{ と } \psi \text{ の交換関係 (B.13)}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/030_claim_Vとpsiの交換関係.typ", ordinal: 31 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_031_claim_V_psi_commutator。labels: commutation_V_psi。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について（このとき ", "〔def_fermi〕", " より ", math(String.raw`\psi_\mu, \psi_\mu^\dagger`), " が定義される）、"]),
      displayMath(String.raw`T_{(V)}(\psi_\mu^\dagger)
= \Bigl(\gamma_1(\theta_\mu) + \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}\Bigr)\psi_\mu^\dagger`),
      displayMath(String.raw`T_{(V)}(\psi_\mu)
= \Bigl(\gamma_1(\theta_\mu) - \sqrt{-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)}\Bigr)\psi_\mu`),
      paragraph(["証明."]),
      paragraph(["〔def_fermi〕", " より、"]),
      displayMath(String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) \cdot P_\mu`),
      paragraph([math(String.raw`T_{(V)}`), " は ", ref("mat_conj"), " より線型写像であり、", math(String.raw`P_\mu`), " の各成分は ", math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`), " に依らない複素数なので、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}\!\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}
&= T_{(V)}\!\bigl(\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)\cdot P_\mu\bigr)
\quad (\because\ \text{フェルミオンの定義}) \\
&= \begin{pmatrix} T_{(V)}(\hat{Z}_\mu^{(-)}) & T_{(V)}(\hat{Y}_\mu) \end{pmatrix}\cdot P_\mu
\quad (\because\ T_{(V)} \text{ の線形性}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) A(\theta_\mu)\cdot P_\mu
\quad (\because\ T_{(V)}\ \text{の}\ \hat{Z}_\mu^{(-)}, \hat{Y}_\mu\ \text{への作用}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)(P_\mu D_\mu P_\mu^{-1})\cdot P_\mu
\quad (\because\ A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu D_\mu
\quad (\because\ \text{行列の積の結合則と}\ P_\mu^{-1}P_\mu = I) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} D_\mu
\quad (\because\ \text{フェルミオンの定義}) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix}\begin{pmatrix} \lambda_{+,\mu} & 0 \\ 0 & \lambda_{-,\mu} \end{pmatrix}
\quad (\because\ D_\mu\ \text{の成分}) \\
&= \begin{pmatrix} \lambda_{+,\mu}\psi_\mu^\dagger & \lambda_{-,\mu}\psi_\mu \end{pmatrix}
\quad (\because\ \text{行ベクトルと対角行列の積の成分計算}) \\
&= \begin{pmatrix} \bigl(\gamma_1(\theta_\mu) + \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu^\dagger & \bigl(\gamma_1(\theta_\mu) - \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\psi_\mu \end{pmatrix}
\quad (\because\ \lambda_{\pm,\mu}\ \text{の値})
\end{aligned}`),
      paragraph(["ここで、第 3 の等号の作用は ", "〔T_V_hatZ_hatY〕", "、第 4 の等号の対角化 ", math(String.raw`A(\theta_\mu) = P_\mu D_\mu P_\mu^{-1}`), " と第 7・第 9 の等号の ", math(String.raw`D_\mu`), " の成分・固有値 ", math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), " は ", "〔eigenvector_of_A_theta〕", " および ", "〔diagonalization_P_D〕", "、第 1・第 6 の等号は ", "〔def_fermi〕", " による。両成分を比較して主張を得る。"]),
    ],
  },
  {
    id: "note_evenfermi_003_claim_anticommutator_integer_route_TV1_hatZ_hatY_032_claim_anticommutator_psi",
    targets: ["anticommutator_of_check_psi"],
    title: { tex: String.raw`\psi \text{ の反交換関係}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/031_claim_psiの反交換関係.typ", ordinal: 32 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_032_claim_anticommutator_psi。labels: anticommutator_of_psi。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " かつ ", math(String.raw`\gamma_2(\theta_\nu) \neq 0`), " なる ", math(String.raw`\mu, \nu \in \mathcal{M}`), " について（このとき ", "〔def_fermi〕", " より ", math(String.raw`\psi_\mu, \psi_\mu^\dagger, \psi_\nu, \psi_\nu^\dagger`), " が定義される）、"]),
      displayMath(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0, \quad
[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}, \quad
[\psi_\mu, \psi_\nu]_+ = 0`),
      paragraph(["ここで ", math(String.raw`\sqrt{\cdot}`), "（", "〔def_fermi〕", " を通じて ", math(String.raw`\psi_\mu^\dagger, \psi_\mu`), " の係数に現れる）は ", ref("def_sqrt_cc"), " で定めた単一値の写像 ", math(String.raw`\sqrt{\cdot} : \mathbb{C} \to \mathbb{C}`), " である。すなわち、平方根は根号の中身だけで一意に定まる複素数であって、", math(String.raw`\mu`), " ごとに ", math(String.raw`\pm`), " を選ぶ自由度は無い。この一意性は主張の成立に不可欠であり、証明の Step 0 で明示的に使う。"]),
      paragraph(["証明."]),
      paragraph(["Step 0: 平方根の値が ", math(String.raw`\mu`), " と ", math(String.raw`\nu`), " で一致すること（分枝の一致）。以下 ", math(String.raw`t_\mu := \sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \in \mathbb{C}`), "、", math(String.raw`t_\nu := \sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} \in \mathbb{C}`), " と略記する。"]),
      paragraph(["Step 0-1: ", math(String.raw`\gamma_2`), " は ", math(String.raw`2\pi`), " 周期である。実際 ", math(String.raw`k \in \mathbb{Z}`), " と ", math(String.raw`\theta \in \mathbb{R}`), " について ", math(String.raw`\cos(\theta + 2k\pi) = \cos\theta`), "、", math(String.raw`\sin(\theta + 2k\pi) = \sin\theta`), " であり、", ref("euler_formula_cos_sin"), " の Euler の公式 ", math(String.raw`\exp(i\theta) = \cos\theta + i\sin\theta`), " より ", math(String.raw`\exp(i(\theta + 2k\pi)) = \exp(i\theta)`), "。", math(String.raw`\gamma_2(\theta) = i \exp(i\theta) s_2^*(c_1\cos\theta - i\sin\theta - s_1 c_2)`), " は ", math(String.raw`\exp(i\theta), \cos\theta, \sin\theta`), " のみを通じて ", math(String.raw`\theta`), " に依存するから、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta+2k\pi)
&=i \exp(i(\theta+2k\pi))s_2^*\bigl(c_1\cos(\theta+2k\pi)-i\sin(\theta+2k\pi)-s_1c_2\bigr)
&& (\because\ \gamma_2\ \text{の定義})\\
&=i \exp(i\theta)s_2^*\bigl(c_1\cos\theta-i\sin\theta-s_1c_2\bigr)
&& (\because\ \exp(i\theta),\cos\theta,\sin\theta\ \text{の}\ 2\pi\ \text{周期性})\\
&=\gamma_2(\theta)
&& (\because\ \gamma_2\ \text{の定義})
\end{aligned}`),
      paragraph(["Step 0-2: ", math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`), " のとき ", math(String.raw`\mu + \nu \equiv 0 \pmod{M}`), " すなわち ", math(String.raw`\nu = -\mu + kM`), " なる ", math(String.raw`k \in \mathbb{Z}`), " が存在する。このとき"]),
      displayMath(String.raw`\begin{aligned}
\theta_\nu
&=\dfrac{2\pi\nu}{M}
&& (\because\ \theta_\nu\ \text{の定義})\\
&=\dfrac{2\pi(-\mu+kM)}{M}
&& (\because\ \nu=-\mu+kM)\\
&=-\dfrac{2\pi\mu}{M}+2k\pi
&& (\because\ \mathbb{R}\ \text{の分配則と約分})\\
&=-\theta_\mu+2k\pi
&& (\because\ \theta_\mu\ \text{の定義})
\end{aligned}`),
      paragraph(["であるから、Step 0-1 より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\nu)
&=\gamma_2(-\theta_\mu+2k\pi)
&& (\because\ \theta_\nu=-\theta_\mu+2k\pi)\\
&=\gamma_2(-\theta_\mu)
&& (\because\ \gamma_2\ \text{の}\ 2\pi\ \text{周期性}),\\[3pt]
\gamma_2(-\theta_\nu)
&=\gamma_2(\theta_\mu-2k\pi)
&& (\because\ \theta_\nu=-\theta_\mu+2k\pi)\\
&=\gamma_2(\theta_\mu)
&& (\because\ \gamma_2\ \text{の}\ 2\pi\ \text{周期性})
\end{aligned}`),
      paragraph(["（", math(String.raw`\theta_\nu = -\theta_\mu + 2k\pi`), " は ", math(String.raw`\mathbb{R}`), " における等式であって ", math(String.raw`\theta_\nu = -\theta_\mu`), " とは限らない。両者が ", math(String.raw`\gamma_2`), " の値として一致するのは、Step 0-1 の周期性による。）したがって根号の中身は ", math(String.raw`\mathbb{C}`), " の元として一致する："]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)
&=\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{上の二つの等式})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`),
      paragraph(["Step 0-3: ", ref("def_sqrt_cc"), " の ", math(String.raw`\sqrt{\cdot}`), " は ", math(String.raw`\mathbb{C}`), " から ", math(String.raw`\mathbb{C}`), " への写像である。写像は等しい入力に等しい値を返すから、Step 0-2 の等式より"]),
      displayMath(String.raw`\begin{aligned}
t_\nu
&=\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
&& (\because\ t_\nu\ \text{の定義})\\
&=\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \text{根号の中身について上で得た等式})\\
&=t_\mu
&& (\because\ t_\mu\ \text{の定義})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`t_\nu`), " と ", math(String.raw`t_\mu`), " は同一の複素数である（", math(String.raw`t_\nu = -t_\mu`), " という可能性は残らない）。"]),
      paragraph(["Step 0-4: この一致は結論に不可欠である。", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = -|\gamma_2(\theta_\mu)|^2`), " であり、仮定 ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " より ", math(String.raw`|\gamma_2(\theta_\mu)|^2 > 0`), " であるから"]),
      displayMath(String.raw`\begin{aligned}
t_\mu^2
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ t_\mu\ \text{の定義と}\ (\sqrt{z})^2=z)\\
&=-|\gamma_2(\theta_\mu)|^2
&& (\because\ \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)=-|\gamma_2(\theta_\mu)|^2)\\
&\neq0_{\mathbb{C}}
&& (\because\ \gamma_2(\theta_\mu)\neq0\ \text{より}\ |\gamma_2(\theta_\mu)|^2>0),\\
t_\mu&\neq0_{\mathbb{C}}
&& (\because\ t_\mu=0_{\mathbb{C}}\ \text{ならば}\ t_\mu^2=0_{\mathbb{C}})
\end{aligned}`),
      paragraph(["後述の a) の係数の括弧は ", "次の一続きの式変形により因数分解できる。"]),
      displayMath(String.raw`\begin{aligned}
-t_\mu t_\nu+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&=-t_\mu t_\nu+\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{Step 0-2})\\
&=t_\mu^2-t_\mu t_\nu
&& (\because\ t_\mu^2=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu))\\
&=t_\mu(t_\mu-t_\nu)
&& (\because\ \mathbb{C}\ \text{の分配則})
\end{aligned}`),
      paragraph(["Step 0-3 の ", math(String.raw`t_\nu = t_\mu`), " によってのみ ", math(String.raw`0`), " になる。仮に ", math(String.raw`t_\nu = -t_\mu`), " であれば括弧は ", math(String.raw`2t_\mu^2 \neq 0`), " となり第 1 の等式は偽になる（同様に b) の括弧は ", math(String.raw`t_\mu t_\nu + t_\mu^2`), " で、", math(String.raw`t_\nu = -t_\mu`), " なら ", math(String.raw`0`), " となって第 2 の等式も偽になる）。"]),
      paragraph(["〔def_fermi〕", " より、", math(String.raw`c_\mu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}`), " とおくと"]),
      displayMath(String.raw`\begin{aligned}
\psi_\mu^\dagger &= c_\mu\bigl(+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)
&&\left(\because\ \text{定義「フェルミオン」の}\ \psi_\mu^\dagger\ \text{の表示式で}\ c_\mu\ \text{を括り出した}\right)\\
\psi_\mu &= c_\mu\bigl(-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\hat{Z}_\mu^{(-)} + \gamma_2(-\theta_\mu)\hat{Y}_\mu\bigr)
&&\left(\because\ \text{定義「フェルミオン」の}\ \psi_\mu\ \text{の表示式で}\ c_\mu\ \text{を括り出した}\right)
\end{aligned}`),
      paragraph(["である。また、", "〔anticommutator_of_hat_Z_and_hat_Y〕", " より、"]),
      displayMath(String.raw`[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}, \quad
[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ = 0, \quad
[\hat{Y}_\mu, \hat{Y}_\nu]_+ = 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
      paragraph(["である。"]),
      paragraph(["a) ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+`), " について、反交換子の双線型性より"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu^\dagger]_+
&= c_\mu c_\nu\Bigl(
(i)(i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu^\dagger,\psi_\nu^\dagger\ \text{の定義})\\
&= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ i^2=-1)
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`), " のとき、Step 0-3 の ", math(String.raw`t_\nu = t_\mu`), "（平方根が単一値であることから従う分枝の一致）を使うと"]),
      displayMath(String.raw`\begin{aligned}
\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
&=t_\mu t_\nu
&& (\because\ t_\mu,t_\nu\ \text{の定義})\\
&=t_\mu^2
&& (\because\ \text{Step 0-3 の}\ t_\nu=t_\mu)\\
&=\bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)^2
&& (\because\ t_\mu\ \text{の定義})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ (\sqrt{z})^2=z)
\end{aligned}`),
      paragraph(["（第 2 の等号が Step 0-3 の ", math(String.raw`t_\nu = t_\mu`), " である。ここを ", math(String.raw`t_\nu = \pm t_\mu`), " までしか言えないと結論は得られない。）また Step 0-2 の ", math(String.raw`\gamma_2(-\theta_\nu) = \gamma_2(\theta_\mu)`), " より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&=\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)
&& (\because\ \text{Step 0-2 の}\ \gamma_2(-\theta_\nu)=\gamma_2(\theta_\mu))\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`),
      paragraph(["したがって係数の和は"]),
      displayMath(String.raw`\begin{aligned}
&-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{上の二つの式変形})\\
&=0
&& (\because\ \mathbb{C}\ \text{の加法逆元})
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} = 0`), " のときは、先に得た反交換子の式の因子が零なので、同じ結論を得る。以上から ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0`), "。"]),
      paragraph(["b) ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+`), " について、反交換子の双線型性より"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu]_+
&= c_\mu c_\nu\Bigl(
(i)(-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,(-i)\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu^\dagger,\psi_\nu\ \text{の定義})\\
&= c_\mu c_\nu\bigl(\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ (i)(-i)=1)
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`), " のとき、a) で示した平方根の積の式変形と ", math(String.raw`\gamma_2`), " の積の式変形を使うと、係数の括弧は"]),
      displayMath(String.raw`\begin{aligned}
&\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)
&& (\because\ \text{a) の平方根の積の式変形})\\
&=\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{a) の}\ \gamma_2\ \text{の積の式変形})\\
&=2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{同じ項の和})
\end{aligned}`),
      paragraph(["である。また係数の積は"]),
      displayMath(String.raw`\begin{aligned}
c_\mu c_\nu
&=\frac{1}{4M\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)}
&& (\because\ c_\mu,c_\nu\ \text{の定義と分数の積})\\
&=\frac{1}{4M\gamma_2(-\theta_\mu)\gamma_2(\theta_\mu)}
&& (\because\ \text{Step 0-2 の}\ \gamma_2(-\theta_\nu)=\gamma_2(\theta_\mu))\\
&=\frac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}
&& (\because\ \mathbb{C}\ \text{の積の可換則})
\end{aligned}`),
      paragraph(["であるから、"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\mu^\dagger, \psi_\nu]_+
&= \frac{1}{4M\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\cdot 2\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\cdot 2M\cdot\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{上の三つの式変形})\\
&= \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{約分})
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} = 0`), " のときは、先に得た反交換子の式の因子が零なので、全体が ", math(String.raw`0`), " となり、同じ結論を得る。以上から ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}`), "。"]),
      paragraph(["c) ", math(String.raw`[\psi_\mu, \psi_\nu]_+`), " について、反交換子の双線型性より"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\mu, \psi_\nu]_+
&= c_\mu c_\nu\Bigl(
(-i)(-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Z}_\mu^{(-)}, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + (-i)\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\nu)[\hat{Z}_\mu^{(-)}, \hat{Y}_\nu]_+ \\
&\quad + \gamma_2(-\theta_\mu)\,(-i)\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}[\hat{Y}_\mu, \hat{Z}_\nu^{(-)}]_+ \\
&\quad + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)[\hat{Y}_\mu, \hat{Y}_\nu]_+
\Bigr)
&& (\because\ \text{反交換子の双線型性と}\ \psi_\mu,\psi_\nu\ \text{の定義})\\
&= c_\mu c_\nu\bigl(-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)} + \gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I_{\mathrm{Mat}(2^M,\mathbb{C})}
&& (\because\ \text{二つの交差項の反交換子は零であり、}\ (-i)(-i)=-1)
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`), " のとき、a) で示した二つの式変形を当てると、係数の括弧は"]),
      displayMath(String.raw`\begin{aligned}
&-\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}
+\gamma_2(-\theta_\mu)\gamma_2(-\theta_\nu)\\
&=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&& (\because\ \text{a) の平方根の積と}\ \gamma_2\ \text{の積の式変形})\\
&=0
&& (\because\ \mathbb{C}\ \text{の加法逆元})
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu+\nu,0} = 0`), " のときは、先に得た反交換子の式の因子が零なので、全体が ", math(String.raw`0`), " となる。以上から ", math(String.raw`[\psi_\mu, \psi_\nu]_+ = 0`), "。"]),
    ],
  },
  {
    id: "note_Athetatilde_006_claim_det_A_integer_route_TV1_hatZ_hatY_035_claim_det_A_theta",
    targets: ["det_A_theta_tilde"],
    title: { tex: String.raw`\det A(\theta_\mu) = 1` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/034_claim_det_A_theta_mu.typ", ordinal: 35 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_035_claim_det_A_theta。labels: det_A_theta。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_transfer_matrix_symbols"), " の記号のもと ", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), " とする。", math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\det A(\theta_\mu) = 1, \quad
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = 1, \quad
\lambda_{+,\mu} \cdot \lambda_{-,\mu} = 1`),
      paragraph(["証明."]),
      paragraph(["Step 0: 使う 3 つの関係式。", ref("def_transfer_matrix_symbols"), " の記号のもと、", math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), " とする。次の 3 つを使う。"]),
      displayMath(String.raw`\text{(i)}\ c_1^2 - s_1^2 = 1, \qquad
\text{(ii)}\ (c_2^*)^2 - (s_2^*)^2 = 1, \qquad
\text{(iii)}\ c_2\, s_2^* = c_2^*`),
      paragraph(["(i) は ", math(String.raw`c_1 = \cosh 2K_1`), "、", math(String.raw`s_1 = \sinh 2K_1`), " と恒等式 ", math(String.raw`\cosh^2 x - \sinh^2 x = 1`), "（", math(String.raw`x = 2K_1`), "）による。(ii) は同じ恒等式を ", math(String.raw`x = 2K_2^*`), " に適用したものである。(iii) は ", ref("duality_c2_star_eq_s2_star_c2"), " そのもの、すなわち ", math(String.raw`K_2`), " と ", math(String.raw`K_2^*`), " の双対関係 ", math(String.raw`\sinh(2K_2)\sinh(2K_2^*) = 1`), "（", ref("def_transfer_matrix_symbols"), "）の帰結 ", math(String.raw`c_2^* = s_2^*\,c_2`), " である。"]),
      paragraph(["（(iii) は ", math(String.raw`A(\theta)`), " の定義に現れる ", math(String.raw`c_2`), " と ", math(String.raw`B_2`), " に現れる ", math(String.raw`c_2^*`), " を結ぶ関係であり、これを落とすと以下の計算は成立しない。", "〔factorization_of_A_theta〕", " の分解 ", math(String.raw`A(\theta_\mu) = B_1(\theta_\mu)B_2B_1(\theta_\mu)`), " 自体がこの関係を経由して成り立っているので、ここでは分解を経由せず ", ref("def_A_theta"), " の定義から直接計算する。）"]),
      paragraph(["Step 1: ", math(String.raw`\det A(\theta_\mu)`), " の定義からの計算。", ref("def_A_theta"), " より"]),
      displayMath(String.raw`A(\theta_\mu) = \begin{pmatrix}
\gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\
-\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu)
\end{pmatrix}`),
      paragraph([math(String.raw`2 \times 2`), " 行列の行列式の定義より"]),
      displayMath(String.raw`\begin{aligned}
\det A(\theta_\mu)
&= \gamma_1(\theta_\mu)\cdot\gamma_1(\theta_\mu)
  - \gamma_2(\theta_\mu)\cdot\bigl(-\gamma_2(-\theta_\mu)\bigr)
&&\left(\because\ 2\times2\ \text{行列の行列式の定義と直前の行列表示}\right)\\
&= \gamma_1(\theta_\mu)^2
  - \bigl(-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)\bigr)
&&\left(\because\ \text{冪の定義と積の結合則}\right)\\
&= \gamma_1(\theta_\mu)^2
  + \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&&\left(\because\ a-(-b)=a+b\right)
\end{aligned}`),
      paragraph(["これで statement の第 1 の量と第 2 の量が等しいことが言えた。残りは、この値が ", math(String.raw`1`), " であることである。"]),
      paragraph(["Step 2: ", math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`), " の実部表示。以下 ", math(String.raw`u := \cos\theta_\mu \in \mathbb{R}`), "、", math(String.raw`v := \sin\theta_\mu \in \mathbb{R}`), " と略記する（", math(String.raw`u^2 + v^2 = 1`), "）。", ref("def_A_theta"), " の ", math(String.raw`\gamma_2`), " の定義より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu) &= i\,\exp(i\theta_\mu)\,s_2^*\bigl((c_1 u - s_1 c_2) - i v\bigr)
&&\left(\because\ \text{\(\gamma_2\) の定義と \(u,v\) の略記}\right)\\
\gamma_2(-\theta_\mu) &= i\,\exp(-i\theta_\mu)\,s_2^*\bigl((c_1 u - s_1 c_2) + i v\bigr)
&&\left(\because\ \cos(-\theta_\mu)=u,\ \sin(-\theta_\mu)=-v\right)
\end{aligned}`),
      paragraph(["（", math(String.raw`\cos(-\theta_\mu) = u`), "、", math(String.raw`\sin(-\theta_\mu) = -v`), " を代入した。）", math(String.raw`i \cdot i = -1`), " と ", math(String.raw`\exp(i\theta_\mu)\exp(-i\theta_\mu) = \exp(0) = 1`), "、および ", math(String.raw`(a - iv)(a + iv) = a^2 + v^2`), "（", math(String.raw`a := c_1 u - s_1 c_2 \in \mathbb{R}`), "）より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&=i^2\exp(i\theta_\mu)\exp(-i\theta_\mu)(s_2^*)^2
  \bigl((c_1u-s_1c_2)-iv\bigr)\bigl((c_1u-s_1c_2)+iv\bigr)
&&\left(\because\ \text{直前の 2 式の代入と積の結合則}\right)\\
&=-\exp(0)(s_2^*)^2
  \bigl((c_1u-s_1c_2)-iv\bigr)\bigl((c_1u-s_1c_2)+iv\bigr)
&&\left(\because\ i^2=-1,\ \exp(i\theta_\mu)\exp(-i\theta_\mu)=\exp(0)\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2-(iv)^2\Bigr)
&&\left(\because\ \exp(0)=1,\ (a-b)(a+b)=a^2-b^2\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+v^2\Bigr)
&&\left(\because\ (iv)^2=-v^2\right)\\
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+1-u^2\Bigr)
&&\left(\because\ u^2+v^2=1\right)
\end{aligned}`),
      paragraph(["Step 3: 展開。", math(String.raw`\gamma_1(\theta_\mu) = c_1 c_2^* - s_1 s_2^* u`), " より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&=\bigl(c_1c_2^*-s_1s_2^*u\bigr)^2
&&\left(\because\ \gamma_1(\theta_\mu)=c_1c_2^*-s_1s_2^*u\right)\\
&=c_1^2(c_2^*)^2-2c_1c_2^*s_1s_2^*u+s_1^2(s_2^*)^2u^2
&&\left(\because\ (a-b)^2=a^2-2ab+b^2\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&=-(s_2^*)^2\Bigl((c_1u-s_1c_2)^2+1-u^2\Bigr)
&&\left(\because\ \text{Step 2 の終点}\right)\\
&=-(s_2^*)^2\Bigl(c_1^2u^2-2c_1s_1c_2u+s_1^2c_2^2+1-u^2\Bigr)
&&\left(\because\ (a-b)^2=a^2-2ab+b^2\right)\\
&=-c_1^2(s_2^*)^2u^2+2c_1s_1c_2(s_2^*)^2u-s_1^2c_2^2(s_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2
&&\left(\because\ \text{分配則}\right)
\end{aligned}`),
      paragraph(["Step 4: (iii) による ", math(String.raw`c_2`), " の消去。(iii) ", math(String.raw`c_2 s_2^* = c_2^*`), " を使うと"]),
      displayMath(String.raw`\begin{aligned}
2 c_1 s_1 c_2 (s_2^*)^2 u
&=2 c_1 s_1 (c_2 s_2^*) s_2^* u
&&\left(\because\ (s_2^*)^2=s_2^*s_2^*\ \text{と積の結合則}\right)\\
&=2 c_1 s_1 c_2^* s_2^* u
&&\left(\because\ \text{(iii)}\ c_2s_2^*=c_2^*\right),\\[4pt]
s_1^2 c_2^2 (s_2^*)^2
&=s_1^2 (c_2 s_2^*)^2
&&\left(\because\ c_2^2(s_2^*)^2=(c_2s_2^*)^2\right)\\
&=s_1^2 (c_2^*)^2
&&\left(\because\ \text{(iii)}\ c_2s_2^*=c_2^*\right)
\end{aligned}`),
      paragraph(["これを代入して Step 3 の 2 式を足すと"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&= \bigl(c_1^2 (c_2^*)^2 - 2 c_1 c_2^* s_1 s_2^* u + s_1^2 (s_2^*)^2 u^2\bigr) \\
&\quad + \bigl(-c_1^2 (s_2^*)^2 u^2 + 2 c_1 s_1 c_2^* s_2^* u - s_1^2 (c_2^*)^2 - (s_2^*)^2 + (s_2^*)^2 u^2\bigr)
&&\left(\because\ \text{Step 3 の 2 式と直前の}\ c_2\ \text{の消去}\right)\\
&= \bigl(c_1^2 - s_1^2\bigr)(c_2^*)^2 - (s_2^*)^2
 + (s_2^*)^2 u^2\bigl(s_1^2 - c_1^2 + 1\bigr)
&&\left(\because\ u\ \text{の 1 次の項を相殺し、残る項を分配則でまとめる}\right)
\end{aligned}`),
      paragraph(["（", math(String.raw`u`), " の 1 次の項 ", math(String.raw`-2 c_1 c_2^* s_1 s_2^* u`), " と ", math(String.raw`+2 c_1 s_1 c_2^* s_2^* u`), " は相殺した。これが (iii) を使った箇所である。）"]),
      paragraph(["Step 5: (i)(ii) による結論。(i) ", math(String.raw`c_1^2 - s_1^2 = 1`), " より ", math(String.raw`s_1^2 - c_1^2 + 1 = 0`), " であるから ", math(String.raw`u^2`), " の項は消え、同じく (i) より第 1 項は ", math(String.raw`(c_2^*)^2`), " になる。よって (ii) ", math(String.raw`(c_2^*)^2 - (s_2^*)^2 = 1`), " より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&= (c_1^2-s_1^2)(c_2^*)^2-(s_2^*)^2
 +(s_2^*)^2u^2(s_1^2-c_1^2+1)
&&\left(\because\ \text{Step 4 の終点}\right)\\
&=(c_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2(-1+1)
&&\left(\because\ \text{(i)}\ c_1^2-s_1^2=1\ \text{を 2 箇所へ適用}\right)\\
&=(c_2^*)^2-(s_2^*)^2+(s_2^*)^2u^2\cdot0
&&\left(\because\ -1+1=0\right)\\
&=(c_2^*)^2-(s_2^*)^2
&&\left(\because\ a\cdot0=0,\ b+0=b\right)\\
&=1
&&\left(\because\ \text{(ii)}\ (c_2^*)^2-(s_2^*)^2=1\right)
\end{aligned}`),
      paragraph(["Step 1 と合わせて ", math(String.raw`\det A(\theta_\mu) = \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1`), "。"]),
      paragraph(["Step 6: 固有値の積。", "〔eigenvector_of_A_theta〕", " より ", math(String.raw`\lambda_{\pm,\mu} = \gamma_1(\theta_\mu) \pm \sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), " であり、", math(String.raw`(\sqrt{z})^2 = z`), "（", ref("def_sqrt_cc"), "）を ", math(String.raw`z = -\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)`), " に適用して"]),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}\,\lambda_{-,\mu}
&=\left(\gamma_1(\theta_\mu)+\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)
  \left(\gamma_1(\theta_\mu)-\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)
&&\left(\because\ \lambda_{\pm,\mu}\ \text{の式を代入}\right)\\
&=\gamma_1(\theta_\mu)^2-\left(\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\right)^2
&&\left(\because\ (a+b)(a-b)=a^2-b^2\right)\\
&=\gamma_1(\theta_\mu)^2+\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&&\left(\because\ (\sqrt{z})^2=z,\ z=-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)\right)\\
&=1
&&\left(\because\ \text{Step 5 の終点}\right)
\end{aligned}`),
      paragraph(["以上で statement の 3 つの等式がすべて示された。"]),
    ],
  },
  {
    id: "note_Athetatilde_007_claim_gamma1_gt_1_integer_route_TV1_hatZ_hatY_036_claim_gamma1_geq_1",
    targets: ["gamma1_gt_1_theta_tilde"],
    title: { tex: String.raw`\gamma_1(\theta_\mu) \geq 1` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/035_claim_gamma1_geq_1.typ", ordinal: 36 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_036_claim_gamma1_geq_1。labels: gamma1_geq_1。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\gamma_1(\theta_\mu) \geq 1`),
      paragraph(["証明."]),
      paragraph(["〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`), " すなわち ", math(String.raw`-\gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu) = |\gamma_2(\theta_\mu)|^2`), " であるから、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&= 1 - \gamma_2(\theta_\mu)\,\gamma_2(-\theta_\mu)
&& (\because\ \text{〔det\_A\_theta〕})\\
&= 1 + |\gamma_2(\theta_\mu)|^2
&& (\because\ \text{〔relation\_of\_gamma\_2〕})\\
&\geq 1
&& (\because\ |\gamma_2(\theta_\mu)|^2\geq 0)
\end{aligned}`),
      paragraph(["また、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)
&= c_1 c_2^* - s_1 s_2^*\cos\theta_\mu
&& (\because\ \gamma_1\ \text{の定義})\\
&\geq c_1 c_2^* - s_1 s_2^*
&& (\because\ \cos\theta_\mu\leq 1)\\
&> 0
&& (\because\ \cosh>\sinh\ \text{より}\ c_1c_2^*>s_1s_2^*)
\end{aligned}`),
      paragraph(["したがって、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)
&\geq1
&& (\because\ \gamma_1(\theta_\mu)^2\geq1\ \text{かつ}\ \gamma_1(\theta_\mu)>0)
\end{aligned}`),
    ],
  },
  {
    id: "note_Athetatilde_008_definition_gamma_theta_tilde_integer_route_TV1_hatZ_hatY_034a_definition_gamma_theta_mu",
    targets: ["def_gamma_theta_tilde_mu"],
    title: { tex: String.raw`\gamma(\theta_\mu) \text{ の定義}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ", ordinal: 34 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の定義ブロック TV1_hatZ_hatY_034a_definition_gamma_theta_mu。labels: def_gamma_theta_mu。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、", math(String.raw`\gamma_1(\theta_\mu) \geq 1`), " より ", ref("def_arccosh"), " の arccosh が適用でき、"]),
      displayMath(String.raw`\gamma(\theta_\mu) := \mathrm{arccosh}(\gamma_1(\theta_\mu)) \in \mathbb{R}_{\geq 0}`),
    ],
  },
  {
    id: "note_Athetatilde_009_claim_lambda_eq_exp_gamma_integer_route_TV1_hatZ_hatY_034b_claim_lambda_pm_exp_gamma",
    targets: ["lambda_eq_exp_gamma_theta_tilde"],
    title: { tex: String.raw`\lambda_{\pm,\mu} = \exp(\pm\gamma(\theta_\mu))` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/033_definition_gamma_theta_mu.typ", ordinal: 34 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_034b_claim_lambda_pm_exp_gamma。labels: lambda_eq_exp_gamma。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`\lambda_{+,\mu} = \exp(\gamma(\theta_\mu)), \quad \lambda_{-,\mu} = \exp(-\gamma(\theta_\mu))`),
      paragraph(["証明."]),
      paragraph(["〔det_A_theta〕", " と ", "〔eigenvector_of_A_theta〕", " より、", math(String.raw`\det A(\theta_\mu) = 1`), " と固有値の和・積から、"]),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}\lambda_{-,\mu}
&=\det A(\theta_\mu)
&&\bigl(\because\ \lambda_{+,\mu},\lambda_{-,\mu}\ \text{は}\ A(\theta_\mu)\ \text{の固有値}\bigr)\\
&=1
&&\bigl(\because\ \det A(\theta_\mu)=1\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}+\lambda_{-,\mu}
&=2\gamma_1(\theta_\mu)
&&\bigl(\because\ \lambda_{\pm,\mu}=\gamma_1(\theta_\mu)\pm\sqrt{-\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\bigr)\\
&\geq2
&&\bigl(\because\ \gamma_1(\theta_\mu)\geq1\bigr)\\
&>0
&&\bigl(\because\ 2>0\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\lambda_{+,\mu}&>0,\qquad \lambda_{-,\mu}>0
&&\bigl(\because\ \lambda_{+,\mu}\lambda_{-,\mu}>0\ \text{かつ}\ \lambda_{+,\mu}+\lambda_{-,\mu}>0\bigr)\\
\gamma(\theta_\mu)&\geq0
&&\bigl(\because\ \gamma(\theta_\mu)=\operatorname{arccosh}(\gamma_1(\theta_\mu))\ \text{と}\ \blkref{arccosh_properties}\text{ (1)}\bigr)\\
\lambda_{\pm,\mu}&=\exp(\pm\gamma(\theta_\mu))
&&\bigl(\because\ \text{正の二固有値を相反する指数として書く}\bigr)\\
\cosh(\gamma(\theta_\mu))&=\gamma_1(\theta_\mu)
&&\bigl(\because\ \gamma(\theta_\mu)\ \text{の定義と}\ \blkref{arccosh_properties}\text{ (2)}\bigr)
\end{aligned}`),
    ],
  },
  {
    id: "note_evenfermi_005_definition_check_Vprime_integer_route_TV1_hatZ_hatY_033_definition_Vprime",
    targets: ["def_check_Vprime"],
    title: { tex: String.raw`V' \text{ の定義}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ", ordinal: 33 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の定義ブロック TV1_hatZ_hatY_033_definition_Vprime。labels: def_Vprime。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      displayMath(String.raw`V' := \exp\!\Biggl(+\sum_{\substack{\mu \in \{1,\dots,M\} \\ \gamma_2(\theta_\mu) \neq 0}} \gamma(\theta_\mu)\Bigl(\psi_\mu^\dagger \psi_{-\mu} - \tfrac{1}{2}\Bigr)\Biggr)`),
      paragraph(["ここで和は ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " を満たす ", math(String.raw`\mu \in \{1,\dots,M\}`), " にわたる。この ", math(String.raw`\mu`), " に対しては ", "〔def_fermi〕", " と ", "〔relation_of_gamma_2〕", "（", math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`), "）より ", math(String.raw`\psi_\mu^\dagger, \psi_{-\mu}`), " がともに定義されるため、和の各項は well-defined である。"]),
    ],
  },
  {
    id: "note_evenfermi_006_claim_action_T_check_Vprime_integer_route_TV1_hatZ_hatY_038_claim_action_T_Vprime_psi",
    targets: ["action_of_T_check_Vprime_on_check_psi"],
    title: { tex: String.raw`T_{(V')} \text{ の } \psi \text{ への作用}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/037_claim_T_Vprimeのpsiへの作用.typ", ordinal: 38 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_038_claim_action_T_Vprime_psi。labels: action_of_T_Vprime_on_psi。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " なる ", math(String.raw`\mu \in \mathcal{M}`), " について（このとき ", "〔def_fermi〕", " より ", math(String.raw`\psi_\mu, \psi_\mu^\dagger`), " が定義される）、"]),
      displayMath(String.raw`T_{(V')}(\psi_\mu^\dagger) = \exp(+\gamma(\theta_\mu))\psi_\mu^\dagger,
\quad
T_{(V')}(\psi_\mu) = \exp(-\gamma(\theta_\mu))\psi_\mu`),
      paragraph(["証明."]),
      paragraph(["〔def_Vprime〕", " より ", math(String.raw`V' = \exp(X)`), " ただし"]),
      displayMath(String.raw`X := +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\Bigl(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}\Bigr)`),
      paragraph(["である（", "〔def_Vprime〕", " の和と同じく ", math(String.raw`\gamma_2(\theta_\nu) \neq 0`), " なる ", math(String.raw`\nu \in \{1,\dots,M\}`), " にわたる。この ", math(String.raw`\nu`), " については ", "〔def_fermi〕", " と ", "〔relation_of_gamma_2〕", " より ", math(String.raw`\psi_\nu^\dagger, \psi_{-\nu}`), " がともに定義される）。"]),
      paragraph([math(String.raw`X`), " と ", math(String.raw`-X`), " について"]),
      displayMath(String.raw`\begin{aligned}
X(-X)
&=-X^2
&&(\because\ \text{スカラー }-1\text{ を積の外へ出す})\\
&=(-X)X
&&(\because\ \text{同じ }X\text{ どうしの積})
\end{aligned}`),
      paragraph(["なので可換である。したがって ", ref("theorem_exp_product"), " より"]),
      displayMath(String.raw`\begin{aligned}
\exp(X)\exp(-X)
&=\exp(X+(-X))
&&(\because\ \text{指数行列の積の定理})\\
&=\exp(O)
&&(\because\ X+(-X)=O)\\
&=I
&&(\because\ \text{零行列の指数行列})
\end{aligned}`),
      paragraph(["故に ", math(String.raw`V'^{-1} = \exp(-X)`), " であり、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V')}(\psi_\mu^\dagger)
&=V'\psi_\mu^\dagger V'^{-1}
&&(\because\ T_{(V')}\ \text{の定義})\\
&=\exp(X)\psi_\mu^\dagger\exp(-X)
&&(\because\ V'=\exp(X),\ V'^{-1}=\exp(-X))
\end{aligned}`),
      paragraph(["Step 1: ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger] = \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger`), "。"]),
      displayMath(String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
&= \psi_\nu^\dagger(\delta^M_{\mu-\nu,0}\,I - \psi_\mu^\dagger\psi_{-\nu})
&& (\because [\psi_{-\nu}, \psi_\mu^\dagger]_+ = \delta^M_{\mu-\nu,0}\,I) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger I
   - \psi_\nu^\dagger\psi_\mu^\dagger\psi_{-\nu}
&& (\because \text{分配則}) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   - \psi_\nu^\dagger\psi_\mu^\dagger\psi_{-\nu}
&& (\because \psi_\nu^\dagger I=\psi_\nu^\dagger) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   - (-\psi_\mu^\dagger\psi_\nu^\dagger)\psi_{-\nu}
&& (\because [\psi_\nu^\dagger, \psi_\mu^\dagger]_+ = 0) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{加法逆元の符号則})
\end{aligned}`),
      paragraph(["（反交換関係は ", "〔anticommutator_of_psi〕", " による）。ゆえに"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
&= \psi_\nu^\dagger \psi_{-\nu}\psi_\mu^\dagger
   - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{交換子の定義}) \\
&= (\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
   + \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu})
   - \psi_\mu^\dagger\psi_\nu^\dagger\psi_{-\nu}
&& (\because \text{直前の式変形}) \\
&= \delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
&& (\because \text{加法逆元による相殺})
\end{aligned}`),
      paragraph(["Step 2: ", math(String.raw`[X, \psi_\mu^\dagger] = +\gamma(\theta_\mu)\psi_\mu^\dagger`), "。"]),
      displayMath(String.raw`\begin{aligned}
[X, \psi_\mu^\dagger]
&= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu^\dagger]
&&(\because\ \text{scalar\_identity\_commutes})\\
&= +\sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\,\delta^M_{\mu-\nu,0}\,\psi_\nu^\dagger
&&(\because\ \text{Step 1})
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\mu-\nu,0} \neq 0`), " となる ", math(String.raw`\nu \in \{1,\dots,M\}`), " を ", math(String.raw`\mu`), " の場合分けで特定する。特定される ", math(String.raw`\nu`), " はいずれも ", math(String.raw`\theta_\nu \equiv \pm\theta_\mu \pmod{2\pi}`), " を満たし、", math(String.raw`\gamma_2`), " は ", math(String.raw`\theta`), " の ", math(String.raw`\cos, \sin, \exp(i\theta)`), " のみに依存するから ", math(String.raw`\gamma_2(\theta_\nu) = \gamma_2(\pm\theta_\mu)`), "。", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " と ", "〔relation_of_gamma_2〕", "（", math(String.raw`\gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}`), "）より ", math(String.raw`\gamma_2(\pm\theta_\mu) \neq 0`), " であるから、特定される ", math(String.raw`\nu`), " は和の添字集合に属する。"]),
      paragraph(["a) ", math(String.raw`\mu \in \{1,\dots,M\}`), " のとき: ", math(String.raw`\mu \equiv \nu \pmod{M}`), " かつ ", math(String.raw`\nu \in \{1,\dots,M\}`), " を満たす ", math(String.raw`\nu`), " は ", math(String.raw`\nu = \mu`), " のみ。よって ", math(String.raw`[X, \psi_\mu^\dagger] = \gamma(\theta_\mu)\psi_\mu^\dagger`), "。"]),
      paragraph(["b) ", math(String.raw`\mu = -k`), "（", math(String.raw`k \in \{1,\dots,M-1\}`), "）のとき: ", math(String.raw`-k \equiv \nu \pmod{M}`), " かつ ", math(String.raw`\nu \in \{1,\dots,M\}`), " を満たす ", math(String.raw`\nu`), " は ", math(String.raw`\nu = M - k`), " のみ。", math(String.raw`\theta_{M-k} = 2\pi - \theta_k`), " より ", math(String.raw`\exp(i\theta_{M-k}) = \exp(-i\theta_k)`), "、", math(String.raw`\cos\theta_{M-k} = \cos\theta_k`), "、", math(String.raw`\sin\theta_{M-k} = -\sin\theta_k`), "。また ", "〔def_hatZ_pm〕", " と ", "〔def_hatY〕", " より ", math(String.raw`\hat{Z}_{M-k}^{(-)} = \hat{Z}_{-k}^{(-)}`), "、", math(String.raw`\hat{Y}_{M-k} = \hat{Y}_{-k}`), "。", ref("def_A_theta"), " より"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_{M-k})
&= i\,\exp(i\theta_{M-k})s_2^*(c_1\cos\theta_{M-k} - i\sin\theta_{M-k} - s_1 c_2)
&&(\because\ \gamma_2\ \text{の定義})\\
&= i\,\exp(-i\theta_k)s_2^*(c_1\cos\theta_k + i\sin\theta_k - s_1 c_2)
&&(\because\ \exp(i\theta_{M-k}) = \exp(-i\theta_k),\ \cos\theta_{M-k} = \cos\theta_k,\ \sin\theta_{M-k} = -\sin\theta_k)\\
&= \gamma_2(-\theta_k)
&&(\because\ \gamma_2\ \text{の定義に}\ -\theta_k\ \text{を代入した形})\\
&= \gamma_2(\theta_{-k})
&&(\because\ \theta_{-k} = -\theta_k)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta_{M-k})
&= i\,\exp(-i\theta_{M-k})s_2^*(c_1\cos\theta_{M-k} + i\sin\theta_{M-k} - s_1 c_2)
&&(\because\ \gamma_2\ \text{の定義に}\ -\theta_{M-k}\ \text{を代入した形})\\
&= i\,\exp(i\theta_k)s_2^*(c_1\cos\theta_k - i\sin\theta_k - s_1 c_2)
&&(\because\ \exp(-i\theta_{M-k}) = \exp(i\theta_k),\ \cos\theta_{M-k} = \cos\theta_k,\ \sin\theta_{M-k} = -\sin\theta_k)\\
&= \gamma_2(\theta_k)
&&(\because\ \gamma_2\ \text{の定義})\\
&= \gamma_2(-\theta_{-k})
&&(\because\ -\theta_{-k} = \theta_k)
\end{aligned}`),
      paragraph(["これらと ", "〔def_fermi〕", " より ", math(String.raw`\psi_{M-k}^\dagger = \psi_{-k}^\dagger`), "、また ", math(String.raw`\cos\theta_{M-k} = \cos\theta_k = \cos\theta_{-k}`), " より ", math(String.raw`\gamma_1(\theta_{M-k}) = \gamma_1(\theta_{-k})`), " ゆえ ", math(String.raw`\gamma(\theta_{M-k}) = \gamma(\theta_{-k})`), "。よって ", math(String.raw`[X, \psi_{-k}^\dagger] = \gamma(\theta_{-k})\psi_{-k}^\dagger`), "。"]),
      paragraph(["c) ", math(String.raw`\mu = -M`), " のとき: ", math(String.raw`\nu = M`), " のみ。", "〔hatZ_hatY_M_periodicity〕", " より ", math(String.raw`\hat{Z}_M^{(-)} = \hat{Z}_{-M}^{(-)}`), "、", math(String.raw`\hat{Y}_M = \hat{Y}_{-M}`), "、", "〔gamma2_theta_M_periodicity〕", " より ", math(String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M})`), "、", math(String.raw`\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`), "。ゆえ ", "〔def_fermi〕", " より ", math(String.raw`\psi_M^\dagger = \psi_{-M}^\dagger`), "、", math(String.raw`\gamma(\theta_M) = \gamma(\theta_{-M})`), " であり ", math(String.raw`[X, \psi_{-M}^\dagger] = \gamma(\theta_{-M})\psi_{-M}^\dagger`), "。"]),
      paragraph(["a)〜c) より全 ", math(String.raw`\mu \in \mathcal{M}`), " について ", math(String.raw`[X, \psi_\mu^\dagger] = \gamma(\theta_\mu)\psi_\mu^\dagger`), " である。したがって"]),
      displayMath(String.raw`\begin{aligned}
X\psi_\mu^\dagger
&=\psi_\mu^\dagger X+\gamma(\theta_\mu)\psi_\mu^\dagger
&&(\because\ [X,\psi_\mu^\dagger]=\gamma(\theta_\mu)\psi_\mu^\dagger\ \text{と交換子の定義})\\
&=\psi_\mu^\dagger X+\psi_\mu^\dagger\gamma(\theta_\mu)I
&&(\because\ \gamma(\theta_\mu)\ \text{はスカラー})\\
&=\psi_\mu^\dagger\bigl(X+\gamma(\theta_\mu)I\bigr)
&&(\because\ \text{分配則})
\end{aligned}`),
      paragraph(["Step 3: 帰納法で ", math(String.raw`X^n \psi_\mu^\dagger = \psi_\mu^\dagger (X + \gamma(\theta_\mu)I)^n`), " を示す。", math(String.raw`n = 0`), " のときは"]),
      displayMath(String.raw`\begin{aligned}
X^0\psi_\mu^\dagger
&= I\psi_\mu^\dagger
&&(\because\ \text{冪の定義}\ X^0 = I)\\
&= \psi_\mu^\dagger
&&(\because\ \text{単位行列との積})\\
&= \psi_\mu^\dagger I
&&(\because\ \text{単位行列との積})\\
&= \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^0
&&(\because\ \text{冪の定義}\ (X + \gamma(\theta_\mu)I)^0 = I)
\end{aligned}`),
      paragraph(["で成立する。", math(String.raw`n`), " で成立すると仮定すると"]),
      displayMath(String.raw`\begin{aligned}
X^{n+1}\psi_\mu^\dagger
&= (X\cdot X^n)\psi_\mu^\dagger
&&(\because\ \text{冪の定義})\\
&= X\cdot(X^n\psi_\mu^\dagger)
&&(\because\ \text{積の結合則})\\
&= X\cdot\bigl(\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n\bigr)
&&(\because\ \text{帰納法の仮定})\\
&= (X\psi_\mu^\dagger)\cdot(X + \gamma(\theta_\mu)I)^n
&&(\because\ \text{積の結合則})\\
&= \bigl(\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)\bigr)\cdot(X + \gamma(\theta_\mu)I)^n
&&(\because\ \text{Step 2 のまとめ})\\
&= \psi_\mu^\dagger\bigl((X + \gamma(\theta_\mu)I)\cdot(X + \gamma(\theta_\mu)I)^n\bigr)
&&(\because\ \text{積の結合則})\\
&= \psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^{n+1}
&&(\because\ \text{冪の定義})
\end{aligned}`),
      paragraph(["となるから、全 ", math(String.raw`n \geq 0`), " で成立する。"]),
      paragraph(["Step 4: ", math(String.raw`\exp(X)\psi_\mu^\dagger = \psi_\mu^\dagger \exp(X + \gamma(\theta_\mu)I)`), "。"]),
      displayMath(String.raw`\begin{aligned}
\sum_{n=0}^N \frac{X^n}{n!}\,\psi_\mu^\dagger
&= \sum_{n=0}^N \frac{X^n\psi_\mu^\dagger}{n!}
&& (\because\ \text{有限和の各項へ右から }\psi_\mu^\dagger\text{ を掛ける})\\
&= \sum_{n=0}^N \frac{\psi_\mu^\dagger(X + \gamma(\theta_\mu)I)^n}{n!}
&& (\because\ \text{Step 3})\\
&= \psi_\mu^\dagger \sum_{n=0}^N \frac{(X + \gamma(\theta_\mu)I)^n}{n!}
&& (\because\ \text{有限和に対する分配則})
\end{aligned}`),
      paragraph([math(String.raw`N \to \infty`), " の極限で ", ref("exp_converges"), " より右辺は ", math(String.raw`\psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)`), " に収束し（", ref("matrix_multiplication_continuity"), "）、", math(String.raw`\exp(X)\psi_\mu^\dagger = \psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)`), "。"]),
      paragraph(["Step 5: 結論。", math(String.raw`(X + \gamma(\theta_\mu)I)`), " と ", math(String.raw`(-X)`), " は可換だから ", ref("theorem_exp_product"), " より、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V')}(\psi_\mu^\dagger)
&= \exp(X)\psi_\mu^\dagger\exp(-X)
&&(\because\ \text{証明冒頭の鎖})\\
&= \psi_\mu^\dagger\exp(X + \gamma(\theta_\mu)I)\exp(-X)
&&(\because\ \text{Step 4})\\
&= \psi_\mu^\dagger\exp((X + \gamma(\theta_\mu)I) + (-X))
&&(\because\ \text{指数行列の積の定理})\\
&= \psi_\mu^\dagger\exp(\gamma(\theta_\mu)I)
&&(\because\ (X + \gamma(\theta_\mu)I) + (-X) = \gamma(\theta_\mu)I)\\
&= \psi_\mu^\dagger\cdot \exp(\gamma(\theta_\mu))I
&&(\because\ (\gamma(\theta_\mu)I)^n = (\gamma(\theta_\mu))^n I)\\
&= \exp(+\gamma(\theta_\mu))\psi_\mu^\dagger
&&(\because\ \text{単位行列とのスカラー倍の積})
\end{aligned}`),
      paragraph([math(String.raw`T_{(V')}(\psi_\mu) = \exp(-\gamma(\theta_\mu))\psi_\mu`), " について。"]),
      paragraph(["Step 1': ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      displayMath(String.raw`\begin{aligned}
\psi_\nu^\dagger \psi_{-\nu}\psi_\mu
&= \psi_\nu^\dagger(-\psi_\mu\psi_{-\nu})
&&(\because\ [\psi_{-\nu},\psi_\mu]_+=0)\\
&= -\psi_\nu^\dagger\psi_\mu\psi_{-\nu}
&&(\because\ \text{スカラー倍と行列の積の結合則})\\
&= -(\delta^M_{\nu+\mu,0}\,I-\psi_\mu\psi_\nu^\dagger)\psi_{-\nu}
&&(\because\ [\psi_\nu^\dagger,\psi_\mu]_+=\delta^M_{\nu+\mu,0}\,I)\\
&= -\delta^M_{\nu+\mu,0}\,I\psi_{-\nu}+\psi_\mu\psi_\nu^\dagger\psi_{-\nu}
&&(\because\ \text{分配則})\\
&= -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}+\psi_\mu\psi_\nu^\dagger\psi_{-\nu}
&&(\because\ I\psi_{-\nu}=\psi_{-\nu})
\end{aligned}`),
      paragraph(["（反交換関係は ", "〔anticommutator_of_psi〕", " による）。ゆえに ", math(String.raw`[\psi_\nu^\dagger \psi_{-\nu},\, \psi_\mu] = -\delta^M_{\nu+\mu,0}\,\psi_{-\nu}`), "。"]),
      paragraph(["Step 2': ", math(String.raw`[X, \psi_\mu] = -\gamma(\theta_\mu)\psi_\mu`), "。"]),
      displayMath(String.raw`\begin{aligned}
[X,\psi_\mu]
&=\left[\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)\psi_\nu^\dagger\psi_{-\nu},\,\psi_\mu\right]
&&(\because\ X\ \text{の定義})\\
&=\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)[\psi_\nu^\dagger\psi_{-\nu},\psi_\mu]
&&(\because\ \text{交換子の有限和とスカラー倍への分配則})\\
&=-\sum_{\substack{\nu\in\{1,\dots,M\}\\\gamma_2(\theta_\nu)\neq0}}
\gamma(\theta_\nu)\delta^M_{\nu+\mu,0}\psi_{-\nu}
&&(\because\ \text{Step 1'})
\end{aligned}`),
      paragraph([math(String.raw`\delta^M_{\nu+\mu,0} \neq 0`), " となる ", math(String.raw`\nu \in \{1,\dots,M\}`), " を ", math(String.raw`\mu`), " の場合分けで特定し ", math(String.raw`\psi_{-\nu} = \psi_\mu`), " を確認する（周期性の計算は Step 2 と対称的で、特定される ", math(String.raw`\nu`), " が和の添字集合に属することも同様）："]),
      list([[math(String.raw`\mu \in \{1,\dots,M-1\}`), ": ", math(String.raw`\nu = M-\mu`), "、", math(String.raw`\psi_{-(M-\mu)} = \psi_{\mu-M} = \psi_\mu`), "、", math(String.raw`\gamma(\theta_{M-\mu}) = \gamma(\theta_\mu)`), "。"], [math(String.raw`\mu = M`), ": ", math(String.raw`\nu = M`), "、", math(String.raw`\psi_{-M} = \psi_M`), "。"], [math(String.raw`\mu = -k\ (k \in \{1,\dots,M-1\})`), ": ", math(String.raw`\nu = k`), "、", math(String.raw`\psi_{-k} = \psi_\mu`), "、", math(String.raw`\gamma(\theta_k) = \gamma(\theta_{-k})`), "。"], [math(String.raw`\mu = -M`), ": ", math(String.raw`\nu = M`), "、", math(String.raw`\psi_{-M} = \psi_{-M}`), "、", math(String.raw`\gamma(\theta_M) = \gamma(\theta_{-M})`), "。"]]),
      paragraph(["以上より全 ", math(String.raw`\mu \in \mathcal{M}`), " について ", math(String.raw`[X, \psi_\mu] = -\gamma(\theta_\mu)\psi_\mu`), "、すなわち ", math(String.raw`X\psi_\mu = \psi_\mu(X - \gamma(\theta_\mu)I)`), "。Steps 3'〜5' は ", math(String.raw`\psi_\mu^\dagger`), " の証明と ", math(String.raw`\gamma(\theta_\mu) \to -\gamma(\theta_\mu)`), "（符号反転）のみ異なり同様に成立し、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V')}(\psi_\mu)
&= \exp(X)\psi_\mu\exp(-X)
&&(\because\ \text{証明冒頭の鎖})\\
&= \psi_\mu\exp(X-\gamma(\theta_\mu)I)\exp(-X)
&&(\because\ \text{Steps 3'--4'})\\
&= \psi_\mu\exp((X-\gamma(\theta_\mu)I)+(-X))
&&(\because\ \text{指数行列の積の定理})\\
&= \psi_\mu\exp(-\gamma(\theta_\mu)I)
&&(\because\ (X-\gamma(\theta_\mu)I)+(-X)=-\gamma(\theta_\mu)I)\\
&= \psi_\mu\cdot \exp(-\gamma(\theta_\mu))I
&&(\because\ (-\gamma(\theta_\mu)I)^n=(-\gamma(\theta_\mu))^nI)\\
&= \exp(-\gamma(\theta_\mu))\psi_\mu
&&(\because\ \text{単位行列とのスカラー倍の積})
\end{aligned}`),
    ],
  },
  {
    id: "note_evenfermi_007_claim_T_eq_on_check_Z_Y_integer_route_TV1_hatZ_hatY_045_claim_A_theta_is_identity",
    targets: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ のとき } A(\theta_\mu) = I` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/044_claim_gamma2_0のときA_thetaは単位行列.typ", ordinal: 45 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_045_claim_A_theta_is_identity。labels: A_theta_is_identity_when_gamma2_zero。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。", math(String.raw`\mu \in \mathcal{M}`), " が ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たすとき、"]),
      displayMath(String.raw`A(\theta_\mu) = I \quad (2 \times 2 \text{ 単位行列})`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たす ", math(String.raw`\mu \in \mathcal{M}`), " を固定する。以下で引く関係式は ", "〔relation_of_gamma_2〕", "、", "〔det_A_theta〕", "、", "〔gamma1_geq_1〕", "、", ref("def_A_theta"), " である。"]),
      paragraph(["Step 1: ", math(String.raw`\gamma_2(-\theta_\mu) = 0`), "。"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(-\theta_\mu)
&= -\overline{\gamma_2(\theta_\mu)}
&&(\because\ \gamma_2 \text{ の対称性 } \gamma_2(-\theta_\mu) = -\overline{\gamma_2(\theta_\mu)}) \\
&= -\overline{0}
&&(\because\ \gamma_2(\theta_\mu) = 0) \\
&= 0
&&(\because\ \overline{0} = 0,\ -0 = 0)
\end{aligned}`),
      paragraph(["Step 2: ", math(String.raw`\gamma_1(\theta_\mu) = 1`), "。"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\mu)^2
&= 1 - \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)
&&(\because\ \det A(\theta_\mu) = 1 \text{ の等式 } \gamma_1(\theta_\mu)^2 + \gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) = 1 \text{ を移項}) \\
&= 1 - 0 \cdot 0
&&(\because\ \gamma_2(\theta_\mu) = 0,\ \text{Step 1}) \\
&= 1
&&(\because\ 0 \cdot 0 = 0,\ 1 - 0 = 1)
\end{aligned}`),
      paragraph(["〔gamma1_geq_1〕", " より ", math(String.raw`\gamma_1(\theta_\mu) \geq 1 > 0`), " であるから、", math(String.raw`\gamma_1(\theta_\mu)^2 = 1`), " と合わせて ", math(String.raw`\gamma_1(\theta_\mu) = 1`), " を得る。"]),
      paragraph(["Step 3: ", math(String.raw`A(\theta_\mu) = I`), "。"]),
      displayMath(String.raw`\begin{aligned}
A(\theta_\mu)
&= \begin{pmatrix} \gamma_1(\theta_\mu) & \gamma_2(\theta_\mu) \\ -\gamma_2(-\theta_\mu) & \gamma_1(\theta_\mu) \end{pmatrix}
&&(\because\ \det A(\theta_\mu) = 1 \text{ の証明中の成分表示。} A(\theta_\mu) \text{ の各成分の } \gamma_1, \gamma_2 \text{ による書き換え}) \\
&= \begin{pmatrix} 1 & 0 \\ -0 & 1 \end{pmatrix}
&&(\because\ \gamma_2(\theta_\mu) = 0,\ \text{Step 1, Step 2}) \\
&= \begin{pmatrix} 1 & 0 \\ 0 & 1 \end{pmatrix}
&&(\because\ -0 = 0) \\
&= I
&&(\because\ 2 \times 2 \text{ 単位行列の定義})
\end{aligned}`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "note_evenfermi_007_claim_T_eq_on_check_Z_Y_integer_route_TV1_hatZ_hatY_042_claim_T_Vprime_fixes_hatZ_hatY_gamma2_zero",
    targets: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    title: { tex: String.raw`\gamma_2(\theta_\mu) = 0 \text{ のとき } T_{(V')} \text{ は } \hat{Z}_\mu^{(-)}, \hat{Y}_\mu \text{ を固定する}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/041_claim_T_VprimeのhatZ_hatYへの作用_gamma2が0の場合.typ", ordinal: 42 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_042_claim_T_Vprime_fixes_hatZ_hatY_gamma2_zero。labels: T_Vprime_fixes_hatZ_hatY_when_gamma2_zero。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。"]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " が ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たすとき、"]),
      displayMath(String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}, \quad T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\gamma_2(\theta_\mu) = 0`), " を満たす ", math(String.raw`\mu \in \mathcal{M}`), " を固定する。", "〔def_Vprime〕", " より ", math(String.raw`V' = \exp(X)`), "、ただし"]),
      displayMath(String.raw`X := \sum_{\substack{\nu \in \{1,\dots,M\} \\ \gamma_2(\theta_\nu) \neq 0}} \gamma(\theta_\nu)\Bigl(\psi_\nu^\dagger \psi_{-\nu} - \tfrac{1}{2}\Bigr)`),
      paragraph(["である。", "〔def_Vprime〕", " の定義により、", math(String.raw`X`), " の和は最初から ", math(String.raw`\gamma_2(\theta_\nu) \neq 0`), " となる ", math(String.raw`\nu \in \{1,\dots,M\}`), " のみにわたる。この ", math(String.raw`\nu`), " については ", "〔def_fermi〕", " と ", "〔relation_of_gamma_2〕", " より ", math(String.raw`\psi_\nu^\dagger, \psi_{-\nu}`), " がともに定義されるので、", math(String.raw`X`), " の各項は well-defined である（", math(String.raw`\gamma_2(\theta_\nu) = 0`), " となる ", math(String.raw`\nu`), " ははじめから和に含まれない）。"]),
      paragraph(["〔action_of_T_Vprime_on_psi〕", " の証明冒頭と同様に ", math(String.raw`V'^{-1} = \exp(-X)`), " であり、", math(String.raw`T_g`), " の定義（", ref("def_T_g"), "）より ", math(String.raw`T_{(V')}(W) = V'W V'^{-1} = \exp(X)W\exp(-X)`), "（", math(String.raw`W \in \mathrm{Mat}(2^M,\mathbb{C})`), "）である。"]),
      paragraph(["Step 1: ", math(String.raw`\gamma_2(\theta_\nu) = 0 \Rightarrow \gamma(\theta_\nu) = 0`), "。"]),
      paragraph([math(String.raw`\gamma_2(\theta_\nu) = 0`), " とする。", "〔det_A_theta〕", " より ", math(String.raw`\gamma_1(\theta_\nu)^2 + \gamma_2(\theta_\nu)\gamma_2(-\theta_\nu) = 1`), " であるから、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_1(\theta_\nu)^2
&= 1 - \gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)
&& (\because\ \det A(\theta_\nu)=1) \\
&= 1 - 0\cdot\gamma_2(-\theta_\nu)
&& (\because\ \gamma_2(\theta_\nu)=0) \\
&= 1
&& (\because\ 0\cdot\gamma_2(-\theta_\nu)=0)
\end{aligned}`),
      paragraph(["〔gamma1_geq_1〕", " より ", math(String.raw`\gamma_1(\theta_\nu) \geq 1 > 0`), " であるから ", math(String.raw`\gamma_1(\theta_\nu) = 1`), "。ここで ", math(String.raw`\gamma(\theta_\nu)`), " の定義は ", "〔def_gamma_theta_mu〕", " であるから、"]),
      displayMath(String.raw`\begin{aligned}
\gamma(\theta_\nu)
&= \mathrm{arccosh}(\gamma_1(\theta_\nu))
&& (\because\ \gamma(\theta_\nu)\text{ の定義}) \\
&= \mathrm{arccosh}(1)
&& (\because\ \gamma_1(\theta_\nu)=1) \\
&= 0
&& (\because\ \blkref{arccosh_properties}\text{ (4)})
\end{aligned}`),
      paragraph(["である。"]),
      paragraph(["Step 2: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " かつ ", math(String.raw`\delta^M_{\mu\pm\nu,0} \neq 0`), " ならば ", math(String.raw`\gamma_2(\theta_\nu) = 0`), "（ゆえに ", math(String.raw`\gamma(\theta_\nu) = 0`), "）。"]),
      paragraph([math(String.raw`\nu \in \{1,\dots,M\}`), " とし、", math(String.raw`\delta^M_{\mu-\nu,0} \neq 0`), " または ", math(String.raw`\delta^M_{\mu+\nu,0} \neq 0`), " と仮定する。すなわち ", math(String.raw`\mu \equiv \nu \pmod{M}`), " または ", math(String.raw`\mu \equiv -\nu \pmod{M}`), "。", "〔gamma_2_theta_is_0〕", " より ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " は ", math(String.raw`\sin\theta_\mu = 0`), " かつ ", math(String.raw`c_1\cos\theta_\mu = s_1 c_2`), " と同値である。", math(String.raw`\theta_\kappa = \tfrac{2\pi\kappa}{M}`), " であるから ", math(String.raw`\mu \equiv \nu \pmod{M}`), " のとき、ある ", math(String.raw`\ell \in \mathbb{Z}`), " で ", math(String.raw`\nu = \mu + \ell M`), " と書け ", math(String.raw`\theta_\nu = \theta_\mu + 2\pi\ell`), "、", math(String.raw`\mu \equiv -\nu \pmod{M}`), " のときは ", math(String.raw`\theta_\nu = -\theta_\mu + 2\pi\ell`), " である。"]),
      paragraph(["いずれの場合も、"]),
      displayMath(String.raw`\begin{aligned}
\cos\theta_\nu
&= \cos\theta_\mu
&& (\because\ \text{三角関数の周期性と偶奇性}) \\
\sin\theta_\nu
&= \pm\sin\theta_\mu
&& (\because\ \text{三角関数の周期性と偶奇性}) \\
&= 0
&& (\because\ \sin\theta_\mu=0) \\
c_1\cos\theta_\nu
&= c_1\cos\theta_\mu
&& (\because\ \cos\theta_\nu=\cos\theta_\mu) \\
&= s_1c_2
&& (\because\ c_1\cos\theta_\mu=s_1c_2) \\
\gamma_2(\theta_\nu)
&= 0
&& (\because\ \text{〔gamma\_2\_theta\_is\_0〕}) \\
\gamma(\theta_\nu)
&= 0
&& (\because\ \text{Step 1})
\end{aligned}`),
      paragraph(["Step 3: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " のとき ", math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`), " かつ ", math(String.raw`[X, \hat{Y}_\mu] = O`), "。"]),
      paragraph(["各 ", math(String.raw`\nu \in \{1,\dots,M\}`), "（", math(String.raw`\gamma_2(\theta_\nu) \neq 0`), "）について ", math(String.raw`c_\nu := \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\nu)}`), " とおくと ", "〔def_fermi〕", " より"]),
      displayMath(String.raw`\begin{aligned}
\psi_\nu^\dagger
&= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\,\hat{Z}_\nu^{(-)} + \gamma_2(-\theta_\nu)\hat{Y}_\nu\bigr)
&& (\because\ \text{フェルミオンの定義と }c_\nu\text{ の定義}) \\
\psi_{-\nu}
&= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\,\hat{Z}_{-\nu}^{(-)} + \gamma_2(-\theta_{-\nu})\hat{Y}_{-\nu}\bigr)
&& (\because\ \text{フェルミオンの定義と }c_{-\nu}\text{ の定義})
\end{aligned}`),
      paragraph(["である。", "〔anticommutator_of_hat_Z_and_hat_Y〕", " と反交換子の双線型性、", math(String.raw`[\hat{Z}_\kappa^{(-)}, \hat{Y}_\lambda]_+ = 0`), " より（", math(String.raw`\delta^M_{\nu+\mu,0} = \delta^M_{\mu+\nu,0}`), "、", math(String.raw`\delta^M_{-\nu+\mu,0} = \delta^M_{\mu-\nu,0}`), "）"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\nu^\dagger, \hat{Z}_\mu^{(-)}]_+
&= c_\nu\bigl(+i\sqrt{\gamma_2(\theta_\nu)\gamma_2(-\theta_\nu)}\bigr)\cdot 2M\delta^M_{\mu+\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_\nu^{(-)},\hat Y_\mu]_+=0) \\
[\psi_{-\nu}, \hat{Z}_\mu^{(-)}]_+
&= c_{-\nu}\bigl(-i\sqrt{\gamma_2(\theta_{-\nu})\gamma_2(-\theta_{-\nu})}\bigr)\cdot 2M\delta^M_{\mu-\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_{-\nu}^{(-)},\hat Y_\mu]_+=0) \\
[\psi_\nu^\dagger, \hat{Y}_\mu]_+
&= c_\nu\,\gamma_2(-\theta_\nu)\cdot 2M\delta^M_{\mu+\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_\nu^{(-)},\hat Y_\mu]_+=0) \\
[\psi_{-\nu}, \hat{Y}_\mu]_+
&= c_{-\nu}\,\gamma_2(-\theta_{-\nu})\cdot 2M\delta^M_{\mu-\nu,0}\,I
&& (\because\ \text{フェルミオンの表示、反交換子の双線型性、}\ [\hat Z_{-\nu}^{(-)},\hat Y_\mu]_+=0)
\end{aligned}`),
      paragraph([math(String.raw`W \in \{\hat{Z}_\mu^{(-)}, \hat{Y}_\mu\}`), " を固定する。いま ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " かつ ", math(String.raw`\gamma_2(\theta_\nu) \neq 0`), " であるから、Step 2 の対偶より ", math(String.raw`\delta^M_{\mu+\nu,0} = 0`), " かつ ", math(String.raw`\delta^M_{\mu-\nu,0} = 0`), "。よって上の反交換子はすべて ", math(String.raw`O`), " となる: ", math(String.raw`[\psi_\nu^\dagger, W]_+ = O`), "、", math(String.raw`[\psi_{-\nu}, W]_+ = O`), "。したがって ", ref("commutator_via_anticommutators"), " より"]),
      displayMath(String.raw`\begin{aligned}
[\psi_\nu^\dagger \psi_{-\nu}, W]
&= \psi_\nu^\dagger[\psi_{-\nu}, W]_+ - [\psi_\nu^\dagger, W]_+\psi_{-\nu}
&& (\because\ \text{積の交換子を反交換子で表す恒等式}) \\
&= \psi_\nu^\dagger O - O\psi_{-\nu}
&& (\because\ [\psi_{-\nu},W]_+=O,\ [\psi_\nu^\dagger,W]_+=O) \\
&= O
&& (\because\ AO=OA=O)
\end{aligned}`),
      paragraph(["また、"]),
      displayMath(String.raw`\begin{aligned}
[\tfrac{1}{2}I,W]
&=O
&& (\because\ \blkref{scalar_identity_commutes}) \\
[\psi_\nu^\dagger\psi_{-\nu}-\tfrac{1}{2}I,W]
&=[\psi_\nu^\dagger\psi_{-\nu},W]-[\tfrac{1}{2}I,W]
&& (\because\ \text{交換子の加法性}) \\
&=O-O
&& (\because\ [\psi_\nu^\dagger\psi_{-\nu},W]=O,\ [\tfrac{1}{2}I,W]=O) \\
&=O
&& (\because\ O-O=O) \\
[\gamma(\theta_\nu)(\psi_\nu^\dagger\psi_{-\nu}-\tfrac{1}{2}I),W]
&=\gamma(\theta_\nu)[\psi_\nu^\dagger\psi_{-\nu}-\tfrac{1}{2}I,W]
&& (\because\ \text{交換子の斉次性}) \\
&=\gamma(\theta_\nu)O
&& (\because\ [\psi_\nu^\dagger\psi_{-\nu}-\tfrac{1}{2}I,W]=O) \\
&=O
&& (\because\ zO=O\ (z\in\mathbb C)) \\
[X,W]
&=\sum_{\substack{\nu=1\\\gamma_2(\theta_\nu)\ne0}}^M
[\gamma(\theta_\nu)(\psi_\nu^\dagger\psi_{-\nu}-\tfrac{1}{2}I),W]
&& (\because\ X\text{ の定義と交換子の加法性}) \\
&=\sum_{\substack{\nu=1\\\gamma_2(\theta_\nu)\ne0}}^M O
&& (\because\ \text{各 }\nu\text{ に対する直前の等式}) \\
&=O
&& (\because\ \text{零行列の有限和})
\end{aligned}`),
      paragraph([math(String.raw`W`), " は ", math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`), " いずれでもよいから ", math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`), "、", math(String.raw`[X, \hat{Y}_\mu] = O`), "。"]),
      paragraph(["Step 4: ", math(String.raw`[X, W] = O \Rightarrow \exp(X)W\exp(-X) = W`), "。"]),
      paragraph([math(String.raw`[X, W] = O`), " すなわち ", math(String.raw`XW = WX`), " とする。帰納法で ", math(String.raw`X^n W = W X^n`), "（", math(String.raw`n \geq 0`), "）を示す。"]),
      displayMath(String.raw`\begin{aligned}
X^{n+1}W
&= X\cdot X^n W
&& (\because\ X^{n+1}=X\cdot X^n) \\
&= X\cdot W X^n
&& (\because\ X^nW=WX^n) \\
&= (XW)X^n
&& (\because\ \text{行列積の結合則}) \\
&= (WX)X^n
&& (\because\ XW=WX) \\
&= W X^{n+1}
&& (\because\ \text{行列積の結合則と }X^{n+1}=X\cdot X^n)
\end{aligned}`),
      paragraph([math(String.raw`n = 0`), " で ", math(String.raw`X^0 W = W = W X^0`), " だから全 ", math(String.raw`n \geq 0`), " で成立する。よって"]),
      displayMath(String.raw`\begin{aligned}
\left(\sum_{n=0}^N \frac{X^n}{n!}\right)W
&= \sum_{n=0}^N \frac{X^n W}{n!}
&& (\because\ \text{行列積の有限和に関する分配則}) \\
&= \sum_{n=0}^N \frac{W X^n}{n!}
&& (\because\ X^nW=WX^n) \\
&= W\left(\sum_{n=0}^N \frac{X^n}{n!}\right)
&& (\because\ \text{行列積の有限和に関する分配則})
\end{aligned}`),
      paragraph([math(String.raw`N \to \infty`), " の極限で ", ref("exp_converges"), "・", ref("matrix_multiplication_continuity"), " より ", math(String.raw`\exp(X)W = W\exp(X)`), "。", math(String.raw`X`), " と ", math(String.raw`-X`), " は可換だから ", ref("theorem_exp_product"), " より ", math(String.raw`\exp(X)\exp(-X) = \exp(O) = I`), "（", ref("theorem_exp_zero"), "）であり、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V')}(W)
&= \exp(X)W\exp(-X)
&& (\because\ T_{(V')}\text{ の定義}) \\
&= W\exp(X)\exp(-X)
&& (\because\ \exp(X)W=W\exp(X)) \\
&= WI
&& (\because\ \exp(X)\exp(-X)=I) \\
&= W
&& (\because\ I\text{ は単位行列})
\end{aligned}`),
      paragraph(["Step 3 より ", math(String.raw`[X, \hat{Z}_\mu^{(-)}] = O`), " かつ ", math(String.raw`[X, \hat{Y}_\mu] = O`), " であるから ", math(String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`), "、", math(String.raw`T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`), "。"]),
    ],
  },
  {
    id: "note_evenfermi_007_claim_T_eq_on_check_Z_Y_integer_route_TV1_hatZ_hatY_043_claim_T_V_eq_T_Vprime_on_hatZ_hatY",
    targets: ["T_V_plus_eq_T_check_Vprime_on_check_Z_Y"],
    title: { tex: String.raw`T_{(V)} \text{ と } T_{(V')} \text{ は } \hat{Z}^{(-)}, \hat{Y} \text{ 上で一致する}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/042_claim_T_VとT_VprimeはhatZ_hatY上で一致.typ", ordinal: 43 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_043_claim_T_V_eq_T_Vprime_on_hatZ_hatY。labels: T_V_eq_T_Vprime_on_hatZ_hatY。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mathcal{M} := \{-M, \dots, -1, 1, \dots, M\}`), " とする。すべての ", math(String.raw`\mu \in \mathcal{M}`), " について、"]),
      displayMath(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)}), \quad T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\mu \in \mathcal{M}`), " を固定する。", math(String.raw`T_{(V)}`), " はその定義（", "〔def_T_V〕", "）より 3 つの写像 ", math(String.raw`T_{(V_1^{(\pm)})^{1/2}}, T_{(V_2)}, T_{(V_1^{(\pm)})^{1/2}}`), " の合成であり、各写像は ", math(String.raw`T_g`), "（", ref("def_T_g"), "）の形で ", ref("mat_conj"), " より線型写像であるから、合成として ", math(String.raw`T_{(V)}`), " も線型写像である。", math(String.raw`T_{(V')}`), " は ", math(String.raw`T_g`), " の ", math(String.raw`g = V'`), " の場合であり、", "〔def_Vprime〕", " より ", math(String.raw`V'`), " は可逆であるから ", ref("mat_conj"), " より線型写像である。", math(String.raw`\gamma_2(\theta_\mu)`), " が ", math(String.raw`0`), " であるか否かで場合分けする。"]),
      paragraph(["場合 1: ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), "。このとき ", "〔def_fermi〕", " より ", math(String.raw`\psi_\mu^\dagger, \psi_\mu`), " が定義され、"]),
      displayMath(String.raw`\begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} = \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu`),
      paragraph(["が成り立つ。ここで ", math(String.raw`P_\mu`), " は ", "〔diagonalization_P_D〕", " で与えられる ", math(String.raw`2 \times 2`), " 複素行列"]),
      displayMath(String.raw`P_\mu = \frac{1}{2\sqrt{M}\,\gamma_2(-\theta_\mu)}
\begin{pmatrix}
+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} & -i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \\
\gamma_2(-\theta_\mu) & \gamma_2(-\theta_\mu)
\end{pmatrix}`),
      paragraph(["である。まず ", math(String.raw`P_\mu`), " が可逆であることを示す。準備として、", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(\theta_\mu) \neq 0 \iff \gamma_2(-\theta_\mu) \neq 0`), "、ゆえ ", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), " かつ ", math(String.raw`\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu) \neq 0`), " かつ ", math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`), "（", ref("square_of_sqrt"), " より ", math(String.raw`(\sqrt{z})^2 = z \neq 0`), " ゆえ ", math(String.raw`\sqrt{z} \neq 0`), "）である。行列式は"]),
      displayMath(String.raw`\begin{aligned}
\det P_\mu
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\Bigl((+i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu) - (-i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)})\gamma_2(-\theta_\mu)\Bigr)
\quad (\because P_\mu \text{ \u306e\u5b9a\u7fa9\u3068 }2\times2\text{ \u884c\u5217\u306e\u884c\u5217\u5f0f}) \\
&= \frac{1}{(2\sqrt{M}\,\gamma_2(-\theta_\mu))^2}\cdot 2i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu)
\quad (\because \text{\u5206\u914d\u5f8b\u3068\u7b26\u53f7\u306e\u8a08\u7b97}) \\
&= \frac{2i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}\,\gamma_2(-\theta_\mu)}{4M\,\gamma_2(-\theta_\mu)^2}
\quad (\because (2\sqrt{M}\,\gamma_2(-\theta_\mu))^2 = 4M\,\gamma_2(-\theta_\mu)^2\text{。}(\sqrt{M})^2 = M\text{ は }\text{square\_of\_sqrt}) \\
&= \frac{i\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{2M\,\gamma_2(-\theta_\mu)}
\quad (\because \gamma_2(-\theta_\mu)\neq0\text{ による共通因子 }2\gamma_2(-\theta_\mu)\text{ の約分})
\end{aligned}`),
      paragraph(["である。分子は ", math(String.raw`i \neq 0`), " と ", math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)} \neq 0`), "（準備）の積なので零でなく、分母 ", math(String.raw`2M\,\gamma_2(-\theta_\mu)`), " も零でない。よって ", math(String.raw`\det P_\mu \neq 0`), " であり ", math(String.raw`P_\mu`), " は可逆である。"]),
      paragraph([math(String.raw`P_\mu^{-1} = \begin{pmatrix} q_{11} & q_{12} \\ q_{21} & q_{22} \end{pmatrix}`), "（各 ", math(String.raw`q_{ij} \in \mathbb{C}`), "）とおくと、"]),
      displayMath(String.raw`\begin{aligned}
\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr)
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) I
\quad (\because \text{単位行列との積}) \\
&= \bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) (P_\mu P_\mu^{-1})
\quad (\because P_\mu P_\mu^{-1}=I) \\
&= \left(\bigl(\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu\bigr) P_\mu\right) P_\mu^{-1}
\quad (\because \text{行列の積の結合則}) \\
&= \begin{pmatrix} \psi_\mu^\dagger & \psi_\mu \end{pmatrix} P_\mu^{-1}
\quad (\because \text{def\_fermi}) \\
&= \begin{pmatrix} q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu & q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu \end{pmatrix}
\quad (\because 1\times2\text{ 行列と }2\times2\text{ 行列の積の定義})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`\hat{Z}_\mu^{(-)} = q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu`), "、", math(String.raw`\hat{Y}_\mu = q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu`), " である。一方、", "〔commutation_V_psi〕", " と ", "〔lambda_eq_exp_gamma〕", " より"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\psi_\mu^\dagger)
&= \lambda_{+,\mu}\psi_\mu^\dagger
\quad (\because \text{フェルミオン生成演算子への作用}) \\
&= \exp(\gamma(\theta_\mu))\psi_\mu^\dagger
\quad (\because \lambda_{+,\mu}=\exp(\gamma(\theta_\mu))), \\
T_{(V)}(\psi_\mu)
&= \lambda_{-,\mu}\psi_\mu
\quad (\because \text{フェルミオン消滅演算子への作用}) \\
&= \exp(-\gamma(\theta_\mu))\psi_\mu
\quad (\because \lambda_{-,\mu}=\exp(-\gamma(\theta_\mu))).
\end{aligned}`),
      paragraph(["であり、", "〔action_of_T_Vprime_on_psi〕", " より"]),
      displayMath(String.raw`T_{(V')}(\psi_\mu^\dagger) = \exp(\gamma(\theta_\mu))\psi_\mu^\dagger, \quad T_{(V')}(\psi_\mu) = \exp(-\gamma(\theta_\mu))\psi_\mu`),
      paragraph(["である。したがって"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\psi_\mu^\dagger)
&= \exp(\gamma(\theta_\mu))\psi_\mu^\dagger
\quad (\because \text{直前の }T_{(V)}\text{ の作用}) \\
&= T_{(V')}(\psi_\mu^\dagger)
\quad (\because \text{直前の }T_{(V')}\text{ の作用}), \\
T_{(V)}(\psi_\mu)
&= \exp(-\gamma(\theta_\mu))\psi_\mu
\quad (\because \text{直前の }T_{(V)}\text{ の作用}) \\
&= T_{(V')}(\psi_\mu)
\quad (\because \text{直前の }T_{(V')}\text{ の作用}).
\end{aligned}`),
      paragraph(["が成り立つ。これより、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\hat{Z}_\mu^{(-)})
&= T_{(V)}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu)
\quad (\because \hat{Z}_\mu^{(-)}=q_{11}\psi_\mu^\dagger+q_{21}\psi_\mu) \\
&= q_{11}T_{(V)}(\psi_\mu^\dagger) + q_{21}T_{(V)}(\psi_\mu) \quad (\because T_{(V)} \text{ の線型性}) \\
&= q_{11}T_{(V')}(\psi_\mu^\dagger) + q_{21}T_{(V')}(\psi_\mu) \quad (\because \text{直前の二つの作用の一致}) \\
&= T_{(V')}(q_{11}\psi_\mu^\dagger + q_{21}\psi_\mu) \quad (\because T_{(V')} \text{ の線型性}) \\
&= T_{(V')}(\hat{Z}_\mu^{(-)})
\quad (\because q_{11}\psi_\mu^\dagger+q_{21}\psi_\mu=\hat{Z}_\mu^{(-)})
\end{aligned}`),
      paragraph(["が成り立つ。また、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\hat{Y}_\mu)
&= T_{(V)}(q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu)
\quad (\because \hat{Y}_\mu=q_{12}\psi_\mu^\dagger+q_{22}\psi_\mu) \\
&= q_{12}T_{(V)}(\psi_\mu^\dagger) + q_{22}T_{(V)}(\psi_\mu)
\quad (\because T_{(V)} \text{ の線型性}) \\
&= q_{12}T_{(V')}(\psi_\mu^\dagger) + q_{22}T_{(V')}(\psi_\mu)
\quad (\because \text{直前の二つの作用の一致}) \\
&= T_{(V')}(q_{12}\psi_\mu^\dagger + q_{22}\psi_\mu)
\quad (\because T_{(V')} \text{ の線型性}) \\
&= T_{(V')}(\hat{Y}_\mu)
\quad (\because q_{12}\psi_\mu^\dagger+q_{22}\psi_\mu=\hat{Y}_\mu).
\end{aligned}`),
      paragraph(["場合 2: ", math(String.raw`\gamma_2(\theta_\mu) = 0`), "。", math(String.raw`T_{(V)}`), " について、", "〔T_V_hatZ_hatY〕", " と ", "〔A_theta_is_identity_when_gamma2_zero〕", " より"]),
      displayMath(String.raw`\begin{aligned}
(T_{(V)}(\hat{Z}_\mu^{(-)}),\, T_{(V)}(\hat{Y}_\mu))
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)A(\theta_\mu)
\quad (\because \text{T\_V\_hatZ\_hatY}) \\
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)I
\quad (\because \gamma_2(\theta_\mu)=0\text{ のとき }A(\theta_\mu)=I\text{：A\_theta\_is\_identity\_when\_gamma2\_zero}) \\
&= (\hat{Z}_\mu^{(-)},\, \hat{Y}_\mu)
\quad (\because \text{単位行列との積})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`), "、", math(String.raw`T_{(V)}(\hat{Y}_\mu) = \hat{Y}_\mu`), "。", math(String.raw`T_{(V')}`), " について ", "〔T_Vprime_fixes_hatZ_hatY_when_gamma2_zero〕", " より ", math(String.raw`T_{(V')}(\hat{Z}_\mu^{(-)}) = \hat{Z}_\mu^{(-)}`), "、", math(String.raw`T_{(V')}(\hat{Y}_\mu) = \hat{Y}_\mu`), "。したがって両者は一致する。"]),
      paragraph(["結論: 場合 1, 2 いずれでも ", math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)})`), "、", math(String.raw`T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`), " が成り立つ。", math(String.raw`\mu \in \mathcal{M}`), " は任意であったから、主張が示された。"]),
    ],
  },
  {
    id: "note_evenfermi_008_claim_T_eq_integer_route_TV1_hatZ_hatY_039_claim_T_V_eq_T_Vprime",
    targets: ["T_V_plus_eq_T_check_Vprime"],
    title: { tex: String.raw`T_{(V)} = T_{(V')}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/038_claim_T_V_eq_T_Vprime.typ", ordinal: 39 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_039_claim_T_V_eq_T_Vprime。labels: T_V_eq_T_Vprime。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`T_{(V)} = T_{(V')}`),
      paragraph(["すなわち、任意の ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " に対して ", math(String.raw`T_{(V)}(x) = T_{(V')}(x)`), " である。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: ", math(String.raw`T_{(V)}`), " と ", math(String.raw`T_{(V')}`), " は単位的環準同型かつ線型である。"]),
      paragraph(["〔def_T_V〕", " より、任意の ", math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`), " について"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(X)
&= T_{(V_1^{(\pm)})^{1/2}}\!\left(T_{V_2}\!\left(T_{(V_1^{(\pm)})^{1/2}}(X)\right)\right)
&&\bigl(\because\ \text{\cref{lab:def_T_V}}\bigr)
\end{aligned}`),
      paragraph(["である。すなわち ", math(String.raw`T_{(V)} = T_{(V_1^{(\pm)})^{1/2}} \circ T_{V_2} \circ T_{(V_1^{(\pm)})^{1/2}}`), " である。各因子 ", math(String.raw`T_{(V_1^{(\pm)})^{1/2}},\ T_{V_2}`), " は ", math(String.raw`T_g`), "（", ref("def_T_g"), "）の形であり、", "〔def_T_V〕", " で ", math(String.raw`T_g`), " が用いられている時点で ", math(String.raw`(V_1^{(\pm)})^{1/2},\ V_2`), " は可逆である。"]),
      displayMath(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`),
      paragraph(["とおく。可逆行列の積は可逆だから ", math(String.raw`V`), " は可逆である。", ref("conjugation_is_ring_homomorphism"), " の合成則を 2 回適用すると、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}
&= T_{(V_1^{(\pm)})^{1/2}} \circ T_{V_2} \circ T_{(V_1^{(\pm)})^{1/2}}
   \quad (\because \text{def\_T\_V}) \\
&= T_{(V_1^{(\pm)})^{1/2} V_2} \circ T_{(V_1^{(\pm)})^{1/2}}
   \quad (\because \text{conjugation\_is\_ring\_homomorphism}) \\
&= T_{(V_1^{(\pm)})^{1/2} V_2 (V_1^{(\pm)})^{1/2}}
   \quad (\because \text{conjugation\_is\_ring\_homomorphism}) \\
&= T_V
   \quad (\because V=(V_1^{(\pm)})^{1/2}V_2(V_1^{(\pm)})^{1/2})
\end{aligned}`),
      paragraph(["が成り立つ。よって ", math(String.raw`T_{(V)} = T_V`), " であり、", math(String.raw`V`), " は可逆だから ", ref("conjugation_is_ring_homomorphism"), " より ", math(String.raw`T_{(V)}`), " は乗法的かつ単位的（", math(String.raw`T_{(V)}(I) = I`), "）であり、", ref("mat_conj"), " より線型である。"]),
      paragraph([math(String.raw`T_{(V')}`), " は ", math(String.raw`T_g`), "（", ref("def_T_g"), "）の ", math(String.raw`g = V'`), " の場合であり、", "〔def_Vprime〕", " より ", math(String.raw`V'`), " は可逆である。したがって ", ref("conjugation_is_ring_homomorphism"), " より ", math(String.raw`T_{(V')}`), " は乗法的かつ単位的であり、", ref("mat_conj"), " より線型である。"]),
      paragraph(["Step 2: ", math(String.raw`T_{(V)}`), " と ", math(String.raw`T_{(V')}`), " は各 ", math(String.raw`Z_m, Y_m`), " 上で一致する。"]),
      paragraph(["各 ", math(String.raw`m \in \{1,\dots,M\}`), " について、", "〔recover_Z_Y_from_hatZ_hatY〕", " より"]),
      displayMath(String.raw`\begin{aligned}
Z_m
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)
&&\bigl(\because\ \text{\cref{lab:recover_Z_Y_from_hatZ_hatY}}\bigr) \\
Y_m
&= \frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)
&&\bigl(\because\ \text{\cref{lab:recover_Z_Y_from_hatZ_hatY}}\bigr)
\end{aligned}`),
      paragraph(["が成り立つ。", math(String.raw`T_{(V)}, T_{(V')}`), " は線型（Step 1）であり、", "〔T_V_eq_T_Vprime_on_hatZ_hatY〕", " より各 ", math(String.raw`\mu \in \mathcal{M}`), " で ", math(String.raw`T_{(V)}(\hat{Z}_\mu^{(-)}) = T_{(V')}(\hat{Z}_\mu^{(-)})`), " かつ ", math(String.raw`T_{(V)}(\hat{Y}_\mu) = T_{(V')}(\hat{Y}_\mu)`), " であるから、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(Z_m)
&= T_{(V)}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V)}(\hat{Z}_\mu^{(-)})
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V')}(\hat{Z}_\mu^{(-)})
   \quad (\because \text{T\_V\_eq\_T\_Vprime\_on\_hatZ\_hatY}) \\
&= T_{(V')}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Z}_\mu^{(-)}\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because T_{(V')}\text{ の線型性}) \\
&= T_{(V')}(Z_m)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY})
\end{aligned}`),
      paragraph(["が成り立つ。同様に、"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(Y_m)
&= T_{(V)}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V)}(\hat{Y}_\mu)
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \frac{1}{M}\sum_{\mu=1}^M \exp\!\left(i\,m\frac{2\pi\mu}{M}\right) T_{(V')}(\hat{Y}_\mu)
   \quad (\because \text{T\_V\_eq\_T\_Vprime\_on\_hatZ\_hatY}) \\
&= T_{(V')}\!\left(\frac{1}{M}\sum_{\mu=1}^M \hat{Y}_\mu\exp\!\left(i\,m\frac{2\pi\mu}{M}\right)\right)
   \quad (\because T_{(V')}\text{ の線型性}) \\
&= T_{(V')}(Y_m)
   \quad (\because \text{recover\_Z\_Y\_from\_hatZ\_hatY})
\end{aligned}`),
      paragraph(["が成り立つ。よってすべての ", math(String.raw`m \in \{1,\dots,M\}`), " について"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(Z_m)
&= T_{(V')}(Z_m)
   \quad (\because \text{直前の }Z_m\text{ に対する式変形}) \\
T_{(V)}(Y_m)
&= T_{(V')}(Y_m)
   \quad (\because \text{直前の }Y_m\text{ に対する式変形})
\end{aligned}`),
      paragraph(["である。"]),
      paragraph(["Step 3: 一致する元の集合は、和・スカラー倍・積で閉じ、単位元を含む。"]),
      paragraph(["集合"]),
      displayMath(String.raw`\mathcal{E} := \left\{\, x \in \mathrm{Mat}(2^M,\mathbb{C}) \;:\; T_{(V)}(x) = T_{(V')}(x) \,\right\}`),
      paragraph(["を考える。", math(String.raw`\mathcal{E}`), " が ", math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`), " の部分集合として、和・スカラー倍・積について閉じ、単位元を含むことを示す。"]),
      paragraph(["（加法・スカラー倍について閉じる）", math(String.raw`x, y \in \mathcal{E}`), " と ", math(String.raw`\alpha, \beta \in \mathbb{C}`), " について、", math(String.raw`T_{(V)}, T_{(V')}`), " は線型（Step 1）であるから"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(\alpha x + \beta y)
&= \alpha T_{(V)}(x) + \beta T_{(V)}(y)
   \quad (\because T_{(V)}\text{ の線型性}) \\
&= \alpha T_{(V')}(x) + \beta T_{(V')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(V')}(\alpha x + \beta y)
   \quad (\because T_{(V')}\text{ の線型性})
\end{aligned}`),
      displayMath(String.raw`\alpha x + \beta y \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`),
      paragraph(["（積について閉じる）", math(String.raw`x, y \in \mathcal{E}`), " について、", math(String.raw`T_{(V)}, T_{(V')}`), " は乗法的（Step 1）であるから"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(x y)
&= T_{(V)}(x)\, T_{(V)}(y)
   \quad (\because T_{(V)}\text{ の乗法性、conjugation\_is\_ring\_homomorphism}) \\
&= T_{(V')}(x)\, T_{(V')}(y)
   \quad (\because x, y \in \mathcal{E}) \\
&= T_{(V')}(x y)
   \quad (\because T_{(V')}\text{ の乗法性、conjugation\_is\_ring\_homomorphism})
\end{aligned}`),
      displayMath(String.raw`x y \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`),
      paragraph(["（単位元を含む）Step 1 の単位性より"]),
      displayMath(String.raw`\begin{aligned}
T_{(V)}(I)
&= I
\quad (\because T_{(V)}\text{ の単位性}) \\
&= T_{(V')}(I)
\quad (\because T_{(V')}\text{ の単位性})
\end{aligned}`),
      displayMath(String.raw`I \in \mathcal{E}
\quad (\because\ \mathcal{E}\ \text{の定義と直前の等式})`),
      paragraph(["以上より ", math(String.raw`\mathcal{E}`), " は単位元を含み、和・スカラー倍・積について閉じる ", math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`), " の部分集合である。"]),
      paragraph(["Step 4: 結論。"]),
      paragraph(["Step 2 より ", math(String.raw`Z_1,\dots,Z_M, Y_1,\dots,Y_M \in \mathcal{E}`), " である。", math(String.raw`\mathcal{E}`), " は ", math(String.raw`S := \{Z_1,\dots,Z_M, Y_1,\dots,Y_M\}`), " を含み、和・スカラー倍・積について閉じ、単位元を含む（Step 3）。したがって、", math(String.raw`S`), " を含み和・スカラー倍・積について閉じ単位元を含む最小の部分集合 ", math(String.raw`\mathcal{A}`), "（", ref("Z_Y_generate_algebra"), " の ", math(String.raw`\mathcal{A}`), "）について ", math(String.raw`\mathcal{A} \subseteq \mathcal{E}`), " である。", ref("Z_Y_generate_algebra"), " より ", math(String.raw`\mathcal{A} = \mathrm{Mat}(2^M,\mathbb{C})`), " であるから、"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{Mat}(2^M,\mathbb{C})
&= \mathcal{A}
&& (\because \text{Z\_Y\_generate\_algebra}) \\
&\subseteq \mathcal{E}
&& (\because \mathcal{E}\ \text{は生成元を含み、和・スカラー倍・積について閉じ、単位元を含む}) \\
&\subseteq \mathrm{Mat}(2^M,\mathbb{C})
&& (\because \mathcal{E}\ \text{の定義})
\end{aligned}`),
      paragraph(["したがって"]),
      displayMath(String.raw`\mathcal{E} = \mathrm{Mat}(2^M,\mathbb{C})
\quad (\because\ \text{二つの包含による集合の相等})`),
      paragraph(["である。任意の ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " について"]),
      displayMath(String.raw`T_{(V)}(x) = T_{(V')}(x)
\quad (\because\ x\in\mathcal{E}\ \text{と}\ \mathcal{E}\ \text{の定義})`),
      paragraph(["なので"]),
      displayMath(String.raw`T_{(V)} = T_{(V')}
\quad (\because\ \text{写像の相等は全ての入力での値の相等})`),
      paragraph(["が成り立つことを意味する。"]),
    ],
  },
  {
    id: "note_evenfermi_009_claim_V_plus_eq_c_Vprime_integer_route_TV1_hatZ_hatY_040_claim_V_eq_cVprime",
    targets: ["V_plus_eq_c_check_Vprime"],
    title: { tex: String.raw`V = c V' \text{（定数倍を除いて一致）}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ", ordinal: 40 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_040_claim_V_eq_cVprime。labels: V_eq_Vprime。以下は本文にあったときの内容のまま。）"]),
      paragraph(["ある ", math(String.raw`c \in \mathbb{C}^\times`), " が存在して、"]),
      displayMath(String.raw`V = c \cdot V'`),
      paragraph(["ここで ", math(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`), "（", "〔def_T_V〕", " で導入され、", "〔T_V_eq_T_Vprime〕", " の Step 1 で ", math(String.raw`T_{(V)} = T_V`), " が示された行列）とする。"]),
      paragraph(["証明."]),
      paragraph(["Step 1: ", math(String.raw`W := V'^{-1} V`), " は可逆である。"]),
      paragraph(["〔T_V_eq_T_Vprime〕", " の Step 1 より、", math(String.raw`V := (V_1^{(\pm)})^{1/2}\, V_2\, (V_1^{(\pm)})^{1/2}`), " は可逆である。また ", "〔def_Vprime〕", " より ", math(String.raw`V'`), " は可逆であり、可逆行列の逆行列 ", math(String.raw`V'^{-1}`), " も可逆である。"]),
      displayMath(String.raw`W := V'^{-1} V`),
      paragraph(["とおく。可逆行列の積は可逆であるから ", math(String.raw`W`), " は可逆である。特に ", math(String.raw`W`), " の逆行列 ", math(String.raw`W^{-1}`), " が存在する。"]),
      paragraph(["左から ", math(String.raw`V'`), " を掛けると"]),
      displayMath(String.raw`\begin{aligned}
V' W
&= V'(V'^{-1} V)
   \quad (\because W = V'^{-1} V) \\
&= (V' V'^{-1}) V
   \quad (\because \text{行列の積の結合法則}) \\
&= I_{\mathrm{Mat}(2^M,\mathbb{C})}\, V
   \quad (\because V' V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= V
   \quad (\because \text{単位元の性質})
\end{aligned}`),
      paragraph(["すなわち"]),
      displayMath(String.raw`V = V' W`),
      paragraph(["を得る。"]),
      paragraph(["Step 2: ", math(String.raw`W`), " はすべての ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " と可換である。"]),
      paragraph(["〔T_V_eq_T_Vprime〕", " より ", math(String.raw`T_{(V)} = T_{(V')}`), " であり、", "〔T_V_eq_T_Vprime〕", " の Step 1 で示された ", math(String.raw`T_{(V)} = T_V`), " と合わせると、任意の ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " について"]),
      displayMath(String.raw`\begin{aligned}
T_V(x)
&= T_{(V)}(x)
   \quad (\because \text{T\_V\_eq\_T\_Vprime の Step 1: } T_{(V)} = T_V) \\
&= T_{(V')}(x)
   \quad (\because \text{T\_V\_eq\_T\_Vprime}: T_{(V)} = T_{(V')})
\end{aligned}`),
      paragraph(["が成り立つ。両辺を ", ref("mat_conj"), " の共役写像の定義で書き下すと、任意の ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\begin{aligned}
V x V^{-1}
&= T_V(x)
   \quad (\because \text{mat\_conj}) \\
&= T_{(V')}(x)
   \quad (\because \text{上の等式}) \\
&= V' x V'^{-1}
   \quad (\because \text{mat\_conj})
\end{aligned}`),
      paragraph(["すなわち"]),
      displayMath(String.raw`V x V^{-1} = V' x V'^{-1}`),
      paragraph(["である。"]),
      paragraph(["ここで Step 1 の ", math(String.raw`V = V' W`), " を代入する。まず逆行列について、", ref("conjugation_is_ring_homomorphism"), " の Step 3 で確認された積の逆元の公式 ", math(String.raw`(AB)^{-1} = B^{-1}A^{-1}`), " より"]),
      displayMath(String.raw`\begin{aligned}
V^{-1}
&= (V' W)^{-1}
   \quad (\because V = V' W) \\
&= W^{-1} V'^{-1}
   \quad (\because (AB)^{-1} = B^{-1}A^{-1})
\end{aligned}`),
      paragraph(["が成り立つ。これらを上の等式 ", math(String.raw`V x V^{-1} = V' x V'^{-1}`), " の左辺に代入すると、任意の ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\begin{aligned}
V'\left(W x W^{-1}\right)V'^{-1}
&= (V' W)\, x\, (W^{-1} V'^{-1})
   \quad (\because \text{行列の積の結合法則}) \\
&= V x V^{-1}
   \quad (\because V = V' W,\ V^{-1} = W^{-1}V'^{-1}) \\
&= V' x V'^{-1}
   \quad (\because V x V^{-1} = V' x V'^{-1})
\end{aligned}`),
      paragraph(["が成り立つ。両辺に左から ", math(String.raw`V'^{-1}`), "、右から ", math(String.raw`V'`), " を掛けると、任意の ", math(String.raw`x`), " について"]),
      displayMath(String.raw`\begin{aligned}
W x W^{-1}
&= V'^{-1}\left(V'\left(W x W^{-1}\right)V'^{-1}\right)V'
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= V'^{-1}\left(V' x V'^{-1}\right)V'
   \quad (\because V'(W x W^{-1})V'^{-1} = V' x V'^{-1}) \\
&= x
   \quad (\because V'^{-1}V' = V'V'^{-1} = I_{\mathrm{Mat}(2^M,\mathbb{C})})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`W x W^{-1} = x`), " である。両辺に右から ", math(String.raw`W`), " を掛けると、任意の ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " について"]),
      displayMath(String.raw`\begin{aligned}
W x
&= (W x W^{-1}) W
   \quad (\because W^{-1}W = I_{\mathrm{Mat}(2^M,\mathbb{C})}) \\
&= x W
   \quad (\because W x W^{-1} = x)
\end{aligned}`),
      paragraph(["が成り立つ。したがって ", math(String.raw`W`), " はすべての ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " と可換である。"]),
      paragraph(["Step 3: ", math(String.raw`W`), " はスカラーである。"]),
      paragraph(["Step 2 より ", math(String.raw`W`), " はすべての ", math(String.raw`x \in \mathrm{Mat}(2^M,\mathbb{C})`), " と可換であるから、", ref("centralizer_is_scalar"), " より、ある ", math(String.raw`c \in \mathbb{C}`), " が存在して"]),
      displayMath(String.raw`W = c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}
\quad (\because \text{centralizer\_is\_scalar})`),
      paragraph(["が成り立つ。"]),
      paragraph(["Step 4: ", math(String.raw`c \neq 0`), " であること。"]),
      paragraph(["Step 1 より ", math(String.raw`W`), " は可逆である。仮に ", math(String.raw`c = 0`), " ならば ", math(String.raw`W = 0\cdot I_{\mathrm{Mat}(2^M,\mathbb{C})} = O`), "（零行列）となるが、零行列は可逆でない（任意の ", math(String.raw`A`), " について ", math(String.raw`O A = O \neq I_{\mathrm{Mat}(2^M,\mathbb{C})}`), "）から、", math(String.raw`W`), " が可逆であることに矛盾する。よって ", math(String.raw`c \neq 0`), "、すなわち ", math(String.raw`c \in \mathbb{C}^\times`), " である。"]),
      paragraph(["Step 5: 結論。"]),
      paragraph(["Step 1 の ", math(String.raw`V = V' W`), " に Step 3 の ", math(String.raw`W = c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " を代入すると"]),
      displayMath(String.raw`\begin{aligned}
V
&= V' W
   \quad (\because \text{Step 1}) \\
&= V'\left(c \cdot I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
   \quad (\because \text{Step 3}) \\
&= c \cdot \left(V' I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)
   \quad (\because \text{スカラー倍と行列積の可換性}) \\
&= c \cdot V'
   \quad (\because \text{単位元の性質})
\end{aligned}`),
      paragraph(["が成り立つ。Step 4 より ", math(String.raw`c \in \mathbb{C}^\times`), " であるから、求める ", math(String.raw`c \in \mathbb{C}^\times`), " が存在して ", math(String.raw`V = c \cdot V'`), " である。"]),
    ],
  },
  {
    id: "note_evenfermi_002_claim_periodicity_integer_route_TV1_hatZ_hatY_041_claim_gamma2_periodicity",
    targets: ["periodicity_of_check_fermi"],
    title: { tex: String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M}),\;
\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/040_claim_gamma2_thetaMの周期性.typ", ordinal: 41 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_041_claim_gamma2_periodicity。labels: gamma2_theta_M_periodicity。以下は本文にあったときの内容のまま。）"]),
      displayMath(String.raw`\gamma_2(\theta_M) = \gamma_2(\theta_{-M}), \quad
\gamma_2(-\theta_M) = \gamma_2(-\theta_{-M})`),
      paragraph(["証明."]),
      paragraph([math(String.raw`\theta_M = 2\pi`), "、", math(String.raw`\theta_{-M} = -2\pi`), " である。したがって ", math(String.raw`\theta_M`), " と ", math(String.raw`\theta_{-M}`), " の指数関数・余弦・正弦の値はそれぞれ一致する。"]),
      displayMath(String.raw`\begin{aligned}
\exp(i\theta_M)
&= \exp(2\pi i)
&& (\because\ \theta_M=2\pi) \\
&= 1
&& (\because\ \exp(2\pi i)=1) \\
&= \exp(-2\pi i)
&& (\because\ \exp(-2\pi i)=1) \\
&= \exp(i\theta_{-M})
&& (\because\ \theta_{-M}=-2\pi), \\
\cos\theta_M
&= \cos 2\pi
&& (\because\ \theta_M=2\pi) \\
&= 1
&& (\because\ \cos 2\pi=1) \\
&= \cos(-2\pi)
&& (\because\ \cos(-2\pi)=1) \\
&= \cos\theta_{-M}
&& (\because\ \theta_{-M}=-2\pi), \\
\sin\theta_M
&= \sin 2\pi
&& (\because\ \theta_M=2\pi) \\
&= 0
&& (\because\ \sin 2\pi=0) \\
&= \sin(-2\pi)
&& (\because\ \sin(-2\pi)=0) \\
&= \sin\theta_{-M}
&& (\because\ \theta_{-M}=-2\pi).
\end{aligned}`),
      paragraph([ref("def_A_theta"), " にこれらの値を代入すると、"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_M)
&= i \cdot 1 \cdot s_2^*(c_1 \cdot 1 - i \cdot 0 - s_1 c_2)
&& (\because\ \text{def\_A\_theta と上の指数関数・余弦・正弦の値}) \\
&= i\,s_2^*(c_1-s_1c_2)
&& (\because\ \text{複素数の四則演算}) \\
&= \gamma_2(\theta_{-M})
&& (\because\ \text{def\_A\_theta と上の指数関数・余弦・正弦の値}), \\
\gamma_2(-\theta_M)
&= i \cdot 1 \cdot s_2^*(c_1 \cdot 1 - i \cdot 0 - s_1 c_2)
&& (\because\ -\theta_M=-2\pi\ \text{と def\_A\_theta}) \\
&= i\,s_2^*(c_1-s_1c_2)
&& (\because\ \text{複素数の四則演算}) \\
&= \gamma_2(-\theta_{-M})
&& (\because\ -\theta_{-M}=2\pi\ \text{と def\_A\_theta}).
\end{aligned}`),
    ],
  },
  {
    id: "note_TV1_hatZ_hatY_044_claim_critical_condition_integer_route_TV1_hatZ_hatY_044_claim_critical_condition_gamma2_zero_part",
    targets: ["critical_condition_c1_eq_s1_c2"],
    title: { tex: String.raw`c_1 = s_1 c_2 \text{ は臨界条件 } s_1 s_2 = 1 \text{ と同値}` },
    origin: { path: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/043_claim_臨界条件_c1_eq_s1c2.typ", ordinal: 44 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/008_TV1_hatZ_hatY_part2.ts の主張ブロック TV1_hatZ_hatY_044_claim_critical_condition。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph(["この同値性から、", math(String.raw`\gamma_2`), " の零点と Ising 模型の臨界点が対応する。実際 ", "〔gamma_2_theta_is_0〕", " より、", math(String.raw`\mu \in \mathcal{M}`), " について ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " となるのは ", math(String.raw`\mu = \pm M`), "（すなわち ", math(String.raw`\theta_\mu = \pm 2\pi`), "、", math(String.raw`\cos\theta_\mu = 1`), "）かつ ", math(String.raw`c_2 s_1 = c_1`), " のときに限るから、", math(String.raw`\gamma_2(\theta_M) = 0`), "（フェルミオン ", math(String.raw`\psi_M`), " が ", "〔def_fermi〕", " で未定義になる特異点）であることと Ising 模型の臨界点 ", math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`), " であることは同値である。"]),
      paragraph(["証明."]),
      paragraph(["Step 3: ", math(String.raw`\gamma_2`), " の零点と臨界点の対応（statement 後半）の導出。", "〔gamma_2_theta_is_0〕", " より、", math(String.raw`\mu \in \mathcal{M}`), " について"]),
      displayMath(String.raw`\gamma_2(\theta_\mu) = 0
\iff \begin{cases} \mu = \pm M \\ c_1 = s_1 c_2 \end{cases}`),
      paragraph(["である。右辺の第 2 条件 ", math(String.raw`c_1 = s_1 c_2`), " は ", math(String.raw`\mu`), " に依存しない。特に ", math(String.raw`\mu = M \in \mathcal{M}`), " をとれば第 1 条件は自動的に満たされるから"]),
      displayMath(String.raw`\begin{aligned}
\gamma_2(\theta_M)=0
&\iff c_1=s_1c_2
&& (\because\ \mu=M\ \text{では第 1 条件}\ \mu=\pm M\ \text{が成り立つ})\\
&\iff s_1s_2=1
&& (\because\ \text{Step 1 と Step 2})\\
&\iff \sinh 2K_1\sinh 2K_2=1
&& (\because\ s_1=\sinh 2K_1,\ s_2=\sinh 2K_2\text{、}\blkref{def_transfer_matrix_symbols})
\end{aligned}`),
      paragraph(["〔def_fermi〕", " において ", math(String.raw`\psi_M, \psi_M^\dagger`), " は正規化因子 ", math(String.raw`1/(2\sqrt{M}\,\gamma_2(-\theta_M))`), " を含むため ", math(String.raw`\gamma_2(\theta_M) = 0`), "（", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(-\theta_M) = 0`), " と同値）のとき定義されない。よって「", math(String.raw`\psi_M`), " が定義されない特異点であること」と「Ising 模型の臨界点 ", math(String.raw`\sinh 2K_1 \sinh 2K_2 = 1`), " であること」は同値である。"]),
      paragraph(["なお ", math(String.raw`c_1 \neq s_1 c_2`), " のとき（すなわち ", math(String.raw`s_1 s_2 \neq 1`), " のとき）は、上の同値より、すべての ", math(String.raw`\mu \in \mathcal{M}`), " について ", math(String.raw`\gamma_2(\theta_\mu) \neq 0`), " である。"]),
    ],
  },
  {
    id: "note_evenEigen_010_theorem_eigenvalues_of_V_plus_integer_route_eigenvalues_of_V_000_remark_overview",
    targets: ["eigenvalues_of_V_plus"],
    title: { text: "この章の目的" },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 2 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の注意ブロック eigenvalues_of_V_000_remark_overview。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔V_eq_Vprime〕", " により、ある ", math(String.raw`c \in \mathbb{C}^\times`), " が存在して ", math(String.raw`V = c V'`), " が成り立つ。しかし ", math(String.raw`c`), " の値そのものは決まっていない。この章では ", math(String.raw`c`), " を決定し、あわせて ", math(String.raw`V`), " の固有値をすべて求める。結論は"]),
      displayMath(String.raw`c = (2\sinh 2K_2)^{M/2}, \qquad
V = (2\sinh 2K_2)^{M/2}\,V'`),
      paragraph(["であり、", math(String.raw`V`), " の固有値は ", math(String.raw`\epsilon = (\epsilon_\mu)`), "（各 ", math(String.raw`\epsilon_\mu \in \{0,1\}`), "）でパラメトライズされた"]),
      displayMath(String.raw`\Lambda_\epsilon = (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)`),
      paragraph(["である。ここで ", math(String.raw`\mathcal{I}`), " は ", "〔def_Vprime〕", " の和に現れる添字の集合である。"]),
      paragraph(["この章で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（", ref("def_exp"), "）、および実数の ", math(String.raw`\cosh, \sinh, \mathrm{arccosh}`), " だけである。行列式は使わない。"]),
    ],
  },
  {
    id: "note_evenEigen_001_definition_check_number_operator_integer_route_eigenvalues_of_V_004_definition_number_operator",
    targets: ["def_check_number_operator"],
    title: { tex: String.raw`\text{フェルミオン数演算子 } n_\mu` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 6 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の定義ブロック eigenvalues_of_V_004_definition_number_operator。labels: def_number_operator。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔def_fermi〕", " および ", "〔def_Vprime〕", " と同じく"]),
      displayMath(String.raw`\mathcal{M} := \{-M,\dots,-1,1,\dots,M\}, \qquad
\mathcal{I} := \{\mu \in \{1,\dots,M\} \mid \gamma_2(\theta_\mu) \neq 0\},
\qquad m := |\mathcal{I}|`),
      paragraph(["とおく（", math(String.raw`\mathcal{M}`), " は ", "〔def_fermi〕", " で ", math(String.raw`\psi_\mu, \psi_\mu^\dagger`), " の添字が走る集合、", math(String.raw`\mathcal{I}`), " は ", "〔def_Vprime〕", " の和に現れる添字の集合である）。定義から ", math(String.raw`\mathcal{I} \subseteq \{1,\dots,M\} \subset \mathcal{M}`), " であり、", math(String.raw`\mu \in \mathcal{I}`), " なら ", math(String.raw`-\mu \in \{-M,\dots,-1\} \subset \mathcal{M}`), " でもある。"]),
      paragraph([math(String.raw`\mu \in \mathcal{I}`), " について、", "〔relation_of_gamma_2〕", " より ", math(String.raw`\gamma_2(-\theta_\mu) \neq 0`), " すなわち ", math(String.raw`\gamma_2(\theta_{-\mu}) \neq 0`), " でもあるから、", "〔def_fermi〕", " により ", math(String.raw`\psi_\mu^\dagger`), " と ", math(String.raw`\psi_{-\mu}`), " がともに定義される。そこで"]),
      displayMath(String.raw`n_\mu := \psi_\mu^\dagger \psi_{-\mu} \in \mathrm{Mat}(2^M,\mathbb{C})
\qquad (\mu \in \mathcal{I})`),
      paragraph(["と定める。", "〔gamma_2_theta_is_0〕", " より ", math(String.raw`\gamma_2(\theta_\mu) = 0`), " となる ", math(String.raw`\mu \in \{1,\dots,M\}`), " は臨界条件下の ", math(String.raw`\mu = M`), " に限られるので、臨界点でなければ ", math(String.raw`\mathcal{I} = \{1,\dots,M\}`), "（", math(String.raw`m = M`), "）、臨界点では ", math(String.raw`\mathcal{I} = \{1,\dots,M-1\}`), "（", math(String.raw`m = M-1`), "）である。"]),
      paragraph(["なお ", "〔def_fermi〕", " の ", math(String.raw`\psi_\mu, \psi_\mu^\dagger`), " の係数に現れる平方根 ", math(String.raw`\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}`), " は ", ref("def_sqrt_cc"), " で定めた**単一値の写像** ", math(String.raw`\sqrt{\cdot}:\mathbb{C}\to\mathbb{C}`), " の値であり、添字 ", math(String.raw`\mu`), " ごとに ", math(String.raw`\pm`), " を選ぶ自由度は無い。この一意性は ", "〔anticommutator_of_psi〕", " の反交換関係の成立そのものに効いており（同 Claim の Step 0）、以下で ", "〔anticommutator_of_psi〕", " を添字対 ", math(String.raw`(\mu,\mu)`), "、", math(String.raw`(\mu,-\mu)`), "、", math(String.raw`(\mu,-\nu)`), "、", math(String.raw`(-\mu,\nu)`), " へ適用するときも、この単一の値をそのまま使う。"]),
      paragraph(["この記号のもとで ", "〔def_Vprime〕", " の ", math(String.raw`V'`), " は"]),
      displayMath(String.raw`V' = \exp(X), \qquad
X := \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(n_\mu - \tfrac{1}{2}
I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)`),
      paragraph(["と書ける。"]),
    ],
  },
  {
    id: "note_evenEigen_002_claim_check_number_operator_idempotent_integer_route_eigenvalues_of_V_005_claim_number_operator_idempotent",
    targets: ["check_number_operator_idempotent"],
    title: { tex: String.raw`n_\mu^2 = n_\mu` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 7 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_005_claim_number_operator_idempotent。labels: number_operator_idempotent。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{I}`), " について、"]),
      list([[math(String.raw`\text{(1)}\quad (\psi_\mu^\dagger)^2 = 0, \qquad (\psi_{-\mu})^2 = 0`)], [math(String.raw`\text{(2)}\quad \psi_{-\mu}\psi_\mu^\dagger = I_{\mathrm{Mat}(2^M,\mathbb{C})} - n_\mu`)], [math(String.raw`\text{(3)}\quad n_\mu^2 = n_\mu`)]]),
      paragraph(["以下、", math(String.raw`2^M`), " 次の単位行列 ", math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " を単に ", math(String.raw`I`), " と書く。"]),
      paragraph(["証明."]),
      paragraph(["(1) ", "〔anticommutator_of_psi〕", " の第 1 式 ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu^\dagger]_+ = 0`), " において ", math(String.raw`\nu = \mu`), " と取ると、反交換子の定義 ", math(String.raw`[X,Y]_+ = XY + YX`), " より"]),
      displayMath(String.raw`\begin{aligned}
0
&= [\psi_\mu^\dagger, \psi_\mu^\dagger]_+
&&\bigl(\because\ \text{反交換関係の第 1 式}\bigr)\\
&= \psi_\mu^\dagger\psi_\mu^\dagger + \psi_\mu^\dagger\psi_\mu^\dagger
&&\bigl(\because\ \text{反交換子の定義}\bigr)\\
&= 2(\psi_\mu^\dagger)^2
&&\bigl(\because\ \text{同じ項の和}\bigr)
\end{aligned}`),
      paragraph([math(String.raw`2 \neq 0`), " なので ", math(String.raw`(\psi_\mu^\dagger)^2 = 0`), "。同じく第 3 式 ", math(String.raw`[\psi_\mu, \psi_\nu]_+ = 0`), " を ", math(String.raw`\mu = \nu = -\mu`), " すなわち添字 ", math(String.raw`-\mu`), " について適用して ", math(String.raw`(\psi_{-\mu})^2 = 0`), "（", "〔def_number_operator〕", " より ", math(String.raw`\mu \in \mathcal{I}`), " なので ", math(String.raw`-\mu \in \mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`), " かつ ", math(String.raw`\gamma_2(\theta_{-\mu}) \neq 0`), " であり、", "〔anticommutator_of_psi〕", " の仮定「", math(String.raw`\gamma_2(\theta_\mu)\neq 0`), " かつ ", math(String.raw`\gamma_2(\theta_\nu)\neq 0`), " なる ", math(String.raw`\mu,\nu \in \mathcal{M}`), "」を満たす）。"]),
      paragraph(["(2) ", "〔anticommutator_of_psi〕", " の第 2 式 ", math(String.raw`[\psi_\mu^\dagger, \psi_\nu]_+ = \delta^M_{\mu+\nu,0}\,I`), " において ", math(String.raw`\nu = -\mu`), " と取る。", math(String.raw`\mu + (-\mu) = 0 \equiv 0 \pmod M`), " なので ", ref("def_delta_M"), " より ", math(String.raw`\delta^M_{\mu+(-\mu),0} = 1`), " であり、"]),
      displayMath(String.raw`\begin{aligned}
\psi_{-\mu}\psi_\mu^\dagger
&= I-\psi_\mu^\dagger\psi_{-\mu}
&&\left(\because\ [\psi_\mu^\dagger,\psi_{-\mu}]_+=I\ \text{と行列の加法。}\text{〔anticommutator\_of\_psi〕}\right)\\
&= I-n_\mu
&&\left(\because\ \text{フェルミオン数演算子 }n_\mu\text{ の定義。}\text{〔def\_number\_operator〕}\right)
\end{aligned}`),
      paragraph(["(3) (1)(2) を使って"]),
      displayMath(String.raw`\begin{aligned}
n_\mu^2
&= (\psi_\mu^\dagger\psi_{-\mu})(\psi_\mu^\dagger\psi_{-\mu})
&&\bigl(\because\ \text{フェルミオン数演算子 } n_\mu \text{ の定義}\bigr)\\
&= \psi_\mu^\dagger\left(\psi_{-\mu}\psi_\mu^\dagger\right)\psi_{-\mu}
&&\bigl(\because\ \text{行列の積の結合法則}\bigr)\\
&= \psi_\mu^\dagger\left(I - n_\mu\right)\psi_{-\mu}
&&\bigl(\because\ \text{(2)}\bigr)\\
&= \psi_\mu^\dagger\psi_{-\mu} - \psi_\mu^\dagger n_\mu \psi_{-\mu}
&&\bigl(\because\ \text{行列の積の分配法則}\bigr)\\
&= n_\mu - \psi_\mu^\dagger\left(\psi_\mu^\dagger\psi_{-\mu}\right)\psi_{-\mu}
&&\bigl(\because\ n_\mu = \psi_\mu^\dagger\psi_{-\mu}\bigr)\\
&= n_\mu - (\psi_\mu^\dagger)^2\,(\psi_{-\mu})^2
&&\bigl(\because\ \text{結合法則}\bigr)\\
&= n_\mu - 0 \cdot 0
&&\bigl(\because\ \text{(1)}\bigr)\\
&= n_\mu
&&\bigl(\because\ \text{零行列との積と差}\bigr)
\end{aligned}`),
    ],
  },
  {
    id: "note_evenEigen_003_claim_check_number_operators_commute_integer_route_eigenvalues_of_V_006_claim_number_operators_commute",
    targets: ["check_number_operators_commute"],
    title: { tex: String.raw`n_\mu n_\nu = n_\nu n_\mu` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 8 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_006_claim_number_operators_commute。labels: number_operators_commute。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu, \nu \in \mathcal{I}`), " が ", math(String.raw`\mu \neq \nu`), " を満たすとき、"]),
      list([[math(String.raw`\text{(1)}\quad \psi_\mu^\dagger n_\nu = n_\nu \psi_\mu^\dagger, \qquad
\psi_{-\mu} n_\nu = n_\nu \psi_{-\mu}`)], [math(String.raw`\text{(2)}\quad n_\mu n_\nu = n_\nu n_\mu`)]]),
      paragraph(["証明."]),
      paragraph(["Step 1（4 つの反交換関係）。", math(String.raw`\mu, \nu \in \mathcal{I} \subseteq \{1,\dots,M\}`), " かつ ", math(String.raw`\mu \neq \nu`), " なので ", math(String.raw`1 \leq |\mu - \nu| \leq M-1`), " であり、とくに ", math(String.raw`\mu - \nu \not\equiv 0 \pmod M`), "。よって ", ref("def_delta_M"), " より ", math(String.raw`\delta^M_{\mu-\nu,0} = \delta^M_{-\mu+\nu,0} = 0`), " である。準備として、同じ次数の正方行列 ", math(String.raw`X, Y`), " について"]),
      displayMath(String.raw`\begin{aligned}
[X,Y]_+
&=XY+YX
&& (\because\ \text{反交換子の定義})\\
&=YX+XY
&& (\because\ \text{行列の加法の交換法則})\\
&=[Y,X]_+
&& (\because\ \text{反交換子の定義})
\end{aligned}`),
      paragraph(["が成り立つ（反交換子の対称性）。", "〔anticommutator_of_psi〕", " を ", math(String.raw`(\mu,\nu)`), "、", math(String.raw`(\mu,-\nu)`), "、", math(String.raw`(\nu,-\mu)`), "、", math(String.raw`(-\mu,-\nu)`), " に適用すると"]),
      displayMath(String.raw`\begin{aligned}
{[\psi_\mu^\dagger, \psi_\nu^\dagger]_+}
&= 0
   \quad (\because \text{〔anticommutator\_of\_psi〕}\text{ の第 1 式}) \\
{[\psi_\mu^\dagger, \psi_{-\nu}]_+}
&= \delta^M_{\mu-\nu,0}\,I
   \quad (\because \text{〔anticommutator\_of\_psi〕}\text{ の第 2 式}) \\
&= 0
   \quad (\because \delta^M_{\mu-\nu,0}=0) \\
{[\psi_{-\mu}, \psi_\nu^\dagger]_+}
&= \delta^M_{-\mu+\nu,0}\,I
   \quad (\because \text{〔anticommutator\_of\_psi〕}\text{ の第 2 式を }(\nu,-\mu)\text{ へ適用し、上の反交換子の対称性}) \\
&= 0
   \quad (\because \delta^M_{-\mu+\nu,0}=0) \\
{[\psi_{-\mu}, \psi_{-\nu}]_+}
&= 0
   \quad (\because \text{〔anticommutator\_of\_psi〕}\text{ の第 3 式})
\end{aligned}`),
      paragraph(["すなわち、", math(String.raw`A \in \{\psi_\mu^\dagger, \psi_{-\mu}\}`), " と ", math(String.raw`B \in \{\psi_\nu^\dagger, \psi_{-\nu}\}`), " のどの組み合わせでも ", math(String.raw`AB = -BA`), " が成り立つ。"]),
      paragraph(["Step 2（(1) の証明）。", math(String.raw`A \in \{\psi_\mu^\dagger, \psi_{-\mu}\}`), " を取ると、Step 1 を 2 回使って"]),
      displayMath(String.raw`\begin{aligned}
A\,n_\nu
&= A\,\psi_\nu^\dagger \psi_{-\nu}
   \quad (\because \text{フェルミオン数演算子 } n_\nu \text{ の定義}) \\
&= (-\psi_\nu^\dagger A)\,\psi_{-\nu}
   \quad (\because A\psi_\nu^\dagger = -\psi_\nu^\dagger A) \\
&= -\psi_\nu^\dagger\,(A \psi_{-\nu})
   \quad (\because \text{結合法則}) \\
&= -\psi_\nu^\dagger\,(-\psi_{-\nu} A)
   \quad (\because A\psi_{-\nu} = -\psi_{-\nu}A) \\
&= \psi_\nu^\dagger \psi_{-\nu} A
   \quad (\because \text{符号の積 } (-1)(-1) = 1 \text{ と結合法則}) \\
&= n_\nu A
   \quad (\because \text{フェルミオン数演算子 } n_\nu \text{ の定義})
\end{aligned}`),
      paragraph(["符号は ", math(String.raw`(-1)^2 = 1`), " となって消える。", math(String.raw`A = \psi_\mu^\dagger`), " と ", math(String.raw`A = \psi_{-\mu}`), " の両方でこれが成り立つ。"]),
      paragraph(["Step 3（(2) の証明）。(1) を 2 回使って"]),
      displayMath(String.raw`\begin{aligned}
n_\mu n_\nu
&= \left(\psi_\mu^\dagger \psi_{-\mu}\right) n_\nu
   \quad (\because \text{フェルミオン数演算子 } n_\mu \text{ の定義}) \\
&= \psi_\mu^\dagger\left(\psi_{-\mu} n_\nu\right)
   \quad (\because \text{結合法則}) \\
&= \psi_\mu^\dagger\left(n_\nu \psi_{-\mu}\right)
   \quad (\because \text{(1) を } A = \psi_{-\mu} \text{ へ適用}) \\
&= \left(\psi_\mu^\dagger n_\nu\right)\psi_{-\mu}
   \quad (\because \text{結合法則}) \\
&= \left(n_\nu \psi_\mu^\dagger\right)\psi_{-\mu}
   \quad (\because \text{(1) を } A = \psi_\mu^\dagger \text{ へ適用}) \\
&= n_\nu\left(\psi_\mu^\dagger\psi_{-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= n_\nu n_\mu
   \quad (\because \text{フェルミオン数演算子 } n_\mu \text{ の定義})
\end{aligned}`),
    ],
  },
  {
    id: "note_evenEigen_004_claim_trace_of_check_number_operator_product_integer_route_eigenvalues_of_V_007_claim_trace_of_number_operator_product",
    targets: ["trace_of_check_number_operator_product"],
    title: { tex: String.raw`\mathrm{tr}\bigl(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\bigr) = 2^{M-k}` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 9 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_007_claim_trace_of_number_operator_product。labels: trace_of_number_operator_product。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\mu \in \mathcal{I}`), " と ", math(String.raw`e \in \{0,1\}`), " に対して"]),
      displayMath(String.raw`R_\mu^{(1)} := n_\mu, \qquad R_\mu^{(0)} := I - n_\mu
\qquad \left(I = I_{\mathrm{Mat}(2^M,\mathbb{C})}\right)`),
      paragraph(["と書く。", math(String.raw`k \in \mathbb{Z}_{\geq 0}`), "、相異なる ", math(String.raw`\mu_1, \dots, \mu_k \in \mathcal{I}`), "、および ", math(String.raw`e_1,\dots,e_k \in \{0,1\}`), " について、"]),
      displayMath(String.raw`\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)} R_{\mu_2}^{(e_2)}\cdots R_{\mu_k}^{(e_k)}\right)
= 2^{M-k}`),
      paragraph(["（", math(String.raw`k = 0`), " のときは空の積を ", math(String.raw`I`), " と読み、", math(String.raw`\mathrm{tr}(I) = 2^M`), " である。）とくに ", math(String.raw`\mathrm{tr}(n_\mu) = \mathrm{tr}(I - n_\mu) = 2^{M-1}`), " であり、値は指数 ", math(String.raw`e_1,\dots,e_k`), " の選び方に依らず、因子の個数 ", math(String.raw`k`), " だけで決まる。"]),
      paragraph(["証明."]),
      paragraph([math(String.raw`n_\mu \in \mathrm{Mat}(2^M,\mathbb{C})`), " であり ", math(String.raw`I = I_{\mathrm{Mat}(2^M,\mathbb{C})}`), " は ", math(String.raw`2^M`), " 次の単位行列なので、", "トレースの基本性質より ", math(String.raw`\mathrm{tr}(I) = 2^M`), " である。", math(String.raw`k`), " に関する帰納法で示す。"]),
      paragraph(["基底段階（", math(String.raw`k = 0`), "）。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(I)
&= 2^M
   \quad (\because \text{トレースの基本性質 (3)。}\blkref{trace_basic_properties}) \\
&= 2^{M-0}
   \quad (\because M-0=M)
\end{aligned}`),
      paragraph(["帰納段階：", math(String.raw`k \geq 1`), " とし、相異なる ", math(String.raw`k-1`), " 個の添字については主張が成り立つと仮定する。相異なる ", math(String.raw`\mu_1,\dots,\mu_k \in \mathcal{I}`), " を取り、"]),
      displayMath(String.raw`P := R_{\mu_2}^{(e_2)} R_{\mu_3}^{(e_3)}\cdots R_{\mu_k}^{(e_k)}`),
      paragraph(["とおく。", math(String.raw`\mu_1 \neq \mu_j`), "（", math(String.raw`j = 2,\dots,k`), "）なので ", "〔number_operators_commute〕", " (1) より ", math(String.raw`\psi_{\mu_1}^\dagger`), " と ", math(String.raw`\psi_{-\mu_1}`), " はどの ", math(String.raw`n_{\mu_j}`), " とも可換である。ゆえに単位行列とも可換であることと分配法則から ", math(String.raw`I-n_{\mu_j}`), " とも可換であり、したがって各 ", math(String.raw`R_{\mu_j}^{(e_j)}`), " および積 ", math(String.raw`P`), " とも可換である。同じく ", "〔number_operators_commute〕", " (2) より ", math(String.raw`n_{\mu_1}`), " と ", math(String.raw`P`), " は可換である。"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\!\left(n_{\mu_1} P\right)
&= \mathrm{tr}\!\left(\psi_{\mu_1}^\dagger \psi_{-\mu_1} P\right)
   \quad (\because \text{フェルミオン数演算子 } n_{\mu_1} \text{ の定義。}\text{〔def\_number\_operator〕}) \\
&= \mathrm{tr}\!\left(\psi_{-\mu_1} P\, \psi_{\mu_1}^\dagger\right)
   \quad (\because \text{巡回性を } A = \psi_{\mu_1}^\dagger,\ B = \psi_{-\mu_1}P \text{ に適用。}\blkref{trace_basic_properties}) \\
&= \mathrm{tr}\!\left(P\, \psi_{-\mu_1}\psi_{\mu_1}^\dagger\right)
   \quad (\because \psi_{-\mu_1} \text{ と } P \text{ が可換}) \\
&= \mathrm{tr}\!\left(P\,(I - n_{\mu_1})\right)
   \quad (\because \text{数演算子の冪等性 (2)。}\text{〔number\_operator\_idempotent〕}) \\
&= \mathrm{tr}\!\left(P-P\,n_{\mu_1}\right)
   \quad (\because \text{分配法則と単位行列の性質}) \\
&= \mathrm{tr}(P) - \mathrm{tr}(P\,n_{\mu_1})
   \quad (\because \text{トレースの線型性。}\blkref{trace_basic_properties}) \\
&= \mathrm{tr}(P) - \mathrm{tr}(n_{\mu_1} P)
   \quad (\because n_{\mu_1} \text{ と } P \text{ が可換})
\end{aligned}`),
      paragraph(["したがって"]),
      displayMath(String.raw`\begin{aligned}
2\,\mathrm{tr}(n_{\mu_1}P)
&= \mathrm{tr}(P)
   \quad (\because \text{直前の等式を移項}) \\
\mathrm{tr}(n_{\mu_1}P)
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{両辺を }2\text{ で割る}) \\
&= \frac{1}{2}\cdot 2^{M-(k-1)}
   \quad (\because \text{帰納法の仮定}) \\
&= \frac{1}{2}\cdot 2^{M-k+1}
   \quad (\because M-(k-1)=M-k+1) \\
&= 2^{M-k}
   \quad (\because 2^{M-k+1}=2\cdot2^{M-k})
\end{aligned}`),
      paragraph(["まず ", math(String.raw`e_1=1`), " の場合は"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(1)}P\right)
&= \mathrm{tr}\!\left(n_{\mu_1}P\right)
   \quad (\because R_{\mu_1}^{(1)}=n_{\mu_1}) \\
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前に得た }\mathrm{tr}(n_{\mu_1}P)=\tfrac12\,\mathrm{tr}(P)) \\
&= \frac{1}{2}\cdot 2^{M-(k-1)}
   \quad (\because \text{帰納法の仮定}) \\
&= \frac{1}{2}\cdot 2^{M-k+1}
   \quad (\because M-(k-1)=M-k+1) \\
&= 2^{M-k}
   \quad (\because 2^{M-k+1}=2\cdot2^{M-k})
\end{aligned}`),
      paragraph(["である。次に ", math(String.raw`e_1=0`), " の場合は"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(0)}P\right)
&= \mathrm{tr}\!\left((I-n_{\mu_1})P\right)
   \quad (\because R_{\mu_1}^{(0)}=I-n_{\mu_1}) \\
&= \mathrm{tr}\!\left(P-n_{\mu_1}P\right)
   \quad (\because \text{分配法則と単位行列の性質}) \\
&= \mathrm{tr}(P)-\mathrm{tr}(n_{\mu_1}P)
   \quad (\because \text{トレースの線型性。}\blkref{trace_basic_properties}) \\
&= \mathrm{tr}(P)-\frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前に得た }\mathrm{tr}(n_{\mu_1}P)=\tfrac12\,\mathrm{tr}(P)) \\
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{複素数の四則演算}) \\
&= \frac{1}{2}\cdot2^{M-(k-1)}
   \quad (\because \text{帰納法の仮定}) \\
&= \frac{1}{2}\cdot2^{M-k+1}
   \quad (\because M-(k-1)=M-k+1) \\
&= 2^{M-k}
   \quad (\because 2^{M-k+1}=2\cdot2^{M-k})
\end{aligned}`),
      paragraph([math(String.raw`e_1\in\{0,1\}`), " なので二つの場合は尽くされ、帰納段階が示された。したがって任意の ", math(String.raw`e_1,\dots,e_k\in\{0,1\}`), " について主張が成り立つ。"]),
    ],
  },
  {
    id: "note_evenEigen_005_claim_check_joint_eigenspace_decomposition_integer_route_eigenvalues_of_V_008_claim_joint_eigenspace_decomposition",
    targets: ["check_joint_eigenspace_decomposition"],
    title: { text: "数演算子の同時固有空間分解" },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 10 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_008_claim_joint_eigenspace_decomposition。labels: joint_eigenspace_decomposition。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\epsilon = (\epsilon_\mu)_{\mu \in \mathcal{I}} \in \{0,1\}^{\mathcal{I}}`), " に対して"]),
      displayMath(String.raw`Q_\epsilon := \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
\in \mathrm{Mat}(2^M,\mathbb{C})`),
      paragraph(["と定める。ここで ", math(String.raw`R_\mu^{(1)} = n_\mu`), "、", math(String.raw`R_\mu^{(0)} = I - n_\mu`), " は ", "〔trace_of_number_operator_product〕", " の記号であり、因子は ", "〔number_operators_commute〕", " により互いに可換なので、積の順序は問わない。"]),
      paragraph([math(String.raw`Q_\epsilon`), " は、恒等式"]),
      displayMath(String.raw`I = \prod_{\mu \in \mathcal{I}}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)`),
      paragraph(["の右辺を分配法則で展開したときに現れる項のうち、各 ", math(String.raw`\mu \in \mathcal{I}`), " について因子 ", math(String.raw`R_\mu^{(\epsilon_\mu)}`), " を選んで作られる項である。", math(String.raw`\epsilon_\mu = 1`), " は ", math(String.raw`n_\mu`), " が ", math(String.raw`1`), " として働く側を、", math(String.raw`\epsilon_\mu = 0`), " は ", math(String.raw`0`), " として働く側を選ぶことに当たる（下の (3)）。このとき、"]),
      list([[math(String.raw`\text{(1)}\quad Q_\epsilon Q_{\epsilon'} = 0 \quad (\epsilon \neq \epsilon'), \qquad Q_\epsilon^2 = Q_\epsilon`)], [math(String.raw`\text{(2)}\quad \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} Q_\epsilon = I`)], [math(String.raw`\text{(3)}\quad n_\nu Q_\epsilon = \epsilon_\nu Q_\epsilon \quad (\nu \in \mathcal{I})`)], [math(String.raw`\text{(4)}\quad \mathrm{tr}(Q_\epsilon) = 2^{M-m}, \qquad \dim_{\mathbb{C}} \mathrm{im}\,Q_\epsilon = 2^{M-m}`)], [math(String.raw`\text{(5)}\quad \mathbb{C}^{2^M} = \bigoplus_{\epsilon \in \{0,1\}^{\mathcal{I}}} \mathrm{im}\,Q_\epsilon`)]]),
      paragraph(["が成り立つ。とくに ", math(String.raw`m = M`), "（臨界点でない場合）には各 ", math(String.raw`\mathrm{im}\,Q_\epsilon`), " は 1 次元である。"]),
      paragraph(["証明."]),
      paragraph(["Step 0（1 つの添字についての関係）。", "〔number_operator_idempotent〕", " (3) の ", math(String.raw`n_\mu^2 = n_\mu`), " より"]),
      displayMath(String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(1)}
&= n_\mu^2
   \quad (\because R_\mu^{(1)} = n_\mu \text{ の定義と冪の記法}) \\
&= n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= R_\mu^{(1)}
   \quad (\because R_\mu^{(1)} = n_\mu \text{ の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(0)}
&= (I-n_\mu)^2
   \quad (\because R_\mu^{(0)} = I - n_\mu \text{ の定義と冪の記法}) \\
&= I - 2n_\mu + n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= I - 2n_\mu + n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= I - n_\mu
   \quad (\because -2n_\mu + n_\mu = -n_\mu) \\
&= R_\mu^{(0)}
   \quad (\because R_\mu^{(0)} = I - n_\mu \text{ の定義})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(0)}
&= n_\mu(I - n_\mu)
   \quad (\because R_\mu^{(1)},\ R_\mu^{(0)} \text{ の定義}) \\
&= n_\mu - n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= n_\mu - n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= 0
   \quad (\because \text{加法の逆元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(1)}
&= (I - n_\mu)n_\mu
   \quad (\because R_\mu^{(0)},\ R_\mu^{(1)} \text{ の定義}) \\
&= n_\mu - n_\mu^2
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= n_\mu - n_\mu
   \quad (\because \text{上に引いた } n_\mu^2 = n_\mu) \\
&= 0
   \quad (\because \text{加法の逆元})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
R_\mu^{(1)} + R_\mu^{(0)}
&= n_\mu + (I - n_\mu)
   \quad (\because R_\mu^{(1)},\ R_\mu^{(0)} \text{ の定義}) \\
&= I
   \quad (\because n_\mu + (-n_\mu) = 0 \text{ と零元との和})
\end{aligned}`),
      paragraph(["また ", math(String.raw`\mu \neq \nu`), " のとき ", "〔number_operators_commute〕", " (2) より ", math(String.raw`n_\mu n_\nu = n_\nu n_\mu`), " であり、", math(String.raw`I`), " は任意の行列と可換だから、", math(String.raw`R_\mu^{(e)}`), " と ", math(String.raw`R_\nu^{(e')}`), " も可換である。"]),
      paragraph(["Step 1（(1) の証明）。", math(String.raw`\epsilon \neq \epsilon'`), " なら、ある ", math(String.raw`\nu \in \mathcal{I}`), " で ", math(String.raw`\epsilon_\nu \neq \epsilon'_\nu`), "。因子はすべて可換なので、", math(String.raw`Q_\epsilon Q_{\epsilon'}`), " の中で添字 ", math(String.raw`\nu`), " の 2 因子を隣接させられて"]),
      displayMath(String.raw`\begin{aligned}
Q_\epsilon Q_{\epsilon'}
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)
  R_\nu^{(\epsilon_\nu)}R_\nu^{(\epsilon'_\nu)}
   \quad (\because \text{因子の可換性により添字 }\nu\text{ の二因子を隣接させる}) \\
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)\cdot 0
   \quad (\because \epsilon_\nu\neq\epsilon'_\nu\text{ と Step 0 の直交性}) \\
&= 0
   \quad (\because \text{零行列との積})
\end{aligned}`),
      paragraph([math(String.raw`\epsilon = \epsilon'`), " のときは各因子が Step 0 より冪等なので"]),
      displayMath(String.raw`\begin{aligned}
Q_\epsilon^2
&= \prod_{\mu\in\mathcal I}R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{因子の可換性}) \\
&= \prod_{\mu\in\mathcal I}R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{Step 0 の冪等性を各因子へ適用}) \\
&= Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`),
      paragraph(["Step 2（(2) の証明）。Step 0 の ", math(String.raw`R_\mu^{(1)} + R_\mu^{(0)} = I`), " を各因子に代入し、可換な有限個の因子の積を分配法則で展開すると"]),
      displayMath(String.raw`\begin{aligned}
I
&= \prod_{\mu \in \mathcal{I}}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)
   \quad (\because \text{Step 0 の }R_\mu^{(1)}+R_\mu^{(0)}=I) \\
&= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
   \quad (\because \text{有限積を分配法則で展開}) \\
&= \sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`),
      paragraph(["（展開して現れる項は、各 ", math(String.raw`\mu`), " について ", math(String.raw`R_\mu^{(1)}`), " と ", math(String.raw`R_\mu^{(0)}`), " のどちらを選ぶかの全ての選び方に 1 対 1 に対応し、その選び方の全体が ", math(String.raw`\{0,1\}^{\mathcal{I}}`), " である。）"]),
      paragraph(["Step 3（(3) の証明）。", math(String.raw`\nu \in \mathcal{I}`), " を固定する。因子はすべて可換なので"]),
      displayMath(String.raw`n_\nu Q_\epsilon
= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}\right) n_\nu R_\nu^{(\epsilon_\nu)}
\quad (\because Q_\epsilon\text{ の定義と因子の可換性})`),
      paragraph([math(String.raw`\epsilon_\nu = 1`), " なら"]),
      displayMath(String.raw`\begin{aligned}
n_\nu R_\nu^{(1)}
&= n_\nu n_\nu \quad (\because R_\nu^{(1)}\text{ の定義}) \\
&= n_\nu \quad (\because \text{Step 0 の冪等性}) \\
&= R_\nu^{(1)} \quad (\because R_\nu^{(1)}\text{ の定義}) \\
&= \epsilon_\nu R_\nu^{(\epsilon_\nu)} \quad (\because \epsilon_\nu=1)
\end{aligned}`),
      paragraph([math(String.raw`\epsilon_\nu = 0`), " なら"]),
      displayMath(String.raw`\begin{aligned}
n_\nu R_\nu^{(0)}
&= n_\nu(I-n_\nu) \quad (\because R_\nu^{(0)}\text{ の定義}) \\
&= 0 \quad (\because \text{Step 0 の直交性}) \\
&= \epsilon_\nu R_\nu^{(\epsilon_\nu)} \quad (\because \epsilon_\nu=0)
\end{aligned}`),
      paragraph(["いずれの場合も"]),
      displayMath(String.raw`\begin{aligned}
n_\nu Q_\epsilon
&= \left(\prod_{\mu\neq\nu}R_\mu^{(\epsilon_\mu)}\right)n_\nu R_\nu^{(\epsilon_\nu)}
   \quad (\because Q_\epsilon\text{ の定義と因子の可換性}) \\
&= \left(\prod_{\mu\neq\nu}R_\mu^{(\epsilon_\mu)}\right)\epsilon_\nu R_\nu^{(\epsilon_\nu)}
   \quad (\because \text{上の二つの場合}) \\
&= \epsilon_\nu Q_\epsilon
   \quad (\because Q_\epsilon\text{ の定義})
\end{aligned}`),
      paragraph(["Step 4（(4) の証明）。", math(String.raw`T := \{\mu \in \mathcal{I} \mid \epsilon_\mu = 1\}`), " とおくと"]),
      displayMath(String.raw`\begin{aligned}
Q_\epsilon
&= \prod_{\mu \in \mathcal{I}} R_\mu^{(\epsilon_\mu)}
   \quad (\because Q_\epsilon\text{ の定義}) \\
&= \left(\prod_{\mu \in T} R_\mu^{(1)}\right)\prod_{\mu \in \mathcal{I}\setminus T} R_\mu^{(0)}
   \quad (\because T\text{ の定義と因子の可換性}) \\
&= \left(\prod_{\mu \in T} n_\mu\right)\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)
   \quad (\because R_\mu^{(1)},\,R_\mu^{(0)}\text{ の定義})
\end{aligned}`),
      paragraph(["である。第 2 の積を分配法則で展開すると"]),
      displayMath(String.raw`\prod_{\mu \in \mathcal{I}\setminus T}(I - n_\mu)
= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|} \prod_{\mu \in S} n_\mu
\quad (\because \text{有限積を分配法則で展開})`),
      paragraph(["であるから、トレースの線型性（", ref("trace_basic_properties"), " (1)）と ", "〔trace_of_number_operator_product〕", "（", math(String.raw`T`), " と ", math(String.raw`S`), " は交わらないので ", math(String.raw`T \cup S`), " の元は相異なる ", math(String.raw`|T| + |S|`), " 個）より"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(Q_\epsilon)
&= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|}\,
   \mathrm{tr}\!\left(\prod_{\mu \in T \cup S} n_\mu\right)
   \quad (\because \text{上の展開とトレースの線型性}) \\
&= \sum_{S \subseteq \mathcal{I}\setminus T} (-1)^{|S|}\, 2^{M - |T| - |S|}
   \quad (\because \text{数演算子の積のトレース}) \\
&= 2^{M-|T|}\sum_{j=0}^{m-|T|}\binom{m-|T|}{j}(-1)^{j}\,2^{-j}
   \quad (\because |\mathcal{I}\setminus T| = m - |T| \text{ で、大きさ } j \text{ の部分集合は } \tbinom{m-|T|}{j} \text{ 個}) \\
&= 2^{M-|T|}\left(1 - \tfrac{1}{2}\right)^{m-|T|}
   \quad (\because \text{二項定理}) \\
&= 2^{M-|T|}\cdot 2^{-(m-|T|)}
   \quad (\because 1-\tfrac12=\tfrac12=2^{-1}\text{ と冪の法則}) \\
&= 2^{M-m}
   \quad (\because \text{同じ底の冪の積})
\end{aligned}`),
      paragraph([math(String.raw`Q_\epsilon`), " は Step 1 より冪等である。したがって"]),
      displayMath(String.raw`\begin{aligned}
\dim_{\mathbb{C}}\mathrm{im}\,Q_\epsilon
&= \mathrm{tr}(Q_\epsilon)
   \quad (\because \text{冪等行列のトレースは像の次元（}\blkref{trace_of_idempotent}\text{）。} Q_\epsilon \text{ は Step 1 より冪等}) \\
&= 2^{M-m}
   \quad (\because \text{上で計算した } \mathrm{tr}(Q_\epsilon))
\end{aligned}`),
      paragraph(["Step 5（(5) の証明）。(2) より任意の ", math(String.raw`x \in \mathbb{C}^{2^M}`), " について"]),
      displayMath(String.raw`\begin{aligned}
x
&= Ix
   \quad (\because I\text{ は単位行列}) \\
&= \left(\sum_\epsilon Q_\epsilon\right)x
   \quad (\because \text{(2)}) \\
&= \sum_\epsilon Q_\epsilon x
   \quad (\because \text{行列作用の線型性})
\end{aligned}`),
      paragraph(["であり、各 ", math(String.raw`Q_\epsilon x`), " は ", math(String.raw`\mathrm{im}\,Q_\epsilon`), " に属するので、これらの像の和は全体を張る。直和であることを見るために ", math(String.raw`\sum_\epsilon y_\epsilon = 0`), "（", math(String.raw`y_\epsilon \in \mathrm{im}\,Q_\epsilon`), "）とする。各 ", math(String.raw`\epsilon`), " に対して ", math(String.raw`y_\epsilon = Q_\epsilon x_\epsilon`), " となる ", math(String.raw`x_\epsilon\in\mathbb C^{2^M}`), " を取る。(1) より、各 ", math(String.raw`\epsilon,\epsilon'`), " について"]),
      displayMath(String.raw`\begin{aligned}
Q_{\epsilon'}y_\epsilon
&= Q_{\epsilon'}Q_\epsilon x_\epsilon
   \quad (\because y_\epsilon=Q_\epsilon x_\epsilon) \\
&=
\begin{cases}
0, & \epsilon\ne\epsilon', \\
Q_\epsilon x_\epsilon, & \epsilon=\epsilon'
\end{cases}
   \quad (\because \text{(1) の直交性と冪等性}) \\
&=
\begin{cases}
0, & \epsilon\ne\epsilon', \\
y_\epsilon, & \epsilon=\epsilon'
\end{cases}
   \quad (\because y_\epsilon=Q_\epsilon x_\epsilon)
\end{aligned}`),
      paragraph(["である。したがって各 ", math(String.raw`\epsilon'`), " について"]),
      displayMath(String.raw`\begin{aligned}
0
&= Q_{\epsilon'}0
   \quad (\because \text{線型写像は零ベクトルを零ベクトルへ写す}) \\
&= Q_{\epsilon'}\left(\sum_\epsilon y_\epsilon\right)
   \quad (\because \sum_\epsilon y_\epsilon=0) \\
&= \sum_\epsilon Q_{\epsilon'}y_\epsilon
   \quad (\because \text{行列作用の線型性}) \\
&= y_{\epsilon'}
   \quad (\because \text{(1) の直交性と冪等性})
\end{aligned}`),
      paragraph(["が成り立つので、和は直和である。"]),
      paragraph(["（次元の整合：", math(String.raw`\left|\{0,1\}^{\mathcal{I}}\right| = 2^m`), " 個の空間がそれぞれ ", math(String.raw`2^{M-m}`), " 次元で、合計 ", math(String.raw`2^m \cdot 2^{M-m} = 2^M`), " となり ", math(String.raw`\mathbb{C}^{2^M}`), " の次元に一致する。）"]),
    ],
  },
  {
    id: "note_evenEigen_006_claim_eigenvalues_of_check_Vprime_integer_route_eigenvalues_of_V_009_claim_eigenvalues_of_Vprime",
    targets: ["eigenvalues_of_check_Vprime"],
    title: { tex: String.raw`V' \text{ の固有値}` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 11 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_009_claim_eigenvalues_of_Vprime。labels: eigenvalues_of_Vprime。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\epsilon \in \{0,1\}^{\mathcal{I}}`), " に対して"]),
      displayMath(String.raw`g(\epsilon) := \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right) \in \mathbb{R}`),
      paragraph(["とおく。このとき"]),
      displayMath(String.raw`V' Q_\epsilon = \exp(g(\epsilon)) Q_\epsilon`),
      paragraph(["が成り立つ。すなわち ", math(String.raw`\mathrm{im}\,Q_\epsilon`), " の各元は ", math(String.raw`V'`), " の固有値 ", math(String.raw`\exp(g(\epsilon))`), " の固有ベクトルであり、", "〔joint_eigenspace_decomposition〕", " (5) より ", math(String.raw`V'`), " は対角化可能で、その固有値は重複度を込めて"]),
      displayMath(String.raw`\left\{\,\exp(g(\epsilon)) \ \text{（重複度 } 2^{M-m}\text{）} \ \middle|\ \epsilon \in \{0,1\}^{\mathcal{I}}\,\right\}`),
      paragraph(["で尽くされる（個数は重複度を込めて ", math(String.raw`2^m\cdot 2^{M-m} = 2^M`), "）。とくに ", math(String.raw`V'`), " の固有値はすべて正の実数である。"]),
      paragraph(["証明."]),
      paragraph(["Step 1（", math(String.raw`X Q_\epsilon = g(\epsilon) Q_\epsilon`), "）。", "〔def_number_operator〕", " の ", math(String.raw`X = \sum_{\mu\in\mathcal{I}}\gamma(\theta_\mu)(n_\mu - \tfrac12 I)`), " に ", "〔joint_eigenspace_decomposition〕", " (3) を代入して"]),
      displayMath(String.raw`\begin{aligned}
X Q_\epsilon
&= \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
   \left(n_\mu Q_\epsilon - \tfrac{1}{2} Q_\epsilon\right)
   \quad (\because \text{〔def\_number\_operator〕}\text{ と行列の積の分配法則}) \\
&= \sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
   \left(\epsilon_\mu Q_\epsilon - \tfrac{1}{2} Q_\epsilon\right)
   \quad (\because \text{〔joint\_eigenspace\_decomposition〕}\text{ (3)}) \\
&= \left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right) Q_\epsilon
   \quad (\because \text{有限和の線型性で } Q_\epsilon \text{ を右へくくり出す}) \\
&= g(\epsilon)\,Q_\epsilon
   \quad (\because g(\epsilon) \text{ の定義})
\end{aligned}`),
      paragraph(["Step 2（", math(String.raw`X^k Q_\epsilon = g(\epsilon)^k Q_\epsilon`), "）。", math(String.raw`k`), " に関する帰納法。", math(String.raw`k=0`), " は自明。", math(String.raw`X^k Q_\epsilon = g(\epsilon)^k Q_\epsilon`), " を仮定すると、Step 1 より"]),
      displayMath(String.raw`\begin{aligned}
X^{k+1}Q_\epsilon
&= X\left(X^k Q_\epsilon\right)
   \quad (\because \text{冪の定義 } X^{k+1} = X X^k \text{ と行列の積の結合法則}) \\
&= X\left(g(\epsilon)^k Q_\epsilon\right)
   \quad (\because \text{帰納法の仮定}) \\
&= g(\epsilon)^k\left(X Q_\epsilon\right)
   \quad (\because \text{スカラー倍と行列の積の交換}) \\
&= g(\epsilon)^{k+1} Q_\epsilon
   \quad (\because \text{Step 1 の } X Q_\epsilon = g(\epsilon) Q_\epsilon \text{ と冪の定義})
\end{aligned}`),
      paragraph(["Step 3（指数関数へ）。", ref("def_exp"), " より ", math(String.raw`V' = \exp(X) = \sum_{k=0}^{\infty}\frac{1}{k!}X^k`), " であり、この級数は ", ref("exp_converges"), " により ", ref("def_matrix_norm"), " のノルムについて収束する。部分和を ", math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}X^k`), " と書くと、Step 2 と有限和の線型性から"]),
      displayMath(String.raw`\begin{aligned}
E_K Q_\epsilon
&= \sum_{k=0}^{K}\frac{1}{k!}X^k Q_\epsilon
   \quad (\because E_K \text{ の定義と行列の積の分配法則}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\,g(\epsilon)^k Q_\epsilon
   \quad (\because \text{Step 2 を各項へ適用}) \\
&= \left(\sum_{k=0}^{K}\frac{g(\epsilon)^k}{k!}\right) Q_\epsilon
   \quad (\because \text{有限和の線型性で } Q_\epsilon \text{ を右へくくり出す})
\end{aligned}`),
      paragraph([math(String.raw`K \to \infty`), " とすると、左辺は ", ref("matrix_multiplication_continuity"), " より ", math(String.raw`\exp(X) Q_\epsilon = V' Q_\epsilon`), " に収束し、右辺は ", ref("scalar_exp_is_limit_of_partial_sums"), " より ", math(String.raw`\exp(g(\epsilon))Q_\epsilon`), " に収束する。極限の一意性より"]),
      displayMath(String.raw`V' Q_\epsilon = \exp(g(\epsilon)) Q_\epsilon`),
      paragraph(["Step 4（固有値の言い換え）。", math(String.raw`y \in \mathrm{im}\,Q_\epsilon`), " なら ", math(String.raw`y = Q_\epsilon x`), " と書けて、", "〔joint_eigenspace_decomposition〕", " (1) より"]),
      displayMath(String.raw`\begin{aligned}
Q_\epsilon y
&= Q_\epsilon^2 x
   \quad (\because y = Q_\epsilon x) \\
&= Q_\epsilon x
   \quad (\because \text{〔joint\_eigenspace\_decomposition〕}\text{ (1) の冪等性}) \\
&= y
   \quad (\because y = Q_\epsilon x)
\end{aligned}`),
      paragraph(["だから"]),
      displayMath(String.raw`\begin{aligned}
V' y
&= V' Q_\epsilon y
   \quad (\because \text{上の } Q_\epsilon y = y) \\
&= \exp(g(\epsilon)) Q_\epsilon y
   \quad (\because \text{Step 3 の } V' Q_\epsilon = \exp(g(\epsilon)) Q_\epsilon) \\
&= \exp(g(\epsilon)) y
   \quad (\because \text{上の } Q_\epsilon y = y)
\end{aligned}`),
      paragraph(["〔joint_eigenspace_decomposition〕", " (5) より ", math(String.raw`\mathbb{C}^{2^M}`), " は ", math(String.raw`\mathrm{im}\,Q_\epsilon`), " たちの直和だから、各 ", math(String.raw`\mathrm{im}\,Q_\epsilon`), " の基底を合わせると ", math(String.raw`V'`), " の固有ベクトルからなる ", math(String.raw`\mathbb{C}^{2^M}`), " の基底が得られる。したがって ", math(String.raw`V'`), " は対角化可能で、固有値は ", math(String.raw`\exp(g(\epsilon))`), " が重複度 ", math(String.raw`\dim \mathrm{im}\,Q_\epsilon = 2^{M-m}`), " で現れるもので尽くされる。"]),
      paragraph([math(String.raw`g(\epsilon) \in \mathbb{R}`), "（", "〔def_gamma_theta_mu〕", " より ", math(String.raw`\gamma(\theta_\mu) \in \mathbb{R}_{\geq 0}`), "）なので ", math(String.raw`\exp(g(\epsilon)) > 0`), "（", ref("real_exp_positive"), "）である。"]),
    ],
  },
  {
    id: "note_evenEigen_007_claim_trace_of_check_Vprime_integer_route_eigenvalues_of_V_010_claim_trace_of_Vprime",
    targets: ["trace_of_check_Vprime"],
    title: { tex: String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1}) > 0` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 12 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_010_claim_trace_of_Vprime。labels: trace_of_Vprime。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`V'`), " は可逆で ", math(String.raw`V'^{-1} = \exp(-X)`), " であり、"]),
      displayMath(String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1})
= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
\ \in \mathbb{R}_{>0}`),
      paragraph(["証明."]),
      paragraph(["Step 1（可逆性）。", math(String.raw`X`), " と ", math(String.raw`-X`), " は可換なので"]),
      displayMath(String.raw`\begin{aligned}
\exp(X)\exp(-X)
&= \exp\bigl(X+(-X)\bigr)
   \quad (\because \text{指数行列の積の定理}) \\
&= \exp(0)
   \quad (\because \text{加法の逆元}) \\
&= I
   \quad (\because \exp(0)=I)
\end{aligned}`),
      paragraph([ref("theorem_exp_product"), "、", ref("theorem_exp_zero"), "。同様に"]),
      displayMath(String.raw`\begin{aligned}
\exp(-X)\exp(X)
&= \exp\bigl((-X)+X\bigr)
   \quad (\because \text{指数行列の積の定理}) \\
&= \exp(0)
   \quad (\because \text{加法の逆元}) \\
&= I
   \quad (\because \exp(0)=I)
\end{aligned}`),
      paragraph(["だから ", math(String.raw`V' = \exp(X)`), " は可逆で ", math(String.raw`V'^{-1} = \exp(-X)`), "。"]),
      paragraph(["Step 2（トレースの計算）。", "〔joint_eigenspace_decomposition〕", " (2) と ", "〔eigenvalues_of_Vprime〕", "、および ", ref("trace_basic_properties"), " (1) より"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(V')
&= \mathrm{tr}\!\left(V' \sum_{\epsilon} Q_\epsilon\right)
   \quad (\because \textstyle\sum_\epsilon Q_\epsilon = I) \\
&= \sum_{\epsilon} \mathrm{tr}\!\left(V' Q_\epsilon\right)
   \quad (\because \text{トレースの線型性}) \\
&= \sum_{\epsilon} \exp(g(\epsilon))\,\mathrm{tr}(Q_\epsilon)
   \quad (\because V'Q_\epsilon = \exp(g(\epsilon))Q_\epsilon) \\
&= 2^{M-m}\sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} \exp(g(\epsilon))
   \quad (\because \mathrm{tr}(Q_\epsilon) = 2^{M-m})
\end{aligned}`),
      paragraph(["Step 3（積への分解）。", math(String.raw`g(\epsilon) = \sum_{\mu}\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`), " なので、", ref("scalar_exp_product"), " を繰り返し適用して"]),
      displayMath(String.raw`\exp(g(\epsilon)) = \prod_{\mu \in \mathcal{I}}
\exp\!\left(\gamma(\theta_\mu)\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)
\quad (\because \text{実数の exp の積公式を有限回適用。}\blkref{scalar_exp_product})`),
      paragraph([math(String.raw`\epsilon`), " は各成分を独立に ", math(String.raw`0`), " か ", math(String.raw`1`), " から選ぶので、有限個の因子の積の展開（Step 2 の ", math(String.raw`\sum_\epsilon`), " と同じ 1 対 1 対応）により"]),
      displayMath(String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{\mathcal{I}}} \exp(g(\epsilon))
&= \prod_{\mu \in \mathcal{I}}
   \left(\exp\!\left(-\tfrac{\gamma(\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\theta_\mu)}{2}\right)\right)
   \quad \left(\because \text{各 }\epsilon_\mu\in\{0,1\}\text{ の独立な選択による有限積の展開}\right) \\
&= \prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
   \quad \left(\because \cosh x = \frac{\exp(x) + \exp(-x)}{2}\ \blkref{def_cosh_sinh}\right)
\end{aligned}`),
      paragraph(["Step 4（", math(String.raw`V'^{-1}`), " についても同じ値）。", math(String.raw`V'^{-1} = \exp(-X)`), " であり、", math(String.raw`-X = \sum_\mu(-\gamma(\theta_\mu))(n_\mu - \tfrac12 I)`), " だから、Step 1〜3 をそのまま ", math(String.raw`\gamma(\theta_\mu) \to -\gamma(\theta_\mu)`), " として適用でき"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(V'^{-1})
&= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{-\gamma(\theta_\mu)}{2}\right)
   \quad (\because \text{Steps 1--3 を }-X\text{ へ適用}) \\
&= 2^{M-m}\prod_{\mu \in \mathcal{I}} 2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
   \quad (\because \cosh\text{ は偶関数}) \\
&= \mathrm{tr}(V')
   \quad (\because \text{Steps 2--3 の }\mathrm{tr}(V')\text{ の計算})
\end{aligned}`),
      paragraph(["最後から 2 番目の等号は ", math(String.raw`\cosh`), " が偶関数であること（", ref("cosh_sinh_basic_properties"), "）による。"]),
      paragraph(["Step 5（正値性）。", "〔def_gamma_theta_mu〕", " より ", math(String.raw`\gamma(\theta_\mu) \in \mathbb{R}_{\geq 0}`), " であり、", ref("cosh_sinh_basic_properties"), " より ", math(String.raw`\cosh x \geq 1`), "。したがって"]),
      displayMath(String.raw`\begin{aligned}
2\cosh\!\left(\frac{\gamma(\theta_\mu)}{2}\right)
&\geq 2
   \quad (\because \cosh x\geq1) \\
&>0
   \quad (\because 2>0)
\end{aligned}`),
      paragraph(["である。さらに ", math(String.raw`2^{M-m}>0`), " なので、正の因子の有限積である Step 2--3 の表示から ", math(String.raw`\mathrm{tr}(V')>0`), " を得る。"]),
    ],
  },
  {
    id: "note_evenEigen_008_claim_V_plus_is_positive_definite_integer_route_eigenvalues_of_V_015_claim_V_is_positive_definite",
    targets: ["V_plus_is_positive_definite"],
    title: { tex: String.raw`V \text{ は正定値、とくに } \mathrm{tr}(V) > 0` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 17 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_015_claim_V_is_positive_definite。labels: V_is_positive_definite。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔V_eq_Vprime〕", " の ", math(String.raw`V := (V_1^{(\pm)})^{1/2}\,V_2\,(V_1^{(\pm)})^{1/2}`), " について（", math(String.raw`(V_1^{(\pm)})^{1/2} := \exp\!\left(\tfrac{1}{2}iK_1H_1^{(\pm)}\right) = \exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)`), " は ", "〔ホロノミック量子場_p142下段_1〕", " の proof で用いられている規約）、"]),
      displayMath(String.raw`V = (2s_2)^{M/2}\,\exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(S_2\right)\exp\!\left(\tfrac{1}{2}S_1^{(\pm)}\right)`),
      paragraph(["であり、", math(String.raw`V`), " は可逆で正定値、", math(String.raw`V^{-1}`), " も正定値である。とくに"]),
      displayMath(String.raw`\mathrm{tr}(V) \in \mathbb{R}_{>0}, \qquad \mathrm{tr}(V^{-1}) \in \mathbb{R}_{>0}`),
      paragraph(["証明."]),
      paragraph(["Step 1（表示）。"]),
      displayMath(String.raw`\begin{aligned}
V
&= (V_1^{(\pm)})^{1/2}\,V_2\,(V_1^{(\pm)})^{1/2}
   \quad (\because V \text{ の定義}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)V_2\,\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (V_1^{(\pm)})^{1/2} \text{ の規約}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)(2\sinh 2K_2)^{M/2}
   \exp\!\left(K_2^*\textstyle\sum_{m}\sigma_m^x\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because V_2 \text{ の記号の定義}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)(2s_2)^{M/2}\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{実対称性の Step 1: 指数の中身は } S_2\text{。}s_2 := \sinh 2K_2) \\
&= (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
V\,W
&= (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   (2s_2)^{-M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{Step 1 の表示と } W \text{ の定義}) \\
&= (2s_2)^{M/2}(2s_2)^{-M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (2s_2)^{M/2}(2s_2)^{-M/2} = 1) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)
   \exp\!\left(\tfrac12 S_1^{(\pm)}-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}\tfrac12 S_1^{(\pm)} \text{ と }-\tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}S_2 \text{ と }-S_2 \text{ は可換}) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(\tfrac12 S_1^{(\pm)}-\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。}\tfrac12 S_1^{(\pm)} \text{ と }-\tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= I
   \quad (\because \exp(O) = I)
\end{aligned}`),
      paragraph(["これが statement の表示である（", math(String.raw`V_2`), " の記号の定義は ", ref("def_transfer_matrix_symbols"), "、指数の中身が ", math(String.raw`S_2`), " に等しいことは ", ref("iH_is_real_symmetric"), " の Step 1、スカラーを前へ出す操作は ", ref("scalar_identity_commutes"), "）。"]),
      paragraph(["Step 2（各因子の性質）。", ref("iH_is_real_symmetric"), " より ", math(String.raw`\tfrac12 S_1^{(\pm)}`), " と ", math(String.raw`S_2`), " はエルミートである。", ref("exp_hermitian_is_positive_definite"), " (1) より"]),
      list([[math(String.raw`B := \exp\!\left(\tfrac12 S_1^{(\pm)}\right)`), " はエルミートかつ正定値、とくに可逆"], [math(String.raw`A := \exp(S_2)`), " は正定値"]]),
      paragraph(["Step 3（正定値性）。"]),
      displayMath(String.raw`\begin{aligned}
\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
&= B A B
   \quad (\because A,\ B \text{ の定義}) \\
&= B^* A B
   \quad (\because B \text{ はエルミート: } B^* = B)
\end{aligned}`),
      paragraph([ref("exp_hermitian_is_positive_definite"), " (2) より ", math(String.raw`B^*AB`), " は正定値。", math(String.raw`K_2 \in \mathbb{R}_{>0}`), " より ", math(String.raw`s_2 = \sinh 2K_2 > 0`), " なので ", math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`), " であり、同 (3) より ", math(String.raw`V = (2s_2)^{M/2}B^*AB`), " も正定値である。"]),
      paragraph(["Step 4（可逆性と ", math(String.raw`V^{-1}`), "）。", math(String.raw`W := (2s_2)^{-M/2}\,\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(-S_2\right)\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)`), " と置く。"]),
      displayMath(String.raw`\begin{aligned}
W\,V
&= (2s_2)^{-M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)
   (2s_2)^{M/2}\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because W \text{ の定義と Step 1 の表示}) \\
&= (2s_2)^{-M/2}(2s_2)^{M/2}\exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{スカラー行列は全行列と可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because (2s_2)^{-M/2}(2s_2)^{M/2} = 1) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)
   \exp\!\left(-\tfrac12 S_1^{(\pm)} + \tfrac12 S_1^{(\pm)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -\tfrac12 S_1^{(\pm)} \text{ と } \tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp(-S_2 + S_2)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -S_2 \text{ と } S_2 \text{ は可換}) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)}\right)\exp\!\left(\tfrac12 S_1^{(\pm)}\right)
   \quad (\because \exp(O) = I) \\
&= \exp\!\left(-\tfrac12 S_1^{(\pm)} + \tfrac12 S_1^{(\pm)}\right)
   \quad (\because \text{可換行列の exp 積公式。} -\tfrac12 S_1^{(\pm)} \text{ と } \tfrac12 S_1^{(\pm)} \text{ は可換}) \\
&= I
   \quad (\because \exp(O) = I)
\end{aligned}`),
      paragraph(["（スカラーを前へ出す操作は ", ref("scalar_identity_commutes"), "、可換行列の exp 積公式は ", ref("theorem_exp_product"), "、", math(String.raw`\exp(O) = I`), " は ", ref("theorem_exp_zero"), "。）以上の二つの鎖から ", math(String.raw`V\,W = I`), " と ", math(String.raw`W\,V = I`), " がともに成り立つから ", math(String.raw`V`), " は可逆で、"]),
      displayMath(String.raw`V^{-1} = W = (2s_2)^{-M/2}\,\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)
\exp\!\left(-S_2\right)\exp\!\left(-\tfrac{1}{2}S_1^{(\pm)}\right)`),
      paragraph(["である。", math(String.raw`-\tfrac12 S_1^{(\pm)}`), " と ", math(String.raw`-S_2`), " もエルミートなので、Step 2〜3 をそのまま適用して ", math(String.raw`V^{-1}`), " も正定値である。"]),
      paragraph(["Step 5（トレース）。", ref("exp_hermitian_is_positive_definite"), " (4) より ", math(String.raw`\mathrm{tr}(V) > 0`), "、", math(String.raw`\mathrm{tr}(V^{-1}) > 0`), "。"]),
    ],
  },
  {
    id: "note_evenEigen_009_claim_constant_c_value_even_sector_integer_route_eigenvalues_of_V_017_claim_constant_c_value",
    targets: ["constant_c_value_even_sector"],
    title: { tex: String.raw`c = (2\sinh 2K_2)^{M/2}` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 19 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_017_claim_constant_c_value。labels: constant_c_value。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔V_eq_Vprime〕", " の定数 ", math(String.raw`c \in \mathbb{C}^\times`), " は"]),
      displayMath(String.raw`c = (2\sinh 2K_2)^{M/2} = (2s_2)^{M/2} \in \mathbb{R}_{>0}`),
      paragraph(["である。すなわち"]),
      displayMath(String.raw`V = (2\sinh 2K_2)^{M/2}\,V'`),
      paragraph(["証明."]),
      paragraph(["以下 ", math(String.raw`S_1 := S_1^{(\pm)}`), "（符号の選択は固定する）、", math(String.raw`S_2`), " は ", ref("iH_is_real_symmetric"), " のもの、", math(String.raw`\tau := \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)`), " と書く。"]),
      paragraph(["Step 1（", math(String.raw`\mathrm{tr}(V)`), " と ", math(String.raw`\mathrm{tr}(V^{-1})`), " を ", math(String.raw`\tau`), " で表す）。", "〔V_is_positive_definite〕", " Step 1 の表示と ", ref("trace_basic_properties"), " (1)(2) より"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(V)
&= (2s_2)^{M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\exp\!\left(\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(\tfrac12 S_1\right)\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\right)
   \quad \left(\because \text{巡回性を } A = \exp\!\left(\tfrac12 S_1\right)\exp(S_2),\ B = \exp\!\left(\tfrac12 S_1\right) \text{ に適用}\right) \\
&= (2s_2)^{M/2}\,\mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad \left(\because \text{可換なので } \exp\!\left(\tfrac12 S_1\right)^2 = \exp(S_1)\right) \\
&= (2s_2)^{M/2}\,\tau
   \quad (\because\ \tau \text{ の定義})
\end{aligned}`),
      paragraph(["同じ計算を ", "〔V_is_positive_definite〕", " Step 4 の ", math(String.raw`V^{-1}`), " の表示に適用して"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(V^{-1})
&= (2s_2)^{-M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(-\tfrac12 S_1\right)\exp(-S_2)\exp\!\left(-\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{-M/2}\,
   \mathrm{tr}\!\left(\exp\!\left(-\tfrac12 S_1\right)\exp\!\left(-\tfrac12 S_1\right)\exp(-S_2)\right)
   \quad (\because \text{トレースの巡回性}) \\
&= (2s_2)^{-M/2}\,\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)
   \quad \left(\because \exp\!\left(-\tfrac12 S_1\right)^2=\exp(-S_1)\right)
\end{aligned}`),
      paragraph(["Step 2（", math(String.raw`\mathrm{tr}(\exp(-S_1)\exp(-S_2)) = \tau`), "）。", ref("sign_flip_conjugation"), " の ", math(String.raw`U`), " について、共役は行列の積とスカラー倍を保ち、有限部分和の極限とも交換する（", math(String.raw`\|UXU^{-1} - UYU^{-1}\| = \|U(X-Y)U^{-1}\| \leq \|U\|\,\|U^{-1}\|\,\|X - Y\|`), "：", ref("matrix_norm_submultiplicativity"), "）から、", math(String.raw`U(S)^k U^{-1} = (USU^{-1})^k`), " と ", ref("def_exp"), " より"]),
      displayMath(String.raw`U\exp(S)U^{-1} = \exp\!\left(U S U^{-1}\right)
\qquad (S \in \mathrm{Mat}(2^M,\mathbb{C}))`),
      paragraph(["これを ", math(String.raw`S = S_1, S_2`), " に適用し、", ref("sign_flip_conjugation"), " と ", ref("trace_basic_properties"), " (4) を使って"]),
      displayMath(String.raw`\begin{aligned}
\tau
&= \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad (\because\ \tau \text{ の定義}) \\
&= \mathrm{tr}\!\left(U\exp(S_1)\exp(S_2)U^{-1}\right)
   \quad (\because \text{トレースは共役で不変}) \\
&= \mathrm{tr}\!\left(\left(U\exp(S_1)U^{-1}\right)\left(U\exp(S_2)U^{-1}\right)\right)
   \quad (\because U^{-1}U = I) \\
&= \mathrm{tr}\!\left(\exp\!\left(US_1U^{-1}\right)\exp\!\left(US_2U^{-1}\right)\right)
   \quad \left(\because \text{上の等式 } U\exp(S)U^{-1} = \exp\!\left(USU^{-1}\right)\right) \\
&= \mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)
   \quad (\because \text{符号反転共役})
\end{aligned}`),
      paragraph(["Step 3（", math(String.raw`c^2`), " の決定）。まず ", math(String.raw`V^{-1} = c^{-1}V'^{-1}`), " を確かめる。", "〔V_is_positive_definite〕", " Step 4 より ", math(String.raw`V`), " は可逆で逆行列 ", math(String.raw`V^{-1}`), " をもち、", "〔trace_of_Vprime〕", " Step 1 より ", math(String.raw`V'`), " も可逆で逆行列 ", math(String.raw`V'^{-1} = \exp(-X)`), " をもつ。", math(String.raw`c \in \mathbb{C}^\times`), " すなわち ", math(String.raw`c \neq 0`), " なので ", math(String.raw`c^{-1} \in \mathbb{C}`), " が取れて、", "〔V_eq_Vprime〕", " の ", math(String.raw`V = cV'`), " から"]),
      displayMath(String.raw`\begin{aligned}
\left(c^{-1}V'^{-1}\right)V
&= \left(c^{-1}V'^{-1}\right)\left(cV'\right)
   \quad (\because\ V = cV') \\
&= c^{-1}c\,\left(V'^{-1}V'\right)
   \quad (\because \text{スカラー倍は行列の積と可換に前へ出せる}) \\
&= 1\cdot\left(V'^{-1}V'\right)
   \quad (\because\ c^{-1}c = 1) \\
&= V'^{-1}V'
   \quad (\because \text{スカラー } 1 \text{ の積}) \\
&= I
   \quad (\because\ V'^{-1} \text{ は } V' \text{ の逆行列})
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
V\left(c^{-1}V'^{-1}\right)
&= \left(cV'\right)\left(c^{-1}V'^{-1}\right)
   \quad (\because\ V = cV') \\
&= c\,c^{-1}\left(V'V'^{-1}\right)
   \quad (\because \text{スカラー倍は行列の積と可換に前へ出せる}) \\
&= 1\cdot\left(V'V'^{-1}\right)
   \quad (\because\ c\,c^{-1} = 1) \\
&= V'V'^{-1}
   \quad (\because \text{スカラー } 1 \text{ の積}) \\
&= I
   \quad (\because\ V'^{-1} \text{ は } V' \text{ の逆行列})
\end{aligned}`),
      paragraph(["（スカラー倍は行列の積と可換に前へ出せる：", ref("scalar_identity_commutes"), "。）よって ", math(String.raw`c^{-1}V'^{-1}`), " は ", math(String.raw`V`), " の左逆行列でも右逆行列でもある。逆行列は存在すれば一意である（", math(String.raw`AB = BA = I`), " かつ ", math(String.raw`AC = CA = I`), " なら次の鎖で一意である）。"]),
      displayMath(String.raw`\begin{aligned}
B
&=BI
   \quad (\because \text{単位行列}) \\
&=B(AC)
   \quad (\because AC=I) \\
&=(BA)C
   \quad (\because \text{結合則}) \\
&=IC
   \quad (\because BA=I) \\
&=C
   \quad (\because \text{単位行列})
\end{aligned}`),
      paragraph(["したがって"]),
      displayMath(String.raw`V^{-1} = c^{-1}V'^{-1}`),
      paragraph(["が従う。したがって ", ref("trace_basic_properties"), " (1) より"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(V)
&=c\,\mathrm{tr}(V')
   \quad (\because V=cV'\ \text{とトレースの線型性}), \\
\mathrm{tr}(V^{-1})
&=c^{-1}\,\mathrm{tr}(V'^{-1})
   \quad (\because V^{-1}=c^{-1}V'^{-1}\ \text{とトレースの線型性})
\end{aligned}`),
      paragraph(["〔trace_of_Vprime〕", " より ", math(String.raw`\mathrm{tr}(V') = \mathrm{tr}(V'^{-1}) > 0`), " なので、これらは ", math(String.raw`0`), " でなく、辺々割ることができて"]),
      displayMath(String.raw`\begin{aligned}
\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
&=\frac{c\,\mathrm{tr}(V')}{c^{-1}\,\mathrm{tr}(V'^{-1})}
   \quad (\because \text{直前の二つの表示}) \\
&=c^2\,\frac{\mathrm{tr}(V')}{\mathrm{tr}(V'^{-1})}
   \quad (\because c\ne0) \\
&=c^2
   \quad (\because \mathrm{tr}(V')=\mathrm{tr}(V'^{-1}))
\end{aligned}`),
      paragraph(["一方 Step 1・Step 2 より（", "〔V_is_positive_definite〕", " より ", math(String.raw`\mathrm{tr}(V) > 0`), " なので ", math(String.raw`\tau = (2s_2)^{-M/2}\mathrm{tr}(V) \neq 0`), "）"]),
      displayMath(String.raw`\begin{aligned}
\frac{\mathrm{tr}(V)}{\mathrm{tr}(V^{-1})}
&=\frac{(2s_2)^{M/2}\,\tau}{(2s_2)^{-M/2}\,\tau}
   \quad (\because \text{Step 1 と Step 2}) \\
&=(2s_2)^M
   \quad (\because \tau\ne0\ \text{かつ指数法則})
\end{aligned}`),
      paragraph(["よって ", math(String.raw`c^2 = (2s_2)^{M}`), "。"]),
      paragraph(["Step 4（符号の確定）。", math(String.raw`c = \mathrm{tr}(V)/\mathrm{tr}(V')`), " であり、", "〔V_is_positive_definite〕", " より ", math(String.raw`\mathrm{tr}(V) \in \mathbb{R}_{>0}`), "、", "〔trace_of_Vprime〕", " より ", math(String.raw`\mathrm{tr}(V') \in \mathbb{R}_{>0}`), " なので ", math(String.raw`c \in \mathbb{R}_{>0}`), " である。"]),
      paragraph([math(String.raw`K_2 \in \mathbb{R}_{>0}`), " より ", math(String.raw`s_2 = \sinh 2K_2 > 0`), " なので ", math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`), " である。次の一続きで"]),
      displayMath(String.raw`\begin{aligned}
\left(c - (2s_2)^{M/2}\right)\left(c + (2s_2)^{M/2}\right)
&=c^2-\left((2s_2)^{M/2}\right)^2
   \quad (\because \text{和と差の積}) \\
&=c^2-(2s_2)^{M}
   \quad (\because \text{指数法則}\ \left((2s_2)^{M/2}\right)^2=(2s_2)^{M}) \\
&=(2s_2)^{M}-(2s_2)^{M}
   \quad (\because \text{Step 3 の}\ c^2=(2s_2)^{M}) \\
&=0
\end{aligned}`),
      paragraph(["である。"]),
      paragraph([math(String.raw`c > 0`), " かつ ", math(String.raw`(2s_2)^{M/2} > 0`), " より第 2 因子は正で ", math(String.raw`0`), " でない。よって第 1 因子が ", math(String.raw`0`), " であり ", math(String.raw`c = (2s_2)^{M/2}`), "。"]),
    ],
  },
  {
    id: "note_evenEigen_010_theorem_eigenvalues_of_V_plus_integer_route_eigenvalues_of_V_018_claim_eigenvalues_of_V",
    targets: ["eigenvalues_of_V_plus"],
    title: { tex: String.raw`V \text{ の固有値}` },
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 20 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/009_eigenvalues_of_V.ts の主張ブロック eigenvalues_of_V_018_claim_eigenvalues_of_V。labels: eigenvalues_of_V。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`\epsilon \in \{0,1\}^{\mathcal{I}}`), " に対して"]),
      displayMath(String.raw`\Lambda_\epsilon := (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right)\right) \in \mathbb{R}_{>0}`),
      paragraph(["とおく。このとき"]),
      list([[math(String.raw`\text{(1)}\quad V Q_\epsilon = \Lambda_\epsilon Q_\epsilon`), "。とくに ", math(String.raw`V`), " は対角化可能で、その固有値は重複度を込めて ", math(String.raw`\{\Lambda_\epsilon\ (\text{重複度 } 2^{M-m})\}_{\epsilon}`), " で尽くされる（総個数 ", math(String.raw`2^M`), "）。"], [math(String.raw`\text{(2)}`), " 固有値はすべて正の実数であり、最大のものは全ての ", math(String.raw`\epsilon_\mu = 1`), " を取ったとき、最小のものは全ての ", math(String.raw`\epsilon_\mu = 0`), " を取ったときである："]]),
      displayMath(String.raw`\Lambda_{\max} = (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\right), \qquad
\Lambda_{\min} = (2\sinh 2K_2)^{M/2}
\exp\!\left(-\frac{1}{2}\sum_{\mu \in \mathcal{I}} \gamma(\theta_\mu)\right)`),
      paragraph(["（したがって ", math(String.raw`\Lambda_{\max}\Lambda_{\min} = (2\sinh 2K_2)^{M} = c^2`), "。）"]),
      paragraph(["証明."]),
      paragraph(["(1) ", "〔constant_c_value〕", " より ", math(String.raw`V = (2s_2)^{M/2}V'`), " であり、", "〔eigenvalues_of_Vprime〕", " より ", math(String.raw`V'Q_\epsilon = \exp(g(\epsilon))Q_\epsilon`), " だから"]),
      displayMath(String.raw`\begin{aligned}
V Q_\epsilon
&= (2s_2)^{M/2}V'Q_\epsilon
   \quad (\because V=(2s_2)^{M/2}V') \\
&= (2s_2)^{M/2}\exp(g(\epsilon))Q_\epsilon
   \quad (\because V'Q_\epsilon=\exp(g(\epsilon))Q_\epsilon) \\
&= \Lambda_\epsilon Q_\epsilon
   \quad (\because \Lambda_\epsilon\ \text{の定義})
\end{aligned}`),
      paragraph(["対角化可能性・重複度・総個数は ", "〔eigenvalues_of_Vprime〕", " の Step 4 と同じ議論（", "〔joint_eigenspace_decomposition〕", " (5) による直和分解）で得られる。スカラー倍は固有ベクトルを変えない。"]),
      paragraph(["(2) ", math(String.raw`(2s_2)^{M/2} > 0`), " と ", math(String.raw`\exp(g(\epsilon)) > 0`), "（", ref("real_exp_positive"), "）より ", math(String.raw`\Lambda_\epsilon > 0`), "。"]),
      paragraph(["大小の比較。", math(String.raw`\Lambda_\epsilon = (2s_2)^{M/2}\exp(g(\epsilon))`), " で ", math(String.raw`(2s_2)^{M/2}`), " は ", math(String.raw`\epsilon`), " に依らない正の定数、", math(String.raw`t \mapsto \exp(t)`), " は実数上の狭義単調増加関数（", ref("real_exp_strictly_increasing"), "）なので、", math(String.raw`\Lambda_\epsilon`), " の大小は ", math(String.raw`g(\epsilon) = \sum_{\mu}\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`), " の大小と一致する。", "〔def_gamma_theta_mu〕", " より ", math(String.raw`\gamma(\theta_\mu) \geq 0`), " なので、各項 ", math(String.raw`\gamma(\theta_\mu)(\epsilon_\mu - \tfrac12)`), " は ", math(String.raw`\epsilon_\mu = 1`), " のとき ", math(String.raw`+\tfrac12\gamma(\theta_\mu)`), "、", math(String.raw`\epsilon_\mu = 0`), " のとき ", math(String.raw`-\tfrac12\gamma(\theta_\mu)`), " であり、前者が後者以上である。各項は独立に選べるので、和が最大になるのは全ての ", math(String.raw`\epsilon_\mu = 1`), "、最小になるのは全ての ", math(String.raw`\epsilon_\mu = 0`), " のときである。それぞれ"]),
      displayMath(String.raw`\begin{aligned}
g(1,\dots,1)
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\left(1 - \tfrac12\right)
   \quad (\because g\ \text{の定義に}\ \epsilon_\mu=1\ \text{を代入}) \\
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\cdot\frac12
   \quad \left(\because 1-\tfrac12=\tfrac12\right) \\
&= \frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)
   \quad \left(\because \text{和の線型性}\right)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
g(0,\dots,0)
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\left(0 - \tfrac12\right)
   \quad (\because g\ \text{の定義に}\ \epsilon_\mu=0\ \text{を代入}) \\
&= \sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)\cdot\left(-\frac12\right)
   \quad \left(\because 0-\tfrac12=-\tfrac12\right) \\
&= -\frac{1}{2}\sum_{\mu \in \mathcal{I}}\gamma(\theta_\mu)
   \quad \left(\because \text{和の線型性}\right)
\end{aligned}`),
      paragraph(["を代入して statement の ", math(String.raw`\Lambda_{\max}, \Lambda_{\min}`), " を得る。積は次の鎖で求まる。"]),
      displayMath(String.raw`\begin{aligned}
\Lambda_{\max}\Lambda_{\min}
&= (2s_2)^{M/2}\exp(g(1,\dots,1))\,(2s_2)^{M/2}\exp(g(0,\dots,0))
   \quad (\because \Lambda_{\max},\Lambda_{\min}\ \text{の表式}) \\
&= \left((2s_2)^{M/2}(2s_2)^{M/2}\right)
   \left(\exp(g(1,\dots,1))\exp(g(0,\dots,0))\right)
   \quad (\because \text{積の可換則と結合則}) \\
&= (2s_2)^{M}\left(\exp(g(1,\dots,1))\exp(g(0,\dots,0))\right)
   \quad (\because \text{冪の法則}) \\
&= (2s_2)^{M}\exp(g(1,\dots,1)+g(0,\dots,0))
   \quad (\because \text{実数の exp の積公式。}\blkref{scalar_exp_product}) \\
&= (2s_2)^{M}\exp(0)
   \quad (\because g(1,\dots,1)+g(0,\dots,0)=0) \\
&= (2s_2)^{M}
   \quad (\because \exp(0)=1\ \blkref{scalar_exp_zero})
\end{aligned}`),
    ],
  },
  {
    id: "note_evensector_004_claim_commutator_H_check_Z_Y_integer_route_evensector_001_claim_why_minus_only",
    targets: ["commutator_of_H_and_check_Z_Y"],
    title: { tex: String.raw`008 \text{ 章の議論が } (-) \text{ セクター専用である理由}` },
    origin: { path: "structured-latex/content/013_even_sector_modes.ts", ordinal: 3 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/013_even_sector_modes.ts の主張ブロック evensector_001_claim_why_minus_only。labels: why_008_applies_only_to_minus_sector。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔def_hatZ_pm〕", " の ", math(String.raw`\hat{Z}_\mu^{(\pm)}`), " と ", ref("def_transfer_matrix_symbols"), " の ", math(String.raw`H_2`), " について、", math(String.raw`\mu \in \mathcal{M}`), " で"]),
      displayMath(String.raw`\left[H_2,\ \hat{Z}_\mu^{(-)}\right] = -2\,\hat{Y}_\mu,
\qquad
\left[H_2,\ \hat{Z}_\mu^{(+)}\right] = -2\,\hat{Y}_\mu + 4\,\exp(-i\frac{2\pi\mu}{M})\,Y_1`),
      paragraph(["が成り立つ。とくに ", math(String.raw`Y_1 \neq 0`), " なので **", math(String.raw`\left[H_2, \hat{Z}_\mu^{(+)}\right] \neq -2\hat{Y}_\mu`), "** である。"]),
      paragraph(["〔commutator_of_H_and_Z_Y〕", " の (C) は ", math(String.raw`\hat{Z}_\mu^{(-)}`), " についての主張であり、008 章以降の議論（", "〔nesting_of_commutator_of_H_and_Z〕", " の (h2.z−) 以下すべて）はこの (C) を土台にしている。", "したがって **008 章以降は ", math(String.raw`(-)`), " セクター専用であり、", math(String.raw`V^{(+)}`), " にはそのまま適用できない。**"]),
      paragraph(["証明."]),
      paragraph(["Step 1（サイトごとの交換関係）。", math(String.raw`H_2 = \sum_{m=1}^{M} Z_mY_m`), " と ", ref("anticommutator_of_Z_and_Y"), " から、", math(String.raw`j \in \{1,\dots,M\}`), " について"]),
      displayMath(String.raw`\left[H_2,\ Z_j\right] = -2\,Y_j`),
      paragraph(["を示す。", math(String.raw`m \neq j`), " の項について、", ref("anticommutator_of_Z_and_Y"), " より ", math(String.raw`Z_mZ_j = -Z_jZ_m`), "、", math(String.raw`Y_mZ_j = -Z_jY_m`), " なので"]),
      displayMath(String.raw`\begin{aligned}
\left(Z_mY_m\right)Z_j
&= Z_m\left(Y_mZ_j\right)
   &&(\because \text{行列の積の結合法則}) \\
&= Z_m\left(-Z_jY_m\right)
   &&(\because \text{anticommutator\_of\_Z\_and\_Y}\ (m \neq j)) \\
&= -\left(Z_mZ_j\right)Y_m
   &&(\because \text{結合法則とスカラー倍}) \\
&= -\left(-Z_jZ_m\right)Y_m
   &&(\because \text{anticommutator\_of\_Z\_and\_Y}\ (m \neq j)) \\
&= Z_j\left(Z_mY_m\right)
   &&(\because -(-1) = 1 \text{ の符号の消去と行列の積の結合法則})
\end{aligned}`),
      paragraph(["すなわち ", math(String.raw`[Z_mY_m, Z_j] = 0`), "（符号が 2 回反転して戻る）。", math(String.raw`m = j`), " の項は、", math(String.raw`Y_jZ_j = -Z_jY_j`), " と ", math(String.raw`Z_jZ_j = I`), "（", ref("anticommutator_of_Z_and_Y"), " で ", math(String.raw`\mu=\nu=j`), " とすると ", math(String.raw`2Z_j^2 = 2I`), "）より"]),
      displayMath(String.raw`\begin{aligned}
\left[Z_jY_j,\ Z_j\right]
&= \left(Z_jY_j\right)Z_j - Z_j\left(Z_jY_j\right)
   &&(\because \text{交換子の定義}) \\
&= Z_j\left(Y_jZ_j\right) - \left(Z_jZ_j\right)Y_j
   &&(\because \text{行列の積の結合法則}) \\
&= Z_j\left(-Z_jY_j\right) - \left(Z_jZ_j\right)Y_j
   &&(\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= -\left(Z_jZ_j\right)Y_j - \left(Z_jZ_j\right)Y_j
   &&(\because \text{結合法則とスカラー倍}) \\
&= -I\,Y_j - I\,Y_j
   &&(\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_jZ_j = I)) \\
&= -2Y_j
   &&(\because I\,Y_j = Y_j \text{（単位行列）と同じ行列の和})
\end{aligned}`),
      paragraph(["交換子は第 2 引数について線型なので、和をとって ", math(String.raw`[H_2, Z_j] = -2Y_j`), "。"]),
      paragraph(["Step 2（", math(String.raw`(-)`), " の場合）。", "〔def_hatZ_pm〕", " より ", math(String.raw`\hat{Z}_\mu^{(-)} = \sum_{j=1}^{M} \exp(-i\frac{2\pi j\mu}{M})Z_j`), "（", math(String.raw`j=1`), " の係数は ", math(String.raw`-(-1) = +1`), "）である。交換子の線型性と Step 1 より"]),
      displayMath(String.raw`\begin{aligned}
\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&= \left[H_2,\ \sum_{j=1}^{M} \exp(-i\frac{2\pi j\mu}{M})Z_j\right]
   &&(\because \text{def\_hatZ\_pm}) \\
&= \sum_{j=1}^{M} \exp(-i\frac{2\pi j\mu}{M})\left[H_2,\ Z_j\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} \exp(-i\frac{2\pi j\mu}{M})\left(-2Y_j\right)
   &&(\because \text{Step 1}) \\
&= -2\sum_{j=1}^{M} \exp(-i\frac{2\pi j\mu}{M})\,Y_j
   &&(\because \text{スカラー倍を有限和の外へ出す（分配律）}) \\
&= -2\,\hat{Y}_\mu
   &&(\because \text{def\_hatY})
\end{aligned}`),
      paragraph(["（最初と最後の等号で使ったのは ", "〔def_hatZ_pm〕", " と ", "〔def_hatY〕", " の定義である。）"]),
      paragraph(["Step 3（", math(String.raw`(+)`), " の場合）。", "〔def_hatZ_pm〕", " より ", math(String.raw`\hat{Z}_\mu^{(+)}`), " は ", math(String.raw`j=1`), " の係数だけが ", math(String.raw`-1`), " なので"]),
      displayMath(String.raw`\hat{Z}_\mu^{(+)} = \hat{Z}_\mu^{(-)} - 2\,\exp(-i\frac{2\pi\mu}{M})\,Z_1`),
      paragraph(["（", math(String.raw`j=1`), " の係数が ", math(String.raw`+1`), " から ", math(String.raw`-1`), " へ変わる分を引いた）。交換子の線型性と Step 1・Step 2 より"]),
      displayMath(String.raw`\begin{aligned}
\left[H_2,\ \hat{Z}_\mu^{(+)}\right]
&= \left[H_2,\ \hat{Z}_\mu^{(-)} - 2\exp(-i\frac{2\pi\mu}{M})Z_1\right]
   &&(\because \text{直前の displayMath}) \\
&= \left[H_2,\ \hat{Z}_\mu^{(-)}\right] - 2\exp(-i\frac{2\pi\mu}{M})\left[H_2,\ Z_1\right]
   &&(\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -2\hat{Y}_\mu - 2\exp(-i\frac{2\pi\mu}{M})\left[H_2,\ Z_1\right]
   &&(\because \text{Step 2}) \\
&= -2\hat{Y}_\mu - 2\exp(-i\frac{2\pi\mu}{M})\left(-2Y_1\right)
   &&(\because \text{Step 1 を } j = 1 \text{ に適用}) \\
&= -2\hat{Y}_\mu + 4\,\exp(-i\frac{2\pi\mu}{M})\,Y_1
   &&(\because (-2)\cdot(-2) = 4 \text{ のスカラーの計算})
\end{aligned}`),
      paragraph(["Step 4（", math(String.raw`Y_1 \neq 0`), "）。", ref("def_transfer_matrix_symbols"), " より ", math(String.raw`Y_1 = \sigma_1^y`), " であり、", ref("pauli_matrix_products"), " の ", math(String.raw`\sigma^y\sigma^y = I`), " より ", math(String.raw`Y_1`), " は可逆、とくに ", math(String.raw`Y_1 \neq 0`), "。また ", math(String.raw`\exp(-i2\pi\mu/M) \neq 0`), " なので ", math(String.raw`4\exp(-i2\pi\mu/M)Y_1 \neq 0`), " であり、2 つの交換子は一致しない。"]),
    ],
  },
]);
