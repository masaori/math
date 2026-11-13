/-
「頂点単純閉路の位相因子はトーラスの巻き付き二次符号に等しい」
（`claim_vertex_simple_orbit_quadratic_sign`）の必要十分版。

具体版と同じ二場合に分ける。切断線偶奇 `(h, v)` が零なら、回転数 `t` は `4` か `-4`（`hzero`）なので
`z ^ t = -1`（`z ^ 4 = -1` と整数指数の法則）であり、左辺は `-(1) * (-1) = 1 = χ(0,0)`。
零でないなら `t = 0`（`hnonzero`）で、指数の式鎖 `q = hv + (1-a)h + (1-b)v = ah + bv + (h+v+hv) = ah + bv + 1`
（二を法とする）により左辺 `-(-1)^(ah+bv)` は `χ(h,v)` に等しい。

係数の住処には除算環だけを仮定する。可換性は使わない（現れる元は全て `-1` と `z` の整数冪で、
互いに可換である必要がない計算の並びになっている）。除算環は削れない: `t = -4` の場合に
`z ^ (-4) = (z ^ 4)⁻¹` と逆元を取るので、`z` の逆元が要る。`-1` と符号の掛け算に環の演算が要る。
回転数 `t` と切断線偶奇の関係は、具体版が前の主張から得る二つの含意（`hzero`・`hnonzero`）だけを使う。
-/
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Algebra.Ring.Defs
import Mathlib.Algebra.Field.Basic
import Mathlib.Tactic.NormNum
import Mathlib.Algebra.GroupWithZero.Units.Basic
import Ising2DLambda.NecSuf.KacWard.ArfFourierSignProjection

namespace Ising2DLambda.NecSuf.KacWard

/-- 二次の指数の分配: `hv + (1-a)h + (1-b)v = ah + bv + (h+v+hv)`（二を法とする）。 -/
theorem quadraticParity_eq_linear_add_necSuf (a b h v : Bool) :
    quadraticParity a b h v =
      Bool.xor (Bool.xor (a && h) (b && v)) (Bool.xor (Bool.xor h v) (h && v)) := by
  cases a <;> cases b <;> cases h <;> cases v <;> rfl

/-- 切断線偶奇が零でない三場合 `(1,0)`・`(0,1)`・`(1,1)` では `h + v + hv = 1`（二を法とする）。 -/
theorem seam_sum_eq_one_of_ne_zero_necSuf (h v : Bool) (hne : (h, v) ≠ (false, false)) :
    Bool.xor (Bool.xor h v) (h && v) = true := by
  cases h <;> cases v <;> simp_all

theorem vertex_simple_orbit_quadratic_sign_necSuf {K : Type*} [DivisionRing K]
    (z : K) (hz4 : z ^ 4 = -1) (a b h v : Bool) (t : ℤ)
    (hzero : (h, v) = (false, false) → t = 4 ∨ t = -4)
    (hnonzero : (h, v) ≠ (false, false) → t = 0) :
    -((-1 : K) ^ (a.toNat * h.toNat + b.toNat * v.toNat)) * z ^ t =
      ((sign (quadraticParity a b h v) : ℤ) : K) := by
  by_cases h0 : (h, v) = (false, false)
  · -- 切断線偶奇が零の場合: z ^ t = -1
    have hzt : z ^ t = -1 := by
      rcases hzero h0 with ht | ht
      · rw [ht]
        exact_mod_cast hz4
      · rw [ht, zpow_neg]
        have : z ^ (4 : ℤ) = -1 := by exact_mod_cast hz4
        rw [this, inv_neg_one]
    obtain ⟨rfl, rfl⟩ := Prod.mk.inj h0
    rw [hzt]
    cases a <;> cases b <;> norm_num [sign, quadraticParity]
  · -- 切断線偶奇が零でない場合: t = 0、指数は ah + bv + 1
    rw [hnonzero h0, zpow_zero, mul_one, quadraticParity_eq_linear_add_necSuf,
      seam_sum_eq_one_of_ne_zero_necSuf h v h0]
    revert h0
    cases a <;> cases b <;> cases h <;> cases v <;> norm_num [sign]

end Ising2DLambda.NecSuf.KacWard
