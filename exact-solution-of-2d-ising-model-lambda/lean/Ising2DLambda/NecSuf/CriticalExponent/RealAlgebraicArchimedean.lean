/-
`claim_real_algebraic_archimedean`（実閉部分体の順序は Archimedes 性を持つ）の必要十分版。

具体版と同じ手順（B = h/k ≤ h < N := h + 1、0 < N − B、B < N、−N < −B、推移律）を、
標数零の可除環 K と「正」の述語 P だけで書く。順序は「u < v は P (v − u)」として読む。
具体版が使う P の性質は次の二つだけである。
  - posAdd: 正の元の和は正。推移律 (w − u) = (w − v) + (v − u) の段に要る。
  - ratPos: 正の有理数の像は正。0 < N − B を K へ移す段に要る。
有理上下界は前の主張（`claim_real_algebraic_rational_bounds`）の結論として、
この元 a についての仮定 `hlower`・`hupper` で受ける。
積・可換性・正の元の非零・三分法・平方であることは使わない。K に標数零を置くのは、
有理数の差の像を像の差へ書き換える（`Rat.cast_sub`）ためである。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Algebra.Order.Field.Rat
import Mathlib.Data.Rat.Cast.CharZero
import Mathlib.Tactic.Abel
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum

namespace Ising2DLambda.NecSuf.CriticalExponent

section

variable {K : Type*} [DivisionRing K] {P : K → Prop}

/-- 推移律: `P (v − u)` と `P (w − v)` から `P (w − u)`。 -/
theorem sub_pos_trans_necSuf
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    {u v w : K} (huv : P (v - u)) (hvw : P (w - v)) : P (w - u) := by
  have h : w - u = (w - v) + (v - u) := by abel
  rw [h]
  exact posAdd _ _ hvw huv

/-- 有理数の順序: `B = h/k`（`h, k ∈ N_{>0}`）なら `B ≤ h < h + 1`。 -/
theorem rational_lt_succ_numerator_necSuf {B : ℚ} (hB : 0 < B) :
    B < ((B.num.natAbs + 1 : ℕ) : ℚ) := by
  have hnum : 0 < B.num := Rat.num_pos.mpr hB
  have hh : ((B.num.natAbs : ℕ) : ℚ) = (B.num : ℚ) := by
    rw [Nat.cast_natAbs, Int.cast_abs, abs_of_pos (by exact_mod_cast hnum)]
  have hk : (1 : ℚ) ≤ (B.den : ℚ) := by exact_mod_cast B.den_pos
  calc B = (B.num : ℚ) / (B.den : ℚ) := (Rat.num_div_den B).symm
    _ ≤ (B.num : ℚ) := div_le_self (by exact_mod_cast hnum.le) hk
    _ = ((B.num.natAbs : ℕ) : ℚ) := hh.symm
    _ < ((B.num.natAbs + 1 : ℕ) : ℚ) := by push_cast; linarith

/-- 必要十分版の主定理: `a − (−N)` と `N − a` がともに正となる `N ∈ N_{>0}` がある。 -/
theorem archimedean_necSuf [CharZero K]
    (posAdd : ∀ u v : K, P u → P v → P (u + v))
    (ratPos : ∀ q : ℚ, 0 < q → P (q : K))
    (a : K) {B : ℚ} (hB : 0 < B)
    (hlower : P (a - ((-B : ℚ) : K))) (hupper : P ((B : K) - a)) :
    ∃ N : ℕ, 0 < N ∧ P (a - ((-(N : ℚ) : ℚ) : K)) ∧ P (((N : ℚ) : K) - a) := by
  have hBN := rational_lt_succ_numerator_necSuf hB
  set N : ℕ := B.num.natAbs + 1 with hNdef
  -- 0 < N − B。
  have hpos : P (((N : ℚ) : K) - (B : K)) := by
    have h : ((N : ℚ) : K) - (B : K) = (((N : ℚ) - B : ℚ) : K) := by
      push_cast
      rfl
    rw [h]
    exact ratPos _ (sub_pos.mpr hBN)
  -- −N < −B: (−B) − (−N) = N − B。
  have hnegN : P (((-B : ℚ) : K) - ((-(N : ℚ) : ℚ) : K)) := by
    have h : ((-B : ℚ) : K) - ((-(N : ℚ) : ℚ) : K) = ((N : ℚ) : K) - (B : K) := by
      push_cast
      abel
    rw [h]
    exact hpos
  refine ⟨N, Nat.succ_pos _, ?_, ?_⟩
  · exact sub_pos_trans_necSuf posAdd hnegN hlower
  · exact sub_pos_trans_necSuf posAdd hupper hpos

end

end Ising2DLambda.NecSuf.CriticalExponent
