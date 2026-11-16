/-
具体版のクリフォード代数 Cl(V,q) と、必要十分版の K := ℂ、n := -1_ℂ のクリフォード代数 Cl(V'_N,q_N) の間で、
主張を運ぶための互いに逆な準同型。本文のラベルを持たない、Lean の中だけの道具である。

具体版の前提から作ったクリフォード代数と、具体版の前提を写した必要十分版の前提のクリフォード代数は、別の集合である
（T(V)・I_q が命題として等しいだけのときも、W^* のように点の型が別の部分型のときもある）。そこで、二つの空間の点を
互いに写す線型な写像の組（`PointTransport`。二次形式を保ち、互いの逆）を一つ置き、二つのクリフォード代数の普遍性から
  - T : Cl → Cl_N（T ∘ γ = γ_N ∘ toPoint）
  - S : Cl_N → Cl（S ∘ γ_N = γ ∘ ofPoint）
を作る。どちらも生成元の上で互いに逆なので、生成元で一致する準同型は等しいことから、互いに逆な ℂ-代数の準同型である。
具体版の主張の両辺を T で写して必要十分版の主張に当て、S で戻すことで、必要十分版の主張の特殊化として具体版の主張を得る
（`SplitQuadraticSpace/GeneratorsFromNecSuf.lean` の Φ・Ψ を、任意の点の写し方について書いたもの）。
-/
import CliffordMatrixIsomorphism.CliffordAlgebra.DefinitionAndUniversalProperty.CliffordAlgebraFromNecSuf

namespace CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis

open ComplexVectorSpace ComplexAlgebra

universe u u'

noncomputable section

variable {V : Type u} {V' : Type u'}

/-- 必要十分版のクリフォード代数を、具体版の ℂ-代数として読む（欄を写すだけ）。 -/
abbrev algebraOfNecSuf (Q' : NecSuf.Clifford.QuadraticSpaceWithBasis ℂ V') :
    ComplexAlgebra (Q'.Cl complexCliffordLaws) :=
  TensorPowers.complexAlgebraOfNecSuf (Q'.cliffordAlgebra complexCliffordLaws)

/-- 具体版の空間 Q の点と、必要十分版の空間 Q' の点を互いに写す写像の組。どちらも線型で、二次形式を保ち、互いの逆である。 -/
structure PointTransport (Q : QuadraticSpaceWithBasis V) (Q' : NecSuf.Clifford.QuadraticSpaceWithBasis ℂ V') where
  toPoint : V → V'
  ofPoint : V' → V
  toPoint_isLinearMap : NecSuf.VectorSpace.IsLinearMap Q.space.toNecSuf Q'.space toPoint
  ofPoint_isLinearMap : NecSuf.VectorSpace.IsLinearMap Q'.space Q.space.toNecSuf ofPoint
  form_toPoint : ∀ v : V, Q'.form (toPoint v) = Q.form v
  form_ofPoint : ∀ v' : V', Q.form (ofPoint v') = Q'.form v'
  ofPoint_toPoint : ∀ v : V, ofPoint (toPoint v) = v
  toPoint_ofPoint : ∀ v' : V', toPoint (ofPoint v') = v'

namespace PointTransport

variable {Q : QuadraticSpaceWithBasis V} {Q' : NecSuf.Clifford.QuadraticSpaceWithBasis ℂ V'} (P : PointTransport Q Q')

theorem mapTo_isLinearMap :
    IsComplexLinearMap Q.space (algebraOfNecSuf Q').toComplexVectorSpace (fun v => Q'.γ complexCliffordLaws (P.toPoint v)) := by
  rw [isComplexLinearMap_iff_necSuf]
  exact NecSuf.VectorSpace.IsLinearMap.comp P.toPoint_isLinearMap (Q'.γ_isLinearMap complexCliffordLaws)

theorem mapTo_mul_self (v : V) :
    (algebraOfNecSuf Q').mul (Q'.γ complexCliffordLaws (P.toPoint v)) (Q'.γ complexCliffordLaws (P.toPoint v))
      = (algebraOfNecSuf Q').smul (Q.form v) (algebraOfNecSuf Q').one := by
  rw [← P.form_toPoint v]
  exact Q'.γ_mul_self complexCliffordLaws add_neg_cancel (P.toPoint v)

theorem mapOf_isLinearMap :
    NecSuf.VectorSpace.IsLinearMap Q'.space Q.cliffordAlgebra.toNecSuf.toVectorSpace (fun v' => Q.γ (P.ofPoint v')) :=
  NecSuf.VectorSpace.IsLinearMap.comp P.ofPoint_isLinearMap ((isComplexLinearMap_iff_necSuf _ _ _).1 Q.γ_isLinearMap_of_necSuf)

theorem mapOf_mul_self (v' : V') :
    Q.cliffordAlgebra.toNecSuf.mul (Q.γ (P.ofPoint v')) (Q.γ (P.ofPoint v'))
      = Q.cliffordAlgebra.toNecSuf.smul (Q'.form v') Q.cliffordAlgebra.toNecSuf.one := by
  rw [← P.form_ofPoint v']
  exact Q.γ_mul_self_of_necSuf (P.ofPoint v')

/-- 具体版の普遍性から得る T : Cl → Cl_N（T ∘ γ = γ_N ∘ toPoint）。 -/
def toCl : Q.Cl → Q'.Cl complexCliffordLaws :=
  Classical.choose (Q.universalProperty_of_necSuf (algebraOfNecSuf Q') _ P.mapTo_isLinearMap P.mapTo_mul_self)

theorem toCl_isHom : IsComplexAlgebraHomomorphism Q.cliffordAlgebra (algebraOfNecSuf Q') P.toCl :=
  (Classical.choose_spec (Q.universalProperty_of_necSuf (algebraOfNecSuf Q') _ P.mapTo_isLinearMap
    P.mapTo_mul_self)).1.1

theorem toCl_γ (v : V) : P.toCl (Q.γ v) = Q'.γ complexCliffordLaws (P.toPoint v) :=
  (Classical.choose_spec (Q.universalProperty_of_necSuf (algebraOfNecSuf Q') _ P.mapTo_isLinearMap
    P.mapTo_mul_self)).1.2 v

/-- 必要十分版の普遍性から得る S : Cl_N → Cl（S ∘ γ_N = γ ∘ ofPoint）。 -/
def ofCl : Q'.Cl complexCliffordLaws → Q.Cl :=
  Classical.choose (Q'.universalProperty complexCliffordLaws add_neg_cancel Q.cliffordAlgebra.toNecSuf _
    P.mapOf_isLinearMap P.mapOf_mul_self)

theorem ofCl_isHom : IsComplexAlgebraHomomorphism (algebraOfNecSuf Q') Q.cliffordAlgebra P.ofCl :=
  (isComplexAlgebraHomomorphism_iff_necSuf _ _ _).2
    (Classical.choose_spec (Q'.universalProperty complexCliffordLaws add_neg_cancel Q.cliffordAlgebra.toNecSuf _
      P.mapOf_isLinearMap P.mapOf_mul_self)).1.1

theorem ofCl_γ (v' : V') : P.ofCl (Q'.γ complexCliffordLaws v') = Q.γ (P.ofPoint v') :=
  (Classical.choose_spec (Q'.universalProperty complexCliffordLaws add_neg_cancel Q.cliffordAlgebra.toNecSuf _
    P.mapOf_isLinearMap P.mapOf_mul_self)).1.2 v'

/-- S ∘ T は恒等写像である（γ(V) の上で一致する準同型）。 -/
theorem ofCl_toCl (x : Q.Cl) : P.ofCl (P.toCl x) = x :=
  eq_of_agree_on_generators_of_necSuf (IsComplexAlgebraHomomorphism.comp_of_necSuf P.toCl_isHom P.ofCl_isHom)
    (isComplexAlgebraHomomorphism_id_of_necSuf Q.cliffordAlgebra) (Set.range Q.γ) Q.γ_generates_of_necSuf
    (fun _ ⟨v, hv⟩ => by rw [← hv, P.toCl_γ, P.ofCl_γ, P.ofPoint_toPoint]) x

/-- T ∘ S は恒等写像である（γ_N(V'_N) の上で一致する準同型）。 -/
theorem toCl_ofCl (y : Q'.Cl complexCliffordLaws) : P.toCl (P.ofCl y) = y :=
  eq_of_agree_on_generators_of_necSuf (IsComplexAlgebraHomomorphism.comp_of_necSuf P.ofCl_isHom P.toCl_isHom)
    (isComplexAlgebraHomomorphism_id_of_necSuf (algebraOfNecSuf Q')) (Set.range (Q'.γ complexCliffordLaws))
    ((generatesAlgebra_iff_necSuf _ _).2 (Q'.γ_generates complexCliffordLaws))
    (fun _ ⟨v', hv'⟩ => by rw [← hv', P.ofCl_γ, P.toCl_γ, P.toPoint_ofPoint]) y

/-- T で写した両辺が等しければ、両辺は等しい。 -/
theorem eq_of_toCl_eq {x y : Q.Cl} (h : P.toCl x = P.toCl y) : x = y := calc
  x = P.ofCl (P.toCl x) := (P.ofCl_toCl x).symm
  _ = P.ofCl (P.toCl y) := by rw [h]
  _ = y := P.ofCl_toCl y

/-- T は全単射である。 -/
theorem toCl_bijective : Function.Bijective P.toCl :=
  ⟨fun _ _ h => P.eq_of_toCl_eq h, fun y => ⟨P.ofCl y, P.toCl_ofCl y⟩⟩

end PointTransport

/-- 具体版の空間 Q と、それを写しただけの必要十分版の空間 `Q.toNecSuf` の間の、恒等写像による点の写し方。 -/
def transportToNecSuf (Q : QuadraticSpaceWithBasis V) : PointTransport Q Q.toNecSuf where
  toPoint := fun v => v
  ofPoint := fun v => v
  toPoint_isLinearMap := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  ofPoint_isLinearMap := ⟨fun _ _ => rfl, fun _ _ => rfl⟩
  form_toPoint := fun _ => rfl
  form_ofPoint := fun _ => rfl
  ofPoint_toPoint := fun _ => rfl
  toPoint_ofPoint := fun _ => rfl

end

end CliffordMatrixIsomorphism.Clifford.QuadraticSpaceWithBasis
