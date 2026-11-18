/-
節「奇数次の多項式は部分体上の次数が奇数の根を持つ」の具体版。

  人手証明                                                  このファイル
  係数の上界の和の番号の、積の係数                          `qbarPolyProductTopCoeff`
  （`claim_qbar_poly_product_top_coefficient`）
  主張（`claim_odd_degree_polynomial_has_odd_degree_root`）  `oddDegreePolynomial_hasOddDegreeRoot`
    根を取る（`def_algebraic_numbers` の第二条件）          `IsAlgClosed.exists_root`
    d := deg_F(β) と p（`def_degree_over_subfield`）        `degreeOverSubfield_spec`
    ac_d(p) ≠ 0                                             `minimalVanishingPolynomial_leading_ne_zero`
    d ≥ 1（d = 0 なら aev_β(p) = ac_0(p) ≠ 0）               `hd1`
    割る（`claim_minimal_vanishing_polynomial_divides`）     `minimalVanishingPolynomial_dvd`
    u ≠ 0 と e                                              `hu0`・`hue`・`hub`
    e + d = n                                               `hed`
    d が奇数の場合 / 偶数の場合（帰納法の仮定）              最後の場合分け

本文の「零でない多項式 u の係数が零でない番号の最大値 e」は `Polynomial.natDegree`
（定義の対応。`Polynomial.coeff_eq_zero_of_natDegree_lt` と `Polynomial.leadingCoeff_ne_zero`）で読む。
本文の「ある j で n = 2j+1」は `Odd n`（定義が同じ）。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.MinimalVanishingPolynomialDivides
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyProductCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_qbar_poly_product_top_coefficient` の具体版。`k > a` で係数が零の `f` と `k > b` で係数が零の
`g` について、`ac_{a+b}(f·g) = ac_a(f)·ac_b(g)`。積の係数の和のうち、番号の組 `(a, b)` 以外の項は、
第一成分が `a` より大きいか、第二成分が `b` より大きいので零である。 -/
theorem qbarPolyProductTopCoeff (f g : QbarPoly) (a b : ℕ) (hf : ∀ k, a < k → f.coeff k = 0)
    (hg : ∀ k, b < k → g.coeff k = 0) :
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

/-- `claim_odd_degree_polynomial_has_odd_degree_root` の具体版。最高次の番号 `n` が奇数の
`f ∈ F[t]` は、`deg_F(β)` が奇数で `n` 以下の根 `β` を持つ（`n` についての強い帰納法）。 -/
theorem oddDegreePolynomial_hasOddDegreeRoot (F : Subfield Qbar) :
    ∀ (n : ℕ) (f : QbarPoly), f ∈ subfieldCoefficientPolynomials F → Odd n → f.coeff n ≠ 0 →
      (∀ k : ℕ, n < k → f.coeff k = 0) →
      ∃ β : Qbar, qbarPolyEval β f = 0 ∧ Odd (degreeOverSubfield F β) ∧
        degreeOverSubfield F β ≤ n := by
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro f hf hodd hfn hfz
  -- 根を取る: n ≥ 1 かつ ac_n(f) ≠ 0 なので f は次数 1 以上（`def_algebraic_numbers` の第二条件）。
  have hn1 : 1 ≤ n := by obtain ⟨j, hj⟩ := hodd; omega
  have hdeg : f.degree ≠ 0 := by
    intro h0
    have hlow : ((n : ℕ) : WithBot ℕ) ≤ f.degree := Polynomial.le_degree_of_ne_zero hfn
    rw [h0] at hlow
    exact (by omega : ¬ n ≤ 0) (by exact_mod_cast hlow)
  obtain ⟨β, hβroot⟩ := IsAlgClosed.exists_root f hdeg
  have hfβ : qbarPolyEval β f = 0 := by rw [qbarPolyEval_eq_eval]; exact hβroot
  -- d := deg_F(β) と、d ∈ D_F(β) の証人 p。
  obtain ⟨p, hp, hp0, htop, hpβ⟩ := degreeOverSubfield_spec F β
  set d := degreeOverSubfield F β with hd
  have hpd : p.coeff d ≠ 0 := minimalVanishingPolynomial_leading_ne_zero F β p hp hp0 htop hpβ
  -- d ≥ 1: d = 0 なら p は定数 ac_0(p) で、aev_β(p) = ac_0(p) ≠ 0 に反する。
  have hd1 : 1 ≤ d := by
    by_contra hlt
    have hd0 : d = 0 := by omega
    have hpC : p = Polynomial.C (p.coeff 0) := by
      ext k
      rw [Polynomial.coeff_C]
      by_cases hk : k = 0
      · rw [if_pos hk, hk]
      · rw [if_neg hk]; exact htop k (by omega)
    have hval : qbarPolyEval β p = p.coeff 0 := by
      rw [qbarPolyEval_eq_eval, hpC, Polynomial.eval_C, Polynomial.coeff_C_zero]
    rw [hd0] at hpd
    exact hpd (hval ▸ hpβ)
  -- 割る（`claim_minimal_vanishing_polynomial_divides`）。
  obtain ⟨u, hu, hfu⟩ := minimalVanishingPolynomial_dvd F β p hp hp0 htop hpβ f hf hfβ
  have hu0 : u ≠ 0 := by
    intro h
    apply hfn
    rw [hfu, h, zero_mul, Polynomial.coeff_zero]
  set e := u.natDegree with he
  have hue : u.coeff e ≠ 0 := Polynomial.leadingCoeff_ne_zero.mpr hu0
  have hub : ∀ k : ℕ, e < k → u.coeff k = 0 :=
    fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  -- 積の最高次の番号は和になる: e + d = n。
  have htopf : f.coeff (e + d) ≠ 0 := by
    rw [hfu, qbarPolyProductTopCoeff u p e d hub htop]
    intro h0
    exact hpd (qbarNoZeroDivisors hue h0)
  have hboundf : ∀ k : ℕ, e + d < k → f.coeff k = 0 := by
    intro k hk
    rw [hfu]
    exact qbarPolyProductCoeffBound u p e d hub htop k hk
  have hed : e + d = n := by
    rcases lt_trichotomy (e + d) n with h | h | h
    · exact absurd (hboundf n h) hfn
    · exact h
    · exact absurd (hfz (e + d) h) htopf
  by_cases hdodd : Odd d
  · -- d が奇数の場合: β がそのまま主張の根である。
    exact ⟨β, hfβ, hdodd, by omega⟩
  · -- d が奇数でない場合: d = 2h で、e = 2(j - h) + 1 は奇数、e < n。帰納法の仮定を u に当てる。
    obtain ⟨h, hh⟩ := Nat.not_odd_iff_even.mp hdodd
    obtain ⟨j, hj⟩ := hodd
    have heodd : Odd e := ⟨j - h, by omega⟩
    have hen : e < n := by omega
    obtain ⟨γ, huγ, hγodd, hγle⟩ := ih e hen u hu heodd hue hub
    refine ⟨γ, ?_, hγodd, by omega⟩
    calc qbarPolyEval γ f
        = qbarPolyEval γ (u * p) := by rw [hfu]
      _ = qbarPolyEval γ u * qbarPolyEval γ p := by
          simp only [qbarPolyEval_eq_eval, Polynomial.eval_mul]
      _ = 0 * qbarPolyEval γ p := by rw [huγ]
      _ = 0 := zero_mul _

end Ising2DLambda.FisherZero
