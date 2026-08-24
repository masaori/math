/-
必要十分版 `NecSuf.crossPowerIdentity_iff_powerForm` から、正の有理数上の具体版と同じ主張を導く。
具体版に残るのは、有限箱値が正であること、隣接する立方数が互いに素であること、
および正の有理数上で非零自然数乗が単射であることだけである。
-/
import Ising3DCut.LimitQuantity.RationalRootFromDivisiblePrimeExponents
import Ising3DCut.NecSuf.CrossPowerIdentityIffPowerForm

namespace Ising3DCut.LimitQuantity

/-- `eventually_cross_power_identity_iff_rational_power_form` を必要十分版から導いた版。 -/
theorem eventually_cross_power_identity_iff_rational_power_form_viaNecSuf
    (q : ℚ) (hq : 0 < q) (L0 : ℕ) (hL0 : 0 < L0) :
    (∀ L, L0 ≤ L →
        rationalValueSeq q L ^ ((L + 1) ^ 3) =
          rationalValueSeq q (L + 1) ^ (L ^ 3)) ↔
      (∃ c : ℚ, 0 < c ∧ ∀ L, L0 ≤ L → rationalValueSeq q L = c ^ (L ^ 3)) := by
  let a : ℕ → {x : ℚ // 0 < x} := fun L =>
    if hL : 0 < L then
      ⟨rationalValueSeq q L, partitionPolynomial_evalAtRational_pos hL hq⟩
    else
      ⟨1, one_pos⟩
  have ha (L : ℕ) (hL : L0 ≤ L) : (a L : ℚ) = rationalValueSeq q L := by
    simp [a, lt_of_lt_of_le hL0 hL]
  have habstract := Ising3DCut.NecSuf.crossPowerIdentity_iff_powerForm
    a (fun L => L ^ 3) L0
    (fun L hL => pow_ne_zero 3 (lt_of_lt_of_le hL0 hL).ne')
    (fun L _hL => coprime_cube_succ L)
    (by
      intro m hm x y hxy
      apply Subtype.ext
      apply (pow_left_inj₀ x.property.le y.property.le hm).1
      exact congrArg Subtype.val hxy)
  constructor
  · intro hcross
    have hcross' : ∀ L, L0 ≤ L → a L ^ ((L + 1) ^ 3) = a (L + 1) ^ (L ^ 3) := by
      intro L hL
      apply Subtype.ext
      simpa [ha L hL, ha (L + 1) (le_trans hL (Nat.le_succ L))] using hcross L hL
    obtain ⟨c, hc⟩ := habstract.mp hcross'
    refine ⟨(c : ℚ), c.property, ?_⟩
    intro L hL
    have := congrArg Subtype.val (hc L hL)
    simpa [ha L hL] using this
  · rintro ⟨c, hcpos, hc⟩
    let c' : {x : ℚ // 0 < x} := ⟨c, hcpos⟩
    have hc' : ∀ L, L0 ≤ L → a L = c' ^ (L ^ 3) := by
      intro L hL
      apply Subtype.ext
      simpa [ha L hL, c'] using hc L hL
    have hcross' := habstract.mpr ⟨c', hc'⟩
    intro L hL
    have := congrArg Subtype.val (hcross' L hL)
    simpa [ha L hL, ha (L + 1) (le_trans hL (Nat.le_succ L))] using this

end Ising3DCut.LimitQuantity
