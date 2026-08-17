/-
「零でない多項式を割る一次因子の冪の指数は、係数の上界を超えない」の必要十分版。

具体版と同じ手順（整除の証人 g、g ≠ 0、非零係数の番号の最大元 m、
一次因子の冪との積の先頭の係数 ac_{m+k}(f) = ac_m(g) ≠ 0、背理法で m+k ≤ n、k ≤ n）。
必要なのは可換環だけである（一次式 X - C w に加法の逆元が要り、先頭の係数の主張が
積の可換則を使う。零因子の有無は使わない——係数 1 の一次因子との積だから）。
体・代数閉性は要らない。
-/
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarLinearFactorPowMulLeadingCoeff

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

open Polynomial

theorem poly_linear_factor_pow_divides_exponent_le_necSuf {R : Type*} [CommRing R]
    (w : R) (f : R[X]) (n : ℕ)
    (hf : f ≠ 0) (hn : ∀ i, n < i → f.coeff i = 0) (k : ℕ)
    (hdiv : ∃ g : R[X], f = (X - Polynomial.C w) ^ k * g) : k ≤ n := by
  obtain ⟨g, hg⟩ := hdiv
  have hg0 : g ≠ 0 := by
    intro h0
    apply hf
    rw [hg, h0, mul_zero]
  have hne : g.support.Nonempty := by
    rw [Finset.nonempty_iff_ne_empty, Ne, Polynomial.support_eq_empty]
    exact hg0
  set m : ℕ := g.support.max' hne with hm_def
  have hm_ne : g.coeff m ≠ 0 :=
    Polynomial.mem_support_iff.mp (Finset.max'_mem g.support hne)
  have hm_top : ∀ i, m < i → g.coeff i = 0 := by
    intro i hi
    by_contra hci
    have hmem : i ∈ g.support := Polynomial.mem_support_iff.mpr hci
    exact absurd (Finset.le_max' g.support i hmem) (not_le.mpr hi)
  have hlead : f.coeff (m + k) = g.coeff m := by
    rw [hg]
    exact poly_linear_factor_pow_mul_leading_coeff_necSuf w g m hm_top k
  have hf_ne : f.coeff (m + k) ≠ 0 := by
    rw [hlead]
    exact hm_ne
  have hmk : m + k ≤ n := by
    by_contra hlt
    exact hf_ne (hn (m + k) (not_le.mp hlt))
  exact le_trans (Nat.le_add_left k m) hmk

end Ising2DLambda.NecSuf.ThermodynamicLimit
