/-
章「固有値の代数性」の「1 でない 1 の冪根の、冪の有限和は零元である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_root_of_unity_geometric_sum_zero`）に対応する。

  人手証明                                          このファイル
  準備（z ≠ 1 から z - 1 ≠ 0）                      `hz1`（両辺に 1 を足す 3 段の鎖）
  鎖の第 1 段（伸縮の等式）                          `qbarGeometricTelescope`
  鎖の第 2 段（z ∈ μ_n すなわち z^n = 1）           `mem_rootOfUnity.mp hz`
  鎖の第 3 段（同じ元どうしの差は零元）              `sub_self`
  結論（零元でない方で割る）                         `qbarNoZeroDivisors`

mathlib の `geom_sum_eq`・`sub_ne_zero_of_ne` 等の既製定理へは委ねない
（準備の段も、割る段も、人手証明が持っている段をそのまま書く）。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarGeometricTelescope
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 人手証明の本体。`z ∈ μ_n` かつ `z ≠ 1` ならば `G_n(z) = 0`
（`claim_root_of_unity_geometric_sum_zero`）。 -/
theorem rootOfUnityGeometricSumZero {n : ℕ} {z : Qbar} (hz : z ∈ RootOfUnity n)
    (hne : z ≠ 1) : qbarGeomSum z n = 0 := by
  -- 準備。z - 1 = 0 とすると両辺に 1 を足して z = 1 となり、仮定に反する。
  have hz1 : z - 1 ≠ 0 := by
    intro h
    apply hne
    calc z = (z - 1) + 1 := by rw [sub_add_cancel]
      _ = 0 + 1 := by rw [h]
      _ = 1 := zero_add 1
  -- 鎖。(z - 1) G_n(z) = z^n - 1 = 1 - 1 = 0。
  have hchain : (z - 1) * qbarGeomSum z n = 0 :=
    calc (z - 1) * qbarGeomSum z n
        = z ^ n - 1 := qbarGeometricTelescope z n   -- 第 1 段。伸縮の等式。
      _ = 1 - 1 := by rw [mem_rootOfUnity.mp hz]    -- 第 2 段。z^n = 1。
      _ = 0 := sub_self 1                           -- 第 3 段。同じ元の差は零元。
  -- 結論。積が零元で、z - 1 が零元でないので、もう一方が零元である。
  exact qbarNoZeroDivisors hz1 hchain

end Ising2DLambda.AlgebraicEigenvalue
