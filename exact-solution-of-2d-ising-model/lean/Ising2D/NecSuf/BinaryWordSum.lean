/-
# `{0,1}^r` の上の和、その加法を保つ写像による像、二項の和の有限積の展開（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/DefinitionSumOverBinaryWords.lean`
（人手 `def_sum_over_binary_words`・`sum_over_binary_words_distributes_in_left_factor`・`sum_over_binary_words_distributes_in_right_factor`・
`sum_over_binary_words_with_one_nonzero_term`）と
`ClaimExpansionOfFiniteProductOfTwoTermSums.lean`（人手 `expansion_of_finite_product_of_two_term_sums`）。
具体版をこのファイルの系として導くのは、同じフォルダの `DefinitionSumOverBinaryWordsFromNecSuf.lean`・
`ClaimExpansionOfFiniteProductOfTwoTermSumsFromNecSuf.lean`。

人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `{0,1}^r` は Lean の `Fin (r + 1) → Fin 2`、人手の `(ε', e)` は
`Fin.snoc ε' e`（`(ε', e)_j = ε'_j`（`j ≤ r`）は `Fin.snoc_castSucc`、`(ε', e)_{r+1} = e` は `Fin.snoc_last`）である。
定義の 2 つの式が、そのまま `binWordSum` の 2 つの節である。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `sum_over_binary_words_distributes_in_left_factor` の `r = 1`・`r → r + 1`（同じ並び） | `binWordSum_map` の 2 つの節（`f := (· C)`） |
| `sum_over_binary_words_distributes_in_right_factor` の `r = 1`・`r → r + 1`（同じ並び） | `binWordSum_map` の 2 つの節（`f := (C * ·)`） |
| `trace_of_sum_over_binary_words` の `r = 1`・`r → r + 1` | `binWordSum_map` の 2 つの節（`f := trace`。導出は `ClaimTraceOfSumOverBinaryWordsFromNecSuf.lean`） |
| `real_inclusion_preserves_sum_over_binary_words` の `r = 1`・`r → r + 1`（人手の鎖を右辺から左辺へ読んだ形。段の対応は逆順で 1 対 1） | `binWordSum_map` の 2 つの節（`f := (↑· : ℝ → ℂ)`。導出は `ClaimRealInclusionPreservesSumOverBinaryWordsFromNecSuf.lean`） |
| `expansion_of_finite_product_of_two_term_sums` の `r = 1`・`r → r + 1`（同じ並び） | `finProdLeft_add_eq_binWordSum` の 2 つの節 |
| `sum_over_binary_words_with_one_nonzero_term` の `r = 1` の二つの場合・`r → r + 1` の `δ' ≠ δ`・本体・二つの場合（同じ並び） | `binWordSum_eq_of_eq_zero` の 2 つの節 |

## 何が効いているか / 効いていないか

- 和の定義に要るのは二項演算 `+` だけである（`Add α`）。零元・結合則・可換則は効いていない（空の和を持たず、足す順序を定義で固定する）。
- 右から掛けることとの分配で効くのは、写像 `f` が `+` を保つこと（`f (a + b) = f a + f b`）だけである。具体版は `f := (· C)` で、
  `mat_mult_distributes_over_sum_in_left_factor` がこの仮定に当たる。左から掛ける側も同じ補題で、`f := (C * ·)`、
  `mat_mult_distributes_over_sum_in_right_factor` が仮定に当たる（右と左で別の性質は効いていない）。
- 一つの項以外が零の和で効くのは、`a + 0 = a`・`0 + a = a`（`AddZeroClass α`）だけである。和の結合則・可換則・逆元は効いていない。
  零元を持たない `Add α` では主張が述べられないので、零元と二つの単位律は削れない（`ε'` が `(1)` か `(0)` かで片方ずつ使う）。
- 展開で効くのは、二つの分配律（`Distrib R`）だけである。積の結合則、単位元、零元、和の結合則・可換則、因子どうしの可換性は効いていない
  （積を左から掛けるので、`(∏_{j≤r} …) A_{r+1}` の形が定義そのものである）。
-/
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Tactic.FinCases
import Mathlib.Data.Fintype.Basic
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

/-- **和を保つ写像は `{0,1}^r` の上の和を保つ**（具体版 `sum_over_binary_words_distributes_in_left_factor` は `f := (· C)`、
`sum_over_binary_words_distributes_in_right_factor` は `f := (C * ·)`）。 -/
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

/-- `{0,1}^1` の元は `(1)` と `(0)` である。 -/
theorem binWord_one_eq_one_or_zero (ε : Fin 1 → Fin 2) : ε = (fun _ => 1) ∨ ε = (fun _ => 0) := by
  have h : ε 0 = 1 ∨ ε 0 = 0 := by generalize ε 0 = e; fin_cases e <;> simp
  rcases h with h | h
  · left; funext j; rw [Subsingleton.elim j 0, h]
  · right; funext j; rw [Subsingleton.elim j 0, h]

/-- `δ' ≠ δ`（`δ := Fin.init ε'`）なら `(δ', e'') ≠ ε'`（ある `j ≤ r` の成分で異なる）。 -/
theorem snoc_ne_of_ne_init {r : ℕ} (ε' : Fin (r + 2) → Fin 2) (δ' : Fin (r + 1) → Fin 2)
    (hne : δ' ≠ Fin.init ε') (e'' : Fin 2) : Fin.snoc (α := fun _ => Fin 2) δ' e'' ≠ ε' := by
  obtain ⟨j, hj⟩ := Function.ne_iff.mp hne
  intro heq
  apply hj
  calc δ' j
      = Fin.snoc (α := fun _ => Fin 2) δ' e'' (Fin.castSucc j) := (Fin.snoc_castSucc (α := fun _ => Fin 2) _ _ _).symm
    _ = ε' (Fin.castSucc j) := by rw [heq]
    _ = Fin.init ε' j := rfl

/-- `e' ≠ ε'_{r+1}` なら `(δ, e') ≠ ε'`。 -/
theorem snoc_ne_of_ne_last {r : ℕ} (ε' : Fin (r + 2) → Fin 2) (e' : Fin 2)
    (hne : e' ≠ ε' (Fin.last (r + 1))) : Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') e' ≠ ε' := by
  intro heq
  apply hne
  calc e'
      = Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') e' (Fin.last (r + 1)) := (Fin.snoc_last (α := fun _ => Fin 2) _ _).symm
    _ = ε' (Fin.last (r + 1)) := by rw [heq]

/-- **一つの項以外が零の `{0,1}^r` の上の和はその項に等しい**（具体版 `sum_over_binary_words_with_one_nonzero_term`）。
効くのは `a + 0 = a`・`0 + a = a`（`AddZeroClass`）だけで、和の結合則・可換則・逆元は効いていない。
`r → r + 1` の段の `O + O = O` も `a + 0 = a` の `a := 0` である。 -/
theorem binWordSum_eq_of_eq_zero {α : Type*} [AddZeroClass α] :
    ∀ (r : ℕ) (ε' : Fin (r + 1) → Fin 2) (B : (Fin (r + 1) → Fin 2) → α),
      (∀ ε, ε ≠ ε' → B ε = 0) → binWordSum r B = B ε'
  | 0, ε', B, hB => by
    rcases binWord_one_eq_one_or_zero ε' with h | h
    · subst h
      have h0 : B (fun _ => 0) = 0 := hB _ (fun heq => absurd (congrFun heq 0) (by decide))
      calc binWordSum 0 B
          = B (fun _ => 1) + B (fun _ => 0) := rfl            -- 定義
        _ = B (fun _ => 1) + 0 := by rw [h0]                  -- `B_{(0)} = 0`
        _ = B (fun _ => 1) := add_zero _                      -- `a + 0 = a`
    · subst h
      have h1 : B (fun _ => 1) = 0 := hB _ (fun heq => absurd (congrFun heq 0) (by decide))
      calc binWordSum 0 B
          = B (fun _ => 1) + B (fun _ => 0) := rfl            -- 定義
        _ = 0 + B (fun _ => 0) := by rw [h1]                  -- `B_{(1)} = 0`
        _ = B (fun _ => 0) := zero_add _                      -- `0 + a = a`
  | r + 1, ε', B, hB => by
    have hδe : Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') (ε' (Fin.last (r + 1))) = ε' := Fin.snoc_init_self ε'
    have hC : ∀ δ', δ' ≠ Fin.init ε' →
        B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0) = 0 := by
      intro δ' hne
      calc B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0)
          = 0 + 0 := by
            rw [hB _ (snoc_ne_of_ne_init ε' δ' hne 1), hB _ (snoc_ne_of_ne_init ε' δ' hne 0)]
        _ = 0 := add_zero 0                                   -- `a + 0 = a`（`a := 0`）
    have hbody : binWordSum (r + 1) B
        = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) :=
      calc binWordSum (r + 1) B
          = binWordSum r
              (fun δ' => B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0)) := rfl
                                                              -- 定義
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) :=
            binWordSum_eq_of_eq_zero r (Fin.init ε') _ hC     -- 帰納法の仮定
    have he : ε' (Fin.last (r + 1)) = 1 ∨ ε' (Fin.last (r + 1)) = 0 := by generalize ε' (Fin.last (r + 1)) = e; fin_cases e <;> simp
    rcases he with he | he
    · have h0 : B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) = 0 :=
        hB _ (snoc_ne_of_ne_last ε' 0 (by rw [he]; decide))
      calc binWordSum (r + 1) B
          = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := hbody
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + 0 := by rw [h0]
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) := add_zero _
        _ = B ε' := by rw [← he, hδe]
    · have h1 : B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) = 0 :=
        hB _ (snoc_ne_of_ne_last ε' 1 (by rw [he]; decide))
      calc binWordSum (r + 1) B
          = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := hbody
        _ = 0 + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := by rw [h1]
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := zero_add _
        _ = B ε' := by rw [← he, hδe]

end Ising2D.NecSuf
