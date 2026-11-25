/- 具体版が必要十分版の特殊化として得られることの導出。 -/
import Ising2DLambda.KacWard.PrimitiveIntegerPair
import Ising2DLambda.NecSuf.KacWard.PrimitiveIntegerPair

namespace Ising2DLambda.KacWard

theorem primitiveIntegerPair_from_necSuf (a b : ℤ) :
    primitiveIntegerPair a b ↔
      Ising2DLambda.NecSuf.KacWard.primitivePair Int.gcd a b := Iff.rfl

end Ising2DLambda.KacWard
