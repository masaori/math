/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.ContactSplitPairDescent
import Ising2DLambda.NecSuf.KacWard.ContactSplitPairDescent

namespace Ising2DLambda.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem contact_split_pair_descent_from_necSuf {V : Type} [DecidableEq V]
    (tgt : ℕ → V) (m k l : ℕ)
    (hk : 0 < k) (hkl : k < l) (hlm : l ≤ m)
    (hcontact : tgt k = tgt l) :
    (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)).card
    + (((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).filter
      (fun ab => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)).card
    < ((Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
        (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2)).card := by
  have hwMem : (k, l) ∈ (Finset.Ioc 0 m ×ˢ Finset.Ioc 0 m).filter
      (fun ab => ab.1 < ab.2 ∧ tgt ab.1 = tgt ab.2) := by
    rw [Finset.mem_filter, Finset.mem_product, Finset.mem_Ioc, Finset.mem_Ioc]
    exact ⟨⟨⟨hk, le_of_lt (lt_of_lt_of_le hkl hlm)⟩, ⟨lt_trans hk hkl, hlm⟩⟩,
      hkl, hcontact⟩
  exact Ising2DLambda.NecSuf.KacWard.exclusive_split_witness_descent_necSuf _
    (fun ab : ℕ × ℕ => ab.1 ∈ Finset.Ioc k l ∧ ab.2 ∈ Finset.Ioc k l)
    (fun ab : ℕ × ℕ => ¬ ab.1 ∈ Finset.Ioc k l ∧ ¬ ab.2 ∈ Finset.Ioc k l)
    (fun ab _ h => h.2.1 h.1.1) (k, l) hwMem
    (by rw [Finset.mem_Ioc, Finset.mem_Ioc]; omega)
    (by rw [Finset.mem_Ioc, Finset.mem_Ioc]; omega)

end Ising2DLambda.KacWard
