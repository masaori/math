/-
節「ℂ-線型空間」の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引き、
具体版の主張と同じ形の主張 `…_of_necSuf` を、必要十分版の主張に ℂ の性質（mathlib の補題）を
渡して示す。

  具体版                                   必要十分版の特殊化
  ComplexVectorSpace V                     toNecSuf : NecSuf.VectorSpace ℂ V（欄を写すだけ）
  linearCombination・orderedSum など        …_eq_necSuf（帰納法の各段が rfl）
  IsComplexLinearForm 等の性質              …_iff_necSuf
  各主張                                    …_of_necSuf
  dualSpaceVectorSpace 等の構造             …_of_necSuf と、具体版との一致 …_eq_of_necSuf（rfl）

座標の写像は具体版と必要十分版で別々に `Classical.choose` で選ぶので、写像として同じとは限らない。
1,…,n の番号では係数の一意性から値が一致する（`coordinate_eq_necSuf`）ので、それを通して運ぶ。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.DirectSum
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.CoordinatesAndDualBasis
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.DirectSum
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.ComplexVectorSpace

universe u v

variable {V : Type u} {U : Type v}

/-! ### 定義の対応 -/

/-- 具体版の ℂ-線型空間を、必要十分版の K := ℂ の線型空間として読む（欄を写すだけ）。 -/
def toNecSuf (S : ComplexVectorSpace V) : NecSuf.VectorSpace ℂ V where
  add := S.add
  smul := S.smul
  zero := S.zero
  add_assoc := S.add_assoc
  add_comm := S.add_comm
  add_zero := S.add_zero
  exists_add_inverse := S.exists_add_inverse
  smul_assoc := S.smul_assoc
  one_smul := S.one_smul
  smul_add := S.smul_add
  add_smul := S.add_smul

theorem partialLinearCombination_eq_necSuf (S : ComplexVectorSpace V) (c : ℕ → ℂ) (x : ℕ → V)
    (m : ℕ) :
    partialLinearCombination S c x m
      = NecSuf.VectorSpace.partialLinearCombination S.toNecSuf c x m := by
  induction m with
  | zero => rfl
  | succ m ih =>
    show S.add (partialLinearCombination S c x m) (S.smul (c (m + 1)) (x (m + 1)))
      = S.add (NecSuf.VectorSpace.partialLinearCombination S.toNecSuf c x m)
          (S.smul (c (m + 1)) (x (m + 1)))
    rw [ih]

theorem linearCombination_eq_necSuf (S : ComplexVectorSpace V) (n : ℕ) (c : ℕ → ℂ) (x : ℕ → V) :
    linearCombination S n c x = NecSuf.VectorSpace.linearCombination S.toNecSuf n c x :=
  partialLinearCombination_eq_necSuf S c x n

theorem isComplexLinearForm_iff_necSuf (S : ComplexVectorSpace V) (f : V → ℂ) :
    IsComplexLinearForm S f ↔ NecSuf.VectorSpace.IsLinearForm S.toNecSuf f :=
  ⟨fun h => ⟨h.map_add, h.map_smul⟩, fun h => ⟨h.map_add, h.map_smul⟩⟩

theorem isComplexLinearMap_iff_necSuf (SV : ComplexVectorSpace V) (SU : ComplexVectorSpace U)
    (f : V → U) :
    IsComplexLinearMap SV SU f ↔ NecSuf.VectorSpace.IsLinearMap SV.toNecSuf SU.toNecSuf f :=
  ⟨fun h => ⟨h.map_add, h.map_smul⟩, fun h => ⟨h.map_add, h.map_smul⟩⟩

theorem isLinearlyIndependentFamily_iff_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) :
    IsLinearlyIndependentFamily S n b
      ↔ NecSuf.VectorSpace.IsLinearlyIndependentFamily S.toNecSuf n b := by
  unfold IsLinearlyIndependentFamily NecSuf.VectorSpace.IsLinearlyIndependentFamily
  simp only [linearCombination_eq_necSuf]
  rfl

theorem spansByLinearCombination_iff_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) :
    SpansByLinearCombination S n b ↔ NecSuf.VectorSpace.SpansByLinearCombination S.toNecSuf n b := by
  unfold SpansByLinearCombination NecSuf.VectorSpace.SpansByLinearCombination
  simp only [linearCombination_eq_necSuf]

theorem isBasisFamily_iff_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V) :
    IsBasisFamily S n b ↔ NecSuf.VectorSpace.IsBasisFamily S.toNecSuf n b :=
  ⟨fun h => ⟨(isLinearlyIndependentFamily_iff_necSuf S n b).1 h.linearlyIndependent,
      (spansByLinearCombination_iff_necSuf S n b).1 h.spans⟩,
    fun h => ⟨(isLinearlyIndependentFamily_iff_necSuf S n b).2 h.linearlyIndependent,
      (spansByLinearCombination_iff_necSuf S n b).2 h.spans⟩⟩

theorem partialOrderedSum_eq_necSuf (a : ℕ → ℂ) (m : ℕ) :
    partialOrderedSum a m = NecSuf.partialOrderedSum a m := by
  induction m with
  | zero => rfl
  | succ m ih =>
    show partialOrderedSum a m + a (m + 1) = NecSuf.partialOrderedSum a m + a (m + 1)
    rw [ih]

theorem orderedSum_eq_necSuf (n : ℕ) (a : ℕ → ℂ) : orderedSum n a = NecSuf.orderedSum n a :=
  partialOrderedSum_eq_necSuf a n

theorem kroneckerDelta_eq_necSuf {X : Type u} [DecidableEq X] (i j : X) :
    kroneckerDelta i j = (NecSuf.kroneckerDelta i j : ℂ) := rfl

/-! ### ℂ の性質の組 -/

/-- 係数の一意性に要る ℂ の性質。 -/
theorem complexUniquenessLaws : NecSuf.VectorSpace.UniquenessLaws ℂ where
  add_zero := _root_.add_zero
  zero_add := zero_add
  add_assoc := _root_.add_assoc
  add_comm := _root_.add_comm
  exists_neg_one := ⟨-1, add_neg_cancel 1⟩
  one_mul := one_mul
  right_distrib := add_mul
  mul_zero := mul_zero
  zero_mul := zero_mul

/-- 双対空間の演算に要る ℂ の性質。 -/
theorem complexDualSpaceOperationLaws : NecSuf.VectorSpace.DualSpaceOperationLaws ℂ where
  add_assoc := _root_.add_assoc
  add_comm := _root_.add_comm
  left_distrib := mul_add
  mul_assoc := mul_assoc
  mul_comm := mul_comm
  zero_add_zero := _root_.add_zero 0
  mul_zero := mul_zero

/-- 双対空間が線型空間であることに要る ℂ の性質。 -/
theorem complexDualSpaceVectorSpaceLaws : NecSuf.VectorSpace.DualSpaceVectorSpaceLaws ℂ where
  toDualSpaceOperationLaws := complexDualSpaceOperationLaws
  add_zero := _root_.add_zero
  exists_neg_one := ⟨-1, add_neg_cancel 1⟩
  one_mul := one_mul
  right_distrib := add_mul
  zero_mul := zero_mul

/-! ### 零ベクトル -/

theorem zero_smul_eq_zero_of_necSuf (S : ComplexVectorSpace V) (x : V) : S.smul 0 x = S.zero :=
  NecSuf.VectorSpace.zero_smul_eq_zero S.toNecSuf (_root_.add_zero 0) x

theorem smul_zero_eq_zero_of_necSuf (S : ComplexVectorSpace V) (l : ℂ) :
    S.smul l S.zero = S.zero :=
  NecSuf.VectorSpace.smul_zero_eq_zero S.toNecSuf (_root_.add_zero 0) mul_zero l

theorem IsComplexLinearForm.map_zero_of_necSuf {S : ComplexVectorSpace V} {g : V → ℂ}
    (hg : IsComplexLinearForm S g) : g S.zero = 0 :=
  NecSuf.VectorSpace.IsLinearForm.map_zero ((isComplexLinearForm_iff_necSuf S g).1 hg)
    (_root_.add_zero 0) zero_mul

theorem IsComplexLinearMap.map_zero_of_necSuf {SV : ComplexVectorSpace V}
    {SU : ComplexVectorSpace U} {f : V → U} (hf : IsComplexLinearMap SV SU f) :
    f SV.zero = SU.zero :=
  NecSuf.VectorSpace.IsLinearMap.map_zero ((isComplexLinearMap_iff_necSuf SV SU f).1 hf) (_root_.add_zero 0)

/-! ### 線型結合 -/

theorem linearCombination_add_of_same_family_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (c d : ℕ → ℂ) :
    S.add (linearCombination S n c b) (linearCombination S n d b)
      = linearCombination S n (fun k => c k + d k) b := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_add_of_same_family S.toNecSuf n b c d

theorem smul_linearCombination_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (c : ℕ → ℂ) (μ : ℂ) :
    S.smul μ (linearCombination S n c b) = linearCombination S n (fun k => μ * c k) b := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.smul_linearCombination S.toNecSuf (_root_.add_zero 0) mul_zero n b c μ

theorem linearCombination_eq_of_terms_eq_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (x y : ℕ → V) (c d : ℕ → ℂ)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.smul (d k) (y k)) :
    linearCombination S n c x = linearCombination S n d y := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_eq_of_terms_eq S.toNecSuf n x y c d h

theorem linearCombination_eq_zero_of_terms_eq_zero_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (x : ℕ → V) (c : ℕ → ℂ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → S.smul (c k) (x k) = S.zero) :
    linearCombination S n c x = S.zero := by
  rw [linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_eq_zero_of_terms_eq_zero S.toNecSuf n x c h

theorem linearCombination_add_of_same_coefficients_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (x y : ℕ → V) (c : ℕ → ℂ) :
    S.add (linearCombination S n c x) (linearCombination S n c y)
      = linearCombination S n c (fun k => S.add (x k) (y k)) := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_add_of_same_coefficients S.toNecSuf n x y c

theorem linearCombination_split_of_necSuf (S : ComplexVectorSpace V) (n n' : ℕ) (x : ℕ → V)
    (c : ℕ → ℂ) :
    linearCombination S (n + n') c x
      = S.add (linearCombination S n c x)
          (linearCombination S n' (fun j => c (n + j)) (fun j => x (n + j))) := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf, linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_split S.toNecSuf n n' x c

theorem coefficients_eq_of_linearCombination_eq_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (hb : IsLinearlyIndependentFamily S n b) (c d : ℕ → ℂ)
    (h : linearCombination S n c b = linearCombination S n d b) :
    ∀ k : ℕ, 1 ≤ k → k ≤ n → c k = d k := by
  rw [linearCombination_eq_necSuf, linearCombination_eq_necSuf] at h
  exact NecSuf.VectorSpace.coefficients_eq_of_linearCombination_eq S.toNecSuf _root_.add_zero zero_add
    _root_.add_assoc _root_.add_comm ⟨-1, add_neg_cancel 1⟩ one_mul add_mul mul_zero zero_mul n b
    ((isLinearlyIndependentFamily_iff_necSuf S n b).1 hb) c d h

/-! ### 双対空間 -/

theorem pointwiseSum_isLinearForm_of_necSuf (S : ComplexVectorSpace V) {f g : V → ℂ}
    (hf : IsComplexLinearForm S f) (hg : IsComplexLinearForm S g) :
    IsComplexLinearForm S (pointwiseSum f g) :=
  (isComplexLinearForm_iff_necSuf S _).2
    (NecSuf.VectorSpace.pointwiseSum_isLinearForm S.toNecSuf _root_.add_assoc _root_.add_comm mul_add
      ((isComplexLinearForm_iff_necSuf S f).1 hf) ((isComplexLinearForm_iff_necSuf S g).1 hg))

theorem pointwiseScalarMultiple_isLinearForm_of_necSuf (S : ComplexVectorSpace V) (μ : ℂ)
    {f : V → ℂ} (hf : IsComplexLinearForm S f) :
    IsComplexLinearForm S (pointwiseScalarMultiple μ f) :=
  (isComplexLinearForm_iff_necSuf S _).2
    (NecSuf.VectorSpace.pointwiseScalarMultiple_isLinearForm S.toNecSuf mul_add mul_assoc mul_comm
      μ ((isComplexLinearForm_iff_necSuf S f).1 hf))

theorem zeroMap_isLinearForm_of_necSuf (S : ComplexVectorSpace V) :
    IsComplexLinearForm S (zeroMap (V := V)) :=
  (isComplexLinearForm_iff_necSuf S _).2
    (NecSuf.VectorSpace.zeroMap_isLinearForm S.toNecSuf (_root_.add_zero 0) mul_zero)

/-- 具体版の双対空間の元を、必要十分版の双対空間の元として読む（値の写像は同じ）。 -/
def DualSpace.toNecSuf {S : ComplexVectorSpace V} (f : DualSpace S) :
    NecSuf.VectorSpace.DualSpace S.toNecSuf :=
  ⟨f.1, (isComplexLinearForm_iff_necSuf S f.1).1 f.2⟩

/-- 必要十分版の双対空間の元を、具体版の双対空間の元として読む。 -/
def DualSpace.ofNecSuf {S : ComplexVectorSpace V} (f : NecSuf.VectorSpace.DualSpace S.toNecSuf) :
    DualSpace S :=
  ⟨f.1, (isComplexLinearForm_iff_necSuf S f.1).2 f.2⟩

/-- 必要十分版の双対空間の等式を、値の写像が同じ具体版の双対空間の元の等式として読む。 -/
theorem DualSpace.eq_of_necSuf {S : ComplexVectorSpace V} {f g : DualSpace S}
    {f' g' : NecSuf.VectorSpace.DualSpace S.toNecSuf} (h : f' = g') (hf : f.1 = f'.1)
    (hg : g.1 = g'.1) : f = g :=
  Subtype.ext (hf.trans ((congrArg Subtype.val h).trans hg.symm))

/-- 本文 `claim_dual_space_is_complex_vector_space` を、必要十分版 `NecSuf.VectorSpace.dualSpaceVectorSpace`
に ℂ の性質を渡して得たもの。八つの公理は、値の写像の等式として必要十分版の公理から運ぶ。 -/
def dualSpaceVectorSpace_of_necSuf (S : ComplexVectorSpace V) :
    ComplexVectorSpace (DualSpace S) where
  add := DualSpace.add S
  smul := DualSpace.smul S
  zero := DualSpace.zero S
  add_assoc f g h := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).add_assoc
      f.toNecSuf g.toNecSuf h.toNecSuf) rfl rfl
  add_comm f g := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).add_comm
      f.toNecSuf g.toNecSuf) rfl rfl
  add_zero f := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).add_zero
      f.toNecSuf) rfl rfl
  exists_add_inverse f := by
    obtain ⟨f', hf'⟩ :=
      (NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).exists_add_inverse
        f.toNecSuf
    exact ⟨DualSpace.ofNecSuf f', DualSpace.eq_of_necSuf hf' rfl rfl⟩
  smul_assoc l μ f := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).smul_assoc
      l μ f.toNecSuf) rfl rfl
  one_smul f := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).one_smul
      f.toNecSuf) rfl rfl
  smul_add l f g := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).smul_add
      l f.toNecSuf g.toNecSuf) rfl rfl
  add_smul l μ f := DualSpace.eq_of_necSuf
    ((NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf).add_smul
      l μ f.toNecSuf) rfl rfl

/-- 具体版の双対空間の構造は、必要十分版から得た構造と同じである（演算が同じで、公理は命題）。 -/
theorem dualSpaceVectorSpace_eq_of_necSuf (S : ComplexVectorSpace V) :
    dualSpaceVectorSpace S = dualSpaceVectorSpace_of_necSuf S := rfl

/-- 具体版の双対空間の中の線型結合の値の写像は、必要十分版の双対空間の中の線型結合の値の写像と同じ。 -/
theorem dualSpace_partialLinearCombination_val_eq_necSuf (S : ComplexVectorSpace V)
    (f : ℕ → DualSpace S) (c : ℕ → ℂ) (m : ℕ) :
    (partialLinearCombination (dualSpaceVectorSpace S) c f m).1
      = (NecSuf.VectorSpace.partialLinearCombination
          (NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf) c
          (fun k => (f k).toNecSuf) m).1 := by
  induction m with
  | zero => rfl
  | succ m ih =>
    funext x
    show (partialLinearCombination (dualSpaceVectorSpace S) c f m).1 x + c (m + 1) * (f (m + 1)).1 x
      = (NecSuf.VectorSpace.partialLinearCombination
          (NecSuf.VectorSpace.dualSpaceVectorSpace complexDualSpaceVectorSpaceLaws S.toNecSuf) c
          (fun k => (f k).toNecSuf) m).1 x + c (m + 1) * (f (m + 1)).1 x
    rw [ih]

theorem dualSpace_linearCombination_apply_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (f : ℕ → DualSpace S) (c : ℕ → ℂ) (x : V) :
    (linearCombination (dualSpaceVectorSpace S) n c f).1 x
      = orderedSum n (fun k => c k * (f k).1 x) := by
  show (partialLinearCombination (dualSpaceVectorSpace S) c f n).1 x = _
  rw [dualSpace_partialLinearCombination_val_eq_necSuf, orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.dualSpace_linearCombination_apply complexDualSpaceVectorSpaceLaws
    S.toNecSuf n (fun k => (f k).toNecSuf) c x

/-! ### 座標の写像と双対基底 -/

/-- 具体版の座標の写像と必要十分版の座標の写像は、1,…,n の番号で値が一致する（係数の一意性による）。 -/
theorem coordinate_eq_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (k : ℕ) (hk1 : 1 ≤ k) (hkn : k ≤ n) (x : V) :
    coordinate S n b hb k x
      = NecSuf.VectorSpace.coordinate S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) k x := by
  have h := linearCombination_coordinate S n b hb x
  rw [linearCombination_eq_necSuf] at h
  exact (NecSuf.VectorSpace.coordinate_eq_of_linearCombination_eq S.toNecSuf complexUniquenessLaws n b
    ((isBasisFamily_iff_necSuf S n b).1 hb) x _ h k hk1 hkn).symm

/-- 座標の写像は具体版と必要十分版で別々に選ぶので、この性質だけは具体版の定理そのものを使う
（選んだ係数の定め方そのものであり、必要十分版から運ぶ対象が無い）。 -/
theorem linearCombination_coordinate_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (x : V) :
    linearCombination S n (fun k => coordinate S n b hb k x) b = x :=
  linearCombination_coordinate S n b hb x

theorem coordinate_eq_of_linearCombination_eq_of_necSuf (S : ComplexVectorSpace V) (n : ℕ)
    (b : ℕ → V) (hb : IsBasisFamily S n b) (x : V) (c : ℕ → ℂ)
    (h : linearCombination S n c b = x) :
    ∀ k : ℕ, 1 ≤ k → k ≤ n → coordinate S n b hb k x = c k := by
  intro k hk1 hkn
  rw [coordinate_eq_necSuf S n b hb k hk1 hkn x]
  rw [linearCombination_eq_necSuf] at h
  exact NecSuf.VectorSpace.coordinate_eq_of_linearCombination_eq S.toNecSuf complexUniquenessLaws n b
    ((isBasisFamily_iff_necSuf S n b).1 hb) x c h k hk1 hkn

theorem coordinate_isLinearForm_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (i : ℕ) (hi1 : 1 ≤ i) (hin : i ≤ n) :
    IsComplexLinearForm S (coordinate S n b hb i) := by
  have hN := NecSuf.VectorSpace.coordinate_isLinearForm S.toNecSuf complexUniquenessLaws n b
    ((isBasisFamily_iff_necSuf S n b).1 hb) i hi1 hin
  refine ⟨fun x y => ?_, fun l x => ?_⟩
  · rw [coordinate_eq_necSuf S n b hb i hi1 hin, coordinate_eq_necSuf S n b hb i hi1 hin,
      coordinate_eq_necSuf S n b hb i hi1 hin]
    exact hN.map_add x y
  · rw [coordinate_eq_necSuf S n b hb i hi1 hin, coordinate_eq_necSuf S n b hb i hi1 hin]
    exact hN.map_smul l x

theorem IsComplexLinearForm.map_linearCombination_of_necSuf {S : ComplexVectorSpace V}
    {f : V → ℂ} (hf : IsComplexLinearForm S f) (n : ℕ) (b : ℕ → V) (c : ℕ → ℂ) :
    f (linearCombination S n c b) = orderedSum n (fun k => c k * f (b k)) := by
  rw [linearCombination_eq_necSuf, orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.IsLinearForm.map_linearCombination
    ((isComplexLinearForm_iff_necSuf S f).1 hf) (_root_.add_zero 0) zero_mul n b c

theorem linearCombination_kroneckerDelta_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (j : ℕ) (hj1 : 1 ≤ j) (hjn : j ≤ n) :
    linearCombination S n (fun k => kroneckerDelta k j) b = b j := by
  rw [linearCombination_eq_necSuf]
  exact NecSuf.VectorSpace.linearCombination_kroneckerDelta S.toNecSuf (_root_.add_zero 0) n b j hj1 hjn

theorem coordinateFamily_isDualBasis_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) : IsDualBasis S n b (coordinateFamily S n b hb) := by
  intro i j hi1 hin hj1 hjn
  have hN := NecSuf.VectorSpace.coordinateFamily_isDualBasis
    complexUniquenessLaws S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) i j hi1 hin hj1 hjn
  rw [NecSuf.VectorSpace.coordinateFamily, dif_pos ⟨hi1, hin⟩] at hN
  rw [coordinateFamily, dif_pos ⟨hi1, hin⟩]
  show coordinate S n b hb i (b j) = kroneckerDelta i j
  rw [coordinate_eq_necSuf S n b hb i hi1 hin]
  exact hN

theorem orderedSum_congr_of_necSuf (n : ℕ) (a a' : ℕ → ℂ)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ n → a k = a' k) : orderedSum n a = orderedSum n a' := by
  rw [orderedSum_eq_necSuf, orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.orderedSum_congr n a a' h

theorem orderedSum_mul_kroneckerDelta_of_necSuf (n : ℕ) (a : ℕ → ℂ) (j : ℕ) (hj1 : 1 ≤ j)
    (hjn : j ≤ n) :
    orderedSum n (fun k => a k * kroneckerDelta k j) = a j := by
  rw [orderedSum_eq_necSuf]
  exact NecSuf.VectorSpace.orderedSum_mul_kroneckerDelta _root_.add_zero zero_add mul_zero mul_one n a j
    hj1 hjn

theorem dualBasis_spans_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) (g : DualSpace S) :
    g = linearCombination (dualSpaceVectorSpace S) n (fun k => g.1 (b k)) f := by
  have hN := NecSuf.VectorSpace.dualBasis_spans complexDualSpaceVectorSpaceLaws zero_add mul_one
    S.toNecSuf n b ((isBasisFamily_iff_necSuf S n b).1 hb) (fun k => (f k).toNecSuf) hf g.toNecSuf
  apply Subtype.ext
  show g.1 = (partialLinearCombination (dualSpaceVectorSpace S) (fun k => g.1 (b k)) f n).1
  rw [dualSpace_partialLinearCombination_val_eq_necSuf]
  exact congrArg Subtype.val hN

theorem dualBasis_linearlyIndependent_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) :
    IsLinearlyIndependentFamily (dualSpaceVectorSpace S) n f := by
  intro c hc
  have hN := NecSuf.VectorSpace.dualBasis_linearlyIndependent complexDualSpaceVectorSpaceLaws
    zero_add mul_one S.toNecSuf n b (fun k => (f k).toNecSuf) hf
  apply hN c
  apply Subtype.ext
  exact (dualSpace_partialLinearCombination_val_eq_necSuf S f c n).symm.trans
    (congrArg Subtype.val hc)

theorem dualBasis_isBasis_of_necSuf (S : ComplexVectorSpace V) (n : ℕ) (b : ℕ → V)
    (hb : IsBasisFamily S n b) (f : ℕ → DualSpace S) (hf : IsDualBasis S n b f) :
    IsBasisFamily (dualSpaceVectorSpace S) n f where
  linearlyIndependent := dualBasis_linearlyIndependent_of_necSuf S n b f hf
  spans g := ⟨fun k => g.1 (b k), (dualBasis_spans_of_necSuf S n b hb f hf g).symm⟩

/-! ### 直和 -/

section DirectSum

variable {V₁ : Type u} {V₂ : Type v}

/-- 本文 `claim_direct_sum_of_two_vector_spaces_is_complex_vector_space` を、必要十分版から得たもの。 -/
def directSumVectorSpace_of_necSuf (S₁ : ComplexVectorSpace V₁) (S₂ : ComplexVectorSpace V₂) :
    ComplexVectorSpace (V₁ × V₂) where
  add := DirectSum.add S₁ S₂
  smul := DirectSum.smul S₁ S₂
  zero := DirectSum.zero S₁ S₂
  add_assoc := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).add_assoc
  add_comm := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).add_comm
  add_zero := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).add_zero
  exists_add_inverse :=
    (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).exists_add_inverse
  smul_assoc := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).smul_assoc
  one_smul := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).one_smul
  smul_add := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).smul_add
  add_smul := (NecSuf.VectorSpace.directSumVectorSpace S₁.toNecSuf S₂.toNecSuf).add_smul

theorem directSumVectorSpace_eq_of_necSuf (S₁ : ComplexVectorSpace V₁)
    (S₂ : ComplexVectorSpace V₂) :
    directSumVectorSpace S₁ S₂ = directSumVectorSpace_of_necSuf S₁ S₂ := rfl

theorem embedFirst_isLinearMap_of_necSuf (S₁ : ComplexVectorSpace V₁) (S₂ : ComplexVectorSpace V₂) :
    IsComplexLinearMap S₁ (directSumVectorSpace S₁ S₂) (embedFirst S₂) :=
  let h := NecSuf.VectorSpace.embedFirst_isLinearMap S₁.toNecSuf S₂.toNecSuf (_root_.add_zero 0) mul_zero
  ⟨h.map_add, h.map_smul⟩

theorem embedSecond_isLinearMap_of_necSuf (S₁ : ComplexVectorSpace V₁)
    (S₂ : ComplexVectorSpace V₂) :
    IsComplexLinearMap S₂ (directSumVectorSpace S₁ S₂) (embedSecond S₁) :=
  let h := NecSuf.VectorSpace.embedSecond_isLinearMap S₁.toNecSuf S₂.toNecSuf (_root_.add_zero 0) mul_zero
  ⟨h.map_add, h.map_smul⟩

theorem pair_eq_add_embed_of_necSuf (S₁ : ComplexVectorSpace V₁) (S₂ : ComplexVectorSpace V₂)
    (x : V₁) (y : V₂) :
    (x, y) = DirectSum.add S₁ S₂ (embedFirst S₂ x) (embedSecond S₁ y) :=
  NecSuf.VectorSpace.pair_eq_add_embed S₁.toNecSuf S₂.toNecSuf x y

end DirectSum

/-! ### ℂ に ℂ-線型空間の構造を与える組 -/

/-- 本文 `claim_complex_numbers_as_vector_space_is_complex_vector_space` を、必要十分版
`NecSuf.VectorSpace.coefficientsVectorSpace` に ℂ の性質を渡して得たもの。 -/
def complexNumbersVectorSpace_of_necSuf : ComplexVectorSpace ℂ :=
  let N := NecSuf.VectorSpace.coefficientsVectorSpace (K := ℂ) _root_.add_assoc _root_.add_comm _root_.add_zero
    (fun a => ⟨-a, add_neg_cancel a⟩) mul_assoc one_mul mul_add add_mul
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

theorem complexNumbersVectorSpace_eq_of_necSuf :
    complexNumbersVectorSpace = complexNumbersVectorSpace_of_necSuf := rfl

end CliffordMatrixIsomorphism.ComplexVectorSpace
