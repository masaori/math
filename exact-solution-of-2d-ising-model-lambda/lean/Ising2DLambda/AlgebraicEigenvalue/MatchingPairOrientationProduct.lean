import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEntryProduct
import Ising2DLambda.AlgebraicEigenvalue.PerfectMatchingSign
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairOrientationProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open scoped Classical

variable {J : Type*} [Fintype J] [LinearOrder J]

/-- The endpoints of a matching pair in increasing order. -/
def concreteAscendingMatePair (m : J → J) (i : J) : J × J :=
  if i < m i then (i, m i) else (m i, i)

/-- Reversing an ordered pair contributes a minus sign. -/
noncomputable def concreteOrientationFactor (m : J → J) (i : J) : Polynomial Qbar :=
  if i < m i then 1 else -1

/-- The concrete polynomial argument follows the pointwise skew equality, separation
of finite products, and reindexing by the selected endpoint in that order. -/
private theorem matchingPairOrientationProduct_aux (S : Finset J) (m : J → J)
    (hS : ∀ i, m i ∈ S ↔ i ∉ S)
    (A : Matrix J J (Polynomial Qbar)) (hskew : ∀ i j, A j i = -A i j) :
    (∏ i ∈ S, A i (m i)) =
      (∏ i ∈ S, concreteOrientationFactor m i) *
        (∏ p ∈ S.image (concreteAscendingMatePair m), A p.1 p.2) := by
  classical
  have hchoice (i : J) (hi : i ∈ S) :
      (if (concreteAscendingMatePair m i).1 ∈ S then (concreteAscendingMatePair m i).1
       else (concreteAscendingMatePair m i).2) = i := by
    by_cases hlt : i < m i
    · simp [concreteAscendingMatePair, hlt, hi]
    · have hnot : m i ∉ S := by
        intro h
        exact ((hS i).mp h) hi
      simp [concreteAscendingMatePair, hlt, hnot]
  have hpair (i : J) :
      A i (m i) = concreteOrientationFactor m i *
        A (concreteAscendingMatePair m i).1 (concreteAscendingMatePair m i).2 := by
    by_cases hlt : i < m i
    · simp [concreteAscendingMatePair, concreteOrientationFactor, hlt]
    · simp [concreteAscendingMatePair, concreteOrientationFactor, hlt, hskew (m i) i]
  calc
    (∏ i ∈ S, A i (m i)) =
        ∏ i ∈ S, concreteOrientationFactor m i *
          A (concreteAscendingMatePair m i).1 (concreteAscendingMatePair m i).2 := by
            apply Finset.prod_congr rfl
            intro i _
            exact hpair i
    _ = (∏ i ∈ S, concreteOrientationFactor m i) *
          (∏ i ∈ S, A (concreteAscendingMatePair m i).1 (concreteAscendingMatePair m i).2) := by
            rw [← Finset.prod_mul_distrib]
    _ = (∏ i ∈ S, concreteOrientationFactor m i) *
          (∏ p ∈ S.image (concreteAscendingMatePair m), A p.1 p.2) := by
            congr 1
            refine Finset.prod_bij' (fun i _ => concreteAscendingMatePair m i)
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

/-- The selected endpoints enumerate precisely the ascending pairs of the
matching represented by the involution. -/
theorem selectedAscendingPairs_eq_matchingOrientedPairs
    (m : FixedPointFreeInvolution J) (S : Finset J)
    (hS : ∀ i, m.val i ∈ S ↔ i ∉ S) :
    S.image (concreteAscendingMatePair m.val) =
      matchingOrientedPairs (involutionToPerfectMatching m) := by
  classical
  ext p
  constructor
  · intro hp
    obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp hp
    by_cases hlt : i < m.val i
    · refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_⟩
      · simpa [concreteAscendingMatePair, hlt]
      · simpa only [involutionToPerfectMatching, involutionPairs,
          Set.mem_setOf_eq, concreteAscendingMatePair, if_pos hlt] using
          (show ∃ j : J, ({i, m.val i} : Set J) = {j, m.val j} from ⟨i, rfl⟩)
    · have hgt : m.val i < i := lt_of_le_of_ne (le_of_not_gt hlt) (m.property.1 i)
      refine Finset.mem_filter.mpr ⟨Finset.mem_univ _, ?_, ?_⟩
      · simpa [concreteAscendingMatePair, hlt] using hgt
      · simpa only [involutionToPerfectMatching, involutionPairs,
          Set.mem_setOf_eq, concreteAscendingMatePair, if_neg hlt] using
          (show ∃ j : J, ({m.val i, i} : Set J) = {j, m.val j} from
            ⟨m.val i, by rw [m.property.2 i]⟩)
  · intro hp
    obtain ⟨_, hlt, hpair⟩ := Finset.mem_filter.mp hp
    change ∃ i : J, ({p.1, p.2} : Set J) = {i, m.val i} at hpair
    obtain ⟨i, hi⟩ := hpair
    rcases Set.pair_eq_pair_iff.mp hi with h | h
    · have hm : m.val p.1 = p.2 := by simpa [h.1, h.2]
      by_cases hs : p.1 ∈ S
      · refine Finset.mem_image.mpr ⟨p.1, hs, ?_⟩
        simp [concreteAscendingMatePair, hm, hlt]
      · have hs2 : p.2 ∈ S := by simpa [hm] using (hS p.1).mpr hs
        refine Finset.mem_image.mpr ⟨p.2, hs2, ?_⟩
        have hm2 : m.val p.2 = p.1 := by rw [← hm, m.property.2]
        simp [concreteAscendingMatePair, hm2, not_lt.mpr hlt.le]
    · have hm : m.val p.1 = p.2 := by
        calc
          m.val p.1 = m.val (m.val i) := by rw [h.1]
          _ = i := m.property.2 i
          _ = p.2 := h.2.symm
      by_cases hs : p.1 ∈ S
      · refine Finset.mem_image.mpr ⟨p.1, hs, ?_⟩
        simp [concreteAscendingMatePair, hm, hlt]
      · have hs2 : p.2 ∈ S := by simpa [hm] using (hS p.1).mpr hs
        refine Finset.mem_image.mpr ⟨p.2, hs2, ?_⟩
        have hm2 : m.val p.2 = p.1 := by rw [← hm, m.property.2]
        simp [concreteAscendingMatePair, hm2, not_lt.mpr hlt.le]

/-- The first and second selected endpoints have the same orientation argument.
Every reversed pair contributes one minus sign by skew symmetry. -/
theorem matchingPairOrientationProduct (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : ∀ i j, A j i = -A i j) :
    (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ),
        concreteOrientationFactor τ.val i) *
      (∏ p ∈ (Finset.univ.filter (· ∈ matchingPairColor τ υ)).image
        (concreteAscendingMatePair τ.val), A p.1 p.2) := by
  classical
  apply matchingPairOrientationProduct_aux
  intro i
  simp only [Finset.mem_filter, Finset.mem_univ, true_and]
  exact matchingPairColor_alternates τ υ i
  exact hA

theorem matchingPairSecondOrientationProduct (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : ∀ i j, A j i = -A i j) :
    (∏ i ∈ Finset.univ.filter (· ∉ matchingPairColor τ υ), A i (υ.val i)) =
      (∏ i ∈ Finset.univ.filter (· ∉ matchingPairColor τ υ),
        concreteOrientationFactor υ.val i) *
      (∏ p ∈ (Finset.univ.filter (· ∉ matchingPairColor τ υ)).image
        (concreteAscendingMatePair υ.val), A p.1 p.2) := by
  classical
  apply matchingPairOrientationProduct_aux
  intro i
  simp only [Finset.mem_filter, Finset.mem_univ, true_and]
  exact not_congr (matchingPairSecondColor_alternates τ υ i)
  exact hA

/-- Derivation of the concrete statements from the ring argument. -/
theorem matchingPairOrientationProduct_from_necSuf (τ υ : FixedPointFreeInvolution J)
    (A : Matrix J J (Polynomial Qbar))
    (hA : ∀ i j, A j i = -A i j) :
    (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ), A i (τ.val i)) =
      (∏ i ∈ Finset.univ.filter (· ∈ matchingPairColor τ υ),
        concreteOrientationFactor τ.val i) *
      (∏ p ∈ (Finset.univ.filter (· ∈ matchingPairColor τ υ)).image
        (concreteAscendingMatePair τ.val), A p.1 p.2) := by
  classical
  have hPair : concreteAscendingMatePair τ.val =
      NecSuf.AlgebraicEigenvalue.ascendingMatePair τ.val := by
    funext i
    rfl
  have hFactor : concreteOrientationFactor τ.val =
      (NecSuf.AlgebraicEigenvalue.orientationFactor τ.val : J → Polynomial Qbar) := by
    funext i
    rfl
  rw [hPair, hFactor]
  apply NecSuf.AlgebraicEigenvalue.orientationProduct_necSuf
  · intro i
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    exact matchingPairColor_alternates τ υ i
  · exact hA

end Ising2DLambda.AlgebraicEigenvalue
