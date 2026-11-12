import Ising2DLambda.RealEscape.DispersionAngleLogContinuous
import Ising2DLambda.NecSuf.RealEscape.DispersionAngleLogContinuous

namespace Ising2DLambda.RealEscape

open Ising2DLambda.ThermodynamicLimit
open Ising2DLambda.FisherZero

/-- 具体版の主張は、必要十分版を `A := ℚ`、`K := ℝ`、`X := ℝ × ℝ`、`j := ι_{ℚ→ℝ}`、
`cⱼ := cos ∘ (第 j 成分)`、`lg := Real.log` に特殊化して得られる。 -/
theorem dispersion_angle_log_continuous_from_necSuf (q : ℚ) (hq0 : 0 < q) (hq1 : q < 1) :
    (∀ θ₁ θ₂ : ℝ, 0 < dispersionAngleArgument q θ₁ θ₂) ∧
      Continuous (dispersionAngleLog q hq0 hq1) := by
  have h := Ising2DLambda.NecSuf.RealEscape.dispersion_angle_log_continuous_necSuf
    noRationalSquareTwo (Rat.castHom ℝ) (Rat.cast_injective) q
    (by simpa using (show (0 : ℝ) < q by exact_mod_cast hq0))
    (by simpa using (show (q : ℝ) < 1 by exact_mod_cast hq1))
    (fun θ : ℝ × ℝ => Real.cos θ.1) (fun θ : ℝ × ℝ => Real.cos θ.2)
    (Real.continuous_cos.comp continuous_fst) (Real.continuous_cos.comp continuous_snd)
    (fun θ => Real.cos_le_one θ.1) (fun θ => Real.cos_le_one θ.2)
    Real.log (Real.continuousOn_log.mono fun t ht => ne_of_gt ht)
  exact ⟨fun θ₁ θ₂ => h.2.2.1 (θ₁, θ₂), h.2.2.2⟩

end Ising2DLambda.RealEscape
