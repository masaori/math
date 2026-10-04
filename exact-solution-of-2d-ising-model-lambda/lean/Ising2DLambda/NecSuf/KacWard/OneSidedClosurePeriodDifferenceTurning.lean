/-
射影、実際の歩、固定四部分列の順に、周期数差の計算を合成する。
列の値には構造を要求しない。和と差の値に可換加法群だけを使う。
中間の同定は独立に示された補題の受け口であり、周期数差を仮定しない。
-/
import Ising2DLambda.NecSuf.KacWard.FourPartRepeatedDifference
import Ising2DLambda.NecSuf.KacWard.PlaneProjectionCyclicTurning

namespace Ising2DLambda.NecSuf.KacWard

/-- 有限区間内の一致だけを、内部和と閉じ目へ移す。 -/
theorem cyclicAdjacentSum_congr_range {α M : Type*} [AddCommMonoid M]
    (weight : α → α → M) (n : ℕ) (hn : 0 < n) (u v : ℕ → α)
    (h : ∀ j < n, u j = v j) :
    cyclicAdjacentSum weight n u = cyclicAdjacentSum weight n v := by
  apply cyclicAdjacentSum_transport_necSuf weight weight u v n
  · intro j hj
    rw [h j (by omega), h (j + 1) (by omega)]
  · rw [h (n - 1) (by omega), h 0 hn]

/-- 四部分列の増分を元周期の和と戻り周期の零へ順に置換する。 -/
theorem oneSidedClosure_periodDifferenceTurning_necSuf
    {α M : Type*} [AddCommGroup M] (weight : α → α → M)
    (u v r x : ℕ → α) (T C : ℕ → M) (original : M)
    (m b n c : ℕ) (hm : 0 < m) (hb : 0 < b) (hn : 0 < n) (hc : 0 < c)
    (hprojection : ∀ k, 0 < k → T k = C k)
    (hword : ∀ k, 0 < k → C k =
      cyclicAdjacentSum weight (k * m + b + k * n + b)
        (joinDirectionSequence
          (joinDirectionSequence
            (joinDirectionSequence (repeatDirectionSequence u m) v (k * m))
            (repeatDirectionSequence r n) (k * m + b)) x (k * m + b + k * n)))
    (hperiod : cyclicAdjacentSum weight m u = original)
    (hreturn : cyclicAdjacentSum weight n r = 0) :
    T (c + 1) - T c = original := by
  let z := fun k => joinDirectionSequence
    (joinDirectionSequence
      (joinDirectionSequence (repeatDirectionSequence u m) v (k * m))
      (repeatDirectionSequence r n) (k * m + b)) x (k * m + b + k * n)
  let N := fun k => k * m + b + k * n + b
  calc
    T (c + 1) - T c = C (c + 1) - T c := by rw [hprojection (c + 1) (by omega)]
    _ = C (c + 1) - C c := by rw [hprojection c hc]
    _ = cyclicAdjacentSum weight (N (c + 1)) (z (c + 1)) - C c := by
      rw [hword (c + 1) (by omega)]
    _ = cyclicAdjacentSum weight (N (c + 1)) (z (c + 1)) -
        cyclicAdjacentSum weight (N c) (z c) := by rw [hword c hc]
    _ = cyclicAdjacentSum weight m u + cyclicAdjacentSum weight n r :=
      fourPartRepeated_cyclicAdjacentSum_difference_necSuf weight u v r x
        m b n b c hm hb hn hb hc
    _ = original + cyclicAdjacentSum weight n r := by rw [hperiod]
    _ = original + 0 := by rw [hreturn]
    _ = original := add_zero original

end Ising2DLambda.NecSuf.KacWard
