import Ising2DLambda.KacWard.FourierModeIndexSet
import Ising2DLambda.NecSuf.KacWard.FourierModeIndexSet

namespace Ising2DLambda.KacWard

theorem fourierModeIndexSet_from_necSuf (L : ℕ) (s : SpinStructure) :
    fourierModeIndexSet L s =
      Ising2DLambda.NecSuf.KacWard.fourierModeIndexSet
        (horizontalTwistedModes L s) (verticalTwistedModes L s) := by
  rfl

end Ising2DLambda.KacWard
