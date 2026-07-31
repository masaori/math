/-
# `N_row → ∞` の極限: `(1/(M N_row)) log Z → (1/M) log c(M)`

人手証明（正本は `structured-latex/content/012_free_energy.ts`）:
- `freeenergy_003_claim_limit_in_N_row`（ラベル `limit_of_log_Z_in_N_row`）

**具体版**（人手証明と同じ抽象度）。必要十分版は `Ising2D/NecSuf/LogSqueeze.lean` の
`Ising2D.NecSuf.abs_log_div_sub_log_le_of_sandwich`。
具体版は必要十分版の系として導出してある。

## 他章への依存（仮定として受け取っている部分）

本章の主張は 011 章の次の 2 つを入力として使う。**別セッションが並行して 011 章を
形式化しているため、import による結合はせず、仮定として受け取る**:

* `def_partition_function_2d_ising`: 分配関数 `Z(J,J') > 0`
  → 仮定 `h1` から従う（`c^N > 0 ≤ Z`）ので明示的な仮定にしていない
* `partition_function_sandwich`: `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`
  → 仮定 `h1`, `h2`
* `def_rayleigh_sup`: `c(M) > 0`
  → 仮定 `hc`

したがって本ファイルの定理は「011 章の挟み撃ちを認めれば `N_row → ∞` の極限が
`(1/M) log c(M)` であること」を主張する。

**この段階では実数解析へ移行していない**（人手証明の最終段落）。
使っているのは有限個の実数の不等式、`log` の単調性と `log(ab) = log a + log b`、
および実数列 `(log 2)/N → 0` だけである。積分も一様連続性も使わない。
-/
import Ising2D.NecSuf.LogSqueeze
import Mathlib.Analysis.SpecificLimits.Basic

namespace Ising2D

open Filter
open scoped Topology

/-- **人手証明 `limit_of_log_Z_in_N_row` の誤差評価**:
`|(1/(MN)) log Z - (1/M) log c| ≤ (log 2)/N`。 -/
theorem abs_log_Z_sub_log_c_le
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, c ^ N ≤ Z N) (h2 : ∀ N, Z N ≤ 2 ^ M * c ^ N)
    {N : ℕ} (hN : 0 < N) :
    |1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c|
      ≤ Real.log 2 / N := by
  have hMpos : (0 : ℝ) < M := by
    have : 0 < M := lt_of_lt_of_le (by norm_num) hM
    exact_mod_cast this
  have hNR : (0 : ℝ) < N := by exact_mod_cast hN
  have hB : (1 : ℝ) ≤ 2 ^ M := one_le_pow₀ (by norm_num)
  have hkey := NecSuf.abs_log_div_sub_log_le_of_sandwich (c := c) (B := (2 : ℝ) ^ M)
    (Z := Z N) hN hc hB (h1 N) (h2 N)
  have hlogB : Real.log ((2 : ℝ) ^ M) = (M : ℝ) * Real.log 2 := by
    rw [Real.log_pow]
  rw [hlogB] at hkey
  have hrw : 1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c
      = (1 / (M : ℝ)) * (Real.log (Z N) / N - Real.log c) := by
    field_simp
  rw [hrw, abs_mul, abs_of_pos (show (0:ℝ) < 1 / (M:ℝ) by positivity)]
  have hMne : (M : ℝ) ≠ 0 := ne_of_gt hMpos
  calc (1 / (M : ℝ)) * |Real.log (Z N) / N - Real.log c|
      ≤ (1 / (M : ℝ)) * ((M : ℝ) * Real.log 2 / N) :=
        mul_le_mul_of_nonneg_left hkey (by positivity)
    _ = Real.log 2 / N := by field_simp

/-- **人手証明 `limit_of_log_Z_in_N_row` そのもの**:
`(1/(M N_row)) log Z → (1/M) log c(M)`。 -/
theorem limit_of_log_Z_in_N_row
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, c ^ N ≤ Z N) (h2 : ∀ N, Z N ≤ 2 ^ M * c ^ N) :
    Tendsto (fun N : ℕ => 1 / ((M : ℝ) * N) * Real.log (Z N)) atTop
      (𝓝 (1 / (M : ℝ) * Real.log c)) := by
  rw [tendsto_iff_dist_tendsto_zero]
  have hbound : Tendsto (fun N : ℕ => Real.log 2 / N) atTop (𝓝 0) :=
    Filter.Tendsto.div_atTop (tendsto_const_nhds (x := Real.log 2))
      (tendsto_natCast_atTop_atTop (R := ℝ))
  refine squeeze_zero' (Filter.Eventually.of_forall fun _ => dist_nonneg) ?_ hbound
  filter_upwards [Filter.eventually_gt_atTop 0] with N hN
  rw [Real.dist_eq]
  exact abs_log_Z_sub_log_c_le hM hc h1 h2 hN

end Ising2D
