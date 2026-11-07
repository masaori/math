/-
# `c(M)^{N_row} ≤ Z ≤ 2^M c(M)^{N_row}` と `lim_{N_row→∞} (1/(M N_row)) log Z = (1/M) log c(M)`

対応する人手証明（正本は `structured-latex/content/thermodynamic_limit_row_limit_and_max_eigenvalue.ts`）:

* `row_limit_and_max_eigenvalue_claim_sandwich_and_limit_in_N_row`
  （ラベル **`partition_function_sandwich_and_limit_in_N_row`**）

主張（`K_1, K_2 > 0`、`M_col ≥ 2`。`W = V_1^{1/2}V_2V_1^{1/2}`、`W_ℝ` はその成分を実数として並べた行列、`c(M_col) = sup{x^⊤W_ℝx | ‖x‖ = 1} > 0`）:

1. `N_row ≥ 1` について `c(M_col)^{N_row} ≤ Z(K_1,K_2) ≤ 2^{M_col} c(M_col)^{N_row}`
2. `lim_{N_row→∞} (1/(M_col N_row)) log Z(K_1,K_2) = (1/M_col) log c(M_col)`

`Z` は `partitionFunction N_row M K_1 K_2`、`W_ℝ` は実数の行列 `physicalSymTransferR M K_1 K_2`、
`c(M_col)` は `rayleighSup (physicalSymTransferR M K_1 K_2)` である。
人手の `d := 2_ℤ^{M_col}`（`W ∈ Mat(d,ℂ)`・`W_ℝ ∈ Mat(d,ℝ)`・`x ∈ ℝ^d`）に当たる添字は `Conf M` で、
`d = 2_ℤ^M` に当たるのは `ℕ` の等式 `card_conf_nat` である。(1) の `2^{M_col}` は人手では `ℝ` の元 `2_ℝ^{M_col}` で、
Lean でも `(2 : ℝ) ^ M` である。(2) の `M_col N_row`・`M_col` は人手の `ι_{ℤ→ℝ}` の像で、Lean では `ℕ → ℝ` の
キャスト `(M : ℝ)`・`(Nrow : ℝ)` である。

## 人手証明との対応

- 主張の前提 `c(M_col) ∈ ℝ_{>0}`（人手 `def_rayleigh_sup`）: `rayleighSup_pos` に
  `W` の正定値性（人手 `W_is_real_symmetric_positive_definite`。`physicalSymTransferR_posDef`）を渡したもの
- (1): 人手 `partition_function_sandwich`（`partition_function_sandwich_physical`）
- (2): 人手 `limit_of_log_Z_in_N_row`（`Ising2D.limit_of_log_Z_in_N_row` に (1) を渡したもの）

仮定 `K_1 > 0` は人手の主張どおりに受け取る（人手は `Z` の定義 `def_partition_function_2d_ising` の定義域
`ℝ_{>0} × ℝ_{>0}` から `K_1, K_2 ∈ ℝ_{>0}` を置く）。証明は `K_1 > 0` を使わない: Lean の `partitionFunction` は
`ℝ × ℝ` の上で定義されており、`W` の実対称性・正定値性も挟み撃ちも `K_2 > 0` だけで成り立つ。
人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（(2) の必要十分版は `Ising2D/NecSuf/LogSqueeze.lean`、(1) の中身は `Ising2D/NecSuf/RayleighMoments.lean` が持つ）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.PhysicalPartitionFunctionSandwich
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.ClaimLimitInNRow

namespace Ising2D

open Filter
open scoped Topology

variable {M : ℕ}

/-- **人手 `partition_function_sandwich_and_limit_in_N_row`**:
`K_1, K_2 > 0`、`M_col ≥ 2` で、`c(M_col) > 0`、`N_row ≥ 1` で `c(M_col)^{N_row} ≤ Z ≤ 2^{M_col} c(M_col)^{N_row}`、
`(1/(M_col N_row)) log Z → (1/M_col) log c(M_col)`。 -/
theorem partition_function_sandwich_and_limit_in_N_row {K1 K2 : ℝ} (_hK1 : 0 < K1) (hK2 : 0 < K2)
    (hM : 2 ≤ M) :
    0 < rayleighSup (physicalSymTransferR M K1 K2)
      ∧ (∀ Nrow : ℕ, 1 ≤ Nrow →
          rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow ≤ partitionFunction Nrow M K1 K2
            ∧ partitionFunction Nrow M K1 K2
              ≤ 2 ^ M * rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow)
      ∧ Tendsto (fun Nrow : ℕ => 1 / ((M : ℝ) * Nrow) * Real.log (partitionFunction Nrow M K1 K2))
          atTop (𝓝 (1 / (M : ℝ) * Real.log (rayleighSup (physicalSymTransferR M K1 K2)))) := by
  -- 前提: c(M_col) > 0（人手 def_rayleigh_sup と W_is_real_symmetric_positive_definite）
  have hc : 0 < rayleighSup (physicalSymTransferR M K1 K2) :=
    rayleighSup_pos (physicalSymTransferR_posDef K1 hK2)
  -- (1): 人手 partition_function_sandwich
  have h1 : ∀ Nrow : ℕ, 1 ≤ Nrow →
      rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow ≤ partitionFunction Nrow M K1 K2
        ∧ partitionFunction Nrow M K1 K2
          ≤ 2 ^ M * rayleighSup (physicalSymTransferR M K1 K2) ^ Nrow :=
    fun _ hN => partition_function_sandwich_physical K1 hK2 hN
  -- (2): 人手 limit_of_log_Z_in_N_row に (1) を渡す
  exact ⟨hc, h1, limit_of_log_Z_in_N_row hM hc (fun N hN => (h1 N hN).1) (fun N hN => (h1 N hN).2)⟩

end Ising2D
