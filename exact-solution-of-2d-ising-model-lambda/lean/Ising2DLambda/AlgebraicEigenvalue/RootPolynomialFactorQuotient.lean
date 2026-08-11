/-
「1 の冪根を根に持つ多項式について、因数定理の商は冪の差の商に等しい」の具体版。
人手証明と同じく、因数定理で構成した有限和のうち番号 n の項だけが残ることを示す。
既製の多項式の除法や商の一意性には委ねない。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorTheorem

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

noncomputable def rootPolynomial (n : ℕ) : QbarPoly :=
  Polynomial.X ^ n + qbarConst (-1)

noncomputable def rootFactorQuotient (w : Qbar) (n : ℕ) : QbarPoly :=
  ∑ k ∈ Finset.range (n + 1),
    qbarConst ((rootPolynomial n).coeff k) * qbarPolyPowDiffSum w k

lemma rootPolynomial_coeff_top (n : ℕ) (hn : n ≠ 0) :
    (rootPolynomial n).coeff n = 1 := by
  rw [rootPolynomial, Polynomial.coeff_add,
    qbarPolyIndeterminatePowerCoefficient n n, if_pos rfl]
  rw [qbarConst, Polynomial.coeff_C, if_neg hn, add_zero]

lemma rootFactorQuotient_term_zero (w : Qbar) (n k : ℕ)
    (hkn : k ≠ n) :
    qbarConst ((rootPolynomial n).coeff k) * qbarPolyPowDiffSum w k = 0 := by
  by_cases hk0 : k = 0
  · subst k
    simp [qbarPolyPowDiffSum]
  · have hkpos : 0 < k := Nat.pos_of_ne_zero hk0
    have hcoeff : (rootPolynomial n).coeff k = 0 := by
      rw [rootPolynomial, Polynomial.coeff_add,
        qbarPolyIndeterminatePowerCoefficient n k, if_neg hkn]
      rw [qbarConst, Polynomial.coeff_C, if_neg hk0, zero_add]
    rw [hcoeff]
    simp [qbarConst]

/-- `f = t^n - 1` について因数定理が構成する商は `K_n(w)` に等しい。 -/
theorem rootPolynomialFactorQuotientEq (w : Qbar) (n : ℕ) (hn : 1 ≤ n) :
    rootFactorQuotient w n = qbarPolyPowDiffSum w n := by
  calc
    rootFactorQuotient w n
        = qbarConst ((rootPolynomial n).coeff n)
            * qbarPolyPowDiffSum w n := by
              rw [rootFactorQuotient]
              apply Finset.sum_eq_single n
              · intro k hk hkn
                exact rootFactorQuotient_term_zero w n k hkn
              · simp
    _ = qbarPolyPowDiffSum w n := by
          have hn0 : n ≠ 0 := Nat.ne_of_gt (lt_of_lt_of_le Nat.zero_lt_one hn)
          rw [rootPolynomial_coeff_top n hn0]
          simp [qbarConst]

end Ising2DLambda.AlgebraicEigenvalue
