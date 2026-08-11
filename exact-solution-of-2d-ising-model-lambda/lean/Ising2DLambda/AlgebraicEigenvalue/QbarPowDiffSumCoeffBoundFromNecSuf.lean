/-
「冪の差の因数分解の商の係数上界」の具体版が、必要十分版の特殊化として得られることの導出。
住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPowDiffSumCoeffBound
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowDiffSumCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の `K_n(w)` と必要十分版の再帰列は同じ元である。 -/
theorem qbarPolyPowDiffSum_eq_coeffBound_necSuf (w : Qbar) (n : ℕ) :
    qbarPolyPowDiffSum w n =
      NecSuf.AlgebraicEigenvalue.powDiffSum_necSuf w n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      simp only [qbarPolyPowDiffSum,
        NecSuf.AlgebraicEigenvalue.powDiffSum_necSuf, qbarConst, ih]

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarPowDiffSumCoeffBound_from_necSuf (w : Qbar) (n j : ℕ) (h : n ≤ j) :
    (qbarPolyPowDiffSum w n).coeff j = 0 := by
  rw [qbarPolyPowDiffSum_eq_coeffBound_necSuf]
  exact NecSuf.AlgebraicEigenvalue.pow_diff_sum_coeff_bound_necSuf w n j h

end Ising2DLambda.AlgebraicEigenvalue
