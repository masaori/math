/-
有限集合 S の元の個数が n 以下であり、S に相異なる n 個の元が与えられれば、
S の元の個数は n である。組み立てが実際に使うデータだけを残した必要十分版。
元の型に代数構造を要求しない。
-/
import Mathlib.Data.Set.Card

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

theorem card_eq_of_upper_and_distinct_sequence_necSuf
    {α : Type*} (S : Set α) (n : ℕ)
    (hfinite : S.Finite) (hupper : S.ncard ≤ n)
    (w : ℕ → α)
    (hmem : ∀ i : ℕ, i < n → w i ∈ S)
    (hdist : ∀ i i' : ℕ, i < n → i' < n → i ≠ i' → w i ≠ w i') :
    S.ncard = n := by
  classical
  let s : Finset α := (Finset.range n).image w
  have hwinj : Set.InjOn w (Finset.range n : Set ℕ) := by
    intro i hi i' hi' heq
    by_contra hne
    exact hdist i i' (Finset.mem_range.mp hi) (Finset.mem_range.mp hi') hne heq
  have hcard : s.card = n := by
    rw [show s = (Finset.range n).image w from rfl,
      Finset.card_image_iff.mpr hwinj, Finset.card_range]
  have hsubset : s ⊆ hfinite.toFinset := by
    intro x hx
    obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hx
    exact hfinite.mem_toFinset.mpr (hmem i (Finset.mem_range.mp hi))
  have hlower : n ≤ S.ncard := by
    rw [Set.ncard_eq_toFinset_card S hfinite, ← hcard]
    exact Finset.card_le_card hsubset
  omega

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
