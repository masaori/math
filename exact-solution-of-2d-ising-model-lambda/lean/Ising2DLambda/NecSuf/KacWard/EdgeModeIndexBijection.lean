import Mathlib

/- `claim_edge_mode_index_bijection` の必要十分版。
   必要なのは二つの有限モード集合の濃度と有限な辺添字集合の濃度だけである。
   具体版と同じく直積を数え、等濃度から全単射を得る。 -/

namespace Ising2DLambda.NecSuf.KacWard

def modeIndexSet {R : Type*} (U W : Set R) : Set (R × R × ZMod 4) :=
  {m | m.1 ∈ U ∧ m.2.1 ∈ W}

theorem edgeModeIndex_equiv_exists_necSuf {R E : Type*} [Fintype E]
    (U W : Set R) (L : ℕ) (hU : U.Finite) (hW : W.Finite)
    (hUc : U.ncard = L) (hWc : W.ncard = L)
    (hE : Fintype.card E = 4 * L ^ 2) :
    Nonempty (E ≃ {m // m ∈ modeIndexSet U W}) := by
  classical
  have hset : modeIndexSet U W = U ×ˢ (W ×ˢ (Set.univ : Set (ZMod 4))) := by
    ext m
    simp [modeIndexSet, Set.mem_prod]
  have hfinite : (modeIndexSet U W).Finite := by
    rw [hset]
    exact hU.prod (hW.prod Set.finite_univ)
  letI : Fintype {m // m ∈ modeIndexSet U W} := hfinite.fintype
  have hcard : Fintype.card {m // m ∈ modeIndexSet U W} = 4 * L ^ 2 := by
    rw [← Nat.card_eq_fintype_card, Nat.card_coe_set_eq, hset,
      Set.ncard_prod, Set.ncard_prod, hUc, hWc,
      Set.ncard_univ, Nat.card_eq_fintype_card]
    norm_num [ZMod.card]
    ring
  exact ⟨Fintype.equivOfCardEq (hE.trans hcard.symm)⟩

end Ising2DLambda.NecSuf.KacWard
