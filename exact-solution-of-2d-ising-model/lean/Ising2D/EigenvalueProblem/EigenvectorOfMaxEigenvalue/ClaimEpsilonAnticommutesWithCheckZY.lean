/-
# `ε` は `Ž, Y̌, ψ̌` と反可換（具体版）

正本: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
（`closing_001_claim_epsilon_anticommutes`、ラベル **`epsilon_anticommutes_with_check_Z_Y`**）

必要十分版は `Ising2D/NecSuf/ParityFermion.lean`（同じラベル）の
`Ising2D.NecSuf.anticomm_sum_smul` / `NecSuf.anticomm_add_smul` / `NecSuf.commute_parity_num` /
`NecSuf.commute_parity_projOn`。(2) は人手の鎖と同じ行の calc（`epsilon_anticomm_phase_sum`）で示し、
必要十分版の特殊化として得られることは `epsilon_anticomm_checkZ_of_necSuf` / `epsilon_anticomm_checkY_of_necSuf`
に別に書く。(3) も人手の鎖と同じ行の calc（`epsilon_anticomm_two_term`）で示し、必要十分版
`NecSuf.anticomm_add_smul` の特殊化は `epsilon_anticomm_checkPsiDag_of_necSuf` / `epsilon_anticomm_checkPsi_of_necSuf` に別に書く。

## 人手証明との対応

| 人手証明 | 本ファイル |
| --- | --- |
| (1) `ε Z_j = -Z_j ε`, `ε Y_j = -Y_j ε` | `Ising2D.epsilon_anticomm_Z` / `epsilon_anticomm_Y`（章 010 で証明済み。再掲） |
| (2) の 9 行の鎖（`(W̌_μ, W)` を `(Ž_μ, Z)`・`(Y̌_μ, Y)` のどちらかとする） | `Ising2D.epsilon_anticomm_phase_sum`（`M_col = r + 1`） |
| (2) `ε Ž_μ = -Ž_μ ε`, `ε Y̌_μ = -Y̌_μ ε` | `Ising2D.epsilon_anticomm_checkZ` / `epsilon_anticomm_checkY` |
| (3) の 9 行の鎖（`(Ψ, p, q)` を `def_check_fermi` の二つの組のどちらかとする） | `Ising2D.epsilon_anticomm_two_term` |
| (3) `ε ψ̌_μ^† = -ψ̌_μ^† ε`, `ε ψ̌_μ = -ψ̌_μ ε` | `Ising2D.epsilon_anticomm_checkPsiDag` / `epsilon_anticomm_checkPsi`（`IsCheckMode` の元へは `epsilon_anticomm_of_isCheckMode`） |
| (4) `ε ň_μ = ň_μ ε`, `ε Q̌_ε = Q̌_ε ε` | `Ising2D.CheckFermi.commute_epsilon_nOp` / `commute_epsilon_Qproj`（`CheckFermiInput.lean`） |

**(1)(2)(3) は無条件である**（章 004・010・013 の形式化済みの定理と、`ψ̌_μ^†`・`ψ̌_μ` の定義
`checkPsiDag`・`checkPsi`（`DefinitionCheckFermi.lean`）だけを使う）。
`CheckFermi` が受け取る生成・消滅演算子へは、「`Ž, Y̌` の 1 次結合であること」を述語 `Ising2D.IsCheckMode`
として受け取る `epsilon_anticomm_of_isCheckMode` で渡す。
-/
import Ising2D.NecSuf.ParityFermion
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.ClaimEpsilonCommutes
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionHalfIntegerModes
import Ising2D.EigenvalueProblem.DiagonalizationAndExponentialForm.DefinitionCheckFermi
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSumFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInRightFactorFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimFiniteSumOfMatricesDistributesInLeftFactorFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimScalarMultipleOfNegatedMatrixFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimNegationDistributesOverMatrixSumFromNecSuf

namespace Ising2D

open Matrix

variable {M : ℕ}

/-- **人手証明 (2) の鎖**（`M_col = r + 1`）。`(W̌_μ, W)` を `(Ž_μ, Z)` と `(Y̌_μ, Y)` のどちらかとし、
`c_j` を位相因子 `exp(-i(j_ℝ θ~_μ)_ℂ)`（Lean では `checkPhase`）とする。
`W̌_μ = Σ_{j=1}^{M_col} (c_j W_{j_ℤ})` の人手の添字 `j ∈ {1,…,M_col}` は、Lean の `j : Fin (r + 1)` の
`(j : ℕ) + 1` にあたる（`DefinitionHalfIntegerModes.lean` の site 添字の規約）。したがって `W j` は人手の
`W_{((j:ℕ)+1)_ℤ}` にあたる。仮定 `hW` は人手の (1)（`epsilon_anticommutes_with_jordan_wigner_Z`・`_Y`）である。
calc の 7 段は人手の鎖の 2〜8 行目と同じ順に並ぶ。必要十分版 `NecSuf.anticomm_sum_smul` も同じ 7 段である。 -/
theorem epsilon_anticomm_phase_sum (r : ℕ) (c : Fin (r + 1) → ℂ) (W : Fin (r + 1) → TensorPow (r + 1))
    (hW : ∀ j, epsilon (r + 1) * W j = -(W j * epsilon (r + 1))) :
    epsilon (r + 1) * (∑ j, c j • W j) = -((∑ j, c j • W j) * epsilon (r + 1)) := by
  calc epsilon (r + 1) * (∑ j, c j • W j)
      = ∑ j, epsilon (r + 1) * (c j • W j) := mul_finite_sum_tensorPow r _ _
                                                        -- `finite_sum_of_matrices_distributes_in_right_factor`（`C → ε`）
    _ = ∑ j, c j • (epsilon (r + 1) * W j) :=
        Finset.sum_congr rfl fun j _ => mul_smul_matrix_tensorPow _ _ _
                                                        -- `scalar_multiple_factors_out_of_right_factor` を各項へ同時適用
    _ = ∑ j, c j • (-(W j * epsilon (r + 1))) :=
        Finset.sum_congr rfl fun j _ => by rw [hW j]
                                                        -- (1) を `j → j_ℤ` で各項へ同時適用
    _ = ∑ j, -(c j • (W j * epsilon (r + 1))) :=
        Finset.sum_congr rfl fun j _ => smul_neg_matrix_tensorPow _ _
                                                        -- `scalar_multiple_of_negated_matrix` を各項へ同時適用
    _ = ∑ j, -((c j • W j) * epsilon (r + 1)) :=
        Finset.sum_congr rfl fun j _ => by rw [smul_mul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_left_factor` を各項へ同時適用
    _ = -∑ j, (c j • W j) * epsilon (r + 1) := neg_finite_sum_tensorPow r _
                                                        -- `finite_sum_of_negated_matrices`
    _ = -((∑ j, c j • W j) * epsilon (r + 1)) := by rw [finite_sum_mul_tensorPow]
                                                        -- `finite_sum_of_matrices_distributes_in_left_factor`（`C → ε`）

/-- **人手証明 (2)**: `ε Ž_μ = -Ž_μ ε`（`M_col = r + 1`）。
calc の 1 段目と 3 段目は人手の鎖の 1 行目と 9 行目（`Ž_μ` の定義 `def_half_integer_checkZ`）、
2 段目は人手の 2〜8 行目（`epsilon_anticomm_phase_sum`）である。 -/
theorem epsilon_anticomm_checkZ_succ (r : ℕ) (μ : ℤ) :
    epsilon (r + 1) * checkZ (r + 1) μ = -(checkZ (r + 1) μ * epsilon (r + 1)) := by
  calc epsilon (r + 1) * checkZ (r + 1) μ
      = epsilon (r + 1) * (∑ j : Fin (r + 1), checkPhase (r + 1) (((j : ℕ) : ℤ) + 1) μ • Z j) := rfl
                                                        -- `Ž_μ` の定義（`def_half_integer_checkZ`）
    _ = -((∑ j : Fin (r + 1), checkPhase (r + 1) (((j : ℕ) : ℤ) + 1) μ • Z j) * epsilon (r + 1)) :=
        epsilon_anticomm_phase_sum r _ _ fun j => epsilon_anticomm_Z j
                                                        -- 人手の鎖の 2〜8 行目
    _ = -(checkZ (r + 1) μ * epsilon (r + 1)) := rfl
                                                        -- `Ž_μ` の定義（`def_half_integer_checkZ`）

/-- **人手証明 (2)**: `ε Y̌_μ = -Y̌_μ ε`（`M_col = r + 1`。段の対応は `epsilon_anticomm_checkZ_succ` と同じ）。 -/
theorem epsilon_anticomm_checkY_succ (r : ℕ) (μ : ℤ) :
    epsilon (r + 1) * checkY (r + 1) μ = -(checkY (r + 1) μ * epsilon (r + 1)) := by
  calc epsilon (r + 1) * checkY (r + 1) μ
      = epsilon (r + 1) * (∑ j : Fin (r + 1), checkPhase (r + 1) (((j : ℕ) : ℤ) + 1) μ • Y j) := rfl
                                                        -- `Y̌_μ` の定義（`def_half_integer_checkY`）
    _ = -((∑ j : Fin (r + 1), checkPhase (r + 1) (((j : ℕ) : ℤ) + 1) μ • Y j) * epsilon (r + 1)) :=
        epsilon_anticomm_phase_sum r _ _ fun j => epsilon_anticomm_Y j
                                                        -- 人手の鎖の 2〜8 行目
    _ = -(checkY (r + 1) μ * epsilon (r + 1)) := rfl
                                                        -- `Y̌_μ` の定義（`def_half_integer_checkY`）

/-- **人手証明 (2)**: `ε Ž_μ = -Ž_μ ε`。

人手の主張は `M_col ≥ 2` で、それは `M = r + 1` の場合 `epsilon_anticomm_checkZ_succ` である。
`M = 0` は人手の主張の外で、`Ž_μ` が空の和 `0` なので両辺とも `0` になる（下流の `CheckFermi M` が
`M` を限らないので場合を埋めている）。 -/
theorem epsilon_anticomm_checkZ (M : ℕ) (μ : ℤ) :
    epsilon M * checkZ M μ = -(checkZ M μ * epsilon M) := by
  cases M with
  | zero => simp [checkZ]
  | succ r => exact epsilon_anticomm_checkZ_succ r μ

/-- **人手証明 (2)**: `ε Y̌_μ = -Y̌_μ ε`（場合の分け方は `epsilon_anticomm_checkZ` と同じ）。 -/
theorem epsilon_anticomm_checkY (M : ℕ) (μ : ℤ) :
    epsilon M * checkY M μ = -(checkY M μ * epsilon M) := by
  cases M with
  | zero => simp [checkY]
  | succ r => exact epsilon_anticomm_checkY_succ r μ

/-- 人手 (2) が必要十分版 `Ising2D.NecSuf.anticomm_sum_smul` の特殊化として得られること
（`Ž_μ` は `Z_j` の ℂ 係数有限和である）。 -/
theorem epsilon_anticomm_checkZ_of_necSuf (M : ℕ) (μ : ℤ) :
    epsilon M * checkZ M μ = -(checkZ M μ * epsilon M) := by
  rw [checkZ]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Z j) Finset.univ _

/-- 人手 (2) の `Y̌_μ` の側が必要十分版の特殊化として得られること。 -/
theorem epsilon_anticomm_checkY_of_necSuf (M : ℕ) (μ : ℤ) :
    epsilon M * checkY M μ = -(checkY M μ * epsilon M) := by
  rw [checkY]
  exact NecSuf.anticomm_sum_smul (𝕜 := ℂ) (fun j => epsilon_anticomm_Y j) Finset.univ _

/-- **人手証明 (3) の鎖**。`(Ψ, p, q)` を `def_check_fermi` の二つの組
`(ψ̌_μ^†, −r/(2√M_col b), 1/(2√M_col))`・`(ψ̌_μ, +r/(2√M_col b), 1/(2√M_col))` のどちらかとし、
`Ψ = p Ž_μ + q Y̌_μ` とする。本補題の `X`・`Y` は人手の `Ž_μ`・`Y̌_μ`、仮定 `hX`・`hY` は人手の (2) である。
calc の 7 段は人手の 9 行の鎖の 2〜8 行目と同じ順に並ぶ（1 行目と 9 行目は `Ψ` の定義で、
`epsilon_anticomm_checkPsiDag`・`epsilon_anticomm_checkPsi` が受け持つ）。
必要十分版 `NecSuf.anticomm_add_smul` も同じ 7 段である。 -/
theorem epsilon_anticomm_two_term (p q : ℂ) (X Y : TensorPow M)
    (hX : epsilon M * X = -(X * epsilon M)) (hY : epsilon M * Y = -(Y * epsilon M)) :
    epsilon M * (p • X + q • Y) = -((p • X + q • Y) * epsilon M) := by
  calc epsilon M * (p • X + q • Y)
      = epsilon M * (p • X) + epsilon M * (q • Y) := mul_add_matrix_tensorPow _ _ _
                                                        -- `mat_mult_distributes_over_sum_in_right_factor`
    _ = p • (epsilon M * X) + q • (epsilon M * Y) := by
        rw [mul_smul_matrix_tensorPow, mul_smul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_right_factor` を 2 項へ同時適用
    _ = p • (-(X * epsilon M)) + q • (-(Y * epsilon M)) := by rw [hX, hY]
                                                        -- (2) を 2 項へ同時適用
    _ = (-(p • (X * epsilon M))) + (-(q • (Y * epsilon M))) := by
        rw [smul_neg_matrix_tensorPow, smul_neg_matrix_tensorPow]
                                                        -- `scalar_multiple_of_negated_matrix` を 2 項へ同時適用
    _ = (-((p • X) * epsilon M)) + (-((q • Y) * epsilon M)) := by
        rw [smul_mul_matrix_tensorPow, smul_mul_matrix_tensorPow]
                                                        -- `scalar_multiple_factors_out_of_left_factor` を 2 項へ同時適用
    _ = -((p • X) * epsilon M + (q • Y) * epsilon M) := (neg_add_tensorPow _ _).symm
                                                        -- `negation_distributes_over_matrix_sum` を右辺から左辺へ
    _ = -((p • X + q • Y) * epsilon M) := by rw [add_mul_matrix_tensorPow]
                                                        -- `mat_mult_distributes_over_sum_in_left_factor`

/-- **人手証明 (3)**: `ε ψ̌_μ^† = −ψ̌_μ^† ε`。
calc の 1 段目と 3 段目は人手の鎖の 1 行目と 9 行目（`ψ̌_μ^†` の定義 `def_check_fermi`。
Lean では `checkPsiDag`、係数は `p = checkP`、`q = checkQ`）、2 段目は人手の 2〜8 行目
（`epsilon_anticomm_two_term`、仮定は (2) の `epsilon_anticomm_checkZ`・`epsilon_anticomm_checkY`）である。 -/
theorem epsilon_anticomm_checkPsiDag (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsiDag K M μ = -(checkPsiDag K M μ * epsilon M) := by
  calc epsilon M * checkPsiDag K M μ
      = epsilon M * (checkP K M μ • checkZ M μ + checkQ M • checkY M μ) := rfl
                                                        -- `def_check_fermi`
    _ = -((checkP K M μ • checkZ M μ + checkQ M • checkY M μ) * epsilon M) :=
        epsilon_anticomm_two_term _ _ _ _ (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ)
                                                        -- 人手の鎖の 2〜8 行目
    _ = -(checkPsiDag K M μ * epsilon M) := rfl
                                                        -- `def_check_fermi`

/-- **人手証明 (3)**: `ε ψ̌_μ = −ψ̌_μ ε`（係数は `p = −checkP`、`q = checkQ`。段の対応は
`epsilon_anticomm_checkPsiDag` と同じ）。 -/
theorem epsilon_anticomm_checkPsi (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsi K M μ = -(checkPsi K M μ * epsilon M) := by
  calc epsilon M * checkPsi K M μ
      = epsilon M * ((-checkP K M μ) • checkZ M μ + checkQ M • checkY M μ) := rfl
                                                        -- `def_check_fermi`
    _ = -(((-checkP K M μ) • checkZ M μ + checkQ M • checkY M μ) * epsilon M) :=
        epsilon_anticomm_two_term _ _ _ _ (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ)
                                                        -- 人手の鎖の 2〜8 行目
    _ = -(checkPsi K M μ * epsilon M) := rfl
                                                        -- `def_check_fermi`

/-- 人手 (3) の `ψ̌_μ^†` の側が必要十分版 `Ising2D.NecSuf.anticomm_add_smul` の特殊化として得られること。 -/
theorem epsilon_anticomm_checkPsiDag_of_necSuf (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsiDag K M μ = -(checkPsiDag K M μ * epsilon M) :=
  NecSuf.anticomm_add_smul (𝕜 := ℂ) (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ) _ _

/-- 人手 (3) の `ψ̌_μ` の側が必要十分版の特殊化として得られること。 -/
theorem epsilon_anticomm_checkPsi_of_necSuf (K : IsingConst) (M : ℕ) (μ : ℤ) :
    epsilon M * checkPsi K M μ = -(checkPsi K M μ * epsilon M) :=
  NecSuf.anticomm_add_smul (𝕜 := ℂ) (epsilon_anticomm_checkZ M μ) (epsilon_anticomm_checkY M μ) _ _

/-- 原文 `def_check_fermi` の「`ψ̌_μ^†`・`ψ̌_μ` は `Ž_μ, Y̌_μ` の ℂ 係数 1 次結合」。
`CheckFermi`（`CheckFermiInput.lean`）が生成・消滅演算子を受け取る形で、具体的な `checkPsiDag`・`checkPsi` は
これを満たす（`ClaimCheckFermiFromDiagonalizationAndExponentialForm.lean`）。 -/
def IsCheckMode (x : TensorPow M) : Prop :=
  ∃ (ν : ℤ) (p q : ℂ), x = p • checkZ M ν + q • checkY M ν

/-- **人手証明 (3)** を `IsCheckMode` の元へ: `Ž, Y̌` の 1 次結合はすべて `ε` と反交換する
（人手の鎖の 2〜8 行目 `epsilon_anticomm_two_term` をそのまま使う）。 -/
theorem epsilon_anticomm_of_isCheckMode {x : TensorPow M} (h : IsCheckMode x) :
    epsilon M * x = -(x * epsilon M) := by
  obtain ⟨ν, p, q, rfl⟩ := h
  exact epsilon_anticomm_two_term p q _ _ (epsilon_anticomm_checkZ M ν) (epsilon_anticomm_checkY M ν)

end Ising2D
