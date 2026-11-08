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
| `‖x^{(+)}‖² = (√Σ_i\|x_i\|²)² = ⋯ = 1^{M_col} = 1` の 14 行の鎖 | `vecNorm_sq_evenUnit_succ` の `calc`（14 段と、添字の個数を `2^{M_col}` に読み替える Lean だけの 1 段） |
| `‖x^{(+)}‖ ∈ ℝ_{≥0}`、`‖x^{(+)}‖ = 0` なら `1 = ⋯ = 0` の 4 行の鎖、`‖x^{(+)}‖^2 = 1 = 1·1 = 1^2` の 3 行の鎖と `positive_real_square_injective` で `‖x^{(+)}‖ = 1` | `vecNorm_evenUnit_succ`（`calc` の 4 段と 3 段） |
| 空でない（`(x^{(+)})ᵀW_ℝx^{(+)} ∈ 𝓡_+`） | `evenSectorSet_epsilonR_nonempty` |

- 人手の `M_col ≥ 1` は Lean の `n + 1` である。人手の `ν(I)` は Lean の `I : Conf (n + 1)`（`vecKron` の冒頭の注意と同じ）。
- 人手の `ε = σ^x⊠⋯⊠σ^x`（`epsilon_square_and_eigenvalues` の証明で得た表示）は `epsilon_eq_siteProd`、
  `kronecker_product_rule` (3) は `kronecker_product_rule_mulVec`、`real_inclusion_preserves_finite_product` は同名の具体版である。
- `σ^x b_+` の 1 段目（行列と数ベクトルの積と `σ^x` の成分）は、2 つの成分ごとに `pauliX` の成分と `Fin 2` の和を開いて読む。

## 人手証明と 1 対 1 にならない箇所

* 人手のノルムの鎖は `i ∈ {1,…,2^{M_col}}` の上の和で書き、和の個数を上端の `2^{M_col}` で読む。Lean の和は `I : Conf (n + 1)` の上の和なので、
  `finite_sum_of_constant_real_number` の段の後に、添字の個数を `2^{M_col}` に読み替える段（`card_conf_nat`）が 1 つ多い。
  1 段目の `def_matrix_norm` は、Lean の `vecNorm x = √(x ⬝ᵥ x)` を `√(Σ|x_i|^2)` に書く `square_of_real_absolute_value` を含む（`ClaimNormOfNormalizedRealVectorIsOne.lean` の `vecNorm_sq_eq_sum_abs_sq` と同じ）。
* Lean の通しの定理は `M` を一般に取るので、`evenSectorSet_epsilonR_nonempty` は `M = 0` も扱う。
  人手は `M_col ≥ 1` なので `M = 0` の行は無い。`M = 0` の `ε_ℝx^{(+)} = x^{(+)}`（`epsilonR_zero_mulVec_evenUnit`）は、
  `ε` が符号反転の置換行列であること（`epsilonR_mulVec_apply`）と `x^{(+)}` の成分が添字に依らないことから示す。
  同じ理由で、各成分の値の `M = 0` の行（空の積は `1 = (1/√2)^0`）も人手に無く、`evenUnit_apply` の `zero` の節だけが扱う。
  ノルムの `M = 0` の行も人手に無く、`vecNorm_evenUnit` の `zero` の節だけが扱う。

必要十分版はない（`sSup` は ℝ の完備性そのものなので、ほどく余地がない。章 011 の
`ThermodynamicLimit/RowLimitAndMaxEigenvalue/DefinitionRayleighSup.lean` と同じ）。
-/
import Ising2D.ThermodynamicLimit.RowLimitAndMaxEigenvalue.DefinitionRayleighSup
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonIsRealSymmetric
import Ising2D.ThermodynamicLimit.ColumnLimitAndClosedForm.ClaimEpsilonRealFixedVectorIffInclusionInEvenEigenvectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimKroneckerProductRuleOnVectors
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteProductOfConstantRealIsPower
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimProductOfRealPowersIsPowerOfProduct
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimPowerOfRealOneIsOne
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimInclusionOfIntegersIntoRealNumbers
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimSquareOfRealAbsoluteValueAndOfRealSum
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimPositiveRealSquareInjective

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

section General

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- **人手本文 `def_sector_rayleigh_sup` の `𝓡_+`**:
`{xᵀW_ℝx | x ∈ ℝ^{2^M}, ε_ℝx = x, ‖x‖ = 1}`。 -/
def evenSectorSet (W ε : Matrix n n ℝ) : Set ℝ :=
  {r | ∃ x : n → ℝ, ε *ᵥ x = x ∧ vecNorm x = 1 ∧ r = x ⬝ᵥ W *ᵥ x}

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
    (hx : ε *ᵥ x = x) (hx1 : vecNorm x = 1) :
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

/-- 人手の `‖x^{(+)}‖² = 1` の 14 行の鎖（人手の `M_col` は `n + 1`、`ν(I)` は `I : Conf (n + 1)`）。 -/
theorem vecNorm_sq_evenUnit_succ (n : ℕ) : vecNorm (evenUnit (n + 1)) ^ 2 = 1 := by
  have hcard : 1 ≤ Fintype.card (Conf (n + 1)) := by
    rw [card_conf_nat]; exact power_of_two_in_integers_is_at_least_one (n + 1)
  have h2 : (0 : ℝ) ≤ 2 := by norm_num
  have h2ne : (2 : ℝ) ≠ 0 := by norm_num
  calc vecNorm (evenUnit (n + 1)) ^ 2
      = (Real.sqrt (∑ I, |evenUnit (n + 1) I| ^ 2)) ^ 2 := by
        rw [vecNorm, vecNormSq_eq_sum]
        simp only [square_of_real_absolute_value]
                          -- `def_matrix_norm` の数ベクトルのノルム（`w → x^{(+)}`）。`square_of_real_absolute_value` は書き方の差を埋める段
    _ = ∑ I, |evenUnit (n + 1) I| ^ 2 :=
        Real.sq_sqrt (Finset.sum_nonneg fun I _ => sq_nonneg _)
                          -- `definition_of_sqrt_r_positive` の `y^2 = x`（根号の中は非負実数の有限和）
    _ = ∑ I, (evenUnit (n + 1) I) ^ 2 :=
        Finset.sum_congr rfl fun I _ => square_of_real_absolute_value _
                          -- `square_of_real_absolute_value`（`q → (x^{(+)})_i`）を `2^{M_col}` 個の項へ同時に
    _ = ∑ _I : Conf (n + 1), ((1 / Real.sqrt 2) ^ (n + 1)) ^ 2 :=
        Finset.sum_congr rfl fun I _ => by rw [evenUnit_apply_succ n I]
                          -- 各成分の値（`evenUnit_apply_succ`）を `2^{M_col}` 個の項へ同時に
    _ = (Fintype.card (Conf (n + 1)) : ℝ) * ((1 / Real.sqrt 2) ^ (n + 1)) ^ 2 :=
        finite_sum_of_constant_real_number_fintype hcard _
                          -- `finite_sum_of_constant_real_number`（`m → 2_ℤ^{M_col}`、`r → ((1/√2)^{M_col})^2`）
    _ = ((2 ^ (n + 1) : ℕ) : ℝ) * ((1 / Real.sqrt 2) ^ (n + 1)) ^ 2 := by
        rw [card_conf_nat]
                          -- 添字の個数 `#𝓘_{M_col} = 2_ℤ^{M_col}`（人手は和の上端の `2^{M_col}` で書くので、Lean だけの読み替えの段）
    _ = (2 : ℝ) ^ (n + 1) * ((1 / Real.sqrt 2) ^ (n + 1)) ^ 2 := by
        rw [inclusion_zz_to_rr_of_power_of_two]
                          -- `inclusion_zz_to_rr_of_power_of_two`（`M → M_col`）
    _ = (2 : ℝ) ^ (n + 1) * ((1 / Real.sqrt 2) ^ (n + 1) * (1 / Real.sqrt 2) ^ (n + 1)) := by
        rw [pow_two]      -- `r^2 := r r`（`r → (1/√2)^{M_col}`）
    _ = (2 : ℝ) ^ (n + 1) * (1 / Real.sqrt 2 * (1 / Real.sqrt 2)) ^ (n + 1) := by
        rw [product_of_real_powers_is_power_of_product]
                          -- `product_of_real_powers_is_power_of_product`（`a, b → 1/√2`、`m → M_col`）
    _ = (2 : ℝ) ^ (n + 1) * (1 / (Real.sqrt 2 * Real.sqrt 2)) ^ (n + 1) := by
        rw [one_div_mul_one_div]
                          -- ℝ で `(1/p)(1/q) = 1/(pq)`（`p, q → √2`）
    _ = (2 : ℝ) ^ (n + 1) * (1 / Real.sqrt 2 ^ 2) ^ (n + 1) := by
        rw [← pow_two]    -- `r^2 := r r`（`r → √2`）を右辺から左辺へ
    _ = (2 : ℝ) ^ (n + 1) * (1 / 2) ^ (n + 1) := by
        rw [Real.sq_sqrt h2]
                          -- `definition_of_sqrt_r_positive` の `y^2 = x`（`x → 2_ℝ`）
    _ = (2 * (1 / 2) : ℝ) ^ (n + 1) :=
        product_of_real_powers_is_power_of_product (n + 1) 2 (1 / 2)
                          -- `product_of_real_powers_is_power_of_product`（`a → 2_ℝ`、`b → 1/2_ℝ`、`m → M_col`）
    _ = (1 : ℝ) ^ (n + 1) := by
        rw [mul_one_div_cancel h2ne]
                          -- ℝ で `p · (1/p) = 1`（`p → 2_ℝ ≠ 0`）
    _ = 1 := power_of_real_one_is_one (n + 1)
                          -- `power_of_real_one_is_one`（`m → M_col`）

/-- 人手の「`‖x^{(+)}‖^2 = 1` から `‖x^{(+)}‖ = 1`」（人手の `M_col` は `n + 1`）: `‖x^{(+)}‖ ∈ ℝ_{≥0}`（`def_matrix_norm`）、
`‖x^{(+)}‖ = 0` なら `1 = ‖x^{(+)}‖^2 = ‖x^{(+)}‖‖x^{(+)}‖ = 0·0 = 0` の 4 行の鎖で矛盾、`‖x^{(+)}‖^2 = 1 = 1·1 = 1^2` の 3 行の鎖と
`positive_real_square_injective`（`a → ‖x^{(+)}‖`、`b → 1`、`⇒`）。 -/
theorem vecNorm_evenUnit_succ (n : ℕ) : vecNorm (evenUnit (n + 1)) = 1 := by
  have hge : 0 ≤ vecNorm (evenUnit (n + 1)) := vecNorm_nonneg _          -- `def_matrix_norm` より `‖x^{(+)}‖ ∈ ℝ_{≥0}`
  have hne : vecNorm (evenUnit (n + 1)) ≠ 0 := by
    intro h0
    have h10 : (1 : ℝ) = 0 :=
      calc (1 : ℝ)
          = vecNorm (evenUnit (n + 1)) ^ 2 := (vecNorm_sq_evenUnit_succ n).symm
                                              -- 上のノルムの鎖を右辺から左辺へ
        _ = vecNorm (evenUnit (n + 1)) * vecNorm (evenUnit (n + 1)) := pow_two _
                                              -- `r^2 := r r`（`r → ‖x^{(+)}‖`）
        _ = 0 * 0 := by rw [h0]               -- `‖x^{(+)}‖ = 0` を両方の因子へ同時に適用
        _ = 0 := zero_mul 0                   -- ℝ で `0 · 0 = 0`
    exact one_ne_zero h10                     -- ℝ で `1 ≠ 0` に反する
  have hpos : 0 < vecNorm (evenUnit (n + 1)) := lt_of_le_of_ne hge (Ne.symm hne)
                                              -- `‖x^{(+)}‖ ∈ ℝ_{≥0}` と `‖x^{(+)}‖ ≠ 0` で `‖x^{(+)}‖ ∈ ℝ_{>0}`
  have hsq : vecNorm (evenUnit (n + 1)) ^ 2 = (1 : ℝ) ^ 2 :=
    calc vecNorm (evenUnit (n + 1)) ^ 2
        = 1 := vecNorm_sq_evenUnit_succ n     -- 上のノルムの鎖
      _ = 1 * 1 := (mul_one 1).symm           -- ℝ で `1 · 1 = 1` を右辺から左辺へ
      _ = (1 : ℝ) ^ 2 := (pow_two 1).symm     -- `r^2 := r r`（`r → 1`）を右辺から左辺へ
  exact (positive_real_square_injective hpos one_pos).mp hsq
                                              -- `positive_real_square_injective`（`a → ‖x^{(+)}‖`、`b → 1`、`⇒`）

/-- `‖x^{(+)}‖ = 1`。`M ≥ 1` は人手の `vecNorm_evenUnit_succ`、`M = 0`（`x^{(+)}` は成分 `1` の 1 成分のベクトル）は人手に無い（冒頭の注意）。 -/
theorem vecNorm_evenUnit : vecNorm (evenUnit M) = 1 := by
  cases M with
  | zero =>
    rw [vecNorm, vecNormSq_eq_sum]
    simp [evenUnit_apply]
  | succ n => exact vecNorm_evenUnit_succ n

/-- **人手 `def_sector_rayleigh_sup` の「`𝓡_+ ≠ ∅`」**: `(x^{(+)})ᵀW_ℝx^{(+)} ∈ 𝓡_+`。 -/
theorem evenSectorSet_epsilonR_nonempty (W : Matrix (Conf M) (Conf M) ℝ) :
    (evenSectorSet W (epsilonR M)).Nonempty := by
  cases M with
  | zero => exact ⟨_, evenUnit 0, epsilonR_zero_mulVec_evenUnit, vecNorm_evenUnit, rfl⟩
  | succ n => exact ⟨_, evenUnit (n + 1), epsilonR_mulVec_evenUnit n, vecNorm_evenUnit, rfl⟩

end Ising2D
