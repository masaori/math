/-
# `‖ε_ℝu‖ = ‖u‖`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_claim_epsilon_real_preserves_norm`（ラベル **`epsilon_real_preserves_norm`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 準備: `ord^{-1}(k)`（`row_configuration_numbering_bijective`）と `ord(ord^{-1}(k)) = k`・`ord^{-1}(ord(t)) = t` | `(configBasisIso _).symm k` と `Equiv.apply_symm_apply`・`Equiv.symm_apply_apply` |
| 準備: `χ(k) := ord(-ord^{-1}(k))` | `spinFlipIndex n k` |
| `χ(χ(k)) = k` の 5 行の鎖（`χ` の定義 2 回、`ord^{-1}(ord(t)) = t`、`negated_row_configuration_is_involutive`、`ord(ord^{-1}(k)) = k`） | `spinFlipIndex_spinFlipIndex` の `calc` の 5 段 |
| `χ` は単射・全射なので全単射 | `spinFlipIndex_bijective`（単射の段 `k = χ(χ(k)) = χ(χ(k')) = k'`、全射の段 `χ(χ(k)) = k`） |
| `(ε_ℝu)_k = u_{χ(k)}` の 3 行の鎖 | `epsilon_real_mulVec_eq_spinFlipIndex` の `calc` の 3 段 |
| 主張の 4 行の鎖（`def_matrix_norm`、項ごとの `(ε_ℝu)_k = u_{χ(k)}`、`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`、`def_matrix_norm`） | `epsilon_real_preserves_norm` の `calc` の 4 段 |

- 人手の `ord(s)` で番号を付けた成分は、Lean では添字 `configBasisIso M s : Conf M` そのものである
  （`ClaimEpsilonRealPermutesEntriesBySpinFlip.lean` 冒頭と同じ扱い）。人手の `M_col` は `n + 1`、`ε_ℝ` は `epsilonReal n`、
  `-s` は `negSpinConf s`、人手の `negated_row_configuration_is_involutive` は `negSpinConf_negSpinConf` である。
- 人手の `def_matrix_norm`（`K = ℝ`）の `‖w‖ = √(Σ|w_k|^2)` は、Lean の `vecNorm w = √(w ⬝ᵥ w)` を `vecNormSq_eq_sum` で `√(Σ w_k^2)` に開き、
  `sq_abs` で `√(Σ|w_k|^2)` に書いたものである（`sq_abs` は人手の行ではなく、二つの書き方の差を埋める段。
  `DefinitionRayleighSup.lean` の `abs_component_le_one_of_unit` と同じ）。
- 人手は付け替えの写像を `χ` と書く（`π` は同じ章で円周率、`κ` は論文の別の章で定数と添字に使うため）。引く主張 `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing` の `π` に `χ` を代入する。
- 人手の和の添字は `{1, …, d}` で、Lean の和の添字は `Conf (n + 1)` である。付け替えの段は、添字が有限型の和の系
  `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing_fintype` で当てる。

必要十分版は置かない。主張は、番号付けの全単射性と `epsilon_real_permutes_entries_by_spin_flip`・
`finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`（必要十分版 `NecSuf/FiniteSumReindexedByBijection.lean`）を
1 回ずつ当てることに尽きる（置換行列の一般の性質は `Ising2D/NecSuf/PermMatrix.lean` にある）。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealPermutesEntriesBySpinFlip
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.RealMatrixBilinearFormAndNorm
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumOfRealNumbersReindexedByBijection

namespace Ising2D

open Matrix

/-- 人手の証明の準備の `χ(k) := ord(-ord^{-1}(k))`（人手の `M_col` は `n + 1`）。 -/
noncomputable def spinFlipIndex (n : ℕ) (k : Conf (n + 1)) : Conf (n + 1) :=
  configBasisIso (n + 1) (negSpinConf ((configBasisIso (n + 1)).symm k))

/-- 人手の準備の `χ(χ(k)) = k`（5 行の鎖）。 -/
theorem spinFlipIndex_spinFlipIndex (n : ℕ) (k : Conf (n + 1)) :
    spinFlipIndex n (spinFlipIndex n k) = k := by
  calc spinFlipIndex n (spinFlipIndex n k)
      = configBasisIso (n + 1) (negSpinConf ((configBasisIso (n + 1)).symm (spinFlipIndex n k))) :=
        rfl                                                         -- `χ` の定義（`k → χ(k)`）
    _ = configBasisIso (n + 1) (negSpinConf ((configBasisIso (n + 1)).symm
          (configBasisIso (n + 1) (negSpinConf ((configBasisIso (n + 1)).symm k))))) :=
        rfl                                                         -- `χ` の定義
    _ = configBasisIso (n + 1) (negSpinConf (negSpinConf ((configBasisIso (n + 1)).symm k))) := by
        rw [Equiv.symm_apply_apply]                                 -- `ord^{-1}(ord(t)) = t`（`t → -ord^{-1}(k)`）
    _ = configBasisIso (n + 1) ((configBasisIso (n + 1)).symm k) := by
        rw [negSpinConf_negSpinConf]                                -- `negated_row_configuration_is_involutive`（`s → ord^{-1}(k)`）
    _ = k := Equiv.apply_symm_apply _ k                             -- `ord(ord^{-1}(k)) = k`

/-- 人手の準備の「`χ` は全単射」（`χ(χ(k)) = k` から単射と全射）。 -/
theorem spinFlipIndex_bijective (n : ℕ) : Function.Bijective (spinFlipIndex n) := by
  constructor
  · intro k k' h                                                    -- 単射: `χ(k) = χ(k')` なら（人手の 3 行の鎖）
    calc k = spinFlipIndex n (spinFlipIndex n k) :=
          (spinFlipIndex_spinFlipIndex n k).symm                    -- `χ(χ(k)) = k` を右辺から左辺へ
      _ = spinFlipIndex n (spinFlipIndex n k') := by rw [h]         -- `χ(k) = χ(k')`
      _ = k' := spinFlipIndex_spinFlipIndex n k'                    -- `χ(χ(k)) = k`（`k → k'`）
  · intro k                                                         -- 全射: `χ(χ(k)) = k` なので `k` は `χ(k)` の像（人手の 1 行の鎖）
    exact ⟨spinFlipIndex n k, spinFlipIndex_spinFlipIndex n k⟩

/-- 人手の準備の `(ε_ℝu)_k = u_{χ(k)}`（3 行の鎖）。 -/
theorem epsilon_real_mulVec_eq_spinFlipIndex (n : ℕ) (u : Conf (n + 1) → ℝ) (k : Conf (n + 1)) :
    (epsilonReal n *ᵥ u) k = u (spinFlipIndex n k) := by
  calc (epsilonReal n *ᵥ u) k
      = (epsilonReal n *ᵥ u) (configBasisIso (n + 1) ((configBasisIso (n + 1)).symm k)) := by
        rw [Equiv.apply_symm_apply]                                 -- `ord(ord^{-1}(k)) = k` を右辺から左辺へ
    _ = u (configBasisIso (n + 1) (negSpinConf ((configBasisIso (n + 1)).symm k))) :=
        epsilon_real_permutes_entries_by_spin_flip n u _            -- `epsilon_real_permutes_entries_by_spin_flip`（`s → ord^{-1}(k)`）
    _ = u (spinFlipIndex n k) := rfl                                -- `χ` の定義を右辺から左辺へ

/-- **人手 `epsilon_real_preserves_norm`**: `‖ε_ℝu‖ = ‖u‖`（人手の `M_col` は `n + 1`。ノルムは `def_matrix_norm` の `K = ℝ`）。 -/
theorem epsilon_real_preserves_norm (n : ℕ) (u : Conf (n + 1) → ℝ) :
    vecNorm (epsilonReal n *ᵥ u) = vecNorm u := by
  calc vecNorm (epsilonReal n *ᵥ u)
      = Real.sqrt (∑ k, |(epsilonReal n *ᵥ u) k| ^ 2) := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [sq_abs]                                          -- `def_matrix_norm`（`w → ε_ℝu`）。`sq_abs` は書き方の差を埋める段
    _ = Real.sqrt (∑ k, |u (spinFlipIndex n k)| ^ 2) := by
        simp only [epsilon_real_mulVec_eq_spinFlipIndex]            -- `(ε_ℝu)_k = u_{χ(k)}` を `d` 個の項へ同時に
    _ = Real.sqrt (∑ k, |u k| ^ 2) := by
        rw [finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing_fintype
          (fun k => |u k| ^ 2) (spinFlipIndex n) (spinFlipIndex_bijective n)]
                                                                    -- `finite_sum_of_real_numbers_is_invariant_under_bijective_reindexing`（`a_j → |u_j|^2`）
    _ = vecNorm u := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [sq_abs]                                          -- `def_matrix_norm`（`w → u`）を右辺から左辺へ

end Ising2D
