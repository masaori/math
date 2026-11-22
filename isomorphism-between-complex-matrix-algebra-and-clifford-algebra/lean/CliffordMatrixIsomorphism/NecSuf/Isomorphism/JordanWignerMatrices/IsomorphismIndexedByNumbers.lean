/-
節「系：複素行列版イジングの Jordan–Wigner 行列への接続」の後半のうち、Ω̂ := ν_{r_M} ∘ Ω・Ω̂' := Ω' ∘ μ_{r_M} と、
Ω̂ が値が 1 の直交基底の元の像を送る先と、系の定理の必要十分版。具体版
`Isomorphism/JordanWignerMatrices/IsomorphismIndexedByNumbers.lean` と同じ def と calc の行のまま、係数 ℂ を型の変数 K に、
-1_ℂ・i・h を K の元 n・i・h に替えて書く（前提の組は前半の必要十分版 `NecSuf/Isomorphism/JordanWignerMatrices/ConjugatedIsomorphism.lean` と同じ）。

主張ごとに使う K の性質（どの主張も、Cl(V,q) を作るために章「クリフォード代数」の仮定 `CliffordLaws K n` を持ち、Ω を作るために
前半の必要十分版の仮定 a + (-a) = 0、(-a) · b = -(a · b)、-(-a) = a、i · i = -1、Q が二次形式であること、e の三つの条件、h を持つ）:

  本文のラベル                                                                       このファイル                          足す性質
  def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers      numberedHomomorphismToMatrix（Ω̂）    なし
  def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers      numberedHomomorphismFromMatrix（Ω̂'） h が 1 + 1 の両側の逆元
                                                                                                                          （Ω' を作るため）
  claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
                                                                                     numberedHomomorphismToMatrix_first    (1 + 1) · h = 1
  claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
                                                                                     numberedHomomorphismToMatrix_second   (1 + 1) · h = 1
  theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms
                                                                                     numberedHomomorphisms_mutually_inverse_of_family・
                                                                                     numberedHomomorphisms_mutually_inverse
                                                                                                                          h · (1 + 1) = 1 と (1 + 1) · h = 1
                                                                                                                          （後者は e を固定する仮定の組 E も）

B̂ := Mat_{1,…,2^M}(K) は `numberedMatrixAlgebra C.valuedMaps C.mul_comm C.uniqueness.mul_zero D.M`（K-代数にする三つの性質は
`CliffordLaws K n` の欄から渡す）。

分かったこと:
- ν_{r_M}・μ_{r_M} を合成する段は、K の性質を足さない。ν_{r_M}・μ_{r_M} が K-代数の準同型であることに要る乗法の交換法則と a · 0 = 0 は、
  B と B̂ を K-代数にするためのもので、`CliffordLaws K n` の欄にある。ν_{r_M} と μ_{r_M} が互いの逆であることは、K の性質を使わない。
- したがって、番号の行列環へ移した系の定理が要する K の性質は、前半の系の定理（Ω・Ω'）が要するものと同じである。
- 本文の前提 M ≥ 1 は、どの主張も使わない。Ω̂ の二つの主張が m ∈ {1,…,M} を要するのは、前半の Ω の主張（c_m を作る）からである。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.ConjugatedIsomorphism
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.JordanWignerMatrices.IndexedByNumbers

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.Isomorphism
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet isFiniteSet_powerSet twoPower
  firstSiteHighestNumbering_isNumbering)

universe u v uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W) {Y : Type v}

/-! ### Ω̂・Ω̂' -/

/-- 本文 `def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers` の必要十分版：Ω̂ := ν_{r_M} ∘ Ω。 -/
def numberedHomomorphismToMatrix (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl C) : Mat K (Idx (twoPower D.M)) :=
  firstSiteHighestReindexMatrix D.M (D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he a)

/-- 本文 `def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers` の必要十分版：Ω̂' := Ω' ∘ μ_{r_M}。 -/
def numberedHomomorphismFromMatrix (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : IsInverseOfTwo h)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (G : Mat K (Idx (twoPower D.M))) : QY.Cl C :=
  D.conjugatedHomomorphismFromMatrix C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
    (firstSiteHighestInverseReindexMatrix D.M G)

/-! ### Ω̂ が直交基底の元の像を送る先 -/

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix`
の必要十分版：Ω̂(γ_Y(e_m)) = Z^{(2^M)}_m。 -/
theorem numberedHomomorphismToMatrix_first (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : (1 + 1) * h = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e m))
      = numberedJordanWignerZ C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m := calc
  D.numberedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e m))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M
          (D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e m))) := rfl
  -- claim_conjugated_homomorphism_sends_first_half_of_orthonormal_basis_to_jordan_wigner_z_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerZ D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_first C hneg hneg_mul hneg_neg i hi h hh QY hQf e he m hm]
  -- claim_reindexing_of_jordan_wigner_z_matrix_is_jordan_wigner_z_matrix_indexed_by_numbers
  _ = numberedJordanWignerZ C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m :=
      firstSiteHighestReindexMatrix_jordanWignerZ C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m

/-- 本文 `claim_homomorphism_to_matrices_indexed_by_numbers_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix`
の必要十分版：Ω̂(γ_Y(e_{M+m})) = Y^{(2^M)}_m。 -/
theorem numberedHomomorphismToMatrix_second (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : (1 + 1) * h = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (m : ℕ) (hm : 1 ≤ m ∧ m ≤ D.M) :
    D.numberedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e (D.M + m)))
      = numberedJordanWignerY C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m := calc
  D.numberedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e (D.M + m)))
      -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
      = firstSiteHighestReindexMatrix D.M
          (D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he (QY.γ C (e (D.M + m)))) := rfl
  -- claim_conjugated_homomorphism_sends_second_half_of_orthonormal_basis_to_jordan_wigner_y_matrix
  _ = firstSiteHighestReindexMatrix D.M (jordanWignerY i D.M m) := by
      rw [D.conjugatedHomomorphismToMatrix_second C hneg hneg_mul hneg_neg i hi h hh QY hQf e he m hm]
  -- claim_reindexing_of_jordan_wigner_y_matrix_is_jordan_wigner_y_matrix_indexed_by_numbers
  _ = numberedJordanWignerY C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m :=
      firstSiteHighestReindexMatrix_jordanWignerY C.valuedMaps C.mul_comm C.uniqueness.mul_zero i D.M m

/-! ### 系の定理 -/

/-- 系の定理の本体の必要十分版：e が三つの条件を満たす任意の族のとき、Ω̂ と Ω̂' は互いに逆な K-代数の準同型である。 -/
theorem numberedHomomorphisms_mutually_inverse_of_family (hneg : ∀ a : K, a + -a = 0)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    let B' := numberedMatrixAlgebra C.valuedMaps C.mul_comm C.uniqueness.mul_zero D.M
    let Ω₁ := D.numberedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he
    let Ω₁' := D.numberedHomomorphismFromMatrix C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) B' Ω₁ ∧
      IsAlgebraHomomorphism B' (QY.cliffordAlgebra C) Ω₁' ∧
      (∀ a : QY.Cl C, Ω₁' (Ω₁ a) = a) ∧
      (∀ G : Mat K (Idx (twoPower D.M)), Ω₁ (Ω₁' G) = G) ∧
      Function.Bijective Ω₁ ∧
      (∀ (G : Mat K (Idx (twoPower D.M))) (a : QY.Cl C), Ω₁ a = G → a = Ω₁' G) := by
  intro B' Ω₁ Ω₁'
  let L := C.valuedMaps
  let ν : Mat K (PowerSet D.M) → Mat K (Idx (twoPower D.M)) := firstSiteHighestReindexMatrix D.M
  let μ : Mat K (Idx (twoPower D.M)) → Mat K (PowerSet D.M) := firstSiteHighestInverseReindexMatrix D.M
  let Ω := D.conjugatedHomomorphismToMatrix C hneg hneg_mul hneg_neg i hi h QY hQf e he
  let Ω' := D.conjugatedHomomorphismFromMatrix C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
  -- Ω と Ω' は K-代数の準同型で、互いに逆である
  -- （theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms）
  obtain ⟨hΩ, hΩ', hΩ'Ω, hΩΩ', -, -⟩ :=
    D.conjugatedHomomorphisms_mutually_inverse_of_family C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
  -- ν_{r_M} と μ_{r_M} は K-代数の準同型（claim_reindexing_of_matrices_by_numbering_is_algebra_homomorphism、
  -- claim_reindexing_of_matrices_by_inverse_numbering_is_algebra_homomorphism）
  have hν : IsAlgebraHomomorphism (D.matrixAlgebra C) B' ν :=
    reindexMatrix_isAlgebraHomomorphism L C.mul_comm C.uniqueness.mul_zero (isFiniteSet_powerSet D.M)
      (firstSiteHighestNumbering_isNumbering D.M)
  have hμ : IsAlgebraHomomorphism B' (D.matrixAlgebra C) μ :=
    inverseReindexMatrix_isAlgebraHomomorphism L C.mul_comm C.uniqueness.mul_zero (isFiniteSet_powerSet D.M)
      (firstSiteHighestNumbering_isNumbering D.M)
  -- 合成 Ω̂ と Ω̂' は K-代数の準同型（claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism）
  have hΩ₁ : IsAlgebraHomomorphism (QY.cliffordAlgebra C) B' Ω₁ :=
    IsAlgebraHomomorphism.comp (φ := Ω) (ψ := ν) hΩ hν
  have hΩ₁' : IsAlgebraHomomorphism B' (QY.cliffordAlgebra C) Ω₁' :=
    IsAlgebraHomomorphism.comp (φ := μ) (ψ := Ω') hμ hΩ'
  have hΩ₁'Ω₁ : ∀ a : QY.Cl C, Ω₁' (Ω₁ a) = a := fun a => calc
    Ω₁' (Ω₁ a)
        -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
        = Ω₁' (ν (Ω a)) := rfl
    -- def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers
    _ = Ω' (μ (ν (Ω a))) := rfl
    -- claim_inverse_reindexing_after_reindexing_of_matrices_is_identity
    _ = Ω' (Ω a) := by
        rw [show μ (ν (Ω a)) = Ω a from
          inverseReindexMatrix_reindexMatrix (firstSiteHighestNumbering_isNumbering D.M).surjective (Ω a)]
    -- theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
    _ = a := hΩ'Ω a
  have hΩ₁Ω₁' : ∀ G : Mat K (Idx (twoPower D.M)), Ω₁ (Ω₁' G) = G := fun G => calc
    Ω₁ (Ω₁' G)
        -- def_homomorphism_from_general_clifford_algebra_to_matrices_indexed_by_numbers
        = ν (Ω (Ω₁' G)) := rfl
    -- def_homomorphism_to_general_clifford_algebra_from_matrices_indexed_by_numbers
    _ = ν (Ω (Ω' (μ G))) := rfl
    -- theorem_conjugated_homomorphisms_between_general_clifford_algebra_and_matrix_algebra_are_mutually_inverse_isomorphisms
    _ = ν (μ G) := by rw [show Ω (Ω' (μ G)) = μ G from hΩΩ' (μ G)]
    -- claim_reindexing_after_inverse_reindexing_of_matrices_is_identity
    _ = G := reindexMatrix_inverseReindexMatrix (firstSiteHighestNumbering_isNumbering D.M) G
  have hinj : Function.Injective Ω₁ := by
    intro a a' haa'
    calc a = Ω₁' (Ω₁ a) := (hΩ₁'Ω₁ a).symm
      _ = Ω₁' (Ω₁ a') := by rw [haa']
      _ = a' := hΩ₁'Ω₁ a'
  have hsurj : Function.Surjective Ω₁ := fun G => ⟨Ω₁' G, hΩ₁Ω₁' G⟩
  have hinv : ∀ (G : Mat K (Idx (twoPower D.M))) (a : QY.Cl C), Ω₁ a = G → a = Ω₁' G := by
    intro G a ha
    apply hinj
    calc Ω₁ a = G := ha
      _ = Ω₁ (Ω₁' G) := (hΩ₁Ω₁' G).symm
  exact ⟨hΩ₁, hΩ₁', hΩ₁'Ω₁, hΩ₁Ω₁', ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_homomorphisms_between_general_clifford_algebra_and_matrices_indexed_by_numbers_are_mutually_inverse_isomorphisms`
の必要十分版：e := `orthonormalBasis` のとき（前半の系の定理の必要十分版と同じく、e を固定する仮定の組 `E` と Q の非退化性を足す）。 -/
theorem numberedHomomorphisms_mutually_inverse [Inv K] (E : OrthonormalBasisExistenceLaws K)
    (hneg : ∀ a : K, a + -a = 0) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis E QY hdim hQ
    let he := D.orthonormalBasis_spec E QY hdim hQ
    let B' := numberedMatrixAlgebra C.valuedMaps C.mul_comm C.uniqueness.mul_zero D.M
    let Ω₁ := D.numberedHomomorphismToMatrix C hneg E.neg_mul hneg_neg i hi h QY hQ.isQuadraticForm e he
    let Ω₁' := D.numberedHomomorphismFromMatrix C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) B' Ω₁ ∧
      IsAlgebraHomomorphism B' (QY.cliffordAlgebra C) Ω₁' ∧
      (∀ a : QY.Cl C, Ω₁' (Ω₁ a) = a) ∧
      (∀ G : Mat K (Idx (twoPower D.M)), Ω₁ (Ω₁' G) = G) ∧
      Function.Bijective Ω₁ ∧
      (∀ (G : Mat K (Idx (twoPower D.M))) (a : QY.Cl C), Ω₁ a = G → a = Ω₁' G) :=
  D.numberedHomomorphisms_mutually_inverse_of_family C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm
    _ (D.orthonormalBasis_spec E QY hdim hQ)

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
