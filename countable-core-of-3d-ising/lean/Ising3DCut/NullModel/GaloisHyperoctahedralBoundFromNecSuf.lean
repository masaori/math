/- 具体版が、忠実な群作用と不動点のない対合についての必要十分版の特殊化であることを示す。 -/
import Ising3DCut.NullModel.GaloisHyperoctahedralBound
import Ising3DCut.NecSuf.NullModel.GaloisHyperoctahedralBound

namespace Ising3DCut.NullModel

noncomputable section

variable {F K : Type*} [Field F] [Field K] [Algebra F K]

/-- `claim_galois_hyperoctahedral_bound` を必要十分版から導く。 -/
theorem galoisGroup_embeds_in_pairPermutations_from_necSuf
    (R : Finset K) (G : Subgroup (K ≃ₐ[F] K))
    (hclosed : ∀ g : G, ∀ a ∈ R, g.1 a ∈ R)
    (hinv : ∀ a ∈ R, a⁻¹ ∈ R)
    (hnonfixed : ∀ a ∈ R, a⁻¹ ≠ a)
    (hgenerated : Algebra.adjoin F (R : Set K) = ⊤) :
    ∃ φ : G →* Equiv.Perm (NonfixedRoots R),
      Function.Injective φ ∧
        ∀ g a, φ g (reciprocalRoot R hinv a) = reciprocalRoot R hinv (φ g a) := by
  exact NecSuf.NullModel.embeds_in_pairPermutations
    (rootAction R G hclosed) (reciprocalRoot R hinv)
    (reciprocalRoot_involution R hinv)
    (reciprocalRoot_ne_self R hinv hnonfixed)
    (fun g h hgh => rootAction_injective_of_adjoin_eq_top R G hclosed hgenerated
      (DFunLike.ext _ _ hgh))
    (rootAction_reciprocal R G hclosed hinv)

end

end Ising3DCut.NullModel
