/-
# `V̌'` の固有値（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`eigenvalues_of_check_Vprime`（`evenEigen_006_claim_...`）、および
`def_check_number_operator` (2) の `X̌`, `V̌'`（正本は `structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts`）。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean` の
`NecSuf.pow_mul_eq_of_mul_eq_smul`（原文 Step 2）と
`NecSuf.exp_mul_eq_of_mul_eq_smul`（原文 Step 3）、
および `Ising2D/NecSuf/SimpleEigenvalue.lean` の左右反転版
（`NecSuf.mul_exp_eq_of_mul_eq_smul`。原文 Step 3' の `Q̌_ε V̌' = e^ǧ Q̌_ε` の形で、後段の単純性の証明が要求する）。
Step 3・Step 3' の具体版 `Vprime_mul_Qproj`・`Qproj_mul_Vprime` は人手の極限の鎖と 1 対 1 の calc で示し、
同じ主張を必要十分版の特殊化として得る導出は同じフォルダの `ClaimEigenvaluesCheckVprimeFromNecSuf.lean` に置く。

必要十分版は章 009 の `eigenvalues_of_Vprime` と同じである（このファイルの具体版は必要十分版を引かず、特殊化は FromNecSuf の側に置く）。違いは重複度で、章 009 の `2^{M-m}` が `m = M` により `1` になる。

## `γ(θ~_μ)` の扱い

原文の `γ(θ~_μ) = arccosh(γ_1(θ~_μ))`（章「A(θ~_μ) の対角化と V^{(+)} の指数表示」の `def_gamma_theta` の `θ = θ~_μ` での値）は
`Ising2D.gammaFn`（`EigenvalueProblem/DiagonalizationAndExponentialForm/ClaimGamma1LowerBound.lean`、形式化済み）で書ける。
本ファイルでは章 009 と同じく**実数の族 `g : CheckIdx M → ℝ` として受け取り**、
`γ(θ~_μ) > 0` が要るところ（章 017 の単純性）でだけ狭義正値性を仮定に加える
（`TheoremMaxEigenvalueSimple.lean` で `gammaFn` との同定と狭義正値性を証明する）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimCheckJointEigenspace
import Ising2D.NecSuf.SimpleEigenvalue
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultiplesOfOneMatrixFromNecSuf
import Ising2D.MathematicalTools.VectorAndMatrixNormsAndConvergence.ClaimContinuityOfProductsAndScalarMultiplesFromNecSuf

namespace Ising2D

open Matrix Filter Topology

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

/-- 人手の Step 1 の前置き「`𝓜̌ = {1, …, M_col}` なので `X̌` の和は `Σ_{μ=1}^{M_col}`」: `Xop`（`CheckIdx M` の上の `Finset.sum`）を、
人手の添字 `μ = j + 1`（`checkIdxOfFin`）で `Fin M` の上の和へ付け替える。添字を付け替える段で、人手の鎖の行ではない。 -/
theorem Xop_eq_sum_fin (g : CheckIdx M → ℝ) :
    F.Xop g = ∑ j : Fin M, ((g (checkIdxOfFin j) : ℂ)) • (F.nOp (checkIdxOfFin j) - (1 / 2 : ℂ) • 1) :=
  (Fintype.sum_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _
    (fun _ => rfl)).symm

/-- 人手の Step 1 の最後の行「`ǧ` の定義」: `ǧ(ε) = Σ_{μ=1}^{M_col} γ(θ~_μ)(ε_μ - 1/2)` を、`ℂ` の値として `Fin M` の上の和で書く。
人手の `ε_μ` は Lean の `if μ ∈ T then 1 else 0`。人手は `γ(θ~_μ)`・`ǧ(ε) ∈ ℝ` をそのまま `ℂ` の係数として使っており、
ℝ から ℂ への包含（`Complex.ofReal` が和・積・差・`1`・`0`・`1/2` を保つこと）を書いていない。Lean ではそれを `push_cast` で出し、
添字の付け替えは `Xop_eq_sum_fin` と同じく `checkIdxOfFin` で行う。 -/
theorem gval_eq_sum_fin (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    ((F.gval g T : ℝ) : ℂ)
      = ∑ j : Fin M, ((g (checkIdxOfFin j) : ℂ)) *
          ((if checkIdxOfFin j ∈ T then (1 : ℂ) else 0) - 1 / 2) := by
  rw [gval, ← Fintype.sum_bijective checkIdxOfFin ⟨checkIdxOfFin_injective, checkIdxOfFin_surjective⟩ _ _
    (fun _ => rfl)]
  push_cast
  refine Finset.sum_congr rfl fun j _ => ?_
  split_ifs <;> simp

/-- **原文 `eigenvalues_of_check_Vprime` Step 1**（左から掛ける形）: `X̌Q̌_ε = ǧ(ε)Q̌_ε`。人手の 14 行の鎖と 1 対 1 の calc
（`M_col = r + 1`。人手の `μ` は `checkIdxOfFin j`、`½` は `(1/2 : ℂ)`、`ε_μ` は `if μ ∈ T then 1 else 0`）。
和の各項へ同じ主張を同時に適用する行（人手の「各項へ」）は `Finset.sum_congr` で書く。 -/
theorem Xop_mul_Qproj_step1 {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ)
    (T : Finset (CheckIdx (r + 1))) :
    F.Xop g * F.Qproj T = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  set Q := F.Qproj T
  set γ : Fin (r + 1) → ℂ := fun j => (g (checkIdxOfFin j) : ℂ)
  set n : Fin (r + 1) → TensorPow (r + 1) := fun j => F.nOp (checkIdxOfFin j)
  set e : Fin (r + 1) → ℂ := fun j => if checkIdxOfFin j ∈ T then (1 : ℂ) else 0
  set h : ℂ := 1 / 2
  calc F.Xop g * Q
      = (∑ j, γ j • (n j - h • (1 : TensorPow (r + 1)))) * Q := by rw [F.Xop_eq_sum_fin g]
                                                        -- `def_check_number_operator` (2)（`Σ_{μ=1}^{M_col}`）
    _ = ∑ j, (γ j • (n j - h • (1 : TensorPow (r + 1)))) * Q := finite_sum_mul_tensorPow r _ Q
                                                        -- `finite_sum_of_matrices_distributes_in_left_factor`
    _ = ∑ j, γ j • ((n j - h • (1 : TensorPow (r + 1))) * Q) :=
        Finset.sum_congr rfl fun j _ => smul_mul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_left_factor` を各項へ
    _ = ∑ j, γ j • ((n j + -(h • (1 : TensorPow (r + 1)))) * Q) :=
        Finset.sum_congr rfl fun j _ => by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation` を各項へ
    _ = ∑ j, γ j • (n j * Q + (-(h • (1 : TensorPow (r + 1)))) * Q) :=
        Finset.sum_congr rfl fun j _ => by rw [add_mul_matrix_tensorPow]
                                                        -- `mat_mult_distributes_over_sum_in_left_factor` を各項へ
    _ = ∑ j, γ j • (n j * Q + -((h • (1 : TensorPow (r + 1))) * Q)) :=
        Finset.sum_congr rfl fun j _ => by rw [neg_mul_matrix_tensorPow]
                                                        -- `negation_factors_out_of_left_factor` を各項へ
    _ = ∑ j, γ j • (n j * Q - (h • (1 : TensorPow (r + 1))) * Q) :=
        Finset.sum_congr rfl fun j _ => by rw [← sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ、各項へ
    _ = ∑ j, γ j • (n j * Q - h • ((1 : TensorPow (r + 1)) * Q)) :=
        Finset.sum_congr rfl fun j _ => by rw [smul_mul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_left_factor` を各項へ
    _ = ∑ j, γ j • (n j * Q - h • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [identity_matrix_mul_tensorPow]
                                                        -- `identity_matrix_is_left_unit_of_mat_mult` を各項へ
    _ = ∑ j, γ j • (e j • Q - h • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [F.nOp_mul_Qproj (checkIdxOfFin j) T]
                                                        -- `check_joint_eigenspace_decomposition` (3) の `ň_νQ̌_ε = ε_νQ̌_ε` を各項へ
    _ = ∑ j, γ j • ((e j - h) • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [smul_sub_smul_tensorPow]
                                                        -- `difference_of_scalar_multiples_of_one_matrix` を各項へ
    _ = ∑ j, (γ j * (e j - h)) • Q :=
        Finset.sum_congr rfl fun j _ => smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative` を各項へ（Lean の具体版は無く、mathlib の `smul_smul`）
    _ = (∑ j, γ j * (e j - h)) • Q := finite_sum_smul_one_tensorPow r _ Q
                                                        -- `finite_sum_of_scalar_multiples_of_one_matrix`
    _ = ((F.gval g T : ℝ) : ℂ) • Q := by rw [F.gval_eq_sum_fin g T]
                                                        -- `ǧ` の定義

/-- 人手の範囲外の `M_col = 0`（人手は `M_col ≥ 2`）でだけ使う `X̌Q̌_ε = ǧ(ε)Q̌_ε`。mathlib の `Finset.sum_mul` などで閉じる
（人手の鎖とは対応しない）。 -/
theorem Xop_mul_Qproj_of_finset_sum (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
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

/-- **原文 `eigenvalues_of_check_Vprime` Step 1**: `X̌ Q̌_ε = ǧ(ε) Q̌_ε`。
`M = r + 1` では人手の鎖と 1 対 1 の `Xop_mul_Qproj_step1`、人手の範囲外の `M = 0` では `Xop_mul_Qproj_of_finset_sum` による。 -/
theorem Xop_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Xop g * F.Qproj T = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  match M, F, g, T with
  | 0, F, g, T => exact F.Xop_mul_Qproj_of_finset_sum g T
  | r + 1, F, g, T => exact Xop_mul_Qproj_step1 F g T

/-- **原文 `eigenvalues_of_check_Vprime` Step 1**（右から掛ける形）: `Q̌_εX̌ = ǧ(ε)Q̌_ε`。人手の 14 行の鎖と 1 対 1 の calc
（`M_col = r + 1`。記号の対応は `Xop_mul_Qproj_step1` と同じ）。和の各項へ同じ主張を同時に適用する行（人手の「各項へ」）は
`Finset.sum_congr` で書く。 -/
theorem Qproj_mul_Xop_step1 {r : ℕ} (F : CheckFermiSetup (r + 1)) (g : CheckIdx (r + 1) → ℝ)
    (T : Finset (CheckIdx (r + 1))) :
    F.Qproj T * F.Xop g = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  set Q := F.Qproj T
  set γ : Fin (r + 1) → ℂ := fun j => (g (checkIdxOfFin j) : ℂ)
  set n : Fin (r + 1) → TensorPow (r + 1) := fun j => F.nOp (checkIdxOfFin j)
  set e : Fin (r + 1) → ℂ := fun j => if checkIdxOfFin j ∈ T then (1 : ℂ) else 0
  set h : ℂ := 1 / 2
  calc Q * F.Xop g
      = Q * (∑ j, γ j • (n j - h • (1 : TensorPow (r + 1)))) := by rw [F.Xop_eq_sum_fin g]
                                                        -- `def_check_number_operator` (2)（`Σ_{μ=1}^{M_col}`）
    _ = ∑ j, Q * (γ j • (n j - h • (1 : TensorPow (r + 1)))) := mul_finite_sum_tensorPow r Q _
                                                        -- `finite_sum_of_matrices_distributes_in_right_factor`
    _ = ∑ j, γ j • (Q * (n j - h • (1 : TensorPow (r + 1)))) :=
        Finset.sum_congr rfl fun j _ => mul_smul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor` を各項へ
    _ = ∑ j, γ j • (Q * (n j + -(h • (1 : TensorPow (r + 1))))) :=
        Finset.sum_congr rfl fun j _ => by rw [sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation` を各項へ
    _ = ∑ j, γ j • (Q * n j + Q * (-(h • (1 : TensorPow (r + 1))))) :=
        Finset.sum_congr rfl fun j _ => by rw [mul_add_matrix_tensorPow]
                                                        -- `mat_mult_distributes_over_sum_in_right_factor` を各項へ
    _ = ∑ j, γ j • (Q * n j + -(Q * (h • (1 : TensorPow (r + 1))))) :=
        Finset.sum_congr rfl fun j _ => by rw [mul_neg_matrix_tensorPow]
                                                        -- `negation_factors_out_of_right_factor` を各項へ
    _ = ∑ j, γ j • (Q * n j - Q * (h • (1 : TensorPow (r + 1)))) :=
        Finset.sum_congr rfl fun j _ => by rw [← sub_eq_add_neg_tensorPow]
                                                        -- `matrix_difference_is_sum_with_negation` を右辺から左辺へ、各項へ
    _ = ∑ j, γ j • (Q * n j - h • (Q * (1 : TensorPow (r + 1)))) :=
        Finset.sum_congr rfl fun j _ => by rw [mul_smul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_right_factor` を各項へ
    _ = ∑ j, γ j • (Q * n j - h • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [mul_identity_matrix_tensorPow]
                                                        -- `identity_matrix_is_right_unit_of_mat_mult` を各項へ
    _ = ∑ j, γ j • (e j • Q - h • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [F.Qproj_mul_nOp (checkIdxOfFin j) T]
                                                        -- `check_joint_eigenspace_decomposition` (3) の `Q̌_εň_ν = ε_νQ̌_ε` を各項へ
    _ = ∑ j, γ j • ((e j - h) • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [smul_sub_smul_tensorPow]
                                                        -- `difference_of_scalar_multiples_of_one_matrix` を各項へ
    _ = ∑ j, (γ j * (e j - h)) • Q :=
        Finset.sum_congr rfl fun j _ => smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative` を各項へ（Lean の具体版は無く、mathlib の `smul_smul`）
    _ = (∑ j, γ j * (e j - h)) • Q := finite_sum_smul_one_tensorPow r _ Q
                                                        -- `finite_sum_of_scalar_multiples_of_one_matrix`
    _ = ((F.gval g T : ℝ) : ℂ) • Q := by rw [F.gval_eq_sum_fin g T]
                                                        -- `ǧ` の定義

/-- 人手の範囲外の `M_col = 0`（人手は `M_col ≥ 2`）でだけ使う `Q̌_εX̌ = ǧ(ε)Q̌_ε`。`X̌` と `Q̌_ε` の可換性と
`Xop_mul_Qproj_of_finset_sum` で閉じる（人手の鎖とは対応しない）。 -/
theorem Qproj_mul_Xop_of_commute (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Xop g = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  have hcomm : Commute (F.Xop g) (F.Qproj T) := by
    refine Commute.sum_left _ _ _ fun i _ => ?_
    refine Commute.smul_left ?_ _
    refine Commute.sub_left (F.commute_nOp_Qproj i T) ?_
    exact Commute.smul_left (Commute.one_left _) _
  rw [← hcomm.eq, F.Xop_mul_Qproj_of_finset_sum g T]

/-- **原文 `eigenvalues_of_check_Vprime` Step 1**（右から掛ける形）: `Q̌_ε X̌ = ǧ(ε) Q̌_ε`。
`M = r + 1` では人手の鎖と 1 対 1 の `Qproj_mul_Xop_step1`、人手の範囲外の `M = 0` では `Qproj_mul_Xop_of_commute` による。 -/
theorem Qproj_mul_Xop (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Xop g = ((F.gval g T : ℝ) : ℂ) • F.Qproj T := by
  match M, F, g, T with
  | 0, F, g, T => exact F.Qproj_mul_Xop_of_commute g T
  | r + 1, F, g, T => exact Qproj_mul_Xop_step1 F g T

/-- **原文 `eigenvalues_of_check_Vprime` Step 2**: `X̌^k Q̌_ε = ǧ(ε)^k Q̌_ε`。
人手の帰納法の鎖（`k = 0` の 4 行、`k + 1` の 8 行）と 1 対 1 の calc。行列の冪は `def_exp` (1) の
`A^0 := I`・`A^{m+1} := A^m A`（mathlib の `pow_zero`・`pow_succ` が同じ形）、数の冪も同じ形で証明の中で定めている。
同じ主張の必要十分版は `NecSuf.pow_mul_eq_of_mul_eq_smul`（`ClaimEigenvaluesCheckVprimeFromNecSuf.lean` の `Vprime_mul_Qproj_of_necSuf` が `NecSuf.exp_mul_eq_of_mul_eq_smul` の中で使う）。
具体版の `Vprime_mul_Qproj` は部分和の鎖 `partialExpSum_mul_Qproj` を経てこの定理を使う。 -/
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
同じ主張の必要十分版は `NecSuf.mul_exp_eq_of_mul_eq_smul` の中の冪の段（`ClaimEigenvaluesCheckVprimeFromNecSuf.lean` の `Qproj_mul_Vprime_of_necSuf` が使う）。
具体版の `Qproj_mul_Vprime` は部分和の鎖 `Qproj_mul_partialExpSum` を経てこの定理を使う。 -/
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

/-- **原文 `eigenvalues_of_check_Vprime` Step 3 の部分和**: `E_K := Σ_{k=0}^{K} (1/k!) X̌^k`。
人手の添字 `0` からの和（`def_finite_sum_of_matrices_from_index_zero`）は `Finset.range (K + 1)` の上の和で書く。 -/
noncomputable def partialExpSum (g : CheckIdx M → ℝ) (K : ℕ) : TensorPow M :=
  ∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) • F.Xop g ^ k

/-- **原文 `eigenvalues_of_check_Vprime` Step 3 の部分和の鎖**: `E_K Q̌_ε = (Σ_{k=0}^{K} (1/k!) ǧ(ε)^k) Q̌_ε`。人手の 8 行と 1 対 1 の calc。
人手の `Σ_{j=1}^{K+1}` は `Fin (K + 1)` の上の和で、人手の `j − 1` が Lean の `(j : ℕ)` に当たる。
`def_finite_sum_of_matrices_from_index_zero`・`def_finite_sum_of_complex_numbers_from_index_zero` の式（添字 `0` からの和を添字 `1` からの和へずらす）は
mathlib の `Finset.sum_range`（`Σ_{i ∈ range n} f i = Σ_{i : Fin n} f i`）で出す。
和の各項へ同じ主張を同時に適用する行（人手の「各項へ」）は `Finset.sum_congr` で書く。 -/
theorem partialExpSum_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) (K : ℕ) :
    F.partialExpSum g K * F.Qproj T
      = (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * (((F.gval g T : ℝ) : ℂ)) ^ k) • F.Qproj T := by
  set Q := F.Qproj T
  set X := F.Xop g
  set G : ℂ := ((F.gval g T : ℝ) : ℂ)
  calc F.partialExpSum g K * Q
      = (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) • X ^ k) * Q := rfl
                                                        -- `E_K` の定義
    _ = (∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • X ^ (j : ℕ)) * Q := by
          rw [Finset.sum_range (fun k => (1 / (k.factorial : ℂ)) • X ^ k)]
                                                        -- `def_finite_sum_of_matrices_from_index_zero`（項 `(1/k!)X̌^k`）
    _ = ∑ j : Fin (K + 1), ((1 / ((j : ℕ).factorial : ℂ)) • X ^ (j : ℕ)) * Q := finite_sum_mul_tensorPow K _ Q
                                                        -- `finite_sum_of_matrices_distributes_in_left_factor`（`r → K + 1`）
    _ = ∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • (X ^ (j : ℕ) * Q) :=
        Finset.sum_congr rfl fun j _ => smul_mul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_left_factor` を各項へ
    _ = ∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • (G ^ (j : ℕ) • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [F.Xop_pow_mul_Qproj g T]
                                                        -- Step 2（`k → j − 1`）を各項へ
    _ = ∑ j : Fin (K + 1), ((1 / ((j : ℕ).factorial : ℂ)) * G ^ (j : ℕ)) • Q :=
        Finset.sum_congr rfl fun j _ => smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative` を各項へ（Lean の具体版は無く、mathlib の `smul_smul`）
    _ = (∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) * G ^ (j : ℕ)) • Q := finite_sum_smul_one_tensorPow K _ Q
                                                        -- `finite_sum_of_scalar_multiples_of_one_matrix`（`r → K + 1`）
    _ = (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * G ^ k) • Q := by
          rw [Finset.sum_range (fun k => (1 / (k.factorial : ℂ)) * G ^ k)]
                                                        -- `def_finite_sum_of_complex_numbers_from_index_zero`（項 `(1/k!)ǧ(ε)^k`）を右辺から左辺へ

/-- **原文 `eigenvalues_of_check_Vprime` Step 3' の部分和の鎖**: `Q̌_ε E_K = (Σ_{k=0}^{K} (1/k!) ǧ(ε)^k) Q̌_ε`。人手の 8 行と 1 対 1 の calc
（添字の読み替えは `partialExpSum_mul_Qproj` と同じ）。 -/
theorem Qproj_mul_partialExpSum (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) (K : ℕ) :
    F.Qproj T * F.partialExpSum g K
      = (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * (((F.gval g T : ℝ) : ℂ)) ^ k) • F.Qproj T := by
  set Q := F.Qproj T
  set X := F.Xop g
  set G : ℂ := ((F.gval g T : ℝ) : ℂ)
  calc Q * F.partialExpSum g K
      = Q * (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) • X ^ k) := rfl
                                                        -- `E_K` の定義
    _ = Q * (∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • X ^ (j : ℕ)) := by
          rw [Finset.sum_range (fun k => (1 / (k.factorial : ℂ)) • X ^ k)]
                                                        -- `def_finite_sum_of_matrices_from_index_zero`（項 `(1/k!)X̌^k`）
    _ = ∑ j : Fin (K + 1), Q * ((1 / ((j : ℕ).factorial : ℂ)) • X ^ (j : ℕ)) := mul_finite_sum_tensorPow K Q _
                                                        -- `finite_sum_of_matrices_distributes_in_right_factor`（`r → K + 1`）
    _ = ∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • (Q * X ^ (j : ℕ)) :=
        Finset.sum_congr rfl fun j _ => mul_smul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor` を各項へ
    _ = ∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) • (G ^ (j : ℕ) • Q) :=
        Finset.sum_congr rfl fun j _ => by rw [F.Qproj_mul_Xop_pow g T]
                                                        -- Step 3' の帰納法（`k → j − 1`）を各項へ
    _ = ∑ j : Fin (K + 1), ((1 / ((j : ℕ).factorial : ℂ)) * G ^ (j : ℕ)) • Q :=
        Finset.sum_congr rfl fun j _ => smul_smul _ _ _
                                                        -- `scalar_multiple_is_associative` を各項へ（mathlib の `smul_smul`）
    _ = (∑ j : Fin (K + 1), (1 / ((j : ℕ).factorial : ℂ)) * G ^ (j : ℕ)) • Q := finite_sum_smul_one_tensorPow K _ Q
                                                        -- `finite_sum_of_scalar_multiples_of_one_matrix`（`r → K + 1`）
    _ = (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * G ^ k) • Q := by
          rw [Finset.sum_range (fun k => (1 / (k.factorial : ℂ)) * G ^ k)]
                                                        -- `def_finite_sum_of_complex_numbers_from_index_zero`（項 `(1/k!)ǧ(ε)^k`）を右辺から左辺へ

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

/-- **原文 `eigenvalues_of_check_Vprime` Step 3 の極限の鎖の 1 行目の根拠**: 部分和 `E_K` は `K → ∞` で `V̌' = exp(X̌)` に収束する
（`def_exp` と `matrix_exp_series_converges` (1)（`N → K`、`A → X̌`））。`matrix_exp_series_converges` の Lean の具体版は無く、Lean の `def_exp` は `matExp_hasSum`（項 `(k!)^{-1} X̌^k` の
`Finset.range n` の上の和が `n → ∞` で収束する）で、`E_K` は `Finset.range (K + 1)` の上の和なので、添字を `K ↦ K + 1` で送る
（`Filter.tendsto_add_atTop_nat`）。係数の `(k!)^{-1}` と `1/k!` は mathlib の `one_div` で同じ数である。 -/
theorem partialExpSum_tendsto (g : CheckIdx M → ℝ) :
    Tendsto (fun K => F.partialExpSum g K) atTop (𝓝 (F.Vprime g)) := by
  have h := ((matExp_hasSum (F.Xop g)).tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)
  refine h.congr fun K => ?_
  simp only [Function.comp_apply, partialExpSum, one_div]

/-- **原文 `eigenvalues_of_check_Vprime` Step 3 の極限の鎖の 6 行目が引く `scalar_exp_is_limit_of_partial_sums`**
（係数の集合 `K → ℂ`、`x → ǧ(ε)_ℂ`）: `Σ_{k=0}^{K} z^k/k! → exp(z)`。人手のこの主張の Lean の具体版はまだ無く、
mathlib の `NormedSpace.expSeries_div_hasSum_exp`（`Complex.exp_eq_exp_ℂ` で `Complex.exp` へ読み替える）で閉じる。
添字は `partialExpSum_tendsto` と同じく `K ↦ K + 1` で送る。 -/
theorem complex_exp_partial_sum_tendsto (z : ℂ) :
    Tendsto (fun K => ∑ k ∈ Finset.range (K + 1), z ^ k / (k.factorial : ℂ)) atTop (𝓝 (Complex.exp z)) := by
  have h := NormedSpace.expSeries_div_hasSum_exp z
  rw [← Complex.exp_eq_exp_ℂ] at h
  exact (h.tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)

set_option backward.isDefEq.respectTransparency false in
/-- **原文 `eigenvalues_of_check_Vprime` Step 3**: `V̌' Q̌_ε = e^{ǧ(ε)} Q̌_ε`。人手の極限の鎖（7 行）と 1 対 1 の calc。

人手の `lim_{K→∞}` は mathlib の `limUnder atTop` で書く。人手の各行の極限は `def_matrix_norm` の意味で、
その収束は `‖A_K − A‖ → 0` である。Lean の行列の列の収束 `Tendsto … (𝓝 A)` とは、Frobenius ノルム（`def_matrix_norm` の
行列ノルムと値が一致する）を入れて `tendsto_iff_norm_sub_tendsto_zero` で行き来する（人手の行ではない。収束の定義の読み替え）。
`limUnder` の値を極限の値に置き換える段（`Filter.Tendsto.limUnder_eq`）は、人手の `matrix_norm_triangle_inequality` (4)
（極限の一意性。`lim` が一意に定まる極限を表すこと）に当たる。(4) の Lean の具体版は無く、mathlib の `Filter.Tendsto.limUnder_eq` で閉じる。
- 1 行目: `partialExpSum_tendsto`（`def_exp` と `matrix_exp_series_converges` (1)）。
- 2 行目: `matrix_multiplication_continuity`（`n → 2^{M_col}`。Lean は `TensorPow M` の系 `mul_right_tendsto_tensorPow`）。
- 3 行目: 部分和の鎖 `partialExpSum_mul_Qproj` を各 `K` へ。
- 4 行目: Lean の `G` は初めから `((ǧ(ε) : ℝ) : ℂ)`（`inclusion_rr_to_cc` の `ǧ(ε)_ℂ`）なので、この行は `rfl` である。
- 5 行目: `(1/k!) z = z (1/k!) = z/k!`（mathlib の `mul_comm`・`mul_one_div`）を各項へ。
- 6 行目: `scalar_exp_is_limit_of_partial_sums`（`complex_exp_partial_sum_tendsto`）の極限を仮定に置いた
  `scalar_sequence_times_matrix_converges`（Lean は `TensorPow M` の系 `smul_tendsto_tensorPow`）と、`matrix_norm_triangle_inequality` (4)。
- 7 行目: `complex_exp_of_real_argument`（Lean の具体版は無く、mathlib の `Complex.ofReal_exp`）。 -/
theorem Vprime_mul_Qproj (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Vprime g * F.Qproj T = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  letI : NormedAddCommGroup (TensorPow M) := Matrix.frobeniusNormedAddCommGroup
  set Q := F.Qproj T
  set G : ℂ := ((F.gval g T : ℝ) : ℂ)
  have hE := F.partialExpSum_tendsto g
  -- `E_K Q̌_ε → V̌' Q̌_ε`（`matrix_multiplication_continuity`）
  have hEQ : Tendsto (fun K => F.partialExpSum g K * Q) atTop (𝓝 (F.Vprime g * Q)) :=
    tendsto_iff_norm_sub_tendsto_zero.2
      (mul_right_tendsto_tensorPow Q _ _ (tendsto_iff_norm_sub_tendsto_zero.1 hE))
  -- `(Σ_{k=0}^{K} G^k/k!) Q̌_ε → exp(G) Q̌_ε`（`scalar_exp_is_limit_of_partial_sums` と `scalar_sequence_times_matrix_converges`）
  have hcQ : Tendsto (fun K => (∑ k ∈ Finset.range (K + 1), G ^ k / (k.factorial : ℂ)) • Q) atTop
      (𝓝 (Complex.exp G • Q)) :=
    tendsto_iff_norm_sub_tendsto_zero.2
      (smul_tendsto_tensorPow _ _ Q (tendsto_iff_norm_sub_tendsto_zero.1 (complex_exp_partial_sum_tendsto G)))
  calc F.Vprime g * Q
      = (limUnder atTop (fun K => F.partialExpSum g K)) * Q := by rw [hE.limUnder_eq]
                                                        -- `V̌' = exp(X̌)` は部分和 `E_K` の極限（`def_exp`、`matrix_exp_series_converges` (1)）
    _ = limUnder atTop (fun K => F.partialExpSum g K * Q) := by rw [hE.limUnder_eq, hEQ.limUnder_eq]
                                                        -- `matrix_multiplication_continuity`（`(A_N)_N → (E_N)_N`、`A → V̌'`、`B → Q̌_ε`）
    _ = limUnder atTop
          (fun K => (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * (((F.gval g T : ℝ) : ℂ)) ^ k) • Q) := by
          congr 1; funext K; exact F.partialExpSum_mul_Qproj g T K
                                                        -- 上の部分和の鎖を各 `K` へ
    _ = limUnder atTop (fun K => (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * G ^ k) • Q) := rfl
                                                        -- 鎖の係数 `ǧ(ε) ∈ ℝ` は `inclusion_rr_to_cc` の `ǧ(ε)_ℂ` として掛けている
    _ = limUnder atTop (fun K => (∑ k ∈ Finset.range (K + 1), G ^ k / (k.factorial : ℂ)) • Q) := by
          congr 1; funext K; congr 1
          exact Finset.sum_congr rfl fun k _ => by rw [mul_comm, mul_one_div]
                                                        -- `(1/k!) z = z (1/k!) =: z/k!` を各項へ
    _ = Complex.exp G • Q := hcQ.limUnder_eq
                                                        -- `scalar_exp_is_limit_of_partial_sums`（`x → ǧ(ε)_ℂ`）の極限を仮定に置いた
                                                        -- `scalar_sequence_times_matrix_converges` と `matrix_norm_triangle_inequality` (4)
    _ = ((Real.exp (F.gval g T) : ℝ) : ℂ) • Q := by rw [Complex.ofReal_exp]
                                                        -- `complex_exp_of_real_argument`（`x → ǧ(ε)`。Lean の具体版は無く、mathlib の `Complex.ofReal_exp`）

set_option backward.isDefEq.respectTransparency false in
/-- **原文 `eigenvalues_of_check_Vprime` Step 3'**: 左右を入れ替えた形 `Q̌_ε V̌' = e^{ǧ(ε)} Q̌_ε`（単純性の証明で使う）。
人手の極限の鎖の 1〜7 行と 1 対 1 の calc（読み替えは `Vprime_mul_Qproj` と同じ）。2 行目は
`matrix_multiplication_continuity_in_right_factor`（Lean は `TensorPow M` の系 `mul_left_tendsto_tensorPow`）、3 行目は
部分和の鎖 `Qproj_mul_partialExpSum` を各 `K` へ。人手の鎖の最後の行「`= V̌'Q̌_ε`（Step 3 の極限の鎖）」は、
この定理の主張が `e^{ǧ(ε)} Q̌_ε` で止まるので置かない（`Vprime_mul_Qproj` を右辺から左辺へ引けば得られる）。 -/
theorem Qproj_mul_Vprime (g : CheckIdx M → ℝ) (T : Finset (CheckIdx M)) :
    F.Qproj T * F.Vprime g = ((Real.exp (F.gval g T) : ℝ) : ℂ) • F.Qproj T := by
  letI : NormedAddCommGroup (TensorPow M) := Matrix.frobeniusNormedAddCommGroup
  set Q := F.Qproj T
  set G : ℂ := ((F.gval g T : ℝ) : ℂ)
  have hE := F.partialExpSum_tendsto g
  -- `Q̌_ε E_K → Q̌_ε V̌'`（`matrix_multiplication_continuity_in_right_factor`）
  have hQE : Tendsto (fun K => Q * F.partialExpSum g K) atTop (𝓝 (Q * F.Vprime g)) :=
    tendsto_iff_norm_sub_tendsto_zero.2
      (mul_left_tendsto_tensorPow Q _ _ (tendsto_iff_norm_sub_tendsto_zero.1 hE))
  have hcQ : Tendsto (fun K => (∑ k ∈ Finset.range (K + 1), G ^ k / (k.factorial : ℂ)) • Q) atTop
      (𝓝 (Complex.exp G • Q)) :=
    tendsto_iff_norm_sub_tendsto_zero.2
      (smul_tendsto_tensorPow _ _ Q (tendsto_iff_norm_sub_tendsto_zero.1 (complex_exp_partial_sum_tendsto G)))
  calc Q * F.Vprime g
      = Q * (limUnder atTop (fun K => F.partialExpSum g K)) := by rw [hE.limUnder_eq]
                                                        -- `V̌' = exp(X̌)` は部分和 `E_K` の極限（Step 3 の級数表示）
    _ = limUnder atTop (fun K => Q * F.partialExpSum g K) := by rw [hE.limUnder_eq, hQE.limUnder_eq]
                                                        -- `matrix_multiplication_continuity_in_right_factor`（`(A_N)_N → (E_N)_N`、`A → V̌'`、`B → Q̌_ε`）
    _ = limUnder atTop
          (fun K => (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * (((F.gval g T : ℝ) : ℂ)) ^ k) • Q) := by
          congr 1; funext K; exact F.Qproj_mul_partialExpSum g T K
                                                        -- 上の部分和の鎖を各 `K` へ
    _ = limUnder atTop (fun K => (∑ k ∈ Finset.range (K + 1), (1 / (k.factorial : ℂ)) * G ^ k) • Q) := rfl
                                                        -- 鎖の係数 `ǧ(ε) ∈ ℝ` は `inclusion_rr_to_cc` の `ǧ(ε)_ℂ` として掛けている
    _ = limUnder atTop (fun K => (∑ k ∈ Finset.range (K + 1), G ^ k / (k.factorial : ℂ)) • Q) := by
          congr 1; funext K; congr 1
          exact Finset.sum_congr rfl fun k _ => by rw [mul_comm, mul_one_div]
                                                        -- `(1/k!) z = z (1/k!) =: z/k!` を各項へ
    _ = Complex.exp G • Q := hcQ.limUnder_eq
                                                        -- `scalar_exp_is_limit_of_partial_sums` の極限を仮定に置いた
                                                        -- `scalar_sequence_times_matrix_converges` と `matrix_norm_triangle_inequality` (4)
    _ = ((Real.exp (F.gval g T) : ℝ) : ℂ) • Q := by rw [Complex.ofReal_exp]
                                                        -- `complex_exp_of_real_argument`（`x → ǧ(ε)`）

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
