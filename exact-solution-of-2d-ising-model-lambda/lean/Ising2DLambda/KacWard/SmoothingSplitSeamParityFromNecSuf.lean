/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.SmoothingSplitSeamParity
import Ising2DLambda.NecSuf.KacWard.SmoothingSplitSeamParity

namespace Ising2DLambda.KacWard

/-- 具体版が必要十分版の特殊化として得られることの記録。 -/
theorem smoothing_split_seam_parity_from_necSuf {L : ℕ}
    (horizontal vertical : OrientedEdge L → ℕ) (edge : ℕ → OrientedEdge L)
    (m k l : ℕ) (hkl : k < l) (hlm : l ≤ m) :
    (((∑ r ∈ Finset.Ioc k l, horizontal (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, horizontal (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, horizontal (edge r)) % 2) % 2,
      ((∑ r ∈ Finset.Ioc k l, vertical (edge r)) % 2
        + ((∑ r ∈ Finset.Ioc l m, vertical (edge r))
          + ∑ r ∈ Finset.Ioc 0 k, vertical (edge r)) % 2) % 2) =
    ((∑ r ∈ Finset.Ioc 0 m, horizontal (edge r)) % 2,
      (∑ r ∈ Finset.Ioc 0 m, vertical (edge r)) % 2) :=
  smoothing_split_seam_parity horizontal vertical edge m k l hkl hlm

end Ising2DLambda.KacWard
