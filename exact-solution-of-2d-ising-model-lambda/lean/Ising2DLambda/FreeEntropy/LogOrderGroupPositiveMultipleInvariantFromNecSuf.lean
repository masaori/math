/- 必要十分版を具体的な対数順序群と正の有理数へ特殊化する。 -/
import Ising2DLambda.FreeEntropy.LogOrderGroupPositiveMultipleInvariant
import Ising2DLambda.NecSuf.FreeEntropy.LogOrderGroupPositiveMultipleInvariant

namespace Ising2DLambda.FreeEntropy

theorem logOrderLE_natSmul_iff_from_necSuf (N : ℕ) (hN : 1 ≤ N) (l m : LogOrderGroup) :
    logOrderLE l m ↔ logOrderLE ((N : ℤ) • l) ((N : ℤ) • m) := by
  rw [natCast_zsmul, natCast_zsmul]
  exact Ising2DLambda.NecSuf.FreeEntropy.pullback_multiple_iff_necSuf
    (fun n a => n • a) (fun q n => q ^ n) (· ≤ ·) rationalOfLog
    (fun n a => rationalOfLog_natSmul n a)
    (fun n hn a b => pow_le_pow_iff_left₀ (le_of_lt (rationalOfLog_pos a))
      (le_of_lt (rationalOfLog_pos b)) (Nat.pos_iff_ne_zero.mp hn))
    N hN l m

end Ising2DLambda.FreeEntropy
