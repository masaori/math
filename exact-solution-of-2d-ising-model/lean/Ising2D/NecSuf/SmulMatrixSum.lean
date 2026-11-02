/-
# スカラー倍は行列の和・有限和に分配する（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixSum.lean`
（人手 `scalar_multiple_distributes_over_matrix_sum`・`finite_sum_of_scalar_multiples`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimScalarMultipleDistributesOverMatrixSumFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_smul_add_apply`（スカラー倍の定義 → 和の定義 → 左分配則 → スカラー倍の定義を 2 か所 → 和の定義） | `smul_add_matrix_apply'`（同じ並び） |
| `matrix_smul_add`（全ての成分が一致する） | `smul_add_matrix'` |
| `finite_sum_smul_of_matrices`（`r + 1` 項の帰納法。有限和の定義 → 帰納法の仮定 → 和のスカラー倍を右辺から左辺へ → 有限和の定義） | `finite_sum_smul_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- スカラーは係数と同じ集合の元が左から掛かるものとした（具体版のスカラー倍が `ℂ` の積であることに合わせた。`Mul` から入る `SMul`）。
- 和のスカラー倍で効いているのは、係数の**左分配則**（`LeftDistribClass`）だけである。外すと `c(x + y) = cx + cy` の段が通らない。
- **加法の結合則・交換則・零・逆元、乗法の結合則・単位元・可換則は、和のスカラー倍では効いていない**（`Add`・`Mul` だけを取る）。
- 有限和のスカラー倍で効いているのは、上の和のスカラー倍と有限和の定義（左から足す）だけである。`AddCommMonoid` は、mathlib の `Finset.sum` を
  人手の左から足す有限和の定義の代わりに使うために要る（`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` の証明は加法の結合則・交換則に依る）。
  人手の定義どおりに左から足した和なら、`r + 1 ≥ 1` 項の帰納法の段に加法の結合則・交換則・零は現れない。
- 添字の集合は任意で、有限であることも順序も効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`(c(A + B))_{ij} = (cA + cB)_{ij}`**（具体版 `matrix_smul_add_apply`）。係数は `Add`・`Mul` と左分配則だけ。 -/
theorem smul_add_matrix_apply' {R : Type*} [Add R] [Mul R] [LeftDistribClass R]
    (c : R) (A B : Matrix ι κ R) (i : ι) (j : κ) :
    (c • (A + B)) i j = (c • A + c • B) i j :=
  calc (c • (A + B)) i j
      = c * (A + B) i j := rfl                                                -- スカラー倍の定義
    _ = c * (A i j + B i j) := rfl                                            -- 和の定義
    _ = c * A i j + c * B i j := left_distrib _ _ _                           -- 左分配則
    _ = (c • A) i j + (c • B) i j := rfl                                      -- スカラー倍の定義（2 か所へ同時適用）
    _ = (c • A + c • B) i j := rfl                                            -- 和の定義

/-- **`c(A + B) = cA + cB`**（具体版 `matrix_smul_add`）。 -/
theorem smul_add_matrix' {R : Type*} [Add R] [Mul R] [LeftDistribClass R]
    (c : R) (A B : Matrix ι κ R) :
    c • (A + B) = c • A + c • B :=
  Matrix.ext (smul_add_matrix_apply' c A B)   -- 全ての成分が一致する

/-- **`Σ_{j=1}^{r+1} (cX_j) = cΣ_{j=1}^{r+1} X_j`**（具体版 `finite_sum_smul_of_matrices`）。`r` についての帰納法。 -/
theorem finite_sum_smul_matrix' {R : Type*} [AddCommMonoid R] [Mul R] [LeftDistribClass R] (c : R) :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix ι κ R), ∑ j, c • X j = c • ∑ j, X j
  | 0, X =>
    calc ∑ j : Fin 1, c • X j
        = c • X 0 := Fin.sum_univ_one (fun j => c • X j)                      -- 有限和の定義（1 項）
      _ = c • ∑ j : Fin 1, X j := by rw [Fin.sum_univ_one]                    -- 有限和の定義（1 項）
  | r + 1, X =>
    calc ∑ j : Fin (r + 2), c • X j
        = (∑ j : Fin (r + 1), c • X j.castSucc) + c • X (Fin.last _) :=
          Fin.sum_univ_castSucc (fun j => c • X j)                            -- 有限和の定義（項を 1 つ足す）
      _ = (c • ∑ j : Fin (r + 1), X j.castSucc) + c • X (Fin.last _) := by
          rw [finite_sum_smul_matrix' c r (fun j => X j.castSucc)]            -- 帰納法の仮定
      _ = c • ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _)) :=
          (smul_add_matrix' c _ _).symm                                       -- 和のスカラー倍（右辺から左辺へ）
      _ = c • ∑ j : Fin (r + 2), X j := by rw [Fin.sum_univ_castSucc X]        -- 有限和の定義（項を 1 つ足す）

end Ising2D.NecSuf
