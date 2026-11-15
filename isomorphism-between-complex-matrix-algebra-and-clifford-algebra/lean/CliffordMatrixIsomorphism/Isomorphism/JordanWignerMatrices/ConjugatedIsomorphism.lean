/-
章「同型の証明」の節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、一般の偶数次元の系の準同型 Φ_Y が
値が 1 の直交基底の元の像を送る先と、Φ_Y・Ψ_Y を U と U' で挟んだ写像 Ω・Ω' と、系の定理の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                       このファイル
  claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis           homomorphismToMatrixOfGeneral_first
  claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis          homomorphismToMatrixOfGeneral_second
  def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power       conjugatedHomomorphismToMatrix（Ω）
  def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power         conjugatedHomomorphismFromMatrix（Ω'）
  claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
                                                                                     conjugatedHomomorphismToMatrix_first
  claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
                                                                                     conjugatedHomomorphismToMatrix_second
  theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
                                                                                     conjugatedHomomorphisms_mutually_inverse_of_family・
                                                                                     conjugatedHomomorphisms_mutually_inverse

表し方:
- 前提の組は系「一般の偶数次元の非退化な二次空間」と同じく `D : SplitData W`、`QY`、e と e の三つの条件 `he` で受ける
  （`IsometryToSplitSpace.lean` の冒頭）。本文の e は `orthonormalBasis` で固定した族だが、主張の証明が e について使うのは
  三つの条件（θ を定めるための基底であること）だけなので、主張と Ω・Ω' は e と `he` を引数にとる。系の定理では
  e := `orthonormalBasis` とする（`conjugatedHomomorphisms_mutually_inverse`）。
- Φ_Y・Ψ_Y は `homomorphismToMatrixOfGeneral`・`homomorphismFromMatrixOfGeneral`、Φ は `homomorphismToMatrix`、Cl(θ) は
  `QuadraticSpaceWithBasis.inducedHom`、θ は `mapToSplit`（= L_{e,u}。`mapByCoordinates`）、u は `splitFamily`。
- B := Mat_{P_M}(ℂ) は `D.matrixAlgebra`（演算は `Mat.add`・`Mat.mul`・`Mat.smul` と定義により同じ）、
  κ_{U,U'} は `conjugation (isFiniteSet_powerSet D.M) U U'`。
- 本文の「γ はスカラー倍を保つ（二か所）」「Φ はスカラー倍を保つ（二か所）」の行は、同じ主張を二か所へ当てる一行である。
- 系の定理の「Ω は全単射であり、その逆写像は Ω'」は、系「一般の偶数次元」の定理と同じく `Function.Bijective` と
  「Ω(a) = F を満たす a は Ω'(F) である」で書く。

本文が引く主張は次の宣言を引く。
  def_homomorphism_of_clifford_algebras_induced_by_isometry                 inducedHom_γ（Cl(θ) ∘ γ_Y = γ ∘ θ）・inducedHom_isHom
  claim_map_by_coordinates_and_family_sends_basis_member_to_family_member   mapByCoordinates_basis
  def_family_in_split_space_for_isometry                                    splitFamily_first・splitFamily_second
  claim_direct_sum_element_is_sum_of_embedded_components                    pair_eq_add_embed
  claim_embedding_into_first_component_is_linear_map・…_second_…           embedFirst_isLinearMap・embedSecond_isLinearMap
  claim_clifford_generator_map_is_linear_map                                γ_isLinearMap
  claim_homomorphism_to_matrix_algebra_sends_creation_generator_to_creation_operator_matrix
                                                                            homomorphismToMatrix_creation
  claim_homomorphism_to_matrix_algebra_sends_annihilation_generator_to_annihilation_operator_matrix
                                                                            homomorphismToMatrix_annihilation
  claim_conjugation_by_mutually_inverse_matrices_is_algebra_homomorphism    conjugation_isComplexAlgebraHomomorphism
  claim_conjugations_by_mutually_inverse_matrices_compose_to_identity       conjugation_conjugation
  claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism        IsComplexAlgebraHomomorphism.comp

必要十分版は `NecSuf/Isomorphism/JordanWignerMatrices/ConjugatedIsomorphism.lean`、導出版は `ConjugatedIsomorphismFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugation

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### Φ_Y が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis`：Φ_Y(γ_Y(e_m)) = c_m +_B c_m^T。 -/
theorem homomorphismToMatrixOfGeneral_first (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e m))
      = D.matrixAlgebra.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm) := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let S₂ := dualSpaceVectorSpace D.spaceW
  let Φ := D.homomorphismToMatrix
  let θ := D.mapToSplit QY e he
  let hθ := D.mapToSplit_isIsometry QY e he
  calc D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e m))
      = Φ (QuadraticSpaceWithBasis.inducedHom QY D.space θ hθ (QY.γ (e m))) := rfl
    _ = Φ (D.space.γ (θ (e m))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ]
    _ = Φ (D.space.γ (D.splitFamily m)) := by
        rw [show θ (e m) = D.splitFamily m from
          mapByCoordinates_basis QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily m hm.1 (by omega)]
    _ = Φ (D.space.γ (D.w m, D.f m)) := by rw [D.splitFamily_first m hm.2]
    _ = Φ (D.space.γ (D.space.space.add (embedFirst S₂ (D.w m)) (embedSecond D.spaceW (D.f m)))) :=
        congrArg (fun p => Φ (D.space.γ p)) (pair_eq_add_embed D.spaceW S₂ (D.w m) (D.f m))
    _ = Φ (A.add (D.space.γ (embedFirst S₂ (D.w m))) (D.space.γ (embedSecond D.spaceW (D.f m)))) := by
        rw [D.space.γ_add]
    _ = Φ (A.add (D.creation m) (D.annihilation m)) := rfl
    _ = B.add (Φ (D.creation m)) (Φ (D.annihilation m)) := D.homomorphismToMatrix_isHom.map_add _ _
    _ = B.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm) := by
        rw [show Φ (D.creation m) = creationMatrix D.M m hm from D.homomorphismToMatrix_creation hm,
          show Φ (D.annihilation m) = annihilationMatrix D.M m hm from D.homomorphismToMatrix_annihilation hm]

/-- 本文 `claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis`：
Φ_Y(γ_Y(e_{M+m})) = ((-_ℂ i) ∗_B c_m) +_B (i ∗_B c_m^T)。 -/
theorem homomorphismToMatrixOfGeneral_second (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))
      = D.matrixAlgebra.add (D.matrixAlgebra.smul (-imaginaryUnit) (creationMatrix D.M m hm))
          (D.matrixAlgebra.smul imaginaryUnit (annihilationMatrix D.M m hm)) := by
  let A := D.space.cliffordAlgebra
  let B := D.matrixAlgebra
  let SV := D.space.space
  let S₂ := dualSpaceVectorSpace D.spaceW
  let Φ := D.homomorphismToMatrix
  let θ := D.mapToSplit QY e he
  let hθ := D.mapToSplit_isIsometry QY e he
  let i := imaginaryUnit
  have hin1 : embedFirst S₂ (D.spaceW.smul (-i) (D.w m)) = SV.smul (-i) (embedFirst S₂ (D.w m)) :=
    (embedFirst_isLinearMap D.spaceW S₂).map_smul (-i) (D.w m)
  have hin2 : embedSecond D.spaceW (S₂.smul i (D.f m)) = SV.smul i (embedSecond D.spaceW (D.f m)) :=
    (embedSecond_isLinearMap D.spaceW S₂).map_smul i (D.f m)
  calc D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))
      = Φ (QuadraticSpaceWithBasis.inducedHom QY D.space θ hθ (QY.γ (e (D.M + m)))) := rfl
    _ = Φ (D.space.γ (θ (e (D.M + m)))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ]
    _ = Φ (D.space.γ (D.splitFamily (D.M + m))) := by
        rw [show θ (e (D.M + m)) = D.splitFamily (D.M + m) from
          mapByCoordinates_basis QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily (D.M + m) (by omega)
            (by omega)]
    _ = Φ (D.space.γ (D.spaceW.smul (-i) (D.w m), S₂.smul i (D.f m))) := by rw [D.splitFamily_second m hm.1]
    _ = Φ (D.space.γ (SV.add (embedFirst S₂ (D.spaceW.smul (-i) (D.w m)))
          (embedSecond D.spaceW (S₂.smul i (D.f m))))) :=
        congrArg (fun p => Φ (D.space.γ p))
          (pair_eq_add_embed D.spaceW S₂ (D.spaceW.smul (-i) (D.w m)) (S₂.smul i (D.f m)))
    _ = Φ (D.space.γ (SV.add (SV.smul (-i) (embedFirst S₂ (D.w m))) (SV.smul i (embedSecond D.spaceW (D.f m))))) := by
        rw [hin1, hin2]
    _ = Φ (A.add (D.space.γ (SV.smul (-i) (embedFirst S₂ (D.w m))))
          (D.space.γ (SV.smul i (embedSecond D.spaceW (D.f m))))) := by rw [D.space.γ_add]
    _ = Φ (A.add (A.smul (-i) (D.space.γ (embedFirst S₂ (D.w m))))
          (A.smul i (D.space.γ (embedSecond D.spaceW (D.f m))))) := by
        rw [D.space.γ_isLinearMap.map_smul (-i) (embedFirst S₂ (D.w m)),
          D.space.γ_isLinearMap.map_smul i (embedSecond D.spaceW (D.f m))]; rfl
    _ = Φ (A.add (A.smul (-i) (D.creation m)) (A.smul i (D.annihilation m))) := rfl
    _ = B.add (Φ (A.smul (-i) (D.creation m))) (Φ (A.smul i (D.annihilation m))) :=
        D.homomorphismToMatrix_isHom.map_add _ _
    _ = B.add (B.smul (-i) (Φ (D.creation m))) (B.smul i (Φ (D.annihilation m))) := by
        rw [show Φ (A.smul (-i) (D.creation m)) = B.smul (-i) (Φ (D.creation m)) from
            D.homomorphismToMatrix_isHom.map_smul (-i) (D.creation m),
          show Φ (A.smul i (D.annihilation m)) = B.smul i (Φ (D.annihilation m)) from
            D.homomorphismToMatrix_isHom.map_smul i (D.annihilation m)]
    _ = B.add (B.smul (-i) (creationMatrix D.M m hm)) (B.smul i (annihilationMatrix D.M m hm)) := by
        rw [show Φ (D.creation m) = creationMatrix D.M m hm from D.homomorphismToMatrix_creation hm,
          show Φ (D.annihilation m) = annihilationMatrix D.M m hm from D.homomorphismToMatrix_annihilation hm]

/-! ### U と U' で挟んだ写像 Ω・Ω' -/

/-- 本文 `def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power`：Ω := κ_{U,U'} ∘ Φ_Y。 -/
def conjugatedHomomorphismToMatrix (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) : Mat (PowerSet D.M) :=
  conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
    (D.homomorphismToMatrixOfGeneral QY e he a)

/-- 本文 `def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power`：Ω' := Ψ_Y ∘ κ_{U',U}。 -/
def conjugatedHomomorphismFromMatrix (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat (PowerSet D.M)) : QY.Cl :=
  D.homomorphismFromMatrixOfGeneral QY e he
    (conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfHalfExchange D.M) (kroneckerPowerOfExchange D.M) F)

/-- 本文 `claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix`：Ω(γ_Y(e_m)) = Z_m。 -/
theorem conjugatedHomomorphismToMatrix_first (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m)) = jordanWignerZ D.M m := calc
  D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m))
      = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e m))) := rfl
  _ = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (Mat.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm)) := by
        rw [D.homomorphismToMatrixOfGeneral_first QY e he m hm]; rfl
  _ = jordanWignerZ D.M m := conjugation_creation_add_annihilation D.M m hm

/-- 本文 `claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix`：
Ω(γ_Y(e_{M+m})) = Y_m。 -/
theorem conjugatedHomomorphismToMatrix_second (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = jordanWignerY D.M m := calc
  D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))
      = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))) := rfl
  _ = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (Mat.add (Mat.smul (-imaginaryUnit) (creationMatrix D.M m hm))
            (Mat.smul imaginaryUnit (annihilationMatrix D.M m hm))) := by
        rw [D.homomorphismToMatrixOfGeneral_second QY e he m hm]; rfl
  _ = jordanWignerY D.M m := conjugation_imaginary_combination D.M m hm

/-! ### 系の定理 -/

/-- 系の定理の本体：e が三つの条件を満たす任意の族のとき、Ω と Ω' は互いに逆な ℂ-代数の準同型である。
本文の定理は e := `orthonormalBasis` の場合（`conjugatedHomomorphisms_mutually_inverse`）。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_family (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.conjugatedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.conjugatedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.conjugatedHomomorphismFromMatrix QY e he (D.conjugatedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.conjugatedHomomorphismToMatrix QY e he (D.conjugatedHomomorphismFromMatrix QY e he F) = F) ∧
      Function.Bijective (D.conjugatedHomomorphismToMatrix QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.conjugatedHomomorphismToMatrix QY e he a = F → a = D.conjugatedHomomorphismFromMatrix QY e he F) := by
  let hX := isFiniteSet_powerSet D.M
  let U := kroneckerPowerOfExchange D.M
  let U' := kroneckerPowerOfHalfExchange D.M
  let ΦY := D.homomorphismToMatrixOfGeneral QY e he
  let ΨY := D.homomorphismFromMatrixOfGeneral QY e he
  let Ω := D.conjugatedHomomorphismToMatrix QY e he
  let Ω' := D.conjugatedHomomorphismFromMatrix QY e he
  obtain ⟨hΦY, hΨY, hΨΦ, hΦΨ, -, -⟩ := D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family QY e he
  -- U ·_B U' = 1_B と U' ·_B U = 1_B
  have hUU' : Mat.mul hX U U' = Mat.one := kroneckerPowerOfExchange_mul_half D.M
  have hU'U : Mat.mul hX U' U = Mat.one := kroneckerPowerOfHalfExchange_mul D.M
  -- κ_{U,U'} と κ_{U',U} は ℂ-代数の準同型
  have hκ : IsComplexAlgebraHomomorphism D.matrixAlgebra D.matrixAlgebra (conjugation hX U U') :=
    conjugation_isComplexAlgebraHomomorphism hX U U' hUU' hU'U
  have hκ' : IsComplexAlgebraHomomorphism D.matrixAlgebra D.matrixAlgebra (conjugation hX U' U) :=
    conjugation_isComplexAlgebraHomomorphism hX U' U hU'U hUU'
  -- 合成 Ω と Ω' は ℂ-代数の準同型
  have hΩ : IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra Ω :=
    IsComplexAlgebraHomomorphism.comp (φ := ΦY) (ψ := conjugation hX U U') hΦY hκ
  have hΩ' : IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra Ω' :=
    IsComplexAlgebraHomomorphism.comp (φ := conjugation hX U' U) (ψ := ΨY) hκ' hΨY
  -- 一つ目の等式：κ_{U',U}(κ_{U,U'}(G)) = G。二つ目の等式：κ_{U,U'}(κ_{U',U}(G)) = G
  have h1 : ∀ G : Mat (PowerSet D.M), conjugation hX U' U (conjugation hX U U' G) = G :=
    conjugation_conjugation hX U U' hU'U
  have h2 : ∀ G : Mat (PowerSet D.M), conjugation hX U U' (conjugation hX U' U G) = G :=
    conjugation_conjugation hX U' U hUU'
  have hΩ'Ω : ∀ a : QY.Cl, Ω' (Ω a) = a := fun a => calc
    Ω' (Ω a) = ΨY (conjugation hX U' U (conjugation hX U U' (ΦY a))) := rfl
    _ = ΨY (ΦY a) := by rw [show conjugation hX U' U (conjugation hX U U' (ΦY a)) = ΦY a from h1 (ΦY a)]
    _ = a := hΨΦ a
  have hΩΩ' : ∀ F : Mat (PowerSet D.M), Ω (Ω' F) = F := fun F => calc
    Ω (Ω' F) = conjugation hX U U' (ΦY (ΨY (conjugation hX U' U F))) := rfl
    _ = conjugation hX U U' (conjugation hX U' U F) := by rw [show ΦY (ΨY (conjugation hX U' U F)) = conjugation hX U' U F from hΦΨ (conjugation hX U' U F)]
    _ = F := h2 F
  -- 単射であること
  have hinj : Function.Injective Ω := by
    intro a a' haa'
    calc a = Ω' (Ω a) := (hΩ'Ω a).symm
      _ = Ω' (Ω a') := by rw [haa']
      _ = a' := hΩ'Ω a'
  -- 全射であること
  have hsurj : Function.Surjective Ω := fun F => ⟨Ω' F, hΩΩ' F⟩
  -- Ω^{-1}(F) = Ω'(F)
  have hinv : ∀ (F : Mat (PowerSet D.M)) (a : QY.Cl), Ω a = F → a = Ω' F := by
    intro F a ha
    apply hinj
    calc Ω a = F := ha
      _ = Ω (Ω' F) := (hΩΩ' F).symm
  exact ⟨hΩ, hΩ', hΩ'Ω, hΩΩ', ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms`：
e := `orthonormalBasis` のとき、Ω := κ_{U,U'} ∘ Φ_Y と Ω' := Ψ_Y ∘ κ_{U',U} は ℂ-代数の準同型で、互いに逆であり、
Ω は全単射でその逆写像は Ω' である。 -/
theorem conjugatedHomomorphisms_mutually_inverse (QY : Clifford.QuadraticSpaceWithBasis Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis QY hdim hQ
    let he := D.orthonormalBasis_spec QY hdim hQ
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.conjugatedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.conjugatedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.conjugatedHomomorphismFromMatrix QY e he (D.conjugatedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.conjugatedHomomorphismToMatrix QY e he (D.conjugatedHomomorphismFromMatrix QY e he F) = F) ∧
      Function.Bijective (D.conjugatedHomomorphismToMatrix QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.conjugatedHomomorphismToMatrix QY e he a = F → a = D.conjugatedHomomorphismFromMatrix QY e he F) :=
  D.conjugatedHomomorphisms_mutually_inverse_of_family QY _ (D.orthonormalBasis_spec QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
