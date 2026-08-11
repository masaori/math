/-
「一次因子の積から 1 つの因子を先頭へ取り出せる」の具体版。
人手証明の正本は `claim_qbar_poly_linear_factor_product_extract` である。

人手証明と同じく因子の個数 j について帰納する。一歩では取り出す番号が
最後の番号か否かで分け、最後なら交換則と一次因子の積の係数上界
（`qbarPolyLinearFactorProductCoeffBound`）、それ以外なら帰納法の仮定と結合則、
および一次因子との積の係数上界（`qbarPolyLinearFactorCoeffBound`）を使う。
取り出した残りの因子 B は係数上界 j - 1 つきに取れる（r3 での強化）。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialRemainingFactorValueNeZero
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyLinearFactorProductCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

theorem qbarPolyLinearFactorProductExtract (w : ℕ → Qbar) :
    ∀ j i : ℕ, i < j →
      ∃ B : QbarPoly,
        (∏ k ∈ Finset.range j, (Polynomial.X - qbarConst (w k)))
          = (Polynomial.X - qbarConst (w i)) * B ∧
        ∀ l : ℕ, j - 1 < l → B.coeff l = 0 := by
  intro j
  induction j with
  | zero =>
      intro i hi
      omega
  | succ j ih =>
      intro i hi
      by_cases hij : i = j
      · -- 場合 i = j: 最後の因子を交換則で先頭へ移す。
        -- 残りは j 個の一次因子の積なので、係数は番号 j で尽きる（r2）。
        subst i
        refine ⟨∏ k ∈ Finset.range j, (Polynomial.X - qbarConst (w k)), ?_, ?_⟩
        · rw [Finset.prod_range_succ, mul_comm]
        · intro l hl
          exact qbarPolyLinearFactorProductCoeffBound w j l (by omega)
      · -- 場合 i ≠ j: 帰納法の仮定で j 個の積から取り出し、最後の因子を掛ける。
        -- 係数上界は可換則と一次因子との積の係数上界（d4b2a）で 1 つ上がる。
        have hil : i < j := by omega
        obtain ⟨A, hA, hAbound⟩ := ih i hil
        refine ⟨A * (Polynomial.X - qbarConst (w j)), ?_, ?_⟩
        · rw [Finset.prod_range_succ, hA, mul_assoc]
        · intro l hl
          rw [mul_comm]
          exact qbarPolyLinearFactorCoeffBound (w j) A (j - 1) hAbound l (by omega)

end Ising2DLambda.AlgebraicEigenvalue
