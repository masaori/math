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
  非空性と有界性から上限の存在を得る                                         `periodicRealizedLowerSet_exists_isLUB_of_le_one`
  完備性で上限を取る: f^per(q) := sup ρ_ℝ(A^per(q))                          `periodicFreeEnergyDensity`
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

/-- 非空で上に有界な実数の集合は上限を持つ。 -/
theorem periodicRealizedLowerSet_exists_isLUB_of_le_one {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    ∃ f : ℝ, IsLUB (periodicRealizedLowerSet q) f := by
  exact ⟨sSup (periodicRealizedLowerSet q),
    isLUB_csSup (periodicRealizedLowerSet_nonempty_of_le_one hq0 hq1)
      (periodicRealizedLowerSet_bddAbove_of_le_one hq0 hq1)⟩

/-- 定義域内では上限の存在証明から周期境界の密度を選ぶ。 -/
noncomputable def periodicFreeEnergyDensity (q : ℚ) : ℝ :=
  if hq : 0 < q ∧ q ≤ 1 then
    Classical.choose (periodicRealizedLowerSet_exists_isLUB_of_le_one hq.1 hq.2)
  else sSup (periodicRealizedLowerSet q)

/-- 定義域内で選んだ密度は、下組の実現像の上限である。 -/
theorem periodicFreeEnergyDensity_isLUB_of_le_one {q : ℚ}
    (hq0 : 0 < q) (hq1 : q ≤ 1) :
    IsLUB (periodicRealizedLowerSet q) (periodicFreeEnergyDensity q) := by
  have hq : 0 < q ∧ q ≤ 1 := ⟨hq0, hq1⟩
  simpa [periodicFreeEnergyDensity, hq] using
    (Classical.choose_spec (periodicRealizedLowerSet_exists_isLUB_of_le_one hq0 hq1))

/-- 密度は全ての有理数 `q` で下組の実現像の上限と一致する。 -/
theorem periodicFreeEnergyDensity_eq_sSup (q : ℚ) :
    periodicFreeEnergyDensity q = sSup (periodicRealizedLowerSet q) := by
  by_cases hq : 0 < q ∧ q ≤ 1
  · exact (periodicFreeEnergyDensity_isLUB_of_le_one hq.1 hq.2).unique
      (isLUB_csSup
        (periodicRealizedLowerSet_nonempty_of_le_one hq.1 hq.2)
        (periodicRealizedLowerSet_bddAbove_of_le_one hq.1 hq.2))
  · simp [periodicFreeEnergyDensity, hq]

/-- `f^per(q) = f^op(q)`（同じ集合の上限は同じ実数）。 -/
theorem periodicFreeEnergyDensity_eq_openSquare_of_le_one {q : ℚ} (hq0 : 0 < q) (hq1 : q ≤ 1) :
    periodicFreeEnergyDensity q = openSquareFreeEnergyDensity q := by
  apply (periodicFreeEnergyDensity_isLUB_of_le_one hq0 hq1).unique
  rw [periodicRealizedLowerSet_eq_openSquare_of_le_one hq0 hq1]
  exact isLUB_csSup (openSquareRealizedLowerSet_nonempty hq0)
    (openSquareRealizedLowerSet_bddAbove hq0)

end Ising2DLambda.ThermodynamicLimit
