/-
主張「正の元が平方で奇数次の多項式が根を持つ部分体に虚数単位を足すと代数的数の全体になる」
（ラベル `claim_adjoin_imaginary_unit_gives_algebraic_numbers`）の必要十分版。
具体版 `Ising2DLambda.FisherZero.adjoinImaginaryUnit_gives_algebraicNumbers` と同じ手順
（最高次の係数で割る → 一次因子の積に分ける → 積の根は因子の根）を、手順が実際に使う仮定だけの上で行う。

要るのは次だけである。
- 零因子の無い可換環 K。可換性は値を取る写像が積を保つこと（(五)）に、零因子の無いことは
  一次因子の積の値が零なら因子のどれかが零であることに使う。
- 係数の所属の集合 S（具体版では F）と根の所属の集合 T（具体版では Lin_F(ω)）。
  S ⊆ T（具体版では u = u + 0·ω）、S の積での閉性、S の零でない元の S の中の左逆元
  （(三) の c⁻¹ · c = 1 にだけ使う。体であることの残りは使わない）。
- 一次因子への分解（hfactor。具体版では
  `claim_imaginary_unit_extension_monic_polynomial_linear_factor_product` が供給する）。
- ξ の零化多項式 p で、番号 n の係数が零でなく、n より上の係数が零のもの（具体版では
  `def_degree_over_subfield` と `claim_minimal_vanishing_polynomial_leading_coefficient_nonzero` が供給する）。

削れたもの: 体であること（逆元は c の一つだけ）・ω·ω = -1・正錐・共役・奇数次の根・平方根・
最小次数であること。これらは仮定 hfactor と p の供給側に隔離される。
-/
import Mathlib

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial
open scoped BigOperators

/-- 具体版の (一) と同じ段: 定数多項式を左から掛けた積の係数を、`i = 0` の項を取り出して示す。 -/
theorem constMulCoeff_necSuf {K : Type*} [Semiring K] (a : K) (p : K[X]) (j : ℕ) :
    (C a * p).coeff j = a * p.coeff j := by
  rw [Polynomial.coeff_mul]
  rw [Finset.sum_eq_single ((0, j) : ℕ × ℕ)]
  · rw [Polynomial.coeff_C_zero]
  · intro b hb hne
    have hb' : b.1 + b.2 = j := Finset.HasAntidiagonal.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ 0 := by
      intro h0
      apply hne
      have hb2 : b.2 = j := by omega
      exact Prod.ext h0 hb2
    rw [Polynomial.coeff_C, if_neg hb1, zero_mul]
  · intro h
    exact absurd (Finset.HasAntidiagonal.mem_antidiagonal.mpr (by omega : 0 + j = j)) h

theorem adjoinImaginaryUnit_gives_algebraicNumbers_necSuf
    {K : Type*} [CommRing K] [NoZeroDivisors K]
    (S T : Set K) (hST : ∀ a : K, a ∈ S → a ∈ T)
    (hSmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hSinv : ∀ c : K, c ∈ S → c ≠ 0 → ∃ c' : K, c' ∈ S ∧ c' * c = 1)
    (hfactor : ∀ (d : ℕ) (g : K[X]), (∀ k : ℕ, g.coeff k ∈ T) →
      (∀ k : ℕ, d < k → g.coeff k = 0) → g.coeff d = 1 →
      ∃ α : ℕ → K, (∀ i : ℕ, α i ∈ T) ∧ g = ∏ i ∈ Finset.range d, (X - C (α i)))
    (ξ : K) (n : ℕ) (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hc : p.coeff n ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpξ : p.eval ξ = 0) : ξ ∈ T := by
  haveI : Nontrivial K := ⟨⟨p.coeff n, 0, hc⟩⟩
  -- 準備: c の左逆元 c'。
  obtain ⟨c', hc'S, hc'⟩ := hSinv (p.coeff n) (hp n) hc
  -- (一) と (二)。
  have hg : ∀ k : ℕ, (C c' * p).coeff k ∈ T := by
    intro k
    rw [constMulCoeff_necSuf]
    exact hST _ (hSmul _ _ hc'S (hp k))
  -- (三)。
  have hlead : (C c' * p).coeff n = 1 := by
    rw [constMulCoeff_necSuf]; exact hc'
  -- (四)。
  have hbound : ∀ k : ℕ, n < k → (C c' * p).coeff k = 0 := by
    intro k hk
    rw [constMulCoeff_necSuf, htop k hk, mul_zero]
  obtain ⟨α, hα, hfac⟩ := hfactor n _ hg hbound hlead
  -- (五)。
  have hgξ : (C c' * p).eval ξ = 0 := by
    rw [Polynomial.eval_mul, Polynomial.eval_C, hpξ, mul_zero]
  -- 積の根は因子の根。
  rw [hfac, Polynomial.eval_prod] at hgξ
  obtain ⟨r, _, hr⟩ := Finset.prod_eq_zero_iff.mp hgξ
  rw [Polynomial.eval_sub, Polynomial.eval_X, Polynomial.eval_C, sub_eq_zero] at hr
  rw [hr]
  exact hα r

end Ising2DLambda.NecSuf.FisherZero
