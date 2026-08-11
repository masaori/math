/-
章「固有値の代数性」の「代数的数の積が零元ならば、零元でない方で割って他方が零元と分かる」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_no_zero_divisors`）に対応する。

  人手証明                                このファイル
  準備（a ≠ 0 から a⁻¹ を取る）           `inv_mul_cancel₀ ha`
  鎖の第 1 段（b = 1 b）                  `one_mul`
  鎖の第 2 段（1 = a⁻¹ a）                `inv_mul_cancel₀ ha`
  鎖の第 3 段（結合則）                   `mul_assoc`
  鎖の第 4 段（仮定 a b = 0）             `hab`
  鎖の第 5 段（零元との積は零元）         `mul_zero`

mathlib の `mul_eq_zero`・`eq_zero_of_ne_zero_of_mul_left_eq_zero` 等の既製定理へは委ねない
（体に零因子が無いことを一般論として引くと、人手証明の 5 段の鎖が消える）。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`a b = 0` かつ `a ≠ 0` ならば `b = 0`（`claim_qbar_no_zero_divisors`）。 -/
theorem qbarNoZeroDivisors {a b : Qbar} (ha : a ≠ 0) (hab : a * b = 0) : b = 0 := by
  -- 準備。a ≠ 0 なので、体 Qbar に a⁻¹ a = 1 を満たす元 a⁻¹ がある。
  have hinv : a⁻¹ * a = 1 := inv_mul_cancel₀ ha
  calc b
      = 1 * b := (one_mul b).symm            -- 第 1 段。1 は積の単位元。
    _ = (a⁻¹ * a) * b := by rw [hinv]        -- 第 2 段。準備で取った a⁻¹ の性質。
    _ = a⁻¹ * (a * b) := mul_assoc _ _ _     -- 第 3 段。積の結合則。
    _ = a⁻¹ * 0 := by rw [hab]               -- 第 4 段。仮定 a b = 0。
    _ = 0 := mul_zero _                      -- 第 5 段。零元との積は零元。

end Ising2DLambda.AlgebraicEigenvalue
