import Ising2DLambda.KacWard.CellBoundaryWinding

namespace Ising2DLambda.NecSuf.KacWard

/-- The coefficient of a basis edge in an oriented occurrence. -/
def coefficient {E : Type*} [DecidableEq E]
    (edge : E) (occurrence : E × Bool) : ℤ :=
  if occurrence.1 = edge then 1 - 2 * (occurrence.2.toNat : ℤ) else 0

private theorem occurrenceWeight_sum {E : Type*} [Fintype E] [DecidableEq E]
    (occurrence : E × Bool) (weight : E → ℤ) :
    (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1 =
      ∑ edge : E, coefficient edge occurrence * weight edge := by
  simp [coefficient]

private theorem listWeight_sum {E : Type*} [Fintype E] [DecidableEq E]
    (occurrences : List (E × Bool)) (weight : E → ℤ) :
    (occurrences.map fun occurrence =>
      (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum =
        ∑ edge : E,
          ((occurrences.map (coefficient edge)).sum) * weight edge := by
  induction occurrences with
  | nil => simp
  | cons occurrence tail ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [ih, occurrenceWeight_sum occurrence weight, ← Finset.sum_add_distrib]
      congr 1
      funext edge
      simp [add_mul]

/-- Equality of the integer coefficient of every basis edge determines every
weighted evaluation of a finite walk and a finite family of cell boundaries. -/
theorem equal_coefficients_equal_weighted_evaluations
    {E C I : Type*} [Fintype E] [DecidableEq E] [Fintype I]
    [DecidableEq C] (walk : I → E × Bool) (cells : Finset C)
    (boundary : C → List (E × Bool))
    (hcoeff : ∀ edge : E,
      (∑ i : I, coefficient edge (walk i)) =
        ∑ cell ∈ cells, ((boundary cell).map (coefficient edge)).sum)
    (weight : E → ℤ) :
    (∑ i : I, (1 - 2 * ((walk i).2.toNat : ℤ)) * weight (walk i).1) =
      ∑ cell ∈ cells,
        ((boundary cell).map fun occurrence =>
          (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum := by
  classical
  calc
    _ = ∑ i : I, ∑ edge : E,
          coefficient edge (walk i) * weight edge := by
            apply Finset.sum_congr rfl
            intro i _
            exact occurrenceWeight_sum (walk i) weight
    _ = ∑ edge : E, ∑ i : I,
          coefficient edge (walk i) * weight edge := Finset.sum_comm
    _ = ∑ edge : E, (∑ i : I, coefficient edge (walk i)) * weight edge := by
          simp [Finset.sum_mul]
    _ = ∑ edge : E,
          (∑ cell ∈ cells, ((boundary cell).map (coefficient edge)).sum) *
            weight edge := by
          apply Finset.sum_congr rfl
          intro edge _
          rw [hcoeff edge]
    _ = ∑ cell ∈ cells, ∑ edge : E,
          ((boundary cell).map (coefficient edge)).sum * weight edge := by
          simp only [Finset.sum_mul]
          exact Finset.sum_comm
    _ = _ := by
          apply Finset.sum_congr rfl
          intro cell _
          symm
          exact listWeight_sum (boundary cell) weight

theorem signed_coefficients_zero_weighted_evaluation
    {E C I : Type*} [Fintype E] [DecidableEq E] [Fintype I]
    [DecidableEq C] (walk : I → E × Bool) (cells : Finset C)
    (boundary : C → List (E × Bool)) (weight : E → ℤ)
    (ε : ℤ) (hε : ε ≠ 0)
    (hcoeff : ∀ edge : E,
      (∑ cell ∈ cells, ((boundary cell).map (coefficient edge)).sum) =
        ε * ∑ i : I, coefficient edge (walk i))
    (hboundary : ∑ cell ∈ cells,
      ((boundary cell).map fun occurrence =>
        (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum = 0) :
    (∑ i : I, (1 - 2 * ((walk i).2.toNat : ℤ)) * weight (walk i).1) = 0 := by
  have hsum : ε * (∑ i : I,
      (1 - 2 * ((walk i).2.toNat : ℤ)) * weight (walk i).1) = 0 := by
    calc
      _ = ε * ∑ edge : E,
          (∑ i : I, coefficient edge (walk i)) * weight edge := by
            congr 1
            calc
              _ = ∑ i : I, ∑ edge : E,
                    coefficient edge (walk i) * weight edge := by
                      apply Finset.sum_congr rfl
                      intro i _
                      exact occurrenceWeight_sum (walk i) weight
              _ = _ := by rw [Finset.sum_comm]; simp [Finset.sum_mul]
      _ = ∑ edge : E,
          (∑ cell ∈ cells, ((boundary cell).map (coefficient edge)).sum) *
            weight edge := by
              rw [Finset.mul_sum]
              apply Finset.sum_congr rfl
              intro edge _
              rw [hcoeff edge]
              ring
      _ = ∑ cell ∈ cells,
          ((boundary cell).map fun occurrence =>
            (1 - 2 * (occurrence.2.toNat : ℤ)) * weight occurrence.1).sum := by
              simp only [Finset.sum_mul]
              rw [Finset.sum_comm]
              apply Finset.sum_congr rfl
              intro cell _
              symm
              exact listWeight_sum (boundary cell) weight
      _ = 0 := hboundary
  exact (mul_eq_zero.mp hsum).resolve_left hε

end Ising2DLambda.NecSuf.KacWard
