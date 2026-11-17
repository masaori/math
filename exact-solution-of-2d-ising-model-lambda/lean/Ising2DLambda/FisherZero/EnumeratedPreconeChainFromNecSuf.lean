/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.NecSuf.FisherZero.EnumeratedPreconeChain
import Ising2DLambda.FisherZero.SubfieldPreconeFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の列 `preconeChain` は必要十分版の列 `chainSet` を部分体の台集合へ特殊化したものである。 -/
theorem preconeChain_eq_chainSet (E : Subfield Qbar) (T : Set Qbar) (ξ : ℕ → Qbar) :
    ∀ n : ℕ, preconeChain E T ξ n = Ising2DLambda.NecSuf.FisherZero.chainSet (E : Set Qbar) T ξ n := by
  intro n
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [preconeChain, Ising2DLambda.NecSuf.FisherZero.chainSet, ih]
    rfl

theorem preconeChainUnion_eq_chainUnion (E : Subfield Qbar) (T : Set Qbar) (ξ : ℕ → Qbar) :
    preconeChainUnion E T ξ = Ising2DLambda.NecSuf.FisherZero.chainUnion (E : Set Qbar) T ξ := by
  ext z
  simp only [preconeChainUnion, Ising2DLambda.NecSuf.FisherZero.chainUnion, Set.mem_setOf_eq,
    preconeChain_eq_chainSet]

/-- `claim_enumerated_precone_chain_covers_signs` を必要十分版から得る。 -/
theorem preconeChainUnion_covers_signs_from_necSuf (F E : Subfield Qbar) (CF T : Set Qbar)
    (hT : IsSubfieldPrecone F E CF T) (hneg : (-1 : Qbar) ∉ T) (ξ : ℕ → Qbar)
    (hξ : Function.Surjective ξ) :
    IsSubfieldPrecone F E CF (preconeChainUnion E T ξ) ∧
      (-1 : Qbar) ∉ preconeChainUnion E T ξ ∧
      (∀ z : Qbar, z ∈ E → z ∈ preconeChainUnion E T ξ ∨ -z ∈ preconeChainUnion E T ξ) := by
  obtain ⟨hle, hcone, hT'⟩ := (isSubfieldPrecone_iff_from_necSuf F E CF T).mp hT
  obtain ⟨hP, hn, hcov⟩ :=
    Ising2DLambda.NecSuf.FisherZero.chainUnion_covers_signs_necSuf (E : Set Qbar) CF T
      E.zero_mem E.one_mem (fun _ _ hx hy => E.add_mem hx hy)
      (fun _ _ hx hy => E.mul_mem hx hy) (fun _ hx => E.neg_mem hx) hT' hneg ξ
      (fun z _ => hξ z)
  rw [preconeChainUnion_eq_chainUnion]
  exact ⟨(isSubfieldPrecone_iff_from_necSuf F E CF _).mpr ⟨hle, hcone, hP⟩, hn, hcov⟩

end Ising2DLambda.FisherZero
