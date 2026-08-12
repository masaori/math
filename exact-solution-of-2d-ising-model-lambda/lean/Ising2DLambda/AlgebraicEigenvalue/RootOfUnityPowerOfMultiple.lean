/-
章「固有値の代数性」の「指数が根の次数の倍数ならば 1 の冪根の冪は 1 である」の具体版。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張
`claim_root_of_unity_power_of_multiple` に対応する。

  人手証明                         このファイル
  m = n k を満たす k を取る          `hdiv` を分解する
  w^m = w^(n k)                     `m = n k`
  w^(n k) = (w^n)^k                `pow_mul`
  (w^n)^k = 1^k                    `mem_rootOfUnity` と `hw`
  1^k = 1                          `one_pow`

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- `n ∣ m` かつ `w ∈ μ_n` ならば `w ^ m = 1`。 -/
theorem rootOfUnityPowerOfMultiple {n m : ℕ} (_hn : 1 ≤ n) {w : Qbar}
    (hw : w ∈ RootOfUnity n) (hdiv : n ∣ m) : w ^ m = 1 := by
  obtain ⟨k, rfl⟩ := hdiv
  have hroot : w ^ n = 1 := by
    rw [mem_rootOfUnity] at hw
    exact hw
  calc w ^ (n * k) = (w ^ n) ^ k := pow_mul w n k
    _ = 1 ^ k := by rw [hroot]
    _ = 1 := one_pow k

end Ising2DLambda.AlgebraicEigenvalue
