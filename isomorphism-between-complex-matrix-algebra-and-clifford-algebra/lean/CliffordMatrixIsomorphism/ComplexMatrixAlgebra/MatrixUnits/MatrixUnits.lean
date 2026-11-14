/-
章「複素行列環」の、行列単位とその積の規則、成分を取り出す写像、単位行列と行列の行列単位による分解の具体版。
人手証明と 1 対 1 に対応させる。mathlib の `Matrix`・`Finset.sum` は使わない。

  本文のラベル                                                     このファイル
  def_matrix_unit                                                  matrixUnit・entry_matrixUnit
  claim_product_of_matrix_units                                    matrixUnit_mul_matrixUnit
  claim_matrix_entry_map_is_linear_map                             entryMap・entryMap_isComplexLinearMap
  claim_decomposition_of_identity_matrix_into_matrix_units         sum_matrixUnit_diagonal_eq_one
  claim_matrix_is_double_sum_of_entries_times_matrix_units         eq_double_sum_entry_smul_matrixUnit

本文が「i = j と j = i は同値なので、場合分けが一致する」（def_kronecker_delta）とする行は、
`MatrixUnits.kroneckerDelta_swap` を一回当てる行である（同じ定理を二か所へ当てる行は二回の rw を一行に書く）。
本文の行列単位の定義は X が有限集合であることを前提に置くが、定義は有限性を使わない（和を含まない）ので、
`matrixUnit` は X の等号の判定 `[DecidableEq X]` だけをとる（`Mat.one` と同じ）。

和は、Mat_X(ℂ) の中の和は ℂ-線型空間 `matricesVectorSpace X` の中の、それ以外は ℂ^vec（`complexNumbersVectorSpace`、
証明の中では S と書く）の中の有限集合 X の上の和 `sumOverFiniteSet` である。本文が引く有限集合の上の和の主張は次の宣言で引く。
  claim_sum_over_finite_set_depends_only_on_terms                             sumOverFiniteSet_congr
  claim_sum_over_finite_set_with_kronecker_delta_picks_term                   sumOverFiniteSet_kroneckerDelta
  claim_linear_map_maps_sum_over_finite_set_to_sum_of_values                  IsComplexLinearMap.map_sumOverFiniteSet
  claim_double_sums_over_finite_sets_with_equal_terms_are_equal               sumOverFiniteSet_double_congr
  claim_linear_map_maps_double_sum_over_finite_sets_to_double_sum_of_values   IsComplexLinearMap.map_double_sumOverFiniteSet

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixUnits/MatrixUnits.lean`、導出版は `MatrixUnitsFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixAlgebra.VectorSpace

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

variable {X : Type u}

namespace MatrixUnits

/-- 本文 `def_kronecker_delta` の「i = j と j = i は同値なので、場合分けが一致する」行：δ_{i,j} = δ_{j,i}。 -/
theorem kroneckerDelta_swap [DecidableEq X] (i j : X) : kroneckerDelta i j = kroneckerDelta j i := by
  by_cases hij : i = j
  · rw [kroneckerDelta, kroneckerDelta, if_pos hij, if_pos hij.symm]
  · rw [kroneckerDelta, kroneckerDelta, if_neg hij, if_neg (fun h => hij h.symm)]

end MatrixUnits

open MatrixUnits

/-- 本文 `def_matrix_unit`：(E_{x,y})_{u,v} := δ_{x,u} ·_ℂ δ_{y,v}。 -/
def matrixUnit [DecidableEq X] (x y : X) : Mat X := fun p => kroneckerDelta x p.1 * kroneckerDelta y p.2

theorem entry_matrixUnit [DecidableEq X] (x y u v : X) :
    Mat.entry (matrixUnit x y) u v = kroneckerDelta x u * kroneckerDelta y v := rfl

/-- 本文 `claim_product_of_matrix_units`：E_{x,y} ·_{Mat_X} E_{z,w} = δ_{y,z} ∗_{Mat_X} E_{x,w}。 -/
theorem matrixUnit_mul_matrixUnit (hX : IsFiniteSet X) [DecidableEq X] (x y z w : X) :
    Mat.mul hX (matrixUnit x y) (matrixUnit z w) = Mat.smul (kroneckerDelta y z) (matrixUnit x w) :=
  Mat.ext fun p q => by
  let S := complexNumbersVectorSpace
  -- （準備）r_t := (δ_{x,p} ·_ℂ δ_{w,q}) ·_ℂ δ_{z,t}
  let r : X → ℂ := fun t => (kroneckerDelta x p * kroneckerDelta w q) * kroneckerDelta z t
  -- （準備）(δ_{x,p} ·_ℂ δ_{y,t}) ·_{ℂ^vec} (δ_{z,t} ·_ℂ δ_{w,q}) = δ_{y,t} ·_{ℂ^vec} r_t
  have hprep : ∀ t : X,
      S.smul (kroneckerDelta x p * kroneckerDelta y t) (kroneckerDelta z t * kroneckerDelta w q)
        = S.smul (kroneckerDelta y t) (r t) := fun t => calc
    S.smul (kroneckerDelta x p * kroneckerDelta y t) (kroneckerDelta z t * kroneckerDelta w q)
        = (kroneckerDelta x p * kroneckerDelta y t) * (kroneckerDelta z t * kroneckerDelta w q) := rfl
    _ = (kroneckerDelta y t * kroneckerDelta x p) * (kroneckerDelta z t * kroneckerDelta w q) := by
        rw [mul_comm (kroneckerDelta x p) (kroneckerDelta y t)]
    _ = kroneckerDelta y t * (kroneckerDelta x p * (kroneckerDelta z t * kroneckerDelta w q)) := by
        rw [_root_.mul_assoc (kroneckerDelta y t) (kroneckerDelta x p)
          (kroneckerDelta z t * kroneckerDelta w q)]
    _ = kroneckerDelta y t * (kroneckerDelta x p * (kroneckerDelta w q * kroneckerDelta z t)) := by
        rw [mul_comm (kroneckerDelta z t) (kroneckerDelta w q)]
    _ = kroneckerDelta y t * ((kroneckerDelta x p * kroneckerDelta w q) * kroneckerDelta z t) := by
        rw [_root_.mul_assoc (kroneckerDelta x p) (kroneckerDelta w q) (kroneckerDelta z t)]
    _ = kroneckerDelta y t * r t := rfl
    _ = S.smul (kroneckerDelta y t) (r t) := rfl
  calc Mat.entry (Mat.mul hX (matrixUnit x y) (matrixUnit z w)) p q
      = sumOverFiniteSet S hX (fun t => Mat.entry (matrixUnit x y) p t)
          (fun t => Mat.entry (matrixUnit z w) t q) := rfl
    _ = sumOverFiniteSet S hX (fun t => kroneckerDelta x p * kroneckerDelta y t)
          (fun t => kroneckerDelta z t * kroneckerDelta w q) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun t => kroneckerDelta y t) (fun t => r t) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hprep
    _ = r y := sumOverFiniteSet_kroneckerDelta S hX (fun t => r t) y
    _ = (kroneckerDelta x p * kroneckerDelta w q) * kroneckerDelta z y := rfl
    _ = kroneckerDelta z y * (kroneckerDelta x p * kroneckerDelta w q) := by
        rw [mul_comm (kroneckerDelta x p * kroneckerDelta w q) (kroneckerDelta z y)]
    _ = kroneckerDelta y z * (kroneckerDelta x p * kroneckerDelta w q) := by
        rw [kroneckerDelta_swap z y]
    _ = kroneckerDelta y z * Mat.entry (matrixUnit x w) p q := rfl
    _ = Mat.entry (Mat.smul (kroneckerDelta y z) (matrixUnit x w)) p q := rfl

/-- 本文 `claim_matrix_entry_map_is_linear_map` の ent_{p,q}：ent_{p,q}(A) := A_{p,q}。 -/
def entryMap (p q : X) : Mat X → ℂ := fun A => Mat.entry A p q

/-- 本文 `claim_matrix_entry_map_is_linear_map`：ent_{p,q} は Mat_X(ℂ) から ℂ^vec への線型写像である。 -/
theorem entryMap_isComplexLinearMap (X : Type u) (p q : X) :
    IsComplexLinearMap (matricesVectorSpace X) complexNumbersVectorSpace (entryMap p q) where
  map_add A B := calc
    entryMap p q ((matricesVectorSpace X).add A B) = Mat.entry (Mat.add A B) p q := rfl
    _ = Mat.entry A p q + Mat.entry B p q := rfl
    _ = complexNumbersVectorSpace.add (Mat.entry A p q) (Mat.entry B p q) := rfl
    _ = complexNumbersVectorSpace.add (entryMap p q A) (entryMap p q B) := rfl
  map_smul l A := calc
    entryMap p q ((matricesVectorSpace X).smul l A) = Mat.entry (Mat.smul l A) p q := rfl
    _ = l * Mat.entry A p q := rfl
    _ = complexNumbersVectorSpace.smul l (Mat.entry A p q) := rfl
    _ = complexNumbersVectorSpace.smul l (entryMap p q A) := rfl

/-- 本文 `claim_decomposition_of_identity_matrix_into_matrix_units`：Σ_{x∈X} 1_ℂ ∗_{Mat_X} E_{x,x} = 1_{Mat_X}。 -/
theorem sum_matrixUnit_diagonal_eq_one (hX : IsFiniteSet X) [DecidableEq X] :
    sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1) (fun x => matrixUnit x x) = Mat.one :=
  Mat.ext fun p q => by
  let S := complexNumbersVectorSpace
  -- （準備）1_ℂ ·_{ℂ^vec} ent_{p,q}(E_{x,x}) = δ_{p,x} ·_{ℂ^vec} δ_{q,x}
  have hprep : ∀ x : X, S.smul 1 (entryMap p q (matrixUnit x x))
      = S.smul (kroneckerDelta p x) (kroneckerDelta q x) := fun x => calc
    S.smul 1 (entryMap p q (matrixUnit x x)) = S.smul 1 (Mat.entry (matrixUnit x x) p q) := rfl
    _ = S.smul 1 (kroneckerDelta x p * kroneckerDelta x q) := rfl
    _ = 1 * (kroneckerDelta x p * kroneckerDelta x q) := rfl
    _ = kroneckerDelta x p * kroneckerDelta x q := by
        rw [_root_.one_mul (kroneckerDelta x p * kroneckerDelta x q)]
    _ = kroneckerDelta p x * kroneckerDelta q x := by
        rw [kroneckerDelta_swap x p, kroneckerDelta_swap x q]
    _ = S.smul (kroneckerDelta p x) (kroneckerDelta q x) := rfl
  calc Mat.entry (sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1) (fun x => matrixUnit x x)) p q
      = entryMap p q
          (sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1) (fun x => matrixUnit x x)) := rfl
    _ = sumOverFiniteSet S hX (fun _ => 1) (fun x => entryMap p q (matrixUnit x x)) :=
        (entryMap_isComplexLinearMap X p q).map_sumOverFiniteSet hX _ _
    _ = sumOverFiniteSet S hX (fun x => kroneckerDelta p x) (fun x => kroneckerDelta q x) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hprep
    _ = kroneckerDelta q p := sumOverFiniteSet_kroneckerDelta S hX (fun x => kroneckerDelta q x) p
    _ = kroneckerDelta p q := kroneckerDelta_swap q p
    _ = Mat.entry (Mat.one : Mat X) p q := rfl

/-- 本文 `claim_matrix_is_double_sum_of_entries_times_matrix_units`：
F = Σ_{x∈X} 1_ℂ ∗_{Mat_X} (Σ_{y∈X} F_{x,y} ∗_{Mat_X} E_{x,y})。 -/
theorem eq_double_sum_entry_smul_matrixUnit (hX : IsFiniteSet X) [DecidableEq X] (F : Mat X) :
    F = sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1)
      (fun x => sumOverFiniteSet (matricesVectorSpace X) hX (fun y => Mat.entry F x y)
        (fun y => matrixUnit x y)) :=
  Mat.ext fun p q => by
  let S := complexNumbersVectorSpace
  -- （準備の一つ目）F_{x,y} ·_{ℂ^vec} ent_{p,q}(E_{x,y}) = δ_{q,y} ·_{ℂ^vec} (F_{x,y} ·_ℂ δ_{x,p})
  have hprep1 : ∀ x y : X, S.smul (Mat.entry F x y) (entryMap p q (matrixUnit x y))
      = S.smul (kroneckerDelta q y) (Mat.entry F x y * kroneckerDelta x p) := fun x y => calc
    S.smul (Mat.entry F x y) (entryMap p q (matrixUnit x y))
        = S.smul (Mat.entry F x y) (Mat.entry (matrixUnit x y) p q) := rfl
    _ = S.smul (Mat.entry F x y) (kroneckerDelta x p * kroneckerDelta y q) := rfl
    _ = Mat.entry F x y * (kroneckerDelta x p * kroneckerDelta y q) := rfl
    _ = (Mat.entry F x y * kroneckerDelta x p) * kroneckerDelta y q := by
        rw [_root_.mul_assoc (Mat.entry F x y) (kroneckerDelta x p) (kroneckerDelta y q)]
    _ = kroneckerDelta y q * (Mat.entry F x y * kroneckerDelta x p) := by
        rw [mul_comm (Mat.entry F x y * kroneckerDelta x p) (kroneckerDelta y q)]
    _ = kroneckerDelta q y * (Mat.entry F x y * kroneckerDelta x p) := by
        rw [kroneckerDelta_swap y q]
    _ = S.smul (kroneckerDelta q y) (Mat.entry F x y * kroneckerDelta x p) := rfl
  -- （準備の二つ目）Σ_{y∈X} δ_{q,y} ·_{ℂ^vec} (F_{x,y} ·_ℂ δ_{x,p}) = F_{x,q} ·_ℂ δ_{x,p}
  have hprep2 : ∀ x : X,
      sumOverFiniteSet S hX (fun y => kroneckerDelta q y) (fun y => Mat.entry F x y * kroneckerDelta x p)
        = Mat.entry F x q * kroneckerDelta x p := fun x =>
    sumOverFiniteSet_kroneckerDelta S hX (fun y => Mat.entry F x y * kroneckerDelta x p) q
  -- （準備の三つ目）1_ℂ ·_{ℂ^vec} (F_{x,q} ·_ℂ δ_{x,p}) = δ_{p,x} ·_{ℂ^vec} F_{x,q}
  have hprep3 : ∀ x : X, S.smul 1 (Mat.entry F x q * kroneckerDelta x p)
      = S.smul (kroneckerDelta p x) (Mat.entry F x q) := fun x => calc
    S.smul 1 (Mat.entry F x q * kroneckerDelta x p) = 1 * (Mat.entry F x q * kroneckerDelta x p) := rfl
    _ = Mat.entry F x q * kroneckerDelta x p := by
        rw [_root_.one_mul (Mat.entry F x q * kroneckerDelta x p)]
    _ = kroneckerDelta x p * Mat.entry F x q := by
        rw [mul_comm (Mat.entry F x q) (kroneckerDelta x p)]
    _ = kroneckerDelta p x * Mat.entry F x q := by rw [kroneckerDelta_swap x p]
    _ = S.smul (kroneckerDelta p x) (Mat.entry F x q) := rfl
  calc Mat.entry F p q
      = sumOverFiniteSet S hX (fun x => kroneckerDelta p x) (fun x => Mat.entry F x q) :=
        (sumOverFiniteSet_kroneckerDelta S hX (fun x => Mat.entry F x q) p).symm
    _ = sumOverFiniteSet S hX (fun _ => 1) (fun x => Mat.entry F x q * kroneckerDelta x p) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun x => (hprep3 x).symm)
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun x => sumOverFiniteSet S hX (fun y => kroneckerDelta q y)
            (fun y => Mat.entry F x y * kroneckerDelta x p)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun x => by rw [hprep2 x])
    _ = sumOverFiniteSet S hX (fun _ => 1)
          (fun x => sumOverFiniteSet S hX (fun y => Mat.entry F x y)
            (fun y => entryMap p q (matrixUnit x y))) :=
        sumOverFiniteSet_double_congr S hX hX _ _ _ _ (fun x y => (hprep1 x y).symm)
    _ = entryMap p q
          (sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1)
            (fun x => sumOverFiniteSet (matricesVectorSpace X) hX (fun y => Mat.entry F x y)
              (fun y => matrixUnit x y))) :=
        ((entryMap_isComplexLinearMap X p q).map_double_sumOverFiniteSet hX hX
          (fun x y => Mat.entry F x y) (fun x y => matrixUnit x y)).symm
    _ = Mat.entry
          (sumOverFiniteSet (matricesVectorSpace X) hX (fun _ => 1)
            (fun x => sumOverFiniteSet (matricesVectorSpace X) hX (fun y => Mat.entry F x y)
              (fun y => matrixUnit x y))) p q := rfl

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
