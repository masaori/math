/-
# `ε` の固有値 `+1` の固有空間への射影と Jordan–Wigner 表示の章の章末の主張

対応する人手証明（正本は `structured-latex/content/partition_function_projection_and_jordan_wigner.ts`）:

* `projection_and_jordan_wigner_claim_W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`
  （ラベル **`W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`**）

主張: `M_col ≥ 2`、`K_2 > 0` のとき
(1) `W P^{(+)} = V^{(+)} P^{(+)}`、
(2) `𝓕^{(+)} = {f | ε f = f} = im P^{(+)}`、
(3) `V^{(+)} = exp((i/2)K_1H_1^{(+)}) (2 sinh 2K_2)^{M_col/2} exp(iK_2^*H_2) exp((i/2)K_1H_1^{(+)})`。

## 人手証明との対応

人手の証明は既存の三つの主張を挙げるだけである。

* (1): `symmetrized_transfer_matrix_on_sectors`（`W` は物理の実対称化転送行列 `physicalSymTransferR` を
  複素行列へ写したもの）
* (2): `epsilon_projector_properties` (2) の `im P^{(+)} = 𝓕^{(+)}`（`epsilon_projector_properties_image`）の両辺の入れ替え
* (3): `V_plus_exponential_form`

人手の主張は既存の主張を並べるだけなので、必要十分版は置かない。
-/
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.PhysicalSymTransferBridge
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimEpsilonProjectors
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimVPlusExponentialForm

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手 `W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form`**。 -/
theorem W_P_plus_eq_V_plus_P_plus_image_and_V_plus_exponential_form {K2 : ℝ} (K1 : ℝ)
    (hM : 2 ≤ M) (hK2 : 0 < K2) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom * epsProjPlus M
        = VPlusOfTransfer M K1 K2 * epsProjPlus M
      ∧ {f : Conf M → ℂ | epsilon M *ᵥ f = f}
        = Set.range (fun x : Conf M → ℂ => epsProjPlus M *ᵥ x)
      ∧ VPlusOfTransfer M K1 K2
        = matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M)
          * (((((2 * Real.sinh (2 * K2)) ^ ((M : ℝ) / 2) : ℝ) : ℂ))
              • matExp ((Complex.I * ((Kstar K2 : ℝ) : ℂ)) • H2 M))
          * matExp (((1 / 2 : ℂ) * Complex.I * (K1 : ℂ)) • H1plus M) :=
  ⟨symmetrized_transfer_matrix_on_sectors K1 hM hK2,   -- 人手の (1)
    epsilon_projector_properties_image.symm,           -- 人手の (2)
    V_plus_exponential_form K1 hK2⟩                    -- 人手の (3)

end Ising2D
