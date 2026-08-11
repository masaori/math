/-
章「固有値の代数性」の「不定元の冪の係数は、番号が指数と一致するときだけ単位元である」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_poly_indeterminate_power_coefficient`）に対応する。

  人手証明                                          このファイル
  ac_j(f)（Qbar[t] の係数）                         `Polynomial.coeff`
  ac_1(t) = 1、j ≠ 1 で ac_j(t) = 0                 `Polynomial.coeff_X`
  出発点（t^0 = 1 と ac_j(1)）                      `pow_zero` と `Polynomial.coeff_one`
  一歩の第 1 の等号（冪の約束 t^{k+1} = t^k t）      `pow_succ`
  場合 1（j = 0）の第 2 から第 5 の等号             `qbarPolyCoeffMulXZero`
  場合 2（j = j'+1）の第 2 から第 9 の等号          `qbarPolyCoeffMulXSucc`
  場合 2 の第 10 の等号（帰納法の仮定）             `ih`
  後者の単射性（j' = k ⟺ j'+1 = k+1）               `Nat.succ_inj`

`Polynomial.coeff_X_pow`（主張そのものにあたる mathlib の既製定理）へは委ねない。
場合分けと帰納法は人手証明のとおりに書く。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

/-- 人手証明の一歩の場合 1（`j = 0`）にあたる段。
積の係数の定義（和は `i = 0` の 1 項だけ）と `ac_0(t) = 0`。 -/
theorem qbarPolyCoeffMulXZero (p : QbarPoly) : (p * Polynomial.X).coeff 0 = 0 := by
  rw [Polynomial.mul_coeff_zero, Polynomial.coeff_X_zero, mul_zero]

/-- 人手証明の一歩の場合 2（`j = j'+1`）にあたる段。
積の係数の定義から `i = j'` の項を取り出し、他の項が零であることを使う。 -/
theorem qbarPolyCoeffMulXSucc (p : QbarPoly) (j : ℕ) :
    (p * Polynomial.X).coeff (j + 1) = p.coeff j := by
  -- 第 2 の等号（積の係数の定義）。
  rw [Polynomial.coeff_mul]
  -- 第 3 から第 7 の等号（i = j' の項を取り出し、他の項が零であることを使う）。
  rw [Finset.sum_eq_single ((j, 1) : ℕ × ℕ)]
  · -- 第 8・第 9 の等号（ac_1(t) = 1 と積の単位元）。
    simp
  · intro b hb hne
    have hb' : b.1 + b.2 = j + 1 := Finset.mem_antidiagonal.mp hb
    have hne2 : b.2 ≠ 1 := by
      intro h
      apply hne
      have : b.1 = j := by omega
      exact Prod.ext this h
    simp only [Polynomial.coeff_X, if_neg (fun h : (1 : ℕ) = b.2 => hne2 h.symm), mul_zero]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : j + 1 = j + 1)) h

/-- 人手証明の本体。`ac_j(t^k)` は `j = k` のとき `1`、そうでないとき `0`
（`claim_qbar_poly_indeterminate_power_coefficient`）。 -/
theorem qbarPolyIndeterminatePowerCoefficient (k j : ℕ) :
    ((Polynomial.X : QbarPoly) ^ k).coeff j = if j = k then 1 else 0 := by
  induction k generalizing j with
  | zero =>
      -- 出発点。t^0 = 1 と、1 の係数。
      rw [pow_zero, Polynomial.coeff_one]
  | succ k ih =>
      -- 一歩。第 1 の等号（t^{k+1} = t^k t）のあと j で場合分けする。
      rw [pow_succ]
      match j with
      | 0 =>
          -- 場合 1（j = 0）。0 ≠ k + 1 なので右辺も零元。
          rw [qbarPolyCoeffMulXZero]
          simp
      | j + 1 =>
          -- 場合 2（j = j'+1）。落としてから帰納法の仮定を入れる。
          rw [qbarPolyCoeffMulXSucc, ih]
          -- j' = k と j'+1 = k+1 は同値（後者の単射性）。
          simp

end Ising2DLambda.AlgebraicEigenvalue
