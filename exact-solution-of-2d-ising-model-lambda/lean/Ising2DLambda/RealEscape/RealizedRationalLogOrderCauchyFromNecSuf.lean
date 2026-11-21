import Ising2DLambda.NecSuf.RealEscape.RealizedRationalLogOrderCauchy
import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimit
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensitySequenceCauchy
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Filter Topology

/-- The abstract order-to-real Cauchy theorem applies to the log-order realization. -/
theorem cauchySeq_realizeRational_of_isCauchyRationalLogOrder_from_necSuf
    (l : ℕ → RationalLogOrderGroup) (hl : IsCauchyRationalLogOrder l) :
    CauchySeq (fun L => realizeRational (l L)) := by
  apply Ising2DLambda.NecSuf.RealEscape.cauchySeq_realization_of_orderCauchy
    rationalLogOrderLE realizeRational l
  · intro a b
    unfold realizeRational
    apply Finsupp.sum_add_index'
    · intro p
      simp
    · intro p x y
      push_cast
      ring
  · exact realizeRational_zero
  · intro a b hab
    exact realizeRational_le_of_rationalLogOrderLE _ _ hab
  · intro δ hδ
    let e : RationalLogOrderGroup := toRational (FreeEntropy.generator ⟨2, Nat.prime_two⟩)
    let c : ℝ := realizeRational e
    have hc : 0 < c := realizeRational_generatorTwo_pos
    obtain ⟨r, hr0, hrδ⟩ : ∃ r : ℚ, (0 : ℝ) < r ∧ (r : ℝ) < δ / c :=
      exists_rat_btwn (div_pos hδ hc)
    have hr0q : (0 : ℚ) ≤ r := le_of_lt (Rat.cast_pos.mp hr0)
    have he0 : rationalLogOrderLE 0 e := rationalLogOrderLE_zero_toRational_generator_two
    have hη0 : rationalLogOrderLE 0 (r • e) := by
      have h := rationalLogOrderLE_ratSmul_le_ratSmul_of_le hr0q he0
      simpa only [zero_smul] using h
    have hηreal : realizeRational (r • e) = (r : ℝ) * c := realizeRational_smul r e
    have hηpos : 0 < realizeRational (r • e) := by
      rw [hηreal]
      exact mul_pos hr0 hc
    have hηne : r • e ≠ 0 := by
      intro h
      rw [h, realizeRational_zero] at hηpos
      exact (not_lt.mpr le_rfl) hηpos
    refine ⟨r • e, hη0, hηne, ?_⟩
    rw [hηreal]
    exact (lt_div_iff₀ hc).mp hrδ
  · intro ε hε0 hεne
    obtain ⟨N, _, hN⟩ := hl ε hε0 hεne
    refine ⟨N, ?_⟩
    intro m hm n hn
    exact hN m n hm hn

theorem exists_realLimit_openSquareDensitySequence_of_le_one_from_necSuf {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∃ I : ℝ, Tendsto (fun L => realizeRational (openSquareDensitySequence q L)) atTop (𝓝 I) := by
  exact cauchySeq_tendsto_of_complete
    (cauchySeq_realizeRational_of_isCauchyRationalLogOrder_from_necSuf _
      (isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one hq0 hq1))

end Ising2DLambda.RealEscape
