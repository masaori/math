/- 「有理数の平方は二にならない」の論理的な手順だけを残した必要十分版。 -/
import Mathlib.Data.Int.Order.Basic

namespace Ising2DLambda.NecSuf.FisherZero

/-- 符号による三分、負数から正数への帰着、指数の二倍による矛盾だけを要求する。 -/
theorem no_rational_square_two_necSuf
    {A : Type} (square positive negative isZero : A → Prop) (neg : A → A)
    (exponent : A → ℤ)
    (hCases : ∀ q, negative q ∨ isZero q ∨ positive q)
    (hZeroContradiction : ∀ q, isZero q → ¬ square q)
    (hNegPositive : ∀ q, negative q → positive (neg q))
    (hNegSquare : ∀ q, negative q → square q → square (neg q))
    (hSquareExponent : ∀ r, positive r → square r → (1 : ℤ) = exponent r + exponent r)
    (hNoDouble : ∀ m : ℤ, (1 : ℤ) ≠ m + m) :
    ∀ q, ¬ square q := by
  intro q hSquare
  rcases hCases q with hNeg | hZero | hPos
  · exact hNoDouble (exponent (neg q))
      (hSquareExponent (neg q) (hNegPositive q hNeg) (hNegSquare q hNeg hSquare))
  · exact hZeroContradiction q hZero hSquare
  · exact hNoDouble (exponent q) (hSquareExponent q hPos hSquare)

end Ising2DLambda.NecSuf.FisherZero
