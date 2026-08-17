/-
章「熱力学極限」の「有限集合上の根の重複度の和は係数の上界を超えない」
（`claim_qbar_finite_root_multiplicity_sum_le_coeff_bound`）の具体版。
人手証明と同じく係数の上界について帰納し、正の重複度を持つ一点の一次因子を割り出す。

住処: Qbar（実数体・複素数体は現れない）。
-/
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityGeOneIffRoot
import Ising2DLambda.ThermodynamicLimit.QbarRootMultiplicityLeQuotientSucc
import Ising2DLambda.ThermodynamicLimit.QbarOtherRootMultiplicityLeQuotient
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

theorem qbarFiniteRootMultiplicitySumLeCoeffBound (f : QbarPoly) (s : Finset Qbar) (n : ℕ)
    (hf : f ≠ 0) (hcoeff : ∀ i : ℕ, n < i → f.coeff i = 0) :
    ∑ w ∈ s, qbarRootMultiplicity w f hf ≤ n := by
  classical
  induction n generalizing f with
  | zero =>
      have hzero : ∀ w ∈ s, qbarRootMultiplicity w f hf = 0 := by
        intro w hw
        have hle := qbarRootMultiplicity_le_of_coeff_bound w f hf 0 hcoeff
        omega
      calc
        ∑ w ∈ s, qbarRootMultiplicity w f hf = ∑ w ∈ s, 0 := by
          apply Finset.sum_congr rfl
          intro w hw
          rw [hzero w hw]
        _ = 0 := by simp
        _ ≤ 0 := le_rfl
  | succ n ih =>
      by_cases hall : ∀ w ∈ s, qbarRootMultiplicity w f hf = 0
      · calc
          ∑ w ∈ s, qbarRootMultiplicity w f hf = ∑ w ∈ s, 0 := by
            apply Finset.sum_congr rfl
            intro w hw
            rw [hall w hw]
          _ = 0 := by simp
          _ ≤ n + 1 := Nat.zero_le _
      · push Not at hall
        obtain ⟨w, hw, hwne⟩ := hall
        have hwpos : 1 ≤ qbarRootMultiplicity w f hf := Nat.one_le_iff_ne_zero.mpr hwne
        have hroot : qbarPolyEval w f = 0 :=
          (qbarRootMultiplicityGeOneIffRoot w f hf).mp hwpos
        let g : QbarPoly :=
          ∑ k ∈ Finset.range (n + 1 + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k
        have hfactor : f = (Polynomial.X - qbarConst w) * g := by
          simpa [g, Nat.succ_eq_add_one] using
            qbarFactorTheorem f w (n + 1) hcoeff hroot
        have hg : g ≠ 0 := by
          intro hgzero
          apply hf
          calc
            f = (Polynomial.X - qbarConst w) * g := hfactor
            _ = (Polynomial.X - qbarConst w) * 0 := by rw [hgzero]
            _ = 0 := mul_zero _
        have hcoeffg : ∀ i : ℕ, n < i → g.coeff i = 0 := by
          intro i hi
          simpa [g, Nat.succ_eq_add_one] using
            qbarFactorQuotientCoeffBound f w (n + 1) i (by omega)
        have hsumg : ∑ x ∈ s, qbarRootMultiplicity x g hg ≤ n := ih g hg hcoeffg
        have hdist : qbarRootMultiplicity w f hf ≤ qbarRootMultiplicity w g hg + 1 :=
          qbarRootMultiplicityLeQuotientSucc w f g hf hg hfactor
        have hother : ∀ x ∈ s.erase w,
            qbarRootMultiplicity x f hf ≤ qbarRootMultiplicity x g hg := by
          intro x hx
          have hxne : x ≠ w := (Finset.mem_erase.mp hx).1
          exact qbarOtherRootMultiplicityLeQuotient x w hxne f g hf hg hfactor
        have herase : ∑ x ∈ s.erase w, qbarRootMultiplicity x f hf ≤
            ∑ x ∈ s.erase w, qbarRootMultiplicity x g hg := by
          exact Finset.sum_le_sum fun x hx => hother x hx
        have hbefore : ∑ x ∈ s, qbarRootMultiplicity x f hf =
            qbarRootMultiplicity w f hf + ∑ x ∈ s.erase w, qbarRootMultiplicity x f hf := by
          rw [add_comm, Finset.sum_erase_add _ _ hw]
        have hafter : ∑ x ∈ s, qbarRootMultiplicity x g hg =
            qbarRootMultiplicity w g hg + ∑ x ∈ s.erase w, qbarRootMultiplicity x g hg := by
          rw [add_comm, Finset.sum_erase_add _ _ hw]
        omega

end Ising2DLambda.ThermodynamicLimit
