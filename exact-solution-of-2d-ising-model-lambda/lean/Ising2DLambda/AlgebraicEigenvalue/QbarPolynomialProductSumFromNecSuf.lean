/-
「多項式の有限和の積の添字写像展開」の必要十分版からの導出。
必要十分版の部分集合の帰納法へ、成分型を一定の B、値の可換半環を Polynomial Qbar として
供給する。部分集合版では A の有限性は要らず、全体集合に取る段で初めて要る。
係数の代数閉性・除法・減法・多項式の次数は使わない。
具体版の 𝔉(S)（QbarFiniteMapsOn）と必要十分版の FamilyOn は同じ写像の型で、
和の添字の取り替えは恒等の往復で済む。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialProductSum
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitProduct

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset

variable {A B : Type*} [DecidableEq A] [Fintype B]

/-- 具体版の 𝔉(S) と必要十分版の組の全体の往復。値を作り直さない。 -/
def qbarFiniteMapsOnEquivFamilyOn (S : Finset A) :
    QbarFiniteMapsOn B S ≃ NecSuf.AlgebraicEigenvalue.FamilyOn (fun _ : A => B) S where
  toFun f := f
  invFun f := f
  left_inv _ := rfl
  right_inv _ := rfl

/-- 部分集合上の帰納法へ、実際の多項式の値を供給する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_family_from_necSuf
    (g : A → B → Polynomial Qbar) (S : Finset A) :
    (∏ i ∈ S, ∑ b : B, g i b) =
      ∑ f : QbarFiniteMapsOn B S, qbarProductSumWeight g S f := by
  calc
    (∏ i ∈ S, ∑ b : B, g i b) =
        ∑ f : NecSuf.AlgebraicEigenvalue.FamilyOn (fun _ : A => B) S,
          ∏ i ∈ S.attach, g i.1 (f i.1 i.2) :=
      NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_family
        (B := fun _ : A => B) (R := Polynomial Qbar) g S
    _ = ∑ f : QbarFiniteMapsOn B S, qbarProductSumWeight g S f :=
      (Equiv.sum_comp (qbarFiniteMapsOnEquivFamilyOn S)
        (fun f => ∏ i ∈ S.attach, g i.1 (f i.1 i.2))).symm

/-- 全体集合上の再添字付けへ、実際の多項式の値と有限添字型を供給する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_pi_from_necSuf [Fintype A]
    (g : A → B → Polynomial Qbar) :
    (∏ i : A, ∑ b : B, g i b) = ∑ f : A → B, ∏ i : A, g i (f i) := by
  exact NecSuf.AlgebraicEigenvalue.prod_sum_eq_sum_prod_pi
    (B := fun _ : A => B) (R := Polynomial Qbar) g

end Ising2DLambda.AlgebraicEigenvalue
