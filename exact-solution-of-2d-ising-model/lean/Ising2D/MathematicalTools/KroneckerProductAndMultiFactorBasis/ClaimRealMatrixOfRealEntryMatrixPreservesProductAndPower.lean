/-
# `ϱ_{ℂ→ℝ}` は積と冪を保つ（具体版）

正本: `structured-latex/content/002_linear_space_general.ts`

* `linear_space_general_claim_real_matrix_of_real_entry_matrix_preserves_product`
  （ラベル **`real_matrix_of_real_entry_matrix_preserves_product`**）
* `linear_space_general_claim_real_matrix_of_real_entry_matrix_preserves_power`
  （ラベル **`real_matrix_of_real_entry_matrix_preserves_power`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 積: 6 行の鎖 `(((AB)_ℝ)_ik)_ℂ = (AB)_ik = Σ_j A_ijB_jk = Σ_j ((A_ℝ)_ij)_ℂ((B_ℝ)_jk)_ℂ = Σ_j ((A_ℝ)_ij(B_ℝ)_jk)_ℂ = (Σ_j (A_ℝ)_ij(B_ℝ)_jk)_ℂ = ((A_ℝB_ℝ)_ik)_ℂ` | `real_matrix_of_real_entry_matrix_preserves_product` の `calc` の 6 段 |
| 積: 結び（`inclusion_rr_to_cc_is_injective`、`i, k` は任意） | 同じ定理の `ext i k` と `inclusion_rr_to_cc_is_injective` |
| 冪 `q = 0`: `I_st = δ_st = {1_ℂ, 0_ℂ} = {(1)_ℂ, (0)_ℂ} = ((I_{Mat(n,ℝ)})_st)_ℂ` の 4 行 | `identity_matrix_entry_eq_real_identity_entry` の `calc` の 3 段（Lean には `δ` に当たる独立の対象が無く、mathlib の単位行列の成分 `Matrix.one_apply` が `if s = t then 1 else 0` を返すので、人手の 1・2 行目が 1 段目にまとまる） |
| 冪 `q = 0`: `A^0 = I` の成分はすべて実数 | `identity_matrix_hasRealEntries` |
| 冪 `q = 0`: `(((A^0)_ℝ)_st)_ℂ = (A^0)_st = I_st = ((I_{Mat(n,ℝ)})_st)_ℂ = (((A_ℝ)^0)_st)_ℂ` の 4 行と単射性 | `real_matrix_of_real_entry_matrix_preserves_power` の `zero` の `calc` の 4 段 |
| 冪 `q + 1`: `A^{q+1} = A^qA` の成分はすべて実数（`product_of_real_entry_matrices_has_real_entries`） | `matrix_pow_hasRealEntries` の `succ` |
| 冪 `q + 1`: 4 行の鎖 `(A^{q+1})_ℝ = (A^qA)_ℝ = (A^q)_ℝA_ℝ = (A_ℝ)^qA_ℝ = (A_ℝ)^{q+1}` | `real_matrix_of_real_entry_matrix_preserves_power` の `succ` の `calc` の 4 段 |

- 人手の `Mat^re(m,n,ℂ)` の元 `A` は、Lean では行列 `A` と `MatrixHasRealEntries A` の証明 `hA` の組である
  （`DefinitionRealMatrixOfRealEntryMatrix.lean`）。`(AB)_ℝ` に渡す証明は `matrix_mul_hasRealEntries`、`(A^q)_ℝ` に渡す証明は
  `matrix_pow_hasRealEntries` である。`MatrixHasRealEntries` は命題なので、どの証明を渡しても `realMatrixOfRealEntries` の値は同じである。
  `A^{q+1}` と `A^qA` は行列として等しいが証明の型が違うので、その行は `realMatrixOfRealEntries_congr`（等しい行列の `ϱ` は等しい）で書く。
- 人手の `def_exp` (1) の `A^0 := I`、`A^{m+1} := A^mA` は、Lean の `Monoid` の冪の `pow_zero`・`pow_succ` である（`K = ℂ` と `K = ℝ` の両方）。
- 人手の `def_real_matrix_product`・`def_real_identity_matrix`（実数の行列の積と単位行列）は、Lean の `Matrix ι ι ℝ` の `*` と `1`（成分は `Matrix.one_apply`）である。
- 人手の `m, n, p ∈ ℤ_{≥1}` と成分の番号は、Lean の添字の型の元である。和を取る添字の型には、`matrix_mul_hasRealEntries` と同じく
  `Fintype` と、人手の `n ≥ 1` に当たる `Nonempty` を置く。
- 積の鎖の 5 行目の `real_inclusion_preserves_finite_sum` は具体版が無いので、既存の慣行どおり mathlib の `Complex.ofReal_sum` を引く。
  2 行目・6 行目の `mat_mult` は mathlib の行列の積の定義（成分は `dotProduct`）で `rfl` である。

必要十分版は置かない。主張は `ℝ → ℂ` の包含が和と積を保ち単射であること（`real_inclusion_preserves_product`・
`real_inclusion_preserves_finite_sum`・`inclusion_rr_to_cc_is_injective`）の成分ごとの組み合わせで、それらの抽象的な内容は
引いた主張の側（`NecSuf/ProductOfClosedEntries.lean` ほか）に尽きている。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionRealMatrixOfRealEntryMatrix
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimProductOfRealEntryMatricesHasRealEntries

namespace Ising2D

/-- 等しい行列の `ϱ` は等しい（`ϱ` は写像なので、引数が等しければ値が等しい）。 -/
theorem realMatrixOfRealEntries_congr {α β : Type*} {B B' : Matrix α β ℂ} (h : B = B')
    (hB : MatrixHasRealEntries B) (hB' : MatrixHasRealEntries B') :
    realMatrixOfRealEntries B hB = realMatrixOfRealEntries B' hB' := by
  subst h
  rfl

/-- **人手 `real_matrix_of_real_entry_matrix_preserves_product`**: `(AB)_ℝ = A_ℝB_ℝ`。 -/
theorem real_matrix_of_real_entry_matrix_preserves_product {α β γ : Type*} [Fintype β] [Nonempty β]
    (A : Matrix α β ℂ) (B : Matrix β γ ℂ) (hA : MatrixHasRealEntries A) (hB : MatrixHasRealEntries B) :
    realMatrixOfRealEntries (A * B) (matrix_mul_hasRealEntries A B hA hB)
      = realMatrixOfRealEntries A hA * realMatrixOfRealEntries B hB := by
  ext i k
  apply inclusion_rr_to_cc_is_injective                                      -- `a → ((AB)_ℝ)_ik`, `b → (A_ℝB_ℝ)_ik`
  calc ((realMatrixOfRealEntries (A * B) (matrix_mul_hasRealEntries A B hA hB) i k : ℝ) : ℂ)
      = (A * B) i k := ofReal_realMatrixOfRealEntries_apply _ _ i k          -- `def_real_matrix_of_real_entry_matrix`（`B → AB`）
    _ = ∑ j, A i j * B j k := rfl                                            -- `mat_mult`
    _ = ∑ j, ((realMatrixOfRealEntries A hA i j : ℝ) : ℂ)
          * ((realMatrixOfRealEntries B hB j k : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun j _ => by
          rw [ofReal_realMatrixOfRealEntries_apply A hA i j,
            ofReal_realMatrixOfRealEntries_apply B hB j k]                   -- `def_real_matrix_of_real_entry_matrix`（`B → A` と `B → B`）を `n` 個の項へ
    _ = ∑ j, ((realMatrixOfRealEntries A hA i j * realMatrixOfRealEntries B hB j k : ℝ) : ℂ) :=
        Finset.sum_congr rfl fun j _ => real_inclusion_mul _ _               -- `real_inclusion_preserves_product` を `n` 個の項へ
    _ = ((∑ j, realMatrixOfRealEntries A hA i j * realMatrixOfRealEntries B hB j k : ℝ) : ℂ) :=
        (Complex.ofReal_sum _ _).symm                                        -- `real_inclusion_preserves_finite_sum`（`m → n`）
    _ = (((realMatrixOfRealEntries A hA * realMatrixOfRealEntries B hB) i k : ℝ) : ℂ) := rfl
                                                                             -- `def_real_matrix_product`（`P → A_ℝ`, `Q → B_ℝ`）

variable {ι : Type*} [DecidableEq ι]

/-- **人手 `real_matrix_of_real_entry_matrix_preserves_power` の `q = 0` の 4 行の鎖**:
`I_st = δ_st = {1_ℂ, 0_ℂ} = {(1)_ℂ, (0)_ℂ} = ((I_{Mat(n,ℝ)})_st)_ℂ`。 -/
theorem identity_matrix_entry_eq_real_identity_entry (s t : ι) :
    (1 : Matrix ι ι ℂ) s t = (((1 : Matrix ι ι ℝ) s t : ℝ) : ℂ) :=
  calc (1 : Matrix ι ι ℂ) s t
      = if s = t then (1 : ℂ) else 0 := Matrix.one_apply                        -- `def_identity_matrix` と `def_kronecker_delta`
    _ = if s = t then ((1 : ℝ) : ℂ) else ((0 : ℝ) : ℂ) := by
        rw [Complex.ofReal_one, Complex.ofReal_zero]                           -- 略記 `1_ℂ = (1)_ℂ`、`0_ℂ = (0)_ℂ`
    _ = (((1 : Matrix ι ι ℝ) s t : ℝ) : ℂ) := by
        rw [Matrix.one_apply]                                                  -- `def_real_identity_matrix`
        split_ifs <;> rfl

/-- **人手 `real_matrix_of_real_entry_matrix_preserves_power` の `q = 0`**: `I` の成分はすべて実数
（`(I_{Mat(n,ℝ)})_st` が `def_matrix_with_real_entries` の `r` に当たる）。 -/
theorem identity_matrix_hasRealEntries : MatrixHasRealEntries (1 : Matrix ι ι ℂ) :=
  fun s t => ⟨(1 : Matrix ι ι ℝ) s t, identity_matrix_entry_eq_real_identity_entry s t⟩

variable [Fintype ι] [Nonempty ι]

/-- **人手 `real_matrix_of_real_entry_matrix_preserves_power` の「`A^q` の成分はすべて実数」**（`q` の帰納法。
`q = 0` は `identity_matrix_hasRealEntries`、`q + 1` は `A^{q+1} = A^qA` と `product_of_real_entry_matrices_has_real_entries`
（`A → A^q`, `B → A`））。 -/
theorem matrix_pow_hasRealEntries (A : Matrix ι ι ℂ) (hA : MatrixHasRealEntries A) :
    ∀ q : ℕ, MatrixHasRealEntries (A ^ q)
  | 0 => by
      rw [pow_zero]                                                           -- `def_exp` (1) の `A^0 := I`
      exact identity_matrix_hasRealEntries
  | q + 1 => by
      rw [pow_succ]                                                           -- `def_exp` (1) の `A^{q+1} := A^qA`
      exact matrix_mul_hasRealEntries _ _ (matrix_pow_hasRealEntries A hA q) hA

/-- **人手 `real_matrix_of_real_entry_matrix_preserves_power`**: `(A^q)_ℝ = (A_ℝ)^q`。 -/
theorem real_matrix_of_real_entry_matrix_preserves_power (A : Matrix ι ι ℂ) (hA : MatrixHasRealEntries A) :
    ∀ q : ℕ, realMatrixOfRealEntries (A ^ q) (matrix_pow_hasRealEntries A hA q)
      = realMatrixOfRealEntries A hA ^ q
  | 0 => by
      ext s t
      apply inclusion_rr_to_cc_is_injective                                   -- `a → ((A^0)_ℝ)_st`, `b → ((A_ℝ)^0)_st`
      calc ((realMatrixOfRealEntries (A ^ 0) (matrix_pow_hasRealEntries A hA 0) s t : ℝ) : ℂ)
          = (A ^ 0) s t := ofReal_realMatrixOfRealEntries_apply _ _ s t      -- `def_real_matrix_of_real_entry_matrix`（`B → A^0`）
        _ = (1 : Matrix ι ι ℂ) s t := by rw [pow_zero]                        -- `def_exp` (1) の `A^0 := I`（`K = ℂ`）
        _ = (((1 : Matrix ι ι ℝ) s t : ℝ) : ℂ) :=
            identity_matrix_entry_eq_real_identity_entry s t                  -- 上の鎖
        _ = (((realMatrixOfRealEntries A hA ^ 0) s t : ℝ) : ℂ) := by rw [pow_zero]
                                                                              -- `def_exp` (1) の `(A_ℝ)^0 := I_{Mat(n,ℝ)}`（`K = ℝ`）
  | q + 1 =>
      calc realMatrixOfRealEntries (A ^ (q + 1)) (matrix_pow_hasRealEntries A hA (q + 1))
          = realMatrixOfRealEntries (A ^ q * A)
              (matrix_mul_hasRealEntries _ _ (matrix_pow_hasRealEntries A hA q) hA) :=
            realMatrixOfRealEntries_congr (pow_succ A q) _ _                  -- `def_exp` (1) の `A^{q+1} := A^qA`（`K = ℂ`）
        _ = realMatrixOfRealEntries (A ^ q) (matrix_pow_hasRealEntries A hA q)
              * realMatrixOfRealEntries A hA :=
            real_matrix_of_real_entry_matrix_preserves_product _ _ _ _        -- `real_matrix_of_real_entry_matrix_preserves_product`（`A → A^q`, `B → A`）
        _ = realMatrixOfRealEntries A hA ^ q * realMatrixOfRealEntries A hA := by
            rw [real_matrix_of_real_entry_matrix_preserves_power A hA q]      -- 帰納法の仮定
        _ = realMatrixOfRealEntries A hA ^ (q + 1) := (pow_succ _ q).symm     -- `def_exp` (1) の `(A_ℝ)^{q+1} := (A_ℝ)^qA_ℝ`（`K = ℝ`）

end Ising2D
