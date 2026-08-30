/-
「平滑化後の横断数の全体更新」の具体版。
人手証明と同じく、頂点ごとの分解、横断の頂点での積の差、
他頂点の不変性を組み合わせる。
-/
import Ising2DLambda.KacWard.CrossingNumberVertexDecomposition
import Ising2DLambda.KacWard.SmoothingOtherVertexInvariance
import Ising2DLambda.NecSuf.KacWard.SmoothingCrossingNumberUpdate

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 一つの横断を平滑化した後の横断数は、選んだ頂点の
二軸の直進通過数によって更新される。 -/
theorem smoothing_crossing_number_update {m : ℕ} {V : Type} [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card + 1
      = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = false).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = true).card := by
  let crossingCount := fun data : Fin m → LocalVisit =>
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
      p.1 < p.2 ∧ IndexCrossing vertex data p.1 p.2).card
  let vertexCount := fun data : Fin m → LocalVisit => fun w : V =>
    (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
      p.1 < p.2 ∧ IndexCrossing vertex data p.1 p.2).filter
        fun p => vertex p.1 = w).card
  let axisZero := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit k).turn = .straight ∧ (visit k).vertical = false).card
  let axisOne := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit k).turn = .straight ∧ (visit k).vertical = true).card
  let axisZero' := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit' k).turn = .straight ∧ (visit' k).vertical = false).card
  let axisOne' := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit' k).turn = .straight ∧ (visit' k).vertical = true).card
  have hdecomp : crossingCount visit = ∑ w : V, vertexCount visit w :=
    crossing_number_vertex_decomposition vertex visit
  have hdecomp' : crossingCount visit' = ∑ w : V, vertexCount visit' w :=
    crossing_number_vertex_decomposition vertex visit'
  have hzero : axisZero = axisZero' + 1 := by
    simpa [axisZero, axisZero'] using
      (smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
        (vertex a) false)
  have hone : axisOne = axisOne' + 1 := by
    simpa [axisOne, axisOne'] using
      (smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
        (vertex a) true)
  have hbefore : vertexCount visit (vertex a) = axisZero * axisOne := by
    simpa [vertexCount, axisZero, axisOne] using
      (vertex_crossing_number_factorization vertex visit (vertex a))
  have hafter : vertexCount visit' (vertex a) = axisZero' * axisOne' := by
    simpa [vertexCount, axisZero', axisOne'] using
      (vertex_crossing_number_factorization vertex visit' (vertex a))
  have hlocal : vertexCount visit (vertex a) + 1 =
      vertexCount visit' (vertex a) + axisZero + axisOne := by
    rw [hbefore, hafter, hzero, hone]
    simp only [Nat.add_mul, Nat.mul_add, Nat.one_mul, Nat.mul_one]
    omega
  have hvertexOther : ∀ w, w ≠ vertex a → vertexCount visit' w = vertexCount visit w := by
    intro w hw
    simpa [vertexCount] using
      (smoothing_other_vertex_crossing_invariance vertex visit visit' a b hcross hother ha hb w
        (Ne.symm hw))
  have hsum := single_fiber_update_sum_necSuf
    (vertexCount visit) (vertexCount visit') (vertex a) axisZero axisOne hlocal hvertexOther
  change crossingCount visit + 1 = crossingCount visit' + axisZero + axisOne
  rw [hdecomp, hdecomp']
  exact hsum

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_crossing_number_update_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V] [Fintype V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight) :
    ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).card + 1
      = ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = false).card
        + (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
            (visit k).turn = .straight ∧ (visit k).vertical = true).card :=
  smoothing_crossing_number_update vertex visit visit' a b hcross hother ha hb

end Ising2DLambda.KacWard
