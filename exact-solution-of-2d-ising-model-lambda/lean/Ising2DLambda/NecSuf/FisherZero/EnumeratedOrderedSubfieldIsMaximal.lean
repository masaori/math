import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldChain
import Ising2DLambda.NecSuf.FisherZero.IncreasingPositiveConeUnionRestriction
import Ising2DLambda.NecSuf.FisherZero.IncreasingPositiveConeUnion

namespace Ising2DLambda.NecSuf.FisherZero

/-- 台の体構造を使わず、列挙と正錐の一段の制限から極大性を得る。 -/
theorem enumeratedOrderedSubfield_isMaximal {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (F₀ : T) (C₀ : Set K)
    (hC₀ : IsPositiveConeOn (carrier F₀) C₀)
    (ξ : ℕ → K) (hξ : Function.Surjective ξ) :
    ∃ (F : ℕ → T) (C : ℕ → Set K),
      F 0 = F₀ ∧ C 0 = C₀ ∧
      (∀ n, ExtendsPositiveConeOn (carrier (F n)) (carrier (F (n + 1)))
        (C n) (C (n + 1))) ∧
      ExtendsPositiveConeOn (carrier F₀)
        {z | ∃ n, z ∈ carrier (F n)} C₀ {z | ∃ n, z ∈ C n} ∧
      ∀ (E : T) (D : Set K),
        ExtendsPositiveConeOn {z | ∃ n, z ∈ carrier (F n)}
          (carrier E) {z | ∃ n, z ∈ C n} D →
        carrier E = {z | ∃ n, z ∈ carrier (F n)} := by
  obtain ⟨F, C, hF₀, hC₀', hstep, hcapture⟩ :=
    enumeratedOrderedSubfield_chain carrier F₀ C₀ hC₀ ξ
  have hrestrict : ∀ n z,
      (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ carrier (F n)) ↔ z ∈ C n := by
    intro n z
    exact increasingPositiveConeUnion_restrictsToStage
      (fun j => carrier (F j)) C
      (fun j => (hstep j).subset_le)
      (fun j => (hstep j).cone_F.subset)
      (fun j => (hstep j).inter_eq) n z
  have hbase : ExtendsPositiveConeOn (carrier F₀)
      {z | ∃ n, z ∈ carrier (F n)} C₀ {z | ∃ n, z ∈ C n} := by
    refine ⟨?_, hC₀, increasingPositiveConeUnion_isPositiveCone
      (fun n => carrier (F n)) C hstep, ?_⟩
    · intro z hz
      exact ⟨0, hF₀.symm ▸ hz⟩
    · intro z
      simpa [hF₀, hC₀'] using hrestrict 0 z
  refine ⟨F, C, hF₀, hC₀', hstep, hbase, ?_⟩
  intro E D hED
  exact enumeratedOrderedSubfield_maximalityCriterion carrier ξ hξ F C
    (fun n => (hstep n).cone_F) hrestrict hcapture E D hED

end Ising2DLambda.NecSuf.FisherZero
