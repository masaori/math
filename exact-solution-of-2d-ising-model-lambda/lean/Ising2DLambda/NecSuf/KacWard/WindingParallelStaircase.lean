/-
「平行階段の各歩は平行座標を増やす単位歩である」の必要十分版。

具体的な巻き付き数から切り離すと、二つの歩のどちらを先に並べるかという場合分け、
二つの有限な歩数、各歩を正へ送る加法準同型だけが必要である。
-/
import Ising2DLambda.NecSuf.KacWard.WindingTransverseStaircase

namespace Ising2DLambda.NecSuf.KacWard

/-- 二つの歩を、命題 `firstBeforeSecond` が真なら第一・第二、偽なら第二・第一の順に並べる。 -/
def orderedTwoPhaseStaircase {G : Type*} [AddCommGroup G]
    (firstBeforeSecond : Prop) [Decidable firstBeforeSecond]
    (H V : ℕ) (firstStep secondStep : G) (s : ℕ) : G :=
  if firstBeforeSecond then
    twoPhaseStaircase H firstStep secondStep s
  else
    twoPhaseStaircase V secondStep firstStep s

/-- 順序を場合分けした二段階階段でも、隣接差は該当する一歩で、座標は真に増える。 -/
theorem orderedTwoPhaseStaircase_step_necSuf
    {G A : Type*} [AddCommGroup G] [AddCommGroup A] [LinearOrder A] [IsOrderedAddMonoid A]
    (firstBeforeSecond : Prop) [Decidable firstBeforeSecond]
    (H V : ℕ) (firstStep secondStep : G) (coordinate : G →+ A)
    (hfirst : 0 < H → 0 < coordinate firstStep)
    (hsecond : 0 < V → 0 < coordinate secondStep)
    (s : ℕ) (hs : s < H + V) :
    (orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep (s + 1) -
        orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep s =
      if firstBeforeSecond then (if s < H then firstStep else secondStep)
      else (if s < V then secondStep else firstStep)) ∧
    coordinate (orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep s) <
      coordinate (orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep (s + 1)) := by
  by_cases horder : firstBeforeSecond
  · simpa [orderedTwoPhaseStaircase, horder] using
      (twoPhaseStaircase_step_necSuf H V firstStep secondStep coordinate
        hfirst hsecond s hs)
  · have hs' : s < V + H := by omega
    simpa [orderedTwoPhaseStaircase, horder] using
      (twoPhaseStaircase_step_necSuf V H secondStep firstStep coordinate
        hsecond hfirst s hs')

/-- 正の座標増分を持つ順序付き二段階階段は、終点まで単射である。 -/
theorem orderedTwoPhaseStaircase_injOn_necSuf
    {G A : Type*} [AddCommGroup G] [AddCommGroup A] [LinearOrder A] [IsOrderedAddMonoid A]
    (firstBeforeSecond : Prop) [Decidable firstBeforeSecond]
    (H V : ℕ) (firstStep secondStep : G) (coordinate : G →+ A)
    (hfirst : 0 < H → 0 < coordinate firstStep)
    (hsecond : 0 < V → 0 < coordinate secondStep) :
    Set.InjOn (orderedTwoPhaseStaircase firstBeforeSecond H V firstStep secondStep)
      (Set.Iic (H + V)) := by
  by_cases horder : firstBeforeSecond
  · intro s hs t ht heq
    apply (twoPhaseStaircase_injOn_necSuf H V firstStep secondStep coordinate
      hfirst hsecond) hs ht
    simpa [orderedTwoPhaseStaircase, horder] using heq
  · intro s hs t ht heq
    apply (twoPhaseStaircase_injOn_necSuf V H secondStep firstStep coordinate
      hsecond hfirst)
    · simpa [Nat.add_comm] using hs
    · simpa [Nat.add_comm] using ht
    · simpa [orderedTwoPhaseStaircase, horder] using heq

end Ising2DLambda.NecSuf.KacWard
