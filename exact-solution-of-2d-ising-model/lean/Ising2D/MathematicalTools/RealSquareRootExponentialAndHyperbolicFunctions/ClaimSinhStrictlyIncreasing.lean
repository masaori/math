/-
# `sinh` は狭義単調増加

人手証明（正本は `structured-latex/content/020_critical_point.ts`）:
- `critical_claim_sinh_strictly_increasing`（ラベル `sinh_strictly_increasing`）

**具体版**（人手証明と同じ抽象度＝実数の `exp`・`sinh`）。人手の証明は準備の 2 本の鎖、
3 本の含意、`sinh y − sinh x` の 4 行の鎖、最後の含意からなり、下の `have` と `calc` がその順に 1 対 1 で対応する。

- `def_cosh_sinh` は Lean で定義し直しておらず、`Real.sinh_eq` が人手の定義の式の役を担う。
- `real_exp_strictly_increasing` の Lean の具体版は無いので、mathlib の `Real.exp_lt_exp` で引く。
- mathlib の `Real.sinh_lt_sinh`・`Real.sinh_le_sinh`・`Real.sinh_strictMono` は使わない。

人手の本文は、この主張を「`a ≤ b` と `sinh_strictly_increasing`（等号のときは等しい）」の形でも引く
（`critical_point_and_log_divergence.ts` の `kappa_of_K_basic` (4) など）。その読み方を `sinh_le_sinh_of_le` に置いた。

必要十分版は `Ising2D/NecSuf/OddPartStrictlyIncreasing.lean`、具体版をその特殊化として得る導出は
同じフォルダの `ClaimSinhStrictlyIncreasingFromNecSuf.lean`。
-/
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv

namespace Ising2D

/-- **人手 `sinh_strictly_increasing` の準備の 2 本目の鎖の 1 行目**: `x < y ⟹ −y < −x`。 -/
theorem real_neg_lt_neg_of_lt {x y : ℝ} (h : x < y) : -y < -x := by
  have h1 : (-1) * y < (-1) * x := mul_lt_mul_of_neg_left h (by norm_num)
                                                        -- 両辺に `−1 < 0` を掛けると不等号の向きが反転する
  rwa [neg_one_mul, neg_one_mul] at h1

/-- **人手 `sinh_strictly_increasing`**: `x < y` ならば `sinh x < sinh y`。 -/
theorem sinh_strictly_increasing {x y : ℝ} (h : x < y) : Real.sinh x < Real.sinh y := by
  -- 準備の 1 本目の鎖
  have hE : Real.exp x < Real.exp y := Real.exp_lt_exp.mpr h
                                                        -- `real_exp_strictly_increasing`
  -- 準備の 2 本目の鎖
  have hN : -y < -x := real_neg_lt_neg_of_lt h          -- 両辺に `−1 < 0` を掛ける
  have hEN : Real.exp (-y) < Real.exp (-x) := Real.exp_lt_exp.mpr hN
                                                        -- `real_exp_strictly_increasing`
  -- 3 本の含意
  have h1 : Real.exp y - Real.exp x > 0 := by
    have h' : Real.exp x + -Real.exp x < Real.exp y + -Real.exp x :=
      add_lt_add_left hE (-Real.exp x)                  -- 両辺に `−exp(x)` を加える
    rwa [add_neg_cancel, ← sub_eq_add_neg] at h'
  have h2 : Real.exp (-x) - Real.exp (-y) > 0 := by
    have h' : Real.exp (-y) + -Real.exp (-y) < Real.exp (-x) + -Real.exp (-y) :=
      add_lt_add_left hEN (-Real.exp (-y))              -- 両辺に `−exp(−y)` を加える
    rwa [add_neg_cancel, ← sub_eq_add_neg] at h'
  have h3 : (Real.exp y - Real.exp x) + (Real.exp (-x) - Real.exp (-y)) > 0 := add_pos h1 h2
                                                        -- 正の実数の和は正
  -- `sinh y − sinh x` の鎖
  have hd : Real.sinh y - Real.sinh x > 0 :=
    calc Real.sinh y - Real.sinh x
        = (Real.exp y - Real.exp (-y)) / 2 - (Real.exp x - Real.exp (-x)) / 2 := by
          rw [Real.sinh_eq y, Real.sinh_eq x]            -- `sinh` の定義を 2 箇所へ（`def_cosh_sinh`）
      _ = ((Real.exp y - Real.exp (-y)) - (Real.exp x - Real.exp (-x))) / 2 := (sub_div _ _ _).symm
                                                        -- 分母の等しい分数の差
      _ = ((Real.exp y - Real.exp x) + (Real.exp (-x) - Real.exp (-y))) / 2 := by congr 1; ring
                                                        -- 分子の項の並べ替え
      _ > 0 := div_pos h3 two_pos                       -- 上の分子の正値性と、正の数を `2 > 0` で割ると正
  -- 最後の含意
  have h4 : 0 + Real.sinh x < (Real.sinh y - Real.sinh x) + Real.sinh x :=
    add_lt_add_left hd (Real.sinh x)                    -- 両辺に `sinh x` を加える
  rwa [zero_add, sub_add_cancel] at h4

/-- 人手の「`x ≤ y` と `sinh_strictly_increasing`（等号のときは等しい）」の読み方:
`x ≤ y` ならば `sinh x ≤ sinh y`。`x < y` なら `sinh_strictly_increasing`、`x = y` なら等号で出す。 -/
theorem sinh_le_sinh_of_le {x y : ℝ} (h : x ≤ y) : Real.sinh x ≤ Real.sinh y := by
  rcases lt_or_eq_of_le h with hlt | heq
  · exact le_of_lt (sinh_strictly_increasing hlt)       -- `x < y`: `sinh_strictly_increasing`
  · rw [heq]                                            -- `x = y`: 等号のときは等しい

end Ising2D
