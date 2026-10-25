import Mathlib.LinearAlgebra.Multilinear.Basic

namespace Ising2DLambda.NecSuf.KacWard

open Finset

/-- A choice of the second contribution is a subset of the finite set of pairs. -/
theorem taggedProductExpansion {ι R : Type*} [DecidableEq ι] [CommRing R]
    (s : Finset ι) (long short : ι → R) :
    (∏ p ∈ s, (long p - short p)) =
      ∑ t ∈ s.powerset,
        (-1 : R) ^ t.card * (∏ p ∈ s \ t, long p) * (∏ p ∈ t, short p) := by
  classical
  induction s using Finset.induction_on with
  | empty => simp
  | @insert a s ha ih =>
    rw [Finset.prod_insert ha, Finset.sum_powerset_insert ha]
    have hnot (t : Finset ι) (ht : t ∈ s.powerset) : a ∉ t :=
      Finset.notMem_of_mem_powerset_of_notMem ht ha
    have hleft (t : Finset ι) (ht : t ∈ s.powerset) :
        (-1 : R) ^ t.card * (∏ p ∈ insert a s \ t, long p) * (∏ p ∈ t, short p) =
        long a * ((-1 : R) ^ t.card * (∏ p ∈ s \ t, long p) * (∏ p ∈ t, short p)) := by
      have hd : insert a s \ t = insert a (s \ t) := by
        ext x
        by_cases hx : x = a
        · simp [hx, hnot t ht]
        · simp [hx]
      rw [hd, Finset.prod_insert (by simp [ha])]
      ring
    have hright (t : Finset ι) (ht : t ∈ s.powerset) :
        (-1 : R) ^ (insert a t).card *
          (∏ p ∈ insert a s \ insert a t, long p) *
          (∏ p ∈ insert a t, short p) =
        -short a * ((-1 : R) ^ t.card * (∏ p ∈ s \ t, long p) * (∏ p ∈ t, short p)) := by
      have hd : insert a s \ insert a t = s \ t := by
        ext x
        by_cases hx : x = a
        · simp [hx, ha]
        · simp [hx]
      rw [hd, Finset.card_insert_of_notMem (hnot t ht), Finset.prod_insert (hnot t ht)]
      simp [pow_succ]
      ring
    rw [Finset.sum_congr rfl hleft, Finset.sum_congr rfl hright]
    rw [← Finset.mul_sum, ← Finset.mul_sum, ← ih]
    ring

end Ising2DLambda.NecSuf.KacWard
