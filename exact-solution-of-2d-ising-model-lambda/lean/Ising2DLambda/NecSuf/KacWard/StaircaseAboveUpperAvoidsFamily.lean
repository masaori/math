/-
「整数帯の上端以上の基点からの反復横断階段は基点以外で周期持ち上げと交わらない」
の必要十分版。

格子・巻き付き・階段から切り離すと、必要なのは整数値座標を持つ二つの点族、階段の基点が
周期点族の上端以上にあること、階段の第 `s` 点が基点より `s` 以上高いことだけである。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 基点以上へ歩数分だけ上がる点族は、上端以下の点族と正の歩数では交わらない。 -/
theorem staircase_above_upper_avoids_family_necSuf
    {I X : Type*} (staircase : ℕ → X) (family : I → X) (coordinate : X → ℤ)
    (base : X) (upper : ℤ)
    (hbase : upper ≤ coordinate base)
    (hlower : ∀ s : ℕ, coordinate base + (s : ℤ) ≤ coordinate (staircase s))
    (hupper : ∀ i : I, coordinate (family i) ≤ upper)
    (s : ℕ) (hs : 1 ≤ s) (i : I) : staircase s ≠ family i := by
  intro heq
  have hstaircase := hlower s
  have hfamily := hupper i
  rw [heq] at hstaircase
  omega

end Ising2DLambda.NecSuf.KacWard
