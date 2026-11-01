/-
# 単位行列とスカラー倍の、行列同士の積での性質（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityAndScalarMultipleInMatrixProduct.lean`
（人手 `identity_matrix_is_left_unit_of_mat_mult`・`identity_matrix_is_right_unit_of_mat_mult`・
`scalar_multiple_factors_out_of_left_factor`・`scalar_multiple_factors_out_of_right_factor`）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityAndScalarMultipleInMatrixProductFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `identity_matrix_mul_apply`（積の定義 → 単位行列の成分 `δ_{ij}` → `j = i` の項を分ける → `δ` の値 → `1·x = x` → `0·x = 0` → `0` の有限和と `x + 0 = x`） | `one_mul_matrix_apply` |
| `mul_identity_matrix_apply`（積の定義 → `δ_{jk}` → `j = k` の項を分ける → `δ` の値 → `x·1 = x` → `x·0 = 0` → `0` の有限和と `x + 0 = x`） | `mul_one_matrix_apply` |
| `smul_mul_matrix_apply`（積の定義 → スカラー倍の定義 → 結合則 → 左分配則 → 積の定義 → スカラー倍の定義） | `smul_mul_matrix_apply'` |
| `mul_smul_matrix_apply`（積の定義 → スカラー倍の定義 → 結合則 → 交換則 → 結合則 → 左分配則 → 積の定義 → スカラー倍の定義） | `mul_smul_matrix_apply'` |

## 何が効いているか / 効いていないか

- **仮定の型クラスについて**: 行列の積 `Matrix.mul` の定義そのものが係数に `NonUnitalNonAssocSemiring` を要求するので、
  各定理の型クラスはそれより弱くできない。
- 添字は有限であること（`Fintype`。積が有限和だから）だけが効き、`Fin n` の順序は効いていない。単位行列には添字の等号の判定が要る。
- `I A = A` に効くのは、`1·x = x`・`0·x = 0`・`x + 0 = x` と有限和の取り出しだけである（`NonAssocSemiring`）。
- `A I = A` に効くのは、`x·1 = x`・`x·0 = 0`・`x + 0 = x` と有限和の取り出しだけである（`NonAssocSemiring`）。
  乗法の可換則は効いていない（右から `0` を掛けた項は `x·0 = 0` でそのまま消える）。
- `(aA)B = a(AB)` に効くのは、乗法の結合則と左分配則である（`NonUnitalSemiring`）。乗法の可換則は効いていない。
- `A(aB) = a(AB)` には、**乗法の可換則が効いている**（`NonUnitalCommSemiring`）: `A_{ij}(aB_{jk})` の `a` を `A_{ij}` の左へ
  移す段がある。外せないことは、添字 `Unit`（`1×1`）・`B = 1` に制限すると乗法の可換則そのものが出ることで確かめる
  （`mul_comm_of_mul_smul_matrix`）。
- 複素数であること、体であること、加法逆元は効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

open Matrix

variable {ι κ μ : Type*}

/-- **`(I A)_{ik} = A_{ik}`**（具体版 `identity_matrix_mul_apply`）。係数は `NonAssocSemiring`。 -/
theorem one_mul_matrix_apply {R : Type*} [NonAssocSemiring R] [Fintype ι] [DecidableEq ι]
    (A : Matrix ι κ R) (i : ι) (k : κ) : ((1 : Matrix ι ι R) * A) i k = A i k :=
  calc ((1 : Matrix ι ι R) * A) i k
      = ∑ j, (1 : Matrix ι ι R) i j * A j k := rfl                                   -- 積の定義
    _ = ∑ j, (if i = j then (1 : R) else 0) * A j k := by simp only [Matrix.one_apply] -- 単位行列の成分 `δ_{ij}`
    _ = (if i = i then (1 : R) else 0) * A i k
          + ∑ j ∈ Finset.univ.erase i, (if i = j then (1 : R) else 0) * A j k :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ i)).symm                         -- `j = i` の項を分ける
    _ = 1 * A i k + ∑ j ∈ Finset.univ.erase i, 0 * A j k := by
        congr 1
        · rw [if_pos rfl]                                                           -- `δ_{ii} = 1`
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [if_neg (Finset.ne_of_mem_erase hj).symm]                             -- `δ_{ij} = 0`
    _ = A i k + ∑ j ∈ Finset.univ.erase i, 0 * A j k := by rw [one_mul]            -- `1·x = x`
    _ = A i k + ∑ j ∈ Finset.univ.erase i, (0 : R) := by simp only [zero_mul]       -- `0·x = 0` を各項へ
    _ = A i k := by rw [Finset.sum_const_zero, add_zero]                            -- `0` は加法の単位元

/-- **`(A I)_{ik} = A_{ik}`**（具体版 `mul_identity_matrix_apply`）。係数は `NonAssocSemiring`（可換則は使わない）。 -/
theorem mul_one_matrix_apply {R : Type*} [NonAssocSemiring R] [Fintype κ] [DecidableEq κ]
    (A : Matrix ι κ R) (i : ι) (k : κ) : (A * (1 : Matrix κ κ R)) i k = A i k :=
  calc (A * (1 : Matrix κ κ R)) i k
      = ∑ j, A i j * (1 : Matrix κ κ R) j k := rfl                                   -- 積の定義
    _ = ∑ j, A i j * (if j = k then (1 : R) else 0) := by simp only [Matrix.one_apply] -- 単位行列の成分 `δ_{jk}`
    _ = A i k * (if k = k then (1 : R) else 0)
          + ∑ j ∈ Finset.univ.erase k, A i j * (if j = k then (1 : R) else 0) :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ k)).symm                         -- `j = k` の項を分ける
    _ = A i k * 1 + ∑ j ∈ Finset.univ.erase k, A i j * 0 := by
        congr 1
        · rw [if_pos rfl]                                                           -- `δ_{kk} = 1`
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [if_neg (Finset.ne_of_mem_erase hj)]                                  -- `δ_{jk} = 0`
    _ = A i k + ∑ j ∈ Finset.univ.erase k, A i j * 0 := by rw [mul_one]            -- `x·1 = x`
    _ = A i k + ∑ j ∈ Finset.univ.erase k, (0 : R) := by simp only [mul_zero]       -- `x·0 = 0` を各項へ
    _ = A i k := by rw [Finset.sum_const_zero, add_zero]                            -- `0` は加法の単位元

/-- **`((aA)B)_{ik} = (a(AB))_{ik}`**（具体版 `smul_mul_matrix_apply`）。係数は `NonUnitalSemiring`（可換則は使わない）。 -/
theorem smul_mul_matrix_apply' {R : Type*} [NonUnitalSemiring R] [Fintype κ] (a : R)
    (A : Matrix ι κ R) (B : Matrix κ μ R) (i : ι) (k : μ) : ((a • A) * B) i k = (a • (A * B)) i k :=
  calc ((a • A) * B) i k
      = ∑ j, (a • A) i j * B j k := rfl                        -- 積の定義
    _ = ∑ j, (a * A i j) * B j k := rfl                        -- スカラー倍の定義
    _ = ∑ j, a * (A i j * B j k) := by simp only [mul_assoc]   -- 乗法の結合則
    _ = a * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm  -- 左分配則
    _ = a * (A * B) i k := rfl                                 -- 積の定義
    _ = (a • (A * B)) i k := rfl                               -- スカラー倍の定義

/-- **`(A(aB))_{ik} = (a(AB))_{ik}`**（具体版 `mul_smul_matrix_apply`）。係数は `NonUnitalCommSemiring`。 -/
theorem mul_smul_matrix_apply' {R : Type*} [NonUnitalCommSemiring R] [Fintype κ] (a : R)
    (A : Matrix ι κ R) (B : Matrix κ μ R) (i : ι) (k : μ) : (A * (a • B)) i k = (a • (A * B)) i k :=
  calc (A * (a • B)) i k
      = ∑ j, A i j * (a • B) j k := rfl                        -- 積の定義
    _ = ∑ j, A i j * (a * B j k) := rfl                        -- スカラー倍の定義
    _ = ∑ j, (A i j * a) * B j k := by simp only [mul_assoc]   -- 乗法の結合則
    _ = ∑ j, (a * A i j) * B j k := by simp only [mul_comm _ a] -- 乗法の可換則
    _ = ∑ j, a * (A i j * B j k) := by simp only [mul_assoc]   -- 乗法の結合則
    _ = a * ∑ j, A i j * B j k := (Finset.mul_sum _ _ _).symm  -- 左分配則
    _ = a * (A * B) i k := rfl                                 -- 積の定義
    _ = (a • (A * B)) i k := rfl                               -- スカラー倍の定義

/-- **可換則が外せないことの確認**: `A(aB) = a(AB)` が添字 `Unit` の `1×1` 行列で成り立てば、係数の乗法は可換である。 -/
theorem mul_comm_of_mul_smul_matrix {R : Type*} [Semiring R]
    (h : ∀ (a : R) (A B : Matrix Unit Unit R), A * (a • B) = a • (A * B)) (a x : R) : x * a = a * x := by
  have := congrFun (congrFun (h a (fun _ _ => x) 1) ()) ()
  simpa [Matrix.mul_apply] using this

/-- `I A = A`。 -/
theorem one_mul_matrix {R : Type*} [NonAssocSemiring R] [Fintype ι] [DecidableEq ι] (A : Matrix ι κ R) :
    (1 : Matrix ι ι R) * A = A :=
  Matrix.ext (one_mul_matrix_apply A)

/-- `A I = A`。 -/
theorem mul_one_matrix {R : Type*} [NonAssocSemiring R] [Fintype κ] [DecidableEq κ] (A : Matrix ι κ R) :
    A * (1 : Matrix κ κ R) = A :=
  Matrix.ext (mul_one_matrix_apply A)

/-- `(aA)B = a(AB)`。 -/
theorem smul_mul_matrix' {R : Type*} [NonUnitalSemiring R] [Fintype κ] (a : R) (A : Matrix ι κ R)
    (B : Matrix κ μ R) : (a • A) * B = a • (A * B) :=
  Matrix.ext (smul_mul_matrix_apply' a A B)

/-- `A(aB) = a(AB)`。 -/
theorem mul_smul_matrix' {R : Type*} [NonUnitalCommSemiring R] [Fintype κ] (a : R) (A : Matrix ι κ R)
    (B : Matrix κ μ R) : A * (a • B) = a • (A * B) :=
  Matrix.ext (mul_smul_matrix_apply' a A B)

end Ising2D.NecSuf
