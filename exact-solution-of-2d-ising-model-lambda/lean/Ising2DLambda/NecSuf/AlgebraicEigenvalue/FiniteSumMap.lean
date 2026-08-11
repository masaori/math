/-
「多項式の値は係数の有限和で書ける」の鎖の第 2 の等号（写像を有限和へ繰り返し当てること）の
必要十分版。

主張: 零元を保ち 2 項の和を保つ写像は、範囲にわたる有限和を有限和へ写す。

仮定が「具体版の証明が実際に使っている性質」だけであることの検査:
- 値の側に要るのは可換な加法モノイドだけである（積も、積の単位元も、冪も要らない）。
  可換性と結合則は Finset の和がそもそも定義される（並べ方に依らない）ために要るのであって、
  この証明の各段が明示的に使うのは `Finset.sum_range_succ` の一歩の切り出しだけである。
- 写像に要るのは、零元を保つこと（出発点）と 2 項の和を保つこと（一歩）の 2 つだけである。
  積を保つことも単位元を保つことも要らない。単射性も全射性も要らない。
- 添字は `Finset.range` で走る自然数だけを使う。一般の有限集合にわたる和は要らない
  （具体版の和が 0 から n まででしか走らないため。一般化はしない）。

具体版（`qbarPolyEvalCoefficientSum`）は M = Qbar[t]、N = Qbar、φ = aev_w への特殊化として
得られる（`QbarPolyEvalCoefficientSumFromNecSuf.lean`）。

住処: ここに ℝ / ℂ は現れない。
-/
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 零元を保ち 2 項の和を保つ写像は、範囲にわたる有限和を有限和へ写す。
証明は和の長さ `m` についての帰納法である（人手証明の「有限和へ繰り返し当てる」）。
mathlib の `map_sum`（主張そのもの）へは委ねない。 -/
theorem finite_sum_map_necSuf {M N : Type*} [AddCommMonoid M] [AddCommMonoid N]
    (φ : M → N) (h0 : φ 0 = 0)
    (hadd : ∀ a b : M, φ (a + b) = φ a + φ b)
    (g : ℕ → M) (m : ℕ) :
    φ (∑ k ∈ Finset.range m, g k) = ∑ k ∈ Finset.range m, φ (g k) := by
  induction m with
  | zero =>
      -- 出発点。空の和は零元であり、φ は零元を保つ。
      simp only [Finset.range_zero, Finset.sum_empty]
      exact h0
  | succ m ih =>
      -- 一歩。最後の項を切り出し（sum_range_succ）、φ が 2 項の和を保つことと
      -- 帰納法の仮定を当ててから、切り出した形へ戻す。
      rw [Finset.sum_range_succ, hadd, ih, Finset.sum_range_succ]

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
