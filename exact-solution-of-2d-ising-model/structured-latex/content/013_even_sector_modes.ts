import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/013_even_sector_modes.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_modes",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "偶セクターの半整数運動量モード" },
    labels: [],
  },

  {
    id: "evensector_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
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
    origin: { path: SRC, ordinal: 3 },
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
        String.raw`\begin{aligned}
\left(Z_mY_m\right)Z_j
&= Z_m\left(Y_mZ_j\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= Z_m\left(-Z_jY_m\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (m \neq j)) \\
&= -\left(Z_mZ_j\right)Y_m
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -\left(-Z_jZ_m\right)Y_m
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (m \neq j)) \\
&= Z_j\left(Z_mY_m\right)
   \quad (\because -(-1) = 1 \text{ の符号の消去と行列の積の結合法則})
\end{aligned}`,
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
&= \left(Z_jY_j\right)Z_j - Z_j\left(Z_jY_j\right)
   \quad (\because \text{交換子の定義}) \\
&= Z_j\left(Y_jZ_j\right) - \left(Z_jZ_j\right)Y_j
   \quad (\because \text{行列の積の結合法則}) \\
&= Z_j\left(-Z_jY_j\right) - \left(Z_jZ_j\right)Y_j
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= -\left(Z_jZ_j\right)Y_j - \left(Z_jZ_j\right)Y_j
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -I\,Y_j - I\,Y_j
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_jZ_j = I)) \\
&= -2Y_j
   \quad (\because I\,Y_j = Y_j \text{（単位行列）と同じ行列の和})
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
        String.raw`\begin{aligned}
\left[H_2,\ \hat{Z}_\mu^{(-)}\right]
&= \left[H_2,\ \sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}Z_j\right]
   \quad (\because \text{def\_hatZ\_hatY}) \\
&= \sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}\left[H_2,\ Z_j\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}\left(-2Y_j\right)
   \quad (\because \text{Step 1}) \\
&= -2\sum_{j=1}^{M} e^{-i\frac{2\pi j\mu}{M}}\,Y_j
   \quad (\because \text{スカラー倍を有限和の外へ出す（分配律）}) \\
&= -2\,\hat{Y}_\mu
   \quad (\because \text{def\_hatZ\_hatY})
\end{aligned}`,
      ),
      paragraph([
        "（最初と最後の等号で使ったのは ",
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`),
        " の定義である。）",
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
\left[H_2,\ \hat{Z}_\mu^{(+)}\right]
&= \left[H_2,\ \hat{Z}_\mu^{(-)} - 2e^{-i\frac{2\pi\mu}{M}}Z_1\right]
   \quad (\because \text{直前の displayMath}) \\
&= \left[H_2,\ \hat{Z}_\mu^{(-)}\right] - 2e^{-i\frac{2\pi\mu}{M}}\left[H_2,\ Z_1\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -2\hat{Y}_\mu - 2e^{-i\frac{2\pi\mu}{M}}\left[H_2,\ Z_1\right]
   \quad (\because \text{Step 2}) \\
&= -2\hat{Y}_\mu - 2e^{-i\frac{2\pi\mu}{M}}\left(-2Y_1\right)
   \quad (\because \text{Step 1 を } j = 1 \text{ に適用}) \\
&= -2\hat{Y}_\mu + 4\,e^{-i\frac{2\pi\mu}{M}}\,Y_1
   \quad (\because (-2)\cdot(-2) = 4 \text{ のスカラーの計算})
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
    origin: { path: SRC, ordinal: 4 },
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
      paragraph([
        "とおく（ここで ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " としているのは**記号 ",
        math(String.raw`\tilde\theta_\mu`),
        " の定義域**であって、主張を述べる添字の範囲ではない。主張の範囲は ",
        ref("def_check_index_set"),
        " で ",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
        " に絞る。下の指数和も ",
        math(String.raw`\mu`),
        " を ",
        math(String.raw`1`),
        " から ",
        math(String.raw`M`),
        " まで、すなわち ",
        math(String.raw`\check{\mathcal{M}}`),
        " 全体にわたって取っている）。このとき ",
        math(String.raw`k \in \mathbb{Z}`),
        " について",
      ]),
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
        " である。以下、指数法則 ",
        math(String.raw`e^{z+w} = e^{z}e^{w}`),
        "（",
        math(String.raw`z, w \in \mathbb{C}`),
        "）としては ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n = 1`),
        " すなわち ",
        math(String.raw`\mathrm{Mat}(1,\mathbb{C}) = \mathbb{C}`),
        " に適用したものを使う（",
        math(String.raw`\mathbb{C}`),
        " の積は可換なので仮定は満たされる）。これより",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\mu=1}^{M} e^{ik\tilde\theta_\mu}
&= \sum_{\mu=1}^{M} e^{i k\left(\frac{2\pi\mu}{M} - \frac{\pi}{M}\right)}
   \quad (\because \tilde\theta_\mu = \tfrac{2\pi\mu}{M} - \tfrac{\pi}{M}) \\
&= \sum_{\mu=1}^{M} e^{i\frac{2\pi\mu k}{M}}\,e^{-i\frac{\pi k}{M}}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{-i\frac{\pi k}{M}}\sum_{\mu=1}^{M} e^{\frac{2\pi i \mu k}{M}}
   \quad (\because \text{有限和から }\mu\text{ に依らない因子をくくり出す（分配律）})
\end{aligned}`,
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
        String.raw`\begin{aligned}
e^{-i\frac{\pi k}{M}}
&= e^{-i\frac{\pi l M}{M}}
   \quad (\because k = lM) \\
&= e^{-i\pi l}
   \quad (\because M\ge 2\text{ なので }M\ne0\text{、分数の約分}) \\
&= \cos(\pi l) - i\sin(\pi l)
   \quad (\because \text{euler\_formula\_cos\_sin}) \\
&= (-1)^{l}
   \quad (\because l \in \mathbb{Z} \text{ に対し } \cos(\pi l) = (-1)^l,\ \sin(\pi l) = 0)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`e^{-i\pi l} = \cos(\pi l) - i\sin(\pi l)`),
        " は ",
        ref("euler_formula_cos_sin"),
        " による。）よって和は ",
        math(String.raw`M(-1)^l`),
        "。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "definition",
    origin: { path: SRC, ordinal: 5 },
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
      paragraph([
        "**定義域を ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " としているのは、下の (2)（添字の周期性）を述べるためである。** 主張を述べる添字の範囲は ",
        ref("def_check_index_set"),
        " の ",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
        " に絞る。以降 ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " 全体で述べるのは、この (2) と ",
        ref("periodicity_of_check_fermi"),
        " の 2 つだけである。",
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
        "(1) まず指数の角度を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
M\tilde\theta_\mu
&=2\pi\left(\mu-\tfrac12\right)
&&\bigl(\because\ \tilde\theta_\mu=\tfrac{2\pi}{M}(\mu-\tfrac12)\bigr)\\
&=2\pi\mu-\pi
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)
\end{aligned}`),
      paragraph([
        "この等式と ",
        ref("euler_formula_cos_sin"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-iM\tilde\theta_\mu}
&= e^{-i(2\pi\mu - \pi)}
   \quad (\because M\tilde\theta_\mu = 2\pi\mu - \pi) \\
&= e^{-2\pi i\mu}\,e^{i\pi}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \left(\cos(2\pi\mu) - i\sin(2\pi\mu)\right)\left(\cos\pi + i\sin\pi\right)
   \quad (\because \text{euler\_formula\_cos\_sin}\ \text{を 2 箇所へ同時適用}) \\
&= \left(1 - i\cdot 0\right)\left(-1 + i\cdot 0\right)
   \quad (\because \cos(2\pi\mu)=1,\ \sin(2\pi\mu)=0,\ \cos\pi=-1,\ \sin\pi=0\ (\mu\in\mathbb{Z})) \\
&= 1\cdot(-1)
   \quad (\because i\cdot 0 = 0\ \text{と加法の単位元}) \\
&= -1
   \quad (\because \text{積の単位元})
\end{aligned}`,
      ),
      paragraph([
        "（指数法則は ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " に、三角関数への書き換えは ",
        ref("euler_formula_cos_sin"),
        " による。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`\cos(2\pi\mu) = 1`),
        "、",
        math(String.raw`\sin(2\pi\mu) = 0`),
        "。）",
      ]),
      paragraph([
        "(2) まず添字をずらした角度を計算する。",
      ]),
      displayMath(String.raw`\begin{aligned}
\tilde\theta_{\mu+M}
&=\frac{2\pi\left(\mu+M-\tfrac12\right)}{M}
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義に }\mu+M\text{ を代入}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)+2\pi M}{M}
&&\bigl(\because\ \mathbb R\text{ の分配則}\bigr)\\
&=\frac{2\pi\left(\mu-\tfrac12\right)}{M}+2\pi
&&\bigl(\because\ \mathbb R\text{ の分数の加法と }\tfrac{2\pi M}{M}=2\pi\bigr)\\
&=\tilde\theta_\mu+2\pi
&&\bigl(\because\ \tilde\theta_\mu\text{ の定義}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`j \in \mathbb{Z}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-ij\tilde\theta_{\mu+M}}
&= e^{-ij\left(\tilde\theta_\mu + 2\pi\right)}
   \quad (\because \tilde\theta_{\mu+M}=\tilde\theta_\mu+2\pi) \\
&= e^{-ij\tilde\theta_\mu}\,e^{-2\pi i j}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{-ij\tilde\theta_\mu}\left(\cos(2\pi j) - i\sin(2\pi j)\right)
   \quad (\because \text{euler\_formula\_cos\_sin}) \\
&= e^{-ij\tilde\theta_\mu}
   \quad (\because j \in \mathbb{Z} \text{ より } \cos(2\pi j) = 1,\ \sin(2\pi j) = 0)
\end{aligned}`,
      ),
      paragraph([
        "（ここでも ",
        ref("theorem_exp_product"),
        " と ",
        ref("euler_formula_cos_sin"),
        " を使った。）係数がすべて一致するので、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{\mu+M}
&=\sum_{j=1}^{M}Z_j e^{-ij\tilde\theta_{\mu+M}}
&&\left(\because\ \check{Z}_{\mu+M}\text{ の定義}\right)\\
&=\sum_{j=1}^{M}Z_j e^{-ij\tilde\theta_{\mu}}
&&\left(\because\ \text{上で得た }e^{-ij\tilde\theta_{\mu+M}}=e^{-ij\tilde\theta_\mu}\text{ を全項へ同時適用}\right)\\
&=\check{Z}_{\mu}
&&\left(\because\ \check{Z}_{\mu}\text{ の定義}\right),\\[4pt]
\check{Y}_{\mu+M}
&=\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_{\mu+M}}
&&\left(\because\ \check{Y}_{\mu+M}\text{ の定義}\right)\\
&=\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_{\mu}}
&&\left(\because\ \text{上で得た }e^{-ij\tilde\theta_{\mu+M}}=e^{-ij\tilde\theta_\mu}\text{ を全項へ同時適用}\right)\\
&=\check{Y}_{\mu}
&&\left(\because\ \check{Y}_{\mu}\text{ の定義}\right)
\end{aligned}`,
      ),
      paragraph([
        "(3) 共役添字について、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{1-\mu}
&=\frac{2\pi\left(1-\mu-\frac12\right)}{M}
&&\left(\because\ \tilde\theta_{1-\mu}\text{ の定義}\right)\\
&=\frac{2\pi\left(\frac12-\mu\right)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\frac{2\pi\left(\mu-\frac12\right)}{M}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\tilde\theta_\mu
&&\left(\because\ \tilde\theta_\mu\text{ の定義}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
      ],
    },
  },

  {
    id: "evensector_003a_definition_check_index_set",
    kind: "definition",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{（半整数運動量の添字集合）}` },
    labels: ["def_check_index_set"],
    statement: [
      paragraph([
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        " とし、",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されている）を用いる。",
      ]),
      displayMath(
        String.raw`\check{\mathcal{M}} := \left\{1, 2, \dots, M\right\} \subset \mathbb{Z}`,
      ),
      paragraph([
        "と定める。008 章で整数運動量の添字集合が ",
        ref("def_hatZ_hatY"),
        " の ",
        math(String.raw`\mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`),
        " だったのに対応する、**半整数運動量側の添字集合**である。",
      ]),
      paragraph([
        "**以降、013 章から 017 章までのすべての主張は ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " について述べる。** ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " 全体で述べるのは、記号 ",
        math(String.raw`\tilde\theta_\mu, \check{Z}_\mu, \check{Y}_\mu, \check\psi_\mu`),
        " の**定義域**と、添字の周期性を述べる 2 つの主張 ",
        ref("def_half_integer_modes"),
        " (2) と ",
        ref("periodicity_of_check_fermi"),
        " だけである。これら 2 つは、計算の途中で ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に現れた添字を ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中へ引き戻すための橋渡しなので、",
        math(String.raw`\mathbb{Z}`),
        " で述べる必要がある。",
      ]),
      paragraph(["次の 5 つの性質を後で繰り返し使う。"]),
      list([
        [
          math(
            String.raw`\text{(1) 相異なる } M \text{ 個の運動量：}\quad
\mu, \nu \in \check{\mathcal{M}},\ \mu \neq \nu \implies \tilde\theta_\mu \neq \tilde\theta_\nu,
\qquad 0 < \tilde\theta_\mu < 2\pi`,
          ),
        ],
        [
          math(
            String.raw`\text{(2) 共役添字の閉性：}\quad \mu \in \check{\mathcal{M}} \implies M+1-\mu \in \check{\mathcal{M}}`,
          ),
        ],
        [
          math(
            String.raw`\text{(3) 共役添字の言い換え：}\quad \left(M+1-\mu\right) - \left(1-\mu\right) = M,
\quad \text{すなわち } 1-\mu \equiv M+1-\mu \pmod M`,
          ),
        ],
        [
          math(
            String.raw`\text{(4) 自己共役点：}\quad
\mu \in \check{\mathcal{M}},\ M+1-\mu = \mu
\iff M \text{ が奇数かつ } \mu = \tfrac{M+1}{2}`,
          ),
          "。このとき ",
          math(String.raw`\tilde\theta_\mu = \pi`),
          "。",
        ],
        [
          math(
            String.raw`\text{(5) 対の判定：}\quad
\mu, \nu \in \check{\mathcal{M}} \implies
\left(\mu+\nu \equiv 1 \pmod M \iff \nu = M+1-\mu\right)`,
          ),
          "。したがって ",
          math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
          " では ",
          math(String.raw`\delta^M_{(\mu+\nu,\,1)} = \delta_{\nu,\,M+1-\mu}`),
          " である（右辺は通常のクロネッカーのデルタ、すなわち ",
          math(String.raw`\nu = M+1-\mu`),
          " のとき ",
          math(String.raw`1`),
          "、そうでないとき ",
          math(String.raw`0`),
          "）。",
        ],
      ]),
      paragraph([
        "(5) は、",
        math(String.raw`\check{\mathcal{M}}`),
        " へ範囲を絞ったことで**合同式が消える**ことを述べている。",
        ref("anticommutator_of_check_Z_Y"),
        " 以降で対を指定するのに合同式が要らなくなるのはこのためである。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " より ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\frac12\right)}{M}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_\nu - \tilde\theta_\mu
&= \frac{2\pi\left(\nu-\frac12\right)}{M} - \frac{2\pi\left(\mu-\frac12\right)}{M}
   \quad (\because \text{antiperiodic\_exp\_sum の } \tilde\theta \text{ の定義}) \\
&= \frac{2\pi}{M}\left(\nu - \mu\right)
   \quad (\because \text{通分と分配法則})
\end{aligned}`,
      ),
      paragraph([
        "であり ",
        math(String.raw`\frac{2\pi}{M} > 0`),
        " なので、",
        math(String.raw`\mu \neq \nu`),
        " なら ",
        math(String.raw`\tilde\theta_\mu \neq \tilde\theta_\nu`),
        "。また同じ式は ",
        math(String.raw`\mu \mapsto \tilde\theta_\mu`),
        " が狭義単調増加であることを与えるので、",
        math(String.raw`1 \leq \mu \leq M`),
        " では",
      ]),
      displayMath(
        String.raw`\tilde\theta_1 = \frac{2\pi\cdot\frac12}{M} = \frac{\pi}{M}
\ \leq\ \tilde\theta_\mu \ \leq\
\tilde\theta_M = \frac{2\pi\left(M-\frac12\right)}{M} = 2\pi - \frac{\pi}{M}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`M \geq 2`),
        " より ",
        math(String.raw`0 < \frac{\pi}{M}`),
        " かつ ",
        math(String.raw`2\pi - \frac{\pi}{M} < 2\pi`),
        " なので ",
        math(String.raw`0 < \tilde\theta_\mu < 2\pi`),
        "。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`1 \leq \mu \leq M`),
        " の各辺に ",
        math(String.raw`-1`),
        " を掛けると ",
        math(String.raw`-M \leq -\mu \leq -1`),
        "、さらに ",
        math(String.raw`M+1`),
        " を足すと ",
        math(String.raw`1 \leq M+1-\mu \leq M`),
        "。",
        math(String.raw`M+1-\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        "。",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`(M+1-\mu) - (1-\mu) = M`),
        " は展開するだけである。",
        ref("def_delta_M"),
        " の合同の意味により、差が ",
        math(String.raw`M`),
        " の倍数であることが ",
        math(String.raw`1-\mu \equiv M+1-\mu \pmod M`),
        " である。",
      ]),
      paragraph([
        "(4) ",
        math(String.raw`M+1-\mu = \mu`),
        " は ",
        math(String.raw`M+1 = 2\mu`),
        " と同値であり、これは ",
        math(String.raw`\mu = \frac{M+1}{2}`),
        " と同値である。",
        math(String.raw`\mu \in \mathbb{Z}`),
        " なので ",
        math(String.raw`M+1`),
        " は偶数、すなわち ",
        math(String.raw`M`),
        " は奇数でなければならない。逆に ",
        math(String.raw`M`),
        " が奇数なら ",
        math(String.raw`\frac{M+1}{2} \in \mathbb{Z}`),
        " であり、",
        math(String.raw`M \geq 2`),
        " と併せて ",
        math(String.raw`1 \leq \frac{M+1}{2} \leq M`),
        "（右の不等式は ",
        math(String.raw`M+1 \leq 2M \iff 1 \leq M`),
        "）なので ",
        math(String.raw`\frac{M+1}{2} \in \check{\mathcal{M}}`),
        "。このとき",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{\frac{M+1}{2}}
&= \frac{2\pi\left(\frac{M+1}{2}-\frac12\right)}{M}
   \quad (\because \text{antiperiodic\_exp\_sum の } \tilde\theta \text{ の定義}) \\
&= \frac{2\pi\cdot\frac{M}{2}}{M}
   \quad \left(\because \tfrac{M+1}{2}-\tfrac12 = \tfrac{M}{2}\right) \\
&= \pi
   \quad (\because \text{約分})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`\tilde\theta`),
        " の定義は ",
        ref("antiperiodic_exp_sum"),
        " による。）",
      ]),
      paragraph([
        "(5) ",
        math(String.raw`(\Leftarrow)`),
        " ",
        math(String.raw`\nu = M+1-\mu`),
        " なら ",
        math(String.raw`\mu+\nu = M+1`),
        " なので ",
        math(String.raw`(\mu+\nu) - 1 = M`),
        "、すなわち ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        "。",
      ]),
      paragraph([
        math(String.raw`(\Rightarrow)`),
        " ",
        math(String.raw`1 \leq \mu \leq M`),
        " と ",
        math(String.raw`1 \leq \nu \leq M`),
        " を足すと ",
        math(String.raw`2 \leq \mu+\nu \leq 2M`),
        "、よって ",
        math(String.raw`1 \leq \mu+\nu-1 \leq 2M-1`),
        "。仮定 ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " は ",
        math(String.raw`\mu+\nu-1`),
        " が ",
        math(String.raw`M`),
        " の倍数であることを意味する（",
        ref("def_delta_M"),
        " の合同の意味）。",
      ]),
      paragraph([
        math(String.raw`M`),
        " の倍数 ",
        math(String.raw`lM`),
        "（",
        math(String.raw`l \in \mathbb{Z}`),
        "）が ",
        math(String.raw`1 \leq lM \leq 2M-1`),
        " を満たすのは ",
        math(String.raw`l = 1`),
        " のときに限る（",
        math(String.raw`l \leq 0`),
        " なら ",
        math(String.raw`lM \leq 0 < 1`),
        "、",
        math(String.raw`l \geq 2`),
        " なら ",
        math(String.raw`lM \geq 2M > 2M-1`),
        "）。よって ",
        math(String.raw`\mu+\nu-1 = M`),
        " すなわち ",
        math(String.raw`\nu = M+1-\mu`),
        "。",
      ]),
      paragraph([
        "デルタの等式は、",
        ref("def_delta_M"),
        " より ",
        math(String.raw`\delta^M_{(\mu+\nu,1)} = 1 \iff \mu+\nu \equiv 1 \pmod M`),
        " であり、いま示した同値によりこれが ",
        math(String.raw`\nu = M+1-\mu`),
        " と同値だからである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "𝓜̌ = {1,…,M} はこれ以上減らせない: θ~_μ (μ = 1..M) は (0,2π) 内の相異なる M 個であり ((1))、共役 μ ↦ M+1−μ について閉じている ((2))。008 章の 𝓜 = {−M,…,−1,1,…,M} が μ ↦ −μ について閉じていたのと同じ構造である。",
      ],
    },
  },

  {
    id: "evensector_003b_claim_conjugate_index_of_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`\check{\mathcal{M}} \text{ の内側で共役添字を取る}` },
    labels: ["conjugate_index_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      list([
        [math(String.raw`\text{(1)}\quad \tilde\theta_{M+1-\mu} = 2\pi - \tilde\theta_\mu`)],
        [
          math(
            String.raw`\text{(2)}\quad e^{-ij\tilde\theta_{M+1-\mu}} = e^{ij\tilde\theta_\mu}
\qquad (j \in \mathbb{Z})`,
          ),
        ],
        [
          math(
            String.raw`\text{(3)}\quad \check{Z}_{M+1-\mu} = \check{Z}_{1-\mu},
\qquad \check{Y}_{M+1-\mu} = \check{Y}_{1-\mu}`,
          ),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに (3) により、",
        ref("def_half_integer_modes"),
        " (3) の共役添字 ",
        math(String.raw`1-\mu`),
        "（これは ",
        math(String.raw`\mu \geq 2`),
        " では ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外に出る）を、つねに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の元である ",
        math(String.raw`M+1-\mu`),
        " で置き換えてよい。**013 章から 017 章では以降つねにそうする。**",
      ]),
      paragraph([
        "(2) は ",
        ref("def_half_integer_modes"),
        " (3) の ",
        math(String.raw`\tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
        " が果たしていた役割を、",
        math(String.raw`\check{\mathcal{M}}`),
        " の内側で果たす（位相としては ",
        math(String.raw`\tilde\theta_{M+1-\mu}`),
        " は ",
        math(String.raw`-\tilde\theta_\mu`),
        " と ",
        math(String.raw`2\pi`),
        " しか違わない）。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta`),
        " の定義より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{M+1-\mu}
&= \frac{2\pi\left(M+1-\mu-\frac12\right)}{M}
   \quad (\because \text{antiperiodic\_exp\_sum の } \tilde\theta \text{ の定義}) \\
&= \frac{2\pi\left(M - \left(\mu-\frac12\right)\right)}{M}
   \quad \left(\because M+1-\mu-\tfrac12 = M - \left(\mu-\tfrac12\right)\right) \\
&= 2\pi - \frac{2\pi\left(\mu-\frac12\right)}{M} \\
&= 2\pi - \tilde\theta_\mu
   \quad (\because \text{antiperiodic\_exp\_sum の } \tilde\theta \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`j \in \mathbb{Z}`),
        " について、(1) と指数法則より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-ij\tilde\theta_{M+1-\mu}}
&= e^{-ij\left(2\pi - \tilde\theta_\mu\right)}
   \quad (\because \text{直前の (1)}) \\
&= e^{-2\pi i j}\,e^{ij\tilde\theta_\mu}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \left(\cos(2\pi j) - i\sin(2\pi j)\right)e^{ij\tilde\theta_\mu}
   \quad (\because \text{euler\_formula\_cos\_sin}) \\
&= e^{ij\tilde\theta_\mu}
   \quad (\because j \in \mathbb{Z} \text{ より } \cos(2\pi j) = 1,\ \sin(2\pi j) = 0)
\end{aligned}`,
      ),
      paragraph([
        "（指数法則は ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " すなわち ",
        math(String.raw`\mathrm{Mat}(1,\mathbb{C}) = \mathbb{C}`),
        " に適用したもの、三角関数への書き換えは ",
        ref("euler_formula_cos_sin"),
        " による。）",
      ]),
      paragraph([
        "(3) ",
        ref("def_half_integer_modes"),
        " (2)（添字の周期性）を添字 ",
        math(String.raw`1-\mu \in \mathbb{Z}`),
        " に適用すると ",
        math(String.raw`\check{Z}_{(1-\mu)+M} = \check{Z}_{1-\mu}`),
        " であり、",
        math(String.raw`(1-\mu)+M = M+1-\mu`),
        " なので ",
        math(String.raw`\check{Z}_{M+1-\mu} = \check{Z}_{1-\mu}`),
        "。",
        math(String.raw`\check{Y}`),
        " についても同じである。",
      ]),
      paragraph([
        "（ここで ",
        ref("def_half_integer_modes"),
        " (2) を ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字 ",
        math(String.raw`1-\mu`),
        " に適用している。",
        ref("def_check_index_set"),
        " が述べたとおり、この主張を ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " で残してあるのはまさにこの橋渡しのためである。）",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_004_claim_commutator_H_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ と } \check{Z}, \check{Y} \text{ の交換関係}` },
    labels: ["commutator_of_H_and_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について（",
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
        String.raw`\begin{aligned}
\left[Z_jY_j,\ Y_j\right]
&= \left(Z_jY_j\right)Y_j - Y_j\left(Z_jY_j\right)
   \quad (\because \text{交換子の定義}) \\
&= Z_j\left(Y_jY_j\right) - \left(Y_jZ_j\right)Y_j
   \quad (\because \text{行列の積の結合法則}) \\
&= Z_j\,I - \left(Y_jZ_j\right)Y_j
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_jY_j = I)) \\
&= Z_j - \left(-Z_jY_j\right)Y_j
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_jZ_j = -Z_jY_j)) \\
&= Z_j + Z_j\left(Y_jY_j\right)
   \quad (\because \text{結合法則とスカラー倍}) \\
&= Z_j + Z_j\,I
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_jY_j = I)) \\
&= Z_j + Z_j
   \quad (\because \text{単位行列の性質 } Z_j\,I = Z_j) \\
&= 2Z_j
   \quad (\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`Y_jY_j = I`),
        " と ",
        math(String.raw`Y_jZ_j = -Z_jY_j`),
        " はいずれも ",
        ref("anticommutator_of_Z_and_Y"),
        " による。）",
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
        String.raw`\begin{aligned}
\left[Y_mZ_{m+1},\ Z_{m+1}\right]
&= \left(Y_mZ_{m+1}\right)Z_{m+1} - Z_{m+1}\left(Y_mZ_{m+1}\right)
   \quad (\because \text{交換子の定義}) \\
&= Y_m\left(Z_{m+1}Z_{m+1}\right) - \left(Z_{m+1}Y_m\right)Z_{m+1}
   \quad (\because \text{行列の積の結合法則}) \\
&= Y_m\,I - \left(Z_{m+1}Y_m\right)Z_{m+1}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_{m+1}Z_{m+1} = I)) \\
&= Y_m - \left(-Y_mZ_{m+1}\right)Z_{m+1}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_{m+1}Y_m = -Y_mZ_{m+1})) \\
&= Y_m + Y_m\left(Z_{m+1}Z_{m+1}\right)
   \quad (\because \text{結合法則とスカラー倍}) \\
&= Y_m + Y_m\,I
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_{m+1}Z_{m+1} = I)) \\
&= Y_m + Y_m
   \quad (\because \text{単位行列の性質 } Y_m\,I = Y_m) \\
&= 2Y_m
   \quad (\because \text{同類項をまとめる})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`Z_{m+1}Z_{m+1} = I`),
        " と ",
        math(String.raw`Z_{m+1}Y_m = -Y_mZ_{m+1}`),
        " はいずれも ",
        ref("anticommutator_of_Z_and_Y"),
        " による。）したがって ",
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
        String.raw`\begin{aligned}
\left[-Y_MZ_1,\ Z_1\right]
&= -\left[Y_MZ_1,\ Z_1\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_MZ_1\right)Z_1 - Z_1\left(Y_MZ_1\right)\right)
   \quad (\because \text{交換子の定義}) \\
&= -\left(Y_M\left(Z_1Z_1\right) - \left(Z_1Y_M\right)Z_1\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= -\left(Y_M\,I - \left(Z_1Y_M\right)Z_1\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_M - \left(-Y_MZ_1\right)Z_1\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_1Y_M = -Y_MZ_1)) \\
&= -\left(Y_M + Y_M\left(Z_1Z_1\right)\right)
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -\left(Y_M + Y_M\,I\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_1Z_1 = I)) \\
&= -\left(Y_M + Y_M\right)
   \quad (\because \text{単位行列の性質 } Y_M\,I = Y_M) \\
&= -2Y_M
   \quad (\because \text{同類項をまとめる}) \\
&= 2\left(-Y_M\right)
   \quad (\because \text{スカラー倍の符号の整理 } -2Y_M = 2(-Y_M)) \\
&= 2\,Y_0^{\flat}
   \quad (\because Y_0^{\flat} := -Y_M)
\end{aligned}`,
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
        String.raw`\begin{aligned}
\left[Y_mZ_{m+1},\ Y_m\right]
&= \left(Y_mZ_{m+1}\right)Y_m - Y_m\left(Y_mZ_{m+1}\right)
   \quad (\because \text{交換子の定義}) \\
&= Y_m\left(Z_{m+1}Y_m\right) - \left(Y_mY_m\right)Z_{m+1}
   \quad (\because \text{行列の積の結合法則}) \\
&= Y_m\left(-Y_mZ_{m+1}\right) - \left(Y_mY_m\right)Z_{m+1}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_{m+1}Y_m = -Y_mZ_{m+1})) \\
&= -\left(Y_mY_m\right)Z_{m+1} - \left(Y_mY_m\right)Z_{m+1}
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -I\,Z_{m+1} - I\,Z_{m+1}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_mY_m = I)) \\
&= -2Z_{m+1}
   \quad (\because \text{単位行列の性質 } I\,Z_{m+1} = Z_{m+1}\text{ と同類項をまとめる})
\end{aligned}`,
      ),
      paragraph([
        "（用いた関係式はいずれも ",
        ref("anticommutator_of_Z_and_Y"),
        " による。）なので ",
        math(String.raw`1 \leq j \leq M-1`),
        " では ",
        math(String.raw`[H_1^{(+)}, Y_j] = -2Z_{j+1}`),
        "。",
        math(String.raw`j = M`),
        " では境界項だけが残り",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[-Y_MZ_1,\ Y_M\right]
&= -\left[Y_MZ_1,\ Y_M\right]
   \quad (\because \text{交換子の第 1 引数についての } \mathbb{C} \text{ 線型性}) \\
&= -\left(\left(Y_MZ_1\right)Y_M - Y_M\left(Y_MZ_1\right)\right)
   \quad (\because \text{交換子の定義}) \\
&= -\left(Y_M\left(Z_1Y_M\right) - \left(Y_MY_M\right)Z_1\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= -\left(Y_M\left(-Y_MZ_1\right) - \left(Y_MY_M\right)Z_1\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Z_1Y_M = -Y_MZ_1)) \\
&= -\left(-\left(Y_MY_M\right)Z_1 - \left(Y_MY_M\right)Z_1\right)
   \quad (\because \text{結合法則とスカラー倍}) \\
&= -\left(-I\,Z_1 - I\,Z_1\right)
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}\ (Y_MY_M = I)) \\
&= -\left(-Z_1 - Z_1\right)
   \quad (\because \text{単位行列の性質 } I\,Z_1 = Z_1) \\
&= -\left(-2Z_1\right)
   \quad (\because \text{同類項をまとめる}) \\
&= 2Z_1
   \quad (\because \text{スカラー倍の符号の整理 } -(-2Z_1) = 2Z_1) \\
&= -2\left(-Z_1\right)
   \quad (\because \text{スカラー倍の符号の整理 } 2Z_1 = -2(-Z_1)) \\
&= -2\,Z_{M+1}^{\flat}
   \quad (\because Z_{M+1}^{\flat} := -Z_1)
\end{aligned}`,
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
        String.raw`\begin{aligned}
\left[H_2,\ \check{Z}_\mu\right]
&= \left[H_2,\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j\right]
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_2,\ Z_j\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left(-2Y_j\right)
   \quad (\because \text{Step 1 の第 1 式}) \\
&= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j \\
&= -2\,\check{Y}_\mu
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        "（最初と最後の等号は ",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の定義による。）Step 1 の第 2 式 ",
        math(String.raw`[H_2, Y_j] = 2Z_j`),
        " からも、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_2,\ \check{Y}_\mu\right]
&= \left[H_2,\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j\right]
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_2,\ Y_j\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\cdot 2Z_j
   \quad (\because \text{Step 1 の第 2 式}) \\
&= 2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j
   \quad (\because \text{スカラー倍を和の外へ出す}) \\
&= 2\,\check{Z}_\mu
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        "を得る。",
      ]),
      paragraph([
        "Step 3（(A)）。主計算に先立ち、添字を ",
        math(String.raw`l := j-1`),
        " と置き換える（",
        math(String.raw`j = 1,\dots,M`),
        " が ",
        math(String.raw`l = 0,\dots,M-1`),
        " に 1 対 1 で対応する）。また、",
        ref("def_half_integer_modes"),
        " (1) の ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " と ",
        math(String.raw`Y_0^{\flat} = -Y_M`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-i\cdot 0\cdot\tilde\theta_\mu}\,Y_0^{\flat}
&= 1\cdot Y_0^{\flat}
   \quad (\because e^0=1) \\
&= 1\cdot\left(-Y_M\right)
   \quad (\because Y_0^{\flat} := -Y_M) \\
&= \left(-1\right)Y_M
   \quad (\because \mathbb{C}\text{ の四則}) \\
&= e^{-iM\tilde\theta_\mu}\,Y_M
   \quad (\because \text{def\_half\_integer\_modes (1)}) \\
&= e^{-iM\tilde\theta_\mu}\,Y_M^{\flat}
   \quad (\because Y_M^{\flat} := Y_M\ (1 \leq M \leq M))
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 3 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Z}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j\right]
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_1^{(+)},\ Z_j\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\cdot 2\,Y_{j-1}^{\flat}
   \quad (\because \text{Step 1 の第 3 式}) \\
&= 2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Y_{j-1}^{\flat}
   \quad (\because \text{スカラー倍を和の外へ出す}) \\
&= 2\sum_{l=0}^{M-1} e^{-i(l+1)\tilde\theta_\mu}\,Y_l^{\flat}
   \quad (\because \text{有限和の添字の付け替え } l=j-1) \\
&= 2\sum_{l=0}^{M-1} e^{-i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=0}^{M-1} e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   \quad (\because \text{分配則}) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Y_l^{\flat}
   \quad (\because \text{直前の displayMath による } l=0 \text{ の項と } l=M \text{ の項の入れ替え}) \\
&= 2\,e^{-i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Y_l
   \quad (\because 1 \leq l \leq M \text{ では } Y_l^{\flat} = Y_l) \\
&= 2\,e^{-i\tilde\theta_\mu}\,\check{Y}_\mu
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        "ここで指数法則は ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " に適用し、最初と最後の等号は ",
        ref("def_half_integer_modes"),
        " の定義を使った。",
      ]),
      paragraph([
        "Step 4（(B)）。主計算に先立ち、添字を ",
        math(String.raw`l := j+1`),
        " と置き換える（",
        math(String.raw`j = 1,\dots,M`),
        " が ",
        math(String.raw`l = 2,\dots,M+1`),
        " に 1 対 1 で対応する）。また、",
        ref("def_half_integer_modes"),
        " (1) の ",
        math(String.raw`e^{-iM\tilde\theta_\mu} = -1`),
        " と ",
        math(String.raw`Z_{M+1}^{\flat} = -Z_1`),
        " より、境界の二項は一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
e^{-i(M+1)\tilde\theta_\mu}\,Z_{M+1}^{\flat}
&= e^{-iM\tilde\theta_\mu}\,e^{-i\tilde\theta_\mu}\,Z_{M+1}^{\flat}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{-iM\tilde\theta_\mu}\,e^{-i\tilde\theta_\mu}\left(-Z_1\right)
   \quad (\because Z_{M+1}^{\flat} := -Z_1) \\
&= \left(-1\right)e^{-i\tilde\theta_\mu}\left(-Z_1\right)
   \quad (\because \text{def\_half\_integer\_modes (1)}) \\
&= e^{-i\tilde\theta_\mu}\,Z_1
   \quad (\because \mathbb{C}\text{ の四則}) \\
&= e^{-i\cdot 1\cdot\tilde\theta_\mu}\,Z_1^{\flat}
   \quad (\because Z_1^{\flat} := Z_1)
\end{aligned}`,
      ),
      paragraph([
        "となる。この境界項の等式と Step 1 の第 4 式、交換子の線型性を使うと、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[H_1^{(+)},\ \check{Y}_\mu\right]
&= \left[H_1^{(+)},\ \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Y_j\right]
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left[H_1^{(+)},\ Y_j\right]
   \quad (\because \text{交換子の第 2 引数についての } \mathbb{C} \text{ 線型性}) \\
&= \sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\left(-2\,Z_{j+1}^{\flat}\right)
   \quad (\because \text{Step 1 の第 4 式}) \\
&= -2\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,Z_{j+1}^{\flat}
   \quad (\because \text{スカラー倍を和の外へ出す}) \\
&= -2\sum_{l=2}^{M+1} e^{-i(l-1)\tilde\theta_\mu}\,Z_{l}^{\flat}
   \quad (\because \text{有限和の添字の付け替え } l = j+1) \\
&= -2\sum_{l=2}^{M+1} e^{i\tilde\theta_\mu}e^{-il\tilde\theta_\mu}\,Z_{l}^{\flat}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=2}^{M+1} e^{-il\tilde\theta_\mu}\,Z_l^{\flat}
   \quad (\because \text{分配則}) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Z_l^{\flat}
   \quad (\because \text{直前の displayMath による } l=M+1 \text{ の項と } l=1 \text{ の項の入れ替え}) \\
&= -2\,e^{i\tilde\theta_\mu}\sum_{l=1}^{M} e^{-il\tilde\theta_\mu}\,Z_l
   \quad (\because 1 \leq l \leq M \text{ では } Z_l^{\flat} = Z_l) \\
&= -2\,e^{i\tilde\theta_\mu}\,\check{Z}_\mu
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        "ここで指数法則は ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " に適用し、最初と最後の等号は ",
        ref("def_half_integer_modes"),
        " の定義を使った。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "(A)(B) が成り立つ仕組みは反周期性 e^{-iM θ~_μ} = -1 である。整数運動量では e^{-iM θ_μ} = +1 なので、同じ計算をすると境界項の符号が合わず H_1^{(-)} 側でしか閉じない。ここが (+) と (-) を分ける唯一の点である。",
        "M=2,3,4,5 の全 μ について数値で確認済み（sagemath/check/046_claim_even_sector_modes/check_02_commutators.sage）。",
        "2026-08-15 の式変形統一で、三つの鎖の最終行（= 2Z_j・= 2Y_m・= 2(−Y_M)）に欠けていた行末根拠を補い、単位行列の消去と同類項の統合の圧縮を開いた。内容は変えていない。",
        "2026-08-19 の式変形統一で、境界項二本の鎖にあった「直前の displayMath と同じ計算」の一行を、(Y_M, Z_1) に対する交換子の定義・結合法則・anticommutator_of_Z_and_Y・単位行列・同類項の一操作ずつの行へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ の反交換関係}` },
    labels: ["anticommutator_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について",
      ]),
      displayMath(
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M\,\delta_{\nu,\,M+1-\mu}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M\,\delta_{\nu,\,M+1-\mu}\,I`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M+1-\mu}`),
        " は通常のクロネッカーのデルタ（",
        math(String.raw`\nu = M+1-\mu`),
        " のとき ",
        math(String.raw`1`),
        "、そうでないとき ",
        math(String.raw`0`),
        "）である。",
      ]),
      paragraph([
        "**対になる添字に合同式が現れない**のは、添字の範囲を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ったからである：",
        ref("def_check_index_set"),
        " (5) により ",
        math(String.raw`\mu,\nu \in \check{\mathcal{M}}`),
        " では ",
        math(String.raw`\mu+\nu \equiv 1 \pmod M`),
        " と ",
        math(String.raw`\nu = M+1-\mu`),
        " が同値である。",
      ]),
      paragraph([
        ref("anticommutator_of_hat_Z_and_hat_Y"),
        " では対になる添字が ",
        math(String.raw`\nu = -\mu`),
        " だったのに対し、ここでは ",
        math(String.raw`\nu = M+1-\mu`),
        " である。これは ",
        ref("conjugate_index_of_check_Z_Y"),
        " の共役添字が ",
        math(String.raw`-\mu`),
        " ではなく ",
        math(String.raw`M+1-\mu`),
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
        "、",
        ref("anticommutator_of_Z_and_Y"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("exp_sum"),
        "、",
        ref("def_delta_M"),
        "、",
        ref("def_check_index_set"),
        " (5) を順に使うと、第 1 式は主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu, \check{Z}_\nu\right]_+
&= \left[\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}Z_j,\ \sum_{k=1}^{M} e^{-ik\tilde\theta_\nu}Z_k\right]_+
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ik\tilde\theta_\nu}
   \left[Z_j, Z_k\right]_+
   \quad (\because \text{反交換子の } \mathbb{C} \text{ 双線型性}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ik\tilde\theta_\nu}\cdot 2I\,\delta^M_{(j,k)}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}) \\
&= 2I\sum_{j=1}^{M} e^{-ij\tilde\theta_\mu}\,e^{-ij\tilde\theta_\nu}
   \quad (\because 1 \leq j,k \leq M \text{ では } \delta^M_{(j,k)} = 1 \iff j = k) \\
&= 2I\sum_{j=1}^{M} e^{-ij\left(\tilde\theta_\mu + \tilde\theta_\nu\right)}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= 2I\sum_{j=1}^{M} \exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M}\right)
   \quad \left(\because \tilde\theta_\mu + \tilde\theta_\nu = \tfrac{2\pi(\mu+\nu-1)}{M}\right) \\
&= 2M I\,\delta^M_{(-(\mu+\nu-1),\,0)}
   \quad (\because \text{exp\_sum}) \\
&= 2M I\,\delta^M_{(\mu+\nu,\,1)}
   \quad (\because \text{def\_delta\_M}) \\
&= 2M\,\delta_{\nu,\,M+1-\mu}\,I
   \quad (\because \text{def\_check\_index\_set (5)}\ (\mu,\nu \in \check{\mathcal{M}}))
\end{aligned}`,
      ),
      paragraph([
        "第 2 式は、",
        ref("def_half_integer_modes"),
        " と ",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Z_j,Y_k]_+=0`),
        " を使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Z_j,\ \sum_{k=1}^{M}e^{-ik\tilde\theta_\nu}Y_k\right]_+
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}[Z_j,Y_k]_+
   \quad (\because \text{反交換子の }\mathbb{C}\text{ 双線型性}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}\cdot 0
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}) \\
&= 0
   \quad (\because \mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "第 3 式も、",
        ref("def_half_integer_modes"),
        "、",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Y_j,Y_k]_+ = 2I\,\delta^M_{(j,k)}`),
        " と、第 1 式で使った ",
        ref("theorem_exp_product"),
        "、",
        ref("exp_sum"),
        "、",
        ref("def_delta_M"),
        "、",
        ref("def_check_index_set"),
        " (5) を順に使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Y}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}Y_j,\ \sum_{k=1}^{M}e^{-ik\tilde\theta_\nu}Y_k\right]_+
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}[Y_j,Y_k]_+
   \quad (\because \text{反交換子の }\mathbb{C}\text{ 双線型性}) \\
&= \sum_{j=1}^{M}\sum_{k=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ik\tilde\theta_\nu}\cdot 2I\,\delta^M_{(j,k)}
   \quad (\because \text{anticommutator\_of\_Z\_and\_Y}) \\
&= 2I\sum_{j=1}^{M}e^{-ij\tilde\theta_\mu}e^{-ij\tilde\theta_\nu}
   \quad (\because 1\le j,k\le M\text{ では }\delta^M_{(j,k)}=1\iff j=k) \\
&= 2I\sum_{j=1}^{M}e^{-ij(\tilde\theta_\mu+\tilde\theta_\nu)}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= 2I\sum_{j=1}^{M}\exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M}\right)
   \quad \left(\because \tilde\theta_\mu+\tilde\theta_\nu=\tfrac{2\pi(\mu+\nu-1)}{M}\right) \\
&= 2M I\,\delta^M_{(-(\mu+\nu-1),\,0)}
   \quad (\because \text{exp\_sum}) \\
&= 2M I\,\delta^M_{(\mu+\nu,\,1)}
   \quad (\because \text{def\_delta\_M}) \\
&= 2M\,\delta_{\nu,\,M+1-\mu}\,I
   \quad (\because \text{def\_check\_index\_set (5)}\ (\mu,\nu\in\check{\mathcal M}))
\end{aligned}`,
      ),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
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
        "準備として、",
        math(String.raw`j, k \in \{1,\dots,M\}`),
        " のとき ",
        math(String.raw`|j-k| \leq M-1 < M`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " を指数の整数 ",
        math(String.raw`j-k`),
        " に適用すると（",
        math(String.raw`j = k`),
        " のときは ",
        math(String.raw`j-k = 0 = 0 \cdot M`),
        " で ",
        math(String.raw`(-1)^0 = 1`),
        "、",
        math(String.raw`j \neq k`),
        " のときは ",
        math(String.raw`|j-k| < M`),
        " かつ ",
        math(String.raw`j-k \neq 0`),
        " なので ",
        math(String.raw`j-k \not\equiv 0 \pmod M`),
        "）",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
= \begin{cases}
M & (j = k) \\
0 & (j \neq k)
\end{cases}`,
      ),
      paragraph([
        "である。第 1 式は、",
        ref("def_half_integer_modes"),
        " と ",
        ref("theorem_exp_product"),
        " と準備の等式を順に使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_\mu\,e^{ij\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_\mu}\right)e^{ij\tilde\theta_\mu}
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_\mu}\,e^{ij\tilde\theta_\mu}
   \quad (\because \text{有限和への分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Z_k\,e^{i(j-k)\tilde\theta_\mu}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M} Z_k \sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
   \quad (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\cdot Z_j\cdot M
   \quad (\because \text{準備の等式により } k = j \text{ の項だけが残る}) \\
&= Z_j
   \quad (\because M\ne 0\text{ なのでスカラー }\tfrac{1}{M}\text{ と }M\text{ が相殺する})
\end{aligned}`,
      ),
      paragraph([
        "第 2 式も、",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\check{Y}_\mu`),
        " の定義から同じ根拠の並びで、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\,e^{ij\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M} Y_k\,e^{-ik\tilde\theta_\mu}\right)e^{ij\tilde\theta_\mu}
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Y_k\,e^{-ik\tilde\theta_\mu}\,e^{ij\tilde\theta_\mu}
   \quad (\because \text{有限和への分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M} Y_k\,e^{i(j-k)\tilde\theta_\mu}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M} Y_k \sum_{\mu=1}^{M} e^{i(j-k)\tilde\theta_\mu}
   \quad (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\cdot Y_j\cdot M
   \quad (\because \text{準備の等式により } k = j \text{ の項だけが残る}) \\
&= Y_j
   \quad (\because M\ne 0\text{ なのでスカラー }\tfrac{1}{M}\text{ と }M\text{ が相殺する})
\end{aligned}`,
      ),
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
    conversion: {
      status: "added",
      notes: [
        "2026-08-15 の式変形統一で、復元式の鎖の最終行へスカラー 1/M と M の相殺という行末根拠を補った。内容は変えていない。",
        "2026-08-19 の式変形統一で、二つの displayMath と間の散文に分かれていた復元式の導出を、準備の指数和等式と一続き六段の鎖へまとめ、「Y_j についても同じ計算」と畳まれていた第 2 式を同じ形の鎖へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "evensector_007_claim_H1_H2_via_check_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`H_1^{(+)}, H_2 \text{ を } \check{Z}, \check{Y} \text{ で表す}` },
    labels: ["H1_H2_via_check_Z_Y"],
    statement: [
      displayMath(
        String.raw`H_1^{(+)} = \frac{1}{M}\sum_{\mu=1}^{M} \check{Y}_\mu\,\check{Z}_{M+1-\mu}\,e^{-i\tilde\theta_\mu},
\qquad
H_2 = \frac{1}{M}\sum_{\mu=1}^{M} \check{Z}_{M+1-\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        ref("H1_H2_via_hatZ_hatY"),
        " の半整数運動量版。共役添字が ",
        math(String.raw`-\mu`),
        " から ",
        math(String.raw`M+1-\mu`),
        " に変わっている）。和の添字 ",
        math(String.raw`\mu`),
        " も共役添字 ",
        math(String.raw`M+1-\mu`),
        " も ",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまる。",
      ]),
    ],
    proof: [
      paragraph([
        "まず ",
        ref("def_half_integer_modes"),
        " と ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) から ",
        math(String.raw`\check{Z}_{M+1-\mu}`),
        " の表示を用意する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M+1-\mu}
&= \sum_{k=1}^{M} Z_k\,e^{-ik\tilde\theta_{M+1-\mu}}
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{k=1}^{M} Z_k\,e^{ik\tilde\theta_\mu}
   \quad (\because \text{conjugate\_index\_of\_check\_Z\_Y (2)})
\end{aligned}`,
      ),
      paragraph([
        "次に ",
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
        " である。これと ",
        ref("def_half_integer_modes"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_transfer_matrix_symbols"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Z}_{M+1-\mu}\check{Y}_\mu
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right)
   \left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right)
   \quad (\because \text{準備した }\check Z_{M+1-\mu}\text{ の表示と def\_half\_integer\_modes}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j\,
   e^{ik\tilde\theta_\mu}e^{-ij\tilde\theta_\mu}
   \quad (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j\,
   e^{i(k-j)\tilde\theta_\mu}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{k=1}^{M}\sum_{j=1}^{M} Z_kY_j
   \sum_{\mu=1}^{M} e^{i(k-j)\tilde\theta_\mu}
   \quad (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\sum_{j=1}^{M} Z_jY_j\cdot M
   \quad (\because \text{antiperiodic\_exp\_sum}) \\
&= \sum_{j=1}^{M} Z_jY_j
   \quad (\because \text{スカラー } \tfrac{1}{M} \text{ と } M \text{ の相殺}) \\
&= H_2
   \quad (\because \text{def\_transfer\_matrix\_symbols})
\end{aligned}`,
      ),
      paragraph([
        "もう一方の式の準備として、",
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
      paragraph([
        "したがって、",
        ref("def_half_integer_modes"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_V1_pm"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M}\sum_{\mu=1}^{M}\check{Y}_\mu\check{Z}_{M+1-\mu}e^{-i\tilde\theta_\mu}
&= \frac{1}{M}\sum_{\mu=1}^{M}\left(\sum_{j=1}^{M}Y_j e^{-ij\tilde\theta_\mu}\right)
   \left(\sum_{k=1}^{M}Z_k e^{ik\tilde\theta_\mu}\right) e^{-i\tilde\theta_\mu}
   \quad (\because \text{def\_half\_integer\_modes と準備した } \check{Z}_{M+1-\mu} \text{ の表示}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k\,
   e^{-ij\tilde\theta_\mu}e^{ik\tilde\theta_\mu}e^{-i\tilde\theta_\mu}
   \quad (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M}\sum_{\mu=1}^{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k\,
   e^{-i(j-k+1)\tilde\theta_\mu}
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= \frac{1}{M}\sum_{j=1}^{M}\sum_{k=1}^{M} Y_jZ_k
   \sum_{\mu=1}^{M} e^{-i(j-k+1)\tilde\theta_\mu}
   \quad (\because \text{有限和の順序交換}) \\
&= \frac{1}{M}\left(\sum_{j=1}^{M-1} Y_jZ_{j+1}\cdot M + Y_MZ_1\cdot(-M)\right)
   \quad (\because \text{antiperiodic\_exp\_sum と直上の 2 つの場合分け}) \\
&= \sum_{j=1}^{M-1} Y_jZ_{j+1} - Y_MZ_1
   \quad (\because \text{スカラー } \tfrac{1}{M} \text{ の分配と } \tfrac{1}{M}\cdot M = 1,\ \tfrac{1}{M}\cdot(-M) = -1 \text{ の相殺}) \\
&= H_1^{(+)}
   \quad (\because \text{def\_V1\_pm})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "境界項 -Y_M Z_1 の符号が、antiperiodic_exp_sum の l=1 の因子 (-1)^1 として自動的に出てくる。整数運動量版 H1_H2_via_hatZ_hatY で hat(Z)^{(±)} の第 1 項の符号が担っていた役割を、ここでは指数和の符号が担っている。",
        "2026-08-19 の式変形統一で、H_2 と H_1^{(+)} の導出を分断していた説明・重複した参照を準備へ移し、それぞれ主張の右辺から H_2・H_1^{(+)} へ至る一続きの鎖へまとめた。内容・参照は変えていない。",
      ],
    },
  },
]);
