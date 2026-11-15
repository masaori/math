/-
章「同型の証明」の系「奇数次元の二次空間」のうち、奇数次元のクリフォード代数 A' := Cl(V',q') の中心の元
z := j(ε) ·_{A'} g についての定義と主張の具体版。人手証明と 1 対 1 に対応させる（calc の一行が本文の一行）。

  本文のラベル                                                                  このファイル
  claim_added_generator_commutes_with_image_of_parity_factor                    addedGenerator_comm_image_parityFactor
  claim_added_generator_commutes_with_image_of_parity_element                   addedGenerator_comm_image_parityElement
  def_central_element_of_odd_dimensional_clifford_algebra                       centralElement（z）
  claim_square_of_central_element_is_one                                        centralElement_mul_self
  claim_central_element_commutes_with_image_of_split_space                      centralElement_comm_image_γ
  claim_central_element_commutes_with_added_generator                           centralElement_comm_addedGenerator
  claim_image_of_odd_extension_element_is_sum_of_images                         oddSpace_γ_pair
  claim_central_element_commutes_with_every_element                             centralElement_comm

表し方:
- A' は `D.oddSpace.cliffordAlgebra`、γ' は `D.oddSpace.γ`、j は `D.oddInclusionHom`、g は `D.addedGenerator`、
  χ_i・ε は `D.parityFactor i`・`D.parityElement`（`OddExtension.lean`・`ParityElement.lean`）。z は `D.centralElement`。
- 本文の「交換する」は y ·_{A'} a = a ·_{A'} y の等式で書く。本文の「C_g に属する」は `commutingElements` の所属で書く。
- 本文の「ℂ の四則」（(-1_ℂ)·(-1_ℂ) = 1_ℂ、t = t ·_ℂ 1_ℂ）は ℂ の計算（`norm_num`・`mul_one`）で書く。
- claim_added_generator_commutes_with_image_of_parity_factor の「すべての i ∈ {1,…,M}」の範囲は証明が使わない
  （a_i・a†_i が γ の像であることだけを使う）ので、i は ℕ の任意の元とし、範囲を仮定に置かない。
- 本文の前提 M ∈ ℤ_{≥1} は、どの主張も使わないので仮定に置かない（M = 0 でも同じ証明が通る）。

必要十分版は `NecSuf/Isomorphism/OddDimensional/CentralElement.lean`、導出版は `CentralElementFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtension
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElement

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-! ### g と j(χ_i)・j(ε) の交換 -/

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_factor`：g ·_{A'} j(χ_i) = j(χ_i) ·_{A'} g。
g が j(a_i)・j(a†_i) と反交換することから、j(a_i) j(a†_i)・j(a†_i) j(a_i) が C_g に属することを出し、
j(χ_i) をそれらの和とスカラー倍に書き直す。 -/
theorem addedGenerator_comm_image_parityFactor (i : ℕ) :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.parityFactor i))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.parityFactor i)) D.addedGenerator := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let a := D.annihilation i
  let c := D.creation i
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom
  -- claim_added_generator_anticommutes_with_image_of_split_space を v := in_2(f_i) と v := in_1(w_i) に当てる
  have ha : A'.add (A'.mul g (j a)) (A'.mul (j a) g) = A'.zero :=
    D.addedGenerator_anticommute (embedSecond D.spaceW (D.f i))
  have hc : A'.add (A'.mul g (j c)) (A'.mul (j c) g) = A'.zero :=
    D.addedGenerator_anticommute (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))
  -- j(a_i) j(a†_i)・j(a†_i) j(a_i) は C_g に属する（C_g は部分代数）
  have hC : IsSubalgebra A' (commutingElements A' g) := commutingElements_isSubalgebra A' g
  have h1 : A'.mul (j a) (j c) ∈ commutingElements A' g := mul_comm_of_anticommute_both A' g (j a) (j c) ha hc
  have h2 : A'.mul (j c) (j a) ∈ commutingElements A' g := mul_comm_of_anticommute_both A' g (j c) (j a) hc ha
  have hχ : j (D.parityFactor i) = A'.add (A'.mul (j a) (j c)) (A'.smul (-1) (A'.mul (j c) (j a))) := calc
    j (D.parityFactor i) = j (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) := rfl
    _ = A'.add (j (A.mul a c)) (j (A.smul (-1) (A.mul c a))) := hj.map_add _ _
    _ = A'.add (j (A.mul a c)) (A'.smul (-1) (j (A.mul c a))) := by rw [hj.map_smul (-1) (A.mul c a)]
    _ = A'.add (A'.mul (j a) (j c)) (A'.smul (-1) (A'.mul (j c) (j a))) := by
        rw [hj.map_mul a c, hj.map_mul c a]
  -- C_g はスカラー倍と加法で閉じている
  have h3 : j (D.parityFactor i) ∈ commutingElements A' g := by
    rw [hχ]
    exact hC.add_mem _ _ h1 (hC.smul_mem (-1) _ h2)
  exact h3

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_element`：g ·_{A'} j(ε) = j(ε) ·_{A'} g。
j(ε) = ∏_{A',i=1}^{M} j(χ_i) と、g が各因子と交換することから。 -/
theorem addedGenerator_comm_image_parityElement :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom D.parityElement)
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom D.parityElement) D.addedGenerator := by
  let A' := D.oddSpace.cliffordAlgebra
  -- claim_algebra_homomorphism_maps_ordered_product_to_ordered_product
  have hε : D.oddInclusionHom D.parityElement
      = ComplexAlgebra.orderedProduct A' D.M (fun k => D.oddInclusionHom (D.parityFactor k)) :=
    D.oddInclusionHom_isHom.map_orderedProduct D.M D.parityFactor
  rw [hε]
  -- claim_element_commuting_with_each_factor_commutes_with_ordered_product
  exact commute_orderedProduct A' D.addedGenerator D.M _
    (fun k _ _ => D.addedGenerator_comm_image_parityFactor k)

/-! ### 中心の元 z -/

/-- 本文 `def_central_element_of_odd_dimensional_clifford_algebra`：z := j(ε) ·_{A'} g。 -/
def centralElement : D.oddSpace.Cl :=
  D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom D.parityElement) D.addedGenerator

/-- 本文 `claim_square_of_central_element_is_one`：z ·_{A'} z = 1_{A'}。 -/
theorem centralElement_mul_self :
    D.oddSpace.cliffordAlgebra.mul D.centralElement D.centralElement = D.oddSpace.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom
  calc A'.mul D.centralElement D.centralElement
      = A'.mul (A'.mul (j ε) g) (A'.mul (j ε) g) := rfl
    _ = A'.mul (j ε) (A'.mul g (A'.mul (j ε) g)) := A'.mul_assoc _ _ _
    _ = A'.mul (j ε) (A'.mul (A'.mul g (j ε)) g) := by rw [A'.mul_assoc g (j ε) g]
    _ = A'.mul (j ε) (A'.mul (A'.mul (j ε) g) g) := by rw [D.addedGenerator_comm_image_parityElement]
    _ = A'.mul (j ε) (A'.mul (j ε) (A'.mul g g)) := by rw [A'.mul_assoc (j ε) g g]
    _ = A'.mul (j ε) (A'.mul (j ε) A'.one) := by rw [D.addedGenerator_mul_self]
    _ = A'.mul (j ε) (j ε) := by rw [A'.mul_one (j ε)]
    _ = j (A.mul ε ε) := (hj.map_mul ε ε).symm
    _ = j A.one := by rw [D.parityElement_mul_self]
    _ = A'.one := hj.map_one

/-- 本文 `claim_central_element_commutes_with_image_of_split_space`：すべての v ∈ V について
z ·_{A'} j(γ(v)) = j(γ(v)) ·_{A'} z。 -/
theorem centralElement_comm_image_γ (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement (D.oddInclusionHom (D.space.γ v))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.centralElement := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  let y := D.space.γ v
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom
  -- 準備：claim_added_generator_anticommutes_with_image_of_split_space に claim_anticommuting_elements_swap_with_sign を当てる
  have hg : A'.mul g (j y) = A'.smul (-1) (A'.mul (j y) g) :=
    mul_eq_neg_one_smul_swap A' g (j y) (D.addedGenerator_anticommute v)
  -- 準備：claim_image_of_split_space_anticommutes_with_parity_element の左辺の二項を入れ替えて
  -- claim_anticommuting_elements_swap_with_sign を当てる
  have hε : A.mul ε y = A.smul (-1) (A.mul y ε) := by
    have h : A.add (A.mul ε y) (A.mul y ε) = A.zero := by
      rw [A.add_comm (A.mul ε y) (A.mul y ε)]
      exact D.γ_anticommute_parityElement v
    exact mul_eq_neg_one_smul_swap A ε y h
  calc A'.mul D.centralElement (j y)
      = A'.mul (A'.mul (j ε) g) (j y) := rfl
    _ = A'.mul (j ε) (A'.mul g (j y)) := A'.mul_assoc _ _ _
    _ = A'.mul (j ε) (A'.smul (-1) (A'.mul (j y) g)) := by rw [hg]
    _ = A'.smul (-1) (A'.mul (j ε) (A'.mul (j y) g)) := (A'.smul_mul_right (-1) (j ε) _).symm
    _ = A'.smul (-1) (A'.mul (A'.mul (j ε) (j y)) g) := by rw [A'.mul_assoc (j ε) (j y) g]
    _ = A'.smul (-1) (A'.mul (j (A.mul ε y)) g) := by rw [hj.map_mul ε y]
    _ = A'.smul (-1) (A'.mul (j (A.smul (-1) (A.mul y ε))) g) := by rw [hε]
    _ = A'.smul (-1) (A'.mul (A'.smul (-1) (j (A.mul y ε))) g) := by rw [hj.map_smul (-1) (A.mul y ε)]
    _ = A'.smul (-1) (A'.smul (-1) (A'.mul (j (A.mul y ε)) g)) := by
        rw [← A'.smul_mul_left (-1) (j (A.mul y ε)) g]
    _ = A'.smul ((-1) * (-1)) (A'.mul (j (A.mul y ε)) g) := (A'.smul_assoc (-1) (-1) _).symm
    _ = A'.smul 1 (A'.mul (j (A.mul y ε)) g) := by rw [show ((-1 : ℂ) * (-1)) = 1 by norm_num]
    _ = A'.mul (j (A.mul y ε)) g := A'.one_smul _
    _ = A'.mul (A'.mul (j y) (j ε)) g := by rw [hj.map_mul y ε]
    _ = A'.mul (j y) (A'.mul (j ε) g) := A'.mul_assoc _ _ _
    _ = A'.mul (j y) D.centralElement := rfl

/-- 本文 `claim_central_element_commutes_with_added_generator`：g ·_{A'} z = z ·_{A'} g。 -/
theorem centralElement_comm_addedGenerator :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.centralElement
      = D.oddSpace.cliffordAlgebra.mul D.centralElement D.addedGenerator := by
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  calc A'.mul g D.centralElement
      = A'.mul g (A'.mul (j ε) g) := rfl
    _ = A'.mul (A'.mul g (j ε)) g := (A'.mul_assoc _ _ _).symm
    _ = A'.mul (A'.mul (j ε) g) g := by rw [D.addedGenerator_comm_image_parityElement]
    _ = A'.mul D.centralElement g := rfl

/-! ### A' の全体との交換 -/

/-- 本文 `claim_image_of_odd_extension_element_is_sum_of_images`：すべての v ∈ V と t ∈ ℂ について
γ'((v, t)) = j(γ(v)) +_{A'} t ∗_{A'} g。 -/
theorem oddSpace_γ_pair (v : W × DualSpace D.spaceW) (t : ℂ) :
    D.oddSpace.γ (v, t)
      = D.oddSpace.cliffordAlgebra.add (D.oddInclusionHom (D.space.γ v))
          (D.oddSpace.cliffordAlgebra.smul t D.addedGenerator) := by
  let A' := D.oddSpace.cliffordAlgebra
  let V' := D.oddVectorSpace
  let γ' := D.oddSpace.γ
  calc γ' (v, t)
      = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion t)) :=
        congrArg γ' (pair_eq_add_embed D.space.space complexNumbersVectorSpace v t)
    _ = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion (t * 1))) := by rw [_root_.mul_one t]
    _ = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion (complexNumbersVectorSpace.smul t 1))) := rfl
    _ = γ' (V'.add (D.oddInclusion v) (V'.smul t (D.oddSecondInclusion 1))) :=
        congrArg (fun x => γ' (V'.add (D.oddInclusion v) x))
          ((embedSecond_isLinearMap D.space.space complexNumbersVectorSpace).map_smul t 1)
    _ = γ' (V'.add (D.oddInclusion v) (V'.smul t D.addedUnitVector)) := rfl
    _ = A'.add (γ' (D.oddInclusion v)) (γ' (V'.smul t D.addedUnitVector)) :=
        D.oddSpace.γ_isLinearMap.map_add _ _
    _ = A'.add (γ' (D.oddInclusion v)) (A'.smul t (γ' D.addedUnitVector)) :=
        congrArg (A'.add (γ' (D.oddInclusion v))) (D.oddSpace.γ_isLinearMap.map_smul t D.addedUnitVector)
    _ = A'.add (D.oddInclusionHom (D.space.γ v)) (A'.smul t (γ' D.addedUnitVector)) := by
        rw [D.oddInclusionHom_γ v]
    _ = A'.add (D.oddInclusionHom (D.space.γ v)) (A'.smul t D.addedGenerator) := rfl

/-- 本文 `claim_central_element_commutes_with_every_element`：すべての a ∈ A' について z ·_{A'} a = a ·_{A'} z。
z が γ'(V') のすべての元と交換することを示し、γ'(V') が A' を生成することから全体へ広げる。 -/
theorem centralElement_comm (a : D.oddSpace.Cl) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement a = D.oddSpace.cliffordAlgebra.mul a D.centralElement := by
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let z := D.centralElement
  have hgen : ∀ x : D.oddSpace.Cl, x ∈ Set.range D.oddSpace.γ → A'.mul z x = A'.mul x z := by
    rintro _ ⟨⟨v, t⟩, rfl⟩
    calc A'.mul z (D.oddSpace.γ (v, t))
        = A'.mul z (A'.add (j (D.space.γ v)) (A'.smul t g)) := by rw [D.oddSpace_γ_pair v t]
      _ = A'.add (A'.mul z (j (D.space.γ v))) (A'.mul z (A'.smul t g)) := A'.left_distrib _ _ _
      _ = A'.add (A'.mul z (j (D.space.γ v))) (A'.smul t (A'.mul z g)) := by
          rw [← A'.smul_mul_right t z g]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.smul t (A'.mul z g)) := by
          rw [D.centralElement_comm_image_γ v]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.smul t (A'.mul g z)) := by
          rw [← D.centralElement_comm_addedGenerator]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.mul (A'.smul t g) z) := by
          rw [A'.smul_mul_left t g z]
      _ = A'.mul (A'.add (j (D.space.γ v)) (A'.smul t g)) z := (A'.right_distrib _ _ _).symm
      _ = A'.mul (D.oddSpace.γ (v, t)) z := by rw [D.oddSpace_γ_pair v t]
  -- claim_element_commuting_with_generating_subset_commutes_with_every_element を X := γ'(V')、y := z に当てる
  exact mul_comm_of_mul_comm_on_generators A' D.oddSpace.γ_generates z hgen a

end

end CliffordMatrixIsomorphism.Clifford.SplitData
