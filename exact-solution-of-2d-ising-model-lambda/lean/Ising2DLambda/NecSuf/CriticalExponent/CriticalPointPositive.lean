/-
`claim_critical_point_positive` の必要十分版。

具体版が使う本質は次だけである。
  - s は平方 w*w である。
  - w*w + 1*1 は平方 v*v である。
  - 二つの平方の和が零なら各項が零である。
  - s*s = 1+1。
  - 体の四則と逆元。

実閉性・代数的数・平方の三分法・虚数単位・一意表示は、この論法自体には要らない。
-/
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.CriticalExponent

theorem criticalPoint_positive_necSuf {K : Type*} [Field K]
    (s w : K)
    (hsSquare : s = w * w)
    (hsTwo : s * s = 1 + 1)
    (sumIsSquare : ∀ a b : K, ∃ v : K, a * a + b * b = v * v)
    (sumEqZero : ∀ a b : K, a * a + b * b = 0 → a = 0 ∧ b = 0) :
    ∃ z : K, z ≠ 0 ∧ (-1 + s) - 0 = z * z := by
  obtain ⟨v, hv⟩ := sumIsSquare w 1
  have hsv : s + 1 = v * v := by
    calc
      s + 1 = w * w + 1 * 1 := by rw [hsSquare]; ring
      _ = v * v := hv
  have hv0 : v ≠ 0 := by
    intro hvZero
    have hsum : w * w + 1 * 1 = 0 := by rw [hv, hvZero]; ring
    exact one_ne_zero (sumEqZero w 1 hsum).2
  refine ⟨v⁻¹, inv_ne_zero hv0, ?_⟩
  field_simp [hv0]
  simp only [sub_zero, pow_two]
  rw [← hsv]
  calc
    (-1 + s) * (s + 1) = s * s - 1 := by ring
    _ = (1 + 1) - 1 := by rw [hsTwo]
    _ = 1 := by ring

end Ising2DLambda.NecSuf.CriticalExponent
