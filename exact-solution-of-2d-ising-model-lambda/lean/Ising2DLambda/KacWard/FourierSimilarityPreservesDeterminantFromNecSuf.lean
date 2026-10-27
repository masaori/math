/- claim_fourier_similarity_preserves_determinant の必要十分版に実際の Fourier 行列を渡す。 -/
import Ising2DLambda.KacWard.FourierSimilarityPreservesDeterminant
import Ising2DLambda.NecSuf.KacWard.FourierSimilarityPreservesDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem fourier_similarity_preserves_determinant_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (s : SpinStructure)
    (κ : OrientedEdge L ≃ {m // m ∈ fourierModeIndexSet L s}) :
    kacWardDeterminant (kacWardTransitionMatrix L z s) =
      Matrix.det (1 - (Polynomial.X : QbarPoly) •
        (modeBlockMatrix z s κ).map Polynomial.C) := by
  classical
  let F := (twistedFourierMatrix s κ).map Polynomial.C
  let G := (twistedFourierInverseCandidate s κ).map Polynomial.C
  let T : Matrix (OrientedEdge L) (OrientedEdge L) QbarPoly :=
    1 - (Polynomial.X : QbarPoly) • (modeBlockMatrix z s κ).map Polynomial.C
  letI : Nonempty (OrientedEdge L) := by
    change Nonempty (Fin (2 * L ^ 2) × Bool)
    exact ⟨(⟨0, by have := NeZero.pos L; positivity⟩, false)⟩
  have hFG : F * G = 1 := by
    simpa [F, G, Matrix.map_mul] using
      congrArg (fun A : Matrix (OrientedEdge L) (OrientedEdge L) Qbar =>
        A.map Polynomial.C) (twistedFourier_rightInverse s κ)
  have hdetMul (A B : Matrix (OrientedEdge L) (OrientedEdge L) QbarPoly) :
      Matrix.det (A * B) = Matrix.det A * Matrix.det B := qbarPolynomial_det_mul A B
  calc
    kacWardDeterminant (kacWardTransitionMatrix L z s) = Matrix.det (F * T * G) :=
      congrArg Matrix.det (polynomial_fourier_similarity z s κ)
    _ = Matrix.det T :=
      NecSuf.KacWard.similarity_preserves_determinant_necSuf F T G hFG hdetMul
        (polynomialOrientedIdentity_determinant L)

end Ising2DLambda.KacWard
