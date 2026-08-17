/-
「実閉部分体の二つの平方の和が零なら、両方が零である」の必要十分版。

部分体も一意表示も、この段では本質でない。効いているのは
「`ω*ω = -1` の体では `x*x + y*y = (x + yω)(x - yω)` であり、零因子が無いので
どちらかの因子が零である」ことだけで、必要なのは可換な整域である。
（本文はこのあと一意表示を当てて `x = y = 0` を出す。そこだけが部分体の性質を使う。）
-/
import Mathlib.Algebra.Ring.Basic
import Mathlib.Algebra.GroupWithZero.Basic
import Mathlib.Tactic.Ring

namespace Ising2DLambda.NecSuf.FisherZero

theorem sq_add_sq_eq_zero_factor_necSuf {R : Type*} [CommRing R] [IsDomain R]
    (ω x y : R) (hω : ω * ω = -1) (h : x * x + y * y = 0) :
    x + y * ω = 0 ∨ x - y * ω = 0 := by
  have hfac : (x + y * ω) * (x - y * ω) = 0 := by
    calc (x + y * ω) * (x - y * ω)
        = x * x - y * y * (ω * ω) := by ring
      _ = x * x - y * y * (-1) := by rw [hω]
      _ = x * x + y * y := by ring
      _ = 0 := h
  exact mul_eq_zero.mp hfac

end Ising2DLambda.NecSuf.FisherZero
