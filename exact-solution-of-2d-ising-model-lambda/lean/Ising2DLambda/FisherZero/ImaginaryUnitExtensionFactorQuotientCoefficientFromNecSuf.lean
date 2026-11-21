/- 必要十分版を Qbar の部分体へ特殊化する導出。住処: Qbar。
零元・単位元・和・符号反転・積の閉性は `Subfield` から渡す。必要十分版の `K_k(w)` が
具体版の `qbarPolyPowDiffSum` に一致することは、同じ約束の `k` の帰納法で示す。 -/
import Ising2DLambda.FisherZero.ImaginaryUnitExtensionFactorQuotientCoefficient
import Ising2DLambda.NecSuf.FisherZero.ImaginaryUnitExtensionFactorQuotientCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- 必要十分版の `K_k(w)` は具体版の `K_k(w)` に等しい。 -/
theorem powDiffSumOn_eq_qbarPolyPowDiffSum (w : Qbar) (k : ℕ) :
    Ising2DLambda.NecSuf.FisherZero.powDiffSumOn w k = qbarPolyPowDiffSum w k := by
  induction k with
  | zero => rfl
  | succ k ih =>
      rw [Ising2DLambda.NecSuf.FisherZero.powDiffSumOn, qbarPolyPowDiffSum, ih, qbarConst]

/-- `claim_imaginary_unit_extension_factor_quotient_coefficient` を必要十分版から得る。 -/
theorem imaginaryUnitExtension_factor_quotient_coefficient_from_necSuf
    (F : Subfield Qbar) (omega : Qbar) (homega : omega * omega = -1) (f : QbarPoly)
    (hf : ∀ k : ℕ, f.coeff k ∈ imaginaryUnitLinearValues F omega)
    (w : Qbar) (hw : w ∈ imaginaryUnitLinearValues F omega) (n : ℕ) (j : ℕ) :
    (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k).coeff j
      ∈ imaginaryUnitLinearValues F omega := by
  have h := Ising2DLambda.NecSuf.FisherZero.imaginaryUnitExtension_factor_quotient_coefficient_necSuf
    (F : Set Qbar) F.zero_mem F.one_mem (fun _ _ hx hy => F.add_mem hx hy)
    (fun _ hx => F.neg_mem hx) (fun _ _ hx hy => F.mul_mem hx hy) omega homega f hf w hw n j
  simp only [powDiffSumOn_eq_qbarPolyPowDiffSum] at h
  exact h

end Ising2DLambda.FisherZero
