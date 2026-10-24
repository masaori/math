/- 定数項一の多項式平方根。一意性は差と和の積の零積性で示す。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialZeroProduct

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 定数項一で、平方が指定された多項式になること。存在は含めない。 -/
def qbarPolynomialSquareRoot (D S : QbarPoly) : Prop :=
  S.coeff 0 = 1 ∧ S * S = D

/-- 定数項一の多項式平方根は一意である。 -/
theorem qbarPolynomialSquareRoot_unique (S T : QbarPoly)
    (hS : S.coeff 0 = 1) (hT : T.coeff 0 = 1) (hsquare : S * S = T * T) :
    S = T := by
  -- 分配則、交差項の可換性、加法の相殺を順に使う。
  have hproduct : (S - T) * (S + T) = 0 := by
    calc
      (S - T) * (S + T) = S * (S + T) - T * (S + T) := sub_mul S T _
      _ = (S * S + S * T) - T * (S + T) := by rw [mul_add S S T]
      _ = (S * S + S * T) - (T * S + T * T) := by rw [mul_add T S T]
      _ = (S * S + S * T) - (S * T + T * T) := by rw [mul_comm T S]
      _ = ((S * S + S * T) - S * T) - T * T := sub_add_eq_sub_sub _ _ _
      _ = S * S - T * T := by rw [add_sub_cancel_right]
      _ = T * T - T * T := by rw [hsquare]
      _ = 0 := sub_self _
  -- 和の定数項は一足す一なので、和は零多項式でない。
  have hsum : S + T ≠ 0 := by
    intro hzero
    have htwo : (0 : Qbar) = 2 := by
      calc
        (0 : Qbar) = (0 : QbarPoly).coeff 0 := (Polynomial.coeff_zero 0).symm
        _ = (S + T).coeff 0 := by rw [hzero]
        _ = S.coeff 0 + T.coeff 0 := Polynomial.coeff_add S T 0
        _ = 1 + 1 := by rw [hS, hT]
        _ = 2 := one_add_one_eq_two
    exact two_ne_zero htwo.symm
  -- 本文の多項式零積性を適用し、和が零となる枝を排除する。
  rcases qbarPolynomial_zero_product (S - T) (S + T) hproduct with hdiff | hzero
  · calc
      S = (S - T) + T := (sub_add_cancel S T).symm
      _ = 0 + T := by rw [hdiff]
      _ = T := zero_add T
  · exact False.elim (hsum hzero)

end Ising2DLambda.AlgebraicEigenvalue
