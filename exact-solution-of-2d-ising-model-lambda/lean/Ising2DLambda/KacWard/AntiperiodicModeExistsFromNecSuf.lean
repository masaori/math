import Ising2DLambda.KacWard.AntiperiodicModeExists
import Ising2DLambda.NecSuf.KacWard.AntiperiodicModeExists

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem antiperiodicMode_exists_from_necSuf (L : ℕ) (hL : 1 ≤ L) :
    ∃ ξ ∈ RootOfUnity (2 * L), ξ ^ L = (-1 : Qbar) := by
  have hndvd : ¬ 2 * L ∣ L := by
    intro hdvd
    have hle : 2 * L ≤ L := Nat.le_of_dvd (by omega) hdvd
    omega
  obtain ⟨ξ, hroot, hne⟩ := rootOfUnityPowerNotOneExists
    (by omega : 1 ≤ 2 * L) hndvd
  obtain ⟨η, hη, hηneg⟩ :=
    Ising2DLambda.NecSuf.KacWard.antiperiodicMode_exists_necSuf L
      (R := Qbar) ⟨ξ, hroot, hne⟩
  exact ⟨η, hη, hηneg⟩

end Ising2DLambda.KacWard
