import Ising2DLambda.AlgebraicEigenvalue.MatchingPairTermEquality
import Ising2DLambda.AlgebraicEigenvalue.MatchingPairBijection
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.MatchingPairEvenSum

namespace Ising2DLambda.AlgebraicEigenvalue

open Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
variable {J : Type*} [Fintype J] [LinearOrder J]

noncomputable instance evenOrbitPermutationFintype : Fintype (EvenOrbitPermutation J) := by
  classical
  unfold EvenOrbitPermutation
  infer_instance

theorem matchingPair_even_term
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A)
    (p : PerfectMatching J × PerfectMatching J) :
    Polynomial.C ((sign (fun x y : J => x < y)
      (perfectMatchingPairEvenOrbitEquiv p).val : ℤ) : Qbar) *
        (∏ i : J, A i ((perfectMatchingPairEvenOrbitEquiv p).val i)) =
      (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
        (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
    let τ := perfectMatchingToInvolution p.1
    let υ := perfectMatchingToInvolution p.2
    let w := (Finset.univ.filter (· ∈ matchingPairColor τ υ)).sort (· ≤ ·)
    have hw : w.Nodup := Finset.sort_nodup _ _
    have hcolor : ∀ i : J, i ∈ w ↔ i ∈ matchingPairColor τ υ := by
      intro i
      simp [w]
    have h := matchingPairTermEquality τ υ A hA w hw hcolor
    have he : (perfectMatchingPairEvenOrbitEquiv p).val = matchingPairPermutation τ υ := rfl
    rw [he]
    simpa only [τ, υ, matching_involution_left_inverse] using h

/-- 偶数軌道の置換和を、対応する順序付き完全マッチング対の和へ移す。 -/
theorem matchingPair_even_sum
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    (∑ s : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
        ∏ i : J, A i (s.val i)) =
      ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
  let e := perfectMatchingPairEvenOrbitEquiv (J := J)
  calc
    (∑ s : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
        ∏ i : J, A i (s.val i)) =
      ∑ p : PerfectMatching J × PerfectMatching J,
        Polynomial.C ((sign (fun x y : J => x < y) (e p).val : ℤ) : Qbar) *
          ∏ i : J, A i ((e p).val i) :=
        (Equiv.sum_comp e _).symm
    _ = ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
      apply Finset.sum_congr rfl
      intro p _
      exact matchingPair_even_term A hA p

theorem matchingPair_even_sum_from_necSuf
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    (∑ s : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
        ∏ i : J, A i (s.val i)) =
      ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := by
  exact NecSuf.AlgebraicEigenvalue.weightedSum_reindex_of_term_eq
    perfectMatchingPairEvenOrbitEquiv
    (fun s => Polynomial.C ((sign (fun x y : J => x < y) s.val : ℤ) : Qbar) *
      ∏ i : J, A i (s.val i))
    (fun p => (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
      (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2))
    (matchingPair_even_term A hA)

end Ising2DLambda.AlgebraicEigenvalue
