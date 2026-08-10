/-
章「固有値の代数性」の「代数的数の積の冪は、冪の積である」の具体版
（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_mul_pow`）に対応する。

  人手証明                                  このファイル
  出発点の鎖 4 段（n = 0）                  induction の zero の分岐の calc 4 段
  一歩の鎖 9 段（n → n+1）                  induction の succ の分岐の calc 9 段

mathlib の `mul_pow` へは委ねず、人手証明の帰納法と鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`(w * z) ^ n = w ^ n * z ^ n`（`claim_qbar_mul_pow`）。 -/
theorem qbarMul_pow (w z : Qbar) (n : ℕ) : (w * z) ^ n = w ^ n * z ^ n := by
  induction n with
  | zero =>
      calc (w * z) ^ 0
          = 1 := pow_zero _
            -- 第 1 段。y^0 := 1。
        _ = 1 * 1 := (one_mul 1).symm
            -- 第 2 段。1 は積の単位元。
        _ = w ^ 0 * 1 := by rw [pow_zero]
            -- 第 3 段。y^0 := 1。
        _ = w ^ 0 * z ^ 0 := by rw [pow_zero z]
            -- 第 4 段。y^0 := 1。
  | succ n ih =>
      calc (w * z) ^ (n + 1)
          = (w * z) ^ n * (w * z) := pow_succ _ _
            -- 第 1 段。y^{j+1} := y^j y。
        _ = (w ^ n * z ^ n) * (w * z) := by rw [ih]
            -- 第 2 段。帰納法の仮定。
        _ = w ^ n * (z ^ n * (w * z)) := mul_assoc _ _ _
            -- 第 3 段。積の結合則。
        _ = w ^ n * ((z ^ n * w) * z) := by rw [mul_assoc]
            -- 第 4 段。積の結合則。
        _ = w ^ n * ((w * z ^ n) * z) := by rw [mul_comm (z ^ n) w]
            -- 第 5 段。積の可換則を z^n と w に当てる。
        _ = w ^ n * (w * (z ^ n * z)) := by rw [mul_assoc]
            -- 第 6 段。積の結合則。
        _ = (w ^ n * w) * (z ^ n * z) := (mul_assoc _ _ _).symm
            -- 第 7 段。積の結合則。
        _ = w ^ (n + 1) * (z ^ n * z) := by rw [pow_succ]
            -- 第 8 段。y^{j+1} := y^j y。
        _ = w ^ (n + 1) * z ^ (n + 1) := by rw [pow_succ z n]
            -- 第 9 段。y^{j+1} := y^j y。

end Ising2DLambda.AlgebraicEigenvalue
