/-
具体版が必要十分版の特殊化として得られることの導出。
mul を Qbar[t] の積、l を一次因子 t - ŵ、g を因数定理の商、v を w における値、
z を零元と置く。準備（係数の上界・根の条件・因数定理・商の係数の上界・消去・
商の値の非零性）は具体版と同じ形で確かめて仮定へ渡す。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialRemainingFactorValueNeZero
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootPolynomialRemainingFactorValueNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem rootPolynomialRemainingFactorValueNeZero_from_necSuf (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) (B : QbarPoly)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hf : rootPolynomial n = (Polynomial.X - qbarConst w) * B) :
    qbarPolyEval w B ≠ 0 := by
  -- 準備は具体版と同じ。
  have hcoeff : ∀ k : ℕ, n < k → (rootPolynomial n).coeff k = 0 := by
    intro k hk
    calc
      (rootPolynomial n).coeff k
          = (Polynomial.X ^ n : QbarPoly).coeff k + (qbarConst (-1)).coeff k := by
            rw [rootPolynomial, Polynomial.coeff_add]
      _ = 0 + (qbarConst (-1)).coeff k := by
            rw [qbarPolyIndeterminatePowerCoefficient n k,
              if_neg (by omega : ¬(k = n))]
      _ = 0 + 0 := by
            rw [qbarConst, Polynomial.coeff_C, if_neg (by omega : ¬(k = 0))]
      _ = 0 := zero_add 0
  have hroot : qbarPolyEval w (rootPolynomial n) = 0 := by
    calc
      qbarPolyEval w (rootPolynomial n)
          = qbarPolyEval w (Polynomial.X ^ n) + qbarPolyEval w (qbarConst (-1)) := by
            rw [rootPolynomial]; simp [qbarPolyEval_eq_eval]
      _ = w ^ n + qbarPolyEval w (qbarConst (-1)) := by
            rw [qbarPolyEvalIndeterminatePow]
      _ = w ^ n + (-1) := by simp [qbarPolyEval_eq_eval, qbarConst]
      _ = 1 + (-1) := by rw [mem_rootOfUnity.mp hw]
      _ = 0 := by norm_num
  have hfg : rootPolynomial n
      = (Polynomial.X - qbarConst w) * rootFactorQuotient w n := by
    have h := qbarFactorTheorem (rootPolynomial n) w n hcoeff hroot
    rw [rootFactorQuotient]
    exact h
  have hgcoeff : ∀ j, n < j → (rootFactorQuotient w n).coeff j = 0 := by
    intro j hj
    have h := qbarFactorQuotientCoeffBound (rootPolynomial n) w n j (Nat.le_of_lt hj)
    rw [rootFactorQuotient]
    exact h
  -- 必要十分版の特殊化。
  exact Ising2DLambda.NecSuf.AlgebraicEigenvalue.remaining_factor_value_necSuf
    (fun A C => A * C) (Polynomial.X - qbarConst w) (rootPolynomial n)
    (rootFactorQuotient w n) B (qbarPolyEval w) 0 hfg hf
    (fun hmul => qbarPolyLinearFactorCancellation w B (rootFactorQuotient w n) n hB hgcoeff hmul)
    (rootFactorQuotientValueNeZero n hn w hw)

end Ising2DLambda.AlgebraicEigenvalue
