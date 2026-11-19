/-
節「基本対称式への代入」の具体版（全次数が重み付き次数以下であることの部分）。

  人手証明                                                          このファイル
  定義 `def_qbar_multivariate_weighted_degree`                       `exponentWeightedTotal`・`qbarWeightedDegree`
    最大元の性質（台の元の重み付き総和は重み付き次数以下）           `exponentWeightedTotal_le_qbarWeightedDegree`
  主張 `claim_qbar_total_degree_constant`                             `qbarTotalDegree_C`
  主張 `claim_qbar_total_degree_finite_sum_bound`                     `qbarTotalDegree_sum_le`
    和の係数は係数の和、零でない項が一つはある                       `MvPolynomial.coeff_sum`・`Finset.exists_ne_zero_of_sum_ne_zero`
  主張 `claim_qbar_total_degree_product_bound`                        `qbarTotalDegree_mul_le`
    指数の総和は和を和へ送る                                         `exponentTotal_add`
    積の零でない係数は零でない係数の積から来る                       `MvPolynomial.coeff_mul`・`left_ne_zero_of_mul`・`right_ne_zero_of_mul`
  主張 `claim_qbar_total_degree_finite_product_bound`                 `qbarTotalDegree_prod_le`
    I が空のとき（空の積は単位元 mk_n(1)）                         `Finset.prod_empty`・`MvPolynomial.C_1`
    I = {i₀} ⊔ I' のとき                                           `Finset.prod_insert`・`Finset.sum_insert`
  主張 `claim_qbar_elementary_symmetric_total_degree_bound`           `qbarTotalDegree_elementarySymmetric_le`
    準備（tdeg_n(X^{(n)}_k) ≤ 1）                                    `qbarTotalDegree_X_le`
  主張 `claim_elementary_symmetric_substitution_degree_bound`         `qbarTotalDegree_elementarySymmetricSubst_le`
    準備（冪の全次数）                                             `qbarTotalDegree_pow_le`
    T_a の評価の式鎖                                               同じ名前の `have` の `calc`

本文の帰納法「I の元の個数について、i₀ ∈ I を取り I' = I \ {i₀}」は、`Finset.induction_on` の
`insert i₀ I'`（`i₀ ∉ I'`）で読む。本文の A_Q = {a | mco_a(Q) ≠ 0} は `Q.support`。
全次数は mathlib の `MvPolynomial.totalDegree` を使わず、`qbarTotalDegree`（本文の定義）で述べる。

住処: Qbar（次数は ℕ）。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SymmetricVanishingDivisibleByProduct
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSymmetric

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_multivariate_weighted_degree` の重み付きの指数の総和 `wsz_n(a) = Σ_k (k+1)·a(k)`。 -/
def exponentWeightedTotal {n : ℕ} (a : Fin n →₀ ℕ) : ℕ :=
  ∑ k : Fin n, (k.val + 1) * a k

/-- `def_qbar_multivariate_weighted_degree` の重み付き次数 `wdeg_n(Q)`。 -/
noncomputable def qbarWeightedDegree {n : ℕ} (Q : QbarMvPoly n) : ℕ :=
  Q.support.sup exponentWeightedTotal

/-- `def_qbar_multivariate_weighted_degree` の最大元の性質。台の元の重み付き総和は重み付き次数以下。 -/
theorem exponentWeightedTotal_le_qbarWeightedDegree {n : ℕ} (Q : QbarMvPoly n) (a : Fin n →₀ ℕ)
    (ha : coeff a Q ≠ 0) : exponentWeightedTotal a ≤ qbarWeightedDegree Q :=
  Finset.le_sup (mem_support_iff.mpr ha)

/-- `claim_qbar_total_degree_constant` の具体版。`tdeg_n(mk_n(c)) = 0`。 -/
theorem qbarTotalDegree_C {n : ℕ} (c : Qbar) : qbarTotalDegree (C c : QbarMvPoly n) = 0 := by
  apply Nat.eq_zero_of_le_zero
  apply qbarTotalDegree_le_of_forall
  intro a ha
  rw [coeff_C] at ha
  split_ifs at ha with h
  · -- a が零写像のとき: sz_n(0) = 0。
    rw [← h]
    simp [exponentTotal]
  · -- a が零写像でないとき: 係数は 0 なので台に無い。
    exact absurd rfl ha

/-- `claim_qbar_total_degree_finite_sum_bound` の具体版。 -/
theorem qbarTotalDegree_sum_le {n : ℕ} {ι : Type} (I : Finset ι) (P : ι → QbarMvPoly n) (m : ℕ)
    (hP : ∀ i ∈ I, qbarTotalDegree (P i) ≤ m) : qbarTotalDegree (∑ i ∈ I, P i) ≤ m := by
  classical
  apply qbarTotalDegree_le_of_forall
  intro a ha
  -- mco_a(Σ_i P(i)) = Σ_i mco_a(P(i)) ≠ 0 なので、mco_a(P(i)) ≠ 0 となる i ∈ I がある。
  rw [coeff_sum] at ha
  obtain ⟨i, hi, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero ha
  calc exponentTotal a ≤ qbarTotalDegree (P i) := exponentTotal_le_qbarTotalDegree (P i) a hne
    _ ≤ m := hP i hi

/-- `claim_qbar_total_degree_product_bound` の準備。`sz_n(b + c) = sz_n(b) + sz_n(c)`。 -/
theorem exponentTotal_add {n : ℕ} (b c : Fin n →₀ ℕ) :
    exponentTotal (b + c) = exponentTotal b + exponentTotal c := by
  unfold exponentTotal
  rw [← Finset.sum_add_distrib]
  rfl

/-- `claim_qbar_total_degree_product_bound` の具体版。`tdeg_n(A·B) ≤ tdeg_n(A) + tdeg_n(B)`。 -/
theorem qbarTotalDegree_mul_le {n : ℕ} (A B : QbarMvPoly n) :
    qbarTotalDegree (A * B) ≤ qbarTotalDegree A + qbarTotalDegree B := by
  classical
  apply qbarTotalDegree_le_of_forall
  intro a ha
  -- mco_a(A·B) = Σ_{b+c=a} mco_b(A)·mco_c(B) ≠ 0 なので、零でない項 (b, c) がある。
  rw [coeff_mul] at ha
  obtain ⟨x, hx, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero ha
  rw [Finset.mem_antidiagonal] at hx
  have hb : coeff x.1 A ≠ 0 := left_ne_zero_of_mul hne
  have hc : coeff x.2 B ≠ 0 := right_ne_zero_of_mul hne
  calc exponentTotal a = exponentTotal (x.1 + x.2) := by rw [hx]
    _ = exponentTotal x.1 + exponentTotal x.2 := exponentTotal_add x.1 x.2
    _ ≤ qbarTotalDegree A + qbarTotalDegree B :=
        Nat.add_le_add (exponentTotal_le_qbarTotalDegree A _ hb)
          (exponentTotal_le_qbarTotalDegree B _ hc)

/-- `claim_qbar_total_degree_finite_product_bound` の具体版。 -/
theorem qbarTotalDegree_prod_le {n : ℕ} {ι : Type} (I : Finset ι) (P : ι → QbarMvPoly n) :
    qbarTotalDegree (∏ i ∈ I, P i) ≤ ∑ i ∈ I, qbarTotalDegree (P i) := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    -- I が空のとき: 空の積は単位元 mk_n(1) で、その全次数は 0。
    rw [Finset.prod_empty, Finset.sum_empty, ← C_1, qbarTotalDegree_C]
  | insert i₀ I' hi₀ ih =>
    -- I = {i₀} ⊔ I' のとき: 二元の積の上界と帰納法の仮定。
    rw [Finset.prod_insert hi₀, Finset.sum_insert hi₀]
    calc qbarTotalDegree (P i₀ * ∏ i ∈ I', P i)
        ≤ qbarTotalDegree (P i₀) + qbarTotalDegree (∏ i ∈ I', P i) := qbarTotalDegree_mul_le _ _
      _ ≤ qbarTotalDegree (P i₀) + ∑ i ∈ I', qbarTotalDegree (P i) := Nat.add_le_add_left ih _

/-- `claim_qbar_elementary_symmetric_total_degree_bound` の準備。`tdeg_n(X^{(n)}_k) ≤ 1`。 -/
theorem qbarTotalDegree_X_le {n : ℕ} (k : Fin n) : qbarTotalDegree (X k : QbarMvPoly n) ≤ 1 := by
  classical
  apply qbarTotalDegree_le_of_forall
  intro a ha
  rw [coeff_X] at ha
  split_ifs at ha with h
  · -- a = δ_k のとき: sz_n(δ_k) = 1。
    rw [← h]
    simp [exponentTotal, Finsupp.single_apply]
  · -- a ≠ δ_k のとき: 係数は 0 なので台に無い。
    exact absurd rfl ha

/-- `claim_qbar_elementary_symmetric_total_degree_bound` の具体版。`tdeg_n(es_{n,j}) ≤ j`。 -/
theorem qbarTotalDegree_elementarySymmetric_le (n j : ℕ) :
    qbarTotalDegree (qbarElementarySymmetric n j) ≤ j := by
  unfold qbarElementarySymmetric
  apply qbarTotalDegree_sum_le
  intro S hS
  rw [Finset.mem_powersetCard] at hS
  calc qbarTotalDegree (∏ k ∈ S, (X k : QbarMvPoly n))
      ≤ ∑ k ∈ S, qbarTotalDegree (X k : QbarMvPoly n) := qbarTotalDegree_prod_le S _
    _ ≤ ∑ _k ∈ S, 1 := Finset.sum_le_sum (fun k _ => qbarTotalDegree_X_le k)
    _ = S.card := by rw [Finset.sum_const, smul_eq_mul, mul_one]
    _ = j := hS.2

/-- `claim_elementary_symmetric_substitution_degree_bound` の準備（冪）。
`A^e = ∏_{i ∈ ℕ_{<e}} A` に有限積の上界を使う。 -/
theorem qbarTotalDegree_pow_le {n : ℕ} (A : QbarMvPoly n) (e : ℕ) :
    qbarTotalDegree (A ^ e) ≤ e * qbarTotalDegree A := by
  have h := qbarTotalDegree_prod_le (Finset.range e) (fun _ => A)
  rwa [Finset.prod_const, Finset.card_range, Finset.sum_const, Finset.card_range,
    smul_eq_mul] at h

/-- `claim_elementary_symmetric_substitution_degree_bound` の具体版。
`tdeg_n(se_n(Q)) ≤ wdeg_n(Q)`。 -/
theorem qbarTotalDegree_elementarySymmetricSubst_le {n : ℕ} (Q : QbarMvPoly n) :
    qbarTotalDegree (elementarySymmetricSubst n Q) ≤ qbarWeightedDegree Q := by
  -- 準備: tdeg_n(ee_n(k)) = tdeg_n(es_{n,k+1}) ≤ k + 1。
  have hee : ∀ k : Fin n, qbarTotalDegree (elementarySymmetricValues n k) ≤ k.val + 1 :=
    fun k => qbarTotalDegree_elementarySymmetric_le n (k.val + 1)
  -- 各 a ∈ A_Q で tdeg_n(T_a) ≤ wdeg_n(Q)。
  have hT : ∀ a ∈ Q.support,
      qbarTotalDegree (C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k) ≤
        qbarWeightedDegree Q := fun a ha =>
    calc qbarTotalDegree (C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k)
        ≤ qbarTotalDegree (C (coeff a Q) : QbarMvPoly n) +
            qbarTotalDegree (∏ k, elementarySymmetricValues n k ^ a k) :=
          qbarTotalDegree_mul_le _ _
      _ = qbarTotalDegree (∏ k, elementarySymmetricValues n k ^ a k) := by
          rw [qbarTotalDegree_C, zero_add]
      _ ≤ ∑ k, qbarTotalDegree (elementarySymmetricValues n k ^ a k) :=
          qbarTotalDegree_prod_le _ _
      _ ≤ ∑ k, a k * qbarTotalDegree (elementarySymmetricValues n k) :=
          Finset.sum_le_sum (fun k _ => qbarTotalDegree_pow_le _ _)
      _ ≤ ∑ k : Fin n, a k * (k.val + 1) :=
          Finset.sum_le_sum (fun k _ => Nat.mul_le_mul_left _ (hee k))
      _ = exponentWeightedTotal a :=
          Finset.sum_congr rfl (fun k _ => Nat.mul_comm _ _)
      _ ≤ qbarWeightedDegree Q :=
          exponentWeightedTotal_le_qbarWeightedDegree Q a (mem_support_iff.mp ha)
  -- se_n(Q) = Σ_{a ∈ A_Q} T_a。
  have hexp : elementarySymmetricSubst n Q =
      ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k := by
    calc elementarySymmetricSubst n Q
        = qbarMvSubst (elementarySymmetricValues n) Q := rfl
      _ = ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, elementarySymmetricValues n k ^ a k := by
          rw [qbarMvSubst, aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact qbarTotalDegree_sum_le Q.support _ _ hT

end Ising2DLambda.FisherZero
