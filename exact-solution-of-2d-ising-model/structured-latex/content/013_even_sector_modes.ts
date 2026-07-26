import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/013_even_sector_modes.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_modes",
    kind: "heading",
    level: 2,
    sourcePath: SRC,
    sourceOrdinal: 1,
    title: { text: "偶セクターの半整数運動量モード" },
    labels: [],
    conversion: { status: "added" },
  },

  {
    id: "evensector_000_remark_overview",
    kind: "remark",
    sourcePath: SRC,
    sourceOrdinal: 2,
    title: { text: "この章の目的" },
    labels: [],
    statement: [
      paragraph([
        ref("remark_remaining_input_even_sector"),
        " で述べたとおり、Onsager の自由エネルギーを本文で閉じるために残っている入力は 1 つだけである：",
        math(String.raw`V^{(+)}`),
        " の固有値が**半整数運動量**で与えられること。この章はその土台を据える。",
      ]),
      paragraph([
        "まず ",
        ref("why_008_applies_only_to_minus_sector"),
        " で、004 章以降の ",
        math(String.raw`\hat{Z}_\mu^{(\pm)}`),
        " が ",
        math(String.raw`(-)`),
        " セクターにしか使えない理由を**等式として**確定させる。",
        "次に、符号を第 1 項に置く代わりに位相へ繰り込んだモード",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M} Z_j\,e^{-i j\tilde\theta_\mu},\qquad
\check{Y}_\mu := \sum_{j=1}^{M} Y_j\,e^{-i j\tilde\theta_\mu},\qquad
\tilde\theta_\mu := \frac{2\pi\left(\mu - \tfrac{1}{2}\right)}{M}`,
      ),
      paragraph([
        "を導入し、これらが ",
        math(String.raw`H_1^{(+)}, H_2`),
        " に対して ",
        ref("commutator_of_H_and_Z_Y"),
        " と**同じ形**の交換関係を満たすこと、および ",
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " に対応する反交換関係を満たすことを示す。",
      ]),
      paragraph([
        "働く仕組みは 1 つの等式に集約される：",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        "（**反周期性**）。",
        math(String.raw`\hat{Z}^{(\pm)}`),
        " では境界の符号を第 1 項に置いていたのに対し、",
        math(String.raw`\check{Z}`),
        " では位相 ",
        math(String.raw`e^{-ij\tilde\theta_\mu}`),
        " が ",
        math(String.raw`j = M`),
        " から ",
        math(String.raw`j = 0`),
        " へ回るときに自動的に符号を出す。この違いが、",
        math(String.raw`H_2`),
        " との交換関係が壊れるか壊れないかを分ける。",
      ]),
      paragraph([
        "**この章で扱うのはここまでである。** これらの関係式から ",
        math(String.raw`V^{(+)}`),
        " の固有値を導くには、008 章・009 章と同じ道筋（",
        math(String.raw`T_V`),
        " の作用 → ",
        math(String.raw`A(\theta)`),
        " の対角化 → フェルミオン → ",
        math(String.raw`V = cV'`),
        " → 固有値）を半整数運動量で辿る必要があり、その分量は 008 章と 009 章の合計に相当する。",
        "進め方は `docs/tasks/free-energy-roadmap/task-dependency-graph.md` の章 C′ に記した。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_001_claim_why_minus_only",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 3,
    title: { tex: String.raw`008 \text{ 章の議論が } (-) \text{ セクター専用である理由}` },
    labels: ["why_008_applies_only_to_minus_sector"],
    statement: [
      paragraph([
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\hat{Z}_\mu^{(\pm)}`),
        " と ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`H_2`),
        " について、",
        math(String.raw`\mu \in \mathcal{M}`),
        " で",
      ]),
      displayMath(
        String.raw`\left[H_2,\ \hat{Z}_\mu^{(-)}\right] = -2\,\hat{Y}_\mu,
\qquad
\left[H_2,\ \hat{Z}_\mu^{(+)}\right] = -2\,\hat{Y}_\mu + 4\,e^{-i\frac{2\pi\mu}{M}}\,Y_1`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`Y_1 \neq 0`),
        " なので **",
        math(String.raw`\left[H_2, \hat{Z}_\mu^{(+)}\right] \neq -2\hat{Y}_\mu`),
        "** である。",
      ]),
      paragraph([
        ref("commutator_of_H_and_Z_Y"),
        " の (C) は ",
        math(String.raw`\hat{Z}_\mu^{(-)}`),
        " についての主張であり、008 章以降の議論（",
        ref("nesting_of_commutator_of_H_and_Z"),
        " の (h2.z−) 以下すべて）はこの (C) を土台にしている。",
        "したがって **008 章以降は ",
        math(String.raw`(-)`),
        " セクター専用であり、",
        math(String.raw`V^{(+)}`),
        " にはそのまま適用できない。**",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（サイトごとの交換関係）。",
        math(String.raw`H_2 = \sum_{m=1}^{M} Z_mY_m`),
        " と ",
        ref("anticommutator_of_Z_and_Y"),
        " から、",
        math(String.raw`j \in \{1,\dots,M\}`),
        " について",
      ]),
      displayMath(String.raw`\left[H_2,\ Z_j\right] = -2\,Y_j`),
      paragraph([
        "を示す。",
        math(String.raw`m \neq j`),
        " の項について、",
        ref("anticommutator_of_Z_and_Y"),
        " より ",
        math(String.raw`Z_mZ_j = -Z_jZ_m`),
        "、",
        math(String.raw`Y_mZ_j = -Z_jY_m`),
        " なので",
      ]),
      displayMath(
        String.raw`(Z_mY_m)Z_j = Z_m(Y_mZ_j) = -Z_m Z_j Y_m = Z_jZ_mY_m`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`[Z_mY_m, Z_j] = 0`),
        "（符号が 2 回反転して戻る）。",
        math(String.raw`m = j`),
        " の項は、",
        math(String.raw`Y_jZ_j = -Z_jY_j`),
        " と ",
        math(String.raw`Z_jZ_j = I`),
        "（",
        ref("anticommutator_of_Z_and_Y"),
        " で ",
        math(String.raw`\mu=\nu=j`),
        " とすると ",
        math(String.raw`2Z_j^2 = 2I`),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[Z_jY_j,\ Z_j\right]
&= Z_jY_jZ_j - Z_jZ_jY_j \\
&= Z_j(-Z_jY_j) - I\,Y_j
   \quad (\because Y_jZ_j = -Z_jY_j,\ Z_jZ_j = I) \\
&= -Y_j - Y_j = -2Y_j
\end{aligned}`,
      ),
      paragraph([
        "交換子は第 2 引数について線型なので、和をとって ",
        math(String.raw`[H_2, Z_j] = -2Y_j`),
        "。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`(-)`),
        " の場合）。",
        ref("def_hatZ_hatY"),
        " より ",
        math(String.raw`\hat{Z}_\mu^{(-)} = \sum_{j=1}^{M} Z_j e^{-i\frac{2\pi j\mu}{M}}`),
        "（",
        math(String.raw`j=1`),
        " の係数は ",
        math(String.raw`-(-1) = +1`),
        "）である。交換子の線型性と Step 1 より",
      ]),
      displayMath(
        String.raw`\left[H_2, \hat{Z}_\mu^{(-)}\right]
= \sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}\left[H_2, Z_j\right]
= -2\sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}\,Y_j
= -2\,\hat{Y}_\mu`,
      ),
      paragraph([
        "（最後の等号は ",
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\hat{Y}_\mu`),
        " の定義。）",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`(+)`),
        " の場合）。",
        ref("def_hatZ_hatY"),
        " より ",
        math(String.raw`\hat{Z}_\mu^{(+)}`),
        " は ",
        math(String.raw`j=1`),
        " の係数だけが ",
        math(String.raw`-1`),
        " なので",
      ]),
      displayMath(
        String.raw`\hat{Z}_\mu^{(+)} = \hat{Z}_\mu^{(-)} - 2\,e^{-i\frac{2\pi\mu}{M}}\,Z_1`,
      ),
      paragraph([
        "（",
        math(String.raw`j=1`),
        " の係数が ",
        math(String.raw`+1`),
        " から ",
        math(String.raw`-1`),
        " へ変わる分を引いた）。交換子の線型性と Step 1・Step 2 より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2, \hat{Z}_\mu^{(+)}\right]
&= \left[H_2, \hat{Z}_\mu^{(-)}\right] - 2e^{-i\frac{2\pi\mu}{M}}\left[H_2, Z_1\right] \\
&= -2\hat{Y}_\mu - 2e^{-i\frac{2\pi\mu}{M}}\left(-2Y_1\right) \\
&= -2\hat{Y}_\mu + 4\,e^{-i\frac{2\pi\mu}{M}}\,Y_1
\end{aligned}`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`Y_1 \neq 0`),
        "）。",
        ref("def_transfer_matrix_symbols"),
        " より ",
        math(String.raw`Y_1 = \sigma_1^y`),
        " であり、",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^y\sigma^y = I`),
        " より ",
        math(String.raw`Y_1`),
        " は可逆、とくに ",
        math(String.raw`Y_1 \neq 0`),
        "。また ",
        math(String.raw`e^{-i2\pi\mu/M} \neq 0`),
        " なので ",
        math(String.raw`4e^{-i2\pi\mu/M}Y_1 \neq 0`),
        " であり、2 つの交換子は一致しない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "数値でも (-) 側は残差 1e-15 で成立、(+) 側は残差 1e-3 以上で不成立であることを確認済み（sagemath/check/045_claim_free_energy/check_03_remaining_input.sage および 046_claim_even_sector_modes/check_01）。",
      ],
    },
  },

  {
    id: "evensector_002_claim_antiperiodic_exp_sum",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 4,
    title: { text: "半整数運動量の指数和" },
    labels: ["antiperiodic_exp_sum"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\tilde\theta_\mu := \frac{2\pi\left(\mu-\tfrac12\right)}{M} \in \mathbb{R}`,
      ),
      paragraph(["とおく。このとき ", math(String.raw`k \in \mathbb{Z}`), " について"]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M} e^{i k \tilde\theta_\mu}
= \begin{cases}
M\,(-1)^{l} & (k = lM,\ l \in \mathbb{Z}) \\
0 & (k \not\equiv 0 \pmod M)
\end{cases}`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`|k| < M`),
        " かつ ",
        math(String.raw`k \neq 0`),
        " なら和は ",
        math(String.raw`0`),
        "、",
        math(String.raw`k = 0`),
        " なら ",
        math(String.raw`M`),
        " である。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\mu}{M} - \dfrac{\pi}{M}`),
        " なので、指数法則より",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M} e^{ik\tilde\theta_\mu}
= \sum_{\mu=1}^{M} e^{i\frac{2\pi\mu k}{M}}\,e^{-i\frac{\pi k}{M}}
= e^{-i\frac{\pi k}{M}}\sum_{\mu=1}^{M} e^{\frac{2\pi i \mu k}{M}}`,
      ),
      paragraph([
        ref("exp_sum"),
        " より右端の和は ",
        math(String.raw`M\,\delta^M_{(k,0)}`),
        " である（",
        ref("def_delta_M"),
        "）。",
      ]),
      paragraph([
        math(String.raw`k \not\equiv 0 \pmod M`),
        " のときは ",
        math(String.raw`\delta^M_{(k,0)} = 0`),
        " なので和は ",
        math(String.raw`0`),
        "。",
      ]),
      paragraph([
        math(String.raw`k = lM`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）のときは ",
        math(String.raw`\delta^M_{(k,0)} = 1`),
        " であり、前因子は",
      ]),
      displayMath(
        String.raw`e^{-i\frac{\pi k}{M}} = e^{-i\frac{\pi l M}{M}} = e^{-i\pi l} = (-1)^{l}`,
      ),
      paragraph([
        "（",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`e^{-i\pi l} = \cos(\pi l) - i\sin(\pi l) = (-1)^l`),
        "）。よって和は ",
        math(String.raw`M(-1)^l`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "definition",
    sourcePath: SRC,
    sourceOrdinal: 5,
    title: { tex: String.raw`\check{Z}_\mu, \check{Y}_\mu \text{（半整数運動量モード）}` },
    labels: ["def_half_integer_modes"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \mathbb{Z}`),
        " とし、",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi(\mu-\frac12)}{M}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`\check{Z}_\mu := \sum_{j=1}^{M} Z_j\,e^{-i j\tilde\theta_\mu},\qquad
\check{Y}_\mu := \sum_{j=1}^{M} Y_j\,e^{-i j\tilde\theta_\mu}
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`Z_j, Y_j`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " のもの）。",
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\hat{Z}_\mu^{(\pm)}`),
        " と違い、**係数に例外項が無い**（すべての ",
        math(String.raw`j`),
        " で係数は ",
        math(String.raw`e^{-ij\tilde\theta_\mu}`),
        "）。",
      ]),
      paragraph(["次の 3 つの性質を後で繰り返し使う。"]),
      list([
        [
          math(String.raw`\text{(1) 反周期性：}\quad e^{-i M \tilde\theta_\mu} = -1`),
        ],
        [
          math(String.raw`\text{(2) 添字の周期性：}\quad \check{Z}_{\mu+M} = \check{Z}_\mu,\quad \check{Y}_{\mu+M} = \check{Y}_\mu`),
        ],
        [
          math(String.raw`\text{(3) 共役添字：}\quad \tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`M\tilde\theta_\mu = 2\pi\left(\mu-\tfrac12\right) = 2\pi\mu - \pi`),
        " なので、",
        ref("euler_formula_cos_sin"),
        " より",
      ]),
      displayMath(
        String.raw`e^{-iM\tilde\theta_\mu} = e^{-i(2\pi\mu - \pi)} = e^{-2\pi i\mu}\,e^{i\pi} = 1\cdot(-1) = -1`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`\tilde\theta_{\mu+M} = \dfrac{2\pi(\mu+M-\frac12)}{M} = \tilde\theta_\mu + 2\pi`),
        " なので ",
        math(String.raw`e^{-ij\tilde\theta_{\mu+M}} = e^{-ij\tilde\theta_\mu}e^{-2\pi i j} = e^{-ij\tilde\theta_\mu}`),
        "（",
        math(String.raw`j \in \mathbb{Z}`),
        "）。係数がすべて一致するので ",
        math(String.raw`\check{Z}_{\mu+M} = \check{Z}_\mu`),
        "、",
        math(String.raw`\check{Y}_{\mu+M} = \check{Y}_\mu`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`\tilde\theta_{1-\mu} = \dfrac{2\pi\left(1-\mu-\frac12\right)}{M} = \dfrac{2\pi\left(\frac12-\mu\right)}{M} = -\dfrac{2\pi\left(\mu-\frac12\right)}{M} = -\tilde\theta_\mu`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
      ],
    },
  },

  {
    id: "evensector_004_claim_commutator_H_check_Z_Y",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 6,
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ と } \check{Z}, \check{Y} \text{ の交換関係}` },
    labels: ["commutator_of_H_and_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \mathbb{Z}`),
        " について（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_V1_pm"),
        " の ",
        math(String.raw`H_1^{(\pm)}`),
        " で上の符号を取ったもの、すなわち ",
        math(String.raw`H_1^{(+)} = Y_1Z_2 + \cdots + Y_{M-1}Z_M - Y_MZ_1`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad \left[H_1^{(+)},\ \check{Z}_\mu\right] &= 2\,e^{-i\tilde\theta_\mu}\,\check{Y}_\mu, &
\text{(B)}\quad \left[H_1^{(+)},\ \check{Y}_\mu\right] &= -2\,e^{i\tilde\theta_\mu}\,\check{Z}_\mu, \\
\text{(C)}\quad \left[H_2,\ \check{Z}_\mu\right] &= -2\,\check{Y}_\mu, &
\text{(D)}\quad \left[H_2,\ \check{Y}_\mu\right] &= 2\,\check{Z}_\mu
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。これは ",
        ref("commutator_of_H_and_Z_Y"),
        " の (A)〜(D) と**同じ形**であり、",
        math(String.raw`\theta_\mu`),
        " が ",
        math(String.raw`\tilde\theta_\mu`),
        " に、",
        math(String.raw`\hat{Z}_\mu^{(\pm)}, \hat{Y}_\mu`),
        " が ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " に置き換わっただけである。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（サイトごとの交換関係）。",
        ref("anticommutator_of_Z_and_Y"),
        " の関係式（相異なる添字の ",
        math(String.raw`Z, Y`),
        " は反可換、同じ添字では ",
        math(String.raw`Z_jZ_j = Y_jY_j = I`),
        " かつ ",
        math(String.raw`Z_jY_j = -Y_jZ_j`),
        "）から、次を示す。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ Z_j\right] &= -2Y_j, &
\left[H_2,\ Y_j\right] &= 2Z_j, \\
\left[H_1^{(+)},\ Z_j\right] &= 2\,Y_{j-1}^{\flat}, &
\left[H_1^{(+)},\ Y_j\right] &= -2\,Z_{j+1}^{\flat}
\end{aligned}`,
      ),
      paragraph([
        "ここで**反周期的な延長**",
      ]),
      displayMath(
        String.raw`Y_0^{\flat} := -Y_M,\quad Y_j^{\flat} := Y_j\ (1\leq j\leq M),\qquad
Z_{M+1}^{\flat} := -Z_1,\quad Z_j^{\flat} := Z_j\ (1\leq j\leq M)`,
      ),
      paragraph([
        "を用いた（",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_{M+1} := Z_1`),
        " という**周期的**な規約とは符号が逆である点に注意）。",
      ]),
      paragraph([
        math(String.raw`[H_2, Z_j] = -2Y_j`),
        " は ",
        ref("why_008_applies_only_to_minus_sector"),
        " の Step 1 で示した。",
        math(String.raw`[H_2, Y_j] = 2Z_j`),
        " も同様で、",
        math(String.raw`m \neq j`),
        " の項は 2 回の符号反転で消え、",
        math(String.raw`m = j`),
        " の項は",
      ]),
      displayMath(
        String.raw`\left[Z_jY_j,\ Y_j\right] = Z_jY_jY_j - Y_jZ_jY_j
= Z_j + Z_jY_jY_j = Z_j + Z_j = 2Z_j`,
      ),
      paragraph([
        "（",
        math(String.raw`Y_jY_j = I`),
        " と ",
        math(String.raw`Y_jZ_j = -Z_jY_j`),
        " を使った）。",
      ]),
      paragraph([
        math(String.raw`H_1^{(+)}`),
        " については、各項 ",
        math(String.raw`Y_mZ_{m+1}`),
        "（",
        math(String.raw`1 \leq m \leq M-1`),
        "）と境界項 ",
        math(String.raw`-Y_MZ_1`),
        " を個別に見る。",
        math(String.raw`Y_mZ_{m+1}`),
        " と ",
        math(String.raw`Z_j`),
        " について、",
        math(String.raw`j \neq m+1`),
        " なら ",
        math(String.raw`Z_j`),
        " は ",
        math(String.raw`Y_m`),
        " とも ",
        math(String.raw`Z_{m+1}`),
        " とも反可換なので 2 回の符号反転で可換になり交換子は ",
        math(String.raw`0`),
        "。",
        math(String.raw`j = m+1`),
        " なら",
      ]),
      displayMath(
        String.raw`\left[Y_mZ_{m+1},\ Z_{m+1}\right]
= Y_mZ_{m+1}Z_{m+1} - Z_{m+1}Y_mZ_{m+1}
= Y_m + Y_mZ_{m+1}Z_{m+1} = 2Y_m`,
      ),
      paragraph([
        "（",
        math(String.raw`Z_{m+1}Z_{m+1} = I`),
        " と ",
        math(String.raw`Z_{m+1}Y_m = -Y_mZ_{m+1}`),
        "）。したがって ",
        math(String.raw`2 \leq j \leq M`),
        " では ",
        math(String.raw`m = j-1`),
        " の項だけが残って ",
        math(String.raw`[H_1^{(+)}, Z_j] = 2Y_{j-1}`),
        "。",
        math(String.raw`j = 1`),
        " では境界項だけが残り",
      ]),
      displayMath(
        String.raw`\left[-Y_MZ_1,\ Z_1\right] = -2Y_M = 2\left(-Y_M\right) = 2\,Y_0^{\flat}`,
      ),
      paragraph([
        "であるから、両方の場合が ",
        math(String.raw`[H_1^{(+)}, Z_j] = 2Y_{j-1}^{\flat}`),
        " にまとまる。",
      ]),
      paragraph([
        "同様に ",
        math(String.raw`Y_mZ_{m+1}`),
        " と ",
        math(String.raw`Y_j`),
        " については ",
        math(String.raw`j = m`),
        " の項だけが残り",
      ]),
      displayMath(
        String.raw`\left[Y_mZ_{m+1},\ Y_m\right]
= Y_mZ_{m+1}Y_m - Y_mY_mZ_{m+1}
= -Y_mY_mZ_{m+1} - Z_{m+1} = -2Z_{m+1}`,
      ),
      paragraph([
        "なので ",
        math(String.raw`1 \leq j \leq M-1`),
        " では ",
        math(String.raw`[H_1^{(+)}, Y_j] = -2Z_{j+1}`),
        "。",
        math(String.raw`j = M`),
        " では境界項だけが残り",
      ]),
      displayMath(
        String.raw`\left[-Y_MZ_1,\ Y_M\right] = -\left(-2Z_1\right) = 2Z_1 = -2\left(-Z_1\right) = -2\,Z_{M+1}^{\flat}`,
      ),
      paragraph([
        "であるから ",
        math(String.raw`[H_1^{(+)}, Y_j] = -2Z_{j+1}^{\flat}`),
        " にまとまる。",
      ]),
      paragraph([
        "Step 2（(C)(D)）。交換子は第 2 引数について ",
        math(String.raw`\mathbb{C}`),
        " 線型なので、Step 1 の第 1 式と ",
        ref("def_half_integer_modes"),
        " より",
      ]),
      displayMath(
        String.raw`\left[H_2,\ \check{Z}_\mu\right]
= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_2, Z_j\right]
= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j
= -2\,\check{Y}_\mu`,
      ),
      paragraph(["同様に第 2 式から ", math(String.raw`\left[H_2, \check{Y}_\mu\right] = 2\check{Z}_\mu`), "。"]),
      paragraph([
        "Step 3（(A)）。Step 1 の第 3 式と線型性より",
      ]),
      displayMath(
        String.raw`\left[H_1^{(+)},\ \check{Z}_\mu\right]
= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\cdot 2\,Y_{j-1}^{\flat}
= 2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Y_{j-1}^{\flat}`,
      ),
      paragraph([
        math(String.raw`l := j-1`),
        " と置き換えると ",
        math(String.raw`e^{-ij\tilde\theta_\mu} = e^{-i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}`),
        " なので",
      ]),
      displayMath(
        String.raw`\left[H_1^{(+)},\ \check{Z}_\mu\right]
= 2\,e^{-i\tilde\theta_\mu}\sum_{l=0}^{M-1} e^{-il\tilde\theta_\mu}\,Y_l^{\flat}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`l = 0`),
        " の項を ",
        math(String.raw`l = M`),
        " の項に置き換えられる。実際 ",
        ref("def_half_integer_modes"),
        " (1) の ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " と ",
        math(String.raw`Y_0^{\flat} = -Y_M`),
        " より",
      ]),
      displayMath(
        String.raw`e^{-i\cdot 0\cdot\tilde\theta_\mu}\,Y_0^{\flat} = 1\cdot\left(-Y_M\right) = \left(-1\right)Y_M
= e^{-iM\tilde\theta_\mu}\,Y_M = e^{-iM\tilde\theta_\mu}\,Y_M^{\flat}`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\sum_{l=0}^{M-1} = \sum_{l=1}^{M}`),
        "（",
        math(String.raw`l=0`),
        " の項を落として ",
        math(String.raw`l=M`),
        " の項を足す。両者は等しい）であり",
      ]),
      displayMath(
        String.raw`\left[H_1^{(+)},\ \check{Z}_\mu\right]
= 2\,e^{-i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Y_l
= 2\,e^{-i\tilde\theta_\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "Step 4（(B)）。Step 1 の第 4 式と線型性より",
      ]),
      displayMath(
        String.raw`\left[H_1^{(+)},\ \check{Y}_\mu\right]
= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Z_{j+1}^{\flat}
= -2\,e^{i\tilde\theta_\mu}\sum_{l=2}^{M+1} e^{-il\tilde\theta_\mu}\,Z_l^{\flat}`,
      ),
      paragraph([
        "（",
        math(String.raw`l := j+1`),
        "、",
        math(String.raw`e^{-ij\tilde\theta_\mu} = e^{i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}`),
        "）。ここでも ",
        math(String.raw`l = M+1`),
        " の項を ",
        math(String.raw`l = 1`),
        " の項に置き換えられる：",
      ]),
      displayMath(
        String.raw`e^{-i(M+1)\tilde\theta_\mu}\,Z_{M+1}^{\flat}
= e^{-iM\tilde\theta_\mu}\,e^{-i\tilde\theta_\mu}\left(-Z_1\right)
= \left(-1\right)e^{-i\tilde\theta_\mu}\left(-Z_1\right)
= e^{-i\tilde\theta_\mu}\,Z_1`,
      ),
      paragraph([
        "よって ",
        math(String.raw`\sum_{l=2}^{M+1} = \sum_{l=1}^{M}`),
        " であり",
      ]),
      displayMath(
        String.raw`\left[H_1^{(+)},\ \check{Y}_\mu\right]
= -2\,e^{i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Z_l
= -2\,e^{i\tilde\theta_\mu}\,\check{Z}_\mu`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "(A)(B) が成り立つ仕組みは反周期性 e^{-iM θ~_μ} = -1 である。整数運動量では e^{-iM θ_μ} = +1 なので、同じ計算をすると境界項の符号が合わず H_1^{(-)} 側でしか閉じない。ここが (+) と (-) を分ける唯一の点である。",
        "M=2,3,4,5 の全 μ について数値で確認済み（sagemath/check/046_claim_even_sector_modes/check_02_commutators.sage）。",
      ],
    },
  },

  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 7,
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu, \nu \in \mathbb{Z}`), " について"]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M\,\delta^M_{(\mu+\nu,\,1)}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M\,\delta^M_{(\mu+\nu,\,1)}\,I`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\delta^M`),
        " は ",
        ref("def_delta_M"),
        " のものである。",
      ]),
      paragraph([
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " では対になる添字が ",
        math(String.raw`\mu+\nu \equiv 0`),
        " だったのに対し、ここでは ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " である。これは ",
        ref("def_half_integer_modes"),
        " (3) の共役添字が ",
        math(String.raw`-\mu`),
        " ではなく ",
        math(String.raw`1-\mu`),
        " であることに対応する。",
      ]),
    ],
    proof: [
      paragraph([
        "反交換子は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型（",
        math(String.raw`[\alpha X,\beta W]_+ = \alpha\beta[X,W]_+`),
        "）なので、",
        ref("def_half_integer_modes"),
        " を代入して",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
= \sum_{j=1}^{M}\sum_{k=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ik\tilde\theta_\nu}
  \left[Z_j, Z_k\right]_+`,
      ),
      paragraph([
        ref("anticommutator_of_Z_and_Y"),
        " より ",
        math(String.raw`[Z_j,Z_k]_+ = 2I\,\delta^M_{(j,k)}`),
        " であり、",
        math(String.raw`1 \leq j,k \leq M`),
        " の範囲では ",
        math(String.raw`\delta^M_{(j,k)} = 1 \iff j = k`),
        " なので、二重和のうち ",
        math(String.raw`j = k`),
        " の項だけが残って",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
= 2I\sum_{j=1}^{M} e^{-ij\left(\tilde\theta_\mu + \tilde\theta_\nu\right)}`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`\tilde\theta_\mu + \tilde\theta_\nu = \dfrac{2\pi\left(\mu+\nu-1\right)}{M}`),
        " なので、",
        ref("exp_sum"),
        " を ",
        math(String.raw`k = -(\mu+\nu-1)`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\sum_{j=1}^{M} e^{-ij\left(\tilde\theta_\mu+\tilde\theta_\nu\right)}
= \sum_{j=1}^{M} \exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M}\right)
= M\,\delta^M_{(-(\mu+\nu-1),\,0)}
= M\,\delta^M_{(\mu+\nu,\,1)}`,
      ),
      paragraph([
        "（最後の等号は ",
        ref("def_delta_M"),
        " より ",
        math(String.raw`-(\mu+\nu-1) \equiv 0 \iff \mu+\nu \equiv 1 \pmod M`),
        "）。よって第 1 式を得る。",
      ]),
      paragraph([
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Z_j, Y_k]_+ = 0`),
        " より、同じ展開で第 2 式 ",
        math(String.raw`[\check{Z}_\mu, \check{Y}_\nu]_+ = 0`),
        " が従う（二重和のすべての項が ",
        math(String.raw`0`),
        "）。",
      ]),
      paragraph([
        "第 3 式は ",
        math(String.raw`[Y_j,Y_k]_+ = 2I\,\delta^M_{(j,k)}`),
        " を使って第 1 式とまったく同じ計算になる。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 8,
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ から } Z_j, Y_j \text{ を復元する}` },
    labels: ["recover_Z_Y_from_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`j \in \{1,\dots,M\}`), " について"]),
      displayMath(
        String.raw`Z_j = \frac{1}{M}\sum_{\mu=1}^{M} \check{Z}_\mu\,e^{i j\tilde\theta_\mu},
\qquad
Y_j = \frac{1}{M}\sum_{\mu=1}^{M} \check{Y}_\mu\,e^{i j\tilde\theta_\mu}`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Z}_1,\dots,\check{Z}_M,\check{Y}_1,\dots,\check{Y}_M`),
        " は ",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`Z_j, Y_j`),
        " を生成するので、",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " を（単位的 ",
        math(String.raw`\mathbb{C}`),
        " 代数として）生成する。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_half_integer_modes"),
        " を代入し、有限和の順序を交換すると",
      ]),
      displayMath(
        String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{ij\tilde\theta_\mu}
= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_\mu}\,e^{ij\tilde\theta_\mu}
= \frac{1}{M}\sum_{k=1}^{M} Z_k \sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}`,
      ),
      paragraph([
        math(String.raw`1 \leq j,k \leq M`),
        " より ",
        math(String.raw`|j-k| \leq M-1 < M`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " より内側の和は ",
        math(String.raw`j = k`),
        " のとき ",
        math(String.raw`M`),
        "、そうでないとき ",
        math(String.raw`0`),
        " である（",
        math(String.raw`|j-k| < M`),
        " なので ",
        math(String.raw`j-k \equiv 0 \pmod M`),
        " は ",
        math(String.raw`j = k`),
        " と同値で、そのとき ",
        math(String.raw`l = 0`),
        " すなわち ",
        math(String.raw`(-1)^l = 1`),
        "）。よって ",
        math(String.raw`k = j`),
        " の項だけが残り",
      ]),
      displayMath(
        String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{ij\tilde\theta_\mu}
= \frac{1}{M}\cdot Z_j\cdot M = Z_j`,
      ),
      paragraph([math(String.raw`Y_j`), " についても同じ計算である。"]),
      paragraph([
        "生成性については、",
        ref("Z_Y_generate_algebra"),
        " が ",
        math(String.raw`Z_j, Y_j`),
        " の生成性を主張しており、いま示した式は各 ",
        math(String.raw`Z_j, Y_j`),
        " が ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 線型結合であることを与えるので、",
        math(String.raw`\check{Z}, \check{Y}`),
        " の生成する部分代数は ",
        math(String.raw`Z_j, Y_j`),
        " をすべて含み、したがって全体に一致する。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_007_claim_H1_H2_via_check_Z_Y",
    kind: "claim",
    sourcePath: SRC,
    sourceOrdinal: 9,
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ を } \check{Z}, \check{Y} \text{ で表す}` },
    labels: ["H1_H2_via_check_Z_Y"],
    statement: [
      displayMath(
        String.raw`H_1^{(+)} = \frac{1}{M}\sum_{\mu=1}^{M} \check{Y}_\mu\,\check{Z}_{1-\mu}\,e^{-i\tilde\theta_\mu},
\qquad
H_2 = \frac{1}{M}\sum_{\mu=1}^{M} \check{Z}_{1-\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        ref("H1_H2_via_hatZ_hatY"),
        " の半整数運動量版。共役添字が ",
        math(String.raw`-\mu`),
        " から ",
        math(String.raw`1-\mu`),
        " に変わっている）。",
      ]),
    ],
    proof: [
      paragraph([
        ref("def_half_integer_modes"),
        " (3) より ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " なので ",
        math(String.raw`\check{Z}_{1-\mu} = \sum_{k=1}^{M} Z_k e^{ik\tilde\theta_\mu}`),
        " である。",
      ]),
      paragraph([math(String.raw`H_2`), " について、有限和の順序交換より"]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_{1-\mu}\check{Y}_\mu
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right)
   \left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right) \\
&= \frac{1}{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j
   \sum_{\mu=1}^{M} e^{i(k-j)\tilde\theta_\mu}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`1 \leq j,k \leq M`),
        " より ",
        math(String.raw`|k-j| < M`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " より内側の和は ",
        math(String.raw`k = j`),
        " のとき ",
        math(String.raw`M`),
        "、そうでないとき ",
        math(String.raw`0`),
        "。よって",
      ]),
      displayMath(
        String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_{1-\mu}\check{Y}_\mu
= \sum_{j=1}^{M} Z_jY_j = H_2`,
      ),
      paragraph([
        math(String.raw`H_1^{(+)}`),
        " について、同様に展開すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\check{Z}_{1-\mu}e^{-i\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right)
   \left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right) e^{-i\tilde\theta_\mu} \\
&= \frac{1}{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k
   \sum_{\mu=1}^{M} e^{-i(j-k+1)\tilde\theta_\mu}
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`1 \leq j,k \leq M`),
        " より ",
        math(String.raw`j-k+1`),
        " は ",
        math(String.raw`2-M`),
        " 以上 ",
        math(String.raw`M`),
        " 以下である。",
        ref("antiperiodic_exp_sum"),
        " より、内側の和が ",
        math(String.raw`0`),
        " でないのは ",
        math(String.raw`j-k+1 = lM`),
        " のときに限り、この範囲では ",
        math(String.raw`l = 0`),
        " と ",
        math(String.raw`l = 1`),
        " だけが可能である。",
      ]),
      list([
        [
          math(String.raw`l = 0`),
          "、すなわち ",
          math(String.raw`k = j+1`),
          "（",
          math(String.raw`k \leq M`),
          " より ",
          math(String.raw`1 \leq j \leq M-1`),
          "）。このとき内側の和は ",
          math(String.raw`M(-1)^0 = M`),
          "。",
        ],
        [
          math(String.raw`l = 1`),
          "、すなわち ",
          math(String.raw`j-k+1 = M`),
          "。",
          math(String.raw`1\leq j,k\leq M`),
          " でこれを満たすのは ",
          math(String.raw`j = M,\ k = 1`),
          " のみ。このとき内側の和は ",
          math(String.raw`M(-1)^1 = -M`),
          "。",
        ],
      ]),
      paragraph(["したがって"]),
      displayMath(
        String.raw`\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\check{Z}_{1-\mu}e^{-i\tilde\theta_\mu}
= \frac{1}{M}\left(\sum_{j=1}^{M-1} Y_jZ_{j+1}\cdot M + Y_MZ_1\cdot(-M)\right)
= \sum_{j=1}^{M-1} Y_jZ_{j+1} - Y_MZ_1`,
      ),
      paragraph([
        ref("def_V1_pm"),
        " より右辺は ",
        math(String.raw`H_1^{(+)}`),
        " に等しい。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "境界項 -Y_M Z_1 の符号が、antiperiodic_exp_sum の l=1 の因子 (-1)^1 として自動的に出てくる。整数運動量版 H1_H2_via_hatZ_hatY で hat(Z)^{(±)} の第 1 項の符号が担っていた役割を、ここでは指数和の符号が担っている。",
      ],
    },
  },
]);
