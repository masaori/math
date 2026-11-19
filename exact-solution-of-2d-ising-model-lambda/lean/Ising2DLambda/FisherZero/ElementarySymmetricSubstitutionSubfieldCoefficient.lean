/-
節「基本対称式への代入」の具体版（部分体係数を保つことの部分）。

  人手証明                                                          このファイル
  主張 `claim_subfield_coefficient_multivariate_constant`             `C_mem_subfieldCoefficientMvPolys`
    a が零写像のとき・そうでないときの二つの場合                     `MvPolynomial.coeff_C` の `if` の二つの枝
  主張 `claim_subfield_coefficient_multivariate_variable`             `X_mem_subfieldCoefficientMvPolys`
    a = δ_k のとき・そうでないときの二つの場合                       `MvPolynomial.coeff_X` の `if` の二つの枝
  主張 `claim_subfield_coefficient_multivariate_finite_sum`           `sum_mem_subfieldCoefficientMvPolys`
    I が空のとき（空の和は零元、零元の係数は 0）                   `Finset.sum_empty`・`MvPolynomial.coeff_zero`
    I = {i₀} ⊔ I' のとき（和の係数）                               `Finset.sum_insert`・`MvPolynomial.coeff_add`
  主張 `claim_subfield_coefficient_multivariate_finite_product`       `prod_mem_subfieldCoefficientMvPolys`
    I が空のとき（空の積は単位元 mk_n(1)）                         `Finset.prod_empty`・`MvPolynomial.C_1`
    I = {i₀} ⊔ I' のとき（積の係数）                               `Finset.prod_insert`・`MvPolynomial.coeff_mul`
  主張 `claim_qbar_elementary_symmetric_subfield_coefficient`         `elementarySymmetric_mem_subfieldCoefficientMvPolys`
  主張 `claim_elementary_symmetric_substitution_subfield_coefficient` `elementarySymmetricSubst_mem_subfieldCoefficientMvPolys`
    第一の準備（二元の積、冪）                                     `mul_mem_subfieldCoefficientMvPolys`・
                                                                    `pow_mem_subfieldCoefficientMvPolys`
    第二の準備（ee_n(k) = es_{n,k+1} ∈ F[X_{<n}]）                 同じ名前の `have`
    T_a ∈ F[X_{<n}]                                                同じ名前の `have`
    式鎖の第二の等号（ms_y の定義の有限和）                       `MvPolynomial.aeval_def`・`MvPolynomial.eval₂_eq'`

本文の帰納法「I の元の個数について、i₀ ∈ I を取り I' = I \ {i₀}」は、`Finset.induction_on` の
`insert i₀ I'`（`i₀ ∉ I'`）で読む。どちらも I = {i₀} ⊔ I' と分けて I' に帰納法の仮定を使う。
本文の ms_y の和の添字 A_Q = {a | mco_a(Q) ≠ 0} は `Q.support`。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SymmetricVanishingDivisibleByProduct
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSymmetric

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `claim_subfield_coefficient_multivariate_constant` の具体版。`c ∈ F` なら `mk_n(c) ∈ F[X_{<n}]`。 -/
theorem C_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} {c : Qbar} (hc : c ∈ F) :
    (C c : QbarMvPoly n) ∈ subfieldCoefficientMvPolys F n := by
  intro a
  rw [coeff_C]
  split_ifs
  · -- a が零写像のとき: mco_a(mk_n(c)) = c ∈ F。
    exact hc
  · -- a が零写像でないとき: mco_a(mk_n(c)) = 0 ∈ F。
    exact F.zero_mem

/-- `claim_subfield_coefficient_multivariate_variable` の具体版。`X^{(n)}_k ∈ F[X_{<n}]`。 -/
theorem X_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} (k : Fin n) :
    (X k : QbarMvPoly n) ∈ subfieldCoefficientMvPolys F n := by
  classical
  intro a
  rw [coeff_X]
  split_ifs
  · -- a = δ_k のとき: mco_a(X_k) = 1 ∈ F。
    exact F.one_mem
  · -- a ≠ δ_k のとき: mco_a(X_k) = 0 ∈ F。
    exact F.zero_mem

/-- `claim_subfield_coefficient_multivariate_finite_sum` の具体版。 -/
theorem sum_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} {ι : Type} (I : Finset ι)
    (P : ι → QbarMvPoly n) (hP : ∀ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n) :
    ∑ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    -- I が空のとき: mco_a(0) = 0 ∈ F。
    intro a
    rw [Finset.sum_empty, coeff_zero]
    exact F.zero_mem
  | insert i₀ I' hi₀ ih =>
    -- I = {i₀} ⊔ I' のとき: mco_a(P(i₀) + Σ_{I'} P) = mco_a(P(i₀)) + mco_a(Σ_{I'} P) ∈ F。
    have hI' : ∑ i ∈ I', P i ∈ subfieldCoefficientMvPolys F n :=
      ih (fun i hi => hP i (Finset.mem_insert_of_mem hi))
    intro a
    rw [Finset.sum_insert hi₀, coeff_add]
    exact F.add_mem (hP i₀ (Finset.mem_insert_self i₀ I') a) (hI' a)

/-- `claim_subfield_coefficient_multivariate_finite_product` の具体版。 -/
theorem prod_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} {ι : Type} (I : Finset ι)
    (P : ι → QbarMvPoly n) (hP : ∀ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n) :
    ∏ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    -- I が空のとき: 空の積は単位元 mk_n(1)、1 ∈ F。
    rw [Finset.prod_empty, ← C_1]
    exact C_mem_subfieldCoefficientMvPolys F F.one_mem
  | insert i₀ I' hi₀ ih =>
    -- I = {i₀} ⊔ I' のとき: 積の係数は Σ_{b+c=a} mco_b(P(i₀)) · mco_c(Π_{I'} P) ∈ F。
    have hI' : ∏ i ∈ I', P i ∈ subfieldCoefficientMvPolys F n :=
      ih (fun i hi => hP i (Finset.mem_insert_of_mem hi))
    intro a
    rw [Finset.prod_insert hi₀, coeff_mul]
    exact F.sum_mem (fun x _ => F.mul_mem (hP i₀ (Finset.mem_insert_self i₀ I') x.1) (hI' x.2))

/-- `claim_qbar_elementary_symmetric_subfield_coefficient` の具体版。`es_{n,j} ∈ F[X_{<n}]`。 -/
theorem elementarySymmetric_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) (n j : ℕ) :
    qbarElementarySymmetric n j ∈ subfieldCoefficientMvPolys F n := by
  unfold qbarElementarySymmetric
  -- 有限和（j 元部分集合の全体）の各項は変数の有限積。
  exact sum_mem_subfieldCoefficientMvPolys F _ _ (fun S _ =>
    prod_mem_subfieldCoefficientMvPolys F S _ (fun k _ => X_mem_subfieldCoefficientMvPolys F k))

/-- `claim_elementary_symmetric_substitution_subfield_coefficient` の第一の準備（二元の積）。
`I = {0, 1}`、`P(0) = A`、`P(1) = B` に有限積の主張を使う。 -/
theorem mul_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} {A B : QbarMvPoly n}
    (hA : A ∈ subfieldCoefficientMvPolys F n) (hB : B ∈ subfieldCoefficientMvPolys F n) :
    A * B ∈ subfieldCoefficientMvPolys F n := by
  have h := prod_mem_subfieldCoefficientMvPolys F (Finset.univ : Finset (Fin 2)) ![A, B]
    (fun i _ => by fin_cases i <;> simpa)
  rwa [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one, Matrix.cons_val_fin_one] at h

/-- `claim_elementary_symmetric_substitution_subfield_coefficient` の第一の準備（冪）。
`A^e = ∏_{i ∈ ℕ_{<e}} A` に有限積の主張を使う。 -/
theorem pow_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ} {A : QbarMvPoly n}
    (hA : A ∈ subfieldCoefficientMvPolys F n) (e : ℕ) :
    A ^ e ∈ subfieldCoefficientMvPolys F n := by
  have h := prod_mem_subfieldCoefficientMvPolys F (Finset.range e) (fun _ => A) (fun _ _ => hA)
  rwa [Finset.prod_const, Finset.card_range] at h

/-- `claim_elementary_symmetric_substitution_subfield_coefficient` の具体版。
`Q ∈ F[X_{<n}]` なら `se_n(Q) ∈ F[X_{<n}]`。 -/
theorem elementarySymmetricSubst_mem_subfieldCoefficientMvPolys (F : Subfield Qbar) {n : ℕ}
    (Q : QbarMvPoly n) (hQ : Q ∈ subfieldCoefficientMvPolys F n) :
    elementarySymmetricSubst n Q ∈ subfieldCoefficientMvPolys F n := by
  -- 第二の準備: ee_n(k) = es_{n,k+1} ∈ F[X_{<n}]。
  have hee : ∀ k : Fin n, elementarySymmetricValues n k ∈ subfieldCoefficientMvPolys F n :=
    fun k => elementarySymmetric_mem_subfieldCoefficientMvPolys F n (k.val + 1)
  -- T_a ∈ F[X_{<n}]。
  have hT : ∀ a ∈ Q.support, C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k ∈
      subfieldCoefficientMvPolys F n := fun a _ =>
    mul_mem_subfieldCoefficientMvPolys F (C_mem_subfieldCoefficientMvPolys F (hQ a))
      (prod_mem_subfieldCoefficientMvPolys F Finset.univ _
        (fun k _ => pow_mem_subfieldCoefficientMvPolys F (hee k) (a k)))
  -- se_n(Q) = ms_{ee_n}(Q) = Σ_{a ∈ A_Q} T_a ∈ F[X_{<n}]。
  have hexp : elementarySymmetricSubst n Q =
      ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k := by
    calc elementarySymmetricSubst n Q
        = qbarMvSubst (elementarySymmetricValues n) Q := rfl
      _ = ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k := by
          rw [qbarMvSubst, aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact sum_mem_subfieldCoefficientMvPolys F Q.support _ hT

end Ising2DLambda.FisherZero
