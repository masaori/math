/- 具体版が必要十分版の特殊化であることの導出。住処: Z。 -/
import Ising2DLambda.FisherZero.HighTemperatureSectorDecomposition
import Ising2DLambda.NecSuf.FisherZero.HighTemperatureSectorDecomposition

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

theorem highTemperatureSectorDecomposition_from_necSuf (L : ℕ) [NeZero L] :
    highTemperaturePolynomial L =
      highTemperatureSectorPolynomial L (0, 0) +
      highTemperatureSectorPolynomial L (0, 1) +
      highTemperatureSectorPolynomial L (1, 0) +
      highTemperatureSectorPolynomial L (1, 1) := by
  classical
  let source := (univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L)
  let weight := fun A : Finset (Edge L) =>
      ((1 : Polynomial ℤ) + Polynomial.X) ^ (2 * L ^ 2 - A.card) *
        ((1 : Polynomial ℤ) - Polynomial.X) ^ A.card
  have h := Ising2DLambda.NecSuf.FisherZero.sum_eq_sum_label_fibers_necSuf
    source (torusHomologySector L) weight
  calc
    -- 本文の最初の等号: H_L の定義。
    highTemperaturePolynomial L = ∑ A ∈ source, weight A := rfl
    -- 二つ目の等号: 必要十分版へ実際の偶部分グラフ・巻き付き偶奇・重みを渡す。
    _ = ∑ sector : Fin 2 × Fin 2,
          ∑ A ∈ source.filter (fun A => torusHomologySector L A = sector), weight A := h
    -- 三つ目の等号: セクターの所属条件。
    _ = ∑ sector : Fin 2 × Fin 2,
          ∑ A ∈ (univ : Finset (Finset (Edge L))).filter
            (fun A => IsInTorusHomologySector L A sector), weight A := by
      simp only [source, Finset.filter_filter, IsInTorusHomologySector]
    -- 四つ目の等号: H_L^{a,b} の定義。
    _ = ∑ sector : Fin 2 × Fin 2, highTemperatureSectorPolynomial L sector := rfl
    -- 五つ目の等号: 四つの組の列挙。
    _ = highTemperatureSectorPolynomial L (0, 0) +
          highTemperatureSectorPolynomial L (0, 1) +
          highTemperatureSectorPolynomial L (1, 0) +
          highTemperatureSectorPolynomial L (1, 1) := by
      simp only [Fintype.sum_prod_type, Fin.sum_univ_two, add_assoc]

end Ising2DLambda.FisherZero
