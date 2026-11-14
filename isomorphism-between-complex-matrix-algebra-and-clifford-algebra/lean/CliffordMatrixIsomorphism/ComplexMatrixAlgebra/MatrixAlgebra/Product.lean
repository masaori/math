/-
章「複素行列環」の、行列の積の結合法則・分配法則・単位行列・スカラー倍との両立の具体版。人手証明と 1 対 1 に対応させる。
mathlib の `Matrix`・`Finset.sum` は使わない。

  本文のラベル                                                              このファイル
  claim_matrix_product_is_associative                                       mat_mul_assoc
  claim_matrix_product_distributes_over_sum_in_right_factor                 mat_mul_add
  claim_matrix_product_distributes_over_sum_in_left_factor                  mat_add_mul
  claim_identity_matrix_is_left_unit_of_matrix_product                      mat_one_mul
  claim_identity_matrix_is_right_unit_of_matrix_product                     mat_mul_one
  claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor    mat_smul_mul_left
  claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor   mat_smul_mul_right

和はどれも ℂ^vec（`complexNumbersVectorSpace`、証明の中では S と書く）の中の有限集合 X の上の和 `sumOverFiniteSet` で、
本文が引く有限集合の上の和の主張は次の宣言を V := ℂ^vec で引く。
  claim_sum_over_finite_set_depends_only_on_terms              sumOverFiniteSet_congr
  claim_scalar_multiple_of_sum_over_finite_set                 smul_sumOverFiniteSet
  claim_sum_of_sums_over_finite_set_with_same_family           sumOverFiniteSet_add_of_same_family
  claim_sum_of_sums_over_finite_set_with_same_coefficients     sumOverFiniteSet_add_of_same_coefficients
  claim_sum_over_finite_set_with_kronecker_delta_picks_term    sumOverFiniteSet_kroneckerDelta
  claim_interchange_of_double_sum_over_finite_sets             sumOverFiniteSet_interchange
本文が「各 z で +_{Mat_X}（など）の定義」と sumOverFiniteSet_congr を引く行は、項ごとの等式が `rfl` の
`sumOverFiniteSet_congr` の行である。

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Product.lean`、導出版は `MatrixAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.Definitions
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.DoubleSum

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

/-- 本文 `claim_matrix_product_is_associative`：(A · B) · C = A · (B · C)。 -/
theorem mat_mul_assoc (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX (Mat.mul hX A B) C = Mat.mul hX A (Mat.mul hX B C) := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  -- （準備）λ_{w,z} := A_{x,z} ·_ℂ B_{z,w}
  let lam : X → X → ℂ := fun w z => Mat.entry A x z * Mat.entry B z w
  -- （準備）p_w := Σ_{z∈X} A_{x,z} ·_{ℂ^vec} B_{z,w}
  let p : X → ℂ := fun w =>
    sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z w)
  -- （準備）u_w := p_w ·_{ℂ^vec} C_{w,y}
  let u : X → ℂ := fun w => S.smul (p w) (Mat.entry C w y)
  -- （準備）(C_{w,y} ·_ℂ A_{x,z}) ·_{ℂ^vec} B_{z,w} = λ_{w,z} ·_{ℂ^vec} C_{w,y}
  have hlam : ∀ w z : X, S.smul (Mat.entry C w y * Mat.entry A x z) (Mat.entry B z w)
      = S.smul (lam w z) (Mat.entry C w y) := fun w z => calc
    S.smul (Mat.entry C w y * Mat.entry A x z) (Mat.entry B z w)
        = (Mat.entry C w y * Mat.entry A x z) * Mat.entry B z w := rfl
    _ = Mat.entry C w y * (Mat.entry A x z * Mat.entry B z w) := by
        rw [_root_.mul_assoc (Mat.entry C w y) (Mat.entry A x z) (Mat.entry B z w)]
    _ = (Mat.entry A x z * Mat.entry B z w) * Mat.entry C w y := by
        rw [mul_comm (Mat.entry C w y) (Mat.entry A x z * Mat.entry B z w)]
    _ = lam w z * Mat.entry C w y := rfl
    _ = S.smul (lam w z) (Mat.entry C w y) := rfl
  -- （準備）u_w = Σ_{z∈X} λ_{w,z} ·_{ℂ^vec} C_{w,y}
  have hu : ∀ w : X, u w = sumOverFiniteSet S hX (fun z => lam w z) (fun _ => Mat.entry C w y) :=
    fun w => calc
    u w = S.smul (p w) (Mat.entry C w y) := rfl
    _ = p w * Mat.entry C w y := rfl
    _ = Mat.entry C w y * p w := by rw [mul_comm (p w) (Mat.entry C w y)]
    _ = S.smul (Mat.entry C w y) (p w) := rfl
    _ = S.smul (Mat.entry C w y)
          (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z w)) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry C w y * Mat.entry A x z) (fun z => Mat.entry B z w) :=
        smul_sumOverFiniteSet S hX _ _ (Mat.entry C w y)
    _ = sumOverFiniteSet S hX (fun z => lam w z) (fun _ => Mat.entry C w y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (hlam w)
  -- （準備）(A · B)_{x,w} = p_w
  have hAB : ∀ w : X, Mat.entry (Mat.mul hX A B) x w = p w := fun _ => rfl
  -- （準備）p_w ·_{ℂ^vec} C_{w,y} = u_w = 1_ℂ ·_{ℂ^vec} u_w
  have hpu : ∀ w : X, S.smul (p w) (Mat.entry C w y) = S.smul 1 (u w) := fun w => calc
    S.smul (p w) (Mat.entry C w y) = u w := rfl
    _ = S.smul 1 (u w) := (S.one_smul (u w)).symm
  -- （準備）(B · C)_{z,y} = Σ_{w∈X} B_{z,w} ·_{ℂ^vec} C_{w,y}
  have hBC : ∀ z : X, Mat.entry (Mat.mul hX B C) z y
      = sumOverFiniteSet S hX (fun w => Mat.entry B z w) (fun w => Mat.entry C w y) := fun _ => rfl
  calc Mat.entry (Mat.mul hX (Mat.mul hX A B) C) x y
      = sumOverFiniteSet S hX (fun w => Mat.entry (Mat.mul hX A B) x w) (fun w => Mat.entry C w y) := rfl
    _ = sumOverFiniteSet S hX (fun w => p w) (fun w => Mat.entry C w y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun w => by rw [hAB w])
    _ = sumOverFiniteSet S hX (fun _ => 1) (fun w => u w) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun w => hpu w)
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun w => sumOverFiniteSet S hX (fun z => lam w z) (fun _ => Mat.entry C w y)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun w => by rw [hu w])
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun z => sumOverFiniteSet S hX (fun w => lam w z) (fun w => Mat.entry C w y)) :=
        sumOverFiniteSet_interchange S hX hX lam (fun w _ => Mat.entry C w y)
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun z => S.smul (Mat.entry A x z)
            (sumOverFiniteSet S hX (fun w => Mat.entry B z w) (fun w => Mat.entry C w y))) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun z => by
          rw [smul_sumOverFiniteSet S hX (fun w => Mat.entry C w y) (fun w => Mat.entry B z w)
            (Mat.entry A x z)])
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z)
          (fun z => sumOverFiniteSet S hX (fun w => Mat.entry B z w) (fun w => Mat.entry C w y)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun z => S.one_smul _)
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.mul hX B C) z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun z => by rw [hBC z])
    _ = Mat.entry (Mat.mul hX A (Mat.mul hX B C)) x y := rfl

/-- 本文 `claim_matrix_product_distributes_over_sum_in_right_factor`：A · (B + C) = (A · B) + (A · C)。 -/
theorem mat_mul_add (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX A (Mat.add B C) = Mat.add (Mat.mul hX A B) (Mat.mul hX A C) := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  calc Mat.entry (Mat.mul hX A (Mat.add B C)) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.add B C) z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y + Mat.entry C z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z)
          (fun z => S.add (Mat.entry B z y) (Mat.entry C z y)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = S.add (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y))
          (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry C z y)) :=
        (sumOverFiniteSet_add_of_same_coefficients S hX _ _ _).symm
    _ = S.add (Mat.entry (Mat.mul hX A B) x y) (Mat.entry (Mat.mul hX A C) x y) := rfl
    _ = Mat.entry (Mat.mul hX A B) x y + Mat.entry (Mat.mul hX A C) x y := rfl
    _ = Mat.entry (Mat.add (Mat.mul hX A B) (Mat.mul hX A C)) x y := rfl

/-- 本文 `claim_matrix_product_distributes_over_sum_in_left_factor`：(A + B) · C = (A · C) + (B · C)。 -/
theorem mat_add_mul (hX : IsFiniteSet X) (A B C : Mat X) :
    Mat.mul hX (Mat.add A B) C = Mat.add (Mat.mul hX A C) (Mat.mul hX B C) := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  calc Mat.entry (Mat.mul hX (Mat.add A B) C) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.add A B) x z) (fun z => Mat.entry C z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z + Mat.entry B x z) (fun z => Mat.entry C z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = S.add (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry C z y))
          (sumOverFiniteSet S hX (fun z => Mat.entry B x z) (fun z => Mat.entry C z y)) :=
        (sumOverFiniteSet_add_of_same_family S hX _ _ _).symm
    _ = S.add (Mat.entry (Mat.mul hX A C) x y) (Mat.entry (Mat.mul hX B C) x y) := rfl
    _ = Mat.entry (Mat.mul hX A C) x y + Mat.entry (Mat.mul hX B C) x y := rfl
    _ = Mat.entry (Mat.add (Mat.mul hX A C) (Mat.mul hX B C)) x y := rfl

/-- 本文 `claim_identity_matrix_is_left_unit_of_matrix_product`：1 · A = A。 -/
theorem mat_one_mul (hX : IsFiniteSet X) [DecidableEq X] (A : Mat X) :
    Mat.mul hX Mat.one A = A := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  calc Mat.entry (Mat.mul hX Mat.one A) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.one : Mat X) x z) (fun z => Mat.entry A z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => kroneckerDelta x z) (fun z => Mat.entry A z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry A x y := sumOverFiniteSet_kroneckerDelta S hX (fun z => Mat.entry A z y) x

/-- 本文 `claim_identity_matrix_is_right_unit_of_matrix_product`：A · 1 = A。 -/
theorem mat_mul_one (hX : IsFiniteSet X) [DecidableEq X] (A : Mat X) :
    Mat.mul hX A Mat.one = A := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  -- （準備）A_{x,z} ·_{ℂ^vec} δ_{z,y} = δ_{y,z} ·_{ℂ^vec} A_{x,z}
  have hswap : ∀ z : X, S.smul (Mat.entry A x z) (kroneckerDelta z y)
      = S.smul (kroneckerDelta y z) (Mat.entry A x z) := fun z => calc
    S.smul (Mat.entry A x z) (kroneckerDelta z y) = Mat.entry A x z * kroneckerDelta z y := rfl
    _ = kroneckerDelta z y * Mat.entry A x z := by rw [mul_comm (Mat.entry A x z) (kroneckerDelta z y)]
    _ = kroneckerDelta y z * Mat.entry A x z := by
        -- z = y と y = z は同値なので、場合分けが一致する（def_kronecker_delta）
        by_cases hzy : z = y
        · rw [kroneckerDelta, kroneckerDelta, if_pos hzy, if_pos hzy.symm]
        · rw [kroneckerDelta, kroneckerDelta, if_neg hzy, if_neg (fun h => hzy h.symm)]
    _ = S.smul (kroneckerDelta y z) (Mat.entry A x z) := rfl
  calc Mat.entry (Mat.mul hX A Mat.one) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.one : Mat X) z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => kroneckerDelta z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun z => kroneckerDelta y z) (fun z => Mat.entry A x z) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hswap
    _ = Mat.entry A x y := sumOverFiniteSet_kroneckerDelta S hX (fun z => Mat.entry A x z) y

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor`：λ ∗ (A · B) = (λ ∗ A) · B。 -/
theorem mat_smul_mul_left (hX : IsFiniteSet X) (l : ℂ) (A B : Mat X) :
    Mat.smul l (Mat.mul hX A B) = Mat.mul hX (Mat.smul l A) B := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  calc Mat.entry (Mat.smul l (Mat.mul hX A B)) x y
      = l * Mat.entry (Mat.mul hX A B) x y := rfl
    _ = l * sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y) := rfl
    _ = S.smul l (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y)) := rfl
    _ = sumOverFiniteSet S hX (fun z => l * Mat.entry A x z) (fun z => Mat.entry B z y) :=
        smul_sumOverFiniteSet S hX _ _ l
    _ = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.smul l A) x z) (fun z => Mat.entry B z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry (Mat.mul hX (Mat.smul l A) B) x y := rfl

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor`：λ ∗ (A · B) = A · (λ ∗ B)。 -/
theorem mat_smul_mul_right (hX : IsFiniteSet X) (l : ℂ) (A B : Mat X) :
    Mat.smul l (Mat.mul hX A B) = Mat.mul hX A (Mat.smul l B) := Mat.ext fun x y => by
  let S := complexNumbersVectorSpace
  -- （準備）(λ ·_ℂ A_{x,z}) ·_{ℂ^vec} B_{z,y} = A_{x,z} ·_{ℂ^vec} (λ ·_ℂ B_{z,y})
  have hmove : ∀ z : X, S.smul (l * Mat.entry A x z) (Mat.entry B z y)
      = S.smul (Mat.entry A x z) (l * Mat.entry B z y) := fun z => calc
    S.smul (l * Mat.entry A x z) (Mat.entry B z y) = (l * Mat.entry A x z) * Mat.entry B z y := rfl
    _ = (Mat.entry A x z * l) * Mat.entry B z y := by rw [mul_comm l (Mat.entry A x z)]
    _ = Mat.entry A x z * (l * Mat.entry B z y) := by
        rw [_root_.mul_assoc (Mat.entry A x z) l (Mat.entry B z y)]
    _ = S.smul (Mat.entry A x z) (l * Mat.entry B z y) := rfl
  calc Mat.entry (Mat.smul l (Mat.mul hX A B)) x y
      = l * Mat.entry (Mat.mul hX A B) x y := rfl
    _ = l * sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y) := rfl
    _ = S.smul l (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y)) := rfl
    _ = sumOverFiniteSet S hX (fun z => l * Mat.entry A x z) (fun z => Mat.entry B z y) :=
        smul_sumOverFiniteSet S hX _ _ l
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => l * Mat.entry B z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hmove
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.smul l B) z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry (Mat.mul hX A (Mat.smul l B)) x y := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
