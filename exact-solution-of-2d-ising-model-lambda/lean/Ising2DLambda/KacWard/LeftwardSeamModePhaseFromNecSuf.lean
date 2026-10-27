import Ising2DLambda.KacWard.LeftwardSeamModePhase
import Ising2DLambda.NecSuf.KacWard.LeftwardSeamModePhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- The reverse horizontal edge instantiates the period-residue lemma. -/
theorem leftwardSeam_modePhase_from_necSuf (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (e : Edge L) (he : e.val < L ^ 2) :
    (twistSign s (e, true) : Qbar) *
      (varpi ^ (orientedTarget (e, true)).2.val *
        varsigma ^ (orientedTarget (e, true)).1.val) =
      varpi⁻¹ * (varpi ^ (orientedSource (e, true)).2.val *
        varsigma ^ (orientedSource (e, true)).1.val) := by
  letI : NeZero L := ⟨by omega⟩
  have hcol : edgeColumn L e < L := by
    unfold edgeColumn
    exact Nat.mod_lt _ (by omega)
  let σ : Qbar := if s.1 then -1 else 1
  have hz : varpi ^ L = σ := hvarpi
  have hz0 : varpi ≠ 0 := by
    intro h
    have hzero : (0 : Qbar) ^ L = σ := by simpa [h] using hz
    cases hs : s.1 <;> simp [σ, hs, Nat.ne_of_gt hL] at hzero
  have hσ : σ * σ = 1 := by
    cases hs : s.1 <;> simp [σ, hs]
  have hsign : (twistSign s (e, true) : Qbar) =
      if edgeColumn L e = L - 1 then σ else 1 := by
    by_cases hlast : edgeColumn L e = L - 1
    · cases hs : s.1 <;> simp [twistSign, horizontalSeamParity,
        verticalSeamParity, he, hlast, σ, hs]
    · simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
  have hsource : (((edgeColumn L e : ZMod L) + 1).val) =
      (edgeColumn L e + 1) % L := by
    convert ZMod.val_natCast L (edgeColumn L e + 1) using 1 <;> push_cast <;> ring
  have htarget : ((edgeColumn L e : ZMod L).val) = edgeColumn L e :=
    ZMod.val_natCast_of_lt hcol
  simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
    Bool.true_eq_false, ↓reduceIte, hsource, htarget]
  rw [hsign]
  have hmain := Ising2DLambda.NecSuf.KacWard.leftwardSeam_modePhase_necSuf
    L (edgeColumn L e) hL hcol σ varpi hz hσ hz0
  rw [← mul_assoc, hmain]
  simp [mul_assoc]

end Ising2DLambda.KacWard
