/-
`claim_complex_realization_preserves_multiplication`（複素実現は乗法と単位元を保つ）の具体版。

人手証明との対応:
  - 一意表示 ξ = a + bω, η = c + dω を取る段: `data.unique_decomposition`。
  - ξη = (ac − bd) + (ad + bc)ω の式変形（Q̄ の分配法則、乗法の結合・交換法則、ω² = −1、
    加法の結合・交換法則、分配法則）: `complexAlgebraicRealization_product_decomposition`。
  - ρ_C(ξη) から ρ_C(ξ)ρ_C(η) までの式変形（定義、実現写像の加法保存、加法保存と有理数上の一致による
    ρ(−bd) = −ρ(bd)、乗法保存、ℂ の分配法則、加法の交換法則、i² = −1、乗法の結合・交換法則、
    分配法則、定義）: `complexAlgebraicRealization_preserves_multiplication`。
  - 1 = 1 + 0ω と ρ_C(1) = ρ(1) + iρ(0) = 1 + i0 = 1: `complexAlgebraicRealization_one`。
-/
import Ising2DLambda.RealEscape.ComplexAlgebraicRealization
import Ising2DLambda.RealEscape.CutRealizationPreservesMultiplication
import Ising2DLambda.RealEscape.CutRealizationPreservesStrictOrder

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue

/-- 人手証明の一つ目の式変形: (a + bω)(c + dω) = (ac − bd) + (ad + bc)ω。 -/
theorem complexAlgebraicRealization_product_decomposition (data : RealClosedSubfieldData)
    {xi eta : Qbar} {a b c d : data.carrier}
    (hxi : xi = (a : Qbar) + (b : Qbar) * data.omega)
    (heta : eta = (c : Qbar) + (d : Qbar) * data.omega) :
    xi * eta = ((a * c - b * d : data.carrier) : Qbar) +
      ((a * d + b * c : data.carrier) : Qbar) * data.omega := by
  calc
    xi * eta = ((a : Qbar) + (b : Qbar) * data.omega) * ((c : Qbar) + (d : Qbar) * data.omega) := by
      rw [hxi, heta]
    _ = (a : Qbar) * (c : Qbar) + (a : Qbar) * ((d : Qbar) * data.omega) +
          ((b : Qbar) * data.omega) * (c : Qbar) +
          ((b : Qbar) * data.omega) * ((d : Qbar) * data.omega) := by
      -- Q̄ の分配法則
      rw [add_mul, mul_add, mul_add, ← add_assoc]
    _ = (a : Qbar) * (c : Qbar) + ((a : Qbar) * (d : Qbar)) * data.omega +
          ((b : Qbar) * (c : Qbar)) * data.omega +
          ((b : Qbar) * (d : Qbar)) * (data.omega * data.omega) := by
      -- Q̄ の乗法の結合法則と交換法則
      ring
    _ = (a : Qbar) * (c : Qbar) + ((a : Qbar) * (d : Qbar)) * data.omega +
          ((b : Qbar) * (c : Qbar)) * data.omega - (b : Qbar) * (d : Qbar) := by
      -- def_real_closed_subfield の ω² = −1
      rw [data.omega_sq, mul_neg_one, ← sub_eq_add_neg]
    _ = ((a : Qbar) * (c : Qbar) - (b : Qbar) * (d : Qbar)) +
          (((a : Qbar) * (d : Qbar)) * data.omega + ((b : Qbar) * (c : Qbar)) * data.omega) := by
      -- Q̄ の加法の結合法則と交換法則
      abel
    _ = ((a : Qbar) * (c : Qbar) - (b : Qbar) * (d : Qbar)) +
          ((a : Qbar) * (d : Qbar) + (b : Qbar) * (c : Qbar)) * data.omega := by
      -- Q̄ の分配法則
      rw [add_mul]
    _ = ((a * c - b * d : data.carrier) : Qbar) +
          ((a * d + b * c : data.carrier) : Qbar) * data.omega := by
      -- 部分体の演算は Q̄ の演算の制限
      rw [Subfield.coe_sub, Subfield.coe_add, Subfield.coe_mul, Subfield.coe_mul,
        Subfield.coe_mul, Subfield.coe_mul]

/-- 具体版: ρ_C(ξη) = ρ_C(ξ)ρ_C(η)。 -/
theorem complexAlgebraicRealization_preserves_multiplication (data : RealClosedSubfieldData)
    (xi eta : Qbar) :
    complexAlgebraicRealization data (xi * eta) =
      complexAlgebraicRealization data xi * complexAlgebraicRealization data eta := by
  obtain ⟨⟨a, b⟩, hxi, -⟩ := data.unique_decomposition xi
  obtain ⟨⟨c, d⟩, heta, -⟩ := data.unique_decomposition eta
  have hprod := complexAlgebraicRealization_product_decomposition data hxi heta
  set ra := (realAlgebraicCutRealization data a : ℂ)
  set rb := (realAlgebraicCutRealization data b : ℂ)
  set rc := (realAlgebraicCutRealization data c : ℂ)
  set rd := (realAlgebraicCutRealization data d : ℂ)
  calc
    complexAlgebraicRealization data (xi * eta)
        = (realAlgebraicCutRealization data (a * c - b * d) : ℂ) +
            Complex.I * (realAlgebraicCutRealization data (a * d + b * c) : ℂ) :=
      -- 複素実現の定義（一意表示 hprod）
      complexAlgebraicRealization_eq data (xi * eta) (a * c - b * d) (a * d + b * c) hprod
    _ = ((realAlgebraicCutRealization data (a * c) + realAlgebraicCutRealization data (-(b * d)) : ℝ) : ℂ) +
          Complex.I * ((realAlgebraicCutRealization data (a * d) +
            realAlgebraicCutRealization data (b * c) : ℝ) : ℂ) := by
      -- claim_cut_realization_preserves_addition（ac − bd = ac + (−bd)）
      rw [sub_eq_add_neg, cutRealization_preserves_addition data (a * c) (-(b * d)),
        cutRealization_preserves_addition data (a * d) (b * c)]
    _ = ((realAlgebraicCutRealization data (a * c) - realAlgebraicCutRealization data (b * d) : ℝ) : ℂ) +
          Complex.I * ((realAlgebraicCutRealization data (a * d) +
            realAlgebraicCutRealization data (b * c) : ℝ) : ℂ) := by
      -- 加法保存と有理数上の一致による ρ(−bd) = −ρ(bd)
      rw [cutRealization_neg data (b * d), ← sub_eq_add_neg]
    _ = (ra * rc - rb * rd) + Complex.I * (ra * rd + rb * rc) := by
      -- claim_cut_realization_preserves_multiplication を四か所に適用
      rw [cutRealization_preserves_multiplication data a c,
        cutRealization_preserves_multiplication data b d,
        cutRealization_preserves_multiplication data a d,
        cutRealization_preserves_multiplication data b c]
      push_cast
      rfl
    _ = (ra * rc - rb * rd) + (Complex.I * (ra * rd) + Complex.I * (rb * rc)) := by
      -- ℂ の分配法則
      rw [mul_add]
    _ = ra * rc + Complex.I * (ra * rd) + Complex.I * (rb * rc) - rb * rd := by
      -- ℂ の加法の交換法則
      abel
    _ = ra * rc + Complex.I * (ra * rd) + Complex.I * (rb * rc) +
          Complex.I ^ 2 * (rb * rd) := by
      -- i² = −1
      rw [Complex.I_sq, neg_one_mul, ← sub_eq_add_neg]
    _ = ra * rc + ra * (Complex.I * rd) + (Complex.I * rb) * rc +
          (Complex.I * rb) * (Complex.I * rd) := by
      -- ℂ の乗法の結合法則と交換法則
      ring
    _ = (ra + Complex.I * rb) * (rc + Complex.I * rd) := by
      -- ℂ の分配法則
      rw [add_mul, mul_add, mul_add, ← add_assoc]
    _ = complexAlgebraicRealization data xi * complexAlgebraicRealization data eta := by
      -- 複素実現の定義
      rw [complexAlgebraicRealization_eq data xi a b hxi,
        complexAlgebraicRealization_eq data eta c d heta]

/-- 具体版: ρ_C(1) = 1。 -/
theorem complexAlgebraicRealization_one (data : RealClosedSubfieldData) :
    complexAlgebraicRealization data 1 = 1 := by
  -- 1 = 1 + 0ω は一意な係数表示
  have h1 : (1 : Qbar) = ((1 : data.carrier) : Qbar) + ((0 : data.carrier) : Qbar) * data.omega := by
    rw [Subfield.coe_one, Subfield.coe_zero, zero_mul, add_zero]
  calc
    complexAlgebraicRealization data 1
        = (realAlgebraicCutRealization data 1 : ℂ) +
            Complex.I * (realAlgebraicCutRealization data 0 : ℂ) :=
      -- 複素実現の定義
      complexAlgebraicRealization_eq data 1 1 0 h1
    _ = 1 + Complex.I * 0 := by
      -- claim_cut_realization_agrees_on_rationals（q = 1, q = 0）
      rw [cutRealization_one, cutRealization_zero, Complex.ofReal_one, Complex.ofReal_zero]
    _ = 1 := by
      -- ℂ の零元
      rw [mul_zero, add_zero]

end Ising2DLambda.RealEscape
