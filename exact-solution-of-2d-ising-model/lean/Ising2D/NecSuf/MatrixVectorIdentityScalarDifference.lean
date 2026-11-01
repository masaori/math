/-
# 単位行列・スカラー倍・差の数ベクトルへの作用（必要十分版）

具体版: `Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectors.lean`
（人手 `matrix_difference_zero_iff_equal`・`identity_matrix_is_left_unit_of_mat_mult`・`scalar_multiple_factors_out_of_left_factor`・
`matrix_difference_mul_vector`。中の 2 つは右の因子が数ベクトルの場合）。
具体版をこのファイルの系として導くのは
`Ising2D/MathematicalTools/FiniteMatricesPauliMatricesAndCommutators/ClaimIdentityScalarMultipleAndDifferenceOnVectorsFromNecSuf.lean`。

| 具体版の段 | 必要十分版 |
| --- | --- |
| `matrix_sub_eq_zero_iff`・`vec_sub_eq_zero_iff`（成分ごとの等号 → 差の定義 → 零行列の定義 → 移項 → 成分ごとの等号） | `sub_eq_zero_iff_matrix`・`sub_eq_zero_iff_vec` |
| `identity_matrix_mulVec_apply`（積の定義 → 単位行列の成分 `δ_{ij}` → `j = i` の項を分ける → `δ` の値 → `1·x = x` → `0·x = 0` → `0` の有限和と `x + 0 = x`） | `one_mulVec_apply` |
| `smul_mulVec_eq_apply`（積の定義 → スカラー倍の定義 → 乗法の結合則 → 左分配則 → 積の定義 → スカラー倍の定義） | `smul_mulVec_apply` |
| `sub_mulVec_eq_apply`（差の定義 → 積の定義 → 有限和の差 → 分配則 → 差の定義 → 積の定義） | `sub_mulVec_apply` |

## 何が効いているか / 効いていないか

- **仮定の型クラスについて**: 行列とベクトルの積 `Matrix.mulVec` の定義そのものが係数に `NonUnitalNonAssocSemiring`
  （加法の可換モノイドと両側の分配則）を要求するので、各定理の型クラスはそれより弱くできない。証明が実際に使う性質は下に挙げたものだけで、
  型クラスに含まれるそれ以外の性質（`I v = v` での両側の分配則、`(λB)v = λ(Bv)` での右分配則、`Av - Bv = (A - B)v` での左分配則など）は、
  積の定義が要求するために残している仮定であって、証明では使っていない。
- 添字は有限であること（`Fintype`。行列とベクトルの積が有限和だから）だけが効き、`Fin n` の順序は効いていない。
  単位行列には添字の等号の判定（`DecidableEq`）が要る。
- `A - B = O ⟺ A = B` に効くのは、係数の加法群の構造（移項 `x - y = 0 ⟺ x = y`）だけである。乗法は現れない。
- `I v = v` に効くのは、`1·x = x`・`0·x = 0`・`x + 0 = x` と有限和の取り出しだけである（`NonAssocSemiring`）。
  乗法の結合則も可換則も、加法逆元も効いていない。
- `(λB)v = λ(Bv)` に効くのは、乗法の結合則（`(λB_{ij})v_j = λ(B_{ij}v_j)`）と左分配則（`λ` を有限和の外へ出す）である
  （`NonUnitalSemiring`）。**乗法の可換則は効いていない**: スカラーは左から掛け、行列とベクトルの積も左の行列の成分を左に置くので、
  順序を入れ替える段が無い。結合則は外せない: 主張を添字 `Unit`（`1×1`）に制限すると乗法の結合則そのものが出る
  （`mul_assoc_of_smul_mulVec`）。
- `Av - Bv = (A - B)v` に効くのは、有限和の差（加法群）と右分配則（`(x - y)z = xz - yz`）である（`NonUnitalNonAssocRing`）。
  乗法の結合則・可換則・単位元は効いていない。
- 複素数であること、体であることは効いていない。
-/
import Mathlib.Data.Matrix.Mul
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.BigOperators.Ring.Finset

namespace Ising2D.NecSuf

open Matrix

variable {ι κ : Type*}

/-- **`A - B = O ⟺ A = B`**（具体版 `matrix_sub_eq_zero_iff`）。係数は加法群。 -/
theorem sub_eq_zero_iff_matrix {R : Type*} [AddGroup R] (A B : Matrix ι κ R) : A - B = 0 ↔ A = B :=
  calc A - B = 0
      ↔ ∀ i k, (A - B) i k = (0 : Matrix ι κ R) i k := Matrix.ext_iff.symm  -- 行列の等号は成分ごと
    _ ↔ ∀ i k, A i k - B i k = (0 : Matrix ι κ R) i k := Iff.rfl            -- 差の定義
    _ ↔ ∀ i k, A i k - B i k = 0 := Iff.rfl                                 -- 零行列の定義
    _ ↔ ∀ i k, A i k = B i k := by simp only [sub_eq_zero]                  -- 移項
    _ ↔ A = B := Matrix.ext_iff                                             -- 行列の等号は成分ごと

/-- **`u - w = 0 ⟺ u = w`**（具体版 `vec_sub_eq_zero_iff`）。係数は加法群。 -/
theorem sub_eq_zero_iff_vec {R : Type*} [AddGroup R] (u w : ι → R) : u - w = 0 ↔ u = w :=
  calc u - w = 0
      ↔ ∀ i, (u - w) i = (0 : ι → R) i := funext_iff     -- 数ベクトルの等号は成分ごと
    _ ↔ ∀ i, u i - w i = (0 : ι → R) i := Iff.rfl        -- 差の定義
    _ ↔ ∀ i, u i - w i = 0 := Iff.rfl                     -- 零ベクトルの定義
    _ ↔ ∀ i, u i = w i := by simp only [sub_eq_zero]      -- 移項
    _ ↔ u = w := funext_iff.symm                          -- 数ベクトルの等号は成分ごと

/-- **`(I v)_i = v_i`**（具体版 `identity_matrix_mulVec_apply`）。係数は `NonAssocSemiring`。 -/
theorem one_mulVec_apply {R : Type*} [NonAssocSemiring R] [Fintype ι] [DecidableEq ι] (v : ι → R) (i : ι) :
    ((1 : Matrix ι ι R) *ᵥ v) i = v i :=
  calc ((1 : Matrix ι ι R) *ᵥ v) i
      = ∑ j, (1 : Matrix ι ι R) i j * v j := rfl                                    -- 積の定義
    _ = ∑ j, (if i = j then (1 : R) else 0) * v j := by simp only [Matrix.one_apply]  -- 単位行列の成分 `δ_{ij}`
    _ = (if i = i then (1 : R) else 0) * v i
          + ∑ j ∈ Finset.univ.erase i, (if i = j then (1 : R) else 0) * v j :=
        (Finset.add_sum_erase _ _ (Finset.mem_univ i)).symm                          -- `j = i` の項を分ける
    _ = 1 * v i + ∑ j ∈ Finset.univ.erase i, 0 * v j := by
        congr 1
        · rw [if_pos rfl]                                                            -- `δ_{ii} = 1`
        · refine Finset.sum_congr rfl fun j hj => ?_
          rw [if_neg (Finset.ne_of_mem_erase hj).symm]                              -- `δ_{ij} = 0`
    _ = v i + ∑ j ∈ Finset.univ.erase i, 0 * v j := by rw [one_mul]                 -- `1·x = x`
    _ = v i + ∑ j ∈ Finset.univ.erase i, (0 : R) := by simp only [zero_mul]          -- `0·x = 0` を各項へ
    _ = v i := by rw [Finset.sum_const_zero, add_zero]                               -- `0` は加法の単位元

/-- **`((λB)v)_i = (λ(Bv))_i`**（具体版 `smul_mulVec_eq_apply`）。係数は `NonUnitalSemiring`（可換則は使わない）。 -/
theorem smul_mulVec_apply {R : Type*} [NonUnitalSemiring R] [Fintype κ] (lam : R) (B : Matrix ι κ R)
    (v : κ → R) (i : ι) : ((lam • B) *ᵥ v) i = (lam • (B *ᵥ v)) i :=
  calc ((lam • B) *ᵥ v) i
      = ∑ j, (lam • B) i j * v j := rfl                          -- 積の定義
    _ = ∑ j, (lam * B i j) * v j := rfl                          -- スカラー倍の定義
    _ = ∑ j, lam * (B i j * v j) := by simp only [mul_assoc]     -- 乗法の結合則
    _ = lam * ∑ j, B i j * v j := (Finset.mul_sum _ _ _).symm    -- 左分配則
    _ = lam * (B *ᵥ v) i := rfl                                  -- 積の定義
    _ = (lam • (B *ᵥ v)) i := rfl                                -- スカラー倍の定義

/-- **`(Av - Bv)_i = ((A - B)v)_i`**（具体版 `sub_mulVec_eq_apply`）。係数は `NonUnitalNonAssocRing`。 -/
theorem sub_mulVec_apply {R : Type*} [NonUnitalNonAssocRing R] [Fintype κ] (A B : Matrix ι κ R)
    (v : κ → R) (i : ι) : (A *ᵥ v - B *ᵥ v) i = ((A - B) *ᵥ v) i :=
  calc (A *ᵥ v - B *ᵥ v) i
      = (A *ᵥ v) i - (B *ᵥ v) i := rfl                                     -- 差の定義
    _ = ∑ j, A i j * v j - ∑ j, B i j * v j := rfl                         -- 積の定義
    _ = ∑ j, (A i j * v j - B i j * v j) := (Finset.sum_sub_distrib _ _).symm  -- 有限和の差
    _ = ∑ j, (A i j - B i j) * v j := by simp only [sub_mul]               -- 右分配則
    _ = ∑ j, (A - B) i j * v j := rfl                                      -- 差の定義
    _ = ((A - B) *ᵥ v) i := rfl                                            -- 積の定義

/-- **結合則が外せないことの確認**: `(λB)v = λ(Bv)` が添字 `Unit` の `1×1` 行列で成り立てば、係数の乗法は結合的である。
したがって `smul_mulVec_apply` の `NonUnitalSemiring`（結合則）は、積の定義が要求する `NonUnitalNonAssocSemiring` へ弱められない。 -/
theorem mul_assoc_of_smul_mulVec {R : Type*} [NonUnitalNonAssocSemiring R]
    (h : ∀ (lam : R) (B : Matrix Unit Unit R) (v : Unit → R), (lam • B) *ᵥ v = lam • (B *ᵥ v))
    (a b c : R) : a * (b * c) = a * b * c := by
  have := congrFun (h a (fun _ _ => b) (fun _ => c)) ()
  simpa [Matrix.mulVec, dotProduct] using this.symm

/-- `I v = v`。 -/
theorem one_mulVec_eq {R : Type*} [NonAssocSemiring R] [Fintype ι] [DecidableEq ι] (v : ι → R) :
    (1 : Matrix ι ι R) *ᵥ v = v :=
  funext (one_mulVec_apply v)

/-- `(λB)v = λ(Bv)`。 -/
theorem smul_mulVec_eq' {R : Type*} [NonUnitalSemiring R] [Fintype κ] (lam : R) (B : Matrix ι κ R)
    (v : κ → R) : (lam • B) *ᵥ v = lam • (B *ᵥ v) :=
  funext (smul_mulVec_apply lam B v)

/-- `Av - Bv = (A - B)v`。 -/
theorem sub_mulVec_eq' {R : Type*} [NonUnitalNonAssocRing R] [Fintype κ] (A B : Matrix ι κ R) (v : κ → R) :
    A *ᵥ v - B *ᵥ v = (A - B) *ᵥ v :=
  funext (sub_mulVec_apply A B v)

end Ising2D.NecSuf
