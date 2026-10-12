import Ising2DLambda.FisherZero.PositiveRationalInPositiveCone
import Ising2DLambda.FisherZero.QuadraticRepresentationUniqueFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.PositiveEmbeddedCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 零の三等号から正錐の第一条件までを、有理数の包含へ特殊化する。 -/
theorem positiveRational_mem_positiveCone_from_necSuf (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) (q : ℚ) (hq : 0 < q) :
    positiveRationalElement s q ∈ quadraticPositiveCone s := by
  obtain ⟨hmem, hpositive⟩ :=
    Ising2DLambda.NecSuf.FisherZero.embedded_coefficient_positive_necSuf
      (A := ℚ) (V := Qbar)
      (fun z : Qbar => add_zero z)
      (algebraMap ℚ Qbar) (map_zero (algebraMap ℚ Qbar))
      (fun z : Qbar => z * s) (zero_mul s)
      (fun a : ℚ => 0 ≤ a) (fun a : ℚ => 0 < a) le_rfl
      (fun _ h => le_of_lt h) (fun _ h => ne_of_gt h)
      (quadraticRepresentation s)
      (fun xi a b h => by
        have hcoeff := quadraticRepresentationUnique_from_necSuf s hs
          (quadraticRepresentation s xi).1 (quadraticRepresentation s xi).2 a b
          ((quadraticRepresentation_spec s xi).symm.trans h)
        exact Prod.ext hcoeff.1 hcoeff.2)
      quadraticCoefficientPositive (fun _ _ ha hb hab => Or.inl ⟨ha, hb, hab⟩)
      q hq
  exact hpositive

end Ising2DLambda.FisherZero
