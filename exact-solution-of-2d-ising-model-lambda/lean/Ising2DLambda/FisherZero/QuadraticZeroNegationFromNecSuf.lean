import Ising2DLambda.FisherZero.QuadraticZeroNegation
import Ising2DLambda.FisherZero.QuadraticRepresentationUniqueFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticZeroNegation

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 本文の四等号を、代数的数の零の和・包含の零保存・右乗法の零保存へ特殊化する。 -/
theorem quadraticZero_mem_from_necSuf (s : Qbar) :
    (0 : Qbar) ∈ quadraticFieldSet s := by
  exact Ising2DLambda.NecSuf.FisherZero.zero_mem_necSuf
    (add_zero (0 : Qbar))
    (algebraMap ℚ Qbar) (map_zero (algebraMap ℚ Qbar))
    (fun z : Qbar => z * s) (zero_mul s)

/-- 本文の十四等号を特殊化し、一意性はその必要十分版からの導出を供給する。 -/
theorem quadraticRepresentation_eq_zero_iff_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    (xi : Qbar) = 0 ↔ quadraticRepresentation s xi = (0, 0) := by
  exact Ising2DLambda.NecSuf.FisherZero.zero_representation_necSuf
    (add_zero (0 : Qbar))
    (algebraMap ℚ Qbar) (map_zero (algebraMap ℚ Qbar))
    (fun z : Qbar => z * s) (zero_mul s)
    (fun eta : QuadraticFieldElement s => (eta : Qbar)) (quadraticRepresentation s)
    (quadraticRepresentation_spec s)
    (quadraticRepresentationUnique_from_necSuf s hs) xi

/-- 本文の五等号を、和の逆元則・包含と右乗法の逆元保存へ特殊化する。 -/
theorem quadraticNeg_mem_from_necSuf (s : Qbar) (xi : QuadraticFieldElement s) :
    -(xi : Qbar) ∈ quadraticFieldSet s := by
  exact Ising2DLambda.NecSuf.FisherZero.neg_mem_necSuf
    (fun z w : Qbar => neg_add z w)
    (algebraMap ℚ Qbar) (map_neg (algebraMap ℚ Qbar))
    (fun z : Qbar => z * s) (fun z : Qbar => neg_mul z s)
    (fun eta : QuadraticFieldElement s => (eta : Qbar)) (quadraticRepresentation s)
    (quadraticRepresentation_spec s) xi

theorem quadraticRepresentation_neg_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2)
    (xi : QuadraticFieldElement s) :
    quadraticRepresentation s (quadraticNegElement s xi) =
      (-(quadraticRepresentation s xi).1, -(quadraticRepresentation s xi).2) := by
  exact Ising2DLambda.NecSuf.FisherZero.neg_representation_necSuf
    (fun z w : Qbar => neg_add z w)
    (algebraMap ℚ Qbar) (map_neg (algebraMap ℚ Qbar))
    (fun z : Qbar => z * s) (fun z : Qbar => neg_mul z s)
    (quadraticNegElement s) (fun eta : QuadraticFieldElement s => (eta : Qbar))
    (fun _ => rfl) (quadraticRepresentation s) (quadraticRepresentation_spec s)
    (fun eta a b h => by
      have hcoeff := quadraticRepresentationUnique_from_necSuf s hs
        (quadraticRepresentation s eta).1 (quadraticRepresentation s eta).2 a b
        ((quadraticRepresentation_spec s eta).symm.trans h)
      exact Prod.ext hcoeff.1 hcoeff.2) xi

end Ising2DLambda.FisherZero
