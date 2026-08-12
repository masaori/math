/-
章「固有値の代数性」の「1 の冪根の全体にわたる冪の和の値」の具体版。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張
`claim_root_of_unity_power_sum_value` に対応する。

  人手証明                                      このファイル
  n ∣ m の場合分け                              `by_cases hdiv : n ∣ m`
  n ∣ m なら S_{n,m} = n                       `powerSumMultipleValue`
  n ∤ m なら w^m ≠ 1 なる w ∈ μ_n が存在       `rootOfUnityPowerNotOneExists`
  その w により S_{n,m} = 0                    `powerSumZero`

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumMultipleValue
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerNotOneExists
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSumZero

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `n ≥ 1` のとき、`S_{n,m}` は `n ∣ m` なら `n`、そうでなければ零元である。 -/
theorem powerSumValue {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)] (m : ℕ) :
    powerSum n m = if n ∣ m then algebraMap ℚ Qbar (n : ℚ) else 0 := by
  by_cases hdiv : n ∣ m
  · rw [if_pos hdiv]
    exact powerSumMultipleValue hn hdiv
  · rw [if_neg hdiv]
    obtain ⟨w, hw, hne⟩ := rootOfUnityPowerNotOneExists hn hdiv
    exact powerSumZero hn hw hne

end Ising2DLambda.AlgebraicEigenvalue
