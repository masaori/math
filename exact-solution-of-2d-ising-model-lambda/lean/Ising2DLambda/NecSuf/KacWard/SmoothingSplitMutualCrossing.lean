/-
「平滑化の混合横断数は二本の閉歩道の混合横断数に等しい」の必要十分版。

具体版 `Ising2DLambda.KacWard.splitMutualCrossingNumber_eq_closedWalkMutualCrossingNumber` と同じ手順
（二本の位置の対 `(i, j)` を添字の対 `(p_A(i), p_B(j))` へ送る全単射。二本の各位置は元の添字の辺で、
その後続は平滑化後の出辺であることから、位置対の横断は添字対の三条件に一致する）を、辺・格子・方向を
取り去って述べる。使う仮定は次の二つだけである。
- 平滑化後の各出辺が接続であること（`hexit`）。二本の混合横断は接続の条件を含むので
  （`straightCrossing`）、これを削ると添字対の三条件から位置対の横断へ戻れず、
  二本の混合横断数が平滑化の混合横断数以下であることしか言えない。
- `k < l`。二本の位置の写像の単射性と像（ブロック `A`・`B`）に使う。
直進の関係 `straight`、終点 `target`、軸 `axis` には何の性質も要らない。
-/
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitCrossingPartition

namespace Ising2DLambda.NecSuf.KacWard

variable {E V A : Type*} {m : ℕ}

/-- 二本の閉じた辺列の混合横断数（位置の対のうち、二つの通過が横断の関係にあるものの個数）。 -/
noncomputable def closedWalkMutualCrossingNumber {a b : ℕ}
    (cross : E → E → E → E → Prop) (δ : Fin (a + 1) → E) (η : Fin (b + 1) → E) : ℕ := by
  classical
  exact ((Finset.univ ×ˢ Finset.univ).filter fun p : Fin (a + 1) × Fin (b + 1) =>
    cross (δ p.1) (δ (cyclicSuccessor p.1)) (η p.2) (η (cyclicSuccessor p.2))).card

open Classical in
/-- `c_×(γ; k, l) = c_mut(γ_A, γ_B)`: 位置の対 `(i, j)` を `(p_A(i), p_B(j))` へ送る全単射。 -/
theorem splitMutualCrossingNumber_eq_closedWalkMutual_necSuf (Next : E → E → Prop)
    (γ : Fin (m + 1) → E) (target : E → V) (straight : E → E → Prop) (axis : E → A)
    {k l : Fin (m + 1)} (hexit : ∀ r, Next (γ r) (smoothedSuccessorEdge γ k l r)) (hkl : k < l) :
    closedWalkMutualCrossingNumber (straightCrossing Next target straight axis)
        (cyclicSegment γ (k.val + 1) (l.val - k.val - 1))
        (cyclicSegment γ (l.val + 1) (m - l.val + k.val)) =
      splitMutualCrossingNumber γ target straight axis k l := by
  unfold closedWalkMutualCrossingNumber splitMutualCrossingNumber
  apply Finset.card_bij (fun q _ => (splitIndexA k l q.1, splitIndexB k l q.2))
  · intro q hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hq
    rw [splitSegmentA_successor_necSuf γ hkl, splitSegmentB_successor_necSuf γ hkl] at hq
    obtain ⟨_, _, h1, h2, h3, h4⟩ := hq
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
    exact ⟨(splitIndexA_range_necSuf hkl _).2 ⟨_, rfl⟩, (splitIndexB_range_necSuf hkl _).2 ⟨_, rfl⟩,
      h1, h2, h3, h4⟩
  · intro q _ q' _ h
    simp only [Prod.mk.injEq] at h
    exact Prod.ext (splitIndexA_injective_necSuf hkl h.1) (splitIndexB_injective_necSuf hkl h.2)
  · intro r hr
    simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and] at hr
    obtain ⟨hrA, hsB, h1, h2, h3, h4⟩ := hr
    obtain ⟨i, hi⟩ := (splitIndexA_range_necSuf hkl r.1).1 hrA
    obtain ⟨j, hj⟩ := (splitIndexB_range_necSuf hkl r.2).1 hsB
    refine ⟨(i, j), ?_, ?_⟩
    · simp only [Finset.mem_filter, Finset.mem_product, Finset.mem_univ, true_and]
      rw [splitSegmentA_successor_necSuf γ hkl, splitSegmentB_successor_necSuf γ hkl]
      change straightCrossing Next target straight axis (γ (splitIndexA k l i)) _
        (γ (splitIndexB k l j)) _
      rw [hi, hj]
      exact ⟨hexit _, hexit _, h1, h2, h3, h4⟩
    · simp only [hi, hj]

end Ising2DLambda.NecSuf.KacWard
