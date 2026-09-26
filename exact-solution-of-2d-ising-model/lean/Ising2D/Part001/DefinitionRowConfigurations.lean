/-
# 1 行ぶんのスピン配置の全体 `𝔐`

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_definition_row_configurations`（ラベル **`def_row_configurations`**）

人手の `𝔐 = Map({1,…,M_col}, {-1,1})`。

* 人手の列数 `M_col` は Lean の束縛変数 `M` である。列の添字 `{1,…,M_col}` は `Fin M`
  （0 始まり。人手の `m` が Lean の `(m : ℕ) + 1`）。
* 人手の `{-1, 1}` は `ℝ` の部分集合なので、Lean でも `ℝ` の部分型 `SpinVal` として持つ。
  指数の肩に現れる `K_1 μ(m) μ(m+1)` が `ℝ` の元であることを型で保証するためである。
-/
import Mathlib.Data.Real.Basic
import Mathlib.Data.Fintype.Pi
import Mathlib.Data.Fintype.Card
import Mathlib.Tactic.NormNum

namespace Ising2D

/-- 人手の `{-1, 1} ⊂ ℝ`。 -/
abbrev SpinVal : Type := {r : ℝ // r = 1 ∨ r = -1}

/-- `{-1, 1}` は有限集合（元は `1` と `-1` の 2 つ）。 -/
noncomputable instance : Fintype SpinVal :=
  Fintype.subtype {1, -1} (fun r => by simp)

/-- `{-1, 1}` の元の個数は `2`（`1 ≠ -1`）。 -/
theorem card_spinVal : Fintype.card SpinVal = 2 := by
  rw [Fintype.card_of_subtype ({1, -1} : Finset ℝ) (fun r => by simp)]
  exact Finset.card_pair (by norm_num : (1 : ℝ) ≠ -1)

/-- **人手の `𝔐 = Map({1,…,M_col}, {-1,1})`（`def_row_configurations`）。** -/
abbrev SpinConf (M : ℕ) : Type := Fin M → SpinVal

end Ising2D
