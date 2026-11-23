/- 辺列に沿うねじれ符号の積の具体版が、必要十分版の特殊化として得られることの記録。 -/
import Ising2DLambda.KacWard.WalkTwistSign
import Ising2DLambda.NecSuf.KacWard.WalkTwistSign

namespace Ising2DLambda.KacWard

theorem edgeSequenceSeamParities_from_necSuf {L : ℕ}
    (walk : List (OrientedEdge L)) :
    edgeSequenceSeamParities walk =
      Ising2DLambda.NecSuf.KacWard.edgeSequenceSeamParities
        horizontalSeamParity verticalSeamParity walk := rfl

theorem walkTwistSign_product_from_necSuf {L : ℕ} (a b : Bool)
    (horizontal vertical : OrientedEdge L → Bool) (walk : List (OrientedEdge L)) :
    (walk.map (Ising2DLambda.NecSuf.KacWard.twistSign a b horizontal vertical)).prod =
      Ising2DLambda.NecSuf.KacWard.boolSign
        (Bool.xor
          (a && Ising2DLambda.NecSuf.KacWard.parity horizontal walk)
          (b && Ising2DLambda.NecSuf.KacWard.parity vertical walk)) :=
  Ising2DLambda.NecSuf.KacWard.walkTwistSign_product_necSuf a b horizontal vertical walk

end Ising2DLambda.KacWard
