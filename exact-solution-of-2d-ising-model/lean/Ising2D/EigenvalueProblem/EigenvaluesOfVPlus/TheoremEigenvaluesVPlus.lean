/-
# `V^{(+)}` の固有値（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`eigenvalues_of_V_plus`（`evenEigen_010_theorem_...`）。

**必要十分版**は `Ising2D/NecSuf/SimpleEigenvalue.lean` の
`NecSuf.sum_weight_le_univ` / `NecSuf.sum_weight_empty_le`（大小比較の核）と、
`Ising2D/NecSuf/JointEigenspace.lean`（固有関係そのもの）。

## 章 009 との違い

章 009 の `eigenvalues_of_V` に対して、
- 重複度が `2^{M-m}` から `1` に（`m = M`）、
- 和の範囲が `I` から `𝓜̌ = {1,…,M}` に、
- `γ(θ~_μ) > 0` が狭義なので大小比較も狭義に（`checkBigLambda_lt_max`）
なる。狭義性は `TheoremMaxEigenvalueSimple.lean` の単純性の根拠である。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimConstantCEvenSector
import Ising2D.NecSuf.SimpleEigenvalue

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

/-- **原文 `eigenvalues_of_V_plus` (1)**: `V^{(+)} Q̌_ε = (Λ̌_ε)_ℂ Q̌_ε`。

人手の (1) の第一の鎖（9 行）と 1 対 1 である（calc は 6 段。1〜5 行目が 1 段ずつ、6・7・9 行目が最後の 1 段、8 行目は無い）。人手の 6・7・9 行目（`a` の置き方、`ǧ(ε)` の定義、`Λ̌_ε` の定義）は、
Lean では `checkBigLambda` の定義（`ǧ(ε)` を `F.gval g T` で書く）の展開 `rfl` の 1 段が受け持つ。人手の 8 行目（`s_2 = sinh 2K_2`）に当たる段は無い。
Lean の `VPlus`・`checkBigLambda` は `s2` を `K_2` から独立な引数に取り、主張は全ての `s2 > 0` について述べるからである。
`hVeq` の `c` が 0 でないことは、人手では `V_plus_eq_c_check_Vprime` の `c ∈ ℂ^×` が与える。ここでは仮定に持たないので
`c_ne_zero_of_VPlus_eq_smul`（`V^{(+)}` の可逆性から）で作って `constant_c_value_even_sector` に渡す。 -/
theorem VPlus_mul_Qproj (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) (T : Finset (CheckIdx M)) :
    VPlus M s2 K1 K2star * F.Qproj T
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := by
  have hc := constant_c_value_even_sector F g hK1 hK2 hs2 (c_ne_zero_of_VPlus_eq_smul F g hs2 hVeq) hVeq
  calc VPlus M s2 K1 K2star * F.Qproj T
      = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • F.Vprime g) * F.Qproj T := by
        rw [hVeq, hc]                                                 -- `constant_c_value_even_sector`
    _ = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • (F.Vprime g * F.Qproj T) :=
        smul_mul_matrix_tensorPow _ _ _                               -- `scalar_multiple_factors_out_of_left_factor`
    _ = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • (((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T) := by
        rw [F.Vprime_mul_Qproj g T]                                   -- `eigenvalues_of_check_Vprime` の `V̌'Q̌_ε = (exp ǧ(ε))_ℂ Q̌_ε`
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) * ((Real.exp (F.gval g T) : ℝ) : ℂ)) • F.Qproj T :=
        smul_smul _ _ _                                               -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul`）
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
        rw [real_inclusion_mul]                                       -- `real_inclusion_preserves_product`
    _ = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := rfl         -- 人手の 6・7・9 行目（`checkBigLambda` の定義。8 行目は `s2` が引数なので無い）

/-- **原文 `eigenvalues_of_V_plus` (1)** の右から掛ける形 `Q̌_ε V^{(+)} = (Λ̌_ε)_ℂ Q̌_ε`（単純性の証明で使う）。

人手の (1) の第二の鎖（9 行）と 1 対 1 である（calc の段の割り当ては第一の鎖と同じ）。2 行目は `scalar_multiple_factors_out_of_right_factor`、3 行目は
`eigenvalues_of_check_Vprime` の `Q̌_εV̌' = (exp ǧ(ε))_ℂ Q̌_ε` で、4 行目からは第一の鎖と同じ行である（8 行目の段が無いことも同じ）。 -/
theorem Qproj_mul_VPlus (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g) (T : Finset (CheckIdx M)) :
    F.Qproj T * VPlus M s2 K1 K2star
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := by
  have hc := constant_c_value_even_sector F g hK1 hK2 hs2 (c_ne_zero_of_VPlus_eq_smul F g hs2 hVeq) hVeq
  calc F.Qproj T * VPlus M s2 K1 K2star
      = F.Qproj T * ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • F.Vprime g) := by
        rw [hVeq, hc]                                                 -- `constant_c_value_even_sector`
    _ = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • (F.Qproj T * F.Vprime g) :=
        mul_smul_matrix_tensorPow _ _ _                               -- `scalar_multiple_factors_out_of_right_factor`
    _ = (((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) • (((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T) := by
        rw [F.Qproj_mul_Vprime g T]                                   -- `eigenvalues_of_check_Vprime` の `Q̌_εV̌' = (exp ǧ(ε))_ℂ Q̌_ε`
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) : ℂ) * ((Real.exp (F.gval g T) : ℝ) : ℂ)) • F.Qproj T :=
        smul_smul _ _ _                                               -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
    _ = ((((2 * s2) ^ ((M : ℝ) / 2) : ℝ) * Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
        rw [real_inclusion_mul]                                       -- `real_inclusion_preserves_product`
    _ = ((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T := rfl         -- 人手の 6・7・9 行目（`checkBigLambda` の定義。8 行目は `s2` が引数なので無い）

/-- **原文 `eigenvalues_of_V_plus` (1) の対角化可能性の段落の後の鎖**: `im Q̌_ε` の元は固有値 `Λ̌_ε` の固有ベクトル。
`y = Q̌_ε x` について、人手の 5 行 `V^{(+)}y = V^{(+)}(Q̌_εy) = (V^{(+)}Q̌_ε)y = ((Λ̌_ε)_ℂ Q̌_ε)y = (Λ̌_ε)_ℂ(Q̌_εy) = (Λ̌_ε)_ℂ y`
と 1 対 1 の calc。`Q̌_εy = y` は同じ段落の前の 8 行の鎖で、`eigenvalues_of_check_Vprime` Step 4 の同じ 8 行の具体版
`CheckFermiSetup.Qproj_mulVec_Qproj_mulVec` が受け持つ（範囲もそれに合わせて `M_col = r + 1` とする）。 -/
theorem VPlus_mulVec_of_mem_range {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g) (T : Finset (CheckIdx (r + 1)))
    (x : Conf (r + 1) → ℂ) :
    (VPlus (r + 1) s2 K1 K2star).mulVec ((F.Qproj T).mulVec x)
      = ((checkBigLambda F g s2 T : ℝ) : ℂ) • ((F.Qproj T).mulVec x) := by
  set y := (F.Qproj T).mulVec x
  have hQy : (F.Qproj T).mulVec y = y := CheckFermiSetup.Qproj_mulVec_Qproj_mulVec F T x
                                                        -- 前の 8 行の鎖 `Q̌_εy = y`
  calc (VPlus (r + 1) s2 K1 K2star).mulVec y
      = (VPlus (r + 1) s2 K1 K2star).mulVec ((F.Qproj T).mulVec y) := by rw [hQy]
                                                        -- 上の等式 `Q̌_εy = y` を右辺から左辺へ
    _ = (VPlus (r + 1) s2 K1 K2star * F.Qproj T).mulVec y := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`（`m,n,p → 2^{M_col}`、`q → 1`、`A → V^{(+)}`、`B → Q̌_ε`、`C → y`）
                                                        -- を右辺から左辺へ。Lean の数ベクトルは 1 列の行列ではなく `Conf M → ℂ` なので、
                                                        -- mathlib の `Matrix.mulVec_mulVec`（`Qproj_mulVec_Qproj_mulVec` の 1 行目と同じ）
    _ = (((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T).mulVec y := by
          rw [VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq T]  -- (1) の第一の鎖
    _ = ((checkBigLambda F g s2 T : ℝ) : ℂ) • (F.Qproj T).mulVec y := smul_mulVec_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_left_factor`（`m,n → 2^{M_col}`、`p → 1`、
                                                        -- `a → (Λ̌_ε)_ℂ`、`A → Q̌_ε`、`B → y`）
    _ = ((checkBigLambda F g s2 T : ℝ) : ℂ) • y := by rw [hQy]
                                                        -- 上の等式 `Q̌_εy = y`

/-- **原文 `eigenvalues_of_V_plus` (2) の正値性**: `Λ̌_ε > 0`。

人手の (2) の前置きの 2 つの不等号と 5 行の鎖と 1 対 1 である。前置きの `a > 0`（所属は `def_second_transfer_matrix_prefactor`）は
`hapos`、`exp(ǧ(ε)) > 0`（`real_exp_positive`（`x → ǧ(ε)`））は `eigenvalues_of_check_Vprime` 最後の具体版 `exp_gval_pos` を引く `hexp` である。
`hapos` は `constant_c_value_even_sector` の準備の `a ∈ ℝ_{>0}` と同じく、Lean の `a` が `(2s_2)^{M/2}`（`Real.rpow`）なので
`Real.rpow_pos_of_pos` で作る（Lean の `s2` は `K_2` から独立な正の引数で、`2s_2 > 0` は `hs2` から出る）。
鎖の 1・3・4 行目（`Λ̌_ε` の定義、`ǧ(ε)` の定義、`a` の置き方）は `checkBigLambda` の定義の展開 `rfl` の 1 段が受け持つ。
2 行目（`s_2 = sinh 2K_2`）に当たる段は `s2` が引数なので無い（`VPlus_mul_Qproj` の 8 行目と同じ）。5 行目は ℝ で `u > 0, v > 0` なら `uv > 0`（mathlib の `mul_pos`）である。 -/
theorem checkBigLambda_pos (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) {s2 : ℝ} (hs2 : 0 < s2)
    (T : Finset (CheckIdx M)) : 0 < checkBigLambda F g s2 T := by
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
                                                        -- 前置き: `a > 0`（所属は `def_second_transfer_matrix_prefactor`）
  have hexp : 0 < Real.exp (F.gval g T) := F.exp_gval_pos g T
                                                        -- 前置き: `real_exp_positive`（`x → ǧ(ε)`）
  calc checkBigLambda F g s2 T
      = (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g T) := rfl
                                                        -- 1・3・4 行目（`Λ̌_ε`・`ǧ(ε)` の定義、`a` の置き方）
    _ > 0 := mul_pos hapos hexp                         -- ℝ で `u > 0, v > 0` なら `uv > 0`（`u → a`、`v → exp(ǧ(ε))`）

/-- **原文 `eigenvalues_of_V_plus` (2)**: 最大固有値は全ての `ε_μ = 1` のとき
（必要十分版 `NecSuf.sum_weight_le_univ` の特殊化）。 -/
theorem checkBigLambda_le_max (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 T ≤ checkBigLambda F g s2 Finset.univ := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  exact Real.exp_le_exp.2 (NecSuf.sum_weight_le_univ g hg T)

/-- **原文 `eigenvalues_of_V_plus` (2)**: 最小固有値は全ての `ε_μ = 0` のとき。 -/
theorem checkBigLambda_min_le (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 (∅ : Finset (CheckIdx M)) ≤ checkBigLambda F g s2 T := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_le_mul_of_nonneg_left ?_ (le_of_lt (Real.rpow_pos_of_pos (by linarith) _))
  exact Real.exp_le_exp.2 (NecSuf.sum_weight_empty_le g hg T)

/-- **原文 `max_eigenvalue_of_V_plus_simple` (2)**: `γ(θ~_μ) > 0` なら大小比較は狭義。

章 009 では `γ(θ_μ) ≥ 0` しか無いのでこの形は言えない
（必要十分版 `NecSuf.sum_weight_lt_of_ne_univ` の特殊化）。 -/
theorem checkBigLambda_lt_max (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) {T : Finset (CheckIdx M)}
    (hT : T ≠ Finset.univ) :
    checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ := by
  rw [checkBigLambda, checkBigLambda]
  refine mul_lt_mul_of_pos_left ?_ (Real.rpow_pos_of_pos (by linarith) _)
  exact Real.exp_lt_exp.2 (NecSuf.sum_weight_lt_of_ne_univ g hg hT)

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
