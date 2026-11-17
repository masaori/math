import Ising2DLambda.FisherZero.IncreasingPositiveConeUnionFromNecSuf

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 列挙段階の取込条件から極大性を得る具体版。和集合を各段へ制限すると
その段の正錐に戻ることを仮定する。住処は Qbar だけである。 -/
theorem enumeratedOrderedSubfield_maximalityCriterion
    (ξ : ℕ → Qbar) (hξ : Function.Surjective ξ)
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1)))
    (hrestrict : ∀ (n : ℕ) (z : Qbar),
      (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ F n) ↔ z ∈ C n)
    (hcapture : ∀ n (E : Subfield Qbar) (D : Set Qbar),
      ExtendsPositiveCone (F n) E (C n) D → ξ n ∈ E → ξ n ∈ F (n + 1))
    (E : Subfield Qbar) (D : Set Qbar)
    (hED : ExtendsPositiveCone
      (increasingSubfieldUnion F
        (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)))
      E {x | ∃ n, x ∈ C n} D) :
    E = increasingSubfieldUnion F
      (monotone_nat_of_le_succ (fun n => (hstep n).subfield_le)) := by
  apply Subfield.ext
  intro z
  constructor
  · intro hz
    obtain ⟨n, hn⟩ := hξ z
    have hFnE : ∀ x : Qbar, x ∈ F n → x ∈ E := by
      intro x hx
      exact hED.subfield_le x ⟨n, hx⟩
    have hDn : ∀ x : Qbar, (x ∈ D ∧ x ∈ F n) ↔ x ∈ C n := by
      intro x
      constructor
      · rintro ⟨hxD, hxF⟩
        exact (hrestrict n x).1 ⟨(hED.inter_eq x).1
          ⟨hxD, ⟨n, hxF⟩⟩, hxF⟩
      · intro hxC
        have hxF := (hstep n).cone_F.subset x hxC
        exact ⟨((hED.inter_eq x).2 ⟨n, hxC⟩).1, hxF⟩
    have hExt : ExtendsPositiveCone (F n) E (C n) D :=
      ⟨hFnE, (hstep n).cone_F, hED.cone_E, hDn⟩
    exact ⟨n + 1, hn ▸ hcapture n E D hExt (hn.symm ▸ hz)⟩
  · exact hED.subfield_le z

end Ising2DLambda.FisherZero
