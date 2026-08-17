/-
「正の有理数は正錐の元である」を既存の必要十分版から導出する。
必要十分版 positive_of_representation_necSuf は「表示が正条件を満たすなら正」だけを仮定に取り、
体・順序・二次体の構造を要求しない（SelfDualPositiveRoot の必要十分版と同じものを引く。
同じ議論を二箇所に置かない）。具体側の仕事は表示 rep_s(q) = (q, 0) の供給だけである。
-/
import Ising2DLambda.FisherZero.PositiveRationalInPositiveCone
import Ising2DLambda.NecSuf.FisherZero.SelfDualPositiveRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem positiveRational_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) (hq : 0 < q) :
    positiveRationalElement s q ∈ quadraticPositiveCone s := by
  apply Ising2DLambda.NecSuf.FisherZero.positive_of_representation_necSuf
      (quadraticRepresentation s) quadraticCoefficientPositive
      (positiveRationalElement s q) q 0
  · exact positiveRational_representation s hs q
  · refine Or.inl ⟨le_of_lt hq, le_rfl, ?_⟩
    intro h
    rw [Prod.mk.injEq] at h
    exact absurd h.1 (ne_of_gt hq)

end Ising2DLambda.FisherZero
