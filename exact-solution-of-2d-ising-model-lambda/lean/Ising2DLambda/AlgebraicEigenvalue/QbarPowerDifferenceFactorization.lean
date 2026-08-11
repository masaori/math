/-
章「固有値の代数性」の「代数的数の冪の差は、もとの 2 元の差を因子に持つ」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは主張 1 件
（`claim_qbar_power_difference_factorization`）に対応する。

  人手証明                                          このファイル
  H_0(z,w) = 0、H_{n+1} = H_n w + z^n               `qbarPowDiffSum`
  準備（z z^k = z^k z。結合則と単位元だけ）          `pow_succ'`（下の第 8 の等号で使う）
  出発点（H_0 = 0、z^0 = w^0 = 1）                   `Nat.zero` の場合
  一歩の第 1 の等号（H_{n+1} の約束）                `qbarPowDiffSum` の展開
  一歩の第 2・第 5・第 7 の等号（分配則）            `mul_add` / `sub_mul`
  一歩の第 3 の等号（積の結合則）                    `mul_assoc`
  一歩の第 4 の等号（帰納法の仮定）                  `ih`
  一歩の第 6 の等号（w^{n+1} = w^n w）               `pow_succ`
  一歩の第 8・第 9 の等号（z z^n = z^n z = z^{n+1}） `pow_succ'`（人手証明では準備の等式を引く）
  一歩の第 10 の等号（w z^n = z^n w。可換則）        `Commute.pow_right`
  一歩の第 11 の等号（z^n w が相殺する）             加法群の計算

mathlib の `sub_dvd_pow_sub_pow`・`Commute.sub_dvd_pow_sub_pow` 等の既製定理へは委ねない。
帰納法と分配則だけで人手証明の 5 段・11 段の鎖をそのまま書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（元は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の `H_n(z, w)`（`H_0 = 0`、`H_{n+1} = H_n w + z^n`）。 -/
noncomputable def qbarPowDiffSum (z w : Qbar) : ℕ → Qbar
  | 0 => 0
  | n + 1 => qbarPowDiffSum z w n * w + z ^ n

/-- 人手証明の本体。`(z - w) H_n(z, w) = z^n - w^n`
（`claim_qbar_power_difference_factorization`）。 -/
theorem qbarPowerDifferenceFactorization (z w : Qbar) (n : ℕ) :
    (z - w) * qbarPowDiffSum z w n = z ^ n - w ^ n := by
  induction n with
  | zero =>
      -- 出発点。H_0 = 0、0 との積が 0、z^0 = 1、w^0 = 1。
      calc (z - w) * qbarPowDiffSum z w 0
          = (z - w) * 0 := by rw [qbarPowDiffSum]
        _ = 0 := mul_zero _
        _ = 1 - 1 := (sub_self 1).symm
        _ = z ^ 0 - 1 := by rw [pow_zero]
        _ = z ^ 0 - w ^ 0 := by rw [pow_zero w]
  | succ n ih =>
      -- 一歩。人手証明の 11 段の鎖をそのまま書く。
      calc (z - w) * qbarPowDiffSum z w (n + 1)
          = (z - w) * (qbarPowDiffSum z w n * w + z ^ n) := by rw [qbarPowDiffSum]
        _ = (z - w) * (qbarPowDiffSum z w n * w) + (z - w) * z ^ n := mul_add _ _ _
        _ = ((z - w) * qbarPowDiffSum z w n) * w + (z - w) * z ^ n := by rw [mul_assoc]
        _ = (z ^ n - w ^ n) * w + (z - w) * z ^ n := by rw [ih]
        _ = (z ^ n * w - w ^ n * w) + (z - w) * z ^ n := by rw [sub_mul]
        _ = (z ^ n * w - w ^ (n + 1)) + (z - w) * z ^ n := by rw [← pow_succ]
        _ = (z ^ n * w - w ^ (n + 1)) + (z * z ^ n - w * z ^ n) := by rw [sub_mul]
        _ = (z ^ n * w - w ^ (n + 1)) + (z ^ (n + 1) - w * z ^ n) := by rw [← pow_succ']
        _ = (z ^ n * w - w ^ (n + 1)) + (z ^ (n + 1) - z ^ n * w) := by
            -- 可換則を使うのはこの 1 箇所だけである（必要十分版では `Commute z w` になる）。
            rw [mul_comm w (z ^ n)]
        _ = z ^ (n + 1) - w ^ (n + 1) := by ring

end Ising2DLambda.AlgebraicEigenvalue
