/-
節「単項式の係数と末尾の変数への零代入の係数」の具体版。

  人手証明                                                  このファイル
  定義 `def_qbar_multivariate_monomial`                     `qbarMonomial`・`exponentWeight`
  定義 `def_exponent_zero_extension`                        `exponentZeroExtension`
  主張 `claim_qbar_monomial_multiplication_coefficient`     `qbarMonomial_mul_coeff`
    準備（変数を一つ掛けたときの係数）                      `qbarX_mul_coeff`
    帰納法の零の段（ew(a) = 0 なら a = 0、mon_n(0) = 1）     `qbarMonomial_zero`
    帰納法の段の分解 mon_n(δ_k + a') = X_k · mon_n(a')       `qbarMonomial_single_add`
  主張 `claim_last_variable_zero_coefficient`                `lastVariableZero_coeff`
    第一の等号（代入の定義）                                `MvPolynomial.aeval_eq_eval₂Hom`・`MvPolynomial.eval₂_eq'`
    第二の等号（a(n) ≠ 0 の項は零、a(n) = 0 の項は単項式）   `lastVariableZero_term_of_last_ne_zero`・`lastVariableZero_term_of_last_eq_zero`
    第三の等号（各項の係数）                                `qbarMonomial_mul_coeff`
    第四の等号（係数が残る指数は ez_n(b) だけ）              `Finset.sum_eq_single`

本文の指数 `a ∈ Ex_n` は `Fin n →₀ ℕ`、`a ≤ c` と `c - a` は各点の順序と差で、`Finsupp` の順序と差がそれに当たる。
準備の等号は積の係数の定義（`MvPolynomial.coeff_mul`）と変数の係数（`MvPolynomial.coeff_X`）から和を一項に絞って示す。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.ElementarySymmetricLastVariableZero

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- `def_qbar_multivariate_monomial` の具体版。`mon_n(a) = ∏_{k ∈ ℕ_{<n}} (X^{(n)}_k)^{a(k)}`。 -/
noncomputable def qbarMonomial (n : ℕ) (a : Fin n →₀ ℕ) : QbarMvPoly n :=
  ∏ k, X k ^ a k

/-- `def_qbar_multivariate_monomial` の指数の総和 `ew(a) = Σ_{k ∈ ℕ_{<n}} a(k)`。 -/
def exponentWeight {n : ℕ} (a : Fin n →₀ ℕ) : ℕ :=
  ∑ k, a k

/-- `def_exponent_zero_extension` の具体版。`ez_n(b)(k) = b(k)`（`k < n`）、`ez_n(b)(n) = 0`。 -/
noncomputable def exponentZeroExtension {n : ℕ} (b : Fin n →₀ ℕ) : Fin (n + 1) →₀ ℕ :=
  Finsupp.embDomain Fin.castSuccEmb b

theorem exponentZeroExtension_castSucc {n : ℕ} (b : Fin n →₀ ℕ) (k : Fin n) :
    exponentZeroExtension b k.castSucc = b k := by
  unfold exponentZeroExtension
  exact Finsupp.embDomain_apply_self Fin.castSuccEmb b k

theorem exponentZeroExtension_last {n : ℕ} (b : Fin n →₀ ℕ) :
    exponentZeroExtension b (Fin.last n) = 0 := by
  unfold exponentZeroExtension
  apply Finsupp.embDomain_notin_range
  rintro ⟨k, hk⟩
  exact Fin.castSucc_ne_last k hk

/-- `claim_qbar_monomial_multiplication_coefficient` の準備。
`mco_c(X_k · R) = Σ_{b+e=c} mco_b(X_k) mco_e(R)` は `δ_k + e = c` の項だけが残り、
そのような `e` は `δ_k ≤ c` のときに限って `c - δ_k` ただ一つである。 -/
theorem qbarX_mul_coeff {n : ℕ} (k : Fin n) (R : QbarMvPoly n) (c : Fin n →₀ ℕ) :
    coeff c (X k * R) =
      if Finsupp.single k 1 ≤ c then coeff (c - Finsupp.single k 1) R else 0 := by
  classical
  rw [coeff_mul]
  simp_rw [coeff_X]
  simp only [ite_mul, one_mul, zero_mul]
  rw [Finset.sum_ite]
  simp only [Finset.sum_const_zero, add_zero]
  split_ifs with h
  · rw [Finset.sum_eq_single (Finsupp.single k 1, c - Finsupp.single k 1)]
    · intro x hx hne
      exfalso
      rw [Finset.mem_filter, Finset.mem_antidiagonal] at hx
      obtain ⟨hsum, hfst⟩ := hx
      apply hne
      ext1
      · exact hfst.symm
      · simp only
        rw [← hsum, ← hfst, add_tsub_cancel_left]
    · intro hnot
      exfalso
      apply hnot
      rw [Finset.mem_filter, Finset.mem_antidiagonal]
      exact ⟨add_tsub_cancel_of_le h, rfl⟩
  · apply Finset.sum_eq_zero
    intro x hx
    exfalso
    rw [Finset.mem_filter, Finset.mem_antidiagonal] at hx
    apply h
    rw [← hx.1, hx.2]
    exact le_self_add

/-- 帰納法の零の段: `mon_n(0) = 1`。 -/
theorem qbarMonomial_zero (n : ℕ) : qbarMonomial n 0 = 1 := by
  simp [qbarMonomial]

/-- 帰納法の段の分解: `mon_n(δ_k + a') = X_k · mon_n(a')`。 -/
theorem qbarMonomial_single_add {n : ℕ} (k : Fin n) (a' : Fin n →₀ ℕ) :
    qbarMonomial n (Finsupp.single k 1 + a') = X k * qbarMonomial n a' := by
  classical
  unfold qbarMonomial
  simp_rw [Finsupp.add_apply, pow_add]
  rw [Finset.prod_mul_distrib]
  congr 1
  rw [Finset.prod_eq_single k]
  · simp
  · intro j _ hj
    rw [Finsupp.single_apply, if_neg (Ne.symm hj), pow_zero]
  · intro h
    exact absurd (Finset.mem_univ k) h

/-- `claim_qbar_monomial_multiplication_coefficient` の具体版。
`mco_c(mon_n(a) · Q) = mco_{c-a}(Q)`（`a ≤ c`）、`0`（それ以外）。指数の総和 `ew(a)` についての帰納法。 -/
theorem qbarMonomial_mul_coeff {n : ℕ} (a c : Fin n →₀ ℕ) (Q : QbarMvPoly n) :
    coeff c (qbarMonomial n a * Q) = if a ≤ c then coeff (c - a) Q else 0 := by
  classical
  suffices h : ∀ w : ℕ, ∀ a c : Fin n →₀ ℕ, exponentWeight a = w →
      coeff c (qbarMonomial n a * Q) = if a ≤ c then coeff (c - a) Q else 0 from
    h _ a c rfl
  intro w
  induction w with
  | zero =>
    -- ew(a) = 0 なら a = 0、mon_n(0) = 1。
    intro a c hw
    have ha : a = 0 := by
      ext k
      have := (Finset.sum_eq_zero_iff.mp hw) k (Finset.mem_univ k)
      simpa using this
    subst ha
    rw [qbarMonomial_zero, one_mul, if_pos (zero_le), tsub_zero]
  | succ w ih =>
    intro a c hw
    -- ew(a) ≥ 1 なので a(k) ≥ 1 の k がある。a = δ_k + a'。
    obtain ⟨k, -, hk⟩ := Finset.exists_ne_zero_of_sum_ne_zero
      (show ∑ j, a j ≠ 0 from by rw [show ∑ j, a j = exponentWeight a from rfl, hw]; omega)
    have hle : Finsupp.single k 1 ≤ a := by
      intro j
      rw [Finsupp.single_apply]
      split_ifs with hj
      · subst hj; omega
      · exact Nat.zero_le _
    set a' := a - Finsupp.single k 1 with ha'
    have hsplit : a = Finsupp.single k 1 + a' := (add_tsub_cancel_of_le hle).symm
    have hw' : exponentWeight a' = w := by
      have h1 : exponentWeight a = 1 + exponentWeight a' := by
        unfold exponentWeight
        conv_lhs => rw [hsplit]
        simp_rw [Finsupp.add_apply]
        rw [Finset.sum_add_distrib]
        congr 1
        simp [Finsupp.single_apply]
      omega
    rw [hsplit, qbarMonomial_single_add, mul_assoc, qbarX_mul_coeff]
    -- mco_c(X_k · (mon_n(a') Q)) を、帰納法の仮定で mon_n(a') の段へ下ろす。
    by_cases hc : Finsupp.single k 1 ≤ c
    · rw [if_pos hc, ih a' _ hw']
      have hiff : a' ≤ c - Finsupp.single k 1 ↔ Finsupp.single k 1 + a' ≤ c := by
        rw [le_tsub_iff_left hc]
      by_cases ha'c : a' ≤ c - Finsupp.single k 1
      · rw [if_pos ha'c, if_pos (hiff.mp ha'c), tsub_tsub]
      · rw [if_neg ha'c, if_neg (fun h => ha'c (hiff.mpr h))]
    · rw [if_neg hc, if_neg]
      intro h
      exact hc (le_trans le_self_add h)

/-- `claim_last_variable_zero_coefficient` の第二の等号の前半: `a(n) ≠ 0` の項の積は零。 -/
theorem lastVariableZero_term_of_last_ne_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : a (Fin.last n) ≠ 0) :
    ∏ i, lastVariableZeroValues n i ^ a i = 0 := by
  rw [Fin.prod_univ_castSucc]
  simp [lastVariableZeroValues, zero_pow ha]

/-- `claim_last_variable_zero_coefficient` の第二の等号の後半: `a(n) = 0` の項の積は
`mon_n(a|_{<n})`。制限 `a|_{<n}` は `Finsupp.comapDomain` で書く。 -/
theorem lastVariableZero_term_of_last_eq_zero {n : ℕ} (a : Fin (n + 1) →₀ ℕ)
    (ha : a (Fin.last n) = 0) :
    ∏ i, lastVariableZeroValues n i ^ a i =
      qbarMonomial n (Finsupp.comapDomain Fin.castSucc a (Fin.castSucc_injective n).injOn) := by
  rw [Fin.prod_univ_castSucc]
  simp [lastVariableZeroValues, ha, qbarMonomial]

/-- `claim_last_variable_zero_coefficient` の具体版。`mco_b(lz_n(P)) = mco_{ez_n(b)}(P)`。 -/
theorem lastVariableZero_coeff {n : ℕ} (P : QbarMvPoly (n + 1)) (b : Fin n →₀ ℕ) :
    coeff b (lastVariableZero n P) = coeff (exponentZeroExtension b) P := by
  classical
  -- 第一の等号: 代入の定義。
  rw [lastVariableZero, qbarMvSubst, aeval_eq_eval₂Hom, coe_eval₂Hom, eval₂_eq']
  -- 第二の等号: a(n) ≠ 0 の項を落とし、a(n) = 0 の項を単項式に書く。
  rw [← Finset.sum_filter_add_sum_filter_not _ (fun a => a (Fin.last n) = 0)]
  have hdrop : ∑ a ∈ P.support.filter (fun a => ¬ a (Fin.last n) = 0),
      algebraMap Qbar (QbarMvPoly n) (coeff a P) * ∏ i, lastVariableZeroValues n i ^ a i = 0 := by
    apply Finset.sum_eq_zero
    intro a ha
    rw [lastVariableZero_term_of_last_ne_zero a (Finset.mem_filter.mp ha).2, mul_zero]
  rw [hdrop, add_zero, coeff_sum]
  -- 第三の等号: 各項の係数は、単項式の指数が b に等しいときだけ係数 mco_a(P)。
  have hterm : ∀ a ∈ P.support.filter (fun a => a (Fin.last n) = 0),
      coeff b (algebraMap Qbar (QbarMvPoly n) (coeff a P) * ∏ i, lastVariableZeroValues n i ^ a i) =
        if Finsupp.comapDomain Fin.castSucc a (Fin.castSucc_injective n).injOn = b
        then coeff a P else 0 := by
    intro a ha
    rw [lastVariableZero_term_of_last_eq_zero a (Finset.mem_filter.mp ha).2, mul_comm,
      qbarMonomial_mul_coeff, MvPolynomial.algebraMap_eq]
    split_ifs with hle heq heq
    · rw [coeff_C, if_pos]
      rw [heq, tsub_self]
    · rw [coeff_C, if_neg]
      intro h0
      apply heq
      exact le_antisymm hle (tsub_eq_zero_iff_le.mp h0.symm)
    · exact absurd (heq ▸ le_refl b) hle
    · rfl
  rw [Finset.sum_congr rfl hterm]
  -- 第四の等号: 係数が残る指数は ez_n(b) だけ。
  have hext : ∀ a : Fin (n + 1) →₀ ℕ, a (Fin.last n) = 0 →
      Finsupp.comapDomain Fin.castSucc a (Fin.castSucc_injective n).injOn = b →
        a = exponentZeroExtension b := by
    intro a hlast hres
    ext i
    induction i using Fin.lastCases with
    | last => rw [hlast, exponentZeroExtension_last]
    | cast k =>
      rw [exponentZeroExtension_castSucc, ← hres, Finsupp.comapDomain_apply]
  have hres_ext : Finsupp.comapDomain Fin.castSucc (exponentZeroExtension b)
      (Fin.castSucc_injective n).injOn = b := by
    ext k
    rw [Finsupp.comapDomain_apply, exponentZeroExtension_castSucc]
  rw [Finset.sum_eq_single (exponentZeroExtension b)]
  · rw [if_pos hres_ext]
  · intro a ha hne
    rw [if_neg]
    intro hres
    exact hne (hext a (Finset.mem_filter.mp ha).2 hres)
  · intro hnot
    rw [if_pos hres_ext]
    by_contra hcoeff
    apply hnot
    rw [Finset.mem_filter, mem_support_iff]
    exact ⟨hcoeff, exponentZeroExtension_last b⟩

end Ising2DLambda.FisherZero
