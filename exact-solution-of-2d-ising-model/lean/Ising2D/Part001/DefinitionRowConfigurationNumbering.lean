/-
# 1 行ぶんのスピン配置の番号付け `ord`

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_definition_row_configuration_numbering`
  （ラベル **`def_row_configuration_numbering`**）

人手の定義は `ord(μ) := 1 + ∑_{m=1}^{M_col} ((1-μ(m))/2)·2^{M_col-m}`（`ord : 𝔐 → ℤ`）。

* 人手は `(1-μ(m))/2` が `μ(m) = 1` のとき `0`、`μ(m) = -1` のとき `1` であることから
  右辺を整数の有限和とみている。Lean では各桁を整数 `spinBit (μ m) ∈ {0, 1}` として定義し、
  それが実数として `(1-μ(m))/2` に等しいことを `spinBit_eq` で示す。
* Lean の列の添字 `m : Fin M` は人手の `m - 1` なので、人手の指数 `M_col - m` は
  Lean では `M - 1 - m` である。
-/
import Ising2D.Part001.DefinitionRowConfigurations
import Mathlib.Tactic.Linarith
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.NormNum

namespace Ising2D

/-- `s ∈ {-1, 1}` の桁 `(1 - s)/2 ∈ {0, 1}` を整数として持ったもの。 -/
noncomputable def spinBit (s : SpinVal) : ℤ := if (s : ℝ) = 1 then 0 else 1

/-- 人手の定義の桁 `(1 - μ(m))/2` と一致する。 -/
theorem spinBit_eq (s : SpinVal) : (spinBit s : ℝ) = (1 - (s : ℝ)) / 2 := by
  rcases s.2 with h | h
  · rw [spinBit, if_pos h, h]; norm_num
  · rw [spinBit, if_neg (by rw [h]; norm_num), h]; norm_num

theorem spinBit_eq_zero_iff (s : SpinVal) : spinBit s = 0 ↔ (s : ℝ) = 1 := by
  by_cases h : (s : ℝ) = 1
  · simp [spinBit, h]
  · simp [spinBit, h]

theorem spinBit_nonneg (s : SpinVal) : 0 ≤ spinBit s := by
  unfold spinBit; split <;> norm_num

theorem spinBit_le_one (s : SpinVal) : spinBit s ≤ 1 := by
  unfold spinBit; split <;> norm_num

/-- **人手 `def_row_configuration_numbering` の `ord`。** -/
noncomputable def rowConfigOrd {M : ℕ} (μ : SpinConf M) : ℤ :=
  1 + ∑ m : Fin M, spinBit (μ m) * 2 ^ (M - 1 - (m : ℕ))

end Ising2D
