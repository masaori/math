import Mathlib.Logic.Function.Iterate

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 本文と同じ八等号。単射な自己写像だけを用い、有限性・全射性・順序は不要。
全ての回数での単射性を要求すれば一回の反復も含むので、元の写像の単射性は必要である。 -/
theorem iterate_injective_necSuf {J : Type*}
    (f : J → J) (hf : Function.Injective f) (n : ℕ) :
    Function.Injective (f^[n]) := by
  induction n with
  | zero =>
    intro i j hij
    calc
      i = f^[0] i := rfl
      _ = f^[0] j := hij
      _ = j := rfl
  | succ n ih =>
    intro i j hij
    have hiter : f^[n] (f i) = f^[n] (f j) := by
      calc
        f^[n] (f i) = f^[n + 1] i := rfl
        _ = f^[n + 1] j := hij
        _ = f^[n] (f j) := rfl
    have himage : f i = f j := ih hiter
    calc
      i = j := hf himage

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
