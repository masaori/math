/-
# `{0,1}^r` の上の和、その加法を保つ写像による像、二項の和の有限積の展開（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionSumOverBinaryWords.lean`
（人手 `def_sum_over_binary_words`・`sum_over_binary_words_distributes_in_left_factor`）と
`ClaimExpansionOfFiniteProductOfTwoTermSums.lean`（人手 `expansion_of_finite_product_of_two_term_sums`）。
具体版をこのファイルの系として導くのは、同じフォルダの `DefinitionSumOverBinaryWordsFromNecSuf.lean`・
`ClaimExpansionOfFiniteProductOfTwoTermSumsFromNecSuf.lean`。

人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `{0,1}^r` は Lean の `Fin (r + 1) → Fin 2`、人手の `(ε', e)` は
`Fin.snoc ε' e`（`(ε', e)_j = ε'_j`（`j ≤ r`）は `Fin.snoc_castSucc`、`(ε', e)_{r+1} = e` は `Fin.snoc_last`）である。
定義の 2 つの式が、そのまま `binWordSum` の 2 つの節である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `sum_over_binary_words_distributes_in_left_factor` の `r = 1`・`r → r + 1`（同じ並び） | `binWordSum_map` の 2 つの節（`f := (· C)`） |
| `expansion_of_finite_product_of_two_term_sums` の `r = 1`・`r → r + 1`（同じ並び） | `finProdLeft_add_eq_binWordSum` の 2 つの節 |

## 何が効いているか / 効いていないか

- 和の定義に要るのは二項演算 `+` だけである（`Add α`）。零元・結合則・可換則は効いていない（空の和を持たず、足す順序を定義で固定する）。
- 右から掛けることとの分配で効くのは、写像 `f` が `+` を保つこと（`f (a + b) = f a + f b`）だけである。具体版は `f := (· C)` で、
  `mat_mult_distributes_over_sum_in_left_factor` がこの仮定に当たる。
- 展開で効くのは、二つの分配律（`Distrib R`）だけである。積の結合則、単位元、零元、和の結合則・可換則、因子どうしの可換性は効いていない
  （積を左から掛けるので、`(∏_{j≤r} …) A_{r+1}` の形が定義そのものである）。
-/
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Algebra.Ring.Defs
import Ising2D.NecSuf.FiniteProductLeft

namespace Ising2D.NecSuf

/-- **`def_sum_over_binary_words`** の必要十分版: `{0,1}^{r+1}` で添字付けられた族の和（最後の成分で `1` を `0` より先に足す）。 -/
def binWordSum {α : Type*} [Add α] : (r : ℕ) → ((Fin (r + 1) → Fin 2) → α) → α
  | 0, B => B (fun _ => 1) + B (fun _ => 0)
  | r + 1, B => binWordSum r (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0))

/-- `Σ_{ε∈{0,1}^1} B_ε := B_{(1)} + B_{(0)}`。 -/
theorem binWordSum_zero {α : Type*} [Add α] (B : (Fin 1 → Fin 2) → α) :
    binWordSum 0 B = B (fun _ => 1) + B (fun _ => 0) := rfl

/-- `Σ_{ε∈{0,1}^{r+2}} B_ε := Σ_{ε'∈{0,1}^{r+1}} (B_{(ε',1)} + B_{(ε',0)})`（人手の `r` は Lean の `r + 1`）。 -/
theorem binWordSum_succ {α : Type*} [Add α] (r : ℕ) (B : (Fin (r + 2) → Fin 2) → α) :
    binWordSum (r + 1) B
      = binWordSum r (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl

/-- **和を保つ写像は `{0,1}^r` の上の和を保つ**（具体版 `sum_over_binary_words_distributes_in_left_factor` は `f := (· C)`）。 -/
theorem binWordSum_map {α β : Type*} [Add α] [Add β] (f : α → β) (hf : ∀ a b, f (a + b) = f a + f b) :
    ∀ (r : ℕ) (X : (Fin (r + 1) → Fin 2) → α), f (binWordSum r X) = binWordSum r (fun ε => f (X ε))
  | 0, X =>
    calc f (binWordSum 0 X)
        = f (X (fun _ => 1) + X (fun _ => 0)) := rfl                        -- 定義
      _ = f (X (fun _ => 1)) + f (X (fun _ => 0)) := hf _ _                  -- `f` は和を保つ
      _ = binWordSum 0 (fun ε => f (X ε)) := rfl                             -- 定義を右辺から左辺へ
  | r + 1, X =>
    calc f (binWordSum (r + 1) X)
        = f (binWordSum r (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0))) := rfl
                                                                             -- 定義
      _ = binWordSum r (fun ε' => f (X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0))) :=
          binWordSum_map f hf r _                                            -- 帰納法の仮定
      _ = binWordSum r (fun ε' => f (X (Fin.snoc (α := fun _ => Fin 2) ε' 1)) + f (X (Fin.snoc (α := fun _ => Fin 2) ε' 0))) := by
          congr 1; funext ε'; exact hf _ _                                   -- `f` は和を保つ（各項へ）
      _ = binWordSum (r + 1) (fun ε => f (X ε)) := rfl                       -- 定義を右辺から左辺へ

/-- **二項の和の有限積の展開**（具体版 `expansion_of_finite_product_of_two_term_sums`）。`A j e` が人手の `A_{j+1}^{(e)}`。 -/
theorem finProdLeft_add_eq_binWordSum {R : Type*} [Distrib R] :
    ∀ (r : ℕ) (A : Fin (r + 1) → Fin 2 → R),
      finProdLeft r (fun j => A j 1 + A j 0) = binWordSum r (fun ε => finProdLeft r (fun j => A j (ε j)))
  | 0, A =>
    calc finProdLeft 0 (fun j => A j 1 + A j 0)
        = A 0 1 + A 0 0 := finProdLeft_zero _                               -- 有限積の定義
      _ = A 0 ((fun _ : Fin 1 => (1 : Fin 2)) 0) + A 0 ((fun _ : Fin 1 => (0 : Fin 2)) 0) := rfl
                                                                             -- `(1)_1 = 1`、`(0)_1 = 0`
      _ = finProdLeft 0 (fun j => A j ((fun _ : Fin 1 => (1 : Fin 2)) j))
            + finProdLeft 0 (fun j => A j ((fun _ : Fin 1 => (0 : Fin 2)) j)) := rfl
                                                                             -- 有限積の定義を右辺から左辺へ 2 か所
      _ = binWordSum 0 (fun ε => finProdLeft 0 (fun j => A j (ε j))) := rfl  -- 和の定義を右辺から左辺へ
  | r + 1, A =>
    calc finProdLeft (r + 1) (fun j => A j 1 + A j 0)
        = finProdLeft r (fun j => A (Fin.castSucc j) 1 + A (Fin.castSucc j) 0)
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0) := finProdLeft_succ r _
                                                                             -- 有限積の定義
      _ = binWordSum r (fun ε' => finProdLeft r (fun j => A (Fin.castSucc j) (ε' j)))
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0) := by
          rw [finProdLeft_add_eq_binWordSum r (fun j => A (Fin.castSucc j))]  -- 帰納法の仮定
      _ = binWordSum r (fun ε' => finProdLeft r (fun j => A (Fin.castSucc j) (ε' j))
            * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0)) :=
          binWordSum_map (· * (A (Fin.last (r + 1)) 1 + A (Fin.last (r + 1)) 0))
            (fun a b => add_mul a b _) r _                                   -- 和を保つ写像（右の分配律）
      _ = binWordSum r (fun ε' => finProdLeft r (fun j => A (Fin.castSucc j) (ε' j)) * A (Fin.last (r + 1)) 1
            + finProdLeft r (fun j => A (Fin.castSucc j) (ε' j)) * A (Fin.last (r + 1)) 0) := by
          congr 1; funext ε'; exact mul_add _ _ _                            -- 左の分配律（各項へ）
      _ = binWordSum r (fun ε' =>
            finProdLeft r (fun j => A (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.castSucc j)))
              * A (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 1 (Fin.last (r + 1)))
            + finProdLeft r (fun j => A (Fin.castSucc j) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.castSucc j)))
              * A (Fin.last (r + 1)) (Fin.snoc (α := fun _ => Fin 2) ε' 0 (Fin.last (r + 1)))) := by
          simp only [Fin.snoc_castSucc, Fin.snoc_last]                       -- `(ε', e)_j = ε'_j`、`(ε', e)_{r+1} = e`
      _ = binWordSum r (fun ε' =>
            finProdLeft (r + 1) (fun j => A j (Fin.snoc (α := fun _ => Fin 2) ε' 1 j))
            + finProdLeft (r + 1) (fun j => A j (Fin.snoc (α := fun _ => Fin 2) ε' 0 j))) := rfl
                                                                             -- 有限積の定義を右辺から左辺へ（各項の 2 か所）
      _ = binWordSum (r + 1) (fun ε => finProdLeft (r + 1) (fun j => A j (ε j))) := rfl
                                                                             -- 和の定義を右辺から左辺へ

end Ising2D.NecSuf
