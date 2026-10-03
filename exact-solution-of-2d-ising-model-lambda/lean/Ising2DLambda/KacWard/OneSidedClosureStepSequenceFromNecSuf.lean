/- 歩ベクトル列の具体版を、隣接対を読む写像の必要十分版から導く。 -/
import Ising2DLambda.KacWard.OneSidedClosureStepSequence
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureStepSequence

namespace Ising2DLambda.KacWard

open Ising2DLambda.NecSuf.KacWard

/-- 接合点で途切れない歩ベクトル列の四部分表示。 -/
theorem oneSidedClosure_stepSequence_from_necSuf
    (p q r s : ℕ → ℤ × ℤ) (a b c : ℕ)
    (_ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (h12 : p a = q 0) (h23 : q b = r 0) (h34 : r c = s b)
    (j : ℕ) (hj : j < a + 2 * b + c) :
    oneSidedPeriodicLiftClosure p q r s a b c (j + 1) -
        oneSidedPeriodicLiftClosure p q r s a b c j =
      joinDirectionSequence
        (joinDirectionSequence
          (joinDirectionSequence (fun i => p (i + 1) - p i)
            (fun i => q (i + 1) - q i) a)
          (fun i => r (i + 1) - r i) (a + b))
        (fun i => s (b - (i + 1)) - s (b - i)) (a + b + c) j := by
  -- 点の型を整数格子、隣接対の写像を終点から始点を引く写像へ特殊化する。
  have h := oneSidedClosure_stepSequence_necSuf
    (fun x y : ℤ × ℤ => y - x) p q r s a b c hb hc h12 h23 h34 j hj
  change oneSidedFourSegmentPath p q r s a b c (j + 1) -
    oneSidedFourSegmentPath p q r s a b c j = _
  exact h

end Ising2DLambda.KacWard
