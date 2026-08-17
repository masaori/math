/-
章「熱力学極限」の「零でない多項式を割る一次因子の冪の指数は、係数の上界を超えない」
（`claim_qbar_linear_factor_pow_divides_exponent_le`）の具体版。

  人手証明                                                          このファイル
  f = (t-ŵ)^k·g（整除の証人）                                       `obtain ⟨g, hg⟩`
  g ≠ 0（g = 0 なら f = (t-ŵ)^k·0 = 0 で f ≠ 0 に反する）           `hg0`（`mul_zero`）
  g の非零係数の番号の集合は空でなく有限。最大元を m とする         `g.support.max'`
    ac_m(g) ≠ 0、i > m ⇒ ac_i(g) = 0                                 `hm_ne`, `hm_top`
  ac_{m+k}(f) = ac_{m+k}((t-ŵ)^k·g) = ac_m(g) ≠ 0                     `qbarLinearFactorPowMulLeadingCoeff`
  背理法: n < m+k なら ac_{m+k}(f) = 0（係数の上界）で矛盾            `by_contra`, `hn`
  よって m+k ≤ n、k ≤ m+k ≤ n                                       `Nat.le_add_left`, `le_trans`

住処: Q̄（実数体・複素数体は現れない）。`natDegree` は使わず係数で書く。
-/
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowDivides
import Ising2DLambda.ThermodynamicLimit.QbarLinearFactorPowMulLeadingCoeff

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

/-- `f ≠ 0` が係数の上界 `n` を持ち `(t - ŵ)^k ∣ f` ならば `k ≤ n`。 -/
theorem qbarLinearFactorPowDividesExponentLe (w : Qbar) (f : QbarPoly) (n : ℕ)
    (hf : f ≠ 0) (hn : ∀ i, n < i → f.coeff i = 0) (k : ℕ)
    (hdiv : qbarLinearFactorPowDivides w k f) : k ≤ n := by
  -- f = (t-ŵ)^k · g
  obtain ⟨g, hg⟩ := hdiv
  -- g ≠ 0
  have hg0 : g ≠ 0 := by
    intro h0
    apply hf
    rw [hg, h0, mul_zero]
  -- 非零係数の番号の集合は空でない。最大元 m
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
  -- ac_{m+k}(f) = ac_m(g) ≠ 0
  have hlead : f.coeff (m + k) = g.coeff m := by
    rw [hg]
    exact qbarLinearFactorPowMulLeadingCoeff w g m hm_top k
  have hf_ne : f.coeff (m + k) ≠ 0 := by
    rw [hlead]
    exact hm_ne
  -- 背理法: n < m+k なら係数の上界に反する
  have hmk : m + k ≤ n := by
    by_contra hlt
    exact hf_ne (hn (m + k) (not_le.mp hlt))
  exact le_trans (Nat.le_add_left k m) hmk

end Ising2DLambda.ThermodynamicLimit
