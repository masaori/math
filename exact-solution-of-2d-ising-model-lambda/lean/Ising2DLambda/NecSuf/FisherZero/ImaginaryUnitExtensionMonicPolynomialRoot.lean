/-
「虚数単位を足した体を係数とする、最高次の係数が一の多項式は、その体に根を持つ」の必要十分版。
具体版と同じ段（準備 (一)〜(四) と、根の取り出し・場合分け）を、段が実際に使う仮定だけの上で行う。

- 台 `L` は零因子の無い可換環（`aev_z(g)·aev_z(cjp(g)) = 0` から片方の零を取り出す段）。
  逆元・順序・代数閉性は使わない。
- 係数の部分集合 `S`（具体版の F）は零元・単位元を含むこと。`cj(0) = 0`・`cj(1) = 1` を
  `cj(a + bω) = a - bω`（`hcj`）から出す準備 (一) に使う。S の演算での閉性は使わない。
- 根の部分集合 `T`（具体版の Lin_F(ω) = F(ω)）は `cj` で閉じること（`hcjmem`）。
- 写像 `cjp` の係数が `cj` の値であること（`hcjp`。具体版は係数の共役の定義）。
- 部品の結論を三つ仮定に取る。積 `g·cjp(g)` の係数が S に入ること（`hprodS`。具体版は
  `claim_imaginary_unit_extension_conjugate_product_subfield_coefficient`）、S 係数で最高次の係数が一の
  多項式が T に根を持つこと（`hroot`。具体版は `claim_subfield_polynomial_root_in_imaginary_unit_extension`
  と K = Lin_F(ω)）、共役と値の入れ替え（`hev`。具体版は
  `claim_imaginary_unit_extension_conjugate_evaluation`）。
  `ω·ω = -1`・正錐・平方根・奇数次の根の仮定はこれらの部品の中でだけ使い、この合成は使わない。
-/
import Ising2DLambda.NecSuf.FisherZero.OddDegreePolynomialHasOddDegreeRoot
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPolyProductCoeffBound
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 具体版と同じ段で示す。 -/
theorem imaginaryUnitExtension_monicPolynomial_root_necSuf
    {L : Type*} [CommRing L] [NoZeroDivisors L] (S T : Set L)
    (hzero : (0 : L) ∈ S) (hone : (1 : L) ∈ S)
    (omega : L) (cj : L → L) (hcj : ∀ a b : L, a ∈ S → b ∈ S → cj (a + b * omega) = a - b * omega)
    (hcjmem : ∀ z : L, z ∈ T → cj z ∈ T)
    (cjp : Polynomial L → Polynomial L) (hcjp : ∀ (g : Polynomial L) (k : ℕ), (cjp g).coeff k = cj (g.coeff k))
    (hprodS : ∀ g : Polynomial L, (∀ k : ℕ, g.coeff k ∈ T) → ∀ k : ℕ, (g * cjp g).coeff k ∈ S)
    (hroot : ∀ (n : ℕ) (f : Polynomial L), 1 ≤ n → (∀ k : ℕ, f.coeff k ∈ S) →
      (∀ k : ℕ, n < k → f.coeff k = 0) → f.coeff n = 1 → ∃ z : L, z ∈ T ∧ f.eval z = 0)
    (hev : ∀ g : Polynomial L, (∀ k : ℕ, g.coeff k ∈ T) → ∀ z : L, z ∈ T →
      g.eval (cj z) = cj ((cjp g).eval z))
    (d : ℕ) (hd : 1 ≤ d) (g : Polynomial L) (hg : ∀ k : ℕ, g.coeff k ∈ T)
    (hbound : ∀ k : ℕ, d < k → g.coeff k = 0) (hlead : g.coeff d = 1) :
    ∃ w : L, w ∈ T ∧ g.eval w = 0 := by
  -- 準備 (一)。
  have hcj0 : cj 0 = 0 := by
    calc cj 0 = cj (0 + 0 * omega) := by ring_nf
      _ = 0 - 0 * omega := hcj 0 0 hzero hzero
      _ = 0 := by ring
  have hcj1 : cj 1 = 1 := by
    calc cj 1 = cj (1 + 0 * omega) := by ring_nf
      _ = 1 - 0 * omega := hcj 1 0 hone hzero
      _ = 1 := by ring
  -- 準備 (二)。
  have hbound' : ∀ k : ℕ, d < k → (cjp g).coeff k = 0 := by
    intro k hk
    calc (cjp g).coeff k = cj (g.coeff k) := hcjp g k
      _ = cj 0 := by rw [hbound k hk]
      _ = 0 := hcj0
  have hlead' : (cjp g).coeff d = 1 := by
    calc (cjp g).coeff d = cj (g.coeff d) := hcjp g d
      _ = cj 1 := by rw [hlead]
      _ = 1 := hcj1
  -- 準備 (三)・(四)。
  have hhbound : ∀ k : ℕ, d + d < k → (g * cjp g).coeff k = 0 :=
    Ising2DLambda.NecSuf.AlgebraicEigenvalue.poly_product_coeff_bound_necSuf g _ d d hbound hbound'
  have hhlead : (g * cjp g).coeff (d + d) = 1 := by
    calc (g * cjp g).coeff (d + d) = g.coeff d * (cjp g).coeff d :=
          productTopCoeff_necSuf g _ d d hbound hbound'
      _ = 1 * 1 := by rw [hlead, hlead']
      _ = 1 := one_mul 1
  -- 主張。
  obtain ⟨z, hzT, hz⟩ := hroot (d + d) (g * cjp g) (by omega) (hprodS g hg) hhbound hhlead
  have hprod : g.eval z * (cjp g).eval z = 0 := by
    calc g.eval z * (cjp g).eval z = (g * cjp g).eval z := (Polynomial.eval_mul).symm
      _ = 0 := hz
  by_cases hgz : g.eval z = 0
  · exact ⟨z, hzT, hgz⟩
  · have hcz : (cjp g).eval z = 0 := (mul_eq_zero.mp hprod).resolve_left hgz
    refine ⟨cj z, hcjmem z hzT, ?_⟩
    calc g.eval (cj z) = cj ((cjp g).eval z) := hev g hg z hzT
      _ = cj 0 := by rw [hcz]
      _ = 0 := hcj0

end Ising2DLambda.NecSuf.FisherZero
