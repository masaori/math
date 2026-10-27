import Mathlib
import Ising2DLambda.KacWard.TransitionFourierIntertwining
import Ising2DLambda.KacWard.TwistedFourierRightInverse
import Ising2DLambda.KacWard.DeterminantConstantTerm

namespace Ising2DLambda.KacWard
open Ising2DLambda.AlgebraicEigenvalue

theorem polynomial_fourier_similarity {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    kacWardPolynomialMatrix (kacWardTransitionMatrix L z s) =
      (twistedFourierMatrix s κ).map Polynomial.C *
        (1 - (Polynomial.X : QbarPoly) • (modeBlockMatrix z s κ).map Polynomial.C) *
          (twistedFourierInverseCandidate s κ).map Polynomial.C := by
  classical
  let M := kacWardTransitionMatrix L z s
  let F := twistedFourierMatrix s κ
  let B := modeBlockMatrix z s κ
  let G := twistedFourierInverseCandidate s κ
  have hMF : M * F = F * B := transition_fourier_intertwining z s κ
  have hFG : F * G = 1 := twistedFourier_rightInverse s κ
  have hMFP : M.map Polynomial.C * F.map Polynomial.C =
      F.map Polynomial.C * B.map Polynomial.C := by
    simpa only [Matrix.map_mul] using congrArg (fun A : Matrix (OrientedEdge L) (OrientedEdge L) Qbar => A.map Polynomial.C) hMF
  have hFGP : F.map Polynomial.C * G.map Polynomial.C = 1 := by
    simpa [Matrix.map_mul] using congrArg (fun A : Matrix (OrientedEdge L) (OrientedEdge L) Qbar => A.map Polynomial.C) hFG
  change 1 - (Polynomial.X : QbarPoly) • M.map Polynomial.C = _
  calc
    1 - (Polynomial.X : QbarPoly) • M.map Polynomial.C =
        F.map Polynomial.C * G.map Polynomial.C -
          (Polynomial.X : QbarPoly) • (M.map Polynomial.C * (F.map Polynomial.C * G.map Polynomial.C)) := by rw [hFGP]; simp
    _ = F.map Polynomial.C * G.map Polynomial.C -
          (Polynomial.X : QbarPoly) • ((M.map Polynomial.C * F.map Polynomial.C) * G.map Polynomial.C) := by rw [mul_assoc]
    _ = F.map Polynomial.C * G.map Polynomial.C -
          (Polynomial.X : QbarPoly) • ((F.map Polynomial.C * B.map Polynomial.C) * G.map Polynomial.C) := by rw [hMFP]
    _ = F.map Polynomial.C * (1 - (Polynomial.X : QbarPoly) • B.map Polynomial.C) * G.map Polynomial.C := by
      simp [mul_sub, sub_mul, mul_assoc]
end Ising2DLambda.KacWard
