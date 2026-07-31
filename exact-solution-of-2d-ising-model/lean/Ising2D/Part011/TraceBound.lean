/-
# 半正定値行列に対する `xᵀAx ≤ ‖x‖² tr(A)`

正本: `structured-latex/content/011_max_eigenvalue.ts`
（`maxeig_008_claim_trace_power_sandwich` の Step 3 の途中で使われる補題）

人手証明の該当箇所:

```
xᵀ A x ≤ (∑_k |x_k| √(A_kk))² ≤ (∑_k x_k²)(∑_k A_kk) = ‖x‖² tr(A)
```

1 つ目の不等号は `psd_cauchy_schwarz` から出る `|A_kl| ≤ √(A_kk A_ll)` を成分表示へ代入したもの、
2 つ目は `ℝ^d` の Cauchy–Schwarz である。

**必要十分版を別に置かない理由**: この主張は「有限添字集合」と「平方根の取れる順序体」を
本質的に使う（跡は有限添字でしか定義されず、`√(A_kk)` を経由しない証明を人手証明は
採っていない）。ここでの `n` は既に任意の有限型なので、これ以上ほどく余地がない。
-/
import Ising2D.Part011.Claim005_PsdCauchySchwarz

set_option linter.unusedSectionVars false

namespace Ising2D

open Matrix

variable {n : Type*} [Fintype n] [DecidableEq n]

/-- 半正定値行列の対角成分は非負。 -/
theorem psd_diag_nonneg {A : Matrix n n ℝ} (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ A *ᵥ x) (i : n) :
    0 ≤ A i i := by
  have h := hpsd (Pi.single i 1)
  rwa [single_dotProduct_mulVec_single] at h

/-- `|A_ij| ≤ √(A_ii)√(A_jj)`（人手証明の `|A_kl| = |e_kᵀ A e_l| ≤ √(A_kk A_ll)`）。 -/
theorem psd_abs_entry_le {A : Matrix n n ℝ} (hA : A.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ A *ᵥ x) (i j : n) :
    |A i j| ≤ Real.sqrt (A i i) * Real.sqrt (A j j) := by
  have hcs := psd_cauchy_schwarz hA hpsd (Pi.single i 1) (Pi.single j 1)
  rw [single_dotProduct_mulVec_single, single_dotProduct_mulVec_single,
    single_dotProduct_mulVec_single] at hcs
  -- `hcs : (A j i)^2 ≤ A i i * A j j`
  have hji : A j i = A i j := hA.apply i j
  rw [hji] at hcs
  have h1 : |A i j| = Real.sqrt ((A i j) ^ 2) := (Real.sqrt_sq_eq_abs _).symm
  rw [h1, ← Real.sqrt_mul (psd_diag_nonneg hpsd i)]
  exact Real.sqrt_le_sqrt hcs

/-- **半正定値対称行列に対する `xᵀAx ≤ ‖x‖² tr(A)`**。 -/
theorem psd_quad_le_normSq_mul_trace {A : Matrix n n ℝ} (hA : A.IsSymm)
    (hpsd : ∀ x : n → ℝ, 0 ≤ x ⬝ᵥ A *ᵥ x) (x : n → ℝ) :
    x ⬝ᵥ A *ᵥ x ≤ vecNormSq x * A.trace := by
  classical
  set S : ℝ := ∑ i, |x i| * Real.sqrt (A i i) with hS
  have hexpand : x ⬝ᵥ A *ᵥ x = ∑ i, ∑ j, x i * (A i j * x j) := by
    simp [dotProduct, Matrix.mulVec, Finset.mul_sum]
  have hSS : S * S = ∑ i, ∑ j, (|x i| * Real.sqrt (A i i)) * (|x j| * Real.sqrt (A j j)) := by
    rw [hS, Finset.sum_mul_sum]
  have hstep1 : x ⬝ᵥ A *ᵥ x ≤ S * S := by
    rw [hexpand, hSS]
    refine Finset.sum_le_sum fun i _ => Finset.sum_le_sum fun j _ => ?_
    have habs : x i * (A i j * x j) ≤ |x i| * |A i j| * |x j| := by
      calc x i * (A i j * x j) ≤ |x i * (A i j * x j)| := le_abs_self _
        _ = |x i| * |A i j| * |x j| := by
              rw [abs_mul, abs_mul]
              ring
    have hentry := psd_abs_entry_le hA hpsd i j
    have : |x i| * |A i j| * |x j|
        ≤ |x i| * (Real.sqrt (A i i) * Real.sqrt (A j j)) * |x j| := by
      have h0 : (0 : ℝ) ≤ |x i| := abs_nonneg _
      have h1 : (0 : ℝ) ≤ |x j| := abs_nonneg _
      have := mul_le_mul_of_nonneg_left hentry h0
      exact mul_le_mul_of_nonneg_right this h1
    calc x i * (A i j * x j) ≤ |x i| * |A i j| * |x j| := habs
      _ ≤ |x i| * (Real.sqrt (A i i) * Real.sqrt (A j j)) * |x j| := this
      _ = (|x i| * Real.sqrt (A i i)) * (|x j| * Real.sqrt (A j j)) := by ring
  have hstep2 : S * S ≤ (∑ i, |x i| ^ 2) * ∑ i, Real.sqrt (A i i) ^ 2 := by
    have h := Finset.sum_mul_sq_le_sq_mul_sq Finset.univ (fun i => |x i|)
      (fun i => Real.sqrt (A i i))
    calc S * S = (∑ i, |x i| * Real.sqrt (A i i)) ^ 2 := by rw [hS, sq]
      _ ≤ (∑ i, |x i| ^ 2) * ∑ i, Real.sqrt (A i i) ^ 2 := h
  have hx2 : (∑ i, |x i| ^ 2) = vecNormSq x := by
    rw [vecNormSq_eq_sum]
    exact Finset.sum_congr rfl fun i _ => sq_abs (x i)
  have hA2 : (∑ i, Real.sqrt (A i i) ^ 2) = A.trace := by
    rw [Matrix.trace]
    exact Finset.sum_congr rfl fun i _ => Real.sq_sqrt (psd_diag_nonneg hpsd i)
  calc x ⬝ᵥ A *ᵥ x ≤ S * S := hstep1
    _ ≤ (∑ i, |x i| ^ 2) * ∑ i, Real.sqrt (A i i) ^ 2 := hstep2
    _ = vecNormSq x * A.trace := by rw [hx2, hA2]

end Ising2D
