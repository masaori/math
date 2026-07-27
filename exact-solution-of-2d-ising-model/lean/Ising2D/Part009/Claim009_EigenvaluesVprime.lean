/-
# `V'` の固有値とトレース（具体版）

対応する人手証明（`structured-latex/content/009_eigenvalues_of_V.ts`）:
- `eigenvalues_of_Vprime`（`eigenvalues_of_V_009_claim_eigenvalues_of_Vprime`）
- `trace_of_Vprime`（`eigenvalues_of_V_010_claim_trace_of_Vprime`）

抽象版は `Ising2D/Abstract/JointEigenspace.lean` の
`Abstract.pow_mul_eq_of_mul_eq_smul`（原文 Step 2）と
`Abstract.exp_mul_eq_of_mul_eq_smul`（原文 Step 3）。

## `γ(θ_μ)` の扱い

原文の `γ(θ_μ) = arccosh(γ_1(θ_μ))` は mathlib に `Real.arccosh` が無いので、
**非負実数の族 `g : 𝓘 → ℝ` として仮定に持つ**（本章が `γ` について使うのは
`γ(θ_μ) ≥ 0` だけである）。`g` が実際に `arccosh(γ_1(θ_μ))` であることは
008 章の `def_gamma_theta_mu` の内容であり、本章の結論には効かない。
-/
import Ising2D.Part009.Claim008_JointEigenspace
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Exponential

namespace Ising2D

open Matrix

namespace FermiSetup

variable {M : ℕ} {K : IsingConst} (F : FermiSetup M K)

/-- **原文 `def_number_operator` の `X`**:
`X = ∑_{μ∈𝓘} γ(θ_μ)(n_μ - (1/2) I)`。 -/
noncomputable def Xop (g : F.Idx → ℝ) : TensorPow M :=
  ∑ i : F.Idx, ((g i : ℂ)) • (F.nOp i - (1 / 2 : ℂ) • 1)

/-- **原文 `def_Vprime` の `V' = exp(X)`**。 -/
noncomputable def Vprime (g : F.Idx → ℝ) : TensorPow M := matExp (F.Xop g)

/-- **原文 `eigenvalues_of_Vprime` の `g(ε)`**:
`g(ε) = ∑_{μ∈𝓘} γ(θ_μ)(ε_μ - 1/2)`。 -/
noncomputable def gval (g : F.Idx → ℝ) (T : Finset F.Idx) : ℝ :=
  ∑ i : F.Idx, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)

theorem Xop_neg (g : F.Idx → ℝ) : F.Xop (fun i => -(g i)) = -F.Xop g := by
  simp only [Xop, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Complex.ofReal_neg, neg_smul]

theorem gval_neg (g : F.Idx → ℝ) (T : Finset F.Idx) :
    F.gval (fun i => -(g i)) T = -F.gval g T := by
  simp only [gval, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  ring

/-- **原文 `eigenvalues_of_Vprime` Step 1**: `X Q_ε = g(ε) Q_ε`。 -/
theorem Xop_mul_Qproj (g : F.Idx → ℝ) (T : Finset F.Idx) :
    F.Xop g * F.Qproj T = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  rw [Xop, Finset.sum_mul]
  have hterm : ∀ i : F.Idx,
      ((g i : ℂ)) • (F.nOp i - (1 / 2 : ℂ) • 1) * F.Qproj T
        = ((g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2) : ℝ) : ℂ) • F.Qproj T := by
    intro i
    simp only [sub_mul, smul_mul_assoc, one_mul]
    rw [F.nOp_mul_Qproj i T, ← sub_smul, smul_smul]
    congr 1
    by_cases hT : i ∈ T <;> simp [hT] <;> push_cast <;> ring
  rw [Finset.sum_congr rfl fun i _ => hterm i, gval]
  push_cast
  rw [Finset.sum_smul]

set_option backward.isDefEq.respectTransparency false in
/-- **原文 `eigenvalues_of_Vprime` Step 3**: `V' Q_ε = e^{g(ε)} Q_ε`。

`NormedSpace.exp` を扱うために mathlib の `Matrix.exp_*` と同じく
`Norms.Operator`（行列の作用素ノルム）を局所的に開く。 -/
theorem Vprime_mul_Qproj (g : F.Idx → ℝ) (T : Finset F.Idx) :
    F.Vprime g * F.Qproj T = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  have h : NormedSpace.exp (F.Xop g) * F.Qproj T
      = Complex.exp ((F.gval g T : ℝ) : ℂ) • F.Qproj T :=
    open scoped Norms.Operator in
      Abstract.exp_mul_eq_of_mul_eq_smul (F.Xop_mul_Qproj g T)
  rw [Vprime, matExp, h, Complex.ofReal_exp]

/-- **原文 `eigenvalues_of_Vprime` Step 4**: `im Q_ε` の元は固有値 `e^{g(ε)}` の固有ベクトル。 -/
theorem Vprime_mulVec_of_mem_range (g : F.Idx → ℝ) (T : Finset F.Idx) (x : Conf M → ℂ) :
    (F.Vprime g).mulVec ((F.Qproj T).mulVec x)
      = ((Real.exp (F.gval g T) : ℝ) : ℂ) • ((F.Qproj T).mulVec x) := by
  rw [Matrix.mulVec_mulVec, F.Vprime_mul_Qproj g T, Matrix.smul_mulVec]

/-- **原文 `eigenvalues_of_Vprime` 最後**: 固有値はすべて正の実数。 -/
theorem exp_gval_pos (g : F.Idx → ℝ) (T : Finset F.Idx) : 0 < Real.exp (F.gval g T) :=
  Real.exp_pos _

/-! ## `V'` の可逆性とトレース（原文 `trace_of_Vprime`） -/

/-- **原文 `trace_of_Vprime` Step 1**: `V'` を単元として取り出したもの。 -/
noncomputable def VprimeUnits (g : F.Idx → ℝ) : (TensorPow M)ˣ := matExpUnits (F.Xop g)

@[simp]
theorem VprimeUnits_val (g : F.Idx → ℝ) :
    ((F.VprimeUnits g : (TensorPow M)ˣ) : TensorPow M) = F.Vprime g := rfl

/-- **原文 `trace_of_Vprime` Step 1**: `V'^{-1} = exp(-X)`。 -/
theorem VprimeUnits_inv (g : F.Idx → ℝ) :
    (((F.VprimeUnits g)⁻¹ : (TensorPow M)ˣ) : TensorPow M) = F.Vprime (fun i => -(g i)) := by
  rw [VprimeUnits, matExpUnits_inv, Vprime, F.Xop_neg g]

theorem Vprime_mul_Vprime_neg (g : F.Idx → ℝ) :
    F.Vprime g * F.Vprime (fun i => -(g i)) = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).mul_inv

theorem Vprime_neg_mul_Vprime (g : F.Idx → ℝ) :
    F.Vprime (fun i => -(g i)) * F.Vprime g = 1 := by
  rw [← F.VprimeUnits_val g, ← F.VprimeUnits_inv g]
  exact_mod_cast (F.VprimeUnits g).inv_mul

/-- 各因子の展開: `exp(g(ε)) = ∏_μ (μ ∈ T ? e^{γ_μ/2} : e^{-γ_μ/2})`。 -/
theorem exp_gval_eq_prod (g : F.Idx → ℝ) (T : Finset F.Idx) :
    Real.exp (F.gval g T)
      = ∏ i : F.Idx, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))) := by
  rw [gval, Real.exp_sum]
  refine Finset.prod_congr rfl fun i _ => ?_
  by_cases hT : i ∈ T <;> simp [hT] <;> ring_nf

/-- **原文 `trace_of_Vprime` Step 3**: `∑_ε e^{g(ε)} = ∏_μ 2 cosh(γ(θ_μ)/2)`。 -/
theorem sum_exp_gval (g : F.Idx → ℝ) :
    ∑ T : Finset F.Idx, Real.exp (F.gval g T)
      = ∏ i : F.Idx, (2 * Real.cosh (g i / 2)) := by
  classical
  have hprod : ∏ i : F.Idx, (Real.exp (g i / 2) + Real.exp (-(g i / 2)))
      = ∑ T ∈ (Finset.univ : Finset F.Idx).powerset,
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) :=
    Finset.prod_add _ _ _
  have hsplit : ∀ T : Finset F.Idx,
      (∏ i : F.Idx, (if i ∈ T then Real.exp (g i / 2) else Real.exp (-(g i / 2))))
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
  calc ∑ T : Finset F.Idx, Real.exp (F.gval g T)
      = ∑ T : Finset F.Idx,
          (∏ i ∈ T, Real.exp (g i / 2)) * ∏ i ∈ Finset.univ \ T, Real.exp (-(g i / 2)) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.exp_gval_eq_prod g T, hsplit T]
    _ = ∏ i : F.Idx, (Real.exp (g i / 2) + Real.exp (-(g i / 2))) := by
        rw [hprod, Finset.powerset_univ]
    _ = ∏ i : F.Idx, (2 * Real.cosh (g i / 2)) := by
        refine Finset.prod_congr rfl fun i _ => ?_
        rw [Real.cosh_eq]
        ring

/-- **原文 `trace_of_Vprime` Step 2〜3**:
`tr(V') = 2^{M-m} ∏_μ 2 cosh(γ(θ_μ)/2)`。 -/
theorem trace_Vprime (g : F.Idx → ℝ) :
    (F.Vprime g).trace
      = ((2 ^ (M - F.I.card) : ℕ) : ℂ) * ((∏ i : F.Idx, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by
  classical
  calc (F.Vprime g).trace
      = (∑ T : Finset F.Idx, F.Vprime g * F.Qproj T).trace := by
        rw [← Finset.mul_sum, F.sum_Qproj, mul_one]
    _ = ∑ T : Finset F.Idx, (F.Vprime g * F.Qproj T).trace := Matrix.trace_sum _ _
    _ = ∑ T : Finset F.Idx,
          ((Real.exp (F.gval g T) : ℝ) : ℂ) * ((2 ^ (M - F.I.card) : ℕ) : ℂ) := by
        refine Finset.sum_congr rfl fun T _ => ?_
        rw [F.Vprime_mul_Qproj g T, Matrix.trace_smul, F.trace_Qproj T, smul_eq_mul]
    _ = ((2 ^ (M - F.I.card) : ℕ) : ℂ)
          * ((∑ T : Finset F.Idx, Real.exp (F.gval g T) : ℝ) : ℂ) := by
        rw [← Finset.sum_mul]
        push_cast
        ring
    _ = ((2 ^ (M - F.I.card) : ℕ) : ℂ)
          * ((∏ i : F.Idx, (2 * Real.cosh (g i / 2)) : ℝ) : ℂ) := by
        rw [F.sum_exp_gval g]

/-- **原文 `trace_of_Vprime` Step 4**: `tr(V'^{-1}) = tr(V')`（`cosh` が偶関数）。 -/
theorem trace_Vprime_inv (g : F.Idx → ℝ) :
    (F.Vprime (fun i => -(g i))).trace = (F.Vprime g).trace := by
  rw [F.trace_Vprime, F.trace_Vprime]
  congr 2
  refine Finset.prod_congr rfl fun i _ => ?_
  rw [show -(g i) / 2 = -(g i / 2) by ring, Real.cosh_neg]

/-- **原文 `trace_of_Vprime` Step 5**: `tr(V') > 0`（`γ ≥ 0` と `cosh ≥ 1`）。 -/
theorem trace_Vprime_pos (g : F.Idx → ℝ) :
    ∃ r : ℝ, 0 < r ∧ (F.Vprime g).trace = (r : ℂ) := by
  refine ⟨(2 ^ (M - F.I.card) : ℕ) * ∏ i : F.Idx, (2 * Real.cosh (g i / 2)), ?_, ?_⟩
  · have hpos : (0 : ℝ) < ∏ i : F.Idx, (2 * Real.cosh (g i / 2)) := by
      refine Finset.prod_pos fun i _ => ?_
      have : (0 : ℝ) < Real.cosh (g i / 2) := Real.cosh_pos _
      linarith
    have : (0 : ℝ) < ((2 ^ (M - F.I.card) : ℕ) : ℝ) := by positivity
    exact mul_pos this hpos
  · rw [F.trace_Vprime g]
    push_cast
    ring

end FermiSetup

end Ising2D
