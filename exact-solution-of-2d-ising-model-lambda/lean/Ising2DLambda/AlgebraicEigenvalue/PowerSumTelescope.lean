/-
章「固有値の代数性」の「倍数を指数とする冪と単位元の逆元との和は、約数を指数とするそれと
冪の有限和との積である」の具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_power_sum_telescope`）に対応する。

  人手証明                                                   このファイル
  準備の第一（ι(κ(1)) が単位元・ι(κ(0)) が零元）              constSecond_constPoly_one / _zero（既出）
  準備の第二（ι(κ(1)) + u = ι(κ(0))）                        one_add_negUnitSecond
  帰納法の出発点（k = 0）                                    powerSumTelescope（zero の場合）
  帰納法の一歩の 11 段                                       powerSumTelescope（succ の場合の calc）
  主張そのもの                                               powerSumTelescope

人手証明の `u := ι(-κ(1))` は `negUnitSecond` である。既出の `constSecond_neg_one` で
`-1` に等しいことは分かるが、人手証明が引き算を使わない形で書いているので、この具体版でも
`u` を `constSecond (-(constPoly 1))` のまま扱い、使う性質は `1 + u = 0` だけに絞る。

人手証明の `Σ_{j<k} t^{dj}` は `∑ j ∈ Finset.range k, X ^ (d * j)` である。

mathlib の幾何級数の既製定理（`geom_sum_mul`・`Commute.geom_sum₂_mul` 等）は引いていない。
引くと「有限和から項を分けて分配則で括り直す」という人手証明の各段が消える。
使ったのは有限和の基本則（`Finset.sum_empty`・`Finset.sum_range_succ`）と、
`ℤ[x][t]` の分配則・指数法則だけである。

住処: 人手証明のこのブロックは ℤ を宣言している。
ここに ℝ / ℂ は現れない（値は `Polynomial (Polynomial ℤ)`、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.SecondPolynomial
import Mathlib.Tactic.Abel

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

/-- 人手証明の `u := ι(-κ(1))`。 -/
noncomputable def negUnitSecond : SecondPoly := constSecond (-(constPoly 1))

theorem negUnitSecond_def : negUnitSecond = constSecond (-(constPoly 1)) := rfl

/-- 人手証明の準備の第二。`ι(κ(1)) + u = ι(κ(0))`、すなわち `1 + u = 0`。

`ι` が和を和へ写すこと（`map_add`）と `κ(1) + (-κ(1)) = κ(0)` による。 -/
theorem one_add_negUnitSecond : (1 : SecondPoly) + negUnitSecond = 0 := by
  calc (1 : SecondPoly) + negUnitSecond
      = constSecond (constPoly 1) + constSecond (-(constPoly 1)) := by
        rw [negUnitSecond_def, constSecond_constPoly_one]
    _ = constSecond (constPoly 1 + -(constPoly 1)) := (map_add _ _ _).symm
    _ = constSecond (constPoly 0) := by rw [add_neg_cancel, constPoly_zero]
    _ = 0 := constSecond_constPoly_zero

/-- 一歩で余る項が零元であること（人手証明の第 7〜10 段に当たる）。 -/
theorem add_negUnitSecond_mul_eq_zero (b : SecondPoly) : b + negUnitSecond * b = 0 := by
  have h : ((1 : SecondPoly) + negUnitSecond) * b = b + negUnitSecond * b := by
    rw [add_mul, one_mul]
  rw [← h, one_add_negUnitSecond, zero_mul]

/-- 人手証明の主張。`t^{dk} + u = (t^d + u) · Σ_{j<k} t^{dj}`。

`d` を固定して `k` についての帰納法。出発点は `k = 0`（空集合にわたる有限和が零元で、
両辺がともに零元）、一歩は余る項 `t^{dk} + u · t^{dk}` を落として指数法則と分配則で
括り直し、帰納法の仮定を当てて有限和へ戻すものである。 -/
theorem powerSumTelescope (d : ℕ) : ∀ k : ℕ,
    (Polynomial.X : SecondPoly) ^ (d * k) + negUnitSecond
      = ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
        * ∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (d * j) := by
  intro k
  induction k with
  | zero =>
      -- 出発点。d * 0 = 0、t^0 = 1、空集合にわたる和は零元。
      rw [Finset.range_zero, Finset.sum_empty, Nat.mul_zero, pow_zero, mul_zero,
        one_add_negUnitSecond]
  | succ k ih =>
      have hz : (Polynomial.X : SecondPoly) ^ (d * k)
          + negUnitSecond * (Polynomial.X : SecondPoly) ^ (d * k) = 0 :=
        add_negUnitSecond_mul_eq_zero _
      have hexp : d + d * k = d * (k + 1) := by ring
      calc (Polynomial.X : SecondPoly) ^ (d * (k + 1)) + negUnitSecond
          = ((Polynomial.X : SecondPoly) ^ (d * k)
              + negUnitSecond * (Polynomial.X : SecondPoly) ^ (d * k))
            + ((Polynomial.X : SecondPoly) ^ (d * (k + 1)) + negUnitSecond) := by
              rw [hz, zero_add]
        _ = ((Polynomial.X : SecondPoly) ^ (d * k) + negUnitSecond)
            + ((Polynomial.X : SecondPoly) ^ (d * (k + 1))
              + negUnitSecond * (Polynomial.X : SecondPoly) ^ (d * k)) := by abel
        _ = ((Polynomial.X : SecondPoly) ^ (d * k) + negUnitSecond)
            + ((Polynomial.X : SecondPoly) ^ d * (Polynomial.X : SecondPoly) ^ (d * k)
              + negUnitSecond * (Polynomial.X : SecondPoly) ^ (d * k)) := by
              rw [← pow_add, hexp]
        _ = ((Polynomial.X : SecondPoly) ^ (d * k) + negUnitSecond)
            + ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
              * (Polynomial.X : SecondPoly) ^ (d * k) := by rw [add_mul]
        _ = ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
              * (∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (d * j))
            + ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
              * (Polynomial.X : SecondPoly) ^ (d * k) := by rw [ih]
        _ = ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
              * ((∑ j ∈ Finset.range k, (Polynomial.X : SecondPoly) ^ (d * j))
                + (Polynomial.X : SecondPoly) ^ (d * k)) := by rw [mul_add]
        _ = ((Polynomial.X : SecondPoly) ^ d + negUnitSecond)
              * ∑ j ∈ Finset.range (k + 1), (Polynomial.X : SecondPoly) ^ (d * j) := by
              rw [Finset.sum_range_succ]

end Ising2DLambda.AlgebraicEigenvalue
