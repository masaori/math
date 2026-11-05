/-
# 転置で不変な行列の exp は転置で不変（**具体版**）

対応する人手証明のラベル: `exp_of_symmetric_is_symmetric`
（`structured-latex/content/009_eigenvalues_of_V.ts` の `eigenvalues_of_V_claim_exp_of_symmetric_is_symmetric`）。

**必要十分版**: `Ising2D/NecSuf/SeriesOfSymmetricIsSymmetric.lean`。具体版をその特殊化として導くのは
`ClaimExpOfSymmetricIsSymmetricFromNecSuf.lean`。

## 人手証明との対応

| 人手 | Lean |
| --- | --- |
| 冒頭の `(I^⊤)_{kl}` の 4 行（`def_matrix_transpose` → `def_identity_matrix` → `def_kronecker_delta` → `def_identity_matrix`） | `identity_transpose_tensorPow` の `calc` の 4 段 |
| 準備 `SS^m = S^mS` の `m = 0` の 4 行と `m → m+1` の 4 行 | `tensorPow_mul_pow_comm` の 2 つの `calc` |
| 準備 `(S^m)^⊤ = S^m` の `m = 0` の 3 行と `m → m+1` の 6 行（`transpose_of_matrix_product`） | `tensorPow_pow_transpose_of_transpose_eq` の 2 つの `calc` |
| 部分和 `E_N := Σ_{m=0}^{N}(1/m!)S^m` と成分の式 `(E_N)_{kl} = Σ_{m=0}^{N}(1/m!)_ℂ(S^m)_{kl}` | `expPartialSum`、`expPartialSum_apply` |
| `((E_N)^⊤)_{kl}` の 5 行と「すべての `N` で `E_N^⊤ = E_N`」 | `expPartialSum_transpose_apply` の `calc` の 5 段、`expPartialSum_transpose` |
| `def_exp` (1) の `E_N → exp(S)`、`transpose_preserves_matrix_limits` の `E_N^⊤ → exp(S)^⊤`、`E_N^⊤ = E_N` による書き換え、`matrix_norm_triangle_inequality` (4)（極限の一意性） | `matExp_transpose_of_transpose_eq` の `hE`・`hT`・書き換え・`tendsto_nhds_unique` |

* 行列は `TensorPow M`（添字 `Conf M`）で述べる。使う側（`W_is_real_symmetric_positive_definite` の Step 2 の `B = exp(½K_1D)`・`A = exp(S_2)`）が
  `TensorPow M` の `matExp` だからである。人手の `n` は `2^{M_col}` にあたる。添字が `Conf M` なので、
  `transpose_of_matrix_product`・`transpose_preserves_matrix_limits`・`identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult` は、
  必要十分版を添字 `Conf M` へ特殊化した系 `transpose_mul_tensorPow`・`transpose_tendsto_tensorPow`・`identity_matrix_mul_tensorPow`・`mul_identity_matrix_tensorPow` を引く。
* `def_exp` (1) の冪 `A^0 := I`・`A^{m+1} := A^mA` は mathlib の `pow_zero`・`pow_succ`（`a^{m+1} = a^m a`）と同じ形である。
  `mat_mult_associative` は本文に Lean の具体版が無く、他のファイルと同じく mathlib の `Matrix.mul_assoc` を引く。
* 部分和の成分の式は、人手が `def_matrix_sum` を項の数についての帰納法で、`def_matrix_scalar_multiple` を各項へ当てはめて得ている段で、
  Lean は和とスカラー倍の成分の定義そのもの（mathlib の `Matrix.sum_apply`・`Matrix.smul_apply`）で閉じる。
* `def_exp` (1) の「部分和が `exp(S)` へ収束する」は `matExp_hasSum`（項 `(m!)^{-1}S^m` の和）の部分和の収束で、
  mathlib の部分和 `Σ_{m<N}` を `N → N+1` とずらして人手の `Σ_{m=0}^{N}` に合わせる。
  ノルムは mathlib の Frobenius ノルムで、`def_matrix_norm` の行列ノルムと値が一致する（`ClaimTransposePreservesMatrixNormAndLimits.lean` と同じ入れ方）。
  極限の段で `ℝ` へ脱出する（人手の主張に書いてある）。
* 極限の一意性（人手 `matrix_norm_triangle_inequality` (4)）は、本文に Lean の具体版が無く、`ClaimSignFlipConjugation.lean` の
  `Uflip_conj_matExp` と同じく mathlib の `tendsto_nhds_unique` を引く。
-/
import Ising2D.MathematicalTools.TraceConjugateTransposeAndPositiveDefiniteness.ClaimTransposePreservesMatrixNormAndLimitsFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimTransposeOfMatrixProductFromNecSuf
import Ising2D.MathematicalTools.FiniteMatricesPauliMatricesAndCommutators.ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf
import Ising2D.Representation

namespace Ising2D

open Matrix Filter Topology

attribute [local instance] Matrix.frobeniusNormedAddCommGroup

variable {M : ℕ}

/-- 人手 冒頭の `I^⊤ = I`（成分の 4 行）。 -/
theorem identity_transpose_tensorPow : (1 : TensorPow M)ᵀ = 1 :=
  Matrix.ext fun k l =>
    calc (1 : TensorPow M)ᵀ k l
        = (1 : TensorPow M) l k := rfl                                -- `def_matrix_transpose`（`B → I`, `p → k`, `q → l`）
      _ = if l = k then 1 else 0 := Matrix.one_apply                 -- `def_identity_matrix`（`i → l`, `j → k`）
      _ = if k = l then 1 else 0 := by simp only [eq_comm]           -- `def_kronecker_delta` で `l = k` と `k = l` は同じ条件
      _ = (1 : TensorPow M) k l := Matrix.one_apply.symm             -- `def_identity_matrix`（`i → k`, `j → l`）

/-- 人手 準備: すべての `m` について `SS^m = S^mS`（`m` についての帰納法）。 -/
theorem tensorPow_mul_pow_comm (S : TensorPow M) (m : ℕ) : S * S ^ m = S ^ m * S := by
  induction m with
  | zero =>
    calc S * S ^ 0 = S * 1 := by rw [pow_zero]                      -- `def_exp` (1) の `A^0 := I`
      _ = S := mul_identity_matrix_tensorPow S                        -- `identity_matrix_is_right_unit_of_mat_mult`
      _ = 1 * S := (identity_matrix_mul_tensorPow S).symm             -- `identity_matrix_is_left_unit_of_mat_mult`
      _ = S ^ 0 * S := by rw [pow_zero]                               -- `def_exp` (1) の `A^0 := I`
  | succ m ih =>
    calc S * S ^ (m + 1) = S * (S ^ m * S) := by rw [pow_succ]      -- `def_exp` (1) の `A^{m+1} := A^mA`
      _ = (S * S ^ m) * S := (Matrix.mul_assoc _ _ _).symm            -- `mat_mult_associative`
      _ = (S ^ m * S) * S := by rw [ih]                               -- 帰納法の仮定
      _ = S ^ (m + 1) * S := by rw [pow_succ]                         -- `def_exp` (1) の `A^{m+1} := A^mA`

/-- 人手 準備: `S^⊤ = S` なら、すべての `m` について `(S^m)^⊤ = S^m`（`m` についての帰納法）。 -/
theorem tensorPow_pow_transpose_of_transpose_eq (S : TensorPow M) (hS : Sᵀ = S) (m : ℕ) :
    (S ^ m)ᵀ = S ^ m := by
  induction m with
  | zero =>
    calc (S ^ 0)ᵀ = (1 : TensorPow M)ᵀ := by rw [pow_zero]          -- `def_exp` (1) の `A^0 := I`
      _ = 1 := identity_transpose_tensorPow                           -- `I^⊤ = I`
      _ = S ^ 0 := (pow_zero S).symm                                  -- `def_exp` (1) の `A^0 := I`
  | succ m ih =>
    calc (S ^ (m + 1))ᵀ = (S ^ m * S)ᵀ := by rw [pow_succ]          -- `def_exp` (1) の `A^{m+1} := A^mA`
      _ = Sᵀ * (S ^ m)ᵀ := transpose_mul_tensorPow _ _                -- `transpose_of_matrix_product`（`A → S^m`, `B → S`）
      _ = S * (S ^ m)ᵀ := by rw [hS]                                  -- `S^⊤ = S`
      _ = S * S ^ m := by rw [ih]                                     -- 帰納法の仮定
      _ = S ^ m * S := tensorPow_mul_pow_comm S m                     -- 準備の `SS^m = S^mS`
      _ = S ^ (m + 1) := (pow_succ S m).symm                          -- `def_exp` (1) の `A^{m+1} := A^mA`

/-- 人手の部分和 `E_N := Σ_{m=0}^{N} (1/m!) S^m`（`def_exp` (1) の部分和。係数は `(1/m!)_ℂ`）。 -/
noncomputable def expPartialSum (S : TensorPow M) (N : ℕ) : TensorPow M :=
  ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ • S ^ m

/-- 人手の部分和の成分の式 `(E_N)_{kl} = Σ_{m=0}^{N}(1/m!)_ℂ(S^m)_{kl}`（`def_matrix_sum`・`def_matrix_scalar_multiple`）。 -/
theorem expPartialSum_apply (S : TensorPow M) (N : ℕ) (k l : Conf M) :
    expPartialSum S N k l = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m) k l := by
  simp only [expPartialSum, Matrix.sum_apply, Matrix.smul_apply, smul_eq_mul]

/-- 人手 `((E_N)^⊤)_{kl}` の 5 行。 -/
theorem expPartialSum_transpose_apply (S : TensorPow M) (hS : Sᵀ = S) (N : ℕ) (k l : Conf M) :
    (expPartialSum S N)ᵀ k l = expPartialSum S N k l :=
  calc (expPartialSum S N)ᵀ k l
      = expPartialSum S N l k := rfl                                                 -- `def_matrix_transpose`（`B → E_N`）
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m) l k :=
        expPartialSum_apply S N l k                                                  -- `(E_N)_{lk}` の成分の式
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m)ᵀ k l := rfl     -- `def_matrix_transpose`（`B → S^m`）を各項へ
    _ = ∑ m ∈ Finset.range (N + 1), ((m.factorial : ℂ))⁻¹ * (S ^ m) k l := by
        simp only [tensorPow_pow_transpose_of_transpose_eq S hS]                    -- 上で示した `(S^m)^⊤ = S^m` を各項へ
    _ = expPartialSum S N k l := (expPartialSum_apply S N k l).symm                  -- `(E_N)_{kl}` の成分の式

/-- 人手「すべての `N` で `E_N^⊤ = E_N`」。 -/
theorem expPartialSum_transpose (S : TensorPow M) (hS : Sᵀ = S) (N : ℕ) :
    (expPartialSum S N)ᵀ = expPartialSum S N :=
  Matrix.ext (expPartialSum_transpose_apply S hS N)

/-- **人手 `exp_of_symmetric_is_symmetric`**: `S^⊤ = S` なら `exp(S)^⊤ = exp(S)`。 -/
theorem matExp_transpose_of_transpose_eq (S : TensorPow M) (hS : Sᵀ = S) :
    (matExp S)ᵀ = matExp S := by
  -- `def_exp` (1): `E_N → exp(S)`（`matExp_hasSum` の部分和 `Σ_{m<N}` を `N → N+1` とずらす）
  have hE : Tendsto (fun N => expPartialSum S N) atTop (𝓝 (matExp S)) :=
    ((matExp_hasSum S).tendsto_sum_nat).comp (tendsto_add_atTop_nat 1)
  -- `transpose_preserves_matrix_limits`（`A_N → E_N`, `A → exp(S)`）: `E_N^⊤ → exp(S)^⊤`
  have hT := transpose_tendsto_tensorPow (fun N => expPartialSum S N) (matExp S)
    (tendsto_iff_norm_sub_tendsto_zero.1 hE)
  -- `E_N^⊤ = E_N` なので `E_N → exp(S)^⊤`
  simp only [expPartialSum_transpose S hS] at hT
  -- `matrix_norm_triangle_inequality` (4)（極限の一意性）
  exact tendsto_nhds_unique (tendsto_iff_norm_sub_tendsto_zero.2 hT) hE

end Ising2D
