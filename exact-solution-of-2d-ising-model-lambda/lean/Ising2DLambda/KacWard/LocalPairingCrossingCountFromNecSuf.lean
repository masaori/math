import Ising2DLambda.KacWard.LocalPairingCrossingCount
import Ising2DLambda.KacWard.LocalPairingSignedSumFromNecSuf
import Ising2DLambda.KacWard.LocalPairingTaggedMatchingCorrespondenceFromNecSuf
import Ising2DLambda.NecSuf.KacWard.LocalPairingCrossingCount

/-!
具体版 `shortPairCrossingNumber_eq_localPairingCrossingCount` を、必要十分版を半辺 `OrientedEdge L`・
頂点 `Vertex L`・対の集合 `t`・頂点 `orientedSource p.1`・横断 `shortPairsTransverse`・
頂点の数 `localPairingCrossingIndicator` に特殊化して得る導出版と、それを使った
`claim_local_pairing_signed_sum` の二つ目の等式の導出版。
-/

namespace Ising2DLambda.KacWard

open Finset Ising2DLambda.AlgebraicEigenvalue Ising2DLambda.PartitionPolynomial
  Ising2DLambda.TransferMatrix Ising2DLambda.FisherZero
open scoped Classical

variable {L : ℕ} [NeZero L]

theorem shortPairCrossingNumber_eq_localPairingCrossingCount_from_necSuf {z : Qbar}
    {s : SpinStructure} {D : PerfectMatching (OrientedEdge L)}
    {t : Finset (OrientedEdge L × OrientedEdge L)} (P : Finset (Edge L))
    (ht : t ⊆ matchingOrientedPairs D)
    (hterm : matchingSignPolynomial D *
      ((-1 : Polynomial Qbar) ^ t.card *
        (∏ p ∈ matchingOrientedPairs D \ t, gaugedLongContribution z s p) *
        (∏ p ∈ t, gaugedShortContribution z s p)) ≠ 0)
    (hP : taggedComplementEdges D t = P)
    (κ : Vertex L → Fin 4 → Fin 4) (hκ : κ ∈ vertexLocalPairingChoices P)
    (hmate : ∀ v i, i ∈ selectedPortNumbers P v →
      perfectMatchingMate D (portEquiv.symm (v, i)) = portEquiv.symm (v, κ v i)) :
    shortPairCrossingNumber t = localPairingCrossingCount P κ := by
  subst hP
  unfold shortPairCrossingNumber localPairingCrossingCount
  refine Ising2DLambda.NecSuf.KacWard.crossing_pair_count_eq_vertex_sum t
    (fun p => orientedSource p.1) shortPairsTransverse
    (fun v => localPairingCrossingIndicator (selectedPortNumbers _ v) (κ v))
    (fun _ _ h => edgeTransverseCrossing_symm h)
    (fun p q h => by
      have h₃ := h.2.2.1
      rw [orientedTarget_reversal, orientedTarget_reversal] at h₃
      exact h₃)
    (fun v => by
      unfold localPairingCrossingIndicator
      split_ifs <;> simp)
    (fun v hv p hp q hq hpv => shortPairs_not_transverse_of_noncrossing ht hterm κ hκ hmate v
      (by
        intro hc
        simp [localPairingCrossingIndicator, hc] at hv) p hp q hq hpv)
    (fun v hv => vertexShortPairs_of_crossing ht hterm κ hκ hmate v
      (by
        unfold localPairingCrossingIndicator at hv
        split_ifs at hv with hc
        · exact hc))

theorem nonzeroTaggedMatchings_signed_crossing_sum_eq_one_from_necSuf (z : Qbar)
    (hz : z ^ (4 : ℕ) = -1) (s : SpinStructure) (P : Finset (Edge L))
    (hP : IsEvenEdgeSubset L P) :
    ∑ x ∈ nonzeroTaggedMatchings z s P, (-1 : ℤ) ^ shortPairCrossingNumber x.2 = 1 := by
  rw [nonzeroTaggedMatchings_sum_eq_localPairing_sum_from_necSuf z hz s P _
    (fun κ => (-1 : ℤ) ^ localPairingCrossingCount P κ)]
  · exact localPairingFamilies_signed_sum_eq_one_from_necSuf P hP
  · intro κ hκ
    obtain ⟨_, ht, hterm, hP'⟩ :=
      Finset.mem_filter.mp (localPairingTaggedMatching_mem z hz s P κ hκ)
    rw [shortPairCrossingNumber_eq_localPairingCrossingCount_from_necSuf P ht hterm hP' κ hκ
      (localPairingTaggedMatching_mate P κ hκ)]

end Ising2DLambda.KacWard
