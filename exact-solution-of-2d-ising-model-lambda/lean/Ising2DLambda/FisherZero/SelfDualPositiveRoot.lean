/-
「正の根の特定」の具体版。
本文と同じ表示の構成、正錐三条件の判定、二根の場合分けを順に実装する。
-/
import Ising2DLambda.FisherZero.SelfDualQuadraticRoots
import Ising2DLambda.FisherZero.QuadraticPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_self_dual_root_plus_mem` の具体版。 -/
theorem selfDualRootPlus_mem (s : Qbar) :
    -1 + s ∈ quadraticFieldSet s := by
  refine ⟨-1, 1, ?_⟩
  calc
    -1 + s = algebraMap ℚ Qbar (-1) + s := by norm_num
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar 1 * s := by simp

/-- 根 `-1+s` を `Q_s` の元として持ち上げる。 -/
noncomputable def selfDualRootPlus (s : Qbar) : QuadraticFieldElement s :=
  ⟨-1 + s, selfDualRootPlus_mem s⟩

/-- `claim_self_dual_root_plus_representation` の具体版。 -/
theorem selfDualRootPlus_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootPlus s) = (-1, 1) := by
  apply quadraticRepresentation_eq s hs (selfDualRootPlus s) (-1) 1
  change -1 + s = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar 1 * s
  norm_num

/-- `claim_self_dual_root_minus_mem` の具体版。 -/
theorem selfDualRootMinus_mem (s : Qbar) :
    -1 - s ∈ quadraticFieldSet s := by
  refine ⟨-1, -1, ?_⟩
  calc
    -1 - s = -1 + (-s) := sub_eq_add_neg _ _
    _ = algebraMap ℚ Qbar (-1) + (-(algebraMap ℚ Qbar 1 * s)) := by norm_num
    _ = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar (-1) * s := by norm_num

/-- 根 `-1-s` を `Q_s` の元として持ち上げる。 -/
noncomputable def selfDualRootMinus (s : Qbar) : QuadraticFieldElement s :=
  ⟨-1 - s, selfDualRootMinus_mem s⟩

/-- `claim_self_dual_root_minus_representation` の具体版。 -/
theorem selfDualRootMinus_representation (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootMinus s) = (-1, -1) := by
  apply quadraticRepresentation_eq s hs (selfDualRootMinus s) (-1) (-1)
  change -1 - s = algebraMap ℚ Qbar (-1) + algebraMap ℚ Qbar (-1) * s
  simp [sub_eq_add_neg]

/-- `claim_self_dual_root_plus_positive` の具体版。 -/
theorem selfDualRootPlus_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootPlus s ∈ quadraticPositiveCone s := by
  change quadraticCoefficientPositive (quadraticRepresentation s (selfDualRootPlus s))
  rw [selfDualRootPlus_representation s hs]
  exact Or.inr (Or.inr ⟨by norm_num, by norm_num, by norm_num⟩)

/-- `claim_self_dual_root_minus_not_positive` の具体版。 -/
theorem selfDualRootMinus_not_mem_positiveCone (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootMinus s ∉ quadraticPositiveCone s := by
  change ¬ quadraticCoefficientPositive (quadraticRepresentation s (selfDualRootMinus s))
  rw [selfDualRootMinus_representation s hs]
  simp [quadraticCoefficientPositive]

/-- `claim_self_dual_positive_root_unique` の具体版。 -/
theorem selfDualPositiveRoot_unique {s xi : Qbar}
    (hs : s * s = algebraMap ℚ Qbar 2)
    (hxiMem : xi ∈ quadraticFieldSet s)
    (hquadratic : xi ^ 2 + 2 * xi - 1 = 0)
    (hpositive : (⟨xi, hxiMem⟩ : QuadraticFieldElement s) ∈ quadraticPositiveCone s) :
    xi = -1 + s := by
  rcases (selfDualQuadratic_roots hs).mp hquadratic with hplus | hminus
  · exact hplus
  · have hSubtype : (⟨xi, hxiMem⟩ : QuadraticFieldElement s) = selfDualRootMinus s := by
      apply Subtype.ext
      exact hminus
    have : selfDualRootMinus s ∈ quadraticPositiveCone s := by
      rw [← hSubtype]
      exact hpositive
    exact (selfDualRootMinus_not_mem_positiveCone s hs this).elim

/-- `def_critical_point` の具体版。 -/
noncomputable def criticalPoint (s : Qbar) : QuadraticFieldElement s := selfDualRootPlus s

end Ising2DLambda.FisherZero
