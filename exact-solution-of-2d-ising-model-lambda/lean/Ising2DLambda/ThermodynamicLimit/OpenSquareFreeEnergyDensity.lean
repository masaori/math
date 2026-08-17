/-
章「熱力学極限」の「下組の実現像の上限としての開境界正方形の自由エネルギー密度
（実数体への脱出: 完備性）」（`def_open_square_free_energy_density`）の具体版。
定義ブロックなので必要十分版は無い。
（旧実数値経路の同名ファイルは 2026-08-17 に後片付けで消したので、この名前が唯一である。）

  人手証明（定義の well-defined 性）                                     このファイル
  ρ_ℝ(A^op(q)) := { ρ_ℝ(μ) | μ ∈ A^op(q) } ⊂ ℝ                              `openSquareRealizedLowerSet`
  空でない: −ι(ℓ_2) ∈ A^op(q)（claim_open_square_density_lower_set_nonempty）  `openSquareRealizedLowerSet_nonempty`
  上に有界の含意の鎖:
    μ ∈ A^op(q) ⟹ μ ≤_{Λ_ℚ} ι(ℓ_2)+2·ι(log(1+q))（…_le_upper_bound）
                ⟹ ρ_ℝ(μ) ≤ ρ_ℝ(ι(ℓ_2)+2·ι(log(1+q))) = b(q)（順序保存）     `realizeRational_le_realizeRational_upperBound_of_mem_openSquareDensityLowerSet`
    したがって b(q) は上界                                                  `openSquareRealizedLowerSet_bddAbove`
  完備性で上限を取る: f^op(q) := sup ρ_ℝ(A^op(q))                           `openSquareFreeEnergyDensity`（`sSup`）
  上限の特徴づけ: 上界である／最小である                                    `realizeRational_le_openSquareFreeEnergyDensity`（`le_csSup`）
                                                                              `openSquareFreeEnergyDensity_le_of_forall_le`（`csSup_le`）
実数体の完備性はここで初めて使う（`Real` の `ConditionallyCompleteLinearOrder`）。
実対数について使うのは順序保存 `realizeRational_le_of_rationalLogOrderLE` だけである。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealizationMonotone
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensityLowerSetLeUpperBound

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 下組 `A^op(q)` の実現像 `ρ_ℝ(A^op(q)) ⊂ ℝ`。 -/
noncomputable def openSquareRealizedLowerSet (q : ℚ) : Set ℝ :=
  realizeRational '' openSquareDensityLowerSet q

/-- 空でない: `ρ_ℝ(−ι(ℓ_2))` が属する（`claim_open_square_density_lower_set_nonempty`）。 -/
theorem openSquareRealizedLowerSet_nonempty {q : ℚ} (hq : 0 < q) :
    (openSquareRealizedLowerSet q).Nonempty :=
  ⟨realizeRational (-(toRational (generator ⟨2, Nat.prime_two⟩))),
    ⟨_, neg_toRational_generator_two_mem_openSquareDensityLowerSet hq, rfl⟩⟩

/-- 含意の鎖: `μ ∈ A^op(q)` ⟹ `μ ≤_{Λ_ℚ} ι(ℓ_2)+2·ι(log(1+q))` ⟹ `ρ_ℝ(μ) ≤ b(q)`。 -/
theorem realizeRational_le_realizeRational_upperBound_of_mem_openSquareDensityLowerSet {q : ℚ}
    (hq : 0 < q) {μ : RationalLogOrderGroup} (hμ : μ ∈ openSquareDensityLowerSet q) :
    realizeRational μ ≤
      realizeRational (toRational (generator ⟨2, Nat.prime_two⟩) +
        (2 : ℚ) • toRational (logRat (1 + q))) := by
  -- 一段目: claim_open_square_density_lower_set_le_upper_bound
  have h1 := rationalLogOrderLE_upperBound_of_mem_openSquareDensityLowerSet hq hμ
  -- 二段目: claim_rational_log_order_group_realization_monotone
  exact realizeRational_le_of_rationalLogOrderLE _ _ h1

/-- 上に有界: `b(q)` が上界。 -/
theorem openSquareRealizedLowerSet_bddAbove {q : ℚ} (hq : 0 < q) :
    BddAbove (openSquareRealizedLowerSet q) := by
  refine ⟨realizeRational (toRational (generator ⟨2, Nat.prime_two⟩) +
    (2 : ℚ) • toRational (logRat (1 + q))), ?_⟩
  rintro t ⟨μ, hμ, rfl⟩
  exact realizeRational_le_realizeRational_upperBound_of_mem_openSquareDensityLowerSet hq hμ

/-- `def_open_square_free_energy_density`: `f^op(q) := sup ρ_ℝ(A^op(q))`。
実数体の完備性はここで使う。 -/
noncomputable def openSquareFreeEnergyDensity (q : ℚ) : ℝ :=
  sSup (openSquareRealizedLowerSet q)

/-- 上限は上界である: `μ ∈ A^op(q)` なら `ρ_ℝ(μ) ≤ f^op(q)`。 -/
theorem realizeRational_le_openSquareFreeEnergyDensity {q : ℚ} (hq : 0 < q)
    {μ : RationalLogOrderGroup} (hμ : μ ∈ openSquareDensityLowerSet q) :
    realizeRational μ ≤ openSquareFreeEnergyDensity q :=
  le_csSup (openSquareRealizedLowerSet_bddAbove hq) ⟨μ, hμ, rfl⟩

/-- 上限は最小の上界である: すべての `μ ∈ A^op(q)` で `ρ_ℝ(μ) ≤ b` なら `f^op(q) ≤ b`。 -/
theorem openSquareFreeEnergyDensity_le_of_forall_le {q : ℚ} (hq : 0 < q) {b : ℝ}
    (hb : ∀ μ ∈ openSquareDensityLowerSet q, realizeRational μ ≤ b) :
    openSquareFreeEnergyDensity q ≤ b := by
  apply csSup_le (openSquareRealizedLowerSet_nonempty hq)
  rintro t ⟨μ, hμ, rfl⟩
  exact hb μ hμ

end Ising2DLambda.ThermodynamicLimit
