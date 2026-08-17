/-
章「熱力学極限」の「持ち上げの値は整係数多項式の代数的数における値に一致する」
（`claim_integer_polynomial_qbar_lift_evaluation`）の具体版。

  人手証明                                                          このファイル
  準備: n < k なら ac_k(f̂^F) = 0                                    `integerPolynomialQbarLift_coeff_eq_zero_of_natDegree_lt`
  第 1 の等号（`claim_qbar_evaluation_coefficient_sum`）             `qbarPolyEvalCoefficientSum`
  第 2 の等号（ac_k(f̂^F) = a_k を各項へ同時に）                     `integerPolynomialQbarLift_coeff`（`Finset.sum_congr`）
  第 3 の等号（`def_qbar_polynomial_evaluation` の定義式）           `Polynomial.eval₂_eq_sum_range`（定義の展開）

人手証明の n は f の表示 Σ_{m=0}^{n} a_m x^m の上端であり、Lean では `f.natDegree` を取る
（`Polynomial ℤ` の係数は次数より上で 0 なので、これは表示の一つである）。
住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.IntegerPolynomialQbarLift
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalCoefficientSum
import Ising2DLambda.FisherZero.Algebraicity

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero

/-- 人手証明の準備: `n < k` なら `ac_k(f̂^F) = 0`（`def_integer_polynomial_qbar_lift` の下の場合）。 -/
theorem integerPolynomialQbarLift_coeff_eq_zero_of_natDegree_lt (f : Polynomial ℤ) (k : ℕ)
    (hk : f.natDegree < k) : (integerPolynomialQbarLift f).coeff k = 0 := by
  rw [integerPolynomialQbarLift_coeff, Polynomial.coeff_eq_zero_of_natDegree_lt hk, Int.cast_zero]

/-- 人手証明の本体（一続き三段）: `aev_ξ(f̂^F) = Ev^F_ξ(f)`。 -/
theorem qbarPolyEval_integerPolynomialQbarLift (xi : Qbar) (f : Polynomial ℤ) :
    qbarPolyEval xi (integerPolynomialQbarLift f) = qbarPolynomialEval xi f := by
  calc qbarPolyEval xi (integerPolynomialQbarLift f)
      -- 第 1 の等号（`claim_qbar_evaluation_coefficient_sum`）。
      = ∑ k ∈ Finset.range (f.natDegree + 1),
          (integerPolynomialQbarLift f).coeff k * xi ^ k :=
        qbarPolyEvalCoefficientSum xi (integerPolynomialQbarLift f) f.natDegree
          (fun k hk => integerPolynomialQbarLift_coeff_eq_zero_of_natDegree_lt f k hk)
    -- 第 2 の等号（`ac_k(f̂^F) = a_k` を各項へ同時に当てる）。
    _ = ∑ k ∈ Finset.range (f.natDegree + 1), ((f.coeff k : ℤ) : Qbar) * xi ^ k :=
        Finset.sum_congr rfl (fun k _ => by rw [integerPolynomialQbarLift_coeff])
    -- 第 3 の等号（`def_qbar_polynomial_evaluation` の定義式）。
    _ = qbarPolynomialEval xi f := by
        unfold qbarPolynomialEval
        rw [Polynomial.coe_eval₂RingHom, Polynomial.eval₂_eq_sum_range]
        rfl

end Ising2DLambda.ThermodynamicLimit
