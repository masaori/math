/-
`claim_complex_realization_twisted_modes_are_complex_roots`
（複素実現した横・縦モードは対応する複素方程式の根である）の具体版。

`Bool.false` と `Bool.true` は本文の 0 と 1 に対応し、(-1)^c は `if c then -1 else 1` と書く
（`KacWard/TwistedModeSets.lean` の規約）。

人手証明との対応:
  - 複素実現が冪を保つことの帰納法（零乗・単位元の保存・零乗の三行、冪の定義・乗法の保存・
    帰納法の仮定・冪の定義の四行）: `complexAlgebraicRealization_pow`。
  - (-1)^c = (-1)^c + 0ω の表示から ρ_C((-1)^c) = ρ_R((-1)^c) + iρ_R(0) = (-1)^c + i0 = (-1)^c:
    `complexAlgebraicRealization_signRat`。
  - ρ_C(ϖ)^L = ρ_C(ϖ^L) = ρ_C((-1)^a) = (-1)^a: `complexAlgebraicRealization_horizontalMode_pow`。
    縦の同じ三行: `complexAlgebraicRealization_verticalMode_pow`。
-/
import Ising2DLambda.RealEscape.ComplexRealizationPreservesMultiplication
import Ising2DLambda.KacWard.TwistedModeSets

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 人手証明の帰納法: ρ_C(z^n) = ρ_C(z)^n。 -/
theorem complexAlgebraicRealization_pow (data : RealClosedSubfieldData) (z : Qbar) :
    ∀ n : ℕ, complexAlgebraicRealization data (z ^ n) = complexAlgebraicRealization data z ^ n
  | 0 => by
    calc
      complexAlgebraicRealization data (z ^ 0) = complexAlgebraicRealization data 1 := by
        -- Q̄ の零乗
        rw [pow_zero]
      _ = 1 := complexAlgebraicRealization_one data  -- 単位元の保存
      _ = complexAlgebraicRealization data z ^ 0 := by
        -- ℂ の零乗
        rw [pow_zero]
  | n + 1 => by
    calc
      complexAlgebraicRealization data (z ^ (n + 1)) =
          complexAlgebraicRealization data (z ^ n * z) := by
        -- Q̄ の冪の定義
        rw [pow_succ]
      _ = complexAlgebraicRealization data (z ^ n) * complexAlgebraicRealization data z :=
        -- claim_complex_realization_preserves_multiplication
        complexAlgebraicRealization_preserves_multiplication data (z ^ n) z
      _ = complexAlgebraicRealization data z ^ n * complexAlgebraicRealization data z := by
        -- 帰納法の仮定
        rw [complexAlgebraicRealization_pow data z n]
      _ = complexAlgebraicRealization data z ^ (n + 1) := by
        -- ℂ の冪の定義
        rw [pow_succ]

/-- 人手証明の有理数の実現: ρ_C((-1)^c) = (-1)^c（c ∈ {0, 1}）。 -/
theorem complexAlgebraicRealization_signRat (data : RealClosedSubfieldData) (c : Bool) :
    complexAlgebraicRealization data (if c then -1 else 1) = (if c then -1 else 1 : ℂ) := by
  -- (-1)^c は有理数なので R に属し、(-1)^c = (-1)^c + 0ω は一意な係数表示である。
  have hrep : (if c then -1 else 1 : Qbar) =
      ((realClosedRat data (if c then -1 else 1) : data.carrier) : Qbar) +
        ((0 : data.carrier) : Qbar) * data.omega := by
    cases c <;> simp [realClosedRat]
  calc
    complexAlgebraicRealization data (if c then -1 else 1)
        = (realAlgebraicCutRealization data (realClosedRat data (if c then -1 else 1)) : ℂ) +
            Complex.I * (realAlgebraicCutRealization data 0 : ℂ) :=
      -- def_complex_algebraic_realization と (-1)^c = (-1)^c + 0ω
      complexAlgebraicRealization_eq data _ _ _ hrep
    _ = (((if c then -1 else 1 : ℚ) : ℝ) : ℂ) + Complex.I * ((0 : ℝ) : ℂ) := by
      -- claim_cut_realization_agrees_on_rationals（q = (-1)^c と q = 0）
      rw [cutRealization_agrees_on_rationals, cutRealization_zero]
    _ = (if c then -1 else 1 : ℂ) := by
      -- ℂ の零元
      cases c <;> simp

/-- 具体版（横）: ϖ ∈ U_a なら ρ_C(ϖ)^L = (-1)^a。 -/
theorem complexAlgebraicRealization_horizontalMode_pow (data : RealClosedSubfieldData)
    (L : ℕ) (s : SpinStructure) {w : Qbar} (hw : w ∈ horizontalTwistedModes L s) :
    complexAlgebraicRealization data w ^ L = (if s.1 then -1 else 1 : ℂ) := by
  calc
    complexAlgebraicRealization data w ^ L = complexAlgebraicRealization data (w ^ L) :=
      -- 上の帰納法
      (complexAlgebraicRealization_pow data w L).symm
    _ = complexAlgebraicRealization data (if s.1 then -1 else 1) := by
      -- def_horizontal_twisted_modes
      rw [show w ^ L = (if s.1 then -1 else 1 : Qbar) from hw]
    _ = (if s.1 then -1 else 1 : ℂ) :=
      -- a ∈ {0, 1} と上の有理数の実現
      complexAlgebraicRealization_signRat data s.1

/-- 具体版（縦）: ς ∈ W_b なら ρ_C(ς)^L = (-1)^b。 -/
theorem complexAlgebraicRealization_verticalMode_pow (data : RealClosedSubfieldData)
    (L : ℕ) (s : SpinStructure) {w : Qbar} (hw : w ∈ verticalTwistedModes L s) :
    complexAlgebraicRealization data w ^ L = (if s.2 then -1 else 1 : ℂ) := by
  calc
    complexAlgebraicRealization data w ^ L = complexAlgebraicRealization data (w ^ L) :=
      -- 上の帰納法
      (complexAlgebraicRealization_pow data w L).symm
    _ = complexAlgebraicRealization data (if s.2 then -1 else 1) := by
      -- def_vertical_twisted_modes
      rw [show w ^ L = (if s.2 then -1 else 1 : Qbar) from hw]
    _ = (if s.2 then -1 else 1 : ℂ) :=
      -- b ∈ {0, 1} と上の有理数の実現
      complexAlgebraicRealization_signRat data s.2

end Ising2DLambda.RealEscape
