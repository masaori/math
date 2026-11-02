import Ising2DLambda.KacWard.TerminalMatrix

namespace Ising2DLambda.KacWard

/-- 実際の二辺の方向番号で定める一歩の整数回転数。
後続辺でない組への値は全域化のための零である。 -/
def stepTurning {L : ℕ} (e f : OrientedEdge L) : ℤ :=
  if f ∈ nonbacktrackingSuccessors e then
    if directionNumber f = directionNumber e then 0
    else if directionNumber f = directionNumber e + 1 then 1
    else if directionNumber f = directionNumber e - 1 then -1
    else 0
  else 0

end Ising2DLambda.KacWard
