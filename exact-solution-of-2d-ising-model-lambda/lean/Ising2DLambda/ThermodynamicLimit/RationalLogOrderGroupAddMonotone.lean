/-
人手証明「有理係数の対数順序群の順序は加法について単調である」
（`claim_rational_log_order_group_add_monotone`）の具体版。

三元 `λ, μ, ν` に共通の共通分母 `N := N_λ N_μ N_ν`（`commonDenominator_three_exists`）を取り、
`N·(λ+ν) = N·λ + N·ν = ι(λ_N) + N·ν = ι(λ_N) + ι(ν_N) = ι(λ_N + ν_N)` の四段で
`N` が `λ+ν` の共通分母（証人 `λ_N + ν_N`）であることを示し（`μ+ν` も同じ）、仮定を
「すべての両方の共通分母で」の形（`rationalLogOrderLE_iff_forall`）で読んで `Λ` の順序の加法単調性
（`claim_log_order_group_add_monotone` = `logOrderLE_add_right`）へ落とす。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupLinearOrder
import Ising2DLambda.FreeEntropy.LogOrderGroupAddMonotone

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: `N` が `λ` の共通分母（証人 `λ_N`）で `ν` の共通分母（証人 `ν_N`）なら、
`N` は `λ+ν` の共通分母で証人は `λ_N + ν_N`（人手証明の四段の鎖）。 -/
theorem commonDenominator_add (N : ℕ) (l n : RationalLogOrderGroup) (lN nN : LogOrderGroup)
    (hl : IsCommonDenominator N l lN) (hn : IsCommonDenominator N n nN) :
    IsCommonDenominator N (l + n) (lN + nN) := by
  unfold IsCommonDenominator at hl hn ⊢
  calc
    (N : ℚ) • (l + n) = (N : ℚ) • l + (N : ℚ) • n := smul_add _ _ _   -- 有理数倍の分配則
    _ = toRational lN + (N : ℚ) • n := by rw [hl]                      -- N は λ の共通分母、証人 λ_N
    _ = toRational lN + toRational nN := by rw [hn]                    -- N は ν の共通分母、証人 ν_N
    _ = toRational (lN + nN) := (toRational_add lN nN).symm            -- ι の加法性

/-- 加法単調性。三元の共通の共通分母 `N` で ∀ 形に読み、`Λ` の加法単調性へ落とす。 -/
theorem rationalLogOrderLE_add_right {l m : RationalLogOrderGroup} (h : rationalLogOrderLE l m)
    (n : RationalLogOrderGroup) : rationalLogOrderLE (l + n) (m + n) := by
  obtain ⟨N, lN, mN, nN, hN, hl, hm, hn⟩ := commonDenominator_three_exists l m n
  have e : logOrderLE lN mN := (rationalLogOrderLE_iff_forall l m).mp h N lN mN hN hl hm
  exact ⟨N, lN + nN, mN + nN, hN, commonDenominator_add N l n lN nN hl hn,
    commonDenominator_add N m n mN nN hm hn, logOrderLE_add_right e nN⟩

end Ising2DLambda.ThermodynamicLimit
