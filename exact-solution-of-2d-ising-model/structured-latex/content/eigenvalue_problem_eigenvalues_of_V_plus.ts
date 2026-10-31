import { defineBlocks, paragraph, math, displayMath, list, ref } from "../schema.ts";

/**
 * 部「固有値問題」の章「V^{(+)} の固有値」。章立て（`tools/chapter-plan.ts`）で
 * この章に割り当てた項を、章の中の依存順に並べる。章の最後は、この章のゴールの式を主張するブロックである。
 */

export default defineBlocks([
  {
    id: "heading_chapter_eigenvalues_of_V_plus",
    kind: "heading",
    level: 2,
    title: { tex: String.raw`V^{(+)}\text{ の固有値}` },
    labels: [],
  },
  {
    id: "evenEigen_000_remark_overview",
    kind: "remark",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 2 },
    title: { tex: String.raw`c \text{ の値と } V^{(+)} \text{ の固有値を求める道筋}` },
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
        " の値そのものは決まっていない。以下では ",
        math(String.raw`c`),
        " を決定し、あわせて ",
        math(String.raw`V^{(+)}`),
        " の固有値をすべて求める。結論は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}, \qquad
V^{(+)} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\,\check{V}'`,
      ),
      paragraph([
        "であり、",
        math(String.raw`V^{(+)}`),
        " の固有値は ",
        math(String.raw`\epsilon = (\epsilon_\mu)_{\mu=1}^{M_{\mathrm{col}}}`),
        "（各 ",
        math(String.raw`\epsilon_\mu \in \{0,1\}`),
        "）でパラメトライズされた",
      ]),
      displayMath(
        String.raw`\check\Lambda_\epsilon = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right)\right)`,
      ),
      paragraph([
        "であり、その最大値は ",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}}`),
        " で ",
        math(String.raw`\delta = \tfrac12`),
        " と取ったもの ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
        " に一致し、しかも**単純固有値**である。",
      ]),
      paragraph([
        "次のブロックを用いる：トレース（",
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
        "。いずれも ",
        math(String.raw`S_1^{(+)} = iK_1H_1^{(+)}`),
        " について述べてある）。",
      ]),
      paragraph([
        math(String.raw`\tilde\theta_\mu`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "）について次の 3 点が成り立つのは、",
        ref("gamma_2_theta_tilde_nonzero"),
        "（",
        math(String.raw`\gamma_2(\tilde\theta_\mu) \neq 0`),
        " が例外なく成り立つこと）と ",
        ref("gamma_theta_tilde_mu_positive"),
        "（",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        "）による。",
      ]),
      list([
        [
          "(a) ", math(String.raw`\check{n}_\mu`), " の添字の集合が ",
          math(String.raw`\check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\}`),
          "（",
          ref("def_check_index_set"),
          "）の全部になる。",
        ],
        [
          "(b) 同時固有空間が**すべて 1 次元**になる。",
        ],
        [
          "(c) ",
          math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
          " が狭義なので、**最大固有値が単純になる。**",
        ],
      ]),
      paragraph([
        "**対になる添字は ",
        math(String.raw`\mu`),
        " と ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " である**（",
        ref("conjugate_index_of_check_Z_Y"),
        "、",
        ref("anticommutator_of_check_psi"),
        "）。",
        ref("def_check_index_set"),
        " (2) により ",
        math(String.raw`M_{\mathrm{col}}+1-\mu`),
        " は ",
        math(String.raw`\check{\mathcal{M}}`),
        " の中にとどまるので、**以下の主張はすべて ",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        " について述べられ、",
        math(String.raw`\check{\mathcal{M}}`),
        " の外の添字は現れない。**",
      ]),
      paragraph([
        "以下で用いる道具は、複素数を成分とする行列の積・和・スカラー倍、行列の指数関数（",
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
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "eigenvalues_of_V_014_claim_iH_is_real_symmetric",
    kind: "claim",
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 16 },
    title: { tex: String.raw`i K_1 H_1^{(+)} \text{ と } i K_2^* H_2 \text{ は実対称}` },
    labels: ["iH_is_real_symmetric"],
    statement: [
      paragraph([
        ref("def_transfer_matrix_symbols"),
        " の記号のもとで、",
      ]),
      displayMath(
        String.raw`S_1^{(+)} := i K_1 H_1^{(+)}, \qquad S_2 := i K_2^* H_2`,
      ),
      paragraph(["とおくと、"]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(+)} &= K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z\right)
  - K_1\, G, \qquad
G := \sigma_1^y\,\sigma_2^x \sigma_3^x \cdots \sigma_{M_{\mathrm{col}}-1}^x\, \sigma_{M_{\mathrm{col}}}^y \\
S_2 &= K_2^*\left(\sigma_1^x + \sigma_2^x + \cdots + \sigma_{M_{\mathrm{col}}}^x\right)
\end{aligned}`,
      ),
      paragraph([
        "であり（",
        math(String.raw`M_{\mathrm{col}} = 2`),
        " のとき ",
        math(String.raw`G = \sigma_1^y\sigma_2^y`),
        " と読む）、",
        math(String.raw`S_1^{(+)}`),
        " と ",
        math(String.raw`S_2`),
        " はいずれも成分がすべて実数で、転置について対称である。とくに ",
        ref("def_hermitian_positive_definite"),
        " の意味でエルミートである。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（用いる ",
        math(String.raw`2\times 2`),
        " の積）。Pauli 行列の行列表示から直接成分計算して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma^z\sigma^y
&= \begin{pmatrix}1&0\\0&-1\end{pmatrix}\begin{pmatrix}0&-i\\i&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}0&-i\\-i&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^x
   \quad (\because \sigma^x \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^y\sigma^x
&= \begin{pmatrix}0&-i\\i&0\end{pmatrix}\begin{pmatrix}0&1\\1&0\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}-i&0\\0&i\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^z
   \quad (\because \sigma^z \text{ の行列表示})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\sigma^x\sigma^z
&= \begin{pmatrix}0&1\\1&0\end{pmatrix}\begin{pmatrix}1&0\\0&-1\end{pmatrix}
   \quad (\because \text{Pauli 行列の行列表示},\ \blkref{pauli_matrix_products}) \\
&= \begin{pmatrix}0&-1\\1&0\end{pmatrix}
   \quad (\because \text{行列積の成分計算}) \\
&= -i\,\sigma^y
   \quad (\because \sigma^y \text{ の行列表示})
\end{aligned}`,
      ),
      paragraph([
        "また ",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = I`),
        "、相異なるサイトに置かれた ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        "（",
        math(String.raw`j \neq k`),
        "）は可換である（",
        ref("kronecker_product_rule"),
        " (1) より、クロネッカー積どうしの積は各サイトごとの ",
        math(String.raw`2`),
        " 次の行列の積になり、各サイトでは一方が ",
        math(String.raw`I_{\mathrm{Mat}(2,\mathbb{C})}`),
        " だから）。",
      ]),
      paragraph([
        "Step 1（",
        math(String.raw`S_2`),
        " の形）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\sigma_m^y`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Z_m Y_m
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \quad (\because Z_m,\ Y_m \text{ の定義}) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)\left(\sigma_1^x\cdots\sigma_{m-1}^x\right)
   \sigma_m^z\sigma_m^y
   \quad (\because \sigma_m^z \text{ は } \sigma_j^x\ (j<m) \text{ と可換}) \\
&= \sigma_m^z\sigma_m^y
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^x
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["よって"]),
      displayMath(
        String.raw`\begin{aligned}
H_2
&= \sum_{m=1}^{M_{\mathrm{col}}} Z_mY_m
   \quad (\because\ \blkref{def_H2}) \\
&= \sum_{m=1}^{M_{\mathrm{col}}} (-i\,\sigma_m^x)
   \quad (\because \text{上で得た } Z_mY_m = -i\,\sigma_m^x) \\
&= -i\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because \text{スカラー倍の和の分配})
\end{aligned}`,
      ),
      paragraph(["であり、"]),
      displayMath(
        String.raw`\begin{aligned}
S_2
&= iK_2^*H_2
   \quad (\because S_2 \text{ の定義}) \\
&= iK_2^*\left(-i\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x\right)
   \quad (\because \text{上で得た } H_2 \text{ の表示}) \\
&= i(-i)\,K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because \text{スカラー倍の交換}) \\
&= K_2^*\sum_{m=1}^{M_{\mathrm{col}}}\sigma_m^x
   \quad (\because i\cdot(-i) = 1)
\end{aligned}`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`S_1^{(+)}`),
        " の形）。",
        math(String.raw`1 \leq m \leq M_{\mathrm{col}}-1`),
        " に対して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
Y_m Z_{m+1}
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y\right)
   \left(\sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^x\,\sigma_{m+1}^z\right)
   \quad (\because Y_m,\ Z_{m+1} \text{ の定義}) \\
&= \left(\sigma_1^x\cdots\sigma_{m-1}^x\right)^2\,
   \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \text{相異なる因子どうしは可換}) \\
&= \sigma_m^y\sigma_m^x\,\sigma_{m+1}^z
   \quad (\because \sigma_j^x\sigma_j^x = I) \\
&= -i\,\sigma_m^z\sigma_{m+1}^z
   \quad (\because \text{Step 0})
\end{aligned}`,
      ),
      paragraph(["また境界項について"]),
      displayMath(
        String.raw`\begin{aligned}
Y_{M_{\mathrm{col}}} Z_1
&= \left(\sigma_1^x\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y\right)\sigma_1^z
   \quad (\because Y_{M_{\mathrm{col}}},\ Z_1 \text{ の定義}) \\
&= \left(\sigma_1^x\sigma_1^z\right)\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \sigma_1^z \text{ は他の因子と可換}) \\
&= -i\,\sigma_1^y\,\sigma_2^x\cdots\sigma_{M_{\mathrm{col}}-1}^x\,\sigma_{M_{\mathrm{col}}}^y
   \quad (\because \text{Step 0}) \\
&= -i\,G
   \quad (\because G \text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "これらと ",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)}`),
        " の定義を使うと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
S_1^{(+)}
&= iK_1H_1^{(+)}
   \quad (\because S_1^{(+)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1} Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1\right)
   \quad (\because H_1^{(+)} \text{ の定義}) \\
&= iK_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\left(-i\,\sigma_m^z\sigma_{m+1}^z\right) - (-i\,G)\right)
   \quad (\because \text{上で得た } Y_mZ_{m+1},\ Y_{M_{\mathrm{col}}}Z_1 \text{ の表示}) \\
&= i(-i)\,K_1\left(\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z - G\right)
   \quad (\because \text{スカラー倍の和の分配と交換}) \\
&= K_1\sum_{m=1}^{M_{\mathrm{col}}-1}\sigma_m^z\sigma_{m+1}^z - K_1\,G
   \quad (\because i\cdot(-i) = 1 \text{ と分配則})
\end{aligned}`,
      ),
      paragraph([
        "Step 3（実対称性）。",
        math(String.raw`\sigma^x = \begin{pmatrix}0&1\\1&0\end{pmatrix}`),
        " と ",
        math(String.raw`\sigma^z = \begin{pmatrix}1&0\\0&-1\end{pmatrix}`),
        " は成分が実で対称、",
        math(String.raw`\sigma^y = \begin{pmatrix}0&-i\\i&0\end{pmatrix}`),
        " は成分が純虚数で交代（",
        math(String.raw`(\sigma^y)^\top = -\sigma^y`),
        "）である。クロネッカー積（",
        ref("def_kronecker"),
        "）の成分は各因子の成分の積であり、転置は因子ごとの転置になる（",
        ref("kronecker_transpose"),
        "）：",
      ]),
      displayMath(
        String.raw`\left(A_1\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}\right)^\top
= A_1^\top\boxtimes\cdots\boxtimes A_{M_{\mathrm{col}}}^\top
\quad (\because \text{クロネッカー積の転置})`,
      ),
      paragraph([
        "したがって、",
      ]),
      list([
        [
          math(String.raw`\sigma_m^x`),
          "：",
          math(String.raw`\sigma^x`),
          " が 1 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`\sigma_m^z\sigma_{m+1}^z`),
          "：",
          math(String.raw`\sigma^z`),
          " が 2 個、他は ",
          math(String.raw`I`),
          "。成分は実、転置で不変。",
        ],
        [
          math(String.raw`G`),
          "：",
          math(String.raw`\sigma^y`),
          " が **2 個**（第 1 因子と第 ",
          math(String.raw`M_{\mathrm{col}}`),
          " 因子）、残りは ",
          math(String.raw`\sigma^x`),
          "。純虚数成分の因子がちょうど 2 個なので、成分の積に現れる虚数単位は ",
          math(String.raw`i^2 = -1`),
          " の形でまとまり、成分はすべて実数。転置は ",
          math(String.raw`(-1)^2 = 1`),
          " 倍なので ",
          math(String.raw`G^\top = G`),
          "。",
        ],
      ]),
      paragraph([
        math(String.raw`K_1, K_2^* \in \mathbb{R}`),
        " なので、これらの実係数の有限和である ",
        math(String.raw`S_1^{(+)}`),
        "、",
        math(String.raw`S_2`),
        " は成分がすべて実数で転置について対称、すなわち実対称である。",
        ref("def_hermitian_positive_definite"),
        " の最後の注意より、実対称行列はエルミートである。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。A_1⊗⋯⊗A_M 型の積を <def_kronecker> のクロネッカー積 A_1⊠⋯⊠A_M へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "iK_1H_1^{(±)} と iK_2^*H_2 が厳密に実対称（成分が実かつ転置不変）であることは、M=2,3,4,5 と両符号について数値的にも残差 0 で確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_01_real_symmetric.sage）。",
        "2026-08-15 の式変形統一で、Step 1 の Z_mY_m の鎖と Step 2 の Y_mZ_{m+1} の鎖の先頭行（定義の適用）に欠けていた行末根拠を補った。内容は変えていない。",
        "2026-09-05 の式変形統一で、Step 0 の三つの Pauli 行列積について、段落に置かれていた参照を実際に行列表示を使う各等号の行末へ移した。内容と計算順序は変えていない。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "eigenvalues_of_V_016_claim_sign_flip_conjugation",
    kind: "claim",
    origin: { path: "structured-latex/content/009_eigenvalues_of_V.ts", ordinal: 18 },
    title: { tex: String.raw`\text{符号反転共役 } U` },
    labels: ["sign_flip_conjugation"],
    statement: [
      paragraph([math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`), " とし、"]),
      displayMath(
        String.raw`E := \prod_{\substack{1 \leq m \leq M_{\mathrm{col}} \\ m\ \text{奇数}}} \sigma_m^x, \qquad
F := \prod_{m=1}^{M_{\mathrm{col}}} \sigma_m^z, \qquad
U := E F \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
      ),
      paragraph([
        "とおく（積の因子は相異なるサイトに置かれた ",
        math(String.raw`2`),
        " 次の行列のクロネッカー積なので、",
        ref("kronecker_product_rule"),
        " (1) より互いに可換であり、順序は問わない）。このとき ",
        math(String.raw`U`),
        " は可逆で、",
      ]),
      displayMath(
        String.raw`U\,S_1^{(+)}\,U^{-1} = -\,S_1^{(+)}, \qquad
U\,S_2\,U^{-1} = -\,S_2`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`U H_1^{(+)} U^{-1} = -H_1^{(+)}`),
        "、",
        math(String.raw`U H_2 U^{-1} = -H_2`),
        "。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 0（可逆性）。",
        ref("pauli_matrix_products"),
        " より ",
        math(String.raw`\sigma^x\sigma^x = \sigma^z\sigma^z = I`),
        " なので、各サイト ",
        math(String.raw`m`),
        " で",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\sigma_m^x\sigma_m^x
&= I
   \quad (\because\ \text{パウリ行列の積}), \\
\sigma_m^z\sigma_m^z
&= I
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "が成り立つ。したがって ",
        math(String.raw`\sigma_m^x`),
        "、",
        math(String.raw`\sigma_m^z`),
        " はいずれも自分自身を逆行列にもつ可逆行列であり、可逆行列の有限積である ",
        math(String.raw`E, F, U`),
        " も可逆である。",
      ]),
      paragraph([
        "Step 1（1 因子ごとの共役）。",
        math(String.raw`j \neq k`),
        " なら ",
        math(String.raw`\sigma_j^a`),
        " と ",
        math(String.raw`\sigma_k^b`),
        " は可換なので、共役 ",
        math(String.raw`X \mapsto FXF^{-1}`),
        " において ",
        math(String.raw`F`),
        " のうち第 ",
        math(String.raw`k`),
        " 因子の ",
        math(String.raw`\sigma_k^z`),
        " だけが効く。",
        ref("pauli_matrix_products"),
        " の ",
        math(String.raw`\sigma^z\sigma^x = -\sigma^x\sigma^z`),
        "、",
        math(String.raw`\sigma^y\sigma^z = -\sigma^z\sigma^y`),
        "、および ",
        math(String.raw`(\sigma^z)^{-1} = \sigma^z`),
        " より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
F\sigma_k^x F^{-1}
&= \sigma_k^z\sigma_k^x\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^x\text{ と可換}) \\
&= -\sigma_k^x\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^x
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^y F^{-1}
&= \sigma_k^z\sigma_k^y\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^y\text{ と可換}) \\
&= -\sigma_k^y\sigma_k^z\sigma_k^z
   \quad (\because\ \text{パウリ行列の積}) \\
&= -\sigma_k^y
   \quad (\because\ \text{パウリ行列の積}), \\
F\sigma_k^z F^{-1}
&= \sigma_k^z\sigma_k^z\sigma_k^z
   \quad (\because\ k\ \text{以外のサイトの因子は }\sigma_k^z\text{ と可換}) \\
&= \sigma_k^z
   \quad (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`E`),
        " は奇数番目の因子にだけ ",
        math(String.raw`\sigma^x`),
        " をもつ。したがって ", math(String.raw`k`),
        " が偶数なら全因子が ", math(String.raw`\sigma_k^a`),
        " と可換であり、", math(String.raw`k`),
        " が奇数なら第 ", math(String.raw`k`),
        " 因子だけを計算すればよい。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E\sigma_k^aE^{-1}
&= \sigma_k^a
&& (\because\ k\text{ が偶数なら }E\text{ の全因子と可換}),\\
E\sigma_k^xE^{-1}
&= \sigma_k^x\sigma_k^x\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= \sigma_k^x
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^yE^{-1}
&= \sigma_k^x\sigma_k^y\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^y\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^y
&& (\because\ \text{パウリ行列の積}),\\
E\sigma_k^zE^{-1}
&= \sigma_k^x\sigma_k^z\sigma_k^x
&& (\because\ k\text{ が奇数なら第 }k\text{ 因子だけが効く})\\
&= -\sigma_k^z\sigma_k^x\sigma_k^x
&& (\because\ \text{パウリ行列の積})\\
&= -\sigma_k^z
&& (\because\ \text{パウリ行列の積})
\end{aligned}`,
      ),
      paragraph([
        "この 2 つを合成して（",
        math(String.raw`U X U^{-1} = E(FXF^{-1})E^{-1}`),
        "）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U\sigma_k^x U^{-1}
&= E\left(F\sigma_k^xF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E(-\sigma_k^x)E^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= -\sigma_k^x
   \quad (\because\ E\sigma_k^xE^{-1}=\sigma_k^x), \\
U\sigma_k^y U^{-1}
&= E\left(F\sigma_k^yF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= -E\sigma_k^yE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}+\sigma_k^y & (k\ \text{奇数}) \\ -\sigma_k^y & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け}), \\
U\sigma_k^z U^{-1}
&= E\left(F\sigma_k^zF^{-1}\right)E^{-1}
   \quad (\because\ U=EF) \\
&= E\sigma_k^zE^{-1}
   \quad (\because\ F\text{ による共役の計算}) \\
&= \begin{cases}-\sigma_k^z & (k\ \text{奇数}) \\ +\sigma_k^z & (k\ \text{偶数})\end{cases}
   \quad (\because\ E\text{ による共役の場合分け})
\end{aligned}`,
      ),
      paragraph([
        "以下、共役 ",
        math(String.raw`X \mapsto UXU^{-1}`),
        " が ",
        math(String.raw`\mathbb{C}`),
        " 線型で積を保つこと（",
        math(String.raw`U(XY)U^{-1} = (UXU^{-1})(UYU^{-1})`),
        "、",
        math(String.raw`U^{-1}U = I`),
        " より）を繰り返し使う。",
      ]),
      paragraph([
        "Step 2（",
        math(String.raw`Z_m`),
        " と ",
        math(String.raw`Y_m`),
        " への作用）。",
        ref("def_transfer_matrix_symbols"),
        " の ",
        math(String.raw`Z_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^z`),
        "、",
        math(String.raw`Y_m = \sigma_1^x\cdots\sigma_{m-1}^x\,\sigma_m^y`),
        " の各因子に Step 1 を適用すると、符号は因子ごとの符号の積になる。先頭の ",
        math(String.raw`\sigma^x`),
        " の因子は ",
        math(String.raw`m-1`),
        " 個あり、Step 1 の第 1 式より各々 ",
        math(String.raw`-1`),
        " なので寄与は ",
        math(String.raw`(-1)^{m-1}`),
        "。第 ",
        math(String.raw`m`),
        " 因子の寄与は Step 1 の第 2・第 3 式より",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U Z_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}-1 & (m\ \text{奇数}) \\ +1 & (m\ \text{偶数})\end{cases}\ Z_m
   \quad (\because\ \text{Step 1 を }Z_m\text{ の各因子に適用}) \\
&= -\,Z_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算}), \\
U Y_m U^{-1}
&= (-1)^{m-1}\cdot\begin{cases}+1 & (m\ \text{奇数}) \\ -1 & (m\ \text{偶数})\end{cases}\ Y_m
   \quad (\because\ \text{Step 1 を }Y_m\text{ の各因子に適用}) \\
&= +\,Y_m
   \quad (\because\ m\ \text{の偶奇ごとに符号を計算})
\end{aligned}`,
      ),
      paragraph([
        "（",
        math(String.raw`m`),
        " 奇数なら ",
        math(String.raw`(-1)^{m-1} = +1`),
        "、",
        math(String.raw`m`),
        " 偶数なら ",
        math(String.raw`(-1)^{m-1} = -1`),
        " なので、いずれの場合も積は ",
        math(String.raw`Z_m`),
        " について ",
        math(String.raw`-1`),
        "、",
        math(String.raw`Y_m`),
        " について ",
        math(String.raw`+1`),
        " になる。",
        math(String.raw`m = 1`),
        " のときは先頭の ",
        math(String.raw`\sigma^x`),
        " の因子が無く ",
        math(String.raw`Z_1 = \sigma_1^z`),
        "、",
        math(String.raw`Y_1 = \sigma_1^y`),
        " だが、",
        math(String.raw`1`),
        " は奇数なので符号は同じく ",
        math(String.raw`-1`),
        "、",
        math(String.raw`+1`),
        " である。**",
        math(String.raw`m`),
        " の偶奇によらない**ことが要点である。）",
      ]),
      paragraph([
        "Step 3（",
        math(String.raw`H_1^{(+)}`),
        " と ",
        math(String.raw`H_2`),
        " への作用）。",
        ref("def_H1_plus"),
        " の ",
        math(String.raw`H_1^{(+)} = \sum_{m=1}^{M_{\mathrm{col}}-1}Y_mZ_{m+1} - Y_{M_{\mathrm{col}}}Z_1`),
        " と ",
        ref("iH_is_real_symmetric"),
        " の Step 1 の ",
        math(String.raw`H_2 = \sum_{m=1}^{M_{\mathrm{col}}}Z_mY_m`),
        " は、どちらも ",
        math(String.raw`Y`),
        " と ",
        math(String.raw`Z`),
        " を 1 個ずつ掛けた項の、係数が ",
        math(String.raw`1`),
        " または ",
        math(String.raw`-1`),
        " の有限和である。Step 2 より各項について",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U\left(Y_j Z_k\right)U^{-1}
&= \left(U Y_j U^{-1}\right)\left(U Z_k U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (+Y_j)(-Z_k)
   \quad (\because\ \text{Step 2}) \\
&= -\,Y_j Z_k
   \quad (\because\ \text{スカラー倍と行列積の両立}), \\
U\left(Z_j Y_j\right)U^{-1}
&= \left(U Z_j U^{-1}\right)\left(U Y_j U^{-1}\right)
   \quad (\because\ \text{共役は積を保つ}) \\
&= (-Z_j)(+Y_j)
   \quad (\because\ \text{Step 2}) \\
&= -\,Z_j Y_j
   \quad (\because\ \text{スカラー倍と行列積の両立})
\end{aligned}`,
      ),
      paragraph([
        "なので、共役の ",
        math(String.raw`\mathbb{C}`),
        " 線型性より",
      ]),
      displayMath(
        String.raw`U H_1^{(+)} U^{-1} = -\,H_1^{(+)}, \qquad
U H_2 U^{-1} = -\,H_2`,
      ),
      paragraph([
        "Step 4（",
        math(String.raw`S_1^{(+)}, S_2`),
        " への言い換え）。",
        math(String.raw`S_1^{(+)} = iK_1H_1^{(+)}`),
        "、",
        math(String.raw`S_2 = iK_2^*H_2`),
        " であり、スカラー倍は共役と可換なので Step 3 から",
      ]),
      displayMath(
        String.raw`\begin{aligned}
U S_1^{(+)} U^{-1}
&= iK_1\,U H_1^{(+)} U^{-1}
   \quad (\because\ S_1^{(+)}=iK_1H_1^{(+)}\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_1H_1^{(+)}
   \quad (\because\ \text{Step 3}) \\
&= -\,S_1^{(+)}
   \quad (\because\ S_1^{(+)}=iK_1H_1^{(+)}), \\
U S_2 U^{-1}
&= iK_2^*\,U H_2 U^{-1}
   \quad (\because\ S_2=iK_2^*H_2\ \text{かつ共役はスカラー倍を保つ}) \\
&= -iK_2^*H_2
   \quad (\because\ \text{Step 3}) \\
&= -\,S_2
   \quad (\because\ S_2=iK_2^*H_2)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`K_1, K_2^* > 0`),
        " より ",
        math(String.raw`iK_1, iK_2^* \neq 0`),
        " なので、逆に ",
        math(String.raw`S`),
        " についての等式から ",
        math(String.raw`H`),
        " についての等式も従い、両者は同値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "抽象テンソル積の記法を廃した（README のゴール設定 2 節）。Mat(2,C)^{⊗M}（抽象テンソル冪）を具体的な行列空間 Mat(2^M,C) へ置き換えた。主張・証明の内容と段階構造・ラベルは変えていない。",
        "この U は M の偶奇によらず両方の符号 (±) について働く。M=2,3,4,5,6 と両符号で残差 0 を数値確認した（sagemath/check/042_claim_constant_c_and_eigenvalues_of_V/check_02_sign_flip_conjugation.sage）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "freeenergy_definition_Theta_delta_M",
    kind: "definition",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 7 },
    title: { tex: String.raw`\Theta^{(\delta)}_{M_{\mathrm{col}}}` },
    labels: ["def_Theta_delta_M"],
    statement: [
      paragraph([
        math(String.raw`\delta \in [0,1)`),
        " と ",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " に対し",
      ]),
      displayMath(
        String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)} := \left\{\, \frac{2\pi(\mu-\delta)}{M_{\mathrm{col}}} \ \middle|\ \mu = 1,\dots,M_{\mathrm{col}} \,\right\}`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`\delta \in [0,1) \subset \mathbb{R}`),
        " であり、元が ",
        math(String.raw`\pi \in \mathbb{R}`),
        " を含むので、",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " は ",
        math(String.raw`\mathbb{R}`),
        " の部分集合である。",
        math(String.raw`\mu`),
        " が有限個の値 ",
        math(String.raw`1,\dots,M_{\mathrm{col}}`),
        " を動くので、",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " は有限集合である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: もとは onsager_free_energy_expression の statement の中で Λ^{(δ)}_M と一緒に定義していた。Λ の定義とは別に、定理の証明と max_eigenvalue_of_V_plus_simple の証明がこの集合を使うので、独立した定義へ分けた。",
      ],
    },
  },
  {
    id: "freeenergy_definition_Lambda_delta_M",
    kind: "definition",
    origin: { path: "structured-latex/content/012_free_energy.ts", ordinal: 7 },
    title: { tex: String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}}` },
    labels: ["def_Lambda_delta_M"],
    statement: [
      paragraph([
        ref("def_transfer_matrix"),
        " の ",
        math(String.raw`K_2 \in \mathbb{R}_{>0}`),
        "、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma : \mathbb{R} \to \mathbb{R}_{\geq 0}`),
        "、",
        ref("def_Theta_delta_M"),
        " の ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " について、",
        math(String.raw`\delta \in [0,1)`),
        " と ",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " に対し",
      ]),
      displayMath(
        String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}} := (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\left(\frac{1}{2}\sum_{\theta \in \Theta_{M_{\mathrm{col}}}^{(\delta)}} \gamma(\theta)\right)`,
      ),
      paragraph([
        "とおく。",
        math(String.raw`K_2 > 0`),
        " より ",
        math(String.raw`2\sinh 2K_2 > 0`),
        " なので、実数冪 ",
        math(String.raw`(2\sinh 2K_2)^{M_{\mathrm{col}}/2}`),
        " が定まる。",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(\delta)}`),
        " は有限集合なので和が定まり、",
        math(String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}} \in \mathbb{R}`),
        " である（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        math(String.raw`\gamma`),
        " が実関数 ",
        math(String.raw`\mathrm{arccosh}`),
        " の値であり、",
        math(String.raw`\exp`),
        " と実数冪の値を取るからである）。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: もとは onsager_free_energy_expression の statement の中で定義していた。固有値問題の章（max_eigenvalue_of_V_plus_simple）と c_plus_equals_Lambda_half_integer が定義だけを使うために閉形式の定理を参照していたので、独立した定義へ分けた。",
      ],
    },
  },
  {
    id: "evenEigen_002_claim_check_number_operator_idempotent",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 4 },
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
\qquad \left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^2 = 0`),
        ],
        [
          math(String.raw`\text{(2)}\quad \check\psi_{M_{\mathrm{col}}+1-\mu}\,\check\psi_\mu^\dagger = I - \check{n}_\mu`),
        ],
        [math(String.raw`\text{(3)}\quad \check{n}_\mu^2 = \check{n}_\mu`)],
      ]),
    ],
    proof: [
      paragraph([
        "(1) 反交換関係の第 1 式 ",
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
   \quad (\because \text{$\check\psi$ の反交換関係の第 1 式で } \nu = \mu\text{。}\blkref{anticommutator_of_check_psi}) \\
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
        " で両方の添字を ", math(String.raw`M_{\mathrm{col}}+1-\mu`), " と取る。上と同じ三段を省略せず書くと",
      ]),
      displayMath(
        String.raw`\begin{aligned}
0
&= \left[\check\psi_{M_{\mathrm{col}}+1-\mu},\check\psi_{M_{\mathrm{col}}+1-\mu}\right]_+
   \quad (\because \text{$M_{\mathrm{col}}+1-\mu\in\check{\mathcal M}$ は添字集合の対称性。}\blkref{def_check_index_set}\text{。$\check\psi$ の反交換関係の第 3 式。}\blkref{anticommutator_of_check_psi}) \\
&= \check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_{M_{\mathrm{col}}+1-\mu}
  +\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{反交換子の定義}) \\
&= 2\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^2
   \quad (\because \text{同じ項の和})
\end{aligned}`,
      ),
      displayMath(
        String.raw`\begin{aligned}
\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^2
&= \frac12\,2\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^2
   \quad (\because \mathbb C\text{ の四則}) \\
&= \frac12\,0
   \quad (\because \text{直前の鎖}) \\
&= 0
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph([
        "(2) 反交換関係の第 2 式 ",
        math(String.raw`[\check\psi_\mu^\dagger, \check\psi_\nu]_+ = \delta_{\nu,\,M_{\mathrm{col}}+1-\mu}\,I`),
        " において ",
        math(String.raw`\nu = M_{\mathrm{col}}+1-\mu`),
        " と取る。このとき ",
        math(String.raw`\delta_{M_{\mathrm{col}}+1-\mu,\,M_{\mathrm{col}}+1-\mu} = 1`),
        " なので（",
        math(String.raw`\check{\mathcal{M}}`),
        " へ絞ったので合同式の計算が要らない）、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger
&=\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}
 +\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger\right)
 -\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \mathbb C\text{ の四則}) \\
&= I-\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式。}\blkref{anticommutator_of_check_psi}) \\
&= I-\check n_\mu
   \quad (\because \check{n}_\mu\ \text{の定義。}\blkref{def_check_number_operator})
\end{aligned}`,
      ),
      paragraph(["(3) (1)(2) を使って"]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu^2
&= \left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \quad (\because \check{n}_\mu\ \text{の定義。}\blkref{def_check_number_operator}) \\
&= \check\psi_\mu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\check\psi_\mu^\dagger\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{行列の積の結合法則}) \\
&= \check\psi_\mu^\dagger\left(I - \check{n}_\mu\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{(2)}) \\
&= \check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}
   - \check\psi_\mu^\dagger\,\check{n}_\mu\,\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{行列の積の分配法則}) \\
&= \check{n}_\mu
   - \check\psi_\mu^\dagger\left(\check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \check{n}_\mu = \check\psi_\mu^\dagger\check\psi_{M_{\mathrm{col}}+1-\mu}\text{。}\blkref{def_check_number_operator}) \\
&= \check{n}_\mu
   - \left(\check\psi_\mu^\dagger\right)^2\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\right)^2
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
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 5 },
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
\qquad \check\psi_{M_{\mathrm{col}}+1-\mu}\,\check{n}_\nu = \check{n}_\nu\,\check\psi_{M_{\mathrm{col}}+1-\mu}`),
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
        math(String.raw`M_{\mathrm{col}}+1-\mu, M_{\mathrm{col}}+1-\nu \in \check{\mathcal{M}}`),
        " なので、",
        ref("anticommutator_of_check_psi"),
        " を ",
        math(String.raw`(\mu,\nu)`),
        "、",
        math(String.raw`(\mu,M_{\mathrm{col}}+1-\nu)`),
        "、",
        math(String.raw`(\nu,M_{\mathrm{col}}+1-\mu)`),
        "、",
        math(String.raw`(M_{\mathrm{col}}+1-\mu,M_{\mathrm{col}}+1-\nu)`),
        " の 4 通りに適用できる。まず対の条件を見る：",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}
&= \delta_{\mu,\,\nu}
   \quad (\because M_{\mathrm{col}}+1-\nu = M_{\mathrm{col}}+1-\mu \iff \mu = \nu) \\
&= 0
   \quad (\because \mu \neq \nu)
\end{aligned}`,
      ),
      paragraph([
        "である（添字を ",
        math(String.raw`\check{\mathcal{M}}`),
        " に絞ってあるので、合同式を経由せずこの等号で済む。",
        ref("def_check_index_set"),
        " (5)）。したがって",
      ]),
      displayMath(
        String.raw`\begin{aligned}
{\left[\check\psi_\mu^\dagger, \check\psi_\nu^\dagger\right]_+} &= 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 1 式。}\blkref{anticommutator_of_check_psi}), \\
{\left[\check\psi_\mu^\dagger, \check\psi_{M_{\mathrm{col}}+1-\nu}\right]_+}
  &= \delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\,I
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式。}\blkref{anticommutator_of_check_psi}) \\
  &= 0
   \quad (\because \text{直前の }\delta\text{ の計算 }\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}=0), \\
{\left[\check\psi_{M_{\mathrm{col}}+1-\mu}, \check\psi_\nu^\dagger\right]_+}
  &= \delta_{M_{\mathrm{col}}+1-\mu,\,M_{\mathrm{col}}+1-\nu}\,I
   \quad (\because \text{$\check\psi$ の反交換関係の第 2 式を添字 } (\nu, M_{\mathrm{col}}+1-\mu) \text{ へ適用し、}
     \text{反交換子が引数の順序に依らないこと } [X,W]_+ = XW + WX = [W,X]_+\text{。}\blkref{anticommutator_of_check_psi}) \\
  &= 0
   \quad (\because \text{直前の }\delta\text{ の計算と }\delta_{M_{\mathrm{col}}+1-\mu,\,M_{\mathrm{col}}+1-\nu}=\delta_{M_{\mathrm{col}}+1-\nu,\,M_{\mathrm{col}}+1-\mu}\text{（対の条件の対称性）}), \\
{\left[\check\psi_{M_{\mathrm{col}}+1-\mu}, \check\psi_{M_{\mathrm{col}}+1-\nu}\right]_+} &= 0
   \quad (\because \text{$\check\psi$ の反交換関係の第 3 式。}\blkref{anticommutator_of_check_psi})
\end{aligned}`,
      ),
      paragraph([
        "すなわち、",
        math(String.raw`A \in \{\check\psi_\mu^\dagger, \check\psi_{M_{\mathrm{col}}+1-\mu}\}`),
        " と ",
        math(String.raw`B \in \{\check\psi_\nu^\dagger, \check\psi_{M_{\mathrm{col}}+1-\nu}\}`),
        " のどの組み合わせでも ",
        math(String.raw`AB = -BA`),
        " が成り立つ。",
      ]),
      paragraph([
        "Step 2（(1) の証明）。",
        math(String.raw`A \in \{\check\psi_\mu^\dagger, \check\psi_{M_{\mathrm{col}}+1-\mu}\}`),
        " を取ると、",
        math(String.raw`\check{n}_\nu`),
        " の定義（",
        ref("def_check_number_operator"),
        "）を開き、Step 1 を 2 回使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
A\,\check{n}_\nu
&= A\,\check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \check{n}_\nu\ \text{の定義}) \\
&= \left(-\check\psi_\nu^\dagger A\right)\check\psi_{M_{\mathrm{col}}+1-\nu}
   \quad (\because \text{Step 1 の } A\check\psi_\nu^\dagger = -\check\psi_\nu^\dagger A) \\
&= -\check\psi_\nu^\dagger\left(A\,\check\psi_{M_{\mathrm{col}}+1-\nu}\right)
   \quad (\because \text{結合法則}) \\
&= -\check\psi_\nu^\dagger\left(-\check\psi_{M_{\mathrm{col}}+1-\nu}A\right)
   \quad (\because \text{Step 1 の } A\check\psi_{M_{\mathrm{col}}+1-\nu} = -\check\psi_{M_{\mathrm{col}}+1-\nu}A) \\
&= \check\psi_\nu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\nu}\,A
   \quad (\because (-1)^2 = 1) \\
&= \check{n}_\nu\,A
   \quad (\because \check{n}_\nu\ \text{の定義})
\end{aligned}`,
      ),
      paragraph([
        "符号は ",
        math(String.raw`(-1)^2 = 1`),
        " となって消える。",
        math(String.raw`A = \check\psi_\mu^\dagger`),
        " と ",
        math(String.raw`A = \check\psi_{M_{\mathrm{col}}+1-\mu}`),
        " の両方でこれが成り立つ。",
      ]),
      paragraph([
        "Step 3（(2) の証明）。",
        math(String.raw`\check{n}_\mu, \check{n}_\nu`),
        " の定義（",
        ref("def_check_number_operator"),
        "）を開き、(1) を 2 回使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{n}_\mu \check{n}_\nu
&= \left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}\right)\check{n}_\nu
   \quad (\because \check{n}_\mu\ \text{の定義}) \\
&= \check\psi_\mu^\dagger\left(\check\psi_{M_{\mathrm{col}}+1-\mu}\,\check{n}_\nu\right)
   \quad (\because \text{結合法則}) \\
&= \check\psi_\mu^\dagger\left(\check{n}_\nu\,\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \quad (\because \text{(1) を } A = \check\psi_{M_{\mathrm{col}}+1-\mu} \text{ に適用}) \\
&= \left(\check\psi_\mu^\dagger\,\check{n}_\nu\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{結合法則}) \\
&= \left(\check{n}_\nu\,\check\psi_\mu^\dagger\right)\check\psi_{M_{\mathrm{col}}+1-\mu}
   \quad (\because \text{(1) を } A = \check\psi_\mu^\dagger \text{ に適用}) \\
&= \check{n}_\nu\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu}\right)
   \quad (\because \text{結合法則}) \\
&= \check{n}_\nu \check{n}_\mu
   \quad (\because \check{n}_\mu\ \text{の定義})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の number_operators_commute の半整数運動量版。反交換子の対は ν = M+1−μ であり、添字を 𝓜̌ = {1,…,M} に絞ったので、消えることを確かめる δ は δ_{M+1−ν, M+1−μ} = δ_{μ,ν} = 0（μ ≠ ν）だけで済む。合同式の書き換えは要らない（def_check_index_set (5)）。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_01（M=2,3,4,5、μ ≠ ν の全組、残差 ≤ 1.3e-15）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenEigen_004_claim_trace_of_check_number_operator_product",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 6 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\right) = 2^{M_{\mathrm{col}}-k}
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
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
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
= 2^{M_{\mathrm{col}}-k}`,
      ),
      paragraph([
        "（",
        math(String.raw`k = 0`),
        " のときは空の積を ",
        math(String.raw`I`),
        " と読み、",
        math(String.raw`\mathrm{tr}(I) = 2^{M_{\mathrm{col}}}`),
        " である。）とくに ",
        math(String.raw`e_1 = \cdots = e_k = 1`),
        " と取れば ",
        math(String.raw`\mathrm{tr}\!\left(\check{n}_{\mu_1}\cdots\check{n}_{\mu_k}\right) = 2^{M_{\mathrm{col}}-k}`),
        " であり、",
        math(String.raw`\mathrm{tr}(\check{n}_\mu) = 2^{M_{\mathrm{col}}-1}`),
        "、",
        math(String.raw`k = M_{\mathrm{col}}`),
        " のとき ",
        math(String.raw`\mathrm{tr}(\check{n}_1\cdots\check{n}_{M_{\mathrm{col}}}) = 1`),
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
        math(String.raw`k = M_{\mathrm{col}}`),
        " の場合）。",
      ]),
    ],
    proof: [
      paragraph([
        math(String.raw`\check{n}_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " であり ",
        math(String.raw`I`),
        " は ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 次の単位行列なので、",
        ref("trace_basic_properties"),
        " (3) より ",
        math(String.raw`\mathrm{tr}(I) = 2^{M_{\mathrm{col}}}`),
        " である（トレースは ",
        ref("def_trace"),
        "）。",
        math(String.raw`k`),
        " に関する帰納法で示す。",
      ]),
      paragraph([
        "基底段階（",
        math(String.raw`k = 0`),
        "）では、空の積が単位行列であることから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}(I)
&= 2^{M_{\mathrm{col}}}
   \quad (\because \text{トレースの基本性質 (3)。}\blkref{trace_basic_properties}) \\
&= 2^{M_{\mathrm{col}}-0}
   \quad (\because \mathbb C\text{ の四則})
\end{aligned}`,
      ),
      paragraph(["したがって主張が成立する。"]),
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
        math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu_1}`),
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
        " の第 2 式は ", math(String.raw`\check\psi_{M_{\mathrm{col}}+1-\mu_1}\check\psi_{\mu_1}^{\dagger}=I-\check n_{\mu_1}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{n}_{\mu_1}P\right)
&= \mathrm{tr}\!\left(\check\psi_{\mu_1}^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu_1}\,P\right)
   \quad (\because \check{n}_{\mu_1}\ \text{の定義。}\blkref{def_check_number_operator}) \\
&= \mathrm{tr}\!\left(\check\psi_{M_{\mathrm{col}}+1-\mu_1}\,P\,\check\psi_{\mu_1}^\dagger\right)
   \quad (\because \text{トレースの巡回性を } A = \check\psi_{\mu_1}^\dagger,\
       B = \check\psi_{M_{\mathrm{col}}+1-\mu_1}P \text{ に適用。}\blkref{trace_basic_properties}) \\
&= \mathrm{tr}\!\left(P\,\check\psi_{M_{\mathrm{col}}+1-\mu_1}\,\check\psi_{\mu_1}^\dagger\right)
   \quad (\because \check\psi_{M_{\mathrm{col}}+1-\mu_1} \text{ と } P \text{ の可換性（上で確認）}) \\
&= \mathrm{tr}\!\left(P\left(I - \check{n}_{\mu_1}\right)\right)
   \quad (\because \check{n}_{\mu_1}\ \text{の冪等性の第 2 式。}\blkref{check_number_operator_idempotent}) \\
&= \mathrm{tr}(P) - \mathrm{tr}\!\left(P\,\check{n}_{\mu_1}\right)
   \quad (\because \text{分配則とトレースの線型性。}\blkref{trace_basic_properties}) \\
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
        "帰納法の仮定から ",
        math(String.raw`\mathrm{tr}(P) = 2^{M_{\mathrm{col}}-(k-1)}`),
        " なので、いずれの場合も",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(R_{\mu_1}^{(e_1)}\cdots R_{\mu_k}^{(e_k)}\right)
&= \frac{1}{2}\,\mathrm{tr}(P)
   \quad (\because \text{直前の二場合}) \\
&= \frac{1}{2}\cdot 2^{M_{\mathrm{col}}-k+1}
   \quad (\because \text{帰納法の仮定}) \\
&= 2^{M_{\mathrm{col}}-k}
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
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 7 },
    title: { tex: String.raw`\check{n}_\mu \text{ の同時固有空間分解（各空間は 1 次元）}` },
    labels: ["check_joint_eigenspace_decomposition"],
    statement: [
      paragraph([
        math(String.raw`\epsilon = (\epsilon_\mu)_{\mu=1}^{M_{\mathrm{col}}} \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check{Q}_\epsilon := \prod_{\mu=1}^{M_{\mathrm{col}}}
\Bigl(\epsilon_\mu\,\check{n}_\mu + (1-\epsilon_\mu)\left(I - \check{n}_\mu\right)\Bigr)
\ \in\ \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`,
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
          math(String.raw`\text{(5)}\quad \mathbb{C}^{2^{M_{\mathrm{col}}}}
= \bigoplus_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \mathrm{im}\,\check{Q}_\epsilon`),
        ],
      ]),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " は ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個の ",
        math(String.raw`1`),
        " 次元部分空間の直和に分解される。",
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
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M_{\mathrm{col}}} R_\mu^{(\epsilon_\mu)}`),
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
   \quad (\because \check{n}_\mu\ \text{の冪等性 (3)}) \\
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
   \quad (\because \check{n}_\mu\ \text{の冪等性 (3)}) \\
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
   \quad (\because \check{n}_\mu\ \text{の冪等性 (3)}) \\
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
   \quad (\because \check{n}_\mu\ \text{の冪等性 (3)}) \\
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
&=\left(\prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}\right)
  \left(\prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}\right)
  \quad (\because \check{Q}_\epsilon\text{ の定義}) \\
&=\prod_{\mu=1}^{M_{\mathrm{col}}}\left(R_\mu^{(\epsilon_\mu)}R_\mu^{(\epsilon_\mu)}\right)
  \quad (\because \text{異なる添字の因子の可換性}) \\
&=\prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}
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
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \prod_{\mu=1}^{M_{\mathrm{col}}} R_\mu^{(\epsilon_\mu)}
   \quad (\because \check{Q}_\epsilon \text{ の定義（冒頭）}) \\
&= \prod_{\mu=1}^{M_{\mathrm{col}}}\left(R_\mu^{(1)} + R_\mu^{(0)}\right)
   \quad (\because \text{可換な有限個の因子の積の分配法則による展開}) \\
&= \prod_{\mu=1}^{M_{\mathrm{col}}} I
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
        math(String.raw`2^{M_{\mathrm{col}}}`),
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
&=\check{n}_\nu\prod_{\mu=1}^{M_{\mathrm{col}}}R_\mu^{(\epsilon_\mu)}
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
  \quad (\because \check{n}_\nu\ \text{の冪等性 (3)}) \\
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
  \quad (\because \check{n}_\nu\ \text{の冪等性 (3)}) \\
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
        math(String.raw`\check{Q}_\epsilon = \prod_{\mu=1}^{M_{\mathrm{col}}} R_\mu^{(\epsilon_\mu)}`),
        " は、相異なる ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の添字 ",
        math(String.raw`1,\dots,M_{\mathrm{col}} \in \check{\mathcal{M}}`),
        " についての ",
        math(String.raw`R_\mu^{(e)}`),
        " の積そのものなので、",
        ref("trace_of_check_number_operator_product"),
        " を ",
        math(String.raw`k = M_{\mathrm{col}}`),
        "、",
        math(String.raw`(\mu_1,\dots,\mu_{M_{\mathrm{col}}}) = (1,\dots,M_{\mathrm{col}})`),
        "、",
        math(String.raw`(e_1,\dots,e_{M_{\mathrm{col}}}) = (\epsilon_1,\dots,\epsilon_{M_{\mathrm{col}}})`),
        " として適用でき、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\mathrm{tr}\!\left(\check{Q}_\epsilon\right)
&= 2^{M_{\mathrm{col}}-M_{\mathrm{col}}}
  \quad (\because \blkref{trace_of_check_number_operator_product}\ \text{（上の適用）}) \\
&= 2^{0}
  \quad (\because M_{\mathrm{col}}-M_{\mathrm{col}}=0) \\
&= 1
  \quad (\because \text{冪の零乗})
\end{aligned}`,
      ),
      paragraph([
        "を得る（",
        math(String.raw`\check{\mathcal{M}} = \{1,\dots,M_{\mathrm{col}}\}`),
        " の元をすべて使い切っているので指数が ",
        math(String.raw`0`),
        " になる）。",
      ]),
      paragraph([
        math(String.raw`\check{Q}_\epsilon`),
        " は Step 1 より冪等なので、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\dim_{\mathbb{C}}\mathrm{im}\,\check{Q}_\epsilon
&= \mathrm{tr}\!\left(\check{Q}_\epsilon\right)
  \quad (\because \text{冪等行列のトレースは像の次元（}\blkref{trace_of_idempotent}\text{）。}\check{Q}_\epsilon\text{ は Step 1 より冪等}) \\
&= 1
  \quad (\because \text{上で計算した } \mathrm{tr}(\check{Q}_\epsilon))
\end{aligned}`,
      ),
      paragraph([
        "Step 5（(5) の証明）。(2) より任意の ",
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
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
        math(String.raw`\left|\{0,1\}^{\check{\mathcal{M}}}\right| = 2^{M_{\mathrm{col}}}`),
        " 個の空間がそれぞれ ",
        math(String.raw`1`),
        " 次元で、合計 ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " となり ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " の次元に一致する。）",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の joint_eigenspace_decomposition の半整数運動量版。段階構造は同じで、添字集合 I が {1,…,M} に、m が M に、tr(Q_ε) = 2^{M−m} が 1 に置き換わる。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_02（M=2,3,4,5 の {0,1}^M を全列挙。tr(Q̌_ε) = 1 の残差 ≤ 1.1e-15、rank Q̌_ε = 1 を特異値で判定して違反 0 件）。",
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenEigen_006_claim_eigenvalues_of_check_Vprime",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 8 },
    title: { tex: String.raw`\check{V}' \text{ の固有値}` },
    labels: ["eigenvalues_of_check_Vprime"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check{g}(\epsilon) := \sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac{1}{2}\right) \in \mathbb{R}`,
      ),
      paragraph(["とおく（", ref("def_gamma_theta"), "）。このとき"]),
      displayMath(
        String.raw`\check{V}'\,\check{Q}_\epsilon = \check{Q}_\epsilon\,\check{V}'
= \exp(\check{g}(\epsilon))\,\check{Q}_\epsilon`,
      ),
      paragraph([
        "が成り立つ。すなわち ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " の各元は ",
        math(String.raw`\check{V}'`),
        " の固有値 ",
        math(String.raw`\exp(\check{g}(\epsilon))`),
        " の固有ベクトルであり、",
        ref("check_joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`\check{V}'`),
        " は対角化可能で、その固有値は重複度を込めて",
      ]),
      displayMath(
        String.raw`\left\{\,\exp(\check{g}(\epsilon)) \ \middle|\
\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\,\right\}
\qquad (\text{各 } \epsilon \text{ が重複度 } 1 \text{ を与え、総個数 } 2^{M_{\mathrm{col}}})`,
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
        math(String.raw`\gamma(\tilde\theta_{M_{\mathrm{col}}+1-\mu}) = \gamma(\tilde\theta_\mu)`),
        " なので、",
        math(String.raw`\epsilon`),
        " の成分を ",
        math(String.raw`\mu \leftrightarrow M_{\mathrm{col}}+1-\mu`),
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
        math(String.raw`\check{X} = \sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)
\left(\check{n}_\mu - \tfrac12 I\right)`),
        " に ",
        ref("check_joint_eigenspace_decomposition"),
        " (3) を代入して",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check{X}\check{Q}_\epsilon
&= \sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
   \left(\check{n}_\mu\check{Q}_\epsilon - \tfrac12 \check{Q}_\epsilon\right)
   \quad (\because \text{行列の積の分配法則}) \\
&= \sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
   \left(\epsilon_\mu\check{Q}_\epsilon - \tfrac12 \check{Q}_\epsilon\right)
   \quad (\because \text{同時固有空間分解 (3)}) \\
&= \left(\sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
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
&= \exp(\check{g}(\epsilon))\,\check{Q}_\epsilon
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
&= \exp(\check{g}(\epsilon))\check{Q}_\epsilon
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
&= \exp(\check{g}(\epsilon))\check{Q}_\epsilon y
   \quad (\because \text{Step 3}) \\
&= \exp(\check{g}(\epsilon)) y
   \quad (\because \text{上の等式 }\check{Q}_\epsilon y = y)
\end{aligned}`,
      ),
      paragraph([
        ref("check_joint_eigenspace_decomposition"),
        " (5) より ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " は ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " たちの直和だから、各 ",
        math(String.raw`\mathrm{im}\,\check{Q}_\epsilon`),
        " の基底（1 次元なので 1 本）を合わせると ",
        math(String.raw`\check{V}'`),
        " の固有ベクトルからなる ",
        math(String.raw`\mathbb{C}^{2^{M_{\mathrm{col}}}}`),
        " の基底が得られる。したがって ",
        math(String.raw`\check{V}'`),
        " は対角化可能で、固有値は ",
        math(String.raw`\exp(\check{g}(\epsilon))`),
        " が各 ",
        math(String.raw`\epsilon`),
        " について 1 つずつ現れるもので尽くされる（総個数 ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        "）。",
      ]),
      paragraph([
        math(String.raw`\check{g}(\epsilon) \in \mathbb{R}`),
        "（",
        ref("gamma_theta_tilde_mu_positive"),
        " より ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}_{>0}`),
        "）なので ",
        math(String.raw`\exp(\check{g}(\epsilon)) > 0`),
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
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 9 },
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
= \prod_{\mu=1}^{M_{\mathrm{col}}} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
\ \in\ \mathbb{R}_{>0}`,
      ),
      paragraph([
        "が成り立つ。",
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
&= \sum_{\epsilon} \exp(\check{g}(\epsilon))\,\mathrm{tr}\!\left(\check{Q}_\epsilon\right)
   \quad (\because \check{V}'\check{Q}_\epsilon = \exp(\check{g}(\epsilon))\check{Q}_\epsilon) \\
&= \sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \exp(\check{g}(\epsilon))
   \quad (\because \mathrm{tr}(\check{Q}_\epsilon) = 1)
\end{aligned}`,
      ),
      paragraph([
        "Step 2（積への分解）。",
        math(String.raw`\check{g}(\epsilon) = \sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)
\left(\epsilon_\mu - \tfrac12\right)`),
        " なので、実数の指数法則より",
      ]),
      displayMath(
        String.raw`\exp(\check{g}(\epsilon)) = \prod_{\mu=1}^{M_{\mathrm{col}}}
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
\sum_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \exp(\check{g}(\epsilon))
&= \prod_{\mu=1}^{M_{\mathrm{col}}}
   \left(\exp\!\left(-\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)
   + \exp\!\left(+\tfrac{\gamma(\tilde\theta_\mu)}{2}\right)\right)
   \quad (\because \text{直前の積表示と、有限個の因子の積の展開}) \\
&= \prod_{\mu=1}^{M_{\mathrm{col}}} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad \left(\because \cosh x = \frac{\exp(x) + \exp(-x)}{2}\right)
\end{aligned}`,
      ),
      paragraph([
        "Step 3（",
        math(String.raw`\left(\check{V}'\right)^{-1}`),
        " についても同じ値）。",
        math(String.raw`\left(\check{V}'\right)^{-1} = \exp(-\check{X})`),
        " であり、",
        math(String.raw`-\check{X} = \sum_{\mu=1}^{M_{\mathrm{col}}}\left(-\gamma(\tilde\theta_\mu)\right)
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
&= \prod_{\mu=1}^{M_{\mathrm{col}}} 2\cosh\!\left(\frac{-\gamma(\tilde\theta_\mu)}{2}\right)
   \quad (\because \text{Step 1--2 を }\gamma(\tilde\theta_\mu)\mapsto-\gamma(\tilde\theta_\mu)\text{ として適用}) \\
&= \prod_{\mu=1}^{M_{\mathrm{col}}} 2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
   \quad (\because \cosh\text{ は偶関数}) \\
&= \mathrm{tr}\!\left(\check{V}'\right)
   \quad (\because \text{Step 1--2 の }\check{V}'\text{ のトレース表示})
\end{aligned}`,
      ),
      paragraph([
        "Step 4（正値性）。",
        ref("gamma_theta_tilde_mu_positive"),
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
&=\prod_{\mu=1}^{M_{\mathrm{col}}}2\cosh\!\left(\frac{\gamma(\tilde\theta_\mu)}{2}\right)
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
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "evenEigen_008_claim_V_plus_is_positive_definite",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 10 },
    title: {
      tex: String.raw`V^{(+)} \text{ は正定値}`,
    },
    labels: ["V_plus_is_positive_definite"],
    statement: [
      paragraph([
        ref("iH_is_real_symmetric"),
        " の ",
        math(String.raw`S_1^{(+)} := iK_1H_1^{(+)}`),
        "、",
        math(String.raw`S_2 := iK_2^*H_2`),
        " について、",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} = \left(V_1^{(+)}\right)^{1/2}V_2\left(V_1^{(+)}\right)^{1/2}`),
        " は",
      ]),
      displayMath(
        String.raw`V^{(+)} = (2s_2)^{M_{\mathrm{col}}/2}\,
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
        " は正定値（",
        ref("def_hermitian_positive_definite"),
        " の意味）である。",
      ]),
    ],
    proof: [
      paragraph([
        "Step 1（表示）。二つの因子を順に書き直す（",
        ref("def_V_plus"),
        "、",
        ref("def_V1_plus_square_root"),
        "、",
        ref("V2_exponential_representation"),
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
&= (2s_2)^{M_{\mathrm{col}}/2}\exp\!\left(iK_2^*H_2\right)
   \quad (\because V_2 \text{ の表示}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp(S_2)
   \quad (\because S_2 = iK_2^*H_2)
\end{aligned}`,
      ),
      paragraph([
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}`),
        " はスカラーなので ",
        ref("scalar_identity_commutes"),
        " により前へ出せて statement の表示を得る。",
      ]),
      paragraph([
        "Step 2（各因子の性質）。",
        ref("iH_is_real_symmetric"),
        " より ",
        math(String.raw`S_1^{(+)}`),
        " は実対称、したがって ",
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
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`),
        " であり、同 (3) より ",
        math(String.raw`V^{(+)} = (2s_2)^{M_{\mathrm{col}}/2}B^*AB`),
        " も正定値である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の V_is_positive_definite の (+) セクター版。009 章の主張は V_eq_Vprime の V（why_008_applies_only_to_minus_sector で確定したとおり実質 (−) 専用）に結びついているので、V^{(+)} について改めて述べた。証明で使う iH_is_real_symmetric と exp_hermitian_is_positive_definite はどちらも複号によらない形で述べられているので、内容は旧複合ブロックの Step 1〜3 と同一である。Lean の対応定理は Ising2D.VPlus_posDef。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_05（S_1^{(+)}, S_2 の実対称性の残差 0.0、V^{(+)} のエルミート性の残差 ≤ 2.0e-12、固有値の全体最小 3.2e-4 > 0、M=2,3,4,5・6 組の (K_1,K_2)）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "evenEigen_claim_V_plus_is_invertible",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 10 },
    title: {
      tex: String.raw`V^{(+)} \text{ は可逆であり、左右逆は明示できる}`,
    },
    labels: ["V_plus_is_invertible"],
    statement: [
      paragraph([
        ref("V_plus_is_positive_definite"),
        " の表示に対して、次の行列を置く：",
      ]),
      displayMath(
        String.raw`R^{(+)} := (2s_2)^{-M_{\mathrm{col}}/2}\,
\exp\!\left(-\tfrac12 S_1^{(+)}\right)\exp(-S_2)
\exp\!\left(-\tfrac12 S_1^{(+)}\right)
\in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C}).`,
      ),
      paragraph(["このとき左右の積はそれぞれ"]),
      displayMath(
        String.raw`V^{(+)}R^{(+)}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})},
\qquad
R^{(+)}V^{(+)}=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`,
      ),
      paragraph(["である。したがって ", math(String.raw`V^{(+)}`), " は可逆であり、"]),
      displayMath(
        String.raw`\left(V^{(+)}\right)^{-1}=R^{(+)}
=(2s_2)^{-M_{\mathrm{col}}/2}\,
\exp\!\left(-\tfrac12 S_1^{(+)}\right)\exp(-S_2)
\exp\!\left(-\tfrac12 S_1^{(+)}\right).`,
      ),
    ],
    proof: [
      paragraph([
        "Step 1（指数行列どうしの左右逆）。",
        math(String.raw`E_+:=\exp(\tfrac12S_1^{(+)})`),
        "、",
        math(String.raw`E_-:=\exp(-\tfrac12S_1^{(+)})`),
        "、",
        math(String.raw`A_+:=\exp(S_2)`),
        "、",
        math(String.raw`A_-:=\exp(-S_2)`),
        " と置く。各指数の行列とその反数は可換するので、",
        ref("theorem_exp_product"),
        " と ",
        ref("theorem_exp_zero"),
        " を一行ずつ使うと、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
E_+E_-
&=\exp\!\left(\tfrac12S_1^{(+)}-\tfrac12S_1^{(+)}\right)
&&\left(\because\ \blkref{theorem_exp_product}\right)\\
&=\exp(O)
&&\left(\because\ \tfrac12S_1^{(+)}-\tfrac12S_1^{(+)}=O\right)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\left(\because\ \blkref{theorem_exp_zero}\right),\\[2mm]
E_-E_+
&=\exp\!\left(-\tfrac12S_1^{(+)}+\tfrac12S_1^{(+)}\right)
&&\left(\because\ \blkref{theorem_exp_product}\right)\\
&=\exp(O)
&&\left(\because\ -\tfrac12S_1^{(+)}+\tfrac12S_1^{(+)}=O\right)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\left(\because\ \blkref{theorem_exp_zero}\right),\\[2mm]
A_+A_-
&=\exp(S_2-S_2)
&&\left(\because\ \blkref{theorem_exp_product}\right)\\
&=\exp(O)
&&(\because\ S_2-S_2=O)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\left(\because\ \blkref{theorem_exp_zero}\right),\\[2mm]
A_-A_+
&=\exp(-S_2+S_2)
&&\left(\because\ \blkref{theorem_exp_product}\right)\\
&=\exp(O)
&&(\because\ -S_2+S_2=O)\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&\left(\because\ \blkref{theorem_exp_zero}\right).
\end{aligned}`,
      ),
      paragraph([
        "Step 2（右側の候補を掛ける）。",
        math(String.raw`a:=(2s_2)^{M_{\mathrm{col}}/2}`),
        " と置く。",
        math(String.raw`s_2>0`),
        " なので ",
        math(String.raw`a>0`),
        " であり、正の実数の冪の指数法則から ",
        math(String.raw`a^{-1}=(2s_2)^{-M_{\mathrm{col}}/2}`),
        " である。スカラー倍した単位行列は全行列と可換する（",
        ref("scalar_identity_commutes"),
        "）ので、結合法則と Step 1 を使って",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}R^{(+)}
&=(aE_+A_+E_+)(a^{-1}E_-A_-E_-)
&&(\because\ V^{(+)}\text{ と }R^{(+)}\text{ の表示})\\
&=aa^{-1}E_+A_+E_+E_-A_-E_-
&&\left(\because\ \blkref{scalar_identity_commutes}\ \text{とスカラー倍の結合法則}\right)\\
&=E_+A_+E_+E_-A_-E_-
&&(\because\ aa^{-1}=1)\\
&=E_+A_+(E_+E_-)A_-E_-
&&(\because\ \text{行列積の結合法則})\\
&=E_+A_+IA_-E_-
&&(\because\ \text{Step 1 の第一の左右逆})\\
&=E_+A_+A_-E_-
&&(\because\ \text{単位行列})\\
&=E_+(A_+A_-)E_-
&&(\because\ \text{行列積の結合法則})\\
&=E_+IE_-
&&(\because\ \text{Step 1 の第三の左右逆})\\
&=E_+E_-
&&(\because\ \text{単位行列})\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{Step 1 の第一の左右逆}).
\end{aligned}`,
      ),
      paragraph(["Step 3（左側の候補を掛ける）。Step 1 の残る二つの左右逆を使うと"]),
      displayMath(
        String.raw`\begin{aligned}
R^{(+)}V^{(+)}
&=(a^{-1}E_-A_-E_-)(aE_+A_+E_+)
&&(\because\ R^{(+)}\text{ と }V^{(+)}\text{ の表示})\\
&=a^{-1}aE_-A_-E_-E_+A_+E_+
&&\left(\because\ \blkref{scalar_identity_commutes}\ \text{とスカラー倍の結合法則}\right)\\
&=E_-A_-E_-E_+A_+E_+
&&(\because\ a^{-1}a=1)\\
&=E_-A_-(E_-E_+)A_+E_+
&&(\because\ \text{行列積の結合法則})\\
&=E_-A_-IA_+E_+
&&(\because\ \text{Step 1 の第二の左右逆})\\
&=E_-A_-A_+E_+
&&(\because\ \text{単位行列})\\
&=E_-(A_-A_+)E_+
&&(\because\ \text{行列積の結合法則})\\
&=E_-IE_+
&&(\because\ \text{Step 1 の第四の左右逆})\\
&=E_-E_+
&&(\because\ \text{単位行列})\\
&=I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}
&&(\because\ \text{Step 1 の第二の左右逆}).
\end{aligned}`,
      ),
      paragraph([
        "したがって ",
        math(String.raw`R^{(+)}`),
        " は ",
        math(String.raw`V^{(+)}`),
        " の右逆かつ左逆であり、statement の逆行列の明示式を得る。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧 V_plus_is_positive_definite の Step 4 前半を、左右の積をそれぞれ省略せず計算する独立した主張へ分けた。Lean の対応定理は Ising2D.VPlus_mul_VPlusInv と Ising2D.VPlusInv_mul_VPlus。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_07_V_plus_mul_inverse.sage と check_08_inverse_mul_V_plus.sage。候補逆行列を因子の逆順積から構成し、左右の積を別ファイルで I と比較する。",
      ],
    },
  },
  {
    id: "evenEigen_claim_trace_V_plus_is_positive",
    kind: "claim",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 10 },
    title: {
      tex: String.raw`\mathrm{tr}\!\left(V^{(+)}\right)\text{ は正}`,
    },
    labels: ["trace_V_plus_is_positive"],
    statement: [
      displayMath(String.raw`\mathrm{tr}\!\left(V^{(+)}\right) \in \mathbb{R}_{>0}.`),
    ],
    proof: [
      paragraph([
        ref("V_plus_is_positive_definite"),
        " と ",
        ref("exp_hermitian_is_positive_definite"),
        " (4) より ",
        math(String.raw`\mathrm{tr}(V^{(+)})>0`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "旧 V_plus_inverse_positive_and_trace_positivity の Step 2 から、V^{(+)} 自身のトレース正値性だけを一主張として分離した。Lean の対応定理は Ising2D.trace_VPlus_pos。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_05_positive_definite_and_c.sage のトレース最小値による正値性検査。",
      ],
    },
  },
  {
    id: "evenEigen_009_claim_constant_c_value_even_sector",
    kind: "claim",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 11 },
    title: { tex: String.raw`c = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}` },
    labels: ["constant_c_value_even_sector"],
    statement: [
      paragraph([
        ref("V_plus_eq_c_check_Vprime"),
        " の定数 ",
        math(String.raw`c \in \mathbb{C}^\times`),
        " は",
      ]),
      displayMath(
        String.raw`c = (2\sinh 2K_2)^{M_{\mathrm{col}}/2} = (2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`,
      ),
      paragraph(["である。すなわち"]),
      displayMath(String.raw`V^{(+)} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\,\check{V}'`),
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
&= (2s_2)^{M_{\mathrm{col}}/2}\,\mathrm{tr}\!\left(
   \exp\!\left(\tfrac12 S_1\right)\exp(S_2)\exp\!\left(\tfrac12 S_1\right)\right)
   \quad (\because \text{トレースの線型性}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\,\mathrm{tr}\!\left(
   \exp\!\left(\tfrac12 S_1\right)\exp\!\left(\tfrac12 S_1\right)\exp(S_2)\right)
   \quad \left(\because \text{巡回性を } A = \exp\!\left(\tfrac12 S_1\right)\exp(S_2),\
   B = \exp\!\left(\tfrac12 S_1\right) \text{ に適用}\right) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\,\mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right)
   \quad \left(\because \text{可換なので } \exp\!\left(\tfrac12 S_1\right)^2 = \exp(S_1)\right) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\,\tau
   \quad (\because \tau := \mathrm{tr}\!\left(\exp(S_1)\exp(S_2)\right))
\end{aligned}`,
      ),
      paragraph([
        "同じ計算を ",
        ref("V_plus_is_invertible"),
        " の ",
        math(String.raw`\left(V^{(+)}\right)^{-1}`),
        " の表示に適用して",
      ]),
      displayMath(
        String.raw`\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)
= (2s_2)^{-M_{\mathrm{col}}/2}\,\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right)`,
      ),
      paragraph([
        "Step 2（",
        math(String.raw`\mathrm{tr}\!\left(\exp(-S_1)\exp(-S_2)\right) = \tau`),
        "）。",
        ref("sign_flip_conjugation"),
        " の ",
        math(String.raw`U`),
        " は ",
        math(String.raw`US_1^{(+)}U^{-1} = -S_1^{(+)}`),
        "、",
        math(String.raw`US_2U^{-1} = -S_2`),
        " を与えるので、",
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
\qquad \left(S \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})\right)`,
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
        ref("trace_V_plus_is_positive"),
        " より ",
        math(String.raw`\mathrm{tr}\!\left(V^{(+)}\right) > 0`),
        " なので ",
        math(String.raw`\tau = (2s_2)^{-M_{\mathrm{col}}/2}\mathrm{tr}\!\left(V^{(+)}\right) \neq 0`),
        "）",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\frac{\mathrm{tr}\!\left(V^{(+)}\right)}
{\mathrm{tr}\!\left(\left(V^{(+)}\right)^{-1}\right)}
&= \frac{(2s_2)^{M_{\mathrm{col}}/2}\,\tau}{(2s_2)^{-M_{\mathrm{col}}/2}\,\tau}
   \quad (\because \text{Step 1・Step 2}) \\
&= (2s_2)^{M_{\mathrm{col}}}
   \quad (\because \tau\neq0\text{ と }\mathbb{C}\text{ の四則})
\end{aligned}`,
      ),
      paragraph(["よって ", math(String.raw`c^2 = (2s_2)^{M_{\mathrm{col}}}`), "。"]),
      paragraph([
        "Step 4（符号の確定）。Step 3 の第 1 式より ",
        math(String.raw`c = \mathrm{tr}\!\left(V^{(+)}\right)/\mathrm{tr}\!\left(\check{V}'\right)`),
        " であり、",
        ref("trace_V_plus_is_positive"),
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
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} \in \mathbb{R}_{>0}`),
        " である。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
c^2 &= (2s_2)^{M_{\mathrm{col}}}
   \quad (\because \text{Step 3}) \\
&= \left((2s_2)^{M_{\mathrm{col}}/2}\right)^2
   \quad (\because \text{正の実数の冪の指数法則 } \left(a^{M_{\mathrm{col}}/2}\right)^2 = a^{M_{\mathrm{col}}})
\end{aligned}`,
      ),
      paragraph(["と合わせると"]),
      displayMath(
        String.raw`\left(c - (2s_2)^{M_{\mathrm{col}}/2}\right)\left(c + (2s_2)^{M_{\mathrm{col}}/2}\right) = 0`,
      ),
      paragraph([
        math(String.raw`c > 0`),
        " かつ ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} > 0`),
        " より第 2 因子は正で ",
        math(String.raw`0`),
        " でない。",
        math(String.raw`\mathbb{C}`),
        " は体（",
        ref("complex_numbers_form_a_field"),
        "）ゆえ零因子を持たないから第 1 因子が ",
        math(String.raw`0`),
        " であり、",
        math(String.raw`c = (2s_2)^{M_{\mathrm{col}}/2}`),
        "。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の constant_c_value の (+) セクター版。行列式は使わず、tr(V)/tr(V^{-1}) = c^2 と符号反転共役 U、および正定値性からの符号確定という同じ筋で通る。009 章の証明は S_1^{(-)} で書かれているが、iH_is_real_symmetric と sign_flip_conjugation はどちらも S_1^{(±)} について複号同順で述べられているので、上の符号を取るだけで (+) 側に使える。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_05（U S_1^{(+)} U^{-1} = −S_1^{(+)} の残差 0.0、tr(exp(−S_1)exp(−S_2)) = τ の相対差 ≤ 6.1e-16、tr(V^{(+)})/tr((V^{(+)})^{-1}) = (2s_2)^M の相対差 ≤ 6.6e-16、c = (2 sinh 2K_2)^{M/2} の相対差 ≤ 4.3e-15）。",
        "2026-09-26: (−) セクターを本文から外し、(+) セクターだけで述べる形にした。",
      ],
    },
  },
  {
    id: "evenEigen_010_theorem_eigenvalues_of_V_plus",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 12 },
    title: { tex: String.raw`V^{(+)} \text{ の固有値}` },
    labels: ["eigenvalues_of_V_plus"],
    statement: [
      paragraph([
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対して",
      ]),
      displayMath(
        String.raw`\check\Lambda_\epsilon := (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)
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
          math(String.raw`2^{M_{\mathrm{col}}}`),
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
        String.raw`\check\Lambda_{\max} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)\right),
\qquad
\check\Lambda_{\min} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(-\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}} \gamma(\tilde\theta_\mu)\right)`,
      ),
      paragraph([
        "（したがって ",
        math(String.raw`\check\Lambda_{\max}\check\Lambda_{\min} = (2\sinh 2K_2)^{M_{\mathrm{col}}} = c^2`),
        "。）",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("constant_c_value_even_sector"),
        " より ",
        math(String.raw`V^{(+)} = (2s_2)^{M_{\mathrm{col}}/2}\check{V}'`),
        " であり、",
        ref("eigenvalues_of_check_Vprime"),
        " より ",
        math(String.raw`\check{V}'\check{Q}_\epsilon = \exp(\check{g}(\epsilon))\check{Q}_\epsilon`),
        " だから",
      ]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}\check{Q}_\epsilon
&= (2s_2)^{M_{\mathrm{col}}/2}\check{V}'\check{Q}_\epsilon
   \quad (\because \text{定数 }c\text{ の決定}) \\
&= (2s_2)^{M_{\mathrm{col}}/2}\exp(\check{g}(\epsilon))\check{Q}_\epsilon
   \quad (\because \check{V}'\text{ の固有値}) \\
&= \check\Lambda_\epsilon\check{Q}_\epsilon
   \quad (\because \check\Lambda_\epsilon\text{ の定義})
\end{aligned}`,
      ),
      paragraph([
        "同じ式変形を ",
        ref("eigenvalues_of_check_Vprime"),
        " の Step 3' の ",
        math(String.raw`\check{Q}_\epsilon\check{V}' = \exp(\check{g}(\epsilon))\check{Q}_\epsilon`),
        " に対して行い（スカラー ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}`),
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
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2} > 0`),
        " と ",
        math(String.raw`\exp(\check{g}(\epsilon)) > 0`),
        " より ",
        math(String.raw`\check\Lambda_\epsilon > 0`),
        "。",
      ]),
      paragraph([
        "大小の比較。",
        math(String.raw`\check\Lambda_\epsilon = (2s_2)^{M_{\mathrm{col}}/2}\exp(\check{g}(\epsilon))`),
        " で ",
        math(String.raw`(2s_2)^{M_{\mathrm{col}}/2}`),
        " は ",
        math(String.raw`\epsilon`),
        " に依らない正の定数、",
        math(String.raw`t \mapsto \exp(t)`),
        " は実数上の狭義単調増加関数なので、",
        math(String.raw`\check\Lambda_\epsilon`),
        " の大小は ",
        math(String.raw`\check{g}(\epsilon)
= \sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\left(\epsilon_\mu - \tfrac12\right)`),
        " の大小と一致する。",
        ref("gamma_theta_tilde_mu_positive"),
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
        String.raw`\check{g}(1,\dots,1) = \frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu),
\qquad
\check{g}(0,\dots,0) = -\frac{1}{2}\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)`,
      ),
      paragraph([
        "を代入して statement の ",
        math(String.raw`\check\Lambda_{\max}, \check\Lambda_{\min}`),
        " を得る。さらに",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\Lambda_{\max}\check\Lambda_{\min}
&= (2s_2)^{M_{\mathrm{col}}}
   \quad (\because \text{指数部分が互いに打ち消し合う}) \\
&= c^2
   \quad (\because \text{定数 }c\text{ の決定。}\blkref{constant_c_value_even_sector})
\end{aligned}`,
      ),
    ],
    conversion: {
      status: "added",
      notes: [
        "009 章の eigenvalues_of_V の (+) セクター版。重複度が 2^{M-m} から 1 に、和の範囲が I から {1,…,M} に変わる。γ(θ~_μ) > 0 が狭義なので、大小比較も狭義になる（009 章では ≥ しか言えなかった）。",
        "式変形の書き方の統一（2026-09-04）。式変形の直後に置いていた「第 2 行で用いた」の参照を、定数 c の決定を使う行末の (∵ …) の blkref へ移した。内容・式変形・根拠・参照は変えていない。",
        "数値検証: sagemath/check/050_claim_even_sector_eigenvalues/check_06（M=2,3,4,5・6 組の (K_1,K_2) で、V^{(+)} の 2^M 個の固有値全体が {Λ̌_ε} と相対誤差 9.0e-12 以下で一致。V^{(+)} は行列指数関数から直接構成しており、証明の経路とは独立）。",
      ],
    },
  },
  {
    id: "evenEigen_011_theorem_max_eigenvalue_of_V_plus_simple",
    kind: "theorem",
    standing: "mainTheorem",
    origin: { path: "structured-latex/content/017_even_sector_eigenvalues.ts", ordinal: 13 },
    title: {
      tex: String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}} \text{ であり単純固有値}`,
    },
    labels: ["max_eigenvalue_of_V_plus_simple"],
    statement: [
      paragraph([
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(\delta)}_{M_{\mathrm{col}}}`),
        " について、次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad \check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
          "。すなわち ",
          math(String.raw`V^{(+)}`),
          " の最大固有値は ",
          math(String.raw`\delta = \tfrac12`),
          "に対応する。",
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
          math(String.raw`\left\{x \in \mathbb{C}^{2^{M_{\mathrm{col}}}} \mid V^{(+)}x
= \check\Lambda_{\max}x\right\}
= \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
          " であり、この空間の次元は ",
          math(String.raw`1`),
          " である。",
        ],
      ]),
      paragraph([
        "単純性は、",
        ref("gamma_theta_tilde_mu_positive"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) > 0`),
        " が**すべての ",
        math(String.raw`\mu`),
        "、すべての ",
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "（臨界点を含む）で**成り立つことから従う。",
      ]),
    ],
    proof: [
      paragraph([
        "(1) ",
        ref("def_Theta_delta_M"),
        " と ",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\delta = \tfrac12`),
        " の場合の定義は",
      ]),
      displayMath(
        String.raw`\Theta_{M_{\mathrm{col}}}^{(1/2)} = \left\{\left.\frac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}
\ \right|\ \mu = 1,\dots,M_{\mathrm{col}}\right\},
\qquad
\Lambda^{(1/2)}_{M_{\mathrm{col}}} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}
\exp\!\left(\frac{1}{2}\sum_{\theta \in \Theta_{M_{\mathrm{col}}}^{(1/2)}}\gamma(\theta)\right)`,
      ),
      paragraph([
        "である。",
        ref("antiperiodic_exp_sum"),
        " の ",
        math(String.raw`\tilde\theta_\mu = \dfrac{2\pi\left(\mu-\frac12\right)}{M_{\mathrm{col}}}`),
        " より ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(1/2)} = \left\{\tilde\theta_\mu \mid \mu = 1,\dots,M_{\mathrm{col}}\right\}`),
        " である。",
      ]),
      paragraph([
        "この ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の値は互いに相異なる。実際 ",
        math(String.raw`\mu, \nu \in \check{\mathcal{M}}`),
        "、",
        math(String.raw`\mu \neq \nu`),
        " なら ",
        math(String.raw`\tilde\theta_\mu - \tilde\theta_\nu = \dfrac{2\pi(\mu-\nu)}{M_{\mathrm{col}}}`),
        " で ",
        math(String.raw`1 \leq |\mu-\nu| \leq M_{\mathrm{col}}-1`),
        " だから ",
        math(String.raw`0 < \left|\tilde\theta_\mu - \tilde\theta_\nu\right| < 2\pi`),
        " であり、とくに ",
        math(String.raw`\tilde\theta_\mu \neq \tilde\theta_\nu`),
        "。よって集合 ",
        math(String.raw`\Theta_{M_{\mathrm{col}}}^{(1/2)}`),
        " はちょうど ",
        math(String.raw`M_{\mathrm{col}}`),
        " 個の元をもち、",
      ]),
      displayMath(
        String.raw`\sum_{\theta \in \Theta_{M_{\mathrm{col}}}^{(1/2)}}\gamma(\theta)
= \sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)`,
      ),
      paragraph([
        "である。ここで左辺の ",
        math(String.raw`\gamma`),
        " は ",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\theta) = \mathrm{arccosh}\left(\gamma_1(\theta)\right)`),
        "（",
        math(String.raw`\gamma_1(\theta) = c_1c_2^* - s_1s_2^*\cos\theta`),
        " は ",
        ref("def_gamma1_gamma2_of_theta"),
        "）であり、右辺の ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " は同じ ",
        math(String.raw`\gamma`),
        " の ",
        math(String.raw`\theta = \tilde\theta_\mu`),
        " での値である（",
        ref("def_gamma_theta"),
        "）。したがって ",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_{\max}`),
        " の表式と比べて ",
        math(String.raw`\check\Lambda_{\max} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`),
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
        String.raw`\begin{aligned}
\check{g}(1,\dots,1) - \check{g}(\epsilon)
&= \sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)
\Bigl(1 - \epsilon_\mu\Bigr)
   \quad (\because \blkref{eigenvalues_of_check_Vprime}\text{ の }\check{g}\text{ の定義と分配法則}) \\
&\geq \gamma(\tilde\theta_{\mu_0})\Bigl(1 - \epsilon_{\mu_0}\Bigr)
   \quad (\because \text{各項は }\gamma(\tilde\theta_\mu) > 0\text{ と }
1 - \epsilon_\mu \in \{0,1\}\text{ より} \geq 0\text{。}\mu = \mu_0\text{ の項だけを残す}) \\
&= \gamma(\tilde\theta_{\mu_0})
   \quad (\because \epsilon_{\mu_0} = 0) \\
&> 0
   \quad (\because \blkref{gamma_theta_tilde_mu_positive})
\end{aligned}`,
      ),
      paragraph([
        "である。よって ",
        math(String.raw`\check{g}(\epsilon) < \check{g}(1,\dots,1)`),
        " であり、",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\Lambda_\epsilon
&= (2s_2)^{M_{\mathrm{col}}/2}\exp(\check{g}(\epsilon))
   \quad (\because \blkref{eigenvalues_of_V_plus}\text{ の }\check\Lambda_\epsilon\text{ の定義と }
\blkref{eigenvalues_of_check_Vprime}\text{ の }\check{g}\text{ の定義}) \\
&< (2s_2)^{M_{\mathrm{col}}/2}\exp(\check{g}(1,\dots,1))
   \quad (\because \check{g}(\epsilon) < \check{g}(1,\dots,1)\text{、}
t \mapsto \exp(t)\text{ は狭義単調増加、}(2s_2)^{M_{\mathrm{col}}/2} > 0) \\
&= \check\Lambda_{\max}
   \quad (\because \blkref{eigenvalues_of_V_plus}\text{ (2)})
\end{aligned}`,
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
        math(String.raw`x \in \mathbb{C}^{2^{M_{\mathrm{col}}}}`),
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
   \quad (\because \blkref{eigenvalues_of_V_plus}\text{ (1)}) \\
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
        String.raw`\begin{aligned}
x &= \sum_{\epsilon}\check{Q}_\epsilon x
   \quad (\because \blkref{check_joint_eigenspace_decomposition}\text{ (2)}) \\
&= \check{Q}_{(1,\dots,1)}x
   \quad (\because \epsilon \neq (1,\dots,1)\text{ の項は }\check{Q}_\epsilon x = 0)
\end{aligned}`,
      ),
      paragraph([
        "とくに ",
        math(String.raw`x \in \mathrm{im}\,\check{Q}_{(1,\dots,1)}`),
        " である。逆に ",
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
        "2026-09-26: 整数運動量の経路を本文から外したため、それとの比較・依存を除いた。",
      ],
    },
  },
  {
    id: "eigenvalues_of_V_plus_claim_c_value_eigenvalues_and_strict_maximum",
    kind: "claim",
    standing: "mainTheorem",
    title: {
      tex: String.raw`V^{(+)}\check{Q}_\epsilon = \check\Lambda_\epsilon\check{Q}_\epsilon \text{ と } \max_\epsilon \check\Lambda_\epsilon = \check\Lambda_{(1,\dots,1)} = \Lambda^{(1/2)}_{M_{\mathrm{col}}}`,
    },
    labels: ["V_plus_eigenvalues_with_c_value_and_strict_maximum"],
    statement: [
      paragraph([
        math(String.raw`K_1, K_2 \in \mathbb{R}_{>0}`),
        "、",
        math(String.raw`M_{\mathrm{col}} \in \mathbb{Z}_{\geq 2}`),
        " とする。",
        ref("def_V_plus"),
        " の ",
        math(String.raw`V^{(+)} \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "、",
        ref("def_check_number_operator"),
        " の ",
        math(String.raw`\check{n}_\mu \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        "（",
        math(String.raw`\mu \in \check{\mathcal{M}}`),
        "、",
        ref("def_check_index_set"),
        "）、",
        ref("def_gamma_theta"),
        " の ",
        math(String.raw`\gamma(\tilde\theta_\mu) \in \mathbb{R}`),
        "（",
        math(String.raw`\mathbb{R}`),
        " に住むのは、",
        ref("def_arccosh"),
        " が逆双曲線余弦を実対数で定めるため）、",
        math(String.raw`I := I_{\mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})}`),
        "、",
        math(String.raw`\epsilon \in \{0,1\}^{\check{\mathcal{M}}}`),
        " に対する ",
        ref("check_joint_eigenspace_decomposition"),
        " の ",
        math(String.raw`\check{Q}_\epsilon \in \mathrm{Mat}(2^{M_{\mathrm{col}}},\mathbb{C})`),
        " と ",
        ref("eigenvalues_of_V_plus"),
        " の ",
        math(String.raw`\check\Lambda_\epsilon \in \mathbb{R}_{>0}`),
        "、",
        ref("def_Lambda_delta_M"),
        " の ",
        math(String.raw`\Lambda^{(1/2)}_{M_{\mathrm{col}}} \in \mathbb{R}`),
        "（この二つが ",
        math(String.raw`\mathbb{R}`),
        " に住むのは、実数 ",
        math(String.raw`\gamma(\tilde\theta_\mu)`),
        " の和を実数の指数関数に入れ、",
        math(String.raw`2\sinh 2K_2 > 0`),
        " の実数冪を掛けた値だから）について、次が成り立つ。",
      ]),
      list([
        [
          math(String.raw`\text{(1)}\quad V^{(+)} = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)`),
          "。すなわち ",
          ref("V_plus_eq_c_exp_sum_gamma_check_number_operator"),
          " の式は ",
          math(String.raw`c = (2\sinh 2K_2)^{M_{\mathrm{col}}/2}`),
          " で成り立つ。",
        ],
        [
          math(String.raw`\text{(2)}\quad V^{(+)}\check{Q}_\epsilon = \check\Lambda_\epsilon\check{Q}_\epsilon
\quad \left(\epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right)`),
        ],
        [
          math(String.raw`\text{(3)}\quad \Lambda^{(1/2)}_{M_{\mathrm{col}}} = \check\Lambda_{(1,\dots,1)}
= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\frac12\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)`),
        ],
        [
          math(String.raw`\text{(4)}\quad \epsilon \neq (1,\dots,1) \ \Longrightarrow\ \check\Lambda_\epsilon < \check\Lambda_{(1,\dots,1)}`),
          "。とくに ",
          math(String.raw`\max_{\epsilon \in \{0,1\}^{\check{\mathcal{M}}}} \check\Lambda_\epsilon = \check\Lambda_{(1,\dots,1)}`),
          " である。",
        ],
      ]),
    ],
    proof: [
      paragraph(["(1)"]),
      displayMath(
        String.raw`\begin{aligned}
V^{(+)}
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\,\check{V}'
&&(\because\ \blkref{constant_c_value_even_sector}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\check{X}\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{V}' := \exp(\check{X})) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu} - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_Vprime}\ \text{の}\ \check{X}\ \text{の定義}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\sum_{\mu \in \check{\mathcal{M}}} \gamma(\tilde\theta_\mu)\left(\check{n}_\mu - \tfrac12 I\right)\right)
&&(\because\ \blkref{def_check_number_operator}\ \text{の}\ \check{n}_\mu := \check\psi_\mu^\dagger\,\check\psi_{M_{\mathrm{col}}+1-\mu})
\end{aligned}`,
      ),
      paragraph(["(2)"]),
      displayMath(
        String.raw`V^{(+)}\check{Q}_\epsilon = \check\Lambda_\epsilon\check{Q}_\epsilon
\qquad (\because\ \blkref{eigenvalues_of_V_plus}\ \text{(1)})`,
      ),
      paragraph(["(3)"]),
      displayMath(
        String.raw`\begin{aligned}
\Lambda^{(1/2)}_{M_{\mathrm{col}}}
&= \check\Lambda_{\max}
&&(\because\ \blkref{max_eigenvalue_of_V_plus_simple}\ \text{(1)}) \\
&= \check\Lambda_{(1,\dots,1)}
&&(\because\ \blkref{eigenvalues_of_V_plus}\ \text{(2)：最大のものは全ての}\ \epsilon_\mu = 1\ \text{を取ったとき}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\left(1 - \tfrac12\right)\right)
&&(\because\ \blkref{eigenvalues_of_V_plus}\ \text{の}\ \check\Lambda_\epsilon\ \text{の定義に}\ \epsilon_\mu = 1\ \text{を代入}) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\cdot\tfrac12\right)
&&(\because\ 1 - \tfrac12 = \tfrac12) \\
&= (2\sinh 2K_2)^{M_{\mathrm{col}}/2}\exp\!\left(\frac12\sum_{\mu=1}^{M_{\mathrm{col}}}\gamma(\tilde\theta_\mu)\right)
&&(\because\ \text{分配法則})
\end{aligned}`,
      ),
      paragraph([
        "(4) ",
        math(String.raw`\epsilon \neq (1,\dots,1)`),
        " とする。",
      ]),
      displayMath(
        String.raw`\begin{aligned}
\check\Lambda_\epsilon
&< \check\Lambda_{\max}
&&(\because\ \blkref{max_eigenvalue_of_V_plus_simple}\ \text{(2)}) \\
&= \check\Lambda_{(1,\dots,1)}
&&(\because\ \blkref{eigenvalues_of_V_plus}\ \text{(2)})
\end{aligned}`,
      ),
      paragraph([
        "集合 ",
        math(String.raw`\left\{\check\Lambda_\epsilon \mid \epsilon \in \{0,1\}^{\check{\mathcal{M}}}\right\} \subset \mathbb{R}`),
        " は有限集合（元は高々 ",
        math(String.raw`2^{M_{\mathrm{col}}}`),
        " 個）で ",
        math(String.raw`\check\Lambda_{(1,\dots,1)}`),
        " を含み、いま示したとおり他のすべての元は ",
        math(String.raw`\check\Lambda_{(1,\dots,1)}`),
        " より小さい。よって最大元が存在して ",
        math(String.raw`\max_{\epsilon} \check\Lambda_\epsilon = \check\Lambda_{(1,\dots,1)}`),
        " である。",
      ]),
    ],
    conversion: {
      status: "added",
      notes: [
        "2026-10-31: 章立ての組み直しで、V^{(+)} の固有値の章のゴールの式を一つの主張として立てた。既存の主張 constant_c_value_even_sector・eigenvalues_of_V_plus・max_eigenvalue_of_V_plus_simple を並べ、V̌'・X̌・ň_μ・Λ̌_ε の定義を代入するだけで、新しい証明は無い。",
      ],
    },
  },
]);
