/-
# 行列の有限積と、単位行列の有限積は単位行列（**具体版**）

対応する人手証明のラベル: `def_finite_product_of_matrices`・`finite_product_of_identity_matrices`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_finite_product_of_matrices`・
`linear_space_general_claim_finite_product_of_identity_matrices`）。

**必要十分版**: `Ising2D/NecSuf/FiniteProductLeft.lean`。具体版をその系として導くのは
`DefinitionFiniteProductOfMatricesFromNecSuf.lean`。

## 人手証明との対応

* 行列の添字は一般の有限型 `ι` にしてある。人手の `Mat(n,ℂ)` は `ι := Fin n`、人手の `Mat(2^{M_col},ℂ)` は `ι := Conf M`（`TensorPow M`）である。
  人手の定義は行列の次数を固定しないので、添字の型を一つに決めないことで両方へそのまま当てる。
  `finite_product_of_identity_matrices` は人手どおり `Mat(n,ℂ)`（`ι := Fin n`）について述べる。
* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。Lean の `finiteMatrixProduct r A`（因子 `A : Fin (r + 1) → Matrix ι ι ℂ`）は人手の `∏_{j=1}^{r+1} A_j` で、人手の `A_j` が Lean の `A (j - 1)` である。
  定義の 2 つの式は `finiteMatrixProduct` の 2 つの節で、`finiteMatrixProduct_zero`・`finiteMatrixProduct_succ` として引く。
  mathlib の `List.prod`（右から畳み込み、空の積は `1`）は人手の定義と形が違うので使わない。
* `finite_product_of_identity_matrices` の帰納法の 2 つの鎖（`r = 1` の 1 行、`r → r + 1` の 3 行）は、同じ名前の定理の 2 つの節の `calc` と 1 対 1 である。
  最後の行の `identity_matrix_is_right_unit_of_mat_mult`（`A → I`）は具体版 `mul_identity_matrix` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct

namespace Ising2D

open Matrix

/-- **`def_finite_product_of_matrices`**: `r + 1` 個の正方行列（添字の型 `ι`、成分は `ℂ`）を左から順に掛ける。 -/
def finiteMatrixProduct {ι : Type*} [Fintype ι] :
    (r : ℕ) → (Fin (r + 1) → Matrix ι ι ℂ) → Matrix ι ι ℂ
  | 0, A => A 0
  | r + 1, A => finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1))

/-- `def_finite_product_of_matrices` の 1 つ目の式: `∏_{j=1}^{1} A_j := A_1`。 -/
theorem finiteMatrixProduct_zero {ι : Type*} [Fintype ι] (A : Fin 1 → Matrix ι ι ℂ) :
    finiteMatrixProduct 0 A = A 0 := rfl

/-- `def_finite_product_of_matrices` の 2 つ目の式: `∏_{j=1}^{r+2} A_j := (∏_{j=1}^{r+1} A_j) A_{r+2}`（人手の `r` は Lean の `r + 1`）。 -/
theorem finiteMatrixProduct_succ {ι : Type*} [Fintype ι] (r : ℕ) (A : Fin (r + 2) → Matrix ι ι ℂ) :
    finiteMatrixProduct (r + 1) A
      = finiteMatrixProduct r (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 1)) := rfl

/-- **`finite_product_of_identity_matrices`**: `∏_{j=1}^{r} I_{Mat(n,ℂ)} = I_{Mat(n,ℂ)}`（人手の `r` は Lean の `r + 1`）。 -/
theorem finite_product_of_identity_matrices {n : ℕ} :
    ∀ r : ℕ, finiteMatrixProduct r (fun _ => (1 : Matrix (Fin n) (Fin n) ℂ)) = 1
  | 0 =>
    calc finiteMatrixProduct 0 (fun _ => (1 : Matrix (Fin n) (Fin n) ℂ))
        = 1 := finiteMatrixProduct_zero _                                       -- `def_finite_product_of_matrices`
  | r + 1 =>
    calc finiteMatrixProduct (r + 1) (fun _ => (1 : Matrix (Fin n) (Fin n) ℂ))
        = finiteMatrixProduct r (fun _ => (1 : Matrix (Fin n) (Fin n) ℂ)) * 1 :=
          finiteMatrixProduct_succ r _                                          -- `def_finite_product_of_matrices`
      _ = 1 * 1 := by rw [finite_product_of_identity_matrices r]               -- 帰納法の仮定
      _ = 1 := mul_identity_matrix 1                                            -- `identity_matrix_is_right_unit_of_mat_mult`（`A → I`）

end Ising2D
