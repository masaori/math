/-
「高温展開の多項式は四つのセクター多項式の和である」の具体版。
人手証明と同じく、偶部分グラフの全体を二つの巻き付き偶奇の値で分け、
その四つのファイバーごとに有限和を分割する。住処は有限集合と Z[x] である。
-/
import Ising2DLambda.FisherZero.HighTemperaturePolynomial
import Ising2DLambda.FisherZero.TorusHomologySector
import Ising2DLambda.NecSuf.FisherZero.HighTemperatureSectorDecomposition

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- セクター `sector` に属する偶部分グラフだけにわたる高温展開の多項式。 -/
noncomputable def highTemperatureSectorPolynomial (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) : Polynomial ℤ := by
  classical
  exact ∑ A ∈ (univ : Finset (Finset (Edge L))).filter
      (fun A => IsInTorusHomologySector L A sector),
    ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
      ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card

/-- 偶部分グラフの有限和は、四つの巻き付きセクターの和に等しい。 -/
theorem highTemperaturePolynomial_eq_sum_sectors (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      ∑ sector : Fin 2 × Fin 2, highTemperatureSectorPolynomial L sector := by
  classical
  rw [highTemperaturePolynomial]
  have h := Ising2DLambda.NecSuf.FisherZero.sum_eq_sum_label_fibers_necSuf
    ((univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L))
    (torusHomologySector L)
    (fun A =>
      ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
        ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card)
  simpa only [highTemperatureSectorPolynomial, IsInTorusHomologySector,
    Finset.filter_filter, and_assoc] using h

/-- `claim_high_temperature_sector_decomposition` の具体版。 -/
theorem highTemperatureSectorDecomposition (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      highTemperatureSectorPolynomial L (0, 0) +
      highTemperatureSectorPolynomial L (0, 1) +
      highTemperatureSectorPolynomial L (1, 0) +
      highTemperatureSectorPolynomial L (1, 1) := by
  rw [highTemperaturePolynomial_eq_sum_sectors]
  simp only [Fintype.sum_prod_type, Fin.sum_univ_two, add_assoc]

end Ising2DLambda.FisherZero
