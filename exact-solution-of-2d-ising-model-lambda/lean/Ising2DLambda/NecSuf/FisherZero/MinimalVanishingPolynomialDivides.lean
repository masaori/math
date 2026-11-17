/-
「次数未満の零化多項式は零」「最小次数の零化多項式は零化多項式を全て割り切る」
「代入した値は次数未満の係数しか持たない多項式の値である」の必要十分版。

具体版と同じ段で示す。部分体上の次数 `deg_F(α)` は、`Nat.find` で取った最小元としてではなく、
最小性だけを仮定 `hmin`（`D_F(α)` の任意の元以上であること）で受ける自然数 `n` に置き換える。
次数未満の零化多項式が零であることには `hmin` だけが要り、係数の集合 `S` の閉性も台の演算も使わない。
整除と値の表示には、除法（必要十分版 `polynomialDivision_necSuf`）のために `S` が零元を含み、
和・差・積・零でない元による商で閉じることが要る。単位元・逆元の閉性は使わない。
台は体であることが要る: 除法には商が、代入 `eval` が積を保つ段（`Polynomial.eval_mul`）には積の可換性が要る。
-/
import Ising2DLambda.NecSuf.FisherZero.SubfieldCoefficientPolynomialDivision
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 次数未満の零化多項式は零（具体版 `vanishingPolynomial_below_degree_eq_zero` と同じ段）。 -/
theorem vanishingPolynomial_below_degree_eq_zero_necSuf {K : Type*} [Semiring K] (S : Set K) (α : K)
    (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval α = 0 → n ≤ d)
    (q : K[X]) (hq : ∀ k : ℕ, q.coeff k ∈ S) (hqα : q.eval α = 0)
    (hz : ∀ k : ℕ, n ≤ k → q.coeff k = 0) : q = 0 := by
  by_contra hq0
  rcases Nat.eq_zero_or_pos n with h0 | hpos
  · exact hq0 (Polynomial.ext fun k => by rw [Polynomial.coeff_zero]; exact hz k (by omega))
  · have hle := hmin (n - 1) q hq hq0 (fun k hk => hz k (by omega)) hqα
    omega

/-- 番号 `n` の係数が零でない段（具体版 `minimalVanishingPolynomial_leading_ne_zero` と同じ段）。 -/
theorem minimalVanishingPolynomial_leading_ne_zero_necSuf {K : Type*} [Semiring K] (S : Set K)
    (α : K) (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval α = 0 → n ≤ d)
    (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpα : p.eval α = 0) : p.coeff n ≠ 0 := by
  intro hc
  apply hp0
  apply vanishingPolynomial_below_degree_eq_zero_necSuf S α n hmin p hp hpα
  intro k hk
  rcases Nat.eq_or_lt_of_le hk with heq | hlt
  · rw [← heq]; exact hc
  · exact htop k hlt

/-- 整除（具体版 `minimalVanishingPolynomial_dvd` と同じ段）。 -/
theorem minimalVanishingPolynomial_dvd_necSuf {K : Type*} [Field K] (S : Set K)
    (h0 : (0 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S) (α : K) (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval α = 0 → n ≤ d)
    (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpα : p.eval α = 0)
    (f : K[X]) (hf : ∀ k : ℕ, f.coeff k ∈ S) (hfα : f.eval α = 0) :
    ∃ u : K[X], (∀ k : ℕ, u.coeff k ∈ S) ∧ f = u * p := by
  obtain ⟨u, r, hu, hr, hfeq, hrz⟩ := polynomialDivision_necSuf S h0 hadd hsub hmul hdiv p n hp
    (minimalVanishingPolynomial_leading_ne_zero_necSuf S α n hmin p hp hp0 htop hpα) htop f hf
  have hrα : r.eval α = 0 := by
    calc r.eval α = f.eval α - u.eval α * p.eval α := by
          simp only [hfeq, Polynomial.eval_add, Polynomial.eval_mul]
          ring
      _ = 0 - u.eval α * 0 := by rw [hfα, hpα]
      _ = 0 := by ring
  have hr0 : r = 0 := vanishingPolynomial_below_degree_eq_zero_necSuf S α n hmin r hr hrα hrz
  exact ⟨u, hu, by rw [hfeq, hr0, add_zero]⟩

/-- 値の表示（具体版 `subfieldPolynomialValues_reduced` と同じ段）。
`n ∈ D_F(α)` の証人 `p` は仮定で受ける（具体版では `degreeOverSubfield_spec`）。 -/
theorem polynomialValues_reduced_necSuf {K : Type*} [Field K] (S : Set K)
    (h0 : (0 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S) (α : K) (n : ℕ)
    (hmin : ∀ (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval α = 0 → n ≤ d)
    (p : K[X]) (hp : ∀ k : ℕ, p.coeff k ∈ S) (hp0 : p ≠ 0)
    (htop : ∀ k : ℕ, n < k → p.coeff k = 0) (hpα : p.eval α = 0)
    (f : K[X]) (hf : ∀ k : ℕ, f.coeff k ∈ S) :
    ∃ g : K[X], (∀ k : ℕ, g.coeff k ∈ S) ∧ (∀ k : ℕ, n ≤ k → g.coeff k = 0) ∧
      g.eval α = f.eval α := by
  obtain ⟨u, r, _, hr, hfeq, hrz⟩ := polynomialDivision_necSuf S h0 hadd hsub hmul hdiv p n hp
    (minimalVanishingPolynomial_leading_ne_zero_necSuf S α n hmin p hp hp0 htop hpα) htop f hf
  refine ⟨r, hr, hrz, ?_⟩
  calc r.eval α = u.eval α * 0 + r.eval α := by ring
    _ = u.eval α * p.eval α + r.eval α := by rw [hpα]
    _ = f.eval α := by simp only [hfeq, Polynomial.eval_add, Polynomial.eval_mul]

end Ising2DLambda.NecSuf.FisherZero
