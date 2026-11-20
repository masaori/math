/-
具体版が必要十分版の特殊化として得られることの導出。
族を `A e := RootIndexPair (e+1)`、分解の全単射を `rootIndexPairSplit`、`A 0` が空であることを
`card_rootIndexPair_one` から取り、`d = (d-1)+1` で `e := d - 1` とする。
-/
import Ising2DLambda.FisherZero.RootIndexPairCount
import Ising2DLambda.NecSuf.FisherZero.RootIndexPairCount

namespace Ising2DLambda.FisherZero

theorem rootIndexPairCount_from_necSuf (d N : ℕ) (hd : 1 ≤ d) (ν : Fin N ≃ RootIndexPair d) :
    N + N = d * (d - 1) := by
  obtain ⟨e, rfl⟩ : ∃ e : ℕ, d = e + 1 := ⟨d - 1, (Nat.sub_add_cancel hd).symm⟩
  rw [Nat.add_sub_cancel]
  exact Ising2DLambda.NecSuf.FisherZero.pair_family_count_necSuf
    (fun e => RootIndexPair (e + 1))
    (Fintype.card_eq_zero_iff.mp card_rootIndexPair_one) rootIndexPairSplit e N ν

end Ising2DLambda.FisherZero
