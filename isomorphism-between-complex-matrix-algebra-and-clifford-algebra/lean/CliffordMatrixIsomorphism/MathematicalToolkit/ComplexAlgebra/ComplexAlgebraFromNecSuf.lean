/-
節「ℂ-代数」の具体版が、必要十分版の K := ℂ への特殊化として得られることを示す導出版。
具体版のファイルはどれも必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                   必要十分版の特殊化
  ComplexAlgebra A                         toNecSuf : NecSuf.AlgebraOver ℂ A（欄を写すだけ）
  toComplexVectorSpace                     toComplexVectorSpace_toNecSuf（rfl）
  IsComplexAlgebraHomomorphism 等の性質     …_iff_necSuf
  partialOrderedProduct・orderedProduct    …_eq_necSuf（帰納法の各段が rfl）
  restrictedOrderedProduct                 restrictedOrderedProduct_eq_necSuf（orderedProduct の一致から）
  各主張                                   …_of_necSuf

必要十分版の五つの主張は、係数 K の性質を一つも使わない。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Homomorphisms
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexVectorSpaceFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.ComplexAlgebra.Homomorphisms

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v w

variable {A : Type u} {B : Type v} {C : Type w}

/-! ### 定義の対応 -/

/-- 具体版の ℂ-代数を、必要十分版の K := ℂ の代数として読む（欄を写すだけ）。 -/
def toNecSuf (SA : ComplexAlgebra A) : NecSuf.AlgebraOver ℂ A where
  toUnitalRing := SA.toUnitalRing
  smul := SA.smul
  smul_assoc := SA.smul_assoc
  one_smul := SA.one_smul
  smul_add := SA.smul_add
  add_smul := SA.add_smul
  smul_mul_left := SA.smul_mul_left
  smul_mul_right := SA.smul_mul_right

theorem toComplexVectorSpace_toNecSuf (SA : ComplexAlgebra A) :
    SA.toComplexVectorSpace.toNecSuf = SA.toNecSuf.toVectorSpace := rfl

theorem isComplexAlgebraHomomorphism_iff_necSuf (SA : ComplexAlgebra A) (SB : ComplexAlgebra B)
    (φ : A → B) :
    IsComplexAlgebraHomomorphism SA SB φ
      ↔ NecSuf.AlgebraOver.IsAlgebraHomomorphism SA.toNecSuf SB.toNecSuf φ :=
  ⟨fun h => ⟨h.isRingHomomorphism, ⟨h.isLinearMap.map_add, h.isLinearMap.map_smul⟩⟩,
    fun h => ⟨h.isRingHomomorphism, ⟨h.isLinearMap.map_add, h.isLinearMap.map_smul⟩⟩⟩

theorem partialOrderedProduct_eq_necSuf (SA : ComplexAlgebra A) (x : ℕ → A) (m : ℕ) :
    partialOrderedProduct SA x m = NecSuf.AlgebraOver.partialOrderedProduct SA.toNecSuf x m := by
  induction m with
  | zero => rfl
  | succ m ih =>
    show SA.mul (partialOrderedProduct SA x m) (x (m + 1))
      = SA.mul (NecSuf.AlgebraOver.partialOrderedProduct SA.toNecSuf x m) (x (m + 1))
    rw [ih]

theorem orderedProduct_eq_necSuf (SA : ComplexAlgebra A) (n : ℕ) (x : ℕ → A) :
    orderedProduct SA n x = NecSuf.AlgebraOver.orderedProduct SA.toNecSuf n x :=
  partialOrderedProduct_eq_necSuf SA x n

theorem isSubalgebra_iff_necSuf (SA : ComplexAlgebra A) (S : Set A) :
    IsSubalgebra SA S ↔ NecSuf.AlgebraOver.IsSubalgebra SA.toNecSuf S :=
  ⟨fun h => ⟨h.one_mem, h.add_mem, h.mul_mem, h.smul_mem⟩,
    fun h => ⟨h.one_mem, h.add_mem, h.mul_mem, h.smul_mem⟩⟩

theorem generatesAlgebra_iff_necSuf (SA : ComplexAlgebra A) (X : Set A) :
    GeneratesAlgebra SA X ↔ NecSuf.AlgebraOver.GeneratesAlgebra SA.toNecSuf X :=
  ⟨fun h S hS hXS => h S ((isSubalgebra_iff_necSuf SA S).2 hS) hXS,
    fun h S hS hXS => h S ((isSubalgebra_iff_necSuf SA S).1 hS) hXS⟩

/-! ### 主張 -/

theorem restrictedOrderedProduct_eq_necSuf (SA : ComplexAlgebra A) (x' : ℕ → A) (m : ℕ) :
    restrictedOrderedProduct SA x' m = NecSuf.AlgebraOver.restrictedOrderedProduct SA.toNecSuf x' m :=
  orderedProduct_eq_necSuf SA m x'

theorem orderedProduct_of_restricted_family_of_necSuf (SA : ComplexAlgebra A) (x x' : ℕ → A)
    (m : ℕ) (h : ∀ k : ℕ, 1 ≤ k → k ≤ m → x' k = x k) :
    orderedProduct SA m x' = partialOrderedProduct SA x m := by
  rw [orderedProduct_eq_necSuf, partialOrderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.orderedProduct_of_restricted_family SA.toNecSuf x x' m h

theorem eq_of_agree_on_generators_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B}
    {φ ψ : A → B} (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hψ : IsComplexAlgebraHomomorphism SA SB ψ) (X : Set A) (hX : GeneratesAlgebra SA X)
    (hagree : ∀ x ∈ X, φ x = ψ x) (a : A) : φ a = ψ a :=
  NecSuf.AlgebraOver.eq_of_agree_on_generators ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ)
    ((isComplexAlgebraHomomorphism_iff_necSuf SA SB ψ).1 hψ) X
    ((generatesAlgebra_iff_necSuf SA X).1 hX) hagree a

theorem IsComplexAlgebraHomomorphism.comp_of_necSuf {SA : ComplexAlgebra A} {SB : ComplexAlgebra B}
    {SC : ComplexAlgebra C} {φ : A → B} {ψ : B → C} (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hψ : IsComplexAlgebraHomomorphism SB SC ψ) :
    IsComplexAlgebraHomomorphism SA SC (fun x => ψ (φ x)) :=
  (isComplexAlgebraHomomorphism_iff_necSuf SA SC _).2
    (NecSuf.AlgebraOver.IsAlgebraHomomorphism.comp
      ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ)
      ((isComplexAlgebraHomomorphism_iff_necSuf SB SC ψ).1 hψ))

theorem isComplexAlgebraHomomorphism_id_of_necSuf (SA : ComplexAlgebra A) :
    IsComplexAlgebraHomomorphism SA SA (fun x => x) :=
  (isComplexAlgebraHomomorphism_iff_necSuf SA SA _).2
    (NecSuf.AlgebraOver.isAlgebraHomomorphism_id SA.toNecSuf)

theorem IsComplexAlgebraHomomorphism.map_orderedProduct_of_necSuf {SA : ComplexAlgebra A}
    {SB : ComplexAlgebra B} {φ : A → B} (hφ : IsComplexAlgebraHomomorphism SA SB φ) (n : ℕ)
    (x : ℕ → A) : φ (orderedProduct SA n x) = orderedProduct SB n (fun k => φ (x k)) := by
  rw [orderedProduct_eq_necSuf, orderedProduct_eq_necSuf]
  exact NecSuf.AlgebraOver.IsAlgebraHomomorphism.map_orderedProduct
    ((isComplexAlgebraHomomorphism_iff_necSuf SA SB φ).1 hφ) n x

end CliffordMatrixIsomorphism.ComplexAlgebra
