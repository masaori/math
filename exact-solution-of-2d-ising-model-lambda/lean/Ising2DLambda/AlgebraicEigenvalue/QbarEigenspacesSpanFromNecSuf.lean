/- 具体版が必要十分版の特殊化であることの導出。住処: Qbar。 -/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspacesSpan
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.QbarEigenspacesSpan

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 落とす写像の像の所属と復元式を、必要十分版へ供給する。 -/
theorem qbarEigenspaces_span_from_necSuf
    (L : ℕ) [NeZero L] [Fintype (RootOfUnity L)]
    (A : QbarRowMatrix L) (hA : qbarMatrixPow L A L = qbarIdentityMatrix L)
    (v : QbarRowVector L) :
    ∃ u : RootOfUnity L → QbarRowVector L,
      (∀ z, u z ∈ qbarEigenspace L A z.1) ∧ qbarVectorSum L Finset.univ u = v := by
  apply NecSuf.AlgebraicEigenvalue.finite_family_spans_necSuf
    (E := fun z : RootOfUnity L => qbarEigenspace L A z.1)
    (sum := qbarVectorSum L Finset.univ)
    v (fun z => qbarProjector L A z.1 v) (qbarVectorSmul L ((L : Qbar)⁻¹))
  · intro z
    exact qbarProjector_mem_eigenspace L A z.1 v hA z.2
  · intro z x hx
    exact qbarEigenspace_smul L A z.1 ((L : Qbar)⁻¹) x hx
  · exact qbarProjector_reconstruction L A v

end Ising2DLambda.AlgebraicEigenvalue
