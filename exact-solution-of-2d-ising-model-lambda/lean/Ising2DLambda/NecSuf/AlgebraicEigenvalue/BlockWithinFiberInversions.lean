import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingInversionDecomposition
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.BlockPreservingPermutationBijection

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

variable {J K : Type*} [Fintype J] [DecidableEq J] [Fintype K] [DecidableEq K]
    (block : J → K) (r : J → J → Prop) [DecidableRel r]
    (σ : {σ : Equiv.Perm J // ∀ j, block (σ j) = block j}) (k : K)

noncomputable def fiberInversionPairs :
    Finset ({j : J // block j = k} × {j : J // block j = k}) :=
  (univ : Finset ({j : J // block j = k} × {j : J // block j = k})).filter
    (fun p => r p.1.1 p.2.1 ∧
      r ((blockRestriction block σ k) p.2).1 ((blockRestriction block σ k) p.1).1)

/-- The induced relation on a fiber identifies its inversion pairs with the global fiber pairs. -/
theorem blockWithinFiberInversions_card_eq_restriction :
    (blockWithinFiberInversions block r σ.1 k).card =
      (fiberInversionPairs block r σ k).card := by
  classical
  have hcard : (fiberInversionPairs block r σ k).card =
      (blockWithinFiberInversions block r σ.1 k).card := by
    apply Finset.card_bij (fun p _ => (p.1.1, p.2.1))
    · intro p hp
      simp only [fiberInversionPairs, mem_filter, mem_univ, true_and] at hp
      simp only [blockWithinFiberInversions, blockInversionPairs, orderedPairs,
        mem_filter, mem_univ, true_and]
      exact ⟨⟨hp.1, hp.2⟩, ⟨p.1.2.trans p.2.2.symm, p.1.2⟩⟩
    · intro p hp q hq h
      exact Prod.ext (Subtype.ext (congrArg Prod.fst h))
        (Subtype.ext (congrArg Prod.snd h))
    · intro p hp
      simp only [blockWithinFiberInversions, blockInversionPairs, orderedPairs,
        mem_filter, mem_univ, true_and] at hp
      let h₁ : block p.1 = k := hp.2.2
      let h₂ : block p.2 = k := hp.2.1.symm.trans h₁
      refine ⟨(⟨p.1, h₁⟩, ⟨p.2, h₂⟩), ?_, rfl⟩
      simp only [fiberInversionPairs, mem_filter, mem_univ, true_and]
      exact ⟨hp.1.1, hp.1.2⟩
  exact hcard.symm

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
