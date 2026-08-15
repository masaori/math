/-
人手証明「開境界自由エネルギー密度の値集合の下限の存在（t が 1 以下の場合）」
（`claim_open_free_energy_density_infimum_exists_le_one`）の具体版と必要十分版からの導出。

値集合 `Ψ^op_t` を符号反転した `-Ψ^op_t` は空でなく `-ι(2)·log t` を上界に持つので、
既に宣言した完備性（上限の存在）を適用し、その上限の符号を戻して下限とする。
-/
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensitySupremum
import Ising2DLambda.ThermodynamicLimit.OpenFreeEnergyDensityLowerBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.OpenFreeEnergyDensityInfimum

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_open_free_energy_density_infimum_exists_le_one` の具体版。 -/
theorem openFreeEnergyDensityValueSet_has_infimum_of_le_one
    (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    ∃ v : ℝ, IsGLB (openFreeEnergyDensityValueSet t) v := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  let lower : ℝ := 2 * realLogarithm t
  -- 反転した集合 `-Ψ^op_t`
  let negated : Set ℝ := (fun y : ℝ => -y) '' openFreeEnergyDensityValueSet t
  have hnonempty : negated.Nonempty :=
    ⟨-(openSquareFreeEnergyDensity one t), ⟨openSquareFreeEnergyDensity one t, ⟨one, rfl⟩, rfl⟩⟩
  have hbounded : BddAbove negated := by
    refine ⟨-lower, ?_⟩
    rintro z ⟨y, ⟨L, rfl⟩, rfl⟩
    exact neg_le_neg (openSquareFreeEnergyDensity_lowerBound_of_le_one L t ht1)
  obtain ⟨u, hu⟩ := real_nonempty_bddAbove_has_supremum negated hnonempty hbounded
  refine ⟨-u, ?_, ?_⟩
  · -- `-u` は下界である
    rintro y ⟨L, rfl⟩
    have hmem : -(openSquareFreeEnergyDensity L t) ∈ negated :=
      ⟨openSquareFreeEnergyDensity L t, ⟨L, rfl⟩, rfl⟩
    have h := neg_le_neg (hu.1 hmem)
    rw [neg_neg] at h
    exact h
  · -- 任意の下界 `m` は `-u` 以下である
    intro m hm
    have hupper : -m ∈ upperBounds negated := by
      rintro z ⟨y, hy, rfl⟩
      exact neg_le_neg (hm hy)
    have h := neg_le_neg (hu.2 hupper)
    rw [neg_neg] at h
    exact h

/-- 必要十分版から開境界値集合の下限の存在を導く。 -/
theorem openFreeEnergyDensityValueSet_has_infimum_of_le_one_from_necSuf
    (t : StrictlyPositiveReal) (ht1 : t.1 ≤ 1) :
    ∃ v : ℝ, IsGLB (openFreeEnergyDensityValueSet t) v := by
  let one : PositiveNatural := ⟨1, by norm_num⟩
  have habstract :=
    NecSuf.ThermodynamicLimit.indexedValueSet_has_infimum_necSuf
      (fun L : PositiveNatural => openSquareFreeEnergyDensity L t) one (2 * realLogarithm t)
      (fun y : ℝ => -y) (fun h => neg_le_neg h) neg_neg
      (fun L => openSquareFreeEnergyDensity_lowerBound_of_le_one L t ht1)
      real_nonempty_bddAbove_has_supremum
  simpa [openFreeEnergyDensityValueSet] using habstract

end Ising2DLambda.ThermodynamicLimit
