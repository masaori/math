/-
# 人手の `V_2` についての `V2_in_Z_Y` と `V2_exponential_representation`

対応する人手証明（正本は `structured-latex/content/004_transfer_matrix.ts`）:

* `transfer_matrix_003a_claim_V2_in_Z_Y`（ラベル **`V2_in_Z_Y`**）:
  `V_2 = (2s_2)^{M_col/2} exp(i K_2^* (Z_1 Y_1 + ⋯ + Z_{M_col} Y_{M_col}))`
* `transfer_matrix_011d_claim_V2_exponential_representation`
  （ラベル **`V2_exponential_representation`**）: `V_2 = (2s_2)^{M_col/2} exp(i K_2^* H_2)`

どちらも左辺の `V_2` は `def_transfer_matrix` の成分定義（`Ising2D.V2`）であり、
`s_2 = sinh 2K_2`, `K_2^* = Ising2D.Kstar K_2`（`K_2 > 0`）である。

## 人手証明との対応

* `V2_in_Z_Y` の Step 0–2（`σ^x_m = i Z_m Y_m`）→ `Ising2D.Z_mul_Y_same` と、その有限和版
  `Ising2D.I_smul_H2_eq_sum_sigmaX`（`Part004/Definition010_H1H2V1V2.lean`）。
* `V2_in_Z_Y` の Step 3（指数の肩の等式）→ `V2PauliForm_eq_V2FromJordanWigner`（右辺の式どうし。
  `s2`, `K2star` は独立な引数）。最終の式変形
  `V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^* ∑σ^x) = (2s_2)^{M/2} exp(K_2^* ∑σ^x) = (2s_2)^{M/2} exp(iK_2^*∑Z_mY_m)`
  の第 1 行が `second_transfer_matrix_pauli_form`、第 3 行が `V2PauliForm_eq_V2FromJordanWigner`
  → `V2_in_Z_Y`。
* `V2_exponential_representation` の 2 行（`V2_in_Z_Y` と `def_H2`）→ `V2_exponential_representation`
  （第 2 行は `V2FromJordanWigner_eq_V2H2Form`）。
-/
import Ising2D.Part004.ClaimSecondTransferMatrixPauliForm

namespace Ising2D

variable {M : ℕ}

/-- 人手 `V2_in_Z_Y` Step 3 の指数の肩の等式 `K_2^*(σ^x_1+⋯+σ^x_M) = iK_2^*(Z_1Y_1+⋯+Z_MY_M)` を、
右辺の式どうしの等式として述べたもの（`s2`, `K2star` は独立な引数）。 -/
theorem V2PauliForm_eq_V2FromJordanWigner (s2 : ℝ) (K2star : ℂ) :
    V2PauliForm M s2 K2star = V2FromJordanWigner M s2 K2star := by
  rw [V2PauliForm_eq_V2H2Form, V2FromJordanWigner_eq_V2H2Form]

/-- **人手 `V2_in_Z_Y`: `V_2 = (2s_2)^{M/2} exp(i K_2^* (Z_1 Y_1 + ⋯ + Z_M Y_M))`。** -/
theorem V2_in_Z_Y {K2 : ℝ} (h : 0 < K2) :
    V2 M K2 = V2FromJordanWigner M (Real.sinh (2 * K2)) ((Kstar K2 : ℝ) : ℂ) := by
  rw [second_transfer_matrix_pauli_form h, V2PauliForm_eq_V2FromJordanWigner]

/-- **人手 `V2_exponential_representation`: `V_2 = (2s_2)^{M/2} exp(i K_2^* H_2)`。** -/
theorem V2_exponential_representation {K2 : ℝ} (h : 0 < K2) :
    V2 M K2 = V2H2Form M (Real.sinh (2 * K2)) ((Kstar K2 : ℝ) : ℂ) := by
  rw [V2_in_Z_Y h, V2FromJordanWigner_eq_V2H2Form]

/-- `K_2 > 0` なら `s_2 = sinh 2K_2 > 0`。 -/
theorem sinh_two_mul_pos {K2 : ℝ} (h : 0 < K2) : 0 < Real.sinh (2 * K2) :=
  Real.sinh_pos_iff.mpr (by linarith)

end Ising2D
