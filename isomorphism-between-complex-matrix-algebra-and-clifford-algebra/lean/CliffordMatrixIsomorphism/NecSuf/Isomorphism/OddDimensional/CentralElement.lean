/-
章「同型の証明」の系「奇数次元の二次空間」のうち、奇数次元のクリフォード代数 A' の中心の元 z := j(ε) ·_{A'} g についての
定義と主張の必要十分版。具体版 `Isomorphism/OddDimensional/CentralElement.lean` と同じ def・calc の行を、
係数 ℂ を型の変数 K に、-1_ℂ を K の元 n に替えて書く。
本文のラベルと宣言の対応は具体版の冒頭の表と同じである（宣言の名前も同じ）。

どの主張も、Cl(V,q)・Cl(V',q') を K の上の代数にするための章「クリフォード代数」の仮定 `CliffordLaws K n` と、
j を作るための a + (-a) = 0（`hneg`。等長写像が誘導する準同型の存在）を持つ。z の定義も j を通すので `hneg` を持つ。
そのほかに行の中で `CliffordLaws K n` の欄から使う K の性質:

  addedGenerator_comm_image_parityFactor     0 + 0 = 0・1 + n = 0（反交換する二元の入れ替え）、n · n = 1（反交換する二元の積との交換）
  addedGenerator_comm_image_parityElement    前の主張を引くだけ（番号順の積の像と、各因子と交換する元の主張は係数の性質を使わない）
  centralElement                             なし
  centralElement_mul_self                    なし（g · g = 1 と ε · ε = 1 を引く）
  centralElement_comm_image_γ                0 + 0 = 0・1 + n = 0（反交換する二元の入れ替えを二度）、n · n = 1（符号が二度掛かって消える行）
  centralElement_comm_addedGenerator         なし
  oddSpace_γ_pair                            a · 1 = a（本文の「ℂ の四則」t = t · 1）、0 + 0 = 0・a · 0 = 0（in'_2 が線型）
  centralElement_comm                        前の主張を引くだけ

分かったこと:
- z が A' の中心にあることは、係数について章「クリフォード代数」の仮定と a + (-a) = 0 のほかに何も足さない。
  -1_ℂ の役をする n に要るのは、本文が「ℂ の四則」で済ませた (-1)·(-1) = 1（n · n = 1）と 1 + (-1) = 0（1 + n = 0）だけである。
- 2 の可逆性（1 + 1 ≠ 0）・½ の存在・平方根は、どの主張も使わない（z · z = 1 は g · g = 1 と ε · ε = 1 だけから出る）。
  K の乗法の交換法則も、行の中では使わない（`CliffordLaws` の欄としてだけ持つ）。
- g が j(χ_i) と交換することは、i ∈ {1,…,M} を使わない（a_i・a†_i が γ の像であることだけを使う）。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わない（M = 0 でも同じ証明が通る）。
-/
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.ParityElement

namespace CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData

open CliffordMatrixIsomorphism.NecSuf.VectorSpace
open CliffordMatrixIsomorphism.NecSuf.AlgebraOver

universe u uK

noncomputable section

variable {K : Type uK} [Add K] [Mul K] [One K] [Zero K] [Neg K] {n : K} (C : CliffordLaws K n)
  {W : Type u} (D : SplitData K W)

/-! ### g と j(χ_i)・j(ε) の交換 -/

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_factor` の必要十分版：g ·_{A'} j(χ_i) = j(χ_i) ·_{A'} g。 -/
theorem addedGenerator_comm_image_parityFactor (hneg : ∀ a : K, a + -a = 0) (i : ℕ) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.addedGenerator C) (D.oddInclusionHom C hneg (D.parityFactor C i))
      = ((D.oddSpace C).cliffordAlgebra C).mul (D.oddInclusionHom C hneg (D.parityFactor C i)) (D.addedGenerator C) := by
  let A := (D.space C).cliffordAlgebra C
  let A' := (D.oddSpace C).cliffordAlgebra C
  let j := D.oddInclusionHom C hneg
  let g := D.addedGenerator C
  let a := D.annihilation C i
  let c := D.creation C i
  have hj : IsAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom C hneg
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- claim_added_generator_anticommutes_with_image_of_split_space を v := in_2(f_i) と v := in_1(w_i) に当てる
  have ha : A'.add (A'.mul g (j a)) (A'.mul (j a) g) = A'.zero :=
    D.addedGenerator_anticommute C hneg (embedSecond D.spaceW (D.f i))
  have hc : A'.add (A'.mul g (j c)) (A'.mul (j c) g) = A'.zero :=
    D.addedGenerator_anticommute C hneg (embedFirst (dualSpaceVectorSpace C.dualSpaceVectorSpaceLaws D.spaceW) (D.w i))
  -- j(a_i) j(a†_i)・j(a†_i) j(a_i) は C_g に属する（C_g は部分代数）
  have hC : IsSubalgebra A' (commutingElements A' g) := commutingElements_isSubalgebra A' g
  have h1 : A'.mul (j a) (j c) ∈ commutingElements A' g :=
    mul_comm_of_anticommute_both h00 n C.congruence.one_add_n C.congruence.n_mul_n A' g (j a) (j c) ha hc
  have h2 : A'.mul (j c) (j a) ∈ commutingElements A' g :=
    mul_comm_of_anticommute_both h00 n C.congruence.one_add_n C.congruence.n_mul_n A' g (j c) (j a) hc ha
  have hχ : j (D.parityFactor C i) = A'.add (A'.mul (j a) (j c)) (A'.smul n (A'.mul (j c) (j a))) := calc
    j (D.parityFactor C i) = j (A.add (A.mul a c) (A.smul n (A.mul c a))) := rfl
    _ = A'.add (j (A.mul a c)) (j (A.smul n (A.mul c a))) := hj.map_add _ _
    _ = A'.add (j (A.mul a c)) (A'.smul n (j (A.mul c a))) := by rw [hj.map_smul n (A.mul c a)]
    _ = A'.add (A'.mul (j a) (j c)) (A'.smul n (A'.mul (j c) (j a))) := by
        rw [hj.map_mul a c, hj.map_mul c a]
  -- C_g はスカラー倍と加法で閉じている
  have h3 : j (D.parityFactor C i) ∈ commutingElements A' g := by
    rw [hχ]
    exact hC.add_mem _ _ h1 (hC.smul_mem n _ h2)
  exact h3

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_element` の必要十分版：g ·_{A'} j(ε) = j(ε) ·_{A'} g。 -/
theorem addedGenerator_comm_image_parityElement (hneg : ∀ a : K, a + -a = 0) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.addedGenerator C) (D.oddInclusionHom C hneg (D.parityElement C))
      = ((D.oddSpace C).cliffordAlgebra C).mul (D.oddInclusionHom C hneg (D.parityElement C)) (D.addedGenerator C) := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
  have hε : D.oddInclusionHom C hneg (D.parityElement C)
      = NecSuf.AlgebraOver.orderedProduct A' D.M (fun k => D.oddInclusionHom C hneg (D.parityFactor C k)) :=
    NecSuf.AlgebraOver.IsAlgebraHomomorphism.map_orderedProduct (D.oddInclusionHom_isHom C hneg).map_one
      (D.oddInclusionHom_isHom C hneg).map_mul D.M (D.parityFactor C)
  rw [hε]
  -- claim_element_commuting_with_each_factor_commutes_with_ordered_product
  exact commute_orderedProduct A' (D.addedGenerator C) D.M _
    (fun k _ _ => D.addedGenerator_comm_image_parityFactor C hneg k)

/-! ### 中心の元 z -/

/-- 本文 `def_central_element_of_odd_dimensional_clifford_algebra` の必要十分版：z := j(ε) ·_{A'} g。 -/
def centralElement (hneg : ∀ a : K, a + -a = 0) : (D.oddSpace C).Cl C :=
  ((D.oddSpace C).cliffordAlgebra C).mul (D.oddInclusionHom C hneg (D.parityElement C)) (D.addedGenerator C)

/-- 本文 `claim_square_of_central_element_is_one` の必要十分版：z ·_{A'} z = 1_{A'}。 -/
theorem centralElement_mul_self (hneg : ∀ a : K, a + -a = 0) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.centralElement C hneg) (D.centralElement C hneg)
      = ((D.oddSpace C).cliffordAlgebra C).one := by
  let A := (D.space C).cliffordAlgebra C
  let A' := (D.oddSpace C).cliffordAlgebra C
  let j := D.oddInclusionHom C hneg
  let g := D.addedGenerator C
  let ε := D.parityElement C
  have hj : IsAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom C hneg
  calc A'.mul (D.centralElement C hneg) (D.centralElement C hneg)
      = A'.mul (A'.mul (j ε) g) (A'.mul (j ε) g) := rfl
    _ = A'.mul (j ε) (A'.mul g (A'.mul (j ε) g)) := A'.mul_assoc _ _ _
    _ = A'.mul (j ε) (A'.mul (A'.mul g (j ε)) g) := by rw [A'.mul_assoc g (j ε) g]
    _ = A'.mul (j ε) (A'.mul (A'.mul (j ε) g) g) := by rw [D.addedGenerator_comm_image_parityElement C hneg]
    _ = A'.mul (j ε) (A'.mul (j ε) (A'.mul g g)) := by rw [A'.mul_assoc (j ε) g g]
    _ = A'.mul (j ε) (A'.mul (j ε) A'.one) := by rw [D.addedGenerator_mul_self C hneg]
    _ = A'.mul (j ε) (j ε) := by rw [A'.mul_one (j ε)]
    _ = j (A.mul ε ε) := (hj.map_mul ε ε).symm
    _ = j A.one := by rw [D.parityElement_mul_self C hneg]
    _ = A'.one := hj.map_one

/-- 本文 `claim_central_element_commutes_with_image_of_split_space` の必要十分版：
すべての v ∈ V について z ·_{A'} j(γ(v)) = j(γ(v)) ·_{A'} z。 -/
theorem centralElement_comm_image_γ (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.centralElement C hneg) (D.oddInclusionHom C hneg ((D.space C).γ C v))
      = ((D.oddSpace C).cliffordAlgebra C).mul (D.oddInclusionHom C hneg ((D.space C).γ C v)) (D.centralElement C hneg) := by
  let A := (D.space C).cliffordAlgebra C
  let A' := (D.oddSpace C).cliffordAlgebra C
  let j := D.oddInclusionHom C hneg
  let g := D.addedGenerator C
  let ε := D.parityElement C
  let y := (D.space C).γ C v
  have hj : IsAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom C hneg
  have h00 : (0 : K) + 0 = 0 := C.congruence.zero_add_zero
  -- 準備：claim_added_generator_anticommutes_with_image_of_split_space に claim_anticommuting_elements_swap_with_sign を当てる
  have hg : A'.mul g (j y) = A'.smul n (A'.mul (j y) g) :=
    mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A' g (j y) (D.addedGenerator_anticommute C hneg v)
  -- 準備：claim_image_of_split_space_anticommutes_with_parity_element の左辺の二項を入れ替えて
  -- claim_anticommuting_elements_swap_with_sign を当てる
  have hε : A.mul ε y = A.smul n (A.mul y ε) := by
    have h : A.add (A.mul ε y) (A.mul y ε) = A.zero := by
      rw [A.add_comm (A.mul ε y) (A.mul y ε)]
      exact D.γ_anticommute_parityElement C hneg v
    exact mul_eq_neg_one_smul_swap h00 n C.congruence.one_add_n A ε y h
  calc A'.mul (D.centralElement C hneg) (j y)
      = A'.mul (A'.mul (j ε) g) (j y) := rfl
    _ = A'.mul (j ε) (A'.mul g (j y)) := A'.mul_assoc _ _ _
    _ = A'.mul (j ε) (A'.smul n (A'.mul (j y) g)) := by rw [hg]
    _ = A'.smul n (A'.mul (j ε) (A'.mul (j y) g)) := (A'.smul_mul_right n (j ε) _).symm
    _ = A'.smul n (A'.mul (A'.mul (j ε) (j y)) g) := by rw [A'.mul_assoc (j ε) (j y) g]
    _ = A'.smul n (A'.mul (j (A.mul ε y)) g) := by rw [hj.map_mul ε y]
    _ = A'.smul n (A'.mul (j (A.smul n (A.mul y ε))) g) := by rw [hε]
    _ = A'.smul n (A'.mul (A'.smul n (j (A.mul y ε))) g) := by rw [hj.map_smul n (A.mul y ε)]
    _ = A'.smul n (A'.smul n (A'.mul (j (A.mul y ε)) g)) := by
        rw [← A'.smul_mul_left n (j (A.mul y ε)) g]
    _ = A'.smul (n * n) (A'.mul (j (A.mul y ε)) g) := (A'.smul_assoc n n _).symm
    -- 本文の「ℂ の四則」(-1_ℂ)·(-1_ℂ) = 1_ℂ の行。n · n = 1 はここで要る
    _ = A'.smul 1 (A'.mul (j (A.mul y ε)) g) := by rw [C.congruence.n_mul_n]
    _ = A'.mul (j (A.mul y ε)) g := A'.one_smul _
    _ = A'.mul (A'.mul (j y) (j ε)) g := by rw [hj.map_mul y ε]
    _ = A'.mul (j y) (A'.mul (j ε) g) := A'.mul_assoc _ _ _
    _ = A'.mul (j y) (D.centralElement C hneg) := rfl

/-- 本文 `claim_central_element_commutes_with_added_generator` の必要十分版：g ·_{A'} z = z ·_{A'} g。 -/
theorem centralElement_comm_addedGenerator (hneg : ∀ a : K, a + -a = 0) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.addedGenerator C) (D.centralElement C hneg)
      = ((D.oddSpace C).cliffordAlgebra C).mul (D.centralElement C hneg) (D.addedGenerator C) := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  let j := D.oddInclusionHom C hneg
  let g := D.addedGenerator C
  let ε := D.parityElement C
  calc A'.mul g (D.centralElement C hneg)
      = A'.mul g (A'.mul (j ε) g) := rfl
    _ = A'.mul (A'.mul g (j ε)) g := (A'.mul_assoc _ _ _).symm
    _ = A'.mul (A'.mul (j ε) g) g := by rw [D.addedGenerator_comm_image_parityElement C hneg]
    _ = A'.mul (D.centralElement C hneg) g := rfl

/-! ### A' の全体との交換 -/

/-- 本文 `claim_image_of_odd_extension_element_is_sum_of_images` の必要十分版：すべての v ∈ V と t ∈ K について
γ'((v, t)) = j(γ(v)) +_{A'} t ∗_{A'} g。j を書くために `hneg` を持つ。 -/
theorem oddSpace_γ_pair (hneg : ∀ a : K, a + -a = 0) (v : W × DualSpace D.spaceW) (t : K) :
    (D.oddSpace C).γ C (v, t)
      = ((D.oddSpace C).cliffordAlgebra C).add (D.oddInclusionHom C hneg ((D.space C).γ C v))
          (((D.oddSpace C).cliffordAlgebra C).smul t (D.addedGenerator C)) := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  let V' := oddVectorSpace C.valuedMaps (D.space C).space
  let γ' := (D.oddSpace C).γ C
  calc γ' (v, t)
      = γ' (V'.add (oddInclusion C.valuedMaps v) (oddSecondInclusion (D.space C).space t)) :=
        congrArg γ' (pair_eq_add_embed (D.space C).space (coefficientsVec C.valuedMaps) v t)
    -- 本文の「ℂ の四則」t = t · 1 の行。a · 1 = a はここで要る
    _ = γ' (V'.add (oddInclusion C.valuedMaps v) (oddSecondInclusion (D.space C).space (t * 1))) := by
        rw [C.mul_one t]
    _ = γ' (V'.add (oddInclusion C.valuedMaps v)
          (oddSecondInclusion (D.space C).space ((coefficientsVec C.valuedMaps).smul t 1))) := rfl
    _ = γ' (V'.add (oddInclusion C.valuedMaps v) (V'.smul t (oddSecondInclusion (D.space C).space 1))) :=
        congrArg (fun x => γ' (V'.add (oddInclusion C.valuedMaps v) x))
          ((embedSecond_isLinearMap (D.space C).space (coefficientsVec C.valuedMaps) C.congruence.zero_add_zero
            C.uniqueness.mul_zero).map_smul t 1)
    _ = γ' (V'.add (oddInclusion C.valuedMaps v) (V'.smul t (D.addedUnitVector C))) := rfl
    _ = A'.add (γ' (oddInclusion C.valuedMaps v)) (γ' (V'.smul t (D.addedUnitVector C))) :=
        ((D.oddSpace C).γ_isLinearMap C).map_add _ _
    _ = A'.add (γ' (oddInclusion C.valuedMaps v)) (A'.smul t (γ' (D.addedUnitVector C))) :=
        congrArg (A'.add (γ' (oddInclusion C.valuedMaps v)))
          (((D.oddSpace C).γ_isLinearMap C).map_smul t (D.addedUnitVector C))
    _ = A'.add (D.oddInclusionHom C hneg ((D.space C).γ C v)) (A'.smul t (γ' (D.addedUnitVector C))) := by
        rw [D.oddInclusionHom_γ C hneg v]
    _ = A'.add (D.oddInclusionHom C hneg ((D.space C).γ C v)) (A'.smul t (D.addedGenerator C)) := rfl

/-- 本文 `claim_central_element_commutes_with_every_element` の必要十分版：すべての a ∈ A' について
z ·_{A'} a = a ·_{A'} z。 -/
theorem centralElement_comm (hneg : ∀ a : K, a + -a = 0) (a : (D.oddSpace C).Cl C) :
    ((D.oddSpace C).cliffordAlgebra C).mul (D.centralElement C hneg) a
      = ((D.oddSpace C).cliffordAlgebra C).mul a (D.centralElement C hneg) := by
  let A' := (D.oddSpace C).cliffordAlgebra C
  let j := D.oddInclusionHom C hneg
  let g := D.addedGenerator C
  let z := D.centralElement C hneg
  have hgen : ∀ x : (D.oddSpace C).Cl C, x ∈ Set.range ((D.oddSpace C).γ C) → A'.mul z x = A'.mul x z := by
    rintro _ ⟨⟨v, t⟩, rfl⟩
    calc A'.mul z ((D.oddSpace C).γ C (v, t))
        = A'.mul z (A'.add (j ((D.space C).γ C v)) (A'.smul t g)) := by rw [D.oddSpace_γ_pair C hneg v t]
      _ = A'.add (A'.mul z (j ((D.space C).γ C v))) (A'.mul z (A'.smul t g)) := A'.left_distrib _ _ _
      _ = A'.add (A'.mul z (j ((D.space C).γ C v))) (A'.smul t (A'.mul z g)) := by
          rw [← A'.smul_mul_right t z g]
      _ = A'.add (A'.mul (j ((D.space C).γ C v)) z) (A'.smul t (A'.mul z g)) := by
          rw [D.centralElement_comm_image_γ C hneg v]
      _ = A'.add (A'.mul (j ((D.space C).γ C v)) z) (A'.smul t (A'.mul g z)) := by
          rw [← D.centralElement_comm_addedGenerator C hneg]
      _ = A'.add (A'.mul (j ((D.space C).γ C v)) z) (A'.mul (A'.smul t g) z) := by
          rw [A'.smul_mul_left t g z]
      _ = A'.mul (A'.add (j ((D.space C).γ C v)) (A'.smul t g)) z := (A'.right_distrib _ _ _).symm
      _ = A'.mul ((D.oddSpace C).γ C (v, t)) z := by rw [D.oddSpace_γ_pair C hneg v t]
  -- claim_element_commuting_with_generating_subset_commutes_with_every_element を X := γ'(V')、y := z に当てる
  exact mul_comm_of_mul_comm_on_generators A' ((D.oddSpace C).γ_generates C) z hgen a

end

end CliffordMatrixIsomorphism.NecSuf.Clifford.SplitData
