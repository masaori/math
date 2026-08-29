/- 必要十分版: 二元集合の四場合だけから Arf--Fourier 符号射影を示す。 -/
import Mathlib.Data.Int.Basic

namespace Ising2DLambda.NecSuf.KacWard

def quadraticParity (a b h v : Bool) : Bool :=
  Bool.xor (Bool.xor (h && v) ((!a) && h)) ((!b) && v)

def arfParity (a b : Bool) : Bool := (!a) && (!b)

def sign (b : Bool) : ℤ := if b then -1 else 1

theorem arfFourierSignProjection_necSuf (h v : Bool) :
    sign (arfParity false false) * sign (quadraticParity false false h v) +
    sign (arfParity false true) * sign (quadraticParity false true h v) +
    sign (arfParity true false) * sign (quadraticParity true false h v) +
    sign (arfParity true true) * sign (quadraticParity true true h v) = 2 := by
  cases h <;> cases v <;> decide

end Ising2DLambda.NecSuf.KacWard
