/-
# `cosh`・`sinh` の基本性質 (1)・(3)（**具体版**）

人手証明（正本は `structured-latex/content/003_exp_linear_map.ts`）:
- `calc_formulae_000b_claim_cosh_sinh_basic_properties`（ラベル **`cosh_sinh_basic_properties`**）

このファイルは主張の (1) と (3) を置く。(2) `(cosh x)^2 − (sinh x)^2 = 1` と (4) `a^2 = b^2 ⟺ a = b` は置いていない
（状態台帳に残してある）。

| 人手の行 | Lean |
| --- | --- |
| (1) の 1 本目の 4 行の鎖 `cosh x − sinh x = … = exp(−x)` | `cosh_sub_sinh_eq_exp_neg`（同じ行の calc） |
| (1) の 2 本目の 4 行の鎖 `cosh x + sinh x = … = exp(x)` | `cosh_add_sinh_eq_exp`（同じ行の calc） |
| (1) の 3 本目の 2 行の鎖 `cosh x − sinh x = exp(−x) > 0` | `cosh_sub_sinh_pos`（同じ行の calc） |
| (1) の含意 `cosh x − sinh x > 0 ⟹ cosh x > sinh x` | `real_cosh_gt_sinh` |
| (1) の 4 本目の 3 行の鎖 `2cosh x = … > 0` | `two_cosh_pos`（同じ行の calc） |
| (1) の含意 `2cosh x > 0 ⟹ cosh x > 0` | `cosh_pos_of_two_cosh_pos` |
| (3) の含意 `x > 0 ⟹ −x < 0`・`x > 0 ⟹ 0 < x` | `real_neg_lt_zero_of_pos` と `real_one_lt_exp` の `h0x` |
| (3) の 2 本の鎖 `exp(−x) < exp(0) = 1`・`1 = exp(0) < exp(x)` | `real_exp_neg_lt_one`・`real_one_lt_exp`（同じ行の calc） |
| (3) の含意の 2 行 `exp(−x) < 1 < exp(x) ⟹ exp(−x) < exp(x) ⟹ exp(x) − exp(−x) > 0` | `real_exp_sub_exp_neg_pos` |
| (3) の 2 行の鎖 `sinh x = (exp(x) − exp(−x))/2 > 0` | `real_sinh_pos_of_pos`（同じ行の calc） |
| (3) の結び `cosh x > sinh x ∧ sinh x > 0 ⟹ cosh x > sinh x > 0` | `cosh_sinh_basic_properties_3` |

人手の `cosh`・`sinh`（`def_cosh_sinh`）は Lean で定義し直していない。mathlib の `Real.cosh`・`Real.sinh` の等式
`Real.cosh_eq`・`Real.sinh_eq` が、人手の定義の式そのものとしてその役を担う。人手が引く `real_exp_positive` は具体版
`Ising2D.real_exp_positive`、`scalar_exp_zero`（`K → ℝ`）は mathlib の `Real.exp_zero`、`real_exp_strictly_increasing` は
Lean の具体版が無いので mathlib の `Real.exp_lt_exp` で受ける。

人手の主張 (1) は `cosh x + sinh x = exp(x) > 0` も述べるが、人手の証明に `exp(x) > 0` の行は無い（`real_exp_positive` の
`x → x` そのもの）。`cosh_sinh_basic_properties_1` はその欄を `real_exp_positive x` で埋める。

必要十分版は `Ising2D/NecSuf/HyperbolicBasicPropertiesFromMonotoneMap.lean`、具体版をその特殊化として得る導出は
`ClaimCoshSinhBasicPropertiesFromNecSuf.lean`。
-/
import Ising2D.MathematicalTools.MatrixExponentialAndCommutators.ClaimRealExpPositive

namespace Ising2D

/-- **人手 `cosh_sinh_basic_properties` (1) の 1 本目の鎖**: `cosh x − sinh x = exp(−x)`。 -/
theorem cosh_sub_sinh_eq_exp_neg (x : ℝ) : Real.cosh x - Real.sinh x = Real.exp (-x) :=
  calc Real.cosh x - Real.sinh x
      = (Real.exp x + Real.exp (-x)) / 2 - (Real.exp x - Real.exp (-x)) / 2 := by
        rw [Real.cosh_eq, Real.sinh_eq]                 -- `cosh`・`sinh` の定義
    _ = ((Real.exp x + Real.exp (-x)) - (Real.exp x - Real.exp (-x))) / 2 :=
        div_sub_div_same _ _ _                          -- 分母の等しい分数の差
    _ = (2 * Real.exp (-x)) / 2 := by
        congr 1; rw [two_mul]; abel                     -- 分子の整理
    _ = Real.exp (-x) :=
        by rw [two_mul, ← mul_two]; exact mul_div_cancel_right₀ _ two_ne_zero
                                                        -- 約分（`2b = b + b = b·2` と直してから約分するので、乗法の可換則は使わない）

/-- **人手 `cosh_sinh_basic_properties` (1) の 2 本目の鎖**: `cosh x + sinh x = exp(x)`。 -/
theorem cosh_add_sinh_eq_exp (x : ℝ) : Real.cosh x + Real.sinh x = Real.exp x :=
  calc Real.cosh x + Real.sinh x
      = (Real.exp x + Real.exp (-x)) / 2 + (Real.exp x - Real.exp (-x)) / 2 := by
        rw [Real.cosh_eq, Real.sinh_eq]                 -- `cosh`・`sinh` の定義
    _ = ((Real.exp x + Real.exp (-x)) + (Real.exp x - Real.exp (-x))) / 2 :=
        (add_div _ _ _).symm                            -- 分母の等しい分数の和
    _ = (2 * Real.exp x) / 2 := by
        congr 1; rw [two_mul]; abel                     -- 分子の整理
    _ = Real.exp x :=
        by rw [two_mul, ← mul_two]; exact mul_div_cancel_right₀ _ two_ne_zero
                                                        -- 約分（`2b = b + b = b·2` と直してから約分するので、乗法の可換則は使わない）

/-- **人手 `cosh_sinh_basic_properties` (1) の 3 本目の鎖**: `cosh x − sinh x = exp(−x) > 0`。 -/
theorem cosh_sub_sinh_pos (x : ℝ) : Real.cosh x - Real.sinh x > 0 :=
  calc Real.cosh x - Real.sinh x
      = Real.exp (-x) := cosh_sub_sinh_eq_exp_neg x     -- 上の第 1 式
    _ > 0 := real_exp_positive (-x)                     -- `exp` の正値性（`real_exp_positive`）

/-- **人手 `cosh_sinh_basic_properties` (1) の含意**: `cosh x − sinh x > 0 ⟹ cosh x > sinh x`。 -/
theorem real_cosh_gt_sinh (x : ℝ) : Real.cosh x > Real.sinh x := by
  have h : 0 + Real.sinh x < (Real.cosh x - Real.sinh x) + Real.sinh x :=
    add_lt_add_left (cosh_sub_sinh_pos x) (Real.sinh x)  -- 両辺に `sinh x` を加える
  rwa [zero_add, sub_add_cancel] at h

/-- **人手 `cosh_sinh_basic_properties` (1) の 4 本目の鎖**: `2cosh x = (cosh x − sinh x) + (cosh x + sinh x)
= exp(−x) + exp(x) > 0`。 -/
theorem two_cosh_pos (x : ℝ) : 2 * Real.cosh x > 0 :=
  calc 2 * Real.cosh x
      = (Real.cosh x - Real.sinh x) + (Real.cosh x + Real.sinh x) := by
        rw [two_mul]; abel                              -- 右辺の整理
    _ = Real.exp (-x) + Real.exp x := by
        rw [cosh_sub_sinh_eq_exp_neg, cosh_add_sinh_eq_exp]
                                                        -- 上の 2 式
    _ > 0 := add_pos (real_exp_positive (-x)) (real_exp_positive x)
                                                        -- `exp` の正値性（`real_exp_positive`）

/-- **人手 `cosh_sinh_basic_properties` (1) の含意**: `2cosh x > 0 ⟹ cosh x > 0`。 -/
theorem cosh_pos_of_two_cosh_pos (x : ℝ) : Real.cosh x > 0 :=
  (mul_pos_iff_of_pos_left two_pos).mp (two_cosh_pos x) -- 両辺を `2 > 0` で割る

/-- **人手 `cosh_sinh_basic_properties` (1)**: `cosh x − sinh x = exp(−x) > 0` かつ `cosh x + sinh x = exp(x) > 0`。
特に `cosh x > 0` かつ `cosh x > sinh x`。 -/
theorem cosh_sinh_basic_properties_1 (x : ℝ) :
    (Real.cosh x - Real.sinh x = Real.exp (-x) ∧ Real.exp (-x) > 0) ∧
    (Real.cosh x + Real.sinh x = Real.exp x ∧ Real.exp x > 0) ∧
    Real.cosh x > 0 ∧ Real.cosh x > Real.sinh x :=
  ⟨⟨cosh_sub_sinh_eq_exp_neg x, real_exp_positive (-x)⟩,
    ⟨cosh_add_sinh_eq_exp x, real_exp_positive x⟩,
    cosh_pos_of_two_cosh_pos x, real_cosh_gt_sinh x⟩

/-- **人手 `cosh_sinh_basic_properties` (3) の 1 行目**: `x > 0 ⟹ −x < 0`。 -/
theorem real_neg_lt_zero_of_pos {x : ℝ} (hx : x > 0) : -x < 0 := by
  have h : (-1) * x < (-1) * 0 := mul_lt_mul_of_neg_left hx (by norm_num)
                                                        -- 両辺に `−1 < 0` を掛けると不等号の向きが反転する
  rwa [neg_one_mul, mul_zero] at h

/-- **人手 `cosh_sinh_basic_properties` (3) の 1 本目の鎖**: `exp(−x) < exp(0) = 1`。 -/
theorem real_exp_neg_lt_one {x : ℝ} (hx : x > 0) : Real.exp (-x) < 1 :=
  calc Real.exp (-x)
      < Real.exp 0 := Real.exp_lt_exp.mpr (real_neg_lt_zero_of_pos hx)
                                                        -- `−x < 0` と `real_exp_strictly_increasing`
    _ = 1 := Real.exp_zero                              -- `scalar_exp_zero`

/-- **人手 `cosh_sinh_basic_properties` (3) の 2 本目の鎖**: `1 = exp(0) < exp(x)`。 -/
theorem real_one_lt_exp {x : ℝ} (hx : x > 0) : 1 < Real.exp x :=
  have h0x : 0 < x := hx                                -- 同じ不等式の左右を入れ替える
  calc (1 : ℝ)
      = Real.exp 0 := Real.exp_zero.symm                -- `scalar_exp_zero`
    _ < Real.exp x := Real.exp_lt_exp.mpr h0x           -- `0 < x` と `real_exp_strictly_increasing`

/-- **人手 `cosh_sinh_basic_properties` (3) の含意の 2 行**:
`exp(−x) < 1 < exp(x) ⟹ exp(−x) < exp(x) ⟹ exp(x) − exp(−x) > 0`。 -/
theorem real_exp_sub_exp_neg_pos {x : ℝ} (hx : x > 0) : Real.exp x - Real.exp (-x) > 0 := by
  have h1 : Real.exp (-x) < Real.exp x := lt_trans (real_exp_neg_lt_one hx) (real_one_lt_exp hx)
                                                        -- ℝ の順序の推移律
  have h2 : Real.exp (-x) + -Real.exp (-x) < Real.exp x + -Real.exp (-x) :=
    add_lt_add_left h1 (-Real.exp (-x))                -- 両辺に `−exp(−x)` を加える
  rwa [add_neg_cancel, ← sub_eq_add_neg] at h2

/-- **人手 `cosh_sinh_basic_properties` (3) の鎖**: `sinh x = (exp(x) − exp(−x))/2 > 0`。 -/
theorem real_sinh_pos_of_pos {x : ℝ} (hx : x > 0) : Real.sinh x > 0 :=
  calc Real.sinh x
      = (Real.exp x - Real.exp (-x)) / 2 := Real.sinh_eq x
                                                        -- `sinh` の定義
    _ > 0 := div_pos (real_exp_sub_exp_neg_pos hx) two_pos   -- 正の実数を `2 > 0` で割った値は正

/-- **人手 `cosh_sinh_basic_properties` (3)**: `x > 0` ならば `cosh x > sinh x > 0`。 -/
theorem cosh_sinh_basic_properties_3 {x : ℝ} (hx : x > 0) :
    Real.cosh x > Real.sinh x ∧ Real.sinh x > 0 :=
  ⟨real_cosh_gt_sinh x, real_sinh_pos_of_pos hx⟩                  -- (1) と直前の不等式

end Ising2D
