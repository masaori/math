/-
「多項式の有限和の積の添字写像展開」の必要十分版からの導出。
既存の同じ部分集合の帰納法へ、成分型を一定の B、値の可換半環を Polynomial Qbar として
供給する。部分集合版では A の有限性は要らず、全体集合に取る段で初めて要る。
係数の代数閉性・除法・減法・多項式の次数は使わない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialProductSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (FamilyOn)

variable {A B : Type*} [DecidableEq A] [Fintype B]

/-- 部分集合上の帰納法へ、実際の多項式の値を供給する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_family_from_necSuf
    (g : A → B → Polynomial Qbar) (S : Finset A) :
    (∏ i ∈ S, ∑ b : B, g i b) =
      ∑ f : FamilyOn (fun _ : A => B) S, ∏ i ∈ S.attach, g i.1 (f i.1 i.2) := by
  exact NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_family
    (B := fun _ : A => B) (R := Polynomial Qbar) g S

/-- 全体集合上の再添字付けへ、実際の多項式の値と有限添字型を供給する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_pi_from_necSuf [Fintype A]
    (g : A → B → Polynomial Qbar) :
    (∏ i : A, ∑ b : B, g i b) = ∑ f : A → B, ∏ i : A, g i (f i) := by
  exact NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_pi
    (B := fun _ : A => B) (R := Polynomial Qbar) g

end Ising2DLambda.AlgebraicEigenvalue
