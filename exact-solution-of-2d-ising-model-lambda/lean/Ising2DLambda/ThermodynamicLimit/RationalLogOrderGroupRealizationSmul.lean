/-
章「熱力学極限」の「実現写像は有理数倍と可換である（実数体への脱出: 実対数）」
（`claim_rational_log_order_group_realization_smul`）の具体版。

  人手証明（一続き六段）                                                       このファイル
  ρ_ℝ(r·μ) = Σ_{p∈supp(r·μ)} ι(（r·μ)(p)) log_ℝ(ι p)      （定義）             `realizeRational_eq_sum_support`
           = Σ_{p∈supp(μ)}   ι((r·μ)(p)) log_ℝ(ι p)      （supp(r·μ) ⊂ supp(μ)、
                                                          台を含む有限集合の和）  `Finsupp.support_smul`・`Finset.sum_subset`
           = Σ_{p∈supp(μ)}   ι(r·μ(p)) log_ℝ(ι p)        （r·μ の定義）          `Finsupp.smul_apply`・`smul_eq_mul`
           = Σ_{p∈supp(μ)}   ι(r)·ι(μ(p)) log_ℝ(ι p)     （ι は乗法を保つ）      `Rat.cast_mul`
           = Σ_{p∈supp(μ)}   ι(r)·(ι(μ(p)) log_ℝ(ι p))   （ℝ の乗法の結合則）    `mul_assoc`
           = ι(r) · Σ_{p∈supp(μ)} ι(μ(p)) log_ℝ(ι p)     （ℝ の分配則を有限和へ）`Finset.mul_sum`
           = ι(r) · ρ_ℝ(μ)                               （定義）               `realizeRational_eq_sum_support`

脱出したブロックなので、ℝ の環の性質（結合則・分配則）は mathlib のものをそのまま引く。
-/
import Ising2DLambda.ThermodynamicLimit.RationalLogOrderGroupRealization

namespace Ising2DLambda.ThermodynamicLimit

/-- `claim_rational_log_order_group_realization_smul`: `ρ_ℝ(r·μ) = ι_{ℚ→ℝ}(r)·ρ_ℝ(μ)`。 -/
theorem realizeRational_smul (r : ℚ) (μ : RationalLogOrderGroup) :
    realizeRational (r • μ) = (r : ℝ) * realizeRational μ := by
  calc
    realizeRational (r • μ)
        = (r • μ).support.sum fun p => (((r • μ) p : ℚ) : ℝ) * realLog (primePositiveReal p) :=
          realizeRational_eq_sum_support (r • μ)                       -- 定義
    _ = μ.support.sum fun p => (((r • μ) p : ℚ) : ℝ) * realLog (primePositiveReal p) := by
          -- supp(r·μ) ⊂ supp(μ)。台の外の項は (r·μ)(p) = 0 なので 0
          apply Finset.sum_subset (Finsupp.support_smul)
          intro p _ hp
          rw [Finsupp.notMem_support_iff.mp hp]
          simp
    _ = μ.support.sum fun p => ((r * μ p : ℚ) : ℝ) * realLog (primePositiveReal p) := by
          -- r·μ の定義: (r·μ)(p) = r μ(p)
          apply Finset.sum_congr rfl
          intro p _
          rw [Finsupp.smul_apply, smul_eq_mul]
    _ = μ.support.sum fun p => ((r : ℝ) * ((μ p : ℚ) : ℝ)) * realLog (primePositiveReal p) := by
          -- ι_{ℚ→ℝ} は乗法を保つ
          apply Finset.sum_congr rfl
          intro p _
          rw [Rat.cast_mul]
    _ = μ.support.sum fun p => (r : ℝ) * (((μ p : ℚ) : ℝ) * realLog (primePositiveReal p)) := by
          -- ℝ の乗法の結合則
          apply Finset.sum_congr rfl
          intro p _
          rw [mul_assoc]
    _ = (r : ℝ) * μ.support.sum fun p => ((μ p : ℚ) : ℝ) * realLog (primePositiveReal p) :=
          (Finset.mul_sum _ _ _).symm                                   -- ℝ の分配則を有限和へ
    _ = (r : ℝ) * realizeRational μ := by
          rw [realizeRational_eq_sum_support]                           -- 定義

end Ising2DLambda.ThermodynamicLimit
