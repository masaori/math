/-
「有限積から指定した 1 つの因子を、係数上界つきの残りの因子とともに
先頭へ取り出せる」の必要十分版。

具体版と同じ帰納法に必要なのは次の 4 つだけである。
- 空積と有限積を書くための単位元と、積の結合則・交換則（可換モノイド）。
- 上界の述語 bound（中身は問わない。多項式の係数であることを使わない）。
- 有限積そのものが因子の個数を上界に持つこと（hprod。具体版では r2 が供給する）。
- 因子を 1 つ左から掛けると上界が 1 つ上がること（hstep。具体版では d4b2a が供給する）。
加法・分配則・体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped BigOperators

theorem linear_factor_product_extract_necSuf {M : Type*} [CommMonoid M]
    (a : ℕ → M) (bound : M → ℕ → Prop)
    (hprod : ∀ m : ℕ, bound (∏ k ∈ Finset.range m, a k) m)
    (hstep : ∀ (C : M) (m n : ℕ), bound C m → bound (a n * C) (m + 1)) :
    ∀ j i : ℕ, i < j →
      ∃ B : M, (∏ k ∈ Finset.range j, a k) = a i * B ∧ bound B (j - 1) := by
  intro j
  induction j with
  | zero =>
      intro i hi
      omega
  | succ j ih =>
      intro i hi
      by_cases hij : i = j
      · -- 場合 i = j: 交換則と、有限積そのものの上界（hprod）。
        subst i
        refine ⟨∏ k ∈ Finset.range j, a k, ?_, ?_⟩
        · rw [Finset.prod_range_succ, mul_comm]
        · exact hprod j
      · -- 場合 i ≠ j: 帰納法の仮定・結合則と、因子を掛ける一歩（hstep）・交換則。
        have hil : i < j := by omega
        obtain ⟨A, hA, hAbound⟩ := ih i hil
        refine ⟨A * a j, ?_, ?_⟩
        · rw [Finset.prod_range_succ, hA, mul_assoc]
        · have h := hstep A (j - 1) j hAbound
          have hj : j - 1 + 1 = j := by omega
          rw [hj, mul_comm (a j) A] at h
          exact h

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
