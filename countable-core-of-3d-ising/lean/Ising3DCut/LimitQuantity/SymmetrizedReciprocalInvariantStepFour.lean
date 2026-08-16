/-
「回文性で対称化した素指数データは逆数で不変である」
（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）の Lean 具体版・第四歩の前半。

人手証明の最後の段「L≥2 かつ q≠1 なら Z_L(q) ≠ Z_L(1/q)」のうち、
「Z_L が正の有理数上で狭義単調増加なら、q>0, q≠1 で Z_L(q) ≠ Z_L(1/q)」の部分に対応する。
q ≠ 1/q（q>0, q≠1）と、q<1/q または 1/q<q のどちらかで真の不等号が出ることだけを使う。
狭義単調性そのもの（非負係数・正の最高次係数・次数 ≥ 1 から）は
`SymmetrizedReciprocalInvariantStepFourMonotone.lean`（次の tick）で示す。
-/
import Mathlib.Algebra.Order.Field.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

namespace Ising3DCut.LimitQuantity

/-- 第四歩の前半。`g` が `(0,∞)` 上で狭義単調増加なら、`q>0`, `q≠1` で `g q ≠ g (1/q)`。 -/
theorem ne_eval_inv_of_strictMonoOn {g : ℚ → ℚ}
    (hmono : ∀ a b : ℚ, 0 < a → a < b → g a < g b)
    {q : ℚ} (hq : 0 < q) (hq1 : q ≠ 1) :
    g q ≠ g (1 / q) := by
  have hinv : 0 < 1 / q := one_div_pos.mpr hq
  rcases lt_trichotomy q (1 / q) with h | h | h
  · exact ne_of_lt (hmono q (1 / q) hq h)
  · exfalso
    have : q * q = 1 := by
      calc q * q = q * (1 / q) := by rw [← h]
        _ = 1 := mul_one_div_cancel hq.ne'
    have hq2 : q = 1 ∨ q = -1 := by
      have : (q - 1) * (q + 1) = 0 := by ring_nf; linarith
      rcases mul_eq_zero.mp this with h1 | h1
      · left; linarith
      · right; linarith
    rcases hq2 with h1 | h1
    · exact hq1 h1
    · linarith
  · exact (ne_of_lt (hmono (1 / q) q hinv h)).symm

end Ising3DCut.LimitQuantity
