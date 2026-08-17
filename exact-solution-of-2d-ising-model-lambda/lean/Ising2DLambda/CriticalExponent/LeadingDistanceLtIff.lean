/-
人手証明 `claim_leading_distance_lt_iff_close_zero` の具体版。

  人手証明                                                このファイル
  第一条件 → 第二条件（d_1(L) ∈ D_L の証人 ξ を取る）      `leadingDistance_lt_iff` の mp
  第二条件 → 第一条件（最小性の場合分け）                  `leadingDistance_lt_iff` の mpr
    第一の場合（dsq_c(ξ) = d_1(L)）                        `heq ▸ hlt`
    第二の場合（d_1(L) <_R dsq_c(ξ)。推移律）              `realAlgebraicLt_trans`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.CriticalExponent.LeadingDistance

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

/-- 人手証明の主張: `d_1(L) <_R t` と「ある Fisher 零点 ξ で `dsq_c(ξ) <_R t`」は同値。 -/
theorem leadingDistance_lt_iff (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2)
    (t : data.carrier) :
    realAlgebraicLt data (leadingDistance L hL data s hs) t ↔
      ∃ ξ ∈ FisherZeroSet L,
        realAlgebraicLt data (distanceSquaredToCriticalPoint data s hs ξ) t := by
  constructor
  · -- 第一条件 → 第二条件: d_1(L) ∈ D_L の証人 ξ を取る。
    intro h
    obtain ⟨ξ, hξ, heq⟩ :=
      (mem_leadingDistanceFinset L data s hs
        (leadingDistance L hL data s hs)).1
        (leadingDistance_isMin L hL data s hs).1
    -- dsq_c(ξ) = d_1(L) <_R t
    exact ⟨ξ, hξ, heq ▸ h⟩
  · -- 第二条件 → 第一条件: 最小性の場合分け。
    rintro ⟨ξ, hξ, hlt⟩
    have hmem : distanceSquaredToCriticalPoint data s hs ξ ∈
        leadingDistanceFinset L data s hs :=
      (mem_leadingDistanceFinset L data s hs _).2 ⟨ξ, hξ, rfl⟩
    rcases (leadingDistance_isMin L hL data s hs).2 _ hmem with heq | hlt2
    · -- 第一の場合: dsq_c(ξ) = d_1(L) なので書き換える。
      exact heq ▸ hlt
    · -- 第二の場合: d_1(L) <_R dsq_c(ξ) <_R t（推移律）。
      exact realAlgebraicLt_trans data _ _ _ hlt2 hlt

end Ising2DLambda.CriticalExponent
