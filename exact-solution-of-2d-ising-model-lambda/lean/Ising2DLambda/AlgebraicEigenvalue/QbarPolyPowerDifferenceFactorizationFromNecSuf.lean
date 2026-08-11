/-
多項式版の具体版が、必要十分版の特殊化として得られることの導出。

具体版は必要十分版（`power_difference_factorization_necSuf`）を次のように取ったものである。

  R := QbarPoly = Polynomial Qbar（可換環なので当然に環である）
  z := Polynomial.X        w := qbarConst w        n := n
  h : Commute X (C w) := 係数どうしの積が可換なので多項式どうしの積も可換

すなわち、`Qbar` の 2 元についての具体版（`QbarPowerDifferenceFactorization`）と
この多項式版は、**同じ 1 本の定理の別々の特殊化**である。
人手証明で同じ鎖を 2 度書いているのは、人手証明を一般の環へ持ち上げないという規則によるもので、
数学的に 2 つの内容があるわけではない。この導出がそのことを示す。

`K_n` の定義は必要十分版の `H_n` と同じ約束（`H_0 = 0`、`H_{n+1} = H_n w + z^n`）で
書いてあるので、一致は `n` についての帰納法で出る。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowerDifferenceFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 多項式版の `K_n` と必要十分版の `H_n` は同じ元である（同じ約束で定めてあるため）。 -/
theorem qbarPolyPowDiffSum_eq_necSuf (w : Qbar) (n : ℕ) :
    qbarPolyPowDiffSum w n
      = NecSuf.AlgebraicEigenvalue.powDiffSum (Polynomial.X : QbarPoly) (qbarConst w) n := by
  induction n with
  | zero => rfl
  | succ n ih =>
      rw [qbarPolyPowDiffSum, NecSuf.AlgebraicEigenvalue.powDiffSum, ih]

/-- 多項式版の具体版は必要十分版の特殊化である。 -/
theorem qbarPolyPowerDifferenceFactorization_from_necSuf (w : Qbar) (n : ℕ) :
    (Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w n
      = Polynomial.X ^ n - qbarConst w ^ n := by
  rw [qbarPolyPowDiffSum_eq_necSuf]
  exact NecSuf.AlgebraicEigenvalue.power_difference_factorization_necSuf
    (R := QbarPoly) Polynomial.X (qbarConst w)
    (Commute.all (Polynomial.X : QbarPoly) (qbarConst w)) n

end Ising2DLambda.AlgebraicEigenvalue
