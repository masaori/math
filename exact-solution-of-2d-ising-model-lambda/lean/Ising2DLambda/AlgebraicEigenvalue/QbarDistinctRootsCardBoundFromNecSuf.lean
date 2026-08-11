/-
必要十分版を Qbar 係数多項式へ特殊化し、人手証明の具体版と同じ結論を導く。
-/
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.DistinctRootsCardBound
import Ising2DLambda.AlgebraicEigenvalue.QbarDistinctRootsCardBound

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarDistinctRootsCardLe_from_necSuf (f : QbarPoly) (s : Finset Qbar) (n : ℕ)
    (hfne : f ≠ 0)
    (hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0)
    (hroot : ∀ w ∈ s, qbarPolyEval w f = 0) :
    s.card ≤ n := by
  classical
  let Root : QbarPoly → Qbar → Prop := fun p w => qbarPolyEval w p = 0
  let Bound : ℕ → QbarPoly → Prop := fun m p => ∀ k : ℕ, m < k → p.coeff k = 0
  let quot : ℕ → QbarPoly → Qbar → QbarPoly := fun m p w =>
    ∑ k ∈ Finset.range (m + 1), qbarConst (p.coeff k) * qbarPolyPowDiffSum w k
  apply Ising2DLambda.NecSuf.AlgebraicEigenvalue.distinct_roots_card_le_necSuf
      (0 : QbarPoly) Root Bound quot
  · intro p hpbound hex
    obtain ⟨w, hw⟩ := hex
    have hfactor := qbarFactorTheorem p w 0 hpbound hw
    have hgzero : (∑ k ∈ Finset.range (0 + 1),
        qbarConst (p.coeff k) * qbarPolyPowDiffSum w k) = 0 := by
      apply Polynomial.ext
      intro j
      simpa using qbarFactorQuotientCoeffBound p w 0 j (Nat.zero_le j)
    calc
      p = (Polynomial.X - qbarConst w) *
          ∑ k ∈ Finset.range (0 + 1), qbarConst (p.coeff k) * qbarPolyPowDiffSum w k := hfactor
      _ = (Polynomial.X - qbarConst w) * 0 := by rw [hgzero]
      _ = 0 := mul_zero _
  · intro m p w hpne hpbound hw
    intro hq
    apply hpne
    have hfactor := qbarFactorTheorem p w m hpbound hw
    simpa [quot, hq] using hfactor
  · intro m p w hpbound hw
    intro j hj
    simpa [quot] using qbarFactorQuotientCoeffBound p w (m + 1) j (by omega)
  · intro m p w w' hpbound hw hw' hne
    apply qbarFactorQuotientOtherRootZero p (quot m p w) w w'
    · exact qbarFactorTheorem p w m hpbound hw
    · exact hw'
    · exact hne
  · exact hfne
  · exact hcoeff
  · exact hroot

end Ising2DLambda.AlgebraicEigenvalue
