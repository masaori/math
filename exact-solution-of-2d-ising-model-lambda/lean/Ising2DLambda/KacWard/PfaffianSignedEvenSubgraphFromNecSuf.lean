import Ising2DLambda.KacWard.PfaffianSignedEvenSubgraph
import Ising2DLambda.KacWard.PfaffianComplementFiberSumFromNecSuf
import Ising2DLambda.NecSuf.KacWard.PfaffianSignedEvenSubgraph

/-!
具体版 `gaugedPfaffian_eq_signedEvenSubgraphPolynomial`（`claim_pfaffian_signed_even_subgraph`）を、
一行目から四行目の導出版 `gaugedPfaffian_eq_seamSignedEvenSubgraphSum_from_necSuf` と、
必要十分版 `sum_sign_weights_eq_map_of_parity_agreement` を
補辺の集合 `𝒲_L`・偶奇の型 `ℕ`・送り元 `ℤ[X]`・送り先 `Qbar[X]`・係数の包含 `ℤ ↪ Qbar`・
切断線偶奇 `h(P), v(P)` と巻き付き偶奇 `ε_h(P), ε_v(P)`・重み `x^{|P|}` に特殊化して合成する導出版。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero
open scoped Classical

variable {L : ℕ} [NeZero L]

theorem gaugedPfaffian_eq_signedEvenSubgraphPolynomial_from_necSuf (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) :
    qbarPolynomialPfaffian (gaugedTerminalMatrix L z s) =
      (signedEvenSubgraphPolynomial L (spinComponentFin s.1) (spinComponentFin s.2)).map
        (Int.castRingHom Qbar) := by
  rw [gaugedPfaffian_eq_seamSignedEvenSubgraphSum_from_necSuf z hz s]
  have hgen := Ising2DLambda.NecSuf.KacWard.sum_sign_weights_eq_map_of_parity_agreement
    ((univ : Finset (Finset (Edge L))).filter (IsEvenEdgeSubset L))
    (Polynomial.mapRingHom (Int.castRingHom Qbar))
    (fun p q => qbarConst ((torusQuadraticSign s.1 s.2 (decide (p = 1)) (decide (q = 1)) : ℤ) : Qbar))
    (fun p q => ((-1 : Polynomial ℤ) ^ ((1 + s.1.toNat) * p + (1 + s.2.toNat) * q + p * q)))
    (fun P => (edgeSetSeamParities P).1) (fun P => (edgeSetSeamParities P).2)
    (fun P => (horizontalWindingParity L P : ℕ)) (fun P => (verticalWindingParity L P : ℕ))
    (fun P => (Polynomial.X : Polynomial ℤ) ^ P.card)
    (fun P _ => by
      have hh : (edgeSetSeamParities P).1 < 2 := Nat.mod_lt _ (by norm_num)
      have hv : (edgeSetSeamParities P).2 < 2 := Nat.mod_lt _ (by norm_num)
      simp only [torusQuadraticSign_eq_neg_one_pow _ _ _ _ hh hv, qbarConst]
      simp)
    (fun P _ => edgeSetHorizontalSeamParity_eq_windingParity P)
    (fun P _ => edgeSetVerticalSeamParity_eq_windingParity P)
  simp only [Polynomial.coe_mapRingHom, Polynomial.map_pow, Polynomial.map_X] at hgen
  refine hgen.trans ?_
  congr 1
  rw [signedEvenSubgraphPolynomial]
  apply Finset.sum_congr rfl
  intro P _
  rw [signedEvenSubgraphCoefficient, torusHomologySector, spinComponentFin_val, spinComponentFin_val]

end Ising2DLambda.KacWard
