/-
「横断階段の各歩は横断水準を増やす単位歩である」の必要十分版。

具体的な整数格子から切り離すと、二つの歩を順に繰り返す有限列と、各歩を正へ送る
加法準同型だけが必要である。同じ隣接差の計算から座標の真の増加と単射性を得る。
-/
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 最初の `H` 歩を `firstStep`、続く歩を `secondStep` とする二段階の階段。 -/
def twoPhaseStaircase {G : Type*} [AddCommGroup G]
    (H : ℕ) (firstStep secondStep : G) (s : ℕ) : G :=
  if s ≤ H then s • firstStep else H • firstStep + (s - H) • secondStep

/-- 二段階の階段の隣接差は、その位置の歩に等しく、正の座標増分を持つ。 -/
theorem twoPhaseStaircase_step_necSuf
    {G A : Type*} [AddCommGroup G] [AddCommGroup A] [LinearOrder A] [IsOrderedAddMonoid A]
    (H V : ℕ) (firstStep secondStep : G) (coordinate : G →+ A)
    (hfirst : 0 < H → 0 < coordinate firstStep)
    (hsecond : 0 < V → 0 < coordinate secondStep)
    (s : ℕ) (hs : s < H + V) :
    (twoPhaseStaircase H firstStep secondStep (s + 1) -
        twoPhaseStaircase H firstStep secondStep s =
      if s < H then firstStep else secondStep) ∧
    coordinate (twoPhaseStaircase H firstStep secondStep s) <
      coordinate (twoPhaseStaircase H firstStep secondStep (s + 1)) := by
  by_cases hphase : s < H
  · have hsle : s ≤ H := Nat.le_of_lt hphase
    have hsuccle : s + 1 ≤ H := by omega
    have hH : 0 < H := by omega
    simp only [twoPhaseStaircase, if_pos hsle, if_pos hsuccle, if_pos hphase]
    constructor
    · simp [add_nsmul]
    · rw [map_nsmul, map_nsmul]
      simpa [add_nsmul] using add_lt_add_left (hfirst hH) (s • coordinate firstStep)
  · have hsge : H ≤ s := by omega
    have hsuccgt : ¬s + 1 ≤ H := by omega
    have hV : 0 < V := by omega
    simp only [twoPhaseStaircase, if_neg hsuccgt, if_neg hphase]
    by_cases heq : s = H
    · subst s
      simp only [le_refl, if_pos, Nat.add_sub_cancel_left]
      constructor
      · simp
      · rw [map_nsmul, map_add, map_nsmul]
        simp only [one_nsmul]
        exact lt_add_of_pos_right _ (hsecond hV)
    · have hsnotle : ¬s ≤ H := by omega
      simp only [if_neg hsnotle]
      have hsub : s + 1 - H = (s - H) + 1 := by omega
      constructor
      · rw [hsub, add_nsmul]
        simp
      · rw [map_add, map_add, map_nsmul, map_nsmul]
        rw [hsub, add_nsmul]
        simp only [map_add, map_nsmul, one_nsmul]
        simpa [add_assoc] using
          (lt_add_of_pos_right
            (H • coordinate firstStep + (s - H) • coordinate secondStep)
            (hsecond hV))

/-- 正の座標増分を持つ二段階の階段は、終点まで単射である。 -/
theorem twoPhaseStaircase_injOn_necSuf
    {G A : Type*} [AddCommGroup G] [AddCommGroup A] [LinearOrder A] [IsOrderedAddMonoid A]
    (H V : ℕ) (firstStep secondStep : G) (coordinate : G →+ A)
    (hfirst : 0 < H → 0 < coordinate firstStep)
    (hsecond : 0 < V → 0 < coordinate secondStep) :
    Set.InjOn (twoPhaseStaircase H firstStep secondStep) (Set.Iic (H + V)) := by
  have hstrict : StrictMonoOn
      (fun s => coordinate (twoPhaseStaircase H firstStep secondStep s))
      (Set.Iic (H + V)) := by
    apply strictMonoOn_of_lt_succ Set.ordConnected_Iic
    intro s _ _ hsnext
    exact (twoPhaseStaircase_step_necSuf H V firstStep secondStep coordinate
      hfirst hsecond s (Nat.lt_of_succ_le hsnext)).2
  intro s hs t ht heq
  apply hstrict.injOn hs ht
  exact congrArg coordinate heq

end Ising2DLambda.NecSuf.KacWard
