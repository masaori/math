import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

/-- 一次式の値の集合が部分体であれば、生成部分体との一致に平方関係は不要。 -/
theorem quadraticLinearValues_eq_adjoin_necSuf {K : Type*} [DivisionRing K]
    (F S : Subfield K) (b : K)
    (hS : (S : Set K) = {y | ∃ u v : K, u ∈ F ∧ v ∈ F ∧ y = u + v * b}) :
    (S : Set K) = (Subfield.closure ((F : Set K) ∪ ({b} : Set K)) : Set K) := by
  apply Set.Subset.antisymm
  · intro y hy
    rw [hS] at hy
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    have hu' : u ∈ Subfield.closure ((F : Set K) ∪ ({b} : Set K)) :=
      Subfield.subset_closure (Or.inl hu)
    have hv' : v ∈ Subfield.closure ((F : Set K) ∪ ({b} : Set K)) :=
      Subfield.subset_closure (Or.inl hv)
    have hb' : b ∈ Subfield.closure ((F : Set K) ∪ ({b} : Set K)) :=
      Subfield.subset_closure (Or.inr (by simp))
    exact (Subfield.closure _).add_mem hu' ((Subfield.closure _).mul_mem hv' hb')
  · have hF : (F : Set K) ⊆ S := by
      intro u hu
      rw [hS]
      exact ⟨u, 0, hu, F.zero_mem, by simp⟩
    have hbS : b ∈ S := by
      change b ∈ (S : Set K)
      rw [hS]
      exact ⟨0, 1, F.zero_mem, F.one_mem, by simp⟩
    have hsub : ((F : Set K) ∪ ({b} : Set K)) ⊆ S := by
      intro x hx
      rcases hx with hx | hx
      · exact hF hx
      · have hxb : x = b := by simpa only [Set.mem_singleton_iff] using hx
        exact hxb ▸ hbS
    exact Subfield.closure_le.mpr hsub

end Ising2DLambda.NecSuf.FisherZero
