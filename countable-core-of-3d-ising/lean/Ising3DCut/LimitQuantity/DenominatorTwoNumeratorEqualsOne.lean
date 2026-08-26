/-
「有限箱の量が末尾で一定となる正の有理点は 1 に限られる」の接続の一段。
既約分母が `2` の場合に、分母を払った有限箱等式と既に得た分子の整除から、
破れ数 `0` の多重度が `2` であることを使って既約分子が `1` になることを示す。

扱うのは一つの有限箱における整数の等式・整除だけであり、極限も無限和も現れない。
-/
import Ising3DCut.LimitQuantity.DenominatorTwoPointAndFinalCandidateSet
import Ising3DCut.NullModel.ZeroBreakageConstant

namespace Ising3DCut.LimitQuantity

/-- 分母を払った有限箱等式と分子の整除を、分母 `2` の既約性へ接続する。 -/
theorem denominator_two_numerator_eq_one_from_finite_box
    {a E c n L S : ℕ} (hL : 0 < L) (hcoprime : Nat.Coprime a 2)
    (hscaled : (2 : ℤ) ^ E * (c : ℤ) ^ n =
      (2 : ℤ) ^ E * (NullModel.multiplicity L 0 : ℤ) + (a : ℤ) * S)
    (hdvd : (a : ℤ) ∣ 2 * ((c : ℤ) ^ n - 1)) :
    a = 1 := by
  have hidentity := denominatorTwo_scaled_difference_identity hscaled
  have hleft : (a : ℤ) ∣ (2 : ℤ) ^ (E + 1) * ((c : ℤ) ^ n - 1) := by
    have hpow : (2 : ℤ) ^ (E + 1) * ((c : ℤ) ^ n - 1) =
        (2 : ℤ) ^ E * (2 * ((c : ℤ) ^ n - 1)) := by ring
    rw [hpow]
    exact Dvd.dvd.mul_left hdvd _
  have hsum : (a : ℤ) ∣
      (2 : ℤ) ^ (E + 1) * ((NullModel.multiplicity L 0 : ℤ) - 1) +
        2 * (a : ℤ) * S := by
    rw [← hidentity]
    exact hleft
  have htail : (a : ℤ) ∣ 2 * (a : ℤ) * S := by
    exact ⟨2 * S, by ring⟩
  have hconstant : (a : ℤ) ∣
      (2 : ℤ) ^ (E + 1) * ((NullModel.multiplicity L 0 : ℤ) - 1) := by
    have hsub := hsum.sub htail
    have hrw :
        (2 : ℤ) ^ (E + 1) * ((NullModel.multiplicity L 0 : ℤ) - 1) +
            2 * (a : ℤ) * S - 2 * (a : ℤ) * S =
          (2 : ℤ) ^ (E + 1) * ((NullModel.multiplicity L 0 : ℤ) - 1) := by
      ring
    rw [hrw] at hsub
    exact hsub
  have hzero : NullModel.multiplicity L 0 = 2 := NullModel.multiplicity_zero_eq_two hL
  have hpowerInt : (a : ℤ) ∣ (2 : ℤ) ^ (E + 1) := by
    simpa [hzero] using hconstant
  have hpowerNat : a ∣ 2 ^ (E + 1) := by
    exact_mod_cast hpowerInt
  exact denominatorTwo_numerator_eq_one hcoprime hpowerNat

end Ising3DCut.LimitQuantity
