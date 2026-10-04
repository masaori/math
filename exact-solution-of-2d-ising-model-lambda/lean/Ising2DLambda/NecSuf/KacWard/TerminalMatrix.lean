/-
端末行列の行選択の必要十分版。
有限和、零と一の左乗法、減法の記号だけを要求する。
始終点には tgt(reverse(e))=src(e)、反転には対合性だけを使う。
重みは任意でよく、分配則、乗法の結合則、体の構造は不要である。
-/
import Ising2DLambda.NecSuf.KacWard.ReversalMatrix

namespace Ising2DLambda.NecSuf.KacWard

open scoped BigOperators

/-- 任意の重みに後続条件を課した、I-xM の成分。 -/
def successorKernel {α V R : Type*} [DecidableEq α] [DecidableEq V]
    [Zero R] [One R] [Mul R] [Sub R]
    (reverse : α → α) (source target : α → V) (weight : α → α → R) (x : R) :
    Matrix α α R :=
  fun e f => (if e = f then 1 else 0) -
    x * (if target e = source f ∧ f ≠ reverse e then weight e f else 0)

/-- 対合の選択行列を I-xM の左から掛けた行列。 -/
def terminalMatrix {α V R : Type*} [Fintype α] [DecidableEq α] [DecidableEq V]
    [AddCommMonoid R] [One R] [Mul R] [Sub R]
    (reverse : α → α) (source target : α → V) (weight : α → α → R) (x : R) :
    Matrix α α R :=
  involutionMatrix reverse * successorKernel reverse source target weight x

/-- 具体版と同じ、端点・対合性・等号対称性による後続条件の書換え。 -/
lemma terminal_successor_condition_necSuf {α V : Type*}
    (reverse : α → α) (hinvolutive : Function.Involutive reverse)
    (source target : α → V) (htarget : ∀ e, target (reverse e) = source e)
    (e f : α) :
    (target (reverse e) = source f ∧ f ≠ reverse (reverse e)) ↔
      source f = source e ∧ f ≠ e := by
  calc
    _ ↔ source e = source f ∧ f ≠ reverse (reverse e) := by rw [htarget]
    _ ↔ source e = source f ∧ f ≠ e := by rw [hinvolutive]
    _ ↔ source f = source e ∧ f ≠ e := by simp only [@eq_comm _ (source e) (source f)]

/-- 具体版と同じ、唯一の反転行の選択と後続条件の書換え。 -/
theorem terminalMatrix_entry_necSuf {α V R : Type*}
    [Fintype α] [DecidableEq α] [DecidableEq V]
    [AddCommMonoid R] [One R] [Mul R] [Sub R]
    (reverse : α → α) (hinvolutive : Function.Involutive reverse)
    (source target : α → V) (htarget : ∀ e, target (reverse e) = source e)
    (weight : α → α → R) (x : R)
    (hzero_mul : ∀ r : R, 0 * r = 0) (hone_mul : ∀ r : R, 1 * r = r)
    (e f : α) :
    terminalMatrix reverse source target weight x e f =
      (if f = reverse e then 1 else 0) - x *
        (if source f = source e ∧ f ≠ e then weight (reverse e) f else 0) := by
  have hzero (g : α) (hg : g ≠ reverse e) :
      involutionMatrix (R := R) reverse e g *
        successorKernel reverse source target weight x g f = 0 := by
    calc
      _ = 0 * successorKernel reverse source target weight x g f := by
        rw [show involutionMatrix (R := R) reverse e g = 0 from if_neg hg]
      _ = 0 := hzero_mul _
  calc
    terminalMatrix reverse source target weight x e f =
        ∑ g, involutionMatrix reverse e g * successorKernel reverse source target weight x g f := rfl
    _ = involutionMatrix reverse e (reverse e) *
        successorKernel reverse source target weight x (reverse e) f :=
      Fintype.sum_eq_single (reverse e) hzero
    _ = 1 * successorKernel reverse source target weight x (reverse e) f := by
      rw [show involutionMatrix (R := R) reverse e (reverse e) = 1 from if_pos rfl]
    _ = successorKernel reverse source target weight x (reverse e) f := hone_mul _
    _ = (if reverse e = f then 1 else 0) - x *
        (if target (reverse e) = source f ∧ f ≠ reverse (reverse e)
          then weight (reverse e) f else 0) := rfl
    _ = (if f = reverse e then 1 else 0) - x *
        (if target (reverse e) = source f ∧ f ≠ reverse (reverse e)
          then weight (reverse e) f else 0) := by
      simp only [@eq_comm _ (reverse e) f]
    _ = _ := by
      simp only [terminal_successor_condition_necSuf reverse hinvolutive source target htarget]

end Ising2DLambda.NecSuf.KacWard
