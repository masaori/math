/-
# `Λ̌_max = Λ^{(1/2)}_M` であり単純固有値（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`max_eigenvalue_of_V_plus_simple`（`evenEigen_011_theorem_...`）。
あわせて章 015 の `def_gamma_theta_tilde_mu`（`γ(θ~_μ) > 0`）をここで証明する。

**抽象版**は `Ising2D/Abstract/SimpleEigenvalue.lean`:
- (2) の狭義最大性 → `Abstract.sum_weight_lt_of_ne_univ`
- (3) の固有空間の同定 → `Abstract.eq_proj_of_eigen`

## `γ(θ~_μ) > 0`（半整数運動量に固有の点）

章 009 は `γ(θ_μ) ≥ 0` しか持てず（臨界点で `γ(θ_M) = 0` になりうる）、
最大固有値の単純性を言えなかった。半整数運動量では

  `cos θ~_μ < 1`（`0 < θ~_μ < 2π` による）  かつ  `sinh 2K_1 · sinh 2K_2^* > 0`

から `γ_1(θ~_μ) > cosh(2K_1 - 2K_2^*) ≥ 1` が**すべての `μ ∈ 𝓜̌`、
すべての `K_1, K_2 > 0`（臨界点を含む）で**成り立ち、`Real.arcosh_pos` により
`γ(θ~_μ) > 0` が従う。これが本章の最終結論を可能にしている。

## 依存

`Ising2D.LambdaM`（`Part012/Theorem005_OnsagerFreeEnergy.lean`、形式化済み）は
人手証明 `onsager_free_energy_expression` の `Λ^{(δ)}_M` そのものである。
`Ising2D.gammaFn`（`Part012/Claim001_Gamma1LowerBound.lean`）が
`gamma1_lower_bound_all_theta` の `γ(θ) = arccosh(γ_1(θ))` である。
-/
import Ising2D.Part017.Theorem010_EigenvaluesVPlus
import Ising2D.Part012.Theorem005_OnsagerFreeEnergy

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-! ## `γ(θ~_μ) > 0`（章 015 `def_gamma_theta_tilde_mu`） -/

section GammaPos

variable {M : ℕ}

/-- `μ ∈ 𝓜̌` なら `cos θ~_μ < 1`（`0 < θ~_μ < 2π` による）。 -/
theorem cos_thetaTilde_lt_one (hM : M ≠ 0) {μ : ℤ} (hμ : CheckIndex M μ) :
    Real.cos (thetaTilde M μ) < 1 := by
  have h1 := thetaTilde_pos hM hμ
  have h2 := thetaTilde_lt_two_pi hM hμ
  have hpi := Real.pi_pos
  rcases lt_or_eq_of_le (Real.cos_le_one (thetaTilde M μ)) with h | h
  · exact h
  · exfalso
    have hz := (Real.cos_eq_one_iff_of_lt_of_lt (by linarith) h2).1 h
    linarith

/-- **章 015 `gamma1_gt_1_theta_tilde`**: `γ_1(θ~_μ) > 1`（`μ ∈ 𝓜̌`）。 -/
theorem one_lt_gamma1R_thetaTilde (P : IsingParam) (hM : M ≠ 0) {μ : ℤ}
    (hμ : CheckIndex M μ) : 1 < gamma1R P.const (thetaTilde M μ) := by
  have hcos := cos_thetaTilde_lt_one hM hμ
  have hsinh1 : 0 < Real.sinh (2 * P.K1) := by
    have := P.s1_pos; simpa [IsingParam.const] using this
  have hsinh2 : 0 < Real.sinh (2 * P.K2star) := by
    have := P.s2star_pos; simpa [IsingParam.const] using this
  have hcs : Real.cosh (2 * P.K1 - 2 * P.K2star)
      = Real.cosh (2 * P.K1) * Real.cosh (2 * P.K2star)
        - Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star) := Real.cosh_sub _ _
  have hone : (1 : ℝ) ≤ Real.cosh (2 * P.K1 - 2 * P.K2star) := Real.one_le_cosh _
  have hpos : 0 < Real.sinh (2 * P.K1) * Real.sinh (2 * P.K2star)
      * (1 - Real.cos (thetaTilde M μ)) :=
    mul_pos (mul_pos hsinh1 hsinh2) (by linarith)
  simp only [gamma1R, IsingParam.const]
  nlinarith [hcs, hone, hpos]

/-- **章 015 `def_gamma_theta_tilde_mu`**: `γ(θ~_μ) > 0`（`μ ∈ 𝓜̌`）。

章 009 の `γ(θ_μ) ≥ 0` との違いがここにあり、単純性の根拠である。 -/
theorem gammaFn_thetaTilde_pos (P : IsingParam) (hM : M ≠ 0) {μ : ℤ}
    (hμ : CheckIndex M μ) : 0 < gammaFn P (thetaTilde M μ) :=
  Real.arcosh_pos (one_lt_gamma1R_thetaTilde P hM hμ)

end GammaPos

/-! ## 添字の付け替え（`𝓜̌ ↔ {1,…,M}`） -/

section Reindex

/-- `𝓜̌` 上の和は `{0,…,M-1}` 上の和に付け替えられる（`μ = k+1`）。 -/
theorem sum_checkIdx {β : Type*} [AddCommMonoid β] (f : ℤ → β) (M : ℕ) :
    ∑ i : CheckIdx M, f i.1 = ∑ k ∈ Finset.range M, f ((k : ℤ) + 1) := by
  have h : ∑ i : CheckIdx M, f i.1 = ∑ μ ∈ checkIdxFinset M, f μ :=
    Finset.sum_coe_sort (checkIdxFinset M) f
  rw [h, checkIdxFinset]
  exact Finset.sum_image fun x _ y _ hxy => checkIdxFinset_injOn hxy

/-- 代表点の一致: `t^{(M)}_μ` を `δ = 1/2` で取ったものが `θ~_μ` である
（人手証明 `max_eigenvalue_of_V_plus_simple` (1) の `Θ^{(1/2)}_M = {θ~_μ}`）。 -/
theorem tagPoint_half_eq_thetaTilde (M : ℕ) (k : ℕ) :
    tagPoint (1 / 2) M (k + 1) = thetaTilde M ((k : ℤ) + 1) := by
  unfold tagPoint thetaTilde
  push_cast
  ring

end Reindex

/-! ## 本体 -/

section MaxSimple

variable {M : ℕ}

/-- **原文 `max_eigenvalue_of_V_plus_simple` (1)**: `Λ̌_max = Λ^{(1/2)}_M`。 -/
theorem checkBigLambda_univ_eq_LambdaM (F : CheckFermiSetup M) (P : IsingParam)
    (g : CheckIdx M → ℝ) (hg : ∀ i : CheckIdx M, g i = gammaFn P (thetaTilde M i.1)) :
    checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ = LambdaM P (1 / 2) M := by
  have hgval : F.gval g Finset.univ
      = 1 / 2 * ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint (1 / 2) M μ) := by
    rw [Ising2D.sum_Icc_one_eq_sum_range]
    have h1 : ∑ k ∈ Finset.range M, gammaFn P (tagPoint (1 / 2) M (k + 1))
        = ∑ k ∈ Finset.range M, gammaFn P (thetaTilde M ((k : ℤ) + 1)) :=
      Finset.sum_congr rfl fun k _ => by rw [tagPoint_half_eq_thetaTilde]
    rw [h1, ← sum_checkIdx (fun μ => gammaFn P (thetaTilde M μ)) M]
    rw [CheckFermiSetup.gval, Finset.mul_sum]
    refine Finset.sum_congr rfl fun i _ => ?_
    rw [hg i]
    simp
    ring
  rw [checkBigLambda, LambdaM, hgval]

/-- **原文 `max_eigenvalue_of_V_plus_simple` (2)**: `ε ≠ (1,…,1)` なら `Λ̌_ε < Λ̌_max`。 -/
theorem checkBigLambda_lt_max_of_gammaFn (F : CheckFermiSetup M) (P : IsingParam)
    (g : CheckIdx M → ℝ) (hg : ∀ i : CheckIdx M, g i = gammaFn P (thetaTilde M i.1))
    {T : Finset (CheckIdx M)} (hT : T ≠ Finset.univ) :
    checkBigLambda F g (Real.sinh (2 * P.K2)) T
      < checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ := by
  have hgpos : ∀ i : CheckIdx M, 0 < g i := by
    intro i
    rw [hg i]
    exact gammaFn_thetaTilde_pos P F.hM (CheckIdx.prop' i)
  have hs2 : 0 < Real.sinh (2 * P.K2) := by
    have : 0 < 2 * P.K2 := by linarith [P.K2_pos]
    exact Real.sinh_pos_iff.2 this
  exact checkBigLambda_lt_max F g hgpos hs2 hT

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) 前半**:
固有値 `Λ̌_max` の固有ベクトルは `im Q̌_{(1,…,1)}` に入る。

抽象版 `Abstract.eq_proj_of_eigen` の特殊化（作用は `Matrix.mulVec`）。 -/
theorem eq_Qproj_univ_mulVec_of_eigen (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M K1 s2 K2star = c • F.Vprime g)
    {x : Conf M → ℂ}
    (hx : (VPlus M K1 s2 K2star).mulVec x
            = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x) :
    x = (F.Qproj Finset.univ).mulVec x := by
  classical
  refine Abstract.eq_proj_of_eigen
    (act := fun (A : TensorPow M) (v : Conf M → ℂ) => A.mulVec v)
    (fun A B v => (Matrix.mulVec_mulVec v A B).symm)
    (fun v => Matrix.one_mulVec v)
    (fun r A v => Matrix.smul_mulVec r A v)
    (fun A r v => Matrix.mulVec_smul A r v)
    (fun q v => by rw [← Matrix.sum_mulVec])
    (Q := F.Qproj) (V := VPlus M K1 s2 K2star)
    (lam := fun T => ((checkBigLambda F g s2 T : ℝ) : ℂ))
    (i₀ := Finset.univ) F.sum_Qproj
    (fun T => Qproj_mul_VPlus F g hK1 hK2 hs2 hVeq T) ?_ hx
  intro T hT
  have hlt : checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ :=
    checkBigLambda_lt_max F g hgpos hs2 hT
  exact fun hc => absurd (Complex.ofReal_injective hc) (ne_of_lt hlt)

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) 後半**:
逆に `im Q̌_{(1,…,1)}` の各元は固有値 `Λ̌_max` の固有ベクトルであり、
その空間の次元は `1` である。 -/
theorem finrank_range_Qproj_univ (F : CheckFermiSetup M) :
    ((Module.finrank ℂ
        (LinearMap.range (Matrix.toLin' (F.Qproj (Finset.univ : Finset (CheckIdx M))))) : ℕ)
      : ℂ) = 1 :=
  F.finrank_range_Qproj _

end MaxSimple

end Ising2D
