/-
章「熱力学極限」の「有理円板内の重複度付きの Fisher 零点の個数」
（`def_fisher_zero_mult_count_in_rational_disc`）の具体版。定義ブロックなので必要十分版は無い。

  人手証明                                                          このファイル
  F_L ∩ D(c,r) は有限集合                                            `fisherZeroSet_inter_rationalDisc_finite`
  Ẑ_L^F ≠ 0 なので各点の重複度が定まる                              `integerPolynomialQbarLift_partitionPolynomial_ne_zero`
  N^mult_L(c,r) := Σ_{ξ ∈ F_L ∩ D(c,r)} mult_ξ(Ẑ_L^F) ∈ ℕ           `fisherZeroMultCountInRationalDisc`
  和を取る有限集合の元の個数は N_L(c,r) である                      `fisherZeroMultCount_index_card`

住処: Qbar と ℕ。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroCountInRationalDisc
import Ising2DLambda.ThermodynamicLimit.FisherZeroFinsetCardBound
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicity

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 和を取る添字集合。`F_L ∩ D(c,r)` を有限集合として読んだもの。 -/
noncomputable def fisherZeroMultCountIndex
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) : Finset Qbar :=
  (fisherZeroSet_inter_rationalDisc_finite L data c r).toFinset

/-- `def_fisher_zero_mult_count_in_rational_disc` の具体版:
`N^mult_L(c,r) := Σ_{ξ ∈ F_L ∩ D(c,r)} mult_ξ(Ẑ_L^F)`。
各項の重複度が定まるのは `Ẑ_L^F ≠ 0` による。 -/
noncomputable def fisherZeroMultCountInRationalDisc
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) : ℕ :=
  ∑ ξ ∈ fisherZeroMultCountIndex L data c r,
    qbarRootMultiplicity ξ (integerPolynomialQbarLift (partitionPolynomial L))
      (integerPolynomialQbarLift_partitionPolynomial_ne_zero L)

/-- 添字集合の所属は共通部分の所属と同じである（定義の展開だけ）。 -/
theorem mem_fisherZeroMultCountIndex
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) (ξ : Qbar) :
    ξ ∈ fisherZeroMultCountIndex L data c r
      ↔ ξ ∈ FisherZeroSet L ∩ rationalDisc data c r := by
  simp [fisherZeroMultCountIndex]

/-- 和を取る有限集合の元の個数は `N_L(c,r)` である（重複度を数えない個数）。 -/
theorem fisherZeroMultCount_index_card
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    (fisherZeroMultCountIndex L data c r).card = fisherZeroCountInRationalDisc L data c r :=
  (Set.ncard_eq_toFinset_card (FisherZeroSet L ∩ rationalDisc data c r)
    (fisherZeroSet_inter_rationalDisc_finite L data c r)).symm

end Ising2DLambda.ThermodynamicLimit
