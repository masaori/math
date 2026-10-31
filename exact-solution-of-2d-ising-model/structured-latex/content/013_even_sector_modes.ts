import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

const SRC = "structured-latex/content/013_even_sector_modes.ts";

export default defineBlocks([
  {
    id: "heading_even_sector_modes",
    kind: "heading",
    level: 2,
    origin: { path: SRC, ordinal: 1 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ による } Z_j, Y_j \text{ の離散 Fourier 変換}` },
    labels: [],
  },








  {
    id: "evensector_003_definition_half_integer_modes",
    kind: "claim",
    origin: { path: SRC, ordinal: 5 },
    title: { tex: String.raw`\tilde\theta_\mu \text{ の共役添字恒等式 } \tilde\theta_{1-\mu} = -\tilde\theta_\mu` },
    labels: ["def_half_integer_modes"],
    statement: [
      paragraph([
        math(String.raw`M_{\mathrm{col}}\in\mathbb Z_{\geq2}`),
        "、",
        math(String.raw`\mu\in\mathbb Z`),
        " とする。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu`),
        " について、旧複合主張の番号を保った次の恒等式が成り立つ。",
      ]),
      displayMath(String.raw`\text{(3) 共役添字：}\quad \tilde\theta_{1-\mu} = -\tilde\theta_\mu`),
    ],
    proof: [
      paragraph([
        "(3) 共役添字について、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\tilde\theta_{1-\mu}
&=\frac{2\pi\left(1-\mu-\frac12\right)}{M_{\mathrm{col}}}
&&\left(\because\ \tilde\theta_{1-\mu}\text{ の定義}\right)\\
&=\frac{2\pi\left(\frac12-\mu\right)}{M_{\mathrm{col}}}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}
&&\left(\because\ \mathbb{R}\text{ の四則}\right)\\
&=-\tilde\theta_\mu
&&\left(\because\ \tilde\theta_\mu\text{ の定義}\right)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "converted",
      notes: [
        "旧複合ラベルは、後続参照の意味を保つため、共役添字恒等式だけを述べる残余主張に残した。",
        "(3) により、整数運動量の場合に -μ が果たしていた「共役添字」の役割を、半整数運動量では 1-μ が果たす。反交換関係の対が μ+ν ≡ 1 (mod M) になるのはこのためである。",
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
        [math(String.raw`\text{(1)}\quad \tilde\theta_{M_{\mathrm{col}}+1-\mu} = 2\pi - \tilde\theta_\mu`)],
        [
          math(
            String.raw`\text{(2)}\quad \exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \exp(ij\tilde\theta_\mu)
\qquad (j \in \mathbb{Z})`,
          ),
        ],
        [
          math(
            String.raw`\text{(3)}\quad \check{Z}_{M_{\mathrm{col}}+1-\mu} = \check{Z}_{1-\mu},
\qquad \check{Y}_{M_{\mathrm{col}}+1-\mu} = \check{Y}_{1-\mu}`,
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
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
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
        math(String.raw`\tilde\theta_{M_{\mathrm{col}}+1-\mu}`),
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
\tilde\theta_{M_{\mathrm{col}}+1-\mu}
&= \frac{2\pi\left(M_{\mathrm{col}}+1-\mu-\frac12\right)}{M_{\mathrm{col}}}
   &&(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義}) \\
&= \frac{2\pi\left(M_{\mathrm{col}} - \left(\mu-\frac12\right)\right)}{M_{\mathrm{col}}}
   &&\left(\because M_{\mathrm{col}}+1-\mu-\tfrac12 = M_{\mathrm{col}} - \left(\mu-\tfrac12\right)\right) \\
&= 2\pi - \frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}
   &&(\because \mathbb C \text{ の四則}) \\
&= 2\pi - \tilde\theta_\mu
   &&(\because \blkref{antiperiodic_exp_sum}\text{ の } \tilde\theta \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "(2) ",
        math(String.raw`j \in \mathbb{Z}`),
        " について、(1) と指数法則より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\exp(-ij\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&= \exp(-ij\left(2\pi - \tilde\theta_\mu\right))
   &&(\because \text{直前の (1)}) \\
&= \exp(-2\pi i j)\,\exp(ij\tilde\theta_\mu)
   &&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \left(\cos(2\pi j) - i\sin(2\pi j)\right)\exp(ij\tilde\theta_\mu)
   &&(\because \blkref{euler_formula_cos_sin}) \\
&= \exp(ij\tilde\theta_\mu)
   &&(\because j \in \mathbb{Z} \text{ より } \cos(2\pi j) = 1,\ \sin(2\pi j) = 0)
\end{aligned}`,
      ),
      paragraph([
        "ここで指数法則の ", math(String.raw`n=1`), " は ",
        math(String.raw`\mathrm{Mat}(1,\mathbb{C}) = \mathbb{C}`),
        " における適用である。",
      ]),
      paragraph([
        "(3) ",
        ref("half_integer_checkZ_periodicity"),
        " と ",
        ref("half_integer_checkY_periodicity"),
        "（添字の周期性）を添字 ",
        math(String.raw`1-\mu \in \mathbb{Z}`),
        " に適用すると",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M_{\mathrm{col}}+1-\mu}
&=\check{Z}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Z}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkZ_periodicity}\bigr),\\[2pt]
\check{Y}_{M_{\mathrm{col}}+1-\mu}
&=\check{Y}_{(1-\mu)+M_{\mathrm{col}}}
&&\bigl(\because (1-\mu)+M_{\mathrm{col}}=M_{\mathrm{col}}+1-\mu\bigr)\\
&=\check{Y}_{1-\mu}
&&\bigl(\because \blkref{half_integer_checkY_periodicity}\bigr).
\end{aligned}`,
      ),
      paragraph([
        "この適用では、添字の周期性を ", math(String.raw`\check{\mathcal{M}}`),
        " の外の添字 ", math(String.raw`1-\mu`),
        " に用いている。添字の周期性を ", math(String.raw`\mu\in\mathbb Z`),
        " で述べたことが、この橋渡しを可能にする。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-01 の式変形統一で、二本の式変形鎖の行中にあった根拠 7 行を行末の根拠列（aligned の &&）へ揃え、添字の周期性の二本の等式を同じ形へ開いた。内容・式変形・根拠・ラベル参照は不変である。",
      ],
    },
  },


  {
    id: "evensector_005_claim_anticommutator_check_Z_Y",
    kind: "claim",
    standing: "mainTheorem",
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
        String.raw`\left[\check{Z}_\mu, \check{Z}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I,
\qquad
\left[\check{Z}_\mu, \check{Y}_\nu\right]_+ = 0,
\qquad
\left[\check{Y}_\mu, \check{Y}_\nu\right]_+ = 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`,
      ),
      paragraph([
        "が成り立つ。ここで ",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}`),
        " は通常のクロネッカーのデルタ（",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
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
        math(String.raw`\mu+\nu \equiv 1 \pmod M_{\mathrm{col}}`),
        " と ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " が同値である。",
      ]),
    ],
    proof: [
      paragraph([
        "反交換子は両引数について ",
        math(String.raw`\mathbb{C}`),
        " 双線型（",
        math(String.raw`[\alpha X,\beta W]_+ = \alpha\beta[X,W]_+`),
        "）なので、",
        ref("def_half_integer_checkZ"),
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
&= \left[\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)Z_j,\ \sum_{k=1}^{M_{\mathrm{col}}} \exp(-ik\tilde\theta_\nu)Z_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\,\exp(-ik\tilde\theta_\nu)
   \left[Z_j, Z_k\right]_+
   &&\bigl(\because \text{反交換子の } \mathbb{C} \text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\,\exp(-ik\tilde\theta_\nu)\cdot 2I\,\delta^{(M_{\mathrm{col}})}_{(j,k)}
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\tilde\theta_\mu)\,\exp(-ij\tilde\theta_\nu)
   &&\bigl(\because 1 \leq j,k \leq M_{\mathrm{col}} \text{ では } \delta^{(M_{\mathrm{col}})}_{(j,k)} = 1 \iff j = k\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}} \exp(-ij\left(\tilde\theta_\mu + \tilde\theta_\nu\right))
   &&\bigl(\because \text{theorem\_exp\_product}\ (n=1)\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}} \exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M_{\mathrm{col}}}\right)
   &&\bigl(\because \tilde\theta_\mu + \tilde\theta_\nu = \tfrac{2\pi(\mu+\nu-1)}{M_{\mathrm{col}}}\bigr) \\
&= 2M_{\mathrm{col}} I\,\delta^{(M_{\mathrm{col}})}_{(-(\mu+\nu-1),\,0)}
   &&\bigl(\because \text{exp\_sum}\bigr) \\
&= 2M_{\mathrm{col}} I\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}
   &&\bigl(\because \text{def\_delta\_M}\bigr) \\
&= 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I
   &&\bigl(\because \text{def\_check\_index\_set (5)}\ (\mu,\nu \in \check{\mathcal{M}})\bigr)
\end{aligned}`,
      ),
      paragraph([
        "第 2 式は、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        " と ",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Z_j,Y_k]_+=0`),
        " を使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\left[\check{Z}_\mu,\check{Y}_\nu\right]_+
&= \left[\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Z_j,\ \sum_{k=1}^{M_{\mathrm{col}}}\exp(-ik\tilde\theta_\nu)Y_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkZ},\ \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\exp(-ik\tilde\theta_\nu)[Z_j,Y_k]_+
   &&\bigl(\because \text{反交換子の }\mathbb{C}\text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\exp(-ik\tilde\theta_\nu)\cdot 0
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 0
   &&\bigl(\because \mathbb{C}\text{ の四則}\bigr)
\end{aligned}`,
      ),
      paragraph([
        "第 3 式も、",
        ref("def_half_integer_checkY"),
        "、",
        ref("anticommutator_of_Z_and_Y"),
        " の ",
        math(String.raw`[Y_j,Y_k]_+ = 2I\,\delta^{(M_{\mathrm{col}})}_{(j,k)}`),
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
&= \left[\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)Y_j,\ \sum_{k=1}^{M_{\mathrm{col}}}\exp(-ik\tilde\theta_\nu)Y_k\right]_+
   &&\bigl(\because \blkref{def_half_integer_checkY}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\exp(-ik\tilde\theta_\nu)[Y_j,Y_k]_+
   &&\bigl(\because \text{反交換子の }\mathbb{C}\text{ 双線型性}\bigr) \\
&= \sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\exp(-ik\tilde\theta_\nu)\cdot 2I\,\delta^{(M_{\mathrm{col}})}_{(j,k)}
   &&\bigl(\because \text{anticommutator\_of\_Z\_and\_Y}\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij\tilde\theta_\mu)\exp(-ij\tilde\theta_\nu)
   &&\bigl(\because 1\le j,k\le M_{\mathrm{col}}\text{ では }\delta^{(M_{\mathrm{col}})}_{(j,k)}=1\iff j=k\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}}\exp(-ij(\tilde\theta_\mu+\tilde\theta_\nu))
   &&\bigl(\because \text{theorem\_exp\_product}\ (n=1)\bigr) \\
&= 2I\sum_{j=1}^{M_{\mathrm{col}}}\exp\!\left(\frac{2\pi i j\left(-(\mu+\nu-1)\right)}{M_{\mathrm{col}}}\right)
   &&\bigl(\because \tilde\theta_\mu+\tilde\theta_\nu=\tfrac{2\pi(\mu+\nu-1)}{M_{\mathrm{col}}}\bigr) \\
&= 2M_{\mathrm{col}} I\,\delta^{(M_{\mathrm{col}})}_{(-(\mu+\nu-1),\,0)}
   &&\bigl(\because \text{exp\_sum}\bigr) \\
&= 2M_{\mathrm{col}} I\,\delta^{(M_{\mathrm{col}})}_{(\mu+\nu,\,1)}
   &&\bigl(\because \text{def\_delta\_M}\bigr) \\
&= 2M_{\mathrm{col}}\,\delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I
   &&\bigl(\because \text{def\_check\_index\_set (5)}\ (\mu,\nu\in\check{\mathcal M})\bigr)
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },

  {
    id: "evensector_006_claim_recover_Z_Y",
    kind: "claim",
    origin: { path: SRC, ordinal: 10 },
    title: { tex: String.raw`\check{Z}, \check{Y} \text{ から } Z_j, Y_j \text{ を復元する}` },
    labels: ["recover_Z_Y_from_check_Z_Y"],
    statement: [
      paragraph([math(String.raw`j \in \{1,\dots,M_{\mathrm{col}}\}`), " について"]),
      displayMath(
        String.raw`Z_j = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Z}_\mu\,\exp(i j\tilde\theta_\mu),
\qquad
Y_j = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Y}_\mu\,\exp(i j\tilde\theta_\mu)`,
      ),
      paragraph([
        "が成り立つ。とくに ",
        math(String.raw`\check{Z}_1,\dots,\check{Z}_{M_{\mathrm{col}}},\check{Y}_1,\dots,\check{Y}_{M_{\mathrm{col}}}`),
        " は ",
        ref("Z_Y_generate_algebra"),
        " の ",
        math(String.raw`Z_j, Y_j`),
        " を生成するので、",
        math(String.raw`\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " を（単位的 ",
        math(String.raw`\mathbb{C}`),
        " 代数として）生成する。",
      ]),
    ],
    proof: [
      paragraph([
        "準備として、",
        math(String.raw`j, k \in \{1,\dots,M_{\mathrm{col}}\}`),
        " のとき ",
        math(String.raw`|j-k| \leq M_{\mathrm{col}}-1 < M_{\mathrm{col}}`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " を指数の整数 ",
        math(String.raw`j-k`),
        " に適用する。まず ",
        math(String.raw`j = k`),
        " のときは",
      ]),
      displayMath(
        String.raw`\begin{aligned}
j-k
&=0
&&(\because\ j=k\text{ と }\mathbb Z\text{ の減法})\\
&=0\cdot M_{\mathrm{col}}
&&(\because\ \mathbb Z\text{ の乗法})
\end{aligned}`,
      ),
      paragraph([
        "であり、",
        math(String.raw`(-1)^0 = 1`),
        "、",
        math(String.raw`j \neq k`),
        " のときは ",
        math(String.raw`|j-k| < M_{\mathrm{col}}`),
        " かつ ",
        math(String.raw`j-k \neq 0`),
        " なので ",
        math(String.raw`j-k \not\equiv 0 \pmod M_{\mathrm{col}}`),
        " である。したがって",
      ]),
      displayMath(
        String.raw`\sum_{\mu=1}^{M_{\mathrm{col}}} \exp(i(j-k)\tilde\theta_\mu)
= \begin{cases}
M_{\mathrm{col}} & (j = k) \\
0 & (j \neq k)
\end{cases}\quad(\because\ \blkref{antiperiodic_exp_sum}\text{ と }|j-k|<M_{\mathrm{col}})`,
      ),
      paragraph([
        "である。第 1 式は、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("theorem_exp_product"),
        " と準備の等式を順に使うと、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_\mu\,\exp(ij\tilde\theta_\mu)
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(-ik\tilde\theta_\mu)\right)\exp(ij\tilde\theta_\mu)
&&(\because \blkref{def_half_integer_checkZ}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(-ik\tilde\theta_\mu)\,\exp(ij\tilde\theta_\mu)
&&(\because \text{有限和への分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(i(j-k)\tilde\theta_\mu)
&&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Z_k \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(i(j-k)\tilde\theta_\mu)
&&(\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\cdot Z_j\cdot M_{\mathrm{col}}
&&(\because \blkref{antiperiodic_exp_sum}\text{ と準備の等式により } k = j \text{ の項だけが残る}) \\
&= Z_j
&&(\because M_{\mathrm{col}}\ne 0\text{ なのでスカラー }\tfrac{1}{M_{\mathrm{col}}}\text{ と }M_{\mathrm{col}}\text{ が相殺する})
\end{aligned}`,
      ),
      paragraph([
        "第 2 式も、",
        ref("def_half_integer_checkY"),
        " の ",
        math(String.raw`\check{Y}_\mu`),
        " の定義から同じ根拠の並びで、一続きに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\,\exp(ij\tilde\theta_\mu)
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{k=1}^{M_{\mathrm{col}}} Y_k\,\exp(-ik\tilde\theta_\mu)\right)\exp(ij\tilde\theta_\mu)
&&(\because \blkref{def_half_integer_checkY}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_k\,\exp(-ik\tilde\theta_\mu)\,\exp(ij\tilde\theta_\mu)
&&(\because \text{有限和への分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_k\,\exp(i(j-k)\tilde\theta_\mu)
&&(\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_k \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(i(j-k)\tilde\theta_\mu)
&&(\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\cdot Y_j\cdot M_{\mathrm{col}}
&&(\because \blkref{antiperiodic_exp_sum}\text{ と準備の等式により } k = j \text{ の項だけが残る}) \\
&= Y_j
&&(\because M_{\mathrm{col}}\ne 0\text{ なのでスカラー }\tfrac{1}{M_{\mathrm{col}}}\text{ と }M_{\mathrm{col}}\text{ が相殺する})
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
        "2026-08-31 の式変形統一で、準備の散文に埋まっていた j-k=0=0M を、整数の減法と乗法を一つずつ適用する二段の鎖へ開いた。内容・参照は変えていない。",
        "2026-08-31 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 14 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・参照は変えていない。",
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
        String.raw`H_1^{(+)} = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Y}_\mu\,\check{Z}_{M_{\mathrm{col}}+1-\mu}\,\exp(-i\tilde\theta_\mu),
\qquad
H_2 = \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}} \check{Z}_{M_{\mathrm{col}}+1-\mu}\,\check{Y}_\mu`,
      ),
      paragraph([
        "が成り立つ（",
        math(String.raw`H_1^{(+)}`),
        " は ",
        ref("def_H1_plus"),
        " のもの、",
        math(String.raw`H_2`),
        " は ",
        ref("def_H2"),
        " のもの）。和の添字 ",
        math(String.raw`\mu`),
        " も共役添字 ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
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
        ref("def_half_integer_checkZ"),
        " と ",
        ref("conjugate_index_of_check_Z_Y"),
        " (2) から ",
        math(String.raw`\check{Z}_{M_{\mathrm{col}}+1-\mu}`),
        " の表示を用意する。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{Z}_{M_{\mathrm{col}}+1-\mu}
&= \sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(-ik\tilde\theta_{M_{\mathrm{col}}+1-\mu})
&& (\because \blkref{def_half_integer_checkZ}) \\
&= \sum_{k=1}^{M_{\mathrm{col}}} Z_k\,\exp(ik\tilde\theta_\mu)
&& (\because \blkref{conjugate_index_of_check_Z_Y}\text{ (2)})
\end{aligned}`,
      ),
      paragraph([
        "次に ",
        math(String.raw`1 \leq j,k \leq M_{\mathrm{col}}`),
        " より ",
        math(String.raw`|k-j| < M_{\mathrm{col}}`),
        " なので、",
        ref("antiperiodic_exp_sum"),
        " より内側の和は ",
        math(String.raw`k = j`),
        " のとき ",
        math(String.raw`M_{\mathrm{col}}`),
        "、そうでないとき ",
        math(String.raw`0`),
        " である。これと ",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H2"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Z}_{M_{\mathrm{col}}+1-\mu}\check{Y}_\mu
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{k=1}^{M_{\mathrm{col}}}Z_k \exp(ik\tilde\theta_\mu)\right)
   \left(\sum_{j=1}^{M_{\mathrm{col}}}Y_j \exp(-ij\tilde\theta_\mu)\right)
&& (\because \text{準備した }\check Z_{M_{\mathrm{col}}+1-\mu}\text{ の表示と }\blkref{def_half_integer_checkY}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j\,
   \exp(ik\tilde\theta_\mu)\exp(-ij\tilde\theta_\mu)
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j\,
   \exp(i(k-j)\tilde\theta_\mu)
&& (\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_kY_j
   \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(i(k-j)\tilde\theta_\mu)
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}} Z_jY_j\cdot M_{\mathrm{col}}
&& (\because \blkref{antiperiodic_exp_sum}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}} Z_jY_j
&& (\because \text{スカラー } \tfrac{1}{M_{\mathrm{col}}} \text{ と } M_{\mathrm{col}} \text{ の相殺}) \\
&= H_2
&& (\because \blkref{def_H2})
\end{aligned}`,
      ),
      paragraph([
        "もう一方の式の準備として、",
        math(String.raw`1 \leq j,k \leq M_{\mathrm{col}}`),
        " より ",
        math(String.raw`j-k+1`),
        " は ",
        math(String.raw`2-M_{\mathrm{col}}`),
        " 以上 ",
        math(String.raw`M_{\mathrm{col}}`),
        " 以下である。",
        ref("antiperiodic_exp_sum"),
        " より、内側の和が ",
        math(String.raw`0`),
        " でないのは ",
        math(String.raw`j-k+1 = lM_{\mathrm{col}}`),
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
          math(String.raw`k \leq M_{\mathrm{col}}`),
          " より ",
          math(String.raw`1 \leq j \leq M_{\mathrm{col}}-1`),
          "）。このとき内側の和は ",
          math(String.raw`M_{\mathrm{col}}(-1)^0 = M_{\mathrm{col}}`),
          "。",
        ],
        [
          math(String.raw`l = 1`),
          "、すなわち ",
          math(String.raw`j-k+1 = M_{\mathrm{col}}`),
          "。",
          math(String.raw`1\leq j,k\leq M_{\mathrm{col}}`),
          " でこれを満たすのは ",
          math(String.raw`j = M_{\mathrm{col}},\ k = 1`),
          " のみ。このとき内側の和は ",
          math(String.raw`M_{\mathrm{col}}(-1)^1 = -M_{\mathrm{col}}`),
          "。",
        ],
      ]),
      paragraph([
        "したがって、",
        ref("def_half_integer_checkZ"),
        " と ",
        ref("def_half_integer_checkY"),
        "、",
        ref("theorem_exp_product"),
        "、",
        ref("def_H1_plus"),
        " を順に使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\check{Y}_\mu\check{Z}_{M_{\mathrm{col}}+1-\mu}\exp(-i\tilde\theta_\mu)
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\left(\sum_{j=1}^{M_{\mathrm{col}}}Y_j \exp(-ij\tilde\theta_\mu)\right)
   \left(\sum_{k=1}^{M_{\mathrm{col}}}Z_k \exp(ik\tilde\theta_\mu)\right) \exp(-i\tilde\theta_\mu)
&& (\because \blkref{def_half_integer_checkY}\text{ と準備した } \check{Z}_{M_{\mathrm{col}}+1-\mu} \text{ の表示}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k\,
   \exp(-ij\tilde\theta_\mu)\exp(ik\tilde\theta_\mu)\exp(-i\tilde\theta_\mu)
&& (\because \text{積を二重和へ分配}) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{\mu=1}^{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k\,
   \exp(-i(j-k+1)\tilde\theta_\mu)
&& (\because \blkref{theorem_exp_product}\ (n=1)) \\
&= \frac{1}{M_{\mathrm{col}}}\sum_{j=1}^{M_{\mathrm{col}}}\sum_{k=1}^{M_{\mathrm{col}}} Y_jZ_k
   \sum_{\mu=1}^{M_{\mathrm{col}}} \exp(-i(j-k+1)\tilde\theta_\mu)
&& (\because \text{有限和の順序交換}) \\
&= \frac{1}{M_{\mathrm{col}}}\left(\sum_{j=1}^{M_{\mathrm{col}}-1} Y_jZ_{j+1}\cdot M_{\mathrm{col}} + Y_{M_{\mathrm{col}}}Z_1\cdot(-M_{\mathrm{col}})\right)
&& (\because \blkref{antiperiodic_exp_sum}\text{ と直上の 2 つの場合分け}) \\
&= \sum_{j=1}^{M_{\mathrm{col}}-1} Y_jZ_{j+1} - Y_{M_{\mathrm{col}}}Z_1
&& (\because \text{スカラー } \tfrac{1}{M_{\mathrm{col}}} \text{ の分配と } \tfrac{1}{M_{\mathrm{col}}}\cdot M_{\mathrm{col}} = 1,\ \tfrac{1}{M_{\mathrm{col}}}\cdot(-M_{\mathrm{col}}) = -1 \text{ の相殺}) \\
&= H_1^{(+)}
&& (\because \blkref{def_H1_plus})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "境界項 -Y_M Z_1 の符号が、antiperiodic_exp_sum の l=1 の因子 (-1)^1 として自動的に出てくる。整数運動量版 H1_H2_via_hatZ_hatY で hat(Z)^{(±)} の第 1 項の符号が担っていた役割を、ここでは指数和の符号が担っている。",
        "2026-08-19 の式変形統一で、H_2 と H_1^{(+)} の導出を分断していた説明・重複した参照を準備へ移し、それぞれ主張の右辺から H_2・H_1^{(+)} へ至る一続きの鎖へまとめた。内容・参照は変えていない。",
        "2026-09-01 の式変形統一で、三本の鎖に行中の \\quad(\\because …) で置かれていた根拠 16 行を、他の証明と同じ行末の根拠列（aligned の &&）へ揃えた。内容・式変形・根拠・参照は変えていない。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
]);
