/-
章「熱力学極限」の「有理係数の対数順序群の Cauchy 列」（`def_rational_log_order_group_cauchy_sequence`）の
具体版（人手証明の定義と 1 対 1 に対応させる）。

  人手証明                                                       このファイル
  列 λ: {L ∈ ℕ | L ≥ 1} → Λ_ℚ                                     `l : ℕ → RationalLogOrderGroup`
    （具体版では L = 0 にも値を置くが、N ≥ 1 なので L = 0 の値は定義の中で参照されない）
  Cauchy 列: ∀ ε (0 ≤ ε, ε ≠ 0) ∃ N ≥ 1 ∀ L, M ≥ N,
             −ε ≤_{Λ_ℚ} λ_L − λ_M ≤_{Λ_ℚ} ε                        `IsCauchyRationalLogOrder`
  定数列は Cauchy 列（N = 1。λ_L − λ_M = 0 で −ε ≤ 0 ≤ ε）        `isCauchyRationalLogOrder_const`

使うのは Λ_ℚ の加法・逆元（`Finsupp` の群構造）と順序 `rationalLogOrderLE`
（`def_rational_log_order_group_order`）、および加法単調性 `rationalLogOrderLE_add_right`
（`claim_rational_log_order_group_add_monotone`）だけである。極限の存在は主張しない。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

/-- `def_rational_log_order_group_cauchy_sequence`。列 `l` が `Λ_ℚ` の Cauchy 列であるとは、
`0 ≤_{Λ_ℚ} ε` かつ `ε ≠ 0` なる任意の `ε` に対し、ある `N ≥ 1` があって `N ≤ L`, `N ≤ M` なるすべての
`L, M` で `−ε ≤_{Λ_ℚ} l L − l M ≤_{Λ_ℚ} ε` が成り立つこと。 -/
def IsCauchyRationalLogOrder (l : ℕ → RationalLogOrderGroup) : Prop :=
  ∀ ε : RationalLogOrderGroup, rationalLogOrderLE 0 ε → ε ≠ 0 →
    ∃ N : ℕ, 1 ≤ N ∧ ∀ L M : ℕ, N ≤ L → N ≤ M →
      rationalLogOrderLE (-ε) (l L - l M) ∧ rationalLogOrderLE (l L - l M) ε

/-- `0 ≤_{Λ_ℚ} ε` から `−ε ≤_{Λ_ℚ} 0`。加法単調性で両辺に `−ε` を足す。 -/
theorem rationalLogOrderLE_neg_of_nonneg {ε : RationalLogOrderGroup}
    (h : rationalLogOrderLE 0 ε) : rationalLogOrderLE (-ε) 0 := by
  have h' := rationalLogOrderLE_add_right h (-ε)   -- 0 + (−ε) ≤ ε + (−ε)
  rwa [zero_add, add_neg_cancel] at h'

/-- 定数列は Cauchy 列である（`N = 1`）。 -/
theorem isCauchyRationalLogOrder_const (c : RationalLogOrderGroup) :
    IsCauchyRationalLogOrder (fun _ => c) := by
  intro ε hε _
  refine ⟨1, le_rfl, ?_⟩
  intro L M _ _
  -- λ_L − λ_M = c − c = 0
  have hdiff : (fun _ : ℕ => c) L - (fun _ : ℕ => c) M = 0 := sub_self c
  rw [hdiff]
  exact ⟨rationalLogOrderLE_neg_of_nonneg hε, hε⟩

end Ising2DLambda.ThermodynamicLimit
