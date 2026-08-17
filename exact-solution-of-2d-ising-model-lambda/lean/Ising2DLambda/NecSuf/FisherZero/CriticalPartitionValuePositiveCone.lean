/- 「非空な有限和は、一つ目が正で残りが零または正なら正である」の必要十分版。
   必要なのは右零元、正な二元の加法閉性、各項の二分だけである。 -/
import Mathlib.Data.Set.Defs
import Mathlib.Data.Nat.Basic

namespace Ising2DLambda.NecSuf.FisherZero

def nonemptyPartialSum {X : Type*} (add : X → X → X) (f : ℕ → X) : ℕ → X
  | 0 => f 0
  | n + 1 => add (nonemptyPartialSum add f n) (f (n + 1))

theorem nonempty_sum_mem_positive_necSuf {X : Type*} (P : Set X)
    (add : X → X → X) (f : ℕ → X) (z : X)
    (haddZero : ∀ x : X, add x z = x)
    (hadd : ∀ x y : X, x ∈ P → y ∈ P → add x y ∈ P)
    (hfirst : f 0 ∈ P)
    (hterm : ∀ n : ℕ, f (n + 1) = z ∨ f (n + 1) ∈ P) :
    ∀ n : ℕ, nonemptyPartialSum add f n ∈ P := by
  intro n
  induction n with
  | zero => exact hfirst
  | succ n ih =>
      rw [nonemptyPartialSum]
      rcases hterm n with hz | hp
      · rw [hz, haddZero]
        exact ih
      · exact hadd _ _ ih hp

end Ising2DLambda.NecSuf.FisherZero
