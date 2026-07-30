/-
# 同時固有空間分解の直和形と `V̌'`・`V^{(+)}` の対角化可能性（具体版）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
- `check_joint_eigenspace_decomposition` (5)（`evenEigen_005_claim_...`）
- `eigenvalues_of_check_Vprime`（`evenEigen_006_claim_...`）の「`V̌'` は対角化可能」
- `eigenvalues_of_V_plus`（`evenEigen_010_theorem_...`）の「`V^{(+)}` は対角化可能」

**抽象版**は `Ising2D/Abstract/JointEigenspaceDecomposition.lean`。
章 009（`Ising2D/Part009/Claim009_DirectSumAndDiagonalization.lean`）と
**まったく同じ抽象版の特殊化**であり、違いは同時固有空間の次元
（章 009 の `2^{M-m}` が `m = M` により `1` になる）だけである。

半整数運動量では `tr(Q̌_ε) = 1` なので、直和成分はすべて 1 次元であり、
固有ベクトルからなる基底は「各 `ε` にちょうど 1 本」という形になる
（`Claim005_CheckJointEigenspace.lean` の `trace_Qproj` 参照）。
-/
import Ising2D.Part017.Theorem010_EigenvaluesVPlus
import Ising2D.Abstract.JointEigenspaceDecomposition

namespace Ising2D

open Matrix
open Module (Basis)

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-! ## 原文 (5) の `DirectSum.IsInternal` 形 -/

/-- **原文 `check_joint_eigenspace_decomposition` (5)**:
`ℂ^{2^M} = ⊕_ε im Q̌_ε`（`Submodule` の族としての内部直和）。 -/
theorem isInternal_range_Qproj :
    DirectSum.IsInternal fun T : Finset (CheckIdx M) =>
      LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  Abstract.isInternal_range_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj

/-- 原文 (5) 前半（`im Q̌_ε` たちが全体を張る）を `Submodule` の言葉で述べた版。 -/
theorem iSup_range_Qproj_eq_top :
    (⨆ T : Finset (CheckIdx M), LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T))) = ⊤ :=
  Abstract.iSup_range_proj_eq_top
    (p := fun T : Finset (CheckIdx M) => Matrix.toLinAlgEquiv' (F.Qproj T))
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-- 原文 (5) 後半（直和性）を `Submodule` の言葉で述べた版。 -/
theorem iSupIndep_range_Qproj :
    iSupIndep fun T : Finset (CheckIdx M) =>
      LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  Abstract.iSupIndep_range_proj
    (p := fun T : Finset (CheckIdx M) => Matrix.toLinAlgEquiv' (F.Qproj T))
    (fun _ _ h => by rw [← map_mul, F.Qproj_mul_Qproj_of_ne h, map_zero])
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-! ## `V̌'` の対角化可能性（原文 `eigenvalues_of_check_Vprime`） -/

/-- **原文 `eigenvalues_of_check_Vprime` の「`V̌'` は対角化可能」**:
`V̌'` の固有ベクトルからなる `ℂ^{2^M}` の基底が存在し、表現行列は対角行列である。 -/
theorem exists_eigenBasis_Vprime (g : CheckIdx M → ℝ) :
    ∃ (b : Basis (Conf M) ℂ (Conf M → ℂ)) (lam : Conf M → ℂ),
      (∀ a, ∃ T : Finset (CheckIdx M), lam a = ((Real.exp (F.gval g T) : ℝ) : ℂ)) ∧
      (∀ a, (F.Vprime g).mulVec (b a) = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' (F.Vprime g)) = Matrix.diagonal lam :=
  Abstract.exists_eigenBasis_of_matrix_proj
    (A := F.Vprime g) (Q := F.Qproj) (c := fun T => ((Real.exp (F.gval g T) : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

/-- **原文 `eigenvalues_of_check_Vprime` の「相似変換で対角化できる」形**。 -/
theorem exists_conj_diagonal_Vprime (g : CheckIdx M → ℝ) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧ P' * F.Vprime g * P = Matrix.diagonal lam :=
  Abstract.exists_conj_diagonal_of_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

end CheckFermiSetup

/-! ## `V^{(+)}` の対角化可能性（原文 `eigenvalues_of_V_plus`） -/

section EigenVPlus

variable {M : ℕ}

/-- **原文 `eigenvalues_of_V_plus` の「`V^{(+)}` は対角化可能」**:
`V^{(+)}` の固有ベクトルからなる基底が存在し、固有値は `Λ̌_ε` である。

各同時固有空間は 1 次元なので、この基底は「各 `ε` にちょうど 1 本」という形になる。 -/
theorem exists_eigenBasis_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    ∃ (b : Basis (Conf M) ℂ (Conf M → ℂ)) (lam : Conf M → ℂ),
      (∀ a, ∃ T : Finset (CheckIdx M), lam a = ((checkBigLambda F g s2 T : ℝ) : ℂ)) ∧
      (∀ a, (VPlus M s2 K1 K2star).mulVec (b a) = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' (VPlus M s2 K1 K2star))
        = Matrix.diagonal lam :=
  Abstract.exists_eigenBasis_of_matrix_proj
    (A := VPlus M s2 K1 K2star) (Q := F.Qproj)
    (c := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj
    (VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq)

/-- **原文 `eigenvalues_of_V_plus` の「相似変換で対角化できる」形**。 -/
theorem exists_conj_diagonal_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧
        P' * VPlus M s2 K1 K2star * P = Matrix.diagonal lam :=
  Abstract.exists_conj_diagonal_of_matrix_proj
    (Q := F.Qproj) (c := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj
    (VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq)

end EigenVPlus

end Ising2D
