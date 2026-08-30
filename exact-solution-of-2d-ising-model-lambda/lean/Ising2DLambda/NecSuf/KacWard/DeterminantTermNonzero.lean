/-
必要十分版: 可換整域 R 上で、置換 σ に対応する `I - X C(A)` の成分積が非零であることと、
σ が動かす各添字 i で A i (σ i) が非零であることは同値である。

使う構造は有限積、零因子がないこと、多項式の定数項だけである。
-/
import Mathlib.LinearAlgebra.Matrix.Polynomial

namespace Ising2DLambda.NecSuf.KacWard

open Matrix Polynomial Equiv

noncomputable def determinantEntryProduct {R : Type} [CommRing R]
    {ι : Type} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι R) (σ : Equiv.Perm ι) : Polynomial R :=
  ∏ i, ((1 : Matrix ι ι (Polynomial R)) -
    (Polynomial.X : Polynomial R) • A.map Polynomial.C) i (σ i)

theorem determinantEntryProduct_ne_zero_iff {R : Type} [CommRing R]
    [IsDomain R] {ι : Type} [Fintype ι] [DecidableEq ι]
    (A : Matrix ι ι R) (σ : Equiv.Perm ι) :
    determinantEntryProduct A σ ≠ 0 ↔ ∀ i, σ i ≠ i → A i (σ i) ≠ 0 := by
  classical
  rw [determinantEntryProduct, Finset.prod_ne_zero_iff]
  constructor
  · intro h i hi
    have hfactor := h i (Finset.mem_univ i)
    simpa [hi, Ne.symm hi, Polynomial.C_ne_zero] using hfactor
  · intro h i _
    by_cases hi : σ i = i
    · have hconstant :
          (((1 : Matrix ι ι (Polynomial R)) -
            (Polynomial.X : Polynomial R) • A.map Polynomial.C) i (σ i)).coeff 0 = 1 := by
          simp [hi]
      intro hzero
      rw [hzero, Polynomial.coeff_zero] at hconstant
      exact zero_ne_one hconstant
    · simpa [hi, Ne.symm hi, Polynomial.C_ne_zero] using h i hi

end Ising2DLambda.NecSuf.KacWard
