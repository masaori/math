import Ising2DLambda.KacWard.SignedEvenSubgraphSectorSum

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial

theorem coefficient_sum (sector : Fin 2 × Fin 2) :
    (∑ spin : Fin 2 × Fin 2,
      signedEvenSubgraphCoefficient spin.1 spin.2 sector) =
        if sector = (0, 0) then 4 else 0 := by
  rcases sector with ⟨c, d⟩
  fin_cases c <;> fin_cases d <;>
    simp [signedEvenSubgraphCoefficient, Fintype.sum_prod_type, Fin.sum_univ_two] <;>
    norm_num

/-- Four signed sector polynomials add to twice the partition polynomial. -/
theorem finiteTorusPolynomial (L : ℕ) [NeZero L] :
    (∑ spin : Fin 2 × Fin 2,
      signedEvenSubgraphPolynomial L spin.1 spin.2) =
        2 * partitionPolynomial L := by
  classical
  calc
    (∑ spin : Fin 2 × Fin 2,
        signedEvenSubgraphPolynomial L spin.1 spin.2)
        = ∑ spin : Fin 2 × Fin 2, ∑ sector : Fin 2 × Fin 2,
            signedEvenSubgraphCoefficient spin.1 spin.2 sector *
              sectorGeneratingPolynomial L sector := by
                apply Finset.sum_congr rfl
                intro spin _
                exact signedEvenSubgraphPolynomial_eq_sectorSum L spin.1 spin.2
    _ = ∑ sector : Fin 2 × Fin 2, ∑ spin : Fin 2 × Fin 2,
          signedEvenSubgraphCoefficient spin.1 spin.2 sector *
            sectorGeneratingPolynomial L sector := Finset.sum_comm
    _ = ∑ sector : Fin 2 × Fin 2,
          (∑ spin : Fin 2 × Fin 2,
            signedEvenSubgraphCoefficient spin.1 spin.2 sector) *
              sectorGeneratingPolynomial L sector := by
                apply Finset.sum_congr rfl
                intro sector _
                rw [Finset.sum_mul]
    _ = 4 * sectorGeneratingPolynomial L (0, 0) := by
          simp [coefficient_sum]
    _ = 2 * partitionPolynomial L := by
          rw [partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial]
          ring

end Ising2DLambda.KacWard
