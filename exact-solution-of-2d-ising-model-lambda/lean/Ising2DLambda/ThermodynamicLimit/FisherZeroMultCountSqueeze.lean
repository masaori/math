/-
章「熱力学極限」の零点密度の挟み込み `N_L(c,r) ≤ N^mult_L(c,r) ≤ 2L^2` の具体版。

  人手証明                                                          このファイル
  ξ ∈ F_L ∩ D(c,r) なら aev_ξ(Ẑ_L^F) = Ev^F_ξ(Z_L) = 0             `hroot`
  よって 1 ≤ mult_ξ(Ẑ_L^F)                                          `qbarRootMultiplicityGeOneIffRoot`
  N_L = Σ 1 ≤ Σ mult_ξ = N^mult_L                                   `fisherZeroCount_le_fisherZeroMultCount`
  Ẑ_L^F ≠ 0 と 2L^2 < i で係数が零なので Σ mult_ξ ≤ 2L^2            `fisherZeroMultCount_le_edge_bound`

住処: Qbar と ℕ。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroMultCountInRationalDisc
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityGeOneIffRoot
import Ising2DLambda.ThermodynamicLimit.QbarFiniteRootMultiplicitySumLeCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.FisherZero
open Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 準備: 円板内の零点は持ち上げの根なので、その重複度は 1 以上である。 -/
theorem one_le_fisherZeroMultiplicity
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r})
    (ξ : Qbar) (hξ : ξ ∈ fisherZeroMultCountIndex L data c r) :
    1 ≤ qbarRootMultiplicity ξ (integerPolynomialQbarLift (partitionPolynomial L))
      (integerPolynomialQbarLift_partitionPolynomial_ne_zero L) := by
  have hmem : ξ ∈ FisherZeroSet L :=
    ((mem_fisherZeroMultCountIndex L data c r ξ).mp hξ).1
  have hroot : qbarPolyEval ξ (integerPolynomialQbarLift (partitionPolynomial L)) = 0 := by
    calc qbarPolyEval ξ (integerPolynomialQbarLift (partitionPolynomial L))
        = qbarPolynomialEval ξ (partitionPolynomial L) :=
          qbarPolyEval_integerPolynomialQbarLift ξ (partitionPolynomial L)
      _ = 0 := mem_fisherZero.mp hmem
  exact (qbarRootMultiplicityGeOneIffRoot ξ _
    (integerPolynomialQbarLift_partitionPolynomial_ne_zero L)).mpr hroot

/-- `claim_fisher_zero_count_le_mult_count` の具体版: `N_L(c,r) ≤ N^mult_L(c,r)`。 -/
theorem fisherZeroCount_le_fisherZeroMultCount
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroCountInRationalDisc L data c r ≤ fisherZeroMultCountInRationalDisc L data c r := by
  rw [← fisherZeroMultCount_index_card L data c r, fisherZeroMultCountInRationalDisc]
  calc (fisherZeroMultCountIndex L data c r).card
      = ∑ _ξ ∈ fisherZeroMultCountIndex L data c r, 1 :=
        Finset.card_eq_sum_ones _
    _ ≤ ∑ ξ ∈ fisherZeroMultCountIndex L data c r,
          qbarRootMultiplicity ξ (integerPolynomialQbarLift (partitionPolynomial L))
            (integerPolynomialQbarLift_partitionPolynomial_ne_zero L) :=
        Finset.sum_le_sum (one_le_fisherZeroMultiplicity L data c r)

/-- `claim_fisher_zero_mult_count_le_edge_bound` の具体版: `N^mult_L(c,r) ≤ 2L^2`。 -/
theorem fisherZeroMultCount_le_edge_bound
    (data : RealClosedSubfieldData) (c : ℚ × ℚ) (r : {r : ℚ // 0 < r}) :
    fisherZeroMultCountInRationalDisc L data c r ≤ 2 * L ^ 2 :=
  qbarFiniteRootMultiplicitySumLeCoeffBound
    (integerPolynomialQbarLift (partitionPolynomial L))
    (fisherZeroMultCountIndex L data c r) (2 * L ^ 2)
    (integerPolynomialQbarLift_partitionPolynomial_ne_zero L)
    (integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt L)

end Ising2DLambda.ThermodynamicLimit
