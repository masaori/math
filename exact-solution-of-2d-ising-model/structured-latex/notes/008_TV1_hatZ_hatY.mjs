import { defineNotes, paragraph, math, displayMath, list, todo, ref } from "../schema.mjs";

// 章「T_{V_1}(hat Z) と hat Z, hat Y の関係」に紐づく参照用ノート。文書本体ではない。

export default defineNotes([
  {
    id: "note_TV1_hatZ_hatY_001_expressions_used_in_proof",
    targets: ["commutator_of_H_and_Z_Y"],
    title: { text: "証明で用いる表式と反交換関係（原文の note）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/000_claim_H1_H2とhatZ_hatYの交換関係.typ",
    body: [
      paragraph(["証明で用いる表式と反交換関係（原文 note）："]),
      displayMath(
        String.raw`\begin{aligned}
H_1^{(\pm)} &= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\left(\hat{Y}_j\hat{Z}_{-j}^{(\pm)}e^{-i\frac{2\pi j}{M}}\right) \\
H_2 &= \frac{1}{M}\sum_{j\in\{1,\dots,M\}}\hat{Z}_{-j}^{(-)}\hat{Y}_j \\
[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+ &= 2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}} \\
[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\mp)}]_+ &= \overbrace{2M\,\delta^M_{\mu+\nu,0}\,I_{(\mathbb{C}^2)^{\otimes M}}}^{[\hat{Z}_\mu^{(\pm)},\hat{Z}_\nu^{(\pm)}]_+}
   + \left(-2\,e^{-i\frac{2\pi}{M}(\mu+\nu)}\cdot 2\,I_{(\mathbb{C}^2)^{\otimes M}}\right) \\
[\hat{Z}_\mu^{(\pm)},\hat{Y}_\nu]_+ &= 0 \\
[\hat{Y}_\mu,\hat{Y}_\nu]_+ &= 2M\,\delta^M_{\mu+\nu,0}\,I \\
\sum_{j=1}^{M} e^{k\cdot\frac{2\pi i j}{M}} &= M\,\delta^M_{(k,0)}
\end{aligned}`,
      ),
    ],
  },
  {
    id: "note_TV1_hatZ_hatY_002_concrete_examples",
    targets: ["nesting_of_commutator_of_H_and_Z"],
    title: { text: "原文 note の具体例（n = 0,1,2,3,4）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/001_claim_交換子のネスト.typ",
    body: [
      paragraph([
        "原文 note の具体例（",
        ref("commutator_of_H_and_Z_Y"),
        " を繰り返し適用）：",
      ]),
      paragraph(["(h1.z) ", math(String.raw`n=0`), "："]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]\dots]}_{0\text{ times}}
= \hat{Z}_\mu^{(\pm)}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]
&= K_1[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot 2\cdot\begin{cases}
\hat{Y}_M & (\mu = -M) \\
e^{-i\frac{2\pi(M+\mu)}{M}}\hat{Y}_{M+\mu} & (-M+1 \leq \mu \leq -1) \\
e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu & (1 \leq \mu \leq M-1) \\
\hat{Y}_M & (\mu = M)
\end{cases} \\
&= K_1\cdot 2\cdot\left(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu\right)
   \quad (\because \hat{Y}\text{ の }M\text{ 周期性})
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, [K_1 H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}]]
&= [K_1 H_1^{(\pm)},\ K_1\cdot 2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)] \\
&= K_1^2\cdot 2\cdot e^{-i\frac{2\pi\mu}{M}}[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1^2\cdot 2\cdot e^{-i\frac{2\pi\mu}{M}}\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^2\cdot 2^2\cdot(-1)^1\cdot e^{\overbrace{-i\frac{2\pi\mu}{M}-i\frac{2\pi(-\mu)}{M}}^{0}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]]}^{n=2}]
&= [K_1 H_1^{(\pm)},\ K_1^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot K_1^2\cdot 2^2\cdot(-1)^1\cdot[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1\cdot K_1^2\cdot 2^2\cdot(-1)^1\cdot\left(2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)\right) \\
&= K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h1.z) ", math(String.raw`n=4`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Z}_\mu^{(\pm)}]]]}^{n=3}]
&= [K_1 H_1^{(\pm)},\ K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu] \\
&= K_1\cdot K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1\cdot K_1^3\cdot 2^3\cdot(-1)^1\cdot e^{-i\frac{2\pi\mu}{M}}\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot e^{-i\frac{2\pi\mu}{M}}e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot e^{\overbrace{-i\frac{2\pi\mu}{M}-i\frac{2\pi(-\mu)}{M}}^{0}}\hat{Z}_\mu^{(\pm)} \\
&= K_1^4\cdot 2^4\cdot(-1)^2\cdot\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=0`), "："]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(\pm)},\dots,[K_1 H_1^{(\pm)},\hat{Y}_\mu]\dots]}_{0\text{ times}}
= \hat{Y}_\mu`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \hat{Y}_\mu]
&= K_1[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},\hat{Y}_\mu]}^{n=1}]
&= [K_1 H_1^{(\pm)},\ K_1\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}] \\
&= K_1^2\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}[H_1^{(\pm)}, \hat{Z}_\mu^{(\pm)}] \\
&= K_1^2\cdot 2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}\left(2\cdot(e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu)\right) \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot e^{-i\frac{2\pi(-\mu)}{M}}e^{-i\frac{2\pi\mu}{M}}\hat{Y}_\mu \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot e^{\overbrace{-i\frac{2\pi(-\mu)}{M}-i\frac{2\pi\mu}{M}}^{0}}\hat{Y}_\mu \\
&= K_1^2\cdot 2^2\cdot(-1)\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h1.y) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_1 H_1^{(\pm)}, \overbrace{[K_1 H_1^{(\pm)},[K_1 H_1^{(\pm)},\hat{Y}_\mu]]}^{n=2}]
&= [K_1 H_1^{(\pm)},\ K_1^2\cdot 2^2\cdot(-1)\cdot\hat{Y}_\mu] \\
&= K_1^3\cdot 2^2\cdot(-1)\cdot[H_1^{(\pm)}, \hat{Y}_\mu] \\
&= K_1^3\cdot 2^2\cdot(-1)\cdot\left(-2\cdot(e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)})\right) \\
&= K_1^3\cdot 2^3\cdot(-1)^2\cdot e^{-i\frac{2\pi(-\mu)}{M}}\hat{Z}_\mu^{(\pm)}
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=1`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \hat{Z}_\mu^{(-)}]
&= K_2^*[H_2, \hat{Z}_\mu^{(-)}] \\
&= K_2^*(-2\cdot\hat{Y}_\mu) \\
&= (K_2^*)^1\cdot 2^1\cdot(-1)^1\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=2`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \overbrace{[K_2^* H_2,\hat{Z}_\mu^{(-)}]}^{n=1}]
&= [K_2^* H_2,\ (K_2^*)^1\cdot 2^1\cdot(-1)^1\cdot\hat{Y}_\mu] \\
&= (K_2^*)^2\cdot 2^1\cdot(-1)^1\cdot[H_2, \hat{Y}_\mu] \\
&= (K_2^*)^2\cdot 2^1\cdot(-1)^1\cdot(2\cdot\hat{Z}_\mu^{(-)}) \\
&= (K_2^*)^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(-)}
\end{aligned}`,
      ),
      paragraph(["(h2.z−) ", math(String.raw`n=3`), "："]),
      displayMath(
        String.raw`\begin{aligned}
[K_2^* H_2, \overbrace{[K_2^* H_2,[K_2^* H_2,\hat{Z}_\mu^{(-)}]]}^{n=2}]
&= [K_2^* H_2,\ (K_2^*)^2\cdot 2^2\cdot(-1)^1\cdot\hat{Z}_\mu^{(-)}] \\
&= (K_2^*)^3\cdot 2^2\cdot(-1)^1\cdot[H_2, \hat{Z}_\mu^{(-)}] \\
&= (K_2^*)^3\cdot 2^2\cdot(-1)^1\cdot(-2\cdot\hat{Y}_\mu) \\
&= (K_2^*)^3\cdot 2^3\cdot(-1)^2\cdot\hat{Y}_\mu
\end{aligned}`,
      ),
    ],
  },
  {
    id: "note_TV1_hatZ_hatY_005_taylor_expansion_of_sinh_cosh",
    targets: ["extract_taylor_coefficient_of_Z_Y"],
    title: { text: "sinh, cosh のテイラー展開（原文の note）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/004_claim_テイラー係数の抽出.typ",
    body: [
      paragraph(["sinh, cosh のテイラー展開（原文 note）："]),
      displayMath(
        String.raw`\sinh x = x + \frac{1}{3!}x^3 + \frac{1}{5!}x^5 + \frac{1}{7!}x^7 + \cdots, \qquad
\cosh x = 1 + \frac{1}{2!}x^2 + \frac{1}{4!}x^4 + \frac{1}{6!}x^6 + \cdots`,
      ),
    ],
  },
  {
    id: "note_TV1_hatZ_hatY_026_reference_facts_on_arg",
    targets: ["arg_of_gamma2_quotient"],
    title: { text: "逆数と積の arg に関する参考事実（原文の note）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/025_claim_gamma2の商のarg.typ",
    body: [
      paragraph(["（原文の note にある参考事実）"]),
      displayMath(
        String.raw`\arg^{[0,2\pi)}\!\left(\frac{1}{z}\right) = \arg^{[0,2\pi)}(z^{-1}) = \begin{cases}0 & (\arg^{[0,2\pi)}(z) = 0) \\ 2\pi - \arg^{[0,2\pi)}(z) & (0 < \arg^{[0,2\pi)}(z) < 2\pi)\end{cases}`,
      ),
      paragraph([
        math(String.raw`z_1, z_2 \in \mathbb{C}`),
        " について ",
        math(String.raw`r_1, r_2 \in \mathbb{R}_{\geq 0}`),
        "、",
        math(String.raw`\theta_1, \theta_2 \in \mathbb{R}`),
        " を用いて ",
        math(String.raw`\phi_{\mathrm{polar}}(z_1) = [(r_1,\theta_1)]_{\sim}`),
        "、",
        math(String.raw`\phi_{\mathrm{polar}}(z_2) = [(r_2,\theta_2)]_{\sim}`),
        " とすると、",
        math(String.raw`0 \leq \theta_1+\theta_2-2n\pi < 2\pi`),
        " を満たす ",
        math(String.raw`n \in \mathbb{Z}`),
        " が存在して ",
        math(String.raw`\arg^{[0,2\pi)}(z_1 z_2) = \theta_1+\theta_2-2n\pi`),
        "。",
      ]),
    ],
  },
  {
    // 元は def_fermi の notes。定義の妥当性（γ2≠0 のときのみ定義される）は statement へ格上げ済みで、
    // ここに残すのは書き換え形と先行研究との比較（出版の解説パート用の素材）。
    id: "note_TV1_hatZ_hatY_030_epsilon_form_and_holonomic_comparison",
    targets: ["def_fermi"],
    title: { text: "符号 ε_μ を用いた書き換えと、ホロノミック量子場の定義との相違" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/029_definition_フェルミオン.typ",
    body: [
      paragraph([
        ref("equation_of_a_theta_mu"),
        " の Part A より、",
        math(String.raw`\arg^{[0,2\pi)}(\gamma_2(-\theta_\mu))`),
        " に応じて符号 ",
        math(String.raw`\epsilon_\mu \in \{+1, -1\}`),
        " が定まり、",
        math(String.raw`\dfrac{\sqrt{\gamma_2(\theta_\mu)\gamma_2(-\theta_\mu)}}{\gamma_2(-\theta_\mu)} = \epsilon_\mu\cdot a(\theta_\mu)`),
        " が成り立つ。よって、上記のフェルミオンの定義は",
      ]),
      displayMath(
        String.raw`\psi_\mu^\dagger
= \frac{1}{2\sqrt{M}}\bigl(\hat{Y}_\mu + \epsilon_\mu\cdot i\,a(\theta_\mu)\hat{Z}_\mu^{(-)}\bigr),
\qquad
\psi_\mu
= \frac{1}{2\sqrt{M}}\bigl(\hat{Y}_\mu - \epsilon_\mu\cdot i\,a(\theta_\mu)\hat{Z}_\mu^{(-)}\bigr)`,
      ),
      paragraph([
        "のようにも書ける。これはホロノミック量子場 付録B 式(B.11)(B.12) の定義とは、",
        math(String.raw`a(\theta_\mu)`),
        " が逆数になっている点、および領域に応じた符号 ",
        math(String.raw`\epsilon_\mu`),
        " がある点で異なる。",
      ]),
    ],
  },
  {
    // 元は def_Vprime の notes。和の範囲を限定する理由（well-definedness）は statement へ格上げ済みで、
    // ここに残すのは先行研究との比較。
    id: "note_TV1_hatZ_hatY_033_holonomic_comparison",
    targets: ["def_Vprime"],
    title: { text: "ホロノミック量子場の定義との相違（添字を反転させる理由）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/032_definition_Vprimeの定義.typ",
    body: [
      paragraph([
        "この定義はホロノミック量子場の定義とは異なる。ホロノミック量子場では ",
        math(String.raw`\psi_\mu^\dagger \psi_\mu`),
        "（同インデックス）が用いられ和の範囲も ",
        math(String.raw`\mu \in \mathcal{M}`),
        " 全体にわたるが、その場合 ",
        math(String.raw`\psi_\mu^\dagger`),
        " が ",
        math(String.raw`\mathrm{ad}(X)`),
        " の固有ベクトルにならないため ",
        math(String.raw`T_{(V')}(\psi_\mu^\dagger) = e^{\gamma(\theta_\mu)}\psi_\mu^\dagger`),
        " が成り立たない。本定義では ",
        math(String.raw`\psi_\mu^\dagger \psi_{-\mu}`),
        "（反転インデックス）を使い和を ",
        math(String.raw`\gamma_2(\theta_\mu) \neq 0`),
        " なる ",
        math(String.raw`\mu \in \{1,\dots,M\}`),
        " にとることで、この問題を回避している。",
      ]),
    ],
  },
  {
    // 元は V_eq_Vprime の #note。証明の依存関係についての方針メモであり、
    // 主張の正しさそのものには不要なのでノートへ置く。
    id: "note_TV1_hatZ_hatY_039_proof_does_not_use_clifford_group",
    targets: ["V_eq_Vprime"],
    title: { text: "この証明はクリフォード群の性質に依存しない（原文の note）" },
    sourcePath: "_old/typst/parts/008_T_V1_hatZとhatZ_hatYの関係/039_claim_V_eq_Vprime.typ",
    body: [
      paragraph([
        "この証明はクリフォード群（",
        ref("def_T_g"),
        " とは別の TODO 項目 009）の性質には依存しない。",
        ref("T_V_eq_T_Vprime"),
        " の共役写像としての一致から、全行列環 ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})^{\otimes M}`),
        " の中心がスカラーに限ること（",
        ref("centralizer_is_scalar"),
        "）を用いて結論する。",
      ]),
    ],
  },
]);
