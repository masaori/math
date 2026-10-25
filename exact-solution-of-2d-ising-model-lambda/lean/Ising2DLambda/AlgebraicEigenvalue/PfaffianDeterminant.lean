import Ising2DLambda.AlgebraicEigenvalue.MatchingPairEvenSum
import Ising2DLambda.AlgebraicEigenvalue.OddOrbitSignedSumZero
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialDeterminantFixedPoints
import Ising2DLambda.AlgebraicEigenvalue.QbarPolynomialPfaffian
import Ising2DLambda.NecSuf.AlgebraicEigenvalue.PfaffianDeterminant
import Mathlib.Algebra.Ring.Parity

namespace Ising2DLambda.AlgebraicEigenvalue

open Classical
open Ising2DLambda.NecSuf.AlgebraicEigenvalue (sign)
variable {J : Type*} [Fintype J] [LinearOrder J]

private theorem orbitLength_one_of_fixed (σ : Equiv.Perm J) (i : J) (h : σ i = i) :
    finitePermutationOrbitLength σ i = 1 := by
  have hinv : σ.symm i = i := by
    apply σ.injective
    simpa using h.symm
  have horbit : finitePermutationOrbit σ i = {i} := by
    ext j
    constructor
    · rintro ⟨n, hn | hn⟩
      · simp only [finiteMapIterate, Function.iterate_fixed h n] at hn
        simp [hn.symm]
      · simp only [finiteMapIterate, Function.iterate_fixed hinv n] at hn
        simp [hn.symm]
    · intro hj
      have hji : j = i := Set.mem_singleton_iff.mp hj
      subst j
      exact ⟨0, Or.inl rfl⟩
  rw [finitePermutationOrbitLength, horbit, Set.ncard_singleton]

private theorem even_orbit_fixed_free (σ : Equiv.Perm J)
    (h : ∀ i, Even (finitePermutationOrbitLength σ i)) :
    ∀ i : J, σ i ≠ i := by
  intro i hi
  have hlength := orbitLength_one_of_fixed σ i hi
  have hEven := h i
  rw [hlength] at hEven
  norm_num at hEven

private theorem oddOrbit_iff_not_all_even (σ : Equiv.Perm J) :
    (oddOrbitPoints σ).Nonempty ↔ ¬ ∀ i, Even (finitePermutationOrbitLength σ i) := by
  constructor
  · rintro ⟨i, hi⟩ hall
    have hOdd : Odd (finitePermutationOrbitLength σ i) := by
      simpa only [oddOrbitPoints, Finset.mem_filter, Finset.mem_univ, true_and] using hi
    exact (Nat.not_even_iff_odd.mpr hOdd) (hall i)
  · intro h
    obtain ⟨i, hi⟩ := not_forall.mp h
    exact ⟨i, by simpa only [oddOrbitPoints, Finset.mem_filter,
      Finset.mem_univ, true_and] using (Nat.not_even_iff_odd.mp hi)⟩

private theorem derangement_partition (A : Matrix J J (Polynomial Qbar)) :
    (∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i)) =
    (∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) +
    (∑ σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J},
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) := by
  classical
  let w : Equiv.Perm J → Polynomial Qbar := fun σ =>
    Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) * ∏ i : J, A i (σ i)
  let p : Equiv.Perm J → Prop := fun σ => ∀ i, Even (finitePermutationOrbitLength σ i)
  have heven : (fixedPointFreePermutations J).filter p = Finset.univ.filter p := by
    ext σ
    simp only [Finset.mem_filter, Finset.mem_univ, true_and]
    constructor
    · exact And.right
    · intro hp
      exact ⟨by simpa only [fixedPointFreePermutations, Finset.mem_filter,
        Finset.mem_univ, true_and] using even_orbit_fixed_free σ hp, hp⟩
  have hodd : (fixedPointFreePermutations J).filter (fun σ => ¬ p σ) =
      Finset.univ.filter (fun σ => σ ∈ oddOrbitDerangements J) := by
    ext σ
    simp only [Finset.mem_filter, Finset.mem_univ, true_and,
      fixedPointFreePermutations, oddOrbitDerangements, Set.mem_setOf_eq]
    exact and_congr_right' (oddOrbit_iff_not_all_even σ).symm
  have hsplit := (Finset.sum_filter_add_sum_filter_not
    (fixedPointFreePermutations J) p w).symm
  calc
    (∑ σ ∈ fixedPointFreePermutations J, w σ) =
      (∑ σ ∈ (fixedPointFreePermutations J).filter p, w σ) +
      (∑ σ ∈ (fixedPointFreePermutations J).filter (fun σ => ¬ p σ), w σ) := hsplit
    _ = (∑ σ ∈ Finset.univ.filter p, w σ) +
      (∑ σ ∈ Finset.univ.filter (fun σ => σ ∈ oddOrbitDerangements J), w σ) := by
        rw [heven, hodd]
    _ = (∑ σ : EvenOrbitPermutation J, w σ.val) +
      (∑ σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J}, w σ.val) := by
        congr 1
        · have hu : (Finset.univ : Finset (EvenOrbitPermutation J)) =
              (Finset.univ : Finset (Equiv.Perm J)).subtype p := by
            apply Finset.ext
            intro σ
            simp [EvenOrbitPermutation, p]
            rfl
          have hs := (Finset.sum_subtype_eq_sum_filter
            (s := Finset.univ) (p := p) w).symm
          rw [← hu] at hs
          exact hs
        · simpa only [Finset.subtype_univ] using
            (Finset.sum_subtype_eq_sum_filter (s := Finset.univ)
              (p := fun σ => σ ∈ oddOrbitDerangements J) w).symm

/-- 不動点の消去、軌道の偶奇分割、奇数軌道の相殺、偶数軌道の再添字付けを順に使う。 -/
theorem qbarPolynomialPfaffian_sq_eq_det
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    qbarPolynomialPfaffian A ^ 2 = Matrix.det A := by
  classical
  have hpartition := derangement_partition A
  have hcancel := oddOrbit_signed_sum_zero A hA.2
  have heven := matchingPair_even_sum A hA
  have hpf := qbarPolynomialPfaffian_sq_eq_sum_matching_pairs A hA
  apply Eq.symm
  calc
    Matrix.det A = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := qbarPolynomial_det_eq_sum_fixedPointFree A hA.1
    _ = (∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) +
      (∑ σ : {σ : Equiv.Perm J // σ ∈ oddOrbitDerangements J},
        Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
          ∏ i : J, A i (σ.val i)) := hpartition
    _ = (∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i)) + 0 := congrArg (_ + ·) hcancel
    _ = ∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i) := add_zero _
    _ = ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := heven
    _ = qbarPolynomialPfaffian A ^ 2 := hpf.symm

/-- 必要十分版の有限和合成を、具体的な置換とマッチング対へ適用する。 -/
theorem qbarPolynomialPfaffian_sq_eq_det_from_necSuf
    (A : Matrix J J (Polynomial Qbar))
    (hA : IsZeroDiagonalSkewQbarPolynomialMatrix A) :
    qbarPolynomialPfaffian A ^ 2 = Matrix.det A := by
  classical
  have hpartition := derangement_partition A
  have hcancel := oddOrbit_signed_sum_zero A hA.2
  have hsplit := NecSuf.AlgebraicEigenvalue.sum_split_cancel
    _ _ _ hpartition hcancel
  apply Eq.symm
  calc
    Matrix.det A = ∑ σ ∈ fixedPointFreePermutations J,
      Polynomial.C ((sign (fun i j : J => i < j) σ : ℤ) : Qbar) *
        ∏ i : J, A i (σ i) := qbarPolynomial_det_eq_sum_fixedPointFree A hA.1
    _ = ∑ σ : EvenOrbitPermutation J,
      Polynomial.C ((sign (fun i j : J => i < j) σ.val : ℤ) : Qbar) *
        ∏ i : J, A i (σ.val i) := hsplit
    _ = ∑ p : PerfectMatching J × PerfectMatching J,
        (matchingSignPolynomial p.1 * matchingSignPolynomial p.2) *
          (matchingMatrixMonomial A p.1 * matchingMatrixMonomial A p.2) := matchingPair_even_sum A hA
    _ = qbarPolynomialPfaffian A ^ 2 :=
      (qbarPolynomialPfaffian_sq_eq_sum_matching_pairs A hA).symm

end Ising2DLambda.AlgebraicEigenvalue
