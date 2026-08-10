/-
主張「倍数を指数とする冪と単位元の逆元との和は、約数を指数とするそれと冪の有限和との積である」
の必要十分版。

具体版（`Ising2DLambda.AlgebraicEigenvalue.PowerSumTelescope`）の証明は、`k` についての
帰納法である。出発点は空集合にわたる有限和が零元であること、一歩は有限和から最大の項を
分けて帰納法の仮定を当て、分配則で括り直し、`1 + u = 0` で余る項を落とすものである。
証明手順は具体版と同じ（出発点 → 余る項を落とす → 指数法則 → 分配則 → 帰納法の仮定 →
分配則 → 項を戻す）。

  使っている性質                なぜ削れないか
  `Semiring R`                  有限和と積、分配則、単位元・零元に要る。
  `hu : 1 + u = 0`              一歩で余る項 `a^k + u * a^k` を落とす唯一の根拠。
                                これが無いと右辺に `(1 + u) * a^k` が残る。

削れたもの: `a` が `t^d` の形であること（`d` そのものが消える。具体版では
`(t^d)^k = t^{dk}` の指数法則で戻す）、値が多項式であること、積の可換性
（`u * a^k` の順序を変えていないので要らない）、加法の逆元の存在
（`u` は仮定で受け取るだけで、`-1` として作らない）、`d ≥ 1` と `k ≥ 1`
（出発点を `k = 0` に置けるので、退化した場合を除く必要が無い）。

住処: ここに ℝ / ℂ は現れない（値は一般の半環、指数は ℕ）。
-/
import Mathlib.Algebra.BigOperators.Ring.Finset
import Mathlib.Tactic.Abel

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Finset

/-- 一歩で余る項が零元であること。`1 + u = 0` だけを使う。 -/
theorem add_mul_self_eq_zero_of_one_add_eq_zero {R : Type*} [Semiring R] {u : R}
    (hu : (1 : R) + u = 0) (b : R) : b + u * b = 0 := by
  have h : (1 + u) * b = b + u * b := by rw [add_mul, one_mul]
  rw [← h, hu, zero_mul]

/-- 必要十分版の本体。`a ^ k + u = (a + u) * Σ_{j<k} a ^ j`。

`k` についての帰納法。具体版と同じ手順である。 -/
theorem pow_add_eq_mul_geom {R : Type*} [Semiring R] (a u : R) (hu : (1 : R) + u = 0) :
    ∀ k : ℕ, a ^ k + u = (a + u) * ∑ j ∈ Finset.range k, a ^ j := by
  intro k
  induction k with
  | zero =>
      -- 出発点。空集合にわたる有限和は零元であり、零元を掛けた積は零元である。
      rw [Finset.range_zero, Finset.sum_empty, mul_zero, pow_zero, hu]
  | succ k ih =>
      have hz : a ^ k + u * a ^ k = 0 := add_mul_self_eq_zero_of_one_add_eq_zero hu (a ^ k)
      calc a ^ (k + 1) + u
          = (a ^ k + u * a ^ k) + (a ^ (k + 1) + u) := by rw [hz, zero_add]
        _ = (a ^ k + u) + (a ^ (k + 1) + u * a ^ k) := by abel
        _ = (a ^ k + u) + (a * a ^ k + u * a ^ k) := by rw [pow_succ' a k]
        _ = (a ^ k + u) + (a + u) * a ^ k := by rw [add_mul]
        _ = (a + u) * (∑ j ∈ Finset.range k, a ^ j) + (a + u) * a ^ k := by rw [ih]
        _ = (a + u) * ((∑ j ∈ Finset.range k, a ^ j) + a ^ k) := by rw [mul_add]
        _ = (a + u) * ∑ j ∈ Finset.range (k + 1), a ^ j := by rw [Finset.sum_range_succ]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
