/-
# 行列の和・スカラー倍・差・有限和の転置（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiples.lean`
（人手 `transpose_of_matrix_sum`・`transpose_of_matrix_scalar_multiple`・`transpose_of_matrix_difference`・`transpose_of_finite_sum_of_matrices`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimTransposeOfMatrixSumsAndScalarMultiplesFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_transpose_add_apply`（転置の定義 → 和の定義 → 転置の定義を 2 か所 → 和の定義） | `transpose_add_matrix_apply'`（同じ並び） |
| `matrix_transpose_smul_apply`（転置の定義 → スカラー倍の定義 → 転置の定義 → スカラー倍の定義） | `transpose_smul_matrix_apply'`（同じ並び） |
| `matrix_transpose_sub_apply`（転置の定義 → 差の定義 → 転置の定義を 2 か所 → 差の定義） | `transpose_sub_matrix_apply'`（同じ並び） |
| `matrix_transpose_add`・`matrix_transpose_smul`・`matrix_transpose_sub`（全ての成分が一致する） | `transpose_add_matrix'`・`transpose_smul_matrix'`・`transpose_sub_matrix'` |
| `finite_sum_transpose_of_matrices`（`r + 1` 項の帰納法。有限和の定義 → 和の転置 → 帰納法の仮定 → 有限和の定義） | `finite_sum_transpose_matrix'`（同じ並び） |

## 何が効いているか / 効いていないか

- 和・スカラー倍・差の転置で効いているのは、**和・スカラー倍・差が成分ごとの演算であることと、転置が成分の添字を入れ替えることだけ**である。
  係数の型 `R` に置いたのは、和の転置では `Add R`、スカラー倍の転置では `Mul R`（スカラー倍は `R` の積を成分ごとに左から掛けるもの）、
  差の転置では `Sub R` だけで、どれも演算の性質（結合則・交換則・分配則・零・単位元・逆元）を 1 つも使わない。
  具体版の成分の鎖の 4 段はどれも定義の展開であり、`ℂ` の演算の法則を引く段が無いことと一致する。
- 有限和の転置で効いているのは、上の和の転置と有限和の定義（左から足す）だけである。`AddCommMonoid` は、mathlib の `Finset.sum` を
  人手の左から足す有限和の定義の代わりに使うために要る（`Fin.sum_univ_one`・`Fin.sum_univ_castSucc` の証明は加法の結合則・交換則に依る）。
  人手の定義どおりに左から足した和なら、`r + 1 ≥ 1` 項の帰納法の段に加法の結合則・交換則・零は現れない（`NecSuf/SmulMatrixSum.lean` と同じ）。
- 行と列の添字の集合は任意の型で、有限であることも順序も正方であることも効いていない（積を使わないため）。複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`((A + B)^⊤)_{pq} = (A^⊤ + B^⊤)_{pq}`**（具体版 `matrix_transpose_add_apply`）。係数は `Add` だけ。 -/
theorem transpose_add_matrix_apply' {R : Type*} [Add R] (A B : Matrix ι κ R) (p : κ) (q : ι) :
    (A + B)ᵀ p q = (Aᵀ + Bᵀ) p q :=
  calc (A + B)ᵀ p q
      = (A + B) q p := rfl                                                    -- 転置の定義
    _ = A q p + B q p := rfl                                                  -- 和の定義
    _ = Aᵀ p q + Bᵀ p q := rfl                                                -- 転置の定義（2 か所へ同時適用）
    _ = (Aᵀ + Bᵀ) p q := rfl                                                  -- 和の定義

/-- **`(A + B)^⊤ = A^⊤ + B^⊤`**（具体版 `matrix_transpose_add`）。 -/
theorem transpose_add_matrix' {R : Type*} [Add R] (A B : Matrix ι κ R) : (A + B)ᵀ = Aᵀ + Bᵀ :=
  Matrix.ext (transpose_add_matrix_apply' A B)   -- 全ての成分が一致する

/-- **`((cA)^⊤)_{pq} = (cA^⊤)_{pq}`**（具体版 `matrix_transpose_smul_apply`）。係数は `Mul` だけ。 -/
theorem transpose_smul_matrix_apply' {R : Type*} [Mul R] (c : R) (A : Matrix ι κ R) (p : κ) (q : ι) :
    (c • A)ᵀ p q = (c • Aᵀ) p q :=
  calc (c • A)ᵀ p q
      = (c • A) q p := rfl                                                    -- 転置の定義
    _ = c * A q p := rfl                                                      -- スカラー倍の定義
    _ = c * Aᵀ p q := rfl                                                     -- 転置の定義
    _ = (c • Aᵀ) p q := rfl                                                   -- スカラー倍の定義

/-- **`(cA)^⊤ = cA^⊤`**（具体版 `matrix_transpose_smul`）。 -/
theorem transpose_smul_matrix' {R : Type*} [Mul R] (c : R) (A : Matrix ι κ R) : (c • A)ᵀ = c • Aᵀ :=
  Matrix.ext (transpose_smul_matrix_apply' c A)   -- 全ての成分が一致する

/-- **`((A - B)^⊤)_{ki} = (A^⊤ - B^⊤)_{ki}`**（具体版 `matrix_transpose_sub_apply`）。係数は `Sub` だけ。 -/
theorem transpose_sub_matrix_apply' {R : Type*} [Sub R] (A B : Matrix ι κ R) (k : κ) (i : ι) :
    (A - B)ᵀ k i = (Aᵀ - Bᵀ) k i :=
  calc (A - B)ᵀ k i
      = (A - B) i k := rfl                                                    -- 転置の定義
    _ = A i k - B i k := rfl                                                  -- 差の定義
    _ = Aᵀ k i - Bᵀ k i := rfl                                                -- 転置の定義（2 か所へ同時適用）
    _ = (Aᵀ - Bᵀ) k i := rfl                                                  -- 差の定義

/-- **`(A - B)^⊤ = A^⊤ - B^⊤`**（具体版 `matrix_transpose_sub`）。 -/
theorem transpose_sub_matrix' {R : Type*} [Sub R] (A B : Matrix ι κ R) : (A - B)ᵀ = Aᵀ - Bᵀ :=
  Matrix.ext (transpose_sub_matrix_apply' A B)   -- 全ての成分が一致する

/-- **`(Σ_{j=1}^{r+1} X_j)^⊤ = Σ_{j=1}^{r+1} X_j^⊤`**（具体版 `finite_sum_transpose_of_matrices`）。`r` についての帰納法。 -/
theorem finite_sum_transpose_matrix' {R : Type*} [AddCommMonoid R] :
    ∀ (r : ℕ) (X : Fin (r + 1) → Matrix ι κ R), (∑ j, X j)ᵀ = ∑ j, (X j)ᵀ
  | 0, X =>
    calc (∑ j : Fin 1, X j)ᵀ
        = (X 0)ᵀ := by rw [Fin.sum_univ_one]                                  -- 有限和の定義（1 項）
      _ = ∑ j : Fin 1, (X j)ᵀ := (Fin.sum_univ_one (fun j => (X j)ᵀ)).symm    -- 有限和の定義（1 項）
  | r + 1, X =>
    calc (∑ j : Fin (r + 2), X j)ᵀ
        = ((∑ j : Fin (r + 1), X j.castSucc) + X (Fin.last _))ᵀ := by
          rw [Fin.sum_univ_castSucc X]                                        -- 有限和の定義（項を 1 つ足す）
      _ = (∑ j : Fin (r + 1), X j.castSucc)ᵀ + (X (Fin.last _))ᵀ :=
          transpose_add_matrix' _ _                                           -- 和の転置
      _ = (∑ j : Fin (r + 1), (X j.castSucc)ᵀ) + (X (Fin.last _))ᵀ := by
          rw [finite_sum_transpose_matrix' r (fun j => X j.castSucc)]         -- 帰納法の仮定
      _ = ∑ j : Fin (r + 2), (X j)ᵀ :=
          (Fin.sum_univ_castSucc (fun j => (X j)ᵀ)).symm                      -- 有限和の定義（項を 1 つ足す）

end Ising2D.NecSuf
