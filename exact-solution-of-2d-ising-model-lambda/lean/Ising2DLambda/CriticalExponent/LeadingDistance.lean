/-
人手証明 `def_leading_distance` の具体版。

  人手証明                                                     このファイル
  D_L := { y ∈ R | ∃ ξ ∈ F_L, y = dsq_c(ξ) }（有限集合として）  `leadingDistanceFinset`
  D_L の元の特徴づけ                                            `mem_leadingDistanceFinset`
  D_L が空でないこと（`claim_fisher_zero_set_nonempty`）        `leadingDistanceFinset_nonempty`
  d_1(L) := D_L の最小元（`claim_real_algebraic_min_unique`）   `leadingDistance`
  d_1(L) が最小元の条件を満たすこと                             `leadingDistance_isMin`
  最小元の一意性（条件を満たす元は d_1(L) に限る）              `leadingDistance_unique`

有限性は `claim_fisher_zero_set_finite_card_bound`（`fisherZeroSet_finite_ncard_le`）を
証人に取り、`Set.Finite.toFinset` で有限集合として持つ。
住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.FisherZero.RealAlgebraicMinUnique
import Ising2DLambda.FisherZero.DistanceSquaredToCriticalPoint
import Ising2DLambda.FisherZero.FisherZeroSetNonempty
import Ising2DLambda.ThermodynamicLimit.FisherZeroSetFiniteCardBound

namespace Ising2DLambda.CriticalExponent

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.ThermodynamicLimit

/-- `D_L`: Fisher 零点の臨界点への距離の二乗の全体（有限集合）。 -/
noncomputable def leadingDistanceFinset (L : ℕ) [NeZero L]
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    Finset data.carrier :=
  ((fisherZeroSet_finite_ncard_le L).1.image
    (distanceSquaredToCriticalPoint data s hs)).toFinset

/-- `D_L` の元の特徴づけ: ある Fisher 零点の距離の二乗であること。 -/
theorem mem_leadingDistanceFinset (L : ℕ) [NeZero L]
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2)
    (y : data.carrier) :
    y ∈ leadingDistanceFinset L data s hs ↔
      ∃ ξ ∈ FisherZeroSet L, distanceSquaredToCriticalPoint data s hs ξ = y := by
  simp [leadingDistanceFinset, Set.Finite.mem_toFinset, Set.mem_image]

/-- `D_L` は空でない（人手証明: `claim_fisher_zero_set_nonempty` の元の値を取る）。 -/
theorem leadingDistanceFinset_nonempty (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    (leadingDistanceFinset L data s hs).Nonempty := by
  obtain ⟨ξ, hξ⟩ := fisherZeroSet_nonempty L hL
  exact ⟨distanceSquaredToCriticalPoint data s hs ξ,
    (mem_leadingDistanceFinset L data s hs _).mpr ⟨ξ, hξ, rfl⟩⟩

/-- `d_1(L)`: `D_L` の最小元（`claim_real_algebraic_min_unique` によりちょうど 1 つ）。 -/
noncomputable def leadingDistance (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    data.carrier :=
  Classical.choose
    (existsUnique_realAlgebraicMin data
      (leadingDistanceFinset_nonempty L hL data s hs)).exists

/-- `d_1(L)` は `D_L` の最小元の条件を満たす。 -/
theorem leadingDistance_isMin (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2) :
    IsRealAlgebraicMin data (leadingDistanceFinset L data s hs)
      (leadingDistance L hL data s hs) :=
  Classical.choose_spec
    (existsUnique_realAlgebraicMin data
      (leadingDistanceFinset_nonempty L hL data s hs)).exists

/-- 最小元の条件を満たす元は `d_1(L)` に限る（一意性）。 -/
theorem leadingDistance_unique (L : ℕ) [NeZero L] (hL : 2 ≤ L)
    (data : RealClosedSubfieldData) (s : Qbar) (hs : s * s = 2)
    (m : data.carrier)
    (hm : IsRealAlgebraicMin data (leadingDistanceFinset L data s hs) m) :
    m = leadingDistance L hL data s hs :=
  (existsUnique_realAlgebraicMin data
    (leadingDistanceFinset_nonempty L hL data s hs)).unique hm
    (leadingDistance_isMin L hL data s hs)

end Ising2DLambda.CriticalExponent
