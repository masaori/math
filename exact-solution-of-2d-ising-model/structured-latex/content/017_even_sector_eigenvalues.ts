import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/017_even_sector_eigenvalues.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_eigenvalues",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\text{定数 } c \text{ の決定と } V^{(+)} \text{ の固有値}` },
    labels: [],
  },

  {
    id: "evenEigen_000_remark_overview",
    kind: "remark",
    origin: { path: SRC, ordinal: 2 },
    title: { text: "この章の目的と、009 章との違い" },
    labels: [],
    statement: [
      paragraph([
        ref("V_plus_eq_c_check_Vprime"),
        " により、ある ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " が存在して ",
        math(String.raw`V^{(+)} = c\,\check{V}'`),
        " が成り立つ。しかし ",
        math(String.raw`c`),
        " の値そのものは決まっていない。この章では ",
        math(String.raw`c`),
        " を決定し、あわせて ",
        math(String.raw`V^{(+)}`),
        " の固有値をすべて求める。結論は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M/2}, \qquad
V^{(+)} = (2\sinh 2K_2)^{M/2}\,\check{V}'`,
      ),
      paragraph([
        "であり、",
        math(String.raw`V^{(+)}`),
        " の固有値は ",
        math(String.raw`\epsilon = (\epsilon_\mu)_{\mu=1}^{M}`),
        "（各 ",
        math(String.raw`\epsilon_\mu \in \{0,1\}`),
        "）でパラメトライズされた",
      ]),
      displayMath(
        String.raw`\check\Lambda_\epsilon = (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)`,
      ),
      paragraph([
        "であり、その最大値は ",
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\Lambda^{(\delta)}_M`),
        " で ",
        math(String.raw`\delta = \tfrac12`),
        " と取ったもの ",
        math(String.raw`\Lambda^{(1/2)}_M`),
        " に一致し、しかも**単純固有値**である。",
      ]),
      paragraph([
        "**道筋は ",
        ref("eigenvalues_of_V"),
        " までの 009 章と同じである。** トレース（",
        ref("def_trace"),
        "、",
        ref("trace_basic_properties"),
        "、",
        ref("trace_of_idempotent"),
        "）、エルミート性と正定値性（",
        ref("def_hermitian_positive_definite"),
        "、",
        ref("star_preserves_norm_and_limits"),
        "、",
        ref("exp_hermitian_is_positive_definite"),
        "）、および符号反転共役（",
        ref("iH_is_real_symmetric"),
        "、",
        ref("sign_flip_conjugation"),
        "）は 009 章で ",
        math(String.raw`(\pm)`),
        " の両符号について述べてあるので、**再定義せずそのまま引く**。この章で新しく書くのは、",
        "半整数運動量に固有の部分だけである。",
      ]),
      paragraph([
        "009 章との差は次の 3 点で、いずれも ",
        ref("gamma_2_theta_tilde_nonzero"),
        "（",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が例外なく成り立つこと）と ",
        ref("def_gamma_theta_tilde_mu"),
        "（",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        "）から来る。",
      ]),
      list([
        [
          "(a) 添字の集合が ",
          math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
          "（",
          ref("def_check_index_set"),
          "）の全部になる。009 章の ",
          ref("def_number_operator"),
          " は ",
          math(String.raw`\mathcal{I} = \{\mu \mid \gamma_2(\theta_\mu) \neq 0\}`),
          " に限定され、臨界点では ",
          math(String.raw`m = |\mathcal{I}| = M-1`),
          " だった（",
          ref("gamma_2_theta_is_0"),
          "）。",
        ],
        [
          "(b) 同時固有空間が**すべて 1 次元**になる。009 章の ",
          ref("joint_eigenspace_decomposition"),
          " (4) の次元 ",
          math(String.raw`2^{M-m}`),
          " は ",
          math(String.raw`m = M`),
          " により ",
          math(String.raw`1`),
          " になり、",
          ref("trace_of_Vprime"),
          " の前因子 ",
          math(String.raw`2^{M-m}`),
          " も消える。",
        ],
        [
          "(c) **最大固有値が単純になる。** 009 章では臨界点で ",
          math(String.raw`\gamma(\theta_M) = 0`),
          " となりうるので ",
          math(String.raw`\Lambda_{\max}`),
          " の単純性は言えない（",
          ref("def_gamma_theta_mu"),
          " は ",
          math(String.raw`\gamma(\theta_\mu) \geq 0`),
          " しか与えない）。半整数運動量では狭義に ",
          math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
          " なので単純性が従う。",
        ],
      ]),
      paragraph([
        "**対になる添字は ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`M+1-\mu`),
        " である**（",
        ref("conjugate_index_of_check_Z_Y"),
        "、",
        ref("anticommutator_of_check_psi"),
        "）。009 章の ",
        math(String.raw`-\mu`),
        " をそのまま写してはならない。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`M+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまるので、**この章の主張はすべて ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について述べられ、",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字は現れない。**",
      ]),
      paragraph([
        "この章で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
        ref("def_exp"),
        "）、および実数の ",
        math(String.raw`\cosh, \sinh, \mathrm{arccosh}`),
        " だけである。行列式は使わない。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章と同じく、c の決定に行列式（Leibniz 定義と乗法性）を使う経路は採らない。tr(V^{(+)})/tr((V^{(+)})^{-1}) = c^2 と符号反転共役 U を使う経路を採る。",
        "009 章の iH_is_real_symmetric と sign_flip_conjugation は S_1^{(±)} = iK_1H_1^{(±)} について複号同順で述べられているので、(+) 側をそのまま引ける（H_1^{(+)} 用に書き直す必要はない）。この点は数値でも残差 0.0 で確認した（sagemath/check/050_claim_even_sector_eigenvalues/check_05）。",
      ],
    },
  },

  {
    id: "evenEigen_001_definition_check_number_operator",
    kind: "definition",
    origin: { path: SRC, ordinal: 3 },
    title: { tex: String.raw`\text{数演算子 } \check{n}_\mu` },
    labels: ["def_check_number_operator"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M \in \mathbb{Z}_{\geq 2}`),
        "、",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）とする。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\mu \in \check{\mathcal{M}}`),
        " なので、",
        ref("def_check_fermi"),
        " により ",
        math(String.raw`\check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`\check\psi_{M+1-\mu}`),
        " は**ともに定義されている**。そこで",
      ]),
      displayMath(
        String.raw`\check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})
\qquad (\mu \in \check{\mathcal{M}})`,
      ),
      paragraph([
        "と定める。以下、",
        math(String.raw`2^M`),
        " 次の単位行列 ",
        math(String.raw`I_{\mathrm{Mat}(2^M,\mathbb{C})}`),
        " を単に ",
        math(String.raw`I`),
        " と書く。次が成り立つ。",
      ]),
      list([
        [
          "(1) 共役添字の対応 ",
          math(String.raw`\mu \mapsto M+1-\mu`),
          " は ",
          math(String.raw`\check{\mathcal{M}}`),
          " 上の対合である：",
          math(String.raw`M+1-(M+1-\mu) = \mu`),
          "。したがって ",
          math(String.raw`\check{n}_\mu`),
          " は ",
          math(String.raw`\mu \in \check{\mathcal{M}}`),
          " の ",
          math(String.raw`M`),
          " 個で尽き、",
          math(String.raw`\check{\mathcal{M}}`),
          " の外の添字は要らない。",
        ],
        [
          "(2) ",
          ref("def_check_Vprime"),
          " の ",
          math(String.raw`\check{X}`),
          " と ",
          math(String.raw`\check{V}'`),
          " はこの記号で",
        ],
      ]),
      displayMath(
        String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)
\left(\check{n}_\mu - \tfrac12 I\right),
\qquad
\check{V}' = \exp\!\left(\check{X}\right)`,
      ),
      paragraph([
        "と書ける。",
        "009 章の ",
        ref("def_number_operator"),
        " が ",
        math(String.raw`n_\mu = \psi_\mu^\dagger\psi_{-\mu}`),
        " を ",
        math(String.raw`\mathcal{I} = \{\mu \in \{1,\dots,M\} \mid \gamma_2(\theta_\mu) \neq 0\}`),
        " の上でしか定義できず、臨界点では ",
        math(String.raw`m := |\mathcal{I}| = M-1`),
        " だったのと違い、**ここでは ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " が例外なく走る**（",
        ref("gamma_2_theta_tilde_nonzero"),
        "）。009 章の記号でいえば ",
        math(String.raw`m = M`),
        " の場合にあたる。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        math(String.raw`M+1-(M+1-\mu) = \mu`),
        " は展開するだけである。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`\mu \mapsto M+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " から ",
        math(String.raw`\check{\mathcal{M}}`),
        " への写像であり、いま示したとおり 2 回施すと恒等写像になるので全単射（対合）である。",
        "したがって ",
        math(String.raw`\check{n}_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）を作るのに ",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字は現れない。",
      ]),
      paragraph([
        "(2) ",
        ref("def_check_Vprime"),
        " の ",
        math(String.raw`\check{X} = \sum_{\mu \in \check{\mathcal{M}}}\gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu} - \tfrac12 I\right)`),
        " の各項の第 1 因子が定義により ",
        math(String.raw`\check{n}_\mu`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の def_number_operator の半整数運動量版。対になる添字は −μ ではなく M+1−μ である（conjugate_index_of_check_Z_Y、def_check_index_set (2)）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01。対を −μ に取り違えると冪等性が残差 2.59 で破れることも対照として確認した。",
      ],
    },
  },

  {
    id: "evenEigen_002_claim_check_number_operator_idempotent",
    kind: "claim",
    origin: { path: SRC, ordinal: 4 },
    title: { tex: String.raw`\check{n}_\mu^2 = \check{n}_\mu` },
    labels: ["check_number_operator_idempotent"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "（",
        ref("def_check_index_set"),
        "）について、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \left(\check\psi_\mu^\dagger\right)^2 = 0,
\qquad \left(\check\psi_{M+1-\mu}\right)^2 = 0`),
        ],
        [
          math(String.raw`\text{(2)}\quad \check\psi_{M+1-\mu}\,\check\psi_\mu^\dagger = I - \check{n}_\mu`),
        ],
        [math(String.raw`\text{(3)}\quad \check{n}_\mu^2 = \check{n}_\mu`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("anticommutator_of_check_psi"),
        " の第 1 式 ",
        math(String.raw`[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger]_+ = 0`),
        " において ",
        math(String.raw`\nu = \mu`),
        " と取ると、反交換子の定義 ",
        math(String.raw`[X,W]_+ = XW + WX`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&= \left[\check\psi_\mu^\dagger, \check\psi_\mu^\dagger\right]_+
   \quad (\because \text{$\check\psi$ の反交換関係の第 1 式で } \nu = \mu) \\
&= \check\psi_\mu^\dagger\check\psi_\mu^\dagger + \check\psi_\mu^\dagger\check\psi_\mu^\dagger
   \quad (\because \text{反交換子の定義}) \\
&= 2\left(\check\psi_\mu^\dagger\right)^2
   \quad (\because \text{同じ項の和})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`2 \neq 0`), " なので、直前の鎖の両辺を 2 で割ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_\mu^\dagger\right)^2
&= \frac12\,2\left(\check\psi_\mu^\dagger\right)^2
   \quad (\because \mathbb C\text{ の四則}) \\
&= \frac12\,0
   \quad (\because \text{直前の鎖}) \\
&= 0
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "第 3 式 ",
        math(String.raw`[\check\psi_\mu, \check\psi_\nu]_+ = 0`),
        " で両方の添字を ", math(String.raw`M+1-\mu`), " と取る。共役添字が ",
        math(String.raw`\check{\mathcal M}`), " に属することは ", ref("def_check_index_set"),
        " (2) による。上と同じ三段を省略せず書くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&= \left[\check\psi_{M+1-\mu},\check\psi_{M+1-\mu}\right]_+
   \quad (\because \text{$\check\psi$ の反交換関係の第 3 式}) \\
&= \check\psi_{M+1-\mu}\check\psi_{M+1-\mu}
  +\check\psi_{M+1-\mu}\check\psi_{M+1-\mu}
   \quad (\because \text{反交換子の定義}) \\
&= 2\left(\check\psi_{M+1-\mu}\right)^2
   \quad (\because \text{同じ項の和})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_{M+1-\mu}\right)^2
&= \frac12\,2\left(\check\psi_{M+1-\mu}\right)^2
   \quad (\because \mathbb C\text{ の四則}) \\
&= \frac12\,0
   \quad (\because \text{直前の鎖}) \\
&= 0
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        ref("anticommutator_of_check_psi"),
        " の第 2 式 ",
        math(String.raw`[\check\psi_\mu^\dagger, \check\psi_\nu]_+ = \delta_{\nu,\,M+1-\mu}\,I`),
        " において ",
        math(String.raw`\nu = M+1-\mu`),
        " と取る。このとき ",
        math(String.raw`\delta_{M+1-\mu,\,M+1-\mu} = 1`),
        " なので（",
        math(String.raw`\check{\mathcal{M}}`),
        " へ絞ったので合同式の計算が要らない）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_{M+1-\mu}\check\psi_\mu^\dagger
&=\left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu}
 +\check\psi_{M+1-\mu}\check\psi_\mu^\dagger\right)
 -\check\psi_\mu^\dagger\check\psi_{M+1-\mu}
   \quad (\because \mathbb C\text{ の四則}) \\
&= I-\check\psi_\mu^\dagger\check\psi_{M+1-\mu}
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式}) \\
&= I-\check n_\mu
   \quad (\because \text{数演算子の定義})
\end{aligned}`,
      ),
      paragraph(["(3) (1)(2) を使って"]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu^2
&= \left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu}\right)
   \left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu}\right)
   \quad (\because \text{数演算子の定義}) \\
&= \check\psi_\mu^\dagger\left(\check\psi_{M+1-\mu}\check\psi_\mu^\dagger\right)\check\psi_{M+1-\mu}
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\mu^\dagger\left(I - \check{n}_\mu\right)\check\psi_{M+1-\mu}
   \quad (\because \text{(2)}) \\
&= \check\psi_\mu^\dagger\check\psi_{M+1-\mu}
   - \check\psi_\mu^\dagger\,\check{n}_\mu\,\check\psi_{M+1-\mu}
   \quad (\because \text{行列の積の分配法則}) \\
&= \check{n}_\mu
   - \check\psi_\mu^\dagger\left(\check\psi_\mu^\dagger\check\psi_{M+1-\mu}\right)\check\psi_{M+1-\mu}
   \quad (\because \check{n}_\mu = \check\psi_\mu^\dagger\check\psi_{M+1-\mu}) \\
&= \check{n}_\mu
   - \left(\check\psi_\mu^\dagger\right)^2\left(\check\psi_{M+1-\mu}\right)^2
   \quad (\because \text{結合法則}) \\
&= \check{n}_\mu - 0\cdot 0
   \quad (\because \text{(1)})
\\
&= \check{n}_\mu
   \quad (\because \text{零元との積と減法})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の number_operator_idempotent の半整数運動量版。009 章では ψ_{-μ} が定義域に入ること（γ_2(θ_{-μ}) ≠ 0）を確かめる必要があったが、anticommutator_of_check_psi が μ, ν ∈ Z 全体について成り立つのでその手当ては要らない。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01（残差 ≤ 1.6e-15）。",
      ],
    },
  },

  {
    id: "evenEigen_003_claim_check_number_operators_commute",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\check{n}_\mu \check{n}_\nu = \check{n}_\nu \check{n}_\mu` },
    labels: ["check_number_operators_commute"],
    statement: [
      paragraph([
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " が ",
        math(String.raw`\mu \neq \nu`),
        " を満たすとき、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \check\psi_\mu^\dagger\,\check{n}_\nu = \check{n}_\nu\,\check\psi_\mu^\dagger,
\qquad \check\psi_{M+1-\mu}\,\check{n}_\nu = \check{n}_\nu\,\check\psi_{M+1-\mu}`),
        ],
        [math(String.raw`\text{(2)}\quad \check{n}_\mu \check{n}_\nu = \check{n}_\nu \check{n}_\mu`)],
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（4 つの反交換関係）。",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        " かつ ",
        math(String.raw`\mu \neq \nu`),
        " である。",
        ref("def_check_index_set"),
        " (2) より ",
        math(String.raw`M+1-\mu, M+1-\nu \in \check{\mathcal{M}}`),
        " なので、",
        ref("anticommutator_of_check_psi"),
        " を ",
        math(String.raw`(\mu,\nu)`),
        "、",
        math(String.raw`(\mu,M+1-\nu)`),
        "、",
        math(String.raw`(\nu,M+1-\mu)`),
        "、",
        math(String.raw`(M+1-\mu,M+1-\nu)`),
        " の 4 通りに適用できる。まず対の条件を見る：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\delta_{M+1-\nu,\,M+1-\mu}
&= \delta_{\mu,\,\nu}
   \quad (\because M+1-\nu = M+1-\mu \iff \mu = \nu) \\
&= 0
   \quad (\because \mu \neq \nu)
\end{aligned}`,
      ),
      paragraph([
        "である。**009 章および以前の版で必要だった合同式の書き換え（",
        math(String.raw`\mu+(1-\nu) \equiv 1 \pmod M \iff \mu-\nu \equiv 0 \pmod M`),
        "）は、添字を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ったことで不要になっている**（",
        ref("def_check_index_set"),
        " (5)）。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
{\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+} &= 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 1 式}), \\
{\left[\check\psi_\mu^\dagger, \check\psi_{M+1-\nu}\right]_+}
  &= \delta_{M+1-\nu,\,M+1-\mu}\,I = 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式と直前の }\delta\text{ の計算}), \\
{\left[\check\psi_{M+1-\mu}, \check\psi_\nu^\dagger\right]_+}
  &= \delta_{M+1-\mu,\,M+1-\nu}\,I = 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式を } (\nu, M+1-\mu) \text{ へ適用し、反交換子の対称性}), \\
{\left[\check\psi_{M+1-\mu}, \check\psi_{M+1-\nu}\right]_+} &= 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 3 式})
\end{aligned}`,
      ),
      paragraph([
        "（第 3 式では ",
        ref("anticommutator_of_check_psi"),
        " の第 2 式を添字 ",
        math(String.raw`(\nu, M+1-\mu)`),
        " に適用し、反交換子が引数の順序に依らないこと ",
        math(String.raw`[X,W]_+ = XW + WX = [W,X]_+`),
        " を使った。）すなわち、",
        math(String.raw`A \in \{\check\psi_\mu^\dagger, \check\psi_{M+1-\mu}\}`),
        " と ",
        math(String.raw`B \in \{\check\psi_\nu^\dagger, \check\psi_{M+1-\nu}\}`),
        " のどの組み合わせでも ",
        math(String.raw`AB = -BA`),
        " が成り立つ。",
      ]),
      paragraph([
        "Step 2（(1) の証明）。",
        math(String.raw`A \in \{\check\psi_\mu^\dagger, \check\psi_{M+1-\mu}\}`),
        " を取ると、数演算子の定義（",
        ref("def_check_number_operator"),
        "）を開き、Step 1 を 2 回使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A\,\check{n}_\nu
&= A\,\check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}
   \quad (\because \text{数演算子の定義}) \\
&= \left(-\check\psi_\nu^\dagger A\right)\check\psi_{M+1-\nu}
   \quad (\because \text{Step 1 の } A\check\psi_\nu^\dagger = -\check\psi_\nu^\dagger A) \\
&= -\check\psi_\nu^\dagger\left(A\,\check\psi_{M+1-\nu}\right)
   \quad (\because \text{結合法則}) \\
&= -\check\psi_\nu^\dagger\left(-\check\psi_{M+1-\nu}A\right)
   \quad (\because \text{Step 1 の } A\check\psi_{M+1-\nu} = -\check\psi_{M+1-\nu}A) \\
&= \check\psi_\nu^\dagger\,\check\psi_{M+1-\nu}\,A
   \quad (\because (-1)^2 = 1) \\
&= \check{n}_\nu\,A
   \quad (\because \text{数演算子の定義})
\end{aligned}`,
      ),
      paragraph([
        "符号は ",
        math(String.raw`(-1)^2 = 1`),
        " となって消える。",
        math(String.raw`A = \check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`A = \check\psi_{M+1-\mu}`),
        " の両方でこれが成り立つ。",
      ]),
      paragraph([
        "Step 3（(2) の証明）。数演算子の定義（",
        ref("def_check_number_operator"),
        "）を開き、(1) を 2 回使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu \check{n}_\nu
&= \left(\check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}\right)\check{n}_\nu
   \quad (\because \text{数演算子の定義}) \\
&= \check\psi_\mu^\dagger\left(\check\psi_{M+1-\mu}\,\check{n}_\nu\right)
   \quad (\because \text{結合法則}) \\
&= \check\psi_\mu^\dagger\left(\check{n}_\nu\,\check\psi_{M+1-\mu}\right)
   \quad (\because \text{(1) を } A = \check\psi_{M+1-\mu} \text{ に適用}) \\
&= \left(\check\psi_\mu^\dagger\,\check{n}_\nu\right)\check\psi_{M+1-\mu}
   \quad (\because \text{結合法則}) \\
&= \left(\check{n}_\nu\,\check\psi_\mu^\dagger\right)\check\psi_{M+1-\mu}
   \quad (\because \text{(1) を } A = \check\psi_\mu^\dagger \text{ に適用}) \\
&= \check{n}_\nu\left(\check\psi_\mu^\dagger\,\check\psi_{M+1-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= \check{n}_\nu \check{n}_\mu
   \quad (\because \text{数演算子の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の number_operators_commute の半整数運動量版。反交換子の対は ν = M+1−μ であり、添字を 𝓜̌ = {1,…,M} に絞ったので、消えることを確かめる δ は δ_{M+1−ν, M+1−μ} = δ_{μ,ν} = 0（μ ≠ ν）だけで済む。合同式の書き換えは要らない（def_check_index_set (5)）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01（M=2,3,4,5、μ ≠ ν の全組、残差 ≤ 1.3e-15）。",
      ],
    },
  },

  {
    id: "evenEigen_004_claim_trace_of_check_number_operator_product",
    kind: "claim",
    origin: { path: SRC, ordinal: 6 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\right) = 2^{M-k}
\quad \left(R_\mu^{(1)} = \check{n}_\mu,\ R_\mu^{(0)} = I - \check{n}_\mu\right)`,
    },
    labels: ["trace_of_check_number_operator_product"],
    statement: [
      paragraph([
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " に対して",
      ]),
      displayMath(
        String.raw`R_\mu^{(1)} := \check{n}_\mu, \qquad R_\mu^{(0)} := I - \check{n}_\mu
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と書く（",
        ref("def_check_number_operator"),
        "）。このとき、",
        math(String.raw`k \in \mathbb{Z}_{\geq 0}`),
        "、相異なる ",
        math(String.raw`\mu_1,\dots,\mu_k \in \check{\mathcal{M}}`),
        "、および ",
        math(String.raw`e_1,\dots,e_k \in \{0,1\}`),
        " について、",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)}R_{\mu_2}^{(e_2)}\cdots R_{\mu_k}^{(e_k)}\right)
= 2^{M-k}`,
      ),
      paragraph([
        "（",
        math(String.raw`k = 0`),
        " のときは空の積を ",
        math(String.raw`I`),
        " と読み、",
        math(String.raw`\mathrm{tr}(I) = 2^M`),
        " である。）とくに ",
        math(String.raw`e_1 = \cdots = e_k = 1`),
        " と取れば ",
        math(String.raw`\mathrm{tr}\!\left(\check{n}_{\mu_1}\cdots\check{n}_{\mu_k}\right) = 2^{M-k}`),
        " であり、",
        math(String.raw`\mathrm{tr}(\check{n}_\mu) = 2^{M-1}`),
        "、",
        math(String.raw`k = M`),
        " のとき ",
        math(String.raw`\mathrm{tr}(\check{n}_1\cdots\check{n}_M) = 1`),
        "。",
      ]),
      paragraph([
        "**因子として ",
        math(String.raw`\check{n}_\mu`),
        " と ",
        math(String.raw`I - \check{n}_\mu`),
        " の混在を許しているのが要点である。** これにより ",
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\mathrm{tr}\!\left(\check{Q}_\epsilon\right) = 1`),
        " が、",
        math(String.raw`\prod_{\mu \notin T}\left(I - \check{n}_\mu\right)`),
        " を部分集合の和へ展開して二項定理で足し上げる、という手順を経ずに直接得られる（",
        math(String.raw`k = M`),
        " の場合）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\check{n}_\mu \in \mathrm{Mat}(2^M,\mathbb{C})`),
        " であり ",
        math(String.raw`I`),
        " は ",
        math(String.raw`2^M`),
        " 次の単位行列なので、",
        ref("trace_basic_properties"),
        " (3) より ",
        math(String.raw`\mathrm{tr}(I) = 2^M`),
        " である（トレースは ",
        ref("def_trace"),
        "）。",
        math(String.raw`k`),
        " に関する帰納法で示す。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`k = 0`),
        "）：",
        math(String.raw`\mathrm{tr}(I) = 2^M = 2^{M-0}`),
        " で成立。",
      ]),
      paragraph([
        "帰納段階：",
        math(String.raw`k \geq 1`),
        " とし、相異なる ",
        math(String.raw`k-1`),
        " 個の添字（と任意の ",
        math(String.raw`e`),
        " の選び方）については主張が成り立つと仮定する。相異なる ",
        math(String.raw`\mu_1,\dots,\mu_k \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`e_1,\dots,e_k \in \{0,1\}`),
        " を取り、",
      ]),
      displayMath(
        String.raw`P := R_{\mu_2}^{(e_2)}R_{\mu_3}^{(e_3)}\cdots R_{\mu_k}^{(e_k)}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\mu_1 \neq \mu_j`),
        "（",
        math(String.raw`j = 2,\dots,k`),
        "）なので ",
        ref("check_number_operators_commute"),
        " (1) より ",
        math(String.raw`\check\psi_{\mu_1}^\dagger`),
        " と ",
        math(String.raw`\check\psi_{M+1-\mu_1}`),
        " はどの ",
        math(String.raw`\check{n}_{\mu_j}`),
        " とも可換であり、",
        math(String.raw`I`),
        " は任意の行列と可換だから（",
        ref("scalar_identity_commutes"),
        "）、",
        math(String.raw`R_{\mu_j}^{(e_j)} \in \left\{\check{n}_{\mu_j},\, I - \check{n}_{\mu_j}\right\}`),
        " とも可換である。したがって積 ",
        math(String.raw`P`),
        " とも可換である。同じく (2) と ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`\check{n}_{\mu_1}`),
        " と ",
        math(String.raw`P`),
        " は可換である。",
      ]),
      paragraph([
        "まず ",
        math(String.raw`2\,\mathrm{tr}\!\left(\check{n}_{\mu_1}P\right) = \mathrm{tr}(P)`),
        " を示す。途中で使う ", ref("check_number_operator_idempotent"),
        " の第 2 式は ", math(String.raw`\check\psi_{M+1-\mu_1}\check\psi_{\mu_1}^{\dagger}=I-\check n_{\mu_1}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{n}_{\mu_1}P\right)
&= \mathrm{tr}\!\left(\check\psi_{\mu_1}^\dagger\,\check\psi_{M+1-\mu_1}\,P\right)
   \quad (\because \text{定義}) \\
&= \mathrm{tr}\!\left(\check\psi_{M+1-\mu_1}\,P\,\check\psi_{\mu_1}^\dagger\right)
   \quad (\because \text{巡回性を } A = \check\psi_{\mu_1}^\dagger,\
       B = \check\psi_{M+1-\mu_1}P \text{ に適用}) \\
&= \mathrm{tr}\!\left(P\,\check\psi_{M+1-\mu_1}\,\check\psi_{\mu_1}^\dagger\right)
   \quad (\because \check\psi_{M+1-\mu_1} \text{ と } P \text{ が可換}) \\
&= \mathrm{tr}\!\left(P\left(I - \check{n}_{\mu_1}\right)\right)
   \quad (\because \text{数演算子の冪等性の証明の第 2 式}) \\
&= \mathrm{tr}(P) - \mathrm{tr}\!\left(P\,\check{n}_{\mu_1}\right)
   \quad (\because \text{トレースの線型性}) \\
&= \mathrm{tr}(P) - \mathrm{tr}\!\left(\check{n}_{\mu_1}P\right)
   \quad (\because \check{n}_{\mu_1} \text{ と } P \text{ が可換})
\end{aligned}`,
      ),
      paragraph([
        "直前の鎖を移項し、2 で割ると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2\,\mathrm{tr}\!\left(\check n_{\mu_1}P\right)
&=\mathrm{tr}(P)
   \quad (\because \mathbb C\text{ の四則}) \\
\mathrm{tr}\!\left(\check n_{\mu_1}P\right)
&=\frac12\,\mathrm{tr}(P)
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "となる。これから ",
        math(String.raw`e_1`),
        " が ",
        math(String.raw`1`),
        " でも ",
        math(String.raw`0`),
        " でも同じ値になる：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(1)}P\right)
&= \mathrm{tr}\!\left(\check{n}_{\mu_1}P\right)
   \quad (\because R_{\mu_1}^{(1)}=\check n_{\mu_1}) \\
&= \tfrac12\,\mathrm{tr}(P)
   \quad (\because \text{直前の鎖}), \\
\mathrm{tr}\!\left(R_{\mu_1}^{(0)}P\right)
&= \mathrm{tr}\!\left(\left(I - \check{n}_{\mu_1}\right)P\right)
   \quad (\because R_{\mu_1}^{(0)}=I-\check n_{\mu_1}) \\
&= \mathrm{tr}(P) - \mathrm{tr}\!\left(\check{n}_{\mu_1}P\right)
   \quad (\because \text{分配則とトレースの線型性}) \\
&= \mathrm{tr}(P) - \tfrac12\,\mathrm{tr}(P)
   \quad (\because \text{直前の鎖}) \\
&= \tfrac12\,\mathrm{tr}(P)
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "（第 2 式で ",
        math(String.raw`(I - \check{n}_{\mu_1})P = P - \check{n}_{\mu_1}P`),
        " は分配法則である。）帰納法の仮定から ",
        math(String.raw`\mathrm{tr}(P) = 2^{M-(k-1)}`),
        " なので、いずれの場合も",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\right)
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前の二場合}) \\
&= \frac{1}{2}\cdot 2^{M-k+1}
   \quad (\because \text{帰納法の仮定}) \\
&= 2^{M-k}
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "（",
        ref("check_number_operators_commute"),
        " (2) と ",
        ref("scalar_identity_commutes"),
        " より ",
        math(String.raw`R_\mu^{(e)}`),
        " たちは互いに可換で積の順序に依らないので、どの因子を ",
        math(String.raw`\mu_1`),
        " の位置に置いてもよく、一般の相異なる添字列についても同じ結論を得る。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の trace_of_number_operator_product の半整数運動量版。添字集合が I ではなく {1,…,M} 全部になるので、k は M まで走れて tr(ň_1⋯ň_M) = 2^0 = 1 になる（009 章では臨界点で |I| = M−1 までしか走れなかった）。",
        "009 章と違い、因子として ň_μ と I − ň_μ の混在を許す形で述べてある。どちらの因子でも tr(R_μ P) = tr(P)/2 が成り立つので帰納法は 1 段で済み、check_joint_eigenspace_decomposition の tr(Q̌_ε) = 1 を、∏(I − ň) の部分集合展開と二項定理を経ずに k = M の場合として直接得られる（docs/tasks/2026-07_lean-ch009-013/004_ch017_冗長な手順と暗黙の前提.md の指摘 1 に対応。Lean 側の Ising2D.Abstract.two_pow_smul_tau_projOn が同じ構造である）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01（ň のみの積について {1,…,M} の全部分集合、残差 ≤ 7.1e-15）。因子が混在する場合は check_02 の tr(Q̌_ε) = 1（k = M、残差 ≤ 1.1e-15）が該当する。",
      ],
    },
  },

  {
    id: "evenEigen_005_claim_check_joint_eigenspace_decomposition",
    kind: "claim",
    origin: { path: SRC, ordinal: 7 },
    title: { text: "数演算子の同時固有空間分解（各空間は 1 次元）" },
    labels: ["check_joint_eigenspace_decomposition"],
    statement: [
      paragraph([
        math(String.raw`\epsilon = (\epsilon_\mu)_{\mu=1}^{M} \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check{Q}_\epsilon := \prod_{\mu=1}^{M}
\Bigl(\epsilon_\mu\,\check{n}_\mu + (1-\epsilon_\mu)\left(I - \check{n}_\mu\right)\Bigr)
\ \in\ \mathrm{Mat}(2^M,\mathbb{C})`,
      ),
      paragraph([
        "と定める（因子は ",
        ref("check_number_operators_commute"),
        " により互いに可換なので、積の順序は問わない）。このとき、",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \check{Q}_\epsilon \check{Q}_{\epsilon'} = 0
\quad (\epsilon \neq \epsilon'), \qquad \check{Q}_\epsilon^2 = \check{Q}_\epsilon`),
        ],
        [
          math(String.raw`\text{(2)}\quad \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}}
\check{Q}_\epsilon = I`),
        ],
        [
          math(String.raw`\text{(3)}\quad \check{n}_\nu \check{Q}_\epsilon
= \check{Q}_\epsilon \check{n}_\nu
= \epsilon_\nu \check{Q}_\epsilon \quad (\nu \in \check{\mathcal{M}})`),
        ],
        [
          math(String.raw`\text{(4)}\quad \mathrm{tr}\!\left(\check{Q}_\epsilon\right) = 1,
\qquad \dim_{\mathbb{C}} \mathrm{im}\,\check{Q}_\epsilon = 1`),
        ],
        [
          math(String.raw`\text{(5)}\quad \mathbb{C}^{2^M}
= \bigoplus_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{im}\,\check{Q}_\epsilon`),
        ],
      ]),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " は ",
        math(String.raw`2^M`),
        " 個の ",
        math(String.raw`1`),
        " 次元部分空間の直和に分解される。",
        "009 章の ",
        ref("joint_eigenspace_decomposition"),
        " (4) の次元 ",
        math(String.raw`2^{M-m}`),
        " は臨界点で ",
        math(String.raw`2`),
        " になりえたが、半整数運動量では ",
        math(String.raw`m = M`),
        " なので**常に ",
        math(String.raw`1`),
        " 次元**である（",
        ref("def_check_number_operator"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "以下、",
        ref("trace_of_check_number_operator_product"),
        " と同じ記号を使う：",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " と ",
        math(String.raw`e \in \{0,1\}`),
        " に対して ",
        math(String.raw`R_\mu^{(1)} := \check{n}_\mu`),
        "、",
        math(String.raw`R_\mu^{(0)} := I - \check{n}_\mu`),
        "。",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M} R_\mu^{(\epsilon_\mu)}`),
        " である。",
      ]),
      paragraph([
        "Step 0（1 つの添字についての関係）。",
        ref("check_number_operator_idempotent"),
        " (3) の ",
        math(String.raw`\check{n}_\mu^2 = \check{n}_\mu`),
        " と、単位行列が任意の行列と可換であること（",
        ref("scalar_identity_commutes"),
        "）を使う。まず 2 つの冪等性：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(1)}
&= \check{n}_\mu\check{n}_\mu
   \quad (\because R_\mu^{(1)} \text{ の定義（冒頭）}) \\
&= \check{n}_\mu
   \quad (\because \text{数演算子の冪等性 (3)}) \\
&= R_\mu^{(1)}
   \quad (\because R_\mu^{(1)} \text{ の定義（冒頭）})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(0)}
&= \left(I-\check{n}_\mu\right)\left(I-\check{n}_\mu\right)
   \quad (\because R_\mu^{(0)} \text{ の定義（冒頭）}) \\
&= I - \check{n}_\mu - \check{n}_\mu + \check{n}_\mu\check{n}_\mu
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= I - \check{n}_\mu - \check{n}_\mu + \check{n}_\mu
   \quad (\because \text{数演算子の冪等性 (3)}) \\
&= I - \check{n}_\mu
   \quad (\because \text{行列の加法（同じ項の消去）}) \\
&= R_\mu^{(0)}
   \quad (\because R_\mu^{(0)} \text{ の定義（冒頭）})
\end{aligned}`,
      ),
      paragraph(["次に異なる上付き添字の積が両順序とも零であること："]),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)}R_\mu^{(0)}
&= \check{n}_\mu\left(I - \check{n}_\mu\right)
   \quad (\because R_\mu^{(1)}, R_\mu^{(0)} \text{ の定義（冒頭）}) \\
&= \check{n}_\mu - \check{n}_\mu\check{n}_\mu
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= \check{n}_\mu - \check{n}_\mu
   \quad (\because \text{数演算子の冪等性 (3)}) \\
&= 0
   \quad (\because \text{行列の加法逆元})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(0)}R_\mu^{(1)}
&= \left(I - \check{n}_\mu\right)\check{n}_\mu
   \quad (\because R_\mu^{(0)}, R_\mu^{(1)} \text{ の定義（冒頭）}) \\
&= \check{n}_\mu - \check{n}_\mu\check{n}_\mu
   \quad (\because \text{分配法則と、単位行列との積}) \\
&= \check{n}_\mu - \check{n}_\mu
   \quad (\because \text{数演算子の冪等性 (3)}) \\
&= 0
   \quad (\because \text{行列の加法逆元})
\end{aligned}`,
      ),
      paragraph(["最後に和が単位行列であること："]),
      displayMath(
        String.raw`\begin{aligned}
R_\mu^{(1)} + R_\mu^{(0)}
&= \check{n}_\mu + \left(I - \check{n}_\mu\right)
   \quad (\because R_\mu^{(1)}, R_\mu^{(0)} \text{ の定義（冒頭）}) \\
&= I
   \quad (\because \text{行列の加法（加法逆元と単位元）})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        math(String.raw`\mu \neq \nu`),
        " のとき ",
        ref("check_number_operators_commute"),
        " (2) より ",
        math(String.raw`\check{n}_\mu \check{n}_\nu = \check{n}_\nu \check{n}_\mu`),
        " であり、",
        math(String.raw`I`),
        " は任意の行列と可換だから（",
        ref("scalar_identity_commutes"),
        "）、",
        math(String.raw`R_\mu^{(e)}`),
        " と ",
        math(String.raw`R_\nu^{(e')}`),
        " も可換である。",
      ]),
      paragraph([
        "Step 1（(1) の証明）。",
        math(String.raw`\epsilon \neq \epsilon'`),
        " なら、ある ",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " で ",
        math(String.raw`\epsilon_\nu \neq \epsilon'_\nu`),
        "。因子はすべて可換なので、",
        math(String.raw`\check{Q}_\epsilon \check{Q}_{\epsilon'}`),
        " の中で添字 ",
        math(String.raw`\nu`),
        " の 2 因子を隣接させられて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon \check{Q}_{\epsilon'}
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)
  R_\nu^{(\epsilon_\nu)}R_\nu^{(\epsilon'_\nu)}
  \quad (\because \text{因子の可換性により添字 }\nu\text{ の二因子を末尾へ寄せる}) \\
&= \left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon'_\mu)}\right)\cdot 0
  \quad (\because \epsilon_\nu\neq\epsilon'_\nu\text{ と Step 0 の異なる上付き添字の積}) \\
&= 0
  \quad (\because \text{零行列は行列積の零元})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon = \epsilon'`),
        " のときは各因子が Step 0 より冪等なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon^2
&=\left(\prod_{\mu=1}^{M}R_\mu^{(\epsilon_\mu)}\right)
  \left(\prod_{\mu=1}^{M}R_\mu^{(\epsilon_\mu)}\right)
  \quad (\because \check{Q}_\epsilon\text{ の定義}) \\
&=\prod_{\mu=1}^{M}\left(R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon_\mu)}\right)
  \quad (\because \text{異なる添字の因子の可換性}) \\
&=\prod_{\mu=1}^{M}R_\mu^{(\epsilon_\mu)}
  \quad (\because \text{Step 0 の二つの冪等性を各因子へ同時に適用}) \\
&=\check{Q}_\epsilon
  \quad (\because \check{Q}_\epsilon\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "Step 2（(2) の証明）。主張の左辺から始める：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \check{Q}_\epsilon
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \prod_{\mu=1}^{M} R_\mu^{(\epsilon_\mu)}
   \quad (\because \check{Q}_\epsilon \text{ の定義（冒頭）}) \\
&= \prod_{\mu=1}^{M}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)
   \quad (\because \text{可換な有限個の因子の積の分配法則による展開}) \\
&= \prod_{\mu=1}^{M} I
   \quad (\because \text{Step 0 の和が単位行列であることを各因子へ同時に適用}) \\
&= I
   \quad (\because \text{単位行列の有限積は単位行列})
\end{aligned}`,
      ),
      paragraph([
        "（展開して現れる項は、各 ",
        math(String.raw`\mu`),
        " について ",
        math(String.raw`R_\mu^{(1)}`),
        " と ",
        math(String.raw`R_\mu^{(0)}`),
        " のどちらを選ぶかの全ての選び方に 1 対 1 に対応し、その選び方の全体が ",
        math(String.raw`\{0,1\}^{\check{\mathcal{M}}}`),
        "（要素数 ",
        math(String.raw`2^M`),
        "）である。）",
      ]),
      paragraph([
        "Step 3（(3) の証明）。",
        math(String.raw`\nu \in \check{\mathcal{M}}`),
        " を固定する。因子はすべて可換なので、主張の左辺は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\nu \check{Q}_\epsilon
&=\check{n}_\nu\prod_{\mu=1}^{M}R_\mu^{(\epsilon_\mu)}
  \quad (\because \check{Q}_\epsilon\text{ の定義}) \\
&=\left(\prod_{\mu \neq \nu} R_\mu^{(\epsilon_\mu)}\right)
  \check{n}_\nu R_\nu^{(\epsilon_\nu)}
  \quad (\because \text{異なる添字の因子の可換性})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon_\nu = 1`),
        " の場合は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\nu R_\nu^{(1)}
&=\check{n}_\nu\check{n}_\nu
  \quad (\because R_\nu^{(1)}\text{ の定義（冒頭）}) \\
&=\check{n}_\nu
  \quad (\because \text{数演算子の冪等性 (3)}) \\
&=R_\nu^{(1)}
  \quad (\because R_\nu^{(1)}\text{ の定義（冒頭）}) \\
&=\epsilon_\nu R_\nu^{(\epsilon_\nu)}
  \quad (\because \epsilon_\nu=1\text{ と単位元の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`\epsilon_\nu = 0`),
        " の場合は",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\nu R_\nu^{(0)}
&=\check{n}_\nu\left(I-\check{n}_\nu\right)
  \quad (\because R_\nu^{(0)}\text{ の定義（冒頭）}) \\
&=\check{n}_\nu-\check{n}_\nu\check{n}_\nu
  \quad (\because \text{分配法則と、単位行列との積}) \\
&=\check{n}_\nu-\check{n}_\nu
  \quad (\because \text{数演算子の冪等性 (3)}) \\
&=0
  \quad (\because \text{行列の加法逆元}) \\
&=\epsilon_\nu R_\nu^{(\epsilon_\nu)}
  \quad (\because \epsilon_\nu=0\text{ と零元の積})
\end{aligned}`,
      ),
      paragraph(["したがって、どちらの場合も"]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\nu\check{Q}_\epsilon
&=\left(\prod_{\mu\ne\nu}R_\mu^{(\epsilon_\mu)}\right)
  \epsilon_\nu R_\nu^{(\epsilon_\nu)}
  \quad (\because \text{直前の二つの場合}) \\
&=\epsilon_\nu\check{Q}_\epsilon
  \quad (\because \check{Q}_\epsilon\text{ の定義とスカラーの分配})
\end{aligned}`,
      ),
      paragraph([
        "**左右どちらから掛けても同じである。** 実際 ",
        math(String.raw`\check{n}_\nu`),
        " は ",
        math(String.raw`\check{Q}_\epsilon`),
        " のどの因子 ",
        math(String.raw`R_\mu^{(\epsilon_\mu)}`),
        " とも可換である（",
        math(String.raw`\mu \neq \nu`),
        " なら Step 0 の可換性、",
        math(String.raw`\mu = \nu`),
        " なら ",
        math(String.raw`\check{n}_\nu`),
        " と ",
        math(String.raw`\check{n}_\nu`),
        " または ",
        math(String.raw`I - \check{n}_\nu`),
        " の可換性で、後者は ",
        ref("scalar_identity_commutes"),
        " による）から、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon\check{n}_\nu
&=\check{n}_\nu\check{Q}_\epsilon
  \quad (\because \check{n}_\nu\text{ と }\check{Q}_\epsilon\text{ の全因子の可換性}) \\
&=\epsilon_\nu\check{Q}_\epsilon
  \quad (\because \text{直前の結果})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（(4) の証明）。",
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M} R_\mu^{(\epsilon_\mu)}`),
        " は、相異なる ",
        math(String.raw`M`),
        " 個の添字 ",
        math(String.raw`1,\dots,M \in \check{\mathcal{M}}`),
        " についての ",
        math(String.raw`R_\mu^{(e)}`),
        " の積そのものなので、",
        ref("trace_of_check_number_operator_product"),
        " を ",
        math(String.raw`k = M`),
        "、",
        math(String.raw`(\mu_1,\dots,\mu_M) = (1,\dots,M)`),
        "、",
        math(String.raw`(e_1,\dots,e_M) = (\epsilon_1,\dots,\epsilon_M)`),
        " として適用でき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{Q}_\epsilon\right)
&= 2^{M-M}
  \quad (\because \text{数演算子の積のトレース（上の適用）}) \\
&= 2^{0}
  \quad (\because M-M=0) \\
&= 1
  \quad (\because \text{冪の零乗})
\end{aligned}`,
      ),
      paragraph([
        "を得る（",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M\}`),
        " の元をすべて使い切っているので指数が ",
        math(String.raw`0`),
        " になる。ここが 009 章と分かれる点である）。",
      ]),
      paragraph([
        math(String.raw`\check{Q}_\epsilon`),
        " は Step 1 より冪等なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\dim_{\mathbb{C}}\mathrm{im}\,\check{Q}_\epsilon
&= \mathrm{tr}\!\left(\check{Q}_\epsilon\right)
  \quad (\because \text{冪等行列のトレースは像の次元。}\check{Q}_\epsilon\text{ は Step 1 より冪等}) \\
&= 1
  \quad (\because \text{上で計算した } \mathrm{tr}(\check{Q}_\epsilon))
\end{aligned}`,
      ),
      paragraph([
        ref("trace_of_idempotent"),
        " を引いた。009 章の同じ計算が ",
        math(String.raw`2^{M-m}`),
        " を与えるところで、",
        math(String.raw`m = M`),
        " により ",
        math(String.raw`2^{M-M} = 1`),
        " になっている。",
      ]),
      paragraph([
        "Step 5（(5) の証明）。(2) より任意の ",
        math(String.raw`x \in \mathbb{C}^{2^M}`),
        " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
x
&= Ix
  \quad (\because \text{単位行列の作用}) \\
&= \left(\sum_\epsilon \check{Q}_\epsilon\right)x
  \quad (\because \text{Step 2 の射影子の和}) \\
&= \sum_\epsilon \check{Q}_\epsilon x
  \quad (\because \text{行列の作用の分配法則})
\end{aligned}`,
      ),
      paragraph([
        "である。各項 ", math(String.raw`\check{Q}_\epsilon x`), " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " に属するから和は全体を張る。直和であることを見るために ",
        math(String.raw`\sum_\epsilon y_\epsilon = 0`),
        "（",
        math(String.raw`y_\epsilon \in \mathrm{im}\,\check{Q}_\epsilon`),
        "）とする。任意の ", math(String.raw`\epsilon'`), " を固定する。Step 1 より、",
        math(String.raw`\epsilon\ne\epsilon'`), " なら ",
        math(String.raw`\check{Q}_{\epsilon'}y_\epsilon=0`),
        " であり、", math(String.raw`y_{\epsilon'}\in\mathrm{im}\,\check{Q}_{\epsilon'}`),
        " と冪等性から ",
        math(String.raw`\check{Q}_{\epsilon'}y_{\epsilon'}=y_{\epsilon'}`), " である。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
y_{\epsilon'}
&= \sum_\epsilon \check{Q}_{\epsilon'}y_\epsilon
  \quad (\because \text{Step 1 の直交性と冪等性}) \\
&= \check{Q}_{\epsilon'}\left(\sum_\epsilon y_\epsilon\right)
  \quad (\because \text{行列の作用の分配法則}) \\
&= \check{Q}_{\epsilon'}0
  \quad (\because \sum_\epsilon y_\epsilon=0) \\
&= 0
  \quad (\because \text{零ベクトルへの行列の作用})
\end{aligned}`,
      ),
      paragraph([
        "が各 ",
        math(String.raw`\epsilon'`),
        " について成り立ち、直和である。",
      ]),
      paragraph([
        "（次元の整合：",
        math(String.raw`\left|\{0,1\}^{\check{\mathcal{M}}}\right| = 2^M`),
        " 個の空間がそれぞれ ",
        math(String.raw`1`),
        " 次元で、合計 ",
        math(String.raw`2^M`),
        " となり ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の次元に一致する。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の joint_eigenspace_decomposition の半整数運動量版。段階構造は同じで、添字集合 I が {1,…,M} に、m が M に、tr(Q_ε) = 2^{M−m} が 1 に置き換わる。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_02（M=2,3,4,5 の {0,1}^M を全列挙。tr(Q̌_ε) = 1 の残差 ≤ 1.1e-15、rank Q̌_ε = 1 を特異値で判定して違反 0 件）。",
      ],
    },
  },

  {
    id: "evenEigen_006_claim_eigenvalues_of_check_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 8 },
    title: { tex: String.raw`\check{V}' \text{ の固有値}` },
    labels: ["eigenvalues_of_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check{g}(\epsilon) := \sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right) \in \mathbb{R}`,
      ),
      paragraph(["とおく（", ref("def_gamma_theta_tilde_mu"), "）。このとき"]),
      displayMath(
        String.raw`\check{V}'\,\check{Q}_\epsilon = \check{Q}_\epsilon\,\check{V}'
= e^{\check{g}(\epsilon)}\,\check{Q}_\epsilon`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " の各元は ",
        math(String.raw`\check{V}'`),
        " の固有値 ",
        math(String.raw`e^{\check{g}(\epsilon)}`),
        " の固有ベクトルであり、",
        ref("check_joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`\check{V}'`),
        " は対角化可能で、その固有値は重複度を込めて",
      ]),
      displayMath(
        String.raw`\left\{\,e^{\check{g}(\epsilon)} \ \middle|\
\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\,\right\}
\qquad (\text{各 } \epsilon \text{ が重複度 } 1 \text{ を与え、総個数 } 2^M)`,
      ),
      paragraph([
        "で尽くされる。とくに ",
        math(String.raw`\check{V}'`),
        " の固有値はすべて正の実数である。",
      ]),
      paragraph([
        "**「固有値がすべて相異なる」ことは主張しない。** ",
        ref("periodicity_of_check_fermi"),
        " (3) より ",
        math(String.raw`\gamma(\tilde\theta_{M+1-\mu}) = \gamma(\tilde\theta_\mu)`),
        " なので、",
        math(String.raw`\epsilon`),
        " の成分を ",
        math(String.raw`\mu \leftrightarrow M+1-\mu`),
        " で入れ替えても ",
        math(String.raw`\check{g}(\epsilon)`),
        " は変わらない。したがって相異なる ",
        math(String.raw`\epsilon`),
        " が同じ固有値を与えることは実際に起こる。",
        "**単純性を主張するのは最大固有値だけである**（",
        ref("max_eigenvalue_of_V_plus_simple"),
        "）。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（",
        math(String.raw`\check{X}\check{Q}_\epsilon = \check{g}(\epsilon)\check{Q}_\epsilon`),
        "）。",
        ref("def_check_number_operator"),
        " (2) の ",
        math(String.raw`\check{X} = \sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)
\left(\check{n}_\mu - \tfrac12 I\right)`),
        " に ",
        ref("check_joint_eigenspace_decomposition"),
        " (3) を代入して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\check{Q}_\epsilon
&= \sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
   \left(\check{n}_\mu\check{Q}_\epsilon - \tfrac12 \check{Q}_\epsilon\right)
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
   \left(\epsilon_\mu\check{Q}_\epsilon - \tfrac12 \check{Q}_\epsilon\right)
   \quad (\because \text{同時固有空間分解 (3)}) \\
&= \left(\sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
   \left(\epsilon_\mu - \tfrac12\right)\right)\check{Q}_\epsilon
   \quad (\because \text{有限和のくくり出し}) \\
&= \check{g}(\epsilon)\,\check{Q}_\epsilon
   \quad (\because \check{g} \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "同じ計算を ",
        ref("check_joint_eigenspace_decomposition"),
        " (3) の右から掛ける形 ",
        math(String.raw`\check{Q}_\epsilon\check{n}_\mu = \epsilon_\mu\check{Q}_\epsilon`),
        " に対して行えば ",
        math(String.raw`\check{Q}_\epsilon\check{X} = \check{g}(\epsilon)\check{Q}_\epsilon`),
        " も得られる。とくに ",
        math(String.raw`\check{X}\check{Q}_\epsilon = \check{Q}_\epsilon\check{X}`),
        "（両者が同じ ",
        math(String.raw`\check{g}(\epsilon)\check{Q}_\epsilon`),
        " に等しい）である。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`\check{X}^k\check{Q}_\epsilon = \check{g}(\epsilon)^k\check{Q}_\epsilon`),
        "）。",
        math(String.raw`k`),
        " に関する帰納法。",
        math(String.raw`k = 0`),
        " は自明。",
        math(String.raw`\check{X}^k\check{Q}_\epsilon = \check{g}(\epsilon)^k\check{Q}_\epsilon`),
        " を仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}^{k+1}\check{Q}_\epsilon
&= \check{X}\left(\check{X}^k\check{Q}_\epsilon\right)
   \quad (\because \text{行列の冪の定義と積の結合法則}) \\
&= \check{X}\left(\check{g}(\epsilon)^k\check{Q}_\epsilon\right)
   \quad (\because \text{帰納法の仮定}) \\
&= \check{g}(\epsilon)^k\left(\check{X}\check{Q}_\epsilon\right)
   \quad (\because \text{スカラー倍と行列の積の交換}) \\
&= \check{g}(\epsilon)^k\left(\check{g}(\epsilon)\,\check{Q}_\epsilon\right)
   \quad (\because \text{Step 1}) \\
&= \check{g}(\epsilon)^{k+1}\check{Q}_\epsilon
   \quad (\because \text{スカラー倍の結合法則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（指数関数へ）。",
        ref("def_exp"),
        " より ",
        math(String.raw`\check{V}' = \exp(\check{X}) = \sum_{k=0}^{\infty}\frac{1}{k!}\check{X}^k`),
        " であり、この級数は ",
        ref("exp_converges"),
        " により ",
        ref("def_matrix_norm"),
        " のノルムについて収束する。部分和を ",
        math(String.raw`E_K := \sum_{k=0}^{K}\frac{1}{k!}\check{X}^k`),
        " と書くと、Step 2 と有限和の線型性から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_K \check{Q}_\epsilon
&= \left(\sum_{k=0}^{K}\frac{1}{k!}\check{X}^k\right)\check{Q}_\epsilon
   \quad (\because E_K \text{ の定義}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\left(\check{X}^k\check{Q}_\epsilon\right)
   \quad (\because \text{有限和と行列積の分配法則}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\left(\check{g}(\epsilon)^k\check{Q}_\epsilon\right)
   \quad (\because \text{Step 2}) \\
&= \left(\sum_{k=0}^{K}\frac{\check{g}(\epsilon)^k}{k!}\right)\check{Q}_\epsilon
   \quad (\because \text{有限和からの共通因子のくくり出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K \to \infty`),
        " の極限を取る。行列積の連続性（",
        ref("matrix_multiplication_continuity"),
        "）と実指数級数の収束（",
        ref("real_exp_series_converges"),
        "）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}'\,\check{Q}_\epsilon
&= \left(\lim_{K\to\infty} E_K\right)\check{Q}_\epsilon
   \quad (\because \check{V}' = \exp(\check{X}) \text{ は部分和 } E_K \text{ の極限。上の級数表示}) \\
&= \lim_{K\to\infty}\left(E_K\,\check{Q}_\epsilon\right)
   \quad (\because \text{行列積の連続性}) \\
&= \lim_{K\to\infty}\left(\left(\sum_{k=0}^{K}\frac{\check{g}(\epsilon)^k}{k!}\right)
   \check{Q}_\epsilon\right)
   \quad (\because \text{上の部分和の鎖}) \\
&= e^{\check{g}(\epsilon)}\,\check{Q}_\epsilon
   \quad (\because \text{実指数級数の収束と極限の一意性})
\end{aligned}`,
      ),
      paragraph([
        "Step 3'（右から掛ける形）。Step 1 の ",
        math(String.raw`\check{Q}_\epsilon\check{X} = \check{g}(\epsilon)\check{Q}_\epsilon`),
        " から、", math(String.raw`k`), " に関する帰納法を行う。",
        math(String.raw`k=0`), " は単位行列の右単位元により成り立つ。",
        math(String.raw`\check{Q}_\epsilon\check{X}^k=\check{g}(\epsilon)^k\check{Q}_\epsilon`),
        " を仮定すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon\check{X}^{k+1}
&= \left(\check{Q}_\epsilon\check{X}^k\right)\check{X}
   \quad (\because \text{行列の冪の定義と積の結合法則}) \\
&= \left(\check{g}(\epsilon)^k\check{Q}_\epsilon\right)\check{X}
   \quad (\because \text{帰納法の仮定}) \\
&= \check{g}(\epsilon)^k\left(\check{Q}_\epsilon\check{X}\right)
   \quad (\because \text{スカラー倍と行列の積の交換}) \\
&= \check{g}(\epsilon)^k\left(\check{g}(\epsilon)\check{Q}_\epsilon\right)
   \quad (\because \text{Step 1 の右から掛ける形}) \\
&= \check{g}(\epsilon)^{k+1}\check{Q}_\epsilon
   \quad (\because \text{スカラー倍の結合法則})
\end{aligned}`,
      ),
      paragraph([
        "したがって全ての ", math(String.raw`k\in\mathbb N`), " でこの等式が成り立つ。",
        "Step 3 と同じ部分和 ", math(String.raw`E_K`), " について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon E_K
&= \check{Q}_\epsilon\left(\sum_{k=0}^{K}\frac{1}{k!}\check{X}^k\right)
   \quad (\because E_K \text{ の定義}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\left(\check{Q}_\epsilon\check{X}^k\right)
   \quad (\because \text{有限和と行列積の分配法則}) \\
&= \sum_{k=0}^{K}\frac{1}{k!}\left(\check{g}(\epsilon)^k\check{Q}_\epsilon\right)
   \quad (\because \text{上の帰納法}) \\
&= \left(\sum_{k=0}^{K}\frac{\check{g}(\epsilon)^k}{k!}\right)\check{Q}_\epsilon
   \quad (\because \text{有限和からの共通因子のくくり出し})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K\to\infty`), " の極限を取る。行列積の連続性（",
        ref("matrix_multiplication_continuity"), "）と実指数級数の収束（",
        ref("real_exp_series_converges"), "）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon\check{V}'
&= \check{Q}_\epsilon\left(\lim_{K\to\infty}E_K\right)
   \quad (\because \check{V}'=\exp(\check{X}) \text{ は部分和 }E_K\text{ の極限。Step 3 の級数表示}) \\
&= \lim_{K\to\infty}\left(\check{Q}_\epsilon E_K\right)
   \quad (\because \text{行列積の連続性}) \\
&= \lim_{K\to\infty}\left(\left(\sum_{k=0}^{K}\frac{\check{g}(\epsilon)^k}{k!}\right)\check{Q}_\epsilon\right)
   \quad (\because \text{上の部分和の鎖}) \\
&= e^{\check{g}(\epsilon)}\check{Q}_\epsilon
   \quad (\because \text{実指数級数の収束と極限の一意性}) \\
&= \check{V}'\check{Q}_\epsilon
   \quad (\because \text{Step 3})
\end{aligned}`,
      ),
      paragraph([
        "を得る。**この左からの形（",
        math(String.raw`\check{Q}_\epsilon`),
        " を固有方程式の両辺に左から掛ける使い方）が ",
        ref("max_eigenvalue_of_V_plus_simple"),
        " (3) で必要になる。**",
      ]),
      paragraph([
        "Step 4（固有値の言い換え）。",
        math(String.raw`y \in \mathrm{im}\,\check{Q}_\epsilon`),
        " なら ",
        math(String.raw`y = \check{Q}_\epsilon x`),
        " と書けて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Q}_\epsilon y
&= \check{Q}_\epsilon\left(\check{Q}_\epsilon x\right)
   \quad (\because y = \check{Q}_\epsilon x \text{ と書いた}) \\
&= \check{Q}_\epsilon^2 x
   \quad (\because \text{行列積の結合法則}) \\
&= \check{Q}_\epsilon x
   \quad (\because \text{check\_joint\_eigenspace\_decomposition (1) の冪等性}) \\
&= y
   \quad (\because y = \check{Q}_\epsilon x \text{ と書いた})
\end{aligned}`,
      ),
      paragraph([
        "である（冪等性は ",
        ref("check_joint_eigenspace_decomposition"),
        " (1)）。だから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{V}' y
&= \check{V}'\left(\check{Q}_\epsilon y\right)
   \quad (\because \text{上の等式 }\check{Q}_\epsilon y = y) \\
&= e^{\check{g}(\epsilon)}\check{Q}_\epsilon y
   \quad (\because \text{Step 3}) \\
&= e^{\check{g}(\epsilon)} y
   \quad (\because \text{上の等式 }\check{Q}_\epsilon y = y)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " たちの直和だから、各 ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " の基底（1 次元なので 1 本）を合わせると ",
        math(String.raw`\check{V}'`),
        " の固有ベクトルからなる ",
        math(String.raw`\mathbb{C}^{2^M}`),
        " の基底が得られる。したがって ",
        math(String.raw`\check{V}'`),
        " は対角化可能で、固有値は ",
        math(String.raw`e^{\check{g}(\epsilon)}`),
        " が各 ",
        math(String.raw`\epsilon`),
        " について 1 つずつ現れるもので尽くされる（総個数 ",
        math(String.raw`2^M`),
        "）。",
      ]),
      paragraph([
        math(String.raw`\check{g}(\epsilon) \in \mathbb{R}`),
        "（",
        ref("def_gamma_theta_tilde_mu"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{>0}`),
        "）なので ",
        math(String.raw`e^{\check{g}(\epsilon)} > 0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の eigenvalues_of_Vprime の半整数運動量版。重複度 2^{M-m} が m = M により 1 になる。",
        "V̌' Q̌_ε = Q̌_ε V̌' = e^{ǧ(ε)} Q̌_ε の「左から掛ける形」（Step 3'）を明示してある。max_eigenvalue_of_V_plus_simple (3) がこの形を使うため（Lean 側は Ising2D.CheckFermiSetup.Qproj_mul_Vprime / Ising2D.Qproj_mul_VPlus）。根拠は X̌ と Q̌_ε の可換性で、これは check_joint_eigenspace_decomposition (3) の両側版から従う。",
        "「固有値がすべて相異なるわけではない」ことは一次情報で確認した（sagemath/check/050_claim_even_sector_eigenvalues/check_03。M=2..5・6 組の (K1,K2) で、相異なる ε が同じ固有値を与える隣接ペアが 144 件現れる）。本文でも相異なるとは主張していない。",
        "数値検証: 同 check_03（X̌Q̌_ε = ǧ(ε)Q̌_ε、V̌'Q̌_ε = e^{ǧ(ε)}Q̌_ε、Sage の固有値集合との一致。残差 ≤ 8.0e-12）。",
      ],
    },
  },

  {
    id: "evenEigen_007_claim_trace_of_check_Vprime",
    kind: "claim",
    origin: { path: SRC, ordinal: 9 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(\check{V}'\right)
= \mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right) > 0`,
    },
    labels: ["trace_of_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`\check{V}'`),
        " は可逆で ",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        " であり（",
        ref("def_check_Vprime"),
        " (2)）、",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\check{V}'\right)
= \mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right)
= \prod_{\mu=1}^{M} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
\ \in\ \mathbb{R}_{>0}`,
      ),
      paragraph([
        "が成り立つ。009 章の ",
        ref("trace_of_Vprime"),
        " にあった前因子 ",
        math(String.raw`2^{M-m}`),
        " は ",
        math(String.raw`m = M`),
        " なので ",
        math(String.raw`1`),
        " であり、ここには現れない。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（トレースの計算）。",
        ref("check_joint_eigenspace_decomposition"),
        " (2)(4) と ",
        ref("eigenvalues_of_check_Vprime"),
        "、および ",
        ref("trace_basic_properties"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{V}'\right)
&= \mathrm{tr}\!\left(\check{V}'\sum_{\epsilon}\check{Q}_\epsilon\right)
   \quad (\because \textstyle\sum_\epsilon \check{Q}_\epsilon = I) \\
&= \sum_{\epsilon} \mathrm{tr}\!\left(\check{V}'\check{Q}_\epsilon\right)
   \quad (\because \text{トレースの線型性}) \\
&= \sum_{\epsilon} e^{\check{g}(\epsilon)}\,\mathrm{tr}\!\left(\check{Q}_\epsilon\right)
   \quad (\because \check{V}'\check{Q}_\epsilon = e^{\check{g}(\epsilon)}\check{Q}_\epsilon) \\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} e^{\check{g}(\epsilon)}
   \quad (\because \mathrm{tr}(\check{Q}_\epsilon) = 1)
\end{aligned}`,
      ),
      paragraph([
        "Step 2（積への分解）。",
        math(String.raw`\check{g}(\epsilon) = \sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac12\right)`),
        " なので、実数の指数法則より",
      ]),
      displayMath(
        String.raw`e^{\check{g}(\epsilon)} = \prod_{\mu=1}^{M}
\exp\!\left(\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)\right)
\quad (\because \text{theorem\_exp\_product}\ (n=1))`,
      ),
      paragraph([
        math(String.raw`\epsilon`),
        " は各成分を独立に ",
        math(String.raw`0`),
        " か ",
        math(String.raw`1`),
        " から選ぶので、有限個の因子の積の展開（Step 1 の ",
        math(String.raw`\sum_\epsilon`),
        " と同じ 1 対 1 対応）により",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} e^{\check{g}(\epsilon)}
&= \prod_{\mu=1}^{M}
   \left(\exp\!\left(-\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)\right)
   \quad (\because \text{直前の積表示と、有限個の因子の積の展開}) \\
&= \prod_{\mu=1}^{M} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad \left(\because \cosh x = \frac{e^x + e^{-x}}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`\left(\check{V}'\right)^{-1}`),
        " についても同じ値）。",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        " であり、",
        math(String.raw`-\check{X} = \sum_{\mu=1}^{M}\left(-\gamma(\tilde\theta_\mu)\right)
\left(\check{n}_\mu - \tfrac12 I\right)`),
        " だから、Step 1〜2 をそのまま ",
        math(String.raw`\gamma(\tilde\theta_\mu) \to -\gamma(\tilde\theta_\mu)`),
        " として適用でき（",
        ref("eigenvalues_of_check_Vprime"),
        " の Step 1〜4 も符号を替えるだけで通る）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right)
&= \prod_{\mu=1}^{M} 2\cosh\!\left(\frac{-\gamma(\tilde\theta_\mu)}{2}\right)
   \quad (\because \text{Step 1--2 を }\gamma(\tilde\theta_\mu)\mapsto-\gamma(\tilde\theta_\mu)\text{ として適用}) \\
&= \prod_{\mu=1}^{M} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad (\because \cosh\text{ は偶関数}) \\
&= \mathrm{tr}\!\left(\check{V}'\right)
   \quad (\because \text{Step 1--2 の }\check{V}'\text{ のトレース表示})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（正値性）。",
        ref("def_gamma_theta_tilde_mu"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{>0}`),
        " であり、",
        ref("cosh_sinh_basic_properties"),
        " より各 ", math(String.raw`\mu`), " について次の鎖を得る。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
&\ge 2
   \quad (\because \cosh x\ge1) \\
&>0
   \quad (\because 2>0)
\end{aligned}`,
      ),
      paragraph(["したがって正数の有限積と Step 1--2 のトレース表示により"]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{V}'\right)
&=\prod_{\mu=1}^{M}2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad (\because \text{Step 1--2}) \\
&>0
   \quad (\because \text{正数の有限積は正})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の trace_of_Vprime の半整数運動量版。可逆性は def_check_Vprime (2) で既に示してあるので、009 章の Step 1（可逆性）は繰り返さない。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_04（tr(V̌') = Π 2cosh(γ/2) の相対差 ≤ 3.8e-15、tr((V̌')^{-1}) = tr(V̌') の相対差 ≤ 2.5e-15）。",
      ],
    },
  },

  {
    id: "evenEigen_008_claim_V_plus_is_positive_definite",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: {
      tex: String.raw`V^{(+)} \text{ は正定値、とくに } \mathrm{tr}\!\left(V^{(+)}\right) > 0`,
    },
    labels: ["V_plus_is_positive_definite"],
    statement: [
      paragraph([
        ref("iH_is_real_symmetric"),
        " の ",
        math(String.raw`S_1^{(\pm)} := iK_1H_1^{(\pm)}`),
        "、",
        math(String.raw`S_2 := iK_2^*H_2`),
        " について、**上の符号を取ったもの ",
        math(String.raw`S_1^{(+)}`),
        " を使う**。",
        ref("def_V_plus_and_T_V_plus"),
        " の ",
        math(String.raw`V^{(+)} = \left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}`),
        " は",
      ]),
      displayMath(
        String.raw`V^{(+)} = (2s_2)^{M/2}\,
\exp\!\left(\tfrac12 S_1^{(+)}\right)\exp\!\left(S_2\right)
\exp\!\left(\tfrac12 S_1^{(+)}\right)`,
      ),
      paragraph([
        "と書ける（",
        math(String.raw`s_2 = \sinh 2K_2`),
        " は ",
        ref("def_transfer_matrix_symbols"),
        "）。このとき ",
        math(String.raw`V^{(+)}`),
        " は可逆で正定値（",
        ref("def_hermitian_positive_definite"),
        " の意味）であり、",
      ]),
      displayMath(
        String.raw`\left(V^{(+)}\right)^{-1} = (2s_2)^{-M/2}\,
\exp\!\left(-\tfrac12 S_1^{(+)}\right)\exp\!\left(-S_2\right)
\exp\!\left(-\tfrac12 S_1^{(+)}\right)`,
      ),
      paragraph([math(String.raw`\left(V^{(+)}\right)^{-1}`), " も正定値である。とくに"]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(V^{(+)}\right) \in \mathbb{R}_{>0},
\qquad
\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right) \in \mathbb{R}_{>0}`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（表示）。二つの因子を順に書き直す（",
        ref("def_V_plus_and_T_V_plus"),
        "、",
        ref("def_transfer_matrix_symbols"),
        "、",
        ref("iH_is_real_symmetric"),
        "）。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left(V_1^{(+)}\right)^{1/2}
&= \exp\!\left(\tfrac{i}{2}K_1H_1^{(+)}\right)
   \quad (\because \left(V_1^{(+)}\right)^{1/2} \text{ の定義}) \\
&= \exp\!\left(\tfrac12 S_1^{(+)}\right)
   \quad (\because S_1^{(+)} = iK_1H_1^{(+)})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
V_2
&= (2s_2)^{M/2}\exp\!\left(iK_2^*H_2\right)
   \quad (\because V_2 \text{ の表示}) \\
&= (2s_2)^{M/2}\exp(S_2)
   \quad (\because S_2 = iK_2^*H_2)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(2s_2)^{M/2}`),
        " はスカラーなので ",
        ref("scalar_identity_commutes"),
        " により前へ出せて statement の表示を得る。",
      ]),
      paragraph([
        "Step 2（各因子の性質）。",
        ref("iH_is_real_symmetric"),
        " は ",
        math(String.raw`S_1^{(\pm)}`),
        " を**複号のいずれについても**実対称としているので、",
        math(String.raw`S_1^{(+)}`),
        " も実対称、したがって ",
        ref("def_hermitian_positive_definite"),
        " の最後の注意よりエルミートである。",
        math(String.raw`\tfrac12 S_1^{(+)}`),
        " と ",
        math(String.raw`S_2`),
        " もエルミート（実係数倍）であり、",
        ref("exp_hermitian_is_positive_definite"),
        " (1) より",
      ]),
      list([
        [
          math(String.raw`B := \exp\!\left(\tfrac12 S_1^{(+)}\right)`),
          " はエルミートかつ正定値、とくに可逆",
        ],
        [math(String.raw`A := \exp(S_2)`), " は正定値"],
      ]),
      paragraph([
        "Step 3（正定値性）。",
        math(String.raw`B`),
        " がエルミートなので ",
        math(String.raw`B^* = B`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp\!\left(\tfrac12 S_1^{(+)}\right)\exp(S_2)\exp\!\left(\tfrac12 S_1^{(+)}\right)
&= BAB
   \quad (\because B,\ A \text{ の定義（Step 2）}) \\
&= B^*AB
   \quad (\because B^* = B)
\end{aligned}`,
      ),
      paragraph([
        ref("exp_hermitian_is_positive_definite"),
        " (2) より ",
        math(String.raw`B^*AB`),
        " は正定値。",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`),
        " であり、同 (3) より ",
        math(String.raw`V^{(+)} = (2s_2)^{M/2}B^*AB`),
        " も正定値である。",
      ]),
      paragraph([
        "Step 4（可逆性と ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        "）。",
        ref("theorem_exp_product"),
        " と ",
        ref("theorem_exp_zero"),
        " より ",
        math(String.raw`\exp\!\left(\pm\tfrac12 S_1^{(+)}\right)`),
        " どうし、",
        math(String.raw`\exp(\pm S_2)`),
        " どうしは互いに逆行列である。よって statement の ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " の式の右辺と ",
        math(String.raw`V^{(+)}`),
        " の積は内側から順に打ち消し合って ",
        math(String.raw`I`),
        " になる（スカラー ",
        math(String.raw`(2s_2)^{\pm M/2}`),
        " も打ち消し合う）。",
        math(String.raw`-\tfrac12 S_1^{(+)}`),
        " と ",
        math(String.raw`-S_2`),
        " もエルミートなので、Step 2〜3 をそのまま適用して ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " も正定値である。",
      ]),
      paragraph([
        "Step 5（トレース）。",
        ref("exp_hermitian_is_positive_definite"),
        " (4) より ",
        math(String.raw`\mathrm{tr}\!\left(V^{(+)}\right) > 0`),
        "、",
        math(String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right) > 0`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の V_is_positive_definite の (+) セクター版。009 章の主張は V_eq_Vprime の V（why_008_applies_only_to_minus_sector で確定したとおり実質 (−) 専用）に結びついているので、V^{(+)} について改めて述べた。証明で使う iH_is_real_symmetric と exp_hermitian_is_positive_definite はどちらも複号によらない形で述べられているので、内容は 009 章の Step 1〜5 と同一である。(V^{(+)})^{-1} の正定値性についても同一である: 009 章の V_is_positive_definite は statement で「V は可逆で正定値、V^{-1} も正定値である」と述べ、その Step 4 で −(1/2)S_1^{(±)} と −S_2 のエルミート性から Step 2〜3 を再適用して示している（本章の Step 4 と同じ手順）。ただし Lean 側には 009 章の V^{-1}（Ising2D.VmatInv）に対応する正定値性の定理が無く、章 017 で新たに Ising2D.VPlusInv_posDef として証明した。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_05（S_1^{(+)}, S_2 の実対称性の残差 0.0、V^{(+)} のエルミート性の残差 ≤ 2.0e-12、固有値の全体最小 3.2e-4 > 0、M=2,3,4,5・6 組の (K_1,K_2)）。",
      ],
    },
  },

  {
    id: "evenEigen_009_claim_constant_c_value_even_sector",
    kind: "claim",
    origin: { path: SRC, ordinal: 11 },
    title: { tex: String.raw`c = (2\sinh 2K_2)^{M/2}` },
    labels: ["constant_c_value_even_sector"],
    statement: [
      paragraph([
        ref("V_plus_eq_c_check_Vprime"),
        " の定数 ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M/2} = (2s_2)^{M/2} \in \mathbb{R}_{>0}`,
      ),
      paragraph(["である。すなわち"]),
      displayMath(String.raw`V^{(+)} = (2\sinh 2K_2)^{M/2}\,\check{V}'`),
    ],
    proof: [
      paragraph([
        "以下 ",
        math(String.raw`S_1 := S_1^{(+)} = iK_1H_1^{(+)}`),
        "、",
        math(String.raw`S_2 = iK_2^*H_2`),
        "（",
        ref("iH_is_real_symmetric"),
        "）、",
        math(String.raw`\tau := \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)`),
        " と書く。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`\mathrm{tr}\!\left(V^{(+)}\right)`),
        " と ",
        math(String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)`),
        " を ",
        math(String.raw`\tau`),
        " で表す）。",
        ref("V_plus_is_positive_definite"),
        " の表示と ",
        ref("trace_basic_properties"),
        " (1)(2) より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(V^{(+)}\right)
&= (2s_2)^{M/2}\,\mathrm{tr}\!\left(
   \exp\!\left(\tfrac12 S_1\right)\exp(S_2)\exp\!\left(\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{M/2}\,\mathrm{tr}\!\left(
   \exp\!\left(\tfrac12 S_1\right)\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\right)
   \quad \left(\because \text{巡回性を } A = \exp\!\left(\tfrac12 S_1\right)\exp(S_2),\
   B = \exp\!\left(\tfrac12 S_1\right) \text{ に適用}\right) \\
&= (2s_2)^{M/2}\,\mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad \left(\because \text{可換なので } \exp\!\left(\tfrac12 S_1\right)^2 = \exp(S_1)\right) \\
&= (2s_2)^{M/2}\,\tau
   \quad (\because \tau := \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right))
\end{aligned}`,
      ),
      paragraph([
        "同じ計算を ",
        ref("V_plus_is_positive_definite"),
        " の ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " の表示に適用して",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)
= (2s_2)^{-M/2}\,\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right) = \tau`),
        "）。",
        ref("sign_flip_conjugation"),
        " の ",
        math(String.raw`U`),
        " は**複号同順に** ",
        math(String.raw`US_1^{(\pm)}U^{-1} = -S_1^{(\pm)}`),
        "、",
        math(String.raw`US_2U^{-1} = -S_2`),
        " を与えるので、上の符号を取って ",
        math(String.raw`US_1U^{-1} = -S_1`),
        " が使える。共役は行列の積とスカラー倍を保ち、有限部分和の極限とも交換する（",
        math(String.raw`\left\|UXU^{-1} - UWU^{-1}\right\|
= \left\|U(X-W)U^{-1}\right\| \leq \|U\|\,\|U^{-1}\|\,\|X-W\|`),
        "：",
        ref("matrix_norm_submultiplicativity"),
        "）から、",
        math(String.raw`US^kU^{-1} = \left(USU^{-1}\right)^k`),
        " と ",
        ref("def_exp"),
        " より",
      ]),
      displayMath(
        String.raw`U\exp(S)U^{-1} = \exp\!\left(USU^{-1}\right)
\qquad \left(S \in \mathrm{Mat}(2^M,\mathbb{C})\right)`,
      ),
      paragraph([
        "これを ",
        math(String.raw`S = S_1, S_2`),
        " に適用し、",
        ref("trace_basic_properties"),
        " (4) を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tau
&= \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right) \\
&= \mathrm{tr}\!\left(U\exp(S_1)\exp(S_2)U^{-1}\right)
   \quad (\because \text{トレースは共役で不変}) \\
&= \mathrm{tr}\!\left(\left(U\exp(S_1)U^{-1}\right)
   \left(U\exp(S_2)U^{-1}\right)\right)
   \quad (\because U^{-1}U = I) \\
&= \mathrm{tr}\!\left(\exp\!\left(US_1U^{-1}\right)\exp\!\left(US_2U^{-1}\right)\right) \\
&= \mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)
   \quad (\because \text{符号反転共役})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`c^2`),
        " の決定）。",
        ref("V_plus_eq_c_check_Vprime"),
        " の ",
        math(String.raw`V^{(+)} = c\check{V}'`),
        " から ",
        math(String.raw`\left(V^{(+)}\right)^{-1} = c^{-1}\left(\check{V}'\right)^{-1}`),
        " であり、",
        ref("trace_basic_properties"),
        " (1) より",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(V^{(+)}\right) = c\,\mathrm{tr}\!\left(\check{V}'\right),
\qquad
\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)
= c^{-1}\,\mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right)`,
      ),
      paragraph([
        ref("trace_of_check_Vprime"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(\check{V}'\right)
= \mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right) > 0`),
        " なので、これらは ",
        math(String.raw`0`),
        " でなく、辺々割ることができて",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\mathrm{tr}\!\left(V^{(+)}\right)}
{\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)}
&= \frac{c\,\mathrm{tr}\!\left(\check{V}'\right)}
{c^{-1}\,\mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right)}
   \quad (\because \text{Step 3 の二つのトレース表示}) \\
&= c^2\,\frac{\mathrm{tr}\!\left(\check{V}'\right)}
{\mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right)}
   \quad (\because \mathbb{C}\text{ の四則}) \\
&= c^2
   \quad \left(\because
   \mathrm{tr}\!\left(\check{V}'\right)
   = \mathrm{tr}\!\left(\left(\check{V}'\right)^{-1}\right) > 0\right)
\end{aligned}`,
      ),
      paragraph([
        "一方 Step 1・Step 2 より（",
        ref("V_plus_is_positive_definite"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(V^{(+)}\right) > 0`),
        " なので ",
        math(String.raw`\tau = (2s_2)^{-M/2}\mathrm{tr}\!\left(V^{(+)}\right) \neq 0`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\mathrm{tr}\!\left(V^{(+)}\right)}
{\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)}
&= \frac{(2s_2)^{M/2}\,\tau}{(2s_2)^{-M/2}\,\tau}
   \quad (\because \text{Step 1・Step 2}) \\
&= (2s_2)^M
   \quad (\because \tau\neq0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph(["よって ", math(String.raw`c^2 = (2s_2)^{M}`), "。"]),
      paragraph([
        "Step 4（符号の確定）。Step 3 の第 1 式より ",
        math(String.raw`c = \mathrm{tr}\!\left(V^{(+)}\right)/\mathrm{tr}\!\left(\check{V}'\right)`),
        " であり、",
        ref("V_plus_is_positive_definite"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(V^{(+)}\right) \in \mathbb{R}_{>0}`),
        "、",
        ref("trace_of_check_Vprime"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(\check{V}'\right) \in \mathbb{R}_{>0}`),
        " なので ",
        math(String.raw`c \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      paragraph([
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        " より ",
        math(String.raw`s_2 = \sinh 2K_2 > 0`),
        " なので ",
        math(String.raw`(2s_2)^{M/2} \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c^2 &= (2s_2)^M
   \quad (\because \text{Step 3}) \\
&= \left((2s_2)^{M/2}\right)^2
   \quad (\because \text{正の実数の冪の指数法則 } \left(a^{M/2}\right)^2 = a^M)
\end{aligned}`,
      ),
      paragraph(["と合わせると"]),
      displayMath(
        String.raw`\left(c - (2s_2)^{M/2}\right)\left(c + (2s_2)^{M/2}\right) = 0`,
      ),
      paragraph([
        math(String.raw`c > 0`),
        " かつ ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " より第 2 因子は正で ",
        math(String.raw`0`),
        " でない。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから第 1 因子が ",
        math(String.raw`0`),
        " であり、",
        math(String.raw`c = (2s_2)^{M/2}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の constant_c_value の (+) セクター版。行列式は使わず、tr(V)/tr(V^{-1}) = c^2 と符号反転共役 U、および正定値性からの符号確定という同じ筋で通る。009 章の証明は S_1^{(-)} で書かれているが、iH_is_real_symmetric と sign_flip_conjugation はどちらも S_1^{(±)} について複号同順で述べられているので、上の符号を取るだけで (+) 側に使える。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_05（U S_1^{(+)} U^{-1} = −S_1^{(+)} の残差 0.0、tr(exp(−S_1)exp(−S_2)) = τ の相対差 ≤ 6.1e-16、tr(V^{(+)})/tr((V^{(+)})^{-1}) = (2s_2)^M の相対差 ≤ 6.6e-16、c = (2 sinh 2K_2)^{M/2} の相対差 ≤ 4.3e-15）。",
      ],
    },
  },

  {
    id: "evenEigen_010_theorem_eigenvalues_of_V_plus",
    kind: "theorem",
    origin: { path: SRC, ordinal: 12 },
    title: { tex: String.raw`V^{(+)} \text{ の固有値}` },
    labels: ["eigenvalues_of_V_plus"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check\Lambda_\epsilon := (2\sinh 2K_2)^{M/2}
\exp\!\left(\sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right)\right) \in \mathbb{R}_{>0}`,
      ),
      paragraph(["とおく。このとき"]),
      list([
        [
          math(String.raw`\text{(1)}\quad V^{(+)}\check{Q}_\epsilon
= \check{Q}_\epsilon V^{(+)}
= \check\Lambda_\epsilon \check{Q}_\epsilon`),
          "（左右どちらから掛けても同じ）。とくに ",
          math(String.raw`V^{(+)}`),
          " は対角化可能で、その固有値は重複度を込めて ",
          math(String.raw`\left\{\check\Lambda_\epsilon\right\}_{\epsilon}`),
          "（各 ",
          math(String.raw`\epsilon`),
          " が 1 つずつ、総個数 ",
          math(String.raw`2^M`),
          "）で尽くされる。",
        ],
        [
          math(String.raw`\text{(2)}`),
          " 固有値はすべて正の実数であり、最大のものは全ての ",
          math(String.raw`\epsilon_\mu = 1`),
          " を取ったとき、最小のものは全ての ",
          math(String.raw`\epsilon_\mu = 0`),
          " を取ったときである：",
        ],
      ]),
      displayMath(
        String.raw`\check\Lambda_{\max} = (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)\right),
\qquad
\check\Lambda_{\min} = (2\sinh 2K_2)^{M/2}
\exp\!\left(-\frac{1}{2}\sum_{\mu=1}^{M} \gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "（したがって ",
        math(String.raw`\check\Lambda_{\max}\check\Lambda_{\min} = (2\sinh 2K_2)^{M} = c^2`),
        "。）",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("constant_c_value_even_sector"),
        " より ",
        math(String.raw`V^{(+)} = (2s_2)^{M/2}\check{V}'`),
        " であり、",
        ref("eigenvalues_of_check_Vprime"),
        " より ",
        math(String.raw`\check{V}'\check{Q}_\epsilon = e^{\check{g}(\epsilon)}\check{Q}_\epsilon`),
        " だから",
      ]),
      displayMath(
        String.raw`V^{(+)}\check{Q}_\epsilon = (2s_2)^{M/2}\check{V}'\check{Q}_\epsilon
= (2s_2)^{M/2}e^{\check{g}(\epsilon)}\check{Q}_\epsilon
= \check\Lambda_\epsilon\check{Q}_\epsilon`,
      ),
      paragraph([
        "同じ式変形を ",
        ref("eigenvalues_of_check_Vprime"),
        " の Step 3' の ",
        math(String.raw`\check{Q}_\epsilon\check{V}' = e^{\check{g}(\epsilon)}\check{Q}_\epsilon`),
        " に対して行い（スカラー ",
        math(String.raw`(2s_2)^{M/2}`),
        " は ",
        ref("scalar_identity_commutes"),
        " により左右どちらへも出せる）、",
        math(String.raw`\check{Q}_\epsilon V^{(+)} = \check\Lambda_\epsilon\check{Q}_\epsilon`),
        " も得る。",
      ]),
      paragraph([
        "対角化可能性・重複度・総個数は ",
        ref("eigenvalues_of_check_Vprime"),
        " の Step 4 と同じ議論（",
        ref("check_joint_eigenspace_decomposition"),
        " (5) による直和分解）で得られる。スカラー倍は固有ベクトルを変えない。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " と ",
        math(String.raw`e^{\check{g}(\epsilon)} > 0`),
        " より ",
        math(String.raw`\check\Lambda_\epsilon > 0`),
        "。",
      ]),
      paragraph([
        "大小の比較。",
        math(String.raw`\check\Lambda_\epsilon = (2s_2)^{M/2}e^{\check{g}(\epsilon)}`),
        " で ",
        math(String.raw`(2s_2)^{M/2}`),
        " は ",
        math(String.raw`\epsilon`),
        " に依らない正の定数、",
        math(String.raw`t \mapsto e^t`),
        " は実数上の狭義単調増加関数なので、",
        math(String.raw`\check\Lambda_\epsilon`),
        " の大小は ",
        math(String.raw`\check{g}(\epsilon)
= \sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)`),
        " の大小と一致する。",
        ref("def_gamma_theta_tilde_mu"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " なので、各項 ",
        math(String.raw`\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)`),
        " は ",
        math(String.raw`\epsilon_\mu = 1`),
        " のとき ",
        math(String.raw`+\tfrac12\gamma(\tilde\theta_\mu)`),
        "、",
        math(String.raw`\epsilon_\mu = 0`),
        " のとき ",
        math(String.raw`-\tfrac12\gamma(\tilde\theta_\mu)`),
        " であり、前者が後者より**狭義に**大きい。各項は独立に選べるので、和が最大になるのは全ての ",
        math(String.raw`\epsilon_\mu = 1`),
        "、最小になるのは全ての ",
        math(String.raw`\epsilon_\mu = 0`),
        " のときである。それぞれ",
      ]),
      displayMath(
        String.raw`\check{g}(1,\dots,1) = \frac{1}{2}\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu),
\qquad
\check{g}(0,\dots,0) = -\frac{1}{2}\sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)`,
      ),
      paragraph([
        "を代入して statement の ",
        math(String.raw`\check\Lambda_{\max}, \check\Lambda_{\min}`),
        " を得る。積は指数部分が打ち消し合って ",
        math(String.raw`\check\Lambda_{\max}\check\Lambda_{\min} = (2s_2)^{M}`),
        " であり、",
        ref("constant_c_value_even_sector"),
        " より これは ",
        math(String.raw`c^2`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の eigenvalues_of_V の (+) セクター版。重複度が 2^{M-m} から 1 に、和の範囲が I から {1,…,M} に変わる。γ(θ~_μ) > 0 が狭義なので、大小比較も狭義になる（009 章では ≥ しか言えなかった）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_06（M=2,3,4,5・6 組の (K_1,K_2) で、V^{(+)} の 2^M 個の固有値全体が {Λ̌_ε} と相対誤差 9.0e-12 以下で一致。V^{(+)} は行列指数関数から直接構成しており、証明の経路とは独立）。",
      ],
    },
  },

  {
    id: "evenEigen_011_theorem_max_eigenvalue_of_V_plus_simple",
    kind: "theorem",
    origin: { path: SRC, ordinal: 13 },
    title: {
      tex: String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_M \text{ であり単純固有値}`,
    },
    labels: ["max_eigenvalue_of_V_plus_simple"],
    statement: [
      paragraph([
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\Lambda^{(\delta)}_M`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \check\Lambda_{\max} = \Lambda^{(1/2)}_M`),
          "。すなわち ",
          math(String.raw`V^{(+)}`),
          " の最大固有値は ",
          math(String.raw`\delta = \tfrac12`),
          "（半整数運動量）に対応する。",
        ],
        [
          math(String.raw`\text{(2)}\quad \epsilon \neq (1,\dots,1)
\ \Longrightarrow\ \check\Lambda_\epsilon < \check\Lambda_{\max}`),
          "（狭義の不等号）。",
        ],
        [
          math(String.raw`\text{(3)}`),
          " したがって ",
          math(String.raw`\check\Lambda_{\max}`),
          " は ",
          math(String.raw`V^{(+)}`),
          " の**単純固有値**である：",
          math(String.raw`\left\{x \in \mathbb{C}^{2^M} \mid V^{(+)}x
= \check\Lambda_{\max}x\right\}
= \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
          " であり、この空間の次元は ",
          math(String.raw`1`),
          " である。",
        ],
      ]),
      paragraph([
        "009 章の ",
        ref("eigenvalues_of_V"),
        " の ",
        math(String.raw`\Lambda_{\max}`),
        " は ",
        math(String.raw`\delta = 0`),
        "（整数運動量）に対応するもので、そちらでは臨界点で ",
        math(String.raw`\gamma(\theta_M) = 0`),
        " となりうるため単純性は言えない。半整数運動量では ",
        ref("def_gamma_theta_tilde_mu"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " が**すべての ",
        math(String.raw`\mu`),
        "、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点を含む）で**成り立つので、単純性が従う。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("onsager_free_energy_expression"),
        " の ",
        math(String.raw`\delta = \tfrac12`),
        " の場合の定義は",
      ]),
      displayMath(
        String.raw`\Theta_M^{(1/2)} = \left\{\left.\frac{2\pi\left(\mu-\frac12\right)}{M}
\ \right|\ \mu = 1,\dots,M\right\},
\qquad
\Lambda^{(1/2)}_M = (2\sinh 2K_2)^{M/2}
\exp\!\left(\frac{1}{2}\sum_{\theta \in \Theta_M^{(1/2)}}\gamma(\theta)\right)`,
      ),
      paragraph([
        "である。",
        ref("def_half_integer_modes"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\frac12\right)}{M}`),
        " より ",
        math(String.raw`\Theta_M^{(1/2)} = \left\{\tilde\theta_\mu \mid \mu = 1,\dots,M\right\}`),
        " である。",
      ]),
      paragraph([
        "この ",
        math(String.raw`M`),
        " 個の値は互いに相異なる。実際 ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`\mu \neq \nu`),
        " なら ",
        math(String.raw`\tilde\theta_\mu - \tilde\theta_\nu = \dfrac{2\pi(\mu-\nu)}{M}`),
        " で ",
        math(String.raw`1 \leq |\mu-\nu| \leq M-1`),
        " だから ",
        math(String.raw`0 < \left|\tilde\theta_\mu - \tilde\theta_\nu\right| < 2\pi`),
        " であり、とくに ",
        math(String.raw`\tilde\theta_\mu \neq \tilde\theta_\nu`),
        "。よって集合 ",
        math(String.raw`\Theta_M^{(1/2)}`),
        " はちょうど ",
        math(String.raw`M`),
        " 個の元をもち、",
      ]),
      displayMath(
        String.raw`\sum_{\theta \in \Theta_M^{(1/2)}}\gamma(\theta)
= \sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)`,
      ),
      paragraph([
        "である。ここで左辺の ",
        math(String.raw`\gamma`),
        " は ",
        ref("gamma1_lower_bound_all_theta"),
        " の ",
        math(String.raw`\gamma(\theta) = \mathrm{arccosh}\left(\gamma_1(\theta)\right)`),
        "（",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        "）であり、右辺の ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は ",
        ref("def_gamma_theta_tilde_mu"),
        " の ",
        math(String.raw`\mathrm{arccosh}\left(\gamma_1(\tilde\theta_\mu)\right)`),
        " である。",
        ref("def_gamma1_gamma2_of_theta"),
        " の ",
        math(String.raw`\gamma_1`),
        " は ",
        ref("gamma1_lower_bound_all_theta"),
        " のものと同じ式なので、",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " において両者は同じ実数である。したがって ",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_{\max}`),
        " の表式と比べて ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_M`),
        "。",
      ]),
      paragraph([
        "(2) ",
        math(String.raw`\epsilon \neq (1,\dots,1)`),
        " とすると、ある ",
        math(String.raw`\mu_0 \in \check{\mathcal{M}}`),
        " で ",
        math(String.raw`\epsilon_{\mu_0} = 0`),
        " である。",
        ref("eigenvalues_of_check_Vprime"),
        " の ",
        math(String.raw`\check{g}`),
        " について",
      ]),
      displayMath(
        String.raw`\check{g}(1,\dots,1) - \check{g}(\epsilon)
= \sum_{\mu=1}^{M}\gamma(\tilde\theta_\mu)
\Bigl(1 - \epsilon_\mu\Bigr)
\ \geq\ \gamma(\tilde\theta_{\mu_0})\left(1 - 0\right)
= \gamma(\tilde\theta_{\mu_0}) > 0`,
      ),
      paragraph([
        "である（各項は ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " と ",
        math(String.raw`1 - \epsilon_\mu \in \{0,1\}`),
        " より ",
        math(String.raw`\geq 0`),
        " なので、",
        math(String.raw`\mu = \mu_0`),
        " の項だけを残す不等式が成り立つ。最後の狭義の不等号は ",
        ref("def_gamma_theta_tilde_mu"),
        "）。よって ",
        math(String.raw`\check{g}(\epsilon) < \check{g}(1,\dots,1)`),
        " であり、",
        math(String.raw`t \mapsto e^t`),
        " が狭義単調増加で ",
        math(String.raw`(2s_2)^{M/2} > 0`),
        " だから",
      ]),
      displayMath(
        String.raw`\check\Lambda_\epsilon = (2s_2)^{M/2}e^{\check{g}(\epsilon)}
< (2s_2)^{M/2}e^{\check{g}(1,\dots,1)} = \check\Lambda_{\max}`,
      ),
      paragraph([
        "（",
        math(String.raw`\check\Lambda_{\max} = \check\Lambda_{(1,\dots,1)}`),
        " は ",
        ref("eigenvalues_of_V_plus"),
        " (2)。）",
      ]),
      paragraph([
        "(3) ",
        math(String.raw`x \in \mathbb{C}^{2^M}`),
        " が ",
        math(String.raw`V^{(+)}x = \check\Lambda_{\max}x`),
        " を満たすとする。",
        math(String.raw`\epsilon' \in \{0,1\}^{\check{\mathcal{M}}}`),
        " を任意に取り、この固有方程式の両辺に**左から ",
        math(String.raw`\check{Q}_{\epsilon'}`),
        " を掛ける**。",
        ref("eigenvalues_of_V_plus"),
        " (1) の左から掛ける形 ",
        math(String.raw`\check{Q}_{\epsilon'}V^{(+)} = \check\Lambda_{\epsilon'}\check{Q}_{\epsilon'}`),
        " を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\Lambda_{\epsilon'}\left(\check{Q}_{\epsilon'}x\right)
&= \left(\check{Q}_{\epsilon'}V^{(+)}\right)x
   \quad (\because \text{eigenvalues\_of\_V\_plus (1)}) \\
&= \check{Q}_{\epsilon'}\left(V^{(+)}x\right)
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\Lambda_{\max}\left(\check{Q}_{\epsilon'}x\right)
   \quad (\because V^{(+)}x = \check\Lambda_{\max}x)
\end{aligned}`,
      ),
      paragraph([
        "すなわち ",
        math(String.raw`\left(\check\Lambda_{\epsilon'} - \check\Lambda_{\max}\right)
\check{Q}_{\epsilon'}x = 0`),
        "。(2) より ",
        math(String.raw`\epsilon' \neq (1,\dots,1)`),
        " のとき ",
        math(String.raw`\check\Lambda_{\epsilon'} - \check\Lambda_{\max} \neq 0`),
        " であり、これは ",
        math(String.raw`0`),
        " でない複素数なので割ることができて ",
        math(String.raw`\check{Q}_{\epsilon'}x = 0`),
        "。したがって ",
        ref("check_joint_eigenspace_decomposition"),
        " (2) の ",
        math(String.raw`x = \sum_\epsilon \check{Q}_\epsilon x`),
        " において ",
        math(String.raw`\epsilon \neq (1,\dots,1)`),
        " の項がすべて消え、",
      ]),
      displayMath(
        String.raw`x = \sum_{\epsilon}\check{Q}_\epsilon x
= \check{Q}_{(1,\dots,1)}x \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`,
      ),
      paragraph([
        "逆に ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " の各元が固有値 ",
        math(String.raw`\check\Lambda_{\max}`),
        " の固有ベクトルであることは ",
        ref("eigenvalues_of_V_plus"),
        " (1) と ",
        ref("eigenvalues_of_check_Vprime"),
        " の Step 4 と同じ計算で従う。よって固有空間は ",
        math(String.raw`\mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " に一致し、",
        ref("check_joint_eigenspace_decomposition"),
        " (4) よりその次元は ",
        math(String.raw`1`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "この主張が docs/tasks/free-energy-roadmap/task-dependency-graph.md の章 C′ の出口である。Λ̌_max = Λ^{(1/2)}_M により remark_remaining_input_even_sector の「残っている入力」が埋まり、sector_decomposition_of_rayleigh_sup の c_+(M) を Λ^{(1/2)}_M と結びつける準備が整う（その接続そのものは次の作業）。",
        "単純性は「最大固有値だけ」の性質である。固有値全体が相異なるわけではない（eigenvalues_of_check_Vprime の statement 末尾）。",
        "(3) の証明は固有方程式の両辺に左から Q̌_{ε'} を掛けるだけで済み、check_joint_eigenspace_decomposition (5) の直和性は使わない（以前は使っていた。docs/tasks/2026-07_lean-ch009-013/004_ch017_冗長な手順と暗黙の前提.md の指摘 2・2' に対応。Lean 側は Ising2D.Abstract.eq_proj_of_eigen）。使うのは (2) の Σ_ε Q̌_ε = I と eigenvalues_of_V_plus (1) の左から掛ける形、および dim = 1 のための (4) だけである。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_06（Λ̌_max = Λ^{(1/2)}_M の相対差 0.0、γ(θ~_μ) の全体最小 5.4e-1 > 0、最大固有値と 2 番目の固有値の相対差の最小 4.17e-1。対照として整数運動量の Λ^{(0)}_M とは一致しない）。",
      ],
    },
  },
]);
