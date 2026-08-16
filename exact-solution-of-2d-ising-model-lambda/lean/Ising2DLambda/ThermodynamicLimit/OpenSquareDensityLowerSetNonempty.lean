/-
章「熱力学極限」の「開境界正方形の密度の列が定める下組」（`def_open_square_density_lower_set`）と
「開境界正方形の密度の下組は空でない」（`claim_open_square_density_lower_set_nonempty`）の具体版
（人手証明と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  A^op(q) := A((Ψ^op_L(q))_{L≥1})                                 `openSquareDensityLowerSet`
    （列は `openSquareDensitySequence q`。L = 0 の値 0 は N ≥ 1 なので参照されない）
  所属の言い換え                                                  `mem_openSquareDensityLowerSet_iff`
  準備の第一: 0 ≤_{Λ_ℚ} ι(ℓ_2)                                    `rationalLogOrderLE_zero_toRational_generator_two`（既出）
  準備の第二: ℓ_2(2) = 1 ≠ 0、単射性から ι(ℓ_2) ≠ 0               `toRational_generator_two_ne_zero`
  証人 ε := ι(ℓ_2)、N := 1。L ≥ 1 で
    −ι(ℓ_2) + ε = −ι(ℓ_2) + ι(ℓ_2)（ε の定義）= 0（逆元律）
    ≤_{Λ_ℚ} Ψ^op_L(q)（密度の非負）                                 `neg_toRational_generator_two_mem_openSquareDensityLowerSet`
  下組は空でない                                                  `openSquareDensityLowerSet_nonempty`

`q ≤ 1` は使わない。住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupSequenceLowerSet
import Ising2DLambda.ThermodynamicLimit.OpenSquareDensitySequenceCauchy
import Ising2DLambda.ThermodynamicLimit.OpenSquareMultipleSideSubsquareDensityErrorBound
import Ising2DLambda.ThermodynamicLimit.OpenSquareFreeEntropyDensityNonnegative

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_open_square_density_lower_set`。開境界正方形の密度の列が定める下組 `A^op(q)`。 -/
noncomputable def openSquareDensityLowerSet (q : ℚ) : Set RationalLogOrderGroup :=
  rationalLogOrderSequenceLowerSet (openSquareDensitySequence q)

/-- 所属の言い換え（定義の展開）。 -/
theorem mem_openSquareDensityLowerSet_iff (q : ℚ) (μ : RationalLogOrderGroup) :
    μ ∈ openSquareDensityLowerSet q ↔
      ∃ ε : RationalLogOrderGroup, rationalLogOrderLE 0 ε ∧ ε ≠ 0 ∧
        ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → rationalLogOrderLE (μ + ε) (openSquareDensitySequence q L) :=
  Iff.rfl

/-- 準備の第二: `ι(ℓ_2) ≠ 0`。`ℓ_2(2) = 1 ≠ 0` なので `ℓ_2 ≠ 0`、`ι(0) = 0` と単射性
（`claim_rational_log_order_group_embedding`）から。 -/
theorem toRational_generator_two_ne_zero :
    toRational (generator ⟨2, Nat.prime_two⟩) ≠ 0 := by
  intro h
  -- ℓ_2 ≠ 0（ℓ_2(2) = 1 ≠ 0。def_log_order_group）
  have hgen : generator ⟨2, Nat.prime_two⟩ ≠ (0 : LogOrderGroup) := by
    intro h0
    have h2 : generator ⟨2, Nat.prime_two⟩ ⟨2, Nat.prime_two⟩ = 1 := by
      simp [generator]
    rw [h0, Finsupp.zero_apply] at h2
    exact zero_ne_one h2
  -- ι(ℓ_2) = 0 = ι(0) なら単射性から ℓ_2 = 0
  apply hgen
  apply toRational_injective
  rw [h, toRational_zero]

/-- `claim_open_square_density_lower_set_nonempty`。`−ι(ℓ_2) ∈ A^op(q)`。 -/
theorem neg_toRational_generator_two_mem_openSquareDensityLowerSet {q : ℚ} (hq : 0 < q) :
    -(toRational (generator ⟨2, Nat.prime_two⟩)) ∈ openSquareDensityLowerSet q := by
  -- 証人 ε := ι(ℓ_2)、N := 1
  refine ⟨toRational (generator ⟨2, Nat.prime_two⟩),
    rationalLogOrderLE_zero_toRational_generator_two,   -- 準備の第一
    toRational_generator_two_ne_zero,                    -- 準備の第二
    1, le_refl 1, ?_⟩
  intro L hL
  haveI : NeZero L := ⟨by omega⟩
  -- 一段目・二段目: −ι(ℓ_2) + ι(ℓ_2) = 0（逆元律）
  rw [neg_add_cancel]
  -- 三段目: 0 ≤ Ψ^op_L(q)（claim_open_square_free_entropy_density_nonnegative）。列の値は Ψ^op_L(q)
  rw [openSquareDensitySequence_of_ne_zero]
  exact rationalLogOrderLE_zero_openScaledFreeEntropy L hq

/-- 下組は空でない。 -/
theorem openSquareDensityLowerSet_nonempty {q : ℚ} (hq : 0 < q) :
    (openSquareDensityLowerSet q).Nonempty :=
  ⟨_, neg_toRational_generator_two_mem_openSquareDensityLowerSet hq⟩

end Ising2DLambda.ThermodynamicLimit
