/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、Ω̂ が直交基底の元の像を送る先と系の定理の具体版が、
必要十分版の K := ℂ、n := -1_ℂ、i := imaginaryUnit、h := inverseOfTwo への特殊化から得られることを示す導出版。

  具体版                                                         導出版
  numberedHomomorphismToMatrix（Ω̂）                              numberedHomomorphismToMatrix_eq_necSuf（Ω̂ = Ω̂_N ∘ T_Y）
  numberedHomomorphismFromMatrix（Ω̂'）                           toCl_numberedHomomorphismFromMatrix（T_Y ∘ Ω̂' = Ω̂'_N）
  numberedHomomorphismToMatrix_first・…_second                   …_of_necSuf
  numberedHomomorphisms_mutually_inverse_of_family               …_of_necSuf（必要十分版の本体を特殊化し、T_Y・S_Y で引き戻す）
  numberedHomomorphisms_mutually_inverse                         …_of_necSuf（本体の導出版を固定した e に当てる）

運び方: 前半の導出版（`ConjugatedIsomorphismFromNecSuf.lean` の冒頭）と同じく、具体版の Cl(Y,Q) と必要十分版の Cl(Y,Q) の間の
互いに逆な準同型 T_Y・S_Y（`QuadraticSpaceWithBasis.transportToNecSuf`）を置く。ν_{r_M}・μ_{r_M} は必要十分版のものと同じ式
（`firstSiteHighestReindexMatrix_eq_necSuf`・`firstSiteHighestInverseReindexMatrix_eq_necSuf`）なので、Ω = Ω_N ∘ T_Y・
T_Y ∘ Ω' = Ω'_N から Ω̂ = Ω̂_N ∘ T_Y・T_Y ∘ Ω̂' = Ω̂'_N が出る。Z^{(2^M)}_m・Y^{(2^M)}_m と番号の行列環 B̂ は必要十分版のものと同じ
（`numberedJordanWignerZ_eq_necSuf`・`numberedJordanWignerY_eq_necSuf`・`matricesComplexAlgebra_toNecSuf`）。
ℂ から渡す性質は前半の導出版と同じである。
-/
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IsomorphismIndexedByNumbers
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.IndexedByNumbersFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphismFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.MatrixReindexing.MatrixReindexingFromNecSuf
import CliffordMatrixIsomorphism.ComplexMatrixAlgebra.FirstSiteHighestDigitNumbering.FirstSiteHighestDigitNumberingFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.IsomorphismIndexedByNumbers

-- 添字の再帰的な定義（2^M・個数 N_i(T)・整数の番号順の和など）は具体版と必要十分版に同じ式で別に置いてあり、
-- 変数での値は再帰の展開でしか一致しないので、このファイルでは smartUnfolding を切って定義どおりに展開させる。
set_option smartUnfolding false

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### 必要十分版の Ω̂・Ω̂' と、具体版の Ω̂・Ω̂' との関係 -/

/-- 必要十分版の Ω̂（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev numberedHomomorphismToMatrixN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    QY.toNecSuf.Cl complexCliffordLaws → Mat (Idx (twoPower D.M)) :=
  D.toNecSuf.numberedHomomorphismToMatrix complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo QY.toNecSuf ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm)
    e he.toNecSuf

/-- 必要十分版の Ω̂'（`D.toNecSuf` と `QY.toNecSuf` に ℂ の性質を渡したもの）。 -/
abbrev numberedHomomorphismFromMatrixN (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    Mat (Idx (twoPower D.M)) → QY.toNecSuf.Cl complexCliffordLaws :=
  D.toNecSuf.numberedHomomorphismFromMatrix complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf

/-- 本文 `def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers`：具体版の Ω̂ は、必要十分版の Ω̂ に
T_Y を先に当てたものである。 -/
theorem numberedHomomorphismToMatrix_eq_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) :
    D.numberedHomomorphismToMatrix QY e he a
      = D.numberedHomomorphismToMatrixN QY e he ((QuadraticSpaceWithBasis.transportToNecSuf QY).toCl a) := by
  show firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix QY e he a) = _
  rw [D.conjugatedHomomorphismToMatrix_eq_necSuf QY e he a, firstSiteHighestReindexMatrix_eq_necSuf]
  rfl

/-- 本文 `def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers`：具体版の Ω̂' を T_Y で写したものは、
必要十分版の Ω̂' である。 -/
theorem toCl_numberedHomomorphismFromMatrix (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (G : Mat (Idx (twoPower D.M))) :
    (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl (D.numberedHomomorphismFromMatrix QY e he G)
      = D.numberedHomomorphismFromMatrixN QY e he G := by
  show (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl
      (D.conjugatedHomomorphismFromMatrix QY e he (firstSiteHighestInverseReindexMatrix D.M G)) = _
  rw [D.toCl_conjugatedHomomorphismFromMatrix QY e he, firstSiteHighestInverseReindexMatrix_eq_necSuf]
  rfl

/-! ### Ω̂ が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix` を、
必要十分版の主張を Ω̂ = Ω̂_N ∘ T_Y で引き戻して得たもの。 -/
theorem numberedHomomorphismToMatrix_first_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e m)) = numberedJordanWignerZ D.M m := by
  rw [D.numberedHomomorphismToMatrix_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    numberedJordanWignerZ_eq_necSuf]
  exact D.toNecSuf.numberedHomomorphismToMatrix_first complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo mul_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf m hm

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix` を、
必要十分版の主張を Ω̂ = Ω̂_N ∘ T_Y で引き戻して得たもの。 -/
theorem numberedHomomorphismToMatrix_second_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix QY e he (QY.γ (e (D.M + m))) = numberedJordanWignerY D.M m := by
  rw [D.numberedHomomorphismToMatrix_eq_necSuf QY e he, (QuadraticSpaceWithBasis.transportToNecSuf QY).toCl_γ,
    numberedJordanWignerY_eq_necSuf]
  exact D.toNecSuf.numberedHomomorphismToMatrix_second complexCliffordLaws add_neg_cancel neg_mul neg_neg imaginaryUnit
    imaginaryUnit_mul_self inverseOfTwo mul_inverseOfTwo QY.toNecSuf
    ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf m hm

/-! ### 系の定理 -/

/-- 系の定理の本体（`numberedHomomorphisms_mutually_inverse_of_family`）を、必要十分版の系の定理の本体を
`D.toNecSuf`・`QY.toNecSuf` と ℂ の性質に特殊化し、互いに逆な準同型 T_Y・S_Y で引き戻して得たもの。
具体版の Ω̂ は Ω̂_N ∘ T_Y、Ω̂' は S_Y ∘ Ω̂'_N に等しい。 -/
theorem numberedHomomorphisms_mutually_inverse_of_family_of_necSuf (QY : QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M)
        (D.numberedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra
        (D.numberedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.numberedHomomorphismFromMatrix QY e he (D.numberedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ G : Mat (Idx (twoPower D.M)),
        D.numberedHomomorphismToMatrix QY e he (D.numberedHomomorphismFromMatrix QY e he G) = G) ∧
      Function.Bijective (D.numberedHomomorphismToMatrix QY e he) ∧
      (∀ (G : Mat (Idx (twoPower D.M))) (a : QY.Cl),
        D.numberedHomomorphismToMatrix QY e he a = G → a = D.numberedHomomorphismFromMatrix QY e he G) := by
  let P := QuadraticSpaceWithBasis.transportToNecSuf QY
  let Ω₁N := D.numberedHomomorphismToMatrixN QY e he
  let Ω₁'N := D.numberedHomomorphismFromMatrixN QY e he
  obtain ⟨hΩ₁N, hΩ₁'N, hΩ₁'Ω₁N, hΩ₁Ω₁'N, hbijN, hinvN⟩ :=
    D.toNecSuf.numberedHomomorphisms_mutually_inverse_of_family complexCliffordLaws add_neg_cancel neg_mul neg_neg
      imaginaryUnit imaginaryUnit_mul_self inverseOfTwo isInverseOfTwo_inverseOfTwo QY.toNecSuf
      ((isQuadraticForm_iff_necSuf QY.space QY.form).1 QY.isQuadraticForm) e he.toNecSuf
  have hΩ₁ : IsComplexAlgebraHomomorphism (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf) (numberedMatrixAlgebra D.M)
      Ω₁N :=
    (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 (by rw [numberedMatrixAlgebra, matricesComplexAlgebra_toNecSuf]; exact hΩ₁N)
  have hΩ₁' : IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) (QuadraticSpaceWithBasis.algebraOfNecSuf QY.toNecSuf)
      Ω₁'N :=
    (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2 (by rw [numberedMatrixAlgebra, matricesComplexAlgebra_toNecSuf]; exact hΩ₁'N)
  have hΩ₁eq : D.numberedHomomorphismToMatrix QY e he = fun a => Ω₁N (P.toCl a) :=
    funext (D.numberedHomomorphismToMatrix_eq_necSuf QY e he)
  have hΩ₁'eq : D.numberedHomomorphismFromMatrix QY e he = fun G => P.ofCl (Ω₁'N G) := funext fun G =>
    (P.ofCl_toCl _).symm.trans (congrArg P.ofCl (D.toCl_numberedHomomorphismFromMatrix QY e he G))
  rw [hΩ₁eq, hΩ₁'eq]
  refine ⟨IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom hΩ₁,
    IsComplexAlgebraHomomorphism.comp_of_necSuf hΩ₁' P.ofCl_isHom,
    fun a => ?_, fun G => ?_, ?_, fun G a ha => ?_⟩
  · exact (congrArg P.ofCl (hΩ₁'Ω₁N (P.toCl a))).trans (P.ofCl_toCl a)
  · exact (congrArg Ω₁N (P.toCl_ofCl (Ω₁'N G))).trans (hΩ₁Ω₁'N G)
  · exact hbijN.comp P.toCl_bijective
  · exact (P.ofCl_toCl a).symm.trans (congrArg P.ofCl (hinvN G (P.toCl a) ha))

/-- 本文 `theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms`
を得たもの（e := `orthonormalBasis`）。必要十分版の系の定理と同じ手順で、上の本体の導出版を具体版の e に当てる。 -/
theorem numberedHomomorphisms_mutually_inverse_of_necSuf (QY : QuadraticSpaceWithBasis Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis QY hdim hQ
    let he := D.orthonormalBasis_spec QY hdim hQ
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra (numberedMatrixAlgebra D.M)
        (D.numberedHomomorphismToMatrix QY e he) ∧
      IsComplexAlgebraHomomorphism (numberedMatrixAlgebra D.M) QY.cliffordAlgebra
        (D.numberedHomomorphismFromMatrix QY e he) ∧
      (∀ a : QY.Cl, D.numberedHomomorphismFromMatrix QY e he (D.numberedHomomorphismToMatrix QY e he a) = a) ∧
      (∀ G : Mat (Idx (twoPower D.M)),
        D.numberedHomomorphismToMatrix QY e he (D.numberedHomomorphismFromMatrix QY e he G) = G) ∧
      Function.Bijective (D.numberedHomomorphismToMatrix QY e he) ∧
      (∀ (G : Mat (Idx (twoPower D.M))) (a : QY.Cl),
        D.numberedHomomorphismToMatrix QY e he a = G → a = D.numberedHomomorphismFromMatrix QY e he G) :=
  D.numberedHomomorphisms_mutually_inverse_of_family_of_necSuf QY _ (D.orthonormalBasis_spec_of_necSuf QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
