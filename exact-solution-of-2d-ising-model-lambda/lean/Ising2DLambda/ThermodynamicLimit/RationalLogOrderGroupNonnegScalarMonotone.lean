/-
人手証明「非負有理数倍は有理係数の対数順序群の順序を保つ」
（`claim_rational_log_order_group_nonneg_scalar_monotone`）の具体版。

`c = u/v`（`u := num(c) ∈ ℤ`、`v := den(c) ≥ 1`、`v·c = u`。`0 ≤ c` から `u ∈ ℕ`）。
仮定を「ある N」の形で読んで `λ_N ≤_Λ μ_N` となる両方の共通分母 `N ≥ 1` を取り、
`(vN)·(c·λ) = ((vN)c)·λ = ((vc)N)·λ = (uN)·λ = u·(N·λ) = u·ι(λ_N) = ι(uλ_N)` の六段で
`vN` が `c·λ` の共通分母（証人 `uλ_N`）であることを示し（`c·μ` も同じ）、
`u ≥ 1` なら `Λ` の順序の正整数倍不変性、`u = 0` なら反射律で `uλ_N ≤_Λ uμ_N` を得る。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder
import Ising2DLambda.FreeEntropy.LogOrderGroupPositiveMultipleInvariant

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: `N` が `λ` の共通分母（証人 `λ_N`）なら、`den(c)·N` は `c·λ` の共通分母で
証人は `num(c)·λ_N`（人手証明の六段の鎖）。 -/
theorem commonDenominator_ratSmul (c : ℚ) (N : ℕ) (l : RationalLogOrderGroup)
    (lN : LogOrderGroup) (h : IsCommonDenominator N l lN) :
    IsCommonDenominator (c.den * N) (c • l) (c.num • lN) := by
  unfold IsCommonDenominator at h ⊢
  calc
    (((c.den * N : ℕ) : ℚ)) • (c • l)
        = ((((c.den * N : ℕ) : ℚ)) * c) • l := smul_smul _ _ _                -- 有理数倍の結合則
    _ = (((c.den : ℚ) * c) * (N : ℚ)) • l := by
          rw [Nat.cast_mul, mul_comm ((c.den : ℚ)) (N : ℚ), mul_assoc,
            mul_comm (N : ℚ) ((c.den : ℚ) * c)]                              -- ℚ の積の可換性と結合則
    _ = (((c.num : ℤ) : ℚ) * (N : ℚ)) • l := by
          rw [mul_comm ((c.den : ℚ)) c, Rat.mul_den_eq_num]                    -- den(c)·c = num(c)
    _ = (((c.num : ℤ) : ℚ)) • (((N : ℚ)) • l) := (smul_smul _ _ _).symm       -- 有理数倍の結合則
    _ = (((c.num : ℤ) : ℚ)) • toRational lN := by rw [h]                      -- N は λ の共通分母
    _ = toRational (c.num • lN) := toRational_intSmul _ _                     -- ι は整数倍と交換する

/-- 証人の間の順序: `λ_N ≤_Λ μ_N` と `u ∈ ℕ` から `uλ_N ≤_Λ uμ_N`
（`u ≥ 1` は正整数倍不変性、`u = 0` は両辺が零写像で反射律）。 -/
theorem logOrderLE_natSmul_of_le (u : ℕ) {lN mN : LogOrderGroup} (h : logOrderLE lN mN) :
    logOrderLE (((u : ℤ)) • lN) (((u : ℤ)) • mN) := by
  rcases Nat.eq_zero_or_pos u with hu | hu
  · -- u = 0: 0 倍は零写像、反射律
    subst hu
    simp only [Nat.cast_zero, zero_smul]
    exact logOrderLE_refl 0
  · -- u ≥ 1: claim_log_order_group_positive_multiple_invariant
    exact (logOrderLE_natSmul_iff u hu lN mN).mp h

/-- 主張。`0 ≤ c` と `λ ≤_{Λ_ℚ} μ` から `c·λ ≤_{Λ_ℚ} c·μ`。 -/
theorem rationalLogOrderLE_ratSmul_of_nonneg {c : ℚ} (hc : 0 ≤ c)
    {l m : RationalLogOrderGroup} (h : rationalLogOrderLE l m) :
    rationalLogOrderLE (c • l) (c • m) := by
  obtain ⟨N, lN, mN, hN, hl, hm, hle⟩ := h
  -- u := num(c) ∈ ℕ
  have hnum : 0 ≤ c.num := Rat.num_nonneg.mpr hc
  obtain ⟨u, hu⟩ : ∃ u : ℕ, (u : ℤ) = c.num := ⟨c.num.toNat, Int.toNat_of_nonneg hnum⟩
  refine ⟨c.den * N, c.num • lN, c.num • mN, ?_, commonDenominator_ratSmul c N l lN hl,
    commonDenominator_ratSmul c N m mN hm, ?_⟩
  · -- vN ≥ 1
    exact Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero (Nat.pos_iff_ne_zero.mp c.den_pos) (Nat.one_le_iff_ne_zero.mp hN))
  · rw [← hu]
    exact logOrderLE_natSmul_of_le u hle

end Ising2DLambda.ThermodynamicLimit
