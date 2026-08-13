/-
「正錐の非負係数条件どうしの積」の必要十分版。
四つの正座標の組に応じて、積の第一座標または第二座標が正になることだけを要求する。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_mul_nonnegative_necSuf
    {A : Type} (zero : A) (le lt : A → A → Prop)
    (a b a' b' first second : A)
    (hFirstNonneg : le zero first) (hSecondNonneg : le zero second)
    (hLeftPositive : lt zero a ∨ lt zero b)
    (hRightPositive : lt zero a' ∨ lt zero b')
    (hFirstAA : lt zero a → lt zero a' → lt zero first)
    (hSecondAB : lt zero a → lt zero b' → lt zero second)
    (hSecondBA : lt zero b → lt zero a' → lt zero second)
    (hFirstBB : lt zero b → lt zero b' → lt zero first)
    (hPositiveNeZero : ∀ x, lt zero x → x ≠ zero) :
    le zero first ∧ le zero second ∧ (first, second) ≠ (zero, zero) := by
  refine ⟨hFirstNonneg, hSecondNonneg, ?_⟩
  intro hPair
  have hFirstZero : first = zero := congrArg Prod.fst hPair
  have hSecondZero : second = zero := congrArg Prod.snd hPair
  rcases hLeftPositive with ha | hb <;> rcases hRightPositive with hap | hbp
  · exact (hPositiveNeZero first (hFirstAA ha hap)) hFirstZero
  · exact (hPositiveNeZero second (hSecondAB ha hbp)) hSecondZero
  · exact (hPositiveNeZero second (hSecondBA hb hap)) hSecondZero
  · exact (hPositiveNeZero first (hFirstBB hb hbp)) hFirstZero

end Ising2DLambda.NecSuf.FisherZero
