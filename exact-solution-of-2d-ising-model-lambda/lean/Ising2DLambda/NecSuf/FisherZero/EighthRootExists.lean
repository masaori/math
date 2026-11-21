/-
`claim_eighth_root_exists` の必要十分版。具体版と同じ手順
（二の平方根と虚数単位を取る、`s ≠ 0` から `s` の右逆元を取る、`ζ := (1 + ω) · t` の平方が `ω`、
`ζ⁴ = (ζ · ζ) · (ζ · ζ) = ω · ω = -1`）を、可換環 `K` の上で述べる。

仮定はこの手順が実際に使うものだけである。
- `hsqrt`: 平方が `2` の元。`ζ · ζ` の計算で `2` を `s · s` に戻すのに使う。
- `himag`: 平方が `-1` の元。`ζ · ζ` の展開の `ω · ω` と、最後の `ω · ω = -1` に使う。
- `htwo`: `2 ≠ 0`。`s ≠ 0` を導くのに使う（`s = 0` なら `2 = s · s = 0`）。
- `hinv`: 零でない元の右逆元。`s` の右逆元 `t` を取るのに使う。体であることの全体は使わない。
- 可換性: `((1 + ω) · t) · ((1 + ω) · t)` を `((1 + ω) · (1 + ω)) · (t · t)` に並べ替えるのに使う。
代数閉性・`ℚ` の部分体であること・多項式は使わない（存在は `hsqrt`・`himag` が与える）。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem eighthRoot_exists_necSuf {K : Type*} [CommRing K]
    (hsqrt : ∃ s : K, s * s = 2) (himag : ∃ omega : K, omega * omega = -1)
    (htwo : (2 : K) ≠ 0) (hinv : ∀ a : K, a ≠ 0 → ∃ b : K, a * b = 1) :
    ∃ zeta : K, zeta ^ 4 = -1 := by
  obtain ⟨s, hs⟩ := hsqrt
  obtain ⟨omega, homega⟩ := himag
  have hsNe : s ≠ 0 := by
    intro hs0
    apply htwo
    calc (2 : K) = s * s := hs.symm
      _ = 0 * 0 := by rw [hs0]
      _ = 0 := mul_zero 0
  obtain ⟨t, ht⟩ := hinv s hsNe
  have hSq : ((1 + omega) * t) * ((1 + omega) * t) = omega := by
    calc ((1 + omega) * t) * ((1 + omega) * t)
        = ((1 + omega) * (1 + omega)) * (t * t) := by rw [mul_mul_mul_comm]
      _ = (1 * 1 + 1 * omega + (omega * 1 + omega * omega)) * (t * t) := by
          rw [add_mul, mul_add, mul_add, add_assoc]
      _ = (1 + omega + (omega + omega * omega)) * (t * t) := by
          rw [one_mul, one_mul, mul_one]
      _ = (1 + omega + (omega + -1)) * (t * t) := by rw [homega]
      _ = (omega + omega + (1 + -1)) * (t * t) := by abel_nf
      _ = (omega + omega) * (t * t) := by rw [add_neg_cancel, add_zero]
      _ = (omega * (1 + 1)) * (t * t) := by rw [mul_add, mul_one]
      _ = (omega * 2) * (t * t) := by rw [one_add_one_eq_two]
      _ = (omega * (s * s)) * (t * t) := by rw [hs]
      _ = omega * ((s * t) * (s * t)) := by rw [mul_assoc, mul_mul_mul_comm]
      _ = omega * (1 * 1) := by rw [ht]
      _ = omega := by rw [one_mul, mul_one]
  refine ⟨(1 + omega) * t, ?_⟩
  calc ((1 + omega) * t) ^ 4
      = ((1 + omega) * t) ^ 3 * ((1 + omega) * t) := pow_succ _ 3
    _ = (((1 + omega) * t) ^ 2 * ((1 + omega) * t)) * ((1 + omega) * t) := by
        rw [pow_succ _ 2]
    _ = ((((1 + omega) * t) ^ 1 * ((1 + omega) * t)) * ((1 + omega) * t)) * ((1 + omega) * t) := by
        rw [pow_succ _ 1]
    _ = ((((1 + omega) * t) * ((1 + omega) * t)) * ((1 + omega) * t)) * ((1 + omega) * t) := by
        rw [pow_one]
    _ = (((1 + omega) * t) * ((1 + omega) * t)) * (((1 + omega) * t) * ((1 + omega) * t)) := by
        rw [mul_assoc]
    _ = omega * omega := by rw [hSq]
    _ = -1 := homega

end Ising2DLambda.NecSuf.FisherZero
