/-
人手証明「有理係数の対数順序群の逆元は順序を反転する」
（`claim_rational_log_order_group_neg_reverses_order`）の具体版。

`λ ≤_{Λ_ℚ} μ` の両辺に `ν := (−λ) + (−μ)` を加法単調性（`rationalLogOrderLE_add_right`）で足し、
左辺を `λ + ((−λ) + (−μ)) = (λ + (−λ)) + (−μ) = 0 + (−μ) = −μ`（結合則・逆元・単位元）、
右辺を `μ + ((−λ) + (−μ)) = μ + ((−μ) + (−λ)) = (μ + (−μ)) + (−λ) = 0 + (−λ) = −λ`
（交換則・結合則・逆元・単位元）と整える。順序の定義の中身（共通分母）にも有理数倍にも触れない。
住処は ℕ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

/-- 逆元は順序を反転する: `λ ≤ μ` ならば `−μ ≤ −λ`。 -/
theorem rationalLogOrderLE_neg_le_neg {l m : RationalLogOrderGroup}
    (h : rationalLogOrderLE l m) : rationalLogOrderLE (-m) (-l) := by
  -- 両辺に ν := (−λ) + (−μ) を足す（加法単調性）
  have h' := rationalLogOrderLE_add_right h (-l + -m)
  -- 左辺の三段: 結合則 → 逆元 → 単位元
  have hl : l + (-l + -m) = -m := by
    rw [← add_assoc, add_neg_cancel, zero_add]
  -- 右辺の四段: 交換則 → 結合則 → 逆元 → 単位元
  have hr : m + (-l + -m) = -l := by
    rw [add_comm (-l) (-m), ← add_assoc, add_neg_cancel, zero_add]
  rwa [hl, hr] at h'

end Ising2DLambda.ThermodynamicLimit
