import Ising2DLambda.KacWard.WalkEqualsCellBoundary

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.TransferMatrix

private theorem edgeOfRow_eq_iff (L : ℕ) [NeZero L]
    (side side' : Bool) (i j i' j' : ZMod L) :
    edgeOfRow L side i j = edgeOfRow L side' i' j' ↔
      side = side' ∧ i = i' ∧ j = j' := by
  constructor
  · intro h
    have h' : edgeOfSum L (match side with
        | false => Sum.inl (i, j)
        | true => Sum.inr (i, j)) =
        edgeOfSum L (match side' with
        | false => Sum.inl (i', j')
        | true => Sum.inr (i', j')) := by
      cases side <;> cases side' <;> simpa [edgeOfSum] using h
    have hinj := edgeOfSum_injective L h'
    cases side <;> cases side' <;> simp_all
  · rintro ⟨rfl, rfl, rfl⟩
    rfl

theorem cellContribution_horizontal (L : ℕ) [NeZero L]
    (i j r c : ZMod L) :
    ((cellBoundaryEdges L r c).map
      (orientedEdgeCoefficient (edgeOfRow L false i j))).sum =
      (if (r, c) = (i, j) then (1 : ℤ) else 0) -
      (if (r, c) = (i - 1, j) then (1 : ℤ) else 0) := by
  have hrow : i = r + 1 ↔ r = i - 1 := by
    constructor <;> intro h <;> rw [h] <;> ring
  simp [cellBoundaryEdges, orientedEdgeCoefficient,
    edgeOfRow_eq_iff, Prod.mk.injEq, eq_comm, hrow]
  split_ifs <;> omega

theorem cellSetEdgeCoefficient_horizontal (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (i j : ZMod L) :
    cellSetEdgeCoefficient L S (edgeOfRow L false i j) =
      (if (i, j) ∈ S then (1 : ℤ) else 0) -
      (if (i - 1, j) ∈ S then (1 : ℤ) else 0) := by
  classical
  simp only [cellSetEdgeCoefficient]
  simp_rw [cellContribution_horizontal]
  simp [Finset.sum_sub_distrib]

theorem cellContribution_vertical (L : ℕ) [NeZero L]
    (i j r c : ZMod L) :
    ((cellBoundaryEdges L r c).map
      (orientedEdgeCoefficient (edgeOfRow L true i j))).sum =
      (if (r, c) = (i, j - 1) then (1 : ℤ) else 0) -
      (if (r, c) = (i, j) then (1 : ℤ) else 0) := by
  have hcol : j = c + 1 ↔ c = j - 1 := by
    constructor <;> intro h <;> rw [h] <;> ring
  simp [cellBoundaryEdges, orientedEdgeCoefficient,
    edgeOfRow_eq_iff, Prod.mk.injEq, eq_comm, hcol]
  split_ifs <;> omega

theorem cellSetEdgeCoefficient_vertical (L : ℕ) [NeZero L]
    (S : Finset (ZMod L × ZMod L)) (i j : ZMod L) :
    cellSetEdgeCoefficient L S (edgeOfRow L true i j) =
      (if (i, j - 1) ∈ S then (1 : ℤ) else 0) -
      (if (i, j) ∈ S then (1 : ℤ) else 0) := by
  classical
  simp only [cellSetEdgeCoefficient]
  simp_rw [cellContribution_vertical]
  simp [Finset.sum_sub_distrib]

end Ising2DLambda.KacWard
