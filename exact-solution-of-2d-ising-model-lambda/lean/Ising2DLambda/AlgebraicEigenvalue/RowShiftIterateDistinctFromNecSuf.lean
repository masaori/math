/-
具体版が必要十分版の特殊化として得られることを示す（導出）。

具体版 `rowShiftIterate_index_eq_of_lt_period` は、必要十分版 `eq_of_le_of_symm` の
述語 `p` に「`a < e(τ)` かつ `b < e(τ)` かつ `S^[a](τ) = S^[b](τ)`」を取ったものである。
対称性は上界の条件が `a` と `b` について対称であることと等号の対称性から、
`a ≤ b` の側は準備 `eq_of_rowShiftIterate_eq_of_le` から得られる。
-/
import Ising2DLambda.AlgebraicEigenvalue.RowShiftIterateDistinct
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RowShiftIterateDistinct

namespace Ising2DLambda.AlgebraicEigenvalue

open TransferMatrix

variable {L : ℕ} [NeZero L]

/-- 具体版の主張が、必要十分版の特殊化として得られること。 -/
theorem rowShiftIterate_index_eq_of_lt_period_from_necSuf {τ : RowConfig L} {a b : ℕ}
    (ha : a < rowShiftMinimalPeriod L τ) (hb : b < rowShiftMinimalPeriod L τ)
    (h : rowShiftIterate L a τ = rowShiftIterate L b τ) : a = b :=
  NecSuf.AlgebraicEigenvalue.eq_of_le_of_symm
    (p := fun a b => a < rowShiftMinimalPeriod L τ ∧ b < rowShiftMinimalPeriod L τ
      ∧ rowShiftIterate L a τ = rowShiftIterate L b τ)
    (fun hp => ⟨hp.2.1, hp.1, hp.2.2.symm⟩)
    (fun hab hp => eq_of_rowShiftIterate_eq_of_le hab hp.2.1 hp.2.2)
    ⟨ha, hb, h⟩

end Ising2DLambda.AlgebraicEigenvalue
