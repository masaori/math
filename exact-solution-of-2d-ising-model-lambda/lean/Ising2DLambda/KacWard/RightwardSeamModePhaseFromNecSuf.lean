import Ising2DLambda.KacWard.RightwardSeamModePhase
import Ising2DLambda.NecSuf.KacWard.RightwardSeamModePhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- The concrete horizontal seam is the period-residue calculation. -/
theorem rightwardSeam_modePhase_from_necSuf (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (e : Edge L) (he : e.val < L ^ 2) :
    (twistSign s (e, false) : Qbar) *
      (varpi ^ (orientedTarget (e, false)).2.val *
        varsigma ^ (orientedTarget (e, false)).1.val) =
      varpi ^ ((orientedSource (e, false)).2.val + 1) *
        varsigma ^ (orientedSource (e, false)).1.val := by
  letI : NeZero L := ⟨by omega⟩
  have hcol : edgeColumn L e < L := by
    unfold edgeColumn
    exact Nat.mod_lt _ (by omega)
  let σ : Qbar := if s.1 then -1 else 1
  have hz : varpi ^ L = σ := hvarpi
  have hsign : (twistSign s (e, false) : Qbar) =
      if edgeColumn L e = L - 1 then σ else 1 := by
    by_cases hlast : edgeColumn L e = L - 1
    · cases hs : s.1 <;> simp [twistSign, horizontalSeamParity,
        verticalSeamParity, he, hlast, σ, hs]
    · simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
  have htarget : (((edgeColumn L e : ZMod L) + 1).val) =
      (edgeColumn L e + 1) % L := by
    convert ZMod.val_natCast L (edgeColumn L e + 1) using 1 <;> push_cast <;> ring
  have hsource : ((edgeColumn L e : ZMod L).val) = edgeColumn L e :=
    ZMod.val_natCast_of_lt hcol
  simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
    Bool.false_eq_true, ↓reduceIte, htarget, hsource]
  rw [hsign]
  have hmain := Ising2DLambda.NecSuf.KacWard.rightwardSeam_modePhase_necSuf
    L (edgeColumn L e) hL hcol σ varpi hz
  rw [← mul_assoc, hmain]

end Ising2DLambda.KacWard
