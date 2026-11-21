/-
方向の列の具体版の定義（`KacWard/DirectionSequence.lean`）が、必要十分版の同名の定義を
値の型 ℤ に特殊化したものに一致することの記録。導出（`*_from_necSuf`）だけが使う。
-/
import Ising2DLambda.KacWard.DirectionSequence
import Ising2DLambda.NecSuf.KacWard.RepeatedAdjacentSum
import Ising2DLambda.NecSuf.KacWard.ReversedParallelStaircaseTurning

namespace Ising2DLambda.KacWard

theorem joinDirectionSequence_eq_necSuf {α : Type*} (u v : ℕ → α) (a : ℕ) :
    joinDirectionSequence u v a = Ising2DLambda.NecSuf.KacWard.joinDirectionSequence u v a :=
  rfl

theorem internalAdjacentSum_eq_necSuf {α : Type*} (weight : α → α → ℤ) (n : ℕ)
    (u : ℕ → α) :
    internalAdjacentSum weight n u =
      Ising2DLambda.NecSuf.KacWard.internalAdjacentSum weight n u :=
  rfl

theorem cyclicAdjacentSum_eq_necSuf {α : Type*} (weight : α → α → ℤ) (n : ℕ)
    (u : ℕ → α) :
    cyclicAdjacentSum weight n u =
      Ising2DLambda.NecSuf.KacWard.cyclicAdjacentSum weight n u :=
  rfl

theorem twoBlockSequence_eq_necSuf {α : Type*} (p : ℕ) (a b : α) :
    twoBlockSequence p a b = Ising2DLambda.NecSuf.KacWard.twoBlockSequence p a b :=
  rfl

theorem repeatDirectionSequence_eq_necSuf {α : Type*} (u : ℕ → α) (n : ℕ) :
    repeatDirectionSequence u n = Ising2DLambda.NecSuf.KacWard.repeatDirectionSequence u n :=
  rfl

end Ising2DLambda.KacWard
