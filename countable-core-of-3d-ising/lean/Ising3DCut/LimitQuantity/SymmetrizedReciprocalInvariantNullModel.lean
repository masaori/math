/-
「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 具体版：零モデルの $Z_L$ について完成。
人手証明（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`）との対応：
  回文性 $Z_L(q)=q^{\#E_L}Z_L(1/q)$ → 付値の乗法性 → $\Lambda$ の加法で整理、を束ねた
  `symmetrized_padicValRat_eval_reciprocal_invariant` に、
  `reflect_nullModel_poly_eq`（回文性）・`natDegree_polyOfMultiplicity_le`（次数）・
  `eval_polyOfMultiplicity_pos`（$Z_L(1/q)>0$。非負係数と $\Omega_L(0)\ge2$）を渡す。

住処: 有理数の付値と `ℚ[X]` の評価のみ。ℝ / ℂ は現れない。
-/
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantBundle
import Ising3DCut.LimitQuantity.SymmetrizedReciprocalInvariantSpecialized
import Ising3DCut.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.LimitQuantity

open Polynomial

/-- 重複度列から作った多項式は、$\Omega(0)\ge1$ なら正の有理点で正の値をとる
（各項が非負で $m=0$ の項が正）。 -/
theorem eval_polyOfMultiplicity_pos {E : ℕ} {Ω : ℕ → ℕ} (h0 : 1 ≤ Ω 0)
    {q : ℚ} (hq : 0 < q) : 0 < (polyOfMultiplicity E Ω).eval q := by
  unfold polyOfMultiplicity
  rw [eval_finsetSum]
  apply Finset.sum_pos'
  · intro m _
    simp only [eval_mul, eval_C, eval_pow, eval_X]
    exact mul_nonneg (Nat.cast_nonneg _) (pow_nonneg hq.le _)
  · refine ⟨0, Finset.mem_range.mpr (Nat.succ_pos E), ?_⟩
    simp only [eval_mul, eval_C, pow_zero, mul_one]
    exact_mod_cast h0

/-- 零モデル：$L\ge1$、$q>0$ のとき、各素数 $p$ で対称化した付値
$2\lambda_p(Z_L(q))-\#E_L\,\lambda_p(q)$ は $q$ と $1/q$ で一致する。 -/
theorem nullModel_symmetrized_padicValRat_reciprocal_invariant
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
  exact symmetrized_padicValRat_eval_reciprocal_invariant
    (reflect_nullModel_poly_eq L)
    (natDegree_polyOfMultiplicity_le _ _)
    hq.ne'
    (eval_polyOfMultiplicity_pos h0 hq').ne'

end Ising3DCut.LimitQuantity
