/-
人手証明の主張「和が部分体に入る二数は、二数を根とする二次式の値を零にする部分体の元があれば共に部分体に入る」
（ラベル `claim_sum_in_subfield_root_gives_both_numbers`）の具体版。

住処: Qbar。R / C は現れない。
-/
import Ising2DLambda.FisherZero.SubfieldCoefficientPolynomials
import Ising2DLambda.AlgebraicEigenvalue.QbarNoZeroDivisors

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_sum_in_subfield_root_gives_both_numbers` の具体版。
人手証明の段: 式鎖 `(γ-α)(γ-β) = γγ - γβ - αγ + αβ = γγ - (αγ+βγ) + αβ = γγ - (α+β)γ + αβ = 0`。
`γ-α = 0` なら `α = γ-(γ-α) = γ-0 = γ ∈ F`、`β = (α+β)-α ∈ F`。
`γ-α ≠ 0` なら `claim_qbar_no_zero_divisors`（`qbarNoZeroDivisors`）で `γ-β = 0`、
`β = γ-(γ-β) = γ-0 = γ ∈ F`、`α = (α+β)-β ∈ F`。 -/
theorem mem_and_mem_of_sum_mem_of_root_mem (F : Subfield Qbar) (α β γ : Qbar)
    (hsum : α + β ∈ F) (hγ : γ ∈ F)
    (hroot : γ * γ - (α + β) * γ + α * β = 0) :
    α ∈ F ∧ β ∈ F := by
  -- 式鎖
  have hprod : (γ - α) * (γ - β) = 0 := by
    calc (γ - α) * (γ - β) = γ * γ - γ * β - α * γ + α * β := by ring
      _ = γ * γ - (α * γ + β * γ) + α * β := by ring
      _ = γ * γ - (α + β) * γ + α * β := by ring
      _ = 0 := hroot
  by_cases hα : γ - α = 0
  · -- γ - α = 0 の場合
    have hαF : α ∈ F := by
      have hchain : α = γ := by
        calc α = γ - (γ - α) := by ring
          _ = γ - 0 := by rw [hα]
          _ = γ := sub_zero γ
      rw [hchain]; exact hγ
    have hchain : β = (α + β) - α := by ring
    refine ⟨hαF, ?_⟩
    rw [hchain]; exact F.sub_mem hsum hαF
  · -- γ - α ≠ 0 の場合: 零因子が無いので γ - β = 0
    have hβ : γ - β = 0 := qbarNoZeroDivisors hα hprod
    have hβF : β ∈ F := by
      have hchain : β = γ := by
        calc β = γ - (γ - β) := by ring
          _ = γ - 0 := by rw [hβ]
          _ = γ := sub_zero γ
      rw [hchain]; exact hγ
    have hchain : α = (α + β) - β := by ring
    refine ⟨?_, hβF⟩
    rw [hchain]; exact F.sub_mem hsum hβF

end Ising2DLambda.FisherZero
