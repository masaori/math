/-
「正錐の非負係数条件どうしの和」の必要十分版。
型に環や全順序を要求せず、第一の組の二係数を零にする根拠だけを受け取る。
第二の組の非零性とその二係数の零への導出は、結論へ使わないため除く。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

theorem positive_add_nonnegative_necSuf
    {A : Type} (zero : A) (add : A → A → A) (le : A → A → Prop)
    (a b a' b' : A)
    (ha : le zero a) (hb : le zero b) (hap : le zero a') (hbp : le zero b')
    (hab : (a, b) ≠ (zero, zero))
    (hAddZero : ∀ x, add x zero = x)
    (hAddNonneg : ∀ x y, le zero x → le zero y → le zero (add x y))
    (hAddRight : ∀ x y, le zero y → le (add x zero) (add x y))
    (hAntisymm : ∀ x y, le x y → le y x → x = y) :
    le zero (add a a') ∧ le zero (add b b') ∧
      (add a a', add b b') ≠ (zero, zero) := by
  have hNonnegA : le zero (add a a') := hAddNonneg a a' ha hap
  have hNonnegB : le zero (add b b') := hAddNonneg b b' hb hbp
  refine ⟨hNonnegA, hNonnegB, ?_⟩
  intro hPair
  have hA : add a a' = zero := congrArg Prod.fst hPair
  have hB : add b b' = zero := congrArg Prod.snd hPair
  -- 各鎖は零元則・加法単調性・零和の代入の順であり、最後に反対称性を使う。
  have haZero : a = add a zero := (hAddZero a).symm
  have haLeSum : le (add a zero) (add a a') := hAddRight a a' hap
  have haNonpos : le a zero := by
    exact (congrArg₂ le haZero.symm hA).mp haLeSum
  have ha0 : a = zero := hAntisymm a zero haNonpos ha
  have hbZero : b = add b zero := (hAddZero b).symm
  have hbLeSum : le (add b zero) (add b b') := hAddRight b b' hbp
  have hbNonpos : le b zero := by
    exact (congrArg₂ le hbZero.symm hB).mp hbLeSum
  have hb0 : b = zero := hAntisymm b zero hbNonpos hb
  have hZeroPair : (a, b) = (zero, zero) := Prod.ext ha0 hb0
  exact hab hZeroPair

end Ising2DLambda.NecSuf.FisherZero
