import Mathlib.Algebra.Polynomial.Basic
import Mathlib.Data.Fintype.BigOperators

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {J R : Type*} [LinearOrder J] [CommRing R]

def ascendingMatePair (m : J → J) (i : J) : J × J :=
  if i < m i then (i, m i) else (m i, i)

def orientationFactor (m : J → J) (i : J) : R :=
  if i < m i then 1 else -1

/-- Each selected endpoint is sent to its ascending pair. The inverse chooses the
endpoint of that pair in `S`; alternation makes this choice unique. -/
theorem orientationProduct_necSuf (S : Finset J) (m : J → J)
    (hS : ∀ i, m i ∈ S ↔ i ∉ S)
    (A : J → J → R) (hskew : ∀ i j, A j i = -A i j) :
    (∏ i ∈ S, A i (m i)) =
      (∏ i ∈ S, orientationFactor m i) *
        (∏ p ∈ S.image (ascendingMatePair m), A p.1 p.2) := by
  classical
  have hchoice (i : J) (hi : i ∈ S) :
      (if (ascendingMatePair m i).1 ∈ S then (ascendingMatePair m i).1
       else (ascendingMatePair m i).2) = i := by
    by_cases hlt : i < m i
    · simp [ascendingMatePair, hlt, hi]
    · have hnot : m i ∉ S := by
        intro h
        exact ((hS i).mp h) hi
      simp [ascendingMatePair, hlt, hnot]
  have hpair (i : J) :
      A i (m i) = orientationFactor m i *
        A (ascendingMatePair m i).1 (ascendingMatePair m i).2 := by
    by_cases hlt : i < m i
    · simp [ascendingMatePair, orientationFactor, hlt]
    · simp [ascendingMatePair, orientationFactor, hlt, hskew (m i) i]
  calc
    (∏ i ∈ S, A i (m i)) =
        ∏ i ∈ S, orientationFactor m i *
          A (ascendingMatePair m i).1 (ascendingMatePair m i).2 := by
            apply Finset.prod_congr rfl
            intro i _
            exact hpair i
    _ = (∏ i ∈ S, orientationFactor m i) *
          (∏ i ∈ S, A (ascendingMatePair m i).1 (ascendingMatePair m i).2) := by
            rw [← Finset.prod_mul_distrib]
    _ = (∏ i ∈ S, orientationFactor m i) *
          (∏ p ∈ S.image (ascendingMatePair m), A p.1 p.2) := by
            congr 1
            refine Finset.prod_bij' (fun i _ => ascendingMatePair m i)
              (fun p _ => if p.1 ∈ S then p.1 else p.2)
              (fun i hi => Finset.mem_image.mpr ⟨i, hi, rfl⟩)
              (fun p hp => ?_) (fun i hi => hchoice i hi)
              (fun p hp => ?_) ?_
            · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
              simpa [hchoice i hi] using hi
            · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
              rw [hchoice i hi]
            · intro i _
              rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
