/- 二つの具体版を、それぞれの必要十分版から導く。 -/
import Ising2DLambda.FisherZero.FreeEntropyDualRelation
import Ising2DLambda.NecSuf.FisherZero.FreeEntropyDualRelation

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial Ising2DLambda.FreeEntropy

theorem partitionValueDualFactorization_from_necSuf (L : ℕ) [NeZero L]
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L) =
      (1 + q) ^ (2 * L ^ 2) * dualSectorValueSum L q := by
  have hLow := congrArg (intPolynomialEval q)
    (partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial L)
  have hMixed := congrArg (intPolynomialEval q) (mixedBoundaryDualityIdentity L)
  simp only [intPolynomialEval_add, intPolynomialEval_mul, intPolynomialEval_pow] at hLow hMixed
  have hLow' : Polynomial.aeval q (partitionPolynomial L) =
      2 * intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)) := by
    rw [← intPolynomialEval_eq_aeval]
    simpa [intPolynomialEval] using hLow
  have hMixed' :
      2 ^ (L ^ 2 + 1) * intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)) =
        intPolynomialEval q (highTemperatureSectorPolynomial L (0, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (0, 1)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 1)) := by
    simpa [intPolynomialEval] using hMixed.symm
  exact Ising2DLambda.NecSuf.FisherZero.partition_value_dual_factorization_necSuf
    (L ^ 2) (2 * L ^ 2)
    (Polynomial.aeval q (partitionPolynomial L))
    (intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)))
    (intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (0, 0)))
    (intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (0, 1)))
    (intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (1, 0)))
    (intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (1, 1)))
    (intPolynomialEval q (highTemperatureSectorPolynomial L (0, 0)))
    (intPolynomialEval q (highTemperatureSectorPolynomial L (0, 1)))
    (intPolynomialEval q (highTemperatureSectorPolynomial L (1, 0)))
    (intPolynomialEval q (highTemperatureSectorPolynomial L (1, 1)))
    (1 + q) hLow' hMixed'
    (sectorValueDuality L (0, 0) hq) (sectorValueDuality L (0, 1) hq)
    (sectorValueDuality L (1, 0) hq) (sectorValueDuality L (1, 1) hq)

theorem freeEntropyDualRelation_from_necSuf (L : ℕ) [NeZero L]
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + freeEntropy L q =
      (2 * L ^ 2) • logRat (1 + q) + logRat (dualSectorValueSum L q) := by
  rcases hq with ⟨hqPos, hqLtOne⟩
  have hOnePlus : 0 < 1 + q := by linarith
  have hZ : 0 < Polynomial.aeval q (partitionPolynomial L) :=
    partitionPolynomial_eval_pos L hqPos
  have hFactor := partitionValueDualFactorization_from_necSuf L ⟨hqPos, hqLtOne⟩
  have hSum : 0 < dualSectorValueSum L q := by
    have hLeft : 0 < 2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L) :=
      mul_pos (pow_pos (by norm_num) _) hZ
    have hCommon : 0 < (1 + q) ^ (2 * L ^ 2) := pow_pos hOnePlus _
    nlinarith
  apply Ising2DLambda.NecSuf.FisherZero.free_entropy_dual_relation_necSuf
    (L ^ 2) (2 * L ^ 2)
    (generator ⟨2, Nat.prime_two⟩) (freeEntropy L q) (logRat 2)
    (logRat (Polynomial.aeval q (partitionPolynomial L)))
    (logRat (2 ^ (L ^ 2)))
    (logRat (2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L)))
    (logRat ((1 + q) ^ (2 * L ^ 2) * dualSectorValueSum L q))
    (logRat ((1 + q) ^ (2 * L ^ 2))) (logRat (1 + q))
    (logRat (dualSectorValueSum L q))
  · rfl
  · exact logRat_two.symm
  · exact (logRat_pow (by norm_num : (0 : ℚ) < 2) (L ^ 2)).symm
  · exact (logRat_mul (pow_pos (by norm_num) _) hZ).symm
  · exact congrArg logRat hFactor
  · exact logRat_mul (pow_pos hOnePlus _) hSum
  · exact logRat_pow hOnePlus (2 * L ^ 2)

end Ising2DLambda.FisherZero
