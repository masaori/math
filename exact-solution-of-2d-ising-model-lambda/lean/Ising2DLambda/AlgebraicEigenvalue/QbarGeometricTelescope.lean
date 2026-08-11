/-
章「固有値の代数性」の「代数的数の冪の有限和は、1 を引いたものを掛けると伸縮する」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_geometric_telescope`）に対応する。

  人手証明                                          このファイル
  G_n(z) = Σ_{k=0}^{n-1} z^k                        `qbarGeomSum`
  準備（z z^k = z^k z。k についての帰納法）          `pow_succ'`（mathlib の証明も同じ帰納法）
  出発点（G_0 は空和）                               `Nat.zero` の場合。`Finset.range 0` が空
  一歩の第 1 の等号（G_{n+1} = G_n + z^n）           `Finset.sum_range_succ`
  一歩の第 2・第 4 の等号（分配則）                   `sub_mul` / `mul_add`（環の分配則）
  一歩の第 3 の等号（帰納法の仮定）                   `ih`
  一歩の第 5 の等号（1 z^n = z^n）                   `one_mul`
  一歩の第 6・第 7 の等号（z z^n = z^n z = z^{n+1}） `pow_succ'`
  一歩の第 8 の等号（z^n が相殺する）                 加法群の計算

mathlib の `geom_sum_mul`・`Finset.geom_sum_eq` 等の既製定理へは委ねない。
帰納法と分配則だけで人手証明の 4 段・6 段の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Mathlib.Algebra.BigOperators.Group.Finset.Defs

namespace Ising2DLambda.AlgebraicEigenvalue

open BigOperators

/-- 人手証明の `G_n(z) = Σ_{k=0}^{n-1} z^k`。 -/
noncomputable def qbarGeomSum (z : Qbar) (n : ℕ) : Qbar :=
  ∑ k ∈ Finset.range n, z ^ k

/-- 人手証明の本体。`(z - 1) G_n(z) = z^n - 1`（`claim_qbar_geometric_telescope`）。 -/
theorem qbarGeometricTelescope (z : Qbar) (n : ℕ) :
    (z - 1) * qbarGeomSum z n = z ^ n - 1 := by
  induction n with
  | zero =>
      -- 出発点。空和が 0 であること、0 との積が 0 であること、z^0 = 1 であること。
      calc (z - 1) * qbarGeomSum z 0
          = (z - 1) * 0 := by rw [qbarGeomSum, Finset.range_zero, Finset.sum_empty]
        _ = 0 := mul_zero _
        _ = 1 - 1 := (sub_self 1).symm
        _ = z ^ 0 - 1 := by rw [pow_zero]
  | succ n ih =>
      -- 一歩。G_{n+1} = G_n + z^n へ分配則を当て、帰納法の仮定を入れて z^n を相殺させる。
      calc (z - 1) * qbarGeomSum z (n + 1)
          = (z - 1) * (qbarGeomSum z n + z ^ n) := by
            rw [qbarGeomSum, qbarGeomSum, Finset.sum_range_succ]
        _ = (z - 1) * qbarGeomSum z n + (z - 1) * z ^ n := mul_add _ _ _
        _ = (z ^ n - 1) + (z - 1) * z ^ n := by rw [ih]
        _ = (z ^ n - 1) + (z * z ^ n - 1 * z ^ n) := by rw [sub_mul]
        _ = (z ^ n - 1) + (z ^ (n + 1) - z ^ n) := by rw [one_mul, ← pow_succ']
        _ = z ^ (n + 1) - 1 := by ring

end Ising2DLambda.AlgebraicEigenvalue
