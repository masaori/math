import Ising2DLambda.KacWard.DeterminantSquareRootTorusFormula
import Ising2DLambda.NecSuf.KacWard.DeterminantSquareRootTorusFormula

/-!
具体版 `partitionPolynomial_eq_half_sum_kacWardSquareRoots`
（`claim_determinant_square_root_torus_formula`）を、必要十分版 `eq_half_sum_squareRoots_necSuf` の
特殊化として得る導出版。`ι = 𝒮`（`SpinStructure`）、`P = Qbar[x]`、`c = coeff 0`、
`D = D^{a,b}_L`、`Q = Q^{a,b}_L` を係数ごとに送ったもの、`Z = Z_L` を係数ごとに送ったもの、
`two = 2`、`half = C (1/2)` と置く。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial

theorem partitionPolynomial_eq_half_sum_kacWardSquareRoots_from_necSuf {L : ℕ} [NeZero L]
    (z : Qbar) (hz : z ^ (4 : ℕ) = -1) (S : SpinStructure → QbarPoly)
    (hS : ∀ s : SpinStructure,
      qbarPolynomialSquareRoot (kacWardDeterminant (kacWardTransitionMatrix L z s)) (S s)) :
    (partitionPolynomial L).map (Int.castRingHom Qbar) =
      Polynomial.C (1 / 2 : Qbar) * ∑ s : SpinStructure, S s :=
  Ising2DLambda.NecSuf.KacWard.eq_half_sum_squareRoots_necSuf
    (fun p : QbarPoly => p.coeff 0)
    (fun s => kacWardDeterminant (kacWardTransitionMatrix L z s))
    (fun s => (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
      (Int.castRingHom Qbar))
    S _ 2 (Polynomial.C (1 / 2 : Qbar))
    (by rw [← Polynomial.C_ofNat, ← Polynomial.C_mul]; norm_num)
    (finiteTorusPolynomial_map_qbar L)
    (fun s => (kacWardDeterminant_qbarPolynomialSquareRoot z hz s).1)
    (fun s => (kacWardDeterminant_qbarPolynomialSquareRoot z hz s).2)
    (fun s => (hS s).1) (fun s => (hS s).2)
    (fun A B hA hB h => qbarPolynomialSquareRoot_unique A B hA hB h)

end Ising2DLambda.KacWard
