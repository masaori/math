/- 可換環は分配・交差項の交換・減法の相殺に使う。
零因子が無いことは差と和の積からの分岐に、1+1≠0 は和の枝の排除に使う。
標数零全体・逆元・順序・代数閉性は使わない。 -/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolynomialZeroProduct

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 差と和の積を用いる、定数項一の多項式平方根の一意性。 -/
theorem polynomialSquareRoot_unique_necSuf {R : Type*} [CommRing R] [NoZeroDivisors R]
    (htwo_ne : (1 : R) + 1 ≠ 0) (S T : Polynomial R)
    (hS : S.coeff 0 = 1) (hT : T.coeff 0 = 1) (hsquare : S * S = T * T) :
    S = T := by
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
  have hsum : S + T ≠ 0 := by
    intro hzero
    have htwo : (0 : R) = 1 + 1 := by
      calc
        (0 : R) = (0 : Polynomial R).coeff 0 := (Polynomial.coeff_zero 0).symm
        _ = (S + T).coeff 0 := by rw [hzero]
        _ = S.coeff 0 + T.coeff 0 := Polynomial.coeff_add S T 0
        _ = 1 + 1 := by rw [hS, hT]
    exact htwo_ne htwo.symm
  rcases polynomial_zero_product_necSuf (S - T) (S + T) hproduct with hdiff | hzero
  · calc
      S = (S - T) + T := (sub_add_cancel S T).symm
      _ = 0 + T := by rw [hdiff]
      _ = T := zero_add T
  · exact False.elim (hsum hzero)

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
