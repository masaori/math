/-
「係数上界つき多項式の積の係数は、上界の和より上の番号で零である」の必要十分版。

手順は具体版と同じ（積の係数の有限和・項ごとの場合分け・2 つの係数の仮定）。
係数に要るのは**半環**だけである。加法の逆元（引き算）は一度も使わない——
一次因子との積の係数上界の必要十分版が可換環を要した（一次式 X - C w の中に引き算がある）
のと違い、こちらは一次式を作らないので半環まで下がる。積の可換性も体も代数閉性も不要。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 半環上でも、係数が番号 `p` で尽きる多項式と番号 `q` で尽きる多項式の積の係数は、
番号 `p + q` で尽きる。 -/
theorem poly_product_coeff_bound_necSuf {R : Type*} [Semiring R]
    (P Q : R[X]) (p q : ℕ)
    (hP : ∀ k, p < k → P.coeff k = 0) (hQ : ∀ k, q < k → Q.coeff k = 0) :
    ∀ k, p + q < k → (P * Q).coeff k = 0 := by
  intro k hk
  rw [Polynomial.coeff_mul]
  apply Finset.sum_eq_zero
  intro x hx
  have hxk : x.1 + x.2 = k := by simpa using hx
  by_cases hi : p < x.1
  · rw [hP x.1 hi, zero_mul]
  · have hj : q < x.2 := by omega
    rw [hQ x.2 hj, mul_zero]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
