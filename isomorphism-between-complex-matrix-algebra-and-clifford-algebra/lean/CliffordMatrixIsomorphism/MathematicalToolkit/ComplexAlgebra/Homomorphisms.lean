/-
節「ℂ-代数」のうち、番号順の積と準同型についての五つの主張の具体版。人手証明と 1 対 1 に対応させる。

  本文のラベル                                                         このファイル
  def_ordered_product_of_restricted_family                             restrictedOrderedProduct
  claim_partial_product_is_ordered_product_of_restricted_family        orderedProduct_of_restricted_family
  claim_homomorphisms_agreeing_on_generators_are_equal                 eq_of_agree_on_generators
  claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism   IsComplexAlgebraHomomorphism.comp
  claim_identity_map_is_algebra_homomorphism                           isComplexAlgebraHomomorphism_id
  claim_algebra_homomorphism_maps_ordered_product_to_ordered_product   IsComplexAlgebraHomomorphism.map_orderedProduct

族を {1,…,m} に制限した族は、`ℕ` の族としては 1,…,m で元の族と値の等しい族 x' である。
本文の部分積 Π_j は m ≤ n の範囲で使うが、Π_j は j > n でも同じ式で定まるので、n を仮定に置かない。

必要十分版は `NecSuf/MathematicalToolkit/ComplexAlgebra/Homomorphisms.lean`、導出版は `ComplexAlgebraFromNecSuf.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.Definitions

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v w

variable {A : Type u} {B : Type v} {C : Type w}

/-- 本文 `def_ordered_product_of_restricted_family`：族を {1,…,m} に制限した族 x' の番号順の積 ∏_{A,k=1}^{m} x'_k。
制限した族は `ℕ` の族としては 1,…,m で元の族と値の等しい族で表すので、その番号順の積 Π_m である。 -/
def restrictedOrderedProduct (SA : ComplexAlgebra A) (x' : ℕ → A) (m : ℕ) : A :=
  orderedProduct SA m x'

/-- 本文 `claim_partial_product_is_ordered_product_of_restricted_family`：族を {1,…,m} に制限した族 x' の
番号順の積は、元の族の部分積 Π_m に等しい。Π'_j = Π_j（j ≤ m）を j の帰納法で示す。 -/
theorem orderedProduct_of_restricted_family (SA : ComplexAlgebra A) (x x' : ℕ → A) (m : ℕ)
    (h : ∀ k : ℕ, 1 ≤ k → k ≤ m → x' k = x k) :
    orderedProduct SA m x' = partialOrderedProduct SA x m := by
  have hj : ∀ j : ℕ, j ≤ m → partialOrderedProduct SA x' j = partialOrderedProduct SA x j := by
    intro j
    induction j with
    | zero => intro _; calc
        partialOrderedProduct SA x' 0 = SA.one := rfl
        _ = partialOrderedProduct SA x 0 := rfl
    | succ j ih =>
      intro hjm
      calc partialOrderedProduct SA x' (j + 1)
          = SA.mul (partialOrderedProduct SA x' j) (x' (j + 1)) := rfl
        _ = SA.mul (partialOrderedProduct SA x j) (x' (j + 1)) := by rw [ih (by omega)]
        _ = SA.mul (partialOrderedProduct SA x j) (x (j + 1)) := by rw [h (j + 1) (by omega) hjm]
        _ = partialOrderedProduct SA x (j + 1) := rfl
  calc orderedProduct SA m x' = restrictedOrderedProduct SA x' m := rfl
    _ = partialOrderedProduct SA x' m := rfl
    _ = partialOrderedProduct SA x m := hj m le_rfl

/-- 本文 `claim_homomorphisms_agreeing_on_generators_are_equal`：X が A を生成し、X の上で φ = ψ なら、
A の任意の元 a で φ(a) = ψ(a)。E := {a ∈ A : φ(a) = ψ(a)} が部分代数であることを示す。 -/
theorem eq_of_agree_on_generators {SA : ComplexAlgebra A} {SB : ComplexAlgebra B} {φ ψ : A → B}
    (hφ : IsComplexAlgebraHomomorphism SA SB φ) (hψ : IsComplexAlgebraHomomorphism SA SB ψ)
    (X : Set A) (hX : GeneratesAlgebra SA X) (hagree : ∀ x ∈ X, φ x = ψ x) (a : A) :
    φ a = ψ a := by
  let E : Set A := {a : A | φ a = ψ a}
  have hE : IsSubalgebra SA E := {
    one_mem := by
      show φ SA.one = ψ SA.one
      calc φ SA.one = SB.one := hφ.map_one
        _ = ψ SA.one := hψ.map_one.symm
    add_mem := by
      intro x y hx hy
      show φ (SA.add x y) = ψ (SA.add x y)
      calc φ (SA.add x y) = SB.add (φ x) (φ y) := hφ.map_add x y
        _ = SB.add (ψ x) (φ y) := by rw [show φ x = ψ x from hx]
        _ = SB.add (ψ x) (ψ y) := by rw [show φ y = ψ y from hy]
        _ = ψ (SA.add x y) := (hψ.map_add x y).symm
    mul_mem := by
      intro x y hx hy
      show φ (SA.mul x y) = ψ (SA.mul x y)
      calc φ (SA.mul x y) = SB.mul (φ x) (φ y) := hφ.map_mul x y
        _ = SB.mul (ψ x) (φ y) := by rw [show φ x = ψ x from hx]
        _ = SB.mul (ψ x) (ψ y) := by rw [show φ y = ψ y from hy]
        _ = ψ (SA.mul x y) := (hψ.map_mul x y).symm
    smul_mem := by
      intro l x hx
      show φ (SA.smul l x) = ψ (SA.smul l x)
      calc φ (SA.smul l x) = SB.smul l (φ x) := hφ.map_smul l x
        _ = SB.smul l (ψ x) := by rw [show φ x = ψ x from hx]
        _ = ψ (SA.smul l x) := (hψ.map_smul l x).symm }
  have hXE : X ⊆ E := fun x hx => hagree x hx
  have hEuniv : E = Set.univ := hX E hE hXE
  have ha : a ∈ E := by rw [hEuniv]; exact Set.mem_univ a
  exact ha

/-- 本文 `claim_composition_of_algebra_homomorphisms_is_algebra_homomorphism`：ψ ∘ φ は ℂ-代数の準同型。 -/
theorem IsComplexAlgebraHomomorphism.comp {SA : ComplexAlgebra A} {SB : ComplexAlgebra B}
    {SC : ComplexAlgebra C} {φ : A → B} {ψ : B → C} (hφ : IsComplexAlgebraHomomorphism SA SB φ)
    (hψ : IsComplexAlgebraHomomorphism SB SC ψ) :
    IsComplexAlgebraHomomorphism SA SC (fun x => ψ (φ x)) := by
  have hadd : ∀ x y : A, ψ (φ (SA.add x y)) = SC.add (ψ (φ x)) (ψ (φ y)) := by
    intro x y
    calc ψ (φ (SA.add x y)) = ψ (SB.add (φ x) (φ y)) := by rw [hφ.map_add x y]
      _ = SC.add (ψ (φ x)) (ψ (φ y)) := hψ.map_add (φ x) (φ y)
  have hmul : ∀ x y : A, ψ (φ (SA.mul x y)) = SC.mul (ψ (φ x)) (ψ (φ y)) := by
    intro x y
    calc ψ (φ (SA.mul x y)) = ψ (SB.mul (φ x) (φ y)) := by rw [hφ.map_mul x y]
      _ = SC.mul (ψ (φ x)) (ψ (φ y)) := hψ.map_mul (φ x) (φ y)
  have hone : ψ (φ SA.one) = SC.one := by
    calc ψ (φ SA.one) = ψ SB.one := by rw [hφ.map_one]
      _ = SC.one := hψ.map_one
  have hsmul : ∀ (l : ℂ) (x : A), ψ (φ (SA.smul l x)) = SC.smul l (ψ (φ x)) := by
    intro l x
    calc ψ (φ (SA.smul l x)) = ψ (SB.smul l (φ x)) := by rw [hφ.map_smul l x]
      _ = SC.smul l (ψ (φ x)) := hψ.map_smul l (φ x)
  exact ⟨⟨hadd, hmul, hone⟩, ⟨hadd, hsmul⟩⟩

/-- 本文 `claim_identity_map_is_algebra_homomorphism`：id_A は ℂ-代数の準同型。 -/
theorem isComplexAlgebraHomomorphism_id (SA : ComplexAlgebra A) :
    IsComplexAlgebraHomomorphism SA SA (fun x => x) :=
  ⟨⟨fun _ _ => rfl, fun _ _ => rfl, rfl⟩, ⟨fun _ _ => rfl, fun _ _ => rfl⟩⟩

/-- 本文 `claim_algebra_homomorphism_maps_ordered_product_to_ordered_product`：
φ(∏_{A,k=1}^{n} x_k) = ∏_{B,k=1}^{n} φ(x_k)。φ(Π^A_m) = Π^B_m を m の帰納法で示す。 -/
theorem IsComplexAlgebraHomomorphism.map_orderedProduct {SA : ComplexAlgebra A}
    {SB : ComplexAlgebra B} {φ : A → B} (hφ : IsComplexAlgebraHomomorphism SA SB φ) (n : ℕ)
    (x : ℕ → A) : φ (orderedProduct SA n x) = orderedProduct SB n (fun k => φ (x k)) := by
  have hm : ∀ m : ℕ, φ (partialOrderedProduct SA x m)
      = partialOrderedProduct SB (fun k => φ (x k)) m := by
    intro m
    induction m with
    | zero => calc
        φ (partialOrderedProduct SA x 0) = φ SA.one := rfl
        _ = SB.one := hφ.map_one
        _ = partialOrderedProduct SB (fun k => φ (x k)) 0 := rfl
    | succ m ih => calc
        φ (partialOrderedProduct SA x (m + 1))
            = φ (SA.mul (partialOrderedProduct SA x m) (x (m + 1))) := rfl
        _ = SB.mul (φ (partialOrderedProduct SA x m)) (φ (x (m + 1))) := hφ.map_mul _ _
        _ = SB.mul (partialOrderedProduct SB (fun k => φ (x k)) m) (φ (x (m + 1))) := by rw [ih]
        _ = partialOrderedProduct SB (fun k => φ (x k)) (m + 1) := rfl
  exact hm n

end CliffordMatrixIsomorphism.ComplexAlgebra
