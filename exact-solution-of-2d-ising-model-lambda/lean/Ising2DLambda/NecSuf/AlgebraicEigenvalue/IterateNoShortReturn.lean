import Mathlib.Data.Set.Function
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationAdd
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.IterationInjective
import Mathlib.Order.Interval.Set.Defs
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-- 同じ差の論法。有限性、全射性、逆写像、帰還の存在は不要である。 -/
theorem iterate_injOn_of_no_short_return_necSuf {J : Type*}
    (f : J → J) (hf : Function.Injective f) (i : J) (p : ℕ)
    (hmin : ∀ n : ℕ, 0 < n → f^[n] i = i → p ≤ n) :
    Set.InjOn (fun n : ℕ => f^[n] i) (Set.Iio p) := by
  intro r hr t ht heq
  have no_lt (a b : ℕ) (hab : a < b) (hb : b < p)
      (hcollision : f^[a] i = f^[b] i) : False := by
    let d := b - a
    have hdpos : 0 < d := by dsimp [d]; omega
    have hsum : a + d = b := by dsimp [d]; omega
    have hdb : d ≤ b := Nat.sub_le b a
    have hdp : d < p := lt_of_le_of_lt hdb hb
    have hcomp : f^[a] (f^[d] i) = f^[a] i := by
      calc
        f^[a] (f^[d] i) = f^[a + d] i := (iterate_add_necSuf f a d i).symm
        _ = f^[b] i := congrArg (fun k : ℕ => f^[k] i) hsum
        _ = f^[a] i := hcollision.symm
    have hreturn : f^[d] i = i := iterate_injective_necSuf f hf a hcomp
    have hminimal : p ≤ d := hmin d hdpos hreturn
    exact (not_le_of_gt hdp) hminimal
  rcases lt_trichotomy r t with h | h | h
  · exact (no_lt r t h ht heq).elim
  · exact h
  · exact (no_lt t r h hr heq.symm).elim

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
