/-
# 成分がすべて実数の複素行列から実数の行列への写像（定義）と、`ℝ → ℂ` の包含の単射性

正本:
- `structured-latex/content/000_calculation_formulae_00_09.ts`
  （`calc_formulae_claim_inclusion_rr_to_cc_is_injective`、ラベル **`inclusion_rr_to_cc_is_injective`**）
- `structured-latex/content/002_linear_space_general.ts`
  （`linear_space_general_definition_real_matrix_of_real_entry_matrix`、ラベル **`def_real_matrix_of_real_entry_matrix`**）

- 人手の `r_ℂ := ι_{ℝ→ℂ}(r) = (r, 0)`（`inclusion_rr_to_cc`）は Lean の `(r : ℂ)` で、`(r : ℂ) = ⟨r, 0⟩` は `complex_ofReal_eq_mk`、
  `𝐂 = 𝐑²` の二つの元の等号を成分ごとに見るのは `complex_mk_eq_mk_iff` である（`DefinitionComplexNumbers.lean`）。
- 人手の `Mat^re(m,n,ℂ)`（成分がすべて実数の複素行列の全体）の元 `B` は、Lean では行列 `B` と `MatrixHasRealEntries B`（`def_matrix_with_real_entries`）の証明 `hB` の組で受け取る。
- 人手の `w_pq(B)`（`B_pq = r_ℂ` を満たす `r ∈ ℝ`）は、存在（`hB p q`）から `Classical.choose` で取る。
  人手が `w_pq(B)` を定めるのに使う一意性（`inclusion_rr_to_cc_is_injective`）は、`realMatrixOfRealEntries_apply_eq`
  （`B_pq = r_ℂ` を満たす `r` は `(B_ℝ)_pq` に等しい）で使う。
- 人手の `((B_ℝ)_pq)_ℂ = B_pq` は `ofReal_realMatrixOfRealEntries_apply` である。

必要十分版は置かない。`inclusion_rr_to_cc_is_injective` の証明が使うのは「`ℂ = ℝ²` の二つの元が等しければ第 1 成分が等しい」
ことだけで、取り払える代数の構造（和・積）を使っていない。`def_real_matrix_of_real_entry_matrix` は定義である。
-/
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.DefinitionMatrixWithRealEntries
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.DefinitionComplexNumbers

namespace Ising2D

/-- **人手 `inclusion_rr_to_cc_is_injective`**: `a_ℂ = b_ℂ` なら `a = b`。
人手の鎖 `(a, 0) = a_ℂ = b_ℂ = (b, 0)` を作り、`𝐂 = 𝐑²` の二つの元の等号（`complex_mk_eq_mk_iff`）から第 1 成分を比べる。 -/
theorem inclusion_rr_to_cc_is_injective {a b : ℝ} (h : (a : ℂ) = (b : ℂ)) : a = b :=
  have hpair : (⟨a, 0⟩ : ℂ) = ⟨b, 0⟩ :=
    calc (⟨a, 0⟩ : ℂ)
        = (a : ℂ) := (complex_ofReal_eq_mk a).symm  -- `inclusion_rr_to_cc`（`x → a`）
      _ = (b : ℂ) := h                             -- 仮定
      _ = ⟨b, 0⟩ := complex_ofReal_eq_mk b         -- `inclusion_rr_to_cc`（`x → b`）
  ((complex_mk_eq_mk_iff a 0 b 0).mp hpair).1      -- `definition_of_cc` の `𝐑²` の元の等号の第 1 成分

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
