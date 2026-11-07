/-
# `N_row → ∞` の極限（具体版を必要十分版から導く）

具体版 `ClaimLimitInNRow.lean` の 2 つの定理を、必要十分版 `Ising2D/NecSuf/LogSqueeze.lean` の特殊化として得る。
人手のラベルは `limit_of_log_Z_in_N_row`。

- 誤差評価 `abs_log_Z_sub_log_c_le`: `NecSuf.abs_div_sub_le_of_sandwich` の `L := Real.log`、`b := 2`。
  `L` の単調性の仮定は具体版 `real_log_strictly_increasing`、積の法則は具体版 `real_log_of_product` で埋める。
- 極限 `limit_of_log_Z_in_N_row`: `NecSuf.tendsto_of_abs_sub_le_div` の `C := log 2`（`C ≥ 0` は具体版の準備 `log_two_pos`）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimLimitInNRow
import Ising2D.NecSuf.LogSqueeze

namespace Ising2D

open Filter
open scoped Topology

/-- `abs_log_Z_sub_log_c_le` を `NecSuf.abs_div_sub_le_of_sandwich`（`L := Real.log`、`b := 2`）の特殊化として得る。 -/
theorem abs_log_Z_sub_log_c_le_of_necSuf
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, 1 ≤ N → c ^ N ≤ Z N) (h2 : ∀ N, 1 ≤ N → Z N ≤ 2 ^ M * c ^ N)
    {N : ℕ} (hN : 1 ≤ N) :
    |1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c|
      ≤ Real.log 2 / N :=
  NecSuf.abs_div_sub_le_of_sandwich
    (fun _ _ hu huv => le_of_lt (real_log_strictly_increasing hu (hu.trans huv) huv))
    (fun _ _ ha hb => (real_log_of_product ha hb).2)
    (le_trans (by norm_num) hM) hN (by norm_num) hc (h1 N hN) (h2 N hN)

/-- `limit_of_log_Z_in_N_row` を `NecSuf.tendsto_of_abs_sub_le_div`（`C := log 2`）の特殊化として得る。 -/
theorem limit_of_log_Z_in_N_row_of_necSuf
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, 1 ≤ N → c ^ N ≤ Z N) (h2 : ∀ N, 1 ≤ N → Z N ≤ 2 ^ M * c ^ N) :
    Tendsto (fun N : ℕ => 1 / ((M : ℝ) * N) * Real.log (Z N)) atTop
      (𝓝 (1 / (M : ℝ) * Real.log c)) :=
  NecSuf.tendsto_of_abs_sub_le_div log_two_pos.le
    (fun _ hN => abs_log_Z_sub_log_c_le_of_necSuf hM hc h1 h2 hN)

end Ising2D
