/-
# 2次元 Ising 模型の分配関数 `Z(K_1, K_2)`

対応する人手証明（正本は `structured-latex/content/001_partition_function_2d_ising.ts`）:

* `partition_function_2d_ising_001_definition_lattice_size`（ラベル `def_lattice_size`）
* `partition_function_2d_ising_002_definition_partition_function`
  （ラベル **`def_partition_function_2d_ising`**）

人手の定義:

  `𝔖 := Map({1,…,N_row}×{1,…,M_col}, {-1,1})`、
  `Z(K_1,K_2) := ∑_{s ∈ 𝔖} exp(∑_{i,j} (K_1 s(i,j) s(i,j+1) + K_2 s(i,j) s(i+1,j)))`

（周期境界条件 `s(N_row+1, j) := s(1, j)`, `s(i, M_col+1) := s(i, 1)`）。

## 記号

* 人手の格子サイズ `M_col`（列数）・`N_row`（行数）は Lean の束縛変数 `M`・`Nrow`
  （`def_lattice_size`）。行の添字は `Fin Nrow`、列の添字は `Fin M`（いずれも 0 始まり）。
* `s : Fin Nrow × Fin M → SpinVal` が人手の `𝔖` の元。第 1 成分が行 `i`、第 2 成分が列 `j`。
* 両方向の周期境界条件は巡回後者 `Ising2D.nextSite` で表す。
* `K_1` は同じ行の隣り合うサイト（列方向の隣接）、`K_2` は隣り合う行の同じ列のサイトを結ぶ。
* 人手の `K_1, K_2 ∈ ℝ_{>0}` は `K1 K2 : ℝ`。定義に正値性は要らないので仮定に置かない。
-/
import Ising2D.Part001.DefinitionRowConfigurations
import Ising2D.Part004.Definition010_H1H2V1V2

namespace Ising2D

/-- **人手 `def_partition_function_2d_ising` の `Z(K_1, K_2)`**（格子サイズは `Nrow` 行 `M` 列）。 -/
noncomputable def partitionFunction (Nrow M : ℕ) (K1 K2 : ℝ) : ℝ :=
  ∑ s : Fin Nrow × Fin M → SpinVal,
    Real.exp (∑ p : Fin Nrow × Fin M,
      (K1 * (s p : ℝ) * (s (p.1, nextSite p.2) : ℝ)
        + K2 * (s p : ℝ) * (s (nextSite p.1, p.2) : ℝ)))

end Ising2D
