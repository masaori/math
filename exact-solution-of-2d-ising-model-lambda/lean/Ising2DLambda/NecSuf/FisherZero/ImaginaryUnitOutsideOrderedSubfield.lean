import Mathlib.Algebra.Field.Subfield.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

/-- 加法で閉じる錐、単位元の正性、非零平方の正性だけを用いる。 -/
theorem imaginaryUnit_not_mem_orderedSubfield
    {K : Type*} [Field K] (F : Subfield K) (C : Set K)
    (hzero : (0 : K) ∉ C) (hone : (1 : K) ∈ C)
    (hadd : ∀ x y : K, x ∈ C → y ∈ C → x + y ∈ C)
    (hsquare : ∀ x : K, x ∈ F → x ≠ 0 → x * x ∈ C)
    (omega : K) (homega : omega * omega = -1) : omega ∉ F := by
  have hminus : (-1 : K) ∉ C := by
    intro h
    have hsum : (1 : K) + -1 ∈ C := hadd 1 (-1) hone h
    have hsum0 : (1 : K) + -1 = 0 := by ring
    exact hzero (hsum0 ▸ hsum)
  intro hmem
  have hne : omega ≠ 0 := by
    intro hz
    have hzeroeq : (0 : K) = -1 := by simpa [hz] using homega
    exact neg_ne_zero.mpr one_ne_zero hzeroeq.symm
  have hsq : omega * omega ∈ C := hsquare omega hmem hne
  exact hminus (homega ▸ hsq)

end Ising2DLambda.NecSuf.FisherZero
