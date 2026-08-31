import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/014_even_sector_T_action.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_T_action",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { text: "偶セクターの転送行列の共役作用" },
    labels: [],
  },

  {
    id: "evensectorT_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的と、008 章との関係" },
    labels: [],
    statement: [
      paragraph([
        ref("commutator_of_H_and_check_Z_Y"),
        " で、半整数運動量モード ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " が ",
        math(String.raw`H_1^{(+)}, H_2`),
        " に対して満たす交換関係 (A)〜(D) を得た。この章では、そこから",
      ]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\ \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right),
\qquad
A\!\left(\tilde\theta_\mu\right) = B_1\!\left(\tilde\theta_\mu\right) B_2 B_1\!\left(\tilde\theta_\mu\right)`,
      ),
      paragraph([
        "まで到達する。ここで ",
        math(String.raw`V^{(+)} := \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}`),
        " であり、",
        math(String.raw`A(\theta)`),
        " は ",
        ref("def_A_theta"),
        " の（",
        math(String.raw`\theta \in \mathbb{C}`),
        " について定義された）行列である。",
      ]),
      paragraph([
        "**008 章との関係。** 008 章は同じ道筋を整数運動量 ",
        math(String.raw`\theta_\mu = 2\pi\mu/M`),
        " と ",
        math(String.raw`\hat{Z}_\mu^{(-)}, \hat{Y}_\mu`),
        " について辿っている。",
        ref("why_008_applies_only_to_minus_sector"),
        " で確定させたとおり 008 章の議論は ",
        math(String.raw`(-)`),
        " セクター専用なので、そこで扱われている ",
        math(String.raw`V`),
        " は実質 ",
        math(String.raw`\left(V_1^{(-)}\right)^{1/2} V_2 \left(V_1^{(-)}\right)^{1/2}`),
        " である。混同を避けるため、この章では ",
        math(String.raw`V^{(+)}, T_{(V^{(+)})}`),
        " という別の記号を用い、必要な主張はすべてこの章で立て直す。",
      ]),
      paragraph([
        "**同じ代数計算で通る理由。** 008 章の ",
        ref("nesting_of_commutator_of_H_and_Z"),
        " から ",
        ref("T_V_hatZ_hatY"),
        " までの各証明は、1 重の交換子の公式 (A)〜(D) と、交換子の双線型性・指数関数の共役の級数展開・",
        math(String.raw`e^{i\theta}e^{-i\theta} = 1`),
        " だけを使っており、",
        math(String.raw`\theta_\mu`),
        " に固有の性質（",
        math(String.raw`e^{-iM\theta_\mu} = +1`),
        "、添字集合 ",
        math(String.raw`\mathcal{M}`),
        " の形、",
        ref("hatZ_hatY_M_periodicity"),
        " の ",
        math(String.raw`M`),
        " 周期性）を使っていない。",
        math(String.raw`\theta_\mu`),
        " に固有の性質が使われていたのは 1 重の交換子 (A)〜(D) を導く段階（",
        ref("commutator_of_H_and_Z_Y"),
        "）だけであり、そこは ",
        ref("commutator_of_H_and_check_Z_Y"),
        " が半整数運動量について独立に済ませてある。",
        "したがってこの章の各主張は、008 章の対応する証明と同じ代数計算を ",
        math(String.raw`\tilde\theta_\mu, \check{Z}_\mu, \check{Y}_\mu`),
        " について繰り返すことで得られる。",
      ]),
      paragraph([
        "**添字の量化について。** ",
        ref("def_half_integer_modes"),
        " は ",
        math(String.raw`\mu \in \mathbb{Z}`),
        " について定義されているが、",
        ref("def_half_integer_modes"),
        " (2) の添字周期性 ",
        math(String.raw`\check{Z}_{\mu+M} = \check{Z}_\mu`),
        " により本質的に相異なる添字は ",
        math(String.raw`M`),
        " 個である。**この章の主張はすべて ",
        ref("def_check_index_set"),
        " の ",
        math(String.raw`\mu \in \check{\mathcal{M}} = \{1,\dots,M\}`),
        " について述べる。** これは 008 章の ",
        math(String.raw`\mathcal{M} = \{-M,\dots,-1,1,\dots,M\}`),
        " に対応する、半整数運動量側の必要最小の有限集合である。",
      ]),
    ],
    conversion: { status: "added" },
  },

  {
    id: "evensectorT_001_definition_V_plus",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`V^{(+)} \text{ と } T_{(V^{(+)})} \text{ の定義}` },
    labels: ["def_V_plus_and_T_V_plus"],
    statement: [
      paragraph([
        ref("def_V1_pm"),
        " の ",
        math(String.raw`V_1^{(\pm)}`),
        " で上の符号を取ったもの、すなわち",
      ]),
      displayMath(
        String.raw`V_1^{(+)} := \exp\!\left(i K_1 H_1^{(+)}\right),
\qquad H_1^{(+)} = Y_1Z_2 + Y_2Z_3 + \cdots + Y_{M-1}Z_M - Y_MZ_1`,
      ),
      paragraph([
        "について、その ",
        math(String.raw`1/2`),
        " 乗を",
      ]),
      displayMath(
        String.raw`\left(V_1^{(+)}\right)^{1/2} := \exp\!\left(\tfrac{i}{2} K_1 H_1^{(+)}\right)
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める。さらに ",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(iK_2^* H_2\right)`),
        " を用いて",
      ]),
      displayMath(
        String.raw`V^{(+)} := \left(V_1^{(+)}\right)^{1/2} V_2 \left(V_1^{(+)}\right)^{1/2}
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定め、",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g(X) = gXg^{-1}`),
        " を用いて",
      ]),
      displayMath(
        String.raw`T_{(V^{(+)})}(X) := T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
T_{V_2}\!\left(T_{\left(V_1^{(+)}\right)^{1/2}}(X)\right)\right)
\qquad \left(X \in \mathrm{Mat}(2^M,\mathbb{C})\right)`,
      ),
      paragraph([
        "と定める。この定義が意味をもつために必要な事実として、次が成り立つ。",
      ]),
      list([
        [
          "(1) ",
          math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
          "、",
          math(String.raw`V_2`),
          "、",
          math(String.raw`V^{(+)}`),
          " はいずれも可逆（",
          ref("def_invertible_elements_of_R"),
          " の意味で ",
          math(String.raw`R^\times`),
          " の元）であり、したがって ",
          math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2}, T_{V^{(+)}}`),
          " が定義できる。",
        ],
        [
          "(2) ",
          math(String.raw`\left(V_1^{(+)}\right)^{1/2}`),
          " は名前のとおり ",
          math(String.raw`V_1^{(+)}`),
          " の平方根である：",
          math(String.raw`\left(\left(V_1^{(+)}\right)^{1/2}\right)^2 = V_1^{(+)}`),
          "。",
        ],
        [
          "(3) 合成として定めた ",
          math(String.raw`T_{(V^{(+)})}`),
          " は、",
          math(String.raw`V^{(+)}`),
          " による共役そのものに一致する：",
          math(String.raw`T_{(V^{(+)})} = T_{V^{(+)}}`),
          "。",
        ],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("matrix_exp_conjugation"),
        " (3) より、任意の ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について ",
        math(String.raw`\exp(X)`),
        " は可逆で ",
        math(String.raw`\exp(X)^{-1} = \exp(-X)`),
        " である。よって ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2} = \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)`),
        " と ",
        math(String.raw`\exp\!\left(iK_2^*H_2\right)`),
        " は可逆。",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{C}\setminus\{0\}`),
        " であり、",
        ref("def_invertible_elements_of_R"),
        " (ii)(iv) より ",
        math(String.raw`V_2 = (2s_2)^{M/2}I \cdot \exp\!\left(iK_2^*H_2\right)`),
        " も可逆。同じく (ii) を 2 回使って ",
        math(String.raw`V^{(+)}`),
        " も可逆である。",
      ]),
      paragraph([
        "(2) ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`X = Y = \tfrac{i}{2}K_1H_1^{(+)}`),
        " に適用する（",
        math(String.raw`X`),
        " は自分自身と可換）。すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right)^2
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)} + \tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad (\because\ \text{可換な指数行列の積の定理}) \\
&= \exp\!\left(iK_1H_1^{(+)}\right)
   \quad (\because \text{同類項 } \tfrac{i}{2}K_1H_1^{(+)} \text{ の加法}) \\
&= V_1^{(+)}
   \quad (\because\ V_1^{(+)}\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "(3) ",
        math(String.raw`g, h \in R^\times`),
        " と ",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について、",
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g(X) = gXg^{-1}`),
        "、",
        ref("def_invertible_elements_of_R"),
        " (ii) の ",
        math(String.raw`(gh)^{-1} = h^{-1}g^{-1}`),
        "、および行列の積の結合律より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_g\!\left(T_h(X)\right)
&= g\left(hXh^{-1}\right)g^{-1}
   \quad (\because \text{def\_T\_g を 2 回適用}) \\
&= (gh)X\left(h^{-1}g^{-1}\right)
   \quad (\because \text{行列の積の結合律}) \\
&= (gh)X(gh)^{-1}
   \quad (\because\ \text{可逆元の積の逆元}) \\
&= T_{gh}(X)
   \quad (\because\ \text{共役写像の定義})
\end{aligned}`,
      ),
      paragraph([
        "これを ",
        math(String.raw`g = \left(V_1^{(+)}\right)^{1/2}`),
        "、",
        math(String.raw`h = V_2`),
        " に、次いで ",
        math(String.raw`g = \left(V_1^{(+)}\right)^{1/2}V_2`),
        "、",
        math(String.raw`h = \left(V_1^{(+)}\right)^{1/2}`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}\circ T_{V_2}\circ T_{\left(V_1^{(+)}\right)^{1/2}}
&= T_{\left(V_1^{(+)}\right)^{1/2}V_2}\circ T_{\left(V_1^{(+)}\right)^{1/2}}
   \quad \left(\because \text{直前の } T_g \circ T_h = T_{gh}\ \text{を左の 2 つに適用}\right) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}}
   \quad \left(\because \text{同じ } T_g \circ T_h = T_{gh}\ \text{をその結果と残りの 1 つに適用}\right) \\
&= T_{V^{(+)}}
   \quad \left(\because V^{(+)} := \left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}\right)
\end{aligned}`,
      ),
      paragraph([
        "（1 つ目の等号で ",
        math(String.raw`T_g \circ T_h = T_{gh}`),
        " を左の 2 つに、2 つ目でその結果と残りの 1 つに使った。合成の順序は ",
        math(String.raw`T_{(V^{(+)})}(X) = T_{\left(V_1^{(+)}\right)^{1/2}}\left(T_{V_2}\left(T_{\left(V_1^{(+)}\right)^{1/2}}(X)\right)\right)`),
        " の定義どおりである。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の def_T_V は T_{(V)} を (V_1^{(±)})^{1/2}, V_2 の共役の合成として定義しているが、why_008_applies_only_to_minus_sector で確定したとおりその V は実質 (-) 専用である。偶セクターの議論と混同しないよう、本章では V^{(+)} / T_{(V^{(+)})} という別記号を導入し、008 章の def_T_V を参照せずに定義し直した。",
        "008 章は (V_1^{(±)})^{1/2} を「exp(iK_1H_1^{(±)}) の 1/2 乗」と書いたうえで proof の中で exp((1/2)iK_1H_1^{(±)}) と読み替えている（TV1_hatZ_hatY_012_claim_TV1_TV2_actions の proof）。本章では最初から exp((i/2)K_1H_1^{(+)}) を定義とし、それが V_1^{(+)} の平方根であることを (2) で示した（読み替えを暗黙にしない）。",
        "T_{(V^{(+)})} = T_{V^{(+)}}（合成が積による共役に一致すること）は数値でも確認済み（sagemath/check/047_claim_even_sector_T_action/check_04, 「合成=共役」列）。",
      ],
    },
  },

  {
    id: "evensectorT_002_claim_nesting_commutator",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についての } n \text{ 重交換子}` },
    labels: ["nesting_of_commutator_of_H_and_check_Z"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とする。",
        math(String.raw`H_1^{(+)}, H_2, \check{Z}_\mu, \check{Y}_\mu`),
        " はすべて ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の元であり（",
        ref("def_half_integer_modes"),
        "、",
        ref("def_V1_pm"),
        "、",
        ref("def_transfer_matrix_symbols"),
        "）、",
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " はスカラー、",
        math(String.raw`[X, W] := XW - WX`),
        " は交換子である。",
        ref("nesting_of_commutator_of_H_and_Z"),
        " と同じく、",
        math(String.raw`X \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " を固定するごとに ",
        math(String.raw`n`),
        " 重の交換子を",
      ]),
      displayMath(
        String.raw`\underbrace{[X,\dots,[X, W]\dots]}_{n}
:= \underbrace{\mathrm{ad}_X \circ \cdots \circ \mathrm{ad}_X}_{n}(W),
\qquad \mathrm{ad}_X(W) := [X, W]`,
      ),
      paragraph([
        "と定める（",
        math(String.raw`n = 0`),
        " のときは恒等写像、すなわち値は ",
        math(String.raw`W`),
        " そのもの）。以下、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(+)}, \dots, [K_1 H_1^{(+)}, \check{Z}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_1)^n e^{-i\tilde\theta}\,\check{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{[K_1 H_1^{(+)}, \dots, [K_1 H_1^{(+)}, \check{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_1)^n e^{i\tilde\theta}\,\check{Z}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_1)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \check{Z}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{[K_2^* H_2, \dots, [K_2^* H_2, \check{Y}_\mu]\dots]}_{n}
= \begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "証明はすべて ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " に関する帰納法であり、用いるのは ",
        ref("commutator_of_H_and_check_Z_Y"),
        " の 1 重の交換子の公式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\text{(A)}\quad \left[H_1^{(+)}, \check{Z}_\mu\right] &= 2 e^{-i\tilde\theta}\,\check{Y}_\mu, &
\text{(B)}\quad \left[H_1^{(+)}, \check{Y}_\mu\right] &= -2 e^{i\tilde\theta}\,\check{Z}_\mu, \\
\text{(C)}\quad \left[H_2, \check{Z}_\mu\right] &= -2\,\check{Y}_\mu, &
\text{(D)}\quad \left[H_2, \check{Y}_\mu\right] &= 2\,\check{Z}_\mu
\end{aligned}`,
      ),
      paragraph([
        "と、交換子の第 1 引数・第 2 引数についての ",
        math(String.raw`\mathbb{C}`),
        " 双線型性",
      ]),
      displayMath(
        String.raw`[\alpha X, \beta W] = \alpha\beta\,[X, W]
\qquad (\alpha, \beta \in \mathbb{C},\ X, W \in \mathrm{Mat}(2^M,\mathbb{C}))`,
      ),
      paragraph([
        "だけである。後者は、スカラー倍が積と可換なこと（",
        ref("scalar_identity_commutes"),
        "）を使って次のように得られる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
[\alpha X, \beta W]
&= (\alpha X)(\beta W) - (\beta W)(\alpha X)
   \quad (\because \text{交換子の定義}) \\
&= \alpha\beta\,XW - \alpha\beta\,WX
   \quad (\because \text{スカラー倍が積と可換であること}) \\
&= \alpha\beta\,(XW - WX)
   \quad (\because \text{分配則}) \\
&= \alpha\beta\,[X, W]
   \quad (\because \text{交換子の定義})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`e^{-i\tilde\theta}e^{i\tilde\theta} = 1`),
        " を使う。各主張の右辺は ",
        math(String.raw`n`),
        " の偶奇で場合分けされているので、帰納段階は「",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数」「",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数」の 2 通りを別々に示す。",
      ]),

      paragraph([
        "(h1.z) の証明。",
        math(String.raw`C_n := \underbrace{[K_1 H_1^{(+)},\dots,[K_1 H_1^{(+)}, \check{Z}_\mu]\dots]}_{n}`),
        " とおくと、定義より ",
        math(String.raw`C_{n+1} = [K_1 H_1^{(+)},\, C_n]`),
        " が ",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について成り立つ。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`n = 0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_0
&= \check{Z}_\mu
   \quad (\because\ 0\ \text{重交換子は恒等写像}) \\
&= (-1)^0(2K_1)^0\check{Z}_\mu
   \quad (\because\ (-1)^0=1\ \text{かつ}\ (2K_1)^0=1)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`C_n = (-1)^{n/2}(2K_1)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{n/2}(2K_1)^n\check{Z}_\mu\right]
   \quad (\because C_{n+1} = [K_1 H_1^{(+)},\, C_n] \text{ と帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(+)},\ \check{Z}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot 2 e^{-i\tilde\theta}\check{Y}_\mu
   \quad (\because \text{(A)}) \\
&= (-1)^{n/2}(2K_1)^{n+1} e^{-i\tilde\theta}\check{Y}_\mu
   \quad (\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot 2 = (2K_1)^{n+1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)-1)/2} = (-1)^{n/2}`),
        " であり、係数 ",
        math(String.raw`(2K_1)^{n+1}`),
        " と位相因子 ",
        math(String.raw`e^{-i\tilde\theta}`),
        " も一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`C_n = (-1)^{(n-1)/2}(2K_1)^n e^{-i\tilde\theta}\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
C_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{(n-1)/2}(2K_1)^n e^{-i\tilde\theta}\check{Y}_\mu\right]
   \quad (\because C_{n+1} = [K_1 H_1^{(+)},\, C_n] \text{ と帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\tilde\theta}\left[H_1^{(+)},\ \check{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n-1)/2}(2K_1)^n e^{-i\tilde\theta}\cdot\left(-2 e^{i\tilde\theta}\check{Z}_\mu\right)
   \quad (\because \text{(B)}) \\
&= (-1)\cdot(-1)^{(n-1)/2}(2K_1)^{n+1}\,\overbrace{e^{-i\tilde\theta}e^{i\tilde\theta}}^{=\,1}\,\check{Z}_\mu
   \quad (\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot(-2) = (-1)(2K_1)^{n+1}) \\
&= (-1)^{(n-1)/2+1}(2K_1)^{n+1}\check{Z}_\mu
   \quad (\because e^{-i\tilde\theta}e^{i\tilde\theta} = 1 \text{ と } (-1)\cdot(-1)^{(n-1)/2} = (-1)^{(n-1)/2+1}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\check{Z}_\mu
   \quad \left(\because \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は ",
        math(String.raw`\dfrac{n-1}{2}+1 = \dfrac{n+1}{2}`),
        " による。",
        math(String.raw`n+1`),
        " は偶数なので偶数側の右辺 ",
        math(String.raw`(-1)^{(n+1)/2}(2K_1)^{n+1}\check{Z}_\mu`),
        " と一致する（位相因子は ",
        math(String.raw`e^{-i\tilde\theta}e^{i\tilde\theta}=1`),
        " により消える）。以上で (h1.z) が成り立つ。",
      ]),

      paragraph([
        "(h1.y) の証明。",
        math(String.raw`D_n := \underbrace{[K_1 H_1^{(+)},\dots,[K_1 H_1^{(+)}, \check{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`D_{n+1} = [K_1 H_1^{(+)},\, D_n]`),
        "。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_0
&= \check{Y}_\mu
   \quad (\because\ 0\ \text{重交換子は恒等写像}) \\
&= (-1)^0(2K_1)^0\check{Y}_\mu
   \quad (\because\ (-1)^0=1\ \text{かつ}\ (2K_1)^0=1)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`D_n = (-1)^{n/2}(2K_1)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{n/2}(2K_1)^n\check{Y}_\mu\right]
   \quad (\because D_{n+1} = [K_1 H_1^{(+)},\, D_n] \text{ と帰納法の仮定}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\left[H_1^{(+)},\ \check{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{n/2}(2K_1)^n\cdot\left(-2 e^{i\tilde\theta}\check{Z}_\mu\right)
   \quad (\because \text{(B)}) \\
&= (-1)^{n/2+1}(2K_1)^{n+1} e^{i\tilde\theta}\check{Z}_\mu
   \quad (\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot(-2) = (-1)(2K_1)^{n+1})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号は ",
        math(String.raw`(-1)^{((n+1)+1)/2} = (-1)^{n/2+1}`),
        " であり一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`D_n = (-1)^{(n+1)/2}(2K_1)^n e^{i\tilde\theta}\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
D_{n+1}
&= \left[K_1 H_1^{(+)},\ (-1)^{(n+1)/2}(2K_1)^n e^{i\tilde\theta}\check{Z}_\mu\right]
   \quad (\because D_{n+1} = [K_1 H_1^{(+)},\, D_n] \text{ と帰納法の仮定}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\tilde\theta}\left[H_1^{(+)},\ \check{Z}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_1\cdot(-1)^{(n+1)/2}(2K_1)^n e^{i\tilde\theta}\cdot 2 e^{-i\tilde\theta}\check{Y}_\mu
   \quad (\because \text{(A)}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\,\overbrace{e^{i\tilde\theta}e^{-i\tilde\theta}}^{=\,1}\,\check{Y}_\mu
   \quad (\because \text{スカラー倍の交換と } K_1\cdot(2K_1)^n\cdot 2 = (2K_1)^{n+1}) \\
&= (-1)^{(n+1)/2}(2K_1)^{n+1}\check{Y}_\mu
   \quad (\because e^{i\tilde\theta}e^{-i\tilde\theta} = 1)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h1.y) が成り立つ。",
      ]),

      paragraph([
        "(h2.z) の証明。",
        math(String.raw`E_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \check{Z}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`E_{n+1} = [K_2^* H_2,\, E_n]`),
        "。この場合は (C), (D) の右辺に ",
        math(String.raw`e^{\pm i\tilde\theta}`),
        " が現れないので位相因子は出てこない。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_0
&= \check{Z}_\mu
   \quad (\because\ 0\ \text{重交換子は恒等写像}) \\
&= (-1)^0(2K_2^*)^0\check{Z}_\mu
   \quad (\because\ (-1)^0=1\ \text{かつ}\ (2K_2^*)^0=1)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`E_n = (-1)^{n/2}(2K_2^*)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\check{Z}_\mu\right]
   \quad (\because E_{n+1} = [K_2^* H_2,\, E_n] \text{ と帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \check{Z}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot\left(-2\,\check{Y}_\mu\right)
   \quad (\because \text{(C)}) \\
&= (-1)^{n/2}(-1)(2K_2^*)^n(2K_2^*)\check{Y}_\mu
   \quad (\because \text{スカラー倍の交換と結合。} K_2^*\cdot(-2) = (-1)(2K_2^*)) \\
&= (-1)^{n/2+1}(2K_2^*)^{n+1}\check{Y}_\mu
   \quad (\because \text{冪の指数法則を } (-1) \text{ と } 2K_2^* \text{ の両方へ適用})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号 ",
        math(String.raw`(-1)^{((n+1)+1)/2} = (-1)^{n/2+1}`),
        " と一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`E_n = (-1)^{(n+1)/2}(2K_2^*)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n+1)/2}(2K_2^*)^n\check{Y}_\mu\right]
   \quad (\because E_{n+1} = [K_2^* H_2,\, E_n] \text{ と帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\left[H_2,\ \check{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n+1)/2}(2K_2^*)^n\cdot 2\,\check{Z}_\mu
   \quad (\because \text{(D)}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^n(2K_2^*)\check{Z}_\mu
   \quad (\because \text{スカラー倍の交換と結合}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\check{Z}_\mu
   \quad (\because \text{冪の指数法則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h2.z) が成り立つ。",
      ]),

      paragraph([
        "(h2.y) の証明。",
        math(String.raw`F_n := \underbrace{[K_2^* H_2,\dots,[K_2^* H_2, \check{Y}_\mu]\dots]}_{n}`),
        " とおく。",
        math(String.raw`F_{n+1} = [K_2^* H_2,\, F_n]`),
        "。基底段階（",
        math(String.raw`n=0`),
        "、偶数）では、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_0
&= \check{Y}_\mu
   \quad (\because\ 0\ \text{重交換子は恒等写像}) \\
&= (-1)^0(2K_2^*)^0\check{Y}_\mu
   \quad (\because\ (-1)^0=1\ \text{かつ}\ (2K_2^*)^0=1)
\end{aligned}`,
      ),
      paragraph(["となり、偶数側の右辺と一致する。"]),
      paragraph([
        "帰納段階 1（",
        math(String.raw`n`),
        " 偶数 → ",
        math(String.raw`n+1`),
        " 奇数）：",
        math(String.raw`F_n = (-1)^{n/2}(2K_2^*)^n\check{Y}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{n/2}(2K_2^*)^n\check{Y}_\mu\right]
   \quad (\because F_{n+1} = [K_2^* H_2,\, F_n] \text{ と帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\left[H_2,\ \check{Y}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{n/2}(2K_2^*)^n\cdot 2\,\check{Z}_\mu
   \quad (\because \text{(D)}) \\
&= (-1)^{n/2}(2K_2^*)^n(2K_2^*)\check{Z}_\mu
   \quad (\because \text{スカラー倍の交換と結合}) \\
&= (-1)^{n/2}(2K_2^*)^{n+1}\check{Z}_\mu
   \quad (\because \text{冪の指数法則})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は奇数で、奇数側の右辺の符号 ",
        math(String.raw`(-1)^{((n+1)-1)/2} = (-1)^{n/2}`),
        " と一致する。",
      ]),
      paragraph([
        "帰納段階 2（",
        math(String.raw`n`),
        " 奇数 → ",
        math(String.raw`n+1`),
        " 偶数）：",
        math(String.raw`F_n = (-1)^{(n-1)/2}(2K_2^*)^n\check{Z}_\mu`),
        " と仮定すると、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F_{n+1}
&= \left[K_2^* H_2,\ (-1)^{(n-1)/2}(2K_2^*)^n\check{Z}_\mu\right]
   \quad (\because F_{n+1} = [K_2^* H_2,\, F_n] \text{ と帰納法の仮定}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\left[H_2,\ \check{Z}_\mu\right]
   \quad (\because \text{交換子の双線型性}) \\
&= K_2^*\cdot(-1)^{(n-1)/2}(2K_2^*)^n\cdot\left(-2\,\check{Y}_\mu\right)
   \quad (\because \text{(C)}) \\
&= (-1)^{(n-1)/2}(-1)(2K_2^*)^n(2K_2^*)\check{Y}_\mu
   \quad (\because \text{スカラー倍の交換と結合。} K_2^*\cdot(-2) = (-1)(2K_2^*)) \\
&= (-1)^{(n-1)/2+1}(2K_2^*)^{n+1}\check{Y}_\mu
   \quad (\because \text{冪の指数法則を } (-1) \text{ と } 2K_2^* \text{ の両方へ適用}) \\
&= (-1)^{(n+1)/2}(2K_2^*)^{n+1}\check{Y}_\mu
   \quad \left(\because \tfrac{n-1}{2}+1 = \tfrac{n+1}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`n+1`),
        " は偶数で、偶数側の右辺の符号 ",
        math(String.raw`(-1)^{(n+1)/2}`),
        " と一致する。以上で (h2.y) が成り立つ。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の nesting_of_commutator_of_H_and_Z と同じ帰納法を、(A)〜(D) を commutator_of_H_and_check_Z_Y から取って半整数運動量について繰り返したもの。008 章の証明が θ_μ に固有の性質（e^{-iMθ_μ}=+1、添字集合 calM、hatZ_hatY_M_periodicity）を一切使っていないことを確認したうえで書いた。使うのは (A)〜(D) と交換子の双線型性と e^{iθ}e^{-iθ}=1 だけである。",
        "008 章では (h2.z) が hatZ^{(-)} 専用だったのに対し、ここでは (C)(D) が checkZ, checkY について成り立つので (h2.z)(h2.y) にセクターの制限が付かない。これが偶セクターで議論が閉じる理由である。",
        "M=2,3,4,5、μ=1..M、n=0..8、5 組の (K1,K2)（臨界点上・臨界点近傍を含む）で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage）。",
      ],
    },
  },

  {
    id: "evensectorT_003_claim_coefficient_conversion",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についての } \cosh, \sinh \text{ の展開係数への変換}` },
    labels: ["cosh_sinh_coefficient_conversion_for_check"],
    statement: [
      paragraph([
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とし、",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i K_1^n e^{-i\tilde\theta}\,\check{Y}_\mu & (n \text{ 奇数}) \\
K_1^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i K_1^n e^{i\tilde\theta}\,\check{Z}_\mu & (n \text{ 奇数}) \\
K_1^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
= \begin{cases}
-i (2K_2^*)^n\,\check{Y}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n\,\check{Z}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
= \begin{cases}
i (2K_2^*)^n\,\check{Z}_\mu & (n \text{ 奇数}) \\
(2K_2^*)^n\,\check{Y}_\mu & (n \text{ 偶数})
\end{cases}`,
      ),
    ],
    proof: [
      paragraph([
        "まず 4 式すべてで用いる 2 つの補題を用意する（",
        ref("cosh_sinh_coefficient_conversion"),
        " の proof の補題 1・補題 2 と同一の主張であり、",
        math(String.raw`\check{Z}, \check{Y}`),
        " とは無関係に ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " の任意の元について成り立つ）。",
      ]),
      paragraph([
        "補題 1（生成子のスカラー倍）：",
        math(String.raw`\alpha \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`\underbrace{[\alpha X,\dots,[\alpha X, W]\dots]}_{n}
= \alpha^{n}\,\underbrace{[X,\dots,[X, W]\dots]}_{n}`,
      ),
      paragraph([
        "が成り立つ。実際、交換子の第 1 引数についての ",
        math(String.raw`\mathbb{C}`),
        " 線型性より、任意の ",
        math(String.raw`W`),
        " について次の一続きが成り立つ。",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}(W)
&=[\alpha X,W]
&&\bigl(\because\ \mathrm{ad}\text{ の定義}\bigr)\\
&=\alpha[X,W]
&&\bigl(\because\ \text{交換子の第 1 引数についての }\mathbb{C}\text{ 線型性}\bigr)\\
&=\alpha\,\mathrm{ad}_X(W)
&&\bigl(\because\ \mathrm{ad}\text{ の定義}\bigr)
\end{aligned}`),
      paragraph([
        "任意の ",
        math(String.raw`W`),
        " で成り立つので、線型写像として ",
        math(String.raw`\mathrm{ad}_{\alpha X}=\alpha\,\mathrm{ad}_X`),
        " である。したがって、",
      ]),
      displayMath(String.raw`\begin{aligned}
\mathrm{ad}_{\alpha X}^{\,n}
&=(\alpha\,\mathrm{ad}_X)^n
&&\bigl(\because\ \mathrm{ad}_{\alpha X}=\alpha\,\mathrm{ad}_X\bigr)\\
&=\alpha^n\,\mathrm{ad}_X^{\,n}
&&\bigl(\because\ \mathrm{ad}_X\text{ は }\mathbb{C}\text{ 線型であり、合成の各段からスカラーを前へ出せる}\bigr)
\end{aligned}`),
      paragraph([
        math(String.raw`n = 0`),
        " のときは両辺とも恒等写像で ",
        math(String.raw`\alpha^0 = 1`),
        " により成立する。",
      ]),
      paragraph([
        "補題 2（虚数単位の冪）：",
        math(String.raw`n \in \mathbb{Z}_{\geq 0}`),
        " について",
      ]),
      displayMath(
        String.raw`i^{n} = \begin{cases}
i\,(-1)^{(n-1)/2} & (n \text{ 奇数}) \\
(-1)^{n/2} & (n \text{ 偶数})
\end{cases}`,
      ),
      paragraph([
        "が成り立つ。実際 ",
        math(String.raw`i^2 = -1`),
        " を使う。",
      ]),
      displayMath(String.raw`\begin{aligned}
i^n
&=(i^2)^{n/2}
&&\bigl(\because\ n\text{ が偶数なら }n=2(n/2)\bigr)\\
&=(-1)^{n/2}
&&\bigl(\because\ i^2=-1\bigr)
\end{aligned}
\qquad(n\text{ が偶数})`),
      displayMath(String.raw`\begin{aligned}
i^n
&=i\,(i^2)^{(n-1)/2}
&&\bigl(\because\ n\text{ が奇数なら }n=1+2((n-1)/2)\bigr)\\
&=i\,(-1)^{(n-1)/2}
&&\bigl(\because\ i^2=-1\bigr)
\end{aligned}
\qquad(n\text{ が奇数})`),
      paragraph(["いずれの指数も整数である。"]),
      paragraph([
        "(h1.z) について、補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(+)}`),
        "、",
        math(String.raw`W = \check{Z}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h1.z) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(+)},\dots,\left[K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_1)^{n} e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{nesting\_of\_commutator\_of\_H\_and\_check\_Z (h1.z)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,2^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,2^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \text{冪の指数法則を商 }\left(\tfrac{i}{2}\right)^{n}=i^{n}2^{-n}\text{ と積 }(2K_1)^n=2^{n}K_1^n\text{ の両方へ適用し、スカラーを並べ替えた}\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n-1)/2}\,K_1^{n}\, e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because 2^{-n}2^{n} = 2^{0} = 1\right) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}\,K_1^{n}\, e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}\,K_1^{n}\, e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n-1}{2} = n-1,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
i\,K_1^{n}\, e^{-i\tilde\theta}\check{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n-1} = 1,\ n \text{ 偶数なら } (-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、",
        math(String.raw`n`),
        " が奇数なら ",
        math(String.raw`n-1`),
        " が偶数で ",
        math(String.raw`(-1)^{n-1} = 1`),
        "、",
        math(String.raw`n`),
        " が偶数なら ",
        math(String.raw`(-1)^{n} = 1`),
        " による。",
      ]),
      paragraph([
        "(h1.y) について、補題 1 を ",
        math(String.raw`\alpha = \tfrac{i}{2}`),
        "、",
        math(String.raw`X = K_1 H_1^{(+)}`),
        "、",
        math(String.raw`W = \check{Y}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h1.y) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
&= \left(\tfrac{i}{2}\right)^{n}
   \underbrace{\left[K_1 H_1^{(+)},\dots,\left[K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= \left(\tfrac{i}{2}\right)^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_1)^{n} e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_1)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{nesting\_of\_commutator\_of\_H\_and\_check\_Z (h1.y)}) \\
&= \begin{cases}
i^{n}\,2^{-n}\,2^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
i^{n}\,2^{-n}\,2^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \text{冪の指数法則を商 }\left(\tfrac{i}{2}\right)^{n}=i^{n}2^{-n}\text{ と積 }(2K_1)^n=2^{n}K_1^n\text{ の両方へ適用し、スカラーを並べ替えた}\right) \\
&= \begin{cases}
i^{n}\,(-1)^{(n+1)/2}\,K_1^{n}\, e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
i^{n}\,(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because 2^{-n}2^{n} = 2^{0} = 1\right) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}\,K_1^{n}\, e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}\,K_1^{n}\, e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n}\,K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n+1}{2} = n\right) \\
&= \begin{cases}
-i\,K_1^{n}\, e^{i\tilde\theta}\check{Z}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n} = -1,\ n \text{ 偶数なら } (-1)^{n} = 1)
\end{aligned}`,
      ),
      paragraph([
        "最後の等号は、",
        math(String.raw`n`),
        " が奇数なら ",
        math(String.raw`(-1)^{n} = -1`),
        "、偶数なら ",
        math(String.raw`(-1)^{n} = 1`),
        " による。",
      ]),
      paragraph([
        "(h2.z) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \check{Z}_\mu`),
        " として使う。今回は ",
        math(String.raw`\alpha = i`),
        " なので ",
        math(String.raw`2`),
        " の冪が現れず、",
        math(String.raw`(2K_2^*)^n`),
        " はそのまま残る。代入する ",
        math(String.raw`n`),
        " 重交換子は ",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h2.z) である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n+1)/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{nesting\_of\_commutator\_of\_H\_and\_check\_Z (h2.z)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n+1)/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n+1}{2} = n,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
-i\,(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^n = -1,\ n \text{ 偶数なら } (-1)^n = 1)
\end{aligned}`,
      ),
      paragraph([
        "(h2.y) について、補題 1 を ",
        math(String.raw`\alpha = i`),
        "、",
        math(String.raw`X = K_2^* H_2`),
        "、",
        math(String.raw`W = \check{Y}_\mu`),
        " として使い、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " (h2.y) を代入する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
&= i^{n}
   \underbrace{\left[K_2^* H_2,\dots,\left[K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{補題 1}) \\
&= i^{n}\begin{cases}
(-1)^{(n-1)/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{nesting\_of\_commutator\_of\_H\_and\_check\_Z (h2.y)}) \\
&= \begin{cases}
i\,(-1)^{(n-1)/2}(-1)^{(n-1)/2}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n/2}(-1)^{n/2}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{補題 2}) \\
&= \begin{cases}
i\,(-1)^{n-1}(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(-1)^{n}(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad \left(\because \frac{n-1}{2}+\frac{n-1}{2} = n-1,\ \frac{n}{2}+\frac{n}{2} = n\right) \\
&= \begin{cases}
i\,(2K_2^*)^{n}\check{Z}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because n \text{ 奇数なら } (-1)^{n-1} = 1,\ n \text{ 偶数なら } (-1)^n = 1)
\end{aligned}`,
      ),
      paragraph([
        "以上 4 式が、",
        ref("nesting_of_commutator_of_H_and_check_Z"),
        " の各式に補題 1・補題 2 を適用して得られた。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の cosh_sinh_coefficient_conversion と同一形の計算を半整数運動量について繰り返したもの。用いる補題 1・補題 2 は θ にも Z,Y にも依存しない純代数的な主張なので、そのまま同じものを使える。",
        "M=2,3,4,5、μ=1..M、n=0..8 で数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_01_nested_commutators.sage の scaled 列）。",
      ],
    },
  },

  {
    id: "evensectorT_004_claim_extract_taylor",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ についてのテイラー係数の抽出}` },
    labels: ["extract_taylor_coefficient_of_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " とし ",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記する。次の 4 つの級数は ",
        math(String.raw`\mathrm{Mat}(2^M,\mathbb{C})`),
        " において収束し（",
        ref("matrix_exp_conjugation"),
        " (1)）、それぞれ次に等しい。",
      ]),
      paragraph(["(h1.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
= \cosh(K_1)\check{Z}_\mu + i e^{-i\tilde\theta}\sinh(K_1)\check{Y}_\mu`,
      ),
      paragraph(["(h1.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[\tfrac{i}{2}K_1 H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1 H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
= -i e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu`,
      ),
      paragraph(["(h2.z)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Z}_\mu\right]\dots\right]}_{n}
= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu`,
      ),
      paragraph(["(h2.y)"]),
      displayMath(
        String.raw`\sum_{n=0}^{\infty} \frac{1}{n!}
\underbrace{\left[i K_2^* H_2,\dots,\left[i K_2^* H_2,\check{Y}_\mu\right]\dots\right]}_{n}
= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu`,
      ),
    ],
    proof: [
      paragraph([
        "各級数を ",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " により偶数項・奇数項に分け、",
        math(String.raw`\sinh, \cosh`),
        " のテイラー展開",
      ]),
      displayMath(
        String.raw`\sinh x = \sum_{\substack{n \geq 1 \\ n \text{ 奇数}}} \frac{x^n}{n!}, \qquad
\cosh x = \sum_{\substack{n \geq 0 \\ n \text{ 偶数}}} \frac{x^n}{n!}`,
      ),
      paragraph([
        "を用いる。(h1.z) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h1.z) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Z}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\,K_1^{n}\,e^{-i\tilde\theta}\,\check{Y}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{展開係数への変換 (h1.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\check{Z}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,K_1^{n}\,e^{-i\tilde\theta}\,\check{Y}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\check{Z}_\mu
   + i\,e^{-i\tilde\theta}\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\check{Y}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, i e^{-i\tilde\theta} \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(K_1)\check{Z}_\mu + i\,e^{-i\tilde\theta}\sinh(K_1)\check{Y}_\mu
   \quad (\because \sinh, \cosh \text{ のテイラー展開})
\end{aligned}`,
      ),
      paragraph([
        "1 行目で ",
        math(String.raw`n = 0`),
        " 項を分けて書いたが、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " (h1.z) の偶数側は ",
        math(String.raw`n = 0`),
        " でも ",
        math(String.raw`K_1^{0}\check{Z}_\mu = \check{Z}_\mu = \frac{1}{0!}\check{Z}_\mu`),
        " と一致するので、2 行目では ",
        math(String.raw`n = 0`),
        " 項を偶数側の和へ吸収した（以下の 3 式でも同様）。3 行目では ",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " と ",
        math(String.raw`i e^{-i\tilde\theta}`),
        " が ",
        math(String.raw`n`),
        " に依らないので和の外へ出した。",
      ]),
      paragraph([
        "(h1.y) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h1.y) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\,K_1^{n}\,e^{i\tilde\theta}\,\check{Z}_\mu & (n\text{ 奇数}) \\
K_1^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{展開係数への変換 (h1.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}K_1^{n}\check{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,K_1^{n}\,e^{i\tilde\theta}\,\check{Z}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}K_1^{n}\right)\check{Y}_\mu
   - i\,e^{i\tilde\theta}\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}K_1^{n}\right)\check{Z}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, -i e^{i\tilde\theta} \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(K_1)\check{Y}_\mu - i\,e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu
   \quad (\because \sinh, \cosh \text{ のテイラー展開}) \\
&= -i\,e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
   \quad (\because \text{行列加法の可換則})
\end{aligned}`,
      ),
      paragraph([
        "(h2.z) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h2.z) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Z}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
-i\,(2K_2^*)^{n}\,\check{Y}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\,\check{Z}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{展開係数への変換 (h2.z)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\check{Z}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,(-i)\,(2K_2^*)^{n}\,\check{Y}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Z}_\mu
   - i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Y}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, -i \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
   \quad (\because \sinh, \cosh \text{ のテイラー展開})
\end{aligned}`,
      ),
      paragraph([
        "(h2.y) について、",
        ref("cosh_sinh_coefficient_conversion_for_check"),
        " の (h2.y) を用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
(\text{左辺})
&= \frac{1}{0!}\check{Y}_\mu
   + \sum_{n=1}^{\infty}\frac{1}{n!}\begin{cases}
i\,(2K_2^*)^{n}\,\check{Z}_\mu & (n\text{ 奇数}) \\
(2K_2^*)^{n}\,\check{Y}_\mu & (n\text{ 偶数})
\end{cases}
   \quad (\because \text{展開係数への変換 (h2.y)}) \\
&= \sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\left(\frac{1}{n!}(2K_2^*)^{n}\check{Y}_\mu\right)
   + \sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\left(\frac{1}{n!}\,i\,(2K_2^*)^{n}\,\check{Z}_\mu\right)
   \quad (\because n = 0 \text{ 項を偶数側の和へ吸収し、偶数項と奇数項に分けた}) \\
&= \left(\sum_{\substack{n\geq 0\\ n\text{ 偶数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Y}_\mu
   + i\left(\sum_{\substack{n\geq 1\\ n\text{ 奇数}}}\frac{1}{n!}(2K_2^*)^{n}\right)\check{Z}_\mu
   \quad (\because \check{Z}_\mu, \check{Y}_\mu, i \text{ が } n \text{ に依らないので和の外へ出した}) \\
&= \cosh(2K_2^*)\check{Y}_\mu + i\sinh(2K_2^*)\check{Z}_\mu
   \quad (\because \sinh, \cosh \text{ のテイラー展開}) \\
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
   \quad (\because \text{行列加法の可換則})
\end{aligned}`,
      ),
      paragraph([
        "以上 4 式がいずれも statement の右辺と一致する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の extract_taylor_coefficient_of_Z_Y と同一形。sinh/cosh のテイラー展開は 008 章の TV1_hatZ_hatY_004_claim_sinh_cosh_taylor がラベルを持たないため、ここでは式を再掲して使った。",
        "級数を 40 次で打ち切った数値検証を M=2,3,4,5・μ=1..M・5 組の (K1,K2) で実施し、残差 1e-13 以下（sagemath/check/047_claim_even_sector_T_action/check_02_taylor_sums.sage）。",
        "4 式の係数変換の適用を各式鎖の直前から実在ラベルで参照し、(h1.y)・(h2.y) の終端の項の交換へ行列加法の可換則を明記した（2026-08-15）。",
      ],
    },
  },

  {
    id: "evensectorT_005_claim_T_actions",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { tex: String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2} \text{ の } \check{Z}, \check{Y} \text{ への作用}` },
    labels: ["T_actions_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " について（",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)
&= \cosh(K_1)\check{Z}_\mu + i e^{-i\tilde\theta}\sinh(K_1)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix} \\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)
&= -i e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix} \\
T_{V_2}(\check{Z}_\mu)
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix} \\
T_{V_2}(\check{Y}_\mu)
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
  \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
\end{aligned}`,
      ),
      paragraph([
        "ここで行ベクトルと列ベクトルの積は ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} := aA + bB`),
        "（",
        math(String.raw`A, B \in \mathrm{Mat}(2^M,\mathbb{C})`),
        "、",
        math(String.raw`a, b \in \mathbb{C}`),
        "）とする。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)`),
        " について、",
        ref("def_T_g"),
        "、",
        ref("def_V_plus_and_T_V_plus"),
        " の定義、",
        ref("matrix_exp_conjugation"),
        " (3) の ",
        math(String.raw`\exp(X)^{-1} = \exp(-X)`),
        "、",
        ref("exp_X_Y_exp_-X"),
        "、",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " を順に用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)
&= \left(V_1^{(+)}\right)^{1/2}\,\check{Z}_\mu\,\left(\left(V_1^{(+)}\right)^{1/2}\right)^{-1}
   \quad (\because \text{def\_T\_g}) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Z}_\mu\,
   \left(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right)^{-1}
   \quad \left(\because \text{def\_V\_plus\_and\_T\_V\_plus}:\ \left(V_1^{(+)}\right)^{1/2} := \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Z}_\mu\,
   \exp\!\left(-\tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad \left(\because \text{matrix\_exp\_conjugation (3)}:\ \exp(X)^{-1} = \exp(-X)\right) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{i}{2}K_1H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1H_1^{(+)},\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{exp\_X\_Y\_exp\_-X}) \\
&= \cosh(K_1)\check{Z}_\mu + i\,e^{-i\tilde\theta}\sinh(K_1)\check{Y}_\mu
   \quad (\because \text{extract\_taylor\_coefficient\_of\_check\_Z\_Y (h1.z)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)`),
        " については、作用させる元が ",
        math(String.raw`\check{Z}_\mu`),
        " から ",
        math(String.raw`\check{Y}_\mu`),
        " へ変わるだけで共役の展開はまったく同じ手順であり、最後に ",
        ref("extract_taylor_coefficient_of_check_Z_Y"),
        " の (h1.y) を使う。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)
&= \left(V_1^{(+)}\right)^{1/2}\,\check{Y}_\mu\,\left(\left(V_1^{(+)}\right)^{1/2}\right)^{-1}
   \quad (\because \text{def\_T\_g}) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Y}_\mu\,
   \left(\exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right)^{-1}
   \quad \left(\because \text{def\_V\_plus\_and\_T\_V\_plus}:\ \left(V_1^{(+)}\right)^{1/2} := \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\right) \\
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)\,\check{Y}_\mu\,
   \exp\!\left(-\tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad \left(\because \text{matrix\_exp\_conjugation (3)}:\ \exp(X)^{-1} = \exp(-X)\right) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[\tfrac{i}{2}K_1H_1^{(+)},\dots,\left[\tfrac{i}{2}K_1H_1^{(+)},\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{exp\_X\_Y\_exp\_-X}) \\
&= -i\,e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu
   \quad (\because \text{extract\_taylor\_coefficient\_of\_check\_Z\_Y (h1.y)})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`T_{V_2}`),
        " については、",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`V_2 = (2s_2)^{M/2}\exp\!\left(iK_2^*H_2\right)`),
        " の前因子 ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{C}\setminus\{0\}`),
        " が共役で打ち消し合う。実際 ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`(2s_2)^{M/2}I`),
        " は任意の元と可換であり、",
        ref("def_invertible_elements_of_R"),
        " (ii)(iv) より ",
        math(String.raw`V_2^{-1} = \left((2s_2)^{M/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)`),
        " である（",
        ref("def_T_g"),
        " と ",
        ref("exp_X_Y_exp_-X"),
        " も以下で使う）。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Z}_\mu)
&= V_2\,\check{Z}_\mu\,V_2^{-1}
   \quad (\because \text{def\_T\_g}) \\
&= (2s_2)^{M/2}\exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,
   \left((2s_2)^{M/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \text{def\_transfer\_matrix\_symbols の } V_2 \text{ と直前の } V_2^{-1} \text{ の表示}) \\
&= (2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1}
   \exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \text{scalar\_identity\_commutes（スカラー } \left((2s_2)^{M/2}\right)^{-1} \text{ を左端へ移す）}) \\
&= \exp\!\left(iK_2^*H_2\right)\,\check{Z}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because (2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1} = 1) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[iK_2^*H_2,\dots,\left[iK_2^*H_2,\check{Z}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{exp\_X\_Y\_exp\_-X}) \\
&= \cosh(2K_2^*)\check{Z}_\mu - i\sinh(2K_2^*)\check{Y}_\mu
   \quad (\because \text{extract\_taylor\_coefficient\_of\_check\_Z\_Y (h2.z)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
T_{V_2}(\check{Y}_\mu)
&= V_2\,\check{Y}_\mu\,V_2^{-1}
   \quad (\because \text{def\_T\_g}) \\
&= (2s_2)^{M/2}\exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,
   \left((2s_2)^{M/2}\right)^{-1}\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \text{def\_transfer\_matrix\_symbols の } V_2 \text{ と直前の } V_2^{-1} \text{ の表示}) \\
&= (2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1}
   \exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because \text{scalar\_identity\_commutes（スカラー } \left((2s_2)^{M/2}\right)^{-1} \text{ を左端へ移す）}) \\
&= \exp\!\left(iK_2^*H_2\right)\,\check{Y}_\mu\,\exp\!\left(-iK_2^*H_2\right)
   \quad (\because (2s_2)^{M/2}\left((2s_2)^{M/2}\right)^{-1} = 1) \\
&= \sum_{n=0}^{\infty}\frac{1}{n!}
   \underbrace{\left[iK_2^*H_2,\dots,\left[iK_2^*H_2,\check{Y}_\mu\right]\dots\right]}_{n}
   \quad (\because \text{exp\_X\_Y\_exp\_-X}) \\
&= i\sinh(2K_2^*)\check{Z}_\mu + \cosh(2K_2^*)\check{Y}_\mu
   \quad (\because \text{extract\_taylor\_coefficient\_of\_check\_Z\_Y (h2.y)})
\end{aligned}`,
      ),
      paragraph([
        "最後に、行ベクトルと列ベクトルの積の定義 ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`),
        " により、上の 4 式はいずれも statement の行列表示に書き換えられる。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の ホロノミック量子場_p142下段_1 の半整数運動量版。008 章では H_1 の符号 (±) と hatZ の符号 (-) が食い違ったまま書かれていたが（why_008_applies_only_to_minus_sector により実質 (-) 専用）、ここでは H_1^{(+)} と checkZ, checkY で首尾一貫している。",
        "行列指数関数を明示的に構成した直接計算（交換子の級数展開に依存しない独立経路）で数値確認済み。V_2 の前因子 (2 s_2)^{M/2} を明示的に付けた形で相殺も確認した（sagemath/check/047_claim_even_sector_T_action/check_03_T_actions.sage）。",
      ],
    },
  },

  {
    id: "evensectorT_006_claim_linearity_of_T",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`T_g \text{ の } \mathbb{C} \text{ 線型性}` },
    labels: ["linearity_of_T_on_check_Z_Y"],
    statement: [
      paragraph([
        math(String.raw`g \in R^\times`),
        "（",
        ref("def_invertible_elements_of_R"),
        "）と ",
        math(String.raw`a, b \in \mathbb{C}`),
        "、",
        math(String.raw`X, W \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " について",
      ]),
      displayMath(String.raw`T_g(aX + bW) = a\,T_g(X) + b\,T_g(W)`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`g = \left(V_1^{(+)}\right)^{1/2}`),
        "、",
        math(String.raw`g = V_2`),
        " について、",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        " と ",
        math(String.raw`a, b \in \mathbb{C}`),
        " に対し",
      ]),
      displayMath(
        String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(a\check{Z}_\mu + b\check{Y}_\mu\right)
= a\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu) + b\,T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu),
\qquad
T_{V_2}\!\left(a\check{Z}_\mu + b\check{Y}_\mu\right)
= a\,T_{V_2}(\check{Z}_\mu) + b\,T_{V_2}(\check{Y}_\mu)`,
      ),
    ],
    proof: [
      paragraph([
        ref("def_T_g"),
        " の ",
        math(String.raw`T_g(X) = gXg^{-1}`),
        " と、行列の積が和について分配することおよびスカラー倍と可換であること（",
        ref("scalar_identity_commutes"),
        "）より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_g(aX + bW)
&= g(aX + bW)g^{-1}
   \quad (\because \text{def\_T\_g}) \\
&= a\,gXg^{-1} + b\,gWg^{-1}
   \quad (\because \text{行列の積の分配法則と scalar\_identity\_commutes}) \\
&= a\,T_g(X) + b\,T_g(W)
   \quad (\because \text{def\_T\_g})
\end{aligned}`,
      ),
      paragraph([
        ref("def_V_plus_and_T_V_plus"),
        " (1) より ",
        math(String.raw`\left(V_1^{(+)}\right)^{1/2}, V_2 \in R^\times`),
        " なので、後半はこの一般形の特別な場合である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の linearity_of_T は「表式よりただの 1 次関数なので自明」とだけ書かれていた。ここでは T_g の定義から分配法則で書き下し、g を可逆元一般に取った形で述べた（後で使うのは g = (V_1^{(+)})^{1/2}, V_2 の 2 つだけ）。",
      ],
    },
  },

  {
    id: "evensectorT_007_definition_B1_B2",
    kind: "definition",
    origin: { path: SRC, ordinal: 9 },
    title: { tex: String.raw`B_1(\theta), B_2 \text{ の定義}` },
    labels: ["def_B1_theta_B2"],
    statement: [
      paragraph([math(String.raw`\theta \in \mathbb{R}`), " について、"]),
      displayMath(
        String.raw`B_1(\theta) := \begin{pmatrix}
\cosh K_1 & -i e^{i\theta}\sinh K_1 \\
i e^{-i\theta}\sinh K_1 & \cosh K_1
\end{pmatrix},
\qquad
B_2 := \begin{pmatrix}
\cosh(2K_2^*) & i\sinh(2K_2^*) \\
-i\sinh(2K_2^*) & \cosh(2K_2^*)
\end{pmatrix}`,
      ),
      paragraph([
        "と定める（いずれも ",
        math(String.raw`\mathrm{Mat}(2,\mathbb{C})`),
        " の元。",
        math(String.raw`K_1, K_2^*`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の記号）。",
        ref("factorization_of_A_theta"),
        " の ",
        math(String.raw`B_1(\theta_\mu), B_2`),
        " は ",
        math(String.raw`\theta = \theta_\mu`),
        " とした場合であり、この定義はそれを ",
        math(String.raw`\theta \in \mathbb{R}`),
        " 一般へ広げたものである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章では B_1, B_2 は factorization_of_A_theta の statement と T_V_hatZ_hatY の proof の中で θ_μ（μ ∈ calM）に限って導入されている。半整数運動量 θ~_μ で使うために、θ ∈ R 一般の定義として立て直した（008 章側は変更していない）。",
      ],
    },
  },

  {
    id: "evensectorT_008_claim_product_action",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`T_{\left(V_1^{(+)}\right)^{1/2}}, T_{V_2} \text{ の } (\check{Z}, \check{Y}) \text{ への直積作用}` },
    labels: ["calc_of_TxT_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）", " について、"]),
      displayMath(
        String.raw`\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1\!\left(\tilde\theta_\mu\right)`,
      ),
      displayMath(
        String.raw`\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2`,
      ),
      paragraph([
        "ここで ",
        math(String.raw`B_1, B_2`),
        " は ",
        ref("def_B1_theta_B2"),
        " のものであり、行ベクトルと ",
        math(String.raw`2\times 2`),
        " 行列の積は列ごとの ",
        math(String.raw`\begin{pmatrix}A, & B\end{pmatrix}\begin{pmatrix}a \\ b\end{pmatrix} = aA + bB`),
        " を 2 列並べたもの、すなわち",
      ]),
      displayMath(
        String.raw`\begin{pmatrix}A, & B\end{pmatrix}
\begin{pmatrix}p & q \\ r & s\end{pmatrix}
:= \left(pA + rB,\ qA + sB\right)`,
      ),
      paragraph(["とする。"]),
    ],
    proof: [
      paragraph([
        ref("T_actions_on_check_Z_Y"),
        " の 4 式の列ベクトル表示を、",
        math(String.raw`\check{Z}_\mu`),
        " 分・",
        math(String.raw`\check{Y}_\mu`),
        " 分の順に 2 列並べる。",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と書くと ",
        math(String.raw`V_1`),
        " 分は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
&\left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) \\
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \right)
   \quad (\because \text{T\_actions\_on\_check\_Z\_Y を 2 列へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(K_1) & -i e^{i\tilde\theta}\sinh(K_1) \\
   i e^{-i\tilde\theta}\sinh(K_1) & \cosh(K_1)
   \end{pmatrix}
   \quad (\because \text{statement の行ベクトルと行列の積の定義}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_1\!\left(\tilde\theta_\mu\right)
   \quad (\because \text{def\_B1\_theta\_B2})
\end{aligned}`,
      ),
      paragraph([math(String.raw`V_2`), " 分も同様に、"]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
&= \left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}\cosh(2K_2^*) \\ -i\sinh(2K_2^*)\end{pmatrix},\ \
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}i\sinh(2K_2^*) \\ \cosh(2K_2^*)\end{pmatrix}
   \right)
   \quad (\because \text{T\_actions\_on\_check\_Z\_Y を 2 列へ同時適用}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   \begin{pmatrix}
   \cosh(2K_2^*) & i\sinh(2K_2^*) \\
   -i\sinh(2K_2^*) & \cosh(2K_2^*)
   \end{pmatrix}
   \quad (\because \text{statement の行ベクトルと行列の積の定義}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \quad (\because \text{def\_B1\_theta\_B2})
\end{aligned}`,
      ),
      paragraph([
        "並べた 2 列がそれぞれ ",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\tilde\theta_\mu)`),
        "、",
        math(String.raw`B_2`),
        " の第 1 列・第 2 列に一致している。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の calc_of_TxT_hatZxhatY の半整数運動量版。008 章は直積写像 T×T を別ブロックで定義してから 2 列を並べていたが、直積写像の記号は以降で使われないので、ここでは 2 つの像の組をそのまま行ベクトル×行列の形に書いた。",
        "数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_03_T_actions.sage の「B1 右乗」「B2 右乗」列）。",
      ],
    },
  },

  {
    id: "evensectorT_009_claim_factorization_A_theta",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`A(\theta) = B_1(\theta) B_2 B_1(\theta) \text{（}\theta \in \mathbb{R}\text{ 一般）}` },
    labels: ["factorization_of_A_theta_general"],
    statement: [
      paragraph([
        math(String.raw`\theta \in \mathbb{R}`),
        " について、",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\theta), B_2`),
        " と ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の間に",
      ]),
      displayMath(String.raw`B_1(\theta)\, B_2\, B_1(\theta) = A(\theta)`),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）",
        "）とすれば ",
        math(String.raw`B_1(\tilde\theta_\mu) B_2 B_1(\tilde\theta_\mu) = A(\tilde\theta_\mu)`),
        " である。",
      ]),
    ],
    proof: [
      paragraph(["以下、記号を"]),
      displayMath(
        String.raw`a := \cosh K_1 \in \mathbb{R},\quad b := \sinh K_1 \in \mathbb{R},\quad
C := \cosh 2K_2^* = c_2^* \in \mathbb{R},\quad S := \sinh 2K_2^* = s_2^* \in \mathbb{R}`,
      ),
      paragraph([
        "と略記する（",
        math(String.raw`c_1, s_1, c_2, c_2^*, s_2^*`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        " の記号）。",
        ref("cosh_sinh_basic_properties"),
        " による倍角公式から従う次の三本の等式",
      ]),
      displayMath(String.raw`\begin{aligned}
a^2 + b^2
&= \cosh^2 K_1 + \sinh^2 K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= \cosh 2K_1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}\bigr)\\
&= c_1
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の記号の定義}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
2ab
&= 2\cosh K_1 \sinh K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= \sinh 2K_1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\text{ の倍角公式}\bigr)\\
&= s_1
&&\bigl(\because\ \blkref{def_transfer_matrix_symbols}\text{ の記号の定義}\bigr)
\end{aligned}`),
      displayMath(String.raw`\begin{aligned}
a^2 - b^2
&= \cosh^2 K_1 - \sinh^2 K_1
&&\bigl(\because\ a, b\text{ の定義}\bigr)\\
&= 1
&&\bigl(\because\ \blkref{cosh_sinh_basic_properties}\bigr)
\end{aligned}`),
      paragraph([
        "を後で用いる。また複素指数の指数法則 ",
        math(String.raw`e^{z}e^{w} = e^{z+w}`),
        " としては ",
        ref("theorem_exp_product"),
        " を ",
        math(String.raw`n=1`),
        " に適用したものを使う。この記号で ",
        math(String.raw`B_1(\theta) = \begin{pmatrix} a & -i e^{i\theta} b \\ i e^{-i\theta} b & a\end{pmatrix}`),
        "、",
        math(String.raw`B_2 = \begin{pmatrix} C & i S \\ -i S & C\end{pmatrix}`),
        " である。",
      ]),
      paragraph([
        "Step 1: ",
        math(String.raw`N := B_2\, B_1(\theta)`),
        " を成分ごとに計算する（行列の積は ",
        ref("mat_mult"),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
N_{11} &= C\cdot a + (iS)\cdot\left(i e^{-i\theta} b\right)
   \quad (\because \text{mat\_mult}) \\
       &= Ca - S b\, e^{-i\theta}
   \quad (\because i\cdot i = -1) \\
N_{12} &= C\cdot\left(-i e^{i\theta} b\right) + (iS)\cdot a
   \quad (\because \text{mat\_mult}) \\
       &= i\left(Sa - C b\, e^{i\theta}\right) \\
N_{21} &= (-iS)\cdot a + C\cdot\left(i e^{-i\theta} b\right)
   \quad (\because \text{mat\_mult}) \\
       &= i\left(C b\, e^{-i\theta} - Sa\right) \\
N_{22} &= (-iS)\cdot\left(-i e^{i\theta} b\right) + C\cdot a
   \quad (\because \text{mat\_mult}) \\
       &= Ca - S b\, e^{i\theta}
   \quad (\because (-i)\cdot(-i) = -1)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`i\cdot i = -1`),
        " を使った。）",
      ]),
      paragraph([
        "Step 2: ",
        math(String.raw`P := B_1(\theta)\, N = B_1(\theta)\, B_2\, B_1(\theta)`),
        " の (1,1) 成分。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{11}
&= a\, N_{11} + \left(-i e^{i\theta} b\right) N_{21}
   \quad (\because \text{mat\_mult}) \\
&= a\left(Ca - S b\, e^{-i\theta}\right)
   + \left(-i e^{i\theta} b\right)\cdot i\left(C b\, e^{-i\theta} - Sa\right)
   \quad (\because \text{Step 1 の } N_{11}, N_{21}) \\
&= Ca^2 - S ab\, e^{-i\theta}
   + e^{i\theta} b\left(C b\, e^{-i\theta} - Sa\right)
   \quad (\because -i\cdot i = 1) \\
&= Ca^2 - S ab\, e^{-i\theta} + C b^2 - S ab\, e^{i\theta}
   \quad (\because e^{i\theta}e^{-i\theta} = 1,\ \text{theorem\_exp\_product}\ (n=1)) \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right) \\
&= C\, c_1 - S ab\left(e^{i\theta} + e^{-i\theta}\right)
   \quad (\because \text{倍角公式 } a^2+b^2 = c_1) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\left(e^{i\theta} + e^{-i\theta}\right)
   \quad (\because \text{倍角公式 } 2ab = s_1) \\
&= C\, c_1 - S\cdot\frac{s_1}{2}\cdot 2\cos\theta
   \quad (\because \text{euler\_formula\_cos\_sin より } e^{i\theta}+e^{-i\theta} = 2\cos\theta) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   \quad (\because C := c_2^*,\ S := s_2^*)
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`e^{i\theta} + e^{-i\theta} = 2\cos\theta`),
        " は ",
        ref("euler_formula_cos_sin"),
        " による。）これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,1) 成分に一致する。",
      ]),
      paragraph(["Step 3: ", math(String.raw`P`), " の (2,2) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{22}
&= \left(i e^{-i\theta} b\right) N_{12} + a\, N_{22}
   \quad (\because \text{mat\_mult}) \\
&= \left(i e^{-i\theta} b\right)\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + a\left(Ca - S b\, e^{i\theta}\right)
   \quad (\because \text{Step 1 の } N_{12}, N_{22}) \\
&= -e^{-i\theta} b\left(Sa - C b\, e^{i\theta}\right) + Ca^2 - S ab\, e^{i\theta}
   \quad (\because i\cdot i = -1) \\
&= -S ab\, e^{-i\theta} + C b^2 + Ca^2 - S ab\, e^{i\theta}
   \quad (\because e^{-i\theta}e^{i\theta} = 1,\ \text{theorem\_exp\_product}\ (n=1)) \\
&= C\left(a^2 + b^2\right) - S ab\left(e^{i\theta} + e^{-i\theta}\right) \\
&= c_1 c_2^* - s_1 s_2^*\cos\theta
   \quad (\because P_{11} \text{ の計算の最後の 4 段と同じ})
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        math(String.raw`A(\theta)`),
        " の (2,2) 成分に一致する（(1,1) 成分と同一の式）。",
      ]),
      paragraph([
        "Step 4: ",
        math(String.raw`P`),
        " の (1,2) 成分。準備として、補助的な等式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2 + b^2 e^{2i\theta}
&= e^{i\theta}\left(a^2 e^{-i\theta} + b^2 e^{i\theta}\right)
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{i\theta}\left(a^2(\cos\theta - i\sin\theta) + b^2(\cos\theta + i\sin\theta)\right)
   \quad (\because \text{euler\_formula\_cos\_sin を 2 箇所へ同時適用}) \\
&= e^{i\theta}\left(\left(a^2 + b^2\right)\cos\theta - i\left(a^2 - b^2\right)\sin\theta\right) \\
&= e^{i\theta}\left(c_1\cos\theta - i\left(a^2-b^2\right)\sin\theta\right)
   \quad (\because \text{倍角公式 } a^2+b^2 = c_1) \\
&= e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right)
   \quad (\because a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph([
        "を置く（",
        ref("theorem_exp_product"),
        "、",
        ref("euler_formula_cos_sin"),
        "）。また ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " による。これらを用いて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{12}
&= a\, N_{12} + \left(-i e^{i\theta} b\right) N_{22}
   \quad (\because \text{mat\_mult}) \\
&= a\cdot i\left(Sa - C b\, e^{i\theta}\right)
   + \left(-i e^{i\theta} b\right)\left(Ca - S b\, e^{i\theta}\right)
   \quad (\because \text{Step 1 の } N_{12}, N_{22}) \\
&= i\left[S a^2 - C ab\, e^{i\theta}\right]
   + i\left[-C ab\, e^{i\theta} + S b^2 e^{2i\theta}\right]
   \quad (\because \text{theorem\_exp\_product}\ (n=1)\ (e^{i\theta}e^{i\theta} = e^{2i\theta})) \\
&= i\left[S\left(a^2 + b^2 e^{2i\theta}\right) - 2C ab\, e^{i\theta}\right] \\
&= i\left[S\, e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right) - 2C ab\, e^{i\theta}\right]
   \quad (\because \text{準備の補助的な等式}) \\
&= i\left[S\, e^{i\theta}\left(c_1\cos\theta - i\sin\theta\right) - C s_1 e^{i\theta}\right]
   \quad (\because \text{倍角公式 } 2ab = s_1) \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - c_2^*\, s_1\right]
   \quad (\because C := c_2^*,\ S := s_2^*) \\
&= i e^{i\theta}\left[s_2^*\left(c_1\cos\theta - i\sin\theta\right) - s_2^* c_2\, s_1\right]
   \quad (\because \text{duality\_c2\_star\_eq\_s2\_star\_c2}:\ c_2^* = s_2^* c_2) \\
&= i e^{i\theta} s_2^*\left(c_1\cos\theta - i\sin\theta - s_1 c_2\right)
\end{aligned}`,
      ),
      paragraph([
        "得られた ",
        math(String.raw`P_{12}`),
        " は ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (1,2) 成分に一致する。",
      ]),
      paragraph(["Step 5: ", math(String.raw`P`), " の (2,1) 成分。"]),
      displayMath(
        String.raw`\begin{aligned}
P_{21}
&= \left(i e^{-i\theta} b\right) N_{11} + a\, N_{21}
   \quad (\because \text{mat\_mult}) \\
&= \left(i e^{-i\theta} b\right)\left(Ca - S b\, e^{-i\theta}\right)
   + a\cdot i\left(C b\, e^{-i\theta} - Sa\right)
   \quad (\because \text{Step 1 の } N_{11}, N_{21}) \\
&= i\left[C ab\, e^{-i\theta} - S b^2 e^{-2i\theta}\right]
   + i\left[C ab\, e^{-i\theta} - S a^2\right]
   \quad (\because \text{theorem\_exp\_product}\ (n=1)\ (e^{-i\theta}e^{-i\theta} = e^{-2i\theta})) \\
&= -i\left[S\left(a^2 + b^2 e^{-2i\theta}\right) - 2C ab\, e^{-i\theta}\right]
\end{aligned}`,
      ),
      paragraph([
        "準備として、Step 4 の補助的な等式と同形の等式",
      ]),
      displayMath(
        String.raw`\begin{aligned}
a^2 + b^2 e^{-2i\theta}
&= e^{-i\theta}\left(a^2 e^{i\theta} + b^2 e^{-i\theta}\right)
   \quad (\because \text{theorem\_exp\_product}\ (n=1)) \\
&= e^{-i\theta}\left(a^2(\cos\theta + i\sin\theta) + b^2(\cos\theta - i\sin\theta)\right)
   \quad (\because \text{euler\_formula\_cos\_sin を 2 箇所へ同時適用}) \\
&= e^{-i\theta}\left(\left(a^2 + b^2\right)\cos\theta + i\left(a^2 - b^2\right)\sin\theta\right) \\
&= e^{-i\theta}\left(c_1\cos\theta + i\left(a^2-b^2\right)\sin\theta\right)
   \quad (\because \text{倍角公式 } a^2+b^2 = c_1) \\
&= e^{-i\theta}\left(c_1\cos\theta + i\sin\theta\right)
   \quad (\because a^2-b^2 = 1)
\end{aligned}`,
      ),
      paragraph([
        "を置く（",
        ref("theorem_exp_product"),
        "、",
        ref("euler_formula_cos_sin"),
        "）。また ",
        math(String.raw`c_2^* = s_2^* c_2`),
        " は ",
        ref("duality_c2_star_eq_s2_star_c2"),
        " による。これらを用いて、直前の ",
        math(String.raw`P_{21}`),
        " の表示から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P_{21}
&= -i\left[S\left(a^2 + b^2 e^{-2i\theta}\right) - 2C ab\, e^{-i\theta}\right]
   \quad (\because \text{直前の } P_{21} \text{ の表示}) \\
&= -i\left[S\, e^{-i\theta}\left(c_1\cos\theta + i\sin\theta\right) - 2C ab\, e^{-i\theta}\right]
   \quad (\because \text{準備の補助的な等式}) \\
&= -i\left[S\, e^{-i\theta}\left(c_1\cos\theta + i\sin\theta\right) - C s_1 e^{-i\theta}\right]
   \quad (\because \text{倍角公式 } 2ab = s_1) \\
&= -i e^{-i\theta}\left[s_2^*\left(c_1\cos\theta + i\sin\theta\right) - c_2^*\, s_1\right]
   \quad (\because C := c_2^*,\ S := s_2^*) \\
&= -i e^{-i\theta}\left[s_2^*\left(c_1\cos\theta + i\sin\theta\right) - s_2^* c_2\, s_1\right]
   \quad (\because \text{duality\_c2\_star\_eq\_s2\_star\_c2}:\ c_2^* = s_2^* c_2) \\
&= -i e^{-i\theta} s_2^*\left(c_1\cos\theta + i\sin\theta - s_1 c_2\right)
\end{aligned}`,
      ),
      paragraph([
        "これは ",
        ref("def_A_theta"),
        " の ",
        math(String.raw`A(\theta)`),
        " の (2,1) 成分に一致する。",
      ]),
      paragraph([
        "Step 6: Step 2〜5 により ",
        math(String.raw`P = B_1(\theta) B_2 B_1(\theta)`),
        " の 4 成分すべてが ",
        math(String.raw`A(\theta)`),
        " の対応成分に一致するので ",
        math(String.raw`B_1(\theta) B_2 B_1(\theta) = A(\theta)`),
        "。",
        math(String.raw`\theta \in \mathbb{R}`),
        " は任意だったから、",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " を代入して後半を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の factorization_of_A_theta は μ ∈ calM で量化された主張であり、そのままでは θ~_μ に適用できない。証明の実体（T_V_hatZ_hatY の proof の Step 1〜6）は θ ∈ R について何も μ に固有のことを使っていないので、ここでは θ ∈ R 一般の主張として立て直し、同じ行列計算を書き下した。",
        "θ を [0, 2π) 上で 60 点走査し、5 組の (K1,K2) について残差 1e-14 以下であることを数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage の (1)）。",
        "2026-08-19 の式変形統一で、Step 5 の「Step 4 とまったく同じ計算（θ → -θ）」に畳まれていた補助的な等式の導出と P_21 の整理を、Step 4 と同形の一続きの鎖（補助等式 5 段と P_21 の 6 段）へ開いた。内容・参照は変えていない。",
      ],
    },
  },

  {
    id: "evensectorT_010_claim_T_V_plus_action",
    kind: "claim",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`T_{(V^{(+)})} \text{ の } \check{Z}, \check{Y} \text{ への作用}` },
    labels: ["T_V_plus_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`\mu \in \check{\mathcal{M}}`), "（", ref("def_check_index_set"), "）", " について、"]),
      displayMath(
        String.raw`\left(T_{(V^{(+)})}(\check{Z}_\mu),\; T_{(V^{(+)})}(\check{Y}_\mu)\right)
= \left(\check{Z}_\mu,\; \check{Y}_\mu\right) A\!\left(\tilde\theta_\mu\right),
\qquad \tilde\theta_\mu = \frac{2\pi\left(\mu - \tfrac12\right)}{M}`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`T_{(V^{(+)})}`),
        " は ",
        ref("def_V_plus_and_T_V_plus"),
        "、",
        math(String.raw`A(\theta)`),
        " は ",
        ref("def_A_theta"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`\tilde\theta := \tilde\theta_\mu`),
        " と略記し、",
        ref("def_B1_theta_B2"),
        " の ",
        math(String.raw`B_1(\tilde\theta), B_2`),
        " を用いる。",
      ]),
      paragraph([
        "(z) ",
        math(String.raw`T_{(V^{(+)})}(\check{Z}_\mu)`),
        " について、",
        ref("def_V_plus_and_T_V_plus"),
        " の定義、",
        ref("T_actions_on_check_Z_Y"),
        "、",
        ref("linearity_of_T_on_check_Z_Y"),
        "、",
        ref("calc_of_TxT_check_Z_Y"),
        " を順に用いる。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\check{Z}_\mu)
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu)\right)\right)
   \quad (\because \text{def\_V\_plus\_and\_T\_V\_plus}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   \cosh(K_1)\check{Z}_\mu + i e^{-i\tilde\theta}\sinh(K_1)\check{Y}_\mu\right)\right)
   \quad (\because \text{T\_actions\_on\_check\_Z\_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \text{linearity\_of\_T\_on\_check\_Z\_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix}\right)
   \quad (\because \text{calc\_of\_TxT\_check\_Z\_Y}) \\
&= \left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix}
   \quad (\because \text{linearity\_of\_T\_on\_check\_Z\_Y}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2
   \begin{pmatrix}\cosh(K_1) \\ i e^{-i\tilde\theta}\sinh(K_1)\end{pmatrix}
   \quad (\because \text{calc\_of\_TxT\_check\_Z\_Y})
\end{aligned}`,
      ),
      paragraph([
        "（3 行目・5 行目の線型性は、",
        math(String.raw`B_2`),
        " や列ベクトルの成分がスカラーであり、",
        math(String.raw`\check{Z}_\mu, \check{Y}_\mu`),
        " の ",
        math(String.raw`\mathbb{C}`),
        " 線型結合に ",
        math(String.raw`T`),
        " を掛ける形になっていることによる。）",
      ]),
      paragraph([
        "(y) ",
        math(String.raw`T_{(V^{(+)})}(\check{Y}_\mu)`),
        " についても同様に、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
T_{(V^{(+)})}(\check{Y}_\mu)
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right)\right)
   \quad (\because \text{def\_V\_plus\_and\_T\_V\_plus}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(T_{V_2}\!\left(
   -i e^{i\tilde\theta}\sinh(K_1)\check{Z}_\mu + \cosh(K_1)\check{Y}_\mu\right)\right)
   \quad (\because \text{T\_actions\_on\_check\_Z\_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \left(T_{V_2}(\check{Z}_\mu),\ T_{V_2}(\check{Y}_\mu)\right)
   \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \text{linearity\_of\_T\_on\_check\_Z\_Y}) \\
&= T_{\left(V_1^{(+)}\right)^{1/2}}\!\left(
   \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} B_2
   \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}\right)
   \quad (\because \text{calc\_of\_TxT\_check\_Z\_Y}) \\
&= \left(T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Z}_\mu),\
   T_{\left(V_1^{(+)}\right)^{1/2}}(\check{Y}_\mu)\right) B_2
   \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \text{linearity\_of\_T\_on\_check\_Z\_Y}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2
   \begin{pmatrix}-i e^{i\tilde\theta}\sinh(K_1) \\ \cosh(K_1)\end{pmatrix}
   \quad (\because \text{calc\_of\_TxT\_check\_Z\_Y})
\end{aligned}`,
      ),
      paragraph([
        "(z) と (y) で得た 2 つの列ベクトルは、",
        ref("def_B1_theta_B2"),
        " より ",
        math(String.raw`B_1(\tilde\theta)`),
        " の第 1 列・第 2 列そのものである。2 列を並べ、",
        ref("factorization_of_A_theta_general"),
        " を ",
        math(String.raw`\theta = \tilde\theta_\mu \in \mathbb{R}`),
        " として適用すると、主張の左辺から一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(T_{(V^{(+)})}(\check{Z}_\mu),\ T_{(V^{(+)})}(\check{Y}_\mu)\right)
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix}
   B_1(\tilde\theta)\, B_2\, B_1(\tilde\theta)
   \quad (\because \text{(z), (y) の鎖と def\_B1\_theta\_B2}) \\
&= \begin{pmatrix}\check{Z}_\mu, & \check{Y}_\mu\end{pmatrix} A(\tilde\theta_\mu)
   \quad (\because \text{factorization\_of\_A\_theta\_general})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "008 章の T_V_hatZ_hatY の半整数運動量版。008 章はこのブロックの proof の中で B_1 B_2 B_1 = A(θ) の行列計算も行っていたが、ここではそれを factorization_of_A_theta_general として θ ∈ R 一般の独立した claim に分け、本ブロックは合成の計算だけを扱う形にした。",
        "M=2,3,4,5、μ=1..M、5 組の (K1,K2)（臨界点上・臨界点近傍を含む）について、V^{(+)} を行列指数関数から直接構成して (T(checkZ), T(checkY)) = (checkZ, checkY) A(θ~_μ) を数値確認済み（sagemath/check/047_claim_even_sector_T_action/check_04_T_V_plus_and_factorization.sage の (3)）。",
        "同じ検証で γ_2(θ~_μ) ≠ 0 が全 μ で成り立つことも数値で確認した（最小 |γ_2| は 0.56 以上）。これは章 C′ の残りの段（A(θ~) の対角化）で臨界点の例外処理が不要になることを示唆する事実であり、本章では使っていない。",
        "2026-08-19 の式変形統一で、(z), (y) の二本の鎖から得た二列を並べる等式と、B_1(θ~_μ) B_2 B_1(θ~_μ) = A(θ~_μ) の適用を、主張の左辺から始まる一続き二段の鎖と行末根拠へまとめた。内容・参照は変えていない。",
      ],
    },
  },
]);
