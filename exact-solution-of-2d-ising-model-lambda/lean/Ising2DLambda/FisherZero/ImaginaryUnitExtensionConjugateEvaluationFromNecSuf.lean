/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
零元・単位元・和・符号反転・積の閉性は `Subfield` から、`cj(a + bω) = a - bω` は共役の well-defined 性
（`imaginaryUnitConj_apply`）から渡す。多項式の値を係数の有限和へ移す段は
`claim_qbar_evaluation_coefficient_sum`（`qbarPolyEvalCoefficientSum`）。 -/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionConjugateEvaluation
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionConjugateEvaluation

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_imaginary_unit_extension_conjugate_evaluation` を必要十分版から得る。 -/
theorem imaginaryUnitExtension_conjugate_evaluation_from_necSuf
    (F : Subfield Qbar) (C : Set Qbar) (hC : IsSubfieldPositiveCone F C)
    (omega : Qbar) (homega : omega * omega = -1) (g : QbarPoly)
    (hg : ∀ k : ℕ, g.coeff k ∈ imaginaryUnitLinearValues F omega)
    (z : Qbar) (hz : z ∈ imaginaryUnitLinearValues F omega) :
    qbarPolyEval z (imaginaryUnitConjPoly F omega g) ∈ imaginaryUnitLinearValues F omega ∧
      qbarPolyEval (imaginaryUnitConj F omega z) g
        = imaginaryUnitConj F omega (qbarPolyEval z (imaginaryUnitConjPoly F omega g)) := by
  set n := g.natDegree
  have hn : ∀ k : ℕ, n < k → g.coeff k = 0 := fun k hk => Polynomial.coeff_eq_zero_of_natDegree_lt hk
  have hn' : ∀ k : ℕ, n < k → (imaginaryUnitConjPoly F omega g).coeff k = 0 := by
    intro k hk
    rw [imaginaryUnitConjPoly_coeff F C hC omega homega, hn k hk,
      imaginaryUnitConj_zero F C hC omega homega]
  obtain ⟨hmem, heq⟩ :=
    Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_conjugate_evaluation_necSuf
      (F : Set Qbar) F.zero_mem F.one_mem (fun _ _ hx hy => F.add_mem hx hy)
      (fun _ hx => F.neg_mem hx) (fun _ _ hx hy => F.mul_mem hx hy) omega homega
      (imaginaryUnitConj F omega) (fun a b ha hb => imaginaryUnitConj_apply F C hC omega homega a b ha hb)
      (fun k => g.coeff k) (fun k => (imaginaryUnitConjPoly F omega g).coeff k) hg
      (fun k => imaginaryUnitConjPoly_coeff F C hC omega homega g k) z hz n
  rw [qbarPolyEvalCoefficientSum z _ n hn', qbarPolyEvalCoefficientSum _ g n hn]
  exact ⟨hmem, heq⟩

end Ising2DLambda.FisherZero
