import Ising2DLambda.KacWard.LocalPairingSignedSum
import Ising2DLambda.NecSuf.KacWard.LocalPairingSignedSum

/-!
具体版 `localPairingFamilies_signed_sum_eq_one` を、必要十分版を頂点集合 `Vertex L`・
値の環 `ℤ`・選択集合 `selectedPortNumbers P` に特殊化して得る導出版。
-/

namespace Ising2DLambda.KacWard

open Ising2DLambda.FisherZero Ising2DLambda.PartitionPolynomial

theorem localPairingFamilies_signed_sum_eq_one_from_necSuf {L : ℕ} [NeZero L]
    (P : Finset (Edge L)) (hP : IsEvenEdgeSubset L P) :
    ∑ κ ∈ vertexLocalPairingChoices P,
      (-1 : ℤ) ^ localPairingCrossingCount P κ = 1 :=
  Ising2DLambda.NecSuf.KacWard.localPairingFamilies_signed_sum_eq_one
    (fun v => selectedPortNumbers P v) (selectedPortNumbers_card_cases P hP)

end Ising2DLambda.KacWard
