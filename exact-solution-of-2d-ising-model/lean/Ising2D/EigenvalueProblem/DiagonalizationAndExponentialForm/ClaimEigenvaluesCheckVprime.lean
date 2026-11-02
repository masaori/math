/-
# `V̌'` の固有値（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`eigenvalues_of_check_Vprime`（`evenEigen_006_claim_...`）、および
`def_check_number_operator` (2) の `X̌`, `V̌'`（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean` の
`NecSuf.pow_mul_eq_of_mul_eq_smul`（原文 Step 2）と
`NecSuf.exp_mul_eq_of_mul_eq_smul`（原文 Step 3）、
および `Ising2D/NecSuf/SimpleEigenvalue.lean` の左右反転版
（`NecSuf.mul_exp_eq_of_mul_eq_smul`。原文が区別していない
`Q̌_ε V̌' = e^ǧ Q̌_ε` の形で、後段の単純性の証明が要求する）。

**章 009 の `eigenvalues_of_Vprime` とまったく同じ必要十分版の特殊化である。**
違いは重複度で、章 009 の `2^{M-m}` が `m = M` により `1` になる。

## `γ(θ~_μ)` の扱い

原文の `γ(θ~_μ) = arccosh(γ_1(θ~_μ))`（章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `def_gamma_theta` の `θ = θ~_μ` での値）は
`Ising2D.gammaFn`（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma1LowerBound.lean`、形式化済み）で書ける。
本ファイルでは章 009 と同じく**実数の族 `g : CheckIdx M → ℝ` として受け取り**、
`γ(θ~_μ) > 0` が要るところ（章 017 の単純性）でだけ狭義正値性を仮定に加える
（`TheoremMaxEigenvalueSimple.lean` で `gammaFn` との同定と狭義正値性を証明する）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimCheckJointEigenspace
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

/-- **原文 `eigenvalues_of_check_Vprime` Step 2**: `X̌^k Q̌_ε = ǧ(ε)^k Q̌_ε`。
人手の帰納法の鎖（`k = 0` の 4 行、`k + 1` の 8 行）と 1 対 1 の calc。行列の冪は `def_exp` (1) の
`A^0 := I`・`A^{m+1} := A^m A`（mathlib の `pow_zero`・`pow_succ` が同じ形）、数の冪も同じ形で証明の中で定めている。
同じ主張の必要十分版の特殊化は `NecSuf.pow_mul_eq_of_mul_eq_smul`（`Vprime_mul_Qproj` が使う）。 -/
theorem Xop_pow_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) (k : ℕ) :
    F.Xop g ^ k * F.Qproj T = (((F.gval g T : ℝ) : ℂ)) ^ k • F.Qproj T := by
  induction k with
  | zero =>
    calc F.Xop g ^ 0 * F.Qproj T
        = 1 * F.Qproj T := by rw [pow_zero]
                                                        -- `def_exp` (1) の `A^0 := I`
      _ = F.Qproj T := identity_matrix_mul_tensorPow _
                                                        -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = (1 : ℂ) • F.Qproj T := (one_smul ℂ _).symm
                                                        -- `scalar_multiple_by_one` を右辺から左辺へ（Lean の具体版は無く、mathlib の `one_smul`）
      _ = (((F.gval g T : ℝ) : ℂ)) ^ 0 • F.Qproj T := by rw [pow_zero]
                                                        -- `ǧ(ε)^0 := 1`
  | succ k ih =>
    calc F.Xop g ^ (k + 1) * F.Qproj T
        = (F.Xop g ^ k * F.Xop g) * F.Qproj T := by rw [pow_succ]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`
      _ = F.Xop g ^ k * (F.Xop g * F.Qproj T) := Matrix.mul_assoc _ _ _
                                                        -- `mat_mult_associative`（Lean の具体版は無く、mathlib の `Matrix.mul_assoc` を 1 回）
      _ = F.Xop g ^ k * ((((F.gval g T : ℝ) : ℂ)) • F.Qproj T) := by rw [F.Xop_mul_Qproj g T]
                                                        -- Step 1
      _ = (((F.gval g T : ℝ) : ℂ)) • (F.Xop g ^ k * F.Qproj T) := mul_smul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor`
      _ = (((F.gval g T : ℝ) : ℂ)) • ((((F.gval g T : ℝ) : ℂ)) ^ k • F.Qproj T) := by rw [ih]
                                                        -- 帰納法の仮定
      _ = ((((F.gval g T : ℝ) : ℂ)) * (((F.gval g T : ℝ) : ℂ)) ^ k) • F.Qproj T := smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative`（Lean の具体版は無く、mathlib の `smul_smul`）
      _ = ((((F.gval g T : ℝ) : ℂ)) ^ k * (((F.gval g T : ℝ) : ℂ))) • F.Qproj T := by
            rw [mul_comm (((F.gval g T : ℝ) : ℂ))]
                                                        -- ℂ の積の交換律（`complex_numbers_form_a_field`）
      _ = (((F.gval g T : ℝ) : ℂ)) ^ (k + 1) • F.Qproj T := by rw [pow_succ]
                                                        -- `ǧ(ε)^{k+1} := ǧ(ε)^k ǧ(ε)`

/-- **原文 `eigenvalues_of_check_Vprime` Step 3' の帰納法**: `Q̌_ε X̌^k = ǧ(ε)^k Q̌_ε`。
人手の鎖（`k = 0` の 4 行、`k + 1` の 7 行）と 1 対 1 の calc。
同じ主張の必要十分版の特殊化は `NecSuf.mul_exp_eq_of_mul_eq_smul` の中の冪の段（`Qproj_mul_Vprime` が使う）。 -/
theorem Qproj_mul_Xop_pow (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) (k : ℕ) :
    F.Qproj T * F.Xop g ^ k = (((F.gval g T : ℝ) : ℂ)) ^ k • F.Qproj T := by
  induction k with
  | zero =>
    calc F.Qproj T * F.Xop g ^ 0
        = F.Qproj T * 1 := by rw [pow_zero]
                                                        -- `def_exp` (1) の `A^0 := I`
      _ = F.Qproj T := mul_identity_matrix_tensorPow _
                                                        -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = (1 : ℂ) • F.Qproj T := (one_smul ℂ _).symm
                                                        -- `scalar_multiple_by_one` を右辺から左辺へ（Lean の具体版は無く、mathlib の `one_smul`）
      _ = (((F.gval g T : ℝ) : ℂ)) ^ 0 • F.Qproj T := by rw [pow_zero]
                                                        -- `ǧ(ε)^0 := 1`
  | succ k ih =>
    calc F.Qproj T * F.Xop g ^ (k + 1)
        = F.Qproj T * (F.Xop g ^ k * F.Xop g) := by rw [pow_succ]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`
      _ = (F.Qproj T * F.Xop g ^ k) * F.Xop g := (Matrix.mul_assoc _ _ _).symm
                                                        -- `mat_mult_associative` を右辺から左辺へ（mathlib の `Matrix.mul_assoc`）
      _ = ((((F.gval g T : ℝ) : ℂ)) ^ k • F.Qproj T) * F.Xop g := by rw [ih]
                                                        -- 帰納法の仮定
      _ = (((F.gval g T : ℝ) : ℂ)) ^ k • (F.Qproj T * F.Xop g) := smul_mul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_left_factor`
      _ = (((F.gval g T : ℝ) : ℂ)) ^ k • ((((F.gval g T : ℝ) : ℂ)) • F.Qproj T) := by
            rw [F.Qproj_mul_Xop g T]
                                                        -- Step 1 の右から掛ける形
      _ = ((((F.gval g T : ℝ) : ℂ)) ^ k * (((F.gval g T : ℝ) : ℂ))) • F.Qproj T := smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative`（mathlib の `smul_smul`）
      _ = (((F.gval g T : ℝ) : ℂ)) ^ (k + 1) • F.Qproj T := by rw [pow_succ]
                                                        -- `ǧ(ε)^{k+1} := ǧ(ε)^k ǧ(ε)`

/-- **原文 `eigenvalues_of_check_Vprime` Step 4 の最初の鎖**: `y = Q̌_ε x` なら `Q̌_ε y = y`。
人手の 8 行（両端の `y = Q̌_ε x` の書き換えは Lean では `y` を置かずに書くので現れない）と 1 対 1 の calc。 -/
theorem Qproj_mulVec_Qproj_mulVec (T : Finset (CheckIdx M)) (x : Conf M → ℂ) :
    (F.Qproj T).mulVec ((F.Qproj T).mulVec x) = (F.Qproj T).mulVec x :=
  calc (F.Qproj T).mulVec ((F.Qproj T).mulVec x)
      = (F.Qproj T * F.Qproj T).mulVec x := Matrix.mulVec_mulVec _ _ _
                                                        -- `mat_mult_associative`（`q → 1`）を右辺から左辺へ。Lean の数ベクトルは
                                                        -- 1 列の行列ではなく `Conf M → ℂ` なので、mathlib の `Matrix.mulVec_mulVec`
    _ = ((1 * F.Qproj T) * F.Qproj T).mulVec x := by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
    _ = ((F.Qproj T ^ 0 * F.Qproj T) * F.Qproj T).mulVec x := by rw [pow_zero]
                                                        -- `def_exp` (1) の `A^0 := I`
    _ = (F.Qproj T ^ 1 * F.Qproj T).mulVec x := by rw [← pow_succ]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`（`m = 0`）
    _ = (F.Qproj T ^ 2).mulVec x := by rw [← pow_succ]
                                                        -- `def_exp` (1) の `A^{m+1} := A^m A`（`m = 1`）
    _ = (F.Qproj T).mulVec x := by rw [sq, F.Qproj_mul_self T]
                                                        -- `check_joint_eigenspace_decomposition` (1) の `Q̌_ε^2 = Q̌_ε`
                                                        -- （Lean の `Qproj_mul_self` は `Q̌_ε Q̌_ε = Q̌_ε` の形なので mathlib の `sq` で読み替える）

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
