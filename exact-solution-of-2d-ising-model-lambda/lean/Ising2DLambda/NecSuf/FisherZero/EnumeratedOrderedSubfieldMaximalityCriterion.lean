import Ising2DLambda.NecSuf.FisherZero.SubfieldPositiveCone

namespace Ising2DLambda.NecSuf.FisherZero

/-- この論法が使うのは、台の表示写像、正錐の制限、列挙の全射性だけである。
台が部分体であることや体演算は使わない。 -/
theorem enumeratedOrderedSubfield_maximalityCriterion {K T : Type}
    [Zero K] [Add K] [Mul K] [Neg K]
    (carrier : T → Set K) (ξ : ℕ → K) (hξ : Function.Surjective ξ)
    (F : ℕ → T) (C : ℕ → Set K)
    (hcone : ∀ n, IsPositiveConeOn (carrier (F n)) (C n))
    (hrestrict : ∀ (n : ℕ) (z : K),
      (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ carrier (F n)) ↔ z ∈ C n)
    (hcapture : ∀ n (E : T) (D : Set K),
      ExtendsPositiveConeOn (carrier (F n)) (carrier E) (C n) D →
        ξ n ∈ carrier E → ξ n ∈ carrier (F (n + 1)))
    (E : T) (D : Set K)
    (hED : ExtendsPositiveConeOn {x | ∃ n, x ∈ carrier (F n)}
      (carrier E) {x | ∃ n, x ∈ C n} D) :
    carrier E = {x | ∃ n, x ∈ carrier (F n)} := by
  ext z
  constructor
  · intro hz
    obtain ⟨n, hn⟩ := hξ z
    have hFnE : ∀ x : K, x ∈ carrier (F n) → x ∈ carrier E := by
      intro x hx
      exact hED.subset_le x ⟨n, hx⟩
    have hDn : ∀ x : K, (x ∈ D ∧ x ∈ carrier (F n)) ↔ x ∈ C n := by
      intro x
      constructor
      · rintro ⟨hxD, hxF⟩
        exact (hrestrict n x).1 ⟨(hED.inter_eq x).1
          ⟨hxD, ⟨n, hxF⟩⟩, hxF⟩
      · intro hxC
        have hxF := (hcone n).subset x hxC
        exact ⟨((hED.inter_eq x).2 ⟨n, hxC⟩).1, hxF⟩
    have hExt : ExtendsPositiveConeOn (carrier (F n)) (carrier E) (C n) D :=
      ⟨hFnE, hcone n, hED.cone_E, hDn⟩
    exact ⟨n + 1, hn ▸ hcapture n E D hExt (hn.symm ▸ hz)⟩
  · exact hED.subset_le z

end Ising2DLambda.NecSuf.FisherZero
