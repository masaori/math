/-
# `W P^{(+)}` の `H_1^{(+)}`, `H_2` による指数表示

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `projection_and_jordan_wigner_claim_symmetrized_transfer_matrix_on_sector_exponential_form`
  （ラベル **`symmetrized_transfer_matrix_on_sector_exponential_form`**）

主張: `M_col ≥ 2`、`K_1, K_2 > 0` のとき
`W P^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)}) P^{(+)}`。

## 人手証明との対応

人手の証明は式変形 5 行で、各行が次の定理・定義の書き換えに当たる。

1. `W P^{(+)} = V^{(+)} P^{(+)}`: `symmetrized_transfer_matrix_on_sectors`
2. `V^{(+)}` を `(V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}` へ: `def_V_plus`（`VPlusOfTransfer`）
3. `(V_1^{(+)})^{1/2}` を `exp((i/2)K_1H_1^{(+)})` へ: `def_V1_plus_square_root`（`V1plusHalf`）
4. `V_2` を `(2s_2)^{M_col/2} exp(iK_2^*H_2)` へ: `V2_exponential_representation`
5. `s_2` を `sinh 2K_2` へ: `def_indexed_hyperbolic_abbreviations`

Lean の `V2_exponential_representation` の右辺 `V2H2Form M (sinh 2K_2) K_2^*` は、引数 `s2` に
`sinh 2K_2` を入れてあるので、5 行目は `V2H2Form` を展開するだけで済む。
`(i/2)K_1` は Lean では `(1/2) * √-1 * K_1` と書く。

人手の主張は既存の主張と定義の代入だけなので、必要十分版は置かない（代入の鎖で使う構造の必要十分版は
1 行目の `Ising2D.NecSuf.sandwich_mul_proj_eq` が持つ）。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimV2InZY

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `symmetrized_transfer_matrix_on_sector_exponential_form`**。 -/
theorem symmetrized_transfer_matrix_on_sector_exponential_form {K2 : ℝ} (K1 : ℝ)
    (hM : 2 ≤ M) (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom * epsProjPlus M
      = matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M)
        * (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
            • matExp ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))
        * matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) * epsProjPlus M := by
  rw [symmetrized_transfer_matrix_on_sectors K1 hM hK2,  -- 人手の 1 行目
    VPlusOfTransfer,                                     -- 人手の 2 行目
    V1plusHalf,                                          -- 人手の 3 行目
    V2_exponential_representation hK2,                   -- 人手の 4 行目
    V2H2Form]                                            -- 人手の 5 行目

end Ising2D
