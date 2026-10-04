/-
四部分の歩の置換を、一側閉包の循環隣接和へ移す必要十分版。
点と歩には構造を仮定しない。任意の二項写像で隣接点を読むだけでよい。
値の加法可換モノイドは有限和に必要であり、重みに交代性などは不要。
-/
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureStepSequence
import Ising2DLambda.NecSuf.KacWard.PlaneProjectionCyclicTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 各区間だけで一致する四列を、連結列の同じ区間で置換する。 -/
theorem fourPartSequence_congr_range {Y : Type*}
    (u v r x U V R X : ℕ → Y) (a b c d : ℕ)
    (hu : ∀ i < a, u i = U i) (hv : ∀ i < b, v i = V i)
    (hr : ∀ i < c, r i = R i) (hx : ∀ i < d, x i = X i)
    (j : ℕ) (hj : j < a + b + c + d) :
    joinDirectionSequence (joinDirectionSequence (joinDirectionSequence u v a) r (a + b))
        x (a + b + c) j =
      joinDirectionSequence (joinDirectionSequence (joinDirectionSequence U V a) R (a + b))
        X (a + b + c) j := by
  by_cases hja : j < a
  · simp only [joinDirectionSequence, if_pos (show j < a + b + c by omega),
      if_pos (show j < a + b by omega), if_pos hja, hu j hja]
  · by_cases hjab : j < a + b
    · simp only [joinDirectionSequence, if_pos (show j < a + b + c by omega),
        if_pos hjab, if_neg hja, hv (j - a) (by omega)]
    · by_cases hjabc : j < a + b + c
      · simp only [joinDirectionSequence, if_pos hjabc, if_neg hjab,
          hr (j - (a + b)) (by omega)]
      · simp only [joinDirectionSequence, if_neg hjabc,
          hx (j - (a + b + c)) (by omega)]

/-- 三接合の一致から四部分の歩を置換し、内部和と閉じ目へ代入する。 -/
theorem oneSidedClosure_cyclicAdjacentSum_necSuf {P Y M : Type*} [AddCommMonoid M]
    (step : P → P → Y) (weight : Y → Y → M)
    (p q r s : ℕ → P) (U V R X : ℕ → Y) (a b c : ℕ)
    (hb : 0 < b) (hc : 0 < c)
    (h12 : p a = q 0) (h23 : q b = r 0) (h34 : r c = s b)
    (hu : ∀ i < a, step (p i) (p (i + 1)) = U i)
    (hv : ∀ i < b, step (q i) (q (i + 1)) = V i)
    (hr : ∀ i < c, step (r i) (r (i + 1)) = R i)
    (hx : ∀ i < b, step (s (b - i)) (s (b - (i + 1))) = X i) :
    let W := oneSidedFourSegmentPath p q r s a b c
    let z := joinDirectionSequence
      (joinDirectionSequence (joinDirectionSequence U V a) R (a + b)) X (a + b + c)
    cyclicAdjacentSum weight (a + b + c + b) (fun j => step (W j) (W (j + 1))) =
      cyclicAdjacentSum weight (a + b + c + b) z := by
  dsimp only
  have hstep (j : ℕ) (hj : j < a + b + c + b) :=
    (oneSidedClosure_stepSequence_necSuf step p q r s a b c hb hc h12 h23 h34 j
      (by omega)).trans
      (fourPartSequence_congr_range _ _ _ _ U V R X a b c b hu hv hr hx j hj)
  unfold cyclicAdjacentSum
  apply congrArg₂ (· + ·)
  · apply Finset.sum_congr rfl
    intro j hj
    have hj' := Finset.mem_range.mp hj
    exact congrArg₂ weight (hstep j (by omega)) (hstep (j + 1) (by omega))
  · exact congrArg₂ weight (hstep (a + b + c + b - 1) (by omega)) (hstep 0 (by omega))

end Ising2DLambda.NecSuf.KacWard
