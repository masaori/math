/-
章「離散 Whitney 系: トーラス上の閉歩道の回転数」の
「頂点単純閉路の位相因子はトーラスの巻き付き二次符号に等しい」
（`claim_vertex_simple_orbit_quadratic_sign`）の具体版。

`ζ_8` は `z ^ 4 = -1` を満たす `z : Qbar` で受ける（`claim_closed_walk_rotation_phase_sign` の具体版と同じ）。
切断線偶奇 `h(γ), v(γ) ∈ {0, 1}` は自然数で、巻き付き二次符号 `χ_{a,b}` の引数へは `decide (· = 1)` で渡す。
人手証明と同じ二場合に分ける。
- `(h, v) = (0, 0)`: `claim_vertex_simple_cycle_turning_by_seam_parity` の具体版から `t∘(γ) ∈ {4, -4}`、
  閉歩道の回転数 `rot(γ) = t∘(γ)/4 = ±1`（`def_closed_walk_rotation_number`）と `ζ_8^4 = -1` から
  `ζ_8^{t∘(γ)} = (-1)^{rot(γ)} = -1`。左辺は `-(-1)^0 (-1) = 1 = χ_{a,b}(0,0)`。
- `(h, v) ≠ (0, 0)`: 同じ主張から `t∘(γ) = 0`。指数 `q_{a,b}(h,v) = ah + bv + (h+v+hv) = ah + bv + 1`（二を法とする）
  により `-(-1)^{ah+bv} = (-1)^{q_{a,b}(h,v)} = χ_{a,b}(h,v)`。
住処は ℤ と二を法とした剰余、および `Qbar` の整数冪だけである。
-/
import Ising2DLambda.KacWard.VertexSimpleCycleTurningBySeamParity
import Ising2DLambda.KacWard.ClosedWalkRotationNumber
import Ising2DLambda.KacWard.TorusQuadraticSign

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 二未満の自然数 `n` は、`n = 1` の真偽値を自然数へ戻したものに等しい。 -/
theorem natLtTwo_eq_decide_toNat (n : ℕ) (hn : n < 2) : n = (decide (n = 1)).toNat := by
  interval_cases n <;> rfl

/-- `def_torus_quadratic_sign` の指数の分配:
`hv + (1-a)h + (1-b)v = ah + bv + (h+v+hv)`（二を法とする）。 -/
theorem torusQuadraticParity_eq_linear_add (a b h v : Bool) :
    torusQuadraticParity a b h v =
      Bool.xor (Bool.xor (a && h) (b && v)) (Bool.xor (Bool.xor h v) (h && v)) := by
  cases a <;> cases b <;> cases h <;> cases v <;> rfl

/-- 切断線偶奇が零でない三場合 `(1,0)`・`(0,1)`・`(1,1)` では `h + v + hv = 1`（二を法とする）。 -/
theorem seamParity_sum_eq_one_of_ne_zero (h v : Bool) (hne : (h, v) ≠ (false, false)) :
    Bool.xor (Bool.xor h v) (h && v) = true := by
  cases h <;> cases v <;> simp_all

/-- 自然数へ戻して共に零になる真偽値の対は `(false, false)` である。 -/
theorem boolPair_eq_false_of_toNat_eq_zero (hb vb : Bool)
    (h1 : hb.toNat = 0) (h2 : vb.toNat = 0) : (hb, vb) = (false, false) := by
  cases hb <;> cases vb <;> simp_all

/-- `claim_vertex_simple_orbit_quadratic_sign` の具体版。 -/
theorem vertexSimpleOrbit_quadraticSign {L m : ℕ} [NeZero L]
    (s : SpinStructure) {z : Qbar} (hz4 : z ^ 4 = -1)
    (γ : Fin (m + 1) → OrientedEdge L)
    (hγ : closedNonbacktrackingWalk γ)
    (hcontact : contactPairCount γ hγ = 0) :
    -((-1 : Qbar) ^ (s.1.toNat * (edgeSequenceSeamParities (List.ofFn γ)).1 +
          s.2.toNat * (edgeSequenceSeamParities (List.ofFn γ)).2)) *
        z ^ cyclicTotalTurning γ hγ =
      ((torusQuadraticSign s.1 s.2
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).1 = 1))
          (decide ((edgeSequenceSeamParities (List.ofFn γ)).2 = 1)) : ℤ) : Qbar) := by
  -- 切断線偶奇と回転数の関係（claim_vertex_simple_cycle_turning_by_seam_parity）
  have hturn := vertexSimpleCycle_cyclicTotalTurning_by_seamParity γ hγ hcontact
  set p := edgeSequenceSeamParities (List.ofFn γ) with hp
  have hlt1 : p.1 < 2 := by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)
  have hlt2 : p.2 < 2 := by rw [hp, edgeSequenceSeamParities]; exact Nat.mod_lt _ (by norm_num)
  set hb := decide (p.1 = 1) with hhb
  set vb := decide (p.2 = 1) with hvb
  have hpb : p = (hb.toNat, vb.toNat) :=
    Prod.ext (natLtTwo_eq_decide_toNat _ hlt1) (natLtTwo_eq_decide_toNat _ hlt2)
  rw [hpb]
  rcases s with ⟨a, b⟩
  by_cases h0 : (hb, vb) = (false, false)
  · -- (h, v) = (0, 0)
    obtain ⟨hh, hv⟩ := Prod.mk.inj h0
    have hp0 : p = (0, 0) := by rw [hpb, hh, hv]; rfl
    have ht := hturn.1 hp0
    -- ζ_8^{t∘(γ)} = ζ_8^{4 rot(γ)} = (ζ_8^4)^{rot(γ)} = (-1)^{rot(γ)} = -1
    have hfour : (4 : ℤ) ∣ cyclicTotalTurning γ hγ := by
      rcases ht with ht | ht <;> rw [ht] <;> norm_num
    have hrot := four_mul_closedWalkRotationNumber γ hγ hfour
    have hrot1 : closedWalkRotationNumber γ hγ = 1 ∨ closedWalkRotationNumber γ hγ = -1 := by
      rcases ht with ht | ht <;> [left; right] <;> omega
    have hzt : z ^ cyclicTotalTurning γ hγ = -1 := by
      calc z ^ cyclicTotalTurning γ hγ
          = z ^ ((4 : ℤ) * closedWalkRotationNumber γ hγ) := by rw [hrot]
        _ = (z ^ (4 : ℤ)) ^ closedWalkRotationNumber γ hγ := zpow_mul z 4 _
        _ = (-1 : Qbar) ^ closedWalkRotationNumber γ hγ := by
            rw [show z ^ (4 : ℤ) = -1 by exact_mod_cast hz4]
        _ = -1 := by rcases hrot1 with h1 | h1 <;> rw [h1] <;> norm_num
    rw [hzt, hh, hv]
    cases a <;> cases b <;> norm_num [torusQuadraticSign, torusQuadraticParity]
  · -- (h, v) ≠ (0, 0)
    have hpne : p ≠ (0, 0) := by
      intro hp0
      apply h0
      rw [hpb] at hp0
      obtain ⟨h1, h2⟩ := Prod.mk.inj hp0
      exact boolPair_eq_false_of_toNat_eq_zero _ _ h1 h2
    -- t∘(γ) = 0
    rw [hturn.2 hpne, zpow_zero, mul_one]
    -- q_{a,b}(h,v) = ah + bv + (h+v+hv) = ah + bv + 1
    simp only [torusQuadraticSign]
    rw [torusQuadraticParity_eq_linear_add, seamParity_sum_eq_one_of_ne_zero hb vb h0]
    revert h0
    cases a <;> cases b <;> cases hb <;> cases vb <;> norm_num

end Ising2DLambda.KacWard
