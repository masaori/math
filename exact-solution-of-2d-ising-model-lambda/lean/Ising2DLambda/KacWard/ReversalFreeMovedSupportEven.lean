import Ising2DLambda.KacWard.Basic
import Ising2DLambda.FisherZero.EvenSubgraphSpinSum

namespace Ising2DLambda.KacWard

open Ising2DLambda.PartitionPolynomial Ising2DLambda.FisherZero

/-- 向き付き辺の始点。 -/
def orientedSource {L : ℕ} (e : OrientedEdge L) : Vertex L :=
  if e.2 then boundary1 L e.1 else boundary0 L e.1

/-- 向き付き辺の終点。 -/
def orientedTarget {L : ℕ} (e : OrientedEdge L) : Vertex L :=
  if e.2 then boundary0 L e.1 else boundary1 L e.1

end Ising2DLambda.KacWard
