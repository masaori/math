/-
# 列に並べた行列に対角行列を右から掛けると、各列が対角成分倍になる（**必要十分版**）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimColumnMatrixTimesDiagonalMatrix.lean`
（人手 `column_matrix_times_diagonal_matrix_scales_columns`）。具体版をこのファイルの系として導くのは、同じフォルダの
`ClaimColumnMatrixTimesDiagonalMatrixFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 前置き `column_entry_mul_offdiag_eq_zero` の 2 段（対角行列の非対角成分・`z 0 = 0`） | `col_entry_mul_offdiag_eq_zero` の 2 段（同じ並び） |
| `cols_mul_diagonal_matrix` の 6 段（積の成分・列の成分・一つの項のほかが 0 の和・積の可換律・スカラー倍の成分・列の成分） | `cols_mul_diagonal_eq_cols_smul` の 6 段（同じ並び） |

## 何が効いているか / 効いていないか

係数に置くのは、和のための `AddCommMonoid R` と積のための `Mul R`（`Matrix` の積の要件もこの 2 つだけ）であり、
鎖が使う次の 2 つの性質は仮定で渡す。

- **`x 0 = 0`**（前置きの 2 段目。仮定 `hmz`）。対角行列の非対角成分 `0` との積を `0` にする。
- **係数の乗法の可換性**（4 段目。仮定 `hcomm`）。`[b_1 ⋯ b_p] D` の `(i, k)` 成分は `(b_k)_i D_{kk}`（右から掛かる）で、
  主張の右辺の `D_{kk} b_k` は左から掛けたスカラー倍なので、入れ替えに可換性が要る。これを外すと通らない
  （例えば係数を四元数に取り、`n = p = 1`、`b_1 = (i)`、`D = (j)` とすると左辺は `ij = k`、右辺は `ji = -k`）。

積の結合則・単位元・分配則・`0 x = 0` は鎖に出ない。体であることも、加法の逆元も要らない。添字の集合に順序は要らない（`Fintype` だけ）。
-/
import Mathlib.Data.Matrix.Mul

namespace Ising2D.NecSuf

open Matrix

variable {n p R : Type*} [Fintype p] [AddCommMonoid R] [Mul R]

omit [Fintype p] in
/-- **前置き**（具体版 `column_entry_mul_offdiag_eq_zero`）: `j ≠ k` なら `(b_j)_i D_{jk} = 0`。 -/
theorem col_entry_mul_offdiag_eq_zero (b : p → n → R) (D : Matrix p p R)
    (hD : ∀ k l, k ≠ l → D k l = 0) (hmz : ∀ x : R, x * 0 = 0) (i : n) {j k : p} (hjk : j ≠ k) :
    b j i * D j k = 0 :=
  calc b j i * D j k
      = b j i * 0 := by rw [hD j k hjk]   -- 対角行列の非対角成分
    _ = 0 := hmz _                         -- `z 0 = 0`（仮定 `hmz`）

/-- **`column_matrix_times_diagonal_matrix_scales_columns` の必要十分版**:
`[b_1 ⋯ b_p] D = [D_{11} b_1 ⋯ D_{pp} b_p]`（列に並べた行列は `Matrix.of fun j k => b k j`）。
calc の 6 段は具体版 `Ising2D.cols_mul_diagonal_matrix` の 6 段と同じ順に並ぶ。 -/
theorem cols_mul_diagonal_eq_cols_smul (b : p → n → R) (D : Matrix p p R)
    (hD : ∀ k l, k ≠ l → D k l = 0) (hmz : ∀ x : R, x * 0 = 0) (hcomm : ∀ x y : R, x * y = y * x) :
    Matrix.of (fun j k => b k j) * D = Matrix.of (fun i k => (D k k • b k) i) := by
  ext i k
  calc (Matrix.of (fun j k => b k j) * D) i k
      = ∑ j, Matrix.of (fun j k => b k j) i j * D j k := rfl
                                                        -- 積の成分
    _ = ∑ j, b j i * D j k := rfl                       -- 列に並べた行列の成分の定め方を各項へ
    _ = b k i * D k k :=
        Finset.sum_eq_single k (fun j _ hjk => col_entry_mul_offdiag_eq_zero b D hD hmz i hjk)
          (fun h => absurd (Finset.mem_univ k) h)       -- 一つの項のほかが 0 の有限和と前置き
    _ = D k k * b k i := hcomm _ _                      -- 積の可換性（仮定 `hcomm`。外せない。冒頭の例）
    _ = (D k k • b k) i := rfl                          -- スカラー倍の成分を右辺から左辺へ
    _ = Matrix.of (fun i k => (D k k • b k) i) i k := rfl
                                                        -- 列に並べた行列の成分の定め方を右辺から左辺へ

end Ising2D.NecSuf
