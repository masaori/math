/-
章「同型の証明」の節「系：一般の偶数次元の非退化な二次空間」の後半（分裂した二次空間との等長写像と、系の定理）の必要十分版。
具体版 `Isomorphism/GeneralEvenDimensional/IsometryToSplitSpace.lean` と同じ def・structure・calc の行を、係数 ℂ を型の変数 K に、
-1_ℂ を K の元 n に替えて書く（V := W ⊕ W^* と Cl(V,q) は章「クリフォード代数」の必要十分版の前提の組 `CliffordLaws K n` で作る）。
K には演算の記号（`Add`・`Mul`・`Zero`・`One`・`Neg`、e を固定する定義だけ `Inv`）だけを与え、公理は仮定として渡す。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。具体版との違いは次の三つ。
- 虚数単位 i は K の元の変数 i に、i · i = -1 は仮定 `hi` になる（`def_imaginary_unit`・`claim_imaginary_unit_squares_to_minus_one`）。
- 2 の逆元 h は K の元の変数 h に、h が 1 + 1 の両側の乗法の逆元であることは仮定 `IsInverseOfTwo h` になる
  （`def_inverse_of_two_in_complex_numbers`）。
- 一般の非退化な二次空間の前提の組 `QuadraticSpaceWithBasis K Y` は「Q は二次形式」の欄を持たないので、Q が二次形式であることを
  仮定 `hQf` で渡す。非退化であることは e を固定する定義（`orthonormalBasis`）だけが使う。

主張ごとに使う K の性質（θ・θ' の主張は、V を線型空間にし基底 d を作るために、`CliffordLaws K n` の欄から n の三つの性質と
`ValuedMapsLaws` の六つの欄を除いた組 `SplitSpaceLaws K` を持ち、V は `spaceOf` で作る。系の定理は `CliffordLaws K n` を持ち、
`C.splitSpaceLaws` を渡す。下に書くのは、行の中で組の欄から使う性質と、足す仮定である）:

  splitBasis_first・splitBasis_second      なし（基底を並べた族の定め方だけ）
  negImaginaryUnit_mul_imaginaryUnit       i · i = -1、(-a) · b = -(a · b)、-(-a) = a
  form_splitFamily                         上の三つ、乗法の交換法則、a · 1 = a。k = m の場合は K の性質を使わない
  polarization_splitFamily                 a + (-a) = 0（q_W の偏極の値）、右分配法則、加法の交換法則（-i + i = 0 の行）、0 · a = 0、
                                           a + 0 = a、a · 0 = 0、加法の結合法則（偏極の対称性）。i · i = -1 は使わない
  mapToSplit_isIsometry                    form_splitFamily・polarization_splitFamily の性質、Q が二次形式であること、
                                           互いに直交する族の線型結合での二次形式の値の性質（加法の結合法則・交換法則、a + (-a) = 0、
                                           0 + a = a、a + 0 = a、a · 0 = 0、0 · a = 0）、係数の一意性の仮定の組（θ が線型）
  mapFromSplit_splitFamily                 i · i = -1・(-a) · b = -(a · b)・-(-a) = a（準備の一つ目）、乗法の交換法則・結合法則、
                                           右分配法則、a + (-a) = 0、加法の交換法則、0 · a = 0、h · (1+1) = 1 と (1+1) · h = 1、
                                           0 + 0 = 0、係数の一意性の仮定の組（θ' が線型で d_l を v_l へ移す）
  mapToSplit_inverseFamily                 i · i = -1・(-a) · b = -(a · b)・-(-a) = a、乗法の交換法則、a + (-a) = 0、h · (1+1) = 1、
                                           0 + 0 = 0・a · 0 = 0（零ベクトルのスカラー倍）、係数の一意性の仮定の組。(1+1) · h = 1 は使わない。
                                           e については基底であることだけを使う（直交と値が 1 は使わない）
  mapFromSplit_mapToSplit                  上の二つの和。e については基底であることだけを使う
  mapToSplit_mapFromSplit                  mapToSplit_inverseFamily の性質。(1+1) · h = 1 と、e の直交と値が 1 は使わない
  mapFromSplit_isIsometry                  mapToSplit_mapFromSplit と mapToSplit_isIsometry の和。(1+1) · h = 1 は使わない
  系の定理（generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family）
                                           上の全部と、主定理の仮定（`CliffordLaws K n` と a + (-a) = 0）
  orthonormalBasis・orthonormalBasis_spec  どの元での値も 1 の直交基底の存在の仮定の組 `OrthonormalBasisExistenceLaws`
                                           （直交基底の存在の性質・K の各元が平方根をもつこと・0 でない元の逆元・乗法の交換法則）
  系の定理（generalCliffordAlgebra_isomorphic_matrixAlgebra）
                                           上の二行の和

分かったこと:
- K の各元が平方根をもつこと（ℂ では ℝ の完備性への脱出）と、0 でない元の乗法の逆元と、Q の非退化性は、e を固定する段
  （`orthonormalBasis`）だけが使う。θ・v・θ' の主張と、等長写像が誘導する準同型で主定理を運ぶ段は、e が三つの条件
  （基底・直交・値が 1）を満たすことしか使わない。
- 2 の可逆性が要るのは逆向きの写像 θ' の族 v（h := (1+1)^{-1}）だけで、θ が等長写像であることには要らない。
  使うのは h · (1+1) = 1（v を θ へ通す二つの主張）と (1+1) · h = 1（θ'(u_{M+m}) の準備の四つ目）で、乗法の交換法則があれば一方から他方が出る。
- i · i = -1 は、族 u の各元での q の値が 1 であることと、θ・θ' が u・v を互いの基底へ移すことに要る。
  族 u の異なる二元が直交することは i · i = -1 を使わない（i が K のどの元でも成り立つ）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.OrthonormalBasis
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.GeneralEvenDimensional.InducedHomomorphism
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.MutuallyInverseHomomorphisms.MutuallyInverseHomomorphisms

namespace CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe uK v

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {Y : Type v}

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space` の e が満たす三つの条件の必要十分版。 -/
structure IsOrthonormalBasisFamily (S : VectorSpace K Y) (q : Y → K) (n : ℕ) (e : ℕ → Y) : Prop where
  isBasis : IsBasisFamily S n e
  orthogonal : ∀ k l : ℕ, 1 ≤ k → k ≤ n → 1 ≤ l → l ≤ n → k ≠ l → polarization S q (e k) (e l) = 0
  form_eq_one : ∀ k : ℕ, 1 ≤ k → k ≤ n → q (e k) = 1

omit [Zero K] [Neg K] in
/-- 本文 `def_inverse_of_two_in_complex_numbers` の必要十分版：h が 1 + 1 の両側の乗法の逆元であること。 -/
structure IsInverseOfTwo (h : K) : Prop where
  mul_two : h * (1 + 1) = 1
  two_mul : (1 + 1) * h = 1

omit [Add K] [Zero K] in
/-- 本文 `claim_negative_imaginary_unit_times_imaginary_unit_is_one` の必要十分版：(-i) · i = 1。 -/
theorem negImaginaryUnit_mul_imaginaryUnit (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) : (-i) * i = 1 := calc
  (-i) * i = -(i * i) := hneg_mul i i
  _ = -(-1) := by rw [hi]
  _ = 1 := hneg_neg 1

/-- 本文 `claim_existence_of_orthonormal_basis_for_nondegenerate_quadratic_form` の必要十分版の仮定の組
（`exists_orthonormal_basis` の仮定を一つにまとめたもの）。 -/
structure OrthonormalBasisExistenceLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] [Neg K] [Inv K] : Prop where
  orthogonalization : OrthogonalizationLaws K
  neg_mul : ∀ a b : K, (-a) * b = -(a * b)
  mul_one : ∀ a : K, a * 1 = a
  inv_mul : ∀ a : K, a ≠ 0 → a⁻¹ * a = 1
  mul_inv : ∀ a : K, a ≠ 0 → a * a⁻¹ = 1
  mul_comm : ∀ a b : K, a * b = b * a
  sqrt : ∀ z : K, ∃ s : K, s * s = z

end CliffordMatrixIsomorphism.NecSuf.VectorSpace

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
open CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra (PowerSet)
universe u v uK

/-- 番号 k ∈ {1,…,M+M} は、m ∈ {1,…,M} によって k = m か k = M + m のどちらかの形に書ける（本文の場合分け。ℂ を含まない）。 -/
theorem index_cases (M k : ℕ) (hk : k ≤ M + M) :
    k ≤ M ∨ ∃ m : ℕ, 1 ≤ m ∧ m ≤ M ∧ k = M + m := by
  by_cases h : k ≤ M
  · exact Or.inl h
  · exact Or.inr ⟨k - M, by omega, by omega, by omega⟩

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W) {Y : Type v}

/-- 系「一般の偶数次元」の等長写像 θ・θ' の主張が K に置く仮定：V := W ⊕ W^* を K-線型空間にし、その基底 d を作るのに
使う性質。章の仮定の組 `CliffordLaws K n` の欄のうち、n の三つの性質（1 + n = 0、n + 1 = 1 + n、n · n = 1）と、
`ValuedMapsLaws` の六つの欄（加法の結合法則・交換法則、a + 0 = a、加法の逆元の存在、1 · a = a、右分配法則。
同じ性質は係数の一意性の組 `UniquenessLaws` の欄にある）を除いたもの。 -/
structure SplitSpaceLaws (K : Type uK) [Add K] [Mul K] [One K] [Zero K] : Prop where
  uniqueness : UniquenessLaws K
  mul_comm : ∀ a b : K, a * b = b * a
  mul_assoc : ∀ a b c : K, (a * b) * c = a * (b * c)
  left_distrib : ∀ a b c : K, a * (b + c) = a * b + a * c

namespace SplitSpaceLaws

omit [Neg K] in
/-- 双対空間を線型空間にする性質は、どれもこの組の欄から出る（`CliffordLaws.dualSpaceVectorSpaceLaws` と同じ欄の当て方。
0 + 0 = 0 は a + 0 = a の a := 0）。 -/
theorem dualSpaceVectorSpaceLaws (L : SplitSpaceLaws K) : DualSpaceVectorSpaceLaws K where
  add_assoc := L.uniqueness.add_assoc
  add_comm := L.uniqueness.add_comm
  left_distrib := L.left_distrib
  mul_assoc := L.mul_assoc
  mul_comm := L.mul_comm
  zero_add_zero := L.uniqueness.add_zero 0
  mul_zero := L.uniqueness.mul_zero
  add_zero := L.uniqueness.add_zero
  exists_neg_one := L.uniqueness.exists_neg_one
  one_mul := L.uniqueness.one_mul
  right_distrib := L.uniqueness.right_distrib
  zero_mul := L.uniqueness.zero_mul

omit [Neg K] in
/-- a · 1 = a は、乗法の交換法則と 1 · a = a から出る。 -/
theorem mul_one (L : SplitSpaceLaws K) : ∀ a : K, a * 1 = a := fun a =>
  (L.mul_comm a 1).trans (L.uniqueness.one_mul a)

end SplitSpaceLaws

omit [Neg K] in
/-- 章の仮定の組から、この組の欄を取り出す。 -/
theorem _root_.CliffordMatrixIsomorphism.NecSuf.Clifford.CliffordLaws.splitSpaceLaws {n : K}
    (C : CliffordLaws K n) : SplitSpaceLaws K :=
  ⟨C.uniqueness, C.mul_comm, C.valuedMaps.mul_assoc, C.valuedMaps.left_distrib⟩

variable (L : SplitSpaceLaws K)

omit [Neg K] in
/-- 本文 `def_clifford_algebra_of_split_quadratic_space` の V := W ⊕ W^* と q_W の必要十分版を、`SplitSpaceLaws` から作ったもの
（`SplitData.space` と同じ欄の値。`SplitData.space C` とは、欄の証明だけが違うので定義により等しい）。 -/
def spaceOf : QuadraticSpaceWithBasis K (W × DualSpace D.spaceW) where
  space := splitSpace L.dualSpaceVectorSpaceLaws D.spaceW
  dim := D.M + D.M
  basis := concatenatedFamily D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f
  isBasis := concatenatedFamily_isBasisFamily D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.M D.w D.f
    L.dualSpaceVectorSpaceLaws.zero_add_zero L.dualSpaceVectorSpaceLaws.mul_zero D.isBasis
    (dualBasis_isBasis L.dualSpaceVectorSpaceLaws L.uniqueness.zero_add L.mul_one D.spaceW D.M D.w D.isBasis.spans D.f D.isDualBasis)
  form := splitQuadraticForm D.spaceW

/-! ### 分裂した二次空間の基底 d -/

/-- 本文 `def_setting_of_general_even_dimensional_corollary` の d の必要十分版。 -/
def splitBasis : ℕ → W × DualSpace D.spaceW := (D.spaceOf L).basis

omit [Neg K] in
/-- 本文 `def_setting_of_general_even_dimensional_corollary` の必要十分版：d は V の基底である。 -/
theorem splitBasis_isBasis : IsBasisFamily (D.spaceOf L).space (D.M + D.M) (D.splitBasis L) := (D.spaceOf L).isBasis

omit [Neg K] in
/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の一つ目の必要十分版。 -/
theorem splitBasis_first (m : ℕ) (hmM : m ≤ D.M) :
    D.splitBasis L m = embedFirst (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) (D.w m) := calc
  D.splitBasis L m
      = concatenatedFamily D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f m := rfl
  _ = embedFirst (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) (D.w m) :=
      concatenatedFamily_of_le D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f m hmM

omit [Neg K] in
/-- 本文 `claim_members_of_basis_of_split_space_in_general_even_dimensional_corollary` の二つ目の必要十分版。 -/
theorem splitBasis_second (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitBasis L (D.M + m) = embedSecond D.spaceW (D.f m) := calc
  D.splitBasis L (D.M + m)
      = concatenatedFamily D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f
          (D.M + m) := rfl
  _ = embedSecond D.spaceW (D.f m) :=
      concatenatedFamily_add D.spaceW (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW) D.M D.w D.f m hm1

/-! ### どの元での値も 1 の直交基底 e -/

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space` の必要十分版。存在は `exists_orthonormal_basis` の必要十分版。 -/
def orthonormalBasis [Inv K] (E : OrthonormalBasisExistenceLaws K) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) : ℕ → Y :=
  Classical.choose (exists_orthonormal_basis E.orthogonalization E.neg_mul E.mul_one E.inv_mul E.mul_inv E.mul_comm
    E.sqrt QY.space QY.form hQ (D.M + D.M) QY.basis (hdim ▸ QY.isBasis))

/-- 本文 `def_orthonormal_basis_of_general_even_dimensional_space` の必要十分版：固定した e は三つの条件を満たす。 -/
theorem orthonormalBasis_spec [Inv K] (E : OrthonormalBasisExistenceLaws K) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) (D.orthonormalBasis E QY hdim hQ) := by
  obtain ⟨h1, h2, h3⟩ := Classical.choose_spec (exists_orthonormal_basis E.orthogonalization E.neg_mul E.mul_one
    E.inv_mul E.mul_inv E.mul_comm E.sqrt QY.space QY.form hQ (D.M + D.M) QY.basis (hdim ▸ QY.isBasis))
  exact ⟨h1, h2, h3⟩

/-! ### 分裂した二次空間の族 u -/

/-- 本文 `def_family_in_split_space_for_isometry` の必要十分版。 -/
def splitFamily (i : K) (k : ℕ) : W × DualSpace D.spaceW :=
  if k ≤ D.M then (D.w k, D.f k)
  else (D.spaceW.smul (-i) (D.w (k - D.M)),
    (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW).smul i (D.f (k - D.M)))

/-- 本文 `def_family_in_split_space_for_isometry` の必要十分版：u_m = (w_m, f_m)。 -/
theorem splitFamily_first (i : K) (m : ℕ) (hmM : m ≤ D.M) : D.splitFamily L i m = (D.w m, D.f m) := by
  unfold splitFamily
  rw [if_pos hmM]

/-- 本文 `def_family_in_split_space_for_isometry` の必要十分版：u_{M+m} = ((-i) ·_W w_m, i ·_{W^*} f_m)。 -/
theorem splitFamily_second (i : K) (m : ℕ) (hm1 : 1 ≤ m) :
    D.splitFamily L i (D.M + m)
      = (D.spaceW.smul (-i) (D.w m), (dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW).smul i (D.f m)) := by
  unfold splitFamily
  rw [if_neg (by omega), Nat.add_sub_cancel_left]

omit [Add K] [Mul K] [Neg K] in
/-- 本文 `def_kronecker_delta` の必要十分版：δ_{m,m} = 1。 -/
theorem kroneckerDelta_self (m : ℕ) : (kroneckerDelta m m : K) = 1 := by
  unfold kroneckerDelta
  rw [if_pos rfl]

/-- 本文 `claim_quadratic_form_on_family_in_split_space_is_one` の必要十分版。 -/
theorem form_splitFamily (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a)
    (i : K) (hi : i * i = -1) (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) :
    (D.spaceOf L).form (D.splitFamily L i k) = 1 := by
  let SF := dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩
  · calc (D.spaceOf L).form (D.splitFamily L i k)
        = splitQuadraticForm D.spaceW (D.w k, D.f k) := by rw [D.splitFamily_first L i k hkM]; rfl
      _ = (D.f k).1 (D.w k) := rfl
      _ = kroneckerDelta k k := D.isDualBasis k k hk1 hkM hk1 hkM
      _ = 1 := kroneckerDelta_self k
  · calc (D.spaceOf L).form (D.splitFamily L i (D.M + m))
        = splitQuadraticForm D.spaceW (D.spaceW.smul (-i) (D.w m), SF.smul i (D.f m)) := by
          rw [D.splitFamily_second L i m hm1]; rfl
      _ = (SF.smul i (D.f m)).1 (D.spaceW.smul (-i) (D.w m)) := rfl
      _ = i * (D.f m).1 (D.spaceW.smul (-i) (D.w m)) := rfl
      _ = i * ((-i) * (D.f m).1 (D.w m)) := by rw [(D.f m).2.map_smul (-i) (D.w m)]
      _ = i * ((-i) * kroneckerDelta m m) := by rw [D.isDualBasis m m hm1 hmM hm1 hmM]
      _ = i * ((-i) * 1) := by rw [kroneckerDelta_self m]
      _ = i * (-i) := by rw [L.mul_one (-i)]
      _ = (-i) * i := L.mul_comm i (-i)
      _ = 1 := negImaginaryUnit_mul_imaginaryUnit hneg_mul hneg_neg i hi

/-- 本文 `claim_family_in_split_space_is_orthogonal` の二つ目の場合の必要十分版。i · i = -1 を使わない。 -/
theorem polarization_splitFamily_first_second (hneg : ∀ a : K, a + -a = 0) (i : K) (m m' : ℕ) (hm1 : 1 ≤ m)
    (hmM : m ≤ D.M) (hm'1 : 1 ≤ m') (hm'M : m' ≤ D.M) :
    polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i m) (D.splitFamily L i (D.M + m')) = 0 := by
  let SF := dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW
  have hδ : (kroneckerDelta m' m : K) = kroneckerDelta m m' := by
    unfold kroneckerDelta
    by_cases h : m = m'
    · rw [if_pos h.symm, if_pos h]
    · rw [if_neg (Ne.symm h), if_neg h]
  calc polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i m) (D.splitFamily L i (D.M + m'))
      = polarization (splitSpace L.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW) (D.w m, D.f m)
          (D.spaceW.smul (-i) (D.w m'), SF.smul i (D.f m')) := by
        rw [D.splitFamily_first L i m hmM, D.splitFamily_second L i m' hm'1]; rfl
    _ = (D.f m).1 (D.spaceW.smul (-i) (D.w m')) + (SF.smul i (D.f m')).1 (D.w m) :=
        polarization_splitQuadraticForm L.dualSpaceVectorSpaceLaws D.spaceW hneg _ _ _ _
    _ = (-i) * (D.f m).1 (D.w m') + (SF.smul i (D.f m')).1 (D.w m) := by
        rw [(D.f m).2.map_smul (-i) (D.w m')]
    _ = (-i) * (D.f m).1 (D.w m') + i * (D.f m').1 (D.w m) := rfl
    _ = (-i) * kroneckerDelta m m' + i * kroneckerDelta m' m := by
        rw [D.isDualBasis m m' hm1 hmM hm'1 hm'M, D.isDualBasis m' m hm'1 hm'M hm1 hmM]
    _ = (-i) * kroneckerDelta m m' + i * kroneckerDelta m m' := by rw [hδ]
    _ = ((-i) + i) * kroneckerDelta m m' := (L.uniqueness.right_distrib (-i) i (kroneckerDelta m m')).symm
    _ = 0 * kroneckerDelta m m' := by rw [L.uniqueness.add_comm (-i) i, hneg i]
    _ = 0 := L.uniqueness.zero_mul (kroneckerDelta m m')

/-- 本文 `claim_family_in_split_space_is_orthogonal` の必要十分版。i · i = -1 を使わない。 -/
theorem polarization_splitFamily (hneg : ∀ a : K, a + -a = 0) (i : K) (k l : ℕ) (hk1 : 1 ≤ k)
    (hk : k ≤ D.M + D.M) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M) (hkl : k ≠ l) :
    polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i k) (D.splitFamily L i l) = 0 := by
  let SF := dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩ <;>
    rcases index_cases D.M l hl with hlM | ⟨m', hm'1, hm'M, rfl⟩
  · calc polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i k) (D.splitFamily L i l)
        = polarization (splitSpace L.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW)
            (D.w k, D.f k) (D.w l, D.f l) := by
          rw [D.splitFamily_first L i k hkM, D.splitFamily_first L i l hlM]; rfl
      _ = (D.f k).1 (D.w l) + (D.f l).1 (D.w k) :=
          polarization_splitQuadraticForm L.dualSpaceVectorSpaceLaws D.spaceW hneg _ _ _ _
      _ = kroneckerDelta k l + kroneckerDelta l k := by
          rw [D.isDualBasis k l hk1 hkM hl1 hlM, D.isDualBasis l k hl1 hlM hk1 hkM]
      _ = 0 + 0 := by unfold kroneckerDelta; rw [if_neg hkl, if_neg (Ne.symm hkl)]
      _ = 0 := L.uniqueness.add_zero 0
  · exact D.polarization_splitFamily_first_second L hneg i k m' hk1 hkM hm'1 hm'M
  · calc polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i (D.M + m)) (D.splitFamily L i l)
        = polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i l) (D.splitFamily L i (D.M + m)) :=
          polarization_symm L.uniqueness.add_assoc L.uniqueness.add_comm (D.spaceOf L).space (D.spaceOf L).form _ _
      _ = 0 := D.polarization_splitFamily_first_second L hneg i l m hl1 hlM hm1 hmM
  · have hmm' : m ≠ m' := fun h => hkl (by rw [h])
    calc polarization (D.spaceOf L).space (D.spaceOf L).form (D.splitFamily L i (D.M + m))
          (D.splitFamily L i (D.M + m'))
        = polarization (splitSpace L.dualSpaceVectorSpaceLaws D.spaceW) (splitQuadraticForm D.spaceW)
            (D.spaceW.smul (-i) (D.w m), SF.smul i (D.f m))
            (D.spaceW.smul (-i) (D.w m'), SF.smul i (D.f m')) := by
          rw [D.splitFamily_second L i m hm1, D.splitFamily_second L i m' hm'1]; rfl
      _ = (SF.smul i (D.f m)).1 (D.spaceW.smul (-i) (D.w m')) + (SF.smul i (D.f m')).1 (D.spaceW.smul (-i) (D.w m)) :=
          polarization_splitQuadraticForm L.dualSpaceVectorSpaceLaws D.spaceW hneg _ _ _ _
      _ = i * (D.f m).1 (D.spaceW.smul (-i) (D.w m')) + i * (D.f m').1 (D.spaceW.smul (-i) (D.w m)) := rfl
      _ = i * ((-i) * (D.f m).1 (D.w m')) + i * ((-i) * (D.f m').1 (D.w m)) := by
          rw [(D.f m).2.map_smul (-i) (D.w m'), (D.f m').2.map_smul (-i) (D.w m)]
      _ = i * ((-i) * kroneckerDelta m m') + i * ((-i) * kroneckerDelta m' m) := by
          rw [D.isDualBasis m m' hm1 hmM hm'1 hm'M, D.isDualBasis m' m hm'1 hm'M hm1 hmM]
      _ = i * ((-i) * 0) + i * ((-i) * 0) := by unfold kroneckerDelta; rw [if_neg hmm', if_neg (Ne.symm hmm')]
      _ = i * 0 + i * 0 := by rw [L.uniqueness.mul_zero (-i)]
      _ = 0 + 0 := by rw [L.uniqueness.mul_zero i]
      _ = 0 := L.uniqueness.add_zero 0

/-! ### 一般の非退化な二次空間から分裂した二次空間への写像 θ -/

/-- 本文 `def_map_to_split_quadratic_space` の必要十分版：θ := L_{e,u}。 -/
def mapToSplit (i : K) (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y)
    (hb : IsBasisFamily QY.space (D.M + D.M) e) (x : Y) : W × DualSpace D.spaceW :=
  mapByCoordinates QY.space (D.spaceOf L).space (D.M + D.M) e hb (D.splitFamily L i) x

/-- 本文 `claim_map_to_split_quadratic_space_is_isometry` の必要十分版。Q が二次形式であること `hQf` を仮定に置く。 -/
theorem mapToSplit_isIsometry (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry QY.space (D.spaceOf L).space QY.form (D.spaceOf L).form (D.mapToSplit L i QY e he.isBasis) where
  isQuadraticForm := hQf
  isQuadraticForm' := splitQuadraticForm_isQuadraticForm L.dualSpaceVectorSpaceLaws D.spaceW hneg
  isLinearMap := mapByCoordinates_isLinearMap L.uniqueness QY.space (D.spaceOf L).space (D.M + D.M) e he.isBasis
    (D.splitFamily L i)
  map_form x := by
    let ν : ℕ → K := fun k => coordinate QY.space (D.M + D.M) e he.isBasis k x
    calc (D.spaceOf L).form (D.mapToSplit L i QY e he.isBasis x)
        = (D.spaceOf L).form (linearCombination (D.spaceOf L).space (D.M + D.M) ν (D.splitFamily L i)) := rfl
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * (D.spaceOf L).form (D.splitFamily L i k))) :=
          quadraticForm_linearCombination_orthogonal L.uniqueness.add_assoc L.uniqueness.add_comm hneg
            L.uniqueness.zero_add L.uniqueness.add_zero L.uniqueness.mul_zero L.uniqueness.zero_mul
            (D.spaceOf L).space (D.spaceOf L).form
            (splitQuadraticForm_isQuadraticForm L.dualSpaceVectorSpaceLaws D.spaceW hneg) (D.M + D.M)
            (D.splitFamily L i) (D.polarization_splitFamily L hneg i) ν
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * 1)) :=
          orderedSum_congr (D.M + D.M) _ _ fun k hk1 hk => by
            rw [D.form_splitFamily L hneg_mul hneg_neg i hi k hk1 hk]
      _ = orderedSum (D.M + D.M) (fun k => ν k * (ν k * QY.form (e k))) :=
          orderedSum_congr (D.M + D.M) _ _ fun k hk1 hk => by rw [he.form_eq_one k hk1 hk]
      _ = QY.form (linearCombination QY.space (D.M + D.M) ν e) :=
          (quadraticForm_linearCombination_orthogonal L.uniqueness.add_assoc L.uniqueness.add_comm hneg
            L.uniqueness.zero_add L.uniqueness.add_zero L.uniqueness.mul_zero L.uniqueness.zero_mul
            QY.space QY.form hQf (D.M + D.M) e he.orthogonal ν).symm
      _ = QY.form x := by rw [linearCombination_coordinate QY.space (D.M + D.M) e he.isBasis x]

/-! ### 逆向きの写像 θ' -/

/-- 本文 `def_family_in_general_space_for_inverse_isometry` の必要十分版。 -/
def inverseFamily (i h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y) (k : ℕ) : Y :=
  if k ≤ D.M then QY.space.smul h (QY.space.add (e k) (QY.space.smul i (e (D.M + k))))
  else QY.space.smul h (QY.space.add (e (k - D.M)) (QY.space.smul (-i) (e (D.M + (k - D.M)))))

/-- 本文 `def_family_in_general_space_for_inverse_isometry` の必要十分版：v_m。 -/
theorem inverseFamily_first (i h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y) (m : ℕ)
    (hmM : m ≤ D.M) :
    D.inverseFamily i h QY e m = QY.space.smul h (QY.space.add (e m) (QY.space.smul i (e (D.M + m)))) := by
  unfold inverseFamily
  rw [if_pos hmM]

/-- 本文 `def_family_in_general_space_for_inverse_isometry` の必要十分版：v_{M+m}。 -/
theorem inverseFamily_second (i h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y) (m : ℕ)
    (hm1 : 1 ≤ m) :
    D.inverseFamily i h QY e (D.M + m)
      = QY.space.smul h (QY.space.add (e m) (QY.space.smul (-i) (e (D.M + m)))) := by
  unfold inverseFamily
  rw [if_neg (by omega), Nat.add_sub_cancel_left]

/-- 本文 `def_map_from_split_quadratic_space` の必要十分版：θ' := L_{d,v}。 -/
def mapFromSplit (i h : K) (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y) (y : W × DualSpace D.spaceW) : Y :=
  mapByCoordinates (D.spaceOf L).space QY.space (D.M + D.M) (D.splitBasis L) (D.splitBasis_isBasis L)
    (D.inverseFamily i h QY e) y

/-- 本文 `claim_map_from_split_quadratic_space_sends_family_to_orthonormal_basis` の必要十分版。 -/
theorem mapFromSplit_splitFamily (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : IsInverseOfTwo h)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y) (k : ℕ) (hk1 : 1 ≤ k) (hk : k ≤ D.M + D.M) :
    D.mapFromSplit L i h QY e (D.splitFamily L i k) = e k := by
  let SY := QY.space
  let SV := (D.spaceOf L).space
  let SF := dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW
  let θ' := D.mapFromSplit L i h QY e
  let v := D.inverseFamily i h QY e
  have h00 : (0 : K) + 0 = 0 := L.uniqueness.add_zero 0
  have hθ' : IsLinearMap SV SY θ' :=
    mapByCoordinates_isLinearMap L.uniqueness SV SY (D.M + D.M) (D.splitBasis L) (D.splitBasis_isBasis L) v
  have hθ'd : ∀ l : ℕ, 1 ≤ l → l ≤ D.M + D.M → θ' (D.splitBasis L l) = v l :=
    fun l hl1 hl => mapByCoordinates_basis L.uniqueness SV SY (D.M + D.M) (D.splitBasis L) (D.splitBasis_isBasis L) v
      l hl1 hl
  have hp1 : (-i) * i = 1 := negImaginaryUnit_mul_imaginaryUnit hneg_mul hneg_neg i hi
  have hp2 : i * (-i) = 1 := by rw [L.mul_comm i (-i)]; exact hp1
  have hp3 : (-i) * h + i * h = 0 := calc
    (-i) * h + i * h = ((-i) + i) * h := (L.uniqueness.right_distrib (-i) i h).symm
    _ = 0 * h := by rw [L.uniqueness.add_comm (-i) i, hneg i]
    _ = 0 := L.uniqueness.zero_mul h
  have hp4 : ((-i) * h) * i + (i * h) * (-i) = 1 := calc
    ((-i) * h) * i + (i * h) * (-i) = (-i) * (h * i) + i * (h * (-i)) := by
        rw [L.mul_assoc (-i) h i, L.mul_assoc i h (-i)]
    _ = (-i) * (i * h) + i * ((-i) * h) := by rw [L.mul_comm h i, L.mul_comm h (-i)]
    _ = ((-i) * i) * h + (i * (-i)) * h := by
        rw [L.mul_assoc (-i) i h, L.mul_assoc i (-i) h]
    _ = 1 * h + 1 * h := by rw [hp1, hp2]
    _ = (1 + 1) * h := (L.uniqueness.right_distrib 1 1 h).symm
    _ = 1 := hh.two_mul
  rcases index_cases D.M k hk with hkM | ⟨m, hm1, hmM, rfl⟩
  · let e' := e (D.M + k)
    have hu : D.splitFamily L i k = SV.add (D.splitBasis L k) (D.splitBasis L (D.M + k)) := calc
      D.splitFamily L i k = (D.w k, D.f k) := D.splitFamily_first L i k hkM
      _ = SV.add (embedFirst SF (D.w k)) (embedSecond D.spaceW (D.f k)) :=
          pair_eq_add_embed D.spaceW SF (D.w k) (D.f k)
      _ = SV.add (D.splitBasis L k) (D.splitBasis L (D.M + k)) := by
          rw [D.splitBasis_first L k hkM, D.splitBasis_second L k hk1]
    calc θ' (D.splitFamily L i k)
        = θ' (SV.add (D.splitBasis L k) (D.splitBasis L (D.M + k))) := by rw [hu]
      _ = SY.add (θ' (D.splitBasis L k)) (θ' (D.splitBasis L (D.M + k))) := hθ'.map_add _ _
      _ = SY.add (v k) (v (D.M + k)) := by rw [hθ'd k hk1 (by omega), hθ'd (D.M + k) (by omega) (by omega)]
      _ = SY.add (SY.smul h (SY.add (e k) (SY.smul i e'))) (SY.smul h (SY.add (e k) (SY.smul (-i) e'))) := by
          rw [show v k = _ from D.inverseFamily_first i h QY e k hkM,
            show v (D.M + k) = _ from D.inverseFamily_second i h QY e k hk1]
      _ = SY.smul h (SY.add (SY.add (e k) (SY.smul i e')) (SY.add (e k) (SY.smul (-i) e'))) :=
          (SY.smul_add h _ _).symm
      _ = SY.smul h (SY.add (SY.add (e k) (e k)) (SY.add (SY.smul i e') (SY.smul (-i) e'))) := by
          rw [rearrange_sum_of_two_sums SY (e k) (SY.smul i e') (e k) (SY.smul (-i) e')]
      _ = SY.smul h (SY.add (SY.add (SY.smul 1 (e k)) (SY.smul 1 (e k))) (SY.add (SY.smul i e') (SY.smul (-i) e'))) := by
          rw [SY.one_smul (e k)]
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) (SY.smul (i + -i) e')) := by
          rw [SY.add_smul 1 1 (e k), SY.add_smul i (-i) e']
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) (SY.smul 0 e')) := by rw [hneg i]
      _ = SY.smul h (SY.add (SY.smul (1 + 1) (e k)) SY.zero) := by rw [zero_smul_eq_zero SY h00 e']
      _ = SY.smul h (SY.smul (1 + 1) (e k)) := by rw [SY.add_zero (SY.smul (1 + 1) (e k))]
      _ = SY.smul (h * (1 + 1)) (e k) := (SY.smul_assoc h (1 + 1) (e k)).symm
      _ = SY.smul 1 (e k) := by rw [hh.mul_two]
      _ = e k := SY.one_smul (e k)
  · let e' := e (D.M + m)
    have hu : D.splitFamily L i (D.M + m)
        = SV.add (SV.smul (-i) (D.splitBasis L m)) (SV.smul i (D.splitBasis L (D.M + m))) := calc
      D.splitFamily L i (D.M + m) = (D.spaceW.smul (-i) (D.w m), SF.smul i (D.f m)) :=
          D.splitFamily_second L i m hm1
      _ = SV.add (embedFirst SF (D.spaceW.smul (-i) (D.w m))) (embedSecond D.spaceW (SF.smul i (D.f m))) :=
          pair_eq_add_embed D.spaceW SF _ _
      _ = SV.add (SV.smul (-i) (embedFirst SF (D.w m))) (SV.smul i (embedSecond D.spaceW (D.f m))) := by
          rw [(embedFirst_isLinearMap D.spaceW SF h00 L.uniqueness.mul_zero).map_smul (-i) (D.w m),
            (embedSecond_isLinearMap D.spaceW SF h00 L.uniqueness.mul_zero).map_smul i (D.f m)]; rfl
      _ = SV.add (SV.smul (-i) (D.splitBasis L m)) (SV.smul i (D.splitBasis L (D.M + m))) := by
          rw [D.splitBasis_first L m hmM, D.splitBasis_second L m hm1]
    calc θ' (D.splitFamily L i (D.M + m))
        = θ' (SV.add (SV.smul (-i) (D.splitBasis L m)) (SV.smul i (D.splitBasis L (D.M + m)))) := by rw [hu]
      _ = SY.add (θ' (SV.smul (-i) (D.splitBasis L m))) (θ' (SV.smul i (D.splitBasis L (D.M + m)))) :=
          hθ'.map_add _ _
      _ = SY.add (SY.smul (-i) (θ' (D.splitBasis L m))) (SY.smul i (θ' (D.splitBasis L (D.M + m)))) := by
          rw [hθ'.map_smul (-i) (D.splitBasis L m), hθ'.map_smul i (D.splitBasis L (D.M + m))]
      _ = SY.add (SY.smul (-i) (v m)) (SY.smul i (v (D.M + m))) := by
          rw [hθ'd m hm1 (by omega), hθ'd (D.M + m) (by omega) (by omega)]
      _ = SY.add (SY.smul (-i) (SY.smul h (SY.add (e m) (SY.smul i e'))))
            (SY.smul i (SY.smul h (SY.add (e m) (SY.smul (-i) e')))) := by
          rw [show v m = _ from D.inverseFamily_first i h QY e m hmM,
            show v (D.M + m) = _ from D.inverseFamily_second i h QY e m hm1]
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
      _ = SY.add SY.zero (SY.smul 1 e') := by rw [zero_smul_eq_zero SY h00 (e m)]
      _ = SY.add SY.zero e' := by rw [SY.one_smul e']
      _ = SY.add e' SY.zero := SY.add_comm SY.zero e'
      _ = e' := SY.add_zero e'

/-- 本文 `claim_map_to_split_quadratic_space_sends_family_to_basis` の必要十分版。(1+1) · h = 1 は使わない。 -/
theorem mapToSplit_inverseFamily (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh2 : h * (1 + 1) = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y)
    (hb : IsBasisFamily QY.space (D.M + D.M) e) (l : ℕ) (hl1 : 1 ≤ l) (hl : l ≤ D.M + D.M) :
    D.mapToSplit L i QY e hb (D.inverseFamily i h QY e l) = D.splitBasis L l := by
  let SY := QY.space
  let SW := D.spaceW
  let SF := dualSpaceVectorSpace L.dualSpaceVectorSpaceLaws D.spaceW
  let SV := (D.spaceOf L).space
  let θ := D.mapToSplit L i QY e hb
  have h00 : (0 : K) + 0 = 0 := L.uniqueness.add_zero 0
  have hθ : IsLinearMap SY SV θ :=
    mapByCoordinates_isLinearMap L.uniqueness SY SV (D.M + D.M) e hb (D.splitFamily L i)
  have hθe : ∀ k : ℕ, 1 ≤ k → k ≤ D.M + D.M → θ (e k) = D.splitFamily L i k :=
    fun k hk1 hk => mapByCoordinates_basis L.uniqueness SY SV (D.M + D.M) e hb (D.splitFamily L i) k hk1 hk
  have hp1 : (-i) * i = 1 := negImaginaryUnit_mul_imaginaryUnit hneg_mul hneg_neg i hi
  have hp2 : i * (-i) = 1 := by rw [L.mul_comm i (-i)]; exact hp1
  have hp5 : (-i) * (-i) = -1 := calc
    (-i) * (-i) = -(i * (-i)) := hneg_mul i (-i)
    _ = -1 := by rw [hp2]
  rcases index_cases D.M l hl with hlM | ⟨m, hm1, hmM, rfl⟩
  · let e' := e (D.M + l)
    calc θ (D.inverseFamily i h QY e l)
        = θ (SY.smul h (SY.add (e l) (SY.smul i e'))) := by rw [D.inverseFamily_first i h QY e l hlM]
      _ = SV.smul h (θ (SY.add (e l) (SY.smul i e'))) := hθ.map_smul _ _
      _ = SV.smul h (SV.add (θ (e l)) (θ (SY.smul i e'))) := by rw [hθ.map_add (e l) (SY.smul i e')]
      _ = SV.smul h (SV.add (θ (e l)) (SV.smul i (θ e'))) := by rw [hθ.map_smul i e']
      _ = SV.smul h (SV.add (D.splitFamily L i l) (SV.smul i (D.splitFamily L i (D.M + l)))) := by
          rw [hθe l hl1 (by omega), hθe (D.M + l) (by omega) (by omega)]
      _ = SV.smul h (SV.add (D.w l, D.f l) (SV.smul i (SW.smul (-i) (D.w l), SF.smul i (D.f l)))) := by
          rw [D.splitFamily_first L i l hlM, D.splitFamily_second L i l hl1]
      _ = SV.smul h (SV.add (D.w l, D.f l) (SW.smul i (SW.smul (-i) (D.w l)), SF.smul i (SF.smul i (D.f l)))) := rfl
      _ = SV.smul h (SW.add (D.w l) (SW.smul i (SW.smul (-i) (D.w l))),
            SF.add (D.f l) (SF.smul i (SF.smul i (D.f l)))) := rfl
      _ = SV.smul h (SW.add (D.w l) (SW.smul (i * (-i)) (D.w l)), SF.add (D.f l) (SF.smul (i * i) (D.f l))) := by
          rw [SW.smul_assoc i (-i) (D.w l), SF.smul_assoc i i (D.f l)]
      _ = SV.smul h (SW.add (D.w l) (SW.smul 1 (D.w l)), SF.add (D.f l) (SF.smul (i * i) (D.f l))) := by rw [hp2]
      _ = SV.smul h (SW.add (D.w l) (SW.smul 1 (D.w l)), SF.add (D.f l) (SF.smul (-1) (D.f l))) := by rw [hi]
      _ = SV.smul h (SW.add (SW.smul 1 (D.w l)) (SW.smul 1 (D.w l)), SF.add (SF.smul 1 (D.f l)) (SF.smul (-1) (D.f l))) := by
          rw [SW.one_smul (D.w l), SF.one_smul (D.f l)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.smul (1 + -1) (D.f l)) := by
          rw [SW.add_smul 1 1 (D.w l), SF.add_smul 1 (-1) (D.f l)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.smul 0 (D.f l)) := by rw [hneg (1 : K)]
      _ = SV.smul h (SW.smul (1 + 1) (D.w l), SF.zero) := by rw [zero_smul_eq_zero SF h00 (D.f l)]
      _ = (SW.smul h (SW.smul (1 + 1) (D.w l)), SF.smul h SF.zero) := rfl
      _ = (SW.smul (h * (1 + 1)) (D.w l), SF.smul h SF.zero) := by rw [SW.smul_assoc h (1 + 1) (D.w l)]
      _ = (SW.smul (h * (1 + 1)) (D.w l), SF.zero) := by rw [smul_zero_eq_zero SF h00 L.uniqueness.mul_zero h]
      _ = (SW.smul 1 (D.w l), SF.zero) := by rw [hh2]
      _ = (D.w l, SF.zero) := by rw [SW.one_smul (D.w l)]
      _ = embedFirst SF (D.w l) := rfl
      _ = D.splitBasis L l := (D.splitBasis_first L l hlM).symm
  · let e' := e (D.M + m)
    calc θ (D.inverseFamily i h QY e (D.M + m))
        = θ (SY.smul h (SY.add (e m) (SY.smul (-i) e'))) := by rw [D.inverseFamily_second i h QY e m hm1]
      _ = SV.smul h (θ (SY.add (e m) (SY.smul (-i) e'))) := hθ.map_smul _ _
      _ = SV.smul h (SV.add (θ (e m)) (θ (SY.smul (-i) e'))) := by rw [hθ.map_add (e m) (SY.smul (-i) e')]
      _ = SV.smul h (SV.add (θ (e m)) (SV.smul (-i) (θ e'))) := by rw [hθ.map_smul (-i) e']
      _ = SV.smul h (SV.add (D.splitFamily L i m) (SV.smul (-i) (D.splitFamily L i (D.M + m)))) := by
          rw [hθe m hm1 (by omega), hθe (D.M + m) (by omega) (by omega)]
      _ = SV.smul h (SV.add (D.w m, D.f m) (SV.smul (-i) (SW.smul (-i) (D.w m), SF.smul i (D.f m)))) := by
          rw [D.splitFamily_first L i m hmM, D.splitFamily_second L i m hm1]
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
          rw [hp1]
      _ = SV.smul h (SW.add (SW.smul 1 (D.w m)) (SW.smul (-1) (D.w m)), SF.add (SF.smul 1 (D.f m)) (SF.smul 1 (D.f m))) := by
          rw [SW.one_smul (D.w m), SF.one_smul (D.f m)]
      _ = SV.smul h (SW.smul (1 + -1) (D.w m), SF.smul (1 + 1) (D.f m)) := by
          rw [SW.add_smul 1 (-1) (D.w m), SF.add_smul 1 1 (D.f m)]
      _ = SV.smul h (SW.smul 0 (D.w m), SF.smul (1 + 1) (D.f m)) := by rw [hneg (1 : K)]
      _ = SV.smul h (SW.zero, SF.smul (1 + 1) (D.f m)) := by rw [zero_smul_eq_zero SW h00 (D.w m)]
      _ = (SW.smul h SW.zero, SF.smul h (SF.smul (1 + 1) (D.f m))) := rfl
      _ = (SW.zero, SF.smul h (SF.smul (1 + 1) (D.f m))) := by
          rw [smul_zero_eq_zero SW h00 L.uniqueness.mul_zero h]
      _ = (SW.zero, SF.smul (h * (1 + 1)) (D.f m)) := by rw [SF.smul_assoc h (1 + 1) (D.f m)]
      _ = (SW.zero, SF.smul 1 (D.f m)) := by rw [hh2]
      _ = (SW.zero, D.f m) := by rw [SF.one_smul (D.f m)]
      _ = embedSecond SW (D.f m) := rfl
      _ = D.splitBasis L (D.M + m) := (D.splitBasis_second L m hm1).symm

/-- 本文 `claim_map_from_split_after_map_to_split_is_identity` の必要十分版。 -/
theorem mapFromSplit_mapToSplit (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : IsInverseOfTwo h)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y)
    (hb : IsBasisFamily QY.space (D.M + D.M) e) (x : Y) :
    D.mapFromSplit L i h QY e (D.mapToSplit L i QY e hb x) = x := by
  have hθ : IsLinearMap QY.space (D.spaceOf L).space (D.mapToSplit L i QY e hb) :=
    mapByCoordinates_isLinearMap L.uniqueness QY.space (D.spaceOf L).space (D.M + D.M) e hb (D.splitFamily L i)
  have hθ' : IsLinearMap (D.spaceOf L).space QY.space (D.mapFromSplit L i h QY e) :=
    mapByCoordinates_isLinearMap L.uniqueness (D.spaceOf L).space QY.space (D.M + D.M) (D.splitBasis L)
      (D.splitBasis_isBasis L) (D.inverseFamily i h QY e)
  have hcomp : IsLinearMap QY.space QY.space (fun x => D.mapFromSplit L i h QY e (D.mapToSplit L i QY e hb x)) :=
    IsLinearMap.comp hθ hθ'
  have hfix : ∀ k : ℕ, 1 ≤ k → k ≤ D.M + D.M →
      D.mapFromSplit L i h QY e (D.mapToSplit L i QY e hb (e k)) = e k :=
    fun k hk1 hk => calc
      D.mapFromSplit L i h QY e (D.mapToSplit L i QY e hb (e k)) = D.mapFromSplit L i h QY e (D.splitFamily L i k) := by
          rw [show D.mapToSplit L i QY e hb (e k) = D.splitFamily L i k from
            mapByCoordinates_basis L.uniqueness QY.space (D.spaceOf L).space (D.M + D.M) e hb (D.splitFamily L i)
              k hk1 hk]
      _ = e k := D.mapFromSplit_splitFamily L hneg hneg_mul hneg_neg i hi h hh QY e k hk1 hk
  exact linearMap_eq_self_of_fixes_basis QY.space (L.uniqueness.add_zero 0) (D.M + D.M) e hb.spans _ hcomp hfix x

/-- 本文 `claim_map_to_split_after_map_from_split_is_identity` の必要十分版。 -/
theorem mapToSplit_mapFromSplit (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh2 : h * (1 + 1) = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (e : ℕ → Y)
    (hb : IsBasisFamily QY.space (D.M + D.M) e) (y : W × DualSpace D.spaceW) :
    D.mapToSplit L i QY e hb (D.mapFromSplit L i h QY e y) = y := by
  have hθ : IsLinearMap QY.space (D.spaceOf L).space (D.mapToSplit L i QY e hb) :=
    mapByCoordinates_isLinearMap L.uniqueness QY.space (D.spaceOf L).space (D.M + D.M) e hb (D.splitFamily L i)
  have hθ' : IsLinearMap (D.spaceOf L).space QY.space (D.mapFromSplit L i h QY e) :=
    mapByCoordinates_isLinearMap L.uniqueness (D.spaceOf L).space QY.space (D.M + D.M) (D.splitBasis L)
      (D.splitBasis_isBasis L) (D.inverseFamily i h QY e)
  have hcomp : IsLinearMap (D.spaceOf L).space (D.spaceOf L).space
      (fun y => D.mapToSplit L i QY e hb (D.mapFromSplit L i h QY e y)) :=
    IsLinearMap.comp hθ' hθ
  have hfix : ∀ l : ℕ, 1 ≤ l → l ≤ D.M + D.M →
      D.mapToSplit L i QY e hb (D.mapFromSplit L i h QY e (D.splitBasis L l)) = D.splitBasis L l :=
    fun l hl1 hl => calc
      D.mapToSplit L i QY e hb (D.mapFromSplit L i h QY e (D.splitBasis L l))
          = D.mapToSplit L i QY e hb (D.inverseFamily i h QY e l) := by
          rw [show D.mapFromSplit L i h QY e (D.splitBasis L l) = D.inverseFamily i h QY e l from
            mapByCoordinates_basis L.uniqueness (D.spaceOf L).space QY.space (D.M + D.M) (D.splitBasis L)
              (D.splitBasis_isBasis L) (D.inverseFamily i h QY e) l hl1 hl]
      _ = D.splitBasis L l := D.mapToSplit_inverseFamily L hneg hneg_mul hneg_neg i hi h hh2 QY e hb l hl1 hl
  exact linearMap_eq_self_of_fixes_basis (D.spaceOf L).space (L.uniqueness.add_zero 0) (D.M + D.M) (D.splitBasis L)
    (D.splitBasis_isBasis L).spans _ hcomp hfix y

/-- 本文 `claim_map_from_split_quadratic_space_is_isometry` の必要十分版。(1+1) · h = 1 は使わない。 -/
theorem mapFromSplit_isIsometry (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh2 : h * (1 + 1) = 1)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    IsIsometry (D.spaceOf L).space QY.space (D.spaceOf L).form QY.form (D.mapFromSplit L i h QY e) :=
  isIsometry_of_linear_rightInverse QY.space (D.spaceOf L).space QY.form (D.spaceOf L).form
    (D.mapToSplit L i QY e he.isBasis) (D.mapFromSplit L i h QY e)
    (D.mapToSplit_isIsometry L hneg hneg_mul hneg_neg i hi QY hQf e he).isQuadraticForm
    (D.mapToSplit_isIsometry L hneg hneg_mul hneg_neg i hi QY hQf e he).isQuadraticForm'
    (D.mapToSplit_isIsometry L hneg hneg_mul hneg_neg i hi QY hQf e he).map_form
    (mapByCoordinates_isLinearMap L.uniqueness (D.spaceOf L).space QY.space (D.M + D.M) (D.splitBasis L)
      (D.splitBasis_isBasis L) (D.inverseFamily i h QY e))
    (D.mapToSplit_mapFromSplit L hneg hneg_mul hneg_neg i hi h hh2 QY e he.isBasis)

/-! ### 系：一般の偶数次元の非退化な二次空間のクリフォード代数と行列環の同型 -/

/-- 本文の系の定理の Φ_Y := Φ ∘ Cl(θ) の必要十分版。誘導される準同型の必要十分版は、θ が線型であることと
q(θ(x)) = Q(x) だけを引数にとる。 -/
def homomorphismToMatrixOfGeneral (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (a : QY.Cl C) : Mat K (PowerSet D.M) :=
  D.homomorphismToMatrix C hneg
    (QuadraticSpaceWithBasis.inducedHom C hneg QY (D.space C) (D.mapToSplit C.splitSpaceLaws i QY e he.isBasis)
      (D.mapToSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi QY hQf e he).isLinearMap
      (D.mapToSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi QY hQf e he).map_form a)

/-- 本文の系の定理の Ψ_Y := Cl(θ') ∘ Ψ の必要十分版。 -/
def homomorphismFromMatrixOfGeneral (hneg : ∀ a : K, a + -a = 0) (hneg_mul : ∀ a b : K, (-a) * b = -(a * b))
    (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1) (h : K) (hh : IsInverseOfTwo h)
    (QY : Clifford.QuadraticSpaceWithBasis K Y) (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) (F : Mat K (PowerSet D.M)) : QY.Cl C :=
  QuadraticSpaceWithBasis.inducedHom C hneg (D.space C) QY (D.mapFromSplit C.splitSpaceLaws i h QY e)
    (D.mapFromSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi h hh.mul_two QY hQf e he).isLinearMap
    (D.mapFromSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi h hh.mul_two QY hQf e he).map_form
    (D.homomorphismFromMatrix C F)

/-- 系の定理の本体の必要十分版：e が三つの条件を満たす任意の族のとき、Φ_Y と Ψ_Y は互いに逆な K-代数の準同型である。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family (hneg : ∀ a : K, a + -a = 0)
    (hneg_mul : ∀ a b : K, (-a) * b = -(a * b)) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hQf : IsQuadraticForm QY.space QY.form) (e : ℕ → Y)
    (he : IsOrthonormalBasisFamily QY.space QY.form (D.M + D.M) e) :
    let ΦY := D.homomorphismToMatrixOfGeneral C hneg hneg_mul hneg_neg i hi QY hQf e he
    let ΨY := D.homomorphismFromMatrixOfGeneral C hneg hneg_mul hneg_neg i hi h hh QY hQf e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) ΦY ∧
      IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) ΨY ∧
      (∀ a : QY.Cl C, ΨY (ΦY a) = a) ∧
      (∀ F : Mat K (PowerSet D.M), ΦY (ΨY F) = F) ∧
      Function.Bijective ΦY ∧
      (∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), ΦY a = F → a = ΨY F) := by
  intro ΦY ΨY
  have hθ := D.mapToSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi QY hQf e he
  have hθ' := D.mapFromSplit_isIsometry C.splitSpaceLaws hneg hneg_mul hneg_neg i hi h hh.mul_two QY hQf e he
  let θ := D.mapToSplit C.splitSpaceLaws i QY e he.isBasis
  let θ' := D.mapFromSplit C.splitSpaceLaws i h QY e
  let Clθ := QuadraticSpaceWithBasis.inducedHom C hneg QY (D.space C) θ hθ.isLinearMap hθ.map_form
  let Clθ' := QuadraticSpaceWithBasis.inducedHom C hneg (D.space C) QY θ' hθ'.isLinearMap hθ'.map_form
  let Φ := D.homomorphismToMatrix C hneg
  let Ψ := D.homomorphismFromMatrix C
  have hΦY : IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) ΦY :=
    IsAlgebraHomomorphism.comp (φ := Clθ) (ψ := Φ)
      (QuadraticSpaceWithBasis.inducedHom_isHom C hneg QY (D.space C) θ hθ.isLinearMap hθ.map_form)
      (D.homomorphismToMatrix_isHom C hneg)
  have hΨY : IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) ΨY :=
    IsAlgebraHomomorphism.comp (φ := Ψ) (ψ := Clθ') (D.homomorphismFromMatrix_isHom C hneg)
      (QuadraticSpaceWithBasis.inducedHom_isHom C hneg (D.space C) QY θ' hθ'.isLinearMap hθ'.map_form)
  have h1 : ∀ a : QY.Cl C, Clθ' (Clθ a) = a :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom C hneg QY (D.space C) θ hθ.isLinearMap hθ.map_form
      θ' hθ'.isLinearMap hθ'.map_form (D.mapFromSplit_mapToSplit C.splitSpaceLaws hneg hneg_mul hneg_neg i hi h hh QY e he.isBasis)
  have h2 : ∀ X : (D.space C).Cl C, Clθ (Clθ' X) = X :=
    QuadraticSpaceWithBasis.inducedHom_comp_inducedHom C hneg (D.space C) QY θ' hθ'.isLinearMap hθ'.map_form
      θ hθ.isLinearMap hθ.map_form (D.mapToSplit_mapFromSplit C.splitSpaceLaws hneg hneg_mul hneg_neg i hi h hh.mul_two QY e he.isBasis)
  have hΨΦ : ∀ a : QY.Cl C, ΨY (ΦY a) = a := fun a => calc
    ΨY (ΦY a) = Clθ' (Ψ (Φ (Clθ a))) := rfl
    _ = Clθ' (Clθ a) := by
        rw [show Ψ (Φ (Clθ a)) = Clθ a from D.homomorphismFromMatrix_homomorphismToMatrix C hneg (Clθ a)]
    _ = a := h1 a
  have hΦΨ : ∀ F : Mat K (PowerSet D.M), ΦY (ΨY F) = F := fun F => calc
    ΦY (ΨY F) = Φ (Clθ (Clθ' (Ψ F))) := rfl
    _ = Φ (Ψ F) := by rw [h2 (Ψ F)]
    _ = F := D.homomorphismToMatrix_homomorphismFromMatrix C hneg F
  have hinj : Function.Injective ΦY := by
    intro a a' haa'
    calc a = ΨY (ΦY a) := (hΨΦ a).symm
      _ = ΨY (ΦY a') := by rw [haa']
      _ = a' := hΨΦ a'
  have hsurj : Function.Surjective ΦY := fun F => ⟨ΨY F, hΦΨ F⟩
  have hinv : ∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), ΦY a = F → a = ΨY F := by
    intro F a ha
    apply hinj
    calc ΦY a = F := ha
      _ = ΦY (ΨY F) := (hΦΨ F).symm
  exact ⟨hΦY, hΨY, hΨΦ, hΦΨ, ⟨hinj, hsurj⟩, hinv⟩

/-- 本文 `theorem_clifford_algebra_of_general_even_dimensional_nondegenerate_quadratic_space_is_isomorphic_to_matrix_algebra`
の必要十分版：e := `orthonormalBasis` のとき。e を固定するために、どの元での値も 1 の直交基底の存在の仮定の組 `E`
（K の各元が平方根をもつこと・0 でない元の逆元を含む）と、Q の非退化性 `hQ` を足す。 -/
theorem generalCliffordAlgebra_isomorphic_matrixAlgebra [Inv K] (E : OrthonormalBasisExistenceLaws K)
    (hneg : ∀ a : K, a + -a = 0) (hneg_neg : ∀ a : K, -(-a) = a) (i : K) (hi : i * i = -1)
    (h : K) (hh : IsInverseOfTwo h) (QY : Clifford.QuadraticSpaceWithBasis K Y)
    (hdim : QY.dim = D.M + D.M) (hQ : IsNondegenerateQuadraticForm QY.space QY.form) :
    let e := D.orthonormalBasis E QY hdim hQ
    let he := D.orthonormalBasis_spec E QY hdim hQ
    let ΦY := D.homomorphismToMatrixOfGeneral C hneg E.neg_mul hneg_neg i hi QY hQ.isQuadraticForm e he
    let ΨY := D.homomorphismFromMatrixOfGeneral C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm e he
    IsAlgebraHomomorphism (QY.cliffordAlgebra C) (D.matrixAlgebra C) ΦY ∧
      IsAlgebraHomomorphism (D.matrixAlgebra C) (QY.cliffordAlgebra C) ΨY ∧
      (∀ a : QY.Cl C, ΨY (ΦY a) = a) ∧
      (∀ F : Mat K (PowerSet D.M), ΦY (ΨY F) = F) ∧
      Function.Bijective ΦY ∧
      (∀ (F : Mat K (PowerSet D.M)) (a : QY.Cl C), ΦY a = F → a = ΨY F) :=
  D.generalCliffordAlgebra_isomorphic_matrixAlgebra_of_family C hneg E.neg_mul hneg_neg i hi h hh QY hQ.isQuadraticForm
    _ (D.orthonormalBasis_spec E QY hdim hQ)

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
