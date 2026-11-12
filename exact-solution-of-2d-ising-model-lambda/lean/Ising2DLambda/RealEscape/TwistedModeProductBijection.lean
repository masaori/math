/-
`claim_twisted_mode_product_bijection`
（横・縦モードの複素実現は直積でも全単射である）の具体版。

人手証明との対応:
  - Θ_{L,a,b}(ϖ, ς) := (ρ_C(ϖ), ρ_C(ς)): `twistedModeProductRealization`。
  - 第一段落（値域）: 各成分が `claim_twisted_modes_complex_roots_bijection` により
    E_{L,a}・E_{L,b} に属する: `twistedModeProductRealization_mapsTo`。
  - 第二段落（単射）: ρ_C(ϖ) = pr_1(Θ(ϖ, ς)) = pr_1(Θ(ϖ', ς')) = ρ_C(ϖ') の三行と第二成分の三行、
    各成分の単射性、(ϖ, ς) = (ϖ', ς) = (ϖ', ς') の二行: `twistedModeProductRealization_injOn`。
  - 第三段落（全射）: 各成分の全射性で ϖ・ς を取り、Θ(ϖ, ς) = (ρ_C(ϖ), ρ_C(ς)) = (z, ρ_C(ς)) = (z, w)
    の三行: `twistedModeProductRealization_surjOn`。
  - 結論: `twistedModeProductRealization_bijOn`。
-/
import Ising2DLambda.RealEscape.TwistedModesComplexRootsBijection

namespace Ising2DLambda.RealEscape

open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 本文の Θ_{L,a,b}(ϖ, ς) := (ρ_C(ϖ), ρ_C(ς))。 -/
noncomputable def twistedModeProductRealization (data : RealClosedSubfieldData) :
    Qbar × Qbar → ℂ × ℂ :=
  fun p => (complexAlgebraicRealization data p.1, complexAlgebraicRealization data p.2)

/-- 第一段落: Θ は U_a × W_b を E_{L,a} × E_{L,b} へ送る。 -/
theorem twistedModeProductRealization_mapsTo (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.MapsTo (twistedModeProductRealization data)
      (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s)
      (complexRootSet L s.1 ×ˢ complexRootSet L s.2) := by
  rintro ⟨ϖ, ς⟩ ⟨hϖ, hς⟩
  -- claim_twisted_modes_complex_roots_bijection（各成分の値域）
  exact ⟨(complexAlgebraicRealization_horizontal_bijOn data L hL s).mapsTo hϖ,
    (complexAlgebraicRealization_vertical_bijOn data L hL s).mapsTo hς⟩

/-- 第二段落: Θ は U_a × W_b の上で単射。 -/
theorem twistedModeProductRealization_injOn (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.InjOn (twistedModeProductRealization data)
      (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s) := by
  rintro ⟨ϖ, ς⟩ ⟨hϖ, hς⟩ ⟨ϖ', ς'⟩ ⟨hϖ', hς'⟩ hΘ
  have h1 : complexAlgebraicRealization data ϖ = complexAlgebraicRealization data ϖ' :=
    calc
      complexAlgebraicRealization data ϖ
          = (twistedModeProductRealization data (ϖ, ς)).1 := rfl -- Θ の定義
      _ = (twistedModeProductRealization data (ϖ', ς')).1 := by rw [hΘ] -- 仮定
      _ = complexAlgebraicRealization data ϖ' := rfl -- Θ の定義
  have h2 : complexAlgebraicRealization data ς = complexAlgebraicRealization data ς' :=
    calc
      complexAlgebraicRealization data ς
          = (twistedModeProductRealization data (ϖ, ς)).2 := rfl -- Θ の定義
      _ = (twistedModeProductRealization data (ϖ', ς')).2 := by rw [hΘ] -- 仮定
      _ = complexAlgebraicRealization data ς' := rfl -- Θ の定義
  -- claim_twisted_modes_complex_roots_bijection（各成分の単射性）
  have hϖeq : ϖ = ϖ' := (complexAlgebraicRealization_horizontal_bijOn data L hL s).injOn hϖ hϖ' h1
  have hςeq : ς = ς' := (complexAlgebraicRealization_vertical_bijOn data L hL s).injOn hς hς' h2
  calc
    ((ϖ, ς) : Qbar × Qbar) = (ϖ', ς) := by rw [hϖeq] -- 第一成分の等号
    _ = (ϖ', ς') := by rw [hςeq] -- 第二成分の等号

/-- 第三段落: Θ は U_a × W_b から E_{L,a} × E_{L,b} への全射。 -/
theorem twistedModeProductRealization_surjOn (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.SurjOn (twistedModeProductRealization data)
      (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s)
      (complexRootSet L s.1 ×ˢ complexRootSet L s.2) := by
  rintro ⟨z, w⟩ ⟨hz, hw⟩
  -- claim_twisted_modes_complex_roots_bijection（横方向・縦方向の全射性）
  obtain ⟨ϖ, hϖ, hϖz⟩ := (complexAlgebraicRealization_horizontal_bijOn data L hL s).surjOn hz
  obtain ⟨ς, hς, hςw⟩ := (complexAlgebraicRealization_vertical_bijOn data L hL s).surjOn hw
  refine ⟨(ϖ, ς), ⟨hϖ, hς⟩, ?_⟩
  calc
    twistedModeProductRealization data (ϖ, ς)
        = (complexAlgebraicRealization data ϖ, complexAlgebraicRealization data ς) := rfl
      -- Θ の定義
    _ = (z, complexAlgebraicRealization data ς) := by rw [hϖz] -- ϖ の選択
    _ = (z, w) := by rw [hςw] -- ς の選択

/-- 具体版: Θ_{L,a,b} : U_a × W_b → E_{L,a} × E_{L,b} は全単射。 -/
theorem twistedModeProductRealization_bijOn (data : RealClosedSubfieldData)
    (L : ℕ) (hL : 0 < L) (s : SpinStructure) :
    Set.BijOn (twistedModeProductRealization data)
      (horizontalTwistedModes L s ×ˢ verticalTwistedModes L s)
      (complexRootSet L s.1 ×ˢ complexRootSet L s.2) :=
  ⟨twistedModeProductRealization_mapsTo data L hL s,
    twistedModeProductRealization_injOn data L hL s,
    twistedModeProductRealization_surjOn data L hL s⟩

end Ising2DLambda.RealEscape
