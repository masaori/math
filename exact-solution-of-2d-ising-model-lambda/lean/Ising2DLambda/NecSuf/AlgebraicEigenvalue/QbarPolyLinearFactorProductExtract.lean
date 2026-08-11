/-
「有限積から指定した 1 つの因子を先頭へ取り出せる」の必要十分版。

具体版と同じ帰納法に必要なのは、空積と有限積を書くための単位元、
積の結合則、指定因子が最後にある場合に使う交換則だけである。
したがって可換モノイドで足り、加法・分配則・体・代数閉性は要らない。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open scoped BigOperators

theorem linear_factor_product_extract_necSuf {M : Type*} [CommMonoid M] (a : ℕ → M) :
    ∀ j i : ℕ, i < j → ∃ B : M, (∏ k ∈ Finset.range j, a k) = a i * B := by
  intro j
  induction j with
  | zero =>
      intro i hi
      omega
  | succ j ih =>
      intro i hi
      by_cases hij : i = j
      · subst i
        refine ⟨∏ k ∈ Finset.range j, a k, ?_⟩
        rw [Finset.prod_range_succ, mul_comm]
      · have hil : i < j := by omega
        obtain ⟨B, hB⟩ := ih i hil
        refine ⟨B * a j, ?_⟩
        rw [Finset.prod_range_succ, hB, mul_assoc]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
