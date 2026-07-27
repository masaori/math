/-
# 分配関数の挟み撃ち `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}`

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_009_claim_partition_function_sandwich`、ラベル **`partition_function_sandwich`**）

人手証明は `Z_equals_trace_of_W` と `trace_power_sandwich` を合わせるだけなので、
本ファイルもそれをそのまま写す。

**章 010 への依存**: `Z(J,J') = tr((V₁V₂)^{N_row})`（ラベル `partition_function_in_pauli_form`）
は章 010 の結果であり、本タスクの担当外なので **仮定 `hZ` として受け取る**。

抽象版は置かない（この主張は `trace_power_sandwich` の言い換えであり、
抽象的な内容は `Ising2D/Abstract/RayleighMoments.lean` に尽きている）。
-/
import Ising2D.Part011.Definition001_SymmetrizedTransferMatrix

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n] [Nonempty n]

/-- **分配関数の挟み撃ち**（人手証明 `partition_function_sandwich`）。

* `hBB : B * B = V₁`（`B = V₁^{1/2}`）
* `hB`, `hBunit`: `V₁^{1/2}` は実対称かつ可逆
* `hV2symm`, `hV2pd`: `V₂` は実対称正定値（章 009 の帰結。`Ising2D.matExp_posDef` で作れる）
* `hZ`: `Z = tr((V₁V₂)^{N_row})`（**章 010 の `partition_function_in_pauli_form`**）

結論は `c(M)^{N_row} ≤ Z ≤ (dim) c(M)^{N_row}`（Ising では `dim = 2^M`）。 -/
theorem partition_function_sandwich {B V1 V2 : Matrix n n ℝ} (hBB : B * B = V1)
    (hB : B.IsSymm) (hBunit : IsUnit B) (hV2symm : V2.IsSymm)
    (hV2pd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ V2 *ᵥ x)
    {Z : ℝ} {N : ℕ} (hN : 1 ≤ N) (hZ : Z = ((V1 * V2) ^ N).trace) :
    rayleighSup (symTransfer B V2) ^ N ≤ Z ∧
      Z ≤ (Fintype.card n : ℝ) * rayleighSup (symTransfer B V2) ^ N := by
  obtain ⟨k, rfl⟩ : ∃ k, N = k + 1 := ⟨N - 1, by omega⟩
  have hWsymm : (symTransfer B V2).IsSymm := symTransfer_isSymm hB hV2symm
  have hWpd : ∀ x : n → ℝ, x ≠ 0 → 0 < x ⬝ᵥ symTransfer B V2 *ᵥ x :=
    fun x hx => symTransfer_posDef hB hBunit hV2pd x hx
  have hZW : Z = (symTransfer B V2 ^ (k + 1)).trace := by
    rw [hZ, trace_symTransfer_pow hBB k]
  rw [hZW]
  exact trace_power_sandwich hWsymm hWpd (by omega)

end Ising2D
