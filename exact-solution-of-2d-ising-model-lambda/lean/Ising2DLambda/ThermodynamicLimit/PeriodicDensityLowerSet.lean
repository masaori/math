/-
章「熱力学極限」の「周期境界の密度の列が定める下組」（`def_periodic_density_lower_set`）と
「周期境界の密度の下組は開境界正方形の密度の下組に含まれる（q は 1 以下）」
（`claim_periodic_density_lower_set_subset_open_square_le_one`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  列 L ↦ Ψ_L(q)                                                  `periodicDensitySequence`
    （L = 0 の値 0 は N ≥ 1 なので参照されない。開境界正方形の `openSquareDensitySequence` と同じ約束）
  L ≠ 0 では列の値は Ψ_L(q)                                        `periodicDensitySequence_of_ne_zero`
  A^per(q) := A((Ψ_L(q))_{L≥1})                                  `periodicDensityLowerSet`
  所属の言い換え                                                  `mem_periodicDensityLowerSet_iff`
  A^per(q) ⊂ A^op(q)（0 < q ≤ 1）:
    μ の証人 ε, N をそのまま使い、N ≤ L で
    μ + ε ≤ Ψ_L(q)（証人の性質）
        ≤ Ψ^op_L(q)（claim_periodic_open_boundary_comparison_density_le_one の右）、推移律
                                                                 `periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one`

住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetNonempty
import Ising2DLambda.ThermodynamicLimit.PeriodicOpenComparisonDensity

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 列 `L ↦ Ψ_L(q)`（`L = 0` では `0`。下組の定義は `L ≥ 1` しか見ない）。 -/
noncomputable def periodicDensitySequence (q : ℚ) : ℕ → RationalLogOrderGroup :=
  fun L => if h : L = 0 then 0 else
    haveI : NeZero L := ⟨h⟩
    scaledFreeEntropy L q

/-- `L ≠ 0` では列の値は `Ψ_L(q)` そのものである。 -/
theorem periodicDensitySequence_of_ne_zero (q : ℚ) (L : ℕ) [hL : NeZero L] :
    periodicDensitySequence q L = scaledFreeEntropy L q := by
  unfold periodicDensitySequence
  rw [dif_neg hL.out]

/-- `def_periodic_density_lower_set`。周期境界の密度の列が定める下組 `A^per(q)`。 -/
noncomputable def periodicDensityLowerSet (q : ℚ) : Set RationalLogOrderGroup :=
  rationalLogOrderSequenceLowerSet (periodicDensitySequence q)

/-- 所属の言い換え（定義の展開）。 -/
theorem mem_periodicDensityLowerSet_iff (q : ℚ) (μ : RationalLogOrderGroup) :
    μ ∈ periodicDensityLowerSet q ↔
      ∃ ε : RationalLogOrderGroup, rationalLogOrderLE 0 ε ∧ ε ≠ 0 ∧
        ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → rationalLogOrderLE (μ + ε) (periodicDensitySequence q L) :=
  Iff.rfl

/-- `claim_periodic_density_lower_set_subset_open_square_le_one`。
`0 < q ≤ 1` のとき `A^per(q) ⊆ A^op(q)`。 -/
theorem periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicDensityLowerSet q ⊆ openSquareDensityLowerSet q := by
  intro μ hμ
  -- μ の証人 ε, N を取る
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  -- 同じ ε, N を A^op(q) の所属の証人にする
  refine ⟨ε, hε0, hεne, N, hN1, ?_⟩
  intro L hL
  haveI : NeZero L := ⟨by omega⟩
  -- 一段目: μ + ε ≤ Ψ_L(q)（証人の性質）。列の値は Ψ_L(q)
  have h1 : rationalLogOrderLE (μ + ε) (scaledFreeEntropy L q) := by
    have h := hN L hL
    rwa [periodicDensitySequence_of_ne_zero] at h
  -- 二段目: Ψ_L(q) ≤ Ψ^op_L(q)（claim_periodic_open_boundary_comparison_density_le_one の右）
  have h2 : rationalLogOrderLE (scaledFreeEntropy L q) (openScaledFreeEntropy L q) :=
    (rationalLogOrderLE_periodicOpenDensity_bounds_of_le_one L hq0 hq1).2
  -- 推移律（claim_rational_log_order_group_linear_order）。列の値は Ψ^op_L(q)
  rw [openSquareDensitySequence_of_ne_zero]
  exact rationalLogOrderLE_trans h1 h2

end Ising2DLambda.ThermodynamicLimit
