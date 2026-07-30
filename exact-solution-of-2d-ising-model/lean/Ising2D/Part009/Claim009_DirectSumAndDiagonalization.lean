/-
# 同時固有空間分解の直和形と `V'`・`V` の対角化可能性（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `joint_eigenspace_decomposition` (5)
  （`eigenvalues_of_V_008_claim_joint_eigenspace_decomposition`）
- `eigenvalues_of_Vprime`（`eigenvalues_of_V_009_claim_eigenvalues_of_Vprime`）の
  「`V'` は対角化可能」
- `eigenvalues_of_V`（`eigenvalues_of_V_011_claim_eigenvalues_of_V`）の
  「`V` は対角化可能」

**抽象版**は `Ising2D/Abstract/JointEigenspaceDecomposition.lean`。
本ファイルの主張はすべて抽象版の特殊化として導出する
（章 017 の `Ising2D/Part017/Claim006_DirectSumAndDiagonalization.lean` も同じ抽象版の特殊化）。

## 既存の (5) との関係

`Claim008_JointEigenspace.lean` の `sum_Qproj_mulVec`（`x = ∑_ε Q_ε x`）と
`eq_zero_of_sum_eq_zero`（`∑ y_ε = 0` かつ `y_ε ∈ im Q_ε` なら各 `y_ε = 0`）は、
人手証明 Step 5 が実際に書いている 2 つの事実をそのまま述べたものである。
本ファイルはそれを mathlib の内部直和（`DirectSum.IsInternal`）の言葉へ翻訳し、
そこから固有ベクトルからなる基底を構成する。
-/
import Ising2D.Part009.Claim009_EigenvaluesVprime
import Ising2D.Part009.Claim013_PositiveDefinite
import Ising2D.Abstract.JointEigenspaceDecomposition

namespace Ising2D

open Matrix
open Module (Basis)

namespace FermiSetup

variable {M : ℕ} {K : IsingConst} (F : FermiSetup M K)

/-! ## 原文 (5) の `DirectSum.IsInternal` 形 -/

/-- **原文 `joint_eigenspace_decomposition` (5)**:
`ℂ^{2^M} = ⊕_ε im Q_ε`（`Submodule` の族としての内部直和）。

`Q_ε` は行列なので、`im Q_ε` は線型写像 `x ↦ Q_ε x` の像として述べる。
抽象版 `Abstract.isInternal_range_matrix_proj` の特殊化。 -/
theorem isInternal_range_Qproj :
    DirectSum.IsInternal fun T : Finset F.Idx =>
      LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  Abstract.isInternal_range_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj

/-- 原文 (5) 前半（`im Q_ε` たちが全体を張る）を `Submodule` の言葉で述べた版。
既存の `sum_Qproj_mulVec` と同じ内容である。 -/
theorem iSup_range_Qproj_eq_top :
    (⨆ T : Finset F.Idx, LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T))) = ⊤ :=
  Abstract.iSup_range_proj_eq_top
    (p := fun T : Finset F.Idx => Matrix.toLinAlgEquiv' (F.Qproj T))
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-- 原文 (5) 後半（直和性）を `Submodule` の言葉で述べた版。
既存の `eq_zero_of_sum_eq_zero` と同じ内容である。 -/
theorem iSupIndep_range_Qproj :
    iSupIndep fun T : Finset F.Idx => LinearMap.range (Matrix.toLinAlgEquiv' (F.Qproj T)) :=
  Abstract.iSupIndep_range_proj
    (p := fun T : Finset F.Idx => Matrix.toLinAlgEquiv' (F.Qproj T))
    (fun T T' h => by rw [← map_mul, F.Qproj_mul_Qproj_of_ne h, map_zero])
    (by rw [← map_sum, F.sum_Qproj, map_one])

/-! ## `V'` の対角化可能性（原文 `eigenvalues_of_Vprime`） -/

/-- **原文 `eigenvalues_of_Vprime` の「`V'` は対角化可能」**:
`V'` の固有ベクトルからなる `ℂ^{2^M}` の基底が存在し、その基底に関する `V'` の
表現行列は対角行列である。固有値はすべて `e^{g(ε)}` の形（したがって正の実数）。 -/
theorem exists_eigenBasis_Vprime (g : F.Idx → ℝ) :
    ∃ (b : Basis (Conf M) ℂ (Conf M → ℂ)) (lam : Conf M → ℂ),
      (∀ a, ∃ T : Finset F.Idx, lam a = ((Real.exp (F.gval g T) : ℝ) : ℂ)) ∧
      (∀ a, (F.Vprime g).mulVec (b a) = lam a • b a) ∧
      LinearMap.toMatrix b b (Matrix.toLinAlgEquiv' (F.Vprime g)) = Matrix.diagonal lam :=
  Abstract.exists_eigenBasis_of_matrix_proj
    (A := F.Vprime g) (Q := F.Qproj) (c := fun T => ((Real.exp (F.gval g T) : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

/-- **原文 `eigenvalues_of_Vprime` の「相似変換で対角化できる」形**:
`P⁻¹ V' P` が対角行列になる可逆行列 `P` が存在する。 -/
theorem exists_conj_diagonal_Vprime (g : F.Idx → ℝ) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧ P' * F.Vprime g * P = Matrix.diagonal lam :=
  Abstract.exists_conj_diagonal_of_matrix_proj
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj (F.Vprime_mul_Qproj g)

/-! ## `V` の対角化可能性（原文 `eigenvalues_of_V`） -/

/-- **原文 `eigenvalues_of_V` の「`V` は対角化可能」**:
`V = c V'` なら `V` も同じ射影の族で対角化でき、固有値は `c e^{g(ε)}` である。

原文どおり `V = cV'` は 008 章の内容なので仮定として受け取る
（`Claim017_ConstantC.lean` の `constant_c_value` と同じ扱い）。 -/
theorem exists_conj_diagonal_Vmat (g : F.Idx → ℝ) {K1 η : ℂ} {s2 : ℝ} {K2star c : ℂ}
    (hVeq : Vmat M K1 η s2 K2star = c • F.Vprime g) :
    ∃ (P P' : TensorPow M) (lam : Conf M → ℂ),
      P * P' = 1 ∧ P' * P = 1 ∧ P' * Vmat M K1 η s2 K2star * P = Matrix.diagonal lam := by
  refine Abstract.exists_conj_diagonal_of_matrix_proj
    (Q := F.Qproj) (c := fun T => c * ((Real.exp (F.gval g T) : ℝ) : ℂ))
    (fun _ _ h => F.Qproj_mul_Qproj_of_ne h) F.sum_Qproj fun T => ?_
  rw [hVeq, smul_mul_assoc, F.Vprime_mul_Qproj g T, smul_smul]

end FermiSetup

end Ising2D
