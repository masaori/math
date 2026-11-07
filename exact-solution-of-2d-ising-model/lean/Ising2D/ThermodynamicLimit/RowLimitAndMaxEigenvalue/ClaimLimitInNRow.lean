/-
# `N_row → ∞` の極限: `(1/(M N_row)) log Z → (1/M) log c(M)`

人手証明（正本は `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`）:
- `freeenergy_003_claim_limit_in_N_row`（ラベル `limit_of_log_Z_in_N_row`）

**具体版**（人手証明と同じ抽象度）。必要十分版は `Ising2D/NecSuf/LogSqueeze.lean` の
`Ising2D.NecSuf.abs_div_sub_le_of_sandwich`・`Ising2D.NecSuf.tendsto_of_abs_sub_le_div`、
具体版をその系として導くのは `ClaimLimitInNRowFromNecSuf.lean`。

| 人手の段 | Lean |
| --- | --- |
| 証明冒頭: `c ∈ ℝ_{>0}`、`c^N`・`2^M ∈ ℝ_{>0}`（`real_log_of_power`）、`2^Mc^N ∈ ℝ_{>0}`（`real_log_of_product`）、`Z ∈ ℝ_{>0}` | 仮定 `hc`、`hcN.1`・`h2M.1`、`hprod.1`、`hZ`（人手の `def_partition_function_2d_ising` の `Z > 0` は、Lean では `0 < c^N ≤ Z` から出す） |
| 含意の鎖の 1 行目: `c^N ≤ Z ≤ 2^M c^N`（`partition_function_sandwich`） | 仮定 `h1`, `h2` |
| 2 行目: `log` を当てる（`u < v` は `real_log_strictly_increasing`、`u = v` は値が一つに定まること） | `s2`（`hmono` の 2 つの場合） |
| 3 行目: `real_log_of_power` を `a = c, n = N_row` で | `s3` |
| 4 行目: `real_log_of_product` を `a = 2^M, b = c^N` で | `s4` |
| 5 行目: `real_log_of_power` を `a = 2, n = M_col` で | `s5` |
| 6 行目: `real_log_of_power` を `a = c, n = N_row` で | `s6` |
| 7 行目: 各辺を `M_col N_row ∈ ℝ_{>0}` で割る | `s7` |
| 8 行目: ℝ の四則（共通の因子 `N_row`、`M_col` を約す） | `e1`〜`e3` と `s8` |
| 9 行目: 各辺から `(1/M) log c` を引く | `s9` |
| 10 行目: `def_real_absolute_value` の `q ≥ 0` の場合を 9 行目の `0 ≤ …` に | `abs_of_nonneg s9.1` |
| 準備: `log 2 > log 1 = log(exp 0) = 0` | `log_two_pos` の 3 段の `calc` |
| `ε > 0` を取り、`log 2/ε > 0`（正の数を正の数で割る） | `intro ε hε`、`ht` |
| アルキメデス性を `t = log 2/ε` に使い、`log 2/ε < N_0` の `N_0` を取る | `exists_nat_gt`（人手の `N_0 ∈ ℤ` を Lean は `ℕ` の `n` で取る） |
| `0 < log 2/ε < N_0 ⟹ 0 < N_0`（推移律） | `hN0pos` |
| `⟹ N_0 ≥ 1`（`0` と `1` の間に整数は無い） | `hN0` |
| `log 2 = (log 2/ε)ε < N_0ε`（`ε ≠ 0` を約す、両辺に `ε > 0` を掛ける） | `hN0eps` の 2 段の `calc` |
| `|a_N − a| ≤ log 2/N ≤ log 2/N_0 < ε`（`N ≥ N_0`） | 3 段の `calc` |
| `def_matrix_norm` の `K = ℝ` の列の収束の意味で `a_N → a`。極限は `scalar_limit_is_unique` で一つに定まる | `Metric.tendsto_atTop` と `Real.dist_eq`。結論の `Tendsto … (𝓝 a)` が値 `a` を名指すので、一意性の段は Lean では要らない |

人手の `log` は `def_real_logarithm_positive` で、Lean は mathlib の `Real.log` で表す（具体版は無い）。
準備の `scalar_exp_zero`・`def_real_logarithm_positive` の `log(exp x) = x` は mathlib の `Real.exp_zero`・`Real.log_exp`、
人手の `def_real_absolute_value` は mathlib の `|·|` で表し、`q ≥ 0` の場合を `abs_of_nonneg` で引く。ℝ のアルキメデス性は mathlib の `exists_nat_gt` で表す。実数列の収束（`def_matrix_norm` の 1 行 1 列の行列のノルムは絶対値）は
mathlib の距離 `dist x y = |x − y|` による `Metric.tendsto_atTop` で表す。
人手の主張のとおり、ここで実対数と極限による ℝ 脱出をする。

## 他章への依存（仮定として受け取っている部分）

本章の主張は次の入力を、具体的な `Z` と `c(M)` に依らない仮定として受け取る。
具体的な分配関数と `c(M)` への適用は `ThermodynamicLimit/ColumnLimitAndClosedForm/TheoremOnsagerUnconditional.lean` で行う:

* `def_partition_function_2d_ising`: 分配関数 `Z(K_1,K_2) > 0`
  → 仮定 `h1` から従う（`0 < c^N ≤ Z`）ので明示的な仮定にしていない
* `partition_function_sandwich`: `N_row ≥ 1` について `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`
  → 仮定 `h1`, `h2`（人手と同じく `1 ≤ N` の範囲でだけ受け取る）
* `def_rayleigh_sup`: `c(M) > 0`
  → 仮定 `hc`
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimRealLogStrictlyIncreasing
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimRealLogOfPower
import Mathlib.Topology.MetricSpace.Pseudo.Lemmas
import Mathlib.Topology.Instances.Real.Lemmas

namespace Ising2D

open Filter
open scoped Topology

/-- **人手証明 `limit_of_log_Z_in_N_row` の含意の鎖**:
`|(1/(MN)) log Z - (1/M) log c| ≤ (log 2)/N`。 -/
theorem abs_log_Z_sub_log_c_le
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, 1 ≤ N → c ^ N ≤ Z N) (h2 : ∀ N, 1 ≤ N → Z N ≤ 2 ^ M * c ^ N)
    {N : ℕ} (hN : 1 ≤ N) :
    |1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c|
      ≤ Real.log 2 / N := by
  have hM1 : 1 ≤ M := le_trans (by norm_num) hM
  have hcN := real_log_of_power hc N hN                           -- `c^N ∈ ℝ_{>0}`、`log(c^N) = N log c`
  have h2M := real_log_of_power (by norm_num : (0 : ℝ) < 2) M hM1 -- `2^M ∈ ℝ_{>0}`、`log(2^M) = M log 2`
  have hprod := real_log_of_product h2M.1 hcN.1                   -- `log(2^M c^N) = log(2^M) + log(c^N)`
  have hZ : 0 < Z N := lt_of_lt_of_le hcN.1 (h1 N hN)             -- `Z ∈ ℝ_{>0}`
  have hmono : ∀ u v : ℝ, 0 < u → u ≤ v → Real.log u ≤ Real.log v := fun u v hu huv => by
    rcases huv.lt_or_eq with h | h
    · exact le_of_lt (real_log_strictly_increasing hu (hu.trans h) h)
                                                                  -- `u < v`: `real_log_strictly_increasing`
    · rw [h]                                                      -- `u = v`: 写像 `log` の値が一つに定まる
  have hMR : (0 : ℝ) < M := by exact_mod_cast hM1
  have hNR : (0 : ℝ) < N := by exact_mod_cast hN
  have hMN : (0 : ℝ) < (M : ℝ) * N := mul_pos hMR hNR
  -- 1 行目: `c^N ≤ Z ≤ 2^M c^N`（`partition_function_sandwich`、仮定 h1, h2）
  -- 2 行目: `log(c^N) ≤ log Z ≤ log(2^M c^N)`
  have s2 : Real.log (c ^ N) ≤ Real.log (Z N) ∧ Real.log (Z N) ≤ Real.log (2 ^ M * c ^ N) :=
    ⟨hmono _ _ hcN.1 (h1 N hN), hmono _ _ hZ (h2 N hN)⟩
  -- 3 行目: `real_log_of_power` を `a = c, n = N_row` で
  have s3 : (N : ℝ) * Real.log c ≤ Real.log (Z N) ∧ Real.log (Z N) ≤ Real.log (2 ^ M * c ^ N) :=
    ⟨hcN.2.symm.trans_le s2.1, s2.2⟩
  -- 4 行目: `real_log_of_product` を `a = 2^M, b = c^N` で
  have s4 : (N : ℝ) * Real.log c ≤ Real.log (Z N)
      ∧ Real.log (Z N) ≤ Real.log (2 ^ M) + Real.log (c ^ N) :=
    ⟨s3.1, s3.2.trans_eq hprod.2⟩
  -- 5 行目: `real_log_of_power` を `a = 2, n = M_col` で
  have s5 : (N : ℝ) * Real.log c ≤ Real.log (Z N)
      ∧ Real.log (Z N) ≤ (M : ℝ) * Real.log 2 + Real.log (c ^ N) :=
    ⟨s4.1, s4.2.trans_eq (by rw [h2M.2])⟩
  -- 6 行目: `real_log_of_power` を `a = c, n = N_row` で
  have s6 : (N : ℝ) * Real.log c ≤ Real.log (Z N)
      ∧ Real.log (Z N) ≤ (M : ℝ) * Real.log 2 + (N : ℝ) * Real.log c :=
    ⟨s5.1, s5.2.trans_eq (by rw [hcN.2])⟩
  -- 7 行目: 各辺を `M_col N_row ∈ ℝ_{>0}` で割る。正の数で割っても不等号は保たれる
  have s7 : (N : ℝ) * Real.log c / ((M : ℝ) * N) ≤ Real.log (Z N) / ((M : ℝ) * N)
      ∧ Real.log (Z N) / ((M : ℝ) * N)
          ≤ ((M : ℝ) * Real.log 2 + (N : ℝ) * Real.log c) / ((M : ℝ) * N) :=
    ⟨div_le_div_of_nonneg_right s6.1 hMN.le, div_le_div_of_nonneg_right s6.2 hMN.le⟩
  -- 8 行目: ℝ の四則。分子と分母の共通の因子 `N_row`、`M_col` を約す
  have e1 : (N : ℝ) * Real.log c / ((M : ℝ) * N) = 1 / (M : ℝ) * Real.log c := by field_simp
  have e2 : Real.log (Z N) / ((M : ℝ) * N) = 1 / ((M : ℝ) * N) * Real.log (Z N) := by
    rw [one_div_mul_eq_div]
  have e3 : ((M : ℝ) * Real.log 2 + (N : ℝ) * Real.log c) / ((M : ℝ) * N)
      = 1 / (M : ℝ) * Real.log c + Real.log 2 / N := by
    field_simp; ring
  have s8 : 1 / (M : ℝ) * Real.log c ≤ 1 / ((M : ℝ) * N) * Real.log (Z N)
      ∧ 1 / ((M : ℝ) * N) * Real.log (Z N) ≤ 1 / (M : ℝ) * Real.log c + Real.log 2 / N :=
    ⟨e1.symm.trans_le (s7.1.trans_eq e2), e2.symm.trans_le (s7.2.trans_eq e3)⟩
  -- 9 行目: 各辺から `(1/M_col) log c` を引く。引いても不等号は保たれる
  have s9 : 0 ≤ 1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c
      ∧ 1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c ≤ Real.log 2 / N :=
    ⟨sub_nonneg.2 s8.1, sub_le_iff_le_add'.2 s8.2⟩
  -- 10 行目: `def_real_absolute_value` の `q ≥ 0` の場合を 9 行目の `0 ≤ …` に
  rw [abs_of_nonneg s9.1]
  exact s9.2

/-- **人手証明 `limit_of_log_Z_in_N_row` の準備**: `log 2 > 0`。 -/
theorem log_two_pos : Real.log 2 > 0 :=
  calc Real.log 2 > Real.log 1 := real_log_strictly_increasing one_pos two_pos one_lt_two
                                        -- `real_log_strictly_increasing` を `1 < 2` に
    _ = Real.log (Real.exp 0) := by rw [Real.exp_zero]
                                        -- `scalar_exp_zero`
    _ = 0 := Real.log_exp 0
                                        -- `def_real_logarithm_positive` の `log(exp x) = x`

/-- **人手証明 `limit_of_log_Z_in_N_row` そのもの**:
`(1/(M N_row)) log Z → (1/M) log c(M)`。 -/
theorem limit_of_log_Z_in_N_row
    {M : ℕ} (hM : 2 ≤ M) {c : ℝ} (hc : 0 < c) {Z : ℕ → ℝ}
    (h1 : ∀ N, 1 ≤ N → c ^ N ≤ Z N) (h2 : ∀ N, 1 ≤ N → Z N ≤ 2 ^ M * c ^ N) :
    Tendsto (fun N : ℕ => 1 / ((M : ℝ) * N) * Real.log (Z N)) atTop
      (𝓝 (1 / (M : ℝ) * Real.log c)) := by
  rw [Metric.tendsto_atTop]                                       -- `def_matrix_norm` の `K = ℝ` の列の収束
  intro ε hε                                                      -- `ε ∈ ℝ_{>0}` を取る
  have ht : 0 < Real.log 2 / ε := div_pos log_two_pos hε         -- `log 2/ε > 0`（準備の `log 2 > 0` と `ε > 0`。正の数を正の数で割る）
  obtain ⟨n, hn⟩ := exists_nat_gt (Real.log 2 / ε)                -- ℝ のアルキメデス性を `t = log 2/ε` に: `log 2/ε < N_0`
  have hN0pos : (0 : ℝ) < n := lt_trans ht hn                     -- `0 < log 2/ε < N_0 ⟹ 0 < N_0`（推移律）
  have hN0 : 1 ≤ n := Nat.one_le_iff_ne_zero.2 (by rintro rfl; simp at hN0pos)
                                                                  -- `N_0 ≥ 1`（`0` と `1` の間に整数は無い）
  have hN0eps : Real.log 2 < n * ε :=
    calc Real.log 2 = Real.log 2 / ε * ε := (div_mul_cancel₀ _ hε.ne').symm
                                                                  -- ℝ の四則。`ε ≠ 0` を約す
      _ < n * ε := mul_lt_mul_of_pos_right hn hε                 -- `log 2/ε < N_0` の両辺に `ε > 0` を掛ける
  refine ⟨n, fun N hN => ?_⟩                                      -- `N_row ∈ ℤ_{≥N_0}` について
  have hNR : (n : ℝ) ≤ N := by exact_mod_cast hN
  rw [Real.dist_eq]
  calc |1 / ((M : ℝ) * N) * Real.log (Z N) - 1 / (M : ℝ) * Real.log c|
      ≤ Real.log 2 / N := abs_log_Z_sub_log_c_le hM hc h1 h2 (le_trans hN0 hN)
                                                                  -- 上の含意の鎖の最後の行
    _ ≤ Real.log 2 / n := div_le_div_of_nonneg_left log_two_pos.le hN0pos hNR
                                                                  -- 準備の `log 2 > 0` かつ `0 < N_0 ≤ N_row`
    _ < ε := (div_lt_iff₀ hN0pos).2 (by rw [mul_comm]; exact hN0eps)
                                                                  -- `N_0ε > log 2` の両辺を `N_0 > 0` で割る

end Ising2D
