/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・実数側の第 1 段。
可算側の等式 $Z_L(q)^2/q^{\#E_L}=Z_L(1/q)^2/(1/q)^{\#E_L}$（$\mathbb Q$）を実数へ写し、
底が等しいので任意の実指数 $s$ に対して $s$ 乗（対称化した列の項 $\tilde a_L$ の形）も
項ごとに等しいことを述べる。**ここが ℝ への脱出**であり、以後は
`tendsto_iff_of_pointwise_eq`・`limit_eq_of_pointwise_eq` へ渡すだけである。
-/
import Ising3DCut.LimitQuantity.SymmetrizedValueReciprocalInvariantNullModel
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 零モデル：$L\ge1$、$q>0$、任意の実指数 $s$ に対し
$(Z_L(q)^2/q^{\#E_L})^s=(Z_L(1/q)^2/(1/q)^{\#E_L})^s$（$\mathbb R$ の等式）。 -/
theorem nullModel_symmetrized_real_term_reciprocal_invariant {L : ℕ} (hL : 0 < L) {q : ℚ}
    (hq : 0 < q) (s : ℝ) :
    ((((polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval q) ^ 2
        / q ^ (Fintype.card (NullModel.Edge L)) : ℚ) : ℝ) ^ s =
      ((((polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval (1 / q)) ^ 2
        / (1 / q) ^ (Fintype.card (NullModel.Edge L)) : ℚ) : ℝ) ^ s := by
  rw [nullModel_symmetrized_value_reciprocal_invariant hL hq]

end Ising3DCut.LimitQuantity
