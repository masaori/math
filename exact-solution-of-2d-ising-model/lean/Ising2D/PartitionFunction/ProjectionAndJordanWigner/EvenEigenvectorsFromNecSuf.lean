/-
# `𝓕^{(+)}` の複素部分加群 — 具体版を必要十分版の特殊化として導出する

対応する人手証明のラベル: `even_eigenspace_is_complex_subspace`。

具体版 `Ising2D.evenEigenspace`（零・和・複素スカラー倍の閉性は `zero_mem_evenEigenvectors`・
`add_mem_evenEigenvectors`・`smul_mem_evenEigenvectors`）は
`Ising2D/PartitionFunction/ProjectionAndJordanWigner/EvenEigenvectors.lean` にあり、必要十分版
`Ising2D.NecSuf.fixedSubmodule`（閉性は `NecSuf.zero_mem_fixedVectors`・`NecSuf.add_mem_fixedVectors`・
`NecSuf.smul_mem_fixedVectors`）は `Ising2D/NecSuf/FixedVectorsSubmodule.lean` にある。
両版の零・和・スカラー倍の段は同じ順に対応する。
-/
import Ising2D.NecSuf.FixedVectorsSubmodule
import Ising2D.PartitionFunction.ProjectionAndJordanWigner.EvenEigenvectors

namespace Ising2D

/-- 具体版 `evenEigenspace` は必要十分版 `NecSuf.fixedSubmodule` を `R=ℂ`、`ι=Conf M`、`A=epsilon M` とした
特殊化である。 -/
theorem evenEigenspace_eq_fixedSubmodule (M : ℕ) (hM : 1 ≤ M) :
    evenEigenspace M hM = NecSuf.fixedSubmodule (epsilon M) := by
  apply Submodule.ext
  intro f
  rfl

end Ising2D
