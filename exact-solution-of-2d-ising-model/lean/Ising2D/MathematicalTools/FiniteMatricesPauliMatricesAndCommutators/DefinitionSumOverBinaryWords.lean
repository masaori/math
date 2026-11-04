/-
# `{0,1}^r` の上の行列の和と、右または左から行列を掛けることとの分配（**具体版**）

対応する人手証明のラベル: `def_sum_over_binary_words`・`def_sum_over_binary_words_of_complex_numbers`・`def_sum_over_binary_words_of_real_numbers`・`sum_over_binary_words_distributes_in_left_factor`・
`sum_over_binary_words_distributes_in_right_factor`・`sum_over_binary_words_with_one_nonzero_term`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_sum_over_binary_words`・`linear_space_general_definition_sum_over_binary_words_of_complex_numbers`・`linear_space_general_definition_sum_over_binary_words_of_real_numbers`・
`linear_space_general_claim_sum_over_binary_words_distributes_in_left_factor`・
`linear_space_general_claim_sum_over_binary_words_distributes_in_right_factor`・
`linear_space_general_claim_sum_over_binary_words_with_one_nonzero_term`）。

**必要十分版**: `Ising2D/NecSuf/BinaryWordSum.lean`。具体版をその系として導くのは `DefinitionSumOverBinaryWordsFromNecSuf.lean`。

## 人手証明との対応

* 人手の `r ∈ ℤ_{≥1}` が Lean の `r + 1` に当たる。人手の `{0,1}^r` は Lean の `Fin (r + 1) → Fin 2` で、人手の `ε_j` が Lean の `ε (j - 1)` である。
  人手の `(ε', e)` は `Fin.snoc ε' e` である。
* 定義の 2 つの式は `binaryWordMatrixSum` の 2 つの節で、`binaryWordMatrixSum_zero`・`binaryWordMatrixSum_succ` として引く。
  複素数の和 `def_sum_over_binary_words_of_complex_numbers` も同じ 2 つの節の `binaryWordComplexSum` で、
  `binaryWordComplexSum_zero`・`binaryWordComplexSum_succ` として引く。実数の和 `def_sum_over_binary_words_of_real_numbers` も同じ 2 つの節の
  `binaryWordRealSum` で、`binaryWordRealSum_zero`・`binaryWordRealSum_succ` として引く。
* `sum_over_binary_words_distributes_in_left_factor` の帰納法の 2 つの鎖（`r = 1` の 3 行、`r → r + 1` の 4 行）は、
  `binaryWordMatrixSum_mul` の 2 つの節の `calc` と 1 対 1 である。`mat_mult_distributes_over_sum_in_left_factor` は具体版 `add_mul_matrix` である。
* `sum_over_binary_words_distributes_in_right_factor` の帰納法の 2 つの鎖（`r = 1` の 3 行、`r → r + 1` の 4 行）は、
  `mul_binaryWordMatrixSum` の 2 つの節の `calc` と 1 対 1 である。`mat_mult_distributes_over_sum_in_right_factor` は具体版 `mul_add_matrix` である。
* `sum_over_binary_words_with_one_nonzero_term` の帰納法（`r = 1` の二つの場合の 3 行ずつ、`r → r + 1` の `δ' ≠ δ` の 3 行・本体の 4 行・
  `e = 1`・`e = 0` の 3 行ずつ）は、`binaryWordMatrixSum_eq_of_eq_zero` の `calc` と 1 対 1 である。人手の `δ` は `Fin.init ε'`、人手の `C_{δ'}` は `fun δ' => B (Fin.snoc δ' 1) + B (Fin.snoc δ' 0)`（`C` の定義の行は `rfl` で、`calc` の行を立てていない）、
  `(δ, e) = ε'` は `Fin.snoc_init_self`、`(δ', e'') ≠ ε'` と `(δ, e') ≠ ε'` の段は `binaryWord_snoc_ne_of_ne_init`・`binaryWord_snoc_ne_of_ne_last` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimMatMultDistributesOverSum
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Tactic.FinCases

namespace Ising2D

open Matrix

/-- **`def_sum_over_binary_words`**: `{0,1}^{r+1}` で添字付けられた `Mat(m,n,ℂ)` の元の和。 -/
def binaryWordMatrixSum {m n : ℕ} :
    (r : ℕ) → ((Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) → Matrix (Fin m) (Fin n) ℂ
  | 0, B => B (fun _ => 1) + B (fun _ => 0)
  | r + 1, B => binaryWordMatrixSum r (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0))

/-- `def_sum_over_binary_words` の 1 つ目の式: `Σ_{ε∈{0,1}^1} B_ε := B_{(1)} + B_{(0)}`。 -/
theorem binaryWordMatrixSum_zero {m n : ℕ} (B : (Fin 1 → Fin 2) → Matrix (Fin m) (Fin n) ℂ) :
    binaryWordMatrixSum 0 B = B (fun _ => 1) + B (fun _ => 0) := rfl

/-- `def_sum_over_binary_words` の 2 つ目の式: `Σ_{ε∈{0,1}^{r+2}} B_ε := Σ_{ε'∈{0,1}^{r+1}} (B_{(ε',1)} + B_{(ε',0)})`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordMatrixSum_succ {m n : ℕ} (r : ℕ) (B : (Fin (r + 2) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) :
    binaryWordMatrixSum (r + 1) B
      = binaryWordMatrixSum r
          (fun ε' => B (Fin.snoc (α := fun _ => Fin 2) ε' 1) + B (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl

/-- **`def_sum_over_binary_words_of_complex_numbers`**: `{0,1}^{r+1}` で添字付けられた複素数の和
（足す順序は `binaryWordMatrixSum` と同じ。人手の `r` は Lean の `r + 1`）。 -/
def binaryWordComplexSum : (r : ℕ) → ((Fin (r + 1) → Fin 2) → ℂ) → ℂ
  | 0, z => z (fun _ => 1) + z (fun _ => 0)
  | r + 1, z => binaryWordComplexSum r (fun ε' => z (Fin.snoc (α := fun _ => Fin 2) ε' 1) + z (Fin.snoc (α := fun _ => Fin 2) ε' 0))

/-- `def_sum_over_binary_words_of_complex_numbers` の 1 つ目の式: `Σ_{ε∈{0,1}^1} z_ε := z_{(1)} + z_{(0)}`。 -/
theorem binaryWordComplexSum_zero (z : (Fin 1 → Fin 2) → ℂ) :
    binaryWordComplexSum 0 z = z (fun _ => 1) + z (fun _ => 0) := rfl

/-- `def_sum_over_binary_words_of_complex_numbers` の 2 つ目の式:
`Σ_{ε∈{0,1}^{r+2}} z_ε := Σ_{ε'∈{0,1}^{r+1}} (z_{(ε',1)} + z_{(ε',0)})`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordComplexSum_succ (r : ℕ) (z : (Fin (r + 2) → Fin 2) → ℂ) :
    binaryWordComplexSum (r + 1) z
      = binaryWordComplexSum r
          (fun ε' => z (Fin.snoc (α := fun _ => Fin 2) ε' 1) + z (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl

/-- **`def_sum_over_binary_words_of_real_numbers`**: `{0,1}^{r+1}` で添字付けられた実数の和
（足す順序は `binaryWordMatrixSum` と同じ。人手の `r` は Lean の `r + 1`）。 -/
def binaryWordRealSum : (r : ℕ) → ((Fin (r + 1) → Fin 2) → ℝ) → ℝ
  | 0, x => x (fun _ => 1) + x (fun _ => 0)
  | r + 1, x => binaryWordRealSum r (fun ε' => x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0))

/-- `def_sum_over_binary_words_of_real_numbers` の 1 つ目の式: `Σ_{ε∈{0,1}^1} x_ε := x_{(1)} + x_{(0)}`。 -/
theorem binaryWordRealSum_zero (x : (Fin 1 → Fin 2) → ℝ) :
    binaryWordRealSum 0 x = x (fun _ => 1) + x (fun _ => 0) := rfl

/-- `def_sum_over_binary_words_of_real_numbers` の 2 つ目の式:
`Σ_{ε∈{0,1}^{r+2}} x_ε := Σ_{ε'∈{0,1}^{r+1}} (x_{(ε',1)} + x_{(ε',0)})`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordRealSum_succ (r : ℕ) (x : (Fin (r + 2) → Fin 2) → ℝ) :
    binaryWordRealSum (r + 1) x
      = binaryWordRealSum r
          (fun ε' => x (Fin.snoc (α := fun _ => Fin 2) ε' 1) + x (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl

/-- **`sum_over_binary_words_distributes_in_left_factor`**: `(Σ_{ε∈{0,1}^r} X_ε) C = Σ_{ε∈{0,1}^r} X_ε C`（人手の `r` は Lean の `r + 1`）。 -/
theorem binaryWordMatrixSum_mul {m n p : ℕ} :
    ∀ (r : ℕ) (X : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ) (C : Matrix (Fin n) (Fin p) ℂ),
      binaryWordMatrixSum r X * C = binaryWordMatrixSum r (fun ε => X ε * C)
  | 0, X, C =>
    calc binaryWordMatrixSum 0 X * C
        = (X (fun _ => 1) + X (fun _ => 0)) * C := rfl                       -- `def_sum_over_binary_words`
      _ = X (fun _ => 1) * C + X (fun _ => 0) * C := add_mul_matrix _ _ _     -- `mat_mult_distributes_over_sum_in_left_factor`
      _ = binaryWordMatrixSum 0 (fun ε => X ε * C) := rfl                     -- `def_sum_over_binary_words` を右辺から左辺へ
  | r + 1, X, C =>
    calc binaryWordMatrixSum (r + 1) X * C
        = binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * C := rfl
                                                                              -- `def_sum_over_binary_words`
      _ = binaryWordMatrixSum r
            (fun ε' => (X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) * C) :=
          binaryWordMatrixSum_mul r _ C                                       -- 帰納法の仮定
      _ = binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) * C + X (Fin.snoc (α := fun _ => Fin 2) ε' 0) * C) := by
          congr 1; funext ε'; exact add_mul_matrix _ _ _                      -- `mat_mult_distributes_over_sum_in_left_factor` を各項へ
      _ = binaryWordMatrixSum (r + 1) (fun ε => X ε * C) := rfl               -- `def_sum_over_binary_words` を右辺から左辺へ

/-- **`sum_over_binary_words_distributes_in_right_factor`**: `C (Σ_{ε∈{0,1}^r} X_ε) = Σ_{ε∈{0,1}^r} C X_ε`（人手の `r` は Lean の `r + 1`）。 -/
theorem mul_binaryWordMatrixSum {m n p : ℕ} :
    ∀ (r : ℕ) (C : Matrix (Fin m) (Fin n) ℂ) (X : (Fin (r + 1) → Fin 2) → Matrix (Fin n) (Fin p) ℂ),
      C * binaryWordMatrixSum r X = binaryWordMatrixSum r (fun ε => C * X ε)
  | 0, C, X =>
    calc C * binaryWordMatrixSum 0 X
        = C * (X (fun _ => 1) + X (fun _ => 0)) := rfl                       -- `def_sum_over_binary_words`
      _ = C * X (fun _ => 1) + C * X (fun _ => 0) := mul_add_matrix _ _ _     -- `mat_mult_distributes_over_sum_in_right_factor`
      _ = binaryWordMatrixSum 0 (fun ε => C * X ε) := rfl                     -- `def_sum_over_binary_words` を右辺から左辺へ
  | r + 1, C, X =>
    calc C * binaryWordMatrixSum (r + 1) X
        = C * binaryWordMatrixSum r
            (fun ε' => X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := rfl
                                                                              -- `def_sum_over_binary_words`
      _ = binaryWordMatrixSum r
            (fun ε' => C * (X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + X (Fin.snoc (α := fun _ => Fin 2) ε' 0))) :=
          mul_binaryWordMatrixSum r C _                                       -- 帰納法の仮定
      _ = binaryWordMatrixSum r
            (fun ε' => C * X (Fin.snoc (α := fun _ => Fin 2) ε' 1) + C * X (Fin.snoc (α := fun _ => Fin 2) ε' 0)) := by
          congr 1; funext ε'; exact mul_add_matrix _ _ _                      -- `mat_mult_distributes_over_sum_in_right_factor` を各項へ
      _ = binaryWordMatrixSum (r + 1) (fun ε => C * X ε) := rfl               -- `def_sum_over_binary_words` を右辺から左辺へ

/-- `{0,1}^1` の元は `(1)` と `(0)` である（`def_sum_over_binary_words`）。 -/
theorem binaryWord_one_eq_one_or_zero (ε : Fin 1 → Fin 2) : ε = (fun _ => 1) ∨ ε = (fun _ => 0) := by
  have h : ε 0 = 1 ∨ ε 0 = 0 := by generalize ε 0 = e; fin_cases e <;> simp
  rcases h with h | h
  · left; funext j; rw [Subsingleton.elim j 0, h]
  · right; funext j; rw [Subsingleton.elim j 0, h]

/-- `e ∈ {0,1}` は `1` か `0` である。 -/
theorem binaryWord_fin_two_eq_one_or_zero (e : Fin 2) : e = 1 ∨ e = 0 := by
  fin_cases e <;> simp

/-- 人手の「`δ' ≠ δ` なら、ある `j ≤ r` で `δ'_j ≠ δ_j` であり、`(δ', e'')_j = δ'_j ≠ δ_j = ε'_j` なので `(δ', e'') ≠ ε'`」。
`δ` は `ε'` の初めの `r` 成分（`Fin.init ε'`）である。 -/
theorem binaryWord_snoc_ne_of_ne_init {r : ℕ} (ε' : Fin (r + 2) → Fin 2) (δ' : Fin (r + 1) → Fin 2)
    (hne : δ' ≠ Fin.init ε') (e'' : Fin 2) : Fin.snoc (α := fun _ => Fin 2) δ' e'' ≠ ε' := by
  obtain ⟨j, hj⟩ := Function.ne_iff.mp hne                  -- ある `j ≤ r` で `δ'_j ≠ δ_j`
  intro heq
  apply hj
  calc δ' j
      = Fin.snoc (α := fun _ => Fin 2) δ' e'' (Fin.castSucc j) := (Fin.snoc_castSucc (α := fun _ => Fin 2) _ _ _).symm
                                                              -- `(δ', e'')_j = δ'_j`
    _ = ε' (Fin.castSucc j) := by rw [heq]                    -- `(δ', e'') = ε'` と仮定する
    _ = Fin.init ε' j := rfl                                  -- `δ_j := ε'_j`

/-- 人手の「`(δ, e')_{r+1} = e' ≠ e = ε'_{r+1}` なので `(δ, e') ≠ ε'`」。 -/
theorem binaryWord_snoc_ne_of_ne_last {r : ℕ} (ε' : Fin (r + 2) → Fin 2) (e' : Fin 2)
    (hne : e' ≠ ε' (Fin.last (r + 1))) : Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') e' ≠ ε' := by
  intro heq
  apply hne
  calc e'
      = Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') e' (Fin.last (r + 1)) := (Fin.snoc_last (α := fun _ => Fin 2) _ _).symm
                                                              -- `(δ, e')_{r+1} = e'`
    _ = ε' (Fin.last (r + 1)) := by rw [heq]                  -- `(δ, e') = ε'` と仮定する

/-- **`sum_over_binary_words_with_one_nonzero_term`**: `ε ≠ ε'` で `B_ε = O` なら `Σ_{ε∈{0,1}^r} B_ε = B_{ε'}`
（人手の `r` は Lean の `r + 1`）。帰納法の `r = 1` の二つの場合と、`r → r + 1` の `δ' ≠ δ` の鎖・本体の 4 行・`e = 1`・`e = 0` の場合の鎖が、
人手の鎖と 1 対 1 である（`C` の定義の行は `rfl` で、`calc` の行を立てていない）。`matrix_plus_zero_matrix`・`zero_matrix_plus_matrix` は具体版 `matrix_add_zero_matrix`・`zero_matrix_add_matrix`。 -/
theorem binaryWordMatrixSum_eq_of_eq_zero {m n : ℕ} :
    ∀ (r : ℕ) (ε' : Fin (r + 1) → Fin 2) (B : (Fin (r + 1) → Fin 2) → Matrix (Fin m) (Fin n) ℂ),
      (∀ ε, ε ≠ ε' → B ε = 0) → binaryWordMatrixSum r B = B ε'
  | 0, ε', B, hB => by
    rcases binaryWord_one_eq_one_or_zero ε' with h | h
    · -- `ε' = (1)`: `(0)_1 = 0 ≠ 1 = (1)_1` なので `B_{(0)} = O`
      subst h
      have h0 : B (fun _ => 0) = 0 := hB _ (fun heq => absurd (congrFun heq 0) (by decide))
      calc binaryWordMatrixSum 0 B
          = B (fun _ => 1) + B (fun _ => 0) := rfl            -- `def_sum_over_binary_words`
        _ = B (fun _ => 1) + 0 := by rw [h0]                  -- `B_{(0)} = O`
        _ = B (fun _ => 1) := matrix_add_zero_matrix _        -- `matrix_plus_zero_matrix`
    · -- `ε' = (0)`: `(1)_1 = 1 ≠ 0 = (0)_1` なので `B_{(1)} = O`
      subst h
      have h1 : B (fun _ => 1) = 0 := hB _ (fun heq => absurd (congrFun heq 0) (by decide))
      calc binaryWordMatrixSum 0 B
          = B (fun _ => 1) + B (fun _ => 0) := rfl            -- `def_sum_over_binary_words`
        _ = 0 + B (fun _ => 0) := by rw [h1]                  -- `B_{(1)} = O`
        _ = B (fun _ => 0) := zero_matrix_add_matrix _        -- `zero_matrix_plus_matrix`
  | r + 1, ε', B, hB => by
    -- `δ := (ε'_1, …, ε'_r)`（`Fin.init ε'`）、`e := ε'_{r+1}`、`(δ, e) = ε'`
    have hδe : Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') (ε' (Fin.last (r + 1))) = ε' := Fin.snoc_init_self ε'
    -- `δ' ≠ δ` なら `B_{(δ',1)} + B_{(δ',0)} = O + O = O`
    have hC : ∀ δ', δ' ≠ Fin.init ε' →
        B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0) = 0 := by
      intro δ' hne
      calc B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0)
          = 0 + 0 := by
            rw [hB _ (binaryWord_snoc_ne_of_ne_init ε' δ' hne 1), hB _ (binaryWord_snoc_ne_of_ne_init ε' δ' hne 0)]
                                                              -- `B_{(δ',1)} = O`、`B_{(δ',0)} = O`
        _ = 0 := matrix_add_zero_matrix 0                     -- `matrix_plus_zero_matrix`（`X → O`）
    have hbody : binaryWordMatrixSum (r + 1) B
        = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) :=
      calc binaryWordMatrixSum (r + 1) B
          = binaryWordMatrixSum r
              (fun δ' => B (Fin.snoc (α := fun _ => Fin 2) δ' 1) + B (Fin.snoc (α := fun _ => Fin 2) δ' 0)) := rfl
                                                              -- `def_sum_over_binary_words`
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) :=
            binaryWordMatrixSum_eq_of_eq_zero r (Fin.init ε') _ hC
                                                              -- `C_{δ'}` の定義（`fun δ' => B_{(δ',1)} + B_{(δ',0)}` が `C`）、
                                                              -- 帰納法の仮定（`ε' → δ`、`B → C`）、`C_δ` の定義
    rcases binaryWord_fin_two_eq_one_or_zero (ε' (Fin.last (r + 1))) with he | he
    · -- `e = 1`: `(δ,0)_{r+1} = 0 ≠ 1 = ε'_{r+1}` なので `B_{(δ,0)} = O`
      have h0 : B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) = 0 :=
        hB _ (binaryWord_snoc_ne_of_ne_last ε' 0 (by rw [he]; decide))
      calc binaryWordMatrixSum (r + 1) B
          = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := hbody
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + 0 := by rw [h0]
                                                              -- `B_{(δ,0)} = O`
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) := matrix_add_zero_matrix _
                                                              -- `matrix_plus_zero_matrix`
        _ = B ε' := by rw [← he, hδe]                         -- `(δ,1) = (δ,e) = ε'`
    · -- `e = 0`: `(δ,1)_{r+1} = 1 ≠ 0 = ε'_{r+1}` なので `B_{(δ,1)} = O`
      have h1 : B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) = 0 :=
        hB _ (binaryWord_snoc_ne_of_ne_last ε' 1 (by rw [he]; decide))
      calc binaryWordMatrixSum (r + 1) B
          = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 1) + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := hbody
        _ = 0 + B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := by rw [h1]
                                                              -- `B_{(δ,1)} = O`
        _ = B (Fin.snoc (α := fun _ => Fin 2) (Fin.init ε') 0) := zero_matrix_add_matrix _
                                                              -- `zero_matrix_plus_matrix`
        _ = B ε' := by rw [← he, hδe]                         -- `(δ,0) = (δ,e) = ε'`

end Ising2D
