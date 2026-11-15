/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の後半（分裂した二次空間との等長写像と、系の定理）の具体版。
人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                              このファイル
  def_setting_of_general_even_dimensional_corollary                         SplitData（前提の組）・SplitData.splitBasis（d）・splitBasis_isBasis
  claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary
                                                                            SplitData.splitBasis_first・SplitData.splitBasis_second
  def_general_even_dimensional_nondegenerate_quadratic_space                前提 QY・hdim・hQ（各宣言の引数）
  def_orthonormal_basis_of_general_even_dimensional_space                   IsOrthonormalBasisFamily（e の三つの条件）・
                                                                            SplitData.orthonormalBasis（e）・SplitData.orthonormalBasis_spec
  def_inverse_of_two_in_complex_numbers                                     inverseOfTwo（h）・inverseOfTwo_mul・mul_inverseOfTwo
  claim_negative_imaginary_unit_times_imaginary_unit_is_one                 negImaginaryUnit_mul_imaginaryUnit
  def_family_in_split_space_for_isometry                                    SplitData.splitFamily（u）・splitFamily_first・splitFamily_second
  claim_quadratic_form_on_family_in_split_space_is_one                      SplitData.form_splitFamily
  claim_family_in_split_space_is_orthogonal                                 SplitData.polarization_splitFamily
  def_map_to_split_quadratic_space                                          SplitData.mapToSplit（θ）
  claim_map_to_split_quadratic_space_is_isometry                            SplitData.mapToSplit_isIsometry
  def_family_in_general_space_for_inverse_isometry                          SplitData.inverseFamily（v）・inverseFamily_first・inverseFamily_second
  def_map_from_split_quadratic_space                                        SplitData.mapFromSplit（θ'）
  claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis    SplitData.mapFromSplit_splitFamily
  claim_map_to_split_quadratic_space_sends_family_to_basis                  SplitData.mapToSplit_inverseFamily
  claim_map_from_split_after_map_to_split_is_identity                       SplitData.mapFromSplit_mapToSplit
  claim_map_to_split_after_map_from_split_is_identity                       SplitData.mapToSplit_mapFromSplit
  claim_map_from_split_quadratic_space_is_isometry                          SplitData.mapFromSplit_isIsometry
  theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra
                                                                            SplitData.homomorphismToMatrixOfGeneral（Φ_Y）・
                                                                            SplitData.homomorphismFromMatrixOfGeneral（Ψ_Y）・
                                                                            SplitData.generalCliffordAlgebra_isomorphic_matrixAlgebra

表し方:
- 分裂した二次空間 (V, q) と基底 d は `SplitData` の `D.space`（V := W ⊕ W^*、q := q_W、基底 c）で、本文の d は c と同じ族
  `D.splitBasis` である。B_q は `polarization D.space.space D.space.form`。
- 一般の非退化な二次空間 (Y, b^Y, Q) は、章「クリフォード代数」の前提の組 `QY : QuadraticSpaceWithBasis Y`（基底 b^Y、二次形式 Q、
  Cl(Y,Q) は基底 b^Y で構成したもの）と、基底の元の個数が 2M であること `hdim : QY.dim = D.M + D.M` と、Q が非退化であること
  `hQ : IsNondegenerateQuadraticForm QY.space QY.form` で受ける。2M は `D.M + D.M`（`D.space.dim` と同じ式）と書く。
- 本文の e は「条件を満たす基底を一つ固定する」もので、存在は `exists_orthonormal_basis`（`OrthonormalBasis.lean`）による。
  `orthonormalBasis` はそれを `Classical.choose` で取り出したものである。θ・v・θ' と、それらについての主張は、e を引数にとり、
  e が満たす三つの条件 `IsOrthonormalBasisFamily` を仮定に置く（本文の証明が e について使うのはこの三つだけである）。
  系の定理では e := `orthonormalBasis` とする。
- 番号付けた族 u・v は `ℕ → V`・`ℕ → Y` で、`if k ≤ M` で前半 {1,…,M} と後半 {M+1,…,2M} を分けて定める（1,…,2M の外の値は使わない）。
  本文の「k = m の場合」「k = M + m の場合」は、`index_cases` で k を m か M + m の形に分けて書く。
- 本文の ℂ の加法の逆元 -_ℂ z は ℂ の `-z`、i は `imaginaryUnit`（`OrthonormalBasis.lean`）である。
- 本文の前提 M ∈ ℤ_{≥1} は、どの証明も使わない（M = 0 でも同じ証明が通る）ので、仮定に置かない。
- 系の定理の「Φ_Y は全単射であり、その逆写像は Ψ_Y」は、主定理（`cliffordAlgebra_isomorphic_matrixAlgebra`）と同じく
  `Function.Bijective` と「Φ_Y(a) = F を満たす a は Ψ_Y(F) である」で書く。

必要十分版は `NecSuf/Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean`、導出版は `IsometryToSplitSpaceFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.OrthonormalBasis
import CliffordMatrixIsomorphism.Isomorphism.GeneralEvenDimensional.InducedHomomorphism
import CliffordMatrixIsomorphism.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe v

variable {Y : Type v}

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space` の e が満たす三つの条件：基底であること、
k ≠ l なら B_q(e_k, e_l) = 0_ℂ、すべての k で q(e_k) = 1_ℂ。 -/
structure IsOrthonormalBasisFamily (S : ComplexVectorSpace Y) (q : Y → ℂ) (n : ℕ) (e : ℕ → Y) : Prop where
  isBasis : IsBasisFamily S n e
  orthogonal : ∀ k l : ℕ, 1 ≤ k → k ≤ n → 1 ≤ l → l ≤ n → k ≠ l → polarization S q (e k) (e l) = 0
  form_eq_one : ∀ k : ℕ, 1 ≤ k → k ≤ n → q (e k) = 1

/-- 本文 `def_inverse_of_two_in_complex_numbers`：h := (1_ℂ +_ℂ 1_ℂ)^{-1}。1 + 1 ≠ 0（`complex_one_add_one_ne_zero`、
本文 `claim_one_plus_one_is_nonzero_in_complex_numbers`）なので逆元がある。 -/
noncomputable def inverseOfTwo : ℂ := ((1 : ℂ) + 1)⁻¹

/-- 本文 `def_inverse_of_two_in_complex_numbers`：h ·_ℂ (1_ℂ +_ℂ 1_ℂ) = 1_ℂ。 -/
theorem inverseOfTwo_mul : inverseOfTwo * ((1 : ℂ) + 1) = 1 := inv_mul_cancel₀ complex_one_add_one_ne_zero

/-- 本文 `def_inverse_of_two_in_complex_numbers`：(1_ℂ +_ℂ 1_ℂ) ·_ℂ h = 1_ℂ。 -/
theorem mul_inverseOfTwo : ((1 : ℂ) + 1) * inverseOfTwo = 1 := mul_inv_cancel₀ complex_one_add_one_ne_zero

/-- 本文 `claim_negative_imaginary_unit_times_imaginary_unit_is_one`：(-_ℂ i) ·_ℂ i = 1_ℂ。 -/
theorem negImaginaryUnit_mul_imaginaryUnit : (-imaginaryUnit) * imaginaryUnit = 1 := calc
  (-imaginaryUnit) * imaginaryUnit = -(imaginaryUnit * imaginaryUnit) := neg_mul imaginaryUnit imaginaryUnit
  _ = -(-1) := by rw [imaginaryUnit_mul_self]
  _ = 1 := neg_neg 1

end CliffordMatrixIsomorphism.ComplexVectorSpace

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra
open CliffordMatrixIsomorphism.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.Isomorphism

universe u v

/-- 番号 k ∈ {1,…,M+M} は、m ∈ {1,…,M} によって k = m か k = M + m のどちらかの形に書ける（本文の場合分け）。 -/
theorem index_cases (M k : ℕ) (hk : k ≤ M + M) :
    k ≤ M ∨ ∃ m : ℕ, 1 ≤ m ∧ m ≤ M ∧ k = M + m := by
  by_cases h : k ≤ M
  · exact Or.inl h
  · exact Or.inr ⟨k - M, by omega, by omega, by omega⟩

noncomputable section

variable {W : Type u} (D : SplitData W) {Y : Type v}

/-! ### 分裂した二次空間の基底 d -/

/-- 本文 `def_setting_of_general_even_dimensional_corollary`：V の基底 c を、生成作用素の行列との区別のため d と書く。 -/
def splitBasis : ℕ → W × DualSpace D.spaceW := D.space.basis

/-- 本文 `def_setting_of_general_even_dimensional_corollary`：d は V の基底である（`claim_basis_of_direct_sum_of_two_vector_spaces`）。 -/
theorem splitBasis_isBasis : IsBasisFamily D.space.space (D.M + D.M) D.splitBasis := D.space.isBasis

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の一つ目：d_m = in_1(w_m)。
本文の m ∈ {1,…,M} のうち、証明が使うのは m ≤ M だけである。 -/
theorem splitBasis_first (m : ℕ) (hmM : m ≤ D.M) :
    D.splitBasis m = embedFirst (dualSpaceVectorSpace D.spaceW) (D.w m) := calc
  D.splitBasis m = concatenatedFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f m := rfl
  _ = embedFirst (dualSpaceVectorSpace D.spaceW) (D.w m) :=
      concatenatedFamily_of_le D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f m hmM

/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の二つ目：d_{M+m} = in_2(f_m)。
本文の m ∈ {1,…,M} のうち、証明が使うのは 1 ≤ m だけである。 -/
theorem splitBasis_second (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitBasis (D.M + m) = embedSecond D.spaceW (D.f m) := calc
  D.splitBasis (D.M + m) = concatenatedFamily D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f (D.M + m) := rfl
  _ = embedSecond D.spaceW (D.f m) :=
      concatenatedFamily_add D.spaceW (dualSpaceVectorSpace D.spaceW) D.M D.w D.f m hm1

/-! ### どの元での値も 1 の直交基底 e -/

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space`：Y の基底 e で、k ≠ l なら B_Q(e_k, e_l) = 0_ℂ、
すべての k で Q(e_k) = 1_ℂ を満たすものを一つ固定する。存在は `exists_orthonormal_basis`
（本文 `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form`）。 -/
def orthonormalBasis (QY : Clifford.QuadraticSpaceWithBasis Y) (hdim : QY.dim = D.M + D.M)
    (hQ : IsNondegenerateQuadraticForm QY.space QY.form) : ℕ → Y :=
  Classical.choose (exists_orthonormal_basis QY.space QY.form hQ (D.M + D.M) QY.basis (hdim ▸ QY.isBasis))

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space`：固定した e は三つの条件を満たす。 -/
theorem orthonormalBasis_spec (QY : Clifford.QuadraticSpaceWithBasis Y) (hdim : QY.dim = D.M + D.M)
    (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) (D.orthonormalBasis QY hdim hQ) := by
  obtain ⟨h1, h2, h3⟩ :=
    Classical.choose_spec (exists_orthonormal_basis QY.space QY.form hQ (D.M + D.M) QY.basis (hdim ▸ QY.isBasis))
  exact ⟨h1, h2, h3⟩

/-! ### 分裂した二次空間の族 u -/

/-- 本文 `def_family_in_split_space_for_isometry`：u_m := (w_m, f_m)、u_{M+m} := ((-_ℂ i) ·_W w_m, i ·_{W^*} f_m)。 -/
def splitFamily (k : ℕ) : W × DualSpace D.spaceW :=
  if k ≤ D.M then (D.w k, D.f k)
  else (D.spaceW.smul (-imaginaryUnit) (D.w (k - D.M)),
    (dualSpaceVectorSpace D.spaceW).smul imaginaryUnit (D.f (k - D.M)))

/-- 本文 `def_family_in_split_space_for_isometry`：u_m = (w_m, f_m)（m ≤ M）。 -/
theorem splitFamily_first (m : ℕ) (hmM : m ≤ D.M) : D.splitFamily m = (D.w m, D.f m) := by
  unfold splitFamily
  rw [if_pos hmM]

/-- 本文 `def_family_in_split_space_for_isometry`：u_{M+m} = ((-_ℂ i) ·_W w_m, i ·_{W^*} f_m)（1 ≤ m）。 -/
theorem splitFamily_second (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitFamily (D.M + m)
      = (D.spaceW.smul (-imaginaryUnit) (D.w m), (dualSpaceVectorSpace D.spaceW).smul imaginaryUnit (D.f m)) := by
  unfold splitFamily
  rw [if_neg (by omega), Nat.add_sub_cancel_left]

/-- 本文 `def_kronecker_delta`：δ_{m,m} = 1_ℂ。 -/
theorem kroneckerDelta_self (m : ℕ) : (kroneckerDelta m m : ℂ) = 1 := by
  unfold kroneckerDelta
  rw [if_pos rfl]

/-- 本文 `claim_quadratic_form_on_family_in_split_space_is_one`：すべての k ∈ {1,…,2M} で q(u_k) = 1_ℂ。 -/
theorem form_splitFamily (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) : D.space.form (D.splitFamily k) = 1 := by
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩
  · -- k = m の場合
    calc D.space.form (D.splitFamily k)
        = splitQuadraticForm D.spaceW (D.w k, D.f k) := by rw [D.splitFamily_first k hkM]; rfl
      _ = (D.f k).1 (D.w k) := rfl
      _ = kroneckerDelta k k := D.isDualBasis k k hk1 hkM hk1 hkM
      _ = 1 := kroneckerDelta_self k
  · -- k = M + m の場合
    calc D.space.form (D.splitFamily (D.M + m))
        = splitQuadraticForm D.spaceW
            (D.spaceW.smul (-imaginaryUnit) (D.w m), (dualSpaceVectorSpace D.spaceW).smul imaginaryUnit (D.f m)) := by
          rw [D.splitFamily_second m hm1]; rfl
      _ = ((dualSpaceVectorSpace D.spaceW).smul imaginaryUnit (D.f m)).1 (D.spaceW.smul (-imaginaryUnit) (D.w m)) := rfl
      _ = imaginaryUnit * (D.f m).1 (D.spaceW.smul (-imaginaryUnit) (D.w m)) := rfl
      _ = imaginaryUnit * ((-imaginaryUnit) * (D.f m).1 (D.w m)) := by rw [(D.f m).2.map_smul (-imaginaryUnit) (D.w m)]
      _ = imaginaryUnit * ((-imaginaryUnit) * kroneckerDelta m m) := by rw [D.isDualBasis m m hm1 hmM hm1 hmM]
      _ = imaginaryUnit * ((-imaginaryUnit) * 1) := by rw [kroneckerDelta_self m]
      _ = imaginaryUnit * (-imaginaryUnit) := by rw [mul_one (-imaginaryUnit)]
      _ = (-imaginaryUnit) * imaginaryUnit := mul_comm imaginaryUnit (-imaginaryUnit)
      _ = 1 := negImaginaryUnit_mul_imaginaryUnit

/-- 本文 `claim_family_in_split_space_is_orthogonal` の二つ目の場合（k = m、l = M + m'）：B_q(u_m, u_{M+m'}) = 0_ℂ。
三つ目の場合はこれを m と m' を入れ替えて引く。 -/
theorem polarization_splitFamily_first_second (m m' : ℕ) (hm1 : 1 ≤ m) (hmM : m ≤ D.M) (hm'1 : 1 ≤ m')
    (hm'M : m' ≤ D.M) :
    polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m')) = 0 := by
  have hδ : (kroneckerDelta m' m : ℂ) = kroneckerDelta m m' := by
    unfold kroneckerDelta
    by_cases h : m = m'
    · rw [if_pos h.symm, if_pos h]
    · rw [if_neg (Ne.symm h), if_neg h]
  let i := imaginaryUnit
  calc polarization D.space.space D.space.form (D.splitFamily m) (D.splitFamily (D.M + m'))
      = polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW) (D.w m, D.f m)
          (D.spaceW.smul (-i) (D.w m'), (dualSpaceVectorSpace D.spaceW).smul i (D.f m')) := by
        rw [D.splitFamily_first m hmM, D.splitFamily_second m' hm'1]; rfl
    _ = (D.f m).1 (D.spaceW.smul (-i) (D.w m')) + ((dualSpaceVectorSpace D.spaceW).smul i (D.f m')).1 (D.w m) :=
        polarization_splitQuadraticForm D.spaceW _ _ _ _
    _ = (-i) * (D.f m).1 (D.w m') + ((dualSpaceVectorSpace D.spaceW).smul i (D.f m')).1 (D.w m) := by
        rw [(D.f m).2.map_smul (-i) (D.w m')]
    _ = (-i) * (D.f m).1 (D.w m') + i * (D.f m').1 (D.w m) := rfl
    _ = (-i) * kroneckerDelta m m' + i * kroneckerDelta m' m := by
        rw [D.isDualBasis m m' hm1 hmM hm'1 hm'M, D.isDualBasis m' m hm'1 hm'M hm1 hmM]
    _ = (-i) * kroneckerDelta m m' + i * kroneckerDelta m m' := by rw [hδ]
    _ = ((-i) + i) * kroneckerDelta m m' := (add_mul (-i) i (kroneckerDelta m m')).symm
    _ = 0 * kroneckerDelta m m' := by rw [neg_add_cancel i]
    _ = 0 := zero_mul (kroneckerDelta m m' : ℂ)

/-- 本文 `claim_family_in_split_space_is_orthogonal`：k ≠ l なら B_q(u_k, u_l) = 0_ℂ。四つの場合に分ける。 -/
theorem polarization_splitFamily (k l : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M)
    (hkl : k ≠ l) : polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l) = 0 := by
  let i := imaginaryUnit
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩ <;>
    rcases index_cases D.M l hl with hlM | ⟨m', hm'1, hm'M, rfl⟩
  · -- k = m、l = m'、m ≠ m' の場合
    calc polarization D.space.space D.space.form (D.splitFamily k) (D.splitFamily l)
        = polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW) (D.w k, D.f k) (D.w l, D.f l) := by
          rw [D.splitFamily_first k hkM, D.splitFamily_first l hlM]; rfl
      _ = (D.f k).1 (D.w l) + (D.f l).1 (D.w k) := polarization_splitQuadraticForm D.spaceW _ _ _ _
      _ = kroneckerDelta k l + kroneckerDelta l k := by
          rw [D.isDualBasis k l hk1 hkM hl1 hlM, D.isDualBasis l k hl1 hlM hk1 hkM]
      _ = 0 + 0 := by unfold kroneckerDelta; rw [if_neg hkl, if_neg (Ne.symm hkl)]
      _ = 0 := _root_.add_zero (0 : ℂ)
  · -- k = m、l = M + m' の場合
    exact D.polarization_splitFamily_first_second k m' hk1 hkM hm'1 hm'M
  · -- k = M + m、l = m' の場合：B_q の対称性（`polarization_symm`）で一つ前の場合へ
    calc polarization D.space.space D.space.form (D.splitFamily (D.M + m)) (D.splitFamily l)
        = polarization D.space.space D.space.form (D.splitFamily l) (D.splitFamily (D.M + m)) :=
          polarization_symm D.space.space D.space.form _ _
      _ = 0 := D.polarization_splitFamily_first_second l m hl1 hlM hm1 hmM
  · -- k = M + m、l = M + m'、m ≠ m' の場合
    have hmm' : m ≠ m' := fun h => hkl (by rw [h])
    calc polarization D.space.space D.space.form (D.splitFamily (D.M + m)) (D.splitFamily (D.M + m'))
        = polarization (splitSpace D.spaceW) (splitQuadraticForm D.spaceW)
            (D.spaceW.smul (-i) (D.w m), (dualSpaceVectorSpace D.spaceW).smul i (D.f m))
            (D.spaceW.smul (-i) (D.w m'), (dualSpaceVectorSpace D.spaceW).smul i (D.f m')) := by
          rw [D.splitFamily_second m hm1, D.splitFamily_second m' hm'1]; rfl
      _ = ((dualSpaceVectorSpace D.spaceW).smul i (D.f m)).1 (D.spaceW.smul (-i) (D.w m'))
            + ((dualSpaceVectorSpace D.spaceW).smul i (D.f m')).1 (D.spaceW.smul (-i) (D.w m)) :=
          polarization_splitQuadraticForm D.spaceW _ _ _ _
      _ = i * (D.f m).1 (D.spaceW.smul (-i) (D.w m')) + i * (D.f m').1 (D.spaceW.smul (-i) (D.w m)) := rfl
      _ = i * ((-i) * (D.f m).1 (D.w m')) + i * ((-i) * (D.f m').1 (D.w m)) := by
          rw [(D.f m).2.map_smul (-i) (D.w m'), (D.f m').2.map_smul (-i) (D.w m)]
      _ = i * ((-i) * kroneckerDelta m m') + i * ((-i) * kroneckerDelta m' m) := by
          rw [D.isDualBasis m m' hm1 hmM hm'1 hm'M, D.isDualBasis m' m hm'1 hm'M hm1 hmM]
      _ = i * ((-i) * 0) + i * ((-i) * 0) := by unfold kroneckerDelta; rw [if_neg hmm', if_neg (Ne.symm hmm')]
      _ = i * 0 + i * 0 := by rw [mul_zero (-i)]
      _ = 0 + 0 := by rw [mul_zero i]
      _ = 0 := _root_.add_zero (0 : ℂ)

/-! ### 一般の非退化な二次空間から分裂した二次空間への写像 θ -/

/-- 本文 `def_map_to_split_quadratic_space`：θ := L_{e,u}、θ(x) = Σ_{k=1}^{2M} β^e_k(x) ·_V u_k。 -/
def mapToSplit (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) : W × DualSpace D.spaceW :=
  mapByCoordinates QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily x

/-- 本文 `claim_map_to_split_quadratic_space_is_isometry`：θ は (Y, Q) から (V, q) への等長写像である。 -/
theorem mapToSplit_isIsometry (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry QY.space D.space.space QY.form D.space.form (D.mapToSplit QY e he) where
  isQuadraticForm := QY.isQuadraticForm
  isQuadraticForm' := D.space.isQuadraticForm
  isLinearMap := mapByCoordinates_isLinearMap QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily
  map_form x := by
    let ν : ℕ → ℂ := fun k => coordinate QY.space (D.M + D.M) e he.isBasis k x
    calc D.space.form (D.mapToSplit QY e he x)
        = D.space.form (linearCombination D.space.space (D.M + D.M) ν D.splitFamily) := rfl
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * D.space.form (D.splitFamily k))) :=
          quadraticForm_linearCombination_orthogonal D.space.space D.space.form D.space.isQuadraticForm (D.M + D.M)
            D.splitFamily D.polarization_splitFamily ν
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * 1)) :=
          orderedSum_congr (D.M + D.M) _ _ fun k hk1 hk => by rw [D.form_splitFamily k hk1 hk]
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * QY.form (e k))) :=
          orderedSum_congr (D.M + D.M) _ _ fun k hk1 hk => by rw [he.form_eq_one k hk1 hk]
      _ = QY.form (linearCombination QY.space (D.M + D.M) ν e) :=
          (quadraticForm_linearCombination_orthogonal QY.space QY.form QY.isQuadraticForm (D.M + D.M) e
            he.orthogonal ν).symm
      _ = QY.form x := by rw [linearCombination_coordinate QY.space (D.M + D.M) e he.isBasis x]

/-! ### 逆向きの写像 θ' -/

/-- 本文 `def_family_in_general_space_for_inverse_isometry`：v_m := h ·_Y (e_m +_Y i ·_Y e_{M+m})、
v_{M+m} := h ·_Y (e_m +_Y (-_ℂ i) ·_Y e_{M+m})。 -/
def inverseFamily (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y) (k : ℕ) : Y :=
  if k ≤ D.M then QY.space.smul inverseOfTwo (QY.space.add (e k) (QY.space.smul imaginaryUnit (e (D.M + k))))
  else QY.space.smul inverseOfTwo
    (QY.space.add (e (k - D.M)) (QY.space.smul (-imaginaryUnit) (e (D.M + (k - D.M)))))

/-- 本文 `def_family_in_general_space_for_inverse_isometry`：v_m（m ≤ M）。 -/
theorem inverseFamily_first (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y) (m : ℕ) (hmM : m ≤ D.M) :
    D.inverseFamily QY e m
      = QY.space.smul inverseOfTwo (QY.space.add (e m) (QY.space.smul imaginaryUnit (e (D.M + m)))) := by
  unfold inverseFamily
  rw [if_pos hmM]

/-- 本文 `def_family_in_general_space_for_inverse_isometry`：v_{M+m}（1 ≤ m）。 -/
theorem inverseFamily_second (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y) (m : ℕ) (hm1 : 1 ≤ m) :
    D.inverseFamily QY e (D.M + m)
      = QY.space.smul inverseOfTwo (QY.space.add (e m) (QY.space.smul (-imaginaryUnit) (e (D.M + m)))) := by
  unfold inverseFamily
  rw [if_neg (by omega), Nat.add_sub_cancel_left]

/-- 本文 `def_map_from_split_quadratic_space`：θ' := L_{d,v}、θ'(y) = Σ_{l=1}^{2M} β^d_l(y) ·_Y v_l。 -/
def mapFromSplit (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y) (y : W × DualSpace D.spaceW) : Y :=
  mapByCoordinates D.space.space QY.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis (D.inverseFamily QY e) y

/-- 本文 `claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis`：θ'(u_k) = e_k（k ∈ {1,…,2M}）。
e について使うのは何も無い（v と θ' の定義だけ）。 -/
theorem mapFromSplit_splitFamily (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y) (k : ℕ) (hk1 : 1 ≤ k)
    (hk : k ≤ D.M + D.M) : D.mapFromSplit QY e (D.splitFamily k) = e k := by
  let SY := QY.space
  let SV := D.space.space
  let i := imaginaryUnit
  let h := inverseOfTwo
  let θ' := D.mapFromSplit QY e
  let v := D.inverseFamily QY e
  have hθ' : IsComplexLinearMap SV SY θ' :=
    mapByCoordinates_isLinearMap SV SY (D.M + D.M) D.splitBasis D.splitBasis_isBasis v
  have hθ'd : ∀ l : ℕ, 1 ≤ l → l ≤ D.M + D.M → θ' (D.splitBasis l) = v l :=
    fun l hl1 hl => mapByCoordinates_basis SV SY (D.M + D.M) D.splitBasis D.splitBasis_isBasis v l hl1 hl
  -- 準備の一つ目と二つ目
  have hp1 : (-i) * i = 1 := negImaginaryUnit_mul_imaginaryUnit
  have hp2 : i * (-i) = 1 := by rw [mul_comm i (-i)]; exact hp1
  -- 準備の三つ目
  have hp3 : (-i) * h + i * h = 0 := calc
    (-i) * h + i * h = ((-i) + i) * h := (add_mul (-i) i h).symm
    _ = 0 * h := by rw [neg_add_cancel i]
    _ = 0 := zero_mul h
  -- 準備の四つ目
  have hp4 : ((-i) * h) * i + (i * h) * (-i) = 1 := calc
    ((-i) * h) * i + (i * h) * (-i) = (-i) * (h * i) + i * (h * (-i)) := by
        rw [mul_assoc (-i) h i, mul_assoc i h (-i)]
    _ = (-i) * (i * h) + i * ((-i) * h) := by rw [mul_comm h i, mul_comm h (-i)]
    _ = ((-i) * i) * h + (i * (-i)) * h := by rw [mul_assoc (-i) i h, mul_assoc i (-i) h]
    _ = 1 * h + 1 * h := by rw [hp1, hp2]
    _ = (1 + 1) * h := (add_mul 1 1 h).symm
    _ = 1 := mul_inverseOfTwo
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩
  · -- k = m の場合
    let e' := e (D.M + k)
    have hu : D.splitFamily k = SV.add (D.splitBasis k) (D.splitBasis (D.M + k)) := calc
      D.splitFamily k = (D.w k, D.f k) := D.splitFamily_first k hkM
      _ = SV.add (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w k)) (embedSecond D.spaceW (D.f k)) :=
          pair_eq_add_embed D.spaceW (dualSpaceVectorSpace D.spaceW) (D.w k) (D.f k)
      _ = SV.add (D.splitBasis k) (D.splitBasis (D.M + k)) := by
          rw [D.splitBasis_first k hkM, D.splitBasis_second k hk1]
    calc θ' (D.splitFamily k)
        = θ' (SV.add (D.splitBasis k) (D.splitBasis (D.M + k))) := by rw [hu]
      _ = SY.add (θ' (D.splitBasis k)) (θ' (D.splitBasis (D.M + k))) := hθ'.map_add _ _
      _ = SY.add (v k) (v (D.M + k)) := by rw [hθ'd k hk1 (by omega), hθ'd (D.M + k) (by omega) (by omega)]
      _ = SY.add (SY.smul h (SY.add (e k) (SY.smul i e'))) (SY.smul h (SY.add (e k) (SY.smul (-i) e'))) := by
          rw [show v k = _ from D.inverseFamily_first QY e k hkM, show v (D.M + k) = _ from D.inverseFamily_second QY e k hk1]
      _ = SY.smul h (SY.add (SY.add (e k) (SY.smul i e')) (SY.add (e k) (SY.smul (-i) e'))) :=
          (SY.smul_add h _ _).symm
      _ = SY.smul h (SY.add (SY.add (e k) (e k)) (SY.add (SY.smul i e') (SY.smul (-i) e'))) := by
          rw [rearrange_sum_of_two_sums SY (e k) (SY.smul i e') (e k) (SY.smul (-i) e')]
      _ = SY.smul h (SY.add (SY.add (SY.smul 1 (e k)) (SY.smul 1 (e k))) (SY.add (SY.smul i e') (SY.smul (-i) e'))) := by
          rw [SY.one_smul (e k)]
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) (SY.smul (i + -i) e')) := by
          rw [SY.add_smul 1 1 (e k), SY.add_smul i (-i) e']
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) (SY.smul 0 e')) := by rw [add_neg_cancel i]
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) SY.zero) := by rw [zero_smul_eq_zero SY e']
      _ = SY.smul h (SY.smul (1 + 1) (e k)) := by rw [SY.add_zero (SY.smul (1 + 1) (e k))]
      _ = SY.smul (h * (1 + 1)) (e k) := (SY.smul_assoc h (1 + 1) (e k)).symm
      _ = SY.smul 1 (e k) := by rw [inverseOfTwo_mul]
      _ = e k := SY.one_smul (e k)
  · -- k = M + m の場合
    let e' := e (D.M + m)
    have hu : D.splitFamily (D.M + m)
        = SV.add (SV.smul (-i) (D.splitBasis m)) (SV.smul i (D.splitBasis (D.M + m))) := calc
      D.splitFamily (D.M + m)
          = (D.spaceW.smul (-i) (D.w m), (dualSpaceVectorSpace D.spaceW).smul i (D.f m)) := D.splitFamily_second m hm1
      _ = SV.add (embedFirst (dualSpaceVectorSpace D.spaceW) (D.spaceW.smul (-i) (D.w m)))
            (embedSecond D.spaceW ((dualSpaceVectorSpace D.spaceW).smul i (D.f m))) :=
          pair_eq_add_embed D.spaceW (dualSpaceVectorSpace D.spaceW) _ _
      _ = SV.add (SV.smul (-i) (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w m)))
            (SV.smul i (embedSecond D.spaceW (D.f m))) := by
          rw [(embedFirst_isLinearMap D.spaceW (dualSpaceVectorSpace D.spaceW)).map_smul (-i) (D.w m),
            (embedSecond_isLinearMap D.spaceW (dualSpaceVectorSpace D.spaceW)).map_smul i (D.f m)]; rfl
      _ = SV.add (SV.smul (-i) (D.splitBasis m)) (SV.smul i (D.splitBasis (D.M + m))) := by
          rw [D.splitBasis_first m hmM, D.splitBasis_second m hm1]
    calc θ' (D.splitFamily (D.M + m))
        = θ' (SV.add (SV.smul (-i) (D.splitBasis m)) (SV.smul i (D.splitBasis (D.M + m)))) := by rw [hu]
      _ = SY.add (θ' (SV.smul (-i) (D.splitBasis m))) (θ' (SV.smul i (D.splitBasis (D.M + m)))) :=
          hθ'.map_add _ _
      _ = SY.add (SY.smul (-i) (θ' (D.splitBasis m))) (SY.smul i (θ' (D.splitBasis (D.M + m)))) := by
          rw [hθ'.map_smul (-i) (D.splitBasis m), hθ'.map_smul i (D.splitBasis (D.M + m))]
      _ = SY.add (SY.smul (-i) (v m)) (SY.smul i (v (D.M + m))) := by
          rw [hθ'd m hm1 (by omega), hθ'd (D.M + m) (by omega) (by omega)]
      _ = SY.add (SY.smul (-i) (SY.smul h (SY.add (e m) (SY.smul i e'))))
            (SY.smul i (SY.smul h (SY.add (e m) (SY.smul (-i) e')))) := by
          rw [show v m = _ from D.inverseFamily_first QY e m hmM, show v (D.M + m) = _ from D.inverseFamily_second QY e m hm1]
      _ = SY.add (SY.smul ((-i) * h) (SY.add (e m) (SY.smul i e')))
            (SY.smul (i * h) (SY.add (e m) (SY.smul (-i) e'))) := by
          rw [SY.smul_assoc (-i) h, SY.smul_assoc i h]
      _ = SY.add (SY.add (SY.smul ((-i) * h) (e m)) (SY.smul ((-i) * h) (SY.smul i e')))
            (SY.add (SY.smul (i * h) (e m)) (SY.smul (i * h) (SY.smul (-i) e'))) := by
          rw [SY.smul_add ((-i) * h) (e m) (SY.smul i e'), SY.smul_add (i * h) (e m) (SY.smul (-i) e')]
      _ = SY.add (SY.add (SY.smul ((-i) * h) (e m)) (SY.smul (((-i) * h) * i) e'))
            (SY.add (SY.smul (i * h) (e m)) (SY.smul ((i * h) * (-i)) e')) := by
          rw [SY.smul_assoc ((-i) * h) i e', SY.smul_assoc (i * h) (-i) e']
      _ = SY.add (SY.add (SY.smul ((-i) * h) (e m)) (SY.smul (i * h) (e m)))
            (SY.add (SY.smul (((-i) * h) * i) e') (SY.smul ((i * h) * (-i)) e')) :=
          rearrange_sum_of_two_sums SY _ _ _ _
      _ = SY.add (SY.smul ((-i) * h + i * h) (e m)) (SY.smul (((-i) * h) * i + (i * h) * (-i)) e') := by
          rw [SY.add_smul ((-i) * h) (i * h) (e m), SY.add_smul (((-i) * h) * i) ((i * h) * (-i)) e']
      _ = SY.add (SY.smul 0 (e m)) (SY.smul 1 e') := by rw [hp3, hp4]
      _ = SY.add SY.zero (SY.smul 1 e') := by rw [zero_smul_eq_zero SY (e m)]
      _ = SY.add SY.zero e' := by rw [SY.one_smul e']
      _ = SY.add e' SY.zero := SY.add_comm SY.zero e'
      _ = e' := SY.add_zero e'

/-- 本文 `claim_map_to_split_quadratic_space_sends_family_to_basis`：θ(v_l) = d_l（l ∈ {1,…,2M}）。
e について使うのは、基底であること（θ の定義と θ(e_k) = u_k）だけである。 -/
theorem mapToSplit_inverseFamily (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (l : ℕ) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M) :
    D.mapToSplit QY e he (D.inverseFamily QY e l) = D.splitBasis l := by
  let SY := QY.space
  let SW := D.spaceW
  let SF := dualSpaceVectorSpace D.spaceW
  let SV := D.space.space
  let i := imaginaryUnit
  let h := inverseOfTwo
  let θ := D.mapToSplit QY e he
  have hθ : IsComplexLinearMap SY SV θ :=
    mapByCoordinates_isLinearMap SY SV (D.M + D.M) e he.isBasis D.splitFamily
  have hθe : ∀ k : ℕ, 1 ≤ k → k ≤ D.M + D.M → θ (e k) = D.splitFamily k :=
    fun k hk1 hk => mapByCoordinates_basis SY SV (D.M + D.M) e he.isBasis D.splitFamily k hk1 hk
  have hp1 : (-i) * i = 1 := negImaginaryUnit_mul_imaginaryUnit
  have hp2 : i * (-i) = 1 := by rw [mul_comm i (-i)]; exact hp1
  -- (-_ℂ i) ·_ℂ (-_ℂ i) = -_ℂ 1_ℂ
  have hp5 : (-i) * (-i) = -1 := calc
    (-i) * (-i) = -(i * (-i)) := neg_mul i (-i)
    _ = -1 := by rw [hp2]
  rcases index_cases D.M l hl with hlM | ⟨m, hm1, hmM, rfl⟩
  · -- l = m の場合
    let e' := e (D.M + l)
    calc θ (D.inverseFamily QY e l)
        = θ (SY.smul h (SY.add (e l) (SY.smul i e'))) := by rw [D.inverseFamily_first QY e l hlM]
      _ = SV.smul h (θ (SY.add (e l) (SY.smul i e'))) := hθ.map_smul _ _
      _ = SV.smul h (SV.add (θ (e l)) (θ (SY.smul i e'))) := by rw [hθ.map_add (e l) (SY.smul i e')]
      _ = SV.smul h (SV.add (θ (e l)) (SV.smul i (θ e'))) := by rw [hθ.map_smul i e']
      _ = SV.smul h (SV.add (D.splitFamily l) (SV.smul i (D.splitFamily (D.M + l)))) := by
          rw [hθe l hl1 (by omega), hθe (D.M + l) (by omega) (by omega)]
      _ = SV.smul h (SV.add (D.w l, D.f l) (SV.smul i (SW.smul (-i) (D.w l), SF.smul i (D.f l)))) := by
          rw [D.splitFamily_first l hlM, D.splitFamily_second l hl1]
      _ = SV.smul h (SV.add (D.w l, D.f l) (SW.smul i (SW.smul (-i) (D.w l)), SF.smul i (SF.smul i (D.f l)))) := rfl
      _ = SV.smul h (SW.add (D.w l) (SW.smul i (SW.smul (-i) (D.w l))),
            SF.add (D.f l) (SF.smul i (SF.smul i (D.f l)))) := rfl
      _ = SV.smul h (SW.add (D.w l) (SW.smul (i * (-i)) (D.w l)), SF.add (D.f l) (SF.smul (i * i) (D.f l))) := by
          rw [SW.smul_assoc i (-i) (D.w l), SF.smul_assoc i i (D.f l)]
      _ = SV.smul h (SW.add (D.w l) (SW.smul 1 (D.w l)), SF.add (D.f l) (SF.smul (i * i) (D.f l))) := by rw [hp2]
      _ = SV.smul h (SW.add (D.w l) (SW.smul 1 (D.w l)), SF.add (D.f l) (SF.smul (-1) (D.f l))) := by
          rw [imaginaryUnit_mul_self]
      _ = SV.smul h (SW.add (SW.smul 1 (D.w l)) (SW.smul 1 (D.w l)), SF.add (SF.smul 1 (D.f l)) (SF.smul (-1) (D.f l))) := by
          rw [SW.one_smul (D.w l), SF.one_smul (D.f l)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.smul (1 + -1) (D.f l)) := by
          rw [SW.add_smul 1 1 (D.w l), SF.add_smul 1 (-1) (D.f l)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.smul 0 (D.f l)) := by rw [add_neg_cancel (1 : ℂ)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.zero) := by rw [zero_smul_eq_zero SF (D.f l)]
      _ = (SW.smul h (SW.smul (1 + 1) (D.w l)), SF.smul h SF.zero) := rfl
      _ = (SW.smul (h * (1 + 1)) (D.w l), SF.smul h SF.zero) := by rw [SW.smul_assoc h (1 + 1) (D.w l)]
      _ = (SW.smul (h * (1 + 1)) (D.w l), SF.zero) := by rw [smul_zero_eq_zero SF h]
      _ = (SW.smul 1 (D.w l), SF.zero) := by rw [inverseOfTwo_mul]
      _ = (D.w l, SF.zero) := by rw [SW.one_smul (D.w l)]
      _ = embedFirst SF (D.w l) := rfl
      _ = D.splitBasis l := (D.splitBasis_first l hlM).symm
  · -- l = M + m の場合
    let e' := e (D.M + m)
    calc θ (D.inverseFamily QY e (D.M + m))
        = θ (SY.smul h (SY.add (e m) (SY.smul (-i) e'))) := by rw [D.inverseFamily_second QY e m hm1]
      _ = SV.smul h (θ (SY.add (e m) (SY.smul (-i) e'))) := hθ.map_smul _ _
      _ = SV.smul h (SV.add (θ (e m)) (θ (SY.smul (-i) e'))) := by rw [hθ.map_add (e m) (SY.smul (-i) e')]
      _ = SV.smul h (SV.add (θ (e m)) (SV.smul (-i) (θ e'))) := by rw [hθ.map_smul (-i) e']
      _ = SV.smul h (SV.add (D.splitFamily m) (SV.smul (-i) (D.splitFamily (D.M + m)))) := by
          rw [hθe m hm1 (by omega), hθe (D.M + m) (by omega) (by omega)]
      _ = SV.smul h (SV.add (D.w m, D.f m) (SV.smul (-i) (SW.smul (-i) (D.w m), SF.smul i (D.f m)))) := by
          rw [D.splitFamily_first m hmM, D.splitFamily_second m hm1]
      _ = SV.smul h (SV.add (D.w m, D.f m)
            (SW.smul (-i) (SW.smul (-i) (D.w m)), SF.smul (-i) (SF.smul i (D.f m)))) := rfl
      _ = SV.smul h (SW.add (D.w m) (SW.smul (-i) (SW.smul (-i) (D.w m))),
            SF.add (D.f m) (SF.smul (-i) (SF.smul i (D.f m)))) := rfl
      _ = SV.smul h (SW.add (D.w m) (SW.smul ((-i) * (-i)) (D.w m)),
            SF.add (D.f m) (SF.smul ((-i) * i) (D.f m))) := by
          rw [SW.smul_assoc (-i) (-i) (D.w m), SF.smul_assoc (-i) i (D.f m)]
      _ = SV.smul h (SW.add (D.w m) (SW.smul (-1) (D.w m)), SF.add (D.f m) (SF.smul ((-i) * i) (D.f m))) := by
          rw [hp5]
      _ = SV.smul h (SW.add (D.w m) (SW.smul (-1) (D.w m)), SF.add (D.f m) (SF.smul 1 (D.f m))) := by
          rw [negImaginaryUnit_mul_imaginaryUnit]
      _ = SV.smul h (SW.add (SW.smul 1 (D.w m)) (SW.smul (-1) (D.w m)), SF.add (SF.smul 1 (D.f m)) (SF.smul 1 (D.f m))) := by
          rw [SW.one_smul (D.w m), SF.one_smul (D.f m)]
      _ = SV.smul h (SW.smul (1 + -1) (D.w m), SF.smul (1 + 1) (D.f m)) := by
          rw [SW.add_smul 1 (-1) (D.w m), SF.add_smul 1 1 (D.f m)]
      _ = SV.smul h (SW.smul 0 (D.w m), SF.smul (1 + 1) (D.f m)) := by rw [add_neg_cancel (1 : ℂ)]
      _ = SV.smul h (SW.zero, SF.smul (1 + 1) (D.f m)) := by rw [zero_smul_eq_zero SW (D.w m)]
      _ = (SW.smul h SW.zero, SF.smul h (SF.smul (1 + 1) (D.f m))) := rfl
      _ = (SW.zero, SF.smul h (SF.smul (1 + 1) (D.f m))) := by rw [smul_zero_eq_zero SW h]
      _ = (SW.zero, SF.smul (h * (1 + 1)) (D.f m)) := by rw [SF.smul_assoc h (1 + 1) (D.f m)]
      _ = (SW.zero, SF.smul 1 (D.f m)) := by rw [inverseOfTwo_mul]
      _ = (SW.zero, D.f m) := by rw [SF.one_smul (D.f m)]
      _ = embedSecond SW (D.f m) := rfl
      _ = D.splitBasis (D.M + m) := (D.splitBasis_second m hm1).symm

/-- 本文 `claim_map_from_split_after_map_to_split_is_identity`：すべての x ∈ Y で θ'(θ(x)) = x。 -/
theorem mapFromSplit_mapToSplit (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (x : Y) :
    D.mapFromSplit QY e (D.mapToSplit QY e he x) = x := by
  have hθ : IsComplexLinearMap QY.space D.space.space (D.mapToSplit QY e he) :=
    mapByCoordinates_isLinearMap QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily
  have hθ' : IsComplexLinearMap D.space.space QY.space (D.mapFromSplit QY e) :=
    mapByCoordinates_isLinearMap D.space.space QY.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis
      (D.inverseFamily QY e)
  -- 合成は線型写像（`claim_composition_of_linear_maps_is_linear_map`）
  have hcomp : IsComplexLinearMap QY.space QY.space (fun x => D.mapFromSplit QY e (D.mapToSplit QY e he x)) :=
    IsComplexLinearMap.comp hθ hθ'
  have hfix : ∀ k : ℕ, 1 ≤ k → k ≤ D.M + D.M → D.mapFromSplit QY e (D.mapToSplit QY e he (e k)) = e k :=
    fun k hk1 hk => calc
      D.mapFromSplit QY e (D.mapToSplit QY e he (e k)) = D.mapFromSplit QY e (D.splitFamily k) := by
          rw [show D.mapToSplit QY e he (e k) = D.splitFamily k from
            mapByCoordinates_basis QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily k hk1 hk]
      _ = e k := D.mapFromSplit_splitFamily QY e k hk1 hk
  exact linearMap_eq_self_of_fixes_basis QY.space (D.M + D.M) e he.isBasis _ hcomp hfix x

/-- 本文 `claim_map_to_split_after_map_from_split_is_identity`：すべての y ∈ V で θ(θ'(y)) = y。 -/
theorem mapToSplit_mapFromSplit (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (y : W × DualSpace D.spaceW) :
    D.mapToSplit QY e he (D.mapFromSplit QY e y) = y := by
  have hθ : IsComplexLinearMap QY.space D.space.space (D.mapToSplit QY e he) :=
    mapByCoordinates_isLinearMap QY.space D.space.space (D.M + D.M) e he.isBasis D.splitFamily
  have hθ' : IsComplexLinearMap D.space.space QY.space (D.mapFromSplit QY e) :=
    mapByCoordinates_isLinearMap D.space.space QY.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis
      (D.inverseFamily QY e)
  have hcomp : IsComplexLinearMap D.space.space D.space.space
      (fun y => D.mapToSplit QY e he (D.mapFromSplit QY e y)) :=
    IsComplexLinearMap.comp hθ' hθ
  have hfix : ∀ l : ℕ, 1 ≤ l → l ≤ D.M + D.M →
      D.mapToSplit QY e he (D.mapFromSplit QY e (D.splitBasis l)) = D.splitBasis l :=
    fun l hl1 hl => calc
      D.mapToSplit QY e he (D.mapFromSplit QY e (D.splitBasis l)) = D.mapToSplit QY e he (D.inverseFamily QY e l) := by
          rw [show D.mapFromSplit QY e (D.splitBasis l) = D.inverseFamily QY e l from
            mapByCoordinates_basis D.space.space QY.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis
              (D.inverseFamily QY e) l hl1 hl]
      _ = D.splitBasis l := D.mapToSplit_inverseFamily QY e he l hl1 hl
  exact linearMap_eq_self_of_fixes_basis D.space.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis _ hcomp hfix y

/-- 本文 `claim_map_from_split_quadratic_space_is_isometry`：θ' は (V, q) から (Y, Q) への等長写像である
（`claim_linear_right_inverse_of_isometry_is_isometry`）。 -/
theorem mapFromSplit_isIsometry (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry D.space.space QY.space D.space.form QY.form (D.mapFromSplit QY e) :=
  isIsometry_of_linear_rightInverse QY.space D.space.space QY.form D.space.form (D.mapToSplit QY e he)
    (D.mapFromSplit QY e) (D.mapToSplit_isIsometry QY e he)
    (mapByCoordinates_isLinearMap D.space.space QY.space (D.M + D.M) D.splitBasis D.splitBasis_isBasis
      (D.inverseFamily QY e))
    (D.mapToSplit_mapFromSplit QY e he)

/-! ### 系：一般の偶数次元の非退化な二次空間のクリフォード代数と行列環の同型 -/

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
の Φ_Y := Φ ∘ Cl(θ)。 -/
def homomorphismToMatrixOfGeneral (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl) : Mat (PowerSet D.M) :=
  D.homomorphismToMatrix
    (QuadraticSpaceWithBasis.inducedHom QY D.space (D.mapToSplit QY e he) (D.mapToSplit_isIsometry QY e he) a)

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
の Ψ_Y := Cl(θ') ∘ Ψ。 -/
def homomorphismFromMatrixOfGeneral (QY : Clifford.QuadraticSpaceWithBasis Y) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat (PowerSet D.M)) : QY.Cl :=
  QuadraticSpaceWithBasis.inducedHom D.space QY (D.mapFromSplit QY e) (D.mapFromSplit_isIsometry QY e he)
    (D.homomorphismFromMatrix F)

/-- 系の定理の本体：e が三つの条件を満たす任意の族のとき、Φ_Y と Ψ_Y は互いに逆な ℂ-代数の準同型である。
本文の定理は e := `orthonormalBasis` の場合（`generalCliffordAlgebra_isomorphic_matrixAlgebra`）。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family (QY : Clifford.QuadraticSpaceWithBasis Y)
    (e : ℕ → Y) (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.homomorphismToMatrixOfGeneral QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.homomorphismFromMatrixOfGeneral QY e he) ∧
      (∀ a : QY.Cl, D.homomorphismFromMatrixOfGeneral QY e he (D.homomorphismToMatrixOfGeneral QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.homomorphismToMatrixOfGeneral QY e he (D.homomorphismFromMatrixOfGeneral QY e he F) = F) ∧
      Function.Bijective (D.homomorphismToMatrixOfGeneral QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.homomorphismToMatrixOfGeneral QY e he a = F → a = D.homomorphismFromMatrixOfGeneral QY e he F) := by
  let θ := D.mapToSplit QY e he
  let θ' := D.mapFromSplit QY e
  let hθ := D.mapToSplit_isIsometry QY e he
  let hθ' := D.mapFromSplit_isIsometry QY e he
  let Clθ := QuadraticSpaceWithBasis.inducedHom QY D.space θ hθ
  let Clθ' := QuadraticSpaceWithBasis.inducedHom D.space QY θ' hθ'
  let Φ := D.homomorphismToMatrix
  let Ψ := D.homomorphismFromMatrix
  let ΦY := D.homomorphismToMatrixOfGeneral QY e he
  let ΨY := D.homomorphismFromMatrixOfGeneral QY e he
  -- Φ_Y と Ψ_Y は準同型の合成（`claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism`）
  have hΦY : IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra ΦY :=
    IsComplexAlgebraHomomorphism.comp (φ := Clθ) (ψ := Φ) (QuadraticSpaceWithBasis.inducedHom_isHom QY D.space θ hθ)
      D.homomorphismToMatrix_isHom
  have hΨY : IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra ΨY :=
    IsComplexAlgebraHomomorphism.comp (φ := Ψ) (ψ := Clθ') D.homomorphismFromMatrix_isHom
      (QuadraticSpaceWithBasis.inducedHom_isHom D.space QY θ' hθ')
  -- 一つ目の等式：Cl(θ')(Cl(θ)(a)) = a
  have h1 : ∀ a : QY.Cl, Clθ' (Clθ a) = a :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom QY D.space θ hθ θ' hθ' (D.mapFromSplit_mapToSplit QY e he)
  -- 二つ目の等式：Cl(θ)(Cl(θ')(X)) = X
  have h2 : ∀ X : D.space.Cl, Clθ (Clθ' X) = X :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom D.space QY θ' hθ' θ hθ (D.mapToSplit_mapFromSplit QY e he)
  have hΨΦ : ∀ a : QY.Cl, ΨY (ΦY a) = a := fun a => calc
    ΨY (ΦY a) = Clθ' (Ψ (Φ (Clθ a))) := rfl
    _ = Clθ' (Clθ a) := by rw [show Ψ (Φ (Clθ a)) = Clθ a from D.homomorphismFromMatrix_homomorphismToMatrix (Clθ a)]
    _ = a := h1 a
  have hΦΨ : ∀ F : Mat (PowerSet D.M), ΦY (ΨY F) = F := fun F => calc
    ΦY (ΨY F) = Φ (Clθ (Clθ' (Ψ F))) := rfl
    _ = Φ (Ψ F) := by rw [h2 (Ψ F)]
    _ = F := D.homomorphismToMatrix_homomorphismFromMatrix F
  -- 単射であること
  have hinj : Function.Injective ΦY := by
    intro a a' haa'
    calc a = ΨY (ΦY a) := (hΨΦ a).symm
      _ = ΨY (ΦY a') := by rw [haa']
      _ = a' := hΨΦ a'
  -- 全射であること
  have hsurj : Function.Surjective ΦY := fun F => ⟨ΨY F, hΦΨ F⟩
  -- Φ_Y^{-1}(F) = Ψ_Y(F)
  have hinv : ∀ (F : Mat (PowerSet D.M)) (a : QY.Cl), ΦY a = F → a = ΨY F := by
    intro F a ha
    apply hinj
    calc ΦY a = F := ha
      _ = ΦY (ΨY F) := (hΦΨ F).symm
  exact ⟨hΦY, hΨY, hΨΦ, hΦΨ, ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`：
e := `orthonormalBasis`（`def_orthonormal_basis_of_general_even_dimensional_space`）のとき、Φ_Y := Φ ∘ Cl(θ) と
Ψ_Y := Cl(θ') ∘ Ψ は ℂ-代数の準同型で、互いに逆であり、Φ_Y は全単射でその逆写像は Ψ_Y である。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra (QY : Clifford.QuadraticSpaceWithBasis Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis QY hdim hQ
    let he := D.orthonormalBasis_spec QY hdim hQ
    IsComplexAlgebraHomomorphism QY.cliffordAlgebra D.matrixAlgebra (D.homomorphismToMatrixOfGeneral QY e he) ∧
      IsComplexAlgebraHomomorphism D.matrixAlgebra QY.cliffordAlgebra (D.homomorphismFromMatrixOfGeneral QY e he) ∧
      (∀ a : QY.Cl, D.homomorphismFromMatrixOfGeneral QY e he (D.homomorphismToMatrixOfGeneral QY e he a) = a) ∧
      (∀ F : Mat (PowerSet D.M),
        D.homomorphismToMatrixOfGeneral QY e he (D.homomorphismFromMatrixOfGeneral QY e he F) = F) ∧
      Function.Bijective (D.homomorphismToMatrixOfGeneral QY e he) ∧
      (∀ (F : Mat (PowerSet D.M)) (a : QY.Cl),
        D.homomorphismToMatrixOfGeneral QY e he a = F → a = D.homomorphismFromMatrixOfGeneral QY e he F) :=
  D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family QY _ (D.orthonormalBasis_spec QY hdim hQ)

end

end CliffordMatrixIsomorphism.Clifford.SplitData
