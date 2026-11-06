/-
# `ε_ℝ := ϱ(ε)`（定義）と `ε_ℝx = x ⟺ ι(x) ∈ 𝓕^{(+)}`

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`

* `maxeig_definition_epsilon_real`（ラベル **`def_epsilon_real`**）
* `maxeig_claim_epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`
  （ラベル **`epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`**）

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| `ε_ℝ := ϱ(ε)`（`epsilon_is_real_symmetric` の成分の実性、`def_real_matrix_of_real_entry_matrix` の `B → ε`） | `epsilonReal n := realMatrixOfRealEntries (epsilon (n + 1)) (epsilon_hasRealEntries n)` |
| `((ε_ℝ)_kl)_ℂ = ε_kl` | `ofReal_epsilonReal_apply` |
| 証明の準備: `epsilon_is_real_symmetric` より `ε ∈ Mat^re`、`def_epsilon_real` より `ε_ℝ = ϱ(ε)` なので `real_vector_inclusion_intertwines_matrix_vector_product`（`B → ε`）が当てはまる | `epsilonReal_intertwines`（`ι(ε_ℝx) = ει(x)`） |
| (⇒) の 2 行の鎖 `ει(x) = ι(ε_ℝx) = ι(x)` と `def_even_eigenvectors_of_epsilon` | 主張の `mp` の `calc` の 2 段 |
| (⇐) の `ει(x) = ι(x)`（仮定と `def_even_eigenvectors_of_epsilon`）、2 行の鎖 `ι(ε_ℝx) = ει(x) = ι(x)` と `real_vector_inclusion_is_injective` | 主張の `mpr` の `hε`、`calc` の 2 段と `real_vector_inclusion_is_injective` |
| 主張 | `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`（人手の `M_col` は Lean の `n + 1`） |

- 人手の `ℝ^{2^{M_col}}`・`ℂ^{2^{M_col}}` は Lean の `Conf (n + 1) → ℝ`・`Conf (n + 1) → ℂ`、`ι^{2^{M_col}}_{ℝ→ℂ}` は `cvec`、
  `𝓕^{(+)}` は `evenEigenvectors (n + 1) hM`（`EvenEigenvectors.lean`）である。
- `def_sector_rayleigh_sup` の Lean の `evenSectorSet` は、`ε` の実数の行列として符号反転の置換行列 `epsilonR`
  （`ClaimEpsilonIsRealSymmetric.lean`）を受け取る。`epsilonR (n + 1) = ε_ℝ` を `epsilonR_eq_epsilonReal` で示し、
  主張を `epsilonR` の形へ移したもの `epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors` を置く（人手の対応する行は無い。
  人手の `ε_ℝ` と Lean の `epsilonR` が同じ行列であることを述べるだけの橋である）。

必要十分版は置かない。主張の中身は `real_vector_inclusion_intertwines_matrix_vector_product` と
`real_vector_inclusion_is_injective` の 2 つを 1 回ずつ当てることに尽き、`ε` について使う性質は成分が実数であることだけである。
-/
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonIsRealSymmetric
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealVectorInclusion
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.EvenEigenvectors

namespace Ising2D

open Matrix

/-- **人手 `def_epsilon_real`**: `ε_ℝ := ϱ^{2^{M_col},2^{M_col}}_{ℂ→ℝ}(ε)`（人手の `M_col` は `n + 1`。
成分の実性は `epsilon_is_real_symmetric` の前半 `epsilon_hasRealEntries`）。 -/
noncomputable def epsilonReal (n : ℕ) : Matrix (Conf (n + 1)) (Conf (n + 1)) ℝ :=
  realMatrixOfRealEntries (epsilon (n + 1)) (epsilon_hasRealEntries n)

/-- 人手 `def_epsilon_real` の `((ε_ℝ)_kl)_ℂ = ε_kl`。 -/
theorem ofReal_epsilonReal_apply (n : ℕ) (k l : Conf (n + 1)) :
    ((epsilonReal n k l : ℝ) : ℂ) = epsilon (n + 1) k l :=
  ofReal_realMatrixOfRealEntries_apply _ _ k l

/-- 人手の証明の準備: `real_vector_inclusion_intertwines_matrix_vector_product`（`m, n → 2^{M_col}`, `B → ε`）。 -/
theorem epsilonReal_intertwines (n : ℕ) (x : Conf (n + 1) → ℝ) :
    cvec (epsilonReal n *ᵥ x) = epsilon (n + 1) *ᵥ cvec x :=
  real_vector_inclusion_intertwines_matrix_vector_product _ (epsilon_hasRealEntries n) x

/-- **人手 `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`**:
`ε_ℝx = x ⟺ ι^{2^{M_col}}_{ℝ→ℂ}(x) ∈ 𝓕^{(+)}`（人手の `M_col` は `n + 1`）。 -/
theorem epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors (n : ℕ) (hM : 1 ≤ n + 1)
    (x : Conf (n + 1) → ℝ) :
    epsilonReal n *ᵥ x = x ↔ cvec x ∈ evenEigenvectors (n + 1) hM := by
  constructor
  · intro h
    show epsilon (n + 1) *ᵥ cvec x = cvec x                    -- `def_even_eigenvectors_of_epsilon`（`f → ι(x)`）
    calc epsilon (n + 1) *ᵥ cvec x
        = cvec (epsilonReal n *ᵥ x) := (epsilonReal_intertwines n x).symm
                                                              -- `real_vector_inclusion_intertwines_matrix_vector_product` を右辺から左辺へ
      _ = cvec x := by rw [h]                                 -- 仮定 `ε_ℝx = x`
  · intro h
    have hε : epsilon (n + 1) *ᵥ cvec x = cvec x := h         -- 仮定と `def_even_eigenvectors_of_epsilon`（`f → ι(x)`）
    apply real_vector_inclusion_is_injective                  -- `x → ε_ℝx`, `y → x`
    calc cvec (epsilonReal n *ᵥ x)
        = epsilon (n + 1) *ᵥ cvec x := epsilonReal_intertwines n x
                                                              -- `real_vector_inclusion_intertwines_matrix_vector_product`
      _ = cvec x := hε                                        -- 仮定から得た `ει(x) = ι(x)`

/-- 人手の `ε_ℝ` と、`evenSectorSet` が受け取る符号反転の置換行列 `epsilonR` は同じ行列である
（成分ごとに `epsilon_eq_ofReal_epsilonR` と `def_real_matrix_of_real_entry_matrix` の一意性の段）。 -/
theorem epsilonR_eq_epsilonReal (n : ℕ) : epsilonR (n + 1) = epsilonReal n := by
  ext k l
  exact (realMatrixOfRealEntries_apply_eq _ _ (epsilon_eq_ofReal_epsilonR k l)).symm

/-- `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors` を `evenSectorSet` の `epsilonR` の形へ移したもの。 -/
theorem epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors (n : ℕ) (hM : 1 ≤ n + 1)
    (x : Conf (n + 1) → ℝ) :
    epsilonR (n + 1) *ᵥ x = x ↔ cvec x ∈ evenEigenvectors (n + 1) hM := by
  rw [epsilonR_eq_epsilonReal]
  exact epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors n hM x

end Ising2D
