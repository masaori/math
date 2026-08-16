/-
「整数冪の実対数は整数倍である」の具体版を、必要十分版 `map_zpow_necSuf` の特殊化として導く。
渡すのは `G := {t : ℝ // 0 < t}`（正の実数の乗法群。mathlib の `Positive` の群構造。
`ℝ_{>0}` の定義 `PositiveReal` はこの型そのもの）、`A := ℝ`、`f := log_ℝ`（`realLog`）、
乗法を加法へ移すこと（`realLog_mul`）だけである。整数冪 `u^k` の値は `(u.1)^k` と `rfl` で一致し
（`Positive.coe_zpow`）、`k • x = ι(k)·x` は `zsmul_eq_mul`・`Rat.cast_intCast`。
-/
import Mathlib.Algebra.Order.Positive.Field
import Ising2DLambda.ThermodynamicLimit.RealLogarithmIntPower
import Ising2DLambda.NecSuf.ThermodynamicLimit.RealLogarithmIntPower

namespace Ising2DLambda.ThermodynamicLimit

/-- `log_ℝ` を正の実数の乗法群 `{t : ℝ // 0 < t}` 上の写像として読んだもの（`PositiveReal` と同じ型）。 -/
noncomputable def realLogOnPositive (u : {t : ℝ // 0 < t}) : ℝ := realLog u

theorem realLogOnPositive_mul (u v : {t : ℝ // 0 < t}) :
    realLogOnPositive (u * v) = realLogOnPositive u + realLogOnPositive v :=
  realLog_mul u v

theorem realLog_zpow_from_necSuf (u : PositiveReal) (k : ℤ) :
    realLog ⟨u.1 ^ k, zpow_pos u.2 k⟩ = ((k : ℚ) : ℝ) * realLog u := by
  have h := NecSuf.ThermodynamicLimit.map_zpow_necSuf realLogOnPositive realLogOnPositive_mul
    (u : {t : ℝ // 0 < t}) k
  -- 左辺: (u^k).1 = u.1^k は rfl（Positive.coe_zpow）。右辺: k • x = (k:ℝ)·x、ι(k) = (k:ℝ)
  change realLog ⟨u.1 ^ k, _⟩ = k • realLog u at h
  rw [Rat.cast_intCast, ← zsmul_eq_mul]
  exact h

end Ising2DLambda.ThermodynamicLimit
