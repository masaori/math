/-
章「固有値の代数性」の「因数定理の商の係数は、上界の番号以上で零である」の具体版。
人手証明の正本は `structured-latex/content/main-text.ts` の
`claim_qbar_factor_quotient_coeff_bound` である。

`Polynomial.finset_sum_coeff` / `Polynomial.coeff_C_mul` へは委ねない。有限和の係数は
2 項の和の係数を繰り返し当てる帰納法で、定数多項式を左から掛けた積の係数は
積の係数の有限和から `i = 0` の項を取り出して示す（人手証明の鎖と同じ段割り）。

住処: Qbar。ここに ℝ / ℂ は現れない（係数は ℚ の代数閉包の元、番号は ℕ）。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPowDiffSumCoeffBound

namespace Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の第 2 の等号: 有限和の係数は係数の有限和である（2 項の和の係数を繰り返し当てる）。 -/
theorem qbarPolyCoeffRangeSum (F : ℕ → QbarPoly) (m j : ℕ) :
    (∑ k ∈ Finset.range m, F k).coeff j = ∑ k ∈ Finset.range m, (F k).coeff j := by
  induction m with
  | zero =>
      rw [Finset.range_zero, Finset.sum_empty, Finset.sum_empty, Polynomial.coeff_zero]
  | succ m ih =>
      rw [Finset.sum_range_succ, Polynomial.coeff_add, ih, Finset.sum_range_succ]

/-- 人手証明の第 3〜8 の等号: 定数多項式を左から掛けた積の係数を、
積の係数の有限和から `i = 0` の項を取り出して示す段。 -/
theorem qbarPolyCoeffConstMul (a : Qbar) (p : QbarPoly) (j : ℕ) :
    (qbarConst a * p).coeff j = a * p.coeff j := by
  rw [qbarConst, Polynomial.coeff_mul]
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

/-- `n ≤ j` ならば、因数定理の商 `g = Σ_{k=0}^{n} ac_k(f)^ · K_k(w)` の
`j` 番目の係数は零である。根の条件 `aev_w(f) = 0` は仮定しない。 -/
theorem qbarFactorQuotientCoeffBound (f : QbarPoly) (w : Qbar) (n j : ℕ) (h : n ≤ j) :
    (∑ k ∈ Finset.range (n + 1),
      qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j = 0 := by
  calc
    (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j
        = ∑ k ∈ Finset.range (n + 1),
            (qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j :=
          qbarPolyCoeffRangeSum _ _ _
    _ = ∑ k ∈ Finset.range (n + 1), f.coeff k * (qbarPolyPowDiffSum w k).coeff j := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          exact qbarPolyCoeffConstMul _ _ _
    _ = ∑ k ∈ Finset.range (n + 1), f.coeff k * 0 := by
          refine Finset.sum_congr rfl (fun k hk => ?_)
          have hk' : k ≤ j := by
            have hkn := Finset.mem_range.mp hk
            omega
          rw [qbarPowDiffSumCoeffBound w k j hk']
    _ = ∑ k ∈ Finset.range (n + 1), (0 : Qbar) := by
          refine Finset.sum_congr rfl (fun k _ => ?_)
          exact mul_zero _
    _ = 0 := Finset.sum_const_zero

end Ising2DLambda.AlgebraicEigenvalue
