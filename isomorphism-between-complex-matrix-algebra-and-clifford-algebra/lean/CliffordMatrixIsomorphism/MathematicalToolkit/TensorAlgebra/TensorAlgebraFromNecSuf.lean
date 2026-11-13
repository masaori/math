/-
節「テンソル代数」の土台（族の直和、つなげた組、テンソルの積とその双線型性）の具体版が、必要十分版の K := ℂ への特殊化として
得られることを示す導出版。具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、
具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質（mathlib の補題）を渡して示す。

  具体版                                   必要十分版の特殊化
  DirectSumOfFamily とその演算             directSumOfFamilyVectorSpace_of_necSuf と、具体版との一致（rfl）
  concatTuple・fixSecond                   …_eq_necSuf（同じ式。rfl）
  pointwiseSumMap・pointwiseSmulMap        …_eq_necSuf（同じ式。rfl）
  TensorPowers                             TensorPowers.toNecSuf（k 重テンソル積であることは isTensorProduct_toNecSuf で運ぶ）
  appendMap・multiplyLeft・tensorMul       …_eq_necSuf（具体版と必要十分版で別々に `Classical.choose` で選ぶので、
                                           必要十分版の普遍性の一意性に具体版の写像を当てて一致させる）
  各主張                                   …_of_necSuf

必要十分版の加法の逆元の係数 n には -1、乗法の交換法則には `mul_comm` を渡す。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.DirectSumOfFamily
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorAlgebra.ProductOfTensors
import CliffordMatrixIsomorphism.MathematicalToolkit.TensorProduct.TensorProductFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.DirectSumOfFamily
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorAlgebra.ProductOfTensors

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

/-! ### ℂ の性質の組と、線型空間・k 重テンソル積の読み替え -/

/-- 族の直和のスカラー倍に要る ℂ の性質。 -/
theorem complexScalarMultipleOfZeroLaws : NecSuf.VectorSpace.ScalarMultipleOfZeroLaws ℂ where
  zero_add_zero := _root_.add_zero 0
  mul_zero := mul_zero

/-- 必要十分版の K := ℂ の線型空間を、具体版の ℂ-線型空間として読む（欄を写すだけ）。 -/
def ofNecSuf {U : Type v} (N : NecSuf.VectorSpace ℂ U) : ComplexVectorSpace U where
  add := N.add
  smul := N.smul
  zero := N.zero
  add_assoc := N.add_assoc
  add_comm := N.add_comm
  add_zero := N.add_zero
  exists_add_inverse := N.exists_add_inverse
  smul_assoc := N.smul_assoc
  one_smul := N.one_smul
  smul_add := N.smul_add
  add_smul := N.add_smul

/-- 具体版の k 重テンソル積は、必要十分版の K := ℂ の k 重テンソル積である（任意の U を `ofNecSuf` で具体版へ渡す）。 -/
theorem isTensorProduct_toNecSuf {V : Type u} (SV : ComplexVectorSpace V) (k : ℕ) {T : Type v}
    (ST : ComplexVectorSpace T) (τ : Tuple V k → T) (h : IsTensorProduct.{u, v, v} SV k ST τ) :
    NecSuf.VectorSpace.IsTensorProduct.{u, v, v, 0} SV.toNecSuf k ST.toNecSuf τ where
  multilinear := (isMultilinearMap_iff_necSuf SV ST k τ).1 h.multilinear
  universal U SU g hg := by
    obtain ⟨hbar, ⟨hlin, hcomp⟩, huniq⟩ :=
      h.universal U (ofNecSuf SU) g ((isMultilinearMap_iff_necSuf SV (ofNecSuf SU) k g).2 hg)
    exact ⟨hbar, ⟨(isComplexLinearMap_iff_necSuf ST (ofNecSuf SU) hbar).1 hlin, hcomp⟩,
      fun g' hg' => huniq g' ⟨(isComplexLinearMap_iff_necSuf ST (ofNecSuf SU) g').2 hg'.1, hg'.2⟩⟩

/-! ### 族の直和 -/

section DirectSumOfFamily

variable {E : ℕ → Type v} (S : ∀ j : ℕ, ComplexVectorSpace (E j))

theorem isZeroBound_iff_necSuf (x : (j : ℕ) → E j) (N : ℕ) :
    IsZeroBound S x N ↔ NecSuf.VectorSpace.IsZeroBound (fun j => (S j).toNecSuf) x N := Iff.rfl

theorem componentwiseSum_isZeroBound_of_necSuf (x y : DirectSumOfFamily S) :
    ∃ N : ℕ, IsZeroBound S (fun j => (S j).add (x.1 j) (y.1 j)) N :=
  NecSuf.VectorSpace.componentwiseSum_isZeroBound (fun j => (S j).toNecSuf) x y

theorem componentwiseSmul_isZeroBound_of_necSuf (l : ℂ) (x : DirectSumOfFamily S) :
    ∃ N : ℕ, IsZeroBound S (fun j => (S j).smul l (x.1 j)) N :=
  NecSuf.VectorSpace.componentwiseSmul_isZeroBound (fun j => (S j).toNecSuf)
    complexScalarMultipleOfZeroLaws l x

/-- 本文 `claim_direct_sum_of_family_of_vector_spaces_is_complex_vector_space` を、必要十分版に ℂ の性質と n := -1 を渡して得たもの。 -/
def directSumOfFamilyVectorSpace_of_necSuf : ComplexVectorSpace (DirectSumOfFamily S) :=
  ofNecSuf (NecSuf.VectorSpace.directSumOfFamilyVectorSpace (fun j => (S j).toNecSuf)
    complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1))

theorem directSumOfFamilyVectorSpace_eq_of_necSuf :
    directSumOfFamilyVectorSpace S = directSumOfFamilyVectorSpace_of_necSuf S := rfl

theorem directSumOfFamilyVectorSpace_toNecSuf :
    (directSumOfFamilyVectorSpace S).toNecSuf
      = NecSuf.VectorSpace.directSumOfFamilyVectorSpace (fun j => (S j).toNecSuf)
          complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) := rfl

theorem embedComponent_eq_necSuf (k : ℕ) (y : E k) :
    embedComponent S k y = NecSuf.VectorSpace.embedComponent (fun j => (S j).toNecSuf) k y := rfl

theorem embedComponent_isLinearMap_of_necSuf (k : ℕ) :
    IsComplexLinearMap (S k) (directSumOfFamilyVectorSpace S) (embedComponent S k) :=
  (isComplexLinearMap_iff_necSuf (S k) (directSumOfFamilyVectorSpace S) (embedComponent S k)).2
    (NecSuf.VectorSpace.embedComponent_isLinearMap (fun j => (S j).toNecSuf)
      complexScalarMultipleOfZeroLaws (-1) (add_neg_cancel 1) k)

end DirectSumOfFamily

/-! ### つなげた組と、後ろの組を固定して入れた写像 -/

section Concatenation

variable {V : Type u} {U : Type v}

theorem concatTuple_eq_necSuf {k l : ℕ} (u : Tuple V k) (u' : Tuple V l) :
    concatTuple u u' = NecSuf.VectorSpace.concatTuple u u' := rfl

theorem fixSecond_eq_necSuf {k l : ℕ} (g : Tuple V (k + l) → U) (u' : Tuple V l) :
    fixSecond g u' = NecSuf.VectorSpace.fixSecond g u' := rfl

theorem concatTuple_replaceComponent_first_of_necSuf {k l : ℕ} (u : Tuple V k) (u' : Tuple V l)
    (r : Idx k) (x : V) :
    concatTuple (replaceComponent u r x) u'
      = replaceComponent (concatTuple u u') (Idx.inFirst l r) x :=
  NecSuf.VectorSpace.concatTuple_replaceComponent_first u u' r x

theorem concatTuple_replaceComponent_second_of_necSuf {k l : ℕ} (u : Tuple V k) (u' : Tuple V l)
    (r : Idx l) (x : V) :
    concatTuple u (replaceComponent u' r x)
      = replaceComponent (concatTuple u u') (Idx.inSecond k r) x :=
  NecSuf.VectorSpace.concatTuple_replaceComponent_second u u' r x

theorem fixSecond_isMultilinearMap_of_necSuf {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {k l : ℕ} {g : Tuple V (k + l) → U} (hg : IsMultilinearMap SV SU (k + l) g) (u' : Tuple V l) :
    IsMultilinearMap SV SU k (fixSecond g u') :=
  (isMultilinearMap_iff_necSuf SV SU k _).2
    (NecSuf.VectorSpace.fixSecond_isMultilinearMap ((isMultilinearMap_iff_necSuf SV SU (k + l) g).1 hg) u')

end Concatenation

/-! ### 線型写像の各点ごとの和とスカラー倍 -/

section PointwiseLinearMaps

variable {V : Type u} {U : Type v}

theorem pointwiseSumMap_eq_necSuf (SU : ComplexVectorSpace U) (f g : V → U) :
    pointwiseSumMap SU f g = NecSuf.VectorSpace.pointwiseSumMap SU.toNecSuf f g := rfl

theorem pointwiseSmulMap_eq_necSuf (SU : ComplexVectorSpace U) (μ : ℂ) (f : V → U) :
    pointwiseSmulMap SU μ f = NecSuf.VectorSpace.pointwiseSmulMap SU.toNecSuf μ f := rfl

theorem pointwiseSumMap_isLinearMap_of_necSuf {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {f g : V → U} (hf : IsComplexLinearMap SV SU f) (hg : IsComplexLinearMap SV SU g) :
    IsComplexLinearMap SV SU (pointwiseSumMap SU f g) :=
  (isComplexLinearMap_iff_necSuf SV SU _).2
    (NecSuf.VectorSpace.pointwiseSumMap_isLinearMap ((isComplexLinearMap_iff_necSuf SV SU f).1 hf)
      ((isComplexLinearMap_iff_necSuf SV SU g).1 hg))

theorem pointwiseSmulMap_isLinearMap_of_necSuf {SV : ComplexVectorSpace V} {SU : ComplexVectorSpace U}
    {f : V → U} (hf : IsComplexLinearMap SV SU f) (μ : ℂ) :
    IsComplexLinearMap SV SU (pointwiseSmulMap SU μ f) :=
  (isComplexLinearMap_iff_necSuf SV SU _).2
    (NecSuf.VectorSpace.pointwiseSmulMap_isLinearMap ((isComplexLinearMap_iff_necSuf SV SU f).1 hf) μ
      (mul_comm μ))

end PointwiseLinearMaps

/-! ### テンソルの積 -/

namespace TensorPowers

variable {V : Type u} {SV : ComplexVectorSpace V} (P : TensorPowers.{u, v} SV)

/-- 具体版の j 重テンソル積の族を、必要十分版の K := ℂ の族として読む。 -/
def toNecSuf : NecSuf.VectorSpace.TensorPowers.{u, v, 0} SV.toNecSuf where
  T := P.T
  space j := (P.space j).toNecSuf
  τ := P.τ
  isTensorProduct j := isTensorProduct_toNecSuf SV j (P.space j) (P.τ j) (P.isTensorProduct j)

theorem appendMap_eq_necSuf (k l : ℕ) (u' : Tuple V l) :
    P.appendMap k l u' = P.toNecSuf.appendMap k l u' :=
  P.toNecSuf.appendMap_unique k l u' (P.appendMap k l u')
    ((isComplexLinearMap_iff_necSuf (P.space k) (P.space (k + l)) _).1 (P.appendMap_isLinearMap k l u'))
    (P.appendMap_spec k l u').1.2

theorem appendMapValue_eq_necSuf (k l : ℕ) (F : P.T k) :
    P.appendMapValue k l F = P.toNecSuf.appendMapValue k l F := by
  funext u'
  show P.appendMap k l u' F = P.toNecSuf.appendMap k l u' F
  rw [P.appendMap_eq_necSuf k l u']

theorem appendMapValue_isMultilinearMap_of_necSuf (k l : ℕ) (F : P.T k) :
    IsMultilinearMap SV (P.space (k + l)) l (P.appendMapValue k l F) := by
  rw [isMultilinearMap_iff_necSuf, P.appendMapValue_eq_necSuf k l F]
  exact P.toNecSuf.appendMapValue_isMultilinearMap mul_comm k l F

theorem multiplyLeft_eq_necSuf (k l : ℕ) (F : P.T k) :
    P.multiplyLeft k l F = P.toNecSuf.multiplyLeft mul_comm k l F :=
  P.toNecSuf.multiplyLeft_unique mul_comm k l F (P.multiplyLeft k l F)
    ((isComplexLinearMap_iff_necSuf (P.space l) (P.space (k + l)) _).1 (P.multiplyLeft_isLinearMap k l F))
    (fun u' => by
      show P.multiplyLeft k l F (P.τ l u') = P.toNecSuf.appendMapValue k l F u'
      rw [← P.appendMapValue_eq_necSuf k l F]
      exact (P.multiplyLeft_spec k l F).1.2 u')

theorem tensorMul_eq_necSuf (k l : ℕ) (F : P.T k) (G : P.T l) :
    P.tensorMul k l F G = P.toNecSuf.tensorMul mul_comm k l F G := by
  show P.multiplyLeft k l F G = P.toNecSuf.multiplyLeft mul_comm k l F G
  rw [P.multiplyLeft_eq_necSuf k l F]

theorem tensorMul_tau_tau_of_necSuf (k l : ℕ) (u : Tuple V k) (u' : Tuple V l) :
    P.tensorMul k l (P.τ k u) (P.τ l u') = P.τ (k + l) (concatTuple u u') := by
  rw [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_tau_tau mul_comm k l u u'

theorem tensorMul_add_right_of_necSuf (k l : ℕ) (F : P.T k) (G G' : P.T l) :
    P.tensorMul k l F ((P.space l).add G G')
      = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F G') := by
  simp only [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_add_right mul_comm k l F G G'

theorem tensorMul_smul_right_of_necSuf (k l : ℕ) (F : P.T k) (c : ℂ) (G : P.T l) :
    P.tensorMul k l F ((P.space l).smul c G) = (P.space (k + l)).smul c (P.tensorMul k l F G) := by
  simp only [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_smul_right mul_comm k l F c G

theorem tensorMul_add_left_of_necSuf (k l : ℕ) (F F' : P.T k) (G : P.T l) :
    P.tensorMul k l ((P.space k).add F F') G
      = (P.space (k + l)).add (P.tensorMul k l F G) (P.tensorMul k l F' G) := by
  simp only [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_add_left mul_comm k l F F' G

theorem tensorMul_smul_left_of_necSuf (k l : ℕ) (c : ℂ) (F : P.T k) (G : P.T l) :
    P.tensorMul k l ((P.space k).smul c F) G = (P.space (k + l)).smul c (P.tensorMul k l F G) := by
  simp only [P.tensorMul_eq_necSuf]
  exact P.toNecSuf.tensorMul_smul_left mul_comm k l c F G

end TensorPowers

end CliffordMatrixIsomorphism.ComplexVectorSpace
