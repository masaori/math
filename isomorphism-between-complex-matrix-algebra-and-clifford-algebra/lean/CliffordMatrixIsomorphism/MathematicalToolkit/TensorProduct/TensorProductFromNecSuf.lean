/-
節「テンソル積」の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、
具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                 必要十分版の特殊化
  replaceComponent・basisTuple           …_eq_necSuf（同じ式。rfl）
  IsMultilinearMap・IsTensorProduct      isMultilinearMap_iff_necSuf・isTensorProduct_of_necSuf
  complexValuedMapsVectorSpace           complexValuedMapsVectorSpace_of_necSuf と、具体版との一致（rfl）
  partialOrderedProduct・orderedProduct  …_eq_necSuf（帰納法の各段が rfl）
  coordinateTensor                       coordinateTensor_eq_necSuf（座標の写像は具体版と必要十分版で別々に選ぶので、
                                         1,…,n の番号で値が一致すること `coordinate_eq_necSuf` を通す）
  inducedLinearMap                       inducedLinearMap_eq_necSuf
  各主張                                 …_of_necSuf

n 進の番号付け（`BaseNNumbering.lean`）は ℂ を含まないので、具体版と必要十分版が同じものを使う。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.CoordinateConstruction
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.FiniteSetSumFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.CoordinateConstruction

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v v' w

variable {V : Type u} {U : Type v} {U' : Type v'}

/-! ### ℂ の性質の組 -/

/-- ℂ^X を線型空間にするのに要る ℂ の性質。 -/
theorem complexValuedMapsLaws : NecSuf.VectorSpace.ValuedMapsLaws ℂ where
  add_assoc := _root_.add_assoc
  add_comm := _root_.add_comm
  add_zero := _root_.add_zero
  exists_neg a := ⟨-a, add_neg_cancel a⟩
  mul_assoc := mul_assoc
  one_mul := one_mul
  left_distrib := mul_add
  right_distrib := add_mul

/-! ### 定義の対応 -/

theorem replaceComponent_eq_necSuf {k : ℕ} (v : Tuple V k) (r : Idx k) (x : V) :
    replaceComponent v r x = NecSuf.VectorSpace.replaceComponent v r x := rfl

theorem basisTuple_eq_necSuf (b : ℕ → V) {n k : ℕ} (x : MapsBetweenInitialSegments n k) :
    basisTuple b x = NecSuf.VectorSpace.basisTuple b x := rfl

theorem isMultilinearMap_iff_necSuf (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U)
    (k : ℕ) (h : Tuple V k → U) :
    IsMultilinearMap SV SU k h ↔ NecSuf.VectorSpace.IsMultilinearMap SV.toNecSuf SU.toNecSuf k h :=
  ⟨fun hh => ⟨hh.map_add, hh.map_smul⟩, fun hh => ⟨hh.map_add, hh.map_smul⟩⟩

/-- 必要十分版の k 重テンソル積は、具体版の k 重テンソル積である（任意の ℂ-線型空間 U を toNecSuf で渡す）。 -/
theorem isTensorProduct_of_necSuf (SV : ComplexVectorSpace V) (k : ℕ) {T : Type v'}
    (ST : ComplexVectorSpace T) (τ : Tuple V k → T)
    (h : NecSuf.VectorSpace.IsTensorProduct.{u, v', w, 0} SV.toNecSuf k ST.toNecSuf τ) :
    IsTensorProduct.{u, v', w} SV k ST τ where
  multilinear := (isMultilinearMap_iff_necSuf SV ST k τ).2 h.multilinear
  universal U SU g hg := by
    obtain ⟨hbar, ⟨hlin, hcomp⟩, huniq⟩ :=
      h.universal U SU.toNecSuf g ((isMultilinearMap_iff_necSuf SV SU k g).1 hg)
    exact ⟨hbar, ⟨(isComplexLinearMap_iff_necSuf ST SU hbar).2 hlin, hcomp⟩,
      fun g' hg' => huniq g' ⟨(isComplexLinearMap_iff_necSuf ST SU g').1 hg'.1, hg'.2⟩⟩

/-- 本文 `claim_complex_valued_maps_on_set_form_complex_vector_space` を、必要十分版に ℂ の性質を渡して得たもの。 -/
def complexValuedMapsVectorSpace_of_necSuf (X : Type u) : ComplexVectorSpace (X → ℂ) :=
  let N := NecSuf.VectorSpace.complexValuedMapsVectorSpace complexValuedMapsLaws X
  { add := N.add
    smul := N.smul
    zero := N.zero
    add_assoc := N.add_assoc
    add_comm := N.add_comm
    add_zero := N.add_zero
    exists_add_inverse := N.exists_add_inverse
    smul_assoc := N.smul_assoc
    one_smul := N.one_smul
    smul_add := N.smul_add
    add_smul := N.add_smul }

theorem complexValuedMapsVectorSpace_eq_of_necSuf (X : Type u) :
    complexValuedMapsVectorSpace X = complexValuedMapsVectorSpace_of_necSuf X := rfl

theorem complexValuedMapsVectorSpace_toNecSuf (X : Type u) :
    (complexValuedMapsVectorSpace X).toNecSuf
      = NecSuf.VectorSpace.complexValuedMapsVectorSpace complexValuedMapsLaws X := rfl

theorem complexNumbersVectorSpace_toNecSuf :
    complexNumbersVectorSpace.toNecSuf = NecSuf.VectorSpace.coefficientsVec complexValuedMapsLaws := rfl

theorem partialOrderedProduct_eq_necSuf (a : ℕ → ℂ) :
    ∀ m : ℕ, partialOrderedProduct a m = NecSuf.partialOrderedProduct a m
  | 0 => rfl
  | m + 1 => by
    show partialOrderedProduct a m * a (m + 1) = NecSuf.partialOrderedProduct a m * a (m + 1)
    rw [partialOrderedProduct_eq_necSuf a m]

theorem orderedProduct_eq_necSuf (k : ℕ) (a : ℕ → ℂ) :
    orderedProduct k a = NecSuf.orderedProduct k a :=
  partialOrderedProduct_eq_necSuf a k

theorem coordinateFactors_eq_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) {k : ℕ} (v : Tuple V k) (x : MapsBetweenInitialSegments n k) :
    coordinateFactors S n b hb v x
      = NecSuf.VectorSpace.coordinateFactors S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) v x := by
  unfold coordinateFactors NecSuf.VectorSpace.coordinateFactors
  congr 1
  funext r
  exact coordinate_eq_necSuf S n b hb (x r).1 (x r).2.1 (x r).2.2 (v r)

theorem coordinateTensor_eq_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) :
    coordinateTensor S n b hb k
      = NecSuf.VectorSpace.coordinateTensor S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) k := by
  funext v x
  show orderedProduct k (coordinateFactors S n b hb v x) = NecSuf.orderedProduct k _
  rw [orderedProduct_eq_necSuf, coordinateFactors_eq_necSuf]

theorem inducedLinearMap_eq_necSuf (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V) (k : ℕ)
    (h : Tuple V k → U) :
    inducedLinearMap SU n b k h = NecSuf.VectorSpace.inducedLinearMap SU.toNecSuf n b k h := by
  funext F
  exact sumOverFiniteSet_eq_necSuf SU _ F _

/-! ### 主張 -/

theorem IsMultilinearMap.comp_linearMap_of_necSuf {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {SU' : ComplexVectorSpace U'} {k : ℕ} {h : Tuple V k → U}
    (hh : IsMultilinearMap SV SU k h) {f : U → U'} (hf : IsComplexLinearMap SU SU' f) :
    IsMultilinearMap SV SU' k (fun v => f (h v)) :=
  (isMultilinearMap_iff_necSuf SV SU' k _).2
    (NecSuf.VectorSpace.IsMultilinearMap.comp_linearMap ((isMultilinearMap_iff_necSuf SV SU k h).1 hh)
      ((isComplexLinearMap_iff_necSuf SU SU' f).1 hf))

theorem orderedProduct_add_in_one_factor_of_necSuf (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k)
    (a a' a'' : ℕ → ℂ) (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s ∧ a s = a'' s)
    (hr : a r = a' r + a'' r) :
    orderedProduct k a = orderedProduct k a' + orderedProduct k a'' := by
  simp only [orderedProduct_eq_necSuf]
  exact NecSuf.orderedProduct_add_in_one_factor mul_add add_mul k r hr1 hrk a a' a'' hne hr

theorem orderedProduct_smul_in_one_factor_of_necSuf (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k) (l : ℂ)
    (a a' : ℕ → ℂ) (hne : ∀ s : ℕ, 1 ≤ s → s ≤ k → s ≠ r → a s = a' s) (hr : a r = l * a' r) :
    orderedProduct k a = l * orderedProduct k a' := by
  simp only [orderedProduct_eq_necSuf]
  exact NecSuf.orderedProduct_smul_in_one_factor mul_assoc k r hr1 hrk l (fun c => mul_comm c l) a a'
    hne hr

theorem orderedProduct_mul_of_necSuf (k : ℕ) (a b : ℕ → ℂ) :
    orderedProduct k a * orderedProduct k b = orderedProduct k (fun s => a s * b s) := by
  simp only [orderedProduct_eq_necSuf]
  exact NecSuf.orderedProduct_mul (one_mul 1) mul_assoc mul_comm k a b

theorem orderedProduct_of_unit_factors_after_of_necSuf (k r : ℕ) (hrk : r ≤ k) (a : ℕ → ℂ)
    (h1 : ∀ s : ℕ, r < s → s ≤ k → a s = 1) :
    orderedProduct k a = partialOrderedProduct a r := by
  rw [orderedProduct_eq_necSuf, partialOrderedProduct_eq_necSuf]
  exact NecSuf.orderedProduct_of_unit_factors_after mul_one k r hrk a h1

theorem orderedProduct_of_zero_factor_of_necSuf (k r : ℕ) (hr1 : 1 ≤ r) (hrk : r ≤ k) (a : ℕ → ℂ)
    (hr : a r = 0) : orderedProduct k a = 0 := by
  rw [orderedProduct_eq_necSuf]
  exact NecSuf.orderedProduct_of_zero_factor mul_assoc (fun c => mul_comm c 0) zero_mul k r hr1 hrk a hr

theorem coordinateTensor_isMultilinear_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) :
    IsMultilinearMap S (coordinateTensorSpace n k) k (coordinateTensor S n b hb k) := by
  rw [isMultilinearMap_iff_necSuf, coordinateTensor_eq_necSuf]
  exact NecSuf.VectorSpace.coordinateTensor_isMultilinear complexValuedMapsLaws complexUniquenessLaws
    mul_comm S.toNecSuf n b _ k

theorem coordinateTensor_basisTuple_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (x y : MapsBetweenInitialSegments n k) :
    coordinateTensor S n b hb k (basisTuple b x) y = kroneckerDelta x y := by
  rw [coordinateTensor_eq_necSuf]
  exact NecSuf.VectorSpace.coordinateTensor_basisTuple complexUniquenessLaws S.toNecSuf n b _ k x y

theorem eq_sum_coordinateTensor_basisTuple_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ) (F : MapsBetweenInitialSegments n k → ℂ) :
    F = sumOverFiniteSet (coordinateTensorSpace n k) (isFiniteSet_maps n k) F
      (fun x => coordinateTensor S n b hb k (basisTuple b x)) := by
  rw [sumOverFiniteSet_eq_necSuf, coordinateTensor_eq_necSuf]
  exact NecSuf.VectorSpace.eq_sum_coordinateTensor_basisTuple complexValuedMapsLaws
    complexUniquenessLaws mul_comm S.toNecSuf n b _ k F

theorem inducedLinearMap_isLinearMap_of_necSuf (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V)
    (k : ℕ) (h : Tuple V k → U) :
    IsComplexLinearMap (coordinateTensorSpace n k) SU (inducedLinearMap SU n b k h) := by
  rw [isComplexLinearMap_iff_necSuf, inducedLinearMap_eq_necSuf]
  exact NecSuf.VectorSpace.inducedLinearMap_isLinearMap complexValuedMapsLaws (_root_.add_zero 0)
    mul_zero SU.toNecSuf n b k h

theorem multilinear_eq_of_basisTuple_of_necSuf (S : ComplexVectorSpace V)
    (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ)
    (g g' : Tuple V k → U) (hg : IsMultilinearMap S SU k g) (hg' : IsMultilinearMap S SU k g')
    (hagree : ∀ x : MapsBetweenInitialSegments n k, g (basisTuple b x) = g' (basisTuple b x)) :
    g = g' :=
  NecSuf.VectorSpace.multilinear_eq_of_basisTuple (_root_.add_zero 0) S.toNecSuf SU.toNecSuf n b
    ((isBasisFamily_iff_necSuf S n b).1 hb) k g g' ((isMultilinearMap_iff_necSuf S SU k g).1 hg)
    ((isMultilinearMap_iff_necSuf S SU k g').1 hg') hagree

theorem inducedLinearMap_comp_coordinateTensor_of_necSuf (S : ComplexVectorSpace V)
    (SU : ComplexVectorSpace U) (n : ℕ) (b : ℕ → V) (hb : IsBasisFamily S n b) (k : ℕ)
    (h : Tuple V k → U) (hh : IsMultilinearMap S SU k h) :
    (fun v => inducedLinearMap SU n b k h (coordinateTensor S n b hb k v)) = h := by
  rw [inducedLinearMap_eq_necSuf, coordinateTensor_eq_necSuf]
  exact NecSuf.VectorSpace.inducedLinearMap_comp_coordinateTensor complexValuedMapsLaws
    complexUniquenessLaws mul_comm S.toNecSuf SU.toNecSuf n b _ k h
    ((isMultilinearMap_iff_necSuf S SU k h).1 hh)

theorem coordinateTensor_isTensorProduct_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) :
    IsTensorProduct.{u, 0, w} S k (coordinateTensorSpace n k) (coordinateTensor S n b hb k) := by
  apply isTensorProduct_of_necSuf
  rw [coordinateTensor_eq_necSuf]
  exact NecSuf.VectorSpace.coordinateTensor_isTensorProduct.{u, w, 0} complexValuedMapsLaws
    complexUniquenessLaws mul_comm S.toNecSuf n b _ k

end CliffordMatrixIsomorphism.ComplexVectorSpace
