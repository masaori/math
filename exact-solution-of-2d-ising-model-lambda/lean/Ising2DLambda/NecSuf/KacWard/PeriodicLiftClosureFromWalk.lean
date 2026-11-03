import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.KacWard

/-- 四つの有限列を、共有する境界の添字を一度だけ使って並べる。 -/
def fourPartClosure {X : Type*} (h p : ℕ)
    (first second third fourth : ℕ → X) : Fin (2 * h + 2 * p + 1) → X :=
  fun j =>
    if j.val ≤ h then first j.val
    else if j.val ≤ h + p then second (j.val - h)
    else if j.val ≤ 2 * h + p then third (j.val - h - p)
    else fourth (j.val - 2 * h - p)

end Ising2DLambda.NecSuf.KacWard
