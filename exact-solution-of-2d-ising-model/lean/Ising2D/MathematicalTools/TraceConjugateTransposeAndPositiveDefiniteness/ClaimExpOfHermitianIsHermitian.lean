/-
# エルミート行列の exp はエルミート（**具体版**）

対応する人手証明のラベル: `exp_of_hermitian_is_hermitian`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_exp_of_hermitian_is_hermitian`）。

**必要十分版**: `Ising2D/NecSuf/SeriesOfHermitianIsHermitian.lean`。具体版をその特殊化として導くのは
`ClaimExpOfHermitianIsHermitianFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 冒頭の `I^* = I`（`identity_matrix_is_positive_definite` のエルミート性の成分の 5 行: `def_hermitian_positive_definite` → `def_identity_matrix` → `\overline{δ_{lk}} = δ_{lk}` → `δ_{lk} = δ_{kl}` → `def_identity_matrix`） | `identity_conjTranspose_tensorPow` の `calc` の 5 段（3 段目は `star_identity_entry_tensorPow`） |
| 準備 `SS^m = S^mS` の `m = 0` の 4 行と `m → m+1` の 4 行 | `tensorPow_mul_pow_comm`（`ClaimExpOfSymmetricIsSymmetric.lean`、同じ 8 行） |
| 準備 `(S^m)^* = S^m` の `m = 0` の 3 行と `m → m+1` の 6 行（`star_preserves_norm_and_limits` (1) の第 1 式） | `tensorPow_pow_conjTranspose_of_conjTranspose_eq` の 2 つの `calc` |
| 部分和 `E_N := Σ_{m=0}^{N}(1/m!)S^m` と成分の式 `(E_N)_{kl} = Σ_{m=0}^{N}(1/m!)_ℂ(S^m)_{kl}` | `expPartialSum`、`expPartialSum_apply`（`ClaimExpOfSymmetricIsSymmetric.lean`） |
| `((E_N)^*)_{kl}` の 8 行と「すべての `N` で `E_N^* = E_N`」 | `expPartialSum_conjTranspose_apply` の `calc` の 8 段、`expPartialSum_conjTranspose` |
| `def_exp` (1) の `E_N → exp(S)`、`star_preserves_norm_and_limits` (3) の `E_N^* → exp(S)^*`、`E_N^* = E_N` による書き換え、`matrix_norm_triangle_inequality` (4)（極限の一意性） | `matExp_conjTranspose_of_conjTranspose_eq` の `hE`・`hT`・書き換え・`tendsto_nhds_unique` |

* 行列は `TensorPow M`（添字 `Conf M`）で述べる。使う側（`exp_hermitian_is_positive_definite`・`W_is_real_symmetric_positive_definite` の Step 2）が
  `TensorPow M` の `matExp` だからである。人手の `n` は `2^{M_col}` にあたる。添字が `Conf M` なので、
  `star_preserves_norm_and_limits` (1) の第 1 式・(3) は、必要十分版を添字 `Conf M` へ特殊化した系
  `conjTranspose_mul_tensorPow`・`conjTranspose_tendsto_tensorPow`（`ClaimStarPreservesNormAndLimitsFromNecSuf.lean`）を引く。
* 冒頭の `I^* = I` は、人手が `identity_matrix_is_positive_definite` のエルミート性の段を引いている。その主張の Lean の具体版は無いので、
  そのエルミート性の段の成分の 5 行を `TensorPow M` について `identity_conjTranspose_tensorPow` に置いた。
  人手の `δ_{ij}` は `def_identity_matrix` の成分 `if i = j then 1 else 0`（mathlib の `Matrix.one_apply`）で書く
  （添字が `Fin n` の `kroneckerDelta` は `Conf M` に当てはまらない）。
  3 段目の「`δ_{lk}` は `1_ℂ` か `0_ℂ` なので `\overline{δ_{lk}} = δ_{lk}`（`complex_conjugate_of_real_inclusion`）」は、
  `ClaimTraceOfPositiveDefiniteIsPositive.lean` の `star_kroneckerDelta` と同じ場合分けで `star_identity_entry_tensorPow` に置いた。
  `identity_matrix_is_positive_definite` の具体版を置いたら、この 2 つはそちらへ移して引く形にできる。
* `def_exp` (1) の冪 `A^0 := I`・`A^{m+1} := A^mA` は mathlib の `pow_zero`・`pow_succ`（`a^{m+1} = a^m a`）と同じ形である。
* 部分和の係数 `(1/m!)_ℂ` は Lean では `((m! : ℂ))⁻¹` と書いてある（`expPartialSum`）。8 行のうち 5 行目の
  `complex_conjugate_of_real_inclusion` は、`((m! : ℂ))⁻¹ = ((m! : ℝ)⁻¹)_ℂ`（`inclusion_rr_to_cc` が逆数と自然数の像を保つこと。
  mathlib の `Complex.ofReal_inv`・`Complex.ofReal_natCast`）と書き直してから当てる（`star_inv_factorial`）。
* 複素共役の性質 `complex_conjugate_of_sum`・`complex_conjugate_of_product` は、具体版を `star` の形と添字 `0, …, N`（`Finset.range (N + 1)`）へ
  読み替えた `complex_conjugate_star_sum_range`（`N → N + 1`）・`complex_conjugate_star_mul`（`MathematicalTools/SetNotationAndComplexCartesianArithmetic/ClaimComplexConjugateOfSumProductDifferenceStarForm.lean`）を引く。
* `def_exp` (1) の「部分和が `exp(S)` へ収束する」は、`ClaimExpOfSymmetricIsSymmetric.lean` と同じく `matExp_hasSum` の部分和
  `Σ_{m<N}` を `N → N+1` とずらして人手の `Σ_{m=0}^{N}` に合わせる。ノルムは mathlib の Frobenius ノルムで、
  `def_matrix_norm` の行列ノルムと値が一致する。極限の段で `ℝ` へ脱出する（人手の主張に書いてある）。
* 極限の一意性（人手 `matrix_norm_triangle_inequality` (4)）は、本文に Lean の具体版が無く、
  `ClaimExpOfSymmetricIsSymmetric.lean` と同じく mathlib の `tendsto_nhds_unique` を引く。
-/
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimComplexConjugateOfSumProductDifferenceStarForm
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimExpOfSymmetricIsSymmetric
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimStarPreservesNormAndLimitsFromNecSuf
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimRealSymmetricMatrixIsHermitian

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

variable {M : ℕ}

/-- 人手 `identity_matrix_is_positive_definite` のエルミート性の 3 行目:
`δ_{lk}` は `1_ℂ` か `0_ℂ` なので `\overline{δ_{lk}} = δ_{lk}`（`complex_conjugate_of_real_inclusion`）。 -/
theorem star_identity_entry_tensorPow (l k : Conf M) :
    star (if l = k then (1 : ℂ) else 0) = if l = k then (1 : ℂ) else 0 := by
  by_cases h : l = k
  · rw [if_pos h]                                                                -- `δ_{lk} = 1_ℂ`
    calc star (1 : ℂ)
        = star ((1 : ℝ) : ℂ) := rfl                                              -- `1_ℂ = (1)_ℂ`
      _ = ((1 : ℝ) : ℂ) := complex_conjugate_of_real_inclusion 1                 -- `complex_conjugate_of_real_inclusion`
      _ = 1 := rfl
  · rw [if_neg h]                                                                -- `δ_{lk} = 0_ℂ`
    calc star (0 : ℂ)
        = star ((0 : ℝ) : ℂ) := rfl                                              -- `0_ℂ = (0)_ℂ`
      _ = ((0 : ℝ) : ℂ) := complex_conjugate_of_real_inclusion 0                 -- `complex_conjugate_of_real_inclusion`
      _ = 0 := rfl

/-- 人手 冒頭の `I^* = I`（`identity_matrix_is_positive_definite` のエルミート性の成分の 5 行）。 -/
theorem identity_conjTranspose_tensorPow : (1 : TensorPow M)ᴴ = 1 :=
  Matrix.ext fun k l =>
    calc (1 : TensorPow M)ᴴ k l
        = star ((1 : TensorPow M) l k) := rfl                                    -- `def_hermitian_positive_definite`
      _ = star (if l = k then (1 : ℂ) else 0) := by rw [Matrix.one_apply]       -- `def_identity_matrix`（`i → l`, `j → k`）
      _ = if l = k then (1 : ℂ) else 0 := star_identity_entry_tensorPow l k      -- `\overline{δ_{lk}} = δ_{lk}`
      _ = if k = l then (1 : ℂ) else 0 := by simp only [eq_comm]                -- `δ_{lk} = δ_{kl}`（`l = k ⟺ k = l`）
      _ = (1 : TensorPow M) k l := Matrix.one_apply.symm                         -- `def_identity_matrix`（`i → k`, `j → l`）

/-- 人手 準備: `S^* = S` なら、すべての `m` について `(S^m)^* = S^m`（`m` についての帰納法）。 -/
theorem tensorPow_pow_conjTranspose_of_conjTranspose_eq (S : TensorPow M) (hS : Sᴴ = S) (m : ℕ) :
    (S ^ m)ᴴ = S ^ m := by
  induction m with
  | zero =>
    calc (S ^ 0)ᴴ = (1 : TensorPow M)ᴴ := by rw [pow_zero]                     -- `def_exp` (1) の `A^0 := I`
      _ = 1 := identity_conjTranspose_tensorPow                                  -- `I^* = I`
      _ = S ^ 0 := (pow_zero S).symm                                             -- `def_exp` (1) の `A^0 := I`
  | succ m ih =>
    calc (S ^ (m + 1))ᴴ = (S ^ m * S)ᴴ := by rw [pow_succ]                     -- `def_exp` (1) の `A^{m+1} := A^mA`
      _ = Sᴴ * (S ^ m)ᴴ := conjTranspose_mul_tensorPow _ _                       -- `star_preserves_norm_and_limits` (1) の第 1 式（`A → S^m`, `B → S`）
      _ = S * (S ^ m)ᴴ := by rw [hS]                                             -- `S^* = S`
      _ = S * S ^ m := by rw [ih]                                                -- 帰納法の仮定
      _ = S ^ m * S := tensorPow_mul_pow_comm S m                                -- 準備の `SS^m = S^mS`
      _ = S ^ (m + 1) := (pow_succ S m).symm                                     -- `def_exp` (1) の `A^{m+1} := A^mA`

/-- 部分和の係数 `(1/m!)_ℂ` は共役で動かない（`complex_conjugate_of_real_inclusion` の `r → 1/m!`）。
Lean の係数 `((m! : ℂ))⁻¹` を `((m! : ℝ)⁻¹)_ℂ` と書き直してから当てる。 -/
theorem star_inv_factorial (m : ℕ) : star ((m.factorial : ℂ))⁻¹ = ((m.factorial : ℂ))⁻¹ := by
  have h : ((m.factorial : ℂ))⁻¹ = (((m.factorial : ℝ))⁻¹ : ℝ) := by
    rw [Complex.ofReal_inv, Complex.ofReal_natCast]                              -- `inclusion_rr_to_cc` は逆数と自然数の像を保つ
  rw [h]
  exact complex_conjugate_of_real_inclusion _                                    -- `complex_conjugate_of_real_inclusion`

/-- 人手 `((E_N)^*)_{kl}` の 8 行。 -/
theorem expPartialSum_conjTranspose_apply (S : TensorPow M) (hS : Sᴴ = S) (N : ℕ) (k l : Conf M) :
    (expPartialSum S N)ᴴ k l = expPartialSum S N k l :=
  calc (expPartialSum S N)ᴴ k l
      = star (expPartialSum S N l k) := rfl                                                  -- `def_hermitian_positive_definite`
    _ = star (∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m) l k) := by
        rw [expPartialSum_apply]                                                             -- `(E_N)_{lk}` の成分の式
    _ = ∑ m ∈ Finset.range (N + 1), star (((m.factorial : ℂ))⁻¹ * (S ^ m) l k) :=
        complex_conjugate_star_sum_range (N + 1) _                                           -- `complex_conjugate_of_sum` の `m = N+1`
    _ = ∑ m ∈ Finset.range (N + 1), star ((m.factorial : ℂ))⁻¹ * star ((S ^ m) l k) := by
        simp only [complex_conjugate_star_mul]                                               -- `complex_conjugate_of_product` を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * star ((S ^ m) l k) := by
        simp only [star_inv_factorial]                                                       -- `complex_conjugate_of_real_inclusion` を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m)ᴴ k l := rfl              -- `def_hermitian_positive_definite` を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m) k l := by
        simp only [tensorPow_pow_conjTranspose_of_conjTranspose_eq S hS]                     -- 上で示した `(S^m)^* = S^m` を各項へ
    _ = expPartialSum S N k l := (expPartialSum_apply S N k l).symm                          -- `(E_N)_{kl}` の成分の式

/-- 人手「すべての `N` で `E_N^* = E_N`」。 -/
theorem expPartialSum_conjTranspose (S : TensorPow M) (hS : Sᴴ = S) (N : ℕ) :
    (expPartialSum S N)ᴴ = expPartialSum S N :=
  Matrix.ext (expPartialSum_conjTranspose_apply S hS N)

/-- **人手 `exp_of_hermitian_is_hermitian`**: `S^* = S` なら `exp(S)^* = exp(S)`。 -/
theorem matExp_conjTranspose_of_conjTranspose_eq (S : TensorPow M) (hS : Sᴴ = S) :
    (matExp S)ᴴ = matExp S := by
  -- `def_exp` (1): `E_N → exp(S)`（`matExp_hasSum` の部分和 `Σ_{m<N}` を `N → N+1` とずらす）
  have hE : Tendsto (fun N => expPartialSum S N) atTop (𝓝 (matExp S)) :=
    ((matExp_hasSum S).tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)
  -- `star_preserves_norm_and_limits` (3)（`A_N → E_N`, `A → exp(S)`）: `E_N^* → exp(S)^*`
  have hT := conjTranspose_tendsto_tensorPow (fun N => expPartialSum S N) (matExp S)
    (tendsto_iff_norm_sub_tendsto_zero.1 hE)
  -- `E_N^* = E_N` なので `E_N → exp(S)^*`
  simp only [expPartialSum_conjTranspose S hS] at hT
  -- `matrix_norm_triangle_inequality` (4)（極限の一意性）
  exact tendsto_nhds_unique (tendsto_iff_norm_sub_tendsto_zero.2 hT) hE

end Ising2D
