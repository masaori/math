/-
主張「一次因子を取り除いた商は、もとの根と相異なる根で零になる」の必要十分版。

必要なのは、多項式の型 `P` の積、値を取る写像がその積を保つこと、因子の値が零でない元
`difference` であること、および `difference` が左逆元を持つことだけである。
多項式環、加法、引き算、体、代数閉性は仮定しない。

住処: ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 因子分解を零点で評価した積から、零でない因子を左から割って商の値を零とする。 -/
theorem factor_quotient_other_root_zero_necSuf {P M : Type*} [MonoidWithZero M]
    (mulP : P → P → P) (eval : P → M) (f factor g : P)
    (difference differenceInv : M)
    (hfactor : f = mulP factor g)
    (hevalMul : eval (mulP factor g) = eval factor * eval g)
    (hevalFactor : eval factor = difference)
    (hroot : eval f = 0) (hinv : differenceInv * difference = 1) :
    eval g = 0 := by
  have hchain : difference * eval g = 0 := by
    calc
      difference * eval g = eval factor * eval g := by rw [hevalFactor]
      _ = eval (mulP factor g) := hevalMul.symm
      _ = eval f := by rw [hfactor]
      _ = 0 := hroot
  exact no_zero_divisors_necSuf hinv hchain

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
