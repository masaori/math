/-
主張「因数定理の商の係数は、上界の番号以上で零である」の必要十分版。
具体版と同じ段割りを一般の半環係数の多項式で行う。要求するのは和・積の係数と
零元・単位元だけであり、加法の逆元、積の可換性、体、代数閉性は使わない。
さらに係数の列は任意の写像 `c : ℕ → R` でよく、多項式の係数であることも使わない
（具体版は `c = f.coeff` の特殊化である）。

住処: ここに ℝ / ℂ は現れない（係数は一般の半環の元、番号は ℕ）。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarPowDiffSumCoeffBound

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

open Polynomial

/-- 有限和の係数は係数の有限和である（半環係数。2 項の和の係数を繰り返し当てる）。 -/
theorem coeff_range_sum_necSuf {R : Type*} [Semiring R] (F : ℕ → R[X]) (m j : ℕ) :
    (∑ k ∈ Finset.range m, F k).coeff j = ∑ k ∈ Finset.range m, (F k).coeff j := by
  induction m with
  | zero =>
      rw [Finset.range_zero, Finset.sum_empty, Finset.sum_empty, Polynomial.coeff_zero]
  | succ m ih =>
      rw [Finset.sum_range_succ, Polynomial.coeff_add, ih, Finset.sum_range_succ]

/-- 定数多項式を左から掛けた積の係数（半環係数。積の係数の有限和から `i = 0` の項を取り出す）。 -/
theorem coeff_C_mul_necSuf {R : Type*} [Semiring R] (a : R) (p : R[X]) (j : ℕ) :
    (C a * p).coeff j = a * p.coeff j := by
  rw [Polynomial.coeff_mul]
  rw [Finset.sum_eq_single ((0, j) : ℕ × ℕ)]
  · simp
  · intro b hb hne
    have hb' : b.1 + b.2 = j := Finset.mem_antidiagonal.mp hb
    have hb1 : b.1 ≠ 0 := by
      intro h0
      apply hne
      have hb2 : b.2 = j := by omega
      exact Prod.ext h0 hb2
    simp only [Polynomial.coeff_C, if_neg hb1, zero_mul]
  · intro h
    exact absurd (Finset.mem_antidiagonal.mpr (by omega : 0 + j = j)) h

/-- 半環係数でも、`n ≤ j` ならば商 `Σ_{k=0}^{n} C (c k) · K_k(w)` の
`j` 番目の係数は零である。係数の列 `c` は任意の写像でよい。 -/
theorem factor_quotient_coeff_bound_necSuf {R : Type*} [Semiring R]
    (c : ℕ → R) (w : R) (n j : ℕ) (h : n ≤ j) :
    (∑ k ∈ Finset.range (n + 1), C (c k) * powDiffSum_necSuf w k).coeff j = 0 := by
  calc
    (∑ k ∈ Finset.range (n + 1), C (c k) * powDiffSum_necSuf w k).coeff j
        = ∑ k ∈ Finset.range (n + 1), (C (c k) * powDiffSum_necSuf w k).coeff j :=
          coeff_range_sum_necSuf _ _ _
    _ = ∑ k ∈ Finset.range (n + 1), c k * (powDiffSum_necSuf w k).coeff j := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          exact coeff_C_mul_necSuf _ _ _
    _ = ∑ k ∈ Finset.range (n + 1), c k * 0 := by
          refine Finset.sum_congr rfl (fun k hk => ?_)
          have hk' : k ≤ j := by
            have hkn := Finset.mem_range.mp hk
            omega
          rw [pow_diff_sum_coeff_bound_necSuf w k j hk']
    _ = ∑ k ∈ Finset.range (n + 1), (0 : R) := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          exact mul_zero _
    _ = 0 := Finset.sum_const_zero

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
