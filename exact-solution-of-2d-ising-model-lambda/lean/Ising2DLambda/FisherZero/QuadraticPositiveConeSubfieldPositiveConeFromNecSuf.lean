import Ising2DLambda.FisherZero.QuadraticPositiveConeSubfieldPositiveCone
import Ising2DLambda.FisherZero.SubfieldPositiveConeFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.QuadraticPositiveConeSubfieldPositiveCone

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版を二次体の台と正錐に特殊化する。 -/
theorem quadraticPositiveCone_isSubfieldPositiveCone_from_necSuf
    (s : Qbar) (hs : s * s = algebraMap ℚ Qbar 2) :
    IsSubfieldPositiveCone (quadraticFieldSubfield s hs)
      (quadraticPositiveConeAmbient s) := by
  have h := quadraticPositiveCone_isSubfieldPositiveCone s hs
  apply (isSubfieldPositiveCone_iff_from_necSuf
    (quadraticFieldSubfield s hs) (quadraticPositiveConeAmbient s)).mpr
  exact Ising2DLambda.NecSuf.FisherZero.positiveCone_of_closed_trichotomy
    (quadraticFieldSubfield s hs : Set Qbar) (quadraticPositiveConeAmbient s)
    h.subset h.add_mem h.mul_mem h.trichotomy

end Ising2DLambda.FisherZero
