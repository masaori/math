import Ising2DLambda.FisherZero.SelfDualPositiveRoot
import Ising2DLambda.NecSuf.FisherZero.SelfDualPositiveRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem selfDualRootPlus_mem_from_necSuf (s : Qbar) :
    -1 + s ∈ quadraticFieldSet s := by
  change ∃ a b : ℚ, -1 + s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
  simpa using
    (Ising2DLambda.NecSuf.FisherZero.represented_value_mem_necSuf
      (fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) (-1) 1)

theorem selfDualRootPlus_representation_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootPlus s) = (-1, 1) := by
  let combine : ℚ → ℚ → QuadraticFieldElement s := fun a b =>
    ⟨algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s, ⟨a, b, rfl⟩⟩
  have h := Ising2DLambda.NecSuf.FisherZero.representation_of_value_necSuf
      combine (quadraticRepresentation s)
      (fun x a b hx => quadraticRepresentation_eq s hs x a b (congrArg Subtype.val hx))
      (-1) 1
  simpa [combine, selfDualRootPlus] using h

theorem selfDualRootMinus_mem_from_necSuf (s : Qbar) :
    -1 - s ∈ quadraticFieldSet s := by
  change ∃ a b : ℚ, -1 - s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
  simpa [sub_eq_add_neg] using
    (Ising2DLambda.NecSuf.FisherZero.represented_value_mem_necSuf
      (fun a b : ℚ => algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s) (-1) (-1))

theorem selfDualRootMinus_representation_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootMinus s) = (-1, -1) := by
  let combine : ℚ → ℚ → QuadraticFieldElement s := fun a b =>
    ⟨algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s, ⟨a, b, rfl⟩⟩
  have h := Ising2DLambda.NecSuf.FisherZero.representation_of_value_necSuf
      combine (quadraticRepresentation s)
      (fun x a b hx => quadraticRepresentation_eq s hs x a b (congrArg Subtype.val hx))
      (-1) (-1)
  simpa [combine, selfDualRootMinus, sub_eq_add_neg] using h

theorem selfDualRootPlus_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootPlus s ∈ quadraticPositiveCone s := by
  apply Ising2DLambda.NecSuf.FisherZero.positive_of_representation_necSuf
      (quadraticRepresentation s) quadraticCoefficientPositive
      (selfDualRootPlus s) (-1) 1
  · exact selfDualRootPlus_representation s hs
  · exact Or.inr (Or.inr ⟨by norm_num, by norm_num, by norm_num⟩)

theorem selfDualRootMinus_not_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    selfDualRootMinus s ∉ quadraticPositiveCone s := by
  apply Ising2DLambda.NecSuf.FisherZero.not_positive_of_representation_necSuf
      (quadraticRepresentation s) quadraticCoefficientPositive
      (selfDualRootMinus s) (-1) (-1)
  · exact selfDualRootMinus_representation s hs
  · simp [quadraticCoefficientPositive]

theorem selfDualPositiveRoot_unique_from_necSuf {s xi : Qbar}
    (hs : s * s = algebraMap ℚ Qbar 2)
    (hxiMem : xi ∈ quadraticFieldSet s)
    (hquadratic : xi ^ 2 + 2 * xi - 1 = 0)
    (hpositive : (⟨xi, hxiMem⟩ : QuadraticFieldElement s) ∈ quadraticPositiveCone s) :
    xi = -1 + s := by
  apply Ising2DLambda.NecSuf.FisherZero.positive_root_unique_necSuf
      (-1 + s) (-1 - s) xi
      (fun z => ∃ hz : z ∈ quadraticFieldSet s,
        (⟨z, hz⟩ : QuadraticFieldElement s) ∈ quadraticPositiveCone s)
  · exact (selfDualQuadratic_roots hs).mp hquadratic
  · exact ⟨hxiMem, hpositive⟩
  · rintro ⟨hminusMem, hminusPositive⟩
    have hSubtype : (⟨-1 - s, hminusMem⟩ : QuadraticFieldElement s) = selfDualRootMinus s := by
      rfl
    rw [hSubtype] at hminusPositive
    exact selfDualRootMinus_not_mem_positiveCone s hs hminusPositive

end Ising2DLambda.FisherZero
