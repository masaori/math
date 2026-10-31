/-
# Pauli 行列で書いた転送行列による分配関数の表式

対応する人手証明（正本は `structured-latex/content/partition_function_transfer_matrix_representation.ts`）:

* `transfer_matrix_representation_claim_partition_function_via_pauli_transfer_matrices`
  （ラベル **`partition_function_via_pauli_transfer_matrices`**）

主張: `K_1, K_2 > 0` のとき
`Z(K_1,K_2) = tr((exp(K_1 ∑_m σ^z_m σ^z_{m+1}) (2 sinh 2K_2)^{M_col/2} exp(K_2^* ∑_m σ^x_m))^{N_row})`。

## 人手証明との対応

人手の証明は式変形 3 行で、各行が次の定理の書き換えに当たる。

1. `Z(K_1,K_2) = tr((V_1V_2)^{N_row})`: `partition_function_via_transfer_matrix`
2. `V_1` をパウリ行列表示へ: `first_transfer_matrix_pauli_form`
3. `V_2` をパウリ行列表示へ: `second_transfer_matrix_pauli_form`

`V1PauliForm M K1` と `V2PauliForm M (sinh 2K_2) K_2^*` は、それぞれ右辺の式に付けた名前である。
人手の仮定 `K_1 > 0` は、この 3 行のどれも使わないので置かない。
-/
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimPartitionFunctionViaTransferMatrix
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimFirstTransferMatrixPauliForm
import Ising2D.PartitionFunction.TransferMatrixRepresentation.ClaimSecondTransferMatrixPauliForm

namespace Ising2D

variable {M : ℕ}

/-- **人手 `partition_function_via_pauli_transfer_matrices`**。 -/
theorem partition_function_via_pauli_transfer_matrices (K1 : ℝ) {K2 : ℝ} (hK2 : 0 < K2)
    {Nrow : ℕ} (hN : 1 ≤ Nrow) :
    ((partitionFunction Nrow M K1 K2 : ℝ) : ℂ) =
      ((V1PauliForm M (K1 : ℂ) * V2PauliForm M (Real.sinh (2 * K2)) ((Kstar K2 : ℝ) : ℂ)) ^ Nrow).trace := by
  rw [partition_function_via_transfer_matrix K1 K2 hN,   -- 人手の 1 行目
    first_transfer_matrix_pauli_form K1,                -- 人手の 2 行目
    second_transfer_matrix_pauli_form hK2]              -- 人手の 3 行目

end Ising2D
