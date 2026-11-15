/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、行列環の直積から奇数次元のクリフォード代数への写像
Ψ'((F, G)) := j(Ψ(F)) ·_{A'} e_+ +_{A'} j(Ψ(G)) ·_{A'} e_-、それが ℂ-代数の準同型であること、Φ' と互いに逆であること、
系の定理の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra              homomorphismFromPairOfMatrices（Ψ'）
  claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism
                                                                                     homomorphismFromPairOfMatrices_isHom
  claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity
                                                                                     homomorphismToPairOfMatrices_idempotentPlus・
                                                                                     homomorphismToPairOfMatrices_idempotentMinus（証明の前半の
                                                                                     Φ'(e_±) の値）・
                                                                                     homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices
  claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity
                                                                                     homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices
  theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras
                                                                                     oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras

表し方:
- A' は `D.oddSpace.cliffordAlgebra`、B と B × B は `D.matrixAlgebra`・`D.pairOfMatricesAlgebra`、Φ と Ψ は
  `D.homomorphismToMatrix`・`D.homomorphismFromMatrix`、Φ' は `D.homomorphismToPairOfMatrices`、j・g・ε・z は
  `D.oddInclusionHom`・`D.addedGenerator`・`D.parityElement`・`D.centralElement`、e_± は `D.idempotentPlus`・`D.idempotentMinus`
  （`Idempotents.lean`）、h は `inverseOfTwo`。
- B × B の元 (F, G) は Lean の組で、本文の「(F, G) と (F', G') について」は組を `rintro ⟨F, G⟩` で開いて書く。
  直積の演算（加法・スカラー倍・乗法・単位元）を成分で書く行は、定義による（`rfl`）。
- 本文の乗法の式変形は、同じ五つの段（結合法則・結合法則・e_± の交換・結合法則・結合法則）を四か所に一度に当てる形に書いているので、
  calc も本文どおりにその五段を四か所に書く。
- 本文の「四か所に」「各成分に」「二か所に」の行は、それぞれの等式を一回の `rw` に並べて書き換える。
- 本文の「ℂ の四則」の行（h ·_ℂ (1_ℂ + (-1_ℂ)) = 0_ℂ）は ℂ の計算（`norm_num`）で書く。-_ℂ(-1_ℂ) = 1_ℂ の行は `neg_neg` を当てる。
- 本文の「$\Xi$ の定義により、これは主張の等式である」は、Ξ := Ψ' ∘ Φ' を `fun a => Ψ' (Φ' a)` と書くので定義による。
- 系の定理の「Φ' は全単射であり、その逆写像は Ψ'」は、主定理（`cliffordAlgebra_isomorphic_matrixAlgebra`）と同じく
  `Function.Bijective` と「Φ'(a) = (F, G) を満たす a は Ψ'((F, G)) である」で書く。
- 本文の前提 M ∈ ℤ_{≥1} は、どの証明も使わない（M = 0 でも同じ証明が通る）ので、仮定に置かない。

必要十分版は `NecSuf/Isomorphism/OddDimensional/HomomorphismFromPairOfMatrices.lean`、導出版は
`HomomorphismFromPairOfMatricesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.Idempotents
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `def_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra`：
Ψ'((F, G)) := j(Ψ(F)) ·_{A'} e_+ +_{A'} j(Ψ(G)) ·_{A'} e_-。 -/
def homomorphismFromPairOfMatrices (p : Mat (PowerSet D.M) × Mat (PowerSet D.M)) : D.oddSpace.Cl :=
  D.oddSpace.cliffordAlgebra.add
    (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.homomorphismFromMatrix p.1)) D.idempotentPlus)
    (D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.homomorphismFromMatrix p.2)) D.idempotentMinus)

/-- 本文 `claim_homomorphism_from_pair_of_matrix_algebras_to_odd_clifford_algebra_is_algebra_homomorphism`：
Ψ' は ℂ-代数 B × B から ℂ-代数 A' への ℂ-代数の準同型。 -/
theorem homomorphismFromPairOfMatrices_isHom :
    IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra D.homomorphismFromPairOfMatrices := by
  let A' := D.oddSpace.cliffordAlgebra
  let B := D.matrixAlgebra
  let BB := D.pairOfMatricesAlgebra
  let ep := D.idempotentPlus
  let em := D.idempotentMinus
  let Ψ' := D.homomorphismFromPairOfMatrices
  let J : Mat (PowerSet D.M) → D.oddSpace.Cl := fun F => D.oddInclusionHom (D.homomorphismFromMatrix F)
  -- J := j ∘ Ψ は ℂ-代数の準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hJ : IsComplexAlgebraHomomorphism B A' J :=
    IsComplexAlgebraHomomorphism.comp D.homomorphismFromMatrix_isHom D.oddInclusionHom_isHom
  -- e_± は A' のすべての元と交換する（claim_idempotents_of_odd_dimensional_clifford_algebra_commute_with_every_element）
  have hcp : ∀ y : D.oddSpace.Cl, A'.mul y ep = A'.mul ep y := D.idempotent_comm 1
  have hcm : ∀ y : D.oddSpace.Cl, A'.mul y em = A'.mul em y := D.idempotent_comm (-1)
  -- 加法を保つこと
  have hadd : ∀ x y : Mat (PowerSet D.M) × Mat (PowerSet D.M), Ψ' (BB.add x y) = A'.add (Ψ' x) (Ψ' y) := by
    rintro ⟨F, G⟩ ⟨F', G'⟩
    calc Ψ' (BB.add (F, G) (F', G'))
        = Ψ' (B.add F F', B.add G G') := rfl
      _ = A'.add (A'.mul (J (B.add F F')) ep) (A'.mul (J (B.add G G')) em) := rfl
      _ = A'.add (A'.mul (A'.add (J F) (J F')) ep) (A'.mul (A'.add (J G) (J G')) em) := by
          -- J は加法を保つ
          rw [hJ.map_add F F', hJ.map_add G G']
      _ = A'.add (A'.add (A'.mul (J F) ep) (A'.mul (J F') ep)) (A'.add (A'.mul (J G) em) (A'.mul (J G') em)) := by
          -- U_ring(A') の分配法則
          rw [A'.right_distrib (J F) (J F') ep, A'.right_distrib (J G) (J G') em]
      _ = A'.add (A'.add (A'.mul (J F) ep) (A'.mul (J G) em)) (A'.add (A'.mul (J F') ep) (A'.mul (J G') em)) :=
          -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(A') に当てる
          rearrange_sum_of_two_sums A'.toComplexVectorSpace _ _ _ _
      _ = A'.add (Ψ' (F, G)) (Ψ' (F', G')) := rfl
  -- スカラー倍を保つこと
  have hsmul : ∀ (l : ℂ) (x : Mat (PowerSet D.M) × Mat (PowerSet D.M)), Ψ' (BB.smul l x) = A'.smul l (Ψ' x) := by
    rintro l ⟨F, G⟩
    calc Ψ' (BB.smul l (F, G))
        = Ψ' (B.smul l F, B.smul l G) := rfl
      _ = A'.add (A'.mul (J (B.smul l F)) ep) (A'.mul (J (B.smul l G)) em) := rfl
      _ = A'.add (A'.mul (A'.smul l (J F)) ep) (A'.mul (A'.smul l (J G)) em) := by
          -- J はスカラー倍を保つ
          rw [hJ.map_smul l F, hJ.map_smul l G]
      _ = A'.add (A'.smul l (A'.mul (J F) ep)) (A'.smul l (A'.mul (J G) em)) := by
          -- スカラー倍と乗法の両立、左の因子
          rw [A'.smul_mul_left l (J F) ep, A'.smul_mul_left l (J G) em]
      _ = A'.smul l (A'.add (A'.mul (J F) ep) (A'.mul (J G) em)) :=
          -- U_vec(A') のベクトルの加法についての分配法則
          (A'.smul_add l _ _).symm
      _ = A'.smul l (Ψ' (F, G)) := rfl
  -- 乗法の単位元を保つこと
  have hone : Ψ' BB.one = A'.one := calc
    Ψ' BB.one = Ψ' (B.one, B.one) := rfl
    _ = A'.add (A'.mul (J B.one) ep) (A'.mul (J B.one) em) := rfl
    _ = A'.add (A'.mul A'.one ep) (A'.mul A'.one em) := by
        -- J は乗法の単位元を保つ
        rw [hJ.map_one]
    _ = A'.add ep em := by
        -- U_ring(A') の乗法の単位元
        rw [A'.one_mul ep, A'.one_mul em]
    _ = A'.one :=
        -- claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one
        D.idempotentPlus_add_idempotentMinus
  -- 乗法を保つこと
  have hmul : ∀ x y : Mat (PowerSet D.M) × Mat (PowerSet D.M), Ψ' (BB.mul x y) = A'.mul (Ψ' x) (Ψ' y) := by
    rintro ⟨F, G⟩ ⟨F', G'⟩
    let P₁ := J F
    let P₂ := J G
    let Q₁ := J F'
    let Q₂ := J G'
    -- e_+ ·_{A'} e_- = 0_{A'}、e_- ·_{A'} e_+ = 0_{A'}
    -- （claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero を σ := 1_ℂ・σ := -1_ℂ に当てたもの）
    have hpm : A'.mul ep em = A'.zero := D.idempotentPlus_mul_idempotentMinus
    have hmp : A'.mul em ep = A'.zero := D.idempotentMinus_mul_idempotentPlus
    have hpp : A'.mul ep ep = ep := D.idempotentPlus_mul_self
    have hmm : A'.mul em em = em := D.idempotentMinus_mul_self
    symm
    calc A'.mul (Ψ' (F, G)) (Ψ' (F', G'))
        = A'.mul (A'.add (A'.mul P₁ ep) (A'.mul P₂ em)) (A'.add (A'.mul Q₁ ep) (A'.mul Q₂ em)) := rfl
      _ = A'.add (A'.mul (A'.mul P₁ ep) (A'.add (A'.mul Q₁ ep) (A'.mul Q₂ em)))
            (A'.mul (A'.mul P₂ em) (A'.add (A'.mul Q₁ ep) (A'.mul Q₂ em))) :=
          -- U_ring(A') の分配法則
          A'.right_distrib _ _ _
      _ = A'.add (A'.add (A'.mul (A'.mul P₁ ep) (A'.mul Q₁ ep)) (A'.mul (A'.mul P₁ ep) (A'.mul Q₂ em)))
            (A'.add (A'.mul (A'.mul P₂ em) (A'.mul Q₁ ep)) (A'.mul (A'.mul P₂ em) (A'.mul Q₂ em))) := by
          -- U_ring(A') の分配法則
          rw [A'.left_distrib (A'.mul P₁ ep), A'.left_distrib (A'.mul P₂ em)]
      _ = A'.add (A'.add (A'.mul P₁ (A'.mul ep (A'.mul Q₁ ep))) (A'.mul P₁ (A'.mul ep (A'.mul Q₂ em))))
            (A'.add (A'.mul P₂ (A'.mul em (A'.mul Q₁ ep))) (A'.mul P₂ (A'.mul em (A'.mul Q₂ em)))) := by
          -- U_ring(A') の乗法の結合法則を四か所に
          rw [A'.mul_assoc P₁ ep (A'.mul Q₁ ep), A'.mul_assoc P₁ ep (A'.mul Q₂ em),
            A'.mul_assoc P₂ em (A'.mul Q₁ ep), A'.mul_assoc P₂ em (A'.mul Q₂ em)]
      _ = A'.add (A'.add (A'.mul P₁ (A'.mul (A'.mul ep Q₁) ep)) (A'.mul P₁ (A'.mul (A'.mul ep Q₂) em)))
            (A'.add (A'.mul P₂ (A'.mul (A'.mul em Q₁) ep)) (A'.mul P₂ (A'.mul (A'.mul em Q₂) em))) := by
          -- U_ring(A') の乗法の結合法則を四か所に
          rw [A'.mul_assoc ep Q₁ ep, A'.mul_assoc ep Q₂ em, A'.mul_assoc em Q₁ ep, A'.mul_assoc em Q₂ em]
      _ = A'.add (A'.add (A'.mul P₁ (A'.mul (A'.mul Q₁ ep) ep)) (A'.mul P₁ (A'.mul (A'.mul Q₂ ep) em)))
            (A'.add (A'.mul P₂ (A'.mul (A'.mul Q₁ em) ep)) (A'.mul P₂ (A'.mul (A'.mul Q₂ em) em))) := by
          -- e_± は A' のすべての元と交換する。四か所に
          rw [hcp Q₁, hcp Q₂, hcm Q₁, hcm Q₂]
      _ = A'.add (A'.add (A'.mul P₁ (A'.mul Q₁ (A'.mul ep ep))) (A'.mul P₁ (A'.mul Q₂ (A'.mul ep em))))
            (A'.add (A'.mul P₂ (A'.mul Q₁ (A'.mul em ep))) (A'.mul P₂ (A'.mul Q₂ (A'.mul em em)))) := by
          -- U_ring(A') の乗法の結合法則を四か所に
          rw [A'.mul_assoc Q₁ ep ep, A'.mul_assoc Q₂ ep em, A'.mul_assoc Q₁ em ep, A'.mul_assoc Q₂ em em]
      _ = A'.add (A'.add (A'.mul (A'.mul P₁ Q₁) (A'.mul ep ep)) (A'.mul (A'.mul P₁ Q₂) (A'.mul ep em)))
            (A'.add (A'.mul (A'.mul P₂ Q₁) (A'.mul em ep)) (A'.mul (A'.mul P₂ Q₂) (A'.mul em em))) := by
          -- U_ring(A') の乗法の結合法則を四か所に
          rw [← A'.mul_assoc P₁ Q₁ (A'.mul ep ep), ← A'.mul_assoc P₁ Q₂ (A'.mul ep em),
            ← A'.mul_assoc P₂ Q₁ (A'.mul em ep), ← A'.mul_assoc P₂ Q₂ (A'.mul em em)]
      _ = A'.add (A'.add (A'.mul (A'.mul P₁ Q₁) ep) (A'.mul (A'.mul P₁ Q₂) (A'.mul ep em)))
            (A'.add (A'.mul (A'.mul P₂ Q₁) (A'.mul em ep)) (A'.mul (A'.mul P₂ Q₂) em)) := by
          -- claim_idempotent_of_odd_dimensional_clifford_algebra_squares_to_itself
          rw [hpp, hmm]
      _ = A'.add (A'.add (A'.mul (A'.mul P₁ Q₁) ep) (A'.mul (A'.mul P₁ Q₂) A'.zero))
            (A'.add (A'.mul (A'.mul P₂ Q₁) A'.zero) (A'.mul (A'.mul P₂ Q₂) em)) := by
          -- claim_product_of_different_idempotents_of_odd_dimensional_clifford_algebra_is_zero
          rw [hpm, hmp]
      _ = A'.add (A'.add (A'.mul (A'.mul P₁ Q₁) ep) A'.zero) (A'.add A'.zero (A'.mul (A'.mul P₂ Q₂) em)) := by
          -- claim_element_times_zero_in_algebra_is_zero
          rw [mul_zero_eq_zero A' (A'.mul P₁ Q₂), mul_zero_eq_zero A' (A'.mul P₂ Q₁)]
      _ = A'.add (A'.mul (A'.mul P₁ Q₁) ep) (A'.add A'.zero (A'.mul (A'.mul P₂ Q₂) em)) := by
          -- U_ring(A') の加法の単位元
          rw [A'.add_zero (A'.mul (A'.mul P₁ Q₁) ep)]
      _ = A'.add (A'.mul (A'.mul P₁ Q₁) ep) (A'.add (A'.mul (A'.mul P₂ Q₂) em) A'.zero) := by
          -- U_ring(A') の加法の交換法則
          rw [A'.add_comm A'.zero (A'.mul (A'.mul P₂ Q₂) em)]
      _ = A'.add (A'.mul (A'.mul P₁ Q₁) ep) (A'.mul (A'.mul P₂ Q₂) em) := by
          -- U_ring(A') の加法の単位元
          rw [A'.add_zero (A'.mul (A'.mul P₂ Q₂) em)]
      _ = A'.add (A'.mul (J (B.mul F F')) ep) (A'.mul (J (B.mul G G')) em) := by
          -- J は乗法を保つ
          rw [hJ.map_mul F F', hJ.map_mul G G']
      _ = Ψ' (B.mul F F', B.mul G G') := rfl
      _ = Ψ' (BB.mul (F, G) (F', G')) := rfl
  -- 四つの性質から、Ψ' は ℂ-代数の準同型である
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半：
Φ'(e_+) = (1_B, 0_B)。 -/
theorem homomorphismToPairOfMatrices_idempotentPlus :
    D.homomorphismToPairOfMatrices D.idempotentPlus = (D.matrixAlgebra.one, D.matrixAlgebra.zero) := by
  let B := D.matrixAlgebra
  let h := inverseOfTwo
  calc D.homomorphismToPairOfMatrices D.idempotentPlus
      = D.homomorphismToPairOfMatrices (D.idempotent 1) := rfl
    _ = (B.smul (h * (1 + 1)) B.one, B.smul (h * (1 + -1)) B.one) :=
        -- claim_homomorphism_to_pair_of_matrices_on_idempotents（σ := 1_ℂ）
        D.homomorphismToPairOfMatrices_idempotent 1
    _ = (B.smul 1 B.one, B.smul (h * (1 + -1)) B.one) := by
        -- h は 1_ℂ +_ℂ 1_ℂ の乗法の逆元（def_inverse_of_two_in_complex_numbers）
        rw [inverseOfTwo_mul]
    _ = (B.smul 1 B.one, B.smul 0 B.one) := by
        -- ℂ の四則
        rw [show h * (1 + -1 : ℂ) = 0 by norm_num]
    _ = (B.one, B.smul 0 B.one) := by
        -- U_vec(B) のスカラー倍の単位元
        rw [B.one_smul B.one]
    _ = (B.one, B.zero) := by
        -- claim_zero_scalar_multiple_is_zero_vector
        rw [ComplexAlgebra.zero_smul_eq_zero B B.one]

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity` の証明の前半：
Φ'(e_-) = (0_B, 1_B)。 -/
theorem homomorphismToPairOfMatrices_idempotentMinus :
    D.homomorphismToPairOfMatrices D.idempotentMinus = (D.matrixAlgebra.zero, D.matrixAlgebra.one) := by
  let B := D.matrixAlgebra
  let h := inverseOfTwo
  calc D.homomorphismToPairOfMatrices D.idempotentMinus
      = D.homomorphismToPairOfMatrices (D.idempotent (-1)) := rfl
    _ = (B.smul (h * (1 + -1)) B.one, B.smul (h * (1 + -(-1))) B.one) :=
        -- claim_homomorphism_to_pair_of_matrices_on_idempotents（σ := -1_ℂ）
        D.homomorphismToPairOfMatrices_idempotent (-1)
    _ = (B.smul (h * (1 + -1)) B.one, B.smul (h * (1 + 1)) B.one) := by
        -- ℂ の中で -_ℂ(-1_ℂ) = 1_ℂ
        rw [neg_neg (1 : ℂ)]
    _ = (B.smul (h * (1 + -1)) B.one, B.smul 1 B.one) := by
        -- h は 1_ℂ +_ℂ 1_ℂ の乗法の逆元（def_inverse_of_two_in_complex_numbers）
        rw [inverseOfTwo_mul]
    _ = (B.smul 0 B.one, B.smul 1 B.one) := by
        -- ℂ の四則
        rw [show h * (1 + -1 : ℂ) = 0 by norm_num]
    _ = (B.zero, B.smul 1 B.one) := by
        -- claim_zero_scalar_multiple_is_zero_vector
        rw [ComplexAlgebra.zero_smul_eq_zero B B.one]
    _ = (B.zero, B.one) := by
        -- U_vec(B) のスカラー倍の単位元
        rw [B.one_smul B.one]

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_homomorphism_to_odd_clifford_algebra_is_identity`：
すべての F, G ∈ B について Φ'(Ψ'((F, G))) = (F, G)。 -/
theorem homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices (F G : Mat (PowerSet D.M)) :
    D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G) := by
  let A' := D.oddSpace.cliffordAlgebra
  let B := D.matrixAlgebra
  let BB := D.pairOfMatricesAlgebra
  let ep := D.idempotentPlus
  let em := D.idempotentMinus
  let j := D.oddInclusionHom
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  let Φ' := D.homomorphismToPairOfMatrices
  have hΦ' : IsComplexAlgebraHomomorphism A' BB Φ' := D.homomorphismToPairOfMatrices_isHom
  have hΦ'j : ∀ x : D.space.Cl, Φ' (j x) = (Φ x, Φ x) := D.homomorphismToPairOfMatrices_oddInclusionHom
  have hΦΨ : ∀ H : Mat (PowerSet D.M), Φ (Ψ H) = H := D.homomorphismToMatrix_homomorphismFromMatrix
  have hep : Φ' ep = (B.one, B.zero) := D.homomorphismToPairOfMatrices_idempotentPlus
  have hem : Φ' em = (B.zero, B.one) := D.homomorphismToPairOfMatrices_idempotentMinus
  calc Φ' (D.homomorphismFromPairOfMatrices (F, G))
      = Φ' (A'.add (A'.mul (j (Ψ F)) ep) (A'.mul (j (Ψ G)) em)) := rfl
    _ = BB.add (Φ' (A'.mul (j (Ψ F)) ep)) (Φ' (A'.mul (j (Ψ G)) em)) := hΦ'.map_add _ _
    _ = BB.add (BB.mul (Φ' (j (Ψ F))) (Φ' ep)) (BB.mul (Φ' (j (Ψ G))) (Φ' em)) := by
        -- Φ' は乗法を保つ
        rw [hΦ'.map_mul (j (Ψ F)) ep, hΦ'.map_mul (j (Ψ G)) em]
    _ = BB.add (BB.mul (Φ (Ψ F), Φ (Ψ F)) (Φ' ep)) (BB.mul (Φ (Ψ G), Φ (Ψ G)) (Φ' em)) := by
        -- claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism
        rw [hΦ'j (Ψ F), hΦ'j (Ψ G)]
    _ = BB.add (BB.mul (F, F) (Φ' ep)) (BB.mul (G, G) (Φ' em)) := by
        -- claim_homomorphism_to_matrix_algebra_after_homomorphism_to_clifford_algebra_is_identity
        rw [hΦΨ F, hΦΨ G]
    _ = BB.add (BB.mul (F, F) (B.one, B.zero)) (BB.mul (G, G) (B.zero, B.one)) := by
        -- 先に求めた Φ'(e_+) と Φ'(e_-) の値
        rw [hep, hem]
    _ = BB.add (B.mul F B.one, B.mul F B.zero) (B.mul G B.zero, B.mul G B.one) := rfl
    _ = BB.add (F, B.mul F B.zero) (B.mul G B.zero, G) := by
        -- U_ring(B) の乗法の単位元
        rw [B.mul_one F, B.mul_one G]
    _ = BB.add (F, B.zero) (B.zero, G) := by
        -- claim_element_times_zero_in_algebra_is_zero
        rw [mul_zero_eq_zero B F, mul_zero_eq_zero B G]
    _ = (B.add F B.zero, B.add B.zero G) := rfl
    _ = (B.add F B.zero, B.add G B.zero) := by
        -- U_ring(B) の加法の交換法則
        rw [B.add_comm B.zero G]
    _ = (F, G) := by
        -- U_ring(B) の加法の単位元
        rw [B.add_zero F, B.add_zero G]

/-- 本文 `claim_homomorphism_to_odd_clifford_algebra_after_homomorphism_to_pair_of_matrices_is_identity`：
すべての a ∈ A' について Ψ'(Φ'(a)) = a。Ξ := Ψ' ∘ Φ' と id_{A'} が γ'(V') の上で一致することを示し、
γ'(V') が A' を生成することから全体で一致させる。 -/
theorem homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices (a : D.oddSpace.Cl) :
    D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let B := D.matrixAlgebra
  let ep := D.idempotentPlus
  let em := D.idempotentMinus
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  let Φ' := D.homomorphismToPairOfMatrices
  let Ψ' := D.homomorphismFromPairOfMatrices
  let Ξ : D.oddSpace.Cl → D.oddSpace.Cl := fun x => Ψ' (Φ' x)
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom
  have hΨ : IsComplexAlgebraHomomorphism B A Ψ := D.homomorphismFromMatrix_isHom
  have hΦ'j : ∀ x : D.space.Cl, Φ' (j x) = (Φ x, Φ x) := D.homomorphismToPairOfMatrices_oddInclusionHom
  have hΨΦ : ∀ y : D.space.Cl, Ψ (Φ y) = y := D.homomorphismFromMatrix_homomorphismToMatrix
  have hΦ'g : Φ' g = (Φ ε, B.smul (-1) (Φ ε)) := D.homomorphismToPairOfMatrices_addedGenerator
  -- Ξ は ℂ-代数の準同型、id_{A'} も ℂ-代数の準同型
  have hΞ : IsComplexAlgebraHomomorphism A' A' Ξ :=
    IsComplexAlgebraHomomorphism.comp D.homomorphismToPairOfMatrices_isHom D.homomorphismFromPairOfMatrices_isHom
  have hid : IsComplexAlgebraHomomorphism A' A' (fun x => x) := isComplexAlgebraHomomorphism_id A'
  -- y ∈ A について Ξ(j(y)) = j(y)
  have hjy : ∀ y : D.space.Cl, Ξ (j y) = j y := fun y => calc
    Ξ (j y) = Ψ' (Φ y, Φ y) := by
        -- claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism
        show Ψ' (Φ' (j y)) = _
        rw [hΦ'j y]
    _ = A'.add (A'.mul (j (Ψ (Φ y))) ep) (A'.mul (j (Ψ (Φ y))) em) := rfl
    _ = A'.add (A'.mul (j y) ep) (A'.mul (j y) em) := by
        -- claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity
        rw [hΨΦ y]
    _ = A'.mul (j y) (A'.add ep em) :=
        -- U_ring(A') の分配法則
        (A'.left_distrib _ _ _).symm
    _ = A'.mul (j y) A'.one := by
        -- claim_sum_of_idempotents_of_odd_dimensional_clifford_algebra_is_one
        rw [D.idempotentPlus_add_idempotentMinus]
    _ = j y := A'.mul_one (j y)
  -- Ξ(g) = g
  have hg : Ξ g = g := calc
    Ξ g = Ψ' (Φ ε, B.smul (-1) (Φ ε)) := by
        -- claim_homomorphism_to_pair_of_matrices_on_added_generator
        show Ψ' (Φ' g) = _
        rw [hΦ'g]
    _ = A'.add (A'.mul (j (Ψ (Φ ε))) ep) (A'.mul (j (Ψ (B.smul (-1) (Φ ε)))) em) := rfl
    _ = A'.add (A'.mul (j (Ψ (Φ ε))) ep) (A'.mul (j (A.smul (-1) (Ψ (Φ ε)))) em) := by
        -- Ψ はスカラー倍を保つ
        rw [hΨ.map_smul (-1) (Φ ε)]
    _ = A'.add (A'.mul (j ε) ep) (A'.mul (j (A.smul (-1) ε)) em) := by
        -- claim_homomorphism_to_clifford_algebra_after_homomorphism_to_matrix_algebra_is_identity
        rw [hΨΦ ε]
    _ = A'.add (A'.mul (j ε) ep) (A'.mul (A'.smul (-1) (j ε)) em) := by
        -- j はスカラー倍を保つ
        rw [hj.map_smul (-1) ε]
    _ = A'.add (A'.mul (j ε) ep) (A'.smul (-1) (A'.mul (j ε) em)) := by
        -- スカラー倍と乗法の両立、左の因子
        rw [← A'.smul_mul_left (-1) (j ε) em]
    _ = A'.add (A'.mul (j ε) ep) (A'.mul (j ε) (A'.smul (-1) em)) := by
        -- スカラー倍と乗法の両立、右の因子
        rw [A'.smul_mul_right (-1) (j ε) em]
    _ = A'.mul (j ε) (A'.add ep (A'.smul (-1) em)) :=
        -- U_ring(A') の分配法則
        (A'.left_distrib _ _ _).symm
    _ = A'.mul (j ε) D.centralElement := by
        -- claim_difference_of_idempotents_of_odd_dimensional_clifford_algebra_is_central_element
        rw [D.idempotentPlus_sub_idempotentMinus]
    _ = A'.mul (j ε) (A'.mul (j ε) g) := rfl
    _ = A'.mul (A'.mul (j ε) (j ε)) g := (A'.mul_assoc _ _ _).symm
    _ = A'.mul (j (A.mul ε ε)) g := by
        -- j は乗法を保つ
        rw [hj.map_mul ε ε]
    _ = A'.mul (j A.one) g := by
        -- claim_square_of_parity_element_is_one
        rw [D.parityElement_mul_self]
    _ = A'.mul A'.one g := by
        -- j は乗法の単位元を保つ
        rw [hj.map_one]
    _ = g := A'.one_mul g
  -- x = (v, t) ∈ V' について Ξ(γ'(x)) = id_{A'}(γ'(x))
  have hagree : ∀ x ∈ Set.range D.oddSpace.γ, Ξ x = (fun y => y) x := by
    rintro _ ⟨⟨v, t⟩, rfl⟩
    calc Ξ (D.oddSpace.γ (v, t))
        = Ξ (A'.add (j (D.space.γ v)) (A'.smul t g)) := by
          -- claim_image_of_odd_extension_element_is_sum_of_images
          rw [D.oddSpace_γ_pair v t]
      _ = A'.add (Ξ (j (D.space.γ v))) (Ξ (A'.smul t g)) := hΞ.map_add _ _
      _ = A'.add (Ξ (j (D.space.γ v))) (A'.smul t (Ξ g)) := by
          -- Ξ はスカラー倍を保つ
          rw [hΞ.map_smul t g]
      _ = A'.add (j (D.space.γ v)) (A'.smul t (Ξ g)) := by
          -- 上の一つ目の等式で y := γ(v)
          rw [hjy (D.space.γ v)]
      _ = A'.add (j (D.space.γ v)) (A'.smul t g) := by
          -- 上の二つ目の等式
          rw [hg]
      _ = D.oddSpace.γ (v, t) := (D.oddSpace_γ_pair v t).symm
      _ = (fun y => y) (D.oddSpace.γ (v, t)) := rfl
  -- γ'(V') は A' を生成するので（claim_image_of_clifford_generator_map_generates_clifford_algebra）、
  -- claim_homomorphisms_agreeing_on_generators_are_equal により Ξ = id_{A'}
  exact eq_of_agree_on_generators hΞ hid (Set.range D.oddSpace.γ) D.oddSpace.γ_generates hagree a

/-- 本文 `theorem_clifford_algebra_of_odd_dimensional_quadratic_space_is_isomorphic_to_product_of_matrix_algebras`：
Φ' と Ψ' は ℂ-代数の準同型で、Ψ'(Φ'(a)) = a、Φ'(Ψ'((F, G))) = (F, G)。Φ' は全単射で、Φ'(a) = (F, G) を満たす a は
Ψ'((F, G)) である。 -/
theorem oddCliffordAlgebra_isomorphic_pairOfMatrixAlgebras :
    IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra D.homomorphismToPairOfMatrices ∧
      IsComplexAlgebraHomomorphism D.pairOfMatricesAlgebra D.oddSpace.cliffordAlgebra
        D.homomorphismFromPairOfMatrices ∧
      (∀ a : D.oddSpace.Cl, D.homomorphismFromPairOfMatrices (D.homomorphismToPairOfMatrices a) = a) ∧
      (∀ F G : Mat (PowerSet D.M), D.homomorphismToPairOfMatrices (D.homomorphismFromPairOfMatrices (F, G)) = (F, G)) ∧
      Function.Bijective D.homomorphismToPairOfMatrices ∧
      (∀ (F G : Mat (PowerSet D.M)) (a : D.oddSpace.Cl),
        D.homomorphismToPairOfMatrices a = (F, G) → a = D.homomorphismFromPairOfMatrices (F, G)) := by
  let Φ' := D.homomorphismToPairOfMatrices
  let Ψ' := D.homomorphismFromPairOfMatrices
  -- 単射であること
  have hinj : Function.Injective Φ' := by
    intro a a' haa'
    calc a = Ψ' (Φ' a) := (D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices a).symm
      _ = Ψ' (Φ' a') := by rw [haa']
      _ = a' := D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices a'
  -- 全射であること
  have hsurj : Function.Surjective Φ' := fun p =>
    ⟨Ψ' (p.1, p.2), D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices p.1 p.2⟩
  -- Φ'^{-1}((F, G)) = Ψ'((F, G))：Φ'(a) = (F, G) を満たすただ一つの a は Ψ'((F, G))
  have hinv : ∀ (F G : Mat (PowerSet D.M)) (a : D.oddSpace.Cl), Φ' a = (F, G) → a = Ψ' (F, G) := by
    intro F G a ha
    apply hinj
    calc Φ' a = (F, G) := ha
      _ = Φ' (Ψ' (F, G)) := (D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices F G).symm
  exact ⟨D.homomorphismToPairOfMatrices_isHom, D.homomorphismFromPairOfMatrices_isHom,
    D.homomorphismFromPairOfMatrices_homomorphismToPairOfMatrices,
    D.homomorphismToPairOfMatrices_homomorphismFromPairOfMatrices, ⟨hinj, hsurj⟩, hinv⟩

end

end CliffordMatrixIsomorphism.Clifford.SplitData
