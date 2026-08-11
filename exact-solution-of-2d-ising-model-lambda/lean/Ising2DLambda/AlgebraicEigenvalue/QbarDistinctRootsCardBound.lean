/-
章「固有値の代数性」の「零でない多項式の相異なる根は係数の上界を超えない」の具体版。
人手証明と同じく、根を一つ選んで明示的な商を作り、残りの根へ帰納法を当てる。
既製の多項式の根の個数定理には委ねない。

住処: Qbar。ここに ℝ / ℂ は現れない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientCoeffBound
import Ising2DLambda.AlgebraicEigenvalue.QbarFactorQuotientOtherRootZero

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarDistinctRootsCardLe (f : QbarPoly) (s : Finset Qbar) (n : ℕ)
    (hfne : f ≠ 0)
    (hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0)
    (hroot : ∀ w ∈ s, qbarPolyEval w f = 0) :
    s.card ≤ n := by
  classical
  induction n generalizing f s with
  | zero =>
      by_contra hcard
      have hs : s.Nonempty := Finset.card_pos.mp (by omega)
      obtain ⟨w, hw⟩ := hs
      let g : QbarPoly :=
        ∑ k ∈ Finset.range (0 + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k
      have hfactor : f = (Polynomial.X - qbarConst w) * g := by
        simpa [g] using qbarFactorTheorem f w 0 hcoeff (hroot w hw)
      have hgzero : g = 0 := by
        apply Polynomial.ext
        intro j
        simpa [g] using qbarFactorQuotientCoeffBound f w 0 j (Nat.zero_le j)
      apply hfne
      calc
        f = (Polynomial.X - qbarConst w) * g := hfactor
        _ = (Polynomial.X - qbarConst w) * 0 := by rw [hgzero]
        _ = 0 := mul_zero _
  | succ n ih =>
      by_cases hs : s.Nonempty
      · obtain ⟨w, hw⟩ := hs
        let g : QbarPoly :=
          ∑ k ∈ Finset.range (n + 1 + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k
        have hfactor : f = (Polynomial.X - qbarConst w) * g := by
          simpa [g, Nat.succ_eq_add_one] using
            qbarFactorTheorem f w (n + 1) hcoeff (hroot w hw)
        have hgne : g ≠ 0 := by
          intro hgzero
          apply hfne
          calc
            f = (Polynomial.X - qbarConst w) * g := hfactor
            _ = (Polynomial.X - qbarConst w) * 0 := by rw [hgzero]
            _ = 0 := mul_zero _
        have hcoeffg : ∀ j : ℕ, n < j → g.coeff j = 0 := by
          intro j hj
          simpa [g, Nat.succ_eq_add_one] using
            qbarFactorQuotientCoeffBound f w (n + 1) j (by omega)
        have hrootg : ∀ w' ∈ s.erase w, qbarPolyEval w' g = 0 := by
          intro w' hw'
          have hmem := Finset.mem_erase.mp hw'
          exact qbarFactorQuotientOtherRootZero f g w w' hfactor
            (hroot w' hmem.2) hmem.1
        have hcard := ih g (s.erase w) hgne hcoeffg hrootg
        rw [Finset.card_erase_of_mem hw] at hcard
        omega
      · simp only [Finset.not_nonempty_iff_eq_empty] at hs
        simp [hs]

end Ising2DLambda.AlgebraicEigenvalue
