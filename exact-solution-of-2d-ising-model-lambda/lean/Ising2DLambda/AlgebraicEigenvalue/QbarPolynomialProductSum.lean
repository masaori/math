/-
「多項式の有限和の積の添字写像展開」の具体版。値は Polynomial Qbar に固定する。
部分集合の空集合・一点追加による帰納法を独立に実装し、最後に全体集合を代入する。
FamilyOn、空集合上の写像の一意性、insertFamilyEquiv、その重みの因子分離だけを
既存の局所補題から使う。積和展開の既製定理や必要十分版の全体定理は使わない。
住処は Qbar。実数・複素数を経由しない。
-/
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.ShiftCharOrbitProduct
import Mathlib.Algebra.Polynomial.Basic

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset
open Ising2DLambda.NecSuf.AlgebraicEigenvalue
  (FamilyOn insertFamilyEquiv prod_attach_insertFamily familyOnUnivEquiv)

variable {A B : Type*} [DecidableEq A] [Fintype B]

/-- 本文の部分集合上の主張。空集合の三等号と、一点追加の七等号をそのまま辿る。
空集合上の写像は、値域 B が空でもただ一つ存在する。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_family
    (g : A → B → Polynomial Qbar) (S : Finset A) :
    (∏ i ∈ S, ∑ b : B, g i b) =
      ∑ f : FamilyOn (fun _ : A => B) S, ∏ i ∈ S.attach, g i.1 (f i.1 i.2) := by
  classical
  induction S using Finset.induction_on with
  | empty =>
      calc
        (∏ i ∈ (∅ : Finset A), ∑ b : B, g i b) = 1 := Finset.prod_empty
        _ = ∑ _f : FamilyOn (fun _ : A => B) (∅ : Finset A),
            (1 : Polynomial Qbar) := by simp
        _ = ∑ f : FamilyOn (fun _ : A => B) (∅ : Finset A),
            ∏ i ∈ (∅ : Finset A).attach, g i.1 (f i.1 i.2) := by
          refine Finset.sum_congr rfl ?_
          intro f _
          simp
  | insert i₀ S hi₀ ih =>
      let W : FamilyOn (fun _ : A => B) S → Polynomial Qbar :=
        fun f => ∏ i ∈ S.attach, g i.1 (f i.1 i.2)
      let V : FamilyOn (fun _ : A => B) (insert i₀ S) → Polynomial Qbar :=
        fun h => ∏ i ∈ (insert i₀ S).attach, g i.1 (h i.1 i.2)
      calc
        (∏ i ∈ insert i₀ S, ∑ b : B, g i b) =
            (∑ b : B, g i₀ b) * ∏ i ∈ S, ∑ b : B, g i b :=
          Finset.prod_insert hi₀
        _ = (∑ b : B, g i₀ b) * ∑ f : FamilyOn (fun _ : A => B) S, W f :=
          congrArg ((∑ b : B, g i₀ b) * ·) ih
        _ = ∑ b : B, g i₀ b * (∑ f : FamilyOn (fun _ : A => B) S, W f) :=
          Finset.sum_mul _ _ _
        _ = ∑ b : B, ∑ f : FamilyOn (fun _ : A => B) S, g i₀ b * W f := by
          refine Finset.sum_congr rfl ?_
          intro b _
          exact Finset.mul_sum _ _ _
        _ = ∑ p : B × FamilyOn (fun _ : A => B) S, g i₀ p.1 * W p.2 := by
          rw [Fintype.sum_prod_type]
        _ = ∑ p : B × FamilyOn (fun _ : A => B) S,
            V (insertFamilyEquiv (B := fun _ : A => B) hi₀ p) := by
          refine Finset.sum_congr rfl ?_
          intro p _
          exact (prod_attach_insertFamily hi₀ g p.1 p.2).symm
        _ = ∑ h : FamilyOn (fun _ : A => B) (insert i₀ S), V h :=
          Equiv.sum_comp (insertFamilyEquiv (B := fun _ : A => B) hi₀) V

/-- 本文の最終段。部分集合を全体集合に取り、重みの定義を展開し、所属の証明を
受け取る写像から通常の写像へ再添字付けする。A、B の空集合を除かない。 -/
theorem qbarPolynomial_prod_sum_eq_sum_prod_pi [Fintype A]
    (g : A → B → Polynomial Qbar) :
    (∏ i : A, ∑ b : B, g i b) = ∑ f : A → B, ∏ i : A, g i (f i) := by
  classical
  let W : FamilyOn (fun _ : A => B) (univ : Finset A) → Polynomial Qbar :=
    fun f => ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1 i.2)
  calc
    (∏ i : A, ∑ b : B, g i b) =
        ∑ f : FamilyOn (fun _ : A => B) (univ : Finset A), W f :=
      qbarPolynomial_prod_sum_eq_sum_prod_family g univ
    _ = ∑ f : FamilyOn (fun _ : A => B) (univ : Finset A),
        ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1 i.2) := rfl
    _ = ∑ f : A → B, ∏ i : A, g i (f i) := by
      calc
        _ = ∑ f : A → B, ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1) :=
          Equiv.sum_comp (familyOnUnivEquiv (fun _ : A => B))
            (fun f => ∏ i ∈ (univ : Finset A).attach, g i.1 (f i.1))
        _ = ∑ f : A → B, ∏ i : A, g i (f i) := by
          refine Finset.sum_congr rfl ?_
          intro f _
          exact Finset.prod_attach (univ : Finset A) (fun i => g i (f i))

end Ising2DLambda.AlgebraicEigenvalue
