/-
# 行列の有限積と、単位行列の有限積は単位行列（具体版を必要十分版から導く）

具体版 `DefinitionFiniteProductOfMatrices.lean` の定義と主張を、必要十分版 `Ising2D/NecSuf/FiniteProductLeft.lean` の
`R := Mat(n,ℂ)` の特殊化として得る。`h := mul_identity_matrix 1`（人手の `identity_matrix_is_right_unit_of_mat_mult` の `A → I`）を渡す。
人手のラベルは `def_finite_product_of_matrices`・`finite_product_of_identity_matrices`。

有限積の定義 `finiteMatrixProduct` は添字の型 `ι` を一般にしてあるので、`finiteMatrixProduct_eq_finProdLeft` は `R := Matrix ι ι ℂ` の特殊化である。
`finite_product_of_identity_matrices` の `TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版の
`finite_product_of_identity_matrices` は人手どおり添字が `Fin n` の行列について述べてあり、`Conf M` の行列には当てはまらないためである。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D

/-- 具体版の有限積 `finiteMatrixProduct` は、必要十分版 `NecSuf.finProdLeft` の `R := Matrix ι ι ℂ` の場合である（2 つの節が一致する）。 -/
theorem finiteMatrixProduct_eq_finProdLeft {ι : Type*} [Fintype ι] :
    ∀ (r : ℕ) (A : Fin (r + 1) → Matrix ι ι ℂ), finiteMatrixProduct r A = NecSuf.finProdLeft r A
  | 0, _ => rfl
  | r + 1, A => by
    rw [finiteMatrixProduct_succ, NecSuf.finProdLeft_succ, finiteMatrixProduct_eq_finProdLeft r]

/-- `finite_product_of_identity_matrices` を `NecSuf.finProdLeft_const_one'`（`R := Mat(n,ℂ)`）の特殊化として得る。 -/
theorem finite_product_of_identity_matrices_of_necSuf {n : ℕ} (r : ℕ) :
    finiteMatrixProduct r (fun _ => (1 : Matrix (Fin n) (Fin n) ℂ)) = 1 := by
  rw [finiteMatrixProduct_eq_finProdLeft]
  exact NecSuf.finProdLeft_const_one' (mul_identity_matrix 1) r

/-- `finite_product_of_identity_matrices` の `TensorPow M` での系（`NecSuf.finProdLeft_const_one'` の `R := TensorPow M` の特殊化）。 -/
theorem finite_product_of_identity_matrices_tensorPow {M : ℕ} (r : ℕ) :
    NecSuf.finProdLeft r (fun _ => (1 : TensorPow M)) = 1 :=
  NecSuf.finProdLeft_const_one' (mul_identity_matrix_tensorPow 1) r

end Ising2D
