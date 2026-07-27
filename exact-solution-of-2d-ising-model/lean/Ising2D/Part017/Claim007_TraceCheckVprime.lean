/-
# `tr(V̌') = tr((V̌')^{-1}) > 0`（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`trace_of_check_Vprime`（`evenEigen_007_claim_...`）。

**抽象版は置かない。** 使っている一般論はトレースの線型性（既に
`Ising2D/Abstract/NumberOperator.lean` の「加法的かつ巡回的な汎関数 `τ`」として
抽象化してある）と、実数の指数法則・`cosh` の偶関数性だけで、
取り払える構造が残っていない。

## 章 009 との違い

章 009 の `trace_of_Vprime` は `tr(V') = 2^{M-m} ∏_μ 2cosh(γ_μ/2)` だった。
半整数運動量では `m = M` なので**前因子 `2^{M-m}` が消える**
（`tr(Q̌_ε) = 1` になったことの直接の帰結）。
-/
import Ising2D.Part017.Claim006_EigenvaluesCheckVprime

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- `V̌'` を単元として取り出したもの（原文 `def_check_Vprime` (2) の可逆性）。 -/
noncomputable def VprimeUnits (g : CheckIdx M → ℝ) : (TensorPow M)ˣ := matExpUnits (F.Xop g)

@[simp]
theorem VprimeUnits_val (g : CheckIdx M → ℝ) :
    ((F.VprimeUnits g : (TensorPow M)ˣ) : TensorPow M) = F.Vprime g := rfl

/-- **原文 `trace_of_check_Vprime` の `(V̌')^{-1} = exp(-X̌)`**。 -/
theorem VprimeUnits_inv (g : CheckIdx M → ℝ) :
    (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M)
      = F.Vprime (fun i => -(g i)) := by
  rw [VprimeUnits, matExpUnits_inv, Vprime, F.Xop_neg g]

theorem Vprime_mul_Vprime_neg (g : CheckIdx M → ℝ) :
    F.Vprime g * F.Vprime (fun i => -(g i)) = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).mul_inv

theorem Vprime_neg_mul_Vprime (g : CheckIdx M → ℝ) :
    F.Vprime (fun i => -(g i)) * F.Vprime g = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).inv_mul

/-- 各因子の展開: `exp(ǧ(ε)) = ∏_μ (μ ∈ T ? e^{γ_μ/2} : e^{-γ_μ/2})`。 -/
theorem exp_gval_eq_prod (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    Real.exp (F.gval g T)
      = ∏ i : CheckIdx M, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))) := by
  rw [gval, Real.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  by_cases hT : i ∈ T <;> simp [hT] <;> ring_nf

/-- **原文 `trace_of_check_Vprime` Step 2**:
`∑_ε e^{ǧ(ε)} = ∏_μ 2 cosh(γ(θ~_μ)/2)`。 -/
theorem sum_exp_gval (g : CheckIdx M → ℝ) :
    ∑ T : Finset (CheckIdx M), Real.exp (F.gval g T)
      = ∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) := by
  classical
  have hprod : ∏ i : CheckIdx M, (Real.exp (g i / 2) + Real.exp (-(g i / 2)))
      = ∑ T ∈ (Finset.univ : Finset (CheckIdx M)).powerset,
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) :=
    Finset.prod_add _ _ _
  have hsplit : ∀ T : Finset (CheckIdx M),
      (∏ i : CheckIdx M, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))))
        = (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) := by
    intro T
    rw [Finset.prod_ite]
    congr 1
    · congr 1
      ext i
      simp
    · congr 1
      ext i
      simp [Finset.mem_sdiff]
  calc ∑ T : Finset (CheckIdx M), Real.exp (F.gval g T)
      = ∑ T : Finset (CheckIdx M),
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.exp_gval_eq_prod g T, hsplit T]
    _ = ∏ i : CheckIdx M, (Real.exp (g i / 2) + Real.exp (-(g i / 2))) := by
        rw [hprod, Finset.powerset_univ]
    _ = ∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) := by
        refine Finset.prod_congr rfl fun i _ => ?_
        rw [Real.cosh_eq]
        ring

/-- **原文 `trace_of_check_Vprime` Step 1〜2**:
`tr(V̌') = ∏_μ 2 cosh(γ(θ~_μ)/2)`（**前因子 `2^{M-m}` は無い**）。 -/
theorem trace_Vprime (g : CheckIdx M → ℝ) :
    (F.Vprime g).trace = ((∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by
  classical
  calc (F.Vprime g).trace
      = (∑ T : Finset (CheckIdx M), F.Vprime g * F.Qproj T).trace := by
        rw [← Finset.mul_sum, F.sum_Qproj, mul_one]
    _ = ∑ T : Finset (CheckIdx M), (F.Vprime g * F.Qproj T).trace := Matrix.trace_sum _ _
    _ = ∑ T : Finset (CheckIdx M), ((Real.exp (F.gval g T) : ℝ) : ℂ) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.Vprime_mul_Qproj g T, Matrix.trace_smul, F.trace_Qproj T, smul_eq_mul, mul_one]
    _ = ((∑ T : Finset (CheckIdx M), Real.exp (F.gval g T) : ℝ) : ℂ) := by push_cast; ring
    _ = ((∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by rw [F.sum_exp_gval g]

/-- **原文 `trace_of_check_Vprime` Step 3**: `tr((V̌')^{-1}) = tr(V̌')`（`cosh` が偶関数）。 -/
theorem trace_Vprime_inv (g : CheckIdx M → ℝ) :
    (F.Vprime (fun i => -(g i))).trace = (F.Vprime g).trace := by
  rw [F.trace_Vprime, F.trace_Vprime]
  norm_cast
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [show -(g i) / 2 = -(g i / 2) by ring, Real.cosh_neg]

/-- **原文 `trace_of_check_Vprime` Step 4**: `tr(V̌') > 0`（`cosh ≥ 1`）。 -/
theorem trace_Vprime_pos (g : CheckIdx M → ℝ) :
    ∃ r : ℝ, 0 < r ∧ (F.Vprime g).trace = (r : ℂ) := by
  refine ⟨∏ i : CheckIdx M, (2 * Real.cosh (g i / 2)), ?_, F.trace_Vprime g⟩
  refine Finset.prod_pos fun i _ => ?_
  have : (0 : ℝ) < Real.cosh (g i / 2) := Real.cosh_pos _
  linarith

end CheckFermiSetup

end Ising2D
