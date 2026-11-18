/-
節「奇数次の多項式は部分体上の次数が奇数の根を持つ」の必要十分版。

具体版と同じ段で示し、各段が実際に使う性質だけを仮定に置く。

- 係数の上界の和の番号の積の係数: 台は `Semiring` でよい（可換性も符号反転も使わない）。
- 主張: 部分体上の次数 `deg_F` は、`Nat.find` で取った最小元としてではなく、写像 `deg : K → ℕ` と、
  その値が `D_F(β)` に属すること（証人 `hspec`）と最小であること（`hmin`）で受ける。
  根の存在は、`K` 全体の代数閉性ではなく「係数が `S` に属し、番号 1 以上に零でない係数を持つ多項式は
  根を持つ」（`hroot`）だけを使う。帰納法で根を取るのは `f` と商 `u` だけで、どちらも係数が `S` に属する。
  係数の集合 `S` の閉性（零元と、和・差・積・零でない元による商）は、整除の段
  （必要十分版 `minimalVanishingPolynomial_dvd_necSuf`）の除法のためだけに要る。単位元・逆元の閉性は使わない。
  台は体であることが要る: 除法には商が、最高次の係数の積が零でないことには零因子が無いことが、
  代入が積を保つ段（`Polynomial.eval_mul`）には積の可換性が要る。
-/
import Ising2DLambda.NecSuf.FisherZero.MinimalVanishingPolynomialDivides

namespace Ising2DLambda.NecSuf.FisherZero

open Polynomial

/-- 係数の上界の和の番号の積の係数（具体版 `qbarPolyProductTopCoeff` と同じ段）。 -/
theorem productTopCoeff_necSuf {K : Type*} [Semiring K] (f g : K[X]) (a b : ℕ)
    (hf : ∀ k, a < k → f.coeff k = 0) (hg : ∀ k, b < k → g.coeff k = 0) :
    (f * g).coeff (a + b) = f.coeff a * g.coeff b := by
  rw [Polynomial.coeff_mul, Finset.sum_eq_single ((a, b) : ℕ × ℕ)]
  · intro c hc hne
    have hc' : c.1 + c.2 = a + b := Finset.mem_antidiagonal.mp hc
    rcases lt_or_ge a c.1 with h1 | h1
    · rw [hf c.1 h1, zero_mul]
    · have h2 : b < c.2 := by
        rcases Nat.eq_or_lt_of_le h1 with h | h
        · exact absurd (Prod.ext h (by omega)) hne
        · omega
      rw [hg c.2 h2, mul_zero]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (rfl : a + b = a + b)) h

/-- 係数の上界の和より上の番号で積の係数は零（具体版の `qbarPolyProductCoeffBound` と同じ段）。 -/
theorem productCoeffBound_necSuf {K : Type*} [Semiring K] (f g : K[X]) (a b : ℕ)
    (hf : ∀ k, a < k → f.coeff k = 0) (hg : ∀ k, b < k → g.coeff k = 0) :
    ∀ k, a + b < k → (f * g).coeff k = 0 := by
  intro k hk
  rw [Polynomial.coeff_mul]
  apply Finset.sum_eq_zero
  intro c hc
  have hc' : c.1 + c.2 = k := Finset.mem_antidiagonal.mp hc
  rcases lt_or_ge a c.1 with h1 | h1
  · rw [hf c.1 h1, zero_mul]
  · rw [hg c.2 (by omega), mul_zero]

/-- 主張（具体版 `oddDegreePolynomial_hasOddDegreeRoot` と同じ段）。 -/
theorem oddDegreePolynomial_hasOddDegreeRoot_necSuf {K : Type*} [Field K] (S : Set K)
    (h0 : (0 : K) ∈ S) (hadd : ∀ a b : K, a ∈ S → b ∈ S → a + b ∈ S)
    (hsub : ∀ a b : K, a ∈ S → b ∈ S → a - b ∈ S) (hmul : ∀ a b : K, a ∈ S → b ∈ S → a * b ∈ S)
    (hdiv : ∀ a b : K, a ∈ S → b ∈ S → a / b ∈ S) (deg : K → ℕ)
    (hspec : ∀ β : K, ∃ p : K[X], (∀ k : ℕ, p.coeff k ∈ S) ∧ p ≠ 0 ∧
      (∀ k : ℕ, deg β < k → p.coeff k = 0) ∧ p.eval β = 0)
    (hmin : ∀ (β : K) (d : ℕ) (q : K[X]), (∀ k : ℕ, q.coeff k ∈ S) → q ≠ 0 →
      (∀ k : ℕ, d < k → q.coeff k = 0) → q.eval β = 0 → deg β ≤ d)
    (hroot : ∀ (f : K[X]) (n : ℕ), (∀ k : ℕ, f.coeff k ∈ S) → 1 ≤ n → f.coeff n ≠ 0 →
      ∃ β : K, f.eval β = 0) :
    ∀ (n : ℕ) (f : K[X]), (∀ k : ℕ, f.coeff k ∈ S) → Odd n → f.coeff n ≠ 0 →
      (∀ k : ℕ, n < k → f.coeff k = 0) →
      ∃ β : K, f.eval β = 0 ∧ Odd (deg β) ∧ deg β ≤ n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro f hf hodd hfn hfz
  have hn1 : 1 ≤ n := by obtain ⟨j, hj⟩ := hodd; omega
  obtain ⟨β, hfβ⟩ := hroot f n hf hn1 hfn
  obtain ⟨p, hp, hp0, htop, hpβ⟩ := hspec β
  have hpd : p.coeff (deg β) ≠ 0 :=
    minimalVanishingPolynomial_leading_ne_zero_necSuf S β (deg β) (hmin β) p hp hp0 htop hpβ
  have hd1 : 1 ≤ deg β := by
    by_contra hlt
    have hd0 : deg β = 0 := by omega
    have hpC : p = Polynomial.C (p.coeff 0) := by
      ext k
      rw [Polynomial.coeff_C]
      by_cases hk : k = 0
      · rw [if_pos hk, hk]
      · rw [if_neg hk]; exact htop k (by omega)
    have hval : p.eval β = p.coeff 0 := by
      rw [hpC, Polynomial.eval_C, Polynomial.coeff_C_zero]
    rw [hd0] at hpd
    exact hpd (hval ▸ hpβ)
  obtain ⟨u, hu, hfu⟩ := minimalVanishingPolynomial_dvd_necSuf S h0 hadd hsub hmul hdiv β (deg β)
    (hmin β) p hp hp0 htop hpβ f hf hfβ
  have hu0 : u ≠ 0 := by
    intro h
    apply hfn
    rw [hfu, h, zero_mul, Polynomial.coeff_zero]
  have hue : u.coeff u.natDegree ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hu0
  have hub : ∀ k : ℕ, u.natDegree < k → u.coeff k = 0 :=
    fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  have htopf : f.coeff (u.natDegree + deg β) ≠ 0 := by
    rw [hfu, productTopCoeff_necSuf u p u.natDegree (deg β) hub htop]
    exact mul_ne_zero hue hpd
  have hboundf : ∀ k : ℕ, u.natDegree + deg β < k → f.coeff k = 0 := by
    intro k hk
    rw [hfu]
    exact productCoeffBound_necSuf u p u.natDegree (deg β) hub htop k hk
  have hed : u.natDegree + deg β = n := by
    rcases lt_trichotomy (u.natDegree + deg β) n with h | h | h
    · exact absurd (hboundf n h) hfn
    · exact h
    · exact absurd (hfz _ h) htopf
  by_cases hdodd : Odd (deg β)
  · exact ⟨β, hfβ, hdodd, by omega⟩
  · obtain ⟨h, hh⟩ := Nat.not_odd_iff_even.mp hdodd
    obtain ⟨j, hj⟩ := hodd
    have heodd : Odd u.natDegree := ⟨j - h, by omega⟩
    have hen : u.natDegree < n := by omega
    obtain ⟨γ, huγ, hγodd, hγle⟩ := ih u.natDegree hen u hu heodd hue hub
    refine ⟨γ, ?_, hγodd, by omega⟩
    rw [hfu, Polynomial.eval_mul, huγ, zero_mul]

end Ising2DLambda.NecSuf.FisherZero
