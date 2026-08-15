/-
人手証明「有理係数の対数順序群の元は共通分母を持つ」（`claim_common_denominator_exists`）の具体版。

`λ ∈ Λ_ℚ` の非零値の既約分母の積 `N_λ` は `1` 以上で、`λ` の共通分母である。証人 `ν` は
各素数で `(N_λ / den) · num`（台の外では `0`）。証明は本文と同じく、`p ∈ S_λ` では
有理数倍の定義 → `den` が `N_λ` の因子 → 積の結合則 → 既約分数表示 `den·λ(p) = num` →
分母 1 の有理数の積 → `ν` の定義 → `ι` の定義、`p ∉ S_λ` では両辺 `0` の鎖で閉じる。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.CommonDenominator

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `N_λ := ∏_{p ∈ S_λ} den(λ(p))`。`S_λ` は `Finsupp` の台 `l.support`。 -/
def denominatorProduct (l : RationalLogOrderGroup) : ℕ :=
  l.support.prod (fun p => (l p).den)

/-- 主張の第一部: `N_λ ≥ 1`（`1` 以上の整数の有限積。空積は `1`）。 -/
theorem denominatorProduct_pos (l : RationalLogOrderGroup) : 1 ≤ denominatorProduct l := by
  unfold denominatorProduct
  exact Nat.one_le_iff_ne_zero.mpr
    (Finset.prod_ne_zero_iff.mpr (fun p _ => (l p).den_nz))

/-- `p ∈ S_λ` なら `den(λ(p))` は積 `N_λ` の因子である。 -/
theorem den_dvd_denominatorProduct (l : RationalLogOrderGroup) (p : Nat.Primes)
    (hp : p ∈ l.support) : (l p).den ∣ denominatorProduct l :=
  Finset.dvd_prod_of_mem (fun p => (l p).den) hp

/-- 証人 `ν`: 各素数で `(N_λ / den(λ(p))) · num(λ(p))`。`λ(p) = 0` では `(N_λ/1)·0 = 0`。 -/
noncomputable def commonDenominatorWitness (l : RationalLogOrderGroup) : LogOrderGroup :=
  Finsupp.mapRange
    (fun q : ℚ => (((denominatorProduct l / q.den : ℕ) : ℤ)) * q.num)
    (by simp) l

theorem commonDenominatorWitness_apply (l : RationalLogOrderGroup) (p : Nat.Primes) :
    commonDenominatorWitness l p
      = (((denominatorProduct l / (l p).den : ℕ) : ℤ)) * (l p).num := by
  simp [commonDenominatorWitness]

/-- `claim_common_denominator_exists`: `N_λ` は `λ` の共通分母で、証人は `ν`。 -/
theorem commonDenominator_exists (l : RationalLogOrderGroup) :
    IsCommonDenominator (denominatorProduct l) l (commonDenominatorWitness l) := by
  unfold IsCommonDenominator
  -- 写像の等号は各素数での値の等号
  ext p
  by_cases hp : p ∈ l.support
  · -- p ∈ S_λ
    have hdvd : (l p).den ∣ denominatorProduct l := den_dvd_denominatorProduct l p hp
    calc
      (((denominatorProduct l : ℕ) : ℚ) • l) p
          = ((denominatorProduct l : ℕ) : ℚ) * l p := Finsupp.smul_apply _ _ _
      -- den は N_λ の因子: N_λ = (N_λ / den) · den
      _ = (((denominatorProduct l / (l p).den * (l p).den : ℕ) : ℚ)) * l p := by
            rw [Nat.div_mul_cancel hdvd]
      -- ℚ の積の結合則（ℕ の積を ℚ の積へ読み替えたうえで）
      _ = (((denominatorProduct l / (l p).den : ℕ) : ℚ)) * (((l p).den : ℚ) * l p) := by
            rw [Nat.cast_mul, mul_assoc]
      -- 既約分数表示: den · λ(p) = num
      _ = (((denominatorProduct l / (l p).den : ℕ) : ℚ)) * (((l p).num : ℤ) : ℚ) := by
            rw [mul_comm ((l p).den : ℚ) (l p), Rat.mul_den_eq_num]
      -- 分母 1 の有理数の積は整数の積
      _ = (((((denominatorProduct l / (l p).den : ℕ) : ℤ)) * (l p).num : ℤ) : ℚ) := by
            rw [Int.cast_mul, Int.cast_natCast]
      -- ν の定義
      _ = ((commonDenominatorWitness l p : ℤ) : ℚ) := by
            rw [commonDenominatorWitness_apply]
      -- ι の定義
      _ = toRational (commonDenominatorWitness l) p := (toRational_apply _ _).symm
  · -- p ∉ S_λ: λ(p) = 0
    have h0 : l p = 0 := Finsupp.notMem_support_iff.mp hp
    calc
      (((denominatorProduct l : ℕ) : ℚ) • l) p
          = ((denominatorProduct l : ℕ) : ℚ) * l p := Finsupp.smul_apply _ _ _
      _ = ((denominatorProduct l : ℕ) : ℚ) * 0 := by rw [h0]
      _ = 0 := mul_zero _
      -- ν の定義（λ(p) = 0 なので (N_λ/1)·0 = 0）
      _ = ((commonDenominatorWitness l p : ℤ) : ℚ) := by
            rw [commonDenominatorWitness_apply, h0]; simp
      -- ι の定義
      _ = toRational (commonDenominatorWitness l) p := (toRational_apply _ _).symm

end Ising2DLambda.ThermodynamicLimit
