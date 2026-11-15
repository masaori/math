import Ising2DLambda.KacWard.DeterminantPolynomialSquareRootExists
import Ising2DLambda.NecSuf.KacWard.DeterminantPolynomialSquareRootExists

/-!
具体版 `kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot`
（`claim_determinant_polynomial_square_root_exists`）を、必要十分版の二つの定理から得る導出版。

* `sum_ite_degree_zero_eq_one_necSuf` を、添字の有限集合 `E_L` の偶部分グラフの全体・次数 `A ↦ |A|`・
  重み（符号の定数項）・`e = ∅` に特殊化して `ac_0(Q^{a,b}_L) = 1` を得る。
* `existsUnique_squareRoot_of_witness_necSuf` を、`P = Qbar[X]`・`c = coeff 0`・`D = D^{a,b}_L`・
  `Q = Q^{a,b}_L` と一意性 `qbarPolynomialSquareRoot_unique` に特殊化する。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.FisherZero
open scoped Classical

theorem signedEvenSubgraphPolynomial_coeff_zero_from_necSuf (L : ℕ) [NeZero L] (a b : Fin 2) :
    (signedEvenSubgraphPolynomial L a b).coeff 0 = 1 := by
  rw [signedEvenSubgraphPolynomial_coeff_zero_eq_sum]
  apply Ising2DLambda.NecSuf.KacWard.sum_ite_degree_zero_eq_one_necSuf
    _ Finset.card _ (∅ : Finset (Edge L))
  · exact Finset.mem_filter.mpr ⟨Finset.mem_univ _, emptyEdgeSubset_isEven L⟩
  · intro A _ hA
    exact Finset.card_eq_zero.mp hA
  · exact Finset.card_empty
  · rw [torusHomologySector_empty]
    simp [signedEvenSubgraphCoefficient]

theorem kacWardDeterminant_existsUnique_qbarPolynomialSquareRoot_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    ∃! S : QbarPoly,
      qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) S := by
  have hc : ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
      (Int.castRingHom Qbar)).coeff 0 = 1 := by
    rw [Polynomial.coeff_map, signedEvenSubgraphPolynomial_coeff_zero_from_necSuf, map_one]
  have hsq : ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) *
      ((signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar)) = kacWardDeterminant (kacWardTransitionMatrix L z s) := by
    rw [← pow_two]
    exact (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq z hz s).symm
  exact Ising2DLambda.NecSuf.KacWard.existsUnique_squareRoot_of_witness_necSuf
    (fun p : QbarPoly => p.coeff 0) _ _ hc hsq
    (fun S T hS hT h => qbarPolynomialSquareRoot_unique S T hS hT h)

end Ising2DLambda.KacWard
