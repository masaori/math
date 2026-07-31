/-
# `tr(ε V^{(+)})` を `η_{(1,…,1)}` で表す（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_003_claim_trace_epsilon_V_plus_via_eigenvalues`、
ラベル **`trace_of_epsilon_V_plus_via_check_eigenvalues`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）の
`Ising2D.NecSuf.sum_powerset_signed_exp`。本ファイルの Step 2 はその**系**である。

## 章 017 から受け取る入力

原文 `eigenvalues_of_V_plus` は

  `V^{(+)} Q̌_ε = Λ̌_ε Q̌_ε`,
  `Λ̌_ε = (2 sinh 2K_2)^{M/2} exp(∑_μ γ(θ̃_μ)(ε_μ - 1/2))`

を主張する（章 017、Lean 未形式化）。これを構造 `Ising2D.VPlusData` として受け取る。
`C = (2 sinh 2K_2)^{M/2} > 0` と `γ(θ̃_μ) > 0`（原文 `def_gamma_theta_tilde_mu`、
章 015 の `gamma1_gt_1_theta_tilde` の帰結）も仮定に含める。
**`γ(θ̃_μ) > 0` が半整数運動量に固有の要点であり、これがあるので `sinh` の積が `0` にならない。**
-/
import Ising2D.Part018.Claim002_EpsilonEigenvalueOnQ

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- 原文 `eigenvalues_of_V_plus` の `Λ̌_ε`。 -/
noncomputable def checkLambda (C : ℝ) (gam : Fin M → ℝ) (T : Finset (Fin M)) : ℝ :=
  C * Real.exp (∑ μ : Fin M, gam μ * ((if μ ∈ T then (1 : ℝ) else 0) - 1 / 2))

theorem checkLambda_pos {C : ℝ} (hC : 0 < C) (gam : Fin M → ℝ) (T : Finset (Fin M)) :
    0 < checkLambda C gam T := by
  unfold checkLambda
  positivity

/-- `Λ̌_ε ≤ Λ̌_{(1,…,1)}`（原文 `eigenvalues_of_V_plus` (2)）。 -/
theorem checkLambda_le_univ {C : ℝ} (hC : 0 < C) {gam : Fin M → ℝ} (hgam : ∀ μ, 0 < gam μ)
    (T : Finset (Fin M)) : checkLambda C gam T ≤ checkLambda C gam Finset.univ := by
  unfold checkLambda
  refine mul_le_mul_of_nonneg_left (Real.exp_le_exp.2 ?_) hC.le
  refine Finset.sum_le_sum fun μ _ => ?_
  by_cases h : μ ∈ T
  · simp [h]
  · rw [if_neg h, if_pos (Finset.mem_univ μ)]
    nlinarith [hgam μ]

/-- `T ≠ (1,…,1)` なら **狭義に** `Λ̌_ε < Λ̌_{(1,…,1)}`（最大固有値の単純性の根拠）。 -/
theorem checkLambda_lt_univ {C : ℝ} (hC : 0 < C) {gam : Fin M → ℝ} (hgam : ∀ μ, 0 < gam μ)
    {T : Finset (Fin M)} (hT : T ≠ Finset.univ) :
    checkLambda C gam T < checkLambda C gam Finset.univ := by
  obtain ⟨ν, hν⟩ : ∃ ν : Fin M, ν ∉ T := by
    by_contra hc
    push_neg at hc
    exact hT (Finset.eq_univ_of_forall hc)
  unfold checkLambda
  refine mul_lt_mul_of_pos_left (Real.exp_lt_exp.2 ?_) hC
  refine Finset.sum_lt_sum (fun μ _ => ?_) ⟨ν, Finset.mem_univ ν, ?_⟩
  · by_cases h : μ ∈ T
    · simp [h]
    · rw [if_neg h, if_pos (Finset.mem_univ μ)]
      nlinarith [hgam μ]
  · rw [if_neg hν, if_pos (Finset.mem_univ ν)]
    nlinarith [hgam ν]

/-- **章 017 `eigenvalues_of_V_plus` から受け取る入力**。 -/
structure VPlusData (M : ℕ) (F : CheckFermi M) where
  /-- `V^{(+)}` -/
  V : TensorPow M
  /-- `(2 sinh 2K_2)^{M/2}` -/
  C : ℝ
  hC : 0 < C
  /-- `γ(θ̃_μ)` -/
  gam : Fin M → ℝ
  hgam : ∀ μ, 0 < gam μ
  hV : ∀ T : Finset (Fin M),
    V * F.Qproj T = ((checkLambda C gam T : ℝ) : ℂ) • F.Qproj T

namespace VPlusData

variable {F : CheckFermi M} (D : VPlusData M F)

/-- `Λ̌_{max} = Λ̌_{(1,…,1)}`。 -/
noncomputable def lamMax : ℝ := checkLambda D.C D.gam (Finset.univ : Finset (Fin M))

theorem lamMax_pos : 0 < D.lamMax := checkLambda_pos D.hC D.gam _

theorem checkLambda_le_lamMax (T : Finset (Fin M)) : checkLambda D.C D.gam T ≤ D.lamMax :=
  checkLambda_le_univ D.hC D.hgam T

/-! ## Step 1: トレースの分解 -/

theorem epsilon_mul_V_mul_Qproj (T : Finset (Fin M)) :
    epsilon M * D.V * F.Qproj T
      = (F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ)) • F.Qproj T := by
  calc epsilon M * D.V * F.Qproj T = epsilon M * (D.V * F.Qproj T) := by rw [mul_assoc]
    _ = epsilon M * (((checkLambda D.C D.gam T : ℝ) : ℂ) • F.Qproj T) := by rw [D.hV T]
    _ = ((checkLambda D.C D.gam T : ℝ) : ℂ) • (epsilon M * F.Qproj T) := by
        rw [mul_smul_comm]
    _ = ((checkLambda D.C D.gam T : ℝ) : ℂ) • (F.eta T • F.Qproj T) := by
        rw [F.epsilon_mul_Qproj T]
    _ = (F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ)) • F.Qproj T := by
        rw [smul_smul, mul_comm]

/-- **人手証明 Step 1**: `tr(εV^{(+)}) = ∑_ε η_ε Λ̌_ε`。 -/
theorem trace_epsilon_mul_V_eq_sum :
    (epsilon M * D.V).trace
      = ∑ T : Finset (Fin M), F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ) := by
  have hdecomp : epsilon M * D.V
      = ∑ T : Finset (Fin M), (epsilon M * D.V * F.Qproj T) := by
    rw [← Finset.mul_sum, F.sum_Qproj, mul_one]
  rw [hdecomp, Matrix.trace_sum]
  refine Finset.sum_congr rfl fun T _ => ?_
  rw [D.epsilon_mul_V_mul_Qproj T, Matrix.trace_smul, F.trace_Qproj T, smul_eq_mul, mul_one]

/-! ## Step 2: 積への分解 -/

/-- 人手証明 Step 2 の右辺の実数因子 `(2 sinh 2K_2)^{M/2} ∏_μ 2 sinh(γ(θ̃_μ)/2)`。 -/
noncomputable def traceFactor : ℝ := D.C * ∏ μ : Fin M, (2 * Real.sinh (D.gam μ / 2))

/-- **人手証明 Step 3**: 右辺の `η` 以外の因子はすべて正。 -/
theorem traceFactor_pos : 0 < D.traceFactor := by
  unfold traceFactor
  refine mul_pos D.hC (Finset.prod_pos fun μ _ => ?_)
  have := D.hgam μ
  have hs : 0 < Real.sinh (D.gam μ / 2) := Real.sinh_pos_iff.2 (by linarith)
  linarith

/-- **人手証明 `trace_of_epsilon_V_plus_via_check_eigenvalues` そのもの**:

  `tr(εV^{(+)}) = η_{(1,…,1)} (2 sinh 2K_2)^{M/2} ∏_μ 2 sinh(γ(θ̃_μ)/2)`。 -/
theorem trace_epsilon_mul_V :
    (epsilon M * D.V).trace = F.eta Finset.univ * ((D.traceFactor : ℝ) : ℂ) := by
  rw [D.trace_epsilon_mul_V_eq_sum]
  have hreal : ∀ T : Finset (Fin M),
      F.eta T * ((checkLambda D.C D.gam T : ℝ) : ℂ)
        = F.eta Finset.univ * (((-1 : ℝ) ^ (M - T.card)
            * checkLambda D.C D.gam T : ℝ) : ℂ) := by
    intro T
    rw [F.eta_eq_eta_univ_mul T]
    push_cast
    ring
  rw [Finset.sum_congr rfl (fun T _ => hreal T), ← Finset.mul_sum]
  congr 1
  rw [← Complex.ofReal_sum]
  congr 1
  -- 実数の等式に落とす
  have hcard : (Finset.univ : Finset (Fin M)).card = M := by simp
  have hkey := NecSuf.sum_powerset_signed_exp (Finset.univ : Finset (Fin M)) D.gam
  rw [Finset.powerset_univ, hcard] at hkey
  unfold traceFactor checkLambda
  rw [← hkey, Finset.mul_sum]
  exact Finset.sum_congr rfl fun T _ => by ring

/-- **人手証明の最後の同値**: `η_{(1,…,1)} = +1 ⟺ tr(εV^{(+)}) > 0`（の一方向）。 -/
theorem eta_univ_eq_one_of_trace_pos (h : 0 < ((epsilon M * D.V).trace).re) :
    F.eta (Finset.univ : Finset (Fin M)) = 1 := by
  rcases F.eta_mem (Finset.univ : Finset (Fin M)) with hη | hη
  · exact hη
  · exfalso
    rw [D.trace_epsilon_mul_V, hη] at h
    simp only [neg_mul, one_mul, Complex.neg_re, Complex.ofReal_re] at h
    have := D.traceFactor_pos
    linarith

end VPlusData

end Ising2D
