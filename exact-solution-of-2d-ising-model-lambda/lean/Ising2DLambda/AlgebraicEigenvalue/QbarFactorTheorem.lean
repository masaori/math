/-
章「固有値の代数性」の「根を持つ多項式は一次式を因子に持つ」の具体版。
人手証明の十段の鎖と同じ商を構成する。既製の因数定理には委ねない。
-/
import Ising2DLambda.AlgebraicEigenvalue.QbarPolyEvalCoefficientSum
import Ising2DLambda.AlgebraicEigenvalue.QbarConstEmbeddingPow

namespace Ising2DLambda.AlgebraicEigenvalue

open Polynomial

theorem qbarFactorTheorem (f : QbarPoly) (w : Qbar) (n : ℕ)
    (hcoeff : ∀ k : ℕ, n < k → f.coeff k = 0)
    (hroot : qbarPolyEval w f = 0) :
    ∃ g : QbarPoly, f = (Polynomial.X - qbarConst w) * g := by
  let g := ∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k
  refine ⟨g, ?_⟩
  have heval : (∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k) = 0 := by
    rw [← qbarPolyEvalCoefficientSum w f n hcoeff, hroot]
  calc
    f = ∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * Polynomial.X ^ k :=
      qbarPolyMonomialDecomposition f n hcoeff
    _ = (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * Polynomial.X ^ k)
          - qbarConst 0 := by rw [qbarConst]; simp
    _ = (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * Polynomial.X ^ k)
          - qbarConst (∑ k ∈ Finset.range (n + 1), f.coeff k * w ^ k) := by rw [heval]
    _ = (∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * Polynomial.X ^ k)
          - ∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k * w ^ k) := by
            simp only [qbarConst, map_sum]
    _ = ∑ k ∈ Finset.range (n + 1),
          (qbarConst (f.coeff k) * Polynomial.X ^ k - qbarConst (f.coeff k * w ^ k)) := by
            rw [Finset.sum_sub_distrib]
    _ = ∑ k ∈ Finset.range (n + 1),
          (qbarConst (f.coeff k) * Polynomial.X ^ k
            - qbarConst (f.coeff k) * qbarConst (w ^ k)) := by
            refine Finset.sum_congr rfl (fun k _ => ?_)
            rw [show qbarConst (f.coeff k * w ^ k)
                = qbarConst (f.coeff k) * qbarConst (w ^ k) by simp [qbarConst]]
    _ = ∑ k ∈ Finset.range (n + 1),
          (qbarConst (f.coeff k) * Polynomial.X ^ k
            - qbarConst (f.coeff k) * qbarConst w ^ k) := by
            refine Finset.sum_congr rfl (fun k _ => ?_)
            rw [qbarConstEmbeddingPow]
    _ = ∑ k ∈ Finset.range (n + 1),
          qbarConst (f.coeff k) * (Polynomial.X ^ k - qbarConst w ^ k) := by
            refine Finset.sum_congr rfl (fun k _ => ?_)
            ring
    _ = ∑ k ∈ Finset.range (n + 1),
          qbarConst (f.coeff k) * ((Polynomial.X - qbarConst w) * qbarPolyPowDiffSum w k) := by
            refine Finset.sum_congr rfl (fun k _ => ?_)
            rw [qbarPolyPowerDifferenceFactorization]
    _ = (Polynomial.X - qbarConst w)
          * ∑ k ∈ Finset.range (n + 1), qbarConst (f.coeff k) * qbarPolyPowDiffSum w k := by
            rw [Finset.mul_sum]
            refine Finset.sum_congr rfl (fun k _ => ?_)
            ring
    _ = (Polynomial.X - qbarConst w) * g := rfl

end Ising2DLambda.AlgebraicEigenvalue
