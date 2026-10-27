import Mathlib
import Ising2DLambda.NecSuf.KacWard.TwistedFourierMatrix
import Ising2DLambda.NecSuf.KacWard.ModeBlockMatrix

namespace Ising2DLambda.NecSuf.KacWard

theorem transition_fourier_intertwining_necSuf
    {E P D R : Type*} [Fintype E] [Fintype P] [Fintype D]
    [DecidableEq D] [DecidableEq P] [CommSemiring R]
    (κ : E ≃ P × D) (direction : E → D)
    (ψ : P → D → E → R) (small : P → Matrix D D R)
    (T : Matrix E E R)
    (hsupport : ∀ p d e, direction e ≠ d → ψ p d e = 0)
    (haction : ∀ p d e,
      T.mulVec (ψ p d) e = small p (direction e) d * ψ p (direction e) e) :
    T * fourierMatrix κ (fun m e => ψ m.1 m.2 e) =
      fourierMatrix κ (fun m e => ψ m.1 m.2 e) *
        modeBlockMatrix κ Prod.fst Prod.snd small := by
  classical
  apply Matrix.ext
  intro e h
  let p := (κ h).1
  let d := direction e
  have hleft :
      (T * fourierMatrix κ (fun m e => ψ m.1 m.2 e)) e h =
        small p d (κ h).2 * ψ p d e := by
    change T.mulVec (ψ p (κ h).2) e = _
    exact haction p (κ h).2 e
  have hright :
      (fourierMatrix κ (fun m e => ψ m.1 m.2 e) *
        modeBlockMatrix κ Prod.fst Prod.snd small) e h =
        ψ p d e * small p d (κ h).2 := by
    rw [Matrix.mul_apply]
    change (∑ g : E, ψ (κ g).1 (κ g).2 e *
      modeBlockMatrix κ Prod.fst Prod.snd small g h) = _
    rw [Fintype.sum_equiv κ
      (fun g : E => ψ (κ g).1 (κ g).2 e *
        modeBlockMatrix κ Prod.fst Prod.snd small g h)
      (fun m : P × D => ψ m.1 m.2 e *
        modeBlockMatrix κ Prod.fst Prod.snd small (κ.symm m) h)
      (by intro g; simp)]
    calc
      _ = ψ p d e * modeBlockMatrix κ Prod.fst Prod.snd small
          (κ.symm (p, d)) h := by
        apply Fintype.sum_eq_single (p, d)
        intro m hm
        by_cases hp : m.1 = p
        · have hd : m.2 ≠ d := by
            intro hmd
            apply hm
            exact Prod.ext hp hmd
          simp [hsupport m.1 m.2 e (Ne.symm (by simpa [d] using hd))]
        · simp [modeBlockMatrix, p, hp]
      _ = _ := by simp [modeBlockMatrix, p, d]
  rw [hleft, hright]
  exact mul_comm _ _

end Ising2DLambda.NecSuf.KacWard
