/-
# `cosh, sinh` の加法定理・半角公式と `arcsinh`

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- 下の (2)〜(5) は旧ラベル `cosh_addition_and_half_angle` の項の番号である。本文ではこのブロックは 1 ブロック 1 主張へ
  分割されて無い（(2) は `cosh_half_angle_formula`・`sinh_double_angle_formula` など）。
- (1) の加法定理は `critical_claim_cosh_addition_formula`（ラベル `cosh_addition_formula`）と
  `critical_claim_sinh_addition_formula`（ラベル `sinh_addition_formula`）。`cosh_add_formula`・`cosh_sub_formula`・
  `sinh_add_formula`・`sinh_sub_formula` の `calc` は、それぞれの複号の人手の鎖と 1 対 1 である。

**具体版**（人手証明と同じ抽象度＝実数の `cosh, sinh, arsinh`）。
必要十分版は `Ising2D/NecSuf/HyperbolicBounds.lean`
（`Ising2D.NecSuf.sinh_le_mul_cosh` ほか）。(5) の後半は必要十分版の系として導出してある。
(1) の加法定理 4 本の必要十分版は `Ising2D/NecSuf/SymmetrizedAdditionFormulas.lean`、
具体版をその特殊化として得る導出は `ClaimCoshAdditionAndHalfAngleFromNecSuf.lean`。
倍角公式 `sinh_double_angle_formula`（具体版 `sinh_eq_two_sinh_half_mul_cosh_half`。人手の 4 行と 1 対 1 の `calc`）の必要十分版は
`Ising2D/NecSuf/DoubleAngleFormula.lean`、導出は同じ `ClaimCoshAdditionAndHalfAngleFromNecSuf.lean`。

## mathlib の状況（調査結果）

原文 `arcsinh(y) := log(y + √(y²+1))` は mathlib の `Real.arsinh`（綴りは `arcsinh` ではない）と
**定義が一致する**（`Real.arsinh x = log (x + √(1 + x^2))`）。
逆関数性 `Real.sinh_arsinh` / `Real.arsinh_sinh`、単調性 `Real.sinh_lt_sinh` /
`Real.sinh_le_sinh`、微分 `Real.hasDerivAt_arsinh` がすべて揃っているので自前定義は不要。
`t ≤ sinh t` も `Real.self_le_sinh_iff` にある。
mathlib に**無かった**のは `sinh t ≤ t cosh t` だけで、これは必要十分版で証明した。
-/
import Ising2D.NecSuf.HyperbolicBounds
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealNegationOfSumIsSumOfNegations
import Ising2D.MathematicalTools.SetNotationAndComplexCartesianArithmetic.ClaimRealTimesNegationIsNegationOfProduct
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimCoshIsEven
import Ising2D.MathematicalTools.RealSquareRootExponentialAndHyperbolicFunctions.ClaimSinhIsOdd

namespace Ising2D

open Real

/-- **人手 `cosh_addition_formula` の複号 `+`**: 人手の 8 行の鎖と 1 対 1 の `calc`。
人手の記号 `E_x, E_{−x}, E_y, E_{−y}` は `Real.exp x` などをそのまま書く。
`def_cosh_sinh` は Lean で定義し直しておらず、`Real.cosh_eq`・`Real.sinh_eq` が人手の定義の式の役を担う。
`scalar_exp_product` は `def_scalar_exp` の具体版が Lean に無いので mathlib の `Real.exp_add` で引く。
mathlib の `Real.cosh_add` は使わない。 -/
theorem cosh_add_formula (x y : ℝ) :
    Real.cosh (x + y) = Real.cosh x * Real.cosh y + Real.sinh x * Real.sinh y :=
  calc Real.cosh (x + y)
      = (Real.exp (x + y) + Real.exp (-(x + y))) / 2 := Real.cosh_eq (x + y)
          -- `cosh` の定義（`def_cosh_sinh`）
    _ = (Real.exp (x + y) + Real.exp ((-x) + (-y))) / 2 := by
          rw [real_negation_of_sum_is_sum_of_negations x y]
          -- `real_negation_of_sum_is_sum_of_negations`
    _ = (Real.exp x * Real.exp y + Real.exp (-x) * Real.exp (-y)) / 2 := by
          rw [Real.exp_add x y, Real.exp_add (-x) (-y)]
          -- `exp(s+t) = exp(s)exp(t)` を 2 箇所へ（`scalar_exp_product`）
    _ = (2 * (Real.exp x * Real.exp y) + 2 * (Real.exp (-x) * Real.exp (-y))) / 4 := by ring
          -- 分母と分子に `2` を掛ける
    _ = ((Real.exp x * Real.exp y + Real.exp x * Real.exp (-y)
            + Real.exp (-x) * Real.exp y + Real.exp (-x) * Real.exp (-y))
          + (Real.exp x * Real.exp y - Real.exp x * Real.exp (-y)
            - Real.exp (-x) * Real.exp y + Real.exp (-x) * Real.exp (-y))) / 4 := by ring
          -- `E_x E_{−y}` と `E_{−x} E_y` を足して引く
    _ = ((Real.exp x + Real.exp (-x)) * (Real.exp y + Real.exp (-y))
          + (Real.exp x - Real.exp (-x)) * (Real.exp y - Real.exp (-y))) / 4 := by ring
          -- 分配律
    _ = (Real.exp x + Real.exp (-x)) / 2 * ((Real.exp y + Real.exp (-y)) / 2)
          + (Real.exp x - Real.exp (-x)) / 2 * ((Real.exp y - Real.exp (-y)) / 2) := by ring
          -- 分数の和と積
    _ = Real.cosh x * Real.cosh y + Real.sinh x * Real.sinh y := by
          rw [← Real.cosh_eq x, ← Real.cosh_eq y, ← Real.sinh_eq x, ← Real.sinh_eq y]
          -- `cosh`, `sinh` の定義を 4 箇所へ（`def_cosh_sinh`）

/-- **人手 `cosh_addition_formula` の複号 `−`**: 人手の 6 行の鎖と 1 対 1 の `calc`。
`def_real_difference`（`y − z := y + (−z)`）は Lean で定義し直しておらず、mathlib の `sub_eq_add_neg` が定義の式の役を担う。 -/
theorem cosh_sub_formula (x y : ℝ) :
    Real.cosh (x - y) = Real.cosh x * Real.cosh y - Real.sinh x * Real.sinh y :=
  calc Real.cosh (x - y)
      = Real.cosh (x + (-y)) := by rw [sub_eq_add_neg x y]
          -- `def_real_difference`（`y → x`, `z → y`）
    _ = Real.cosh x * Real.cosh (-y) + Real.sinh x * Real.sinh (-y) := cosh_add_formula x (-y)
          -- 複号が `+` の場合を `−y ∈ ℝ` に当てはめる（`y → −y`）
    _ = Real.cosh x * Real.cosh y + Real.sinh x * Real.sinh (-y) := by rw [cosh_is_even y]
          -- `cosh_is_even`（`x → y`）
    _ = Real.cosh x * Real.cosh y + Real.sinh x * (-Real.sinh y) := by rw [sinh_is_odd y]
          -- `sinh_is_odd`（`x → y`）
    _ = Real.cosh x * Real.cosh y + (-(Real.sinh x * Real.sinh y)) := by
          rw [real_times_negation_is_negation_of_product (Real.sinh x) (Real.sinh y)]
          -- `real_times_negation_is_negation_of_product`（`x → sinh x`, `t → sinh y`）
    _ = Real.cosh x * Real.cosh y - Real.sinh x * Real.sinh y := by
          rw [← sub_eq_add_neg (Real.cosh x * Real.cosh y) (Real.sinh x * Real.sinh y)]
          -- `def_real_difference`（`y → cosh x·cosh y`, `z → sinh x·sinh y`）を右辺から左辺へ

/-- **人手 `sinh_addition_formula` の複号 `+`**: 人手の 8 行の鎖と 1 対 1 の `calc`。
記号と根拠の読み方は `cosh_add_formula` と同じ。mathlib の `Real.sinh_add` は使わない。 -/
theorem sinh_add_formula (x y : ℝ) :
    Real.sinh (x + y) = Real.sinh x * Real.cosh y + Real.cosh x * Real.sinh y :=
  calc Real.sinh (x + y)
      = (Real.exp (x + y) - Real.exp (-(x + y))) / 2 := Real.sinh_eq (x + y)
          -- `sinh` の定義（`def_cosh_sinh`）
    _ = (Real.exp (x + y) - Real.exp ((-x) + (-y))) / 2 := by
          rw [real_negation_of_sum_is_sum_of_negations x y]
          -- `real_negation_of_sum_is_sum_of_negations`
    _ = (Real.exp x * Real.exp y - Real.exp (-x) * Real.exp (-y)) / 2 := by
          rw [Real.exp_add x y, Real.exp_add (-x) (-y)]
          -- `exp(s+t) = exp(s)exp(t)` を 2 箇所へ（`scalar_exp_product`）
    _ = (2 * (Real.exp x * Real.exp y) - 2 * (Real.exp (-x) * Real.exp (-y))) / 4 := by ring
          -- 分母と分子に `2` を掛ける
    _ = ((Real.exp x * Real.exp y + Real.exp x * Real.exp (-y)
            - Real.exp (-x) * Real.exp y - Real.exp (-x) * Real.exp (-y))
          + (Real.exp x * Real.exp y - Real.exp x * Real.exp (-y)
            + Real.exp (-x) * Real.exp y - Real.exp (-x) * Real.exp (-y))) / 4 := by ring
          -- `E_x E_{−y}` と `E_{−x} E_y` を足して引く
    _ = ((Real.exp x - Real.exp (-x)) * (Real.exp y + Real.exp (-y))
          + (Real.exp x + Real.exp (-x)) * (Real.exp y - Real.exp (-y))) / 4 := by ring
          -- 分配律
    _ = (Real.exp x - Real.exp (-x)) / 2 * ((Real.exp y + Real.exp (-y)) / 2)
          + (Real.exp x + Real.exp (-x)) / 2 * ((Real.exp y - Real.exp (-y)) / 2) := by ring
          -- 分数の和と積
    _ = Real.sinh x * Real.cosh y + Real.cosh x * Real.sinh y := by
          rw [← Real.cosh_eq x, ← Real.cosh_eq y, ← Real.sinh_eq x, ← Real.sinh_eq y]
          -- `cosh`, `sinh` の定義を 4 箇所へ（`def_cosh_sinh`）

/-- **人手 `sinh_addition_formula` の複号 `−`**: 人手の 6 行の鎖と 1 対 1 の `calc`。
`def_real_difference`（`y − z := y + (−z)`）は Lean で定義し直しておらず、mathlib の `sub_eq_add_neg` が定義の式の役を担う。 -/
theorem sinh_sub_formula (x y : ℝ) :
    Real.sinh (x - y) = Real.sinh x * Real.cosh y - Real.cosh x * Real.sinh y :=
  calc Real.sinh (x - y)
      = Real.sinh (x + (-y)) := by rw [sub_eq_add_neg x y]
          -- `def_real_difference`（`y → x`, `z → y`）
    _ = Real.sinh x * Real.cosh (-y) + Real.cosh x * Real.sinh (-y) := sinh_add_formula x (-y)
          -- 複号が `+` の場合を `−y ∈ ℝ` に当てはめる（`y → −y`）
    _ = Real.sinh x * Real.cosh y + Real.cosh x * Real.sinh (-y) := by rw [cosh_is_even y]
          -- `cosh_is_even`（`x → y`）
    _ = Real.sinh x * Real.cosh y + Real.cosh x * (-Real.sinh y) := by rw [sinh_is_odd y]
          -- `sinh_is_odd`（`x → y`）
    _ = Real.sinh x * Real.cosh y + (-(Real.cosh x * Real.sinh y)) := by
          rw [real_times_negation_is_negation_of_product (Real.cosh x) (Real.sinh y)]
          -- `real_times_negation_is_negation_of_product`（`x → cosh x`, `t → sinh y`）
    _ = Real.sinh x * Real.cosh y - Real.cosh x * Real.sinh y := by
          rw [← sub_eq_add_neg (Real.sinh x * Real.cosh y) (Real.cosh x * Real.sinh y)]
          -- `def_real_difference`（`y → sinh x·cosh y`, `z → cosh x·sinh y`）を右辺から左辺へ

/-- 人手証明 (2): `cosh x = 1 + 2 sinh²(x/2)`。 -/
theorem cosh_eq_one_add_two_sinh_half_sq (x : ℝ) :
    Real.cosh x = 1 + 2 * Real.sinh (x / 2) ^ 2 := by
  have hcs := Real.cosh_sq (x / 2)
  have h2 := Real.cosh_two_mul (x / 2)
  rw [show 2 * (x / 2) = x by ring] at h2
  rw [h2, hcs]; ring

/-- **人手 `sinh_double_angle_formula`**: `sinh x = 2 sinh(x/2) cosh(x/2)`。人手の 4 行の鎖と 1 対 1 の `calc`。
mathlib の `Real.sinh_two_mul` は使わない。
人手の右辺 `2 sinh(x/2) cosh(x/2)` は括弧を書かないが、Lean の `2 * a * b` は `(2 * a) * b` と読まれるので、
最後の行の「同類項をまとめる」（`a b + a b = 2 (a b)`、`two_mul`）の後に、Lean にだけ乗法の結合律（`mul_assoc`）の段がある。 -/
theorem sinh_eq_two_sinh_half_mul_cosh_half (x : ℝ) :
    Real.sinh x = 2 * Real.sinh (x / 2) * Real.cosh (x / 2) :=
  calc Real.sinh x
      = Real.sinh (x / 2 + x / 2) := by rw [add_halves x]
          -- `x = x/2 + x/2`
    _ = Real.sinh (x / 2) * Real.cosh (x / 2) + Real.cosh (x / 2) * Real.sinh (x / 2) :=
          sinh_add_formula (x / 2) (x / 2)
          -- `sinh_addition_formula` の複号 `+` を `x → x/2`, `y → x/2` で
    _ = Real.sinh (x / 2) * Real.cosh (x / 2) + Real.sinh (x / 2) * Real.cosh (x / 2) := by
          rw [mul_comm (Real.cosh (x / 2)) (Real.sinh (x / 2))]
          -- `ℝ` の乗法の交換律
    _ = 2 * Real.sinh (x / 2) * Real.cosh (x / 2) := by
          rw [← two_mul, ← mul_assoc]
          -- 同類項をまとめる（`two_mul`）。続く `mul_assoc` は上の docstring の Lean にだけある段

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
