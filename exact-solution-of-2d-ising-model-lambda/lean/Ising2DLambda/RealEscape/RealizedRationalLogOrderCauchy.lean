/-
The realization of a Cauchy sequence in the rational log-order group is Cauchy in the reals.
This is the first bridge from the countable density sequence to its real limit.
-/
import Ising2DLambda.RealEscape.SequenceLowerSetSupRealLimit
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensitySequenceCauchy
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupScalarCompareNonneg
import Mathlib.Topology.MetricSpace.Cauchy

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit Filter Topology

private theorem realizeRational_add (μ ν : RationalLogOrderGroup) :
    realizeRational (μ + ν) = realizeRational μ + realizeRational ν := by
  unfold realizeRational
  apply Finsupp.sum_add_index'
  · intro p
    simp
  · intro p a b
    push_cast
    ring

private theorem realizeRational_neg (μ : RationalLogOrderGroup) :
    realizeRational (-μ) = -realizeRational μ := by
  calc
    realizeRational (-μ) = realizeRational ((-1 : ℚ) • μ) := by rw [neg_one_smul]
    _ = ((-1 : ℚ) : ℝ) * realizeRational μ := realizeRational_smul _ _
    _ = -realizeRational μ := by norm_num

private theorem realizeRational_sub (μ ν : RationalLogOrderGroup) :
    realizeRational (μ - ν) = realizeRational μ - realizeRational ν := by
  rw [sub_eq_add_neg, realizeRational_add, realizeRational_neg, sub_eq_add_neg]

/-- The countable Cauchy condition becomes ordinary real Cauchy after realization. -/
theorem cauchySeq_realizeRational_of_isCauchyRationalLogOrder
    (l : ℕ → RationalLogOrderGroup) (hl : IsCauchyRationalLogOrder l) :
    CauchySeq (fun L => realizeRational (l L)) := by
  apply Metric.cauchySeq_iff.mpr
  intro δ hδ
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
  obtain ⟨N, _, hN⟩ := hl (r • e) hη0 hηne
  refine ⟨N, ?_⟩
  intro m hm n hn
  obtain ⟨hlow, hupp⟩ := hN m n hm hn
  have hlowr := realizeRational_le_of_rationalLogOrderLE _ _ hlow
  have huppr := realizeRational_le_of_rationalLogOrderLE _ _ hupp
  have hδr : (r : ℝ) * c < δ := (lt_div_iff₀ hc).mp hrδ
  rw [Real.dist_eq]
  apply abs_lt.mpr
  constructor
  · rw [realizeRational_neg, realizeRational_sub, hηreal] at hlowr
    linarith
  · rw [realizeRational_sub, hηreal] at huppr
    linarith

/-- Real completeness supplies the limit of the realized open-square density sequence. -/
theorem exists_realLimit_realizeRational_of_isCauchyRationalLogOrder
    (l : ℕ → RationalLogOrderGroup) (hl : IsCauchyRationalLogOrder l) :
    ∃ I : ℝ, Tendsto (fun L => realizeRational (l L)) atTop (𝓝 I) := by
  exact cauchySeq_tendsto_of_complete
    (cauchySeq_realizeRational_of_isCauchyRationalLogOrder l hl)

theorem exists_realLimit_openSquareDensitySequence_of_le_one {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∃ I : ℝ, Tendsto (fun L => realizeRational (openSquareDensitySequence q L)) atTop (𝓝 I) := by
  exact exists_realLimit_realizeRational_of_isCauchyRationalLogOrder _
    (isCauchyRationalLogOrder_openSquareDensitySequence_of_le_one hq0 hq1)

end Ising2DLambda.RealEscape
