/-
# `c_+(M) := sup 𝓡_+`（偶セクターでの Rayleigh 商の上限）の定義

正本: `structured-latex/content/thermodynamic_limit_column_limit_and_closed_form.ts`
（`maxeig_010a_definition_sector_rayleigh_sup`、ラベル **`def_sector_rayleigh_sup`**）

人手の定義（`M_col ∈ ℤ_{≥1}`）:

  `𝓡_+ := { xᵀW_ℝx | x ∈ ℝ^{2^M}, ε_ℝx = x, ‖x‖ = 1 }`,  `c_+(M) := sup 𝓡_+`

と、上限が定まること（`𝓡_+` が空でなく上に有界であること）。`W_ℝ` は `def_W_real` の実数の行列、
`ε_ℝ` は `def_epsilon_real` の実数の行列、
`xᵀW_ℝx` は `def_real_bilinear_value` の実数の値で、`def_rayleigh_sup` の `𝓡` の元と同じ式である。
Lean の `x ⬝ᵥ W *ᵥ x` を人手の和の形へ開くのは `dotProduct_mulVec_eq_real_bilinear_value`
（`MathematicalTools/TraceConjugateTransposeAndPositiveDefiniteness/RealMatrixBilinearFormAndNorm.lean`）である。
Lean の `evenSectorSet W ε` は実数の行列 `W`・`ε` を受け取り、Ising では `W := physicalSymTransferR`
（`W_ℝ` の具体形。`physicalSymTransferR_eq_realMatrixOfRealEntries`）、`ε := epsilonR M`
（`ε_ℝ` と同じ行列であることは `epsilonR_eq_epsilonReal`）で使う。

## 人手証明との対応

| 人手 | 本ファイル |
| --- | --- |
| `𝓡_+`, `c_+(M)` | `evenSectorSet W ε`, `evenSectorRayleighSup W ε`（Ising では `ε := epsilonR M`） |
| 上に有界（`𝓡_+ ⊆ 𝓡`） | `evenSectorSet_subset` / `evenSectorSet_bddAbove` |
| `a_+ ∈ ℝ^2`、`b_+ := ι^2(a_+)` | `aPlus`、`cvec aPlus` |
| `σ^x b_+ = b_+` の 3 行の鎖 | `pauliX_mulVec_cvec_aPlus` の `calc` の 3 段 |
| `x^{(+)}`（成分 `Π_k (a_+)_{i_k}`） | `evenUnit` |
| 各成分の値 `(x^{(+)})_{ν(I)} = Π_k (a_+)_{i_k} = Π_k 1/√2 = (1/√2)^{M_col}` の 3 行の鎖 | `evenUnit_apply_succ` の `calc` の 3 段 |
| `ι(x^{(+)})_{ν(I)} = (b_+⊠⋯⊠b_+)_{ν(I)}` の 5 行の鎖 | `cvec_evenUnit` の `calc` の 5 段 |
| `ει(x^{(+)}) = ι(x^{(+)})` の 5 行の鎖 | `epsilon_mulVec_cvec_evenUnit` の `calc` の 5 段 |
| `def_even_eigenvectors_of_epsilon` と `epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors`（`⇐`）で `ε_ℝx^{(+)} = x^{(+)}` | `epsilonR_mulVec_evenUnit`（`epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors` の `mpr`） |
| `‖x^{(+)}‖² = Σ_I ((1/√2)^{M_col})² = 2^M · 2^{-M} = 1` | `vecNormSq_evenUnit`（各成分の値は `evenUnit_apply`） |
| 空でない（`(x^{(+)})ᵀW_ℝx^{(+)} ∈ 𝓡_+`） | `evenSectorSet_epsilonR_nonempty` |

- 人手の `M_col ≥ 1` は Lean の `n + 1` である。人手の `ν(I)` は Lean の `I : Conf (n + 1)`（`vecKron` の冒頭の注意と同じ）。
- 人手の `ε = σ^x⊠⋯⊠σ^x`（`epsilon_square_and_eigenvalues` の証明で得た表示）は `epsilon_eq_siteProd`、
  `kronecker_product_rule` (3) は `kronecker_product_rule_mulVec`、`real_inclusion_preserves_finite_product` は同名の具体版である。
- `σ^x b_+` の 1 段目（行列と数ベクトルの積と `σ^x` の成分）は、2 つの成分ごとに `pauliX` の成分と `Fin 2` の和を開いて読む。

## 人手証明と 1 対 1 にならない箇所

* ノルムの鎖 `vecNormSq_evenUnit` は、まだ人手の 3 行と 1 対 1 の `calc` になっていない（状態台帳の (cl3b)）。
* Lean の通しの定理は `M` を一般に取るので、`evenSectorSet_epsilonR_nonempty` は `M = 0` も扱う。
  人手は `M_col ≥ 1` なので `M = 0` の行は無い。`M = 0` の `ε_ℝx^{(+)} = x^{(+)}`（`epsilonR_zero_mulVec_evenUnit`）は、
  `ε` が符号反転の置換行列であること（`epsilonR_mulVec_apply`）と `x^{(+)}` の成分が添字に依らないことから示す。
  同じ理由で、各成分の値の `M = 0` の行（空の積は `1 = (1/√2)^0`）も人手に無く、`evenUnit_apply` の `zero` の節だけが扱う。

必要十分版はない（`sSup` は ℝ の完備性そのものなので、ほどく余地がない。章 011 の
`ThermodynamicLimit/RowLimitAndMaxEigenvalue/DefinitionRayleighSup.lean` と同じ）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonIsRealSymmetric
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerProductRuleOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfConstantRealIsPower

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

section General

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手本文 `def_sector_rayleigh_sup` の `𝓡_+`**:
`{xᵀW_ℝx | x ∈ ℝ^{2^M}, ε_ℝx = x, ‖x‖ = 1}`。 -/
def evenSectorSet (W ε : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = x ∧ vecNormSq x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

/-- **人手本文 `def_sector_rayleigh_sup` の `c_+(M) := sup 𝓡_+`**。 -/
noncomputable def evenSectorRayleighSup (W ε : Matrix n n ℝ) : ℝ := sSup (evenSectorSet W ε)

/-- 人手の「`𝓡_+` の元 `xᵀW_ℝx` は、`x ∈ ℝ^{2^M}`、`‖x‖ = 1` なので同じ式で `𝓡` の元」（`𝓡_+ ⊆ 𝓡`）。 -/
theorem evenSectorSet_subset (W ε : Matrix n n ℝ) : evenSectorSet W ε ⊆ rayleighSet W := by
  rintro r ⟨x, _, hx, rfl⟩
  exact ⟨x, hx, rfl⟩

/-- 人手の「`𝓡_+` は上に有界」（`𝓡_+ ⊆ 𝓡` と `𝓡` の有界性）。`W` に仮定を置かない。 -/
theorem evenSectorSet_bddAbove (W ε : Matrix n n ℝ) :
    BddAbove (evenSectorSet W ε) :=
  (rayleighSet_bddAbove W).mono (evenSectorSet_subset W ε)

/-- 偶セクターの単位ベクトルに対する `xᵀW_ℝx ≤ c_+(M)`（上限の定義そのもの）。 -/
theorem le_evenSectorRayleighSup {W : Matrix n n ℝ} {ε : Matrix n n ℝ} {x : n → ℝ}
    (hx : ε *ᵥ x = x) (hx1 : vecNormSq x = 1) :
    x ⬝ᵥ W *ᵥ x ≤ evenSectorRayleighSup W ε :=
  le_csSup (evenSectorSet_bddAbove W ε) ⟨x, hx, hx1, rfl⟩

end General

/-! ## `𝓡_+` は空でない（Ising の `ε`） -/

variable {M : ℕ}

/-- 人手の `a_+ := (1/√2, 1/√2)^⊤ ∈ ℝ^2`。 -/
noncomputable def aPlus : Fin 2 → ℝ := fun _ => 1 / Real.sqrt 2

/-- 人手の `σ^x b_+ = b_+`（`b_+ := ι^2(a_+)`）。 -/
theorem pauliX_mulVec_cvec_aPlus : pauliX *ᵥ cvec aPlus = cvec aPlus := by
  funext i
  calc (pauliX *ᵥ cvec aPlus) i
      = ![cvec aPlus 1, cvec aPlus 0] i := by
        fin_cases i <;> simp [pauliX, mulVec, dotProduct, Fin.sum_univ_two]
                                            -- `mat_mult` の行列と数ベクトルの積と `σ^x` の成分
    _ = ![cvec aPlus 0, cvec aPlus 1] i := rfl
                                            -- `(b_+)_1 = (1/√2)_ℂ = (b_+)_2`（`def_real_vector_inclusion`）
    _ = cvec aPlus i := by fin_cases i <;> rfl
                                            -- 数ベクトルを成分で書いた

/-- 人手の `x^{(+)}`: `(x^{(+)})_{ν(I)} := Π_{k=1}^{M} (a_+)_{i_k}`（`def_finite_product_of_real_numbers`）。 -/
noncomputable def evenUnit (M : ℕ) : Conf M → ℝ := fun I => ∏ k, aPlus (I k)

/-- 人手の `x^{(+)}` の各成分の値の 3 行の鎖 `(x^{(+)})_{ν(I)} = Π_k (a_+)_{i_k} = Π_k 1/√2 = (1/√2)^{M_col}`
（人手の `M_col` は `n + 1`）。 -/
theorem evenUnit_apply_succ (n : ℕ) (I : Conf (n + 1)) :
    evenUnit (n + 1) I = (1 / Real.sqrt 2) ^ (n + 1) :=
  calc evenUnit (n + 1) I
      = ∏ k, aPlus (I k) := rfl                                -- `x^{(+)}` の定義
    _ = ∏ _k : Fin (n + 1), 1 / Real.sqrt 2 := rfl             -- `a_+` の定義の `(a_+)_1 = 1/√2 = (a_+)_2` を各因子へ同時に適用
    _ = (1 / Real.sqrt 2) ^ (n + 1) :=
          finite_product_of_constant_real_is_power n _         -- `finite_product_of_constant_real_is_power`（`m → M_col`、`r → 1/√2`）

/-- `x^{(+)}` の各成分は `(1/√2)^M`。`M ≥ 1` は人手の鎖 `evenUnit_apply_succ`、`M = 0`（空の積は `1`）は人手に無い（冒頭の注意）。 -/
theorem evenUnit_apply (I : Conf M) : evenUnit M I = (1 / Real.sqrt 2) ^ M := by
  cases M with
  | zero => exact (Finset.prod_empty).trans (pow_zero _).symm
  | succ n => exact evenUnit_apply_succ n I

/-- 人手の `ι^{2^M}(x^{(+)}) = b_+⊠⋯⊠b_+`（成分の 5 行の鎖。人手の `M_col` は `n + 1`）。 -/
theorem cvec_evenUnit (n : ℕ) :
    cvec (evenUnit (n + 1)) = vecKron (n + 1) (fun _ => cvec aPlus) := by
  funext I
  calc cvec (evenUnit (n + 1)) I
      = ((evenUnit (n + 1) I : ℝ) : ℂ) := rfl          -- `def_real_vector_inclusion`（`x → x^{(+)}`）
    _ = ((∏ k, aPlus (I k) : ℝ) : ℂ) := rfl             -- `x^{(+)}` の定義
    _ = ∏ k, ((aPlus (I k) : ℝ) : ℂ) :=
          (real_inclusion_preserves_finite_product n (fun k => aPlus (I k))).symm
                                                        -- `real_inclusion_preserves_finite_product` を右辺から左辺へ
    _ = ∏ k, cvec aPlus (I k) := rfl                    -- `def_real_vector_inclusion`（`x → a_+`）を各因子へ
    _ = vecKron (n + 1) (fun _ => cvec aPlus) I := rfl  -- `def_kronecker` (1)（`v_k → b_+`）を右辺から左辺へ

/-- 人手の `ε ι(x^{(+)}) = ι(x^{(+)})`（人手の `M_col` は `n + 1`）。 -/
theorem epsilon_mulVec_cvec_evenUnit (n : ℕ) :
    epsilon (n + 1) *ᵥ cvec (evenUnit (n + 1)) = cvec (evenUnit (n + 1)) :=
  calc epsilon (n + 1) *ᵥ cvec (evenUnit (n + 1))
      = siteProd (n + 1) (fun _ => pauliX) *ᵥ cvec (evenUnit (n + 1)) := by
        rw [epsilon_eq_siteProd]          -- `epsilon_square_and_eigenvalues` の証明で得た表示
    _ = siteProd (n + 1) (fun _ => pauliX) *ᵥ vecKron (n + 1) (fun _ => cvec aPlus) := by
        rw [cvec_evenUnit]                -- `ι(x^{(+)}) = b_+⊠⋯⊠b_+`
    _ = vecKron (n + 1) (fun _ => pauliX *ᵥ cvec aPlus) :=
          kronecker_product_rule_mulVec n _ _              -- `kronecker_product_rule` (3)
    _ = vecKron (n + 1) (fun _ => cvec aPlus) := by
          rw [pauliX_mulVec_cvec_aPlus]                   -- `σ^x b_+ = b_+` を各因子へ同時に適用
    _ = cvec (evenUnit (n + 1)) := (cvec_evenUnit n).symm
                                            -- `ι(x^{(+)}) = b_+⊠⋯⊠b_+` を右辺から左辺へ

/-- 人手の `ε_ℝ x^{(+)} = x^{(+)}`: `ι(x^{(+)}) ∈ 𝓕^{(+)}`（`def_even_eigenvectors_of_epsilon`）と
`epsilon_real_fixed_vector_iff_inclusion_in_even_eigenvectors` の `⇐`（人手の `M_col` は `n + 1`）。 -/
theorem epsilonR_mulVec_evenUnit (n : ℕ) :
    epsilonR (n + 1) *ᵥ evenUnit (n + 1) = evenUnit (n + 1) :=
  (epsilonR_mulVec_eq_self_iff_cvec_mem_evenEigenvectors n (Nat.le_add_left 1 n) _).mpr
    (epsilon_mulVec_cvec_evenUnit n)

/-- `M = 0` の `ε_ℝ x^{(+)} = x^{(+)}`（人手は `M_col ≥ 1` なので対応する行は無い。冒頭の注意）。 -/
theorem epsilonR_zero_mulVec_evenUnit : epsilonR 0 *ᵥ evenUnit 0 = evenUnit 0 := by
  funext k
  rw [epsilonR_mulVec_apply]
  rfl

/-- 人手の `‖x^{(+)}‖² = ∑_I ((1/√2)^M)² = 2^M · 2^{-M} = 1`。 -/
theorem vecNormSq_evenUnit : vecNormSq (evenUnit M) = 1 := by
  rw [vecNormSq_eq_sum]
  simp only [evenUnit_apply, one_div, Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  rw [card_conf, ← pow_mul, mul_comm M 2, pow_mul, inv_pow, Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2),
    inv_pow, mul_inv_cancel₀ (pow_ne_zero _ (by norm_num))]

/-- **人手 `def_sector_rayleigh_sup` の「`𝓡_+ ≠ ∅`」**: `(x^{(+)})ᵀW_ℝx^{(+)} ∈ 𝓡_+`。 -/
theorem evenSectorSet_epsilonR_nonempty (W : Matrix (Conf M) (Conf M) ℝ) :
    (evenSectorSet W (epsilonR M)).Nonempty := by
  cases M with
  | zero => exact ⟨_, evenUnit 0, epsilonR_zero_mulVec_evenUnit, vecNormSq_evenUnit, rfl⟩
  | succ n => exact ⟨_, evenUnit (n + 1), epsilonR_mulVec_evenUnit n, vecNormSq_evenUnit, rfl⟩

end Ising2D
