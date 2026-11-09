/-
# `tr(εV^{(+)})` を二つのスピン和で書き、閉じた式と正値性を得る（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の Step 4・Step 5・Step 6 と主張）

| 人手 | Lean |
| --- | --- |
| Step 4 の一つ目の鎖（7 行）`(exp(κD_0)(εV_2))_{ord(s),ord(s)} = ⋯ = (exp(-K_2M_col)exp(K_1E(s)))_ℂ` | `matExp_openChainD0_mul_epsilon_mul_V2_apply_self` の 7 段 |
| Step 4 の二つ目の鎖（7 行）`(exp(κD_0)(GV_2))_{ord(s),ord(s)} = ⋯ = (exp(K_2M_col)(s(M_col)s(1)exp(K_1E(s))))_ℂ` | `matExp_openChainD0_mul_boundaryG_mul_V2_apply_self` の 7 段 |
| Step 5 の `tr(X) = ∑_{s∈𝔐} X_{ord(s),ord(s)}`（`def_trace` と準備の和の定め方） | `trace_eq_sum_configBasisIso` |
| Step 5 の二つの鎖の 4 行目の根拠 `finite_sum_of_real_scalar_multiples` を 𝔐 の上の和へ当てたもの | `finite_sum_over_spinConf_of_real_scalar_multiples` |
| Step 5 の一つ目のトレースの鎖（4 行）`tr(exp(κD_0)(εV_2)) = ⋯ = (exp(-K_2M_col)S_cosh)_ℂ` | `trace_matExp_openChainD0_mul_epsilon_mul_V2` の 4 段 |
| Step 5 の二つ目のトレースの鎖（4 行）`tr(exp(κD_0)(GV_2)) = ⋯ = (exp(K_2M_col)S_sinh)_ℂ` | `trace_matExp_openChainD0_mul_boundaryG_mul_V2` の 4 段 |
| Step 5 の組み立ての鎖（11 行）`tr(εV^{(+)}) = ⋯ = (cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh))_ℂ` | `trace_epsilon_VPlusOfTransfer_eq_spin_sums` の 11 段（印 `人手 1`〜`人手 11`） |
| Step 5 の実数の鎖（左辺と 8 行）`cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh) = ⋯ = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}` | `spin_sums_combination_eq_closed_form` の 8 段（印 `人手 1`〜`人手 8`） |
| 同 4 行目の根拠「同じ実数 `∓K_2` を `M_col` 個足すと `∓K_2M_col`」 | `finite_sum_of_constant_real`・`finite_sum_of_negated_constant_real` |
| Step 5 の「ゆえに主張の等号が成り立つ」 | `trace_epsilon_VPlusOfTransfer_closed_form` |
| Step 6（正値性）`(2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} > 0` | `closed_form_of_trace_epsilon_V_plus_pos` |
| 主張の `∈ ℝ_{>0}` を実部で読んだ `0 < Re tr(εV^{(+)})` | `trace_epsilon_VPlusOfTransfer_pos` |
| 主張 `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}` | `trace_of_epsilon_V_plus` |

`S_cosh`・`S_sinh` は Lean では名前を付けず、和 `∑ s : SpinConf M, …` をそのまま書く。
二つのトレースの鎖の 3 行目 `real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype` を引く
（添字 `SpinConf M` は空でない）。Lean の具体版が無い根拠は、既存の慣行どおり mathlib を引く。組み立ての鎖の 3 行目 `mat_mult_associative` は `Matrix.mul_assoc` である。組み立ての鎖のほかの根拠は具体版で、分配と括り出しは `TensorPow M` での系
`add_mul_matrix_tensorPow`・`mul_add_matrix_tensorPow`・`smul_mul_matrix_tensorPow`・`mul_smul_matrix_tensorPow`、
`trace_basic_properties` (1) は `trace_linear`、`real_inclusion_preserves_product`・`real_inclusion_preserves_sum` は
`real_inclusion_mul`・`real_inclusion_add` である。

`V^{(+)}` は人手 `def_V_plus` の `(V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`、Lean の `VPlusOfTransfer M K_1 K_2` である。
最終定理の入力が持つ `vPlusDataOf` の `V^{(+)}` は、`V_2` を `V2_exponential_representation` で書き換えた形
`VPlus M (sinh 2K_2) K_1 K_2^*` なので、`VPlusOfTransfer_eq_VPlus` で人手の形へ戻して
`trace_epsilon_vPlusDataOf_pos` を得る。これで最終定理 `onsager_exact_solution_unconditional` の入力から `htr` を外した。

正値性は人手 Step 6 と同じく、実数の鎖の左辺の二項がともに正であることから出す
（`open_chain_spin_sums_positive`（`open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos`）、
`cosh_sinh_basic_properties_3`、`real_exp_positive`）。

必要十分版は置かない。一般化できるのは、行列の積の分配と対角成分の読み取り（可換環上の行列で成り立つ）と、
順序体での正の数の積と和の正値性だけで、必要十分版にしても何が本質的かについて情報を与えない
（`ClaimTraceEpsilonVPlusMatrixEntries.lean` と同じ扱い。二つのスピン和の一般形は `NecSuf/OpenChainSpinSum.lean` が既に持つ）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusMatrixEntries
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusReduction
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpOfFiniteSum
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpPositive
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfRealProducts
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshSinhBasicProperties

namespace Ising2D

open Matrix

variable {M : ℕ}

/-! ## Step 5 の準備: トレースと 𝔐 の上の和 -/

/-- 人手 Step 5 の `tr(X) = ∑_{s∈𝔐} X_{ord(s),ord(s)}`（`def_trace` と準備の和の定め方）。
人手の番号 `ord(s)` は Lean の添字 `configBasisIso M s`（`ι(s)`）に当たる（`config_numbering_equals_kronecker_numbering`、
`ord = ν∘ι`）。`def_trace` の対角成分の和を `ι` で 𝔐 の上の和へ足し直す。 -/
theorem trace_eq_sum_configBasisIso (X : TensorPow M) :
    X.trace = ∑ s : SpinConf M, X (configBasisIso M s) (configBasisIso M s) := by
  rw [trace_eq_sum_diag]
  exact ((configBasisIso M).sum_comp (fun I => X I I)).symm

/-- 人手 Step 5 の二つの鎖の 4 行目の根拠 `finite_sum_of_real_scalar_multiples` を、𝔐 の上の和
（準備の和の定め方 `∑_{s∈𝔐} a(s) := ∑_{k=1}^{2^{M_col}} a(ord^{-1}(k))`）へ当てたもの:
`∑_{s∈𝔐} c a(s) = c ∑_{s∈𝔐} a(s)`。
Lean の `∑ s : SpinConf M` は番号付けに依らない有限集合の上の和なので、番号 `Fin (2^M)` への付け替え
`(configBasisIso M).trans finFunctionFinEquiv`（`toFinPowAlgEquiv M` と同じ番号付け）で `Fin` の和へ移して
具体版 `finite_sum_of_real_scalar_multiples` を当て、同じ付け替えで戻す（付け替えの 2 段は人手の行ではない）。
この付け替えの番号（`∑_m I(m)·2^m`）は人手の `ord` と別の全単射だが、`∑ s : SpinConf M` は番号付けに依らない和なので、
結論は付け替えの選び方に依らない（`ClaimTraceEpsilonVPlusReduction.lean` の `toFinPowAlgEquiv M` と同じ扱い）。 -/
theorem finite_sum_over_spinConf_of_real_scalar_multiples (c : ℝ) (a : SpinConf M → ℝ) :
    ∑ s : SpinConf M, c * a s = c * ∑ s : SpinConf M, a s :=
  let e : SpinConf M ≃ Fin (2 ^ M) := (configBasisIso M).trans finFunctionFinEquiv
  calc ∑ s : SpinConf M, c * a s
      = ∑ k : Fin (2 ^ M), c * a (e.symm k) := (e.symm.sum_comp (fun s => c * a s)).symm
    _ = c * ∑ k : Fin (2 ^ M), a (e.symm k) := finite_sum_of_real_scalar_multiples _ c _
    _ = c * ∑ s : SpinConf M, a s := by rw [e.symm.sum_comp a]

/-! ## Step 4 -/

/-- **人手 Step 4 の一つ目の鎖**（7 行）:
`(exp(κD_0)(εV_2))_{ord(s),ord(s)} = (exp(-K_2M_col)exp(K_1E(s)))_ℂ`。 -/
theorem matExp_openChainD0_mul_epsilon_mul_V2_apply_self (K1 K2 : ℝ) (s : SpinConf M) :
    (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2)) (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (-(K2 * M)) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2)) (configBasisIso M s) (configBasisIso M s)
      = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * (epsilon M * V2 M K2) (configBasisIso M s) (configBasisIso M s) :=
        -- 人手 1: `mat_mult` と (a) の `exp(κD_0)` の対角性、`finite_sum_with_single_nonzero_term`
        mul_apply_configBasisIso_of_single_nonzero _ (matExp_smul_openChainD0_apply_of_ne K1 s) _
    _ = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * (epsilon M (configBasisIso M s) (configBasisIso M (negSpinConf s))
            * V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)) := by
        -- 人手 2: `mat_mult` と (b)、`finite_sum_with_single_nonzero_term`
        rw [mul_apply_configBasisIso_of_single_nonzero _ (epsilon_apply_configBasisIso_of_ne s)]
    _ = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * (1 * V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s)) := by
        rw [epsilon_apply_configBasisIso_neg_self]                 -- 人手 3: (b) の `δ_{-(-s)=s} = 1_ℂ`
    _ = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s) := by
        rw [one_mul]                                               -- 人手 4: `complex_numbers_form_a_field` の積の単位元
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * V2 M K2 (configBasisIso M (negSpinConf s)) (configBasisIso M s) := by
        rw [matExp_smul_openChainD0_apply]                         -- 人手 5: (a)
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) * ((Real.exp (-(K2 * M)) : ℝ) : ℂ) := by
        rw [V2_apply_configBasisIso_neg_self]                      -- 人手 6: (c)
    _ = ((Real.exp (-(K2 * M)) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        -- 人手 7: `real_inclusion_preserves_product` と ℝ の積の可換律
        (real_inclusion_mul _ _).trans (congrArg (fun x : ℝ => (x : ℂ)) (mul_comm _ _))

/-- **人手 Step 4 の二つ目の鎖**（7 行）:
`(exp(κD_0)(GV_2))_{ord(s),ord(s)} = (exp(K_2M_col)(s(M_col)s(1)exp(K_1E(s))))_ℂ`。 -/
theorem matExp_openChainD0_mul_boundaryG_mul_V2_apply_self (hM : M ≠ 0) (K1 K2 : ℝ) (s : SpinConf M) :
    (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2))
        (configBasisIso M s) (configBasisIso M s)
      = ((Real.exp (K2 * M)
          * ((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2))
        (configBasisIso M s) (configBasisIso M s)
      = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * (boundaryG M hM * V2 M K2) (configBasisIso M s) (configBasisIso M s) :=
        -- 人手 1: `mat_mult` と (a) の `exp(κD_0)` の対角性、`finite_sum_with_single_nonzero_term`
        mul_apply_configBasisIso_of_single_nonzero _ (matExp_smul_openChainD0_apply_of_ne K1 s) _
    _ = matExp ((K1 : ℂ) • openChainD0 M) (configBasisIso M s) (configBasisIso M s)
          * (boundaryG M hM (configBasisIso M s) (configBasisIso M s)
            * V2 M K2 (configBasisIso M s) (configBasisIso M s)) := by
        -- 人手 2: `mat_mult` と (a) の `G` の対角性、`finite_sum_with_single_nonzero_term`
        rw [mul_apply_configBasisIso_of_single_nonzero _ (boundaryG_apply_configBasisIso_of_ne hM s)]
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
            * V2 M K2 (configBasisIso M s) (configBasisIso M s)) := by
        rw [matExp_smul_openChainD0_apply, boundaryG_apply_configBasisIso_self]  -- 人手 3: (a)
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * ((((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) : ℝ) : ℂ)
            * ((Real.exp (K2 * M) : ℝ) : ℂ)) := by
        rw [V2_apply_configBasisIso_self]                          -- 人手 4: (c)
    _ = ((Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          * (((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K2 * M) : ℝ) : ℂ) :=
        congrArg _ (real_inclusion_mul _ _)                        -- 人手 5: `real_inclusion_preserves_product`
    _ = ((Real.exp (K1 * openChainEnergy s)
          * ((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K2 * M)) : ℝ) : ℂ) :=
        real_inclusion_mul _ _                                     -- 人手 6: `real_inclusion_preserves_product`
    _ = ((Real.exp (K2 * M)
          * ((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) :=
        -- 人手 7: ℝ の積の可換律・結合律
        congrArg (fun x : ℝ => (x : ℂ)) (by
          rw [mul_comm _ (Real.exp (K2 * M)), mul_left_comm, mul_comm (Real.exp (K1 * openChainEnergy s))])

/-! ## Step 5 -/

/-- **人手 Step 5 の一つ目の鎖**（4 行）:
`tr(exp(κD_0)(εV_2)) = (exp(-K_2M_col)S_cosh)_ℂ`、`S_cosh := ∑_{s∈𝔐} exp(K_1E(s))`。 -/
theorem trace_matExp_openChainD0_mul_epsilon_mul_V2 (K1 K2 : ℝ) :
    (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2)).trace
      = ((Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2)).trace
      = ∑ s : SpinConf M, (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2))
          (configBasisIso M s) (configBasisIso M s) :=
        trace_eq_sum_configBasisIso _                              -- 人手 1: `def_trace` と準備の和の定め方
    _ = ∑ s : SpinConf M, ((Real.exp (-(K2 * M)) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun s _ =>
          matExp_openChainD0_mul_epsilon_mul_V2_apply_self K1 K2 s  -- 人手 2: Step 4
    _ = ((∑ s : SpinConf M, Real.exp (-(K2 * M)) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        -- 人手 3: `real_inclusion_preserves_finite_sum`
        real_inclusion_of_finite_sum_fintype _
    _ = ((Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        -- 人手 4: `finite_sum_of_real_scalar_multiples`
        congrArg (fun x : ℝ => (x : ℂ)) (finite_sum_over_spinConf_of_real_scalar_multiples _ _)

/-- **人手 Step 5 の二つ目の鎖**（4 行）:
`tr(exp(κD_0)(GV_2)) = (exp(K_2M_col)S_sinh)_ℂ`、`S_sinh := ∑_{s∈𝔐} s(M_col)s(1)exp(K_1E(s))`。 -/
theorem trace_matExp_openChainD0_mul_boundaryG_mul_V2 (hM : M ≠ 0) (K1 K2 : ℝ) :
    (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2)).trace
      = ((Real.exp (K2 * M) * ∑ s : SpinConf M,
          (s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
  calc (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2)).trace
      = ∑ s : SpinConf M, (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM * V2 M K2))
          (configBasisIso M s) (configBasisIso M s) :=
        trace_eq_sum_configBasisIso _                              -- 人手 1: `def_trace` と準備の和の定め方
    _ = ∑ s : SpinConf M, ((Real.exp (K2 * M)
          * ((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun s _ =>
          matExp_openChainD0_mul_boundaryG_mul_V2_apply_self hM K1 K2 s  -- 人手 2: Step 4
    _ = ((∑ s : SpinConf M, Real.exp (K2 * M)
          * ((s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) :=
        -- 人手 3: `real_inclusion_preserves_finite_sum`
        real_inclusion_of_finite_sum_fintype _
    _ = ((Real.exp (K2 * M) * ∑ s : SpinConf M,
          (s (lastSite M hM) : ℝ) * (s (firstSite M hM) : ℝ) * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) :=
        -- 人手 4: `finite_sum_of_real_scalar_multiples`
        congrArg (fun x : ℝ => (x : ℂ)) (finite_sum_over_spinConf_of_real_scalar_multiples _ _)

/-- **人手 Step 5 の組み立ての鎖**（11 行）:
`tr(εV^{(+)}) = (cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh))_ℂ`。 -/
theorem trace_epsilon_VPlusOfTransfer_eq_spin_sums (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = ((Real.cosh K1 * (Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s))
          + Real.sinh K1 * (Real.exp (K2 * M) * ∑ s : SpinConf M,
              (s (lastSite M (by omega)) : ℝ) * (s (firstSite M (by omega)) : ℝ)
                * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) := by
  have hM0 : M ≠ 0 := by omega
  calc (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = (epsilon M * V1plus M (K1 : ℂ) * V2 M K2).trace :=
        trace_epsilon_VPlusOfTransfer _ _                          -- 人手 1: Step 1
    _ = (matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M hM0)
          * V2 M K2).trace := by
        rw [epsilon_mul_V1plus hM]                                 -- 人手 2: Step 2
    _ = (matExp ((K1 : ℂ) • openChainD0 M)
          * ((((Real.cosh K1 : ℝ) : ℂ) • epsilon M + ((Real.sinh K1 : ℝ) : ℂ) • boundaryG M hM0)
            * V2 M K2)).trace := by
        -- 人手 3: `mat_mult_associative`（具体版が無いので既存の慣行どおり `Matrix.mul_assoc`）
        rw [Matrix.mul_assoc]
    _ = (matExp ((K1 : ℂ) • openChainD0 M)
          * ((((Real.cosh K1 : ℝ) : ℂ) • epsilon M) * V2 M K2
            + (((Real.sinh K1 : ℝ) : ℂ) • boundaryG M hM0) * V2 M K2)).trace := by
        rw [add_mul_matrix_tensorPow]                              -- 人手 4: `mat_mult_distributes_over_sum_in_left_factor`
    _ = (matExp ((K1 : ℂ) • openChainD0 M)
          * (((Real.cosh K1 : ℝ) : ℂ) • (epsilon M * V2 M K2)
            + ((Real.sinh K1 : ℝ) : ℂ) • (boundaryG M hM0 * V2 M K2))).trace := by
        -- 人手 5: `scalar_multiple_factors_out_of_left_factor`（2 か所へ同時適用）
        rw [smul_mul_matrix_tensorPow, smul_mul_matrix_tensorPow]
    _ = (matExp ((K1 : ℂ) • openChainD0 M) * (((Real.cosh K1 : ℝ) : ℂ) • (epsilon M * V2 M K2))
          + matExp ((K1 : ℂ) • openChainD0 M)
            * (((Real.sinh K1 : ℝ) : ℂ) • (boundaryG M hM0 * V2 M K2))).trace := by
        rw [mul_add_matrix_tensorPow]                              -- 人手 6: `mat_mult_distributes_over_sum_in_right_factor`
    _ = (((Real.cosh K1 : ℝ) : ℂ) • (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2))
          + ((Real.sinh K1 : ℝ) : ℂ)
            • (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM0 * V2 M K2))).trace := by
        -- 人手 7: `scalar_multiple_factors_out_of_right_factor`（2 か所へ同時適用）
        rw [mul_smul_matrix_tensorPow, mul_smul_matrix_tensorPow]
    _ = ((Real.cosh K1 : ℝ) : ℂ) * (matExp ((K1 : ℂ) • openChainD0 M) * (epsilon M * V2 M K2)).trace
          + ((Real.sinh K1 : ℝ) : ℂ)
            * (matExp ((K1 : ℂ) • openChainD0 M) * (boundaryG M hM0 * V2 M K2)).trace :=
        trace_linear _ _ _ _                                       -- 人手 8: `trace_basic_properties` (1)
    _ = ((Real.cosh K1 : ℝ) : ℂ)
          * ((Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ)
          + ((Real.sinh K1 : ℝ) : ℂ)
            * ((Real.exp (K2 * M) * ∑ s : SpinConf M,
                (s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ)
                  * Real.exp (K1 * openChainEnergy s) : ℝ) : ℂ) := by
        -- 人手 9: 直前の二つの鎖
        rw [trace_matExp_openChainD0_mul_epsilon_mul_V2, trace_matExp_openChainD0_mul_boundaryG_mul_V2]
    _ = ((Real.cosh K1 * (Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ)
          + ((Real.sinh K1 * (Real.exp (K2 * M) * ∑ s : SpinConf M,
                (s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ)
                  * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) := by
        -- 人手 10: `real_inclusion_preserves_product`（2 か所へ同時適用）
        rw [real_inclusion_mul, real_inclusion_mul]
    _ = ((Real.cosh K1 * (Real.exp (-(K2 * M)) * ∑ s : SpinConf M, Real.exp (K1 * openChainEnergy s))
          + Real.sinh K1 * (Real.exp (K2 * M) * ∑ s : SpinConf M,
              (s (lastSite M hM0) : ℝ) * (s (firstSite M hM0) : ℝ)
                * Real.exp (K1 * openChainEnergy s)) : ℝ) : ℂ) :=
        real_inclusion_add _ _                                     -- 人手 11: `real_inclusion_preserves_sum`

/-- 人手 Step 5 の実数の鎖の 4 行目の根拠「同じ実数を `M_col` 個足すと `M_col` 倍」の `+K_2` の側:
`∑_{j=1}^{M} c = cM`。人手は名前の付いたブロックを引かないので、mathlib の `Finset.sum_const`・`nsmul_eq_mul` で閉じる。 -/
theorem finite_sum_of_constant_real (M : ℕ) (c : ℝ) :
    ∑ _j : Fin M, c = c * M := by
  rw [Finset.sum_const, Finset.card_univ, Fintype.card_fin, nsmul_eq_mul, mul_comm]

/-- 同じ根拠の `-K_2` の側: `∑_{j=1}^{M} (-c) = -(cM)`。人手の `-K_2M_col` を Lean は `-(K_2 · M)` と括弧付けするので、
`finite_sum_of_constant_real` の `(-c)M` を `-(cM)` へ読み替える段（`neg_mul`）をここに置く。 -/
theorem finite_sum_of_negated_constant_real (M : ℕ) (c : ℝ) :
    ∑ _j : Fin M, (-c) = -(c * M) := by
  rw [finite_sum_of_constant_real, neg_mul]

/-- **人手 Step 5 の実数の鎖**（左辺と 8 行）:
`cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh)
  = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}`。
人手の `M_col` は Lean の `n + 1`（`M_col - 1 ≥ 1` は `1 ≤ n`）。人手の冪 `x^n := ∏_{j=1}^{n} x` は Lean の `x ^ n`
（mathlib の `Monoid.npow`）で、両者を行き来する段は `Fin.prod_const`（`∏_{j : Fin n} x = x ^ n`）を引く。
人手 3 の根拠 `def_finite_product_of_real_numbers` の帰納の式 `∏_{j=1}^{n+1} x = (∏_{j=1}^{n} x)x` は、`Fin.prod_const` で
冪へ移した形 `x^{n+1} = x^n x`（Lean の `pow_succ`）で読む。 -/
theorem spin_sums_combination_eq_closed_form (n : ℕ) (hn : 1 ≤ n) (K1 K2 : ℝ) :
    Real.cosh K1 * (Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ)))
          * ∑ s : SpinConf (n + 1), Real.exp (K1 * openChainEnergy s))
        + Real.sinh K1 * (Real.exp (K2 * ((n + 1 : ℕ) : ℝ))
          * ∑ s : SpinConf (n + 1), (s (lastSite (n + 1) (by omega)) : ℝ)
              * (s (firstSite (n + 1) (by omega)) : ℝ) * Real.exp (K1 * openChainEnergy s))
      = (2 * Real.exp (-K2) * Real.cosh K1) ^ (n + 1) + (2 * Real.exp K2 * Real.sinh K1) ^ (n + 1) := by
  have hM : 2 ≤ n + 1 := by omega
  calc Real.cosh K1 * (Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ)))
            * ∑ s : SpinConf (n + 1), Real.exp (K1 * openChainEnergy s))
        + Real.sinh K1 * (Real.exp (K2 * ((n + 1 : ℕ) : ℝ))
          * ∑ s : SpinConf (n + 1), (s (lastSite (n + 1) (by omega)) : ℝ)
              * (s (firstSite (n + 1) (by omega)) : ℝ) * Real.exp (K1 * openChainEnergy s))
      = Real.cosh K1 * (Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ))) * (2 * (2 * Real.cosh K1) ^ (n + 1 - 1)))
        + Real.sinh K1 * (Real.exp (K2 * ((n + 1 : ℕ) : ℝ)) * (2 * (2 * Real.sinh K1) ^ (n + 1 - 1))) := by
        -- 人手 1: `open_chain_partition_sum` と `open_chain_endpoint_product_sum` を `K = K_1` に
        rw [open_chain_partition_sum hM K1, open_chain_endpoint_product_sum hM K1]
    _ = Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ))) * ((2 * Real.cosh K1) ^ n * (2 * Real.cosh K1))
        + Real.exp (K2 * ((n + 1 : ℕ) : ℝ)) * ((2 * Real.sinh K1) ^ n * (2 * Real.sinh K1)) := by
        -- 人手 2: ℝ の積の可換律・結合律（指数の `n + 1 - 1` は Lean の自然数の引き算で、`n` と同じ数）
        rw [Nat.add_sub_cancel]
        ac_rfl
    _ = Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ))) * (2 * Real.cosh K1) ^ (n + 1)
        + Real.exp (K2 * ((n + 1 : ℕ) : ℝ)) * (2 * Real.sinh K1) ^ (n + 1) := by
        -- 人手 3: `def_finite_product_of_real_numbers` の帰納的定義（`x^{n+1} = x^n x`、2 か所へ同時に、右辺から左辺へ）
        rw [← pow_succ, ← pow_succ]
    _ = Real.exp (∑ _j : Fin (n + 1), (-K2)) * (2 * Real.cosh K1) ^ (n + 1)
        + Real.exp (∑ _j : Fin (n + 1), K2) * (2 * Real.sinh K1) ^ (n + 1) := by
        -- 人手 4: ℝ の有限和: 同じ実数 `∓K_2` を `M_col` 個足すと `∓K_2M_col`
        rw [finite_sum_of_negated_constant_real, finite_sum_of_constant_real]
    _ = (∏ _j : Fin (n + 1), Real.exp (-K2)) * (2 * Real.cosh K1) ^ (n + 1)
        + (∏ _j : Fin (n + 1), Real.exp K2) * (2 * Real.sinh K1) ^ (n + 1) := by
        -- 人手 5: `real_exp_of_finite_sum`（2 か所へ同時に）
        rw [real_exp_of_finite_sum n (fun _ => -K2), real_exp_of_finite_sum n (fun _ => K2)]
    _ = (∏ _j : Fin (n + 1), Real.exp (-K2)) * (∏ _j : Fin (n + 1), 2 * Real.cosh K1)
        + (∏ _j : Fin (n + 1), Real.exp K2) * (∏ _j : Fin (n + 1), 2 * Real.sinh K1) := by
        -- 人手 6: 冪の定義 `x^n := ∏_{j=1}^{n} x`（2 か所へ同時に、右辺から左辺へ）
        rw [Fin.prod_const (n + 1) (2 * Real.cosh K1), Fin.prod_const (n + 1) (2 * Real.sinh K1)]
    _ = (∏ _j : Fin (n + 1), Real.exp (-K2) * (2 * Real.cosh K1))
        + (∏ _j : Fin (n + 1), Real.exp K2 * (2 * Real.sinh K1)) := by
        -- 人手 7: `finite_product_of_real_products`（2 か所へ同時に、右辺から左辺へ）
        rw [finite_product_of_real_products n (fun _ => Real.exp (-K2)) (fun _ => 2 * Real.cosh K1),
          finite_product_of_real_products n (fun _ => Real.exp K2) (fun _ => 2 * Real.sinh K1)]
    _ = (2 * Real.exp (-K2) * Real.cosh K1) ^ (n + 1) + (2 * Real.exp K2 * Real.sinh K1) ^ (n + 1) := by
        -- 人手 8: ℝ の積の可換律・結合律と冪の定義
        rw [Fin.prod_const, Fin.prod_const]
        ac_rfl

/-- 人手 Step 5 の「ゆえに主張の等号が成り立つ」: 組み立ての鎖（`trace_epsilon_VPlusOfTransfer_eq_spin_sums`）の右辺の
括弧の中の実数を、実数の鎖（`spin_sums_combination_eq_closed_form`）で書き換える。
`tr(εV^{(+)}) = ((2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col})_ℂ`。 -/
theorem trace_epsilon_VPlusOfTransfer_closed_form (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = (((2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M : ℝ) : ℂ) := by
  obtain ⟨n, rfl⟩ : ∃ n : ℕ, M = n + 1 := ⟨M - 1, by omega⟩
  rw [trace_epsilon_VPlusOfTransfer_eq_spin_sums hM K1 K2,
    spin_sums_combination_eq_closed_form n (by omega) K1 K2]

/-! ## Step 6 -/

/-- **人手 Step 6**: `(2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} > 0`。
Step 5 の実数の鎖の左辺の二項がともに正であること（`open_chain_spin_sums_positive` の `S_cosh > 0`・`S_sinh > 0`、
`cosh_sinh_basic_properties` (3) から `cosh K_1 > sinh K_1 > 0`、`real_exp_positive` から `exp(∓K_2M_col) > 0`、
正の実数の積は正）から左辺が正（正の実数の和は正）、それが右辺に等しい。
「正の実数の積・和は正」は人手が名前の付いたブロックを引かないので mathlib の `mul_pos`・`add_pos` を引く。 -/
theorem closed_form_of_trace_epsilon_V_plus_pos (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    0 < (2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M := by
  obtain ⟨n, rfl⟩ : ∃ n : ℕ, M = n + 1 := ⟨M - 1, by omega⟩
  -- `cosh_sinh_basic_properties` (3) と `K_1 > 0`
  have hsinh : Real.sinh K1 > 0 := (cosh_sinh_basic_properties_3 hK1).2
  have hcosh : Real.cosh K1 > 0 := lt_trans hsinh (cosh_sinh_basic_properties_3 hK1).1
  rw [← spin_sums_combination_eq_closed_form n (by omega) K1 K2]
  exact add_pos
    (mul_pos hcosh (mul_pos (real_exp_positive _) (open_chain_partition_sum_pos hM hK1)))
    (mul_pos hsinh (mul_pos (real_exp_positive _) (open_chain_endpoint_product_sum_pos hM hK1)))

/-- `0 < Re tr(εV^{(+)})`: Step 5 の主張の等号で `tr(εV^{(+)})` を実数の包含に書き、その実部（包含した実数そのもの）に
Step 6 を当てる。 -/
theorem trace_epsilon_VPlusOfTransfer_pos (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    0 < ((epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace).re := by
  rw [trace_epsilon_VPlusOfTransfer_closed_form hM K1 K2, Complex.ofReal_re]
  exact closed_form_of_trace_epsilon_V_plus_pos hM hK1 K2

/-! ## 主張 -/

/-- **人手 `trace_of_epsilon_V_plus`**:
`tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}`。 -/
theorem trace_of_epsilon_V_plus (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
        = (((2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M : ℝ) : ℂ)
      ∧ 0 < ((epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace).re :=
  ⟨trace_epsilon_VPlusOfTransfer_closed_form hM K1 K2, trace_epsilon_VPlusOfTransfer_pos hM hK1 K2⟩

/-- 最終定理の入力が持つ `vPlusDataOf` の `V^{(+)}`（`VPlus M (sinh 2K_2) K_1 K_2^*`）について `tr(εV^{(+)}) > 0`。
`VPlusOfTransfer_eq_VPlus` で人手 `def_V_plus` の形へ戻して `trace_of_epsilon_V_plus` を使う。 -/
theorem trace_epsilon_vPlusDataOf_pos (P : IsingParam) (hM2 : 2 ≤ M) (hM : M ≠ 0) :
    0 < ((epsilon M * (vPlusDataOf P hM P.c2_mul_s2star_eq_c2star).V).trace).re := by
  rw [vPlusDataOf_V, IsingParam.K2star, ← VPlusOfTransfer_eq_VPlus P.K2_pos]
  exact (trace_of_epsilon_V_plus hM2 P.K1_pos P.K2).2

end Ising2D
