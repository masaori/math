import Ising2DLambda.KacWard.TwistedModeSets
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnityPowerNotOneExists

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の `claim_antiperiodic_mode_exists` に対応する。 -/
theorem antiperiodicMode_exists (L : ℕ) (hL : 1 ≤ L) :
    ∃ ξ ∈ RootOfUnity (2 * L), ξ ^ L = (-1 : Qbar) := by
  have hlt : L < 2 * L := by omega
  have hndvd : ¬ 2 * L ∣ L := by
    intro hdvd
    have hle : 2 * L ≤ L := Nat.le_of_dvd (by omega) hdvd
    omega
  obtain ⟨ξ, hξ, hne⟩ := rootOfUnityPowerNotOneExists (by omega : 1 ≤ 2 * L) hndvd
  have hsquare : (ξ ^ L) ^ 2 = 1 := by
    calc
      (ξ ^ L) ^ 2 = ξ ^ (2 * L) := by rw [mul_comm 2 L, pow_mul]
      _ = 1 := hξ
  have hfactor : (ξ ^ L - 1) * (ξ ^ L + 1) = 0 := by
    calc
      (ξ ^ L - 1) * (ξ ^ L + 1) = (ξ ^ L) ^ 2 - 1 := by ring
      _ = 0 := by rw [hsquare]; ring
  have hright : ξ ^ L + 1 = 0 := by
    rcases mul_eq_zero.mp hfactor with hleft | hright
    · exact False.elim (hne (sub_eq_zero.mp hleft))
    · exact hright
  exact ⟨ξ, hξ, eq_neg_of_add_eq_zero_left hright⟩

end Ising2DLambda.KacWard
