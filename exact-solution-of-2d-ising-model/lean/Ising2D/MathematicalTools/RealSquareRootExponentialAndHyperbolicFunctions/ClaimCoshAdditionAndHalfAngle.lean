/-
# `cosh, sinh` の加法定理・半角公式と `arcsinh`

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_001_claim_cosh_addition_and_half_angle`（ラベル `cosh_addition_and_half_angle`）

**具体版**（人手証明と同じ抽象度＝実数の `cosh, sinh, arsinh`）。
必要十分版は `Ising2D/NecSuf/HyperbolicBounds.lean`
（`Ising2D.NecSuf.sinh_le_mul_cosh` ほか）。(5) の後半は必要十分版の系として導出してある。

## mathlib の状況（調査結果）

原文 `arcsinh(y) := log(y + √(y²+1))` は mathlib の `Real.arsinh`（綴りは `arcsinh` ではない）と
**定義が一致する**（`Real.arsinh x = log (x + √(1 + x^2))`）。
逆関数性 `Real.sinh_arsinh` / `Real.arsinh_sinh`、単調性 `Real.sinh_lt_sinh` /
`Real.sinh_le_sinh`、微分 `Real.hasDerivAt_arsinh` がすべて揃っているので自前定義は不要。
`t ≤ sinh t` も `Real.self_le_sinh_iff` にある。
mathlib に**無かった**のは `sinh t ≤ t cosh t` だけで、これは必要十分版で証明した。
-/
import Ising2D.NecSuf.HyperbolicBounds

namespace Ising2D

open Real

/-- 人手証明 (1): `cosh` の加法定理（`+`）。mathlib の `Real.cosh_add` そのもの。 -/
theorem cosh_add_formula (x y : ℝ) :
    Real.cosh (x + y) = Real.cosh x * Real.cosh y + Real.sinh x * Real.sinh y :=
  Real.cosh_add x y

/-- 人手証明 (1): `cosh` の加法定理（`-`）。 -/
theorem cosh_sub_formula (x y : ℝ) :
    Real.cosh (x - y) = Real.cosh x * Real.cosh y - Real.sinh x * Real.sinh y :=
  Real.cosh_sub x y

/-- 人手証明 (1): `sinh` の加法定理（`+`）。 -/
theorem sinh_add_formula (x y : ℝ) :
    Real.sinh (x + y) = Real.sinh x * Real.cosh y + Real.cosh x * Real.sinh y :=
  Real.sinh_add x y

/-- 人手証明 (1): `sinh` の加法定理（`-`）。 -/
theorem sinh_sub_formula (x y : ℝ) :
    Real.sinh (x - y) = Real.sinh x * Real.cosh y - Real.cosh x * Real.sinh y :=
  Real.sinh_sub x y

/-- 人手証明 (2): `cosh x = 1 + 2 sinh²(x/2)`。 -/
theorem cosh_eq_one_add_two_sinh_half_sq (x : ℝ) :
    Real.cosh x = 1 + 2 * Real.sinh (x / 2) ^ 2 := by
  have hcs := Real.cosh_sq (x / 2)
  have h2 := Real.cosh_two_mul (x / 2)
  rw [show 2 * (x / 2) = x by ring] at h2
  rw [h2, hcs]; ring

/-- 人手証明 (2): `sinh x = 2 sinh(x/2) cosh(x/2)`。 -/
theorem sinh_eq_two_sinh_half_mul_cosh_half (x : ℝ) :
    Real.sinh x = 2 * Real.sinh (x / 2) * Real.cosh (x / 2) := by
  have h := Real.sinh_two_mul (x / 2)
  rw [show 2 * (x / 2) = x by ring] at h
  rw [h]

/-- 人手証明 (3): `sinh` は狭義単調増加。 -/
theorem sinh_strictMono : StrictMono Real.sinh := fun _ _ h => Real.sinh_lt_sinh.2 h

/-- 人手証明 (3) の系: `sinh` は単射。 -/
theorem sinh_injective_real : Function.Injective Real.sinh := sinh_strictMono.injective

/-- 人手証明 (4): `arcsinh(y) = log(y + √(y²+1))` は mathlib の `Real.arsinh` と一致する。 -/
theorem arsinh_eq_log_form (y : ℝ) : Real.arsinh y = Real.log (y + Real.sqrt (y ^ 2 + 1)) := by
  rw [Real.arsinh]
  ring_nf

/-- 人手証明 (4): `sinh (arcsinh y) = y`。 -/
theorem sinh_arsinh_eq (y : ℝ) : Real.sinh (Real.arsinh y) = y := Real.sinh_arsinh y

/-- 人手証明 (4): `sinh u = y ⟺ u = arcsinh y`。 -/
theorem sinh_eq_iff_eq_arsinh (u y : ℝ) : Real.sinh u = y ↔ u = Real.arsinh y := by
  constructor
  · intro h; rw [← h, Real.arsinh_sinh]
  · intro h; rw [h, Real.sinh_arsinh]

/-- 人手証明 (4): `arcsinh'(y) = 1/√(y²+1)`。 -/
theorem hasDerivAt_arsinh_form (y : ℝ) :
    HasDerivAt Real.arsinh (1 / Real.sqrt (y ^ 2 + 1)) y := by
  have h := Real.hasDerivAt_arsinh y
  rw [show (1:ℝ) + y ^ 2 = y ^ 2 + 1 by ring] at h
  simpa [one_div] using h

/-- 人手証明 (5) の前半: `t ≤ sinh t`（`t ≥ 0`）。 -/
theorem self_le_sinh_of_nonneg {t : ℝ} (ht : 0 ≤ t) : t ≤ Real.sinh t :=
  Real.self_le_sinh_iff.2 ht

/-- 人手証明 (5) の後半: `sinh t ≤ t cosh t`（`t ≥ 0`）。
**必要十分版 `Ising2D.NecSuf.sinh_le_mul_cosh` の系。** -/
theorem sinh_le_mul_cosh_of_nonneg {t : ℝ} (ht : 0 ≤ t) : Real.sinh t ≤ t * Real.cosh t :=
  NecSuf.sinh_le_mul_cosh ht

/-- 人手証明 (5) そのもの。 -/
theorem cosh_addition_and_half_angle_five {t : ℝ} (ht : 0 ≤ t) :
    t ≤ Real.sinh t ∧ Real.sinh t ≤ t * Real.cosh t :=
  ⟨self_le_sinh_of_nonneg ht, sinh_le_mul_cosh_of_nonneg ht⟩

end Ising2D
