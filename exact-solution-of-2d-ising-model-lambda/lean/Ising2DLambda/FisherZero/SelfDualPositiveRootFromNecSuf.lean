import Ising2DLambda.FisherZero.SelfDualPositiveRoot
import Ising2DLambda.NecSuf.FisherZero.SelfDualPositiveRoot

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem selfDualRootPlus_mem_from_necSuf (s : Qbar) :
    -1 + s ∈ quadraticFieldSet s := by
  change ∃ a b : ℚ, -1 + s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
  exact Ising2DLambda.NecSuf.FisherZero.selfDualRootPlus_mem_necSuf
    (algebraMap ℚ Qbar) s (map_one (algebraMap ℚ Qbar))
    (map_neg (algebraMap ℚ Qbar) (1 : ℚ)) (one_mul s)

theorem selfDualRootPlus_representation_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootPlus s) = (-1, 1) := by
  exact Ising2DLambda.NecSuf.FisherZero.selfDualRootPlus_representation_necSuf
    (algebraMap ℚ Qbar) s (quadraticRepresentation s (selfDualRootPlus s))
    (quadraticRepresentation_spec s (selfDualRootPlus s))
    (map_one (algebraMap ℚ Qbar)) (map_neg (algebraMap ℚ Qbar) (1 : ℚ))
    (one_mul s) (quadraticRepresentationUnique s hs)

theorem selfDualRootMinus_mem_from_necSuf (s : Qbar) :
    -1 - s ∈ quadraticFieldSet s := by
  change ∃ a b : ℚ, -1 - s = algebraMap ℚ Qbar a + algebraMap ℚ Qbar b * s
  exact Ising2DLambda.NecSuf.FisherZero.selfDualRootMinus_mem_necSuf
    (algebraMap ℚ Qbar) s (sub_eq_add_neg _ _)
    (map_one (algebraMap ℚ Qbar)) (map_neg (algebraMap ℚ Qbar) (1 : ℚ))
    (one_mul s) (neg_mul (1 : Qbar) s)

theorem selfDualRootMinus_representation_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    quadraticRepresentation s (selfDualRootMinus s) = (-1, -1) := by
  exact Ising2DLambda.NecSuf.FisherZero.selfDualRootMinus_representation_necSuf
    (algebraMap ℚ Qbar) s (quadraticRepresentation s (selfDualRootMinus s))
    (quadraticRepresentation_spec s (selfDualRootMinus s)) (sub_eq_add_neg _ _)
    (map_one (algebraMap ℚ Qbar)) (map_neg (algebraMap ℚ Qbar) (1 : ℚ))
    (one_mul s) (neg_mul (1 : Qbar) s) (quadraticRepresentationUnique s hs)

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
