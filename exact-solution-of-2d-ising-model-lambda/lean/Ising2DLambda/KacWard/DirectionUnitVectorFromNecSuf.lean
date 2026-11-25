/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DirectionUnitVector
import Ising2DLambda.NecSuf.KacWard.DirectionUnitVector

namespace Ising2DLambda.KacWard

theorem directionUnitVector_from_necSuf (d : ZMod 4) :
    directionUnitVector d =
      Ising2DLambda.NecSuf.KacWard.directionUnitVector
        (0, 1) (1, 0) (0, -1) (-1, 0) d := rfl

end Ising2DLambda.KacWard
