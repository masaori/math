/-
# `sinh 2K_c = 1` と `|d²f/dK²(K) - (8/π) log(1/|K-K_c|)| ≤ 49`

対応する人手証明（正本は `structured-latex/content/critical_point_and_log_divergence.ts`）:

* `critical_point_claim_sinh_K_c_and_second_derivative_log_divergence`
  （ラベル **`critical_point_sinh_K_c_and_second_derivative_log_divergence`**）

主張（`K_1 = K_2 = K > 0`。`f(K) := (1/2)log(2 sinh 2K) + (1/4π)∫₀^{2π} γ(θ)dθ`）:

1. `kappa_of_K_basic` の `K_c`（`Kc`。`sinh 2K_c = 1` で定めたもの）は `(1/2)log(1+√2)` を満たし、正で、
   `sinh 2K = 1` を満たす `ℝ_{>0}` の元は `K_c` だけである。
2. `0 < |K-K_c| ≤ 1/10` で `f` は `K` で 2 回微分可能で、`|f''(K) - (8/π)log(1/|K-K_c|)| ≤ 49`。

`K_c` は `Ising2D.Kc`（`arsinh 1 / 2`）、等方な場合の結合定数の組は `isoParam K hK`、
`γ(θ)` は `gammaFn (isoParam K hK) θ`、人手 `specific_heat_log_divergence` の `f` は `fFun` である。

## 人手証明との対応

- (1): 人手 `kappa_of_K_basic` の `K_c` の定義（`sinh_two_Kc`）と、`cosh_addition_and_half_angle` (3)(4) の
  `arcsinh(y) = log(y + √(y²+1))`（`arsinh_eq_log_form`）と `sinh` の単射性（`sinh_injective_real`）。
  正であることは `Kc_pos`。
- (2) の式変形 `f(K) = (1/2)log(2 sinh 2K) + G(κ(K))`: 人手 `isotropic_A_equals_one` と `G` の定義
  （`integral_gammaFn_isoParam`）。`f` が 2 重極限の値であることは人手の主張に含まれない
  （人手は `f` を `c_plus_value_c_sandwich_and_double_limit_of_log_Z` (3) の右辺として定義するだけ）ので、ここでは述べない。
- (2) の不等式: 人手 `specific_heat_log_divergence` の二つ目の不等式（`specific_heat_log_divergence_dist`）と、
  2 回微分可能であること（`hasDerivAt_deriv_fFun`）。

## 仮定

`K > 0` だけである。人手の主張は既存の主張を並べるだけなので、必要十分版は置かない
（`κ` の増分の評価の必要十分版は `Ising2D/NecSuf/MeanValueTwoSided.lean`、積分記号下の微分は
`Ising2D/NecSuf/DiffUnderIntegral.lean` が持つ）。
-/
import Ising2D.Part020.Theorem012_SpecificHeatLogDivergence

namespace Ising2D

/-- **人手 `critical_point_sinh_K_c_and_second_derivative_log_divergence` の (1)**:
`K_c = (1/2)log(1+√2)`、`K_c > 0`、`sinh 2K_c = 1`、`sinh 2K = 1` を満たす正の `K` は `K_c` だけ。 -/
theorem Kc_eq_half_log_and_unique :
    Kc = Real.log (1 + Real.sqrt 2) / 2 ∧ 0 < Kc ∧ Real.sinh (2 * Kc) = 1
      ∧ ∀ K : ℝ, 0 < K → Real.sinh (2 * K) = 1 → K = Kc := by
  refine ⟨?_, Kc_pos, sinh_two_Kc, ?_⟩
  · -- 人手 cosh_addition_and_half_angle (4): arcsinh(1) = log(1 + √(1² + 1))
    rw [Kc, arsinh_eq_log_form]
    norm_num
  · intro K _ hK
    -- sinh は単射（人手 cosh_addition_and_half_angle (3)）
    have h : Real.sinh (2 * K) = Real.sinh (2 * Kc) := by rw [hK, sinh_two_Kc]
    have := sinh_injective_real h
    linarith

/-- **人手 `critical_point_sinh_K_c_and_second_derivative_log_divergence`**:
(1) `K_c = (1/2)log(1+√2)`、`K_c > 0`、`sinh 2K_c = 1`、`sinh 2K = 1` を満たす正の `K` は `K_c` だけ。
(2) `0 < |K-K_c| ≤ 1/10` で、人手の `f(K) = (1/2)log(2 sinh 2K) + (1/4π)∫γ` が `fFun K` に等しく
（人手の証明 (2) の式変形）、`fFun` は `K` で 2 回微分可能で `|f''(K) - (8/π)log(1/|K-K_c|)| ≤ 49`。 -/
theorem critical_point_sinh_K_c_and_second_derivative_log_divergence :
    (Kc = Real.log (1 + Real.sqrt 2) / 2 ∧ 0 < Kc ∧ Real.sinh (2 * Kc) = 1
      ∧ ∀ K : ℝ, 0 < K → Real.sinh (2 * K) = 1 → K = Kc)
    ∧ (∀ (K : ℝ) (hK : 0 < K), 0 < |K - Kc| → |K - Kc| ≤ 1 / 10 →
        1 / 2 * Real.log (2 * Real.sinh (2 * K))
            + 1 / (4 * Real.pi) * ∫ θ in (0 : ℝ)..(2 * Real.pi), gammaFn (isoParam K hK) θ
          = fFun K
        ∧ HasDerivAt (deriv fFun) (fSecond K) K
        ∧ |deriv (deriv fFun) K - (8 / Real.pi) * Real.log (1 / |K - Kc|)| ≤ 49) := by
  refine ⟨Kc_eq_half_log_and_unique, fun K hK h0 h1 => ?_⟩
  have hKD : K ∈ Dnbhd := by
    rw [abs_le] at h1
    exact Set.mem_Icc.2 ⟨by linarith [h1.1], by linarith [h1.2]⟩
  have hKc : K ≠ Kc := fun h => by rw [h, sub_self, abs_zero] at h0; exact lt_irrefl 0 h0
  -- 人手 (2) の式変形: isotropic_A_equals_one と G の定義
  refine ⟨by rw [integral_gammaFn_isoParam K hK]; rfl, ?_, ?_⟩
  -- 人手 (2): specific_heat_log_divergence（2 回微分可能であることと二つ目の不等式）
  · exact hasDerivAt_deriv_fFun hK hKc
  · exact specific_heat_log_divergence_dist hKD hKc

end Ising2D
