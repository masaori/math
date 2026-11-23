/-
人手証明の主張「臨界点は Fisher 零点でない」
（ラベル `claim_critical_point_not_fisher_zero`）の具体版。

人手証明との対応:

  準備    臨界点での評価値を係数表示で有限和に書き（claim_coefficient_representation）、
          その値を正錐の元として取り出す（claim_critical_partition_value_mem_positive_cone）
  背理法  x_c ∈ F_L と仮定すると評価値が零になる（def_finite_lattice_fisher_zeros）
  第 1 段 零になった値の表示が (0,0) になる（claim_quadratic_zero_representation）
  第 2 段 (0,0) は正錐の三条件のどれも満たさない（def_quadratic_positive_cone）
  結論    正錐への所属と矛盾する。ゆえに x_c ∉ F_L

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.CriticalPartitionValuePositiveCone
import Ising2DLambda.FisherZero.QuadraticZeroNegation

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

/-- 臨界点は有限格子の Fisher 零点ではない。 -/
theorem criticalPoint_not_mem_fisherZero (L : ℕ) [NeZero L] (s : Qbar)
    (hs : s * s = algebraMap ℚ Qbar 2) :
    (criticalPoint s : Qbar) ∉ FisherZeroSet L := by
  -- 準備の第 1 の等号。係数表示（claim_coefficient_representation）で評価値を有限和に書く。
  have hsum : qbarPolynomialEval (criticalPoint s : Qbar) (partitionPolynomial L) =
      ∑ m ∈ Finset.range (2 * L ^ 2 + 1),
        (PartitionPolynomial.multiplicity L m : Qbar) * (criticalPoint s : Qbar) ^ m :=
    qbarPolynomialEval_partitionPolynomial_eq_sum_multiplicity_qbar L (criticalPoint s : Qbar)
  -- 準備の残り。その値 xi は正錐の元である。
  obtain ⟨xi, hcoe, hpos⟩ := criticalPartitionValue_mem_positiveCone L s hs
  have hxiSum : (xi : Qbar) =
      ∑ m ∈ Finset.range (2 * L ^ 2 + 1),
        (PartitionPolynomial.multiplicity L m : Qbar) * (criticalPoint s : Qbar) ^ m :=
    hcoe.trans hsum
  -- 背理法。x_c ∈ F_L と仮定すると評価値が零になる。
  intro hroot
  have hzero : qbarPolynomialEval (criticalPoint s : Qbar) (partitionPolynomial L) = 0 :=
    (mem_fisherZero).1 hroot
  have hxi0 : (xi : Qbar) = 0 := by
    calc
      (xi : Qbar) = ∑ m ∈ Finset.range (2 * L ^ 2 + 1),
          (PartitionPolynomial.multiplicity L m : Qbar) * (criticalPoint s : Qbar) ^ m := hxiSum
      _ = qbarPolynomialEval (criticalPoint s : Qbar) (partitionPolynomial L) := hsum.symm
      _ = 0 := hzero
  -- 第 1 段。零元の表示は (0,0) である。
  have hrep : quadraticRepresentation s xi = (0, 0) :=
    (quadraticRepresentation_eq_zero_iff s hs xi).1 hxi0
  -- 第 2 段。(0,0) は正錐の三条件のどれも満たさない。
  change quadraticCoefficientPositive (quadraticRepresentation s xi) at hpos
  rw [hrep] at hpos
  rcases hpos with ⟨-, -, hne⟩ | ⟨ha, -, -⟩ | ⟨ha, -, -⟩
  · exact hne rfl
  · exact lt_irrefl 0 ha
  · exact lt_irrefl 0 ha

end Ising2DLambda.FisherZero
