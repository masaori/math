/-
章「固有値の代数性」の「不定元と定数の冪の差は、その 2 元の差を因子に持つ」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_poly_power_difference_factorization`）と
定義 2 件（`def_qbar_polynomial_ring`・`def_qbar_constant_embedding`）に対応する。

  人手証明                                          このファイル
  Qbar[t]（代数的数を係数とする 1 変数多項式）      `QbarPoly`
  定数として送る写像 a ↦ â                          `qbarConst`
  K_0(w) = 0、K_{n+1} = K_n ŵ + t^n                 `qbarPolyPowDiffSum`
  準備（t t^k = t^k t。結合則と単位元だけ）          `pow_succ'`（下の第 8 の等号で使う）
  出発点（K_0 = 0、t^0 = ŵ^0 = 1）                   `Nat.zero` の場合
  一歩の第 1 の等号（K_{n+1} の約束）                `qbarPolyPowDiffSum` の展開
  一歩の第 2・第 5・第 7 の等号（分配則）            `mul_add` / `sub_mul`
  一歩の第 3 の等号（積の結合則）                    `mul_assoc`
  一歩の第 4 の等号（帰納法の仮定）                  `ih`
  一歩の第 6 の等号（ŵ^{n+1} = ŵ^n ŵ）              `pow_succ`
  一歩の第 8・第 9 の等号（t t^n = t^n t = t^{n+1}） `pow_succ'`（人手証明では準備の等式を引く）
  一歩の第 10 の等号（ŵ t^n = t^n ŵ）               `mul_comm`
  一歩の第 11 の等号（t^n ŵ が相殺する）             加法群の計算

人手証明が `Qbar` の 2 元について書いた同じ鎖を、住む環を `QbarPoly` へ変えて
もう一度書いたものである（人手証明を一般の環へ持ち上げない規則による。
持ち上げるのは必要十分版だけで、そこでは 2 つは同じ 1 本の定理の別々の特殊化になる）。
mathlib の `sub_dvd_pow_sub_pow` 等の既製定理へは委ねない。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPowerDifferenceFactorization
import Mathlib.Algebra.Polynomial.Basic

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の `Qbar[t]`（`def_qbar_polynomial_ring`）。 -/
noncomputable abbrev QbarPoly := Polynomial Qbar

/-- 人手証明の `â`（`def_qbar_constant_embedding`。定数多項式として送る写像）。 -/
noncomputable def qbarConst (a : Qbar) : QbarPoly := Polynomial.C a

/-- 人手証明の `K_n(w)`（`K_0 = 0`、`K_{n+1} = K_n ŵ + t^n`）。 -/
noncomputable def qbarPolyPowDiffSum (w : Qbar) : ℕ → QbarPoly
  | 0 => 0
  | n + 1 => qbarPolyPowDiffSum w n * qbarConst w + Polynomial.X ^ n

/-- 人手証明の本体。`(t - ŵ) K_n(w) = t^n - ŵ^n`
（`claim_qbar_poly_power_difference_factorization`）。 -/
theorem qbarPolyPowerDifferenceFactorization (w : Qbar) (n : ℕ) :
    (Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w n
      = Polynomial.X ^ n - qbarConst w ^ n := by
  induction n with
  | zero =>
      -- 出発点。K_0 = 0、0 との積が 0、t^0 = 1、ŵ^0 = 1。
      calc (Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w 0
          = (Polynomial.X - qbarConst w) * 0 := by rw [qbarPolyPowDiffSum]
        _ = 0 := mul_zero _
        _ = 1 - 1 := (sub_self 1).symm
        _ = (Polynomial.X : QbarPoly) ^ 0 - 1 := by rw [pow_zero]
        _ = (Polynomial.X : QbarPoly) ^ 0 - qbarConst w ^ 0 := by rw [pow_zero (qbarConst w)]
  | succ n ih =>
      -- 一歩。人手証明の 11 段の鎖をそのまま書く。
      calc (Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w (n + 1)
          = (Polynomial.X - qbarConst w)
              * (qbarPolyPowDiffSum w n * qbarConst w + Polynomial.X ^ n) := by
            rw [qbarPolyPowDiffSum]
        _ = (Polynomial.X - qbarConst w) * (qbarPolyPowDiffSum w n * qbarConst w)
              + (Polynomial.X - qbarConst w) * Polynomial.X ^ n := mul_add _ _ _
        _ = ((Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w n) * qbarConst w
              + (Polynomial.X - qbarConst w) * Polynomial.X ^ n := by rw [mul_assoc]
        _ = (Polynomial.X ^ n - qbarConst w ^ n) * qbarConst w
              + (Polynomial.X - qbarConst w) * Polynomial.X ^ n := by rw [ih]
        _ = (Polynomial.X ^ n * qbarConst w - qbarConst w ^ n * qbarConst w)
              + (Polynomial.X - qbarConst w) * Polynomial.X ^ n := by rw [sub_mul]
        _ = (Polynomial.X ^ n * qbarConst w - qbarConst w ^ (n + 1))
              + (Polynomial.X - qbarConst w) * Polynomial.X ^ n := by rw [← pow_succ]
        _ = (Polynomial.X ^ n * qbarConst w - qbarConst w ^ (n + 1))
              + (Polynomial.X * Polynomial.X ^ n - qbarConst w * Polynomial.X ^ n) := by
            rw [sub_mul]
        _ = (Polynomial.X ^ n * qbarConst w - qbarConst w ^ (n + 1))
              + ((Polynomial.X : QbarPoly) ^ (n + 1) - qbarConst w * Polynomial.X ^ n) := by
            rw [← pow_succ']
        _ = (Polynomial.X ^ n * qbarConst w - qbarConst w ^ (n + 1))
              + ((Polynomial.X : QbarPoly) ^ (n + 1) - Polynomial.X ^ n * qbarConst w) := by
            -- 係数どうしの積が可換なので、多項式どうしの積も可換である。
            rw [mul_comm (qbarConst w) (Polynomial.X ^ n)]
        _ = (Polynomial.X : QbarPoly) ^ (n + 1) - qbarConst w ^ (n + 1) := by ring

end Ising2DLambda.AlgebraicEigenvalue
