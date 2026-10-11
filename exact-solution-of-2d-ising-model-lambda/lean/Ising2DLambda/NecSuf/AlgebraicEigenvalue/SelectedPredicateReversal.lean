/-
選んだ奇数軌道の反転の必要十分版。
有限性・順序・奇数性を除き、不変述語、保存される置換の性質、選択述語の一致だけを残す。
性質の保存と選択の一致は前段から供給し、不動点なしの保存と二重反転はここで導く。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.InvariantPredicateReversal

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

variable {α : Type*} (p : α → Prop) [dp : DecidablePred p]

theorem invariantPredicateReversal_fixed_iff (σ : Equiv.Perm α)
    (h : ∀ i, p (σ i) ↔ p i) (i : α) :
    invariantPredicateReversal p σ h i = i ↔ σ i = i := by
  by_cases hi : p i
  · calc
      invariantPredicateReversal p σ h i = i ↔ σ.symm i = i := by
        change (if p i then σ.symm i else σ i) = i ↔ _
        rw [if_pos hi]
      _ ↔ σ (σ.symm i) = σ i := σ.injective.eq_iff.symm
      _ ↔ i = σ i := by rw [σ.apply_symm_apply i]
      _ ↔ σ i = i := eq_comm
  · change (if p i then σ.symm i else σ i) = i ↔ _
    rw [if_neg hi]

/-- P は奇数点の非空性を抽出した性質であり、不動点なしの条件を含めない。 -/
theorem selectedPredicateReversal_mem (P : Equiv.Perm α → Prop) (σ : Equiv.Perm α)
    (h : ∀ i, p (σ i) ↔ p i)
    (hσ : (∀ i, σ i ≠ i) ∧ P σ)
    (hFeature : P σ → P (invariantPredicateReversal p σ h)) :
    (∀ i, invariantPredicateReversal p σ h i ≠ i) ∧
      P (invariantPredicateReversal p σ h) := by
  let D : Set (Equiv.Perm α) := {π | ∀ i, π i ≠ i}
  have hDer : invariantPredicateReversal p σ h ∈ D ↔ σ ∈ D := by
    calc
      invariantPredicateReversal p σ h ∈ D ↔
          (∀ i, invariantPredicateReversal p σ h i ≠ i) := Iff.rfl
      _ ↔ (∀ i, σ i ≠ i) :=
        forall_congr' (fun i => not_congr (invariantPredicateReversal_fixed_iff p σ h i))
      _ ↔ σ ∈ D := Iff.rfl
  exact ⟨hDer.mpr hσ.1, hFeature hσ.2⟩

/-- 二度目に選ばれた述語 q と元の p が等しければ、既証明の同一述語の二重反転へ帰着する。 -/
theorem selectedPredicateInvolution_twice (q : α → Prop) [dq : DecidablePred q]
    (σ : Equiv.Perm α) (h : ∀ i, p (σ i) ↔ p i)
    (hq : ∀ i, q (invariantPredicateReversal p σ h i) ↔ q i)
    (hSelected : q = p) :
    invariantPredicateReversal q (invariantPredicateReversal p σ h) hq = σ := by
  calc
    invariantPredicateReversal q (invariantPredicateReversal p σ h) hq =
        invariantPredicateReversal p (invariantPredicateReversal p σ h)
          (invariantPredicateReversal_mem_iff p σ h) := by
      subst q
      have hDec : dq = dp := Subsingleton.elim _ _
      subst dq
      rfl
    _ = σ := invariantPredicateReversal_twice p σ h

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
