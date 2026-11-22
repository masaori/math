/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Φ_Y が値が 1 の直交基底の元の像を送る先と、
Ω := κ_{U,U'} ∘ Φ_Y・Ω' := Ψ_Y ∘ κ_{U',U} と、系の定理の必要十分版。具体版
`Isomorphism/JordanWignerMatrices/ConjugatedIsomorphism.lean` と同じ def と calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ・i・h を K の元 n・i・h に替えて書く（前提の組は系「一般の偶数次元」の必要十分版
`NecSuf/Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean` と同じ）。

主張ごとに使う K の性質（どの主張も、Cl(V,q) を作るために章「クリフォード代数」の仮定 `CliffordLaws K n` を持ち、Φ_Y を作るために
系「一般の偶数次元」の仮定 a + (-a) = 0、(-a) · b = -(a · b)、-(-a) = a、i · i = -1、Q が二次形式であること、e の三つの条件を持つ）:

  本文のラベル                                                                  このファイル                              足す性質
  claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis      homomorphismToMatrixOfGeneral_first       なし
  claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis     homomorphismToMatrixOfGeneral_second      なし
  def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power  conjugatedHomomorphismToMatrix（Ω）        h（K の元を一つ）
  def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power    conjugatedHomomorphismFromMatrix（Ω'）     h が 1 + 1 の両側の逆元
                                                                                                                          （Ψ_Y を作るため）
  claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
                                                                                conjugatedHomomorphismToMatrix_first      (1 + 1) · h = 1
  claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
                                                                                conjugatedHomomorphismToMatrix_second     (1 + 1) · h = 1
  theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
                                                                                conjugatedHomomorphisms_mutually_inverse_of_family・
                                                                                conjugatedHomomorphisms_mutually_inverse  h · (1 + 1) = 1 と (1 + 1) · h = 1
                                                                                                                          （後者は e を固定する仮定の組 E も）

分かったこと:
- 行列の側の主張（`JordanWignerConjugation.lean`）が仮定に置いた -1 = n は、`CliffordLaws K n`（1 + n = 0 と加法の公理）と
  a + (-a) = 0 から出る（`neg_one_eq_n`）。乗法の交換法則と a · 0 = 0 は `CliffordLaws K n` の欄である。
- 2 の可逆性が Φ_Y の像の主張と Ω の像の主張に要るのは、U と U' が互いの逆であること（K K' = 1 の準備 h + h = 1）だけで、
  Φ_Y が e_m・e_{M+m} を送る先（c_m + c_m^T など）は 2 の可逆性を使わない。
- i · i = -1 は、Φ_Y を作る段（θ が等長写像であること）から来るだけで、この節の行の中では使わない。
- 本文の前提 M ≥ 1 は、どの主張も使わない。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.JordanWignerConjugation
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpace

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet)

universe u v uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W) {Y : Type v}

include C in
/-- `CliffordLaws K n` の 1 + n = 0 と加法の公理と a + (-a) = 0 から、-1 = n（加法の逆元は一つしかない）。 -/
theorem neg_one_eq_n (hneg : ∀ a : K, a + -a = 0) : (-1 : K) = n := calc
  (-1 : K) = -1 + 0 := (C.uniqueness.add_zero _).symm
  _ = -1 + (1 + n) := by rw [C.congruence.one_add_n]
  _ = (-1 + 1) + n := (C.uniqueness.add_assoc _ _ _).symm
  _ = (1 + -1) + n := by rw [C.uniqueness.add_comm (-1) 1]
  _ = 0 + n := by rw [hneg 1]
  _ = n := C.uniqueness.zero_add n

/-! ### Φ_Y が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis` の必要十分版。 -/
theorem homomorphismToMatrixOfGeneral_first (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e m))
      = (D.matrixAlgebra C).add (creationMatrix n D.M m hm) (annihilationMatrix n D.M m hm) := by
  have hθ := D.mapToSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi QY hQf e he
  let A := (D.space C).cliffordAlgebra C
  let B := D.matrixAlgebra C
  let S₂ := dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW
  let Φ := D.homomorphismToMatrix C hneg
  let θ := D.mapToSplit C.splitSpaceLaws i QY e he.isBasis
  calc D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e m))
      = Φ (QuadraticSpaceWithBasis.inducedHom C hneg QY (D.space C) θ hθ.isLinearMap hθ.map_form (QY.γ C (e m))) :=
        rfl
    _ = Φ ((D.space C).γ C (θ (e m))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ]
    _ = Φ ((D.space C).γ C (D.splitFamily C.splitSpaceLaws i m)) := by
        rw [show θ (e m) = D.splitFamily C.splitSpaceLaws i m from
          mapByCoordinates_basis C.uniqueness QY.space (D.space C).space (D.M + D.M) e he.isBasis (D.splitFamily C.splitSpaceLaws i) m
            hm.1 (by omega)]
    _ = Φ ((D.space C).γ C (D.w m, D.f m)) := by rw [D.splitFamily_first C.splitSpaceLaws i m hm.2]
    _ = Φ ((D.space C).γ C ((D.space C).space.add (embedFirst S₂ (D.w m)) (embedSecond D.spaceW (D.f m)))) :=
        congrArg (fun p => Φ ((D.space C).γ C p)) (pair_eq_add_embed D.spaceW S₂ (D.w m) (D.f m))
    _ = Φ (A.add ((D.space C).γ C (embedFirst S₂ (D.w m))) ((D.space C).γ C (embedSecond D.spaceW (D.f m)))) := by
        rw [(D.space C).γ_add C]
    _ = Φ (A.add (D.creation C m) (D.annihilation C m)) := rfl
    _ = B.add (Φ (D.creation C m)) (Φ (D.annihilation C m)) := (D.homomorphismToMatrix_isHom C hneg).map_add _ _
    _ = B.add (creationMatrix n D.M m hm) (annihilationMatrix n D.M m hm) := by
        rw [show Φ (D.creation C m) = creationMatrix n D.M m hm from D.homomorphismToMatrix_creation C hneg hm,
          show Φ (D.annihilation C m) = annihilationMatrix n D.M m hm from
            D.homomorphismToMatrix_annihilation C hneg hm]

/-- 本文 `claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis` の必要十分版。 -/
theorem homomorphismToMatrixOfGeneral_second (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e (D.M + m)))
      = (D.matrixAlgebra C).add ((D.matrixAlgebra C).smul (-i) (creationMatrix n D.M m hm))
          ((D.matrixAlgebra C).smul i (annihilationMatrix n D.M m hm)) := by
  have hθ := D.mapToSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi QY hQf e he
  let A := (D.space C).cliffordAlgebra C
  let B := D.matrixAlgebra C
  let SV := (D.space C).space
  let S₂ := dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW
  let Φ := D.homomorphismToMatrix C hneg
  let θ := D.mapToSplit C.splitSpaceLaws i QY e he.isBasis
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  have hin1 : embedFirst S₂ (D.spaceW.smul (-i) (D.w m)) = SV.smul (-i) (embedFirst S₂ (D.w m)) :=
    (embedFirst_isLinearMap D.spaceW S₂ h00 C.uniqueness.mul_zero).map_smul (-i) (D.w m)
  have hin2 : embedSecond D.spaceW (S₂.smul i (D.f m)) = SV.smul i (embedSecond D.spaceW (D.f m)) :=
    (embedSecond_isLinearMap D.spaceW S₂ h00 C.uniqueness.mul_zero).map_smul i (D.f m)
  calc D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e (D.M + m)))
      = Φ (QuadraticSpaceWithBasis.inducedHom C hneg QY (D.space C) θ hθ.isLinearMap hθ.map_form
          (QY.γ C (e (D.M + m)))) := rfl
    _ = Φ ((D.space C).γ C (θ (e (D.M + m)))) := by rw [QuadraticSpaceWithBasis.inducedHom_γ]
    _ = Φ ((D.space C).γ C (D.splitFamily C.splitSpaceLaws i (D.M + m))) := by
        rw [show θ (e (D.M + m)) = D.splitFamily C.splitSpaceLaws i (D.M + m) from
          mapByCoordinates_basis C.uniqueness QY.space (D.space C).space (D.M + D.M) e he.isBasis (D.splitFamily C.splitSpaceLaws i)
            (D.M + m) (by omega) (by omega)]
    _ = Φ ((D.space C).γ C (D.spaceW.smul (-i) (D.w m), S₂.smul i (D.f m))) := by
        rw [D.splitFamily_second C.splitSpaceLaws i m hm.1]
    _ = Φ ((D.space C).γ C (SV.add (embedFirst S₂ (D.spaceW.smul (-i) (D.w m)))
          (embedSecond D.spaceW (S₂.smul i (D.f m))))) :=
        congrArg (fun p => Φ ((D.space C).γ C p))
          (pair_eq_add_embed D.spaceW S₂ (D.spaceW.smul (-i) (D.w m)) (S₂.smul i (D.f m)))
    _ = Φ ((D.space C).γ C (SV.add (SV.smul (-i) (embedFirst S₂ (D.w m)))
          (SV.smul i (embedSecond D.spaceW (D.f m))))) := by rw [hin1, hin2]
    _ = Φ (A.add ((D.space C).γ C (SV.smul (-i) (embedFirst S₂ (D.w m))))
          ((D.space C).γ C (SV.smul i (embedSecond D.spaceW (D.f m))))) := by rw [(D.space C).γ_add C]
    _ = Φ (A.add (A.smul (-i) ((D.space C).γ C (embedFirst S₂ (D.w m))))
          (A.smul i ((D.space C).γ C (embedSecond D.spaceW (D.f m))))) := by
        rw [((D.space C).γ_isLinearMap C).map_smul (-i) (embedFirst S₂ (D.w m)),
          ((D.space C).γ_isLinearMap C).map_smul i (embedSecond D.spaceW (D.f m))]; rfl
    _ = Φ (A.add (A.smul (-i) (D.creation C m)) (A.smul i (D.annihilation C m))) := rfl
    _ = B.add (Φ (A.smul (-i) (D.creation C m))) (Φ (A.smul i (D.annihilation C m))) :=
        (D.homomorphismToMatrix_isHom C hneg).map_add _ _
    _ = B.add (B.smul (-i) (Φ (D.creation C m))) (B.smul i (Φ (D.annihilation C m))) := by
        rw [show Φ (A.smul (-i) (D.creation C m)) = B.smul (-i) (Φ (D.creation C m)) from
            (D.homomorphismToMatrix_isHom C hneg).map_smul (-i) (D.creation C m),
          show Φ (A.smul i (D.annihilation C m)) = B.smul i (Φ (D.annihilation C m)) from
            (D.homomorphismToMatrix_isHom C hneg).map_smul i (D.annihilation C m)]
    _ = B.add (B.smul (-i) (creationMatrix n D.M m hm)) (B.smul i (annihilationMatrix n D.M m hm)) := by
        rw [show Φ (D.creation C m) = creationMatrix n D.M m hm from D.homomorphismToMatrix_creation C hneg hm,
          show Φ (D.annihilation C m) = annihilationMatrix n D.M m hm from
            D.homomorphismToMatrix_annihilation C hneg hm]

/-! ### Ω・Ω' -/

/-- 本文 `def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power` の必要十分版：Ω := κ_{U,U'} ∘ Φ_Y。 -/
def conjugatedHomomorphismToMatrix (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl C) : Mat K (PowerSet D.M) :=
  conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange h D.M)
    (D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he a)

/-- 本文 `def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power` の必要十分版：Ω' := Ψ_Y ∘ κ_{U',U}。 -/
def conjugatedHomomorphismFromMatrix (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : IsInverseOfTwo h)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat K (PowerSet D.M)) : QY.Cl C :=
  D.homomorphismFromMatrixOfGeneral C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
    (conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfHalfExchange h D.M)
      (kroneckerPowerOfExchange D.M) F)

/-- 本文 `claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix` の必要十分版。 -/
theorem conjugatedHomomorphismToMatrix_first (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : (1 + 1) * h = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e m))
      = jordanWignerZ D.M m := calc
  D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e m))
      = conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M)
          (kroneckerPowerOfHalfExchange h D.M)
          (D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e m))) := rfl
  _ = conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M)
          (kroneckerPowerOfHalfExchange h D.M) (Mat.add (creationMatrix n D.M m hm) (annihilationMatrix n D.M m hm)) := by
        rw [D.homomorphismToMatrixOfGeneral_first C hneg hneg_mul hneg_neg i hi QY hQf e he m hm]; rfl
  _ = jordanWignerZ D.M m :=
        conjugation_creation_add_annihilation C.valuedMaps C.mul_comm C.uniqueness.mul_zero hneg hneg_mul hneg_neg h hh
          n (neg_one_eq_n C hneg) D.M m hm

/-- 本文 `claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix` の必要十分版。 -/
theorem conjugatedHomomorphismToMatrix_second (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : (1 + 1) * h = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e (D.M + m)))
      = jordanWignerY i D.M m := calc
  D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e (D.M + m)))
      = conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M)
          (kroneckerPowerOfHalfExchange h D.M)
          (D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he (QY.γ C (e (D.M + m)))) := rfl
  _ = conjugation C.valuedMaps (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M)
          (kroneckerPowerOfHalfExchange h D.M)
          (Mat.add (Mat.smul (-i) (creationMatrix n D.M m hm)) (Mat.smul i (annihilationMatrix n D.M m hm))) := by
        rw [D.homomorphismToMatrixOfGeneral_second C hneg hneg_mul hneg_neg i hi QY hQf e he m hm]; rfl
  _ = jordanWignerY i D.M m :=
        conjugation_imaginary_combination C.valuedMaps C.mul_comm C.uniqueness.mul_zero hneg hneg_mul hneg_neg h hh
          n (neg_one_eq_n C hneg) i D.M m hm

/-! ### 系の定理 -/

/-- 系の定理の本体の必要十分版：e が三つの条件を満たす任意の族のとき、Ω と Ω' は互いに逆な K-代数の準同型である。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_family (hneg : ∀ a : K, a + -a = 0)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    let Ω := D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he
    let Ω' := D.conjugatedHomomorphismFromMatrix C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) Ω ∧
      IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) Ω' ∧
      (∀ a : QY.Cl C, Ω' (Ω a) = a) ∧
      (∀ F : Mat K (PowerSet D.M), Ω (Ω' F) = F) ∧
      Function.Bijective Ω ∧
      (∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), Ω a = F → a = Ω' F) := by
  intro Ω Ω'
  let L := C.valuedMaps
  let hX := isFiniteSet_powerSet D.M
  let U : Mat K (PowerSet D.M) := kroneckerPowerOfExchange D.M
  let U' := kroneckerPowerOfHalfExchange h D.M
  let ΦY := D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he
  let ΨY := D.homomorphismFromMatrixOfGeneral C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
  obtain ⟨hΦY, hΨY, hΨΦ, hΦΨ, -, -⟩ :=
    D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
  have hUU' : Mat.mul L hX U U' = Mat.one :=
    kroneckerPowerOfExchange_mul_half L C.mul_comm C.uniqueness.mul_zero hneg hneg_mul hneg_neg h hh.two_mul D.M
  have hU'U : Mat.mul L hX U' U = Mat.one :=
    kroneckerPowerOfHalfExchange_mul L C.mul_comm C.uniqueness.mul_zero hneg hneg_mul hneg_neg h hh.two_mul D.M
  have hκ : IsAlgebraHomomorphism (D.matrixAlgebra C) (D.matrixAlgebra C) (conjugation L hX U U') :=
    conjugation_isAlgebraHomomorphism L C.mul_comm C.uniqueness.mul_zero hX U U' hUU' hU'U
  have hκ' : IsAlgebraHomomorphism (D.matrixAlgebra C) (D.matrixAlgebra C) (conjugation L hX U' U) :=
    conjugation_isAlgebraHomomorphism L C.mul_comm C.uniqueness.mul_zero hX U' U hU'U hUU'
  have hΩ : IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) Ω :=
    IsAlgebraHomomorphism.comp (φ := ΦY) (ψ := conjugation L hX U U') hΦY hκ
  have hΩ' : IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) Ω' :=
    IsAlgebraHomomorphism.comp (φ := conjugation L hX U' U) (ψ := ΨY) hκ' hΨY
  have h1 : ∀ G : Mat K (PowerSet D.M), conjugation L hX U' U (conjugation L hX U U' G) = G :=
    conjugation_conjugation L C.mul_comm C.uniqueness.mul_zero hX U U' hU'U
  have h2 : ∀ G : Mat K (PowerSet D.M), conjugation L hX U U' (conjugation L hX U' U G) = G :=
    conjugation_conjugation L C.mul_comm C.uniqueness.mul_zero hX U' U hUU'
  have hΩ'Ω : ∀ a : QY.Cl C, Ω' (Ω a) = a := fun a => calc
    Ω' (Ω a) = ΨY (conjugation L hX U' U (conjugation L hX U U' (ΦY a))) := rfl
    _ = ΨY (ΦY a) := by rw [show conjugation L hX U' U (conjugation L hX U U' (ΦY a)) = ΦY a from h1 (ΦY a)]
    _ = a := hΨΦ a
  have hΩΩ' : ∀ F : Mat K (PowerSet D.M), Ω (Ω' F) = F := fun F => calc
    Ω (Ω' F) = conjugation L hX U U' (ΦY (ΨY (conjugation L hX U' U F))) := rfl
    _ = conjugation L hX U U' (conjugation L hX U' U F) := by
        rw [show ΦY (ΨY (conjugation L hX U' U F)) = conjugation L hX U' U F from hΦΨ (conjugation L hX U' U F)]
    _ = F := h2 F
  have hinj : Function.Injective Ω := by
    intro a a' haa'
    calc a = Ω' (Ω a) := (hΩ'Ω a).symm
      _ = Ω' (Ω a') := by rw [haa']
      _ = a' := hΩ'Ω a'
  have hsurj : Function.Surjective Ω := fun F => ⟨Ω' F, hΩΩ' F⟩
  have hinv : ∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), Ω a = F → a = Ω' F := by
    intro F a ha
    apply hinj
    calc Ω a = F := ha
      _ = Ω (Ω' F) := (hΩΩ' F).symm
  exact ⟨hΩ, hΩ', hΩ'Ω, hΩΩ', ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms`
の必要十分版：e := `orthonormalBasis` のとき（系「一般の偶数次元」の必要十分版と同じく、e を固定する仮定の組 `E` と Q の非退化性を足す）。 -/
theorem conjugatedHomomorphisms_mutually_inverse [Inv K] (E : OrthonormalBasisExistenceLaws K)
    (hneg : ∀ a : K, a + -a = 0) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis E QY hdim hQ
    let he := D.orthonormalBasis_spec E QY hdim hQ
    let Ω := D.conjugatedHomomorphismToMatrix C hneg E.neg_mul hneg_neg i hi h QY hQ.isQuadraticForm e he
    let Ω' := D.conjugatedHomomorphismFromMatrix C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) Ω ∧
      IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) Ω' ∧
      (∀ a : QY.Cl C, Ω' (Ω a) = a) ∧
      (∀ F : Mat K (PowerSet D.M), Ω (Ω' F) = F) ∧
      Function.Bijective Ω ∧
      (∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), Ω a = F → a = Ω' F) :=
  D.conjugatedHomomorphisms_mutually_inverse_of_family C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm
    _ (D.orthonormalBasis_spec E QY hdim hQ)

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
