/-
`Isomorphism/OddDimensional/CentralElement.lean` の具体版の主張が、必要十分版の K := ℂ、n := -1_ℂ への特殊化から
得られることを示す導出版。具体版のファイルは必要十分版を引かない。
具体版の主張は、どれも具体版と同じ名前に `_of_necSuf` を付けて示す（必要十分版の主張も具体版と同じ名前）。

  具体版                                        必要十分版の特殊化
  addedGenerator_comm_image_parityFactor        addedGenerator_comm_image_parityFactor_of_necSuf
  addedGenerator_comm_image_parityElement       addedGenerator_comm_image_parityElement_of_necSuf
  centralElement                                （定義。具体版の z をそのまま使う）
  centralElement_mul_self                       centralElement_mul_self_of_necSuf
  centralElement_comm_image_γ                   centralElement_comm_image_γ_of_necSuf
  centralElement_comm_addedGenerator            centralElement_comm_addedGenerator_of_necSuf
  oddSpace_γ_pair                               oddSpace_γ_pair_of_necSuf
  centralElement_comm                           centralElement_comm_of_necSuf

運び方:
- どの主張も A' = Cl(V',q') の中の等式で、具体版の Cl(V',q') と必要十分版の前提の組 `D.toNecSuf` の Cl(V',q') は別の集合である。
  具体版の A' から必要十分版の A' への準同型はまだ無いので、`OddExtensionFromNecSuf.lean` の j・g の主張と同じく、
  必要十分版の主張を直に特殊化せず、具体版と同じ手順（calc の行も同じ）を、各段が引く主張の導出版から組み立てる。
  引く導出版は、g の反交換（`addedGenerator_anticommute_of_necSuf`）・g の平方・j が準同型であること・j と γ の関係・
  ε の平方と γ(v) との反交換（`ParityElementFromNecSuf.lean`）・反交換する二元の積との交換と C_y が部分代数であることと
  生成する部分集合で交換すれば全体と交換すること（`CommutingElementsFromNecSuf.lean`）・番号順の積の像と交換・
  反交換する二元の入れ替え・直和の元の分解と in'_2 が線型であること・γ' が線型で A' を生成すること、である。
ℂ から渡す性質は、行の中で使う (-1)·(-1) = 1 と t = t · 1 だけで、残りは各段の導出版が渡す。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CentralElement
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.OddExtensionFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ParityElementFromNecSuf
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.CommutingElementsFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.CentralElement

namespace CliffordMatrixIsomorphism.Clifford.SplitData

open CliffordMatrixIsomorphism.ComplexVectorSpace
open CliffordMatrixIsomorphism.ComplexAlgebra

universe u

noncomputable section

variable {W : Type u} (D : SplitData W)

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_factor` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem addedGenerator_comm_image_parityFactor_of_necSuf (i : ℕ) :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom (D.parityFactor i))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.parityFactor i)) D.addedGenerator := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let a := D.annihilation i
  let c := D.creation i
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom_of_necSuf
  have ha : A'.add (A'.mul g (j a)) (A'.mul (j a) g) = A'.zero :=
    D.addedGenerator_anticommute_of_necSuf (embedSecond D.spaceW (D.f i))
  have hc : A'.add (A'.mul g (j c)) (A'.mul (j c) g) = A'.zero :=
    D.addedGenerator_anticommute_of_necSuf (embedFirst (dualSpaceVectorSpace D.spaceW) (D.w i))
  have hC : IsSubalgebra A' (commutingElements A' g) := commutingElements_isSubalgebra_of_necSuf A' g
  have h1 : A'.mul (j a) (j c) ∈ commutingElements A' g :=
    mul_comm_of_anticommute_both_of_necSuf A' g (j a) (j c) ha hc
  have h2 : A'.mul (j c) (j a) ∈ commutingElements A' g :=
    mul_comm_of_anticommute_both_of_necSuf A' g (j c) (j a) hc ha
  have hχ : j (D.parityFactor i) = A'.add (A'.mul (j a) (j c)) (A'.smul (-1) (A'.mul (j c) (j a))) := calc
    j (D.parityFactor i) = j (A.add (A.mul a c) (A.smul (-1) (A.mul c a))) := rfl
    _ = A'.add (j (A.mul a c)) (j (A.smul (-1) (A.mul c a))) := hj.map_add _ _
    _ = A'.add (j (A.mul a c)) (A'.smul (-1) (j (A.mul c a))) := by rw [hj.map_smul (-1) (A.mul c a)]
    _ = A'.add (A'.mul (j a) (j c)) (A'.smul (-1) (A'.mul (j c) (j a))) := by
        rw [hj.map_mul a c, hj.map_mul c a]
  have h3 : j (D.parityFactor i) ∈ commutingElements A' g := by
    rw [hχ]
    exact hC.add_mem _ _ h1 (hC.smul_mem (-1) _ h2)
  exact h3

/-- 本文 `claim_added_generator_commutes_with_image_of_parity_element` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem addedGenerator_comm_image_parityElement_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator (D.oddInclusionHom D.parityElement)
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom D.parityElement) D.addedGenerator := by
  let A' := D.oddSpace.cliffordAlgebra
  have hε : D.oddInclusionHom D.parityElement
      = ComplexAlgebra.orderedProduct A' D.M (fun k => D.oddInclusionHom (D.parityFactor k)) :=
    D.oddInclusionHom_isHom_of_necSuf.map_orderedProduct_of_necSuf D.M D.parityFactor
  rw [hε]
  exact commute_orderedProduct_of_necSuf A' D.addedGenerator D.M _
    (fun k _ _ => D.addedGenerator_comm_image_parityFactor_of_necSuf k)

/-- 本文 `claim_square_of_central_element_is_one` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem centralElement_mul_self_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.centralElement D.centralElement = D.oddSpace.cliffordAlgebra.one := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom_of_necSuf
  calc A'.mul D.centralElement D.centralElement
      = A'.mul (A'.mul (j ε) g) (A'.mul (j ε) g) := rfl
    _ = A'.mul (j ε) (A'.mul g (A'.mul (j ε) g)) := A'.mul_assoc _ _ _
    _ = A'.mul (j ε) (A'.mul (A'.mul g (j ε)) g) := by rw [A'.mul_assoc g (j ε) g]
    _ = A'.mul (j ε) (A'.mul (A'.mul (j ε) g) g) := by rw [D.addedGenerator_comm_image_parityElement_of_necSuf]
    _ = A'.mul (j ε) (A'.mul (j ε) (A'.mul g g)) := by rw [A'.mul_assoc (j ε) g g]
    _ = A'.mul (j ε) (A'.mul (j ε) A'.one) := by rw [D.addedGenerator_mul_self_of_necSuf]
    _ = A'.mul (j ε) (j ε) := by rw [A'.mul_one (j ε)]
    _ = j (A.mul ε ε) := (hj.map_mul ε ε).symm
    _ = j A.one := by rw [D.parityElement_mul_self_of_necSuf]
    _ = A'.one := hj.map_one

/-- 本文 `claim_central_element_commutes_with_image_of_split_space` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem centralElement_comm_image_γ_of_necSuf (v : W × DualSpace D.spaceW) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement (D.oddInclusionHom (D.space.γ v))
      = D.oddSpace.cliffordAlgebra.mul (D.oddInclusionHom (D.space.γ v)) D.centralElement := by
  let A := D.space.cliffordAlgebra
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  let y := D.space.γ v
  have hj : IsComplexAlgebraHomomorphism A A' j := D.oddInclusionHom_isHom_of_necSuf
  have hg : A'.mul g (j y) = A'.smul (-1) (A'.mul (j y) g) :=
    mul_eq_neg_one_smul_swap_of_necSuf A' g (j y) (D.addedGenerator_anticommute_of_necSuf v)
  have hε : A.mul ε y = A.smul (-1) (A.mul y ε) := by
    have h : A.add (A.mul ε y) (A.mul y ε) = A.zero := by
      rw [A.add_comm (A.mul ε y) (A.mul y ε)]
      exact D.γ_anticommute_parityElement_of_necSuf v
    exact mul_eq_neg_one_smul_swap_of_necSuf A ε y h
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

/-- 本文 `claim_central_element_commutes_with_added_generator` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem centralElement_comm_addedGenerator_of_necSuf :
    D.oddSpace.cliffordAlgebra.mul D.addedGenerator D.centralElement
      = D.oddSpace.cliffordAlgebra.mul D.centralElement D.addedGenerator := by
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let ε := D.parityElement
  calc A'.mul g D.centralElement
      = A'.mul g (A'.mul (j ε) g) := rfl
    _ = A'.mul (A'.mul g (j ε)) g := (A'.mul_assoc _ _ _).symm
    _ = A'.mul (A'.mul (j ε) g) g := by rw [D.addedGenerator_comm_image_parityElement_of_necSuf]
    _ = A'.mul D.centralElement g := rfl

/-- 本文 `claim_image_of_odd_extension_element_is_sum_of_images` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem oddSpace_γ_pair_of_necSuf (v : W × DualSpace D.spaceW) (t : ℂ) :
    D.oddSpace.γ (v, t)
      = D.oddSpace.cliffordAlgebra.add (D.oddInclusionHom (D.space.γ v))
          (D.oddSpace.cliffordAlgebra.smul t D.addedGenerator) := by
  let A' := D.oddSpace.cliffordAlgebra
  let V' := D.oddVectorSpace
  let γ' := D.oddSpace.γ
  calc γ' (v, t)
      = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion t)) :=
        congrArg γ' (pair_eq_add_embed_of_necSuf D.space.space complexNumbersVectorSpace v t)
    _ = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion (t * 1))) := by rw [_root_.mul_one t]
    _ = γ' (V'.add (D.oddInclusion v) (D.oddSecondInclusion (complexNumbersVectorSpace.smul t 1))) := rfl
    _ = γ' (V'.add (D.oddInclusion v) (V'.smul t (D.oddSecondInclusion 1))) :=
        congrArg (fun x => γ' (V'.add (D.oddInclusion v) x))
          ((embedSecond_isLinearMap_of_necSuf D.space.space complexNumbersVectorSpace).map_smul t 1)
    _ = γ' (V'.add (D.oddInclusion v) (V'.smul t D.addedUnitVector)) := rfl
    _ = A'.add (γ' (D.oddInclusion v)) (γ' (V'.smul t D.addedUnitVector)) :=
        D.oddSpace.γ_isLinearMap_of_necSuf.map_add _ _
    _ = A'.add (γ' (D.oddInclusion v)) (A'.smul t (γ' D.addedUnitVector)) :=
        congrArg (A'.add (γ' (D.oddInclusion v))) (D.oddSpace.γ_isLinearMap_of_necSuf.map_smul t D.addedUnitVector)
    _ = A'.add (D.oddInclusionHom (D.space.γ v)) (A'.smul t (γ' D.addedUnitVector)) := by
        rw [D.oddInclusionHom_γ_of_necSuf v]
    _ = A'.add (D.oddInclusionHom (D.space.γ v)) (A'.smul t D.addedGenerator) := rfl

/-- 本文 `claim_central_element_commutes_with_every_element` を、具体版と同じ手順で各段の導出版から組み立てたもの。 -/
theorem centralElement_comm_of_necSuf (a : D.oddSpace.Cl) :
    D.oddSpace.cliffordAlgebra.mul D.centralElement a = D.oddSpace.cliffordAlgebra.mul a D.centralElement := by
  let A' := D.oddSpace.cliffordAlgebra
  let j := D.oddInclusionHom
  let g := D.addedGenerator
  let z := D.centralElement
  have hgen : ∀ x : D.oddSpace.Cl, x ∈ Set.range D.oddSpace.γ → A'.mul z x = A'.mul x z := by
    rintro _ ⟨⟨v, t⟩, rfl⟩
    calc A'.mul z (D.oddSpace.γ (v, t))
        = A'.mul z (A'.add (j (D.space.γ v)) (A'.smul t g)) := by rw [D.oddSpace_γ_pair_of_necSuf v t]
      _ = A'.add (A'.mul z (j (D.space.γ v))) (A'.mul z (A'.smul t g)) := A'.left_distrib _ _ _
      _ = A'.add (A'.mul z (j (D.space.γ v))) (A'.smul t (A'.mul z g)) := by
          rw [← A'.smul_mul_right t z g]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.smul t (A'.mul z g)) := by
          rw [D.centralElement_comm_image_γ_of_necSuf v]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.smul t (A'.mul g z)) := by
          rw [← D.centralElement_comm_addedGenerator_of_necSuf]
      _ = A'.add (A'.mul (j (D.space.γ v)) z) (A'.mul (A'.smul t g) z) := by
          rw [A'.smul_mul_left t g z]
      _ = A'.mul (A'.add (j (D.space.γ v)) (A'.smul t g)) z := (A'.right_distrib _ _ _).symm
      _ = A'.mul (D.oddSpace.γ (v, t)) z := by rw [D.oddSpace_γ_pair_of_necSuf v t]
  exact mul_comm_of_mul_comm_on_generators_of_necSuf A' D.oddSpace.γ_generates_of_necSuf z hgen a

end

end CliffordMatrixIsomorphism.Clifford.SplitData
