import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PermutationSign

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [Fintype K] [DecidableEq K]
    (block : J → K) (r : J → J → Prop) [DecidableRel r]
    (σ : Equiv.Perm J)

def blockInversionPairs : Finset (J × J) :=
  (orderedPairs r).filter (fun p => r (σ p.2) (σ p.1))

def blockWithinFiberInversions (k : K) : Finset (J × J) :=
  (blockInversionPairs r σ).filter
    (fun p => block p.1 = block p.2 ∧ block p.1 = k)

def blockAcrossFiberInversions : Finset (J × J) :=
  (blockInversionPairs r σ).filter (fun p => block p.1 ≠ block p.2)

/-- Partition inversion pairs by their common fiber, leaving pairs from different fibers. -/
theorem inversionCount_fiber_decomposition :
    inversionCount r σ =
      (∑ k : K, (blockWithinFiberInversions block r σ k).card) +
        (blockAcrossFiberInversions block r σ).card := by
  classical
  let pairs := blockInversionPairs r σ
  let same := pairs.filter (fun p => block p.1 = block p.2)
  have hsplit : same.card + (blockAcrossFiberInversions block r σ).card = pairs.card := by
    simpa only [same, pairs, blockAcrossFiberInversions] using
      (Finset.card_filter_add_card_filter_not
        (s := blockInversionPairs r σ) (fun p => block p.1 = block p.2))
  have hfiber : same.card = ∑ k : K, (same.filter (fun p => block p.1 = k)).card := by
    exact Finset.card_eq_sum_card_fiberwise (s := same) (t := univ)
      (f := fun p : J × J => block p.1) (by simp)
  have hterm : ∀ k : K,
      (same.filter (fun p => block p.1 = k)).card =
        (blockWithinFiberInversions block r σ k).card := by
    intro k
    congr 1
    ext p
    simp only [same, pairs, blockWithinFiberInversions, mem_filter]
    tauto
  simpa only [inversionCount, pairs, blockInversionPairs] using
    (show pairs.card = (∑ k : K, (blockWithinFiberInversions block r σ k).card) +
        (blockAcrossFiberInversions block r σ).card by
      rw [← hsplit, hfiber]
      exact congrArg (fun n : ℕ => n + (blockAcrossFiberInversions block r σ).card)
        (Finset.sum_congr rfl (fun k _ => hterm k)))

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
