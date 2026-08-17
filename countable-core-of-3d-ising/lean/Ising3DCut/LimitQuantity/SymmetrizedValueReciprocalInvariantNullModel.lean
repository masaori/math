/-
「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・可算側の段。
人手証明（`claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity`）の
「対称化した列 $\tilde S_q=\tilde S_{1/q}$ が一致する」から、対称化した項の土台
$Z_L(q)^2/q^{\#E_L}$ が $\mathbb Q$ の等式として $q$ と $1/q$ で一致することを導く。
根拠は素指数データが正の有理数を決めること（`rat_eq_of_prime_exponents_eq`）と
対称化した付値の $q\leftrightarrow1/q$ 不変性
（`nullModel_symmetrized_padicValRat_reciprocal_invariant`）だけである。

住処: 有理数のみ。ℝ / ℂ は現れない（実数列と箱の極限は次のファイルで扱う）。
-/
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantNullModel
import Ising3DCut.LimitQuantity.PrimeExponentDataDeterminesRat

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 零モデル：$L\ge1$、$q>0$ のとき $Z_L(q)^2/q^{\#E_L}=Z_L(1/q)^2/(1/q)^{\#E_L}$（$\mathbb Q$ の等式）。 -/
theorem nullModel_symmetrized_value_reciprocal_invariant {L : ℕ} (hL : 0 < L) {q : ℚ} (hq : 0 < q) :
    ((polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval q) ^ 2
        / q ^ (Fintype.card (NullModel.Edge L)) =
      ((polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval (1 / q)) ^ 2
        / (1 / q) ^ (Fintype.card (NullModel.Edge L)) := by
  have h0 : 1 ≤ NullModel.multiplicity L 0 :=
    le_trans (by norm_num) (NullModel.two_le_multiplicity_zero hL)
  have hq' : (0 : ℚ) < 1 / q := one_div_pos.mpr hq
  have hZ : 0 < (polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval q :=
    eval_polyOfMultiplicity_pos h0 hq
  have hZ' : 0 < (polyOfMultiplicity (Fintype.card (NullModel.Edge L)) (NullModel.multiplicity L)).eval (1 / q) :=
    eval_polyOfMultiplicity_pos h0 hq'
  apply rat_eq_of_prime_exponents_eq
  · exact div_pos (pow_pos hZ 2) (pow_pos hq _)
  · exact div_pos (pow_pos hZ' 2) (pow_pos hq' _)
  · intro p hp
    haveI : Fact p.Prime := ⟨hp⟩
    have key := nullModel_symmetrized_padicValRat_reciprocal_invariant (p := p) hL hq
    rw [padicValRat.div (pow_ne_zero _ hZ.ne') (pow_ne_zero _ hq.ne'),
      padicValRat.div (pow_ne_zero _ hZ'.ne') (pow_ne_zero _ hq'.ne'),
      padicValRat.pow _, padicValRat.pow _, padicValRat.pow _, padicValRat.pow _]
    rw [one_div] at *
    push_cast
    linarith [key]

end Ising3DCut.LimitQuantity
