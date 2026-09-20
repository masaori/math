/-
具体版が必要十分版の整数点族への特殊化として得られることの導出。
-/
import Ising2DLambda.KacWard.TransverseTranslatedPeriodicPlaneLift

namespace Ising2DLambda.KacWard

/-- 横断平行移動後の座標等式を必要十分版から導いたもの。 -/
theorem transverseTranslatedPeriodicPlaneLift_coordinate_from_necSuf
    (m L : ℕ) (base : ℤ → ℤ × ℤ) (wv wh u k : ℤ) :
    windingTransverseCoordinate wh wv
        (transverseTranslatedPeriodicPlaneLift m L base wv wh u k) =
      windingTransverseCoordinate wh wv (periodicPlaneLift m base L wv wh k) +
        u * (wh ^ 2 + wv ^ 2) :=
  transverseTranslatedPeriodicPlaneLift_coordinate m L base wv wh u k

end Ising2DLambda.KacWard
