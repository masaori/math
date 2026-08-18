/- `claim_critical_point_rational_partition_interval` の具体版が必要十分版から得られること。 -/
import Ising2DLambda.CriticalExponent.CriticalPointRationalPartitionInterval
import Ising2DLambda.NecSuf.CriticalExponent.CriticalPointRationalPartitionInterval

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.FisherZero

theorem criticalPoint_rationalPartitionInterval_from_necSuf
    (data : RealClosedSubfieldSqrtTwoData s) (hs : s * s = 2)
    (N : ℕ) (hN : 1 ≤ N) :
    ∃ k : ℕ,
      k + 1 ≤ N ∧
      realAlgebraicLe data.toRealClosedSubfieldData
        (rationalPartitionPoint data.toRealClosedSubfieldData k N)
        (criticalPointRealClosed data.toRealClosedSubfieldData s hs) ∧
      realAlgebraicLt data.toRealClosedSubfieldData
        (criticalPointRealClosed data.toRealClosedSubfieldData s hs)
        (rationalPartitionPoint data.toRealClosedSubfieldData (k + 1) N) := by
  classical
  let base := data.toRealClosedSubfieldData
  let xc := criticalPointRealClosed base s hs
  simpa [realAlgebraicLe] using
    (Ising2DLambda.NecSuf.CriticalExponent.criticalPoint_rationalPartitionInterval_necSuf
      (lt := realAlgebraicLt base)
      (point := fun j => rationalPartitionPoint base j N)
      (x := xc) (N := N)
      (realAlgebraicLt_trichotomy base)
      (by simpa [rationalPartitionPoint_zero] using criticalPoint_positive data hs)
      (by simpa [rationalPartitionPoint_top base N hN] using criticalPoint_lt_one data hs))

end Ising2DLambda.CriticalExponent
