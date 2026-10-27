import Ising2DLambda.KacWard.FourierModeIndexSet
import Ising2DLambda.KacWard.TwistedModeCard
import Ising2DLambda.KacWard.TargetDirectionBijection

/- `claim_edge_mode_index_bijection` の具体版。
   ねじれたモードを数え、直積と向き付き辺の濃度を照合する。 -/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.PartitionPolynomial

theorem modeIndex_card_data {L : ℕ} [NeZero L] (s : SpinStructure) :
    (horizontalTwistedModes L s).Finite ∧
    (verticalTwistedModes L s).Finite ∧
    (horizontalTwistedModes L s).ncard = L ∧
    (verticalTwistedModes L s).ncard = L := by
  classical
  have hL : 0 < L := Nat.pos_of_ne_zero (NeZero.ne L)
  obtain ⟨ξ, hξ⟩ := IsAlgClosed.exists_pow_nat_eq (-1 : Qbar) hL
  obtain ⟨hh0, hh1, hv0, hv1⟩ := twistedModeSets_ncard L hL ξ hξ
  have hUcard : (horizontalTwistedModes L s).ncard = L := by
    rcases s with ⟨a, b⟩
    cases a <;> cases b
    · exact hh0
    · exact hh0
    · exact hh1
    · exact hh1
  have hWcard : (verticalTwistedModes L s).ncard = L := by
    rcases s with ⟨a, b⟩
    cases a <;> cases b
    · exact hv0
    · exact hv1
    · exact hv0
    · exact hv1
  have hroots : (RootOfUnity (2 * L)).Finite :=
    (rootOfUnityFiniteCardLe (2 * L) (by omega)).1
  have hU : (horizontalTwistedModes L s).Finite :=
    hroots.subset (fun z hz => twistedModes_subset_doubleRoots L s (Or.inl hz))
  have hW : (verticalTwistedModes L s).Finite :=
    hroots.subset (fun z hz => twistedModes_subset_doubleRoots L s (Or.inr hz))
  exact ⟨hU, hW, hUcard, hWcard⟩

theorem edgeModeIndex_equiv_exists {L : ℕ} [NeZero L] (s : SpinStructure) :
    Nonempty (OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) := by
  classical
  obtain ⟨hU, hW, hUcard, hWcard⟩ := modeIndex_card_data (L := L) s
  have hE : Fintype.card (OrientedEdge L) = 4 * L ^ 2 := by
    change Fintype.card (Edge L × Bool) = 4 * L ^ 2
    rw [Fintype.card_prod, card_edge, Fintype.card_bool]
    ring
  have hset : fourierModeIndexSet L s =
      horizontalTwistedModes L s ×ˢ
        (verticalTwistedModes L s ×ˢ (Set.univ : Set (ZMod 4))) := by
    ext m
    simp [fourierModeIndexSet, Set.mem_prod]
  have hfinite : (fourierModeIndexSet L s).Finite := by
    rw [hset]
    exact hU.prod (hW.prod Set.finite_univ)
  letI : Fintype {m // m ∈ fourierModeIndexSet L s} := hfinite.fintype
  have hcard : Fintype.card {m // m ∈ fourierModeIndexSet L s} = 4 * L ^ 2 := by
    rw [← Nat.card_eq_fintype_card, Nat.card_coe_set_eq, hset,
      Set.ncard_prod, Set.ncard_prod, hUcard, hWcard,
      Set.ncard_univ, Nat.card_eq_fintype_card]
    norm_num [ZMod.card]
    ring
  exact ⟨Fintype.equivOfCardEq (hE.trans hcard.symm)⟩

end Ising2DLambda.KacWard
