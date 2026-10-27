/- claim_fourier_similarity_preserves_determinant の具体版。 -/
import Ising2DLambda.KacWard.PolynomialFourierSimilarity
import Ising2DLambda.KacWard.GaugedTerminalMatrixDeterminant

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

theorem fourier_similarity_preserves_determinant {L : ℕ} [NeZero L]
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
  -- 本文の det(F) det(G) = det(FG) = det(I) = 1。
  have hdetFG : Matrix.det F * Matrix.det G = 1 := by
    calc
      Matrix.det F * Matrix.det G = Matrix.det (F * G) :=
        (qbarPolynomial_det_mul F G).symm
      _ = Matrix.det (1 : Matrix (OrientedEdge L) (OrientedEdge L) QbarPoly) :=
        congrArg Matrix.det hFG
      _ = 1 := polynomialOrientedIdentity_determinant L
  -- 本文の相似等式、二回の乗法性、行列式の積の相殺。
  calc
    kacWardDeterminant (kacWardTransitionMatrix L z s) = Matrix.det (F * T * G) := by
      exact congrArg Matrix.det (polynomial_fourier_similarity z s κ)
    _ = Matrix.det (F * T) * Matrix.det G :=
      qbarPolynomial_det_mul (F * T) G
    _ = (Matrix.det F * Matrix.det T) * Matrix.det G := by
      rw [qbarPolynomial_det_mul F T]
    _ = Matrix.det F * (Matrix.det T * Matrix.det G) := mul_assoc _ _ _
    _ = Matrix.det F * (Matrix.det G * Matrix.det T) :=
      congrArg (Matrix.det F * ·) (mul_comm _ _)
    _ = (Matrix.det F * Matrix.det G) * Matrix.det T := (mul_assoc _ _ _).symm
    _ = 1 * Matrix.det T := by rw [hdetFG]
    _ = Matrix.det T := one_mul _

end Ising2DLambda.KacWard
