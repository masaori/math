/-
不変部分集合上の反転の必要十分版。
場合分けには判定可能な述語、逆計算には両側逆、所属の移送には述語の保存だけを使う。
有限性・順序・有限集合による述語の表示は使わない。
-/
import Mathlib.Logic.Equiv.Defs

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*} (p : α → Prop) [DecidablePred p]

def invariantPredicateForward (σ : Equiv.Perm α) (i : α) : α :=
  if p i then σ.symm i else σ i

def invariantPredicateBackward (σ : Equiv.Perm α) (i : α) : α :=
  if p i then σ i else σ.symm i

omit [DecidablePred p] in
/-- 具体版と同じ、保存条件と逆等式の二段。 -/
theorem inverse_invariantPredicate_iff (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    p (σ.symm i) ↔ p i := by
  calc
    p (σ.symm i) ↔ p (σ (σ.symm i)) := (h (σ.symm i)).symm
    _ ↔ p i := by rw [σ.apply_symm_apply i]

/-- 具体版と同じ、各場合三等号による左逆。 -/
theorem invariantPredicateBackward_forward (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    invariantPredicateBackward p σ (invariantPredicateForward p σ i) = i := by
  by_cases hi : p i
  · have hsi : p (σ.symm i) := (inverse_invariantPredicate_iff p σ h i).mpr hi
    calc
      invariantPredicateBackward p σ (invariantPredicateForward p σ i) =
          invariantPredicateBackward p σ (σ.symm i) :=
        congrArg (invariantPredicateBackward p σ) (if_pos hi)
      _ = σ (σ.symm i) := if_pos hsi
      _ = i := σ.apply_symm_apply i
  · have hsi : ¬ p (σ i) := fun hmem => hi ((h i).mp hmem)
    calc
      invariantPredicateBackward p σ (invariantPredicateForward p σ i) =
          invariantPredicateBackward p σ (σ i) :=
        congrArg (invariantPredicateBackward p σ) (if_neg hi)
      _ = σ.symm (σ i) := if_neg hsi
      _ = i := σ.symm_apply_apply i

/-- 具体版と同じ、各場合三等号による右逆。 -/
theorem invariantPredicateForward_backward (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    invariantPredicateForward p σ (invariantPredicateBackward p σ i) = i := by
  by_cases hi : p i
  · have hsi : p (σ i) := (h i).mpr hi
    calc
      invariantPredicateForward p σ (invariantPredicateBackward p σ i) =
          invariantPredicateForward p σ (σ i) :=
        congrArg (invariantPredicateForward p σ) (if_pos hi)
      _ = σ.symm (σ i) := if_pos hsi
      _ = i := σ.symm_apply_apply i
  · have hsi : ¬ p (σ.symm i) :=
      fun hmem => hi ((inverse_invariantPredicate_iff p σ h i).mp hmem)
    calc
      invariantPredicateForward p σ (invariantPredicateBackward p σ i) =
          invariantPredicateForward p σ (σ.symm i) :=
        congrArg (invariantPredicateForward p σ) (if_neg hi)
      _ = σ (σ.symm i) := if_neg hsi
      _ = i := σ.apply_symm_apply i

def invariantPredicateReversal (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) : Equiv.Perm α where
  toFun := invariantPredicateForward p σ
  invFun := invariantPredicateBackward p σ
  left_inv := invariantPredicateBackward_forward p σ h
  right_inv := invariantPredicateForward_backward p σ h

/-- 具体版と同じ、各場合二つの同値による述語保存。 -/
theorem invariantPredicateReversal_mem_iff (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) (i : α) :
    p (invariantPredicateReversal p σ h i) ↔ p i := by
  by_cases hi : p i
  · calc
      p (invariantPredicateReversal p σ h i) ↔ p (σ.symm i) := by
        change p (invariantPredicateForward p σ i) ↔ _
        rw [show invariantPredicateForward p σ i = σ.symm i from if_pos hi]
      _ ↔ p i := inverse_invariantPredicate_iff p σ h i
  · calc
      p (invariantPredicateReversal p σ h i) ↔ p (σ i) := by
        change p (invariantPredicateForward p σ i) ↔ _
        rw [show invariantPredicateForward p σ i = σ i from if_neg hi]
      _ ↔ p i := h i

/-- 具体版と同じ、各場合三等号による二度反転。 -/
theorem invariantPredicateReversal_twice (σ : Equiv.Perm α)
    (h : ∀ i : α, p (σ i) ↔ p i) :
    invariantPredicateReversal p (invariantPredicateReversal p σ h)
      (invariantPredicateReversal_mem_iff p σ h) = σ := by
  apply Equiv.ext
  intro i
  by_cases hi : p i
  · calc
      invariantPredicateReversal p (invariantPredicateReversal p σ h)
          (invariantPredicateReversal_mem_iff p σ h) i =
          (invariantPredicateReversal p σ h).symm i := if_pos hi
      _ = invariantPredicateBackward p σ i := rfl
      _ = σ i := if_pos hi
  · calc
      invariantPredicateReversal p (invariantPredicateReversal p σ h)
          (invariantPredicateReversal_mem_iff p σ h) i =
          invariantPredicateReversal p σ h i := if_neg hi
      _ = invariantPredicateForward p σ i := rfl
      _ = σ i := if_neg hi

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
