import Ising2DLambda.RealEscape.DispersionAngleRealization
import Ising2DLambda.NecSuf.RealEscape.DispersionAngleRealization

namespace Ising2DLambda.RealEscape

open Polynomial
open Ising2DLambda.FisherZero
open Ising2DLambda.AlgebraicEigenvalue
open Ising2DLambda.CriticalExponent
open Ising2DLambda.KacWard

/-- 具体版の主張は、必要十分版を `F := Qbar`、`S := R`、`ρR := ρ_{R→ℝ}`、`A := ℚ`、`K := ℝ`、`C := ℂ`、
`re := 実部`、`ρC := ρ_{Qbar→ℂ}`、`ex t := exp(it)`、`cs := cos`、`sn := sin`、`n := 2L` に特殊化して得られる。 -/
theorem dispersion_angle_realization_from_necSuf (data : RealClosedSubfieldData) (L : ℕ)
    (hL : 1 ≤ L) (s : SpinStructure) (varpi varsigma : Qbar)
    (hvarpi : varpi ∈ horizontalTwistedModes L s)
    (hvarsigma : varsigma ∈ verticalTwistedModes L s) (k l : ℕ)
    (hΘ : twistedModeProductRealization data (varpi, varsigma) =
      (complexRootCandidate L s.1 k, complexRootCandidate L s.2 l))
    (q : ℚ) (D : data.carrier)
    (hD : (D : Qbar) = (dispersionPolynomial varpi varsigma).eval (q : Qbar)) :
    realAlgebraicCutRealization data D =
      (1 + (q : ℝ) ^ 2) ^ 2 - 2 * (q : ℝ) * (1 - (q : ℝ) ^ 2) *
        (Real.cos (modeAngle L s.1 k) + Real.cos (modeAngle L s.2 l)) := by
  have hn : 0 < 2 * L := by omega
  have hvarpiRoot : varpi ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inl hvarpi)
  have hvarsigmaRoot : varsigma ∈ RootOfUnity (2 * L) :=
    twistedModes_subset_doubleRoots L s (Or.inr hvarsigma)
  obtain ⟨⟨α, β⟩, hαβ, _⟩ := data.unique_decomposition varpi
  obtain ⟨⟨γ, δ⟩, hγδ, _⟩ := data.unique_decomposition varsigma
  obtain ⟨_, hinv₁, hconj₁⟩ := rootOfUnity_inverse_realClosedConj data (2 * L) hn varpi hvarpiRoot α β hαβ
  obtain ⟨_, hinv₂, hconj₂⟩ :=
    rootOfUnity_inverse_realClosedConj data (2 * L) hn varsigma hvarsigmaRoot γ δ hγδ
  have hexp₁ : complexAlgebraicRealization data varpi =
      Complex.exp ((modeAngle L s.1 k : ℂ) * Complex.I) := by
    rw [← complexRootCandidate_eq_exp_modeAngle]
    exact congrArg Prod.fst hΘ
  have hexp₂ : complexAlgebraicRealization data varsigma =
      Complex.exp ((modeAngle L s.2 l : ℂ) * Complex.I) := by
    rw [← complexRootCandidate_eq_exp_modeAngle]
    exact congrArg Prod.snd hΘ
  -- 有理数の R への埋込み（`claim_rationals_are_real_algebraic`）
  let jS : ℚ →+* data.carrier.toSubring :=
    (Rat.castHom Qbar).codRestrict data.carrier.toSubring (rational_mem_realClosedCarrier data)
  have hjS : ∀ u : ℚ, ((jS u : data.carrier.toSubring) : Qbar) = (u : Qbar) := fun _ => rfl
  have h := Ising2DLambda.NecSuf.RealEscape.dispersion_angle_realization_necSuf
    (F := Qbar) (K := ℝ) (C := ℂ) data.carrier.toSubring data.omega
    (realAlgebraicCutRealization data)
    (cutRealization_preserves_addition data) (cutRealization_preserves_multiplication data)
    jS (Rat.castHom ℝ) (fun u => cutRealization_agrees_on_rationals data u)
    Complex.ofRealHom Complex.I Complex.re (fun x y => by simp)
    (complexAlgebraicRealization data) (fun a b => complexAlgebraicRealization_eq data _ a b rfl)
    (complexAlgebraicRealization_preserves_addition data)
    (complexAlgebraicRealization_preserves_multiplication data)
    (complexAlgebraicRealization_one data)
    (fun t => Complex.exp ((t : ℂ) * Complex.I))
    (fun s t => by push_cast; rw [add_mul, Complex.exp_add])
    (by simp)
    Real.cos Real.sin
    (fun t => by
      simp only [Complex.ofRealHom_eq_coe]
      rw [Complex.exp_mul_I, ← Complex.ofReal_cos, ← Complex.ofReal_sin, mul_comm])
    Real.cos_neg Real.sin_neg
    (2 * L) hn varpi varsigma hvarpiRoot hvarsigmaRoot α β γ δ
    hαβ (hinv₁.trans hconj₁) hγδ (hinv₂.trans hconj₂)
    (modeAngle L s.1 k) (modeAngle L s.2 l) hexp₁ hexp₂ q D
    (by
      rw [hD, hjS, dispersionPolynomial]
      simp only [eval_sub, eval_mul, eval_add, eval_pow, eval_X, eval_C, eval_one])
  simpa using h

end Ising2DLambda.RealEscape
