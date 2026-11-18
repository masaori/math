import Ising2DLambda.NecSuf.FisherZero.EnumeratedOrderedSubfieldMaximalityCriterion

namespace Ising2DLambda.NecSuf.FisherZero

/-- この論法には体の演算が要らない。台の増大と、正錐の一段の制限だけを使う。 -/
theorem increasingPositiveConeUnion_restrictsToStage {K : Type}
    (F C : ℕ → Set K)
    (hFstep : ∀ j, F j ⊆ F (j + 1))
    (hCsubset : ∀ j, C j ⊆ F j)
    (hCstep : ∀ j x, (x ∈ C (j + 1) ∧ x ∈ F j) ↔ x ∈ C j)
    (n : ℕ) (z : K) :
    (z ∈ {x | ∃ k, x ∈ C k} ∧ z ∈ F n) ↔ z ∈ C n := by
  have hFmono : ∀ j k, j ≤ k → F j ⊆ F k := by
    intro j k hjk
    induction k, hjk using Nat.le_induction with
    | base => exact Set.Subset.rfl
    | succ k _ ih => exact Set.Subset.trans ih (hFstep k)
  have hCmono : ∀ j k, j ≤ k → C j ⊆ C k := by
    intro j k hjk
    induction k, hjk using Nat.le_induction with
    | base => exact Set.Subset.rfl
    | succ k _ ih =>
      intro x hx
      have hxk := ih hx
      exact ((hCstep k x).2 hxk).1
  have hback : ∀ j k, j ≤ k → ∀ x, x ∈ C k → x ∈ F j → x ∈ C j := by
    intro j k hjk
    induction k, hjk using Nat.le_induction with
    | base => intro x hx _; exact hx
    | succ k hjk ih =>
      intro x hx hFj
      have hFk : x ∈ F k := hFmono j k hjk hFj
      have hxk : x ∈ C k := (hCstep k x).1 ⟨hx, hFk⟩
      exact ih x hxk hFj
  constructor
  · rintro ⟨⟨k, hCk⟩, hFn⟩
    rcases le_total k n with hkn | hnk
    · exact hCmono k n hkn hCk
    · exact hback n k hnk z hCk hFn
  · intro hCn
    exact ⟨⟨n, hCn⟩, hCsubset n hCn⟩

end Ising2DLambda.NecSuf.FisherZero
