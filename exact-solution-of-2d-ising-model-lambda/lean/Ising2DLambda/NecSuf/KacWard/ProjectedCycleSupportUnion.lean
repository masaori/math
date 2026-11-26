/-
交互成分の第一色が射影像を覆うことの必要十分版。
各点と第二の相手が同じ成分に入り、第二の相手が色を反転させ、
その相手が射影を保つことだけを使う。
-/
import Mathlib.Data.Set.Basic

namespace Ising2DLambda.NecSuf.KacWard

/-- 二色のいずれかの点が、各点と同じ射影値を持つ。 -/
theorem projectedCycleSupportUnion_eq_range {J E : Type*}
    (υ : J → J) (B : J → Set J) (C : Set J) (p : J → E)
    (hself : ∀ i, i ∈ B i) (hmate : ∀ i, υ i ∈ B i)
    (hcolor : ∀ i, υ i ∈ C ↔ i ∉ C)
    (hp : ∀ i, p (υ i) = p i) :
    {e | ∃ i j : J, j ∈ B i ∧ j ∈ C ∧ p j = e} = Set.range p := by
  classical
  ext e
  constructor
  · rintro ⟨i, j, hj, hc, rfl⟩
    exact ⟨j, rfl⟩
  · rintro ⟨i, rfl⟩
    by_cases hc : i ∈ C
    · exact ⟨i, i, hself i, hc, rfl⟩
    · exact ⟨i, υ i, hmate i, (hcolor i).2 hc, hp i⟩

end Ising2DLambda.NecSuf.KacWard
