/-
有限集合の和の帰納法の一歩に必要十分な形。
区別した一点では値が高々 1 増え、残りの各点では増えず、移行後の和が n 以下なら、
移行前の和は n+1 以下である。多項式・根・重複度は本質でない。
-/
import Mathlib.Data.Finset.Sum
import Mathlib.Tactic

namespace Ising2DLambda.NecSuf.ThermodynamicLimit

theorem finset_sum_le_succ_of_distinguished_necSuf {α : Type*} [DecidableEq α]
    (s : Finset α) (w : α) (hw : w ∈ s) (before after : α → ℕ) (n : ℕ)
    (hdist : before w ≤ after w + 1)
    (hother : ∀ x ∈ s.erase w, before x ≤ after x)
    (hsum : ∑ x ∈ s, after x ≤ n) :
    ∑ x ∈ s, before x ≤ n + 1 := by
  have herase : ∑ x ∈ s.erase w, before x ≤ ∑ x ∈ s.erase w, after x := by
    exact Finset.sum_le_sum fun x hx => hother x hx
  have hbefore : ∑ x ∈ s, before x = before w + ∑ x ∈ s.erase w, before x := by
    rw [add_comm, Finset.sum_erase_add _ _ hw]
  have hafter : ∑ x ∈ s, after x = after w + ∑ x ∈ s.erase w, after x := by
    rw [add_comm, Finset.sum_erase_add _ _ hw]
  omega

end Ising2DLambda.NecSuf.ThermodynamicLimit
