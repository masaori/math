/-
節「基本対称式への代入」（部分体係数を保つことの部分）の六つの主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.elementarySymmetricSubst_mem_subfieldCoefficientMvPolys` ほか）と
同じ段（係数の場合分け、元の個数についての帰納法、二元の積と冪、有限和への展開）で示し、
各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `R` でよく、部分体 `F` の代わりに部分集合 `S ⊆ R` を置く。体であること・
  逆元・符号反転はどの段でも使わない。
- `S` について使うのは、零元を含むこと（`h0`。定数・変数の零の係数、空の和、積の係数の有限和）、
  単位元を含むこと（`h1`。変数の係数、空の積）、和で閉じること（`hadd`。有限和、積の係数）、
  積で閉じること（`hmul`。積の係数の各項）だけである。各定理はこのうち使うものだけを取る。
- 変数の集合 `σ` が有限であることは、基本対称式（全変数の `j` 元部分集合の和）と、
  代入の展開（全変数にわたる有限積）にだけ使う。
- 代入が係数を保つことは、代入する値 `y k` が全て `S` 係数であることだけから従う。
  具体版ではこれが第二の準備であり、そこで基本対称式であることを使う。
-/
import Mathlib.Algebra.MvPolynomial.Basic
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Data.Finset.Powerset
import Mathlib.Data.Fin.VecNotation
import Mathlib.Tactic.FinCases
import Mathlib.Algebra.BigOperators.Fin

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {R : Type} [CommSemiring R]

/-- 係数が全て `S` に属する多項式の全体（具体版の `subfieldCoefficientMvPolys` の一般化）。 -/
def coeffIn (S : Set R) (σ : Type) : Set (MvPolynomial σ R) :=
  {P | ∀ a : σ →₀ ℕ, coeff a P ∈ S}

/-- `claim_subfield_coefficient_multivariate_constant` の必要十分版。 -/
theorem C_mem_coeffIn_necSuf {S : Set R} {σ : Type} (h0 : (0 : R) ∈ S) {c : R} (hc : c ∈ S) :
    (C c : MvPolynomial σ R) ∈ coeffIn S σ := by
  classical
  intro a
  rw [coeff_C]
  split_ifs
  · exact hc
  · exact h0

/-- `claim_subfield_coefficient_multivariate_variable` の必要十分版。 -/
theorem X_mem_coeffIn_necSuf {S : Set R} {σ : Type} (h0 : (0 : R) ∈ S) (h1 : (1 : R) ∈ S)
    (k : σ) : (X k : MvPolynomial σ R) ∈ coeffIn S σ := by
  classical
  intro a
  rw [coeff_X]
  split_ifs
  · exact h1
  · exact h0

/-- `claim_subfield_coefficient_multivariate_finite_sum` の必要十分版。 -/
theorem sum_mem_coeffIn_necSuf {S : Set R} {σ ι : Type} (h0 : (0 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S) (I : Finset ι)
    (P : ι → MvPolynomial σ R) (hP : ∀ i ∈ I, P i ∈ coeffIn S σ) :
    ∑ i ∈ I, P i ∈ coeffIn S σ := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    intro a
    rw [Finset.sum_empty, coeff_zero]
    exact h0
  | insert i₀ I' hi₀ ih =>
    have hI' : ∑ i ∈ I', P i ∈ coeffIn S σ := ih (fun i hi => hP i (Finset.mem_insert_of_mem hi))
    intro a
    rw [Finset.sum_insert hi₀, coeff_add]
    exact hadd _ _ (hP i₀ (Finset.mem_insert_self i₀ I') a) (hI' a)

/-- `claim_subfield_coefficient_multivariate_finite_product` の必要十分版。
積の係数 `Σ_{b+c=a} mco_b · mco_c` が `S` に入るのに、零元（空の和）・和・積の閉性を使う。 -/
theorem prod_mem_coeffIn_necSuf {S : Set R} {σ ι : Type} (h0 : (0 : R) ∈ S) (h1 : (1 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (I : Finset ι) (P : ι → MvPolynomial σ R) (hP : ∀ i ∈ I, P i ∈ coeffIn S σ) :
    ∏ i ∈ I, P i ∈ coeffIn S σ := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    rw [Finset.prod_empty, ← C_1]
    exact C_mem_coeffIn_necSuf h0 h1
  | insert i₀ I' hi₀ ih =>
    have hI' : ∏ i ∈ I', P i ∈ coeffIn S σ := ih (fun i hi => hP i (Finset.mem_insert_of_mem hi))
    intro a
    rw [Finset.prod_insert hi₀, coeff_mul]
    exact Finset.sum_induction _ (· ∈ S) hadd h0
      (fun x _ => hmul _ _ (hP i₀ (Finset.mem_insert_self i₀ I') x.1) (hI' x.2))

/-- `claim_qbar_elementary_symmetric_subfield_coefficient` の必要十分版。 -/
theorem elementarySymmetric_mem_coeffIn_necSuf {S : Set R} {σ : Type} [Fintype σ]
    (h0 : (0 : R) ∈ S) (h1 : (1 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (j : ℕ) :
    (∑ T ∈ Finset.powersetCard j (Finset.univ : Finset σ), ∏ k ∈ T, (X k : MvPolynomial σ R)) ∈
      coeffIn S σ :=
  sum_mem_coeffIn_necSuf h0 hadd _ _ (fun T _ =>
    prod_mem_coeffIn_necSuf h0 h1 hadd hmul T _ (fun k _ => X_mem_coeffIn_necSuf h0 h1 k))

/-- `claim_elementary_symmetric_substitution_subfield_coefficient` の必要十分版（具体版と同じ段）。
値が全て `S` 係数の代入は `S` 係数を保つ。 -/
theorem aeval_mem_coeffIn_necSuf {S : Set R} {σ τ : Type} [Fintype σ]
    (h0 : (0 : R) ∈ S) (h1 : (1 : R) ∈ S)
    (hadd : ∀ x y : R, x ∈ S → y ∈ S → x + y ∈ S) (hmul : ∀ x y : R, x ∈ S → y ∈ S → x * y ∈ S)
    (y : σ → MvPolynomial τ R) (hy : ∀ k, y k ∈ coeffIn S τ)
    (Q : MvPolynomial σ R) (hQ : Q ∈ coeffIn S σ) :
    aeval y Q ∈ coeffIn S τ := by
  -- 第一の準備（二元の積、冪）。
  have hmul2 : ∀ A B : MvPolynomial τ R, A ∈ coeffIn S τ → B ∈ coeffIn S τ →
      A * B ∈ coeffIn S τ := fun A B hA hB => by
    have h := prod_mem_coeffIn_necSuf h0 h1 hadd hmul (Finset.univ : Finset (Fin 2)) ![A, B]
      (fun i _ => by fin_cases i <;> simpa)
    rwa [Fin.prod_univ_two, Matrix.cons_val_zero, Matrix.cons_val_one,
      Matrix.cons_val_fin_one] at h
  have hpow : ∀ A : MvPolynomial τ R, A ∈ coeffIn S τ → ∀ e : ℕ, A ^ e ∈ coeffIn S τ :=
    fun A hA e => by
      have h := prod_mem_coeffIn_necSuf h0 h1 hadd hmul (Finset.range e) (fun _ => A)
        (fun _ _ => hA)
      rwa [Finset.prod_const, Finset.card_range] at h
  -- T_a ∈ S[X]。
  have hT : ∀ a ∈ Q.support, C (coeff a Q) * ∏ k, y k ^ a k ∈ coeffIn S τ := fun a _ =>
    hmul2 _ _ (C_mem_coeffIn_necSuf h0 (hQ a))
      (prod_mem_coeffIn_necSuf h0 h1 hadd hmul Finset.univ _ (fun k _ => hpow _ (hy k) (a k)))
  have hexp : aeval y Q = ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, y k ^ a k := by
    rw [aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact sum_mem_coeffIn_necSuf h0 hadd Q.support _ hT

end Ising2DLambda.NecSuf.FisherZero
