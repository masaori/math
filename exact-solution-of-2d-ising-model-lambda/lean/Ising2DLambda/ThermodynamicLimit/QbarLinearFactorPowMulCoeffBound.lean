/-
章「熱力学極限」の「一次因子の冪との積の係数は、上界と指数の和より上の番号で零である」
（`claim_qbar_linear_factor_pow_mul_coeff_bound`）の具体版。

  人手証明                                                          このファイル
  j についての帰納法。出発点 j = 0: (t-ŵ)^0·C = 1·C = C            `pow_zero`, `one_mul`
  一歩: (t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C)（冪の約束・可換・結合）  `pow_succ`, `mul_comm`, `mul_assoc`
        claim_qbar_poly_linear_factor_coeff_bound を C' := (t-ŵ)^j·C、
        上界 m+j に当てる                                          `qbarPolyLinearFactorCoeffBound`

住処: Q̄（実数体・複素数体は現れない）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- 係数が番号 `m` で尽きる `C` に一次因子の `j` 乗を掛けると、係数は番号 `m + j` で尽きる。 -/
theorem qbarLinearFactorPowMulCoeffBound (w : Qbar) (C : QbarPoly) (m : ℕ)
    (hC : ∀ k, m < k → C.coeff k = 0) :
    ∀ j : ℕ, ∀ k, m + j < k → ((Polynomial.X - qbarConst w) ^ j * C).coeff k = 0 := by
  intro j
  induction j with
  | zero =>
    -- 出発点: (t-ŵ)^0·C = 1·C = C
    intro k hk
    rw [pow_zero, one_mul]
    exact hC k (by omega)
  | succ j ih =>
    intro k hk
    -- (t-ŵ)^{j+1}·C = (t-ŵ)·((t-ŵ)^j·C)
    have hstep : (Polynomial.X - qbarConst w) ^ (j + 1) * C =
        (Polynomial.X - qbarConst w) * ((Polynomial.X - qbarConst w) ^ j * C) := by
      rw [pow_succ, mul_comm ((Polynomial.X - qbarConst w) ^ j) (Polynomial.X - qbarConst w),
        mul_assoc]
    rw [hstep]
    -- 一次因子との積の係数の上界（上界 m+j の C' へ当てる）
    exact qbarPolyLinearFactorCoeffBound w ((Polynomial.X - qbarConst w) ^ j * C) (m + j) ih k
      (by omega)

end Ising2DLambda.ThermodynamicLimit
