import Ising2DLambda.NecSuf.KacWard.PrimitiveIntegerPair
import Mathlib.Tactic.Ring

namespace Ising2DLambda.KacWard

/-- `def_primitive_integer_pair`: a nonzero integer pair with positive gcd one. -/
def primitiveIntegerPair (a b : ℤ) : Prop :=
  (a, b) ≠ (0, 0) ∧ Int.gcd a b = 1

theorem primitiveIntegerPair_iff_bezout (a b : ℤ) :
    primitiveIntegerPair a b ↔
      ∃ r s : ℤ, a * s - b * r = 1 ∨ a * s - b * r = -1 := by
  constructor
  · intro h
    obtain ⟨_, hg⟩ := h
    refine ⟨-Int.gcdB a b, Int.gcdA a b, Or.inl ?_⟩
    have hb := Int.gcd_eq_gcd_ab a b
    rw [hg] at hb
    calc
      a * Int.gcdA a b - b * (-Int.gcdB a b) =
          a * Int.gcdA a b + b * Int.gcdB a b := by ring
      _ = 1 := hb.symm
  · rintro ⟨r, s, h⟩
    have hn : (a, b) ≠ (0, 0) := by
      intro hab
      have ha : a = 0 := congrArg Prod.fst hab
      have hb : b = 0 := congrArg Prod.snd hab
      rcases h with h | h <;> simp [ha, hb] at h
    have hd : Int.gcd a b ∣ 1 := by
      apply (Int.gcd_dvd_iff).2
      rcases h with h | h
      · exact ⟨s, -r, by calc
          (1 : ℤ) = a * s - b * r := h.symm
          _ = a * s + b * -r := by ring⟩
      · exact ⟨-s, r, by calc
          (1 : ℤ) = -(a * s - b * r) := by rw [h]; ring
          _ = a * -s + b * r := by ring⟩
    exact ⟨hn, Nat.dvd_one.mp hd⟩

theorem primitiveIntegerPair_from_necSuf (a b : ℤ) :
    primitiveIntegerPair a b ↔
      Ising2DLambda.NecSuf.KacWard.primitivePair Int.gcd a b := Iff.rfl

end Ising2DLambda.KacWard
