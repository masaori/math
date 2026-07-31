/-
# `ε` は `Ž, Y̌, ψ̌` と反可換（具体版）

正本: `structured-latex/content/018_even_sector_closing.ts`
（`closing_001_claim_epsilon_anticommutes`、ラベル **`epsilon_anticommutes_with_check_Z_Y`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）の
`Ising2D.NecSuf.anticomm_sum_smul` / `NecSuf.commute_parity_num` /
`NecSuf.commute_parity_projOn`。本ファイルの (2)(3) はその**系**である。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `ε Z_j = -Z_j ε`, `ε Y_j = -Y_j ε` | `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y`（章 010 で証明済み。再掲） |
| (2) `ε Ž_μ = -Ž_μ ε`, `ε Y̌_μ = -Y̌_μ ε` | `Ising2D.epsilon_anticomm_checkZ` / `epsilon_anticomm_checkY` |
| (3) `ε ψ̌_μ^† = -ψ̌_μ^† ε` | `Ising2D.epsilon_anticomm_of_isCheckMode` |
| (4) `ε ň_μ = ň_μ ε`, `ε Q̌_ε = Q̌_ε ε` | `Ising2D.CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`（`Setup.lean`） |

**(1)(2)(3) は無条件である**（章 004・010・013 の形式化済みの定理だけを使う）。
(3) だけは「`ψ̌` が `Ž, Y̌` の 1 次結合であること」（原文 `def_check_fermi`、章 016）を
述語 `Ising2D.IsCheckMode` として受け取る形にしてある。
-/
import Ising2D.NecSuf.ParityFermion
import Ising2D.Part010.Claim010_EpsilonCommutes
import Ising2D.Part013.Definition003_HalfIntegerModes

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手証明 (2)**: `ε Ž_μ = -Ž_μ ε`。

必要十分版 `Ising2D.NecSuf.anticomm_sum_smul` の特殊化として導く
（`Ž_μ` は `Z_j` の ℂ 係数有限和である）。 -/
theorem epsilon_anticomm_checkZ (M : ℕ) (μ : ℤ) :
    epsilon M * checkZ M μ = -(checkZ M μ * epsilon M) := by
  rw [checkZ]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Z j) Finset.univ _

/-- **人手証明 (2)**: `ε Y̌_μ = -Y̌_μ ε`。 -/
theorem epsilon_anticomm_checkY (M : ℕ) (μ : ℤ) :
    epsilon M * checkY M μ = -(checkY M μ * epsilon M) := by
  rw [checkY]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Y j) Finset.univ _

/-- 原文 `def_check_fermi` の「`ψ̌_μ^†` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合」。 -/
def IsCheckMode (x : TensorPow M) : Prop :=
  ∃ (ν : ℤ) (p q : ℂ), x = p • checkZ M ν + q • checkY M ν

/-- **人手証明 (3)**: `Ž, Y̌` の 1 次結合はすべて `ε` と反交換する。 -/
theorem epsilon_anticomm_of_isCheckMode {x : TensorPow M} (h : IsCheckMode x) :
    epsilon M * x = -(x * epsilon M) := by
  obtain ⟨ν, p, q, rfl⟩ := h
  rw [mul_add, add_mul, neg_add, mul_smul_comm, smul_mul_assoc, epsilon_anticomm_checkZ,
    mul_smul_comm, smul_mul_assoc, epsilon_anticomm_checkY, smul_neg, smul_neg]

end Ising2D
