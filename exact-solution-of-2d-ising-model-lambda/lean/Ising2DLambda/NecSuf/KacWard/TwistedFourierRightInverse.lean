/- `claim_twisted_fourier_right_inverse` の必要十分版。
   必要なのは有限添字、二方向の座標核の直交性、終点・方向の単射性と可逆な規格化係数である。 -/
import Ising2DLambda.NecSuf.KacWard.DualTwistedFourierMatrix
import Ising2DLambda.NecSuf.KacWard.TwistedFourierMatrix
import Mathlib

namespace Ising2DLambda.NecSuf.KacWard

open BigOperators

theorem fourier_rightInverse_necSuf
    {E U V D X Y F : Type*} [Fintype E] [Fintype U] [Fintype V] [Fintype D]
    [DecidableEq E] [DecidableEq D] [DecidableEq X] [DecidableEq Y]
    [Field F] (κ : E ≃ U × V × D) (loc : E → X × Y) (dir : E → D)
    (hindex : Function.Injective (fun e => (loc e, dir e)))
    (A Abar : U → Y → F) (B Bbar : V → X → F)
    (ψ ψbar : (U × V × D) → E → F)
    (hψ : ∀ m e, ψ m e = if dir e = m.2.2 then A m.1 (loc e).2 * B m.2.1 (loc e).1 else 0)
    (hψbar : ∀ m e, ψbar m e = if dir e = m.2.2 then Abar m.1 (loc e).2 * Bbar m.2.1 (loc e).1 else 0)
    (cU cV : F) (hc : cU * cV ≠ 0)
    (hU : ∀ y y' : Y, (∑ u : U, A u y * Abar u y') = if y = y' then cU else 0)
    (hV : ∀ x x' : X, (∑ v : V, B v x * Bbar v x') = if x = x' then cV else 0) :
    fourierMatrix κ ψ * fourierInverseCandidate (cU * cV)⁻¹ κ ψbar = 1 := by
  classical
  have hinner (e f : E) :
      (∑ g : E, ψ (κ g) e * ψbar (κ g) f) =
        if e = f then cU * cV else 0 := by
    calc
      (∑ g : E, ψ (κ g) e * ψbar (κ g) f)
          = ∑ m : U × V × D, ψ m e * ψbar m f := by
              exact Fintype.sum_equiv κ _ _ (fun _ => rfl)
      _ = if e = f then cU * cV else 0 := by
        simp only [Fintype.sum_prod_type]
        by_cases hd : dir e = dir f
        · simp [hψ, hψbar, hd]
          have hfactor :
              (∑ u : U, ∑ v : V,
                A u (loc e).2 * B v (loc e).1 *
                  (Abar u (loc f).2 * Bbar v (loc f).1)) =
              (∑ u : U, A u (loc e).2 * Abar u (loc f).2) *
              (∑ v : V, B v (loc e).1 * Bbar v (loc f).1) := by
            rw [Finset.sum_mul_sum]
            apply Finset.sum_congr rfl
            intro u _
            apply Finset.sum_congr rfl
            intro v _
            ring
          rw [hfactor, hU, hV]
          by_cases hef : e = f
          · subst f
            simp
          · have hcoord : (loc e).2 ≠ (loc f).2 ∨ (loc e).1 ≠ (loc f).1 := by
              by_contra h
              push Not at h
              apply hef
              apply hindex
              apply Prod.ext
              · exact Prod.ext h.2 h.1
              · exact hd
            rcases hcoord with h | h <;> simp [hef, h]
        · simp [hψ, hψbar, hd]
          intro hef
          exact (hd (congrArg dir hef)).elim
  apply Matrix.ext
  intro e f
  rw [Matrix.one_apply]
  simp only [Matrix.mul_apply, fourierMatrix, fourierInverseCandidate,
    dualFourierMatrix, Matrix.smul_apply, smul_eq_mul]
  calc
    (∑ g : E, ψ (κ g) e * ((cU * cV)⁻¹ * ψbar (κ g) f))
        = (cU * cV)⁻¹ * (∑ g : E, ψ (κ g) e * ψbar (κ g) f) := by
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro g _
          ring
    _ = (cU * cV)⁻¹ * (if e = f then cU * cV else 0) := by rw [hinner]
    _ = if e = f then 1 else 0 := by
      by_cases hef : e = f
      · simp only [if_pos hef]
        exact inv_mul_cancel₀ hc
      · simp [hef]

end Ising2DLambda.NecSuf.KacWard
