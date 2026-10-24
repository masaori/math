import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue
open Classical

/-- 有限性と順序は、色と二つの相手写像が確定した後の置換の復元に不要である。 -/
theorem recoveredMatchingPair_permutation_eq_necSuf {J : Type*}
    (σ : Equiv.Perm J) (C D : Set J) (τ υ : J → J)
    (hcolor : ∀ i, i ∈ D ↔ i ∈ C)
    (hfirst : ∀ i, i ∈ C → τ i = σ i)
    (hsecond : ∀ i, i ∉ C → υ i = σ i) :
    (fun i => if i ∈ D then τ i else υ i) = σ := by
  classical
  funext i
  by_cases hi : i ∈ C
  · have hd : i ∈ D := (hcolor i).mpr hi
    calc
      (if i ∈ D then τ i else υ i) = τ i := if_pos hd
      _ = σ i := hfirst i hi
  · have hd : i ∉ D := fun h => hi ((hcolor i).mp h)
    calc
      (if i ∈ D then τ i else υ i) = υ i := if_neg hd
      _ = σ i := hsecond i hi

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
