/-
章「熱力学極限」の「有限格子の Fisher 零点の有限部分集合の個数は 2L^2 を超えない」
（`claim_fisher_zero_finset_card_bound`）の具体版。

  人手証明                                                          このファイル
  準備: ac_k(Ẑ_L^F) = Ω_L(k) (k ≤ 2L^2) / 0 (2L^2 < k)              `partitionPolynomial_coeff`＋`integerPolynomialQbarLift_coeff`
  第 1 の仮定: Ẑ_L^F ≠ 0（零なら Ω_L(m) = 0、総和 2^{L^2} = 0 で矛盾）  `integerPolynomialQbarLift_partitionPolynomial_ne_zero`
  第 2 の仮定: 2L^2 < k なら ac_k(Ẑ_L^F) = 0                          `integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt`
  第 3 の仮定: w ∈ S ⊂ F_L なら aev_w(Ẑ_L^F) = Ev^F_w(Z_L) = 0        `fisherZeroSet_finset_card_le` の中の `hroot`
  `claim_qbar_distinct_roots_card_bound` を当てる                     `qbarDistinctRootsCardLe`

住処: Qbar。実数体・複素数体は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.IntegerPolynomialQbarLiftEvaluation
import Ising2DLambda.AlgebraicEigenvalue.QbarDistinctRootsCardBound
import Ising2DLambda.PartitionPolynomial.CoefficientRepresentation
import Ising2DLambda.PartitionPolynomial.CoefficientSum

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial

variable (L : ℕ) [NeZero L]

/-- 人手証明の準備の土台: `claim_coefficient_representation` を係数ごとに読む。
`Z_L` の `x^k` の係数は `Ω_L(k)`（`k ≤ 2L^2`）、`0`（`2L^2 < k`）。 -/
theorem partitionPolynomial_coeff (k : ℕ) :
    (partitionPolynomial L).coeff k
      = if k ≤ 2 * L ^ 2 then (PartitionPolynomial.multiplicity L k : ℤ) else 0 := by
  rw [partitionPolynomial_eq_sum_multiplicity, Polynomial.finsetSum_coeff]
  simp only [Polynomial.coeff_C_mul_X_pow]
  rw [Finset.sum_ite_eq]
  simp [Finset.mem_range]

/-- 第 1 の仮定: `Ẑ_L^F ≠ 0`。零なら `k ≤ 2L^2` で `Ω_L(k) = 0`、総和 `2^{L^2} = 0` となって矛盾。 -/
theorem integerPolynomialQbarLift_partitionPolynomial_ne_zero :
    integerPolynomialQbarLift (partitionPolynomial L) ≠ 0 := by
  intro hzero
  -- 第 1 の鎖: Ω_L(m) = ac_m(Ẑ_L^F) = ac_m(0) = 0（m ≤ 2L^2）。
  have hmult : ∀ m ∈ Finset.range (2 * L ^ 2 + 1), PartitionPolynomial.multiplicity L m = 0 := by
    intro m hm
    have hle : m ≤ 2 * L ^ 2 := Nat.lt_succ_iff.mp (Finset.mem_range.mp hm)
    have hcoeff : ((PartitionPolynomial.multiplicity L m : ℤ) : Qbar)
        = (integerPolynomialQbarLift (partitionPolynomial L)).coeff m := by
      rw [integerPolynomialQbarLift_coeff, partitionPolynomial_coeff, if_pos hle]
    rw [hzero, Polynomial.coeff_zero] at hcoeff
    exact_mod_cast hcoeff
  -- 第 2 の鎖: 2^{L^2} = Σ Ω_L(m) = Σ 0 = 0。
  have hsum : (2 : ℕ) ^ L ^ 2 = 0 := by
    calc (2 : ℕ) ^ L ^ 2
        = ∑ m ∈ Finset.range (2 * L ^ 2 + 1), PartitionPolynomial.multiplicity L m :=
          (multiplicity_sum_eq_two_pow L).symm
      _ = ∑ m ∈ Finset.range (2 * L ^ 2 + 1), (0 : ℕ) :=
          Finset.sum_congr rfl hmult
      _ = 0 := Finset.sum_const_zero
  exact (pow_ne_zero _ (by norm_num : (2 : ℕ) ≠ 0)) hsum

/-- 第 2 の仮定: `2L^2 < k` なら `ac_k(Ẑ_L^F) = 0`（準備の下の場合）。 -/
theorem integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt (k : ℕ)
    (hk : 2 * L ^ 2 < k) :
    (integerPolynomialQbarLift (partitionPolynomial L)).coeff k = 0 := by
  rw [integerPolynomialQbarLift_coeff, partitionPolynomial_coeff, if_neg (not_le.mpr hk),
    Int.cast_zero]

/-- 主張そのもの: `F_L` の有限部分集合 `S` について `|S| ≤ 2L^2`。 -/
theorem fisherZeroSet_finset_card_le (S : Finset Qbar) (hS : ∀ w ∈ S, w ∈ FisherZeroSet L) :
    S.card ≤ 2 * L ^ 2 := by
  -- 第 3 の仮定: w ∈ S なら aev_w(Ẑ_L^F) = Ev^F_w(Z_L) = 0。
  have hroot : ∀ w ∈ S, qbarPolyEval w (integerPolynomialQbarLift (partitionPolynomial L)) = 0 := by
    intro w hw
    calc qbarPolyEval w (integerPolynomialQbarLift (partitionPolynomial L))
        = qbarPolynomialEval w (partitionPolynomial L) :=
          qbarPolyEval_integerPolynomialQbarLift w (partitionPolynomial L)
      _ = 0 := (mem_fisherZero).mp (hS w hw)
  exact qbarDistinctRootsCardLe (integerPolynomialQbarLift (partitionPolynomial L)) S (2 * L ^ 2)
    (integerPolynomialQbarLift_partitionPolynomial_ne_zero L)
    (fun k hk => integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt L k hk)
    hroot

end Ising2DLambda.ThermodynamicLimit
