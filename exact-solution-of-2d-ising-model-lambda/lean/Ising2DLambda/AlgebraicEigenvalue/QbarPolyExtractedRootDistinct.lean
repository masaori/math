/-
「取り出した分解の残りの因子の根は、取り出した因子の根と相異なる」の具体版。
人手証明の正本は `claim_qbar_poly_extracted_root_distinct` である。

人手証明と同じ背理法である。w' = w と仮定して aev_w(h) を 5 段の鎖で 0 へ落とし、
一方で d4b2c1（rootPolynomialRemainingFactorValueNeZero）から aev_w(h) ≠ 0 を得て矛盾させる。

  人手証明                                このファイル
  第 1 段（h = Ag の代入）                calc の第 1 の等号
  第 2 段（評価は積を保つ）               calc の第 2 の等号（eval_mul）
  第 3 段（背理法の仮定 w' = w）          calc の第 3 の等号
  第 4 段（aev_{w'}(g) = 0 の代入）       calc の第 4 の等号
  第 5 段（零元との積は零元）             calc の第 5 の等号（mul_zero）
  d4b2c1 による aev_w(h) ≠ 0             `hne`

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorProductExtract

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarPolyExtractedRootDistinct (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) (h A g : QbarPoly)
    (hcoeff : ∀ k, n < k → h.coeff k = 0)
    (hf : rootPolynomial n = (Polynomial.X - qbarConst w) * h)
    (hAg : h = A * g) (w' : Qbar) (hg : qbarPolyEval w' g = 0) :
    w' ≠ w := by
  intro heq
  have hne := rootPolynomialRemainingFactorValueNeZero n hn w hw h hcoeff hf
  apply hne
  calc
    qbarPolyEval w h
        = qbarPolyEval w (A * g) := by rw [hAg]
    _ = qbarPolyEval w A * qbarPolyEval w g := by
          rw [qbarPolyEval_eq_eval, Polynomial.eval_mul,
            ← qbarPolyEval_eq_eval, ← qbarPolyEval_eq_eval]
    _ = qbarPolyEval w A * qbarPolyEval w' g := by rw [heq]
    _ = qbarPolyEval w A * 0 := by rw [hg]
    _ = 0 := by rw [mul_zero]

end Ising2DLambda.AlgebraicEigenvalue
