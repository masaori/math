/-
# `Λ̌_max = Λ^{(1/2)}_M` であり単純固有値（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`max_eigenvalue_of_V_plus_simple`（`evenEigen_011_theorem_...`）。
あわせて章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `gamma_theta_tilde_mu_positive`（`γ(θ~_μ) > 0`）をここで証明する。

**必要十分版**は `Ising2D/NecSuf/SimpleEigenvalue.lean`:
- (2) の狭義最大性 → `NecSuf.sum_weight_lt_of_ne_univ`（人手の (2) の鎖と 1 対 1 の具体版は `gval_lt_gval_univ`・
  `checkBigLambda_lt_checkBigLambda_univ`。必要十分版の特殊化は `checkBigLambda_lt_max`）
- (3) の固有空間の同定 → `NecSuf.eq_proj_of_eigen`（人手の順の具体版は `Qproj_mulVec_eq_zero_of_eigen`・`eq_Qproj_univ_mulVec_of_eigen`）、
  逆向き → `NecSuf.act_eq_smul_of_proj_fixed`（具体版は `VPlus_mulVec_of_mem_range_Qproj_univ`）
  （(3) の集合の等号 `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)}` そのものは、二つの包含の具体版を合わせた
  `eigenspace_VPlus_max_eq_range_Qproj_univ`）

## `γ(θ~_μ) > 0`（半整数運動量に固有の点）

章 009 は `γ(θ_μ) ≥ 0` しか持てず（臨界点で `γ(θ_M) = 0` になりうる）、
最大固有値の単純性を言えなかった。半整数運動量では

  `cos θ~_μ < 1`（`0 < θ~_μ < 2π` による）  かつ  `sinh 2K_1 · sinh 2K_2^* > 0`

から `γ_1(θ~_μ) > cosh(2K_1 - 2K_2^*) ≥ 1` が**すべての `μ ∈ 𝓜̌`、
すべての `K_1, K_2 > 0`（臨界点を含む）で**成り立ち、`NecSuf.arcosh_pos_of_one_lt`（人手 `gamma_theta_tilde_mu_positive` と同じ背理法の鎖）により
`γ(θ~_μ) > 0` が従う。これが本章の最終結論を可能にしている。

## 依存

`Ising2D.LambdaM`（`EigenvalueProblem/EigenvaluesOfVPlus/TheoremOnsagerFreeEnergy.lean`、形式化済み）は
人手証明 `def_Lambda_delta_M` の `Λ^{(δ)}_M` そのものである。
`Ising2D.gammaFn`（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma1LowerBound.lean`）が
`def_gamma_theta` の `γ(θ) = arccosh(γ_1(θ))` である。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremEigenvaluesVPlus
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.TheoremOnsagerFreeEnergy
import Ising2D.NecSuf.ArcoshExp
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-! ## `γ(θ~_μ) > 0`（章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `gamma_theta_tilde_mu_positive`） -/

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
theorem one_lt_gamma1R_thetaTilde_checkIndex (P : IsingParam) (hM : M ≠ 0) {μ : ℤ}
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

/-- **章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `gamma_theta_tilde_mu_positive`**: `γ(θ~_μ) > 0`（`μ ∈ 𝓜̌`）。

章 009 の `γ(θ_μ) ≥ 0` との違いがここにあり、単純性の根拠である。 -/
theorem gammaFn_thetaTilde_pos (P : IsingParam) (hM : M ≠ 0) {μ : ℤ}
    (hμ : CheckIndex M μ) : 0 < gammaFn P (thetaTilde M μ) :=
  NecSuf.arcosh_pos_of_one_lt (one_lt_gamma1R_thetaTilde_checkIndex P hM hμ)

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
（人手の `θ~_μ = θ^{(1/2)}_{M,μ}`。`def_Theta_delta_M` と `antiperiodic_exp_sum` の `θ~_μ` の定義。Lean では `ℕ` と `ℤ` の添字の実数への包含を付け替える）。 -/
theorem tagPoint_half_eq_thetaTilde (M : ℕ) (k : ℕ) :
    tagPoint (1 / 2) M (k + 1) = thetaTilde M ((k : ℤ) + 1) := by
  unfold tagPoint thetaTilde
  push_cast
  ring

end Reindex

/-! ## 本体 -/

section MaxSimple

variable {M : ℕ}

/-- `def_Lambda_delta_M` の添字 `μ = 1, …, M_col` の和を、人手の有限和の Lean での書き方（`Fin M` の上の和、`μ = j + 1`。
`ClaimFiniteSumsOfRealNumbers.lean` の冒頭）へ付け替える。`LambdaM` は `Finset.Icc 1 M` の上の和で書いてあるので、
その読み替えの段で、人手の鎖の行ではない。 -/
theorem sum_Icc_one_gammaFn_tagPoint_eq_sum_fin (P : IsingParam) (δ : ℝ) (M : ℕ) :
    ∑ μ ∈ Finset.Icc 1 M, gammaFn P (tagPoint δ M μ)
      = ∑ j : Fin M, gammaFn P (tagPoint δ M ((j : ℕ) + 1)) := by
  rw [Ising2D.sum_Icc_one_eq_sum_range, Finset.sum_range (fun k => gammaFn P (tagPoint δ M (k + 1)))]

/-- **原文 `max_eigenvalue_of_V_plus_simple` (1)**: `Λ̌_max = Λ^{(1/2)}_M`。人手の 4 行の鎖と 1 対 1 の calc。

人手の `Λ̌_max` は Lean の `checkBigLambda … Finset.univ`（`ε = (1,…,1)`）である。1 行目の `eigenvalues_of_V_plus` (2) の表式は、
Lean では `checkBigLambda` の定義と `ǧ(1,…,1) = (1/2)Σ_{μ=1}^{M_col} γ(θ~_μ)` の展開で出す（`eigenvalues_of_V_plus` (2) の Lean の主張は無い）。
人手の `Σ_{μ=1}^{M_col}` は `Fin M` の上の和（`μ = j + 1`）、`γ(θ~_μ)` は仮定 `hg` の `g`（`gammaFn P (thetaTilde M μ)`）である。
最後の行は `LambdaM` の定義と、その和の添字の付け替え `sum_Icc_one_gammaFn_tagPoint_eq_sum_fin`（人手の鎖の行ではない）。 -/
theorem checkBigLambda_univ_eq_LambdaM (F : CheckFermiSetup M) (P : IsingParam)
    (g : CheckIdx M → ℝ) (hg : ∀ i : CheckIdx M, g i = gammaFn P (thetaTilde M i.1)) :
    checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ = LambdaM P (1 / 2) M :=
  calc checkBigLambda F g (Real.sinh (2 * P.K2)) Finset.univ
      = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2)
          * Real.exp (1 / 2 * ∑ j : Fin M, gammaFn P (thetaTilde M ((j : ℤ) + 1))) := by
        rw [checkBigLambda, gval_eq_sum_fin_real, Finset.mul_sum]
        congr 2
        refine Finset.sum_congr rfl fun j _ => ?_
        rw [hg (CheckFermiSetup.checkIdxOfFin j), if_pos (Finset.mem_univ _)]
        simp only [CheckFermiSetup.checkIdxOfFin]
        ring
                                                        -- `eigenvalues_of_V_plus` (2)
    _ = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2)
          * Real.exp (1 / 2 * ∑ j : Fin M,
              gammaFn P (2 * Real.pi * ((((j : ℤ) + 1 : ℤ) : ℝ) - 1 / 2) / M)) := rfl
                                                        -- `antiperiodic_exp_sum` の `θ~_μ` の定義を各項へ同時適用
    _ = (2 * Real.sinh (2 * P.K2)) ^ ((M : ℝ) / 2)
          * Real.exp (1 / 2 * ∑ j : Fin M, gammaFn P (tagPoint (1 / 2) M ((j : ℕ) + 1))) := by
        have h : ∀ j : Fin M, gammaFn P (2 * Real.pi * ((((j : ℤ) + 1 : ℤ) : ℝ) - 1 / 2) / M)
            = gammaFn P (tagPoint (1 / 2) M ((j : ℕ) + 1)) := fun j => by
          rw [tagPoint_half_eq_thetaTilde M j]
          rfl
        simp only [h]
                                                        -- `def_Theta_delta_M`（`δ → 1/2`）を右辺から左辺へ、各項へ同時適用
                                                        -- （人手の `μ ∈ ℤ` の包含 `μ_ℝ` と、`tagPoint` の `ℕ` の添字の包含の付け替えは `tagPoint_half_eq_thetaTilde`）
    _ = LambdaM P (1 / 2) M := by
        rw [LambdaM, sum_Icc_one_gammaFn_tagPoint_eq_sum_fin]
                                                        -- `def_Lambda_delta_M`（`δ → 1/2`）を右辺から左辺へ

open CheckFermiSetup in
/-- **原文 `max_eigenvalue_of_V_plus_simple` (2) の `ǧ(1,…,1) − ǧ(ε)` の鎖**: `γ(θ~_μ) > 0` かつ `ε ≠ (1,…,1)` なら
`ǧ(ε) < ǧ(1,…,1)`。人手の行と 1 対 1 の calc（人手の `ε_μ` は Lean の `if μ ∈ T then 1 else 0`、`ε = (1,…,1)` は `T = univ`）。
人手の `a_μ` は `let a` で置き、「`a_μ` の置き方」の 2 行は `rfl` の段にした。最後の「移項」は `sub_pos`。
必要十分版 `NecSuf.sum_weight_lt_of_ne_univ` は同じ並びの calc である。 -/
theorem gval_lt_gval_univ (F : CheckFermiSetup M) (g : CheckIdx M → ℝ) (hgpos : ∀ i, 0 < g i)
    {T : Finset (CheckIdx M)} (hT : T ≠ Finset.univ) :
    F.gval g T < F.gval g Finset.univ := by
  obtain ⟨i₀, hi₀⟩ : ∃ i₀ : CheckIdx M, i₀ ∉ T := by
    by_contra hc
    exact hT (Finset.eq_univ_of_forall fun i => not_not.1 fun hi => hc ⟨i, hi⟩)
                                                        -- 人手の「ある `μ_0` で `ε_{μ_0} = 0`」
  obtain ⟨j₀, rfl⟩ := checkIdxOfFin_surjective i₀
  let a : Fin M → ℝ := fun j => g (checkIdxOfFin j) * (1 - (if checkIdxOfFin j ∈ T then (1 : ℝ) else 0))
                                                        -- 人手の `a_μ := γ(θ~_μ)(1 - ε_μ)`
  have ha : ∀ j : Fin M, 0 ≤ a j := by
    intro j
    refine mul_nonneg (le_of_lt (hgpos _)) ?_
    split <;> norm_num
                                                        -- 人手の `a_μ ≥ 0`（正の実数と `0` 以上の実数の積）
  have hchain : F.gval g Finset.univ - F.gval g T > 0 :=
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
      _ = ∑ j : Fin M, a j := rfl
                                                        -- `a_μ` の置き方
      _ ≥ a j₀ := finite_sum_of_nonnegative_reals_ge_term M a ha j₀
                                                        -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`m → M_col`、`k → μ_0`）
      _ = g (checkIdxOfFin j₀) * (1 - (if checkIdxOfFin j₀ ∈ T then (1 : ℝ) else 0)) := rfl
                                                        -- `a_μ` の置き方
      _ = g (checkIdxOfFin j₀) * 1 := by rw [if_neg hi₀, sub_zero]
                                                        -- `ε_{μ_0} = 0` なので `1 - ε_{μ_0} = 1`
      _ = g (checkIdxOfFin j₀) := mul_one _
                                                        -- `1` は ℝ の積の単位元
      _ > 0 := hgpos _
                                                        -- `gamma_theta_tilde_mu_positive`
  exact sub_pos.1 hchain

/-- **原文 `max_eigenvalue_of_V_plus_simple` (2) の `Λ̌_ε` の鎖**: `γ(θ~_μ) > 0` かつ `ε ≠ (1,…,1)` なら `Λ̌_ε < Λ̌_max`。
人手の行と対応する calc。鎖の前の `exp(ǧ(ε)) < exp(ǧ(1,…,1))`（人手 `real_exp_strictly_increasing`）は mathlib の
`Real.exp_lt_exp`（`real_exp_strictly_increasing` の Lean の具体版は無い）、`(2s_2)^{M_col/2} > 0` は `Real.rpow_pos_of_pos`
（本文に実数冪を定めるブロックが無い）で出す。段にしない人手の行（`s_2` の略記の 2 行と最後の `Λ̌_{(1,…,1)} = Λ̌_max`）は calc の注記に書いた。 -/
theorem checkBigLambda_lt_checkBigLambda_univ (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {s2 : ℝ} (hs2 : 0 < s2) {T : Finset (CheckIdx M)}
    (hT : T ≠ Finset.univ) :
    checkBigLambda F g s2 T < checkBigLambda F g s2 Finset.univ := by
  have hexp : Real.exp (F.gval g T) < Real.exp (F.gval g Finset.univ) :=
    Real.exp_lt_exp.2 (gval_lt_gval_univ F g hgpos hT)
                                                        -- `real_exp_strictly_increasing`（`x → ǧ(ε)`、`y → ǧ(1,…,1)`）
  have hpow : 0 < (2 * s2) ^ ((M : ℝ) / 2) := Real.rpow_pos_of_pos (by linarith) _
                                                        -- `2s_2 > 0` の実数冪
  calc checkBigLambda F g s2 T
      = (2 * s2) ^ ((M : ℝ) / 2)
          * Real.exp (∑ i : CheckIdx M, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)) := rfl
                                                        -- `eigenvalues_of_V_plus` の `Λ̌_ε` の定義
                                                        -- （人手の次の行「`s_2 = sinh 2K_2`」は、Lean では `s2` を引数に取るので段にしない）
    _ = (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g T) := rfl
                                                        -- `ǧ` の定義
    _ < (2 * s2) ^ ((M : ℝ) / 2) * Real.exp (F.gval g Finset.univ) :=
        mul_lt_mul_of_pos_left hexp hpow
                                                        -- 両辺に正の実数 `(2s_2)^{M_col/2}` を掛ける
    _ = (2 * s2) ^ ((M : ℝ) / 2)
          * Real.exp (∑ i : CheckIdx M, g i * ((if i ∈ (Finset.univ : Finset (CheckIdx M)) then (1 : ℝ) else 0) - 1 / 2)) := rfl
                                                        -- `ǧ` の定義（`ε → (1,…,1)`）。`s_2` の行は上と同じく段にしない
    _ = checkBigLambda F g s2 Finset.univ := rfl
                                                        -- `Λ̌_ε` の定義（`ε → (1,…,1)`）。人手の最後の行 `Λ̌_{(1,…,1)} = Λ̌_max`（`eigenvalues_of_V_plus` (2)）は、
                                                        -- Lean の `Λ̌_max` が `checkBigLambda F g s2 Finset.univ` そのものなので段にしない

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
  exact checkBigLambda_lt_checkBigLambda_univ F g hgpos hs2 hT

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の固有方程式に左から `Q̌_{ε'}` を掛ける鎖**:
`V^{(+)}x = Λ̌_max x` なら `Λ̌_{ε'}(Q̌_{ε'}x) = Λ̌_max(Q̌_{ε'}x)`。人手の 5 行と 1 対 1 の calc。
Lean の数ベクトルは 1 列の行列ではなく `Conf M → ℂ` なので、`q → 1`・`p → 1` で引く人手の主張は
mathlib の `Matrix.smul_mulVec`・`Matrix.mulVec_mulVec`・`Matrix.mulVec_smul` で書く。
必要十分版 `NecSuf.eq_proj_of_eigen` の中の `hchain` が同じ 5 段の calc である。 -/
theorem checkBigLambda_smul_Qproj_mulVec_of_eigen (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {x : Conf M → ℂ}
    (hx : (VPlus M s2 K1 K2star).mulVec x
            = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x)
    (T : Finset (CheckIdx M)) :
    ((checkBigLambda F g s2 T : ℝ) : ℂ) • (F.Qproj T).mulVec x
      = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • (F.Qproj T).mulVec x :=
  calc ((checkBigLambda F g s2 T : ℝ) : ℂ) • (F.Qproj T).mulVec x
      = (((checkBigLambda F g s2 T : ℝ) : ℂ) • F.Qproj T).mulVec x :=
        (Matrix.smul_mulVec _ _ _).symm
                                                        -- `scalar_multiple_factors_out_of_left_factor`（`p → 1`）を右辺から左辺へ
    _ = (F.Qproj T * VPlus M s2 K1 K2star).mulVec x := by
        rw [Qproj_mul_VPlus F g hK1 hK2 hs2 hVeq T]
                                                        -- `eigenvalues_of_V_plus` (1) の `Q̌_ε V^{(+)} = Λ̌_ε Q̌_ε` を右辺から左辺へ
    _ = (F.Qproj T).mulVec ((VPlus M s2 K1 K2star).mulVec x) :=
        (Matrix.mulVec_mulVec _ _ _).symm
                                                        -- `mat_mult_associative`（`q → 1`）
    _ = (F.Qproj T).mulVec (((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x) := by rw [hx]
                                                        -- `V^{(+)}x = Λ̌_max x`
    _ = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • (F.Qproj T).mulVec x :=
        Matrix.mulVec_smul _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor`（`p → 1`）

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の `Q̌_{ε'}x = O` の 2 本の鎖**（`ε' ≠ (1,…,1)`）:
左から `Q̌_{ε'}` を掛ける鎖（`checkBigLambda_smul_Qproj_mulVec_of_eigen`）の両端の等式から、
`d := Λ̌_{ε'} − Λ̌_max` について `d(Q̌_{ε'}x) = O` の 4 行、`Q̌_{ε'}x = O` の 5 行を人手の順に示す。
`d ≠ 0` は人手と同じく (2)（`checkBigLambda_lt_checkBigLambda_univ`）と `ι_{ℝ→ℂ}` の単射性
（mathlib の `Complex.ofReal_injective`）と加法の群構造（`sub_eq_zero`）から出す。
Lean の数ベクトルは `Conf M → ℂ` で、零ベクトルは `0`。`difference_of_scalar_multiples_of_one_matrix`・
`scalar_multiple_by_one`・`scalar_multiple_is_associative`・`scalar_multiple_of_zero_matrix`（いずれも `n → 1`）は
この型の具体版が無いので、mathlib の `sub_smul`・`one_smul`・`mul_smul`・`smul_zero` で受ける。 -/
theorem Qproj_mulVec_eq_zero_of_eigen (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {x : Conf M → ℂ}
    (hx : (VPlus M s2 K1 K2star).mulVec x
            = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x)
    {T : Finset (CheckIdx M)} (hT : T ≠ Finset.univ) :
    (F.Qproj T).mulVec x = 0 := by
  have hchain := checkBigLambda_smul_Qproj_mulVec_of_eigen F g hK1 hK2 hs2 hVeq hx T
                                                        -- 上の鎖の両端の等式 `Λ̌_{ε'}(Q̌_{ε'}x) = Λ̌_max(Q̌_{ε'}x)`
  set a : ℂ := ((checkBigLambda F g s2 T : ℝ) : ℂ)
  set b : ℂ := ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ)
  set v : Conf M → ℂ := (F.Qproj T).mulVec x
  set d : ℂ := a - b with hd_def                        -- `d := Λ̌_{ε'} − Λ̌_max`（`def_complex_difference`）
  have hab : a ≠ b := fun hc =>
    ne_of_lt (checkBigLambda_lt_checkBigLambda_univ F g hgpos hs2 hT) (Complex.ofReal_injective hc)
                                                        -- (2) の `Λ̌_{ε'} < Λ̌_max` と、`(Λ̌, 0)` の第 1 成分が違うこと
  have hd : d ≠ 0 := fun h => hab (sub_eq_zero.1 h)    -- `complex_numbers_form_a_field` の加法の群構造
  have hdv : d • v = 0 :=
    calc d • v
        = (a - b) • v := by rw [hd_def]                 -- `d` の置き方
      _ = a • v - b • v := sub_smul _ _ _               -- `difference_of_scalar_multiples_of_one_matrix` を右辺から左辺へ
      _ = b • v - b • v := by rw [hchain]               -- 上の鎖の両端の等式
      _ = 0 := sub_self _                               -- `matrix_difference_zero_iff_equal` の `⟸`
  calc v
      = (1 : ℂ) • v := (one_smul ℂ v).symm              -- `scalar_multiple_by_one` を右辺から左辺へ
    _ = (d⁻¹ * d) • v := by rw [inv_mul_cancel₀ hd]     -- `d^{-1}d = 1_ℂ`（`complex_numbers_form_a_field` の逆元）を右辺から左辺へ
    _ = d⁻¹ • (d • v) := mul_smul _ _ _                 -- `scalar_multiple_is_associative` を右辺から左辺へ
    _ = d⁻¹ • (0 : Conf M → ℂ) := by rw [hdv]          -- 上の鎖 `d(Q̌_{ε'}x) = O`
    _ = 0 := smul_zero _                                -- `scalar_multiple_of_zero_matrix`

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の `x = Q̌_{(1,…,1)}x` の鎖**（4 行）を、人手と同じく
数ベクトルを 1 列の行列 `x : Matrix (Conf (r + 1)) (Fin 1) ℂ` に、`ε ∈ {0,1}^𝓜̌` の上の和を `NecSuf.binWordSum r`
（`def_sum_over_binary_words`、`m → 2^{M_col}`、`n → 1`、`r → M_col`）にして書いた calc。人手の `M_col` が Lean の `r + 1`、
人手の `(1,…,1)` が Lean の語 `ε₀` である（Lean の添字 `finsetOfBinWord ε₀` が `Finset.univ` のもの）。
前提 `hzero` は上で示した `Q̌_εx = O`（`ε ≠ (1,…,1)`）。 -/
theorem colVec_eq_Qproj_mul_of_zero {r : ℕ} (F : CheckFermiSetup (r + 1)) (ε₀ : Fin (r + 1) → Fin 2)
    (x : Matrix (Conf (r + 1)) (Fin 1) ℂ)
    (hzero : ∀ ε, ε ≠ ε₀ → F.Qproj (CheckFermiSetup.finsetOfBinWord ε) * x = 0) :
    x = F.Qproj (CheckFermiSetup.finsetOfBinWord ε₀) * x :=
  calc x
      = (1 : TensorPow (r + 1)) * x := (identity_matrix_mul_colVec x).symm
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
                                                        -- （`m → 2^{M_col}`、`n → 1`、`A → x`）を右辺から左辺へ
    _ = NecSuf.binWordSum r (fun ε => F.Qproj (CheckFermiSetup.finsetOfBinWord ε)) * x := by
        rw [CheckFermiSetup.sum_Qproj_step2 F]
                                                        -- `check_joint_eigenspace_decomposition` (2) を右辺から左辺へ
    _ = NecSuf.binWordSum r (fun ε => F.Qproj (CheckFermiSetup.finsetOfBinWord ε) * x) :=
        binWordSum_mul_colVec r _ x
                                                        -- `sum_over_binary_words_distributes_in_left_factor`
                                                        -- （`m,n → 2^{M_col}`、`p → 1`、`r → M_col`、`X_ε → Q̌_ε`、`C → x`）
    _ = F.Qproj (CheckFermiSetup.finsetOfBinWord ε₀) * x :=
        binWordSum_eq_of_eq_zero_colVec r ε₀ _ hzero
                                                        -- `sum_over_binary_words_with_one_nonzero_term`
                                                        -- （`m → 2^{M_col}`、`n → 1`、`r → M_col`、`ε' → (1,…,1)`、`B_ε → Q̌_εx`）。
                                                        -- 前提は上で示した `Q̌_εx = O`

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の `x ∈ im Q̌_{(1,…,1)}`**: 固有値 `Λ̌_max` の固有ベクトルは
`x = Q̌_{(1,…,1)}x` を満たす。
人手の範囲 `M_col ≥ 2`（`M = r + 1` に含まれる）では、`check_joint_eigenspace_decomposition` (5) の `sum_Qproj_mulVec` と同じく、
数ベクトルを 1 列の行列へ送る単射 `Matrix.replicateCol (Fin 1)` と、語から部分集合への全単射 `finsetOfBinWord` で
人手の 4 行の calc `colVec_eq_Qproj_mul_of_zero` へ運ぶ（運ぶ段は人手の証明の行ではない）。`Q̌_εx = O` は
`Qproj_mulVec_eq_zero_of_eigen`。`M = 0` は人手の範囲外で、mathlib の `Matrix.one_mulVec`・`Matrix.sum_mulVec`・
`Finset.sum_eq_single` で閉じる。
必要十分版 `NecSuf.eq_proj_of_eigen` の特殊化は `eq_Qproj_univ_mulVec_of_eigen_of_necSuf`。 -/
theorem eq_Qproj_univ_mulVec_of_eigen (F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (hgpos : ∀ i, 0 < g i) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus M s2 K1 K2star = c • F.Vprime g)
    {x : Conf M → ℂ}
    (hx : (VPlus M s2 K1 K2star).mulVec x
            = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x) :
    x = (F.Qproj Finset.univ).mulVec x := by
  classical
  have hz : ∀ T : Finset (CheckIdx M), T ≠ Finset.univ → (F.Qproj T).mulVec x = 0 :=
    fun T hT => Qproj_mulVec_eq_zero_of_eigen F g hgpos hK1 hK2 hs2 hVeq hx hT
  cases M with
  | zero =>
    calc x = (1 : TensorPow 0).mulVec x := (Matrix.one_mulVec x).symm
      _ = (∑ T : Finset (CheckIdx 0), F.Qproj T).mulVec x := by rw [F.sum_Qproj]
      _ = ∑ T : Finset (CheckIdx 0), (F.Qproj T).mulVec x := Matrix.sum_mulVec _ _ _
      _ = (F.Qproj Finset.univ).mulVec x :=
          Finset.sum_eq_single Finset.univ (fun T _ hT => hz T hT) (fun h => absurd (Finset.mem_univ _) h)
  | succ r =>
    obtain ⟨ε₀, hε₀⟩ := CheckFermiSetup.finsetOfBinWord_bijective.2 (Finset.univ : Finset (CheckIdx (r + 1)))
                                                        -- 人手の `(1,…,1)` に当たる語 `ε₀`（運ぶ段）
    apply Matrix.replicateCol_injective (ι := Fin 1)
    calc Matrix.replicateCol (Fin 1) x
        = F.Qproj (CheckFermiSetup.finsetOfBinWord ε₀) * Matrix.replicateCol (Fin 1) x := by
          refine colVec_eq_Qproj_mul_of_zero F ε₀ _ (fun ε hε => ?_)
          have hT : CheckFermiSetup.finsetOfBinWord ε ≠ Finset.univ := fun h =>
            hε (CheckFermiSetup.finsetOfBinWord_bijective.1 (h.trans hε₀.symm))
          rw [← Matrix.replicateCol_mulVec, hz _ hT]
          ext a b
          simp
                                                        -- 1 列の行列へ送り（運ぶ段）、人手の 4 行の calc を使う
      _ = Matrix.replicateCol (Fin 1) ((F.Qproj Finset.univ).mulVec x) := by
          rw [hε₀, Matrix.replicateCol_mulVec]
                                                        -- 数ベクトルへ戻す（運ぶ段）

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
    checkBigLambda_lt_max F g hgpos hs2 hT
  exact fun hc => absurd (Complex.ofReal_injective hc) (ne_of_lt hlt)

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の逆向きの鎖**: `im Q̌_{(1,…,1)}` の各元は固有値 `Λ̌_max` の固有ベクトル。
人手の `V^{(+)}y = Λ̌_max y` の 6 行と 1 対 1 の calc。`Q̌_{(1,…,1)}y = y` の 8 行は、人手と同じ行の
`CheckFermiSetup.Qproj_mulVec_Qproj_mulVec`（`eigenvalues_of_check_Vprime` Step 4 の鎖、`ε → (1,…,1)`）である。
人手の範囲 `M_col ≥ 2` を含む `M = r + 1` で述べる（`Qproj_mulVec_Qproj_mulVec` がこの形）。
Lean の `Λ̌_max` は `checkBigLambda F g s2 univ` そのもの（`Λ̌_{(1,…,1)}` と同じ項）なので、
`eigenvalues_of_V_plus` (2) の行は `rfl` である。`mat_mult_associative`（`q → 1`）は `Matrix.mulVec_mulVec` で受ける。
必要十分版 `NecSuf.act_eq_smul_of_proj_fixed` の特殊化は `VPlus_mulVec_of_mem_range_Qproj_univ_of_necSuf`。 -/
theorem VPlus_mulVec_of_mem_range_Qproj_univ {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g)
    {y : Conf (r + 1) → ℂ}
    (hy : y ∈ LinearMap.range (Matrix.toLin' (F.Qproj (Finset.univ : Finset (CheckIdx (r + 1)))))) :
    (VPlus (r + 1) s2 K1 K2star).mulVec y
      = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • y := by
  obtain ⟨z, rfl⟩ := hy                                -- `y = Q̌_{(1,…,1)}z` を満たす `z` を取る（`im` の定義）
  rw [Matrix.toLin'_apply]
  set y := (F.Qproj Finset.univ).mulVec z
  have hQy : (F.Qproj Finset.univ).mulVec y = y := CheckFermiSetup.Qproj_mulVec_Qproj_mulVec F Finset.univ z
                                                        -- `Q̌_{(1,…,1)}y = y` の 8 行
  calc (VPlus (r + 1) s2 K1 K2star).mulVec y
      = (VPlus (r + 1) s2 K1 K2star).mulVec ((F.Qproj Finset.univ).mulVec y) := by rw [hQy]
                                                        -- 上の等式 `Q̌_{(1,…,1)}y = y` を右辺から左辺へ
    _ = (VPlus (r + 1) s2 K1 K2star * F.Qproj Finset.univ).mulVec y := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`（`q → 1`）を右辺から左辺へ
    _ = (((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • F.Qproj Finset.univ).mulVec y := by
        rw [VPlus_mul_Qproj F g hK1 hK2 hs2 hVeq Finset.univ]
                                                        -- `eigenvalues_of_V_plus` (1) の `V^{(+)}Q̌_ε = Λ̌_εQ̌_ε`（`ε → (1,…,1)`）
    _ = (((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • F.Qproj Finset.univ).mulVec y := rfl
                                                        -- `eigenvalues_of_V_plus` (2) の `Λ̌_max = Λ̌_{(1,…,1)}`
    _ = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • (F.Qproj Finset.univ).mulVec y :=
        smul_mulVec_tensorPow _ _ _                     -- `scalar_multiple_factors_out_of_left_factor`（`p → 1`）
    _ = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • y := by rw [hQy]
                                                        -- 上の等式 `Q̌_{(1,…,1)}y = y`

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

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の集合の等号**: `{x | V^{(+)}x = Λ̌_max x} = im Q̌_{(1,…,1)}`。
`⊆` は `eq_Qproj_univ_mulVec_of_eigen`（`x = Q̌_{(1,…,1)}x` なので `x` 自身が `Q̌_{(1,…,1)}` の像）、
`⊇` は `VPlus_mulVec_of_mem_range_Qproj_univ`。人手の範囲 `M_col ≥ 2` を含む `M = r + 1` で述べる。 -/
theorem eigenspace_VPlus_max_eq_range_Qproj_univ {r : ℕ} (F : CheckFermiSetup (r + 1))
    (g : CheckIdx (r + 1) → ℝ) (hgpos : ∀ i, 0 < g i) {K1 K2star : ℂ} {s2 : ℝ} {c : ℂ}
    (hK1 : star K1 = K1) (hK2 : star K2star = K2star) (hs2 : 0 < s2)
    (hVeq : VPlus (r + 1) s2 K1 K2star = c • F.Vprime g) :
    {x : Conf (r + 1) → ℂ |
        (VPlus (r + 1) s2 K1 K2star).mulVec x = ((checkBigLambda F g s2 Finset.univ : ℝ) : ℂ) • x}
      = (LinearMap.range (Matrix.toLin' (F.Qproj (Finset.univ : Finset (CheckIdx (r + 1)))))
          : Set (Conf (r + 1) → ℂ)) := by
  ext x
  constructor
  · intro hx                                            -- `⊆`
    exact ⟨x, by
      rw [Matrix.toLin'_apply]
      exact (eq_Qproj_univ_mulVec_of_eigen F g hgpos hK1 hK2 hs2 hVeq hx).symm⟩
  · intro hx                                            -- `⊇`
    exact VPlus_mulVec_of_mem_range_Qproj_univ F g hK1 hK2 hs2 hVeq hx

/-- **原文 `max_eigenvalue_of_V_plus_simple` (3) の最後**: 固有空間 `im Q̌_{(1,…,1)}` の次元は `1`
（`check_joint_eigenspace_decomposition` (4)）。 -/
theorem finrank_range_Qproj_univ (F : CheckFermiSetup M) :
    ((Module.finrank ℂ
        (LinearMap.range (Matrix.toLin' (F.Qproj (Finset.univ : Finset (CheckIdx M))))) : ℕ)
      : ℂ) = 1 :=
  F.finrank_range_Qproj _

end MaxSimple

end Ising2D
