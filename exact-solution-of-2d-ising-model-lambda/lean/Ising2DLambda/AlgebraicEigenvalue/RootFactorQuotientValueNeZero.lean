/-
「因数定理の商の、もとの根における値は零でない」の具体版。
人手証明と同じく、準備の 3 つの非零性（w ≠ 0、w^(n-1) ≠ 0、同じ元 n 個の有限和の非零性）を
先に立て、値を 2 段の等式（商 = K_n(w)、その値 = 有限和）で書き換えて終点の非零性を当てる。
住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialFactorQuotient
import Ising2DLambda.AlgebraicEigenvalue.QbarPowDiffQuotientRootValue
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityElementNeZero
import Ising2DLambda.AlgebraicEigenvalue.QbarPowNeZero
import Ising2DLambda.AlgebraicEigenvalue.QbarRepeatedSumNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `f = t^n - 1` について因数定理が構成する商の、もとの根 `w` における値は零でない。 -/
theorem rootFactorQuotientValueNeZero (n : ℕ) (hn : 1 ≤ n) (w : Qbar)
    (hw : w ∈ RootOfUnity n) :
    qbarPolyEval w (rootFactorQuotient w n) ≠ 0 := by
  -- n ≥ 1 なので n = m + 1 と書ける（人手証明の「n-1 は自然数である」に対応）。
  obtain ⟨m, rfl⟩ : ∃ m, n = m + 1 :=
    ⟨n - 1, (Nat.succ_pred_eq_of_pos hn).symm⟩
  -- 準備の第 1: w ≠ 0（claim_root_of_unity_element_ne_zero）。
  have hw0 : w ≠ 0 := rootOfUnityElementNeZero (m + 1) hn w hw
  -- 準備の第 2: w^m ≠ 0（claim_qbar_pow_ne_zero）。
  have hpow : w ^ m ≠ 0 := qbarPowNeZero w hw0 m
  -- 準備の第 3: 同じ元 w^m を m+1 個足す有限和は零でない（claim_qbar_repeated_sum_ne_zero）。
  have hsum : (∑ _i ∈ Finset.range (m + 1), w ^ m) ≠ 0 :=
    qbarRepeatedSumNeZero hpow (m + 1) hn
  -- 鎖の第 1 行: g = K_{m+1}(w)（claim_root_polynomial_factor_quotient）。
  have h1 : qbarPolyEval w (rootFactorQuotient w (m + 1))
      = qbarPolyEval w (qbarPolyPowDiffSum w (m + 1)) := by
    rw [rootPolynomialFactorQuotientEq w (m + 1) hn]
  -- 鎖の第 2 行: K_{m+1}(w) の値は有限和（claim_qbar_pow_diff_quotient_root_value）。
  have h2 : qbarPolyEval w (qbarPolyPowDiffSum w (m + 1))
      = ∑ _i ∈ Finset.range (m + 1), w ^ m :=
    qbarPowDiffQuotientRootValue w m
  rw [h1, h2]
  exact hsum

end Ising2DLambda.AlgebraicEigenvalue
