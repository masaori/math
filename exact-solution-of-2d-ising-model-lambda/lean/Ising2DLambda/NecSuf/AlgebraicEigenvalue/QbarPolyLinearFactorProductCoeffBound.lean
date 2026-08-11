/-
「一次因子の積の係数は、因子の個数より上の番号で零である」の必要十分版。

手順は具体版と同じ（空積を出発点とする帰納法、最後の因子の交換、
一次因子との積の係数上界）。係数環に要るのは可換環である。
加法の逆元は一次因子 `X - C (w m)` を作るために要り、交換則は最後の因子を
先頭へ移すために要る。体・代数閉性は要らない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

/-- 可換環上でも、`m` 個の一次因子の積の係数は番号 `m` で尽きる。 -/
theorem poly_linear_factor_product_coeff_bound_necSuf {R : Type*} [CommRing R]
    (w : ℕ → R) :
    ∀ m k : ℕ, m < k →
      (∏ i ∈ Finset.range m, (X - Polynomial.C (w i))).coeff k = 0 := by
  intro m
  induction m with
  | zero =>
      intro k hk
      simp [Polynomial.coeff_one, Nat.ne_of_gt hk]
  | succ m ih =>
      intro k hk
      rw [Finset.prod_range_succ, mul_comm]
      exact poly_linear_factor_coeff_bound_necSuf (w m)
        (∏ i ∈ Finset.range m, (X - Polynomial.C (w i))) m ih k (by omega)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
