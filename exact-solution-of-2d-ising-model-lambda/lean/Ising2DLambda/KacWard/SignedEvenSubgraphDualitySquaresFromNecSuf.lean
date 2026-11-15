import Ising2DLambda.KacWard.SignedEvenSubgraphDualitySquares
import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualitySquares
import Ising2DLambda.KacWard.DispersionDualityFiniteProductFromNecSuf

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue

/-- The abstract square argument specializes to the actual torus polynomial. -/
theorem signedEvenSubgraphDuality_squares_from_necSuf (L : ℕ) [NeZero L]
    (z : Qbar) (hz : z ^ 4 = -1) (s : SpinStructure) :
    (signedEvenSubgraphDualityCleared L (spinComponentFin s.1)
      (spinComponentFin s.2)) ^ 2 =
      (2 ^ (L ^ 2) *
        (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
          (spinComponentFin s.2)).map (Int.castRingHom Qbar)) ^ 2 := by
  let q : QbarPoly :=
    (signedEvenSubgraphPolynomial L (spinComponentFin s.1)
      (spinComponentFin s.2)).map (Int.castRingHom Qbar)
  let d : QbarPoly := kacWardDeterminant (kacWardTransitionMatrix L z s)
  let f : QbarPoly := signedEvenSubgraphDualityCleared L
    (spinComponentFin s.1) (spinComponentFin s.2)
  have hinf : Set.Infinite {x : Qbar | 1 + x ≠ 0} := by
    have h : ({(-1 : Qbar)} : Set Qbar).Finite := Set.finite_singleton _
    have heq : {x : Qbar | 1 + x ≠ 0} = ({(-1 : Qbar)} : Set Qbar)ᶜ := by
      ext x
      simp only [Set.mem_setOf_eq, Set.mem_compl_iff, Set.mem_singleton_iff]
      constructor
      · intro hx heq
        subst x
        exact hx (by ring)
      · intro hx hzero
        apply hx
        linear_combination hzero
    rw [heq]
    exact h.infinite_compl
  exact Ising2DLambda.NecSuf.KacWard.duality_squares
    (ι := FourierModePair L s) (L ^ 2) q d f
    Ising2DLambda.FisherZero.kwDualTransform (fun x => 1 + x ≠ 0)
    hinf (fourierModePair_card_eq L s)
    (kacWardDeterminant_eq_signedEvenSubgraphPolynomial_sq z hz s)
    (fun x hx => by
      exact signedEvenSubgraphDualityCleared_eval L (spinComponentFin s.1)
        (spinComponentFin s.2) x hx)
    (fun x hx => dispersion_mode_product_duality_factor_from_necSuf z x hz s hx)

end Ising2DLambda.KacWard
