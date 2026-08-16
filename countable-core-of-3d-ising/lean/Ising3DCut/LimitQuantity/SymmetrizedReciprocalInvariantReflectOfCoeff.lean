/-
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 具体版へ向けた橋渡し。
本文の回文性は係数の等式 `coeff i = coeff (E - i)`（`帰無モデル: 二部性からの回文性` の
`multiplicity_palindrome`）で述べられ、束ねた定理 `SymmetrizedReciprocalInvariantBundle.lean` は
`reflect E f = f` を仮定にとる。両者を結ぶ一般補題をここに置く。
-/
import Mathlib.Algebra.Polynomial.Reverse

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 係数が `E` について回文（`i ≤ E` で `coeff i = coeff (E - i)`）なら（次数の仮定は不要）
`reflect E f = f`。 -/
theorem reflect_eq_of_coeff_palindrome {E : ℕ} {f : ℚ[X]}
    (hpal : ∀ i, i ≤ E → f.coeff i = f.coeff (E - i)) : reflect E f = f := by
  ext i
  rw [coeff_reflect]
  by_cases hi : i ≤ E
  · rw [revAt_le hi, hpal i hi]
  · push Not at hi
    rw [revAt_eq_self_of_lt hi]

end Ising3DCut.LimitQuantity
