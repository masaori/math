/-
# 係数の和によるスカラー倍と、行列の和の有限和（具体版を必要十分版から導く）

具体版 `ClaimScalarSumAndFiniteSumOfMatrixSums.lean` の主張を、必要十分版 `Ising2D/NecSuf/ScalarSumAndFiniteSumOfMatrixSums.lean` の
係数 `R := ℂ`、添字 `Fin m`・`Fin n` の特殊化として得る。人手のラベルは `scalar_sum_distributes_over_matrix`・`finite_sum_of_matrix_sums`。

`TensorPow M`（添字 `Conf M`）の系も同じ必要十分版の特殊化として置く。具体版は添字が `Fin m` の行列について述べてあり、
`Conf M` の行列には当てはまらないためである。人手 `Z_Y_linearly_independent` の Step 6 の鎖を `TensorPow M` の上で組むときに使う予定で、
和の添字は `Fin n`（項の個数を問わない）で述べる。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarSumAndFiniteSumOfMatrixSums
import Ising2D.NecSuf.ScalarSumAndFiniteSumOfMatrixSums
import Ising2D.Basic

namespace Ising2D

/-- `matrix_add_smul` を `NecSuf.add_smul_matrix'`（係数 `ℂ`）の特殊化として得る。 -/
theorem matrix_add_smul_of_necSuf {m n : ℕ} (a b : ℂ) (A : Matrix (Fin m) (Fin n) ℂ) :
    (a + b) • A = a • A + b • A :=
  NecSuf.add_smul_matrix' a b A

/-- `finite_sum_of_matrix_sums` を `NecSuf.finite_sum_add_matrix'`（係数 `ℂ`、必要十分版の項数の引数を `r + 1` に）の特殊化として得る。 -/
theorem finite_sum_of_matrix_sums_of_necSuf {m n : ℕ} (r : ℕ) (X Y : Fin (r + 1) → Matrix (Fin m) (Fin n) ℂ) :
    ∑ j, (X j + Y j) = (∑ j, X j) + ∑ j, Y j :=
  NecSuf.finite_sum_add_matrix' (r + 1) X Y

/-- `scalar_sum_distributes_over_matrix` の `TensorPow M` での系（`NecSuf.add_smul_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem add_smul_tensorPow {M : ℕ} (a b : ℂ) (A : TensorPow M) : (a + b) • A = a • A + b • A :=
  NecSuf.add_smul_matrix' a b A

/-- `finite_sum_of_matrix_sums` の `TensorPow M` での系（`NecSuf.finite_sum_add_matrix'` の添字 `Conf M` の特殊化）。 -/
theorem finite_sum_of_matrix_sums_tensorPow {M : ℕ} (n : ℕ) (X Y : Fin n → TensorPow M) :
    ∑ j, (X j + Y j) = (∑ j, X j) + ∑ j, Y j :=
  NecSuf.finite_sum_add_matrix' n X Y

/-- `finite_sum_of_matrix_sums` の `TensorPow M` での系で、和の添字が有限型 `κ` のもの。`κ` に固定した番号を付けて
`Fin (card κ)` の上の和へ移し、`finite_sum_of_matrix_sums_tensorPow` を当てて番号を外す。
人手 `Z_Y_linearly_independent` の Step 6 の `Σ_{q=1}^{N}` を、Lean の多重添字 `Fin M → Fin 4` の上の和で書くために置く
（人手の全単射 `π` で並べた添字 `q` を、Lean は多重添字そのもので書く）。 -/
theorem finite_sum_of_matrix_sums_tensorPow_fintype {M : ℕ} {κ : Type*} [Fintype κ] (X Y : κ → TensorPow M) :
    ∑ j, (X j + Y j) = (∑ j, X j) + ∑ j, Y j := by
  let e : κ ≃ Fin (Fintype.card κ) := Fintype.equivFin κ
  calc ∑ j, (X j + Y j)
      = ∑ i, (X (e.symm i) + Y (e.symm i)) := (e.symm.sum_comp _).symm            -- `κ` に番号を付ける
    _ = (∑ i, X (e.symm i)) + ∑ i, Y (e.symm i) :=
        finite_sum_of_matrix_sums_tensorPow _ _ _                                  -- `finite_sum_of_matrix_sums`（`n → card κ`）
    _ = (∑ j, X j) + ∑ j, Y j := by rw [e.symm.sum_comp, e.symm.sum_comp]         -- 番号を外す

end Ising2D
