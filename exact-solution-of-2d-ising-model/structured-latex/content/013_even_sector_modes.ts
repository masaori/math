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
