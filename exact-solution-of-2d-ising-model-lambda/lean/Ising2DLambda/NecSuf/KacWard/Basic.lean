/- 必要十分版: 二元集合の固定点を持たない対合と、その直積の濃度だけを仮定する。 -/
import Mathlib.Data.Fintype.Prod

namespace Ising2DLambda.NecSuf.KacWard

def reverseBool (b : Bool) : Bool := !b

lemma reverseBool_involutive (b : Bool) : reverseBool (reverseBool b) = b := by
  cases b <;> rfl

lemma reverseBool_ne (b : Bool) : reverseBool b ≠ b := by
  cases b <;> decide

lemma card_bool_product : Fintype.card (Bool × Bool) = 4 := by
  rw [Fintype.card_prod, Fintype.card_bool]

end Ising2DLambda.NecSuf.KacWard
