/-
# `𝓕^{(+)}` の上で `W` と `V^{(+)}` は一致する（必要十分版からの導出）

具体版 `ClaimWEqVPlusOnEvenSector.lean` の `epsProjPlus_mulVec_of_even`・`W_mulVec_eq_VPlus_mulVec_of_even` を、
必要十分版 `Ising2D/NecSuf/EvenSectorAgreement.lean` の `NecSuf.invProj_smul_of_fixed`・`NecSuf.smul_eq_of_mul_proj_eq` の
特殊化として得る。人手のラベルは `c_plus_equals_Lambda_half_integer`（Step 0）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimWEqVPlusOnEvenSector
import Ising2D.NecSuf.EvenSectorAgreement

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- `Conf M → ℂ` 上の線型写像の環で `2` は可逆（逆元は複素数 `1/2` 倍の写像。`ℂ` での `2` の逆元を
スカラー倍の写像 `algebraMap` で送る）。 -/
noncomputable instance invertibleTwoEndConf : Invertible (2 : Module.End ℂ (Conf M → ℂ)) :=
  haveI : Invertible (2 : ℂ) := invertibleOfNonzero two_ne_zero
  (Invertible.map (algebraMap ℂ (Module.End ℂ (Conf M → ℂ))) (2 : ℂ)).copy _ (map_ofNat _ 2).symm

/-- `⅟2` は複素数 `1/2` 倍の写像。 -/
theorem invOf_two_endConf_apply (v : Conf M → ℂ) :
    (⅟(2 : Module.End ℂ (Conf M → ℂ))) v = (1 / 2 : ℂ) • v := by
  change (algebraMap ℂ (Module.End ℂ (Conf M → ℂ)) (⅟(2 : ℂ))) v = _
  rw [Module.algebraMap_end_apply, invOf_eq_inv, one_div]

/-- `P^{(+)}` を線型写像へ送ると、必要十分版の `invProj` を `ε` の線型写像で評価したもの。 -/
theorem mulVecLin_epsProjPlus :
    (epsProjPlus M).mulVecLin = NecSuf.invProj (epsilon M).mulVecLin := by
  refine LinearMap.ext fun v => ?_
  rw [NecSuf.invProj, Module.End.mul_apply, invOf_two_endConf_apply, LinearMap.add_apply,
    Module.End.one_apply, Matrix.mulVecLin_apply, Matrix.mulVecLin_apply, epsProjPlus,
    Matrix.smul_mulVec, Matrix.add_mulVec, Matrix.one_mulVec]

/-- **具体版 `epsProjPlus_mulVec_of_even` は必要十分版 `NecSuf.invProj_smul_of_fixed` の特殊化**
（環は `Conf M → ℂ` 上の線型写像の環、`e` は `ε` の線型写像）。 -/
theorem epsProjPlus_mulVec_of_even_of_necSuf {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    epsProjPlus M *ᵥ f = f := by
  have h := NecSuf.invProj_smul_of_fixed (R := Module.End ℂ (Conf M → ℂ))
    (e := (epsilon M).mulVecLin) (f := f) hf
  rw [← mulVecLin_epsProjPlus] at h
  exact h

/-- **具体版 `W_mulVec_eq_VPlus_mulVec_of_even` は必要十分版 `NecSuf.smul_eq_of_mul_proj_eq` の特殊化**
（半群は `Conf M → ℂ` 上の線型写像の環、`B, C, P` は `W, V^{(+)}, P^{(+)}` の線型写像）。 -/
theorem W_mulVec_eq_VPlus_mulVec_of_even_of_necSuf {K2 : ℝ} (K1 : ℝ) (hM : 2 ≤ M) (hK2 : 0 < K2)
    {f : Conf M → ℂ} (hf : epsilon M *ᵥ f = f) :
    (physicalSymTransferR M K1 K2).map Complex.ofRealHom *ᵥ f
      = VPlusOfTransfer M K1 K2 *ᵥ f := by
  have hBP : ((physicalSymTransferR M K1 K2).map Complex.ofRealHom).mulVecLin * (epsProjPlus M).mulVecLin
      = (VPlusOfTransfer M K1 K2).mulVecLin * (epsProjPlus M).mulVecLin := by
    rw [Module.End.mul_eq_comp, Module.End.mul_eq_comp, ← Matrix.mulVecLin_mul, ← Matrix.mulVecLin_mul,
      symmetrized_transfer_matrix_on_sectors K1 hM hK2]
  exact NecSuf.smul_eq_of_mul_proj_eq (R := Module.End ℂ (Conf M → ℂ)) hBP
    (epsProjPlus_mulVec_of_even_of_necSuf hf)

end Ising2D
