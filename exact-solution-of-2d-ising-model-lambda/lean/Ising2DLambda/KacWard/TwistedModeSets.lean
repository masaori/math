/-
横・縦方向のねじれたモード集合の定義。
`Bool.false` と `Bool.true` は本文の 0 と 1 に対応する。
住処は Qbar と有限集合であり、実数体・複素数体は使わない。
-/
import Ising2DLambda.KacWard.Basic
import Ising2DLambda.AlgebraicEigenvalue.RootOfUnity

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

def horizontalTwistedModes (L : ℕ) (s : SpinStructure) : Set Qbar :=
  {z : Qbar | z ^ L = if s.1 then -1 else 1}

def verticalTwistedModes (L : ℕ) (s : SpinStructure) : Set Qbar :=
  {z : Qbar | z ^ L = if s.2 then -1 else 1}

theorem twistedModes_subset_doubleRoots (L : ℕ) (s : SpinStructure) :
    horizontalTwistedModes L s ∪ verticalTwistedModes L s ⊆ RootOfUnity (2 * L) := by
  intro z hz
  have hpow : z ^ L = 1 ∨ z ^ L = -1 := by
    rcases hz with hz | hz
    · unfold horizontalTwistedModes at hz
      cases h : s.1 <;> simp [h] at hz
      · exact Or.inl hz
      · exact Or.inr hz
    · unfold verticalTwistedModes at hz
      cases h : s.2 <;> simp [h] at hz
      · exact Or.inl hz
      · exact Or.inr hz
  change z ^ (2 * L) = 1
  calc
    z ^ (2 * L) = (z ^ L) ^ 2 := by rw [mul_comm 2 L, pow_mul]
    _ = 1 := by rcases hpow with h | h <;> rw [h] <;> norm_num

end Ising2DLambda.KacWard
