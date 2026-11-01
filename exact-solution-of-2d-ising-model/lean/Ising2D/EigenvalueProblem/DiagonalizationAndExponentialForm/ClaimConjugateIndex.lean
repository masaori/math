/-
# `𝓜̌` の内側で共役添字を取る（**具体版**）

対応する人手証明のラベル: `conjugate_index_of_check_Z_Y`
（`structured-latex/content/eigenvalue_problem_diagonalization_and_exponential_form.ts` の
`evensector_003b_claim_conjugate_index_of_check_Z_Y`）

**必要十分版は無い。** (1)(3) は `θ~` の定義と添字の周期性（既存の必要十分版
`Ising2D.NecSuf.transform_periodic` の特殊化）から出る書き換えで、
新たに取り払える構造が無い。(2) は (1)・指数法則・Euler の公式・`cos(2πj) = 1, sin(2πj) = 0`
の 4 行で、使っているのは複素指数関数のこれらの性質だけであり、取り払える構造が無い。

## 原文の主張（`μ ∈ 𝓜̌`）

  (1) `θ~_{M+1-μ} = 2π - θ~_μ`
  (2) `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`  (`j ∈ ℤ`)
  (3) `check(Z)_{M+1-μ} = check(Z)_{1-μ}`,  `check(Y)_{M+1-μ} = check(Y)_{1-μ}`

(1)(2) は `μ ∈ ℤ` 全体で成り立つので、Lean でも `μ : ℤ` のまま述べる
（`𝓜̌` への制限は必要ない）。
-/
import Ising2D.EigenvalueProblem.ReductionToATheta.DefinitionCheckIndexSet

namespace Ising2D

variable {M : ℕ}

/-- **(1)**: `θ~_{M+1-μ} = 2π - θ~_μ`。 -/
theorem thetaTilde_conj (hM : M ≠ 0) (μ : ℤ) :
    thetaTilde M ((M : ℤ) + 1 - μ) = 2 * Real.pi - thetaTilde M μ := by
  have hMR : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  rw [thetaTilde, thetaTilde]
  push_cast
  field_simp
  ring

/-- **(2)**: `e^{-ij θ~_{M+1-μ}} = e^{ij θ~_μ}`（`j ∈ ℤ`）。

人手の整数 `j` は Lean の `k` である。右辺の `e^{ij θ~_μ}` は `e^{-i(-j) θ~_μ} = checkPhase M (-j) μ` である。
人手の式変形の 4 行（(1)、指数法則 `theorem_exp_product` (`n = 1`)、
Euler の公式 `euler_formula_cos_sin`、`cos(2πj) = 1, sin(2πj) = 0`）に 1 行ずつ対応させ、
両端を `checkPhase_eq_exp`（`checkPhase` が `e^{-ik θ~_μ}` そのものであること）で開く。 -/
theorem checkPhase_conj' (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = checkPhase M (-k) μ := by
  calc checkPhase M k ((M : ℤ) + 1 - μ)
      -- (∵ checkPhase は e^{-ik θ~_{M+1-μ}} そのもの)
      = Complex.exp (-(Complex.I * (k : ℂ) * (thetaTilde M ((M : ℤ) + 1 - μ) : ℂ))) :=
        checkPhase_eq_exp hM k _
      -- (∵ 直前の (1))
    _ = Complex.exp (-(Complex.I * (k : ℂ) * ((2 * Real.pi - thetaTilde M μ : ℝ) : ℂ))) := by
        rw [thetaTilde_conj hM μ]
      -- (∵ theorem_exp_product (n = 1))
    _ = Complex.exp (-(2 * (Real.pi : ℂ) * Complex.I * (k : ℂ)))
          * Complex.exp (Complex.I * (k : ℂ) * (thetaTilde M μ : ℂ)) := by
        rw [← Complex.exp_add]
        congr 1
        push_cast
        ring
      -- (∵ euler_formula_cos_sin。exp(φi) = cos φ + i sin φ を φ = -2πj に当て、cos(-x) = cos x, sin(-x) = -sin x で書き直す)
    _ = (Complex.cos (2 * (Real.pi : ℂ) * (k : ℂ)) - Complex.I * Complex.sin (2 * (Real.pi : ℂ) * (k : ℂ)))
          * Complex.exp (Complex.I * (k : ℂ) * (thetaTilde M μ : ℂ)) := by
        rw [show -(2 * (Real.pi : ℂ) * Complex.I * (k : ℂ)) = (-(2 * (Real.pi : ℂ) * (k : ℂ))) * Complex.I by ring,
          Complex.exp_mul_I, Complex.cos_neg, Complex.sin_neg]
        ring
      -- (∵ j ∈ ℤ より cos(2πj) = 1, sin(2πj) = 0)
    _ = Complex.exp (Complex.I * (k : ℂ) * (thetaTilde M μ : ℂ)) := by
        have hcos : Complex.cos (2 * (Real.pi : ℂ) * (k : ℂ)) = 1 := by
          rw [show 2 * (Real.pi : ℂ) * (k : ℂ) = (k : ℂ) * (2 * (Real.pi : ℂ)) by ring]
          exact Complex.cos_int_mul_two_pi k
        have hsin : Complex.sin (2 * (Real.pi : ℂ) * (k : ℂ)) = 0 := by
          rw [show 2 * (Real.pi : ℂ) * (k : ℂ) = ((2 * k : ℤ) : ℂ) * (Real.pi : ℂ) by push_cast; ring]
          exact Complex.sin_int_mul_pi (2 * k)
        rw [hcos, hsin]
        ring
      -- (∵ checkPhase は e^{-i(-k) θ~_μ} そのもの)
    _ = checkPhase M (-k) μ := by
        rw [checkPhase_eq_exp hM]
        congr 1
        push_cast
        ring

/-- (2) を `2M` 乗根の位相因子で書いた形: `e^{-ij θ~_{M+1-μ}} = exp(2π√-1 · j(2μ-1)/(2M))`。
`(2)` の右辺 `checkPhase M (-j) μ` を `checkPhase` の定義で開いたものである。 -/
theorem checkPhase_conj (hM : M ≠ 0) (k μ : ℤ) :
    checkPhase M k ((M : ℤ) + 1 - μ) = expPhase (2 * M) (-(k * (2 * μ - 1))) := by
  rw [checkPhase_conj' hM, checkPhase]
  congr 1
  ring

/-- **(3)**: `check(Z)_{M+1-μ} = check(Z)_{1-μ}`。

人手の式変形どおり、添字を `(1-μ)+M` と書き直し、`half_integer_checkZ_periodicity`
（`checkZ_period`）を添字 `1-μ` に当てる。 -/
theorem checkZ_conj (hM : M ≠ 0) (μ : ℤ) : checkZ M ((M : ℤ) + 1 - μ) = checkZ M (1 - μ) := by
  calc
    checkZ M ((M : ℤ) + 1 - μ) = checkZ M ((1 - μ) + (M : ℤ)) := by
      rw [show (M : ℤ) + 1 - μ = (1 - μ) + (M : ℤ) by ring]
    _ = checkZ M (1 - μ) := checkZ_period hM (1 - μ)

/-- **(3)**: `check(Y)_{M+1-μ} = check(Y)_{1-μ}`。

人手の式変形どおり、添字を `(1-μ)+M` と書き直し、`half_integer_checkY_periodicity`
（`checkY_period`）を添字 `1-μ` に当てる。 -/
theorem checkY_conj (hM : M ≠ 0) (μ : ℤ) : checkY M ((M : ℤ) + 1 - μ) = checkY M (1 - μ) := by
  calc
    checkY M ((M : ℤ) + 1 - μ) = checkY M ((1 - μ) + (M : ℤ)) := by
      rw [show (M : ℤ) + 1 - μ = (1 - μ) + (M : ℤ) by ring]
    _ = checkY M (1 - μ) := checkY_period hM (1 - μ)

/-- 共役添字での `check(Z)` の展開（`H1_H2_via_check_Z_Y` の証明の 1 行目）:
`check(Z)_{M+1-μ} = ∑_{k=1}^{M} Z_k e^{ik θ~_μ}`。 -/
theorem checkZ_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkZ M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Z k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

/-- 共役添字での `check(Y)` の展開。 -/
theorem checkY_conj_eq (hM : M ≠ 0) (μ : ℤ) :
    checkY M ((M : ℤ) + 1 - μ)
      = ∑ k : Fin M, expPhase (2 * M) (-((((k : ℕ) : ℤ) + 1) * (2 * μ - 1))) • Y k :=
  Finset.sum_congr rfl fun k _ => by rw [checkPhase_conj hM]

end Ising2D
