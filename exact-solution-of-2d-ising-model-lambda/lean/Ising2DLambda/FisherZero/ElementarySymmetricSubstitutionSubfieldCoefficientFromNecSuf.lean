/- 必要十分版を `Qbar` の部分体 `F`（`S = F`、`R = Qbar`、`σ = Fin n`）へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionSubfieldCoefficient

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- 具体版の `F[X_{<n}]` は必要十分版の `coeffIn F (Fin n)` と同じ集合である。 -/
theorem subfieldCoefficientMvPolys_eq_coeffIn (F : Subfield Qbar) (n : ℕ) :
    subfieldCoefficientMvPolys F n = Ising2DLambda.NecSuf.FisherZero.coeffIn (F : Set Qbar) (Fin n) :=
  rfl

private theorem subfield_add_mem (F : Subfield Qbar) :
    ∀ x y : Qbar, x ∈ (F : Set Qbar) → y ∈ (F : Set Qbar) → x + y ∈ (F : Set Qbar) :=
  fun _ _ hx hy => F.add_mem hx hy

private theorem subfield_mul_mem (F : Subfield Qbar) :
    ∀ x y : Qbar, x ∈ (F : Set Qbar) → y ∈ (F : Set Qbar) → x * y ∈ (F : Set Qbar) :=
  fun _ _ hx hy => F.mul_mem hx hy

/-- `claim_subfield_coefficient_multivariate_constant` を必要十分版から得る。 -/
theorem C_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ} {c : Qbar}
    (hc : c ∈ F) : (C c : QbarMvPoly n) ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.C_mem_coeffIn_necSuf F.zero_mem hc

/-- `claim_subfield_coefficient_multivariate_variable` を必要十分版から得る。 -/
theorem X_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ} (k : Fin n) :
    (X k : QbarMvPoly n) ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.X_mem_coeffIn_necSuf F.zero_mem F.one_mem k

/-- `claim_subfield_coefficient_multivariate_finite_sum` を必要十分版から得る。 -/
theorem sum_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ} {ι : Type}
    (I : Finset ι) (P : ι → QbarMvPoly n) (hP : ∀ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n) :
    ∑ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.sum_mem_coeffIn_necSuf F.zero_mem (subfield_add_mem F) I P hP

/-- `claim_subfield_coefficient_multivariate_finite_product` を必要十分版から得る。 -/
theorem prod_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar) {n : ℕ} {ι : Type}
    (I : Finset ι) (P : ι → QbarMvPoly n) (hP : ∀ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n) :
    ∏ i ∈ I, P i ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.prod_mem_coeffIn_necSuf F.zero_mem F.one_mem
    (subfield_add_mem F) (subfield_mul_mem F) I P hP

/-- `claim_qbar_elementary_symmetric_subfield_coefficient` を必要十分版から得る（`σ = Fin n`）。 -/
theorem elementarySymmetric_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar)
    (n j : ℕ) : qbarElementarySymmetric n j ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.elementarySymmetric_mem_coeffIn_necSuf F.zero_mem F.one_mem
    (subfield_add_mem F) (subfield_mul_mem F) j

/-- `claim_elementary_symmetric_substitution_subfield_coefficient` を必要十分版から得る
（`y = ee_n`。値の条件は基本対称式の導出で与える）。 -/
theorem elementarySymmetricSubst_mem_subfieldCoefficientMvPolys_from_necSuf (F : Subfield Qbar)
    {n : ℕ} (Q : QbarMvPoly n) (hQ : Q ∈ subfieldCoefficientMvPolys F n) :
    elementarySymmetricSubst n Q ∈ subfieldCoefficientMvPolys F n :=
  Ising2DLambda.NecSuf.FisherZero.aeval_mem_coeffIn_necSuf F.zero_mem F.one_mem
    (subfield_add_mem F) (subfield_mul_mem F) (elementarySymmetricValues n)
    (fun k => elementarySymmetric_mem_subfieldCoefficientMvPolys_from_necSuf F n (k.val + 1)) Q hQ

end Ising2DLambda.FisherZero
