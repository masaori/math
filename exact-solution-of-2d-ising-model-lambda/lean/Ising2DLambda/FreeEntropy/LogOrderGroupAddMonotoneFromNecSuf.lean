/- 必要十分版を具体的な対数順序群と正の有理数へ特殊化する。 -/
import Ising2DLambda.FreeEntropy.LogOrderGroupAddMonotone
import Ising2DLambda.NecSuf.FreeEntropy.LogOrderGroupAddMonotone

namespace Ising2DLambda.FreeEntropy

theorem rationalOfLog_add_from_necSuf (l n : LogOrderGroup) :
    rationalOfLog (l + n) = rationalOfLog l * rationalOfLog n := by
  exact Ising2DLambda.NecSuf.FreeEntropy.inverse_add_to_mul_necSuf
    (· + ·) (· * ·) (fun q : ℚ => 0 < q) rationalOfLog logRat rationalOfLog_pos
    (fun a b => mul_pos (rationalOfLog_pos a) (rationalOfLog_pos b))
    logRat_rationalOfLog
    (fun a b => by
      calc
        logRat (rationalOfLog a * rationalOfLog b) =
            logRat (rationalOfLog a) + logRat (rationalOfLog b) :=
          logRat_mul (rationalOfLog_pos a) (rationalOfLog_pos b)
        _ = a + b := by rw [logRat_rationalOfLog, logRat_rationalOfLog])
    (fun hu hv h => logRat_injective_of_pos hu hv h) l n

theorem logOrderLE_add_right_from_necSuf {l m : LogOrderGroup}
    (h : logOrderLE l m) (n : LogOrderGroup) : logOrderLE (l + n) (m + n) := by
  exact Ising2DLambda.NecSuf.FreeEntropy.pullback_add_right_mono_necSuf
    (· + ·) (· * ·) (· ≤ ·) rationalOfLog rationalOfLog_add
    (fun q : ℚ => 0 < q) rationalOfLog_pos
    (fun a b c hab hc => mul_le_mul_of_nonneg_right hab (le_of_lt hc)) h n

end Ising2DLambda.FreeEntropy
