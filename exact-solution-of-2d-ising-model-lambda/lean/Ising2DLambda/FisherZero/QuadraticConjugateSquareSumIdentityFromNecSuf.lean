import Ising2DLambda.FisherZero.QuadraticConjugateSquareSumIdentity
import Ising2DLambda.NecSuf.FisherZero.QuadraticConjugateSquareSumIdentity

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

theorem quadraticConjugateSquareSumIdentity_from_necSuf
    (F : Subfield Qbar) (a b : Qbar) (ha : a ∈ F) (hb : b * b = a)
    (ι : Type) [Fintype ι] (c u v : ι → Qbar)
    (hc : ∀ i, c i ∈ F) (hu : ∀ i, u i ∈ F) (hv : ∀ i, v i ∈ F) :
    (∑ i, c i * ((u i + v i * b) * (u i + v i * b))) +
      (∑ i, c i * ((u i - v i * b) * (u i - v i * b))) =
      2 * ∑ i, c i * ((u i * u i) + a * (v i * v i)) :=
  Ising2DLambda.NecSuf.FisherZero.quadraticConjugateSquareSumIdentity a b hb ι c u v

end Ising2DLambda.FisherZero
