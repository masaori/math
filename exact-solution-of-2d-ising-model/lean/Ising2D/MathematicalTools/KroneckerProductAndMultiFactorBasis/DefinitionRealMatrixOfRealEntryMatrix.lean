/-
# 成分がすべて実数の複素行列から実数の行列への写像（定義）と、`ℝ → ℂ` の包含の単射性

正本:
- `structured-latex/content/000_calculation_formulae_00_09.ts`
  （`calc_formulae_claim_inclusion_rr_to_cc_is_injective`、ラベル **`inclusion_rr_to_cc_is_injective`**）
- `structured-latex/content/002_linear_space_general.ts`
  （`linear_space_general_definition_real_matrix_of_real_entry_matrix`、ラベル **`def_real_matrix_of_real_entry_matrix`**）

- 人手の `r_ℂ := ι_{ℝ→ℂ}(r) = (r, 0)`（`inclusion_rr_to_cc`）は Lean の `(r : ℂ)`、その第 1 成分は `Complex.re` である。
- 人手の `Mat^re(m,n,ℂ)`（成分がすべて実数の複素行列の全体）の元 `B` は、Lean では行列 `B` と `MatrixHasRealEntries B`（`def_matrix_with_real_entries`）の証明 `hB` の組で受け取る。
- 人手の `w_pq(B)`（`B_pq = r_ℂ` を満たす `r ∈ ℝ`）は、存在（`hB p q`）から `Classical.choose` で取る。
  人手が `w_pq(B)` を定めるのに使う一意性（`inclusion_rr_to_cc_is_injective`）は、`realMatrixOfRealEntries_apply_eq`
  （`B_pq = r_ℂ` を満たす `r` は `(B_ℝ)_pq` に等しい）で使う。
- 人手の `((B_ℝ)_pq)_ℂ = B_pq` は `ofReal_realMatrixOfRealEntries_apply` である。

必要十分版は置かない。`inclusion_rr_to_cc_is_injective` の証明が使うのは「`ℂ = ℝ²` の二つの元が等しければ第 1 成分が等しい」
ことだけで、取り払える代数の構造（和・積）を使っていない。`def_real_matrix_of_real_entry_matrix` は定義である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries

namespace Ising2D

/-- **人手 `inclusion_rr_to_cc_is_injective`**: `a_ℂ = b_ℂ` なら `a = b`。
人手の鎖 `(a, 0) = a_ℂ = b_ℂ = (b, 0)` の両端の第 1 成分（Lean の `Complex.re`）を比べる。 -/
theorem inclusion_rr_to_cc_is_injective {a b : ℝ} (h : (a : ℂ) = (b : ℂ)) : a = b :=
  calc a
      = (a : ℂ).re := (Complex.ofReal_re a).symm   -- `(a, 0)` の第 1 成分は `a`（`inclusion_rr_to_cc`）
    _ = (b : ℂ).re := congrArg Complex.re h        -- 仮定 `a_ℂ = b_ℂ` の第 1 成分（`definition_of_cc` の `ℝ²` の元の等号）
    _ = b := Complex.ofReal_re b                   -- `(b, 0)` の第 1 成分は `b`（`inclusion_rr_to_cc`）

variable {α β : Type*}

/-- **人手 `def_real_matrix_of_real_entry_matrix` の `ϱ^{m,n}_{ℂ→ℝ}`**: 成分がすべて実数の `B` に、
`(B_ℝ)_pq := w_pq(B)`（`B_pq = r_ℂ` を満たす `r ∈ ℝ`）を成分とする実数の行列 `B_ℝ` を対応させる。 -/
noncomputable def realMatrixOfRealEntries (B : Matrix α β ℂ) (hB : MatrixHasRealEntries B) :
    Matrix α β ℝ :=
  Matrix.of fun p q => Classical.choose (hB p q)

/-- **人手 `def_real_matrix_of_real_entry_matrix` の `((B_ℝ)_pq)_ℂ = B_pq`**（`w_pq(B)` の取り方）。 -/
theorem ofReal_realMatrixOfRealEntries_apply (B : Matrix α β ℂ) (hB : MatrixHasRealEntries B)
    (p : α) (q : β) : ((realMatrixOfRealEntries B hB p q : ℝ) : ℂ) = B p q :=
  (Classical.choose_spec (hB p q)).symm

/-- **人手 `def_real_matrix_of_real_entry_matrix` の一意性の段**: `B_pq = r_ℂ` を満たす `r ∈ ℝ` は `(B_ℝ)_pq` に等しい
（`r_ℂ = B_pq = ((B_ℝ)_pq)_ℂ` に `inclusion_rr_to_cc_is_injective` を当てる）。 -/
theorem realMatrixOfRealEntries_apply_eq (B : Matrix α β ℂ) (hB : MatrixHasRealEntries B)
    {p : α} {q : β} {r : ℝ} (h : B p q = (r : ℂ)) : realMatrixOfRealEntries B hB p q = r :=
  inclusion_rr_to_cc_is_injective ((ofReal_realMatrixOfRealEntries_apply B hB p q).trans h)

end Ising2D
