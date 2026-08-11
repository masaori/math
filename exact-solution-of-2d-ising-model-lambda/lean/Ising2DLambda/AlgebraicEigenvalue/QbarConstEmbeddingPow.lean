/-
章「固有値の代数性」の「定数として送る写像は冪を冪へ写す」の
具体版（人手証明と 1 対 1 に対応させる）。

人手証明の正本は `structured-latex/content/main-text.ts`。このファイルは
主張 1 件（`claim_qbar_constant_embedding_pow`）に対応する。

  人手証明                                          このファイル
  出発点の第 1 の等号（w^0 = 1）                     `pow_zero`
  出発点の第 2 の等号（(1)^ = 1）                    `Polynomial.C_1`
  出発点の第 3 の等号（((w)^)^0 = 1）                `pow_zero`
  一歩の第 1 の等号（w^{n+1} = w^n w）               `pow_succ`
  一歩の第 2 の等号（(a b)^ = (a)^ (b)^）            `Polynomial.C_mul`
  一歩の第 3 の等号（帰納法の仮定）                   `ih`
  一歩の第 4 の等号（((w)^)^{n+1} = ((w)^)^n (w)^）  `pow_succ`

mathlib の `map_pow`（主張そのもの）へは委ねず、帰納法を自分で書く。
左右の冪は住む環（`Qbar` と `QbarPoly`）が違う別々の約束であり、
この等式は約束からは出ない。

住処: 人手証明のこのブロックは Qbar を宣言している。
ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、指数は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyPowerDifferenceFactorization

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の本体。`(w^n)^ = ((w)^)^n`（`claim_qbar_constant_embedding_pow`）。 -/
theorem qbarConstEmbeddingPow (w : Qbar) (n : ℕ) :
    qbarConst (w ^ n) = qbarConst w ^ n := by
  unfold qbarConst
  induction n with
  | zero =>
      -- 出発点。w^0 = 1、(1)^ = 1、((w)^)^0 = 1。
      calc (Polynomial.C (w ^ 0) : QbarPoly)
          = Polynomial.C (1 : Qbar) := by rw [pow_zero]
        _ = 1 := Polynomial.C_1
        _ = (Polynomial.C w : QbarPoly) ^ 0 := (pow_zero _).symm
  | succ n ih =>
      -- 一歩。w^{n+1} = w^n w、積を保つこと、帰納法の仮定、((w)^)^{n+1} = ((w)^)^n (w)^。
      calc (Polynomial.C (w ^ (n + 1)) : QbarPoly)
          = Polynomial.C (w ^ n * w) := by rw [pow_succ]
        _ = Polynomial.C (w ^ n) * Polynomial.C w := Polynomial.C_mul
        _ = (Polynomial.C w : QbarPoly) ^ n * Polynomial.C w := by rw [ih]
        _ = (Polynomial.C w : QbarPoly) ^ (n + 1) := (pow_succ _ _).symm

end Ising2DLambda.AlgebraicEigenvalue
