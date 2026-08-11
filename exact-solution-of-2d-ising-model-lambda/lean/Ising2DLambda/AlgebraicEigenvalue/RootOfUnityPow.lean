/-
章「固有値の代数性」の「1 の冪根の冪は 1 の冪根である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_root_of_unity_pow`）に対応する。

  人手証明                                   このファイル
  k についての帰納法                          `Nat.rec`（`induction k with`）
  出発点 w^0 = 1（冪の約束）                  `pow_zero`
  出発点 1^n = 1（単位元の反復積は単位元）     `one_pow`
  一歩 w^{k+1} = w^k w（冪の約束）            `pow_succ`
  一歩 μ_n が積で閉じている                   `rootOfUnity_mul`（`claim_root_of_unity_mul` の具体版）

mathlib の一般論（`Subgroup`・`Submonoid.pow_mem`・`rootsOfUnity` 等）へ委ねず、
人手証明の帰納法をそのまま書く。μ_n が積で閉じていることは自前の `rootOfUnity_mul` を引く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityMul

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`w ∈ μ_n` ならば任意の `k` について `w ^ k ∈ μ_n`
（`claim_root_of_unity_pow`）。 -/
theorem rootOfUnity_pow {n : ℕ} {w : Qbar} (hw : w ∈ RootOfUnity n) (k : ℕ) :
    w ^ k ∈ RootOfUnity n := by
  induction k with
  | zero =>
      -- 出発点。w^0 = 1 であり、1^n = 1 なので 1 ∈ μ_n。
      rw [pow_zero, mem_rootOfUnity]
      exact one_pow n
  | succ k ih =>
      -- 一歩。w^{k+1} = w^k w へ、μ_n が積で閉じていることを当てる。
      rw [pow_succ]
      exact rootOfUnity_mul ih hw

end Ising2DLambda.AlgebraicEigenvalue
