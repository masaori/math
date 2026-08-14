/-
「分配多項式の値の双対分解」と「双対な点どうしの自由エントロピーの関係」の具体版。
人手証明と同じく、四セクターの多項式恒等式を有理点で評価して共通因子を括り出し、
正値性を確認してから対数の加法性と冪の法則を一段ずつ適用する。
住処は Q と Lambda であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.MixedBoundaryDualityIdentity
import Ising2DLambda.FisherZero.SectorValueDuality
import Ising2DLambda.FreeEntropy.Additivity
import Ising2DLambda.FreeEntropy.AtOne
import Ising2DLambda.FreeEntropy.ValuePositive

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial Ising2DLambda.FreeEntropy

noncomputable def dualSectorValueSum (L : ℕ) [NeZero L] (q : ℚ) : ℚ :=
  intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (0, 0)) +
    intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (0, 1)) +
    intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (1, 0)) +
    intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L (1, 1))

lemma intPolynomialEval_eq_aeval (q : ℚ) (f : Polynomial ℤ) :
    intPolynomialEval q f = Polynomial.aeval q f := by
  rw [Polynomial.aeval_def]
  rfl

/-- `claim_partition_value_dual_factorization` の具体版。 -/
theorem partitionValueDualFactorization (L : ℕ) [NeZero L]
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
      intPolynomialEval q (highTemperatureSectorPolynomial L (0, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (0, 1)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 1)) =
        2 ^ (L ^ 2 + 1) *
          intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)) := by
    simpa [intPolynomialEval] using hMixed
  calc
    2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L) =
        2 ^ (L ^ 2) *
          (2 * intPolynomialEval q (sectorGeneratingPolynomial L (0, 0))) := by rw [hLow']
    _ = (2 ^ (L ^ 2) * 2) *
          intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)) := by rw [mul_assoc]
    _ = 2 ^ (L ^ 2 + 1) *
          intPolynomialEval q (sectorGeneratingPolynomial L (0, 0)) := by rw [← pow_succ]
    _ = intPolynomialEval q (highTemperatureSectorPolynomial L (0, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (0, 1)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 0)) +
          intPolynomialEval q (highTemperatureSectorPolynomial L (1, 1)) := hMixed'.symm
    _ = (1 + q) ^ (2 * L ^ 2) * dualSectorValueSum L q := by
      rw [sectorValueDuality L (0, 0) hq, sectorValueDuality L (0, 1) hq,
        sectorValueDuality L (1, 0) hq, sectorValueDuality L (1, 1) hq]
      simp only [dualSectorValueSum]
      ring

/-- `claim_free_entropy_dual_relation` の具体版。 -/
theorem freeEntropyDualRelation (L : ℕ) [NeZero L]
    {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + freeEntropy L q =
      (2 * L ^ 2) • logRat (1 + q) + logRat (dualSectorValueSum L q) := by
  rcases hq with ⟨hqPos, hqLtOne⟩
  have hOnePlus : 0 < 1 + q := by linarith
  have hZ : 0 < Polynomial.aeval q (partitionPolynomial L) :=
    partitionPolynomial_eval_pos L hqPos
  have hFactor := partitionValueDualFactorization L ⟨hqPos, hqLtOne⟩
  have hSum : 0 < dualSectorValueSum L q := by
    have hLeft : 0 < 2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L) :=
      mul_pos (pow_pos (by norm_num) _) hZ
    have hCommon : 0 < (1 + q) ^ (2 * L ^ 2) := pow_pos hOnePlus _
    nlinarith
  calc
    (L ^ 2) • generator ⟨2, Nat.prime_two⟩ + freeEntropy L q =
        (L ^ 2) • logRat 2 + logRat (Polynomial.aeval q (partitionPolynomial L)) := by
      rw [freeEntropy, logRat_two]
    _ = logRat (2 ^ (L ^ 2)) + logRat (Polynomial.aeval q (partitionPolynomial L)) := by
      rw [logRat_pow (by norm_num : (0 : ℚ) < 2)]
    _ = logRat (2 ^ (L ^ 2) * Polynomial.aeval q (partitionPolynomial L)) := by
      rw [logRat_mul (pow_pos (by norm_num) _) hZ]
    _ = logRat ((1 + q) ^ (2 * L ^ 2) * dualSectorValueSum L q) := by rw [hFactor]
    _ = logRat ((1 + q) ^ (2 * L ^ 2)) + logRat (dualSectorValueSum L q) := by
      rw [logRat_mul (pow_pos hOnePlus _) hSum]
    _ = (2 * L ^ 2) • logRat (1 + q) + logRat (dualSectorValueSum L q) := by
      rw [logRat_pow hOnePlus]

end Ising2DLambda.FisherZero
