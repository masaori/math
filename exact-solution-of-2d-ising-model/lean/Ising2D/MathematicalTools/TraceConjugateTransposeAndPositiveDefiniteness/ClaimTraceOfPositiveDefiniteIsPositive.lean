/-
# 正定値行列のトレースは正（**具体版**）

対応する人手証明のラベル: `trace_of_positive_definite_is_positive`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_trace_of_positive_definite_is_positive`）。
人手の `x^*Ay` は `def_conjugate_bilinear_value`、正定値は `def_hermitian_positive_definite` による。

**必要十分版**: `Ising2D/NecSuf/TraceOfPositiveDefinite.lean`。具体版をその系として導くのは
`ClaimTraceOfPositiveDefiniteIsPositiveFromNecSuf.lean`（`TensorPow M` の系もそこに置く）。

## 人手証明との対応

| 人手 | Lean（具体版） |
| --- | --- |
| `x^*Ay := Σ_k Σ_l (\overline{x_k}A_{kl})y_l`（`def_conjugate_bilinear_value`） | `conjugateBilinearValue` |
| 正定値の `x^*Ax ∈ ℝ_{>0}`（`def_hermitian_positive_definite`）と mathlib の `Matrix.PosDef` の読み替え | `posDef_conjugateBilinearValue_pos` |
| `b^{(k)}_i := δ_{ik}`、`b^{(k)}_k = 1_ℂ = (1,0) ≠ (0,0) = 0_ℂ` なので `b^{(k)} ≠ 0` | `standardBasisVec`・`standardBasisVec_ne_zero` |
| `δ_{ij}` は `1_ℂ` か `0_ℂ` なので `\overline{δ_{ij}} = δ_{ij}`（`complex_conjugate_of_real_inclusion`） | `star_kroneckerDelta` |
| `i = j ⟺ j = i` なので `δ_{ij} = δ_{ji}` | `kroneckerDelta_comm` |
| 成分の鎖 `b^{(k)*}Ab^{(k)} = … = A_{kk}` の 11 行 | `conjugate_bilinear_value_basis_eq_diag` の `calc` の 11 段 |
| 「`A_{kk} = b^{(k)*}Ab^{(k)} = (r_k)_ℂ` を満たす `r_k ∈ ℝ_{>0}` がある」 | `trace_of_positive_definite_is_positive` の `choose` と `hd` |
| トレースの鎖の 3 行（`def_trace` → `r_k` の取り方 → `real_inclusion_preserves_finite_sum`） | 同じ定理の `htr` の `calc` の 3 段 |
| `Σ r_k ≥ r_1 > 0` の 2 行（`finite_sum_of_nonnegative_reals_is_at_least_each_term` → `r_1 ∈ ℝ_{>0}`） | 同じ定理の `hpos` の `calc` の 2 段（1 段目は具体版 `finite_sum_of_nonnegative_reals_ge_term`） |

- 成分の式との接点は `matrix_mul_apply_sum`（`mat_mult`）・`identity_matrix_apply`（`def_identity_matrix`）・
  `mul_identity_matrix`・`identity_matrix_mul`（`identity_matrix_is_right_unit_of_mat_mult`・`_left_unit_`）・
  `trace_eq_sum_diag`（`def_trace`）である。
- 人手の `real_inclusion_preserves_finite_sum` は具体版 `real_inclusion_of_finite_sum_fintype` を引く（`1 ≤ n` から添字 `Fin n` は空でない）。
- `conjugateBilinearValue`・`posDef_conjugateBilinearValue_pos` の添字は有限集合 `ι` で受け取る（人手の `{1,…,n}` は `Fin n`、
  `2^{M_col}` 個の行配位で添字づけた行列（`W_real_is_positive_definite`）は `Conf M`）。和を取るのに有限であることだけを使う。
- 人手の `n ∈ ℤ_{≥1}` は仮定 `1 ≤ n` で受け取る。`r_1` は添字 `⟨0, _⟩ : Fin n` の `r` である。
-/
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProduct
import Ising2D.MathematicalTools.KroneckerProductAndMultiFactorBasis.ClaimRealInclusionPreservesFiniteSum
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.DefinitionTrace
import Ising2D.MathematicalTools.TrigonometricEstimatesFiniteSumsAndIntegrals.ClaimFiniteSumsOfRealNumbers
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Complex.Order
import Mathlib.Data.Complex.BigOperators

namespace Ising2D

open Matrix
open scoped ComplexOrder

/-- **`def_conjugate_bilinear_value`**: `x^*Ay := Σ_k Σ_l (\overline{x_k} A_{kl}) y_l`。 -/
def conjugateBilinearValue {ι : Type*} [Fintype ι] (x : ι → ℂ) (A : Matrix ι ι ℂ) (y : ι → ℂ) : ℂ :=
  ∑ k, ∑ l, (star (x k) * A k l) * y l

/-- mathlib の `star x ⬝ᵥ (A *ᵥ y)` は人手の `x^*Ay` と同じ値である（`Matrix.PosDef` を人手の正定値で読むため）。 -/
theorem dotProduct_mulVec_eq_conjugateBilinearValue {ι : Type*} [Fintype ι] (x : ι → ℂ) (A : Matrix ι ι ℂ)
    (y : ι → ℂ) : star x ⬝ᵥ (A *ᵥ y) = conjugateBilinearValue x A y :=
  calc star x ⬝ᵥ (A *ᵥ y)
      = ∑ k, star (x k) * ∑ l, A k l * y l := rfl                                 -- `⬝ᵥ`・`*ᵥ` の定義
    _ = ∑ k, ∑ l, star (x k) * (A k l * y l) :=                                   -- 分配律を各項へ
        Finset.sum_congr rfl fun _ _ => Finset.mul_sum _ _ _
    _ = ∑ k, ∑ l, (star (x k) * A k l) * y l :=                                   -- 積の結合律を各項へ
        Finset.sum_congr rfl fun _ _ => Finset.sum_congr rfl fun _ _ => (mul_assoc _ _ _).symm
    _ = conjugateBilinearValue x A y := rfl                                       -- `def_conjugate_bilinear_value`

/-- **`def_hermitian_positive_definite`** の正定値の条件: `A` が正定値で `x ≠ 0` なら、`x^*Ax = r_ℂ` を満たす `r ∈ ℝ_{>0}` がある。

mathlib の `Matrix.PosDef` は `0 < star x ⬝ᵥ (A *ᵥ x)`（`ℂ` の順序 `ComplexOrder`）の形なので、
`0 < z ↔ 0 < z.re ∧ 0 = z.im`（`Complex.pos_iff`）で人手の略記 `z ∈ ℝ_{>0}` へ読み替える。 -/
theorem posDef_conjugateBilinearValue_pos {ι : Type*} [Fintype ι] {A : Matrix ι ι ℂ} (hA : A.PosDef)
    {x : ι → ℂ} (hx : x ≠ 0) : ∃ r : ℝ, 0 < r ∧ conjugateBilinearValue x A x = (r : ℂ) := by
  have h := Complex.pos_iff.mp (hA.dotProduct_mulVec_pos hx)
  rw [dotProduct_mulVec_eq_conjugateBilinearValue] at h
  exact ⟨(conjugateBilinearValue x A x).re, h.1, Complex.ext rfl (by rw [Complex.ofReal_im, ← h.2])⟩

/-- 標準基底ベクトル `b^{(k)}_i := δ_{ik}`（`def_kronecker_delta`）。 -/
def standardBasisVec {n : ℕ} (k : Fin n) : Fin n → ℂ := fun i => kroneckerDelta i k

/-- `b^{(k)}_k = 1_ℂ = (1,0) ≠ (0,0) = 0_ℂ` なので `b^{(k)} ≠ 0`。 -/
theorem standardBasisVec_ne_zero {n : ℕ} (k : Fin n) : standardBasisVec k ≠ 0 := by
  intro h
  have hk : standardBasisVec k k = 0 := by rw [h]; rfl
  have h1 : standardBasisVec k k = 1 := kroneckerDelta_self k                            -- `def_kronecker_delta`
  have h10 : (⟨1, 0⟩ : ℂ) ≠ ⟨0, 0⟩ := fun e => one_ne_zero (congrArg Complex.re e)  -- 実部が `1 ≠ 0`
  exact h10 (h1.symm.trans hk)                                                   -- `1_ℂ = (1,0)`・`0_ℂ = (0,0)`（`inclusion_rr_to_cc`）

/-- `δ_{ij}` は `1_ℂ` か `0_ℂ` なので `\overline{δ_{ij}} = δ_{ij}`（`complex_conjugate_of_real_inclusion`）。 -/
theorem star_kroneckerDelta {n : ℕ} (i j : Fin n) : star (kroneckerDelta i j) = kroneckerDelta i j := by
  by_cases h : i = j
  · rw [h, kroneckerDelta_self]                                                   -- `δ_{jj} = 1_ℂ`
    calc star (1 : ℂ)
        = star ((1 : ℝ) : ℂ) := rfl                                               -- `1_ℂ = (1)_ℂ`
      _ = ((1 : ℝ) : ℂ) := complex_conjugate_of_real_inclusion 1                  -- `complex_conjugate_of_real_inclusion`
      _ = 1 := rfl
  · rw [kroneckerDelta_of_ne h]                                                   -- `δ_{ij} = 0_ℂ`
    calc star (0 : ℂ)
        = star ((0 : ℝ) : ℂ) := rfl                                               -- `0_ℂ = (0)_ℂ`
      _ = ((0 : ℝ) : ℂ) := complex_conjugate_of_real_inclusion 0                  -- `complex_conjugate_of_real_inclusion`
      _ = 0 := rfl

/-- `i = j ⟺ j = i` なので `δ_{ij} = δ_{ji}`。 -/
theorem kroneckerDelta_comm {n : ℕ} (i j : Fin n) : kroneckerDelta i j = kroneckerDelta j i := by
  unfold kroneckerDelta
  simp only [eq_comm]

/-- **`trace_of_positive_definite_is_positive`** の成分の鎖: `b^{(k)*}Ab^{(k)} = A_{kk}`。 -/
theorem conjugate_bilinear_value_basis_eq_diag {n : ℕ} (A : Matrix (Fin n) (Fin n) ℂ) (k : Fin n) :
    conjugateBilinearValue (standardBasisVec k) A (standardBasisVec k) = A k k :=
  calc conjugateBilinearValue (standardBasisVec k) A (standardBasisVec k)
      = ∑ i, ∑ l, (star (kroneckerDelta i k) * A i l) * kroneckerDelta l k := rfl -- `def_conjugate_bilinear_value` と `b^{(k)}` の定義
    _ = ∑ i, ∑ l, (kroneckerDelta i k * A i l) * kroneckerDelta l k := by         -- `\overline{δ_{ik}} = δ_{ik}` を各項へ
        simp only [star_kroneckerDelta]
    _ = ∑ i, ∑ l, kroneckerDelta i k * (A i l * kroneckerDelta l k) :=            -- 積の結合律を各項へ（`complex_numbers_form_a_field`）
        Finset.sum_congr rfl fun i _ => Finset.sum_congr rfl fun l _ => mul_assoc _ _ _
    _ = ∑ i, kroneckerDelta i k * ∑ l, A i l * kroneckerDelta l k :=              -- 分配律を項の数だけ繰り返す（`complex_numbers_form_a_field`）
        Finset.sum_congr rfl fun i _ => (Finset.mul_sum _ _ _).symm
    _ = ∑ i, kroneckerDelta i k * ∑ l, A i l * (1 : Matrix (Fin n) (Fin n) ℂ) l k := by  -- `def_identity_matrix` を各項へ
        simp only [identity_matrix_apply]
    _ = ∑ i, kroneckerDelta i k * (A * (1 : Matrix (Fin n) (Fin n) ℂ)) i k :=     -- `mat_mult`
        Finset.sum_congr rfl fun i _ => by rw [matrix_mul_apply_sum]
    _ = ∑ i, kroneckerDelta i k * A i k := by rw [mul_identity_matrix]            -- `identity_matrix_is_right_unit_of_mat_mult`
    _ = ∑ i, kroneckerDelta k i * A i k := by                                     -- `δ_{ik} = δ_{ki}` を各項へ
        simp only [kroneckerDelta_comm _ k]
    _ = ∑ i, (1 : Matrix (Fin n) (Fin n) ℂ) k i * A i k := by                     -- `def_identity_matrix` を各項へ
        simp only [identity_matrix_apply]
    _ = ((1 : Matrix (Fin n) (Fin n) ℂ) * A) k k := (matrix_mul_apply_sum _ _ _ _).symm  -- `mat_mult`
    _ = A k k := by rw [identity_matrix_mul]                                      -- `identity_matrix_is_left_unit_of_mat_mult`

/-- **`trace_of_positive_definite_is_positive`**: `n ∈ ℤ_{≥1}`、`A ∈ Mat(n,ℂ)` が正定値なら `tr(A) ∈ ℝ_{>0}`。 -/
theorem trace_of_positive_definite_is_positive {n : ℕ} (hn : 1 ≤ n) (A : Matrix (Fin n) (Fin n) ℂ)
    (hA : A.PosDef) : ∃ s : ℝ, 0 < s ∧ A.trace = (s : ℂ) := by
  -- `A` が正定値で `b^{(k)} ≠ 0` なので、`A_{kk} = b^{(k)*}Ab^{(k)} = (r_k)_ℂ` を満たす `r_k ∈ ℝ_{>0}` がある
  choose r hr hrA using fun k : Fin n => posDef_conjugateBilinearValue_pos hA (standardBasisVec_ne_zero k)
  have hd : ∀ k, A k k = (r k : ℂ) := fun k =>
    (conjugate_bilinear_value_basis_eq_diag A k).symm.trans (hrA k)
  haveI : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩                                          -- `n ∈ ℤ_{≥1}` なので添字の集合は空でない
  have htr : A.trace = ((∑ k, r k : ℝ) : ℂ) :=
    calc A.trace
        = ∑ k, A k k := trace_eq_sum_diag A                                       -- `def_trace`
      _ = ∑ k, (r k : ℂ) := Finset.sum_congr rfl fun k _ => hd k                  -- `r_k` の取り方を各項へ
      _ = ((∑ k, r k : ℝ) : ℂ) := real_inclusion_of_finite_sum_fintype _          -- `real_inclusion_preserves_finite_sum`
  -- `n ≥ 1` なので `r_1` がある
  have hpos : ∑ k, r k > 0 :=
    calc ∑ k, r k
        ≥ r ⟨0, hn⟩ :=                                                            -- `finite_sum_of_nonnegative_reals_is_at_least_each_term`（`m → n`, `a_j → r_j`, `k → 1`）
          finite_sum_of_nonnegative_reals_ge_term n r (fun k => (hr k).le) ⟨0, hn⟩
      _ > 0 := hr ⟨0, hn⟩                                                         -- `r_1 ∈ ℝ_{>0}`
  exact ⟨∑ k, r k, hpos, htr⟩

end Ising2D
