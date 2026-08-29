/-
「横断の平滑化は他の頂点の横断数を変えない」
（`claim_smoothing_other_vertex_crossing_invariance`）の具体版。
通過頂点と平滑化前後の局所通過を有限添字からの写像として持つ。
人手証明の等式の鎖と 1 対 1 に対応する:
平滑化後の積表示 → 各軸の直進通過数の不変（w ≠ v の場合）→ 平滑化前の積表示。
-/
import Ising2DLambda.KacWard.SmoothingVertexCrossingNumber

namespace Ising2DLambda.KacWard

/-- 横断の頂点と異なる頂点 `w` では、平滑化後の横断数は平滑化前の横断数に等しい。 -/
theorem smoothing_other_vertex_crossing_invariance {m : ℕ} {V : Type} [DecidableEq V]
    (vertex : Fin m → V) (visit visit' : Fin m → LocalVisit) (a b : Fin m)
    (hcross : IndexCrossing vertex visit a b)
    (hother : ∀ r, r ≠ a → r ≠ b → visit' r = visit r)
    (ha : (visit' a).turn ≠ .straight) (hb : (visit' b).turn ≠ .straight)
    (w : V) (hw : vertex a ≠ w) :
    ((((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
        p.1 < p.2 ∧ IndexCrossing vertex visit' p.1 p.2).filter
          fun p => vertex p.1 = w).card)
      = ((((Finset.univ ×ˢ Finset.univ).filter fun p : Fin m × Fin m =>
          p.1 < p.2 ∧ IndexCrossing vertex visit p.1 p.2).filter
            fun p => vertex p.1 = w).card) := by
  -- 各軸の直進通過数は w ≠ v の場合に不変（人手証明の第二・第三の等号）
  have h₀ : (Finset.univ.filter fun k : Fin m => vertex k = w ∧
      (visit' k).turn = .straight ∧ (visit' k).vertical = false).card
      = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
        (visit k).turn = .straight ∧ (visit k).vertical = false).card := by
    have := smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
      w false
    rw [if_neg hw, Nat.add_zero] at this
    exact this.symm
  have h₁ : (Finset.univ.filter fun k : Fin m => vertex k = w ∧
      (visit' k).turn = .straight ∧ (visit' k).vertical = true).card
      = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
        (visit k).turn = .straight ∧ (visit k).vertical = true).card := by
    have := smoothing_straight_visit_count_update vertex visit visit' a b hcross hother ha hb
      w true
    rw [if_neg hw, Nat.add_zero] at this
    exact this.symm
  -- 平滑化後と平滑化前の積表示（人手証明の第一・第四の等号）を因子の等式で結ぶ
  calc
    _ = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit' k).turn = .straight ∧ (visit' k).vertical = false).card
        * (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit' k).turn = .straight ∧ (visit' k).vertical = true).card :=
      vertex_crossing_number_factorization vertex visit' w
    _ = (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit k).turn = .straight ∧ (visit k).vertical = false).card
        * (Finset.univ.filter fun k : Fin m => vertex k = w ∧
          (visit k).turn = .straight ∧ (visit k).vertical = true).card := by rw [h₀, h₁]
    _ = _ := (vertex_crossing_number_factorization vertex visit w).symm

end Ising2DLambda.KacWard
