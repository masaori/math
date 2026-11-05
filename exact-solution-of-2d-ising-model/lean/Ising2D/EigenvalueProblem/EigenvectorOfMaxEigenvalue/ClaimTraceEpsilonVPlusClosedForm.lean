/-
# `tr(εV^{(+)})` を二つのスピン和で書き、閉じた式と正値性を得る（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_006_theorem_trace_of_epsilon_V_plus`、ラベル **`trace_of_epsilon_V_plus`** の Step 4・Step 5・Step 6 と主張）

旧い分け方のまま残っているのは、表の「Step 5 の実数の鎖」の行が指す `trace_epsilon_VPlusOfTransfer_closed_form` の本体（4 段）だけである（(t9) で人手の 9 行と 1 対 1 に書き直す）。

| 人手 | Lean |
| --- | --- |
| Step 4 の一つ目の鎖（7 行）`(exp(κD_0)(εV_2))_{ord(s),ord(s)} = ⋯ = (exp(-K_2M_col)exp(K_1E(s)))_ℂ` | `matExp_openChainD0_mul_epsilon_mul_V2_apply_self` の 7 段 |
| Step 4 の二つ目の鎖（7 行）`(exp(κD_0)(GV_2))_{ord(s),ord(s)} = ⋯ = (exp(K_2M_col)(s(M_col)s(1)exp(K_1E(s))))_ℂ` | `matExp_openChainD0_mul_boundaryG_mul_V2_apply_self` の 7 段 |
| Step 5 の `tr(X) = ∑_{s∈𝔐} X_{ord(s),ord(s)}`（`def_trace` と準備の和の定め方） | `trace_eq_sum_configBasisIso` |
| Step 5 の二つの鎖の 4 行目の根拠 `finite_sum_of_real_scalar_multiples` を 𝔐 の上の和へ当てたもの | `finite_sum_over_spinConf_of_real_scalar_multiples` |
| Step 5 の一つ目のトレースの鎖（4 行）`tr(exp(κD_0)(εV_2)) = ⋯ = (exp(-K_2M_col)S_cosh)_ℂ` | `trace_matExp_openChainD0_mul_epsilon_mul_V2` の 4 段 |
| Step 5 の二つ目のトレースの鎖（4 行）`tr(exp(κD_0)(GV_2)) = ⋯ = (exp(K_2M_col)S_sinh)_ℂ` | `trace_matExp_openChainD0_mul_boundaryG_mul_V2` の 4 段 |
| Step 5 の組み立ての鎖（11 行）`tr(εV^{(+)}) = ⋯ = (cosh K_1(exp(-K_2M_col)S_cosh) + sinh K_1(exp(K_2M_col)S_sinh))_ℂ` | `trace_epsilon_VPlusOfTransfer_eq_spin_sums` の 11 段（印 `人手 1`〜`人手 11`） |
| Step 5 の実数の鎖（9 行）と「ゆえに主張の等号が成り立つ」 | `trace_epsilon_VPlusOfTransfer_closed_form`（旧い分け方の 4 段のまま） |
| Step 6（正値性） | `trace_epsilon_VPlusOfTransfer_pos` |
| 主張 `tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col} ∈ ℝ_{>0}` | `trace_of_epsilon_V_plus` |

`S_cosh`・`S_sinh` は Lean では名前を付けず、和 `∑ s : SpinConf M, …` をそのまま書く。
Lean の具体版が無い根拠は、既存の慣行どおり mathlib を引く。二つのトレースの鎖の 3 行目 `real_inclusion_preserves_finite_sum` は
`Complex.ofReal_sum`、組み立ての鎖の 3 行目 `mat_mult_associative` は `Matrix.mul_assoc` である。組み立ての鎖のほかの根拠は具体版で、分配と括り出しは `TensorPow M` での系
`add_mul_matrix_tensorPow`・`mul_add_matrix_tensorPow`・`smul_mul_matrix_tensorPow`・`mul_smul_matrix_tensorPow`、
`trace_basic_properties` (1) は `trace_linear`、`real_inclusion_preserves_product`・`real_inclusion_preserves_sum` は
`real_inclusion_mul`・`real_inclusion_add` である。

`V^{(+)}` は人手 `def_V_plus` の `(V_1^{(+)})^{1/2}V_2(V_1^{(+)})^{1/2}`、Lean の `VPlusOfTransfer M K_1 K_2` である。
最終定理の入力が持つ `vPlusDataOf` の `V^{(+)}` は、`V_2` を `V2_exponential_representation` で書き換えた形
`VPlus M (sinh 2K_2) K_1 K_2^*` なので、`VPlusOfTransfer_eq_VPlus` で人手の形へ戻して
`trace_epsilon_vPlusDataOf_pos` を得る。これで最終定理 `onsager_exact_solution_unconditional` の入力から `htr` を外した。

正値性（`trace_epsilon_VPlusOfTransfer_pos`）は、組み立ての鎖の右辺の二項がともに正であることから出す
（`open_chain_spin_sums_positive`（`open_chain_partition_sum_pos`・`open_chain_endpoint_product_sum_pos`）、
`cosh K_1 > 0`、`sinh K_1 > 0`、`exp(∓K_2M_col) > 0`）。人手 Step 6 は実数の鎖の左辺（同じ実数）の二項から出す。

必要十分版は置かない。一般化できるのは、行列の積の分配と対角成分の読み取り（可換環上の行列で成り立つ）と、
順序体での正の数の積と和の正値性だけで、必要十分版にしても何が本質的かについて情報を与えない
（`ClaimTraceEpsilonVPlusMatrixEntries.lean` と同じ扱い。二つのスピン和の一般形は `NecSuf/OpenChainSpinSum.lean` が既に持つ）。
-/
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusMatrixEntries
import Ising2D.EigenvalueProblem.EigenvectorOfMaxEigenvalue.ClaimTraceEpsilonVPlusReduction
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.ClaimVPlusDataFromEigenvaluesOfVPlus

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
        -- 人手 3: `real_inclusion_preserves_finite_sum`（具体版が無いので既存の慣行どおり `Complex.ofReal_sum`）
        (Complex.ofReal_sum _ _).symm
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
        -- 人手 3: `real_inclusion_preserves_finite_sum`（具体版が無いので既存の慣行どおり `Complex.ofReal_sum`）
        (Complex.ofReal_sum _ _).symm
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

/-- **人手 Step 5 の実数の鎖**（旧い分け方の 4 段のまま。(t9) で人手の 9 行に揃える）:
`tr(εV^{(+)}) = (2exp(-K_2)cosh K_1)^{M_col} + (2exp(K_2)sinh K_1)^{M_col}`。 -/
theorem trace_epsilon_VPlusOfTransfer_closed_form (hM : 2 ≤ M) (K1 K2 : ℝ) :
    (epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace
      = (((2 * Real.exp (-K2) * Real.cosh K1) ^ M + (2 * Real.exp K2 * Real.sinh K1) ^ M : ℝ) : ℂ) := by
  rw [trace_epsilon_VPlusOfTransfer_eq_spin_sums hM K1 K2]
  congr 1
  obtain ⟨n, rfl⟩ : ∃ n : ℕ, M = n + 1 := ⟨M - 1, by omega⟩
  calc Real.cosh K1 * (Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ)))
            * ∑ s : SpinConf (n + 1), Real.exp (K1 * openChainEnergy s))
        + Real.sinh K1 * (Real.exp (K2 * ((n + 1 : ℕ) : ℝ))
          * ∑ s : SpinConf (n + 1), (s (lastSite (n + 1) (by omega)) : ℝ)
              * (s (firstSite (n + 1) (by omega)) : ℝ) * Real.exp (K1 * openChainEnergy s))
      = Real.cosh K1 * (Real.exp (-(K2 * ((n + 1 : ℕ) : ℝ))) * (2 * (2 * Real.cosh K1) ^ (n + 1 - 1)))
        + Real.sinh K1 * (Real.exp (K2 * ((n + 1 : ℕ) : ℝ)) * (2 * (2 * Real.sinh K1) ^ (n + 1 - 1))) := by
        -- 二つの 1 次元開鎖のスピン和公式（`open_chain_partition_sum`・`open_chain_endpoint_product_sum`、`K = K_1`）
        rw [open_chain_partition_sum hM K1, open_chain_endpoint_product_sum hM K1]
    -- `2·2^{M_col-1} = 2^{M_col}`、`cosh(K_1)(cosh K_1)^{M_col-1} = (cosh K_1)^{M_col}`（`sinh` も同じ）
    _ = 2 ^ (n + 1) * Real.exp (-(((n + 1 : ℕ) : ℝ) * K2)) * Real.cosh K1 ^ (n + 1)
        + 2 ^ (n + 1) * Real.exp (((n + 1 : ℕ) : ℝ) * K2) * Real.sinh K1 ^ (n + 1) := by
        rw [Nat.add_sub_cancel, mul_comm K2]
        ring
    -- 指数法則 `exp(±M_colK_2) = (exp(±K_2))^{M_col}`
    _ = 2 ^ (n + 1) * Real.exp (-K2) ^ (n + 1) * Real.cosh K1 ^ (n + 1)
        + 2 ^ (n + 1) * Real.exp K2 ^ (n + 1) * Real.sinh K1 ^ (n + 1) := by
        rw [← Real.exp_nat_mul, ← Real.exp_nat_mul, mul_neg]
    -- 積の冪の分配
    _ = (2 * Real.exp (-K2) * Real.cosh K1) ^ (n + 1) + (2 * Real.exp K2 * Real.sinh K1) ^ (n + 1) := by
        rw [mul_pow, mul_pow, mul_pow, mul_pow]

/-! ## Step 6 -/

/-- **人手 Step 6**: `tr(εV^{(+)}) > 0`。Step 5 の組み立ての鎖の右辺の二項がともに正であることから出す
（`open_chain_spin_sums_positive`、`cosh K_1 > 0`、`sinh K_1 > 0`、`exp(∓K_2M_col) > 0`）。 -/
theorem trace_epsilon_VPlusOfTransfer_pos (hM : 2 ≤ M) {K1 : ℝ} (hK1 : 0 < K1) (K2 : ℝ) :
    0 < ((epsilon M * VPlusOfTransfer M (K1 : ℂ) K2).trace).re := by
  rw [trace_epsilon_VPlusOfTransfer_eq_spin_sums hM K1 K2, Complex.ofReal_re]
  exact add_pos
    (mul_pos (Real.cosh_pos K1) (mul_pos (Real.exp_pos _) (open_chain_partition_sum_pos hM hK1)))
    (mul_pos (Real.sinh_pos_iff.mpr hK1) (mul_pos (Real.exp_pos _)
      (open_chain_endpoint_product_sum_pos hM hK1)))

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
