/-
「一次因子との分解の残りの因子の、その一次因子の根における値は零でない」の具体版。
人手証明の正本は `claim_root_polynomial_remaining_factor_value_ne_zero` である。

人手証明と同じく、因数定理の 2 つの仮定（係数の上界・根の条件）を確かめて
f = (t-ŵ)g を作り、仮定 f = (t-ŵ)B と合わせて一次因子を消去し B = g を得て、
商の値の非零性（claim_root_factor_quotient_value_ne_zero）を写す。

  人手証明                                          このファイル
  第 1（n < k で ac_k(f) = 0）                      `hcoeff`
  第 2（w ∈ μ_n で aev_w(f) = 0）                   `hroot`
  因数定理 f = (t-ŵ)g                               `hfg`
  商の係数の上界（n < j で ac_j(g) = 0）            `hgcoeff`
  消去による B = g                                  `hBg`
  値の鎖 aev_w(B) = aev_w(g) ≠ 0                    末尾の書き換えと適用

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootFactorQuotientValueNeZero
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorCancellation
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem rootPolynomialRemainingFactorValueNeZero (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) (B : QbarPoly)
    (hB : ∀ k, n < k → B.coeff k = 0)
    (hf : rootPolynomial n = (Polynomial.X - qbarConst w) * B) :
    qbarPolyEval w B ≠ 0 := by
  -- 準備の第 1: n < k では f = t^n + (-1)^ の両方の項の係数が零である。
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
  -- 準備の第 2: w^n = 1 から aev_w(f) = 1 + (-1) = 0（代入は和を保つ・
  -- 不定元の冪の値・定数の値）。
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
  -- 因数定理: f = (t-ŵ)g。g は式で指定した商（rootFactorQuotient）。
  have hfg : rootPolynomial n
      = (Polynomial.X - qbarConst w) * rootFactorQuotient w n := by
    have h := qbarFactorTheorem (rootPolynomial n) w n hcoeff hroot
    rw [rootFactorQuotient]
    exact h
  -- 商の係数の上界: n ≤ j で零なので、とくに n < j で零である。
  have hgcoeff : ∀ j, n < j → (rootFactorQuotient w n).coeff j = 0 := by
    intro j hj
    have h := qbarFactorQuotientCoeffBound (rootPolynomial n) w n j (Nat.le_of_lt hj)
    rw [rootFactorQuotient]
    exact h
  -- 本体: (t-ŵ)B = f = (t-ŵ)g から一次因子を消去して B = g。
  have hBg : B = rootFactorQuotient w n := by
    apply qbarPolyLinearFactorCancellation w B (rootFactorQuotient w n) n hB hgcoeff
    rw [← hf, hfg]
  -- 値の鎖: aev_w(B) = aev_w(g) であり、終点は単根性により零でない。
  rw [hBg]
  exact rootFactorQuotientValueNeZero n hn w hw

end Ising2DLambda.AlgebraicEigenvalue
