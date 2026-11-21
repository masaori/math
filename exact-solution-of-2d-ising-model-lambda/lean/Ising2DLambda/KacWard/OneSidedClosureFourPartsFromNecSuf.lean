/-
四部分の有限列の具体版（`KacWard/OneSidedClosureFourParts.lean`）が、必要十分版の同名の定義を
値の型 `ℤ × ℤ` に特殊化したものに一致することの記録。導出（`*_from_necSuf`）だけが使う。
-/
import Ising2DLambda.KacWard.OneSidedClosureFourParts
import Ising2DLambda.NecSuf.KacWard.OneSidedPeriodicLiftClosure
import Ising2DLambda.NecSuf.KacWard.PeriodicLiftClosureFromWalk
import Ising2DLambda.NecSuf.KacWard.OneSidedClosureJunctions

namespace Ising2DLambda.KacWard

theorem oneSidedFourSegmentPath_eq_necSuf (first second third fourth : ℕ → ℤ × ℤ)
    (a b c : ℕ) :
    oneSidedFourSegmentPath first second third fourth a b c =
      Ising2DLambda.NecSuf.KacWard.oneSidedFourSegmentPath first second third fourth a b c :=
  rfl

theorem fourPartClosure_eq_necSuf (h p : ℕ) (first second third fourth : ℕ → ℤ × ℤ) :
    fourPartClosure h p first second third fourth =
      Ising2DLambda.NecSuf.KacWard.fourPartClosure h p first second third fourth :=
  rfl

theorem fourJunctionPairs_eq_necSuf (a b c d : ℕ) (u v w x : ℕ → ℤ × ℤ) :
    fourJunctionPairs a b c d u v w x =
      Ising2DLambda.NecSuf.KacWard.fourJunctionPairs a b c d u v w x :=
  rfl

end Ising2DLambda.KacWard
