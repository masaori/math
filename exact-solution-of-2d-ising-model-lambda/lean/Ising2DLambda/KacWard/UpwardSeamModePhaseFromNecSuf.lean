import Ising2DLambda.KacWard.UpwardSeamModePhase
import Ising2DLambda.NecSuf.KacWard.UpwardSeamModePhase

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.AlgebraicEigenvalue

/-- The reverse vertical edge instantiates the period-residue lemma. -/
theorem upwardSeam_modePhase_from_necSuf (L : ℕ) (hL : 1 ≤ L)
    (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s)
    (e : Edge L) (he : ¬ e.val < L ^ 2) :
    (twistSign s (e, true) : Qbar) *
      (varpi ^ (orientedTarget (e, true)).2.val *
        varsigma ^ (orientedTarget (e, true)).1.val) =
      varsigma⁻¹ * (varpi ^ (orientedSource (e, true)).2.val *
        varsigma ^ (orientedSource (e, true)).1.val) := by
  letI : NeZero L := ⟨by omega⟩
  have hrow : edgeRow L e < L := by
    have hidx : edgeIndex L e < L ^ 2 := by
      simp only [edgeIndex, if_neg he]
      have heval := e.isLt
      omega
    unfold edgeRow
    rw [Nat.div_lt_iff_lt_mul (by omega)]
    nlinarith
  let σ : Qbar := if s.2 then -1 else 1
  have hz : varsigma ^ L = σ := hvarsigma
  have hz0 : varsigma ≠ 0 := by
    intro h
    have hzero : (0 : Qbar) ^ L = σ := by simpa [h] using hz
    cases hs : s.2 <;> simp [σ, hs, Nat.ne_of_gt hL] at hzero
  have hσ : σ * σ = 1 := by
    cases hs : s.2 <;> simp [σ, hs]
  have hsign : (twistSign s (e, true) : Qbar) =
      if edgeRow L e = L - 1 then σ else 1 := by
    by_cases hlast : edgeRow L e = L - 1
    · cases hs : s.2 <;> simp [twistSign, horizontalSeamParity,
        verticalSeamParity, he, hlast, σ, hs]
    · simp [twistSign, horizontalSeamParity, verticalSeamParity, he, hlast]
  have hsource : (((edgeRow L e : ZMod L) + 1).val) =
      (edgeRow L e + 1) % L := by
    convert ZMod.val_natCast L (edgeRow L e + 1) using 1 <;> push_cast <;> ring
  have htarget : ((edgeRow L e : ZMod L).val) = edgeRow L e :=
    ZMod.val_natCast_of_lt hrow
  simp only [orientedTarget, orientedSource, boundary0, boundary1, he,
    Bool.true_eq_false, ↓reduceIte, hsource, htarget]
  rw [hsign]
  have hmain := Ising2DLambda.NecSuf.KacWard.upwardSeam_modePhase_necSuf
    L (edgeRow L e) hL hrow σ varsigma hz hσ hz0
  calc
    (if edgeRow L e = L - 1 then σ else 1) *
        (varpi ^ (edgeColumn L e : ZMod L).val * varsigma ^ edgeRow L e) =
        varpi ^ (edgeColumn L e : ZMod L).val *
          ((if edgeRow L e = L - 1 then σ else 1) * varsigma ^ edgeRow L e) := by ring
    _ = varpi ^ (edgeColumn L e : ZMod L).val *
          (varsigma⁻¹ * varsigma ^ ((edgeRow L e + 1) % L)) := by rw [hmain]
    _ = varsigma⁻¹ *
          (varpi ^ (edgeColumn L e : ZMod L).val *
            varsigma ^ ((edgeRow L e + 1) % L)) := by ring

end Ising2DLambda.KacWard
