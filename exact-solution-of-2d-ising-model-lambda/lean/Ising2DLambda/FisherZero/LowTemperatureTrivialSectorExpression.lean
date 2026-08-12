/-
「低温展開の自明セクター表示」の具体版。
人手証明と同じく、双対辺写像が実現できる破れた辺集合と自明セクターの間に
与える全単射で有限和の添字を取り替え、Z_L = 2 D_L とつなぐ。
住処は有限集合と Z[x] であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.AttainableDualImageTrivialSector
import Ising2DLambda.FisherZero.LowTemperaturePolynomialFromNecSuf
import Ising2DLambda.NecSuf.FisherZero.LowTemperatureTrivialSectorExpression

namespace Ising2DLambda.FisherZero

open Finset Ising2DLambda.PartitionPolynomial

/-- セクター `sector` に属する偶部分グラフの生成多項式 `G_L^{a,b}`。 -/
noncomputable def sectorGeneratingPolynomial (L : ℕ) [NeZero L]
    (sector : Fin 2 × Fin 2) : Polynomial ℤ := by
  classical
  exact ∑ A ∈ univ.filter (fun A : Finset (Edge L) => IsInTorusHomologySector L A sector),
    Polynomial.X ^ A.card

/-- 双対辺写像は辺の有限部分集合の元数を保つ。 -/
theorem card_image_dualEdgeEquiv (L : ℕ) [NeZero L] (B : Finset (Edge L)) :
    (B.image (dualEdgeEquiv L)).card = B.card := by
  exact card_image_iff.mpr fun _ _ _ _ h => (dualEdgeEquiv L).injective h

/-- `claim_low_temperature_trivial_sector_expression` の具体版。 -/
theorem partitionPolynomial_eq_two_mul_trivialSectorGeneratingPolynomial
    (L : ℕ) [NeZero L] :
    partitionPolynomial L = 2 * sectorGeneratingPolynomial L (0, 0) := by
  classical
  have hsum :
      lowTemperaturePolynomial L = sectorGeneratingPolynomial L (0, 0) := by
    rw [lowTemperaturePolynomial, sectorGeneratingPolynomial]
    apply Ising2DLambda.NecSuf.FisherZero.weighted_sum_eq_of_inverse_necSuf
      (attainableBrokenEdgeSets L) (trivialSectorEdgeSets L)
      (fun B => B.image (dualEdgeEquiv L))
      (fun A => A.image (dualEdgeEquiv L).symm)
      (sourceWeight := fun B => (Polynomial.X : Polynomial ℤ) ^ B.card)
      (targetWeight := fun A => (Polynomial.X : Polynomial ℤ) ^ A.card)
    · intro B hB
      rw [← attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets L]
      exact mem_image_of_mem _ hB
    · intro A hA
      have hImage : A.image (dualEdgeEquiv L).symm ∈ attainableBrokenEdgeSets L := by
        rw [← attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets L] at hA
        rw [attainableDualBrokenEdgeSets, mem_image] at hA
        obtain ⟨B, hB, hBA⟩ := hA
        rw [← hBA]
        have hround :
            (B.image (dualEdgeEquiv L)).image (dualEdgeEquiv L).symm = B := by
          ext e
          simp
        rw [hround]
        exact hB
      exact hImage
    · intro B _
      ext e
      simp
    · intro A _
      ext e
      simp
    · intro B _
      rw [card_image_dualEdgeEquiv]
  calc
    partitionPolynomial L
        = 2 * lowTemperaturePolynomial L :=
          partitionPolynomial_eq_two_mul_lowTemperaturePolynomial L
    _ = 2 * sectorGeneratingPolynomial L (0, 0) := by rw [hsum]

end Ising2DLambda.FisherZero
