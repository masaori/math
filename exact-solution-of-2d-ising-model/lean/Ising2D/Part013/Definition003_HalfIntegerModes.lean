/-
# `check(Z)_μ`, `check(Y)_μ`（半整数運動量モード）の定義（**具体版**）

対応する人手証明のラベル: `def_half_integer_checkZ`, `def_half_integer_checkY`,
`half_integer_phase_antiperiodicity`, `half_integer_checkZ_periodicity`,
`half_integer_checkY_periodicity`,
`def_half_integer_modes`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_003_definition_half_integer_checkZ`,
`evensector_003_definition_half_integer_checkY`,
`evensector_003_claim_half_integer_phase_antiperiodicity`,
`evensector_003_claim_half_integer_checkZ_periodicity`,
`evensector_003_claim_half_integer_checkY_periodicity`,
`evensector_003_definition_half_integer_modes`）

**必要十分版**は `Ising2D/NecSuf/AntiperiodicFourier.lean`。
とくに反周期性は `Ising2D.NecSuf.pow_half_eq_neg_one`（`ξ^M = -1`）、
(2) の添字周期性は既存の `Ising2D.NecSuf.transform_periodic`
（`NecSuf/DiscreteFourier.lean`、重み・周波数が任意）の特殊化である。
必要十分版からの導出は `Ising2D/Part013/Claim002_AntiperiodicExpSumFromNecSuf.lean`。

## 原文の定義（`M ∈ ℤ_{≥2}`、`μ ∈ ℤ`）

  `check(Z)_μ := ∑_{j=1}^{M} Z_j e^{-i j θ~_μ}`,  `check(Y)_μ := ∑_{j=1}^{M} Y_j e^{-i j θ~_μ}`

`hat(Z)^{(±)}` と違い**係数に例外項が無い**（`Ising2D.firstSign` にあたるものが無い）。
境界の符号は位相の反周期性 `e^{-iM θ~_μ} = -1` が自動的に出す。

## 形式化の方針

* 位相因子は `Ising2D.checkPhase`（`Part013/Claim002_AntiperiodicExpSum.lean`）。
* site 添字は `Fin M` で、原文の `j` は `(j : ℕ) + 1`。
* 添字 `μ` は `ℤ` のまま扱う（原文が (2) と `periodicity_of_check_fermi` のために
  定義域を `ℤ` にしているのと同じ）。
-/
import Ising2D.Part013.Claim002_AntiperiodicExpSum
import Ising2D.Part004.Claim011_H1H2ViaHat

namespace Ising2D

variable {M : ℕ}

/-- **`def_half_integer_checkZ`**:
原文の `check(Z)_μ := ∑_{j=1}^{M} Z_j e^{-i j θ~_μ}`。 -/
noncomputable def checkZ (M : ℕ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j

/-- **`def_half_integer_checkY`**:
原文の `check(Y)_μ := ∑_{j=1}^{M} Y_j e^{-i j θ~_μ}`。 -/
noncomputable def checkY (M : ℕ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Y j

/-! ## 独立させた反周期性・Z/Y 行列の周期性と `def_half_integer_modes` に残した共役添字 -/

/-- **`half_integer_phase_antiperiodicity`（反周期性）**: `e^{-iM θ~_μ} = -1`。

これが 013 章全体の仕組みである（整数運動量では `e^{-iMθ_μ} = +1`）。 -/
theorem checkPhase_antiperiodic (hM : M ≠ 0) (μ : ℤ) : checkPhase M (M : ℤ) μ = -1 :=
  checkPhase_M hM μ

/-- **`half_integer_checkZ_periodicity`**: `check(Z)_{μ+M} = check(Z)_μ`。 -/
theorem thetaTilde_period_for_checkZY (hM : M ≠ 0) (μ : ℤ) :
    thetaTilde M (μ + (M : ℤ)) = thetaTilde M μ + 2 * Real.pi := by
  have hMR : (M : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hM
  calc
    thetaTilde M (μ + (M : ℤ))
        = 2 * Real.pi * (((μ : ℝ) + M) - 1 / 2) / M := by
            rw [thetaTilde]
            push_cast
            rfl
    _ = (2 * Real.pi * ((μ : ℝ) - 1 / 2) + 2 * Real.pi * M) / M := by ring
    _ = 2 * Real.pi * ((μ : ℝ) - 1 / 2) / M + (2 * Real.pi * M) / M := by
          rw [add_div]
    _ = 2 * Real.pi * ((μ : ℝ) - 1 / 2) / M + 2 * Real.pi := by
          field_simp
    _ = thetaTilde M μ + 2 * Real.pi := by rw [thetaTilde]

/-- 負角の Euler 公式を、本文と同じ実数の正弦・余弦で書いたもの。 -/
theorem checkPhase_eq_cos_sub_I_sin (hM : M ≠ 0) (j μ : ℤ) :
    checkPhase M j μ =
      (Real.cos ((j : ℝ) * thetaTilde M μ) : ℂ)
        - Complex.I * (Real.sin ((j : ℝ) * thetaTilde M μ) : ℂ) := by
  rw [checkPhase_eq_exp hM]
  rw [show -(Complex.I * (j : ℂ) * (thetaTilde M μ : ℂ)) =
      ((-((j : ℝ) * thetaTilde M μ) : ℝ) : ℂ) * Complex.I by
        push_cast
        ring]
  rw [Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin,
    Real.cos_neg, Real.sin_neg]
  push_cast
  ring

/-- 本文の「角度を `2π` ずらし、Euler 公式と三角関数の周期性を使う」経路で示す位相周期性。 -/
theorem checkPhase_period_for_checkZY (hM : M ≠ 0) (j μ : ℤ) :
    checkPhase M j (μ + (M : ℤ)) = checkPhase M j μ := by
  calc
    checkPhase M j (μ + (M : ℤ))
        = (Real.cos ((j : ℝ) * thetaTilde M (μ + (M : ℤ))) : ℂ)
            - Complex.I * (Real.sin ((j : ℝ) * thetaTilde M (μ + (M : ℤ))) : ℂ) :=
          checkPhase_eq_cos_sub_I_sin hM j _
    _ = (Real.cos ((j : ℝ) * (thetaTilde M μ + 2 * Real.pi)) : ℂ)
            - Complex.I * (Real.sin ((j : ℝ) * (thetaTilde M μ + 2 * Real.pi)) : ℂ) := by
          rw [thetaTilde_period_for_checkZY hM]
    _ = (Real.cos ((j : ℝ) * thetaTilde M μ + (j : ℝ) * (2 * Real.pi)) : ℂ)
            - Complex.I *
                (Real.sin ((j : ℝ) * thetaTilde M μ + (j : ℝ) * (2 * Real.pi)) : ℂ) := by
          ring
    _ = (Real.cos ((j : ℝ) * thetaTilde M μ) : ℂ)
            - Complex.I * (Real.sin ((j : ℝ) * thetaTilde M μ) : ℂ) := by
          rw [Real.cos_add_int_mul_two_pi, Real.sin_add_int_mul_two_pi]
    _ = checkPhase M j μ := (checkPhase_eq_cos_sub_I_sin hM j μ).symm

/-- **`half_integer_checkZ_periodicity`**: `check(Z)_{μ+M} = check(Z)_μ`。 -/
theorem checkZ_period (hM : M ≠ 0) (μ : ℤ) : checkZ M (μ + (M : ℤ)) = checkZ M μ := by
  calc
    checkZ M (μ + (M : ℤ)) =
        ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (μ + (M : ℤ)) • Z j := rfl
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j :=
      Finset.sum_congr rfl fun j _ => by rw [checkPhase_period_for_checkZY hM]
    _ = checkZ M μ := rfl

/-- **`half_integer_checkY_periodicity`**: `check(Y)_{μ+M} = check(Y)_μ`。 -/
theorem checkY_period (hM : M ≠ 0) (μ : ℤ) : checkY M (μ + (M : ℤ)) = checkY M μ := by
  calc
    checkY M (μ + (M : ℤ)) =
        ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) (μ + (M : ℤ)) • Y j := rfl
    _ = ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Y j :=
      Finset.sum_congr rfl fun j _ => by rw [checkPhase_period_for_checkZY hM]
    _ = checkY M μ := rfl

/-- 位相因子の合同不変性: `M ∣ a - b` なら `e^{-i k θ~_a} = e^{-i k θ~_b}`。

奇数周波数の差 `(2a-1) - (2b-1) = 2(a-b)` が `2M` の倍数になることによる。 -/
theorem checkPhase_congr (hM : M ≠ 0) (k : ℤ) {a b : ℤ} (h : (M : ℤ) ∣ a - b) :
    checkPhase M k a = checkPhase M k b := by
  rw [checkPhase, checkPhase]
  refine expPhase_congr (M := 2 * M) (by omega) ?_
  obtain ⟨c, hc⟩ := h
  refine ⟨k * c, ?_⟩
  rw [show k * (2 * a - 1) - k * (2 * b - 1) = 2 * (k * (a - b)) by ring, hc]
  push_cast
  ring

/-- **`half_integer_checkZ_periodicity` の合同形**:
`M ∣ μ - ν` なら `check(Z)_μ = check(Z)_ν`。 -/
theorem checkZ_congr (hM : M ≠ 0) {μ ν : ℤ} (h : (M : ℤ) ∣ μ - ν) :
    checkZ M μ = checkZ M ν :=
  Finset.sum_congr rfl fun j _ => by rw [checkPhase_congr hM _ h]

/-- **`half_integer_checkY_periodicity` の合同形**:
`M ∣ μ - ν` なら `check(Y)_μ = check(Y)_ν`。 -/
theorem checkY_congr (hM : M ≠ 0) {μ ν : ℤ} (h : (M : ℤ) ∣ μ - ν) :
    checkY M μ = checkY M ν :=
  Finset.sum_congr rfl fun j _ => by rw [checkPhase_congr hM _ h]

/-- **(3) 共役添字**: `θ~_{1-μ} = -θ~_μ`。 -/
theorem thetaTilde_one_sub (M : ℕ) (μ : ℤ) : thetaTilde M (1 - μ) = -thetaTilde M μ := by
  rw [thetaTilde, thetaTilde]
  push_cast
  ring

/-- (3) の位相因子版: `e^{-i k θ~_{1-μ}} = e^{i k θ~_μ}`。 -/
theorem checkPhase_one_sub (M : ℕ) (k μ : ℤ) :
    checkPhase M k (1 - μ) = expPhase (2 * M) (-(k * (2 * μ - 1))) := by
  rw [checkPhase]
  congr 1
  ring

end Ising2D
