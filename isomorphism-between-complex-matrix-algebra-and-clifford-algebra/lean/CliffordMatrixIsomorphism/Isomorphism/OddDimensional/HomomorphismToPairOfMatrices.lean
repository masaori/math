/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一つの次元を足した空間から行列の組への写像 φ'、
それが線型であることと値の平方、奇数次元のクリフォード代数から行列環の直積への準同型 Φ' と、
Φ' ∘ j・Φ'(g) の値の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  def_map_from_odd_extension_to_pair_of_matrices                                     SplitData.pairOfMatricesAlgebra（B × B）・
                                                                                     SplitData.mapToPairOfMatrices（φ'）
  claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map                     SplitData.mapToPairOfMatrices_isLinearMap
  claim_square_of_map_from_odd_extension_to_pair_of_matrices                         SplitData.mapToPairOfMatrices_mul_self
  claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras
                                                                                     SplitData.existsUnique_homomorphismToPairOfMatrices
  def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras              SplitData.homomorphismToPairOfMatrices（Φ'）・
                                                                                     homomorphismToPairOfMatrices_isHom・
                                                                                     homomorphismToPairOfMatrices_γ
  claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism                  SplitData.homomorphismToPairOfMatrices_oddInclusionHom
  claim_homomorphism_to_pair_of_matrices_on_added_generator                          SplitData.homomorphismToPairOfMatrices_addedGenerator

表し方:
- B := Mat_{P_M}(ℂ) は `D.matrixAlgebra`、Φ は `D.homomorphismToMatrix`、ε は `D.parityElement`、A := Cl(V,q) は
  `D.space.cliffordAlgebra`、γ は `D.space.γ`、A' と γ' は `D.oddSpace.cliffordAlgebra`・`D.oddSpace.γ`、j は `D.oddInclusionHom`、
  u・g は `D.addedUnitVector`・`D.addedGenerator`（`OddExtension.lean`）。B × B は直積 `productAlgebra`（`ProductOfAlgebras.lean`）を
  B と B に当てたもので、名前 `D.pairOfMatricesAlgebra` を置く。
- V' の元 (v, t) は Lean の組 p（v = p.1、t = p.2）で、φ'(p) は p.1・p.2 で書く（`matrixValuedMap` と同じ）。
- 本文の「各成分に」の行は、二つの成分の等式を一回で書き換える（`ProductOfAlgebras.lean` と同じ）。
- 本文の「ℂ の四則」の行は ℂ の補題（`neg_add`・`neg_mul_eq_mul_neg`・`neg_mul_neg`・`neg_zero`）を一回当てる。
  -1_ℂ の定義の行（-_ℂ 1_ℂ = -1_ℂ）は、Lean では両辺が同じ式 `-1` なので `rfl` である。
- 本文の前提 M ∈ ℤ_{≥1} は、どの証明も使わない（M = 0 でも同じ証明が通る）ので、仮定に置かない。

必要十分版は `NecSuf/Isomorphism/OddDimensional/HomomorphismToPairOfMatrices.lean`、導出版は `HomomorphismToPairOfMatricesFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElement
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ProductOfAlgebras
import CliffordMatrixIsomorphism.Isomorphism.HomomorphismToMatrixAlgebra.HomomorphismToMatrixAlgebra

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### φ' と、それが線型であること・値の平方 -/

/-- 本文 `def_map_from_odd_extension_to_pair_of_matrices` の B × B：B := Mat_{P_M}(ℂ) と B の直積
（`def_product_of_two_complex_algebras`、`claim_product_of_two_complex_algebras_is_complex_algebra`）。 -/
abbrev pairOfMatricesAlgebra : ComplexAlgebra (Mat (PowerSet D.M) × Mat (PowerSet D.M)) :=
  productAlgebra D.matrixAlgebra D.matrixAlgebra

/-- 本文 `def_map_from_odd_extension_to_pair_of_matrices`：
φ'((v, t)) := (Φ(γ(v)) +_B t ∗_B Φ(ε), Φ(γ(v)) +_B (-_ℂ t) ∗_B Φ(ε))。 -/
def mapToPairOfMatrices (p : (W × DualSpace D.spaceW) × ℂ) : Mat (PowerSet D.M) × Mat (PowerSet D.M) :=
  (D.matrixAlgebra.add (D.homomorphismToMatrix (D.space.γ p.1))
      (D.matrixAlgebra.smul p.2 (D.homomorphismToMatrix D.parityElement)),
    D.matrixAlgebra.add (D.homomorphismToMatrix (D.space.γ p.1))
      (D.matrixAlgebra.smul (-p.2) (D.homomorphismToMatrix D.parityElement)))

/-- 本文 `claim_map_from_odd_extension_to_pair_of_matrices_is_linear_map`：φ' は V' から U_vec(B × B) への線型写像である。
Ξ := Φ ∘ γ は線型写像（`claim_clifford_generator_map_is_linear_map`・`def_complex_algebra_homomorphism`・
`claim_composition_of_linear_maps_is_linear_map`）、η := Φ(ε)。 -/
theorem mapToPairOfMatrices_isLinearMap :
    IsComplexLinearMap D.oddSpace.space D.pairOfMatricesAlgebra.toComplexVectorSpace D.mapToPairOfMatrices := by
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  let γ := D.space.γ
  let η := Φ D.parityElement
  have hΞ := IsComplexLinearMap.comp D.space.γ_isLinearMap D.homomorphismToMatrix_isHom.isLinearMap_underlying
  have hΞadd : ∀ v v' : W × DualSpace D.spaceW, Φ (γ (D.space.space.add v v')) = B.add (Φ (γ v)) (Φ (γ v')) :=
    fun v v' => hΞ.map_add v v'
  have hΞsmul : ∀ (l : ℂ) (v : W × DualSpace D.spaceW), Φ (γ (D.space.space.smul l v)) = B.smul l (Φ (γ v)) :=
    fun l v => hΞ.map_smul l v
  refine ⟨fun p p' => ?_, fun l p => ?_⟩
  · -- 加法を保つこと
    calc D.mapToPairOfMatrices (D.oddSpace.space.add p p')
        = D.mapToPairOfMatrices (D.space.space.add p.1 p'.1, p.2 + p'.2) := rfl
      _ = (B.add (Φ (γ (D.space.space.add p.1 p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (Φ (γ (D.space.space.add p.1 p'.1))) (B.smul (-(p.2 + p'.2)) η)) := rfl
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (-(p.2 + p'.2)) η)) := by
          -- Ξ は加法を保つ。各成分に
          rw [hΞadd p.1 p'.1]
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (p.2 + p'.2) η),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.smul (-p.2 + -p'.2) η)) := by
          -- ℂ の四則
          rw [neg_add p.2 p'.2]
      _ = (B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul p.2 η) (B.smul p'.2 η)),
            B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul (-p.2) η) (B.smul (-p'.2) η))) := by
          -- U_vec(B) のスカラーの加法についての分配法則。各成分に
          rw [B.add_smul p.2 p'.2 η, B.add_smul (-p.2) (-p'.2) η]
      _ = (B.add (B.add (Φ (γ p.1)) (B.smul p.2 η)) (B.add (Φ (γ p'.1)) (B.smul p'.2 η)),
            B.add (B.add (Φ (γ p.1)) (B.smul (-p.2) η)) (B.add (Φ (γ p'.1)) (B.smul (-p'.2) η))) := by
          -- claim_rearranging_sum_of_two_sums_in_vector_space を U_vec(B) に当てる。各成分に
          rw [show B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul p.2 η) (B.smul p'.2 η))
                = B.add (B.add (Φ (γ p.1)) (B.smul p.2 η)) (B.add (Φ (γ p'.1)) (B.smul p'.2 η)) from
              rearrange_sum_of_two_sums B.toComplexVectorSpace _ _ _ _,
            show B.add (B.add (Φ (γ p.1)) (Φ (γ p'.1))) (B.add (B.smul (-p.2) η) (B.smul (-p'.2) η))
                = B.add (B.add (Φ (γ p.1)) (B.smul (-p.2) η)) (B.add (Φ (γ p'.1)) (B.smul (-p'.2) η)) from
              rearrange_sum_of_two_sums B.toComplexVectorSpace _ _ _ _]
      _ = ProductAlgebra.add B B (B.add (Φ (γ p.1)) (B.smul p.2 η), B.add (Φ (γ p.1)) (B.smul (-p.2) η))
            (B.add (Φ (γ p'.1)) (B.smul p'.2 η), B.add (Φ (γ p'.1)) (B.smul (-p'.2) η)) := rfl
      _ = D.pairOfMatricesAlgebra.add (D.mapToPairOfMatrices p) (D.mapToPairOfMatrices p') := rfl
  · -- スカラー倍を保つこと
    calc D.mapToPairOfMatrices (D.oddSpace.space.smul l p)
        = D.mapToPairOfMatrices (D.space.space.smul l p.1, l * p.2) := rfl
      _ = (B.add (Φ (γ (D.space.space.smul l p.1))) (B.smul (l * p.2) η),
            B.add (Φ (γ (D.space.space.smul l p.1))) (B.smul (-(l * p.2)) η)) := rfl
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul (l * p.2) η),
            B.add (B.smul l (Φ (γ p.1))) (B.smul (-(l * p.2)) η)) := by
          -- Ξ はスカラー倍を保つ。各成分に
          rw [hΞsmul l p.1]
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul (l * p.2) η),
            B.add (B.smul l (Φ (γ p.1))) (B.smul (l * -p.2) η)) := by
          -- ℂ の四則
          rw [neg_mul_eq_mul_neg l p.2]
      _ = (B.add (B.smul l (Φ (γ p.1))) (B.smul l (B.smul p.2 η)),
            B.add (B.smul l (Φ (γ p.1))) (B.smul l (B.smul (-p.2) η))) := by
          -- U_vec(B) のスカラー倍の結合法則。各成分に
          rw [B.smul_assoc l p.2 η, B.smul_assoc l (-p.2) η]
      _ = (B.smul l (B.add (Φ (γ p.1)) (B.smul p.2 η)), B.smul l (B.add (Φ (γ p.1)) (B.smul (-p.2) η))) := by
          -- U_vec(B) のベクトルの加法についての分配法則。各成分に
          rw [← B.smul_add l (Φ (γ p.1)) (B.smul p.2 η), ← B.smul_add l (Φ (γ p.1)) (B.smul (-p.2) η)]
      _ = ProductAlgebra.smul B B l (B.add (Φ (γ p.1)) (B.smul p.2 η), B.add (Φ (γ p.1)) (B.smul (-p.2) η)) := rfl
      _ = D.pairOfMatricesAlgebra.smul l (D.mapToPairOfMatrices p) := rfl

/-- 本文 `claim_square_of_map_from_odd_extension_to_pair_of_matrices`：φ'(x) ·_{B×B} φ'(x) = q'(x) ∗_{B×B} 1_{B×B}。
x = (v, t)、X := Φ(γ(v))、Y := Φ(ε) と置き、三つの等式を準備してから平方の主張
（`claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity`）を当てる。 -/
theorem mapToPairOfMatrices_mul_self (p : (W × DualSpace D.spaceW) × ℂ) :
    D.pairOfMatricesAlgebra.mul (D.mapToPairOfMatrices p) (D.mapToPairOfMatrices p)
      = D.pairOfMatricesAlgebra.smul (D.oddSpace.form p) D.pairOfMatricesAlgebra.one := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  have hΦ := D.homomorphismToMatrix_isHom
  let X := Φ (D.space.γ p.1)
  let Y := Φ D.parityElement
  -- 準備の一つ目：X ·_B X = q(v) ∗_B 1_B
  have hX : B.mul X X = B.smul (D.space.form p.1) B.one := calc
    B.mul X X = Φ (A.mul (D.space.γ p.1) (D.space.γ p.1)) := (hΦ.map_mul _ _).symm
    _ = Φ (A.smul (D.space.form p.1) A.one) := by rw [D.space.γ_mul_self p.1]
    _ = B.smul (D.space.form p.1) (Φ A.one) := hΦ.map_smul _ _
    _ = B.smul (D.space.form p.1) B.one := by rw [show Φ A.one = B.one from hΦ.map_one]
  -- 準備の二つ目：Y ·_B Y = 1_B
  have hY : B.mul Y Y = B.one := calc
    B.mul Y Y = Φ (A.mul D.parityElement D.parityElement) := (hΦ.map_mul _ _).symm
    _ = Φ A.one := by rw [D.parityElement_mul_self]
    _ = B.one := hΦ.map_one
  -- 準備の三つ目：X ·_B Y +_B Y ·_B X = 0_B
  have hXY : B.add (B.mul X Y) (B.mul Y X) = B.zero := calc
    B.add (B.mul X Y) (B.mul Y X)
        = B.add (Φ (A.mul (D.space.γ p.1) D.parityElement)) (Φ (A.mul D.parityElement (D.space.γ p.1))) := by
          rw [show B.mul X Y = Φ (A.mul (D.space.γ p.1) D.parityElement) from (hΦ.map_mul _ _).symm,
            show B.mul Y X = Φ (A.mul D.parityElement (D.space.γ p.1)) from (hΦ.map_mul _ _).symm]
    _ = Φ (A.add (A.mul (D.space.γ p.1) D.parityElement) (A.mul D.parityElement (D.space.γ p.1))) :=
          (hΦ.map_add _ _).symm
    _ = Φ A.zero := by rw [D.γ_anticommute_parityElement p.1]
    _ = B.zero := hΦ.isLinearMap_underlying.map_zero
  calc D.pairOfMatricesAlgebra.mul (D.mapToPairOfMatrices p) (D.mapToPairOfMatrices p)
      = ProductAlgebra.mul B B (B.add X (B.smul p.2 Y), B.add X (B.smul (-p.2) Y))
          (B.add X (B.smul p.2 Y), B.add X (B.smul (-p.2) Y)) := rfl
    _ = (B.mul (B.add X (B.smul p.2 Y)) (B.add X (B.smul p.2 Y)),
          B.mul (B.add X (B.smul (-p.2) Y)) (B.add X (B.smul (-p.2) Y))) := rfl
    _ = (B.smul (D.space.form p.1 + p.2 * p.2) B.one, B.smul (D.space.form p.1 + -p.2 * -p.2) B.one) := by
        -- s := t と s := -t で各成分に
        rw [square_of_add_smul_of_anticommuting B X Y (D.space.form p.1) hX hY hXY p.2,
          square_of_add_smul_of_anticommuting B X Y (D.space.form p.1) hX hY hXY (-p.2)]
    _ = (B.smul (D.space.form p.1 + p.2 * p.2) B.one, B.smul (D.space.form p.1 + p.2 * p.2) B.one) := by
        -- ℂ の四則
        rw [neg_mul_neg p.2 p.2]
    _ = ProductAlgebra.smul B B (D.space.form p.1 + p.2 * p.2) (B.one, B.one) := rfl
    _ = D.pairOfMatricesAlgebra.smul (D.space.form p.1 + p.2 * p.2) D.pairOfMatricesAlgebra.one := rfl
    _ = D.pairOfMatricesAlgebra.smul (D.oddSpace.form p) D.pairOfMatricesAlgebra.one := rfl

/-! ### Φ' -/

/-- 本文 `claim_existence_and_uniqueness_of_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras`：
Θ ∘ γ' = φ' を満たす ℂ-代数の準同型 Θ : A' → B × B がただ一つ存在する。
クリフォード代数の普遍性を A := B × B、線型写像 φ' に当てる。 -/
theorem existsUnique_homomorphismToPairOfMatrices :
    ∃ Θ : D.oddSpace.Cl → Mat (PowerSet D.M) × Mat (PowerSet D.M),
      (IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra Θ ∧
        ∀ x, Θ (D.oddSpace.γ x) = D.mapToPairOfMatrices x) ∧
      ∀ Θ' : D.oddSpace.Cl → Mat (PowerSet D.M) × Mat (PowerSet D.M),
        (IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra Θ' ∧
          ∀ x, Θ' (D.oddSpace.γ x) = D.mapToPairOfMatrices x) → Θ' = Θ :=
  D.oddSpace.universalProperty D.pairOfMatricesAlgebra D.mapToPairOfMatrices D.mapToPairOfMatrices_isLinearMap
    D.mapToPairOfMatrices_mul_self

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras`：存在と一意性の主張のただ一つの準同型 Φ'。 -/
def homomorphismToPairOfMatrices : D.oddSpace.Cl → Mat (PowerSet D.M) × Mat (PowerSet D.M) :=
  Classical.choose D.existsUnique_homomorphismToPairOfMatrices

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras`：Φ' は ℂ-代数の準同型である。 -/
theorem homomorphismToPairOfMatrices_isHom :
    IsComplexAlgebraHomomorphism D.oddSpace.cliffordAlgebra D.pairOfMatricesAlgebra D.homomorphismToPairOfMatrices :=
  (Classical.choose_spec D.existsUnique_homomorphismToPairOfMatrices).1.1

/-- 本文 `def_homomorphism_from_odd_clifford_algebra_to_pair_of_matrix_algebras`：Φ' ∘ γ' = φ'。 -/
theorem homomorphismToPairOfMatrices_γ (x : (W × DualSpace D.spaceW) × ℂ) :
    D.homomorphismToPairOfMatrices (D.oddSpace.γ x) = D.mapToPairOfMatrices x :=
  (Classical.choose_spec D.existsUnique_homomorphismToPairOfMatrices).1.2 x

/-- 本文 `claim_homomorphism_to_pair_of_matrices_after_induced_homomorphism`：すべての a ∈ A について Φ'(j(a)) = (Φ(a), Φ(a))。
Δ := ⟨Φ, Φ⟩ と Φ' ∘ j はどちらも準同型で、γ(v) の上で一致するので等しい（`claim_homomorphisms_agreeing_on_generators_are_equal`）。 -/
theorem homomorphismToPairOfMatrices_oddInclusionHom (a : D.space.Cl) :
    D.homomorphismToPairOfMatrices (D.oddInclusionHom a) = (D.homomorphismToMatrix a, D.homomorphismToMatrix a) := by
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  let Φ' := D.homomorphismToPairOfMatrices
  -- Δ := ⟨Φ, Φ⟩ は準同型（claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hΔ : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.pairOfMatricesAlgebra (pairMap Φ Φ) :=
    pairMap_isHom D.homomorphismToMatrix_isHom D.homomorphismToMatrix_isHom
  -- Φ' ∘ j は準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hcomp : IsComplexAlgebraHomomorphism D.space.cliffordAlgebra D.pairOfMatricesAlgebra
      (fun x => Φ' (D.oddInclusionHom x)) :=
    IsComplexAlgebraHomomorphism.comp D.oddInclusionHom_isHom D.homomorphismToPairOfMatrices_isHom
  have hγ : ∀ v : W × DualSpace D.spaceW, Φ' (D.oddInclusionHom (D.space.γ v)) = pairMap Φ Φ (D.space.γ v) :=
    fun v => calc
    Φ' (D.oddInclusionHom (D.space.γ v)) = Φ' (D.oddSpace.γ (D.oddInclusion v)) := by rw [D.oddInclusionHom_γ v]
    _ = D.mapToPairOfMatrices (D.oddInclusion v) := D.homomorphismToPairOfMatrices_γ _
    _ = D.mapToPairOfMatrices (v, complexNumbersVectorSpace.zero) := rfl
    _ = D.mapToPairOfMatrices (v, 0) := rfl
    _ = (B.add (Φ (D.space.γ v)) (B.smul 0 (Φ D.parityElement)),
          B.add (Φ (D.space.γ v)) (B.smul (-0) (Φ D.parityElement))) := rfl
    _ = (B.add (Φ (D.space.γ v)) (B.smul 0 (Φ D.parityElement)),
          B.add (Φ (D.space.γ v)) (B.smul 0 (Φ D.parityElement))) := by
        -- ℂ の四則
        rw [neg_zero]
    _ = (B.add (Φ (D.space.γ v)) B.zero, B.add (Φ (D.space.γ v)) B.zero) := by
        -- claim_zero_scalar_multiple_is_zero_vector を各成分に
        rw [show B.smul 0 (Φ D.parityElement) = B.zero from zero_smul_eq_zero B.toComplexVectorSpace _]
    _ = (Φ (D.space.γ v), Φ (D.space.γ v)) := by
        -- U_vec(B) の加法の単位元。各成分に
        rw [B.add_zero (Φ (D.space.γ v))]
    _ = pairMap Φ Φ (D.space.γ v) := rfl
  -- γ(V) は A を生成する（claim_image_of_clifford_generator_map_generates_clifford_algebra）
  calc Φ' (D.oddInclusionHom a)
      = pairMap Φ Φ a :=
        eq_of_agree_on_generators hcomp hΔ (Set.range D.space.γ) D.space.γ_generates
          (fun _ ⟨v, hv⟩ => by rw [← hv]; exact hγ v) a
    _ = (Φ a, Φ a) := rfl

/-- 本文 `claim_homomorphism_to_pair_of_matrices_on_added_generator`：Φ'(g) = (Φ(ε), (-1_ℂ) ∗_B Φ(ε))。
Φ ∘ γ は線型写像なので Φ(γ(0_V)) = 0_B（`claim_linear_map_sends_zero_to_zero`）。 -/
theorem homomorphismToPairOfMatrices_addedGenerator :
    D.homomorphismToPairOfMatrices D.addedGenerator
      = (D.homomorphismToMatrix D.parityElement,
          D.matrixAlgebra.smul (-1) (D.homomorphismToMatrix D.parityElement)) := by
  let B := D.matrixAlgebra
  let Φ := D.homomorphismToMatrix
  let η := Φ D.parityElement
  have h0 : Φ (D.space.γ D.space.space.zero) = B.zero :=
    (IsComplexLinearMap.comp D.space.γ_isLinearMap D.homomorphismToMatrix_isHom.isLinearMap_underlying).map_zero
  calc D.homomorphismToPairOfMatrices D.addedGenerator
      = D.homomorphismToPairOfMatrices (D.oddSpace.γ D.addedUnitVector) := rfl
    _ = D.mapToPairOfMatrices D.addedUnitVector := D.homomorphismToPairOfMatrices_γ _
    _ = D.mapToPairOfMatrices (D.oddSecondInclusion 1) := rfl
    _ = D.mapToPairOfMatrices (D.space.space.zero, 1) := rfl
    _ = (B.add (Φ (D.space.γ D.space.space.zero)) (B.smul 1 η),
          B.add (Φ (D.space.γ D.space.space.zero)) (B.smul (-1) η)) := rfl
    _ = (B.add B.zero (B.smul 1 η), B.add B.zero (B.smul (-1) η)) := by
        -- Φ(γ(0_V)) = 0_B を二か所に
        rw [h0]
    _ = (B.add B.zero (B.smul 1 η), B.add B.zero (B.smul (-1) η)) := rfl  -- -1_ℂ の定義
    _ = (B.add (B.smul 1 η) B.zero, B.add (B.smul (-1) η) B.zero) := by
        -- U_vec(B) の加法の交換法則。各成分に
        rw [B.add_comm B.zero (B.smul 1 η), B.add_comm B.zero (B.smul (-1) η)]
    _ = (B.smul 1 η, B.smul (-1) η) := by
        -- U_vec(B) の加法の単位元。各成分に
        rw [B.add_zero (B.smul 1 η), B.add_zero (B.smul (-1) η)]
    _ = (η, B.smul (-1) η) := by
        -- U_vec(B) のスカラー倍の単位元
        rw [B.one_smul η]

end

end CliffordMatrixIsomorphism.Clifford.SplitData
