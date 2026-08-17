import Ising3DCut.NecSuf.SymmetrizedReciprocalInvariant
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantNullModel

/-!
必要十分版 `NecSuf.symmetrized_padicValRat_reciprocal_invariant_of_palindrome` から
零モデルの具体版を導き直す（具体版が過剰な構造を要求していないことの検査）。
渡すのは回文性・次数上界・`q ≠ 0`・`Z_L(1/q) ≠ 0` の四つだけである。
-/

namespace Ising3DCut.LimitQuantity

open Polynomial

theorem nullModel_symmetrized_padicValRat_reciprocal_invariant_fromNecSuf
    {p : ℕ} [Fact p.Prime] {L : ℕ} (hL : 0 < L) {q : ℚ} (hq : 0 < q) :
    2 * padicValRat p ((polyOfMultiplicity (Fintype.card (NullModel.Edge L))
          (NullModel.multiplicity L)).eval q)
        - (Fintype.card (NullModel.Edge L) : ℤ) * padicValRat p q =
      2 * padicValRat p ((polyOfMultiplicity (Fintype.card (NullModel.Edge L))
          (NullModel.multiplicity L)).eval (1 / q))
        - (Fintype.card (NullModel.Edge L) : ℤ) * padicValRat p q⁻¹ := by
  have h0 : 1 ≤ NullModel.multiplicity L 0 :=
    le_trans (by norm_num) (NullModel.two_le_multiplicity_zero hL)
  have hq' : (0 : ℚ) < 1 / q := one_div_pos.mpr hq
  exact NecSuf.symmetrized_padicValRat_reciprocal_invariant_of_palindrome
    (reflect_nullModel_poly_eq L)
    (natDegree_polyOfMultiplicity_le _ _)
    hq.ne'
    (eval_polyOfMultiplicity_pos h0 hq').ne'

end Ising3DCut.LimitQuantity
