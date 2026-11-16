/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」のうち、Φ_Y が値が 1 の直交基底の元の像を送る先、
Ω・Ω' が直交基底の元の像を送る先、系の定理の具体版が、必要十分版の K := ℂ、n := -1_ℂ、i := imaginaryUnit、h := inverseOfTwo への
特殊化から得られることを示す導出版。

  具体版                                                         導出版
  conjugatedHomomorphismToMatrix（Ω）                            conjugatedHomomorphismToMatrix_eq_necSuf（Ω = Ω_N ∘ T_Y）
  conjugatedHomomorphismFromMatrix（Ω'）                         toCl_conjugatedHomomorphismFromMatrix（T_Y ∘ Ω' = Ω'_N）
  homomorphismToMatrixOfGeneral_first・…_second                  …_of_necSuf
  conjugatedHomomorphismToMatrix_first・…_second                 …_of_necSuf
  conjugatedHomomorphisms_mutually_inverse_of_family             …_of_necSuf（必要十分版の本体を特殊化し、T_Y・S_Y で引き戻す）
  conjugatedHomomorphisms_mutually_inverse                       …_of_necSuf（本体の導出版を固定した e に当てる）

運び方: 系「一般の偶数次元」の導出版（`IsometryToSplitSpaceFromNecSuf.lean` の冒頭）と同じく、具体版の Cl(Y,Q) と、具体版の前提を
写した必要十分版の前提 `D.toNecSuf`・`QY.toNecSuf` の Cl(Y,Q) は別の集合なので、二つの間の互いに逆な準同型
T_Y・S_Y（`QuadraticSpaceWithBasis.transportToNecSuf`。点は動かさない）を置く。具体版の Φ_Y は Φ_{Y,N} ∘ T_Y、Ψ_Y は S_Y ∘ Ψ_{Y,N}
に等しい（`homomorphismToMatrixOfGeneral_eq_necSuf`・`toCl_homomorphismFromMatrixOfGeneral`）。U・U'・κ・c_m・c_m^T・Z_m・Y_m は
必要十分版のものと同じ行列である（`JordanWignerConjugationFromNecSuf.lean`）。したがって Ω = Ω_N ∘ T_Y、Ω' = S_Y ∘ Ω'_N となり、
γ_Y(e_m) を送る先の主張は、T_Y(γ_Y(e_m)) = γ_{Y,N}(e_m) に必要十分版の主張を当てて得る。系の定理の本体は、必要十分版の本体の
六つの部分をこの二つの等式で具体版へ移す。系の定理は、必要十分版の系の定理と同じく、本体を固定した e に当てる
（二つの e は別々に `Classical.choose` で選ぶので、必要十分版の系の定理そのものは具体版の e について述べない）。
ℂ から渡す性質は、系「一般の偶数次元」の導出版と同じ組（`complexCliffordLaws`・`add_neg_cancel`・`neg_mul`・`neg_neg`・
`imaginaryUnit_mul_self`・`isInverseOfTwo_inverseOfTwo`）と、(1 + 1) · h = 1 の `mul_inverseOfTwo` である。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphism
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.JordanWignerConjugationFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.IsometryToSplitSpaceFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphism

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### 必要十分版の Ω・Ω' と、具体版の Ω・Ω' との関係 -/

/-- 必要十分版の Ω（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev conjugatedHomomorphismToMatrixN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    QY.toNecSuf.Cl complexCliffordLaws → Mat (PowerSet D.M) :=
  D.toNecSuf.conjugatedHomomorphismToMatrix complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm)
    e he.toNecSuf

/-- 必要十分版の Ω'（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev conjugatedHomomorphismFromMatrixN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    Mat (PowerSet D.M) → QY.toNecSuf.Cl complexCliffordLaws :=
  D.toNecSuf.conjugatedHomomorphismFromMatrix complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf

/-- 本文 `def_homomorphism_from_general_clifford_algebra_conjugated_by_kronecker_power`：具体版の Ω は、必要十分版の Ω に
T_Y を先に当てたものである（Φ_Y = Φ_{Y,N} ∘ T_Y と、U・U'・κ が必要十分版のものと同じ行列であることによる）。 -/
theorem conjugatedHomomorphismToMatrix_eq_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) :
    D.conjugatedHomomorphismToMatrix QY e he a
      = D.conjugatedHomomorphismToMatrixN QY e he ((QuadraticSpaceWithBasis.transportToNecSuf QY).toCl a) := by
  show conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfExchange D.M) (kroneckerPowerOfHalfExchange D.M)
      (D.homomorphismToMatrixOfGeneral QY e he a) = _
  rw [D.homomorphismToMatrixOfGeneral_eq_necSuf QY e he a, conjugation_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf,
    kroneckerPowerOfHalfExchange_eq_necSuf]
  rfl

/-- 本文 `def_homomorphism_to_general_clifford_algebra_conjugated_by_kronecker_power`：具体版の Ω' を T_Y で写したものは、
必要十分版の Ω' である（T_Y ∘ Ψ_Y = Ψ_{Y,N} と、U・U'・κ が必要十分版のものと同じ行列であることによる）。 -/
theorem toCl_conjugatedHomomorphismFromMatrix (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat (PowerSet D.M)) :
    (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl (D.conjugatedHomomorphismFromMatrix QY e he F)
      = D.conjugatedHomomorphismFromMatrixN QY e he F := by
  show (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl (D.homomorphismFromMatrixOfGeneral QY e he
      (conjugation (isFiniteSet_powerSet D.M) (kroneckerPowerOfHalfExchange D.M) (kroneckerPowerOfExchange D.M) F)) = _
  rw [D.toCl_homomorphismFromMatrixOfGeneral QY e he, conjugation_eq_necSuf, kroneckerPowerOfExchange_eq_necSuf,
    kroneckerPowerOfHalfExchange_eq_necSuf]
  rfl

/-! ### Φ_Y が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_from_general_space_on_first_half_of_orthonormal_basis` を、必要十分版の主張を
T_Y(γ_Y(e_m)) = γ_{Y,N}(e_m) に当てて得たもの。 -/
theorem homomorphismToMatrixOfGeneral_first_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e m))
      = D.matrixAlgebra.add (creationMatrix D.M m hm) (annihilationMatrix D.M m hm) := by
  rw [D.homomorphismToMatrixOfGeneral_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact D.toNecSuf.homomorphismToMatrixOfGeneral_first complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e
    he.toNecSuf m hm

/-- 本文 `claim_homomorphism_from_general_space_on_second_half_of_orthonormal_basis` を、必要十分版の主張を
T_Y(γ_Y(e_{M+m})) = γ_{Y,N}(e_{M+m}) に当てて得たもの。 -/
theorem homomorphismToMatrixOfGeneral_second_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.homomorphismToMatrixOfGeneral QY e he (QY.γ (e (D.M + m)))
      = D.matrixAlgebra.add (D.matrixAlgebra.smul (-imaginaryUnit) (creationMatrix D.M m hm))
          (D.matrixAlgebra.smul imaginaryUnit (annihilationMatrix D.M m hm)) := by
  rw [D.homomorphismToMatrixOfGeneral_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    creationMatrix_eq_necSuf, annihilationMatrix_eq_necSuf]
  exact D.toNecSuf.homomorphismToMatrixOfGeneral_second complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e
    he.toNecSuf m hm

/-! ### U と U' で挟んだ写像 Ω・Ω' -/

/-- 本文 `claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix` を、必要十分版の主張を
Ω = Ω_N ∘ T_Y で引き戻して得たもの。 -/
theorem conjugatedHomomorphismToMatrix_first_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e m)) = jordanWignerZ D.M m := by
  rw [D.conjugatedHomomorphismToMatrix_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    jordanWignerZ_eq_necSuf]
  exact D.toNecSuf.conjugatedHomomorphismToMatrix_first complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo mul_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf m hm

/-- 本文 `claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix` を、必要十分版の主張を
Ω = Ω_N ∘ T_Y で引き戻して得たもの。 -/
theorem conjugatedHomomorphismToMatrix_second_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.conjugatedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = jordanWignerY D.M m := by
  rw [D.conjugatedHomomorphismToMatrix_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    jordanWignerY_eq_necSuf]
  exact D.toNecSuf.conjugatedHomomorphismToMatrix_second complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo mul_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf m hm

/-! ### 系の定理 -/

/-- 系の定理の本体（`conjugatedHomomorphisms_mutually_inverse_of_family`）を、必要十分版の系の定理の本体を
`D.toNecSuf`・`QY.toNecSuf` と ℂ の性質に特殊化し、互いに逆な準同型 T_Y : Cl(Y,Q) → Cl_N(Y,Q)・S_Y で引き戻して得たもの。
具体版の Ω は Ω_N ∘ T_Y、Ω' は S_Y ∘ Ω'_N に等しい。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_family_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.conjugatedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.conjugatedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.conjugatedHomomorphismFromMatrix QY e he (D.conjugatedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.conjugatedHomomorphismToMatrix QY e he (D.conjugatedHomomorphismFromMatrix QY e he F) = F) ∧
      Function.Bijective (D.conjugatedHomomorphismToMatrix QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.conjugatedHomomorphismToMatrix QY e he a = F → a = D.conjugatedHomomorphismFromMatrix QY e he F) := by
  let P := QuadraticSpaceWithBasis.transportToNecSuf QY
  let ΩN := D.conjugatedHomomorphismToMatrixN QY e he
  let Ω'N := D.conjugatedHomomorphismFromMatrixN QY e he
  obtain ⟨hΩN, hΩ'N, hΩ'ΩN, hΩΩ'N, hbijN, hinvN⟩ :=
    D.toNecSuf.conjugatedHomomorphisms_mutually_inverse_of_family complexCliffordLaws add_neg_cancel neg_mul neg_neg
      imaginaryUnit imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
      ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf
  have hΩ : IsComplexAlgebraHomomorphism (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf) D.matrixAlgebra ΩN :=
    (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 (by rw [D.matrixAlgebra_toNecSuf]; exact hΩN)
  have hΩ' : IsComplexAlgebraHomomorphism D.matrixAlgebra (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf) Ω'N :=
    (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 (by rw [D.matrixAlgebra_toNecSuf]; exact hΩ'N)
  have hΩeq : D.conjugatedHomomorphismToMatrix QY e he = fun a => ΩN (P.toCl a) :=
    funext (D.conjugatedHomomorphismToMatrix_eq_necSuf QY e he)
  have hΩ'eq : D.conjugatedHomomorphismFromMatrix QY e he = fun F => P.ofCl (Ω'N F) := funext fun F =>
    (P.ofCl_toCl _).symm.trans (congrArg P.ofCl (D.toCl_conjugatedHomomorphismFromMatrix QY e he F))
  rw [hΩeq, hΩ'eq]
  refine ⟨IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom hΩ,
    IsComplexAlgebraHomomorphism.comp_of_necSuf hΩ' P.ofCl_isHom,
    fun a => ?_, fun F => ?_, ?_, fun F a ha => ?_⟩
  · exact (congrArg P.ofCl (hΩ'ΩN (P.toCl a))).trans (P.ofCl_toCl a)
  · exact (congrArg ΩN (P.toCl_ofCl (Ω'N F))).trans (hΩΩ'N F)
  · exact hbijN.comp P.toCl_bijective
  · exact (P.ofCl_toCl a).symm.trans (congrArg P.ofCl (hinvN F (P.toCl a) ha))

/-- 本文 `theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms`
を得たもの（e := `orthonormalBasis`）。必要十分版の系の定理が、必要十分版の本体を e := 必要十分版の `orthonormalBasis` に当てるのと
同じ手順で、上の本体の導出版を具体版の e に当てる。 -/
theorem conjugatedHomomorphisms_mutually_inverse_of_necSuf (QY : QuadraticSpaceWithBasis Y)
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
