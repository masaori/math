/-
`claim_complex_realization_injective`（複素実現は単射である）の具体版。

人手証明との対応:
  - 一意表示 ξ = a + bω, η = c + dω を取る段: `data.unique_decomposition`。
  - ρ_R(a) + iρ_R(b) = ρ_C(ξ) = ρ_C(η) = ρ_R(c) + iρ_R(d) の式変形（定義、仮定、定義）:
    `complexAlgebraicRealization_injective` の `hC`。
  - ρ_R(a) = Re(ρ_R(a) + iρ_R(b)) = Re(ρ_R(c) + iρ_R(d)) = ρ_R(c) の式変形（実部の定義、上の等式、
    実部の定義）: `hre`。虚部の同じ式変形: `him`。
  - 実現写像の単射性（`claim_cut_realization_preserves_strict_order`）から a = c, b = d: `cutRealization_injective`。
  - ξ = a + bω = c + dω = η の式変形: 最後の `calc`。
-/
import Ising2DLambda.RealEscape.ComplexAlgebraicRealization
import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- 具体版: 複素実現 ρ_C : Q̄ → ℂ は単射である。 -/
theorem complexAlgebraicRealization_injective (data : RealClosedSubfieldData) :
    Function.Injective (complexAlgebraicRealization data) := by
  intro xi eta h
  obtain ⟨⟨a, b⟩, hxi, -⟩ := data.unique_decomposition xi
  obtain ⟨⟨c, d⟩, heta, -⟩ := data.unique_decomposition eta
  have hC : (realAlgebraicCutRealization data a : ℂ) +
        Complex.I * (realAlgebraicCutRealization data b : ℂ) =
      (realAlgebraicCutRealization data c : ℂ) +
        Complex.I * (realAlgebraicCutRealization data d : ℂ) := by
    calc
      (realAlgebraicCutRealization data a : ℂ) +
            Complex.I * (realAlgebraicCutRealization data b : ℂ)
          = complexAlgebraicRealization data xi :=
        -- 複素実現の定義
        (complexAlgebraicRealization_eq data xi a b hxi).symm
      _ = complexAlgebraicRealization data eta := h  -- 仮定
      _ = (realAlgebraicCutRealization data c : ℂ) +
            Complex.I * (realAlgebraicCutRealization data d : ℂ) :=
        -- 複素実現の定義
        complexAlgebraicRealization_eq data eta c d heta
  have hre : realAlgebraicCutRealization data a = realAlgebraicCutRealization data c := by
    calc
      realAlgebraicCutRealization data a
          = ((realAlgebraicCutRealization data a : ℂ) +
              Complex.I * (realAlgebraicCutRealization data b : ℂ)).re := by
        -- ℂ の実部の定義（ρ_R(a), ρ_R(b) は実数）
        simp
      _ = ((realAlgebraicCutRealization data c : ℂ) +
              Complex.I * (realAlgebraicCutRealization data d : ℂ)).re := by
        rw [hC]
      _ = realAlgebraicCutRealization data c := by
        -- ℂ の実部の定義
        simp
  have him : realAlgebraicCutRealization data b = realAlgebraicCutRealization data d := by
    calc
      realAlgebraicCutRealization data b
          = ((realAlgebraicCutRealization data a : ℂ) +
              Complex.I * (realAlgebraicCutRealization data b : ℂ)).im := by
        -- ℂ の虚部の定義（ρ_R(a), ρ_R(b) は実数）
        simp
      _ = ((realAlgebraicCutRealization data c : ℂ) +
              Complex.I * (realAlgebraicCutRealization data d : ℂ)).im := by
        rw [hC]
      _ = realAlgebraicCutRealization data d := by
        -- ℂ の虚部の定義
        simp
  -- claim_cut_realization_preserves_strict_order の単射性
  have hac : a = c := cutRealization_injective data hre
  have hbd : b = d := cutRealization_injective data him
  calc
    xi = (a : Qbar) + (b : Qbar) * data.omega := hxi  -- ξ の係数表示
    _ = (c : Qbar) + (d : Qbar) * data.omega := by rw [hac, hbd]
    _ = eta := heta.symm  -- η の係数表示

end Ising2DLambda.RealEscape
