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
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

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

open CheckFermiSetup in
/-- 人手の `ǧ(ε) = Σ_{μ=1}^{M_col} γ(θ~_μ)(ε_μ - 1/2)` を、`Fin M` の上の和で書く（`ℝ` の値）。
人手の添字 `μ = j + 1`（`checkIdxOfFin`）へ付け替える段で、人手の鎖の行ではない（`gval_eq_sum_fin` の `ℝ` の版）。
`eigenvalues_of_V_plus` (2) の大小の比較と `max_eigenvalue_of_V_plus_simple` の鎖が使う。 -/
theorem gval_eq_sum_fin_real (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.gval g T
      = ∑ j : Fin M, g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2) := by
  rw [CheckFermiSetup.gval]
  exact (Fintype.sum_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _
    (fun _ => rfl)).symm

open CheckFermiSetup in
/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較の `ǧ(1,…,1) − ǧ(ε) ≥ 0` の鎖**: `γ(θ~_μ) > 0` なら `ǧ(ε) ≤ ǧ(1,…,1)`。
人手の 7 行と 1 対 1 の calc（人手の `ε_μ` は Lean の `if μ ∈ T then 1 else 0`、`ε = (1,…,1)` は `T = univ`）。5 行目までは
`max_eigenvalue_of_V_plus_simple` (2) の `gval_lt_gval_univ` と同じ段である。人手の `r_μ` は `let r` で置き、「`r_μ` の置き方」は `rfl` の段にした。
人手の `k → 1` は `Fin M` の `0`（`μ = j + 1`）で、`M_col ≥ 1` は `F.hM` から出す。最後の「移項」は `sub_nonneg`。
必要十分版 `NecSuf.sum_weight_le_univ` は同じ並びの calc である。 -/
theorem gval_le_gval_univ (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (hgpos : ∀ i, 0 < g i)
    (T : Finset (CheckIdx M)) :
    F.gval g T ≤ F.gval g Finset.univ := by
  let j₀ : Fin M := ⟨0, Nat.pos_of_ne_zero F.hM⟩          -- 人手の `1 ∈ 𝓜̌`（`M_col ≥ 2 ≥ 1`）
  let r : Fin M → ℝ := fun j => g (checkIdxOfFin j) * (1 - (if checkIdxOfFin j ∈ T then (1 : ℝ) else 0))
                                                        -- 人手の `r_μ := γ(θ~_μ)(1 - ε_μ)`
  have hr : ∀ j : Fin M, 0 ≤ r j := by
    intro j
    refine mul_nonneg (le_of_lt (hgpos _)) ?_
    split <;> norm_num
                                                        -- 人手の `r_μ ≥ 0`（正の実数と `0` 以上の実数の積）
  have hchain : F.gval g Finset.univ - F.gval g T ≥ 0 :=
    calc F.gval g Finset.univ - F.gval g T
        = (∑ j : Fin M, g (checkIdxOfFin j) * (1 - 1 / 2))
            - ∑ j : Fin M, g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2) := by
          rw [gval_eq_sum_fin_real F g Finset.univ, gval_eq_sum_fin_real F g T]
          simp only [Finset.mem_univ, if_true]
                                                        -- `eigenvalues_of_check_Vprime` の `ǧ` の定義を 2 か所へ同時適用
      _ = ∑ j : Fin M, (g (checkIdxOfFin j) * (1 - 1 / 2)
            - g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2)) :=
          (finite_sum_of_real_differences M _ _).symm
                                                        -- `finite_sum_of_real_differences`（`m → M_col`）を右辺から左辺へ
      _ = ∑ j : Fin M, g (checkIdxOfFin j)
            * ((1 - 1 / 2) - ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2)) :=
          Finset.sum_congr rfl fun j _ => (mul_sub _ _ _).symm
                                                        -- ℝ の分配法則を各項へ同時適用
      _ = ∑ j : Fin M, g (checkIdxOfFin j) * (1 - (if checkIdxOfFin j ∈ T then (1 : ℝ) else 0)) :=
          Finset.sum_congr rfl fun j _ => by ring
                                                        -- ℝ で `(1 - 1/2) - (ε_μ - 1/2) = 1 - ε_μ` を各項へ同時適用
      _ = ∑ j : Fin M, r j := rfl
                                                        -- `r_μ` の置き方
      _ ≥ r j₀ := finite_sum_of_nonnegative_reals_ge_term M r hr j₀
                                                        -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`m → M_col`、`k → 1`）
      _ ≥ 0 := hr j₀
                                                        -- `r_1 ≥ 0`
  exact sub_nonneg.1 hchain

open CheckFermiSetup in
/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較の `ǧ(ε) − ǧ(0,…,0) ≥ 0` の鎖**: `γ(θ~_μ) > 0` なら `ǧ(0,…,0) ≤ ǧ(ε)`。
人手の 7 行と 1 対 1 の calc（`ε = (0,…,0)` は `T = ∅`）。人手の `w_μ` は `let w` で置いた。
必要十分版 `NecSuf.sum_weight_empty_le` は同じ並びの calc である。 -/
theorem gval_empty_le_gval (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (hgpos : ∀ i, 0 < g i)
    (T : Finset (CheckIdx M)) :
    F.gval g ∅ ≤ F.gval g T := by
  let j₀ : Fin M := ⟨0, Nat.pos_of_ne_zero F.hM⟩          -- 人手の `1 ∈ 𝓜̌`（`M_col ≥ 2 ≥ 1`）
  let w : Fin M → ℝ := fun j => g (checkIdxOfFin j) * (if checkIdxOfFin j ∈ T then (1 : ℝ) else 0)
                                                        -- 人手の `w_μ := γ(θ~_μ)ε_μ`
  have hw : ∀ j : Fin M, 0 ≤ w j := by
    intro j
    refine mul_nonneg (le_of_lt (hgpos _)) ?_
    split <;> norm_num
                                                        -- 人手の `w_μ ≥ 0`（正の実数と `0` 以上の実数の積）
  have hchain : F.gval g T - F.gval g ∅ ≥ 0 :=
    calc F.gval g T - F.gval g ∅
        = (∑ j : Fin M, g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2))
            - ∑ j : Fin M, g (checkIdxOfFin j) * (0 - 1 / 2) := by
          rw [gval_eq_sum_fin_real F g T, gval_eq_sum_fin_real F g ∅]
          simp only [Finset.notMem_empty, if_false]
                                                        -- `eigenvalues_of_check_Vprime` の `ǧ` の定義を 2 か所へ同時適用
      _ = ∑ j : Fin M, (g (checkIdxOfFin j) * ((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2)
            - g (checkIdxOfFin j) * (0 - 1 / 2)) :=
          (finite_sum_of_real_differences M _ _).symm
                                                        -- `finite_sum_of_real_differences`（`m → M_col`）を右辺から左辺へ
      _ = ∑ j : Fin M, g (checkIdxOfFin j)
            * (((if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) - 1 / 2) - (0 - 1 / 2)) :=
          Finset.sum_congr rfl fun j _ => (mul_sub _ _ _).symm
                                                        -- ℝ の分配法則を各項へ同時適用
      _ = ∑ j : Fin M, g (checkIdxOfFin j) * (if checkIdxOfFin j ∈ T then (1 : ℝ) else 0) :=
          Finset.sum_congr rfl fun j _ => by ring
                                                        -- ℝ で `(ε_μ - 1/2) - (0 - 1/2) = ε_μ` を各項へ同時適用
      _ = ∑ j : Fin M, w j := rfl
                                                        -- `w_μ` の置き方
      _ ≥ w j₀ := finite_sum_of_nonnegative_reals_ge_term M w hw j₀
                                                        -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`m → M_col`、`k → 1`）
      _ ≥ 0 := hw j₀
                                                        -- `w_1 ≥ 0`
  exact sub_nonneg.1 hchain

/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較の「`x ≤ y` なら `exp(x) ≤ exp(y)`」**: 人手と同じく `x < y` と `x = y` に分け、
`x < y` は `real_exp_strictly_increasing`（Lean の具体版は無く、mathlib の `Real.exp_lt_exp`）、`x = y` は等号で出す。 -/
theorem real_exp_le_exp_of_le {x y : ℝ} (hxy : x ≤ y) : Real.exp x ≤ Real.exp y := by
  rcases lt_or_eq_of_le hxy with h | h
  · exact le_of_lt (Real.exp_lt_exp.2 h)                 -- `x < y`: `real_exp_strictly_increasing`
  · rw [h]                                              -- `x = y`: `exp(x) = exp(y)`

/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較の `Λ̌_ε ≤ Λ̌_{(1,…,1)}` の鎖**。人手の 9 行と 1 対 1 の calc。
人手の 1〜4 行目（`Λ̌_ε` の定義、`s_2 = sinh 2K_2`、`ǧ(ε)` の定義、`a` の置き方）は `checkBigLambda_pos` と同じく `rfl` の 1 段が受け持ち、
2 行目に当たる段は `s2` が引数なので無い。6〜9 行目も同じく `rfl` の 1 段である。`a > 0` は (2) の正値性の前置きと同じく
`Real.rpow_pos_of_pos` で作る。必要十分版の特殊化は `checkBigLambda_le_max`。 -/
theorem checkBigLambda_le_checkBigLambda_univ (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 T ≤ checkBigLambda F g s2 Finset.univ := by
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
                                                        -- (2) の正値性の前置き: `a > 0`
  have hexp : Real.exp (F.gval g T) ≤ Real.exp (F.gval g Finset.univ) :=
    real_exp_le_exp_of_le (gval_le_gval_univ F g hgpos T)
                                                        -- `x ≤ y` なら `exp(x) ≤ exp(y)`（`x → ǧ(ε)`、`y → ǧ(1,…,1)`）
  calc checkBigLambda F g s2 T
      = (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g T) := rfl
                                                        -- 1〜4 行目（`Λ̌_ε`・`ǧ(ε)` の定義、`a` の置き方）
    _ ≤ (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g Finset.univ) :=
        mul_le_mul_of_nonneg_left hexp (le_of_lt hapos)
                                                        -- 両辺に正の実数 `a` を掛ける
    _ = checkBigLambda F g s2 Finset.univ := rfl
                                                        -- 6〜9 行目（`a` の置き方、`ǧ` と `Λ̌_ε` の定義（`ε → (1,…,1)`））

/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較の `Λ̌_{(0,…,0)} ≤ Λ̌_ε` の鎖**。人手の 9 行と 1 対 1 の calc
（段の割り当ては `checkBigLambda_le_checkBigLambda_univ` と同じ）。必要十分版の特殊化は `checkBigLambda_min_le`。 -/
theorem checkBigLambda_empty_le_checkBigLambda (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 (∅ : Finset (CheckIdx M)) ≤ checkBigLambda F g s2 T := by
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
                                                        -- (2) の正値性の前置き: `a > 0`
  have hexp : Real.exp (F.gval g ∅) ≤ Real.exp (F.gval g T) :=
    real_exp_le_exp_of_le (gval_empty_le_gval F g hgpos T)
                                                        -- `x ≤ y` なら `exp(x) ≤ exp(y)`（`x → ǧ(0,…,0)`、`y → ǧ(ε)`）
  calc checkBigLambda F g s2 (∅ : Finset (CheckIdx M))
      = (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g ∅) := rfl
                                                        -- 1〜4 行目（`Λ̌_ε` の定義（`ε → (0,…,0)`）、`ǧ` の定義、`a` の置き方）
    _ ≤ (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g T) :=
        mul_le_mul_of_nonneg_left hexp (le_of_lt hapos)
                                                        -- 両辺に正の実数 `a` を掛ける
    _ = checkBigLambda F g s2 T := rfl
                                                        -- 6〜9 行目（`a` の置き方、`ǧ(ε)` と `Λ̌_ε` の定義）

/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較（最大）の必要十分版の特殊化**: 必要十分版 `NecSuf.sum_weight_le_univ`
（重みは非負で足りる）を `R := ℝ`、`h := 1/2` へ特殊化し、具体版 `checkBigLambda_le_checkBigLambda_univ` と同じく `a > 0` と
`exp` の単調性で `Λ̌` へ移す。 -/
theorem checkBigLambda_le_max (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 T ≤ checkBigLambda F g s2 Finset.univ := by
  haveI : Nonempty (CheckIdx M) := ⟨CheckFermiSetup.checkIdxOfFin ⟨0, Nat.pos_of_ne_zero F.hM⟩⟩
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
  exact mul_le_mul_of_nonneg_left (real_exp_le_exp_of_le (NecSuf.sum_weight_le_univ g hg T)) (le_of_lt hapos)

/-- **原文 `eigenvalues_of_V_plus` (2) の大小の比較（最小）の必要十分版の特殊化**（`NecSuf.sum_weight_empty_le`）。 -/
theorem checkBigLambda_min_le (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hg : ∀ i, 0 ≤ g i) {s2 : ℝ} (hs2 : 0 < s2) (T : Finset (CheckIdx M)) :
    checkBigLambda F g s2 (∅ : Finset (CheckIdx M)) ≤ checkBigLambda F g s2 T := by
  haveI : Nonempty (CheckIdx M) := ⟨CheckFermiSetup.checkIdxOfFin ⟨0, Nat.pos_of_ne_zero F.hM⟩⟩
  have hapos : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
  exact mul_le_mul_of_nonneg_left (real_exp_le_exp_of_le (NecSuf.sum_weight_empty_le g hg T)) (le_of_lt hapos)

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
