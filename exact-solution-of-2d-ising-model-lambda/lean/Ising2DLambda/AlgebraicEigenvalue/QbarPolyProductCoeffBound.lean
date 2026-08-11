/-
「係数上界つき多項式の積の係数は、上界の和より上の番号で零である」の具体版。
人手証明との対応:
- 第 1 段（積の係数）= `Polynomial.coeff_mul`（番号の組 (i, k - i) にわたる有限和）。
- 第 2〜5 段（有限和を番号 p で分け、前半は Q の係数の仮定、後半は P の係数の仮定で
  各項を零にし、零元の有限和で閉じる）= `Finset.sum_eq_zero` と、各組についての
  「i > p か否か」の場合分け。本文が和を 2 つに分けて前半・後半で別の仮定を当てるのと
  同じ場合分けを、項ごとに行っている。i ≤ p の場合に k - i > q を出す算術も本文と同じ。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- `Qbar[t]` では、係数が番号 `p` で尽きる多項式と番号 `q` で尽きる多項式の積の係数は、
番号 `p + q` で尽きる。 -/
theorem qbarPolyProductCoeffBound (P Q : QbarPoly) (p q : ℕ)
    (hP : ∀ k, p < k → P.coeff k = 0) (hQ : ∀ k, q < k → Q.coeff k = 0) :
    ∀ k, p + q < k → (P * Q).coeff k = 0 := by
  intro k hk
  -- 第 1 段: 積の係数は番号の組にわたる有限和である
  rw [Polynomial.coeff_mul]
  -- 第 2〜5 段: 各項が零であることを、i > p か否かの場合分けで示す
  apply Finset.sum_eq_zero
  intro x hx
  have hxk : x.1 + x.2 = k := by simpa using hx
  by_cases hi : p < x.1
  · -- 後半（i > p）: P の係数の仮定と零元との積
    rw [hP x.1 hi, zero_mul]
  · -- 前半（i ≤ p）: k - i ≥ k - p > q なので Q の係数の仮定と零元との積
    have hj : q < x.2 := by omega
    rw [hQ x.2 hj, mul_zero]

end Ising2DLambda.AlgebraicEigenvalue
