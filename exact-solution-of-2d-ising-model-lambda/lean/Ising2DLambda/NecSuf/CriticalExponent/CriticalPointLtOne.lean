/-
`claim_critical_point_lt_one` の必要十分版。

具体版が使う本質は次だけである。
  - s は零元でない w の平方 w*w である（w ≠ 0 は証人 z = w*v⁻¹ の非零性に要る）。
  - w*w + 1*1 は平方 v*v である。
  - 二つの平方の和が零なら各項が零である。
  - s*s = 1+1。
  - 体の四則と逆元。

実閉性・代数的数・平方の三分法・虚数単位・一意表示は、この論法自体には要らない。
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.CriticalExponent

theorem criticalPoint_lt_one_necSuf {K : Type*} [Field K]
    (s w : K)
    (hw0 : w ≠ 0)
    (hsSquare : s = w * w)
    (hsTwo : s * s = 1 + 1)
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0) :
    ∃ z : K, z ≠ 0 ∧ 1 - (-1 + s) = z * z := by
  obtain ⟨v, hv⟩ := sumIsSquare w 1
  have hsv : s + 1 = v * v := by
    calc
      s + 1 = w * w + 1 * 1 := by rw [hsSquare]; ring
      _ = v * v := hv
  have hv0 : v ≠ 0 := by
    intro hvZero
    have hsum : w * w + 1 * 1 = 0 := by rw [hv, hvZero]; ring
    exact one_ne_zero (sumEqZero w 1 hsum).2
  have hkey : ((2 : K) - s) * (v * v) = s := by
    rw [← hsv]
    calc
      ((2 : K) - s) * (s + 1) = (1 + 1) - s * s + s := by ring
      _ = (1 + 1) - (1 + 1) + s := by rw [hsTwo]
      _ = s := by ring
  refine ⟨w * v⁻¹, mul_ne_zero hw0 (inv_ne_zero hv0), ?_⟩
  have hsub : (1 : K) - (-1 + s) = 2 - s := by ring
  rw [hsub, eq_comm]
  calc
    w * v⁻¹ * (w * v⁻¹) = (w * w) * (v⁻¹ * v⁻¹) := by ring
    _ = s * (v⁻¹ * v⁻¹) := by rw [← hsSquare]
    _ = (((2 : K) - s) * (v * v)) * (v⁻¹ * v⁻¹) := by rw [hkey]
    _ = ((2 : K) - s) * ((v * v⁻¹) * (v * v⁻¹)) := by ring
    _ = ((2 : K) - s) * ((1 : K) * 1) := by rw [mul_inv_cancel₀ hv0]
    _ = (2 : K) - s := by ring

end Ising2DLambda.NecSuf.CriticalExponent
