/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Φ_Y が値が 1 の直交基底の元の像を送る先、
Ω・Ω' が直交基底の元の像を送る先、系の定理の具体版を、各段の導出版から組み立てた導出版。

運び方: 系「一般の偶数次元」の導出版（`IsometryToSplitSpaceFromNecSuf.lean` の冒頭）と同じく、具体版の Cl(Y,Q)・Cl(V,q) と
必要十分版のそれは別の集合なので、必要十分版の主張を直に特殊化しない。具体版と同じ calc の行を、各行が引く主張の導出版
（`inducedHom_γ_of_necSuf`・`mapByCoordinates_basis_of_necSuf`・`pair_eq_add_embed_of_necSuf`・
`γ_isLinearMap_of_necSuf`・`homomorphismToMatrix_isHom_of_necSuf`・`homomorphismToMatrix_creation_of_necSuf`・
`homomorphismToMatrix_annihilation_of_necSuf`・`generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family_of_necSuf`・
`conjugation_…_of_necSuf`、この節の行列の側の主張の導出版）で書き直す。Ω・Ω' は具体版の定義をそのまま使う。
u の定義を開く行（`splitFamily_first`・`splitFamily_second`）は定義の展開で、主張を引く行ではないので具体版のものを使う。

  具体版                                                         導出版
  homomorphismToMatrixOfGeneral_first・…_second                  …_of_necSuf
  conjugatedHomomorphismToMatrix_first・…_second                 …_of_necSuf
  conjugatedHomomorphisms_mutually_inverse_of_family・
  conjugatedHomomorphisms_mutually_inverse                       …_of_necSuf
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphism
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugationFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpaceFromNecSuf

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### Φ_Y が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis` を、各段の導出版から
具体版と同じ手順で組み立てたもの。 -/
theorem homomorphismToMatrixOfGeneral_first_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
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
    _ = Φ (D.space.γ (θ (e m))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf]
    _ = Φ (D.space.γ (D.splitFamily m)) := by
        rw [show θ (e m) = D.splitFamily m from
          mapByCoordinates_basis_of_necSuf QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily m hm.1 (by omega)]
    _ = Φ (D.space.γ (D.w m, D.f m)) := by rw [D.splitFamily_first m hm.2]
    _ = Φ (D.space.γ (D.space.space.add (embedFirst S₂ (D.w m)) (embedSecond D.spaceW (D.f m)))) :=
        congrArg (fun p => Φ (D.space.γ p)) (pair_eq_add_embed_of_necSuf D.spaceW S₂ (D.w m) (D.f m))
    _ = Φ (A.add (D.space.γ (embedFirst S₂ (D.w m))) (D.space.γ (embedSecond D.spaceW (D.f m)))) := by
        rw [D.space.γ_isLinearMap_of_necSuf.map_add]; rfl
    _ = Φ (A.add (D.creation m) (D.annihilation m)) := rfl
    _ = B.add (Φ (D.creation m)) (Φ (D.annihilation m)) := D.homomorphismToMatrix_isHom_of_necSuf.map_add _ _
    _ = B.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm) := by
        rw [show Φ (D.creation m) = creationMatrix D.M m hm from D.homomorphismToMatrix_creation_of_necSuf hm,
          show Φ (D.annihilation m) = annihilationMatrix D.M m hm from D.homomorphismToMatrix_annihilation_of_necSuf hm]

/-- 本文 `claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis` を、各段の導出版から
具体版と同じ手順で組み立てたもの。 -/
theorem homomorphismToMatrixOfGeneral_second_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
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
    (embedFirst_isLinearMap_of_necSuf D.spaceW S₂).map_smul (-i) (D.w m)
  have hin2 : embedSecond D.spaceW (S₂.smul i (D.f m)) = SV.smul i (embedSecond D.spaceW (D.f m)) :=
    (embedSecond_isLinearMap_of_necSuf D.spaceW S₂).map_smul i (D.f m)
  calc D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))
      = Φ (QuadraticSpaceWithBasis.inducedHom QY D.space θ hθ (QY.γ (e (D.M + m)))) := rfl
    _ = Φ (D.space.γ (θ (e (D.M + m)))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ_of_necSuf]
    _ = Φ (D.space.γ (D.splitFamily (D.M + m))) := by
        rw [show θ (e (D.M + m)) = D.splitFamily (D.M + m) from
          mapByCoordinates_basis_of_necSuf QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily (D.M + m) (by omega)
            (by omega)]
    _ = Φ (D.space.γ (D.spaceW.smul (-i) (D.w m), S₂.smul i (D.f m))) := by rw [D.splitFamily_second m hm.1]
    _ = Φ (D.space.γ (SV.add (embedFirst S₂ (D.spaceW.smul (-i) (D.w m)))
          (embedSecond D.spaceW (S₂.smul i (D.f m))))) :=
        congrArg (fun p => Φ (D.space.γ p))
          (pair_eq_add_embed_of_necSuf D.spaceW S₂ (D.spaceW.smul (-i) (D.w m)) (S₂.smul i (D.f m)))
    _ = Φ (D.space.γ (SV.add (SV.smul (-i) (embedFirst S₂ (D.w m))) (SV.smul i (embedSecond D.spaceW (D.f m))))) := by
        rw [hin1, hin2]
    _ = Φ (A.add (D.space.γ (SV.smul (-i) (embedFirst S₂ (D.w m))))
          (D.space.γ (SV.smul i (embedSecond D.spaceW (D.f m))))) := by rw [D.space.γ_isLinearMap_of_necSuf.map_add]; rfl
    _ = Φ (A.add (A.smul (-i) (D.space.γ (embedFirst S₂ (D.w m))))
          (A.smul i (D.space.γ (embedSecond D.spaceW (D.f m))))) := by
        rw [D.space.γ_isLinearMap_of_necSuf.map_smul (-i) (embedFirst S₂ (D.w m)),
          D.space.γ_isLinearMap_of_necSuf.map_smul i (embedSecond D.spaceW (D.f m))]; rfl
    _ = Φ (A.add (A.smul (-i) (D.creation m)) (A.smul i (D.annihilation m))) := rfl
    _ = B.add (Φ (A.smul (-i) (D.creation m))) (Φ (A.smul i (D.annihilation m))) :=
        D.homomorphismToMatrix_isHom_of_necSuf.map_add _ _
    _ = B.add (B.smul (-i) (Φ (D.creation m))) (B.smul i (Φ (D.annihilation m))) := by
        rw [show Φ (A.smul (-i) (D.creation m)) = B.smul (-i) (Φ (D.creation m)) from
            D.homomorphismToMatrix_isHom_of_necSuf.map_smul (-i) (D.creation m),
          show Φ (A.smul i (D.annihilation m)) = B.smul i (Φ (D.annihilation m)) from
            D.homomorphismToMatrix_isHom_of_necSuf.map_smul i (D.annihilation m)]
    _ = B.add (B.smul (-i) (creationMatrix D.M m hm)) (B.smul i (annihilationMatrix D.M m hm)) := by
        rw [show Φ (D.creation m) = creationMatrix D.M m hm from D.homomorphismToMatrix_creation_of_necSuf hm,
          show Φ (D.annihilation m) = annihilationMatrix D.M m hm from D.homomorphismToMatrix_annihilation_of_necSuf hm]

/-! ### U と U' で挟んだ写像 Ω・Ω' -/

/-- 本文 `claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix` を、各段の導出版から
具体版と同じ手順で組み立てたもの。 -/
theorem conjugatedHomomorphismToMatrix_first_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m)) = jordanWignerZ D.M m := calc
  D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m))
      = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e m))) := rfl
  _ = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (Mat.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm)) := by
        rw [D.homomorphismToMatrixOfGeneral_first_of_necSuf QY e he m hm]; rfl
  _ = jordanWignerZ D.M m := conjugation_creation_add_annihilation_of_necSuf D.M m hm

/-- 本文 `claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix` を、各段の導出版から
具体版と同じ手順で組み立てたもの。 -/
theorem conjugatedHomomorphismToMatrix_second_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = jordanWignerY D.M m := calc
  D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m)))
      = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))) := rfl
  _ = conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
          (Mat.add (Mat.smul (-imaginaryUnit) (creationMatrix D.M m hm))
            (Mat.smul imaginaryUnit (annihilationMatrix D.M m hm))) := by
        rw [D.homomorphismToMatrixOfGeneral_second_of_necSuf QY e he m hm]; rfl
  _ = jordanWignerY D.M m := conjugation_imaginary_combination_of_necSuf D.M m hm

/-! ### 系の定理 -/

/-- 系の定理の本体（`conjugatedHomomorphisms_mutually_inverse_of_family`）を、各段の導出版から組み立てたもの。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_family_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
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
  obtain ⟨hΦY, hΨY, hΨΦ, hΦΨ, -, -⟩ := D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family_of_necSuf QY e he
  -- U ·_B U' = 1_B と U' ·_B U = 1_B
  have hUU' : Mat.mul hX U U' = Mat.one := kroneckerPowerOfExchange_mul_half_of_necSuf D.M
  have hU'U : Mat.mul hX U' U = Mat.one := kroneckerPowerOfHalfExchange_mul_of_necSuf D.M
  -- κ_{U,U'} と κ_{U',U} は ℂ-代数の準同型
  have hκ : IsComplexAlgebraHomomorphism D.matrixAlgebra D.matrixAlgebra (conjugation hX U U') :=
    conjugation_isComplexAlgebraHomomorphism_of_necSuf hX U U' hUU' hU'U
  have hκ' : IsComplexAlgebraHomomorphism D.matrixAlgebra D.matrixAlgebra (conjugation hX U' U) :=
    conjugation_isComplexAlgebraHomomorphism_of_necSuf hX U' U hU'U hUU'
  -- 合成 Ω と Ω' は ℂ-代数の準同型
  have hΩ : IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra Ω :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := ΦY) (ψ := conjugation hX U U') hΦY hκ
  have hΩ' : IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra Ω' :=
    IsComplexAlgebraHomomorphism.comp_of_necSuf (φ := conjugation hX U' U) (ψ := ΨY) hκ' hΨY
  -- 一つ目の等式：κ_{U',U}(κ_{U,U'}(G)) = G。二つ目の等式：κ_{U,U'}(κ_{U',U}(G)) = G
  have h1 : ∀ G : Mat (PowerSet D.M), conjugation hX U' U (conjugation hX U U' G) = G :=
    conjugation_conjugation_of_necSuf hX U U' hU'U
  have h2 : ∀ G : Mat (PowerSet D.M), conjugation hX U U' (conjugation hX U' U G) = G :=
    conjugation_conjugation_of_necSuf hX U' U hUU'
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

/-- 本文 `theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms`
を、各段の導出版から組み立てたもの（e := `orthonormalBasis`）。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_necSuf (QY : Clifford.QuadraticSpaceWithBasis Y)
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
  D.conjugatedHomomorphisms_mutually_inverse_of_family_of_necSuf QY _ (D.orthonormalBasis_spec_of_necSuf QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
