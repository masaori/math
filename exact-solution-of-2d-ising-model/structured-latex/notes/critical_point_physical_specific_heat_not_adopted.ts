import { defineNotes, paragraph, math, displayMath, ref } from "../schema.ts";

// 物理の比熱 C と、臨界点の章の d²f/dK² の対応（本文不採用）。文書本体ではない。
//
// **本文には採用しなかった。** 理由: 比熱・絶対温度・Boltzmann 定数・内部エネルギーは本文で定義されない
// 物理の量であり、この対応は数学的主張ではなく物理量との辞書だからである（リポジトリの CLAUDE.md
// 「本文とノートの使い分け」の物理的解釈）。本文の到達点 specific_heat_log_divergence と臨界点の章の
// ゴールの主張は、この対応を使わずに閉じる。もとは臨界点の章の注記 critical_013_remark_physical_specific_heat
// （ラベル remark_physical_specific_heat）で、内容はそのまま運んだ。

export default defineNotes([
  {
    id: "note_critical_012_theorem_specific_heat_log_divergence_physical_specific_heat",
    targets: ["specific_heat_log_divergence"],
    title: { tex: String.raw`\text{物理的な比熱 } C \text{ との対応：} C = k_B K^2 \frac{d^2 f}{dK^2}` },
    origin: { path: "structured-latex/content/020_critical_point.ts", ordinal: 15 },
    body: [
      paragraph([
        "【本文不採用。理由: 比熱などの物理の量は本文で定義されず、この対応は数学的主張ではなく物理量との辞書であるため。",
        "臨界点の章の到達点はこの対応を使わずに閉じる。】",
      ]),
      paragraph(["（もと content/020_critical_point.ts の注記ブロック critical_013_remark_physical_specific_heat。labels: remark_physical_specific_heat。以下は本文にあったときの内容のまま。）"]),
      paragraph([
        ref("specific_heat_log_divergence"),
        " は結合定数 ",
        math(String.raw`K`),
        " についての 2 階微分の発散を述べている。物理でいう比熱は温度についての 2 階微分だが、",
        "両者は次のように比例する。",
      ]),
      paragraph([
        ref("def_partition_function_2d_ising"),
        " の ",
        math(String.raw`Z(K_1,K_2)`),
        " において、等方な場合の結合定数を",
      ]),
      displayMath(
        String.raw`K = \beta \mathcal{J},
\qquad \beta := \frac{1}{k_B T}`,
      ),
      paragraph([
        "と書く（",
        math(String.raw`\mathcal{J}`),
        " は相互作用の強さ、",
        math(String.raw`T`),
        " は絶対温度、",
        math(String.raw`k_B`),
        " は Boltzmann 定数。",
        math(String.raw`\mathcal{J}, k_B, T \in \mathbb{R}_{>0}`),
        "）。1 サイトあたりの内部エネルギー ",
        math(String.raw`u`),
        " と比熱 ",
        math(String.raw`C`),
        " は",
      ]),
      displayMath(
        String.raw`u := -\frac{\partial}{\partial\beta}f(K),
\qquad
C := \frac{\partial u}{\partial T}`,
      ),
      paragraph([
        "で定義される（",
        math(String.raw`f`),
        " は ",
        ref("specific_heat_log_divergence"),
        " の 1 サイトあたりの ",
        math(String.raw`\log Z`),
        " の極限）。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
u
&=-\frac{df}{dK}\frac{dK}{d\beta}
&&\bigl(\because\ u\text{ の定義と合成関数の微分}\bigr)\\
&=-\mathcal{J}\frac{df}{dK}
&&\bigl(\because\ K=\beta\mathcal{J}\bigr),\\
\frac{\partial u}{\partial\beta}
&=-\mathcal{J}\frac{d^2f}{dK^2}\frac{dK}{d\beta}
&&\bigl(\because\ \mathcal{J}\text{ は定数であり合成関数の微分}\bigr)\\
&=-\mathcal{J}^2\frac{d^2f}{dK^2}
&&\bigl(\because\ dK/d\beta=\mathcal{J}\bigr),\\
\frac{d\beta}{dT}
&=-\frac{1}{k_BT^2}
&&\bigl(\because\ \beta=1/(k_BT)\text{ の微分}\bigr)\\
&=-k_B\beta^2
&&\bigl(\because\ \beta=1/(k_BT)\bigr),\\
C
&=\frac{\partial u}{\partial\beta}\frac{d\beta}{dT}
&&\bigl(\because\ C\text{ の定義と合成関数の微分}\bigr)\\
&=\left(-\mathcal{J}^2\frac{d^2f}{dK^2}\right)\left(-k_B\beta^2\right)
&&\bigl(\because\ \text{上の二式}\bigr)\\
&=k_B(\beta\mathcal{J})^2\frac{d^2f}{dK^2}
&&\bigl(\because\ \text{積の交換と結合}\bigr)\\
&=k_BK^2\frac{d^2f}{dK^2}
&&\bigl(\because\ K=\beta\mathcal{J}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "**したがって比熱 ",
        math(String.raw`C`),
        " は ",
        math(String.raw`\dfrac{d^2f}{dK^2}`),
        " の正の定数倍（臨界点の近傍では ",
        math(String.raw`k_BK^2 \to k_BK_c^2 > 0`),
        "）であり、",
        ref("specific_heat_log_divergence"),
        " はそのまま比熱の対数発散",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C
&=k_BK^2\frac{d^2f}{dK^2}
&&\bigl(\because\ \text{上の等式}\bigr)\\
&=k_BK^2\left(\frac{8}{\pi}\log\frac{1}{|K-K_c|}+O\right)
&&\bigl(\because\ \blkref{specific_heat_log_divergence},\ |O|\leq49\bigr)
\end{aligned}`,
      ),
      paragraph([
        "を意味する。**",
        math(String.raw`K = \beta\mathcal{J}`),
        " は ",
        math(String.raw`T`),
        " の狭義単調減少関数なので、",
        math(String.raw`K \to K_c`),
        " と ",
        math(String.raw`T \to T_c := \dfrac{\mathcal{J}}{k_BK_c}`),
        " は同じことである。",
      ]),
      paragraph([
        "なお ",
        math(String.raw`2K_c = \log(1+\sqrt2)`),
        "（",
        ref("kappa_of_K_basic"),
        "）なので ",
        math(String.raw`\dfrac{\mathcal{J}}{k_BT_c} = K_c = \dfrac{\log(1+\sqrt2)}{2}`),
        " であり、これが Onsager の臨界温度である。",
      ]),
    ],
  },
]);
