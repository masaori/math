/- 必要十分版を `Qbar` 係数・`σ = Fin n`・重み `w = sz_n`（指数の総和）へ特殊化する導出。住処: Qbar。 -/
import Ising2DLambda.FisherZero.ElementarySymmetricSubstitutionDegreeBound
import Ising2DLambda.NecSuf.FisherZero.ElementarySymmetricSubstitutionDegreeBound

namespace Ising2DLambda.FisherZero

open Ising2DLambda.AlgebraicEigenvalue
open MvPolynomial

/-- 具体版の全次数は必要十分版の `wDeg exponentTotal` と同じものである。 -/
theorem qbarTotalDegree_eq_wDeg {n : ℕ} (P : QbarMvPoly n) :
    qbarTotalDegree P = Ising2DLambda.NecSuf.FisherZero.wDeg exponentTotal P :=
  rfl

private theorem exponentTotal_zero_le {n : ℕ} : exponentTotal (0 : Fin n →₀ ℕ) ≤ 0 := by
  simp [exponentTotal]

private theorem exponentTotal_add_le {n : ℕ} :
    ∀ b c : Fin n →₀ ℕ, exponentTotal (b + c) ≤ exponentTotal b + exponentTotal c :=
  fun b c => (exponentTotal_add b c).le

/-- `claim_qbar_total_degree_constant` を必要十分版から得る。 -/
theorem qbarTotalDegree_C_from_necSuf {n : ℕ} (c : Qbar) :
    qbarTotalDegree (C c : QbarMvPoly n) = 0 :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_C_necSuf exponentTotal exponentTotal_zero_le c

/-- `claim_qbar_total_degree_finite_sum_bound` を必要十分版から得る。 -/
theorem qbarTotalDegree_sum_le_from_necSuf {n : ℕ} {ι : Type} (I : Finset ι)
    (P : ι → QbarMvPoly n) (m : ℕ) (hP : ∀ i ∈ I, qbarTotalDegree (P i) ≤ m) :
    qbarTotalDegree (∑ i ∈ I, P i) ≤ m :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_sum_le_necSuf exponentTotal I P m hP

/-- `claim_qbar_total_degree_product_bound` を必要十分版から得る。 -/
theorem qbarTotalDegree_mul_le_from_necSuf {n : ℕ} (A B : QbarMvPoly n) :
    qbarTotalDegree (A * B) ≤ qbarTotalDegree A + qbarTotalDegree B :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_mul_le_necSuf exponentTotal exponentTotal_add_le A B

/-- `claim_qbar_total_degree_finite_product_bound` を必要十分版から得る。 -/
theorem qbarTotalDegree_prod_le_from_necSuf {n : ℕ} {ι : Type} (I : Finset ι)
    (P : ι → QbarMvPoly n) :
    qbarTotalDegree (∏ i ∈ I, P i) ≤ ∑ i ∈ I, qbarTotalDegree (P i) :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_prod_le_necSuf exponentTotal exponentTotal_zero_le
    exponentTotal_add_le I P

/-- `claim_qbar_elementary_symmetric_total_degree_bound` を必要十分版から得る（`σ = Fin n`）。 -/
theorem qbarTotalDegree_elementarySymmetric_le_from_necSuf (n j : ℕ) :
    qbarTotalDegree (qbarElementarySymmetric n j) ≤ j :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_elementarySymmetric_le_necSuf exponentTotal
    exponentTotal_zero_le exponentTotal_add_le (fun k => qbarTotalDegree_X_le k) j

/-- `claim_elementary_symmetric_substitution_degree_bound` を必要十分版から得る
（`y = ee_n`、`d k = k + 1`。値の条件は基本対称式の導出で与える）。 -/
theorem qbarTotalDegree_elementarySymmetricSubst_le_from_necSuf {n : ℕ} (Q : QbarMvPoly n) :
    qbarTotalDegree (elementarySymmetricSubst n Q) ≤ qbarWeightedDegree Q :=
  Ising2DLambda.NecSuf.FisherZero.wDeg_aeval_le_necSuf exponentTotal exponentTotal_zero_le
    exponentTotal_add_le (elementarySymmetricValues n) (fun k => k.val + 1)
    (fun k => qbarTotalDegree_elementarySymmetric_le_from_necSuf n (k.val + 1)) Q

end Ising2DLambda.FisherZero
