/-
「低温展開の自明セクター表示」の具体版。
人手証明と同じく、双対辺写像が実現できる破れた辺集合と自明セクターの間に
与える全単射で有限和の添字を取り替え、Z_L = 2 D_L とつなぐ。
住処は有限集合と Z[x] であり、R / C は現れない。
-/
import Ising2DLambda.FisherZero.AttainableDualImageTrivialSector
import Ising2DLambda.FisherZero.LowTemperaturePolynomial

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
  let delta : Finset (Edge L) → Finset (Edge L) := fun B => B.image (dualEdgeEquiv L)
  let inverse : Finset (Edge L) → Finset (Edge L) :=
    fun A => A.image (dualEdgeEquiv L).symm
  -- 本文の像の二等号。これが終域と全射性を与える。
  have htarget : (attainableBrokenEdgeSets L).image delta = trivialSectorEdgeSets L := by
    calc
      (attainableBrokenEdgeSets L).image delta
          = attainableDualBrokenEdgeSets L := rfl
      _ = trivialSectorEdgeSets L := attainableDualBrokenEdgeSets_eq_trivialSectorEdgeSets L
  have hleft (B : Finset (Edge L)) : inverse (delta B) = B := by
    ext e
    simp [inverse, delta]
  -- 本文の単射性の三等号。部分集合への逆写像を両辺へ施す。
  have hinjective : Function.Injective delta := by
    intro B B' hBB'
    calc
      B = inverse (delta B) := (hleft B).symm
      _ = inverse (delta B') := congrArg inverse hBB'
      _ = B' := hleft B'
  -- 有限和の再添字付けは、一元追加の帰納法で独立に証明する。
  have hreindex (source : Finset (Finset (Edge L))) :
      (∑ B ∈ source, (Polynomial.X : Polynomial ℤ) ^ (delta B).card) =
        ∑ A ∈ source.image delta, (Polynomial.X : Polynomial ℤ) ^ A.card := by
    induction source using Finset.induction_on with
    | empty => simp only [image_empty, sum_empty]
    | insert B source hB ih =>
      have hnot : delta B ∉ source.image delta := by
        intro hmem
        obtain ⟨B', hB', hEq⟩ := mem_image.mp hmem
        exact hB ((hinjective hEq) ▸ hB')
      calc
        (∑ B' ∈ insert B source, (Polynomial.X : Polynomial ℤ) ^ (delta B').card)
            = Polynomial.X ^ (delta B).card +
                ∑ B' ∈ source, (Polynomial.X : Polynomial ℤ) ^ (delta B').card :=
                  sum_insert hB
        _ = Polynomial.X ^ (delta B).card +
                ∑ A ∈ source.image delta, (Polynomial.X : Polynomial ℤ) ^ A.card :=
                  congrArg (fun p : Polynomial ℤ => Polynomial.X ^ (delta B).card + p) ih
        _ = ∑ A ∈ insert (delta B) (source.image delta),
                (Polynomial.X : Polynomial ℤ) ^ A.card := (sum_insert hnot).symm
        _ = ∑ A ∈ (insert B source).image delta,
                (Polynomial.X : Polynomial ℤ) ^ A.card := by rw [image_insert]
  -- 本文の主計算の五等号: 低温表示、定義、元数保存、再添字付け、セクターの定義。
  calc
    partitionPolynomial L
        = 2 * lowTemperaturePolynomial L :=
          partitionPolynomial_eq_two_mul_lowTemperaturePolynomial L
    _ = 2 * ∑ B ∈ attainableBrokenEdgeSets L,
          (Polynomial.X : Polynomial ℤ) ^ B.card := rfl
    _ = 2 * ∑ B ∈ attainableBrokenEdgeSets L,
          (Polynomial.X : Polynomial ℤ) ^ (delta B).card := by
            congr 1
            apply sum_congr rfl
            intro B _
            dsimp [delta]
            rw [card_image_dualEdgeEquiv]
    _ = 2 * ∑ A ∈ trivialSectorEdgeSets L,
          (Polynomial.X : Polynomial ℤ) ^ A.card := by rw [hreindex, htarget]
    _ = 2 * sectorGeneratingPolynomial L (0, 0) := rfl

end Ising2DLambda.FisherZero
