/-
章「熱力学極限」の「対数順序群の元の実現は rat_Λ の実対数である（実数体への脱出: 実対数）」
（`claim_log_order_group_realization_real_log`）の具体版。

  人手証明                                                                  このファイル
  準備: 有限積の実対数は実対数の和（台の大きさ、すなわち有限集合の元の個数の帰納法。
        空積は 1 で log_ℝ(1) = 0、S ∪ {p} では乗法を加法へ移し帰納法の仮定）      `realLog_prod`
  一続きの鎖 ρ_ℝ(ι_{Λ→Λ_ℚ}(λ)) = … = log_ℝ(ι_{ℚ→ℝ}(rat_Λ(λ)))                  `realizeRational_toRational`
    定義（台に渡る和）                                                        `realizeRational_eq_sum_support`
    supp(ι(λ)) = supp(λ)                                                      `Finsupp.support_mapRange_of_injective`
    ι(λ)(p) = λ(p)/1                                                          `toRational_apply`
    整数冪の実対数は整数倍（u := ι(p)、k := λ(p)）                            `realLog_zpow`
    ι_{ℚ→ℝ} は整数冪を保つ                                                    `Rat.cast_zpow`
    準備（有限積の実対数は和）                                                `realLog_prod`
    ι_{ℚ→ℝ} は有限積を保つ                                                    `Rat.cast_prod`
    rat_Λ の定義（台に渡る積）                                                `rationalOfLog` の定義そのもの
実対数について使うのは `realLog_mul`（乗法を加法へ移す）と、それから出した `realLog_one`・`realLog_zpow` だけである。
`Real.log_prod`・`Real.log_zpow` は使わない（人手証明の手順と 1 対 1 にするため）。
-/
import Ising2DLambda.ThermodynamicLimit.RealLogarithmIntPower
import Ising2DLambda.FreeEntropy.RationalLogSurjective

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- 正の実数の等式は、その実対数の等式を与える（下付きの正値性の証明は値に影響しない）。 -/
theorem realLog_congr {a b : ℝ} (ha : 0 < a) (hb : 0 < b) (h : a = b) :
    realLog ⟨a, ha⟩ = realLog ⟨b, hb⟩ := by
  subst h; rfl

/-- 準備: 有限積の実対数は実対数の和。有限集合 `S` の元の個数についての帰納法。 -/
theorem realLog_prod {α : Type*} [DecidableEq α] (S : Finset α) (u : α → PositiveReal) :
    realLog ⟨∏ p ∈ S, (u p).1, Finset.prod_pos fun p _ => (u p).2⟩ = ∑ p ∈ S, realLog (u p) := by
  induction S using Finset.induction_on with
  | empty =>
      -- 空積は 1、log_ℝ(1) = 0、空和は 0
      rw [Finset.sum_empty]
      rw [realLog_congr _ one_pos Finset.prod_empty]
      exact realLog_one
  | insert p S hp ih =>
      -- S ∪ {p} の積は u_p·(S の積)。乗法を加法へ移し、帰納法の仮定
      rw [Finset.sum_insert hp]
      rw [realLog_congr _ (mul_pos (u p).2 (Finset.prod_pos fun q _ => (u q).2)) (Finset.prod_insert hp)]
      rw [realLog_mul (u p) ⟨∏ q ∈ S, (u q).1, Finset.prod_pos fun q _ => (u q).2⟩]
      rw [ih]

/-- 素数 `p` の整数冪 `p^k ∈ ℚ_{>0}`（`ℚ` の中の冪）は正である。 -/
theorem prime_zpow_pos (p : Nat.Primes) (k : ℤ) : (0 : ℚ) < (p.1 : ℚ) ^ k :=
  zpow_pos (Nat.cast_pos.mpr p.property.pos) k

/-- `p^k ∈ ℚ_{>0}` を `ι_{ℚ→ℝ}` で読んだ正の実数。 -/
noncomputable def primeZpowPositiveReal (p : Nat.Primes) (k : ℤ) : PositiveReal :=
  ⟨(((p.1 : ℚ) ^ k : ℚ) : ℝ), Rat.cast_pos.mpr (prime_zpow_pos p k)⟩

/-- `rat_Λ(λ) ∈ ℚ_{>0}` を `ι_{ℚ→ℝ}` で読んだ正の実数。 -/
noncomputable def rationalOfLogPositiveReal (l : LogOrderGroup) : PositiveReal :=
  ⟨((rationalOfLog l : ℚ) : ℝ), Rat.cast_pos.mpr (rationalOfLog_pos l)⟩

/-- `claim_log_order_group_realization_real_log`:
`ρ_ℝ(ι_{Λ→Λ_ℚ}(λ)) = log_ℝ(ι_{ℚ→ℝ}(rat_Λ(λ)))`。 -/
theorem realizeRational_toRational (l : LogOrderGroup) :
    realizeRational (toRational l) = realLog (rationalOfLogPositiveReal l) := by
  classical
  calc
    realizeRational (toRational l)
        = ∑ p ∈ (toRational l).support,
            (((toRational l) p : ℚ) : ℝ) * realLog (primePositiveReal p) :=
          realizeRational_eq_sum_support _                                  -- 定義（台に渡る和）
    _ = ∑ p ∈ l.support, (((toRational l) p : ℚ) : ℝ) * realLog (primePositiveReal p) := by
          rw [toRational, Finsupp.support_mapRange_of_injective (by simp) l Int.cast_injective]
                                                                            -- supp(ι(λ)) = supp(λ)
    _ = ∑ p ∈ l.support, (((l p : ℤ) : ℚ) : ℝ) * realLog (primePositiveReal p) := by
          simp only [toRational_apply]                                      -- ι(λ)(p) = λ(p)/1
    _ = ∑ p ∈ l.support,
          realLog ⟨(primePositiveReal p).1 ^ (l p), zpow_pos (primePositiveReal p).2 _⟩ := by
          simp only [realLog_zpow]                                          -- 整数冪の実対数は整数倍
    _ = ∑ p ∈ l.support, realLog (primeZpowPositiveReal p (l p)) := by
          refine Finset.sum_congr rfl fun p _ => ?_
          exact realLog_congr _ _ (Rat.cast_zpow _ _).symm                  -- ι は整数冪を保つ
    _ = realLog ⟨∏ p ∈ l.support, (primeZpowPositiveReal p (l p)).1,
            Finset.prod_pos fun p _ => (primeZpowPositiveReal p (l p)).2⟩ := by
          rw [realLog_prod l.support (fun p => primeZpowPositiveReal p (l p))]
                                                                            -- 準備: 有限積の実対数は和
    _ = realLog ⟨(((∏ p ∈ l.support, (p.1 : ℚ) ^ (l p) : ℚ)) : ℝ),
            Rat.cast_pos.mpr (Finset.prod_pos fun p _ => prime_zpow_pos p (l p))⟩ := by
          exact realLog_congr _ _ (Rat.cast_prod _ _).symm                  -- ι は有限積を保つ
    _ = realLog (rationalOfLogPositiveReal l) := rfl                        -- rat_Λ の定義（台に渡る積）

end Ising2DLambda.ThermodynamicLimit
