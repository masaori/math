/-
# `Λ̌_max` の狭義の大小比較と固有空間の同定（具体版を必要十分版から導く）

具体版 `TheoremMaxEigenvalueSimple.lean` の `checkBigLambda_lt_checkBigLambda_univ`（人手 `max_eigenvalue_of_V_plus_simple` (2)）の
主張を、必要十分版 `Ising2D/NecSuf/SimpleEigenvalue.lean` の `sum_weight_lt_of_ne_univ` の `R := ℝ`、`k := halfSign` への特殊化として、
`eq_Qproj_univ_mulVec_of_eigen`・`VPlus_mulVec_of_mem_range_Qproj_univ`（同 (3) の二つの包含）の主張を、同じファイルの
`eq_proj_of_eigen`・`act_eq_smul_of_proj_fixed` の作用 `Matrix.mulVec` への特殊化として得る。
-/
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.TheoremMaxEigenvalueSimple
import Ising2D.NecSuf.SimpleEigenvalue

namespace Ising2D

section MaxSimpleFromNecSuf

variable {M : ℕ}

/-- **`checkBigLambda_lt_checkBigLambda_univ` を必要十分版から導く**: 必要十分版 `NecSuf.sum_weight_lt_of_ne_univ` の
`R := ℝ`、`k := halfSign` への特殊化。 -/
theorem checkBigLambda_lt_checkBigLambda_univ_of_necSuf (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) {T : Finset (CheckIdx M)}
    (hT : T ≠ Finset.univ) :
    checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_lt_mul_of_pos_left ?_ (Real.rpow_pos_of_pos (by linarith) _)
  exact Real.exp_lt_exp.2 (NecSuf.sum_weight_lt_of_ne_univ halfSign halfSign_one_sub_halfSign_zero g hg hT)

/-- `eq_Qproj_univ_mulVec_of_eigen` を必要十分版 `NecSuf.eq_proj_of_eigen` の特殊化として得る
（作用は `Matrix.mulVec`）。 -/
theorem eq_Qproj_univ_mulVec_of_eigen_of_necSuf (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {x : Conf M → ℂ}
    (hx : (VPlus M s2 K1 K2star).mulVec x
            = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x) :
    x = (F.Qproj Finset.univ).mulVec x := by
  classical
  refine NecSuf.eq_proj_of_eigen
    (act := fun (A : TensorPow M) (v : Conf M → ℂ) => A.mulVec v)
    (fun A B v => (Matrix.mulVec_mulVec v A B).symm)
    (fun v => Matrix.one_mulVec v)
    (fun r A v => Matrix.smul_mulVec r A v)
    (fun A r v => Matrix.mulVec_smul A r v)
    (fun q v => by rw [← Matrix.sum_mulVec])
    (Q := F.Qproj) (V := VPlus M s2 K1 K2star)
    (lam := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (i₀ := Finset.univ) F.sum_Qproj
    (fun T => Qproj_mul_VPlus F g hK1 hK2 hs2 hVeq T) ?_ hx
  intro T hT
  have hlt : checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ :=
    checkBigLambda_lt_checkBigLambda_univ_of_necSuf F g hgpos hs2 hT
  exact fun hc => absurd (Complex.ofReal_injective hc) (ne_of_lt hlt)

/-- `VPlus_mulVec_of_mem_range_Qproj_univ` を必要十分版 `NecSuf.act_eq_smul_of_proj_fixed` の特殊化として得る
（作用は `Matrix.mulVec`）。 -/
theorem VPlus_mulVec_of_mem_range_Qproj_univ_of_necSuf {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g)
    {y : Conf (r + 1) → ℂ}
    (hy : y ∈ LinearMap.range (Matrix.toLin' (F.Qproj (Finset.univ : Finset (CheckIdx (r + 1)))))) :
    (VPlus (r + 1) s2 K1 K2star).mulVec y
      = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • y := by
  obtain ⟨z, rfl⟩ := hy
  rw [Matrix.toLin'_apply]
  exact NecSuf.act_eq_smul_of_proj_fixed
    (act := fun (A : TensorPow (r + 1)) (v : Conf (r + 1) → ℂ) => A.mulVec v)
    (fun A B v => (Matrix.mulVec_mulVec v A B).symm)
    (fun r A v => Matrix.smul_mulVec r A v)
    (CheckFermiSetup.Qproj_mulVec_Qproj_mulVec F Finset.univ z)
    (VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq Finset.univ)

end MaxSimpleFromNecSuf

end Ising2D
