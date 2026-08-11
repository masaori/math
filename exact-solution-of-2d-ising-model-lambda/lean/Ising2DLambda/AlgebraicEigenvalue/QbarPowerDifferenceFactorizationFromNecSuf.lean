/-
具体版が必要十分版の特殊化として得られることの導出。

具体版は必要十分版を次のように取ったものである。

  R := Qbar（体なので当然に環である）
  z := z        w := w        n := n
  h : Commute z w := Qbar の積の可換則

すなわち、この段が要求するのは**環であることと、この 2 元が可換であることだけ**である。
体であることも、代数閉であることも、環全体が可換であることも、
`z` や `w` が 1 の冪根であることも、`z ≠ w` であることも使っていない。

`H_n` の定義は両側で同じ約束（`H_0 = 0`、`H_{n+1} = H_n w + z^n`）で書いてあるので、
一致は `n` についての帰納法で出る。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPowerDifferenceFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowerDifferenceFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版の `H_n` と必要十分版の `H_n` は同じ元である（同じ約束で定めてあるため）。 -/
theorem qbarPowDiffSum_eq_necSuf (z w : Qbar) (n : ℕ) :
    qbarPowDiffSum z w n = NecSuf.AlgebraicEigenvalue.powDiffSum z w n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [qbarPowDiffSum, NecSuf.AlgebraicEigenvalue.powDiffSum, ih]

/-- 具体版は必要十分版の特殊化である。 -/
theorem qbarPowerDifferenceFactorization_from_necSuf (z w : Qbar) (n : ℕ) :
    (z - w) * qbarPowDiffSum z w n = z ^ n - w ^ n := by
  rw [qbarPowDiffSum_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.power_difference_factorization_necSuf
    (R := Qbar) z w (Commute.all z w) n

end Ising2DLambda.AlgebraicEigenvalue
