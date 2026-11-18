import Ising2DLambda.FisherZero.EnumeratedOrderedSubfieldMaximalityCriterion

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_increasing_positive_cone_union_restricts_to_stage` の具体版。各段の
正錐の制限を一段ずつ遡り、和集合から任意の段への制限を得る。 -/
theorem increasingPositiveConeUnion_restrictsToStage
    (F : ℕ → Subfield Qbar) (C : ℕ → Set Qbar)
    (hstep : ∀ n, ExtendsPositiveCone (F n) (F (n + 1)) (C n) (C (n + 1)))
    (n : ℕ) (z : Qbar) :
    (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ F n) ↔ z ∈ C n := by
  have hFmono : Monotone F :=
    monotone_nat_of_le_succ (fun j => (hstep j).subfield_le)
  have hCmono : ∀ j k, j ≤ k → C j ⊆ C k := by
    intro j k hjk
    induction k, hjk using Nat.le_induction with
    | base => exact Set.Subset.rfl
    | succ k _ ih =>
      intro x hx
      have hxk := ih hx
      exact (((hstep k).inter_eq x).2 hxk).1
  have hback : ∀ j k, j ≤ k → ∀ x, x ∈ C k → x ∈ F j → x ∈ C j := by
    intro j k hjk
    induction k, hjk using Nat.le_induction with
    | base => intro x hx _; exact hx
    | succ k hjk ih =>
      intro x hx hFj
      have hFk : x ∈ F k := hFmono hjk hFj
      have hxk : x ∈ C k := ((hstep k).inter_eq x).1 ⟨hx, hFk⟩
      exact ih x hxk hFj
  constructor
  · rintro ⟨⟨k, hCk⟩, hFn⟩
    rcases le_total k n with hkn | hnk
    · exact hCmono k n hkn hCk
    · exact hback n k hnk z hCk hFn
  · intro hCn
    exact ⟨⟨n, hCn⟩, (hstep n).cone_F.subset z hCn⟩

end Ising2DLambda.FisherZero
