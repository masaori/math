/-
「大きさによる切り詰めは値の衝突を持つ」を、必要十分版
（`Ising3DCut/NecSuf/MagnitudeTruncationCollision.lean`）の特殊化として導く。

具体版の定理を呼び直さず、必要十分版へ次を与えて特殊化する。

* 添字の型は素数の部分型、値の型は `ℤ`（`min` を取れるので `LinearOrder`）、
* 座標は素指数 `v_p`、頭打ちの高さは `N`、食い違う添字は素数 `2`、
* 二つの元は `2 ^ N` と `2 ^ (N + 1)`、付帯条件は正値性。

必要十分版が要求する四つの仮定に対応する素指数の計算だけをここで確かめる。
-/
import Ising3DCut.LimitQuantity.MagnitudeTruncationCollision
import Ising3DCut.NecSuf.MagnitudeTruncationCollision

namespace Ising3DCut.LimitQuantity

/-- 必要十分版から導いた「大きさによる切り詰めは値の衝突を持つ」。 -/
theorem magnitude_truncation_has_a_value_collision_fromNecSuf (N : ℕ) (hN : 1 ≤ N) :
    ∃ u w : ℚ, 0 < u ∧ 0 < w ∧ u ≠ w ∧
      magnitudeTruncation N u = magnitudeTruncation N w := by
  have hu : (0 : ℚ) < ((2 ^ N : ℕ) : ℚ) := by
    exact_mod_cast Nat.pow_pos (n := N) (by norm_num : 0 < 2)
  have hw : (0 : ℚ) < ((2 ^ (N + 1) : ℕ) : ℚ) := by
    exact_mod_cast Nat.pow_pos (n := N + 1) (by norm_num : 0 < 2)
  have hne : ((2 ^ N : ℕ) : ℚ) ≠ ((2 ^ (N + 1) : ℕ) : ℚ) := by
    have hlt : (2 : ℕ) ^ N < 2 ^ (N + 1) :=
      Nat.pow_lt_pow_right (by norm_num) (Nat.lt_succ_self N)
    intro h
    have : (2 : ℕ) ^ N = 2 ^ (N + 1) := by exact_mod_cast h
    omega
  -- 食い違う添字は素数 `2`。
  have hd : Nat.Prime 2 := Nat.prime_two
  -- 必要十分版の仮定「その添字での二つの座標がいずれも頭打ちの高さ以上」。
  have hcapu : (N : ℤ) ≤ padicValRat ((⟨2, hd⟩ : {p : ℕ // Nat.Prime p}) : ℕ) ((2 ^ N : ℕ) : ℚ) := by
    rw [show (((⟨2, hd⟩ : {p : ℕ // Nat.Prime p}) : ℕ)) = 2 from rfl, padicValRat_two_pow N]
  have hcapw : (N : ℤ)
      ≤ padicValRat ((⟨2, hd⟩ : {p : ℕ // Nat.Prime p}) : ℕ) ((2 ^ (N + 1) : ℕ) : ℚ) := by
    rw [show (((⟨2, hd⟩ : {p : ℕ // Nat.Prime p}) : ℕ)) = 2 from rfl, padicValRat_two_pow (N + 1)]
    omega
  -- 必要十分版の仮定「残りの添字では二つの座標が一致する」。
  have hagree : ∀ p : {p : ℕ // Nat.Prime p}, p ≠ ⟨2, hd⟩ →
      padicValRat (p : ℕ) ((2 ^ N : ℕ) : ℚ) = padicValRat (p : ℕ) ((2 ^ (N + 1) : ℕ) : ℚ) := by
    intro p hp
    have hp2 : (p : ℕ) ≠ 2 := fun h => hp (Subtype.ext h)
    rw [padicValRat_ne_two_pow (p : ℕ) N p.2 hp2,
      padicValRat_ne_two_pow (p : ℕ) (N + 1) p.2 hp2]
  exact Ising3DCut.NecSuf.magnitude_truncation_has_a_value_collision
    (fun p : {p : ℕ // Nat.Prime p} => fun a : ℚ => padicValRat (p : ℕ) a)
    (fun a : ℚ => 0 < a) (N : ℤ) ⟨2, hd⟩ _ _ hu hw hne hcapu hcapw hagree

end Ising3DCut.LimitQuantity
