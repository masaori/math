/-
「横断の平滑化後の頂点横断数は減少後の二軸の直進通過数の積である」
（`claim_smoothing_vertex_crossing_number_update`）の具体版。
通過頂点と平滑化前後の局所通過を有限添字からの写像として持つ。
-/
import Ising2DLambda.KacWard.VertexCrossingFactorization
import Ising2DLambda.KacWard.SmoothingStraightVisitCount

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 選んだ横断の頂点で、平滑化後の横断数は平滑化前の各軸の
直進通過数から一つずつ引いた積に等しい。 -/
theorem smoothing_vertex_crossing_number_update {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight) :
    ((((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).filter
          fun p => vertex p.1 = vertex a).card)
      = ((Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card - 1)
        * ((Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card - 1) := by
  let n₀ := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit k).turn = .straight ∧ (visit k).vertical = false).card
  let n₁ := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit k).turn = .straight ∧ (visit k).vertical = true).card
  let n₀' := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit' k).turn = .straight ∧ (visit' k).vertical = false).card
  let n₁' := (Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
    (visit' k).turn = .straight ∧ (visit' k).vertical = true).card
  let c' := (((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
    p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).filter
      fun p => vertex p.1 = vertex a).card
  have h₀ : n₀ = n₀' + 1 := by
    simpa [n₀, n₀'] using
      (smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
        (vertex a) false)
  have h₁ : n₁ = n₁' + 1 := by
    simpa [n₁, n₁'] using
      (smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
        (vertex a) true)
  have hc : c' = n₀' * n₁' :=
    vertex_crossing_number_factorization vertex visit' (vertex a)
  exact two_factor_after_single_decrement_necSuf n₀ n₁ n₀' n₁' c' h₀ h₁ hc

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_vertex_crossing_number_update_from_necSuf {m : ℕ} {V : Type}
    [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight) :
    ((((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).filter
          fun p => vertex p.1 = vertex a).card)
      = ((Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card - 1)
        * ((Finset.univ.filter fun k : Fin m => vertex k = vertex a ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card - 1) :=
  smoothing_vertex_crossing_number_update vertex visit visit' a b hcross hother ha hb

end Ising2DLambda.KacWard
