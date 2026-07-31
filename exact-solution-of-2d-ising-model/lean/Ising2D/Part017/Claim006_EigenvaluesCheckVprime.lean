/-
# `V̌'` の固有値（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`eigenvalues_of_check_Vprime`（`evenEigen_006_claim_...`）、および
`def_check_number_operator` (2) の `X̌`, `V̌'`。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean` の
`NecSuf.pow_mul_eq_of_mul_eq_smul`（原文 Step 2）と
`NecSuf.exp_mul_eq_of_mul_eq_smul`（原文 Step 3）、
および `Ising2D/NecSuf/SimpleEigenvalue.lean` の左右反転版
（`NecSuf.mul_exp_eq_of_mul_eq_smul`。原文が区別していない
`Q̌_ε V̌' = e^ǧ Q̌_ε` の形で、後段の単純性の証明が要求する）。

**章 009 の `eigenvalues_of_Vprime` とまったく同じ必要十分版の特殊化である。**
違いは重複度で、章 009 の `2^{M-m}` が `m = M` により `1` になる。

## `γ(θ~_μ)` の扱い

原文の `γ(θ~_μ) = arccosh(γ_1(θ~_μ))`（章 015 `def_gamma_theta_tilde_mu`）は
`Ising2D.gammaFn`（`Part012/Claim001_Gamma1LowerBound.lean`、形式化済み）で書ける。
本ファイルでは章 009 と同じく**実数の族 `g : CheckIdx M → ℝ` として受け取り**、
`γ(θ~_μ) > 0` が要るところ（章 017 の単純性）でだけ狭義正値性を仮定に加える
（`Theorem011_MaxEigenvalueSimple.lean` で `gammaFn` との同定と狭義正値性を証明する）。
-/
import Ising2D.Part017.Claim005_CheckJointEigenspace
import Ising2D.NecSuf.SimpleEigenvalue

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- **原文 `def_check_number_operator` (2) の `X̌`**:
`X̌ = ∑_{μ∈𝓜̌} γ(θ~_μ)(ň_μ - (1/2) I)`。 -/
noncomputable def Xop (g : CheckIdx M → ℝ) : TensorPow M :=
  ∑ i : CheckIdx M, ((g i : ℂ)) • (F.nOp i - (1 / 2 : ℂ) • 1)

/-- **原文 `def_check_Vprime` の `V̌' = exp(X̌)`**。 -/
noncomputable def Vprime (g : CheckIdx M → ℝ) : TensorPow M := matExp (F.Xop g)

/-- **原文 `eigenvalues_of_check_Vprime` の `ǧ(ε)`**:
`ǧ(ε) = ∑_{μ=1}^{M} γ(θ~_μ)(ε_μ - 1/2)`。

（`ǧ` の値は `F` に依らないが、`F.gval g T` と書けるように `F` を引数に取る。） -/
noncomputable def gval (_F : CheckFermiSetup M) (g : CheckIdx M → ℝ)
    (T : Finset (CheckIdx M)) : ℝ :=
  ∑ i : CheckIdx M, g i * ((if i ∈ T then (1 : ℝ) else 0) - 1 / 2)

theorem Xop_neg (g : CheckIdx M → ℝ) : F.Xop (fun i => -(g i)) = -F.Xop g := by
  simp only [Xop, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  rw [Complex.ofReal_neg, neg_smul]

theorem gval_neg (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.gval (fun i => -(g i)) T = -F.gval g T := by
  simp only [gval, ← Finset.sum_neg_distrib]
  refine Finset.sum_congr rfl fun i _ => ?_
  ring

/-- **原文 `eigenvalues_of_check_Vprime` Step 1**: `X̌ Q̌_ε = ǧ(ε) Q̌_ε`。 -/
theorem Xop_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Xop g * F.Qproj T = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  rw [Xop, Finset.sum_mul]
  have hterm : ∀ i : CheckIdx M,
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

/-- 左右を入れ替えた形 `Q̌_ε X̌ = ǧ(ε) Q̌_ε`（`X̌` と `Q̌_ε` が可換であることによる）。 -/
theorem Qproj_mul_Xop (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Xop g = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  have hcomm : Commute (F.Xop g) (F.Qproj T) := by
    refine Commute.sum_left _ _ _ fun i _ => ?_
    refine Commute.smul_left ?_ _
    refine Commute.sub_left (F.commute_nOp_Qproj i T) ?_
    exact Commute.smul_left (Commute.one_left _) _
  rw [← hcomm.eq, F.Xop_mul_Qproj g T]

set_option backward.isDefEq.respectTransparency false in
/-- **原文 `eigenvalues_of_check_Vprime` Step 3**: `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`。 -/
theorem Vprime_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Vprime g * F.Qproj T = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  have h : NormedSpace.exp (F.Xop g) * F.Qproj T
      = Complex.exp ((F.gval g T : ℝ) : ℂ) • F.Qproj T :=
    open scoped Norms.Operator in
      NecSuf.exp_mul_eq_of_mul_eq_smul (F.Xop_mul_Qproj g T)
  rw [Vprime, matExp, h, Complex.ofReal_exp]

set_option backward.isDefEq.respectTransparency false in
/-- 左右を入れ替えた形 `Q̌_ε V̌' = e^{ǧ(ε)} Q̌_ε`（単純性の証明で使う）。 -/
theorem Qproj_mul_Vprime (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Vprime g = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  have h : F.Qproj T * NormedSpace.exp (F.Xop g)
      = Complex.exp ((F.gval g T : ℝ) : ℂ) • F.Qproj T :=
    open scoped Norms.Operator in
      NecSuf.mul_exp_eq_of_mul_eq_smul (F.Qproj_mul_Xop g T)
  rw [Vprime, matExp, h, Complex.ofReal_exp]

/-- **原文 `eigenvalues_of_check_Vprime` Step 4**:
`im Q̌_ε` の元は固有値 `e^{ǧ(ε)}` の固有ベクトル。 -/
theorem Vprime_mulVec_of_mem_range (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M))
    (x : Conf M → ℂ) :
    (F.Vprime g).mulVec ((F.Qproj T).mulVec x)
      = ((Real.exp (F.gval g T) : ℝ) : ℂ) • ((F.Qproj T).mulVec x) := by
  rw [Matrix.mulVec_mulVec, F.Vprime_mul_Qproj g T, Matrix.smul_mulVec]

/-- **原文 `eigenvalues_of_check_Vprime` 最後**: 固有値はすべて正の実数。 -/
theorem exp_gval_pos (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    0 < Real.exp (F.gval g T) := Real.exp_pos _

end CheckFermiSetup

end Ising2D
