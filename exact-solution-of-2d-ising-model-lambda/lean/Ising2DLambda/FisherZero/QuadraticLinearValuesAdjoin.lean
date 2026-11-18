import Ising2DLambda.FisherZero.QuadraticLinearValuesInverseClosed

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `F` と `b` が生成する部分体の元は、平方根 `b` の一次式で表せる。 -/
theorem quadraticLinearValues_eq_adjoin (F : Subfield Qbar) (a b : Qbar)
    (ha : a ∈ F) (hb : b * b = a) (hbF : b ∉ F) :
    quadraticLinearValues F b =
      (Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) : Set Qbar) := by
  let S : Subfield Qbar := {
    carrier := quadraticLinearValues F b
    zero_mem' := (quadraticLinearValues_ringClosed F a b ha hb).1
    one_mem' := (quadraticLinearValues_ringClosed F a b ha hb).2.1
    add_mem' := by intros x y hx hy; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.1 x y hx hy
    neg_mem' := by intros x hx; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.2.1 x hx
    mul_mem' := by intros x y hx hy; exact (quadraticLinearValues_ringClosed F a b ha hb).2.2.2.2 x y hx hy
    inv_mem' := by
      intro y hy
      by_cases hy0 : y = 0
      · simpa [hy0] using (quadraticLinearValues_ringClosed F a b ha hb).1
      · exact quadraticLinearValues_inv_mem F a b ha hb hbF y hy hy0
  }
  apply Set.Subset.antisymm
  · intro y hy
    obtain ⟨u, v, hu, hv, rfl⟩ := hy
    have hu' : u ∈ Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) :=
      Subfield.subset_closure (Or.inl hu)
    have hv' : v ∈ Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) :=
      Subfield.subset_closure (Or.inl hv)
    have hb' : b ∈ Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) :=
      Subfield.subset_closure (Or.inr (by simp))
    exact (Subfield.closure _).add_mem hu' ((Subfield.closure _).mul_mem hv' hb')
  · have hF : (F : Set Qbar) ⊆ S := by
      intro u hu
      change u ∈ quadraticLinearValues F b
      exact ⟨u, 0, hu, F.zero_mem, by ring⟩
    have hbS : b ∈ S := by
      change b ∈ quadraticLinearValues F b
      exact ⟨0, 1, F.zero_mem, F.one_mem, by ring⟩
    have hsub : ((F : Set Qbar) ∪ ({b} : Set Qbar)) ⊆ S := by
      intro x hx
      rcases hx with hx | hx
      · exact hF hx
      · have hxb : x = b := by simpa only [Set.mem_singleton_iff] using hx
        exact hxb ▸ hbS
    have hle : Subfield.closure ((F : Set Qbar) ∪ ({b} : Set Qbar)) ≤ S :=
      Subfield.closure_le.mpr hsub
    exact hle

end Ising2DLambda.FisherZero
