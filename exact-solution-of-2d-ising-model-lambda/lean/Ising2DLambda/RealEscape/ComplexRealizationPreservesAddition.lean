/-
`claim_complex_realization_preserves_addition`（複素実現は加法を保つ）の具体版。

人手証明との対応:
  - 一意表示 ξ = a + bω, η = c + dω を取る段: `data.unique_decomposition`。
  - ξ + η = (a + c) + (b + d)ω の式変形（Q̄ の結合・交換法則、分配法則）:
    `complexAlgebraicRealization_sum_decomposition`。
  - ρ_C(ξ + η) から ρ_C(ξ) + ρ_C(η) までの式変形（定義、実現写像の加法保存
    `claim_cut_realization_preserves_addition`、ℂ の分配法則、ℂ の結合・交換法則、定義）:
    `complexAlgebraicRealization_preserves_addition`。
-/
import Ising2DLambda.RealEscape.ComplexAlgebraicRealization
import Ising2DLambda.RealEscape.CutRealizationPreservesAddition

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の一つ目の式変形: (a + bω) + (c + dω) = (a + c) + (b + d)ω。 -/
theorem complexAlgebraicRealization_sum_decomposition (data : RealClosedSubfieldData)
    {xi eta : Qbar} {a b c d : data.carrier}
    (hxi : xi = (a : Qbar) + (b : Qbar) * data.omega)
    (heta : eta = (c : Qbar) + (d : Qbar) * data.omega) :
    xi + eta = ((a + c : data.carrier) : Qbar) + ((b + d : data.carrier) : Qbar) * data.omega := by
  calc
    xi + eta = ((a : Qbar) + (b : Qbar) * data.omega) + ((c : Qbar) + (d : Qbar) * data.omega) := by
      rw [hxi, heta]
    _ = ((a : Qbar) + (c : Qbar)) + ((b : Qbar) * data.omega + (d : Qbar) * data.omega) := by
      -- Q̄ の加法の結合法則と交換法則
      abel
    _ = ((a : Qbar) + (c : Qbar)) + ((b : Qbar) + (d : Qbar)) * data.omega := by
      -- Q̄ の分配法則
      rw [add_mul]
    _ = ((a + c : data.carrier) : Qbar) + ((b + d : data.carrier) : Qbar) * data.omega := by
      -- 部分体の加法は Q̄ の加法の制限
      rw [Subfield.coe_add, Subfield.coe_add]

/-- 具体版: ρ_C(ξ + η) = ρ_C(ξ) + ρ_C(η)。 -/
theorem complexAlgebraicRealization_preserves_addition (data : RealClosedSubfieldData)
    (xi eta : Qbar) :
    complexAlgebraicRealization data (xi + eta) =
      complexAlgebraicRealization data xi + complexAlgebraicRealization data eta := by
  obtain ⟨⟨a, b⟩, hxi, -⟩ := data.unique_decomposition xi
  obtain ⟨⟨c, d⟩, heta, -⟩ := data.unique_decomposition eta
  have hsum := complexAlgebraicRealization_sum_decomposition data hxi heta
  calc
    complexAlgebraicRealization data (xi + eta)
        = (realAlgebraicCutRealization data (a + c) : ℂ) + Complex.I * (realAlgebraicCutRealization data (b + d) : ℂ) :=
      -- 複素実現の定義（一意表示 hsum）
      complexAlgebraicRealization_eq data (xi + eta) (a + c) (b + d) hsum
    _ = ((realAlgebraicCutRealization data a + realAlgebraicCutRealization data c : ℝ) : ℂ) + Complex.I * ((realAlgebraicCutRealization data b + realAlgebraicCutRealization data d : ℝ) : ℂ) := by
      -- claim_cut_realization_preserves_addition を二か所に適用
      rw [cutRealization_preserves_addition data a c, cutRealization_preserves_addition data b d]
    _ = ((realAlgebraicCutRealization data a : ℂ) + (realAlgebraicCutRealization data c : ℂ)) + (Complex.I * (realAlgebraicCutRealization data b : ℂ) + Complex.I * (realAlgebraicCutRealization data d : ℂ)) := by
      -- ℂ の分配法則（実数の和の像は像の和）
      rw [Complex.ofReal_add, Complex.ofReal_add, mul_add]
    _ = ((realAlgebraicCutRealization data a : ℂ) + Complex.I * (realAlgebraicCutRealization data b : ℂ)) + ((realAlgebraicCutRealization data c : ℂ) + Complex.I * (realAlgebraicCutRealization data d : ℂ)) := by
      -- ℂ の加法の結合法則と交換法則
      abel
    _ = complexAlgebraicRealization data xi + complexAlgebraicRealization data eta := by
      -- 複素実現の定義
      rw [complexAlgebraicRealization_eq data xi a b hxi,
        complexAlgebraicRealization_eq data eta c d heta]

end Ising2DLambda.RealEscape
