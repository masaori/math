/-
# 単位行列・行列のスカラー倍・行列の差と、それらの数ベクトルへの作用（**具体版**）

対応する人手証明のラベル:
`def_matrix_difference`, `def_zero_matrix`, `matrix_difference_zero_iff_equal`, `matrix_difference_mul_vector`
（`structured-latex/content/000_calculation_formulae_45_46.ts` の `finite_matrix_definition_difference`,
`finite_matrix_definition_zero_matrix`, `finite_matrix_claim_difference_is_zero_iff_equal`,
`finite_matrix_claim_difference_distributes_over_vector_product`）と、
`def_kronecker_delta`, `def_identity_matrix`, `def_matrix_scalar_multiple`,
`identity_matrix_is_left_unit_of_mat_mult`, `scalar_multiple_factors_out_of_left_factor`
（`structured-latex/content/002_linear_space_general.ts` の `linear_space_general_definition_kronecker_delta`,
`linear_space_general_definition_identity_matrix`, `linear_space_general_definition_matrix_scalar_multiple`,
`linear_space_general_claim_identity_matrix_is_left_unit_of_mat_mult`,
`linear_space_general_claim_scalar_multiple_factors_out_of_left_factor`）。
後の 2 つの主張は、`eigenvector_of_A_theta_tilde` Step 1 が使う数ベクトル（右の因子が 1 列の行列）の場合だけを形式化する。

**必要十分版**: `Ising2D/NecSuf/MatrixVectorIdentityScalarDifference.lean`。具体版をその系として導くのは
`ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`。

## 人手証明との対応

* 定義の 5 つ: クロネッカーのデルタは `kroneckerDelta`（`def_kronecker_delta`）。 行列は mathlib の `Matrix`、単位行列・スカラー倍・差・零行列は mathlib の `1`・`•`・`-`・`0` を使う。
  後段の章の Lean がこれらで書かれているからである。人手の成分の式との接点は
  `identity_matrix_apply`（`def_identity_matrix`。`I_{ij} = δ_{ij}`）・`matrix_smul_apply`（`def_matrix_scalar_multiple`）・
  `matrix_sub_apply`（`def_matrix_difference`）・`matrix_zero_apply`（`def_zero_matrix`）の 4 つと `kroneckerDelta` の値 `kroneckerDelta_self`・`kroneckerDelta_of_ne` だけで、
  ここで示す主張の証明はこれらと行列とベクトルの積の成分 `mulVec_apply_sum`（`mat_mult`）だけから成分ごとに進む。
* 人手の数ベクトル `v ∈ ℂ^n` は `mat_mult` のとおり `n` 行 1 列の行列である。Lean では後段に合わせて `Fin n → ℂ` で書き、
  スカラー倍・差・零ベクトルの成分は `vec_smul_apply`・`vec_sub_apply`・`vec_zero_apply` とする。
  `matrix_difference_zero_iff_equal` は行列の版 `matrix_sub_eq_zero_iff` と、`p = 1` に当たる数ベクトルの版
  `vec_sub_eq_zero_iff`（`eigenvector_of_A_theta_tilde` Step 1 が使う形）を同じ鎖で置く。数ベクトルの版は、行列の版を
  `m` 行 1 列の行列へ特殊化したものではなく、`Fin m → ℂ` の上で同じ 5 行の鎖を別に辿ったものである
  （Lean の数ベクトルは 1 列の行列ではないため）。
* `identity_matrix_is_left_unit_of_mat_mult` の右の因子が数ベクトルの場合: `identity_matrix_mulVec`（`I v = v`）。
  `scalar_multiple_factors_out_of_left_factor` の右の因子が数ベクトルの場合: `smul_mulVec_eq`（`(λB)v = λ(Bv)`）。
  `matrix_difference_mul_vector`: `sub_mulVec_eq`。どれも人手の成分ごとの鎖を 1 行ずつ辿る（前の 2 つは、人手の鎖の
  `k` 列目を 1 列だけにしたものである）。
* 人手の `n, m, p ∈ ℤ_{≥1}` に対し、Lean は `ℕ` で `0` も許す（成分が無いだけで、どの主張もそのまま成り立つ）。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Data.Complex.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic

namespace Ising2D

open Matrix

/-- **`def_kronecker_delta`**: `δ_{ij} = 1`（`i = j`）、`0`（`i ≠ j`）。 -/
def kroneckerDelta {n : ℕ} (i j : Fin n) : ℂ := if i = j then 1 else 0

/-- `def_kronecker_delta` の `i = j` の値。 -/
theorem kroneckerDelta_self {n : ℕ} (i : Fin n) : kroneckerDelta i i = 1 := if_pos rfl

/-- `def_kronecker_delta` の `i ≠ j` の値。 -/
theorem kroneckerDelta_of_ne {n : ℕ} {i j : Fin n} (h : i ≠ j) : kroneckerDelta i j = 0 := if_neg h

/-- **`def_identity_matrix`**: `(I_{Mat(n,ℂ)})_{ij} = δ_{ij}`。 -/
theorem identity_matrix_apply {n : ℕ} (i j : Fin n) :
    (1 : Matrix (Fin n) (Fin n) ℂ) i j = kroneckerDelta i j :=
  Matrix.one_apply

/-- **`def_matrix_scalar_multiple`**: `(λB)_{ik} = λ B_{ik}`。 -/
theorem matrix_smul_apply {m p : ℕ} (lam : ℂ) (B : Matrix (Fin m) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (lam • B) i k = lam * B i k :=
  rfl

/-- **`def_matrix_difference`**: `(A - B)_{ik} = A_{ik} - B_{ik}`。 -/
theorem matrix_sub_apply {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) (i : Fin m) (k : Fin p) :
    (A - B) i k = A i k - B i k :=
  rfl

/-- **`def_zero_matrix`**: 零行列 `O` の成分はすべて `0`。 -/
theorem matrix_zero_apply {m p : ℕ} (i : Fin m) (k : Fin p) :
    (0 : Matrix (Fin m) (Fin p) ℂ) i k = 0 :=
  rfl

/-- **`def_matrix_scalar_multiple`** の数ベクトルの場合: `(λv)_i = λ v_i`。 -/
theorem vec_smul_apply {m : ℕ} (lam : ℂ) (v : Fin m → ℂ) (i : Fin m) : (lam • v) i = lam * v i :=
  rfl

/-- **`def_matrix_difference`** の数ベクトルの場合: `(u - w)_i = u_i - w_i`。 -/
theorem vec_sub_apply {m : ℕ} (u w : Fin m → ℂ) (i : Fin m) : (u - w) i = u i - w i :=
  rfl

/-- **`def_zero_matrix`** の数ベクトルの場合: 零ベクトルの成分はすべて `0`。 -/
theorem vec_zero_apply {m : ℕ} (i : Fin m) : (0 : Fin m → ℂ) i = 0 :=
  rfl

/-- **`mat_mult`**: `(Bv)_i = Σ_j B_{ij} v_j`。 -/
theorem mulVec_apply_sum {m n : ℕ} (B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) (i : Fin m) :
    (B *ᵥ v) i = ∑ j, B i j * v j :=
  rfl

/-- **`matrix_difference_zero_iff_equal`**: `A - B = O ⟺ A = B`（人手の同値の鎖）。 -/
theorem matrix_sub_eq_zero_iff {m p : ℕ} (A B : Matrix (Fin m) (Fin p) ℂ) : A - B = 0 ↔ A = B :=
  calc A - B = 0
      ↔ ∀ i k, (A - B) i k = (0 : Matrix (Fin m) (Fin p) ℂ) i k := Matrix.ext_iff.symm  -- 行列の等号は成分ごと
    _ ↔ ∀ i k, A i k - B i k = (0 : Matrix (Fin m) (Fin p) ℂ) i k := by
        simp only [matrix_sub_apply]                                                    -- `def_matrix_difference`
    _ ↔ ∀ i k, A i k - B i k = 0 := by simp only [matrix_zero_apply]                    -- `def_zero_matrix`
    _ ↔ ∀ i k, A i k = B i k := by simp only [sub_eq_zero]                              -- 移項
    _ ↔ A = B := Matrix.ext_iff                                                         -- 行列の等号は成分ごと

/-- **`matrix_difference_zero_iff_equal`** の数ベクトルの場合（`p = 1`）: `u - w = 0 ⟺ u = w`。 -/
theorem vec_sub_eq_zero_iff {m : ℕ} (u w : Fin m → ℂ) : u - w = 0 ↔ u = w :=
  calc u - w = 0
      ↔ ∀ i, (u - w) i = (0 : Fin m → ℂ) i := funext_iff               -- 数ベクトルの等号は成分ごと
    _ ↔ ∀ i, u i - w i = (0 : Fin m → ℂ) i := by simp only [vec_sub_apply]  -- `def_matrix_difference`
    _ ↔ ∀ i, u i - w i = 0 := by simp only [vec_zero_apply]                 -- `def_zero_matrix`
    _ ↔ ∀ i, u i = w i := by simp only [sub_eq_zero]                    -- 移項
    _ ↔ u = w := funext_iff.symm                                        -- 数ベクトルの等号は成分ごと

/-- **`identity_matrix_is_left_unit_of_mat_mult`**（右の因子が数ベクトル）の成分の鎖: `(I v)_i = v_i`。 -/
theorem identity_matrix_mulVec_apply {n : ℕ} (v : Fin n → ℂ) (i : Fin n) :
    ((1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ v) i = v i :=
  calc ((1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ v) i
      = ∑ j, (1 : Matrix (Fin n) (Fin n) ℂ) i j * v j := mulVec_apply_sum _ _ _   -- `mat_mult`
    _ = ∑ j, kroneckerDelta i j * v j := by simp only [identity_matrix_apply]   -- `def_identity_matrix`
    _ = kroneckerDelta i i * v i + ∑ j ∈ Finset.univ.erase i, kroneckerDelta i j * v j :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ i)).symm                    -- `j = i` の項を分ける
    _ = 1 * v i + ∑ j ∈ Finset.univ.erase i, 0 * v j := by
        congr 1
        · rw [kroneckerDelta_self]                                             -- `def_kronecker_delta`
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [kroneckerDelta_of_ne (Finset.ne_of_mem_erase hj).symm]           -- `def_kronecker_delta`
    _ = v i + ∑ j ∈ Finset.univ.erase i, 0 * v j := by rw [one_mul]           -- `1` は積の単位元
    _ = v i + ∑ j ∈ Finset.univ.erase i, (0 : ℂ) := by simp only [zero_mul]    -- `0·z = 0` を各項へ
    _ = v i := by rw [Finset.sum_const_zero, add_zero]                         -- `0` は加法の単位元

/-- **`identity_matrix_is_left_unit_of_mat_mult`**（右の因子が数ベクトル）: `I v = v`。 -/
theorem identity_matrix_mulVec {n : ℕ} (v : Fin n → ℂ) : (1 : Matrix (Fin n) (Fin n) ℂ) *ᵥ v = v :=
  funext (identity_matrix_mulVec_apply v)   -- 全ての成分が一致する

/-- **`scalar_multiple_factors_out_of_left_factor`**（右の因子が数ベクトル）の成分の鎖: `((λB)v)_i = (λ(Bv))_i`。 -/
theorem smul_mulVec_eq_apply {m n : ℕ} (lam : ℂ) (B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ)
    (i : Fin m) : ((lam • B) *ᵥ v) i = (lam • (B *ᵥ v)) i :=
  calc ((lam • B) *ᵥ v) i
      = ∑ j, (lam • B) i j * v j := mulVec_apply_sum _ _ _                 -- `mat_mult`
    _ = ∑ j, (lam * B i j) * v j := by simp only [matrix_smul_apply]       -- `def_matrix_scalar_multiple`
    _ = ∑ j, lam * (B i j * v j) := by simp only [mul_assoc]               -- 積の結合律
    _ = lam * ∑ j, B i j * v j := (Finset.mul_sum _ _ _).symm              -- 分配律
    _ = lam * (B *ᵥ v) i := by rw [mulVec_apply_sum]                       -- `mat_mult`
    _ = (lam • (B *ᵥ v)) i := (vec_smul_apply _ _ _).symm                  -- `def_matrix_scalar_multiple`

/-- **`scalar_multiple_factors_out_of_left_factor`**（右の因子が数ベクトル）: `(λB)v = λ(Bv)`。 -/
theorem smul_mulVec_eq {m n : ℕ} (lam : ℂ) (B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) :
    (lam • B) *ᵥ v = lam • (B *ᵥ v) :=
  funext (smul_mulVec_eq_apply lam B v)   -- 全ての成分が一致する

/-- **`matrix_difference_mul_vector`** の成分の鎖: `(Av - Bv)_i = ((A - B)v)_i`。 -/
theorem sub_mulVec_eq_apply {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) (i : Fin m) :
    (A *ᵥ v - B *ᵥ v) i = ((A - B) *ᵥ v) i :=
  calc (A *ᵥ v - B *ᵥ v) i
      = (A *ᵥ v) i - (B *ᵥ v) i := vec_sub_apply _ _ _                     -- `def_matrix_difference`
    _ = ∑ j, A i j * v j - ∑ j, B i j * v j := by
        rw [mulVec_apply_sum, mulVec_apply_sum]                            -- `mat_mult`
    _ = ∑ j, (A i j * v j - B i j * v j) := (Finset.sum_sub_distrib _ _).symm  -- 有限和の差は項ごとの差の和
    _ = ∑ j, (A i j - B i j) * v j := by simp only [sub_mul]               -- 分配則
    _ = ∑ j, (A - B) i j * v j := by simp only [matrix_sub_apply]          -- `def_matrix_difference`
    _ = ((A - B) *ᵥ v) i := (mulVec_apply_sum _ _ _).symm                  -- `mat_mult`

/-- **`matrix_difference_mul_vector`**: `Av - Bv = (A - B)v`。 -/
theorem sub_mulVec_eq {m n : ℕ} (A B : Matrix (Fin m) (Fin n) ℂ) (v : Fin n → ℂ) :
    A *ᵥ v - B *ᵥ v = (A - B) *ᵥ v :=
  funext (sub_mulVec_eq_apply A B v)   -- 全ての成分が一致する

end Ising2D
