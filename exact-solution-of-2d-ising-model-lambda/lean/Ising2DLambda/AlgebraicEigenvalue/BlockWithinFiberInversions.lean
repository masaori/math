import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingInversionDecomposition
import Ising2DLambda.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [LinearOrder J] [Fintype K] [DecidableEq K]
    (block : J → K)
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k : K)

noncomputable def fiberInversionPairs :
    Finset ({j : J // block j = k} × {j : J // block j = k}) :=
  (univ : Finset ({j : J // block j = k} × {j : J // block j = k})).filter
    (fun p => p.1 < p.2 ∧ (blockRestriction block σ k) p.2 <
      (blockRestriction block σ k) p.1)

/-- Inversion pairs inside one fiber are exactly the inversions of the restricted permutation. -/
theorem blockWithinFiberInversions_card_eq_restriction :
    (blockWithinFiberInversions block σ k).card =
      (fiberInversionPairs block σ k).card := by
  classical
  have hcard : (fiberInversionPairs block σ k).card =
      (blockWithinFiberInversions block σ k).card := by
    apply Finset.card_bij (fun p _ => (p.1.1, p.2.1))
    · intro p hp
      simp only [fiberInversionPairs, mem_filter, mem_univ, true_and] at hp
      simp only [blockWithinFiberInversions, blockInversionPairs, blockInversionPairs,
        mem_filter, mem_univ, true_and]
      exact ⟨⟨hp.1, hp.2⟩, ⟨p.1.2.trans p.2.2.symm, p.1.2⟩⟩
    · intro p hp q hq h
      exact Prod.ext (Subtype.ext (congrArg Prod.fst h))
        (Subtype.ext (congrArg Prod.snd h))
    · intro p hp
      simp only [blockWithinFiberInversions, blockInversionPairs,
        mem_filter, mem_univ, true_and] at hp
      let h₁ : block p.1 = k := hp.2.2
      let h₂ : block p.2 = k := hp.2.1.symm.trans h₁
      refine ⟨(⟨p.1, h₁⟩, ⟨p.2, h₂⟩), ?_, rfl⟩
      simp only [fiberInversionPairs, mem_filter, mem_univ, true_and]
      exact ⟨hp.1.1, hp.1.2⟩
  exact hcard.symm

end Ising2DLambda.AlgebraicEigenvalue
