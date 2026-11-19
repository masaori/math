/-
節「基本対称式への代入」（全次数が重み付き次数以下であることの部分）の六つの主張の必要十分版。

具体版（`Ising2DLambda.FisherZero.qbarTotalDegree_elementarySymmetricSubst_le` ほか）と同じ段
（台の元についての上界、零でない項の取り出し、元の個数についての帰納法、冪を有限積として読むこと、
代入の有限和への展開）で示し、各段が実際に使う性質だけを仮定に置く。

- 係数は可換半環 `R` でよい。体であること・零因子が無いこと・逆元はどの段でも使わない
  （積の係数の零でない項から因子の係数が零でないことは、零元との積が零元であることだけで従う）。
- 全次数の代わりに、指数の任意の重み `w : (σ →₀ ℕ) → ℕ` についての次数 `wDeg w P = sup_{a ∈ spt P} w a`
  を置く。`w` について使うのは、零の指数で `0` 以下であること（`hw0`。定数・空の積）と、
  和で劣加法的であること（`hwadd`。二元の積）だけである。有限和の上界は `w` に何も要求しない。
  具体版の指数の総和 `sz_n` はこの二つを満たす（加法的で、零で零）。
- 基本対称式の上界では、変数の単項式の重みが `1` 以下であること（`hwX`）と、変数の集合 `σ` が
  有限であること（全変数の `j` 元部分集合の和）だけを使う。
- 代入の上界は、代入する値 `y k` の次数が `d k` 以下であることだけから従い、上界は
  `sup_{a ∈ spt Q} Σ_k a(k)·d(k)` である。具体版では `d k = k + 1` で、それが重み付き次数である。
  値が基本対称式であることは、具体版の準備でだけ使う。変数の集合 `σ` が有限であることは
  代入の展開（全変数にわたる有限積）に使う。
-/
import Mathlib.Algebra.MvPolynomial.Basic
import Mathlib.Algebra.MvPolynomial.Eval
import Mathlib.Data.Finset.Powerset

namespace Ising2DLambda.NecSuf.FisherZero

open MvPolynomial

variable {R : Type} [CommSemiring R]

/-- 指数の重み `w` についての次数（具体版の `qbarTotalDegree` の一般化）。 -/
noncomputable def wDeg {σ : Type} (w : (σ →₀ ℕ) → ℕ) (P : MvPolynomial σ R) : ℕ :=
  P.support.sup w

theorem le_wDeg {σ : Type} (w : (σ →₀ ℕ) → ℕ) (P : MvPolynomial σ R) (a : σ →₀ ℕ)
    (ha : coeff a P ≠ 0) : w a ≤ wDeg w P :=
  Finset.le_sup (mem_support_iff.mpr ha)

theorem wDeg_le_of_forall {σ : Type} (w : (σ →₀ ℕ) → ℕ) (P : MvPolynomial σ R) (m : ℕ)
    (h : ∀ a : σ →₀ ℕ, coeff a P ≠ 0 → w a ≤ m) : wDeg w P ≤ m :=
  Finset.sup_le fun a ha => h a (mem_support_iff.mp ha)

/-- `claim_qbar_total_degree_constant` の必要十分版（`w 0 ≤ 0` だけを使う）。 -/
theorem wDeg_C_necSuf {σ : Type} (w : (σ →₀ ℕ) → ℕ) (hw0 : w 0 ≤ 0) (c : R) :
    wDeg w (C c : MvPolynomial σ R) = 0 := by
  classical
  apply Nat.eq_zero_of_le_zero
  apply wDeg_le_of_forall
  intro a ha
  rw [coeff_C] at ha
  split_ifs at ha with h
  · rw [← h]
    exact hw0
  · exact absurd rfl ha

/-- `claim_qbar_total_degree_finite_sum_bound` の必要十分版（`w` に何も要求しない）。 -/
theorem wDeg_sum_le_necSuf {σ ι : Type} (w : (σ →₀ ℕ) → ℕ) (I : Finset ι)
    (P : ι → MvPolynomial σ R) (m : ℕ) (hP : ∀ i ∈ I, wDeg w (P i) ≤ m) :
    wDeg w (∑ i ∈ I, P i) ≤ m := by
  classical
  apply wDeg_le_of_forall
  intro a ha
  rw [coeff_sum] at ha
  obtain ⟨i, hi, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero ha
  calc w a ≤ wDeg w (P i) := le_wDeg w (P i) a hne
    _ ≤ m := hP i hi

/-- `claim_qbar_total_degree_product_bound` の必要十分版（`w` の劣加法性だけを使う）。 -/
theorem wDeg_mul_le_necSuf {σ : Type} (w : (σ →₀ ℕ) → ℕ)
    (hwadd : ∀ b c : σ →₀ ℕ, w (b + c) ≤ w b + w c) (A B : MvPolynomial σ R) :
    wDeg w (A * B) ≤ wDeg w A + wDeg w B := by
  classical
  apply wDeg_le_of_forall
  intro a ha
  rw [coeff_mul] at ha
  obtain ⟨x, hx, hne⟩ := Finset.exists_ne_zero_of_sum_ne_zero ha
  rw [Finset.mem_antidiagonal] at hx
  have hb : coeff x.1 A ≠ 0 := left_ne_zero_of_mul hne
  have hc : coeff x.2 B ≠ 0 := right_ne_zero_of_mul hne
  calc w a = w (x.1 + x.2) := by rw [hx]
    _ ≤ w x.1 + w x.2 := hwadd x.1 x.2
    _ ≤ wDeg w A + wDeg w B := Nat.add_le_add (le_wDeg w A _ hb) (le_wDeg w B _ hc)

/-- `claim_qbar_total_degree_finite_product_bound` の必要十分版。 -/
theorem wDeg_prod_le_necSuf {σ ι : Type} (w : (σ →₀ ℕ) → ℕ) (hw0 : w 0 ≤ 0)
    (hwadd : ∀ b c : σ →₀ ℕ, w (b + c) ≤ w b + w c) (I : Finset ι) (P : ι → MvPolynomial σ R) :
    wDeg w (∏ i ∈ I, P i) ≤ ∑ i ∈ I, wDeg w (P i) := by
  classical
  induction I using Finset.induction_on with
  | empty =>
    rw [Finset.prod_empty, Finset.sum_empty, ← C_1, wDeg_C_necSuf w hw0]
  | insert i₀ I' hi₀ ih =>
    rw [Finset.prod_insert hi₀, Finset.sum_insert hi₀]
    calc wDeg w (P i₀ * ∏ i ∈ I', P i)
        ≤ wDeg w (P i₀) + wDeg w (∏ i ∈ I', P i) := wDeg_mul_le_necSuf w hwadd _ _
      _ ≤ wDeg w (P i₀) + ∑ i ∈ I', wDeg w (P i) := Nat.add_le_add_left ih _

/-- `claim_qbar_elementary_symmetric_total_degree_bound` の必要十分版。 -/
theorem wDeg_elementarySymmetric_le_necSuf {σ : Type} [Fintype σ] (w : (σ →₀ ℕ) → ℕ)
    (hw0 : w 0 ≤ 0) (hwadd : ∀ b c : σ →₀ ℕ, w (b + c) ≤ w b + w c)
    (hwX : ∀ k : σ, wDeg w (X k : MvPolynomial σ R) ≤ 1) (j : ℕ) :
    wDeg w (∑ T ∈ Finset.powersetCard j (Finset.univ : Finset σ),
      ∏ k ∈ T, (X k : MvPolynomial σ R)) ≤ j := by
  apply wDeg_sum_le_necSuf
  intro T hT
  rw [Finset.mem_powersetCard] at hT
  calc wDeg w (∏ k ∈ T, (X k : MvPolynomial σ R))
      ≤ ∑ k ∈ T, wDeg w (X k : MvPolynomial σ R) := wDeg_prod_le_necSuf w hw0 hwadd T _
    _ ≤ ∑ _k ∈ T, 1 := Finset.sum_le_sum (fun k _ => hwX k)
    _ = T.card := by rw [Finset.sum_const, smul_eq_mul, mul_one]
    _ = j := hT.2

/-- `claim_elementary_symmetric_substitution_degree_bound` の必要十分版（具体版と同じ段）。
値 `y k` の次数が `d k` 以下の代入の次数は `sup_{a ∈ spt Q} Σ_k a(k)·d(k)` 以下。 -/
theorem wDeg_aeval_le_necSuf {σ τ : Type} [Fintype σ] (w : (τ →₀ ℕ) → ℕ) (hw0 : w 0 ≤ 0)
    (hwadd : ∀ b c : τ →₀ ℕ, w (b + c) ≤ w b + w c)
    (y : σ → MvPolynomial τ R) (d : σ → ℕ) (hy : ∀ k, wDeg w (y k) ≤ d k)
    (Q : MvPolynomial σ R) :
    wDeg w (aeval y Q) ≤ Q.support.sup (fun a => ∑ k, d k * a k) := by
  -- 準備（冪）。
  have hpow : ∀ (A : MvPolynomial τ R) (e : ℕ), wDeg w (A ^ e) ≤ e * wDeg w A := fun A e => by
    have h := wDeg_prod_le_necSuf w hw0 hwadd (Finset.range e) (fun _ => A)
    rwa [Finset.prod_const, Finset.card_range, Finset.sum_const, Finset.card_range,
      smul_eq_mul] at h
  have hT : ∀ a ∈ Q.support, wDeg w (C (coeff a Q) * ∏ k, y k ^ a k) ≤
      Q.support.sup (fun a => ∑ k, d k * a k) := fun a ha =>
    calc wDeg w (C (coeff a Q) * ∏ k, y k ^ a k)
        ≤ wDeg w (C (coeff a Q) : MvPolynomial τ R) + wDeg w (∏ k, y k ^ a k) :=
          wDeg_mul_le_necSuf w hwadd _ _
      _ = wDeg w (∏ k, y k ^ a k) := by rw [wDeg_C_necSuf w hw0, zero_add]
      _ ≤ ∑ k, wDeg w (y k ^ a k) := wDeg_prod_le_necSuf w hw0 hwadd _ _
      _ ≤ ∑ k, a k * wDeg w (y k) := Finset.sum_le_sum (fun k _ => hpow _ _)
      _ ≤ ∑ k, a k * d k := Finset.sum_le_sum (fun k _ => Nat.mul_le_mul_left _ (hy k))
      _ = ∑ k, d k * a k := Finset.sum_congr rfl (fun k _ => Nat.mul_comm _ _)
      _ ≤ Q.support.sup (fun a => ∑ k, d k * a k) :=
          Finset.le_sup (f := fun a => ∑ k, d k * a k) ha
  have hexp : aeval y Q = ∑ a ∈ Q.support, C (coeff a Q) * ∏ k, y k ^ a k := by
    rw [aeval_def, eval₂_eq', algebraMap_eq]
  rw [hexp]
  exact wDeg_sum_le_necSuf w Q.support _ _ hT

end Ising2DLambda.NecSuf.FisherZero
