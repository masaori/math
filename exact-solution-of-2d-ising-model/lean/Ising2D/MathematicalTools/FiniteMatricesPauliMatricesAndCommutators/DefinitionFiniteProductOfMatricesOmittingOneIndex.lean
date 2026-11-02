/-
# 一つの添字を除いた行列の有限積と、有限積の一つの因子を末尾へ寄せること（**具体版**）

対応する人手証明のラベル: `def_finite_product_of_matrices_omitting_one_index`・`moving_one_factor_of_finite_product_to_the_end`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_finite_product_of_matrices_omitting_one_index`・
`linear_space_general_claim_moving_one_factor_of_finite_product_to_the_end`）。

**必要十分版**: `Ising2D/NecSuf/FiniteProductOmittingOneIndex.lean`。具体版をその系として導くのは
`DefinitionFiniteProductOfMatricesOmittingOneIndexFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥2}` が Lean の `r + 2` に当たり、人手の `A_j`・`ν` が Lean の `A (j - 1)`・`ν - 1` である。
  人手の右辺の有限積 `∏_{j=1}^{r-1}` は Lean の `finiteMatrixProduct r`（因子 `r + 1` 個）である。
* 人手の `s_{r,ν} : {1,…,r−1} → {1,…,r}`（`j < ν` なら `j`、`ν ≤ j` なら `j + 1`）は `Fin.succAbove ν` で、
  二つの場合は `Fin.succAbove_of_castSucc_lt`・`Fin.succAbove_of_le_castSucc`（`Fin.succAbove` の定義の `if` の二つの枝）である。
* 主張の帰納法の鎖（`r = 2` の `ν = 1` の 6 行と `ν = 2` の 5 行、`r → r + 1` の `ν = r + 1` の 3 行と `ν ≤ r` の 10 行）は、
  `moving_one_factor_of_finite_product_to_the_end_two_first`・`moving_one_factor_of_finite_product_to_the_end_two_second`・
  `moving_one_factor_of_finite_product_to_the_end` の 2 つの場合の `calc` と 1 対 1 である。
  人手の `s_{r+1,ν}(j) = s_{r,ν}(j)`（`j ≤ r − 1`。同じ式で定まる）は、Lean では添字の型が `Fin (r + 1)` から `Fin (r + 2)` へ
  変わるので `Fin.castSucc_succAbove_castSucc` で読み替える。人手の `s_{r+1,ν}(r) = r + 1` は `Fin.succAbove_of_le_castSucc` と `Fin.succ_last`。
  `mat_mult_associative` は Lean の具体版が無く、mathlib の `Matrix.mul_assoc` を 1 回ずつ使う（ほかのファイルと同じ扱い）。
* 人手の帰納法は `ν` について場合を分ける（`ν = r + 1` と `ν ≤ r`）。Lean はそれを `Fin.lastCases` で分ける。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.DefinitionFiniteProductOfMatrices

namespace Ising2D

open Matrix

/-- **`def_finite_product_of_matrices_omitting_one_index`**: `ν` 以外の `r + 1` 個の因子を、添字の小さい順に左から掛ける
（人手の `r` は Lean の `r + 2`、人手の `s_{r,ν}` は `Fin.succAbove ν`）。 -/
def finiteMatrixProductOmitting {n : ℕ} (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → Matrix (Fin n) (Fin n) ℂ) :
    Matrix (Fin n) (Fin n) ℂ :=
  finiteMatrixProduct r (fun j => A (ν.succAbove j))

/-- `def_finite_product_of_matrices_omitting_one_index` の式: `∏_{j=1, j≠ν}^{r} A_j := ∏_{j=1}^{r-1} A_{s_{r,ν}(j)}`。 -/
theorem finiteMatrixProductOmitting_def {n : ℕ} (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → Matrix (Fin n) (Fin n) ℂ) :
    finiteMatrixProductOmitting r ν A = finiteMatrixProduct r (fun j => A (ν.succAbove j)) := rfl

/-- **`moving_one_factor_of_finite_product_to_the_end`** の `r = 2`、`ν = 1` の場合の 6 行（人手の `A_1, A_2` は Lean の `A 0, A 1`）。 -/
theorem moving_one_factor_of_finite_product_to_the_end_two_first {n : ℕ} (A : Fin 2 → Matrix (Fin n) (Fin n) ℂ)
    (h : A 0 * A 1 = A 1 * A 0) :
    finiteMatrixProduct 1 A = finiteMatrixProductOmitting 0 0 A * A 0 :=
  calc finiteMatrixProduct 1 A
      = finiteMatrixProduct 0 (fun j => A (Fin.castSucc j)) * A (Fin.last 1) :=
        finiteMatrixProduct_succ 0 A                                             -- `def_finite_product_of_matrices`
    _ = A 0 * A 1 := by rw [finiteMatrixProduct_zero]; rfl                       -- `def_finite_product_of_matrices`
    _ = A 1 * A 0 := h                                                           -- 仮定（`j → 2`）
    _ = A ((0 : Fin 2).succAbove 0) * A 0 := by
        rw [Fin.succAbove_of_le_castSucc (0 : Fin 2) 0 (Fin.zero_le _)]; rfl          -- `s_{2,1}(1) = 2`（`s` の定義の `ν ≤ j` の場合）
    _ = finiteMatrixProduct 0 (fun j => A ((0 : Fin 2).succAbove j)) * A 0 := by
        rw [finiteMatrixProduct_zero]                                            -- `def_finite_product_of_matrices` を右辺から左辺へ
    _ = finiteMatrixProductOmitting 0 0 A * A 0 := rfl
                                                  -- `def_finite_product_of_matrices_omitting_one_index` を右辺から左辺へ

/-- **`moving_one_factor_of_finite_product_to_the_end`** の `r = 2`、`ν = 2` の場合の 5 行（人手の `A_1, A_2` は Lean の `A 0, A 1`）。 -/
theorem moving_one_factor_of_finite_product_to_the_end_two_second {n : ℕ} (A : Fin 2 → Matrix (Fin n) (Fin n) ℂ) :
    finiteMatrixProduct 1 A = finiteMatrixProductOmitting 0 1 A * A 1 :=
  calc finiteMatrixProduct 1 A
      = finiteMatrixProduct 0 (fun j => A (Fin.castSucc j)) * A (Fin.last 1) :=
        finiteMatrixProduct_succ 0 A                                             -- `def_finite_product_of_matrices`
    _ = A 0 * A 1 := by rw [finiteMatrixProduct_zero]; rfl                       -- `def_finite_product_of_matrices`
    _ = A ((1 : Fin 2).succAbove 0) * A 1 := by
        rw [Fin.succAbove_of_castSucc_lt (1 : Fin 2) 0 (by decide)]; rfl         -- `s_{2,2}(1) = 1`（`s` の定義の `j < ν` の場合）
    _ = finiteMatrixProduct 0 (fun j => A ((1 : Fin 2).succAbove j)) * A 1 := by
        rw [finiteMatrixProduct_zero]                                            -- `def_finite_product_of_matrices` を右辺から左辺へ
    _ = finiteMatrixProductOmitting 0 1 A * A 1 := rfl
                                                  -- `def_finite_product_of_matrices_omitting_one_index` を右辺から左辺へ

/-- **`moving_one_factor_of_finite_product_to_the_end`**: `ν < j` で `A_νA_j = A_jA_ν` なら `∏_{j=1}^{r} A_j = (∏_{j=1, j≠ν}^{r} A_j)A_ν`
（人手の `r` は Lean の `r + 2`）。 -/
theorem moving_one_factor_of_finite_product_to_the_end {n : ℕ} :
    ∀ (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → Matrix (Fin n) (Fin n) ℂ),
      (∀ j, ν < j → A ν * A j = A j * A ν) →
      finiteMatrixProduct (r + 1) A = finiteMatrixProductOmitting r ν A * A ν
  | 0, ν, A, h => by
    match ν with
    | ⟨0, _⟩ => exact moving_one_factor_of_finite_product_to_the_end_two_first A (h 1 (Fin.mk_lt_mk.mpr Nat.zero_lt_one))
    | ⟨1, _⟩ => exact moving_one_factor_of_finite_product_to_the_end_two_second A
  | r + 1, ν, A, h => by
    induction ν using Fin.lastCases with
    | last =>
      -- 人手の `ν = r + 1` の場合の 3 行
      exact calc finiteMatrixProduct (r + 2) A
          = finiteMatrixProduct (r + 1) (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2)) :=
            finiteMatrixProduct_succ (r + 1) A                                   -- `def_finite_product_of_matrices`
        _ = finiteMatrixProduct (r + 1) (fun j => A ((Fin.last (r + 2)).succAbove j)) * A (Fin.last (r + 2)) := by
            congr 2; funext j
            rw [Fin.succAbove_of_castSucc_lt _ _ (Fin.castSucc_lt_last j)]       -- `s_{r+1,r+1}(j) = j`（`s` の定義の `j < ν` の場合）
        _ = finiteMatrixProductOmitting (r + 1) (Fin.last (r + 2)) A * A (Fin.last (r + 2)) := rfl
                                                  -- `def_finite_product_of_matrices_omitting_one_index` を右辺から左辺へ
    | cast ν' =>
      -- 人手の `ν ≤ r` の場合の 10 行。`A_1, …, A_r` は帰納法の仮定の前提を満たす。
      have h' : ∀ j, ν' < j → A (Fin.castSucc ν') * A (Fin.castSucc j) = A (Fin.castSucc j) * A (Fin.castSucc ν') :=
        fun j hj => h (Fin.castSucc j) (Fin.castSucc_lt_castSucc_iff.mpr hj)
      exact calc finiteMatrixProduct (r + 2) A
          = finiteMatrixProduct (r + 1) (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2)) :=
            finiteMatrixProduct_succ (r + 1) A                                   -- `def_finite_product_of_matrices`
        _ = (finiteMatrixProductOmitting r ν' (fun j => A (Fin.castSucc j)) * A (Fin.castSucc ν'))
              * A (Fin.last (r + 2)) := by
            rw [moving_one_factor_of_finite_product_to_the_end r ν' (fun j => A (Fin.castSucc j)) h'] -- 帰納法の仮定
        _ = finiteMatrixProductOmitting r ν' (fun j => A (Fin.castSucc j))
              * (A (Fin.castSucc ν') * A (Fin.last (r + 2))) :=
            Matrix.mul_assoc _ _ _                                               -- `mat_mult_associative`
        _ = finiteMatrixProductOmitting r ν' (fun j => A (Fin.castSucc j))
              * (A (Fin.last (r + 2)) * A (Fin.castSucc ν')) := by
            rw [h (Fin.last (r + 2)) (Fin.castSucc_lt_last ν')]                  -- 仮定（`j → r + 1`）
        _ = (finiteMatrixProductOmitting r ν' (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2)))
              * A (Fin.castSucc ν') :=
            (Matrix.mul_assoc _ _ _).symm                                        -- `mat_mult_associative` を右辺から左辺へ
        _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc (ν'.succAbove j))) * A (Fin.last (r + 2)))
              * A (Fin.castSucc ν') := rfl
                                                  -- `def_finite_product_of_matrices_omitting_one_index`（`r → r`）
        _ = (finiteMatrixProduct r (fun j => A (Fin.castSucc (ν'.succAbove j)))
              * A ((Fin.castSucc ν').succAbove (Fin.last (r + 1)))) * A (Fin.castSucc ν') := by
            rw [Fin.succAbove_of_le_castSucc _ _ (Fin.castSucc_le_castSucc_iff.mpr (Fin.le_last ν')),
              Fin.succ_last]                                                     -- `s_{r+1,ν}(r) = r + 1`（`ν ≤ r`）
        _ = (finiteMatrixProduct r (fun j => A ((Fin.castSucc ν').succAbove (Fin.castSucc j)))
              * A ((Fin.castSucc ν').succAbove (Fin.last (r + 1)))) * A (Fin.castSucc ν') := by
            simp only [Fin.castSucc_succAbove_castSucc]                          -- `s_{r+1,ν}(j) = s_{r,ν}(j)`（`j ≤ r − 1`）
        _ = finiteMatrixProduct (r + 1) (fun j => A ((Fin.castSucc ν').succAbove j)) * A (Fin.castSucc ν') := by
            rw [finiteMatrixProduct_succ]                                        -- `def_finite_product_of_matrices` を右辺から左辺へ
        _ = finiteMatrixProductOmitting (r + 1) (Fin.castSucc ν') A * A (Fin.castSucc ν') := rfl
                                                  -- `def_finite_product_of_matrices_omitting_one_index`（`r → r + 1`）を右辺から左辺へ

end Ising2D
