/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.DirectionGateCrossingTurning
import Ising2DLambda.NecSuf.KacWard.DirectionAxis

namespace Ising2DLambda.KacWard

theorem directionAxis_from_necSuf (d : ZMod 4) :
    directionAxis d = Ising2DLambda.NecSuf.KacWard.residueAxis 2 d := rfl

end Ising2DLambda.KacWard
