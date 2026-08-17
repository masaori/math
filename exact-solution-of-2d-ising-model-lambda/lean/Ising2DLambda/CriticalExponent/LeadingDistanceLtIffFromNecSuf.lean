/- `claim_leading_distance_lt_iff_close_zero` の具体版が必要十分版の特殊化として得られること。 -/
import Ising2DLambda.CriticalExponent.LeadingDistance
import Ising2DLambda.NecSuf.CriticalExponent.LeadingDistanceLtIff

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

theorem leadingDistance_lt_iff_from_necSuf
    (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2)
    (t : data.carrier) :
    realAlgebraicLt data (leadingDistance L hL data s hs) t ↔
      ∃ ξ ∈ FisherZeroSet L,
        realAlgebraicLt data (distanceSquaredToCriticalPoint data s hs ξ) t := by
  have hiff := Ising2DLambda.NecSuf.CriticalExponent.min_lt_iff_exists_lt_necSuf
    (candidate := fun xi : Qbar => xi ∈ FisherZeroSet L)
    (distance := distanceSquaredToCriticalPoint data s hs)
    (lt := realAlgebraicLt data)
    (m := leadingDistance L hL data s hs)
    (t := t)
    (hmMem := by
      obtain ⟨xi, hxi, hdist⟩ :=
        (mem_leadingDistanceFinset L data s hs
          (leadingDistance L hL data s hs)).1
          (leadingDistance_isMin L hL data s hs).1
      exact ⟨xi, hxi, hdist⟩)
    (hmMin := by
      intro xi hxi
      have hmem : distanceSquaredToCriticalPoint data s hs xi ∈
          leadingDistanceFinset L data s hs :=
        (mem_leadingDistanceFinset L data s hs _).2 ⟨xi, hxi, rfl⟩
      exact (leadingDistance_isMin L hL data s hs).2 _ hmem)
    (htrans := fun a b c hab hbc => realAlgebraicLt_trans data a b c hab hbc)
  constructor
  · intro h
    obtain ⟨xi, hxi, hlt⟩ := hiff.1 h
    exact ⟨xi, hxi, hlt⟩
  · rintro ⟨xi, hxi, hlt⟩
    exact hiff.2 ⟨xi, hxi, hlt⟩

end Ising2DLambda.CriticalExponent
