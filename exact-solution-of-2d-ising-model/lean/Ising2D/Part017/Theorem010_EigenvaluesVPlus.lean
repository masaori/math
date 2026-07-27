/-
# `V^{(+)}` の固有値（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`eigenvalues_of_V_plus`（`evenEigen_010_theorem_...`）。

**抽象版**は `Ising2D/Abstract/SimpleEigenvalue.lean` の
`Abstract.sum_weight_le_univ` / `Abstract.sum_weight_empty_le`（大小比較の核）と、
`Ising2D/Abstract/JointEigenspace.lean`（固有関係そのもの）。

## 章 009 との違い

章 009 の `eigenvalues_of_V` に対して、
- 重複度が `2^{M-m}` から `1` に（`m = M`）、
- 和の範囲が `I` から `𝓜̌ = {1,…,M}` に、
- `γ(θ~_μ) > 0` が狭義なので大小比較も狭義に（`checkBigLambda_lt_max`）
なる。狭義性は `Theorem011_MaxEigenvalueSimple.lean` の単純性の根拠である。
-/
import Ising2D.Part017.Claim009_ConstantCEvenSector
import Ising2D.Abstract.SimpleEigenvalue

namespace Ising2D

open Matrix
open scoped ComplexOrder

section EigenVPlus

variable {M : ℕ}

/-- **原文 `eigenvalues_of_V_plus` の `Λ̌_ε`**:
`Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(∑_μ γ(θ~_μ)(ε_μ - 1/2))`。 -/
noncomputable def checkBigLambda (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (s2 : ℝ)
    (T : Finset (CheckIdx M)) : ℝ :=
  ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g T)

/-- **原文 `eigenvalues_of_V_plus` (1)**: `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`。 -/
theorem VPlus_mul_Qproj (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M K1 s2 K2star = c • F.Vprime g) (T : Finset (CheckIdx M)) :
    VPlus M K1 s2 K2star * F.Qproj T
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := by
  have hc := constant_c_value_even_sector F g hK1 hK2 hs2 hVeq
  rw [hVeq, hc, smul_mul_assoc, F.Vprime_mul_Qproj g T, smul_smul, checkBigLambda]
  norm_cast

/-- 左右を入れ替えた形 `Q̌_ε V^{(+)} = Λ̌_ε Q̌_ε`（単純性の証明で使う）。 -/
theorem Qproj_mul_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M K1 s2 K2star = c • F.Vprime g) (T : Finset (CheckIdx M)) :
    F.Qproj T * VPlus M K1 s2 K2star
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := by
  have hc := constant_c_value_even_sector F g hK1 hK2 hs2 hVeq
  rw [hVeq, hc, mul_smul_comm, F.Qproj_mul_Vprime g T, smul_smul, checkBigLambda]
  norm_cast

/-- **原文 `eigenvalues_of_V_plus` (1)**: `im Q̌_ε` の元は固有値 `Λ̌_ε` の固有ベクトル。 -/
theorem VPlus_mulVec_of_mem_range (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M K1 s2 K2star = c • F.Vprime g) (T : Finset (CheckIdx M))
    (x : Conf M → ℂ) :
    (VPlus M K1 s2 K2star).mulVec ((F.Qproj T).mulVec x)
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • ((F.Qproj T).mulVec x) := by
  rw [Matrix.mulVec_mulVec, VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq T, Matrix.smul_mulVec]

/-- **原文 `eigenvalues_of_V_plus` (2)**: 固有値はすべて正の実数。 -/
theorem checkBigLambda_pos (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) {s2 : ℝ} (hs2 : 0 < s2)
    (T : Finset (CheckIdx M)) : 0 < checkBigLambda F g s2 T := by
  rw [checkBigLambda]
  exact mul_pos (Real.rpow_pos_of_pos (by linarith) _) (Real.exp_pos _)

/-- **原文 `eigenvalues_of_V_plus` (2)**: 最大固有値は全ての `ε_μ = 1` のとき
（抽象版 `Abstract.sum_weight_le_univ` の特殊化）。 -/
theorem checkBigLambda_le_max (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 T ≤ checkBigLambda F g s2 Finset.univ := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  exact Real.exp_le_exp.2 (Abstract.sum_weight_le_univ g hg T)

/-- **原文 `eigenvalues_of_V_plus` (2)**: 最小固有値は全ての `ε_μ = 0` のとき。 -/
theorem checkBigLambda_min_le (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 (∅ : Finset (CheckIdx M)) ≤ checkBigLambda F g s2 T := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  exact Real.exp_le_exp.2 (Abstract.sum_weight_empty_le g hg T)

/-- **原文 `max_eigenvalue_of_V_plus_simple` (2)**: `γ(θ~_μ) > 0` なら大小比較は狭義。

章 009 では `γ(θ_μ) ≥ 0` しか無いのでこの形は言えない
（抽象版 `Abstract.sum_weight_lt_of_ne_univ` の特殊化）。 -/
theorem checkBigLambda_lt_max (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) {T : Finset (CheckIdx M)}
    (hT : T ≠ Finset.univ) :
    checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_lt_mul_of_pos_left ?_ (Real.rpow_pos_of_pos (by linarith) _)
  exact Real.exp_lt_exp.2 (Abstract.sum_weight_lt_of_ne_univ g hg hT)

/-- **原文 `eigenvalues_of_V_plus` の最後**: `Λ̌_max Λ̌_min = (2 sinh 2K_2)^M = c^2`。 -/
theorem checkBigLambda_max_mul_min (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {s2 : ℝ} (hs2 : 0 < s2) :
    checkBigLambda F g s2 Finset.univ * checkBigLambda F g s2 (∅ : Finset (CheckIdx M))
      = ((2 * s2) ^ ((M : ℝ)) : ℝ) := by
  have hsum : F.gval g Finset.univ + F.gval g (∅ : Finset (CheckIdx M)) = 0 := by
    rw [CheckFermiSetup.gval, CheckFermiSetup.gval, ← Finset.sum_add_distrib]
    refine Finset.sum_eq_zero fun i _ => ?_
    simp
    ring
  rw [checkBigLambda, checkBigLambda]
  calc ((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g Finset.univ)
        * (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g (∅ : Finset (CheckIdx M))))
      = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * ((2 * s2) ^ ((M : ℝ) / 2) : ℝ))
          * Real.exp (F.gval g Finset.univ + F.gval g (∅ : Finset (CheckIdx M))) := by
        rw [Real.exp_add]; ring
    _ = ((2 * s2) ^ ((M : ℝ)) : ℝ) := by
        rw [hsum, Real.exp_zero, mul_one, ← Real.rpow_add (by linarith)]
        congr 1
        ring

end EigenVPlus

end Ising2D
