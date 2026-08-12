/-
必要十分版の「写像の値による一意なラベル」を、周期トーラスの二つの巻き付き偶奇へ特殊化する。
-/
import Ising2DLambda.FisherZero.TorusHomologySector
import Ising2DLambda.NecSuf.FisherZero.TorusHomologySector

namespace Ising2DLambda.FisherZero

open Ising2DLambda.PartitionPolynomial

/-- 必要十分版から得る四セクターへの一意な所属。 -/
theorem torusHomologySector_unique_from_necSuf (L : ℕ) [NeZero L]
    (A : Finset (Edge L)) (hEven : IsEvenEdgeSubset L A) :
    ∃! sector : Fin 2 × Fin 2, IsInTorusHomologySector L A sector := by
  exact Ising2DLambda.NecSuf.FisherZero.admissible_fiber_label_unique_necSuf
    (IsEvenEdgeSubset L) (torusHomologySector L) A hEven

end Ising2DLambda.FisherZero
