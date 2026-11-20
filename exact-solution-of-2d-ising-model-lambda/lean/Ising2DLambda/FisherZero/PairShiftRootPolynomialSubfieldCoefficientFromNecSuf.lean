/- 必要十分版を `Qbar` 係数・部分体 `F`・`ℕ_{<d}`・`ℕ_{<N}` へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.PairShiftRootPolynomialSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.PairShiftRootPolynomialSubfieldCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue

/-- `claim_qbar_multivariate_point_value_of_substitution` を必要十分版から得る（`K = Qbar`）。 -/
theorem qbarMvValue_qbarMvSubst_from_necSuf {n m : ℕ} (y : Fin n → QbarMvPoly m)
    (α : Fin m → Qbar) (P : QbarMvPoly n) :
    qbarMvValue α (qbarMvSubst y P) = qbarMvValue (fun r => qbarMvValue α (y r)) P :=
  Ising2DLambda.NecSuf.FisherZero.aeval_aeval_necSuf y α P

/-- `claim_subfield_coefficient_multivariate_point_value_mem` を必要十分版から得る（`S = F`）。 -/
theorem qbarMvValue_mem_subfield_from_necSuf (F : Subfield Qbar) {n : ℕ} {P : QbarMvPoly n}
    (hP : P ∈ subfieldCoefficientMvPolys F n) {α : Fin n → Qbar} (hα : ∀ k, α k ∈ F) :
    qbarMvValue α P ∈ F :=
  Ising2DLambda.NecSuf.FisherZero.aeval_mem_of_coeffIn_necSuf (S := (F : Set Qbar)) F.zero_mem
    F.one_mem (fun _ _ hx hy => F.add_mem hx hy) (fun _ _ hx hy => F.mul_mem hx hy) hP hα

/-- `claim_pair_shift_root_polynomial_subfield_coefficient` を必要十分版から得る
（`K = Qbar`、`S = F`、`σ = Fin d`）。 -/
theorem pairShiftRootPolynomial_mem_subfieldCoefficientPolynomials_from_necSuf
    (F : Subfield Qbar) {d N : ℕ} (α : ℕ → Qbar)
    (hf : (∏ i ∈ Finset.range d, (Polynomial.X - qbarConst (α i))) ∈
      subfieldCoefficientPolynomials F)
    {c : Qbar} (hc : c ∈ F) (π : Fin N ≃ RootIndexPair d) (β : ℕ → Qbar)
    (hβ : ∀ r : Fin N, β r = α (π r).1.1 + α (π r).1.2 + c * α (π r).1.1 * α (π r).1.2) :
    (∏ r ∈ Finset.range N, (Polynomial.X - qbarConst (β r))) ∈
      subfieldCoefficientPolynomials F :=
  Ising2DLambda.NecSuf.FisherZero.pairShiftRootPolynomial_coeff_mem_necSuf (S := (F : Set Qbar))
    F.zero_mem F.one_mem (F.neg_mem F.one_mem) (fun _ _ hx hy => F.add_mem hx hy)
    (fun _ _ hx hy => F.mul_mem hx hy) α hf hc π β hβ

end Ising2DLambda.FisherZero
