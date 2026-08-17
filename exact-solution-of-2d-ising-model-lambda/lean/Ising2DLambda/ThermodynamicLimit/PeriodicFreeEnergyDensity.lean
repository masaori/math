/-
章「熱力学極限」の「下組の実現像の上限としての周期境界の自由エネルギー密度（実数体への脱出:
完備性。q は 1 以下）」（`def_periodic_free_energy_density_le_one`）の具体版。
定義ブロックなので必要十分版は無い。

  人手証明（定義の well-defined 性と f^op(q) との一致）                       このファイル
  ρ_ℝ(A^per(q)) := { ρ_ℝ(μ) | μ ∈ A^per(q) } ⊂ ℝ                             `periodicRealizedLowerSet`
  ρ_ℝ(A^per(q)) = ρ_ℝ(A^op(q))
    （claim_periodic_density_lower_set_eq_open_square_le_one で A^per(q)=A^op(q)。
      同じ集合の像は同じ）                                                   `periodicRealizedLowerSet_eq_openSquare_of_le_one`
  空でない・上に有界（開境界正方形の像と同じ集合なので def_open_square_free_energy_density の
    二つの性質をそのまま引く）                                                `periodicRealizedLowerSet_nonempty_of_le_one`
                                                                              `periodicRealizedLowerSet_bddAbove_of_le_one`
  完備性で上限を取る: f^per(q) := sup ρ_ℝ(A^per(q))                          `periodicFreeEnergyDensity`（`sSup`）
  f^per(q) = f^op(q)（同じ集合の上限は同じ）                                 `periodicFreeEnergyDensity_eq_openSquare_of_le_one`
実数体の完備性はここで使う（`Real` の `ConditionallyCompleteLinearOrder`）。新しい脱出理由は増えない。
-/
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEnergyDensity
import Ising2DLambda.ThermodynamicLimit.PeriodicDensityLowerSetEqOpenSquare

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 下組 `A^per(q)` の実現像 `ρ_ℝ(A^per(q)) ⊂ ℝ`。 -/
noncomputable def periodicRealizedLowerSet (q : ℚ) : Set ℝ :=
  realizeRational '' periodicDensityLowerSet q

/-- `A^per(q) = A^op(q)`（`claim_periodic_density_lower_set_eq_open_square_le_one`）なので
実現像も等しい。 -/
theorem periodicRealizedLowerSet_eq_openSquare_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicRealizedLowerSet q = openSquareRealizedLowerSet q := by
  unfold periodicRealizedLowerSet openSquareRealizedLowerSet
  rw [periodicDensityLowerSet_eq_openSquareDensityLowerSet_of_le_one hq0 hq1]

/-- 空でない（開境界正方形の像と同じ集合）。 -/
theorem periodicRealizedLowerSet_nonempty_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    (periodicRealizedLowerSet q).Nonempty := by
  rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]
  exact openSquareRealizedLowerSet_nonempty hq0

/-- 上に有界（開境界正方形の像と同じ集合）。 -/
theorem periodicRealizedLowerSet_bddAbove_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    BddAbove (periodicRealizedLowerSet q) := by
  rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]
  exact openSquareRealizedLowerSet_bddAbove hq0

/-- `def_periodic_free_energy_density_le_one`: `f^per(q) := sup ρ_ℝ(A^per(q))`。
実数体の完備性はここで使う。 -/
noncomputable def periodicFreeEnergyDensity (q : ℚ) : ℝ :=
  sSup (periodicRealizedLowerSet q)

/-- `f^per(q) = f^op(q)`（同じ集合の上限は同じ実数）。 -/
theorem periodicFreeEnergyDensity_eq_openSquare_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicFreeEnergyDensity q = openSquareFreeEnergyDensity q := by
  unfold periodicFreeEnergyDensity openSquareFreeEnergyDensity
  rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]

end Ising2DLambda.ThermodynamicLimit
