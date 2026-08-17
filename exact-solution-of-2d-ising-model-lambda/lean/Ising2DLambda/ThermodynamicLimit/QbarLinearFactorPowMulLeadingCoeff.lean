/-
章「熱力学極限」の「一次因子の冪との積の先頭の係数は、もとの先頭の係数である」
（`claim_qbar_linear_factor_pow_mul_leading_coeff`）の具体版。

  人手証明                                                          このファイル
  j についての帰納法。出発点 j = 0:
    ac_{m+0}((t-ŵ)^0·C) = ac_{m+0}(1·C) = ac_{m+0}(C) = ac_m(C)     `pow_zero`, `one_mul`, `Nat.add_zero`
  一歩: (t-ŵ)^j·C は上界 m+j を持つ                                  `qbarLinearFactorPowMulCoeffBound`
        (t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C)（冪の約束・可換・結合）  `pow_succ`, `mul_comm`, `mul_assoc`
        ac_{m+(j+1)} = ac_{(m+j)+1}（ℕ の加法の結合則）             `Nat.add_assoc`
        claim_qbar_poly_linear_factor_leading_coeff を
        C' := (t-ŵ)^j·C、上界 m+j に当てる                          `qbarPolyLinearFactorLeadingCoeff`
        帰納法の仮定                                                 `ih`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorLeadingCoeff
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowMulCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- 係数が番号 `m` で尽きる `C` に一次因子の `j` 乗を掛けると、番号 `m + j` の係数は
`C` の番号 `m` の係数に等しい。 -/
theorem qbarLinearFactorPowMulLeadingCoeff (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ((Polynomial.X - qbarConst w) ^ j * C).coeff (m + j) = C.coeff m := by
  intro j
  induction j with
  | zero =>
    -- 出発点: ac_{m+0}((t-ŵ)^0·C) = ac_{m+0}(1·C) = ac_{m+0}(C) = ac_m(C)
    calc ((Polynomial.X - qbarConst w) ^ 0 * C).coeff (m + 0)
        = (1 * C).coeff (m + 0) := by rw [pow_zero]
      _ = C.coeff (m + 0) := by rw [one_mul]
      _ = C.coeff m := by rw [Nat.add_zero]
  | succ j ih =>
    -- (t-ŵ)^j·C は上界 m+j を持つ
    have hbound : ∀ k, m + j < k → ((Polynomial.X - qbarConst w) ^ j * C).coeff k = 0 :=
      qbarLinearFactorPowMulCoeffBound w C m hC j
    -- (t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C)
    have hstep : (Polynomial.X - qbarConst w) ^ (j + 1) * C =
        (Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ j * C) := by
      rw [pow_succ, mul_comm ((Polynomial.X - qbarConst w) ^ j) (Polynomial.X - qbarConst w),
        mul_assoc]
    calc ((Polynomial.X - qbarConst w) ^ (j + 1) * C).coeff (m + (j + 1))
        = ((Polynomial.X - qbarConst w) ^ (j + 1) * C).coeff ((m + j) + 1) := by
          rw [Nat.add_assoc]
      _ = ((Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ j * C)).coeff
            ((m + j) + 1) := by rw [hstep]
      _ = ((Polynomial.X - qbarConst w) ^ j * C).coeff (m + j) :=
          qbarPolyLinearFactorLeadingCoeff w ((Polynomial.X - qbarConst w) ^ j * C) (m + j) hbound
      _ = C.coeff m := ih

end Ising2DLambda.ThermodynamicLimit
