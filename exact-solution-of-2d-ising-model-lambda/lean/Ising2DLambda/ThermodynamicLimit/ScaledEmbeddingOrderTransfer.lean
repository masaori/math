/-
人手証明「有理数倍と埋め込みを通した順序の移送」（`claim_scaled_embedding_order_transfer`）の具体版。

`L ≥ 1`、`λ, μ ∈ Λ` について
`(1/L^2)·ι(λ) ≤_{Λ_ℚ} (1/L^2)·ι(μ) ⟺ λ ≤_Λ μ`。
準備: `N := L^2` は `(1/L^2)·ι(λ)` の共通分母で証人は `λ` 自身
（`L^2·((1/L^2)·ι(λ)) = (L^2·(1/L^2))·ι(λ) = 1·ι(λ) = ι(λ)` の三段。有理数倍の結合則・ℚ の約分・`1·λ=λ`）。
→ は順序の定義の ∀ 形（`rationalLogOrderLE_iff_forall`）を `N = L^2` で読む。
← は順序の定義の ∃ 形に `N = L^2` と証人 `λ, μ` を入れる。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupOrder

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 準備: `N = L^2` は `(1/L^2)·ι(λ)` の共通分母で、その証人は `λ` 自身である（三段の鎖）。 -/
theorem commonDenominator_scaled_toRational (L : ℕ) [NeZero L] (l : LogOrderGroup) :
    IsCommonDenominator (L ^ 2) (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l) l := by
  unfold IsCommonDenominator
  have hL : ((L : ℚ) ^ 2) ≠ 0 := pow_ne_zero 2 (by exact_mod_cast (NeZero.ne L))
  calc
    (((L ^ 2 : ℕ) : ℚ)) • (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
        = ((((L ^ 2 : ℕ) : ℚ)) * ((1 : ℚ) / ((L : ℚ) ^ 2))) • toRational l :=
          smul_smul _ _ _                                        -- 有理数倍の結合則
    _ = (1 : ℚ) • toRational l := by
          rw [Nat.cast_pow, mul_one_div_cancel hL]               -- L^2 ≠ 0、ℚ の約分
    _ = toRational l := one_smul _ _                              -- 1·λ = λ

/-- `claim_scaled_embedding_order_transfer`。 -/
theorem rationalLogOrderLE_scaled_toRational_iff (L : ℕ) [NeZero L] (l m : LogOrderGroup) :
    rationalLogOrderLE (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational l)
        (((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational m) ↔ logOrderLE l m := by
  have hN : 1 ≤ L ^ 2 :=
    Nat.one_le_iff_ne_zero.mpr (pow_ne_zero 2 (NeZero.ne L))
  constructor
  · -- → : 順序の定義の ∀ 形を N = L^2 で読む（証人は λ, μ）
    intro h
    exact (rationalLogOrderLE_iff_forall _ _).mp h (L ^ 2) l m hN
      (commonDenominator_scaled_toRational L l) (commonDenominator_scaled_toRational L m)
  · -- ← : 順序の定義の ∃ 形に N = L^2 と証人 λ, μ を入れる
    intro h
    exact ⟨L ^ 2, l, m, hN, commonDenominator_scaled_toRational L l,
      commonDenominator_scaled_toRational L m, h⟩

end Ising2DLambda.ThermodynamicLimit
