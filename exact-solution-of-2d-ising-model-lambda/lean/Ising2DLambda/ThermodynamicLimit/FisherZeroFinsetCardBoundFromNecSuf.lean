/-
「有限格子の Fisher 零点の有限部分集合の個数は 2L^2 を超えない」の具体版が、
必要十分版 `finset_card_le_of_subset_root_set_necSuf` の特殊化として得られることの導出。
P を Qbar[t]、α を Qbar、M を ℕ、p を Ẑ_L^F、n を 2L^2、coeff を Ω_L、total を 2^{L^2}、
F を F_L に取り、cardBound に `qbarDistinctRootsCardLe` を渡す。
-/
import Ising2DLambda.ThermodynamicLimit.FisherZeroFinsetCardBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.FisherZeroFinsetCardBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial

theorem fisherZeroSet_finset_card_le_from_necSuf (L : ℕ) [NeZero L]
    (S : Finset Qbar) (hS : ∀ w ∈ S, w ∈ FisherZeroSet L) :
    S.card ≤ 2 * L ^ 2 :=
  NecSuf.ThermodynamicLimit.finset_card_le_of_subset_root_set_necSuf
    (0 : QbarPoly)
    (fun p w => qbarPolyEval w p = 0)
    (fun n p => ∀ k : ℕ, n < k → p.coeff k = 0)
    (fun p s n hpne hbound hroot => qbarDistinctRootsCardLe p s n hpne hbound hroot)
    (integerPolynomialQbarLift (partitionPolynomial L)) (2 * L ^ 2)
    (fun m => PartitionPolynomial.multiplicity L m) ((2 : ℕ) ^ L ^ 2)
    (by
      intro hzero m hm
      have hle : m ≤ 2 * L ^ 2 := Nat.lt_succ_iff.mp (Finset.mem_range.mp hm)
      have hcoeff : ((PartitionPolynomial.multiplicity L m : ℤ) : Qbar)
          = (integerPolynomialQbarLift (partitionPolynomial L)).coeff m := by
        rw [integerPolynomialQbarLift_coeff, partitionPolynomial_coeff, if_pos hle]
      rw [hzero, Polynomial.coeff_zero] at hcoeff
      exact_mod_cast hcoeff)
    (multiplicity_sum_eq_two_pow L).symm
    (pow_ne_zero _ (by norm_num : (2 : ℕ) ≠ 0))
    (fun k hk => integerPolynomialQbarLift_partitionPolynomial_coeff_eq_zero_of_lt L k hk)
    (FisherZeroSet L)
    (fun w hw => by
      calc qbarPolyEval w (integerPolynomialQbarLift (partitionPolynomial L))
          = qbarPolynomialEval w (partitionPolynomial L) :=
            qbarPolyEval_integerPolynomialQbarLift w (partitionPolynomial L)
        _ = 0 := (mem_fisherZero).mp hw)
    S hS

end Ising2DLambda.ThermodynamicLimit
