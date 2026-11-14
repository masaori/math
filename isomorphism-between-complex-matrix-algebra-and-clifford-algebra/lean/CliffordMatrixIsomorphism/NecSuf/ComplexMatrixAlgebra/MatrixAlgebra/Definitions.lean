/-
章「複素行列環」の、有限集合で添字づけた行列の集合と演算の定義の必要十分版。具体版
`ComplexMatrixAlgebra/MatrixAlgebra/Definitions.lean` と同じ def を、係数 ℂ を型の変数 K に替えて書く。

行列の積の成分は K を自分自身の上の線型空間にした `coefficientsVec L` の中の有限集合の上の和なので、
積を定めるのに、その線型空間を作る K の八つの性質 `L : ValuedMapsLaws K` を引数にとる
（和の値は線型空間の演算の欄 +・·・0 だけで決まり、公理の証明には依らない）。
-/
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.NecSuf.MathematicalToolkit.TensorProduct.CoordinateConstruction

namespace CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.NecSuf.VectorSpace

universe u uK

/-- 本文 `def_matrices_indexed_by_finite_set` の必要十分版：Mat_X(K) は写像 X × X → K の集合。 -/
def Mat (K : Type uK) (X : Type u) : Type (max u uK) := X × X → K

namespace Mat

variable {K : Type uK} {X : Type u}

/-- A_{x,y} := A((x,y))。 -/
def entry (A : Mat K X) (x y : X) : K := A (x, y)

theorem ext {A B : Mat K X} (h : ∀ x y : X, entry A x y = entry B x y) : A = B :=
  funext fun p => h p.1 p.2

/-- (A + B)_{x,y} := A_{x,y} + B_{x,y}。 -/
def add [Add K] (A B : Mat K X) : Mat K X := fun p => entry A p.1 p.2 + entry B p.1 p.2

/-- (A · B)_{x,y} := Σ_{z∈X} A_{x,z} ·_{K^vec} B_{z,y}。 -/
noncomputable def mul [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (A B : Mat K X) : Mat K X := fun p =>
  sumOverFiniteSet (coefficientsVec L) hX (fun z => entry A p.1 z) (fun z => entry B z p.2)

/-- (λ ∗ A)_{x,y} := λ · A_{x,y}。 -/
def smul [Mul K] (l : K) (A : Mat K X) : Mat K X := fun p => l * entry A p.1 p.2

/-- (0)_{x,y} := 0。 -/
def zero [Zero K] : Mat K X := fun _ => 0

/-- (1)_{x,y} := δ_{x,y}。 -/
def one [Zero K] [One K] [DecidableEq X] : Mat K X := fun p => kroneckerDelta p.1 p.2

theorem entry_add [Add K] (A B : Mat K X) (x y : X) : entry (add A B) x y = entry A x y + entry B x y := rfl

theorem entry_mul [Add K] [Mul K] [One K] [Zero K] (L : ValuedMapsLaws K) (hX : IsFiniteSet X) (A B : Mat K X) (x y : X) :
    entry (mul L hX A B) x y
      = sumOverFiniteSet (coefficientsVec L) hX (fun z => entry A x z) (fun z => entry B z y) :=
  rfl

theorem entry_smul [Mul K] (l : K) (A : Mat K X) (x y : X) : entry (smul l A) x y = l * entry A x y := rfl

theorem entry_zero [Zero K] (x y : X) : entry (zero : Mat K X) x y = 0 := rfl

theorem entry_one [Zero K] [One K] [DecidableEq X] (x y : X) : entry (one : Mat K X) x y = kroneckerDelta x y := rfl

end Mat

end CliffordMatrixIsomorphism.NecSuf.ComplexMatrixAlgebra
