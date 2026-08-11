/-
有限部分集合の元の個数が一様に n 以下なら、集合自身が有限で元の個数も n 以下であることに
必要十分なデータだけを残した版。元の型にも集合にも代数構造を要求しない。
-/
import Mathlib.Data.Set.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem finite_ncard_le_of_finset_card_le_necSuf {α : Type*} (S : Set α) (n : ℕ)
    (hcard : ∀ s : Finset α, (s : Set α) ⊆ S → s.card ≤ n) :
    S.Finite ∧ S.ncard ≤ n := by
  classical
  have hfinite : S.Finite := by
    by_contra hnot
    have hinfinite : S.Infinite := hnot
    obtain ⟨s, hs, hsCard⟩ := hinfinite.exists_subset_card_eq (n + 1)
    have hle : s.card ≤ n := hcard s hs
    omega
  constructor
  · exact hfinite
  · rw [Set.ncard_eq_toFinset_card S hfinite]
    exact hcard hfinite.toFinset fun _ hw => hfinite.mem_toFinset.1 hw

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
