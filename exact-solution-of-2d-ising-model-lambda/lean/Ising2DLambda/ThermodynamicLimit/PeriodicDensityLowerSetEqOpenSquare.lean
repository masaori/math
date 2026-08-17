/-
章「熱力学極限」の「周期境界の密度の下組と開境界正方形の密度の下組は等しい（q は 1 以下）」
（`claim_periodic_density_lower_set_eq_open_square_le_one`）の具体版（人手証明と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  A^per(q) ⊂ A^op(q)（claim_periodic_density_lower_set_subset_open_square_le_one）
                                                                 `periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one`（既存）
  A^op(q) ⊂ A^per(q)（claim_open_square_density_lower_set_subset_periodic_le_one）
                                                                 `openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one`（既存）
  両包含から集合の等号（外延性: 任意の μ について、μ ∈ A^per(q) ⟺ μ ∈ A^op(q)）
                                                                 `periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one`

住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetSubsetPeriodic

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `claim_periodic_density_lower_set_eq_open_square_le_one`。
`0 < q ≤ 1` のとき `A^per(q) = A^op(q)`。両包含（外延性）。 -/
theorem periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one
    {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicDensityLowerSet q = openSquareDensityLowerSet q := by
  -- 外延性: 任意の μ について両向きの所属を示す
  ext μ
  constructor
  · -- μ ∈ A^per(q) ⟹ μ ∈ A^op(q)（claim_periodic_density_lower_set_subset_open_square_le_one）
    intro hμ
    exact periodicDensityLowerSet_subset_openSquareDensityLowerSet_of_le_one hq0 hq1 hμ
  · -- μ ∈ A^op(q) ⟹ μ ∈ A^per(q)（claim_open_square_density_lower_set_subset_periodic_le_one）
    intro hμ
    exact openSquareDensityLowerSet_subset_periodicDensityLowerSet_of_le_one hq0 hq1 hμ

end Ising2DLambda.ThermodynamicLimit
