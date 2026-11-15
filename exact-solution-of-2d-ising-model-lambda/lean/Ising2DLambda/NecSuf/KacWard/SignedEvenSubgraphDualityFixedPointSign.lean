import Ising2DLambda.NecSuf.KacWard.SignedEvenSubgraphDualityUpToSign
import Mathlib.Algebra.Polynomial.Eval.Defs

namespace Ising2DLambda.NecSuf.KacWard

/-- An evaluation fixed by the duality selects the positive branch when it is nonzero. -/
theorem duality_fixed_point_positive_sign {R : Type*}
    [CommRing R] [NoZeroDivisors R] [CharZero R]
    (f q : Polynomial R) (x : R) (hsign : f = q ∨ f = -q)
    (heval : f.eval x = q.eval x) (hq : q.eval x ≠ 0) : f = q := by
  rcases hsign with hpos | hneg
  · exact hpos
  · have hsame : q.eval x = -q.eval x := by
      calc
        q.eval x = f.eval x := heval.symm
        _ = (-q).eval x := congrArg (fun p : Polynomial R => p.eval x) hneg
        _ = -q.eval x := by simp
    -- Cancellation needs characteristic zero and absence of zero divisors.
    have htwo : (2 : R) * q.eval x = 0 := by
      calc
        (2 : R) * q.eval x = q.eval x - (-q.eval x) := by ring
        _ = 0 := sub_eq_zero.mpr hsame
    exact False.elim (hq ((mul_eq_zero.mp htwo).resolve_left (by norm_num)))

end Ising2DLambda.NecSuf.KacWard
