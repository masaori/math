/-
章「複素行列環」の、行列の積の結合法則・分配法則・単位行列・スカラー倍との両立の必要十分版。具体版
`ComplexMatrixAlgebra/MatrixAlgebra/Product.lean` と同じ calc の行で、係数 ℂ を型の変数 K に替えて書く。
和は K を自分自身の上の線型空間にした `coefficientsVec L`（具体版の ℂ^vec。証明の中では S と書く）の中の和である。

  本文のラベル                                                              このファイル          使う K の性質
  claim_matrix_product_is_associative                                       mat_mul_assoc         L・乗法の交換法則・a · 0 = 0
  claim_matrix_product_distributes_over_sum_in_right_factor                 mat_mul_add           L（積を定めるためだけ）
  claim_matrix_product_distributes_over_sum_in_left_factor                  mat_add_mul           L（積を定めるためだけ）
  claim_identity_matrix_is_left_unit_of_matrix_product                      mat_one_mul           L（0 + 0 = 0 を L.add_zero 0 で）
  claim_identity_matrix_is_right_unit_of_matrix_product                     mat_mul_one           L（0 + 0 = 0）・
                                                                                                  0 と 1 がどの元とも交換すること
  claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor    mat_smul_mul_left     L（0 + 0 = 0）・a · 0 = 0
  claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor   mat_smul_mul_right    L（0 + 0 = 0・乗法の結合法則）・
                                                                                                  乗法の交換法則・a · 0 = 0

L : `ValuedMapsLaws K` は積 `Mat.mul L hX` を定めるのに要る（和をとる線型空間 K^vec を作る八つ）。行の中で L から使うのは、
結合法則の主張の乗法の結合法則と 1 ·_{K^vec} u = u（スカラー倍の単位元）、右の因子のスカラー倍の主張の乗法の結合法則、
和の主張に渡す 0 + 0 = 0（`L.add_zero 0`）だけである。

削れなかった仮定:
- 乗法の交換法則（結合法則）: 本文の経路は、和のスカラー倍の主張（スカラーを係数の左から掛ける）を使うために、
  p_w ·_K C_{w,y} を C_{w,y} ·_K p_w に、C_{w,y} ·_K (A_{x,z} ·_K B_{z,w}) を (A_{x,z} ·_K B_{z,w}) ·_K C_{w,y} に入れ替える。
  係数が可換でない環でも行列の積は結合的なので、これは主張ではなく本文の経路が要求する性質である。
- 0 と 1 がどの元とも交換すること（右の単位元。`h0 : ∀ a, 0 * a = a * 0`、`h1 : ∀ a, 1 * a = a * 1`）:
  具体版が ℂ の乗法の交換法則を当てる A_{x,z} ·_K δ_{z,y} = δ_{z,y} ·_K A_{x,z} の行。δ の値は 0 か 1 なので、
  乗法の交換法則全体ではなくこの二つで同じ行が書ける（`MatrixUnits.kroneckerDelta_mul_comm`）。
  0 · a = a · 0 は環の公理（両側の a · 0 = 0 = 0 · a）から、1 · a = a · 1 は 1 が両側の単位元であることから従うが、
  K に公理を置かない必要十分版では仮定として残る。
- 乗法の交換法則（右の因子のスカラー倍）: λ ·_K A_{x,z} = A_{x,z} ·_K λ の行。λ がどの元とも交換しなければ
  λ ∗ (A · B) = A · (λ ∗ B) は一般に成り立たないので、主張そのものが要求する性質である。
- a · 0 = 0（結合法則・二つのスカラー倍の主張）: 和のスカラー倍の主張 `smul_sumOverFiniteSet` の仮定
  （ρ ·_V 0_V = 0_V を経由する）。左の因子のスカラー倍の主張は乗法の交換法則を使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Definitions
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.DoubleSum

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} {X : Type u}

namespace MatrixUnits

/-- 本文 `def_kronecker_delta` の「i = j と j = i は同値なので、場合分けが一致する」行の必要十分版：δ_{i,j} = δ_{j,i}。 -/
theorem kroneckerDelta_swap [Zero K] [One K] [DecidableEq X] (i j : X) : (kroneckerDelta i j : K) = kroneckerDelta j i := by
  by_cases hij : i = j
  · rw [kroneckerDelta, kroneckerDelta, if_pos hij, if_pos hij.symm]
  · rw [kroneckerDelta, kroneckerDelta, if_neg hij, if_neg (fun h => hij h.symm)]

/-- 具体版が ℂ の乗法の交換法則を δ の値に当てる行の根拠：0 と 1 がどの元とも交換するなら δ_{i,j} ·_K a = a ·_K δ_{i,j}。 -/
theorem kroneckerDelta_mul_comm [Mul K] [Zero K] [One K] (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1)
    [DecidableEq X] (i j : X) (a : K) : (kroneckerDelta i j : K) * a = a * kroneckerDelta i j := by
  by_cases hij : i = j
  · rw [kroneckerDelta, if_pos hij]
    exact h1 a
  · rw [kroneckerDelta, if_neg hij]
    exact h0 a

end MatrixUnits

open MatrixUnits

variable [Add K] [Mul K] [One K] [Zero K]

/-- 本文 `claim_matrix_product_is_associative` の必要十分版：(A · B) · C = A · (B · C)。 -/
theorem mat_mul_assoc (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) (A B C : Mat K X) :
    Mat.mul L hX (Mat.mul L hX A B) C = Mat.mul L hX A (Mat.mul L hX B C) := Mat.ext fun x y => by
  let S := coefficientsVec L
  -- （準備）λ_{w,z} := A_{x,z} ·_K B_{z,w}
  let lam : X → X → K := fun w z => Mat.entry A x z * Mat.entry B z w
  -- （準備）p_w := Σ_{z∈X} A_{x,z} ·_{K^vec} B_{z,w}
  let p : X → K := fun w =>
    sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z w)
  -- （準備）u_w := p_w ·_{K^vec} C_{w,y}
  let u : X → K := fun w => S.smul (p w) (Mat.entry C w y)
  -- （準備）(C_{w,y} ·_K A_{x,z}) ·_{K^vec} B_{z,w} = λ_{w,z} ·_{K^vec} C_{w,y}
  have hlam : ∀ w z : X, S.smul (Mat.entry C w y * Mat.entry A x z) (Mat.entry B z w)
      = S.smul (lam w z) (Mat.entry C w y) := fun w z => calc
    S.smul (Mat.entry C w y * Mat.entry A x z) (Mat.entry B z w)
        = (Mat.entry C w y * Mat.entry A x z) * Mat.entry B z w := rfl
    _ = Mat.entry C w y * (Mat.entry A x z * Mat.entry B z w) := by
        rw [L.mul_assoc (Mat.entry C w y) (Mat.entry A x z) (Mat.entry B z w)]
    _ = (Mat.entry A x z * Mat.entry B z w) * Mat.entry C w y := by
        rw [hcomm (Mat.entry C w y) (Mat.entry A x z * Mat.entry B z w)]
    _ = lam w z * Mat.entry C w y := rfl
    _ = S.smul (lam w z) (Mat.entry C w y) := rfl
  -- （準備）u_w = Σ_{z∈X} λ_{w,z} ·_{K^vec} C_{w,y}
  have hu : ∀ w : X, u w = sumOverFiniteSet S hX (fun z => lam w z) (fun _ => Mat.entry C w y) :=
    fun w => calc
    u w = S.smul (p w) (Mat.entry C w y) := rfl
    _ = p w * Mat.entry C w y := rfl
    _ = Mat.entry C w y * p w := by rw [hcomm (p w) (Mat.entry C w y)]
    _ = S.smul (Mat.entry C w y) (p w) := rfl
    _ = S.smul (Mat.entry C w y)
          (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z w)) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry C w y * Mat.entry A x z) (fun z => Mat.entry B z w) :=
        smul_sumOverFiniteSet S (L.add_zero 0) hmul0 hX _ _ (Mat.entry C w y)
    _ = sumOverFiniteSet S hX (fun z => lam w z) (fun _ => Mat.entry C w y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (hlam w)
  -- （準備）(A · B)_{x,w} = p_w
  have hAB : ∀ w : X, Mat.entry (Mat.mul L hX A B) x w = p w := fun _ => rfl
  -- （準備）p_w ·_{K^vec} C_{w,y} = u_w = 1_K ·_{K^vec} u_w
  have hpu : ∀ w : X, S.smul (p w) (Mat.entry C w y) = S.smul 1 (u w) := fun w => calc
    S.smul (p w) (Mat.entry C w y) = u w := rfl
    _ = S.smul 1 (u w) := (S.one_smul (u w)).symm
  -- （準備）(B · C)_{z,y} = Σ_{w∈X} B_{z,w} ·_{K^vec} C_{w,y}
  have hBC : ∀ z : X, Mat.entry (Mat.mul L hX B C) z y
      = sumOverFiniteSet S hX (fun w => Mat.entry B z w) (fun w => Mat.entry C w y) := fun _ => rfl
  calc Mat.entry (Mat.mul L hX (Mat.mul L hX A B) C) x y
      = sumOverFiniteSet S hX (fun w => Mat.entry (Mat.mul L hX A B) x w) (fun w => Mat.entry C w y) := rfl
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
          rw [smul_sumOverFiniteSet S (L.add_zero 0) hmul0 hX (fun w => Mat.entry C w y) (fun w => Mat.entry B z w)
            (Mat.entry A x z)])
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z)
          (fun z => sumOverFiniteSet S hX (fun w => Mat.entry B z w) (fun w => Mat.entry C w y)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun z => S.one_smul _)
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.mul L hX B C) z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun z => by rw [hBC z])
    _ = Mat.entry (Mat.mul L hX A (Mat.mul L hX B C)) x y := rfl

/-- 本文 `claim_matrix_product_distributes_over_sum_in_right_factor` の必要十分版：A · (B + C) = (A · B) + (A · C)。 -/
theorem mat_mul_add (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (A B C : Mat K X) :
    Mat.mul L hX A (Mat.add B C) = Mat.add (Mat.mul L hX A B) (Mat.mul L hX A C) := Mat.ext fun x y => by
  let S := coefficientsVec L
  calc Mat.entry (Mat.mul L hX A (Mat.add B C)) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.add B C) z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y + Mat.entry C z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z)
          (fun z => S.add (Mat.entry B z y) (Mat.entry C z y)) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = S.add (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y))
          (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry C z y)) :=
        (sumOverFiniteSet_add_of_same_coefficients S hX _ _ _).symm
    _ = S.add (Mat.entry (Mat.mul L hX A B) x y) (Mat.entry (Mat.mul L hX A C) x y) := rfl
    _ = Mat.entry (Mat.mul L hX A B) x y + Mat.entry (Mat.mul L hX A C) x y := rfl
    _ = Mat.entry (Mat.add (Mat.mul L hX A B) (Mat.mul L hX A C)) x y := rfl

/-- 本文 `claim_matrix_product_distributes_over_sum_in_left_factor` の必要十分版：(A + B) · C = (A · C) + (B · C)。 -/
theorem mat_add_mul (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (A B C : Mat K X) :
    Mat.mul L hX (Mat.add A B) C = Mat.add (Mat.mul L hX A C) (Mat.mul L hX B C) := Mat.ext fun x y => by
  let S := coefficientsVec L
  calc Mat.entry (Mat.mul L hX (Mat.add A B) C) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.add A B) x z) (fun z => Mat.entry C z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z + Mat.entry B x z) (fun z => Mat.entry C z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = S.add (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry C z y))
          (sumOverFiniteSet S hX (fun z => Mat.entry B x z) (fun z => Mat.entry C z y)) :=
        (sumOverFiniteSet_add_of_same_family S hX _ _ _).symm
    _ = S.add (Mat.entry (Mat.mul L hX A C) x y) (Mat.entry (Mat.mul L hX B C) x y) := rfl
    _ = Mat.entry (Mat.mul L hX A C) x y + Mat.entry (Mat.mul L hX B C) x y := rfl
    _ = Mat.entry (Mat.add (Mat.mul L hX A C) (Mat.mul L hX B C)) x y := rfl

/-- 本文 `claim_identity_matrix_is_left_unit_of_matrix_product` の必要十分版：1 · A = A。 -/
theorem mat_one_mul (L : ValuedMapsLaws K) (hX : IsFiniteSet X) [DecidableEq X] (A : Mat K X) :
    Mat.mul L hX Mat.one A = A := Mat.ext fun x y => by
  let S := coefficientsVec L
  calc Mat.entry (Mat.mul L hX Mat.one A) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.one : Mat K X) x z) (fun z => Mat.entry A z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => (kroneckerDelta x z : K)) (fun z => Mat.entry A z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry A x y := sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun z => Mat.entry A z y) x

/-- 本文 `claim_identity_matrix_is_right_unit_of_matrix_product` の必要十分版：A · 1 = A。 -/
theorem mat_mul_one (L : ValuedMapsLaws K) (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1)
    (hX : IsFiniteSet X) [DecidableEq X] (A : Mat K X) :
    Mat.mul L hX A Mat.one = A := Mat.ext fun x y => by
  let S := coefficientsVec L
  -- （準備）A_{x,z} ·_{K^vec} δ_{z,y} = δ_{y,z} ·_{K^vec} A_{x,z}
  have hswap : ∀ z : X, S.smul (Mat.entry A x z) (kroneckerDelta z y : K)
      = S.smul (kroneckerDelta y z : K) (Mat.entry A x z) := fun z => calc
    S.smul (Mat.entry A x z) (kroneckerDelta z y : K) = Mat.entry A x z * (kroneckerDelta z y : K) := rfl
    _ = (kroneckerDelta z y : K) * Mat.entry A x z := (kroneckerDelta_mul_comm h0 h1 z y (Mat.entry A x z)).symm
    _ = (kroneckerDelta y z : K) * Mat.entry A x z := by
        -- z = y と y = z は同値なので、場合分けが一致する（def_kronecker_delta）
        by_cases hzy : z = y
        · rw [kroneckerDelta, kroneckerDelta, if_pos hzy, if_pos hzy.symm]
        · rw [kroneckerDelta, kroneckerDelta, if_neg hzy, if_neg (fun h => hzy h.symm)]
    _ = S.smul (kroneckerDelta y z : K) (Mat.entry A x z) := rfl
  calc Mat.entry (Mat.mul L hX A Mat.one) x y
      = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.one : Mat K X) z y) := rfl
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => kroneckerDelta z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = sumOverFiniteSet S hX (fun z => kroneckerDelta y z) (fun z => Mat.entry A x z) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hswap
    _ = Mat.entry A x y := sumOverFiniteSet_kroneckerDelta S (L.add_zero 0) hX (fun z => Mat.entry A x z) y

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_left_factor` の必要十分版：λ ∗ (A · B) = (λ ∗ A) · B。 -/
theorem mat_smul_mul_left (L : ValuedMapsLaws K) (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) (l : K) (A B : Mat K X) :
    Mat.smul l (Mat.mul L hX A B) = Mat.mul L hX (Mat.smul l A) B := Mat.ext fun x y => by
  let S := coefficientsVec L
  calc Mat.entry (Mat.smul l (Mat.mul L hX A B)) x y
      = l * Mat.entry (Mat.mul L hX A B) x y := rfl
    _ = l * sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y) := rfl
    _ = S.smul l (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y)) := rfl
    _ = sumOverFiniteSet S hX (fun z => l * Mat.entry A x z) (fun z => Mat.entry B z y) :=
        smul_sumOverFiniteSet S (L.add_zero 0) hmul0 hX _ _ l
    _ = sumOverFiniteSet S hX (fun z => Mat.entry (Mat.smul l A) x z) (fun z => Mat.entry B z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry (Mat.mul L hX (Mat.smul l A) B) x y := rfl

/-- 本文 `claim_scalar_multiple_is_compatible_with_matrix_product_in_right_factor` の必要十分版：λ ∗ (A · B) = A · (λ ∗ B)。 -/
theorem mat_smul_mul_right (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a) (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) (l : K) (A B : Mat K X) :
    Mat.smul l (Mat.mul L hX A B) = Mat.mul L hX A (Mat.smul l B) := Mat.ext fun x y => by
  let S := coefficientsVec L
  -- （準備）(λ ·_K A_{x,z}) ·_{K^vec} B_{z,y} = A_{x,z} ·_{K^vec} (λ ·_K B_{z,y})
  have hmove : ∀ z : X, S.smul (l * Mat.entry A x z) (Mat.entry B z y)
      = S.smul (Mat.entry A x z) (l * Mat.entry B z y) := fun z => calc
    S.smul (l * Mat.entry A x z) (Mat.entry B z y) = (l * Mat.entry A x z) * Mat.entry B z y := rfl
    _ = (Mat.entry A x z * l) * Mat.entry B z y := by rw [hcomm l (Mat.entry A x z)]
    _ = Mat.entry A x z * (l * Mat.entry B z y) := by
        rw [L.mul_assoc (Mat.entry A x z) l (Mat.entry B z y)]
    _ = S.smul (Mat.entry A x z) (l * Mat.entry B z y) := rfl
  calc Mat.entry (Mat.smul l (Mat.mul L hX A B)) x y
      = l * Mat.entry (Mat.mul L hX A B) x y := rfl
    _ = l * sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y) := rfl
    _ = S.smul l (sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry B z y)) := rfl
    _ = sumOverFiniteSet S hX (fun z => l * Mat.entry A x z) (fun z => Mat.entry B z y) :=
        smul_sumOverFiniteSet S (L.add_zero 0) hmul0 hX _ _ l
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => l * Mat.entry B z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ hmove
    _ = sumOverFiniteSet S hX (fun z => Mat.entry A x z) (fun z => Mat.entry (Mat.smul l B) z y) :=
        sumOverFiniteSet_congr S hX _ _ _ _ (fun _ => rfl)
    _ = Mat.entry (Mat.mul L hX A (Mat.smul l B)) x y := rfl

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
