/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・実数側の第 2 段。
第 1 段の項ごとの等式（実指数は箱ごとに変わってよい）を、箱の大きさ $L=n+1$ で添字づけた
実数列に束ね、$q$ での列と $1/q$ での列が同じ極限へ収束するかどうかが同値であること、
両方が収束するなら極限が一致することを述べる。使うのは
`tendsto_iff_of_pointwise_eq`・`limit_eq_of_pointwise_eq` だけである。
-/
import Ising3DCut.LimitQuantity.SymmetrizedRealTermReciprocalInvariantNullModel
import Ising3DCut.LimitQuantity.RealLimitOfEqualSequences

namespace Ising3DCut.LimitQuantity

open Polynomial Filter Topology

/-- 零モデルの対称化した実数列の項（箱の大きさ $L$、実指数 $s$）。 -/
noncomputable def nullModelSymmetrizedRealTerm (L : ℕ) (q : ℚ) (s : ℝ) : ℝ :=
  ((((polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval q) ^ 2
      / q ^ (Fintype.card (NullModel.Edge L)) : ℚ) : ℝ) ^ s

/-- $q$ での列（$L=n+1$）と $1/q$ での列は同じ極限へ収束するかどうかが同値。 -/
theorem nullModel_symmetrized_real_seq_tendsto_iff {q : ℚ} (hq : 0 < q) (s : ℕ → ℝ) (ℓ : ℝ) :
    Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) q (s (n + 1))) atTop (𝓝 ℓ) ↔
      Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) (1 / q) (s (n + 1))) atTop (𝓝 ℓ) :=
  tendsto_iff_of_pointwise_eq _ _
    (fun n => nullModel_symmetrized_real_term_reciprocal_invariant (Nat.succ_pos n) hq (s (n + 1))) ℓ

/-- 両方の列が収束するなら極限は一致する。 -/
theorem nullModel_symmetrized_real_seq_limit_eq {q : ℚ} (hq : 0 < q) (s : ℕ → ℝ) (ℓ ℓ' : ℝ)
    (ha : Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) q (s (n + 1))) atTop (𝓝 ℓ))
    (hb : Tendsto (fun n => nullModelSymmetrizedRealTerm (n + 1) (1 / q) (s (n + 1))) atTop (𝓝 ℓ')) :
    ℓ = ℓ' :=
  limit_eq_of_pointwise_eq _ _
    (fun n => nullModel_symmetrized_real_term_reciprocal_invariant (Nat.succ_pos n) hq (s (n + 1)))
    ℓ ℓ' ha hb

end Ising3DCut.LimitQuantity
