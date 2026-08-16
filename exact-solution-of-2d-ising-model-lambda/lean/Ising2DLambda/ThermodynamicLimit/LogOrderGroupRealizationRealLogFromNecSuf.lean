/-
「対数順序群の元の実現は rat_Λ の実対数である」の具体版を、必要十分版 `realize_int_prod_necSuf` の
特殊化として導く。渡すのは `G := {t : ℝ // 0 < t}`（正の実数の乗法群。mathlib の `Positive` の
可換群構造。`ℝ_{>0}` の定義 `PositiveReal` はこの型そのもの）、`A := ℝ`、`f := log_ℝ`（`realLog`）、
乗法を加法へ移すこと（`realLog_mul`）、重み `w p := ι_{ℚ→ℝ}(p)`、`l := λ` である。
残る読み替えは具体側の事情だけである: `supp(ι_{Λ→Λ_ℚ}(λ)) = supp(λ)`・`ι(λ)(p) = λ(p)/1`・
`ι_{ℚ→ℝ}(k)·x = k • x`（左辺の準備）、`{t // 0 < t}` の有限積・整数冪の値は `ℝ` の有限積・整数冪
（`Positive.coe_zpow` は `rfl`）、`ι_{ℚ→ℝ}` が整数冪・有限積を保つこと（`Rat.cast_zpow`・`Rat.cast_prod`）、
`rat_Λ` の定義（右辺の読み替え）。
-/
import Mathlib.Algebra.Order.Positive.Field
import Ising2DLambda.ThermodynamicLimit.LogOrderGroupRealizationRealLog
import Ising2DLambda.ThermodynamicLimit.RealLogarithmIntPowerFromNecSuf
import Ising2DLambda.NecSuf.ThermodynamicLimit.LogOrderGroupRealizationRealLog

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `{t : ℝ // 0 < t}` の有限積の値は `ℝ` の有限積（元の個数の帰納法。各段は定義そのもの）。 -/
theorem positive_val_prod {α : Type*} [DecidableEq α] (S : Finset α) (u : α → {t : ℝ // 0 < t}) :
    (∏ p ∈ S, u p).1 = ∏ p ∈ S, (u p).1 := by
  induction S using Finset.induction_on with
  | empty => rfl
  | insert p S hp ih =>
      rw [Finset.prod_insert hp, Finset.prod_insert hp]
      change (u p).1 * (∏ q ∈ S, u q).1 = _
      rw [ih]

/-- `ι_{ℚ→ℝ}(p)` を正の実数の乗法群 `{t : ℝ // 0 < t}` の元として読んだもの（`primePositiveReal p` と同じ値）。 -/
def primePos (p : Nat.Primes) : {t : ℝ // 0 < t} := primePositiveReal p

theorem realizeRational_toRational_from_necSuf (l : LogOrderGroup) :
    realizeRational (toRational l) = realLog (rationalOfLogPositiveReal l) := by
  classical
  have h := NecSuf.ThermodynamicLimit.realize_int_prod_necSuf realLogOnPositive realLogOnPositive_mul
    primePos l
  -- 左辺の準備: supp(ι(λ)) = supp(λ)、ι(λ)(p) = λ(p)/1、ι_{ℚ→ℝ}(k)·x = k • x
  have hL : realizeRational (toRational l) = ∑ p ∈ l.support, (l p) • realLog (primePositiveReal p) := by
    rw [realizeRational_eq_sum_support, toRational,
      Finsupp.support_mapRange_of_injective (by simp) l Int.cast_injective]
    refine Finset.sum_congr rfl fun p _ => ?_
    rw [← toRational, toRational_apply, Rat.cast_intCast, zsmul_eq_mul]
  -- 右辺の読み替え: {t // 0 < t} の有限積・整数冪の値、ι が整数冪・有限積を保つこと、rat_Λ の定義
  have hR : realLogOnPositive (∏ p ∈ l.support, primePos p ^ (l p))
      = realLog (rationalOfLogPositiveReal l) := by
    refine congrArg realLog (Subtype.ext ?_)
    change (∏ p ∈ l.support, primePos p ^ (l p)).1 = ((rationalOfLog l : ℚ) : ℝ)
    rw [positive_val_prod]                                   -- {t // 0 < t} の有限積の値は ℝ の有限積
    simp only [Positive.coe_zpow]                            -- 整数冪の値は ℝ の整数冪（rfl）
    unfold rationalOfLog Finsupp.prod                        -- rat_Λ の定義（台に渡る積）
    push_cast                                                -- ι は有限積・整数冪を保つ
    rfl
  rw [hL, ← hR]
  exact h

end Ising2DLambda.ThermodynamicLimit
