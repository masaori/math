/- 必要十分版を `Qbar` 係数・`σ = Fin d`・`ι = Fin N` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.PairShiftElementarySymmetric
import Ising2DLambda.NecSuf.FisherZero.PairShiftElementarySymmetric

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_pair_shift_elementary_symmetric_is_symmetric` を必要十分版から得る。
`K = Qbar`、`σ = Fin d`、`ι = Fin N`。 -/
theorem pairShiftElementarySymmetric_isQbarSymmetric_from_necSuf {d N : ℕ} (c : Qbar)
    (π : Fin N ≃ RootIndexPair d) (k : ℕ) :
    IsQbarSymmetric (qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k)) := fun ϱ =>
  Ising2DLambda.NecSuf.FisherZero.pairShiftElementarySymmetric_equivInvariant_necSuf c π ϱ k

/-- `claim_pair_shift_elementary_symmetric_subfield_coefficient` を必要十分版から得る
（`S = F`）。 -/
theorem pairShiftElementarySymmetric_mem_subfieldCoefficientMvPolys_from_necSuf
    (F : Subfield Qbar) {d N : ℕ} {c : Qbar} (hc : c ∈ F) (π : Fin N ≃ RootIndexPair d) (k : ℕ) :
    qbarMvSubst (pairShiftValues c π) (qbarElementarySymmetric N k) ∈
      subfieldCoefficientMvPolys F d :=
  Ising2DLambda.NecSuf.FisherZero.pairShiftElementarySymmetric_mem_coeffIn_necSuf F.zero_mem
    F.one_mem (fun _ _ hx hy => F.add_mem hx hy) (fun _ _ hx hy => F.mul_mem hx hy) hc π k

end Ising2DLambda.FisherZero
