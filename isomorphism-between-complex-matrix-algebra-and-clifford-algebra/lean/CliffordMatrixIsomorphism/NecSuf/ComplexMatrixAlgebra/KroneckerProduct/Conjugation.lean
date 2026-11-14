/-
章「複素行列環」の、二つの行列で両側から挟む写像と、その二つの主張の必要十分版。具体版
`ComplexMatrixAlgebra/KroneckerProduct/Conjugation.lean` と同じ def と calc の行で、係数 ℂ を型の変数 K に替えて書く。

  本文のラベル                                                              このファイル                                 使う K の性質
  def_conjugation_of_matrices                                               conjugation                                  L（積を定めるため）
  claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism    conjugation_map_add                          L（積を定めるためだけ）
                                                                            conjugation_map_mul                          L・乗法の交換法則・a · 0 = 0
                                                                            conjugation_map_one                          L・0 と 1 がどの元とも交換すること
                                                                            conjugation_map_smul                         L・乗法の交換法則・a · 0 = 0
                                                                            conjugation_isAlgebraHomomorphism            L・乗法の交換法則・a · 0 = 0
  claim_conjugations_by_mutually_inverse_matrices_compose_to_identity       conjugation_conjugation                      L・乗法の交換法則・a · 0 = 0

この節の主張は行列の積の主張（`MatrixAlgebra/Product.lean`）だけを引き、K の性質を新たに使わない。仮定は、引く主張の仮定を合わせたものである。
- 乗法の交換法則・a · 0 = 0: 結合法則 `mat_mul_assoc`（本文の経路が和のスカラー倍の主張を使うため）、
  右の因子のスカラー倍 `mat_smul_mul_right`（交換法則と a · 0 = 0）が要る。乗法を保つこと、二つの写像の合成が
  恒等写像であることは結合法則を経由する。
- 0 と 1 がどの元とも交換すること: 右の単位元 `mat_mul_one` の仮定。単位元を保つことはこれだけを経由する。
  交換法則を仮定に持つ主張（準同型であること、合成が恒等写像であること）では、交換法則を 0 と 1 に当てて渡す。
- 準同型であることを述べるには K の上の代数 `matricesAlgebra L hcomm hmul0 hX` が要り、その組を作るのにも同じ二つが要る。
- 加法を保つことは、分配法則の主張（L を積を定めるためだけに使う）だけを引く。
-/
import CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra.MatrixAlgebra.Algebra

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] {X : Type u}

/-- 本文 `def_conjugation_of_matrices` の必要十分版：κ_{U,U'}(F) := (U · F) · U'。 -/
noncomputable def conjugation (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (U U' : Mat K X) (F : Mat K X) :
    Mat K X :=
  Mat.mul L hX (Mat.mul L hX U F) U'

/-- 加法を保つことの必要十分版。 -/
theorem conjugation_map_add (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (U U' F G : Mat K X) :
    conjugation L hX U U' (Mat.add F G) = Mat.add (conjugation L hX U U' F) (conjugation L hX U U' G) := calc
  conjugation L hX U U' (Mat.add F G) = Mat.mul L hX (Mat.mul L hX U (Mat.add F G)) U' := rfl
  _ = Mat.mul L hX (Mat.add (Mat.mul L hX U F) (Mat.mul L hX U G)) U' := by rw [mat_mul_add L hX U F G]
  _ = Mat.add (Mat.mul L hX (Mat.mul L hX U F) U') (Mat.mul L hX (Mat.mul L hX U G) U') :=
      mat_add_mul L hX (Mat.mul L hX U F) (Mat.mul L hX U G) U'
  _ = Mat.add (conjugation L hX U U' F) (conjugation L hX U U' G) := rfl

/-- 乗法を保つことの必要十分版（U' · U = 1 を使う）。 -/
theorem conjugation_map_mul (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat K X)
    (hU'U : Mat.mul L hX U' U = Mat.one) (F G : Mat K X) :
    Mat.mul L hX (conjugation L hX U U' F) (conjugation L hX U U' G)
      = conjugation L hX U U' (Mat.mul L hX F G) := calc
  Mat.mul L hX (conjugation L hX U U' F) (conjugation L hX U U' G)
      = Mat.mul L hX (Mat.mul L hX (Mat.mul L hX U F) U') (Mat.mul L hX (Mat.mul L hX U G) U') := rfl
  _ = Mat.mul L hX (Mat.mul L hX U F) (Mat.mul L hX U' (Mat.mul L hX (Mat.mul L hX U G) U')) :=
      mat_mul_assoc L hcomm hmul0 hX (Mat.mul L hX U F) U' (Mat.mul L hX (Mat.mul L hX U G) U')
  _ = Mat.mul L hX (Mat.mul L hX U F) (Mat.mul L hX (Mat.mul L hX U' (Mat.mul L hX U G)) U') := by
      rw [mat_mul_assoc L hcomm hmul0 hX U' (Mat.mul L hX U G) U']
  _ = Mat.mul L hX (Mat.mul L hX U F) (Mat.mul L hX (Mat.mul L hX (Mat.mul L hX U' U) G) U') := by
      rw [mat_mul_assoc L hcomm hmul0 hX U' U G]
  _ = Mat.mul L hX (Mat.mul L hX U F) (Mat.mul L hX (Mat.mul L hX Mat.one G) U') := by rw [hU'U]
  _ = Mat.mul L hX (Mat.mul L hX U F) (Mat.mul L hX G U') := by rw [mat_one_mul L hX G]
  _ = Mat.mul L hX (Mat.mul L hX (Mat.mul L hX U F) G) U' :=
      (mat_mul_assoc L hcomm hmul0 hX (Mat.mul L hX U F) G U').symm
  _ = Mat.mul L hX (Mat.mul L hX U (Mat.mul L hX F G)) U' := by rw [mat_mul_assoc L hcomm hmul0 hX U F G]
  _ = conjugation L hX U U' (Mat.mul L hX F G) := rfl

/-- 乗法の単位元を保つことの必要十分版（U · U' = 1 を使う）。 -/
theorem conjugation_map_one (L : ValuedMapsLaws K) (h0 : ∀ a : K, 0 * a = a * 0) (h1 : ∀ a : K, 1 * a = a * 1)
    (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat K X)
    (hUU' : Mat.mul L hX U U' = Mat.one) : conjugation L hX U U' Mat.one = Mat.one := calc
  conjugation L hX U U' Mat.one = Mat.mul L hX (Mat.mul L hX U Mat.one) U' := rfl
  _ = Mat.mul L hX U U' := by rw [mat_mul_one L h0 h1 hX U]
  _ = Mat.one := hUU'

/-- スカラー倍を保つことの必要十分版。 -/
theorem conjugation_map_smul (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) (U U' : Mat K X) (l : K) (F : Mat K X) :
    conjugation L hX U U' (Mat.smul l F) = Mat.smul l (conjugation L hX U U' F) := calc
  conjugation L hX U U' (Mat.smul l F) = Mat.mul L hX (Mat.mul L hX U (Mat.smul l F)) U' := rfl
  _ = Mat.mul L hX (Mat.smul l (Mat.mul L hX U F)) U' := by
      rw [mat_smul_mul_right L hcomm hmul0 hX l U F]
  _ = Mat.smul l (Mat.mul L hX (Mat.mul L hX U F) U') :=
      (mat_smul_mul_left L hmul0 hX l (Mat.mul L hX U F) U').symm
  _ = Mat.smul l (conjugation L hX U U' F) := rfl

/-- 本文 `claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism` の必要十分版。 -/
theorem conjugation_isAlgebraHomomorphism (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat K X)
    (hUU' : Mat.mul L hX U U' = Mat.one) (hU'U : Mat.mul L hX U' U = Mat.one) :
    AlgebraOver.IsAlgebraHomomorphism (matricesAlgebra L hcomm hmul0 hX) (matricesAlgebra L hcomm hmul0 hX)
      (conjugation L hX U U') where
  isRingHomomorphism :=
    { map_add := conjugation_map_add L hX U U'
      map_mul := fun F G => (conjugation_map_mul L hcomm hmul0 hX U U' hU'U F G).symm
      map_one := conjugation_map_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX U U' hUU' }
  isLinearMap :=
    { map_add := conjugation_map_add L hX U U'
      map_smul := conjugation_map_smul L hcomm hmul0 hX U U' }

/-- 本文 `claim_conjugations_by_mutually_inverse_matrices_compose_to_identity` の必要十分版。 -/
theorem conjugation_conjugation (L : ValuedMapsLaws K) (hcomm : ∀ a b : K, a * b = b * a)
    (hmul0 : ∀ a : K, a * 0 = 0) (hX : IsFiniteSet X) [DecidableEq X] (U U' : Mat K X)
    (hU'U : Mat.mul L hX U' U = Mat.one) (F : Mat K X) :
    conjugation L hX U' U (conjugation L hX U U' F) = F := calc
  conjugation L hX U' U (conjugation L hX U U' F)
      = Mat.mul L hX (Mat.mul L hX U' (Mat.mul L hX (Mat.mul L hX U F) U')) U := rfl
  _ = Mat.mul L hX (Mat.mul L hX (Mat.mul L hX U' (Mat.mul L hX U F)) U') U := by
      rw [mat_mul_assoc L hcomm hmul0 hX U' (Mat.mul L hX U F) U']
  _ = Mat.mul L hX (Mat.mul L hX U' (Mat.mul L hX U F)) (Mat.mul L hX U' U) :=
      mat_mul_assoc L hcomm hmul0 hX (Mat.mul L hX U' (Mat.mul L hX U F)) U' U
  _ = Mat.mul L hX (Mat.mul L hX U' (Mat.mul L hX U F)) Mat.one := by rw [hU'U]
  _ = Mat.mul L hX U' (Mat.mul L hX U F) := mat_mul_one L (fun a => hcomm 0 a) (fun a => hcomm 1 a) hX
      (Mat.mul L hX U' (Mat.mul L hX U F))
  _ = Mat.mul L hX (Mat.mul L hX U' U) F := (mat_mul_assoc L hcomm hmul0 hX U' U F).symm
  _ = Mat.mul L hX Mat.one F := by rw [hU'U]
  _ = F := mat_one_mul L hX F

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
