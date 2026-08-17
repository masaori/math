/-
章「熱力学極限」の「有理円板内の有限格子の Fisher 零点の個数」（`def_fisher_zero_count_in_rational_disc`）の具体版。
定義ブロックなので必要十分版は無い。

  人手証明                                                          このファイル
  F_L ∩ D(c,r) は有限集合 F_L の部分集合なので有限集合             `fisherZeroSet_inter_rationalDisc_finite`
  N_L(c,r) := |F_L ∩ D(c,r)| ∈ ℕ                                    `fisherZeroCountInRationalDisc`
  N_L(c,r) ≤ |F_L|（有限集合の部分集合の元の個数は全体以下）       `fisherZeroCountInRationalDisc_le_ncard`

住処: Qbar と ℕ。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalDisc
import Ising2DLambda.ThermodynamicLimit.FisherZeroSetFiniteCardBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero

variable (L : ℕ) [NeZero L]

/-- 共通部分 `F_L ∩ D(c,r)` は有限集合 `F_L`（`claim_fisher_zero_set_finite_card_bound`）の
部分集合なので有限集合である。 -/
theorem fisherZeroSet_inter_rationalDisc_finite
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    (FisherZeroSet L ∩ rationalDisc data c r).Finite :=
  (fisherZeroSet_finite_ncard_le L).1.subset Set.inter_subset_left

/-- `def_fisher_zero_count_in_rational_disc` の具体版: `N_L(c,r) := |F_L ∩ D(c,r)| ∈ ℕ`。 -/
noncomputable def fisherZeroCountInRationalDisc
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) : ℕ :=
  (FisherZeroSet L ∩ rationalDisc data c r).ncard

/-- `N_L(c,r) ≤ |F_L|`（有限集合の部分集合の元の個数は全体の元の個数を超えない）。 -/
theorem fisherZeroCountInRationalDisc_le_ncard
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroCountInRationalDisc L data c r ≤ (FisherZeroSet L).ncard :=
  Set.ncard_le_ncard Set.inter_subset_left (fisherZeroSet_finite_ncard_le L).1

end Ising2DLambda.ThermodynamicLimit
