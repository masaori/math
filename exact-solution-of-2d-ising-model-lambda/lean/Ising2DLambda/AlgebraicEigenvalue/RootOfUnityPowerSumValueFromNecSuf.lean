/-
具体版が必要十分版の特殊化として得られることの導出。

`P := n ∣ m` とし、成立側を `powerSumMultipleValue`、不成立側を
`rootOfUnityPowerNotOneExists` と `powerSumZero` から供給する。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumValue
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.RootOfUnityPowerSumValue

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 具体版は必要十分版の特殊化である。 -/
theorem powerSumValue_from_necSuf {n : ℕ} (hn : 1 ≤ n)
    [Fintype (RootOfUnity n)] (m : ℕ) :
    powerSum n m = if n ∣ m then algebraMap ℚ Qbar (n : ℚ) else 0 := by
  exact NecSuf.AlgebraicEigenvalue.piecewise_value_necSuf
    (fun hdiv => powerSumMultipleValue hn hdiv)
    (fun hndiv => by
      obtain ⟨w, hw, hne⟩ := rootOfUnityPowerNotOneExists hn hndiv
      exact powerSumZero hn hw hne)

end Ising2DLambda.AlgebraicEigenvalue
