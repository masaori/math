/- `claim_sector_value_duality` の具体版を必要十分版から導く。 -/
import Ising2DLambda.FisherZero.SectorValueDuality
import Ising2DLambda.NecSuf.FisherZero.SectorValueDuality

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem sectorValueDuality_from_necSuf (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) {q : ℚ} (hq : q ∈ unitIntervalRationals) :
    intPolynomialEval q (highTemperatureSectorPolynomial L sector) =
      (1 + q) ^ (2 * L ^ 2) *
        intPolynomialEval (kwDualRational q) (sectorGeneratingPolynomial L sector) := by
  classical
  rcases hq with ⟨hqPositive, hqLtOne⟩
  have hOnePlusPositive : 0 < 1 + q := by linarith
  have hOnePlusNe : 1 + q ≠ 0 := ne_of_gt hOnePlusPositive
  have hDual : (1 + q) * kwDualRational q = 1 - q := by
    calc
      (1 + q) * kwDualRational q =
          (1 + q) * ((1 - q) * (1 + q)⁻¹) := by
        rw [kwDualRational]
      _ = (1 - q) * ((1 + q) * (1 + q)⁻¹) := by ring
      _ = (1 - q) * 1 := by rw [mul_inv_cancel₀ hOnePlusNe]
      _ = 1 - q := by rw [mul_one]
  rw [highTemperatureSectorPolynomial, sectorGeneratingPolynomial]
  simp only [intPolynomialEval_sum, intPolynomialEval_mul, intPolynomialEval_pow,
    intPolynomialEval_add, intPolynomialEval_sub, intPolynomialEval_one,
    intPolynomialEval_X, ← hDual]
  exact Ising2DLambda.NecSuf.FisherZero.sector_value_duality_necSuf
    ((Finset.univ : Finset (Finset (Edge L))).filter
      (fun A => IsInTorusHomologySector L A sector))
    (2 * L ^ 2) Finset.card (1 + q) (kwDualRational q)
    (by
      intro A hA
      calc
        A.card ≤ Fintype.card (Edge L) := Finset.card_le_univ A
        _ = 2 * L ^ 2 := card_edge L)

end Ising2DLambda.FisherZero
