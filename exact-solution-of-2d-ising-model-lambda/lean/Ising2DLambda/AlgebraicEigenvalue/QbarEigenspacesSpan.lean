/-
「シフト行列の固有空間たちは列ベクトルの全体を張る」の具体版。
人手証明どおり、落とす写像の像の固有空間への所属と復元式を組み合わせる。
住処: Qbar。ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarEigenspace
import Ising2DLambda.AlgebraicEigenvalue.QbarProjectorEigenspace
import Ising2DLambda.AlgebraicEigenvalue.QbarProjectorReconstruction

namespace Ising2DLambda.AlgebraicEigenvalue

open Finset Ising2DLambda.TransferMatrix

/-- 各 `L` 乗根に対応する固有空間から一つずつ取った列ベクトルの和として任意の列ベクトルを書ける。 -/
theorem qbarEigenspaces_span (L : ℕ) [NeZero L] [Fintype (RootOfUnity L)]
    (A : QbarRowMatrix L) (hA : qbarMatrixPow L A L = qbarIdentityMatrix L)
    (v : QbarRowVector L) :
    ∃ u : RootOfUnity L → QbarRowVector L,
      (∀ z, u z ∈ qbarEigenspace L A z.1) ∧ qbarVectorSum L Finset.univ u = v := by
  let u : RootOfUnity L → QbarRowVector L := fun z =>
    qbarVectorSmul L ((L : Qbar)⁻¹) (qbarProjector L A z.1 v)
  refine ⟨u, ?_, ?_⟩
  · intro z
    exact qbarEigenspace_smul L A z.1 ((L : Qbar)⁻¹) (qbarProjector L A z.1 v)
      (qbarProjector_mem_eigenspace L A z.1 v hA z.2)
  · exact qbarProjector_reconstruction L A v

end Ising2DLambda.AlgebraicEigenvalue
