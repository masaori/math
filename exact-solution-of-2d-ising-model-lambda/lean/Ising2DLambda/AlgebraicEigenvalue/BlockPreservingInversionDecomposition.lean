import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingCrossPairParity

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j})

def blockInversionPairs : Finset (J × J) :=
  ((univ : Finset (J × J)).filter (fun p => p.1 < p.2)).filter
    (fun p => σ.1 p.2 < σ.1 p.1)

def blockInversionCount : ℕ :=
  (blockInversionPairs block σ).card

def blockWithinFiberInversions (k : K) : Finset (J × J) :=
  (blockInversionPairs block σ).filter
    (fun p => block p.1 = block p.2 ∧ block p.1 = k)

def blockAcrossFiberInversions : Finset (J × J) :=
  (blockInversionPairs block σ).filter (fun p => block p.1 ≠ block p.2)

/-- Partition inversion pairs by their common fiber, leaving pairs from different fibers. -/
theorem blockPreserving_inversionCount_fiber_decomposition :
    blockInversionCount block σ =
      (∑ k : K, (blockWithinFiberInversions block σ k).card) +
        (blockAcrossFiberInversions block σ).card := by
  classical
  let pairs := blockInversionPairs block σ
  let same := pairs.filter (fun p => block p.1 = block p.2)
  have hsplit : same.card + (blockAcrossFiberInversions block σ).card = pairs.card := by
    simpa only [same, pairs, blockAcrossFiberInversions] using
      (Finset.card_filter_add_card_filter_not
        (s := blockInversionPairs block σ) (fun p => block p.1 = block p.2))
  have hfiber : same.card = ∑ k : K, (same.filter (fun p => block p.1 = k)).card := by
    exact Finset.card_eq_sum_card_fiberwise (s := same) (t := univ)
      (f := fun p : J × J => block p.1) (by simp)
  have hterm : ∀ k : K,
      (same.filter (fun p => block p.1 = k)).card =
        (blockWithinFiberInversions block σ k).card := by
    intro k
    congr 1
    ext p
    simp only [same, pairs, blockWithinFiberInversions, mem_filter]
    tauto
  simpa only [blockInversionCount, pairs, blockInversionPairs] using
    (show pairs.card = (∑ k : K, (blockWithinFiberInversions block σ k).card) +
        (blockAcrossFiberInversions block σ).card by
      rw [← hsplit, hfiber]
      exact congrArg (fun n : ℕ => n + (blockAcrossFiberInversions block σ).card)
        (Finset.sum_congr rfl (fun k _ => hterm k)))

end Ising2DLambda.AlgebraicEigenvalue
