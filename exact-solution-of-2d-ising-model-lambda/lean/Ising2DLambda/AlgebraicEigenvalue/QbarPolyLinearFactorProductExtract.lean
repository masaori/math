/-
「一次因子の積から 1 つの因子を先頭へ取り出せる」の具体版。
人手証明の正本は `claim_qbar_poly_linear_factor_product_extract` である。

人手証明と同じく因子の個数 j について帰納する。一歩では取り出す番号が
最後の番号か否かで分け、最後なら交換則、それ以外なら帰納法の仮定と結合則を使う。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootPolynomialRemainingFactorValueNeZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial
open scoped BigOperators

theorem qbarPolyLinearFactorProductExtract (w : ℕ → Qbar) :
    ∀ j i : ℕ, i < j →
      ∃ B : QbarPoly,
        (∏ k ∈ Finset.range j, (Polynomial.X - qbarConst (w k)))
          = (Polynomial.X - qbarConst (w i)) * B := by
  intro j
  induction j with
  | zero =>
      intro i hi
      omega
  | succ j ih =>
      intro i hi
      by_cases hij : i = j
      · subst i
        refine ⟨∏ k ∈ Finset.range j, (Polynomial.X - qbarConst (w k)), ?_⟩
        rw [Finset.prod_range_succ, mul_comm]
      · have hil : i < j := by omega
        obtain ⟨B, hB⟩ := ih i hil
        refine ⟨B * (Polynomial.X - qbarConst (w j)), ?_⟩
        rw [Finset.prod_range_succ, hB, mul_assoc]

end Ising2DLambda.AlgebraicEigenvalue
