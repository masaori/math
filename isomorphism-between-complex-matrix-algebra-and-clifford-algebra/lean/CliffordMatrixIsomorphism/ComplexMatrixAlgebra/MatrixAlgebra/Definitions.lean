/-
章「複素行列環」の、有限集合で添字づけた行列の集合と演算の定義の具体版。人手証明と 1 対 1 に対応させる。
mathlib の `Matrix` は使わない。

  本文のラベル                                  このファイル
  def_matrices_indexed_by_finite_set            Mat・Mat.entry・Mat.ext・Mat.add・Mat.mul・Mat.smul・Mat.zero・Mat.one

Mat_X(ℂ) は本文どおり写像 X × X → ℂ の集合で、A_{x,y} := A((x,y)) は `Mat.entry A x y`。
行列の積の成分 Σ_{z∈X} A_{x,z} ·_{ℂ^vec} B_{z,y} は、ℂ-線型空間 ℂ^vec（`complexNumbersVectorSpace`）の中の
有限集合 X の上の和 `sumOverFiniteSet` で書く。和を定めるのに X が有限集合であることの証明 hX が要るので、
積は hX を引数にとる。単位行列の成分 δ_{x,y} は X の等号の判定 `[DecidableEq X]` を使う。

必要十分版は `NecSuf/ComplexMatrixAlgebra/MatrixAlgebra/Definitions.lean`。
-/
import CliffordMatrixIsomorphism.MathematicalToolkit.FiniteSetSum.SumOverFiniteSet
import CliffordMatrixIsomorphism.MathematicalToolkit.ComplexVectorSpace.ComplexNumbersAsVectorSpace

namespace CliffordMatrixIsomorphism.ComplexMatrixAlgebra

open CliffordMatrixIsomorphism.ComplexVectorSpace

universe u

/-- 本文 `def_matrices_indexed_by_finite_set`：Mat_X(ℂ) は写像 X × X → ℂ の集合。 -/
def Mat (X : Type u) : Type u := X × X → ℂ

namespace Mat

variable {X : Type u}

/-- 本文 `def_matrices_indexed_by_finite_set`：A_{x,y} := A((x,y))。 -/
def entry (A : Mat X) (x y : X) : ℂ := A (x, y)

/-- 本文 `def_matrices_indexed_by_finite_set`：A = B は、すべての x, y で A_{x,y} = B_{x,y} であること。 -/
theorem ext {A B : Mat X} (h : ∀ x y : X, entry A x y = entry B x y) : A = B :=
  funext fun p => h p.1 p.2

/-- 本文 `def_matrices_indexed_by_finite_set`：(A +_{Mat_X} B)_{x,y} := A_{x,y} +_ℂ B_{x,y}。 -/
def add (A B : Mat X) : Mat X := fun p => entry A p.1 p.2 + entry B p.1 p.2

/-- 本文 `def_matrices_indexed_by_finite_set`：(A ·_{Mat_X} B)_{x,y} := Σ_{z∈X} A_{x,z} ·_{ℂ^vec} B_{z,y}。 -/
noncomputable def mul (hX : IsFiniteSet X) (A B : Mat X) : Mat X := fun p =>
  sumOverFiniteSet complexNumbersVectorSpace hX (fun z => entry A p.1 z) (fun z => entry B z p.2)

/-- 本文 `def_matrices_indexed_by_finite_set`：(λ ∗_{Mat_X} A)_{x,y} := λ ·_ℂ A_{x,y}。 -/
def smul (l : ℂ) (A : Mat X) : Mat X := fun p => l * entry A p.1 p.2

/-- 本文 `def_matrices_indexed_by_finite_set`：(0_{Mat_X})_{x,y} := 0_ℂ。 -/
def zero : Mat X := fun _ => 0

/-- 本文 `def_matrices_indexed_by_finite_set`：(1_{Mat_X})_{x,y} := δ_{x,y}。 -/
def one [DecidableEq X] : Mat X := fun p => kroneckerDelta p.1 p.2

theorem entry_add (A B : Mat X) (x y : X) : entry (add A B) x y = entry A x y + entry B x y := rfl

theorem entry_mul (hX : IsFiniteSet X) (A B : Mat X) (x y : X) :
    entry (mul hX A B) x y
      = sumOverFiniteSet complexNumbersVectorSpace hX (fun z => entry A x z) (fun z => entry B z y) :=
  rfl

theorem entry_smul (l : ℂ) (A : Mat X) (x y : X) : entry (smul l A) x y = l * entry A x y := rfl

theorem entry_zero (x y : X) : entry (zero : Mat X) x y = 0 := rfl

theorem entry_one [DecidableEq X] (x y : X) : entry (one : Mat X) x y = kroneckerDelta x y := rfl

end Mat

end CliffordMatrixIsomorphism.ComplexMatrixAlgebra
