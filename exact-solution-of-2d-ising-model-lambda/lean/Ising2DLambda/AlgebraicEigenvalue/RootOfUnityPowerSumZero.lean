/-
章「固有値の代数性」の「冪が 1 でない 1 の冪根があるとき、冪の和は零元である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_root_of_unity_power_sum_zero`）に対応する。

  人手証明                                          このファイル
  準備 1（μ_n の有限性）                            `[Fintype (RootOfUnity n)]`（powerSum の仮定として受け取る）
  準備 2（w^m ≠ 1 から w^m - 1 ≠ 0）               `hne1`（両辺に 1 を足す 3 段の鎖）
  鎖の第 1 段（分配則）と第 2 段（積の単位元）      `sub_mul`・`one_mul`
  鎖の第 3 段（冪の和の不変性）                      `powerSum_mul_invariant`
  鎖の第 4 段（同じ元どうしの差は零元）              `sub_self`
  結論（零元でない方で割る）                         `qbarNoZeroDivisors`

mathlib の `sub_ne_zero_of_ne` 等の既製定理へは委ねない
（準備の段も、割る段も、人手証明が持っている段をそのまま書く）。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerSum
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 人手証明の本体。`n ≥ 1`・`w ∈ μ_n`・`w^m ≠ 1` ならば `S_{n,m} = 0`
（`claim_root_of_unity_power_sum_zero`）。 -/
theorem powerSumZero {n : ℕ} (hn : 1 ≤ n) [Fintype (RootOfUnity n)] {m : ℕ}
    {w : Qbar} (hw : w ∈ RootOfUnity n) (hne : w ^ m ≠ 1) :
    powerSum n m = 0 := by
  -- 準備 2。w^m - 1 = 0 とすると両辺に 1 を足して w^m = 1 となり、仮定に反する。
  have hne1 : w ^ m - 1 ≠ 0 := by
    intro h
    apply hne
    calc w ^ m = (w ^ m - 1) + 1 := by rw [sub_add_cancel]
      _ = 0 + 1 := by rw [h]
      _ = 1 := zero_add 1
  -- 鎖。(w^m - 1) S = w^m S - 1·S = w^m S - S = S - S = 0。
  have hchain : (w ^ m - 1) * powerSum n m = 0 :=
    calc (w ^ m - 1) * powerSum n m
        = w ^ m * powerSum n m - 1 * powerSum n m := sub_mul _ _ _
          -- 第 1 段。分配則。
      _ = w ^ m * powerSum n m - powerSum n m := by rw [one_mul]
          -- 第 2 段。1 は積の単位元。
      _ = powerSum n m - powerSum n m := by rw [powerSum_mul_invariant hn hw m]
          -- 第 3 段。冪の和の不変性。
      _ = 0 := sub_self _
          -- 第 4 段。同じ元どうしの差は零元。
  -- 結論。積が零元で、w^m - 1 が零元でないので、もう一方が零元である。
  exact qbarNoZeroDivisors hne1 hchain

end Ising2DLambda.AlgebraicEigenvalue
