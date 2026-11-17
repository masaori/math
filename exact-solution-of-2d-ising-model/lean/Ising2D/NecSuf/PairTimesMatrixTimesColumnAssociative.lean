/-
# 行列の組と 2×2 行列と数の列の積の結合律（**必要十分版**）

具体版: `Ising2D/EigenvalueProblem/ReductionToATheta/ClaimPairTimesMatrixTimesColumnAssociative.lean`
（人手 `pair_of_matrices_times_matrix_times_column_associative`）。具体版をこのファイルの系として導くのは、
同じ具体版のフォルダの `ClaimPairTimesMatrixTimesColumnAssociativeFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| 1〜3 行目（2 つの組の積の定義の展開） | 1〜3 段（同じ定義の展開） |
| 4〜7 行目（行列の和とスカラー倍を成分へ下ろす） | 無い（成分を持たない `α` の元のまま扱う） |
| 8 行目（`ℂ` の分配律） | 4 段 `smul_add`（スカラー倍の和への分配） |
| 9 行目（`ℂ` の積の結合律） | 5 段 `smul_smul`（スカラー倍を続けて掛けると係数の積の倍） |
| 10 行目（`ℂ` の加法の結合律・交換律） | 6 段 `add_add_add_comm`（`α` の加法） |
| 11 行目（`ℂ` の分配律） | 7 段 `add_smul`（係数の和の倍） |
| 12 行目（`ℂ` の積の交換律） | 8 段 `mul_comm`（係数の積の交換律。仮定 `CommSemiring`） |
| 14〜15 行目（2 項の有限和と `mat_mult`） | 9〜10 段 |
| 16〜18 行目（成分から組の積へ戻す） | 11 段（組と数の列の積の定義へ戻す） |

## 何が効いているか / 効いていないか

係数は可換半環 `R`、行列の代わりの `α` は `R` 上の加群（`AddCommMonoid α`・`Module R α`）である。鎖が使うのは
スカラー倍の和への分配（`smul_add`）、続けて掛けたスカラー倍（`smul_smul`）、`α` の加法の結合律・交換律、
係数の和の倍（`add_smul`）、係数の積の交換律だけである。

- **係数の積の交換律**（8 段）は外せない。`(A, B) P` の第 1 成分 `pA + rB` に `a` を掛けると係数は `ap`・`ar` で、
  `P v` の成分 `pa + qb` は `P` の成分を左に置く。可換でない係数では一致しない
  （例えば係数を四元数に取り、`α` を四元数そのもの（左からの積による加群）、`A = 1`・`B = 0`、`P` の成分を `p = i`・ほかは `0`、
  `v` の成分を `a = j`・`b = 0` とすると、左辺は `(ji)1 = -k`、右辺は `(ij)1 = k`）。
- 係数が体であること、`ℂ` であること、`α` が行列であること、成分を持つこと、加法の逆元は使わない。
-/
import Ising2D.NecSuf.RowVectorRightInverse

namespace Ising2D.NecSuf

open Matrix

variable {R α : Type*} [CommSemiring R] [AddCommMonoid α] [Module R α]

/-- 組 `(A, B)` と係数の列 `w` の積 `w 0 • A + w 1 • B`（具体版 `Ising2D.rowMulCol`）。
組と `2×2` 行列の積は既存の `rowMul2`（`RowVectorRightInverse.lean`。具体版 `Ising2D.rowMul`）を使う。 -/
def rowMul2Col (p : α × α) (w : Fin 2 → R) : α :=
  w 0 • p.1 + w 1 • p.2

/-- **`pair_of_matrices_times_matrix_times_column_associative` の必要十分版**: `((A, B) P) v = (A, B)(P v)`。
`calc` の各段と具体版 `Ising2D.rowMulCol_rowMul_assoc` の行の対応は冒頭の表のとおり。 -/
theorem rowMul2Col_rowMul2_assoc (A B : α) (P : Matrix (Fin 2) (Fin 2) R) (v : Fin 2 → R) :
    rowMul2Col (rowMul2 (A, B) P) v = rowMul2Col (A, B) (P *ᵥ v) :=
  calc rowMul2Col (rowMul2 (A, B) P) v
      = rowMul2Col (rowMul2Col (A, B) ![P 0 0, P 1 0], rowMul2Col (A, B) ![P 0 1, P 1 1]) v := rfl
                    -- 1 段（具体版 1 行目）
    _ = rowMul2Col (P 0 0 • A + P 1 0 • B, P 0 1 • A + P 1 1 • B) v := rfl
                    -- 2 段（具体版 2 行目）
    _ = v 0 • (P 0 0 • A + P 1 0 • B) + v 1 • (P 0 1 • A + P 1 1 • B) := rfl
                    -- 3 段（具体版 3 行目）
    _ = (v 0 • P 0 0 • A + v 0 • P 1 0 • B) + (v 1 • P 0 1 • A + v 1 • P 1 1 • B) := by
        rw [smul_add, smul_add]
                    -- 4 段（具体版 8 行目）: スカラー倍の和への分配
    _ = ((v 0 * P 0 0) • A + (v 0 * P 1 0) • B) + ((v 1 * P 0 1) • A + (v 1 * P 1 1) • B) := by
        rw [smul_smul, smul_smul, smul_smul, smul_smul]
                    -- 5 段（具体版 9 行目）: 続けて掛けたスカラー倍
    _ = ((v 0 * P 0 0) • A + (v 1 * P 0 1) • A) + ((v 0 * P 1 0) • B + (v 1 * P 1 1) • B) :=
        add_add_add_comm _ _ _ _
                    -- 6 段（具体版 10 行目）: `α` の加法の結合律・交換律
    _ = (v 0 * P 0 0 + v 1 * P 0 1) • A + (v 0 * P 1 0 + v 1 * P 1 1) • B := by
        rw [← add_smul, ← add_smul]
                    -- 7 段（具体版 11 行目）: 係数の和の倍
    _ = (P 0 0 * v 0 + P 0 1 * v 1) • A + (P 1 0 * v 0 + P 1 1 * v 1) • B := by
        rw [mul_comm (v 0) (P 0 0), mul_comm (v 1) (P 0 1), mul_comm (v 0) (P 1 0),
          mul_comm (v 1) (P 1 1)]
                    -- 8 段（具体版 12 行目）: 係数の積の交換律（外せない。冒頭の例）
    _ = (∑ j, P 0 j * v j) • A + (∑ j, P 1 j * v j) • B := by
        rw [Fin.sum_univ_two, Fin.sum_univ_two]
                    -- 9 段（具体版 14 行目）: 2 項の有限和
    _ = (P *ᵥ v) 0 • A + (P *ᵥ v) 1 • B := rfl
                    -- 10 段（具体版 15 行目）: `mulVec` の成分
    _ = rowMul2Col (A, B) (P *ᵥ v) := rfl
                    -- 11 段（具体版 16〜18 行目）: 組と係数の列の積の定義

end Ising2D.NecSuf
