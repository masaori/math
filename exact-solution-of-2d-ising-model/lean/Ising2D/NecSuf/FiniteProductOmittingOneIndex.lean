/-
# 一つの添字を除いた有限積と、有限積の一つの因子を末尾へ寄せること（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionFiniteProductOfMatricesOmittingOneIndex.lean`
（人手 `def_finite_product_of_matrices_omitting_one_index`・`moving_one_factor_of_finite_product_to_the_end`）。
具体版をこのファイルの系として導くのは、同じフォルダの `DefinitionFiniteProductOfMatricesOmittingOneIndexFromNecSuf.lean`。

人手の `r ∈ ℤ_{≥2}` が Lean の `r + 2` に当たり、人手の `A_j`・`ν` が Lean の `A (j - 1)`・`ν - 1` である。
人手の `s_{r,ν}` は `Fin.succAbove ν`。有限積は左から掛ける `finProdLeft`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `moving_one_factor_of_finite_product_to_the_end_two_first`（`r = 2`、`ν = 1` の 6 行） | `finProdLeft_eq_omitting_mul_two_first`（同じ並び） |
| `moving_one_factor_of_finite_product_to_the_end_two_second`（`r = 2`、`ν = 2` の 5 行） | `finProdLeft_eq_omitting_mul_two_second`（同じ並び） |
| `moving_one_factor_of_finite_product_to_the_end` の `ν = r + 1`（3 行）・`ν ≤ r`（10 行） | `finProdLeft_eq_omitting_mul` の 2 つの場合（同じ並び） |

## 何が効いているか / 効いていないか

- 一つの添字を除いた有限積の定義に要るのは二項演算 `*` だけである（`Mul R`）。
- 主張に効くのは積の結合則だけである（`Semigroup R`）。単位元・和・スカラー倍は効いていない（空の積を持たないので単位元が要らない）。
  結合則は、`ν ≤ r` の場合に `A_ν` と `A_{r+1}` を隣り合わせて入れ替える前後の 2 行に使う。`r = 2` と `ν = r + 1` の場合には使わない。
  結合則は外せない。`r = 3`、`ν = 1` で、可換だが結合的でない積（`ℚ` の平均 `a * b := (a + b)/2`）を取ると、可換性の仮定は
  すべて成り立つが、`A_1 = 1`・`A_2 = A_3 = 0` で左辺 `(A_1A_2)A_3 = 1/4`、右辺 `(A_2A_3)A_1 = 1/2` となり一致しない。
-/
import Ising2D.NecSuf.FiniteProductLeft
import Mathlib.Data.Fin.SuccPred

namespace Ising2D.NecSuf

/-- **`def_finite_product_of_matrices_omitting_one_index`** の必要十分版: `ν` 以外の因子を添字の小さい順に左から掛ける。 -/
def finProdLeftOmitting {R : Type*} [Mul R] (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → R) : R :=
  finProdLeft r (fun j => A (ν.succAbove j))

/-- `r = 2`、`ν = 1` の場合。 -/
theorem finProdLeft_eq_omitting_mul_two_first {R : Type*} [Mul R] (A : Fin 2 → R) (h : A 0 * A 1 = A 1 * A 0) :
    finProdLeft 1 A = finProdLeftOmitting 0 0 A * A 0 :=
  calc finProdLeft 1 A
      = finProdLeft 0 (fun j => A (Fin.castSucc j)) * A (Fin.last 1) := finProdLeft_succ 0 A -- 定義
    _ = A 0 * A 1 := by rw [finProdLeft_zero]; rfl                                    -- 定義
    _ = A 1 * A 0 := h                                                                -- 仮定（`j → 2`）
    _ = A ((0 : Fin 2).succAbove 0) * A 0 := by
        rw [Fin.succAbove_of_le_castSucc (0 : Fin 2) 0 (Fin.zero_le _)]; rfl               -- `s_{2,1}(1) = 2`
    _ = finProdLeft 0 (fun j => A ((0 : Fin 2).succAbove j)) * A 0 := by rw [finProdLeft_zero] -- 定義を右辺から左辺へ
    _ = finProdLeftOmitting 0 0 A * A 0 := rfl                                        -- 定義を右辺から左辺へ

/-- `r = 2`、`ν = 2` の場合。 -/
theorem finProdLeft_eq_omitting_mul_two_second {R : Type*} [Mul R] (A : Fin 2 → R) :
    finProdLeft 1 A = finProdLeftOmitting 0 1 A * A 1 :=
  calc finProdLeft 1 A
      = finProdLeft 0 (fun j => A (Fin.castSucc j)) * A (Fin.last 1) := finProdLeft_succ 0 A -- 定義
    _ = A 0 * A 1 := by rw [finProdLeft_zero]; rfl                                    -- 定義
    _ = A ((1 : Fin 2).succAbove 0) * A 1 := by
        rw [Fin.succAbove_of_castSucc_lt (1 : Fin 2) 0 (by decide)]; rfl              -- `s_{2,2}(1) = 1`
    _ = finProdLeft 0 (fun j => A ((1 : Fin 2).succAbove j)) * A 1 := by rw [finProdLeft_zero] -- 定義を右辺から左辺へ
    _ = finProdLeftOmitting 0 1 A * A 1 := rfl                                        -- 定義を右辺から左辺へ

/-- **`moving_one_factor_of_finite_product_to_the_end`** の必要十分版: `ν < j` で `A_νA_j = A_jA_ν` なら
`∏_{j} A_j = (∏_{j≠ν} A_j)A_ν`。 -/
theorem finProdLeft_eq_omitting_mul {R : Type*} [Semigroup R] :
    ∀ (r : ℕ) (ν : Fin (r + 2)) (A : Fin (r + 2) → R), (∀ j, ν < j → A ν * A j = A j * A ν) →
      finProdLeft (r + 1) A = finProdLeftOmitting r ν A * A ν
  | 0, ν, A, h => by
    match ν with
    | ⟨0, _⟩ => exact finProdLeft_eq_omitting_mul_two_first A (h 1 (Fin.mk_lt_mk.mpr Nat.zero_lt_one))
    | ⟨1, _⟩ => exact finProdLeft_eq_omitting_mul_two_second A
  | r + 1, ν, A, h => by
    induction ν using Fin.lastCases with
    | last =>
      exact calc finProdLeft (r + 2) A
          = finProdLeft (r + 1) (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2)) :=
            finProdLeft_succ (r + 1) A                                                -- 定義
        _ = finProdLeft (r + 1) (fun j => A ((Fin.last (r + 2)).succAbove j)) * A (Fin.last (r + 2)) := by
            congr 2; funext j
            rw [Fin.succAbove_of_castSucc_lt _ _ (Fin.castSucc_lt_last j)]            -- `s_{r+1,r+1}(j) = j`
        _ = finProdLeftOmitting (r + 1) (Fin.last (r + 2)) A * A (Fin.last (r + 2)) := rfl -- 定義を右辺から左辺へ
    | cast ν' =>
      have h' : ∀ j, ν' < j → A (Fin.castSucc ν') * A (Fin.castSucc j) = A (Fin.castSucc j) * A (Fin.castSucc ν') :=
        fun j hj => h (Fin.castSucc j) (Fin.castSucc_lt_castSucc_iff.mpr hj)
      exact calc finProdLeft (r + 2) A
          = finProdLeft (r + 1) (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2)) :=
            finProdLeft_succ (r + 1) A                                                -- 定義
        _ = (finProdLeftOmitting r ν' (fun j => A (Fin.castSucc j)) * A (Fin.castSucc ν')) * A (Fin.last (r + 2)) := by
            rw [finProdLeft_eq_omitting_mul r ν' (fun j => A (Fin.castSucc j)) h']    -- 帰納法の仮定
        _ = finProdLeftOmitting r ν' (fun j => A (Fin.castSucc j)) * (A (Fin.castSucc ν') * A (Fin.last (r + 2))) :=
            mul_assoc _ _ _                                                           -- 結合則
        _ = finProdLeftOmitting r ν' (fun j => A (Fin.castSucc j)) * (A (Fin.last (r + 2)) * A (Fin.castSucc ν')) := by
            rw [h (Fin.last (r + 2)) (Fin.castSucc_lt_last ν')]                       -- 仮定（`j → r + 1`）
        _ = (finProdLeftOmitting r ν' (fun j => A (Fin.castSucc j)) * A (Fin.last (r + 2))) * A (Fin.castSucc ν') :=
            (mul_assoc _ _ _).symm                                                    -- 結合則を右辺から左辺へ
        _ = (finProdLeft r (fun j => A (Fin.castSucc (ν'.succAbove j))) * A (Fin.last (r + 2))) * A (Fin.castSucc ν') :=
            rfl                                                                       -- 定義（`r → r`）
        _ = (finProdLeft r (fun j => A (Fin.castSucc (ν'.succAbove j)))
              * A ((Fin.castSucc ν').succAbove (Fin.last (r + 1)))) * A (Fin.castSucc ν') := by
            rw [Fin.succAbove_of_le_castSucc _ _ (Fin.castSucc_le_castSucc_iff.mpr (Fin.le_last ν')),
              Fin.succ_last]                                                          -- `s_{r+1,ν}(r) = r + 1`
        _ = (finProdLeft r (fun j => A ((Fin.castSucc ν').succAbove (Fin.castSucc j)))
              * A ((Fin.castSucc ν').succAbove (Fin.last (r + 1)))) * A (Fin.castSucc ν') := by
            simp only [Fin.castSucc_succAbove_castSucc]                               -- `s_{r+1,ν}(j) = s_{r,ν}(j)`
        _ = finProdLeft (r + 1) (fun j => A ((Fin.castSucc ν').succAbove j)) * A (Fin.castSucc ν') := by
            rw [finProdLeft_succ]                                                     -- 定義を右辺から左辺へ
        _ = finProdLeftOmitting (r + 1) (Fin.castSucc ν') A * A (Fin.castSucc ν') := rfl -- 定義を右辺から左辺へ

end Ising2D.NecSuf
