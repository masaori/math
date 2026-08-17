/-
具体版が必要十分版 `finset_sum_le_succ_of_distinguished_necSuf` の特殊化として得られることの導出。
多項式側の帰納法と一次因子の割り出しは具体版と同じで、有限和を比較する一歩だけを必要十分版へ渡す。
-/
import Ising2DLambda.ThermodynamicLimit.QbarFiniteRootMultiplicitySumLeCoeffBound
import Ising2DLambda.NecSuf.ThermodynamicLimit.QbarFiniteRootMultiplicitySumLeCoeffBound

namespace Ising2DLambda.ThermodynamicLimit

open Ising2DLambda.AlgebraicEigenvalue
open Polynomial

theorem qbarFiniteRootMultiplicitySumLeCoeffBound_from_necSuf
    (f : QbarPoly) (s : Finset Qbar) (n : ℕ) (hf : f ≠ 0)
    (hcoeff : ∀ i : ℕ, n < i → f.coeff i = 0) :
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
        exact Ising2DLambda.NecSuf.ThermodynamicLimit.finset_sum_le_succ_of_distinguished_necSuf
          s w hw (fun x => qbarRootMultiplicity x f hf)
          (fun x => qbarRootMultiplicity x g hg) n hdist hother hsumg

end Ising2DLambda.ThermodynamicLimit
