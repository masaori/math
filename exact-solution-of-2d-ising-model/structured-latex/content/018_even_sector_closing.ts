import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/018_even_sector_closing.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_closing",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ の決定と Onsager の自由エネルギー}` },
    labels: [],
  },

  {
    id: "closing_remark_overview_c_plus_and_onsager",
    kind: "remark",
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) \text{ を } \Lambda^{(1/2)}_{M_{\mathrm{col}}} \text{ で決める道筋}` },
    labels: [],
    statement: [
      paragraph([
        ref("def_sector_rayleigh_sup"),
        " の ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルにわたる上限であり、",
        ref("symmetrized_transfer_matrix_on_sectors"),
        " の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " により ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上では ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致する。したがって、",
        ref("max_eigenvalue_of_V_plus_simple"),
        " の ",
        math(String.raw`V^{(+)}`),
        " の最大固有値 ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`,
      ),
      paragraph([
        "は容易である。逆向きの不等号には、",
        math(String.raw`\check\Lambda_{\max}`),
        " の固有ベクトルが ",
        math(String.raw`\mathcal{F}^{(+)}`),
        " に属すること（",
        ref("max_eigenvector_in_even_sector"),
        "）を使う。",
      ]),
      paragraph([
        "そのうえで ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "（",
        ref("c_plus_equals_Lambda_half_integer"),
        "）を示し、",
        ref("onsager_free_energy_expression"),
        " と合わせて ",
        ref("remark_remaining_input_even_sector"),
        " の「残っている入力」を解消する（",
        ref("onsager_exact_solution"),
        "）。",
      ]),
      paragraph([
        "この章で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
        ref("def_exp"),
        "）、トレース（",
        ref("def_trace"),
        "）、有限個の実数の和と積、および ",
        math(String.raw`\cosh, \sinh, \log`),
        " だけである。積分が現れるのは ",
        ref("riemann_sum_to_integral"),
        " を引く最後の主張だけで、そこが ",
        ref("remark_real_analysis_escape_point"),
        " を使って有限和の極限を積分として計算する。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、旧い章の案内文 closing_000_remark_overview のうち c_+(M) と Onsager の自由エネルギーに関わる段落を、この案内文として 018 に残した（残りは V^{(+)} の最大固有値に属する固有ベクトルの章の案内文になった）。",
      ],
    },
  },

  {
    id: "closing_008_claim_check_Q_is_hermitian",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\check{n}_\mu, \check{Q}_\epsilon \text{ はエルミート}` },
    labels: ["check_number_operator_is_hermitian"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " とする。",
        math(String.raw`X^*`),
        " を ",
        ref("def_hermitian_positive_definite"),
        " の転置共役とすると、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad Z_j^* = Z_j, \qquad Y_j^* = Y_j
\qquad (j \in \{1,\dots,M_{\mathrm{col}}\})`),
        ],
        [
          math(String.raw`\text{(2)}\quad \check{Z}_\mu^* = \check{Z}_{M_{\mathrm{col}}+1-\mu},
\qquad \check{Y}_\mu^* = \check{Y}_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(3)}\quad \left(\check\psi_\mu^\dagger\right)^*
= \check\psi_{M_{\mathrm{col}}+1-\mu}`),
        ],
        [
          math(String.raw`\text{(4)}\quad \check{n}_\mu^* = \check{n}_\mu,
\qquad \check{Q}_\epsilon^* = \check{Q}_\epsilon
\qquad \left(\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right)`),
        ],
      ]),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Q}_\epsilon`),
        " はエルミートな冪等行列なので、任意の ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " について",
      ]),
      displayMath(
        String.raw`x^*\check{Q}_\epsilon x
= x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
= \left\|\check{Q}_\epsilon x\right\|^2 \geq 0`,
      ),
      paragraph(["である。"]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("Z_Y_linearly_independent"),
        " の証明で用いた Pauli 行列の成分表示より ",
        math(String.raw`\left(\sigma^x\right)^* = \sigma^x`),
        "、",
        math(String.raw`\left(\sigma^y\right)^* = \sigma^y`),
        "、",
        math(String.raw`\left(\sigma^z\right)^* = \sigma^z`),
        " である（",
        math(String.raw`\sigma^y`),
        " は転置で ",
        math(String.raw`(1,2)`),
        " 成分 ",
        math(String.raw`-i`),
        " と ",
        math(String.raw`(2,1)`),
        " 成分 ",
        math(String.raw`i`),
        " が入れ替わり、複素共役でさらに符号が戻る）。",
        ref("kronecker_product_rule"),
        " (2) の成分の定義より ",
        math(String.raw`\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^*
= A_1^*\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^*`),
        " なので ",
        math(String.raw`\left(\sigma_k^a\right)^* = \sigma_k^a`),
        "（",
        math(String.raw`a \in \{x,y,z\}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`(XW)^* = W^*X^*`),
        " と、相異なるサイトの因子が可換であること（",
        ref("kronecker_product_rule"),
        " (1)）から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_j^*
&= \left(\sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z\right)^*
   \quad (\because \text{def\_transfer\_matrix\_symbols}) \\
&= \left(\sigma_j^z\right)^*\left(\sigma_{j-1}^x\right)^*\cdots\left(\sigma_1^x\right)^*
   \quad (\because (XW)^* = W^*X^*) \\
&= \sigma_j^z\,\sigma_{j-1}^x\cdots\sigma_1^x
   \quad (\because \text{直前の段落}) \\
&= \sigma_1^x\cdots\sigma_{j-1}^x\sigma_j^z
   \quad (\because \text{相異なるサイトの因子は可換}) \\
&= Z_j
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`Y_j`),
        " も同じ計算である。",
      ]),
      paragraph([
        "(2) ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) より ",
        math(String.raw`\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \exp(ij\tilde\theta_\mu)`),
        " である。",
        math(String.raw`\tilde\theta_\mu \in \mathbb{R}`),
        " なので ",
        ref("euler_formula_cos_sin"),
        " より ",
        math(String.raw`\overline{\exp(-ij\tilde\theta_\mu)} = \exp(ij\tilde\theta_\mu)`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_\mu^*
&= \left(\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Z_j\right)^*
   \quad (\because \text{def\_half\_integer\_modes}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\overline{\exp(-ij\tilde\theta_\mu)}\;Z_j^*
   \quad (\because \text{転置共役は和を保ち、スカラー倍を複素共役つきで保つ}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(ij\tilde\theta_\mu)\,Z_j
   \quad (\because \text{(1) と } \tilde\theta_\mu \in \mathbb{R}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu})\,Z_j
   \quad (\because \text{conjugate\_index\_of\_check\_Z\_Y (2)}) \\
&= \check{Z}_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{def\_half\_integer\_modes})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\check{Y}_\mu`),
        " も同じ計算である（",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M_{\mathrm{col}}+1-\mu \in \check{\mathcal{M}}`),
        " なので右辺は定義されている）。",
      ]),
      paragraph([
        "(3) ",
        ref("def_check_fermi"),
        " より、",
        math(String.raw`\nu := M_{\mathrm{col}}+1-\mu`),
        "、",
        math(String.raw`\beta := \dfrac{1}{2\sqrt{M_{\mathrm{col}}}} \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`\alpha_\mu := \dfrac{-\left|\gamma_2(\tilde\theta_\mu)\right|}
{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}`),
        " とおくと",
      ]),
      displayMath(
        String.raw`\check\psi_\mu^\dagger = \alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu,
\qquad
\check\psi_\nu = -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu`,
      ),
      paragraph([
        "である。まず ",
        math(String.raw`\overline{\alpha_\mu} = -\alpha_\nu`),
        " を示す。",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の ",
        math(String.raw`\gamma_2(-\tilde\theta_\mu) = -\overline{\gamma_2(\tilde\theta_\mu)}`),
        " より ",
        math(String.raw`\left|\gamma_2(-\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\mu)\right|`),
        " であり、",
        ref("periodicity_of_check_fermi"),
        " (3) より ",
        math(String.raw`\gamma_2(\tilde\theta_\nu) = \gamma_2(-\tilde\theta_\mu)`),
        "、",
        math(String.raw`\gamma_2(-\tilde\theta_\nu) = \gamma_2(\tilde\theta_\mu)`),
        " である。よって ",
        math(String.raw`r := \left|\gamma_2(\tilde\theta_\mu)\right|
= \left|\gamma_2(\tilde\theta_\nu)\right| \in \mathbb{R}_{>0}`),
        "（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）と書けて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\overline{\alpha_\mu}
&= \overline{\left(\frac{-r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\mu)}\right)}
   \quad (\because \alpha_\mu \text{ の定義}) \\
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\,\overline{\gamma_2(-\tilde\theta_\mu)}}
   \quad \left(\because r, 2\sqrt{M_{\mathrm{col}}} \in \mathbb{R} \text{ と }
   \overline{z^{-1}} = \left(\bar z\right)^{-1}\right) \\
&= \frac{-r}{2\sqrt{M_{\mathrm{col}}}\left(-\gamma_2(\tilde\theta_\mu)\right)}
   \quad \left(\because \text{relation\_of\_gamma\_2\_theta\_tilde (1) を }
   \overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)
   \text{ の形で使う}\right) \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(\tilde\theta_\mu)} \\
&= \frac{r}{2\sqrt{M_{\mathrm{col}}}\,\gamma_2(-\tilde\theta_\nu)}
   \quad (\because \text{periodicity\_of\_check\_fermi (3)}) \\
&= -\alpha_\nu
   \quad (\because \alpha_\nu \text{ の定義と }
   \left|\gamma_2(\tilde\theta_\nu)\right| = r)
\end{aligned}`,
      ),
      paragraph([
        "（3 段目で使った ",
        math(String.raw`\overline{\gamma_2(-\tilde\theta_\mu)} = -\gamma_2(\tilde\theta_\mu)`),
        " は、",
        ref("relation_of_gamma_2_theta_tilde"),
        " (1) の両辺の複素共役を取り ",
        math(String.raw`\overline{\overline{z}} = z`),
        " を使ったものである。）これを使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_\mu^\dagger\right)^*
&= \left(\alpha_\mu\check{Z}_\mu + \beta\check{Y}_\mu\right)^*
   \quad (\because \text{def\_check\_fermi}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\mu^* + \overline{\beta}\,\check{Y}_\mu^*
   \quad (\because \text{転置共役の線型性（複素共役つき）}) \\
&= \overline{\alpha_\mu}\,\check{Z}_\nu + \beta\,\check{Y}_\nu
   \quad (\because \text{(2) と } \beta \in \mathbb{R}) \\
&= -\alpha_\nu\check{Z}_\nu + \beta\check{Y}_\nu
   \quad \left(\because \overline{\alpha_\mu} = -\alpha_\nu\right) \\
&= \check\psi_\nu
   \quad (\because \text{def\_check\_fermi})
\end{aligned}`,
      ),
      paragraph([
        "(4) (3) の両辺の転置共役を取り ",
        math(String.raw`(X^*)^* = X`),
        " を使うと ",
        math(String.raw`\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^* = \check\psi_\mu^\dagger`),
        " である。よって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu^*
&= \left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^*
&&\left(\because\ \text{def\_check\_fermi}\right)\\
&= \left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^*\left(\check\psi_\mu^\dagger\right)^*
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&= \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}
&&\left(\because\ \text{(3) とその転置共役}\right)\\
&= \check{n}_\mu
&&\left(\because\ \text{def\_check\_fermi}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}`),
        "（",
        math(String.raw`R_\mu^{(1)} = \check{n}_\mu`),
        "、",
        math(String.raw`R_\mu^{(0)} = I - \check{n}_\mu`),
        "）について、各因子はエルミートで（",
        math(String.raw`I^* = I`),
        "）、",
        ref("check_number_operators_commute"),
        " (2) より互いに可換なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon^*
&= \left(R_1^{(\epsilon_1)}\cdots R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\right)^*
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)\\
&= \left(R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\right)^*\cdots\left(R_1^{(\epsilon_1)}\right)^*
&&\left(\because\ (XW)^*=W^*X^*\text{ の反復適用}\right)\\
&= R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}\cdots R_1^{(\epsilon_1)}
&&\left(\because\ \check n_\mu^*=\check n_\mu\text{ と }I^*=I\right)\\
&= R_1^{(\epsilon_1)}\cdots R_{M_{\mathrm{col}}}^{(\epsilon_{M_{\mathrm{col}}})}
&&\left(\because\ \text{因子の可換性。check\_number\_operators\_commute (2)}\right)\\
&= \check{Q}_\epsilon
&&\left(\because\ \text{check\_joint\_eigenspace\_decomposition}\right)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (1) の ",
        math(String.raw`\check{Q}_\epsilon^2 = \check{Q}_\epsilon`),
        " と合わせると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^*\check{Q}_\epsilon x
&=x^*\check{Q}_\epsilon^*\check{Q}_\epsilon x
&&\left(\because\ \check{Q}_\epsilon^*=\check{Q}_\epsilon\text{ と }\check{Q}_\epsilon^2=\check{Q}_\epsilon\right)\\
&=\left(\check{Q}_\epsilon x\right)^*\left(\check{Q}_\epsilon x\right)
&&\left(\because\ (XW)^*=W^*X^*\right)\\
&=\left\|\check{Q}_\epsilon x\right\|^2
&&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&\geq0
&&\left(\because\ \text{実数の平方和は非負}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "c_+(M) ≤ Λ̌_max を示すのに必要なのは「Q̌_ε がエルミートな冪等行列であること」だけである。これがあれば x^*V^{(+)}x = Σ_ε Λ̌_ε ‖Q̌_ε x‖² と書けて、スペクトル定理（実対称行列の対角化可能性）を持ち出さずに Rayleigh 商の上限が押さえられる。011 章が「固有値の存在を使わない」方針を取っているのと整合する。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（(ψ̌_μ^†)^* = ψ̌_{M+1−μ}、ň_μ, Q̌_ε のエルミート性、残差 ≤ 1.2e-14）。",
      ],
    },
  },

  {
    id: "closing_009_theorem_c_plus_equals_Lambda_half",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}` },
    labels: ["c_plus_equals_Lambda_half_integer"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_sector_rayleigh_sup"),
        " の",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) = \sup\left\{\, x^\top W x \ \middle|\
x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}},\ \|x\| = 1 \,\right\}`,
      ),
      paragraph([
        "と ",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " について",
      ]),
      displayMath(
        String.raw`c_+(M_{\mathrm{col}}) = \check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}
= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "が成り立つ。**上限は達成される**（最大値である）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（",
        math(String.raw`\mathcal{F}^{(+)}`),
        " の上で ",
        math(String.raw`W`),
        " と ",
        math(String.raw`V^{(+)}`),
        " が一致すること）。",
        math(String.raw`x \in \mathcal{F}^{(+)}`),
        " なら、",
        ref("def_epsilon_projectors"),
        " と ",
        ref("def_even_eigenvectors_of_epsilon"),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
P^{(+)}x
&= \tfrac12(x + \varepsilon x)
   \quad (\because \blkref{def_epsilon_projectors}\text{ の } P^{(+)} \text{ の定義}) \\
&= \tfrac12(x + x)
   \quad (\because x \in \mathcal{F}^{(+)} \text{ より } \varepsilon x = x.\ \blkref{def_even_eigenvectors_of_epsilon}) \\
&= x
   \quad (\because \text{スカラー倍を整理する})
\end{aligned}`,
      ),
      paragraph([
        "である。したがって ",
        ref("symmetrized_transfer_matrix_on_sectors"),
        " の ",
        math(String.raw`WP^{(+)} = V^{(+)}P^{(+)}`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Wx
&= WP^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x) \\
&= V^{(+)}P^{(+)}x
   \quad (\because \blkref{symmetrized_transfer_matrix_on_sectors}\text{ の }
   WP^{(+)} = V^{(+)}P^{(+)}) \\
&= V^{(+)}x
   \quad (\because \text{直前の } P^{(+)}x = x)
\end{aligned}
\qquad \left(x \in \mathcal{F}^{(+)}\right)`,
      ),
      paragraph([
        "Step 1（",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x \in \mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " とする。",
        math(String.raw`x`),
        " は実ベクトルなので ",
        math(String.raw`x^\top = x^*`),
        " である。",
        ref("check_joint_eigenspace_decomposition"),
        " (2) と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top W x
&= x^*V^{(+)}x
   \quad (\because \text{Step 0 と } x^\top = x^*) \\
&= x^*V^{(+)}\left(\sum_{\epsilon}\check{Q}_\epsilon\right)x
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (2)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon\,x^*\check{Q}_\epsilon x
   \quad (\because \text{eigenvalues\_of\_V\_plus (1)}) \\
&= \sum_{\epsilon}\check\Lambda_\epsilon
   \left\|\check{Q}_\epsilon x\right\|^2
   \quad (\because \text{check\_number\_operator\_is\_hermitian (4)})
\end{aligned}`,
      ),
      paragraph([
        ref("eigenvalues_of_V_plus"),
        " (2) より ",
        math(String.raw`0 < \check\Lambda_\epsilon \leq \check\Lambda_{\max}`),
        " であり、各 ",
        math(String.raw`\left\|\check{Q}_\epsilon x\right\|^2 \geq 0`),
        " なので",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x^\top Wx
&\leq \check\Lambda_{\max}
 \sum_{\epsilon}\left\|\check{Q}_\epsilon x\right\|^2
 &&\left(\because\ 0<\check\Lambda_\epsilon\leq\check\Lambda_{\max}
 \text{ と }\left\|\check{Q}_\epsilon x\right\|^2\geq0\right)\\
&= \check\Lambda_{\max}\sum_{\epsilon}x^*\check{Q}_\epsilon x
 &&\left(\because\ \check Q_\epsilon\text{ はエルミートな冪等行列}
 \text{（check\_number\_operator\_is\_hermitian (4)）}\right)\\
&= \check\Lambda_{\max}\,x^*\!\left(\sum_{\epsilon}\check{Q}_\epsilon\right)\!x
 &&\left(\because\ \text{有限和に対する行列積の分配則}\right)\\
&= \check\Lambda_{\max}\,x^*x
 &&\left(\because\ \sum_\epsilon\check Q_\epsilon=I
 \text{（check\_joint\_eigenspace\_decomposition (2)）}\right)\\
&= \check\Lambda_{\max}\,\|x\|^2
 &&\left(\because\ \text{複素ベクトルのノルムの定義}\right)\\
&= \check\Lambda_{\max}
 &&\left(\because\ \|x\|=1\right)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`x`),
        " は任意だったので ",
        math(String.raw`c_+(M_{\mathrm{col}}) \leq \check\Lambda_{\max}`),
        "。",
      ]),
      paragraph([
        "Step 2（実の最大固有ベクトルの存在）。",
        ref("check_joint_eigenspace_decomposition"),
        " (4) より ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " は 1 次元なので、生成元 ",
        math(String.raw`q \neq 0`),
        " を取る。",
        ref("eigenvalues_of_V_plus"),
        " (1) より ",
        math(String.raw`V^{(+)}q = \check\Lambda_{\max}q`),
        " である。",
      ]),
      paragraph([
        math(String.raw`V^{(+)}`),
        " の成分は実である。実際 ",
        ref("V_plus_is_positive_definite"),
        " の表示 ",
        math(String.raw`V^{(+)} = (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(\tfrac12S_1^{(+)}\right)
\exp(S_2)\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " において、",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`S_1^{(+)}, S_2`),
        " は実対称であり、",
        ref("W_is_real_symmetric_positive_definite"),
        " の Step 2 と同じ議論（実対称行列の冪は実対称、",
        ref("def_exp"),
        " の部分和も実対称、",
        ref("star_preserves_norm_and_limits"),
        " (3) と同様に転置もノルムを保つので極限も実対称）により ",
        math(String.raw`\exp\!\left(\tfrac12S_1^{(+)}\right)`),
        " と ",
        math(String.raw`\exp(S_2)`),
        " は実対称、",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`V^{(+)}`),
        " も実行列である。",
      ]),
      paragraph([
        "したがって ",
        math(String.raw`\overline{V^{(+)}q} = V^{(+)}\overline{q}`),
        " であり、",
        math(String.raw`\check\Lambda_{\max} \in \mathbb{R}`),
        "（",
        ref("eigenvalues_of_V_plus"),
        "）なので ",
        math(String.raw`V^{(+)}\overline{q} = \check\Lambda_{\max}\overline{q}`),
        "。",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) より固有空間は 1 次元の ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)} = \mathbb{C}q`),
        " なので、ある ",
        math(String.raw`z \in \mathbb{C}`),
        " で ",
        math(String.raw`\overline{q} = zq`),
        " と書ける。",
      ]),
      paragraph([
        "ここで ",
        math(String.raw`p := q + \overline{q} = (1+z)q`),
        "、",
        math(String.raw`p' := i\left(q - \overline{q}\right) = i(1-z)q`),
        " とおくと、",
        math(String.raw`\overline{p} = p`),
        "、",
        math(String.raw`\overline{p'} = \overline{i}\left(\overline{q}-q\right)
= (-i)\left(\overline{q}-q\right) = p'`),
        " なので ",
        math(String.raw`p, p'`),
        " はいずれも実ベクトルである。",
        math(String.raw`1+z`),
        " と ",
        math(String.raw`i(1-z)`),
        " が同時に ",
        math(String.raw`0`),
        " になることはない（",
        math(String.raw`z = -1`),
        " かつ ",
        math(String.raw`z = 1`),
        " は不可能）ので、",
        math(String.raw`p`),
        " と ",
        math(String.raw`p'`),
        " の少なくとも一方は ",
        math(String.raw`0`),
        " でない。それを ",
        math(String.raw`v`),
        " とすると ",
        math(String.raw`v \in \mathbb{C}q\setminus\{0\}`),
        " かつ ",
        math(String.raw`v \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " である。",
        math(String.raw`x_0 := v/\|v\|`),
        " とおく。",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`c_+(M_{\mathrm{col}}) \geq \check\Lambda_{\max}`),
        "）。",
        math(String.raw`x_0 \in \mathbb{C}q = \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " なので ",
        ref("max_eigenvector_in_even_sector"),
        " (4) より ",
        math(String.raw`x_0 \in \mathcal{F}^{(+)}`),
        " であり、",
        math(String.raw`x_0`),
        " は実で ",
        math(String.raw`\|x_0\| = 1`),
        " である。Step 0 と ",
        ref("eigenvalues_of_V_plus"),
        " (1) より",
      ]),
      displayMath(
        String.raw`x_0^\top Wx_0
= x_0^\top V^{(+)}x_0
= x_0^\top\left(\check\Lambda_{\max}x_0\right)
= \check\Lambda_{\max}\,x_0^\top x_0
= \check\Lambda_{\max}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`c_+(M_{\mathrm{col}})`),
        " を定める集合は ",
        math(String.raw`\check\Lambda_{\max}`),
        " を要素にもち、",
        math(String.raw`c_+(M_{\mathrm{col}}) \geq \check\Lambda_{\max}`),
        "。Step 1 と合わせて ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \check\Lambda_{\max}`),
        " であり、上限は ",
        math(String.raw`x_0`),
        " で達成される。",
      ]),
      paragraph([
        "最後に ",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (1) の ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " を代入すれば主張の等式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "分割前の上限のセクター分解の注記が「c_+(M) に対応する V^{(+)} の固有値は本文では未確立」としていた点が、ここで解消される。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_04（P^{(+)}WP^{(+)} を F^{(+)} の実基底へ制限して最大固有値を直接求め、Λ^{(1/2)}_M と比較。相対差 ≤ 2e-14）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },

  {
    id: "closing_010_theorem_onsager_exact_solution",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: SRC, ordinal: 12 },
    title: { text: "2 次元 Ising 模型の厳密解（Onsager の自由エネルギー）" },
    labels: ["onsager_exact_solution"],
    statement: [
      paragraph([
        ref("partition_function_via_transfer_matrix"),
        " と同じ設定（結合定数 ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "）のもとで、",
      ]),
      displayMath(
        String.raw`\lim_{M_{\mathrm{col}}\to\infty}\ \lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2)
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "が成り立つ。ここで",
      ]),
      displayMath(
        String.raw`\gamma(\theta)
= \mathrm{arccosh}\!\left(\cosh 2K_1\cosh 2K_2^*
- \sinh 2K_1\sinh 2K_2^*\cos\theta\right)`,
      ),
      paragraph([
        "であり（",
        ref("gamma1_lower_bound_all_theta"),
        "）、これが Onsager の自由エネルギーの表式である。",
      ]),
      paragraph([
        "とくに ",
        ref("remark_remaining_input_even_sector"),
        " が「残っている入力」として挙げていた ",
        math(String.raw`c_+(M_{\mathrm{col}}) = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " は ",
        ref("c_plus_equals_Lambda_half_integer"),
        " で証明された。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`N_{\mathrm{row}}`),
        " の極限）。",
        ref("limit_of_log_Z_in_N_row"),
        " より、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " を固定すると",
      ]),
      displayMath(
        String.raw`\lim_{N_{\mathrm{row}}\to\infty}
\frac{1}{M_{\mathrm{col}}\,N_{\mathrm{row}}}\log Z(K_1,K_2) = \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})`,
      ),
      paragraph([
        "である。以下 ",
        math(String.raw`c(M_{\mathrm{col}})`),
        " の ",
        math(String.raw`M_{\mathrm{col}} \to \infty`),
        " の挙動を調べる。",
      ]),
      paragraph([
        "Step 2（下からの評価 ",
        math(String.raw`c(M_{\mathrm{col}}) \geq \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "）。",
        ref("c_plus_le_c"),
        " と ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
c(M_{\mathrm{col}})
&\geq c_+(M_{\mathrm{col}})
&&\left(\because\ \blkref{c_plus_le_c}\right)\\
&= \Lambda^{(1/2)}_{M_{\mathrm{col}}}
&&\left(\because\ \blkref{c_plus_equals_Lambda_half_integer}\right)
\end{aligned}`),
      paragraph([
        "Step 3（上からの評価 ",
        math(String.raw`c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "）。",
        math(String.raw`x \in \mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        "、",
        math(String.raw`\|x\| = 1`),
        " を任意に取る。成分ごとの絶対値を取ったベクトルを ",
        math(String.raw`u`),
        "（",
        math(String.raw`u_k := |x_k|`),
        "）とし、",
        math(String.raw`v := u + \varepsilon u`),
        " とおく。",
      ]),
      paragraph([
        ref("W_has_positive_entries"),
        " より ",
        math(String.raw`W`),
        " の成分はすべて正なので、",
      ]),
      displayMath(
        String.raw`u^\top Wu = \sum_{k,l}|x_k|\,|x_l|\,W_{kl}
\ \geq\ \left|\sum_{k,l}x_kx_lW_{kl}\right|
\ \geq\ x^\top Wx
\quad (\because \text{三角不等式と } W_{kl} > 0)`,
      ),
      paragraph([
        "である。また ",
        math(String.raw`\varepsilon`),
        " は各基底ベクトルを別の基底ベクトルへ写す置換行列（",
        ref("trace_of_epsilon_V_plus"),
        " の証明 Step 3 の (b)）なので、",
        math(String.raw`u \geq 0`),
        " なら ",
        math(String.raw`\varepsilon u \geq 0`),
        " であり、",
      ]),
      displayMath(String.raw`\begin{aligned}
\|\varepsilon u\|
&= \|u\|
&&\left(\because\ \varepsilon\ \text{は置換行列であり、成分の並べ替えは二乗和を変えない}\right)\\
&= \|x\|
&&\left(\because\ u_k=|x_k|\ \text{であり、ノルムは成分の絶対値だけで決まる}\right)\\
&= 1
&&\left(\because\ \|x\|=1\ \text{（Step 3 の }x\text{ の取り方）}\right)
\end{aligned}`),
      paragraph([
        "である。さらに ",
        math(String.raw`\varepsilon^\top = \varepsilon`),
        "（",
        ref("epsilon_is_real_symmetric"),
        "）、",
        math(String.raw`\varepsilon^2 = I`),
        "（",
        ref("epsilon_square_and_eigenvalues"),
        "）である。",
      ]),
      list([
        [
          displayMath(String.raw`\begin{aligned}
\varepsilon v
&= \varepsilon\left(u+\varepsilon u\right)
&&\left(\because\ v=u+\varepsilon u\right)\\
&= \varepsilon u+\varepsilon^2u
&&\left(\because\ \text{行列の分配則}\right)\\
&= \varepsilon u+u
&&\left(\because\ \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I\right)\\
&=v
&&\left(\because\ v=u+\varepsilon u\right)
\end{aligned}`),
          " より ",
          math(String.raw`v \in \mathcal{F}^{(+)}`),
          "（",
          ref("def_even_eigenvectors_of_epsilon"),
          "）。また ",
          math(String.raw`v`),
          " は実である。",
        ],
        [
          math(String.raw`v \geq u \geq 0`),
          " かつ ",
          math(String.raw`u \neq 0`),
          " より ",
          math(String.raw`v \neq 0`),
          "。",
        ],
        [
          displayMath(String.raw`\begin{aligned}
\|v\|^2
&= \|u\|^2 + 2u^\top\varepsilon u + \|\varepsilon u\|^2
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }\varepsilon^\top=\varepsilon.\ \blkref{epsilon_is_real_symmetric}\right)\\
&= 2 + 2u^\top\varepsilon u
&&\left(\because\ \|u\| = \|\varepsilon u\| = 1\right)\\
&\leq 4
&&\left(\because\ \text{Cauchy–Schwarz より } u^\top\varepsilon u \leq \|u\|\|\varepsilon u\| = 1\right)
\end{aligned}`),
        ],
        [
          displayMath(String.raw`\begin{aligned}
v^\top Wv
&=u^\top Wu+2u^\top W\varepsilon u+(\varepsilon u)^\top W(\varepsilon u)
&&\left(\because\ v=u+\varepsilon u\text{ の展開と }W^\top=W\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top\varepsilon W\varepsilon u
&&\left(\because\ \blkref{epsilon_is_real_symmetric}\text{ の }\varepsilon^\top=\varepsilon\right)\\
&=u^\top Wu+2u^\top W\varepsilon u+u^\top W\varepsilon^2u
&&\left(\because\ \varepsilon W=W\varepsilon.\ \blkref{epsilon_commutes_with_W}\right)\\
&=2u^\top Wu+2u^\top W\varepsilon u
&&\left(\because\ \blkref{epsilon_square_and_eigenvalues}\text{ の }\varepsilon^2=I\right)\\
&\geq2u^\top Wu
&&\left(\because\ u,\varepsilon u\geq0\text{ と }W_{kl}>0\text{ より }u^\top W\varepsilon u\geq0\right)
\end{aligned}`),
        ],
      ]),
      paragraph([
        math(String.raw`\hat{v} := v/\|v\|`),
        " は ",
        math(String.raw`\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}`),
        " の単位ベクトルなので ",
        ref("c_plus_equals_Lambda_half_integer"),
        " より",
      ]),
      displayMath(String.raw`\begin{aligned}
\Lambda^{(1/2)}_{M_{\mathrm{col}}}
&= c_+(M_{\mathrm{col}})
&&\left(\because\ \blkref{c_plus_equals_Lambda_half_integer}\right)\\
&\geq \hat{v}^\top W\hat{v}
&&\left(\because\ c_+(M_{\mathrm{col}})\text{ は }\mathcal{F}^{(+)}\cap\mathbb{R}^{2^{M_{\mathrm{col}}}}\text{ の単位ベクトル上の上限. }\blkref{def_sector_rayleigh_sup}\right)\\
&= \frac{v^\top Wv}{\|v\|^2}
&&\left(\because\ \hat{v}=v/\|v\|\text{ の代入と二次形式の斉次性}\right)\\
&\geq \frac{2\,u^\top Wu}{\|v\|^2}
&&\left(\because\ v^\top Wv\geq2u^\top Wu\text{（上の式変形）と }\|v\|^2>0\right)\\
&\geq \frac{2\,u^\top Wu}{4}
&&\left(\because\ \|v\|^2\leq4\text{（上の式変形）と }u^\top Wu\geq0\text{（}u\geq0,\ W_{kl}>0\text{）}\right)\\
&= \frac{u^\top Wu}{2}
&&\left(\because\ \mathbb{R}\text{ の約分}\right)\\
&\geq \frac{x^\top Wx}{2}
&&\left(\because\ u^\top Wu\geq x^\top Wx\text{（上の三角不等式）}\right)
\end{aligned}`),
      paragraph([
        math(String.raw`x`),
        " は任意だったので、上限を取って ",
        math(String.raw`c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        "。",
      ]),
      paragraph([
        "Step 4（挟み撃ち）。Step 2・Step 3 より ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \leq c(M_{\mathrm{col}}) \leq 2\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " であり、すべて正の実数なので ",
        math(String.raw`\log`),
        " の単調性から",
      ]),
      displayMath(
        String.raw`\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
\ \leq\ \frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
\ \leq\ \frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}} + \frac{\log 2}{M_{\mathrm{col}}}`,
      ),
      paragraph([
        math(String.raw`(\log 2)/M_{\mathrm{col}} \to 0`),
        " なので、",
        ref("onsager_free_energy_expression"),
        " を ",
        math(String.raw`\delta = \tfrac12`),
        " として適用すると",
      ]),
      displayMath(
        String.raw`\lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log c(M_{\mathrm{col}})
= \lim_{M_{\mathrm{col}}\to\infty}\frac{1}{M_{\mathrm{col}}}\log\Lambda^{(1/2)}_{M_{\mathrm{col}}}
= \frac{1}{2}\log\left(2\sinh 2K_2\right)
+ \frac{1}{4\pi}\int_0^{2\pi}\gamma(\theta)\,d\theta`,
      ),
      paragraph([
        "Step 1 と合わせて主張の 2 重極限の値が定まる。",
      ]),
      paragraph([
        "**実数解析（Riemann 積分）を使ったのは ",
        ref("riemann_sum_to_integral"),
        " を経由する最後の等号だけである**（",
        ref("remark_real_analysis_escape_point"),
        "）。それ以外の段はすべて有限サイズの複素行列の積・和・トレースと、",
        "有限個の実数の不等式で書かれている。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "Step 3 の係数 2 は最良ではない（数値では c(M) = c_+(M) が全パラメータで成り立つ。sagemath/check/053_claim_even_sector_closing/check_05 (3')）。しかし 1/M を掛けて M → ∞ とすると log 2 / M → 0 で消えるため、Onsager の表式を出すにはこの粗い評価で十分である。",
        "この粗い評価を採ったのは c_-(M) の値に依存しないためである。一次情報で確認したところ c_-(M) = Λ^{(0)}_M は一般には成り立たない: 高温側 (K_1,K_2) = (0.05,0.1)（sinh2K_1 sinh2K_2 ≈ 0.020）では c_-(M)/Λ^{(0)}_M = 0.1102 で、M = 2,3,4,5 のすべてで一致しない（同 check_05 の対照出力）。V^{(-)} の最大固有値の固有ベクトルが F^{(+)} 側に落ちる場合があるためで、偶セクターで解決したのと同じ問題が奇セクターでは別の答えになりうる。本文はこの点に触れずに済む形にしてある。",
        "数値検証: sagemath/check/053_claim_even_sector_closing/check_05（M=2,3,4,5 で c(M) = max(c_+,c_-) と W の最大固有値の一致、Λ^{(1/2)}_M ≤ c(M) ≤ 2Λ^{(1/2)}_M、および M を大きくしたときの (1/M) log Λ^{(1/2)}_M の Onsager 積分への収束）。",
        "2026-09-26: V_1, V_2 の定義を分配関数の章の成分定義 1 つにし、パウリ行列表示を転送行列の章の主張にした（記号を M_col, N_row, K_1, K_2 に統一）。参照を新しいラベル（<partition_function_via_transfer_matrix>・<def_transfer_matrix>・<config_numbering_equals_kronecker_numbering>・<def_row_configurations>）へ付け替え、Z(J,J') を Z(K_1,K_2) にし、読み替えの断り書きを除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
]);
