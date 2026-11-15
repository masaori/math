/-
章「同型の証明」の節「系：奇数次元の二次空間」のうち、一般の ℂ-代数についての主張の具体版が、
必要十分版の K := ℂ への特殊化から得られることを示す導出版。具体版のファイルは必要十分版を引かない。このファイルだけが両方を引く。

  具体版                                   必要十分版の特殊化
  ProductAlgebra.add 等の演算              productAlgebra_toNecSuf（具体版の直積を K := ℂ の代数として読むと、必要十分版の直積と同じ。rfl）
  productAlgebra                           productAlgebra_of_necSuf と、具体版との一致 productAlgebra_eq_of_necSuf（rfl）
  pairMap                                  pairMap_eq_necSuf（rfl）
  pairMap_isHom                            pairMap_isHom_of_necSuf
  square_of_add_smul_of_anticommuting      square_of_add_smul_of_anticommuting_of_necSuf

ℂ から渡す性質は、平方の主張の 0 + 0 = 0（`add_zero 0`）と a · 0 = 0（`mul_zero`）だけである。
-/
import CliffordMatrixIsomorphism.Isomorphism.OddDimensional.ProductOfAlgebras
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexAlgebra.ComplexAlgebraFromNecSuf
import CliffordMatrixIsomorphism.NecSuf.Isomorphism.OddDimensional.ProductOfAlgebras

namespace CliffordMatrixIsomorphism.ComplexAlgebra

universe u v w

variable {A₁ : Type u} {A₂ : Type v} {C : Type w} {A : Type u}

/-- 本文 `claim_product_of_two_complex_algebras_is_complex_algebra` を、必要十分版から得たもの。 -/
def productAlgebra_of_necSuf (S₁ : ComplexAlgebra A₁) (S₂ : ComplexAlgebra A₂) : ComplexAlgebra (A₁ × A₂) :=
  let N := NecSuf.AlgebraOver.productAlgebra S₁.toNecSuf S₂.toNecSuf
  { toUnitalRing := N.toUnitalRing
    smul := N.smul
    smul_assoc := N.smul_assoc
    one_smul := N.one_smul
    smul_add := N.smul_add
    add_smul := N.add_smul
    smul_mul_left := N.smul_mul_left
    smul_mul_right := N.smul_mul_right }

/-- 具体版の直積の ℂ-代数は、必要十分版から作った ℂ-代数と同じ組である（どの演算も成分ごとの同じ式）。 -/
theorem productAlgebra_eq_of_necSuf (S₁ : ComplexAlgebra A₁) (S₂ : ComplexAlgebra A₂) :
    productAlgebra S₁ S₂ = productAlgebra_of_necSuf S₁ S₂ := rfl

/-- 本文 `claim_product_of_two_complex_algebras_is_complex_algebra` の具体版の組を必要十分版の代数として読むと、
必要十分版の直積と同じ。 -/
theorem productAlgebra_toNecSuf (S₁ : ComplexAlgebra A₁) (S₂ : ComplexAlgebra A₂) :
    (productAlgebra S₁ S₂).toNecSuf = NecSuf.AlgebraOver.productAlgebra S₁.toNecSuf S₂.toNecSuf := rfl

/-- 本文 `def_pair_of_maps_into_product_of_algebras`：具体版の ⟨φ₁, φ₂⟩ は必要十分版の ⟨φ₁, φ₂⟩ と同じ。 -/
theorem pairMap_eq_necSuf (φ₁ : C → A₁) (φ₂ : C → A₂) :
    pairMap φ₁ φ₂ = NecSuf.AlgebraOver.pairMap φ₁ φ₂ := rfl

/-- 本文 `claim_pair_of_algebra_homomorphisms_is_algebra_homomorphism` を、必要十分版から得たもの。 -/
theorem pairMap_isHom_of_necSuf {SC : ComplexAlgebra C} {S₁ : ComplexAlgebra A₁} {S₂ : ComplexAlgebra A₂}
    {φ₁ : C → A₁} {φ₂ : C → A₂} (h₁ : IsComplexAlgebraHomomorphism SC S₁ φ₁)
    (h₂ : IsComplexAlgebraHomomorphism SC S₂ φ₂) :
    IsComplexAlgebraHomomorphism SC (productAlgebra S₁ S₂) (pairMap φ₁ φ₂) := by
  rw [isComplexAlgebraHomomorphism_iff_necSuf, productAlgebra_toNecSuf, pairMap_eq_necSuf]
  exact NecSuf.AlgebraOver.pairMap_isHom ((isComplexAlgebraHomomorphism_iff_necSuf SC S₁ φ₁).1 h₁)
    ((isComplexAlgebraHomomorphism_iff_necSuf SC S₂ φ₂).1 h₂)

/-- 本文 `claim_square_of_sum_with_multiple_of_anticommuting_square_root_of_unity` を、
必要十分版に ℂ の 0 + 0 = 0 と a · 0 = 0 を渡して得たもの。 -/
theorem square_of_add_smul_of_anticommuting_of_necSuf (SA : ComplexAlgebra A) (X Y : A) (α : ℂ)
    (hX : SA.mul X X = SA.smul α SA.one) (hY : SA.mul Y Y = SA.one)
    (hXY : SA.add (SA.mul X Y) (SA.mul Y X) = SA.zero) (s : ℂ) :
    SA.mul (SA.add X (SA.smul s Y)) (SA.add X (SA.smul s Y)) = SA.smul (α + s * s) SA.one :=
  NecSuf.AlgebraOver.square_of_add_smul_of_anticommuting SA.toNecSuf X Y (_root_.add_zero 0) mul_zero α
    hX hY hXY s

end CliffordMatrixIsomorphism.ComplexAlgebra
