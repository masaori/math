/-
人手証明「有理係数の対数順序群」（`def_rational_log_order_group`）と
「対数順序群から有理係数の対数順序群への写像は加法を保ち単射である」
（`claim_rational_log_order_group_embedding`）の具体版。

`Λ_ℚ` は素数から `ℚ` への有限台の写像全体。`ι_{Λ→Λ_ℚ}` は各素数の整数値を
分母 1 の有理数として読む写像である。人手証明と同じく、写像の等号を各素数での値の等号へ
落として、`ι` の定義・`Λ` の加法の定義・分母 1 の有理数の加法・`Λ_ℚ` の加法の定義の順で辿る。
-/
import Ising2DLambda.FreeEntropy.Basic

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_rational_log_order_group`。有理係数の対数順序群 `Λ_ℚ`。
素数から `ℚ` への写像のうち、値が `0` でない素数が有限個であるもの全体。
加法と有理数倍は素数ごと（`Finsupp` の加法・スカラー倍がそれである）。 -/
abbrev RationalLogOrderGroup : Type := Nat.Primes →₀ ℚ

/-- `def_rational_log_order_group` の `ι_{Λ→Λ_ℚ}`。各素数の整数値を分母 1 の有理数として読む。 -/
noncomputable def toRational (l : LogOrderGroup) : RationalLogOrderGroup :=
  Finsupp.mapRange (fun n : ℤ => (n : ℚ)) (by simp) l

/-- `ι` の定義: 各素数での値。 -/
theorem toRational_apply (l : LogOrderGroup) (p : Nat.Primes) :
    toRational l p = ((l p : ℤ) : ℚ) := by
  simp [toRational]

/-- `def_rational_log_order_group` の密度の住処: `(1/L^2)·ι(Φ_L(q)) ∈ Λ_ℚ`。 -/
noncomputable def scaledFreeEntropy (L : ℕ) [NeZero L] (q : ℚ) : RationalLogOrderGroup :=
  ((1 : ℚ) / ((L : ℚ) ^ 2)) • toRational (freeEntropy L q)

/-- `claim_rational_log_order_group_embedding` の加法の部分。 -/
theorem toRational_add (l m : LogOrderGroup) :
    toRational (l + m) = toRational l + toRational m := by
  -- 写像の等号は各素数での値の等号
  ext p
  calc
    toRational (l + m) p = (((l + m) p : ℤ) : ℚ) := toRational_apply (l + m) p
    -- Λ の加法の定義
    _ = ((l p + m p : ℤ) : ℚ) := by rw [Finsupp.add_apply]
    -- 分母 1 の有理数の加法
    _ = ((l p : ℤ) : ℚ) + ((m p : ℤ) : ℚ) := Int.cast_add _ _
    -- ι の定義
    _ = toRational l p + toRational m p := by rw [toRational_apply, toRational_apply]
    -- Λ_ℚ の加法の定義
    _ = (toRational l + toRational m) p := (Finsupp.add_apply _ _ _).symm

/-- `claim_rational_log_order_group_embedding` の単射の部分。 -/
theorem toRational_injective (l m : LogOrderGroup) (h : toRational l = toRational m) :
    l = m := by
  ext p
  -- 分母 1 の有理数の等号から整数の等号
  have hp : ((l p : ℤ) : ℚ) = ((m p : ℤ) : ℚ) := by
    calc
      ((l p : ℤ) : ℚ) = toRational l p := (toRational_apply l p).symm
      _ = toRational m p := by rw [h]
      _ = ((m p : ℤ) : ℚ) := toRational_apply m p
  exact Int.cast_injective hp

/-- `claim_scaled_free_entropy_denominator_clearing` の末尾:
整数倍と `ι` は交換する（`n·ι(ν) = ι(nν)`）。各素数での値の等号として示す。 -/
theorem toRational_intSmul (n : ℤ) (l : LogOrderGroup) :
    ((n : ℚ)) • toRational l = toRational (n • l) := by
  ext p
  calc
    ((n : ℚ) • toRational l) p = (n : ℚ) * toRational l p := Finsupp.smul_apply _ _ _
    -- ι の定義
    _ = (n : ℚ) * ((l p : ℤ) : ℚ) := by rw [toRational_apply]
    -- 分母 1 の有理数の積は整数の積
    _ = ((n * l p : ℤ) : ℚ) := (Int.cast_mul _ _).symm
    -- Λ の整数倍の定義
    _ = (((n • l) p : ℤ) : ℚ) := by rw [Finsupp.smul_apply, smul_eq_mul]
    -- ι の定義
    _ = toRational (n • l) p := (toRational_apply _ _).symm

end Ising2DLambda.ThermodynamicLimit
