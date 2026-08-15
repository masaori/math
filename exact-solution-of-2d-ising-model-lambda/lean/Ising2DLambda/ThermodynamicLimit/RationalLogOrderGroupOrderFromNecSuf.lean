/- 必要十分版を具体的な Λ_ℚ・共通分母・Λ の順序へ特殊化する。 -/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder
import Ising2DLambda.NecSuf.ThermodynamicLimit.RationalLogOrderGroupOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

theorem rationalLogOrderLE_iff_forall_from_necSuf (l m : RationalLogOrderGroup) :
    rationalLogOrderLE l m ↔
      ∀ (N : ℕ) (lN mN : LogOrderGroup),
        1 ≤ N → IsCommonDenominator N l lN → IsCommonDenominator N m mN → logOrderLE lN mN := by
  have hpos : 1 ≤ denominatorProduct l * denominatorProduct m :=
    Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos l))
        (Nat.one_le_iff_ne_zero.mp (denominatorProduct_pos m)))
  obtain ⟨hl, hm⟩ := commonCommonDenominator_exists l m
  have key := NecSuf.ThermodynamicLimit.exists_iff_forall_of_independent_necSuf
    (I := ℕ × LogOrderGroup × LogOrderGroup)
    (fun i => 1 ≤ i.1 ∧ IsCommonDenominator i.1 l i.2.1 ∧ IsCommonDenominator i.1 m i.2.2)
    (fun i => logOrderLE i.2.1 i.2.2)
    ⟨(denominatorProduct l * denominatorProduct m, _, _), hpos, hl, hm⟩
    (fun i j hi hj =>
      commonDenominator_order_independent i.1 j.1 hi.1 hj.1 l m i.2.1 i.2.2 j.2.1 j.2.2
        hi.2.1 hi.2.2 hj.2.1 hj.2.2)
  constructor
  · rintro ⟨N, lN, mN, hN, hl', hm', hle⟩ N' lN' mN' hN' hl'' hm''
    exact key.mp ⟨(N, lN, mN), ⟨hN, hl', hm'⟩, hle⟩ (N', lN', mN') ⟨hN', hl'', hm''⟩
  · intro h
    obtain ⟨⟨N, lN, mN⟩, ⟨hN, hl', hm'⟩, hle⟩ :=
      key.mpr (fun i hi => h i.1 i.2.1 i.2.2 hi.1 hi.2.1 hi.2.2)
    exact ⟨N, lN, mN, hN, hl', hm', hle⟩

end Ising2DLambda.ThermodynamicLimit
