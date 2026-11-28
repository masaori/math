/-
# 行列の積は列ごとに作用する（`Mat(2^M, ℂ)` の場合、**具体版**）

対応する人手証明のラベル: `mat_columnwise`
（`structured-latex/content/000_calculation_formulae_00_09.ts` の `calc_formulae_004_action_on_matrix_pair`）の、
`m, n, p → 2^M`（行列が `Mat(2^M, ℂ)`、Lean の `TensorPow M`）の場合。
証明の中の `n` は `exists_inverse_of_kronecker_numbering` が与える数で、番号 `ν` が `𝓘_M` から `{1,…,n}` への全単射なので
`2^M` に等しい（等しいことは証明に使わない）。

**必要十分版**: `Ising2D/NecSuf/MatColumnwise.lean` の `NecSuf.mul_cols_eq_cols_mulVec`。
この具体版をその特殊化として得るのは `ClaimMatColumnwiseFromNecSuf.lean` の `mul_columns_tensorPow_of_necSuf`。

## 人手証明との対応

人手の `Mat(2^M, ℂ)` の行列は成分を番号 `1,…,2^M` で持ち、Lean の `TensorPow M` は多重添字 `𝓘_M`（Lean の `Conf M`）で持つ。
`ν^{-1}`（Lean の `σ : Fin n → Conf M`）で番号へ移した成分 `A (σ i) (σ k)` が人手の `A_{ik}` である
（`DefinitionMatrixOperationsOverMultiIndices.lean` の冒頭）。

* 人手の「列に並べた行列 `[b_1 ⋯ b_p]`（第 `k` 列の第 `j` 成分が `(b_k)_j`）」は、仮定 `hB : ∀ j k, B j k = b k j` を満たす行列 `B`、
  右辺の `[Ab_1 ⋯ Ab_p]` は仮定 `hC : ∀ i k, C i k = (A *ᵥ b k) i` を満たす行列 `C` として受ける。仮定は添字 `Conf M` で述べてあり、
  添字を `σ` で番号へ移した `B (σ j) (σ k) = b (σ k) (σ j)`・`C (σ i) (σ k) = (A *ᵥ b (σ k)) (σ i)` が本文の番号の添字の定め方である。
  二つの行列を `Matrix.of` で主張に書かないのは、記号 `Matrix.of` が本文の定義の一覧
  （`lean/mathlib-symbols-defined-or-declared-in-text.txt`）に無いためである。仮定は「列に並べた行列の成分の定め方」そのものである。
* 人手の「各成分が一致することを示せばよい」は、番号で読んだ全ての成分の等号にすること
  （`tensorPow_entries_by_kronecker_numbering`）である。
* 人手の成分の鎖 4 行は `mul_columns_tensorPow` の `calc` の 4 段と 1 対 1 である（1 行目と 3 行目の `mat_mult` は
  `tensorPow_mul_apply_eq_mat_mult`・`tensorPow_mulVec_apply_eq_mat_mult`、2 行目と 4 行目の「列に並べた行列の成分の定め方」は
  仮定 `hB`・`hC`）。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixOperationsOverMultiIndices

namespace Ising2D

open Matrix

/-- **`mat_columnwise`**（`Mat(2^M, ℂ)`）: `A[b_1 ⋯ b_p] = [Ab_1 ⋯ Ab_p]`（`A ∈ TensorPow M`、`b_k ∈ ℂ^{2^M}`。
`B = [b_1 ⋯ b_p]`、`C = [Ab_1 ⋯ Ab_p]` は成分の定め方 `hB`・`hC` で受ける）。 -/
theorem mul_columns_tensorPow {M : ℕ} (A B C : TensorPow M) (b : Conf M → Conf M → ℂ)
    (hB : ∀ j k, B j k = b k j) (hC : ∀ i k, C i k = (A *ᵥ b k) i) :
    A * B = C := by
  obtain ⟨n, σ, hord, hσ⟩ := exists_inverse_of_kronecker_numbering M
  -- 各成分が一致することを示せばよい（番号で読んだ成分）
  refine ((tensorPow_entries_by_kronecker_numbering M n hord σ hσ).1 _ _).2 fun i k => ?_
  calc (A * B) (σ i) (σ k)
      = ∑ j : Fin n, A (σ i) (σ j) * B (σ j) (σ k) :=
        tensorPow_mul_apply_eq_mat_mult M n hord σ hσ _ _ i k                     -- `mat_mult`
    _ = ∑ j : Fin n, A (σ i) (σ j) * b (σ k) (σ j) := by
        simp only [hB]                                                            -- 列に並べた行列の成分の定め方
    _ = (A *ᵥ b (σ k)) (σ i) :=
        (tensorPow_mulVec_apply_eq_mat_mult M n hord σ hσ _ _ i).symm            -- `mat_mult` の `p = 1` を `Ab_k` へ
    _ = C (σ i) (σ k) := (hC _ _).symm                                            -- 列に並べた行列の成分の定め方

end Ising2D
