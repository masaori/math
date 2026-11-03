/-
# 数演算子とその補の積のトレース `tr(R_{μ_1}^{(e_1)}⋯R_{μ_k}^{(e_k)}) = 2^{M-k}`（**具体版**）

対応する人手証明（`structured-latex/content/eigenvalue_problem_eigenvalues_of_V_plus.ts`）:
`trace_of_check_number_operator_product`（`evenEigen_004_claim_...`）。

**必要十分版**は `Ising2D/NecSuf/JointEigenspace.lean` の `NecSuf.two_pow_smul_tau_projOn`。
因子の混在を許す主張そのもの `trace_projFactorProd`（`R_μ^{(1)} = ň_μ`、`R_μ^{(0)} = I - ň_μ`）はその特殊化である。
`ň` だけの積の `trace_nOpProd`（人手の「とくに」）は `Ising2D/NecSuf/PairedFermion.lean` の
`NecSuf.two_pow_smul_tau_noncommProd`（その中身も `two_pow_smul_tau_projOn`）の特殊化である。

## 章 009 との違い

章 009 では添字集合 `I` が `{1,…,M}` の真部分集合になりえた（臨界点で `|I| = M-1`）ので、
`k` は `|I|` までしか走れなかった。半整数運動量では `𝓜̌ = {1,…,M}` なので
`k = M` まで走れて `tr(R_1^{(e_1)}⋯R_M^{(e_M)}) = 2^0 = 1` になる。
`trace_projFactorProd` を `S → 𝓜̌` 全体で使うのが `tr(Q̌_ε) = 1`（同時固有空間が 1 次元）の根拠である
（`ClaimCheckJointEigenspace.lean` の `trace_Qproj_step4`）。

## 積の順序について

人手証明は「`check_number_operators_commute` (2) より積の順序に依らない」と書いている。
Lean では非可換環に `Finset.prod` が無いので、可換性の証明を引数に取る
`Finset.noncommProd` を使う（章 009 の `NecSuf.projOn` と同じ扱い）。
-/
import Ising2D.EigenvalueProblem.EigenvaluesOfVPlus.DefinitionCheckNumberOperator
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace

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
人手の証明（`k` についての帰納法と `tr(R_μ P) = tr(P)/2`）と 1 対 1 の具体版はまだ無い。 -/
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
