/-
# `V^{(+)}` の `H_1^{(+)}`, `H_2` による指数表示

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `projection_and_jordan_wigner_claim_V_plus_exponential_form`（ラベル **`V_plus_exponential_form`**）

主張: `K_2 > 0` のとき
`V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})`。

## 人手証明との対応

人手の証明は式変形 4 行で、各行が次の定義・定理の書き換えに当たる。

1. `V^{(+)}` を `(V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` へ: `def_V_plus`（`VPlusOfTransfer`）
2. `(V_1^{(+)})^{1/2}` を `exp((i/2)K_1H_1^{(+)})` へ: `def_V1_plus_square_root`（`V1plusHalf`）
3. `V_2` を `(2s_2)^{M_col/2} exp(iK_2^*H_2)` へ: `V2_exponential_representation`
4. `s_2` を `sinh 2K_2` へ: `def_indexed_hyperbolic_abbreviations`

Lean の `V2_exponential_representation` の右辺 `V2H2Form M (sinh 2K_2) K_2^*` は、引数 `s2` に
`sinh 2K_2` を入れてあるので、4 行目は `V2H2Form` を展開するだけで済む。
`(i/2)K_1` は Lean では `(1/2) * √-1 * K_1` と書く。

人手の主張は `M_col ≥ 2` を置くが（`def_H1_plus` が `M_col ≥ 2` で定義されるため）、Lean の `H1plus M` は
任意の `M` で定まり、この代入の鎖は `M` の大きさを使わないので、仮定に置かない。

人手の主張は既存の定義と主張の代入だけなので、必要十分版は置かない。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.DefinitionV1PlusSquareRoot
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV2InZY

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `V_plus_exponential_form`**: `V^{(+)}` の `H_1^{(+)}`, `H_2` による指数表示。 -/
theorem V_plus_exponential_form {K2 : ℝ} (K1 : ℝ) (hK2 : 0 < K2) :
    VPlusOfTransfer M K1 K2
      = matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M)
        * (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
            • matExp ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))
        * matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) := by
  rw [VPlusOfTransfer,                                   -- 人手の 1 行目
    V1plusHalf,                                          -- 人手の 2 行目
    V2_exponential_representation hK2,                   -- 人手の 3 行目
    V2H2Form]                                            -- 人手の 4 行目

end Ising2D
