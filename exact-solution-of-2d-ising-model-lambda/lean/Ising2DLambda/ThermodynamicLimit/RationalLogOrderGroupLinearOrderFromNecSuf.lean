/- 必要十分版を具体的な Λ_ℚ・共通分母・Λ の順序へ特殊化する。
添字は `ℕ`、良さは `N ≥ 1`、`Rep` は `IsCommonDenominator`、`le` は `logOrderLE`。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 具体版の定義は必要十分版の `indexedLE` の特殊化そのものである。 -/
theorem rationalLogOrderLE_eq_indexedLE :
    rationalLogOrderLE =
      NecSuf.ThermodynamicLimit.indexedLE IsCommonDenominator (fun N : ℕ => 1 ≤ N) logOrderLE := rfl

private theorem hex2 (l m : RationalLogOrderGroup) :
    ∃ (N : ℕ) (lN mN : LogOrderGroup),
      1 ≤ N ∧ IsCommonDenominator N l lN ∧ IsCommonDenominator N m mN := by
  obtain ⟨N, lN, mN, _, hN, hl, hm, _⟩ := commonDenominator_three_exists l m m
  exact ⟨N, lN, mN, hN, hl, hm⟩

private theorem hind (N N' : ℕ) (l m : RationalLogOrderGroup) (lN mN lN' mN' : LogOrderGroup)
    (hN : 1 ≤ N) (hN' : 1 ≤ N')
    (hl : IsCommonDenominator N l lN) (hm : IsCommonDenominator N m mN)
    (hl' : IsCommonDenominator N' l lN') (hm' : IsCommonDenominator N' m mN') :
    logOrderLE lN mN ↔ logOrderLE lN' mN' :=
  commonDenominator_order_independent N N' hN hN' l m lN mN lN' mN' hl hm hl' hm'

theorem rationalLogOrderLE_refl_from_necSuf (l : RationalLogOrderGroup) : rationalLogOrderLE l l :=
  NecSuf.ThermodynamicLimit.indexedLE_refl_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N) logOrderLE
    (fun x => ⟨denominatorProduct x, _, denominatorProduct_pos x, commonDenominator_exists x⟩)
    logOrderLE_refl l

theorem rationalLogOrderLE_trans_from_necSuf {l m n : RationalLogOrderGroup}
    (h1 : rationalLogOrderLE l m) (h2 : rationalLogOrderLE m n) : rationalLogOrderLE l n :=
  NecSuf.ThermodynamicLimit.indexedLE_trans_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N) logOrderLE
    commonDenominator_three_exists hind (fun _ _ _ => logOrderLE_trans) h1 h2

theorem rationalLogOrderLE_antisymm_from_necSuf {l m : RationalLogOrderGroup}
    (h1 : rationalLogOrderLE l m) (h2 : rationalLogOrderLE m l) : l = m :=
  NecSuf.ThermodynamicLimit.indexedLE_antisymm_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N)
    logOrderLE hex2 hind (fun _ _ => logOrderLE_antisymm)
    (fun N x y w hN hx hy => eq_of_commonDenominator_witness_eq N hN x y w hx hy) h1 h2

theorem rationalLogOrderLE_total_from_necSuf (l m : RationalLogOrderGroup) :
    rationalLogOrderLE l m ∨ rationalLogOrderLE m l :=
  NecSuf.ThermodynamicLimit.indexedLE_total_necSuf IsCommonDenominator (fun N : ℕ => 1 ≤ N)
    logOrderLE hex2 logOrderLE_total l m

end Ising2DLambda.ThermodynamicLimit
