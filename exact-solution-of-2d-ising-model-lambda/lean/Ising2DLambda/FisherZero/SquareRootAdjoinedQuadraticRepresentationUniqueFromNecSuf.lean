import Ising2DLambda.NecSuf.FisherZero.SquareRootAdjoinedQuadraticRepresentationUnique

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を代数的数の部分体へ特殊化する。 -/
theorem quadraticRepresentation_unique_from_necSuf (F : Subfield Qbar)
    (b u v w t : Qbar) (hbF : b ∉ F)
    (hu : u ∈ F) (hv : v ∈ F) (hw : w ∈ F) (ht : t ∈ F)
    (h : u + v * b = w + t * b) : u = w ∧ v = t :=
  Ising2DLambda.NecSuf.FisherZero.quadraticRepresentation_unique_necSuf
    F b u v w t hbF hu hv hw ht h

end Ising2DLambda.FisherZero
