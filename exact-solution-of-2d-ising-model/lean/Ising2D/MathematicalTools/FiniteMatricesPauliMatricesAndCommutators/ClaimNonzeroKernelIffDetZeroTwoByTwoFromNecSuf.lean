/-
# 2×2 行列で 0 でないベクトルを 0 へ送ることと行列式が 0 であることの同値（必要十分版からの導出）

具体版 `ClaimNonzeroKernelIffDetZeroTwoByTwo.lean` の `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` を、
必要十分版 `Ising2D/NecSuf/TwoByTwoKernelAndDeterminant.lean` の `NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det`
（係数は零因子の無い、0 と 1 が異なる可換環）の `R := ℂ` への特殊化として得る。人手のラベルは `nonzero_kernel_iff_det_zero_two_by_two`。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNonzeroKernelIffDetZeroTwoByTwo
import Ising2D.NecSuf.TwoByTwoKernelAndDeterminant

namespace Ising2D

open Matrix

/-- `exists_ne_zero_mulVec_eq_zero_iff_det_fin_two` を必要十分版
`NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det`（係数 `R := ℂ`）の特殊化として得る。 -/
theorem exists_ne_zero_mulVec_eq_zero_iff_det_fin_two_of_necSuf (B : Matrix (Fin 2) (Fin 2) ℂ) :
    (∃ v : Fin 2 → ℂ, v ≠ 0 ∧ B *ᵥ v = 0) ↔ B.det = 0 :=
  NecSuf.exists_ne_zero_mulVec_eq_zero_iff_det B

end Ising2D
