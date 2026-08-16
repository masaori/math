/-
章「熱力学極限」の「有理係数の対数順序群の列が定める下組」（`def_rational_log_order_group_sequence_lower_set`）と
「列が定める下組は下に閉じている」（`claim_rational_log_order_group_sequence_lower_set_downward_closed`）の具体版
（人手証明と 1 対 1 に対応させる）。

  人手証明                                                          このファイル
  下組 A((λ_L)) := { μ | ∃ ε (0 ≤ ε, ε ≠ 0) ∃ N ≥ 1 ∀ L ≥ N,
                    μ + ε ≤_{Λ_ℚ} λ_L }                              `rationalLogOrderSequenceLowerSet`
    （列は `ℕ → Λ_ℚ`。人手証明は L ≥ 1 の上の列だが、N ≥ 1 なので L = 0 の値は参照されない）
  所属の言い換え                                                     `mem_rationalLogOrderSequenceLowerSet_iff`
  下に閉じている: μ ∈ A, μ' ≤ μ ⟹ μ' ∈ A
    μ の証人 ε, N をそのまま使い、
    μ' + ε ≤ μ + ε（加法単調性）≤ λ_L（証人の性質）、推移律          `mem_rationalLogOrderSequenceLowerSet_of_le`

使うのは Λ_ℚ の加法と順序 `rationalLogOrderLE`、加法単調性 `rationalLogOrderLE_add_right`
（`claim_rational_log_order_group_add_monotone`）、推移律 `rationalLogOrderLE_trans`
（`claim_rational_log_order_group_linear_order`）だけである。極限の存在は主張しない。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_rational_log_order_group_sequence_lower_set`。列 `l` が定める下組。 -/
def rationalLogOrderSequenceLowerSet (l : ℕ → RationalLogOrderGroup) :
    Set RationalLogOrderGroup :=
  { μ | ∃ ε : RationalLogOrderGroup, rationalLogOrderLE 0 ε ∧ ε ≠ 0 ∧
      ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → rationalLogOrderLE (μ + ε) (l L) }

/-- 所属の言い換え（定義の展開）。 -/
theorem mem_rationalLogOrderSequenceLowerSet_iff (l : ℕ → RationalLogOrderGroup)
    (μ : RationalLogOrderGroup) :
    μ ∈ rationalLogOrderSequenceLowerSet l ↔
      ∃ ε : RationalLogOrderGroup, rationalLogOrderLE 0 ε ∧ ε ≠ 0 ∧
        ∃ N : ℕ, 1 ≤ N ∧ ∀ L : ℕ, N ≤ L → rationalLogOrderLE (μ + ε) (l L) :=
  Iff.rfl

/-- `claim_rational_log_order_group_sequence_lower_set_downward_closed`。
`μ ∈ A` かつ `μ' ≤_{Λ_ℚ} μ` なら `μ' ∈ A`。 -/
theorem mem_rationalLogOrderSequenceLowerSet_of_le (l : ℕ → RationalLogOrderGroup)
    {μ μ' : RationalLogOrderGroup} (hμ : μ ∈ rationalLogOrderSequenceLowerSet l)
    (hle : rationalLogOrderLE μ' μ) : μ' ∈ rationalLogOrderSequenceLowerSet l := by
  -- μ の証人 ε, N を取る
  obtain ⟨ε, hε0, hεne, N, hN1, hN⟩ := hμ
  -- 同じ ε, N を μ' の証人にする
  refine ⟨ε, hε0, hεne, N, hN1, ?_⟩
  intro L hL
  -- μ' + ε ≤ μ + ε（claim_rational_log_order_group_add_monotone）
  have h1 : rationalLogOrderLE (μ' + ε) (μ + ε) := rationalLogOrderLE_add_right hle ε
  -- μ + ε ≤ λ_L（証人の性質）
  have h2 : rationalLogOrderLE (μ + ε) (l L) := hN L hL
  -- 推移律（claim_rational_log_order_group_linear_order）
  exact rationalLogOrderLE_trans h1 h2

end Ising2DLambda.ThermodynamicLimit
