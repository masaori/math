import Mathlib.Logic.Function.Iterate

namespace Ising2DLambda.NecSuf.AlgebraicEigenvalue

/-
反復の対応に要るのは、各枝を進んでもその枝の条件が保たれることと、
その条件の下での一歩の一致だけである。有限性・可逆性・述語の判定は使わない。
-/
theorem piecewise_iterate_necSuf {α : Type*} (p : α → Prop) (f g r : α → α)
    (hg : ∀ i, p i → p (g i)) (hf : ∀ i, ¬ p i → ¬ p (f i))
    (hrg : ∀ i, p i → r i = g i) (hrf : ∀ i, ¬ p i → r i = f i)
    (n : ℕ) (i : α) :
    (p i → r^[n] i = g^[n] i) ∧ (¬ p i → r^[n] i = f^[n] i) := by
  induction n generalizing i with
  | zero =>
    constructor
    · intro _
      calc
        r^[0] i = i := rfl
        _ = g^[0] i := rfl
    · intro _
      calc
        r^[0] i = i := rfl
        _ = f^[0] i := rfl
  | succ n ih =>
    constructor
    · intro hi
      have hgi : p (g i) := hg i hi
      calc
        r^[n + 1] i = r^[n] (r i) := rfl
        _ = r^[n] (g i) := congrArg r^[n] (hrg i hi)
        _ = g^[n] (g i) := (ih (g i)).1 hgi
        _ = g^[n + 1] i := rfl
    · intro hi
      have hfi : ¬ p (f i) := hf i hi
      calc
        r^[n + 1] i = r^[n] (r i) := rfl
        _ = r^[n] (f i) := congrArg r^[n] (hrf i hi)
        _ = f^[n] (f i) := (ih (f i)).2 hfi
        _ = f^[n + 1] i := rfl

end Ising2DLambda.NecSuf.AlgebraicEigenvalue
