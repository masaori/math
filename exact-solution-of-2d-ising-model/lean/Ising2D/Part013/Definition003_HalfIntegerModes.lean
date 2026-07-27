/-
# `check(Z)_μ`, `check(Y)_μ`（半整数運動量モード）の定義（**具体版**）

対応する人手証明のラベル: `def_half_integer_modes`
（`structured-latex/content/013_even_sector_modes.ts` の
`evensector_003_definition_half_integer_modes`）

**抽象版**は `Ising2D/Abstract/AntiperiodicFourier.lean`。
とくに (1) の反周期性は `Ising2D.Abstract.pow_half_eq_neg_one`（`ξ^M = -1`）、
(2) の添字周期性は既存の `Ising2D.Abstract.transform_periodic`
（`Abstract/DiscreteFourier.lean`、重み・周波数が任意）の特殊化である。
抽象版からの導出は `Ising2D/Part013/Claim002_AntiperiodicExpSumAbstract.lean`。

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

/-- **原文の `check(Z)_μ := ∑_{j=1}^{M} Z_j e^{-i j θ~_μ}`**。 -/
noncomputable def checkZ (M : ℕ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Z j

/-- **原文の `check(Y)_μ := ∑_{j=1}^{M} Y_j e^{-i j θ~_μ}`**。 -/
noncomputable def checkY (M : ℕ) (μ : ℤ) : TensorPow M :=
  ∑ j : Fin M, checkPhase M (((j : ℕ) : ℤ) + 1) μ • Y j

/-! ## 原文が挙げる 3 つの性質 -/

/-- **(1) 反周期性**: `e^{-iM θ~_μ} = -1`。

これが 013 章全体の仕組みである（整数運動量では `e^{-iMθ_μ} = +1`）。 -/
theorem checkPhase_antiperiodic (hM : M ≠ 0) (μ : ℤ) : checkPhase M (M : ℤ) μ = -1 :=
  checkPhase_M hM μ

/-- **(2) 添字の周期性**: `check(Z)_{μ+M} = check(Z)_μ`。 -/
theorem checkZ_period (hM : M ≠ 0) (μ : ℤ) : checkZ M (μ + (M : ℤ)) = checkZ M μ :=
  Finset.sum_congr rfl fun j _ => by rw [checkPhase_period hM]

/-- **(2) 添字の周期性**: `check(Y)_{μ+M} = check(Y)_μ`。 -/
theorem checkY_period (hM : M ≠ 0) (μ : ℤ) : checkY M (μ + (M : ℤ)) = checkY M μ :=
  Finset.sum_congr rfl fun j _ => by rw [checkPhase_period hM]

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

/-- 添字の周期性の合同形: `M ∣ μ - ν` なら `check(Z)_μ = check(Z)_ν`。 -/
theorem checkZ_congr (hM : M ≠ 0) {μ ν : ℤ} (h : (M : ℤ) ∣ μ - ν) :
    checkZ M μ = checkZ M ν :=
  Finset.sum_congr rfl fun j _ => by rw [checkPhase_congr hM _ h]

/-- 添字の周期性の合同形: `M ∣ μ - ν` なら `check(Y)_μ = check(Y)_ν`。 -/
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
