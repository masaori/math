/-
節「テンソル代数」のうち、テンソルの積の結合法則・テンソル代数の構造・埋め込みと生成・普遍性の具体版が、
必要十分版の K := ℂ への特殊化として得られることを示す導出版。具体版のファイルはどれも必要十分版を引かない。
このファイルだけが両方を引き、具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質を渡して示す。

  具体版                                        必要十分版との対応
  castT・castTuple・emptyTuple・embedVector     同じ式（rfl。空の組は eq_emptyTuple で一致させる）
  tensorAlgebraMul                              tensorAlgebraMul_eq_necSuf（テンソルの積を `tensorMul_eq_necSuf` で替える）
  tensorAlgebraOne                              tensorAlgebraOne_eq_necSuf
  tensorAlgebra                                 tensorAlgebra_toNecSuf（具体版の代数を必要十分版の K := ℂ の代数として読んだものが、
                                                必要十分版のテンソル代数に等しい）・tensorAlgebra_eq_of_necSuf
  coordinateTensorPowers                        coordinateTensorPowers_toNecSuf（τ は `coordinateTensor_eq_necSuf` で一致させる）
  extensionOnPower・extension                   …_eq_necSuf（具体版と必要十分版で別々に `Classical.choose` で選ぶので、
                                                必要十分版の普遍性の一意性に具体版の写像を当てて一致させる）
  各主張                                        …_of_necSuf

ℂ の性質は、乗法の交換法則に `mul_comm`、0 + 0 = 0 と a · 0 = 0 に `complexScalarMultipleOfZeroLaws`、
本文の -1_ℂ（1 + n = 0 を満たす n）に -1 と `add_neg_cancel 1` を渡す。
A の宇宙 w についての k 重テンソル積の読み替えは `isTensorProduct_toNecSuf_universe`（既存の `isTensorProduct_toNecSuf` を任意の宇宙に広げたもの）。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.UniversalPropertyOfTensorAlgebra
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.TensorAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.MultiplicationInAlgebraFromNecSuf
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.UniversalPropertyOfTensorAlgebra

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v w

/-! ### 読み替えの補題 -/

/-- 具体版の k 重テンソル積は、任意の宇宙 w について、必要十分版の K := ℂ の k 重テンソル積である。 -/
theorem isTensorProduct_toNecSuf_universe {V : Type u} (SV : ComplexVectorSpace V) (k : ℕ) {T : Type v}
    (ST : ComplexVectorSpace T) (τ : Tuple V k → T) (h : IsTensorProduct.{u, v, w} SV k ST τ) :
    NecSuf.VectorSpace.IsTensorProduct.{u, v, w, 0} SV.toNecSuf k ST.toNecSuf τ where
  multilinear := (isMultilinearMap_iff_necSuf SV ST k τ).1 h.multilinear
  universal U SU g hg := by
    obtain ⟨hbar, ⟨hlin, hcomp⟩, huniq⟩ :=
      h.universal U (ofNecSuf SU) g ((isMultilinearMap_iff_necSuf SV (ofNecSuf SU) k g).2 hg)
    exact ⟨hbar, ⟨(isComplexLinearMap_iff_necSuf ST (ofNecSuf SU) hbar).1 hlin, hcomp⟩,
      fun g' hg' => huniq g' ⟨(isComplexLinearMap_iff_necSuf ST (ofNecSuf SU) g').2 hg'.1, hg'.2⟩⟩

/-- 必要十分版の二つの代数は、演算と零・単位元・スカラー倍が等しければ等しい。 -/
theorem algebraOver_eq_of_operations_eq {A : Type v} (S T : NecSuf.AlgebraOver ℂ A)
    (hadd : S.add = T.add) (hmul : S.mul = T.mul) (hzero : S.zero = T.zero) (hone : S.one = T.one)
    (hsmul : S.smul = T.smul) : S = T := by
  obtain ⟨⟨_, _, _, _, _, _, _, _, _, _, _, _, _⟩, _, _, _, _, _, _, _⟩ := S
  obtain ⟨⟨_, _, _, _, _, _, _, _, _, _, _, _, _⟩, _, _, _, _, _, _, _⟩ := T
  cases hadd
  cases hmul
  cases hzero
  cases hone
  cases hsmul
  rfl

/-! ### 組と線型写像 -/

section Tuples

variable {V : Type u}

theorem castTuple_eq_necSuf {a b : ℕ} (h : a = b) (u : Tuple V a) :
    castTuple h u = NecSuf.VectorSpace.castTuple h u := rfl

theorem emptyTuple_eq_necSuf : emptyTuple V = NecSuf.VectorSpace.emptyTuple V :=
  NecSuf.VectorSpace.eq_emptyTuple (emptyTuple V)

theorem concatTuple_assoc_of_necSuf {k l p : ℕ} (u : Tuple V k) (u' : Tuple V l) (u'' : Tuple V p) :
    castTuple (Nat.add_assoc k l p) (concatTuple (concatTuple u u') u'')
      = concatTuple u (concatTuple u' u'') :=
  NecSuf.VectorSpace.concatTuple_assoc u u' u''

theorem oneElementTuple_eq_necSuf (x : V) : oneElementTuple x = NecSuf.VectorSpace.oneElementTuple x := rfl

theorem eq_concatTuple_initialPart_of_necSuf {k : ℕ} (u : Tuple V (k + 1)) :
    u = concatTuple (initialPart u) (oneElementTuple (u (lastIdx k))) :=
  NecSuf.VectorSpace.eq_concatTuple_initialPart u

end Tuples

theorem IsComplexLinearMap.comp_of_necSuf {V : Type u} {U : Type v} {W : Type w}
    {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U} {SW : ComplexVectorSpace W} {f : V → U} {g : U → W}
    (hf : IsComplexLinearMap SV SU f) (hg : IsComplexLinearMap SU SW g) :
    IsComplexLinearMap SV SW (fun x => g (f x)) :=
  (isComplexLinearMap_iff_necSuf _ _ _).2
    (NecSuf.VectorSpace.IsLinearMap.comp ((isComplexLinearMap_iff_necSuf _ _ _).1 hf)
      ((isComplexLinearMap_iff_necSuf _ _ _).1 hg))

theorem sumOverFiniteSet_eq_zero_of_terms_eq_zero_of_necSuf {W : Type v} (S : ComplexVectorSpace W)
    {X : Type w} (hX : IsFiniteSet X) (c : X → ℂ) (v : X → W) (h : ∀ x : X, S.smul (c x) (v x) = S.zero) :
    sumOverFiniteSet S hX c v = S.zero := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.sumOverFiniteSet_eq_zero_of_terms_eq_zero S.toNecSuf (_root_.add_zero 0) mul_zero
    hX c v h

theorem eq_sum_embedComponent_of_necSuf {E : ℕ → Type v} (S : ∀ j : ℕ, ComplexVectorSpace (E j))
    (x : DirectSumOfFamily S) (N : ℕ) (hN : IsZeroBound S x.1 N) :
    x = sumOverFiniteSet (directSumOfFamilyVectorSpace S) (isFiniteSet_upTo N) (fun _ => 1)
      (fun i => embedComponent S i.1 (x.1 i.1)) := by
  rw [sumOverFiniteSet_eq_necSuf]
  exact NecSuf.VectorSpace.eq_sum_embedComponent (fun j => (S j).toNecSuf) complexScalarMultipleOfZeroLaws
    (-1) (add_neg_cancel 1) x N hN

/-! ### テンソルの積の結合法則とテンソル代数 -/

namespace TensorPowers

variable {V : Type u} {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

theorem castT_eq_necSuf {a b : ℕ} (h : a = b) (X : P.T a) : P.castT h X = P.toNecSuf.castT h X := rfl

theorem tensorMul_assoc_of_necSuf (k l p : ℕ) (F : P.T k) (G : P.T l) (H : P.T p) :
    P.castT (Nat.add_assoc k l p) (P.tensorMul (k + l) p (P.tensorMul k l F G) H)
      = P.tensorMul k (l + p) F (P.tensorMul l p G H) := by
  simp only [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_assoc mul_comm k l p F G H

theorem tensorMul_tau_emptyTuple_left_of_necSuf (l : ℕ) (G : P.T l) :
    P.castT (Nat.zero_add l) (P.tensorMul 0 l (P.τ 0 (emptyTuple V)) G) = G := by
  rw [P.tensorMul_eq_necSuf, emptyTuple_eq_necSuf]
  exact P.toNecSuf.tensorMul_tau_emptyTuple_left mul_comm l G

theorem tensorMul_tau_emptyTuple_right_of_necSuf (k : ℕ) (F : P.T k) :
    P.castT (Nat.add_zero k) (P.tensorMul k 0 F (P.τ 0 (emptyTuple V))) = F := by
  rw [P.tensorMul_eq_necSuf, emptyTuple_eq_necSuf]
  exact P.toNecSuf.tensorMul_tau_emptyTuple_right mul_comm k F

theorem convolutionTerm_eq_necSuf (x y : DirectSumOfFamily P.space) (p : ℕ) (i : UpTo p) :
    P.convolutionTerm x y p i = P.toNecSuf.convolutionTerm mul_comm x y p i := by
  show P.castT _ (P.tensorMul i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
    = P.toNecSuf.castT _ (P.toNecSuf.tensorMul mul_comm i.1 (p - i.1) (x.1 i.1) (y.1 (p - i.1)))
  rw [P.tensorMul_eq_necSuf]
  rfl

theorem tensorAlgebraMul_eq_necSuf (x y : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul x y = P.toNecSuf.tensorAlgebraMul mul_comm complexScalarMultipleOfZeroLaws x y := by
  apply DirectSumOfFamily.ext
  intro p
  show sumOverFiniteSet (P.space p) (isFiniteSet_upTo p) (fun _ => 1) (P.convolutionTerm x y p)
    = NecSuf.VectorSpace.sumOverFiniteSet (P.space p).toNecSuf (isFiniteSet_upTo p) (fun _ => 1)
        (P.toNecSuf.convolutionTerm mul_comm x y p)
  rw [sumOverFiniteSet_eq_necSuf, funext (P.convolutionTerm_eq_necSuf x y p)]

theorem tensorAlgebraOne_eq_necSuf : P.tensorAlgebraOne = P.toNecSuf.tensorAlgebraOne := by
  show embedComponent P.space 0 (P.τ 0 (emptyTuple V))
    = NecSuf.VectorSpace.embedComponent P.toNecSuf.space 0 (P.τ 0 (NecSuf.VectorSpace.emptyTuple V))
  rw [emptyTuple_eq_necSuf]
  rfl

theorem tensorAlgebraMul_embed_of_necSuf (k l : ℕ) (F : P.T k) (G : P.T l) :
    P.tensorAlgebraMul (embedComponent P.space k F) (embedComponent P.space l G)
      = embedComponent P.space (k + l) (P.tensorMul k l F G) := by
  rw [P.tensorAlgebraMul_eq_necSuf, P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorAlgebraMul_embed mul_comm complexScalarMultipleOfZeroLaws k l F G

theorem tensorAlgebraMul_assoc_of_necSuf (x y z : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul (P.tensorAlgebraMul x y) z = P.tensorAlgebraMul x (P.tensorAlgebraMul y z) := by
  simp only [P.tensorAlgebraMul_eq_necSuf]
  exact P.toNecSuf.tensorAlgebraMul_assoc mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) x y z

theorem tensorAlgebraOne_mul_of_necSuf (x : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul P.tensorAlgebraOne x = x := by
  rw [P.tensorAlgebraMul_eq_necSuf, P.tensorAlgebraOne_eq_necSuf]
  exact P.toNecSuf.tensorAlgebraOne_mul mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) x

theorem tensorAlgebraMul_one_of_necSuf (x : DirectSumOfFamily P.space) :
    P.tensorAlgebraMul x P.tensorAlgebraOne = x := by
  rw [P.tensorAlgebraMul_eq_necSuf, P.tensorAlgebraOne_eq_necSuf]
  exact P.toNecSuf.tensorAlgebraMul_one mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) x

/-- 本文 `claim_tensor_algebra_is_complex_algebra`：具体版のテンソル代数を K := ℂ の代数として読んだものは、
必要十分版のテンソル代数に ℂ の性質を渡したものである。 -/
theorem tensorAlgebra_toNecSuf :
    P.tensorAlgebra.toNecSuf
      = P.toNecSuf.tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) :=
  algebraOver_eq_of_operations_eq _ _ rfl
    (funext fun x => funext fun y => P.tensorAlgebraMul_eq_necSuf x y) rfl P.tensorAlgebraOne_eq_necSuf rfl

/-- 必要十分版の K := ℂ の代数を、具体版の ℂ-代数として読む（欄を写すだけ）。 -/
def complexAlgebraOfNecSuf {A : Type v} (N : NecSuf.AlgebraOver ℂ A) : ComplexAlgebra A where
  toUnitalRing := N.toUnitalRing
  smul := N.smul
  smul_assoc := N.smul_assoc
  one_smul := N.one_smul
  smul_add := N.smul_add
  add_smul := N.add_smul
  smul_mul_left := N.smul_mul_left
  smul_mul_right := N.smul_mul_right

/-- 本文 `def_tensor_algebra` と `claim_tensor_algebra_is_complex_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
noncomputable def tensorAlgebra_of_necSuf : ComplexAlgebra (DirectSumOfFamily P.space) :=
  complexAlgebraOfNecSuf (P.toNecSuf.tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1))

theorem tensorAlgebra_eq_of_necSuf : P.tensorAlgebra = P.tensorAlgebra_of_necSuf := by
  show P.tensorAlgebra = complexAlgebraOfNecSuf _
  rw [← P.tensorAlgebra_toNecSuf]
  rfl

/-! ### 埋め込みと生成 -/

theorem embedVector_eq_necSuf (x : V) : P.embedVector x = P.toNecSuf.embedVector x := rfl

theorem embedVector_isLinearMap_of_necSuf :
    IsComplexLinearMap SV (ComplexAlgebra.underlyingVectorSpace P.tensorAlgebra) P.embedVector :=
  (isComplexLinearMap_iff_necSuf _ _ _).2
    (P.toNecSuf.embedVector_isLinearMap mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1))

end TensorPowers

/-- 座標による構成の族を K := ℂ の族として読んだものは、必要十分版の座標による構成の族である。 -/
theorem coordinateTensorPowers_toNecSuf {V : Type u} (SV : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily SV n b) :
    (coordinateTensorPowers SV n b hb).toNecSuf
      = NecSuf.VectorSpace.coordinateTensorPowers complexValuedMapsLaws complexUniquenessLaws mul_comm SV.toNecSuf n b
          ((isBasisFamily_iff_necSuf SV n b).1 hb) := by
  have hτ : (fun j => coordinateTensor SV n b hb j)
      = (fun j => NecSuf.VectorSpace.coordinateTensor SV.toNecSuf n b ((isBasisFamily_iff_necSuf SV n b).1 hb) j) :=
    funext fun j => coordinateTensor_eq_necSuf SV n b hb j
  show NecSuf.VectorSpace.TensorPowers.mk _ _ (fun j => coordinateTensor SV n b hb j) _
    = NecSuf.VectorSpace.TensorPowers.mk _ _ _ _
  congr 1

/-- 本文 `claim_image_of_embedding_generates_tensor_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem coordinateTensorPowers_generates_of_necSuf {V : Type u} (SV : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) :
    ComplexAlgebra.GeneratesAlgebra (coordinateTensorPowers SV n b hb).tensorAlgebra
      (Set.range (coordinateTensorPowers SV n b hb).embedVector) := by
  rw [ComplexAlgebra.generatesAlgebra_iff_necSuf, TensorPowers.tensorAlgebra_toNecSuf]
  -- 族 Q が必要十分版の座標による構成の族に等しければ、その上で生成の主張が成り立つ
  have key : ∀ Q : NecSuf.VectorSpace.TensorPowers.{u, 0, 0} SV.toNecSuf,
      Q = NecSuf.VectorSpace.coordinateTensorPowers complexValuedMapsLaws complexUniquenessLaws mul_comm SV.toNecSuf
        n b ((isBasisFamily_iff_necSuf SV n b).1 hb) →
      NecSuf.AlgebraOver.GeneratesAlgebra
        (Q.tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1)) (Set.range Q.embedVector) := by
    rintro Q rfl
    exact NecSuf.VectorSpace.coordinateTensorPowers_generates complexValuedMapsLaws complexUniquenessLaws mul_comm
      complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) SV.toNecSuf n b _
  exact key _ (coordinateTensorPowers_toNecSuf SV n b hb)

/-! ### 普遍性 -/

namespace TensorPowers

/-- 必要十分版の F_k に渡す、族が A の宇宙について k 重テンソル積であること。 -/
theorem isTensorProduct_toNecSuf_family {V : Type u} {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)
    (hP : ∀ k : ℕ, IsTensorProduct.{u, v, w} SV k (P.space k) (P.τ k)) :
    ∀ k : ℕ, NecSuf.VectorSpace.IsTensorProduct.{u, v, w, 0} SV.toNecSuf k (P.toNecSuf.space k) (P.toNecSuf.τ k) :=
  fun k => isTensorProduct_toNecSuf_universe SV k (P.space k) (P.τ k) (hP k)

theorem hf_toNecSuf {V : Type u} {A : Type w} {SV : ComplexVectorSpace V} (SA : ComplexAlgebra A) {f : V → A}
    (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f) :
    NecSuf.VectorSpace.IsLinearMap SV.toNecSuf SA.toNecSuf.toVectorSpace f :=
  (isComplexLinearMap_iff_necSuf _ _ _).1 hf


variable {V : Type u} {A : Type w} {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)
  (hP : ∀ k : ℕ, IsTensorProduct.{u, v, w} SV k (P.space k) (P.τ k))
  (SA : ComplexAlgebra A) {f : V → A} (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f)


theorem orderedProductOfValues_eq_necSuf (k : ℕ) (u : Tuple V k) :
    orderedProductOfValues SA f k u = NecSuf.VectorSpace.orderedProductOfValues SA.toNecSuf f k u :=
  ComplexAlgebra.orderedProduct_eq_necSuf SA k _

theorem extensionOnPower_eq_necSuf (k : ℕ) :
    P.extensionOnPower hP SA hf k
      = P.toNecSuf.extensionOnPower (P.isTensorProduct_toNecSuf_family hP) SA.toNecSuf (hf_toNecSuf SA hf) k :=
  (P.toNecSuf.extensionOnPower_spec (P.isTensorProduct_toNecSuf_family hP) SA.toNecSuf (hf_toNecSuf SA hf) k).2 _
    ⟨(isComplexLinearMap_iff_necSuf _ _ _).1 (P.extensionOnPower_isLinearMap hP SA hf k),
      fun u => (P.extensionOnPower_tau hP SA hf k u).trans (orderedProductOfValues_eq_necSuf SA k u)⟩

theorem extension_eq_necSuf :
    P.extension hP SA hf
      = P.toNecSuf.extension (P.isTensorProduct_toNecSuf_family hP) SA.toNecSuf (hf_toNecSuf SA hf) := by
  funext x
  show sumOverFiniteSet SA.toComplexVectorSpace (isFiniteSet_upTo (Classical.choose x.2)) (fun _ => 1)
      (fun i : UpTo (Classical.choose x.2) => P.extensionOnPower hP SA hf i.1 (x.1 i.1)) = _
  rw [sumOverFiniteSet_eq_necSuf]
  simp only [P.extensionOnPower_eq_necSuf hP SA hf]
  rfl

theorem extension_isLinearMap_of_necSuf :
    IsComplexLinearMap (directSumOfFamilyVectorSpace P.space) SA.toComplexVectorSpace (P.extension hP SA hf) := by
  rw [isComplexLinearMap_iff_necSuf, P.extension_eq_necSuf hP SA hf]
  exact P.toNecSuf.extension_isLinearMap _ SA.toNecSuf _ complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1)
    (fun l => mul_comm 1 l)

theorem extensionOnPower_tensorMul_of_necSuf (k l : ℕ) (G : P.T k) (H : P.T l) :
    P.extensionOnPower hP SA hf (k + l) (P.tensorMul k l G H)
      = SA.mul (P.extensionOnPower hP SA hf k G) (P.extensionOnPower hP SA hf l H) := by
  simp only [P.extensionOnPower_eq_necSuf hP SA hf, P.tensorMul_eq_necSuf]
  exact P.toNecSuf.extensionOnPower_tensorMul _ SA.toNecSuf _ mul_comm k l G H

/-- 本文 `claim_map_from_tensor_algebra_extending_linear_map_is_algebra_homomorphism` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem extension_isAlgebraHomomorphism_of_necSuf :
    ComplexAlgebra.IsComplexAlgebraHomomorphism P.tensorAlgebra SA (P.extension hP SA hf) := by
  rw [ComplexAlgebra.isComplexAlgebraHomomorphism_iff_necSuf, P.tensorAlgebra_toNecSuf, P.extension_eq_necSuf hP SA hf]
  exact P.toNecSuf.extension_isAlgebraHomomorphism _ SA.toNecSuf _ mul_comm complexScalarMultipleOfZeroLaws (-1)
    (add_neg_cancel 1)

theorem extension_embedVector_of_necSuf (x : V) : P.extension hP SA hf (P.embedVector x) = f x := by
  rw [P.extension_eq_necSuf hP SA hf]
  exact P.toNecSuf.extension_embedVector _ SA.toNecSuf _ complexScalarMultipleOfZeroLaws x

end TensorPowers

/-- 本文 `claim_universal_property_of_tensor_algebra` を、必要十分版に ℂ の性質を渡して得たもの。 -/
theorem universalProperty_of_tensorAlgebra_of_necSuf {V : Type u} {A : Type w} (SV : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily SV n b) (SA : ComplexAlgebra A) (f : V → A)
    (hf : IsComplexLinearMap SV SA.toComplexVectorSpace f) :
    ∃ Φ : DirectSumOfFamily (coordinateTensorPowers SV n b hb).space → A,
      (ComplexAlgebra.IsComplexAlgebraHomomorphism (coordinateTensorPowers SV n b hb).tensorAlgebra SA Φ ∧
          ∀ v : V, Φ ((coordinateTensorPowers SV n b hb).embedVector v) = f v) ∧
        ∀ Φ' : DirectSumOfFamily (coordinateTensorPowers SV n b hb).space → A,
          (ComplexAlgebra.IsComplexAlgebraHomomorphism (coordinateTensorPowers SV n b hb).tensorAlgebra SA Φ' ∧
              ∀ v : V, Φ' ((coordinateTensorPowers SV n b hb).embedVector v) = f v) → Φ' = Φ := by
  set P := coordinateTensorPowers SV n b hb with hPdef
  have hf' := TensorPowers.hf_toNecSuf SA hf
  -- 族 Q が必要十分版の座標による構成の族に等しければ、その上で普遍性が成り立つ
  have key : ∀ Q : NecSuf.VectorSpace.TensorPowers.{u, 0, 0} SV.toNecSuf,
      Q = NecSuf.VectorSpace.coordinateTensorPowers complexValuedMapsLaws complexUniquenessLaws mul_comm SV.toNecSuf
        n b ((isBasisFamily_iff_necSuf SV n b).1 hb) →
      ∃ Φ : NecSuf.VectorSpace.DirectSumOfFamily Q.space → A,
        (NecSuf.AlgebraOver.IsAlgebraHomomorphism
            (Q.tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1)) SA.toNecSuf Φ ∧
          ∀ v : V, Φ (Q.embedVector v) = f v) ∧
        ∀ Φ' : NecSuf.VectorSpace.DirectSumOfFamily Q.space → A,
          (NecSuf.AlgebraOver.IsAlgebraHomomorphism
              (Q.tensorAlgebra mul_comm complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1)) SA.toNecSuf Φ' ∧
            ∀ v : V, Φ' (Q.embedVector v) = f v) → Φ' = Φ := by
    rintro Q rfl
    exact NecSuf.VectorSpace.universalProperty_of_tensorAlgebra complexValuedMapsLaws complexUniquenessLaws mul_comm
      (-1) (add_neg_cancel 1) SV.toNecSuf n b _ SA.toNecSuf f hf'
  obtain ⟨Φ, ⟨hΦ, hΦι⟩, huniq⟩ := key P.toNecSuf (coordinateTensorPowers_toNecSuf SV n b hb)
  refine ⟨Φ, ⟨?_, hΦι⟩, fun Φ' hΦ' => huniq Φ' ⟨?_, hΦ'.2⟩⟩
  · rw [ComplexAlgebra.isComplexAlgebraHomomorphism_iff_necSuf, TensorPowers.tensorAlgebra_toNecSuf]
    exact hΦ
  · have h1 := hΦ'.1
    rw [ComplexAlgebra.isComplexAlgebraHomomorphism_iff_necSuf, TensorPowers.tensorAlgebra_toNecSuf] at h1
    exact h1

end CliffordMatrixIsomorphism.ComplexVectorSpace
