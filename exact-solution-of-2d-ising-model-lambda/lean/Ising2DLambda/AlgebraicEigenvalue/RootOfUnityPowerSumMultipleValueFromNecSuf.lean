/-
具体版が必要十分版の特殊化として得られることの導出。

具体版では `α := RootOfUnity n`、`M := Qbar`、`f z := z^m`、`u := 1`、
`c := algebraMap ℚ Qbar n` とし、各項が 1 であることを
`rootOfUnityPowerOfMultiple`、個数を `rootOfUnityFintypeCard`、
単位元の n 個の和の値を `qbarUnitSumEqRational` から供給する。
ここで `Qbar` の積・体・代数閉性は使わない。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumMultipleValue
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerSumMultipleValue

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 具体版は必要十分版の特殊化である。 -/
theorem powerSumMultipleValue_from_necSuf {n : ℕ} (hn : 1 ≤ n)
    [Fintype (RootOfUnity n)] {m : ℕ} (hdiv : n ∣ m) :
    powerSum n m = algebraMap ℚ Qbar (n : ℚ) := by
  rw [powerSum]
  exact NecSuf.AlgebraicEigenvalue.sum_const_reindex_necSuf
    (fun z => rootOfUnityPowerOfMultiple hn z.2 hdiv)
    (rootOfUnityFintypeCard n hn)
    (qbarUnitSumEqRational n)

end Ising2DLambda.AlgebraicEigenvalue
