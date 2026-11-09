/-
# 数演算子とその補の積のトレース `tr(R_{μ_1}^{(e_1)}⋯R_{μ_k}^{(e_k)}) = 2^{M-k}`（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`trace_of_check_number_operator_product`（`evenEigen_004_claim_...`）。

**人手の証明と 1 対 1 の具体版**は下の節の `trace_projFactor_finProdLeft`（`k ≥ 1`。積は `def_finite_product_of_matrices` の左から掛ける
`NecSuf.finProdLeft`、相異なる添字の列は単射 `μ : Fin k → 𝓜̌`）と、基底段階 `trace_identity_base_case`（`k = 0`）である。
その**必要十分版**は `Ising2D/NecSuf/TraceOfNumberOperatorProductByLastFactor.lean` の `NecSuf.tau_finProdLeft_projFactor`（同じ手順）で、
特殊化は `ClaimTraceCheckNumberOperatorProductFromNecSuf.lean` の `trace_projFactor_finProdLeft_of_necSuf`。

同じ主張を添字の集合 `S` と `Finset.noncommProd` で述べた `trace_projFactorProd`、`ň` だけの積の `trace_nOpProd`（人手の「とくに」）は、
人手と別の手順の必要十分版 `Ising2D/NecSuf/JointEigenspace.lean` の `NecSuf.two_pow_smul_tau_projOn`・`Ising2D/NecSuf/PairedFermion.lean` の
`NecSuf.two_pow_smul_tau_noncommProd` の特殊化である。

## 章 009 との違い

章 009 では添字集合 `I` が `{1,…,M}` の真部分集合になりえた（臨界点で `|I| = M-1`）ので、
`k` は `|I|` までしか走れなかった。半整数運動量では `𝓜̌ = {1,…,M}` なので
`k = M` まで走れて `tr(R_1^{(e_1)}⋯R_M^{(e_M)}) = 2^0 = 1` になる。
`tr(Q̌_ε) = 1`（同時固有空間が 1 次元）の根拠は、`trace_projFactor_finProdLeft` を `μ → checkIdxOfFin`（`𝓜̌` 全体）で使う
`ClaimCheckJointEigenspace.lean` の `trace_Qproj_step4` である（人手の範囲外の `M = 0` だけ `trace_projFactorProd` を使う）。

## 積の順序について

人手証明の帰納法は、相異なる添字の全ての列について、最後の因子を分けて示す。積の順序の入れ替えは使わない。
`trace_projFactorProd` は `Finset.noncommProd`（可換性の証明を引数に取る積）で述べてある（章 009 の `NecSuf.projOn` と同じ扱い）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.DefinitionCheckNumberOperator
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesPower
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers
import Ising2D.PartitionFunction.TransferMatrixRepresentation.DefinitionConfigBasisIso
import Ising2D.NecSuf.FiniteProductLeft
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesSum
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteProductsOfCommutingMatricesFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimCommutingWithDifferenceFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatrixDifferenceIsSumWithNegationFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationFactorsOutOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleByOneFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationIsScalarMultipleByMinusOneFromNecSuf

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- 相異なる添字の集合 `S` にわたる `ň_μ` の積（人手証明の `ň_{μ_1}⋯ň_{μ_k}`）。 -/
noncomputable def nOpProd (S : Finset (CheckIdx M)) : TensorPow M :=
  S.noncommProd (NecSuf.num F.cre F.ann) fun i _ j _ _ => F.commute_nOp_nOp i j

theorem nOpProd_eq (S : Finset (CheckIdx M)) :
    F.nOpProd S = S.noncommProd F.nOp fun i _ j _ _ => F.commute_nOp_nOp i j := rfl

@[simp]
theorem nOpProd_empty : F.nOpProd ∅ = 1 := Finset.noncommProd_empty _ _

/-- **原文 `trace_of_check_number_operator_product`**:
相異なる `μ_1,…,μ_k ∈ 𝓜̌` について `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}`。 -/
theorem trace_nOpProd (S : Finset (CheckIdx M)) :
    (F.nOpProd S).trace = ((2 ^ (M - S.card) : ℕ) : ℂ) := by
  have h : ((2 ^ S.card : ℕ) : ℂ) * (F.nOpProd S).trace = ((2 ^ M : ℕ) : ℂ) := by
    have h0 := NecSuf.two_pow_smul_tau_noncommProd F.cre F.ann F.commute_nOp_nOp
      (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
      (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
      (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij) S
    rw [trace_one_tensorPow, nsmul_eq_mul] at h0
    exact h0
  have hle : S.card ≤ M := by
    have := Finset.card_le_univ S
    rwa [CheckIdx.card] at this
  have hsplit : ((2 ^ M : ℕ) : ℂ)
      = ((2 ^ S.card : ℕ) : ℂ) * ((2 ^ (M - S.card) : ℕ) : ℂ) := by
    rw [← Nat.cast_mul, ← pow_add]
    congr 2
    omega
  have hne : ((2 ^ S.card : ℕ) : ℂ) ≠ 0 := by simp
  exact mul_left_cancel₀ hne (h.trans hsplit)

/-- **原文 `trace_of_check_number_operator_product`**（因子の混在を許す主張そのもの）:
相異なる `μ_1,…,μ_k ∈ 𝓜̌` と `e_1,…,e_k ∈ {0,1}` について `tr(R_{μ_1}^{(e_1)}⋯R_{μ_k}^{(e_k)}) = 2^{M_col-k}`
（`R_μ^{(1)} = ň_μ`、`R_μ^{(0)} = I - ň_μ`）。
人手の `{μ_1,…,μ_k}` が Lean の `S`（`k = |S|`）、`e_i = 1` が `μ_i ∈ T`、`R_μ^{(e)}` が `NecSuf.projFactor F.nOp T μ` で、
積は `NecSuf.projOn`（`Finset.noncommProd`。人手の「積の順序に依らない」）である。右辺の `2^{M_col-k}` は `ℂ` の冪
（`def_power_of_complex_number`）で、指数は `ℕ` の差（`k ≤ M_col` なので切り捨ては起きない）である。
必要十分版 `NecSuf.two_pow_smul_tau_projOn` の特殊化で、`2^k · tr(R_{μ_1}^{(e_1)}⋯) = tr(I) = 2^{M_col}` から `2^k` を約分する。
人手の証明（`k` についての帰納法）と 1 対 1 の具体版は、積を `def_finite_product_of_matrices` の形で書いた下の
`trace_projFactor_finProdLeft` である。 -/
theorem trace_projFactorProd (S T : Finset (CheckIdx M)) :
    (NecSuf.projOn F.nOp F.commute_nOp_nOp S T).trace = (2 : ℂ) ^ (M - S.card) := by
  have h : (2 : ℂ) ^ S.card * (NecSuf.projOn F.nOp F.commute_nOp_nOp S T).trace = (2 : ℂ) ^ M := by
    have h0 := NecSuf.two_pow_smul_tau_projOn F.cre F.ann F.commute_nOp_nOp
      (Matrix.trace : TensorPow M → ℂ) (fun x y => Matrix.trace_add x y)
      (fun x y => Matrix.trace_mul_comm x y) F.acomm_cre_ann_self
      (fun i j hij => F.commute_cre_nOp hij) (fun i j hij => F.commute_ann_nOp hij) S T
    rw [trace_one_tensorPow, nsmul_eq_mul] at h0
    push_cast at h0
    exact h0
  have hle : S.card ≤ M := by
    have := Finset.card_le_univ S
    rwa [CheckIdx.card] at this
  have hsplit : (2 : ℂ) ^ M = (2 : ℂ) ^ S.card * (2 : ℂ) ^ (M - S.card) := by
    rw [← pow_add]
    congr 1
    omega
  have hne : (2 : ℂ) ^ S.card ≠ 0 := pow_ne_zero _ two_ne_zero
  exact mul_left_cancel₀ hne (h.trans hsplit)

/-! ## 人手の帰納法と 1 対 1 の具体版

人手の証明（`k` についての帰納法。帰納段階は最後の因子 `R_{μ_k}^{(e_k)}` を分ける）の各鎖を、同じ順の `calc` で置く。
人手の `k ∈ ℤ_{≥1}` が Lean の `r + 1`、相異なる添字の列 `μ_1, …, μ_k` が単射 `μ : Fin (r + 1) → 𝓜̌`（人手の `μ_j` が Lean の `μ (j - 1)`）、
`e_j` は `μ_j ∈ T` かどうか（`R_{μ_j}^{(e_j)}` が `NecSuf.projFactor F.nOp T (μ (j - 1))`）である。積は人手の
`def_finite_product_of_matrices` の左から掛ける積 `NecSuf.finProdLeft`（`TensorPow M` の添字は `Conf M` で、具体版の `finiteMatrixProduct` は
添字が `Fin n` の行列について述べてあるため、`Qproj_eq_finProdLeft` と同じくこちらを使う）。人手の `ψ̌_μ^†` が `F.cre μ`、`ψ̌_{M_col+1-μ}` が
`F.ann μ`、`ň_μ = ψ̌_μ^†ψ̌_{M_col+1-μ}` が `F.nOp_def` である。`mat_mult_associative` の行は、ほかのファイルと同じく mathlib の
`Matrix.mul_assoc` で受ける（人手 `mat_mult_associative` の具体版が無い）。各行の右のコメントは、人手の鎖の同じ行の根拠である。 -/

/-- **人手の基底段階**（`k = 0`）: `tr(I) = Σ_{l=1}^{2_ℤ^{M_col}} 1_ℂ = Σ (1_ℝ)_ℂ = (Σ 1_ℝ)_ℂ = (ι(2_ℤ^{M_col})1_ℝ)_ℂ = (ι(2_ℤ^{M_col}))_ℂ
= (2_ℝ^{M_col})_ℂ = ((2_ℝ)_ℂ)^{M_col} = 2^{M_col} = 2^{M_col-0}`。人手の 9 行と 1 対 1 の `calc` に、添字の個数 `#Conf M = 2_ℤ^{M_col}` の
読み替えの 1 段（人手は和の上端を `2_ℤ^{M_col}` で書くので、Lean だけの段。`DefinitionSectorRayleighSup.lean` と同じ）を足したもの。
人手の前置きの `2_ℤ^{M_col} ∈ ℤ_{≥1}`（`power_of_two_in_integers_is_at_least_one`）は `hcard`。
`real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype`（添字 `Conf M` は空でない）。 -/
theorem trace_identity_base_case : (1 : TensorPow M).trace = (2 : ℂ) ^ (M - 0) := by
  have hcard : 1 ≤ Fintype.card (Conf M) := by
    rw [card_conf_nat]; exact power_of_two_in_integers_is_at_least_one M
  calc (1 : TensorPow M).trace
      = ∑ _l : Conf M, (1 : ℂ) := trace_identity_eq_sum_one        -- `trace_basic_properties` (3)（`n → 2_ℤ^{M_col}`、添字 `k → l`）
    _ = ∑ _l : Conf M, ((1 : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun _ _ => Complex.ofReal_one.symm      -- `1_ℂ` は `(1_ℝ)_ℂ` の略記を `2_ℤ^{M_col}` 個の項へ同時に
    _ = ((∑ _l : Conf M, (1 : ℝ) : ℝ) : ℂ) := real_inclusion_of_finite_sum_fintype _
                                                                     -- `real_inclusion_preserves_finite_sum`（`m → 2_ℤ^{M_col}`、添字 `j → l`、`r_j → 1_ℝ`）
    _ = (((Fintype.card (Conf M) : ℝ) * 1 : ℝ) : ℂ) := by
        rw [finite_sum_of_constant_real_number_fintype hcard]        -- `finite_sum_of_constant_real_number`（`m → 2_ℤ^{M_col}`、`r → 1_ℝ`）
    _ = ((((2 ^ M : ℕ) : ℝ) * 1 : ℝ) : ℂ) := by rw [card_conf_nat]   -- 添字の個数 `#Conf M = 2_ℤ^{M_col}`（Lean だけの読み替えの段）
    _ = (((2 ^ M : ℕ) : ℝ) : ℂ) := by rw [mul_one]                     -- `1_ℝ` は `ℝ` の乗法の単位元
    _ = (((2 : ℝ) ^ M : ℝ) : ℂ) := by rw [inclusion_zz_to_rr_of_power_of_two]
                                                                     -- `inclusion_zz_to_rr_of_power_of_two`（`M → M_col`）
    _ = ((2 : ℝ) : ℂ) ^ M := real_inclusion_of_power 2 M                  -- `real_inclusion_preserves_power`（`r → 2_ℝ`、`m → M_col`）
    _ = (2 : ℂ) ^ M := by rw [Complex.ofReal_ofNat]                  -- 主張の右辺の底 `2 := 2_ℂ := (2_ℝ)_ℂ`
    _ = (2 : ℂ) ^ (M - 0) := by rw [Nat.sub_zero]                    -- `M_col - 0 = M_col`

/-- **人手の準備 2** の単位行列との積の鎖（2 行）: `ψ̌_{M_col+1-μ_k} I = ψ̌_{M_col+1-μ_k} = I ψ̌_{M_col+1-μ_k}`。 -/
theorem ann_mul_identity_prep2 (ν : CheckIdx M) : F.ann ν * 1 = 1 * F.ann ν :=
  calc F.ann ν * 1
      = F.ann ν := mul_identity_matrix_tensorPow _                  -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = 1 * F.ann ν := (identity_matrix_mul_tensorPow _).symm       -- `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ

/-- **人手の準備 2** の `e_j` ごとの鎖（各 3 行）: `μ_j ≠ μ_k` なら
`ψ̌_{M_col+1-μ_k} R_{μ_j}^{(e_j)} = R_{μ_j}^{(e_j)} ψ̌_{M_col+1-μ_k}`（人手の `μ_k` が `ν`、`μ_j` が `μ`）。 -/
theorem ann_mul_projFactor_prep2 (T : Finset (CheckIdx M)) {ν μ : CheckIdx M} (h : ν ≠ μ) :
    F.ann ν * NecSuf.projFactor F.nOp T μ = NecSuf.projFactor F.nOp T μ * F.ann ν := by
  by_cases hμ : μ ∈ T
  · -- `e_j = 1`
    calc F.ann ν * NecSuf.projFactor F.nOp T μ
        = F.ann ν * F.nOp μ := by rw [NecSuf.projFactor_of_mem hμ]   -- `R_{μ_j}^{(1)}` の定義（主張）
      _ = F.nOp μ * F.ann ν := F.commute_ann_nOp h                   -- `check_number_operators_commute` (1) の第 2 式（`μ → μ_k`、`ν → μ_j`）
      _ = NecSuf.projFactor F.nOp T μ * F.ann ν := by rw [NecSuf.projFactor_of_mem hμ]
                                                                      -- `R_{μ_j}^{(1)}` の定義（主張）
  · -- `e_j = 0`
    calc F.ann ν * NecSuf.projFactor F.nOp T μ
        = F.ann ν * (1 - F.nOp μ) := by rw [NecSuf.projFactor_of_notMem hμ]
                                                                      -- `R_{μ_j}^{(0)}` の定義（主張）
      _ = (1 - F.nOp μ) * F.ann ν :=
          mul_sub_eq_sub_mul_of_commute_tensorPow (F.ann ν) 1 (F.nOp μ)
            (F.ann_mul_identity_prep2 ν) (F.commute_ann_nOp h)        -- `commuting_with_difference`（`G → ψ̌_{M_col+1-μ_k}`、`X → I`、`W → ň_{μ_j}`）。前提は上の 2 つの鎖
      _ = NecSuf.projFactor F.nOp T μ * F.ann ν := by rw [NecSuf.projFactor_of_notMem hμ]
                                                                      -- `R_{μ_j}^{(0)}` の定義（主張）

/-- **人手の準備 3**（10 行）: `tr(P(I - ň_{μ_k})) = tr(P) - tr(Pň_{μ_k})`。 -/
theorem trace_mul_one_sub_nOp_prep3 (P : TensorPow M) (ν : CheckIdx M) :
    (P * (1 - F.nOp ν)).trace = P.trace - (P * F.nOp ν).trace :=
  calc (P * (1 - F.nOp ν)).trace
      = (P * (1 + (-F.nOp ν))).trace := by rw [sub_eq_add_neg_tensorPow]
                                                          -- `matrix_difference_is_sum_with_negation`（`A → I`、`B → ň_{μ_k}`）
    _ = (P * 1 + P * (-F.nOp ν)).trace := by rw [mul_add_matrix_tensorPow]
                                                          -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = (P + P * (-F.nOp ν)).trace := by rw [mul_identity_matrix_tensorPow]
                                                          -- `identity_matrix_is_right_unit_of_mat_mult`（`A → P`）
    _ = (P + (-(P * F.nOp ν))).trace := by rw [mul_neg_matrix_tensorPow]
                                                          -- `negation_factors_out_of_right_factor`
    _ = ((1 : ℂ) • P + (-(P * F.nOp ν))).trace := by rw [one_smul_tensorPow]
                                                          -- `scalar_multiple_by_one`（`A → P`）を右辺から左辺へ
    _ = ((1 : ℂ) • P + (-1 : ℂ) • (P * F.nOp ν)).trace := by rw [← neg_eq_neg_one_smul_tensorPow]
                                                          -- `negation_is_scalar_multiple_by_minus_one`（`A → Pň_{μ_k}`）
    _ = 1 * P.trace + (-1) * (P * F.nOp ν).trace := trace_linear _ _ _ _
                                                          -- `trace_basic_properties` (1)（`α → 1_ℂ`、`β → -1_ℂ`）
    _ = P.trace + (-1) * (P * F.nOp ν).trace := by rw [one_mul]
                                                          -- `1_ℂ` は `ℂ` の積の単位元
    _ = P.trace + (-(P * F.nOp ν).trace) := by rw [neg_one_mul]
                                                          -- `multiply_by_minus_one` を右辺から左辺へ
    _ = P.trace - (P * F.nOp ν).trace := (sub_eq_add_neg _ _).symm
                                                          -- `def_complex_difference` を右辺から左辺へ

/-- **人手の帰納段階**の `tr(Pň_{μ_k})` の鎖（8 行）: `tr(Pň_{μ_k}) = tr(P) - tr(Pň_{μ_k})`。前提 `hP` は準備 2。 -/
theorem trace_mul_nOp_chain (P : TensorPow M) (ν : CheckIdx M) (hP : F.ann ν * P = P * F.ann ν) :
    (P * F.nOp ν).trace = P.trace - (P * F.nOp ν).trace :=
  calc (P * F.nOp ν).trace
      = (P * (F.cre ν * F.ann ν)).trace := by rw [F.nOp_def]     -- `def_check_number_operator`
    _ = ((P * F.cre ν) * F.ann ν).trace := by rw [Matrix.mul_assoc]
                                                                  -- `mat_mult_associative` を右辺から左辺へ
    _ = (F.ann ν * (P * F.cre ν)).trace := trace_cyclic _ _       -- `trace_basic_properties` (2)
    _ = ((F.ann ν * P) * F.cre ν).trace := by rw [Matrix.mul_assoc]
                                                                  -- `mat_mult_associative` を右辺から左辺へ
    _ = ((P * F.ann ν) * F.cre ν).trace := by rw [hP]             -- 準備 2
    _ = (P * (F.ann ν * F.cre ν)).trace := by rw [Matrix.mul_assoc]
                                                                  -- `mat_mult_associative`
    _ = (P * (1 - F.nOp ν)).trace := by rw [F.ann_mul_cre]        -- `check_number_operator_idempotent` (2)（`μ → μ_k`）
    _ = P.trace - (P * F.nOp ν).trace := F.trace_mul_one_sub_nOp_prep3 P ν
                                                                  -- 準備 3

/-- **人手の準備 4** の第 1 の鎖（4 行）: `2_ℂ = (2_ℝ)_ℂ = (1_ℝ + 1_ℝ)_ℂ = (1_ℝ)_ℂ + (1_ℝ)_ℂ = 1_ℂ + 1_ℂ`。
Lean の `(2 : ℂ)` が人手の `2_ℂ := (2_ℝ)_ℂ`、`((r : ℝ) : ℂ)` が `r_ℂ` である。 -/
theorem two_eq_one_add_one_prep4 : (2 : ℂ) = 1 + 1 :=
  calc (2 : ℂ)
      = ((2 : ℝ) : ℂ) := (Complex.ofReal_ofNat 2).symm              -- `2_ℂ` の置き方
    _ = ((1 + 1 : ℝ) : ℂ) := by rw [one_add_one_eq_two]                            -- `ℝ` で `1 + 1 = 2` を右辺から左辺へ
    _ = ((1 : ℝ) : ℂ) + ((1 : ℝ) : ℂ) := (real_inclusion_add 1 1).symm
                                                                      -- `real_inclusion_preserves_sum` を右辺から左辺へ
    _ = 1 + 1 := by rw [Complex.ofReal_one]                           -- `inclusion_rr_to_cc` の略記 `1_ℂ = (1_ℝ)_ℂ` を 2 箇所へ

/-- **人手の準備 4** の第 2 の鎖（2 行）: `2_ℂ^{-1} 2_ℂ = 2_ℂ 2_ℂ^{-1} = 1_ℂ`。 -/
theorem inv_two_mul_two_prep4 : (2 : ℂ)⁻¹ * 2 = 1 :=
  calc (2 : ℂ)⁻¹ * 2
      = 2 * (2 : ℂ)⁻¹ := mul_comm _ _                                -- `complex_numbers_form_a_field` の積の可換律
    _ = 1 := mul_inv_cancel₀ two_ne_zero                              -- `complex_numbers_form_a_field` の乗法の逆元

/-- **人手の準備 4** の第 3 の鎖（3 行）: `2_ℂ w = (1_ℂ + 1_ℂ) w = 1_ℂ w + 1_ℂ w = w + w`。 -/
theorem two_mul_eq_add_prep4 (w : ℂ) : 2 * w = w + w :=
  calc 2 * w
      = (1 + 1) * w := by rw [← two_eq_one_add_one_prep4]           -- 上の `2_ℂ = 1_ℂ + 1_ℂ`
    _ = 1 * w + 1 * w := add_mul _ _ _                                -- `complex_numbers_form_a_field` の分配律
    _ = w + w := by rw [one_mul]                                      -- `complex_numbers_form_a_field` の積の単位元を 2 箇所へ

/-- **人手の準備 4** の第 4 の鎖（3 行）: `w = 1_ℂ w = (2_ℂ^{-1} 2_ℂ) w = 2_ℂ^{-1}(2_ℂ w)`。 -/
theorem eq_inv_two_mul_two_mul_prep4 (w : ℂ) : w = (2 : ℂ)⁻¹ * (2 * w) :=
  calc w
      = 1 * w := (one_mul w).symm                                     -- `complex_numbers_form_a_field` の積の単位元を右辺から左辺へ
    _ = ((2 : ℂ)⁻¹ * 2) * w := by rw [inv_two_mul_two_prep4]         -- 上の `2_ℂ^{-1} 2_ℂ = 1_ℂ` を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (2 * w) := mul_assoc _ _ _                        -- `complex_numbers_form_a_field` の積の結合律

/-- **人手の準備 4** の第 5 の鎖（3 行）: `w = 2_ℂ^{-1}(2_ℂ w) = 2_ℂ^{-1}(w + w) = 2_ℂ^{-1} w + 2_ℂ^{-1} w`。 -/
theorem eq_inv_two_mul_add_inv_two_mul_prep4 (w : ℂ) : w = (2 : ℂ)⁻¹ * w + (2 : ℂ)⁻¹ * w :=
  calc w
      = (2 : ℂ)⁻¹ * (2 * w) := eq_inv_two_mul_two_mul_prep4 w        -- 直前の鎖
    _ = (2 : ℂ)⁻¹ * (w + w) := by rw [two_mul_eq_add_prep4]          -- 上の `2_ℂ w = w + w`
    _ = (2 : ℂ)⁻¹ * w + (2 : ℂ)⁻¹ * w := mul_add _ _ _                -- `complex_numbers_form_a_field` の分配律

/-- **人手の帰納段階**の `tr(Pň_{μ_k}) = 2_ℂ^{-1} tr(P)` の鎖（9 行）。`h` は直前の鎖 `tr(Pň_{μ_k}) = tr(P) - tr(Pň_{μ_k})`。 -/
theorem trace_mul_nOp_eq_half (P : TensorPow M) (ν : CheckIdx M) (hP : F.ann ν * P = P * F.ann ν) :
    (P * F.nOp ν).trace = (2 : ℂ)⁻¹ * P.trace := by
  have h := F.trace_mul_nOp_chain P ν hP
  calc (P * F.nOp ν).trace
      = (2 : ℂ)⁻¹ * (2 * (P * F.nOp ν).trace) := eq_inv_two_mul_two_mul_prep4 _
                                                                      -- 準備 4 の `w = 2_ℂ^{-1}(2_ℂ w)`
    _ = (2 : ℂ)⁻¹ * ((P * F.nOp ν).trace + (P * F.nOp ν).trace) := by rw [two_mul_eq_add_prep4]
                                                                      -- 準備 4 の `2_ℂ w = w + w`
    _ = (2 : ℂ)⁻¹ * ((P * F.nOp ν).trace + (P.trace - (P * F.nOp ν).trace)) := by rw [← h]
                                                                      -- 直前の鎖を 2 つ目の `tr(Pň_{μ_k})` へ
    _ = (2 : ℂ)⁻¹ * ((P * F.nOp ν).trace + (P.trace + (-(P * F.nOp ν).trace))) := by
          rw [sub_eq_add_neg]                                         -- `def_complex_difference`
    _ = (2 : ℂ)⁻¹ * ((P * F.nOp ν).trace + ((-(P * F.nOp ν).trace) + P.trace)) := by
          rw [add_comm P.trace]                                       -- `complex_numbers_form_a_field` の和の可換律
    _ = (2 : ℂ)⁻¹ * (((P * F.nOp ν).trace + (-(P * F.nOp ν).trace)) + P.trace) := by
          rw [add_assoc]                                              -- `complex_numbers_form_a_field` の和の結合律を右辺から左辺へ
    _ = (2 : ℂ)⁻¹ * (0 + P.trace) := by rw [add_neg_cancel]          -- `complex_numbers_form_a_field` の加法逆元
    _ = (2 : ℂ)⁻¹ * (P.trace + 0) := by rw [add_comm (0 : ℂ)]        -- `complex_numbers_form_a_field` の和の可換律
    _ = (2 : ℂ)⁻¹ * P.trace := by rw [add_zero]                      -- `complex_numbers_form_a_field` の零元

/-- **人手の帰納段階**の二場合（`e_k = 1` の 2 行、`e_k = 0` の 8 行）: `tr(PR_{μ_k}^{(e_k)}) = 2_ℂ^{-1} tr(P)`。 -/
theorem trace_mul_projFactor_eq_half (T : Finset (CheckIdx M)) (P : TensorPow M) (ν : CheckIdx M)
    (hP : F.ann ν * P = P * F.ann ν) :
    (P * NecSuf.projFactor F.nOp T ν).trace = (2 : ℂ)⁻¹ * P.trace := by
  by_cases hν : ν ∈ T
  · calc (P * NecSuf.projFactor F.nOp T ν).trace
        = (P * F.nOp ν).trace := by rw [NecSuf.projFactor_of_mem hν]   -- `R_{μ_k}^{(1)}` の定義（主張）
      _ = (2 : ℂ)⁻¹ * P.trace := F.trace_mul_nOp_eq_half P ν hP         -- 直前の鎖
  · calc (P * NecSuf.projFactor F.nOp T ν).trace
        = (P * (1 - F.nOp ν)).trace := by rw [NecSuf.projFactor_of_notMem hν]
                                                                       -- `R_{μ_k}^{(0)}` の定義（主張）
      _ = P.trace - (P * F.nOp ν).trace := F.trace_mul_one_sub_nOp_prep3 P ν
                                                                       -- 準備 3
      _ = P.trace - (2 : ℂ)⁻¹ * P.trace := by rw [F.trace_mul_nOp_eq_half P ν hP]
                                                                       -- 直前の鎖
      _ = ((2 : ℂ)⁻¹ * P.trace + (2 : ℂ)⁻¹ * P.trace) - (2 : ℂ)⁻¹ * P.trace := by
          rw [← eq_inv_two_mul_add_inv_two_mul_prep4 P.trace]
                                                                       -- 準備 4 の `w = 2_ℂ^{-1} w + 2_ℂ^{-1} w` を 1 つ目の `tr(P)` へ
      _ = ((2 : ℂ)⁻¹ * P.trace + (2 : ℂ)⁻¹ * P.trace) + (-((2 : ℂ)⁻¹ * P.trace)) := sub_eq_add_neg _ _
                                                                       -- `def_complex_difference`
      _ = (2 : ℂ)⁻¹ * P.trace + ((2 : ℂ)⁻¹ * P.trace + (-((2 : ℂ)⁻¹ * P.trace))) := add_assoc _ _ _
                                                                       -- `complex_numbers_form_a_field` の和の結合律
      _ = (2 : ℂ)⁻¹ * P.trace + 0 := by rw [add_neg_cancel]           -- `complex_numbers_form_a_field` の加法逆元
      _ = (2 : ℂ)⁻¹ * P.trace := add_zero _                            -- `complex_numbers_form_a_field` の零元

/-- **原文 `trace_of_check_number_operator_product`**（`k ≥ 1`。人手の帰納法と 1 対 1）:
相異なる `μ_1, …, μ_k ∈ 𝓜̌` と `e_1, …, e_k ∈ {0,1}` について `tr(∏_{j=1}^{k} R_{μ_j}^{(e_j)}) = 2^{M_col-k}`。
人手の `k` が Lean の `r + 1` で、`r = 0`（人手の `k = 1`、`P := I`）と `r + 1`（人手の `k ≥ 2`、`P := ∏_{j=1}^{k-1}`）の 2 つの節が
帰納段階の 2 つの場合である。`k = 1` の帰納法の仮定は基底段階 `trace_identity_base_case` である。
`k = 0` の場合は `trace_identity_base_case`。 -/
theorem trace_projFactor_finProdLeft (T : Finset (CheckIdx M)) :
    ∀ (r : ℕ) (μ : Fin (r + 1) → CheckIdx M), Function.Injective μ →
      (NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ j))).trace = (2 : ℂ) ^ (M - (r + 1))
  | 0, μ, hμ => by
    have hle : 0 + 1 ≤ M := by
      simpa [CheckIdx.card] using Fintype.card_le_of_injective μ hμ   -- `k ≤ M_col`
    have hP : F.ann (μ 0) * 1 = 1 * F.ann (μ 0) :=
      F.ann_mul_identity_prep2 (μ 0)                           -- 準備 2（`k = 1`、`P := I`）の 3 行。`P := I` なので単位行列との積の鎖そのもの
    calc (NecSuf.finProdLeft 0 (fun j => NecSuf.projFactor F.nOp T (μ j))).trace
        = (NecSuf.projFactor F.nOp T (μ 0)).trace := by rw [NecSuf.finProdLeft_zero]
                                                                -- 準備 1: `def_finite_product_of_matrices`
      _ = (1 * NecSuf.projFactor F.nOp T (μ 0)).trace := by rw [identity_matrix_mul_tensorPow]
                                                                -- 準備 1: `identity_matrix_is_left_unit_of_mat_mult` を右辺から左辺へ
      _ = (2 : ℂ)⁻¹ * (1 : TensorPow M).trace := F.trace_mul_projFactor_eq_half T 1 (μ 0) hP
                                                                -- 直前の二場合
      _ = (2 : ℂ)⁻¹ * (2 : ℂ) ^ (M - 0) := by rw [trace_identity_base_case]
                                                                -- 帰納法の仮定（`k = 0`）
      _ = (2 : ℂ)⁻¹ * (2 : ℂ) ^ ((M - (0 + 1)) + 1) := by
          rw [show M - 0 = (M - (0 + 1)) + 1 by omega]   -- `M_col - (k - 1) = (M_col - k) + 1`
      _ = (2 : ℂ)⁻¹ * ((2 : ℂ) ^ (M - (0 + 1)) * 2) := by
          rw [pow_succ]
                                                                -- `def_power_of_complex_number`（`m → M_col - k`）
      _ = (2 : ℂ)⁻¹ * (2 * (2 : ℂ) ^ (M - (0 + 1))) := by rw [mul_comm ((2 : ℂ) ^ (M - (0 + 1)))]
                                                                -- `complex_numbers_form_a_field` の積の可換律
      _ = ((2 : ℂ)⁻¹ * 2) * (2 : ℂ) ^ (M - (0 + 1)) := (mul_assoc _ _ _).symm
                                                                -- `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
      _ = 1 * (2 : ℂ) ^ (M - (0 + 1)) := by rw [inv_two_mul_two_prep4]
                                                                -- 準備 4 の `2_ℂ^{-1} 2_ℂ = 1_ℂ`
      _ = (2 : ℂ) ^ (M - (0 + 1)) := one_mul _                    -- `complex_numbers_form_a_field` の積の単位元
  | r + 1, μ, hμ => by
    have hle : r + 1 + 1 ≤ M := by
      simpa [CheckIdx.card] using Fintype.card_le_of_injective μ hμ   -- `k ≤ M_col`
    have hIH := trace_projFactor_finProdLeft T r (fun j => μ (Fin.castSucc j))
      (hμ.comp (Fin.castSucc_injective _))                            -- 帰納法の仮定（`k → k - 1`）
    have hP : F.ann (μ (Fin.last (r + 1))) * NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ (Fin.castSucc j)))
        = NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ (Fin.castSucc j))) * F.ann (μ (Fin.last (r + 1))) :=
      commute_finProdLeft_tensorPow r _ _ (fun j =>
        F.ann_mul_projFactor_prep2 T (fun h => (Fin.castSucc_lt_last j).ne' (hμ h)))
                                                                -- 準備 2: `matrix_commuting_with_each_factor_commutes_with_finite_product`（`r → k - 1`）
    calc (NecSuf.finProdLeft (r + 1) (fun j => NecSuf.projFactor F.nOp T (μ j))).trace
        = (NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ (Fin.castSucc j)))
            * NecSuf.projFactor F.nOp T (μ (Fin.last (r + 1)))).trace := by rw [NecSuf.finProdLeft_succ]
                                                                -- 準備 1: `def_finite_product_of_matrices`（`r → k - 1`）
      _ = (2 : ℂ)⁻¹ * (NecSuf.finProdLeft r (fun j => NecSuf.projFactor F.nOp T (μ (Fin.castSucc j)))).trace :=
          F.trace_mul_projFactor_eq_half T _ _ hP               -- 直前の二場合
      _ = (2 : ℂ)⁻¹ * (2 : ℂ) ^ (M - (r + 1)) := by rw [hIH] -- 帰納法の仮定
      _ = (2 : ℂ)⁻¹ * (2 : ℂ) ^ ((M - (r + 1 + 1)) + 1) := by
          rw [show M - (r + 1) = (M - (r + 1 + 1)) + 1 by omega]   -- `M_col - (k - 1) = (M_col - k) + 1`
      _ = (2 : ℂ)⁻¹ * ((2 : ℂ) ^ (M - (r + 1 + 1)) * 2) := by
          rw [pow_succ]
                                                                -- `def_power_of_complex_number`（`m → M_col - k`）
      _ = (2 : ℂ)⁻¹ * (2 * (2 : ℂ) ^ (M - (r + 1 + 1))) := by rw [mul_comm ((2 : ℂ) ^ (M - (r + 1 + 1)))]
                                                                -- `complex_numbers_form_a_field` の積の可換律
      _ = ((2 : ℂ)⁻¹ * 2) * (2 : ℂ) ^ (M - (r + 1 + 1)) := (mul_assoc _ _ _).symm
                                                                -- `complex_numbers_form_a_field` の積の結合律を右辺から左辺へ
      _ = 1 * (2 : ℂ) ^ (M - (r + 1 + 1)) := by rw [inv_two_mul_two_prep4]
                                                                -- 準備 4 の `2_ℂ^{-1} 2_ℂ = 1_ℂ`
      _ = (2 : ℂ) ^ (M - (r + 1 + 1)) := one_mul _                    -- `complex_numbers_form_a_field` の積の単位元

/-- **原文の「とくに」**: `tr(ň_μ) = 2^{M-1}`。 -/
theorem trace_nOp (i : CheckIdx M) : (F.nOp i).trace = ((2 ^ (M - 1) : ℕ) : ℂ) := by
  have h := F.trace_nOpProd {i}
  rw [Finset.card_singleton] at h
  have he : F.nOpProd {i} = F.nOp i := by
    simp [nOpProd, CheckFermiSetup.nOp]
  rwa [he] at h

/-- **原文の「とくに」**: `k = M` のとき `tr(ň_1⋯ň_M) = 1`。
章 009 では `|I| = M` が言えないのでこの形にはならない。 -/
theorem trace_nOpProd_univ :
    (F.nOpProd (Finset.univ : Finset (CheckIdx M))).trace = 1 := by
  have h := F.trace_nOpProd Finset.univ
  rwa [Finset.card_univ, CheckIdx.card, Nat.sub_self, pow_zero, Nat.cast_one] at h

end CheckFermiSetup

end Ising2D
