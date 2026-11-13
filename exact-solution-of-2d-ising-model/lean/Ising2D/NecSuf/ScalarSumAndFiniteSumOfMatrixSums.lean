/-
# 係数の和によるスカラー倍と、行列の和の有限和（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarSumAndFiniteSumOfMatrixSums.lean`
（人手 `scalar_sum_distributes_over_matrix`・`finite_sum_of_matrix_sums`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarSumAndFiniteSumOfMatrixSumsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_add_smul_apply`（スカラー倍の定義 → 右分配則 → スカラー倍の定義を 2 か所 → 和の定義） | `add_smul_matrix_apply'`（同じ並び） |
| `matrix_add_smul`（全ての成分が一致する） | `add_smul_matrix'` |
| `finite_sum_of_matrix_sums_apply`（成分の有限和 → 和の定義を各項 → 係数の和の有限和の分割 → 成分の有限和を 2 か所 → 和の定義） | `finite_sum_add_matrix_apply'`（同じ並び） |
| `finite_sum_of_matrix_sums`（全ての成分が一致する） | `finite_sum_add_matrix'` |

## 何が効いているか / 効いていないか

- スカラーは係数と同じ集合の元が左から掛かるものとした（具体版のスカラー倍が `ℂ` の積であることに合わせた。`Mul` から入る `SMul`）。
- 係数の和によるスカラー倍で効いているのは、係数の**右分配則**（`RightDistribClass`）だけである。外すと `(a + b)x = ax + bx` の段が通らない。
  **加法の結合則・交換則・零・逆元、乗法の結合則・単位元・可換則は効いていない**（`Add`・`Mul` だけを取る）。
- 行列の和の有限和で効いているのは、係数の和の有限和の分割（`finite_sum_add_fin'`。加法の結合則・交換則）と、成分の有限和
  （mathlib の `Matrix.sum_apply`）だけである。`AddCommMonoid` は `Finset.sum` を使うために要る。乗法は現れない。
  具体版の `r + 1 ≥ 1` 項（人手の `r ∈ ℤ_{≥1}`）に対し、ここでは `Fin n` の和で述べる。項が 1 つ以上あることは効いていない（`n = 0` は空の和で、`finite_sum_add_fin'` が扱う）。
- 行列の添字の集合は任意で、有限であることも順序も効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Ising2D.NecSuf.MatMulDistribSum
import Mathlib.Data.Matrix.Basic

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`((a + b)A)_{ij} = (aA + bA)_{ij}`**（具体版 `matrix_add_smul_apply`）。係数は `Add`・`Mul` と右分配則だけ。 -/
theorem add_smul_matrix_apply' {R : Type*} [Add R] [Mul R] [RightDistribClass R]
    (a b : R) (A : Matrix ι κ R) (i : ι) (j : κ) :
    ((a + b) • A) i j = (a • A + b • A) i j :=
  calc ((a + b) • A) i j
      = (a + b) * A i j := rfl                                                -- スカラー倍の定義
    _ = a * A i j + b * A i j := right_distrib _ _ _                          -- 右分配則
    _ = (a • A) i j + (b • A) i j := rfl                                      -- スカラー倍の定義（2 か所へ同時適用）
    _ = (a • A + b • A) i j := rfl                                            -- 和の定義

/-- **`(a + b)A = aA + bA`**（具体版 `matrix_add_smul`）。 -/
theorem add_smul_matrix' {R : Type*} [Add R] [Mul R] [RightDistribClass R]
    (a b : R) (A : Matrix ι κ R) :
    (a + b) • A = a • A + b • A :=
  Matrix.ext (add_smul_matrix_apply' a b A)   -- 全ての成分が一致する

/-- **`(Σ_j(X_j + Y_j))_{ik} = (Σ X_j + Σ Y_j)_{ik}`**（具体版 `finite_sum_of_matrix_sums_apply`。添字は `Fin n` で、空でなくてよい）。 -/
theorem finite_sum_add_matrix_apply' {R : Type*} [AddCommMonoid R] (n : ℕ) (X Y : Fin n → Matrix ι κ R)
    (i : ι) (k : κ) :
    (∑ j, (X j + Y j)) i k = ((∑ j, X j) + ∑ j, Y j) i k :=
  calc (∑ j, (X j + Y j)) i k
      = ∑ j, (X j + Y j) i k := Matrix.sum_apply _ _ _ _                      -- 成分の有限和
    _ = ∑ j, (X j i k + Y j i k) := rfl                                       -- 和の定義を各項へ
    _ = (∑ j, X j i k) + ∑ j, Y j i k :=
        finite_sum_add_fin' _ (fun j => X j i k) (fun j => Y j i k)           -- 係数の和の有限和の分割
    _ = (∑ j, X j) i k + (∑ j, Y j) i k := by
        rw [Matrix.sum_apply, Matrix.sum_apply]                               -- 成分の有限和を右辺から左辺へ 2 か所
    _ = ((∑ j, X j) + ∑ j, Y j) i k := rfl                                    -- 和の定義

/-- **`Σ_j(X_j + Y_j) = Σ X_j + Σ Y_j`**（具体版 `finite_sum_of_matrix_sums`。添字は `Fin n`）。 -/
theorem finite_sum_add_matrix' {R : Type*} [AddCommMonoid R] (n : ℕ) (X Y : Fin n → Matrix ι κ R) :
    ∑ j, (X j + Y j) = (∑ j, X j) + ∑ j, Y j :=
  Matrix.ext (finite_sum_add_matrix_apply' n X Y)   -- 全ての成分が一致する

end Ising2D.NecSuf
