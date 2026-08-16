/- 必要十分版を具体的な Λ_ℚ・共通分母・Λ の順序へ特殊化する。
添字は `ℕ`、良さは `N ≥ 1`、`Rep` は `IsCommonDenominator`、`le` は `logOrderLE`、
作用は `sI c N := den(c)·N`、`sX c λ := c·λ`、`sY c ν := num(c)·ν`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupNonnegScalarMonotone
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupNonnegScalarMonotone

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_ratSmul_of_nonneg_from_necSuf {c : ℚ} (hc : 0 ≤ c)
    {l m : RationalLogOrderGroup} (h : rationalLogOrderLE l m) :
    rationalLogOrderLE (c • l) (c • m) := by
  have hnum : 0 ≤ c.num := Rat.num_nonneg.mpr hc
  obtain ⟨u, hu⟩ : ∃ u : ℕ, (u : ℤ) = c.num := ⟨c.num.toNat, Int.toNat_of_nonneg hnum⟩
  exact NecSuf.ThermodynamicLimit.indexedLE_scale_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N)
    logOrderLE (fun (c : ℚ) (N : ℕ) => c.den * N) (fun (c : ℚ) l => c • l)
    (fun (c : ℚ) ν => c.num • ν) c
    (fun N hN => Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.pos_iff_ne_zero.mp c.den_pos) (Nat.one_le_iff_ne_zero.mp hN)))
    (fun N l lN hl => commonDenominator_ratSmul c N l lN hl)
    (fun a b hab => by rw [← hu]; exact logOrderLE_natSmul_of_le u hab) h

end Ising2DLambda.ThermodynamicLimit
