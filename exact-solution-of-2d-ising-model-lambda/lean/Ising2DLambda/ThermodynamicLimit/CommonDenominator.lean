/-
人手証明「有理係数の対数順序群の元の共通分母」（`def_common_denominator`）と
「共通分母を通した順序の判定は共通分母の取り方によらない」
（`claim_common_denominator_order_independent`）の具体版。

`N` が `λ ∈ Λ_ℚ` の共通分母であるとは、`λ_N ∈ Λ` で `N·λ = ι(λ_N)` を満たすものが在ること。
一意性は `ι` の単射性。独立性は、まず `ι(N'λ_N) = ι(Nλ_{N'})` を七段の鎖で示して単射性で
`N'λ_N = Nλ_{N'}` を得、次に順序の正整数倍不変性を `N'` と `N` について使う同値の鎖で閉じる。
住処は ℕ・ℤ・ℚ・Λ・Λ_ℚ のみで、ℝ / ℂ は現れない。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroup
import Ising2DLambda.FreeEntropy.LogOrderGroupPositiveMultipleInvariant

namespace Ising2DLambda.ThermodynamicLimit

open FreeEntropy

/-- `def_common_denominator`。`N` が `l` の共通分母で、`lN` がその証人であること。 -/
def IsCommonDenominator (N : ℕ) (l : RationalLogOrderGroup) (lN : LogOrderGroup) : Prop :=
  ((N : ℚ)) • l = toRational lN

/-- `def_common_denominator` の一意性。証人は `ι` の単射性から一つしかない。 -/
theorem commonDenominator_unique (N : ℕ) (l : RationalLogOrderGroup) (lN lN' : LogOrderGroup)
    (h : IsCommonDenominator N l lN) (h' : IsCommonDenominator N l lN') : lN = lN' := by
  unfold IsCommonDenominator at h h'
  -- ι(λ_N) = N·λ = ι(λ_N')
  exact toRational_injective lN lN' (h.symm.trans h')

/-- 準備: `N'λ_N = Nλ_{N'}`。両辺を `ι` で送った先を七段の鎖で比べ、単射性で戻す。 -/
theorem commonDenominator_cross_smul (N N' : ℕ) (l : RationalLogOrderGroup)
    (lN lN' : LogOrderGroup)
    (h : IsCommonDenominator N l lN) (h' : IsCommonDenominator N' l lN') :
    ((N' : ℤ)) • lN = ((N : ℤ)) • lN' := by
  unfold IsCommonDenominator at h h'
  apply toRational_injective
  calc
    toRational (((N' : ℤ)) • lN)
        = (((N' : ℤ) : ℚ)) • toRational lN := (toRational_intSmul _ _).symm   -- 整数倍と ι の交換
    _ = (((N' : ℤ) : ℚ)) • (((N : ℚ)) • l) := by rw [← h]                       -- N は λ の共通分母
    _ = ((((N' : ℤ) : ℚ)) * (N : ℚ)) • l := smul_smul _ _ _                       -- 有理数倍の結合則
    _ = (((N : ℚ)) * (((N' : ℤ) : ℚ))) • l := by rw [mul_comm]                    -- ℚ の積の可換性
    _ = ((N : ℚ)) • ((((N' : ℤ) : ℚ)) • l) := (smul_smul _ _ _).symm              -- 有理数倍の結合則
    _ = ((N : ℚ)) • toRational lN' := by
          rw [Int.cast_natCast, h']                                              -- N' は λ の共通分母
    _ = (((N : ℤ) : ℚ)) • toRational lN' := by rw [Int.cast_natCast]
    _ = toRational (((N : ℤ)) • lN') := toRational_intSmul _ _                    -- 整数倍と ι の交換

/-- `claim_common_denominator_order_independent`。 -/
theorem commonDenominator_order_independent (N N' : ℕ) (hN : 1 ≤ N) (hN' : 1 ≤ N')
    (l m : RationalLogOrderGroup) (lN mN lN' mN' : LogOrderGroup)
    (hl : IsCommonDenominator N l lN) (hm : IsCommonDenominator N m mN)
    (hl' : IsCommonDenominator N' l lN') (hm' : IsCommonDenominator N' m mN') :
    logOrderLE lN mN ↔ logOrderLE lN' mN' := by
  have el : ((N' : ℤ)) • lN = ((N : ℤ)) • lN' := commonDenominator_cross_smul N N' l lN lN' hl hl'
  have em : ((N' : ℤ)) • mN = ((N : ℤ)) • mN' := commonDenominator_cross_smul N N' m mN mN' hm hm'
  calc
    logOrderLE lN mN
        ↔ logOrderLE (((N' : ℤ)) • lN) (((N' : ℤ)) • mN) := logOrderLE_natSmul_iff N' hN' lN mN
    _ ↔ logOrderLE (((N : ℤ)) • lN') (((N : ℤ)) • mN') := by rw [el, em]
    _ ↔ logOrderLE lN' mN' := (logOrderLE_natSmul_iff N hN lN' mN').symm

end Ising2DLambda.ThermodynamicLimit
