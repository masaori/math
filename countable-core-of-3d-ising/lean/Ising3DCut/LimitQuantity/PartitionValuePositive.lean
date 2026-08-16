/-
「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の前半（可算側の段）。

第二歩（`PrimeExponentDataDeterminesRat`）を $Z_L(q)$ と $Z_L(q')$ に当てるには、両者が
正の有理数であることが要る。ここでは $L>0$・$q>0$ のとき $Z_L(q)>0$ を示す：
$Z_L(q)=\sum_m \Omega_L(m)\,q^m$ の各項は非負で、$m=0$ の項は $\Omega_L(0)\ge 2$（二つの定数配位）。
-/
import Ising3DCut.CoarseGrainingValuesAgree
import Ising3DCut.NullModel.PartitionSupportEndpoints

namespace Ising3DCut.LimitQuantity

open NullModel

/-- `L > 0`, `q > 0` なら `Z_L(q) > 0`。 -/
theorem partitionPolynomial_evalAtRational_pos {L : ℕ} (hL : 0 < L) {q : ℚ} (hq : 0 < q) :
    0 < evalAtRational q (partitionPolynomial L) := by
  rw [partitionPolynomial, evalAtRational, map_sum]
  simp only [Polynomial.coe_eval₂RingHom, Polynomial.eval₂_monomial, eq_intCast]
  apply Finset.sum_pos'
  · intro m _
    exact mul_nonneg (by exact_mod_cast Nat.zero_le _) (pow_nonneg hq.le _)
  · refine ⟨0, Finset.mem_range.mpr (Nat.succ_pos _), ?_⟩
    have h2 : (2 : ℚ) ≤ (NullModel.multiplicity L 0 : ℤ) := by exact_mod_cast two_le_multiplicity_zero hL
    simp only [pow_zero, mul_one]
    linarith
