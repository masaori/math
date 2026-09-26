import { defineNotes, paragraph, math, displayMath, list, ref } from "../schema.ts";
import type { Label } from "../schema.ts";

// (−) セクター（全スピン反転 ε の固有値 −1 の側）の議論（本文不採用）。文書本体ではない。
//
// 奇セクターの固有ベクトル集合 F^{(−)}、分配関数の偶奇セクター分解、c(M) = max(c_+(M), c_-(M))、
// および「最大固有値はどちらのセクターから来るか」（c_-(M) ≤ c_+(M)）の章である。もとは content/ の
// 004・010・011・019 章にあった本文ブロックで、内容はそのまま運んだ。退避したラベルへの参照は
// 〔ラベル〕という文字列に置き換えてある。
//
// **本文には採用しなかった。** 理由: 自由エネルギー（Onsager の厳密解）の証明が使うのは
// c(M) ≥ c_+(M) と、W の成分の正値性と ε による上からの評価だけであり、(−) セクターの情報は要らない。
// 奇セクターが要るのは相関長・有限サイズ補正・自発磁化など W の全スペクトルを扱う問題で、本文の到達点に含まれない。

const NOT_ADOPTED = paragraph<Label>([
  "【本文不採用の (−) セクターの議論。理由: 自由エネルギーの証明は c(M) ≥ c_+(M) と偶セクター側の評価だけで閉じ、",
  "(−) セクターの情報を使わないため。】",
]);

export default defineNotes([
  {
    id: "note_transfer_matrix_004_definition_eigenspace_even_of_epsilon_minus_sector_transfer_matrix_004_definition_eigenspace_odd_of_epsilon",
    targets: ["def_even_eigenvectors_of_epsilon"],
    title: { tex: String.raw`\varepsilon\text{ の固有値 }-1\text{ の固有ベクトル全体}` },
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の定義ブロック transfer_matrix_004_definition_eigenspace_odd_of_epsilon。labels: def_odd_eigenvectors_of_epsilon。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`), " とし、", ref("def_transfer_matrix_symbols"), " の ", math(String.raw`\varepsilon\in\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`), " を考える。", math(String.raw`\varepsilon`), " を ", math(String.raw`2^{M_{\mathrm{col}}}`), " 成分の複素数ベクトルへ ", ref("mat_mult"), " の通常の行列と数ベクトルの積として作用させ、"]),
      displayMath(String.raw`\mathcal{F}^{(-)}
:=\left\{f\in\mathbb{C}^{2^{M_{\mathrm{col}}}}\;\middle|\;\varepsilon f=-f\right\}`),
      paragraph(["と定める。すなわち ", math(String.raw`\mathcal{F}^{(-)}`), " は、全スピン反転行列を左から掛けると符号が反転する複素数ベクトルの全体である。"]),
    ],
  },
  {
    id: "note_transfer_matrix_004_claim_even_eigenspace_is_complex_subspace_minus_sector_transfer_matrix_004_claim_odd_eigenspace_is_complex_subspace",
    targets: ["even_eigenspace_is_complex_subspace"],
    title: { tex: String.raw`\mathcal{F}^{(-)}\text{ の複素部分線型空間性}` },
    origin: { path: "structured-latex/content/004_transfer_matrix.ts", ordinal: 4 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/004_transfer_matrix.ts の主張ブロック transfer_matrix_004_claim_odd_eigenspace_is_complex_subspace。labels: odd_eigenspace_is_complex_subspace。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M_{\mathrm{col}}\in\mathbb{Z}_{\geq 1}`), " とし、", "〔def_odd_eigenvectors_of_epsilon〕", " の ", math(String.raw`\mathcal{F}^{(-)}\subseteq\mathbb{C}^{2^{M_{\mathrm{col}}}}`), " を考える。この集合は零ベクトルを含み、複素数ベクトルの和と複素スカラー倍について閉じる。すなわち、"]),
      displayMath(String.raw`0\in\mathcal{F}^{(-)}`),
      paragraph(["であり、任意の ", math(String.raw`f,g\in\mathcal{F}^{(-)}`), " と ", math(String.raw`a\in\mathbb{C}`), " に対して、"]),
      displayMath(String.raw`f+g\in\mathcal{F}^{(-)},\qquad af\in\mathcal{F}^{(-)}`),
      paragraph(["が成り立つ。したがって ", math(String.raw`\mathcal{F}^{(-)}`), " は ", math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`), " の複素部分線型空間である。"]),
      paragraph(["証明."]),
      paragraph([ref("mat_mult"), " の行列と数ベクトルの積、および ", ref("complex_numbers_form_a_field"), " の複素数の演算法則を用いる。複素数ベクトルの演算は成分ごとに定め、任意の ", math(String.raw`u,v\in\mathbb{C}^{2^{M_{\mathrm{col}}}}`), "、", math(String.raw`a\in\mathbb{C}`), "、", math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`), " に対して ", math(String.raw`[u+v]_r:=u_r+v_r`), "、", math(String.raw`[au]_r:=au_r`), " および ", math(String.raw`[-u]_r:=-u_r`), " とする。まず零ベクトルを考える。任意の ", math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon 0]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}0
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}0
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の零倍}\right)\\
&=0
&&\left(\because\ \text{有限個の零の和}\right)\\
&=-0
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の零の加法逆元}\right).
\end{aligned}`),
      paragraph(["全ての成分が一致するので ", math(String.raw`\varepsilon 0=-0`), " である。よって ", "〔def_odd_eigenvectors_of_epsilon〕", " から ", math(String.raw`0\in\mathcal{F}^{(-)}`), " である。"]),
      paragraph(["次に ", math(String.raw`f,g\in\mathcal{F}^{(-)}`), " とする。", "〔def_odd_eigenvectors_of_epsilon〕", " より ", math(String.raw`\varepsilon f=-f`), " かつ ", math(String.raw`\varepsilon g=-g`), " である。任意の ", math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon(f+g)]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}(f_s+g_s)
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(\varepsilon_{rs}f_s+\varepsilon_{rs}g_s)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の分配律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}f_s+\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}g_s
&&\left(\because\ \text{有限和を項ごとに分ける}\right)\\
&=[\varepsilon f]_r+[\varepsilon g]_r
&&\left(\because\ \blkref{mat_mult}\right)\\
&=-f_r+(-g_r)
&&\left(\because\ \varepsilon f=-f\ \text{かつ}\ \varepsilon g=-g\right)\\
&=-(f_r+g_r)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の和の加法逆元}\right)\\
&=[-(f+g)]_r
&&\left(\because\ \text{複素数ベクトルの加法逆元の定義}\right).
\end{aligned}`),
      paragraph(["全ての成分が一致するので ", math(String.raw`\varepsilon(f+g)=-(f+g)`), " である。よって ", "〔def_odd_eigenvectors_of_epsilon〕", " から ", math(String.raw`f+g\in\mathcal{F}^{(-)}`), " である。"]),
      paragraph(["最後に ", math(String.raw`a\in\mathbb{C}`), " と ", math(String.raw`f\in\mathcal{F}^{(-)}`), " を取る。", "〔def_odd_eigenvectors_of_epsilon〕", " より ", math(String.raw`\varepsilon f=-f`), " である。任意の ", math(String.raw`r\in\{1,\dots,2^{M_{\mathrm{col}}}\}`), " について、"]),
      displayMath(String.raw`\begin{aligned}
[\varepsilon(af)]_r
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}(af_s)
&&\left(\because\ \blkref{mat_mult}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(\varepsilon_{rs}a)f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}(a\varepsilon_{rs})f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の可換律}\right)\\
&=\sum_{s=1}^{2^{M_{\mathrm{col}}}}a(\varepsilon_{rs}f_s)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積の結合律}\right)\\
&=a\sum_{s=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{rs}f_s
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の分配律を有限回適用}\right)\\
&=a[\varepsilon f]_r
&&\left(\because\ \blkref{mat_mult}\right)\\
&=a(-f_r)
&&\left(\because\ \varepsilon f=-f\right)\\
&=-(af_r)
&&\left(\because\ \blkref{complex_numbers_form_a_field}\text{ の積と加法逆元の両立}\right)\\
&=[-(af)]_r
&&\left(\because\ \text{複素数ベクトルの加法逆元とスカラー倍の定義}\right).
\end{aligned}`),
      paragraph(["全ての成分が一致するので ", math(String.raw`\varepsilon(af)=-(af)`), " である。よって ", "〔def_odd_eigenvectors_of_epsilon〕", " から ", math(String.raw`af\in\mathcal{F}^{(-)}`), " である。零ベクトル・和・複素スカラー倍についての三つの結果から、主張を得る。"]),
    ],
  },
  {
    id: "note_maxeig_claim_symmetrized_transfer_matrix_on_sectors_minus_sector_bridge_011_claim_sector_replacement",
    targets: ["symmetrized_transfer_matrix_on_sectors"],
    title: { tex: String.raw`\text{セクター上での } V_1 \text{ の置き換え}` },
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 13 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/010_transfer_matrix_bridge.ts の主張ブロック bridge_011_claim_sector_replacement。本文にあったときは V_1^{(±)} の両符号を含む旧定義を参照していた。labels: sector_replacement_of_V1。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_V1_plus"), " の記号のもとで（複号同順）"]),
      displayMath(String.raw`V_1\,P^{(\pm)} = V_1^{(\pm)}\,P^{(\pm)}`),
      paragraph(["証明."]),
      paragraph(["固有空間上では、"]),
      displayMath(String.raw`\left(V_1\right)\big|_{\mathcal{F}^{(\pm)}}
= \left(V_1^{(\pm)}\right)\big|_{\mathcal{F}^{(\pm)}}
\quad (\because \blkref{V1_restriction_to_eigenspaces}\ \text{と }\blkref{def_end_iso}\ \text{の同一視})`),
      paragraph(["すなわち任意の ", math(String.raw`f \in \mathcal{F}^{(\pm)}`), " について次を主張している。"]),
      displayMath(String.raw`V_1 f
= V_1^{(\pm)} f
\quad (\because \left.V_1\right|_{\mathcal{F}^{(\pm)}}=\left.V_1^{(\pm)}\right|_{\mathcal{F}^{(\pm)}})`),
      paragraph(["任意の ", math(String.raw`x \in \mathcal{F}`), " について ", math(String.raw`P^{(\pm)}x \in \mathrm{im}\,P^{(\pm)} = \mathcal{F}^{(\pm)}`), " なので、次の鎖を得る。"]),
      displayMath(String.raw`\begin{aligned}
\left(V_1P^{(\pm)}\right)x
&=V_1\left(P^{(\pm)}x\right)
  \quad (\because \text{行列積の作用})\\
&=V_1^{(\pm)}\left(P^{(\pm)}x\right)
  \quad (\because \blkref{epsilon_projector_properties}\ \text{と上の制限の等式})\\
&=\left(V_1^{(\pm)}P^{(\pm)}\right)x
  \quad (\because \text{行列積の作用})
\end{aligned}`),
      paragraph(["この等式が任意の ", math(String.raw`x`), " について成り立つ。行列は ", math(String.raw`\mathcal{F} = \mathbb{C}^{2^{M_{\mathrm{col}}}}`), " のすべてのベクトルへの作用で決まるので、"]),
      displayMath(String.raw`V_1P^{(\pm)}
=V_1^{(\pm)}P^{(\pm)}
\quad (\because \text{すべての }x\in\mathcal{F}\text{ への作用が等しい})`),
      paragraph(["である。"]),
    ],
  },
  {
    id: "note_maxeig_claim_symmetrized_transfer_matrix_on_sectors_minus_sector_bridge_011a_claim_sector_replacement_pow",
    targets: ["symmetrized_transfer_matrix_on_sectors"],
    title: { text: "セクター上での置き換えを転送行列の積の冪へ反復" },
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 13 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/010_transfer_matrix_bridge.ts の主張ブロック bridge_011a_claim_sector_replacement_pow。labels: sector_replacement_pow。以下は本文にあったときの内容のまま。）"]),
      paragraph(["（複号同順）"]),
      displayMath(String.raw`n \in \mathbb{Z}_{\geq 0} \text{ について } (V_1V_2)^{n}\,P^{(\pm)} = \left(V_1^{(\pm)}V_2\right)^{n}P^{(\pm)}`),
      paragraph(["証明."]),
      paragraph([math(String.raw`P := P^{(\pm)}`), " と略記する。", ref("epsilon_projectors_commute_with_transfer_matrices"), " より ", math(String.raw`P`), " は ", math(String.raw`V_1, V_2, V_1^{(\pm)}`), " のすべてと可換であり、", ref("epsilon_projector_properties"), " (2) より ", math(String.raw`P^2 = P`), " である。", math(String.raw`n`), " についての帰納法で示す。"]),
      paragraph([math(String.raw`n = 0`), " のときは両辺とも ", math(String.raw`P`), " で成立。", math(String.raw`(V_1V_2)^{n}P = (V_1^{(\pm)}V_2)^{n}P`), " を仮定する。", "〔sector_replacement_of_V1〕", " と合わせると、"]),
      displayMath(String.raw`\begin{aligned}
(V_1V_2)^{n+1}P
&= V_1V_2\,(V_1V_2)^{n}P
   \quad (\because \text{冪の定義}) \\
&= V_1V_2\,(V_1V_2)^{n}P\,P
   \quad (\because P^2 = P) \\
&= V_1V_2\,P\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_1, V_2 \text{ と可換なので } (V_1V_2)^{n} \text{ とも可換}) \\
&= V_1\,P\,V_2\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_2 \text{ と可換}) \\
&= V_1^{(\pm)}\,P\,V_2\,(V_1V_2)^{n}P
   \quad (\because \text{セクター上での } V_1 \text{ の置き換え}) \\
&= V_1^{(\pm)}\,V_2\,P\,(V_1V_2)^{n}P
   \quad (\because P \text{ は } V_2 \text{ と可換}) \\
&= V_1^{(\pm)}\,V_2\,(V_1V_2)^{n}P\,P
   \quad (\because P \text{ は } V_1, V_2 \text{ と可換なので } (V_1V_2)^{n} \text{ とも可換}) \\
&= V_1^{(\pm)}\,V_2\,(V_1V_2)^{n}P
   \quad (\because P^2 = P) \\
&= V_1^{(\pm)}\,V_2\,\left(V_1^{(\pm)}V_2\right)^{n}P
   \quad (\because \text{帰納法の仮定}) \\
&= \left(V_1^{(\pm)}V_2\right)^{n+1}P
   \quad (\because \text{冪の定義})
\end{aligned}`),
    ],
  },
  {
    id: "note_partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix_minus_sector_bridge_012_claim_partition_function_sector_decomposition",
    targets: ["partition_function_via_transfer_matrix"],
    title: { text: "分配関数の偶奇セクター分解" },
    origin: { path: "structured-latex/content/010_transfer_matrix_bridge.ts", ordinal: 14 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/010_transfer_matrix_bridge.ts の主張ブロック bridge_012_claim_partition_function_sector_decomposition。labels: partition_function_sector_decomposition。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("partition_function_via_transfer_matrix"), " と同じ設定のもと、"]),
      displayMath(String.raw`V^{(\pm)} := \left(V_1^{(\pm)}\right)^{1/2} V_2 \left(V_1^{(\pm)}\right)^{1/2},
\qquad \left(V_1^{(\pm)}\right)^{1/2} := \exp\!\left(\tfrac{1}{2}iK_1H_1^{(\pm)}\right)`),
      paragraph(["について"]),
      displayMath(String.raw`Z(K_1, K_2)
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)`),
      paragraph(["が成り立つ。", ref("def_epsilon_projectors"), " の ", math(String.raw`P^{(\pm)} = \tfrac12(I\pm\varepsilon)`), " を代入すれば"]),
      displayMath(String.raw`Z(K_1,K_2) = \tfrac{1}{2}\Bigl(
  \mathrm{tr}\bigl((V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl(\varepsilon\,(V^{(+)})^{N_{\mathrm{row}}}\bigr)
+ \mathrm{tr}\bigl((V^{(-)})^{N_{\mathrm{row}}}\bigr)
- \mathrm{tr}\bigl(\varepsilon\,(V^{(-)})^{N_{\mathrm{row}}}\bigr)
\Bigr)`),
      paragraph(["とも書ける。"]),
      paragraph(["証明."]),
      paragraph(["Step 1（トレースをセクターに分ける）。", ref("epsilon_projector_properties"), " (3) の ", math(String.raw`P^{(+)} + P^{(-)} = I`), " と ", ref("trace_basic_properties"), " (1) の線型性より、任意の ", math(String.raw`X \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`), " について"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}(X)
&= \mathrm{tr}\!\left(IX\right)
   \quad (\because \text{単位行列の作用}) \\
&= \mathrm{tr}\!\left(\left(P^{(+)}+P^{(-)}\right)X\right)
   \quad (\because P^{(+)}+P^{(-)}=I) \\
&= \mathrm{tr}\!\left(P^{(+)}X\right) + \mathrm{tr}\!\left(P^{(-)}X\right)
   \quad (\because \text{トレースの線型性})
\end{aligned}`),
      paragraph(["これを ", ref("partition_function_via_transfer_matrix"), " の ", math(String.raw`X = (V_1V_2)^{N_{\mathrm{row}}}`), " に適用して"]),
      displayMath(String.raw`Z(K_1,K_2)
= \mathrm{tr}\!\left(P^{(+)}(V_1V_2)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}(V_1V_2)^{N_{\mathrm{row}}}\right)
\quad (\because \blkref{partition_function_via_transfer_matrix}\text{ と上のトレース分解})`),
      paragraph(["Step 2（各セクターで ", math(String.raw`V_1`), " を ", math(String.raw`V_1^{(\pm)}`), " に置き換える）。", "〔sector_replacement_pow〕", " より（複号同順）"]),
      displayMath(String.raw`\mathrm{tr}\!\left(P^{(\pm)}(V_1V_2)^{N_{\mathrm{row}}}\right)
= \mathrm{tr}\!\left(P^{(\pm)}\left(V_1^{(\pm)}V_2\right)^{N_{\mathrm{row}}}\right)
\quad (\because \text{セクター内での }V_1\text{ の置換})`),
      paragraph(["（", math(String.raw`P^{(\pm)}`), " は ", math(String.raw`V_1, V_2`), " と可換なので ", math(String.raw`P^{(\pm)}(V_1V_2)^n = (V_1V_2)^nP^{(\pm)}`), " であり、", "〔sector_replacement_pow〕", " をそのまま使える。）"]),
      paragraph(["Step 3（対称化）。", math(String.raw`B := \left(V_1^{(\pm)}\right)^{1/2}`), " と略記する。", ref("theorem_exp_product"), " と同じ行列どうしの可換性より次の鎖を得る。"]),
      displayMath(String.raw`\begin{aligned}
BB
&= \exp\!\left(\tfrac12 iK_1H_1^{(\pm)}\right)
   \exp\!\left(\tfrac12 iK_1H_1^{(\pm)}\right)
   \quad (\because B\text{ の定義}) \\
&= \exp\!\left(iK_1H_1^{(\pm)}\right)
   \quad (\because \text{可換する行列の指数関数の積}) \\
&= V_1^{(\pm)}
   \quad (\because V_1^{(\pm)}\text{ の定義})
\end{aligned}`),
      paragraph([math(String.raw`n := N_{\mathrm{row}} \geq 1`), " として"]),
      displayMath(String.raw`\begin{aligned}
\left(V^{(\pm)}\right)^{n}
&= \left(B V_2 B\right)^{n}
   \quad (\because V^{(\pm)}\text{ の定義}) \\
&= B\,\underbrace{(V_2 B B)(V_2 BB)\cdots(V_2BB)}_{n-1 \text{ 個}}\,V_2\,B
   \quad (\because \text{行列積の結合法則}) \\
&= B\,\left(V_2 V_1^{(\pm)}\right)^{n-1}V_2\,B
   \quad (\because BB=V_1^{(\pm)})
\end{aligned}`),
      paragraph(["（結合法則で括り直し、隣接する ", math(String.raw`B\,B = V_1^{(\pm)}`), " をまとめた。）よって ", ref("trace_basic_properties"), " (2) の巡回性と、", ref("epsilon_projectors_commute_with_transfer_matrices"), " による ", math(String.raw`P^{(\pm)}`), " と ", math(String.raw`B`), " の可換性から"]),
      displayMath(String.raw`\begin{aligned}
\mathrm{tr}\!\left(P^{(\pm)}\left(V^{(\pm)}\right)^{n}\right)
&= \mathrm{tr}\!\left(P^{(\pm)}B\left(V_2V_1^{(\pm)}\right)^{n-1}V_2B\right)
   \quad (\because \text{直前の鎖で得た }\left(V^{(\pm)}\right)^{n}\text{ の表示を代入}) \\
&= \mathrm{tr}\!\left(B\,P^{(\pm)}B\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because \text{巡回性で右端の } B \text{ を左へ}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}BB\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because P^{(\pm)} \text{ と } B \text{ は可換}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}V_1^{(\pm)}\left(V_2V_1^{(\pm)}\right)^{n-1}V_2\right)
   \quad (\because BB = V_1^{(\pm)}) \\
&= \mathrm{tr}\!\left(P^{(\pm)}\left(V_1^{(\pm)}V_2\right)^{n}\right)
   \quad (\because \text{行列積の結合法則})
\end{aligned}`),
      paragraph(["Step 4（結論）。Step 1〜3 を合わせて"]),
      displayMath(String.raw`Z(K_1,K_2)
= \mathrm{tr}\!\left(P^{(+)}\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
+ \mathrm{tr}\!\left(P^{(-)}\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)
\quad (\because \text{Step 1--3})`),
      paragraph(["さらに ", ref("def_epsilon_projectors"), " の射影子の定義と ", ref("trace_basic_properties"), " (1) の線型性により、次の鎖で statement の 4 項の形を得る。"]),
      displayMath(String.raw`\begin{aligned}
Z(K_1,K_2)
&= \mathrm{tr}\!\left(\tfrac12(I+\varepsilon)\left(V^{(+)}\right)^{N_{\mathrm{row}}}\right)
 + \mathrm{tr}\!\left(\tfrac12(I-\varepsilon)\left(V^{(-)}\right)^{N_{\mathrm{row}}}\right)
   \quad (\because P^{(\pm)}=\tfrac12(I\pm\varepsilon)) \\
&= \tfrac12\Bigl(
  \mathrm{tr}\bigl((V^{(+)})^{N_{\mathrm{row}}}\bigr)
 + \mathrm{tr}\bigl(\varepsilon\,(V^{(+)})^{N_{\mathrm{row}}}\bigr)
 + \mathrm{tr}\bigl((V^{(-)})^{N_{\mathrm{row}}}\bigr)
 - \mathrm{tr}\bigl(\varepsilon\,(V^{(-)})^{N_{\mathrm{row}}}\bigr)
\Bigr)
   \quad (\because \text{トレースの線型性})
\end{aligned}`),
    ],
  },
  {
    id: "note_maxeig_claim_c_plus_le_c_minus_sector_maxeig_010_claim_sector_decomposition_of_c",
    targets: ["c_plus_le_c"],
    title: { tex: String.raw`c(M_{\mathrm{col}}) = \max\left(c_+(M_{\mathrm{col}}), c_-(M_{\mathrm{col}})\right)` },
    origin: { path: "structured-latex/content/011_max_eigenvalue.ts", ordinal: 12 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/011_max_eigenvalue.ts の主張ブロック maxeig_010_claim_sector_decomposition_of_c。labels: sector_decomposition_of_rayleigh_sup。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("def_rayleigh_sup"), " の ", math(String.raw`c(M_{\mathrm{col}})`), " と ", ref("def_sector_rayleigh_sup"), " の ", math(String.raw`c_\pm(M_{\mathrm{col}})`), " について、次が成り立つ。"]),
      displayMath(String.raw`c(M_{\mathrm{col}}) = \max\left(c_+(M_{\mathrm{col}}), c_-(M_{\mathrm{col}})\right)`),
      paragraph(["証明."]),
      paragraph([ref("epsilon_projector_properties"), " (2)(3) より、任意の ", math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`), " は ", math(String.raw`x = x_+ + x_-`), "（", math(String.raw`x_\pm := P^{(\pm)}x \in \mathcal{F}^{(\pm)}`), "）と分解される。", ref("epsilon_square_and_eigenvalues"), " の証明で得た ", math(String.raw`\varepsilon=\sigma^x\boxtimes\cdots\boxtimes\sigma^x`), " と、", ref("pauli_matrix_products"), " の ", math(String.raw`\sigma^x`), " の成分表示、", ref("kronecker_transpose"), " より、"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon^\top
&=\left(\sigma^x\boxtimes\cdots\boxtimes\sigma^x\right)^\top
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示})\\
&=(\sigma^x)^\top\boxtimes\cdots\boxtimes(\sigma^x)^\top
  \quad (\because \blkref{kronecker_transpose})\\
&=\sigma^x\boxtimes\cdots\boxtimes\sigma^x
  \quad (\because \blkref{pauli_matrix_products}\ \text{の }\sigma^x\text{ の成分表示})\\
&=\varepsilon
  \quad (\because \blkref{epsilon_square_and_eigenvalues}\ \text{の証明で得た表示}).
\end{aligned}`),
      paragraph(["したがって ", math(String.raw`\varepsilon`), " は実対称である。さらに、", ref("def_epsilon_projectors"), " から ", math(String.raw`P^{(\pm)}`), " も実対称である。実際、"]),
      displayMath(String.raw`\begin{aligned}
\left(P^{(\pm)}\right)^\top
&=\left(\tfrac12(I\pm\varepsilon)\right)^\top
  \quad (\because \blkref{def_epsilon_projectors})\\
&=\tfrac12\left(I^\top\pm\varepsilon^\top\right)
  \quad (\because \text{転置は和と実数倍を保つ})\\
&=\tfrac12(I\pm\varepsilon)
  \quad (\because I^\top=I,\ \varepsilon^\top=\varepsilon)\\
&=P^{(\pm)}
  \quad (\because \blkref{def_epsilon_projectors}).
\end{aligned}`),
      paragraph(["また ", math(String.raw`I`), " と ", math(String.raw`\varepsilon`), " は実行列なので、", ref("def_epsilon_projectors"), " の ", math(String.raw`P^{(\pm)}`), " も実行列である。したがって ", math(String.raw`x\in\mathbb R^{2^{M_{\mathrm{col}}}}`), " から ", math(String.raw`x_\pm=P^{(\pm)}x\in\mathbb R^{2^{M_{\mathrm{col}}}}`), " であり、先に示したセクターへの所属と合わせて ", math(String.raw`x_\pm\in\mathcal F^{(\pm)}\cap\mathbb R^{2^{M_{\mathrm{col}}}}`), " である。"]),
      paragraph(["ここで任意の ", math(String.raw`u_+\in\mathcal F^{(+)}\cap\mathbb R^{2^{M_{\mathrm{col}}}}`), " と ", math(String.raw`u_-\in\mathcal F^{(-)}\cap\mathbb R^{2^{M_{\mathrm{col}}}}`), " を取る。", ref("epsilon_projector_properties"), " (1)(3) より ", math(String.raw`P^{(+)}u_+=u_+`), "、", math(String.raw`P^{(-)}u_-=u_-`), " だから、"]),
      displayMath(String.raw`\begin{aligned}
u_+^\top u_-
&= \left(P^{(+)}u_+\right)^\top\left(P^{(-)}u_-\right)
   \quad (\because P^{(+)}u_+=u_+,\ P^{(-)}u_-=u_-) \\
&= u_+^\top \left(P^{(+)}\right)^\top P^{(-)}u_-
   \quad (\because \text{転置の積の法則を一回適用する}) \\
&= u_+^\top P^{(+)}P^{(-)}u_-
   \quad (\because (P^{(+)})^\top=P^{(+)}) \\
&= u_+^\top\,0\,u_-
   \quad (\because \blkref{epsilon_projector_properties}\ \text{(1) の }P^{(+)}P^{(-)}=0) \\
&= 0
   \quad (\because \text{零行列の作用})
\end{aligned}`),
      paragraph(["したがって二つのセクターの実ベクトルは直交する。特に ", math(String.raw`x_+^\top x_-=x_-^\top x_+=0`), " である。", ref("def_matrix_norm"), " の数ベクトルのノルムを使うと、"]),
      displayMath(String.raw`\begin{aligned}
\|x\|^2
&=x^\top x
  \quad (\because \blkref{def_matrix_norm}\ \text{の数ベクトルのノルムの定義})\\
&=(x_++x_-)^\top(x_++x_-)
  \quad (\because x=x_++x_-\ \text{を左右へ代入})\\
&=x_+^\top x_+ + x_+^\top x_- + x_-^\top x_+ + x_-^\top x_-
  \quad (\because \text{転置と内積の分配則})\\
&=x_+^\top x_+ + x_-^\top x_-
  \quad (\because x_+^\top x_-=x_-^\top x_+=0)\\
&=\|x_+\|^2+\|x_-\|^2
  \quad (\because \text{ノルムの定義}).
\end{aligned}`),
      paragraph(["また ", ref("epsilon_commutes_with_W"), " より ", math(String.raw`Wx_\pm \in \mathcal{F}^{(\pm)}`), " である。また ", ref("W_is_real_symmetric_positive_definite"), " より ", math(String.raw`W`), " は実行列なので、", math(String.raw`Wx_\pm\in\mathbb R^{2^{M_{\mathrm{col}}}}`), " でもある。したがって、上で示した実ベクトル間の直交性から交叉項が消えて"]),
      displayMath(String.raw`\begin{aligned}
x^\top Wx
&=(x_++x_-)^\top W(x_++x_-)
  \quad (\because x=x_++x_- \text{ を左右へ代入する})\\
&=(x_++x_-)^\top(Wx_++Wx_-)
  \quad (\because \text{行列の作用の分配則})\\
&=x_+^\top Wx_+ + x_+^\top Wx_- + x_-^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{転置と内積の分配則})\\
&=x_+^\top Wx_+ + 0 + 0 + x_-^\top Wx_-
  \quad (\because x_+,Wx_+\in\mathcal F^{(+)}\text{ と }x_-,Wx_-\in\mathcal F^{(-)}\text{ の直交性})\\
&=x_+^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{零は加法単位元})
\end{aligned}`),
      paragraph([math(String.raw`c_\pm := c_\pm(M_{\mathrm{col}})`), " と略記する。任意の ", math(String.raw`y\in\mathcal F^{(\pm)}\cap\mathbb R^{2^{M_{\mathrm{col}}}}`), " について、", math(String.raw`y=0`), " なら ", math(String.raw`y^\top Wy=c_\pm\|y\|^2=0`), " である。", math(String.raw`y\neq0`), " なら ", ref("matrix_norm_triangle_inequality"), " (1) より ", math(String.raw`\|y\|>0`), " であり、", math(String.raw`\widehat y:=y/\|y\|`), " と定める。", ref("def_eigenspaces_of_epsilon"), " と ", ref("matrix_norm_triangle_inequality"), " (2) より、"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\widehat y
&=\varepsilon\left(\frac{1}{\|y\|}y\right)
  \quad (\because \widehat y\ \text{の定義})\\
&=\frac{1}{\|y\|}\,\varepsilon y
  \quad (\because \text{行列の作用は実数倍を保つ})\\
&=\frac{1}{\|y\|}(\pm y)
  \quad (\because y\in\mathcal F^{(\pm)}\ \text{と}\ \blkref{def_eigenspaces_of_epsilon})\\
&=\pm\widehat y
  \quad (\because \widehat y\ \text{の定義}),\\[1mm]
\|\widehat y\|
&=\left\|\frac{1}{\|y\|}y\right\|
  \quad (\because \widehat y\ \text{の定義})\\
&=\left|\frac{1}{\|y\|}\right|\,\|y\|
  \quad (\because \blkref{matrix_norm_triangle_inequality}\ \text{(2)})\\
&=\frac{1}{\|y\|}\,\|y\|
  \quad (\because \|y\|>0\ \text{なので }1/\|y\|>0)\\
&=1
  \quad (\because \|y\|>0).
\end{aligned}`),
      paragraph([math(String.raw`\|y\|>0`), " だから ", math(String.raw`1/\|y\|\in\mathbb R`), " である。また ", math(String.raw`y\in\mathbb R^{2^{M_{\mathrm{col}}}}`), " であり、実数ベクトル全体は実数倍について閉じている。よって ", math(String.raw`\widehat y=(1/\|y\|)y\in\mathbb R^{2^{M_{\mathrm{col}}}}`), " である。上の計算と合わせると、", math(String.raw`\widehat y`), " は同じセクターの単位ベクトルである。したがって ", ref("def_sector_rayleigh_sup"), " より"]),
      displayMath(String.raw`\begin{aligned}
\frac{1}{\|y\|^2}\,y^\top Wy
&=\left(\frac{1}{\|y\|}\right)^2 y^\top Wy
  \quad (\because (1/a)^2=1/a^2)\\
&=\frac{1}{\|y\|}\,y^\top\left(\frac{1}{\|y\|}Wy\right)
  \quad (\because \text{実数倍の結合則})\\
&=\frac{1}{\|y\|}\,y^\top W\left(\frac{1}{\|y\|}y\right)
  \quad (\because \text{行列の作用は実数倍を保つ})\\
&=\left(\frac{1}{\|y\|}y\right)^\top W\left(\frac{1}{\|y\|}y\right)
  \quad (\because \text{転置は実数倍を保つ})\\
&=\widehat y^\top W\widehat y
  \quad (\because \widehat y=(1/\|y\|)y\ \text{を左右へ代入})\\
&\leq c_\pm
  \quad (\because \|\widehat y\|=1\ \text{なのでセクター上限の定義を適用})\\
y^\top Wy
&\leq c_\pm\|y\|^2
  \quad (\because \|y\|^2>0\ \text{を両辺へ掛ける}).
\end{aligned}`),
      paragraph(["零の場合と非零の場合を合わせると、各符号について ", math(String.raw`y^\top Wy\leq c_\pm\|y\|^2`), " が任意のセクターベクトルで成り立つ。これを ", math(String.raw`y=x_\pm`), " へ適用する。", math(String.raw`\|x\| = 1`), " のとき"]),
      displayMath(String.raw`\begin{aligned}
x^\top Wx
&= x_+^\top Wx_+ + x_-^\top Wx_-
  \quad (\because \text{上の交叉項の消去})\\
&\leq c_+\|x_+\|^2 + x_-^\top Wx_-
  \quad (\because x_+^\top Wx_+ \leq c_+\|x_+\|^2 \text{ を第一項へ適用する})\\
&\leq c_+\|x_+\|^2 + c_-\|x_-\|^2
  \quad (\because x_-^\top Wx_- \leq c_-\|x_-\|^2 \text{ を第二項へ適用する})\\
&\leq \max(c_+,c_-)\|x_+\|^2 + \max(c_+,c_-)\|x_-\|^2
  \quad (\because c_\pm \leq \max(c_+,c_-) \text{ と } \|x_\pm\|^2 \geq 0 \text{ の積の単調性})\\
&= \max(c_+,c_-)\left(\|x_+\|^2+\|x_-\|^2\right)
  \quad (\because \text{分配則})\\
&= \max(c_+,c_-)\,\|x\|^2
  \quad (\because \|x\|^2 = \|x_+\|^2 + \|x_-\|^2 \text{ を上で示した})\\
&= \max(c_+,c_-)
  \quad (\because \|x\| = 1)
\end{aligned}`),
      paragraph(["上限を取って ", math(String.raw`c(M_{\mathrm{col}}) \leq \max(c_+,c_-)`), "。逆に、", math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルは ", math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルでもあるので ", math(String.raw`\mathcal{R}_\pm \subseteq \mathcal{R}`), " である（空でないことと上に有界であることは ", ref("def_sector_rayleigh_sup"), "）。したがって"]),
      displayMath(String.raw`\begin{aligned}
c_\pm
&= \sup \mathcal{R}_\pm
  \quad (\because c_\pm \text{ の定義})\\
&\leq \sup \mathcal{R}
  \quad (\because \mathcal{R}_\pm \subseteq \mathcal{R} \text{ と上限の単調性})\\
&= c(M_{\mathrm{col}})
  \quad (\because c(M_{\mathrm{col}}) \text{ の定義})
\end{aligned}`),
      paragraph(["両方の符号について成り立つので、"]),
      displayMath(String.raw`\begin{aligned}
\max(c_+,c_-)
&\leq c(M_{\mathrm{col}})
  \quad (\because c_+\leq c(M_{\mathrm{col}}) \text{ かつ } c_-\leq c(M_{\mathrm{col}}))\\
&\leq \max(c_+,c_-)
  \quad (\because \text{上で示したレイリー商の上界})
\end{aligned}`),
      paragraph(["よって等号が成り立つ。"]),
    ],
  },
  {
    id: "note_closing_010_theorem_onsager_exact_solution_minus_sector_sector_000_remark_overview",
    targets: ["onsager_exact_solution"],
    title: { text: "この章の目的" },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 2 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の注意ブロック sector_000_remark_overview。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph(["〔sector_decomposition_of_rayleigh_sup〕", " (3) により ", math(String.raw`c(M_{\mathrm{col}}) = \max\left(c_+(M_{\mathrm{col}}), c_-(M_{\mathrm{col}})\right)`), " である。", ref("onsager_exact_solution"), " はこの ", math(String.raw`\max`), " の値を決めずに、", math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " という**粗い挟み撃ち**で自由エネルギーを出した（係数 ", math(String.raw`2`), " は ", math(String.raw`(\log 2)/M_{\mathrm{col}} \to 0`), " で消えるので表式には影響しない）。"]),
      paragraph(["この章では、その ", math(String.raw`\max`), " がどちらから来るかを確定させる："]),
      displayMath(String.raw`c_-(M_{\mathrm{col}}) \ \leq\ c_+(M_{\mathrm{col}}),
\qquad \text{したがって}\qquad
c(M_{\mathrm{col}}) = c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
      paragraph(["**自由エネルギーの表式そのものにこの結果は不要である。** それでもこれを示すのは、", math(String.raw`W`), " の最大固有値が ", math(String.raw`\varepsilon`), " の固有値 ", math(String.raw`+1`), " のセクター（偶セクター）から来る、という描像を本文で確定させるためである。"]),
      paragraph(["筋は短い。", math(String.raw`\varepsilon`), " は標準基底のベクトルを別の標準基底のベクトルへ写す ", math(String.raw`0/1`), " の**置換行列**である（", "〔epsilon_is_sign_flip_permutation〕", "）。そこで奇セクターの実ベクトル ", math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " に対し、成分ごとに絶対値を取ったベクトル ", math(String.raw`u`), "（", math(String.raw`u_k := |x_k|`), "）を作ると、符号がそろって ", math(String.raw`u`), " は**偶セクターに移る**（", "〔abs_vector_moves_to_even_sector〕", "）。しかも ", math(String.raw`W`), " の成分がすべて正である（", ref("W_has_positive_entries"), "。この議論で実際に効くのは ", math(String.raw`W_{kl} \geq 0`), " という**非負性だけ**である）ため、絶対値を取ると二次形式の値は**減らない**。よって ", math(String.raw`c_+(M_{\mathrm{col}}) \geq u^\top Wu \geq x^\top Wx`), " となり、", math(String.raw`x`), " について上限を取れば ", math(String.raw`c_+(M_{\mathrm{col}}) \geq c_-(M_{\mathrm{col}})`), " を得る（", "〔c_minus_le_c_plus〕", "）。"]),
      paragraph(["この章で使う道具は、実行列の成分計算、有限個の実数の和・積・絶対値と三角不等式、", "および実数の上限だけである。**実数解析（積分・連続極限）へは移行しない**（", ref("remark_real_analysis_escape_point"), " の移行点は ", ref("onsager_exact_solution"), " の最後の等号だけのままである）。"]),
      paragraph(["なお、示すのは ", math(String.raw`c_-(M_{\mathrm{col}}) \leq c_+(M_{\mathrm{col}})`), " という**不等号だけ**であり、", math(String.raw`c_-(M_{\mathrm{col}})`), " の値そのものには立ち入らない。"]),
    ],
  },
  {
    id: "note_maxeig_claim_epsilon_is_real_symmetric_minus_sector_sector_001_claim_epsilon_is_permutation",
    targets: ["epsilon_is_real_symmetric"],
    title: { tex: String.raw`\varepsilon \text{ は不動点をもたない対合の置換行列}` },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 3 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の主張ブロック sector_001_claim_epsilon_is_permutation。labels: epsilon_is_sign_flip_permutation。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とし、", ref("def_config_basis_iso"), " の ", math(String.raw`\iota`), " による番号付け（", ref("config_numbering_equals_kronecker_numbering"), "）のもとで ", math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`), " の標準基底を ", math(String.raw`e_1,\dots,e_{2^{M_{\mathrm{col}}}}`), " とする。", math(String.raw`k \in \{1,\dots,2^{M_{\mathrm{col}}}\}`), " に対応するスピン配置を ", math(String.raw`s_k \in \mathfrak{M}`), "（", ref("def_row_configurations"), " の ", math(String.raw`\mathfrak{M} = \mathrm{Map}(\{1,\dots,M_{\mathrm{col}}\},\{-1,1\})`), "。すなわち ", math(String.raw`e_k = f_{\iota(s_k)}`), "）と書き、写像 ", math(String.raw`\pi : \{1,\dots,2^{M_{\mathrm{col}}}\} \to \{1,\dots,2^{M_{\mathrm{col}}}\}`), " を"]),
      displayMath(String.raw`\pi(k) := \left(\text{スピン配置 } -s_k \text{ に対応する番号}\right),
\qquad (-s_k)(m) := -\,s_k(m) \quad (m \in \{1,\dots,M_{\mathrm{col}}\})`),
      paragraph(["で定める。", ref("def_transfer_matrix_symbols"), " の ", math(String.raw`\varepsilon = \sigma_1^x\cdots\sigma_{M_{\mathrm{col}}}^x`), " について次が成り立つ。"]),
      list([[math(String.raw`\text{(1)}\quad \varepsilon\,e_k = e_{\pi(k)}
\qquad (k \in \{1,\dots,2^{M_{\mathrm{col}}}\})`), "。とくに ", math(String.raw`\varepsilon`), " の成分は ", math(String.raw`\varepsilon_{l,k} = \begin{cases}1 & (l = \pi(k)) \\ 0 & (l \neq \pi(k))\end{cases}`), " であり、**", math(String.raw`\varepsilon`), " は成分がすべて ", math(String.raw`0`), " または ", math(String.raw`1`), " の置換行列**である（各行・各列にちょうど 1 個の ", math(String.raw`1`), " がある）。"], [math(String.raw`\text{(2)}\quad \pi(\pi(k)) = k, \qquad \pi(k) \neq k
\qquad (k \in \{1,\dots,2^{M_{\mathrm{col}}}\})`), "（", math(String.raw`\pi`), " は不動点をもたない対合）。"], [math(String.raw`\text{(3)}\quad \left(\varepsilon x\right)_k = x_{\pi(k)}
\qquad \left(x \in \mathbb{C}^{2^{M_{\mathrm{col}}}},\ k \in \{1,\dots,2^{M_{\mathrm{col}}}\}\right)`)], [math(String.raw`\text{(4)}\quad x_0 := \frac{1}{\sqrt{2}}\left(e_1 - e_{\pi(1)}\right)
\ \in\ \mathcal{F}^{(-)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}, \qquad \|x_0\| = 1`), "（", ref("def_eigenspaces_of_epsilon"), " の ", math(String.raw`\mathcal{F}^{(-)}`), "）。**とくに ", math(String.raw`\mathcal{F}^{(-)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " は単位ベクトルを含む。**"]]),
      paragraph(["証明."]),
      paragraph(["(1) ", ref("trace_of_epsilon_V_plus"), " の証明 Step 3 の (b) で ", math(String.raw`\varepsilon f_{\iota(s)} = f_{\iota(-s)}`), "（", math(String.raw`s \in \mathfrak{M}`), "）が示されている。", math(String.raw`e_k = f_{\iota(s_k)}`), " と ", math(String.raw`\pi`), " の定義より ", math(String.raw`f_{\iota(-s_k)} = e_{\pi(k)}`), " なので ", math(String.raw`\varepsilon e_k = e_{\pi(k)}`), " である。"]),
      paragraph([math(String.raw`\varepsilon`), " の第 ", math(String.raw`k`), " 列は ", math(String.raw`\varepsilon e_k`), " そのものだから、成分は ", math(String.raw`\varepsilon_{l,k} = \delta_{l,\pi(k)}`), "（", math(String.raw`l = \pi(k)`), " のとき ", math(String.raw`1`), "、そうでなければ ", math(String.raw`0`), "）である。よって各列にちょうど 1 個の ", math(String.raw`1`), " がある。", math(String.raw`s \mapsto -s`), " は ", math(String.raw`\mathfrak{M}`), " からそれ自身への全単射（(2) で示す ", math(String.raw`\pi\circ\pi = \mathrm{id}`), " が逆写像を与える）なので ", math(String.raw`\pi`), " も全単射であり、各行にもちょうど 1 個の ", math(String.raw`1`), " がある。"]),
      paragraph(["(2) ", math(String.raw`-(-s_k) = s_k`), " なので、", math(String.raw`\pi`), " の定義から ", math(String.raw`\pi(\pi(k))`), " は ", math(String.raw`s_k`), " に対応する番号、すなわち ", math(String.raw`k`), " である。また ", math(String.raw`s_k(1) \in \{-1,1\}`), " より ", math(String.raw`-s_k(1) \neq s_k(1)`), " なので ", math(String.raw`-s_k \neq s_k`), "、番号の対応は全単射だから ", math(String.raw`\pi(k) \neq k`), "。"]),
      paragraph(["(3) 行列とベクトルの積の定義に (1) の成分表示を入れる。"]),
      displayMath(String.raw`\begin{aligned}
\left(\varepsilon x\right)_k
&= \sum_{l=1}^{2^{M_{\mathrm{col}}}}\varepsilon_{k,l}\,x_l
&& (\because \text{行列とベクトルの積の定義}) \\
&= \sum_{l=1}^{2^{M_{\mathrm{col}}}}\delta_{k,\pi(l)}\,x_l
&& (\because \text{(1) の成分表示}) \\
&= x_{\pi^{-1}(k)}
&& (\because \pi \text{ は全単射なので } \pi(l) = k \text{ となる } l
   \text{ がちょうど 1 つ}) \\
&= x_{\pi(k)}
&& (\because \text{(2) より } \pi\circ\pi = \mathrm{id} \text{、すなわち }
   \pi^{-1} = \pi)
\end{aligned}`),
      paragraph(["(4) (2) より ", math(String.raw`\pi(1) \neq 1`), " なので ", math(String.raw`e_1`), " と ", math(String.raw`e_{\pi(1)}`), " は相異なる標準基底ベクトルであり、", math(String.raw`\|x_0\|^2 = \tfrac12\left(1 + 1\right) = 1`), "。成分は実数なので ", math(String.raw`x_0 \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`), "。さらに"]),
      displayMath(String.raw`\begin{aligned}
\varepsilon\,x_0
&= \frac{1}{\sqrt{2}}\left(\varepsilon e_1 - \varepsilon e_{\pi(1)}\right)
&& (\because \text{行列の積の線型性}) \\
&= \frac{1}{\sqrt{2}}\left(e_{\pi(1)} - e_{\pi(\pi(1))}\right)
&& (\because \text{(1) を 2 箇所へ同時適用}) \\
&= \frac{1}{\sqrt{2}}\left(e_{\pi(1)} - e_{1}\right)
&& (\because \text{(2) の } \pi(\pi(1)) = 1) \\
&= -\,x_0
&& (\because x_0 \text{ の定義と実数の符号の分配})
\end{aligned}`),
      paragraph(["なので ", ref("def_eigenspaces_of_epsilon"), " より ", math(String.raw`x_0 \in \mathcal{F}^{(-)}`), "。"]),
    ],
  },
  {
    id: "note_closing_010_theorem_onsager_exact_solution_minus_sector_sector_002_claim_abs_vector_moves_to_even_sector",
    targets: ["onsager_exact_solution"],
    title: { tex: String.raw`x \in \mathcal{F}^{(-)} \Longrightarrow u := \left(|x_k|\right)_k
\in \mathcal{F}^{(+)}, \quad u^\top Wu \geq x^\top Wx` },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 4 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の主張ブロック sector_002_claim_abs_vector_moves_to_even_sector。labels: abs_vector_moves_to_even_sector。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), "、", math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とし、", ref("def_symmetrized_transfer_matrix"), " の ", math(String.raw`W`), " を考える（", ref("W_is_real_symmetric_positive_definite"), " より ", math(String.raw`W`), " は実行列とみなせる）。", math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), "（", ref("def_eigenspaces_of_epsilon"), "）に対し、"]),
      displayMath(String.raw`u \in \mathbb{R}^{2^{M_{\mathrm{col}}}}, \qquad
u_k := \left|x_k\right| \quad \left(k \in \{1,\dots,2^{M_{\mathrm{col}}}\}\right)`),
      paragraph(["と定める。このとき次が成り立つ。"]),
      list([[math(String.raw`\text{(1)}\quad \varepsilon\,u = u`), "、すなわち ", math(String.raw`u \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`)], [math(String.raw`\text{(2)}\quad \|u\| = \|x\|`)], [math(String.raw`\text{(3)}\quad u^\top W u \ \geq\ \left|x^\top Wx\right| \ \geq\ x^\top W x`)]]),
      paragraph(["証明."]),
      paragraph(["(1) ", math(String.raw`x \in \mathcal{F}^{(-)}`), " なので ", ref("def_eigenspaces_of_epsilon"), " より ", math(String.raw`\varepsilon x = -x`), " である。", "〔epsilon_is_sign_flip_permutation〕", " (3) をこの等式の第 ", math(String.raw`k`), " 成分に適用すると"]),
      displayMath(String.raw`\begin{aligned}
x_{\pi(k)}
&= \left(\varepsilon x\right)_k
&& (\because \text{epsilon\_is\_sign\_flip\_permutation (3)}) \\
&= \left(-x\right)_k
&& (\because \varepsilon x = -x) \\
&= -\,x_k
\qquad \left(k \in \{1,\dots,2^{M_{\mathrm{col}}}\}\right)
&& (\because \text{スカラー倍の成分表示})
\end{aligned}`),
      paragraph(["を得る。同じ ", "〔epsilon_is_sign_flip_permutation〕", " (3) を ", math(String.raw`u`), " に適用して"]),
      displayMath(String.raw`\begin{aligned}
\left(\varepsilon u\right)_k
&= u_{\pi(k)}
&& (\because \text{epsilon\_is\_sign\_flip\_permutation (3)}) \\
&= \left|x_{\pi(k)}\right|
&& (\because u \text{ の定義}) \\
&= \left|-x_k\right|
&& (\because \text{直前の } x_{\pi(k)} = -x_k) \\
&= \left|x_k\right|
&& (\because \text{実数の絶対値は符号を落とす}) \\
&= u_k
&& (\because u \text{ の定義})
\end{aligned}`),
      paragraph(["すべての ", math(String.raw`k`), " で成分が一致するので ", math(String.raw`\varepsilon u = u`), " であり、", ref("def_eigenspaces_of_epsilon"), " より ", math(String.raw`u \in \mathcal{F}^{(+)}`), "。成分 ", math(String.raw`|x_k|`), " は実数なので ", math(String.raw`u \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`), "。"]),
      paragraph(["(2) ノルムの定義から成分ごとに計算する。"]),
      displayMath(String.raw`\begin{aligned}
\|u\|^2
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}u_k^2
&& (\because \text{ノルムの定義}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}\left|x_k\right|^2
&& (\because u \text{ の定義}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}x_k^2
&& \left(\because |a|^2 = a^2 \ (a \in \mathbb{R})\right) \\
&= \|x\|^2
&& (\because \text{ノルムの定義})
\end{aligned}`),
      paragraph([math(String.raw`\|u\| \geq 0`), "、", math(String.raw`\|x\| \geq 0`), " なので平方根を取って ", math(String.raw`\|u\| = \|x\|`), "。"]),
      paragraph(["(3) ", ref("W_has_positive_entries"), " より ", math(String.raw`W_{kl} > 0`), "（すべての ", math(String.raw`k, l`), "）であり、とくに ", math(String.raw`W_{kl} \geq 0`), " である。以下で使うのはこの**非負性だけ**で、", math(String.raw`W_{kl} > 0`), " が真に必要な箇所はない（", math(String.raw`W_{kl} \geq 0`), " のとき ", math(String.raw`|x_kx_lW_{kl}| = |x_k||x_l|W_{kl}`), " が成り立つ）。二次形式を成分で書き下す。"]),
      displayMath(String.raw`\begin{aligned}
u^\top W u
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}u_k\,u_l\,W_{kl}
&& (\because \text{行列とベクトルの積と内積の成分表示}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}\left|x_k\right|\left|x_l\right|W_{kl}
&& (\because u \text{ の定義}) \\
&= \sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}\left|x_k\,x_l\,W_{kl}\right|
&& \left(\because W_{kl} \geq 0
   \text{ なので } |x_kx_lW_{kl}| = |x_k||x_l|W_{kl}\right) \\
&\geq \left|\sum_{k=1}^{2^{M_{\mathrm{col}}}}\sum_{l=1}^{2^{M_{\mathrm{col}}}}x_k\,x_l\,W_{kl}\right|
&& (\because \text{有限個の実数についての三角不等式}) \\
&= \left|x^\top W x\right|
&& (\because \text{行列とベクトルの積と内積の成分表示}) \\
&\geq x^\top W x
&& \left(\because |a| \geq a \ (a \in \mathbb{R})\right)
\end{aligned}`),
    ],
  },
  {
    id: "note_maxeig_claim_c_plus_le_c_minus_sector_sector_003_theorem_c_minus_le_c_plus",
    targets: ["c_plus_le_c"],
    title: { tex: String.raw`c_-(M_{\mathrm{col}}) \leq c_+(M_{\mathrm{col}})` },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 5 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の定理ブロック sector_003_theorem_c_minus_le_c_plus。labels: c_minus_le_c_plus。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), "、", math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とする。", ref("def_sector_rayleigh_sup"), " の"]),
      displayMath(String.raw`c_\pm(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\}`),
      paragraph(["について ", math(String.raw`c_-(M_{\mathrm{col}})`), " と ", math(String.raw`c_+(M_{\mathrm{col}})`), " はともに実数として定まり（右辺の集合は空でなく上に有界）、"]),
      displayMath(String.raw`c_-(M_{\mathrm{col}}) \ \leq\ c_+(M_{\mathrm{col}})`),
      paragraph(["が成り立つ。"]),
      paragraph(["証明."]),
      paragraph(["Step 1（上限が定まること）。", math(String.raw`\mathcal{R}_\pm := \left\{x^\top Wx \mid
x \in \mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1\right\}`), " とおく。", "〔epsilon_is_sign_flip_permutation〕", " (4) の ", math(String.raw`x_0`), " により ", math(String.raw`\mathcal{R}_-\neq\emptyset`), " である。", math(String.raw`\mathcal{R}_+`), " については ", math(String.raw`v := e_1 + e_{\pi(1)}`), " を取る。第 ", math(String.raw`1`), " 成分が ", math(String.raw`1`), " 以上なので ", math(String.raw`v \neq 0`), " であり、", "〔epsilon_is_sign_flip_permutation〕", " (1) と ", math(String.raw`\pi(\pi(1)) = 1`), "（同 (2)）から ", math(String.raw`\varepsilon v = e_{\pi(1)} + e_1 = v`), " なので ", math(String.raw`y_0 := v/\|v\|`), " は ", math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルであり、", math(String.raw`\mathcal{R}_+\neq\emptyset`), " である。"]),
      paragraph(["（", math(String.raw`\mathcal{R}_+\neq\emptyset`), " に使ったのは ", "〔epsilon_is_sign_flip_permutation〕", " (2) のうち ", math(String.raw`\pi\circ\pi = \mathrm{id}`), " の部分だけで、", math(String.raw`\pi(k) \neq k`), "（不動点をもたないこと）は使っていない。", math(String.raw`\pi(1) = 1`), " であれば ", math(String.raw`v = 2e_1`), " となるだけで、上の議論はそのまま通る。不動点をもたないことが本質的に効くのは ", math(String.raw`\mathcal{R}_-\neq\emptyset`), " の側、すなわち同 (4) の ", math(String.raw`x_0 = \tfrac{1}{\sqrt2}(e_1 - e_{\pi(1)})`), " が非零であるところである。）"]),
      paragraph(["また ", math(String.raw`\mathcal{F}^{(\pm)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルは ", math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルでもあるから ", math(String.raw`\mathcal{R}_\pm \subseteq \mathcal{R}`), "（", ref("def_rayleigh_sup"), " の ", math(String.raw`\mathcal{R}`), "）であり、同じところで示されている ", math(String.raw`\mathcal{R}`), " の上界 ", math(String.raw`\|W\|`), " が ", math(String.raw`\mathcal{R}_\pm`), " の上界にもなる。空でなく上に有界な実数集合は上限をもつので、", math(String.raw`c_\pm(M_{\mathrm{col}}) \in \mathbb{R}`), " が定まる。"]),
      paragraph(["Step 2（各点での比較）。", math(String.raw`x \in \mathcal{F}^{(-)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), "、", math(String.raw`\|x\| = 1`), " を任意に取り、", "〔abs_vector_moves_to_even_sector〕", " の ", math(String.raw`u`), "（", math(String.raw`u_k = |x_k|`), "）を対応させる。"]),
      displayMath(String.raw`\begin{aligned}
x^\top W x
&\leq u^\top W u
&& (\because \text{abs\_vector\_moves\_to\_even\_sector (3)}) \\
&\leq c_+(M_{\mathrm{col}})
&& \left(\because \text{abs\_vector\_moves\_to\_even\_sector (1)(2) より }
   u \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|u\| = \|x\| = 1
   \text{ なので } u^\top Wu \in \mathcal{R}_+\right)
\end{aligned}`),
      paragraph(["Step 3（上限を取る）。Step 2 より ", math(String.raw`c_+(M_{\mathrm{col}})`), " は ", math(String.raw`\mathcal{R}_-`), " の上界である。", math(String.raw`c_-(M_{\mathrm{col}}) = \sup\mathcal{R}_-`), " は ", math(String.raw`\mathcal{R}_-`), " の上界のうち最小のものだから ", math(String.raw`c_-(M_{\mathrm{col}}) \leq c_+(M_{\mathrm{col}})`), "。"]),
      paragraph(["（Step 2・Step 3 が使っているのは ", "〔epsilon_is_sign_flip_permutation〕", " (3) の成分表示（", "〔abs_vector_moves_to_even_sector〕", " を通して）と ", math(String.raw`W`), " の成分の非負性だけである。", math(String.raw`\pi`), " が不動点をもたないことは**不等式の証明そのものには効いていない**。それが要るのは Step 1 で ", math(String.raw`\mathcal{R}_-`), " が空でない、すなわち ", math(String.raw`c_-(M_{\mathrm{col}})`), " が上限として意味をもつことを言う箇所だけである。）"]),
    ],
  },
  {
    id: "note_closing_009_theorem_c_plus_equals_Lambda_half_minus_sector_sector_004_theorem_c_equals_c_plus",
    targets: ["c_plus_equals_Lambda_half_integer"],
    title: { tex: String.raw`c(M_{\mathrm{col}}) = c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}` },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 6 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の定理ブロック sector_004_theorem_c_equals_c_plus。labels: c_equals_c_plus。以下は本文にあったときの内容のまま。）"]),
      paragraph([math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`), "、", math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とする。", ref("def_rayleigh_sup"), " の ", math(String.raw`c(M_{\mathrm{col}})`), "、", "〔sector_decomposition_of_rayleigh_sup〕", " の ", math(String.raw`c_\pm(M_{\mathrm{col}})`), "、", ref("onsager_free_energy_expression"), " の ", math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " について"]),
      displayMath(String.raw`c(M_{\mathrm{col}}) = c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}
= \left(2\sinh 2K_2\right)^{M_{\mathrm{col}}/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)`),
      paragraph(["が成り立つ（", math(String.raw`\tilde\theta_\mu`), " は ", ref("antiperiodic_exp_sum"), " の半整数運動量、", math(String.raw`\gamma`), " は ", ref("def_gamma_theta_tilde_mu"), "）。**上限 ", math(String.raw`c(M_{\mathrm{col}})`), " は達成され、しかもそれを達成する単位ベクトルは偶セクター ", math(String.raw`\mathcal{F}^{(+)}`), " の中に取れる。**"]),
      paragraph(["証明."]),
      paragraph(["Step 1（", math(String.raw`c(M_{\mathrm{col}}) = c_+(M_{\mathrm{col}})`), "）。", "〔sector_decomposition_of_rayleigh_sup〕", " (3) と ", "〔c_minus_le_c_plus〕", " より"]),
      displayMath(String.raw`\begin{aligned}
c(M_{\mathrm{col}})
&= \max\left(c_+(M_{\mathrm{col}}),\, c_-(M_{\mathrm{col}})\right)
&&(\because \text{sector\_decomposition\_of\_rayleigh\_sup (3)}) \\
&= c_+(M_{\mathrm{col}})
&&(\because \text{c\_minus\_le\_c\_plus の } c_-(M_{\mathrm{col}}) \leq c_+(M_{\mathrm{col}}))
\end{aligned}`),
      paragraph(["Step 2（値の代入）。", ref("c_plus_equals_Lambda_half_integer"), " より ", math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " なので、Step 1 と合わせて ", math(String.raw`c(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`), "。右辺の閉じた表示は ", ref("onsager_free_energy_expression"), " の ", math(String.raw`\delta = \tfrac12`), " の場合である。"]),
      paragraph(["Step 3（達成されること）。", ref("c_plus_equals_Lambda_half_integer"), " の証明 Step 3 で、", math(String.raw`x_0 \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`), "、", math(String.raw`\|x_0\| = 1`), " かつ ", math(String.raw`x_0^\top Wx_0 = c_+(M_{\mathrm{col}})`), " を満たす ", math(String.raw`x_0`), " が構成されている。この ", math(String.raw`x_0`), " は ", math(String.raw`\mathbb{R}^{2^{M_{\mathrm{col}}}}`), " の単位ベクトルでもあるから、Step 1 より ", math(String.raw`x_0^\top Wx_0 = c(M_{\mathrm{col}})`), " であり、", ref("def_rayleigh_sup"), " の上限は ", math(String.raw`x_0`), " で達成される。"]),
    ],
  },
  {
    id: "note_closing_010_theorem_onsager_exact_solution_minus_sector_sector_005_remark_sandwich_becomes_equality",
    targets: ["onsager_exact_solution"],
    title: { text: "Onsager の厳密解の証明で使った粗い評価との関係" },
    origin: { path: "structured-latex/content/019_max_eigenvalue_sector.ts", ordinal: 7 },
    body: [
      NOT_ADOPTED,
      paragraph(["（もと content/019_max_eigenvalue_sector.ts の注意ブロック sector_005_remark_sandwich_becomes_equality。labels: なし。以下は本文にあったときの内容のまま。）"]),
      paragraph([ref("onsager_exact_solution"), " の証明 Step 3 は、", ref("W_has_positive_entries"), " から ", math(String.raw`c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " という**粗い上からの評価**を出し、Step 2 の ", math(String.raw`c(M_{\mathrm{col}}) \geq \Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " と合わせて"]),
      displayMath(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \ \leq\ c(M_{\mathrm{col}}) \ \leq\ 2\,\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
      paragraph(["としていた。", "〔c_equals_c_plus〕", " により、この挟み撃ちは**左側の等号**"]),
      displayMath(String.raw`c(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
      paragraph(["へ改善される。すなわち係数 ", math(String.raw`2`), " は不要である。"]),
      paragraph(["**それでも ", ref("onsager_exact_solution"), " の証明はそのままにしてある。** 理由は 2 つある。"]),
      list([["第一に、", ref("onsager_exact_solution"), " は文書順でこの章より**前**にあるので、そこで ", "〔c_equals_c_plus〕", " を引くと「先に読んだ定理が後の章の定理に依存する」という参照の逆流が起きる。", "本文は先頭から順に読めば各段が既出のものだけで正当化される形を保つ。"], ["第二に、自由エネルギーの表式にとって係数 ", math(String.raw`2`), " は無害である。", math(String.raw`\tfrac{1}{M_{\mathrm{col}}}\log`), " を取ると差は ", math(String.raw`(\log 2)/M_{\mathrm{col}}`), " で、", math(String.raw`M_{\mathrm{col}} \to \infty`), " で ", math(String.raw`0`), " に収束する。"]]),
      paragraph(["この章が加えているのは、表式そのものではなく**最大固有値の所在**である：", math(String.raw`W`), " の Rayleigh 商の上限は偶セクター ", math(String.raw`\mathcal{F}^{(+)}`), " の中で達成され、奇セクターはそれを超えない。"]),
      paragraph(["なお、この章は ", math(String.raw`c_-(M_{\mathrm{col}})`), " の**値**については何も述べていない。", math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`), " と対をなす ", math(String.raw`c_-(M_{\mathrm{col}}) = \Lambda^{(0)}_{M_{\mathrm{col}}}`), " は**一般には成り立たない**（", ref("onsager_exact_solution"), " の注記に記録した高温側の反例がある）。奇セクターについては、", math(String.raw`V^{(-)}`), " の最大固有値の固有ベクトルがどちらのセクターに落ちるかを ", ref("max_eigenvector_in_even_sector"), " と同じようには決められない。この章の主張は ", math(String.raw`c_-(M_{\mathrm{col}}) \leq c_+(M_{\mathrm{col}})`), " という**不等号だけ**であり、それには ", math(String.raw`c_-(M_{\mathrm{col}})`), " の値は要らない。"]),
    ],
  },
]);
