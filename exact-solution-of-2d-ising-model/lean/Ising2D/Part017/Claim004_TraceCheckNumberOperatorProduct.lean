/-
# 数演算子の積のトレース `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}`（**具体版**）

対応する人手証明（`structured-latex/content/017_even_sector_eigenvalues.ts`）:
`trace_of_check_number_operator_product`（`evenEigen_004_claim_...`）。

**抽象版**は `Ising2D/Abstract/PairedFermion.lean` の
`Abstract.two_pow_smul_tau_noncommProd`（さらにその中身は
`Ising2D/Abstract/JointEigenspace.lean` の `Abstract.two_pow_smul_tau_projOn`）。
本ファイルはその特殊化である。

## 章 009 との違い

章 009 では添字集合 `I` が `{1,…,M}` の真部分集合になりえた（臨界点で `|I| = M-1`）ので、
`k` は `|I|` までしか走れなかった。半整数運動量では `𝓜̌ = {1,…,M}` なので
`k = M` まで走れて `tr(ň_1⋯ň_M) = 2^0 = 1` になる。
これが `tr(Q̌_ε) = 1`（同時固有空間が 1 次元）の根拠である。

## 積の順序について

人手証明は「`check_number_operators_commute` (2) より積の順序に依らない」と書いている。
Lean では非可換環に `Finset.prod` が無いので、可換性の証明を引数に取る
`Finset.noncommProd` を使う（章 009 の `Abstract.projOn` と同じ扱い）。
-/
import Ising2D.Part017.Definition001_CheckNumberOperator

namespace Ising2D

open Matrix

namespace CheckFermiSetup

variable {M : ℕ} (F : CheckFermiSetup M)

/-- 相異なる添字の集合 `S` にわたる `ň_μ` の積（人手証明の `ň_{μ_1}⋯ň_{μ_k}`）。 -/
noncomputable def nOpProd (S : Finset (CheckIdx M)) : TensorPow M :=
  S.noncommProd (Abstract.num F.cre F.ann) fun i _ j _ _ => F.commute_nOp_nOp i j

theorem nOpProd_eq (S : Finset (CheckIdx M)) :
    F.nOpProd S = S.noncommProd F.nOp fun i _ j _ _ => F.commute_nOp_nOp i j := rfl

@[simp]
theorem nOpProd_empty : F.nOpProd ∅ = 1 := Finset.noncommProd_empty _ _

/-- **原文 `trace_of_check_number_operator_product`**:
相異なる `μ_1,…,μ_k ∈ 𝓜̌` について `tr(ň_{μ_1}⋯ň_{μ_k}) = 2^{M-k}`。 -/
theorem trace_nOpProd (S : Finset (CheckIdx M)) :
    (F.nOpProd S).trace = ((2 ^ (M - S.card) : ℕ) : ℂ) := by
  have h : ((2 ^ S.card : ℕ) : ℂ) * (F.nOpProd S).trace = ((2 ^ M : ℕ) : ℂ) := by
    have h0 := Abstract.two_pow_smul_tau_noncommProd F.cre F.ann F.commute_nOp_nOp
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
