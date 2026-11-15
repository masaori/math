import Ising2DLambda.RealEscape.OnsagerHyperbolicIntegralRewrite
import Ising2DLambda.NecSuf.RealEscape.OnsagerHyperbolicIntegralRewrite

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit

/-- 具体版の主張は、必要十分版を `K := ℝ`、`X := ℝ × ℝ`、`r := ι_{ℚ→ℝ}(q)`、`lg := log_ℝ`、
`E := exp`、`cⱼ := cos ∘ (第 j 成分)`、`I f := ∫₀^{2π}∫₀^{2π} f`、`Adm := 連続`、`area := 4π²`、
`n := 1/8π²` に特殊化して得られる。 -/
theorem onsager_hyperbolic_integral_rewrite_from_necSuf (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    paperCosh (2 * onsagerCoupling q hq0) = onsagerCoshValue q ∧
      paperSinh (2 * onsagerCoupling q hq0) = onsagerSinhValue q ∧
      (∀ θ₁ θ₂ : ℝ, 0 < onsagerHyperbolicArgument q θ₁ θ₂) ∧
      1 / (8 * Real.pi ^ 2) *
          (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
            dispersionAngleLog q hq0 hq1 (θ₁, θ₂)) =
        realLog ⟨2, two_pos⟩ + realLog (onsagerRadius q hq0) +
          1 / (8 * Real.pi ^ 2) *
            (∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi,
              onsagerHyperbolicLog q hq0 hq1 (θ₁, θ₂)) := by
  have hr0 : (0 : ℝ) < (q : ℝ) := by exact_mod_cast hq0
  have h := Ising2DLambda.NecSuf.RealEscape.onsager_hyperbolic_integral_rewrite_necSuf
    (K := ℝ) (X := ℝ × ℝ) (q : ℝ) hr0
    Real.log (fun u v hu hv => Real.log_mul (ne_of_gt hu) (ne_of_gt hv))
    Real.exp (fun u hu => Real.exp_log hu) Real.exp_neg
    (fun θ => Real.cos θ.1) (fun θ => Real.cos θ.2)
    (fun θ => (dispersionAngleArgument_pos q hq0 hq1 θ.1 θ.2).2.2)
    (fun f => ∫ θ₁ in (0 : ℝ)..2 * Real.pi, ∫ θ₂ in (0 : ℝ)..2 * Real.pi, f (θ₁, θ₂))
    Continuous (4 * Real.pi ^ 2) (1 / (8 * Real.pi ^ 2))
    (fun a g hg => iteratedIntegral_const_add a g hg)
    (onsagerHyperbolicLog_continuous q hq0 hq1)
    (by field_simp [Real.pi_ne_zero]; ring)
  obtain ⟨hc, hs, hH, hint⟩ := h
  exact ⟨hc, hs, fun θ₁ θ₂ => hH (θ₁, θ₂), hint⟩

end Ising2DLambda.RealEscape
